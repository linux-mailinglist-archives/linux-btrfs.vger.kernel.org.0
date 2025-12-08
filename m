Return-Path: <linux-btrfs+bounces-19570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74746CAD118
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C4D33027FE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A631327A;
	Mon,  8 Dec 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lw8/Mmmd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4402F6915
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195865; cv=none; b=Hwh6rMS4Xoin+tqSacjrdzg9hZBb4kyBo205IaYwTIgwOWKII/ot4SzBhRed6qgF2F5qaDh5W+rcIvOuEy1jUr8rhoe9nASWhDDAVceBHhRuC1AhWfY5QpzwEkUZ6jBazam+rnQF3AUhPb9WWbLGwYuFlmTer0zHZFV8FTc5NVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195865; c=relaxed/simple;
	bh=jdN3zclU3525rrr0JBy1+Jm0EVFmOArFoOHlgTydJf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFnbhs7E+uS6jD58LvDVLDYHhdSRmb8Nk2KunMwGGWbz09N9W/yqw/Z5WqYVo2ovB8omlt2hCZ9XUZwjx2FYTSVYsIkz2BITrukxaR5i1g85ZVVEFA3OOKeTOzRDKKfR4ZwACxZLx234NpPYLqvbxsqvAkt8ksWOdL0zKzlwCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lw8/Mmmd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PryfkEachwkf3jXEOfd1/qHxkXJoX+SFtYslbEvBn6o=;
	b=Lw8/Mmmd+GNYm65+1hEXA0ylZk7ixD4/enKrkIlbb6ge+lRZdMKTZf0dQn7OnRek/w1/5a
	yGr3mhzDLuPKAbTbwy57KBa7tmfiZb1jPbbYq6OSSaMAdgE4zYPnVs6pXUOxl/yz2S+JJs
	8o4MVpZE3lo/K2qXlQiphkp1f+/IGKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-I4_CTspuMI-YGZugFqzx9w-1; Mon,
 08 Dec 2025 07:10:56 -0500
X-MC-Unique: I4_CTspuMI-YGZugFqzx9w-1
X-Mimecast-MFC-AGG-ID: I4_CTspuMI-YGZugFqzx9w_1765195854
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C09801956058;
	Mon,  8 Dec 2025 12:10:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 198E71956095;
	Mon,  8 Dec 2025 12:10:50 +0000 (UTC)
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
Subject: [RFC 07/12] bio: use bio_set_status for BLK_STS_* status codes
Date: Mon,  8 Dec 2025 12:10:14 +0000
Message-ID: <20251208121020.1780402-8-agruenba@redhat.com>
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

Use bio_set_status(bio, status) in cases where status is a blk_status_t
constant other than BLK_STS_OK.  In these cases, the compiler knows that
status != BLK_STS_OK, so it can optimize out the check in
bio_set_status() and effectively end up with identical code.

Created with Coccinelle using the following semantic patch:

@@
expression bio;
constant C != 0 && != BLK_STS_OK;
@@
- bio->bi_status = C;
+ bio_set_status(bio, C);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/bio-integrity-auto.c    |  2 +-
 block/blk-core.c              |  2 +-
 block/blk-crypto-fallback.c   | 16 ++++++++--------
 block/blk-crypto-internal.h   |  2 +-
 block/blk-crypto.c            |  4 ++--
 block/blk-mq.c                |  4 ++--
 drivers/block/aoe/aoecmd.c    |  8 ++++----
 drivers/block/aoe/aoedev.c    |  2 +-
 drivers/block/drbd/drbd_req.c |  4 ++--
 drivers/block/zram/zram_drv.c |  4 ++--
 drivers/md/bcache/request.c   |  2 +-
 drivers/md/dm-cache-target.c  |  5 +++--
 drivers/md/dm-integrity.c     | 12 ++++++------
 drivers/md/dm-mpath.c         |  2 +-
 drivers/md/dm-raid1.c         |  6 +++---
 drivers/md/dm-thin.c          |  2 +-
 drivers/md/dm-writecache.c    |  4 ++--
 drivers/md/md.c               |  2 +-
 drivers/md/raid1-10.c         |  2 +-
 drivers/md/raid1.c            |  2 +-
 drivers/md/raid10.c           | 10 +++++-----
 drivers/md/raid5.c            |  4 ++--
 drivers/nvdimm/btt.c          |  2 +-
 fs/btrfs/bio.c                |  2 +-
 fs/f2fs/data.c                |  6 +++---
 fs/verity/verify.c            |  2 +-
 include/linux/bio.h           |  4 ++--
 27 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 687952f63bbb..736d53a7f699 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -190,7 +190,7 @@ bool bio_integrity_prep(struct bio *bio)
 err_free_buf:
 	kfree(buf);
 err_end_io:
