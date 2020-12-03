Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893F22CDB08
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgLCQUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:20:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:34652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgLCQUy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 11:20:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607012413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ck8v3h4W9mYsOofCnvrZXL5NK1StrGxVjHU7F4ygkAg=;
        b=YxdPIwTSLOgLnUZatJiuxxmrpiiIt5yv/suGt/qDsoG9CZZtD355ELP7Oe71lSYhFAD9Hs
        efr5eXpJRRnAv25lPyq8xaMIwSQ1an8ANYcpVMXuhakjmCPHYApgJH44GUfN7opuf6WwbN
        shx4I48/R0JTODgm7QqSbZc5VHXiSjU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C964AD57;
        Thu,  3 Dec 2020 16:20:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2EBEDA6E9; Thu,  3 Dec 2020 17:18:39 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove recalc_thresholds from free space ops
Date:   Thu,  3 Dec 2020 17:18:38 +0100
Message-Id: <20201203161838.29392-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After removing the inode number cache that was using the free space
cache code, we can remove at least the recalc_thresholds callback from
the ops. Both code and tests use the same callback function. It's moved
before its first use.

The use_bitmaps callback is still needed by tests to create some
extents/bitmap setup.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-cache.c       | 86 +++++++++++++++----------------
 fs/btrfs/free-space-cache.h       |  1 -
 fs/btrfs/tests/free-space-tests.c |  1 -
 3 files changed, 42 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index cd5996350cf0..93d32b823e04 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -685,6 +685,44 @@ static int io_ctl_read_bitmap(struct btrfs_io_ctl *io_ctl,
 	return 0;
 }
 
+static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
+{
+	struct btrfs_block_group *block_group = ctl->private;
+	u64 max_bytes;
+	u64 bitmap_bytes;
+	u64 extent_bytes;
+	u64 size = block_group->length;
+	u64 bytes_per_bg = BITS_PER_BITMAP * ctl->unit;
+	u64 max_bitmaps = div64_u64(size + bytes_per_bg - 1, bytes_per_bg);
+
+	max_bitmaps = max_t(u64, max_bitmaps, 1);
+
+	ASSERT(ctl->total_bitmaps <= max_bitmaps);
+
+	/*
+	 * We are trying to keep the total amount of memory used per 1GiB of
+	 * space to be MAX_CACHE_BYTES_PER_GIG.  However, with a reclamation
+	 * mechanism of pulling extents >= FORCE_EXTENT_THRESHOLD out of
+	 * bitmaps, we may end up using more memory than this.
+	 */
+	if (size < SZ_1G)
+		max_bytes = MAX_CACHE_BYTES_PER_GIG;
+	else
+		max_bytes = MAX_CACHE_BYTES_PER_GIG * div_u64(size, SZ_1G);
+
+	bitmap_bytes = ctl->total_bitmaps * ctl->unit;
+
+	/*
+	 * we want the extent entry threshold to always be at most 1/2 the max
+	 * bytes we can have, or whatever is less than that.
+	 */
+	extent_bytes = max_bytes - bitmap_bytes;
+	extent_bytes = min_t(u64, extent_bytes, max_bytes >> 1);
+
+	ctl->extents_thresh =
+		div_u64(extent_bytes, sizeof(struct btrfs_free_space));
+}
+
 static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				   struct btrfs_free_space_ctl *ctl,
 				   struct btrfs_path *path, u64 offset)
@@ -803,7 +841,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
 			ctl->total_bitmaps++;
