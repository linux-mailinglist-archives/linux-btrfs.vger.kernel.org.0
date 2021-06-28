Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131113B5B0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhF1JQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:16:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24774 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhF1JQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624871642; x=1656407642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9RRQk3yZ4Y48nfJL3J2/6/8jUFLDivDGgF2d0vvesBg=;
  b=kykwIOIzzk8tBe3Fmhk0CH+PljWVQ+tQkWHS0m7qBDWKlMoSXj74+Nbb
   KbQayB7aAQbVH188pY3MtNeXa0jTaZ8VypsoxLpXKfW5j6IgCXFHshDmD
   90IaEzZeWkZYi9RvLLl44Pzv02cz4EtLf8cSFxvpdMeNjB/4jOBP/B/ia
   XHj7eHVeCPhlLE9KKOgoy+ulRknO3VqfhpRwzOuC8QoZe+enxobIzgInB
   IsD808lwddya7o1pmbAmTQtB7qzQvvY5kW4rWFfM23KNHEoeEh9rQLApE
   UL90z8MhuAWuvvSvt2jUcxSKX/KD+Q/O/8a39DevRKivwZZ5EvwIAPHV6
   Q==;
IronPort-SDR: tEgfNtVm5eHg7MqYk3b2i+cHuIW7Tm7FMHhpG6H8T5xIDenUzI9NPxXruolab2XlRgC/624Cze
 Ck//mJ7qOp4IFAiZniqWLQV8cLKoNpkJwtO9kccg/GMd4MKTNe8gCzTPCHcjmO0jlPmn5yue31
 FT2L2CIZTw7dYEE+ucMNVyGWerT2EzSXnGLJDnZun4Mh9cb0hjZB6JAZ2rh46BbYtk5ddOU0WQ
 /3VNqd2mlgBz7zfRsd4YSaYDqTKF3mLJaDAA/nl3pt/+N8S9ZnkICC2P/sfFRl+SF+ocrW9hR/
 KYo=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="276871728"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 17:14:01 +0800
IronPort-SDR: VAqquZzw55iUL/hmsg/+izh6RWFfGtxxtfoKPlP+Czb6RaLjx/8it9y8z4LPx/8J39dCn0Doe5
 yKLKi2Mb+4Kh3PIB3aLCFiGFxFnsFM5iJLBeZhUMpIAOLxW5otHAhPFDJ4VFtoS46l8JbuBqBn
 U1cj0eAhO8+p7+AgTzsgaYfODUcXrBRK+CZM8qNH6hraOiymA+3JZNzPY758fbVSp4xXBjov9a
 nS1qDWvVNQ5S1yrZkQxmaMEHK5sFnoVFUQX9Fck0sbzoR0TtpptBPUCoCu6p82iUvO/QmNN32X
 j8EeGxMXAryx+AcnDBShIfQj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 01:50:56 -0700
IronPort-SDR: v3S0QT6WqqcaJaLmVmHUY67ehvOT8qN7zWOdfe1ry6ajFH+ho0/R9FGkMQgbVq97tgdxVEZeJN
 vl7ytc+GoTKEoMW8comPc88iH+CmPvEKFi48qKxPKrc5TeGva9xCsTfttYh3N5CiBT8vKKlOjt
 +qgLWIcKgg5NyeJNKJCfgxlIc0xMGSZB/9LUObeKgf1JlGFu2xdLg+yMg92vlvZwd/3q2br57v
 jenetyMAtmm5RLzoxIFRjhpl31DNuAkVyOCmvVWcLt/LG3WKiH2bINqOxdJuNhaselcnu9VwBG
 MjE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2021 02:13:45 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: remove fs_info->max_zone_append_size
Date:   Mon, 28 Jun 2021 18:13:37 +0900
Message-Id: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove fs_info->max_zone_append_size, it doesn't serve any purpose.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h     | 2 --
 fs/btrfs/extent_io.c | 1 -
 fs/btrfs/zoned.c     | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d7ef4d7d2c1a..7a9cf4d12157 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1014,8 +1014,6 @@ struct btrfs_fs_info {
 		u64 zoned;
 	};
 
-	/* Max size to emit ZONE_APPEND write command */
-	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..1f947e24091a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3266,7 +3266,6 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 		return 0;
 	}
 
-	ASSERT(fs_info->max_zone_append_size > 0);
 	/* Ordered extent not yet created, so we're good */
 	ordered = btrfs_lookup_ordered_extent(inode, logical);
 	if (!ordered) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 297c0b1c0634..fa481d1ce524 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -619,7 +619,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
-	fs_info->max_zone_append_size = max_zone_append_size;
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	/*
@@ -1318,9 +1317,6 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	if (!btrfs_is_zoned(fs_info))
 		return false;
 
-	if (!fs_info->max_zone_append_size)
-		return false;
-
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
-- 
2.31.1

