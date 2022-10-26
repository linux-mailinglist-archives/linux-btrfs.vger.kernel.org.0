Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B660EAD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiJZVZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiJZVZg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 17:25:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B729826
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 14:25:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3DDE421E59;
        Wed, 26 Oct 2022 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666819530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jcqMEs09kevx0jZXyPMeJdRvP79TFvVqT2YhoQ5bvMw=;
        b=WkAmCqSBcSGyr+oeFAUQKn4H8+7J3x6FjhCMXrDiuyijnQr0FsmveHH/Zozr47G+2ioxO2
        zVuPvd9NoBE0AfLFp3TRS3gaNYcNk6GRVuXn8IVdo75jvL8PUoWxvkn6bnmn3Kh6ms76gn
        pGPD4/eZYwjztPXy4lA7lbVG4yRVsag=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3612B2C141;
        Wed, 26 Oct 2022 21:25:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE131DA79B; Wed, 26 Oct 2022 23:25:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: simplify percent calculation helpers, rename div_factor
Date:   Wed, 26 Oct 2022 23:25:14 +0200
Message-Id: <20221026212514.431-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The div_factor* helpers calculate fraction or percentage fraction. The
name is a bit confusing, we use it only for percentage calculations and
there are two helpers.

There's a helper mult_frac that's for general fractions, that tries to
be accurate but we multiply and divide by small numbers so we can use
the div_u64 helper.

Rename the div_factor* helpers and use 1..100 percentage range, also drop
the case checking for percentage == 100, it's never hit.

The conversions:

