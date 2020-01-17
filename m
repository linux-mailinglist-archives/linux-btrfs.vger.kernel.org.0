Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1D140A2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgAQMvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:51:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51277 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgAQMvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579265475; x=1610801475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WA5F+FX0E9WeJOkw1sFa98+qZMvbx/Z2qgjl1FT0UKI=;
  b=lRGfiGru+fW0XLR98jMASbyt7pfyMjZublaSmuxWM3+wknaoIuWY1tYh
   QpYhDBm+nyr4vFtDBVOjEnQiE/nf8XPkVj61CdjcbRUOO4uYREeBr0axA
   7Wt/zI8yih/fe1yKmQjwBRW4W2CwcoMQ7phMTqH8Idp1EMPfXnZUONQSz
   8GlGsati9hAJr6EUTN1rp7+omW7ViwWS1/VVLs+jslEhKG8Kj91WrG082
   z+DdWR0K9AZqg/3TghF7XKol/T8RzK7UvEDGPXSAmy4YcPxqncAC6m2CR
   5EumfSU8tizGX8Vstna2dlfqbmLmhI5uctl+NGAQa42meY29UvOTT1SXh
   w==;
IronPort-SDR: rjtAspJ5w9zIYVHXh91yMO1T0c2ZuWahnPS6IMHSeam/n59JquddXXJ2NOMRzqmNbW6xsuMc0z
 fff5sYRF0r37IUCVxCaGTUBM80JSgrRaWCxlgm8/31XGGi715I/dONxENFMjGgFNzJCImmaMff
 0jQqwqXAWawHeD7gSE6pcZZnF9ewh0AKLe8GkXuzCCD7M6n5NXdpe3j2cssWrw19BP+3agjBNH
 2534HcbYV00LJ6SdCQZ2lPCqtc/itMUxyVK4Ujmv7BAcbY2wDrXsvhITYRZq0g9ZQ+CD2Hs0YI
 HpM=
X-IronPort-AV: E=Sophos;i="5.70,330,1574092800"; 
   d="scan'208";a="235550984"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2020 20:51:15 +0800
IronPort-SDR: jlMSaOaafkaz8Ib5sT0+P61KqLyeMV+Z6ujzIkcru69gj0c2F5cim2ywQ3jgW8lC6usB3QeE8C
 /CIcGBOP/ufXt2g9eiMDZPbLsGIS+vu9fSQDDZWF7xwClVzWkqi1Sw02M0X41ZXeSKHlqOOrGk
 DWb9EO/ZLAyO/jkpvaEPrvMOYACnBc66lpb0zKzkax43T5mVgX3jGOq19PPWQcNvFH27sSvmo5
 kUq6m6YFb0XyJO8KzVvBMN81Jtvn+tH/4Anv5864zKLydaEMk5nIXRy8YmXi7eRugXYxE9/kA0
 WBSUbCnBkgnM94FOnJU0IXq4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:44:48 -0800
IronPort-SDR: 05sxgocP+J35Gos13f8TyiLaO/HHZVu36c+LHG7tlxAMLJupweOH3hvmlhe5JLaNv0+TBqmwXG
 1P4P6p6yqn617wYhIIeOdfR5BLRJ51ZgkoI6sQwiWQToTKM3ioRLATX3KONIyIia80L8xLEk43
 UTm4rKJeW24zfxByFcXYL5KFRsA+NGfAfqsVFwZgpZq6J42HtxkRPC9nJrX0NJZpoK8pePkRMA
 faZ8pGRq1mg1vTAtuAvXfw9W8O2xDT1lDjpEtnWGlAOryvo/g9IvwIlnAX7rCFB91jEXezLIJm
 /4E=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2020 04:51:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/5] btrfs: remove buffer_heads form superblock mirror integrity checking
