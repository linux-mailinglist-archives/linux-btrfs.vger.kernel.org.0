Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F504469BD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhKEUbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhKEUbv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:51 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0206DC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id u7so8295195qtc.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dSmxO9gq8WoRy1fxQ8rM0sHU9hK7LIdbXq9TGkgIFsI=;
        b=OHQFo/C2+Sj6coFT28oPiQQ6OhT4IOV48d5NL3NPxLGhopZYsc7CvGUd3feoQE3s1Y
         pBMCF7kXwUQGirBhgxEj+YHiof2B5SqfyoX+IqeBlEYFhOemnlvL/HmJTwOaV007/soS
         9GdHNux95Hk12JU62LvEMVTWrNVyjz2zdW2NhwKUET6d72ugEK5LGd9iryT/xgwaEZ/K
         s2PkMsSR0kwV2w0XqmprB7tgqzqYnZ0pUPOYQgp0o2+/lftJo+EwcAbgL5vEp4dFPJMI
         DbG9oP74m/H045+VYcmxPT/2wsAo3h1m+cVKEYSgsVAYRTSuaTbztIlVuQqYnefz/Cix
         Y2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSmxO9gq8WoRy1fxQ8rM0sHU9hK7LIdbXq9TGkgIFsI=;
        b=JZWhXW/VHq+c+wStwFup4eUsF3Vml7SsBSk6ePPxFYPH37HDFd/johyGPVlsHPWxPw
         9+dU5T37CEh7H3EfSqnQfcF/uH35Zidu7vehvwvvPCVp2Wc8WtXqplgCiFZy1Kubn6JV
         JPsiKvoLup1L5D+AIoqb4cERTG0U+sYHrg7rG07qKz+oASu6kpWD/TkjICvbIlG2m7p0
         5f2z8fLZPJSyPNsR2/wDU3bpFnfDgD9cSj21C8f7vcf42pdvJEZ4PXcbG1HNa3AdRP+F
         RNU3Eu/TTRo8NEnZB8JfbbdTSU+8+4s+I1aD86PJyBuPpJ0BLLoAh3jDuQTSEzKtLjvi
         CDqQ==
X-Gm-Message-State: AOAM5323EpWw4Ui+fhSHg+r2wIkf/WhtDau59H/0VSLJNQSd0lYU+BF6
        4Df6X6HJ3ZMa/6z+zceaOFlcI1PGhrV18A==
X-Google-Smtp-Source: ABdhPJyuhgLaoZM+uQ+mjCBmfjJ6Hp7dJ5q+2cBPrTFxc2pTNxhlJ8IVIx++CITVrxgVLdcu9OG22A==
X-Received: by 2002:ac8:5e0a:: with SMTP id h10mr63133816qtx.195.1636144149813;
        Fri, 05 Nov 2021 13:29:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q4sm6610586qtw.19.2021.11.05.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/20] btrfs-progs: track csum, extent, and free space trees in a rb tree
Date:   Fri,  5 Nov 2021 16:28:40 -0400
Message-Id: <4eb4287b07486764adc2871343c6593c2a7cba75.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to have multiples of these trees with extent tree v2, so
add a rb tree to track them based on their root key value.  This works
for both v1 and v2, so we can remove the direct pointers to these roots
in our fs_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h           |   4 +-
 kernel-shared/disk-io.c         | 290 ++++++++++++++++++++++++--------
 kernel-shared/disk-io.h         |   5 +
 kernel-shared/free-space-tree.c |  15 +-
 mkfs/main.c                     |  28 +--
 5 files changed, 259 insertions(+), 83 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index c263a3bb..12a8165d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1157,15 +1157,13 @@ struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	u8 *new_chunk_tree_uuid;
 	struct btrfs_root *fs_root;
-	struct btrfs_root *_extent_root;
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	struct btrfs_root *dev_root;
-	struct btrfs_root *_csum_root;
 	struct btrfs_root *quota_root;
-	struct btrfs_root *_free_space_root;
 	struct btrfs_root *uuid_root;
 
+	struct rb_root global_roots_tree;
 	struct rb_root fs_root_tree;
 
 	/* the log root tree is a directory of all the other log roots */
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 0e803db8..981ac4f8 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -721,6 +721,23 @@ insert:
 	return root;
 }
 
