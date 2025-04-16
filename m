Return-Path: <linux-btrfs+bounces-13087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA3A9066E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B0516F930
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A071FF7DD;
	Wed, 16 Apr 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nofnYlyG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE971FDE01
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813723; cv=none; b=EjNTz+4ZdcCimtugWJOnLTifyJpxNWFld03vOiCQ66XsRlXqMESxcwPnDZ4sRYlNjll8vbdcpLdG/BoV1uUALM08GLaeIiRHkvhocstEkyTx++52rNftp/ir4J60VhQ5JBuoHXfgm6u6vllLCLS9gzyiF/6S7bQNq1vbbiJ+6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813723; c=relaxed/simple;
	bh=ULMSqJUJE/JQekeiM4lAHJyRNTu+vI9qN/9eYCz4Ttk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9/xw4DdVZrqRNWXkDqYPsl7vB/FTAd83w0o5l2MDDcrrRqNBp8Dai2SuKUHh3pG1nV55J2/CXGw/X5Jaz5LH1jNohIuQWfCDluBTn/W9owrqNu6c8qrvDFATzreTfaEuifzT4OkkbJ3chnjmGctXKcW7rBz5EUb/hu4htGL/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nofnYlyG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813721; x=1776349721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ULMSqJUJE/JQekeiM4lAHJyRNTu+vI9qN/9eYCz4Ttk=;
  b=nofnYlyGiPXTRwyZwGLjbvH4AKGzacw/iM9CR2k+FqL2el5wJcFAacX9
   CWE3dJPWTY5gsIQIAov66L2s0iZYV/3R+VjqSdWxOHcDqRmvCb566m66y
   7IA7IheJv0MjO4vcDKGIK7YNpMqisredNsFF5eTU25MsPfllkC4gDA3HK
   jnsxlGj23xXVYjkD0rT+4mpo3YzYQhgC8Yt3wg48RawVVERSNjqndju3f
   kwt7g2DTfZl0y6K4cpSdf0XLGSAh8VchWhtVkUatunhw+RhuahTAPAz1S
   ufSw5BA35qSzRDO1v7oXx50a3LiD21H557g+YBSRIBeDB62/KesE5fxdH
   A==;
X-CSE-ConnectionGUID: 6i23ydGtT5epuHCbgRiwxQ==
X-CSE-MsgGUID: XLVyCOtISKWNn1r+GVuntg==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484533"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:36 +0800
IronPort-SDR: 67ffb086_1tfnqVMb0ptj1l59jppRRZVl728zm/HRHLagdqKURs7aU8i
 I6lrY7+v/kWeU9PeWqScKdYCR3+DOf39FCbG8xg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:38 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:35 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 11/13] btrfs: use proper data space_info
Date: Wed, 16 Apr 2025 23:28:16 +0900
Message-ID: <653405a025836e4938d3276e69d3015e6b038a0a.1744813603.git.naohiro.aota@wdc.com>
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

Now that, we have data sub-space for the zoned mode. This commit tweaks
some space_info functions to use proper space_info for a file.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
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


