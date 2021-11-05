Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB957446A0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhKEUtJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhKEUtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6DC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id bu11so8103764qvb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WFNOCeYDoaX+M3z7qEDGl+C6JPUokmmYr5vwUr55ews=;
        b=pzwLmBnPY93G4kdh+BeZ5ij+R+tifCk4rswZ2AswHH0kRv/VkrdBlW3ZqFuNRA8KIO
         T0WDdtoe56XW9xdLA3KhN25YUcwAonbp6mMYKtqsys2qLH/c18MuOMOGppz/B+cK8oFn
         tKU7KxsLl6oj4gMuijPHnNwS40lRnzUX2ADFL/ZQkzeXS1F1g4d7gdiBoIQhBxmGEYY6
         qdyJKsRGSN6t+nkV0Mh7xT0vlyPMGXfzNQJUw1N24vDvSfETIskhmcXa3rXDqhmowP+n
         bt/iWOaYcz/PxVvfKf4Kg7PqRXhS7kFw2CI64icmYe4AUqsc9iIHDznGoYgEdVZ+f4PY
         2LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFNOCeYDoaX+M3z7qEDGl+C6JPUokmmYr5vwUr55ews=;
        b=tPQ/hg5xkWFHsK4T5650MEAJ1l6MUFDIsk6D+cqbPXnK8p6QBezzc7nxGph/GFghSJ
         LbK3eOS1zrxN6guBCq57uMqw1ntY4yvXEtJRfc5kpZBQWL9xRqObfiIfG4KjF9QBxX9s
         2sSQsqMB0604t+mmEO1Ob5JJkHlNRgJxN1vWzRYRpaSrZoNK5yTRPhLBEPu4m7LLq0jJ
         cy3RpP5kxiw/z8+3zJyM9fDnofYSTiZXuChlGDhhHKKLRaR8KLi/0OgVeIXNy6qaHwOs
         RN9GsHDffDgfJWFCdrKnf7lNLMSQL1n9byXVFWpUNZichliFZqUmFHWTT0TVxXQ+QHI+
         sSnA==
X-Gm-Message-State: AOAM530DI1USwAZ3OswDaeYMxtE1SJVTtQE+IlN171ZOzlEE/aHucYUo
        oIqx1DgU+kIzCUjfrfBOyHVgY0Lp7HBr9w==
X-Google-Smtp-Source: ABdhPJwws4TUtHFr9oZpsXhF0R21A/FmcoW3zASAlMziBCHs3AxiinooLl96yVk6dk3u3o6JaBWdvg==
X-Received: by 2002:a0c:b341:: with SMTP id a1mr57086749qvf.21.1636145187661;
        Fri, 05 Nov 2021 13:46:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h17sm6650569qtx.64.2021.11.05.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/25] btrfs: track the csum, extent, and free space trees in a rb tree
