Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6EED7A09
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfJOPmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729578AbfJOPmb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA350B51A;
        Tue, 15 Oct 2019 15:42:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/8] btrfs: Factor out tree roots initialization during mount
Date:   Tue, 15 Oct 2019 18:42:20 +0300
Message-Id: <20191015154224.21537-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The code responsible for reading and initilizing tree roots is
scattered in open_ctree among 2 labels, emulating a loop. This is rather
confusing to reason about. Instead, factor the code in a new function,
init_tree_roots which implements the same logical flow.

There are a couple of notable differences, namely:

* Instead of using next_backup_root it's using the newly introduced
  read_backup_root.

* If read_backup_root returns an error init_tree_roots propagates the
  error and there is no special handling of that case e.g. the code jumps
  straight to 'fail_tree_roots' label. The old code, however, was
  (erroneously) jumping to 'fail_block_groups' label if next_backup_root
  did fail, this was unnecessary since the tree roots init logic doesn't
  modify the state of block groups.
---
 fs/btrfs/disk-io.c | 140 +++++++++++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9ed3b40aa10d..a82e3acca765 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2581,6 +2581,87 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	bool handle_error = false;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
+		u64 generation;
+		int level;
+
+		if (handle_error) {
+			if (!IS_ERR(tree_root->node))
+				free_extent_buffer(tree_root->node);
+			tree_root->node = NULL;
+
+			if (!btrfs_test_opt(fs_info, USEBACKUPROOT))
+				break;
+
+			free_root_pointers(fs_info, 0);
+
+			/* don't use the log in recovery mode, it won't be valid */
+			btrfs_set_super_log_root(sb, 0);
+
+			/* we can't trust the free space cache either */
+			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
+
+			ret = read_backup_root(fs_info, i);
+			if (ret < 0)
+				return ret;
+		}
+		generation = btrfs_super_generation(sb);
+		level = btrfs_super_root_level(sb);
+		tree_root->node = read_tree_block(fs_info, btrfs_super_root(sb),
+						  generation, level, NULL);
+		if (IS_ERR(tree_root->node) ||
+		    !extent_buffer_uptodate(tree_root->node)) {
+			handle_error = true;
+
+			if (IS_ERR(tree_root->node))
+				ret = PTR_ERR(tree_root->node);
+			else if (!extent_buffer_uptodate(tree_root->node))
+				ret = -EUCLEAN;
+
+			btrfs_warn(fs_info, "failed to read tree root");
+			continue;
+		}
+
+		btrfs_set_root_node(&tree_root->root_item, tree_root->node);
+		tree_root->commit_root = btrfs_root_node(tree_root);
+		btrfs_set_root_refs(&tree_root->root_item, 1);
+
+		mutex_lock(&tree_root->objectid_mutex);
+		ret = btrfs_find_highest_objectid(tree_root,
+						&tree_root->highest_objectid);
+		if (ret < 0) {
+			mutex_unlock(&tree_root->objectid_mutex);
+			handle_error = true;
+			continue;
+		}
+
+		ASSERT(tree_root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
+		mutex_unlock(&tree_root->objectid_mutex);
+
+		ret = btrfs_read_roots(fs_info);
+		if (ret < 0) {
+			handle_error = true;
+			continue;
+		}
+
+		/* All successful */
+		fs_info->generation = generation;
+		fs_info->last_trans_committed = generation;
+		break;
+
+	}
+
+	return ret;
+}
+
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options)
@@ -2599,8 +2680,6 @@ int __cold open_ctree(struct super_block *sb,
 	struct btrfs_root *chunk_root;
 	int ret;
 	int err = -EINVAL;
-	int num_backups_tried = 0;
-	int backup_index = 0;
 	int clear_free_space_tree = 0;
 	int level;
 
@@ -3022,44 +3101,9 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_tree_roots;
 	}
 
-retry_root_backup:
-	generation = btrfs_super_generation(disk_super);
-	level = btrfs_super_root_level(disk_super);
-
-	tree_root->node = read_tree_block(fs_info,
-					  btrfs_super_root(disk_super),
-					  generation, level, NULL);
-	if (IS_ERR(tree_root->node) ||
-	    !extent_buffer_uptodate(tree_root->node)) {
-		btrfs_warn(fs_info, "failed to read tree root");
-		if (!IS_ERR(tree_root->node))
-			free_extent_buffer(tree_root->node);
-		tree_root->node = NULL;
-		goto recovery_tree_root;
-	}
-
-	btrfs_set_root_node(&tree_root->root_item, tree_root->node);
-	tree_root->commit_root = btrfs_root_node(tree_root);
-	btrfs_set_root_refs(&tree_root->root_item, 1);
-
-	mutex_lock(&tree_root->objectid_mutex);
-	ret = btrfs_find_highest_objectid(tree_root,
-					&tree_root->highest_objectid);
-	if (ret) {
-		mutex_unlock(&tree_root->objectid_mutex);
-		goto recovery_tree_root;
-	}
-
-	ASSERT(tree_root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
-
-	mutex_unlock(&tree_root->objectid_mutex);
-
-	ret = btrfs_read_roots(fs_info);
+	ret = init_tree_roots(fs_info);
 	if (ret)
-		goto recovery_tree_root;
-
-	fs_info->generation = generation;
-	fs_info->last_trans_committed = generation;
+		goto fail_tree_roots;
 
 	ret = btrfs_verify_dev_extents(fs_info);
 	if (ret) {
@@ -3354,24 +3398,6 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_close_devices(fs_info->fs_devices);
 	return err;
-
-recovery_tree_root:
-	if (!btrfs_test_opt(fs_info, USEBACKUPROOT))
-		goto fail_tree_roots;
-
-	free_root_pointers(fs_info, false);
-
-	/* don't use the log in recovery mode, it won't be valid */
-	btrfs_set_super_log_root(disk_super, 0);
-
-	/* we can't trust the free space cache either */
-	btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
-
-	ret = next_root_backup(fs_info, fs_info->super_copy,
-			       &num_backups_tried, &backup_index);
-	if (ret == -1)
-		goto fail_block_groups;
-	goto retry_root_backup;
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
-- 
2.17.1

