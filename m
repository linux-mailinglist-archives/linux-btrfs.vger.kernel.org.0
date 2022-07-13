Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1255572FD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiGMH6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiGMH6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 03:58:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46621E7ACB
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 00:58:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D0671FCFD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657699084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfb48aICoMtx1NFrebeLjudSms4Cxx03B1ym0kaZS8k=;
        b=c7fuDaIjQJsiVGIVKTdWC5lc1yYBwA39Poc3Fc8YHloYzwEdWGILRj7FcYCkjbz2u69mry
        RWFFeoxjpuMLNDWabcB6QxdzVgMSO2sByJaNHXQHrUcVys+4ZOKkdqaQIeW6vfVvIWin9t
        FX0ono8KPH8Z0Nxp5aISPGspvuCspRA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0FF313AAD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KHbEHwt7zmK/KQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:58:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: separate block group tree from extent tree v2
Date:   Wed, 13 Jul 2022 15:57:43 +0800
Message-Id: <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1657698964.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657698964.git.wqu@suse.com>
References: <cover.1657698964.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Block group tree feature is completely a standalone feature, and it has
been over 5 years before the initial introduction to solve the long
mount time.

I don't really want to waste another 5 years waiting for a feature which
may or may not work, but definitely not properly reviewed for its
preparation patches.

So this patch will separate the block group tree feature into a
standalone compat RO feature.

There is a catch, in mkfs create_block_group_tree(), current
tree-checker only accepts block group item with valid chunk_objectid,
but the existing code from extent-tree-v2 didn't properly initialize it.

This patch will also fix above mentioned problem so kernel can mount it
correctly.

Now mkfs/fsck should be able to handle the fs with block group tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c               |  8 ++------
 common/fsfeatures.c        |  8 ++++++++
 common/fsfeatures.h        |  2 ++
 kernel-shared/ctree.h      |  9 ++++++++-
 kernel-shared/disk-io.c    |  4 ++--
 kernel-shared/disk-io.h    |  2 +-
 kernel-shared/print-tree.c |  5 ++---
 mkfs/common.c              | 31 ++++++++++++++++++++++++-------
 mkfs/main.c                |  3 ++-
 9 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/check/main.c b/check/main.c