+static int btrfs_global_roots_compare_keys(struct rb_node *node,
+					   void *data)
+{
+	struct btrfs_key *key = (struct btrfs_key *)data;
+	struct btrfs_root *root;
+
+	root = rb_entry(node, struct btrfs_root, rb_node);
+	return btrfs_comp_cpu_keys(key, &root->root_key);
+}
+
+static int btrfs_global_roots_compare(struct rb_node *node1,
+				      struct rb_node *node2)
+{
+	struct btrfs_root *root = rb_entry(node2, struct btrfs_root, rb_node);
+	return btrfs_global_roots_compare_keys(node1, &root->root_key);
+}
+
 static int btrfs_fs_roots_compare_objectids(struct rb_node *node,
 					    void *data)
 {
@@ -744,16 +761,54 @@ int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2)
 	return btrfs_fs_roots_compare_objectids(node1, (void *)&root->objectid);
 }
 
+int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
+			     struct btrfs_root *root)
+{
+	return rb_insert(&fs_info->global_roots_tree, &root->rb_node,
+			 btrfs_global_roots_compare);
+}
+
+struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
+				     struct btrfs_key *key)
+{
+	struct rb_node *node;
+
+	/*
+	 * Some callers use the key->offset = (u64)-1 convention for looking up
+	 * roots, so set this to 0 if we ended up here from that.
+	 */
+	if (key->offset == (u64)-1)
+		key->offset = 0;
+
+	node = rb_search(&fs_info->global_roots_tree, (void *)key,
+			 btrfs_global_roots_compare_keys, NULL);
+	if (node)
+		return rb_entry(node, struct btrfs_root, rb_node);
+	return NULL;
+}
+
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr)
 {
-	return fs_info->_csum_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_CSUM_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+	return btrfs_global_root(fs_info, &key);
 }
 
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
 				     u64 bytenr)
 {
-	return fs_info->_extent_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+	return btrfs_global_root(fs_info, &key);
 }
 
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
@@ -767,21 +822,22 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
 		return fs_info->tree_root;
 	if (location->objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return fs_info->_extent_root;
+		return btrfs_global_root(fs_info, location);
 	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
 		return fs_info->chunk_root;
 	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
 		return fs_info->dev_root;
 	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return btrfs_csum_root(fs_info, location->offset);
+		return btrfs_global_root(fs_info, location);
 	if (location->objectid == BTRFS_UUID_TREE_OBJECTID)
 		return fs_info->uuid_root ? fs_info->uuid_root : ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_QUOTA_TREE_OBJECTID)
 		return fs_info->quota_enabled ? fs_info->quota_root :
 				ERR_PTR(-ENOENT);
-	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return fs_info->_free_space_root ? fs_info->_free_space_root :
-						ERR_PTR(-ENOENT);
+	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
+		root = btrfs_global_root(fs_info, location);
+		return root ? root : ERR_PTR(-ENOENT);
+	}
 
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
@@ -800,17 +856,25 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 	return root;
 }
 
+static void __free_global_root(struct rb_node *node)
+{
+	struct btrfs_root *root;
+
+	root = rb_entry(node, struct btrfs_root, rb_node);
+	kfree(root);
+}
+
+FREE_RB_BASED_TREE(global_roots, __free_global_root);
+
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	if (fs_info->quota_root)
 		free(fs_info->quota_root);
 
+	free_global_roots_tree(&fs_info->global_roots_tree);
 	free(fs_info->tree_root);
-	free(fs_info->_extent_root);
 	free(fs_info->chunk_root);
 	free(fs_info->dev_root);
-	free(fs_info->_csum_root);
-	free(fs_info->_free_space_root);
 	free(fs_info->uuid_root);
 	free(fs_info->super_copy);
 	free(fs_info->log_root_tree);
@@ -826,20 +890,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 		return NULL;
 
 	fs_info->tree_root = calloc(1, sizeof(struct btrfs_root));
