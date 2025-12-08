Return-Path: <linux-btrfs+bounces-19572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3ACAD172
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A3930E24EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC56D3148DD;
	Mon,  8 Dec 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah831G2W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D1313E0A
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195873; cv=none; b=LUNbnfju75xwlfBt5NEHwwJgqp8EHRbs+ksAqWd80IV3zqHLsl/CkFLd30yMgF3OSR0VMD1AaKfIdxupMLkrY9vaRDQmNLOvHLIv/xsghQb69g7vNnLubbH4r2g9Tkhk69Md//UScvohyII3yX14C5jVJbuBxKLEogjGSehsLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195873; c=relaxed/simple;
	bh=GktH5BhrqlijaASwtvaLDFNN70Mk65V1f3iWJUGdRYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZztYBRe6yIOqO9uQ3ab640opwDO5CbEXNutbrrxpzsBuDYY7Ydu75hrsamKxtsoA632sjDYu1v/Y73r/uL9tXj1qefyDGAQGKDa3+KSvP6M0n3mNqPrLfIPEyLzFYYSrFvyoJrqIZ78EViYcZAxl6JTeDIN17kayQCisLfqaM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ah831G2W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Gcq94rGzUJI4YaB9u7yri6cXo1is4655WtuewIwIxc=;
	b=ah831G2W1KVX0QOI5rWNzr0qi+7axjngqtbPAPNB5g/emZNOohHKgzJcfDOpa7u5D8ss7x
	9uaydmAGMM+7RUZz58Pbdgm+fTVXBbOOYLGdcnR099TFJmD2uo8ICyJZRCvPTB9B3iFtxD
	Dyt7BwTWs8kn3MlSLmFGFqxYGAH3ASg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-vtkiox6yPw2ZhUT3eM8_IA-1; Mon,
 08 Dec 2025 07:11:07 -0500
X-MC-Unique: vtkiox6yPw2ZhUT3eM8_IA-1
X-Mimecast-MFC-AGG-ID: vtkiox6yPw2ZhUT3eM8_IA_1765195865
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2AC6180060D;
	Mon,  8 Dec 2025 12:11:05 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70DBB1956095;
	Mon,  8 Dec 2025 12:11:02 +0000 (UTC)
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
Subject: [RFC 10/12] bio: never set bi_status to BLK_STS_OK during completion
Date: Mon,  8 Dec 2025 12:10:17 +0000
Message-ID: <20251208121020.1780402-11-agruenba@redhat.com>
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

In a few places in the code, we don't know if a bio has failed or
completed successfully, so use bio_set_status() instead of setting
bi_status directly.  That way, bi_status will never be set to
BI_STS_OK (0) during completion.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-crypto-fallback.c   | 2 +-
 drivers/block/ps3vram.c       | 2 +-
 drivers/md/dm-flakey.c        | 2 +-
 drivers/md/dm-verity-target.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 8a2631b1e7e1..7014f646e236 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -150,7 +150,7 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 		mempool_free(enc_bio->bi_io_vec[i].bv_page,
 			     blk_crypto_bounce_page_pool);
 
-	src_bio->bi_status = enc_bio->bi_status;
+	bio_set_status(src_bio, enc_bio->bi_status);
 
 	bio_uninit(enc_bio);
 	kfree(enc_bio);
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index bdcf083b45e2..06844674c998 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -573,7 +573,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 	next = bio_list_peek(&priv->list);
 	spin_unlock_irq(&priv->lock);
 
-	bio->bi_status = error;
+	bio_set_status(bio, error);
 	bio_endio(bio);
 	return next;
 }
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 08925aca838c..8dde47beb387 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -420,7 +420,7 @@ static void clone_free(struct bio *clone)
 static void clone_endio(struct bio *clone)
 {
 	struct bio *bio = clone->bi_private;
-	bio->bi_status = clone->bi_status;
+	bio_set_status(bio, clone->bi_status);
 	clone_free(clone);
 	bio_endio(bio);
 }
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 66a00a8ccb39..4793bcf546ad 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -544,7 +544,7 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	bio->bi_end_io = io->orig_bi_end_io;
-	bio->bi_status = status;
+	bio_set_status(bio, status);
 
 	if (!static_branch_unlikely(&use_bh_wq_enabled) || !io->in_bh)
 		verity_fec_finish_io(io);
-- 
2.51.0


