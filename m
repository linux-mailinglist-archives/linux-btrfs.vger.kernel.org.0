Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84D8528718
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbiEPOcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbiEPObx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D42612C
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711511; x=1684247511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5bQ9dGl2bwCOdg8E2fT/giGQQuN9We3cgBr7X3BV+9g=;
  b=U77U87IsA1+7MKGuMW3CLhonY1/71KlRZkgC4P2+jv3zEp8H7eMPX9on
   wFeqUiOpZ9BfwGqCEqxMbkeyGYWrNiCUTYJ7PVNOZQqcYOCXrjZUAnIt5
   Os2s9mcFyoYdzpanWb0nMklAIPlvmtfJBiHZ0mmtW2uP3inwD/M9VON1a
   oW3Gyy4Gfz05MzkqyeJ0+OrsX2vCc5Kvd1Pc6AHvTSCR7klNc4eYYSbG5
   oqcx3ouWtXwflk1eNZJY1BfVJCvQyL/tGj/L9Ygq+Wi9OrmVzVnflUWe/
   EAr0JoTyvm9tNCMVY3g15Pk9zxnGYoi77SptT+pNJeS5PnOQCNKMF5Xe3
   w==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309216"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:51 +0800
IronPort-SDR: lSHn7rLScukiv+MoeJk++i+9lz0+NqzKc9/2SP4+DuzR9Vt3Eo6Bx0FKYRqZaYBfPNvFywPvTX
 R2tP5+OUblyu9YLwcOlX+dj4uk7nIyk0FvQ9r7kJxEQOePcarExaCR+FnEEsDz/Q9oR3axc1/t
 Z4XnHjDNgepDnrUYA4//gVOrxvdvA4UqLUMjoYWQz4DTt/GnSoiMaUN2xZI0xSsEm3GQRE9IOD
 61luAI4qY+7EaVuWgHeBr0TMntYVCWdPYOGDlZ0cSUW5t6zuXVaCrl3A/6j7xQDgdvbcFGRQFY
 JOBbl5tNTrgWOGb0tK7GvwaQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:32 -0700
IronPort-SDR: XFJLJ9qZ4+0+N8EdrkFkPZUpqwVYMzwdV3F5Vrz+KlQfau6ETcjehGwkRR1VGHOCK3eFMGDkFK
 mOudVflpphwYldBxfxYcQXqPvOh6iXFzdg8qK34aNjsAl3HhtL5NyfoTFekQdgFhcGMbDRzlny
 BzL2kOAquoNg1be7Y7KCbl9ZcAlQdjjkryMQG7xXMKHx4lCx18XL/p2AsWnSEF42+gVHQ4NDMX
 xKx2Hph/HqXNOo3lMRXrILzT8H0Hua0+Qzc+rGcZgKdvOXoqytHcorcLk7EOhe3mhUH7I1EUQq
 yS8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 6/8] btrfs: add code to read raid extent
Date:   Mon, 16 May 2022 07:31:41 -0700
Message-Id: <2aa8aae2f6394b774f480d877f2701fed6fd74c4.1652711187.git.johannes.thumshirn@wdc.com>
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

Add boilerplate code to lookup the physical address from the
raid-stripe-tree when a read on an RAID volume formatted with the
raid-stripe-tree was attempted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 68 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  3 ++
 fs/btrfs/volumes.c          | 23 +++++++++++--
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 370ea68fe343..ecc8205be760 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -1,10 +1,78 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/btrfs_tree.h>
+
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
 #include "raid-stripe-tree.h"
 #include "volumes.h"
+#include "misc.h"
+
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
+		    goto next;
+		offset = logical - found_logical;
+
+		raid_stripe = btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
+		for (i = 0; i < num_stripes; i++) {
+			if (btrfs_stripe_extent_devid_nr(leaf, raid_stripe, i) != devid)
+				continue;
+			*physical = btrfs_stripe_extent_offset_nr(leaf, raid_stripe, i) + offset;
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
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length)
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 766634df8601..1bfa6274eef8 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -5,6 +5,9 @@
 
 #include "volumes.h"
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 length, u64 map_type,
+				 u64 devid, u64 *physical);
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
 void btrfs_raid_stripe_tree_fn(struct work_struct *work);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 36acef2ae5d8..38329728425c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6559,11 +6559,29 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
+	bioc->map_type = map->type;
 
 	for (i = 0; i < num_stripes; i++) {
-		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
+		u64 physical;
+
 		bioc->stripes[i].dev = map->stripes[stripe_index].dev;
+
+		if (fs_info->stripe_root && op == BTRFS_MAP_READ &&
+		   btrfs_need_stripe_tree_update(bioc)) {
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
 
@@ -6600,7 +6618,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	*bioc_ret = bioc;
-	bioc->map_type = map->type;
 	bioc->num_stripes = num_stripes;
 	bioc->max_errors = max_errors;
 	bioc->mirror_num = mirror_num;
-- 
2.35.1

