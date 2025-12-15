Return-Path: <linux-btrfs+bounces-19749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1567CBEE76
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FAB3048DB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253A3101D2;
	Mon, 15 Dec 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X+aUmSYG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66930FC0E
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815879; cv=none; b=IfK1v+OvduNLI+mOPE97aou6f/zF+3uXk3kpicbR/ZOSOENZW6UebQ5uWpWrszWq+MEPp6stBjN54NGIVH/0Nl//SqHKqGHwl13oKdFMzV0h8o3I3Bk8j4OMNEnzcjdpLZqVrwb7/EtmLfm+fJAlwyedYrL9BAowjaG6aXVHpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815879; c=relaxed/simple;
	bh=spf9x8jLrxchu71rDOe/XOymVFoSNaTgP0zdmu1bxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbhN9QuJHORho2/EClIJpL68e5dIpeCAgMzdLJB+aQJHbjRZUVvEqSwPa7deDMPlgRN3UlaLfpBA8bfUXBLJzXFuN5puMUY6yWYE1AxzasehKNYrQ6V1rTsRfBpZt/DcHB9JpkstH7FkG6PThBXutTcNwQ1Uh730CRR6kB6Kbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X+aUmSYG; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765815877; x=1797351877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spf9x8jLrxchu71rDOe/XOymVFoSNaTgP0zdmu1bxQQ=;
  b=X+aUmSYG3owwLU5WMvAzJN+fSULEDbW8tfAgP4nn58MX93ijbAUCcGlc
   u1H/zVebSN8N/XtBUIWL8FbrlRp5cCs5IKGOzH64jLE+6SKGkHX6VX448
   I/gg76h5tW+sM8gN2QZa6Mu9KcK3d+Zlh49rwDssumbTmwlzUDlvLQl3M
   dh1Wyp5CP9jXkNVMjDcNm4uRsf1HsKCoD71LNr3BaT0wA49DxcPoEuT7I
   O0wfGBTGJ9/ujyB+XS5EC2m+2mOhKXyaGFXTULeNgDoirZ1qy5nNlJfcA
   n2RAwjZ+yIT3iYW3brJxVmUyg5Gcnpl16dpfptOT2dDESvN7+ybwphFgg
   w==;
X-CSE-ConnectionGUID: 4ooRDlwbRT+Iq9eFnfN5vQ==
X-CSE-MsgGUID: epvuTBPwSk2+Lyy4oEoqgA==
X-IronPort-AV: E=Sophos;i="6.21,151,1763395200"; 
   d="scan'208";a="137916732"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2025 00:24:34 +0800
IronPort-SDR: 69403641_bWq83vMFQ38YkZ7ICjL3Bj4/w3zYmoZeYEvXVlaTNJJ4oCj
 PGMdhLcmtRDyAXp+FDQBhffXywDR5K8cMcOUDYQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 08:24:34 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.125])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Dec 2025 08:24:31 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 2/3] btrfs: move space_info_flag_to_str() to space-info.h
Date: Mon, 15 Dec 2025 17:24:19 +0100
Message-ID: <20251215162420.238275-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
References: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move space_info_flag_to_str() to space-info.h and as it now isn't static
to space-info.c any more prefix it with 'btrfs_'.

This way it can be re-used in other places.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 18 +-----------------
 fs/btrfs/space-info.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..7b7b7255f7d8 100644
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
+	const char *flag_str = btrfs_space_info_type_str(info);
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 446c0614ad4a..0703f24b23f7 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -307,4 +307,20 @@ int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
+static inline const char *btrfs_space_info_type_str(const struct btrfs_space_info *space_info)
+{
+	switch (space_info->flags) {
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
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.52.0


