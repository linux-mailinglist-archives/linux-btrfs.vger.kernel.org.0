Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794BF109466
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKYTrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41283 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfKYTrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id 59so13067835qtg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7TM/FsScWu+gt6nJL+laMGmyfxHIBFFZMEN8yX7bpbs=;
        b=rWTRxDMvV4ICN/jQl/VT0WTkl/sfVBCXyz6PD3Re1pSWsYp3vX0cdxM8dhD7seyDQW
         o2/qKOeGR299+DBvLcomOr05myn2Swi4zdeji10aPMKZ+2B7nDXCII7Nv/jdoQCebUtM
         WlU5eranw4ypHBESVpyF6oZsppjFuJeUqu9Ck82DqqkFl+GoYuf5aEdKgXI1M6QwoqHT
         5QDLB7enuEDjFRd3zZE9LGiJx5SNTElBDJyFyJDJnA1SouL509OwA5Uda9+yHzM0sGpt
         iuGVduQuYcyZx46+UcgUy5n3gO5ghTjIHQflwGYOippHpZrWeImgkne7uov+db+vRB/o
         XoEQ==
X-Gm-Message-State: APjAAAVBoXmyWRszmn6QHSNg5iwHQRPWYOYfRgdynjnAWoGFlDz9eb9c
        V+6R3pQn/kjc59pz63gJirU=
X-Google-Smtp-Source: APXvYqwBVCX4MZmUjNxhMdXW2AUaqSu3y6vL0Hj0SsKsAEzLej1IuJTC6J4H5xJBeBT367bTOQ1pGQ==
X-Received: by 2002:ac8:5053:: with SMTP id h19mr30988816qtm.38.1574711235215;
        Mon, 25 Nov 2019 11:47:15 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:14 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/22] btrfs: discard one region at a time in async discard
Date:   Mon, 25 Nov 2019 14:46:47 -0500
Message-Id: <06fb0a4a00ae411e781987a27991df0c4b89514d.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h      |  15 +++++
 fs/btrfs/discard.c          |  81 ++++++++++++++++++----
 fs/btrfs/free-space-cache.c | 131 ++++++++++++++++++++++++++++--------
 fs/btrfs/free-space-cache.h |   6 ++
 4 files changed, 191 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 884defd61dcd..601e1d217e22 100644
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
@@ -121,6 +134,8 @@ struct btrfs_block_group {
 	struct list_head discard_list;
 	int discard_index;
 	u64 discard_eligible_time;
+	u64 discard_cursor;
+	enum btrfs_discard_state discard_state;
 
 	/* For dirty block groups */
 	struct list_head dirty_list;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e0f48d6de9a1..8b676103919a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -21,21 +21,28 @@ static struct list_head *btrfs_get_discard_list(
 	return &discard_ctl->discard_list[block_group->discard_index];
 }
 
-void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
-			       struct btrfs_block_group *block_group)
+static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+					struct btrfs_block_group *block_group)
 {
-	spin_lock(&discard_ctl->lock);
-
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED)
 			block_group->discard_index = BTRFS_DISCARD_INDEX_START;
 		block_group->discard_eligible_time = (ktime_get_ns() +
 						      BTRFS_DISCARD_DELAY);
+		block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	}
 
 	list_move_tail(&block_group->discard_list,
 		       btrfs_get_discard_list(discard_ctl, block_group));
+}
+
+void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group *block_group)
+{
+	spin_lock(&discard_ctl->lock);
+
+	__btrfs_add_to_discard_list(discard_ctl, block_group);
 
 spin_unlock(&discard_ctl->lock);
 }
@@ -50,6 +57,7 @@ void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 
 	block_group->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 	block_group->discard_eligible_time = ktime_get_ns();
+	block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	list_add_tail(&block_group->discard_list,
 		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
 
@@ -117,23 +125,41 @@ static struct btrfs_block_group *find_next_block_group(
 /**
  * peek_discard_list - wrap find_next_block_group()
  * @discard_ctl: discard control
+ * @discard_state: the discard_state of the block_group after state management
  *
  * This wraps find_next_block_group() and sets the block_group to be in use.
+ * discard_state's control flow is managed here.  Variables related to
+ * discard_state are reset here as needed (eg discard_cursor).  @discard_state
+ * is remembered as it may change while we're discarding, but we want the
+ * discard to execute in the context determined here.
  */
 static struct btrfs_block_group *peek_discard_list(
-					struct btrfs_discard_ctl *discard_ctl)
+					struct btrfs_discard_ctl *discard_ctl,
+					enum btrfs_discard_state *discard_state)
 {
 	struct btrfs_block_group *block_group;
 	u64 now = ktime_get_ns();
 
 	spin_lock(&discard_ctl->lock);
 
+again:
 	block_group = find_next_block_group(discard_ctl, now);
 
-	if (block_group && now < block_group->discard_eligible_time)
+	if (block_group && now > block_group->discard_eligible_time) {
+		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
+		    block_group->used != 0) {
+			__btrfs_add_to_discard_list(discard_ctl, block_group);
+			goto again;
+		}
+		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
+			block_group->discard_cursor = block_group->start;
+			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
+		}
+		discard_ctl->block_group = block_group;
+		*discard_state = block_group->discard_state;
+	} else {
 		block_group = NULL;
-
-	discard_ctl->block_group = block_group;
+	}
 
 	spin_unlock(&discard_ctl->lock);
 
