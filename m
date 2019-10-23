Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF356E26A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436915AbfJWWx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39250 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436901AbfJWWx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id t8so17195953qtc.6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=I5D7zeCK3skC/0CQU3ERlVM5KltEkL33eq82KgwGTQA=;
        b=IU19R56IrelWC6ivtJMXIWr8XM6zKPSFFp1KpLg17IwJm0fDsgABxXYezkOHPIdUEq
         ncR+zTdJP8BkYzgzADtY1m/ne4JjLWgSKhzS5VVn4xqrolHvsVoBcdeL1UN+0pC+HhHV
         +qE01EDGJnBA9BV16pakIWXJxWmUeWXlCONkzKut9ZhbMo8QpVvlGdYKWurMXmrajBmz
         uQztnLmQ1k24EBkL+eYm7VSNRxWg9q9TcmnMqViReGLQY0XdNJyiMw0WwRpxhipS18D1
         LGi87K3NpGAmPH6lLHF0q/v7EbR4IFhrEomKnlh4h+ftzMF5DCqf9sfvY+x1AhOzx/yk
         0u4w==
X-Gm-Message-State: APjAAAWvWnb/Sxxvay9pKNZbGnq1BUIg0o/bY/32qEAe6LmQZZRzwM3f
        ZouHfo7hDaNqSsD4u0zqYwo=
X-Google-Smtp-Source: APXvYqxo9wfIL5IbYLx2wIg5Y6Zvek6lal+8X7EA0JWDi57CyL8MxNYEBxbCOwtMp2JGQM+OiY2utQ==
X-Received: by 2002:a0c:8b57:: with SMTP id d23mr11895806qvc.159.1571871207695;
        Wed, 23 Oct 2019 15:53:27 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:26 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/22] btrfs: discard one region at a time in async discard
Date:   Wed, 23 Oct 2019 18:53:01 -0400
Message-Id: <6ab77d726e93f19b26858ca8c2248ae249701e71.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The prior two patches added discarding via a background workqueue. This
just piggybacked off of the fstrim code to trim the whole block at once.
Well inevitably this is worse performance wise and will aggressively
overtrim. But it was nice to plumb the other infrastructure to keep the
patches easier to review.

This adds the real goal of this series which is discarding slowly (ie a
slow long running fstrim). The discarding is split into two phases,
extents and then bitmaps. The reason for this is two fold. First, the
bitmap regions overlap the extent regions. Second, discarding the
extents first will let the newly trimmed bitmaps have the highest chance
of coalescing when being readded to the free space cache.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/block-group.h      |  15 +++++
 fs/btrfs/discard.c          |  79 ++++++++++++++++++----
 fs/btrfs/free-space-cache.c | 130 ++++++++++++++++++++++++++++--------
 fs/btrfs/free-space-cache.h |   6 ++
 4 files changed, 188 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 633dce5b9d57..88266cc16c07 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -12,6 +12,19 @@ enum btrfs_disk_cache_state {
 	BTRFS_DC_SETUP,
 };
 
+/*
+ * This describes the state of the block_group for async discard.  This is due
+ * to the two pass nature of it where extent discarding is prioritized over
+ * bitmap discarding.  BTRFS_DISCARD_RESET_CURSOR is set when we are resetting
+ * between lists to prevent contention for discard state variables
+ * (eg discard_cursor).
+ */
+enum btrfs_discard_state {
+	BTRFS_DISCARD_EXTENTS,
+	BTRFS_DISCARD_BITMAPS,
+	BTRFS_DISCARD_RESET_CURSOR,
+};
+
 /*
  * Control flags for do_chunk_alloc's force field CHUNK_ALLOC_NO_FORCE means to
  * only allocate a chunk if we really need one.
@@ -120,6 +133,8 @@ struct btrfs_block_group_cache {
 	struct list_head discard_list;
 	int discard_index;
 	u64 discard_eligible_time;
+	u64 discard_cursor;
+	enum btrfs_discard_state discard_state;
 
 	/* For dirty block groups */
 	struct list_head dirty_list;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 5b5be658c397..e50728061658 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -23,21 +23,28 @@ static struct list_head *btrfs_get_discard_list(
 	return &discard_ctl->discard_list[cache->discard_index];
 }
 
