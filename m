Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6941C81E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbhI2PS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344945AbhI2PS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 11:18:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17890C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:17:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 11so1639216qvd.11
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzKQRLTiMddlc3cbrjYF66C13i2j1TXaf96T4VvarVA=;
        b=E2tM3ODeups7IRuePbS+InmDlG6O4r3j/dlIMeXIOmIAByHTAR8oRn43AapgredZ85
         +wu7FHnFlr0rn12tpHErn7YBDfubrtENwfVeTsCCro9MhTZN+ChKNo6fg1Nc/RMZjpLE
         uBvnqgqVwsaCOc8/B/Z79WHHsSJnv/Od8skOr/WiCc4JwG/KbLHy+vmm41W1eU/30Gw7
         Ye6K85IjGbOe7WtUfn5Y8vvPOaWkctfekpGV48YkR8nU5CMYw5QRUd1j6RlMNA3qYid3
         jwNKQ0nvVzm14C2G5RQylmqKV3s9t3ZahYZkTAxqgo/rknmqrddP2q7iRQjCcG2negwW
         mZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzKQRLTiMddlc3cbrjYF66C13i2j1TXaf96T4VvarVA=;
        b=nPfYoqQDGpqX8Vmk9MBZezSDNESOsfTWLLLmdwpUHjnfxIouzZxIAfnpwJUqMVKg46
         nIWBPOwFVMRYvgtzkcvDiKjTpvQqBsMQqYxUP9IA1IwimzuMpxQVD9l90fnVHGQVut47
         9T3kUpvDfe2t+YtWqSKwVAdLVk367d1hU5YkfWENB8cyR2bhENeuevxssn3z/NiM9mMa
         uAEY/EjJPuQ/aYO6GWOGEZIU698FSywG4iFPOevTQQttlULu4BeDKN+9V/jKkQjafmnP
         ES7cEjXkkxmtpQoIPZEp7EtWIsKCunMFwCxCKW0qfbOEV3YDfyVuHvAsX3oDSa9nURF5
         ROlA==
X-Gm-Message-State: AOAM532AMXEIGrNZFQsqxGLm1MErW47mVhEHMhs1jzaBWivYkpgoaa1I
        5xLsVi9FYQ8b3xfd2swen6/b8SPppn8MbA==
X-Google-Smtp-Source: ABdhPJxQLPAtUxwd2SzoseKtpuqI+BAjdj1XUEhQfTWZCgUIH8IwYoR/VAGmABDUHr2be/V98PHjAg==
X-Received: by 2002:a0c:8e8e:: with SMTP id x14mr441191qvb.67.1632928634229;
        Wed, 29 Sep 2021 08:17:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y22sm105110qkp.9.2021.09.29.08.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:17:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: index free space entries on size
Date:   Wed, 29 Sep 2021 11:17:12 -0400
Message-Id: <a012c6719317617e9ea00f7df05f5be56029bcbb.1632928572.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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
---
v1->v2:
- removed the extraneous format change I made.
- added comments to some of the more subtle parts of the patch.

 fs/btrfs/free-space-cache.c | 84 +++++++++++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h |  2 +
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d26819b1cf6..abc050295fff 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1576,6 +1576,44 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
 	return 0;
 }
 
+static u64 free_space_info_bytes(struct btrfs_free_space *info)
+{
+	if (info->bitmap && info->max_extent_size)
+		return info->max_extent_size;
+	return info->bytes;
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
+		if (free_space_info_bytes(info) < free_space_info_bytes(tmp)) {
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
@@ -1704,6 +1742,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		    struct btrfs_free_space *info)
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
 	ctl->free_extents--;
 
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
@@ -1730,6 +1769,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
+	tree_insert_bytes(ctl, info);
+
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]++;
 		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
@@ -1876,7 +1917,7 @@ static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
 /* Cache the size of the max extent in bytes */
 static struct btrfs_free_space *
 find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
-		unsigned long align, u64 *max_extent_size)
+		unsigned long align, u64 *max_extent_size, bool use_bytes_index)
 {
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -1887,15 +1928,37 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 	if (!ctl->free_space_offset.rb_node)
 		goto out;
 
-	entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset), 0, 1);
-	if (!entry)
-		goto out;
+	if (use_bytes_index) {
+		node = rb_first_cached(&ctl->free_space_bytes);
+	} else {
+		entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),
+					   0, 1);
+		if (!entry)
+			goto out;
+		node = &entry->offset_index;
+	}
 
-	for (node = &entry->offset_index; node; node = rb_next(node)) {
-		entry = rb_entry(node, struct btrfs_free_space, offset_index);
+	for (; node; node = rb_next(node)) {
+		if (use_bytes_index)
+			entry = rb_entry(node, struct btrfs_free_space,
+					 bytes_index);
+		else
+			entry = rb_entry(node, struct btrfs_free_space,
+					 offset_index);
+
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
 
@@ -2482,6 +2545,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	info->bytes = bytes;
 	info->trim_state = trim_state;
 	RB_CLEAR_NODE(&info->offset_index);
+	RB_CLEAR_NODE(&info->bytes_index);
 
 	spin_lock(&ctl->tree_lock);
 
@@ -2795,6 +2859,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	ctl->start = block_group->start;
 	ctl->private = block_group;
 	ctl->op = &free_space_op;
+	ctl->free_space_bytes = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&ctl->trimming_ranges);
 	mutex_init(&ctl->cache_writeout_mutex);
 
@@ -2860,6 +2925,7 @@ static void __btrfs_return_cluster_to_free_space(
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
+		tree_insert_bytes(ctl, entry);
 	}
 	cluster->root = RB_ROOT;
 	spin_unlock(&cluster->lock);
@@ -2961,12 +3027,14 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
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
 
@@ -3250,6 +3318,7 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 
 	cluster->window_start = start * ctl->unit + entry->offset;
 	rb_erase(&entry->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
 	ret = tree_insert_offset(&cluster->root, entry->offset,
 				 &entry->offset_index, 1);
 	ASSERT(!ret); /* -EEXIST; Logic error */
@@ -3340,6 +3409,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
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
2.29.2

