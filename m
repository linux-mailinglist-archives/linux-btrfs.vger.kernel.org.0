Return-Path: <linux-btrfs+bounces-5185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A28CBAE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969AA282D3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F03770EF;
	Wed, 22 May 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F+2SzmEc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C221C6B4
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357826; cv=none; b=XsNTCDXOIh90Mjx4f1ltlRxIIzCYwLLsk59i2C29hwmXud7g6NgPmsswG4yu6uMA/IbxD89s0wrR5HnnxGUPWs8zjaJqhaUM6ReUezDvUlV5HXdUYUlEB0H9kuDTvrK1Z7R2hiorkhfFLwpvd+F+ZvAXe92gOM0gA5IxQaHP9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357826; c=relaxed/simple;
	bh=mqFV2FaVrGXTpH+fUM5qiY8Frwq6H/J1hKtT8VeNFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCM0kTeawpEzmeRIXJVI4WLsE+nKGEmYSZn4LOdS1tKfkyUSueMsw/Ql8QNLJb7Xy7v6y7qjsei47ExW10sNjnX9CCCkjZh36xdCmJFV7Qdvmq/u0AWTQN823pKw4nBw600NsBKbBYv9Koc7C2GJGX8HJQFRFGDHtFAqxczGNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F+2SzmEc; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357825; x=1747893825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqFV2FaVrGXTpH+fUM5qiY8Frwq6H/J1hKtT8VeNFqs=;
  b=F+2SzmEcHgoE8qPzyUtct1VoZSNao3QRtS57aYtjHWrSs8m8ga+cz1RY
   geco4Z3nn3R07fY4a2yiGSa9WXMQ0RJcEX/PDqNk2wcMOUFbyFMgZC39A
   9BbNXWJSdYDdrJ4gP9E/D7Qg/BpFL4S6JQ0a56mkNoGet9LDvge1r+Wiu
   7GtLP0qb7yB9bCMiVHh5pKMDBABn05isyqm+QHzOl4zQeYM+5DcTmXClD
   nKZ0y6iXPqzuHckb3d6WQKAFNcbgCyYkVSbXL/QBzVOjsGkjZhBPM/jBX
   udIwS6DwmzR/ZmnomT7lbvVmadPL3pq5U2pEJGAlkaFD8SIqb8aBrETYz
   A==;
X-CSE-ConnectionGUID: EvNFiAWYSW+VCzte1eMPug==
X-CSE-MsgGUID: yC4oRtUGQO+iGfpllsSc4Q==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16664804"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:42 +0800
IronPort-SDR: 664d7d21_0U7YxcEyt9mVMYvjUgGFuvCu+YsNqDZcqRBeL0lwqfXdpEZ
 vm6UlRxbSGzaPO+ELDK7HDfkeebQBO4ILAYcr1A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:41 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 04/10] btrfs-progs: mkfs: fix minimum size calculation for zoned mode
Date: Wed, 22 May 2024 15:02:26 +0900
Message-ID: <20240522060232.3569226-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
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


