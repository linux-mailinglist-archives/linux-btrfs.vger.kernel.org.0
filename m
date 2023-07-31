Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894B4769F48
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjGaRUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjGaRU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:28 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9DC1BD8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823961; x=1722359961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nK7V7Tn6KE6BxwLrABnQTOtU9OSJbalKoDB3Z4vymww=;
  b=NLBJdeyZg768IWFNtGA9sdN7RHBLGmxy4Za4QvbcfWqCBgqJKTeG4KwW
   u6W5+GaHHwN+qkPZIxsU8vfAqRaJCXFQAeNmZDf+BcC5Zxq5Cj6dMBcxT
   iwCcuuDStDgmHbIXpHAkj+fz+s5QLVEsias/uTqRMZq6Um7EHlKGJvzmC
   8Ztnl1KRnJXWUfqanyA6ffCyu/u3PCJciNBFPHjQkNN5/LOseaRA9WhgQ
   EcF4DxvRab7FeKkdUwrzJ33MrMtd9kFLTj+U8eePjQTAnhtyMRETGROYu
   3t4wCXHYNqSsexlqCdugJJ4grKZi2fn3HKqBWtNt1gWnHwqgjcrw/qYLn
   A==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269568"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:39 +0800
IronPort-SDR: zCgs+M+LMVxMgex/PJx0JOKJ2r2DIbg6JgjocPOiSLx9Sp6LROZvz8icOYwrzbdBLeRVNoYT/a
 K9rKzrAQFHnQ+EXZjBFDJHyMM655tizOcOIuSBamsZLtD/BzN7TwNvbuag4LE9jBGJItyMyZQm
 As0HEzhnZfJFf9dHYDqAeaW319HC4H0EZHcRQL5yTI++ENjkGKyjm0ACQ6UgIP/ugU4QqkaRkT
 TChNUpHTWd867aVcicLpP5A0ahDNF/CXAGvhlQGbY54CaxcE/hIs35ZXU7Ue1M1qYL3ZG/zXpa
 D6g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:16 -0700
IronPort-SDR: VmmThoF8Fq0yGyx55eXZm31tQIOZnDiQNuTVUYJSo8UMySTxlNgCi1N1E9y8BKzqxTHQTWm+DX
 pqaxtefli0syEwXBwL+YA/4DqNEZwknkLr17FQSxcZlN+ujjgLJRYJYeKx8z1pbKNATvo+rOKf
 RvMIGs1+WhyzsbXLAUEU26F1Kmk0YBFkXci6Aozta2yluw1QwMBNm9pioNDrn8Kc77eZsP2QQj
 dDBcvj1oBjP2SoI1/3e716am6os/BluBFSXJ/yNh73aGp1ip6ffOOJOmdkjcprcQCBHFtMUgIt
 tEI=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 07/10] btrfs: zoned: activate metadata block group on write time
Date:   Tue,  1 Aug 2023 02:17:16 +0900
Message-ID: <15f3fcb8dee1563c78354c7aee64e3af19a6eb93.1690823282.git.naohiro.aota@wdc.com>
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

In the current implementation, block groups are activated at reservation
time to ensure that all reserved bytes can be written to an active metadata
block group. However, this approach has proven to be less efficient, as it
activates block groups more frequently than necessary, putting pressure on
the active zone resource and leading to potential issues such as early
ENOSPC or hung_task.

Another drawback of the current method is that it hampers metadata
over-commit, and necessitates additional flush operations and block group
allocations, resulting in decreased overall performance.

To address these issues, this commit introduces a write-time activation of
metadata and system block group. This involves reserving at least one
active block group specifically for a metadata and system block group.

Since metadata write-out is always allocated sequentially, when we need to
write to a non-active block group, we can wait for the ongoing IOs to
complete, activate a new block group, and then proceed with writing to the
new block group.

Fixes: b09315139136 ("btrfs: zoned: activate metadata block group on flush_space")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 11 ++++++
 fs/btrfs/fs.h          |  3 ++
 fs/btrfs/zoned.c       | 83 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a127865f49f9..b0e432c30e1d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4287,6 +4287,17 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_caching_control *caching_ctl;
 	struct rb_node *n;
 
