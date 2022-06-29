Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEB56035E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiF2Ol1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiF2Ol0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13739148
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513684; x=1688049684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQB17tOGq+Hu5Iab9EgPjnToHNtf6W5Fg2/gQJcppuw=;
  b=eXfCfMIe57r7mpK/L9DicYjHY0dWBvoVdJqF8hDIrIpLVNUvdOOahSF+
   /dUNIZ2hvAKirfLhqviJgDsQym6fx3/mk3YO0NZeQmuMea74aDQf0Zj3C
   HLRwkEHEl2U7Tz8Fy+/qj1gz9hHqticQwRnlUVu9jE8V95n6hjzxBvYK0
   XjWdo2fihVzlHPALxlqJh5KbI8iaCMkSiWxwgaqUEJ7SqakPH/i4LMyhK
   YlYVz+xYsTdHygDesyIR4f1aSofdKpFOhAslc8IWt3xpLhcOvaLg41TXZ
   5mere0Uv4cmkYUskG1wS101lPoLwel8phyrYQslU1JZmMJ3ACMRY2X1WD
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064888"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:24 +0800
IronPort-SDR: BlNJYpPMcLn3ePD7oNamKRD+zX3ZlIixleD/n9+detrvrcc2FDnOVWbWMoIqFGuXXI2ZZp2838
 yU3vSJao6Z1csQAd77eQvREk4Fivpu37keiIzaeIySCed3aTi3qCchgEVfs54cV/SJxzFvr14B
 Y3yMufzdSAvTThOBwiStLzkD8Q8Vuwip0KLIH0UoVqfw9DYG9Fe9YQi4XjRtdwdHvCnRukBQ1j
 EJ8qQrZL98MJElNgQ+eyTqGQuP0SfwrW+fg4o25eLV35zM7AjAUDjKGg+/apUVJKHsCef9ODA+
 naDI34d4VbDDf3lNexNFlJvk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:03 -0700
IronPort-SDR: vktyign7enex1f62mWBAcGJsTUMO5j5FXsRetjQpec+ORNKjGioTSC09X29C9lZDOk7DHRwy23
 NGsEOmW/OCQO2YZQrroojgiGiqalZPrxqRwQK66MDgy66IVp0/GAcdi4yHomUJSQHW2QAWgy10
 hU3NCkjRiSp93jS0/N9wfnxRxoX+Gyij5jc/ji8L8QVYMaLlBBLAAC8/+nHarRI6CYeaAW4BRV
 Wtg9/tC3oE+zAEz9VvdQVU6PmLdil4rhVybDvVmCsmbujJw1L5/TILnsUcERpVz/ETQMvqywcN
 I7k=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 3/8] btrfs: add boilerplate code to insert raid extent
Date:   Wed, 29 Jun 2022 07:41:09 -0700
Message-Id: <9ee306b29058d042b4eac3e04c58c383e89d3dc6.1656513330.git.johannes.thumshirn@wdc.com>
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

