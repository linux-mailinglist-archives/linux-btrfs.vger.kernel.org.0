Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8595BE26B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436960AbfJWWxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42964 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436937AbfJWWxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so34720833qto.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lX9FOONTj5msGOtE7JTjLUUHfskPijAQYi6iH1byrYQ=;
        b=YZIUnOGb9ZWDAy5mJlbjExv9ALMes1kBk0Y6r2W/ib3AlVhJSobrI6IMwYepG7SXCj
         iPzj6+mXQC9gQYiCtS1Dm3sk1GEXLZUcFc+EkMAn+VWlHjWXV3sfbf3iNtn5xuVvGiQy
         Av/B/vi/dH3nf81P4Rs4CchZIsh6cUZRG4m9P+y402tizFGplg1fv5m/MOvJygn8KPc8
         NlNvxWUZg/RkqsOJS9C3oULcjf0CRI7yoZVZTPfvrGpG3mseCO54ycH3V9+kRJdw98B1
         sdMnVDGN6BhGstZoM9BUSMnZPfi3zFUeDvG5oB2wOX+8JpVMWL+5M7/vxk5q+SJF/NkS
         FJKQ==
X-Gm-Message-State: APjAAAW8KQhYpBHWVKFqGwOXRVBaEiEUBxbXm5q27xbgcnw76FIv40lW
        xgaYQw/UiIR9AU6RO1SeRM4=
X-Google-Smtp-Source: APXvYqwZzxXkMkw4tfBUB6A3+HTUgZcBQGP0i7HTdDZnJ5XVCWkmnD3ehtz/B9g3fBzNtk7cnqD1tw==
X-Received: by 2002:ac8:411b:: with SMTP id q27mr1159179qtl.53.1571871218959;
        Wed, 23 Oct 2019 15:53:38 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:38 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 17/22] btrfs: have multiple discard lists
Date:   Wed, 23 Oct 2019 18:53:11 -0400
Message-Id: <9affe695998972620340031ccc95caac909bfe4b.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Non-block group destruction discarding currently only had a single list
with no minimum discard length. This can lead to caravaning more
meaningful discards behind a heavily fragmented block group.

This adds support for multiple lists with minimum discard lengths to
prevent the caravan effect. We promote block groups back up when we
exceed the BTRFS_ASYNC_DISCARD_MAX_FILTER size, currently we support
only 2 lists with filters of 1MB and 32KB respectively.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/discard.c          | 98 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/discard.h          |  4 ++
 fs/btrfs/free-space-cache.c | 53 +++++++++++++++-----
 fs/btrfs/free-space-cache.h |  2 +-
 5 files changed, 136 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a87970c7117..57cfc0e11c53 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -455,7 +455,7 @@ struct btrfs_full_stripe_locks_tree {
  * afterwards represent monotonically decreasing discard filter sizes to
  * prioritize what should be discarded next.
  */
-#define BTRFS_NR_DISCARD_LISTS		2
+#define BTRFS_NR_DISCARD_LISTS		3
 #define BTRFS_DISCARD_INDEX_UNUSED	0
 #define BTRFS_DISCARD_INDEX_START	1
 
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index f7799b659d39..592a5c7b9dc1 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -21,6 +21,10 @@
 #define BTRFS_DISCARD_MAX_DELAY		(10000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(10UL)
 
+/* Montonically decreasing minimum length filters after index 0. */
+static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {0,
+	BTRFS_ASYNC_DISCARD_MAX_FILTER, BTRFS_ASYNC_DISCARD_MIN_FILTER};
+
 static struct list_head *btrfs_get_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
 					struct btrfs_block_group_cache *cache)
@@ -133,16 +137,18 @@ static struct btrfs_block_group_cache *find_next_cache(
  * peek_discard_list - wrap find_next_cache()
  * @discard_ctl: discard control
  * @discard_state: the discard_state of the block_group after state management
+ * @discard_index: the discard_index of the block_group after state management
  *
  * This wraps find_next_cache() and sets the cache to be in use.
  * discard_state's control flow is managed here.  Variables related to
  * discard_state are reset here as needed (eg discard_cursor).  @discard_state
- * is remembered as it may change while we're discarding, but we want the
- * discard to execute in the context determined here.
+ * and @discard_index are remembered as it may change while we're discarding,
+ * but we want the discard to execute in the context determined here.
  */
 static struct btrfs_block_group_cache *peek_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
-					enum btrfs_discard_state *discard_state)
+					enum btrfs_discard_state *discard_state,
+					int *discard_index)
 {
 	struct btrfs_block_group_cache *cache;
 	u64 now = ktime_get_ns();
@@ -164,6 +170,7 @@ static struct btrfs_block_group_cache *peek_discard_list(
 		}
 		discard_ctl->cache = cache;
 		*discard_state = cache->discard_state;
+		*discard_index = cache->discard_index;
 	} else {
 		cache = NULL;
 	}
