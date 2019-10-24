Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6ACE26A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436903AbfJWWxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:25 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:39978 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436897AbfJWWxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:25 -0400
Received: by mail-qt1-f182.google.com with SMTP id o49so26907593qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=48QLa1V0hW14gUloX8ypWjXwiWpA6zgCV7SpuWA+8WA=;
        b=oIJwEl/81ePvgbuwo3wJmDbRQPBiKFZgQxy4kmCQacB9EKN5tF20vJv2AAKScKVpQY
         m1e5i8JzP9Oe+ZMGTezqGGuBPUs7xG+7N/DCQjBfewgVLG5D45oGfmGleu2bX3ICzHUV
         cWSIOevCn/QI0RHlnqhLykTgbE2SYy4lmN9auI3UNAaSEVH/XeQMZYdyUil4gLs3OuwI
         ROMTktnQDz3WKakWoFDd+sGuJZEkP1iJTXxEfMbaFRVpZWw2DttPR8Ftthfg3kAXPld8
         6PqQTt7XrL9tXCp4qngEXB/cG0wnXYWLM57Z0l94kDk3fCK60hqTcSfgaby8LXMuOQD0
         tCNw==
X-Gm-Message-State: APjAAAXchRlM++rbEroExJ6WzHrPSIFfzA+H2Wrd18Ej8EHmJ3oN7+8N
        cZ+b5LJDyeLNsJefb9NihtjNDAkf
X-Google-Smtp-Source: APXvYqw2J41egc9raC/QS0gGPYntPZY5zNbhBxV4+boISQwNe3rjxbSOtpOvKeRzUBeZ2NlY4ZwIGA==
X-Received: by 2002:a05:6214:12c:: with SMTP id w12mr11327044qvs.174.1571871203639;
        Wed, 23 Oct 2019 15:53:23 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:22 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Date:   Wed, 23 Oct 2019 18:52:58 -0400
Message-Id: <6563f9fc4cd47bade586d86c658c848f2ffeaa49.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a cap in btrfs in the amount of free extents that a block group
can have. When it surpasses that threshold, future extents are placed
into bitmaps. Instead of keeping track of if a certain bit is trimmed or
not in a second bitmap, keep track of the relative state of the bitmap.

With async discard, trimming bitmaps becomes a more frequent operation.
As a trade off with simplicity, we keep track of if discarding a bitmap
is in progress. If we fully scan a bitmap and trim as necessary, the
bitmap is marked clean. This has some caveats as the min block size may
skip over regions deemed too small. But this should be a reasonable
trade off rather than keeping a second bitmap and making allocation
paths more complex. The downside is we may overtrim, but ideally the min
block size should prevent us from doing that too often and getting stuck
trimming pathological cases.

BTRFS_TRIM_STATE_TRIMMING is added to indicate a bitmap is in the
process of being trimmed. If additional free space is added to that
bitmap, the bit is cleared. A bitmap will be marked
BTRFS_TRIM_STATE_TRIMMED if the trimming code was able to reach the end
of it and the former is still set.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/free-space-cache.c | 89 +++++++++++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h | 12 +++++
 2 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d7f0cb961496..900b935e5997 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1975,11 +1975,18 @@ static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
 
 static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 			       struct btrfs_free_space *info, u64 offset,
-			       u64 bytes)
+			       u64 bytes, enum btrfs_trim_state trim_state)
 {
 	u64 bytes_to_set = 0;
 	u64 end;
 
+	/*
+	 * This is a tradeoff to make bitmap trim state minimal.  We mark the
+	 * whole bitmap untrimmed if at any point we add untrimmed regions.
+	 */
+	if (trim_state == BTRFS_TRIM_STATE_UNTRIMMED)
+		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+
 	end = info->offset + (u64)(BITS_PER_BITMAP * ctl->unit);
 
 	bytes_to_set = min(end - offset, bytes);
@@ -2054,10 +2061,12 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 	struct btrfs_block_group_cache *block_group = NULL;
 	int added = 0;
 	u64 bytes, offset, bytes_added;
+	enum btrfs_trim_state trim_state;
 	int ret;
 
 	bytes = info->bytes;
 	offset = info->offset;
+	trim_state = info->trim_state;
 
 	if (!ctl->op->use_bitmap(ctl, info))
 		return 0;
@@ -2092,8 +2101,8 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		}
 
 		if (entry->offset == offset_to_bitmap(ctl, offset)) {
-			bytes_added = add_bytes_to_bitmap(ctl, entry,
-							  offset, bytes);
+			bytes_added = add_bytes_to_bitmap(ctl, entry, offset,
+							  bytes, trim_state);
 			bytes -= bytes_added;
 			offset += bytes_added;
 		}
@@ -2112,7 +2121,8 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		goto new_bitmap;
 	}
 
-	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes);
+	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes,
+					  trim_state);
 	bytes -= bytes_added;
 	offset += bytes_added;
 	added = 0;
@@ -2146,6 +2156,7 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		/* allocate the bitmap */
 		info->bitmap = kmem_cache_zalloc(btrfs_free_space_bitmap_cachep,
 						 GFP_NOFS);
