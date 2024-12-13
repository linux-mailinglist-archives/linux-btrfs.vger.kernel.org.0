Return-Path: <linux-btrfs+bounces-10336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA89F04FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4547A282CF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 06:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CC18D64B;
	Fri, 13 Dec 2024 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LE4nV1zc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBC15383B
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072230; cv=none; b=pgqDp/8q513xciZK7AP49HnAW4IvG2uTsIhayUgV+OnyNNziu2dnyWk/z1yV0gW6Z1FJ67XYlbXl9JNbI/AO68rUoQmICFa9q9QH5TuTJpHITBs4KO8BqQ2ZfUWDTWFX4uhN0Md4jUQM14SOTUJsbeNHcPk2Z5MRPxczP9c1M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072230; c=relaxed/simple;
	bh=YDcobXsAQA7a5PIYmBDuJ3sAeEqAbZBjNmu8+YWh8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpYz/2XlZdnz/jZMPR0KmBxLBVF4qMZ8WsbMfyy6NLcLiOGPB04TeaVErztRcVLmlTYpj873eSRP4wq/fgeu1uaHsI8uCdH7j3nYZdYWOVOq7reyk1kVin8bhgfe9GD7Sswc59pPzfMNXe18I4iLl4JKD+GsnB5gPCxcdWxSUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LE4nV1zc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5O92+9ZK7UmB5mjBADuqtRFdCP+hS2YYDiibt+uigU4=; b=LE4nV1zcJHYik3v2hCxaXVjuo/
	ujO0qFnK+KTrQ9k5tHdd7CPiBipTymbZeaDBZFWR0bRkFrmsUiNkfcqTktuXcqs+ykd7OpL9wHRmV
	N/xxmeCRGH3U8PxCeYM1XzDQs1zhlDA6p41NFXtKRdnshJ9IJXGAYjFt4lEwqAjtOJYLly4MLMuKo
	pNYUPva+9GPtw7v2A7hnjV85YGUKzAX/clNMEucQx6/O9KHuiC8hNBZSufNsHqRRoHvUGp0SjOGdu
	JhB0tOHrrblTMVxaWaL0uN5VLBwfdlfpdt2Mb+5nmRDaPDUCt5W7P7ZMmcYYO4M0wD3TqGjN3EJK+
	DtsIY+Lg==;
Received: from [2001:4bb8:2c1:cac8:66da:99da:62a9:d488] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzOs-00000002tJM-2Kls;
	Fri, 13 Dec 2024 06:43:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: naohiro.aota@wdc.com,
	linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: zoned: calculate max_extent_size properly on non-zoned setup
Date: Fri, 13 Dec 2024 07:43:43 +0100
Message-ID: <20241213064343.1498094-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Since commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors"),
queue_limits's max_zone_append_sectors is default to be 0 and it is only
updated when there is a zoned device. So, we have
lim->max_zone_append_sectors = 0 when there is no zoned device in the
filesystem.

That leads to fs_info->max_zone_append_size and thus
fs_info->max_extent_size to be 0, which is wrong and can for example
lead to a divide by zero in count_max_extents().

Fix this by only capping fs_info->max_extent_size to
fs_info->max_zone_append_size when it is non-zero.

Based on a patch from Naohiro Aota <naohiro.aota@wdc.com>, from which
much of this commit message is stolen as well.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 11ed523e528e..27f4472fb559 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -748,8 +748,9 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		     (u64)lim->max_segments << PAGE_SHIFT),
 		fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
-	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
-		fs_info->max_extent_size = fs_info->max_zone_append_size;
+
+	fs_info->max_extent_size = min_not_zero(fs_info->max_extent_size,
+			fs_info->max_zone_append_size);
 
 	/*
 	 * Check mount options here, because we might change fs_info->zoned
-- 
2.45.2


