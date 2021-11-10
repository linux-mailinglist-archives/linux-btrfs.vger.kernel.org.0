Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F2144CA4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhKJURh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhKJURg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:36 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC4C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:48 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z9so3268469qtj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ftJd5ouJkupGrNrVkwnDeYnPhB7HQuv+S3la/+gkQAA=;
        b=txTR32gOaaDiK/fJoXHfcys1Hf6a87SVC22FkVU2qdN+Wa5PIKjoADBzTsxBqmqNA+
         GCF3bs0O112X9EPf8PH+nDDg4LthkkMA/gvU1LLYmC+Q+pNRxK8TK1dWfoJXKJQkyO4+
         bmT+znkeNGOBmbv5G/VJHBz4g9WibaXnKMMqqLsbAy1Fpb9T6F8hEN/pidiUZyw1HPl9
         KmrhQchNt3MIVUXV1piZpzjN+55FdOs7OH2ZPQcBQxGPIDZz5AeW8o70kbnDNgQQwY1L
         G56SsjOO2deX/ceQr7IA0505GIjOhMuKY36Nt4kcD0KvmEihy7gRXidA/MhDRyIZbVnF
         ulEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftJd5ouJkupGrNrVkwnDeYnPhB7HQuv+S3la/+gkQAA=;
        b=UXuRM1esl1cSNY1lsx6N2PDFhID5iGA9BpPvCzoHRFCXX6nwV2cQYpwjBALk7tsyPZ
         QcGXuS5YV2BQTHTHcaM/zdW9roFZrqXtNF3cD3hAGol2DY/XplLCtsfU+dSyBBz1op5y
         ZXt9WmfUSECMJm7rLTRKJd9faAUNIwZAFTdfTIPnGgCFl+ew63vYF7ZrerjRUtY8KJh9
         Rj/vQfAA+EHsLrdtM6Ot/rWS+W4uaVQFTcF6uQ3OOOjoD32qaSV+lkDiNuaw2YjVG7i2
         qfqz2k1Ux85UrFdE/ZL+ORGkf/qooDNxw8ybLJqbnjTLz0Xer5nmJowk1t5iUmNRuGNt
         oiYg==
X-Gm-Message-State: AOAM530oa/pBzn5Sv7t4L4JxpYACWLR4R7c2ocCi8UcVgwVMOIjUcOld
        lcYkeQEyIWNsFZn8B74n2cV4qY+OUlmtVg==
X-Google-Smtp-Source: ABdhPJwK6QGQTBsbEv9OmHMtr52QI7MF3noir6+ogG3IOSyMzQwzBXFIlw3NYPezsMV7jHCDQwXFVQ==
X-Received: by 2002:a05:622a:1115:: with SMTP id e21mr1824227qty.315.1636575286714;
        Wed, 10 Nov 2021 12:14:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v15sm440811qkl.91.2021.11.10.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/30] btrfs-progs: stop accessing ->extent_root directly
