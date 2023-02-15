Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76D697E5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBOObY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBOObV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132E36685
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471475; x=1708007475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4TMuTD5kAQ7AQKNfm0FN1sj8dRuM6RB+2txzcfxk/4=;
  b=cBzs6RBLFG7s6KVUgzhqtsn5+FSPY/Ra36iAEaRes8YcmA2TNNSCiiAC
   BfVVBxhwr589VlpssSyvE8QRO0nI2tbaDdmpagPytJn03zB/LaJvMBpeB
   +aYsCcMR25R1Zj5oNXTFPw6D2k233u5WcxQ9GIXfhylJ/nLvCWRJLh+UC
   +QMlKrAN6NTeLgkxz2umUG8Yw+dIQrf3cswSzNy0rK/0enl+I7SGSiQdQ
   ydzqMEZOcnpIb2GZDRNxGJBQGgM/yVfNRP39ZyL6ileWwexvDE6DzPPa5
   K/MjiD5kGHNd+ThHEHkmSMWFrGxjCywu/kOzc/d4zXiJqx3wvItpXR+08
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393909"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:13 +0800
IronPort-SDR: b/qSPktTES6bsn0DBmGOv2poX+nNPf3Ig7buFg9lC8S9UH6YlbtZRbykBNNzcIsPXKUJV9Hn/T
 Lpz5bqv6J9Rpmkkt6mVvPVTwvlAghMTmWRYnZzgb2ewwwEM8JoQ1fH4kcgvjwpXvN4p/HwHjS+
 q2DoIxIXPOB85a8kKGPzpxbcjFAGdRT2CbuKnkw4nEISDx3VwNBMpAn3c/ajb9kRZTSBLHMtcP
 CCqrR2ltpKdVkVc6ulznnklHfy5URKR2xckZ3rdfHKuq+gFm4XrAzB+ejnB+94a8x0Cw+aCYHJ
 iKo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:19 -0800
IronPort-SDR: cyOT1EeiBTCLelQ0fGZGecO/vXQSXfXo9KglNCVfdNcX5M8oeU6lAHbehfqIIe+gocbf5e8CIe
 Pse4mA4QNkehcaiyr2rHlocTUqNA6wrQWw6u6GndcAeofpwR0GnWpgKww0BrNhRKhs54nbTw/p
 MLo3BTlROU5c8ASYqC8yQPwIXKjb2j7up4JutY9YOPzOU32cpyNQxq1HjeVWJ0e0yQKHnQ3vyN
 GX93TWTSUEnwAPe24AHDV8WFiwHxaJc93kGgOXhQJHOyGhfOwf/7glMYbLGxIxbx4dElabUSxh
 CXs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:13 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/6] btrfs-progs: read fs with stripe tree from disk
Date:   Wed, 15 Feb 2023 06:31:05 -0800
Message-Id: <20230215143109.2721722-3-johannes.thumshirn@wdc.com>
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

When encountering a filesystem formatted with the raid stripe tree
feature, read it from disk.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/ctree.h   |  4 ++++
 kernel-shared/disk-io.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a91c7dac4403..ab6b20a1abca 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -80,6 +80,9 @@ struct btrfs_free_space_ctl;
 /* hold the block group items. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* holds raid stripe entries */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -1214,6 +1217,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	struct rb_root global_roots_tree;
 	struct rb_root fs_root_tree;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4050566a8b48..f4f9a4792d29 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -800,6 +800,12 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		return fs_info->block_group_root ? fs_info->block_group_root :
 						ERR_PTR(-ENOENT);
 
+#if EXPERIMENTAL
+	if (location->objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return fs_info->stripe_root ? fs_info->stripe_root :
+			ERR_PTR(-ENOENT);
+#endif
+
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
 	node = rb_search(&fs_info->fs_root_tree, (void *)&objectid,
@@ -832,6 +838,9 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	if (fs_info->quota_root)
 		free(fs_info->quota_root);
 
+	if (fs_info->stripe_root)
+		free(fs_info->stripe_root);
+
 	free_global_roots_tree(&fs_info->global_roots_tree);
 	free(fs_info->tree_root);
 	free(fs_info->chunk_root);
@@ -856,12 +865,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
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
@@ -1270,6 +1281,23 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
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
+			fs_info->stripe_root->track_dirty = 1;
+		}
+	} else {
+		free(fs_info->stripe_root);
+		fs_info->stripe_root = NULL;
+	}
+#endif
+
 	if (maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
@@ -1327,6 +1355,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->chunk_root->node);
 	if (fs_info->uuid_root)
 		free_extent_buffer(fs_info->uuid_root->node);
+	if (fs_info->stripe_root)
+		free_extent_buffer(fs_info->stripe_root->node);
 }
 
 static void free_map_lookup(struct cache_extent *ce)
-- 
2.39.0

