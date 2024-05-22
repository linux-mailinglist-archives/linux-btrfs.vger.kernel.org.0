Return-Path: <linux-btrfs+bounces-5209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFBC8CC352
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0001C2291E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA392E64B;
	Wed, 22 May 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8XnczfE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE712B9CD
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388607; cv=none; b=QoPSbS5sKVbJxupr1ir2LiBSBvqabwdXbIYWG5Fs6j6kXD9l9Bt+0gIt/EoYeXbrOv1GfwrNBNIqdUj1aw/d2ACJKijl/GpO7r0n7lj9E4Q0JWmf4EnLWEPaLaVSitJgMkEe6ELRjNmkmVvKXborUCY4qVBnb1bn/nhfprltaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388607; c=relaxed/simple;
	bh=KK9WWlJhko7qesf7cbOxOzwLJSIkpFPMFqjt1Zmh0iI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1Gw2Req64RPk1lDt4Uho/HP4qehFX/FBZaWVqKZhzOXf0qZtlNPi8f9bPeW3V+aFaRaEX4Kc9W1IwxL2V7M90VusBzgAzpoXVY7g0IzuQarKpl0kPgx6J7ZrBGjgguNTWdpYvOYcGKV9jUiuWbFuLv95V83zFytZltefcR8MRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8XnczfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA12C32782
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388605;
	bh=KK9WWlJhko7qesf7cbOxOzwLJSIkpFPMFqjt1Zmh0iI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l8XnczfE88lvSvO0SBNd3zvBgSAj2K+1QUAi/dEXE+PP80bxw8tH++59eCECptVY1
	 eAvoNgNNIrC+skVrzMq84EKx8nTts2L1/0u9V/fubjL5AJthIjr1PPWyamKbTQWZyY
	 5JkrZyWa8XNzzOjep7UNaPJigAEW0RIrQ2/bgw67d1VHjyqDD01GuCsyFW74y/AyOh
	 F+s0SaU6tJ7YzEtO8ZF4hExNGTqFW68cX0agHikCeUOO/4FziobpXHBG3rOMv9Q+TC
	 Fc1MA1qc6y/a8bfkYUPQ9IFuWqNsKckFsrdv9oTIkpXb27BpjtvS13KwfUIVhMsAVT
	 hIHz1aZBhQ06A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: add and use helper to commit the current transaction
Date: Wed, 22 May 2024 15:36:34 +0100
Message-Id: <d05dfbf23390384ea72dd5c053e319090a333081.1716386100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716386100.git.fdmanana@suse.com>
References: <cover.1716386100.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places that attach to the current transaction with
btrfs_attach_transaction_barrier() and then commit the transaction if
there is one. Add a helper and use it to deduplicate this pattern.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c     | 12 +-----------
 fs/btrfs/qgroup.c      | 33 +++++----------------------------
 fs/btrfs/scrub.c       | 10 +---------
 fs/btrfs/send.c        | 10 +---------
 fs/btrfs/space-info.c  |  9 +--------
 fs/btrfs/super.c       | 11 +----------
 fs/btrfs/transaction.c | 19 +++++++++++++++++++
 fs/btrfs/transaction.h |  1 +
 8 files changed, 30 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2f56f967beb8..78d3966232ae 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4144,9 +4144,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 
 int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *root = fs_info->tree_root;
-	struct btrfs_trans_handle *trans;
-
 	mutex_lock(&fs_info->cleaner_mutex);
 	btrfs_run_delayed_iputs(fs_info);
 	mutex_unlock(&fs_info->cleaner_mutex);
@@ -4156,14 +4153,7 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
 
