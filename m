Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA114633D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAWITA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:19:00 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43990 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgAWIS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579767539; x=1611303539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=19XjfNb2DsyFkWApWGJ7z72fug2kMoPozXI2kQJWYVU=;
  b=NrnWlSp9Ktued/Lf3C0bwSzk2xokZXHtIKrj/Uhv0rgyBeoU9loWGKB0
   2SP0mgkcJIIu3CdmdYEyGlcno2IMj6GyOSdD6p5GB/iDxsm3ofu3Y2Tc7
   9Up37HrVfQDwnReLFPx6YmZEpkXtzgKXRZaPsmU2xgj9Decg0mjw5TkKe
   zoVlzVq9nCWZgD2cCFFgqg9ixLK5vfWJ7KjiVFYVQ66mV0fRa2im4TC86
   WB5oANBh/4niu/P8d7eqw6ECojfSh+mj5WBLEecZjsFlAtYwcn5W7KY+p
   Vnd6dOHyKi28m6cP8YiykmID0T8zBgwxMfzpkX9eV6VW9DEmAJOheukUt
   A==;
IronPort-SDR: y7/fzD7DHYpSSifDoOWeuD/BOk89OmEv+Gmv/uI+C3nW14BLBdsAQ55b+G5vEyAzRPOox/Vfz4
 QJ7vLfDSM7Qi5is8luHLwYU+PTqUAsM3ZjRGvPbVVZwBqoyres8pTPwAboLrgZkPMoIaE3q/5w
 XmFxK7qDlbkkYTBOfXqMhWryGZ97LgLiB1lpwQKPD5EtMc22P6rJosBKQGNvDmGokX8byt7f8Z
 qkPSLfG7CEjOqFtcd004vQNF2P9zRtfTz/niS4yM/8CWScziHG6aKvMleKbrPohTY9NzVmh0AN
 KLs=
X-IronPort-AV: E=Sophos;i="5.70,353,1574092800"; 
   d="scan'208";a="129708690"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 16:18:59 +0800
IronPort-SDR: EJlXZITaj0KfUTnctTE93YVL10oZ6qnAkJVQwd2KbA6pK94J6mNWL6L7gQNQ2id1TOSNMCz/nz
 n/O5Noc6jrB+sydLKdX4a9uiYtRr3V3Ink8UoFlkBLqzvVshI3xXELAUtbxzFei5Q41pKvBZV8
 Vi1Ln1j54ZJZy7TutIFZD6U5Trh4V99sAB4jHH1HQlE4jNOJ8HG1aFHJxtmG6GW4jcXijrliCP
 TG4fg3jTZR1o48xvdhRxancN/3q7SqpWKjSzOHq1YrLW0La5QYCEoDbVjdnPufaztwMZT7BYnL
 g49JvlFJVC4D/FoaIYV61Z2T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 00:12:21 -0800
IronPort-SDR: pNqSPTVbHJUTIGJW/nJLDOEfSSNe0LLoHWPK9y5GEGNtfLOdDmDnr8M/sbqSYVaN345qHFi+tM
 Vb8oUT1prW+0UQBCVWZ0JExBwY49Wi59z9ROyDs4GRapnRjh+Qdja1/P/xi5T++/y9BMDQHcy3
 /18YetMq63X+tpqCLvOV0GgclV+y1ainGGYnx3sPHc9ymg1wY3/kmwNpLZ+CqCKtwS5QC5x948
 1NC/tFT+iwbntFnFCdwDLfU1g2AgZBAGy9cf0ppUF1v3nBNfNDqHOBbgsyG7upGgOy1DAhcZRy
 enA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2020 00:18:58 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/6] btrfs: remove use of buffer_heads from superblock writeout
Date:   Thu, 23 Jan 2020 17:18:46 +0900
Message-Id: <20200123081849.23397-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
- Remove left-over buffer_head.h include (David)
---
 fs/btrfs/disk-io.c | 111 ++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b111f32108cc..ac1755793596 100644
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
@@ -3356,25 +3355,33 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -3475,16 +3482,16 @@ int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
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
@@ -3494,7 +3501,13 @@ static int write_dev_supers(struct btrfs_device *device,
 
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
@@ -3507,26 +3520,22 @@ static int write_dev_supers(struct btrfs_device *device,
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
-
-		/* one reference for submit_bh */
-		get_bh(bh);
+		/* Bump the refcount for wait_dev_supers() */
+		get_page(page);
 
-		set_buffer_uptodate(bh);
-		lock_buffer(bh);
-		bh->b_end_io = btrfs_end_buffer_write_sync;
-		bh->b_private = device;
+		ptr = kmap(page);
+		memcpy(ptr, sb, BTRFS_SUPER_INFO_SIZE);
+		kunmap(page);
 
 		/*
 		 * we fua the first super.  The others we allow
@@ -3535,9 +3544,17 @@ static int write_dev_supers(struct btrfs_device *device,
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
+		bio_set_op_attrs(bio, REQ_OP_WRITE, op_flags);
+		btrfsic_submit_bio(bio);
 	}
 	return errors < i ? 0 : -1;
 }
@@ -3546,12 +3563,11 @@ static int write_dev_supers(struct btrfs_device *device,
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
@@ -3561,32 +3577,33 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
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

