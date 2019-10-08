Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B319CF4CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfJHIQ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 04:16:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730410AbfJHIQ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 04:16:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4CDBAE09
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 08:16:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2.1 4/7] btrfs-progs: mkfs: Introduce -O bg-tree
Date:   Tue,  8 Oct 2019 16:16:50 +0800
Message-Id: <20191008081650.11341-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044936.157873-5-wqu@suse.com>
References: <20191008044936.157873-5-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This allow mkfs.btrfs to create a btrfs with bg-tree feature.

This patch introduce a global function, btrfs_convert_to_bg_tree() in
extent-tree.c, to do the work.

The workflow is pretty simple:
- Create a new tree block for bg tree
- Set the BG_TREE feature for superblock
- Set the fs_info->convert_to_bg_tree flag
- Mark all block group items as dirty
- Commit transaction
  * With fs_info->convert_to_bg_tree set, we will try to delete the
    BLOCK_GROUP_ITEM in extent tree first, then write the new
    BLOCK_GROUP_ITEM into bg tree.

This btrfs_convert_to_bg_tree() will be used in mkfs after the basic fs
is created.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2.1->v2:
- Convert to bg tree after cleaning up temp chunks
  Exposed by btrfs/157 where a test case grep doesn't work as intented,
  due to SINGLE chunks.
---
 common/fsfeatures.c |  6 ++++++
 ctree.h             |  1 +
 extent-tree.c       | 38 ++++++++++++++++++++++++++++++++++++++
 mkfs/common.c       |  6 ++++--
 mkfs/main.c         | 25 +++++++++++++++++++++++++
 transaction.c       |  1 +
 6 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 50934bd161b0..b9bd70a4b3b6 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -86,6 +86,12 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
+	{ "bg-tree", BTRFS_FEATURE_INCOMPAT_BG_TREE,
+		"bg_tree",
+		VERSION_TO_STRING2(5, 0),
+		NULL, 0,
+		NULL, 0,
+		"store block group items in dedicated tree" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/ctree.h b/ctree.h
index c2a18c8ab72f..3d3992487a53 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2856,5 +2856,6 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 
 /* extent-tree.c */
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long nr);
+int btrfs_convert_to_bg_tree(struct btrfs_trans_handle *trans);
 
 #endif
diff --git a/extent-tree.c b/extent-tree.c
index cb3d7a1add0f..87550ef80e37 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1524,6 +1524,44 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, record_parent, 0);
 }
 
+int btrfs_convert_to_bg_tree(struct btrfs_trans_handle *trans)
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
+
+	/* set BG_TREE feature and mark the fs into bg_tree convert status */
+	btrfs_set_super_incompat_flags(fs_info->super_copy,
+			features | BTRFS_FEATURE_INCOMPAT_BG_TREE);
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
 static int write_one_cache_group(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 struct btrfs_block_group_cache *cache)
diff --git a/mkfs/common.c b/mkfs/common.c
index caca5e707233..876193838612 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -111,6 +111,9 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	return ret;
 }
 
+/* These features will not be set in the temporary fs */
+#define MASKED_FEATURES		(~(BTRFS_FEATURE_INCOMPAT_BG_TREE))
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -204,7 +207,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_csum_type(&super, BTRFS_CSUM_TYPE_CRC32);
 	btrfs_set_super_chunk_root_generation(&super, 1);
 	btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
+	btrfs_set_super_incompat_flags(&super, cfg->features & MASKED_FEATURES);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
@@ -824,4 +827,3 @@ int test_minimum_size(const char *file, u64 min_dev_size)
 	return 0;
 }
 
-
diff --git a/mkfs/main.c b/mkfs/main.c
index b752da13aba9..55bc4288dc08 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1312,6 +1312,31 @@ raid_groups:
 		goto out;
 	}
 
+	/*
+	 * Bg tree are converted after temp chunks cleaned up, or we can
+	 * populate temp chunks.
+	 */
+	if (mkfs_cfg.features & BTRFS_FEATURE_INCOMPAT_BG_TREE) {
+		trans = btrfs_start_transaction(fs_info->tree_root, 1);
+		if (IS_ERR(trans)) {
+			error("failed to start transaction: %d", ret);
+			goto out;
+		}
+		ret = btrfs_convert_to_bg_tree(trans);
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

