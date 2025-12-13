Return-Path: <linux-btrfs+bounces-19709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4606CBA4EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 06:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6453430CB837
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 05:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D449229B1F;
	Sat, 13 Dec 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TAJyi/r9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCC182D2
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765602215; cv=none; b=KyYCEr4K9VactpYZD4htDDjTk3PbCPPvUEStr57BtwT3uoUYD1QYcxykdr3qVNoSUupiGpcbWB8Yt4upX8iGOLiJEhmFNPwxSiSyi34RtrsiEjI92vmv5/pkRGpbct4HFObY8m5Zyj9yiZADhzb4OhMoqNhVK/zdpYzmVMhWH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765602215; c=relaxed/simple;
	bh=KhUSTImRRrVR2qA33VB+QOa8mWbcmlIFH5IHML52ra0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTA8uJqvZp6pQ8mULkkOrQ9ZSb60RPOBk3bQGxVd5dVOs8p/OhNVgH8Jftwj2o2NfsLKzvTBDXiv1QsuhMPwsZ20wurMGoLLmG5Z0HWXmMKhLpq9Kl4kTtIWaTKzlY5sldaLqoN0zeZxqMeeh3WPIS6eJodxVdw2pECH7rM3hVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TAJyi/r9; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765602214; x=1797138214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhUSTImRRrVR2qA33VB+QOa8mWbcmlIFH5IHML52ra0=;
  b=TAJyi/r9ssawq4gF2Tx7sB1i86ligsVKVxmYWXsByISidw4Q6oVSsYjg
   JhpRUk7X2rEDs4PVFX+2U18Of2fEA9VDkM7PQtIT/HYA5zigPdVFJ2kTC
   AF89675XdiuZ7TQVdmb50EpPfNC0hPSeYUHvRqSLZ0q5WBHnONUe13Xz1
   W1NFGfQYtRuulrxJ/xyqhTc321XvaoD7xzbRQsbFW4Cs4bCuCRHBQtj4M
   ega0PrN8duVxOT++ifwxArmpFB9Iagd3YTvVGpo1lKQKglfDmdHFYzWQC
   4b7TDW1PdtE6HliKvNZu1E5uMcSDTKgF4uLgIQElh5n9cYYF+9gCopEAM
   Q==;
X-CSE-ConnectionGUID: y/sBxMGBT8aZeagQM1N2dg==
X-CSE-MsgGUID: toDm9jK4Q0WYLTWdaAl1qQ==
X-IronPort-AV: E=Sophos;i="6.21,145,1763395200"; 
   d="scan'208";a="136986306"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2025 13:03:33 +0800
IronPort-SDR: 693cf3a5_4k6fiW7HLaxfr+bHpZvJCOTKh6JqCDzKuMc+CFcrQGn4DhK
 OOWe2BTcUVQhkJOZJnRyq1UuRtxarLlunO3A/Ug==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2025 21:03:34 -0800
WDCIronportException: Internal
Received: from 5cg21747lt.ad.shared (HELO neo.wdc.com) ([10.224.28.121])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2025 21:03:30 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable zones
Date: Sat, 13 Dec 2025 06:03:05 +0100
Message-ID: <20251213050305.10790-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the zoned stats are confined to the filesystems active zones
and not to the reclaimable zones.

Also print the zone information for the reclaimable zones.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6983e7177c0a..dd6a6a5f5b4e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2990,6 +2990,7 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 	struct btrfs_block_group *bg;
 	u64 data_reloc_bg;
 	u64 treelog_bg;
+	size_t reclaimable;
 
 	seq_puts(s, "\n");
 
@@ -3000,8 +3001,8 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 
 	mutex_lock(&fs_info->reclaim_bgs_lock);
 	spin_lock(&fs_info->unused_bgs_lock);
-	seq_printf(s, "\t  reclaimable: %zu\n",
-			     list_count_nodes(&fs_info->reclaim_bgs));
+	reclaimable = list_count_nodes(&fs_info->reclaim_bgs);
+	seq_printf(s, "\t  reclaimable: %zu\n", reclaimable);
 	seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unused_bgs));
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -3026,4 +3027,20 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 			   bg->zone_unusable, btrfs_space_info_type_str(bg->space_info));
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	if (reclaimable) {
+		seq_puts(s, "\treclaimable zones:\n");
+		mutex_lock(&fs_info->reclaim_bgs_lock);
+		spin_lock(&fs_info->unused_bgs_lock);
+		list_for_each_entry(bg, &fs_info->reclaim_bgs, list) {
+			spin_lock(&bg->lock);
+			seq_printf(s,
+					"\t    start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
+					bg->start, bg->alloc_offset, bg->used, bg->reserved,
+					bg->zone_unusable, btrfs_space_info_type_str(bg->space_info));
+			spin_unlock(&bg->lock);
+		}
+		spin_unlock(&fs_info->unused_bgs_lock);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
+	}
 }
-- 
2.52.0