-	bio->bi_status = BLK_STS_RESOURCE;
+	bio_set_status(bio, BLK_STS_RESOURCE);
 	bio_endio(bio);
 	return false;
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index 14ae73eebe0d..4f7b7cf50d23 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -640,7 +640,7 @@ static void __submit_bio(struct bio *bio)
 	
 		if ((bio->bi_opf & REQ_POLLED) &&
 		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
-			bio->bi_status = BLK_STS_NOTSUPP;
+			bio_set_status(bio, BLK_STS_NOTSUPP);
 			bio_endio(bio);
 		} else {
 			disk->fops->submit_bio(bio);
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 86b27f96051a..0e135ba26346 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -281,7 +281,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	/* Allocate bounce bio for encryption */
 	enc_bio = blk_crypto_fallback_clone_bio(src_bio);
 	if (!enc_bio) {
-		src_bio->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(src_bio, BLK_STS_RESOURCE);
 		return false;
 	}
 
@@ -298,7 +298,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 
 	/* and then allocate an skcipher_request for it */
 	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
-		src_bio->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(src_bio, BLK_STS_RESOURCE);
 		goto out_release_keyslot;
 	}
 
@@ -319,7 +319,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 		enc_bvec->bv_page = ciphertext_page;
 
 		if (!ciphertext_page) {
-			src_bio->bi_status = BLK_STS_RESOURCE;
+			bio_set_status(src_bio, BLK_STS_RESOURCE);
 			goto out_free_bounce_pages;
 		}
 
@@ -334,7 +334,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 			if (crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
 					    &wait)) {
 				i++;
-				src_bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(src_bio, BLK_STS_IOERR);
 				goto out_free_bounce_pages;
 			}
 			bio_crypt_dun_increment(curr_dun, 1);
@@ -401,7 +401,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 
 	/* and then allocate an skcipher_request for it */
 	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
-		bio->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(bio, BLK_STS_RESOURCE);
 		goto out;
 	}
 
@@ -421,7 +421,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 			blk_crypto_dun_to_iv(curr_dun, &iv);
 			if (crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
 					    &wait)) {
-				bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(bio, BLK_STS_IOERR);
 				goto out;
 			}
 			bio_crypt_dun_increment(curr_dun, 1);
@@ -492,13 +492,13 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 
 	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
 		/* User didn't call blk_crypto_start_using_key() first */
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 		return false;
 	}
 
 	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
 					&bc->bc_key->crypto_cfg)) {
-		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_set_status(bio, BLK_STS_NOTSUPP);
 		return false;
 	}
 
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..fc606352a31a 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -235,7 +235,7 @@ blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 static inline bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 {
 	pr_warn_once("crypto API fallback disabled; failing request.\n");
-	(*bio_ptr)->bi_status = BLK_STS_NOTSUPP;
+	bio_set_status((*bio_ptr), BLK_STS_NOTSUPP);
 	return false;
 }
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 3e7bf1974cbd..cbba31cd4e58 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -287,12 +287,12 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 
 	/* Error if bio has no data. */
 	if (WARN_ON_ONCE(!bio_has_data(bio))) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 		goto fail;
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_INVAL;
+		bio_set_status(bio, BLK_STS_INVAL);
 		goto fail;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc837aa51daa..4e13d9f9ea96 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -979,7 +979,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 			 * as the BIO fragments may end up not being written
 			 * sequentially.
 			 */
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 		}
 
 		/* Completion has already been traced */
@@ -3164,7 +3164,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
-		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_set_status(bio, BLK_STS_NOTSUPP);
 		bio_endio(bio);
 		goto queue_exit;
 	}
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index a9affb7c264d..a5eb4912fb3e 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1112,7 +1112,7 @@ ktiocomplete(struct frame *f)
 			ahout->cmdstat, ahin->cmdstat,
 			d->aoemajor, d->aoeminor);
 noskb:		if (buf)
-			buf->bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(buf->bio, BLK_STS_IOERR);
 		goto out;
 	}
 
@@ -1125,7 +1125,7 @@ noskb:		if (buf)
 				"aoe: runt data size in read from",
 				(long) d->aoemajor, d->aoeminor,
 			       skb->len, n);
