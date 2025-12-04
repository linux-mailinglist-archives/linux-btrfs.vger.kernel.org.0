Return-Path: <linux-btrfs+bounces-19524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AE8CA3A5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 13:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421F23093A83
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C42FDC29;
	Thu,  4 Dec 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DjWT313j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379B33F8B4
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852229; cv=none; b=lBNJ+90C59szmzq/tnsG9OKg+Asjo8PNegPoan28zd8D4yyoN0tEmqjC0qKyriYceiVXR5FG7VkpKqqEl7gYwKF/KD1hjZJKykiIRtxrWay/j9ascOI3AA44T88wyyehNFAsKA7qs9gyZg/ZDofu47qdVbNbhOhDj34KSkMHqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852229; c=relaxed/simple;
	bh=gRgMPpWw1WX2+CmMbXR5XKTvN9Bki+hWY7ngamQRjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QivUdVOdso2/Ydyv9MOb/VGah6rNexiGdLVKzmSp38qjSmo8jalvnL2CTDi1bC/HyCIgtb/aTS12NPtA1zyvUziiDNzdnKsV6OfUWdmHoGIqhf4oarhBGOHCAqBu8hgguCYvbJyiRlfyl5SxGuviJAB/uxQvM3JnyXLEKSEVI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DjWT313j; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764852227; x=1796388227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRgMPpWw1WX2+CmMbXR5XKTvN9Bki+hWY7ngamQRjdM=;
  b=DjWT313j3k6ezT5Jz66EiMtx7pITwc6DXcChx+eg0EQr7imQK8ipR8IT
   FpzN+ts8LE4JvQba7MRbDAqV5FeVfaNQZromGOJrHEu2lkQWo1asSa46w
   ZOROa03tZiWxzSiwz+Ew/MnpEY0AMZ1PiPBB/EqKQbVyeSh2UJdGrdffR
   863r3f1qvSmZHptKkUctBctdb9PotYWMJTo3m0JX3w7BuOxNsZpA7h2Or
   TDvv9CH+S24SRGBFfWPgpg0dziHg/3ofTO86X7ci2Zdz7Y0MGAf5kYGQ4
   E/H3tDPbvl7Wyh1MAhI7evjxf81W/fSxy+Ieho20itDAIM5hNNo2Xgg1j
   g==;
X-CSE-ConnectionGUID: HIRHsPFtSYOMGdn3VBi+gw==
X-CSE-MsgGUID: 1mlEp1hlTrizZT9AGnU78w==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137266140"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2025 20:42:46 +0800
IronPort-SDR: 693181c6_tIreq7qyuBRh0ihSZ+Wcq+pPBSelgCRrmV0pw8eYVXVSpnI
 yiAymZW+V3BhxgusbrD8Dd2IxuKjmBwVMPxMifw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 04:42:46 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2025 04:42:44 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 5/5] btrfs: move btrfs_bio::can_use_append into flags
Date: Thu,  4 Dec 2025 13:42:27 +0100
Message-ID: <20251204124227.431678-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove struct btrfs_bio's can_use_append field and move it as a flag into
the newly introduced flags member of struct btrfs_bio.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 9 +++++----
 fs/btrfs/bio.h | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a1b0dd8b08f5..ad7e930e4bd0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -499,7 +499,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	 * For zone append writing, bi_sector must point the beginning of the
 	 * zone
 	 */
-	if (btrfs_bio(bio)->can_use_append &&
+	if (btrfs_bio(bio)->flags & BTRFS_BIO_CAN_USE_APPEND &&
 	    btrfs_dev_is_sequential(dev, physical)) {
 		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
@@ -781,10 +781,11 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
 		bbio->orig_logical = logical;
 
-	bbio->can_use_append = btrfs_use_zone_append(bbio);
+	if (btrfs_use_zone_append(bbio))
+		bbio->flags |= BTRFS_BIO_CAN_USE_APPEND;
 
 	map_length = min(map_length, length);
-	if (bbio->can_use_append)
+	if (bbio->flags & BTRFS_BIO_CAN_USE_APPEND)
 		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
@@ -839,7 +840,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			status = errno_to_blk_status(ret);
 			if (status)
 				goto fail;
-		} else if (bbio->can_use_append ||
+		} else if (bbio->flags & BTRFS_BIO_CAN_USE_APPEND ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index d523929b4538..410a500144c1 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -29,6 +29,8 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 #define BTRFS_BIO_IS_SCRUB			(1 << 1)
 /* Whether the csum generation for data write is async. */
 #define BTRFS_BIO_ASYNC_CSUM			(1 << 2)
+/* Whether the bio is written using zone append. */
+#define BTRFS_BIO_CAN_USE_APPEND		(1 << 3)
 
 /*
  * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
@@ -92,9 +94,6 @@ struct btrfs_bio {
 
 	unsigned int flags;
 
-	/* Whether the bio is written using zone append. */
-	bool can_use_append;
-
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
-- 
2.52.0


