Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC653C582
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiFCG5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiFCG5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 02:57:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA565FA
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=waAa4B5GFtvVrgx/ZrxWkbb4f1hMjtZbxN+zngPhO48=; b=UuKpvLepoDYtQe/ygSef8Icaua
        9C+JPiAWXu5OieIoBOXBkA1H3fS75x1IPQSYNUs37tZrpWjh/GKRdWKF34ehA6YHeH8/LNoUkzsjt
        q+EmnWSd2eNtHQuJuMnWQ1Zj0w90BD2wK8zKaU8/udiTUoF2UHIrFlMu2aptxjXrlOUzL6C04azCw
        LMs2CZwshic7T27iRobnhgGSU3knDt5pyuGgOVLmI1NZ/Stu9nWNUuZKfqsOMlvByFGCzQEZNOa/I
        1J4VM/NECuE8DCIGufH3LVgfg3sHrMDVBJi1yR2FI2E/16Em0JWrUHm+ybc+8BbwAzO+v1NjkeD5+
        zVKsHhEQ==;
Received: from [2001:4bb8:185:a81e:b29a:8b56:eb9a:ca3b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx1FP-0069A1-5i; Fri, 03 Jun 2022 06:57:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: split discard handling out of btrfs_map_block
Date:   Fri,  3 Jun 2022 08:57:25 +0200
Message-Id: <20220603065725.40708-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mapping block for discard doesn't really share any code with the regular
block mapping case.  Split it out into an entirely separate helper
that just returns an array of btrfs_discard_stripe structures and the
number of stripes.

This removes the need for the length field in the btrfs_io_context
structure, so remove tht.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent-tree.c | 73 +++++++++++++++++-------------------------
 fs/btrfs/volumes.c     | 73 +++++++++++++++++-------------------------
 fs/btrfs/volumes.h     | 10 +++++-
 3 files changed, 67 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fb367689d9d20..5397ccbbc78a5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1269,7 +1269,7 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	return ret;
 }
 
