Return-Path: <linux-btrfs+bounces-19941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A7CD3ACE
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9678B302E051
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518C279DB3;
	Sun, 21 Dec 2025 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXh7/YKT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB825C6F9
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285630; cv=none; b=ljksacTykIFABcpY9ed+Tbwe6hbMQxye0QEV6hyX9AIvIgXgSEZx3D9D8f/p829fNlRFGvW54gv+Jl6Sg+Jjt4LsQVnNUuogvBTrLyC3yAY3X/dYvq+3DytuGyMp8QC+Ps8HNrau2SJtiN5qsfAoYUY2c9wUyCpmaxMOrmLRkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285630; c=relaxed/simple;
	bh=tkUKQd/oOejzy1+4KfPeSYtNVDYc9mFOs+DgnnOeR+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDBOLDDlWzZaOjBlNO6cLnWM5dNt2v9j1E7NfdDuWXoSuUyi0aFknlV1Tw0EI4CqmZnDF4Ox/Z2YIAWc+5tgp5+1cDDsZ2MtqZ7WF/ch6/9aUrLzMB7wnLQVta+iC/16hbpUZWtSt1rVfJc4SYMhWlW//GH3qOXqjKJHFu/3FnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXh7/YKT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FggBl310SeU2z5ihOYBZTljJM6cUTkQcdyJAp+ym5x0=;
	b=BXh7/YKTxNc4YzlFC7tlY7fybeymhIZ5dx9HTaw4EJ+0yjWrSrve75VQahRMEwtYXeHEfm
	b/gGV3Cwi+dZSvFp89piFwOPeleXQOnXX2CKJ5YyQcKGyc4JDe9AANbN8u9yRzZv1fsWd+
	sarRjJmogtY4nSGrol++cw80o/YonyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-_V4fehw6PWaygTl_DPmMEQ-1; Sat,
 20 Dec 2025 21:53:41 -0500
X-MC-Unique: _V4fehw6PWaygTl_DPmMEQ-1
X-Mimecast-MFC-AGG-ID: _V4fehw6PWaygTl_DPmMEQ_1766285619
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB9051800637;
	Sun, 21 Dec 2025 02:53:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C08BA180049F;
	Sun, 21 Dec 2025 02:53:36 +0000 (UTC)
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
Subject: [RFC v2 17/17] bio: add bio_endio_status
Date: Sun, 21 Dec 2025 03:52:32 +0100
Message-ID: <20251221025233.87087-18-agruenba@redhat.com>
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
 block/bio-integrity-auto.c       |  3 +--
 block/blk-core.c                 |  6 ++----
 block/blk-merge.c                |  6 ++----
 block/blk-mq.c                   |  6 ++----
 drivers/block/drbd/drbd_req.c    |  3 +--
 drivers/block/ps3vram.c          |  3 +--
 drivers/md/dm-cache-target.c     |  3 +--
 drivers/md/dm-integrity.c        | 25 +++++++++----------------
 drivers/md/dm-mpath.c            |  3 +--
 drivers/md/dm-pcache/dm_pcache.c |  3 +--
 drivers/md/dm-raid1.c            |  3 +--
 drivers/md/dm-thin.c             |  6 ++----
 drivers/md/dm-vdo/data-vio.c     |  3 +--
 drivers/md/dm.c                  |  3 +--
 drivers/md/raid1-10.c            |  3 +--
 drivers/md/raid10.c              | 16 ++++++----------
 fs/btrfs/raid56.c                |  6 ++----
 fs/iomap/ioend.c                 |  3 +--
 fs/xfs/xfs_aops.c                |  3 +--
 fs/xfs/xfs_zone_alloc.c          |  3 +--
 include/linux/bio.h              | 12 ++++++++----
 21 files changed, 46 insertions(+), 76 deletions(-)

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
index acf0a82a90ce..119ac3156eeb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -645,8 +645,7 @@ static void __submit_bio(struct bio *bio)
 	
 		if ((bio->bi_opf & REQ_POLLED) &&
 		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
-			bio_set_status(bio, BLK_STS_NOTSUPP);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_NOTSUPP);
 		} else {
 			disk->fops->submit_bio(bio);
 		}
@@ -887,8 +886,7 @@ void submit_bio_noacct(struct bio *bio)
 not_supported:
 	status = BLK_STS_NOTSUPP;
 end_io:
-	bio_set_status(bio, status);
-	bio_endio(bio);
+	bio_endio_status(bio, status);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 27ea5ffb8f77..5ab948ed4c1a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -122,8 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
 
 	if (IS_ERR(split)) {
-		bio_set_status(bio, errno_to_blk_status(PTR_ERR(split)));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(split)));
 		return NULL;
 	}
 
