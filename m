Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE0455F71
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhKRP3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKRP3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:29:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE33C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 07:26:22 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t11so6398100qtw.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldCdbPckpYX4U4Yyx1b7QUkFtQZd5mMuNciWT2s6vig=;
        b=BokEeUuiGxQLOvHCt5Qv8Vydxu7i/eh1PgHOQ6BMFUqncI6WBsSyM3MrZ/H6MqmHNh
         5VmWPVgchgdUdBnDNVjAZqOug2X4dbLQK/3JKHM2nmOUBqF+BVrqrwTaE2Dnou/ttL38
         YXQyW1j42FGHjRYXyy1r94xuUwgzEdH1ae8GZfp6gnLFnNC581hVW0pU5o1M93lO0Bd5
         djdzyw83w541Kc12Qyppf74WfzM5wR6oq1RbNDu9Liku3fTvFN9WTx+xpU2SFmtVf6Er
         GrlIlFfSjy9rFyxkdDxUx+ztRKuOMwlyu3pyM5b/dKL8Ksiv0G+AQsl97EmAoIgJxej6
         aFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldCdbPckpYX4U4Yyx1b7QUkFtQZd5mMuNciWT2s6vig=;
        b=mz6u53rJkxvvhOpaczhhSfcx6eZ3jwhqbFVvTcLYrFMeqpOgfDVcgexj9ZfSTIYY9g
         s8C0PgbjM0uXXl5OYYREjvaf/ECPBJ7her8goYR2EsYfSZ8z6bco9E6A2zg/SO5Gwnfr
         NpkblUXkyP1UG+htFWoIjWN7Nt1PI6mCXfFv7WERcxcer7/JBzR1QLk0UnBOn4x16oPO
         ddLy8jqyPWH/m/q7pkk0VjrhlJyoRVjZDYqp0rUGeaICa8Ief3hax98SVo5EkklfwzVX
         jEJ1Xu6c2SSTWlLkfBEqzxt1CVwtItX6JbulaomNJjhcem2am9urvwsn7d60ZoftTA16
         XF/w==
X-Gm-Message-State: AOAM530+lxNdEOOknNFslCGCpunIleMNIJ0imeTgkIAldERdeAp5MA0U
        k0Q0bdviCxAN7yyWmKqn9huShT0TUpjHIQ==
X-Google-Smtp-Source: ABdhPJy3XKDbhPiSJ9u/OcA8tq63C0q7xHGaHuG8V7MTM+n53v+bB9gjHbBrrqOZ2sfWCIQPlR81fQ==
X-Received: by 2002:ac8:5a10:: with SMTP id n16mr26568775qta.278.1637249180615;
        Thu, 18 Nov 2021 07:26:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm16808qta.46.2021.11.18.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 07:26:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 2/2] btrfs: index free space entries on size
Date:   Thu, 18 Nov 2021 10:26:16 -0500
Message-Id: <41d72c6b01a1a1510015902d3a5a5729d3a159c5.1637248994.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637248994.git.josef@toxicpanda.com>
References: <cover.1637248994.git.josef@toxicpanda.com>
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
 fs/btrfs/free-space-cache.c       | 198 +++++++++++++++++++++++-------
 fs/btrfs/free-space-cache.h       |   2 +
 fs/btrfs/tests/free-space-tests.c | 181 +++++++++++++++++++++++++++
 3 files changed, 337 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 543394acec44..587b8d18d870 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1580,6 +1580,68 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
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
+static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
+{
+	if (entry->bitmap && entry->max_extent_size)
+		return entry->max_extent_size;
+	return entry->bytes;
+}
+
+/*
+ * This is indexed in reverse of what we generally do for rb-tree's, the largest
+ * chunks are left most and the smallest are rightmost.  This is so that we can
+ * take advantage of the cached property of the cached rb-tree and simply get
+ * the largest free space chunk right away.
+ */
+static void tree_insert_bytes(struct btrfs_free_space_ctl *ctl,
+			      struct btrfs_free_space *info)
+{
+	struct rb_root_cached *root = &ctl->free_space_bytes;
+	struct rb_node **p = &root->rb_root.rb_node;
+	struct rb_node *parent_node = NULL;
+	struct btrfs_free_space *tmp;
+	bool leftmost = true;
+
+	while (*p) {
+		parent_node = *p;
+		tmp = rb_entry(parent_node, struct btrfs_free_space,
+			       bytes_index);
+		if (get_max_extent_size(info) < get_max_extent_size(tmp)) {
+			p = &(*p)->rb_right;
+			leftmost = false;
+		} else {
+			p = &(*p)->rb_left;
+		}
+	}
+
+	rb_link_node(&info->bytes_index, parent_node, p);
+	rb_insert_color_cached(&info->bytes_index, root, leftmost);
+}
+
 /*
  * searches the tree for the given offset.
  *
@@ -1708,6 +1770,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		    struct btrfs_free_space *info)
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
 	ctl->free_extents--;
 
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
@@ -1734,6 +1797,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
+	tree_insert_bytes(ctl, info);
+
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]++;
 		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
@@ -1744,6 +1809,22 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
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
+	tree_insert_bytes(ctl, info);
+}
+
 static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 				       struct btrfs_free_space *info,
 				       u64 offset, u64 bytes)
@@ -1762,6 +1843,8 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 	if (info->max_extent_size > ctl->unit)
 		info->max_extent_size = 0;
 
+	relink_bitmap_entry(ctl, info);
+
 	if (start && test_bit(start - 1, info->bitmap))
 		extent_delta++;
 
@@ -1797,9 +1880,16 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
 
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
 
@@ -1867,44 +1957,14 @@ static int search_bitmap(struct btrfs_free_space_ctl *ctl,
 
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
@@ -1914,16 +1974,38 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 
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
 
@@ -1940,6 +2022,13 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
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
@@ -1947,6 +2036,7 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 		}
 
 		if (entry->bitmap) {
+			struct rb_node *old_next = rb_next(node);
 			u64 size = *bytes;
 
 			ret = search_bitmap(ctl, entry, &tmp, &size, true);
@@ -1959,6 +2049,15 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
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
 
@@ -2107,12 +2206,6 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
-	/*
-	 * We set some bytes, we have no idea what the max extent size is
-	 * anymore.
-	 */
-	info->max_extent_size = 0;
-
 	return bytes_to_set;
 
 }
