Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA443EDF9F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfKDMEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbfKDMEU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0576AF21
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:04:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/7] btrfs-progs: mkfs: Introduce -O skinny-bg-tree
Date:   Mon,  4 Nov 2019 20:03:57 +0800
Message-Id: <20191104120401.56408-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120401.56408-1-wqu@suse.com>
References: <20191104120401.56408-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This allow mkfs.btrfs to create a btrfs with skinny-bg-tree feature.

This patch introduce a global function, btrfs_convert_to_bg_tree() in
extent-tree.c, to do the work.

The workflow is pretty simple:
- Create a new tree block for bg tree
- Set the SKINNY_BG_TREE feature for superblock
- Set the fs_info->convert_to_bg_tree flag
- Mark all block group items as dirty
- Commit transaction
  * With fs_info->convert_to_skinny_bg_tree set, we will try to delete the
    BLOCK_GROUP_ITEM in extent tree first, then write the new
    BLOCK_GROUP_ITEM into bg tree.

This btrfs_convert_to_skinny_bg_tree() will be used in mkfs after the basic fs
is created.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c |  6 ++++++
 ctree.h             |  1 +
 extent-tree.c       | 39 +++++++++++++++++++++++++++++++++++++++
 mkfs/common.c       |  5 ++++-
 mkfs/main.c         | 25 +++++++++++++++++++++++++
 transaction.c       |  1 +
 6 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 50934bd161b0..087bab1310b7 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -86,6 +86,12 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
+	{ "skinny-bg-tree", BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE,
+		"skinny_bg_tree",
+		VERSION_TO_STRING2(5, 6),
+		NULL, 0,
+		NULL, 0,
+		"store optimized block group items in dedicated tree" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/ctree.h b/ctree.h
index a93e1d5d202d..631a1f9ce14a 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2862,5 +2862,6 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 
 /* extent-tree.c */
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long nr);
+int btrfs_convert_to_skinny_bg_tree(struct btrfs_trans_handle *trans);
 
 #endif
diff --git a/extent-tree.c b/extent-tree.c
index 7c68508de2ac..cf89a1be6ab5 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1524,6 +1524,45 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, record_parent, 0);
 }
 
+int btrfs_convert_to_skinny_bg_tree(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *bg;
+	struct btrfs_root *bg_root;
+	u64 features = btrfs_super_incompat_flags(fs_info->super_copy);
+	int ret;
+
+	/* create bg tree first */
+	bg_root = btrfs_create_tree(trans, fs_info, BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+	if (IS_ERR(bg_root)) {
+		ret = PTR_ERR(bg_root);
+		errno = -ret;
+		error("failed to create bg tree: %m");
+		return ret;
+	}
+	fs_info->bg_root = bg_root;
+	fs_info->bg_root->track_dirty = 1;
+	fs_info->bg_root->ref_cows = 0;
+	add_root_to_dirty_list(bg_root);
+
+	/* set BG_TREE feature and mark the fs into bg_tree convert status */
+	btrfs_set_super_incompat_flags(fs_info->super_copy,
+			features | BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE);
+	fs_info->convert_to_bg_tree = 1;
+
+	/*
+	 * Mark all block groups dirty so they will get converted to bg tree at
+	 * commit transaction time
+	 */
+	for (bg = btrfs_lookup_first_block_group(fs_info, 0); bg;
+	     bg = btrfs_lookup_first_block_group(fs_info,
+				bg->key.objectid + bg->key.offset))
+		set_extent_bits(&fs_info->block_group_cache, bg->key.objectid,
+				bg->key.objectid + bg->key.offset - 1,
+				BLOCK_GROUP_DIRTY);
+	return 0;
+}
+
 static int write_one_skinny_block_group(struct btrfs_trans_handle *trans,
 					struct btrfs_path *path,
 					struct btrfs_block_group_cache *cache)
diff --git a/mkfs/common.c b/mkfs/common.c
index 469b88d6a8d3..161c2aa5ca47 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -112,6 +112,9 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	return ret;
 }
 
+/* These features will not be set in the temporary fs */
+#define MASKED_FEATURES		(~(BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE))
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -205,7 +208,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
 	btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
+	btrfs_set_super_incompat_flags(&super, cfg->features & MASKED_FEATURES);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 1a4578412b41..9edeb82ee70c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1344,6 +1344,31 @@ raid_groups:
 		goto out;
 	}
 
+	/*
+	 * Bg tree are converted after temp chunks cleaned up, or we can
+	 * populate temp chunks.
+	 */
+	if (mkfs_cfg.features & BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE) {
+		trans = btrfs_start_transaction(fs_info->tree_root, 1);
+		if (IS_ERR(trans)) {
+			error("failed to start transaction: %d", ret);
+			goto out;
+		}
+		ret = btrfs_convert_to_skinny_bg_tree(trans);
+		if (ret < 0) {
+			errno = -ret;
+			error(
+		"bg-tree feature will not be enabled, due to error: %m");
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+		ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+		if (ret < 0) {
+			error("failed to commit transaction: %d", ret);
+			goto out;
+		}
+	}
+
 	if (source_dir_set) {
 		ret = btrfs_mkfs_fill_dir(source_dir, root, verbose);
 		if (ret) {
diff --git a/transaction.c b/transaction.c
index 45bb9e1f9de6..5de967fb015f 100644
--- a/transaction.c
+++ b/transaction.c
@@ -225,6 +225,7 @@ commit_tree:
 	root->commit_root = NULL;
 	fs_info->running_transaction = NULL;
 	fs_info->last_trans_committed = transid;
+	fs_info->convert_to_bg_tree = 0;
 	list_for_each_entry(sinfo, &fs_info->space_info, list) {
 		if (sinfo->bytes_reserved) {
 			warning(
-- 
2.23.0