Date:   Fri, 17 Jan 2020 21:51:05 +0900
Message-Id: <20200117125105.20989-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The integrity checking code for the superblock mirrors is the last remaining
user of buffer_heads in BTRFS, change it to using plain BIOs as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/check-integrity.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 4f6db2fe482a..9a614b19b6b3 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -77,7 +77,6 @@
 
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 #include <linux/mutex.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
@@ -762,28 +761,41 @@ static int btrfsic_process_superblock_dev_mirror(
 	struct btrfs_fs_info *fs_info = state->fs_info;
 	struct btrfs_super_block *super_tmp;
 	u64 dev_bytenr;
-	struct buffer_head *bh;
 	struct btrfsic_block *superblock_tmp;
 	int pass;
 	struct block_device *const superblock_bdev = device->bdev;
+	struct page *page;
+	struct bio bio;
+	struct bio_vec bio_vec;
+	int ret;
 
 	/* super block bytenr is always the unmapped device bytenr */
 	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
 	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)
 		return -1;
-	bh = __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,
-		     BTRFS_SUPER_INFO_SIZE);
-	if (NULL == bh)
+
+	page = alloc_page(GFP_NOIO);
+	if (!page)
+		return -1;
+
+	bio_init(&bio, &bio_vec, 1);
+	bio.bi_iter.bi_sector = dev_bytenr >> SECTOR_SHIFT;
+	bio_set_dev(&bio, superblock_bdev);
+	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
+	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
+
+	ret = submit_bio_wait(&bio);
+	if (ret)
 		return -1;
-	super_tmp = (struct btrfs_super_block *)
-	    (bh->b_data + (dev_bytenr & (BTRFS_BDEV_BLOCKSIZE - 1)));
+
+	super_tmp = page_address(page);
 
 	if (btrfs_super_bytenr(super_tmp) != dev_bytenr ||
 	    btrfs_super_magic(super_tmp) != BTRFS_MAGIC ||
 	    memcmp(device->uuid, super_tmp->dev_item.uuid, BTRFS_UUID_SIZE) ||
 	    btrfs_super_nodesize(super_tmp) != state->metablock_size ||
 	    btrfs_super_sectorsize(super_tmp) != state->datablock_size) {
-		brelse(bh);
+		__free_page(page);
 		return 0;
 	}
 
@@ -795,7 +807,7 @@ static int btrfsic_process_superblock_dev_mirror(
 		superblock_tmp = btrfsic_block_alloc();
 		if (NULL == superblock_tmp) {
 			pr_info("btrfsic: error, kmalloc failed!\n");
-			brelse(bh);
+			__free_page(page);
 			return -1;
 		}
 		/* for superblock, only the dev_bytenr makes sense */
@@ -880,7 +892,7 @@ static int btrfsic_process_superblock_dev_mirror(
 					      mirror_num)) {
 				pr_info("btrfsic: btrfsic_map_block(bytenr @%llu, mirror %d) failed!\n",
 				       next_bytenr, mirror_num);
-				brelse(bh);
+				__free_page(page);
 				return -1;
 			}
 
@@ -890,7 +902,7 @@ static int btrfsic_process_superblock_dev_mirror(
 					mirror_num, NULL);
 			if (NULL == next_block) {
 				btrfsic_release_block_ctx(&tmp_next_block_ctx);
-				brelse(bh);
+				__free_page(page);
 				return -1;
 			}
 
@@ -902,7 +914,7 @@ static int btrfsic_process_superblock_dev_mirror(
 					BTRFSIC_GENERATION_UNKNOWN);
 			btrfsic_release_block_ctx(&tmp_next_block_ctx);
 			if (NULL == l) {
-				brelse(bh);
+				__free_page(page);
 				return -1;
 			}
 		}
@@ -910,7 +922,7 @@ static int btrfsic_process_superblock_dev_mirror(
 	if (state->print_mask & BTRFSIC_PRINT_MASK_INITIAL_ALL_TREES)
 		btrfsic_dump_tree_sub(state, superblock_tmp, 0);
 
-	brelse(bh);
+	__free_page(page);
 	return 0;
 }
 
-- 
2.24.1

