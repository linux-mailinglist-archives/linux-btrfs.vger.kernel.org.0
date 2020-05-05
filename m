Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0A1C4AD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEEACt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbgEEACs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1F3AAEE7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 07/11] btrfs-progs: mkfs: Introduce -O skinny-bg-tree
Date:   Tue,  5 May 2020 08:02:26 +0800
Message-Id: <20200505000230.4454-8-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This allow mkfs.btrfs to create a btrfs with skinny-bg-tree feature.

This patch introduce a new function, btrfs_convert_to_bg_tree() in
extent-tree.c, to do the work.

The convert happens after our fs is created (with temp chunks cleaned
up), before we populate the root dir.

The workflow is simple:
- Create a new tree block for bg tree
- Set the SKINNY_BG_TREE feature for superblock
- Set the fs_info->convert_to_bg_tree flag
- Mark all block group as dirty
- Commit transaction
  * With fs_info->convert_to_skinny_bg_tree set, we will try to delete the
    BLOCK_GROUP_ITEM in extent tree first, then write the new
    BLOCK_GROUP_ITEM into bg tree.
    So that at update_block_group_item(), we convert the old extent
    items to skinny bg items.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c |  6 +++
 ctree.h             |  2 +
 extent-tree.c       | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 mkfs/common.c       |  3 +-
 mkfs/common.h       |  3 ++
 mkfs/main.c         | 11 +++++
 transaction.c       |  1 +
 7 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index ac12d57b25a3..46666b34281d 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -92,6 +92,12 @@ static const struct btrfs_fs_feature {
 		NULL, 0,
 		NULL, 0,
 		"RAID1 with 3 or 4 copies" },
+	{ "skinny-bg-tree", BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE,
+		"skinny_bg_tree",
+		VERSION_TO_STRING2(5, 9),
+		NULL, 0,
+		NULL, 0,
+		"store optimized block group items in dedicated tree" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/ctree.h b/ctree.h
index 9ce73008a7e0..a84237a06609 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1205,6 +1205,7 @@ struct btrfs_fs_info {
 	unsigned int avoid_sys_chunk_alloc:1;
 	unsigned int finalize_on_close:1;
 	unsigned int hide_names:1;
+	unsigned int convert_to_skinny_bg_tree:1;
 
 	int transaction_aborted;
 
@@ -2619,6 +2620,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 u64 add_new_free_space(struct btrfs_block_group *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
+int btrfs_convert_to_skinny_bg_tree(struct btrfs_fs_info *fs_info);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
diff --git a/extent-tree.c b/extent-tree.c
index 179fce4422cf..b6ac7b4caa2f 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1557,6 +1557,11 @@ error:
 	return ret;
 }
 
+static int remove_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_path *path,
+				   struct btrfs_block_group *block_group);
+static int insert_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_block_group *block_group);
 static int update_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_path *path,
 				   struct btrfs_block_group *cache)
@@ -1570,6 +1575,21 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		if (fs_info->convert_to_skinny_bg_tree) {
+			ret = remove_block_group_item(trans, path, cache);
+			btrfs_release_path(path);
+			if (ret < 0 && ret != -ENOENT)
+				goto fail;
+
+			ret = insert_block_group_item(trans, cache);
+			btrfs_release_path(path);
+			/* New one is inserted, no need to update */
+			if (ret == 0)
+				return ret;
+			if (ret < 0 && ret != -EEXIST)
+				return ret;
+			/* ret == -EEXIST case falls through */
+		}
 		ret = locate_skinny_bg_item(fs_info, trans, cache, path, 0, 1);
 		if (ret < 0)
 			goto fail;
@@ -2932,6 +2952,24 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 
 	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		/*
+		 * For convert case, check if there is already one skinny bg
+		 * item, to prevent duplicating items.
+		 */
+		if (fs_info->convert_to_skinny_bg_tree) {
+			struct btrfs_path path;
+			int ret;
+
+			btrfs_init_path(&path);
+			ret = locate_skinny_bg_item(fs_info, NULL, block_group,
+						    &path, 0, 0);
+			btrfs_release_path(&path);
+			if (ret == 0)
+				return -EEXIST;
+			if (ret < 0 && ret != -ENOENT)
+				return ret;
+			/* -ENOENT (no existing item) case falls through */
+		}
 		key.objectid = block_group->start;
 		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
 		key.offset = block_group->used;
