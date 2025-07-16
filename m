Return-Path: <linux-btrfs+bounces-15524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF034B070A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F40256185A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45632EE974;
	Wed, 16 Jul 2025 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KycDa7/D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C34A3E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654806; cv=none; b=TnqXQ8ySGoDkkrX6gfQ9APBUOiKtO1SP+F8hOjqKjV36/VrlTdKAzJYYTIujwyFy7MX9jeN+vdRmt0rxryCBAWP9xv61cctpkxycajSlQ+/N10tprQ4AaHrmQWa/JAqwC66rFjr1cmQsre+WX6h2b4Hj6+AoT/XuVKujQPsGuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654806; c=relaxed/simple;
	bh=TIgUhjrJfP4xMDdb+fZc+NShkl3Ea58kF0u8Yi7CFHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbiSePFWnsKd9zQliAVUMHuvVjRbgP+l2aA8OZMwRDSMnFH5/FTrSgXFrIpWHshu6Oep74PY0b2R7QGf467XA6paSNdpzydGTkgzKibo/RqejbwC26FNfYYluSkxW8aiWkGAAAbjEqCtKhIYw67qWfh5mSemSYTLd0XI8i+LEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KycDa7/D; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752654804; x=1784190804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TIgUhjrJfP4xMDdb+fZc+NShkl3Ea58kF0u8Yi7CFHA=;
  b=KycDa7/DtTHa+Y1WT/6e5xuzucJRxZ+XmcIqXPkLC2p5nRRbWVVv6XrQ
   d6KHO8e3Ilp+CgidwANe5VSHVJIEzIA+zq1R5yAoaOYsE21ZbipdYafqv
   9SuAIblYrKQOiayG9jbXvPgYQiEEuK7YKm4EdK+4r1tEKLMFibI/JNusE
   48ueG5ibrE/V8AF/99A0nvYEfEPduLODTbEjiAFnLOXth9yOJBSJ79zGM
   F5v4Pt5xyI6uyfKAJvsD+ljkHd9uEEiZ2snt2bNBWVZ57qXcNk60P3qUI
   PXowJDVVDbRZclV1fwb6BwTZdreJ1LYZQljHdmszOMsSrrDStnq1jmLLZ
   A==;
X-CSE-ConnectionGUID: apq3iFcwQYGrsljEiUyyjw==
X-CSE-MsgGUID: 2qVmFapzRHuQUTW2nKKTLQ==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="90299996"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 16:33:23 +0800
IronPort-SDR: 68775532_o9yhwj804dtGn86OY47RVh+pDfMlEnfO2cSh85IMf3wjMRf
 bYGWAJBxag5iGz9aXcMgcfrcOuIvcuGN7o/4RdA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2025 00:30:58 -0700
WDCIronportException: Internal
Received: from wdap-0lwmw3epm9.ad.shared (HELO naota-xeon) ([10.224.173.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jul 2025 01:33:23 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: refine extent allocator hint selection
Date: Wed, 16 Jul 2025 17:33:00 +0900
Message-ID: <20250716083300.1308261-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hint block group selection in the extent allocator is wrong in the
first place, as it can select the dedicated data relocation block group for
the normal data allocation.

Since we separated the normal data space_info and the data relocation
space_info, we can easily identify a block group is for data relocation or
not. Do not choose it for the normal data allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ca54fbb0231c..514ae6a6a3e5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4297,7 +4297,8 @@ static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 }
 
 static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
-				    struct find_free_extent_ctl *ffe_ctl)
+				    struct find_free_extent_ctl *ffe_ctl,
+				    struct btrfs_space_info *space_info)
 {
 	if (ffe_ctl->for_treelog) {
 		spin_lock(&fs_info->treelog_bg_lock);
@@ -4321,6 +4322,7 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
 
 			if (block_group_bits(block_group, ffe_ctl->flags) &&
+			    block_group->space_info == space_info &&
 			    avail >= ffe_ctl->num_bytes) {
 				ffe_ctl->hint_byte = block_group->start;
 				break;
@@ -4342,7 +4344,7 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		return prepare_allocation_zoned(fs_info, ffe_ctl);
+		return prepare_allocation_zoned(fs_info, ffe_ctl, space_info);
 	default:
 		BUG();
 	}
-- 
2.50.1


