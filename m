Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011A79BEAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356044AbjIKWCr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbjIKNXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E2CD7
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438596; x=1725974596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zApmCeqyy3SfHYiANMzUPLxS2p9rjxha3fR6HA0U5Bc=;
  b=AhOxesRnj9bhDL3oZgzIc3xgiADKfQTJ+4Asg6+8MNmOJmgKN9R7UEpQ
   kek7uUeSrXiwwWaLXVoJMQLmg+7WIbaygaBrDHh/R2zlEDumGCqgXsvBI
   IMyNW1iBY3kECb+qsHRRU7y3Lf3LJPlZcrblSxvBQy6TWL+pCDrQJf1nW
   LtINccU3igbV2uOb4QY5kNxt5AR0mxAnZ9X2+FJ2LjZezSGmfKgvoccGO
   Mp4+kaXPgylbL1zJ7FDaCGpBseUOpoh2OMS/yGshBQGmcPz2LRAOb18Z+
   /tCmIm5y8i5VC3ALgUL+uEL8YtFB6TvFRKPxAp6Qs2dc1ITrsLT+QDVIB
   Q==;
X-CSE-ConnectionGUID: YsJv9saxQCirmCnV7m52UQ==
X-CSE-MsgGUID: nJtvIU8oSPOvDWqPP/tpdQ==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143285"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:15 +0800
IronPort-SDR: BPJc67i2ybptmxj5GfA2lAmeT5NRz946asZNynxVV+NROdLYg2Ig6cRKRWFWU7muaegu9haDRU
 mJfR7IFfGGuiCCpK53Z0bMTLKB7bGHVzYIX755FSETTCoD8zqsQGM3xiv6JTIPjKmQNmZbSNIN
 TB9fY4eVqQjY1ZjNdCA3kQyVIylomgq+iRprTGfYgoe4w0iz+4JmqzUt1itNwnO1A5Pp+ANkv5
 rLWIjcTCNhOBdGVruQ+eqThtLwyeS9L2DvUsrePnv/f/xTBYUO4zDvyzw62CP3qoB6BA/Nh90w
 po4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:21 -0700
IronPort-SDR: y/d6LHwrN/xp1wcd8LFYJT39BeEAI4SItIc7uDRL7BtCzEjRKDZk8qPeMgucbFJGR+Ik8JUgWI
 MRDtiP6Patob290pElqm2UUTSAz+bAL9iWuX0QPAQC0SXPnzKK84dSW6UVK3Q/sTNIOr8NRH6+
 DYyiwLp5WxieiIEz6rFIbvSUoclw8/Eus74VEBOizPpr6FPwJQOmhBtVXc7dPpegVhRk2l3ahX
 2ITRsLq/5biyyjzezEFrTc+cQzDCHvM96TzEPlzVuIWDRpa5jNsR527i7Qu8FFqqvxYHIrAkVY
 /Gg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs-progs: read stripe tree when mapping blocks
Date:   Mon, 11 Sep 2023 06:23:02 -0700
Message-ID: <20230911-raid-stripe-tree-v1-6-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
References: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=3680; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=zApmCeqyy3SfHYiANMzUPLxS2p9rjxha3fR6HA0U5Bc=; b=GulItj5X+0XtrBgZehtIsXYfOpPTJHya2oSII2x5INWmrD59gDpDqwA4ShbitLPVWGJiPdwmm cBU96kUrpgxAoXjG+c1ZRXeiysG2fxEmoFw0vJsLMw3O68/4I5pVobD
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/volumes.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 95d5930b95d8..2081f7db088f 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1796,6 +1796,105 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 				 multi_ret, mirror_num, raid_map_ret);
 }
 
+static bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
+					u64 map_type)
+{
+#if EXPERIMENTAL
+	const bool is_data = (map_type & BTRFS_BLOCK_GROUP_DATA);
+
+	if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE))
+		return false;
+
+	if (!fs_info->stripe_root)
+		return false;
+
+	if (!is_data)
+		return false;
+
+	if (map_type & BTRFS_BLOCK_GROUP_DUP)
+		return true;
+
+	if (map_type & BTRFS_BLOCK_GROUP_RAID1_MASK)
+		return true;
+
+	if (map_type & BTRFS_BLOCK_GROUP_RAID0)
+		return true;
+
+	if (map_type & BTRFS_BLOCK_GROUP_RAID10)
+		return true;
+
+#endif
+	return false;
+}
+
+static int btrfs_stripe_tree_logical_to_physical(struct btrfs_fs_info *fs_info,
+						u64 logical,
+						struct btrfs_bio_stripe *stripe)
+{
+	struct btrfs_root *root = fs_info->stripe_root;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int slot;
+	int ret;
+
+	key.objectid = logical;
+	key.type = BTRFS_RAID_STRIPE_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	while (1) {
+		struct btrfs_key found_key;
+		struct btrfs_stripe_extent *extent;
+		int num_stripes;
+		u32 item_size;
+		int i;
+
+		leaf = path.nodes[0];
+		slot = path.slots[0];
+
+		if (slot >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(root, &path);
+			if (ret == 0)
+				continue;
+			if (ret < 0)
+				goto error;
+			break;
+		}
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+		if (found_key.type != BTRFS_RAID_STRIPE_KEY)
+			goto next;
+
+		extent = btrfs_item_ptr(leaf, slot,
+					struct btrfs_stripe_extent);
+		item_size = btrfs_item_size(leaf, slot);
+		num_stripes = (item_size -
+			offsetof(struct btrfs_stripe_extent, strides)) /
+			sizeof(struct btrfs_raid_stride);
+
+		for (i = 0; i < num_stripes; i++) {
+			if (stripe->dev->devid !=
+				btrfs_raid_stride_devid_nr(leaf, extent, i))
+				continue;
+			stripe->physical = btrfs_raid_stride_offset_nr(leaf, extent, i);
+			btrfs_release_path(&path);
+			return 0;
+		}
+
+next:
+		path.slots[0]++;
+	}
+
+	btrfs_release_path(&path);
+error:
+	return ret;
+}
+
 int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 		      u64 logical, u64 *length, u64 *type,
 		      struct btrfs_multi_bio **multi_ret, int mirror_num,
@@ -1988,10 +2087,21 @@ again:
 	BUG_ON(stripe_index >= map->num_stripes);
 
 	for (i = 0; i < multi->num_stripes; i++) {
-		multi->stripes[i].physical =
-			map->stripes[stripe_index].physical + stripe_offset +
-			stripe_nr * map->stripe_len;
 		multi->stripes[i].dev = map->stripes[stripe_index].dev;
+
+		if (stripes_allocated &&
+			btrfs_need_stripe_tree_update(fs_info, map->type)) {
+			int ret;
+
+			ret = btrfs_stripe_tree_logical_to_physical(fs_info, logical,
+								&multi->stripes[i]);
+			if (ret)
+				return ret;
+		} else {
+			multi->stripes[i].physical =
+				map->stripes[stripe_index].physical +
+				stripe_offset + stripe_nr * map->stripe_len;
+		}
 		stripe_index++;
 	}
 	*multi_ret = multi;

-- 
2.41.0

