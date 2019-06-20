Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB18F4DA65
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFTTiw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41882 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFTTiv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so4377437qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sGYq0Jj57WNtwIMg+S8grrJOVgIIiz2hjGE2VGVq/e4=;
        b=dHwn+gbF1olpCzoOj8EYTIbeSa5ok3qVESbWq/B0dWN87zsjf9smWNqvJx8OEZbluY
         bNMDdfdCmLrB0fFDqg9tAiBaEHDvtjuyKSydpneC/4eiPNle1VZkkxYxKa7PIe73KlC4
         ovKD+58M/aJoR/G/CppCek2UOzAzyeX3ki3b9yn857NoOJFKRIAJsoCI9Nx43uRVKUSd
         iveaGQAI2QAxE+IOeeDJJEDQEoXIe4jJCrpSY/3QZPNvf2mjPetDT8M/unXC57thati9
         dAxAFkkTuIfVjc2o5iLS2bcVbKYPV/o0CuPDKLMygbpHdojRQmY1T5bU9dyeyG23POKe
         AQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sGYq0Jj57WNtwIMg+S8grrJOVgIIiz2hjGE2VGVq/e4=;
        b=c4qPUejqahUwVhnvqCeXTvzF1h7E/wj7sJaFNEOptGoX98UYSMq6ITrpe9VaSRCDXS
         TWtqWaKXB02dzngY1lBvM5MAswyEzZrP+0hxI7Yhx2GQFAl5WZDyy/l3VRyuy3ulakN3
         Kn5Bayvx9WGfg1yInSc3y1Im3MHj1XmMLCkj7+IcxP1iGbwmzOu5zYEEhI9hB7PYVhtt
         0Exnr/A7LrtC47G5J0MGIKh8+Me5BA6HU0NJ3Ez40hRcOCmqJ58RHRN5h+vLNappBk5h
         7gqpLd6gZuZiP56423wCVa2oOfEqdjaU2x1AjQZ3jJbRQeMauL6mznyM5UBiazFw8SPs
         Jp5A==
X-Gm-Message-State: APjAAAXwRe9uaocI4KJ/68jsWZRYseiq905FYCvc/ngiuy0ibdaON/4F
        JFQtnQ8ewFQ8SzBhBmaoLbbXHpTJljbGmw==
X-Google-Smtp-Source: APXvYqxqa8BOxPttaoIQOFR9lUtRrd8gR4sqhAVgz3Pl+KtCL52NjVjc9GxjsTRNio7gvFHBFsFTfw==
X-Received: by 2002:ac8:2181:: with SMTP id 1mr25785578qty.263.1561059529884;
        Thu, 20 Jun 2019 12:38:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w16sm493623qtc.41.2019.06.20.12.38.49
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 25/25] btrfs: unexport the temporary exported functions
Date:   Thu, 20 Jun 2019 15:38:07 -0400
Message-Id: <20190620193807.29311-26-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These were renamed and exported to facilitate logical migration of
different code chunks into block-group.c.  Now that all the users are in
one file go ahead and rename them back, move the code around, and make
them static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 140 ++++++++++++++++++++++++-------------------------
 fs/btrfs/block-group.h |   6 ---
 2 files changed, 70 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 57ac375ae847..add34cbf76b8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -23,7 +23,7 @@
  *
  * should be called with balance_lock held
  */
-u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	u64 target = 0;
@@ -64,7 +64,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	 * try to reduce to the target profile
 	 */
 	spin_lock(&fs_info->balance_lock);
-	target = btrfs_get_restripe_target(fs_info, flags);
+	target = get_restripe_target(fs_info, flags);
 	if (target) {
 		/* pick target profile only if it's already available */
 		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
@@ -426,7 +426,7 @@ int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group)
+static void fragment_free_space(struct btrfs_block_group_cache *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	u64 start = block_group->key.objectid;
@@ -664,7 +664,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 		block_group->space_info->bytes_used += bytes_used >> 1;
 		spin_unlock(&block_group->lock);
 		spin_unlock(&block_group->space_info->lock);
-		btrfs_fragment_free_space(block_group);
+		fragment_free_space(block_group);
 	}
 #endif
 
@@ -771,7 +771,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 			cache->space_info->bytes_used += bytes_used >> 1;
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
-			btrfs_fragment_free_space(cache);
+			fragment_free_space(cache);
 		}
 #endif
 		mutex_unlock(&caching_ctl->mutex);
@@ -1139,6 +1139,62 @@ btrfs_start_trans_remove_block_group(struct btrfs_fs_info *fs_info,
 							   num_items, 1);
 }
 
