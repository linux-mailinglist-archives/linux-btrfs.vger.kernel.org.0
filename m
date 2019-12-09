Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BF11761F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLITqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41006 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLITqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id s18so7742636pfd.8
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UOVhex7EaHZQl24lz1twg89oc7yWmwWUgEhxc66U/64=;
        b=BP5BFYPGv1Ym9DdPArI8NSo/TcY6L2wYgJ0HFckj+BWS3n3HmOYh6joCg+q1Q8lNGF
         NmYjLxLRuXXmTYYUgfdF0zVmpBgylsrnw4Eem12ZfDcM4IgSZDD2s7B6D/R5L1xPYnug
         gbkZhs+oJEHyrrqkXhOwK/dL7EgbVLx/YbywBptK3W9UbtsZV4n29JcP+3+g22rSzePY
         r5VjNPeFVTeu1Wesl0GPMxC0JQADpplZWEn05sUPvLFbO6xyEo0rAp8CGY03o5qsTzBd
         JiikiZqqgA2xe+hhKoh/JwHhGhIyZDxGLdMA2oQvv8tkDi2OW8wVwtbLWGABOiYY8WvA
         IKTA==
X-Gm-Message-State: APjAAAUP87F4vXnOGXAL31q2n/s82WGeeRVQ20SjO1ppP0ZK7Vedp1S9
        MLQIfSI8L+7h2S1l6QqXC58=
X-Google-Smtp-Source: APXvYqwORPlcCVhnWF6E3O3v8RtoBaQ7ecg/Tmouhy03WloDAlPV9Rk8ZGpR9eNl4MPVnZ9tg3Z2Vw==
X-Received: by 2002:a62:750e:: with SMTP id q14mr31162443pfc.155.1575920778036;
        Mon, 09 Dec 2019 11:46:18 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:17 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/22] btrfs: discard one region at a time in async discard
Date:   Mon,  9 Dec 2019 11:45:52 -0800
Message-Id: <1c69d994367ceb4096567844d7d1a72d6311a4cb.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
 fs/btrfs/discard.c          |  85 ++++++++++++++++++-----
 fs/btrfs/free-space-cache.c | 131 ++++++++++++++++++++++++++++--------
 fs/btrfs/free-space-cache.h |   6 ++
 4 files changed, 192 insertions(+), 45 deletions(-)

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
index 752b38642b6b..a7a091f4af4b 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -21,15 +21,11 @@ static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	return &discard_ctl->discard_list[block_group->discard_index];
 }
 
-static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
-				struct btrfs_block_group *block_group)
+static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+				  struct btrfs_block_group *block_group)
 {
-	spin_lock(&discard_ctl->lock);
-
-	if (!btrfs_run_discard_work(discard_ctl)) {
-		spin_unlock(&discard_ctl->lock);
+	if (!btrfs_run_discard_work(discard_ctl))
 		return;
-	}
 
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
@@ -37,10 +33,19 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			block_group->discard_index = BTRFS_DISCARD_INDEX_START;
 		block_group->discard_eligible_time = (ktime_get_ns() +
 						      BTRFS_DISCARD_DELAY);
+		block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	}
 
 	list_move_tail(&block_group->discard_list,
 		       get_discard_list(discard_ctl, block_group));
+}
+
+static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+				struct btrfs_block_group *block_group)
+{
+	spin_lock(&discard_ctl->lock);
+
+	__add_to_discard_list(discard_ctl, block_group);
 
 	spin_unlock(&discard_ctl->lock);
 }
@@ -60,6 +65,7 @@ static void add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 	block_group->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 	block_group->discard_eligible_time = (ktime_get_ns() +
 					      BTRFS_DISCARD_UNUSED_DELAY);
+	block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	list_add_tail(&block_group->discard_list,
 		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
 
@@ -127,23 +133,41 @@ static struct btrfs_block_group *find_next_block_group(
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
+			__add_to_discard_list(discard_ctl, block_group);
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
 
@@ -257,24 +281,53 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
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
index af0092cafc85..6e07387622cf 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3324,8 +3324,12 @@ static int do_trimming(struct btrfs_block_group *block_group,
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
@@ -3342,36 +3346,25 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3396,10 +3389,15 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3408,7 +3406,14 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 
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
 
@@ -3445,8 +3450,12 @@ static void end_trimming_bitmap(struct btrfs_free_space *entry)
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
@@ -3463,13 +3472,16 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3502,6 +3514,16 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3524,6 +3546,8 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 				  start, bytes, 0, &trim_entry);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
+			block_group->discard_cursor =
+				btrfs_block_group_end(block_group);
 			break;
 		}
 next:
@@ -3533,6 +3557,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		} else {
 			start += bytes;
 		}
+		block_group->discard_cursor = start;
 
 		if (fatal_signal_pending(current)) {
 			if (start != offset)
@@ -3544,6 +3569,9 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		cond_resched();
 	}
 
+	if (offset >= end)
+		block_group->discard_cursor = end;
+
 	return ret;
 }
 
@@ -3604,11 +3632,11 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
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
@@ -3618,6 +3646,51 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
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
index 3100c7d5e646..55d6f6aaeb9b 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -138,6 +138,12 @@ int btrfs_return_cluster_to_free_space(
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

