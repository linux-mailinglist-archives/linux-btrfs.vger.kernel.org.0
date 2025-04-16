Return-Path: <linux-btrfs+bounces-13078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B7A90676
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324971898FD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A51EDA23;
	Wed, 16 Apr 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BvBXPEv4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A41DDA31
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813717; cv=none; b=X3Zh4iP7wQsIRTNM7nKl1uQrXTic3uLQ6nMKMXVThJrDtkpBsT3lUsu6ppV01F6i12tYRCb+aLAzt3NOH8Nl0LMREhwB0v2dwPeCCiPGpAwwUuJSK02qwjxLXXx20kKfOe3bQpSodKSUMnWbNsDFPZ7hQ/C65sVPlK3kiPvKJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813717; c=relaxed/simple;
	bh=/pz5QIt977haPHt4u/HdU+p4ARPhasKV2YRKEe/vTr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq1m6XdbIHMpE+p6k19v/YtE/k97n43Rj0xsOGBoDlFnE5gnZ4ybAgrLvGT0vrfQUkcMY+Q16LZezdgHnKwIitA/AZUvzm7h+dcRDPzRNoeVf58iE8w4EC0NXqGbbiZ7uKWpUIKOv5aGMCz+fZZ5XOPqCGMoDK3hM0O2EAc9g4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BvBXPEv4; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813716; x=1776349716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pz5QIt977haPHt4u/HdU+p4ARPhasKV2YRKEe/vTr0=;
  b=BvBXPEv4Ozc0E7mIHnckKbdlR/TX1bpSZJh7XXS7ACHQ5fnTjWb9VBYb
   GNDBNSB4luv7cv/TOiOf38UpQ/LrvVj02JnDvQScQzVrZB2gDWLTgGFDy
   bz6PqX0+piWT6ba4TFQrcLO42fvUZ0yx8vHBvUQS8CWVto7thCuJmglX9
   pBDiwAKbT+30HNqzPyirxF/XZEQmH+vGKQWy8QYJa17dL0y9T8HTcvh+O
   azKPDrQFNhdQArl0pqipL+/yQEFtNMvbNYWB0MsK3gHcrNh35A7YdaRYI
   ZCWOUMBnHBSyusGO41AFGLWeCTNZhgu4wlkw/QGD4BHLmLIpofMV9UAAw
   g==;
X-CSE-ConnectionGUID: yn3OdADNSDycXsoyb+2j1Q==
X-CSE-MsgGUID: MZ0NjrJlQKiZgtyA1aZRsg==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484520"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:29 +0800
IronPort-SDR: 67ffb07f_ybGX+8q9U/CrSsWK84hCwY4qj6lLpJM5uv46h465YcH1Gfc
 TMFCZ0PZ2OMBh2e63BWcgiunAOVm+smD7/MbDtg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:32 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:28 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 03/13] btrfs: factor out init_space_info()
Date: Wed, 16 Apr 2025 23:28:08 +0900
Message-ID: <75d34a6de9baa6d5aa98f43e184906beb66e649c.1744813603.git.naohiro.aota@wdc.com>
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

Factor out initialization of the space_info struct, which is used in a
later patch. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3bb7246f40fa..7334ffa67a86 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -234,19 +234,11 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 	WRITE_ONCE(space_info->chunk_size, chunk_size);
 }
 
-static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+static void init_space_info(struct btrfs_fs_info *info,
+			    struct btrfs_space_info *space_info, u64 flags)
 {
-
-	struct btrfs_space_info *space_info;
-	int i;
-	int ret;
-
-	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
-	if (!space_info)
-		return -ENOMEM;
-
 	space_info->fs_info = info;
-	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
 	spin_lock_init(&space_info->lock);
@@ -260,6 +252,19 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
+}
+
+static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+{
+
+	struct btrfs_space_info *space_info;
+	int ret;
+
+	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
+	if (!space_info)
+		return -ENOMEM;
+
+	init_space_info(info, space_info, flags);
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
-- 
2.49.0


