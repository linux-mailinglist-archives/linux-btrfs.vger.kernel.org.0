Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3022836E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfHFQ3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:29:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37471 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbfHFQ3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:29:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so85168087qto.4
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fZqS6JT4HvQC5V5NSAjR5yuY/2NCpp31Cdfgqtwe6rY=;
        b=njM4JtxST5sojCpRi6sx/tlNKWrjoIkqV6OukS4xbKbNbDAB7gSKHlYYjYxJi/WpPj
         ivXFlBam2B+Ixx/A/1w0mfRjWQRafuwJtWBvfW7nLxz17Nmj5Mirk9TPtjTEqrKl2K9x
         JFPF+JSVF695FAU02t0nu14nOVc3g2YtL4DIbe3EtugdW8WnUxcq0TK6kJv29bxJKeoK
         UtE00fUo9rm4Gl6KJFzSXGAptyXxJcy7A2buCoQYjftqJOlev6tZxbztwE49sv7cIpOu
         G1K3+z0YPOpgil9floaZaFknv6T8l9pp3w9gKP0TaQjldJJa4TqEFe7t5t0UUX8AFvqz
         8BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZqS6JT4HvQC5V5NSAjR5yuY/2NCpp31Cdfgqtwe6rY=;
        b=rvwlqHznhUcmNfoGKxozx76frVp4HZfvgXjX2FGIouovLFyuj204VFQhGZBX7m64c4
         /FCqHM78IAXHh8Ugd9kenP744wnBW995m66l6jlOffDuxw+JfaOVxhs2E4mjX7oWR+oZ
         8aeXG/QH2DUSO5alaV9hYJb2WzFgH4G0MsUp5wT5iNo0RkVtNuhg0FaOZ9y6R90nWV2z
         0diJGEhIu2AAiQCPN8+mZIGP+hPC7JYCC38Vp45vXlmUTfqzJFtVS0UC0iyPq9gpuDDJ
         pnKSgxykh/jek3wDcjBreR+3w5G7f6K6fLPLazIdqOlushT42EBxw2rdBKZHWHnBKlNG
         CWbQ==
X-Gm-Message-State: APjAAAUDarNn5UxF7cim7leNuu4pdmuCQzMXWJYiS2h1bzstjw7TiKCu
        g7vDH+72fSg00to+EEGwrxxQvw==
X-Google-Smtp-Source: APXvYqwMzmcFHvDkei7mzRtFA8yCaJjr46k9xvhsuvh1QtLA6ITmydtGqqpQVTYWtjtdJ5qy8/qdYg==
X-Received: by 2002:ac8:ce:: with SMTP id d14mr3909849qtg.149.1565108945158;
        Tue, 06 Aug 2019 09:29:05 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y67sm39754046qkd.40.2019.08.06.09.29.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:29:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 14/15] btrfs: unexport the temporary exported functions
Date:   Tue,  6 Aug 2019 12:28:36 -0400
Message-Id: <20190806162837.15840-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/btrfs/block-group.c | 176 ++++++++++++++++++++---------------------
 fs/btrfs/block-group.h |   6 --
 2 files changed, 88 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 451dfd64ed36..0df939285702 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -21,7 +21,7 @@
  *
  * should be called with balance_lock held
  */
-u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	u64 target = 0;
@@ -62,7 +62,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	 * try to reduce to the target profile
 	 */
 	spin_lock(&fs_info->balance_lock);
-	target = btrfs_get_restripe_target(fs_info, flags);
+	target = get_restripe_target(fs_info, flags);
 	if (target) {
 		/* pick target profile only if it's already available */
 		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
@@ -422,7 +422,7 @@ int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group)
+static void fragment_free_space(struct btrfs_block_group_cache *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	u64 start = block_group->key.objectid;
@@ -660,7 +660,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 		block_group->space_info->bytes_used += bytes_used >> 1;
 		spin_unlock(&block_group->lock);
 		spin_unlock(&block_group->space_info->lock);
-		btrfs_fragment_free_space(block_group);
+		fragment_free_space(block_group);
 	}
 #endif
 
@@ -767,7 +767,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 			cache->space_info->bytes_used += bytes_used >> 1;
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
-			btrfs_fragment_free_space(cache);
+			fragment_free_space(cache);
 		}
 #endif
 		mutex_unlock(&caching_ctl->mutex);
@@ -1167,6 +1167,81 @@ btrfs_start_trans_remove_block_group(struct btrfs_fs_info *fs_info,
 							   num_items, 1);
 }
 
+/*
+ * Mark block group @cache read-only, so later write won't happen to block
+ * group @cache.
+ *
+ * If @force is not set, this function will only mark the block group readonly
+ * if we have enough free space (1M) in other metadata/system block groups.
+ * If @force is not set, this function will mark the block group readonly
+ * without checking free space.
+ *
+ * NOTE: This function doesn't care if other block groups can contain all the
+ * data in this block group. That check should be done by relocation routine,
+ * not this function.
+ */
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
+	/*
+	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
+	 *
+	 * Here we make sure if we mark this bg RO, we still have enough
+	 * free space as buffer (if min_allocable_bytes is not 0).
+	 */
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
@@ -1222,7 +1297,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
-		ret = __btrfs_inc_block_group_ro(block_group, 0);
+		ret = inc_block_group_ro(block_group, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret = 0;
@@ -1750,7 +1825,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 
 		set_avail_alloc_bits(info, cache->flags);
 		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
-			__btrfs_inc_block_group_ro(cache, 1);
+			inc_block_group_ro(cache, 1);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
@@ -1771,11 +1846,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
@@ -1868,7 +1943,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 		u64 new_bytes_used = size - bytes_used;
 
 		bytes_used += new_bytes_used >> 1;
-		btrfs_fragment_free_space(cache);
+		fragment_free_space(cache);
 	}
 #endif
 	/*
@@ -1914,7 +1989,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	 * if restripe for this chunk_type is on pick target profile and
 	 * return, otherwise do the usual balance
 	 */
-	stripped = btrfs_get_restripe_target(fs_info, flags);
+	stripped = get_restripe_target(fs_info, flags);
 	if (stripped)
 		return extended_to_chunk(stripped);
 
@@ -1953,81 +2028,6 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	return flags;
 }
 
-/*
- * Mark block group @cache read-only, so later write won't happen to block
- * group @cache.
- *
- * If @force is not set, this function will only mark the block group readonly
- * if we have enough free space (1M) in other metadata/system block groups.
- * If @force is not set, this function will mark the block group readonly
- * without checking free space.
- *
- * NOTE: This function doesn't care if other block groups can contain all the
- * data in this block group. That check should be done by relocation routine,
- * not this function.
- */
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
-	/*
-	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
-	 *
-	 * Here we make sure if we mark this bg RO, we still have enough
-	 * free space as buffer (if min_allocable_bytes is not 0).
-	 */
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
@@ -2077,14 +2077,14 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
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
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 2647c0aa76b8..6f4658b1ec94 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -169,7 +169,6 @@ static inline int btrfs_should_fragment_free_space(
 	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
 		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
 }
-void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group);
 #endif
 
 struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
@@ -249,9 +248,4 @@ static inline int btrfs_block_group_cache_done(
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
2.21.0

