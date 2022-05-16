Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADB52871A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiEPOb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244527AbiEPObw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3126127
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711510; x=1684247510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YiY0Z3bgHLxnnf5g72kdJkcGbIgAF4jcYh/yhyMQGO8=;
  b=hq4Aa9PKcdpZitxBQY6KNd0+jn3hJtn1av1Zi8UlMkbz6Ga4ng2La0uu
   +D9JYvDfKX0+X2gEFgbb4JVdRaVyGGunBAyeRLHTbuSS+cpqSvXZzq7Rz
   inQ1D01z1awLWmB5TD/xrMsM5BtUWfRYSGNceCW7XWzDeXIzxfv6bbaKL
   S1flb4LkeaGjmjksghZL05JzJEROwdtOhWyeUX4+W6jn/H8oBqmAeo3FP
   hUzJPvpQMP7roejn9Li10MognsMekyWQk+ll5yBei092gR1+QiKZphPY0
   ZdgXSBv66mbTO1sbyxF2UR8ufh3QihxqM3uub42dp4+3VGiRJqrQzRWt8
   g==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309215"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:50 +0800
IronPort-SDR: EwDXZDwwurfVlBGpl3E52qoZ8kq2nohRIGgKTGHNKpSofj3p3GnOVFdM6vU5Gbm5ldvTp2vl4s
 Gladd+qnvAdidihuTK5f3GRED1ItJ1ZizUztOR96yY+QpH4gn8YOTnpFpLcHIFRh/nyl/eMO6H
 KWQVj5scmaczyMYDOPFFLhoe9qDOkmINbkC05pG+tf2z0QfLmI/u7qfi6zVn2jAfgcKZE9/Exx
 It/hPEOOmrjJY2BfjTEP+g+hE/jLi6J4N0Gm2OKBN2ZWPl/apQTfbhD288+mje+gZ5QQiwVjjn
 NTz8OnFI3dptDhTczzitnYLj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:32 -0700
IronPort-SDR: uf+kuCyM54UTodEIsScfNhzPXHdbApwXu5QkSgSq3n2DGjJqWxJXjUAQZJiXPhx92Svn60161Q
 DNoK8shXUDvBL32bDy9yjovyADhX8Ibn71/cziaQS27BvEbu9iF6DqR/qXXGUJQqHl/FEnzhWy
 f973YjzqtcjbL2+dsf8TYHR9cHtBCl8YF4tWj7NxAA8hjrL3wyeKfq2cjixkTqXsebt1ctJDMY
 XNlDyQFPeF4Q9R5T7as+ljMtuJpFaOoAS4KvKr6JrywCHpzbOEF4GVZMqSDXhc7/8BLOR85gfp
 WwI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Date:   Mon, 16 May 2022 07:31:40 -0700
Message-Id: <b018704727883c27c3368f1cd3ba84daf682b733.1652711187.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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

Add boilerplate code to delete entries from the raid-stripe-tree if the
corresponding file extent got deleted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.c            |   1 +
 fs/btrfs/extent-tree.c      |   9 +++
 fs/btrfs/file.c             |   1 -
 fs/btrfs/raid-stripe-tree.c | 111 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |   8 +++
 5 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1e24695ede0a..b7b4e421e9b8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3623,6 +3623,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f477035a2ac2..00af3e469881 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -36,6 +36,7 @@
 #include "rcu-string.h"
 #include "zoned.h"
 #include "dev-replace.h"
+#include "raid-stripe-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -3199,6 +3200,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
+		if (is_data) {
+			ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+		}
+
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		if (ret) {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bd329316945f..6021188dcb9a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1009,7 +1009,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 out:
 	args->drop_end = found ? min(args->end, last_end) : args->end;
-
 	return ret;
 }
 
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 426066bd7c0d..370ea68fe343 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -6,6 +6,117 @@
 #include "raid-stripe-tree.h"
 #include "volumes.h"
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_path *path;
+	struct btrfs_key stripe_key;
+	struct btrfs_key found_key;
+	struct extent_buffer *leaf;
+	u64 end = start + length;
+	u64 found_start;
+	u64 found_end;
+	int slot;
+	int ret;
+
+	if (!stripe_root)
+		return 0;
+
+	stripe_key.objectid = start;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = end;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, stripe_root, &stripe_key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+	if (ret == 0)
+		goto delete;
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	btrfs_item_key_to_cpu(leaf, &found_key, slot);
+	found_start = found_key.objectid;
+	found_end = found_start + found_key.offset;
+
+	/*
+	 * | -- range to drop --|
+	 * | ---------- extent ---------- |
+	 */
+front_split:
+	if (start > found_start) {
+		struct btrfs_key front_key;
+		struct btrfs_dp_stripe *raid_stripe;
+		struct extent_buffer *front_leaf;
+		struct btrfs_stripe_extent *stripe_extent;
+		int num_stripes;
+		int i;
+
+		front_key.objectid = found_start + length;
+		front_key.type = BTRFS_RAID_STRIPE_KEY;
+		front_key.offset = found_end - length;
+
+		num_stripes = btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
+
+		ret = btrfs_duplicate_item(trans, stripe_root, path, &front_key);
+		if (ret == -EAGAIN) {
+			btrfs_release_path(path);
+			goto front_split;
+		}
+		if (ret < 0)
+			goto out;
+		front_leaf = path->nodes[0];
+
+		raid_stripe = btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
+		stripe_extent = &raid_stripe->extents;
+		for (i = 0; i < num_stripes; i++) {
+			u64 physical;
+
+			physical = btrfs_stripe_extent_offset(leaf, stripe_extent);
+			btrfs_set_stripe_extent_offset(front_leaf, stripe_extent,
+							  physical + length);
+			stripe_extent++;
+		}
+
+		btrfs_mark_buffer_dirty(front_leaf);
+	}
+
+	/*
+	 *           | -- range to drop --|
+	 * | ---------- extent ---------- |
+	 */
+tail_split:
+	if (end < found_end) {
+		struct btrfs_key tail_key;
+
+
+		tail_key.objectid = start;
+		tail_key.type = BTRFS_RAID_STRIPE_KEY;
+		tail_key.offset = found_end - end;
+
+		ret = btrfs_duplicate_item(trans, stripe_root, path, &tail_key);
+		if (ret == -EAGAIN) {
+			btrfs_release_path(path);
+			goto tail_split;
+		}
+		if (ret < 0)
+			goto out;
+		btrfs_mark_buffer_dirty(path->nodes[0]);
+	}
+
+delete:
+	ret = btrfs_del_item(trans, stripe_root, path);
+out:
+	btrfs_free_path(path);
+	return ret;
+
+}
+
 static void btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_io_context *bioc)
 {
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 320a110ecc66..766634df8601 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -5,8 +5,16 @@
 
 #include "volumes.h"
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 void btrfs_raid_stripe_tree_fn(struct work_struct *work);
 
+static inline int btrfs_num_raid_stripes(u32 item_size)
+{
+	return item_size - offsetof(struct btrfs_dp_stripe, extents) /
+		sizeof(struct btrfs_stripe_extent);
+}
+
 static inline bool btrfs_need_stripe_tree_update(struct btrfs_io_context *bioc)
 {
 	u64 type = bioc->map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
-- 
2.35.1