-			buf->bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(buf->bio, BLK_STS_IOERR);
 			break;
 		}
 		if (n > f->iter.bi_size) {
@@ -1133,7 +1133,7 @@ noskb:		if (buf)
 				"aoe: too-large data size in read from",
 				(long) d->aoemajor, d->aoeminor,
 				n, f->iter.bi_size);
-			buf->bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(buf->bio, BLK_STS_IOERR);
 			break;
 		}
 		bvcpy(skb, f->buf->bio, f->iter, n);
@@ -1637,7 +1637,7 @@ aoe_failbuf(struct aoedev *d, struct buf *buf)
 	if (buf == NULL)
 		return;
 	buf->iter.bi_size = 0;
-	buf->bio->bi_status = BLK_STS_IOERR;
+	bio_set_status(buf->bio, BLK_STS_IOERR);
 	if (buf->nframesout == 0)
 		aoe_end_buf(d, buf);
 }
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3a240755045b..11320258d0ce 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -170,7 +170,7 @@ aoe_failip(struct aoedev *d)
 
 	req = blk_mq_rq_to_pdu(rq);
 	while ((bio = d->ip.nxbio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 		d->ip.nxbio = bio->bi_next;
 		req->nr_bios--;
 	}
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index bd4bc882cc5a..95a58ad6fdcf 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1142,7 +1142,7 @@ static void drbd_process_discard_or_zeroes_req(struct drbd_request *req, int fla
 	int err = drbd_issue_discard_or_zero_out(req->device,
 				req->i.sector, req->i.size >> 9, flags);
 	if (err)
-		req->private_bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(req->private_bio, BLK_STS_IOERR);
 	bio_endio(req->private_bio);
 }
 
@@ -1210,7 +1210,7 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 		/* only pass the error to the upper layers.
 		 * if user cannot handle io errors, that's not our business. */
 		drbd_err(device, "could not kmalloc() req\n");
-		bio->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(bio, BLK_STS_RESOURCE);
 		bio_endio(bio);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..975757f01bb8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2341,7 +2341,7 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 
 		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_reads);
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 			break;
 		}
 		flush_dcache_page(bv.bv_page);
@@ -2372,7 +2372,7 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 
 		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_writes);
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 			break;
 		}
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index acccecd061ea..3ea67a8e252a 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1120,7 +1120,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	 */
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
-		bio->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(bio, BLK_STS_RESOURCE);
 		bio->bi_end_io(bio);
 		return;
 	}
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index a10d75a562db..82d748eeb9aa 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1192,7 +1192,8 @@ static void mg_complete(struct dm_cache_migration *mg, bool success)
 			else if (mg->k.input)
 				mg->overwrite_bio->bi_status = mg->k.input;
 			else