* div_factor calculates tenths and the numbers need to be adjusted
* div_factor_fine is direct replacement

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c      |  6 +++---
 fs/btrfs/block-rsv.c        |  4 ++--
 fs/btrfs/block-rsv.h        |  2 +-
 fs/btrfs/free-space-cache.c |  3 +--
 fs/btrfs/misc.h             | 16 ++--------------
 fs/btrfs/space-info.c       |  4 ++--
 fs/btrfs/sysfs.c            |  2 +-
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/volumes.c          | 12 +++++-------
 9 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5a743c4d4e97..61a9d8d7f06c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1553,7 +1553,7 @@ static bool should_reclaim_block_group(struct btrfs_block_group *bg, u64 bytes_f
 	if (reclaim_thresh == 0)
 		return false;
 
-	thresh = div_factor_fine(bg->length, reclaim_thresh);
+	thresh = mult_perc(bg->length, reclaim_thresh);
 
 	/*
 	 * If we were below the threshold before don't reclaim, we are likely a
@@ -3523,13 +3523,13 @@ static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
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
index 29705256727f..5367a14d44d2 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -227,7 +227,7 @@ int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
+int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent)
 {
 	u64 num_bytes = 0;
 	int ret = -ENOSPC;
@@ -236,7 +236,7 @@ int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
 		return 0;
 
 	spin_lock(&block_rsv->lock);
-	num_bytes = div_factor(block_rsv->size, min_factor);
+	num_bytes = mult_perc(block_rsv->size, min_percent);
 	if (block_rsv->reserved >= num_bytes)
 		ret = 0;
 	spin_unlock(&block_rsv->lock);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 7e9016a9e193..e4696fa990c2 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -62,7 +62,7 @@ void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			enum btrfs_reserve_flush_enum flush);
-int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor);
+int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent);
 int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
 			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
 			   enum btrfs_reserve_flush_enum flush);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7a182cc6dab7..478099c1d464 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2724,8 +2724,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		btrfs_mark_bg_unused(block_group);
 	} else if (bg_reclaim_threshold &&
 		   reclaimable_unusable >=
-		   div_factor_fine(block_group->zone_capacity,
-				   bg_reclaim_threshold)) {
+		   mult_perc(block_group->zone_capacity, bg_reclaim_threshold)) {
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 69826ccd6644..768583a440e1 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -40,22 +40,10 @@ static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
 		wake_up(wq);
 }
 
-static inline u64 div_factor(u64 num, int factor)
+static inline u64 mult_perc(u64 num, u32 percent)
 {
-	if (factor == 10)
-		return num;
-	num *= factor;
-	return div_u64(num, 10);
+	return div_u64(num * percent, 100);
 }
-
-static inline u64 div_factor_fine(u64 num, int factor)
-{
-	if (factor == 100)
-		return num;
-	num *= factor;
-	return div_u64(num, 100);
-}
-
 /* Copy of is_power_of_two that is 64bit safe */
 static inline bool is_power_of_two_u64(u64 n)
 {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 382a2a53d2ff..353c894ee91b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -859,7 +859,7 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	u64 thresh;
 	u64 used;
 
-	thresh = div_factor_fine(total, 90);
+	thresh = mult_perc(total, 90);
 
 	lockdep_assert_held(&space_info->lock);
 
@@ -977,7 +977,7 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 		return false;
 
 	spin_lock(&global_rsv->lock);
-	min_bytes = div_factor(global_rsv->size, 1);
+	min_bytes = mult_perc(global_rsv->size, 10);
 	if (global_rsv->reserved < min_bytes + ticket->bytes) {
 		spin_unlock(&global_rsv->lock);
 		return false;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 32723a388fd9..89fda2f7b3e3 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -764,7 +764,7 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
 
 	/* Limit stripe size to 10% of available space. */
-	val = min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
+	val = min(mult_perc(fs_info->fs_devices->total_rw_bytes, 10), val);
 
 	/* Must be multiple of 256M. */
 	val &= ~((u64)SZ_256M - 1);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9624bbb4b777..ae5681972a37 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -943,7 +943,7 @@ static bool should_end_transaction(struct btrfs_trans_handle *trans)
 	if (btrfs_check_space_for_delayed_refs(fs_info))
 		return true;
 
-	return !!btrfs_block_rsv_check(&fs_info->global_block_rsv, 5);
+	return !!btrfs_block_rsv_check(&fs_info->global_block_rsv, 50);
 }
 
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0182ae70911e..fcf4806008dd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3596,16 +3596,14 @@ static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_off
 	if (bargs->usage_min == 0)
 		user_thresh_min = 0;
 	else
-		user_thresh_min = div_factor_fine(cache->length,
-						  bargs->usage_min);
+		user_thresh_min = mult_perc(cache->length, bargs->usage_min);
 
 	if (bargs->usage_max == 0)
 		user_thresh_max = 1;
 	else if (bargs->usage_max > 100)
 		user_thresh_max = cache->length;
 	else
-		user_thresh_max = div_factor_fine(cache->length,
-						  bargs->usage_max);
+		user_thresh_max = mult_perc(cache->length, bargs->usage_max);
 
 	if (user_thresh_min <= chunk_used && chunk_used < user_thresh_max)
 		ret = 0;
@@ -3629,7 +3627,7 @@ static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
 	else if (bargs->usage > 100)
 		user_thresh = cache->length;
 	else
-		user_thresh = div_factor_fine(cache->length, bargs->usage);
+		user_thresh = mult_perc(cache->length, bargs->usage);
 
 	if (chunk_used < user_thresh)
 		ret = 0;
@@ -5094,7 +5092,7 @@ static void init_alloc_chunk_ctl_policy_regular(
 		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
 
 	/* We don't want a chunk larger than 10% of writable space */
-	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
+	ctl->max_chunk_size = min(mult_perc(fs_devices->total_rw_bytes, 10),
 				  ctl->max_chunk_size);
 	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
@@ -5125,7 +5123,7 @@ static void init_alloc_chunk_ctl_policy_zoned(
 	}
 
 	/* We don't want a chunk larger than 10% of writable space */
-	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
+	limit = max(round_down(mult_perc(fs_devices->total_rw_bytes, 10),
 			       zone_size),
 		    min_chunk_size);
 	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
-- 
2.37.3

