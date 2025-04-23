Return-Path: <linux-btrfs+bounces-13258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC034A97CE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158631786D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82878264A71;
	Wed, 23 Apr 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G1WovY60"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEF26460F
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376265; cv=none; b=WteEdWaz5G8hMnlYEwNkAorWKbqKM4p+0vbnxWKdl9+vEU8m78sbvHsPT1rDbp5teGGg1Vy9reIiMPeQp8cZx97ogTmA6ty7Dd89XFOLb7eOrWFgdthmEfNAmWJdTEy+1v4pffcsQq+NAZR50zY33pVnCVwLC3zCff42GnvEv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376265; c=relaxed/simple;
	bh=/pz5QIt977haPHt4u/HdU+p4ARPhasKV2YRKEe/vTr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpTpouFG3wvvNAZ0At1v7MnzeH7zzXyKj04Pg2evW10jCXxVtZbYi4oaJdbUrJg+PNVaUhxoaS+M64BhhlfbZqIjrHmZMWn+hkVP8hI1l5BgwHBdgXSIYKYxg1ccUJy7Q5TRBfXm3DO8MxpvaGlYRinOUr+8yLwPD2O2zjszYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G1WovY60; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376264; x=1776912264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pz5QIt977haPHt4u/HdU+p4ARPhasKV2YRKEe/vTr0=;
  b=G1WovY60/N+QJBUNnt+dWe7Pc3sBgczXwJsAFwGU7EGwCAoqZGpZV6WF
   N8gxV/SvIMWu5xvVhQIN02FQ7yne58i1Py/95QrrUB9Gddo+HQtnWGXxL
   B4IwvG83uuRVJOXpZndHifUZSoFe4+pZKzN0TyFz6i2yKbkqKPLMoHXKr
   hCSiGhv5c1EcH4MF2iDsLksjfGo7sfLL6XgvAwsTQl60l4MkmT3TB72JY
   lZe1pmd4xzIdCX2wn4SNX6r3Drx9HBENPW1S4SwMxo9fCd5pt1WX5YuL3
   VyBSTn2H7Aqyry+m+b9LPpsYoqEN6rU6TS2CiYeCv+n7/5J8SLMehpQxm
   A==;
X-CSE-ConnectionGUID: qnUakXyuS3auKkNa0w24hA==
X-CSE-MsgGUID: uVQcPGyCSMS9k4oDzx/dqw==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011836"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:17 +0800
IronPort-SDR: 680845e9_p7uleu6+66XXsRcpDeEvb/70lZOFdXIdzTzND3YYbhc5qnM
 s8nIocNpYVe6ueyqAgylcC3fvat/lFNp3m1XjZA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:09 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:17 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 03/13] btrfs: factor out init_space_info()
Date: Wed, 23 Apr 2025 11:43:43 +0900
Message-ID: <78453de08808239e022388789b49f574e287478a.1745375070.git.naohiro.aota@wdc.com>
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


