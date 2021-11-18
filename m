Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE616456516
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKRVg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 16:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhKRVgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 16:36:25 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7DAC06173E
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 13:33:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p4so7992738qkm.7
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR0U2f+lrDdBB+F/tKuTqNoKipsh8lGSP391cjvXK9I=;
        b=MLlMHPR5oQ8JvIyfHz0R90IJE+zHrMkKkYC1dND5VKhtdVR/3zWjqhYFxi4cLjxnTI
         waC5pdwf13AMIGkAk7gnUByKTzT5rJTkPoJomS0mdW2vjtDnuKzNToMbDZUTeKXJZzzX
         G2tO7jhAbdr+/w3IaY8BZgAjBmu5rAKCtjsAzqplVfIK/5CWic1CJUUvp9u1UgHIs3R4
         fILN4bPGLM9QV3+rXG7jDXAWzIeuYkqeoAiXqBQXfEg6j6HfEQX0zaO6Rrw1ndsW0GK1
         IoQ0fxxaoatK08Vg+Lw9MCtw/0JHP4qvHKwWkEMUMamwbJL+4ana7ib8xlaoEpM+gnG2
         32uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR0U2f+lrDdBB+F/tKuTqNoKipsh8lGSP391cjvXK9I=;
        b=Q7bB+/A/JtZKiEgYn0gDxqFN26j3H/TBVpdGzbD2jbjzpdkbzG22QrwaR+7f8/dFEp
         QLfqEm2UBy43NC2QEvetQMDaO2yRQYddax+yUNDxtTRw+z2OzYyj+fy75z6r0X8ossAa
         aBUYxepOUvGjZ1D0bsv3DJIHeBNmaqAVmQ7xb7p/ZrNbqTgVs+rv5WGVGsKEMwa9CCci
         dsfY97JphYQdWX+DmbNB3XPV9o81BCUg/4BpyM85fpZP68Uwm1xE0s56taNiQYAsRl3H
         qx386pzJKsD/cDWKMbQH415S/L/y3bjZAd1JTq/02dq7YSonBV6HvfBGzlhLxtSq+UN7
         KRWA==
X-Gm-Message-State: AOAM533rsUB3+tt4ICBJZ4lEAvzS9xXIbpvPuyVSlV/2EekkyslSBw6v
        kzu2uM9smL3lm6fvfXJFyqzJ07Ij+1J+nQ==
X-Google-Smtp-Source: ABdhPJwEQgJc2d+UJ/xGM1AKACoZ5KxFQvGTM7kzfbbD3Db3nLI79wAFWzktCGKBdRalYAu590SN4A==
X-Received: by 2002:a05:620a:2686:: with SMTP id c6mr24145971qkp.223.1637271203236;
        Thu, 18 Nov 2021 13:33:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t15sm526672qta.45.2021.11.18.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:33:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v5 2/3] btrfs: index free space entries on size
Date:   Thu, 18 Nov 2021 16:33:15 -0500
Message-Id: <afe97640a3d170bea4be47e7ac1487bc81be3a89.1637271014.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637271014.git.josef@toxicpanda.com>
References: <cover.1637271014.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we index free space on offset only, because usually we have a
hint from the allocator that we want to honor for locality reasons.
However if we fail to use this hint we have to go back to a brute force
search through the free space entries to find a large enough extent.

With sufficiently fragmented free space this becomes quite expensive, as
we have to linearly search all of the free space entries to find if we
have a part that's long enough.

To fix this add a cached rb tree to index based on free space entry
bytes.  This will allow us to quickly look up the largest chunk in the
free space tree for this block group, and stop searching once we've
found an entry that is too small to satisfy our allocation.  We simply
choose to use this tree if we're searching from the beginning of the
block group, as we know we do not care about locality at that point.

I wrote an allocator test that creates a 10TiB ram backed null block
device and then fallocates random files until the file system is full.
I think go through and delete all of the odd files.  Then I spawn 8
threads that fallocate 64mib files (1/2 our extent size cap) until the
file system is full again.  I use bcc's funclatency to measure the
latency of find_free_extent.  The baseline results are

     nsecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 10356    |****                                    |
       512 -> 1023       : 58242    |*************************               |
      1024 -> 2047       : 74418    |********************************        |
      2048 -> 4095       : 90393    |****************************************|
      4096 -> 8191       : 79119    |***********************************     |
      8192 -> 16383      : 35614    |***************                         |
     16384 -> 32767      : 13418    |*****                                   |
     32768 -> 65535      : 12811    |*****                                   |
     65536 -> 131071     : 17090    |*******                                 |
    131072 -> 262143     : 26465    |***********                             |
    262144 -> 524287     : 40179    |*****************                       |
    524288 -> 1048575    : 55469    |************************                |
   1048576 -> 2097151    : 48807    |*********************                   |
   2097152 -> 4194303    : 26744    |***********                             |
   4194304 -> 8388607    : 35351    |***************                         |
   8388608 -> 16777215   : 13918    |******                                  |
  16777216 -> 33554431   : 21       |                                        |

