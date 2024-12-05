Return-Path: <linux-btrfs+bounces-10073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B29E4EE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841D318819A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F291C4A07;
	Thu,  5 Dec 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U0Odgy0i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE51B6CF5
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384969; cv=none; b=fnQyHDdZQ690Tm2ta+hxI4ORUcHPJwRfQmkACMXUaO/XLxRHA2l3KLH3zMrd+qB11TimqUF+QvFCAHXV6bSgfRQio14WR7oJ3Y/xEkMed/i3XrF2GiY+T0Pr8gvdSYpHyCTKrAcMo/jlVfRZ7dE7R6Fzm7fEr3y6NXAYCEqoeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384969; c=relaxed/simple;
	bh=Yg0/ZKYktG7fEObUSD/PxEuyOeGev+Ml7YIOtl0mV1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK+1E10H5/zzqVpa6fFA+5vt2/baBGbQrdqcuqKS4E6C7CCioHiosxvDI2bXKZzcC6f9h2Jy4Cz8QxF3brS1OW+Rep58F9NeGDwUPY2jUXHxJT4dSYW7Ci//3frcgGuEQZPyEHGz1ojAKO3JbNp8SJhHRal7i/PsHKShdhLTlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U0Odgy0i; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733384966; x=1764920966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yg0/ZKYktG7fEObUSD/PxEuyOeGev+Ml7YIOtl0mV1E=;
  b=U0Odgy0iIBFmeOnhNm2VUJY75wQmjX+0QLpGLLsKHvYYJvD2bCM4sg7m
   DGn3HYbKOsuMnd6liibzVvOKIxIonlNnovA4xIW1din4G8LmEIbc0QcnN
   IhUsbNY2JmGGpKMJrX3skcmelyjq1uwvSPQmRu+dxWjO14pDuzid9Xsia
   P9k/nEi/Tq3ltfzJJWX+sO3W9pov0bXjttg4+bPgAHuVhRgvoE5m+GyIs
   c4ZxifdzUcHiv9Xt7cewOy5eETSSHeuhAZlPVXbqv7TKwHlTrP6Aj+qhR
   v/P+5wvUUDid9PyBakHy6pkqioIXHMvzo5BHdrrS+d3umJVZZsBtdyYiJ
   Q==;
X-CSE-ConnectionGUID: WPhGFnXeTxqd85RKGkPIWA==
X-CSE-MsgGUID: knZqfTAlS5SIH3iQwNKdRA==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626121"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:24 +0800
IronPort-SDR: 67514c5f_zPQiYFT1egw4/XMQgixMReUnsxIeewho8AId2iz/wH106My
 1UOvZHupdUJmNdKdqiAscuE9X3WcWhvzPhUg1YA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:55 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:24 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/11] btrfs: use proper data space_info
Date: Thu,  5 Dec 2024 16:48:26 +0900
Message-ID: <ad6c61d8fed3362d1d08989d4d77def0f27d3333.1733384172.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
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
index 918ba2ab1d5f..89e43abfb2b8 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -111,6 +111,17 @@
  *  making error handling and cleanup easier.
  */
 
+static inline struct btrfs_space_info* data_sinfo_for_inode(const struct btrfs_inode *inode)
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
2.47.1


