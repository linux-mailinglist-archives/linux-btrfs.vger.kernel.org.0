Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686F79AFD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356108AbjIKWCy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbjIKMwk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED4CEB;
        Mon, 11 Sep 2023 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436756; x=1725972756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNfuLA8tG2aivaq6yjp4JQ9c65/XbLN/yRBDi9R2XTE=;
  b=G71DJe5mBJCJcF5WDGKl0PGnjnF294kTQ9oh7ugeoNY65oPmSOOThOpG
   WMl0TXb2w+H0hgeGk+IyRJFIVsvOSbD+R+bsRZb478ZvP4l2bTNIJF3LM
   2aCYhCO7QIMsrMx68fD/ZEc/3MS4GsBi4DZ9G5i9HPioJKXcMLgKzhs8Z
   2+B+VxiNwG9JO1sVsM2llDz1mledc7LUrLDxcVL0HQTcXdp6IZdCCHoyn
   WjvP/Wq4AuqpZjabRhzu4BVUlpuyaexODs8rv+P4VA8sEg/O2NyZEre1O
   JhY9mLaX8a0tz8bi2BAxMStIbhIlFrzCbxOHE8GYR8KhqQKoEMz6vN9fC
   w==;
X-CSE-ConnectionGUID: Htx3DRGgTkSfk/QSz6i4wQ==
X-CSE-MsgGUID: hD9kqg/eTb6Q+5QwIbBYHg==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594399"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:36 +0800
IronPort-SDR: NPIuTsyUGUwDs10k5kFNYmPz1bMKnbTPipyvZjhEFvdPlbT2WcZOhNAH6YXg8SVXveqpTBvylQ
 6S2lyd1vF14lOgyRmxBQv5RmVWGmhic6c4OId0Z3RHBCzBCvdJs9PpYAyBdzAatJ699MYn4x2f
 CuW8jOdOZIOFpb1xhAzTxEc+llwsvNOUS9FloUzVnwbRvkQrWwET6VXHS9Tfi2m52C+T+MfxmV
 BTXj4/1XqxcWU65JggdlEvyE63xQZEKqWjHzXDW1s7lc2t+1V9UDVhuxAFIzEnTHkNWEMN8Wb7
 OKU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:05:22 -0700
IronPort-SDR: 3b4LOtVH9XTHOOqFKz2/ds6Q2VOATKJRKWadc42bzCwW8mWkh3KmLjVTaKTEc3ufCKQ5ffMKuV
 bytkYrjU18p/SXFJlrqRgzydE5pURVrAnGdqlmiNu6/sYoF6Mp73cxJwxyavSDeew3r2KoXAYG
 v/faX2KROTKmkTJVQK91QVdn1HNkUEOeCh1Ayq0j8+ohBxCIxoBpSUii70HeGxpLq/BzQj3Z9C
 5ILh29aNxzi43M/Z/SduN1+86beIcxs8IHyOtu5cr8I2RFUIF/wdD/KzOlPiFIzp6UNC246qAC
 W4w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/11] btrfs: zoned: allow zoned RAID
Date:   Mon, 11 Sep 2023 05:52:08 -0700
Message-ID: <20230911-raid-stripe-tree-v8-7-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=5991; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=oNfuLA8tG2aivaq6yjp4JQ9c65/XbLN/yRBDi9R2XTE=; b=vw/lnwXT5Qma1bXsUIEGpCkgShSXIJEsBfWlzjWUPPC9HI2KqCTQtiVdkjCd0lxZR6f1SxK24 uVFJ52XWAKlAkCECmstLS0V1KdUhCeIlE9lZ9nBwAF6Y3Jpau+LnfDK
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
data block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.h |   7 ++-
 fs/btrfs/volumes.c          |   2 +
 fs/btrfs/zoned.c            | 113 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 40aa553ae8aa..30c7d5981890 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -8,6 +8,11 @@
 
 #include "disk-io.h"
 
+#define BTRFS_RST_SUPP_BLOCK_GROUP_MASK		(BTRFS_BLOCK_GROUP_DUP |\
+						 BTRFS_BLOCK_GROUP_RAID1_MASK |\
+						 BTRFS_BLOCK_GROUP_RAID0 |\
+						 BTRFS_BLOCK_GROUP_RAID10)
+
 struct btrfs_io_context;
 struct btrfs_io_stripe;
 
@@ -32,7 +37,7 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 	if (type != BTRFS_BLOCK_GROUP_DATA)
 		return false;
 
-	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
+	if (profile & BTRFS_RST_SUPP_BLOCK_GROUP_MASK)
 		return true;
 
 	return false;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7c25f5c77788..9f17e5f290f4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6438,6 +6438,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
+	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
+	      op != BTRFS_MAP_READ) &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
 		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
 				    stripe_index, stripe_offset, stripe_nr);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c6eedf4bfba9..4ca36875058c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1481,8 +1481,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
-		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
-			btrfs_err(fs_info, "zoned: profile DUP not yet supported on data bg");
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info, "zoned: data DUP profile needs stripe_root");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1520,8 +1521,116 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_capacity = min(caps[0], caps[1]);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data %s needs stripe_root",
+				  btrfs_bg_type_to_raid_name(map->type));
+			ret = -EIO;
+			goto out;
+
+		}
+
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if ((alloc_offsets[0] != alloc_offsets[i]) &&
+			    !btrfs_test_opt(fs_info, DEGRADED)) {
+				btrfs_err(fs_info,
+					  "zoned: write pointer offset mismatch of zones in %s profile",
+					  btrfs_bg_type_to_raid_name(map->type));
+				ret = -EIO;
+				goto out;
+			}
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_test_opt(fs_info, DEGRADED) &&
+				    !btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			/*
+			 * In case a device is missing we have a cap of 0, so don't
+			 * use it.
+			 */
+			cache->zone_capacity = min_not_zero(caps[0], caps[i]);
+		}
+
+		if (alloc_offsets[0] != WP_MISSING_DEV)
+			cache->alloc_offset = alloc_offsets[0];
+		else
+			cache->alloc_offset = alloc_offsets[i - 1];
+		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data %s needs stripe_root",
+				  btrfs_bg_type_to_raid_name(map->type));
+			ret = -EIO;
+			goto out;
+
+		}
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			cache->zone_capacity += caps[i];
+			cache->alloc_offset += alloc_offsets[i];
+
+		}
+		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data %s needs stripe_root",
+				  btrfs_bg_type_to_raid_name(map->type));
+			ret = -EIO;
+			goto out;
+
+		}
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			if ((i % map->sub_stripes) == 0) {
+				cache->zone_capacity += caps[i];
+				cache->alloc_offset += alloc_offsets[i];
+			}
+
+		}
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 		/* non-single profiles are not supported yet */

-- 
2.41.0