@@ -173,6 +180,63 @@ static struct btrfs_block_group_cache *peek_discard_list(
 	return cache;
 }
 
+/**
+ * btrfs_discard_check_filter - updates a block groups filters
+ * @cache: block group of interest
+ * @bytes: recently freed region size after coalescing
+ *
+ * Async discard maintains multiple lists with progressively smaller filters
+ * to prioritize discarding based on size.  Should a free space that matches
+ * a larger filter be returned to the free_space_cache, prioritize that discard
+ * by moving @cache to the proper filter.
+ */
+void btrfs_discard_check_filter(struct btrfs_block_group_cache *cache,
+				u64 bytes)
+{
+	struct btrfs_discard_ctl *discard_ctl;
+
+	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
+		return;
+
+	discard_ctl = &cache->fs_info->discard_ctl;
+
+	if (cache->discard_index > BTRFS_DISCARD_INDEX_START &&
+	    bytes >= discard_minlen[cache->discard_index - 1]) {
+		int i;
+
+		remove_from_discard_list(discard_ctl, cache);
+
+		for (i = BTRFS_DISCARD_INDEX_START; i < BTRFS_NR_DISCARD_LISTS;
+		     i++) {
+			if (bytes >= discard_minlen[i]) {
+				cache->discard_index = i;
+				btrfs_add_to_discard_list(discard_ctl, cache);
+				break;
+			}
+		}
+	}
+}
+
+/**
+ * btrfs_update_discard_index - moves a block_group along the discard lists
+ * @discard_ctl: discard control
+ * @cache: block_group of interest
+ *
+ * Increment @cache's discard_index.  If it falls of the list, let it be.
+ * Otherwise add it back to the appropriate list.
+ */
+static void btrfs_update_discard_index(struct btrfs_discard_ctl *discard_ctl,
+				       struct btrfs_block_group_cache *cache)
+{
+	cache->discard_index++;
+	if (cache->discard_index == BTRFS_NR_DISCARD_LISTS) {
+		cache->discard_index = 1;
+		return;
+	}
+
+	btrfs_add_to_discard_list(discard_ctl, cache);
+}
+
 /**
  * btrfs_discard_cancel_work - remove a block_group from the discard lists
  * @discard_ctl: discard control
@@ -289,6 +353,8 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 			btrfs_mark_bg_unused(cache);
 		else
 			btrfs_add_to_discard_unused_list(discard_ctl, cache);
+	} else {
+		btrfs_update_discard_index(discard_ctl, cache);
 	}
 }
 
@@ -305,25 +371,41 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	struct btrfs_discard_ctl *discard_ctl;
 	struct btrfs_block_group_cache *cache;
 	enum btrfs_discard_state discard_state;
+	int discard_index = 0;
 	u64 trimmed = 0;
+	u64 minlen = 0;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
-	cache = peek_discard_list(discard_ctl, &discard_state);
+	cache = peek_discard_list(discard_ctl, &discard_state, &discard_index);
 	if (!cache || !btrfs_run_discard_work(discard_ctl))
 		return;
 
 	/* Perform discarding. */
-	if (discard_state == BTRFS_DISCARD_BITMAPS)
+	minlen = discard_minlen[discard_index];
+
+	if (discard_state == BTRFS_DISCARD_BITMAPS) {
+		u64 maxlen = 0;
+
+		/*
+		 * Use the previous levels minimum discard length as the max
+		 * length filter.  In the case something is added to make a
+		 * region go beyond the max filter, the entire bitmap is set
+		 * back to BTRFS_TRIM_STATE_UNTRIMMED.
+		 */
+		if (discard_index != BTRFS_DISCARD_INDEX_UNUSED)
+			maxlen = discard_minlen[discard_index - 1];
+
 		btrfs_trim_block_group_bitmaps(cache, &trimmed,
 					       cache->discard_cursor,
 					       btrfs_block_group_end(cache),
-					       0, true);
-	else
+					       minlen, maxlen, true);
+	} else {
 		btrfs_trim_block_group_extents(cache, &trimmed,
 					       cache->discard_cursor,
 					       btrfs_block_group_end(cache),
-					       0, true);
+					       minlen, true);
+	}
 
 	discard_ctl->prev_discard = trimmed;
 
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index c1e745196b6c..d24a6fd389f8 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -13,12 +13,16 @@ struct btrfs_block_group_cache;
 
 /* Discard size limits. */
 #define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+#define BTRFS_ASYNC_DISCARD_MAX_FILTER	(SZ_1M)
+#define BTRFS_ASYNC_DISCARD_MIN_FILTER	(SZ_32K)
 
 /* List operations. */
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
 void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 				      struct btrfs_block_group_cache *cache);
