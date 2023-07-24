Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13ED75EA75
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGXETJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjGXETD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00093131
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172341; x=1721708341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uOwL2ZkTcNZo9+yeNnbkQ8RWCvjl2jY+93WfzI6hTV8=;
  b=JYYhq9HOaPQ/25aznz9W/Y85NyeDwrtkHkVhF98Zi0corYSfw7VKCpzR
   Nadd90++Y4hQB8Hu1aKS65/cWKNOgXawtqnruzx0JzOUWy+RF/wB7btsR
   yg6m8EIn/HcjJX0UY3zRcHIeakW31H7kry2e3m77qLW/vdsGRxBd1lONv
   v3qNY28rSHy7khMgFT75B0NHsIQRUJb77j1/g2ZZcOROiZD4TaBD8AOZk
   0PNAHmx9/B10TVPSNZD94YlBNAVVr5OwA6pynVa0mqDKljuS+xomaaLdZ
   aI2O/Wtsrjq/Br9VARZYafeaHaZo4pwNePMXSpM8xIuIawJrjZaLpIVIb
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524376"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:19:01 +0800
IronPort-SDR: fCuIlM/PoersAeXoqIE2NSfvJeSdDCPm+RRJw+jDq8twOnrHkr/OMN4J0V0jRkGcNgTxMhj0gc
 O6pdmJJ1OC/hB1P6kIw+9uouYc1jqCZBvKnIdJVSjGqK8M7WKj2GccB/cjx4Jc19C4ZOgaHyUO
 oOejJ4qL+uCvgLwNyHA8ihpoBd6oc1aPtfo/9AKDs0GduhnCtgR8QW/7ombvBstKqzLw0MU6LS
 s09d37ewPsWWLWiHfjvawEdjZR0uSErchVY3Y9SAkSBVppZ6xFGTZw0oCWgzZcW1wpTnFAsEg1
 4A0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:07 -0700
IronPort-SDR: FZ3BM6KpRFYHlKZ14HIpZKO9DvfQWvx87g5SOgXj+u9Osfm6l/U6xY2k26V8juntIHveY0yldq
 ZHS4ouTQgrOwsUxuJbgK2IOZ4Ok/qDUREF2tX8lAv3e09Lkqsp6SR548y1zsAna9Ph5gesrf4R
 I3PxL+0ycvmu35yNv1K+VpFczP30dgQjCcflEICeRyR6RQmLOBr8A8npkXAK6gRton3sO1FVu+
 tFkRRK6zm8ix7ZGR/sxNJ3dmm2sepo7KN8+j/kTwUXsSZrrEZ10cAP6kPc8bHvU0rOlSdzn3Jt
 QIM=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:19:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 6/8] btrfs: zoned: no longer count fresh BG region as zone unusable
Date:   Mon, 24 Jul 2023 13:18:35 +0900
Message-ID: <6dbd4c356609a0ff5bdce7de408a1659a784886d.1690171333.git.naohiro.aota@wdc.com>
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

Now that we switched to write time activation, we no longer need to (and
must not) count the fresh region as zone unusable. This commit is similar
to revert commit fc22cf8eba79 ("btrfs: zoned: count fresh BG region as zone
unusable").

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c |  8 +-------
 fs/btrfs/zoned.c            | 26 +++-----------------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index bfc01352351c..13f47d9ec13d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2704,13 +2704,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
 	spin_lock(&ctl->tree_lock);
-	/* Count initial region as zone_unusable until it gets activated. */
 	if (!used)
 		to_free = size;
-	else if (initial &&
-		 test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
-		 (block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)))
-		to_free = 0;
 	else if (initial)
 		to_free = block_group->zone_capacity;
 	else if (offset >= block_group->alloc_offset)
@@ -2738,8 +2733,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	reclaimable_unusable = block_group->zone_unusable -
 			       (block_group->length - block_group->zone_capacity);
 	/* All the region is now unusable. Mark it as unused and reclaim */
-	if (block_group->zone_unusable == block_group->length &&
-	    block_group->alloc_offset) {
+	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
 	} else if (bg_reclaim_threshold &&
 		   reclaimable_unusable >=
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f440853dff1c..ce816f5885fb 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1586,19 +1586,9 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 		return;
 
 	WARN_ON(cache->bytes_super != 0);
-
-	/* Check for block groups never get activated */
-	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
-	    cache->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM) &&
-	    !test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags) &&
-	    cache->alloc_offset == 0) {
-		unusable = cache->length;
-		free = 0;
-	} else {
-		unusable = (cache->alloc_offset - cache->used) +
-			   (cache->length - cache->zone_capacity);
-		free = cache->zone_capacity - cache->alloc_offset;
-	}
+	unusable = (cache->alloc_offset - cache->used) +
+		   (cache->length - cache->zone_capacity);
+	free = cache->zone_capacity - cache->alloc_offset;
 
 	/* We only need ->free_space in ALLOC_SEQ block groups */
 	cache->cached = BTRFS_CACHE_FINISHED;
@@ -1978,7 +1968,6 @@ static int reserved_zones(struct btrfs_fs_info *fs_info)
 bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	struct btrfs_device *device;
 	const int reserved = (block_group->flags & BTRFS_BLOCK_GROUP_DATA) ?
@@ -1992,7 +1981,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	map = block_group->physical_map;
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags)) {
 		ret = true;
@@ -2030,14 +2018,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	/* Successfully activated all the zones */
 	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
-	WARN_ON(block_group->alloc_offset != 0);
-	if (block_group->zone_unusable == block_group->length) {
-		block_group->zone_unusable = block_group->length - block_group->zone_capacity;
-		space_info->bytes_zone_unusable -= block_group->zone_capacity;
-	}
 	spin_unlock(&block_group->lock);
-	btrfs_try_granting_tickets(fs_info, space_info);
-	spin_unlock(&space_info->lock);
 
 	/* For the active block group list */
 	btrfs_get_block_group(block_group);
@@ -2050,7 +2031,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 out_unlock:
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.41.0

