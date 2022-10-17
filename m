Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C7600E46
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJQLzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJQLzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CAF4F683
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007740; x=1697543740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZTS60uHAkYTfgc3cMN+8MQhVDavETbhol8zkM/sUVYk=;
  b=XzOAN/WplcBWU8KxELmK7h/yIM7ZVJBPF/eXdubQ7BWNxhOxfsMuN2ky
   WK04jJZSa77NvMlRQD49qJRmclmFa59WNSVwxZUI0X+YnIs+jWhBW4F12
   GAT7IgVPQQ/6RLI3oe7Lj/h7NoGYstoj1zzYuAdApsHu53WyTlQE3HfnT
   KVAyM01aXuaWRV34iqD3LlPe5HAITHc1ZUflpnE97gCfCXTQrUZRWLRR2
   gO4DraTb4ophXb9391lsssefjncnPDeRw6GuW5SxpcMnlVPT/wkLu+UUL
   HejfvALi9qZiE6V/IM45qlOSNtGxqjIrrSTPVNytTLizDWEoK9Ft+DqzA
   A==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337161"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:38 +0800
IronPort-SDR: z/FcemTqXPnHMiAEajlqMS6Z4pKIuRm590hPDxAttlkz4JzVZAU4j+haHhStL70alBJ6rYHghV
 kJUXOPDHqP7Va+bbhVZTkBmg6/LuduvZbDnFpFZE3uG420mq8AUFTfiznJvbVaPTEeZ/mGUgs/
 1CnK0l67tAXo6nUQA+SULFBBG/ZzlPt6rg376+cz4wHOnFqTX2QxVUs2qJvpBbIugAvVbXaQb7
 z8vhHpmm3cY8bpvm4p/QVMA+yKhuLgLXVLSFKTot+aXgLhe9Pvyn3CUMyKJCua52/u9AHyNFcd
 iTLy7nKVwLn0CPE8C4YjFp6h
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:11 -0700
IronPort-SDR: MOCoqbrpbTbO3SoDw7wEr/+OWJWKxPiYpOGJRDZdp01k84Sf1H5mn0vLJSzQ4LQMVoh2Psen49
 K/jqGpQbl9Wp4orvJeBB8jRYxTyqJnRgYvpMKrdd/SYjgF3rkoJkWPHVoopWPqjMmOoaV4/szi
 tF/aycoR4V8NbbGTP6QxCqyEigFIlmeK12FJU1iMA0zM9DMZ++2sDEhHRjAMRaSFWxz3UViIcV
 3hF4ziKv7M/mrnvkhxnx3dFGsjrmhkKLXZxadQQUlDjrXDMdGNF3ZbGbZ5Vp0R1CPAvThaJ+6J
 kaY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:38 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 05/11] btrfs: lookup physical address from stripe extent
Date:   Mon, 17 Oct 2022 04:55:23 -0700
Message-Id: <85853887c5f50188e32f879be823c690c33af9d3.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
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

Lookup the physical address from the raid stripe tree when a read on an
RAID volume formatted with the raid stripe tree was attempted.

If the requested logical address was not found in the stripe tree, it may
still be in the in-memory ordered stripe tree, so fallback to searching
the ordered stripe tree in this case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 142 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |   3 +
 fs/btrfs/volumes.c          |  30 ++++++--
 3 files changed, 168 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 5750857c2a75..91e67600e01a 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -218,3 +218,145 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+
