Return-Path: <linux-btrfs+bounces-19930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E3CD3A4C
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAFAB305D98B
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E839212548;
	Sun, 21 Dec 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2fGfdZk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA08221265
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285583; cv=none; b=BQkN/m3RT0YZiWaJ4a5vIFMn1PPXn/o+3CVkwijac0dKjaKU/UZ1wxBy6qalg0JnALNsMKyaaQmZsX5vf36xauhfXk7m81KDBJhaR57KXmExMo37gLfUVQnVkS7MJGplGpHEYxmYcCYnwmJlIGlPz70wFdQbayNWzs+/jI/P5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285583; c=relaxed/simple;
	bh=wa/cLGBGStMHa4wiaPJkp2x8IVdNQku/BtZQXKI/1k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKSx36XKSD3h225Nby06uESu4fbo8+QGTO6uDWBG9BFcEBLEHmmK71sfk5JSuM9D/w/ay2JF5vRgzR0DRcc2RfaJprIaQdisQ9WpCUzL57I7ljn8lok3yK7pg0dfx6rxACwyjcm968kjGXrGzsKBAdSVU3PSkmodPp7kWReVs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2fGfdZk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHW4SPD9tBLodJmH7Rf3AmmAfw6AhO5IJSG7uhaTc7A=;
	b=h2fGfdZktZ/7JuoK6XzXsXaDwTggbsgyzcKWn2T37rohpC//t3SvKxMY+iJjFYXjVwKHIb
	7hgJ1tdfJ7iqUxJi2rnnsKQmul3X61YPw3Ipwo9kA8sEIcK6d1WAgznTrB1WENzOauTnRd
	YsC4iP0I9BDgj6ubyD7mjpwFFI6/izk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-i3vt7UEBN_-QSuoCQY2xvA-1; Sat,
 20 Dec 2025 21:52:56 -0500
X-MC-Unique: i3vt7UEBN_-QSuoCQY2xvA-1
X-Mimecast-MFC-AGG-ID: i3vt7UEBN_-QSuoCQY2xvA_1766285574
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5474719560A5;
	Sun, 21 Dec 2025 02:52:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F42A180035F;
	Sun, 21 Dec 2025 02:52:51 +0000 (UTC)
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
Subject: [RFC v2 04/17] bio: add bio_set_status
Date: Sun, 21 Dec 2025 03:52:19 +0100
Message-ID: <20251221025233.87087-5-agruenba@redhat.com>
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

Add a bio_set_status(bio, status) helper that sets bio->bi_status to
status if status != BLK_STS_OK.  Replace instances of this pattern in
the code with a call to the new helper.

The WRITE_ONCE() in bio_set_status() ensures that the compiler won't
reorder things in a weird way, but tearing is not an issue because
bi_status is a single-byte field.

Created with Coccinelle using the following semantic patch and option
'--disable-iso unlikely'.

(Coccinelle occasionally likes to add unnecessary curly braces
in if statements; those were removed by hand.)

@@
expression status;
struct bio *bio;
@@
- if (status)
-       bio->bi_status = status;
+ bio_set_status(bio, status);

@@
expression status;
struct bio *bio;
@@
- if (unlikely(status))
-       bio->bi_status = status;
+ if (unlikely(status))
+	bio_set_status(bio, status);

@@
expression status;
struct bio *bio;
@@
if (status) {
<...
-       bio->bi_status = status;
+       bio_set_status(bio, status);
...>
}

@@
expression status;
struct bio *bio;
@@
if (status != BLK_STS_OK) {
<...
-       bio->bi_status = status;
+       bio_set_status(bio, status);
...>
}

@@
expression status;
struct bio *bio;
statement S;
@@
if (status)
-       bio->bi_status = status;
+       bio_set_status(bio, status);
else
	S

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-crypto-fallback.c  |  4 ++--
 block/blk-mq.c               |  4 ++--
 block/t10-pi.c               |  2 +-
 drivers/md/dm-cache-target.c |  3 ++-
 drivers/md/dm.c              |  3 +--
 drivers/nvdimm/pmem.c        |  2 +-
 include/linux/bio.h          | 16 ++++++++++++++++
 7 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 86b27f96051a..a9cb5647879c 100644
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
index d626d32f6e57..9d1883d653c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -970,7 +970,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
 		if (unlikely(error))
-			bio->bi_status = error;
+			bio_set_status(bio, error);
 
 		if (bio_bytes == bio->bi_iter.bi_size) {
 			req->bio = bio->bi_next;
@@ -3206,7 +3206,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
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
index a10d75a562db..03816f0dcb58 100644
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
 				mg->overwrite_bio->bi_status = BLK_STS_IOERR;
 			bio_endio(mg->overwrite_bio);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6c83ab940af7..cbc64377fa96 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -983,8 +983,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 		queue_io(md, bio);
 	} else {
 		/* done with normal IO or empty flush */
-		if (io_error)
-			bio->bi_status = io_error;
+		bio_set_status(bio, io_error);
 		bio_endio(bio);
 	}
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 05785ff21a8b..4fdcbe56a3bc 100644
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
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 16c1c85613b7..a1324ce61ebd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -376,6 +376,22 @@ void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
 
+/**
+ * bio_set_status - set the status of bio
+ * @bio: bio
+ * @status: a BLK_STS_* status code
+ *
+ * Set the status of @bio to @status unless @status is BLK_STS_OK (0).  In bio
+ * chains, this function may be called repeatedly on the same bio.  In that
+ * case, it can override a previous error, but it will never revert from an
+ * error back to BLK_STS_OK.
+ */
+static inline void bio_set_status(struct bio *bio, blk_status_t status)
+{
+	if (status != BLK_STS_OK)
+		WRITE_ONCE(bio->bi_status, status);
+}
+
 static inline void bio_io_error(struct bio *bio)
 {
 	bio->bi_status = BLK_STS_IOERR;
-- 
2.52.0


