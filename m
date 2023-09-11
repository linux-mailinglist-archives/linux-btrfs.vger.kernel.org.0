Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6D79BB31
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356023AbjIKWCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbjIKMwe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A1CEB;
        Mon, 11 Sep 2023 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436750; x=1725972750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nUgxgGRyHtLD7v2F+tQEZvxKac7ZdTy4WQRaUi31oTI=;
  b=YR2IqBssApWi4WMF/rhEUuFEhuTVMcdadaNMkaI+iA28MMkxinJBl679
   k7t0y/nd4hT5lHJUsL6JId4V3iACwa/E9oLpTk8sd+O9RhSoQCZv7aAUv
   MH1RO8+Cu905PCo3kcMvb0PvkA2cOLUD91/A3YbMjk/354azB4j3Lc647
   1cn0hxN2p5OAPz3p9gLV9At+nxlVLVvF7vy8EYrmBvoJJu0p3BPtFziV6
   IDKXreYJ+PMAf2FFOV+YzPqUYoUMPKe5ONXjMaptdiQIrjUygx1hePfdR
   nytTQCHUu6yfBuK3eL804bGbAQfc02IoemyAOlkUi1jRpRrQ7AYxi060b
   A==;
X-CSE-ConnectionGUID: Fy4YrIOSRYueOsUWA5Z3Kg==
X-CSE-MsgGUID: VrJ4IHhhQUCTsVySNHIFJw==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594383"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:30 +0800
IronPort-SDR: 3VItKIvdd7j/7SLCiwjI2uFweAlkRUGJ3vypPzrMs/2uBw6tlHi6OrgBxRQhngLhIdjJGOFWJ0
 waxCkn7icMgEk6W3h2Qy+jqDfWcRhmul9uNLNbhRWnV0rTG1Cbfl1qmDFMKax70YZ3rpdT3xNA
 WT0J4MeN53ZTpZ5YvJfa+8Yso1Em9Ucxl9ILNM7UXFhoKDq9zbtPAKKWWElUlqXLvXOvl0U3SS
 neIdafb9cLj1nblmMNXQ3BOhwm4o4/ZYds0gBTNNT8xXgw0e+Y3PusyPA3mIPAKGXJsf3Q4ztO
 v28=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 04:59:35 -0700
IronPort-SDR: Hlreot0zQ3cyxTdeIICQie1O3w2zak1sobGHL0x/1HLSifI7dbkVJxyuhXFgd7x7sKcwefsk+D
 qtIv8oqde/WkBJeC1xnX1SE8yxMDctQrahRkTz03UgjvziLZagOKqNoA+Ds3cjcAEZIhip+N4X
 kc7knOdegY00wir1t8D1r2th/bVgBfAi0loSm9oCErWWX8NS+bFSw0Y2Wm1qeZnQRbwaFMkYX0
 WzZLz9+gHHr6+ZhiPJxAHQ9e/ptGbi4qeU5RZb59g0kjIXDbkTCkf0XAgsdvbfGbl68VWDCwP6
 0Q8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/11] btrfs: add support for inserting raid stripe extents
Date:   Mon, 11 Sep 2023 05:52:04 -0700
Message-ID: <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=16978; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=nUgxgGRyHtLD7v2F+tQEZvxKac7ZdTy4WQRaUi31oTI=; b=5etT14Y4azYf+0+JcMH4epr3hgjMJCWWUgP6pTTKKMWD/K7ZVY9DZYSF79w4f1XOj5xGEB+OI UfCO+/nLH/LBfo93Qp8VQuyTQprZC/ulNNXQsZMZ1oylbdDNZPenbBH
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/bio.c              |  23 ++++
 fs/btrfs/extent-tree.c      |   1 +
 fs/btrfs/inode.c            |   8 +-
 fs/btrfs/ordered-data.c     |   1 +
 fs/btrfs/ordered-data.h     |   2 +
 fs/btrfs/raid-stripe-tree.c | 266 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  34 ++++++
 fs/btrfs/volumes.c          |   4 +-
 fs/btrfs/volumes.h          |  15 ++-
 10 files changed, 347 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index c57d80729d4f..525af975f61c 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
 	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