+static int inc_block_group_ro(struct btrfs_block_group_cache *cache,
+			      int force)
+{
+	struct btrfs_space_info *sinfo = cache->space_info;
+	u64 num_bytes;
+	u64 sinfo_used;
+	u64 min_allocable_bytes;
+	int ret = -ENOSPC;
+
+	/*
+	 * We need some metadata space and system metadata space for
+	 * allocating chunks in some corner cases until we force to set
+	 * it to be readonly.
+	 */
+	if ((sinfo->flags &
+	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
+	    !force)
+		min_allocable_bytes = SZ_1M;
+	else
+		min_allocable_bytes = 0;
+
+	spin_lock(&sinfo->lock);
+	spin_lock(&cache->lock);
+
+	if (cache->ro) {
+		cache->ro++;
+		ret = 0;
+		goto out;
+	}
+
+	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
+		    cache->bytes_super - btrfs_block_group_used(&cache->item);
+	sinfo_used = btrfs_space_info_used(sinfo, true);
+
+	if (sinfo_used + num_bytes + min_allocable_bytes <=
+	    sinfo->total_bytes) {
+		sinfo->bytes_readonly += num_bytes;
+		cache->ro++;
+		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
+		ret = 0;
+	}
+out:
+	spin_unlock(&cache->lock);
+	spin_unlock(&sinfo->lock);
+	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
+		btrfs_info(cache->fs_info,
+			"unable to make block group %llu ro",
+			cache->key.objectid);
+		btrfs_info(cache->fs_info,
+			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
+			sinfo_used, num_bytes, min_allocable_bytes);
+		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
+	}
+	return ret;
+}
+
 /*
  * Process the unused_bgs list and remove any that don't have any allocated
  * space inside of them.
@@ -1194,7 +1250,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
-		ret = __btrfs_inc_block_group_ro(block_group, 0);
+		ret = inc_block_group_ro(block_group, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret = 0;
@@ -1736,7 +1792,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 
 		set_avail_alloc_bits(info, cache->flags);
 		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
-			__btrfs_inc_block_group_ro(cache, 1);
+			inc_block_group_ro(cache, 1);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
@@ -1758,11 +1814,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_RAID0],
 				list)
-			__btrfs_inc_block_group_ro(cache, 1);
+			inc_block_group_ro(cache, 1);
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_SINGLE],
 				list)
-			__btrfs_inc_block_group_ro(cache, 1);
+			inc_block_group_ro(cache, 1);
 	}
 
 	btrfs_add_raid_kobjects(info);
@@ -1855,7 +1911,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 		u64 new_bytes_used = size - bytes_used;
 
 		bytes_used += new_bytes_used >> 1;
-		btrfs_fragment_free_space(cache);
+		fragment_free_space(cache);
 	}
 #endif
 	/*
@@ -1901,7 +1957,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	 * if restripe for this chunk_type is on pick target profile and
 	 * return, otherwise do the usual balance
 	 */
-	stripped = btrfs_get_restripe_target(fs_info, flags);
+	stripped = get_restripe_target(fs_info, flags);
 	if (stripped)
 		return extended_to_chunk(stripped);
 
@@ -1941,62 +1997,6 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	return flags;
 }
 
-int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
-			       int force)
-{
-	struct btrfs_space_info *sinfo = cache->space_info;
-	u64 num_bytes;
-	u64 sinfo_used;
-	u64 min_allocable_bytes;
-	int ret = -ENOSPC;
-
-	/*
-	 * We need some metadata space and system metadata space for
-	 * allocating chunks in some corner cases until we force to set
-	 * it to be readonly.
-	 */
-	if ((sinfo->flags &
-	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
-	    !force)
-		min_allocable_bytes = SZ_1M;
-	else
-		min_allocable_bytes = 0;
-
-	spin_lock(&sinfo->lock);
-	spin_lock(&cache->lock);
-
-	if (cache->ro) {
-		cache->ro++;
-		ret = 0;
-		goto out;
-	}
-
-	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
-		    cache->bytes_super - btrfs_block_group_used(&cache->item);
-	sinfo_used = btrfs_space_info_used(sinfo, true);
-
-	if (sinfo_used + num_bytes + min_allocable_bytes <=
-	    sinfo->total_bytes) {
-		sinfo->bytes_readonly += num_bytes;
-		cache->ro++;
-		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
-		ret = 0;
-	}
-out:
-	spin_unlock(&cache->lock);
-	spin_unlock(&sinfo->lock);
-	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
-		btrfs_info(cache->fs_info,
-			"unable to make block group %llu ro",
-			cache->key.objectid);
-		btrfs_info(cache->fs_info,
-			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
-			sinfo_used, num_bytes, min_allocable_bytes);
-		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
-	}
-	return ret;
-}
-
 int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 
 {
@@ -2047,14 +2047,14 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 			goto out;
 	}
 
-	ret = __btrfs_inc_block_group_ro(cache, 0);
+	ret = inc_block_group_ro(cache, 0);
 	if (!ret)
 		goto out;
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
-	ret = __btrfs_inc_block_group_ro(cache, 0);
+	ret = inc_block_group_ro(cache, 0);
 out:
 	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
 		alloc_flags = update_block_group_flags(fs_info, cache->flags);
@@ -2858,7 +2858,7 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 	 *      3: raid0
 	 *      4: single
 	 */
-	target = btrfs_get_restripe_target(fs_info, block_group->flags);
+	target = get_restripe_target(fs_info, block_group->flags);
 	if (target) {
 		index = btrfs_bg_flags_to_raid_index(extended_to_chunk(target));
 	} else {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3c6cf7477990..bf72dcfc1c82 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -171,7 +171,6 @@ btrfs_should_fragment_free_space(struct btrfs_block_group_cache *block_group)
 	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
 		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
 }
-void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group);
 #endif
 
 struct btrfs_block_group_cache *
@@ -253,9 +252,4 @@ btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
 	return cache->cached == BTRFS_CACHE_FINISHED ||
 		cache->cached == BTRFS_CACHE_ERROR;
 }
-
-int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
-			       int force);
-u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags);
-
 #endif /* BTRFS_BLOCK_GROUP_H */
-- 
2.14.3

