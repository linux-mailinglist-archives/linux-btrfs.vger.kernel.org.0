Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4174411EF1F
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLNAWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36909 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLNAWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep17so410140pjb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=skf2w8APTjaWQaM2E7XJZOzI0bGTNiKwUntOaGWCSEo=;
        b=XP3Iq1o/n9XVgrJVKN+cbUHOCW2NNNvu0Nsjz9B1Sl0zY4wK2Drni+AUZ6FYtUdUyw
         B+fXeeTQpnjfYN/KXCmFYmetvDWrh9ngDNdAo/IZSdyvFBt2Lm+R4+pJm5g96fb3LqwP
         ANtTJthQGM2EvLXeT8olz85tZHUapz/pK1RkP5vwXiS88H67KjLiVLlpVpIzc+HuZC/9
         dbNSJZqY61Ptir45Ua3HbywW9TH/24NSwF1YCuC6JMbO+pmvq758APRzfrAzUEuQL74w
         D7/YyFACdpdU56QD+UL/paV/FE8on5goELjuHJBgpzEcdJMTEAa4rjY1HarTe6dViIMw
         ZWIg==
X-Gm-Message-State: APjAAAXoPLmo6M4X7wHH3oOuqOhkZUW4aKGlp+QQzrsMbw/JPPoVyZFn
        rVVROOSRmRif9xRu2is3/dM=
X-Google-Smtp-Source: APXvYqwx9GZ4vsnIQnXw09VA8wotUVOnPqlGM/kwm9u6wOO9++VyYVM4SEaqo4PBALTAqBEAJo0UHQ==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr2657060pjp.89.1576282964143;
        Fri, 13 Dec 2019 16:22:44 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:43 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Date:   Fri, 13 Dec 2019 16:22:13 -0800
Message-Id: <f5eb876df942628bfbbeadb6d01f3d207bf9c811.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
index 5f8e2171efbf..7108962e208d 100644
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
@@ -3325,6 +3336,39 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3349,16 +3393,33 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3367,6 +3428,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 
 		bytes = min(bytes, end - start);
 		if (bytes < minlen) {
+			entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			goto next;
@@ -3384,18 +3446,21 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 
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
@@ -3449,7 +3514,9 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group *block_group)
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen)
 {
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
+	u64 rem = 0;
 
 	*trimmed = 0;
 
@@ -3466,6 +3533,10 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 		goto out;
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	div64_u64_rem(end, BITS_PER_BITMAP * ctl->unit, &rem);
+	/* If we ended in the middle of a bitmap, reset the trimming flag. */
+	if (rem)
+		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
 out:
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
@@ -3650,6 +3721,7 @@ int test_add_free_space_entry(struct btrfs_block_group *cache,
 	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
 	struct btrfs_free_space *info = NULL, *bitmap_info;
 	void *map = NULL;
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_TRIMMED;
 	u64 bytes_added;
 	int ret;
 
@@ -3691,7 +3763,8 @@ int test_add_free_space_entry(struct btrfs_block_group *cache,
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

