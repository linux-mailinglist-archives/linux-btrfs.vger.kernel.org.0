Return-Path: <linux-btrfs+bounces-17847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13898BDE73A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B83B1BFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B599327783;
	Wed, 15 Oct 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqu913uR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968C319875
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530886; cv=none; b=iO7e1IX5DRgjb8vxZrR3tthNhz4XLfrU3TjhnwYsUvBpwpaCQO5SA2pOIeuOlZnDV/p4IIsTm4dyySKuFniCCPB4nV/1h0Y0u5PxjEoSP325MaHUn7dB0/I6l68tF+NW1n4AalZgGLMNxp3rGxUJVxBuVkK7ualR2eRjdHgvEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530886; c=relaxed/simple;
	bh=HQ/qLGyoVXc+Jb4/8rGJO6pyEh/jVudEArRdOoTSa4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IepyHi9aK798TKpfl9zZRWKETrRnTTBgOylesvDVYH0qXvfKH8T23SwCJsybGYxTRpE9hMDM7toDkg85Oqz/Oa5nVaQWfcP5pm4WV3fCfMjsTnL8ua7gaD/173oNE3sjxw9mdG8GYNqSWP5tcS763NTeg3zDYfnVpvX0lA5wIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqu913uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D58C4CEFE
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530886;
	bh=HQ/qLGyoVXc+Jb4/8rGJO6pyEh/jVudEArRdOoTSa4s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tqu913uRJEfDzhDMBvxNpcr8qezCuTpHUxF1Z2x4+8LZ0eV7Wf54Aqukjly9rhGSj
	 hXs3U2+HQcoHDx/D6CHLzSd3tEGjrYsto1dHbR9Ne3uhSdaKbynCgahuMowTN9gwyl
	 q1zguqs1tdjaOePa50OS3krlV9H//uQ1BwwDbObNqJznMDw86Xy2CBTJ4hPjIfzfdr
	 yoWSZmm+vAgZ5lAC1C44EOJvSh21V9kMdW/edV14baWUYUa5tcouEnKapJTbIrC5EO
	 nKeS4CZcwpXIN924bZlU3q79H1u9zqkd0gprUdPfu2aJ5U9HsBMEhwTtFAMVD4OfEM
	 3GHSCKcINUxRg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: use the key format macros when printing keys
Date: Wed, 15 Oct 2025 13:21:21 +0100
Message-ID: <c488454c158cdb7f394e561a1fb1ee774bbfbea9.1760530704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760530704.git.fdmanana@suse.com>
References: <cover.1760530704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Change all locations that print a key to use the new macros to print
them in order to ensure a consistent style and avoid repetitive code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c      | 11 +++++------
 fs/btrfs/ctree.c        | 17 +++++++----------
 fs/btrfs/extent-tree.c  | 14 +++++++-------
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/print-tree.c   | 14 ++++++--------
 fs/btrfs/qgroup.c       |  6 ++----
 fs/btrfs/relocation.c   |  4 ++--
 fs/btrfs/root-tree.c    |  4 ++--
 fs/btrfs/send.c         | 10 ++++------
 fs/btrfs/tree-checker.c | 21 +++++++++------------
 fs/btrfs/tree-log.c     | 38 ++++++++++++++++++--------------------
 11 files changed, 64 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 2ab550a1e715..e050d0938dc4 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -666,10 +666,9 @@ static int resolve_indirect_ref(struct btrfs_backref_walk_ctx *ctx,
 		ret = btrfs_search_old_slot(root, &search_key, path, ctx->time_seq);
 
 	btrfs_debug(ctx->fs_info,
-		"search slot in root %llu (level %d, ref count %d) returned %d for key (%llu %u %llu)",
-		 ref->root_id, level, ref->count, ret,
-		 ref->key_for_search.objectid, ref->key_for_search.type,
-		 ref->key_for_search.offset);
+"search slot in root %llu (level %d, ref count %d) returned %d for key " BTRFS_KEY_FMT,
+		    ref->root_id, level, ref->count, ret,
+		    BTRFS_KEY_FMT_VALUE(&ref->key_for_search));
 	if (ret < 0)
 		goto out;
 
