Return-Path: <linux-btrfs+bounces-19937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A3CD3A93
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9F9F3020153
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770C242D86;
	Sun, 21 Dec 2025 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/sjewNb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC5219E8C
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285608; cv=none; b=FKrVad2S3hmZLS64VsGIjeBRa2OHhYl+ODls+2PR69FSvKINS+nJYmGIkvEuOmbTeT2H3iTK7r6BQZRaKtoZ+kDbWTJV3RmTneoSCvlEZGoyy+PDoh13rkrL6Kwag+o9da9mDFEW3yPIy14QdX0cyIQeNXIVQ/WBjcxjpoHjrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285608; c=relaxed/simple;
	bh=YOHiTj7zz01Ftau5ICbeu6JHmAuhzPI0DVL/WCq46oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muIuifLCDNHLD8tqGkRhcmNV3SM4Sj6VdMV9hldjpw6C73s2hdz4jwgH4+yXye4Sbmi7zMTrKjEglTKH6LemAUEaqotBeZ+Udtgmvp3bjyhwuvfJnNbEV9IarPsVo9w99D3ZtOsL8k6cMVcl0xXOWtQnX3JblEyHRSz3RKN5gmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/sjewNb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdikDtYArLBH6tSr8rb+Y7nMetG0VOSDDLmbhd1+tro=;
	b=Y/sjewNbyYIVYiWP8GxJW8hp7f/1f2ZpPiK2AJkkN6Xko2gSDlnEECVIfhi/bVTtCuLx+b
	lCm+EqHqsVsi+PheCFrs2wmu5g/mQvKu6e7orDrsbfQVGuZZ4IFCNhqYJiHRrTH+FVwp5e
	F+I9I3qE52xQTIL58tBf67iti8+x6XA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-PNeO8f1ZMJCukkRtn-wWAw-1; Sat,
 20 Dec 2025 21:53:21 -0500
X-MC-Unique: PNeO8f1ZMJCukkRtn-wWAw-1
X-Mimecast-MFC-AGG-ID: PNeO8f1ZMJCukkRtn-wWAw_1766285599
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D2A8195608E;
	Sun, 21 Dec 2025 02:53:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A61A18004D4;
	Sun, 21 Dec 2025 02:53:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Satya Tangirala <satyat@google.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 11/17] bio: bio_set_status from non-zero errno
Date: Sun, 21 Dec 2025 03:52:26 +0100
Message-ID: <20251221025233.87087-12-agruenba@redhat.com>
In-Reply-To: <20251221025233.87087-1-agruenba@redhat.com>
References: <20251221025233.87087-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In these instances, the compiler knows that errno is not 0 and so it can
optimize 'bio_set_status(bio, errno_to_blk_status(errno))' as
'bio->bi_status = __errno_to_blk_status(errno)'.

Created with Coccinelle using the following semantic patch:

@@
struct bio *bio;
expression errno;
@@
- if (errno)
-       bio->bi_status = errno_to_blk_status(errno);
+ if (errno)
+	bio_set_status(bio, errno_to_blk_status(errno));

@@
struct bio *bio;
expression errno;
@@
- if (unlikely(errno))
-       bio->bi_status = errno_to_blk_status(errno);
+ if (unlikely(errno))
+	bio_set_status(bio, errno_to_blk_status(errno));

@@
expression status;
struct bio *bio;
@@
if (IS_ERR(status)) {
<...
-       bio->bi_status = errno_to_blk_status(PTR_ERR(status));
+       bio_set_status(bio, errno_to_blk_status(PTR_ERR(status)));
...>
}

@@
expression errno;
struct bio *bio;
@@
if (!errno)
	return;
-bio->bi_status = errno_to_blk_status(errno);
+bio_set_status(bio, errno_to_blk_status(errno));

@@
expression errno;
struct bio bio;
@@
if (errno)
-       bio.bi_status = errno_to_blk_status(errno);
+       bio_set_status(&bio, errno_to_blk_status(errno));

@@
expression errno;
struct bio bio;
@@
if (IS_ERR_VALUE(errno))
-       bio.bi_status = errno_to_blk_status(errno);
+       bio_set_status(&bio, errno_to_blk_status(errno));

