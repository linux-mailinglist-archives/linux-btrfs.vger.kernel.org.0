Return-Path: <linux-btrfs+bounces-7519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F180095F849
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD051C2112F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C61990DB;
	Mon, 26 Aug 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwNKv9mC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63B1990A7;
	Mon, 26 Aug 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693922; cv=none; b=MJPxcyVMXXZD396c21yXneLQX1uFqTQdF/WP0qDTAeMHqQjU1mut98DMjk4i5aKGVl6yapWDjc0gywZPMbS2h8mi3DTO8lxiERd+S0YLTkByEJUgv2WjsBkm6Ec9DrgxxrU1hKg7Wyi5CLaAADCgMkbtX0M5brjwA+5k3QY+nmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693922; c=relaxed/simple;
	bh=gjNxz+WDCrVaxGkqjYBwgIQ4LI1H7AXowSfzH9I5l+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4JweveQiUBhQWVp5yuBIWypQM1M5oR46PZR8vChzxEA7ZdIuATcOnS0no6YnU4p53CrillS4zFEvH0cohnxWXTluXcalO69WryeK8nvs67XCm03KoX0w/Obr0RrT5WObBrdnLJ86jDgizeLg1jXjul0vXy+dw9/jSwuRYzov6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwNKv9mC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RNzlZ0CBEGyo8XBfqzn6UuJuFRRrpKYSdfqJczIxzVs=; b=qwNKv9mCFefSmzqRiDImlO/pz5
	H1hzErGuOE/HDfc5jrSnYigUurd2yoKDePfKzEgd2hTVCvOfj/6h7P+SsUdw0JmO23LQUv2+ReHr0
	Ttlie3vNTni1BlD19zpthVIexQ/2Y0ZYgxrAk95u5ZXIB1X5OFRJG/jPDNuQfVFKLvcEnOd/bjOP7
	sNJ+tONcwKrkRJSJn6vMcuVZXQoSFM5KSPqW3uGDqzPa3zEuGE2qoLLSqI1iKVdmuik6bB8bfRWq5
	6w2S8keiCTmYJkU8m1v1E3LeYqD4k+mun8MrikcW9xkYt8cT+Ks25WruJgYUej3k8ZQ3TKkH8W1az
	rshnD5iQ==;
Received: from 2a02-8389-2341-5b80-a8a7-5c16-efec-d7f9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a8a7:5c16:efec:d7f9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidfq-00000008Fyz-44Cw;
	Mon, 26 Aug 2024 17:38:39 +0000
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
Subject: [PATCH 4/4] block: don't use bio_split_rw on misc operations
Date: Mon, 26 Aug 2024 19:37:57 +0200
Message-ID: <20240826173820.1690925-5-hch@lst.de>
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

bio_split_rw is designed to split read and write bios with a payload.
Currently it is called by __bio_split_to_limits for all operations not
explicitly list, which works because bio_may_need_split explicitly checks
for bi_vcnt == 1 and thus skips the bypass if there is no payload and
bio_for_each_bvec loop will never execute it's body if bi_size is 0.

But all this is hard to understand, fragile and wasted pointless cycles.
Switch __bio_split_to_limits to only call bio_split_rw for READ and
WRITE command and don't attempt any kind split for operation that do not
require splitting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 61c2afa67daabb..32f4e9f630a3ac 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -372,7 +372,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
 		const struct queue_limits *lim, unsigned int *nr_segs)
 {
 	switch (bio_op(bio)) {
-	default:
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
 		if (bio_may_need_split(bio, lim))
 			return bio_split_rw(bio, lim, nr_segs);
 		*nr_segs = 1;
@@ -384,6 +385,10 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
 		return bio_split_discard(bio, lim, nr_segs);
 	case REQ_OP_WRITE_ZEROES:
 		return bio_split_write_zeroes(bio, lim, nr_segs);
+	default:
+		/* other operations can't be split */
+		*nr_segs = 0;
+		return bio;
 	}
 }
 
-- 
2.43.0


