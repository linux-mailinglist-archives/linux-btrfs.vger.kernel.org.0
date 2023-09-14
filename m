Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE27F7A0A45
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbjINQFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbjINQFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76201BDD
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707545; x=1726243545;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zApmCeqyy3SfHYiANMzUPLxS2p9rjxha3fR6HA0U5Bc=;
  b=J6dNZ6gjveH/SLKfuDmjZrMp7cvMQGzUrlePwOH6sKPRKC4HklyPBCHk
   DL9VyegE+N42KjOY+c4XNHm94QpM0gYAVr7mi5EcsHdipWBCc42rf79d+
   k4CC30kZcqljmuaKFzcz3jMEaT1m1lyXcxWI8gHo6dR/GxpgjtgX4rfbO
   n8CHW037F5GwbMQev/A9ZeVOcZ1MQQ9ZFTpDpdXGPXAEGJ6Ffem4r8BJr
   Tm4p13pDOcuqKcpUxJUfcqwEV3GuHsye6pzWdsJlPTft4h36XljXYCu/Q
   FybxGS4taUi/mgdh27XIkFe0brrr8rHfPMn+EiKvMjF3exkCApt+hwey2
   A==;
X-CSE-ConnectionGUID: g8EtlwefRVKgza/XDWPPEQ==
X-CSE-MsgGUID: oRZicmpbT2+cWOKi03fKlA==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196094"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:45 +0800
IronPort-SDR: Skx1s6jW8r373EiJlOAvWwyoNIrD65eyeIPZ/N6Zxu71p1kI/zk/MeSp9/cT+aoWskrYulcNBg
 5bcMXnhUc6ag3oYELkb/uSDReORyYKe7fzyNGpLT3YbpLxYdyG/ZcsnPXRBa3WowrpycP7GjG4
 aomeQ1GbGk64KqhFOFWpDQcapbjNejkARfTJqqz1H38c9XqjbH8+PCkrN4ZKiuC/6usdYwDypp
 Dfr2olWBVRcIIyJnShWZ+4cgAquLOpm93WVgsB3NmIxupCVYxYh4y86JHV8jjI5oPo3zTdo7rA
 poY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:28 -0700
IronPort-SDR: 69iFPuve+Xn+LfDduX4MaOY2XahvPTUNkvzuEb6cx/YGr8Paq5g2YQ4RghWjHELC0Cn1LC4Z9Q
 0Hh384GupQt8LAuaYaxXXXKcz+5wP0JYp+bAj5jOD3u5e481yGGBLILRgBr/vnXvMyxIhhHYdZ
 gyOGYdu89BhKMAzAJDfdXsfessXG2OqKnFqRYOOFLQIbm6m2kA+6MmsSu/M1QZmGbSxLKyz2kZ
 cfGRyAtiBp5QmsTENKoyVeTquceVDvGDx479aAcopetEaETZ59jMu9gSOQgusfWJ4JZqjPM5Ks
 YYY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:46 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:05:37 -0700
Subject: [PATCH v4 6/6] btrfs-progs: read stripe tree when mapping blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v4-6-c921c15ec052@wdc.com>
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=3680;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=zApmCeqyy3SfHYiANMzUPLxS2p9rjxha3fR6HA0U5Bc=;
 b=jLrWyk9NsnDv2EftcMZ/NaxnZNBf5bg/Td5HTBO711oF569qZG+qdOhAPyOJfaBzFphdt6jCj
 Ub9yDAYYZLaBVyfe4GRRvusPCAXDxBHFZiF62Wz49knsSoFZkkYJulQ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
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

