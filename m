Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9860F109462
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKYTrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34662 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfKYTrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id i17so18615230qtq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DkXdoshv5lUuQFlTtK+PxMd3pNIlQ6ANnLkUcimNM8U=;
        b=eNx9FkAq/IiK476yhp16+bu6FwXZU7nVe3mA6vKHIOKoK0LgDAjlcChfzL+teWjA1h
         UPGougHY4z6R32GU9WEdIN5pGPld6srvxcX346WO/FubC0xTyIvVhDk0vIsXiS9TWeit
         h133EoN9yKTmGWPVCehg5h2u9V3uxz9JAnO3nUPgxx9BHnVwC4XuPCoMIvu4Ayvnm7Iq
         1ugaLxOp6ELxD08Xh1LqOMXL8pk0SrPh3II8aJWDFVwUUljNGLpRYkybJH6nx8xw+Kge
         8CtIiK8kFRm2URgiYa+UUlZACarhJf/rdjY8iRuDgaqZeQsWwp9s24yItWzXHHpmdxQJ
         I2Hw==
X-Gm-Message-State: APjAAAWBCQDiUUljPCXf0QLu0yJw520TUwTJ7+0sjc7NxtQwPxIdvCBY
        2/MT378+endbtt4E5r0EN0oPEfqFV+Z6mg==
X-Google-Smtp-Source: APXvYqxUiOUMHV0SQPbVwY/nVNmPRLd4bE6fy3CsPVVbP/3fwOqyfAtgf8F5xrp0OwwsZUQhCFD7QA==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr10204535qtp.32.1574711231792;
        Mon, 25 Nov 2019 11:47:11 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:10 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Date:   Mon, 25 Nov 2019 14:46:44 -0500
Message-Id: <4ffb9972f1d156b817f625db7fcccd21e2f9a6a1.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 91 +++++++++++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h | 12 +++++
 2 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 399c641440bc..49ae1e6ee104 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1979,11 +1979,18 @@ static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
 
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
@@ -2058,10 +2065,12 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 	struct btrfs_block_group *block_group = NULL;
 	int added = 0;
 	u64 bytes, offset, bytes_added;
+	enum btrfs_trim_state trim_state;
 	int ret;
 
 	bytes = info->bytes;
 	offset = info->offset;
+	trim_state = info->trim_state;
 
 	if (!ctl->op->use_bitmap(ctl, info))
 		return 0;
@@ -2096,8 +2105,8 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		}
 
 		if (entry->offset == offset_to_bitmap(ctl, offset)) {
-			bytes_added = add_bytes_to_bitmap(ctl, entry,
-							  offset, bytes);
+			bytes_added = add_bytes_to_bitmap(ctl, entry, offset,
+							  bytes, trim_state);
 			bytes -= bytes_added;
 			offset += bytes_added;
 		}
@@ -2116,7 +2125,8 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		goto new_bitmap;
 	}
 
-	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes);
+	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes,
+					  trim_state);
 	bytes -= bytes_added;
 	offset += bytes_added;
 	added = 0;
@@ -2150,6 +2160,7 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		/* allocate the bitmap */
 		info->bitmap = kmem_cache_zalloc(btrfs_free_space_bitmap_cachep,
 						 GFP_NOFS);
+		info->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 		spin_lock(&ctl->tree_lock);
 		if (!info->bitmap) {
 			ret = -ENOMEM;
@@ -3320,6 +3331,39 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
 static int trim_bitmaps(struct btrfs_block_group *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
 {
@@ -3344,16 +3388,33 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3362,6 +3423,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 
 		bytes = min(bytes, end - start);
 		if (bytes < minlen) {
+			entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			goto next;
@@ -3379,18 +3441,21 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 
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
@@ -3444,7 +3509,9 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group *block_group)
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen)
 {
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
+	u64 rem = 0;
 
 	*trimmed = 0;
 
@@ -3461,6 +3528,10 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 		goto out;
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	div64_u64_rem(end, BITS_PER_BITMAP * ctl->unit, &rem);
+	/* If we ended in the middle of a bitmap, reset the trimming flag. */
+	if (rem)
+		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
 out:
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
@@ -3645,6 +3716,7 @@ int test_add_free_space_entry(struct btrfs_block_group *cache,
 	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
 	struct btrfs_free_space *info = NULL, *bitmap_info;
 	void *map = NULL;
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_TRIMMED;
 	u64 bytes_added;
 	int ret;
 
@@ -3686,7 +3758,8 @@ int test_add_free_space_entry(struct btrfs_block_group *cache,
 		info = NULL;
 	}
 
-	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes);
+	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes,
+					  trim_state);
 
 	bytes -= bytes_added;
 	offset += bytes_added;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 66c073f854dc..29d16f58b40b 100644
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
 	BTRFS_TRIM_STATE_UNTRIMMED,
 	BTRFS_TRIM_STATE_TRIMMED,
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

