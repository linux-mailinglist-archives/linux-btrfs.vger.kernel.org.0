Return-Path: <linux-btrfs+bounces-19564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1BCAD115
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC59830989FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A03101B2;
	Mon,  8 Dec 2025 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SILJS9Ev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87112F3638
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195846; cv=none; b=aCfdjhQp8SJ6bGqOT7urJOgxwMo03juisTrRu93Tm1LwlbPSIMxH61Nk5OpM1nkYa/9td3LnENLnQFYWO92WAOXgb9PdaShlwljJQvx+AcFPt4t6woJCy+yoxqpyhSe7k6AKYQ0e8tAH26DxhSAxK+h5vX+e+avUM8i2wc8lKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195846; c=relaxed/simple;
	bh=CqnLgM9bxGlrVxyPzoFh+1bkpkx8bpzOqL+eTMygvt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOjARUu+2DtyQfClwCRqn/P8ZWZLlWVLfHTUjkedZKYYfjSyKBUE50N5akXrjf+12yocB8u11M66RVoKoheKoIYaLFWroY8y++vjv+n0/Bjeiq0RJ9czaJzEQzqxpbl2uoST/bT7DVR0NV7OCZue5yhY3O1zAzoVZzH8fx2jw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SILJS9Ev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4kcdoSw7LDS9+yf8C2Tt+DzBl7/RT2q80T0a13WnlE=;
	b=SILJS9EvgxZzhjeD78EEIUMCqbekiW+5FG3FDnBLLvqNJW5o7a5fAzVY7zVTvkv88RGKKH
	l6PLAa7GL5tLb3qNvdXc0P1EGjSdaLAENFp5x+FyIzvpDxEUshYXzr7RuEipON+hRNX/Qd
	HYbStRdDjAj0Ay6oh/hgiKmAIMJQwyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-NPV6KeqjMjW1Oqy3pjOVkA-1; Mon,
 08 Dec 2025 07:10:40 -0500
X-MC-Unique: NPV6KeqjMjW1Oqy3pjOVkA-1
X-Mimecast-MFC-AGG-ID: NPV6KeqjMjW1Oqy3pjOVkA_1765195839
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21E1B18001D7;
	Mon,  8 Dec 2025 12:10:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC7F41956095;
	Mon,  8 Dec 2025 12:10:35 +0000 (UTC)
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
Subject: [RFC 03/12] bio: add bio_set_errno
Date: Mon,  8 Dec 2025 12:10:10 +0000
Message-ID: <20251208121020.1780402-4-agruenba@redhat.com>
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

Add a bio_set_errno(bio, errno) helper that sets bio->bi_status to
errno_to_blk_status(errno) if errno != 0.  Replace instances of this
pattern in the code with a call to the new helper.

The WRITE_ONCE() in bio_set_errno() ensures that the compiler won't
reorder things in a weird way, but it isn't needed to prevent tearing
because a single-byte field like bi_status cannot tear.

Created with Coccinelle using the following semantic patch:

@@
struct bio *bio;
expression errno;
@@
- if (errno)
-	bio->bi_status = errno_to_blk_status(errno);
+ bio_set_errno(bio, errno);

@@
struct bio *bio;
expression errno;
@@
- if (unlikely(errno))
-	bio->bi_status = errno_to_blk_status(errno);
+ bio_set_errno(bio, errno);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 drivers/block/drbd/drbd_req.c | 3 +--
 drivers/nvdimm/pmem.c         | 3 +--
 include/linux/bio.h           | 8 ++++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d15826f6ee81..bd4bc882cc5a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -176,8 +176,7 @@ void start_new_tl_epoch(struct drbd_connection *connection)
 void complete_master_bio(struct drbd_device *device,
 		struct bio_and_error *m)
 {
-	if (unlikely(m->error))
-		m->bio->bi_status = errno_to_blk_status(m->error);
+	bio_set_errno(m->bio, m->error);
 	bio_endio(m->bio);
 	dec_ap_bio(device);
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 05785ff21a8b..a2f8b5a85326 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -232,8 +232,7 @@ static void pmem_submit_bio(struct bio *bio)
 	if (bio->bi_opf & REQ_FUA)
 		ret = nvdimm_flush(nd_region, bio);
 
-	if (ret)
-		bio->bi_status = errno_to_blk_status(ret);
+	bio_set_errno(bio, ret);
 
 	bio_endio(bio);
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 16c1c85613b7..38ebf03036cb 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -389,6 +389,14 @@ static inline void bio_wouldblock_error(struct bio *bio)
 	bio_endio(bio);
 }
 
+blk_status_t errno_to_blk_status(int errno);
+
+static inline void bio_set_errno(struct bio *bio, int errno)
+{
+	if (errno)
+		WRITE_ONCE(bio->bi_status, errno_to_blk_status(errno));
+}
+
 /*
  * Calculate number of bvec segments that should be allocated to fit data
  * pointed by @iter. If @iter is backed by bvec it's going to be reused
-- 
2.51.0


