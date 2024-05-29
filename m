Return-Path: <linux-btrfs+bounces-5341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F48D2DE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7291F21A37
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1CA16727F;
	Wed, 29 May 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OSJ5kMGk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17F1667DA
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966821; cv=none; b=AoSl47fV4DRN7spkMD92xt3WyE1xSVmqTE43eHDSBqcpanwcXEqK6kx62z/kWK5e/pgtYxLInYRWqR67cnwLMkvPgkJy+OSwkBJtGZvVJIWac0q7lm2UjYTPGd/NKhPr/KB++pdeU2/1W2xS/Ay9iFIW0o3QDz9W+VuKZpw/1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966821; c=relaxed/simple;
	bh=sK5HygYz82g58csk+V4jliSzvR7Yv75tsP9OE+BH2WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBOTCHvmB6V0v8HfwihmobBQsgGj8eOpeXhX06/tlRmXTgBC4w8V/6fNT2QzGmkkDGgbrjnuSH9ufpl7+ow+W6P/W7RdQVgmPfMQ39B13eSmG4pQbzQBPWpihfcfbLPiQE2ZH91amIxGrq3+iN/XxBxSaYwzUzzQNtoALVcbphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OSJ5kMGk; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966820; x=1748502820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sK5HygYz82g58csk+V4jliSzvR7Yv75tsP9OE+BH2WA=;
  b=OSJ5kMGkNByUw4k9jLCwzFBekostNt4L0Qkcy0Dfu/10sjAwkmUY/+jW
   CXr1HmYrWJi9ayiKJmb1TiOA8SqguWrhZdchJClKdyKntglM5oFoWTsQJ
   6TjUqkEK1ZojRM4u7qHw1mMKz9vm7iKKzN384xGPirYDLxFQdG9pI6HTS
   OnTgKzqqIt7nAkhyoPhEoRQRFJI4wSVZEWyYLv25x1t/gljxo2ibqwVyr
   RWmTlrVDnAr37iZCtIoHw4JlJdf9QUByrlsap9iNQLM8B/nOv6fzqZfg8
   w4+XAnOIVKOXLFysSxtqJjAljIu7cnJxjdygyTcDf67c6F0BOmU1hdU9z
   w==;
X-CSE-ConnectionGUID: EZrOuzUwRI2EFSimbKvAZQ==
X-CSE-MsgGUID: hdWqX4YNQEGDom88LoSbkA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865344"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:33 +0800
IronPort-SDR: 6656c94d_XfDv6LWJCVs+UEfMphEjM1kB7/57M8Z98NbeXVgotcvEHTf
 wnB4Zo7Og+8nMBl7tBhaKOigiA+O46tB18Q7blQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:02 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:33 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 04/10] btrfs-progs: mkfs: fix minimum size calculation for zoned mode
Date: Wed, 29 May 2024 16:13:19 +0900
Message-ID: <20240529071325.940910-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we check if a device is larger than 5 zones to determine we can
create btrfs on the device or not. Actually, we need more zones to create
DUP block groups, so it fails with "ERROR: not enough free space to
allocate chunk". Implement proper support for non-SINGLE profile.

Also, current code does not ensure we can create tree-log BG and data
relocation BG, which are essential for the real usage. Count them as
requirement too.

The calculation for a regular btrfs is also adjusted to use dev_stripes
style.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 67 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 2550c2219c90..1b09c8b1a673 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -817,15 +817,50 @@ u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile
 	u64 reserved = 0;
 	u64 meta_size;
 	u64 data_size;
+	u64 dev_stripes;
 
-	/*
-	 * 2 zones for the primary superblock
-	 * 1 zone for the system block group
-	 * 1 zone for a metadata block group
-	 * 1 zone for a data block group
-	 */
-	if (zone_size)
-		return 5 * zone_size;
+	if (zone_size) {
+		/* 2 zones for the primary superblock. */
+		reserved += 2 * zone_size;
+
+		/*
+		 * 1 zone each for the initial SINGLE system, SINGLE
+		 * metadata, and SINGLE data block group
+		 */
+		reserved += 3 * zone_size;
+
+		/*
+		 * On non-SINGLE profile, we need to add real system and
+		 * metadata block group. And, we also need to add a space
+		 * for a tree-log block group.
+		 *
+		 * SINGLE profile can reuse the initial block groups and
+		 * only need to add a tree-log block group
+		 */
+		dev_stripes = (meta_profile & BTRFS_BLOCK_GROUP_DUP) ? 2 : 1;
+		if (meta_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
+			meta_size = 3 * dev_stripes * zone_size;
+		else
+			meta_size = dev_stripes * zone_size;
+		reserved += meta_size;
+
+		/*
+		 * On non-SINGLE profile, we need to add real data block
+		 * group. And, we also need to add a space for a data
+		 * relocation block group.
+		 *
+		 * SINGLE profile can reuse the initial block groups and
+		 * only need to add a data relocation block group.
+		 */
+		dev_stripes = (data_profile & BTRFS_BLOCK_GROUP_DUP) ? 2 : 1;
+		if (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
+			data_size = 2 * dev_stripes * zone_size;
+		else
+			data_size = dev_stripes * zone_size;
+		reserved += data_size;
+
+		return reserved;
+	}
 
 	if (mixed)
 		return 2 * (BTRFS_MKFS_SYSTEM_GROUP_SIZE +
@@ -863,22 +898,18 @@ u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile
 	 *
 	 * And use the stripe size to calculate its physical used space.
 	 */
+	dev_stripes = (meta_profile & BTRFS_BLOCK_GROUP_DUP) ? 2 : 1;
 	if (meta_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
-		meta_size = SZ_8M + SZ_32M;
+		meta_size = dev_stripes * (SZ_8M + SZ_32M);
 	else
-		meta_size = SZ_8M + SZ_8M;
-	/* For DUP/metadata,  2 stripes on one disk */
-	if (meta_profile & BTRFS_BLOCK_GROUP_DUP)
-		meta_size *= 2;
+		meta_size = dev_stripes * (SZ_8M + SZ_8M);
 	reserved += meta_size;
 
+	dev_stripes = (data_profile & BTRFS_BLOCK_GROUP_DUP) ? 2 : 1;
 	if (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
-		data_size = SZ_64M;
+		data_size = dev_stripes * SZ_64M;
 	else
-		data_size = SZ_8M;
-	/* For DUP/data,  2 stripes on one disk */
-	if (data_profile & BTRFS_BLOCK_GROUP_DUP)
-		data_size *= 2;
+		data_size = dev_stripes * SZ_8M;
 	reserved += data_size;
 
 	return reserved;
-- 
2.45.1