@@ -248,24 +274,53 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
  * btrfs_discard_workfn - discard work function
  * @work: work
  *
- * This finds the next block_group to start discarding and then discards it.
+ * This finds the next block_group to start discarding and then discards a
+ * single region.  It does this in a two-pass fashion: first extents and second
+ * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
  */
 static void btrfs_discard_workfn(struct work_struct *work)
 {
 	struct btrfs_discard_ctl *discard_ctl;
 	struct btrfs_block_group *block_group;
+	enum btrfs_discard_state discard_state;
 	u64 trimmed = 0;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
-	block_group = peek_discard_list(discard_ctl);
+	block_group = peek_discard_list(discard_ctl, &discard_state);
 	if (!block_group || !btrfs_run_discard_work(discard_ctl))
 		return;
 
-	btrfs_trim_block_group(block_group, &trimmed, block_group->start,
-			       btrfs_block_group_end(block_group), 0);
+	/* Perform discarding. */
+	if (discard_state == BTRFS_DISCARD_BITMAPS)
+		btrfs_trim_block_group_bitmaps(block_group, &trimmed,
+				       block_group->discard_cursor,
+				       btrfs_block_group_end(block_group),
+				       0, true);
+	else
+		btrfs_trim_block_group_extents(block_group, &trimmed,
+				       block_group->discard_cursor,
+				       btrfs_block_group_end(block_group),
+				       0, true);
+
+	/* Determine next steps for a block_group. */
+	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
+		if (discard_state == BTRFS_DISCARD_BITMAPS) {
+			btrfs_finish_discard_pass(discard_ctl, block_group);
+		} else {
+			block_group->discard_cursor = block_group->start;
+			spin_lock(&discard_ctl->lock);
+			if (block_group->discard_state !=
+			    BTRFS_DISCARD_RESET_CURSOR)
+				block_group->discard_state =
+							BTRFS_DISCARD_BITMAPS;
+			spin_unlock(&discard_ctl->lock);
+		}
+	}
 
-	btrfs_finish_discard_pass(discard_ctl, block_group);
+	spin_lock(&discard_ctl->lock);
+	discard_ctl->block_group = NULL;
+	spin_unlock(&discard_ctl->lock);
 
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7542bd349602..b1fdcc1ab36d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3300,8 +3300,12 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	return ret;
 }
 
+/*
+ * If @async is set, then we will trim 1 region and return.
+ */
 static int trim_no_bitmap(struct btrfs_block_group *block_group,
-			  u64 *total_trimmed, u64 start, u64 end, u64 minlen)
+			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
+			  bool async)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
@@ -3318,36 +3322,25 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
+		/* skip bitmaps and if async, already trimmed entries */
+		while (entry->bitmap ||
+		       (async && btrfs_free_space_trimmed(entry))) {
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
@@ -3372,10 +3365,15 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3384,7 +3382,14 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 
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
 
@@ -3421,8 +3426,12 @@ static void end_trimming_bitmap(struct btrfs_free_space *entry)
 		entry->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 }
 
+/*
+ * If @async is set, then we will trim 1 region and return.
+ */
 static int trim_bitmaps(struct btrfs_block_group *block_group,
-			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
+			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
+			bool async)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
@@ -3439,13 +3448,16 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3478,6 +3490,16 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3500,6 +3522,8 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 				  start, bytes, 0, &trim_entry);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
+			block_group->discard_cursor =
+				btrfs_block_group_end(block_group);
 			break;
 		}
 next:
@@ -3509,6 +3533,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		} else {
 			start += bytes;
 		}
+		block_group->discard_cursor = start;
 
 		if (fatal_signal_pending(current)) {
 			if (start != offset)
@@ -3520,6 +3545,9 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		cond_resched();
 	}
 
+	if (offset >= end)
+		block_group->discard_cursor = end;
+
 	return ret;
 }
 
@@ -3580,11 +3608,11 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	btrfs_get_block_group_trimming(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen);
+	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, false);
 	if (ret)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, false);
 	div64_u64_rem(end, BITS_PER_BITMAP * ctl->unit, &rem);
 	/* If we ended in the middle of a bitmap, reset the trimming flag. */
 	if (rem)
@@ -3594,6 +3622,51 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	return ret;
 }
 
+int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
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
+int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
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
index 49ff6d6f333b..67b59ffd13e4 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -136,6 +136,12 @@ int btrfs_return_cluster_to_free_space(
 			       struct btrfs_free_cluster *cluster);
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen);
+int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
+				   u64 *trimmed, u64 start, u64 end, u64 minlen,
+				   bool async);
+int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
+				   u64 *trimmed, u64 start, u64 end, u64 minlen,
+				   bool async);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

