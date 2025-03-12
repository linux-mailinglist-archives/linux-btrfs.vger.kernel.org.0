Return-Path: <linux-btrfs+bounces-12212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12BA5D40D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 02:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20FB3AC1A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 01:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B342D600;
	Wed, 12 Mar 2025 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PTArkt8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B463595E;
	Wed, 12 Mar 2025 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743143; cv=none; b=HxFX6OBwzfWDx9k9bYgVV8KYMmrrWFypctJW7yL6MQybRXtYefZXWE7G9QWaH9waB40+e9nzmoOCRasHnMJRuU4PwJ9sP7nwq31DQ1mHVLpESU3kjONTsMjA1Ph/tVR4ttAQimqyYpnxi5TdzP2tpkYrHqNmGK6yLsF1kZtlWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743143; c=relaxed/simple;
	bh=uLPuNz7XvpQYueNiV/1nVgmCfxbdbLJM8jImw0ei8yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vcw54qvRmAZp3igrAxUwYutqcGNJ4nMU+NAcsux3WUDW6Abasfg9k5ZlSMQGJjP+7u1aR+rbSB6kvCQuzIet9oamwaUccLeVT6Ovx8bz2nx4HCyK8Xent6c/PvaqZiwlnQzNe3sWVsgXuqakdck/CIgKE0+DS6qHERSfU65YiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PTArkt8N; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741743141; x=1773279141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLPuNz7XvpQYueNiV/1nVgmCfxbdbLJM8jImw0ei8yo=;
  b=PTArkt8Ntn0TPpsaoxEwSnVYYwcqUNffJaXufCi74mbHahONsO2yAY8V
   4QTdv++VV/8gUzcX6ZwQwTuPyl0PInuGlX2q6HstiFBKR0fUrXVoQs/U8
   WHlylyd6RSrvbZjO0lNDmo88Y3kiGsZsVB5dRF0k+cNp/0lOYxUWtep+D
   nm1LMPGOdO2nDsTwyuHZPH7oeE7EmtVAOauSKKV5a0l2rr4xSHqPHyIxE
   wAVt0V4gnSyiw6/ZHVzPtuQuyKpXSxXqcrLbLwD/EdT5EUy3C8R+rwcWN
   q1D7hKwYOhPuVtFM6x/6b5CgmiFxeoglXE4l+OsOMyE0ypoyfzx6vmKZY
   w==;
X-CSE-ConnectionGUID: rjLty0GBRhyEOx2WkWPPPw==
X-CSE-MsgGUID: zcS78Xm0T6WXCC5qRX1WgA==
X-IronPort-AV: E=Sophos;i="6.14,240,1736784000"; 
   d="scan'208";a="48299247"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 09:32:19 +0800
IronPort-SDR: 67d0d64d_+JA2ozYmX97rDP79+qmrnE127owXdHEXdM8+u5d9WTKTCBT
 6njVAbzDoUZtlOjwTZUm3QCCRlXwAEVfgL4DeVw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 17:33:17 -0700
WDCIronportException: Internal
Received: from hy1cl13.ad.shared (HELO naota-xeon..) ([10.224.109.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Mar 2025 18:32:18 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] block: introduce zone capacity helper
Date: Wed, 12 Mar 2025 10:31:03 +0900
Message-ID: <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741596325.git.naohiro.aota@wdc.com>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

{bdev,disk}_zone_capacity() takes block_device or gendisk and sector position
and returns the zone capacity of the corresponding zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/linux/blkdev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d37751789bf5..3c860a0cf339 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -826,6 +826,27 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
 		(sb->s_blocksize_bits - SECTOR_SHIFT);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)
+{
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
+	if (pos + zone_sectors >= get_capacity(disk))
+		return disk->last_zone_capacity;
+	return disk->zone_capacity;
+}
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)
+{
+	return 0;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+static inline unsigned int bdev_zone_capacity(struct block_device *bdev, sector_t pos)
+{
+	return disk_zone_capacity(bdev->bd_disk, pos);
+}
+
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 
 void put_disk(struct gendisk *disk);
-- 
2.48.1