@@
expression errno;
struct bio *bio;
@@
if (errno) {
<...
-       bio->bi_status = errno_to_blk_status(errno);
+       bio_set_status(bio, errno_to_blk_status(errno));
...>
}

@@
expression errno;
struct iomap_ioend *ioend;
struct bio bio;
@@
if (errno) {
<...
-       ioend->io_bio.bi_status = errno_to_blk_status(errno);
+       bio_set_status(&ioend->io_bio, errno_to_blk_status(errno));
...>
}

@@
expression errno;
struct bio *bio;
@@
if (errno < 0) {
<...
-       bio->bi_status = errno_to_blk_status(errno);
+       bio_set_status(bio, errno_to_blk_status(errno));
...>
}

@@
expression errno;
struct bio *bio;
@@
if (unlikely(errno < 0)) {
<...
-       bio->bi_status = errno_to_blk_status(errno);
+       bio_set_status(bio, errno_to_blk_status(errno));
...>
}

@@
expression errno;
struct bio *bio;
@@
if (unlikely(errno != 0)) {
<...
-       bio->bi_status = errno_to_blk_status(errno);
+       bio_set_status(bio, errno_to_blk_status(errno));
...>
}

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-merge.c             | 4 ++--
 drivers/block/drbd/drbd_req.c | 2 +-
 drivers/md/dm-ebs-target.c    | 2 +-
 drivers/md/dm-integrity.c     | 6 +++---
 drivers/md/raid10.c           | 6 ++++--
 drivers/nvdimm/btt.c          | 2 +-
 drivers/nvdimm/pmem.c         | 2 +-
 fs/btrfs/bio.c                | 2 +-
 fs/btrfs/direct-io.c          | 2 +-
 fs/btrfs/raid56.c             | 4 ++--
 fs/crypto/bio.c               | 2 +-
 fs/erofs/fscache.c            | 8 +++++---
 fs/iomap/ioend.c              | 2 +-
 fs/xfs/xfs_aops.c             | 2 +-
 14 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 37864c5d287e..27ea5ffb8f77 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -122,7 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
 
 	if (IS_ERR(split)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+		bio_set_status(bio, errno_to_blk_status(PTR_ERR(split)));
 		bio_endio(bio);
 		return NULL;
 	}
@@ -143,7 +143,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
 	if (unlikely(split_sectors < 0)) {
-		bio->bi_status = errno_to_blk_status(split_sectors);
+		bio_set_status(bio, errno_to_blk_status(split_sectors));
 		bio_endio(bio);
 		return NULL;
 	}
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index baa08d56494d..983b2ff5eb6b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -177,7 +177,7 @@ void complete_master_bio(struct drbd_device *device,
 		struct bio_and_error *m)
 {
 	if (unlikely(m->error))
-		m->bio->bi_status = errno_to_blk_status(m->error);
+		bio_set_status(m->bio, errno_to_blk_status(m->error));
 	bio_endio(m->bio);
 	dec_ap_bio(device);
 }
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 6abb31ca9662..2c97c36df23a 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -217,7 +217,7 @@ static void __ebs_process_bios(struct work_struct *ws)
 		}
 
 		if (r < 0)
