Return-Path: <linux-btrfs+bounces-9281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A09B8A62
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B011F229D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BBE14A4E9;
	Fri,  1 Nov 2024 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDX2Exju"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5E142624;
	Fri,  1 Nov 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730438539; cv=none; b=pMa7KEjGdhEz0Ct5IZgcNCb7a1VFFRd5YgQOICcauBhsFN2FAg4GRkucdzJmco26tf6o6pC1zAnRKwn0cXnUREhmfvb2dj9ISiT7XF59VsptZHvM9WU5znGZcOMP6D5awi/sX20a7xxnVcRDoWh0nDVz78wxywPzx3RQCXTd38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730438539; c=relaxed/simple;
	bh=slb+KppCK655pfVwV7e99lPKBdHboIRwq1Bll/HsT1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPNPgPCkemU7diNLu873EJkXFyYornuvVOF4M6Ju21hPmXuphEieJANi6Es0S9A6piTStM0I+dIrKWUZgRh7EP5mh97dldhLC09gkuyFs9TZ04NSqny7hp7LxNZBEHgWwEkenjhQcjtYnn/0jnxfLgp0qYbEYcZ/YMQbD1A2uWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GDX2Exju; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lGZz3Zhi20WXhdaLzZCJgylWTpCpZvB7OeLjk0c/j4I=; b=GDX2ExjuOkHTUQ7ewprh8gD8St
	iZ4W5jywqde1Qs1EUFw/h+SA4vCrtWnCUhS3zpNhkSU3PQ5b+1J8AgSjpHBannp6TQZeAc/fefpO4
	ByOqMTkUNh9e4FUd75fMt4E1sWFcZloUaM/TS2O2qkCM7mPs/u1hisHdf/Ryy6dY51jFiGvnoulpN
	b7jZVfKRXglcpxkNIOhdvE4Dz4AyDKudqiwxMcpiN28xDuUdWq8FMmkNCGRPi4EsLVjcqTf8ugJIJ
	nfKe317ISTD8q5sJcmPt+sOijU3QgPgamcgwkqY/FrMcnjlGuU+6eMhkN52ksWYXYw8I4gH412fvh
	6ig4/i3Q==;
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6k6t-00000005pGr-0nJV;
	Fri, 01 Nov 2024 05:22:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] block: fix bio_split_rw_at to take zone_write_granularity into account
Date: Fri,  1 Nov 2024 06:21:44 +0100
Message-ID: <20241101052206.437530-2-hch@lst.de>
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

Otherwise it can create unaligned writes on zoned devices.

Fixes: a805a4fa4fa3 ("block: introduce zone_write_granularity limit")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d813d799cee7..d6895859a2fb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -358,7 +358,8 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 	 * split size so that each bio is properly block size aligned, even if
 	 * we do not use the full hardware limits.
 	 */
-	bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
+	bytes = ALIGN_DOWN(bytes, lim->zone_write_granularity ?
+			lim->zone_write_granularity : lim->logical_block_size);
 
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
-- 
2.45.2


