Return-Path: <linux-btrfs+bounces-9314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13C9BAC87
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B756F1F2220B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07418C357;
	Mon,  4 Nov 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3uGDmY4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211618562F;
	Mon,  4 Nov 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701622; cv=none; b=ShnpqfJHNuaYWJDwiygZjIWdOomF0u5SdbkHoUBsRI9pH3OSNcvb7iTKmoYfgTnlwDd+TmyBzhU0nLGOILMPPklEIUjvbEMMa0jlAKSTGIgj0vxksy8Buyn0mXPZJNZqIM45XDJw3LzmSvGnOvN6Ms8pVCsoQ4iD6D7Fh41ZtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701622; c=relaxed/simple;
	bh=g6OYhJEpuFSZK+RD+Rcgv51mtkjmW9XYxjjcxWbViNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FreWuIpmSrD6xdvt70hPERmO53FZi2Bbf1+uilXJkeNi8Mvub0bWF3UNnBHf7PcpM3BjtDzs7j49M9x1D4n2QUw7DdaKUJyCCBJr08cN/AxT0YKP5CGtRJ6N7gDr07bJoLXDf3JQHCpKGGiQhlEFnojbX60xS3G5s2U0mYQD1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n3uGDmY4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UQTaU5P/0JZcdZzVmIgMgjW5rz31/6LiQC/DFO7xtXw=; b=n3uGDmY4t4ineTx+aJ9cLtOLal
	uazOnNWgd2Lggupez2fHbcWkmwkihYnipWBv3hL98CoR5T9S6EkLba4rlpNe2C0VYbJhhGlyPq7Xj
	jnZxC68d7vkz6tnXx5Zb0eawWQuolDvZiSmLMiyQKgEkCrLfpKx68WMBBQNljvz5qzgGNa0zbmZ/E
	RkZQ3clseZjim+HYznOpSCmRUq0nopEb7n1KgbOJbZzrq9izHWRkjENflABhrW5q8B9lYtUxvQ9Nm
	ymccRnDy9LRsH9Xi8Ww6SmCt3fkVf34+U2FfkpWj0dzWeIaF/YCZMosYYx0rHWaTZ5wVeKn5ygKcx
	XQ88Pdmg==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qYE-0000000Cl38-1bvG;
	Mon, 04 Nov 2024 06:26:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 3/5] block: lift bio_is_zone_append to bio.h
Date: Mon,  4 Nov 2024 07:26:31 +0100
Message-ID: <20241104062647.91160-4-hch@lst.de>
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

Make bio_is_zone_append globally available, because file systems need
to use to check for a zone append bio in their end_io handlers to deal
with the block layer emulation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk.h         |  9 ---------
 include/linux/bio.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 63d5df0dc29c..6060e1e180a3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -457,11 +457,6 @@ static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
 }
-static inline bool bio_is_zone_append(struct bio *bio)
-{
-	return bio_op(bio) == REQ_OP_ZONE_APPEND ||
-		bio_flagged(bio, BIO_EMULATES_ZONE_APPEND);
-}
 void blk_zone_write_plug_bio_merged(struct bio *bio);
 void blk_zone_write_plug_init_request(struct request *rq);
 static inline void blk_zone_update_request_bio(struct request *rq,
@@ -510,10 +505,6 @@ static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return false;
 }
-static inline bool bio_is_zone_append(struct bio *bio)
-{
-	return false;
-}
 static inline void blk_zone_write_plug_bio_merged(struct bio *bio)
 {
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4a1bf43ca53d..60830a6a5939 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -675,6 +675,23 @@ static inline void bio_clear_polled(struct bio *bio)
 	bio->bi_opf &= ~REQ_POLLED;
 }
 
+/**
+ * bio_is_zone_append - is this a zone append bio?
+ * @bio:	bio to check
+ *
+ * Check if @bio is a zone append operation.  Core block layer code and end_io
+ * handlers must use this instead of an open coded REQ_OP_ZONE_APPEND check
+ * because the block layer can rewrite REQ_OP_ZONE_APPEND to REQ_OP_WRITE if
+ * it is not natively supported.
+ */
+static inline bool bio_is_zone_append(struct bio *bio)
+{
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		return false;
+	return bio_op(bio) == REQ_OP_ZONE_APPEND ||
+		bio_flagged(bio, BIO_EMULATES_ZONE_APPEND);
+}
+
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
 struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);
-- 
2.45.2


