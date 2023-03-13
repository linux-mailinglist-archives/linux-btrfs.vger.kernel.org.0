Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558226B6FD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 08:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCMHG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCMHGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 03:06:25 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAE4DE39
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678691184; x=1710227184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycsL+qgrQUZK5XjwIIrgrNSTBLCkDvP59DvYHVObNKQ=;
  b=SWD3FvlHsx+Zll0goEZZ1DNTgtuxpWxLy8G3blRDoddvqbiBlZ8yqdGu
   QyAdCuI2wK8Rc7e06+KzIMkalAQBkNKwC3awrYT62RDbVdJzV/BVaDFhc
   B3MwQ/my33i4L6jhy7byjtQBCluStRUfH4jDayevVQRARPNChmCWuIPy9
   kD0JYaFWA/aPdhmS5vXfvUgKZGlagJEoX8bQ4LdJ3SQX9dHY7GX4jFeLw
   6O4emPy0RRrActgQZneWdg/9RJFsZdhixCAvs6VgzKtJMwcIAo5nWHe/f
   KaxPj2fnLsQCUTkkCDfKkh4vsNVXU+6Yu8DfjDAnXua1XeRW24odyx7UG
   w==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673884800"; 
   d="scan'208";a="230433378"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 15:06:23 +0800
IronPort-SDR: tyG+E9w5gHWVpcGm8q1Fhh5vhic1peFCKZyzV+NfULl0JSkZCLxBlU29sx/ZBYNO55ufQloEzp
 AGQAvTG4Cm4jD4mclqZ8vKOUA/5xSRNpIO6ZnVjsQCez/gV1T7b8U5wHANT/dqIKi9+xr/5/WP
 T37pOr5FArPV1sTgpjxfCYf2NUFecn7M/1VT7nWU/zDO6cEcf/Ime0dgsH7v4elOIESDkM+Ft6
 EKykTzk6ItcVg80/k+8F9enJKylvPhdck+97a8Yapj9GNQYiduNmAETLJnf0DaXcfc/0tTOHvw
 tpY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 23:22:51 -0700
IronPort-SDR: HBruhBa2pdEXKNGCYHe0S/roJfD7khRuRjPn9UbaFp0MU4hgEBlrhQEtbVDJOvggXYQ4rdwutM
 WJGO91FGD4hA+rhmUdoujtCVQmWzwNEjAjNXs/wlcu5lcPEQPjhN6JQBG3FUVE5tTeEfvrOIGN
 Qi9zn0Oxy2wCEoMZeHcaFHyCYwF93YvvLC99ya21IHlC4euGuz/gJyMQShN7ub4oiDGHSGW/H3
 sGz8FhiH61SQeoQCUD+5gVhyB1DoEgpNv9XBwIW0b0kCcskutTPHC7qnjrmYcRx7/cLlRY1F0+
 xyo=
WDCIronportException: Internal
Received: from 5cg2075dxm.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.82])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Mar 2023 00:06:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: count fresh BG region as zone unusable
Date:   Mon, 13 Mar 2023 16:06:13 +0900
Message-Id: <bdcc434abd271dfd2b75c1b018ed6dbe425f562e.1678689012.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678689012.git.naohiro.aota@wdc.com>
References: <cover.1678689012.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The naming of space_info->active_total_bytes is misleading. It counts not
only active block groups but also full ones which are previously active but
now inactive. That confusion results in a bug not counting the full BGs
into active_total_bytes on mount time.

For a background, there are three kinds of block groups in terms of
activation.

1. Block groups never activated
2. Block groups currently active
3. Block groups previously active and currently inactive (due to fully
   written or zone finish)

What we really wanted to exclude from "total_bytes" is the total size of
BGs #1. They seem empty and allocatable but since they are not activated,
we cannot rely on them to do the space reservation.

And, since BGs #1 never get activated, they should have no "used",
"reserved" and "pinned" bytes.

OTOH, BGs #3 can be counted in the "total", since they are already full we
cannot allocate from them anyway. For them, "total_bytes == used + reserved
+ pinned + zone_unusable" should hold.

Tracking #2 and #3 as "active_total_bytes" (current implementation) is
confusing. And, tracking #1 and subtract that properly from "total_bytes"
every time you need space reservation is cumbersome.

Instead, we can count the whole region of a newly allocated block group as
zone_unusable. Then, once that block group is activated, release [0 ..
zone_capcity] from the zone_unusable counters. With this, we can eliminate
the confusing ->active_total_bytes and the code will be common among
regular and the zoned mode. Also, no additional counter is needed with this
approach.

Fixes: 6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c |  8 +++++++-
 fs/btrfs/zoned.c            | 23 +++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d250d052487..4962d7bf1e3a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2693,8 +2693,13 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
 	spin_lock(&ctl->tree_lock);
+	/* Count initial region as zone_unusable until it gets activated. */
 	if (!used)
 		to_free = size;
+	else if (initial &&
+		 test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
+		 block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM))
+		to_free = 0;
 	else if (initial)
 		to_free = block_group->zone_capacity;
 	else if (offset >= block_group->alloc_offset)
@@ -2722,7 +2727,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	reclaimable_unusable = block_group->zone_unusable -
 			       (block_group->length - block_group->zone_capacity);
 	/* All the region is now unusable. Mark it as unused and reclaim */
-	if (block_group->zone_unusable == block_group->length) {
+	if (block_group->zone_unusable == block_group->length &&
+	    block_group->alloc_offset) {
 		btrfs_mark_bg_unused(block_group);
 	} else if (bg_reclaim_threshold &&
 		   reclaimable_unusable >=
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 808cfa3091c5..c733383bbaeb 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1580,9 +1580,19 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 		return;
 
 	WARN_ON(cache->bytes_super != 0);
-	unusable = (cache->alloc_offset - cache->used) +
-		   (cache->length - cache->zone_capacity);
-	free = cache->zone_capacity - cache->alloc_offset;
+
+	/* Check for block groups never get activated */
+	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
+	    cache->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM) &&
+	    !test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags) &&
+	    cache->alloc_offset == 0) {
+		unusable = cache->length;
+		free = 0;
+	} else {
+		unusable = (cache->alloc_offset - cache->used) +
+			   (cache->length - cache->zone_capacity);
+		free = cache->zone_capacity - cache->alloc_offset;
+	}
 
 	/* We only need ->free_space in ALLOC_SEQ block groups */
 	cache->cached = BTRFS_CACHE_FINISHED;
@@ -1901,7 +1911,11 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	/* Successfully activated all the zones */
 	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
-	space_info->active_total_bytes += block_group->length;
+	WARN_ON(block_group->alloc_offset != 0);
+	if (block_group->zone_unusable == block_group->length) {
+		block_group->zone_unusable = block_group->length - block_group->zone_capacity;
+		space_info->bytes_zone_unusable -= block_group->zone_capacity;
+	}
 	spin_unlock(&block_group->lock);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
@@ -2256,6 +2270,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved ||
+		    block_group->alloc_offset == 0 ||
 		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)) {
 			spin_unlock(&block_group->lock);
 			continue;
-- 
2.39.2

