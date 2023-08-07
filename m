Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92051772A3E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjHGQNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHGQMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D722107
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424774; x=1722960774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Duc/mcLPUOjbTaiSK+ncQxB3AJUf8nWjp7YXHJvgkvY=;
  b=D7Nt4CxdnCUle5Fu0i5FjKK6b8fYAe+FyB7r+7bvqQl4XrY0GwZklhQo
   kgmYiowHHwEcaCo57HVLnb4E39T+w4zpaD65eWy3h7/Oi3U/gIdymfEQQ
   Y2nTwbHggW9fke2uV62z2AuLx+e892OP1Rj210MLdIefNz2BTyQjFrxRJ
   ugNbz2txPeUCBJR98OqNDckZVx6LlpeiakU1OU5KamzqRGs1PUjPp6/ll
   g0o+2lEFEMy70fPiFS2qP98kyfe0jjrB+DyRdJyrFuRbymG+419Ef8JuX
   CxGCVxe1G7jiF941UiQRyWaPPU5hfr3Xx/sQGJwK4OyiKUx2Fbnls44gA
   A==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240711001"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:53 +0800
IronPort-SDR: IyEOGNZGq75OtsYr2WZwx81u9F7tS9CKgPkQHYWuXWmfrCC5knTwprhV/z02ygBE10XbwlpenN
 S2pi86O6EE7lp7xZu194vGaZxJIQhZTFpphuqK81Hy1VwvseRPVM5HG8AK0ovsyJK0EPczeJGw
 llioDK+Gr4BtjwqZ8L1FisN4sGh+SnJIsK5749h1+/jVGqlCQxfDC/Cxb2C9+fkuPRsYXryydm
 JA20sb6rwS+p6TzI/hp4oP1rn/M+Sd5VclpYoZ/sGfZiMNNysiranr3YgIbCC8Uf5em33Cl91Q
 JMQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:22 -0700
IronPort-SDR: 2Ix3tL/p7/R4j9MPAl4esQi7HJSykuTQBRWOJTxYKXhnecPp6c/AGW4wKLzgDDE8xXo9w/W48W
 5I1Npw5wXHgi83MjrZthKqsslvz+KE0lg8FzTPHIer5h7WZat9FgLxnsGnPXD80RnRdn9hkyhR
 bQXt+VUvZlDWCLv9FMuTvWA+klZys+Y9CKivXHOPS1JUcvpR1SuBHuW010Mc13CdXyfrR2lphw
 VBPBwDqb6OFGp8KIVXTq0zCJz9VhjdxXS7oNIlKXf24VRqze+ngpgs6E1zSp80Q3fadVR97Czb
 8wk=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:54 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 07/10] btrfs: zoned: activate metadata block group on write time
Date:   Tue,  8 Aug 2023 01:12:37 +0900
Message-ID: <caadbae6e3600d4858b81c40b531ef7b4dd94881.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index ef07c6c252d8..a523d64d5491 100644
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
index c9a1732469fd..4fa1590f71ac 100644
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
@@ -1747,6 +1750,64 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	}
 }
 
+static bool check_bg_is_active(struct btrfs_eb_write_context *ctx,
+			       struct btrfs_block_group **active_bg)
+{
+	const struct writeback_control *wbc = ctx->wbc;
+	struct btrfs_block_group *block_group = ctx->zoned_bg;
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
@@ -1781,8 +1842,26 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		ctx->zoned_bg = block_group;
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

