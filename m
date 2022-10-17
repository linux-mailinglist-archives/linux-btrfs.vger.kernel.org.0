Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD38600E45
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJQLzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJQLzl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0B57E0F
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007739; x=1697543739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rV9FAufAXgsESK/Ahap77qr/WaEZ3622VgRZQkGTzp4=;
  b=lPrJOG9g7va33qWsPGkDNH6Yx8/sDDgR4yy3iVvzwwLnrBjkbuRIGIMZ
   LZJRZ57fKrjrYBX9lEO26odGM9ngsdXkWi044ltFWpqOaKxq/dduVPooD
   /jSytfUIV+rMHGHIczBjUewpzxnKeOAuDCgeIgwpavU8nFm2Ry6D40PqH
   9HroHVmWU1oOwswXbodBFPbsZUZCIpQL3TlKn/7+4YvUhA3oxV5aVH6KW
   W9ybNmS/BtNO8ztTpwTGFTNBowUbezSGjVgxpmVfeh+CB/YymJkAf3C92
   JlNKwwx1RN3cpxbE4T8NYMw9Uss0nSfttzXGTYgVB6EH9Ztww7LQLc46p
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337157"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:36 +0800
IronPort-SDR: XEE2EyZJfzf0bWDH1eALkf4h+Sf15+zTdlUNlSr89gkB2G26APb0E9+wtXTKE1pHY/TPZV+vdp
 /YhOHLFBJ7F9/I75r3W3Dt+SwNjA2Tlv7sFVIr/GvrMx60s6e8HpzIQV5LMgZzyOFi3YrIrYvr
 yC4ZghQe0bcx1Wfr37pwW1OH4wUrN905QQv9TmzLZVjjpvvaD90/fOpQ8mB+L3NfI6hMXUVO81
 2aqbbOyWAXeE9kfQR3K+TjLdLRw4NwwmmC0h5G6x54BGFVHI9oEXXj6MFUOH/+Z1c74kcYz/Q0
 6XnIj7IE5O9GuriT0oiko1sU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:10 -0700
IronPort-SDR: PiND+OpDBZsP4Og/sF25K1r7aqs8arKRUtlHoA3CoIzKknVEM09WRDHNE6UsznHSNCy1/lVULF
 IX/IN1JnjHgXUyaZY9hM+nkOsNEHflH+JRkBTFlm+4OOKNtX53q/fu57CIPWrAk3DPiDos9fVB
 4Nu1x1ZlhB11X478vgvox8mtmMH1xAVvxKuBguBzyfpU/PzjSMVc+DPlZhgsbLge2VvORdr/B4
 Ne8X+xVOYJKYN6ecpdsuvFaldjKjlE9V0OTCTkNihpxk0lYXVt+2mD8e4C3osIthUqWGfAGmd+
 1j4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:37 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 03/11] btrfs: add support for inserting raid stripe extents
Date:   Mon, 17 Oct 2022 04:55:21 -0700
Message-Id: <5c8b4c3005d7c02ca4ab76a1802f14137ae47bda.1666007330.git.johannes.thumshirn@wdc.com>
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

Add support for inserting stripe extents into the raid stripe tree on
completion of every write that needs an extra logical-to-physical
translation when using RAID.

Inserting the stripe extents happens after the data I/O has completed,
this is done to a) support zone-append and b) rule out the possibility of
a RAID-write-hole.

This is done by creating in-memory ordered stripe extents, just like the
in memory ordered extents, on I/O completion and the on-disk raid stripe
extents get created once we're running the delayed_refs for the extent
item this stripe extent is tied to.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          |   3 +
 fs/btrfs/extent-tree.c      |  48 +++++++++
 fs/btrfs/inode.c            |   6 ++
 fs/btrfs/raid-stripe-tree.c | 189 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  49 ++++++++++
 fs/btrfs/volumes.c          |  35 ++++++-
 fs/btrfs/volumes.h          |  14 +--
 fs/btrfs/zoned.c            |   4 +
 10 files changed, 345 insertions(+), 8 deletions(-)
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
index 430f224743a9..1f75ab8702bb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1102,6 +1102,9 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
 
+	struct mutex stripe_update_lock;
+	struct rb_root stripe_update_tree;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a166b2602c40..190caabf5fb7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2973,6 +2973,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
+
+	mutex_init(&fs_info->stripe_update_lock);
+	fs_info->stripe_update_tree = RB_ROOT;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bcd0e72cded3..061296bcdfb4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -36,6 +36,7 @@
 #include "rcu-string.h"
 #include "zoned.h"
 #include "dev-replace.h"
