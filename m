Return-Path: <linux-btrfs+bounces-13267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B2A97CF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BFE189E589
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE59D265CC0;
	Wed, 23 Apr 2025 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DMYNN/q7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9026561E
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376271; cv=none; b=Od96aSPZNdIVQ8zFcKqgmGOzjziKvn4eULh0Ylk3K5Vd+WjUwJGr4Y6ncN2wde88HFia0BHjhdFWUkO8x6ZQcPbluAPPr7G5/sZNkcIS6ihssVaZZKb/mqMfyGhrE27OzU1wNxcB2h6cr2uM23BpN8rBeg2NHX/GZEOvlMqR25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376271; c=relaxed/simple;
	bh=813zxvXUM44TW8sPuEhGimwFWVyAp+1AiNuZderhQ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqBVaRP/dw0Dh/0aqDWio8umjND7Q/Yh4lOVaCO8rzAqZqK7gJS/jVoRZfcZbdMC1OEj8eYEOKX+Py34TnnBthXPcb3k/k2qpehbWHhm5n/WDIEtA5CHKmeReim/SodUjcorYnboKXmZjusQS7trbhuGLQeeT9DgBroX5/qq1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DMYNN/q7; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376269; x=1776912269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=813zxvXUM44TW8sPuEhGimwFWVyAp+1AiNuZderhQ+Y=;
  b=DMYNN/q7iZItbVZp2foG+sR9k7gGsV2stasnMPQtCFW5HO9tzOL1ipIV
   heZ7aziqeUWhQ+lgRz1FwwgqpMC5PCslOQp/no8ErLHzn47qt3xQLuZh0
   GqRfjBfiEMM3QZmSZO3Mh1bY7v8Qkr+QLa4euSOXXTNiRHDOAaCbAhTgK
   WLt8HzfivKusrBc642cz9SCnB3TAe26JdYwlObYt2aYxS4L/KjfS/8BXG
   229pCVg2Y8d9Ypds41HYg1GVEbLek03XPqyoVOhFX1czmufHU64h3SK8P
   Gh2uIAPhtFlOff+9ttSttyEHSZEyXiR49ZvowoPzetVCA542gmUiZhT/q
   g==;
X-CSE-ConnectionGUID: r04VAdE+RMS6F90RRDS8og==
X-CSE-MsgGUID: ESlje719TCyUbFYgUZGSWA==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011850"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:25 +0800
IronPort-SDR: 680845f0_QbJWfL98PAv/xZxK65hNnSd+2TBXozY1lxQcomEdZxOrj7Q
 MXsZDNCGevBGdlykN8Mcq4PCXfIxCRA8y45CXyw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:16 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:25 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 11/13] btrfs: use proper data space_info
Date: Wed, 23 Apr 2025 11:43:51 +0900
Message-ID: <a0566b229efbf572d74585f65cb67d0142052e1b.1745375070.git.naohiro.aota@wdc.com>
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

Now that, we have data sub-space for the zoned mode. Tweak some space_info
functions to use proper space_info for a file.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delalloc-space.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index a18895255af9..f7927657e036 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -111,6 +111,15 @@
  *  making error handling and cleanup easier.
  */
 
+static inline struct btrfs_space_info *data_sinfo_for_inode(const struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	if (btrfs_is_zoned(fs_info) && btrfs_is_data_reloc_root(inode->root))
+		return fs_info->data_sinfo->sub_group[SUB_GROUP_DATA_RELOC];
+	return fs_info->data_sinfo;
+}
+
 int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 {
 	struct btrfs_root *root = inode->root;
@@ -123,7 +132,7 @@ int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 	if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	return btrfs_reserve_data_bytes(fs_info->data_sinfo, bytes, flush);
+	return btrfs_reserve_data_bytes(data_sinfo_for_inode(inode), bytes, flush);
 }
 
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
@@ -144,7 +153,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	else if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	ret = btrfs_reserve_data_bytes(fs_info->data_sinfo, len, flush);
+	ret = btrfs_reserve_data_bytes(data_sinfo_for_inode(inode), len, flush);
 	if (ret < 0)
 		return ret;
 
@@ -172,12 +181,10 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_inode *inode,
 					    u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_space_info *data_sinfo;
 
 	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
 
-	data_sinfo = fs_info->data_sinfo;
-	btrfs_space_info_free_bytes_may_use(data_sinfo, len);
+	btrfs_space_info_free_bytes_may_use(data_sinfo_for_inode(inode), len);
 }
 
 /*
-- 
2.49.0


