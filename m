Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E166E697E5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBOOb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBOObX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:23 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85138B55
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471481; x=1708007481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMIiQTrI/2Ssh3uyoT3ZTUAoTdNt3Yd9TyQ7h3/8LPs=;
  b=j80J13Q8hophbWmvZHRumntAFYIwoCkAuEizyxJCPc3mILrBOdAES/Ly
   OXXAdN4jnwn5WlWvYmGGow6BUVJ/qDZROCrgro3UyIqB8QjOGmIAWduCs
   xsigenlbrYSgkIdQqCUkTJ3vbNK4XH11YGobtt8ZJ5r34iuae0FEF7Fk6
   XktrbHnyZv6g1McAONvqQeY7N+aqjipZJLqfQG0W1hMxCBpNMH9JFRpuG
   Q8bJyYaFF6D95o7dKtxNTkiRORUV8jnSqNQL1/+ao+iHRTnAQ7exvn8Gk
   7HCMsyqSNId4+LCsGIi5/lUTR5239J2+B2YAMuSzIMnq5cUyaEIDBjXdB
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393918"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:14 +0800
IronPort-SDR: tGOIFkZa+aMXM8OyG9SjygYLvds41VNmqs8IIe/PnBzf05HpXxgFZHKnVq9UhTAZ+XIapfAGV3
 SgcENXW+ul9Lj1CpCDQmTIB599R82lhCll10YfFtRJ0iC3rHhrtbU8VkES3Opcv7IOQ2I99WNQ
 gjpTV86Mg6Eka3aCG7BTTsGHaEfrgnuN1mvHjuLWevb0Jt2+sDnzn1wxI9LayYt5rahJBpBRCX
 2/a1aoqzpDosuKjcugh6Rf5WK2Skq7qldRn+iggW2ZXR9S464VqxcLU9aOmeap3OT8+UffS2ve
 icI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:21 -0800
IronPort-SDR: wzFGQxWX/BZGO6CJnxN+FyqFAjX8wMerlX2WrZUK3UpBRjI7aTHjfIho91/e/fDP2NMSg2pDua
 jUC8tAcbLxL6aGpZFHG+WJCTnBn4S4tqXFLzayQf+jT6URA3z2WjqMC/+Lxzy9tIN5W9aOkiBs
 BjzU2vvaK3TN7+sEE/ZN/ICTXpaPUShbjlZ27WWM67Ke3BIrObkC0feDPegA05Vu1QS1VxaC73
 RalucPqDx+aKQjwlOkFO6LQMt5v2vrVKY9xR4LITwOrazOGWmtQUjNA8Mk+G+cniMv5jRwbkq+
 uKs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/6] btrfs-progs: read stripe tree when mapping blocks
Date:   Wed, 15 Feb 2023 06:31:07 -0800
Message-Id: <20230215143109.2721722-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/volumes.c | 116 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 65147d064934..466c0382bf10 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1795,6 +1795,105 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
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
@@ -1987,10 +2086,21 @@ again:
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
2.39.0

