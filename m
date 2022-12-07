Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE3C645C65
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLGOXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiLGOWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76D5D686
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422950; x=1701958950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKVdZ2RyXgcoUWWuRRGtBvvp2m2OvT9Bc/6mYnPmF/E=;
  b=ka/Jn6wi8zq1+NeBXW2eA9dFIwOBElm2ap5gleDrAgdLR7G1QQs/Xakv
   cTsOfPlfATu6NHC6YFulYPimUWc1wxmDxl5PAcKaCSASF3pY3aSqBh0GA
   lYgvI8Ok1ggm0EH6OgPsNrOy+LNpYQyXfrl6wueSLBEa5j5xHKQKwioft
   /b+Fg2eOq5mEkAazixJPjRfFkTXUVEZoHyjqAgeNdJERtROlLyAxkjSf6
   IfeG2kbblGSWHZ2jdZ0VF7ZaFw4Gp8N7tfZxWpUJMd2hFlVvPXeiSrRhR
   raJ3GWXkTDrhdY7/mdddCmYS5kcb5Mo8cIcsLrAz7I7EWgcgBErDEpR3F
   w==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099480"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:29 +0800
IronPort-SDR: Z6wI2kJwX2ggvpZlMQ6SBJhNkaUdrzaZ4gYGNBzTdshLG1JvHPN+cvzXMnntXVMgWCP3qcYhIw
 /5lAu+TOJozFKfzpLKzQgiNJ8bukCl9m8rk1JCKAXqAJLEY94w9kV+sYSpo3bG+r34klZVFmXa
 O1TjaqdAfGPSDy4ddCgh8jawjl/J/OxH1oTe7VK+cIeMpEvYnkJrPGrrhHa9vCjPBdsigGPIJP
 u7Zx5i4N0+yn/roGJGowXCufOAcpFwIi6kpzSnnggTX3t/ImhDkNs4M38YmgdJmpIAchZM8vvC
 yXA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:16 -0800
IronPort-SDR: nCKIasmNvQt3RhQ9PCEJM/cDqHEigbQyuvXr7g0l/KtWFbt+LFMfAOn+CKpc5Z0ACZ1H/svv+y
 d3LYtug2RtktQoy6JWMpQ7yaTzrJA79scr6SnX6SPpCBUDDzYRDlZHRUYxnd80GutuLA1YSQfj
 LaVry2/s0u6GtbkBAUVb6weSfu6/aLRtE0T1Vi6gNWwkQfnWJKQ4bCB4xZgFChciTz1KOIen/W
 BsCiueRLI5IATddR1XzfMPQh+Fu2CdGIY14c+xY9ufHIAKqgZ3Tqv66w3wJs46v7OqYXRi7Czv
 wII=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:29 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 3/9] btrfs: add support for inserting raid stripe extents
Date:   Wed,  7 Dec 2022 06:22:12 -0800
Message-Id: <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670422590.git.johannes.thumshirn@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/Makefile           |   3 +-
 fs/btrfs/bio.c              |  30 +++++-
 fs/btrfs/bio.h              |   2 +
 fs/btrfs/delayed-ref.c      |   5 +-
 fs/btrfs/disk-io.c          |   3 +
 fs/btrfs/extent-tree.c      |  49 +++++++++
 fs/btrfs/fs.h               |   3 +
 fs/btrfs/inode.c            |   6 ++
 fs/btrfs/raid-stripe-tree.c | 195 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  69 +++++++++++++
 fs/btrfs/volumes.c          |   5 +-
 fs/btrfs/volumes.h          |  12 +--
 fs/btrfs/zoned.c            |   4 +
 13 files changed, 376 insertions(+), 10 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 555c962fdad6..63236ae2a87b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o
+	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
+	   raid-stripe-tree.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4ccbc120e869..b60a50165703 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -15,6 +15,7 @@
 #include "rcu-string.h"
 #include "zoned.h"
 #include "file-item.h"
+#include "raid-stripe-tree.h"
 
 static struct bio_set btrfs_bioset;
 static struct bio_set btrfs_clone_bioset;
@@ -350,6 +351,21 @@ static void btrfs_raid56_end_io(struct bio *bio)
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
@@ -372,6 +388,15 @@ static void btrfs_orig_write_end_io(struct bio *bio)
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
@@ -383,7 +408,9 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	if (bio->bi_status) {
 		atomic_inc(&stripe->bioc->error);
 		btrfs_log_dev_io_error(bio, stripe->dev);
-	}
+	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+ 	}
 
 	/* Pass on control to the original bio this one was cloned from */
 	bio_endio(stripe->bioc->orig_bio);
@@ -442,6 +469,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 	bio->bi_private = &bioc->stripes[dev_nr];
 	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
 	bioc->stripes[dev_nr].bioc = bioc;
+	bioc->size = bio->bi_iter.bi_size;
 	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
 }
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 20105806c8ac..bf5fbc105148 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -58,6 +58,8 @@ struct btrfs_bio {
 	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
+	struct work_struct raid_stripe_work;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 573ebab886e2..0357f9327cd4 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -14,6 +14,7 @@
 #include "space-info.h"
 #include "tree-mod-log.h"
 #include "fs.h"
+#include "raid-stripe-tree.h"
 
 struct kmem_cache *btrfs_delayed_ref_head_cachep;
 struct kmem_cache *btrfs_delayed_tree_ref_cachep;
@@ -640,8 +641,10 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
 	exist->ref_mod += mod;
 
 	/* remove existing tail if its ref_mod is zero */
-	if (exist->ref_mod == 0)
+	if (exist->ref_mod == 0) {
+		btrfs_drop_ordered_stripe(trans->fs_info, exist->bytenr);
 		drop_delayed_ref(trans, root, href, exist);
+	}
 	spin_unlock(&href->lock);
 	return ret;
 inserted:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5784c850a3ec..bdef4e2e4ea3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3033,6 +3033,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
+
+	rwlock_init(&fs_info->stripe_update_lock);
+	fs_info->stripe_update_tree = RB_ROOT;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 892d78c1853c..de479af062fd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -43,6 +43,7 @@
 #include "file-item.h"
 #include "orphan.h"
 #include "tree-checker.h"
+#include "raid-stripe-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1498,6 +1499,51 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
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
+	if (!btrfs_stripe_tree_root(fs_info))
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
+		ASSERT(stripe->num_bytes == node->num_bytes);
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
@@ -1528,6 +1574,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
 						 node->ref_mod);
