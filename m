Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640CB17EB42
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCIVdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41668 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCIVdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so4527084plr.8
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPuJvXFuiB1r1HZvMinbs424Qxdr3dsdUD3p2/VAQ0I=;
        b=gxlOzghGCDLzDUGj28LQV7Cm7hTGZVYq0FD3qRUxG18+inrA/UVx+C6RJddjVNGjsS
         NpHxYxNeIEpoA+5dvTOtqFdrp6ma+P/fc2VfmberGEOPHjVYqWdj2wA0vA4fbCRRPgf9
         s/9fxa9Evkfg8sWtdRi5BNLpD1AhcIBGvwXnFOguAIEI+Xj0Q80+HeU1/7/kJ+y/UcHB
         d4shOl9ZwJTNxhDu7rhz6dbWjFDS7y55zjqnWhgpeuzWPYkZ2M8mb7nm5kGvQXz44zEV
         LhQs7bbXzP0f/1oheL0zMfCApu5tkQYNPoljy8PGV6jVuNomCesw/Qc/SkSjZB2xNOiV
         2khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPuJvXFuiB1r1HZvMinbs424Qxdr3dsdUD3p2/VAQ0I=;
        b=LODBt3CCOj0G/63K+7T22uid7F1PkoiTiJD/5eU3vsjHR/KdjzzncI821VlQVgCCEd
         kN4BBAG7b9fZ5HSt6IOUJiZaBtI6U4KpKoaKC0jBoaFwi4v2Q9UDFYqMcgIHWLuCte/+
         lIuutoYP08NINpkscmtbyU3FNujx28dgkk0QJoJEzw7GxSrD2hLRWtnuD3cVheUwM62Q
         sPh1I6MSE4XsMHCATib3o+1iBBAd4AWChe6xc4WPuCJyY9KabSqw1oQuZhRAtIOhAu6I
         ljJ7rgHuT4ciZvLQV0fjVKvrJZhMr/xT1yqKscIEqBZYRNPyjISJTeJz5lVf69PoXxAM
         yDBw==
X-Gm-Message-State: ANhLgQ2m+VhZPxhqdDOjkRgH2hclgL5CGffvbJJFRG1vjQN8LDnsrPqB
        PPjGu/izbx4Cd07Mdkkqlu7uFFB0Cgc=
X-Google-Smtp-Source: ADFU+vu/mtowzwHwJWcIwYFur7wvtdd+k1cNXLxiqiqwgHK3VDm1t4ORwo7u1ZFjumc8D1jQdelb7A==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr743296pjq.5.1583789586772;
        Mon, 09 Mar 2020 14:33:06 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:06 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/15] btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
Date:   Mon,  9 Mar 2020 14:32:37 -0700
Message-Id: <95b275ed47f1e4bdaba53040fe6de9eefdf3a5fd.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The next commit will get rid of btrfs_dio_private->orig_bio. The only
thing we really need it for is containing all of the checksums, but we
can easily put those in btrfs_dio_private and get rid of the awkward
logic that looks up the checksums for orig_bio when the first split bio
is submitted. (Interestingly, btrfs_dio_private did contain the
checksums before commit 23ea8e5a0767 ("Btrfs: load checksum data once
when submitting a direct read io"), but it didn't look them up up
front.)

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 79 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a7fb0ba8cde4..4a2e44f3e66e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -84,6 +84,9 @@ struct btrfs_dio_private {
 	 */
 	blk_status_t (*subio_endio)(struct inode *, struct btrfs_io_bio *,
 			blk_status_t);
+
+	/* Checksums. */
+	u8 sums[];
 };
 
 struct btrfs_dio_data {
@@ -7753,7 +7756,6 @@ static void btrfs_endio_direct_read(struct bio *bio)
 
 	dio_bio->bi_status = err;
 	dio_end_io(dio_bio);
-	btrfs_io_bio_free_csum(io_bio);
 	bio_put(bio);
 }
 
@@ -7865,39 +7867,6 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	bio_put(bio);
 }
 
-static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
-						 struct btrfs_dio_private *dip,
-						 struct bio *bio,
-						 u64 file_offset)
-{
-	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
-	struct btrfs_io_bio *orig_io_bio = btrfs_io_bio(dip->orig_bio);
-	u16 csum_size;
-	blk_status_t ret;
-
-	/*
-	 * We load all the csum data we need when we submit
-	 * the first bio to reduce the csum tree search and
-	 * contention.
-	 */
-	if (dip->logical_offset == file_offset) {
-		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, file_offset,
-					    NULL);
-		if (ret)
-			return ret;
-	}
-
-	if (bio == dip->orig_bio)
-		return 0;
-
-	file_offset -= dip->logical_offset;
-	file_offset >>= inode->i_sb->s_blocksize_bits;
-	csum_size = btrfs_super_csum_size(btrfs_sb(inode->i_sb)->super_copy);
-	io_bio->csum = orig_io_bio->csum + csum_size * file_offset;
-
-	return 0;
-}
-
 static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		struct inode *inode, u64 file_offset, int async_submit)
 {
@@ -7933,10 +7902,12 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		if (ret)
 			goto err;
 	} else {
-		ret = btrfs_lookup_and_bind_dio_csum(inode, dip, bio,
-						     file_offset);
-		if (ret)
-			goto err;
+		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+		size_t csum_offset;
+
+		csum_offset = ((file_offset - dip->logical_offset) >>
+			       inode->i_sb->s_blocksize_bits) * csum_size;
+		btrfs_io_bio(bio)->csum = dip->sums + csum_offset;
 	}
 map:
 	ret = btrfs_map_bio(fs_info, bio, 0);
@@ -8047,13 +8018,25 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 				loff_t file_offset)
 {
 	struct btrfs_dio_private *dip = NULL;
+	size_t dip_size;
 	struct bio *bio = NULL;
 	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 
 	bio = btrfs_bio_clone(dio_bio);
 
-	dip = kzalloc(sizeof(*dip), GFP_NOFS);
+	dip_size = sizeof(*dip);
+	if (!write && csum) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+		size_t nblocks = (dio_bio->bi_iter.bi_size >>
+				  inode->i_sb->s_blocksize_bits);
+
+		dip_size += csum_size * nblocks;
+	}
+
+	dip = kzalloc(dip_size, GFP_NOFS);
 	if (!dip) {
 		if (!write) {
 			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
@@ -8093,11 +8076,27 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			dip->bytes;
 		dio_data->unsubmitted_oe_range_start =
 			dio_data->unsubmitted_oe_range_end;
-
 		bio->bi_end_io = btrfs_endio_direct_write;
 	} else {
 		bio->bi_end_io = btrfs_endio_direct_read;
 		dip->subio_endio = btrfs_subio_endio_read;
+
+		if (csum) {
+			blk_status_t status;
+
+			/*
+			 * Load the csums up front to reduce csum tree searches
+			 * and contention when submitting bios.
+			 */
+			status = btrfs_lookup_bio_sums(inode, dio_bio,
+						       file_offset, dip->sums);
+			if (status != BLK_STS_OK) {
+				dip->errors = 1;
+				if (refcount_dec_and_test(&dip->refs))
+					bio_io_error(dip->orig_bio);
+				return;
+			}
+		}
 	}
 
 	btrfs_submit_direct_hook(dip);
-- 
2.25.1

