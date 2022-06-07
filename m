Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39053F6E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiFGHIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 03:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiFGHIg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 03:08:36 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224951EC68
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654585715; x=1686121715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nEpGP2E6nd8Y82e/DKO+Xx8wNpqEukJSqWnvQytJBCk=;
  b=Y1+7CN/IVWvYnZ/L+B8x+h57ae6oj3+7eV+o7XuXyBZu7ooHUN3oJeeR
   nYTOe5word/zrKj/bUuWkg54I6WLerI58HYBQdKUdizTDac2QedI7pu7X
   oeadteXH24BI83qHq6zlWnsb7javM50zf3WUzJ6uMEPAYwb2y2oBr1Hmg
   xgkAQ6PZA1D9zqhK4GN6NgOCagJSAa69oSTUW4Mop41Tz2mq+WmO6Maar
   PTlzRpkwzIrce8lw/pI/mc8Vt0moAHjYCNBXkKGV9aMC7eCWTUsVq8B59
   KsamE9S5rJyyqrqu6b2jUvdNO8v1ZfPohRPXLvptydiKMogVe16PIykHV
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="203238282"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 15:08:34 +0800
IronPort-SDR: 17DaF9or5w5QHtOkIAT3EiWrRZDf2Sdu12FyZiGSaNxA54lK6M5YM02JqSENok3LfJjFsZuhnw
 BAnAYRjGFHcaPOPTXfET2Q6PB6u4X/tDyO+o/cM/LN7/rll86QF2G3XnAE5FuMP/tyG0al88ch
 bXTF6OTyiEeDzIu+ILlNHPXbW0rhq5niYy0CYHfvuXxUAoISR7/0vHoZyxcCcGjaxSw47fF3F1
 GtNu2HFcUUUlLu6Iz2ZtEV6vLwmCzNOcBj4hZaDOgXLHTo+XfnJPHTYwMtZ/5DPJ7kdLHIm/s1
 0l7rT2/n8Eig4EWuZrwOWUNa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 23:31:50 -0700
IronPort-SDR: UEzDH+pRTsJC6jIDFIaJMIYXPSF+COOgYrHGLdiW0lwuY+iSQw639NF4l+H/+aRjLxCN6AQi/A
 dv4Gy/GdNVXcUhB/Zvn0bzxdWGNKgo/kFgM44dKr71dXZCA5GEtMC47GJ5dUb4k9+0jVB9M2Kd
 Ixq0yCKsg4yQNHT+Te4O126cQeSFHHEmMe7ORSbJFziTFBnRPLvCIsVAOdtszeCsnJpaT/mpta
 WN0DmhObZku1s0M0eDs6jIprAe+5de16+x9+TbOn9PjIeitDS/3Hq8xBbZsWuBwFmBd3BXXw7D
 hsc=
WDCIronportException: Internal
Received: from hr204m2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2022 00:08:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] btrfs: zoned: prevent allocation from previous data relocation BG
Date:   Tue,  7 Jun 2022 16:08:29 +0900
Message-Id: <c7b9d256334dbdd84ac506505377a5bfad748f7c.1654585425.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654585425.git.naohiro.aota@wdc.com>
References: <cover.1654585425.git.naohiro.aota@wdc.com>
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

