Return-Path: <linux-btrfs+bounces-14739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C03BADD5E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A366619E0051
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639A2F7419;
	Tue, 17 Jun 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA4qiXRh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E802F740B
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176802; cv=none; b=fWKJlSE4hoWk+3V80pkWz+OTeReJKlPlq2RpHlZi1UV7oXXo4BBSCqtGkLd9y48ok4UuSISU36HXAcILmuyIQWbWcENG5hh1knXZZPRpMxBDS1XJ7WYgPyhgaPQVsVaKe2lFH3ZRbpho4iQvNQsFCEYOIUS5HnihgIYjOmLm1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176802; c=relaxed/simple;
	bh=OlOx9hERSIdRKD6QudMnotU2VegyZRAeWUWTjVhUVhE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZxAaOCyjalsfUDFxIl9SRrbhZAShe2hvdB02BokRsOxmtnARHH5CWbibqWoXd/b39HPaRYUW1JP4Jb9C6zpYjXsv0UftD5YHRAmG7UWWhE0lVvjmBnQuFHVKb2UcM6+t2jE430IX7y+XR9qUDs4xiNnfDQhkS2RDtrQwC589VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA4qiXRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44443C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176801;
	bh=OlOx9hERSIdRKD6QudMnotU2VegyZRAeWUWTjVhUVhE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CA4qiXRhhucmLgy9xhi3MbJFaUtmxFjTczpV2ta76yo5KqQhx05Sbm/GBBEgJ8U9f
	 6g26Ot0GohlJ14g9NfdbS4t79TmR3nQwbyls9DV/u3XsRDA9YOphuxWbGBeRv7irHE
	 zBC0RAQNit0eKvdkt29DBuRBZ0mQb6hyfxjgm48OG7zEMugFCmiaTRuxVkx+NYiT7t
	 mFYD9IBmoYEdP7RvohAIPuEw6jOemjjtTtg8jwN9OLwKZhhDsHLNS6I4aSVq3JN2hn
	 q/LdywI/T6kjrhdZgKHF0Gh+dHyWHKIr9CU6VZlOI91EHNupqGjNaDNuFaLvS1Q2vS
	 0Gr4OMxfHM0hw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs: add btrfs prefix to free space tree exported functions
Date: Tue, 17 Jun 2025 17:13:05 +0100
Message-ID: <ca0d5ca26250730d2e94aba1230f546296233efe.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A few of the free space tree exported functions have a 'btrfs_' prefix in
their name, but most don't. Not only is this inconsistent, the preferred
style is to have such a prefix, to avoid potential collisions in the
future with other kernel code and offer a somewhat better readibility by
making it obvious in calls sites that we are calling btrfs specific code.

So add the 'btrfs_' prefix to all free space tree functions that are
missing it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c                 | 10 +--
 fs/btrfs/extent-tree.c                 |  4 +-
 fs/btrfs/free-space-tree.c             | 95 +++++++++++++-------------
 fs/btrfs/free-space-tree.h             | 52 +++++++-------
 fs/btrfs/tests/free-space-tree-tests.c | 93 ++++++++++++-------------
 5 files changed, 125 insertions(+), 129 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b0cb04b2b93..00e567a4cd16 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -877,7 +877,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 	 */
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 	    !(test_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags)))
-		ret = load_free_space_tree(caching_ctl);
+		ret = btrfs_load_free_space_tree(caching_ctl);
 	else
 		ret = load_extent_tree_free(caching_ctl);
 done:
@@ -1235,7 +1235,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * another task to attempt to create another block group with the same
 	 * item key (and failing with -EEXIST and a transaction abort).
 	 */
-	ret = remove_block_group_free_space(trans, block_group);
+	ret = btrfs_remove_block_group_free_space(trans, block_group);
 	if (ret)
 		goto out;
 
@@ -2372,7 +2372,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
 	cache->space_info = btrfs_find_space_info(info, cache->flags);
 