-				mg->overwrite_bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(mg->overwrite_bio,
+					       BLK_STS_IOERR);
 			bio_endio(mg->overwrite_bio);
 		} else {
 			if (success)
@@ -1854,7 +1855,7 @@ static void requeue_deferred_bios(struct cache *cache)
 	bio_list_merge_init(&bios, &cache->deferred_bios);
 
 	while ((bio = bio_list_pop(&bios))) {
-		bio->bi_status = BLK_STS_DM_REQUEUE;
+		bio_set_status(bio, BLK_STS_DM_REQUEUE);
 		bio_endio(bio);
 		cond_resched();
 	}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 26e500730b3c..d2288b9f2b0d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2513,7 +2513,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	sector_t recalc_sector;
 
 	if (unlikely(bio_integrity(bio))) {
-		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_set_status(bio, BLK_STS_NOTSUPP);
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -2535,7 +2535,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 			if (dio->payload_len > x_size) {
 				unsigned sectors = ((x_size - extra_size) / ic->tuple_size) << ic->sb->log2_sectors_per_block;
 				if (WARN_ON(!sectors || sectors >= bio_sectors(bio))) {
-					bio->bi_status = BLK_STS_NOTSUPP;
+					bio_set_status(bio, BLK_STS_NOTSUPP);
 					bio_endio(bio);
 					return DM_MAPIO_SUBMITTED;
 				}
@@ -2616,7 +2616,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	ret = bio_integrity_add_page(bio, virt_to_page(dio->integrity_payload),
 					dio->payload_len, offset_in_page(dio->integrity_payload));
 	if (unlikely(ret != dio->payload_len)) {
-		bio->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(bio, BLK_STS_RESOURCE);
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -2670,7 +2670,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		r = bio_integrity_add_page(outgoing_bio, virt_to_page(dio->integrity_payload), ic->tuple_size, 0);
 		if (unlikely(r != ic->tuple_size)) {
 			bio_put(outgoing_bio);
-			bio->bi_status = BLK_STS_RESOURCE;
+			bio_set_status(bio, BLK_STS_RESOURCE);
 			bio_endio(bio);
 			return;
 		}
@@ -2694,7 +2694,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 			dm_audit_log_bio(DM_MSG_PREFIX, "integrity-checksum",
 				bio, dio->bio_details.bi_iter.bi_sector, 0);
 
-			bio->bi_status = BLK_STS_PROTECTION;
+			bio_set_status(bio, BLK_STS_PROTECTION);
 			bio_endio(bio);
 			return;
 		}
@@ -2784,7 +2784,7 @@ static void integrity_bio_wait(struct work_struct *w)
 		int r = dm_integrity_map_inline(dio, false);
 		switch (r) {
 			case DM_MAPIO_KILL:
-				bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(bio, BLK_STS_IOERR);
 				fallthrough;
 			case DM_MAPIO_REMAPPED:
 				submit_bio_noacct(bio);
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 1424ef75d088..761e5e79d4a7 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -722,7 +722,7 @@ static void process_queued_bios(struct work_struct *work)
 			bio_io_error(bio);
 			break;
 		case DM_MAPIO_REQUEUE:
-			bio->bi_status = BLK_STS_DM_REQUEUE;
+			bio_set_status(bio, BLK_STS_DM_REQUEUE);
 			bio_endio(bio);
 			break;
 		case DM_MAPIO_REMAPPED:
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 268f734ca9c3..c54995847db0 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -491,9 +491,9 @@ static void hold_bio(struct mirror_set *ms, struct bio *bio)
 		 * If device is suspended, complete the bio.
 		 */
 		if (dm_noflush_suspending(ms->ti))
-			bio->bi_status = BLK_STS_DM_REQUEUE;
+			bio_set_status(bio, BLK_STS_DM_REQUEUE);
 		else
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 
 		bio_endio(bio);
 		return;
@@ -627,7 +627,7 @@ static void write_callback(unsigned long error, void *context)
 	 * degrade the array.
 	 */
 	if (bio_op(bio) == REQ_OP_DISCARD) {
-		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_set_status(bio, BLK_STS_NOTSUPP);
 		bio_endio(bio);
 		return;
 	}
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index ad6b8b3c12dd..bd061a6bf016 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2731,7 +2731,7 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 	thin_hook_bio(tc, bio);
 
 	if (tc->requeue_mode) {
-		bio->bi_status = BLK_STS_DM_REQUEUE;
+		bio_set_status(bio, BLK_STS_DM_REQUEUE);
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
 	}
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4f70e2673e4b..f615ff46cc41 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1265,7 +1265,7 @@ static void bio_copy_block(struct dm_writecache *wc, struct bio *bio, void *data
 			flush_dcache_page(bio_page(bio));
 			if (unlikely(r)) {
 				writecache_error(wc, r, "hardware memory error when reading data: %d", r);
-				bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(bio, BLK_STS_IOERR);
 			}
 		} else {
 			flush_dcache_page(bio_page(bio));
@@ -1312,7 +1312,7 @@ static int writecache_flush_thread(void *data)
 			writecache_flush(wc);
 			wc_unlock(wc);
 			if (writecache_has_error(wc))
-				bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(bio, BLK_STS_IOERR);
 			bio_endio(bio);
 		}
 	}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f6f1aab18a8b..5afc6d63aa7b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -447,7 +447,7 @@ static void md_submit_bio(struct bio *bio)
 
 	if (mddev->ro == MD_RDONLY && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 		bio_endio(bio);
 		return;
 	}
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 521625756128..504730aba9df 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -104,7 +104,7 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		int len = min_t(int, size, PAGE_SIZE);
 
 		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-			bio->bi_status = BLK_STS_RESOURCE;
+			bio_set_status(bio, BLK_STS_RESOURCE);
 			bio_endio(bio);
 			return;
 		}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 592a40233004..923b6a762858 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -301,7 +301,7 @@ static void call_bio_endio(struct r1bio *r1_bio)
 	struct bio *bio = r1_bio->master_bio;
 
 	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 
 	bio_endio(bio);
 }
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9ac26d1f0764..62d5bc9f7b3e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -324,7 +324,7 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
 
 	if (!test_and_set_bit(R10BIO_Returned, &r10_bio->state)) {
 		if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 		bio_endio(bio);
 	}
 
@@ -3600,7 +3600,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				r10_bio->devs[i].repl_bio->bi_end_io = NULL;
 
 			bio = r10_bio->devs[i].bio;
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 			rdev = conf->mirrors[d].rdev;
 			if (rdev == NULL || test_bit(Faulty, &rdev->flags))
 				continue;
@@ -3637,7 +3637,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 
 			/* Need to set up for writing to the replacement */
 			bio = r10_bio->devs[i].repl_bio;
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 
 			sector = r10_bio->devs[i].addr;
 			bio->bi_next = biolist;
@@ -3683,7 +3683,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			struct resync_pages *rp = get_resync_pages(bio);
 			page = resync_fetch_page(rp, page_idx);
 			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-				bio->bi_status = BLK_STS_RESOURCE;
+				bio_set_status(bio, BLK_STS_RESOURCE);
 				bio_endio(bio);
 				goto giveup;
 			}
