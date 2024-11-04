Return-Path: <linux-btrfs+bounces-9313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DE9BAC85
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371541C2093D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2A1791EB;
	Mon,  4 Nov 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbTc6Shu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5217583;
	Mon,  4 Nov 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701618; cv=none; b=IOE5gwS7Ui8H84wwi5zCm/dvrmO7GxYedQcZMkeXxDYJamBHvU2UGXsvnbz5Q+nQB9kD/3WBf5Sjma1GhWDBMcbUp6pScrPQmK6NmHWlArfCUK6zgRA2HKYkcHk6XaH41cppitXhm7uAcjkOnODg0W8ltNqTDWllJH2LGQEyXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701618; c=relaxed/simple;
	bh=YZuzsXtnbUOLLvjZnxC3IdczgYFmB6LLq/rW8p7spxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzVfC3VsnC4oDtSldeOm0TYrlWiuUlhpoi1V7jDXStxye/nUI3WtM0Ta0onkWqmAxj+S9B0qmkJn6ShZycmEEI9T9S6EFuvV7jWe7EHljNpWuYAtTDLrx17gcOskIw3wVroWDws9clrWcqkA1zCq5+DcsgGX6G0x+fghutYusrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jbTc6Shu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wSc3axFl040BTlkVHJV3xpYsecHplStlVUfIc2n+5R8=; b=jbTc6ShuJQpPXOMh7Rg0XO8+O8
	hgdXfmY6FkeDSa4L23Rp4xjFRNVACZcRVxpIORsftD3oRyg+DjATtij0VutygmqLcaSxCXDEuKilU
	iiaBPESyuvCZx3yQgGrlTYAeugprvNX0/wzT3hovm2Sq0nzjZ0nJNvjj9wxfUW570EiYu1kdf9yoP
	Nay17h0plV4URGOLAjfKg7XcZO2yHYL6rSu22taXzjwRLKJ6ts8kwI6zf+tOQ0tn9gxSU10Ofw5WS
	JtXQLJDkgBghm5ixqSahjGOdmqc0pj49m/soo7tYXgbW3gqNAqi+0ZVXwEILqH1Py4eb8WjZ/dwYa
	svmBP4NQ==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qYB-0000000Cl2o-1S1r;
	Mon, 04 Nov 2024 06:26:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] block: fix bio_split_rw_at to take zone_write_granularity into account
Date: Mon,  4 Nov 2024 07:26:30 +0100
Message-ID: <20241104062647.91160-3-hch@lst.de>
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

Otherwise it can create unaligned writes on zoned devices.

Fixes: a805a4fa4fa3 ("block: introduce zone_write_granularity limit")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f440919b6c6f..4e6c0a52009c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -287,6 +287,14 @@ static bool bvec_split_segs(const struct queue_limits *lim,
 	return len > 0 || bv->bv_len > max_len;
 }
 
+static unsigned int bio_split_alignment(struct bio *bio,
+		const struct queue_limits *lim)
+{
+	if (op_is_write(bio_op(bio)) && lim->zone_write_granularity)
+		return lim->zone_write_granularity;
+	return lim->logical_block_size;
+}
+
 /**
  * bio_split_rw_at - check if and where to split a read/write bio
  * @bio:  [in] bio to be split
@@ -349,7 +357,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 	 * split size so that each bio is properly block size aligned, even if
 	 * we do not use the full hardware limits.
 	 */
-	bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
+	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
 
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
-- 
2.45.2