-	set_free_space_tree_thresholds(cache);
+	btrfs_set_free_space_tree_thresholds(cache);
 
 	if (need_clear) {
 		/*
@@ -2791,7 +2791,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 					 block_group->length);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
-		add_block_group_free_space(trans, block_group);
+		btrfs_add_block_group_free_space(trans, block_group);
 
 		/*
 		 * If we restriped during balance, we may have added a new raid
@@ -2889,7 +2889,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	set_bit(BLOCK_GROUP_FLAG_NEW, &cache->runtime_flags);
 
 	cache->length = size;
-	set_free_space_tree_thresholds(cache);
+	btrfs_set_free_space_tree_thresholds(cache);
 	cache->flags = type;
 	cache->cached = BTRFS_CACHE_FINISHED;
 	cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f1ac6a8dd9f4..0c57aaa0f5f0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3000,7 +3000,7 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
+	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -4784,7 +4784,7 @@ static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
 
-	ret = remove_from_free_space_tree(trans, bytenr, num_bytes);
+	ret = btrfs_remove_from_free_space_tree(trans, bytenr, num_bytes);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index d98a927ca079..1794fdf06586 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -35,7 +35,7 @@ static struct btrfs_root *btrfs_free_space_root(
 	return btrfs_global_root(block_group->fs_info, &key);
 }
 
-void set_free_space_tree_thresholds(struct btrfs_block_group *cache)
+void btrfs_set_free_space_tree_thresholds(struct btrfs_block_group *cache)
 {
 	u32 bitmap_range;
 	size_t bitmap_size;
@@ -94,7 +94,7 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 }
 
 EXPORT_FOR_TESTS
-struct btrfs_free_space_info *search_free_space_info(
+struct btrfs_free_space_info *btrfs_search_free_space_info(
 		struct btrfs_trans_handle *trans,
 		struct btrfs_block_group *block_group,
 		struct btrfs_path *path, int cow)
@@ -198,9 +198,9 @@ static void le_bitmap_set(unsigned long *map, unsigned int start, int len)
 }
 
 EXPORT_FOR_TESTS
-int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group,
-				  struct btrfs_path *path)
+int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group,
+					struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = btrfs_free_space_root(block_group);
@@ -278,7 +278,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 	}
 
-	info = search_free_space_info(trans, block_group, path, 1);
+	info = btrfs_search_free_space_info(trans, block_group, path, 1);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		btrfs_abort_transaction(trans, ret);
@@ -340,9 +340,9 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 }
 
 EXPORT_FOR_TESTS
-int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group,
-				  struct btrfs_path *path)
+int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group,
+					struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = btrfs_free_space_root(block_group);
@@ -425,7 +425,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 	}
 
-	info = search_free_space_info(trans, block_group, path, 1);
+	info = btrfs_search_free_space_info(trans, block_group, path, 1);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		btrfs_abort_transaction(trans, ret);
@@ -490,7 +490,7 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 	if (new_extents == 0)
 		return 0;
 
-	info = search_free_space_info(trans, block_group, path, 1);
+	info = btrfs_search_free_space_info(trans, block_group, path, 1);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -503,18 +503,18 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 
 	if (!(flags & BTRFS_FREE_SPACE_USING_BITMAPS) &&
 	    extent_count > block_group->bitmap_high_thresh) {
-		ret = convert_free_space_to_bitmaps(trans, block_group, path);
+		ret = btrfs_convert_free_space_to_bitmaps(trans, block_group, path);
 	} else if ((flags & BTRFS_FREE_SPACE_USING_BITMAPS) &&
 		   extent_count < block_group->bitmap_low_thresh) {
-		ret = convert_free_space_to_extents(trans, block_group, path);
+		ret = btrfs_convert_free_space_to_extents(trans, block_group, path);
 	}
 
 	return ret;
 }
 
 EXPORT_FOR_TESTS
-bool free_space_test_bit(struct btrfs_block_group *block_group,
-			 struct btrfs_path *path, u64 offset)
+bool btrfs_free_space_test_bit(struct btrfs_block_group *block_group,
+			       struct btrfs_path *path, u64 offset)
 {
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -632,7 +632,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 		if (ret)
 			return ret;
 
-		prev_bit_set = free_space_test_bit(block_group, path, prev_block);
+		prev_bit_set = btrfs_free_space_test_bit(block_group, path, prev_block);
 
 		/* The previous block may have been in the previous bitmap. */
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
@@ -680,7 +680,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 				return ret;
 		}
 
