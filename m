Return-Path: <linux-btrfs+bounces-19574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F3CAD149
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9340D303D3C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2365314D38;
	Mon,  8 Dec 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhIj1K+1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372427FB32
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195881; cv=none; b=iHdJe3tA1LLzkOjRnlMpbDP2eL9oE9BKV7ThB31gMcKqpmUWiB8jFjML+DxXUD+5471iTDE9pBjfDY+OmAW8esDMHuoHe85Q/xQpT1wVgEd67pIe7RJsbt3ogcvFj+JF1bQF3+nDVp49+KwOsMS6EgsJzJCiDlt4m5PjZ2qrvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195881; c=relaxed/simple;
	bh=AjO5iyr3sycM8pkoxkFHi2j3JezglR+6at8iRF+LPlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmqExAqplgT51LMRGC0tUIZFGctmftdwXm421s8T04ZBrdwymYdJjHWqa6sUpkBbol2Br7DWgP5ajkShNvvmzwTjrL1M0FVtz4T9r0KJ6o65bRutaZWskGg8lltYxcUHdWB3TAxgHKrywxFf5APteX44HD+eSggjBUpysiFojnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhIj1K+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvXDl6FlzKKYicGNNkhEQN3ksEUv+vCfWRlQsDRp75M=;
	b=bhIj1K+1A2DFMdpRJpsuiIOmDN72rCiYE5cTg+BmZcptfPRXC/EXiFL84xUEIPkUISanlE
	JYPXgb9Pr1RH9kubCsqfjJyt2QmD+URuKGQ9bmRIlJsWEbRx4nuFn0Co5TpqBJ/d4y6hl8
	+TEsyFycMZCQ19OiUnhs8VJ50I9Dqj8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-2pk4_5FGPfaZa_QA5J-5cw-1; Mon,
 08 Dec 2025 07:11:14 -0500
X-MC-Unique: 2pk4_5FGPfaZa_QA5J-5cw-1
X-Mimecast-MFC-AGG-ID: 2pk4_5FGPfaZa_QA5J-5cw_1765195872
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7DA318002E4;
	Mon,  8 Dec 2025 12:11:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 941921956095;
	Mon,  8 Dec 2025 12:11:09 +0000 (UTC)
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
Subject: [RFC 12/12] bio: add bio_endio_status
Date: Mon,  8 Dec 2025 12:10:19 +0000
Message-ID: <20251208121020.1780402-13-agruenba@redhat.com>
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

Add a bio_endio_status() helper as a shortcut for calling
bio_set_status() and bio_endio() in sequence. Use the new helper
throughout the code.

Created with Coccinelle using the following semantic patch:

@@
expression bio, status;
@@
- bio_set_status(bio, status);
- bio_endio(bio);
+ bio_endio_status(bio, status);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/bio-integrity-auto.c    |  3 +--
 block/blk-core.c              |  6 ++----
 block/blk-mq.c                |  6 ++----
 drivers/block/drbd/drbd_req.c |  3 +--
 drivers/block/ps3vram.c       |  3 +--
 drivers/md/dm-cache-target.c  |  3 +--
 drivers/md/dm-integrity.c     | 15 +++++----------
 drivers/md/dm-mpath.c         |  3 +--
 drivers/md/dm-raid1.c         |  3 +--
 drivers/md/dm-thin.c          |  3 +--
 drivers/md/dm.c               |  3 +--
 drivers/md/raid1-10.c         |  3 +--
 drivers/md/raid10.c           |  6 ++----
 include/linux/bio.h           | 12 ++++++++----
 14 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 736d53a7f699..1185f6e15d86 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -190,8 +190,7 @@ bool bio_integrity_prep(struct bio *bio)
 err_free_buf:
 	kfree(buf);
 err_end_io:
-	bio_set_status(bio, BLK_STS_RESOURCE);
-	bio_endio(bio);
+	bio_endio_status(bio, BLK_STS_RESOURCE);
 	return false;
 }
 EXPORT_SYMBOL(bio_integrity_prep);
