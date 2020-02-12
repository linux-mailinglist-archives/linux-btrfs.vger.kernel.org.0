Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946F315A1A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBLHRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:17:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46465 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgBLHRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581491852; x=1613027852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhzX+Ed9N8URGpxMD3mmu5ZshsLiHOwaKqwRZ/TRbbc=;
  b=EOeIkCqLhZAgB3Nu0UScyszSTZWjG43R7q5xIUpIa5sN/GDhZbmGHmF7
   xEPw5nhvFA67xMXdPWwKBPETgxulXfP6SWKWM5juYJCMpjhK4C1RzkZk+
   ItpPsDGiYlA2vGC98J9Nl5VxxZA5D62vBvtk+L0GZ1yPvgeRZ4ez2600m
   czgfPeU/BDQnkPLGsnpioZD3Nzb5N1Z5N5y/W0z4hrZKx/8ounl/43BTC
   wwdWhcITKs689HaygK0r2YJmFDAQENyAV8hXPUvMCR+b032mzE0nFokW8
   23FeTMoX55YBVPFkpz9KidEq1ugKBwRbWpvwynNfwduK+pUlQJjOyWLyS
   A==;
IronPort-SDR: RTzC5nSHnWT/N7CERlHuHNXFKcW2X6g9lfMuST5wtOfZ3Zi1hWlpdbILP4wRkqiDabQHNkj5lc
 trmStcinwP6ukExyNAL2r4c2vmytqkIcpa5NlaDr8DTQDnzEPU5DJUx1o+bSs89gwTScnMUzg1
 si/UvoXrB8E13WNw50MRLNBAqig5SWNpbIaJFM82wrPk1fUOu3tUBTYTNqC/WNLZ6AXRce4Ig3
 r8QP+TTpEYFJBR7OpkobfbtwTLbWNEC3F2mtCW1fBYMmpuJGgEDNhUmGlFHy3P1KLGDz4Y5bnf
 k7E=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448471"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:17:32 +0800
IronPort-SDR: 0mNvYOJ1HjWJa53/uHUHZU/I6SrGmijBVO03BAROhDM3+XySNkOp48u0jch2HXmaPo06C+DRh/
 14Sqr9XpJwGV5W8zD6nPMhLvtt6/1LBvFI/2SxGYqNeyVXvFdFcQs8GYzAp47bSYweQm7bpp4K
 f7dxYnBxMhwXNSHupBKAF3sKB+yP/Stfw/xdSqX7CEWPIKyRJGbOEC2YpvIaobRmo+QWZ0Xus9
 zXdX+gBIzw+tqHeDR5LBZx7bTPkmzONK1PsLKimgtnrsNW9ar1imoWVAoYM9ZflVIo1O646lYk
 wgofqaaAMePZms7sx2GkzVr8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:10:05 -0800
IronPort-SDR: gjBPEkBsbsarBMUF/r5yWOFYjJTxWr3FX2VN39FEKyi6vfNu8PxD0SWyPsbcS1e9GeB3Yt9rin
 H5dsXi0txMSRKJYTNEodDdQXiqJItszldZhe5qjK9/U7tGehlQimjrYBdOVygvZx41aU3i/Spi
 XGynWYzignNHymKoUsiOWOiSZLbOBT9P0clJ8cdmYu6EJRkx41Lwk2gHO6ov5e6wNagQGJMBn+
 pqa00uniojvx7JkpPBmHZfPe51Py6Cxw/EgQuoAkMHmAwTWtpnznfNUvnyyFwn7QjkUvS8+NHq
 NHY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 23:17:16 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v7 8/8] btrfs: remove buffer_heads form superblock mirror integrity checking
Date:   Wed, 12 Feb 2020 16:17:04 +0900
Message-Id: <20200212071704.17505-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
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
Changes to v4:
- Remove mapping_gfp_constraint()

Changes to v2:
- Open-code kunmap() + put_page() (David)
- Remove __GFP_NOFAIL from allocation (Josef)
- Merge error paths (David)

Changes to v1:
- Convert from alloc_page() to find_or_create_page()
---
 fs/btrfs/check-integrity.c | 55 +++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 4f6db2fe482a..e10a27d6db08 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -77,7 +77,6 @@
 
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 #include <linux/mutex.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
@@ -762,29 +761,45 @@ static int btrfsic_process_superblock_dev_mirror(
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
+	page = find_or_create_page(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NOFS);
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
@@ -795,8 +810,8 @@ static int btrfsic_process_superblock_dev_mirror(
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
@@ -880,8 +895,8 @@ static int btrfsic_process_superblock_dev_mirror(
 					      mirror_num)) {
 				pr_info("btrfsic: btrfsic_map_block(bytenr @%llu, mirror %d) failed!\n",
 				       next_bytenr, mirror_num);
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out_unmap;
 			}
 
 			next_block = btrfsic_block_lookup_or_add(
@@ -890,8 +905,8 @@ static int btrfsic_process_superblock_dev_mirror(
 					mirror_num, NULL);
 			if (NULL == next_block) {
 				btrfsic_release_block_ctx(&tmp_next_block_ctx);
-				brelse(bh);
-				return -1;
+				ret = -1;
+				goto out_unmap;
 			}
 
 			next_block->disk_key = tmp_disk_key;
@@ -902,16 +917,18 @@ static int btrfsic_process_superblock_dev_mirror(
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

