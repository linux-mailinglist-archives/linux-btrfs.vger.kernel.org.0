Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E076F4469B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhKEUbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhKEUbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CAC061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:59 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c12so3647189qtd.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E6yEQEdbOHBTviKPAsYuUVGibr6c961wnTpwLhfcQ0k=;
        b=nqrdztfZlWvkUIf2UPdmmpRbEBO/7LqJL/tZG2NylHscNy2ZqGT12RXGlVK+sFy7NW
         QDZ4umpGM8jeet2A4//LTPRLJ+3yA54ujb6aOqnxxJ7qE2aQrRoi/m6TJQDqGJ6/OtZh
         PBezmL8JA+nPq9XqdvPmffFYm7wP7LdruSlOoJGh8TmZoBDKfws6YoxgmTzlJDOZBOHM
         hyDrETTeP3kfLN1bKj3iv/YPLmXbUZvyBvigrjyYoEt1xHxVZkC1K5kYzY5+vNfILldx
         5uEx44kD/yzcxafB6vYjNd1MNjXNApSItM1OvkLaCIYOoE4bh7xXiN1qORjI8SZjIQf0
         B8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6yEQEdbOHBTviKPAsYuUVGibr6c961wnTpwLhfcQ0k=;
        b=fiZQZbZXwKE/uSeP5UXmY42+4YGq0xK+7kYNNxgMSayHxj/tNQgHH+QPDxnF2OOD5N
         hlZMU/ceV3Q0cQJMPyNRewAoCJdqOKWMyxi3J34TSNPddjiIgUG+f/3b2x0/o9ALfg0r
         CaL3QAgv504NlXm4BENRfz+YrGNrtFWHAnFUbrkPm8Jau1GZ9cQf6OIfJpaBXJSAqsNi
         hZ4XrJidftjSr1OAfOOJocCcOLLhTBnk9htqaYGZl7VyZId0bprdhwrWdrVUuYoI1Yau
         Hsf432l2DPJ2QjkSFTeYdoZHtOi3bUY7LDPHanjIL3q5OIsFL4+KI6YLUjG4rO646+iN
         MvfQ==
X-Gm-Message-State: AOAM533Ybx/g/PolARgAR6tRFrAt7ZAShxRwtV6zy4+iNgQRo4vdsIfK
        Kzok9/BKn7eU8qd7iZmaANhli40x5Rpchw==
X-Google-Smtp-Source: ABdhPJwJTN3zW3r2WDUNWyzmY9Udf8/cqFzWz6icqglMU3c/DQYAHb/mF3Y//IMB1H6lgDnu+wkbpw==
X-Received: by 2002:ac8:5a91:: with SMTP id c17mr43445775qtc.229.1636144137804;
        Fri, 05 Nov 2021 13:28:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q4sm6610180qtw.19.2021.11.05.13.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/20] btrfs-progs: stop accessing ->csum_root directly