@@ -4865,7 +4865,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			len = PAGE_SIZE;
 		for (bio = blist; bio ; bio = bio->bi_next) {
 			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-				bio->bi_status = BLK_STS_RESOURCE;
+				bio_set_status(bio, BLK_STS_RESOURCE);
 				bio_endio(bio);
 				return sectors_done;
 			}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 24b32a0c95b4..fa84fadac2fd 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5974,7 +5974,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	sh = raid5_get_active_stripe(conf, ctx, new_sector, flags);
 	if (unlikely(!sh)) {
 		/* cannot get stripe, just give-up */
-		bi->bi_status = BLK_STS_IOERR;
+		bio_set_status(bi, BLK_STS_IOERR);
 		return STRIPE_FAIL;
 	}
 
@@ -6037,7 +6037,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	raid5_release_stripe(sh);
 out:
 	if (ret == STRIPE_SCHEDULE_AND_RETRY && reshape_interrupted(mddev)) {
-		bi->bi_status = BLK_STS_RESOURCE;
+		bio_set_status(bi, BLK_STS_RESOURCE);
 		ret = STRIPE_WAIT_RESHAPE;
 		pr_err_ratelimited("dm-raid456: io across reshape position while reshape can't make progress");
 	}
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 14a8b7622b0d..a624bc9aa699 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1456,7 +1456,7 @@ static void btt_submit_bio(struct bio *bio)
 				len % btt->sector_size) {
 			dev_err_ratelimited(&btt->nd_btt->dev,
 				"unaligned bio segment (len: %d)\n", len);
-			bio->bi_status = BLK_STS_IOERR;
+			bio_set_status(bio, BLK_STS_IOERR);
 			break;
 		}
 
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a0f55591fb90..00a7a13fab0c 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -382,7 +382,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	 * threshold.
 	 */
 	if (atomic_read(&bioc->error) > bioc->max_errors)
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 	else
 		bio->bi_status = BLK_STS_OK;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 775aa4f63aa3..3b031d0391d3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -188,7 +188,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 
 			if (!f2fs_is_compressed_page(folio) &&
 			    !fsverity_verify_page(&folio->page)) {
-				bio->bi_status = BLK_STS_IOERR;
+				bio_set_status(bio, BLK_STS_IOERR);
 				break;
 			}
 		}
@@ -286,7 +286,7 @@ static void f2fs_read_end_io(struct bio *bio)
 	ctx = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_READ_IO))
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 
 	if (bio->bi_status != BLK_STS_OK) {
 		f2fs_finish_read_bio(bio, intask);
@@ -323,7 +323,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	sbi = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
-		bio->bi_status = BLK_STS_IOERR;
+		bio_set_status(bio, BLK_STS_IOERR);
 
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 86067c8b40cf..17a168744037 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -432,7 +432,7 @@ void fsverity_verify_bio(struct bio *bio)
 
 ioerr:
 	fsverity_clear_pending_blocks(&ctx);
-	bio->bi_status = BLK_STS_IOERR;
+	bio_set_status(bio, BLK_STS_IOERR);
 }
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index bf4df0b15ee1..ad70a88cef09 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -384,14 +384,14 @@ static inline void bio_set_status(struct bio *bio, blk_status_t status)
 
 static inline void bio_io_error(struct bio *bio)
 {
-	bio->bi_status = BLK_STS_IOERR;
+	bio_set_status(bio, BLK_STS_IOERR);
 	bio_endio(bio);
 }
 
 static inline void bio_wouldblock_error(struct bio *bio)
 {
 	bio_set_flag(bio, BIO_QUIET);
-	bio->bi_status = BLK_STS_AGAIN;
+	bio_set_status(bio, BLK_STS_AGAIN);
 	bio_endio(bio);
 }
 
-- 
2.51.0