@@ -3323,9 +3322,9 @@ static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
 	eb = path->nodes[level];
 	if (btrfs_node_blockptr(eb, path->slots[level]) != cur->bytenr) {
 		btrfs_err(fs_info,
-"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
+"couldn't find block (%llu) (level %d) in tree (%llu) with key " BTRFS_KEY_FMT,
 			  cur->bytenr, level - 1, btrfs_root_id(root),
-			  tree_key->objectid, tree_key->type, tree_key->offset);
+			  BTRFS_KEY_FMT_VALUE(tree_key));
 		btrfs_put_root(root);
 		ret = -ENOENT;
 		goto out;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 561658aca018..3be1b66aea35 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2599,12 +2599,11 @@ void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
 		if (unlikely(btrfs_comp_keys(&disk_key, new_key) >= 0)) {
 			btrfs_print_leaf(eb);
 			btrfs_crit(fs_info,
-		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
+		"slot %u key " BTRFS_KEY_FMT " new key " BTRFS_KEY_FMT,
 				   slot, btrfs_disk_key_objectid(&disk_key),
 				   btrfs_disk_key_type(&disk_key),
 				   btrfs_disk_key_offset(&disk_key),
-				   new_key->objectid, new_key->type,
-				   new_key->offset);
+				   BTRFS_KEY_FMT_VALUE(new_key));
 			BUG();
 		}
 	}
@@ -2613,12 +2612,11 @@ void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
 		if (unlikely(btrfs_comp_keys(&disk_key, new_key) <= 0)) {
 			btrfs_print_leaf(eb);
 			btrfs_crit(fs_info,
-		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
+		"slot %u key " BTRFS_KEY_FMT " new key " BTRFS_KEY_FMT,
 				   slot, btrfs_disk_key_objectid(&disk_key),
 				   btrfs_disk_key_type(&disk_key),
 				   btrfs_disk_key_offset(&disk_key),
-				   new_key->objectid, new_key->type,
-				   new_key->offset);
+				   BTRFS_KEY_FMT_VALUE(new_key));
 			BUG();
 		}
 	}
@@ -2677,10 +2675,9 @@ static bool check_sibling_keys(const struct extent_buffer *left,
 		btrfs_crit(left->fs_info, "right extent buffer:");
 		btrfs_print_tree(right, false);
 		btrfs_crit(left->fs_info,
-"bad key order, sibling blocks, left last (%llu %u %llu) right first (%llu %u %llu)",
-			   left_last.objectid, left_last.type,
-			   left_last.offset, right_first.objectid,
-			   right_first.type, right_first.offset);
+"bad key order, sibling blocks, left last " BTRFS_KEY_FMT " right first " BTRFS_KEY_FMT,
+			   BTRFS_KEY_FMT_VALUE(&left_last),
+			   BTRFS_KEY_FMT_VALUE(&right_first));
 		return true;
 	}
 	return false;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d1e75da97f58..ae2c3dc9957e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -164,8 +164,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		if (unlikely(num_refs == 0)) {
 			ret = -EUCLEAN;
 			btrfs_err(fs_info,
-		"unexpected zero reference count for extent item (%llu %u %llu)",
-				  key.objectid, key.type, key.offset);
+		"unexpected zero reference count for extent item " BTRFS_KEY_FMT,
+				  BTRFS_KEY_FMT_VALUE(&key));
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
@@ -597,8 +597,8 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 		num_refs = btrfs_shared_data_ref_count(leaf, ref2);
 	} else {
 		btrfs_err(trans->fs_info,
-			  "unrecognized backref key (%llu %u %llu)",
-			  key.objectid, key.type, key.offset);
+			  "unrecognized backref key " BTRFS_KEY_FMT,
+			  BTRFS_KEY_FMT_VALUE(&key));
 		btrfs_abort_transaction(trans, -EUCLEAN);
 		return -EUCLEAN;
 	}
