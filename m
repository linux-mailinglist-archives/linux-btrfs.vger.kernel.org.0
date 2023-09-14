Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6D7A0A43
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbjINQFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbjINQFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CD1BE1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707545; x=1726243545;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Gzghtc64t6MDPgziAXVJWilOZTxzWpOTUJKusY4KU64=;
  b=hHx2f+Sf0HqNgr1KJ5qcH4ht7Xi1k+KqvrwKC6SR1kN12lneSHN1x6MZ
   m7NaISiCWW6g9gWsncJ5Y1R7xWwnGzxBNE0KPLQzumqVoBVKd9H7tmm5c
   9vbbw/ksdhmUto5DPrR5ZsmS7JcyZLMyHP09gqS5v4rf88o9R6Pvsb/ca
   9tjojtNYhKmSg57jOyfuLbWPqFFigQessXF88ug382leGM4QbMPGioGbn
   kmHwrjLflD55WNyjI+A/oAlANphzRn4oXD9i4qgpu/0tcMCnO5CL0mDlx
   67eCQfABK020T44iK7gzWbYNGDwFNH3kdtDQ9pjTTfE/Mw8MeOnqVpUXZ
   w==;
X-CSE-ConnectionGUID: 0PrTYKppS7SdDb2Se3+t0Q==
X-CSE-MsgGUID: bNU7rFJsSyiJopAC6qDg5w==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196091"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:44 +0800
IronPort-SDR: i4QsQGcdzg0DrHYlj+8CxIBtY74QSTSKBo17WxOuPjIl8hGStowHyOvxR3wqAHWiaSc1zc2ITG
 ol0d3dBwm4zEMWrb9dGCSXexj2pALU+oX93a5yk+0fxgIUN2su7Rm6aiXbzV/kkV5YTcRdxAhJ
 2b8a5QWtMrJj2LE9JVnhF3yaIdczgD+OQI6yKUoU4Iio4OyKK9FgnrHUqLmBThxBG6QE0yrdj3
 MPPGZZLeAzLJHyMsjcFaF6+WsU6N/Heh6hSpJYXxSPcxVDvdUsTp3NWdbuzRZOv5+KzdVsxr1d
 9p8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:27 -0700
IronPort-SDR: Kk6h0yfhJNNgBwAbhKwoIW3mGOApNWoRdt1WkCqez0JDw4BetZFthmKiwb5JTBCOXQCQJiSdak
 /twHPXBLQ3il5zqtGMXJepd/dweWtXllDLTrwIXpmbjBLeJb1UZ3oN79aIK9575aJzIT/7aJG4
 +jvQWIY8nG33ZxIN/DDU4KBxEli5foqS14WxjaxIrhtNi+xpzTFoWaSp/43WyZdMe0Es1VOSbH
 z246Z5ArRSg2IgnJ5CTPk4XHStyWb9RQLwOQoIGILsENN++yxc1V9+Rsc5/oV4QNNYKPjX6ZoJ
 p54=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:45 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:05:35 -0700
Subject: [PATCH v4 4/6] btrfs-progs: allow zoned RAID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v4-4-c921c15ec052@wdc.com>
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=7572;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Gzghtc64t6MDPgziAXVJWilOZTxzWpOTUJKusY4KU64=;
 b=0TisWmauFK81TzBnJkyP6dPV0AteeGKl57g7JkV+v9OiyFmXuhZSseI96qUCEy1TWbJ5I5nFr
 YC+XfKTo4qkAmSIqQbX8Jes4kfK2+ZxFB050PiowUI5/KbJE8bxj5hx
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allow for RAID levels 0, 1 and 10 on zoned devices if the RAID stripe tree
is used.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/fsfeatures.c   |  8 ++++++
 kernel-shared/ctree.h |  3 +-
 kernel-shared/zoned.c | 34 ++++++++++++++++++++--
 kernel-shared/zoned.h |  4 +--
 mkfs/main.c           | 79 ++++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 00658fa5159f..2658f5072af4 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -189,6 +189,14 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
 		.desc		= "new extent tree format"
+	} , {
+		.name		= "raid-stripe-tree",
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
+		.sysfs_name	= NULL,
+		VERSION_NULL(compat),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "raid stripe tree"
 	},
 #endif
 	/* Keep this one last */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index de09c15ca0eb..f6ee467adaab 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -102,7 +102,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
+	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index d187c5763406..d8fad4319e44 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -737,7 +737,7 @@ out:
 	return ret;
 }
 
