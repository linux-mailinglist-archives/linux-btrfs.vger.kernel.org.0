Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72FCED46
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfJGUR7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:17:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35681 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfJGUR7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:17:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so13944801qkf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zZaFBsxjBdS+nCe5yTkYZensX2LGWIFBrdhJ1OshTsY=;
        b=aZmGDhZfF5GGmpTgif00Kb++lrgUWzifrpCR+98rgaaQxIKJ4bK9AhIkQsqrSDzOc2
         M5ZBK8wZXQ7NDltuBGPil+rlG6FCEYeOABJ2+4t2DEep+AU1JYsuMKwZF8b66gponY22
         3mFfW82pQhTj34HjOn/kQRsVuFAOeSbyuVHUhKISboKucNCKr4Kh6jVWH/BaB1iYfcK1
         3Yl2gFmK2Q4pVWHmSHiGHDr0mQMSz5Uf1jNsaLmXRWZLi09PVGZrawP1hdzv42WunWOR
         vUq/mChS2q4nLUIUhqDDhMgvBplJeBS3yAemp7TySv2psn9vGlmwSWRUOkmD5W+R18Xu
         KCZQ==
X-Gm-Message-State: APjAAAWXk/7xl5//Toa52EH9Ja6cdISSYZOEafkfmRVmiA40CoU7uJq7
        uPhlCaywhsuUDrkuAYvT2jk=
X-Google-Smtp-Source: APXvYqx9eaemolPzrCy2gA0+sbdNSmjPgJnbBgvzth6VofedvKVMeUgnbFkjWRYFRqK0sD4F3y2yjA==
X-Received: by 2002:a37:4d43:: with SMTP id a64mr25945699qkb.408.1570479477881;
        Mon, 07 Oct 2019 13:17:57 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:57 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/19] btrfs: keep track of cleanliness of the bitmap
Date:   Mon,  7 Oct 2019 16:17:35 -0400
Message-Id: <4cdbe31836b701c2c134c8484bb3531f7024031d.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
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
trimming
pathological cases.

BTRFS_FSC_TRIMMING_BITMAP is added to indicate a bitmap is in the
process of being trimmed. If additional free space is added to that
bitmap, the bit is cleared. A bitmap will be marked BTRFS_FSC_TRIMMED if
the trimming code was able to reach the end of it and the former is
still set.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/free-space-cache.c | 83 +++++++++++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h |  7 ++++
 2 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f119895292b8..129b9a164b35 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1975,11 +1975,14 @@ static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
 
 static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 			       struct btrfs_free_space *info, u64 offset,
-			       u64 bytes)
+			       u64 bytes, u32 flags)
 {
 	u64 bytes_to_set = 0;
 	u64 end;
 
+	if (!(flags & BTRFS_FSC_TRIMMED))
+		info->flags &= ~(BTRFS_FSC_TRIMMED | BTRFS_FSC_TRIMMING_BITMAP);
+
 	end = info->offset + (u64)(BITS_PER_BITMAP * ctl->unit);
 
 	bytes_to_set = min(end - offset, bytes);
@@ -2054,10 +2057,12 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 	struct btrfs_block_group_cache *block_group = NULL;
 	int added = 0;
 	u64 bytes, offset, bytes_added;
+	u32 flags;
 	int ret;
 
 	bytes = info->bytes;
 	offset = info->offset;
+	flags = info->flags;
 
 	if (!ctl->op->use_bitmap(ctl, info))
 		return 0;
@@ -2093,7 +2098,7 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 
 		if (entry->offset == offset_to_bitmap(ctl, offset)) {
 			bytes_added = add_bytes_to_bitmap(ctl, entry,
-							  offset, bytes);
+							  offset, bytes, flags);
 			bytes -= bytes_added;
 			offset += bytes_added;
 		}
@@ -2112,7 +2117,8 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		goto new_bitmap;
 	}
 
-	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes);
+	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes,
+					  flags);
 	bytes -= bytes_added;
 	offset += bytes_added;
 	added = 0;
@@ -2146,6 +2152,7 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		/* allocate the bitmap */
 		info->bitmap = kmem_cache_zalloc(btrfs_free_space_bitmap_cachep,
 						 GFP_NOFS);