@@ -3051,7 +3089,8 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret = 0;
 
-	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE) &&
+	    !fs_info->convert_to_skinny_bg_tree) {
 		key.objectid = block_group->start;
 		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
 		key.offset = (u64)-1;
@@ -4033,3 +4072,59 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long nr)
 
 	return 0;
 }
+
+int btrfs_convert_to_skinny_bg_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_block_group *bg;
+	struct btrfs_root *bg_root;
+	u64 features = btrfs_super_incompat_flags(fs_info->super_copy);
+	int ret;
+
+	ASSERT(fs_info->bg_root == NULL);
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+
+	/* Create bg tree first */
+	bg_root = btrfs_create_tree(trans, fs_info,
+				    BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+	if (IS_ERR(bg_root)) {
+		ret = PTR_ERR(bg_root);
+		errno = -ret;
+		error("failed to create bg tree: %m");
+		goto error;
+	}
+	fs_info->bg_root = bg_root;
+	fs_info->bg_root->track_dirty = 1;
+	fs_info->bg_root->ref_cows = 0;
+	add_root_to_dirty_list(bg_root);
+
+	/* Set SKINNY_BG_FEATURE and convert status */
+	btrfs_set_super_incompat_flags(fs_info->super_copy,
+			features | BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE);
+	fs_info->convert_to_skinny_bg_tree = 1;
+
+	/* Mark all bgs dirty so convert will happen at convert time */
+	for (bg = btrfs_lookup_first_block_group(fs_info, 0); bg;
+	     bg = btrfs_lookup_first_block_group(fs_info,
+		     bg->start + bg->length))
+		if (list_empty(&bg->dirty_list))
+			list_add_tail(&bg->dirty_list, &trans->dirty_bgs);
+
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		goto error;
+	}
+	return ret;
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/mkfs/common.c b/mkfs/common.c
index 469b88d6a8d3..88df4c5ac46d 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -205,7 +205,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
 	btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
+	btrfs_set_super_incompat_flags(&super, cfg->features &
+					~POST_MKFS_FEATURES);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
diff --git a/mkfs/common.h b/mkfs/common.h
index 426852bebf1d..217239345248 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -28,6 +28,9 @@
 #define BTRFS_MKFS_SYSTEM_GROUP_SIZE SZ_4M
 #define BTRFS_MKFS_SMALL_VOLUME_SIZE SZ_1G
 
+/* These features are handled after major mkfs work */
+#define POST_MKFS_FEATURES	(BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE)
+
 /*
  * Tree root blocks created during mkfs
  */
diff --git a/mkfs/main.c b/mkfs/main.c
index 2c28d0b159a6..5a4c41bc9ce8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1332,6 +1332,17 @@ raid_groups:
 		goto out;
 	}
 
+	/* Handle post-mkfs features */
+	if (mkfs_cfg.features & POST_MKFS_FEATURES) {
+		if (mkfs_cfg.features & BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE) {
+			ret = btrfs_convert_to_skinny_bg_tree(fs_info);
+			if (ret < 0) {
+				error("failed to convert to skinny bg tree");
+				goto out;
+			}
+		}
+	}
+
 	if (source_dir_set) {
 		ret = btrfs_mkfs_fill_dir(source_dir, root, verbose);
 		if (ret) {
diff --git a/transaction.c b/transaction.c
index 0917abcad705..4a00ff08d45a 100644
--- a/transaction.c
+++ b/transaction.c
@@ -226,6 +226,7 @@ commit_tree:
 	root->commit_root = NULL;
 	fs_info->running_transaction = NULL;
 	fs_info->last_trans_committed = transid;
+	fs_info->convert_to_skinny_bg_tree = 0;
 	list_for_each_entry(sinfo, &fs_info->space_info, list) {
 		if (sinfo->bytes_reserved) {
 			warning(
-- 
2.26.2

