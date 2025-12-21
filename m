Return-Path: <linux-btrfs+bounces-19942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D6CD3A86
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 772B5301877E
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB4027E054;
	Sun, 21 Dec 2025 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXqB3eQ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BE26980F
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285633; cv=none; b=pVhAhJ/eOjdmt2GEH6m9SI3AUX+BgMMLlEn4ZdH0HmLmq0HYMxP81Gw80+PaOZnBTPmhSk00s7PqeeiUSREyOlE1UEeQLZqa/Z2uXO7mrhYZwpd3hUVzwjRmqHq+TmoJsFLJNZVBCniwlpmsaZDWQR3jBNP1S/o03kdcAPk/PO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285633; c=relaxed/simple;
	bh=NYyLbW6iEsrA8fkjIrv0STEvi9AYMBFhXV7z3OwZVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6WnQdQCh4GctjHvM2YaR+fASojvBUXnS1ZO+vBphGcKXXbaf6luWQjAqMqR1+LEI0yMCau+5DlTAHQct1cBR+SoMf8bdwZ/xjRkE6Xcq3vs/VPDamtoYaFfxXl+MJaclDAt+qg53nwK//9OM7AfEEwflskHH+cBjOmJtcc0rGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXqB3eQ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEwEGf2cVwym+KiRjPuOI3V34q9SnOs+PEKiirNkNWU=;
	b=WXqB3eQ66wEVeQX+p32ee5lfPAkOPnPi6tR0S+mSo0VMzhkr9UptZ/o77gUdEE4jbUkDzj
	KUK8TL2J1bp2V0baCLpzTLYClzKob09k6weaXtlplKsz1NSwmRTwf0vXFUSAqoU5djZaBh
	Vfbj8a+Ep9IrFV+e/zcNNzQyC/Ek6g4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-f9R6PeB8NAWiX2Mn_4caXQ-1; Sat,
 20 Dec 2025 21:53:37 -0500
X-MC-Unique: f9R6PeB8NAWiX2Mn_4caXQ-1
X-Mimecast-MFC-AGG-ID: f9R6PeB8NAWiX2Mn_4caXQ_1766285616
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56930180028B;
	Sun, 21 Dec 2025 02:53:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6473F180049F;
	Sun, 21 Dec 2025 02:53:33 +0000 (UTC)
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
Subject: [RFC v2 16/17] bio: never set bi_status to BLK_STS_OK during completion (part 2)
Date: Sun, 21 Dec 2025 03:52:31 +0100
Message-ID: <20251221025233.87087-17-agruenba@redhat.com>
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

In these two places, it seems that errno can be 0.  This would assign
BLK_STS_OK (0) to bio->bi_status, which is not allowed.  Fix that by
using bio_set_status() instead.

Created with Coccinelle using the following semantic patch.

(Coccinelle occasionally likes to add unnecessary curly braces
in if statements; those were removed by hand.)

@@
struct bio *bio;
expression errno;
@@
- bio->bi_status = errno_to_blk_status(errno);
+ bio_set_status(bio, errno_to_blk_status(errno));

@@
struct bio bio;
expression errno;
@@
- bio.bi_status = errno_to_blk_status(errno);
+ bio_set_status(&bio, errno_to_blk_status(errno));

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 drivers/md/dm-pcache/dm_pcache.c | 2 +-
 drivers/md/dm-vdo/data-vio.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-pcache/dm_pcache.c b/drivers/md/dm-pcache/dm_pcache.c
index e5f5936fa6f0..086ae9b06bfb 100644
--- a/drivers/md/dm-pcache/dm_pcache.c
+++ b/drivers/md/dm-pcache/dm_pcache.c
@@ -74,7 +74,7 @@ static void end_req(struct kref *ref)
 		pcache_req_get(pcache_req);
 		defer_req(pcache_req);
 	} else {
-		bio->bi_status = errno_to_blk_status(ret);
+		bio_set_status(bio, errno_to_blk_status(ret));
 		bio_endio(bio);
 
 		if (atomic_dec_and_test(&pcache->inflight_reqs))
diff --git a/drivers/md/dm-vdo/data-vio.c b/drivers/md/dm-vdo/data-vio.c
index 262e11581f2d..11becc4138c4 100644
--- a/drivers/md/dm-vdo/data-vio.c
+++ b/drivers/md/dm-vdo/data-vio.c
@@ -287,7 +287,7 @@ static void acknowledge_data_vio(struct data_vio *data_vio)
 	if (data_vio->is_partial)
 		vdo_count_bios(&vdo->stats.bios_acknowledged_partial, bio);
 
-	bio->bi_status = errno_to_blk_status(error);
+	bio_set_status(bio, errno_to_blk_status(error));
 	bio_endio(bio);
 }
 
-- 
2.52.0


