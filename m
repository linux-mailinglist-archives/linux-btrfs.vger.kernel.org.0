Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFF15C5C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgBMPYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:24:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43900 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgBMPYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607491; x=1613143491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9xgsJ3qI2ezJFKP91uRHZZ6zHuDaXEiX8DX+4ctjemE=;
  b=ZxcC90X4NlcSM7Jw1VCG71KqVOFfTxjhKPKYKdd3XEBWmDx0fO/qn/fg
   dCQh/nNZ1hFO2+0syubW2sM+1JmQ3HyNeKC0GIOmZG9u5VkyIQ5FL4elv
   CwKNNDYSCe80s85AsKnZWi7MehZWOUbHGdRICV+b3PTPweo50vpAQYRt0
   RZixwUtN6iXAJ7LFwrp6WEH0oeavrPdIum1i/fLt/spxrb7Lv/a3/SszA
   EOFpgE8uRkOZl8o41suItU4sGI5gnO0IOzCMixjs25J9oZqQbbqO1wGY2
   ieGJGQfV9R2s0LH6JCXwVfVDIlUnigTRl44SdNV8MWV7M9RrTO40U7HNf
   w==;
IronPort-SDR: QXK3ONM8lPhJG8T7JcqToo0uzC97DbUPK76m/bH7R7JRwJl7yqAqOPDz7z/97sEAF8DrbDw94K
 ud6eeAz9PgnliG6IE4ydtZrSfbX+53zjY0ty73LVRaPCAWVLzW6PusLSF4nxSFaEcq4+buvzje
 OHudrWEIee1ys1L2umyUc4QuSDjSwRnWYyAoAiZWHLLLlWCTu8z1IoOO45Oovkp6+lGvhPhOYR
 afqegn758+8Ypl50jOfWhlL7rLdUPO3vkrkm0iwXQFswb/6jdj5lDXaH/sgqUXTJi6ZyvL32eY
 mAg=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227893"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:51 +0800
IronPort-SDR: h1+bwVIUo0Vc/9/SbdrVtdRMAjMLiJ09Aoju4yz3EuE5nFIRe9riOnqChJlju70DFnD/trwt4v
 RC/FNzfo2PJJJxDDzH8FB5UKCT5+upln/TEIjBIe7XAfSxaM3j/6LZjBFH3O/sF6zoUNx/VDMX
 Tc5KjsLh4omVtbmmjOTUnEMGPOxidTaIlgr0XCGbyBlhY51eMZLcmMfkvqbS+SngzcDjBGkAYl
 GIqs24jngP7W6tDuib0wW2LjTXfeHRhd/EL3lG+RL1IZyBSaJ/5M5DEGKip8EOmKVZt0DK+9OU
 qk74G8hs9mNy+/m2DpLunLyV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:37 -0800
IronPort-SDR: TYICf+/pOLZGOcaD2UJeLU+JGNOf//AMRaH7oPXlFrw9s2xtpUhXe4nvFM6X3cK5xaPEJ5HnA8
 K3Mq02a1Zxaecc/7drLNWiwOlAD8vf76xStFO5SHeEop/WrtGSKJn4ZZWbSI/oGWDHWr0b1M0k
 QGuG68TsBy/BEF6BzR7mASr5INseqxZ/l2jgKX5yQde63QhZBMabj/Q9/TJ0qj8qnaEgnkUYa9
 jDx8dFZfQao3iWmdkVFKr13i1hIrRgnO4VIJAu3v6C2EcJDY2nHN189uf5cvUZyayg4w4vTuun
 YkY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:48 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 5/8] btrfs: use BIOs instead of buffer_heads from superblock writeout
Date:   Fri, 14 Feb 2020 00:24:33 +0900
Message-Id: <20200213152436.13276-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the superblock read path, change the write path to using BIOs
and pages instead of buffer_heads. This allows us to skip over the
buffer_head code, for writing the superblock to disk.

This is based on a patch originally authored by Nikolay Borisov.

Co-developed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
Changes to v4:
- get rid of op_flags (hch)
- don't use mapping_gfp_constraint() (hch)
- print errno on error (hch)
- use typed pointer (hch)

Changes to v2:
- Don't use bi_set_op_attrs() (David)

Changes to v1:
- Remove left-over buffer_head.h include (David)
---
 fs/btrfs/disk-io.c | 117 ++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9f422edd6cce..906a48f6c996 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -7,7 +7,6 @@
 #include <linux/blkdev.h>
 #include <linux/radix-tree.h>
 #include <linux/writeback.h>