@@ -3326,9 +3326,9 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			if (iref) {
 				if (unlikely(path->slots[0] != extent_slot)) {
 					abort_and_dump(trans, path,
-"invalid iref, extent item key (%llu %u %llu) slot %u doesn't have wanted iref",
-						       key.objectid, key.type,
-						       key.offset, path->slots[0]);
+"invalid iref, extent item key " BTRFS_KEY_FMT " slot %u doesn't have wanted iref",
+						       BTRFS_KEY_FMT_VALUE(&key),
+						       path->slots[0]);
 					ret = -EUCLEAN;
 					goto out;
 				}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bd953146eda7..79732756b87f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5642,9 +5642,9 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 		     location->type != BTRFS_ROOT_ITEM_KEY)) {
 		ret = -EUCLEAN;
 		btrfs_warn(root->fs_info,
-"%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
+"%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location " BTRFS_KEY_FMT ")",
 			   __func__, fname.disk_name.name, btrfs_ino(dir),
-			   location->objectid, location->type, location->offset);
+			   BTRFS_KEY_FMT_VALUE(location));
 	}
 	if (!ret)
 		*type = btrfs_dir_ftype(path->nodes[0], di);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index d16f2960d55d..f189bf09ce6a 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -131,7 +131,7 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 		struct btrfs_tree_block_info *info;
 		info = (struct btrfs_tree_block_info *)(ei + 1);
 		btrfs_tree_block_key(eb, info, &key);
-		pr_info("\t\ttree block key (%llu %u %llu) level %d\n",
+		pr_info("\t\ttree block key " BTRFS_KEY_FMT " level %d\n",
 		       btrfs_disk_key_objectid(&key), key.type,
 		       btrfs_disk_key_offset(&key),
 		       btrfs_tree_block_level(eb, info));
@@ -277,9 +277,8 @@ static void print_dir_item(const struct extent_buffer *eb, int i)
 		struct btrfs_key location;
 
 		btrfs_dir_item_key_to_cpu(eb, di, &location);
-		pr_info("\t\tlocation key (%llu %u %llu) type %d\n",
-			location.objectid, location.type, location.offset,
-			btrfs_dir_ftype(eb, di));
+		pr_info("\t\tlocation key " BTRFS_KEY_FMT " type %d\n",
+			BTRFS_KEY_FMT_VALUE(&location), btrfs_dir_ftype(eb, di));
 		pr_info("\t\ttransid %llu data_len %u name_len %u\n",
 			btrfs_dir_transid(eb, di), data_len, name_len);
 		di = (struct btrfs_dir_item *)((char *)di + len);
@@ -598,10 +597,9 @@ void btrfs_print_tree(const struct extent_buffer *c, bool follow)
 	print_eb_refs_lock(c);
 	for (i = 0; i < nr; i++) {
 		btrfs_node_key_to_cpu(c, &key, i);
-		pr_info("\tkey %d (%llu %u %llu) block %llu gen %llu\n",
-		       i, key.objectid, key.type, key.offset,
-		       btrfs_node_blockptr(c, i),
-		       btrfs_node_ptr_generation(c, i));
+		pr_info("\tkey %d " BTRFS_KEY_FMT " block %llu gen %llu\n",
+			i, BTRFS_KEY_FMT_VALUE(&key), btrfs_node_blockptr(c, i),
+			btrfs_node_ptr_generation(c, i));
 	}
 	if (!follow)
 		return;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..51d696e49768 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3710,10 +3710,8 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 					 path, 1, 0);
 
 	btrfs_debug(fs_info,
-		"current progress key (%llu %u %llu), search_slot ret %d",
-		fs_info->qgroup_rescan_progress.objectid,
-		fs_info->qgroup_rescan_progress.type,
-		fs_info->qgroup_rescan_progress.offset, ret);
+		    "current progress key " BTRFS_KEY_FMT ", search_slot ret %d",
+		    BTRFS_KEY_FMT_VALUE(&fs_info->qgroup_rescan_progress), ret);
 
 	if (ret) {
 		/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 748290758459..96539e8b7b4b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -615,8 +615,8 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 
 			btrfs_disk_key_to_cpu(&cpu_key, &root->root_item.drop_progress);
 			btrfs_err(fs_info,
-	"cannot relocate partially dropped subvolume %llu, drop progress key (%llu %u %llu)",
-				  objectid, cpu_key.objectid, cpu_key.type, cpu_key.offset);
+	"cannot relocate partially dropped subvolume %llu, drop progress key " BTRFS_KEY_FMT,
+				  objectid, BTRFS_KEY_FMT_VALUE(&cpu_key));
 			ret = -EUCLEAN;
 			goto fail;
 		}
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index d07eab70f759..6a7e297ab0a7 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -147,8 +147,8 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (unlikely(ret > 0)) {
 		btrfs_crit(fs_info,
-			"unable to find root key (%llu %u %llu) in tree %llu",
-			key->objectid, key->type, key->offset, btrfs_root_id(root));
+			   "unable to find root key " BTRFS_KEY_FMT " in tree %llu",
+			   BTRFS_KEY_FMT_VALUE(key), btrfs_root_id(root));
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
 		return ret;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6144e66661f5..381901e35345 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1053,10 +1053,8 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 				}
 				if (unlikely(start < p->buf)) {
 					btrfs_err(root->fs_info,
-			"send: path ref buffer underflow for key (%llu %u %llu)",
-						  found_key->objectid,
-						  found_key->type,
-						  found_key->offset);
+			  "send: path ref buffer underflow for key " BTRFS_KEY_FMT,
+						  BTRFS_KEY_FMT_VALUE(found_key));
 					ret = -EINVAL;
 					goto out;
 				}
