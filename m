Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364D0CED4F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfJGUSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfJGUSJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id c4so8425803qtn.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=r7R7OZY/hHgr+pYZ6c8HtwO+nRUQ1qiv+kCfR1ZKasw=;
        b=EK5Ku3qoDXoJeDN4tnp1aVvXwii1ZKt4ZaJy0953Eo/mS0aKwUKnqEvBuh3jHnS6Dn
         eOMRzLkHvaWlZI2Bwx+9WnepT/5hdGhd56NfPm9OPqIoAY9VgyX4nwYbqc4najR3iRJE
         7azH0/8tyt60sT+oyTtLaMr9lWiqGjBKgnCETBXIZU0vVYMp9oa5eu4b75pdMZWhaYRd
         7NfKZep6Rivm+pi67TfqkmShyC/+mhavsMGUZOdotpUQHvpa9wl3GqSZqe+YktYfLYfr
         A76jspjvevVsWPf9iUlX3ic/CZYmjtIq0vcwDxH1idBxqopGBHK5hLb7h2uirYgYbiJl
         E/jw==
X-Gm-Message-State: APjAAAUhZOCIzYiGDC8agmgD43QH5UzLZeOToSGzfrcelkgO1t9jzV3+
        Q6TmqT11yO+6xlW7xNZUP5k=
X-Google-Smtp-Source: APXvYqwA1W53qJ69OaSxH2Ln48q5LasdzuYDfD2lh+BDYfQoL3lQTpOj1zHGxDeaA57mezpGHkJ/6g==
X-Received: by 2002:a0c:9276:: with SMTP id 51mr28734864qvz.35.1570479488058;
        Mon, 07 Oct 2019 13:18:08 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:07 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 13/19] btrfs: have multiple discard lists
Date:   Mon,  7 Oct 2019 16:17:44 -0400
Message-Id: <87b5ef751e8febd481065e475bd53b276e670ff6.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Non-block group destruction discarding currently only had a single list
with no minimum discard length. This can lead to caravaning more
meaningful discards behind a heavily fragmented block group.

This adds support for multiple lists with minimum discard lengths to
prevent the caravan effect. We promote block groups back up when we
exceed the BTRFS_DISCARD_MAX_FILTER size, currently we support only 2
lists with filters of 1MB and 32KB respectively.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/discard.c          | 60 +++++++++++++++++++++++++++++++++----
 fs/btrfs/discard.h          |  4 +++
 fs/btrfs/free-space-cache.c | 37 +++++++++++++++--------
 fs/btrfs/free-space-cache.h |  2 +-
 5 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e81f699347e0..b5608f8dc41a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -439,7 +439,7 @@ struct btrfs_full_stripe_locks_tree {
 };
 
 /* discard control */
-#define BTRFS_NR_DISCARD_LISTS		2
+#define BTRFS_NR_DISCARD_LISTS		3
 
 struct btrfs_discard_ctl {
 	struct workqueue_struct *discard_workers;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 072c73f48297..296cbffc5957 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -20,6 +20,10 @@
 #define BTRFS_DISCARD_MAX_DELAY		(10000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(10UL)
 
+/* montonically decreasing filters after 0 */
+static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {0,
+	BTRFS_DISCARD_MAX_FILTER, BTRFS_DISCARD_MIN_FILTER};
+
 static struct list_head *
 btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 		       struct btrfs_block_group_cache *cache)
@@ -120,7 +124,7 @@ find_next_cache(struct btrfs_discard_ctl *discard_ctl, u64 now)
 }
 
 static struct btrfs_block_group_cache *
-peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
+peek_discard_list(struct btrfs_discard_ctl *discard_ctl, int *discard_index)
 {
 	struct btrfs_block_group_cache *cache;
 	u64 now = ktime_get_ns();
@@ -132,6 +136,7 @@ peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
 
 	if (cache && now > cache->discard_delay) {
 		discard_ctl->cache = cache;
+		*discard_index = cache->discard_index;
 		if (cache->discard_index == 0 &&
 		    cache->free_space_ctl->free_space != cache->key.offset) {
 			__btrfs_add_to_discard_list(discard_ctl, cache);
@@ -150,6 +155,36 @@ peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
 	return cache;
 }
 
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
+	if (cache && cache->discard_index > 1 &&
+	    bytes >= BTRFS_DISCARD_MAX_FILTER) {
+		remove_from_discard_list(discard_ctl, cache);
+		cache->discard_index = 1;
+		btrfs_add_to_discard_list(discard_ctl, cache);
+	}
+}
+
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
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache)
 {
@@ -202,23 +237,34 @@ static void btrfs_discard_workfn(struct work_struct *work)
 {
 	struct btrfs_discard_ctl *discard_ctl;
 	struct btrfs_block_group_cache *cache;
+	int discard_index = 0;
 	u64 trimmed = 0;
+	u64 minlen = 0;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
 again:
-	cache = peek_discard_list(discard_ctl);
+	cache = peek_discard_list(discard_ctl, &discard_index);
 	if (!cache || !btrfs_run_discard_work(discard_ctl))
 		return;
 
-	if (btrfs_discard_bitmaps(cache))
+	minlen = discard_minlen[discard_index];
+
+	if (btrfs_discard_bitmaps(cache)) {
+		u64 maxlen = 0;
+
+		if (discard_index)
+			maxlen = discard_minlen[discard_index - 1];
+
 		btrfs_trim_block_group_bitmaps(cache, &trimmed,
 					       cache->discard_cursor,
 					       btrfs_block_group_end(cache),
-					       0, true);
-	else
+					       minlen, maxlen, true);
+	} else {
 		btrfs_trim_block_group(cache, &trimmed, cache->discard_cursor,
-				       btrfs_block_group_end(cache), 0, true);
+				       btrfs_block_group_end(cache),
+				       minlen, true);
+	}
 
 	discard_ctl->prev_discard = trimmed;
 
