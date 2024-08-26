Return-Path: <linux-btrfs+bounces-7517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3C95F845
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE781C221AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408311990B7;
	Mon, 26 Aug 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tdpaDM12"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA1197A9B;
	Mon, 26 Aug 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693915; cv=none; b=pmY4zjR1XLleh12h6kYO2rhBuqBJKr5mN5fHLLu+69q5nvWYnEPQslZp42ZbUItz7l25YpvkvgPfefi4DXuYJAMPjhXd8MQvUAB8JJ5HrqxoCg7HjAB1yZaNXA+i+hwzZH0WdIMeLuobcKCTphZW57/hjkaygpJuiXDEC6F7dRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693915; c=relaxed/simple;
	bh=CA2gephBjvJn0/GkW9AEA2AU2FIwaaErndnSem8buXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBG2B+5Y5hVXJJ4ulXQzRBZBoLQT5toVqSOiP4tZhLxxgQqp5ZuXENBn4/IBHQ176KvPLex5c0IH+kfVswSC9eRVmnF56QPA8P5nAVqXxrtUErYpC7MpQdnjJWy3aYvEFoq/GD9tAEeUcmkVIfkoc5JcqM+TRhV24MddZ3yLrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tdpaDM12; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JFuGo/wtYw2xFTlIaF+fNehaa9Zme8icFr0kBsP7amI=; b=tdpaDM12LWtNEeYXZZAqtubroa
	gCWbGqturrnMqyX1sCx9+w/MLupNUI9DakZygtfbRqVRjDjabgHXQMnTESktAPaZyfwTP4OnJtgkn
	vcm1qx398ptvKrmKxiVYb4TabPKG522ejCb5UfknSoWMIDJBenxchqb3O5yp6vYPcPvmTEj9p/92r
	MOCsg0rTYEiolXhuURTWXUPGtIzaQyiwLsjT4WHYsZlWnGAzR4sVfN+O8hTSAa8ljkCRD7u8voenH
	XVd/T3iOR4ciR9QY9iF+Z86xZuExZocaYJcXGeBumHPPMoapbxjH6Di8ChmU3X1K/k6ekJaA7oGHg
	37fVsIjw==;
Received: from 2a02-8389-2341-5b80-a8a7-5c16-efec-d7f9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a8a7:5c16:efec:d7f9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidfk-00000008FxP-0s31;
	Mon, 26 Aug 2024 17:38:32 +0000
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
Subject: [PATCH 2/4] block: constify the lim argument to queue_limits_max_zone_append_sectors
Date: Mon, 26 Aug 2024 19:37:55 +0200
Message-ID: <20240826173820.1690925-3-hch@lst.de>
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

queue_limits_max_zone_append_sectors doesn't change the lim argument,
so mark it as const.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e85ec73a07d575..ec3ea5d1f99dfe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1187,7 +1187,8 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
-static inline unsigned int queue_limits_max_zone_append_sectors(struct queue_limits *l)
+static inline unsigned int
+queue_limits_max_zone_append_sectors(const struct queue_limits *l)
 {
 	unsigned int max_sectors = min(l->chunk_sectors, l->max_hw_sectors);
 
-- 
2.43.0


