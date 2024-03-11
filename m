Return-Path: <linux-btrfs+bounces-3183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81736878327
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0911C1F26257
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474E59B63;
	Mon, 11 Mar 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk7k2RHv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445944C93;
	Mon, 11 Mar 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169998; cv=none; b=SRAZpun6zd/ruJfVkfOI82SV5GL5NHo85a3OX0bDrlaVpmyN2CFxdrhkYHWJ/HksSU3N8X7ansQJnyKO33dv2deohe+zTXUNeb5zU+wzyT96u7W9MHri74kl2EA8IVGNuURWJ/vMfEfShte7WTfguUoD1tYljJ+m0lpxRen5m0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169998; c=relaxed/simple;
	bh=Ci9riVZbxJ14AJQUWZVd75cjZHMBm4hSSB/4WuT7fmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRDIklJEASifNodct1lq+StmssaywVkCQD139uTnfm7helNAJmgxRLXGIdC5GyM7FzEmWgylSo2duxUffMIz6HrW/isLGnjUt1YWFXwZ73AQ8zHsyi5mYKNnisetRDS7kR0B3c+TUn4oYTNmYdk42+zT2sCzmISOsnlnzZFLR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk7k2RHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA8C433F1;
	Mon, 11 Mar 2024 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169998;
	bh=Ci9riVZbxJ14AJQUWZVd75cjZHMBm4hSSB/4WuT7fmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk7k2RHvQpfPBHD8SSSVNnLGVAdtA6Eufgejzsg/TD6tLtMsd5aW649BX0XGaSeeh
	 mt/C/52YhgW3DUuSVUdMeDGbdRL++NYK1TMiX7aRT0Fk6HkInGJ0Z8511Z2xEE7DLL
	 wQHqsCNWwex6Hel6qGaROz+fhH3Zi37F/XCV3g0zDr969AdQnyCWRUnZcG4ZO4gcIT
	 8EZKhVXw3QycwiDIHXZzxPyJN9Lv3rpu5O49fzut9LHU+OtOSLoesd+QUOpj1rOdAf
	 iDR6H6f4oiQJ47/AyglwlIgyln0PssW+nDRprDBHw8UwaUvZucvmFXOOZvpOewIkj0
	 bI9IYUxBDIOww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/17] btrfs: fix data races when accessing the reserved amount of block reserves
Date: Mon, 11 Mar 2024 11:12:53 -0400
Message-ID: <20240311151314.317776-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit e06cc89475eddc1f3a7a4d471524256152c68166 ]

At space_info.c we have several places where we access the ->reserved
field of a block reserve without taking the block reserve's spinlock
first, which makes KCSAN warn about a data race since that field is
always updated while holding the spinlock.

The reports from KCSAN are like the following:

  [117.193526] BUG: KCSAN: data-race in btrfs_block_rsv_release [btrfs] / need_preemptive_reclaim [btrfs]

  [117.195148] read to 0x000000017f587190 of 8 bytes by task 6303 on cpu 3:
  [117.195172]  need_preemptive_reclaim+0x222/0x2f0 [btrfs]
  [117.195992]  __reserve_bytes+0xbb0/0xdc8 [btrfs]
  [117.196807]  btrfs_reserve_metadata_bytes+0x4c/0x120 [btrfs]
  [117.197620]  btrfs_block_rsv_add+0x78/0xa8 [btrfs]
  [117.198434]  btrfs_delayed_update_inode+0x154/0x368 [btrfs]
  [117.199300]  btrfs_update_inode+0x108/0x1c8 [btrfs]
  [117.200122]  btrfs_dirty_inode+0xb4/0x140 [btrfs]
  [117.200937]  btrfs_update_time+0x8c/0xb0 [btrfs]
  [117.201754]  touch_atime+0x16c/0x1e0
  [117.201789]  filemap_read+0x674/0x728
  [117.201823]  btrfs_file_read_iter+0xf8/0x410 [btrfs]
  [117.202653]  vfs_read+0x2b6/0x498
  [117.203454]  ksys_read+0xa2/0x150
  [117.203473]  __s390x_sys_read+0x68/0x88
  [117.203495]  do_syscall+0x1c6/0x210
  [117.203517]  __do_syscall+0xc8/0xf0
  [117.203539]  system_call+0x70/0x98

  [117.203579] write to 0x000000017f587190 of 8 bytes by task 11 on cpu 0:
  [117.203604]  btrfs_block_rsv_release+0x2e8/0x578 [btrfs]
  [117.204432]  btrfs_delayed_inode_release_metadata+0x7c/0x1d0 [btrfs]
  [117.205259]  __btrfs_update_delayed_inode+0x37c/0x5e0 [btrfs]
  [117.206093]  btrfs_async_run_delayed_root+0x356/0x498 [btrfs]
  [117.206917]  btrfs_work_helper+0x160/0x7a0 [btrfs]
  [117.207738]  process_one_work+0x3b6/0x838
  [117.207768]  worker_thread+0x75e/0xb10
  [117.207797]  kthread+0x21a/0x230
  [117.207830]  __ret_from_fork+0x6c/0xb8
  [117.207861]  ret_from_fork+0xa/0x30

So add a helper to get the reserved amount of a block reserve while
holding the lock. The value may be not be up to date anymore when used by
need_preemptive_reclaim() and btrfs_preempt_reclaim_metadata_space(), but
that's ok since the worst it can do is cause more reclaim work do be done
sooner rather than later. Reading the field while holding the lock instead
of using the data_race() annotation is used in order to prevent load
tearing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-rsv.h  | 16 ++++++++++++++++
 fs/btrfs/space-info.c | 26 +++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index b0bd12b8652f4..fb440a074700a 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -101,4 +101,20 @@ static inline bool btrfs_block_rsv_full(const struct btrfs_block_rsv *rsv)
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
index d7e8cd4f140cf..3f7a9605e2d3a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -837,7 +837,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info)
 {
-	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
+	const u64 global_rsv_size = btrfs_block_rsv_reserved(&fs_info->global_block_rsv);
 	u64 ordered, delalloc;
 	u64 thresh;
 	u64 used;
@@ -937,8 +937,8 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	ordered = percpu_counter_read_positive(&fs_info->ordered_bytes) >> 1;
 	delalloc = percpu_counter_read_positive(&fs_info->delalloc_bytes);
 	if (ordered >= delalloc)
-		used += fs_info->delayed_refs_rsv.reserved +
-			fs_info->delayed_block_rsv.reserved;
+		used += btrfs_block_rsv_reserved(&fs_info->delayed_refs_rsv) +
+			btrfs_block_rsv_reserved(&fs_info->delayed_block_rsv);
 	else
 		used += space_info->bytes_may_use - global_rsv_size;
 
@@ -1153,7 +1153,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
-		u64 global_rsv_size = global_rsv->reserved;
+		const u64 global_rsv_size = btrfs_block_rsv_reserved(global_rsv);
 
 		loops++;
 
@@ -1165,9 +1165,9 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
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
 
@@ -1187,16 +1187,16 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
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
2.43.0


