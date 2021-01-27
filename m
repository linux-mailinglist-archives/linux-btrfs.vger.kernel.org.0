Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D6305DB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhA0N7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 08:59:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhA0N6w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 08:58:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9212AE2D;
        Wed, 27 Jan 2021 13:58:08 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
Date:   Wed, 27 Jan 2021 14:57:27 +0100
Message-Id: <20210127135728.30276-1-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Before this change, the btrfs_get_io_geometry() function was calling
btrfs_get_chunk_map() to get the extent mapping, necessary for
calculating the I/O geometry. It was using that extent mapping only
internally and freeing the pointer after its execution.

That resulted in calling btrfs_get_chunk_map() de facto twice by the
__btrfs_map_block() function. It was calling btrfs_get_io_geometry()
first and then calling btrfs_get_chunk_map() directly to get the extent
mapping, used by the rest of the function.

This change fixes that by passing the extent mapping to the
btrfs_get_io_geometry() function as an argument.

v2:
When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
- Use errno_to_blk_status(PTR_ERR(em)) as the status
- Set em to NULL

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/inode.c   | 38 +++++++++++++++++++++++++++++---------
 fs/btrfs/volumes.c | 39 ++++++++++++++++-----------------------
 fs/btrfs/volumes.h |  5 +++--
 3 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0dbe1aaa0b71..e2ee3a9c1140 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2183,9 +2183,10 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 logical = bio->bi_iter.bi_sector << 9;
+	struct extent_map *em;
 	u64 length = 0;
 	u64 map_length;
-	int ret;
+	int ret = 0;
 	struct btrfs_io_geometry geom;
 
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
@@ -2193,14 +2194,21 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 
 	length = bio->bi_iter.bi_size;
 	map_length = length;
-	ret = btrfs_get_io_geometry(fs_info, btrfs_op(bio), logical, map_length,
-				    &geom);
+	em = btrfs_get_chunk_map(fs_info, logical, map_length);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical,
+				    map_length, &geom);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (geom.len < length + size)
-		return 1;
-	return 0;
+	if (geom.len < length + size) {
+		ret = 1;
+		goto out;
+	}
+out:
+	free_extent_map(em);
+	return ret;
 }
 
 /*
@@ -7941,10 +7949,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	u64 submit_len;
 	int clone_offset = 0;
 	int clone_len;
+	int logical;
 	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
 	struct btrfs_dio_data *dio_data = iomap->private;
+	struct extent_map *em;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
 	if (!dip) {
@@ -7970,11 +7980,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	}
 
 	start_sector = dio_bio->bi_iter.bi_sector;
+	logical = start_sector << 9;
 	submit_len = dio_bio->bi_iter.bi_size;
 
 	do {
-		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
-					    start_sector << 9, submit_len,
+		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
+		if (IS_ERR(em)) {
+			status = errno_to_blk_status(PTR_ERR(em));
+			em = NULL;
+			goto out_err;
+		}
+		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
+					    logical, submit_len,
 					    &geom);
 		if (ret) {
 			status = errno_to_blk_status(ret);
@@ -8030,12 +8047,15 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		clone_offset += clone_len;
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
+
+		free_extent_map(em);
 	} while (submit_len > 0);
 	return BLK_QC_T_NONE;
 
 out_err:
 	dip->dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
+	free_extent_map(em);
 	return BLK_QC_T_NONE;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a8ec8539cd8d..4c753b17c0a2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5940,23 +5940,24 @@ static bool need_full_stripe(enum btrfs_map_op op)
 }
 
 /*
- * btrfs_get_io_geometry - calculates the geomery of a particular (address, len)
+ * btrfs_get_io_geometry - calculates the geometry of a particular (address, len)
  *		       tuple. This information is used to calculate how big a
  *		       particular bio can get before it straddles a stripe.
  *
- * @fs_info - the filesystem
- * @logical - address that we want to figure out the geometry of
- * @len	    - the length of IO we are going to perform, starting at @logical
- * @op      - type of operation - write or read
- * @io_geom - pointer used to return values
+ * @fs_info: the filesystem
+ * @em:      mapping containing the logical extent
+ * @op:      type of operation - write or read
+ * @logical: address that we want to figure out the geometry of
+ * @len:     the length of IO we are going to perform, starting at @logical
+ * @io_geom: pointer used to return values
  *
  * Returns < 0 in case a chunk for the given logical address cannot be found,
  * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
  */
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-			u64 logical, u64 len, struct btrfs_io_geometry *io_geom)
+int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
+			  enum btrfs_map_op op, u64 logical, u64 len,
+			  struct btrfs_io_geometry *io_geom)
 {
-	struct extent_map *em;
 	struct map_lookup *map;
 	u64 offset;
 	u64 stripe_offset;
@@ -5964,14 +5965,9 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	u64 stripe_len;
 	u64 raid56_full_stripe_start = (u64)-1;
 	int data_stripes;
-	int ret = 0;
 
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
-	em = btrfs_get_chunk_map(fs_info, logical, len);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
-
 	map = em->map_lookup;
 	/* Offset of this logical address in the chunk */
 	offset = logical - em->start;
@@ -5985,8 +5981,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		btrfs_crit(fs_info,
 "stripe math has gone wrong, stripe_offset=%llu offset=%llu start=%llu logical=%llu stripe_len=%llu",
 			stripe_offset, offset, em->start, logical, stripe_len);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* stripe_offset is the offset of this block in its stripe */
@@ -6033,10 +6028,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom->stripe_offset = stripe_offset;
 	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
 
-out:
-	/* once for us */
-	free_extent_map(em);
-	return ret;
+	return 0;
 }
 
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
@@ -6069,12 +6061,13 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	ASSERT(bbio_ret);
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
-	ret = btrfs_get_io_geometry(fs_info, op, logical, *length, &geom);
+	em = btrfs_get_chunk_map(fs_info, logical, *length);
+	ASSERT(!IS_ERR(em));
+
+	ret = btrfs_get_io_geometry(fs_info, em, op, logical, *length, &geom);
 	if (ret < 0)
 		return ret;
 
-	em = btrfs_get_chunk_map(fs_info, logical, *length);
-	ASSERT(!IS_ERR(em));
 	map = em->map_lookup;
 
 	*length = geom.len;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c43663d9c22e..04e2b26823c2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -440,8 +440,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_bio **bbio_ret);
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		u64 logical, u64 len, struct btrfs_io_geometry *io_geom);
+int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
+			  enum btrfs_map_op op, u64 logical, u64 len,
+			  struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
-- 
2.30.0