+	if (btrfs_is_zoned(info)) {
+		if (info->active_meta_bg) {
+			btrfs_put_block_group(info->active_meta_bg);
+			info->active_meta_bg = NULL;
+		}
+		if (info->active_system_bg) {
+			btrfs_put_block_group(info->active_system_bg);
+			info->active_system_bg = NULL;
+		}
+	}
+
 	write_lock(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
 		caching_ctl = list_entry(info->caching_block_groups.next,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 2ce391959b6a..bcb43ba55ef6 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -770,6 +770,9 @@ struct btrfs_fs_info {
 	u64 data_reloc_bg;
 	struct mutex zoned_data_reloc_io_lock;
 
+	struct btrfs_block_group *active_meta_bg;
+	struct btrfs_block_group *active_system_bg;
+
 	u64 nr_global_roots;
 
 	spinlock_t zone_active_bgs_lock;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9dbcd747ee74..91eca8b48715 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -65,6 +65,9 @@
 
 #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
 
+static void wait_eb_writebacks(struct btrfs_block_group *block_group);
+static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written);
+
 static inline bool sb_zone_is_full(const struct blk_zone *zone)
 {
 	return (zone->cond == BLK_ZONE_COND_FULL) ||
@@ -1769,6 +1772,64 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	}
 }
 
+static bool check_bg_is_active(struct btrfs_eb_write_context *ctx,
+			       struct btrfs_block_group **active_bg)
+{
+	const struct writeback_control *wbc = ctx->wbc;
+	struct btrfs_block_group *block_group = ctx->block_group;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
+		return true;
+
+	if (fs_info->treelog_bg == block_group->start) {
+		if (!btrfs_zone_activate(block_group)) {
+			int ret_fin = btrfs_zone_finish_one_bg(fs_info);
+
+			if (ret_fin != 1 || !btrfs_zone_activate(block_group))
+				return false;
+		}
+	} else if (*active_bg != block_group) {
+		struct btrfs_block_group *tgt = *active_bg;
+
+		/*
+		 * zoned_meta_io_lock protects fs_info->active_{meta,system}_bg.
+		 */
+		lockdep_assert_held(&fs_info->zoned_meta_io_lock);
+
+		if (tgt) {
+			/*
+			 * If there is an unsent IO left in the allocated area,
+			 * we cannot wait for them as it may cause a deadlock.
+			 */
+			if (tgt->meta_write_pointer < tgt->start + tgt->alloc_offset) {
+				if (wbc->sync_mode == WB_SYNC_NONE ||
+				    (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync))
+					return false;
+			}
+
+			/* Pivot active metadata/system block group. */
+			btrfs_zoned_meta_io_unlock(fs_info);
+			wait_eb_writebacks(tgt);
+			do_zone_finish(tgt, true);
+			btrfs_zoned_meta_io_lock(fs_info);
+			if (*active_bg == tgt) {
+				btrfs_put_block_group(tgt);
+				*active_bg = NULL;
+			}
+		}
+		if (!btrfs_zone_activate(block_group))
+			return false;
+		if (*active_bg != block_group) {
+			ASSERT(*active_bg == NULL);
+			*active_bg = block_group;
+			btrfs_get_block_group(block_group);
+		}
+	}
+
+	return true;
+}
+
 /*
  * Check @ctx->eb is aligned to the write pointer
  *
@@ -1803,8 +1864,26 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		ctx->block_group = block_group;
 	}
 
-	if (block_group->meta_write_pointer == eb->start)
-		return 0;
+	if (block_group->meta_write_pointer == eb->start) {
+		struct btrfs_block_group **tgt;
+
+		if (!test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags))
+			return 0;
+
+		if (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			tgt = &fs_info->active_system_bg;
+		else
+			tgt = &fs_info->active_meta_bg;
+		if (check_bg_is_active(ctx, tgt))
+			return 0;
+	}
+
+	/*
+	 * Since we may release fs_info->zoned_meta_io_lock, someone can already
+	 * start writing this eb. In that case, we can just bail out.
+	 */
+	if (block_group->meta_write_pointer > eb->start)
+		return -EBUSY;
 
 	/* If for_sync, this hole will be filled with trasnsaction commit. */
 	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
-- 
2.41.0

