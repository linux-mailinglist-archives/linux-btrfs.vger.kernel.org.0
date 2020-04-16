Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37D71AD229
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgDPVqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgDPVqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC760C061A0F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so129404pjb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkubIkbm5CTH8PCM726ZLHiYyoY1I6Mws16fl26l+jU=;
        b=cl8+w/2g60vEsnsozNZlsix+djwjbQ1ywtXLsKFeSORay6MA7kh8efCiTpcihFiCKz
         OYebUQ/An6PQKzHYPlcG+kptDA9SzXKnanUYIkBRqPMODvRCQ6rQ4DsUgXCdes85PHTE
         HrypErUmHEqbdXhKrweZ63RWlko5TiYIsSbnffQL4OEPUKCXq2o4kw3wy7Ny00dI39lp
         y4Arklsn4rJfgt4DHB8sgIqQlKbW6McY2SbmAWwkjdni6/CjkJhu+46tuM/O+0WTlxXA
         PDVjEDTBDBAs7RQ8YCIcVSKNqKauzhmz0D2htln39FNOnaPXmIykmw7J9RYAQtW7payB
         iwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkubIkbm5CTH8PCM726ZLHiYyoY1I6Mws16fl26l+jU=;
        b=ep7iMRXE/JtgznAbBo3sOVo9cUv825CkbekuQ3vA//VHvIiIKsUwFUm906rCak5akd
         KqgyOFQY3le5Lv8eGv3Ei12qNbhs60lJC586sGLCFr0+6hs24SnC9/q0RF84PNsAixib
         h5c/tYZzgTs1zPKsbp5voxStRD1d3ztYDk6m8uVlm1fOXV+Cv69ql5YllSiWxYIm8d4r
         Szleb/rpleBzdV4cOKk7bzyT+Qu6iFyLNhyevBYADW4yfmzF9oDoWUOxtqiO84PSvPKw
         KdXi7jqYJSpuWfImF8/zi5t9df5y0d/VLjHh70md52icWjIsZYlQ1diI70yz/zS9MvAw
         +NWA==
X-Gm-Message-State: AGi0PubzAtSHS/tqcFUwvsLZwlz1on0VdKTf9Fu/0X3lMW66IkGng96+
        k8Qt3J9mlsobYnpWwdH/JXTsAIRUDuA=
X-Google-Smtp-Source: APiQypJ2Oj4lYcsrbalIEeOM7G4R0nkmqwLCAsAfX9qj0tbEUzVsCoyft6UDjy6IUZPCSOdFtU22RQ==
X-Received: by 2002:a17:90a:3268:: with SMTP id k95mr395975pjb.185.1587073605918;
        Thu, 16 Apr 2020 14:46:45 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/15] btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
Date:   Thu, 16 Apr 2020 14:46:21 -0700
Message-Id: <c6a8fd5e2811e07532c63cec0aee48047b8f32a2.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The next commit will get rid of btrfs_dio_private->orig_bio. The only
thing we really need it for is containing all of the checksums, but we
can easily put the checksum array in btrfs_dio_private and have the
submitted bios reference the array. We can also look the checksums up
while we're setting up instead of the current awkward logic that looks
them up for orig_bio when the first split bio is submitted.

(Interestingly, btrfs_dio_private did contain the
checksums before commit 23ea8e5a0767 ("Btrfs: load checksum data once
when submitting a direct read io"), but it didn't look them up up
front.)

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/btrfs_inode.h |  3 ++
 fs/btrfs/inode.c       | 70 +++++++++++++++++++-----------------------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b965fa5429ec..94476a8be4cc 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -324,6 +324,9 @@ struct btrfs_dio_private {
 	 */
 	blk_status_t (*subio_endio)(struct inode *, struct btrfs_io_bio *,
 			blk_status_t);
+
+	/* Checksums. */
+	u8 sums[];
 };
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4b1102f2e6b8..fe87c465b13c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7712,7 +7712,6 @@ static void btrfs_endio_direct_read(struct bio *bio)
 
 	dio_bio->bi_status = err;
 	dio_end_io(dio_bio);
-	btrfs_io_bio_free_csum(io_bio);
 	bio_put(bio);
 }
 
@@ -7824,39 +7823,6 @@ static void btrfs_end_dio_bio(struct bio *bio)
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
@@ -7892,10 +7858,12 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		if (ret)
 			goto err;
 	} else {
-		ret = btrfs_lookup_and_bind_dio_csum(inode, dip, bio,
-						     file_offset);
-		if (ret)
-			goto err;
+		u64 csum_offset;
+
+		csum_offset = file_offset - dip->logical_offset;
+		csum_offset >>= inode->i_sb->s_blocksize_bits;
+		csum_offset *= btrfs_super_csum_size(fs_info->super_copy);
+		btrfs_io_bio(bio)->csum = dip->sums + csum_offset;
 	}
 map:
 	ret = btrfs_map_bio(fs_info, bio, 0);
@@ -7912,10 +7880,22 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 							  loff_t file_offset)
 {
 	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
+	size_t dip_size;
 	struct btrfs_dio_private *dip;
 	struct bio *bio;
 
-	dip = kzalloc(sizeof(*dip), GFP_NOFS);
+	dip_size = sizeof(*dip);
+	if (!write && csum) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+		size_t nblocks;
+
+		nblocks = dio_bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
+		dip_size += csum_size * nblocks;
+	}
+
+	dip = kzalloc(dip_size, GFP_NOFS);
 	if (!dip)
 		return NULL;
 
@@ -7951,6 +7931,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 				loff_t file_offset)
 {
 	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip;
 	struct bio *bio;
@@ -7975,6 +7956,17 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		return;
 	}
 
+	if (!write && csum) {
+		/*
+		 * Load the csums up front to reduce csum tree searches and
+		 * contention when submitting bios.
+		 */
+		status = btrfs_lookup_bio_sums(inode, dio_bio, file_offset,
+					       dip->sums);
+		if (status != BLK_STS_OK)
+			goto out_err;
+	}
+
 	orig_bio = dip->orig_bio;
 	start_sector = orig_bio->bi_iter.bi_sector;
 	submit_len = orig_bio->bi_iter.bi_size;
-- 
2.26.1