Date:   Fri,  5 Nov 2021 16:45:51 -0400
Message-Id: <9b8e6728cf5a0ee5980fa1336ba3e3e8b257076a.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the future we are going to have multiple copies of these trees.  To
facilitate this we need a way to lookup the different roots we are
looking for.  Handle this by adding a global root rb tree that is
indexed on the root->root_key.  Then instead of loading the roots at
mount time with individually targeted keys, simply search the tree_root
for anything with the specific objectid we want.  This will make it
straightforward to support both old style and new style file systems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                       |   9 +-
 fs/btrfs/disk-io.c                     | 276 +++++++++++++++++++------
 fs/btrfs/disk-io.h                     |  20 +-
 fs/btrfs/extent-tree.c                 |   1 +
 fs/btrfs/free-space-tree.c             |  22 +-
 fs/btrfs/tests/btrfs-tests.c           |   1 +
 fs/btrfs/tests/free-space-tests.c      |   5 +-
 fs/btrfs/tests/free-space-tree-tests.c |   5 +-
 fs/btrfs/tests/qgroup-tests.c          |   5 +-
 9 files changed, 264 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 773a45470610..d32aa0fe1415 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -623,20 +623,21 @@ enum btrfs_exclusive_operation {
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
-	struct btrfs_root *_extent_root;
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	struct btrfs_root *dev_root;
 	struct btrfs_root *fs_root;
-	struct btrfs_root *_csum_root;
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
-	struct btrfs_root *_free_space_root;
 	struct btrfs_root *data_reloc_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
+	/* The tree that holds the global roots (csum, extent, etc) */
+	rwlock_t global_root_lock;
+	struct rb_root global_root_tree;
+
 	spinlock_t fs_roots_radix_lock;
 	struct radix_tree_root fs_roots_radix;
 
@@ -1129,6 +1130,8 @@ struct btrfs_qgroup_swapped_blocks {
  * and for the extent tree extent_root root.
  */
 struct btrfs_root {
+	struct rb_node rb_node;
+
 	struct extent_buffer *node;
 
 	struct extent_buffer *commit_root;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b0efc9ca9eaa..2a80b9b6d52d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1149,6 +1149,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->node = NULL;
 	root->commit_root = NULL;
 	root->state = 0;
+	RB_CLEAR_NODE(&root->rb_node);
 
 	root->last_trans = 0;
 	root->free_objectid = 0;
@@ -1242,6 +1243,82 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info)
 }
 #endif
 
+static int global_root_cmp(struct rb_node *a_node, const struct rb_node *b_node)
+{
+	struct btrfs_root *a = rb_entry(a_node, struct btrfs_root, rb_node);
+	struct btrfs_root *b = rb_entry(b_node, struct btrfs_root, rb_node);
+	return btrfs_comp_cpu_keys(&a->root_key, &b->root_key);
+}
+
+static int global_root_key_cmp(const void *k, const struct rb_node *node)
+{
+	struct btrfs_key *key = (struct btrfs_key *)k;
+	struct btrfs_root *root = rb_entry(node, struct btrfs_root, rb_node);
+	return btrfs_comp_cpu_keys(key, &root->root_key);
+}
+
+int btrfs_global_root_insert(struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct rb_node *tmp;
+
+	write_lock(&fs_info->global_root_lock);
+	tmp = rb_find_add(&root->rb_node, &fs_info->global_root_tree,
+			  global_root_cmp);
+	write_unlock(&fs_info->global_root_lock);
+	ASSERT(!tmp);
+
+	return tmp ? -EEXIST : 0;
+}
+
+void btrfs_global_root_delete(struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+
+	write_lock(&fs_info->global_root_lock);
+	rb_erase(&root->rb_node, &fs_info->global_root_tree);
+	write_unlock(&fs_info->global_root_lock);
+}
+
+struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
+				     struct btrfs_key *key)
+{
+	struct rb_node *node;
+	struct btrfs_root *root = NULL;
+
+	read_lock(&fs_info->global_root_lock);
+	node = rb_find(key, &fs_info->global_root_tree, global_root_key_cmp);
+	if (node)
+		root = container_of(node, struct btrfs_root, rb_node);
+	read_unlock(&fs_info->global_root_lock);
+
+	return root;
+}
+
+struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
+				   u64 bytenr)
+{
+	struct btrfs_key key = {
+		.objectid = BTRFS_CSUM_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+	return btrfs_global_root(fs_info, &key);
+}
+
+struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
+				     u64 bytenr)
+{
+	struct btrfs_key key = {
+		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+	return btrfs_global_root(fs_info, &key);
+}
+
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid)
 {
@@ -1554,25 +1631,31 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 						u64 objectid)
 {
+	struct btrfs_key key = {
+		.objectid = objectid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
 	if (objectid == BTRFS_ROOT_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->tree_root);
 	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->_extent_root);
+		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	if (objectid == BTRFS_CHUNK_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->chunk_root);
 	if (objectid == BTRFS_DEV_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->dev_root);
 	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->_csum_root);
+		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->quota_root) ?
 			fs_info->quota_root : ERR_PTR(-ENOENT);
 	if (objectid == BTRFS_UUID_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->uuid_root) ?
 			fs_info->uuid_root : ERR_PTR(-ENOENT);
-	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->_free_space_root) ?
-			fs_info->_free_space_root : ERR_PTR(-ENOENT);
+	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
+		struct btrfs_root *root = btrfs_global_root(fs_info, &key);
+		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
+	}
 	return NULL;
 }
 
@@ -1619,6 +1702,18 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 #endif
 }
 
+static void free_global_roots(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root;
+	struct rb_node *n;
+
+	while ((n = rb_first_postorder(&fs_info->global_root_tree)) != NULL) {
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		rb_erase(&root->rb_node, &fs_info->global_root_tree);
+		btrfs_put_root(root);
+	}
+}
+
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
@@ -1630,14 +1725,12 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
-	btrfs_put_root(fs_info->_extent_root);
+	free_global_roots(fs_info);
 	btrfs_put_root(fs_info->tree_root);
 	btrfs_put_root(fs_info->chunk_root);
 	btrfs_put_root(fs_info->dev_root);
-	btrfs_put_root(fs_info->_csum_root);
 	btrfs_put_root(fs_info->quota_root);
 	btrfs_put_root(fs_info->uuid_root);
-	btrfs_put_root(fs_info->_free_space_root);
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_check_leaked_roots(fs_info);
@@ -2154,21 +2247,29 @@ static void free_root_extent_buffers(struct btrfs_root *root)
 	}
 }
 
