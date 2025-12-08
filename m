Return-Path: <linux-btrfs+bounces-19573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C04CAD17E
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5035B3087D41
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3153148C3;
	Mon,  8 Dec 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+PkMr1r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1B314A67
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195876; cv=none; b=BUU/XnhmU4Ox2LhkLtp91zQtvrjD449rnokARSh+TN50YpJWe/Q8t/Z93vKKQcayi9eXlVKHqD6eykiPSmar0RplwsMYXupIJD0aGb0Lqc025JBVCwzvD5gwfAqjWHAorwAWy82NYEoWDx+o7ORIYDGG696Ck0VS8agSpxJCIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195876; c=relaxed/simple;
	bh=ma2lFAo3foTNL8GPuoOXvRCzcKPR+3yVB6nerqkNVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNFtXWPYBcR9aBYc1Sn5+j62UrEdBddeIdQ+N4rdUxDVnjkVOaUgqphejX0+kTlM7NOpTlR3nRAZ0hOReZ8S8Z5Xa1uI82eq7TR3rGZSXnxat9xONeVRuTSJ3Q8MwlGghz71cvH+fl0mDEsk4I6nUMeclve3bCaDbmm8cpDrtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+PkMr1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9u8cA7lHo2dE6Tv8kTZzAaXvgSUqTY3isgQdGmVBD0=;
	b=U+PkMr1r1M4ml28CX7TZVIimjrhDQFgkq7rt4Uf8ozRhaWcSdTPhKyc8y6cdXP+pgllf4i
	GWfM+QZ+7Vdre4BFGrr5P+eZJlewqBL0ds3Z2skvCuox9XWKkz1wiOgM62fPPtR+x/XjPo
	Uzxg+r3uVovTcPyAQij09B/jM39OE/U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-Kgvi1fWfOVOg7obb1k2nbw-1; Mon,
 08 Dec 2025 07:11:10 -0500
X-MC-Unique: Kgvi1fWfOVOg7obb1k2nbw-1
X-Mimecast-MFC-AGG-ID: Kgvi1fWfOVOg7obb1k2nbw_1765195869
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B6BE1956080;
	Mon,  8 Dec 2025 12:11:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 088791955F24;
	Mon,  8 Dec 2025 12:11:05 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 11/12] bio: add bio_endio_errno
Date: Mon,  8 Dec 2025 12:10:18 +0000
Message-ID: <20251208121020.1780402-12-agruenba@redhat.com>
In-Reply-To: <20251208121020.1780402-1-agruenba@redhat.com>
References: <20251208121020.1780402-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a bio_endio_errno() helper as a shortcut for calling bio_set_errno()
and bio_endio() in sequence. Use the new helper throughout the code.

Created with Coccinelle using the following semantic patch:

@@
expression bio, errno;
@@
- bio_set_errno(bio, errno);
- bio_endio(bio);
+ bio_endio_errno(bio, errno);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-merge.c                | 6 ++----
 drivers/block/drbd/drbd_req.c    | 3 +--
 drivers/md/dm-integrity.c        | 9 +++------
 drivers/md/dm-pcache/dm_pcache.c | 3 +--
 drivers/md/dm-vdo/data-vio.c     | 3 +--
 drivers/md/raid10.c              | 6 ++----
 drivers/nvdimm/pmem.c            | 4 +---
 fs/btrfs/raid56.c                | 6 ++----
 fs/iomap/ioend.c                 | 3 +--
 fs/xfs/xfs_aops.c                | 3 +--
 include/linux/bio.h              | 6 ++++++
 11 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 441013bf59d7..25057d57e9ac 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -122,8 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
 
 	if (IS_ERR(split)) {
-		bio_set_errno(bio, PTR_ERR(split));
-		bio_endio(bio);
+		bio_endio_errno(bio, PTR_ERR(split));
 		return NULL;
 	}
 
@@ -143,8 +142,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
 	if (unlikely(split_sectors < 0)) {
-		bio_set_errno(bio, split_sectors);
-		bio_endio(bio);
+		bio_endio_errno(bio, split_sectors);
 		return NULL;
 	}
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 95a58ad6fdcf..5bedc972b622 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -176,8 +176,7 @@ void start_new_tl_epoch(struct drbd_connection *connection)
 void complete_master_bio(struct drbd_device *device,
 		struct bio_and_error *m)
 {
-	bio_set_errno(m->bio, m->error);
-	bio_endio(m->bio);
+	bio_endio_errno(m->bio, m->error);
 	dec_ap_bio(device);
 }
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 5220e15b6537..90780a112009 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2594,8 +2594,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
-		bio_set_errno(bio, PTR_ERR(bip));
-		bio_endio(bio);
+		bio_endio_errno(bio, PTR_ERR(bip));
 		return DM_MAPIO_SUBMITTED;
 	}
 