diff --git a/block/blk-core.c b/block/blk-core.c
index 95cbb3ffcf9f..8b36674dc09a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -640,8 +640,7 @@ static void __submit_bio(struct bio *bio)
 	
 		if ((bio->bi_opf & REQ_POLLED) &&
 		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
-			bio_set_status(bio, BLK_STS_NOTSUPP);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_NOTSUPP);
 		} else {
 			disk->fops->submit_bio(bio);
 		}
@@ -882,8 +881,7 @@ void submit_bio_noacct(struct bio *bio)
 not_supported:
 	status = BLK_STS_NOTSUPP;
 end_io:
-	bio_set_status(bio, status);
-	bio_endio(bio);
+	bio_endio_status(bio, status);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 503ca259429f..10933de73205 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,8 +3164,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
-		bio_set_status(bio, BLK_STS_NOTSUPP);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
 
@@ -3205,8 +3204,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio_set_status(bio, ret);
-		bio_endio(bio);
+		bio_endio_status(bio, ret);
 		blk_mq_free_request(rq);
 		return;
 	}
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 5bedc972b622..41dbf8bbcd61 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1209,8 +1209,7 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 		/* only pass the error to the upper layers.
 		 * if user cannot handle io errors, that's not our business. */
 		drbd_err(device, "could not kmalloc() req\n");
-		bio_set_status(bio, BLK_STS_RESOURCE);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_RESOURCE);
 		return ERR_PTR(-ENOMEM);
 	}
 
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 06844674c998..8b8bdfa50c97 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -573,8 +573,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 	next = bio_list_peek(&priv->list);
 	spin_unlock_irq(&priv->lock);
 
-	bio_set_status(bio, error);
-	bio_endio(bio);
+	bio_endio_status(bio, error);
 	return next;
 }
 
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index d1dbd4ddaadb..da1b1eb29bb8 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1856,8 +1856,7 @@ static void requeue_deferred_bios(struct cache *cache)
 	bio_list_merge_init(&bios, &cache->deferred_bios);
 
 	while ((bio = bio_list_pop(&bios))) {
-		bio_set_status(bio, BLK_STS_DM_REQUEUE);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_DM_REQUEUE);
 		cond_resched();
 	}
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 90780a112009..06e5cdfdec7d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2513,8 +2513,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	sector_t recalc_sector;
 
 	if (unlikely(bio_integrity(bio))) {
-		bio_set_status(bio, BLK_STS_NOTSUPP);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		return DM_MAPIO_SUBMITTED;
 	}
 
@@ -2535,8 +2534,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 			if (dio->payload_len > x_size) {
 				unsigned sectors = ((x_size - extra_size) / ic->tuple_size) << ic->sb->log2_sectors_per_block;
 				if (WARN_ON(!sectors || sectors >= bio_sectors(bio))) {
-					bio_set_status(bio, BLK_STS_NOTSUPP);
-					bio_endio(bio);
+					bio_endio_status(bio, BLK_STS_NOTSUPP);
 					return DM_MAPIO_SUBMITTED;
 				}
 				dm_accept_partial_bio(bio, sectors);
@@ -2615,8 +2613,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	ret = bio_integrity_add_page(bio, virt_to_page(dio->integrity_payload),
 					dio->payload_len, offset_in_page(dio->integrity_payload));
 	if (unlikely(ret != dio->payload_len)) {
-		bio_set_status(bio, BLK_STS_RESOURCE);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_RESOURCE);
 		return DM_MAPIO_SUBMITTED;
 	}
 
@@ -2668,8 +2665,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		r = bio_integrity_add_page(outgoing_bio, virt_to_page(dio->integrity_payload), ic->tuple_size, 0);
 		if (unlikely(r != ic->tuple_size)) {
 			bio_put(outgoing_bio);
-			bio_set_status(bio, BLK_STS_RESOURCE);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_RESOURCE);
 			return;
 		}
 
