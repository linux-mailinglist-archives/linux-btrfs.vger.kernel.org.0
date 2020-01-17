Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17577140A28
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgAQMvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:51:13 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51277 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgAQMvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579265472; x=1610801472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXeMYQjQ9z7NroZQii20vxjEAYhUJDOqhpca2gEApo0=;
  b=kgcvtENLNK6JVrrKEKFQ803pYdlL16eOMJ2ztDEM5ip8G3H4riMlKRv/
   WNuC0ncqv7DxXqddy/Bg/H/rWbFJ3S+CSjySgGyqWktoNEczqiNcWD5/E
   rmnumpVCreP8MAx/WovfzPKsZGIEpA57okHwtdOpM7VvchFBVQ6sQmX/n
   8E0pyuXysj59uCIVKp0S0f6xZqW6mfXs9zCbKloMQ+tjzkBA0hdo4R1em
   QyuHMdv+HcC0+fX5NR669mv1KWhiLrlINTh81NtzoeEIovk43ciOUbmuT
   pW7qUjyoSRKMcl0EAJwxA1MqJSaD6Y3qKbWdrkZAgNUtXdxYvpOVCTtej
   w==;
IronPort-SDR: 9XgxaOwtCcCGepyVxVFYzx3gV8Fxpt13ghFLxvl0niaV7qOPKd6FObIeUuzDJBvNFuDsMpShuQ
 zw7mVH3QLPa96K7pVR6JbN1DLoqFpkl1jHUV2Sne1Fh5rT/AELWaQGlmC+VMFZYM7nI4Yf0k+6
 MW/hVEOB6o3rAP52uJ899fnEupwZTdI6DCoemYnoXAWSUWbz61N14W5lH/pSsHo4vVJRQ5mPpA
 kmTTs/USFArT5pM+UcnWh7iUls49DVc8KESMFfIErAW4NAii3DZvNE+nOfBGOMaQdbm6XEXTVB
 3p0=
X-IronPort-AV: E=Sophos;i="5.70,330,1574092800"; 
   d="scan'208";a="235550981"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2020 20:51:12 +0800
IronPort-SDR: gKNX/ozUPeIy3F854LIrvVLS6MMcQxxVvX6FTPRQdK38VJlvdqyz7XRkiKrjOxv9jFVwiCGEuF
 V+as9VIwJvv0zrtV81YBwEXRX4NSKVD56BNKipN4nyQNnEv7kN/8pyB4JXacBMsY5tknBRciG3
 WH2JCGT2GqLOftLHZdvi5PGHG0Isq+nSbQKa0DA/laKxuleRFDWdzhG9R+rll0XcXgy3rOh0dd
 +8sY+4MsGBlzO8fa8dbVbIRJKwm01j7VzTJQ5pQjgSnAbevXvOJ2D7YxC/1Y4D62HdmTHo9tDH
 5LYypCFJQ+tIm5vRdDFwornP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:44:46 -0800
IronPort-SDR: YgZwDjj7LQBhruZlRXtuJ22kkdY4XJUDU115i8j3Ti/qmJZE64z9TiumWSbz8pmieS/z8PNAZY
 xSfAQtoWiebMnuYhQpg6g4ouhn/4iC3A+gogTP55XcZjy6Z27MeNdLQkXmT8qXTuKIpbB8n+8y
 mVftywHpWuCDdAt/XDFHCqYrfrwUfgPcCVu6dBJi0lf3b5cTyAoyE3bgzr3EYdgCmn2OaTOefF
 9c/7UTgaEmMcZqP3xFZ99+tQjzmUjLNfoF5dgdj9Vnmilt+UPuiQN7YY13g9qs92g+Kw82bzlo
 TUs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2020 04:51:12 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] btrfs: remove use of buffer_heads from superblock writeout
Date:   Fri, 17 Jan 2020 21:51:02 +0900
Message-Id: <20200117125105.20989-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the superblock read path, change the write path to using BIOs
and pages instead of buffer_heads.

This is based on a patch originally authored by Nikolay Borisov.

Co-developed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 107 ++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 50c93ffe8d03..51e7b832c8fd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3353,25 +3353,33 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -3462,16 +3470,15 @@ int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
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
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct buffer_head *bh;
+	gfp_t gfp_mask;
 	int i;
-	int ret;
 	int errors = 0;
 	u64 bytenr;
 	int op_flags;
@@ -3481,7 +3488,13 @@ static int write_dev_supers(struct btrfs_device *device,
 
 	shash->tfm = fs_info->csum_shash;
 
+	gfp_mask = mapping_gfp_constraint(device->bdev->bd_inode->i_mapping,
+					  ~__GFP_FS) | __GFP_NOFAIL;
+
 	for (i = 0; i < max_mirrors; i++) {
+		struct page *page;
+		struct bio *bio;
+
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
@@ -3494,26 +3507,20 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		crypto_shash_final(shash, sb->csum);
 
-		/* One reference for us, and we leave it for the caller */
-		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
-			      BTRFS_SUPER_INFO_SIZE);
-		if (!bh) {
+		page = find_or_create_page(device->bdev->bd_inode->i_mapping,
+					   bytenr >> PAGE_SHIFT, gfp_mask);
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
+		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
 		 * we fua the first super.  The others we allow
@@ -3522,9 +3529,17 @@ static int write_dev_supers(struct btrfs_device *device,
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
@@ -3533,12 +3548,11 @@ static int write_dev_supers(struct btrfs_device *device,
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
@@ -3548,32 +3562,33 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
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

