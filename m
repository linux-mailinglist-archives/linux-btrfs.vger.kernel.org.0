Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C0A3F191F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhHSM1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376031; x=1660912031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HAT/VgPluIB3gFUuzNyb0ZUhdezpOQr+dsUpmUXU3hE=;
  b=M/SAYDR7zj+IT+N5Y0qm/Yw6ivDkWurmX6I9sLccQEXJQjGvIgE432uH
   MsIQ+oBeyFWka1AP2Ue7PRekLHE3yK306m9BbjeCXDeW4b+zKtfQPQyG8
   OLwnTsmRDykBajG47rTciU+nm4dmSEEgoxQAQAFLrwtvz2IybMtx3Abdc
   iIIOdTV+W7d4+yrF/jT9c4KDOl6hYitSK5clcx57mw1vX7gwpwOx8SXqV
   FQvybLfZ8v0fMDpLCCv/P8adFLDtGA/3PUv/1AZkhIYESd0a6iTkai5A/
   yq7H+rSonm3Eo5Bs7l3u3g6z5NZY7NOdqGski/dxq73GTJSiEqf8GiKuH
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773537"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:10 +0800
IronPort-SDR: PbJhzGdK+ry9kCtXPLckYGWLinBPpNOanEe4ZI7FSObi2EFg8uljcZEcOZPbOdwJAd1fs6JdW4
 g6yQ5CkhJ8G6fJNdCLI06OiMr60JCIwpgjSPibHT3pxGlUu0Z6SndWsGLgnuxbD3WXL4OHjxmf
 3H8WYOZJX2Lspd2L7peTdCu63O5pT43GUWYqBeBoswyM4kG0kDTKaTPwryInISoI1xJqpmhCSW
 S1xeMHmgrbsQquXNWyZvc3uP9Z8A0TxtJ/EHyPgj3a+2kdToqyOyzROkIcfVdZNDBGNAThhhMA
 QaZ83lf3BRFvCl/VoHkB2p9S
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:18 -0700
IronPort-SDR: 6hkz2LnmoR/l89TNvueBD6fZ+XP1+6WPe3Y0XJRPDCq75eLH3eKk+rsSpHrv+y21j+eowSt0HW
 zNt5gVjyorMZ3pfsCReOBNU6Wcj7PGYDRboFFGnGBT3Ixk+402XFQosexzGW/GFz8VpAsPDYLn
 q9eniNrB4jujAu8NhMZqlvxv6wA8iXc91ZSncURa9hRywts4aTHmNguv3Tpux6MTlYLFrHsJSH
 08RDny1mdVeaI9QjpIE1WW9xvLC+00aZOSu62iMxHwQKJbpD34Pv0vxiwEI1bGQU5YCWy2yhWW
 Le0=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 03/17] btrfs: zoned: calculate free space from zone capacity
Date:   Thu, 19 Aug 2021 21:19:10 +0900
Message-Id: <03bf2db22301fcc6706d489dab1dc3ed6ac54a8e.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
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
2.33.0