-			ctl->op->recalc_thresholds(ctl);
+			recalculate_thresholds(ctl);
 			spin_unlock(&ctl->tree_lock);
 			if (ret) {
 				btrfs_err(fs_info,
@@ -1720,44 +1758,6 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	return ret;
 }
 
-static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
-{
-	struct btrfs_block_group *block_group = ctl->private;
-	u64 max_bytes;
-	u64 bitmap_bytes;
-	u64 extent_bytes;
-	u64 size = block_group->length;
-	u64 bytes_per_bg = BITS_PER_BITMAP * ctl->unit;
-	u64 max_bitmaps = div64_u64(size + bytes_per_bg - 1, bytes_per_bg);
-
-	max_bitmaps = max_t(u64, max_bitmaps, 1);
-
-	ASSERT(ctl->total_bitmaps <= max_bitmaps);
-
-	/*
-	 * We are trying to keep the total amount of memory used per 1GiB of
-	 * space to be MAX_CACHE_BYTES_PER_GIG.  However, with a reclamation
-	 * mechanism of pulling extents >= FORCE_EXTENT_THRESHOLD out of
-	 * bitmaps, we may end up using more memory than this.
-	 */
-	if (size < SZ_1G)
-		max_bytes = MAX_CACHE_BYTES_PER_GIG;
-	else
-		max_bytes = MAX_CACHE_BYTES_PER_GIG * div_u64(size, SZ_1G);
-
-	bitmap_bytes = ctl->total_bitmaps * ctl->unit;
-
-	/*
-	 * we want the extent entry threshold to always be at most 1/2 the max
-	 * bytes we can have, or whatever is less than that.
-	 */
-	extent_bytes = max_bytes - bitmap_bytes;
-	extent_bytes = min_t(u64, extent_bytes, max_bytes >> 1);
-
-	ctl->extents_thresh =
-		div_u64(extent_bytes, sizeof(struct btrfs_free_space));
-}
-
 static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 				       struct btrfs_free_space *info,
 				       u64 offset, u64 bytes)
@@ -1969,8 +1969,7 @@ static void add_new_bitmap(struct btrfs_free_space_ctl *ctl,
 	INIT_LIST_HEAD(&info->list);
 	link_free_space(ctl, info);
 	ctl->total_bitmaps++;
-
-	ctl->op->recalc_thresholds(ctl);
+	recalculate_thresholds(ctl);
 }
 
 static void free_bitmap(struct btrfs_free_space_ctl *ctl,
@@ -1992,7 +1991,7 @@ static void free_bitmap(struct btrfs_free_space_ctl *ctl,
 	kmem_cache_free(btrfs_free_space_bitmap_cachep, bitmap_info->bitmap);
 	kmem_cache_free(btrfs_free_space_cachep, bitmap_info);
 	ctl->total_bitmaps--;
-	ctl->op->recalc_thresholds(ctl);
+	recalculate_thresholds(ctl);
 }
 
 static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
@@ -2159,7 +2158,6 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 }
 
 static const struct btrfs_free_space_op free_space_op = {
-	.recalc_thresholds	= recalculate_thresholds,
 	.use_bitmap		= use_bitmap,
 };
 
@@ -3079,7 +3077,7 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 			kmem_cache_free(btrfs_free_space_bitmap_cachep,
 					entry->bitmap);
 			ctl->total_bitmaps--;
-			ctl->op->recalc_thresholds(ctl);
+			recalculate_thresholds(ctl);
 		} else if (!btrfs_free_space_trimmed(entry)) {
 			ctl->discardable_extents[BTRFS_STAT_CURR]--;
 		}
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index a65ed1967d5d..b87e7ecf7373 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -60,7 +60,6 @@ struct btrfs_free_space_ctl {
 };
 
 struct btrfs_free_space_op {
-	void (*recalc_thresholds)(struct btrfs_free_space_ctl *ctl);
 	bool (*use_bitmap)(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info);
 };
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index aebdf23f0cdd..8f05c1eb833f 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -399,7 +399,6 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	u64 offset;
 	u64 max_extent_size;
 	const struct btrfs_free_space_op test_free_space_ops = {
-		.recalc_thresholds = cache->free_space_ctl->op->recalc_thresholds,
 		.use_bitmap = test_use_bitmap,
 	};
 	const struct btrfs_free_space_op *orig_free_space_ops;
-- 
2.25.0

