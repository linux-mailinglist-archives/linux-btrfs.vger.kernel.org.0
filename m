Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A375C2C3FCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKYMTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 07:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgKYMTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 07:19:37 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6210C206E5
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606306775;
        bh=7tX5kVbdtQWxW/gqvQpsaI7tBZlcMMawPcQJV9JQDj8=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VLipUE0o2XfDXmhRFT07CiZvpJITGWbvh9uwspgmRypuxMiInKZVIOrEX251wwW5f
         RD4FIjOGcN3hsUmLxpHAPz0cPIM/+Q3cfInQbW0rVq5vgurW96hielNNCN6Yw9cFUm
         qcIWIBA9lZMGUk5HJRXzp1ra90d1RosfbRKdkqMM=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: fix race that makes inode logging fallback to transaction commit
Date:   Wed, 25 Nov 2020 12:19:26 +0000
Message-Id: <cf5b353c08568cd134afd098f6dbf62b72f02ba7.1606305501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an inode and the previous transaction is still committing, we
have a time window where we can end up incorrectly think an inode has its
last_unlink_trans field with a value greater than the last transaction
committed, which results in the logging to fallback to a full transaction
commit, which is usually much more expensive than doing a log commit.

The race is described by the following steps:

1) We are at transaction 1000;

2) We modify an inode X (a directory) using transaction 1000 and set its
   last_unlink_trans field to 1000, because for example we removed one
   of its subdirectories;

3) We create a new inode Y with a dentry in inode X using transaction 1000,
   so its generation field is set to 1000;

4) The commit for transaction 1000 is started by task A;

5) The task committing transaction 1000 sets the transaction state to
   unblocked, writes the dirty extent buffers and the super blocks, then
   unlocks tree_log_mutex;

6) Some task starts a new transaction with a generation of 1001;

7) We do some modification to inode Y (using transaction 1001);

8) The transaction 1000 commit starts unpinning extents. At this point
   fs_info->last_trans_committed still has a value of 999;

9) Task B starts an fsync on inode Y, and gets a handle for transaction
   1001. When it gets to check_parent_dirs_for_sync() it does the checking
   of the ancestor dentries because the following check does not evaluate
   to true:

       if (S_ISREG(inode->vfs_inode.i_mode) &&
           inode->generation <= last_committed &&
           inode->last_unlink_trans <= last_committed)
               goto out;

   The generation value for inode Y is 1000 and last_committed, which has
   the value read from fs_info->last_trans_committed, has a value of 999,
   so that check evaluates to false and we proceed to check the ancestor
   inodes.

   Once we get to the first ancestor, inode X, we call
   btrfs_must_commit_transaction() on it, which evaluates to true:

   static bool btrfs_must_commit_transaction(...)
   {
       struct btrfs_fs_info *fs_info = inode->root->fs_info;
       bool ret = false;

       mutex_lock(&inode->log_mutex);
       if (inode->last_unlink_trans > fs_info->last_trans_committed) {
           /*
            * Make sure any commits to the log are forced to be full
            * commits.
            */
            btrfs_set_log_full_commit(trans);
            ret = true;
       }
    (...)

    because inode's X last_unlink_trans has a value of 1000 and
    fs_info->last_trans_committed still has a value of 999, it returns
    true to check_parent_dirs_for_sync(), making it return 1 which is
    propagated up to btrfs_sync_file(), causing it to fallback to a full
    transaction commit of transaction 1001.

    We should have not falled back to commit transaction 1001, since inode
    X had last_unlink_trans set to 1000 and the super blocks for
    transaction 1000 were already written. So while not resulting in a
    functional problem, it leads to a lot more work and higher latencies
    for a fsync since committing a transaction is usually more expensive
    than committing a log (if other filesystem changes happened under that
    transaction).

Similar problem happens when logging directories, for the same reason as
btrfs_must_commit_transaction() returns true on an inode with its
last_unlink_trans having the generation of the previous transaction and
that transaction is still committing, unpinning its freed extents.

So fix this by comparing last_unlink_trans with the id of the current
transaction instead of fs_info->last_trans_committed.

This case is often hit when running dbench for a long enough duration, as
it does lots of rename and rmdir operations (both update the field
last_unkink_trans of an inode) and fsyncs of files and directories.

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
 fs/btrfs/tree-log.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6313c50f5e33..592a50d9697f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5449,11 +5449,10 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 static bool btrfs_must_commit_transaction(struct btrfs_trans_handle *trans,
 					  struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	bool ret = false;
 
 	mutex_lock(&inode->log_mutex);
-	if (inode->last_unlink_trans > fs_info->last_trans_committed) {
+	if (inode->last_unlink_trans >= trans->transid) {
 		/*
 		 * Make sure any commits to the log are forced to be full
 		 * commits.
@@ -5475,8 +5474,7 @@ static bool btrfs_must_commit_transaction(struct btrfs_trans_handle *trans,
 static noinline int check_parent_dirs_for_sync(struct btrfs_trans_handle *trans,
 					       struct btrfs_inode *inode,
 					       struct dentry *parent,
-					       struct super_block *sb,
-					       u64 last_committed)
+					       struct super_block *sb)
 {
 	int ret = 0;
 	struct dentry *old_parent = NULL;
@@ -5488,8 +5486,8 @@ static noinline int check_parent_dirs_for_sync(struct btrfs_trans_handle *trans,
 	 * and other fun in this file.
 	 */
 	if (S_ISREG(inode->vfs_inode.i_mode) &&
-	    inode->generation <= last_committed &&
-	    inode->last_unlink_trans <= last_committed)
+	    inode->generation < trans->transid &&
+	    inode->last_unlink_trans < trans->transid)
 		goto out;
 
 	if (!S_ISDIR(inode->vfs_inode.i_mode)) {
@@ -6024,7 +6022,6 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct super_block *sb;
 	int ret = 0;
-	u64 last_committed = fs_info->last_trans_committed;
 	bool log_dentries = false;
 
 	sb = inode->vfs_inode.i_sb;
@@ -6049,8 +6046,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 		goto end_no_trans;
 	}
 
-	ret = check_parent_dirs_for_sync(trans, inode, parent, sb,
-			last_committed);
+	ret = check_parent_dirs_for_sync(trans, inode, parent, sb);
 	if (ret)
 		goto end_no_trans;
 
@@ -6080,8 +6076,8 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	 * and other fun in this file.
 	 */
 	if (S_ISREG(inode->vfs_inode.i_mode) &&
-	    inode->generation <= last_committed &&
-	    inode->last_unlink_trans <= last_committed) {
+	    inode->generation < trans->transid &&
+	    inode->last_unlink_trans < trans->transid) {
 		ret = 0;
 		goto end_trans;
 	}
@@ -6130,7 +6126,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	 * but the file inode does not have a matching BTRFS_INODE_REF_KEY item
 	 * and has a link count of 2.
 	 */
-	if (inode->last_unlink_trans > last_committed) {
+	if (inode->last_unlink_trans >= trans->transid) {
 		ret = btrfs_log_all_parents(trans, inode, ctx);
 		if (ret)
 			goto end_trans;
-- 
2.28.0