index 4f7ab8b29309..02abbd5289f9 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6293,7 +6293,7 @@ static int check_type_with_root(u64 rootid, u8 key_type)
 			goto err;
 		break;
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
-		if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
+		if (btrfs_fs_compat_ro(gfs_info, BLOCK_GROUP_TREE)) {
 			if (rootid != BTRFS_BLOCK_GROUP_TREE_OBJECTID)
 				goto err;
 		} else if (rootid != BTRFS_EXTENT_TREE_OBJECTID) {
@@ -9071,10 +9071,6 @@ again:
 	ret = load_super_root(&normal_trees, gfs_info->chunk_root);
 	if (ret < 0)
 		goto out;
-	ret = load_super_root(&normal_trees, gfs_info->block_group_root);
-	if (ret < 0)
-		goto out;
-
 	ret = parse_tree_roots(&normal_trees, &dropping_trees);
 	if (ret < 0)
 		goto out;
@@ -9574,7 +9570,7 @@ again:
 	 * If we are extent tree v2 then we can reint the block group root as
 	 * well.
 	 */
-	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
+	if (btrfs_fs_compat_ro(gfs_info, BLOCK_GROUP_TREE)) {
 		ret = btrfs_fsck_reinit_root(trans, gfs_info->block_group_root);
 		if (ret) {
 			fprintf(stderr, "block group initialization failed\n");
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 23a92c21a2cc..90704959b13b 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -172,6 +172,14 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(safe, 4,9),
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
+	}, {
+		.name		= "block-group-tree",
+		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
+		.sysfs_name = "block_group_tree",
+		VERSION_TO_STRING2(compat, 6,0),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "block group tree to reduce mount time"
 	},
 	/* Keep this one last */
 	{
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 9e39c667b900..a8d77fd4da05 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -45,6 +45,8 @@
 
 #define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
 #define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
+#define BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE	(1ULL << 2)
+
 
 void btrfs_list_all_fs_features(u64 mask_disallowed);
 void btrfs_list_all_runtime_features(u64 mask_disallowed);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index c12076202577..d8909b3fdf20 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -479,6 +479,12 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
 
+/*
+ * Save all block group items into a dedicated block group tree, to greatly
+ * reduce mount time for large fs.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 5)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
@@ -508,7 +514,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID| \
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 80db5976cc3f..6eeb5ecd1d59 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1203,7 +1203,7 @@ static int load_important_roots(struct btrfs_fs_info *fs_info,
 		backup = sb->super_roots + index;
 	}
 
-	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+	if (!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
 		free(fs_info->block_group_root);
 		fs_info->block_group_root = NULL;
 		goto tree_root;
@@ -1256,7 +1256,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	if (ret)
 		return ret;
 
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
 		ret = find_and_setup_root(root, fs_info,
 				BTRFS_BLOCK_GROUP_TREE_OBJECTID,
 				fs_info->block_group_root);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index bba97fc1a814..6c8eaa2bd13d 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -232,7 +232,7 @@ int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 static inline struct btrfs_root *btrfs_block_group_root(
 						struct btrfs_fs_info *fs_info)
 {
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
 		return fs_info->block_group_root;
 	return btrfs_extent_root(fs_info, 0);
 }
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index bffe30b405c7..b2ee77c2fb73 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1668,6 +1668,7 @@ struct readable_flag_entry {
 static struct readable_flag_entry compat_ro_flags_array[] = {
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE),
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
+	DEF_COMPAT_RO_FLAG_ENTRY(BLOCK_GROUP_TREE),
 };
 static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
 				       sizeof(struct readable_flag_entry);
@@ -1754,9 +1755,7 @@ static void print_readable_compat_ro_flag(u64 flag)
 	 */
 	return __print_readable_flag(flag, compat_ro_flags_array,
 				     compat_ro_flags_num,
-				     BTRFS_FEATURE_COMPAT_RO_SUPP |
-				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
+				     BTRFS_FEATURE_COMPAT_RO_SUPP);
 }
 
 static void print_readable_incompat_flag(u64 flag)
diff --git a/mkfs/common.c b/mkfs/common.c
index b72338551dfb..cb616f13ef9b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -75,6 +75,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	int blk;
 	int i;
 	u8 uuid[BTRFS_UUID_SIZE];
+	bool block_group_tree = !!(cfg->runtime_features &
+				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
@@ -101,6 +103,9 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE)
 			continue;
 
+		if (!block_group_tree && blk == MKFS_BLOCK_GROUP_TREE)
+			continue;
+
 		btrfs_set_root_bytenr(&root_item, cfg->blocks[blk]);
 		btrfs_set_disk_key_objectid(&disk_key,
 			reference_root_table[blk]);
@@ -216,7 +221,8 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
-	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used, 0,
+	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used,
+			       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
 			       cfg->leaf_data_size -
 			       sizeof(struct btrfs_block_group_item));
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
@@ -357,6 +363,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u32 array_size;
 	u32 item_size;
 	u64 total_used = 0;
+	u64 ro_flags = 0;
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
@@ -365,6 +372,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	bool add_block_group = true;
 	bool free_space_tree = !!(cfg->runtime_features &
 				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
+	bool block_group_tree = !!(cfg->runtime_features &
+				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
 	bool extent_tree_v2 = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
@@ -372,8 +381,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	       sizeof(enum btrfs_mkfs_block) * ARRAY_SIZE(default_blocks));
 	blocks_nr = ARRAY_SIZE(default_blocks);
 
-	/* Extent tree v2 needs an extra block for block group tree.*/
-	if (extent_tree_v2) {
+	/*
+	 * Add one new block for block group tree.
+	 * And for block group tree, we don't need to add block group item
+	 * into extent tree, the item will be handled in block group tree
+	 * initialization.
+	 */
+	if (block_group_tree) {
 		mkfs_blocks_add(blocks, &blocks_nr, MKFS_BLOCK_GROUP_TREE);
 		add_block_group = false;
 	}
@@ -433,12 +447,15 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
 	if (free_space_tree) {
-		u64 ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-			BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID;
+		ro_flags |= (BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+			     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
 
-		btrfs_set_super_compat_ro_flags(&super, ro_flags);
 		btrfs_set_super_cache_generation(&super, 0);
 	}
+	if (block_group_tree)
+		ro_flags |= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
+	btrfs_set_super_compat_ro_flags(&super, ro_flags);
+
 	if (extent_tree_v2)
 		btrfs_set_super_nr_global_roots(&super, 1);
 
@@ -695,7 +712,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			goto out;
 	}
 
-	if (extent_tree_v2) {
+	if (block_group_tree) {
 		ret = create_block_group_tree(fd, cfg, buf,
 					      system_group_offset,
 					      system_group_size, total_used);
diff --git a/mkfs/main.c b/mkfs/main.c
index ce096d362171..518ce0fd7523 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -299,7 +299,8 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, info->dev_root);
 	if (ret)
 		return ret;
-        if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
+
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
 		ret = __recow_root(trans, info->block_group_root);
 		if (ret)
 			return ret;
-- 
2.37.0

