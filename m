Return-Path: <linux-btrfs+bounces-2585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4A85BBF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472091F214E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934A69963;
	Tue, 20 Feb 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip3MPX+2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44E6994F
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431882; cv=none; b=LREL6RQ6U9Pk+CrqObjmtA22jTx2J1Tncib4rhwy99Gm0xrGAiOGJjtxzUMYQINXAm6PiDBpdOEuY85ZbltPoIQ1bEbXaMOHiKbbpjeuuDvJpaJKd+oXuhHjq0HM/Ft7GLc638VqwHaNa0KXIYcSbw7kBXH1YI270mKfxCJ5dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431882; c=relaxed/simple;
	bh=ISK9fgpSrdFcxqKx9Eh5QAlkcR5uAvwWFDaZfXGYQto=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKQ4BM5kbAZMSZPXVkXMQVfcD/THrBDQ6XA9viDwu+2/u9zxySTe/c4lm/+Lw/9Jm318wU0nE0uoekvijQysWAaORpqvhE0GaV1+8A0yL/eOagAOD8E8Sac275bAkmo7S2TDXUKP8FU0VgEzrZ3by37rtFgU/WtXCQk89Mpf2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip3MPX+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD940C433F1
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708431882;
	bh=ISK9fgpSrdFcxqKx9Eh5QAlkcR5uAvwWFDaZfXGYQto=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ip3MPX+2aKL0pQ+j6iPlOr8K9Xz8g+0itVsr1sQ9kT1XUpPBDZ1XQvnMNm7XDCp4s
	 bDeuRYcv5OnxV2+Eu2X8LDtKl4f824fRZhHypJtfkFsXODDFH/wIfIdeqgYogeXQC7
	 xYNIQH6cA2lybQ0jJlyGbRURWSOkNUXmcx+XL9gGKMN/qLOGdo23iA4Uw4p9cMIhKb
	 lTmLqCcJv3za0IXtt+5D9FD3PORbRx+A0Ov7ydx6xZMnzL35lGuAuYnwz8jmtQfYf/
	 Ew76e244O+1HN28tbLq5qoiuOlx1p497ysCJJFHqujL8ekS85V+Rl5+1p/BblGGtcq
	 tocUr3UdoFNnQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix data races when accessing the reserved amount of block reserves
Date: Tue, 20 Feb 2024 12:24:33 +0000
Message-Id: <5ff1a68f4289d5bb870a499b248d329893d417ae.1708429856.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708429856.git.fdmanana@suse.com>
References: <cover.1708429856.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At space_info.c we have several places where we access the ->reserved
field of a block reserve without taking the block reserve's spinlock
first, which makes KCSAN warn about a data race since that field is
always updated while holding the spinlock.

The reports from KCSAN are like the following:

  [  117.193526] BUG: KCSAN: data-race in btrfs_block_rsv_release [btrfs] / need_preemptive_reclaim [btrfs]

  [  117.195148] read to 0x000000017f587190 of 8 bytes by task 6303 on cpu 3:
  [  117.195172]  need_preemptive_reclaim+0x222/0x2f0 [btrfs]
  [  117.195992]  __reserve_bytes+0xbb0/0xdc8 [btrfs]
  [  117.196807]  btrfs_reserve_metadata_bytes+0x4c/0x120 [btrfs]
  [  117.197620]  btrfs_block_rsv_add+0x78/0xa8 [btrfs]
  [  117.198434]  btrfs_delayed_update_inode+0x154/0x368 [btrfs]
  [  117.199300]  btrfs_update_inode+0x108/0x1c8 [btrfs]
  [  117.200122]  btrfs_dirty_inode+0xb4/0x140 [btrfs]
  [  117.200937]  btrfs_update_time+0x8c/0xb0 [btrfs]
  [  117.201754]  touch_atime+0x16c/0x1e0
  [  117.201789]  filemap_read+0x674/0x728
  [  117.201823]  btrfs_file_read_iter+0xf8/0x410 [btrfs]
  [  117.202653]  vfs_read+0x2b6/0x498
  [  117.203454]  ksys_read+0xa2/0x150
  [  117.203473]  __s390x_sys_read+0x68/0x88
  [  117.203495]  do_syscall+0x1c6/0x210
  [  117.203517]  __do_syscall+0xc8/0xf0
  [  117.203539]  system_call+0x70/0x98

  [  117.203579] write to 0x000000017f587190 of 8 bytes by task 11 on cpu 0:
  [  117.203604]  btrfs_block_rsv_release+0x2e8/0x578 [btrfs]
  [  117.204432]  btrfs_delayed_inode_release_metadata+0x7c/0x1d0 [btrfs]
  [  117.205259]  __btrfs_update_delayed_inode+0x37c/0x5e0 [btrfs]
  [  117.206093]  btrfs_async_run_delayed_root+0x356/0x498 [btrfs]
  [  117.206917]  btrfs_work_helper+0x160/0x7a0 [btrfs]
  [  117.207738]  process_one_work+0x3b6/0x838
  [  117.207768]  worker_thread+0x75e/0xb10
  [  117.207797]  kthread+0x21a/0x230
  [  117.207830]  __ret_from_fork+0x6c/0xb8
  [  117.207861]  ret_from_fork+0xa/0x30