+		info->flags |= BTRFS_FSC_TRIMMED;
 		spin_lock(&ctl->tree_lock);
 		if (!info->bitmap) {
 			ret = -ENOMEM;
@@ -3295,6 +3302,41 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 	return ret;
 }
 
+/*
+ * If we break out of trimming a bitmap prematurely, we should reset the
+ * trimming bit.  In a rather contrieved case, it's possible to race here so
+ * clear BTRFS_FSC_TRIMMED as well.
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
+	struct btrfs_free_space *info;
+
+	spin_lock(&ctl->tree_lock);
+
+	info = tree_search_offset(ctl, offset, 1, 0);
+	if (info)
+		info->flags &= ~(BTRFS_FSC_TRIMMED | BTRFS_FSC_TRIMMING_BITMAP);
+
+	spin_unlock(&ctl->tree_lock);
+}
+
+static void end_trimming_bitmap(struct btrfs_free_space *entry)
+{
+	if (btrfs_free_space_trimming_bitmap(entry)) {
+		entry->flags |= BTRFS_FSC_TRIMMED;
+		entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
+	}
+}
+
 static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
 {
@@ -3326,9 +3368,26 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			goto next;
 		}
 
+		/*
+		 * Async discard bitmap trimming begins at by setting the start
+		 * to be key.objectid and the offset_to_bitmap() aligns to the
+		 * start of the bitmap.  This lets us know we are fully
+		 * scanning the bitmap rather than only some portion of it.
+		 */
+		if (start == offset)
+			entry->flags |= BTRFS_FSC_TRIMMING_BITMAP;
+
 		bytes = minlen;
 		ret2 = search_bitmap(ctl, entry, &start, &bytes, false);
 		if (ret2 || start >= end) {
+			/*
+			 * This keeps the invariant that all bytes are trimmed
+			 * if BTRFS_FSC_TRIMMED is set on a bitmap.
+			 */
+			if (ret2 && !minlen)
+				end_trimming_bitmap(entry);
+			else
+				entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			next_bitmap = true;
@@ -3337,6 +3396,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 
 		bytes = min(bytes, end - start);
 		if (bytes < minlen) {
+			entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
 			goto next;
@@ -3354,18 +3414,21 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 
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
@@ -3419,6 +3482,7 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *block_group)
 int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen)
 {
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
 
 	*trimmed = 0;
@@ -3436,6 +3500,9 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 		goto out;
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	/* if we ended in the middle of a bitmap, reset the trimming flag */
+	if (end % (BITS_PER_BITMAP * ctl->unit))
+		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
 out:
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
@@ -3620,6 +3687,7 @@ int test_add_free_space_entry(struct btrfs_block_group_cache *cache,
 	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
 	struct btrfs_free_space *info = NULL, *bitmap_info;
 	void *map = NULL;
+	u32 flags = 0;
 	u64 bytes_added;
 	int ret;
 
@@ -3661,7 +3729,8 @@ int test_add_free_space_entry(struct btrfs_block_group_cache *cache,
 		info = NULL;
 	}
 
-	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes);
+	bytes_added = add_bytes_to_bitmap(ctl, bitmap_info, offset, bytes,
+					  flags);
 
 	bytes -= bytes_added;
 	offset += bytes_added;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index ab3dfc00abb5..dc73ec8d34bb 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -7,6 +7,7 @@
 #define BTRFS_FREE_SPACE_CACHE_H
 
 #define BTRFS_FSC_TRIMMED		(1UL << 0)
+#define BTRFS_FSC_TRIMMING_BITMAP	(1UL << 1)
 
 struct btrfs_free_space {
 	struct rb_node offset_index;
@@ -23,6 +24,12 @@ static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
 	return (info->flags & BTRFS_FSC_TRIMMED);
 }
 
+static inline
+bool btrfs_free_space_trimming_bitmap(struct btrfs_free_space *info)
+{
+	return (info->flags & BTRFS_FSC_TRIMMING_BITMAP);
+}
+
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
 	struct rb_root free_space_offset;
-- 
2.17.1