@@ -2691,8 +2687,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 			dm_audit_log_bio(DM_MSG_PREFIX, "integrity-checksum",
 				bio, dio->bio_details.bi_iter.bi_sector, 0);
 
-			bio_set_status(bio, BLK_STS_PROTECTION);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_PROTECTION);
 			return;
 		}
 
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 761e5e79d4a7..1097ffb05b00 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -722,8 +722,7 @@ static void process_queued_bios(struct work_struct *work)
 			bio_io_error(bio);
 			break;
 		case DM_MAPIO_REQUEUE:
-			bio_set_status(bio, BLK_STS_DM_REQUEUE);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_DM_REQUEUE);
 			break;
 		case DM_MAPIO_REMAPPED:
 			submit_bio_noacct(bio);
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index c54995847db0..1f53b125b333 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -627,8 +627,7 @@ static void write_callback(unsigned long error, void *context)
 	 * degrade the array.
 	 */
 	if (bio_op(bio) == REQ_OP_DISCARD) {
-		bio_set_status(bio, BLK_STS_NOTSUPP);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		return;
 	}
 
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index bd061a6bf016..ae8850a3e728 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2731,8 +2731,7 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 	thin_hook_bio(tc, bio);
 
 	if (tc->requeue_mode) {
-		bio_set_status(bio, BLK_STS_DM_REQUEUE);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_DM_REQUEUE);
 		return DM_MAPIO_SUBMITTED;
 	}
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index cbc64377fa96..1743042db9f6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -983,8 +983,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 		queue_io(md, bio);
 	} else {
 		/* done with normal IO or empty flush */
-		bio_set_status(bio, io_error);
-		bio_endio(bio);
+		bio_endio_status(bio, io_error);
 	}
 }
 
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 504730aba9df..53903bb91408 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -104,8 +104,7 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		int len = min_t(int, size, PAGE_SIZE);
 
 		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-			bio_set_status(bio, BLK_STS_RESOURCE);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_RESOURCE);
 			return;
 		}
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7cc27819beb5..7750d6577b83 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3681,8 +3681,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			struct resync_pages *rp = get_resync_pages(bio);
 			page = resync_fetch_page(rp, page_idx);
 			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-				bio_set_status(bio, BLK_STS_RESOURCE);
-				bio_endio(bio);
+				bio_endio_status(bio, BLK_STS_RESOURCE);
 				goto giveup;
 			}
 		}
@@ -4863,8 +4862,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			len = PAGE_SIZE;
 		for (bio = blist; bio ; bio = bio->bi_next) {
 			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-				bio_set_status(bio, BLK_STS_RESOURCE);
-				bio_endio(bio);
+				bio_endio_status(bio, BLK_STS_RESOURCE);
 				return sectors_done;
 			}
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 06fb8ae018c4..8f6ac5fa0a12 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -382,17 +382,21 @@ static inline void bio_set_status(struct bio *bio, blk_status_t status)
 		WRITE_ONCE(bio->bi_status, status);
 }
 
-static inline void bio_io_error(struct bio *bio)
+static inline void bio_endio_status(struct bio *bio, blk_status_t status)
 {
-	bio_set_status(bio, BLK_STS_IOERR);
+	bio_set_status(bio, status);
 	bio_endio(bio);
 }
 
+static inline void bio_io_error(struct bio *bio)
+{
+	bio_endio_status(bio, BLK_STS_IOERR);
+}
+
 static inline void bio_wouldblock_error(struct bio *bio)
 {
 	bio_set_flag(bio, BIO_QUIET);
-	bio_set_status(bio, BLK_STS_AGAIN);
-	bio_endio(bio);
+	bio_endio_status(bio, BLK_STS_AGAIN);
 }
 
 blk_status_t errno_to_blk_status(int errno);
-- 
2.51.0


