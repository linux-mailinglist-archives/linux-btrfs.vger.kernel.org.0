Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D523AAAB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFQFRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 01:17:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQFRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 01:17:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DFC321ACB
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623906906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlXPP2KItTiZN0SFEcVT59G0W8flxVAUlDMlyf9kHDA=;
        b=INxofqjSqbgghy5NJqJhEkOGJUOmav68ftczCvCk2rV2OdvB5+nFfqbwi+zelN0lRiOWh1
        MezySWJGUwNbLUW2ZM0iZ2300wLawxVzlos5u0gAV1Vps2DcRon5XpjX7hQUWMcM2lHIaw
        X/9ap6LXhbtzyfpTNC3J5lgVFJpMZlA=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 50BA5A3BBC
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:15:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 6/9] btrfs: introduce alloc_compressed_bio() for compression
Date:   Thu, 17 Jun 2021 13:14:47 +0800
Message-Id: <20210617051450.206704-7-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617051450.206704-1-wqu@suse.com>
References: <20210617051450.206704-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just aggregate the bio allocation code into one helper, so that we can
replace 4 call sites.

There is one special note for zoned write.

Currently btrfs_submit_compressed_write() will only allocate the first
bio using ZONE_APPEND.
If we have to submit current bio due to stripe boundary, the new bio
allocated will not use ZONE_APPEND.

In theory this should be a bug, but considering zoned mode currently
only support SINGLE profile, which doesn't have any stripe boundary
limit, it should never be a problem.

This function will provide a good entrance for any work which needs to be
done at bio allocation time. Like determining the stripe boundary.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 85 ++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 19da5b26359b..61c455ad1d60 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -431,6 +431,35 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * To allocate a compressed_bio, which will be used to read/write on-disk data.
+ */
+static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
+					unsigned int opf, bio_end_io_t endio_func)
+{
+	struct bio *bio;
+
+	bio = btrfs_bio_alloc(disk_bytenr);
+
+	bio->bi_opf = opf;
+	bio->bi_private = cb;
+	bio->bi_end_io = endio_func;
+
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+		struct btrfs_device *device;
+
+		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
+						fs_info->sectorsize);
+		if (IS_ERR(device)) {
+			bio_put(bio);
+			return ERR_CAST(device);
+		}
+		bio_set_dev(bio, device->bdev);
+	}
+	return bio;
+}
+
 /*
  * worker function to build and submit bios for previously compressed pages.
  * The corresponding pages in the inode should be marked for writeback
@@ -477,22 +506,11 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = btrfs_bio_alloc(first_byte);
-	bio->bi_opf = bio_op | write_flags;
-	bio->bi_private = cb;
-	bio->bi_end_io = end_compressed_bio_write;
-
-	if (use_append) {
-		struct btrfs_device *device;
-
-		device = btrfs_zoned_get_device(fs_info, disk_start, PAGE_SIZE);
-		if (IS_ERR(device)) {
-			kfree(cb);
-			bio_put(bio);
-			return BLK_STS_NOTSUPP;
-		}
-
-		bio_set_dev(bio, device->bdev);
+	bio = alloc_compressed_bio(cb, first_byte, bio_op | write_flags,
+				   end_compressed_bio_write);
+	if (IS_ERR(bio)) {
+		kfree(cb);
+		return errno_to_blk_status(PTR_ERR(bio));
 	}
 
 	if (blkcg_css) {
@@ -536,10 +554,14 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			if (ret)
 				goto finish_cb;
 
-			bio = btrfs_bio_alloc(first_byte);
-			bio->bi_opf = bio_op | write_flags;
-			bio->bi_private = cb;
-			bio->bi_end_io = end_compressed_bio_write;
+			bio = alloc_compressed_bio(cb, first_byte,
+					bio_op | write_flags,
+					end_compressed_bio_write);
+			if (IS_ERR(bio)) {
+				ret = errno_to_blk_status(PTR_ERR(bio));
+				bio = NULL;
+				goto finish_cb;
+			}
 			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
 			/*
@@ -801,10 +823,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_bio_alloc(cur_disk_byte);
-	comp_bio->bi_opf = REQ_OP_READ;
-	comp_bio->bi_private = cb;
-	comp_bio->bi_end_io = end_compressed_bio_read;
+	comp_bio = alloc_compressed_bio(cb, cur_disk_byte, REQ_OP_READ,
+					end_compressed_bio_read);
+	if (IS_ERR(comp_bio)) {
+		ret = errno_to_blk_status(PTR_ERR(comp_bio));
+		comp_bio = NULL;
+		goto fail2;
+	}
 
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
 		u32 pg_len = PAGE_SIZE;
@@ -845,10 +870,14 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			if (ret)
 				goto finish_cb;
 
-			comp_bio = btrfs_bio_alloc(cur_disk_byte);
-			comp_bio->bi_opf = REQ_OP_READ;
-			comp_bio->bi_private = cb;
-			comp_bio->bi_end_io = end_compressed_bio_read;
+			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
+					REQ_OP_READ,
+					end_compressed_bio_read);
+			if (IS_ERR(comp_bio)) {
+				ret = errno_to_blk_status(PTR_ERR(comp_bio));
+				comp_bio = NULL;
+				goto finish_cb;
+			}
 
 			bio_add_page(comp_bio, page, pg_len, 0);
 		}
-- 
2.32.0

