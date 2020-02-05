Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5F153550
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBEQex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 11:34:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:44714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgBEQex (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 11:34:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10D4FACAC;
        Wed,  5 Feb 2020 16:34:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42F3DDA7E6; Wed,  5 Feb 2020 17:34:37 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: add wrapper for transaction abort predicate
Date:   Wed,  5 Feb 2020 17:34:34 +0100
Message-Id: <20200205163434.6367-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The status of aborted transaction can change between calls and it needs
to be accessed by READ_ONCE. Add a helper that also wraps the unlikely
hint.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c   |  2 +-
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/extent-tree.c   | 10 +++++-----
 fs/btrfs/super.c         |  2 +-
 fs/btrfs/transaction.c   | 25 +++++++++++++------------
 fs/btrfs/transaction.h   | 12 ++++++++++++
 6 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 404e050ce8ee..d422fc0eceee 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2345,7 +2345,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 		return 0;
 	}
 
-	if (trans->aborted)
+	if (TRANS_ABORTED(trans))
 		return 0;
 again:
 	inode = lookup_free_space_inode(block_group, path);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 9b23883a1086..ee70584ddc45 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1139,7 +1139,7 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	int ret = 0;
 	bool count = (nr > 0);
 
-	if (trans->aborted)
+	if (TRANS_ABORTED(trans))
 		return -EIO;
 
 	path = btrfs_alloc_path();
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0163fdd59f8f..4c80f5409fb3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1583,7 +1583,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	int err = 0;
 	int metadata = !extent_op->is_data;
 
-	if (trans->aborted)
+	if (TRANS_ABORTED(trans))
 		return 0;
 
 	if (metadata && !btrfs_fs_incompat(fs_info, SKINNY_METADATA))
