Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B589C56C554
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiGHXTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGHXTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024EC41985;
        Fri,  8 Jul 2022 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322353; x=1688858353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aD1/CtJv1bF7AYbarhWHVXAHA6ubkFe6OSBHGSFbDGM=;
  b=IP6hZdSRNOE5IZMGbUlB8emu1KLhGEn/FUZvrEcM7JfFGyrekWwBXL/N
   sPU8CfRnqyriQxDfoW3WWGUxHQicV1eE5/uw8Pp5nZUvQ954RTfuLFxwu
   +nMo3OVEW5G04VkdDCDZomCmi2zvp36lQd9w2ZpLv9G0FHuucW0FKmQS2
   k0PvOQeZlaInoys6r8CmF1a7U7pKwuwvMCtY7JfcnfZpTdUnvyxWU7x2o
   ncQ7nWMhOgdnUyDJS7LdgRTcKDjKYDXySnfbtbNFG0aexMACrQxZwHAzX
   fDHNYDsmPysgacccrTGqK9fhytyGVP1J1pupD3VHepmx73SL5QHeSb8gQ
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871828"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:11 +0800
IronPort-SDR: In8/ZcGRtTTVUzD/3L5E+BH588ALRlur2VgpBsUgraDG5tveofyTZ1hAWpzF8lb/3V2zltCdh9
 64wCdSnUuvD2uWURBKlMAEJF2QhC0PaU8r/CGrAnHFBCeFK3JgupRegZ34f1j8aqBrKT4OSWOr
 zm6Ow5ae6FNOH9IcsmWpJvhFDtIU1OGlWucu2UTVtS7OEHwLlV0DWAGjuh/XUtGxweJ1IZS/2I
 3+goOgXkU8QUE8CR8aXT+UisGBrjI7mNaLPPYdh3kxebUdwfe0uGphpjLy6EIwbXUnJvTogshc
 XeO5o6ge+kFslLpwG7MISY60
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:17 -0700
IronPort-SDR: xRp6S7WUUY7hjI+kbGIPRH4P3GT7qgZTYLNsM+bg65OqHS7B8cbOAv5X765eNk9w6v2mR4dlpe
 1mAJ6czy/wfEPDAsWMOjK0GSE8dT0+laEAgO1ziikM0PDcBZe7BYuaUGO/m38JUypeuGpwBB5t
 VtOeT4eYAuRbSjIcLD3O2/IbllLXuB2IXVujDa/lYoD9iJtp5xnjH/TH9r73us+oUrzOgQB24w
 GZNhLuOep02dCEQhEJzVa4TSj+tGJuQXxA+9BZcod7JneAu+VuIhbcABmfXSAKcieeM6bu9VRN
 1MM=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/13] btrfs: zoned: finish least available block group on data BG allocation
Date:   Sat,  9 Jul 2022 08:18:44 +0900
Message-Id: <b2d700b69a489077717814c5c743e474c283e27e.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we run out of active zones and no sufficient space is left in any
block groups, we need to finish one block group to make room to activate a
new block group.

However, we cannot do this for metadata block groups because we can cause a
deadlock by waiting for a running transaction commit. So, do that only for
a data block group.

Furthermore, the block group to be finished has two requirements. First,
the block group must not have reserved bytes left. Having reserved bytes
means we have an allocated region but did not yet send bios for it. If that
region is allocated by the thread calling btrfs_zone_finish(), it results
in a deadlock.

Second, the block group to be finished must not be a SYSTEM block
group. Finishing a SYSTEM block group easily breaks further chunk
allocation by nullifying the SYSTEM free space.

In a certain case, we cannot find any zone finish candidate or
btrfs_zone_finish() may fail. In that case, we fall back to split the
allocation bytes and fill the last spaces left in the block groups.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 49 +++++++++++++++++++++++++++++++++---------
 fs/btrfs/zoned.c       | 40 ++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  7 ++++++
 3 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c8f26ab7fe24..5589e04eda0e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3965,6 +3965,44 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	}
 }
 
+static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
+				    struct find_free_extent_ctl *ffe_ctl)
+{
+	/* If we can activate new zone, just allocate a chunk and use it */
+	if (btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
+		return 0;
+
+	/*
+	 * We already reached the max active zones. Try to finish one block
+	 * group to make a room for a new block group. This is only possible for
+	 * a data BG because btrfs_zone_finish() may need to wait for a running
+	 * transaction which can cause a deadlock for metadata allocation.
+	 */
+	if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) {
+		int ret = btrfs_zone_finish_one_bg(fs_info);
+
+		if (ret == 1)
+			return 0;
+		else if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * If we have enough free space left in an already active block group
+	 * and we can't activate any other zone now, do not allow allocating a
+	 * new chunk and let find_free_extent() retry with a smaller size.
+	 */
+	if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size)
+		return -ENOSPC;
+
+	/*
+	 * We cannot activate a new block group and no enough space left in any
+	 * block groups. So, allocating a new block group may not help. But,
+	 * there is nothing to do anyway, so let's go with it.
+	 */
+	return 0;
+}
+
 static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 			      struct find_free_extent_ctl *ffe_ctl)
 {
@@ -3972,16 +4010,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return 0;
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		/*
-		 * If we have enough free space left in an already
-		 * active block group and we can't activate any other
-		 * zone now, do not allow allocating a new chunk and
-		 * let find_free_extent() retry with a smaller size.
-		 */
-		if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size &&
-		    !btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
-			return -ENOSPC;
-		return 0;
+		return can_allocate_chunk_zoned(fs_info, ffe_ctl);
 	default:
 		BUG();
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3b45b35aa945..40ac90272b53 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2179,3 +2179,43 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 	spin_unlock(&block_group->lock);
 	btrfs_put_block_group(block_group);
 }
+
+int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_group *block_group;
+	struct btrfs_block_group *min_bg = NULL;
+	u64 min_avail = U64_MAX;
+	int ret;
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	list_for_each_entry(block_group, &fs_info->zone_active_bgs,
+			    active_bg_list) {
+		u64 avail;
+
+		spin_lock(&block_group->lock);
+		if (block_group->reserved ||
+		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)) {
+			spin_unlock(&block_group->lock);
+			continue;
+		}
+
+		avail = block_group->zone_capacity - block_group->alloc_offset;
+		if (min_avail > avail) {
+			if (min_bg)
+				btrfs_put_block_group(min_bg);
+			min_bg = block_group;
+			min_avail = avail;
+			btrfs_get_block_group(min_bg);
+		}
+		spin_unlock(&block_group->lock);
+	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	if (!min_bg)
+		return 0;
+
+	ret = btrfs_zone_finish(min_bg);
+	btrfs_put_block_group(min_bg);
+
+	return ret < 0 ? ret : 1;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 9caeab07fd38..329d28e2fd8d 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -80,6 +80,7 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
+int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -249,6 +250,12 @@ static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 
 static inline void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info,
 						     u64 logical, u64 length) { }
+
+static inline int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
+{
+	return 1;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

