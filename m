Return-Path: <linux-btrfs+bounces-12416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB38A684FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF71C4263C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900A24EF91;
	Wed, 19 Mar 2025 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wb2ESHEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E082505BD
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364913; cv=none; b=tyyos1Gi7slIgSWAv36AgNAptMT0c7n6cacqtIumKOadw95gZT4/GNCP0w+QW9vJrp4Xqc15jZkrk/FfmZPfsquE5V1tW8G/NnDm2EtLrUB1bld3yxZWttdkjaush00L8F/5M5IjUNw45gz4sxzDqhTxSyRQ1z2iHINxJYaozbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364913; c=relaxed/simple;
	bh=PP20KYXQuXdEGmKx31+7Ec6b51hIATsjKSFw2oysyx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbh17t1RwRcFE2i0WgFvhoZw8IGE1b6DxEfo5cJpbbEdeLcoIYMCm0dl4rs6qYrddWkfFt6tDWT68rNdafmJYeQ+poqLZQKDgdUuI0J/tkvPdwIue7c2rkzKUoKg4K2dNB9dFo3tVLm5pY2C9z6mbPCCybAunxL8CfGcfz8gyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Wb2ESHEB; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364911; x=1773900911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PP20KYXQuXdEGmKx31+7Ec6b51hIATsjKSFw2oysyx4=;
  b=Wb2ESHEBXn2cUMX7noJSgYhDLVbrXxBhtNoFFjiame374ZFI1RrXhYmK
   WD1UhPZ80ka1ENnAXUBJzmUcR0TnBTFbt896j/ChBASEQJnHKCpjKecG1
   PhrhCH7YLmtotHKXniuQWaOBcTbS5lmktjqwZ3H9On2iUX2hhTwyMeJKv
   voXai68VJj9ikGOak699LJYjbsmqE4ThOAviRotFd9qI+pcSlYp0nH5mT
   9E+puVjrhMWS4D6LTicjmdcFRYn35crSVJ7VItTtemukR1MyRJrb22WAW
   wKL8S6QWUjRJpE1B7fDkrhIM591atDrWkNrum+/VQEsmAgFDdX5sBT46m
   Q==;
X-CSE-ConnectionGUID: 1VZrDFV+RzaK07Vnk9+EZA==
X-CSE-MsgGUID: 0FGEJmHwQMuSYl3yuKSaaA==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227262"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:08 +0800
IronPort-SDR: 67da530c_9iPX9lnVrBo01kKfrNJ0WEk9V2y3QLxR+sGW/PZTk676hKK
 QYZdxRbNSpO3TGlIXFg98mY4KQXbppGbtqpfFBQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:57 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:07 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 11/13] btrfs: use proper data space_info
Date: Wed, 19 Mar 2025 15:14:42 +0900
Message-ID: <54c32cd875f589527ee25f9b0e9ff82a90c66d7b.1742364593.git.naohiro.aota@wdc.com>
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

Now that, we have data sub-space for the zoned mode. This commit tweaks
some space_info functions to use proper space_info for a file.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/delalloc-space.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 918ba2ab1d5f..4cffac85ff54 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -111,6 +111,17 @@
  *  making error handling and cleanup easier.
  */
 
+static inline struct btrfs_space_info *data_sinfo_for_inode(const struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	if (!btrfs_is_zoned(fs_info))
+		return fs_info->data_sinfo;
+	if (btrfs_is_data_reloc_root(inode->root))
+		return fs_info->data_sinfo->sub_group[SUB_GROUP_DATA_RELOC];
+	return fs_info->data_sinfo;
+}
+
 int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 {
 	struct btrfs_root *root = inode->root;
@@ -123,7 +134,7 @@ int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 	if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	return btrfs_reserve_data_bytes(fs_info->data_sinfo, bytes, flush);
+	return btrfs_reserve_data_bytes(data_sinfo_for_inode(inode), bytes, flush);
 }
 
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
@@ -144,7 +155,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	else if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	ret = btrfs_reserve_data_bytes(fs_info->data_sinfo, len, flush);
+	ret = btrfs_reserve_data_bytes(data_sinfo_for_inode(inode), len, flush);
 	if (ret < 0)
 		return ret;
 
@@ -172,12 +183,10 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_inode *inode,
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