+static void free_global_root_pointers(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root, *tmp;
+
+	rbtree_postorder_for_each_entry_safe(root, tmp,
+					     &fs_info->global_root_tree,
+					     rb_node)
+		free_root_extent_buffers(root);
+}
+
 /* helper to cleanup tree roots */
 static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 {
 	free_root_extent_buffers(info->tree_root);
 
+	free_global_root_pointers(info);
 	free_root_extent_buffers(info->dev_root);
-	free_root_extent_buffers(info->_extent_root);
-	free_root_extent_buffers(info->_csum_root);
 	free_root_extent_buffers(info->quota_root);
 	free_root_extent_buffers(info->uuid_root);
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
-	free_root_extent_buffers(info->_free_space_root);
 }
 
 void btrfs_put_root(struct btrfs_root *root)
@@ -2430,6 +2531,105 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int load_global_roots_objectid(struct btrfs_root *tree_root,
+				      struct btrfs_path *path, u64 objectid,
+				      const char *name)
+{
+	struct btrfs_fs_info *fs_info = tree_root->fs_info;
+	struct btrfs_root *root;
+	int ret;
+	struct btrfs_key key = {
+		.objectid = objectid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	bool found = false;
+
+	/* If we have IGNOREDATACSUMS skip loading these roots. */
+	if (objectid == BTRFS_CSUM_TREE_OBJECTID &&
+	    btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
+		set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
+		return 0;
+	}
+
+	while (1) {
+		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
+		if (ret < 0)
+			break;
+
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+			ret = btrfs_next_leaf(tree_root, path);
+			if (ret) {
+				if (ret > 0)
+					ret = 0;
+				break;
+			}
+		}
+		ret = 0;
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key,
+				      path->slots[0]);
+		if (key.objectid != objectid)
+			break;
+		btrfs_release_path(path);
+
+		found = true;
+		root = read_tree_root_path(tree_root, path, &key);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
+				ret = PTR_ERR(root);
+			break;
+		}
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		ret = btrfs_global_root_insert(root);
+		if (ret) {
+			btrfs_put_root(root);
+			break;
+		}
+		key.offset++;
+	}
+	btrfs_release_path(path);
+
+	if (!found || ret) {
+		if (objectid == BTRFS_CSUM_TREE_OBJECTID)
+			set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
+
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
+			ret = ret ? ret : -ENOENT;
+		else
+			ret = 0;
+		btrfs_err(fs_info, "failed to load root %s", name);
+	}
+	return ret;
+}
+
+static int load_global_roots(struct btrfs_root *tree_root)
+{
+	struct btrfs_path *path;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = load_global_roots_objectid(tree_root, path,
+					 BTRFS_EXTENT_TREE_OBJECTID, "extent");
+	if (ret)
+		goto out;
+	ret = load_global_roots_objectid(tree_root, path,
+					 BTRFS_CSUM_TREE_OBJECTID, "csum");
+	if (ret)
+		goto out;
+	if (!btrfs_fs_compat_ro(tree_root->fs_info, FREE_SPACE_TREE))
+		goto out;
+	ret = load_global_roots_objectid(tree_root, path,
+					 BTRFS_FREE_SPACE_TREE_OBJECTID,
+					 "free space");
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -2439,22 +2639,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	BUG_ON(!fs_info->tree_root);
 
-	location.objectid = BTRFS_EXTENT_TREE_OBJECTID;
+	ret = load_global_roots(tree_root);
+	if (ret)
+		return ret;
+
+	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
 
-	root = btrfs_read_tree_root(tree_root, &location);
-	if (IS_ERR(root)) {
-		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
-			ret = PTR_ERR(root);
-			goto out;
-		}
-	} else {
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->_extent_root = root;
-	}
-
-	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
 		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
@@ -2468,26 +2660,6 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	/* Initialize fs_info for all devices in any case */
 	btrfs_init_devices_late(fs_info);
 