Add boilerplate code to insert raid extents into the raid-stripe-tree on
each write to a RAID1 block-group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          |   3 +
 fs/btrfs/extent-tree.c      |  45 +++++++++
 fs/btrfs/raid-stripe-tree.c | 188 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  65 +++++++++++++
 fs/btrfs/volumes.c          |  13 +++
 fs/btrfs/volumes.h          |   4 +
 fs/btrfs/zoned.c            |   4 +
 9 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea..4484831ac624 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o raid-stripe-tree.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 376b9b112429..2eb79afb4d83 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1092,6 +1092,9 @@ struct btrfs_fs_info {
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
 
+	struct mutex stripe_update_lock;
+	struct rb_root stripe_update_tree;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 45d1ea23a230..3d7c1b8d1cd5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3155,6 +3155,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
+
+	mutex_init(&fs_info->stripe_update_lock);
+	fs_info->stripe_update_tree = RB_ROOT;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f97a0f28f464..e1738b3dfb21 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -36,6 +36,7 @@
 #include "rcu-string.h"
 #include "zoned.h"
 #include "dev-replace.h"
+#include "raid-stripe-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1491,6 +1492,47 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int add_stripe_entry_for_delayed_ref(struct btrfs_trans_handle *trans,
+					    struct btrfs_delayed_ref_node *node)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct extent_map *em;
+	struct map_lookup *map;
+	int ret;
+
+	if (!fs_info->stripe_root)
+		return 0;
+
+	em = btrfs_get_chunk_map(fs_info, node->bytenr, node->num_bytes);
+	if (!em) {
+		btrfs_err(fs_info,
+			  "cannot get chunk map for address %llu",
+			  node->bytenr);
+		return -EINVAL;
+	}
+
+	map = em->map_lookup;
+
+	if (btrfs_need_stripe_tree_update(fs_info, map->type)) {
+		struct btrfs_ordered_stripe *stripe;
+
+		stripe = btrfs_lookup_ordered_stripe(fs_info, node->bytenr);
+		if (!stripe) {
+			btrfs_err(fs_info,
+				  "cannot get stripe extent for address %llu (%llu)",
+				  node->bytenr, node->num_bytes);
+			free_extent_map(em);
+			return -EINVAL;
+		}
+		ASSERT(stripe->logical == node->bytenr);
+		ret = btrfs_insert_raid_extent(trans, stripe);
+		btrfs_put_ordered_stripe(fs_info, stripe);
+	}
+	free_extent_map(em);
+
+	return ret;
+}
+
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
@@ -1521,6 +1563,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
 						 node->ref_mod);
