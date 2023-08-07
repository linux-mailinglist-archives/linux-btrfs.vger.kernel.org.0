Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A8772A3F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjHGQNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjHGQM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C9E76
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424774; x=1722960774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MT8GbSa51NXABeciN+cPtvwhbjFI+mpRkrpvIzwAf3o=;
  b=r7dzaBbZMEngdpMWjMMYk/EyEqkicRqjDlzF6ewAznjYFYWL10vbUyZh
   g6dy9ecMPdzZNsWFNF8mep819ugu7bqNnasb5xUniVBAQkg5pfNMfVXbO
   oRdjV8jEixYagx8ZDRJWBuA8mUNC6Pp6s/oXEUYjmG6aAulFuApJ8RgqH
   KtinO6TpDMqxLHnRxYTJmYx71ueV1qpbhRu8DO02FW4sHKp8mt0vM5Y7z
   lbWXnNzHvOia3//OrNpSkTCyfjyaqehzXy4zlVdh16335uc4DBf+xCj7W
   p7/tRAYw4nPa++RwzyDRLWwWCqZy8XuaBQsiM5GoMGePBgEon4ShPTR+9
   g==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240711005"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:54 +0800
IronPort-SDR: qsMwD3KnNztvbaqHQRQVP5J8Ex8iGyn1he2UVp6pbhKMpCBuR2u+hCZAj1BS70Joon8VCtPihN
 389nDZUvlMgJi5uHG3CobfIWtyaN/9vybGnXFgt4WYaQFoiz2y2W2RmiZT1wIx695Z0GHH+A7Q
 cCa3OkNGLWBFLJhkPTdchVJ4FQftemqgQxkTSo2tjNe/gAqREDkfsFVbsoE35Ggg1CXiIKHI8O
 0VWKKZQ0HHPYId/GZ9G0sYNMOzjAuoh+02tCTd32e09kvfn/hTJOAmT29mrQt9OYvnLfzu5ppt
 YKk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:23 -0700
IronPort-SDR: FrZlHUAX8a1Ixo13RedlwmzOr7veU9QRJEwE5D4jJK0Ji+FIl4n5SBTvidCNj31cMpr/cclzWo
 3VtDQvd3uLyUnG81sUbKmwJqZ6nxKM+wr2pWibLWDB4lUUjYC5p3qVh/9D2OPVSnHQpdag/e5M
 N5FkbolLjY7On3C+pTLYRGib5USDSOy76MbnF77PbPT0qkNSgwivHI6m5CblK0qRt922ahOAqo
 zFQ4nq7PymyOvV1jCysyCu2MdV656Cdr5OtFFSCRP/iHo8F36BEwBZtRdKWUKozsEstjPupNuf
 2Zg=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 08/10] btrfs: zoned: no longer count fresh BG region as zone unusable
Date:   Tue,  8 Aug 2023 01:12:38 +0900
Message-ID: <ca8d3f4a50133240b380bc58a205dfe24dcff06a.1691424260.git.naohiro.aota@wdc.com>
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
index 4fa1590f71ac..957fc76079bd 100644
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
@@ -1964,7 +1954,6 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	struct btrfs_device *device;
 	u64 physical;
@@ -1977,7 +1966,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	map = block_group->physical_map;
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags)) {
 		ret = true;
@@ -2027,14 +2015,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
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
@@ -2047,7 +2028,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 out_unlock:
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.41.0