-	   lru_cache.o
+	   lru_cache.o raid-stripe-tree.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 31ff36990404..ddbe6f8d4ea2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -14,6 +14,7 @@
 #include "rcu-string.h"
 #include "zoned.h"
 #include "file-item.h"
+#include "raid-stripe-tree.h"
 
 static struct bio_set btrfs_bioset;
 static struct bio_set btrfs_clone_bioset;
@@ -415,6 +416,9 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
 	btrfs_orig_bbio_end_io(bbio);
 	btrfs_put_bioc(bioc);
 }
@@ -426,6 +430,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	if (bio->bi_status) {
 		atomic_inc(&stripe->bioc->error);
 		btrfs_log_dev_io_error(bio, stripe->dev);
+	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	}
 
 	/* Pass on control to the original bio this one was cloned from */
@@ -487,6 +493,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 	bio->bi_private = &bioc->stripes[dev_nr];
 	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
 	bioc->stripes[dev_nr].bioc = bioc;
+	bioc->size = bio->bi_iter.bi_size;
 	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
 }
 
@@ -496,6 +503,8 @@ static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
+		if (bio_op(bio) != REQ_OP_READ)
+			btrfs_bio(bio)->orig_physical = smap->physical;
 		bio->bi_iter.bi_sector = smap->physical >> SECTOR_SHIFT;
 		if (bio_op(bio) != REQ_OP_READ)
 			btrfs_bio(bio)->orig_physical = smap->physical;
@@ -688,6 +697,20 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
 		}
 
