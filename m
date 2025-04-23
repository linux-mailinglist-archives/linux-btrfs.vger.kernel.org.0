Return-Path: <linux-btrfs+bounces-13265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C6AA97CF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068783BF9D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946C265638;
	Wed, 23 Apr 2025 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ccr5FSpB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B634264FB0
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376269; cv=none; b=G+qbTr6zlqR+ZVR/NiPX8ZY2nQUINcgP86Ue9nay/7yEtJxrECKz5YnDm1w5hGeMyf5HimETMMIvn3BZzcYpjwyQtGk2BDPt8dwbZ3Gc00UqXcC0SWyJe3Mz938se57+WpyNpI8lwq2R73fJHp7urEvsQNPchAqbq9XL78GJ8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376269; c=relaxed/simple;
	bh=tZOa6+g6V6/wp4z7rk1H0aiANbrgpVER96FgRngpGPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIqYI48j+djA36p3RpPL2kAuFIId1mKZx1VeXpRThndXfq9kZq3J7W6H68hDJ9fQEP2mcMwVgsZmLS0l+Sy7yBtOetmvDIRPKydVQ8wEyQ2xKjf+Fv6vvZbV5ijaiJHGbDhLbzD7HGd29ssqHBESyzfXmXNhztvn322zxgDUBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ccr5FSpB; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376268; x=1776912268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZOa6+g6V6/wp4z7rk1H0aiANbrgpVER96FgRngpGPY=;
  b=ccr5FSpBfzdNSl7p+O/YNJKnWM8coAoaJv8MhfvJQ4nwsZxIL9IEjPAD
   lJSX+kjHxTqSL9fto5icodAqjRPkuc3yg/VhLaoBSAUBeJ3i5N465WEyT
   ColE/o9Ru8IVDwFewAScAGhVlBXVtIha6ckugc/99rswu5Xw4eLAcxrdM
   c6Y2Q8JnruHYNh0KFiUG4xZBTt672gNpvmA0sMVzlx35CPX2Ju6VgHhuM
   gZqtb1hQUmvdd9ATG0aCX45nY/y2yai4TiGgVh2vhJ7ZfRnd43/pB6Pex
   LflLiJONj7xyrbxTqQCDnfnVX1fotwMz5PnnB13sRGmENUj5x+tx0xIuR
   Q==;
X-CSE-ConnectionGUID: XsxIVveAThqnXtPirxvW0g==
X-CSE-MsgGUID: SjiBvJFZQba+1MiVBBo70Q==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:23 +0800
IronPort-SDR: 680845ee_QPHiR40P6wQaxfm0itfUT1DiLPif9StUHAQTQkAAiWcoExU
 QDMRjHbGbEGfQtKduOtgyUf3Y4mf0VQi3ZKMpxA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:15 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:23 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 09/13] btrfs: introduce tree-log sub-space_info
Date: Wed, 23 Apr 2025 11:43:49 +0900
Message-ID: <ca899a66b5bc992e73abf12e06247e5d5015ae19.1745375070.git.naohiro.aota@wdc.com>
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

This commit introduces the tree-log sub-space_info, which is sub-space of
metadata space_info and dedicated for tree-log node allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c |  4 ++++
 fs/btrfs/space-info.h |  1 +
 fs/btrfs/sysfs.c      | 11 +++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e45e9db37497..a34771cf0870 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -299,6 +299,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 		if (flags & BTRFS_BLOCK_GROUP_DATA)
 			ret = create_space_info_sub_group(space_info, flags,
 							  BTRFS_SUB_GROUP_DATA_RELOC, 0);
+		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
+			ret = create_space_info_sub_group(space_info, flags,
+							  BTRFS_SUB_GROUP_TREELOG, 0);
+
 		if (ret)
 			return ret;
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c76929a65475..e04727f30aed 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -101,6 +101,7 @@ enum btrfs_flush_state {
 enum btrfs_space_info_sub_group {
 	BTRFS_SUB_GROUP_PRIMARY,
 	BTRFS_SUB_GROUP_DATA_RELOC,
+	BTRFS_SUB_GROUP_TREELOG,
 };
 #define BTRFS_SPACE_INFO_SUB_GROUP_MAX 1
 struct btrfs_space_info {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4667b388e046..5d93d9dd2c12 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1938,8 +1938,15 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
 	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
 		return "mixed";
 	case BTRFS_BLOCK_GROUP_METADATA:
-		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
-		return "metadata";
+		switch (space_info->subgroup_id) {
+		case BTRFS_SUB_GROUP_PRIMARY:
+			return "metadata";
+		case BTRFS_SUB_GROUP_TREELOG:
+			return "metadata-treelog";
+		default:
+			WARN_ON_ONCE(1);
+			return "metadata (unknown sub-group)";
+		}
 	case BTRFS_BLOCK_GROUP_DATA:
 		switch (space_info->subgroup_id) {
 		case BTRFS_SUB_GROUP_PRIMARY:
-- 
2.49.0