Date:   Wed, 10 Nov 2021 15:14:13 -0500
Message-Id: <28e56d362e833756b928bf9c356127dcee5c3874.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we switch to multiple global trees we'll need to access the
appropriate extent root depending on the block group or possibly root.
To handle this, use a helper in most places and then the actual root in
places where it is required.  We will whittle down the direct accessors
with future patches, but this does the bulk of the preparatory work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c           | 13 +++---
 btrfs-map-logical.c             |  9 ++--
 btrfstune.c                     |  2 +-
 check/main.c                    | 78 +++++++++++++++++++--------------
 check/mode-common.c             |  8 ++--
 check/mode-lowmem.c             | 72 +++++++++++++++++-------------
 check/qgroup-verify.c           |  2 +-
 cmds/rescue-chunk-recover.c     | 18 ++++----
 common/repair.c                 |  5 +--
 convert/main.c                  |  4 +-
 image/main.c                    |  2 +-
 kernel-shared/backref.c         | 10 +++--
 kernel-shared/ctree.h           |  2 +-
 kernel-shared/disk-io.c         | 30 ++++++++-----
 kernel-shared/disk-io.h         |  1 +
 kernel-shared/extent-tree.c     | 42 ++++++++++--------
 kernel-shared/free-space-tree.c |  8 +++-
 kernel-shared/volumes.c         |  3 +-
 kernel-shared/zoned.c           |  2 +-
 mkfs/main.c                     |  4 +-
 20 files changed, 179 insertions(+), 136 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index d7904b6f..d976345c 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -183,6 +183,7 @@ static int corrupt_keys_in_block(struct btrfs_fs_info *fs_info, u64 bytenr)
 static int corrupt_extent(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 bytenr)
 {
+	struct btrfs_root *extent_root;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	u32 item_size;
@@ -200,9 +201,9 @@ static int corrupt_extent(struct btrfs_trans_handle *trans,
 	key.type = (u8)-1;
 	key.offset = (u64)-1;
 
+	extent_root = btrfs_extent_root(trans->fs_info, bytenr);
 	while(1) {
-		ret = btrfs_search_slot(trans, root->fs_info->extent_root,
-					&key, path, -1, 1);
+		ret = btrfs_search_slot(trans, extent_root, &key, path, -1, 1);
 		if (ret < 0)
 			break;
 
@@ -472,7 +473,7 @@ static int corrupt_block_group(struct btrfs_root *root, u64 bg, char *field)
 	u64 orig, bogus;
 	int ret = 0;
 
-	root = root->fs_info->extent_root;
+	root = btrfs_extent_root(root->fs_info, 0);
 
 	corrupt_field = convert_block_group_field(field);
 	if (corrupt_field == BTRFS_BLOCK_GROUP_ITEM_BAD) {
@@ -1382,11 +1383,13 @@ int main(int argc, char **argv)
 	}
 	if (extent_tree) {
 		struct btrfs_trans_handle *trans;
+		struct btrfs_root *extent_root;
 
+		extent_root = btrfs_extent_root(root->fs_info, 0);
 		trans = btrfs_start_transaction(root, 1);
 		BUG_ON(IS_ERR(trans));
-		btrfs_corrupt_extent_tree(trans, root->fs_info->extent_root,
-					  root->fs_info->extent_root->node);
+		btrfs_corrupt_extent_tree(trans, extent_root,
+					  extent_root->node);
 		btrfs_commit_transaction(trans, root);
 		goto out_close;
 	}
diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 4ac644b4..b3a7526b 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -42,6 +42,7 @@ static FILE *info_file;
 static int map_one_extent(struct btrfs_fs_info *fs_info,
 			  u64 *logical_ret, u64 *len_ret, int search_forward)
 {
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	u64 logical;
@@ -59,8 +60,8 @@ static int map_one_extent(struct btrfs_fs_info *fs_info,
 	key.type = 0;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path,
-				0, 0);
+	extent_root = btrfs_extent_root(fs_info, logical);
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
 	BUG_ON(ret == 0);
@@ -73,10 +74,10 @@ again:
 	    (key.type != BTRFS_EXTENT_ITEM_KEY &&
 	     key.type != BTRFS_METADATA_ITEM_KEY)) {
 		if (!search_forward)
-			ret = btrfs_previous_extent_item(fs_info->extent_root,
+			ret = btrfs_previous_extent_item(extent_root,
 							 path, 0);
 		else
-			ret = btrfs_next_extent_item(fs_info->extent_root,
+			ret = btrfs_next_extent_item(extent_root,
 						     path, 0);
 		if (ret)
 			goto out;
diff --git a/btrfstune.c b/btrfstune.c
index d34d89c1..4f77cfc0 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -233,7 +233,7 @@ static int change_buffer_header_uuid(struct extent_buffer *eb, uuid_t new_fsid)
 
 static int change_extents_uuid(struct btrfs_fs_info *fs_info, uuid_t new_fsid)
 {
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
 	struct btrfs_path path;
 	struct btrfs_key key = {0, 0, 0};
 	int ret = 0;
diff --git a/check/main.c b/check/main.c
index 632dfba0..e3e5a336 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5619,7 +5619,7 @@ static int verify_space_cache(struct btrfs_root *root,
 	u64 last;
 	int ret = 0;
 
-	root = gfs_info->extent_root;
+	root = btrfs_extent_root(root->fs_info, cache->start);
 
 	last = max_t(u64, cache->start, BTRFS_SUPER_INFO_OFFSET);
 
@@ -5837,6 +5837,7 @@ out:
 static int check_extent_exists(struct btrfs_root *root, u64 bytenr,
 			       u64 num_bytes)
 {
+	struct btrfs_root *extent_root;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -5848,7 +5849,8 @@ static int check_extent_exists(struct btrfs_root *root, u64 bytenr,
 	key.offset = (u64)-1;
 
 again:
-	ret = btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path,
+	extent_root = btrfs_extent_root(gfs_info, key.objectid);
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path,
 				0, 0);
 	if (ret < 0) {
 		fprintf(stderr, "Error looking up extent record %d\n", ret);
@@ -5858,7 +5860,7 @@ again:
 		if (path.slots[0] > 0) {
 			path.slots[0]--;
 		} else {
-			ret = btrfs_prev_leaf(root, &path);
+			ret = btrfs_prev_leaf(extent_root, &path);
 			if (ret < 0) {
 				goto out;
 			} else if (ret > 0) {
@@ -5882,7 +5884,7 @@ again:
 		if (path.slots[0] > 0) {
 			path.slots[0]--;
 		} else {
-			ret = btrfs_prev_leaf(root, &path);
+			ret = btrfs_prev_leaf(extent_root, &path);
 			if (ret < 0) {
 				goto out;
 			} else if (ret > 0) {
@@ -5895,7 +5897,7 @@ again:
 
 	while (num_bytes) {
 		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-			ret = btrfs_next_leaf(root, &path);
+			ret = btrfs_next_leaf(extent_root, &path);
 			if (ret < 0) {
 				fprintf(stderr, "Error going to next leaf "
 					"%d\n", ret);
@@ -5946,7 +5948,8 @@ again:
 				 * anyway just in case.
 				 */
 				btrfs_release_path(&path);
-				ret = check_extent_exists(root, new_start,
+				ret = check_extent_exists(extent_root,
+							  new_start,
 							  new_bytes);
 				if (ret) {
 					fprintf(stderr, "Right section didn't "
@@ -6720,6 +6723,7 @@ static int delete_extent_records(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 u64 bytenr)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, bytenr);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
@@ -6732,7 +6736,7 @@ static int delete_extent_records(struct btrfs_trans_handle *trans,
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(trans, gfs_info->extent_root, &key,
+		ret = btrfs_search_slot(trans, extent_root, &key,
 					path, 0, 1);
 		if (ret < 0)
 			break;
@@ -6775,7 +6779,7 @@ static int delete_extent_records(struct btrfs_trans_handle *trans,
 			"repair deleting extent record: key [%llu,%u,%llu]\n",
 			found_key.objectid, found_key.type, found_key.offset);
 
-		ret = btrfs_del_item(trans, gfs_info->extent_root, path);
+		ret = btrfs_del_item(trans, extent_root, path);
 		if (ret)
 			break;
 		btrfs_release_path(path);
@@ -6807,7 +6811,8 @@ static int record_extent(struct btrfs_trans_handle *trans,
 			 int allocated, u64 flags)
 {
 	int ret = 0;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info,
+							   rec->start);
 	struct extent_buffer *leaf;
 	struct btrfs_key ins_key;
 	struct btrfs_extent_item *ei;
@@ -6888,7 +6893,7 @@ static int record_extent(struct btrfs_trans_handle *trans,
 			 * just makes the backref allocator create a data
 			 * backref
 			 */
-			ret = btrfs_inc_extent_ref(trans, gfs_info->extent_root,
+			ret = btrfs_inc_extent_ref(trans, extent_root,
 						   rec->start, rec->max_size,
 						   parent,
 						   dback->root,
@@ -6917,7 +6922,7 @@ static int record_extent(struct btrfs_trans_handle *trans,
 		else
 			parent = 0;
 
-		ret = btrfs_inc_extent_ref(trans, gfs_info->extent_root,
+		ret = btrfs_inc_extent_ref(trans, extent_root,
 					   rec->start, rec->max_size,
 					   parent, tback->root, 0, 0);
 		fprintf(stderr,
@@ -7437,7 +7442,6 @@ static int delete_duplicate_records(struct btrfs_root *root,
 		list_move_tail(&tmp->list, &delete_list);
 	}
 
-	root = gfs_info->extent_root;
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -7459,6 +7463,7 @@ static int delete_duplicate_records(struct btrfs_root *root,
 			abort();
 		}
 
+		root = btrfs_extent_root(gfs_info, key.objectid);
 		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
 		if (ret) {
 			if (ret > 0)
@@ -7697,7 +7702,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
 	if (ret < 0)
 		goto out;
 
-	trans = btrfs_start_transaction(gfs_info->extent_root, 1);
+	trans = btrfs_start_transaction(gfs_info->tree_root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -7736,7 +7741,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
 	}
 out:
 	if (trans) {
-		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
+		int err = btrfs_commit_transaction(trans, gfs_info->tree_root);
 
 		if (!ret)
 			ret = err;
@@ -7753,7 +7758,7 @@ out:
 static int fixup_extent_flags(struct extent_record *rec)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = gfs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(gfs_info, rec->start);
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
@@ -7822,6 +7827,7 @@ retry:
 static int prune_one_block(struct btrfs_trans_handle *trans,
 			   struct btrfs_corrupt_block *corrupt)
 {
+	struct btrfs_root *extent_root;
 	int ret;
 	struct btrfs_path path;
 	struct extent_buffer *eb;
@@ -7832,11 +7838,12 @@ static int prune_one_block(struct btrfs_trans_handle *trans,
 
 	btrfs_init_path(&path);
 again:
+	extent_root = btrfs_extent_root(gfs_info, corrupt->key.objectid);
 	/* we want to stop at the parent to our busted block */
 	path.lowest_level = level;
 
-	ret = btrfs_search_slot(trans, gfs_info->extent_root,
-				&corrupt->key, &path, -1, 1);
+	ret = btrfs_search_slot(trans, extent_root, &corrupt->key, &path,
+				-1, 1);
 
 	if (ret < 0)
 		goto out;
@@ -7868,7 +7875,7 @@ again:
 	 * We couldn't find the bad block.
 	 * TODO: search all the nodes for pointers to this block
 	 */
-	if (eb == gfs_info->extent_root->node) {
+	if (eb == extent_root->node) {
 		ret = -ENOENT;
 		goto out;
 	} else {
@@ -7879,7 +7886,7 @@ again:
 
 del_ptr:
 	printk("deleting pointer to block %llu\n", corrupt->cache.start);
-	ret = btrfs_del_ptr(gfs_info->extent_root, &path, level, slot);
+	ret = btrfs_del_ptr(extent_root, &path, level, slot);
 
 out:
 	btrfs_release_path(&path);
@@ -7897,7 +7904,7 @@ static int prune_corrupt_blocks(void)
 		if (!cache)
 			break;
 		if (!trans) {
-			trans = btrfs_start_transaction(gfs_info->extent_root, 1);
+			trans = btrfs_start_transaction(gfs_info->tree_root, 1);
 			if (IS_ERR(trans))
 				return PTR_ERR(trans);
 		}
@@ -7906,7 +7913,7 @@ static int prune_corrupt_blocks(void)
 		remove_cache_extent(gfs_info->corrupt_blocks, cache);
 	}
 	if (trans)
-		return btrfs_commit_transaction(trans, gfs_info->extent_root);
+		return btrfs_commit_transaction(trans, gfs_info->tree_root);
 	return 0;
 }
 
@@ -8011,7 +8018,8 @@ static int repair_extent_item_generation(struct extent_record *rec)
 	struct btrfs_path path;
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info,
+							   rec->start);
 	u64 new_gen = 0;;
 	int ret;
 
@@ -8258,7 +8266,6 @@ repair_abort:
 		} else if (!ret) {
 			struct btrfs_trans_handle *trans;
 
-			root = gfs_info->extent_root;
 			trans = btrfs_start_transaction(root, 1);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
@@ -8714,7 +8721,7 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 	if (!repair || !ret)
 		return ret;
 
-	trans = btrfs_start_transaction(gfs_info->extent_root, 1);
+	trans = btrfs_start_transaction(gfs_info->tree_root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		fprintf(stderr, "Failed to start a transaction\n");
@@ -8722,7 +8729,7 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 	}
 
 	ret = btrfs_fix_block_accounting(trans);
-	btrfs_commit_transaction(trans, gfs_info->extent_root);
+	btrfs_commit_transaction(trans, gfs_info->tree_root);
 	return ret ? ret : -EAGAIN;
 }
 
@@ -9368,7 +9375,7 @@ again:
 	}
 
 	/* Ok we can allocate now, reinit the extent root */
-	ret = btrfs_fsck_reinit_root(trans, gfs_info->extent_root);
+	ret = btrfs_fsck_reinit_root(trans, btrfs_extent_root(gfs_info, 0));
 	if (ret) {
 		fprintf(stderr, "extent root initialization failed\n");
 		/*
@@ -9387,6 +9394,7 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group *cache;
+		struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -9400,8 +9408,8 @@ again:
 		key.objectid = cache->start;
 		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		key.offset = cache->length;
-		ret = btrfs_insert_item(trans, gfs_info->extent_root, &key,
-					&bgi, sizeof(bgi));
+		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
+					sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
 			return ret;
@@ -9618,7 +9626,7 @@ out:
 
 static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 {
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
@@ -9721,6 +9729,7 @@ static void free_roots_info_cache(void)
 
 static int build_roots_info_cache(void)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 	int ret = 0;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
@@ -9737,7 +9746,7 @@ static int build_roots_info_cache(void)
 	key.objectid = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret < 0)
 		goto out;
 	leaf = path.nodes[0];
@@ -9757,7 +9766,7 @@ static int build_roots_info_cache(void)
 
 		ctx.item_count++;
 		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(gfs_info->extent_root, &path);
+			ret = btrfs_next_leaf(extent_root, &path);
 			if (ret < 0) {
 				break;
 			} else if (ret) {
@@ -10670,7 +10679,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	if (init_extent_tree || init_csum_tree) {
 		struct btrfs_trans_handle *trans;
 
-		trans = btrfs_start_transaction(gfs_info->extent_root, 0);
+		trans = btrfs_start_transaction(gfs_info->tree_root, 0);
 		if (IS_ERR(trans)) {
 			error("error starting transaction");
 			ret = PTR_ERR(trans);
@@ -10711,12 +10720,13 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		 * Ok now we commit and run the normal fsck, which will add
 		 * extent entries for all of the items it finds.
 		 */
-		ret = btrfs_commit_transaction(trans, gfs_info->extent_root);
+		ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
 		err |= !!ret;
 		if (ret)
 			goto close_out;
 	}
-	if (!extent_buffer_uptodate(gfs_info->extent_root->node)) {
+	root = btrfs_extent_root(gfs_info, 0);
+	if (!extent_buffer_uptodate(root->node)) {
 		error("critical: extent_root, unable to check the filesystem");
 		ret = -EIO;
 		err |= !!ret;
diff --git a/check/mode-common.c b/check/mode-common.c
index 56377840..72fec47c 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -176,6 +176,8 @@ static int check_prealloc_shared_data_ref(u64 parent, u64 disk_bytenr)
  */
 int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info,
+							   disk_bytenr);
 	struct btrfs_path path;
 	struct btrfs_key key;
 	int ret;
@@ -189,7 +191,7 @@ int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 	key.offset = num_bytes;
 
 	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret > 0) {
 		fprintf(stderr,
 	"Missing extent item in extent tree for disk_bytenr %llu, num_bytes %llu\n",
@@ -240,7 +242,7 @@ int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 	path.slots[0]++;
 	while (true) {
 		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-			ret = btrfs_next_leaf(gfs_info->extent_root, &path);
+			ret = btrfs_next_leaf(extent_root, &path);
 			if (ret < 0)
 				goto out;
 			if (ret > 0) {
@@ -1083,7 +1085,7 @@ int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb)
  */
 int get_extent_item_generation(u64 bytenr, u64 *gen_ret)
 {
-	struct btrfs_root *root = gfs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(gfs_info, bytenr);
 	struct btrfs_extent_item *ei;
 	struct btrfs_path path;
 	struct btrfs_key key;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 696ad215..cc6773cd 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -33,7 +33,7 @@ static u64 total_used = 0;
 static int calc_extent_flag(struct btrfs_root *root, struct extent_buffer *eb,
 			    u64 *flags_ret)
 {
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_root_item *ri = &root->root_item;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_extent_item *ei;
@@ -73,6 +73,7 @@ static int calc_extent_flag(struct btrfs_root *root, struct extent_buffer *eb,
 	key.type = (u8)-1;
 	key.offset = (u64)-1;
 
+	extent_root = btrfs_extent_root(gfs_info, key.objectid);
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret <= 0) {
 		ret = -EIO;
@@ -265,7 +266,7 @@ static int modify_block_group_cache(struct btrfs_block_group *block_group, int c
  */
 static int modify_block_groups_cache(u64 flags, int cache)
 {
-	struct btrfs_root *root = gfs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct btrfs_block_group *bg_cache;
@@ -330,7 +331,7 @@ static int clear_block_groups_full(u64 flags)
 static int create_chunk_and_block_group(u64 flags, u64 *start, u64 *nbytes)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = gfs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
 	int ret;
 
 	if ((flags & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)
@@ -418,7 +419,7 @@ static int is_chunk_almost_full(u64 start)
 {
 	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_root *root = gfs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
 	struct extent_buffer *eb;
@@ -594,10 +595,9 @@ out:
 static int repair_block_accounting(void)
 {
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_root *root = gfs_info->extent_root;
 	int ret;
 
-	trans = btrfs_start_transaction(root, 1);
+	trans = btrfs_start_transaction(gfs_info->tree_root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		errno = -ret;
@@ -606,7 +606,7 @@ static int repair_block_accounting(void)
 	}
 
 	ret = btrfs_fix_block_accounting(trans);
-	btrfs_commit_transaction(trans, root);
+	btrfs_commit_transaction(trans, gfs_info->tree_root);
 	return ret;
 }
 
@@ -622,7 +622,7 @@ static int repair_tree_block_ref(struct btrfs_root *root,
 				 struct node_refs *nrefs, int level, int err)
 {
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
 	struct btrfs_tree_block_info *bi;
@@ -656,6 +656,7 @@ static int repair_tree_block_ref(struct btrfs_root *root,
 	key.offset = (u64)-1;
 
 	/* Search for the extent item */
+	extent_root = btrfs_extent_root(gfs_info, bytenr);
 	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret <= 0) {
 		ret = -EIO;
@@ -3001,7 +3002,7 @@ static int check_tree_block_ref(struct btrfs_root *root,
 				int level, u64 owner, struct node_refs *nrefs)
 {
 	struct btrfs_key key;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
@@ -3030,6 +3031,7 @@ static int check_tree_block_ref(struct btrfs_root *root,
 	key.offset = (u64)-1;
 
 	/* Search for the backref in extent tree */
+	extent_root = btrfs_extent_root(gfs_info, bytenr);
 	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		err |= BACKREF_MISSING;
@@ -3222,7 +3224,7 @@ static int repair_extent_data_item(struct btrfs_root *root,
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
 	struct btrfs_path path;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct extent_buffer *eb;
 	u64 size;
 	u64 disk_bytenr;
@@ -3274,6 +3276,7 @@ static int repair_extent_data_item(struct btrfs_root *root,
 	key.offset = num_bytes;
 
 	btrfs_init_path(&path);
+	extent_root = btrfs_extent_root(gfs_info, key.objectid);
 	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		ret = -EIO;
@@ -3356,7 +3359,7 @@ static int check_extent_data_item(struct btrfs_root *root,
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = pathp->nodes[0];
 	struct btrfs_path path;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_key fi_key;
 	struct btrfs_key dbref_key;
 	struct extent_buffer *leaf;
@@ -3426,6 +3429,7 @@ static int check_extent_data_item(struct btrfs_root *root,
 	dbref_key.type = BTRFS_EXTENT_ITEM_KEY;
 	dbref_key.offset = btrfs_file_extent_disk_num_bytes(eb, fi);
 
+	extent_root = btrfs_extent_root(gfs_info, dbref_key.objectid);
 	ret = btrfs_search_slot(NULL, extent_root, &dbref_key, &path, 0, 0);
 	if (ret)
 		goto out;
@@ -3499,8 +3503,9 @@ static int check_extent_data_item(struct btrfs_root *root,
 		dbref_key.offset = hash_extent_data_ref(owner, fi_key.objectid,
 							fi_key.offset - offset);
 
-		ret = btrfs_search_slot(NULL, gfs_info->extent_root,
-					&dbref_key, &path, 0, 0);
+		extent_root = btrfs_extent_root(gfs_info, dbref_key.objectid);
+		ret = btrfs_search_slot(NULL, extent_root, &dbref_key, &path, 0,
+					0);
 		if (!ret) {
 			found_dbackref = 1;
 			goto out;
@@ -3516,8 +3521,8 @@ static int check_extent_data_item(struct btrfs_root *root,
 		dbref_key.type = BTRFS_SHARED_DATA_REF_KEY;
 		dbref_key.offset = eb->start;
 
-		ret = btrfs_search_slot(NULL, gfs_info->extent_root,
-					&dbref_key, &path, 0, 0);
+		ret = btrfs_search_slot(NULL, extent_root, &dbref_key, &path, 0,
+					0);
 		if (!ret) {
 			found_dbackref = 1;
 			goto out;
@@ -3542,7 +3547,7 @@ out:
  */
 static int check_block_group_item(struct extent_buffer *eb, int slot)
 {
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_root *chunk_root = gfs_info->chunk_root;
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
@@ -3598,6 +3603,7 @@ static int check_block_group_item(struct extent_buffer *eb, int slot)
 	extent_key.offset = 0;
 
 	btrfs_init_path(&path);
+	extent_root = btrfs_extent_root(gfs_info, extent_key.objectid);
 	ret = btrfs_search_slot(NULL, extent_root, &extent_key, &path, 0, 0);
 	if (ret < 0)
 		goto out;
@@ -3673,6 +3679,7 @@ out:
  */
 static int query_tree_block_level(u64 bytenr)
 {
+	struct btrfs_root *extent_root;
 	struct extent_buffer *eb;
 	struct btrfs_path path;
 	struct btrfs_key key;
@@ -3689,10 +3696,12 @@ static int query_tree_block_level(u64 bytenr)
 	key.offset = (u64)-1;
 
 	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, gfs_info->extent_root, &key, &path, 0, 0);
+
+	extent_root = btrfs_extent_root(gfs_info, bytenr);
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 	if (ret < 0)
 		goto release_out;
-	ret = btrfs_previous_extent_item(gfs_info->extent_root, &path, bytenr);
+	ret = btrfs_previous_extent_item(extent_root, &path, bytenr);
 	if (ret < 0)
 		goto release_out;
 	if (ret > 0) {
@@ -3920,7 +3929,7 @@ static int check_extent_data_backref(u64 root_id, u64 objectid, u64 offset,
 				     u64 bytenr, u64 len, u32 count)
 {
 	struct btrfs_root *root;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
@@ -3935,6 +3944,7 @@ static int check_extent_data_backref(u64 root_id, u64 objectid, u64 offset,
 		key.offset = (u64)-1;
 
 		btrfs_init_path(&path);
+		extent_root = btrfs_extent_root(gfs_info, bytenr);
 		ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
 		if (ret < 0)
 			goto out;
@@ -4084,13 +4094,13 @@ out:
  * Returns >0   the backref was deleted but extent still exists
  * Returns =0   the whole extent item was deleted
  */
-static int repair_extent_item(struct btrfs_root *root, struct btrfs_path *path,
-		      u64 bytenr, u64 num_bytes, u64 parent, u64 root_objectid,
-		      u64 owner, u64 offset)
+static int repair_extent_item(struct btrfs_path *path, u64 bytenr, u64
+			      num_bytes, u64 parent, u64 root_objectid, u64
+			      owner, u64 offset)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
 	struct btrfs_key old_key;
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, bytenr);
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &old_key, path->slots[0]);
@@ -4121,7 +4131,7 @@ static int repair_extent_item(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_commit_transaction(trans, extent_root);
 
 	btrfs_release_path(path);
-	ret = btrfs_search_slot(NULL, root, &old_key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, extent_root, &old_key, path, 0, 0);
 	if (ret > 0) {
 		/* odd, there must be one block group before at least */
 		if (path->slots[0] == 0) {
@@ -4159,7 +4169,7 @@ static int repair_extent_item_generation(struct btrfs_path *path)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	u64 new_gen = 0;;
 	int ret;
 
@@ -4172,6 +4182,7 @@ static int repair_extent_item_generation(struct btrfs_path *path)
 	if (ret)
 		return ret;
 	btrfs_release_path(path);
+	extent_root = btrfs_extent_root(gfs_info, key.objectid);
 	trans = btrfs_start_transaction(extent_root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -4349,9 +4360,8 @@ next:
 
 	if ((tmp_err & (REFERENCER_MISSING | REFERENCER_MISMATCH))
 	    && repair) {
-		ret = repair_extent_item(gfs_info->extent_root, path,
-			 key.objectid, num_bytes, parent, root_objectid,
-			 owner, owner_offset);
+		ret = repair_extent_item(path, key.objectid, num_bytes, parent,
+					 root_objectid, owner, owner_offset);
 		if (ret < 0) {
 			err |= tmp_err;
 			err |= FATAL_ERROR;
@@ -4581,6 +4591,7 @@ next:
 static int find_block_group_item(struct btrfs_path *path, u64 bytenr, u64 len,
 				 u64 type)
 {
+	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int ret;
@@ -4589,7 +4600,7 @@ static int find_block_group_item(struct btrfs_path *path, u64 bytenr, u64 len,
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = len;
 
-	ret = btrfs_search_slot(NULL, gfs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -4705,7 +4716,7 @@ static int repair_chunk_item(struct btrfs_root *chunk_root,
 	struct btrfs_chunk *chunk;
 	struct btrfs_key chunk_key;
 	struct extent_buffer *eb = path->nodes[0];
-	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_trans_handle *trans;
 	u64 length;
 	int slot = path->slots[0];
@@ -4715,6 +4726,7 @@ static int repair_chunk_item(struct btrfs_root *chunk_root,
 	btrfs_item_key_to_cpu(eb, &chunk_key, slot);
 	if (chunk_key.type != BTRFS_CHUNK_ITEM_KEY)
 		return err;
+	extent_root = btrfs_extent_root(gfs_info, chunk_key.offset);
 	chunk = btrfs_item_ptr(eb, slot, struct btrfs_chunk);
 	type = btrfs_chunk_type(path->nodes[0], chunk);
 	length = btrfs_chunk_length(eb, chunk);
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index a514fee1..0813b841 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1157,7 +1157,7 @@ static int scan_extents(struct btrfs_fs_info *info,
 			u64 start, u64 end)
 {
 	int ret, i, nr, level;
-	struct btrfs_root *root = info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(info, start);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct btrfs_disk_key disk_key;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 115d91d7..3bf9c36c 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -555,6 +555,7 @@ static int check_chunk_by_metadata(struct recover_control *rc,
 				   struct btrfs_root *root,
 				   struct chunk_record *chunk, int bg_only)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	int i;
 	int slot;
@@ -616,7 +617,8 @@ bg_check:
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = chunk->length;
 
-	ret = btrfs_search_slot(NULL, root->fs_info->extent_root, &key, &path,
+	root = btrfs_extent_root(fs_info, key.objectid);
+	ret = btrfs_search_slot(NULL, root, &key, &path,
 				0, 0);
 	if (ret < 0) {
 		fprintf(stderr, "Search block group failed(%d)\n", ret);
@@ -997,7 +999,7 @@ static int block_group_remove_all_extent_items(struct btrfs_trans_handle *trans,
 	int del_s, del_nr;
 
 	btrfs_init_path(&path);
-	root = root->fs_info->extent_root;
+	root = btrfs_extent_root(fs_info, start);
 
 	key.objectid = start;
 	key.offset = 0;
@@ -1382,6 +1384,7 @@ static int rebuild_block_group(struct btrfs_trans_handle *trans,
 			       struct recover_control *rc,
 			       struct btrfs_root *root)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct chunk_record *chunk_rec;
 	struct btrfs_key search_key;
 	struct btrfs_path path;
@@ -1396,12 +1399,11 @@ static int rebuild_block_group(struct btrfs_trans_handle *trans,
 		search_key.objectid = chunk_rec->offset;
 		search_key.type = BTRFS_EXTENT_ITEM_KEY;
 		search_key.offset = 0;
-		ret = btrfs_search_slot(NULL, root->fs_info->extent_root,
-					&search_key, &path, 0, 0);
+		root = btrfs_extent_root(fs_info, chunk_rec->offset);
+		ret = btrfs_search_slot(NULL, root, &search_key, &path, 0, 0);
 		if (ret < 0)
 			goto out;
-		ret = calculate_bg_used(root->fs_info->extent_root,
-					chunk_rec, &path, &used);
+		ret = calculate_bg_used(root, chunk_rec, &path, &used);
 		/*
 		 * Extent tree is damaged, better to rebuild the whole extent
 		 * tree. Currently, change the used to chunk's len to prevent
@@ -1417,9 +1419,7 @@ static int rebuild_block_group(struct btrfs_trans_handle *trans,
 			used = chunk_rec->length;
 		}
 		btrfs_release_path(&path);
-		ret = __insert_block_group(trans, chunk_rec,
-					   root->fs_info->extent_root,
-					   used);
+		ret = __insert_block_group(trans, chunk_rec, root, used);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/common/repair.c b/common/repair.c
index 176665bb..41520b32 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -167,7 +167,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 	struct extent_buffer *leaf;
 	struct btrfs_block_group *cache;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
 
 	ret = btrfs_run_delayed_refs(trans, -1);
 	if (ret)
@@ -189,8 +189,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
-	ret = btrfs_search_slot(trans, root->fs_info->extent_root,
-				&key, &path, 0, 0);
+	ret = btrfs_search_slot(trans, root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
 	while(1) {
diff --git a/convert/main.c b/convert/main.c
index d480f166..378c6aff 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -945,7 +945,6 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 					  struct btrfs_mkfs_config *cfg,
 					  struct btrfs_convert_context *cctx)
 {
-	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct cache_tree *data_chunks = &cctx->data_chunks;
 	struct cache_extent *cache;
 	u64 max_chunk_size;
@@ -957,8 +956,7 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 	 */
 	max_chunk_size = cfg->num_bytes / 10;
 	max_chunk_size = min((u64)(SZ_1G), max_chunk_size);
-	max_chunk_size = round_down(max_chunk_size,
-				    extent_root->fs_info->sectorsize);
+	max_chunk_size = round_down(max_chunk_size, fs_info->sectorsize);
 
 	for (cache = first_cache_extent(data_chunks); cache;
 	     cache = next_cache_extent(cache)) {
diff --git a/image/main.c b/image/main.c
index 57e0cb6c..ab57ce4e 100644
--- a/image/main.c
+++ b/image/main.c
@@ -922,7 +922,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 	u64 num_bytes;
 	int ret;
 
-	extent_root = metadump->root->fs_info->extent_root;
+	extent_root = btrfs_extent_root(metadump->root->fs_info, 0);
 	bytenr = BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
 	key.objectid = bytenr;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index c04d505e..42832c48 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -645,7 +645,7 @@ static int __add_keyed_refs(struct btrfs_fs_info *fs_info,
 			    struct btrfs_path *path, u64 bytenr,
 			    int info_level)
 {
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	int ret;
 	int slot;
 	struct extent_buffer *leaf;
@@ -734,6 +734,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			     u64 time_seq, struct ulist *refs,
 			     struct ulist *roots, const u64 *extent_item_pos)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	int info_level = 0;
@@ -756,7 +757,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
 	BUG_ON(ret == 0);
@@ -1136,6 +1137,7 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 			struct btrfs_path *path, struct btrfs_key *found_key,
 			u64 *flags_ret)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
 	int ret;
 	u64 flags;
 	u64 size = 0;
@@ -1151,11 +1153,11 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	key.objectid = logical;
 	key.offset = (u64)-1;
 
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_previous_extent_item(fs_info->extent_root, path, 0);
+	ret = btrfs_previous_extent_item(extent_root, path, 0);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d2d1a006..23750156 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1157,7 +1157,7 @@ struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	u8 *new_chunk_tree_uuid;
 	struct btrfs_root *fs_root;
-	struct btrfs_root *extent_root;
+	struct btrfs_root *_extent_root;
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	struct btrfs_root *dev_root;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index f157442d..76cf7567 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -761,6 +761,12 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
 	return fs_info->_csum_root;
 }
 
+struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
+				     u64 bytenr)
+{
+	return fs_info->_extent_root;
+}
+
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 				      struct btrfs_key *location)
 {
@@ -772,7 +778,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
 		return fs_info->tree_root;
 	if (location->objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return fs_info->extent_root;
+		return fs_info->_extent_root;
 	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
 		return fs_info->chunk_root;
 	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
@@ -811,7 +817,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 		free(fs_info->quota_root);
 
 	free(fs_info->tree_root);
-	free(fs_info->extent_root);
+	free(fs_info->_extent_root);
 	free(fs_info->chunk_root);
 	free(fs_info->dev_root);
 	free(fs_info->_csum_root);
@@ -831,7 +837,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 		return NULL;
 
 	fs_info->tree_root = calloc(1, sizeof(struct btrfs_root));
-	fs_info->extent_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->_extent_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->chunk_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->_csum_root = calloc(1, sizeof(struct btrfs_root));
@@ -840,7 +846,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
-	if (!fs_info->tree_root || !fs_info->extent_root ||
+	if (!fs_info->tree_root || !fs_info->_extent_root ||
 	    !fs_info->chunk_root || !fs_info->dev_root ||
 	    !fs_info->_csum_root || !fs_info->quota_root ||
 	    !fs_info->free_space_root || !fs_info->uuid_root ||
@@ -1000,11 +1006,11 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		return -EIO;
 	}
 
-	ret = setup_root_or_create_block(fs_info, flags, fs_info->extent_root,
+	ret = setup_root_or_create_block(fs_info, flags, fs_info->_extent_root,
 					 BTRFS_EXTENT_TREE_OBJECTID, "extent");
 	if (ret)
 		return ret;
-	fs_info->extent_root->track_dirty = 1;
+	fs_info->_extent_root->track_dirty = 1;
 
 	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
 				  fs_info->dev_root);
@@ -1062,7 +1068,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 
 	fs_info->generation = generation;
 	fs_info->last_trans_committed = generation;
-	if (extent_buffer_uptodate(fs_info->extent_root->node) &&
+	if (extent_buffer_uptodate(fs_info->_extent_root->node) &&
 	    !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
@@ -1097,8 +1103,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->_csum_root->node);
 	if (fs_info->dev_root)
 		free_extent_buffer(fs_info->dev_root->node);
-	if (fs_info->extent_root)
-		free_extent_buffer(fs_info->extent_root->node);
+	if (fs_info->_extent_root)
+		free_extent_buffer(fs_info->_extent_root->node);
 	if (fs_info->tree_root)
 		free_extent_buffer(fs_info->tree_root->node);
 	if (fs_info->log_root_tree)
@@ -1851,11 +1857,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	btrfs_set_backup_extent_root(root_backup, info->extent_root->node->start);
+	btrfs_set_backup_extent_root(root_backup, info->_extent_root->node->start);
 	btrfs_set_backup_extent_root_gen(root_backup,
-			       btrfs_header_generation(info->extent_root->node));
+			       btrfs_header_generation(info->_extent_root->node));
 	btrfs_set_backup_extent_root_level(root_backup,
-			       btrfs_header_level(info->extent_root->node));
+			       btrfs_header_level(info->_extent_root->node));
 	/*
 	 * we might commit during log recovery, which happens before we set
 	 * the fs_root.  Make sure it is valid before we fill it in.
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 38abbca5..dc71cc2b 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -218,4 +218,5 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     u64 objectid);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
+struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
 #endif
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 402904d1..3713452b 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -96,7 +96,7 @@ static int cache_block_group(struct btrfs_root *root,
 	if (!block_group)
 		return 0;
 
-	root = root->fs_info->extent_root;
+	root = btrfs_extent_root(root->fs_info, 0);
 	free_space_cache = &root->fs_info->free_space_cache;
 
 	if (block_group->cached)
@@ -1243,6 +1243,8 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 u64 bytenr, u64 num_bytes, u64 parent,
 			 u64 root_objectid, u64 owner, u64 offset)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(root->fs_info,
+							   bytenr);
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_extent_item *item;
@@ -1254,9 +1256,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = insert_inline_extent_backref(trans, root->fs_info->extent_root,
-					   path, bytenr, num_bytes, parent,
-					   root_objectid, owner, offset, 1);
+	ret = insert_inline_extent_backref(trans, extent_root, path, bytenr,
+					   num_bytes, parent, root_objectid,
+					   owner, offset, 1);
 	if (ret == 0)
 		goto out;
 
@@ -1274,9 +1276,8 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* now insert the actual backref */
-	ret = insert_extent_backref(trans, root->fs_info->extent_root,
-				    path, bytenr, parent, root_objectid,
-				    owner, offset, 1);
+	ret = insert_extent_backref(trans, extent_root, path, bytenr, parent,
+				    root_objectid, owner, offset, 1);
 	if (ret)
 		err = ret;
 out:
@@ -1289,6 +1290,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_path *path;
 	int ret;
 	struct btrfs_key key;
@@ -1315,7 +1317,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 
 again:
-	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
 
@@ -1374,6 +1376,7 @@ int btrfs_set_block_flags(struct btrfs_trans_handle *trans, u64 bytenr,
 			  int level, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_path *path;
 	int ret;
 	struct btrfs_key key;
@@ -1396,7 +1399,7 @@ int btrfs_set_block_flags(struct btrfs_trans_handle *trans, u64 bytenr,
 	}
 
 again:
-	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
 
@@ -1537,7 +1540,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
 	unsigned long bi;
 	struct btrfs_block_group_item bgi;
 	struct extent_buffer *leaf;
@@ -1911,9 +1914,10 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			 u64 owner_offset, int refs_to_drop)
 {
 
+	struct btrfs_root *extent_root = btrfs_extent_root(trans->fs_info,
+							   bytenr);
 	struct btrfs_key key;
 	struct btrfs_path *path;
-	struct btrfs_root *extent_root = trans->fs_info->extent_root;
 	struct extent_buffer *leaf;
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
@@ -2181,7 +2185,7 @@ static int noinline find_free_extent(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	u64 orig_search_start = search_start;
-	struct btrfs_root * root = orig_root->fs_info->extent_root;
+	struct btrfs_root *root = orig_root->fs_info->tree_root;
 	struct btrfs_fs_info *info = root->fs_info;
 	u64 total_needed = num_bytes;
 	struct btrfs_block_group *block_group;
@@ -2363,6 +2367,8 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				      struct btrfs_delayed_extent_op *extent_op)
 {
 
+	struct btrfs_root *extent_root = btrfs_extent_root(trans->fs_info,
+							   node->bytenr);
 	struct btrfs_delayed_tree_ref *ref = btrfs_delayed_node_to_tree_ref(node);
 	bool skinny_metadata = btrfs_fs_incompat(trans->fs_info, SKINNY_METADATA);
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2403,8 +2409,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_insert_empty_item(trans, fs_info->extent_root, path,
-				      &ins, size);
+	ret = btrfs_insert_empty_item(trans, extent_root, path, &ins, size);
 	if (ret)
 		return ret;
 
@@ -2726,7 +2731,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 	int ret;
 	struct btrfs_key key;
 
-	root = fs_info->extent_root;
+	root = btrfs_extent_root(fs_info, 0);
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2807,7 +2812,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
 
-	root = fs_info->extent_root;
+	root = btrfs_extent_root(fs_info, 0);
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
@@ -2924,7 +2929,7 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key key;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
 	int ret = 0;
 
 	key.objectid = block_group->start;
@@ -3247,7 +3252,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-
 static void __get_extent_size(struct btrfs_root *root, struct btrfs_path *path,
 			      u64 *start, u64 *len)
 {
@@ -3319,7 +3323,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_fs_info *info = root->fs_info;
-	struct btrfs_root *extent_root = info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(info, disk_bytenr);
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key ins_key;
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 83a8520d..0434733d 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1014,12 +1014,18 @@ out:
 int populate_free_space_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_block_group *block_group)
 {
-	struct btrfs_root *extent_root = trans->fs_info->extent_root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path, *path2;
 	struct btrfs_key key;
 	u64 start, end;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return -EINVAL;
+
+	extent_root = btrfs_extent_root(fs_info, 0);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 7d6fe8fd..4092c067 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1348,7 +1348,6 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 			struct btrfs_fs_info *info, struct alloc_chunk_ctl *ctl,
 			struct list_head *private_devs)
 {
-	struct btrfs_root *extent_root = info->extent_root;
 	struct btrfs_root *chunk_root = info->chunk_root;
 	struct btrfs_stripe *stripes;
 	struct btrfs_device *device = NULL;
@@ -1432,7 +1431,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 
 	/* key was set above */
 	btrfs_set_stack_chunk_length(chunk, ctl->num_bytes);
-	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
+	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_type(chunk, ctl->type);
 	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 776576bc..0164fe9f 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -757,7 +757,7 @@ static int calculate_alloc_pointer(struct btrfs_fs_info *fs_info,
 				   struct btrfs_block_group *cache,
 				   u64 *offset_ret)
 {
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, cache->start);
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
diff --git a/mkfs/main.c b/mkfs/main.c
index c6cc51e9..9647f12a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -277,7 +277,7 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, info->tree_root);
 	if (ret)
 		return ret;
-	ret = __recow_root(trans, info->extent_root);
+	ret = __recow_root(trans, info->_extent_root);
 	if (ret)
 		return ret;
 	ret = __recow_root(trans, info->chunk_root);
@@ -588,7 +588,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_block_group_item *bgi;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_path path;
-- 
2.26.3