@@ -143,8 +142,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
 	if (unlikely(split_sectors < 0)) {
-		bio_set_status(bio, errno_to_blk_status(split_sectors));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(split_sectors));
 		return NULL;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8fb35a258b4c..3ad79017ceeb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3165,8 +3165,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
-		bio_set_status(bio, BLK_STS_NOTSUPP);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
 
@@ -3206,8 +3205,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio_set_status(bio, ret);
-		bio_endio(bio);
+		bio_endio_status(bio, ret);
 		blk_mq_free_request(rq);
 		return;
 	}
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 983b2ff5eb6b..3d3476707638 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1211,8 +1211,7 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio)
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
index 4a6e27c0d510..c21b0d866627 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2512,8 +2512,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	sector_t recalc_sector;
 
 	if (unlikely(bio_integrity(bio))) {
-		bio_set_status(bio, BLK_STS_NOTSUPP);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		return DM_MAPIO_SUBMITTED;
 	}
 
@@ -2534,8 +2533,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 			if (dio->payload_len > x_size) {
 				unsigned sectors = ((x_size - extra_size) / ic->tuple_size) << ic->sb->log2_sectors_per_block;
 				if (WARN_ON(!sectors || sectors >= bio_sectors(bio))) {
-					bio_set_status(bio, BLK_STS_NOTSUPP);
-					bio_endio(bio);
+					bio_endio_status(bio, BLK_STS_NOTSUPP);
 					return DM_MAPIO_SUBMITTED;
 				}
 				dm_accept_partial_bio(bio, sectors);
@@ -2593,8 +2591,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
-		bio_set_status(bio, errno_to_blk_status(PTR_ERR(bip)));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(bip)));
 		return DM_MAPIO_SUBMITTED;
 	}
 
@@ -2615,8 +2612,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	ret = bio_integrity_add_page(bio, virt_to_page(dio->integrity_payload),
 					dio->payload_len, offset_in_page(dio->integrity_payload));
 	if (unlikely(ret != dio->payload_len)) {
-		bio_set_status(bio, BLK_STS_RESOURCE);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_RESOURCE);
 		return DM_MAPIO_SUBMITTED;
 	}
 
@@ -2661,16 +2657,15 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
 		if (IS_ERR(bip)) {
 			bio_put(outgoing_bio);
-			bio_set_status(bio, errno_to_blk_status(PTR_ERR(bip)));
-			bio_endio(bio);
+			bio_endio_status(bio,
+					 errno_to_blk_status(PTR_ERR(bip)));
 			return;
 		}
 
 		r = bio_integrity_add_page(outgoing_bio, virt_to_page(dio->integrity_payload), ic->tuple_size, 0);
 		if (unlikely(r != ic->tuple_size)) {
 			bio_put(outgoing_bio);
-			bio_set_status(bio, BLK_STS_RESOURCE);
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_RESOURCE);
 			return;
 		}
 
@@ -2679,8 +2674,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		r = submit_bio_wait(outgoing_bio);
 		if (unlikely(r != 0)) {
 			bio_put(outgoing_bio);
-			bio_set_status(bio, errno_to_blk_status(r));
-			bio_endio(bio);
+			bio_endio_status(bio, errno_to_blk_status(r));
 			return;
 		}
 		bio_put(outgoing_bio);
@@ -2693,8 +2687,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
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
diff --git a/drivers/md/dm-pcache/dm_pcache.c b/drivers/md/dm-pcache/dm_pcache.c
index 086ae9b06bfb..925a25aa8699 100644
--- a/drivers/md/dm-pcache/dm_pcache.c
+++ b/drivers/md/dm-pcache/dm_pcache.c
@@ -74,8 +74,7 @@ static void end_req(struct kref *ref)
 		pcache_req_get(pcache_req);
 		defer_req(pcache_req);
 	} else {
-		bio_set_status(bio, errno_to_blk_status(ret));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(ret));
 
 		if (atomic_dec_and_test(&pcache->inflight_reqs))
 			wake_up(&pcache->inflight_wq);
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
index 42261bbe4771..7fe004a330c0 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -422,8 +422,7 @@ static void end_discard(struct discard_op *op, int r)
 	 * Even if r is set, there could be sub discards in flight that we
 	 * need to wait for.
 	 */
-	bio_set_status(op->parent_bio, errno_to_blk_status(r));
-	bio_endio(op->parent_bio);
+	bio_endio_status(op->parent_bio, errno_to_blk_status(r));
 }
 
 /*----------------------------------------------------------------*/