-void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
-			       struct btrfs_block_group_cache *cache)
+static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+					struct btrfs_block_group_cache *cache)
 {
-	spin_lock(&discard_ctl->lock);
-
 	if (list_empty(&cache->discard_list) ||
 	    cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
 		if (cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED)
 			cache->discard_index = BTRFS_DISCARD_INDEX_START;
 		cache->discard_eligible_time = (ktime_get_ns() +
 						BTRFS_DISCARD_DELAY);
+		cache->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	}
 
 	list_move_tail(&cache->discard_list,
 		       btrfs_get_discard_list(discard_ctl, cache));
+}
+
+void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group_cache *cache)
+{
+	spin_lock(&discard_ctl->lock);
+
+	__btrfs_add_to_discard_list(discard_ctl, cache);
 
 	spin_unlock(&discard_ctl->lock);
 }
@@ -52,6 +59,7 @@ void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 
 	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 	cache->discard_eligible_time = ktime_get_ns();
+	cache->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	list_add_tail(&cache->discard_list,
 		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
 
@@ -119,23 +127,41 @@ static struct btrfs_block_group_cache *find_next_cache(
 /**
  * peek_discard_list - wrap find_next_cache()
  * @discard_ctl: discard control
+ * @discard_state: the discard_state of the block_group after state management
  *
  * This wraps find_next_cache() and sets the cache to be in use.
+ * discard_state's control flow is managed here.  Variables related to
+ * discard_state are reset here as needed (eg discard_cursor).  @discard_state
+ * is remembered as it may change while we're discarding, but we want the
+ * discard to execute in the context determined here.
  */
 static struct btrfs_block_group_cache *peek_discard_list(
-					struct btrfs_discard_ctl *discard_ctl)
+					struct btrfs_discard_ctl *discard_ctl,
+					enum btrfs_discard_state *discard_state)
 {
 	struct btrfs_block_group_cache *cache;
 	u64 now = ktime_get_ns();
 
 	spin_lock(&discard_ctl->lock);
 
+again:
 	cache = find_next_cache(discard_ctl, now);
 
-	if (cache && now < cache->discard_eligible_time)
+	if (cache && now > cache->discard_eligible_time) {
+		if (cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
+		    btrfs_block_group_used(&cache->item) != 0) {
+			__btrfs_add_to_discard_list(discard_ctl, cache);
+			goto again;
+		}
+		if (cache->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
+			cache->discard_cursor = cache->key.objectid;
+			cache->discard_state = BTRFS_DISCARD_EXTENTS;
+		}
+		discard_ctl->cache = cache;
+		*discard_state = cache->discard_state;
+	} else {
 		cache = NULL;
-
-	discard_ctl->cache = cache;
+	}
 
 	spin_unlock(&discard_ctl->lock);
 
@@ -246,24 +272,51 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
  * btrfs_discard_workfn - discard work function
  * @work: work
  *
- * This finds the next cache to start discarding and then discards it.
+ * This finds the next cache to start discarding and then discards a single
+ * region.  It does this in a two-pass fashion: first extents and second
+ * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
  */
 static void btrfs_discard_workfn(struct work_struct *work)
 {
 	struct btrfs_discard_ctl *discard_ctl;
 	struct btrfs_block_group_cache *cache;
+	enum btrfs_discard_state discard_state;
 	u64 trimmed = 0;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
-	cache = peek_discard_list(discard_ctl);
+	cache = peek_discard_list(discard_ctl, &discard_state);
 	if (!cache || !btrfs_run_discard_work(discard_ctl))
 		return;
 
-	btrfs_trim_block_group(cache, &trimmed, cache->key.objectid,
-			       btrfs_block_group_end(cache), 0);
+	/* Perform discarding. */
+	if (discard_state == BTRFS_DISCARD_BITMAPS)
+		btrfs_trim_block_group_bitmaps(cache, &trimmed,
+					       cache->discard_cursor,
+					       btrfs_block_group_end(cache),
+					       0, true);
+	else
+		btrfs_trim_block_group_extents(cache, &trimmed,
+					       cache->discard_cursor,
+					       btrfs_block_group_end(cache),
+					       0, true);
+
+	/* Determine next steps for a block_group. */
+	if (cache->discard_cursor >= btrfs_block_group_end(cache)) {
+		if (discard_state == BTRFS_DISCARD_BITMAPS) {
+			btrfs_finish_discard_pass(discard_ctl, cache);
+		} else {
+			cache->discard_cursor = cache->key.objectid;
+			spin_lock(&discard_ctl->lock);
+			if (cache->discard_state != BTRFS_DISCARD_RESET_CURSOR)
+				cache->discard_state = BTRFS_DISCARD_BITMAPS;
+			spin_unlock(&discard_ctl->lock);
+		}
+	}
 
-	btrfs_finish_discard_pass(discard_ctl, cache);
+	spin_lock(&discard_ctl->lock);
+	discard_ctl->cache = NULL;
+	spin_unlock(&discard_ctl->lock);
 
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 80a205449547..f840bc126cac 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3299,8 +3299,12 @@ static int do_trimming(struct btrfs_block_group_cache *block_group,
 	return ret;
 }
 
+/*
+ * If @async is set, then we will trim 1 region and return.
+ */
 static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
-			  u64 *total_trimmed, u64 start, u64 end, u64 minlen)
+			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
+			  bool async)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
@@ -3317,36 +3321,24 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 		mutex_lock(&ctl->cache_writeout_mutex);
 		spin_lock(&ctl->tree_lock);
 
-		if (ctl->free_space < minlen) {
-			spin_unlock(&ctl->tree_lock);
-			mutex_unlock(&ctl->cache_writeout_mutex);
-			break;
-		}
+		if (ctl->free_space < minlen)
+			goto out_unlock;
 
 		entry = tree_search_offset(ctl, start, 0, 1);
-		if (!entry) {
-			spin_unlock(&ctl->tree_lock);
-			mutex_unlock(&ctl->cache_writeout_mutex);
-			break;
-		}
+		if (!entry)
+			goto out_unlock;
 
-		/* skip bitmaps */
-		while (entry->bitmap) {
+		/* skip bitmaps and already trimmed entries */
+		while (entry->bitmap || btrfs_free_space_trimmed(entry)) {
 			node = rb_next(&entry->offset_index);
-			if (!node) {
-				spin_unlock(&ctl->tree_lock);
-				mutex_unlock(&ctl->cache_writeout_mutex);
-				goto out;
-			}
+			if (!node)
+				goto out_unlock;
 			entry = rb_entry(node, struct btrfs_free_space,
 					 offset_index);
 		}
 
-		if (entry->offset >= end) {
-			spin_unlock(&ctl->tree_lock);
-			mutex_unlock(&ctl->cache_writeout_mutex);
-			break;
-		}
+		if (entry->offset >= end)
+			goto out_unlock;
 
 		extent_start = entry->offset;
 		extent_bytes = entry->bytes;
@@ -3371,10 +3363,15 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
 				  extent_start, extent_bytes, extent_trim_state,
 				  &trim_entry);
-		if (ret)
+		if (ret) {
+			block_group->discard_cursor = start + bytes;
 			break;
+		}
 next:
 		start += bytes;
+		block_group->discard_cursor = start;
+		if (async && *total_trimmed)
+			break;
 
 		if (fatal_signal_pending(current)) {
 			ret = -ERESTARTSYS;
@@ -3383,7 +3380,14 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 
 		cond_resched();
 	}
-out:
+
+	return ret;
+
+out_unlock:
+	block_group->discard_cursor = btrfs_block_group_end(block_group);
+	spin_unlock(&ctl->tree_lock);
+	mutex_unlock(&ctl->cache_writeout_mutex);
+
 	return ret;
 }
 
