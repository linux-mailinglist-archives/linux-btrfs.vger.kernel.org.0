Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744603E9384
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhHKOVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35964 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhHKOVM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691648; x=1660227648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WHHHyzmaQNqHHiR0/yfc/HMQjiwgTVRiaoBwgQHTpUI=;
  b=Aa8ClHXzYdzws3e+Tdhdd8HV5UD7hVkbGHCY8S3YoTLY/6wC5Pu5AUTe
   5hKRIe01aRdkpfYxYPbpyEuqowTKYwM6DXq6ePTYuP9M6DVIRhRlma6c+
   EGFot36uv1y5T2wWHSLuw4DiMg914QLBx6S2O+Agu302+YZcp7US9Bf+z
   tdxyiDM8EOd0ydL44how1ty/2IXuGPLRwCgCBvX+F+MFGZXcE1CqfY+4H
   guL9RbEoYCFuWqUP5oFipRadoq2Ys/9pEWoHoW4VieoHMO2M+thnBcp4i
   vZ8Y6QrT4oXh9vIgMHdMKmMKDnKwbAbfuNzYxI3xLh1u6TJACBkxh8qOw
   g==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937872"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:48 +0800
IronPort-SDR: qe66fF4KGXvKbpg/QeUTjTB7hKEkFWKmSjOIorXVqO+ddLFLooFFVxEq+ucPrle0ATKLUvuGYE
 gHCknmblVcdkTcV7J9ZXBcBN0L0LrQMyj00iQecPQ/bPTup3jxY50mMOaqgr8xfyI4gtNTkNPu
 BjtfyFcLN6dCscmluNuE9V/QEgtRhckjH+JgPGiW8y2wYhpzex74bdLBLGMVgrzO8PZqZQx91R
 ghMLRa1cRjkwveIWqVO5qDmzWNFi1wRMYUMp+syk17QKzHIT3dtYNYH43dL97pUep1+O4zPUy9
 vXguQgZle5xuYVActzmxUbD0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:19 -0700
IronPort-SDR: 2aRpCCmN/J7XvM7xWuL9fu/LZTzcmMqWJkk1ZA1+STQlu6Wb0B9z9mMz2M95B1sGwdY/72k3cU
 7QHeglpi9LTzTC7RVwgCfd18ocAcuYkFi9OMpC2ZCihO8BGcc+MxXi+lvXEUEXk6/sn+F+57Ku
 Tu9qf/SZwQ8CI2cgNxhgRTocLoVwYZFYT8H7r2B7pLtZ71PU/yHEyCIKauBQ1kKRqR2D+kwlQA
 ZHDJGAvOnstlTIKQ5XNPCcDBaf8Cxpf3cD8jjstButXrOY5qlH/MlzHyylhcDRDrhN139pBur5
 YUc=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:48 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 03/17] btrfs: zoned: calculate free space from zone capacity
Date:   Wed, 11 Aug 2021 23:16:27 +0900
Message-Id: <55e57e66f8c6b4821e43e816ca8bbdc9bc3f351d.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we introduced capacity in a block group, we need to calculate free
space using the capacity instead of the length. Thus, bytes we account
capacity - alloc_pointer as free, and account bytes [capacity, length] as
zone unusable.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      | 6 ++++--
 fs/btrfs/extent-tree.c      | 3 ++-
 fs/btrfs/free-space-cache.c | 8 +++++++-
 fs/btrfs/zoned.c            | 5 +++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index db368518d42c..de22e3c9599e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2486,7 +2486,8 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, 0, &cache->space_info);
+				cache->bytes_super, cache->zone_unusable,
+				&cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2601,7 +2602,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	if (!--cache->ro) {
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes back */
-			cache->zone_unusable = cache->alloc_offset - cache->used;
+			cache->zone_unusable = (cache->alloc_offset - cache->used) +
+				(cache->length - cache->zone_capacity);
 			sinfo->bytes_zone_unusable += cache->zone_unusable;
 			sinfo->bytes_readonly -= cache->zone_unusable;
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fc3da7585fb7..8dafb61c4946 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3796,7 +3796,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
-	avail = block_group->length - block_group->alloc_offset;
+	WARN_ON_ONCE(block_group->alloc_offset > block_group->zone_capacity);
+	avail = block_group->zone_capacity - block_group->alloc_offset;
 	if (avail < num_bytes) {
 		if (ffe_ctl->max_extent_size < avail) {
 			/*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index da0eee7c9e5f..bb2536c745cd 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2539,10 +2539,15 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
+	bool initial = (size == block_group->length);
+
+	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 
 	spin_lock(&ctl->tree_lock);
 	if (!used)
 		to_free = size;
+	else if (initial)
+		to_free = block_group->zone_capacity;
 	else if (offset >= block_group->alloc_offset)
 		to_free = size;
 	else if (offset + size <= block_group->alloc_offset)
@@ -2755,7 +2760,8 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 	 */
 	if (btrfs_is_zoned(fs_info)) {
 		btrfs_info(fs_info, "free space %llu",
-			   block_group->length - block_group->alloc_offset);
+			   block_group->zone_capacity -
+			   block_group->alloc_offset);
 		return;
 	}
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 579fb03ba937..0eb8ea4d3542 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1265,8 +1265,9 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 		return;
 
 	WARN_ON(cache->bytes_super != 0);
-	unusable = cache->alloc_offset - cache->used;
-	free = cache->length - cache->alloc_offset;
+	unusable = (cache->alloc_offset - cache->used) +
+		(cache->length - cache->zone_capacity);
+	free = cache->zone_capacity - cache->alloc_offset;
 
 	/* We only need ->free_space in ALLOC_SEQ block groups */
 	cache->last_byte_to_unpin = (u64)-1;
-- 
2.32.0

