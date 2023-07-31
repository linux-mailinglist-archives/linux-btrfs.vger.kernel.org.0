Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E3769F49
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGaRUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjGaRUa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EE18D
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823964; x=1722359964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhpujwgWrph6FHOVL04IiONRcxruk0whcIU1u0hndOM=;
  b=O/f4JaL4aYDHpCjAjLjV7gkPxf9e8uWmf5da1Kx7RZ3pGGMJKCrA2BpM
   Isx8PsYX2ccDiVNRQVaEwC7qBCaor36dQxCnqjz5W7OiUnenrJtq2jfnK
   u1YL2VS+ZDzGKlqTOW+Hg5DZ7btNWI6kYRnl0xcuRWNC/U1DgI3P0z3CN
   ae9Nj6shUZN5/2Tq+KsB3Ttwh21lmYNrXw45rQ/JMYtM3RTXZUItKNn05
   O/sldzGTH1VASH+baYwzBZRfPMURdD3kvI+l+yUPHpjA3GjWPQkxZbM0/
   Bm97C3O8U1H2SKjuDVeWcwo8l13ytrosjeQgLSu+KfAr7Y2XXx5Tib7C7
   A==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269572"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:40 +0800
IronPort-SDR: QYFbAJWidgwAxXU74TO4wrX3stsycJ6hhW66lzhycoZSEBOUqTpPm44FXa2knALz62uw89mKU0
 M5mDqk2ipmPjGzTYsTQYpmYqOu7HEAEiREaEmkH2iGHcrbIZF3u/7Z2kBg6x6lKh5Ei1D/2eeu
 1DN59Wc0lxxrgO8KFJqqUE0sFf+PNp1zhqNi0UBmB4fFyWMAE+h99+e6AeJ/zNv45XQUvQR+g9
 jdRmpC5c4POnw+1pyxPlYn6DA4KPNz9W91AiddFK7+WJPDDQWByjqYb6WeW+PynI4FkIvzz3eD
 uI4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:17 -0700
IronPort-SDR: azzYYjOxJolbwEgXUu0CLFEgpgpE9BFRMB4TBUe5xLoaOi2bb+Th8aBmkVJ2JRaz8CsyqWpoI+
 V2mZw3iFnOp3PLfbcV04EX9M9RJ3DlR00uVt0GwlXYKlXB0/oXHRU4oonek9cg3QxtGvL6Zvup
 37XTASQGVnYCHykCK4A6eUHFjkkFWydfFPMAsYoQfjOKJakcsrczOrzMmURT9C1k0K5GP8J+Uy
 TIZZFhhUxTAHts8/zqp40aZ6A6oGxpts5TiUhs/L3wf9xEJBbsRE0enjGQCYuJJzJ8B8HweyuF
 NnU=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:40 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 08/10] btrfs: zoned: no longer count fresh BG region as zone unusable
Date:   Tue,  1 Aug 2023 02:17:17 +0900
Message-ID: <5ae5510f8616620c037eff05e3a15df6f401c486.1690823282.git.naohiro.aota@wdc.com>
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
index cd5bfda2c259..27fad70451aa 100644
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
index 91eca8b48715..8c2b88be1480 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1608,19 +1608,9 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
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
@@ -1986,7 +1976,6 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	struct btrfs_device *device;
 	const unsigned int reserved = (block_group->flags & BTRFS_BLOCK_GROUP_DATA) ?
@@ -2000,7 +1989,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	map = block_group->physical_map;
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags)) {
 		ret = true;
@@ -2038,14 +2026,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
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
@@ -2058,7 +2039,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 out_unlock:
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.41.0