-	/* If IGNOREDATACSUMS is set don't bother reading the csum root. */
-	if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
-		location.objectid = BTRFS_CSUM_TREE_OBJECTID;
-		root = btrfs_read_tree_root(tree_root, &location);
-		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
-				ret = PTR_ERR(root);
-				goto out;
-			} else {
-				set_bit(BTRFS_FS_STATE_NO_CSUMS,
-					&fs_info->fs_state);
-			}
-		} else {
-			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-			fs_info->_csum_root = root;
-		}
-	} else {
-		set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
-	}
-
 	/*
 	 * This tree can share blocks with some other fs tree during relocation
 	 * and we need a proper setup by btrfs_get_fs_root
@@ -2525,20 +2697,6 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->uuid_root = root;
 	}
 
-	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		location.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID;
-		root = btrfs_read_tree_root(tree_root, &location);
-		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
-				ret = PTR_ERR(root);
-				goto out;
-			}
-		}  else {
-			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-			fs_info->_free_space_root = root;
-		}
-	}
-
 	return 0;
 out:
 	btrfs_warn(fs_info, "failed to read root (objectid=%llu): %d",
@@ -2893,6 +3051,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->zone_active_bgs_lock);
 	spin_lock_init(&fs_info->relocation_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
+	rwlock_init(&fs_info->global_root_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->reclaim_bgs_lock);
 	mutex_init(&fs_info->reloc_mutex);
@@ -2927,6 +3086,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	atomic_set(&fs_info->reada_works_cnt, 0);
 	atomic_set(&fs_info->nr_delayed_iputs, 0);
 	atomic64_set(&fs_info->tree_mod_seq, 0);
+	fs_info->global_root_tree = RB_ROOT;
 	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
 	fs_info->metadata_ratio = 0;
 	fs_info->defrag_inodes = RB_ROOT;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a4d1788acd24..80b45fcac72a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -71,6 +71,14 @@ struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
 struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
 						 u64 objectid);
+int btrfs_global_root_insert(struct btrfs_root *root);
+void btrfs_global_root_delete(struct btrfs_root *root);
+struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
+				     struct btrfs_key *key);
+struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
+				   u64 bytenr);
+struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
+				     u64 bytenr);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
@@ -103,18 +111,6 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
-static inline struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
-						   u64 bytenr)
-{
-	return fs_info->_extent_root;
-}
-
-static inline struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
-						 u64 bytenr)
-{
-	return fs_info->_csum_root;
-}
-
 static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
 {
 	return btrfs_extent_root(fs_info, 0);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3cf354223e55..e080ee72e5bb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2947,6 +2947,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
 
 	extent_root = btrfs_extent_root(info, bytenr);
+	ASSERT(extent_root);
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index c0f0ba66b5ae..cf227450f356 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -19,7 +19,12 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 static struct btrfs_root *btrfs_free_space_root(
 				struct btrfs_block_group *block_group)
 {
-	return block_group->fs_info->_free_space_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	return btrfs_global_root(block_group->fs_info, &key);
 }
 
 void set_free_space_tree_thresholds(struct btrfs_block_group *cache)
@@ -1164,7 +1169,11 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		ret = PTR_ERR(free_space_root);
 		goto abort;
 	}
-	fs_info->_free_space_root = free_space_root;
+	ret = btrfs_global_root_insert(free_space_root);
+	if (ret) {
+		btrfs_put_root(free_space_root);
+		goto abort;
+	}
 
 	node = rb_first(&fs_info->block_group_cache_tree);
 	while (node) {
@@ -1239,7 +1248,12 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_root *free_space_root = fs_info->_free_space_root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
 	int ret;
 
 	trans = btrfs_start_transaction(tree_root, 0);
@@ -1248,7 +1262,6 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 
 	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE);
 	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
-	fs_info->_free_space_root = NULL;
 
 	ret = clear_free_space_tree(trans, free_space_root);
 	if (ret)
@@ -1258,6 +1271,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto abort;
 
+	btrfs_global_root_delete(free_space_root);
 	list_del(&free_space_root->dirty_list);
 
 	btrfs_tree_lock(free_space_root->node);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 3a4099a2bf05..d8e56edd6991 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -204,6 +204,7 @@ void btrfs_free_dummy_root(struct btrfs_root *root)
 	/* Will be freed by btrfs_free_fs_roots */
 	if (WARN_ON(test_bit(BTRFS_ROOT_IN_RADIX, &root->state)))
 		return;
+	btrfs_global_root_delete(root);
 	btrfs_put_root(root);
 }
 
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index c3709138f7cf..ab823adf1192 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -858,7 +858,10 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	root->fs_info->_extent_root = root;
+	root->root_key.objectid = BTRFS_EXTENT_TREE_OBJECTID;
+	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root->root_key.offset = 0;
+	btrfs_global_root_insert(root);
 
 	ret = test_extents(cache);
 	if (ret)
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 7d6de8b53038..13734ed43bfc 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -446,7 +446,10 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 
 	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
 					BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
-	root->fs_info->_free_space_root = root;
+	root->root_key.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID;
+	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root->root_key.offset = 0;
+	btrfs_global_root_insert(root);
 	root->fs_info->tree_root = root;
 
 	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 88e19781e83f..eee1e4459541 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -455,7 +455,10 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 	}
 
 	/* We are using this root as our extent root */
-	root->fs_info->_extent_root = root;
+	root->root_key.objectid = BTRFS_EXTENT_TREE_OBJECTID;
+	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root->root_key.offset = 0;
+	btrfs_global_root_insert(root);
 
 	/*
 	 * Some of the paths we test assume we have a filled out fs_info, so we
-- 
2.26.3