-		next_bit_set = free_space_test_bit(block_group, path, end);
+		next_bit_set = btrfs_free_space_test_bit(block_group, path, end);
 	}
 
 	if (remove) {
@@ -792,9 +792,9 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 }
 
 EXPORT_FOR_TESTS
-int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group,
-				  struct btrfs_path *path, u64 start, u64 size)
+int __btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group,
+					struct btrfs_path *path, u64 start, u64 size)
 {
 	struct btrfs_free_space_info *info;
 	u32 flags;
@@ -804,7 +804,7 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	info = search_free_space_info(NULL, block_group, path, 0);
+	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 	flags = btrfs_free_space_flags(path->nodes[0], info);
@@ -819,8 +819,8 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	}
 }
 
-int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
-				u64 start, u64 size)
+int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
+				      u64 start, u64 size)
 {
 	struct btrfs_block_group *block_group;
 	struct btrfs_path *path;
@@ -845,8 +845,7 @@ int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	}
 
 	mutex_lock(&block_group->free_space_lock);
-	ret = __remove_from_free_space_tree(trans, block_group, path, start,
-					    size);
+	ret = __btrfs_remove_from_free_space_tree(trans, block_group, path, start, size);
 	mutex_unlock(&block_group->free_space_lock);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
@@ -981,9 +980,9 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 }
 
 EXPORT_FOR_TESTS
-int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
-			     struct btrfs_block_group *block_group,
-			     struct btrfs_path *path, u64 start, u64 size)
+int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
+				   struct btrfs_block_group *block_group,
+				   struct btrfs_path *path, u64 start, u64 size)
 {
 	struct btrfs_free_space_info *info;
 	u32 flags;
@@ -993,7 +992,7 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	info = search_free_space_info(NULL, block_group, path, 0);
+	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 	flags = btrfs_free_space_flags(path->nodes[0], info);
@@ -1008,8 +1007,8 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	}
 }
 
-int add_to_free_space_tree(struct btrfs_trans_handle *trans,
-			   u64 start, u64 size)
+int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
+				 u64 start, u64 size)
 {
 	struct btrfs_block_group *block_group;
 	struct btrfs_path *path;
@@ -1034,7 +1033,7 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	}
 
 	mutex_lock(&block_group->free_space_lock);
-	ret = __add_to_free_space_tree(trans, block_group, path, start, size);
+	ret = __btrfs_add_to_free_space_tree(trans, block_group, path, start, size);
 	mutex_unlock(&block_group->free_space_lock);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
@@ -1114,11 +1113,11 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 				break;
 
 			if (start < key.objectid) {
-				ret = __add_to_free_space_tree(trans,
-							       block_group,
-							       path2, start,
-							       key.objectid -
-							       start);
+				ret = __btrfs_add_to_free_space_tree(trans,
+								     block_group,
+								     path2, start,
+								     key.objectid -
+								     start);
 				if (ret)
 					goto out_locked;
 			}
@@ -1137,8 +1136,8 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 			goto out_locked;
 	}
 	if (start < end) {
-		ret = __add_to_free_space_tree(trans, block_group, path2,
-					       start, end - start);
+		ret = __btrfs_add_to_free_space_tree(trans, block_group, path2,
+						     start, end - start);
 		if (ret)
 			goto out_locked;
 	}
