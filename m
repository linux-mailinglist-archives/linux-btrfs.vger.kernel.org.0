Return-Path: <linux-btrfs+bounces-19929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24641CD3A43
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67822304DEC9
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF121C9EA;
	Sun, 21 Dec 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNZ0elEv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F826AC3
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285579; cv=none; b=VRJPbF3Np/73dLbfy9kepXnj8pR6Qbk61h4BpdPdkhyF1hl/aAC3owGSIXEpJZvC9LwyAeEew4B07oEew5CHvs9FSm9Xrxu9kCl2L+ECBHJUXSPVdyvkWNt22D80wIExSJR2hzg069iyf0VBTtwo7/jOcYi5jvRYCPBbLyhW9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285579; c=relaxed/simple;
	bh=ytmSqvCI1NK1Y6W/9zah+OycgBNTaOsJHj7jzvMklgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtDamMdn1MqAZRS94VEpHuN3NtaKVHC+raB6znV4ShU31t2BlAdl9IWkOtJZeIcwylgXSTSvPA0KgAu1bLM+Z/C6VFrHbwSzkA14poiIJ6ySTB8GZWg4yftHD6yoLGIMHG0tI50mNGe0NgV8MIHYPKSNzTAdEnGoVevQa63+CTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNZ0elEv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98J2ESppVbFgezylqxcV+tZ8H9YPLvgyX4ksKvm5FJY=;
	b=aNZ0elEvH73wvBVabDbkh6DnBEe7lNsGJ/TsK0UlW6g4yyS51NJW++nL1j8sOzAZFfa+Sa
	rfx/D4gdYxj/yevyWq/rPqswX9Y96P065Lm5hvK5frOomaIzgq13pmJ/U8IBRLiE+tb8Od
	Qj1/Fa+P2bgOmhBMt2dDjgdZMBA53pA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-NOr3FQneOXevrgcNFltEzw-1; Sat,
 20 Dec 2025 21:52:53 -0500
X-MC-Unique: NOr3FQneOXevrgcNFltEzw-1
X-Mimecast-MFC-AGG-ID: NOr3FQneOXevrgcNFltEzw_1766285571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8C551956088;
	Sun, 21 Dec 2025 02:52:50 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 851A21800352;
	Sun, 21 Dec 2025 02:52:47 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [RFC v2 03/17] bio: use bio_io_error more often
Date: Sun, 21 Dec 2025 03:52:18 +0100
Message-ID: <20251221025233.87087-4-agruenba@redhat.com>
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

Instead of setting bio->bi_status to BLK_STS_IOERR and calling
bio_endio(bio), use the shorthand bio_io_error(bio).

Created with Coccinelle using the following semantic patch:

@@
struct bio *bio;
@@
- bio->bi_status = BLK_STS_IOERR;
- bio_endio(bio);
+ bio_io_error(bio);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c                  | 3 +--
 drivers/block/drbd/drbd_int.h | 3 +--
 drivers/md/bcache/bcache.h    | 3 +--
 drivers/md/bcache/request.c   | 6 ++----
 drivers/md/dm-mpath.c         | 3 +--
 drivers/md/dm-writecache.c    | 3 +--
 fs/f2fs/segment.c             | 3 +--
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 5e3db9fead77..b4f911273289 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -221,8 +221,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 			break;
 		}
 		if (iocb->ki_flags & IOCB_NOWAIT) {
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f6d6276974ee..32639e8ea72a 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1491,8 +1491,7 @@ static inline void drbd_submit_bio_noacct(struct drbd_device *device,
 	__release(local);
 	if (!bio->bi_bdev) {
 		drbd_err(device, "drbd_submit_bio_noacct: bio->bi_bdev == NULL\n");
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 1d33e40d26ea..7ad7c778d8ff 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -940,8 +940,7 @@ static inline void closure_bio_submit(struct cache_set *c,
 {
 	closure_get(cl);
 	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags))) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 	submit_bio_noacct(bio);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde1..acccecd061ea 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1192,8 +1192,7 @@ void cached_dev_submit_bio(struct bio *bio)
 
 	if (unlikely((d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags)) ||
 		     dc->io_disable)) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
@@ -1296,8 +1295,7 @@ void flash_dev_submit_bio(struct bio *bio)
 	struct bcache_device *d = bio->bi_bdev->bd_disk->private_data;
 
 	if (unlikely(d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags))) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index aaf4a0a4b0eb..1424ef75d088 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -719,8 +719,7 @@ static void process_queued_bios(struct work_struct *work)
 		r = __multipath_map_bio(m, bio, mpio);
 		switch (r) {
 		case DM_MAPIO_KILL:
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 			break;
 		case DM_MAPIO_REQUEUE:
 			bio->bi_status = BLK_STS_DM_REQUEUE;
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index d8de4a3076a1..4f70e2673e4b 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1877,8 +1877,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 		if (WC_MODE_FUA(wc))
 			bio->bi_opf |= REQ_FUA;
 		if (writecache_has_error(wc)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 		} else if (unlikely(!bio_sectors(bio))) {
 			bio->bi_status = BLK_STS_OK;
 			bio_endio(bio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..6444d572f0c7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4090,8 +4090,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	if (fio->bio && *(fio->bio)) {
 		struct bio *bio = *(fio->bio);
 
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		*(fio->bio) = NULL;
 	}
 	return err;
-- 
2.52.0