-	fs_info->_extent_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->chunk_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
-	fs_info->_csum_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
-	fs_info->_free_space_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
-	if (!fs_info->tree_root || !fs_info->_extent_root ||
-	    !fs_info->chunk_root || !fs_info->dev_root ||
-	    !fs_info->_csum_root || !fs_info->quota_root ||
-	    !fs_info->_free_space_root || !fs_info->uuid_root ||
-	    !fs_info->super_copy)
+	if (!fs_info->tree_root || !fs_info->chunk_root || !fs_info->dev_root ||
+	    !fs_info->quota_root || !fs_info->uuid_root || !fs_info->super_copy)
 		goto free_all;
 
 	extent_io_tree_init(&fs_info->extent_cache);
@@ -929,15 +987,13 @@ static int find_best_backup_root(struct btrfs_super_block *super)
 	return best_index;
 }
 
-static int setup_root_or_create_block(struct btrfs_fs_info *fs_info,
-				      unsigned flags,
-				      struct btrfs_root *info_root,
-				      u64 objectid, char *str)
+static int read_root_or_create_block(struct btrfs_fs_info *fs_info,
+				     struct btrfs_root *root, u64 bytenr,
+				     u64 gen, unsigned flags, char *str)
 {
-	struct btrfs_root *root = fs_info->tree_root;
 	int ret;
 
-	ret = find_and_setup_root(root, fs_info, objectid, info_root);
+	ret = read_root_node(fs_info, root, bytenr, gen);
 	if (ret) {
 		if (!(flags & OPEN_CTREE_PARTIAL)) {
 			error("could not setup %s tree", str);
@@ -948,16 +1004,127 @@ static int setup_root_or_create_block(struct btrfs_fs_info *fs_info,
 		 * Need a blank node here just so we don't screw up in the
 		 * million of places that assume a root has a valid ->node
 		 */
-		info_root->node =
-			btrfs_find_create_tree_block(fs_info, 0);
-		if (!info_root->node)
+		root->node = btrfs_find_create_tree_block(fs_info, 0);
+		if (!root->node)
 			return -ENOMEM;
-		clear_extent_buffer_uptodate(info_root->node);
+		clear_extent_buffer_uptodate(root->node);
 	}
 
 	return 0;
 }
 
+static inline bool maybe_load_block_groups(struct btrfs_fs_info *fs_info,
+					   u64 flags)
+{
+	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+
+	if (flags & OPEN_CTREE_NO_BLOCK_GROUPS)
+		return false;
+
+	if (root && extent_buffer_uptodate(root->node))
+		return true;
+
+	return false;
+}
+
+
+static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
+				      struct btrfs_path *path, u64 objectid,
+				      unsigned flags, char *str)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_root *root;
+	int ret;
+	struct btrfs_key key = {
+		.objectid = objectid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+
+	ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
+	if (ret < 0) {
+		error("could not find %s tree", str);
+		return ret;
+	}
+	ret = 0;
+
+	while (1) {
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+			ret = btrfs_next_leaf(tree_root, path);
+			if (ret) {
+				if (ret > 0)
+					ret = 0;
+				break;
+			}
+		}
+		btrfs_item_key_to_cpu(path->nodes[0], &key,
+				      path->slots[0]);
+		if (key.objectid != objectid)
+			break;
+
+		root = calloc(1, sizeof(*root));
+		if (!root) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		btrfs_setup_root(root, fs_info, objectid);
+		read_extent_buffer(path->nodes[0], &root->root_item,
+				   btrfs_item_ptr_offset(path->nodes[0],
+							 path->slots[0]),
+				   sizeof(root->root_item));
+		memcpy(&root->root_key, &key, sizeof(key));
+		ret = read_root_or_create_block(fs_info, root,
+				btrfs_root_bytenr(&root->root_item),
+				btrfs_root_generation(&root->root_item),
+				flags, str);
+		if (ret) {
+			free(root);
+			break;
+		}
+		root->track_dirty = 1;
+
+		ret = btrfs_global_root_insert(fs_info, root);
+		if (ret) {
+			free_extent_buffer(root->node);
+			free(root);
+			break;
+		}
+
+		path->slots[0]++;
+	}
+	btrfs_release_path(path);
+	return ret;
+}
+
+static int load_global_roots(struct btrfs_fs_info *fs_info, unsigned flags)
+{
+	struct btrfs_path *path;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = load_global_roots_objectid(fs_info, path,
+					 BTRFS_EXTENT_TREE_OBJECTID, flags,
+					 "extent");
+	if (ret)
+		goto out;
+	ret = load_global_roots_objectid(fs_info, path,
+					 BTRFS_CSUM_TREE_OBJECTID, flags,
+					 "csum");
+	if (ret)
+		goto out;
+	ret = load_global_roots_objectid(fs_info, path,
+					 BTRFS_FREE_SPACE_TREE_OBJECTID, flags,
+					 "free space");
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			  unsigned flags)
 {
@@ -991,11 +1158,9 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		return -EIO;
 	}
 
