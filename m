Return-Path: <linux-btrfs+bounces-19567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6127BCAD13D
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4143A30BCAD0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FB2EB873;
	Mon,  8 Dec 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+DzRerC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B972EA481
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195853; cv=none; b=H4WHHBanU0FWWqx+lVVFVfIsl5pCjjRdpHV6mlgceLTSBuabm6vZvR6FxbFHSi3EP+W7zI5PFcSRgBx3k/Et7PnOviQIQbqPR7va966Hz+MdCqbdVXlopyzxIRzd2sSsJe0HdQ7swQsM8lQc87whcOcO2437TmCm3KbeaOosJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195853; c=relaxed/simple;
	bh=HpnV20rr6ndnsBiMksVhcGhycFoozLiEWv42W/MgAIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4Dt60iJjQBdcTWcga06vzC77Ctk1y3Jx6lxUGQd4xXsp+8VfGVwSUbtpiel2TSyCwWJCuaBpToaDdkr/0GgufoFuLXQzeuBcy8uLm8EeyvW7SwLj3GChjpkBwdmgtRUP6Jstpw/38AC27DLZZRD9MOI5PyHoxPkyto4jFppv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+DzRerC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llhA/XktVdHDQw9IcSMkZaUbOu3Kj1S2mlzAS2mLG5s=;
	b=J+DzRerC0AHqf4fF/YCvM7d/o9k1seaKHitzyVws5XkXxcozucN+5uaVCWAfptmmbSnqtD
	BxfXD97Bfkdjy9Dd+uYpyv08u16jfob8iefTvYE4FCXIPWBwojYyLu40H9gU2YnYhzKA4j
	VFdhcjwHAX80d8gZ3qZtoJJcOXwaaAo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179--W1j2S5LOy2mP-0qp13q-Q-1; Mon,
 08 Dec 2025 07:10:44 -0500
X-MC-Unique: -W1j2S5LOy2mP-0qp13q-Q-1
X-Mimecast-MFC-AGG-ID: -W1j2S5LOy2mP-0qp13q-Q_1765195843
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACFEE18002F7;
	Mon,  8 Dec 2025 12:10:42 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A4101956095;
	Mon,  8 Dec 2025 12:10:39 +0000 (UTC)
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
Subject: [RFC 04/12] bio: use bio_set_errno in more places
Date: Mon,  8 Dec 2025 12:10:11 +0000
Message-ID: <20251208121020.1780402-5-agruenba@redhat.com>
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

Replace variations of 'bio->bi_status = errno_to_blk_status(errno)' with
a call to bio_set_errno(bio, errno).

Note that bio_set_errno(bio, errno) only sets bio->bi_status to
errno_to_blk_status(errno) if errno is not 0.  We must never set
bio->bi_status to 0 during bio completion.

Also note that bio_set_errno() is an inline function so that the
compiler can get rid of the errno check in case it knows that errno is
not 0.  This is true for all bio_set_errno() calls this patch adds
except for the following two:

  drivers/md/dm-pcache/dm_pcache.c:end_req()
  drivers/md/dm-vdo/data-vio.c:acknowledge_data_vio()

In both of these cases, it seems that bi_status can be set to 0 during
bio completion, so the additional check that comes with using
bio_set_errno() appears to be necessary.

Created with Coccinelle using the following semantic patch:

@@
struct bio *bio;
expression errno;
@@
- bio->bi_status = errno_to_blk_status(errno);
+ bio_set_errno(bio, errno);

@@
struct bio bio;
expression errno;
@@
- bio.bi_status = errno_to_blk_status(errno);
+ bio_set_errno(&bio, errno);

