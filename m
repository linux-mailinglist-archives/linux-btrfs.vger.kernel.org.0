Return-Path: <linux-btrfs+bounces-9282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557589B8A64
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AA7B21CBE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCF014AD0E;
	Fri,  1 Nov 2024 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1qieJJdO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C210F4;
	Fri,  1 Nov 2024 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730438540; cv=none; b=u6xLdGstfAzk8KV6iSJKSCW01cHxXB5Wx5L7FH5EqJdD0XPRe/cGQ2eu1o4xW+EfcotD8AkngqxZe3BdnrclwcJUQ/uDcq6Al4pw4tYCIBuf8qYRdniM28dv+5zrt3oB3+GRBY+kvHI24001DaJvMeF7lBWv8z5xVICP7x5HnHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730438540; c=relaxed/simple;
	bh=ZUkHU54sLpz5za57c2YCZC3gjWNt5WfSHTest/Z7aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq0Za94sxspg2fAWNyR3SxPN5Rie/712bWCrpSjTv7X6eIzVAGjFByE/iggrjDZbfyD6W0KQWkjtlhd7PTrL9GPIgABWNpoJMiRH6AuM7+7IzfTH+Px7sgeIJ2l14SoUsMIX1AIwBgJU44ddlGlByi5UBh340V2+NpFFXisVBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1qieJJdO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I56f3/YPgy9WjhPLAy7KWovxKgackQQXlSQlZ3dgc20=; b=1qieJJdOEzQvrxoSDBVxFokRuR
	mRyFInrcPXfJoW0e4qNImubXASw1v2luCRU/9snhnC/v9jL3HyE+Q4O7TVTeus86FyVm3OeCBtIvz
	I83y/BMF8hRb9BxKJYrXEpL2YAXEADrx5f6pAGTr1zgQedfTIaoZEjNOzexKu3/9mlyPzdPVKjquj
	1TaGr1eW7u0cUJVZNnlcms2MHT7bvevj3KWAvFQFex+XC7KskCSVcTrjy9SquNkghwVdUVqlnH1cL
	qDQ5PhRxQdZs3D5RbfFrb4Z9upIx3VRgGHCgbHsNIU1jAcPjQVP7SKpK7lkXRYQW6iaWEhPs0NHut
	dd/arQVg==;
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6k6w-00000005pH8-37gt;
	Fri, 01 Nov 2024 05:22:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] block: lift bio_is_zone_append to bio.h
Date: Fri,  1 Nov 2024 06:21:45 +0100
Message-ID: <20241101052206.437530-3-hch@lst.de>
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

Make bio_is_zone_append globally available, because file systems need
to use to check for a zone append bio in their end_io handlers to deal
with the block layer emulation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