+		info->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 		spin_lock(&ctl->tree_lock);
 		if (!info->bitmap) {
 			ret = -ENOMEM;
@@ -3317,6 +3328,39 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 	return ret;
 }
 
+/*
+ * If we break out of trimming a bitmap prematurely, we should reset the
+ * trimming bit.  In a rather contrieved case, it's possible to race here so
+ * reset the state to BTRFS_TRIM_STATE_UNTRIMMED.
+ *
+ * start = start of bitmap
+ * end = near end of bitmap
+ *
+ * Thread 1:			Thread 2:
+ * trim_bitmaps(start)
+ *				trim_bitmaps(end)
+ *				end_trimming_bitmap()
+ * reset_trimming_bitmap()
+ */
+static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
+{
+	struct btrfs_free_space *entry;
+
+	spin_lock(&ctl->tree_lock);
+
+	entry = tree_search_offset(ctl, offset, 1, 0);
+	if (entry)
+		entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+
+	spin_unlock(&ctl->tree_lock);
+}
+
+static void end_trimming_bitmap(struct btrfs_free_space *entry)
+{
+	if (btrfs_free_space_trimming_bitmap(entry))
+		entry->trim_state = BTRFS_TRIM_STATE_TRIMMED;
+}
+
 static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
 {
@@ -3341,16 +3385,33 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		}
 
 		entry = tree_search_offset(ctl, offset, 1, 0);
-		if (!entry) {
+		if (!entry || btrfs_free_space_trimmed(entry)) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			next_bitmap = true;
 			goto next;
 		}
 
+		/*
+		 * Async discard bitmap trimming begins at by setting the start
+		 * to be key.objectid and the offset_to_bitmap() aligns to the
+		 * start of the bitmap.  This lets us know we are fully
+		 * scanning the bitmap rather than only some portion of it.
+		 */
+		if (start == offset)
+			entry->trim_state = BTRFS_TRIM_STATE_TRIMMING;
+
 		bytes = minlen;
 		ret2 = search_bitmap(ctl, entry, &start, &bytes, false);
 		if (ret2 || start >= end) {
+			/*
+			 * This keeps the invariant that all bytes are trimmed
+			 * if BTRFS_TRIM_STATE_TRIMMED is set on a bitmap.
+			 */
+			if (ret2 && !minlen)
+				end_trimming_bitmap(entry);
+			else
+				entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			next_bitmap = true;
@@ -3359,6 +3420,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 
 		bytes = min(bytes, end - start);
 		if (bytes < minlen) {
+			entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			goto next;
@@ -3376,18 +3438,21 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
 				  start, bytes, &trim_entry);
-		if (ret)
+		if (ret) {
+			reset_trimming_bitmap(ctl, offset);
 			break;
+		}
 next:
 		if (next_bitmap) {
 			offset += BITS_PER_BITMAP * ctl->unit;
+			start = offset;
 		} else {
 			start += bytes;
-			if (start >= offset + BITS_PER_BITMAP * ctl->unit)
-				offset += BITS_PER_BITMAP * ctl->unit;
 		}
 
 		if (fatal_signal_pending(current)) {
+			if (start != offset)
+				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -3441,6 +3506,7 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *block_group)
 int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen)
 {
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
 
 	*trimmed = 0;
@@ -3458,6 +3524,9 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 		goto out;
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	/* If we ended in the middle of a bitmap, reset the trimming flag. */
+	if (end % (BITS_PER_BITMAP * ctl->unit))
+		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
 out:
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
@@ -3642,6 +3711,7 @@ int test_add_free_space_entry(struct btrfs_block_group_cache *cache,
 	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
 	struct btrfs_free_space *info = NULL, *bitmap_info;
 	void *map = NULL;
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_TRIMMED;
 	u64 bytes_added;
 	int ret;
 
@@ -3683,7 +3753,8 @@ int test_add_free_space_entry(struct btrfs_block_group_cache *cache,
 		info = NULL;
 	}
 
-	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes);
+	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes,
+					  trim_state);
 
 	bytes -= bytes_added;
 	offset += bytes_added;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 98a568dbd5e7..b9d1aad2f7e5 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -8,10 +8,16 @@
 
 /*
  * This is the trim state of an extent or bitmap.
+ *
+ * BTRFS_TRIM_STATE_TRIMMING is special and used to maintain the state of a
+ * bitmap as we may need several trims to fully trim a single bitmap entry.
+ * This is reset should any free space other than trimmed space is added to the
+ * bitmap.
  */
 enum btrfs_trim_state {
 	BTRFS_TRIM_STATE_TRIMMED,
 	BTRFS_TRIM_STATE_UNTRIMMED,
+	BTRFS_TRIM_STATE_TRIMMING,
 };
 
 struct btrfs_free_space {
@@ -29,6 +35,12 @@ static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMED);
 }
 
+static inline bool btrfs_free_space_trimming_bitmap(
+					    struct btrfs_free_space *info)
+{
+	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
+}
+
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
 	struct rb_root free_space_offset;
-- 
2.17.1