+static bool btrfs_physical_from_ordered_stripe(struct btrfs_fs_info *fs_info,
+					      u64 logical, u64 *length,
+					      int num_stripes,
+					      struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_ordered_stripe *os;
+	u64 offset;
+	u64 found_end;
+	u64 end;
+	int i;
+
+	os = btrfs_lookup_ordered_stripe(fs_info, logical);
+	if (!os)
+		return false;
+
+	end = logical + *length;
+	found_end = os->logical + os->num_bytes;
+	if (end > found_end)
+		*length -= end - found_end;
+
+	for (i = 0; i < num_stripes; i++) {
+		if (os->stripes[i].dev != stripe->dev)
+			continue;
+
+		offset = logical - os->logical;
+		ASSERT(offset >= 0);
+		stripe->physical = os->stripes[i].physical + offset;
+		btrfs_put_ordered_stripe(fs_info, os);
+		break;
+	}
+
+	return true;
+}
+
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	int num_stripes = btrfs_bg_type_to_factor(map_type);
+	struct btrfs_dp_stripe *raid_stripe;
+	struct btrfs_key stripe_key;
+	struct btrfs_key found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	u64 offset;
+	u64 found_logical;
+	u64 found_length;
+	u64 end;
+	u64 found_end;
+	int slot;
+	int ret;
+	int i;
+
+	/*
+	 * If we still have the stripe in the ordered stripe tree get it from
+	 * there
+	 */
+	if (btrfs_physical_from_ordered_stripe(fs_info, logical, length,
+					       num_stripes, stripe))
+		return 0;
+
+	stripe_key.objectid = logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (ret) {
+		if (path->slots[0] != 0)
+			path->slots[0]--;
+	}
+
+	end = logical + *length;
+
+	while (1) {
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		found_logical = found_key.objectid;
+		found_length = found_key.offset;
+
+		if (found_logical > end)
+			break;
+
+		if (!in_range(logical, found_logical, found_length))
+			goto next;
+
+		offset = logical - found_logical;
+		found_end = found_logical + found_length;
+
+		/*
+		 * If we have a logically contiguous, but physically
+		 * noncontinuous range, we need to split the bio. Record the
+		 * length after which we must split the bio.
+		 */
+		if (end > found_end)
+			*length -= end - found_end;
+
+		raid_stripe = btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
+		for (i = 0; i < num_stripes; i++) {
+			if (btrfs_stripe_extent_devid_nr(leaf, raid_stripe, i) != 
+			    stripe->dev->devid)
+				continue;
+			stripe->physical = btrfs_stripe_extent_physical_nr(leaf,
+						   raid_stripe, i) + offset;
+			ret = 0;
+			goto out;
+		}
+
+		/*
+		 * If we're here, we haven't found the requested devid in the
+		 * stripe.
+		 */
+		ret = -ENOENT;
+		goto out;
+next:
+		ret = btrfs_next_item(stripe_root, path);
+		if (ret)
+			break;
+	}
+
+out:
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret) {
+		btrfs_err(fs_info,
+			  "cannot find raid-stripe for logical [%llu, %llu]",
+			  logical, logical + *length);
+		btrfs_print_tree(leaf, 1);
+	}
+	btrfs_free_path(path);
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 3456251d0739..083e754f5239 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -16,6 +16,9 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 struct btrfs_io_stripe *stripe);
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 261bf6dd17bc..c67d76d93982 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6313,12 +6313,21 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 	return U64_MAX;
 }
 
-static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
-		          u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
+static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		      u64 logical, u64 *length, struct btrfs_io_stripe *dst,
+		      struct map_lookup *map, u32 stripe_index,
+		      u64 stripe_offset, u64 stripe_nr)
 {
 	dst->dev = map->stripes[stripe_index].dev;
+
+	if (fs_info->stripe_root && op == BTRFS_MAP_READ &&
+	    btrfs_need_stripe_tree_update(fs_info, map->type))
+		return btrfs_get_raid_extent_offset(fs_info, logical, length,
+						    map->type, dst);
+
 	dst->physical = map->stripes[stripe_index].physical +
 			stripe_offset + stripe_nr * map->stripe_len;
+	return 0;
 }
 
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
@@ -6507,13 +6516,14 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			smap->dev = dev_replace->tgtdev;
 			smap->physical = physical_to_patch_in_first_stripe;
 			*mirror_num_ret = map->num_stripes + 1;
+			ret = 0;
 		} else {
-			set_io_stripe(smap, map, stripe_index, stripe_offset,
-				      stripe_nr);
 			*mirror_num_ret = mirror_num;
+			ret = set_io_stripe(fs_info, op, logical, length, smap,
+					    map, stripe_index, stripe_offset,
+					    stripe_nr);
 		}
 		*bioc_ret = NULL;
-		ret = 0;
 		goto out;
 	}
 
@@ -6525,8 +6535,14 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		set_io_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
-			      stripe_nr);
+		ret = set_io_stripe(fs_info, op, logical, length,
+				 &bioc->stripes[i], map, stripe_index,
+				 stripe_offset, stripe_nr);
+		if (ret) {
+			btrfs_put_bioc(bioc);
+			goto out;
+		}
+
 		stripe_index++;
 	}
 
-- 
2.37.3