@@ -3420,8 +3424,12 @@ static void end_trimming_bitmap(struct btrfs_free_space *entry)
 		entry->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 }
 
+/*
+ * If @async is set, then we will trim 1 region and return.
+ */
 static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
-			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
+			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
+			bool async)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
@@ -3438,13 +3446,16 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		spin_lock(&ctl->tree_lock);
 
 		if (ctl->free_space < minlen) {
+			block_group->discard_cursor =
+				btrfs_block_group_end(block_group);
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			break;
 		}
 
 		entry = tree_search_offset(ctl, offset, 1, 0);
-		if (!entry || btrfs_free_space_trimmed(entry)) {
+		if (!entry || (async && start == offset &&
+			       btrfs_free_space_trimmed(entry))) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			next_bitmap = true;
@@ -3477,6 +3488,16 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			goto next;
 		}
 
+		/*
+		 * We already trimmed a region, but are using the locking above
+		 * to reset the trim_state.
+		 */
+		if (async && *total_trimmed) {
+			spin_unlock(&ctl->tree_lock);
+			mutex_unlock(&ctl->cache_writeout_mutex);
+			return ret;
+		}
+
 		bytes = min(bytes, end - start);
 		if (bytes < minlen) {
 			entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
@@ -3499,6 +3520,8 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 				  start, bytes, 0, &trim_entry);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
+			block_group->discard_cursor =
+				btrfs_block_group_end(block_group);
 			break;
 		}
 next:
@@ -3508,6 +3531,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		} else {
 			start += bytes;
 		}
+		block_group->discard_cursor = start;
 
 		if (fatal_signal_pending(current)) {
 			if (start != offset)
@@ -3519,6 +3543,9 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		cond_resched();
 	}
 
+	if (offset >= end)
+		block_group->discard_cursor = end;
+
 	return ret;
 }
 
@@ -3578,11 +3605,11 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 	btrfs_get_block_group_trimming(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen);
+	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, false);
 	if (ret)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, false);
 	/* If we ended in the middle of a bitmap, reset the trimming flag. */
 	if (end % (BITS_PER_BITMAP * ctl->unit))
 		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
@@ -3591,6 +3618,51 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 	return ret;
 }
 
+int btrfs_trim_block_group_extents(struct btrfs_block_group_cache *block_group,
+				   u64 *trimmed, u64 start, u64 end, u64 minlen,
+				   bool async)
+{
+	int ret;
+
+	*trimmed = 0;
+
+	spin_lock(&block_group->lock);
+	if (block_group->removed) {
+		spin_unlock(&block_group->lock);
+		return 0;
+	}
+	btrfs_get_block_group_trimming(block_group);
+	spin_unlock(&block_group->lock);
+
+	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, async);
+
+	btrfs_put_block_group_trimming(block_group);
+	return ret;
+}
+
+int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
+				   u64 *trimmed, u64 start, u64 end, u64 minlen,
+				   bool async)
+{
+	int ret;
+
+	*trimmed = 0;
+
+	spin_lock(&block_group->lock);
+	if (block_group->removed) {
+		spin_unlock(&block_group->lock);
+		return 0;
+	}
+	btrfs_get_block_group_trimming(block_group);
+	spin_unlock(&block_group->lock);
+
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, async);
+
+	btrfs_put_block_group_trimming(block_group);
+	return ret;
+
+}
+
 /*
  * Find the left-most item in the cache tree, and then return the
  * smallest inode number in the item.
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e703f9e09461..316d349ec263 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -138,6 +138,12 @@ int btrfs_return_cluster_to_free_space(
 			       struct btrfs_free_cluster *cluster);
 int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen);
+int btrfs_trim_block_group_extents(struct btrfs_block_group_cache *block_group,
+				   u64 *trimmed, u64 start, u64 end, u64 minlen,
+				   bool async);
+int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
+				   u64 *trimmed, u64 start, u64 end, u64 minlen,
+				   bool async);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

