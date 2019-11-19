Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76EB1023D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfKSMGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:06:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727066AbfKSMGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:06:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E70DB39A;
        Tue, 19 Nov 2019 12:05:59 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/6] btrfs: Move and unexport btrfs_rmap_block
Date:   Tue, 19 Nov 2019 14:05:50 +0200
Message-Id: <20191119120555.6465-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119120555.6465-1-nborisov@suse.com>
References: <20191119120555.6465-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's used only during initial block group reading to map physical
address of super block to a list of logical ones. Make it private to
block-group.c and while at it add proper kernel doc.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c     | 69 -----------------------------------
 fs/btrfs/volumes.h     |  2 --
 3 files changed, 82 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d96561d1ce90..902c246a9d38 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -14,6 +14,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "raid56.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -1516,6 +1517,87 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 	write_sequnlock(&fs_info->profiles_lock);
 }
 
+/*
+ * btrfs_rmap_block - Maps a particular @physical disk address to a list of @logical
+ * addresses. Used primarily to exclude those portions of a block group that
+ * contain super block copies.
+ *
+ * chunk_start - Logical address of block group
+ * physical - Physical address to map to logical addresses
+ * logical - Return array of logical addresses which map to @physical
+ * naddrs - Length of @logical
+ * stripe_len - size of IO stripe for the given block group
+ */
+EXPORT_FOR_TESTS
+int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+{
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 *buf;
+	u64 bytenr;
+	u64 length;
+	u64 stripe_nr;
+	u64 rmap_len;
+	int i, j, nr = 0;
+
+	em = btrfs_get_chunk_map(fs_info, chunk_start, 1);
+	if (IS_ERR(em))
+		return -EIO;
+
+	map = em->map_lookup;
+	length = em->len;
+	rmap_len = map->stripe_len;
+
+	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
+		length = div_u64(length, map->num_stripes / map->sub_stripes);
+	else if (map->type & BTRFS_BLOCK_GROUP_RAID0)
+		length = div_u64(length, map->num_stripes);
+	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		length = div_u64(length, nr_data_stripes(map));
+		rmap_len = map->stripe_len * nr_data_stripes(map);
+	}
+
+	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
+	BUG_ON(!buf); /* -ENOMEM */
+
+	for (i = 0; i < map->num_stripes; i++) {
+		if (map->stripes[i].physical > physical ||
+		    map->stripes[i].physical + length <= physical)
+			continue;
+
+		stripe_nr = physical - map->stripes[i].physical;
+		stripe_nr = div64_u64(stripe_nr, map->stripe_len);
+
+		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
+			stripe_nr = stripe_nr * map->num_stripes + i;
+			stripe_nr = div_u64(stripe_nr, map->sub_stripes);
+		} else if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
+			stripe_nr = stripe_nr * map->num_stripes + i;
+		} /* else if RAID[56], multiply by nr_data_stripes().
+		   * Alternatively, just use rmap_len below instead of
+		   * map->stripe_len */
+
+		bytenr = chunk_start + stripe_nr * rmap_len;
+		WARN_ON(nr >= map->num_stripes);
+		for (j = 0; j < nr; j++) {
+			if (buf[j] == bytenr)
+				break;
+		}
+		if (j == nr) {
+			WARN_ON(nr >= map->num_stripes);
+			buf[nr++] = bytenr;
+		}
+	}
+
+	*logical = buf;
+	*naddrs = nr;
+	*stripe_len = rmap_len;
+
+	free_extent_map(em);
+	return 0;
+}
+
 static int exclude_super_stripes(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..a1a7b543e465 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6107,75 +6107,6 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return __btrfs_map_block(fs_info, op, logical, length, bbio_ret, 0, 1);
 }
 
-int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
-{
-	struct extent_map *em;
-	struct map_lookup *map;
-	u64 *buf;
-	u64 bytenr;
-	u64 length;
-	u64 stripe_nr;
-	u64 rmap_len;
-	int i, j, nr = 0;
-
-	em = btrfs_get_chunk_map(fs_info, chunk_start, 1);
-	if (IS_ERR(em))
-		return -EIO;
-
-	map = em->map_lookup;
-	length = em->len;
-	rmap_len = map->stripe_len;
-
-	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
-		length = div_u64(length, map->num_stripes / map->sub_stripes);
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID0)
-		length = div_u64(length, map->num_stripes);
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		length = div_u64(length, nr_data_stripes(map));
-		rmap_len = map->stripe_len * nr_data_stripes(map);
-	}
-
-	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
-	BUG_ON(!buf); /* -ENOMEM */
-
-	for (i = 0; i < map->num_stripes; i++) {
-		if (map->stripes[i].physical > physical ||
-		    map->stripes[i].physical + length <= physical)
-			continue;
-
-		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64(stripe_nr, map->stripe_len);
-
-		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
-			stripe_nr = stripe_nr * map->num_stripes + i;
-			stripe_nr = div_u64(stripe_nr, map->sub_stripes);
-		} else if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-			stripe_nr = stripe_nr * map->num_stripes + i;
-		} /* else if RAID[56], multiply by nr_data_stripes().
-		   * Alternatively, just use rmap_len below instead of
-		   * map->stripe_len */
-
-		bytenr = chunk_start + stripe_nr * rmap_len;
-		WARN_ON(nr >= map->num_stripes);
-		for (j = 0; j < nr; j++) {
-			if (buf[j] == bytenr)
-				break;
-		}
-		if (j == nr) {
-			WARN_ON(nr >= map->num_stripes);
-			buf[nr++] = bytenr;
-		}
-	}
-
-	*logical = buf;
-	*naddrs = nr;
-	*stripe_len = rmap_len;
-
-	free_extent_map(em);
-	return 0;
-}
-
 static inline void btrfs_end_bbio(struct btrfs_bio *bbio, struct bio *bio)
 {
 	bio->bi_private = bbio->private;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc1b564b9cfe..12a7e0dd26bd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -417,8 +417,6 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     struct btrfs_bio **bbio_ret);
 int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		u64 logical, u64 len, struct btrfs_io_geometry *io_geom);
-int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
-- 
2.17.1

