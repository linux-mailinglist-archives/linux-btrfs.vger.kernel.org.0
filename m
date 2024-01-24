Return-Path: <linux-btrfs+bounces-1721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D783AFA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9E528AB72
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EC1292D9;
	Wed, 24 Jan 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bFNLkuxA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE739128399
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116802; cv=none; b=eGQTq53i/WF4up32D0Myi43KY3WnX9s+XazG4jbR755GNf5tcFXXZ4Gr9ydq1aGKGcmonJ6lCj8nfpNd4KfXiwlblIv5OttI7hypKfGNgBeg5VjR5imTia2gCeoAbAPbGGsPgL5ygdJHrXvIm4DNPwyPozQ9AHL2HSo8CQtwgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116802; c=relaxed/simple;
	bh=Q3We6Xu9OJtfaF1c2bMOiNV/+n80uMP/IN5D1/7sea0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1SBtQ1HC4QatGikZdUfJzU1VZoJUPiNczYoFIXAL7L+xDZT8lKccB1nX6FIgPUeg8fLrc5QVKCT3NXJMZ/3IO8St/6ASXCuwos9cVbOJOwlqDbwnJl1v1RVfjbXkKWr8XthLuxY8xVyDDcG7AiNaX+cz8QLG21n+7qFn6UpU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bFNLkuxA; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc372245aefso2029599276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116800; x=1706721600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRZ9zqAl+WJgmiBPMtKjCnt+nYdtvP2VMNUbXWG82do=;
        b=bFNLkuxAG/I23Bduff2uQTttLqmOayJDdQXrSrGo5SQHoTSiL1QrPY8dqXxtlH87yV
         K55SshIbCToVRTa3+zas/SXqbzPk19kuDl76SsPd2gCixfUffu4H41/uezDGqsiWIpoq
         jI/IYa5X4e0dS5onK/X3CikwtJ7XFCr5J2r8oB9f0CbrybOIL/vsmTHDOmzef3EczB4B
         C6Pz4YJU/IFjbIQeQbW6YbsXMMVxlkE1+rX9J1Nz/7I2s8/4Y82cpkR2JraIHXb+L32/
         9JB0UzNFk7EZ33anKliyaias7Pkq4fAUzVEQ7X0m2wDZLspZq5J1kaPEbUOlA9Ca90p+
         VWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116800; x=1706721600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRZ9zqAl+WJgmiBPMtKjCnt+nYdtvP2VMNUbXWG82do=;
        b=IETypYl0kppeBrjAdfBKzVcLkdao/hcFjYupc9gzkUng8MAO4QIG2F6F29ED8dUNgL
         oLPL07uw8wvDX5nLTYUxtqxv7WNLVv0nPqyYPLl60SsdWZdRaENvg1C98tYTINtKiy9g
         bkBc9TAij3MaTXeGeKPW+RljAvGZerVfVWbHEVy5mICm58hLieIumgMHCqulQJSvyCU1
         7/6lkYFTCwy1mBekiW8edSKgvSBE+wfRHHEqEP4W4dmmcBTaY9appjItdBuvjZGZfj10
         sF0VPzFo/FFLZNCwYWpS5mqYcF4sZBq8dNrxnjZEsx/iy4GnR4X22TByumI1nk8rNUey
         Klgw==
X-Gm-Message-State: AOJu0YxCUGkoF7dtaT0xJI7XV7HNBBbbT5tgtcEiUfIrQuhc48BfFpcO
	uS+qW2NTNZ+2ITH8+gAdYB31f+Gowy3C2BaE9qdH1FSJUZsMV0anwJ7gsVcagrFXkTfriMpaTTc
	N
X-Google-Smtp-Source: AGHT+IF5JwUQIGjZbLQ/yzj+PVNPq74TjIHs/4CJFB1EGY6KaEuyryggIbI2IqqDimtZKsRBgwVyVA==
X-Received: by 2002:a0d:e811:0:b0:5ff:8811:b559 with SMTP id r17-20020a0de811000000b005ff8811b559mr1247266ywe.93.1706116799791;
        Wed, 24 Jan 2024 09:19:59 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ey1-20020a05690c300100b005ffcb4765c9sm65160ywb.28.2024.01.24.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:59 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 39/52] btrfs: implement read repair for encryption
