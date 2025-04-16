Return-Path: <linux-btrfs+bounces-13077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F4A90675
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93AC189893A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41D1DF265;
	Wed, 16 Apr 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KQi38xwK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34231B87E2
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813716; cv=none; b=dmTRBpYyRpoaGfmzxFyuD7oAmM9/x68p85NkzhFqm9fC3oAsK0Rha26GfGlri3hOgJyLkXFhw8D0gFk4Kolx2qCdx0y9xxSi7lL62YTPc8FRQbsQmka8GqkE4miUjdjRhbtYIPBO3esHA7uXBsV1df20qIP98+HkSIArJxa0fR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813716; c=relaxed/simple;
	bh=CNxn5T8cyv3QVZhRb5fWxLVPWjCkLrC3RSqjgxC1a5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUaVbVxy0ZWy3F7YLLB9lZriLdcHjgXs3ec6hsC9qFpus9b6y+vZxZ8qbHaeleSDY/HvplmAaoOEGZRaZCI1Vp9vCzlEx4rwvZJVQAn5nApc9JTLRdpZxj7PwG81ESAtPxvasGbvVpRY5Zq6vjzmVravkTMxgtg+PU/yDrrTMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KQi38xwK; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813714; x=1776349714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNxn5T8cyv3QVZhRb5fWxLVPWjCkLrC3RSqjgxC1a5M=;
  b=KQi38xwK94wSiscHsZegXQB2ooIDk0gRclJCTBbHgjkiheO31qurhRXL
   suwbjNzeuRi0VswlOXup8XVxOdohfcSf1+MxEJz+DUU5fQpNbWk1SdDsL
   nh33a1k7wfE/y+upTvIYthf0sZGiXuXhhceVP1euM3WRw1un3shVxXp1U
   BHMbTGYPRtFIi2YVDDFcYhPlwttu9Tz8RdCuXnm74Ncm0GPiP5c03adXF
   hQau5VWgpWvSQHyvvD5Fu7P7aBnxiKwVVLBrlS1IosbxZnH4vGZxxtWsH
   4ec+bZj3Tw2J3Lz7AvppQ9twaa/+2H3QguQx6Tytn8wINUu7chRNbiSXp
   Q==;
X-CSE-ConnectionGUID: 9LBfh+2IQaapXbDBv6ssEw==
X-CSE-MsgGUID: RmaQN6FLQnCAsMdJ7Z3n1A==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484518"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:27 +0800
IronPort-SDR: 67ffb07d_z8NgS1ZJF33MrqrMmtS+bTJU1aLBrKjZevAvacWinQ527uH
 zYX9P3ta9yXKSNmonOfVSh6CSd90RgHmWiZTaVw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:30 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:26 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 01/13] btrfs: take btrfs_space_info in btrfs_reserve_data_bytes
Date: Wed, 16 Apr 2025 23:28:06 +0900
Message-ID: <f170b7a516ec911589b9f1442c20d48693ee5d39.1744813603.git.naohiro.aota@wdc.com>
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

Take struct btrfs_space_info in btrfs_reserve_data_bytes() to allow
reserving the data from multiple data space_info candidates.

This is a preparation for the following commits and there is no functional
change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delalloc-space.c |  4 ++--
 fs/btrfs/space-info.c     | 10 +++++-----
 fs/btrfs/space-info.h     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 1479be2427cb..c7181779b013 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -123,7 +123,7 @@ int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 	if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	return btrfs_reserve_data_bytes(fs_info, bytes, flush);
+	return btrfs_reserve_data_bytes(fs_info->data_sinfo, bytes, flush);
 }
 
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
@@ -144,7 +144,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	else if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	ret = btrfs_reserve_data_bytes(fs_info, len, flush);
+	ret = btrfs_reserve_data_bytes(fs_info->data_sinfo, len, flush);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 77cc5d4a5a47..3bb7246f40fa 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1836,10 +1836,10 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
  * This will reserve bytes from the data space info.  If there is not enough
  * space then we will attempt to flush space as specified by flush.
  */
-int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush)
 {
-	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	int ret;
 
 	ASSERT(flush == BTRFS_RESERVE_FLUSH_DATA ||
@@ -1847,12 +1847,12 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	       flush == BTRFS_RESERVE_NO_FLUSH);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	ret = __reserve_bytes(fs_info, data_sinfo, bytes, flush);
+	ret = __reserve_bytes(fs_info, space_info, bytes, flush);
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
-					      data_sinfo->flags, bytes, 1);
+					      space_info->flags, bytes, 1);
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, data_sinfo, bytes, 0);
+			btrfs_dump_space_info(fs_info, space_info, bytes, 0);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a96efdb5e681..7459b4eb99cd 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -288,7 +288,7 @@ static inline void btrfs_space_info_free_bytes_may_use(
 	btrfs_try_granting_tickets(space_info->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
-int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
 void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
-- 
2.49.0


