Return-Path: <linux-btrfs+bounces-13269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D0A97CF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC493BFECE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD8265CD0;
	Wed, 23 Apr 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O9vmPPbJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAC265CAD
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376272; cv=none; b=pK/jaUtue7q14uR5n/h08NlDsCs/ZQgGkWA2NbXbHbYfdekt35u2k3rqmbLyK647Qx1IwMffpJtKFPqJ9zMUk6zN8KvWzVHq8uojvqDJfbQEzpQezkzE0NtaO8NdYdAFblZrGad8zHNKqxIokuciPJyfhG4CvhyakYlrQMav+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376272; c=relaxed/simple;
	bh=BQAz1lqZ9/UWozD5xiwBRRlpawMPG3E6/DUqFo9gaVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGU5FqpBsOr7/thcLV0ssArofuv8sWO6+i7yTXH1iErIIYGb/+EtiUwNPCpsPST6iSPjT0k8kL2p5XWReg2mID4c3k/EDthljvVUKJkR3EqYYXMnm+MJFfN5QyrPl873Dra4GN1sRMCycQUHUkmMt517AgnMVElQZLO9IAKECsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O9vmPPbJ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376270; x=1776912270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BQAz1lqZ9/UWozD5xiwBRRlpawMPG3E6/DUqFo9gaVc=;
  b=O9vmPPbJn1/FEtObcE/U2+Wd9HRHliVlon2VWekEdJdEYxyhdqrWBV+k
   loCoF8AGgNWdQiNGryJn7DCX36mnBfGaqfiUMR7otOoddszcsTzJcH15/
   km96T+EU++j/eN8wt7g/UraVCJTbD5d6/N4a1iuQMt5w+uqW7Jkjh3/E9
   iXAnF2+maxsdCK8hP/JDFEdhbNEoaKZz7ZSQn6OVk3a7Hq8dbSV2yFwLQ
   nALhoyKw2Ra7l6n30lB3ygLEKZXl7GWrN/MbD7qZDDf1WoG2lT+28lGWE
   KFN6PwFWZ07i2QOqy0sUi35Sit5Eo6YTnD9T+NNBXCafcoC6Jkd4UdeBp
   Q==;
X-CSE-ConnectionGUID: RO8CbBSWRKuitTYciruyOg==
X-CSE-MsgGUID: x9FMFnueTjubCTKLiUBT1Q==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011854"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:27 +0800
IronPort-SDR: 680845f2_AGqYbOh8fdqGcLVjIvT/RJPbxg/pco1T75+9TN2WOYDF7jx
 aE767tistuzBUXVeIfnPn8heqUoWpQyBP+ImcCQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:18 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:27 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 13/13] btrfs: reclaim from sub-space space_info
Date: Wed, 23 Apr 2025 11:43:53 +0900
Message-ID: <e8f33a754e5d47d031e0056158df93756a11b5c5.1745375070.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745375070.git.naohiro.aota@wdc.com>
References: <cover.1745375070.git.naohiro.aota@wdc.com>
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
 fs/btrfs/space-info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1205588b6234..867092de09d1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1223,6 +1223,10 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	do_async_reclaim_metadata_space(space_info);
+	for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++) {
+		if (space_info->sub_group[i])
+			do_async_reclaim_metadata_space(space_info->sub_group[i]);
+	}
 }
 
 /*
@@ -1451,6 +1455,9 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
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