So add a helper to get the reserved amount of a block reserve while
holding the lock. The value may be not be up to date anymore when used by
need_preemptive_reclaim() and btrfs_preempt_reclaim_metadata_space(), but
that's ok since the worst it can do is cause more reclaim work do be done
sooner rather than later. Reading the field while holding the lock instead
of using the data_race() annotation is used in order to prevent load
tearing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.h  | 16 ++++++++++++++++
 fs/btrfs/space-info.c | 26 +++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index b621199b0130..89c99f4e9f16 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -108,4 +108,20 @@ static inline bool btrfs_block_rsv_full(const struct btrfs_block_rsv *rsv)
 	return data_race(rsv->full);
 }
 
+/*
+ * Get the reserved mount of a block reserve in a context where getting a stale
+ * value is acceptable, instead of accessing it directly and trigger data race
+ * warning from KCSAN.
+ */
+static inline u64 btrfs_block_rsv_reserved(struct btrfs_block_rsv *rsv)
+{
+	u64 ret;
+
+	spin_lock(&rsv->lock);
+	ret = rsv->reserved;
+	spin_unlock(&rsv->lock);
+
+	return ret;
+}
+
 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a5b652c1650a..d620323d08ea 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -855,7 +855,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info)
 {
-	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
+	const u64 global_rsv_size = btrfs_block_rsv_reserved(&fs_info->global_block_rsv);
 	u64 ordered, delalloc;
 	u64 thresh;
 	u64 used;
@@ -955,8 +955,8 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	ordered = percpu_counter_read_positive(&fs_info->ordered_bytes) >> 1;
 	delalloc = percpu_counter_read_positive(&fs_info->delalloc_bytes);
 	if (ordered >= delalloc)
-		used += fs_info->delayed_refs_rsv.reserved +
-			fs_info->delayed_block_rsv.reserved;
+		used += btrfs_block_rsv_reserved(&fs_info->delayed_refs_rsv) +
+			btrfs_block_rsv_reserved(&fs_info->delayed_block_rsv);
 	else
 		used += space_info->bytes_may_use - global_rsv_size;
 
@@ -1172,7 +1172,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
-		u64 global_rsv_size = global_rsv->reserved;
+		const u64 global_rsv_size = btrfs_block_rsv_reserved(global_rsv);
 
 		loops++;
 
@@ -1184,9 +1184,9 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		 * assume it's tied up in delalloc reservations.
 		 */
 		block_rsv_size = global_rsv_size +
-			delayed_block_rsv->reserved +
-			delayed_refs_rsv->reserved +
-			trans_rsv->reserved;
+			btrfs_block_rsv_reserved(delayed_block_rsv) +
+			btrfs_block_rsv_reserved(delayed_refs_rsv) +
+			btrfs_block_rsv_reserved(trans_rsv);
 		if (block_rsv_size < space_info->bytes_may_use)
 			delalloc_size = space_info->bytes_may_use - block_rsv_size;
 
@@ -1206,16 +1206,16 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 			to_reclaim = delalloc_size;
 			flush = FLUSH_DELALLOC;
 		} else if (space_info->bytes_pinned >
-			   (delayed_block_rsv->reserved +
-			    delayed_refs_rsv->reserved)) {
+			   (btrfs_block_rsv_reserved(delayed_block_rsv) +
+			    btrfs_block_rsv_reserved(delayed_refs_rsv))) {
 			to_reclaim = space_info->bytes_pinned;
 			flush = COMMIT_TRANS;
-		} else if (delayed_block_rsv->reserved >
-			   delayed_refs_rsv->reserved) {
-			to_reclaim = delayed_block_rsv->reserved;
+		} else if (btrfs_block_rsv_reserved(delayed_block_rsv) >
+			   btrfs_block_rsv_reserved(delayed_refs_rsv)) {
+			to_reclaim = btrfs_block_rsv_reserved(delayed_block_rsv);
 			flush = FLUSH_DELAYED_ITEMS_NR;
 		} else {
-			to_reclaim = delayed_refs_rsv->reserved;
+			to_reclaim = btrfs_block_rsv_reserved(delayed_refs_rsv);
 			flush = FLUSH_DELAYED_REFS_NR;
 		}
 
-- 
2.40.1


