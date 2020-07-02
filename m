Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2F212255
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGBLcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgGBLcG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 07:32:06 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D64B20723
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593689525;
        bh=IUyUT3IPv7spO8zkWL3aA4FXLwHFPTmbmjczLE0ZG0M=;
        h=From:To:Subject:Date:From;
        b=EG7ZfLY1DaGMzWuqEX4yiuQ2qyxAQgFdcXapafzGgzlAxB1V8W5DWDXvQiBkZv6po
         ZM3f6mF8pT4JMXPPgA8fcMtUCgShJqnp3gLPn3dCxP/bma1rGu3cGETMO6oTD4OVtS
         8E3YezxP3iXaO5hugmoBUVgjZFrdO3MKYgq1qUIs=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: only commit the delayed inode when doing a full fsync
Date:   Thu,  2 Jul 2020 12:31:59 +0100
Message-Id: <20200702113159.153135-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit 2c2c452b0cafdc ("Btrfs: fix fsync when extend references are added
to an inode") forced a commit of the delayed inode when logging an inode
in order to ensure we would end up logging the inode item during a full
fsync. By committing the delayed inode, we updated the inode item in the
fs/subvolume tree and then later when copying items from leafs modified in
the current transaction into the log tree (with copy_inode_items_to_log())
we ended up copying the inode item from the fs/subvolume tree into the log
tree. Logging an up to date version of the inode item is required to make
sure at log replay time we get the link count fixup triggered among other
things (replay xattr deletes, etc). The test case generic/040 from fstests
exercises the bug which that commit fixed.

However for a fast fsync we don't need to commit the delayed inode because
we always log an up to date version of the inode item based on the struct
btrfs_inode we have in-memory. We started doing this for fast fsyncs since
commit e4545de5b035c7 ("Btrfs: fix fsync data loss after append write").

So just stop committing the delayed inode if we are doing a fast fsync,
we are only wasting time and adding contention on fs/subvolume tree.

This patch is part of a series that has the following patches:

1/4 btrfs: only commit the delayed inode when doing a full fsync
2/4 btrfs: only commit delayed items at fsync if we are logging a directory
3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
4/4 btrfs: remove no longer needed use of log_writers for the log root tree

After the entire patchset applied I saw about 12% decrease on max latency
reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
ram, using kvm and using a raw NVMe device directly (no intermediary fs on
the host). The test was invoked like the following:

  mkfs.btrfs -f /dev/sdk
  mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
  dbench -D /mnt/sdk -t 300 8
  umount /mnt/dsk

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index df6d4e3e40b1..44bbf8919883 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5130,7 +5130,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key max_key;
 	struct btrfs_root *log = root->log_root;
 	int err = 0;
-	int ret;
+	int ret = 0;
 	bool fast_search = false;
 	u64 ino = btrfs_ino(inode);
 	struct extent_map_tree *em_tree = &inode->extent_tree;
@@ -5167,14 +5167,16 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	/*
 	 * Only run delayed items if we are a dir or a new file.
-	 * Otherwise commit the delayed inode only, which is needed in
-	 * order for the log replay code to mark inodes for link count
-	 * fixup (create temporary BTRFS_TREE_LOG_FIXUP_OBJECTID items).
+	 * Otherwise commit the delayed inode only if the full sync flag is set,
+	 * as we want to make sure an up to date version is in the subvolume
+	 * tree so copy_inode_items_to_log() / copy_items() can find it and copy
+	 * it to the log tree. For a non full sync, we always log the inode item
+	 * based on the in-memory struct btrfs_inode which is always up to date.
 	 */
 	if (S_ISDIR(inode->vfs_inode.i_mode) ||
 	    inode->generation > fs_info->last_trans_committed)
 		ret = btrfs_commit_inode_delayed_items(trans, inode);
-	else
+	else if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags))
 		ret = btrfs_commit_inode_delayed_inode(inode);
 
 	if (ret) {
-- 
2.26.2

