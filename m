Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAFB528717
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbiEPObz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244524AbiEPObw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1A27CD0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711510; x=1684247510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CelhjqNeNdGGkBBYNLfa/DwOWgeZ/5gIhqceleUjmXI=;
  b=ls6ZiqLPabvt0e0gxIFdGD5qs7hN34JGzsxVEL1lPcl0cuOK/Cf/xYf9
   Vt1w/HbycsjcBp8gL2zhyUtBn1vDv3OcTbKheQHVezs/KMf5P59kd5f/T
   mODRJxXRoIxyMaV5pHHQE/kykwW4tRfE+pZKMFbTRg6Iay7Gyl7z49dfC
   PqRJNORGFuL7lfhdw0JNKee1ACWmc0DdF2zJFdUMktBKg2MrJcoIN2pIZ
   gkjDh4KGWaySGWi/s/uZVfH5Oi6MzueToFxu/j65IDMNmmANIJj+4fhsW
   A7Q9vsdeiwBTMIaOY2WMGo3pzRC8464RYSsnuvp42LLqg1mJtZBPBlVhb
   w==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309213"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:49 +0800
IronPort-SDR: c2gofTRjvOdZL0gxrpCWNAQ8rvAQNWokoKZV0unGy36IWGkvtxDUlymF/pv4MprkxN4x6pbXVG
 t5gnhKWyE0Ws6+WchRPAI4sG4T3cn7FlEY4hMEJMsI+vxQAdxpVvpHFFvsS9JzF4B8rBxynOaL
 QZjL0eE6NZT4SVcSzzFiuffCDxIFXSUTouJHeNXxQ/k78oixHlBfz/RANiwcJ+a5eGI5tup/8h
 Egu5VOHL5btuadcyaiPW110HnmkGoJfkhozsrXqmc6cDjTbnCtIqASqmTzsLrKkAZhShLWB1s5
 lOgoXyI4rzteTBRVe2LcURSo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:31 -0700
IronPort-SDR: Qc2tpbrlHqb7t8qDBgglS5L5D6eBFNOPn2YNEcODHVqycLInt15LVj6EMcAc2k1/yN2V1AMBir
 K8e5zE4sIbo7YCezA6ac2JapZi6T720tQ0dw0punLwjJTmqsb7x/P82ulm+5JMgywvMIUAB1Tu
 toIMZ8uQJngdn+Xo/Io8v0HvOiLkDiKHPe0BKpcOPo6OU8jr50tXoKKKw9YtGBWSm96n9KZeqJ
 M2SW5w0kUXq3q0iGXYGgDJtNqCOWPiEQwgvIDhNpzDjQmlXGAPNvRGtCToPzuhoZiMyr8E8uNq
 z7Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:49 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 4/8] btrfs: add boilerplate code to insert raid extent
Date:   Mon, 16 May 2022 07:31:39 -0700
Message-Id: <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
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

Add boilerplate code to insert raid extents into the raid-stripe-tree on
each write to a RAID1 block-group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/Makefile           |  2 +-
 fs/btrfs/raid-stripe-tree.c | 72 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h | 28 +++++++++++++++
 fs/btrfs/volumes.c          | 21 +++++++++++
 fs/btrfs/volumes.h          |  3 ++
 5 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 4188ba3fd8c3..6b9a00ad532a 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -30,7 +30,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o raid-stripe-tree.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
