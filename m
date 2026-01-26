Return-Path: <linux-btrfs+bounces-21050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C4sJ9cAd2lQaQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21050-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 06:51:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45970843C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 06:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0B5301FF9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21822E406;
	Mon, 26 Jan 2026 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qz1jy5d3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B9230BD5
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406642; cv=none; b=siPGmVt8eyRXgKJrTDRGx4uTune+IPRa3LZWXWRrtKMWIUVGlUgaLc6FezKU+mIwYAGmuFbiwmfFsygbPHGGcwOoO78L2dMt0kgI73AKHAwnaHUwVijjfwz93ksoKjRnVhLGqyDIEElBCePuCbC9q2PvZ4h1AOA+ZMGq9CJV8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406642; c=relaxed/simple;
	bh=iWxtq2ppKIdJju6TsMJSqC/VNkv4nfu+jkwSru+LKl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITfyX3CxBubEizksTD4UW2acxW/XQDzuyxbeSo+hQnplf6FzDJdHAwHXli/X42MflwFke4ySJyUcGu3nyTOIudNrfFBw5v3auIkLLZAtBQD3N2XAIRETWKVwhZj//VRIQuWKHw9BSfhE3m4e8ulkEJTQmbfQPEsLMTqGm9ZJilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qz1jy5d3; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769406641; x=1800942641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWxtq2ppKIdJju6TsMJSqC/VNkv4nfu+jkwSru+LKl4=;
  b=qz1jy5d3RH+yQdepWtMPIc9ztCwAgjE0f5hkeo8r3msm9amj4yJvS7oA
   44PxwSWJCF/DANQcdnGWY+hdBBbU/toux1GYPkVp5vV0nt5YbX7ETpmb+
   ioVw4k980sL316iNXwebr11tc6kFbzcVDHnhPu0nPDzlv+N4QY/sTOpMu
   iQtYQTK9xF7ccQJQLwsrTADUJCmeWHixmUPTs2jJbQ67xOyfyVLA0ZOyO
   Dex0PNdFLNOe/7d+tg9Fov8r+Np7y0XZ3/8uCr0l2H/H6PhxcnJ/Nl1E0
   puIGTeo6jq9CgEppVajZbwPq5dSAC4z0F7GdpxZYxhwwXrhDN13oLpKB/
   A==;
X-CSE-ConnectionGUID: /DHa3+3kQY+lkgo0Ev+3pw==
X-CSE-MsgGUID: hB57QR3+Qha9i2djshi6TA==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="139468893"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2026 13:50:33 +0800
IronPort-SDR: 697700a9_0ImnrEVGALuw/zKEpBPMeLNszOsSb2TxVSFnXxmmJWI8tpV
 FFmvEclYGo9O7USFZydOzsDVSKfD/1bCBwBcBtw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2026 21:50:33 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2026 21:50:33 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/4] btrfs: zoned: factor out the zone loading part into a testable function
Date: Mon, 26 Jan 2026 14:49:52 +0900
Message-ID: <20260126054953.2245883-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126054953.2245883-1-naohiro.aota@wdc.com>
References: <20260126054953.2245883-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21050-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45970843C1
X-Rspamd-Action: no action

Separate btrfs_load_block_group_* calling path into a function, so that it
can be an entry point of unit test.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 109 ++++++++++++++++++++++++++---------------------
 fs/btrfs/zoned.h |   9 ++++
 2 files changed, 70 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 576e8d3ef69c..052d6988ab8c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1812,6 +1812,65 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 	return 0;
 }
 