@@ -231,6 +277,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				 cache->key.offset)
 				btrfs_add_to_discard_free_list(discard_ctl,
 							       cache);
+			else
+				btrfs_update_discard_index(discard_ctl, cache);
 		} else {
 			cache->discard_cursor = cache->key.objectid;
 			cache->discard_flags |= BTRFS_DISCARD_BITMAPS;
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 898dd92dbf8f..1daa8da4a1b5 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -18,6 +18,8 @@
 
 /* discard size limits */
 #define BTRFS_DISCARD_MAX_SIZE		(SZ_64M)
+#define BTRFS_DISCARD_MAX_FILTER	(SZ_1M)
+#define BTRFS_DISCARD_MIN_FILTER	(SZ_32K)
 
 /* discard flags */
 #define BTRFS_DISCARD_RESET_CURSOR	(1UL << 0)
@@ -39,6 +41,8 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
 void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
 				    struct btrfs_block_group_cache *cache);
+void btrfs_discard_check_filter(struct btrfs_block_group_cache *cache,
+				u64 bytes);
 void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
 
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ce33803a45b2..ed35dc090df6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2471,6 +2471,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	if (ret)
 		kmem_cache_free(btrfs_free_space_cachep, info);
 out:
+	btrfs_discard_check_filter(cache, bytes);
 	btrfs_discard_update_discardable(cache, ctl);
 	spin_unlock(&ctl->tree_lock);
 
@@ -3409,7 +3410,13 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 				goto next;
 			}
 			unlink_free_space(ctl, entry);
-			if (bytes > BTRFS_DISCARD_MAX_SIZE) {
+			/*
+			 * Let bytes = BTRFS_MAX_DISCARD_SIZE + X.
+			 * If X < BTRFS_DISCARD_MIN_FILTER, we won't trim X when
+			 * we come back around.  So trim it now.
+			 */
+			if (bytes > (BTRFS_DISCARD_MAX_SIZE +
+				     BTRFS_DISCARD_MIN_FILTER)) {
 				bytes = extent_bytes = BTRFS_DISCARD_MAX_SIZE;
 				entry->offset += BTRFS_DISCARD_MAX_SIZE;
 				entry->bytes -= BTRFS_DISCARD_MAX_SIZE;
@@ -3510,7 +3517,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
 
 static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
-			bool async)
+			u64 maxlen, bool async)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
@@ -3535,7 +3542,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		}
 
 		entry = tree_search_offset(ctl, offset, 1, 0);
-		if (!entry || (async && start == offset &&
+		if (!entry || (async && minlen && start == offset &&
 			       btrfs_free_space_trimmed(entry))) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
@@ -3556,10 +3563,10 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		ret2 = search_bitmap(ctl, entry, &start, &bytes, false);
 		if (ret2 || start >= end) {
 			/*
-			 * This keeps the invariant that all bytes are trimmed
-			 * if BTRFS_FSC_TRIMMED is set on a bitmap.
+			 * We lossily consider a bitmap trimmed if we only skip
+			 * over regions <= BTRFS_DISCARD_MIN_FILTER.
 			 */
-			if (ret2 && !minlen)
+			if (ret2 && minlen <= BTRFS_DISCARD_MIN_FILTER)
 				end_trimming_bitmap(ctl, entry);
 			else
 				entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
@@ -3580,14 +3587,19 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		}
 
 		bytes = min(bytes, end - start);
-		if (bytes < minlen) {
-			entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
+		if (bytes < minlen || (async && maxlen && bytes > maxlen)) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			goto next;
 		}
 
-		if (async && bytes > BTRFS_DISCARD_MAX_SIZE)
+		/*
+		 * Let bytes = BTRFS_MAX_DISCARD_SIZE + X.
+		 * If X < BTRFS_DISCARD_MIN_FILTER, we won't trim X when we come
+		 * back around.  So trim it now.
+		 */
+		if (async && bytes > (BTRFS_DISCARD_MAX_SIZE +
+				      BTRFS_DISCARD_MIN_FILTER))
 			bytes = BTRFS_DISCARD_MAX_SIZE;
 
 		bitmap_clear_bits(ctl, entry, start, bytes);
@@ -3694,7 +3706,7 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 	if (ret || async)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, false);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, 0, false);
 	/* if we ended in the middle of a bitmap, reset the trimming flag */
 	if (end % (BITS_PER_BITMAP * ctl->unit))
 		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
@@ -3705,7 +3717,7 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async)
+				   u64 maxlen, bool async)
 {
 	int ret;
 
@@ -3719,7 +3731,8 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
 	btrfs_get_block_group_trimming(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, async);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
+			   async);
 
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index c5cce44b03af..90abf922f0ba 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -132,7 +132,7 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 			   bool async);
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group_cache *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async);
+				   u64 maxlen, bool async);
 
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.17.1