+		if (ret)
+			return ret;
+		ret = add_stripe_entry_for_delayed_ref(trans, node);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->objectid, ref->offset,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f08b59320645..0dfe8ae2e450 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -780,6 +780,9 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
 
+	rwlock_t stripe_update_lock;
+	struct rb_root stripe_update_tree;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 373b7281f5c7..1299acf52c86 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -70,6 +70,7 @@
 #include "verity.h"
 #include "super.h"
 #include "orphan.h"
+#include "raid-stripe-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -9507,6 +9508,11 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
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
index 000000000000..aa60f784fb1f
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/btrfs_tree.h>
+
+#include "ctree.h"
+#include "fs.h"
+#include "accessors.h"
+#include "transaction.h"
+#include "disk-io.h"
+#include "raid-stripe-tree.h"
+#include "volumes.h"
+#include "misc.h"
+#include "disk-io.h"
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
+	write_lock(&fs_info->stripe_update_lock);
+	node = rb_find_add(&stripe->rb_node, &fs_info->stripe_update_tree,
+	       ordered_stripe_less);
+	write_unlock(&fs_info->stripe_update_lock);
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
+	read_lock(&fs_info->stripe_update_lock);
+	node = rb_find(&logical, root, ordered_stripe_cmp);
+	if (node) {
+		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
+		refcount_inc(&stripe->ref);
+	}
+	read_unlock(&fs_info->stripe_update_lock);
+
+	return stripe;
+}
+
+void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
+				 struct btrfs_ordered_stripe *stripe)
+{
+	write_lock(&fs_info->stripe_update_lock);
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
+	write_unlock(&fs_info->stripe_update_lock);
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
+	if (!btrfs_stripe_tree_root(fs_info))
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
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	struct btrfs_stripe_extent *stripe_extent;
+	size_t item_size;
+	int ret;
+
+	item_size = stripe->num_stripes * sizeof(struct btrfs_raid_stride);
+
+	stripe_extent = kzalloc(item_size, GFP_NOFS);
+	if (!stripe_extent) {
+		btrfs_abort_transaction(trans, -ENOMEM);
+		btrfs_end_transaction(trans);
+		return -ENOMEM;
+	}
+
+	spin_lock(&stripe->lock);
+	for (int i = 0; i < stripe->num_stripes; i++) {
+		u64 devid = stripe->stripes[i].dev->devid;
+		u64 physical = stripe->stripes[i].physical;
+		struct btrfs_raid_stride *raid_stride =
+						&stripe_extent->strides[i];
+
+		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
+		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
+	}
+	spin_unlock(&stripe->lock);
+
+	stripe_key.objectid = stripe->logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = stripe->num_bytes;
+
+	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
+				item_size);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	kfree(stripe_extent);
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
new file mode 100644
index 000000000000..807d9123270c
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef BTRFS_RAID_STRIPE_TREE_H
+#define BTRFS_RAID_STRIPE_TREE_H
+
+#include "disk-io.h"
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
+	if (!btrfs_stripe_tree_root(fs_info))
+		return false;
+
+	if (type != BTRFS_BLOCK_GROUP_DATA)
+		return false;
+
+	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
+		return true;
+
+	return false;
+}
+
+static inline void btrfs_drop_ordered_stripe(struct btrfs_fs_info *fs_info,
+					     u64 logical)
+{
+	struct btrfs_ordered_stripe *stripe;
+
+	if (!btrfs_stripe_tree_root(fs_info))
+		return;
+
+	stripe = btrfs_lookup_ordered_stripe(fs_info, logical);
+	if (!stripe)
+		return;
+	/* once for us */
+	btrfs_put_ordered_stripe(fs_info, stripe);
+	/* once for the tree */
+	btrfs_put_ordered_stripe(fs_info, stripe);
+}
+#endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f936e80a9b15..78b721251a09 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5872,6 +5872,7 @@ static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
 }
 
 static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
+						       u64 logical,
 						       int total_stripes,
 						       int real_stripes)
 {
@@ -5895,6 +5896,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
+	bioc->logical = logical;
 	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
 
@@ -6500,7 +6502,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 
-	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
+	bioc = alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes,
+				      tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7e51f2238f72..5d7547b5fa87 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -368,12 +368,10 @@ struct btrfs_fs_devices {
 
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
@@ -409,6 +407,8 @@ struct btrfs_io_context {
 	int mirror_num;
 	int num_tgtdevs;
 	int *tgtdev_map;
+	u64 logical;
+	u64 size;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0b769dc8bcda..e5a083a9fd0f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1682,6 +1682,10 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	u64 *logical = NULL;
 	int nr, stripe_len;
 
+	/* Filesystems with a stripe tree have their own l2p mapping */
+	if (btrfs_stripe_tree_root(fs_info))
+		return;
+
 	/* Zoned devices should not have partitions. So, we can assume it is 0 */
 	ASSERT(!bdev_is_partition(ordered->bdev));
 	if (WARN_ON(!ordered->bdev))
-- 
2.38.1