+EXPORT_FOR_TESTS
+int btrfs_load_block_group_by_raid_type(struct btrfs_block_group *bg,
+					struct btrfs_chunk_map *map,
+					struct zone_info *zone_info,
+					unsigned long *active, u64 last_alloc)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 profile;
+	int ret;
+
+	profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+	switch (profile) {
+	case 0: /* single */
+		ret = btrfs_load_block_group_single(bg, &zone_info[0], active);
+		break;
+	case BTRFS_BLOCK_GROUP_DUP:
+		ret = btrfs_load_block_group_dup(bg, map, zone_info, active, last_alloc);
+		break;
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		ret = btrfs_load_block_group_raid1(bg, map, zone_info, active,
+						   last_alloc);
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		ret = btrfs_load_block_group_raid0(bg, map, zone_info, active,
+						   last_alloc);
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		ret = btrfs_load_block_group_raid10(bg, map, zone_info, active,
+						    last_alloc);
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+	default:
+		btrfs_err(fs_info, "zoned: profile %s not yet supported",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
+	if (ret == -EIO && profile != 0 && profile != BTRFS_BLOCK_GROUP_RAID0 &&
+	    profile != BTRFS_BLOCK_GROUP_RAID10) {
+		/*
+		 * Detected broken write pointer.  Make this block group
+		 * unallocatable by setting the allocation pointer at the end of
+		 * allocatable region. Relocating this block group will fix the
+		 * mismatch.
+		 *
+		 * Currently, we cannot handle RAID0 or RAID10 case like this
+		 * because we don't have a proper zone_capacity value. But,
+		 * reading from this block group won't work anyway by a missing
+		 * stripe.
+		 */
+		bg->alloc_offset = bg->zone_capacity;
+	}
+
+	return ret;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -1824,7 +1883,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
-	u64 profile;
 
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
@@ -1884,53 +1942,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 	}
 
-	profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
-	switch (profile) {
-	case 0: /* single */
-		ret = btrfs_load_block_group_single(cache, &zone_info[0], active);
-		break;
-	case BTRFS_BLOCK_GROUP_DUP:
-		ret = btrfs_load_block_group_dup(cache, map, zone_info, active,
-						 last_alloc);
-		break;
-	case BTRFS_BLOCK_GROUP_RAID1:
-	case BTRFS_BLOCK_GROUP_RAID1C3:
-	case BTRFS_BLOCK_GROUP_RAID1C4:
-		ret = btrfs_load_block_group_raid1(cache, map, zone_info,
-						   active, last_alloc);
-		break;
-	case BTRFS_BLOCK_GROUP_RAID0:
-		ret = btrfs_load_block_group_raid0(cache, map, zone_info,
-						   active, last_alloc);
-		break;
-	case BTRFS_BLOCK_GROUP_RAID10:
-		ret = btrfs_load_block_group_raid10(cache, map, zone_info,
-						    active, last_alloc);
-		break;
-	case BTRFS_BLOCK_GROUP_RAID5:
-	case BTRFS_BLOCK_GROUP_RAID6:
-	default:
-		btrfs_err(fs_info, "zoned: profile %s not yet supported",
-			  btrfs_bg_type_to_raid_name(map->type));
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (ret == -EIO && profile != 0 && profile != BTRFS_BLOCK_GROUP_RAID0 &&
-	    profile != BTRFS_BLOCK_GROUP_RAID10) {
-		/*
-		 * Detected broken write pointer.  Make this block group
-		 * unallocatable by setting the allocation pointer at the end of
-		 * allocatable region. Relocating this block group will fix the
-		 * mismatch.
-		 *
-		 * Currently, we cannot handle RAID0 or RAID10 case like this
-		 * because we don't have a proper zone_capacity value. But,
-		 * reading from this block group won't work anyway by a missing
-		 * stripe.
-		 */
-		cache->alloc_offset = cache->zone_capacity;
-	}
+	ret = btrfs_load_block_group_by_raid_type(cache, map, zone_info, active,
+						  last_alloc);
 
 out:
 	/* Reject non SINGLE data profiles without RST */
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 2fdc88c6fa3c..8e21a836f858 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -99,6 +99,15 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes);
 void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *seq);
 
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+struct zone_info;
+
+int btrfs_load_block_group_by_raid_type(struct btrfs_block_group *bg,
+					struct btrfs_chunk_map *map,
+					struct zone_info *zone_info,
+					unsigned long *active, u64 last_alloc);
+#endif
+
 #else /* CONFIG_BLK_DEV_ZONED */
 
 static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
-- 
2.52.0