@@ -1703,7 +1703,7 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 {
 	int ret = 0;
 
-	if (trans->aborted) {
+	if (TRANS_ABORTED(trans)) {
 		if (insert_reserved)
 			btrfs_pin_extent(trans->fs_info, node->bytenr,
 					 node->num_bytes, 1);
@@ -2191,7 +2191,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 	int run_all = count == (unsigned long)-1;
 
 	/* We'll clean this up in btrfs_cleanup_transaction */
-	if (trans->aborted)
+	if (TRANS_ABORTED(trans))
 		return 0;
 
 	if (test_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags))
@@ -2913,7 +2913,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	else
 		unpin = &fs_info->freed_extents[0];
 
-	while (!trans->aborted) {
+	while (!TRANS_ABORTED(trans)) {
 		struct extent_state *cached_state = NULL;
 
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
@@ -2950,7 +2950,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		u64 trimmed = 0;
 
 		ret = -EROFS;
-		if (!trans->aborted)
+		if (!TRANS_ABORTED(trans))
 			ret = btrfs_discard_extent(fs_info,
 						   block_group->start,
 						   block_group->length,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 580ba7db67e5..661ebbab5e89 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -244,7 +244,7 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
-	trans->aborted = errno;
+	WRITE_ONCE(trans->aborted, errno);
 	/* Nothing used. The other threads that have joined this
 	 * transaction may be able to continue. */
 	if (!trans->dirty && list_empty(&trans->new_bgs)) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 541d3dc262e9..c2fff16842ac 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -241,7 +241,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 
 	cur_trans = fs_info->running_transaction;
 	if (cur_trans) {
-		if (cur_trans->aborted) {
+		if (TRANS_ABORTED(cur_trans)) {
 			spin_unlock(&fs_info->trans_lock);
 			return cur_trans->aborted;
 		}
@@ -457,7 +457,7 @@ static inline int is_transaction_blocked(struct btrfs_transaction *trans)
 {
 	return (trans->state >= TRANS_STATE_COMMIT_START &&
 		trans->state < TRANS_STATE_UNBLOCKED &&
-		!trans->aborted);
+		!TRANS_ABORTED(trans));
 }
 
 /* wait for commit against the current transaction to become unblocked
@@ -476,7 +476,7 @@ static void wait_current_trans(struct btrfs_fs_info *fs_info)
 
 		wait_event(fs_info->transaction_wait,
 			   cur_trans->state >= TRANS_STATE_UNBLOCKED ||
-			   cur_trans->aborted);
+			   TRANS_ABORTED(cur_trans));
 		btrfs_put_transaction(cur_trans);
 	} else {
 		spin_unlock(&fs_info->trans_lock);
@@ -935,7 +935,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (throttle)
 		btrfs_run_delayed_iputs(info);
 
-	if (trans->aborted ||
+	if (TRANS_ABORTED(trans) ||
 	    test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
 		wake_up_process(info->transaction_kthread);
 		err = -EIO;
@@ -1792,7 +1792,8 @@ static void wait_current_trans_commit_start(struct btrfs_fs_info *fs_info,
 					    struct btrfs_transaction *trans)
 {
 	wait_event(fs_info->transaction_blocked_wait,
-		   trans->state >= TRANS_STATE_COMMIT_START || trans->aborted);
+		   trans->state >= TRANS_STATE_COMMIT_START ||
+		   TRANS_ABORTED(trans));
 }
 
 /*
@@ -1804,7 +1805,8 @@ static void wait_current_trans_commit_start_and_unblock(
 					struct btrfs_transaction *trans)
 {
 	wait_event(fs_info->transaction_wait,
-		   trans->state >= TRANS_STATE_UNBLOCKED || trans->aborted);
+		   trans->state >= TRANS_STATE_UNBLOCKED ||
+		   TRANS_ABORTED(trans));
 }
 
 /*
@@ -2024,7 +2026,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	trans->dirty = true;
 
 	/* Stop the commit early if ->aborted is set */
-	if (unlikely(READ_ONCE(cur_trans->aborted))) {
+	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
 		btrfs_end_transaction(trans);
 		return ret;
@@ -2098,7 +2100,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 		wait_for_commit(cur_trans);
 
-		if (unlikely(cur_trans->aborted))
+		if (TRANS_ABORTED(cur_trans))
 			ret = cur_trans->aborted;
 
 		btrfs_put_transaction(cur_trans);
@@ -2117,7 +2119,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->trans_lock);
 
 			wait_for_commit(prev_trans);
-			ret = prev_trans->aborted;
+			ret = READ_ONCE(prev_trans->aborted);
 
 			btrfs_put_transaction(prev_trans);
 			if (ret)
@@ -2171,8 +2173,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	wait_event(cur_trans->writer_wait,
 		   atomic_read(&cur_trans->num_writers) == 1);
 
-	/* ->aborted might be set after the previous check, so check it */
-	if (unlikely(READ_ONCE(cur_trans->aborted))) {
+	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
 		goto scrub_continue;
 	}
@@ -2290,7 +2291,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * The tasks which save the space cache and inode cache may also
 	 * update ->aborted, check it.
 	 */
-	if (unlikely(READ_ONCE(cur_trans->aborted))) {
+	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
 		mutex_unlock(&fs_info->tree_log_mutex);
 		mutex_unlock(&fs_info->reloc_mutex);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 49f7196368f5..453cea7c7a72 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -115,6 +115,10 @@ struct btrfs_trans_handle {
 	struct btrfs_block_rsv *orig_rsv;
 	refcount_t use_count;
 	unsigned int type;
+	/*
+	 * Error code of transaction abort, set outside of locks and must use
+	 * the READ_ONCE/WRITE_ONCE access
+	 */
 	short aborted;
 	bool adding_csums;
 	bool allocating_chunk;
@@ -126,6 +130,14 @@ struct btrfs_trans_handle {
 	struct list_head new_bgs;
 };
 
+/*
+ * The abort status can be changed between calls and is not protected by locks.
+ * This accepts btrfs_transaction and btrfs_trans_handle as types. Once it's
+ * set to a non-zero value it does not change, so the macro should be in checks
+ * but is not necessary for further reads of the value.
+ */
+#define TRANS_ABORTED(trans)		(unlikely(READ_ONCE((trans)->aborted)))
+
 struct btrfs_pending_snapshot {
 	struct dentry *dentry;
 	struct inode *dir;
-- 
2.24.0