@@ -7234,8 +7232,8 @@ static int search_key_again(const struct send_ctx *sctx,
 	if (unlikely(ret > 0)) {
 		btrfs_print_tree(path->nodes[path->lowest_level], false);
 		btrfs_err(root->fs_info,
-"send: key (%llu %u %llu) not found in %s root %llu, lowest_level %d, slot %d",
-			  key->objectid, key->type, key->offset,
+"send: key " BTRFS_KEY_FMT" not found in %s root %llu, lowest_level %d, slot %d",
+			  BTRFS_KEY_FMT_VALUE(key),
 			  (root == sctx->parent_root ? "parent" : "send"),
 			  btrfs_root_id(root), path->lowest_level,
 			  path->slots[path->lowest_level]);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c10b4c242acf..5684750ca7a6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1618,10 +1618,9 @@ static int check_extent_item(struct extent_buffer *leaf,
 
 		if (unlikely(prev_end > key->objectid)) {
 			extent_err(leaf, slot,
-	"previous extent [%llu %u %llu] overlaps current extent [%llu %u %llu]",
-				   prev_key->objectid, prev_key->type,
-				   prev_key->offset, key->objectid, key->type,
-				   key->offset);
+	"previous extent " BTRFS_KEY_FMT " overlaps current extent " BTRFS_KEY_FMT,
+				   BTRFS_KEY_FMT_VALUE(prev_key),
+				   BTRFS_KEY_FMT_VALUE(key));
 			return -EUCLEAN;
 		}
 	}
@@ -2060,10 +2059,9 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 		/* Make sure the keys are in the right order */
 		if (unlikely(btrfs_comp_cpu_keys(&prev_key, &key) >= 0)) {
 			generic_err(leaf, slot,
-	"bad key order, prev (%llu %u %llu) current (%llu %u %llu)",
-				prev_key.objectid, prev_key.type,
-				prev_key.offset, key.objectid, key.type,
-				key.offset);
+	"bad key order, prev " BTRFS_KEY_FMT " current " BTRFS_KEY_FMT,
+				    BTRFS_KEY_FMT_VALUE(&prev_key),
+				    BTRFS_KEY_FMT_VALUE(&key));
 			return BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 		}
 
@@ -2181,10 +2179,9 @@ enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 
 		if (unlikely(btrfs_comp_cpu_keys(&key, &next_key) >= 0)) {
 			generic_err(node, slot,
-	"bad key order, current (%llu %u %llu) next (%llu %u %llu)",
-				key.objectid, key.type, key.offset,
-				next_key.objectid, next_key.type,
-				next_key.offset);
+	"bad key order, current " BTRFS_KEY_FMT " next " BTRFS_KEY_FMT,
+				    BTRFS_KEY_FMT_VALUE(&key),
+				    BTRFS_KEY_FMT_VALUE(&next_key));
 			return BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 		}
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3bbc3a393cb4..65079eb651da 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -198,9 +198,9 @@ static void do_abort_log_replay(struct walk_control *wc, const char *function,
 
 	if (wc->log_leaf) {
 		btrfs_crit(fs_info,
-	  "log tree (for root %llu) leaf currently being processed (slot %d key %llu %u %llu):",
+"log tree (for root %llu) leaf currently being processed (slot %d key " BTRFS_KEY_FMT "):",
 			   btrfs_root_id(wc->root), wc->log_slot,
-			   wc->log_key.objectid, wc->log_key.type, wc->log_key.offset);
+			   BTRFS_KEY_FMT_VALUE(&wc->log_key));
 		btrfs_print_leaf(wc->log_leaf);
 	}
 
