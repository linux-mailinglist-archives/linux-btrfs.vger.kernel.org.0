Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187865A9A05
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiIAOVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiIAOVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:21:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D955AC41
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662042075; x=1693578075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OCpUPrPhYWtnxmE8IcFkBlGUAKeG8x/pNSgiOu3ZNIk=;
  b=kyZ9DK55mHXgg8G2H5N4lge0CgWK/xmLYR4ulVb6LZJ/v4X1sUw7s2vw
   SpUX6RzTiI0akXiHbx804zrKCq3xSIu+3j4HE27erycA4cxClVx2pCvzw
   LW7KcnPpeaJfkOAVG4QNEESxqrU3M+4uQrg6B/hJPpcfxd6dAPEgrUslk
   rmyVnMmXGw1ERF4u30XnxzCWOM/A6zJqJH6qeCC2Ylh/rVypYDbdth0wM
   sqF3THPObdXxerqK0lGzFIN0Tf+JNoFnp57WEuSeRbaw/YxQX2Lt7st8R
   U00zUC7PNGRiGOrVHlCzzu0JX6Zh2aLtIKwfqZKLwjGCZMY2PSh3smeXd
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="210729470"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 22:21:13 +0800
IronPort-SDR: /xlJCqVAc+oRPSqNY0pDV0YfWrnKGa4iU6l8is1RLL5bVjECjMVtuwqNzRuajqrUMTBKCZ0LoH
 q7DAt2erQml+PWgHg8a869r3+CO7S4x8Olry+O+iemgGRrUPxo4lPQrhBdbbg+iiSXYA+XdloU
 GibbOywHP6oqHECXf+QH/LUdTVkpGNAbBXLUJIk++TFC1TcwFawTj/cQ2uIAmLN7gRph9FpwPe
 Hyxr4dQo6ZVPU3xAwszqfyNeMZAWVAGH7AJCFJn+rUxSDahH+odXGvCdHWqvgxrDddkdQS4nUj
 8+eIxSxss3nyIxYBHntZnzMT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 06:41:42 -0700
IronPort-SDR: 984x+CeTQcDTPP2NtmfbtSCLLqPLdzwYa63jdlSL4yITMNh0ZwNCtGQ0ygfaA+LIX7ubo10s2U
 WvpheiyUv7PbAC7+6STqWxVU5VNQemMQEVun3cbzP4r7EhvGy981dCE14Kfuyx6osRkh1s/dLk
 WkCqc84of4KY6v2/kNm9Ui1FJNE740jRs/CQzrZDMre4ZIbszk5xpzuAvDsuhklj5pKojnRtmV
 yud3RO+dZnHHTW0mcqDNNvsatjKRVM3dhSCq4wVfirt9RaCHkKILOkZNNRr2NQ6PU5R+Zx6fst
 EAc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Sep 2022 07:21:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix mounting with conventional zones
Date:   Thu,  1 Sep 2022 07:21:07 -0700
Message-Id: <0fef711e5ed1d9df00a5a749aab9e3cd3fe4c14c.1662042048.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/zoned.c | 68 ++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e12c0ca509fb..364f39decb4e 100644
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
@@ -1398,45 +1420,29 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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
+			btrfs_get_block_group(cache);
+			spin_lock(&fs_info->zone_active_bgs_lock);
+			list_add_tail(&cache->active_bg_list,
+				      &fs_info->zone_active_bgs);
+			spin_unlock(&fs_info->zone_active_bgs_lock);
 			goto out;
 		}
 	}
-- 
2.37.2

