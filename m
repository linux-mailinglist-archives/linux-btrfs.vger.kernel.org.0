Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7115C5C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBMPYy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:24:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43900 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgBMPYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607495; x=1613143495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1YDMjtJP7dZiq0XA6NZFXqm1jCvyJIwAE8gwhsfgrCg=;
  b=jTYdvl4Eq5VQ1UqNi537eR7728lJX1UOIidJorbj4GYKQ84tfxL/6iak
   L9lDlRow+Th28+xcF50C9NMWo1QIdyxaWqlej29RBqxwR+9UD6wmeyxD/
   GJcX+nR7JpfINAnY9rCsvc3+ROtIoLpNb5GYECZZ/UKxF15YXIWwaBC5J
   jZLBvI0VePe6gCdXFx4+N25hG5pP/h1xsA8M3ff3/FAWgY7CZSYG4ThCQ
   H1JKtymvKNUeoUr86lFNRgWp5qpIasYarXt2T44CXqt2pbIb3iDA+U3SR
   hcjUIFFok3TXfNGEb+Iy0BYJiQabAyA/CRW3r/1bARv4x8/EgeJaKi9Vw
   Q==;
IronPort-SDR: VqDIeWSQkKQ2ZWZE5Z/hSY8IF1gk7N6trWiBnk9AwAFJoGCFQEADIR2rJrIpx/iW8ddSNPxh6W
 KbdG3e79fjGNH/KOWE2LbLHtO/FQw+QGIZSE79Jg43HF17WS9WVDVFICLYdB6XbFfHvS2r1008
 wfU91tS+n/U0tscvhuUYWCxNE+eXP+C+TMsWcQVPtBegV5jZ4+ECGQ01NNwFKqk+Gf7KOURDZl
 NjLj/jN+FQZqhS5t+HGke/9PO5lwtGGkpJ4hmwjkWWAXJ8cL2AOfGJirkSPovnGW18zPzd2Q4V
 bco=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227902"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:54 +0800
IronPort-SDR: mdpTlFqBejrtEotMjfMOiwJsQf8hDL7p/pdHwQQBEfKLQVuVHUvtvMqvouHLZ8wzLh8xicfNtK
 p+I+2Z7TLYrKbMsmDN2F8M0ErmI+swhH5nK43HIEUiTwyv5HKg+4syPKR/z9AwWr3yp99tsKGi
 IqyrVqumNBD1/bu2BLkzv1veWHyY8Ii4iyZVMuGp+EBXEkAQeCiGT3PXDXkIGzBWN97tC6oZ/A
 dKWYekopNMnsZ0DUJcxtKWvWk6pWSXRfMrswHbaV9rtt6WEODwYM+VbGYkl/PSJYZCbRpmtTxz
 0WRXaay42oCk7NzVlh4j7VIg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:41 -0800
IronPort-SDR: Lp/n9yIg79vM1MFym3CxY+Dhje2AcxrHDqGg2hT6uY3ts/+zjlhBGSd/rVbbue/fEwvyC9jWpi
 3acm7U2vQYYzFRZMe40oeA4F1C70ueb7FPO6StznV9BRIxm/OJyJlpqwWf4nM9Xg2gbbBlxDLL
 Z2HDWUt6KKfFEt2UBSjoKcCCJ5EsqXST+9SJq1nv/3dxmCfKS0dVsCtktG8pMIcm2GBzEoW05b
 mYSmkEcivUszHZyXj8+0O8Cu82wVzblJu3yZYU5EwR0ixrEEO3m0vlusf/065k/68nL/pGHueK
 6+8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:52 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 8/8] btrfs: remove buffer_heads form superblock mirror integrity checking
Date:   Fri, 14 Feb 2020 00:24:36 +0900
Message-Id: <20200213152436.13276-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>

---
Changes to v7:
- Use read_Cache_page_gfp()
- Don't kmap() block device mappings (David)

Changes to v4:
- Remove mapping_gfp_constraint()

Changes to v2:
- Open-code kunmap() + put_page() (David)
- Remove __GFP_NOFAIL from allocation (Josef)
- Merge error paths (David)

Changes to v1:
- Convert from alloc_page() to find_or_create_page()
---
 fs/btrfs/check-integrity.c | 42 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 4f6db2fe482a..d8d915d7beda 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -77,7 +77,6 @@
 
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 #include <linux/mutex.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
@@ -762,29 +761,33 @@ static int btrfsic_process_superblock_dev_mirror(
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
+	int ret;
 
 	/* super block bytenr is always the unmapped device bytenr */
 	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
 	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)
 		return -1;
-	bh = __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,
-		     BTRFS_SUPER_INFO_SIZE);
-	if (NULL == bh)
+
+	page = reed_cache_page_gfp(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NOFS);
+	if (IS_ERR(page))
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
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	superblock_tmp =
@@ -795,8 +798,8 @@ static int btrfsic_process_superblock_dev_mirror(
 		superblock_tmp = btrfsic_block_alloc();
 		if (NULL == superblock_tmp) {
 			pr_info("btrfsic: error, kmalloc failed!\n");
-			brelse(bh);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		/* for superblock, only the dev_bytenr makes sense */
 		superblock_tmp->dev_bytenr = dev_bytenr;
@@ -880,8 +883,8 @@ static int btrfsic_process_superblock_dev_mirror(
 					      mirror_num)) {
 				pr_info("btrfsic: btrfsic_map_block(bytenr @%llu, mirror %d) failed!\n",
 				       next_bytenr, mirror_num);
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out;
 			}
 
 			next_block = btrfsic_block_lookup_or_add(
@@ -890,8 +893,8 @@ static int btrfsic_process_superblock_dev_mirror(
 					mirror_num, NULL);
 			if (NULL == next_block) {
 				btrfsic_release_block_ctx(&tmp_next_block_ctx);
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out;
 			}
 
 			next_block->disk_key = tmp_disk_key;
@@ -902,16 +905,17 @@ static int btrfsic_process_superblock_dev_mirror(
 					BTRFSIC_GENERATION_UNKNOWN);
 			btrfsic_release_block_ctx(&tmp_next_block_ctx);
 			if (NULL == l) {
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out;
 			}
 		}
 	}
 	if (state->print_mask & BTRFSIC_PRINT_MASK_INITIAL_ALL_TREES)
 		btrfsic_dump_tree_sub(state, superblock_tmp, 0);
 
-	brelse(bh);
-	return 0;
+out:
+	put_page(page);
+	return ret;
 }
 
 static struct btrfsic_stack_frame *btrfsic_stack_frame_alloc(void)
-- 
2.24.1