avg = 908079 nsecs, total: 580889071441 nsecs, count: 639690

And the patch results are

     nsecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 6883     |**                                      |
       512 -> 1023       : 54346    |*********************                   |
      1024 -> 2047       : 79170    |********************************        |
      2048 -> 4095       : 98890    |****************************************|
      4096 -> 8191       : 81911    |*********************************       |
      8192 -> 16383      : 27075    |**********                              |
     16384 -> 32767      : 14668    |*****                                   |
     32768 -> 65535      : 13251    |*****                                   |
     65536 -> 131071     : 15340    |******                                  |
    131072 -> 262143     : 26715    |**********                              |
    262144 -> 524287     : 43274    |*****************                       |
    524288 -> 1048575    : 53870    |*********************                   |
   1048576 -> 2097151    : 55368    |**********************                  |
   2097152 -> 4194303    : 41036    |****************                        |
   4194304 -> 8388607    : 24927    |**********                              |
   8388608 -> 16777215   : 33       |                                        |
  16777216 -> 33554431   : 9        |                                        |

avg = 623599 nsecs, total: 397259314759 nsecs, count: 637042

There's a little variation in the amount of calls done because of timing
of the threads with metadata requirements, but the avg, total, and
count's are relatively consistent between runs (usually within 2-5% of
each other).  As you can see here we have around a 30% decrease in
average latency with a 30% decrease in overall time spent in
find_free_extent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 181 +++++++++++++++++++++++++++---------
 fs/btrfs/free-space-cache.h |   2 +
 2 files changed, 139 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 543394acec44..d71b9fadab37 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1580,6 +1580,50 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
 	return 0;
 }
 
+/*
+ * This is a little subtle.  We *only* have ->max_extent_size set if we actually
+ * searched through the bitmap and figured out the largest ->max_extent_size,
+ * otherwise it's 0.  In the case that it's 0 we don't want to tell the
+ * allocator the wrong thing, we want to use the actual real max_extent_size
+ * we've found already if it's larger, or we want to use ->bytes.
+ *
+ * This matters because find_free_space() will skip entries who's ->bytes is
+ * less than the required bytes.  So if we didn't search down this bitmap, we
+ * may pick some previous entry that has a smaller ->max_extent_size than we
+ * have.  For example, assume we have two entries, one that has
+ * ->max_extent_size set to 4k and ->bytes set to 1M.  A second entry hasn't set
+ * ->max_extent_size yet, has ->bytes set to 8k and it's contiguous.  We will
+ *  call into find_free_space(), and return with max_extent_size == 4k, because
+ *  that first bitmap entry had ->max_extent_size set, but the second one did
+ *  not.  If instead we returned 8k we'd come in searching for 8k, and find the
+ *  8k contiguous range.
+ *
+ *  Consider the other case, we have 2 8k chunks in that second entry and still
+ *  don't have ->max_extent_size set.  We'll return 16k, and the next time the
+ *  allocator comes in it'll fully search our second bitmap, and this time it'll
+ *  get an uptodate value of 8k as the maximum chunk size.  Then we'll get the
+ *  right allocation the next loop through.
+ */
+static inline u64 get_max_extent_size(const struct btrfs_free_space *entry)
+{
+	if (entry->bitmap && entry->max_extent_size)
+		return entry->max_extent_size;
+	return entry->bytes;
+}
+
+/*
+ * We want the largest entry to be leftmost, so this is inverted from what you'd
+ * normally expect.
+ */
+static bool entry_less(struct rb_node *node, const struct rb_node *parent)
+{
+	const struct btrfs_free_space *entry, *exist;
+
+	entry = rb_entry(node, struct btrfs_free_space, bytes_index);
+	exist = rb_entry(parent, struct btrfs_free_space, bytes_index);
+	return get_max_extent_size(exist) < get_max_extent_size(entry);
+}
+
 /*
  * searches the tree for the given offset.
  *
@@ -1708,6 +1752,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		    struct btrfs_free_space *info)
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
 	ctl->free_extents--;
 
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
@@ -1734,6 +1779,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
+	rb_add_cached(&info->bytes_index, &ctl->free_space_bytes, entry_less);
+
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]++;
 		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
@@ -1744,6 +1791,22 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	return ret;
 }
 
+static void relink_bitmap_entry(struct btrfs_free_space_ctl *ctl,
+				struct btrfs_free_space *info)
+{
+	ASSERT(info->bitmap);
+
+	/*
+	 * If our entry is empty it's because we're on a cluster and we don't
+	 * want to re-link it into our ctl bytes index.
+	 */
+	if (RB_EMPTY_NODE(&info->bytes_index))
+		return;
+
+	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
+	rb_add_cached(&info->bytes_index, &ctl->free_space_bytes, entry_less);
+}
+
 static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 				       struct btrfs_free_space *info,
 				       u64 offset, u64 bytes)
