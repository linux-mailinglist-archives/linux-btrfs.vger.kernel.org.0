Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC82C3FCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgKYMTg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 07:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKYMTg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 07:19:36 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5D7206F7
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606306775;
        bh=rHOEdBiLWHRDt/0k09QjMJDLFW0fVyqbVxzAX5qlY44=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=KOYdCCM7I7K7Mrhbpiblq4zn/aC/tDuDFyGU/IqLEHv8BVbZAIGC+zrifhFLR+BLM
         3GKb6YMT9dGr0ZK4t71jaVYdm9De4Z0gkFD+2u1tvgSaQ0k2hfWtxEHGAGtwSFNws8
         ufp3Djamv8xhQB48UV2K1/IPBFUUxok2knQx1OhM=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: fix race that causes unnecessary logging of ancestor inodes
Date:   Wed, 25 Nov 2020 12:19:25 +0000
Message-Id: <dfb9ca75058a072735d6467872c77b65c9bb3c6b.1606305501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an inode and we are checking if we need to log ancestors that
are new, if the previous transaction is still committing we have a time
window where we can unncessarily log ancestor inodes that were created in
the previous transaction.

The race is described by the following steps:

1) We are at transaction 1000;

2) Directory inode X is created, its generation is set to 1000;

3) The commit for transaction 1000 is started by task A;

4) The task committing transaction 1000 sets the transaction state to
   unblocked, writes the dirty extent buffers and the super blocks, then
   unlocks tree_log_mutex;

5) Inode Y, a regular file, is created under directory inode X, this
   results in starting a new transaction with a generation of 1001;

6) The transaction 1000 commit is unpinning extents. At this point
   fs_info->last_trans_committed still has a value of 999;

7) Task B calls fsync on inode Y and gets a handle for transaction 1001;

8) Task B ends up at log_all_new_ancestors() and then because inode Y has
   only one hard link, ends up at log_new_ancestors_fast(). There it reads
   a value of 999 from fs_info->last_trans_committed, and sees that the
   parent inode X has a generation of 1000, so we end up logging inode X:

     if (inode->generation > fs_info->last_trans_committed) {
         ret = btrfs_log_inode(trans, root, inode,
                               LOG_INODE_EXISTS, ctx);
         (...)

   which is not necessary since it was created in the past transaction,
   with a generation of 1000, and that transaction has already committed
   its super blocks - it's still unpinning extents so it has not yet
   updated fs_info->last_trans_committed from 999 to 1000.

   So this just causes us to spend more time logging and allocating and
   writing more tree blocks for the log tree.

So fix this by comparing an inode's generation with the generation of the
transaction our transaction handle refers to - if the inode's generation
matches the generation of the current transaction than we know it is a
new inode we need to log, otherwise don't log it.

This case is often hit when running dbench for a long enough duration.

This patch belongs to a patch set that is comprised of the following
patches:

  btrfs: fix race causing unnecessary inode logging during link and rename
  btrfs: fix race that results in logging old extents during a fast fsync
  btrfs: fix race that causes unnecessary logging of ancestor inodes
  btrfs: fix race that makes inode logging fallback to transaction commit
  btrfs: fix race leading to unnecessary transaction commit when logging inode
  btrfs: do not block inode logging for so long during transaction commit

Performance results are mentioned in the change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 596d72d239e9..6313c50f5e33 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5835,7 +5835,6 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 
 	while (true) {
 		struct btrfs_fs_info *fs_info = root->fs_info;
-		const u64 last_committed = fs_info->last_trans_committed;
 		struct extent_buffer *leaf = path->nodes[0];
 		int slot = path->slots[0];
 		struct btrfs_key search_key;
@@ -5854,7 +5853,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (BTRFS_I(inode)->generation > last_committed)
+		if (BTRFS_I(inode)->generation >= trans->transid)
 			ret = btrfs_log_inode(trans, root, BTRFS_I(inode),
 					      LOG_INODE_EXISTS, ctx);
 		btrfs_add_delayed_iput(inode);
@@ -5895,7 +5894,6 @@ static int log_new_ancestors_fast(struct btrfs_trans_handle *trans,
 				  struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct dentry *old_parent = NULL;
 	struct super_block *sb = inode->vfs_inode.i_sb;
 	int ret = 0;
@@ -5909,7 +5907,7 @@ static int log_new_ancestors_fast(struct btrfs_trans_handle *trans,
 		if (root != inode->root)
 			break;
 
-		if (inode->generation > fs_info->last_trans_committed) {
+		if (inode->generation >= trans->transid) {
 			ret = btrfs_log_inode(trans, root, inode,
 					      LOG_INODE_EXISTS, ctx);
 			if (ret)
-- 
2.28.0

