Return-Path: <linux-btrfs+bounces-11555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D724DA3B2F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F0B16DD01
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B671C5D72;
	Wed, 19 Feb 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lI9FVlPk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B091C54A7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951902; cv=none; b=gCzDdxqrOrq1gqrfLdsK091BBpxu3BgGhlEgnEaEqoZjJmjhnZbI/9YT8ULd9fUyNik90Kia72WzkXcMJWwBNTXZme4YwER6ZSFjTxsLhnf6sd10tSgBkrj1tHnCgMny52Z/eXuaRL95+GplPAyvzdv6TupZDzqnNphqg5oS8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951902; c=relaxed/simple;
	bh=wrHS5cUCM5L5AttiYjQt+RQCbR4CsmRd5QhN57OxLzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avuNZoTjJGY+XDHDUaBTn3k3KfovU1D/KcKSeaW5zfdrCmszNXyiKPsDvRv/WnHZZlSrhU/mze55ioXDsP75R9Mw6ASIs90IWazoe3cmDpFsiePPyN4ZSKDuz6jxVR7eZZ6babS9weqrltfZm+QgEmcHqyz+agiIaL8n+OrXU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lI9FVlPk; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951897; x=1771487897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrHS5cUCM5L5AttiYjQt+RQCbR4CsmRd5QhN57OxLzc=;
  b=lI9FVlPkFpS7N4wIpUngu1+i296E4+FQ0wTef7l0IcFqr2Ud2ypqS1vH
   VnlblW4A36ctN2BMQQuuL//+uy4E806gtBjmCmpKmA0u4loyzPap+uuH1
   OxqVFWJIPAMOKxWjLRXH4rqMjsGU5INCtx+2j25KnOj2GMDlwcfpeMrox
   vD/aEvUAkLWN7B0I0AnMW1WMnv62dezK7JItxCLF3KKFmgJCaZsGazOsV
   hyX4qWbeFSWyxwawdbQdtXTrDQ9a7+sdE4Q5mTfTM+ftG5oLD7mbhpltU
   pKveUUX6sN/h0yglq7roePXOgYNryWNEC2OlHoCMisKen+drHMJ7QhAGs
   Q==;
X-CSE-ConnectionGUID: zNkK7FJjR6+8e7E5wIj3nA==
X-CSE-MsgGUID: Q5/vM9gmQWqhJEB1SBG9tw==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310808"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:07 +0800
IronPort-SDR: 67b58154_6mGAanfhtTAyA7QONGh9JlDl+BWiJyB3aHzGcqpuV0WVeHs
 ho0K+Va8J6sVrlOG9nzXqzqNo/Lzrywpv1riSHg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:33 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:06 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 05/12] btrfs-progs: zoned: activate block group on loading
Date: Wed, 19 Feb 2025 16:57:49 +0900
Message-ID: <0a272ad61dca26d4ee7f1e7ba474685b21825a05.1739951758.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce "zone_is_active" member to struct btrfs_block_group and activate it
on loading a block group.

Note that activeness check for the extent allocation is currently not
implemented. The activeness checking requires to activate a non-active block
group on the extent allocation, which also require finishing a zone in the case
of hitting the active zone limit. Since mkfs should not hit the limit,
implementing the zone finishing code would not be necessary at the moment.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h |  1 +
 kernel-shared/zoned.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index f10142df80eb..da0635d567dc 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -286,6 +286,7 @@ struct btrfs_block_group {
 	u64 alloc_offset;
 	u64 write_offset;
 	u64 zone_capacity;
+	bool zone_is_active;
 
 	u64 global_root_id;
 };
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index a97466635ecb..ee6c4ee61e4a 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -901,6 +901,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	u64 logical = cache->start;
 	u64 length = cache->length;
 	struct zone_info *zone_info = NULL;
+	unsigned long *active = NULL;
 	int ret = 0;
 	int i;
 	u64 last_alloc = 0;
@@ -935,6 +936,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 	}
 
+	active = bitmap_zalloc(map->num_stripes);
+	if (!active) {
+		free(zone_info);
+		error_msg(ERROR_MSG_MEMORY, "active bitmap");
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		struct zone_info *info = &zone_info[i];
 		bool is_sequential;
@@ -948,6 +956,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
+		/* Consider a zone as active if we can allow any number of active zones. */
+		if (!device->zone_info->max_active_zones)
+			set_bit(i, active);
+
 		is_sequential = btrfs_dev_is_sequential(device, info->physical);
 		if (!is_sequential) {
 			num_conventional++;
@@ -983,6 +995,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		default:
 			/* Partially used zone */
 			info->alloc_offset = ((zone.wp - zone.start) << SECTOR_SHIFT);
+			set_bit(i, active);
 			break;
 		}
 	}
@@ -1008,8 +1021,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 		goto out;
 	}
+	/* SINGLE profile case. */
 	cache->alloc_offset = zone_info[0].alloc_offset;
 	cache->zone_capacity = zone_info[0].capacity;
+	cache->zone_is_active = test_bit(0, active);
 
 out:
 	/* An extent is allocated after the write pointer */
-- 
2.48.1