+		if (ret)
+			return ret;
+		ret = add_stripe_entry_for_delayed_ref(trans, node);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->objectid, ref->offset,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
new file mode 100644
index 000000000000..360046a104c7
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/btrfs_tree.h>
+
+#include "ctree.h"
+#include "transaction.h"
+#include "disk-io.h"
+#include "raid-stripe-tree.h"
+#include "volumes.h"
+
+static struct rb_node *stripe_tree_insert(struct rb_root *root, u64 logical,
+					  struct rb_node *node)
+{
+	struct rb_node **p = &root->rb_node;
+	struct btrfs_ordered_stripe *stripe;
+	struct rb_node *parent = NULL;
+
+	while (*p) {
+		parent = *p;
+		stripe = rb_entry(*p, struct btrfs_ordered_stripe, rb_node);
+
+		if (logical < stripe->logical)
+			p = &(*p)->rb_left;
+		else if (logical >= stripe->logical + stripe->num_bytes)
+			p = &(*p)->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, root);
+	return NULL;
+}
+
+static struct btrfs_ordered_stripe *btrfs_add_ordered_stripe(
+					      struct btrfs_fs_info *fs_info,
+					      u64 logical,
+					      u64 length, int num_stripes,
+					      struct btrfs_io_stripe *stripes)
+{
+	struct btrfs_ordered_stripe *stripe;
+	struct btrfs_io_stripe *tmp;
+	struct rb_node *node;
+	size_t size;
+
+	size = num_stripes * sizeof(struct btrfs_io_stripe);
+	stripe = kzalloc(sizeof(struct btrfs_ordered_stripe), GFP_NOFS);
+	if (!stripe)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&stripe->lock);
+	tmp = kmemdup(stripes, size, GFP_NOFS);
+	if (!tmp) {
+		kfree(stripe);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	stripe->logical = logical;
+	stripe->num_bytes = length;
+	stripe->num_stripes = num_stripes;
+	spin_lock(&stripe->lock);
+	stripe->stripes = tmp;
+	spin_unlock(&stripe->lock);
+	refcount_set(&stripe->ref, 1);
+
+	mutex_lock(&fs_info->stripe_update_lock);
+	node = stripe_tree_insert(&fs_info->stripe_update_tree, logical,
+				  &stripe->rb_node);
+	mutex_unlock(&fs_info->stripe_update_lock);
+
+	if (node) {
+		btrfs_panic(fs_info, -EEXIST,
+			  "inconsistency in ordered stripes at offset %llu",
+			  logical);
+		kfree(stripe->stripes);
+		kfree(stripe);
+		return ERR_PTR(-EEXIST);
+	}
+
+	return stripe;
+}
+
+struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *fs_info,
+							 u64 logical)
+{
+	struct rb_root *root = &fs_info->stripe_update_tree;
+	struct btrfs_ordered_stripe *stripe;
+	struct rb_node *n = root->rb_node;
+
+	mutex_lock(&fs_info->stripe_update_lock);
+	while (n) {
+		stripe = rb_entry(n, struct btrfs_ordered_stripe, rb_node);
+
+		if (logical < stripe->logical) {
+			n = n->rb_left;
+			stripe = NULL;
+		} else if (logical >= stripe->logical + stripe->num_bytes) {
+			n = n->rb_right;
+			stripe = NULL;
+		} else {
+			break;
+		}
+	}
+	if (stripe)
+		btrfs_get_ordered_stripe(stripe);
+	mutex_unlock(&fs_info->stripe_update_lock);
+
+	return stripe;
+}
+
+void btrfs_remove_ordered_stripe(struct btrfs_fs_info *fs_info,
+				 struct btrfs_ordered_stripe *stripe)
+{
+	struct rb_node *node = &stripe->rb_node;
+
+	mutex_lock(&fs_info->stripe_update_lock);
+	rb_erase(node, &fs_info->stripe_update_tree);
+	RB_CLEAR_NODE(node);
+	mutex_unlock(&fs_info->stripe_update_lock);
+
+	spin_lock(&stripe->lock);
+	kfree(stripe->stripes);
+	spin_unlock(&stripe->lock);
+	kfree(stripe);
+}
+
+int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_ordered_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key stripe_key;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_dp_stripe *raid_stripe;
+	size_t item_size;
+	int ret;
+
+	item_size = stripe->num_stripes * sizeof(struct btrfs_stripe_extent);
+
+	raid_stripe = kzalloc(item_size, GFP_NOFS);
+	if (!raid_stripe) {
+		btrfs_abort_transaction(trans, -ENOMEM);
+		btrfs_end_transaction(trans);
+		return -ENOMEM;
+	}
+
+	spin_lock(&stripe->lock);
+	for (int i = 0; i < stripe->num_stripes; i++) {
+		u64 devid = stripe->stripes[i].dev->devid;
+		u64 physical = stripe->stripes[i].physical;
+		struct btrfs_stripe_extent *stripe_extent =
+						&raid_stripe->extents[i];
+
+		btrfs_set_stack_stripe_extent_devid(stripe_extent, devid);
+		btrfs_set_stack_stripe_extent_physical(stripe_extent, physical);
+	}
+	spin_unlock(&stripe->lock);
+
+	stripe_key.objectid = stripe->logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = stripe->num_bytes;
+
+	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, raid_stripe,
+				item_size);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	kfree(raid_stripe);
+
+	return ret;
+}
+
+void btrfs_raid_stripe_update(struct work_struct *work)
+{
+	struct btrfs_io_context *bioc =
+		container_of(work, struct btrfs_io_context, stripe_update_work);
+	struct btrfs_ordered_stripe *stripe;
+	struct bio *bio = bioc->orig_bio;
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
+
+	stripe = btrfs_add_ordered_stripe(fs_info, bioc->logical, bioc->length,
+					  bioc->num_stripes, bioc->stripes);
+	if (IS_ERR(stripe)) {
+		btrfs_bio_counter_dec(fs_info);
+		bio->bi_status = errno_to_blk_status(PTR_ERR(stripe));
+	}
+	btrfs_put_bioc(bioc);
+}
+
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
new file mode 100644
index 000000000000..b9c40ef26dfa
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_RAID_STRIPE_TREE_H
+#define BTRFS_RAID_STRIPE_TREE_H
+
+#include "volumes.h"
+
+struct btrfs_ordered_stripe {
+	struct rb_node rb_node;
+
+	u64 logical;
+	u64 num_bytes;
+	int num_stripes;
+	struct btrfs_io_stripe *stripes;
+	spinlock_t lock;
+	refcount_t ref;
+};
+
+int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_ordered_stripe *stripe);
+void btrfs_raid_stripe_update(struct work_struct *work);
+struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
+						 struct btrfs_fs_info *fs_info,
+						 u64 logical);
+void btrfs_remove_ordered_stripe(struct btrfs_fs_info *fs_info,
+				 struct btrfs_ordered_stripe *stripe);
+
+static inline void btrfs_get_ordered_stripe(struct btrfs_ordered_stripe *stripe)
+{
+	refcount_inc(&stripe->ref);
+}
+
+static inline void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
+					    struct btrfs_ordered_stripe *stripe)
+{
+	if (refcount_dec_and_test(&stripe->ref))
+		btrfs_remove_ordered_stripe(fs_info, stripe);
+}
+
+static inline int btrfs_num_raid_stripes(u32 item_size)
+{
+	return item_size - offsetof(struct btrfs_dp_stripe, extents) /
+		sizeof(struct btrfs_stripe_extent);
+}
+
+static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
+						 u64 map_type)
+{
+	u64 type = map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
+	u64 profile = map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+
+	if (!fs_info->stripe_root)
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
index 2d788a351c1f..b8d4e92c7196 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -33,6 +33,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "zoned.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -5897,6 +5898,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	bioc->fs_info = fs_info;
 	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
+	INIT_WORK(&bioc->stripe_update_work, btrfs_raid_stripe_update);
 
 	return bioc;
 }