@@
struct iomap_ioend *ioend;
expression error;
@@
- ioend->io_bio.bi_status = errno_to_blk_status(error);
+ bio_set_errno(&ioend->io_bio, error);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-merge.c                | 4 ++--
 drivers/md/dm-ebs-target.c       | 2 +-
 drivers/md/dm-integrity.c        | 8 ++++----
 drivers/md/dm-pcache/dm_pcache.c | 2 +-
 drivers/md/dm-thin.c             | 2 +-
 drivers/md/dm-vdo/data-vio.c     | 2 +-
 drivers/md/raid10.c              | 4 ++--
 drivers/nvdimm/btt.c             | 2 +-
 fs/btrfs/bio.c                   | 2 +-
 fs/btrfs/direct-io.c             | 2 +-
 fs/btrfs/raid56.c                | 4 ++--
 fs/crypto/bio.c                  | 2 +-
 fs/erofs/fileio.c                | 2 +-
 fs/erofs/fscache.c               | 4 ++--
 fs/iomap/ioend.c                 | 2 +-
 fs/xfs/xfs_aops.c                | 2 +-
 fs/xfs/xfs_zone_alloc.c          | 2 +-
 17 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 37864c5d287e..441013bf59d7 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -122,7 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
 
 	if (IS_ERR(split)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+		bio_set_errno(bio, PTR_ERR(split));
 		bio_endio(bio);
 		return NULL;
 	}
@@ -143,7 +143,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
 	if (unlikely(split_sectors < 0)) {
-		bio->bi_status = errno_to_blk_status(split_sectors);
+		bio_set_errno(bio, split_sectors);
 		bio_endio(bio);
 		return NULL;
 	}
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 6abb31ca9662..d9f46cbfe89f 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -217,7 +217,7 @@ static void __ebs_process_bios(struct work_struct *ws)
 		}
 
 		if (r < 0)
-			bio->bi_status = errno_to_blk_status(r);
+			bio_set_errno(bio, r);
 	}
 
 	/*
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 170bf67a2edd..26e500730b3c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1581,7 +1581,7 @@ static void do_endio(struct dm_integrity_c *ic, struct bio *bio)
 
 	r = dm_integrity_failed(ic);
 	if (unlikely(r) && !bio->bi_status)
-		bio->bi_status = errno_to_blk_status(r);
+		bio_set_errno(bio, r);
 	if (unlikely(ic->synchronous_mode) && bio_op(bio) == REQ_OP_WRITE) {
 		unsigned long flags;
 
@@ -2594,7 +2594,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
+		bio_set_errno(bio, PTR_ERR(bip));
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -2662,7 +2662,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
 		if (IS_ERR(bip)) {
 			bio_put(outgoing_bio);
-			bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
+			bio_set_errno(bio, PTR_ERR(bip));
 			bio_endio(bio);
 			return;
 		}
@@ -2680,7 +2680,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		r = submit_bio_wait(outgoing_bio);
 		if (unlikely(r != 0)) {
 			bio_put(outgoing_bio);
-			bio->bi_status = errno_to_blk_status(r);
+			bio_set_errno(bio, r);
 			bio_endio(bio);
 			return;
 		}
diff --git a/drivers/md/dm-pcache/dm_pcache.c b/drivers/md/dm-pcache/dm_pcache.c
index e5f5936fa6f0..4acfaab91170 100644
--- a/drivers/md/dm-pcache/dm_pcache.c
+++ b/drivers/md/dm-pcache/dm_pcache.c
@@ -74,7 +74,7 @@ static void end_req(struct kref *ref)
 		pcache_req_get(pcache_req);
 		defer_req(pcache_req);
 	} else {
-		bio->bi_status = errno_to_blk_status(ret);
+		bio_set_errno(bio, ret);
 		bio_endio(bio);
 
 		if (atomic_dec_and_test(&pcache->inflight_reqs))
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index c84149ba4e38..ad6b8b3c12dd 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -423,7 +423,7 @@ static void end_discard(struct discard_op *op, int r)
 	 * need to wait for.
 	 */
 	if (r && !op->parent_bio->bi_status)
-		op->parent_bio->bi_status = errno_to_blk_status(r);
+		bio_set_errno(op->parent_bio, r);
 	bio_endio(op->parent_bio);
 }
 
diff --git a/drivers/md/dm-vdo/data-vio.c b/drivers/md/dm-vdo/data-vio.c
index 262e11581f2d..eaa435dd8e60 100644
--- a/drivers/md/dm-vdo/data-vio.c
+++ b/drivers/md/dm-vdo/data-vio.c
@@ -287,7 +287,7 @@ static void acknowledge_data_vio(struct data_vio *data_vio)
 	if (data_vio->is_partial)
 		vdo_count_bios(&vdo->stats.bios_acknowledged_partial, bio);
 