+#include "raid-stripe-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1491,6 +1492,50 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
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
+		/* once for us */
+		btrfs_put_ordered_stripe(fs_info, stripe);
+		/* once for the tree */
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
@@ -1521,6 +1566,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
 						 node->ref_mod);
+		if (ret)
+			return ret;
+		ret = add_stripe_entry_for_delayed_ref(trans, node);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->objectid, ref->offset,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5f2d9d4f6d43..5414ba573022 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "raid-stripe-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -9550,6 +9551,11 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	if (qgroup_released < 0)
 		return ERR_PTR(qgroup_released);
 
+	ret = btrfs_insert_preallocated_raid_stripe(inode->root->fs_info,
+						    start, len);
+	if (ret)
+		goto free_qgroup;
+
 	if (trans) {
 		ret = insert_reserved_file_extent(trans, inode,
 						  file_offset, &stack_fi,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
new file mode 100644
index 000000000000..d8a69060b54b
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/btrfs_tree.h>
+
+#include "ctree.h"
+#include "transaction.h"
+#include "disk-io.h"
+#include "raid-stripe-tree.h"
+#include "volumes.h"
+#include "misc.h"
+#include "print-tree.h"
+
+static int ordered_stripe_cmp(const void *key, const struct rb_node *node)
+{
+	struct btrfs_ordered_stripe *stripe =
+		rb_entry(node, struct btrfs_ordered_stripe, rb_node);
+	const u64 *logical = key;
+
+	if (*logical < stripe->logical)
+		return -1;
+	if (*logical >= stripe->logical + stripe->num_bytes)
+		return 1;
+	return 0;
+}
+
+static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
+{
+	struct btrfs_ordered_stripe *stripe =
+		rb_entry(rba, struct btrfs_ordered_stripe, rb_node);
+	return ordered_stripe_cmp(&stripe->logical, rbb);
+}
+
+int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
+{
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_ordered_stripe *stripe;
+	struct btrfs_io_stripe *tmp;
+	u64 logical = bioc->logical;
+	u64 length = bioc->size;
+	struct rb_node *node;
+	size_t size;
+
+	size = bioc->num_stripes * sizeof(struct btrfs_io_stripe);
+	stripe = kzalloc(sizeof(struct btrfs_ordered_stripe), GFP_NOFS);
+	if (!stripe)
+		return -ENOMEM;
+
+	spin_lock_init(&stripe->lock);
+	tmp = kmemdup(bioc->stripes, size, GFP_NOFS);
+	if (!tmp) {
+		kfree(stripe);
+		return -ENOMEM;
+	}
+
+	stripe->logical = logical;
+	stripe->num_bytes = length;
+	stripe->num_stripes = bioc->num_stripes;
+	spin_lock(&stripe->lock);
+	stripe->stripes = tmp;
+	spin_unlock(&stripe->lock);
+	refcount_set(&stripe->ref, 1);
+
+	mutex_lock(&fs_info->stripe_update_lock);
+	node = rb_find_add(&stripe->rb_node, &fs_info->stripe_update_tree,
+	       ordered_stripe_less);
+	mutex_unlock(&fs_info->stripe_update_lock);
+	if (node) {
+		btrfs_err(fs_info, "logical: %llu, length: %llu already exists",
+			  logical, length);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *fs_info,
+							 u64 logical)
+{
+	struct rb_root *root = &fs_info->stripe_update_tree;
+	struct btrfs_ordered_stripe *stripe = NULL;
+	struct rb_node *node;
+
+	mutex_lock(&fs_info->stripe_update_lock);
+	node = rb_find(&logical, root, ordered_stripe_cmp);
+	if (node) {
+		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
+		refcount_inc(&stripe->ref);
+	}
+	mutex_unlock(&fs_info->stripe_update_lock);
+
+	return stripe;
+}
+
+void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
+				 struct btrfs_ordered_stripe *stripe)
+{
+	mutex_lock(&fs_info->stripe_update_lock);
+	if (refcount_dec_and_test(&stripe->ref)) {
+		struct rb_node *node = &stripe->rb_node;
+
+		rb_erase(node, &fs_info->stripe_update_tree);
+		RB_CLEAR_NODE(node);
+
+		spin_lock(&stripe->lock);
+		kfree(stripe->stripes);
+		spin_unlock(&stripe->lock);
+		kfree(stripe);
+	}
+	mutex_unlock(&fs_info->stripe_update_lock);
+}
+
+int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
+					  u64 start, u64 len)
+{
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_ordered_stripe *stripe;
+	u64 map_length = len;
+	int ret;
+
+	if (!fs_info->stripe_root)
+		return 0;
+
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, start, &map_length,
+			      &bioc, 0);
+	if (ret)
+		return ret;
+
+	bioc->size = len;
+
+	stripe = btrfs_lookup_ordered_stripe(fs_info, start);
+	if (!stripe) {
+		ret = btrfs_add_ordered_stripe(bioc);
+		if (ret)
+			return ret;
+	} else {
+		spin_lock(&stripe->lock);
+		memcpy(stripe->stripes, bioc->stripes,
+		       bioc->num_stripes * sizeof(struct btrfs_io_stripe));
+		spin_unlock(&stripe->lock);
+		btrfs_put_ordered_stripe(fs_info, stripe);
+	}
+
+	return 0;
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
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
new file mode 100644
index 000000000000..fdcaad405742
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_RAID_STRIPE_TREE_H
+#define BTRFS_RAID_STRIPE_TREE_H
+
+struct btrfs_io_context;
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
+int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
+					  u64 start, u64 len);
+struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
+						 struct btrfs_fs_info *fs_info,
+						 u64 logical);
+int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc);
+void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
+					    struct btrfs_ordered_stripe *stripe);
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
index f5be296b863e..261bf6dd17bc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -33,6 +33,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "zoned.h"
+#include "raid-stripe-tree.h"
 
 static struct bio_set btrfs_bioset;
 static struct bio_set btrfs_clone_bioset;
