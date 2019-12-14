Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD211EF2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLNAXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:23:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36695 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfLNAW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:58 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so413100pjc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Lmw3HBf9MlYhRbq1RJVKQ8gOWi+x8st2YKXVQqa8Q5k=;
        b=Lk55gfYarQx0y4d/sbToc7vc23fhSQn9KZbGs2eBJkG9i/9JWhQ4njivxYKOKbGVSU
         Ge8KwedEjg2VmspNzhWoHbisOpp2+Um1jpRgs8qkyADEUbuI1wfBneg7EhMXIYgWMkza
         U0g7ZeCJOtFlz0L0RwHAe/e3JZUaW7WO1YsanzMmuAGMhz8jtssiyjquR1Hkc5vcEV9Q
         4w3eBagxrz4vo+UFpDBLosbby7I7HnSfQsbP1WadoOa3wncYl+voONOsZWND3HYtdHZd
         fEv9TOXinAj3K1u6QLitPvZdrJGdztR1ZoxMOH3IhLxs3eM8xKg0jHCtT+w4hVIEe3Mc
         iNyw==
X-Gm-Message-State: APjAAAVR0DMQ+hg0xjyYqhr/NbI1dw2hRcd743fQ0btAqxvfkeeo8O4L
        /3HW8rmok5cBkp4VzDEKxfXO2xHl3Wu9TQ==
X-Google-Smtp-Source: APXvYqzoNkCyIM+o68S4WOVXR3Rpb4mhxYRPcpwza+1URLeKc76SIQsNi4+NWu7GKAhxPHNV0Zb1Rw==
X-Received: by 2002:a17:90a:94c1:: with SMTP id j1mr2668346pjw.2.1576282977471;
        Fri, 13 Dec 2019 16:22:57 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:56 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 17/22] btrfs: have multiple discard lists
Date:   Fri, 13 Dec 2019 16:22:26 -0800
Message-Id: <788264998489b69ad464e7f8b442d739ae21fc79.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            |   2 +-
 fs/btrfs/discard.c          | 100 +++++++++++++++++++++++++++++++++---
 fs/btrfs/discard.h          |   6 +++
 fs/btrfs/free-space-cache.c |  53 ++++++++++++++-----
 fs/btrfs/free-space-cache.h |   2 +-
 5 files changed, 140 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bf93ddbc773f..dddf51e27bed 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -457,7 +457,7 @@ struct btrfs_full_stripe_locks_tree {
  * afterwards represent monotonically decreasing discard filter sizes to
  * prioritize what should be discarded next.
  */
-#define BTRFS_NR_DISCARD_LISTS		2
+#define BTRFS_NR_DISCARD_LISTS		3
 #define BTRFS_DISCARD_INDEX_UNUSED	0
 #define BTRFS_DISCARD_INDEX_START	1
 
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index dd5143f0283f..884dffd28596 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -21,6 +21,10 @@
 #define BTRFS_DISCARD_MAX_DELAY		(10000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(10UL)
 
+/* Montonically decreasing minimum length filters after index 0. */
+static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {0,
+	BTRFS_ASYNC_DISCARD_MAX_FILTER, BTRFS_ASYNC_DISCARD_MIN_FILTER};
+
 static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 					  struct btrfs_block_group *block_group)
 {
@@ -140,16 +144,18 @@ static struct btrfs_block_group *find_next_block_group(
  * peek_discard_list - wrap find_next_block_group()
  * @discard_ctl: discard control
  * @discard_state: the discard_state of the block_group after state management
+ * @discard_index: the discard_index of the block_group after state management
  *
  * This wraps find_next_block_group() and sets the block_group to be in use.
  * discard_state's control flow is managed here.  Variables related to
  * discard_state are reset here as needed (eg discard_cursor).  @discard_state
- * is remembered as it may change while we're discarding, but we want the
- * discard to execute in the context determined here.
+ * and @discard_index are remembered as it may change while we're discarding,
+ * but we want the discard to execute in the context determined here.
  */
 static struct btrfs_block_group *peek_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
-					enum btrfs_discard_state *discard_state)
+					enum btrfs_discard_state *discard_state,
+					int *discard_index)
 {
 	struct btrfs_block_group *block_group;
 	u64 now = ktime_get_ns();
@@ -171,6 +177,7 @@ static struct btrfs_block_group *peek_discard_list(
 		}
 		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
+		*discard_index = block_group->discard_index;
 	} else {
 		block_group = NULL;
 	}
@@ -180,6 +187,64 @@ static struct btrfs_block_group *peek_discard_list(
 	return block_group;
 }
 
