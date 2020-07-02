Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631BA212257
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGBLcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgGBLcW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 07:32:22 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86C520723
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593689542;
        bh=6UTDRstRr5N3gGF8TB9H63TGpA1ltvKvjI3r8E639PU=;
        h=From:To:Subject:Date:From;
        b=JPbwzBvxg/RuB/J6Y4zBMIwbuXjM0aETRJwHeKwu17tumyVHJ6aslSNFHd+5BvI9x
         AOiUZddI+j8u6v8LQo4SDCVq7xm4f+UuE9lJ1E9PfPm78l4ZA66O5SjzzecDz5pVJF
         hCID06umihBXdgMu5cJZyvxPB15CWX0YcyB2HotY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: only commit delayed items at fsync if we are logging a directory
Date:   Thu,  2 Jul 2020 12:32:20 +0100
Message-Id: <20200702113220.163855-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an inode we are committing its delayed items if either the
inode is a directory or if it is a new inode, created in the current
transaction.

We need to do it for directories, since new directory indexes are stored
as delayed items of the inode and when logging a directory we need to be
able to access all indexes from the fs/subvolume tree in order to figure
out which index ranges need to be logged.

However for new inodes that are not directories, we do not need to do it
because the only type of delayed item they can have is the inode item, and
we are guaranteed to always log an up to date version of the inode item:

*) for a full fsync we do it by committing the delayed inode and then
   copying the item from the fs/subvolume tree with
   copy_inode_items_to_log();

*) for a fast fsync we always log the inode item based on the contents of
   the in-memory struct btrfs_inode. We guarantee this is always done since
   commit e4545de5b035c7 ("Btrfs: fix fsync data loss after append write").

So stop running delayed items for a new inodes that are not directories,
since that forces committing the delayed inode into the fs/subvolume tree,
wasting time and adding contention to the tree when a full fsync is not
required. We will only do it in case a fast fsync is needed.

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
 fs/btrfs/tree-log.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 44bbf8919883..7c325451d47f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5123,7 +5123,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   const loff_t end,
 			   struct btrfs_log_ctx *ctx)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
 	struct btrfs_path *dst_path;
 	struct btrfs_key min_key;
@@ -5166,15 +5165,17 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	max_key.offset = (u64)-1;
 
 	/*
-	 * Only run delayed items if we are a dir or a new file.
+	 * Only run delayed items if we are a directory. We want to make sure
+	 * all directory indexes hit the fs/subvolume tree so we can find them
+	 * and figure out which index ranges have to be logged.
+	 *
 	 * Otherwise commit the delayed inode only if the full sync flag is set,
 	 * as we want to make sure an up to date version is in the subvolume
 	 * tree so copy_inode_items_to_log() / copy_items() can find it and copy
 	 * it to the log tree. For a non full sync, we always log the inode item
 	 * based on the in-memory struct btrfs_inode which is always up to date.
 	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode) ||
-	    inode->generation > fs_info->last_trans_committed)
+	if (S_ISDIR(inode->vfs_inode.i_mode))
 		ret = btrfs_commit_inode_delayed_items(trans, inode);
 	else if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags))
 		ret = btrfs_commit_inode_delayed_inode(inode);
-- 
2.26.2