Date: Wed, 24 Jan 2024 12:19:01 -0500
Message-ID: <310c0ebdc78613b6f379595e160206013f75b6dc.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to do read repair we will allocate sectorsize bio's and read
them one at a time, repairing any sectors that don't match their csum.
In order to do this we re-submit the IO's after it's failed, and at this
point we still need the fscrypt_extent_info for these new bio's.

Add the fscrypt_extent_info to the read part of the union in the
btrfs_bio, and then pass this through all the places where we do reads.
Additionally add the orig_start, because we need to be able to put the
correct extent offset for the encryption context.

With these in place we can utilize the normal read repair path.  The
only exception is that the actual repair of the bad copies has to be
triggered from the ->process_bio callback, because this is the encrypted
data.  If we waited until the end_io we would have the decrypted data
and we don't want to write that to the disk.  This is the only change to
the normal read repair path, we trigger the fixup of the broken sectors
in ->process_bio, and then we skip that part if we successfully repair
the sector in ->process_bio once we get to the endio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c         | 83 +++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/bio.h         | 10 ++++-
 fs/btrfs/compression.c |  3 ++
 fs/btrfs/extent_io.c   |  3 ++
 fs/btrfs/inode.c       |  2 +
 5 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e85c0f539ab7..d90a9f0ce763 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -99,6 +99,10 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 		bbio->ordered = orig_bbio->ordered;
 		bbio->orig_logical = orig_bbio->orig_logical;
 		orig_bbio->orig_logical += map_length;
+	} else if (is_data_bbio(bbio)) {
+		bbio->fscrypt_info =
+			fscrypt_get_extent_info(orig_bbio->fscrypt_info);
+		bbio->orig_start = orig_bbio->orig_start;
 	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
@@ -107,8 +111,12 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 /* Free a bio that was never submitted to the underlying device. */
 static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
 {
-	if (bbio_has_ordered_extent(bbio))
+	if (bbio_has_ordered_extent(bbio)) {
 		btrfs_put_ordered_extent(bbio->ordered);
+	} else if (is_data_bbio(bbio)) {
+		fscrypt_put_extent_info(bbio->fscrypt_info);
+		bbio->fscrypt_info = NULL;
+	}
 	bio_put(&bbio->bio);
 }
 
@@ -121,6 +129,10 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
 		btrfs_put_ordered_extent(ordered);
 	} else {
 		bbio->end_io(bbio);
+		if (is_data_bbio(bbio)) {
+			fscrypt_put_extent_info(bbio->fscrypt_info);
+			bbio->fscrypt_info = NULL;
+		}
 	}
 }
 
@@ -188,6 +200,23 @@ static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 	}
 }
 
+static void handle_repair(struct btrfs_bio *repair_bbio)
+{
+	struct btrfs_failed_bio *fbio = repair_bbio->private;
+	struct btrfs_inode *inode = repair_bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
+	int mirror = repair_bbio->mirror_num;
+
+	do {
+		mirror = prev_repair_mirror(fbio, mirror);
+		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
+				  repair_bbio->file_offset, fs_info->sectorsize,
+				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
+				  page_folio(bv->bv_page), bv->bv_offset, mirror);
+	} while (mirror != fbio->bbio->mirror_num);
+}
+
 static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 				 struct btrfs_device *dev)
 {
@@ -203,6 +232,13 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	 */
 	ASSERT(folio_order(page_folio(bv->bv_page)) == 0);
 
+	/*
+	 * If we got here from the encrypted path with ->csum_done set then
+	 * we've already csumed and repaired this sector, we're all done.
+	 */
+	if (repair_bbio->csum_done)
+		goto done;
+
 	if (repair_bbio->bio.bi_status ||
 	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
@@ -215,18 +251,17 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 			goto done;
 		}
 
+		btrfs_set_bio_crypt_ctx_from_extent(&repair_bbio->bio,
+						    repair_bbio->inode,
+						    repair_bbio->fscrypt_info,
+						    repair_bbio->file_offset -
+						    repair_bbio->orig_start);
+
 		btrfs_submit_bio(repair_bbio, mirror);
 		return;
 	}
 
-	do {
-		mirror = prev_repair_mirror(fbio, mirror);
-		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
-				  repair_bbio->file_offset, fs_info->sectorsize,
-				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				  page_folio(bv->bv_page), bv->bv_offset, mirror);
-	} while (mirror != fbio->bbio->mirror_num);
-
+	handle_repair(repair_bbio);
 done:
 	btrfs_repair_done(fbio);
 	bio_put(&repair_bbio->bio);