@@ -45,6 +46,8 @@ struct btrfs_failed_bio {
 	atomic_t repair_count;
 };
 
+static void btrfs_raid_stripe_update(struct work_struct *work);
+
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -5887,6 +5890,7 @@ static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
 }
 
 static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
+						       u64 logical,
 						       int total_stripes,
 						       int real_stripes)
 {
@@ -5907,6 +5911,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
+	bioc->logical = logical;
 	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
 
@@ -6512,7 +6517,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
+	bioc = alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes,
+				      tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
@@ -6921,6 +6927,21 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	btrfs_put_bioc(bioc);
 }
 
+static void btrfs_raid_stripe_update(struct work_struct *work)
+{
+	struct btrfs_bio *bbio =
+		container_of(work, struct btrfs_bio, raid_stripe_work);
+	struct btrfs_io_stripe *stripe = bbio->bio.bi_private;
+	struct btrfs_io_context *bioc = stripe->bioc;
+	int ret;
+
+	ret = btrfs_add_ordered_stripe(bioc);
+	if (ret)
+		bbio->bio.bi_status = errno_to_blk_status(ret);
+	btrfs_orig_bbio_end_io(bbio);
+	btrfs_put_bioc(bioc);
+}
+
 static void btrfs_orig_write_end_io(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
@@ -6943,6 +6964,15 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
+	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
+		INIT_WORK(&bbio->raid_stripe_work, btrfs_raid_stripe_update);
+		schedule_work(&bbio->raid_stripe_work);
+		return;
+	}
+
 	btrfs_orig_bbio_end_io(bbio);
 	btrfs_put_bioc(bioc);
 }
@@ -6954,6 +6984,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	if (bio->bi_status) {
 		atomic_inc(&stripe->bioc->error);
 		btrfs_log_dev_io_error(bio, stripe->dev);
+	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	}
 
 	/* Pass on control to the original bio this one was cloned from */
@@ -7013,6 +7045,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 	bio->bi_private = &bioc->stripes[dev_nr];
 	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
 	bioc->stripes[dev_nr].bioc = bioc;
+	bioc->size = bio->bi_iter.bi_size;
 	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b1fe04ff078..1b4a6e46eec3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -374,6 +374,8 @@ struct btrfs_bio {
 	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
+	struct work_struct raid_stripe_work;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
@@ -403,12 +405,10 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
-	union {
-		/* Block mapping */
-		u64 physical;
-		/* For the endio handler */
-		struct btrfs_io_context *bioc;
-	};
+	/* Block mapping */
+	u64 physical;
+	/* For the endio handler */
+	struct btrfs_io_context *bioc;
 };
 
 struct btrfs_discard_stripe {
@@ -444,6 +444,8 @@ struct btrfs_io_context {
 	int mirror_num;
 	int num_tgtdevs;
 	int *tgtdev_map;
+	u64 logical;
+	u64 size;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5d28479b7da4..286b99f04ae2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1659,6 +1659,10 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
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
2.37.3

