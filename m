Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE10D2D46
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfJJPGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:06:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfJJPGw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DF20B1A8;
        Thu, 10 Oct 2019 15:06:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Factor out tree roots initialization during mount
Date:   Thu, 10 Oct 2019 18:06:45 +0300
Message-Id: <20191010150647.20940-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010150647.20940-1-nborisov@suse.com>
References: <20191010150647.20940-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The code responsible for reading and initilizing tree roots is
scattered in open_ctree among 2 labels, emulating a loop. This is rather
confusing to reason about. Instead, factor the code in a new function,
init_tree_roots which implements the same logical flow.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 136 ++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2c3fa89702e7..b850988023aa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2553,6 +2553,82 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
+{
+
+	bool should_retry = btrfs_test_opt(fs_info, USEBACKUPROOT);
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	u64 generation;
+	int level;
+	bool handle_error = false;
+	int num_backups_tried = 0;
+	int backup_index = 0;
+	int ret = 0;
+
+	while (true) {
+		if (handle_error) {
+			if (!IS_ERR(tree_root->node))
+				free_extent_buffer(tree_root->node);
+			tree_root->node = NULL;
+
+			if (!should_retry) {
+				break;
+			}
+			free_root_pointers(fs_info, 0);
+
+			/* don't use the log in recovery mode, it won't be valid */
+			btrfs_set_super_log_root(sb, 0);
+
+			/* we can't trust the free space cache either */
+			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
+
+			ret = next_root_backup(fs_info, sb, &num_backups_tried,
+					       &backup_index);
+			if (ret == -1)
+				return -ESPIPE;
+		}
+		generation = btrfs_super_generation(sb);
+		level = btrfs_super_root_level(sb);
+		tree_root->node = read_tree_block(fs_info, btrfs_super_root(sb),
+						  generation, level, NULL);
+		if (IS_ERR(tree_root->node) ||
+		    !extent_buffer_uptodate(tree_root->node)) {
+			handle_error = true;
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
+		if (ret) {
+			mutex_unlock(&tree_root->objectid_mutex);
+			handle_error = true;
+			continue;
+		}
+
+		ASSERT(tree_root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
+		mutex_unlock(&tree_root->objectid_mutex);
+
+		ret = btrfs_read_roots(fs_info);
+		if (ret) {
+			handle_error = true;
+			continue;
+		}
+
+		fs_info->generation = generation;
+		fs_info->last_trans_committed = generation;
+		break;
+	}
+
+	return ret;
+}
+
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options)
@@ -2571,8 +2647,6 @@ int __cold open_ctree(struct super_block *sb,
 	struct btrfs_root *chunk_root;
 	int ret;
 	int err = -EINVAL;
-	int num_backups_tried = 0;
-	int backup_index = 0;
 	int clear_free_space_tree = 0;
 	int level;
 
@@ -2995,45 +3069,13 @@ int __cold open_ctree(struct super_block *sb,
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
+	ret = init_tree_roots(fs_info);
 	if (ret) {
-		mutex_unlock(&tree_root->objectid_mutex);
-		goto recovery_tree_root;
+		if (ret == -ESPIPE)
+			goto fail_block_groups;
+		goto fail_tree_roots;
 	}
 
-	ASSERT(tree_root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
-
-	mutex_unlock(&tree_root->objectid_mutex);
-
-	ret = btrfs_read_roots(fs_info);
-	if (ret)
-		goto recovery_tree_root;
-
-	fs_info->generation = generation;
-	fs_info->last_trans_committed = generation;
-
 	ret = btrfs_verify_dev_extents(fs_info);
 	if (ret) {
 		btrfs_err(fs_info,
@@ -3327,24 +3369,6 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_close_devices(fs_info->fs_devices);
 	return err;
-
-recovery_tree_root:
-	if (!btrfs_test_opt(fs_info, USEBACKUPROOT))
-		goto fail_tree_roots;
-
-	free_root_pointers(fs_info, 0);
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

