Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330A675EA73
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGXETI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGXETC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24545138
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172341; x=1721708341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23BEuDCqBU7IvYdp5r+d7/FJLJ9D5r6G2Ogo5cX2Qmg=;
  b=IZy4cFSER/pjI7bcQ5LwyEZaOtLEim98IECbxZdQckKj5FqbalmcDbbZ
   I1L+6mr2wt8UkqxX5ihfO1cuyyics5nf7C7Kb2LSwnfjSFE6VrpcucRbx
   hihzreERzs/VBRfrKY8N5Bvp+hRKTyRM0H1+NvW3CnmtjM3WSduYC40Mb
   PAhDZhi8esVe60O/by0NlQ3yoQ3avIKDMjfpreJdhhej9EdfsE4OD85+G
   1pUJFLDZGCyedsg2o8yWJBNqFIT+ospdz6uXS+ZhymfRK790M81cnXZkb
   xEOVxTG6aY74mF5IOlNwE8Eqx9q2uQ/j/+Msc9vYdw/EspKNEt6F/003V
   A==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524375"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:19:00 +0800
IronPort-SDR: RBPr+o36lvmnARnzg0/ct3lhfU1T1I+LLmOfeGrnK2QH33zBG4agO5qeEVPJnbiPx1a0ZGRtgX
 ykVsUDvVx6rh4lxEs47mZ+f9w6uVGUc5s4XGwq8yY70Ypw39il0kwNV8F6kpVPCPCN4rk3ufNg
 7jCtvc320IvXgOc2cLW+dZ0XPbvBQ5Yb0oY4D2phJRpGhsQ9/RTO5exi+FEYKII/BKocoEP4Dc
 YWqzDaWo0U/1Qd7LWWa+sSa5/XZj+y3eybXbb+UVQXImvP6dyuCM72tTs8J2PGNoU+bnTYcKIW
 0lk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:06 -0700
IronPort-SDR: YDfBC7j7c4ipKQGO47DkUiSYuHKUax7RGxwfqlKed+7Z6B7sebVswLsbR+4vUK2guT8IcrMmiz
 vsPerxp3CeOvFzHaJ16sgm8m3tyCwdixvO5muJfPRVFJjuWPhX0WGKK4pvPT54vRHmFYSAqY77
 aaMj952GyZd9eRQxyhXfajwU3BhuYN2w8AZFtaSFJzb0tXPYQEUFnc1KPCXo0CdDYJjtO7gRew
 T5QE5exDI0kvX2lIbNQwuI2yjM9tvt3FOt+Okb/NU5XwPVPx0w94VhSj+oecjX3VQKbjYA+gac
 cdk=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:19:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 5/8] btrfs: zoned: activate metadata block group on write time
Date:   Mon, 24 Jul 2023 13:18:34 +0900
Message-ID: <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690171333.git.naohiro.aota@wdc.com>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
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
 fs/btrfs/block-group.c | 11 +++++++
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/fs.h          |  3 ++
 fs/btrfs/zoned.c       | 72 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  1 +
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 91d38f38c1e7..75f8482f45e5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4274,6 +4274,17 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
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
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 46a0b5357009..3f104559c0cc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1894,7 +1894,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!ret)
 		return 0;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, bg_context)) {
+	if (!btrfs_check_meta_write_pointer(eb->fs_info, wbc, eb, bg_context)) {
 		/*
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..1f2d33112106 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -766,6 +766,9 @@ struct btrfs_fs_info {
 	u64 data_reloc_bg;
 	struct mutex zoned_data_reloc_io_lock;
 
+	struct btrfs_block_group *active_meta_bg;
+	struct btrfs_block_group *active_system_bg;
+
 	u64 nr_global_roots;
 
 	spinlock_t zone_active_bgs_lock;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dbfa49c70c1a..f440853dff1c 100644
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
@@ -1748,6 +1751,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct writeback_control *wbc,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret)
 {
@@ -1779,6 +1783,74 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	if (cache->meta_write_pointer != eb->start)
 		return false;
 
+	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags)) {
+		bool is_system = cache->flags & BTRFS_BLOCK_GROUP_SYSTEM;
+
+		spin_lock(&cache->lock);
+		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			     &cache->runtime_flags)) {
+			spin_unlock(&cache->lock);
+			return true;
+		}
+
+		spin_unlock(&cache->lock);
+		if (fs_info->treelog_bg == cache->start) {
+			if (!btrfs_zone_activate(cache)) {
+				int ret_fin = btrfs_zone_finish_one_bg(fs_info);
+
+				if (ret_fin != 1 || !btrfs_zone_activate(cache))
+					return false;
+			}
+		} else if ((!is_system && fs_info->active_meta_bg != cache) ||
+			   (is_system && fs_info->active_system_bg != cache)) {
+			struct btrfs_block_group *tgt = is_system ?
+				fs_info->active_system_bg : fs_info->active_meta_bg;
+
+			/*
+			 * zoned_meta_io_lock protects
+			 * fs_info->active_{meta,system}_bg.
+			 */
+			lockdep_assert_held(&fs_info->zoned_meta_io_lock);
+
+			if (tgt) {
+				/*
+				 * If there is an unsent IO left in the
+				 * allocated area, we cannot wait for them
+				 * as it may cause a deadlock.
+				 */
+				if (tgt->meta_write_pointer < tgt->start + tgt->alloc_offset) {
+					if (wbc->sync_mode == WB_SYNC_NONE ||
+					    (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync))
+						return false;
+				}
+
+				/* Pivot active metadata/system block group. */
+				btrfs_zoned_meta_io_unlock(fs_info);
+				wait_eb_writebacks(tgt);
+				do_zone_finish(tgt, true);
+				btrfs_zoned_meta_io_lock(fs_info);
+				if (is_system && fs_info->active_system_bg == tgt) {
+					btrfs_put_block_group(tgt);
+					fs_info->active_system_bg = NULL;
+				} else if (!is_system && fs_info->active_meta_bg == tgt) {
+					btrfs_put_block_group(tgt);
+					fs_info->active_meta_bg = NULL;
+				}
+			}
+			if (!btrfs_zone_activate(cache))
+				return false;
+			if (is_system && fs_info->active_system_bg != cache) {
+				ASSERT(fs_info->active_system_bg == NULL);
+				fs_info->active_system_bg = cache;
+				btrfs_get_block_group(cache);
+			} else if (!is_system && fs_info->active_meta_bg != cache) {
+				ASSERT(fs_info->active_meta_bg == NULL);
+				fs_info->active_meta_bg = cache;
+				btrfs_get_block_group(cache);
+			}
+		}
+	}
+
 	return true;
 }
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 42a4df94dc29..6935e04effdd 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -59,6 +59,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct writeback_control *wbc,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
-- 
2.41.0