@@ -1424,8 +1423,8 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	ret = __add_to_free_space_tree(trans, block_group, path,
-				       block_group->start, block_group->length);
+	ret = __btrfs_add_to_free_space_tree(trans, block_group, path,
+					     block_group->start, block_group->length);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 
@@ -1436,8 +1435,8 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int add_block_group_free_space(struct btrfs_trans_handle *trans,
-			       struct btrfs_block_group *block_group)
+int btrfs_add_block_group_free_space(struct btrfs_trans_handle *trans,
+				     struct btrfs_block_group *block_group)
 {
 	int ret;
 
@@ -1450,8 +1449,8 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int remove_block_group_free_space(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group)
+int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group)
 {
 	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_path *path;
@@ -1570,7 +1569,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 		while (offset < key.objectid + key.offset) {
 			bool bit_set;
 
-			bit_set = free_space_test_bit(block_group, path, offset);
+			bit_set = btrfs_free_space_test_bit(block_group, path, offset);
 			if (!prev_bit_set && bit_set) {
 				extent_start = offset;
 			} else if (prev_bit_set && !bit_set) {
@@ -1673,7 +1672,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 	return 0;
 }
 
-int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
+int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 {
 	struct btrfs_block_group *block_group;
 	struct btrfs_free_space_info *info;
@@ -1694,7 +1693,7 @@ int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 	path->search_commit_root = 1;
 	path->reada = READA_FORWARD;
 
-	info = search_free_space_info(NULL, block_group, path, 0);
+	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index 32e71d0c8dd4..3d9a5d4477fc 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -22,39 +22,39 @@ struct btrfs_trans_handle;
 #define BTRFS_FREE_SPACE_BITMAP_SIZE 256
 #define BTRFS_FREE_SPACE_BITMAP_BITS (BTRFS_FREE_SPACE_BITMAP_SIZE * BITS_PER_BYTE)
 
-void set_free_space_tree_thresholds(struct btrfs_block_group *block_group);
+void btrfs_set_free_space_tree_thresholds(struct btrfs_block_group *block_group);
 int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info);
 int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info);
 int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info);
