Return-Path: <linux-btrfs+bounces-11496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD052A379CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8250D188FB4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02615573A;
	Mon, 17 Feb 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TzkBxIFO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EC14A0B3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759877; cv=none; b=kqHeb63udIuCFoyYQBiQi3hYzOkLMp2oa6IJ6t79ENFYBXJ+bkNrRcoyt/j9cphEfETvR69vWPy7zvQS8XBn7fb9ROZH7bzcg3UAgXkOwIqjtKPv9FNV3sx1skqUbVHHXRsRCx4ErAXJ56VxDrgG/Wf/eUiDg4h133+d2ESNISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759877; c=relaxed/simple;
	bh=wrHS5cUCM5L5AttiYjQt+RQCbR4CsmRd5QhN57OxLzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKRGiBlwn/Lgs/efRfXWJm8tTuNihcbVnHB/dLnuX6gUqy22cEwupFdb4zDWq2K6BX8deHyDmD3hvkSNli56oKeiW2Wy3AOZ1r7xo/PZtE6Z423UaofGOzFdCihG7L5hz+tK/KCyeUCDak0jCK/uPqiZecPkcqpZt/bSHXpksyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TzkBxIFO; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759875; x=1771295875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrHS5cUCM5L5AttiYjQt+RQCbR4CsmRd5QhN57OxLzc=;
  b=TzkBxIFOcA3kNvEk8lx93tgwj43h9+FnjYJuv10KC3pH6kbwTCKjs2MH
   ZDrIbjFQv+6DL+DnncmHPBSSsfYGeuSIE9/RiSfWnxgaxQ8lMf6U4S9RI
   e7PtMfdewxkoMrGQIJw+zkKqbUEDrqtONtDPSWTuguPEHZBoD7veQa6C/
   83ZVszgT7L14MhnhLBvzyBbwyrUVaDuSumbZfGO8xcEGEOLk2lGZ0Zpyl
   u6/LCgZpG94SF/C9bdXU0ICXf0HVVf5a0MuHRZlHyjJ9yjZgJOm9murde
   qCB6IklAtmLcZqpn5jBu/2dZxZVOEYe67CWVj6TjU6QuvqYc4yXh+wjuG
   g==;
X-CSE-ConnectionGUID: maucAVaaRo6BJZcxVb8K7Q==
X-CSE-MsgGUID: K7kFAUbUQ1azQxwFhaTHSg==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877178"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:52 +0800
IronPort-SDR: 67b29348_/H5eR4if2t2y/PGizk+GZzeS61z1fdhp2u9X8bBADhHes3h
 DpcRjcWBQbDfDydLQI8OjvHZCJJRJcmEXaTF3dA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:20 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:51 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/12] btrfs-progs: zoned: activate block group on loading
Date: Mon, 17 Feb 2025 11:37:35 +0900
Message-ID: <0a272ad61dca26d4ee7f1e7ba474685b21825a05.1739756953.git.naohiro.aota@wdc.com>
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


