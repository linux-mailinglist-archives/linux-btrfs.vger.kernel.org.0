Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C394146342
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAWITG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:19:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43991 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWITC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579767542; x=1611303542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1LGuqVEY+XciGpC1222BHuFVk9lKRuLry7MKafyxTrU=;
  b=DCaBLNY+2JvLV0ViGI90o9ecLoG3pglwEWVNRgo1gayWPM9Tuco0gDvb
   M5TYHgvzPS2+V2nmK0WDdkH+QG99XyFr+UxvOWvijUel5Dz0BuMOkprTt
   51gXc967u7tW9BnPJWhhGnppSuvADKTiPTzlhKzG9TKN6JXy/TxwrB+uE
   4GjhB9CPQgJqMdposNMZXHUI+x1Ptiw8yzU8QDtPVLOr7uBOWsG59Tccy
   M7/C83KJzok/KU67k0BudFEOs/Z0i20cg/yNzw9Cbyg94bqS0s7Q9FQJ1
   e0FNNKzRxrNrl3aRMnP+vBFJ7EUsTtqMQfXCv0T0ZFTUnJrv/hldGicBJ
   A==;
IronPort-SDR: PMgBv3eOsRuHwTfwUphVFsZHRDHimgw+gZHbkktybkKpa6n1arNIENHZfwsYol9W2MiylU/W62
 eMcC67XrJplWnNWquFvHX79M+FmDY5MPHbM0EAQ9bfZ5uOyqyLrhQ3tk1XRm6HDRPRPspTFK8i
 w/m3ymx+2nHP1rJOYHBaO+FfSo5spxchjdNM3+U4PcV9hHvj6cxxUU6TPw8mBEONmZ4mpajRT/
 gmOqZhuqJE4Ot+1tj0TiZZwU2agHA0bUwUKqK+TzAEWvno8G5v7FoXwrmgHlUv447aKUtD7LsU
 nmQ=
X-IronPort-AV: E=Sophos;i="5.70,353,1574092800"; 
   d="scan'208";a="129708697"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 16:19:02 +0800
IronPort-SDR: 3ws3HIXidxcR/MkH7xSbPKKpmtwP1/0ADui5b5AOoDxtz2KnIYMHZ+EZjtJGBZFDMdMmIicoo0
 EyrOfNG/YMmF8vHIBskkpwIsgylcbwy+XvsWE+8EwoeRS2irmWH79ExWDvMuVenqXjMUnv1iDN
 LvTAu3K8sqTA0rx26pnIC2PV3xuSoPWps64YEkV3ZnxU8aUj48HyytIrfSv6vU5QIvUKiSoAQ5
 gty/JmB/7RAz34YMMuNvmWeot6lQJF9QuXMnhsvjt9lLHzrUrlnu2ty1wfoOOuQsK7RSDz8OZq
 1QhdTPcxkn+f/DVz4unCXMP2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 00:12:25 -0800
IronPort-SDR: cgdv3wx9kIKQmJS5PbHib4ChYBbQ+plQyRxU9/iRBrkDXK9OcM/JCwZd56v31LqLOPO8Q4qY1q
 kK/McOsd59ku/VoOfEpLNzyrH0giphOfGkLBq/52jk7jI74cHlO1onQ4sJgRaxSxTb/u4EDDlA
 A9NVgo6XEVLSp5v4DFOwTXcAmtNtBFxLZUuoIBmY/pCTvJiByzooyP1EZNkVRvhl6szwRtBR1c
 bCD99RKk8/bBjgQse4q1z7P5WIaCqKZBGg+fF9pG3+SWvBBXi4vz2H5h9kevKQibLAzO+U2uGH
 cbs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2020 00:19:01 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 6/6] btrfs: remove buffer_heads form superblock mirror integrity checking
Date:   Thu, 23 Jan 2020 17:18:49 +0900
Message-Id: <20200123081849.23397-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
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
Changes to v1:
- Convert from alloc_page() to find_or_create_page()
---
 fs/btrfs/check-integrity.c | 44 +++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 4f6db2fe482a..45b88bcd6cbb 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -77,7 +77,6 @@
 
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 #include <linux/mutex.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
@@ -762,28 +761,47 @@ static int btrfsic_process_superblock_dev_mirror(
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
+	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
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
+		btrfs_release_disk_super(page);
 		return 0;
 	}
 
@@ -795,7 +813,7 @@ static int btrfsic_process_superblock_dev_mirror(
 		superblock_tmp = btrfsic_block_alloc();
 		if (NULL == superblock_tmp) {
 			pr_info("btrfsic: error, kmalloc failed!\n");
-			brelse(bh);
+			btrfs_release_disk_super(page);
 			return -1;
 		}
 		/* for superblock, only the dev_bytenr makes sense */
@@ -880,7 +898,7 @@ static int btrfsic_process_superblock_dev_mirror(
 					      mirror_num)) {
 				pr_info("btrfsic: btrfsic_map_block(bytenr @%llu, mirror %d) failed!\n",
 				       next_bytenr, mirror_num);
-				brelse(bh);
+				btrfs_release_disk_super(page);
 				return -1;
 			}
 
@@ -890,7 +908,7 @@ static int btrfsic_process_superblock_dev_mirror(
 					mirror_num, NULL);
 			if (NULL == next_block) {
 				btrfsic_release_block_ctx(&tmp_next_block_ctx);
-				brelse(bh);
+				btrfs_release_disk_super(page);
 				return -1;
 			}
 
@@ -902,7 +920,7 @@ static int btrfsic_process_superblock_dev_mirror(
 					BTRFSIC_GENERATION_UNKNOWN);
 			btrfsic_release_block_ctx(&tmp_next_block_ctx);
 			if (NULL == l) {
-				brelse(bh);
+				btrfs_release_disk_super(page);
 				return -1;
 			}
 		}
@@ -910,7 +928,7 @@ static int btrfsic_process_superblock_dev_mirror(
 	if (state->print_mask & BTRFSIC_PRINT_MASK_INITIAL_ALL_TREES)
 		btrfsic_dump_tree_sub(state, superblock_tmp, 0);
 
-	brelse(bh);
+	btrfs_release_disk_super(page);
 	return 0;
 }
 
-- 
2.24.1

