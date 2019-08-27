Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767359F244
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfH0SYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 14:24:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729903AbfH0SYi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 14:24:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06531AC26
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 18:24:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 231A0DA809; Tue, 27 Aug 2019 20:24:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use percentage for fractions, replace helpers
Date:   Tue, 27 Aug 2019 20:24:53 +0200
Message-Id: <20190827182453.3072-1-dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The div_factor* helpers calculate fraction or percentual fraction.
There's a nice helper mult_frac that's for general fractions, we'll add
a local wrapper suited for our purposes and replace all instances of
div_factor and update naming in fuctions that pass the fractions.

* div_factor calculates tenths and the numbers need to be adjusted
* div_factor_fine is direct replacement

Signed-off-by: David Sterba <dsterba@suse.com>
---

This depends on the patches creating misc.h, that are on the way to
misc-next.

 fs/btrfs/block-group.c |  6 +++---
 fs/btrfs/block-rsv.c   |  8 ++++----
 fs/btrfs/block-rsv.h   |  4 ++--
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/misc.h        | 19 ++-----------------
 fs/btrfs/space-info.c  |  6 +++---
 fs/btrfs/transaction.c |  6 +++---
 fs/btrfs/transaction.h |  2 +-
 fs/btrfs/volumes.c     |  9 ++++-----
 9 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 10ba8eddec22..101567565627 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1164,7 +1164,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
-							   num_items, 1);
+							   num_items, 10);
 }
 
 /*
@@ -2829,13 +2829,13 @@ static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
 	 */
 	if (force == CHUNK_ALLOC_LIMITED) {
 		thresh = btrfs_super_total_bytes(fs_info->super_copy);
-		thresh = max_t(u64, SZ_64M, div_factor_fine(thresh, 1));
+		thresh = max_t(u64, SZ_64M, mult_perc(thresh, 1));
 
 		if (sinfo->total_bytes - bytes_used < thresh)
 			return 1;
 	}
 
-	if (bytes_used + SZ_2M < div_factor(sinfo->total_bytes, 8))
+	if (bytes_used + SZ_2M < mult_perc(sinfo->total_bytes, 80))
 		return 0;
 	return 1;
 }
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ef8b8ae27386..74d45e2a6c5a 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -130,7 +130,7 @@ int btrfs_block_rsv_add(struct btrfs_root *root,
 	return ret;
 }
 
-int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
+int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent)
 {
 	u64 num_bytes = 0;
 	int ret = -ENOSPC;
@@ -139,7 +139,7 @@ int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
 		return 0;
 
 	spin_lock(&block_rsv->lock);
-	num_bytes = div_factor(block_rsv->size, min_factor);
+	num_bytes = mult_perc(block_rsv->size, min_percent);
 	if (block_rsv->reserved >= num_bytes)
 		ret = 0;
 	spin_unlock(&block_rsv->lock);
@@ -230,7 +230,7 @@ void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 
 int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 			     struct btrfs_block_rsv *dest, u64 num_bytes,
-			     int min_factor)
+			     int min_percent)
 {
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 min_bytes;
@@ -239,7 +239,7 @@ int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 
 	spin_lock(&global_rsv->lock);
-	min_bytes = div_factor(global_rsv->size, min_factor);
+	min_bytes = mult_perc(global_rsv->size, min_percent);
 	if (global_rsv->reserved < min_bytes + num_bytes) {
 		spin_unlock(&global_rsv->lock);
 		return -ENOSPC;
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index d1428bb73fc5..f93ee706b644 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -60,7 +60,7 @@ void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 int btrfs_block_rsv_add(struct btrfs_root *root,
 			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			enum btrfs_reserve_flush_enum flush);
-int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor);
+int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent);
 int btrfs_block_rsv_refill(struct btrfs_root *root,
 			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
 			   enum btrfs_reserve_flush_enum flush);
@@ -70,7 +70,7 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
 int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes);
 int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 			     struct btrfs_block_rsv *dest, u64 num_bytes,
-			     int min_factor);
+			     int min_percent);
 void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 			       u64 num_bytes, bool update_size);
 u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e0e940fe01df..7bfc89210254 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4153,7 +4153,7 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 	 * 1 for the inode ref
 	 * 1 for the inode
 	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 5, 5);
