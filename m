Return-Path: <linux-btrfs+bounces-9315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C62B9BAC8A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8930DB2137F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01918E364;
	Mon,  4 Nov 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="feo4lkFq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2A18E055;
	Mon,  4 Nov 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701624; cv=none; b=D0q77x53DW/D1ITCFQzHiFMf+YBm+jMCLarfvvw1dTI90EgsWbdQiQVd/SOPirxcybDr7DLBfKrC1L/vM64+Zjnf8ZouscthZP2UNuuBGgVHw575S4YI7f+1PexfXfVmw/yFFC+YDS+Ylbc3qgGpvdYjUTmAuC44kytAzKX+FDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701624; c=relaxed/simple;
	bh=azT/nFSf6O23BcSY14Qav6wZktxauuKFYgRYZ7pxFzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2mw9g8yzmEkdBcuWyNcwRtEljOKRVnDpxQ6cMMtDwJAEdr9vqpXn096j1Z66W611ZnHHuu9BbCzTeR/eDDiM5KMmdcdb6xbPI1ouHFw2PmX+TUrF3/vC5gioOhstFE7LCoz8Jaxua4vB6j/ghsydoPDKcN1loeLLWycYdrDoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=feo4lkFq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oaCuK3vkoOE1dSVOtHe46/RXy5sHzSmiC0OTM79f9S0=; b=feo4lkFqHb0iC7/NYjKy+EcfRk
	CBI8OZHgdt4nLXZvT0r87wDZUmIevqWGhPxNz+vpU44BRpFLTxIoyVFF4h5dCvXfgpBHAm4oNpU1i
	q+nZWmdPPOnE9tcDr+PUipQSaxKpdSJt2SqDh5bsLwi4ba0DV/1dB0AHc2nMuTpSmxRddpRea3KCw
	Jjisq4TRlOQsXwXr7Aftn2oNReeZUL7zB6AyIcaJIq0j32Uuz06FAyg4nuFhK5ka8XZBRC2oliKaq
	9s3nwHhpKE1U8ga2WTZ59H9NWExaHMmRKFK/QypKvWwbkQ8m1iM5jakzDSWlg5YM8KxCNX2m5gnzx
	PpGSitrQ==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qYH-0000000Cl3c-2RTe;
	Mon, 04 Nov 2024 06:27:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 4/5] btrfs: use bio_is_zone_append in the completion handler
Date: Mon,  4 Nov 2024 07:26:32 +0100
Message-ID: <20241104062647.91160-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104062647.91160-1-hch@lst.de>
References: <20241104062647.91160-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