-	ret = setup_root_or_create_block(fs_info, flags, fs_info->_extent_root,
-					 BTRFS_EXTENT_TREE_OBJECTID, "extent");
+	ret = load_global_roots(fs_info, flags);
 	if (ret)
 		return ret;
-	fs_info->_extent_root->track_dirty = 1;
 
 	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
 				  fs_info->dev_root);
@@ -1005,12 +1170,6 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	}
 	fs_info->dev_root->track_dirty = 1;
 
-	ret = setup_root_or_create_block(fs_info, flags, fs_info->_csum_root,
-					 BTRFS_CSUM_TREE_OBJECTID, "csum");
-	if (ret)
-		return ret;
-	fs_info->_csum_root->track_dirty = 1;
-
 	ret = find_and_setup_root(root, fs_info, BTRFS_UUID_TREE_OBJECTID,
 				  fs_info->uuid_root);
 	if (ret) {
@@ -1029,21 +1188,6 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		fs_info->quota_enabled = 1;
 	}
 
-	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		ret = find_and_setup_root(root, fs_info, BTRFS_FREE_SPACE_TREE_OBJECTID,
-					  fs_info->_free_space_root);
-		if (ret) {
-			free(fs_info->_free_space_root);
-			fs_info->_free_space_root = NULL;
-			printk("Couldn't read free space tree\n");
-			return -EIO;
-		}
-		fs_info->_free_space_root->track_dirty = 1;
-	} else {
-		free(fs_info->_free_space_root);
-		fs_info->_free_space_root = NULL;
-	}
-
 	ret = find_and_setup_log_root(root, fs_info, sb);
 	if (ret) {
 		printk("Couldn't setup log root tree\n");
@@ -1053,8 +1197,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 
 	fs_info->generation = generation;
 	fs_info->last_trans_committed = generation;
-	if (extent_buffer_uptodate(fs_info->_extent_root->node) &&
-	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
+	if (maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
 		 * If we don't find any blockgroups (ENOENT) we're either
@@ -1078,18 +1221,29 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	return 0;
 }
 
+static void release_global_roots(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root;
+	struct rb_node *n;
+
+	for (n = rb_first(&fs_info->global_roots_tree); n; n = rb_next(n)) {
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->node)
+			free_extent_buffer(root->node);
+		if (root->commit_root)
+			free_extent_buffer(root->commit_root);
+		root->node = NULL;
+		root->commit_root = NULL;
+	}
+}
+
 void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->_free_space_root)
-		free_extent_buffer(fs_info->_free_space_root->node);
+	release_global_roots(fs_info);
 	if (fs_info->quota_root)
 		free_extent_buffer(fs_info->quota_root->node);
-	if (fs_info->_csum_root)
-		free_extent_buffer(fs_info->_csum_root->node);
 	if (fs_info->dev_root)
 		free_extent_buffer(fs_info->dev_root->node);
-	if (fs_info->_extent_root)
-		free_extent_buffer(fs_info->_extent_root->node);
 	if (fs_info->tree_root)
 		free_extent_buffer(fs_info->tree_root->node);
 	if (fs_info->log_root_tree)
@@ -1811,6 +1965,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	struct btrfs_root_backup *root_backup;
+	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
+	struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 	int next_backup;
 	int last_backup;
 