+	return btrfs_start_transaction_fallback_global_rsv(root, 5, 50);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 7d564924dfeb..4004c4028b73 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -5,10 +5,11 @@
 
 #include <linux/sched.h>
 #include <linux/wait.h>
-#include <asm/div64.h>
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
+#define mult_perc(x, perc)	mult_frac((x), (perc), 100U)
+
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
@@ -31,20 +32,4 @@ static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
 		wake_up(wq);
 }
 
-static inline u64 div_factor(u64 num, int factor)
-{
-	if (factor == 10)
-		return num;
-	num *= factor;
-	return div_u64(num, 10);
-}
-
-static inline u64 div_factor_fine(u64 num, int factor)
-{
-	if (factor == 100)
-		return num;
-	num *= factor;
-	return div_u64(num, 100);
-}
-
 #endif
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bea7ae0a9739..107db4595b29 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -712,9 +712,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 	if (can_overcommit(fs_info, space_info, SZ_1M,
 			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
-		expected = div_factor_fine(space_info->total_bytes, 95);
+		expected = mult_perc(space_info->total_bytes, 95);
 	else
-		expected = div_factor_fine(space_info->total_bytes, 90);
+		expected = mult_perc(space_info->total_bytes, 90);
 
 	if (used > expected)
 		to_reclaim = used - expected;
@@ -729,7 +729,7 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 					struct btrfs_space_info *space_info,
 					u64 used, bool system_chunk)
 {
-	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+	u64 thresh = mult_perc(space_info->total_bytes, 98);
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8624bdee8c5b..3fe0b7382c45 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -615,7 +615,7 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
 					unsigned int num_items,
-					int min_factor)
+					int min_percent)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
@@ -639,7 +639,7 @@ struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 
 	num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
 	ret = btrfs_cond_migrate_bytes(fs_info, &fs_info->trans_block_rsv,
-				       num_bytes, min_factor);
+				       num_bytes, min_percent);
 	if (ret) {
 		btrfs_end_transaction(trans);
 		return ERR_PTR(ret);
@@ -790,7 +790,7 @@ static int should_end_transaction(struct btrfs_trans_handle *trans)
 	if (btrfs_check_space_for_delayed_refs(fs_info))
 		return 1;
 
-	return !!btrfs_block_rsv_check(&fs_info->global_block_rsv, 5);
+	return !!btrfs_block_rsv_check(&fs_info->global_block_rsv, 50);
 }
 
 int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 2c5a6f6e5bb0..c572df6e4131 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -182,7 +182,7 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
 					unsigned int num_items,
-					int min_factor);
+					int min_percent);
 struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_nolock(struct btrfs_root *root);
 struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a324480bc88b..51504736fde7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3397,7 +3397,7 @@ static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_off
 	if (bargs->usage_min == 0)
 		user_thresh_min = 0;
 	else
-		user_thresh_min = div_factor_fine(cache->key.offset,
+		user_thresh_min = mult_perc(cache->key.offset,
 					bargs->usage_min);
 
 	if (bargs->usage_max == 0)
@@ -3405,7 +3405,7 @@ static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_off
 	else if (bargs->usage_max > 100)
 		user_thresh_max = cache->key.offset;
 	else
-		user_thresh_max = div_factor_fine(cache->key.offset,
+		user_thresh_max = mult_perc(cache->key.offset,
 					bargs->usage_max);
 
 	if (user_thresh_min <= chunk_used && chunk_used < user_thresh_max)
@@ -3430,8 +3430,7 @@ static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
 	else if (bargs->usage > 100)
 		user_thresh = cache->key.offset;
 	else
-		user_thresh = div_factor_fine(cache->key.offset,
-					      bargs->usage);
+		user_thresh = mult_perc(cache->key.offset, bargs->usage);
 
 	if (chunk_used < user_thresh)
 		ret = 0;
@@ -4964,7 +4963,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	/* We don't want a chunk larger than 10% of writable space */
-	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
+	max_chunk_size = min(mult_perc(fs_devices->total_rw_bytes, 10),
 			     max_chunk_size);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-- 
2.22.0

