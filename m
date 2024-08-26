Return-Path: <linux-btrfs+bounces-7518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3195F847
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB65B23438
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727381990C8;
	Mon, 26 Aug 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TzgzAbEI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73E198A34;
	Mon, 26 Aug 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693918; cv=none; b=p67cYBjLybv6PjQc1OBdVcMuC/7WYi0/ScZdnbiTSd9URD8BWI/BkaI1uPRSkZVei1NgHpZGGnuBxpmK0OUMNkffYu+Vsss8iluzA0+LDRX3u0Sc6aBpuGwewxVi9PiqrE3exrC/8nBHQoXyVFrzgP1bP0GANFoqE9QA6TsgpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693918; c=relaxed/simple;
	bh=iwo8hl8xY1BSbt4bXpNnabk5ptyd2+uDGnTGCImjgWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG5Z0qCnAPDAOdhHjFgS/gdnWIN1tW7uXNt1qU2m+6UCco1zpkyjY+7Kr4AbSO6w5BovhlgzA1L8euXO5v9ifJKWibuOyap42nBDyYYJU777cKfKNcwaV9jdzZnxtpU+R1dxKbggUwMS+8nMJ4Ygro3VRcHqGkeL4rkE10oZucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TzgzAbEI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=omZkynrzvTm4SPvm8mn56uhqb82LMW6lpAEs2QFZJ4E=; b=TzgzAbEIaDrMehZxu58Z2+ioTq
	t40AZMU/M3vEOdcAaV9QFGgMmq0EyLJ2iK5yWEfZp5F0OlzDKQlCmLWtV/Pr6/5uOWLLjyvRDvO7J
	Q6rFLj8euhGp1oKoJoY1Qos65CtdtQida4y6JRARd2/aDnDGERqJsRSEkjq20sLq8gZH8SLyjdbDH
	loacHQ2hXp5Ld/rT5fuP/PEuVnktJMsc1eY2rl61PMmfyLAhz/VXMdEP0QONXDOP3BlOy0MpnU8L2
	58jjEVFyy9iXZWXXCI4Efk/6zzJLQ7gEey+RrbvO585OdXDlRGnm+3FMRfmO61d4B+sU/IhUrcUyU
	VFKr/Usw==;
Received: from 2a02-8389-2341-5b80-a8a7-5c16-efec-d7f9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a8a7:5c16:efec:d7f9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidfn-00000008Fy3-0ikr;
	Mon, 26 Aug 2024 17:38:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] block: properly handle REQ_OP_ZONE_APPEND in __bio_split_to_limits
Date: Mon, 26 Aug 2024 19:37:56 +0200
Message-ID: <20240826173820.1690925-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826173820.1690925-1-hch@lst.de>
References: <20240826173820.1690925-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently REQ_OP_ZONE_APPEND is handled by the bio_split_rw case in
__bio_split_to_limits.  This is harmful because REQ_OP_ZONE_APPEND
bios do not adhere to the soft max_limits value but instead use their
own capped version of max_hw_sectors, leading to incorrect splits that
later blow up in bio_split.

We still need the bio_split_rw logic to count nr_segs for blk-mq code,
so add a new wrapper that passes in the right limit, and turns any bio
that would need a split into an error as an additional debugging aid.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 20 ++++++++++++++++++++
 block/blk.h       |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index c7222c4685e060..56769c4bcd799b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -378,6 +378,26 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 			get_max_io_size(bio, lim) << SECTOR_SHIFT));
 }
 
+/*
+ * REQ_OP_ZONE_APPEND bios must never be split by the block layer.
+ *
+ * But we want the nr_segs calculation provided by bio_split_rw_at, and having
+ * a good sanity check that the submitter built the bio correctly is nice to
+ * have as well.
+ */
+struct bio *bio_split_zone_append(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nr_segs)
+{
+	unsigned int max_sectors = queue_limits_max_zone_append_sectors(lim);
+	int split_sectors;
+
+	split_sectors = bio_split_rw_at(bio, lim, nr_segs,
+			max_sectors << SECTOR_SHIFT);
+	if (WARN_ON_ONCE(split_sectors > 0))
+		split_sectors = -EINVAL;
+	return bio_submit_split(bio, split_sectors);
+}
+
 /**
  * bio_split_to_limits - split a bio to fit the queue limits
  * @bio:     bio to be split
diff --git a/block/blk.h b/block/blk.h
index 0d8cd64c126064..61c2afa67daabb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -337,6 +337,8 @@ struct bio *bio_split_write_zeroes(struct bio *bio,
 		const struct queue_limits *lim, unsigned *nsegs);
 struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		unsigned *nr_segs);
+struct bio *bio_split_zone_append(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nr_segs);
 
 /*
  * All drivers must accept single-segments bios that are smaller than PAGE_SIZE.
@@ -375,6 +377,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
 			return bio_split_rw(bio, lim, nr_segs);
 		*nr_segs = 1;
 		return bio;
+	case REQ_OP_ZONE_APPEND:
+		return bio_split_zone_append(bio, lim, nr_segs);
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 		return bio_split_discard(bio, lim, nr_segs);
-- 
2.43.0


