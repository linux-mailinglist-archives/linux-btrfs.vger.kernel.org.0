Return-Path: <linux-btrfs+bounces-12417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DE3A684FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CC542383D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB552505CF;
	Wed, 19 Mar 2025 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EBCaX5rM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393052505AD
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364913; cv=none; b=XKchGppnrC9xPUga4kPJEN6lXwuhX22hjRIARmkAlr5P5XJZjSvgzkMTaQBN/ynZZfFmK6BWx22aTgtBcPm8MdwTzQgt+ml0BVEVHxLSQ9ux7JSUXlNz+B/UVDYxrtfLdBZCRvpTFpv3RYnSk+9kfQBnrtiHvFAUktmK8887DT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364913; c=relaxed/simple;
	bh=NPEdKFR4ehVmYWSr4OrNJ2mvYC7ZLsfWsbvT9Pj2PXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWO7ftorwxu85CdO4mHYUnST5OUIW1IBZm49DyVWhLA7q2kpUpWZ0Yb/X8QQ2SvG50Az+BMe4hEQamoBk3Eg+ARYNWXwfbFzMrW07UpnTnwyW/219WfiYLzTac8rKdfRMzfDsu421KJlE02cfB6MEDooqoQMyH+PT0k4u9sWkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EBCaX5rM; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364912; x=1773900912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPEdKFR4ehVmYWSr4OrNJ2mvYC7ZLsfWsbvT9Pj2PXY=;
  b=EBCaX5rM8PUg4obuKhGLnyNjxJbCUCBOdu/Wce3q8dy4qp3YhK1uxH9c
   MmlsKfiKWc6P8T0yTNClnYTGhpqW4TD/o24v7iKIcReNCieUMJ8syitJx
   0F0JUiQ2sntH8Wy6s+2AGHqO6eFCwJdAFAp7AfBMFCqro/pO5Z0kF2sUo
   0tY9qiQXFUEZNqjmry/tpKTJTYCT2rifNrIqbgnhN7H3NubH3KMFXrVYL
   m7eV7h0WOsy/BP69F25/n/it8tkvDl087IqGvi++jeXX6HAY43ICvWY+3
   xf/pbrRqBg0SPK4c2ucOfvDQ7HlvNlQyXwtDsD0PQxL2cqfhnrBSiDh2A
   Q==;
X-CSE-ConnectionGUID: 3u/298NHQz+Vj8ftdu4DUQ==
X-CSE-MsgGUID: XiMNZXA8Tb6wwv/nbs2UVA==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227294"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:10 +0800
IronPort-SDR: 67da530e_TwgB6988F0PwJ/RzjCqPPBKaQCXWRUEIHDh5SfyALcmr9Ky
 R3h8FlL4QPugCxOel5R9UFY5VLLF5NIEABdiqBQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:59 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:09 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 13/13] btrfs: reclaim from sub-space space_info
Date: Wed, 19 Mar 2025 15:14:44 +0900
Message-ID: <5c116a0feffc7f87845a00fd840fb4f7be52f906.1742364593.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742364593.git.naohiro.aota@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 730763be4276..951d3984ea5a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1215,6 +1215,9 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	do_async_reclaim_metadata_space(space_info);
+	for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++)
+		if (space_info->sub_group[i])
+			do_async_reclaim_metadata_space(space_info->sub_group[i]);
 }
 
 /*
@@ -1443,6 +1446,9 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
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


