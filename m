Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E6785AB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjHWOdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjHWOde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45EE6C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:25 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7481bc4d6fso3859076276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801205; x=1693406005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyYBFkPVVl9PWjQ/B45EklVX4zrE0ph5wI3MWOufMwE=;
        b=OW1lTw+uUA5noiNhB58N7mIvWRPRcA+ChHhx07HqL1clNG7MZEvJpHKz0kEinTcO0K
         0vZiLsP+4qeMvH6ZU8eeFjX3QhGO3gb4g7/4w0+WiuC7SVRjZR8uh02v5DwBjakyXYEm
         marBHhjyQOI1AI+jXkeGgRE1Jdhpn1SEfhXrMm15fWkbPA7TbMC5NW8Exu7UkNWxhy2T
         H1qVZ0oet5Bbpa4GeC8LAlDnLOtNwcjJcXYXQf0jMjDPkAhas+uJshio3a0FGBLrKza9
         Ed2y5PiMOLzonm7FGlx2RVkRAzzpVWMtNJ51Wxh3a1Sk9l9+i9tJ8eo3Mom+6aYwovHZ
         A/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801205; x=1693406005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyYBFkPVVl9PWjQ/B45EklVX4zrE0ph5wI3MWOufMwE=;
        b=QTY6RxuPbtwDDh3/Gc2ds6rMml4/PM/i8lsUYI2N6LjJ+hGXpDkewbTcwwHDOsx/A/
         mI5J4QJI6wgX4bQTjQtBTTHBFmNVABxwTP1XdsHGz3SKhcTVE/l54Zp3vOmpXqOy7h0E
         sMVk0dn7P3ZDW2eGFWgItwaYysyHC7283a3acuhL0uIb13RV2LSvJhvZVaeRmVWi9rX4
         6/PSmhW7Xuo57zMYkwz7qw8h19+/bS9KQZtiRNgJAd8EoNPFdEUOemyt9UX1QanqAHMF
         HZqXsDZANV+eZokfCGLfyIMW9kpqW8luhILUs8p75eQ3Hc4YK6bFaX0fydGE1nZSUQcJ
         Pdrw==
X-Gm-Message-State: AOJu0Yx18DVqdxyzjWfszpXXqOO5xopouvGKgaZE8es1qwEouS7GKgex
        VO/Upt53VQymY9nO6IoLouQG9y3hh04kloeDb7U=
X-Google-Smtp-Source: AGHT+IHEfVnjZ0MYU9cJuTuyi6R8mjk+fYS4mBNKWm6xqJECgpPqn6K3hZGdaPZbAvIpxX8MEcCc6g==
X-Received: by 2002:a25:d2c1:0:b0:d74:6681:5c26 with SMTP id j184-20020a25d2c1000000b00d7466815c26mr12741442ybg.16.1692801204112;
        Wed, 23 Aug 2023 07:33:24 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f7-20020a5b0d47000000b00d0bad22d652sm2722739ybr.36.2023.08.23.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/38] btrfs-progs: drop btrfs_init_path
Date:   Wed, 23 Aug 2023 10:32:39 -0400
Message-ID: <f39e59024cd38ec1a7e5fa129188bb10f3e556d5.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This simply zero's out the path, and this is used everywhere we use a
stack path.  Drop this usage and simply init the path's to empty instead
of using a function to do the memset.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/clear-cache.c              | 12 ++--
 check/main.c                     | 94 ++++++++++----------------------
 check/mode-common.c              | 35 ++++--------
 check/mode-lowmem.c              | 84 +++++++++-------------------
 check/qgroup-verify.c            | 14 ++---
 check/repair.c                   |  3 +-
 cmds/inspect-dump-tree.c         |  3 +-
 cmds/inspect-tree-stats.c        |  3 +-
 cmds/rescue-chunk-recover.c      | 13 ++---
 cmds/restore.c                   | 21 +++----
 convert/main.c                   |  9 +--
 convert/source-fs.c              |  4 +-
 image/common.c                   |  3 +-
 image/image-create.c             |  4 +-
 image/image-restore.c            |  6 +-
 kernel-shared/ctree.c            |  5 --
 kernel-shared/ctree.h            |  1 -
 kernel-shared/extent-tree.c      |  3 +-
 kernel-shared/file.c             |  3 +-
 kernel-shared/free-space-cache.c |  4 +-
 kernel-shared/inode.c            |  5 +-
 kernel-shared/print-tree.c       |  3 +-
 kernel-shared/volumes.c          |  6 +-
 mkfs/main.c                      | 15 ++---
 mkfs/rootdir.c                   | 10 +---
 quick-test.c                     |  6 +-
 tune/change-uuid.c               |  6 +-
 27 files changed, 114 insertions(+), 261 deletions(-)

