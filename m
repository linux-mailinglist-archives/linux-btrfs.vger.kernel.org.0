Return-Path: <linux-btrfs+bounces-9283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DF9B8A65
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AF52828A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8B14B945;
	Fri,  1 Nov 2024 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqphav1z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5C148833;
	Fri,  1 Nov 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730438541; cv=none; b=dZpsV3X5o4JB4Ejy5nPa0PssrPNAYFw4S+a+1BRv2hDno+65f+7dSclLiA9aAdSD02GBN9DOCXt9lJPqoo/5UciYDXoOlkUnYDEbzZCBXyI+uQhUKuAbfd+Yk/dcRO9UkJtnHYUzhiGga8aY9jjKRap3Nq+WmS94W4kSI8CLKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730438541; c=relaxed/simple;
	bh=z39hrZpi+DFwhXJlNFv4OE3g8fMI19Mu3OuYJ7O2bYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkiXLAbyzMicoZ7FX84A4GWiBc92RuUpa6FmTYcGqualCxvhAKCO8djR0kbhSHQkLpabiXWgVhV7AJcWC1UAt+rG/Hd2vA0GSVqsOqGOQCrXqB+cY7xd6pB9Q2rLEfjELEbgqpT0ANsexTI2ucLxcT9wVr/2+cM0SdyAVldD4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rqphav1z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eQglrKO3cTPUjwY+ITAsHWbCwAas6cfGpEhvnjlZTXk=; b=rqphav1ztRqhjdfzstWbpeo/qw
	vyAld9K1qTzknBfd6XJAEG9uIIsCRMkUUiB7uay1nQMpWNIHVlNvXou/6murKjXFrSmGjOIj0XK9H
	2NMBP4wTcBNzELQoChsPzukZKRCeJHhcd4XZLIwM2a39RzCMBWpUQDG0qg+XC9jeLIPAAJ9MBS5lQ
	Afx4FMmYk/H/+A5jdhtwhe3emOsnfQY6DaDc2gfyvIKAyD/v9t1e4oNEfQL5Cik57b+MvzbJnI1OZ
	UqZprdi1qpyFTlNuyAqHACMcxHqV+4Is/zsHoCFFA1x8VGcqthA+2RLbwfGa2V4HwPVcNKIvvDydn
	SDC8KOgg==;
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6k6z-00000005pHO-2vlh;
	Fri, 01 Nov 2024 05:22:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: use bio_is_zone_append in the completion handler
Date: Fri,  1 Nov 2024 06:21:46 +0100
Message-ID: <20241101052206.437530-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101052206.437530-1-hch@lst.de>
References: <20241101052206.437530-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise it won't catch bios turned into regular writes by the
block level zone write plugging.

Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fec5c6cde0a7..0f096e226908 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -366,7 +366,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
+		if (bio_is_zone_append(bio) && !bio->bi_status)
 			btrfs_record_physical_zoned(bbio);
 		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	}
@@ -409,7 +409,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
+	if (bio_is_zone_append(bio) && !bio->bi_status)
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
 	btrfs_bio_end_io(bbio, bbio->bio.bi_status);
@@ -423,7 +423,7 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	if (bio->bi_status) {
 		atomic_inc(&stripe->bioc->error);
 		btrfs_log_dev_io_error(bio, stripe->dev);
-	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+	} else if (bio_is_zone_append(bio)) {
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	}
 
-- 
2.45.2


