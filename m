Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B15AD317
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiIEMnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiIEMmm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 08:42:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEED4A81B
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662381507; x=1693917507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Px2WfBz7W3PoctvhC2dGmh68pBKWT26iYFnxTUK3IFk=;
  b=cEPDsTHnLJuvLXONjFRfwK67G4OrPPjQMGeInmjl069zx/p7xCIi21t+
   wvRLSQ/UeasuSGoxSanwd04WxZl/hwgQ6nj8ZpmIUQNEivGZeeoLAMK1o
   iDfoXzq+WTvZ/bIU4seYFLUqRk7fZu3Y5lJFMTvIyADh+T85kQPvZruTJ
   G1KubpnvkNm7oV8vu1aEJdxkaE9OJjqwf2Oqde6JAkRILW5yaclS3PyjA
   LeqZZqYWNXttkTVw3R4STxILpqCAeO12cUuhZ8hrCIz5vzj+ldV0JNEKf
   OUSpHXf5cIF3ty8efeRnNKPLSUwm//ofI5hYjo8M2on8PzKY92k5qKI0U
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="210529659"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 20:38:27 +0800
IronPort-SDR: yaZIZ81fKcvC9MgDKUsSeQWkAOJfbAE0TLWk1hvKW8GQzIM07DLqnc5bv8SxsaPlG5z13+dRsr
 uL4/pndNkCO9UbwvScBO/r8VCZcp32NrVPNiCGKVjAwykVHLDhcmhqsdiQTJVN+a0TsSYzKWVu
 2ZBbggCyR3sRRCXBG1f6nfoVt7YyXy2HGLNdw4gM01TtcwB8noprTzEpO9uJDueKOp5aLOKv1R
 NFBnT/ERlMZtoSmZ70F26GuxIG8JWU09ApIdH6MlpFJGzoZ60xpQ8GYUztZ+Vskuu4ITnSuq4e
 sP0kJ9A2GEWxOw52AUD1syAE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2022 04:58:52 -0700
IronPort-SDR: kYAi/PhwipUw/DFjIyFVJG50UkCTgNMrzOu1ooI3oZ7KJVygtmuTydBpVJZ4rTJuuzNOeI530J
 MwrEwkeN6fdmC+gjIq2+/xizbxOfGwQIRZFAL6pDNKMX7sX1YGnH/HNbYHvHP4dHn8f2rzlGgB
 f1OT7vANYR+WkvHid1Ani12EDm3zCCvaU9yqiEgk/c0D05dtZHhaGfpvlKi2p3ygBT9Xkekssv
 ojchSFO19mnk1cqVRLtfFkvvcH96VwN2I5v5fZtK7Wo38MzzmlrQ2SS8BYjTEaar8GEURG8nC5
 cJo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Sep 2022 05:38:29 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: fix mounting with conventional zones
Date:   Mon,  5 Sep 2022 05:38:24 -0700
Message-Id: <4c82ad00b9241a4c31ac153a3ca9c2c78fbcd551.1662381459.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.2
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