After commit 5f0addf7b890 ("btrfs: zoned: use dedicated lock for data
relocation"), we observe IO errors on e.g, btrfs/232 like below.

   [99909.031820][T4038707] WARNING: CPU: 3 PID: 4038707 at fs/btrfs/extent-tree.c:2381 btrfs_cross_ref_exist+0xfc/0x120 [btrfs]
   <snip>
   [99909.268769][T4038707] Call Trace:
   [99909.272105][T4038707]  <TASK>
   [99909.275093][T4038707]  run_delalloc_nocow+0x7f1/0x11a0 [btrfs]
   [99909.280996][T4038707]  ? test_range_bit+0x174/0x320 [btrfs]
   [99909.286622][T4038707]  ? fallback_to_cow+0x980/0x980 [btrfs]
   [99909.292333][T4038707]  ? find_lock_delalloc_range+0x33e/0x3e0 [btrfs]
   [99909.298825][T4038707]  btrfs_run_delalloc_range+0x445/0x1320 [btrfs]
   [99909.305222][T4038707]  ? test_range_bit+0x320/0x320 [btrfs]
   [99909.310844][T4038707]  ? lock_downgrade+0x6a0/0x6a0
   [99909.315732][T4038707]  ? orc_find.part.0+0x1ed/0x300
   [99909.320705][T4038707]  ? __module_address.part.0+0x25/0x300
   [99909.326280][T4038707]  writepage_delalloc+0x159/0x310 [btrfs]
   <snip>
   [99909.883814][    C3] sd 10:0:1:0: [sde] tag#2620 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
   [99909.893855][    C3] sd 10:0:1:0: [sde] tag#2620 Sense Key : Illegal Request [current]
   [99909.901819][    C3] sd 10:0:1:0: [sde] tag#2620 Add. Sense: Unaligned write command
   [99909.909525][    C3] sd 10:0:1:0: [sde] tag#2620 CDB: Write(16) 8a 00 00 00 00 00 02 f3 63 87 00 00 00 2c 00 00
   [99909.919544][    C3] critical target error, dev sde, sector 396041272 op 0x1:(WRITE) flags 0x800 phys_seg 3 prio class 0
   [99909.930329][    C3] BTRFS error (device dm-1): bdev /dev/mapper/dml_102_2 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0

The IO errors occur when we allocate a regular extent in a previous data
relocation block group.

On zoned btrfs, we use a dedicated block group to relocate a data
extent. Thus, we allocate relocating data extents (pre-alloc) only from the
dedicated block group and vice versa. Once the free space in the dedicated
block group gets tight, a relocating extent may not fit into the block
group. In that case, we need to switch the dedicated block group to the
next one. Then, the previous one is now freed up for allocating a regular
extent. The BG is already not enough to allocate the relocating extent, but
there is still room to allocate a smaller extent. Now the problem
happens. By allocating a regular extent while nocow IOs for the relocation
is still on-going, we will issue WRITE IOs (for relocation) and ZONE APPEND
IOs (for the regular writes) at the same time. That mixed IOs confuses the
write pointer and arises the unaligned write errors.

This commit introduces a new bit 'zoned_data_reloc_ongoing' to the
btrfs_block_group. We set this bit before releasing the dedicated block
group, and no extent are allocated from a block group having this bit
set. This bit is similar to setting block_group->ro, but is different from
it by allowing nocow writes to start.

Once all the nocow IOs for relocation is done (hooked from
btrfs_finish_ordered_io), we reset the bit to release the block group for
further allocation.

Fixes: c2707a255623 ("btrfs: zoned: add a dedicated data relocation block group")
CC: stable@vger.kernel.org # 5.16+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 fs/btrfs/inode.c       |  2 ++
 fs/btrfs/zoned.c       | 27 +++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  5 +++++
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3ac668ace50a..35e0e860cc0b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -104,6 +104,7 @@ struct btrfs_block_group {
 	unsigned int relocating_repair:1;
 	unsigned int chunk_item_inserted:1;
 	unsigned int zone_is_active:1;
+	unsigned int zoned_data_reloc_ongoing:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fb367689d9d2..abf7dc438409 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3832,7 +3832,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	       block_group->start == fs_info->data_reloc_bg ||
 	       fs_info->data_reloc_bg == 0);
 
-	if (block_group->ro) {
+	if (block_group->ro || block_group->zoned_data_reloc_ongoing) {
 		ret = 1;
 		goto out;
 	}
@@ -3894,8 +3894,24 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 out:
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
-	if (ret && ffe_ctl->for_data_reloc)
+	if (ret && ffe_ctl->for_data_reloc &&
+	    fs_info->data_reloc_bg == block_group->start) {
+		/*
+		 * Do not allow further allocations from this block group.
+		 * Compared to increasing the ->ro, setting the
+		 * ->zoned_data_reloc_ongoing flag still allows nocow
+		 *  writers to come in. See btrfs_inc_nocow_writers().
+		 *
+		 * We need to disable an allocation to avoid an allocation of
+		 * regular (non relocation data) extent. With mixed of
+		 * relocation extents and regular extents, we can dispatch WRITE
+		 * commands (for relocation extents) and ZONE APPEND commands
+		 * (for regular extents) at the same time to the same zone,
+		 * which easily break the write pointer.
+		 */
+		block_group->zoned_data_reloc_ongoing = 1;
 		fs_info->data_reloc_bg = 0;
+	}
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f85503ccf106..0ab23bd1310a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3216,6 +3216,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
 						logical_len);
+		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->disk_bytenr,
+						  ordered_extent->disk_num_bytes);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
 		ret = insert_ordered_extent_file_extent(trans, ordered_extent);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c09b1b0208c4..4930ab566e2c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2140,3 +2140,30 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 	factor = div64_u64(used * 100, total);
 	return factor >= fs_info->bg_reclaim_threshold;
 }
+
+void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
+				       u64 length)
+{
+	struct btrfs_block_group *block_group;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	block_group = btrfs_lookup_block_group(fs_info, logical);
+	/* It should be called on a previous data relocation block group. */
+	ASSERT(block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA));
+
+	spin_lock(&block_group->lock);
+	if (!block_group->zoned_data_reloc_ongoing)
+		goto out;
+
+	/* All relocation extents are written. */
+	if (block_group->start + block_group->alloc_offset == logical + length) {
+		/* Now, release this block group for further allocations. */
+		block_group->zoned_data_reloc_ongoing = 0;
+	}
+
+out:
+	spin_unlock(&block_group->lock);
+	btrfs_put_block_group(block_group);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index bb1a189e11f9..6b2eec99162b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -77,6 +77,8 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
+void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
+				       u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -243,6 +245,9 @@ static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 {
 	return false;
 }
+
+static inline void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info,
+						     u64 logical, u64 length) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

