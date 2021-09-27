Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B996C418FD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhI0HYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44978 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhI0HYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48CC5220C0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWQUBqJVDgT2VboG9Gw1OBr3yn0gbmYfS8wc8LYFJ9k=;
        b=amkr0e/kkMIxjszuPGHPF3pBxqjteArmMdNwuqMG+TGwSKNArtxxFr1vTsXiGx79pQposJ
        paDZzWGz23TimXR1u8URf3Wee4TtxAT6r0vDHfJ5uwa6S0vqgaJ39auB8OrUAXztiiv0xk
        50yoSd9qcBXNIf4Qldi+l+OIU5jOToU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A104D13A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4GYlGz1xUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/26] btrfs: introduce alloc_compressed_bio() for compression
Date:   Mon, 27 Sep 2021 15:21:53 +0800
Message-Id: <20210927072208.21634-12-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
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
 fs/btrfs/compression.c | 90 +++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3f0be97d17f3..1b62677cd0f3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -437,6 +437,36 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
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
+	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+
+	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
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
@@ -483,23 +513,11 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
-	bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
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
@@ -543,11 +561,14 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			if (ret)
 				goto finish_cb;
 
-			bio = btrfs_bio_alloc(BIO_MAX_VECS);
-			bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
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
@@ -846,11 +867,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_bio_alloc(BIO_MAX_VECS);
-	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
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
@@ -891,11 +914,14 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			if (ret)
 				goto finish_cb;
 
-			comp_bio = btrfs_bio_alloc(BIO_MAX_VECS);
-			comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
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
2.33.0

