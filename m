Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78D414A7A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgA0P7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 10:59:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39167 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgA0P7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 10:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580140780; x=1611676780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRsbLRlcNrPhAoMuuLO7/xeRNDuKb4NYHXoGXWNn/34=;
  b=QIZluVQjxxYyH0LrljPodBFBDautLy1dqHyP/CuK+0zNyclLG6P/bksu
   nfet+/u2G+AsoET2EqHnYojpfgLb3MPIfYcm8DsyUx+itx9IZc7M6EjOP
   5XnyhOQa4y2yHWh/LzsWNCcbWNdzyBZawKSU49u32tPZ8eUz460KXrTnT
   DkxqbhG37IjBqU/FIcQjZ7YViboFeGORr/yLfyAYm5pTa9gAs9r7Q2Gxc
   wsIKEwjx5H3JRYzcyTNzmXOwDHqVAnLiVCWH+aoxQEbOE2zecXWefDtyj
   zSYIvZTAxuCpO8pLcplB5jm7p57WXCYFkEu0yqrf5Zp+w74dWH3sC9VT4
   Q==;
IronPort-SDR: f5lF2JsQyO9va1+e+nB0TPYuVBfvSKVmSSfVoveNKyGCfUj9jHgRclQzeFydOd/qh/ebTCTpdf
 9x4cvULejQOFy8ptU/iqtf5NtWb08NvCsw39Hx577CmhlP93RArnMBqzXv0C3ggieatEdd+PNM
 DpKj7dTS6dxivMfiUN8+cMWvycuX/y2po4bZiDzNePDhcPefhpRHVBakBnb8KBucAuWgg4zXh6
 685e0dqYq8mxY8uebT5tGb7WtohgLP/zXet4oImgqfqv3Lc2Ah20/cWtYJ85aIzzRR0EYk7Ge4
 I3w=
X-IronPort-AV: E=Sophos;i="5.70,370,1574092800"; 
   d="scan'208";a="132851975"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2020 23:59:39 +0800
IronPort-SDR: 4xQ67mHFmWFuzzCE4DX/lZS9LIcYxw6fYlmP2+IVvdqg3dZk7ir9YPXfnwTylc54muAvzusWpk
 QRwFp4OYqn9Z8ucJciGsffo5PzZz6qCQAHh4CJT+vbMzNn5oalJV3qtYT3ug/kuk7gt+pKeye4
 6m4gcmSUSJ2AuypnclH/5yNtpVL4FNExe8KtWNHOdI5FEu/8iD+Ak5rjcAt68SNB6dTEG5K9Kc
 Qx8YrsIzGbOfL3VojWcgtRm6GtHy6N35L/tJLAOWhjUFs3CtV9OnU1x+lMHzcoepwxEBHM1q20
 colQgXQWrE6VbsQ9PG/ptG46
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 07:52:54 -0800
IronPort-SDR: RZHNdE6ILT5FTq+QFzegyOmbPXYYtmnlcqjO2in1hPmCygK57RGU8KLkpIcJQqWLR7koMPOkWh
 6yFR0aSGGMa+MASEQ8pZsppuGaXynFOIZZrU3YtuZbWomLo5ROfslDS6DRIGIx/Xo5C3EnDYpm
 QWXz5Wo/cdA3jomuq0PUdUwzU+lMYqNtavLoRWN7D9BH8c54DTTeRPSBz/QllCNbCQMYw50NOF
 H/8LjZqjZHmV/X3zBGT9KyNq90s2FqSIHWlPmHt5uLodRzM5KnbFmmwJIgwAIya+YUmqmGlQkb
 4X0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2020 07:59:38 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 2/5] btrfs: remove use of buffer_heads from superblock writeout
Date:   Tue, 28 Jan 2020 00:59:28 +0900
Message-Id: <20200127155931.10818-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
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

---
Changes to v2:
- Don't use bi_set_op_attrs() (David)

Changes to v1:
- Remove left-over buffer_head.h include (David)
---
 fs/btrfs/disk-io.c | 111 ++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1f30b234ac07..c88bd6bbbf66 100644
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
@@ -3360,25 +3359,33 @@ int __cold open_ctree(struct super_block *sb,
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
+		if (blk_status_to_errno(bio->bi_status)) {
+			btrfs_warn_rl_in_rcu(device->fs_info,
+					     "lost page write due to IO error on %s",
+					     rcu_str_deref(device->name));
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
 
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
@@ -3477,16 +3484,16 @@ int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
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
+	gfp_t gfp_mask;
 	int i;
-	int ret;
 	int errors = 0;
 	u64 bytenr;
 	int op_flags;
@@ -3496,7 +3503,13 @@ static int write_dev_supers(struct btrfs_device *device,
 
 	shash->tfm = fs_info->csum_shash;
 
+	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
+
 	for (i = 0; i < max_mirrors; i++) {
+		struct page *page;
+		struct bio *bio;
+		u8 *ptr;
+
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
@@ -3509,26 +3522,22 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		crypto_shash_final(shash, sb->csum);
 
-		/* One reference for us, and we leave it for the caller */
-		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
-			      BTRFS_SUPER_INFO_SIZE);
-		if (!bh) {
+		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
+					   gfp_mask);
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
-
-		set_buffer_uptodate(bh);
-		lock_buffer(bh);
-		bh->b_end_io = btrfs_end_buffer_write_sync;
-		bh->b_private = device;
+		ptr = kmap(page);
+		memcpy(ptr, sb, BTRFS_SUPER_INFO_SIZE);
+		kunmap(page);
 
 		/*
 		 * we fua the first super.  The others we allow
@@ -3537,9 +3546,17 @@ static int write_dev_supers(struct btrfs_device *device,
 		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
 			op_flags |= REQ_FUA;
-		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
-		if (ret)
-			errors++;
+
+		bio = bio_alloc(gfp_mask, 1);
+		bio_set_dev(bio, device->bdev);
+		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
+		bio->bi_private = device;
+		bio->bi_end_io = btrfs_end_super_write;
+		bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
+			     offset_in_page(bytenr));
+
+		bio->bi_opf = REQ_OP_WRITE | op_flags;
+		btrfsic_submit_bio(bio);
 	}
 	return errors < i ? 0 : -1;
 }
@@ -3548,12 +3565,11 @@ static int write_dev_supers(struct btrfs_device *device,
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
@@ -3563,32 +3579,33 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
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