-int load_free_space_tree(struct btrfs_caching_control *caching_ctl);
-int add_block_group_free_space(struct btrfs_trans_handle *trans,
-			       struct btrfs_block_group *block_group);
-int remove_block_group_free_space(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group);
-int add_to_free_space_tree(struct btrfs_trans_handle *trans,
-			   u64 start, u64 size);
-int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
-				u64 start, u64 size);
+int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl);
+int btrfs_add_block_group_free_space(struct btrfs_trans_handle *trans,
+				     struct btrfs_block_group *block_group);
+int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group);
+int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
+				 u64 start, u64 size);
+int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
+				      u64 start, u64 size);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_free_space_info *
-search_free_space_info(struct btrfs_trans_handle *trans,
-		       struct btrfs_block_group *block_group,
-		       struct btrfs_path *path, int cow);
-int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
+btrfs_search_free_space_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_block_group *block_group,
-			     struct btrfs_path *path, u64 start, u64 size);
-int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group,
-				  struct btrfs_path *path, u64 start, u64 size);
-int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group,
-				  struct btrfs_path *path);
-int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
-				  struct btrfs_block_group *block_group,
-				  struct btrfs_path *path);
-bool free_space_test_bit(struct btrfs_block_group *block_group,
-			 struct btrfs_path *path, u64 offset);
+			     struct btrfs_path *path, int cow);
+int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
+				   struct btrfs_block_group *block_group,
+				   struct btrfs_path *path, u64 start, u64 size);
+int __btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group,
+					struct btrfs_path *path, u64 start, u64 size);
+int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group,
+					struct btrfs_path *path);
+int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
+					struct btrfs_block_group *block_group,
+					struct btrfs_path *path);
+bool btrfs_free_space_test_bit(struct btrfs_block_group *block_group,
+			       struct btrfs_path *path, u64 offset);
 #endif
 
 #endif
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index b61972046feb..c8822edd32e2 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -32,7 +32,7 @@ static int __check_free_space_extents(struct btrfs_trans_handle *trans,
 	unsigned int i;
 	int ret;
 
-	info = search_free_space_info(trans, cache, path, 0);
+	info = btrfs_search_free_space_info(trans, cache, path, 0);
 	if (IS_ERR(info)) {
 		test_err("could not find free space info");
 		ret = PTR_ERR(info);
@@ -57,7 +57,7 @@ static int __check_free_space_extents(struct btrfs_trans_handle *trans,
 				goto invalid;
 			offset = key.objectid;
 			while (offset < key.objectid + key.offset) {
-				bit = free_space_test_bit(cache, path, offset);
+				bit = btrfs_free_space_test_bit(cache, path, offset);
 				if (prev_bit == 0 && bit == 1) {
 					extent_start = offset;
 				} else if (prev_bit == 1 && bit == 0) {
@@ -115,7 +115,7 @@ static int check_free_space_extents(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	info = search_free_space_info(trans, cache, path, 0);
+	info = btrfs_search_free_space_info(trans, cache, path, 0);
 	if (IS_ERR(info)) {
 		test_err("could not find free space info");
 		btrfs_release_path(path);
@@ -131,13 +131,13 @@ static int check_free_space_extents(struct btrfs_trans_handle *trans,
 
 	/* Flip it to the other format and check that for good measure. */
 	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
-		ret = convert_free_space_to_extents(trans, cache, path);
+		ret = btrfs_convert_free_space_to_extents(trans, cache, path);
 		if (ret) {
 			test_err("could not convert to extents");
 			return ret;
 		}
 	} else {
-		ret = convert_free_space_to_bitmaps(trans, cache, path);
+		ret = btrfs_convert_free_space_to_bitmaps(trans, cache, path);
 		if (ret) {
 			test_err("could not convert to bitmaps");
 			return ret;
@@ -170,9 +170,8 @@ static int test_remove_all(struct btrfs_trans_handle *trans,
 	const struct free_space_extent extents[] = {};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start,
-					    cache->length);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
@@ -193,8 +192,8 @@ static int test_remove_beginning(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start, alignment);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start, alignment);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
@@ -216,7 +215,7 @@ static int test_remove_end(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
 				    cache->start + cache->length - alignment,
 				    alignment);
 	if (ret) {
@@ -240,9 +239,9 @@ static int test_remove_middle(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start + alignment,
-					    alignment);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start + alignment,
+						  alignment);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
@@ -263,23 +262,22 @@ static int test_merge_left(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start, cache->length);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path, cache->start,
-				       alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path, cache->start,
+					     alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + alignment,
-				       alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
@@ -300,24 +298,23 @@ static int test_merge_right(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start, cache->length);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + 2 * alignment,
-				       alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + 2 * alignment,
+					     alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + alignment,
-				       alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
@@ -338,29 +335,29 @@ static int test_merge_both(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start, cache->length);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path, cache->start,
-				       alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path, cache->start,
+					     alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + 2 * alignment, alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + 2 * alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + alignment, alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
@@ -383,29 +380,29 @@ static int test_merge_none(struct btrfs_trans_handle *trans,
 	};
 	int ret;
 
-	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->start, cache->length);
+	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
+						  cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path, cache->start,
-				       alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path, cache->start,
+					     alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + 4 * alignment, alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + 4 * alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->start + 2 * alignment, alignment);
+	ret = __btrfs_add_to_free_space_tree(trans, cache, path,
+					     cache->start + 2 * alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
@@ -483,14 +480,14 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 		goto out;
 	}
 
-	ret = add_block_group_free_space(&trans, cache);
+	ret = btrfs_add_block_group_free_space(&trans, cache);
 	if (ret) {
 		test_err("could not add block group free space");
 		goto out;
 	}
 
 	if (bitmaps) {
-		ret = convert_free_space_to_bitmaps(&trans, cache, path);
+		ret = btrfs_convert_free_space_to_bitmaps(&trans, cache, path);
 		if (ret) {
 			test_err("could not convert block group to bitmaps");
 			goto out;
@@ -501,7 +498,7 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	if (ret)
 		goto out;
 
-	ret = remove_block_group_free_space(&trans, cache);
+	ret = btrfs_remove_block_group_free_space(&trans, cache);
 	if (ret) {
 		test_err("could not remove block group free space");
 		goto out;
-- 
2.47.2