-#include <linux/buffer_head.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
@@ -3398,25 +3397,34 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
-static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
+static void btrfs_end_super_write(struct bio *bio)
 {
-	if (uptodate) {
-		set_buffer_uptodate(bh);
-	} else {
-		struct btrfs_device *device = (struct btrfs_device *)
-			bh->b_private;
-
-		btrfs_warn_rl_in_rcu(device->fs_info,
-				"lost page write due to IO error on %s",
-					  rcu_str_deref(device->name));
-		/* note, we don't set_buffer_write_io_error because we have
-		 * our own ways of dealing with the IO errors
-		 */
-		clear_buffer_uptodate(bh);
-		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_WRITE_ERRS);
+	struct btrfs_device *device = bio->bi_private;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	struct page *page;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		page = bvec->bv_page;
+
+		if (bio->bi_status) {
+			btrfs_warn_rl_in_rcu(device->fs_info,
+					     "lost page write due to IO error on %s (%d)",
+					     rcu_str_deref(device->name),
+					     blk_status_to_errno(bio->bi_status));
+			ClearPageUptodate(page);
+			SetPageError(page);
+			btrfs_dev_stat_inc_and_print(device,
+						     BTRFS_DEV_STAT_WRITE_ERRS);
+		} else {
+			SetPageUptodate(page);
+		}
+
+		put_page(page);
+		unlock_page(page);
 	}
-	unlock_buffer(bh);
-	put_bh(bh);
+
+	bio_put(bio);
 }
 
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
@@ -3482,19 +3490,17 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
  * the expected device size at commit time. Note that max_mirrors must be
  * same for write and wait phases.
  *
- * Return number of errors when buffer head is not found or submission fails.
+ * Return number of errors when page is not found or submission fails.
  */
 static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
+	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct buffer_head *bh;
 	int i;
-	int ret;
 	int errors = 0;
 	u64 bytenr;
-	int op_flags;
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3502,6 +3508,10 @@ static int write_dev_supers(struct btrfs_device *device,
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < max_mirrors; i++) {
+		struct page *page;
+		struct bio *bio;
+		struct btrfs_super_block *disk_super;
+
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
@@ -3514,37 +3524,44 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		crypto_shash_final(shash, sb->csum);
 
-		/* One reference for us, and we leave it for the caller */
-		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
-			      BTRFS_SUPER_INFO_SIZE);
-		if (!bh) {
+		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
+					   GFP_NOFS);
+		if (!page) {
 			btrfs_err(device->fs_info,
-			    "couldn't get super buffer head for bytenr %llu",
+			    "couldn't get superblock page for bytenr %llu",
 			    bytenr);
 			errors++;
 			continue;
 		}
 
-		memcpy(bh->b_data, sb, BTRFS_SUPER_INFO_SIZE);
+		/* Bump the refcount for wait_dev_supers() */
+		get_page(page);
 
-		/* one reference for submit_bh */
-		get_bh(bh);
+		disk_super = page_address(page);
+		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
 
-		set_buffer_uptodate(bh);
-		lock_buffer(bh);
-		bh->b_end_io = btrfs_end_buffer_write_sync;
-		bh->b_private = device;
+		/*
+		 * Directly use BIOs here instead of relying on the page-cache
+		 * to do I/O, so we don't loose the ability to do integrity
+		 * checking.
+		 */
+		bio = bio_alloc(GFP_NOFS, 1);
+		bio_set_dev(bio, device->bdev);
+		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
+		bio->bi_private = device;
+		bio->bi_end_io = btrfs_end_super_write;
+		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
+			       offset_in_page(bytenr));
 
 		/*
-		 * we fua the first super.  The others we allow
+		 * We fua the first super.  The others we allow
 		 * to go down lazy.
 		 */
-		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
+		bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO;
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
-			op_flags |= REQ_FUA;
-		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
-		if (ret)
-			errors++;
+			bio->bi_opf |= REQ_FUA;
+
+		btrfsic_submit_bio(bio);
 	}
 	return errors < i ? 0 : -1;
 }
@@ -3553,12 +3570,11 @@ static int write_dev_supers(struct btrfs_device *device,
  * Wait for write completion of superblocks done by write_dev_supers,
  * @max_mirrors same for write and wait phases.
  *
- * Return number of errors when buffer head is not found or not marked up to
+ * Return number of errors when page is not found or not marked up to
  * date.
  */
 static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 {
-	struct buffer_head *bh;
 	int i;
 	int errors = 0;
 	bool primary_failed = false;
@@ -3568,32 +3584,33 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	for (i = 0; i < max_mirrors; i++) {
+		struct page *page;
+
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
 
-		bh = __find_get_block(device->bdev,
-				      bytenr / BTRFS_BDEV_BLOCKSIZE,
-				      BTRFS_SUPER_INFO_SIZE);
-		if (!bh) {
+		page = find_get_page(device->bdev->bd_inode->i_mapping,
+				     bytenr >> PAGE_SHIFT);
+		if (!page) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 			continue;
 		}
-		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh)) {
+		wait_on_page_locked(page);
+		if (PageError(page)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 		}
 
 		/* drop our reference */
-		brelse(bh);
+		put_page(page);
 
 		/* drop the reference from the writing run */
-		brelse(bh);
+		put_page(page);
 	}
 
 	/* log error, force error return */
-- 
2.24.1