+void btrfs_discard_check_filter(struct btrfs_block_group_cache *cache,
+				u64 bytes);
 
 /* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c62346b23ca0..dc632afe5f61 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2463,6 +2463,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group_cache *cache = ctl->private;
 	struct btrfs_free_space *info;
 	int ret = 0;
+	u64 filter_bytes = bytes;
 
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
@@ -2499,6 +2500,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	 */
 	steal_from_bitmap(ctl, info, true);
 
+	filter_bytes = max(filter_bytes, info->bytes);
+
 	ret = link_free_space(ctl, info);
 	if (ret)
 		kmem_cache_free(btrfs_free_space_cachep, info);
@@ -2511,8 +2514,10 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 		ASSERT(ret != -EEXIST);
 	}
 
-	if (trim_state != BTRFS_TRIM_STATE_TRIMMED)
+	if (trim_state != BTRFS_TRIM_STATE_TRIMMED) {
+		btrfs_discard_check_filter(cache, filter_bytes);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, cache);
+	}
 
 	return ret;
 }
@@ -3453,7 +3458,14 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 				goto next;
 			}
 			unlink_free_space(ctl, entry);
-			if (max_discard_size && bytes > max_discard_size) {
+			/*
+			 * Let bytes = BTRFS_MAX_DISCARD_SIZE + X.
+			 * If X < BTRFS_ASYNC_DISCARD_MIN_FILTER, we won't trim
+			 * X when we come back around.  So trim it now.
+			 */
+			if (max_discard_size &&
+			    bytes >= (max_discard_size +
+				      BTRFS_ASYNC_DISCARD_MIN_FILTER)) {
 				bytes = extent_bytes = max_discard_size;
 				entry->offset += max_discard_size;
 				entry->bytes -= max_discard_size;
@@ -3563,7 +3575,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
  */
 static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
-			bool async)
+			u64 maxlen, bool async)
 {
 	struct btrfs_discard_ctl *discard_ctl =
 					&block_group->fs_info->discard_ctl;
@@ -3591,7 +3603,15 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		}
 
 		entry = tree_search_offset(ctl, offset, 1, 0);
-		if (!entry || (async && start == offset &&
+		/*
+		 * Bitmaps are marked trimmed lossily now to prevent constant
+		 * discarding of the same bitmap (the reason why we are bound
+		 * by the filters).  So, retrim the block group bitmaps when we
+		 * are preparing to punt to the unused_bgs list.  This uses
+		 * @minlen to determine if we are in BTRFS_DISCARD_INDEX_UNUSED
+		 * which is the only discard index which sets minlen to 0.
+		 */
+		if (!entry || (async && minlen && start == offset &&
 			       btrfs_free_space_trimmed(entry))) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
@@ -3612,10 +3632,10 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		ret2 = search_bitmap(ctl, entry, &start, &bytes, false);
 		if (ret2 || start >= end) {
 			/*
-			 * This keeps the invariant that all bytes are trimmed
-			 * if BTRFS_TRIM_STATE_TRIMMED is set on a bitmap.
+			 * We lossily consider a bitmap trimmed if we only skip
+			 * over regions <= BTRFS_ASYNC_DISCARD_MIN_FILTER.
 			 */
-			if (ret2 && !minlen)
+			if (ret2 && minlen <= BTRFS_ASYNC_DISCARD_MIN_FILTER)
 				end_trimming_bitmap(ctl, entry);
 			else
 				entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
@@ -3636,14 +3656,20 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		}
 
 		bytes = min(bytes, end - start);
-		if (bytes < minlen) {
-			entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+		if (bytes < minlen || (async && maxlen && bytes > maxlen)) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			goto next;
 		}
 
-		if (async && max_discard_size && bytes > max_discard_size)
+		/*
+		 * Let bytes = BTRFS_MAX_DISCARD_SIZE + X.
+		 * If X < @minlen, we won't trim X when we come back around.
+		 * So trim it now.  We differ here from trimming extents as we
+		 * don't keep individual state per bit.
+		 */
+		if (async && max_discard_size &&
+		    bytes > (max_discard_size + minlen))
 			bytes = max_discard_size;
 
 		bitmap_clear_bits(ctl, entry, start, bytes);
@@ -3749,7 +3775,7 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 	if (ret)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, false);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, 0, false);
 	/* If we ended in the middle of a bitmap, reset the trimming flag. */
 	if (end % (BITS_PER_BITMAP * ctl->unit))
 		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
@@ -3782,7 +3808,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group_cache *block_group,
 
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async)
+				   u64 maxlen, bool async)
 {
 	int ret;
 
@@ -3796,7 +3822,8 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
 	btrfs_get_block_group_trimming(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, async);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
+			   async);
 
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 1c0ec98da529..d3a7c9228409 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -146,7 +146,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group_cache *block_group,
 				   bool async);
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async);
+				   u64 maxlen, bool async);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

