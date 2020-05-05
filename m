Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A71C4ADB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgEEAC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgEEACz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 129B4AF01
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 11/11] btrfs-progs: btrfstune: Allow user to rollback to regular extent tree
Date:   Tue,  5 May 2020 08:02:30 +0800
Message-Id: <20200505000230.4454-12-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the skinny bg tree will not be supported on older kernel, some
testers may want to roll back to regular extent tree so that they can
use real-world data to test this feature.

So add such rollback ability to do provide a much wider test coverage
while still allow testers to enjoy their old data on older kernels.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfstune.asciidoc |   4 ++
 btrfstune.c                      |  21 +++++-
 ctree.h                          |   2 +
 extent-tree.c                    | 119 +++++++++++++++++++++++++++++++
 root-tree.c                      |   6 +-
 transaction.c                    |   1 +
 6 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfstune.asciidoc b/Documentation/btrfstune.asciidoc
index 9726cef02929..ca76b077cba6 100644
--- a/Documentation/btrfstune.asciidoc
+++ b/Documentation/btrfstune.asciidoc
@@ -32,6 +32,10 @@ OPTIONS
 enable skinny-bg-tree feature (faster mount time for large fs), enabled by mkfs
 feature 'skinny-bg-tree'.
 
+-B::
++
+disable skinny-bg-tree feature.
+
 -f::
 Allow dangerous changes, e.g. clear the seeding flag or change fsid. Make sure
 that you are aware of the dangers.
diff --git a/btrfstune.c b/btrfstune.c
index 8926dd38798c..6595b0fef32e 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -478,6 +478,7 @@ static void print_usage(void)
 	printf("\t-M UUID     change fsid in metadata_uuid to UUID\n");
 	printf("\t-b          enable skinny-bg-tree feature (mkfs: skinny-bg-tree)");
 	printf("\t            for faster mount time\n");
+	printf("\t-B          disable skinny-bg-tree feature");
 	printf("  general:\n");
 	printf("\t-f          allow dangerous operations, make sure that you are aware of the dangers\n");
 	printf("\t--help      print this help\n");
@@ -488,6 +489,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	struct btrfs_root *root;
 	unsigned ctree_flags = OPEN_CTREE_WRITES;
 	bool to_skinny_bg_tree = false;
+	bool to_extent_tree = false;
 	int success = 0;
 	int total = 0;
 	int seeding_flag = 0;
@@ -504,7 +506,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options,
+		int c = getopt_long(argc, argv, "S:rxfuU:nmM:bB", long_options,
 				    NULL);
 
 		if (c < 0)
@@ -546,6 +548,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case 'b':
 			to_skinny_bg_tree = true;
 			break;
+		case 'B':
+			to_extent_tree = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			print_usage();
@@ -563,11 +568,15 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
-	    !change_metadata_uuid && !to_skinny_bg_tree) {
+	    !change_metadata_uuid && !to_skinny_bg_tree && !to_extent_tree) {
 		error("at least one option should be specified");
 		print_usage();
 		return 1;
 	}
+	if (to_extent_tree && to_skinny_bg_tree) {
+		error("'-b' and '-B' conflict with each other");
+		return 1;
+	}
 
 	if (new_fsid_str) {
 		uuid_t tmp;
@@ -617,6 +626,14 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			goto out;
 		}
 	}