@@ -6623,6 +6625,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 {
 	struct bio *orig_bio = bioc->orig_bio;
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
 
 	bbio->mirror_num = bioc->mirror_num;
@@ -6642,6 +6645,12 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
 	} else {
+		if (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
+		    btrfs_need_stripe_tree_update(fs_info,
+						  bioc->map_type)) {
+			btrfs_get_bioc(bioc);
+			schedule_work(&bioc->stripe_update_work);
+		}
 		bio_endio(orig_bio);
 	}
 
@@ -6667,6 +6676,8 @@ static void btrfs_end_bio(struct bio *bio)
 				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_FLUSH_ERRS);
 		}
+	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	}
 
 	if (bio != bioc->orig_bio)
@@ -6754,6 +6765,8 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	bioc->orig_bio = bio;
 	bioc->private = bio->bi_private;
 	bioc->end_io = bio->bi_end_io;
+	bioc->logical = logical;
+	bioc->length = length;
 	atomic_set(&bioc->stripes_pending, total_devs);
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9537d82bb7a2..f22ea9c23faa 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -14,6 +14,7 @@
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
 extern struct mutex uuid_mutex;
+struct btrfs_ordered_stripe;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
@@ -463,6 +464,9 @@ struct btrfs_io_context {
 	int mirror_num;
 	int num_tgtdevs;
 	int *tgtdev_map;
+	u64 logical;
+	u64 length;
+	struct work_struct stripe_update_work;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7a0f8fa44800..5cf6abeda588 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1641,6 +1641,10 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	u64 *logical = NULL;
 	int nr, stripe_len;
 
+	/* Filesystems with a stripe tree have their own l2p mapping */
+	if (fs_info->stripe_root)
+		return;
+
 	/* Zoned devices should not have partitions. So, we can assume it is 0 */
 	ASSERT(!bdev_is_partition(ordered->bdev));
 	if (WARN_ON(!ordered->bdev))
-- 
2.35.3

