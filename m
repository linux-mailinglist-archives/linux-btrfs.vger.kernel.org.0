Return-Path: <linux-btrfs+bounces-19650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F9CB51B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 09:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2194301A34B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C382BE034;
	Thu, 11 Dec 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oOIdqRsz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EB17A30A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441782; cv=none; b=McejYqst+99WeHf3k/CpS7VhTaoukWYFyJyVB9WI+dSm7Plaa+6TFfVGFbkIhKCgKoyNKX5kZBLMGS9XK3eZzfZzkbb5IDjG6iVZ+XibMX/8fVfS64tvmFex/SUeGhYs2XV7CM+ZuBaNXw6rDZTWlVq5xTTE2zrAAOXrAkCtn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441782; c=relaxed/simple;
	bh=l6AMKNv5hvZBurrD6YuFEVVVoF8vD44Q1ocsvKpdeQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpVytjbvK6U74VJhbEvmJQGp91AztYl06YbMxk64aGsX9omDlZFmoygvq1Bp7Wm3UQhw3+QdKbVid5XWumc2TUiLXWkBganStJVXchlLVOQEA9dDrg5MP77nyXulqdCvvrq/L6PNQMANfVYdgrQ6TQqB99poh8XcrLDw+mrECTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oOIdqRsz; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765441779; x=1796977779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6AMKNv5hvZBurrD6YuFEVVVoF8vD44Q1ocsvKpdeQ4=;
  b=oOIdqRszLG18sGjvo/mg1nWqtdGCw3hbXbQ4Ph2eZJ9AlUa8muSUh2nk
   DMUxM7QsMfGsLbl6BRrE8dE7Ax6jfrB28dYYWgF9B3X0TDyHajYJkXlib
   h+irR3DFupHsShq2Bw//OtZpki+uDUwCkcRFXPVURKeuESXxJRz5h6cLn
   eILNi4xbvLc2YY7SDY83WM8A4f3cUfhUVEn46H/S3usYo8+LUQtPSyMrL
   uy/fxhjdnD+UsFqwHnYFN5YTXFjNueOtuzJRn2AX1NuPFVMYyjlcijnbN
   Zpi+ccKqmNuCsrCIdbYjcXRvlHPjsMy4V8qAyJGEAzlAL5n/ZgcapinMU
   A==;
X-CSE-ConnectionGUID: rHH44zHiT7+Ov8x+bvtMIw==
X-CSE-MsgGUID: +FDy2m1nRGe99D05+Iq/KA==
X-IronPort-AV: E=Sophos;i="6.20,265,1758556800"; 
   d="scan'208";a="136312463"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2025 16:29:39 +0800
IronPort-SDR: 693a80f4_HBMXFEXMiJmkiG4+Gf0d9BJ0nXVkoLkwsZC4CzvrGtnMr+v
 7qk++Km5scequF2i6sWUZ8adj5BiH4Oma5u8wpw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 00:29:40 -0800
WDCIronportException: Internal
Received: from 5cg0214bv2.ad.shared (HELO neo.wdc.com) ([10.224.28.116])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2025 00:29:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] btrfs: Rename space_info_flag_to_str() to btrfs_bg_type_to_str()
Date: Thu, 11 Dec 2025 09:29:25 +0100
Message-ID: <20251211082926.36989-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211082926.36989-1-johannes.thumshirn@wdc.com>
References: <20251211082926.36989-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename space_info_flag_to_str() to btrfs_bg_type_to_str() and move to
block-group.h.

This way in can be re-used in other places.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.h | 16 ++++++++++++++++
 fs/btrfs/space-info.c  | 18 +-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5f933455118c..5185af49d6bc 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -396,4 +396,20 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     bool force_wrong_size_class);
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
 
+static inline const char *btrfs_bg_type_to_str(u64 type)
+{
+	switch (type) {
+	case BTRFS_BLOCK_GROUP_SYSTEM:
+		return "SYSTEM";
+	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
+		return "DATA+METADATA";
+	case BTRFS_BLOCK_GROUP_DATA:
+		return "DATA";
+	case BTRFS_BLOCK_GROUP_METADATA:
+		return "METADATA";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..427756c5138b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -602,22 +602,6 @@ do {									\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
-static const char *space_info_flag_to_str(const struct btrfs_space_info *space_info)
-{
-	switch (space_info->flags) {
-	case BTRFS_BLOCK_GROUP_SYSTEM:
-		return "SYSTEM";
-	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
-		return "DATA+METADATA";
-	case BTRFS_BLOCK_GROUP_DATA:
-		return "DATA";
-	case BTRFS_BLOCK_GROUP_METADATA:
-		return "METADATA";
-	default:
-		return "UNKNOWN";
-	}
-}
-
 static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
@@ -630,7 +614,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 static void __btrfs_dump_space_info(const struct btrfs_space_info *info)
 {
 	const struct btrfs_fs_info *fs_info = info->fs_info;
-	const char *flag_str = space_info_flag_to_str(info);
+	const char *flag_str = btrfs_bg_type_to_str(info->flags);
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
-- 
2.52.0


