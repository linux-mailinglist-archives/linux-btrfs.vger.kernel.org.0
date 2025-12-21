Return-Path: <linux-btrfs+bounces-19932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CFCD3A68
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53929301EF97
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DE21B9C9;
	Sun, 21 Dec 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUoR1YAD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF31FC0EA
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285589; cv=none; b=BGzT91deYW9114vBqt5pPvlwcs+cZpRwEpL6Q18CUYrWQ3xdJbsBpzXGLqPGGRoLWe7na9+FE5j2Yhzw6UKgP0nVK/O1ll27L8Sr5z+EfGNRJq6BdyhACKwtbY4IdL6bxfKdT8KqbaMPcmHgnx+ks1Z1IiS9db0ItpawnUWkupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285589; c=relaxed/simple;
	bh=G5zNazOwnANuZl6Zkj9RKTqDaNGEAQbBly+9bJs0YTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2Xxno4C10a5G3Vv8CNarY8q3InVfypq1+533kd5a3g9Q3jSoxsgZY8/1dqX0LY5gaw1fg+k/W0Wqe7NnWOQqK/Og/ZRo3nOe6TFn110aeU8wJiZq69RJXskbKpvkuFhZNAtphMj2hnRnibTUEu3FM+7r/mOHg47xZUCX5ZPxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUoR1YAD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot0Li/Rd6I4GT/jTlGyYgi3ywYy+1RwNsdBzqtFhH9I=;
	b=cUoR1YADdLWPm6zUPoX/HTns3UY8ukTPeadxFfAhJEB5tU/6V9JpljrTiES00qXU1AXJQm
	n2ul5ANoz9C6NpRF8kHqs5mlmEShLoEJa6L+vqmCfWcdmNiAjeCe2ue11IzA/vzx3jGc0n
	5HKBsSTfMQ8Y2bQooCjpXqmAG9/bEz0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-nzwPdJNfNdKtPdmRKsmofQ-1; Sat,
 20 Dec 2025 21:53:03 -0500
X-MC-Unique: nzwPdJNfNdKtPdmRKsmofQ-1
X-Mimecast-MFC-AGG-ID: nzwPdJNfNdKtPdmRKsmofQ_1766285581
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC7E1956088;
	Sun, 21 Dec 2025 02:53:01 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 626A9180049F;
	Sun, 21 Dec 2025 02:52:58 +0000 (UTC)
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
Subject: [RFC v2 06/17] bio: do not check bio->bi_status before assigning to it
Date: Sun, 21 Dec 2025 03:52:21 +0100
Message-ID: <20251221025233.87087-7-agruenba@redhat.com>
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

In a few places, we check if to->bi_status is 0 before setting it.  This
creates the impression of preserving the first error code that occurs,
but that is not actually the case because bio->bi_status is not updated
atomically.  (And even updating bio->bi_status atomically wouldn't
preserve the first error in bio chains longer than two.)  We don't
actually need to preserve the first error code, though; and all that
matters is that when an error occurs, one of the error codes is
preserved.

Checking bio->bi_status before assigning to it might also have been
meant as an optimization.  We are on an error path and the potential
benefit is miniscule, though.

So, don't check bio->bi_status before assigning to it.

Created with Coccinelle using the following semantic patch:

@@
expression status;
struct bio *bio;
@@
- if (status && !bio->bi_status)
-       bio->bi_status = status;
+ bio_set_status(bio, status);

@@
expression status;
struct bio *bio;
@@
- if (status != BLK_STS_OK && bio->bi_status == BLK_STS_OK)
-       bio->bi_status = status;
+ bio_set_status(bio, status);

@@
expression status;
struct bio *bio;
@@
- if (unlikely(status) && !bio->bi_status)
-       bio->bi_status = status;
+ bio_set_status(bio, status);

@@
expression status;
struct bio bio;
@@
- if (status && !bio.bi_status)
-       bio.bi_status = status;
+ bio_set_status(&bio, status);
---
 block/bio.c                  | 3 +--
 block/fops.c                 | 3 +--
 drivers/md/dm-integrity.c    | 3 +--
 drivers/md/dm-zoned-target.c | 3 +--
 drivers/md/md.c              | 6 ++----
 5 files changed, 6 insertions(+), 12 deletions(-)

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
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e380ed7b2a7b..6d04b067060d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1616,8 +1616,7 @@ static void dec_in_flight(struct dm_integrity_io *dio)
 			schedule_autocommit(ic);
 
 		bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
-		if (unlikely(dio->bi_status) && !bio->bi_status)
-			bio->bi_status = dio->bi_status;
+		bio_set_status(bio, dio->bi_status);
 		if (likely(!bio->bi_status) && unlikely(bio_sectors(bio) != dio->range.n_sectors)) {
 			dio->range.logical_sector += dio->range.n_sectors;
 			bio_advance(bio, dio->range.n_sectors << SECTOR_SHIFT);
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 9da329078ea4..efb960eca8ea 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -77,8 +77,7 @@ static inline void dmz_bio_endio(struct bio *bio, blk_status_t status)
 	struct dmz_bioctx *bioctx =
 		dm_per_bio_data(bio, sizeof(struct dmz_bioctx));
 
-	if (status != BLK_STS_OK && bio->bi_status == BLK_STS_OK)
-		bio->bi_status = status;
+	bio_set_status(bio, status);
 	if (bioctx->dev && bio->bi_status != BLK_STS_OK)
 		bioctx->dev->flags |= DMZ_CHECK_BDEV;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index cbca792fa380..5afc6d63aa7b 100644
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
2.52.0


