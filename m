Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36337BF26
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhELODJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 10:03:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27795 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhELODE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 10:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620828114; x=1652364114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ciqe/UDzKS9sdsMrUxViz6wiA8nGpS3BWEQcny4ROW8=;
  b=g47OyVVYEb/FwBVD5EdecA/iJQgT/bZS3/O/Ave0jVAb5D35pBo7pax8
   CQfLsOhWc6nlK4CPLH3eIbRtPO+m2betLiKDLjIYo93FKYhIVuhrg6oD/
   zXGeRXr9op06Ub8R3CZS/hpypEFTDNoS8tzjaNFJxp8kovMpnOl/M8g4q
   +7ogr1B2Qev0sHBOLmqvMzsT9VcNpAuWxVnUF8WgA3uuiy/2JUVi5cBVv
   89h4iphOcxmZxxZP9Ldvy9nZd75eHNn0BxMXCztFgAGHVVjVDchaqEgSp
   UswE/oUGfT60evM3nrwO23bQRvKLnHlukmVUukHCSxm8h5rd++AuxRPwD
   A==;
IronPort-SDR: RFLqwypbUz+kjo5Sffa2i2iHaCZDf9kOGcGAzcFE9+1DvrAy5Kne5JgqltmBTs1FpkVKaDb6n0
 EUunCAzhJ/Rl9LJbTQWINeLy39RWzbQ8vOUrv7/lFFjGPpM5nooQ8tmSQigtTE64bcq2vaS/ib
 XRc7G0yc3tlKc0heUpBgDuqSS3qkCgD5ovmsk9wvPzF32XTj/w4GA7/3nevdDyZreUwSXnB6GN
 lMOE2ulNH7IVVHXsd9vjdRPNQ5FF1SgfbcKgk2W25FWU+gKak7VV7OQdLr7uHFPVvmdlA1ri4k
 sJ4=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="167902773"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 22:01:53 +0800
IronPort-SDR: BbeWS3cf2VnkJ6+c5hNzXQWiZ+FosKDUkUNxQ0fqxFa8XhM83SFtcuRjZgtKI5D58nNaxyrzPV
 z+A72EkEOb5bfmz7YeirNzlSXi7FczI3mlkzqAp/6iiy8tWcDZYU3Mq3wceSVnlS43a3x0AmPV
 THlm0EP3brr5CyeNZk9UfitX0ox8o2YA9+Y6+Tnzv1VqhJlFPDNn08Yr6SZGd8R25LCTEukNlw
 aBORIpPqk52tW+dYV/9r7pGFyW6enzABGjYmKuX9NcHPuznGJAPXP4LhMpcGyaCilo6WaW9UhF
 F66xiPFje8WSEWmVa+sP+BcF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:40:28 -0700
IronPort-SDR: 17I6y0bXQTwvKac3u7vYhyUaDFU/Kbm2g+dg73nufxaWDWoXe9V5E7AJCEBAV3I90uXKEaD4jz
 ihVFuCRSC8ik9LfMFyKgXJZjyQc22L8ydOeWu+VamSbqWHG0lpzNNtXK0Le2ad/vPoeVSnbUDb
 jl4kU3tYU/AU4cgMPpb+Bi7NqmoiRnMtYkHQ17caeorIsesaUB8xFtwWTYC/At8dE/nmcggWX5
 /0sx6ThuZxBwNiQ6Cp1hJmvXO4EYFtGJ/XwfqGuPv19nIixR5C2ieS2EmiQFNay0CUx/BGJrIO
 BEM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 May 2021 07:01:54 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: zoned: fix compressed writes
Date:   Wed, 12 May 2021 23:01:40 +0900
Message-Id: <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620824721.git.johannes.thumshirn@wdc.com>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When multiple processes write data to the same block group on a compressed
zoned filesystem, the underlying device could report I/O errors and data
corruption is possible.

This happens because on a zoned file system, compressed data writes where
sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
operation. But with REQ_OP_WRITE and parallel submission it cannot be
guaranteed that the data is always submitted aligned to the underlying
zone's write pointer.

The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zoned
filesystem is non intrusive on a regular file system or when submitting to
a conventional zone on a zoned filesystem, as it is guarded by
btrfs_use_zone_append.

Reported-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 44 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2bea01d23a5b..d27205791483 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -28,6 +28,7 @@
 #include "compression.h"
 #include "extent_io.h"
 #include "extent_map.h"
+#include "zoned.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
@@ -349,6 +350,7 @@ static void end_compressed_bio_write(struct bio *bio)
 	 */
 	inode = cb->inode;
 	cb->compressed_pages[0]->mapping = cb->inode->i_mapping;
+	btrfs_record_physical_zoned(inode, cb->start, bio);
 	btrfs_writepage_endio_finish_ordered(cb->compressed_pages[0],
 			cb->start, cb->start + cb->len - 1,
 			bio->bi_status == BLK_STS_OK);
@@ -401,6 +403,10 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	u64 first_byte = disk_start;
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
+	struct block_device *bdev;
+	const bool use_append = btrfs_use_zone_append(inode, disk_start);
+	const unsigned int bio_op =
+		use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
 
 	WARN_ON(!PAGE_ALIGNED(start));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
@@ -418,10 +424,31 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->nr_pages = nr_pages;
 
 	bio = btrfs_bio_alloc(first_byte);
-	bio->bi_opf = REQ_OP_WRITE | write_flags;
+	bio->bi_opf = bio_op | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
 
+	if (use_append) {
+		struct extent_map *em;
+		struct map_lookup *map;
+
+		em = btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
+		if (IS_ERR(em)) {
+			kfree(cb);
+			bio_put(bio);
+			return BLK_STS_NOTSUPP;
+		}
+
+		map = em->map_lookup;
+		/* We only support single profile for now */
+		ASSERT(map->num_stripes == 1);
+		bdev = map->stripes[0].dev->bdev;
+
+		free_extent_map(em);
+
+		bio_set_dev(bio, bdev);
+	}
+
 	if (blkcg_css) {
 		bio->bi_opf |= REQ_CGROUP_PUNT;
 		kthread_associate_blkcg(blkcg_css);
@@ -432,6 +459,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	bytes_left = compressed_len;
 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
 		int submit = 0;
+		int len;
 
 		page = compressed_pages[pg_index];
 		page->mapping = inode->vfs_inode.i_mapping;
@@ -439,9 +467,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
 							  0);
 
+		if (pg_index == 0 && use_append)
+			len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
+		else
+			len = bio_add_page(bio, page, PAGE_SIZE, 0);
+
 		page->mapping = NULL;
-		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
-		    PAGE_SIZE) {
+		if (submit || len < PAGE_SIZE) {
 			/*
 			 * inc the count before we submit the bio so
 			 * we know the end IO handler won't happen before
@@ -465,11 +497,15 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			}
 
 			bio = btrfs_bio_alloc(first_byte);
-			bio->bi_opf = REQ_OP_WRITE | write_flags;
+			bio->bi_opf = bio_op | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
 			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
+			/*
+			 * Use bio_add_page() to ensure the bio has at least one
+			 * page.
+			 */
 			bio_add_page(bio, page, PAGE_SIZE, 0);
 		}
 		if (bytes_left < PAGE_SIZE) {
-- 
2.31.1