diff --git a/check/clear-cache.c b/check/clear-cache.c
index 9f8819f0..7a6b6002 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -130,11 +130,9 @@ static int check_free_space_tree(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key = { 0 };
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret = 0;
 
-	btrfs_init_path(&path);
-
 	while (1) {
 		struct btrfs_block_group *bg;
 		u64 cur_start = key.objectid;
@@ -450,7 +448,6 @@ out:
 
 int truncate_free_ino_items(struct btrfs_root *root)
 {
-	struct btrfs_path path;
 	struct btrfs_key key = { .objectid = BTRFS_FREE_INO_OBJECTID,
 				 .type = (u8)-1,
 				 .offset = (u64)-1 };
@@ -468,9 +465,9 @@ int truncate_free_ino_items(struct btrfs_root *root)
 		struct btrfs_file_extent_item *fi;
 		struct btrfs_root *csum_root;
 		struct btrfs_key found_key;
+		struct btrfs_path path = {};
 		u8 found_type;
 
-		btrfs_init_path(&path);
 		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
@@ -551,15 +548,14 @@ out:
 int clear_ino_cache_items(struct btrfs_fs_info *fs_info)
 {
 	int ret;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 
 	key.objectid = BTRFS_FS_TREE_OBJECTID;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = 0;
 
-	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, &path,	0, 0);
+	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
 
diff --git a/check/main.c b/check/main.c
index 481fe11e..b8bcf5c3 100644
--- a/check/main.c
+++ b/check/main.c
@@ -889,7 +889,7 @@ static void maybe_free_inode_rec(struct cache_tree *inode_cache,
 
 static int check_orphan_item(struct btrfs_root *root, u64 ino)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 
@@ -897,7 +897,6 @@ static int check_orphan_item(struct btrfs_root *root, u64 ino)
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = ino;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	btrfs_release_path(&path);
 	if (ret > 0)
@@ -1325,14 +1324,12 @@ static int leave_shared_node(struct btrfs_root *root,
 static int is_child_root(struct btrfs_root *root, u64 parent_root_id,
 			 u64 child_root_id)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	int has_parent = 0;
 	int ret;
 
-	btrfs_init_path(&path);
-
 	key.objectid = parent_root_id;
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = child_root_id;
@@ -2107,7 +2104,7 @@ static int add_missing_dir_index(struct btrfs_root *root,
 				 struct inode_record *rec,
 				 struct inode_backref *backref)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_trans_handle *trans;
 	struct btrfs_dir_item *dir_item;
 	struct extent_buffer *leaf;
@@ -2125,7 +2122,6 @@ static int add_missing_dir_index(struct btrfs_root *root,
 	fprintf(stderr, "repairing missing dir index item for inode %llu\n",
 		(unsigned long long)rec->ino);
 
-	btrfs_init_path(&path);
 	key.objectid = backref->dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = backref->index;
@@ -2169,7 +2165,7 @@ static int delete_dir_index(struct btrfs_root *root,
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_dir_item *di;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret = 0;
 
 	trans = btrfs_start_transaction(root, 1);
@@ -2181,7 +2177,6 @@ static int delete_dir_index(struct btrfs_root *root,
 		BTRFS_DIR_INDEX_KEY, (unsigned long long)backref->index,
 		(unsigned long long)root->objectid);
 
-	btrfs_init_path(&path);
 	di = btrfs_lookup_dir_index_item(trans, root, &path, backref->dir,
 					 backref->index, backref->name,
 					 backref->namelen, -1);
@@ -2535,14 +2530,13 @@ out:
  */
 static int find_normal_file_extent(struct btrfs_root *root, u64 ino)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_file_extent_item *fi;
 	u8 type;
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
@@ -2755,11 +2749,9 @@ static int repair_mismatch_dir_hash(struct btrfs_trans_handle *trans,
 static int btrfs_delete_item(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct btrfs_key *key)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret = 0;
 
-	btrfs_init_path(&path);
-
 	ret = btrfs_search_slot(trans, root, key, &path, -1, 1);
 	if (ret) {
 		if (ret > 0)
@@ -2779,7 +2771,7 @@ static int find_file_extent_offset_by_bytenr(struct btrfs_root *root,
 		u64 owner, u64 bytenr, u64 *offset_ret)
 {
 	int ret = 0;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_file_extent_item *fi;
@@ -2787,8 +2779,6 @@ static int find_file_extent_offset_by_bytenr(struct btrfs_root *root,
 	u64 disk_bytenr;
 	int slot;
 
-	btrfs_init_path(&path);
-
 	key.objectid = owner;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
@@ -2960,7 +2950,7 @@ static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
 static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret = 0;
 
 	/* unaligned extent recs always lead to csum missing error, clean it */
@@ -2993,7 +2983,6 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	btrfs_init_path(&path);
 	if (!ret && rec->errors & I_ERR_MISMATCH_DIR_HASH)
 		ret = repair_mismatch_dir_hash(trans, root, rec);
 	if (!ret && rec->errors & I_ERR_INVALID_IMODE)
@@ -3539,7 +3528,7 @@ static int repair_btree(struct btrfs_root *root,
 			struct cache_tree *corrupt_blocks)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_corrupt_block *corrupt;
 	struct cache_extent *cache;
 	struct btrfs_key key;
@@ -3557,7 +3546,6 @@ static int repair_btree(struct btrfs_root *root,
 		fprintf(stderr, "Error starting transaction: %m\n");
 		return ret;
 	}
-	btrfs_init_path(&path);
 	cache = first_cache_extent(corrupt_blocks);
 	while (cache) {
 		corrupt = container_of(cache, struct btrfs_corrupt_block,
@@ -3625,7 +3613,7 @@ static int check_fs_root(struct btrfs_root *root,
 	int wret;
 	int level;
 	u64 super_generation;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct shared_node root_node;
 	struct root_record *rec;
 	struct btrfs_root_item *root_item = &root->root_item;
@@ -3668,7 +3656,6 @@ static int check_fs_root(struct btrfs_root *root,
 			rec->found_root_item = 1;
 	}
 
-	btrfs_init_path(&path);
 	memset(&root_node, 0, sizeof(root_node));
 	cache_tree_init(&root_node.root_cache);
 	cache_tree_init(&root_node.inode_cache);
@@ -3804,7 +3791,7 @@ skip_walking:
 
 static int check_fs_roots(struct cache_tree *root_cache)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct walk_control wc;
 	struct extent_buffer *leaf, *tree_node;
@@ -3822,7 +3809,6 @@ static int check_fs_roots(struct cache_tree *root_cache)
 		reset_cached_block_groups();
 	memset(&wc, 0, sizeof(wc));
 	cache_tree_init(&wc.shared);
-	btrfs_init_path(&path);
 
 again:
 	key.offset = 0;
@@ -4212,7 +4198,7 @@ static bool check_owner_ref(struct btrfs_root *root,
 	struct tree_backref *back;
 	struct btrfs_root *ref_root;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *parent;
 	int level;
 	bool found = false;
@@ -4252,7 +4238,6 @@ static bool check_owner_ref(struct btrfs_root *root,
 	else
 		btrfs_node_key_to_cpu(buf, &key, 0);
 
-	btrfs_init_path(&path);
 	path.lowest_level = level + 1;
 	ret = btrfs_search_slot(NULL, ref_root, &key, &path, 0, 0);
 	if (ret < 0)
@@ -4510,7 +4495,7 @@ static int try_to_fix_bad_block(struct btrfs_root *root,
 	struct ulist *roots;
 	struct ulist_node *node;
 	struct btrfs_root *search_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct ulist_iterator iter;
 	struct btrfs_key root_key, key;
 	int ret;
@@ -4523,7 +4508,6 @@ static int try_to_fix_bad_block(struct btrfs_root *root,
 	if (ret)
 		return -EIO;
 
-	btrfs_init_path(&path);
 	ULIST_ITER_INIT(&iter);
 	/*
 	 * If we found no roots referencing to this tree block, there is no
@@ -5768,12 +5752,11 @@ static int check_extent_exists(struct btrfs_root *root, u64 bytenr,
 			       u64 num_bytes)
 {
 	struct btrfs_root *extent_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = bytenr;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = (u64)-1;
@@ -5909,7 +5892,7 @@ out:
 
 static int check_csum_root(struct btrfs_root *root)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	u64 last_data_end = 0;
@@ -5930,7 +5913,6 @@ static int check_csum_root(struct btrfs_root *root)
 		return -ENOENT;
 	}
 
-	btrfs_init_path(&path);
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 	key.offset = 0;
@@ -7376,14 +7358,12 @@ static int delete_duplicate_records(struct btrfs_root *root,
 {
 	struct btrfs_trans_handle *trans;
 	LIST_HEAD(delete_list);
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_record *tmp, *good, *n;
 	int nr_del = 0;
 	int ret = 0, err;
 	struct btrfs_key key;
 
-	btrfs_init_path(&path);
-
 	good = rec;
 	/* Find the record that covers all of the duplicates. */
 	list_for_each_entry(tmp, &rec->dups, list) {
@@ -7479,7 +7459,7 @@ static int __find_possible_backrefs(struct btrfs_root *root,
 		u64 *bytes_ret)
 {
 	int ret = 0;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_file_extent_item *fi;
@@ -7487,8 +7467,6 @@ static int __find_possible_backrefs(struct btrfs_root *root,
 	u64 backref_offset, disk_bytenr;
 	int slot;
 
-	btrfs_init_path(&path);
-
 	key.objectid = owner;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
@@ -7642,7 +7620,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
 {
 	struct btrfs_trans_handle *trans = NULL;
 	int ret;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct cache_extent *cache;
 	struct extent_backref *back, *tmp;
 	int allocated = 0;
@@ -7651,7 +7629,6 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
 	if (rec->flag_block_full_backref)
 		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 
-	btrfs_init_path(&path);
 	if (rec->refs != rec->extent_item_refs && !rec->metadata) {
 		/*
 		 * Sometimes the backrefs themselves are so broken they don't
@@ -7727,7 +7704,7 @@ static int fixup_extent_flags(struct extent_record *rec)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = btrfs_extent_root(gfs_info, rec->start);
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
 	u64 flags;
@@ -7750,7 +7727,6 @@ retry:
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
 	if (ret < 0) {
 		btrfs_release_path(&path);
@@ -7797,14 +7773,13 @@ static int prune_one_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *extent_root;
 	int ret;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *eb;
 	u64 found;
 	int slot;
 	int nritems;
 	int level = corrupt->level + 1;
 
-	btrfs_init_path(&path);
 again:
 	extent_root = btrfs_extent_root(gfs_info, corrupt->key.objectid);
 	/* we want to stop at the parent to our busted block */
@@ -7983,7 +7958,7 @@ static int record_unaligned_extent_rec(struct extent_record *rec)
 static int repair_extent_item_generation(struct extent_record *rec)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
 	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info,
@@ -8003,7 +7978,6 @@ static int repair_extent_item_generation(struct extent_record *rec)
 		error_msg(ERROR_MSG_START_TRANS, "%m");
 		return ret;
 	}
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(trans, extent_root, &key, &path, 0, 1);
 	/* Not possible */
 	if (ret == 0)
@@ -8728,7 +8702,7 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 static int parse_tree_roots(struct list_head *normal_trees,
 			    struct list_head *dropping_trees)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_root_item ri;
@@ -8736,7 +8710,6 @@ static int parse_tree_roots(struct list_head *normal_trees,
 	int slot;
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -8801,15 +8774,13 @@ out:
  */
 static int check_dev_extents(void)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_root *dev_root = gfs_info->dev_root;
 	int ret;
 	u64 prev_devid = 0;
 	u64 prev_dev_ext_end = 0;
 
-	btrfs_init_path(&path);
-
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
@@ -9174,14 +9145,13 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
 static int reset_block_groups(void)
 {
 	struct btrfs_block_group *cache;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_chunk *chunk;
 	struct btrfs_key key;
 	int ret;
 	u64 start;
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = BTRFS_CHUNK_ITEM_KEY;
 	key.offset = 0;
@@ -9245,14 +9215,13 @@ static int reset_block_groups(void)
 static int reset_balance(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_root *root = gfs_info->tree_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int del_slot, del_nr = 0;
 	int ret;
 	int found = 0;
 
-	btrfs_init_path(&path);
 	key.objectid = BTRFS_BALANCE_OBJECTID;
 	key.type = BTRFS_BALANCE_ITEM_KEY;
 	key.offset = 0;
@@ -9351,12 +9320,11 @@ static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
 		.type = BTRFS_ROOT_ITEM_KEY,
 		.offset = 0,
 	};
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *tree_root = gfs_info->tree_root;
 	struct btrfs_root *root;
 	int ret;
 
-	btrfs_init_path(&path);
 	while (1) {
 		ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
 		if (ret) {
@@ -9509,7 +9477,7 @@ again:
 
 static int delete_bad_item(struct btrfs_root *root, struct bad_item *bad)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	int ret;
@@ -9531,7 +9499,6 @@ static int delete_bad_item(struct btrfs_root *root, struct bad_item *bad)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(trans, root, &bad->key, &path, -1, 1);
 	if (ret) {
 		if (ret > 0)
@@ -9583,7 +9550,7 @@ static int build_roots_info_cache(void)
 	int ret = 0;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 
 	if (!roots_info_cache) {
 		roots_info_cache = malloc(sizeof(*roots_info_cache));
@@ -9592,7 +9559,6 @@ static int build_roots_info_cache(void)
 		cache_tree_init(roots_info_cache);
 	}
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
@@ -9799,7 +9765,7 @@ static int maybe_repair_root_item(struct btrfs_path *path,
  */
 static int repair_root_items(void)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	struct btrfs_trans_handle *trans = NULL;
@@ -9810,8 +9776,6 @@ static int repair_root_items(void)
 	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
 		return 0;
 
-	btrfs_init_path(&path);
-
 	ret = build_roots_info_cache();
 	if (ret)
 		goto out;
diff --git a/check/mode-common.c b/check/mode-common.c
index 175e90f7..71e735c4 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -52,10 +52,9 @@ static int check_prealloc_data_ref(u64 disk_bytenr,
 	u64 offset = btrfs_extent_data_ref_offset(eb, dref);
 	struct btrfs_root *root;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = rootid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
@@ -190,7 +189,7 @@ int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 {
 	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info,
 							   disk_bytenr);
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 	struct btrfs_extent_item *ei;
@@ -202,7 +201,6 @@ int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = num_bytes;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret > 0) {
 		fprintf(stderr,
@@ -303,7 +301,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 {
 	struct btrfs_root *csum_root = btrfs_csum_root(gfs_info, start);
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	int ret;
 	size_t size;
@@ -311,8 +309,6 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 	u64 csum_end;
 	u16 csum_size = gfs_info->csum_size;
 
-	btrfs_init_path(&path);
-
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	key.offset = start;
 	key.type = BTRFS_EXTENT_CSUM_KEY;
@@ -416,7 +412,6 @@ static int get_highest_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key key, found_key;
 	int ret;
 
-	btrfs_init_path(path);
 	key.objectid = BTRFS_LAST_FREE_OBJECTID;
 	key.offset = -1;
 	key.type = BTRFS_INODE_ITEM_KEY;
@@ -654,10 +649,9 @@ int delete_corrupted_dir_item(struct btrfs_trans_handle *trans,
 			      u32 namelen)
 {
 	struct btrfs_dir_item *di_item;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(trans, root, di_key, &path, 0, 1);
 	if (ret > 0) {
 		error("key (%llu %u %llu) doesn't exist in root %llu",
@@ -736,7 +730,7 @@ static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
 				    u64 index, const char *name, u32 name_len,
 				    u32 *imode_ret)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key location;
 	struct btrfs_dir_item *di;
@@ -746,7 +740,6 @@ static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
 	u32 len;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = dirid;
 	key.offset = index;
 	key.type = BTRFS_DIR_INDEX_KEY;
@@ -788,7 +781,7 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 				   const char *name, u32 name_len,
 				   u32 *imode_ret)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key location;
 	struct btrfs_dir_item *di;
@@ -800,7 +793,6 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 	u32 len;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = dirid;
 	key.offset = btrfs_name_hash(name, name_len);
 	key.type = BTRFS_DIR_INDEX_KEY;
@@ -1056,7 +1048,7 @@ int check_repair_free_space_inode(struct btrfs_path *path)
 
 int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	int ret;
@@ -1077,7 +1069,6 @@ int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	btrfs_init_path(&path);
 	path.lowest_level = btrfs_header_level(eb);
 	if (path.lowest_level)
 		btrfs_node_key_to_cpu(eb, &key, 0);
@@ -1100,7 +1091,7 @@ int get_extent_item_generation(u64 bytenr, u64 *gen_ret)
 {
 	struct btrfs_root *root = btrfs_extent_root(gfs_info, bytenr);
 	struct btrfs_extent_item *ei;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 
@@ -1108,7 +1099,6 @@ int get_extent_item_generation(u64 bytenr, u64 *gen_ret)
 	key.type = BTRFS_METADATA_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	/* Not possible */
 	if (ret == 0)
@@ -1233,7 +1223,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 					   struct btrfs_root *cur_root)
 {
 	struct btrfs_root *csum_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct extent_buffer *node;
 	struct btrfs_file_extent_item *fi;
@@ -1248,7 +1238,6 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 	if (!buf)
 		return -ENOMEM;
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = 0;
@@ -1340,7 +1329,7 @@ out:
 
 static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *tree_root = gfs_info->tree_root;
 	struct btrfs_root *cur_root;
 	struct extent_buffer *node;
@@ -1348,7 +1337,6 @@ static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans)
 	int slot = 0;
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	key.objectid = BTRFS_FS_TREE_OBJECTID;
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -1487,14 +1475,13 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *extent_root)
 {
 	struct btrfs_root *csum_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_extent_item *ei;
 	struct extent_buffer *leaf;
 	char *buf;
 	struct btrfs_key key;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index d4d6125c..35bca857 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -281,7 +281,7 @@ static int modify_block_groups_cache(u64 flags, int cache)
 {
 	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_block_group *bg_cache;
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
@@ -293,7 +293,6 @@ static int modify_block_groups_cache(u64 flags, int cache)
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = 0;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0) {
 		errno = -ret;
@@ -430,7 +429,7 @@ err:
  */
 static int is_chunk_almost_full(u64 start)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item *bi;
@@ -446,7 +445,6 @@ static int is_chunk_almost_full(u64 start)
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (!ret)
 		ret = -EIO;
@@ -637,7 +635,7 @@ static int repair_tree_block_ref(struct btrfs_root *root,
 {
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_root *extent_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_extent_item *ei;
 	struct btrfs_tree_block_info *bi;
 	struct btrfs_key key;
@@ -660,7 +658,6 @@ static int repair_tree_block_ref(struct btrfs_root *root,
 	WARN_ON(level > BTRFS_MAX_LEVEL);
 	WARN_ON(level < 0);
 
-	btrfs_init_path(&path);
 	bytenr = btrfs_header_bytenr(node);
 	owner = btrfs_header_owner(node);
 	generation = btrfs_header_generation(node);
@@ -820,7 +817,7 @@ static int find_dir_index(struct btrfs_root *root, u64 dirid, u64 location_id,
 			  u64 *index_ret, char *namebuf, u32 name_len,
 			  u8 file_type)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *node;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -842,7 +839,6 @@ static int find_dir_index(struct btrfs_root *root, u64 dirid, u64 location_id,
 	key.offset = (u64)-1;
 	key.type = BTRFS_DIR_INDEX_KEY;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
@@ -919,7 +915,7 @@ static int find_dir_item(struct btrfs_root *root, struct btrfs_key *key,
 			 struct btrfs_key *location_key, char *name,
 			 u32 namelen, u8 file_type)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *node;
 	struct btrfs_dir_item *di;
 	struct btrfs_key location;
@@ -942,7 +938,6 @@ static int find_dir_item(struct btrfs_root *root, struct btrfs_key *key,
 		return ret;
 	}
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, key, &path, 0, 0);
 	if (ret) {
 		ret = key->type == BTRFS_DIR_ITEM_KEY ? DIR_ITEM_MISSING :
@@ -1338,7 +1333,7 @@ static int find_inode_ref(struct btrfs_root *root, struct btrfs_key *key,
 			  char *name, int namelen, u64 *index_ret)
 
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_inode_ref *ref;
 	struct btrfs_inode_extref *extref;
 	struct extent_buffer *node;
@@ -1355,7 +1350,6 @@ static int find_inode_ref(struct btrfs_root *root, struct btrfs_key *key,
 
 	UASSERT(index_ret);
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, key, &path, 0, 0);
 	if (ret) {
 		ret = INODE_REF_MISSING;
@@ -1415,7 +1409,6 @@ extref:
 		goto out;
 
 	btrfs_release_path(&path);
-	btrfs_init_path(&path);
 
 	dir_id = key->offset;
 	key->type = BTRFS_INODE_EXTREF_KEY;
@@ -1498,14 +1491,13 @@ static int repair_inode_item_missing(struct btrfs_root *root, u64 ino,
 {
 	struct btrfs_key key;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret;
 
 	key.objectid = ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	btrfs_init_path(&path);
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		ret = -EIO;
@@ -1564,14 +1556,13 @@ static int lowmem_delete_corrupted_dir_item(struct btrfs_root *root,
 static int try_repair_imode(struct btrfs_root *root, u64 ino)
 {
 	struct btrfs_inode_item *iitem;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 
 	key.objectid = ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	btrfs_init_path(&path);
 
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret > 0)
@@ -2188,7 +2179,7 @@ static int __count_dir_isize(struct btrfs_root *root, u64 ino, int type,
 		u64 *size_ret)
 {
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	u32 len;
 	struct btrfs_dir_item *di;
 	int ret;
@@ -2202,7 +2193,6 @@ static int __count_dir_isize(struct btrfs_root *root, u64 ino, int type,
 	key.type = type;
 	key.offset = (u64)-1;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0) {
 		ret = -EIO;
@@ -2518,11 +2508,10 @@ out:
 
 static bool has_orphan_item(struct btrfs_root *root, u64 ino)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = BTRFS_ORPHAN_OBJECTID;
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = ino;
@@ -3019,7 +3008,7 @@ static int check_tree_block_ref(struct btrfs_root *root,
 {
 	struct btrfs_key key;
 	struct btrfs_root *extent_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	struct extent_buffer *leaf;
@@ -3038,7 +3027,6 @@ static int check_tree_block_ref(struct btrfs_root *root,
 	int strict = 1;
 	int parent = 0;
 
-	btrfs_init_path(&path);
 	key.objectid = bytenr;
 	if (btrfs_fs_incompat(gfs_info, SKINNY_METADATA))
 		key.type = BTRFS_METADATA_ITEM_KEY;
@@ -3239,7 +3227,7 @@ static int repair_extent_data_item(struct btrfs_root *root,
 	struct btrfs_key fi_key;
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *extent_root;
 	struct extent_buffer *eb;
 	u64 size;
@@ -3291,7 +3279,6 @@ static int repair_extent_data_item(struct btrfs_root *root,
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = num_bytes;
 
-	btrfs_init_path(&path);
 	extent_root = btrfs_extent_root(gfs_info, key.objectid);
 	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret < 0) {
@@ -3374,7 +3361,7 @@ static int check_extent_data_item(struct btrfs_root *root,
 {
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = pathp->nodes[0];
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *extent_root;
 	struct btrfs_key fi_key;
 	struct btrfs_key dbref_key;
@@ -3440,7 +3427,6 @@ static int check_extent_data_item(struct btrfs_root *root,
 	owner = btrfs_header_owner(eb);
 
 	/* Check the extent item of the file extent in extent tree */
-	btrfs_init_path(&path);
 	dbref_key.objectid = btrfs_file_extent_disk_bytenr(eb, fi);
 	dbref_key.type = BTRFS_EXTENT_ITEM_KEY;
 	dbref_key.offset = btrfs_file_extent_disk_num_bytes(eb, fi);
@@ -3567,7 +3553,7 @@ static int check_block_group_item(struct extent_buffer *eb, int slot)
 	struct btrfs_root *chunk_root = gfs_info->chunk_root;
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key bg_key;
 	struct btrfs_key chunk_key;
 	struct btrfs_key extent_key;
@@ -3592,7 +3578,6 @@ static int check_block_group_item(struct extent_buffer *eb, int slot)
 	chunk_key.type = BTRFS_CHUNK_ITEM_KEY;
 	chunk_key.offset = bg_key.objectid;
 
-	btrfs_init_path(&path);
 	/* Search for the referencer chunk */
 	ret = btrfs_search_slot(NULL, chunk_root, &chunk_key, &path, 0, 0);
 	if (ret) {
@@ -3618,7 +3603,6 @@ static int check_block_group_item(struct extent_buffer *eb, int slot)
 	extent_key.type = 0;
 	extent_key.offset = 0;
 
-	btrfs_init_path(&path);
 	extent_root = btrfs_extent_root(gfs_info, extent_key.objectid);
 	ret = btrfs_search_slot(NULL, extent_root, &extent_key, &path, 0, 0);
 	if (ret < 0)
@@ -3697,7 +3681,7 @@ static int query_tree_block_level(u64 bytenr)
 {
 	struct btrfs_root *extent_root;
 	struct extent_buffer *eb;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
 	u64 flags;
@@ -3711,8 +3695,6 @@ static int query_tree_block_level(u64 bytenr)
 	key.type = BTRFS_METADATA_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	btrfs_init_path(&path);
-
 	extent_root = btrfs_extent_root(gfs_info, bytenr);
 	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret < 0)
@@ -3775,7 +3757,7 @@ static int check_tree_block_backref(u64 root_id, u64 bytenr, int level)
 {
 	struct btrfs_root *root;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *eb;
 	struct extent_buffer *node;
 	u32 nodesize = btrfs_super_nodesize(gfs_info->super_copy);
@@ -3821,7 +3803,6 @@ static int check_tree_block_backref(u64 root_id, u64 bytenr, int level)
 
 	free_extent_buffer(eb);
 
-	btrfs_init_path(&path);
 	path.lowest_level = level;
 	/* Search with the first key, to ensure we can reach it */
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
@@ -3947,7 +3928,7 @@ static int check_extent_data_backref(u64 root_id, u64 objectid, u64 offset,
 	struct btrfs_root *root;
 	struct btrfs_root *extent_root;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
 	u32 found_count = 0;
@@ -3959,7 +3940,6 @@ static int check_extent_data_backref(u64 root_id, u64 objectid, u64 offset,
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = (u64)-1;
 
-		btrfs_init_path(&path);
 		extent_root = btrfs_extent_root(gfs_info, bytenr);
 		ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 		if (ret < 0)
@@ -3977,7 +3957,6 @@ static int check_extent_data_backref(u64 root_id, u64 objectid, u64 offset,
 	key.objectid = root_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
-	btrfs_init_path(&path);
 
 	root = btrfs_read_fs_root(gfs_info, &key);
 	if (IS_ERR(root))
@@ -4445,7 +4424,7 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 {
 	struct btrfs_root *chunk_root = gfs_info->chunk_root;
 	struct btrfs_dev_extent *ptr;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key chunk_key;
 	struct btrfs_key devext_key;
 	struct btrfs_chunk *chunk;
@@ -4464,7 +4443,6 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 	chunk_key.type = BTRFS_CHUNK_ITEM_KEY;
 	chunk_key.offset = btrfs_dev_extent_chunk_offset(eb, ptr);
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, chunk_root, &chunk_key, &path, 0, 0);
 	if (ret)
 		goto out;
@@ -4508,7 +4486,7 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
 {
 	struct btrfs_root *dev_root = gfs_info->dev_root;
 	struct btrfs_dev_item *dev_item;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_dev_extent *ptr;
 	struct btrfs_device *dev;
@@ -4537,7 +4515,6 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, dev_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		btrfs_item_key_to_cpu(eb, &key, slot);
@@ -4681,7 +4658,7 @@ out:
 static int check_chunk_item(struct extent_buffer *eb, int slot)
 {
 	struct btrfs_root *dev_root = gfs_info->dev_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key chunk_key;
 	struct btrfs_key devext_key;
 	struct btrfs_chunk *chunk;
@@ -4711,7 +4688,6 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 	}
 	type = btrfs_chunk_type(eb, chunk);
 
-	btrfs_init_path(&path);
 	ret = find_block_group_item(&path, chunk_key.offset, length, type);
 	if (ret < 0)
 		err |= REFERENCER_MISSING;
@@ -4720,7 +4696,6 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 	stripe_len = btrfs_stripe_length(gfs_info, eb, chunk);
 	for (i = 0; i < num_stripes; i++) {
 		btrfs_release_path(&path);
-		btrfs_init_path(&path);
 		devext_key.objectid = btrfs_stripe_devid_nr(eb, chunk, i);
 		devext_key.type = BTRFS_DEV_EXTENT_KEY;
 		devext_key.offset = btrfs_stripe_offset_nr(eb, chunk, i);
@@ -5117,12 +5092,10 @@ static int repair_fs_first_inode(struct btrfs_root *root, int err)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int filetype = BTRFS_FT_DIR;
 	int ret = 0;
 
-	btrfs_init_path(&path);
-
 	if (err & INODE_REF_MISSING) {
 		key.objectid = BTRFS_FIRST_FREE_OBJECTID;
 		key.type = BTRFS_INODE_REF_KEY;
@@ -5178,7 +5151,7 @@ out:
  */
 static int check_fs_first_inode(struct btrfs_root *root)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_inode_item *ii;
 	u64 index;
@@ -5196,7 +5169,6 @@ static int check_fs_first_inode(struct btrfs_root *root)
 	    BTRFS_FIRST_FREE_OBJECTID)
 		return 0;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
 		goto out;
@@ -5250,7 +5222,7 @@ out:
  */
 static int check_btrfs_root(struct btrfs_root *root, int check_all)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct node_refs nrefs;
 	struct btrfs_root_item *root_item = &root->root_item;
 	u64 super_generation = btrfs_super_generation(gfs_info->super_copy);
@@ -5273,7 +5245,6 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 
 
 	level = btrfs_header_level(root->node);
-	btrfs_init_path(&path);
 
 	if (btrfs_root_generation(root_item) > super_generation + 1) {
 		error(
@@ -5358,7 +5329,7 @@ static int check_fs_root(struct btrfs_root *root)
 static int check_root_ref(struct btrfs_root *root, struct btrfs_key *ref_key,
 			  struct extent_buffer *node, int slot)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_root_ref *ref;
 	struct btrfs_root_ref *backref;
@@ -5395,7 +5366,6 @@ static int check_root_ref(struct btrfs_root *root, struct btrfs_key *ref_key,
 	key.type = BTRFS_ROOT_BACKREF_KEY + BTRFS_ROOT_REF_KEY - ref_key->type;
 	key.offset = ref_key->objectid;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret) {
 		err |= ROOT_REF_MISSING;
@@ -5450,14 +5420,13 @@ int check_fs_roots_lowmem(void)
 {
 	struct btrfs_root *tree_root = gfs_info->tree_root;
 	struct btrfs_root *cur_root = NULL;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct extent_buffer *node;
 	int slot;
 	int ret;
 	int err = 0;
 
-	btrfs_init_path(&path);
 	key.objectid = BTRFS_FS_TREE_OBJECTID;
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -5556,7 +5525,7 @@ out:
  */
 int check_chunks_and_extents_lowmem(void)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key old_key;
 	struct btrfs_key key;
 	struct btrfs_root *root;
@@ -5572,7 +5541,6 @@ int check_chunks_and_extents_lowmem(void)
 	ret = check_btrfs_root(root, 1);
 	err |= ret;
 
-	btrfs_init_path(&path);
 	key.objectid = BTRFS_EXTENT_TREE_OBJECTID;
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 1a62009b..0c08eae8 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -938,7 +938,7 @@ static int load_quota_info(struct btrfs_fs_info *info)
 	int ret;
 	struct btrfs_root *root = info->quota_root;
 	struct btrfs_root *tmproot;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_key root_key;
 	struct btrfs_disk_key disk_key;
@@ -954,8 +954,6 @@ loop:
 	 * items. The 2nd pass picks up relation items and glues them to their
 	 * respective count structures.
 	 */
-	btrfs_init_path(&path);
-
 	key.offset = 0;
 	key.objectid = search_relations ? 0 : BTRFS_QGROUP_RELATION_KEY;
 	key.type = 0;
@@ -1164,13 +1162,11 @@ static int scan_extents(struct btrfs_fs_info *info,
 	int ret, i, nr, level;
 	struct btrfs_root *root = btrfs_extent_root(info, start);
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *leaf;
 	u64 bytenr = 0, num_bytes = 0;
 
-	btrfs_init_path(&path);
-
 	key.objectid = start;
 	key.type = 0;
 	key.offset = 0;
@@ -1562,7 +1558,7 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	int ret;
 	struct btrfs_root *root = info->quota_root;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_qgroup_info_item *info_item;
 	struct btrfs_key key;
 
@@ -1575,7 +1571,6 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_INFO_KEY;
 	key.offset = count->qgroupid;
@@ -1619,7 +1614,7 @@ static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
 	int ret;
 	struct btrfs_root *root = info->quota_root;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_qgroup_status_item *status_item;
 
@@ -1630,7 +1625,6 @@ static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_STATUS_KEY;
 	key.offset = 0;
diff --git a/check/repair.c b/check/repair.c
index 44fefe3a..eacf4506 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -172,12 +172,11 @@ static int populate_used_from_extent_root(struct btrfs_root *root,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int slot;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 9726bef5..9c3de7aa 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -310,7 +310,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 {
 	struct btrfs_root *root;
 	struct btrfs_fs_info *info;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_root_item ri;
 	struct extent_buffer *leaf;
@@ -516,7 +516,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	}
 	tree_root_scan = info->tree_root;
 
-	btrfs_init_path(&path);
 again:
 	if (!extent_buffer_uptodate(tree_root_scan->node))
 		goto no_node;
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index d720d64a..e1808ec5 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -314,7 +314,7 @@ static int calc_root_size(struct btrfs_root *tree_root, struct btrfs_key *key,
 			  int find_inline)
 {
 	struct btrfs_root *root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct rb_node *n;
 	struct timeval start, end, diff = {0};
 	struct root_stats stat;
@@ -329,7 +329,6 @@ static int calc_root_size(struct btrfs_root *tree_root, struct btrfs_key *key,
 		return 1;
 	}
 
-	btrfs_init_path(&path);
 	memset(&stat, 0, sizeof(stat));
 	level = btrfs_header_level(root->node);
 	stat.lowest_bytenr = btrfs_header_bytenr(root->node);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index bf67fadc..e12dc61c 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -556,7 +556,7 @@ static int check_chunk_by_metadata(struct recover_control *rc,
 	int ret;
 	int i;
 	int slot;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_root *dev_root;
 	struct stripe *stripe;
@@ -564,8 +564,6 @@ static int check_chunk_by_metadata(struct recover_control *rc,
 	struct btrfs_block_group_item *bg_ptr;
 	struct extent_buffer *l;
 
-	btrfs_init_path(&path);
-
 	if (bg_only)
 		goto bg_check;
 
@@ -985,7 +983,7 @@ static int block_group_remove_all_extent_items(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	u64 start = bg->objectid;
 	u64 end = bg->objectid + bg->offset;
@@ -995,7 +993,6 @@ static int block_group_remove_all_extent_items(struct btrfs_trans_handle *trans,
 	int i;
 	int del_s, del_nr;
 
-	btrfs_init_path(&path);
 	root = btrfs_extent_root(fs_info, start);
 
 	key.objectid = start;
@@ -1384,14 +1381,13 @@ static int rebuild_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct chunk_record *chunk_rec;
 	struct btrfs_key search_key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	u64 used = 0;
 	int ret = 0;
 
 	if (list_empty(&rc->rebuild_chunks))
 		return 0;
 
-	btrfs_init_path(&path);
 	list_for_each_entry(chunk_rec, &rc->rebuild_chunks, list) {
 		search_key.objectid = chunk_rec->offset;
 		search_key.type = BTRFS_EXTENT_ITEM_KEY;
@@ -1968,7 +1964,7 @@ static int rebuild_raid_data_chunk_stripes(struct recover_control *rc,
 	int i;
 	int ret = 0;
 	int slot;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key prev_key;
 	struct btrfs_key key;
 	struct btrfs_root *csum_root;
@@ -1988,7 +1984,6 @@ static int rebuild_raid_data_chunk_stripes(struct recover_control *rc,
 	LIST_HEAD(unordered);
 	LIST_HEAD(candidates);
 
-	btrfs_init_path(&path);
 	list_splice_init(&chunk->dextents, &candidates);
 again:
 	if (list_is_last(candidates.next, &candidates))
diff --git a/cmds/restore.c b/cmds/restore.c
index ba085f94..b0e04a7e 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -474,7 +474,7 @@ static int set_file_xattrs(struct btrfs_root *root, u64 inode,
 			   int fd, const char *file_name)
 {
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	u32 name_len = 0;
@@ -485,7 +485,6 @@ static int set_file_xattrs(struct btrfs_root *root, u64 inode,
 	char *data = NULL;
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	key.objectid = inode;
 	key.type = BTRFS_XATTR_ITEM_KEY;
 	key.offset = 0;
@@ -571,11 +570,10 @@ out:
 static int copy_metadata(struct btrfs_root *root, int fd,
 		struct btrfs_key *key)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_inode_item *inode_item;
 	int ret;
 
-	btrfs_init_path(&path);
 	ret = btrfs_lookup_inode(NULL, root, &path, key, 0);
 	if (ret == 0) {
 		struct btrfs_timespec *bts;
@@ -620,7 +618,7 @@ static int copy_file(struct btrfs_root *root, int fd, struct btrfs_key *key,
 		     const char *file)
 {
 	struct extent_buffer *leaf;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_timespec *bts;
@@ -632,7 +630,6 @@ static int copy_file(struct btrfs_root *root, int fd, struct btrfs_key *key,
 	struct timespec times[2];
 	bool times_ok = false;
 
-	btrfs_init_path(&path);
 	ret = btrfs_lookup_inode(NULL, root, &path, key, 0);
 	if (ret == 0) {
 		inode_item = btrfs_item_ptr(path.nodes[0], path.slots[0],
@@ -798,7 +795,7 @@ static int overwrite_ok(const char * path)
 static int copy_symlink(struct btrfs_root *root, struct btrfs_key *key,
 		     const char *file)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *extent_item;
 	struct btrfs_inode_item *inode_item;
@@ -821,7 +818,6 @@ static int copy_symlink(struct btrfs_root *root, struct btrfs_key *key,
 		}
 	}
 
-	btrfs_init_path(&path);
 	key->type = BTRFS_EXTENT_DATA_KEY;
 	key->offset = 0;
 	ret = btrfs_search_slot(NULL, root, key, &path, 0, 0);
@@ -913,7 +909,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 		      const char *output_rootdir, const char *in_dir,
 		      const regex_t *mreg)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *dir_item;
 	struct btrfs_key found_key, location;
@@ -924,7 +920,6 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 	int fd;
 	u8 type;
 
-	btrfs_init_path(&path);
 	key->offset = 0;
 	key->type = BTRFS_DIR_INDEX_KEY;
 	ret = btrfs_search_slot(NULL, root, key, &path, 0, 0);
@@ -1159,7 +1154,7 @@ static int do_list_roots(struct btrfs_root *root)
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_disk_key disk_key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_root_item ri;
 	unsigned long offset;
@@ -1168,7 +1163,6 @@ static int do_list_roots(struct btrfs_root *root)
 
 	root = root->fs_info->tree_root;
 
-	btrfs_init_path(&path);
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -1287,13 +1281,12 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 
 static int find_first_dir(struct btrfs_root *root, u64 *objectid)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key found_key;
 	struct btrfs_key key;
 	int ret = -1;
 	int i;
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = 0;
diff --git a/convert/main.c b/convert/main.c
index da6d6cf4..a9a1e1d9 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -796,7 +796,7 @@ static int create_image(struct btrfs_root *root,
 {
 	struct btrfs_inode_item buf;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct cache_extent *cache;
 	struct cache_tree used_tmp;
@@ -813,7 +813,6 @@ static int create_image(struct btrfs_root *root,
 		return PTR_ERR(trans);
 
 	cache_tree_init(&used_tmp);
-	btrfs_init_path(&path);
 
 	ret = btrfs_find_free_objectid(trans, root, BTRFS_FIRST_FREE_OBJECTID,
 				       &ino);
@@ -1475,7 +1474,7 @@ static int check_convert_image(struct btrfs_root *image_root, u64 ino,
 			       u64 total_size, char *reserved_ranges[])
 {
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_fs_info *fs_info = image_root->fs_info;
 	u64 checked_bytes = 0;
 	int ret;
@@ -1484,7 +1483,6 @@ static int check_convert_image(struct btrfs_root *image_root, u64 ino,
 	key.offset = 0;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, image_root, &key, &path, 0, 0);
 	/*
 	 * It's possible that some fs doesn't store any (including sb)
@@ -1640,7 +1638,7 @@ static int do_rollback(const char *devname)
 	struct btrfs_root *image_root;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_dir_item *dir;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_root_ref *root_ref_item;
@@ -1700,7 +1698,6 @@ static int do_rollback(const char *devname)
 	key.objectid = CONV_IMAGE_SUBVOL_OBJECTID;
 	key.type = BTRFS_ROOT_BACKREF_KEY;
 	key.offset = BTRFS_FS_TREE_OBJECTID;
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, &path, 0, 0);
 	if (ret > 0) {
 		error("unable to find source fs image subvolume, is it deleted?");
diff --git a/convert/source-fs.c b/convert/source-fs.c
index f600b2c3..d206fab6 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -228,7 +228,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 	int ret = 0;
 	struct btrfs_root *root = data->root;
 	struct btrfs_root *convert_root = data->convert_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	u32 sectorsize = root->fs_info->sectorsize;
 	u64 file_pos = file_block * sectorsize;
 	u64 old_disk_bytenr = disk_block * sectorsize;
@@ -241,8 +241,6 @@ int record_file_blocks(struct blk_iterate_data *data,
 				data->objectid, data->inode, file_pos, 0,
 				num_bytes);
 
-	btrfs_init_path(&path);
-
 	/*
 	 * Search real disk bytenr from convert root
 	 */
diff --git a/image/common.c b/image/common.c
index 36e90fd2..3aa298d5 100644
--- a/image/common.c
+++ b/image/common.c
@@ -120,7 +120,7 @@ int update_disk_super_on_device(struct btrfs_fs_info *info,
 {
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_super_block disk_super;
 	char dev_uuid[BTRFS_UUID_SIZE];
@@ -134,7 +134,6 @@ int update_disk_super_on_device(struct btrfs_fs_info *info,
 	key.type = BTRFS_DEV_ITEM_KEY;
 	key.offset = cur_devid;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, info->chunk_root, &key, &path, 0, 0);
 	if (ret) {
 		error("search key failed: %d", ret);
diff --git a/image/image-create.c b/image/image-create.c
index baaeba4e..894969ed 100644
--- a/image/image-create.c
+++ b/image/image-create.c
@@ -753,7 +753,7 @@ int create_metadump(const char *input, FILE *out, int num_threads,
 		    int walk_trees, bool dump_data)
 {
 	struct btrfs_root *root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct metadump_struct metadump;
 	int ret;
 	int err = 0;
@@ -781,8 +781,6 @@ int create_metadump(const char *input, FILE *out, int num_threads,
 		goto out;
 	}
 
-	btrfs_init_path(&path);
-
 	if (walk_trees) {
 		ret = copy_tree_blocks(root, root->fs_info->chunk_root->node,
 				       &metadump, 1);
diff --git a/image/image-restore.c b/image/image-restore.c
index 771e169b..36cdc554 100644
--- a/image/image-restore.c
+++ b/image/image-restore.c
@@ -1426,7 +1426,7 @@ static int remove_all_dev_extents(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	int slot;
@@ -1435,7 +1435,6 @@ static int remove_all_dev_extents(struct btrfs_trans_handle *trans)
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
-	btrfs_init_path(&path);
 
 	ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
 	if (ret < 0) {
@@ -1574,7 +1573,7 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_ext;
 	struct btrfs_device *dev;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_key key;
@@ -1585,7 +1584,6 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 
 	dev_item = &fs_info->super_copy->dev_item;
 
-	btrfs_init_path(&path);
 	devid = btrfs_stack_device_id(dev_item);
 
 	key.objectid = devid;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index ed8a7002..bbbb2cc3 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -201,11 +201,6 @@ u64 btrfs_extref_hash(u64 parent_objectid, const char *name, int len)
 	return (u64)crc32c(parent_objectid, name, len);
 }
 
-inline void btrfs_init_path(struct btrfs_path *p)
-{
-	memset(p, 0, sizeof(*p));
-}
-
 struct btrfs_path *btrfs_alloc_path(void)
 {
 	might_sleep();
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index c7321a40..0d9b75bf 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -990,7 +990,6 @@ int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
-void btrfs_init_path(struct btrfs_path *p);
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 543a9952..55fdf881 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3462,7 +3462,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *block_group;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret = 0;
 
 	block_group = btrfs_lookup_block_group(fs_info, bytenr);
@@ -3484,7 +3484,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_pin_extent(fs_info, bytenr, len);
 
-	btrfs_init_path(&path);
 	/* delete block group item and chunk item */
 	ret = remove_block_group_item(trans, &path, block_group);
 	btrfs_release_path(&path);
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index 100ea31c..de5ecfea 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -187,7 +187,7 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *ii;
 	u64 isize;
@@ -203,7 +203,6 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 		return -EINVAL;
 	}
 
-	btrfs_init_path(&path);
 	key.objectid = ino;
 	key.offset = start;
 	key.type = BTRFS_EXTENT_DATA_KEY;
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index 7bd76e39..e27c1b62 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -910,7 +910,7 @@ int btrfs_clear_free_space_cache(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_disk_key location;
 	struct btrfs_free_space_header *sc_header;
@@ -919,8 +919,6 @@ int btrfs_clear_free_space_cache(struct btrfs_trans_handle *trans,
 	int slot;
 	int ret;
 
-	btrfs_init_path(&path);
-
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
 	key.type = 0;
 	key.offset = bg->start;
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 1430cf33..d4018406 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -585,7 +585,7 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *new_root = NULL;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -600,7 +600,6 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	if (len == 0 || len > BTRFS_NAME_LEN)
 		return NULL;
 
-	btrfs_init_path(&path);
 	key.objectid = dirid;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = (u64)-1;
@@ -705,7 +704,6 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 		new_root = NULL;
 	}
 fail:
-	btrfs_init_path(&path);
 	return new_root;
 }
 
@@ -737,7 +735,6 @@ int btrfs_find_free_objectid(struct btrfs_trans_handle *trans,
 	search_key.offset = 0;
 	search_key.type = 0;
 
-	btrfs_init_path(path);
 	start_found = 0;
 	ret = btrfs_search_slot(trans, root, &search_key, path, 0, 0);
 	if (ret < 0)
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index b7ca8b7e..a32c9a2a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1508,7 +1508,7 @@ out:
 static void bfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 {
 	struct btrfs_fs_info *fs_info = root_eb->fs_info;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int root_level = btrfs_header_level(root_eb);
 	int cur_level;
 	int ret;
@@ -1520,7 +1520,6 @@ static void bfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 	mode |= BTRFS_PRINT_TREE_BFS;
 	mode &= ~(BTRFS_PRINT_TREE_DFS);
 
-	btrfs_init_path(&path);
 	/* For path */
 	extent_buffer_get(root_eb);
 	path.nodes[root_level] = root_eb;
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 946c2e7a..831359be 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2680,7 +2680,7 @@ static int check_dev_extent_beyond_bytenr(struct btrfs_fs_info *fs_info,
 					  u64 physical)
 {
 	struct btrfs_root *root = fs_info->dev_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_dev_extent *dext;
 	struct btrfs_key key;
 	u64 dext_len;
@@ -2691,7 +2691,6 @@ static int check_dev_extent_beyond_bytenr(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = (u64)-1;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
@@ -2730,7 +2729,7 @@ static int reset_device_item_total_bytes(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
 	struct btrfs_dev_item *di;
 	u64 old_bytes = device->total_bytes;
@@ -2753,7 +2752,6 @@ static int reset_device_item_total_bytes(struct btrfs_fs_info *fs_info,
 		return ret;
 	}
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(trans, chunk_root, &key, &path, 0, 1);
 	if (ret > 0) {
 		error("failed to find DEV_ITEM for devid %llu", device->devid);
diff --git a/mkfs/main.c b/mkfs/main.c
index 1b917f55..4de57c8a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -235,11 +235,10 @@ err:
 
 static int __recow_root(struct btrfs_trans_handle *trans, struct btrfs_root *root)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 
-	btrfs_init_path(&path);
 	key.objectid = 0;
 	key.type = 0;
 	key.offset = 0;
@@ -590,10 +589,9 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -707,7 +705,7 @@ static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_inode_item *inode;
 	struct btrfs_root *root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key = {
 		.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
@@ -749,7 +747,6 @@ static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
 	key.objectid = ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	btrfs_init_path(&path);
 
 	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
 	if (ret > 0) {
@@ -851,7 +848,7 @@ static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_fs_info *fs_info,
 			       u64 qgroupid)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *quota_root = fs_info->quota_root;
 	struct btrfs_key key;
 	int ret;
@@ -865,7 +862,6 @@ static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_QGROUP_INFO_KEY;
 	key.offset = qgroupid;
 
-	btrfs_init_path(&path);
 	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
 				      sizeof(struct btrfs_qgroup_info_item));
 	btrfs_release_path(&path);
@@ -886,7 +882,7 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_qgroup_status_item *qsi;
 	struct btrfs_root *quota_root;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int qgroup_repaired = 0;
 	int ret;
@@ -910,7 +906,6 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 	key.type = BTRFS_QGROUP_STATUS_KEY;
 	key.offset = 0;
 
-	btrfs_init_path(&path);
 	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
 				      sizeof(*qsi));
 	if (ret < 0) {
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index a04d27af..bb2666ee 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -444,7 +444,7 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 	ino_t parent_inum, cur_inum;
 	ino_t highest_inum = 0;
 	const char *parent_dir_name;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct extent_buffer *leaf;
 	struct btrfs_key root_dir_key;
 	u64 root_dir_inode_size = 0;
@@ -465,8 +465,6 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 	dir_entry->inum = parent_inum;
 	list_add_tail(&dir_entry->list, &dir_head->list);
 
-	btrfs_init_path(&path);
-
 	root_dir_key.objectid = btrfs_root_dirid(&root->root_item);
 	root_dir_key.offset = 0;
 	root_dir_key.type = BTRFS_INODE_ITEM_KEY;
@@ -800,7 +798,7 @@ static int get_device_extent_end(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *dev_root = fs_info->dev_root;
 	struct btrfs_key key;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_dev_extent *de;
 	int ret;
 
@@ -808,7 +806,6 @@ static int get_device_extent_end(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = (u64)-1;
 
-	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, dev_root, &key, &path, 0, 0);
 	if (ret == 0) {
 		error("DEV_EXTENT for devid %llu not found", devid);
@@ -852,7 +849,7 @@ static int set_device_size(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_dev_item *di;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key;
 	int ret;
 
@@ -861,7 +858,6 @@ static int set_device_size(struct btrfs_fs_info *fs_info,
 	 * super->dev_item will also get updated
 	 */
 	device->total_bytes = new_size;
-	btrfs_init_path(&path);
 
 	/* Update device item in chunk tree */
 	trans = btrfs_start_transaction(chunk_root, 1);
diff --git a/quick-test.c b/quick-test.c
index 480e78bb..3f3c1cb3 100644
--- a/quick-test.c
+++ b/quick-test.c
@@ -41,7 +41,7 @@ int main(int ac, char **av) {
 	int run_size = 300000;
 	int max_key =  100000000;
 	int tree_size = 2;
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_root *root;
 	struct btrfs_trans_handle *trans;
 
@@ -86,7 +86,6 @@ int main(int ac, char **av) {
 	for (i = 0; i < run_size; i++) {
 		num = next_key(i, max_key);
 		ins.objectid = num;
-		btrfs_init_path(&path);
 		if (i % 10000 == 0)
 			fprintf(stderr, "search %d:%d\n", num, i);
 		ret = btrfs_search_slot(NULL, root, &ins, &path, 0, 0);
@@ -117,7 +116,6 @@ int main(int ac, char **av) {
 	for (i = 0 ; i < run_size/4; i++) {
 		num = next_key(i, max_key);
 		ins.objectid = num;
-		btrfs_init_path(&path);
 		ret = btrfs_search_slot(trans, root, &ins, &path, -1, 1);
 		if (!ret) {
 			if (i % 10000 == 0)
@@ -163,7 +161,6 @@ int main(int ac, char **av) {
 	for (i = 0; i < run_size; i++) {
 		num = next_key(i, max_key);
 		ins.objectid = num;
-		btrfs_init_path(&path);
 		if (i % 10000 == 0)
 			fprintf(stderr, "search %d:%d\n", num, i);
 		ret = btrfs_search_slot(NULL, root, &ins, &path, 0, 0);
@@ -181,7 +178,6 @@ int main(int ac, char **av) {
 		struct extent_buffer *leaf;
 		int slot;
 		ins.objectid = (u64)-1;
-		btrfs_init_path(&path);
 		ret = btrfs_search_slot(trans, root, &ins, &path, -1, 1);
 		if (ret == 0)
 			BUG();
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index 30cfb145..54184811 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -82,11 +82,10 @@ static int change_buffer_header_uuid(struct extent_buffer *eb, uuid_t new_fsid)
 static int change_extent_tree_uuid(struct btrfs_fs_info *fs_info, uuid_t new_fsid)
 {
 	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key = {0, 0, 0};
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	/*
 	 * Here we don't use transaction as it will takes a lot of reserve
 	 * space, and that will make a near-full btrfs unable to change uuid
@@ -162,11 +161,10 @@ static int change_device_uuid(struct extent_buffer *eb, int slot,
 
 static int change_chunk_tree_uuid(struct btrfs_root *root, uuid_t new_fsid)
 {
-	struct btrfs_path path;
+	struct btrfs_path path = {};
 	struct btrfs_key key = {0, 0, 0};
 	int ret = 0;
 
-	btrfs_init_path(&path);
 	/* No transaction again */
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
-- 
2.41.0

