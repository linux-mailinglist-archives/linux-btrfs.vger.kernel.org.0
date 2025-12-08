Return-Path: <linux-btrfs+bounces-19566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A504FCAD137
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E75630B2325
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02827FB32;
	Mon,  8 Dec 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QofbKRsw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437872E9EA1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195851; cv=none; b=PdxWK8e7Fo/lv3TpBDSub+Z0g/2YiNBnm1XCUX0jkZfjEYeE8K33IB2n3ZBtUHuEEfEPvEEMQNxxA4MJH7LyBge/LCzaAbZZh9n9Ravlyr8xXW7/aGoE5r6L9aUv+F1DF1IdwsIJJaKF6jGCOkbppr1Ns8V0yDPl78EGek1L2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195851; c=relaxed/simple;
	bh=u8WVF7+TSibqALZYK0Rishqre6CUPToFoFVRzvaGMlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR0o4xWbdgKT+TjD1YPl/M1p7OE/SKBQZ6XvEGYMi+uJKLJeI9ddjvQbcRu/1qvYFTmWHKkQt2ZcETxne7Bq5t4oaAUtz2oZpr7oXgHMPayhnmp1NGJ4Pkg1xiqKBDhpmXPCoZHIu8mDLvkHyj4x454wghoUg9qb0+hcbP2F634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QofbKRsw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aK6rSpeP7OmuKpy2WC08z3GtDIuL7UgtM7KA4SREDM=;
	b=QofbKRswTj1L0fAv7huCa8OqEZxIwWBb/coDrxG8ETzrmO0K+1X3kgnfS88wpjwtr3kyhW
	SsE/Jh1M+GQql4QaCglNLPuS3jtS0xQbMQ4m5k4BbJvbjfWwJojNE8gQEtpRoVNhQPff8k
	GbKbqtQ929jIUWufAJ1xLAcm7clPXlk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-agrsE-LaMz-Nq-br0QCQKQ-1; Mon,
 08 Dec 2025 07:10:47 -0500
X-MC-Unique: agrsE-LaMz-Nq-br0QCQKQ-1
X-Mimecast-MFC-AGG-ID: agrsE-LaMz-Nq-br0QCQKQ_1765195846
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6228318002DE;
	Mon,  8 Dec 2025 12:10:46 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30AF71956095;
	Mon,  8 Dec 2025 12:10:42 +0000 (UTC)
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
Subject: [RFC 05/12] bio: add bio_set_status
Date: Mon,  8 Dec 2025 12:10:12 +0000
Message-ID: <20251208121020.1780402-6-agruenba@redhat.com>
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

Add a bio_set_status(bio, status) helper that sets bio->bi_status to
status if status != BLK_STS_OK.  Replace instances of this pattern in
the code with a call to the new helper.

The WRITE_ONCE() in bio_set_status() ensures that the compiler won't
reorder things in a weird way, but it isn't needed to prevent tearing
because a single-byte field like bi_status cannot tear.

Created with Coccinelle using the following semantic patch:

@@
struct bio *bio;
expression status;
@@
- if (status)
-       bio->bi_status = status;
+ bio_set_status(bio, status);

@@
struct bio *bio;
expression status;
@@
- if (unlikely(status))
-       bio->bi_status = status;
+ bio_set_status(bio, status);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-mq.c      | 3 +--
 drivers/md/dm.c     | 3 +--
 include/linux/bio.h | 6 ++++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..bc837aa51daa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -969,8 +969,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		struct bio *bio = req->bio;
 		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
-		if (unlikely(error))
-			bio->bi_status = error;
+		bio_set_status(bio, error);
 
 		if (bio_bytes == bio->bi_iter.bi_size) {
 			req->bio = bio->bi_next;
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
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 38ebf03036cb..bf4df0b15ee1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -376,6 +376,12 @@ void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
 
+static inline void bio_set_status(struct bio *bio, blk_status_t status)
+{
+	if (status)
+		WRITE_ONCE(bio->bi_status, status);
+}
+
 static inline void bio_io_error(struct bio *bio)
 {
 	bio->bi_status = BLK_STS_IOERR;
-- 
2.51.0


