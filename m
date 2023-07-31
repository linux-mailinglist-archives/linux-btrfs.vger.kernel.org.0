Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420E3769F47
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGaRUn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjGaRU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:28 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F31BC6
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823961; x=1722359961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wn9cLpoQSaBP3G0whOQaePZu6El+QdodnQ6bl3Zy3t0=;
  b=H4bq4MP+WyE2KCvHKg9nF3Bdd1Q7NX1j3jVTgVfAk/63FzYAUjq+zWq8
   YDJlXeOA4ZZ+CBbAyW/+0S5beiZcIOUOue5UQkwChNhUurWuKEkT2MOLf
   mQvs8lRjsVZ83MbRFw9ZAeqg9jjVHMGK53xtI5ZuuCvQ4euPr0bpwuuns
   3Z7+12cUwtmd6oTIeru5RMj8I/AN76mlxbgZNeGuLOoVkgGDN9e30bLVi
   NQ6ty/ew2KtxAIfpXHwOWHacnEuBx85UTwdjzz80v6URaYjxyhck/GqB4
   9hjPwlqALHBW/EV6wxRgJX53tMHOWj82zxH8Sppbr9tOoSJE3gDvIXo2/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269566"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:38 +0800
IronPort-SDR: X5OXbPFwE0ZAq/pb+9/UEUU9SHxpglasUUbKO+ijwvArEFo8hLSvNzXavx8gJ8lrH5Rbi/ygPu
 NAw2hRT1TnkFO8qKb7KZkY4Ohj5b9ZvIEX4Gd2XJ9aYwmJOccA1/SpiQq9zxf0evViAYYsrj2s
 6sXlMn78gqnW1NgKJCF8sv++VwZxrN0+D7dHt+exZoDqnw3jotoES8vxcraIPmnxddc8o6Rcl5
 F09fLQ24ZRt/aKTvUJdP+tBbQMyVKD1/9KtpH4G6/u51KZ/dlvJ9GwQrGTMc/yvyoGLj0AT9FG
 pes=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:15 -0700
IronPort-SDR: 3nZ8ZRfO+HHxhJb4+P0P/E7c6tCWY59Y58cp43UQbc3CHFy1BFUAsrK+WXnLpNvs2mk/vYs9Qh
 aRfCfduGy5UgDPQymF10e0rtCog5tqJjOgStrIiFkyXVgqLOW3NxHKQF2RkXqyWSBHg5vr8jmo
 keQWWXr8u5mWyJKk2xTGYB0JnvIzgPx/xhtG3IjoKqRmDoTijoNwnqoHWSgs9oF7SWvAFKDpb9
 Ybicj8LDO0nU9oLPdeYwaHg43u0iaW5gED/HtzUNPs586mkKQfUTndDJylGb6KCI4/sFH2yAC1
 cUg=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:38 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 06/10] btrfs: zoned: reserve zones for an active metadata/system block group
Date:   Tue,  1 Aug 2023 02:17:15 +0900
Message-ID: <790055decdb2cfa7dfaa3a47dd43b0a1f9129814.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690823282.git.naohiro.aota@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ensure a metadata and system block group can be activated on write time, by
leaving a certain number of active zones when trying to activate a data
block group.

When both metadata and system profiles are set to SINGLE, we need to
reserve two zones. When both are DUP, we need to reserve four zones.

In the case only one of them is DUP, we should reserve three zones.
However, handling the case requires at least two bits to track if we have
seen DUP profile for metadata and system, which is cumbersome. So, just
reserve four zones in that case for now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/fs.h    |  6 ++++++
 fs/btrfs/zoned.c | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ef07c6c252d8..2ce391959b6a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -775,6 +775,12 @@ struct btrfs_fs_info {
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
+	/*
+	 * Reserved active zones per-device for one metadata and one system
+	 * block group.
+	 */
+	unsigned int reserved_active_zones;
+
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3902c16b9188..9dbcd747ee74 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -525,6 +525,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		atomic_set(&zone_info->active_zones_left,
 			   max_active_zones - nactive);
 		set_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags);
+		/*
+		 * First, reserve zones for SINGLE metadata and SINGLE system
+		 * profile. The reservation will be increased when seeing DUP
+		 * profile.
+		 */
+		fs_info->reserved_active_zones = 2;
 	}
 
 	/* Validate superblock log */
@@ -1515,6 +1521,22 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 		cache->alloc_offset = alloc_offsets[0];
 		cache->zone_capacity = min(caps[0], caps[1]);
+
+		/*
+		 * DUP profile needs two zones on the same device. Reserve 2
+		 * zones * 2 types (metadata and system) = 4 zones.
+		 *
+		 * Technically, we can have SINGLE metadata and DUP system
+		 * config. And, in that case, we only need 3 zones, wasting one
+		 * active zone. But, to do the precise reservation, we need one
+		 * more variable just to track we already seen a DUP block group
+		 * or not, which is cumbersome.
+		 *
+		 * For now, let's be lazy and just reserve 4 zones.
+		 */
+		if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags) &&
+		    !(cache->flags & BTRFS_BLOCK_GROUP_DATA))
+			fs_info->reserved_active_zones = 4;
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -1888,6 +1910,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	struct btrfs_device *device;
+	const unsigned int reserved = (block_group->flags & BTRFS_BLOCK_GROUP_DATA) ?
+		fs_info->reserved_active_zones : 0;
 	u64 physical;
 	bool ret;
 	int i;
@@ -1917,6 +1941,15 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
+		/*
+		 * For the data block group, leave active zones for one
+		 * metadata block group and one system block group.
+		 */
+		if (atomic_read(&device->zone_info->active_zones_left) <= reserved) {
+			ret = false;
+			goto out_unlock;
+		}
+
 		if (!btrfs_dev_set_active_zone(device, physical)) {
 			/* Cannot activate the zone */
 			ret = false;
@@ -2111,6 +2144,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = fs_devices->fs_info;
 	struct btrfs_device *device;
+	const unsigned int reserved = (flags & BTRFS_BLOCK_GROUP_DATA) ?
+		fs_info->reserved_active_zones : 0;
 	bool ret = false;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -2131,10 +2166,10 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 
 		switch (flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		case 0: /* single */
-			ret = (atomic_read(&zinfo->active_zones_left) >= 1);
+			ret = (atomic_read(&zinfo->active_zones_left) >= (1 + reserved));
 			break;
 		case BTRFS_BLOCK_GROUP_DUP:
-			ret = (atomic_read(&zinfo->active_zones_left) >= 2);
+			ret = (atomic_read(&zinfo->active_zones_left) >= (2 + reserved));
 			break;
 		}
 		if (ret)
-- 
2.41.0

