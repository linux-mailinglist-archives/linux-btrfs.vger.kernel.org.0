Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC92EED30
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 06:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbhAHFhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 00:37:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbhAHFhu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 00:37:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610084223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dWEafXwOtyb1+lXLYjEdbvXjEZ6AKzDxcV+Y9SXveqE=;
        b=ev6lmS4eLKwaig5hR1Bm+y1mntZB7dxEt+wPkFI/3CJNGMDMAHXV6wuLQ7lkp6mlOYPLbs
        sJz5mBT2DTKVDp9tT6eCpkZhb6jGt+g+x9dDFSKMui1nWE/KFn2VInPJHyAYyggYi7696m
        P6/Gpsp2EQfAr7KzHvEBu5XgwpPohCg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22630AD18
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jan 2021 05:37:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make btrfs_dirty_inode() to always reserve metadata space
Date:   Fri,  8 Jan 2021 13:36:59 +0800
Message-Id: <20210108053659.87728-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several qgroup flush related bugs fixed recently, all of them
are caused by the fact that we can trigger qgroup metadata space
reservation holding a transaction handle.

Thankfully the only situation to trigger above reservation is
btrfs_dirty_inode().

Currently btrfs_dirty_inode() will try join transactio first, then
update the inode.
If btrfs_update_inode() fails with -ENOSPC, then it retry to start
transaction to reserve metadata space.

This not only forces us to reserve metadata space with a transaction
handle hold, but can't handle other errors like -EDQUOT.

This patch will make btrfs_dirty_inode() to call
btrfs_start_transaction() directly without first try joining then
starting, so that in try_flush_qgroup() we won't hold a trans handle.

This will slow down btrfs_dirty_inode() but my fstests doesn't show too
much different for most test cases, thus it may be worthy to skip such
performance "optimization".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delayed-inode.c | 41 +++++++---------------------------------
 fs/btrfs/inode.c         | 11 +----------
 fs/btrfs/qgroup.c        | 34 +++++++++------------------------
 3 files changed, 17 insertions(+), 69 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 70c0340d839c..0f2454de0b2f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -617,42 +617,15 @@ static int btrfs_delayed_inode_reserve_metadata(
 	num_bytes = btrfs_calc_metadata_size(fs_info, 1);
 
 	/*
-	 * btrfs_dirty_inode will update the inode under btrfs_join_transaction
-	 * which doesn't reserve space for speed.  This is a problem since we
-	 * still need to reserve space for this update, so try to reserve the
-	 * space.
+	 * All of our caller should have metadata space reserved, either through
+	 * btrfs_start_transaction() or have reserved space then
+	 * btrfs_join_transaction(), or steal from delalloc_block_rsv.
 	 *
-	 * Now if src_rsv == delalloc_block_rsv we'll let it just steal since
-	 * we always reserve enough to update the inode item.
+	 * This ensure we have all of our metadata space reserved, without the
+	 * need to reserve qgroup metadata space with a transaction hold.
 	 */
-	if (!src_rsv || (!trans->bytes_reserved &&
-			 src_rsv->type != BTRFS_BLOCK_RSV_DELALLOC)) {
-		ret = btrfs_qgroup_reserve_meta_prealloc(root, num_bytes, true);
-		if (ret < 0)
-			return ret;
-		ret = btrfs_block_rsv_add(root, dst_rsv, num_bytes,
-					  BTRFS_RESERVE_NO_FLUSH);
-		/*
-		 * Since we're under a transaction reserve_metadata_bytes could
-		 * try to commit the transaction which will make it return
-		 * EAGAIN to make us stop the transaction we have, so return
-		 * ENOSPC instead so that btrfs_dirty_inode knows what to do.
-		 */
-		if (ret == -EAGAIN) {
-			ret = -ENOSPC;
-			btrfs_qgroup_free_meta_prealloc(root, num_bytes);
-		}
-		if (!ret) {
-			node->bytes_reserved = num_bytes;
-			trace_btrfs_space_reservation(fs_info,
-						      "delayed_inode",
-						      btrfs_ino(inode),
-						      num_bytes, 1);
-		} else {
-			btrfs_qgroup_free_meta_prealloc(root, fs_info->nodesize);
-		}
-		return ret;
-	}
+	ASSERT(src_rsv && (trans->bytes_reserved ||
+			   src_rsv->type == BTRFS_BLOCK_RSV_DELALLOC));
 
 	ret = btrfs_block_rsv_migrate(src_rsv, dst_rsv, num_bytes, true);
 	if (!ret) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9c2800fa80c6..da8e1c24ab22 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5911,20 +5911,11 @@ static int btrfs_dirty_inode(struct inode *inode)
 	if (test_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags))
 		return 0;
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (ret && ret == -ENOSPC) {
-		/* whoops, lets try again with the full transaction */
-		btrfs_end_transaction(trans);
-		trans = btrfs_start_transaction(root, 1);
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
-
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	}
 	btrfs_end_transaction(trans);
 	if (BTRFS_I(inode)->delayed_node)
 		btrfs_balance_delayed_items(fs_info);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 808370ada888..872a5fed9e1a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3535,37 +3535,24 @@ static int try_flush_qgroup(struct btrfs_root *root)
 {
 	struct btrfs_trans_handle *trans;
 	int ret;
-	bool can_commit = true;
 
 	/*
-	 * If current process holds a transaction, we shouldn't flush, as we
-	 * assume all space reservation happens before a transaction handle is
-	 * held.
+	 * We shouldn't hold any trans handle here. Or we can cause deadlock
+	 * when flushing.
 	 *
-	 * But there are cases like btrfs_delayed_item_reserve_metadata() where
-	 * we try to reserve space with one transction handle already held.
-	 * In that case we can't commit transaction, but at least try to end it
-	 * and hope the started data writes can free some space.
+	 * The if branch is for kernel without CONFIG_BTRFS_ASSERT configured.
 	 */
-	if (current->journal_info &&
-	    current->journal_info != BTRFS_SEND_TRANS_STUB)
-		can_commit = false;
+	ASSERT(current->journal_info == NULL ||
+	       current->journal_info == BTRFS_SEND_TRANS_STUB);
+	if (unlikely(current->journal_info &&
+		     current->journal_info != BTRFS_SEND_TRANS_STUB))
+		return 0;
 
 	/*
 	 * We don't want to run flush again and again, so if there is a running
 	 * one, we won't try to start a new flush, but exit directly.
 	 */
 	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
-		/*
-		 * We are already holding a transaction, thus we can block other
-		 * threads from flushing.  So exit right now. This increases
-		 * the chance of EDQUOT for heavy load and near limit cases.
-		 * But we can argue that if we're already near limit, EDQUOT is
-		 * unavoidable anyway.
-		 */
-		if (!can_commit)
-			return 0;
-
 		wait_event(root->qgroup_flush_wait,
 			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
 		return 0;
@@ -3582,10 +3569,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		goto out;
 	}
 
-	if (can_commit)
-		ret = btrfs_commit_transaction(trans);
-	else
-		ret = btrfs_end_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out:
 	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
 	wake_up(&root->qgroup_flush_wait);
-- 
2.29.2