Since commit 6a921de58992 ("btrfs: zoned: introduce
space_info->active_total_bytes"), we're only counting the bytes of a
block-group on an active zone as usable for metadata writes. But on a SMR
drive, we don't have active zones and short circuit some of the logic.

This leads to an error on mount, because we cannot reserve space for
metadata writes.

Fix this by also setting the BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE bit in the
block-group's runtime flag if the zone is a conventional zone.

Fixes: 6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
* de-duplicate list handling code (Naohiro)
---
 fs/btrfs/zoned.c | 83 ++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e12c0ca509fb..cd1d40fcc81f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1187,7 +1187,7 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
  * offset.
  */
 static int calculate_alloc_pointer(struct btrfs_block_group *cache,
-				   u64 *offset_ret)
+				   u64 *offset_ret, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_root *root;
@@ -1197,6 +1197,21 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	int ret;
 	u64 length;
 
+	/*
+	 * Avoid  tree lookups for a new BG. It has no use for a new BG. It
+	 * must always be 0.
+	 *
+	 * Also, we have a lock chain of extent buffer lock -> chunk mutex.
+	 * For new a BG, this function is called from btrfs_make_block_group()
+	 * which is already taking the chunk mutex. Thus, we cannot call
+	 * calculate_alloc_pointer() which takes extent buffer locks to avoid
+	 * deadlock.
+	 */
+	if (new) {
+		*offset_ret = 0;
+		return 0;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -1332,6 +1347,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		else
 			num_conventional++;
 
+		/*
+		 * Consider a zone as active if we can allow any number of
+		 * active zones.
+		 */
+		if (!device->zone_info->max_active_zones)
+			__set_bit(i, active);
+
 		if (!is_sequential) {
 			alloc_offsets[i] = WP_CONVENTIONAL;
 			continue;
@@ -1398,45 +1420,24 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			__set_bit(i, active);
 			break;
 		}
-
-		/*
-		 * Consider a zone as active if we can allow any number of
-		 * active zones.
-		 */
-		if (!device->zone_info->max_active_zones)
-			__set_bit(i, active);
 	}
 
 	if (num_sequential > 0)
 		cache->seq_zone = true;
 
 	if (num_conventional > 0) {
-		/*
-		 * Avoid calling calculate_alloc_pointer() for new BG. It
-		 * is no use for new BG. It must be always 0.
-		 *
-		 * Also, we have a lock chain of extent buffer lock ->
-		 * chunk mutex.  For new BG, this function is called from
-		 * btrfs_make_block_group() which is already taking the
-		 * chunk mutex. Thus, we cannot call
-		 * calculate_alloc_pointer() which takes extent buffer
-		 * locks to avoid deadlock.
-		 */
-
 		/* Zone capacity is always zone size in emulation */
 		cache->zone_capacity = cache->length;
-		if (new) {
-			cache->alloc_offset = 0;
+		ret = calculate_alloc_pointer(cache, &last_alloc, new);
+		if (ret) {
+			btrfs_err(fs_info,
+			  "zoned: failed to determine allocation offset of bg %llu",
+				  cache->start);
 			goto out;
-		}
-		ret = calculate_alloc_pointer(cache, &last_alloc);
-		if (ret || map->num_stripes == num_conventional) {
-			if (!ret)
-				cache->alloc_offset = last_alloc;
-			else
-				btrfs_err(fs_info,
-			"zoned: failed to determine allocation offset of bg %llu",
-					  cache->start);
+		} else if (map->num_stripes == num_conventional) {
+			cache->alloc_offset = last_alloc;
+			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				&cache->runtime_flags);
 			goto out;
 		}
 	}
@@ -1507,13 +1508,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
-	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags)) {
-		btrfs_get_block_group(cache);
-		spin_lock(&fs_info->zone_active_bgs_lock);
-		list_add_tail(&cache->active_bg_list, &fs_info->zone_active_bgs);
-		spin_unlock(&fs_info->zone_active_bgs_lock);
-	}
-
 out:
 	if (cache->alloc_offset > fs_info->zone_size) {
 		btrfs_err(fs_info,
@@ -1538,10 +1532,17 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = -EIO;
 	}
 
-	if (!ret)
+	if (!ret) {
 		cache->meta_write_pointer = cache->alloc_offset + cache->start;
-
-	if (ret) {
+		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			     &cache->runtime_flags)) {
+			btrfs_get_block_group(cache);
+			spin_lock(&fs_info->zone_active_bgs_lock);
+			list_add_tail(&cache->active_bg_list,
+				      &fs_info->zone_active_bgs);
+			spin_unlock(&fs_info->zone_active_bgs_lock);
+		}
+	} else {
 		kfree(cache->physical_map);
 		cache->physical_map = NULL;
 	}
-- 
2.37.2

