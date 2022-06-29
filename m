Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0F560361
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiF2Olc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiF2Ola (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D13AA57
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513689; x=1688049689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNTPgRMxFMkhu0bhGuNQt17KfKUKms6w04bHkj1867A=;
  b=jkz/ccp7Cs9xoRpS6I3qAX9O4b6liA+EdAa2GLYiyjLskJddA+DI8Tvs
   1beSPaa/b5hpNlL9Fdtdw4iRZ50p46b9wru+s8RB8exjo2ZwPTmXwbQF9
   3PhkceOGtrIBBXslHF8IGcvV4Zu8Lae4sOZH+uCuPSY1PHuPdjPFznNFV
   GwlFCDjVMJqPFJFGfynb0KVsBJhr6zqPBouoDcyW3JzwntMJl8rGOjK+f
   Z1cVvmwf5wVGvc2wOp0pa0zczvkWs3/XVEO4Ap/AaYpDSj+4MdoaOPCut
   tk8PQ1jDORtvMH3fnuWXcPliNi1oDl0ziGCdOhzaY6VubKWu5RrpkEqxC
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064896"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:28 +0800
IronPort-SDR: Sj+wkL7rTTZlNAeO2iuL/Ocaf5kVuA+NHJz1WqVCsJyaevEv8BphAP2bXc7Y8l11GlB6+aC/ms
 pgMQ559+u0rEe6LwPXkaGPnVjVM++kUQg1FjsJeiH4MnlcqijW0QR4JSKlQs6mAGz7A3l+cY6U
 65LkyOaDAkmyWkjOVBhP0kqTSAGW/Gt+owz1ya5uyiz/OyFLkAagSgLkHSFQeGrFXt6CmrAsld
 M0tJqrrgiW4wDHO021WpJxSMkwb3lDRrFqU2xgvznjNqcrB0wY3xqWdOeFFkw0GAIFh80D0cai
 XvHd+/3ExXyXOSo+hNIxrJLs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:07 -0700
IronPort-SDR: bkwn/CwKuF+ksk4VBK7Ovtn89rkKs5jO3/uWT+Eb+AeMwiT5wvHwW0yHn3/9ZGs3ZIawdKim9F
 WkW/1JAwVKttuMIjOuA8Hc8cwsAXnymPKGTDsOT7VD7/3xJYt0xKzV7I72NxNu4a13Q7yAxucP
 Jd1Frn87zHWKmpOClvwSfvJrGmtpFIMx5sp79yD6C60g25cHzoav9dZLmw6cQxeN7B4dsuWfnC
 qEhsa/pzC6IcE0zWWje4klvWKtvHqSwKGC0YuDs5i1Mj8baWsxEdrY1Sw8vuP2ZGqKL6tPIIT4
 TpQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 6/8] btrfs: add code to read raid extent
Date:   Wed, 29 Jun 2022 07:41:12 -0700
Message-Id: <1f61c93be9354db6e53da4f404aa0f129f43a1e0.1656513330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656513330.git.johannes.thumshirn@wdc.com>
References: <cover.1656513330.git.johannes.thumshirn@wdc.com>
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

Add boilerplate code to lookup the physical address from the
raid-stripe-tree when a read on an RAID volume formatted with the
raid-stripe-tree was attempted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 65 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  3 ++
 fs/btrfs/volumes.c          | 22 +++++++++++--
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index a673aaf8e703..5ee630a792fc 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -7,6 +7,7 @@
 #include "disk-io.h"
 #include "raid-stripe-tree.h"
 #include "volumes.h"
+#include "misc.h"
 
 static struct rb_node *stripe_tree_insert(struct rb_root *root, u64 logical,
 					  struct rb_node *node)
@@ -251,3 +252,67 @@ void btrfs_raid_stripe_update(struct work_struct *work)
 	btrfs_put_bioc(bioc);
 }
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 length, u64 map_type,
+				 u64 devid, u64 *physical)
+{
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_dp_stripe *raid_stripe;
+	struct btrfs_key stripe_key;
+	struct btrfs_key found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	u64 offset;
+	u64 found_logical, found_length;
+	int num_stripes;
+	int slot;
+	int ret;
+	int i;
+
+	stripe_key.objectid = logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	num_stripes = btrfs_bg_type_to_factor(map_type);
+
+	ret = btrfs_search_slot_for_read(stripe_root, &stripe_key, path, 0, 0);
+	if (ret < 0) {
+		goto out;
+	}
+
+	if (ret == 1)
+		ret = 0;
+
+	while (1) {
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		found_logical = found_key.objectid;
+		found_length = found_key.offset;
+
+		if (!in_range(logical, found_logical, found_length))
+			goto next;
+		offset = logical - found_logical;
+
+		raid_stripe = btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
+		for (i = 0; i < num_stripes; i++) {
+			if (btrfs_stripe_extent_devid_nr(leaf, raid_stripe, i) != devid)
+				continue;
+			*physical = btrfs_stripe_extent_physical_nr(leaf, raid_stripe, i) + offset;
+			goto out;
+		}
+next:
+		ret = btrfs_next_item(stripe_root, path);
+		if (ret)
+			break;
+	}
+out:
+	btrfs_free_path(path);
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index d3cc24e37de1..75e17cad283a 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -16,6 +16,9 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 length, u64 map_type,
+				 u64 devid, u64 *physical);
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8d4e92c7196..2569ef564c97 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6526,9 +6526,27 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
+		u64 physical;
+
 		bioc->stripes[i].dev = map->stripes[stripe_index].dev;
+
+		if (fs_info->stripe_root && op == BTRFS_MAP_READ &&
+		   btrfs_need_stripe_tree_update(bioc->fs_info,
+						 map->type)) {
+			ret = btrfs_get_raid_extent_offset(fs_info, logical,
+							   map->stripe_len,
+							   map->type,
+							   bioc->stripes[i].dev->devid,
+							   &physical);
+			if (ret) {
+				btrfs_put_bioc(bioc);
+				goto out;
+			}
+		} else {
+			physical = map->stripes[stripe_index].physical +
+				stripe_offset + stripe_nr * map->stripe_len;
+		}
+		bioc->stripes[i].physical = physical;
 		stripe_index++;
 	}
 
-- 
2.35.3

