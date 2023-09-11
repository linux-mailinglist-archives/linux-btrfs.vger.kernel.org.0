Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD979AD8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356133AbjIKWDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjIKNXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA3712A
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438593; x=1725974593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KKDM20AA24mnFWIBaq+OM7WQs6kIS7ubq0Wq11kxM7o=;
  b=c0rf7XQa+57oynd8jr8961F7uA7ZeqoMDApsXGW78z85DY1tHSccEjmy
   NcndVqhW1kL8Vp4qTL3JTFR22RtNLXKcr02elIyZrgUjN6ePyLFGPunB3
   zQ0Q7L86giaGvcJbsCe9SU/AxTOBwnWUwrqnzam7XqWvEbNWaTe2nWo+k
   SKzmUXDpObFCFsj5ZtQIXntf9eFqKhEzVdIfahjgCAdvBTbrP00w1elFF
   xiWzFXK7jfklfRvxxzUZivTQMmUxGwW31bGeBQnAx4HPDmjHfGljW43fJ
   PojYLfS2aQJeVh10gfmVD05l3+qQwDldEBM3aPasLwG/SsLvm3+tn8y+o
   A==;
X-CSE-ConnectionGUID: UrfpZVrzQ5qx7OVs8YZWkQ==
X-CSE-MsgGUID: dPmwOBzGS2umbhWlHiCwLg==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143280"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:12 +0800
IronPort-SDR: 6JgWW04Wn+2CogMIhOz030zT7JPbLzz1dN9vH79eBfjakbO0s77IpJrFcY6RL5X5nEDugdleSO
 WxB6NnQ1Fhs2MreffQfBlxEmJuQwe9DDjY9HgXbHyozspM2RMVgUGkhlcJyQ7BzlTDY/hhw0rf
 D87mtM8i2SwXWw/62b3/szsdbZjPZtmxeP0cAiEfH+h5WRHrMJx0gY4RvL3wRGF7QGcWQmDVzu
 5HaJjCHbEHga+H+kcHRK9gx/d/DXc3Qi9AFDAWLCjh6cXO5zEe3jXxBeegXAlAUomFHg6tT2Tu
 hIA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:18 -0700
IronPort-SDR: MO8rPAJvMvrfjzQEMuTrLwo6AlMoYrwIWLnPJ3J8nIbVw6Uo2aYULYdpmPVf2iY/2cyUMeyhpz
 HTzpwkIn2wo+hBibvfOzd3x8TwKmabcn4CpSwTMI29fu3nHdeCzVcVQJ0CHbnxvIH5D2a3QjfG
 8nERUsw/+YiR94Lcfz5tk28wVw6O6y0cpenO3AufxRy1XItruL5P2D7EglfR6j1Ta5pidSummv
 NQfotfZjVwxzSDtUDucW2E6c/8GRNYQxFjjyTxNguvpxoy7TNhNmLb1LTnq1mT4GEERIlPSinl
 PvY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:12 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: read fs with stripe tree from disk
Date:   Mon, 11 Sep 2023 06:22:58 -0700
Message-ID: <20230911-raid-stripe-tree-v1-2-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
References: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=5277; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=KKDM20AA24mnFWIBaq+OM7WQs6kIS7ubq0Wq11kxM7o=; b=xYvN9Dd2Zf2B822BZGPhWR1JuPnOpU40gSA34DH6mES3ZNhb2vKsg2wGc1VGgk8BApPBRHl3r 9QX6HOil2xNBQM3DlQ8kw8m3kuJq2u2/wgFf/2GPuGpOlgMY2t6vymr
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

When encountering a filesystem formatted with the raid stripe tree
feature, read it from disk.

Also add the incompat declaration to the tree printer.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/ctree.h           |  1 +
 kernel-shared/disk-io.c         | 28 +++++++++++++++++++++++++++-
 kernel-shared/print-tree.c      |  1 +
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h |  3 +++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5d3392ae82a6..035358436d8f 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -298,6 +298,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	struct rb_root global_roots_tree;
 	struct rb_root fs_root_tree;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 442d3af8bc01..3ab32f7ad910 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -790,6 +790,10 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		return fs_info->block_group_root ? fs_info->block_group_root :
 						ERR_PTR(-ENOENT);
 
+	if (location->objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return fs_info->stripe_root ? fs_info->stripe_root :
+			ERR_PTR(-ENOENT);
+
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
 	node = rb_search(&fs_info->fs_root_tree, (void *)&objectid,
@@ -822,6 +826,9 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	if (fs_info->quota_root)
 		free(fs_info->quota_root);
 
+	if (fs_info->stripe_root)
+		free(fs_info->stripe_root);
+
 	free_global_roots_tree(&fs_info->global_roots_tree);
 	free(fs_info->tree_root);
 	free(fs_info->chunk_root);
@@ -846,12 +853,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->stripe_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->block_group_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->chunk_root || !fs_info->dev_root ||
 	    !fs_info->quota_root || !fs_info->uuid_root ||
-	    !fs_info->block_group_root || !fs_info->super_copy)
+	    !fs_info->block_group_root || !fs_info->super_copy ||
+	    !fs_info->stripe_root)
 		goto free_all;
 
 	extent_buffer_init_cache(fs_info);
@@ -1260,6 +1269,21 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			return -EIO;
 	}
 
+#if EXPERIMENTAL
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		ret = btrfs_find_and_setup_root(root, fs_info,
+						BTRFS_RAID_STRIPE_TREE_OBJECTID,
+						fs_info->stripe_root);
+		if (ret) {
+			free(fs_info->stripe_root);
+			fs_info->stripe_root = NULL;
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY,
+				&fs_info->stripe_root->state);
+		}
+	}
+#endif
+
 	if (maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
@@ -1317,6 +1341,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->chunk_root->node);
 	if (fs_info->uuid_root)
 		free_extent_buffer(fs_info->uuid_root->node);
+	if (fs_info->stripe_root)
+		free_extent_buffer(fs_info->stripe_root->node);
 }
 
 static void free_map_lookup(struct cache_extent *ce)
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f96a..3eff82b364ef 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1708,6 +1708,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
 	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID_STRIPE_TREE),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89a2a9..c750b7aa921f 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -356,6 +356,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE (1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index e89246a3fdbe..f4a5fb14b4f0 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -73,6 +73,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* holds raid stripe entries */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 

-- 
2.41.0

