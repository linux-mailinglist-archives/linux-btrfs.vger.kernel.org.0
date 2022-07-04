Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C5564CDA
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiGDE65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiGDE6w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:52 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E85FA4
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910731; x=1688446731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WhP92MmgPzjZ/GqG4lrRI9mzxR6+K32bGORHMqYyUeA=;
  b=JI7zrGGGUslkpKPKzYDhRRA1HdUQZ2hdw0KwV9lSssXK4XKDMg+dUQAW
   Ty0idcqIw+Zg2I5Lo9oo57o1ELu9UaucRk71CjAxwLD4QGuFZ9Ye6qwQc
   /wdXLDhYeoSJfWM03t+hBEEJ4k7A99m6m/fxKa703xpOuVa0gWENeyFJ3
   PkQcYlFBGuKHvl0K9Q/Jum4iAh0E/keF2aOGgQvODtyTMONWDRlYL/5a1
   iwdyUxxShIN1kJ7wVp0UMA1OVI2/P4eEux6IrfGd04VSZuoRqbo6rkMtS
   EgocqBBC90LKeHMvi6pW6OyltpTV6Z4xhTCC1gr6OE3cS+M+at/ZwcA8p
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732407"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:51 +0800
IronPort-SDR: z9/j/2SVyg3CiiJ5m1ycF+4rj/JgeTjF/j8Ai5ZNNQn2iTKD72uwWhGIfBf5RbcbrMAzNqP4+x
 rzazxsDS8TFtRJzIsbEBSQPZpPQqZsh8etNYjj6xwT2W9CGw5JqZWkSsiJQxLiMvhLANW4E9yd
 +TCIJAw1KMYaeH+Ow/EugvpesiH50Oh9q/hYkHSDMT8wSjbSljEztD4s7iaycTwIRy70anelVQ
 0xru6yk4jI88gRfiQMw7UOBPbG9wngLlzGDk7NYIh6qYOeQ4uJzP/qNhdSXBJgHrHsVffHpaMm
 J/OniO7GL2jUfHxStfyXh9sJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:44 -0700
IronPort-SDR: oAOwd3DkdVU3RF/1THcwhOrxq9AwjsIw2RtM/PCWTxEqLU2doZsnX2hFvKJjCeUilzpMVyATiX
 EVCYTNg4NNa0IVdSBB6I8u2Bmotuev8+XgZpBOHkQqs8Qh0Pko3uF8fXgsIllyumK9sSYU8Vf0
 mtPOTwrnGIHGU9Jkhg8VHXRm37qB6iZWbheEzTAokMp3eXj2q5YxdYAKpMAurVEmQAKR5G/AYr
 r/yIwaqYK9pU6QhvB+7mDkrTHiCzRbA50UD4zxB3Huia8gULIW3JP9WMZq1LxpfJDj/lxr+j9z
 EQU=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/13] btrfs: zoned: finish least available block group on data BG allocation
Date:   Mon,  4 Jul 2022 13:58:11 +0900
Message-Id: <f246521cb4a2720f8f3663679d6331d2b4b13f17.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent-tree.c | 43 ++++++++++++++++++++++++++++++++----------
 fs/btrfs/zoned.c       | 40 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  7 +++++++
 3 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c8f26ab7fe24..62e75c1d1155 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3965,6 +3965,38 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
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
+	if ((ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) && btrfs_finish_one_bg(fs_info))
+		return 0;
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
@@ -3972,16 +4004,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
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
index eb5a612ea912..4a69e8492177 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2178,3 +2178,43 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 	spin_unlock(&block_group->lock);
 	btrfs_put_block_group(block_group);
 }
+
+bool btrfs_finish_one_bg(struct btrfs_fs_info *fs_info)
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
+		return false;
+
+	ret = btrfs_zone_finish(min_bg);
+	btrfs_put_block_group(min_bg);
+
+	return ret == 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 9caeab07fd38..09a19772ee68 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -80,6 +80,7 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
+bool btrfs_finish_one_bg(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -249,6 +250,12 @@ static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 
 static inline void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info,
 						     u64 logical, u64 length) { }
+
+static inline bool btrfs_finish_one_bg(struct btrfs_fs_info *fs_info)
+{
+	return true;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

