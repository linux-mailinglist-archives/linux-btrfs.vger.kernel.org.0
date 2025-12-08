Return-Path: <linux-btrfs+bounces-19568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C48CAD0E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AFA13030C88
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6902E9EA1;
	Mon,  8 Dec 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp53x1kL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53C2EC0B3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195858; cv=none; b=cMkKwjI5eloYAuaUAgtjegdDp+43MR8A8hKU4shU6RUTTD/Isw8dUF3U4oxi9iqYm7+GfKTomFtK/Iw1AtsHBFf7s0m3nPOKjyUKec735BHC9Lxbh/bdGtz0x85DSWFPlmhxNpDXoIwN3spMxnSpk8oc800f5B8EdvF4GMtQtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195858; c=relaxed/simple;
	bh=/aqHmXm55QFzeqqO0MQ4tbyjsLlvwpwSXuw6KXp6ixY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omBX+CUcku3d/HcjuOw+EN5LEstT8pHTAd5jAEGCO+daMvZmX/pku14CxSyGKlRq3murfOaQnj9RsTAI97FprW/T/pHDqqu5ayc+wM0RzvAyqBhVf+hPgXvvrptttoKRhvrMRP895GDC+A9qua5jpIEwVeNeAQrBQ7MOwr9nhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gp53x1kL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orAO8UOdnlISH4Gd5iJpe1BuLdmoObqRmnQqdm1Ndjk=;
	b=gp53x1kLyU5VJDheNij/qtZshmlebfK0Zd9i0eq+/HoYcsRG/qkgBbAiifv+J23xidHsPP
	KQz0a8zfQH6+wDKdlV/bMn0fazK3QyaLsUOZZ5dXbMZClbFanHkvxrQBAB4pldIAz7UtP5
	GyKS8S6BM2Daix19OuV3eHVjcnox6zI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-7VcLxnpTOg62OUOHeS6ngg-1; Mon,
 08 Dec 2025 07:10:52 -0500
X-MC-Unique: 7VcLxnpTOg62OUOHeS6ngg-1
X-Mimecast-MFC-AGG-ID: 7VcLxnpTOg62OUOHeS6ngg_1765195850
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94EF618002C0;
	Mon,  8 Dec 2025 12:10:50 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B8731956095;
	Mon,  8 Dec 2025 12:10:46 +0000 (UTC)
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
Subject: [RFC 06/12] bio: don't check target->bi_status on error
Date: Mon,  8 Dec 2025 12:10:13 +0000
Message-ID: <20251208121020.1780402-7-agruenba@redhat.com>
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

In a few places, target->bi_status is set to source->bi_status only if
source->bi_status is not 0 and target->bi_status is (still) 0.  Here,
checking the value of target->bi_status before setting it is an
unnecessary micro optimization because we are already on an error path.

In addition, we can be racing with other execution contexts in the case
of chained bios, so there is no guarantee that target->bi_status won't
be set concurrently.  We don't require atomic test-and-set semantics
here.

Created with Coccinelle using the following semantic patch:

@@
struct bio *source;
struct bio *target;
@@
- if (source->bi_status && !target->bi_status)
-       target->bi_status = source->bi_status;
+ bio_set_status(target, source->bi_status);

@@
struct bio *source;
struct bio target;
@@
- if (source->bi_status && !target.bi_status)
-       target.bi_status = source->bi_status;
+ bio_set_status(&target, source->bi_status);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/bio.c     | 3 +--
 block/fops.c    | 3 +--
 drivers/md/md.c | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3f408e1ba13f..5389321872f0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -314,8 +314,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
+	bio_set_status(parent, bio->bi_status);
 	bio_put(bio);
 	return parent;
 }
diff --git a/block/fops.c b/block/fops.c
index b4f911273289..a4a6972cbfbf 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -135,8 +135,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 	bool should_dirty = dio->flags & DIO_SHOULD_DIRTY;
 	bool is_sync = dio->flags & DIO_IS_SYNC;
 
-	if (bio->bi_status && !dio->bio.bi_status)
-		dio->bio.bi_status = bio->bi_status;
+	bio_set_status(&dio->bio, bio->bi_status);
 
 	if (bio_integrity(bio))
 		bio_integrity_unmap_user(bio);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 41c476b40c7a..f6f1aab18a8b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9084,8 +9084,7 @@ static void md_end_clone_io(struct bio *bio)
 	if (bio_data_dir(orig_bio) == WRITE && md_bitmap_enabled(mddev, false))
 		md_bitmap_end(mddev, md_io_clone);
 
-	if (bio->bi_status && !orig_bio->bi_status)
-		orig_bio->bi_status = bio->bi_status;
+	bio_set_status(orig_bio, bio->bi_status);
 
 	if (md_io_clone->start_time)
 		bio_end_io_acct(orig_bio, md_io_clone->start_time);
@@ -9136,8 +9135,7 @@ void md_free_cloned_bio(struct bio *bio)
 	if (bio_data_dir(orig_bio) == WRITE && md_bitmap_enabled(mddev, false))
 		md_bitmap_end(mddev, md_io_clone);
 
-	if (bio->bi_status && !orig_bio->bi_status)
-		orig_bio->bi_status = bio->bi_status;
+	bio_set_status(orig_bio, bio->bi_status);
 
 	if (md_io_clone->start_time)
 		bio_end_io_acct(orig_bio, md_io_clone->start_time);
-- 
2.51.0