-	bio->bi_status = errno_to_blk_status(error);
+	bio_set_errno(bio, error);
 	bio_endio(bio);
 }
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 14dcd5142eb4..9ac26d1f0764 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1665,7 +1665,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = stripe_size - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_set_errno(bio, PTR_ERR(split));
 			bio_endio(bio);
 			return 0;
 		}
@@ -1682,7 +1682,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = bio_sectors(bio) - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_set_errno(bio, PTR_ERR(split));
 			bio_endio(bio);
 			return 0;
 		}
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index a933db961ed7..14a8b7622b0d 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1468,7 +1468,7 @@ static void btt_submit_bio(struct bio *bio)
 					(op_is_write(bio_op(bio))) ? "WRITE" :
 					"READ",
 					(unsigned long long) iter.bi_sector, len);
-			bio->bi_status = errno_to_blk_status(err);
+			bio_set_errno(bio, err);
 			break;
 		}
 	}
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa..a0f55591fb90 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -540,7 +540,7 @@ static void run_one_async_start(struct btrfs_work *work)
 
 	ret = btrfs_bio_csum(async->bbio);
 	if (ret)
-		async->bbio->bio.bi_status = errno_to_blk_status(ret);
+		bio_set_errno(&async->bbio->bio, ret);
 }
 
 /*
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..d47c72abcdc3 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -738,7 +738,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
 						    file_offset, dip->bytes,
 						    !ret);
-			bio->bi_status = errno_to_blk_status(ret);
+			bio_set_errno(bio, ret);
 			iomap_dio_bio_end_io(bio);
 			return;
 		}
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0135dceb7baa..ff802b6513af 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1750,7 +1750,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
+		bio_set_errno(bio, PTR_ERR(rbio));
 		bio_endio(bio);
 		return;
 	}
@@ -2148,7 +2148,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
+		bio_set_errno(bio, PTR_ERR(rbio));
 		bio_endio(bio);
 		return;
 	}
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 5f5599020e94..96977fb5eb1d 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -39,7 +39,7 @@ bool fscrypt_decrypt_bio(struct bio *bio)
 							   fi.offset);
 
 		if (err) {
-			bio->bi_status = errno_to_blk_status(err);
+			bio_set_errno(bio, err);
 			return false;
 		}
 	}
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index b7b3432a9882..0478243ca72e 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -33,7 +33,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	}
 	if (rq->bio.bi_end_io) {
 		if (ret < 0 && !rq->bio.bi_status)
-			rq->bio.bi_status = errno_to_blk_status(ret);
+			bio_set_errno(&rq->bio, ret);
 		rq->bio.bi_end_io(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 362acf828279..dc0790d08510 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -184,7 +184,7 @@ static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error)
 	struct erofs_fscache_bio *io = priv;
 
 	if (IS_ERR_VALUE(transferred_or_error))
-		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
+		bio_set_errno(&io->bio, transferred_or_error);
 	io->bio.bi_end_io(&io->bio);
 	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
 	erofs_fscache_io_put(&io->io);
@@ -215,7 +215,7 @@ void erofs_fscache_submit_bio(struct bio *bio)
 	erofs_fscache_io_put(&io->io);
 	if (!ret)
 		return;
-	bio->bi_status = errno_to_blk_status(ret);
+	bio_set_errno(bio, ret);
 	bio->bi_end_io(bio);
 }
 
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab26..67cd48180fb2 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -87,7 +87,7 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		error = -EIO;
 
 	if (error) {
-		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_set_errno(&ioend->io_bio, error);
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..61368223a069 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -653,7 +653,7 @@ xfs_zoned_writeback_submit(
 
 	ioend->io_bio.bi_end_io = xfs_end_bio;
 	if (error) {
-		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_set_errno(&ioend->io_bio, error);
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index ef7a931ebde5..1381ba5a878e 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -896,7 +896,7 @@ xfs_zone_alloc_and_submit(
 	return;
 
 out_split_error:
-	ioend->io_bio.bi_status = errno_to_blk_status(PTR_ERR(split));
+	bio_set_errno(&ioend->io_bio, PTR_ERR(split));
 out_error:
 	bio_io_error(&ioend->io_bio);
 }
-- 
2.51.0


