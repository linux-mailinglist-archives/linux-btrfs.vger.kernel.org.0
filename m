Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63C2C5744
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbgKZOm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 09:42:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:40630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389991AbgKZOm7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 09:42:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606401777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=i2SPB7s8xs+tMdH/dKhhp7JbXpzq7BYxlAtAXiyQmC4=;
        b=j3dFyyGRK0I1YYnA0ngK+A+JHEl0fBReXd9BmAKgf/gLbP/hoJLd5fC+J3AQWcziqVJPiu
        2Ihfb/DLH3SO20te4P4nhX504ZDWZ36BvTWhoerqg0ifAV7GuDOg+wEZK72p1Yctwso8HH
        BuJ6zf879bzvT/djfqBJ8jclcnmELgo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 492BAAD41;
        Thu, 26 Nov 2020 14:42:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF92FDA87E; Thu, 26 Nov 2020 15:41:27 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: drop casts of bio bi_sector
Date:   Thu, 26 Nov 2020 15:41:27 +0100
Message-Id: <20201126144127.19493-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 72deb455b5ec ("block: remove CONFIG_LBDAF") (5.2) the
sector_t type is u64 on all arches and configs so we don't need to
typecast it.  It used to be unsigned long and the result of sector size
shifts were not guaranteed to fit in the type.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/check-integrity.c | 3 +--
 fs/btrfs/compression.c     | 4 ++--
 fs/btrfs/extent_io.c       | 2 +-
 fs/btrfs/file-item.c       | 6 +++---
 fs/btrfs/inode.c           | 7 +++----
 fs/btrfs/raid56.c          | 8 ++++----
 fs/btrfs/volumes.c         | 4 ++--
 7 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index e90e92e4d0b8..6ff44e53814c 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2692,8 +2692,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
 			pr_info("submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_disk=%p)\n",
 			       bio_op(bio), bio->bi_opf, segs,
-			       (unsigned long long)bio->bi_iter.bi_sector,
-			       dev_bytenr, bio->bi_disk);
+			       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_disk);
 
 		mapped_datav = kmalloc_array(segs,
 					     sizeof(*mapped_datav), GFP_NOFS);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4e022ed72d2f..12d50f1cdc58 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -218,7 +218,7 @@ static void end_compressed_bio_read(struct bio *bio)
 
 	inode = cb->inode;
 	ret = check_compressed_csum(BTRFS_I(inode), bio,
-				    (u64)bio->bi_iter.bi_sector << 9);
+				    bio->bi_iter.bi_sector << 9);
 	if (ret)
 		goto csum_failed;
 
@@ -620,7 +620,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	unsigned long pg_index;
 	struct page *page;
 	struct bio *comp_bio;
-	u64 cur_disk_byte = (u64)bio->bi_iter.bi_sector << 9;
+	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f514304b23bf..569d50ccf78a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2886,7 +2886,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
-			(u64)bio->bi_iter.bi_sector, bio->bi_status,
+			bio->bi_iter.bi_sector, bio->bi_status,
 			io_bio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
 		failure_tree = &BTRFS_I(inode)->io_failure_tree;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6086e4cff203..8fa98d55fcfd 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -315,7 +315,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		path->skip_locking = 1;
 	}
 
-	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
+	disk_bytenr = bio->bi_iter.bi_sector << 9;
 
 	bio_for_each_segment(bvec, bio, iter) {
 		page_bytes_left = bvec.bv_len;
@@ -560,7 +560,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	else
 		offset = 0; /* shut up gcc */
 
-	sums->bytenr = (u64)bio->bi_iter.bi_sector << 9;
+	sums->bytenr = bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
@@ -599,7 +599,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				ordered = btrfs_lookup_ordered_extent(inode,
 								offset);
 				ASSERT(ordered); /* Logic error */
-				sums->bytenr = ((u64)bio->bi_iter.bi_sector << 9)
+				sums->bytenr = (bio->bi_iter.bi_sector << 9)
 					+ total_bytes;
 				index = 0;
 			}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 347076f1da6e..d003f806f02a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2183,7 +2183,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 {
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
+	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	int ret;
@@ -7820,8 +7820,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 		btrfs_warn(BTRFS_I(dip->inode)->root->fs_info,
 			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
 			   btrfs_ino(BTRFS_I(dip->inode)), bio_op(bio),
-			   bio->bi_opf,
-			   (unsigned long long)bio->bi_iter.bi_sector,
+			   bio->bi_opf, bio->bi_iter.bi_sector,
 			   bio->bi_iter.bi_size, err);
 
 	if (bio_op(bio) == REQ_OP_READ) {
@@ -7913,7 +7912,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	dip->inode = inode;
 	dip->logical_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
-	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
+	dip->disk_bytenr = dio_bio->bi_iter.bi_sector << 9;
 	dip->dio_bio = dio_bio;
 	refcount_set(&dip->refs, 1);
 	return dip;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 255490f42b5d..93fbf87bdc8d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1097,7 +1097,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 
 	/* see if we can add this page onto our existing bio */
 	if (last) {
-		u64 last_end = (u64)last->bi_iter.bi_sector << 9;
+		u64 last_end = last->bi_iter.bi_sector << 9;
 		last_end += last->bi_iter.bi_size;
 
 		/*
@@ -1163,7 +1163,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		struct bvec_iter iter;
 		int i = 0;
 
-		start = (u64)bio->bi_iter.bi_sector << 9;
+		start = bio->bi_iter.bi_sector << 9;
 		stripe_offset = start - rbio->bbio->raid_map[0];
 		page_index = stripe_offset >> PAGE_SHIFT;
 
@@ -1374,7 +1374,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 				   struct bio *bio)
 {
-	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
+	u64 logical = bio->bi_iter.bi_sector << 9;
 	int i;
 
 	for (i = 0; i < rbio->nr_data; i++) {
@@ -2150,7 +2150,7 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
 	if (rbio->faila == -1) {
 		btrfs_warn(fs_info,
 	"%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bbio has map_type %llu)",
-			   __func__, (u64)bio->bi_iter.bi_sector << 9,
+			   __func__, bio->bi_iter.bi_sector << 9,
 			   (u64)bio->bi_iter.bi_size, bbio->map_type);
 		if (generic_io)
 			btrfs_put_bbio(bbio);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7132af058a95..fe03a2a1b376 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6347,7 +6347,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	bio->bi_iter.bi_sector = physical >> 9;
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
-		bio_op(bio), bio->bi_opf, (u64)bio->bi_iter.bi_sector,
+		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
 	bio_set_dev(bio, dev->bdev);
@@ -6379,7 +6379,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
-	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
+	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	int ret;
-- 
2.25.0

