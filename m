Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB99697E61
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBOOb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBOObY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:24 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032336685
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471483; x=1708007483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=blfcU0s5Kw+ypvhMtDL0LEuaz785wjuRoja2kAmzW8s=;
  b=oyv02dqPSqM+OgScRKOiOOkLtG/DZK7VynXYtazvOeTia1eFUy+jyZEG
   UWgnQiXO9QF/Ov8MrcD+8KJyd13RFgnHFQXwd+vo65V7qDnex7gTdjlRz
   Br/i9DJGl2O98ZWQLiGdOnHgP+ymriTvfetYjFOjd6LCj/KFwN8207hbY
   //q3sQgQKx1b/AThTVTYOsVAbd1bSqZwK4OmmFrvBYl/aBdnBbNzdrpoX
   bSNinAhzmcsBJgnGU4M8DfC2wRtxaWQPZTehrNtwrLEg8vmhG/7ktSLfM
   ssKhbhwim3jKm50McXuVGVjmiP77bFymdBpXxYGa2h+qQNrvH+LYrOIYm
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393923"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:16 +0800
IronPort-SDR: dK+PlJN1Rgdt6YHaIdiWMsfSn/rMa6XGJRpvJpkBDYspunMd/82d4K7UuQ4zylCY2MWVXV33Vh
 NrpP52NR45P4k0+ERnWoLxhfdBXn7JK1DZVtBfjlvNTU/m8442DJDvPIGPUVPWqusTH4MLiIJ1
 bs5YPEmLJ4RenFVQYaZFr/oylkxd0zL3Y05zNy5L+O3VdpRKJR4pFUVDxrJHfLDHdNH7I0g7BQ
 kkcR+6CoLWQskSNdi0mWxfRwsMxEH5gD2IbO3bi6/O0tET23nFbTEShFVab6Iy9B3ARqRS1qzn
 qag=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:22 -0800
IronPort-SDR: ggSoVIMjoLL7u+EjSIAtGysv+h4WQIyE5ulNOWzat2UEw0reH2BXhZDifUpb7T8UrhRioHRm0v
 Y+OvduBQcV1UUKXOFcSK6cknl4IziaOiCfVfXo/qBE9esXtlm7NM7ZXSXeoSYT4p+c13mjlI7y
 KKgfaHKUUwC1clr669TAjFB6oZ24UOfaj0JN+AT3mLjJOL1SBtgqwGMjd9eSZvknTzP9DSG9Ht
 hOvB0slG0mLPfRiw88rTN4iYiISbK7xUTMqVUArigY3nnoaFFMKAemKSDBBSTHwdTC+jHBUah7
 n7U=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:16 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Date:   Wed, 15 Feb 2023 06:31:09 -0800
Message-Id: <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
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

Allow for RAID levels 0, 1 and 10 on zoned devices if the RAID stripe tree
is used.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/fsfeatures.c   |  8 +++++
 kernel-shared/ctree.h |  3 +-
 kernel-shared/zoned.c | 35 ++++++++++++++++--
 kernel-shared/zoned.h |  4 +--
 mkfs/main.c           | 82 ++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 169e47e92582..d18226f43d7c 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -195,6 +195,14 @@ static const struct btrfs_feature mkfs_features[] = {
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
index a9bb6eb39752..0fb5014d0696 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -560,7 +560,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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
index a79fc6a5dbc3..4f07384817aa 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -795,7 +795,7 @@ out:
 	return ret;
 }
 
-bool zoned_profile_supported(u64 map_type)
+bool zoned_profile_supported(u64 map_type, bool rst)
 {
 	bool data = (map_type & BTRFS_BLOCK_GROUP_DATA);
 	u64 flags = (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
@@ -804,9 +804,37 @@ bool zoned_profile_supported(u64 map_type)
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
@@ -923,7 +951,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	if (!zoned_profile_supported(map->type)) {
+	if (!zoned_profile_supported(map->type,
+					btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE))) {
 		error("zoned: profile %s not yet supported",
 		      btrfs_group_profile_str(map->type));
 		ret = -EINVAL;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index cc0d6b6f166d..c56788bcf07b 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -132,7 +132,7 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
 }
 
-bool zoned_profile_supported(u64 map_type);
+bool zoned_profile_supported(u64 map_type, bool rst);
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
@@ -213,7 +213,7 @@ static inline int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices)
 	return 0;
 }
 
-static inline bool zoned_profile_supported(u64 map_type)
+static inline bool zoned_profile_supported(u64 map_type, bool rst)
 {
 	return false;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index f4ff2c58a81f..a8a370d1c4df 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -958,6 +958,38 @@ fail:
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
@@ -1356,10 +1388,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			exit(1);
 		}
 
+#if !defined(EXPERIMENTAL)
 		if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_RAID56) {
 			error("cannot enable RAID5/6 in zoned mode");
 			exit(1);
 		}
+#endif
 	}
 
 	if (btrfs_check_nodesize(nodesize, sectorsize, &features))
@@ -1464,10 +1498,40 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
+		case BTRFS_BLOCK_GROUP_RAID56_MASK:
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
@@ -1755,6 +1819,16 @@ raid_groups:
 			goto out;
 		}
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
+
 	if (bconf.verbose) {
 		char features_buf[BTRFS_FEATURE_STRING_BUF_SIZE];
 
-- 
2.39.0

