Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4444BE3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhKJKIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 05:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhKJKIL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 05:08:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA6ED61107
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636538724;
        bh=jVlLsMFT1XiyMP2pq5e4kSiYiBtKZWZqcrqo+dIiO24=;
        h=From:To:Subject:Date:From;
        b=gwtnhXSpNLZ/BlK3Zovch622qEZiyV2WRwiQnUeWlWBLBmjJgoKARuPrOlNRkFIn2
         EX3MN6PHK+Ol7H2pt+i2uDbmMnSx9eSjz+CPSmHQoIvSLJ7XnpLBi/fL4E/1/BM9CS
         Nnp8/iDoEi45xBOcYI3aDt4dRBCyvXqYDFKb6iRwLFj3U85+W3Mdyg5G7Fs2Ba0NyE
         GM5VlR/X5kvqPlP0LQeDYcR+XHHncwlLuQl2dQTD3+FY+qGpwBQvAFAXobSD0aDnS+
         EAfkVJA9lSYpzFVXrg0pTsl+dQdjjlFFqpsxNKI1zUdKU83w1sHzI1IjxU4HcmKFHc
         TuWBfX0pbsyqw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reduce the scope of the tree log mutex during transaction commit
Date:   Wed, 10 Nov 2021 10:05:21 +0000
Message-Id: <f9f76a38d5a908d438816a778a7d55764a6360f3.1636538581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the transaction commit path we are acquiring the tree log mutex too
early and we have a stale comment because:

1) It mentions a function named btrfs_commit_tree_roots(), which does not
   exists anymore, it was the old name of commit_cowonly_roots(), renamed
   a very long time ago by commit 5d4f98a28c7d33 ("Btrfs: Mixed back
   reference  (FORWARD ROLLING FORMAT CHANGE)"));

2) It mentions that we need to acquire the tree log mutex at that point
   to ensure we have no running log writers. That is not correct anymore,
   for many years at least, since we are guaranteed that we do not have
   any log writers at that point simply because we have set the state of
   the transaction to TRANS_STATE_COMMIT_DOING and have waited for all
   writers to complete - meaning no one can log until we change the state
   of the transaction to TRANS_STATE_UNBLOCKED. Any attempts to join the
   transaction or start a new one will block until we do that state
   transition;

3) The comment mentions a "trans mutex" which doesn't exists since 2011,
   commit a4abeea41adf ("Btrfs: kill trans_mutex") removed it;

4) The current use of the tree log mutex is to ensure proper serialization
   of super block writes - if someone started a new transaction and uses it
   for logging, it will wait for the previous transaction to write its
   super block before writing the super block when attempting to sync the
   log.

So acquire the tree log mutex only when it's absolutely needed, before
setting the transaction state to TRANS_STATE_UNBLOCKED, fix and move the
stale comment, add some assertions and new comments where appropriate.

Also, this has no effect on concurrency or performance, since the new
start of the critical section is still when the transaction is in the
state TRANS_STATE_COMMIT_DOING.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 76 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1c3a1189c0bd..eb1c916d4884 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -162,6 +162,12 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 	struct btrfs_root *root, *tmp;
 	struct btrfs_caching_control *caching_ctl, *next;
 