-bool zoned_profile_supported(u64 map_type)
+bool zoned_profile_supported(u64 map_type, bool rst)
 {
 	bool data = (map_type & BTRFS_BLOCK_GROUP_DATA);
 	u64 flags = (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
@@ -746,9 +746,37 @@ bool zoned_profile_supported(u64 map_type)
 	if (flags == 0)
 		return true;
 
-	/* We can support DUP on metadata */
+#if EXPERIMENTAL
+	if (data) {
+		if ((flags & BTRFS_BLOCK_GROUP_DUP) && rst)
+			return true;
+		/* Data RAID1 needs a raid-stripe-tree */
+		if ((flags & BTRFS_BLOCK_GROUP_RAID1_MASK) && rst)
+			return true;
+		/* Data RAID0 needs a raid-stripe-tree */
+		if ((flags & BTRFS_BLOCK_GROUP_RAID0) && rst)
+			return true;
+		/* Data RAID10 needs a raid-stripe-tree */
+		if ((flags & BTRFS_BLOCK_GROUP_RAID10) && rst)
+			return true;
+	} else {
+		/* We can support DUP on metadata/system */
+		if (flags & BTRFS_BLOCK_GROUP_DUP)
+			return true;
+		/* We can support RAID1 on metadata/system */
+		if (flags & BTRFS_BLOCK_GROUP_RAID1_MASK)
+			return true;
+		/* We can support RAID0 on metadata/system */
+		if (flags & BTRFS_BLOCK_GROUP_RAID0)
+			return true;
+		/* We can support RAID10 on metadata/system */
+		if (flags & BTRFS_BLOCK_GROUP_RAID10)
+			return true;
+	}
+#else
 	if (!data && (flags & BTRFS_BLOCK_GROUP_DUP))
 		return true;
+#endif
 
 	/* All other profiles are not supported yet */
 	return false;
@@ -863,7 +891,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	if (!zoned_profile_supported(map->type)) {
+	if (!zoned_profile_supported(map->type, !!fs_info->stripe_root)) {
 		error("zoned: profile %s not yet supported",
 		      btrfs_group_profile_str(map->type));
 		ret = -EINVAL;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 9e4162cf25c5..6efc60281bc9 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -133,7 +133,7 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
 }
 
-bool zoned_profile_supported(u64 map_type);
+bool zoned_profile_supported(u64 map_type, bool rst);
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
@@ -214,7 +214,7 @@ static inline int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices)
 	return 0;
 }
 
-static inline bool zoned_profile_supported(u64 map_type)
+static inline bool zoned_profile_supported(u64 map_type, bool rst)
 {
 	return false;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 7acd39ec6531..7d07ba1e7001 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -962,6 +962,38 @@ fail:
 	return ret;
 }
 
+static int setup_raid_stripe_tree_root(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *stripe_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
+	int ret;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	stripe_root = btrfs_create_tree(trans, fs_info, &key);
+	if (IS_ERR(stripe_root))  {
+		ret =  PTR_ERR(stripe_root);
+		goto abort;
+	}
+	fs_info->stripe_root = stripe_root;
+	add_root_to_dirty_list(stripe_root);
+
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret)
+		return ret;
+
+	return 0;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 /* Thread callback for device preparation */
 static void *prepare_one_device(void *ctx)
 {
@@ -1472,10 +1504,39 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret)
 		goto error;
 
-	if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
-		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile))) {
-		error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
-		goto error;
+#if EXPERIMENTAL
+	if (opt_zoned && device_count) {
+		switch (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+		case BTRFS_BLOCK_GROUP_DUP:
+		case BTRFS_BLOCK_GROUP_RAID1:
+		case BTRFS_BLOCK_GROUP_RAID1C3:
+		case BTRFS_BLOCK_GROUP_RAID1C4:
+		case BTRFS_BLOCK_GROUP_RAID0:
+		case BTRFS_BLOCK_GROUP_RAID10:
+			features.incompat_flags |=
+				BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE;
+			break;
+		default:
+			break;
+		}
+	}
+#endif
+
+	if (opt_zoned) {
+		u64 metadata = BTRFS_BLOCK_GROUP_METADATA | metadata_profile;
+		u64 data = BTRFS_BLOCK_GROUP_DATA | data_profile;
+#if EXPERIMENTAL
+		bool rst = features.incompat_flags &
+			BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE;
+#else
+		bool rst = false;
+#endif
+
+		if (!zoned_profile_supported(metadata, rst) ||
+		    !zoned_profile_supported(data, rst)) {
+			error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
+			goto error;
+		}
 	}
 
 	t_prepare = calloc(device_count, sizeof(*t_prepare));
@@ -1585,6 +1646,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE) {
+		ret = setup_raid_stripe_tree_root(fs_info);
+		if (ret < 0) {
+			error("failed to initialize raid-stripe-tree: %d (%m)",
+			      ret);
+			goto out;
+		}
+	}
+
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		errno = -PTR_ERR(trans);
@@ -1750,6 +1820,7 @@ raid_groups:
 			goto out;
 		}
 	}
+
 	if (bconf.verbose) {
 		char features_buf[BTRFS_FEATURE_STRING_BUF_SIZE];
 

-- 
2.41.0

