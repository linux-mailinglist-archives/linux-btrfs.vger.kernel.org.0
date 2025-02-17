Return-Path: <linux-btrfs+bounces-11502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F80A379CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172787A2D9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469471862BB;
	Mon, 17 Feb 2025 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="afC+3QXg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363ED1632D7
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759880; cv=none; b=a15iOH6j/6PdKpttLf4bhqxEwN8B00lPZjizbc7RyjfpsQAlybajGsKy/gGGxFBGAHZZzBaJTAuNdJaEAaOzrCgd6Ngzcp62BN3MrWi3gdZfJlF//skYtru5sZ+DyqtyukvVWsYziwUrvnvnn5vU5G6AilPy8XX7k8xJT1IF8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759880; c=relaxed/simple;
	bh=b+yGm9FvXIHtDZI9mURLWLDlVxw1yY58rwvu/aAEMpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgSWC4Hnwde2rNypzap/zlxOmyfNQIea5EBSExcars/MiYmbidGipeGx0Haj9GPxcNe+PZic3Z87YBY4Rv/tmWst+6lo9uxKzMiXW4P6Eieetd5MdEdwg23v+zkwJDhcx8k7tXohrv7OYxjqTQezWehz0BToM6PBsSdpJ9a4eCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=afC+3QXg; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759879; x=1771295879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+yGm9FvXIHtDZI9mURLWLDlVxw1yY58rwvu/aAEMpk=;
  b=afC+3QXgTuVMhR7+MUXsgBOTTWObe5bR2pAr0TxdY14moj6QsMd350mZ
   zSLPdyGy0048NRVJ5puEK8CwnkAxhk3PFXAps5YzDpHmV1OzZRzfXSrUr
   E7xfGoFtSQw5hMZA32MrEi7j8CXrBjcvUbOb+79Vjvnlh4JjPVpAOeuYW
   baWxk0rsXz4mNsetzf5Td8+9c8BG1LFvS0/V/N+M+YfCTxxg3gQuRrrj9
   TtoGApCmlF+tsnuEDP9k9MkYU/f+FgXIwP2R4oo5/DSh8iGn/HDWI+18K
   OtCXo3gplxCjlDtoyi1zhr8mb29ALulxs4cHhBQaQndt3NJLo4+37RyhY
   A==;
X-CSE-ConnectionGUID: S8854YCrR3eBuuEpa5TVHA==
X-CSE-MsgGUID: 9Z5zvQvoRMynatgeq6nCBg==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877186"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:56 +0800
IronPort-SDR: 67b2934c_YijFnOw3mgE9ougtYG7W216Tz918ub5+gvjdQ+kBi3Zxh6R
 bgzwmP/B3MLs9qDfPmn4Itc2uOLPd93rywjGH3g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:24 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:56 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/12] btrfs-progs: implement RAID10 zone info loading
Date: Mon, 17 Feb 2025 11:37:41 +0900
Message-ID: <4e9ffca4b694c1e16a2b30b153e1de490058a601.1739756953.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739756953.git.naohiro.aota@wdc.com>
References: <cover.1739756953.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just same as the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 66d76427d216..484bade1d2ed 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -1092,6 +1092,39 @@ static int btrfs_load_block_group_raid0(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_load_block_group_raid10(struct btrfs_fs_info *fs_info,
+					 struct btrfs_block_group *bg,
+					 struct map_lookup *map,
+					 struct zone_info *zone_info,
+					 unsigned long *active)
+{
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if (test_bit(0, active) != test_bit(i, active)) {
+			return -EIO;
+		} else {
+			if (test_bit(0, active))
+				bg->zone_is_active = 1;
+		}
+
+		if ((i % map->sub_stripes) == 0) {
+			bg->zone_capacity += zone_info[i].capacity;
+			bg->alloc_offset += zone_info[i].alloc_offset;
+		}
+	}
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -1191,6 +1224,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	case BTRFS_BLOCK_GROUP_RAID0:
 		ret = btrfs_load_block_group_raid0(fs_info, cache, map, zone_info, active);
 		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		ret = btrfs_load_block_group_raid10(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 	default:
-- 
2.48.1


