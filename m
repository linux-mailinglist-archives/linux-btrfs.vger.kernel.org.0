Return-Path: <linux-btrfs+bounces-13089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778FA90671
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED0717475E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEE20013A;
	Wed, 16 Apr 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jwjn8DAc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795171FF1D1
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813724; cv=none; b=PV6qdNKmV/NvVo9l64cJb1M/grbZBubv4vdeKOclsU+bMsNOZhikrib8fMZ/9BvpmxjkurSmqqRTRBENHat0VQjIgEPzQ7t8HeLP55eFhEOPUxawZiZLKZU+Aa2JA2r6Ok+ouNARMDi6H5Tr4OOVuboohJeRg3/diD6dbW6qN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813724; c=relaxed/simple;
	bh=ChdfpV60FnsVHNIDor87O+AvqJAVTlOcC3EH5nkb6Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyTxnVNd2LgVQOZgan+q3aeLS+IuBsLAOKMh2+7vrASTOIirq+P4WktkW7BHSQ4duEXdyjYKTPl2lBRUDFo5w/35ROE2sjZuUKByAVc4mdg9ElW1y9IlVyOFRZWhkMi2N3lY5RdvWLlk+loJHNlOKx/lJB3htsQugcilpRKzbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jwjn8DAc; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813722; x=1776349722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChdfpV60FnsVHNIDor87O+AvqJAVTlOcC3EH5nkb6Ik=;
  b=jwjn8DAcTGwdGizkt7tcDfC0vp5Nj4w3P1AiOA37skOBhRBpMj3M7uCi
   0XxenGmHWGRN3h21MgNtbTSd/w+CBDnpehk6nbRFMMUlbSGf93ZOG4d2a
   V/+6Quw5/YtP9iPNY5JfMF/DVcj0O4A1OvjU6b9q/Lb1EEMiLi8mga+CY
   XkyaBDWsYWb09Ty6O2eifCECsgRvyihgMk+69UCBXv99eiprSfvM7+6gk
   MzLRyKN0pM2R0Xq9iLvOApTyRl7QUSo2m0AKVeH5UgD4CVXyAUCdIqHvc
   14DModXfgXvP3k486QYAsO5qF6pRQiE2vo2M2mMuhs2UjeFY9WV0Q5vPy
   Q==;
X-CSE-ConnectionGUID: rVF9NvzhQQGLEZN7z/Xq4A==
X-CSE-MsgGUID: IZwBM7J0QwyKI/8AsG6Mpg==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484535"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:37 +0800
IronPort-SDR: 67ffb087_CWySzCTiY4PVxjT1Sz67V9KPghQVVZ4EHN8oqx2xdf6Oo50
 agxP5JqkhwBENx58RCKu9tyN8AFnX/fO+C4HJ0Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:40 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:37 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 13/13] btrfs: reclaim from sub-space space_info
Date: Wed, 16 Apr 2025 23:28:18 +0900
Message-ID: <5b85a0d4bed9703a9332abbeb7bfb6802959f369.1744813603.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744813603.git.naohiro.aota@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify btrfs_async_{data,metadata}_reclaim() to run the reclaim process on
the sub-spaces as well.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 62dc69322b80..0f543e3cb2fe 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1221,6 +1221,9 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	do_async_reclaim_metadata_space(space_info);
+	for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++)
+		if (space_info->sub_group[i])
+			do_async_reclaim_metadata_space(space_info->sub_group[i]);
 }
 
 /*
@@ -1449,6 +1452,9 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	fs_info = container_of(work, struct btrfs_fs_info, async_data_reclaim_work);
 	space_info = fs_info->data_sinfo;
 	do_async_reclaim_data_space(space_info);
+	for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++)
+		if (space_info->sub_group[i])
+			do_async_reclaim_data_space(space_info->sub_group[i]);
 }
 
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
-- 
2.49.0