new file mode 100644
index 000000000000..426066bd7c0d
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "ctree.h"
+#include "transaction.h"
+#include "disk-io.h"
+#include "raid-stripe-tree.h"
+#include "volumes.h"
+
+static void btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
+				     struct btrfs_io_context *bioc)
+{
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_key stripe_key;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_dp_stripe *raid_stripe;
+	struct btrfs_stripe_extent *stripe_extent;
+	size_t item_size;
+	int ret;
+	int i;
+
+	item_size = sizeof(struct btrfs_dp_stripe) - sizeof(struct btrfs_stripe_extent) +
+		bioc->num_stripes * sizeof(struct btrfs_stripe_extent);
+
+	raid_stripe = kzalloc(item_size, GFP_NOFS);
+	if (!raid_stripe) {
+		btrfs_abort_transaction(trans, -ENOMEM);
+		return;
+	}
+
+	stripe_extent = &raid_stripe->extents;
+	for (i = 0; i  < bioc->num_stripes; i++) {
+		u64 devid = bioc->stripes[i].dev->devid;
+		u64 physical = bioc->stripes[i].physical;
+
+		btrfs_set_stack_stripe_extent_devid(stripe_extent, devid);
+		btrfs_set_stack_stripe_extent_offset(stripe_extent, physical);
+		stripe_extent++;
+	}
+
+	stripe_key.objectid = bioc->logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = bioc->length;
+
+	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, raid_stripe,
+				item_size);
+	if (ret) {
+		kfree(raid_stripe);
+		btrfs_abort_transaction(trans, ret);
+		return;
+	}
+
+	kfree(raid_stripe);
+}
+
+void btrfs_raid_stripe_tree_fn(struct work_struct *work)
+{
+	struct btrfs_io_context *bioc;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root;
+	struct btrfs_trans_handle *trans = NULL;
+
+	bioc = container_of(work, struct btrfs_io_context, stripe_update_work);
+	fs_info = bioc->fs_info;
+	root = fs_info->stripe_root;
+
+	trans = btrfs_join_transaction(root);
+
+	btrfs_insert_raid_extent(trans, bioc);
+	btrfs_end_transaction(trans);
+
+	btrfs_put_bioc(bioc);
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
new file mode 100644
index 000000000000..320a110ecc66
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_RAID_STRIPE_TREE_H
+#define BTRFS_RAID_STRIPE_TREE_H
+
+#include "volumes.h"
+
+void btrfs_raid_stripe_tree_fn(struct work_struct *work);
+
+static inline bool btrfs_need_stripe_tree_update(struct btrfs_io_context *bioc)
+{
+	u64 type = bioc->map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
+	u64 profile = bioc->map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+
+	if (!bioc->fs_info->stripe_root)
+		return false;
+
+	// for now
+	if (type != BTRFS_BLOCK_GROUP_DATA)
+		return false;
+
+	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
+		return true;
+
+	return false;
+}
+
+#endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd17e87815a..36acef2ae5d8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -33,6 +33,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "zoned.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -5917,6 +5918,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	bioc->fs_info = fs_info;
 	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
+	INIT_WORK(&bioc->stripe_update_work, btrfs_raid_stripe_tree_fn);
 
 	return bioc;
 }
@@ -6677,6 +6679,17 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		int i;
+
+		for (i = 0; i < bioc->num_stripes; i++) {
+			if (bioc->stripes[i].dev->bdev != bio->bi_bdev)
+				continue;
+			bioc->stripes[i].physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+		}
+	}
+
+
 	if (bio == bioc->orig_bio)
 		is_orig_bio = 1;
 
@@ -6700,6 +6713,12 @@ static void btrfs_end_bio(struct bio *bio)
 			 * go over the max number of errors
 			 */
 			bio->bi_status = BLK_STS_OK;
+
+			if (btrfs_op(bio) == BTRFS_MAP_WRITE &&
+			    btrfs_need_stripe_tree_update(bioc)) {
+				btrfs_get_bioc(bioc);
+				schedule_work(&bioc->stripe_update_work);
+			}
 		}
 
 		btrfs_end_bioc(bioc, bio);
@@ -6788,6 +6807,8 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	bioc->orig_bio = first_bio;
 	bioc->private = first_bio->bi_private;
 	bioc->end_io = first_bio->bi_end_io;
+	bioc->logical = logical;
+	bioc->length = length;
 	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 894d289a3b50..4b4235b4432a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -68,6 +68,9 @@ struct btrfs_io_context {
 	int mirror_num;
 	int num_tgtdevs;
 	int *tgtdev_map;
+	u64 logical;
+	u64 length;
+	struct work_struct stripe_update_work;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
-- 
2.35.1

