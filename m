Return-Path: <linux-btrfs+bounces-20965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG1PCPZwc2lNvwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20965-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 14:00:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303476167
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 14:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 630663036EA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE302F12D9;
	Fri, 23 Jan 2026 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XRe998mL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE92EFD90
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173199; cv=none; b=EtOan9ny/bJ7G4stf0mZn1mvuizhAUA0UgT3opfAtzoG2h6o9tdE4RDrA4ADxfwydOetIwqNCNQSLiMEZMMApRfxdq9TH41vIb5lgRNLD2kLvKkqhRXRRd8Vy/ikPpAv394Cw3pcZbZ+49R4hGaIvj6RRFKLEuJCFhH4SAL4Iy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173199; c=relaxed/simple;
	bh=iWxtq2ppKIdJju6TsMJSqC/VNkv4nfu+jkwSru+LKl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljwmUGzhtuEtXOZoqtKZIR83MFCFEEUn3sk15V+/hMi75dxuwFwh9unLT/kb3BegZmnGoLZ+GCev7m4TA1t3tioLTHtIGC5nDrLsIQNA0bSGrKxj6NIzFj0Pxi/V5HAW0glfo9fDo4wI5tU8vtUmcG0ICnnkTIc/lE1sEeK0aJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XRe998mL; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769173196; x=1800709196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWxtq2ppKIdJju6TsMJSqC/VNkv4nfu+jkwSru+LKl4=;
  b=XRe998mL21Gys1mfjlgxkYwY2awstTGVYiX4joisY++6keCjO6Z0Qo4S
   wljQ6Yy9m5Jc5ufpUrsMQWSarS/TkmakncEYXzHSboaZtYHDT8C4QcsCm
   VcmObjQc0Lqu31TiP2mIOaVRAfvbqFxfxjtaVSCu/LxOawEHmQ+kmJ1lY
   ZP6LsPyjkSOSxA/FO1B9lGojGtnz2WkjqWDUIBGNcq5dvMVbyRDV4Hg4o
   hMhuVgg19oFNTzHht+uFuABiAEWM8bNAS9oU7Cv3+1fDvMZcNJYwtVLN0
   KKod2omYTJnwiv0/v38xyLigpqzR2SQ5Z6NXCinHX7EF+FKBPZJNzxJpG
   g==;
X-CSE-ConnectionGUID: wLHvIHBcTui34HrT2xzwIw==
X-CSE-MsgGUID: 7BrHyNxmSQql66T5jqsUFg==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="138590780"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2026 20:59:49 +0800
IronPort-SDR: 697370c7_1zwTp2YuYX37k1489U63QolrcVfwlQc+e1ox5TE/XsVdHL1
 BJY2X87pA6ekKwDi1IOrugdhMS8MBbEPSGFXjMg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 04:59:51 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jan 2026 04:59:52 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs: zoned: factor out the zone loading part into a testable function
Date: Fri, 23 Jan 2026 21:59:19 +0900
Message-ID: <20260123125920.4129581-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123125920.4129581-1-naohiro.aota@wdc.com>
References: <20260123125920.4129581-1-naohiro.aota@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20965-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 8303476167
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