-static int do_discard_extent(struct btrfs_io_stripe *stripe, u64 *bytes)
+static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
 {
 	struct btrfs_device *dev = stripe->dev;
 	struct btrfs_fs_info *fs_info = dev->fs_info;
@@ -1316,76 +1316,61 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 	u64 discarded_bytes = 0;
 	u64 end = bytenr + num_bytes;
 	u64 cur = bytenr;
-	struct btrfs_io_context *bioc = NULL;
 
 	/*
-	 * Avoid races with device replace and make sure our bioc has devices
-	 * associated to its stripes that don't go away while we are discarding.
+	 * Avoid races with device replace and make sure the devices in the
+	 * stripes don't go away while we are discarding.
 	 */
 	btrfs_bio_counter_inc_blocked(fs_info);
 	while (cur < end) {
-		struct btrfs_io_stripe *stripe;
+		struct btrfs_discard_stripe *stripes;
+		unsigned int num_stripes;
 		int i;
 
 		num_bytes = end - cur;
-		/* Tell the block device(s) that the sectors can be discarded */
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
-				      &num_bytes, &bioc, 0);
-		/*
-		 * Error can be -ENOMEM, -ENOENT (no such chunk mapping) or
-		 * -EOPNOTSUPP. For any such error, @num_bytes is not updated,
-		 * thus we can't continue anyway.
-		 */
-		if (ret < 0)
-			goto out;
+		stripes = btrfs_map_discard(fs_info, cur, &num_bytes,
+					    &num_stripes);
+		if (IS_ERR(stripes)) {
+			ret = PTR_ERR(stripes);
+			if (ret == -EOPNOTSUPP)
+				ret = 0;
+			break;
+		}
 
-		stripe = bioc->stripes;
-		for (i = 0; i < bioc->num_stripes; i++, stripe++) {
+		for (i = 0; i < num_stripes; i++) {
+			struct btrfs_discard_stripe *stripe = stripes + i;
 			u64 bytes;
-			struct btrfs_device *device = stripe->dev;
 
-			if (!device->bdev) {
+			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
 
-			if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+			if (!test_bit(BTRFS_DEV_STATE_WRITEABLE,
+					&stripe->dev->dev_state))
 				continue;
 
 			ret = do_discard_extent(stripe, &bytes);
-			if (!ret) {
-				discarded_bytes += bytes;
-			} else if (ret != -EOPNOTSUPP) {
+			if (ret) {
 				/*
-				 * Logic errors or -ENOMEM, or -EIO, but
-				 * unlikely to happen.
-				 *
-				 * And since there are two loops, explicitly
-				 * go to out to avoid confusion.
+				 * Keep going if discard is not supported by the
+				 * device.
 				 */
-				btrfs_put_bioc(bioc);
-				goto out;
+				if (ret != -EOPNOTSUPP)
+					break;
+				ret = 0;
+			} else {
+				discarded_bytes += bytes;
 			}
-
-			/*
-			 * Just in case we get back EOPNOTSUPP for some reason,
-			 * just ignore the return value so we don't screw up
-			 * people calling discard_extent.
-			 */
-			ret = 0;
 		}
-		btrfs_put_bioc(bioc);
+		kfree(stripes);
+		if (ret)
+			break;
 		cur += num_bytes;
 	}
-out:
 	btrfs_bio_counter_dec(fs_info);
-
 	if (actual_bytes)
 		*actual_bytes = discarded_bytes;
-
-
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index be3fb88ae14f8..1437488f8c226 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5914,18 +5914,17 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc)
 		kfree(bioc);
 }
 
-/* can REQ_OP_DISCARD be sent with other REQ like REQ_OP_WRITE? */
 /*
  * Please note that, discard won't be sent to target device of device
  * replace.
  */
-static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
-					 u64 logical, u64 *length_ret,
-					 struct btrfs_io_context **bioc_ret)
+struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
+					       u64 logical, u64 *length_ret,
+					       u32 *num_stripes)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
-	struct btrfs_io_context *bioc;
+	struct btrfs_discard_stripe *stripes;
 	u64 length = *length_ret;
 	u64 offset;
 	u64 stripe_nr;
@@ -5934,29 +5933,25 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	u64 stripe_cnt;
 	u64 stripe_len;
 	u64 stripe_offset;
-	u64 num_stripes;
 	u32 stripe_index;
 	u32 factor = 0;
 	u32 sub_stripes = 0;
 	u64 stripes_per_dev = 0;
 	u32 remaining_stripes = 0;
 	u32 last_stripe = 0;
-	int ret = 0;
+	int ret;
 	int i;
 
-	/* Discard always returns a bioc. */
-	ASSERT(bioc_ret);
-
 	em = btrfs_get_chunk_map(fs_info, logical, length);
 	if (IS_ERR(em))
-		return PTR_ERR(em);
+		return ERR_CAST(em);
 
 	map = em->map_lookup;
+
 	/* we don't discard raid56 yet */
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	ret = -EOPNOTSUPP;
+	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		goto out_free_map;
 
 	offset = logical - em->start;
 	length = min_t(u64, em->start + em->len - logical, length);
@@ -5982,7 +5977,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	 * device we have to walk to find the data, and stripe_index is
 	 * the number of our device in the stripe array
 	 */
-	num_stripes = 1;
+	*num_stripes = 1;
 	stripe_index = 0;
 	if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 			 BTRFS_BLOCK_GROUP_RAID10)) {
@@ -5992,7 +5987,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 			sub_stripes = map->sub_stripes;
 
 		factor = map->num_stripes / sub_stripes;
-		num_stripes = min_t(u64, map->num_stripes,
+		*num_stripes = min_t(u64, map->num_stripes,
 				    sub_stripes * stripe_cnt);
 		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
 		stripe_index *= sub_stripes;
@@ -6002,31 +5997,29 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 		last_stripe *= sub_stripes;
 	} else if (map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK |
 				BTRFS_BLOCK_GROUP_DUP)) {
-		num_stripes = map->num_stripes;
+		*num_stripes = map->num_stripes;
 	} else {
 		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
 					&stripe_index);
 	}
 
