Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5A158263
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBJScl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 13:32:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25711 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbgBJSck (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581359560; x=1612895560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhzX+Ed9N8URGpxMD3mmu5ZshsLiHOwaKqwRZ/TRbbc=;
  b=PfYfXMXyJyKcqHfKFf/o3wI6ivo+UHDcrhzJ8sX62gXzVOxadC+UZMXU
   5vsYuZYU5MhQVwDoOSEgTeDeV+xFbnz/fXoqlXKbLK7NXp7PKvMo7KWra
   n2cFur74l4nq776l5vs4uZalWVqse7yoDlsKE2SpxmClHQsn9PZcRvwf4
   luBOpvDq//l9noXv+c7dIOxXH/VnFxUkO4DpO/L5jGnlaJNm1IqlLcJj3
   m5Q/v+1q0am4xEz3k5YV7gTeiZfOa2xtZHYvfRQNpU6/CRFMX6qUgdMv5
   wKrhka5jAjGEHVrBCWcyrAYI+RYsHVb+izZ9s/BbS25/3CQhlGb/1sle6
   Q==;
IronPort-SDR: m3RrBjkleyo1KS2fL4HrhiC5Zw5Vn3UaULIA28hR/enT7/MWtB9Ftmsg7ajSkOFZjhnCGMAr54
 Fq7dBvdhTt+69Za3tumgzOdcovFixz/oP6BEow4biQy2ffewArtL7A+kDWQiP+66lNmqnq9aUm
 BiS304EShU4k16VCF5qP8mpvq1NNtDLWRcflUmRoKib+FCe+fdxvnogq/zsS+UIo0VAzbNJD5/
 F6c1hCsDxQyHoTwrXQzaJbGNK3iMaqnMhhRCDuoV23TMDIc8VfFgy1kGVM+HV2HcscBGoa8FvL
 +fA=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="237529192"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 02:32:39 +0800
IronPort-SDR: mo46sD/oISD8AHT817oaE1YcjkqhO5TTxn2j7ajjK/TTTC3VHZjjkZBdPBc7G18XSB3yhO0xlM
 +BUQ15WeHi3QZFPiUh9RsT8iirSV9Q5cjXhqkjEyzsSSLJaO7BsHVXZIZl+rSU3NW69umpGNf+
 M6jdQE/3nQYHvTXUgYGyHNGebUvjovguwoSH42cXfPSA/KviEdYAaAaS7e4X74eUh/+BQ3SRDE
 tVl/8ACv5PXKhIveKWVmEqFHIxg9t1q76i7aBTWFL1HOR21LoV/QoTb50o8m4luCG56YZSr7qF
 nBA8HmlkgV0q2H4QVji60QIM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 10:25:32 -0800
IronPort-SDR: 34NeLRmFk4ET/rDkjU/TXdugPwLjfoNyno91V8B8S9RzZk4hB4fL1gz/e+rtprIx6dP/IuQ1rJ
 GFpSC0PBsUjRLEk+VQGyvnDo0GLSoi5D8jEKnrBYE2+/Ml3WqpGzyngss7khZGrcl/rOv0Wv32
 pNFfjlJVfobyJwCrzCCaDfz/Ft52KKS1Hax8jZWCsiDX/ywCNN5xmzNYqlQAn82j56x2BwmBTM
 /6PfyFONYhZa4z3AbDCu8DMR1UlHAKzTJx/tur5xhEES+Bym7pQXY++DYm3Gy7m5Ll0V8D8Afx
 ZyE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2020 10:32:38 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 7/7] btrfs: remove buffer_heads form superblock mirror integrity checking
Date:   Tue, 11 Feb 2020 03:32:25 +0900
Message-Id: <20200210183225.10137-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
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

