Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF6449E70
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 22:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhKHVwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 16:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbhKHVwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 16:52:04 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A88C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 13:49:20 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u25so12882728qve.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 13:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7xGFGslXWucY1JCdv1IMe+wZEQGOzGWXI+okoWFjLE=;
        b=st6ubEtquJoXEpKjKjxE5vtzXnRguvzBth7CdJSayn0BX/UEgMVz5smoCeharxSVMU
         z8FjCt+Hi3QerseEIuVSYMyJkHZvhbL8ao3jS0Nke1Q6mB3pQqMrfESgoF3aZwwXn2ko
         AZLjEMoMWTGzlv9u8Rrx5Sjocd70kon0n3VIeURh8Ihw+Lxh9Z6Zdyo6+0/fYZQeF24D
         /vQWhsH/CM0N9KFxyonZyTtZc4o126vSCPsewndc5dw11YtOjinUJlgBUy9uGtAnpcCb
         f0LTfw7oo5UHS3j1S+GK3qW+Dyji32P5qVWfDhyWj1JOZdZtok8TbIa1XqBNZdkFUJVC
         utuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7xGFGslXWucY1JCdv1IMe+wZEQGOzGWXI+okoWFjLE=;
        b=A2AZBHibigGS5ZXPNoMx5GwlfulO921GQpXN01sMcsmDqi3R0CB7c/1vONIpBUZfA3
         97bSHKNY8ZHDWpkXCQi65O3emmkxIhVxae1goZ6uN2MOHRTMsEJ6A9sjLwq1KZaqtyW6
         r0miy93Mtr0BET1hQoPfPt5EJIzfgriglkIcpTBBCXluC8wr7PR+lqIMJzaFniB2RCip
         c+3kQ3nM5WiDkWAtTnEwINc+z9Un/744cWZ3ZXZn7dm4ZZxUroI8Dv2pyBRxEvR1iAV0
         fQLP0MExzo+tFL/G7Kbkd1A+T7vzi5A03a5Y5MQ36ag+yvMWxKD69JOpy+rgv6we1MDe
         6uwg==
X-Gm-Message-State: AOAM533nHZhccroVCm1jDhdHz8p9PTBjo1VXE1aCCx1cUz6f9E/gGgkY
        dfC7DvyY5wuIz15IozskJXRW5PputPYmNA==
X-Google-Smtp-Source: ABdhPJwJrB4iLQ0ie2No0pclixmDTSBlDzdyx+BAskSHHCn+vDc5dgE/CFnBjVoUznztBNLEuC1sFw==
X-Received: by 2002:a05:6214:23c5:: with SMTP id hr5mr2306274qvb.59.1636408158826;
        Mon, 08 Nov 2021 13:49:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u10sm2359537qtx.3.2021.11.08.13.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:49:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] btrfs: index free space entries on size
Date:   Mon,  8 Nov 2021 16:49:17 -0500
Message-Id: <d69c29c8428a923d526aa2fe068d421d14667b47.1636408067.git.josef@toxicpanda.com>
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v2->v3:
- Added a comment to explain why we don't break if our size is too small after
  the alignment check if we're using bytes index, as it's subtle.
- Added Filipe's reviewed-by.

v1->v2:
- removed the extraneous format change I made.
- added comments to some of the more subtle parts of the patch.

 fs/btrfs/free-space-cache.c | 91 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.h |  2 +
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f3fee88c8ee0..b8ff6956a3af 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1580,6 +1580,44 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
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
@@ -1708,6 +1746,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		    struct btrfs_free_space *info)
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
 	ctl->free_extents--;
 
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
@@ -1734,6 +1773,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
+	tree_insert_bytes(ctl, info);
+
 	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]++;
 		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
@@ -1880,7 +1921,7 @@ static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
 /* Cache the size of the max extent in bytes */
 static struct btrfs_free_space *
 find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
-		unsigned long align, u64 *max_extent_size)
+		unsigned long align, u64 *max_extent_size, bool use_bytes_index)
 {
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -1891,15 +1932,37 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
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
 
@@ -1916,6 +1979,13 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
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
@@ -2486,6 +2556,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	info->bytes = bytes;
 	info->trim_state = trim_state;
 	RB_CLEAR_NODE(&info->offset_index);
+	RB_CLEAR_NODE(&info->bytes_index);
 
 	spin_lock(&ctl->tree_lock);
 
@@ -2799,6 +2870,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	ctl->start = block_group->start;
 	ctl->private = block_group;
 	ctl->op = &free_space_op;
+	ctl->free_space_bytes = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&ctl->trimming_ranges);
 	mutex_init(&ctl->cache_writeout_mutex);
 
@@ -2864,6 +2936,7 @@ static void __btrfs_return_cluster_to_free_space(
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
+		tree_insert_bytes(ctl, entry);
 	}
 	cluster->root = RB_ROOT;
 	spin_unlock(&cluster->lock);
@@ -2965,12 +3038,14 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
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
 
@@ -3254,6 +3329,7 @@ static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
 
 	cluster->window_start = start * ctl->unit + entry->offset;
 	rb_erase(&entry->offset_index, &ctl->free_space_offset);
+	rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
 	ret = tree_insert_offset(&cluster->root, entry->offset,
 				 &entry->offset_index, 1);
 	ASSERT(!ret); /* -EEXIST; Logic error */
@@ -3344,6 +3420,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
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

