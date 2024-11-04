Return-Path: <linux-btrfs+bounces-9312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254949BAC83
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C641F222D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBEA18D642;
	Mon,  4 Nov 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4cws6TOh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25EF17583;
	Mon,  4 Nov 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701615; cv=none; b=K8DTJflLk8K6X8OLAGGyj+nkayPLJjJKePu64FoQUqxLOFtsBPKw6Cv0DyX/zynxK+EdFKJW/4Auh4QZ0MSPN88ug8y8AQytjwJDCAFnc/2yEr0Zv02QsyLT3xslTy6QXsH3ILYpVq/JRZXM8EiCZienrh3Whh4SCO/hK/sCQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701615; c=relaxed/simple;
	bh=+BfJ+HPwVKRE95LTxnWPD1+CbCnKzc6B0thWWFK8Gl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsgWSZHZh5TjCkUL2RxRThK1mEynhp4iopyG75OXRF3Kgjq6AzLLfnqzA6XZt+/Wee7+WW+tIvV0vG4bcPyzoL/AjS6TpwREI/2z3vkyPqYdm1M/HxMcrZXRK0joEIor8sJ1vgHTYB9IiVf3lpWpr0cgFOttGDXcIvmli//KZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4cws6TOh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O1tyXiGHyIiRUZY9ORb1jpf4aW68m98TAHkBFvd/LWo=; b=4cws6TOhglIWpz0RrgCsW40pHO
	iMXHKFL5XJxPNIClhXkCV6ZfGSlqzKqUW0xlfLbM9N6PUer61NhWffnUdK+dz3Li/emUJX5s4kZ0w
	FWW8UrXtWBMYBqSkMo2BKKnBecjCiyERq3K5avaN4pfz1i+zC03i5rwayNc0W82ekTA6wLiTxof+q
	TNlUxqoInudE3HPj7YH9THeka7ayQsVI61vesU7ZXozSMvcuy8sP8L5MEHNiHn+IK7GO6Wl80BG7j
	fwRKUidx3WXv3CZsYnZs+oLqTVKcCtl/tyEQlK+cd01Wek7ZFT3OhKhiukGfJxXJtgqzF9abItlu3
	MrVEtHuA==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qY8-0000000Cl2W-2XBl;
	Mon, 04 Nov 2024 06:26:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] block: take chunk_sectors into account in bio_split_write_zeroes
Date: Mon,  4 Nov 2024 07:26:29 +0100
Message-ID: <20241104062647.91160-2-hch@lst.de>
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

For zoned devices, write zeroes must be split at the zone boundary
which is represented as chunk_sectors.  For other uses like the
internally RAIDed NVMe devices it is probably at least useful.

Enhance get_max_io_size to know about write zeroes and use it in
bio_split_write_zeroes.  Also add a comment about the seemingly
nonsensical zero max_write_zeroes limit.

Fixes: 885fa13f6559 ("block: implement splitting of REQ_OP_WRITE_ZEROES bios")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d813d799cee7..f440919b6c6f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -166,17 +166,6 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 	return bio_submit_split(bio, split_sectors);
 }
 
-struct bio *bio_split_write_zeroes(struct bio *bio,
-		const struct queue_limits *lim, unsigned *nsegs)
-{
-	*nsegs = 0;
-	if (!lim->max_write_zeroes_sectors)
-		return bio;
-	if (bio_sectors(bio) <= lim->max_write_zeroes_sectors)
-		return bio;
-	return bio_submit_split(bio, lim->max_write_zeroes_sectors);
-}
-
 static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
 						bool is_atomic)
 {
@@ -211,7 +200,9 @@ static inline unsigned get_max_io_size(struct bio *bio,
 	 * We ignore lim->max_sectors for atomic writes because it may less
 	 * than the actual bio size, which we cannot tolerate.
 	 */
-	if (is_atomic)
+	if (bio_op(bio) == REQ_OP_WRITE_ZEROES)
+		max_sectors = lim->max_write_zeroes_sectors;
+	else if (is_atomic)
 		max_sectors = lim->atomic_write_max_sectors;
 	else
 		max_sectors = lim->max_sectors;
@@ -398,6 +389,26 @@ struct bio *bio_split_zone_append(struct bio *bio,
 	return bio_submit_split(bio, split_sectors);
 }
 
+struct bio *bio_split_write_zeroes(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nsegs)
+{
+	unsigned int max_sectors = get_max_io_size(bio, lim);
+
+	*nsegs = 0;
+
+	/*
+	 * An unset limit should normally not happen, as bio submission is keyed
+	 * off having a non-zero limit.  But SCSI can clear the limit in the
+	 * I/O completion handler, and we can race and see this.  Splitting to a
+	 * zero limit obviously doesn't make sense, so band-aid it here.
+	 */
+	if (!max_sectors)
+		return bio;
+	if (bio_sectors(bio) <= max_sectors)
+		return bio;
+	return bio_submit_split(bio, max_sectors);
+}
+
 /**
  * bio_split_to_limits - split a bio to fit the queue limits
  * @bio:     bio to be split
-- 
2.45.2


