Return-Path: <linux-btrfs+bounces-13085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E294BA9066D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BA216B4E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562C1FF1CF;
	Wed, 16 Apr 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RSrkIIOl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D61FBE8A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813721; cv=none; b=BXDcYHEwaXzXwk4mffbBvSoiWPLFKz3c/DlYttEUGEi+AYeQKu0GvLbaYypZFVTjcEUjpfksQZGnUTegveBX0IEBNJE8mthWthqo1MyOYOOZHOKfeT8/tGZX/Jt/APY4fW+B0jDkwpg/pRMxjpfbe1xlCuUnUdAjOAmvLygMgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813721; c=relaxed/simple;
	bh=7zSUCpfxzZJrASCwbkJ+Av7AcVbH2p7fhrx+dKAfjdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkc10as4KUp94pDgHBXT+1YixdLXYxcOOelmsd+ldDiAzSeHHY+V66G1lbieaMHRnZ1DL/VXs4ANc2090REYV5HVMImqZOv1FQZ5y33q6BTLlaWm1LbKY6Wz1oej8pdNgDeDKxcZIy/nvCFu+/5uQ3QIAg/CrCMTcavGW33fjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RSrkIIOl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813720; x=1776349720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7zSUCpfxzZJrASCwbkJ+Av7AcVbH2p7fhrx+dKAfjdw=;
  b=RSrkIIOlK6nPhJeOAVT+9Jt1IhggDcGffOqJ2/WhwZf2EvIUVP1Ysv6h
   76OtXMUrndSSgM+VJs2682Qo+tDjNKwA45OTlfirixECc2pUQDMF61k4s
   Pd1PPdBDZD0AdcKsH93Y4OXgxCqgJ0Egwj5toT8oAU4T4LN6JLJbSWo//
   ksQir6/tkPJ8/nHi8rqu8R29To54Ow9V1/HfZipQoWRmBO4hoWduZbRzL
   nI8piZaiHdU6Zr+0JS3P/fefNLDLMYFgPmwzqGimt4/JG+esIip5KKt0s
   ORgOpod4JuGp9PKW49SWNrzrF86vwQ/GUVp/HpcF/Hj4WirlZNw0ckCO4
   w==;
X-CSE-ConnectionGUID: j5Qiz8dNSWGtA6Jv/sbvdg==
X-CSE-MsgGUID: ztP2lydjSRqmFC//6QsbDg==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:34 +0800
IronPort-SDR: 67ffb084_E0DSP+yJOlbRwWWZ0Yv6em0Yp5luf+50kbxOR2q3O8ZsSt8
 1oeEdEonUEtQZC3OlHLDSV505QlbP62VuvyC4RA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:37 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:33 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 09/13] btrfs: introduce tree-log sub-space_info
Date: Wed, 16 Apr 2025 23:28:14 +0900
Message-ID: <e5339b5616f1b4b7ee7625f86fa392bc49d2fc0d.1744813603.git.naohiro.aota@wdc.com>
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

This commit introduces the tree-log sub-space_info, which is sub-space of
metadata space_info and dedicated for tree-log node allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c |  4 ++++
 fs/btrfs/space-info.h |  1 +
 fs/btrfs/sysfs.c      | 10 +++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 37e55298c082..4b2343a3a009 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -292,6 +292,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 		if (flags & BTRFS_BLOCK_GROUP_DATA)
 			ret = create_space_info_sub_group(space_info, flags,
 							  SUB_GROUP_DATA_RELOC);
+		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
+			ret = create_space_info_sub_group(space_info, flags,
+							  SUB_GROUP_METADATA_TREELOG);
+
 		if (ret == -ENOMEM)
 			return ret;
 		ASSERT(!ret);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 64641885babd..1aadf88e5789 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -100,6 +100,7 @@ enum btrfs_flush_state {
 
 enum btrfs_space_info_sub_group {
 	SUB_GROUP_DATA_RELOC = 0,
+	SUB_GROUP_METADATA_TREELOG = 0,
 	SUB_GROUP_PRIMARY = -1,
 };
 #define BTRFS_SPACE_INFO_SUB_GROUP_MAX 1
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 92caa5d09e2f..fba31e2354e5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1938,7 +1938,15 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
 	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
 		return "mixed";
 	case BTRFS_BLOCK_GROUP_METADATA:
-		return "metadata";
+		switch (space_info->subgroup_id) {
+		case SUB_GROUP_PRIMARY:
+			return "metadata";
+		case SUB_GROUP_METADATA_TREELOG:
+			return "metadata-treelog";
+		default:
+			WARN_ON_ONCE(1);
+			return "metadata (unknown sub-group)";
+		}
 	case BTRFS_BLOCK_GROUP_DATA:
 		switch (space_info->subgroup_id) {
 		case SUB_GROUP_PRIMARY:
-- 
2.49.0


