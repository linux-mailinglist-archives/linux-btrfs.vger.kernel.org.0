Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519C2104616
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKTVvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:33 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36079 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKTVvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:33 -0500
Received: by mail-qv1-f67.google.com with SMTP id cv8so580784qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JbS6Xnh6/UEk+qphSqVZ3EdK4Ri8tUYlmlPZnPj+vhs=;
        b=eNx5XmVsIMpsl2a/PadR7ccsaFpI3rFpTe/bJDkso+PR7n3olCrmjOmQxGFPxqVrLQ
         4FrjCYGX+cnQzZrfvkZAzJ/nvNcYTdPT+s5V/7T8ysr2gtJAlp/X877pwSkFsn1+TOd7
         ZcjbdDLbjDwSoXm4Ztqqt0JOD0Ya1OY08wjspXE1EFbhauCHwFWA8BAKGwkILpETjc1f
         J9JckLAUFWyn/QFKwcit2eXbBwfodA2b3BSOxD/vAtIMmbq+qKMhbsb+cFkmyPh7oeNp
         /OxPeV+bcyb5GSphrya/o2EouE0GWq9PSjPEFfmMetmBnCcM5RrclDSsPqMtuh1Wrpa6
         o7Vw==
X-Gm-Message-State: APjAAAV5Za4PbheqVIoRXQUjMDCtnfCpYIFa9FDONmwAE9b/D6EYuWMx
        EIaDRrKiEa0e6TGabEyVBVs=
X-Google-Smtp-Source: APXvYqybgFCOUq+DgA1uOFjes5ovKCvZVXGMwkcGeBNk9o/YbO3RrZeCVPwNjPLJmLw4TxNa8neuCw==
X-Received: by 2002:a0c:9314:: with SMTP id d20mr5010304qvd.28.1574286692105;
        Wed, 20 Nov 2019 13:51:32 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:30 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Date:   Wed, 20 Nov 2019 16:51:03 -0500
Message-Id: <06410c758182c36e3af04249721ded50d8f2c62f.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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
 fs/btrfs/free-space-cache.c | 89 +++++++++++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h | 12 +++++
 2 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 399c641440bc..946a7df33249 100644
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
@@ -3444,6 +3509,7 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group *block_group)
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 			   u64 *trimmed, u64 start, u64 end, u64 minlen)
 {
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
 
 	*trimmed = 0;
@@ -3461,6 +3527,9 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 		goto out;
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen);
+	/* If we ended in the middle of a bitmap, reset the trimming flag. */
+	if (end % (BITS_PER_BITMAP * ctl->unit))
+		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
 out:
 	btrfs_put_block_group_trimming(block_group);
 	return ret;
@@ -3645,6 +3714,7 @@ int test_add_free_space_entry(struct btrfs_block_group *cache,
 	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
 	struct btrfs_free_space *info = NULL, *bitmap_info;
 	void *map = NULL;
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_TRIMMED;
 	u64 bytes_added;
 	int ret;
 
@@ -3686,7 +3756,8 @@ int test_add_free_space_entry(struct btrfs_block_group *cache,
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

