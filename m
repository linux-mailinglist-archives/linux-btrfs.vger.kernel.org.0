Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379CB572DFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiGMGO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiGMGO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F65DA0D6
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/V3zzH1/27qhDtzfo1bJPWZYl3VngIAFnktQs/l/2I8=; b=huVF90qX5BUXsb/MHmWK8GEg4q
        3g49IpNJpm1IV6AXzJcfcUfRaWJ3YF+xQmicpzl4Vh3a/Uw5g6kbKVUHOhj6aN1iWNwwl3+4jddix
        ZYQPBZOs1Tjomr4InjSMfiFTqCvLwEyoUVXtxu2YadBrlBpmqUSjWnIuoAV10wqsp0PejquVPQIHe
        HcXBIIhNNWHqXTKaq0dfay6kuLtXy6xcmoO0LXzlOgAJpVzMM1T9tITRlOP895f/+9wKwInF/1z+s
        pf+5/4nYrPXmxvU06SxTdzmMQYwWk9Fi7GETYtA5DJFsDVJV7v05ag6Vx5rjPIRqavkb3UP+RkQVD
        HPCzs4fw==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdg-000T8F-Sw; Wed, 13 Jul 2022 06:14:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: make the btrfs_io_context allocation in __btrfs_map_block optional
Date:   Wed, 13 Jul 2022 08:13:58 +0200
Message-Id: <20220713061359.1980118-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need for most of the btrfs_io_context when doing I/O to a
single device.  To support such I/O without the extra btrfs_io_context
allocation, turn the mirror_num argument into a pointer so that it can
be used to output the selected mirror number, and add an optional
argument that points to a btrfs_io_stripe structure, which will be
filled with a single extent if provided by the caller.  In that case
the btrfs_io_context allocation can be skipped as all information for
the single device I/O is provided in the mirror_num argument and the
on-stack btrfs_io_stripe.  A caller that makes use of this new
argument will be added in the next commit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 60 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 73e538da31bc4..6824634786c2c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -250,10 +250,10 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
 static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op,
-			     u64 logical, u64 *length,
+			     enum btrfs_map_op op, u64 logical, u64 *length,
 			     struct btrfs_io_context **bioc_ret,
-			     int mirror_num, int need_raid_map);
+			     struct btrfs_io_stripe *smap,
+			     int *mirror_num_p, int need_raid_map);
 
 /*
  * Device locking
@@ -6088,7 +6088,7 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	ret = __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				logical, &length, &bioc, 0, 0);
+				logical, &length, &bioc, NULL, NULL, 0);
 	if (ret) {
 		ASSERT(bioc == NULL);
 		return ret;
@@ -6347,11 +6347,19 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	return 0;
 }
 
+static void set_stripe(struct btrfs_io_stripe *dst, struct map_lookup *map,
+		       u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
+{
+	dst->dev = map->stripes[stripe_index].dev;
+	dst->physical = map->stripes[stripe_index].physical +
+			stripe_offset + stripe_nr * map->stripe_len;
+}
+
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op,
-			     u64 logical, u64 *length,
+			     enum btrfs_map_op op, u64 logical, u64 *length,
 			     struct btrfs_io_context **bioc_ret,
-			     int mirror_num, int need_raid_map)
+			     struct btrfs_io_stripe *smap,
+			     int *mirror_num_p, int need_raid_map)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -6362,6 +6370,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	int data_stripes;
 	int i;
 	int ret = 0;
+	int mirror_num = mirror_num_p ? *mirror_num_p : 0;
 	int num_stripes;
 	int max_errors = 0;
 	int tgtdev_indexes = 0;
@@ -6522,6 +6531,29 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		tgtdev_indexes = num_stripes;
 	}
 
+	/*
+	 * If this I/O maps to a single device, try to return the device and
+	 * physical block information on the stack instead of allocating an
+	 * I/O context structure.
+	 */
+	if (smap && num_alloc_stripes == 1 &&
+	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
+	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
+	     !dev_replace->tgtdev)) {
+		if (unlikely(patch_the_first_stripe_for_dev_replace)) {
+			smap->dev = dev_replace->tgtdev;
+			smap->physical = physical_to_patch_in_first_stripe;
+			*mirror_num_p = map->num_stripes + 1;
+		} else {
+			set_stripe(smap, map, stripe_index, stripe_offset,
+				   stripe_nr);
+			*mirror_num_p = mirror_num;
+		}
+		*bioc_ret = NULL;
+		ret = 0;
+		goto out;
+	}
+
 	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
@@ -6529,9 +6561,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
-		bioc->stripes[i].dev = map->stripes[stripe_index].dev;
+		set_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
+			   stripe_nr);
 		stripe_index++;
 	}
 
@@ -6599,7 +6630,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		      struct btrfs_io_context **bioc_ret, int mirror_num)
 {
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
-				 mirror_num, 0);
+				 NULL, &mirror_num, 0);
 }
 
 /* For Scrub/replace */
@@ -6607,7 +6638,8 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret)
 {
-	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
+	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
+				 NULL, NULL, 1);
 }
 
 /*
@@ -6817,8 +6849,8 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	struct btrfs_io_context *bioc = NULL;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bioc, mirror_num, 1);
+	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				&bioc, NULL, &mirror_num, 1);
 	if (ret) {
 		btrfs_bio_counter_dec(fs_info);
 		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-- 
2.30.2