Date:   Fri,  5 Nov 2021 16:28:32 -0400
Message-Id: <9785c0745f91699cb45ab398d6a32b44645ace39.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 we will have per-block group checksums, so add a
helper to access the csum root and rename the fs_info csum_root to
_csum_root to catch all the places that are accessing it directly.
Convert everybody to use the helper except for internal things.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c       |  2 +-
 check/main.c                | 15 ++++++++++-----
 check/mode-common.c         |  6 +++---
 cmds/rescue-chunk-recover.c | 17 ++++++++---------
 kernel-shared/ctree.h       |  2 +-
 kernel-shared/disk-io.c     | 28 +++++++++++++++++-----------
 kernel-shared/disk-io.h     |  2 +-
 kernel-shared/file-item.c   |  4 ++--
 mkfs/main.c                 |  3 ++-
 9 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index c1624ee1..d7904b6f 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -1031,7 +1031,7 @@ static int delete_csum(struct btrfs_root *root, u64 bytenr, u64 bytes)
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	root = root->fs_info->csum_root;
+	root = btrfs_csum_root(root->fs_info, bytenr);
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		fprintf(stderr, "Couldn't start transaction %ld\n",
diff --git a/check/main.c b/check/main.c
index 22306cf4..632dfba0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5988,7 +5988,7 @@ static int check_csums(struct btrfs_root *root)
 	unsigned long leaf_offset;
 	bool verify_csum = !!check_data_csum;
 
-	root = gfs_info->csum_root;
+	root = btrfs_csum_root(gfs_info, 0);
 	if (!extent_buffer_uptodate(root->node)) {
 		fprintf(stderr, "No valid csum tree found\n");
 		return -ENOENT;
@@ -9496,7 +9496,7 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 					   struct btrfs_root *cur_root)
 {
-	struct btrfs_root *csum_root = gfs_info->csum_root;
+	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_key key;
 	struct extent_buffer *node;
@@ -9532,6 +9532,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 		start = btrfs_file_extent_disk_bytenr(node, fi);
 		len = btrfs_file_extent_disk_num_bytes(node, fi);
 
+		csum_root = btrfs_csum_root(gfs_info, start);
 		ret = populate_csum(trans, csum_root, buf, start, len);
 		if (ret == -EEXIST)
 			ret = 0;
@@ -9618,7 +9619,7 @@ out:
 static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_root *extent_root = gfs_info->extent_root;
-	struct btrfs_root *csum_root = gfs_info->csum_root;
+	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
 	struct extent_buffer *leaf;
@@ -9668,6 +9669,7 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 			continue;
 		}
 
+		csum_root = btrfs_csum_root(gfs_info, key.objectid);
 		ret = populate_csum(trans, csum_root, buf, key.objectid,
 				    key.offset);
 		if (ret)
@@ -10688,7 +10690,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 
 		if (init_csum_tree) {
 			printf("Reinitialize checksum tree\n");
-			ret = btrfs_fsck_reinit_root(trans, gfs_info->csum_root);
+			ret = btrfs_fsck_reinit_root(trans,
+						btrfs_csum_root(gfs_info, 0));
 			if (ret) {
 				error("checksum tree initialization failed: %d",
 						ret);
@@ -10719,7 +10722,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		err |= !!ret;
 		goto close_out;
 	}
-	if (!extent_buffer_uptodate(gfs_info->csum_root->node)) {
+
+	root = btrfs_csum_root(gfs_info, 0);
+	if (!extent_buffer_uptodate(root->node)) {
 		error("critical: csum_root, unable to check the filesystem");
 		ret = -EIO;
 		err |= !!ret;
diff --git a/check/mode-common.c b/check/mode-common.c
index 0059672c..0c3bd38b 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -287,6 +287,7 @@ out:
  */
 int count_csum_range(u64 start, u64 len, u64 *found)
 {
+	struct btrfs_root *csum_root = btrfs_csum_root(gfs_info, start);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
@@ -302,8 +303,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 	key.offset = start;
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 
-	ret = btrfs_search_slot(NULL, gfs_info->csum_root,
-				&key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
 	if (ret < 0)
 		goto out;
 	if (ret > 0 && path.slots[0] > 0) {
@@ -317,7 +317,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 	while (len > 0) {
 		leaf = path.nodes[0];
 		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(gfs_info->csum_root, &path);
+			ret = btrfs_next_leaf(csum_root, &path);
 			if (ret > 0)
 				break;
 			else if (ret < 0)
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 03c7f48f..115d91d7 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1801,7 +1801,7 @@ static int btrfs_rebuild_chunk_stripes(struct recover_control *rc,
 	return ret;
 }
 
-static int next_csum(struct btrfs_root *root,
+static int next_csum(struct btrfs_root *csum_root,
 		     struct extent_buffer **leaf,
 		     struct btrfs_path *path,
 		     int *slot,
@@ -1811,10 +1811,9 @@ static int next_csum(struct btrfs_root *root,
 		     struct btrfs_key *key)
 {
 	int ret = 0;
-	struct btrfs_root *csum_root = root->fs_info->csum_root;
 	struct btrfs_csum_item *csum_item;
-	u32 blocksize = root->fs_info->sectorsize;
-	u16 csum_size = btrfs_super_csum_size(root->fs_info->super_copy);
+	u32 blocksize = csum_root->fs_info->sectorsize;
+	u16 csum_size = btrfs_super_csum_size(csum_root->fs_info->super_copy);
 	int csums_in_item = btrfs_item_size_nr(*leaf, *slot) / csum_size;
 
 	if (*csum_offset >= csums_in_item) {
@@ -1994,7 +1993,6 @@ static int rebuild_raid_data_chunk_stripes(struct recover_control *rc,
 	LIST_HEAD(unordered);
 	LIST_HEAD(candidates);
 
-	csum_root = root->fs_info->csum_root;
 	btrfs_init_path(&path);
 	list_splice_init(&chunk->dextents, &candidates);
 again:
@@ -2005,6 +2003,7 @@ again:
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 	key.offset = start;
 
+	csum_root = btrfs_csum_root(root->fs_info, start);
 	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		fprintf(stderr, "Search csum failed(%d)\n", ret);
@@ -2022,8 +2021,8 @@ again:
 			} else if (ret > 0) {
 				slot = btrfs_header_nritems(leaf) - 1;
 				btrfs_item_key_to_cpu(leaf, &key, slot);
-				if (item_end_offset(root, &key, leaf, slot)
-								> start) {
+				if (item_end_offset(csum_root, &key,
+						    leaf, slot) > start) {
 					csum_offset = start - key.offset;
 					csum_offset /= blocksize;
 					goto next_csum;
@@ -2061,8 +2060,8 @@ again:
 			goto out;
 	}
 next_csum:
-	ret = next_csum(root, &leaf, &path, &slot, &csum_offset, &tree_csum,
-			end, &key);
+	ret = next_csum(csum_root, &leaf, &path, &slot, &csum_offset,
+			&tree_csum, end, &key);
 	if (ret < 0) {
 		fprintf(stderr, "Fetch csum failed\n");
 		goto fail_out;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 73904255..d2d1a006 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1161,7 +1161,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	struct btrfs_root *dev_root;
-	struct btrfs_root *csum_root;
+	struct btrfs_root *_csum_root;
 	struct btrfs_root *quota_root;
 	struct btrfs_root *free_space_root;
 	struct btrfs_root *uuid_root;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 1f940221..c1d55692 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -744,6 +744,12 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2)
 	return btrfs_fs_roots_compare_objectids(node1, (void *)&root->objectid);
 }
 
+struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
+				   u64 bytenr)
+{
+	return fs_info->_csum_root;
+}
+
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 				      struct btrfs_key *location)
 {
@@ -761,7 +767,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
 		return fs_info->dev_root;
 	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return fs_info->csum_root;
+		return btrfs_csum_root(fs_info, location->offset);
 	if (location->objectid == BTRFS_UUID_TREE_OBJECTID)
 		return fs_info->uuid_root ? fs_info->uuid_root : ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_QUOTA_TREE_OBJECTID)
@@ -797,7 +803,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	free(fs_info->extent_root);
 	free(fs_info->chunk_root);
 	free(fs_info->dev_root);
-	free(fs_info->csum_root);
+	free(fs_info->_csum_root);
 	free(fs_info->free_space_root);
 	free(fs_info->uuid_root);
 	free(fs_info->super_copy);
@@ -817,7 +823,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->extent_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->chunk_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
-	fs_info->csum_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->_csum_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->free_space_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
@@ -825,7 +831,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 
 	if (!fs_info->tree_root || !fs_info->extent_root ||
 	    !fs_info->chunk_root || !fs_info->dev_root ||
-	    !fs_info->csum_root || !fs_info->quota_root ||
+	    !fs_info->_csum_root || !fs_info->quota_root ||
 	    !fs_info->free_space_root || !fs_info->uuid_root ||
 	    !fs_info->super_copy)
 		goto free_all;
@@ -993,11 +999,11 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	}
 	fs_info->dev_root->track_dirty = 1;
 
-	ret = setup_root_or_create_block(fs_info, flags, fs_info->csum_root,
+	ret = setup_root_or_create_block(fs_info, flags, fs_info->_csum_root,
 					 BTRFS_CSUM_TREE_OBJECTID, "csum");
 	if (ret)
 		return ret;
-	fs_info->csum_root->track_dirty = 1;
+	fs_info->_csum_root->track_dirty = 1;
 
 	ret = find_and_setup_root(root, fs_info, BTRFS_UUID_TREE_OBJECTID,
 				  fs_info->uuid_root);
@@ -1072,8 +1078,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->free_space_root->node);
 	if (fs_info->quota_root)
 		free_extent_buffer(fs_info->quota_root->node);
-	if (fs_info->csum_root)
-		free_extent_buffer(fs_info->csum_root->node);
+	if (fs_info->_csum_root)
+		free_extent_buffer(fs_info->_csum_root->node);
 	if (fs_info->dev_root)
 		free_extent_buffer(fs_info->dev_root->node);
 	if (fs_info->extent_root)
@@ -1854,11 +1860,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_dev_root_level(root_backup,
 				       btrfs_header_level(info->dev_root->node));
 
-	btrfs_set_backup_csum_root(root_backup, info->csum_root->node->start);
+	btrfs_set_backup_csum_root(root_backup, info->_csum_root->node->start);
 	btrfs_set_backup_csum_root_gen(root_backup,
-			       btrfs_header_generation(info->csum_root->node));
+			       btrfs_header_generation(info->_csum_root->node));
 	btrfs_set_backup_csum_root_level(root_backup,
-			       btrfs_header_level(info->csum_root->node));
+			       btrfs_header_level(info->_csum_root->node));
 
 	btrfs_set_backup_total_bytes(root_backup,
 			     btrfs_super_total_bytes(info->super_copy));
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index e113d842..38abbca5 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -217,5 +217,5 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     u64 objectid);
-
+struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 #endif
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 5bf6aab4..12932e1d 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -185,7 +185,7 @@ fail:
 int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 			  u64 alloc_end, u64 bytenr, char *data, size_t len)
 {
-	struct btrfs_root *root = trans->fs_info->csum_root;
+	struct btrfs_root *root = btrfs_csum_root(trans->fs_info, bytenr);
 	int ret = 0;
 	struct btrfs_key file_key;
 	struct btrfs_key found_key;
@@ -401,7 +401,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 	int ret;
 	u16 csum_size = btrfs_super_csum_size(trans->fs_info->super_copy);
 	int blocksize = trans->fs_info->sectorsize;
-	struct btrfs_root *csum_root = trans->fs_info->csum_root;
+	struct btrfs_root *csum_root = btrfs_csum_root(trans->fs_info, bytenr);
 
 
 	path = btrfs_alloc_path();
diff --git a/mkfs/main.c b/mkfs/main.c
index ce86a0db..c6cc51e9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -268,6 +268,7 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *info = root->fs_info;
+	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 	int ret;
 
 	ret = __recow_root(trans, info->fs_root);
@@ -285,7 +286,7 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, info->dev_root);
 	if (ret)
 		return ret;
-	ret = __recow_root(trans, info->csum_root);
+	ret = __recow_root(trans, csum_root);
 	if (ret)
 		return ret;
 	if (info->free_space_root) {
-- 
2.26.3