@@ -510,9 +510,9 @@ static int overwrite_item(struct walk_control *wc)
 	ret = btrfs_search_slot(NULL, root, &wc->log_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_log_replay(wc, ret,
-		"failed to search subvolume tree for key (%llu %u %llu) root %llu",
-				       wc->log_key.objectid, wc->log_key.type,
-				       wc->log_key.offset, btrfs_root_id(root));
+		"failed to search subvolume tree for key " BTRFS_KEY_FMT " root %llu",
+				       BTRFS_KEY_FMT_VALUE(&wc->log_key),
+				       btrfs_root_id(root));
 		return ret;
 	}
 
@@ -618,9 +618,8 @@ static int overwrite_item(struct walk_control *wc)
 			btrfs_extend_item(trans, wc->subvol_path, item_size - found_size);
 	} else if (ret) {
 		btrfs_abort_log_replay(wc, ret,
-				       "failed to insert item for key (%llu %u %llu)",
-				       wc->log_key.objectid, wc->log_key.type,
-				       wc->log_key.offset);
+				       "failed to insert item for key " BTRFS_KEY_FMT,
+				       BTRFS_KEY_FMT_VALUE(&wc->log_key));
 		return ret;
 	}
 	dst_ptr = btrfs_item_ptr_offset(dst_eb, dst_slot);
@@ -829,9 +828,9 @@ static noinline int replay_one_extent(struct walk_control *wc)
 				      &wc->log_key, sizeof(*item));
 	if (ret) {
 		btrfs_abort_log_replay(wc, ret,
-		       "failed to insert item with key (%llu %u %llu) root %llu",
-				       wc->log_key.objectid, wc->log_key.type,
-				       wc->log_key.offset, btrfs_root_id(root));
+		       "failed to insert item with key " BTRFS_KEY_FMT " root %llu",
+				       BTRFS_KEY_FMT_VALUE(&wc->log_key),
+				       btrfs_root_id(root));
 		goto out;
 	}
 	dest_offset = btrfs_item_ptr_offset(wc->subvol_path->nodes[0],
@@ -1348,9 +1347,9 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_log_replay(wc, ret,
-	       "failed to search subvolume tree for key (%llu %u %llu) root %llu",
-				       search_key.objectid, search_key.type,
-				       search_key.offset, btrfs_root_id(root));
+	       "failed to search subvolume tree for key " BTRFS_KEY_FMT " root %llu",
+				       BTRFS_KEY_FMT_VALUE(&search_key),
+				       btrfs_root_id(root));
 		return ret;
 	} else if (ret == 0) {
 		/*
@@ -1483,9 +1482,9 @@ static int unlink_old_inode_refs(struct walk_control *wc, struct btrfs_inode *in
 	}
 	if (ret < 0) {
 		btrfs_abort_log_replay(wc, ret,
-	       "failed to search subvolume tree for key (%llu %u %llu) root %llu",
-				       wc->log_key.objectid, wc->log_key.type,
-				       wc->log_key.offset, btrfs_root_id(root));
+	       "failed to search subvolume tree for key " BTRFS_KEY_FMT " root %llu",
+				       BTRFS_KEY_FMT_VALUE(&wc->log_key),
+				       btrfs_root_id(root));
 		goto out;
 	}
 
@@ -2700,10 +2699,9 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 						wc->subvol_path, 0, 0);
 			if (ret < 0) {
 				btrfs_abort_log_replay(wc, ret,
-			       "failed to search root %llu for key (%llu %u %llu)",
+			       "failed to search root %llu for key " BTRFS_KEY_FMT,
 						       btrfs_root_id(root),
-						       dir_key.objectid, dir_key.type,
-						       dir_key.offset);
+						       BTRFS_KEY_FMT_VALUE(&dir_key));
 				goto out;
 			}
 
-- 
2.47.2