@@ -2510,6 +2603,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	info->bytes = bytes;
 	info->trim_state = trim_state;
 	RB_CLEAR_NODE(&info->offset_index);
+	RB_CLEAR_NODE(&info->bytes_index);
 
 	spin_lock(&ctl->tree_lock);
 
@@ -2823,6 +2917,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	ctl->start = block_group->start;
 	ctl->private = block_group;
 	ctl->op = &free_space_op;
+	ctl->free_space_bytes = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&ctl->trimming_ranges);
 	mutex_init(&ctl->cache_writeout_mutex);
 
@@ -2888,6 +2983,7 @@ static void __btrfs_return_cluster_to_free_space(
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
+		tree_insert_bytes(ctl, entry);
 	}
 	cluster->root = RB_ROOT;
 	spin_unlock(&cluster->lock);
@@ -2989,12 +3085,14 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
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
 
@@ -3278,6 +3376,17 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 
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
@@ -3368,6 +3477,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
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
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index 8f05c1eb833f..6f922cea8ff8 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -824,6 +824,184 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	return 0;
 }
 
+static bool bytes_index_use_bitmap(struct btrfs_free_space_ctl *ctl,
+				   struct btrfs_free_space *info)
+{
+	return true;
+}
+
+static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
+{
+	const struct btrfs_free_space_op test_free_space_ops = {
+		.use_bitmap = bytes_index_use_bitmap,
+	};
+	const struct btrfs_free_space_op *orig_free_space_ops;
+	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
+	struct btrfs_free_space *entry;
+	struct rb_node *n;
+	u64 offset, max_extent_size, bytes;
+	int ret, i;
+
+	test_msg("running bytes index tests");
+
+	/* First just validate that it does everything in order. */
+	offset = 0;
+	for (i = 0; i < 10; i++) {
+		bytes = (i + 1) * SZ_1M;
+		ret = test_add_free_space_entry(cache, offset, bytes, 0);
+		if (ret) {
+			test_err("couldn't add extent entry %d\n", ret);
+			return ret;
+		}
+		offset += bytes + sectorsize;
+	}
+
+	for (n = rb_first_cached(&ctl->free_space_bytes), i = 9; n;
+	     n = rb_next(n), i--) {
+		entry = rb_entry(n, struct btrfs_free_space, bytes_index);
+		bytes = (i + 1) * SZ_1M;
+		if (entry->bytes != bytes) {
+			test_err("invalid bytes index order, found %llu expected %llu",
+				 entry->bytes, bytes);
+			return -EINVAL;
+		}
+	}
+
+	/* Now validate bitmaps do the correct thing. */
+	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	for (i = 0; i < 2; i++) {
+		offset = i * BITS_PER_BITMAP * sectorsize;
+		bytes = (i + 1) * SZ_1M;
+		ret = test_add_free_space_entry(cache, offset, bytes, 1);
+		if (ret) {
+			test_err("couldn't add bitmap entry");
+			return ret;
+		}
+	}
+
+	for (n = rb_first_cached(&ctl->free_space_bytes), i = 1; n;
+	     n = rb_next(n), i--) {
+		entry = rb_entry(n, struct btrfs_free_space, bytes_index);
+		bytes = (i + 1) * SZ_1M;
+		if (entry->bytes != bytes) {
+			test_err("invalid bytes index order, found %llu expected %llu",
+				 entry->bytes, bytes);
+			return -EINVAL;
+		}
+	}
+
+	/* Now validate bitmaps with different ->max_extent_size. */
+	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	orig_free_space_ops = cache->free_space_ctl->op;
+	cache->free_space_ctl->op = &test_free_space_ops;
+
+	ret = test_add_free_space_entry(cache, 0, sectorsize, 1);
+	if (ret) {
+		test_err("couldn't add bitmap entry");
+		return ret;
+	}
+
+	offset = BITS_PER_BITMAP * sectorsize;
+	ret = test_add_free_space_entry(cache, offset, sectorsize, 1);
+	if (ret) {
+		test_err("couldn't add bitmap_entry");
+		return ret;
+	}
+
+	/*
+	 * Now set a bunch of sectorsize extents in the first entry so it's
+	 * ->bytes is large.
+	 */
+	for (i = 2; i < 20; i += 2) {
+		offset = sectorsize * i;
+		ret = btrfs_add_free_space(cache, offset, sectorsize);
+		if (ret) {
+			test_err("error populating sparse bitmap %d", ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Now set a contiguous extent in the second bitmap so its
+	 * ->max_extent_size is larger than the first bitmaps.
+	 */
+	offset = (BITS_PER_BITMAP * sectorsize) + sectorsize;
+	ret = btrfs_add_free_space(cache, offset, sectorsize);
+	if (ret) {
+		test_err("error adding contiguous extent %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Since we don't set ->max_extent_size unless we search everything
+	 * should be indexed on bytes.
+	 */
+	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
+			 struct btrfs_free_space, bytes_index);
+	if (entry->bytes != (10 * sectorsize)) {
+		test_err("error, wrong entry in the first slot in bytes_index");
+		return -EINVAL;
+	}
+
+	max_extent_size = 0;
+	offset = btrfs_find_space_for_alloc(cache, cache->start, sectorsize * 3,
+					    0, &max_extent_size);
+	if (offset != 0) {
+		test_err("found space to alloc even though we don't have enough space");
+		return -EINVAL;
+	}
+
+	if (max_extent_size != (2 * sectorsize)) {
+		test_err("got the wrong max_extent size %llu expected %llu",
+			 max_extent_size, (unsigned long long)(2 * sectorsize));
+		return -EINVAL;
+	}
+
+	/*
+	 * The search should have re-arranged the bytes index to use the
+	 * ->max_extent_size, validate it's now what we expect it to be.
+	 */
+	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
+			 struct btrfs_free_space, bytes_index);
+	if (entry->bytes != (2 * sectorsize)) {
+		test_err("error, the bytes index wasn't recalculated properly");
+		return -EINVAL;
+	}
+
+	/* Add another sectorsize to re-arrange the tree back to ->bytes. */
+	offset = (BITS_PER_BITMAP * sectorsize) - sectorsize;
+	ret = btrfs_add_free_space(cache, offset, sectorsize);
+	if (ret) {
+		test_err("error adding extent to the sparse entry %d", ret);
+		return ret;
+	}
+
+	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
+			 struct btrfs_free_space, bytes_index);
+	if (entry->bytes != (11 * sectorsize)) {
+		test_err("error, wrong entry in the first slot in bytes_index");
+		return -EINVAL;
+	}
+
+	/*
+	 * Now make sure we find our correct entry after searching that will
+	 * result in a re-arranging of the tree.
+	 */
+	max_extent_size = 0;
+	offset = btrfs_find_space_for_alloc(cache, cache->start, sectorsize * 2,
+					    0, &max_extent_size);
+	if (offset != (BITS_PER_BITMAP * sectorsize)) {
+		test_err("error, found %llu instead of %llu for our alloc",
+			 offset,
+			 (unsigned long long)(BITS_PER_BITMAP * sectorsize));
+		return -EINVAL;
+	}
+
+	cache->free_space_ctl->op = orig_free_space_ops;
+	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	return 0;
+}
+
 int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
@@ -871,6 +1049,9 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 		goto out;
 
 	ret = test_steal_space_from_bitmap_to_extent(cache, sectorsize);
+	if (ret)
+		goto out;
+	ret = test_bytes_index(cache, sectorsize);
 out:
 	btrfs_free_dummy_block_group(cache);
 	btrfs_free_dummy_root(root);
-- 
2.26.3