@@ -1762,6 +1825,8 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 	if (info->max_extent_size > ctl->unit)
 		info->max_extent_size = 0;
 
+	relink_bitmap_entry(ctl, info);
+
 	if (start && test_bit(start - 1, info->bitmap))
 		extent_delta++;
 
@@ -1797,9 +1862,16 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
 
 	bitmap_set(info->bitmap, start, count);
 
+	/*
+	 * We set some bytes, we have no idea what the max extent size is
+	 * anymore.
+	 */
+	info->max_extent_size = 0;
 	info->bytes += bytes;
 	ctl->free_space += bytes;
 
+	relink_bitmap_entry(ctl, info);
+
 	if (start && test_bit(start - 1, info->bitmap))
 		extent_delta--;
 
@@ -1867,44 +1939,14 @@ static int search_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	*bytes = (u64)(max_bits) * ctl->unit;
 	bitmap_info->max_extent_size = *bytes;
+	relink_bitmap_entry(ctl, bitmap_info);
 	return -1;
 }
 
-/*
- * This is a little subtle.  We *only* have ->max_extent_size set if we actually
- * searched through the bitmap and figured out the largest ->max_extent_size,
- * otherwise it's 0.  In the case that it's 0 we don't want to tell the
- * allocator the wrong thing, we want to use the actual real max_extent_size
- * we've found already if it's larger, or we want to use ->bytes.
- *
- * This matters because find_free_space() will skip entries who's ->bytes is
- * less than the required bytes.  So if we didn't search down this bitmap, we
- * may pick some previous entry that has a smaller ->max_extent_size than we
- * have.  For example, assume we have two entries, one that has
- * ->max_extent_size set to 4k and ->bytes set to 1M.  A second entry hasn't set
- * ->max_extent_size yet, has ->bytes set to 8k and it's contiguous.  We will
- *  call into find_free_space(), and return with max_extent_size == 4k, because
- *  that first bitmap entry had ->max_extent_size set, but the second one did
- *  not.  If instead we returned 8k we'd come in searching for 8k, and find the
- *  8k contiguous range.
- *
- *  Consider the other case, we have 2 8k chunks in that second entry and still
- *  don't have ->max_extent_size set.  We'll return 16k, and the next time the
- *  allocator comes in it'll fully search our second bitmap, and this time it'll
- *  get an uptodate value of 8k as the maximum chunk size.  Then we'll get the
- *  right allocation the next loop through.
- */
-static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
-{
-	if (entry->bitmap && entry->max_extent_size)
-		return entry->max_extent_size;
-	return entry->bytes;
-}
-
 /* Cache the size of the max extent in bytes */
 static struct btrfs_free_space *
 find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
-		unsigned long align, u64 *max_extent_size)
+		unsigned long align, u64 *max_extent_size, bool use_bytes_index)
 {
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -1914,16 +1956,38 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 
 	if (!ctl->free_space_offset.rb_node)
 		goto out;
+again:
+	if (use_bytes_index) {
+		node = rb_first_cached(&ctl->free_space_bytes);
+	} else {
+		entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),
+					   0, 1);
+		if (!entry)
+			goto out;
+		node = &entry->offset_index;
+	}
 