+	/*
+	 * At this point no one can be using this transaction to modify any tree
+	 * and no one can start another transaction to modify any tree either.
+	 */
+	ASSERT(cur_trans->state == TRANS_STATE_COMMIT_DOING);
+
 	down_write(&fs_info->commit_root_sem);
 	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
 				 dirty_list) {
@@ -1236,6 +1242,12 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	struct extent_buffer *eb;
 	int ret;
 
+	/*
+	 * At this point no one can be using this transaction to modify any tree
+	 * and no one can start another transaction to modify any tree either.
+	 */
+	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
+
 	eb = btrfs_lock_root_node(fs_info->tree_root);
 	ret = btrfs_cow_block(trans, fs_info->tree_root, eb, NULL,
 			      0, &eb, BTRFS_NESTING_COW);
@@ -1327,7 +1339,8 @@ void btrfs_add_dead_root(struct btrfs_root *root)
 }
 
 /*
- * update all the cowonly tree roots on disk
+ * Update each subvolume root and its relocation root, if it exists, in the tree
+ * of tree roots. Also free log roots if they exist.
  */
 static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 {
@@ -1336,6 +1349,12 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	int i;
 	int ret;
 
+	/*
+	 * At this point no one can be using this transaction to modify any tree
+	 * and no one can start another transaction to modify any tree either.
+	 */
+	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
+
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	while (1) {
 		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
@@ -1348,6 +1367,14 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			struct btrfs_root *root = gang[i];
 			int ret2;
 
+			/*
+			 * At this point we can neither have tasks logging inodes
+			 * from a root nor trying to commit a log tree.
+			 */
+			ASSERT(atomic_read(&root->log_writers) == 0);
+			ASSERT(atomic_read(&root->log_commit[0]) == 0);
+			ASSERT(atomic_read(&root->log_commit[1]) == 0);
+
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
@@ -1472,12 +1499,6 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	/*
-	 * We are going to commit transaction, see btrfs_commit_transaction()
-	 * comment for reason locking tree_log_mutex
-	 */
-	mutex_lock(&fs_info->tree_log_mutex);
-
 	ret = commit_fs_roots(trans);
 	if (ret)
 		goto out;
@@ -1513,8 +1534,6 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 			"Error while writing out transaction for qgroup");
 
 out:
-	mutex_unlock(&fs_info->tree_log_mutex);
-
 	/*
 	 * Force parent root to be updated, as we recorded it before so its
 	 * last_trans == cur_transid.
@@ -2246,24 +2265,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	WARN_ON(cur_trans != trans->transaction);
 
-	/* btrfs_commit_tree_roots is responsible for getting the
-	 * various roots consistent with each other.  Every pointer
-	 * in the tree of tree roots has to point to the most up to date
-	 * root for every subvolume and other tree.  So, we have to keep
-	 * the tree logging code from jumping in and changing any
-	 * of the trees.
-	 *
-	 * At this point in the commit, there can't be any tree-log
-	 * writers, but a little lower down we drop the trans mutex
-	 * and let new people in.  By holding the tree_log_mutex
-	 * from now until after the super is written, we avoid races
-	 * with the tree-log code.
-	 */
-	mutex_lock(&fs_info->tree_log_mutex);
-
 	ret = commit_fs_roots(trans);
 	if (ret)
-		goto unlock_tree_log;
+		goto unlock_reloc;
 
 	/*
 	 * Since the transaction is done, we can apply the pending changes
@@ -2282,11 +2286,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 */
 	ret = btrfs_qgroup_account_extents(trans);
 	if (ret < 0)
-		goto unlock_tree_log;
+		goto unlock_reloc;
 
 	ret = commit_cowonly_roots(trans);
 	if (ret)
-		goto unlock_tree_log;
+		goto unlock_reloc;
 
 	/*
 	 * The tasks which save the space cache and inode cache may also
@@ -2294,7 +2298,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 */
 	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
-		goto unlock_tree_log;
+		goto unlock_reloc;
 	}
 
 	cur_trans = fs_info->running_transaction;
@@ -2327,6 +2331,16 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	btrfs_trans_release_chunk_metadata(trans);
 
+	/*
+	 * Before changing the transaction state to TRANS_STATE_UNBLOCKED and
+	 * setting fs_info->running_transaction to NULL, lock tree_log_mutex to
+	 * make sure that before we commit our superblock, no other task can
+	 * start a new transaction and commit a log tree before we commit our
+	 * superblock. Anyone trying to commit a log tree locks this mutex before
+	 * writing its superblock.
+	 */
+	mutex_lock(&fs_info->tree_log_mutex);
+
 	spin_lock(&fs_info->trans_lock);
 	cur_trans->state = TRANS_STATE_UNBLOCKED;
 	fs_info->running_transaction = NULL;
@@ -2339,10 +2353,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Error while writing out transaction");
-		/*
-		 * reloc_mutex has been unlocked, tree_log_mutex is still held
-		 * but we can't jump to unlock_tree_log causing double unlock
-		 */
 		mutex_unlock(&fs_info->tree_log_mutex);
 		goto scrub_continue;
 	}
@@ -2404,8 +2414,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	return ret;
 
-unlock_tree_log:
-	mutex_unlock(&fs_info->tree_log_mutex);
 unlock_reloc:
 	mutex_unlock(&fs_info->reloc_mutex);
 scrub_continue:
-- 
2.33.0