@@ -281,6 +316,14 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	btrfs_bio_init(repair_bbio, fs_info, NULL, fbio);
 	repair_bbio->inode = failed_bbio->inode;
 	repair_bbio->file_offset = failed_bbio->file_offset + bio_offset;
+	repair_bbio->fscrypt_info =
+		fscrypt_get_extent_info(failed_bbio->fscrypt_info);
+	repair_bbio->orig_start = failed_bbio->orig_start;
+
+	btrfs_set_bio_crypt_ctx_from_extent(repair_bio, repair_bbio->inode,
+					    failed_bbio->fscrypt_info,
+					    repair_bbio->file_offset -
+					    failed_bbio->orig_start);
 
 	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
 	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
@@ -312,7 +355,29 @@ blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
 		offset += sectorsize;
 	}
 
+	/*
+	 * Read repair is slightly different for encrypted bio's.  This callback
+	 * is before we decrypt the bio in the block crypto layer, we're not
+	 * actually in the endio handler.
+	 *
+	 * We don't trigger the repair process here either, that is handled in
+	 * the actual endio path because we don't want to create another psuedo
+	 * endio path through this callback.  This is because when we call
+	 * btrfs_repair_done() we want to call the endio for the original bbio.
+	 * Short circuiting that for the encrypted case would be ugly.  We
+	 * really want to the repair case to be handled generically.
+	 *
+	 * However for the actual repair part we need to use this page
+	 * pre-decrypted, which is why we call the btrfs_repair_io_failure()
+	 * code from this path.  The repair path is synchronous so we are safe
+	 * there.  Then we simply mark the repair bbio as completed so the
+	 * actual btrfs_end_repair_bio() code can skip the repair part.
+	 */
+	if (bbio->bio.bi_pool == &btrfs_repair_bioset)
+		handle_repair(bbio);
 	bbio->csum_done = true;
+	fscrypt_put_extent_info(bbio->fscrypt_info);
+	bbio->fscrypt_info = NULL;
 	return BLK_STS_OK;
 }
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 9465c23acb84..ba737c660010 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -13,6 +13,7 @@
 
 struct btrfs_bio;
 struct btrfs_fs_info;
+struct fscrypt_extent_info;
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
 
@@ -40,13 +41,20 @@ struct btrfs_bio {
 	union {
 		/*
 		 * For data reads: checksumming and original I/O information.
-		 * (for internal use in the btrfs_submit_bio machinery only)
+		 * (for internal use in the btrfs_submit_bio machinery only).
+		 *
+		 * The fscrypt context is used for read repair, this is the only
+		 * thing not internal to btrfs_submit_bio machinery.
 		 */
 		struct {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 			bool csum_done;
 			struct bvec_iter saved_iter;
+
+			/* Used for read repair. */
+			struct fscrypt_extent_info *fscrypt_info;
+			u64 orig_start;
 		};
 
 		/*
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5988813c5bd0..4a1e14efb937 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -603,6 +603,9 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compressed_len = compressed_len;
 	cb->compress_type = extent_map_compression(em);
 	cb->orig_bbio = bbio;
+	cb->bbio.fscrypt_info =
+		fscrypt_get_extent_info(em->fscrypt_info);
+	cb->bbio.orig_start = 0;
 
 	btrfs_set_bio_crypt_ctx_from_extent(&cb->bbio.bio, inode,
 					    em->fscrypt_info, 0);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 43680f26ddbe..3aee2dcc5864 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -835,6 +835,9 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	} else {
 		fscrypt_info = bio_ctrl->fscrypt_info;
 		offset = file_offset - bio_ctrl->orig_start;
+		bbio->fscrypt_info =
+			fscrypt_get_extent_info(fscrypt_info);
+		bbio->orig_start = bio_ctrl->orig_start;
 	}
 
 	btrfs_set_bio_crypt_ctx_from_extent(&bbio->bio, inode, fscrypt_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d882b2de7e2..5377ca2c896f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7972,6 +7972,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	} else {
 		fscrypt_info = dio_data->fscrypt_info;
 		offset = file_offset - dio_data->orig_start;
+		bbio->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+		bbio->orig_start = dio_data->orig_start;
 	}
 
 	btrfs_set_bio_crypt_ctx_from_extent(&bbio->bio, bbio->inode,
-- 
2.43.0


