Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970CB79BC7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355573AbjIKWBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbjIKNXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155612A
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438595; x=1725974595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H022AhqxQLH8oJ/IhL9gK9CUAeyKynw0SLTJOhcuOHQ=;
  b=YilrwGy5AlUpmOxGxVMDPCg5FoylLJqk2YoNFnTAqfzcNgoNFC4orejf
   HiXZM37sQgQj6n4dy7YGQFJ3ehXxEznl2KXzwxtF0UlZSRqGQnCT78VW+
   NvNOoSoYQVdeOEIApTj6YPMHaeLmKUdyw2WJYVd9TMGf/NlAfJ9CA6lZx
   vJo+W9TNDUOD19j3A2E7Tq8UkWr7z1sCFDY8uguyhfgsOE9zeXKBZ1KSt
   SHOEDFfqOohFFmKYcrpxoYnFq2UfhNgV50a7YdCpl69rgrNqIIEYulEM4
   WloKy2f38sEi2ZuhPdJHxzBJqhdI8QgekUxDebYQn01y4CXBkM56rLOc7
   A==;
X-CSE-ConnectionGUID: 8ES1wyiBRRGwLWNFUoUwww==
X-CSE-MsgGUID: OHUcN68/TdyRNJePVtl7FQ==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143283"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:14 +0800
IronPort-SDR: 6DD1LbTZDt0YQB/csjrBy5moV0FrM5Ce5Ab1rVbuMlM+WjrhvVKXZpdvTZlS/TDmU1uf7rbuwg
 B9TSuEa4//11sDNO6axZ7hYtAIrGCT+fWasseomEWjtiCavUUXaN/j9VWsN7taj5XBd5rXg6v9
 MUFgfTgxJuaz1+SyarY7D8p6E4Z2Hd8npHMZrPI/R343zY1AHGlOdoF/dltxASWzCO0UbkfX/1
 Rgw5ZLImApekPdoKjsNCvgBRCENJIc37XDZ03oY2KrKitg3m7RbwD3d1bzYDUkogBhGHGfg7/p
 Ebs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:19 -0700
IronPort-SDR: My0ZbToCJmvcAZDxNYlrQPbivIoV+mITsZaki3rPiNzcYIRXItz1xdhbguw/nFPdPojhxz7P4f
 f2TERQyq8ZWoJiALKCy41yjh938GK+0lAb8NfEqPRLMaxKHDiH+6/MQli9Mcogf3sQBTcYmArI
 cvpjlVzhpokCWcaaK4JmWIfRvkEQiwPc3dvlnzCcunjx+cGIJPWtG0C4mZDqZc2w3WgMTOWNfy
 KPYI3WwSBFBec0fKiw4kmfrh3EiaC8HpS+wSnjpmXxZfAUOFXpYBaCZD598PkJYgDZjeN62zcY
 +K0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: allow zoned RAID
Date:   Mon, 11 Sep 2023 06:23:00 -0700
Message-ID: <20230911-raid-stripe-tree-v1-4-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
References: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=7572; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=H022AhqxQLH8oJ/IhL9gK9CUAeyKynw0SLTJOhcuOHQ=; b=Ye/UjLLY5aX1r6TuR1tcvcESvHzT9JgMZvwugj85EGD/X3aXSpKD3RcuNbZ42G6p/Qqe1GerI KLgMRiBO8/KA2ubdAesgYJ4LHXW4mujAcOzW5lfCIpObnHElXTBrMZ2
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
index 26ab0b6aea17..e6322a77d3c8 100644
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