-			bio->bi_status = errno_to_blk_status(r);
+			bio_set_status(bio, errno_to_blk_status(r));
 	}
 
 	/*
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 6d04b067060d..c5c7c167b45d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2593,7 +2593,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
+		bio_set_status(bio, errno_to_blk_status(PTR_ERR(bip)));
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -2661,7 +2661,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
 		if (IS_ERR(bip)) {
 			bio_put(outgoing_bio);
-			bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
+			bio_set_status(bio, errno_to_blk_status(PTR_ERR(bip)));
 			bio_endio(bio);
 			return;
 		}
@@ -2679,7 +2679,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		r = submit_bio_wait(outgoing_bio);
 		if (unlikely(r != 0)) {
 			bio_put(outgoing_bio);
-			bio->bi_status = errno_to_blk_status(r);
+			bio_set_status(bio, errno_to_blk_status(r));
 			bio_endio(bio);
 			return;
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 59b900672a7a..3e15e190f103 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1665,7 +1665,8 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = stripe_size - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_set_status(bio,
+				       errno_to_blk_status(PTR_ERR(split)));
 			bio_endio(bio);
 			return 0;
 		}
@@ -1682,7 +1683,8 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = bio_sectors(bio) - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_set_status(bio,
+				       errno_to_blk_status(PTR_ERR(split)));
 			bio_endio(bio);
 			return 0;
 		}
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3da30dcbf26c..3b9a7d7b9694 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1468,7 +1468,7 @@ static void btt_submit_bio(struct bio *bio)
 					(op_is_write(bio_op(bio))) ? "WRITE" :
 					"READ",
 					(unsigned long long) iter.bi_sector, len);
-			bio->bi_status = errno_to_blk_status(err);
+			bio_set_status(bio, errno_to_blk_status(err));
 			break;
 		}
 	}
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4fdcbe56a3bc..6b64a217d180 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -233,7 +233,7 @@ static void pmem_submit_bio(struct bio *bio)
 		ret = nvdimm_flush(nd_region, bio);
 
 	if (ret)
-		bio->bi_status = errno_to_blk_status(ret);
+		bio_set_status(bio, errno_to_blk_status(ret));
 
 	bio_endio(bio);
 }
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 519635e2833a..1947f1cb7d08 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -540,7 +540,7 @@ static void run_one_async_start(struct btrfs_work *work)
 
 	ret = btrfs_bio_csum(async->bbio);
 	if (ret)
-		async->bbio->bio.bi_status = errno_to_blk_status(ret);
+		bio_set_status(&async->bbio->bio, errno_to_blk_status(ret));
 }
 
 /*
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..04facbbe6994 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -738,7 +738,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
 						    file_offset, dip->bytes,
 						    !ret);
-			bio->bi_status = errno_to_blk_status(ret);
+			bio_set_status(bio, errno_to_blk_status(ret));
 			iomap_dio_bio_end_io(bio);
 			return;
 		}
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0135dceb7baa..b60ab0bb08ad 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1750,7 +1750,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
+		bio_set_status(bio, errno_to_blk_status(PTR_ERR(rbio)));
 		bio_endio(bio);
 		return;
 	}
@@ -2148,7 +2148,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
+		bio_set_status(bio, errno_to_blk_status(PTR_ERR(rbio)));
 		bio_endio(bio);
 		return;
 	}
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 5f5599020e94..21a3a1c170a2 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -39,7 +39,7 @@ bool fscrypt_decrypt_bio(struct bio *bio)
 							   fi.offset);
 
 		if (err) {
-			bio->bi_status = errno_to_blk_status(err);
+			bio_set_status(bio, errno_to_blk_status(err));
 			return false;
 		}
 	}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 362acf828279..9d84bf24e501 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -183,8 +183,10 @@ static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error)
 {
 	struct erofs_fscache_bio *io = priv;
 
-	if (IS_ERR_VALUE(transferred_or_error))
-		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		bio_set_status(&io->bio,
+			       errno_to_blk_status(transferred_or_error));
+	}
 	io->bio.bi_end_io(&io->bio);
 	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
 	erofs_fscache_io_put(&io->io);
@@ -215,7 +217,7 @@ void erofs_fscache_submit_bio(struct bio *bio)
 	erofs_fscache_io_put(&io->io);
 	if (!ret)
 		return;
-	bio->bi_status = errno_to_blk_status(ret);
+	bio_set_status(bio, errno_to_blk_status(ret));
 	bio->bi_end_io(bio);
 }
 
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab26..1ebe6730d013 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -87,7 +87,7 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		error = -EIO;
 
 	if (error) {
-		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_set_status(&ioend->io_bio, errno_to_blk_status(error));
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..bd2b828164cb 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -653,7 +653,7 @@ xfs_zoned_writeback_submit(
 
 	ioend->io_bio.bi_end_io = xfs_end_bio;
 	if (error) {
-		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_set_status(&ioend->io_bio, errno_to_blk_status(error));
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
-- 
2.52.0


