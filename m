Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623FC10946F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfKYTr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36225 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfKYTr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id y10so18593451qto.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=m42+SVlDX1xxBJPAROD+olbFWHE/VGYB2+b03wD93BU=;
        b=Mojky5S64L9C3jQMFg0ykRadpKX3JYmSeFpeR5nksx1yZXAhg/L/pHnhS1J1TB+BNy
         pvkYspMRsanKnPw0BLd6pU0WvTpO0xbe4sohb4S+hRZd/o+5QwHTBzrNTrXFWVPTIEqB
         MyX5kjSEJtZmTzfBmCQEcI/N+4BFTr5kmGE4/hd12EzH+RMCC8PRolZpaNDN7iqyJlnp
         QkhSozH3LR2pyGMAwYokDtlEEhMeVbP0/5pX6v6aKN+V8tHaKO7IdCatUHo+cmW1UY41
         sYMdXdGZ6KZ6jCYzhbAwcso8U/C6fhqfxIgRToE04mEbR8AYS+yQhg8xTC7wn2xlSGAo
         KFEw==
X-Gm-Message-State: APjAAAX6RomE4gKqOq3sNHHbkiIcrD9WvVv3PYEQlxQy7PxZd4KqXwcN
        CJGJTOtFIO5MZeo1XI5G6AI=
X-Google-Smtp-Source: APXvYqwNMPuJcQ2SCp/YUh+OsGBXRSki5jKhmFbLIRT9DMceEmRjDIy9F/iuQPAzicCYNbSq5T+uhw==
X-Received: by 2002:ac8:43cc:: with SMTP id w12mr31121771qtn.231.1574711246723;
        Mon, 25 Nov 2019 11:47:26 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:26 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 17/22] btrfs: have multiple discard lists
Date:   Mon, 25 Nov 2019 14:46:57 -0500
Message-Id: <bc5f1d9d242e5a8431492e5bddfa2c18e5266438.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
 fs/btrfs/discard.c          | 101 +++++++++++++++++++++++++++++++++---
 fs/btrfs/discard.h          |   4 ++
 fs/btrfs/free-space-cache.c |  53 ++++++++++++++-----
 fs/btrfs/free-space-cache.h |   2 +-
 5 files changed, 139 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 37ad60913092..52f69aaaa19c 100644
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
index 93e632267247..004d83b0a215 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -20,6 +20,10 @@
 #define BTRFS_DISCARD_MAX_DELAY		(10000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(10UL)
 
+/* Montonically decreasing minimum length filters after index 0. */
+static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {0,
+	BTRFS_ASYNC_DISCARD_MAX_FILTER, BTRFS_ASYNC_DISCARD_MIN_FILTER};
+
 static struct list_head *btrfs_get_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
 					struct btrfs_block_group *block_group)
@@ -132,16 +136,18 @@ static struct btrfs_block_group *find_next_block_group(
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
@@ -163,6 +169,7 @@ static struct btrfs_block_group *peek_discard_list(
 		}
 		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
+		*discard_index = block_group->discard_index;
 	} else {
 		block_group = NULL;
 	}
@@ -172,6 +179,65 @@ static struct btrfs_block_group *peek_discard_list(
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
+				btrfs_add_to_discard_list(discard_ctl,
+							  block_group);
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
+	btrfs_add_to_discard_list(discard_ctl, block_group);
+}
+
 /**
  * btrfs_discard_cancel_work - remove a block_group from the discard lists
  * @discard_ctl: discard control
@@ -293,6 +359,8 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 		else
 			btrfs_add_to_discard_unused_list(discard_ctl,
 							 block_group);
+	} else {
+		btrfs_update_discard_index(discard_ctl, block_group);
 	}
 }
 
@@ -309,25 +377,42 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
index e1819f319901..9dbc25bede08 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -11,12 +11,16 @@ struct btrfs_block_group;
 
 /* Discard size limits. */
 #define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+#define BTRFS_ASYNC_DISCARD_MAX_FILTER	(SZ_1M)
+#define BTRFS_ASYNC_DISCARD_MIN_FILTER	(SZ_32K)
 
 /* List operations. */
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
 void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 				      struct btrfs_block_group *block_group);
+void btrfs_discard_check_filter(struct btrfs_block_group *block_group,
+				u64 bytes);
 
 /* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 1c195308652d..83398c42213f 100644
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
@@ -3455,7 +3460,14 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3565,7 +3577,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
  */
 static int trim_bitmaps(struct btrfs_block_group *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
-			bool async)
+			u64 maxlen, bool async)
 {
 	struct btrfs_discard_ctl *discard_ctl =
 					&block_group->fs_info->discard_ctl;
@@ -3593,7 +3605,15 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3614,10 +3634,10 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3638,14 +3658,20 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3752,7 +3778,7 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	if (ret)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, false);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, 0, false);
 	div64_u64_rem(end, BITS_PER_BITMAP * ctl->unit, &rem);
 	/* If we ended in the middle of a bitmap, reset the trimming flag. */
 	if (rem)
@@ -3786,7 +3812,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async)
+				   u64 maxlen, bool async)
 {
 	int ret;
 
@@ -3800,7 +3826,8 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 	btrfs_get_block_group_trimming(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, async);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
+			   async);
 
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index b61b52eeaaf3..7c6d95765979 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -144,7 +144,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 				   bool async);
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async);
+				   u64 maxlen, bool async);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