+	if (to_extent_tree) {
+		ret = btrfs_convert_to_extent_tree(root->fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to disable bg-tree feature: %m");
+			goto out;
+		}
+	}
 	if (seeding_flag) {
 		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
 			fprintf(stderr, "SEED flag cannot be changed on a metadata-uuid changed fs\n");
diff --git a/ctree.h b/ctree.h
index a84237a06609..acae74a93833 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1206,6 +1206,7 @@ struct btrfs_fs_info {
 	unsigned int finalize_on_close:1;
 	unsigned int hide_names:1;
 	unsigned int convert_to_skinny_bg_tree:1;
+	unsigned int convert_to_extent_tree:1;
 
 	int transaction_aborted;
 
@@ -2621,6 +2622,7 @@ u64 add_new_free_space(struct btrfs_block_group *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 int btrfs_convert_to_skinny_bg_tree(struct btrfs_fs_info *fs_info);
+int btrfs_convert_to_extent_tree(struct btrfs_fs_info *fs_info);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
diff --git a/extent-tree.c b/extent-tree.c
index b6ac7b4caa2f..df4c08ddc6f0 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1597,6 +1597,14 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 		btrfs_set_item_key_safe(fs_info->bg_root, path, &key);
 		return 0;
 	}
+	if (fs_info->convert_to_extent_tree) {
+		ret = insert_block_group_item(trans, cache);
+		if (ret == 0)
+			return ret;
+		if (ret < 0 && ret != -EEXIST)
+			goto fail;
+		/* -EEXIST case falls through */
+	}
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = cache->length;
@@ -4128,3 +4136,114 @@ error:
 	btrfs_abort_transaction(trans, ret);
 	return ret;
 }
+
+static int clear_bg_tree(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = fs_info->bg_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+	int nr;
+
+	btrfs_init_path(&path);
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	while (1) {
+		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
+		if (ret < 0)
+			goto out;
+		nr = btrfs_header_nritems(path.nodes[0]);
+		if (!nr)
+			break;
+		ret = btrfs_del_items(trans, root, &path, 0, nr);
+		if (ret < 0)
+			goto out;
+		btrfs_release_path(&path);
+	}
+	ret = 0;
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+int btrfs_convert_to_extent_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *bg_root = fs_info->bg_root;
+	struct btrfs_block_group *bg;
+	u64 features = btrfs_super_incompat_flags(fs_info->super_copy);
+	int ret;
+
+	if (bg_root == NULL) {
+		printf("The fs is not using skinny bg tree\n");
+		return 0;
+	}
+	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+
+	/*
+	 * Empty bg tree, but not delete it yet, as btrfs-progs doesn't have 
+	 * good root deletion routine.
+	 */
+	ret = clear_bg_tree(trans);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to delete bg tree: %m");
+		goto error;
+	}
+	/* Clear SKINNY_BG_FEATURE and set convert status */
+	btrfs_set_super_incompat_flags(fs_info->super_copy,
+			features & ~BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE);
+	fs_info->convert_to_extent_tree = 1;
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
+	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+
+	/* Now cleanup the eb used by bg tree and delete it */
+	ret = btrfs_free_tree_block(trans, bg_root, bg_root->node, 0, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to free bg tree root node: %m");
+		goto error;
+	}
+	free_extent_buffer(bg_root->node);
+	ret = btrfs_del_root(trans, fs_info->tree_root, &bg_root->root_key);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to delete bg root: %m");
+		goto error;
+	}
+	free(bg_root);
+	fs_info->bg_root = NULL;
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	return ret;
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/root-tree.c b/root-tree.c
index 6b8f8c1ce6c5..e39fe15fdd8e 100644
--- a/root-tree.c
+++ b/root-tree.c
@@ -83,7 +83,11 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret != 0);
+	/* The root has been deleted */
+	if (ret > 0) {
+		ret = 0;
+		goto out;
+	}
 	l = path->nodes[0];
 	slot = path->slots[0];
 	ptr = btrfs_item_ptr_offset(l, slot);
diff --git a/transaction.c b/transaction.c
index 4a00ff08d45a..b5f33e0900d4 100644
--- a/transaction.c
+++ b/transaction.c
@@ -227,6 +227,7 @@ commit_tree:
 	fs_info->running_transaction = NULL;
 	fs_info->last_trans_committed = transid;
 	fs_info->convert_to_skinny_bg_tree = 0;
+	fs_info->convert_to_extent_tree = 0;
 	list_for_each_entry(sinfo, &fs_info->space_info, list) {
 		if (sinfo->bytes_reserved) {
 			warning(
-- 
2.26.2