+/**
+ * btrfs_discard_check_filter - updates a block groups filters
+ * @block_group: block group of interest
+ * @bytes: recently freed region size after coalescing
+ *
+ * Async discard maintains multiple lists with progressively smaller filters
+ * to prioritize discarding based on size.  Should a free space that matches
+ * a larger filter be returned to the free_space_cache, prioritize that discard
+ * by moving @block_group to the proper filter.
+ */
+void btrfs_discard_check_filter(struct btrfs_block_group *block_group,
+				u64 bytes)
+{
+	struct btrfs_discard_ctl *discard_ctl;
+
+	if (!block_group ||
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+		return;
+
+	discard_ctl = &block_group->fs_info->discard_ctl;
+
+	if (block_group->discard_index > BTRFS_DISCARD_INDEX_START &&
+	    bytes >= discard_minlen[block_group->discard_index - 1]) {
+		int i;
+
+		remove_from_discard_list(discard_ctl, block_group);
+
+		for (i = BTRFS_DISCARD_INDEX_START; i < BTRFS_NR_DISCARD_LISTS;
+		     i++) {
+			if (bytes >= discard_minlen[i]) {
+				block_group->discard_index = i;
+				add_to_discard_list(discard_ctl, block_group);
+				break;
+			}
+		}
+	}
+}
+
+/**
+ * btrfs_update_discard_index - moves a block_group along the discard lists
+ * @discard_ctl: discard control
+ * @block_group: block_group of interest
+ *
+ * Increment @block_group's discard_index.  If it falls of the list, let it be.
+ * Otherwise add it back to the appropriate list.
+ */
+static void btrfs_update_discard_index(struct btrfs_discard_ctl *discard_ctl,
+				       struct btrfs_block_group *block_group)
+{
+	block_group->discard_index++;
+	if (block_group->discard_index == BTRFS_NR_DISCARD_LISTS) {
+		block_group->discard_index = 1;
+		return;
+	}
+
+	add_to_discard_list(discard_ctl, block_group);
+}
+
 /**
  * btrfs_discard_cancel_work - remove a block_group from the discard lists
  * @discard_ctl: discard control
@@ -300,6 +365,8 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 			btrfs_mark_bg_unused(block_group);
 		else
 			add_to_discard_unused_list(discard_ctl, block_group);
+	} else {
+		btrfs_update_discard_index(discard_ctl, block_group);
 	}
 }
 
@@ -316,25 +383,42 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	struct btrfs_discard_ctl *discard_ctl;
 	struct btrfs_block_group *block_group;
 	enum btrfs_discard_state discard_state;
+	int discard_index = 0;
 	u64 trimmed = 0;
+	u64 minlen = 0;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
-	block_group = peek_discard_list(discard_ctl, &discard_state);
+	block_group = peek_discard_list(discard_ctl, &discard_state,
+					&discard_index);
 	if (!block_group || !btrfs_run_discard_work(discard_ctl))
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
 		btrfs_trim_block_group_bitmaps(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
-				       0, true);
-	else
+				       minlen, maxlen, true);
+	} else {
 		btrfs_trim_block_group_extents(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
-				       0, true);
+				       minlen, true);
+	}
 
 	discard_ctl->prev_discard = trimmed;
 
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index cb6ef0ab879d..91d5eb8e8bd9 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -11,6 +11,12 @@ struct btrfs_block_group;
 
 /* Discard size limits. */
 #define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+#define BTRFS_ASYNC_DISCARD_MAX_FILTER	(SZ_1M)
+#define BTRFS_ASYNC_DISCARD_MIN_FILTER	(SZ_32K)
+
+/* List operations. */
+void btrfs_discard_check_filter(struct btrfs_block_group *block_group,
+				u64 bytes);
 
 /* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e5bb37627807..c9bf0207960d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2466,6 +2466,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group *block_group = ctl->private;
 	struct btrfs_free_space *info;
 	int ret = 0;
+	u64 filter_bytes = bytes;
 
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
@@ -2502,6 +2503,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	 */
 	steal_from_bitmap(ctl, info, true);
 
+	filter_bytes = max(filter_bytes, info->bytes);
+
 	ret = link_free_space(ctl, info);
 	if (ret)
 		kmem_cache_free(btrfs_free_space_cachep, info);
@@ -2514,8 +2517,10 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 		ASSERT(ret != -EEXIST);
 	}
 
-	if (trim_state != BTRFS_TRIM_STATE_TRIMMED)
+	if (trim_state != BTRFS_TRIM_STATE_TRIMMED) {
+		btrfs_discard_check_filter(block_group, filter_bytes);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
+	}
 
 	return ret;
 }
@@ -3479,7 +3484,14 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3589,7 +3601,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
  */
 static int trim_bitmaps(struct btrfs_block_group *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
-			bool async)
+			u64 maxlen, bool async)
 {
 	struct btrfs_discard_ctl *discard_ctl =
 					&block_group->fs_info->discard_ctl;
@@ -3617,7 +3629,15 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3638,10 +3658,10 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3662,14 +3682,20 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3776,7 +3802,7 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	if (ret)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, false);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, 0, false);
 	div64_u64_rem(end, BITS_PER_BITMAP * ctl->unit, &rem);
 	/* If we ended in the middle of a bitmap, reset the trimming flag. */
 	if (rem)
@@ -3810,7 +3836,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async)
+				   u64 maxlen, bool async)
 {
 	int ret;
 
@@ -3824,7 +3850,8 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 	btrfs_get_block_group_trimming(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, async);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
+			   async);
 
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 600633ed403b..e305fa0117d1 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -146,7 +146,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 				   bool async);
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async);
+				   u64 maxlen, bool async);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