-	entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset), 0, 1);
-	if (!entry)
-		goto out;
+	for (; node; node = rb_next(node)) {
+		if (use_bytes_index)
+			entry = rb_entry(node, struct btrfs_free_space,
+					 bytes_index);
+		else
+			entry = rb_entry(node, struct btrfs_free_space,
+					 offset_index);
 
-	for (node = &entry->offset_index; node; node = rb_next(node)) {
-		entry = rb_entry(node, struct btrfs_free_space, offset_index);
+		/*
+		 * If we are using the bytes index then all subsequent entries
+		 * in this tree are going to be < bytes, so simply set the max
+		 * extent size and exit the loop.
+		 *
+		 * If we're using the offset index then we need to keep going
+		 * through the rest of the tree.
+		 */
 		if (entry->bytes < *bytes) {
 			*max_extent_size = max(get_max_extent_size(entry),
 					       *max_extent_size);
+			if (use_bytes_index)
+				break;
 			continue;
 		}
 
@@ -1940,6 +2004,13 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 			tmp = entry->offset;
 		}
 
+		/*
+		 * We don't break here if we're using the bytes index because we
+		 * may have another entry that has the correct alignment that is
+		 * the right size, so we don't want to miss that possibility.
+		 * At worst this adds another loop through the logic, but if we
+		 * broke here we could prematurely ENOSPC.
+		 */
 		if (entry->bytes < *bytes + align_off) {
 			*max_extent_size = max(get_max_extent_size(entry),
 					       *max_extent_size);
@@ -1947,6 +2018,7 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 		}
 
 		if (entry->bitmap) {
+			struct rb_node *old_next = rb_next(node);
 			u64 size = *bytes;
 
 			ret = search_bitmap(ctl, entry, &tmp, &size, true);
@@ -1959,6 +2031,15 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 					max(get_max_extent_size(entry),
 					    *max_extent_size);
 			}
+
+			/*
+			 * The bitmap may have gotten re-arranged in the space
+			 * index here because the max_extent_size may have been
+			 * updated.  Start from the beginning again if this
+			 * happened.
+			 */
+			if (use_bytes_index && old_next != rb_next(node))
+				goto again;
 			continue;
 		}
 
@@ -2107,12 +2188,6 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
-	/*
-	 * We set some bytes, we have no idea what the max extent size is
-	 * anymore.
-	 */
-	info->max_extent_size = 0;
-
 	return bytes_to_set;
 
 }
@@ -2510,6 +2585,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	info->bytes = bytes;
 	info->trim_state = trim_state;
 	RB_CLEAR_NODE(&info->offset_index);
+	RB_CLEAR_NODE(&info->bytes_index);
 
 	spin_lock(&ctl->tree_lock);
 
@@ -2823,6 +2899,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	ctl->start = block_group->start;
 	ctl->private = block_group;
 	ctl->op = &free_space_op;
+	ctl->free_space_bytes = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&ctl->trimming_ranges);
 	mutex_init(&ctl->cache_writeout_mutex);
 
@@ -2888,6 +2965,8 @@ static void __btrfs_return_cluster_to_free_space(
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
+		rb_add_cached(&entry->bytes_index, &ctl->free_space_bytes,
+			      entry_less);
 	}
 	cluster->root = RB_ROOT;
 	spin_unlock(&cluster->lock);
@@ -2989,12 +3068,14 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+	bool use_bytes_index = (offset == block_group->start);
 
 	ASSERT(!btrfs_is_zoned(block_group->fs_info));
 
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
-				block_group->full_stripe_len, max_extent_size);
+				block_group->full_stripe_len, max_extent_size,
+				use_bytes_index);
 	if (!entry)
 		goto out;
 
@@ -3278,6 +3359,17 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 
 	cluster->window_start = start * ctl->unit + entry->offset;
 	rb_erase(&entry->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
+
+	/*
+	 * We need to know if we're currently on the normal space index when we
+	 * manipulate the bitmap so that we know we need to remove and re-insert
+	 * it into the space_index tree.  Clear the bytes_index node here so the
+	 * bitmap manipulation helpers know not to mess with the space_index
+	 * until this bitmap entry is added back into the normal cache.
+	 */
+	RB_CLEAR_NODE(&entry->bytes_index);
+
 	ret = tree_insert_offset(&cluster->root, entry->offset,
 				 &entry->offset_index, 1);
 	ASSERT(!ret); /* -EEXIST; Logic error */
@@ -3368,6 +3460,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
 			continue;
 
 		rb_erase(&entry->offset_index, &ctl->free_space_offset);
+		rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
 		ret = tree_insert_offset(&cluster->root, entry->offset,
 					 &entry->offset_index, 0);
 		total_size += entry->bytes;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 1f23088d43f9..dd982d204d2d 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -22,6 +22,7 @@ enum btrfs_trim_state {
 
 struct btrfs_free_space {
 	struct rb_node offset_index;
+	struct rb_node bytes_index;
 	u64 offset;
 	u64 bytes;
 	u64 max_extent_size;
@@ -45,6 +46,7 @@ static inline bool btrfs_free_space_trimming_bitmap(
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
 	struct rb_root free_space_offset;
+	struct rb_root_cached free_space_bytes;
 	u64 free_space;
 	int extents_thresh;
 	int free_extents;
-- 
2.26.3