-	bioc = alloc_btrfs_io_context(fs_info, num_stripes, 0);
-	if (!bioc) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	ret = -ENOMEM;
+	stripes = kcalloc(*num_stripes, sizeof(*stripes), GFP_NOFS);
+	if (!stripes)
+		goto out_free_map;
 
-	for (i = 0; i < num_stripes; i++) {
-		bioc->stripes[i].physical =
+	for (i = 0; i < *num_stripes; i++) {
+		stripes[i].physical =
 			map->stripes[stripe_index].physical +
 			stripe_offset + stripe_nr * map->stripe_len;
-		bioc->stripes[i].dev = map->stripes[stripe_index].dev;
+		stripes[i].dev = map->stripes[stripe_index].dev;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 				 BTRFS_BLOCK_GROUP_RAID10)) {
-			bioc->stripes[i].length = stripes_per_dev *
-				map->stripe_len;
+			stripes[i].length = stripes_per_dev * map->stripe_len;
 
 			if (i / sub_stripes < remaining_stripes)
-				bioc->stripes[i].length += map->stripe_len;
+				stripes[i].length += map->stripe_len;
 
 			/*
 			 * Special for the first stripe and
@@ -6037,17 +6030,17 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 			 *    off     end_off
 			 */
 			if (i < sub_stripes)
-				bioc->stripes[i].length -= stripe_offset;
+				stripes[i].length -= stripe_offset;
 
 			if (stripe_index >= last_stripe &&
 			    stripe_index <= (last_stripe +
 					     sub_stripes - 1))
-				bioc->stripes[i].length -= stripe_end_offset;
+				stripes[i].length -= stripe_end_offset;
 
 			if (i == sub_stripes - 1)
 				stripe_offset = 0;
 		} else {
-			bioc->stripes[i].length = length;
+			stripes[i].length = length;
 		}
 
 		stripe_index++;
@@ -6057,12 +6050,11 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	*bioc_ret = bioc;
-	bioc->map_type = map->type;
-	bioc->num_stripes = num_stripes;
-out:
 	free_extent_map(em);
-	return ret;
+	return stripes;
+out_free_map:
+	free_extent_map(em);
+	return ERR_PTR(ret);
 }
 
 /*
@@ -6205,7 +6197,6 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 					bioc->stripes + i;
 
 				new->physical = old->physical;
-				new->length = old->length;
 				new->dev = dev_replace->tgtdev;
 				bioc->tgtdev_map[i] = index_where_to_add;
 				index_where_to_add++;
@@ -6246,8 +6237,6 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				bioc->stripes + num_stripes;
 
 			tgtdev_stripe->physical = physical_of_found;
-			tgtdev_stripe->length =
-				bioc->stripes[index_srcdev].length;
 			tgtdev_stripe->dev = dev_replace->tgtdev;
 			bioc->tgtdev_map[index_srcdev] = num_stripes;
 
@@ -6601,10 +6590,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		      u64 logical, u64 *length,
 		      struct btrfs_io_context **bioc_ret, int mirror_num)
 {
-	if (op == BTRFS_MAP_DISCARD)
-		return __btrfs_map_block_for_discard(fs_info, logical,
-						     length, bioc_ret);
-
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
 				 mirror_num, 0);
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 66a25a25034f9..af30fc5ce2111 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -418,7 +418,12 @@ struct btrfs_io_stripe {
 		/* For the endio handler */
 		struct btrfs_io_context *bioc;
 	};
-	u64 length; /* only used for discard mappings */
+};
+
+struct btrfs_discard_stripe {
+	struct btrfs_device *dev;
+	u64 physical;
+	u64 length;
 };
 
 /*
@@ -557,6 +562,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret);
+struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
+					       u64 logical, u64 *length_ret,
+					       u32 *num_stripes);
 int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
 			  enum btrfs_map_op op, u64 logical,
 			  struct btrfs_io_geometry *io_geom);
-- 
2.30.2