+		if (is_data_bbio(bbio) && bioc &&
+		    btrfs_need_stripe_tree_update(bioc->fs_info,
+						  bioc->map_type)) {
+			/*
+			 * No locking for the list update, as we only add to
+			 * the list in the I/O submission path, and list
+			 * iteration only happens in the completion path,
+			 * which can't happen until after the last submission.
+			 */
+			btrfs_get_bioc(bioc);
+			list_add_tail(&bioc->ordered_entry,
+				      &bbio->ordered->bioc_list);
+		}
+
 		/*
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6f6838226fe7..2e11a699ab77 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -42,6 +42,7 @@
 #include "file-item.h"
 #include "orphan.h"
 #include "tree-checker.h"
+#include "raid-stripe-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bafca05940d7..6f71630248da 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -71,6 +71,7 @@
 #include "super.h"
 #include "orphan.h"
 #include "backref.h"
+#include "raid-stripe-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -3091,6 +3092,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	trans->block_rsv = &inode->block_rsv;
 
+	ret = btrfs_insert_raid_extent(trans, ordered_extent);
+	if (ret)
+		goto out;
+
 	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
@@ -3224,7 +3229,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 {
 	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
-	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
+	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags) &&
+	    list_empty(&ordered->bioc_list))
 		btrfs_finish_ordered_zoned(ordered);
 	return btrfs_finish_one_ordered(ordered);
 }
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 345c449d588c..55c7d5543265 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -191,6 +191,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	INIT_LIST_HEAD(&entry->log_list);
 	INIT_LIST_HEAD(&entry->root_extent_list);
 	INIT_LIST_HEAD(&entry->work_list);
+	INIT_LIST_HEAD(&entry->bioc_list);
 	init_completion(&entry->completion);
 
 	/*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 173bd5c5df26..1c51ac57e5df 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -151,6 +151,8 @@ struct btrfs_ordered_extent {
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
+
+	struct list_head bioc_list;
 };
 
 static inline void
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
new file mode 100644
index 000000000000..2415698a8fef
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Western Digital Corporation or its affiliates.
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
+#include "print-tree.h"
+
+static u8 btrfs_bg_type_to_raid_encoding(u64 map_type)
+{
+	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case BTRFS_BLOCK_GROUP_DUP:
+		return BTRFS_STRIPE_DUP;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		return BTRFS_STRIPE_RAID0;
+	case BTRFS_BLOCK_GROUP_RAID1:
+		return BTRFS_STRIPE_RAID1;
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+		return BTRFS_STRIPE_RAID1C3;
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		return BTRFS_STRIPE_RAID1C4;
+	case BTRFS_BLOCK_GROUP_RAID5:
+		return BTRFS_STRIPE_RAID5;
+	case BTRFS_BLOCK_GROUP_RAID6:
+		return BTRFS_STRIPE_RAID6;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		return BTRFS_STRIPE_RAID10;
+	default:
+		ASSERT(0);
+	}
+}
+
+static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
+				 int num_stripes,
+				 struct btrfs_io_context *bioc)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key stripe_key;
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	u8 encoding = btrfs_bg_type_to_raid_encoding(bioc->map_type);
+	struct btrfs_stripe_extent *stripe_extent;
+	size_t item_size;
+	int ret;
+
+	item_size = struct_size(stripe_extent, strides, num_stripes);
+
+	stripe_extent = kzalloc(item_size, GFP_NOFS);
+	if (!stripe_extent) {
+		btrfs_abort_transaction(trans, -ENOMEM);
+		btrfs_end_transaction(trans);
+		return -ENOMEM;
+	}
+
+	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
+	for (int i = 0; i < num_stripes; i++) {
+		u64 devid = bioc->stripes[i].dev->devid;
+		u64 physical = bioc->stripes[i].physical;
+		u64 length = bioc->stripes[i].length;
+		struct btrfs_raid_stride *raid_stride =
+						&stripe_extent->strides[i];
+
+		if (length == 0)
+			length = bioc->size;
+
+		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
+		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
+		btrfs_set_stack_raid_stride_length(raid_stride, length);
+	}
+
+	stripe_key.objectid = bioc->logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = bioc->size;
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
+
+static int btrfs_insert_mirrored_raid_extents(struct btrfs_trans_handle *trans,
+				      struct btrfs_ordered_extent *ordered,
+				      u64 map_type)
+{
+	int num_stripes = btrfs_bg_type_to_factor(map_type);
+	struct btrfs_io_context *bioc;
+	int ret;
+
+	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
+		ret = btrfs_insert_one_raid_extent(trans, num_stripes, bioc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int btrfs_insert_striped_mirrored_raid_extents(
+				      struct btrfs_trans_handle *trans,
+				      struct btrfs_ordered_extent *ordered,
+				      u64 map_type)
+{
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_context *rbioc;
+	const int nstripes = list_count_nodes(&ordered->bioc_list);
+	const int index = btrfs_bg_flags_to_raid_index(map_type);
+	const int substripes = btrfs_raid_array[index].sub_stripes;
+	const int max_stripes = trans->fs_info->fs_devices->rw_devices / 2;
+	int left = nstripes;
+	int stripe = 0, j = 0;
+	int i = 0;
+	int ret = 0;
+	u64 stripe_end;
+	u64 prev_end;
+
+	if (nstripes == 1)
+		return btrfs_insert_mirrored_raid_extents(trans, ordered, map_type);
+
+	rbioc = kzalloc(struct_size(rbioc, stripes, nstripes * substripes),
+			GFP_KERNEL);
+	if (!rbioc)
+		return -ENOMEM;
+
+	rbioc->map_type = map_type;
+	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
+					   ordered_entry)->logical;
+
+	stripe_end = rbioc->logical;
+	prev_end = stripe_end;
+	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
+
+		rbioc->size += bioc->size;
+		for (j = 0; j < substripes; j++) {
+			stripe = i + j;
+			rbioc->stripes[stripe].dev = bioc->stripes[j].dev;
+			rbioc->stripes[stripe].physical = bioc->stripes[j].physical;
+			rbioc->stripes[stripe].length = bioc->size;
+		}
+
+		stripe_end += rbioc->size;
+		if (i >= nstripes ||
+		    (stripe_end - prev_end >= max_stripes * BTRFS_STRIPE_LEN)) {
+			ret = btrfs_insert_one_raid_extent(trans,
+							   nstripes * substripes,
+							   rbioc);
+			if (ret)
+				goto out;
+
+			left -= nstripes;
+			i = 0;
+			rbioc->logical += rbioc->size;
+			rbioc->size = 0;
+		} else {
+			i += substripes;
+			prev_end = stripe_end;
+		}
+	}
+
+	if (left) {
+		bioc = list_prev_entry(bioc, ordered_entry);
+		ret = btrfs_insert_one_raid_extent(trans, substripes, bioc);
+	}
+
+out:
+	kfree(rbioc);
+	return ret;
+}
+
+static int btrfs_insert_striped_raid_extents(struct btrfs_trans_handle *trans,
+				     struct btrfs_ordered_extent *ordered,
+				     u64 map_type)
+{
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_context *rbioc;
+	const int nstripes = list_count_nodes(&ordered->bioc_list);
+	int i = 0;
+	int ret = 0;
+
+	rbioc = kzalloc(struct_size(rbioc, stripes, nstripes), GFP_KERNEL);
+	if (!rbioc)
+		return -ENOMEM;
+	rbioc->map_type = map_type;
+	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
+					   ordered_entry)->logical;
+
+	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
+		rbioc->size += bioc->size;
+		rbioc->stripes[i].dev = bioc->stripes[0].dev;
+		rbioc->stripes[i].physical = bioc->stripes[0].physical;
+		rbioc->stripes[i].length = bioc->size;
+
+		if (i == nstripes - 1) {
+			ret = btrfs_insert_one_raid_extent(trans, nstripes, rbioc);
+			if (ret)
+				goto out;
+
+			i = 0;
+			rbioc->logical += rbioc->size;
+			rbioc->size = 0;
+		} else {
+			i++;
+		}
+	}
+
+	if (i && i < nstripes - 1)
+		ret = btrfs_insert_one_raid_extent(trans, i, rbioc);
+
+out:
+	kfree(rbioc);
+	return ret;
+}
+
+int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_ordered_extent *ordered_extent)
+{
+	struct btrfs_io_context *bioc;
+	u64 map_type;
+	int ret;
+
+	if (!trans->fs_info->stripe_root)
+		return 0;
+
+	map_type = list_first_entry(&ordered_extent->bioc_list, typeof(*bioc),
+				    ordered_entry)->map_type;
+
+	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		ret = btrfs_insert_mirrored_raid_extents(trans, ordered_extent,
+							 map_type);
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		ret = btrfs_insert_striped_raid_extents(trans, ordered_extent,
+							map_type);
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		ret = btrfs_insert_striped_mirrored_raid_extents(trans, ordered_extent, map_type);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	while (!list_empty(&ordered_extent->bioc_list)) {
+		bioc = list_first_entry(&ordered_extent->bioc_list,
+					typeof(*bioc), ordered_entry);
+		list_del(&bioc->ordered_entry);
+		btrfs_put_bioc(bioc);
+	}
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
new file mode 100644
index 000000000000..f36e4c2d46b0
--- /dev/null
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef BTRFS_RAID_STRIPE_TREE_H
+#define BTRFS_RAID_STRIPE_TREE_H
+
+#include "disk-io.h"
+
+struct btrfs_io_context;
+struct btrfs_io_stripe;
+
+int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_ordered_extent *ordered_extent);
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
+#endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 871a55d36e32..0c0fd4eb4848 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5881,6 +5881,7 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 }
 
 static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
+						       u64 logical,
 						       u16 total_stripes)
 {
 	struct btrfs_io_context *bioc;
@@ -5900,6 +5901,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	bioc->fs_info = fs_info;
 	bioc->replace_stripe_src = -1;
 	bioc->full_stripe_logical = (u64)-1;
+	bioc->logical = logical;
 
 	return bioc;
 }
@@ -6434,7 +6436,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 
-	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes);
+	bioc = alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 576bfcb5b764..8604bfbbf510 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -390,12 +390,11 @@ struct btrfs_fs_devices {
 
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
+	u64 length;
+	/* For the endio handler */
+	struct btrfs_io_context *bioc;
 };
 
 struct btrfs_discard_stripe {
@@ -428,6 +427,10 @@ struct btrfs_io_context {
 	atomic_t error;
 	u16 max_errors;
 
+	u64 logical;
+	u64 size;
+	struct list_head ordered_entry;
+
 	/*
 	 * The total number of stripes, including the extra duplicated
 	 * stripe for replace.

-- 
2.41.0