@@ -1842,11 +1998,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	btrfs_set_backup_extent_root(root_backup, info->_extent_root->node->start);
+	btrfs_set_backup_extent_root(root_backup, extent_root->node->start);
 	btrfs_set_backup_extent_root_gen(root_backup,
-			       btrfs_header_generation(info->_extent_root->node));
+			       btrfs_header_generation(extent_root->node));
 	btrfs_set_backup_extent_root_level(root_backup,
-			       btrfs_header_level(info->_extent_root->node));
+			       btrfs_header_level(extent_root->node));
 	/*
 	 * we might commit during log recovery, which happens before we set
 	 * the fs_root.  Make sure it is valid before we fill it in.
@@ -1866,11 +2022,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_dev_root_level(root_backup,
 				       btrfs_header_level(info->dev_root->node));
 
-	btrfs_set_backup_csum_root(root_backup, info->_csum_root->node->start);
+	btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
 	btrfs_set_backup_csum_root_gen(root_backup,
-			       btrfs_header_generation(info->_csum_root->node));
+			       btrfs_header_generation(csum_root->node));
 	btrfs_set_backup_csum_root_level(root_backup,
-			       btrfs_header_level(info->_csum_root->node));
+			       btrfs_header_level(csum_root->node));
 
 	btrfs_set_backup_total_bytes(root_backup,
 			     btrfs_super_total_bytes(info->super_copy));
@@ -1878,7 +2034,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 			     btrfs_super_bytes_used(info->super_copy));
 	btrfs_set_backup_num_devices(root_backup,
 			     btrfs_super_num_devices(info->super_copy));
-};
+}
 
 int write_all_supers(struct btrfs_fs_info *fs_info)
 {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index dc71cc2b..0d2f505f 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -219,4 +219,9 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
+struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info);
+struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
+				     struct btrfs_key *key);
+int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
+			     struct btrfs_root *root);
 #endif
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 70b3d62a..0fdf5004 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -28,7 +28,13 @@
 static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
 						struct btrfs_block_group *block_group)
 {
-	return fs_info->_free_space_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+	return btrfs_global_root(fs_info, &key);
 }
 
 static struct btrfs_free_space_info *
@@ -1238,7 +1244,6 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	features &= ~(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
 		      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
 	btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
-	fs_info->_free_space_root = NULL;
 
 	ret = clear_free_space_tree(trans, free_space_root);
 	if (ret)
@@ -1258,6 +1263,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto abort;
 
+	rb_erase(&free_space_root->rb_node, &fs_info->global_roots_tree);
 	free_extent_buffer(free_space_root->node);
 	free_extent_buffer(free_space_root->commit_root);
 	kfree(free_space_root);
@@ -1474,7 +1480,10 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		ret = PTR_ERR(free_space_root);
 		goto abort;
 	}
-	fs_info->_free_space_root = free_space_root;
+
+	ret = btrfs_global_root_insert(fs_info, free_space_root);
+	if (ret)
+		goto abort;
 	add_root_to_dirty_list(free_space_root);
 
 	do {
diff --git a/mkfs/main.c b/mkfs/main.c
index 16f9ba19..d0c863fd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -264,20 +264,33 @@ out:
 	return ret;
 }
 
+static int recow_global_roots(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root;
+	struct rb_node *n;
+	int ret = 0;
+
+	for (n = rb_first(&fs_info->global_roots_tree); n; n = rb_next(n)) {
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		ret = __recow_root(trans, root);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int recow_roots(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *info = root->fs_info;
-	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 	int ret;
 
 	ret = __recow_root(trans, info->fs_root);
 	if (ret)
 		return ret;
 	ret = __recow_root(trans, info->tree_root);
-	if (ret)
-		return ret;
-	ret = __recow_root(trans, info->_extent_root);
 	if (ret)
 		return ret;
 	ret = __recow_root(trans, info->chunk_root);
@@ -286,14 +299,9 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, info->dev_root);
 	if (ret)
 		return ret;
-	ret = __recow_root(trans, csum_root);
+	ret = recow_global_roots(trans);
 	if (ret)
 		return ret;
-	if (info->_free_space_root) {
-		ret = __recow_root(trans, info->_free_space_root);
-		if (ret)
-			return ret;
-	}
 	return 0;
 }
 
-- 
2.26.3

