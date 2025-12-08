Return-Path: <linux-btrfs+bounces-19569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F238CAD109
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C7733045856
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD9310636;
	Mon,  8 Dec 2025 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhAImzzW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0D2F12C0
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195863; cv=none; b=QUvuKQ5td3Gu/FwsWYNSRISlm53PaApok81243MvbnJgZmQu5w8R6EZWvT3GIpFo4oPncjq0+hsI+6VkZNDTBMtPJKsGzRwgb+7Ul4zq3rxcyuYN8y2QnWwhWKEu8a6CPqNpkxDgimSvy9b2Dz2UNc6V71FQVwBufGa9B6IZ0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195863; c=relaxed/simple;
	bh=sfhgXzszb3rbFgkWYul9C/4xAy/evRh0yzt6XOLy8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQUrmylSfiKzOY9e8Lq8xEfvhS2uWf5yuYd4xijQ+hYPPJHfGGjbJe2MyHbMUPrKmjJoHqStnw2pNF06aQxh5i+SHwPepFS5IQieuMWpbsfwm+ZNdlbP8jjSz3Rv9X99ucSukqxAhHlThKWn6XA/CIpYkTZkveN6jtHr3sJQrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhAImzzW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xW1lJxzmKLAFtrC3EebAHHT/dFnpbfuFBCBcpMhy1w=;
	b=XhAImzzWGMX1DveT4AVPbpaO6xzkhvleTGZIWwU2SBX+E4+SIQN2/QU6PmYDwsbdEfupaD
	f2VbD2kJUkW2U1+dJLp5uzNBCn7bw26IXBtGWDRSeyqhAPopfdcQfrPkSHPwdRgp268KPU
	q3bWYO2zdU+x2NiMH1+xxW3lIr0I1ro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-APg6rgGfMN-B-RkeX6zkxg-1; Mon,
 08 Dec 2025 07:10:59 -0500
X-MC-Unique: APg6rgGfMN-B-RkeX6zkxg-1
X-Mimecast-MFC-AGG-ID: APg6rgGfMN-B-RkeX6zkxg_1765195858
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5749619560A7;
	Mon,  8 Dec 2025 12:10:58 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44DEE1956095;
	Mon,  8 Dec 2025 12:10:55 +0000 (UTC)
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
Subject: [RFC 08/12] bio: use bio_set_status in some more places
Date: Mon,  8 Dec 2025 12:10:15 +0000
Message-ID: <20251208121020.1780402-9-agruenba@redhat.com>
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

In these places, the status is known not to be BLK_STS_OK (0), so the
'status != BLK_STS_OK' check in bio_set_status() will be optimized out
and we end up with identical code.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-crypto-fallback.c  | 4 ++--
 block/blk-mq.c               | 2 +-
 block/t10-pi.c               | 2 +-
 drivers/md/dm-cache-target.c | 3 ++-
 drivers/md/dm-integrity.c    | 2 +-
 drivers/md/dm-zoned-target.c | 2 +-
 drivers/nvdimm/pmem.c        | 2 +-
 fs/btrfs/bio.c               | 4 ++--
 8 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 0e135ba26346..8a2631b1e7e1 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -292,7 +292,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
-		src_bio->bi_status = blk_st;
+		bio_set_status(src_bio, blk_st);
 		goto out_put_enc_bio;
 	}
 
@@ -395,7 +395,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
-		bio->bi_status = blk_st;
+		bio_set_status(bio, blk_st);
 		goto out_no_keyslot;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e13d9f9ea96..503ca259429f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3205,7 +3205,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio->bi_status = ret;
+		bio_set_status(bio, ret);
 		bio_endio(bio);
 		blk_mq_free_request(rq);
 		return;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c4ed9702146..968cf1fe45f0 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -440,7 +440,7 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
 		kunmap_local(kaddr);
 
 		if (ret) {
-			bio->bi_status = ret;
+			bio_set_status(bio, ret);
 			return;
 		}
 	}
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 82d748eeb9aa..d1dbd4ddaadb 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1190,7 +1190,8 @@ static void mg_complete(struct dm_cache_migration *mg, bool success)
 			if (success)
 				force_set_dirty(cache, cblock);
 			else if (mg->k.input)
-				mg->overwrite_bio->bi_status = mg->k.input;
+				bio_set_status(mg->overwrite_bio,
+					       mg->k.input);
 			else
 				bio_set_status(mg->overwrite_bio,
 					       BLK_STS_IOERR);
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index d2288b9f2b0d..5220e15b6537 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1617,7 +1617,7 @@ static void dec_in_flight(struct dm_integrity_io *dio)
 
 		bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 		if (unlikely(dio->bi_status) && !bio->bi_status)
-			bio->bi_status = dio->bi_status;
+			bio_set_status(bio, dio->bi_status);
 		if (likely(!bio->bi_status) && unlikely(bio_sectors(bio) != dio->range.n_sectors)) {
 			dio->range.logical_sector += dio->range.n_sectors;
 			bio_advance(bio, dio->range.n_sectors << SECTOR_SHIFT);
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 9da329078ea4..d0218a9f1c4f 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -78,7 +78,7 @@ static inline void dmz_bio_endio(struct bio *bio, blk_status_t status)
 		dm_per_bio_data(bio, sizeof(struct dmz_bioctx));
 
 	if (status != BLK_STS_OK && bio->bi_status == BLK_STS_OK)
-		bio->bi_status = status;
+		bio_set_status(bio, status);
 	if (bioctx->dev && bio->bi_status != BLK_STS_OK)
 		bioctx->dev->flags |= DMZ_CHECK_BDEV;
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index a2f8b5a85326..aa2a486522b5 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -222,7 +222,7 @@ static void pmem_submit_bio(struct bio *bio)
 			rc = pmem_do_read(pmem, bvec.bv_page, bvec.bv_offset,
 				iter.bi_sector, bvec.bv_len);
 		if (rc) {
-			bio->bi_status = rc;
+			bio_set_status(bio, rc);
 			break;
 		}
 	}
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 00a7a13fab0c..a63d69509d05 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -174,7 +174,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		mirror = next_repair_mirror(fbio, mirror);
 		if (mirror == fbio->bbio->mirror_num) {
 			btrfs_debug(fs_info, "no mirror left");
-			fbio->bbio->bio.bi_status = BLK_STS_IOERR;
+			bio_set_status(&fbio->bbio->bio, BLK_STS_IOERR);
 			goto done;
 		}
 
@@ -225,7 +225,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
 	if (num_copies == 1) {
 		btrfs_debug(fs_info, "no copy to repair from");
-		failed_bbio->bio.bi_status = BLK_STS_IOERR;
+		bio_set_status(&failed_bbio->bio, BLK_STS_IOERR);
 		return fbio;
 	}
 
-- 
2.51.0


