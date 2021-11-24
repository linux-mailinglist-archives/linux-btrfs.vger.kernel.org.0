Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5945B776
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhKXJeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:13 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746263; x=1669282263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j4KoR74MjkwRH5xZ9AXequZ8I+gK/dyc8cRi2WBWtNo=;
  b=l/Hip4ZVBt6ZRtv/AQ62RSKyZq22LVxb7bGvFpBU7LZWotFgoWid33fI
   vXOddaujwdS5DAGL7OOrqKYV866g89EY4OKz2m/hGamtDe5wd9JnrzZwC
   jKFvYbkteQuW5fuWwJkxt/kdGwfP0tZnJPc5uh38LRvSxjIooItJZdz7M
   PNgou9Wa8n0VxxBm1G2RU94rwouZzNcJ9ox9VjzaG8GqBZKbrFf3U3cwA
   FdeMaTYKZ7CI+dwgDWt13U4URiHwdI6EEZWBERiid55IbphnZKXh4/VPk
   m8JoR82AX7gfljFY+oEwtapB7ZvtA6xWf5DJVq3Jd2uAE3P/zBTizWkvi
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499373"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:03 +0800
IronPort-SDR: fJKVASBYmolHy3T+UUF40eLE7yZ3o67/Q4XxQYd40KLjIyu+sipsy2Ji65xHViuOGkdi8zEidJ
 JIMrCqQCAh0THZVtCm8vmJzLU89Oy0B4U1fL6P2tc7faI2gVqK+prMbo1LH6fcgatGkZDa+oXJ
 szTWP42YYgXhg2ozYT5cJQFXLEoperIJ0fiAOdWB3MhIM4dNVA6ry+zmYXaIB+/fVRf0K+Kjb+
 6TEwkWIQKqqY+zv9U7I9fqaU+NJGV6k6hYdF2RUcsc8mcDfg7p0J8gjtjEQjZtPDwhk95YiGLj
 FalUIro7JWpyJf2zFS6zKNGY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:56 -0800
IronPort-SDR: sKpmhFJoNAih5OgKe0uH6ahqgcQyUWGc/JorgXJGqpbAXsty3JVVwIdp6kynLnMnREHK7cJLtM
 esTrNNZgIY3Amj5Mumgr6saKmLIZDnqL9tm8yi7dlPVr1vV6I5WSuJ6mWRV0yK0JIu0dNcpwsZ
 Wuh5eCw0zm6uyzkXmMq8CyF3b4TAakpovj9FslXsNO3PCf7LH7QtOLUKB/o3I9PVFVqh9GAuWh
 x6gpyaUt7llwSzyoXlVsWpJ5dG/QFrPbrPALNurb1eMGVo+i555n7+BRVoDYDZKF5QwzNHywQM
 8FE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:03 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 07/21] btrfs: zoned: move btrfs_finish_block_group_to_copy to zoned code
Date:   Wed, 24 Nov 2021 01:30:33 -0800
Message-Id: <1482f3cd38ca134c23c8969a27191a828fc2f64d.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_finish_block_group_to_copy is only used in a zoned filesystem so
move  the code  to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/dev-replace.c | 55 ------------------------------------------
 fs/btrfs/dev-replace.h |  3 ---
 fs/btrfs/zoned.c       | 55 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 10 ++++++++
 4 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7572d80bff2ac..1fcc5d57e96ef 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -460,61 +460,6 @@ static char* btrfs_dev_name(struct btrfs_device *device)
 		return rcu_str_deref(device->name);
 }
 
-bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
-				      struct btrfs_block_group *cache,
-				      u64 physical)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct extent_map *em;
-	struct map_lookup *map;
-	u64 chunk_offset = cache->start;
-	int num_extents, cur_extent;
-	int i;
-
-	/* Do not use "to_copy" on non zoned filesystem for now */
-	if (!btrfs_is_zoned(fs_info))
-		return true;
-
-	spin_lock(&cache->lock);
-	if (cache->removed) {
-		spin_unlock(&cache->lock);
-		return true;
-	}
-	spin_unlock(&cache->lock);
-
-	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
-	ASSERT(!IS_ERR(em));
-	map = em->map_lookup;
-
-	num_extents = cur_extent = 0;
-	for (i = 0; i < map->num_stripes; i++) {
-		/* We have more device extent to copy */
-		if (srcdev != map->stripes[i].dev)
-			continue;
-
-		num_extents++;
-		if (physical == map->stripes[i].physical)
-			cur_extent = i;
-	}
-
-	free_extent_map(em);
-
-	if (num_extents > 1 && cur_extent < num_extents - 1) {
-		/*
-		 * Has more stripes on this device. Keep this block group
-		 * readonly until we finish all the stripes.
-		 */
-		return false;
-	}
-
-	/* Last stripe on this device */
-	spin_lock(&cache->lock);
-	cache->to_copy = 0;
-	spin_unlock(&cache->lock);
-
-	return true;
-}
-
 static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
 		int read_src)
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 3911049a5f231..60b70dacc299b 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -18,8 +18,5 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
 void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
 int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
 int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
-bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
-				      struct btrfs_block_group *cache,
-				      u64 physical);
 
 #endif
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 73bfe30691b01..893d025069275 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2159,3 +2159,58 @@ int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 
 	return ret;
 }
+
+bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group *cache,
+				      u64 physical)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 chunk_offset = cache->start;
+	int num_extents, cur_extent;
+	int i;
+
+	/* Do not use "to_copy" on non zoned filesystem for now */
+	if (!btrfs_is_zoned(fs_info))
+		return true;
+
+	spin_lock(&cache->lock);
+	if (cache->removed) {
+		spin_unlock(&cache->lock);
+		return true;
+	}
+	spin_unlock(&cache->lock);
+
+	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	ASSERT(!IS_ERR(em));
+	map = em->map_lookup;
+
+	num_extents = cur_extent = 0;
+	for (i = 0; i < map->num_stripes; i++) {
+		/* We have more device extent to copy */
+		if (srcdev != map->stripes[i].dev)
+			continue;
+
+		num_extents++;
+		if (physical == map->stripes[i].physical)
+			cur_extent = i;
+	}
+
+	free_extent_map(em);
+
+	if (num_extents > 1 && cur_extent < num_extents - 1) {
+		/*
+		 * Has more stripes on this device. Keep this block group
+		 * readonly until we finish all the stripes.
+		 */
+		return false;
+	}
+
+	/* Last stripe on this device */
+	spin_lock(&cache->lock);
+	cache->to_copy = 0;
+	spin_unlock(&cache->lock);
+
+	return true;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e2309e3b3d7b8..bc9482cceadc4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -81,6 +81,9 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 				    struct btrfs_device *src_dev);
+bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group *cache,
+				      u64 physical);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -245,6 +248,13 @@ static inline int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 {
 	return 0;
 }
+
+static inline bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+					    struct btrfs_block_group *cache,
+					    u64 physical)
+{
+	return true;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

