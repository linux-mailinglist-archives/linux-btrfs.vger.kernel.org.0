Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64D14A7A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgA0P7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 10:59:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39169 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbgA0P7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 10:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580140783; x=1611676783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DIAsw2fAS2f6f2JmXgH9y7tsImjmph29un5wo68AgVg=;
  b=Ce+1BBppVcYezwQ5GpeCFFBomuW1REI3kerIU37Hd9YqeYYsd7EcT/PI
   TXxryqD4G+0uEYn6yso+RdNp8asH7ENvoTBVhx/aR00USzms96yJaitdW
   WTR2bOMS2iYMTRan30LZF5sB9eJCJpiYBswC26IXH3p0X/dcVLw9QaGmC
   EvnizXdTNTSgFqaKohd7fFYz9kBYgC9MFu3IjuvIoDs8xHR0KhWB/rzG5
   ZNzh0eJ+VGXD22iHtDp3gFiWnRducNwF+qehjCE4QuDNnPObFmTCcEHl8
   mHEPxkFenw5q/Ce6UxeTQ8/BUP5WJVNAHnqQCAcbWYKVYq65T20QDGglc
   Q==;
IronPort-SDR: yq60XzxajenzZVVhVbDzgZzLgh1rDJoQuR+0QLCn3B14vn/KPSmHL9nbgun9VUvJEh52kfACid
 OjPhhxb9Jzo6MZzFfLz1eJvOBsI+Vwo8L6aXyTFEG3HPhSeAzmjWdorPEZptGXD+ZlADtvJieb
 dutvsUcEaHZBg/9s9YlMAw1NSAQuNlUi/+eIu4OQlCkUmcOUvRp7iq4cf2RvbroTtiEC9hgmjp
 C1EwLGyccjR2nxAdD7MYexA/Or+KMJTxKjUKy/flt57WOk/zh597c8i+wRvVEoG2rlp9Jv+CV3
 zU0=
X-IronPort-AV: E=Sophos;i="5.70,370,1574092800"; 
   d="scan'208";a="132851981"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2020 23:59:43 +0800
IronPort-SDR: 5MjqyjqPxsb5GX/OWQKPTkZHrARQaeV+rKoKHTK6A47yED9/976iaR0zdrCQE8YBDwORTFPFPn
 EPngQ6YilJLZGka7SHJ9WWld9Ye5t+xTlLbEAbvMRirJzr6MNWaPIM6UIPx0I5KO1Y6no9R+4l
 6n+p892bXo8yvP3jLUQ567q23k9r/RWNf5I7ik7IG2zI8cuUk5k/bhZ3PpKGUQpsXV2TblZwWd
 Kvxz2beSUcvq9L2zVEKMmtScPMtEoFc8LDDSvKg2MkKGoWi+3G1VnzWsKaAs2E3OovGPrZ+0Fw
 az9g0JdOEB4s1Zf93rnXL2cH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 07:52:57 -0800
IronPort-SDR: tBQ3b6GePfYNuU3nYwmHhtlMan5gKZ8XY2LBSYhyixWP1EFtOwaEO5AFkJB6Ka8Bkc0zdopGH3
 Mtw9O3G9Yl7HLZ2/oEfS5mcHXbRKeWsflSIiSRgVkKXNF18HpYf7Wa/X5YN5yTHOfhD66LtC08
 qtdDOCIDln91Z+u+gN0wjiURQxETqVCBl2xkzJviGTh52iutXGHtMWu55fhQdY0yDb0eWFkaa9
 43isFpF3bI5zxTapaEzgbnMJRoyNhVI1ToWGG3pNbQKF9YntV5cfBt57SBl3TYNI1g8tbowa6g
 qa8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2020 07:59:41 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 5/5] btrfs: remove buffer_heads form superblock mirror integrity checking
Date:   Tue, 28 Jan 2020 00:59:31 +0900
Message-Id: <20200127155931.10818-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The integrity checking code for the superblock mirrors is the last remaining
user of buffer_heads in BTRFS, change it to using plain BIOs as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>

---
Changes to v2:
- Open-code kunmap() + put_page() (David)
- Remove __GFP_NOFAIL from allocation (Josef)
- Merge error paths (David)

Changes to v1:
- Convert from alloc_page() to find_or_create_page()
---
 fs/btrfs/check-integrity.c | 58 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 4f6db2fe482a..d6ab6d3ca413 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -77,7 +77,6 @@
 
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 #include <linux/mutex.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
@@ -762,29 +761,48 @@ static int btrfsic_process_superblock_dev_mirror(
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
+	struct address_space *mapping = superblock_bdev->bd_inode->i_mapping;
+	gfp_t gfp_mask;
+	int ret;
 
 	/* super block bytenr is always the unmapped device bytenr */
 	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
 	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)
 		return -1;
-	bh = __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,
-		     BTRFS_SUPER_INFO_SIZE);
-	if (NULL == bh)
+
+	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS);
+
+	page = find_or_create_page(mapping, dev_bytenr >> PAGE_SHIFT, gfp_mask);
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
+	unlock_page(page);
+
+	super_tmp = kmap(page);
 
 	if (btrfs_super_bytenr(super_tmp) != dev_bytenr ||
 	    btrfs_super_magic(super_tmp) != BTRFS_MAGIC ||
 	    memcmp(device->uuid, super_tmp->dev_item.uuid, BTRFS_UUID_SIZE) ||
 	    btrfs_super_nodesize(super_tmp) != state->metablock_size ||
 	    btrfs_super_sectorsize(super_tmp) != state->datablock_size) {
-		brelse(bh);
-		return 0;
+		ret = 0;
+		goto out_unmap;
 	}
 
 	superblock_tmp =
@@ -795,8 +813,8 @@ static int btrfsic_process_superblock_dev_mirror(
 		superblock_tmp = btrfsic_block_alloc();
 		if (NULL == superblock_tmp) {
 			pr_info("btrfsic: error, kmalloc failed!\n");
-			brelse(bh);
-			return -1;
+			ret = -1;
+			goto out_unmap;
 		}
 		/* for superblock, only the dev_bytenr makes sense */
 		superblock_tmp->dev_bytenr = dev_bytenr;
@@ -880,8 +898,8 @@ static int btrfsic_process_superblock_dev_mirror(
 					      mirror_num)) {
 				pr_info("btrfsic: btrfsic_map_block(bytenr @%llu, mirror %d) failed!\n",
 				       next_bytenr, mirror_num);
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out_unmap;
 			}
 
 			next_block = btrfsic_block_lookup_or_add(
@@ -890,8 +908,8 @@ static int btrfsic_process_superblock_dev_mirror(
 					mirror_num, NULL);
 			if (NULL == next_block) {
 				btrfsic_release_block_ctx(&tmp_next_block_ctx);
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out_unmap;
 			}
 
 			next_block->disk_key = tmp_disk_key;
@@ -902,16 +920,18 @@ static int btrfsic_process_superblock_dev_mirror(
 					BTRFSIC_GENERATION_UNKNOWN);
 			btrfsic_release_block_ctx(&tmp_next_block_ctx);
 			if (NULL == l) {
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out_unmap;
 			}
 		}
 	}
 	if (state->print_mask & BTRFSIC_PRINT_MASK_INITIAL_ALL_TREES)
 		btrfsic_dump_tree_sub(state, superblock_tmp, 0);
 
-	brelse(bh);
-	return 0;
+out_unmap:
+	kunmap(page);
+	put_page(page);
+	return ret;
 }
 
 static struct btrfsic_stack_frame *btrfsic_stack_frame_alloc(void)
-- 
2.24.1