@@ -2730,8 +2729,7 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 	thin_hook_bio(tc, bio);
 
 	if (tc->requeue_mode) {
-		bio_set_status(bio, BLK_STS_DM_REQUEUE);
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_DM_REQUEUE);
 		return DM_MAPIO_SUBMITTED;
 	}
 
diff --git a/drivers/md/dm-vdo/data-vio.c b/drivers/md/dm-vdo/data-vio.c
index 11becc4138c4..298957fa938a 100644
--- a/drivers/md/dm-vdo/data-vio.c
+++ b/drivers/md/dm-vdo/data-vio.c
@@ -287,8 +287,7 @@ static void acknowledge_data_vio(struct data_vio *data_vio)
 	if (data_vio->is_partial)
 		vdo_count_bios(&vdo->stats.bios_acknowledged_partial, bio);
 
-	bio_set_status(bio, errno_to_blk_status(error));
-	bio_endio(bio);
+	bio_endio_status(bio, errno_to_blk_status(error));
 }
 
 static void copy_to_bio(struct bio *bio, char *data_ptr)
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
index 3e15e190f103..5bbef4954fd5 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1665,9 +1665,8 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = stripe_size - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio_set_status(bio,
-				       errno_to_blk_status(PTR_ERR(split)));
-			bio_endio(bio);
+			bio_endio_status(bio,
+					 errno_to_blk_status(PTR_ERR(split)));
 			return 0;
 		}
 
@@ -1683,9 +1682,8 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		split_size = bio_sectors(bio) - remainder;
 		split = bio_split(bio, split_size, GFP_NOIO, &conf->bio_split);
 		if (IS_ERR(split)) {
-			bio_set_status(bio,
-				       errno_to_blk_status(PTR_ERR(split)));
-			bio_endio(bio);
+			bio_endio_status(bio,
+					 errno_to_blk_status(PTR_ERR(split)));
 			return 0;
 		}
 
@@ -3685,8 +3683,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			struct resync_pages *rp = get_resync_pages(bio);
 			page = resync_fetch_page(rp, page_idx);
 			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-				bio_set_status(bio, BLK_STS_RESOURCE);
-				bio_endio(bio);
+				bio_endio_status(bio, BLK_STS_RESOURCE);
 				goto giveup;
 			}
 		}
@@ -4867,8 +4864,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			len = PAGE_SIZE;
 		for (bio = blist; bio ; bio = bio->bi_next) {
 			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
-				bio_set_status(bio, BLK_STS_RESOURCE);
-				bio_endio(bio);
+				bio_endio_status(bio, BLK_STS_RESOURCE);
 				return sectors_done;
 			}
 		}
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b60ab0bb08ad..5bd9dd132314 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1750,8 +1750,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio_set_status(bio, errno_to_blk_status(PTR_ERR(rbio)));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(rbio)));
 		return;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
@@ -2148,8 +2147,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		bio_set_status(bio, errno_to_blk_status(PTR_ERR(rbio)));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(rbio)));
 		return;
 	}
 
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 1ebe6730d013..10963b7c0837 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -87,8 +87,7 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 		error = -EIO;
 
 	if (error) {
-		bio_set_status(&ioend->io_bio, errno_to_blk_status(error));
-		bio_endio(&ioend->io_bio);
+		bio_endio_status(&ioend->io_bio, errno_to_blk_status(error));
 		return error;
 	}
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index bd2b828164cb..c56560715ba4 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -653,8 +653,7 @@ xfs_zoned_writeback_submit(
 
 	ioend->io_bio.bi_end_io = xfs_end_bio;
 	if (error) {
-		bio_set_status(&ioend->io_bio, errno_to_blk_status(error));
-		bio_endio(&ioend->io_bio);
+		bio_endio_status(&ioend->io_bio, errno_to_blk_status(error));
 		return error;
 	}
 	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 2b069cffac00..e5f91580e6d9 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -896,8 +896,7 @@ xfs_zone_alloc_and_submit(
 	return;
 
 out_split_error:
-	bio_set_status(&ioend->io_bio, errno_to_blk_status(PTR_ERR(split)));
-	bio_endio(&ioend->io_bio);
+	bio_endio_status(&ioend->io_bio, errno_to_blk_status(PTR_ERR(split)));
 	return;
 
 out_error:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index cf0f5aba7bee..94f0c7f58002 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -392,17 +392,21 @@ static inline void bio_set_status(struct bio *bio, blk_status_t status)
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
 
 /*
-- 
2.52.0