@@ -2662,8 +2661,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
 		if (IS_ERR(bip)) {
 			bio_put(outgoing_bio);
-			bio_set_errno(bio, PTR_ERR(bip));
-			bio_endio(bio);
+			bio_endio_errno(bio, PTR_ERR(bip));
 			return;
 		}
 
@@ -2680,8 +2678,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		r = submit_bio_wait(outgoing_bio);
 		if (unlikely(r != 0)) {
 			bio_put(outgoing_bio);
-			bio_set_errno(bio, r);
-			bio_endio(bio);
+			bio_endio_errno(bio, r);
 			return;
 		}
 		bio_put(outgoing_bio);
diff --git a/drivers/md/dm-pcache/dm_pcache.c b/drivers/md/dm-pcache/dm_pcache.c
index 4acfaab91170..b3795e88f364 100644
--- a/drivers/md/dm-pcache/dm_pcache.c
+++ b/drivers/md/dm-pcache/dm_pcache.c
@@ -74,8 +74,7 @@ static void end_req(struct kref *ref)
 		pcache_req_get(pcache_req);
 		defer_req(pcache_req);
 	} else {
-		bio_set_errno(bio, ret);
-		bio_endio(bio);
+		bio_endio_errno(bio, ret);
 
 		if (atomic_dec_and_test(&pcache->inflight_reqs))
 			wake_up(&pcache->inflight_wq);
diff --git a/drivers/md/dm-vdo/data-vio.c b/drivers/md/dm-vdo/data-vio.c
index eaa435dd8e60..47827ea61d91 100644
--- a/drivers/md/dm-vdo/data-vio.c
+++ b/drivers/md/dm-vdo/data-vio.c
@@ -287,8 +287,7 @@ static void acknowledge_data_vio(struct data_vio *data_vio)
 	if (data_vio->is_partial)
 		vdo_count_bios(&vdo->stats.bios_acknowledged_partial, bio);
 
-	bio_set_errno(bio, error);
-	bio_endio(bio);
+	bio_endio_errno(bio, error);
 }
 
 static void copy_to_bio(struct bio *bio, char *data_ptr)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 62d5bc9f7b3e..7cc27819beb5 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1665,8 +1665,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = stripe_size - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio_set_errno(bio, PTR_ERR(split));
-			bio_endio(bio);
+			bio_endio_errno(bio, PTR_ERR(split));
 			return 0;
 		}
 
@@ -1682,8 +1681,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = bio_sectors(bio) - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio_set_errno(bio, PTR_ERR(split));
-			bio_endio(bio);
+			bio_endio_errno(bio, PTR_ERR(split));
 			return 0;
 		}
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index aa2a486522b5..ed763c1ec955 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -232,9 +232,7 @@ static void pmem_submit_bio(struct bio *bio)
 	if (bio->bi_opf & REQ_FUA)
 		ret = nvdimm_flush(nd_region, bio);
 
-	bio_set_errno(bio, ret);
-
-	bio_endio(bio);
+	bio_endio_errno(bio, ret);
 }
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ff802b6513af..bf45e8fd3aa1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1750,8 +1750,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio_set_errno(bio, PTR_ERR(rbio));
-		bio_endio(bio);
+		bio_endio_errno(bio, PTR_ERR(rbio));
 		return;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
@@ -2148,8 +2147,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio_set_errno(bio, PTR_ERR(rbio));
-		bio_endio(bio);
+		bio_endio_errno(bio, PTR_ERR(rbio));
 		return;
 	}
 
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 67cd48180fb2..d9e9659b55b3 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -87,8 +87,7 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		error = -EIO;
 
 	if (error) {
-		bio_set_errno(&ioend->io_bio, error);
-		bio_endio(&ioend->io_bio);
+		bio_endio_errno(&ioend->io_bio, error);
 		return error;
 	}
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 61368223a069..4da13a15cb62 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -653,8 +653,7 @@ xfs_zoned_writeback_submit(
 
 	ioend->io_bio.bi_end_io = xfs_end_bio;
 	if (error) {
-		bio_set_errno(&ioend->io_bio, error);
-		bio_endio(&ioend->io_bio);
+		bio_endio_errno(&ioend->io_bio, error);
 		return error;
 	}
 	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad70a88cef09..06fb8ae018c4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -403,6 +403,12 @@ static inline void bio_set_errno(struct bio *bio, int errno)
 		WRITE_ONCE(bio->bi_status, errno_to_blk_status(errno));
 }
 
+static inline void bio_endio_errno(struct bio *bio, int errno)
+{
+	bio_set_errno(bio, errno);
+	bio_endio(bio);
+}
+
 /*
  * Calculate number of bvec segments that should be allocated to fit data
  * pointed by @iter. If @iter is backed by bvec it's going to be reused
-- 
2.51.0