-	trans = btrfs_attach_transaction_barrier(root);
-	if (IS_ERR(trans)) {
-		int ret = PTR_ERR(trans);
-
-		return (ret == -ENOENT) ? 0 : ret;
-	}
-
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_current_transaction(fs_info->tree_root);
 }
 
 static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 391af9e79dd6..6864a8a201df 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1334,7 +1334,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
  */
 static int flush_reservations(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_trans_handle *trans;
 	int ret;
 
 	ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
@@ -1342,13 +1341,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 		return ret;
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
 
-	trans = btrfs_attach_transaction_barrier(fs_info->tree_root);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		return (ret == -ENOENT) ? 0 : ret;
-	}
-
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_current_transaction(fs_info->tree_root);
 }
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
@@ -4028,7 +4021,6 @@ int
 btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 {
 	int ret = 0;
-	struct btrfs_trans_handle *trans;
 
 	ret = qgroup_rescan_init(fs_info, 0, 1);
 	if (ret)
@@ -4045,16 +4037,10 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	 * going to clear all tracking information for a clean start.
 	 */
 
-	trans = btrfs_attach_transaction_barrier(fs_info->fs_root);
-	if (IS_ERR(trans) && trans != ERR_PTR(-ENOENT)) {
+	ret = btrfs_commit_current_transaction(fs_info->fs_root);
+	if (ret) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
-		return PTR_ERR(trans);
-	} else if (trans != ERR_PTR(-ENOENT)) {
-		ret = btrfs_commit_transaction(trans);
-		if (ret) {
-			fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
-			return ret;
-		}
+		return ret;
 	}
 
 	qgroup_rescan_zero_tracking(fs_info);
@@ -4190,7 +4176,6 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
  */
 static int try_flush_qgroup(struct btrfs_root *root)
 {
-	struct btrfs_trans_handle *trans;
 	int ret;
 
 	/* Can't hold an open transaction or we run the risk of deadlocking. */
@@ -4213,15 +4198,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		goto out;
 	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 
-	trans = btrfs_attach_transaction_barrier(root);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		if (ret == -ENOENT)
-			ret = 0;
-		goto out;
-	}
-
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_current_transaction(root);
 out:
 	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
 	wake_up(&root->qgroup_flush_wait);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6c7b5d52591e..188a9c42c9eb 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2437,7 +2437,6 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
 					  struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct btrfs_trans_handle *trans;
 
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
@@ -2446,14 +2445,7 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
 	btrfs_wait_nocow_writers(cache);
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache);
 
-	trans = btrfs_attach_transaction_barrier(root);
-	if (IS_ERR(trans)) {
-		int ret = PTR_ERR(trans);
-
-		return (ret == -ENOENT) ? 0 : ret;
-	}
-
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_current_transaction(root);
 }
 
 static noinline_for_stack
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 289e5e6a6c56..7a82132500a8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7998,7 +7998,6 @@ static int send_subvol(struct send_ctx *sctx)
  */
 static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 {
-	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = sctx->parent_root;
 
 	if (root && root->node != root->commit_root)
@@ -8018,14 +8017,7 @@ static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 	 * an unnecessary update of the root's item in the root tree when
 	 * committing the transaction if that root wasn't changed before.
 	 */
-	trans = btrfs_attach_transaction_barrier(root);
-	if (IS_ERR(trans)) {
-		int ret = PTR_ERR(trans);
-
-		return (ret == -ENOENT) ? 0 : ret;
-	}
-
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_current_transaction(root);
 }
 
 /*
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 69760e1e726f..0283ee9bf813 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -805,14 +805,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		 * because that does not wait for a transaction to fully commit
 		 * (only for it to be unblocked, state TRANS_STATE_UNBLOCKED).
 		 */
-		trans = btrfs_attach_transaction_barrier(root);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			if (ret == -ENOENT)
-				ret = 0;
-			break;
-		}
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_current_transaction(root);
 		break;
 	default:
 		ret = -ENOSPC;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 117a355dbd7a..21d986e07500 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2257,9 +2257,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 
 static int btrfs_freeze(struct super_block *sb)
 {
-	struct btrfs_trans_handle *trans;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_root *root = fs_info->tree_root;
 
 	set_bit(BTRFS_FS_FROZEN, &fs_info->flags);
 	/*
@@ -2268,14 +2266,7 @@ static int btrfs_freeze(struct super_block *sb)
 	 * we want to avoid on a frozen filesystem), or do the commit
 	 * ourselves.
 	 */
-	trans = btrfs_attach_transaction_barrier(root);
-	if (IS_ERR(trans)) {
-		/* no transaction, don't bother */
-		if (PTR_ERR(trans) == -ENOENT)
-			return 0;
-		return PTR_ERR(trans);
-	}
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_current_transaction(fs_info->tree_root);
 }
 
 static int check_dev_super(struct btrfs_device *dev)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 639755f025b4..9590a1899b9d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1989,6 +1989,25 @@ void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 	btrfs_put_transaction(cur_trans);
 }
 
+/*
+ * If there is a running transaction commit it or if it's already committing,
+ * wait for its commit to complete. Does not start and commit a new transaction
+ * if there isn't any running.
+ */
+int btrfs_commit_current_transaction(struct btrfs_root *root)
+{
+	struct btrfs_trans_handle *trans;
+
+	trans = btrfs_attach_transaction_barrier(root);
+	if (IS_ERR(trans)) {
+		int ret = PTR_ERR(trans);
+
+		return (ret == -ENOENT) ? 0 : ret;
+	}
+
+	return btrfs_commit_transaction(trans);
+}
+
 static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 90b987941dd1..81da655b5ee7 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -268,6 +268,7 @@ void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info);
 int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
 void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
+int btrfs_commit_current_transaction(struct btrfs_root *root);
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
 void btrfs_throttle(struct btrfs_fs_info *fs_info);
-- 
2.43.0


