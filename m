Return-Path: <linux-btrfs+bounces-12413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77DBA684EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99107A7E59
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81E2505A3;
	Wed, 19 Mar 2025 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eDuI8VTq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477D211A37
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364908; cv=none; b=NvACuT6QbBuj7S1SNj5xxl4zJ17piLIVFQtoHgQVj7pUjpk5zXINZM8FftgDA60Z/XthMdQihbSIBpTOa3gO7H7sOU+axVxjMKaZDA/pQUTWImqK/K/y/BB4qfabqdsWhh0br2TNMAP5uBgrHYmxFV2LI6O8MMpC6ppcvccJuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364908; c=relaxed/simple;
	bh=/YiZh01/0ct/vUeCzk7oLhphp9SrZBp9ppV+s57BwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujt11L87VlrYzdV2LxnOBOY2yEf7KbRP4Y0ydVT/wkeYuyXEp0E5Fw6QxZTyM49EcEvk6DLGuzdE4rnWsZjYJbdm8xHwZtPDSojlGw89mLer0QyUgbMip4atnUeUNxweUhwj9YOeSt/JAjsut59hygxKWNbmZJBsR9v+eZT2SVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eDuI8VTq; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364906; x=1773900906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/YiZh01/0ct/vUeCzk7oLhphp9SrZBp9ppV+s57BwrI=;
  b=eDuI8VTqGepGFvWrw7MCOTOMyevxp2bJ4Cl0+VMe5uzdlan3TZD/ljjC
   C0Qh1a7j4EHPjNNEvDV8E+k1gPa0tOto1YbQQv2R+hBVQwSmjTuSMUUzQ
   wgVfZGj5VsTtjnnFgeiSdKfyAS/s0lLkV7jK1ZYRhixhrJwGzAra2UQo4
   xP5YxTLrfKnz/J6BT3HiwNM5NNW4CpCfxkzvJshHmJjnquvgRQZok5KgW
   Cni2pDI6t91S5ffq8/A/TwLMwESv4C30yH6yHn84JAgmjtrsihyv01/gm
   bUUFJjqQdztk/2wPWis5xkQXOcrESXPd8LGl6d19Z4FbXtmuGX9OtWnUq
   A==;
X-CSE-ConnectionGUID: lILWdo1WTLqMfoDuJDQw2A==
X-CSE-MsgGUID: gfAKTs7RRpSrhgAtvW/uZA==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227259"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:06 +0800
IronPort-SDR: 67da530a_1sS/4YAcFOJ3cAtJOK98m5EPqFOVfxme+zYYisJ1G6jIFx7
 VeS8UYyPR0JxtI6W2erg44zFMxQLGVZozYuy+8g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:55 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:05 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 09/13] btrfs: introduce tree-log sub-space_info
Date: Wed, 19 Mar 2025 15:14:40 +0900
Message-ID: <f4679fa21b8b55e467c653ae7f0efb64e27044ad.1742364593.git.naohiro.aota@wdc.com>
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

This commit introduces the tree-log sub-space_info, which is sub-space of
metadata space_info and dedicated for tree-log node allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 12 ++++++++++++
 fs/btrfs/space-info.h |  1 +
 fs/btrfs/sysfs.c      | 10 +++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 53eea3cd2bf3..3c775c76e2af 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -280,6 +280,18 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 			ret = btrfs_sysfs_add_space_info_type(info, reloc);
 			ASSERT(!ret);
+		} else if (flags & BTRFS_BLOCK_GROUP_METADATA) {
+			struct btrfs_space_info *treelog = kzalloc(sizeof(*treelog), GFP_NOFS);
+
+			if (!treelog)
+				return -ENOMEM;
+			init_space_info(info, treelog, flags);
+			space_info->sub_group[SUB_GROUP_METADATA_TREELOG] = treelog;
+			treelog->parent = space_info;
+			treelog->subgroup_id = SUB_GROUP_METADATA_TREELOG;
+
+			ret = btrfs_sysfs_add_space_info_type(info, treelog);
+			ASSERT(!ret);
 		}
 	}
 
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


