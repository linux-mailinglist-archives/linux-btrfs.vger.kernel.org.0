Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C534F48434
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFQNhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 09:37:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfFQNhV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 09:37:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA45AAEE1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 13:37:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Use btrfs_get_io_geometry/btrfs_get_stripe_rem appropriately
Date:   Mon, 17 Jun 2019 16:37:17 +0300
Message-Id: <20190617133717.19759-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617133717.19759-1-nborisov@suse.com>
References: <20190617133717.19759-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Presently btrfs_map_block is used not only to do everything necessary
to map a bio to the underlying allocation profile but it's also used to
identify how much data could be written based on btrfs' stripe logic
without actually submitting anything. This is achieved by passing NULL
for 'bbio_ret' parameter.

This patch refactors all callers that require just the mapping length
by switching them to btrfs_get_stripe_rem instead of calling
btrfs_map_block with a special NULL value for 'bbio_ret'. It also
switches __btrfs_map_block to calling btrfs_get_io_geometry.

No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c   | 22 +++++++-------
 fs/btrfs/volumes.c | 71 ++++++----------------------------------------
 2 files changed, 21 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7126493d8d8c..253ee6e6b695 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1931,6 +1931,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
+	u64 stripe_rem_len;
 	int ret;
 
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
@@ -1938,11 +1939,12 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 
 	length = bio->bi_iter.bi_size;
 	map_length = length;
-	ret = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-			      NULL, 0);
+	ret = btrfs_get_stripe_rem(fs_info, btrfs_op(bio), logical, map_length,
+				   &stripe_rem_len);
 	if (ret < 0)
 		return ret;
-	if (map_length < length + size)
+
+	if (stripe_rem_len < length + size)
 		return 1;
 	return 0;
 }
@@ -8316,10 +8318,10 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	int ret;
 	blk_status_t status;
 
-	map_length = orig_bio->bi_iter.bi_size;
-	submit_len = map_length;
-	ret = btrfs_map_block(fs_info, btrfs_op(orig_bio), start_sector << 9,
-			      &map_length, NULL, 0);
+	submit_len = orig_bio->bi_iter.bi_size;
+	ret = btrfs_get_stripe_rem(fs_info, btrfs_op(orig_bio),
+				   start_sector << 9, submit_len,
+				   &map_length);
 	if (ret)
 		return -EIO;
 
@@ -8376,9 +8378,9 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
 
-		map_length = submit_len;
-		ret = btrfs_map_block(fs_info, btrfs_op(orig_bio),
-				      start_sector << 9, &map_length, NULL, 0);
+		ret = btrfs_get_stripe_rem(fs_info, btrfs_op(orig_bio),
+					   start_sector << 9, submit_len,
+					   &map_length);
 		if (ret)
 			goto out_err;
 	} while (submit_len > 0);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d2627d3f9043..05197620a6e2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6061,77 +6061,24 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	u64 physical_to_patch_in_first_stripe = 0;
 	u64 raid56_full_stripe_start = (u64)-1;
 
+	ASSERT(bbio_ret);
+
 	if (op == BTRFS_MAP_DISCARD)
 		return __btrfs_map_block_for_discard(fs_info, logical,
 						     *length, bbio_ret);
 
-	em = btrfs_get_chunk_map(fs_info, logical, *length);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
+	ret = btrfs_get_io_geometry(fs_info, op, logical, *length, length, &offset,
+				&stripe_len, &stripe_nr, &stripe_offset,
+				&raid56_full_stripe_start);
+	if (ret < 0)
+		return ret;
 
+	em = btrfs_get_chunk_map(fs_info, logical, *length);
+	ASSERT(em);
 	map = em->map_lookup;
-	offset = logical - em->start;
 
-	stripe_len = map->stripe_len;
-	stripe_nr = offset;
-	/*
-	 * stripe_nr counts the total number of stripes we have to stride
-	 * to get to this block
-	 */
-	stripe_nr = div64_u64(stripe_nr, stripe_len);
 	data_stripes = nr_data_stripes(map);
 
-	stripe_offset = stripe_nr * stripe_len;
-	if (offset < stripe_offset) {
-		btrfs_crit(fs_info,
-			   "stripe math has gone wrong, stripe_offset=%llu, offset=%llu, start=%llu, logical=%llu, stripe_len=%llu",
-			   stripe_offset, offset, em->start, logical,
-			   stripe_len);
-		free_extent_map(em);
-		return -EINVAL;
-	}
-
-	/* stripe_offset is the offset of this block in its stripe*/
-	stripe_offset = offset - stripe_offset;
-
-	/* if we're here for raid56, we need to know the stripe aligned start */
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		unsigned long full_stripe_len = stripe_len * data_stripes;
-		raid56_full_stripe_start = offset;
-
-		/* allow a write of a full stripe, but make sure we don't
-		 * allow straddling of stripes
-		 */
-		raid56_full_stripe_start = div64_u64(raid56_full_stripe_start,
-				full_stripe_len);
-		raid56_full_stripe_start *= full_stripe_len;
-	}
-
-	if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
-		u64 max_len;
-		/* For writes to RAID[56], allow a full stripeset across all disks.
-		   For other RAID types and for RAID[56] reads, just allow a single
-		   stripe (on a single disk). */
-		if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-		    (op == BTRFS_MAP_WRITE)) {
-			max_len = stripe_len * data_stripes -
-				(offset - raid56_full_stripe_start);
-		} else {
-			/* we limit the length of each bio to what fits in a stripe */
-			max_len = stripe_len - stripe_offset;
-		}
-		*length = min_t(u64, em->len - offset, max_len);
-	} else {
-		*length = em->len - offset;
-	}
-
-	/*
-	 * This is for when we're called from btrfs_bio_fits_in_stripe and all
-	 * it cares about is the length
-	 */
-	if (!bbio_ret)
-		goto out;
-
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 	/*
-- 
2.17.1

