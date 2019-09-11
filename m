Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1EAF71E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfIKHqd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 03:46:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfIKHqc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 03:46:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D83CAAF85
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 07:46:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: Introduce btrfs child tree block verification system
Date:   Wed, 11 Sep 2019 15:46:24 +0800
Message-Id: <20190911074624.27322-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have btrfs_verify_level_key() function to check the first
key and level at tree block read time, it has its limitation due to tree
lock context, it's not reliable handling new tree blocks.

So btrfs_verify_level_key() is good as a pre-check, but it can't ensure
new tree blocks are still sane at runtime.

This patch will introduce the following things to address it:
- struct btrfs_child_verify
  To record needed info. It's mostly the old first_key + level
  combined into one structure.

- btrfs_init_child_verify()
  To fill needed info from @parent and @slot.
  It should be called at the same timing we fill existing first_key.

- btrfs_verify_child()
  The different part is, it must be called after we locked the tree
  blocks.

Compared to old btrfs_verify_level_key(), the following new checks are
added:
- Generation independent check on first_key, level and generation
  Even newly allocated tree blocks will still go through the check,
  preventing runtime corruptions.

- Empty tree check
  It's causing false alert in previous attempts, but with proper
  tree lock context, it shouldn't cause problem.

There are several exceptions which can't be verified by such facility:
- btrfs_search_old_slot()
- btrfs_next_old_leaf()

Those functions uses rewinded tree blocks, thus may not follow the
restrict first-key-must-match rule.

Since now the verification is done with tree lock hold, it's more safe
and we can verify all tree blocks no matter whatever, providing full
runtime cover for parent-child verification.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The old btrfs_verify_level_key() is still kept as is for now.
The plan for old btrfs_verify_key_level() is to only keep the level
check.

The reason for RFC is, although the patch survived several rounds of
xfstests, David has proved again and again that my VM setup is really
bad at catch race related bugs, so I'd keep the patch as RFC for some more
tests.
---
 fs/btrfs/ctree.c      | 136 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/ctree.h      |  18 ++++++
 fs/btrfs/qgroup.c     |  35 +++++++++--
 fs/btrfs/ref-verify.c |   9 +++
 4 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5df76c17775a..60bb7d23c12d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -288,6 +288,59 @@ struct tree_mod_elem {
 	struct tree_mod_root old_root;
 };
 
+int btrfs_verify_child(struct extent_buffer *child,
+		       struct btrfs_child_verify *verify)
+{
+	struct btrfs_fs_info *fs_info = child->fs_info;
+	int found_level;
+	struct btrfs_key found_key;
+	int ret;
+
+	found_level = btrfs_header_level(child);
+	if (found_level != verify->level) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+"tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
+			  child->start, verify->level, found_level);
+		return -EUCLEAN;
+	}
+
+	if (btrfs_header_generation(child) != verify->gen) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+"generation mismatch detected, bytenr=%llu gen expected=%llu has=%llu",
+			  child->start, verify->gen,
+			  btrfs_header_generation(child));
+		return -EUCLEAN;
+	}
+	/* We have first key, the tree block should not be empty */
+	if (btrfs_header_nritems(child) == 0) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+		"invalid empty tree block, parent has key (%llu %u %llu)",
+			  verify->first_key.objectid, verify->first_key.type,
+			  verify->first_key.offset);
+		return -EUCLEAN;
+	}
+
+	if (found_level)
+		btrfs_node_key_to_cpu(child, &found_key, 0);
+	else
+		btrfs_item_key_to_cpu(child, &found_key, 0);
+	ret = btrfs_comp_cpu_keys(&verify->first_key, &found_key);
+
+	if (ret) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+"tree first key mismatch detected, bytenr=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
+			  child->start, verify->first_key.objectid,
+			  verify->first_key.type, verify->first_key.offset,
+			  found_key.objectid, found_key.type,
+			  found_key.offset);
+	}
+	return ret;
+}
+
 /*
  * Pull a new tree mod seq number for our operation.
  */
@@ -1598,6 +1651,7 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	btrfs_set_lock_blocking_write(parent);
 
 	for (i = start_slot; i <= end_slot; i++) {
+		struct btrfs_child_verify verify;
 		struct btrfs_key first_key;
 		int close = 1;
 
@@ -1609,6 +1663,7 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 		blocknr = btrfs_node_blockptr(parent, i);
 		gen = btrfs_node_ptr_generation(parent, i);
 		btrfs_node_key_to_cpu(parent, &first_key, i);
+		btrfs_init_child_verify(parent, i, &verify);
 		if (last_block == 0)
 			last_block = blocknr;
 
@@ -1655,6 +1710,12 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 
 		btrfs_tree_lock(cur);
 		btrfs_set_lock_blocking_write(cur);
+		if (btrfs_verify_child(cur, &verify)) {
+			err = -EUCLEAN;
+			btrfs_tree_unlock(cur);
+			free_extent_buffer(cur);
+			break;
+		}
 		err = __btrfs_cow_block(trans, root, cur, parent, i,
 					&cur, search_start,
 					min(16 * blocksize,
@@ -1824,6 +1885,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			 struct btrfs_path *path, int level)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_child_verify verify;
 	struct extent_buffer *right = NULL;
 	struct extent_buffer *mid;
 	struct extent_buffer *left = NULL;
@@ -1859,6 +1921,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (btrfs_header_nritems(mid) != 1)
 			return 0;
 
+		btrfs_init_child_verify(mid, 0, &verify);
 		/* promote the child to a root */
 		child = read_node_slot(mid, 0);
 		if (IS_ERR(child)) {
@@ -1869,6 +1932,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		btrfs_tree_lock(child);
 		btrfs_set_lock_blocking_write(child);
+		if (btrfs_verify_child(child, &verify)) {
+			ret = -EUCLEAN;
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			goto enospc;
+		}
 		ret = btrfs_cow_block(trans, root, child, mid, 0, &child);
 		if (ret) {
 			btrfs_tree_unlock(child);
@@ -1900,6 +1969,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
 		return 0;
 
+	btrfs_init_child_verify(parent, pslot - 1, &verify);
 	left = read_node_slot(parent, pslot - 1);
 	if (IS_ERR(left))
 		left = NULL;
@@ -1907,6 +1977,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	if (left) {
 		btrfs_tree_lock(left);
 		btrfs_set_lock_blocking_write(left);
+		if (btrfs_verify_child(left, &verify)) {
+			ret = -EUCLEAN;
+			goto enospc;
+		}
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left);
 		if (wret) {
@@ -1915,6 +1989,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	btrfs_init_child_verify(parent, pslot + 1, &verify);
 	right = read_node_slot(parent, pslot + 1);
 	if (IS_ERR(right))
 		right = NULL;
@@ -1922,6 +1997,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	if (right) {
 		btrfs_tree_lock(right);
 		btrfs_set_lock_blocking_write(right);
+		if (btrfs_verify_child(right, &verify)) {
+			ret = -EUCLEAN;
+			goto enospc;
+		}
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right);
 		if (wret) {
@@ -2056,6 +2135,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	struct extent_buffer *mid;
 	struct extent_buffer *left = NULL;
 	struct extent_buffer *parent = NULL;
+	struct btrfs_child_verify verify;
 	int ret = 0;
 	int wret;
 	int pslot;
@@ -2075,6 +2155,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (!parent)
 		return 1;
 
+	btrfs_init_child_verify(parent, pslot - 1, &verify);
 	left = read_node_slot(parent, pslot - 1);
 	if (IS_ERR(left))
 		left = NULL;
@@ -2085,6 +2166,11 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 
 		btrfs_tree_lock(left);
 		btrfs_set_lock_blocking_write(left);
+		if (btrfs_verify_child(left, &verify)) {
+			btrfs_tree_unlock(left);
+			free_extent_buffer(left);
+			return -EUCLEAN;
+		}
 
 		left_nr = btrfs_header_nritems(left);
 		if (left_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2127,6 +2213,8 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(left);
 		free_extent_buffer(left);
 	}
+
+	btrfs_init_child_verify(parent, pslot + 1, &verify);
 	right = read_node_slot(parent, pslot + 1);
 	if (IS_ERR(right))
 		right = NULL;
@@ -2140,6 +2228,11 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		btrfs_tree_lock(right);
 		btrfs_set_lock_blocking_write(right);
 
+		if (btrfs_verify_child(right, &verify)) {
+			btrfs_tree_unlock(right);
+			free_extent_buffer(right);
+			return -EUCLEAN;
+		}
 		right_nr = btrfs_header_nritems(right);
 		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
 			wret = 1;
@@ -2761,6 +2854,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 
 	while (b) {
+		struct btrfs_child_verify verify;
 		level = btrfs_header_level(b);
 
 		/*
@@ -2868,6 +2962,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				goto again;
 			}
 
+			btrfs_init_child_verify(b, slot, &verify);
 			unlock_up(p, level, lowest_unlock,
 				  min_write_lock_level, &write_lock_level);
 
@@ -2887,24 +2982,28 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 
 			if (!p->skip_locking) {
-				level = btrfs_header_level(b);
-				if (level <= write_lock_level) {
+				if (level - 1 <= write_lock_level) {
 					err = btrfs_try_tree_write_lock(b);
 					if (!err) {
 						btrfs_set_path_blocking(p);
 						btrfs_tree_lock(b);
 					}
-					p->locks[level] = BTRFS_WRITE_LOCK;
+					p->locks[level - 1] = BTRFS_WRITE_LOCK;
 				} else {
 					err = btrfs_tree_read_lock_atomic(b);
 					if (!err) {
 						btrfs_set_path_blocking(p);
 						btrfs_tree_read_lock(b);
 					}
-					p->locks[level] = BTRFS_READ_LOCK;
+					p->locks[level - 1] = BTRFS_READ_LOCK;
 				}
-				p->nodes[level] = b;
+				p->nodes[level - 1] = b;
 			}
+			if (btrfs_verify_child(b, &verify)) {
+				ret = -EUCLEAN;
+				goto done;
+ 			}
+			level = btrfs_header_level(b);
 		} else {
 			p->slots[level] = slot;
 			if (ins_len > 0 &&
@@ -3021,6 +3120,11 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 				goto done;
 			}
 
+			/*
+			 * Here we don't verify the tree blocks, as @b can be
+			 * already rewinded, thus its key may not match child
+			 * by nature.
+			 */
 			err = read_block_for_search(root, p, &b, level,
 						    slot, key);
 			if (err == -EAGAIN)
@@ -3763,6 +3867,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 			   int min_data_size, int data_size,
 			   int empty, u32 min_slot)
 {
+	struct btrfs_child_verify verify;
 	struct extent_buffer *left = path->nodes[0];
 	struct extent_buffer *right;
 	struct extent_buffer *upper;
@@ -3781,6 +3886,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	btrfs_assert_tree_locked(path->nodes[1]);
 
+	btrfs_init_child_verify(upper, slot + 1, &verify);
 	right = read_node_slot(upper, slot + 1);
 	/*
 	 * slot + 1 is not valid or we fail to read the right node,
@@ -3792,6 +3898,12 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_tree_lock(right);
 	btrfs_set_lock_blocking_write(right);
 
+	if (btrfs_verify_child(right, &verify)) {
+		btrfs_tree_unlock(right);
+		free_extent_buffer(right);
+		return -EUCLEAN;
+	}
+
 	free_space = btrfs_leaf_free_space(right);
 	if (free_space < data_size)
 		goto out_unlock;
@@ -3996,6 +4108,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 			  *root, struct btrfs_path *path, int min_data_size,
 			  int data_size, int empty, u32 max_slot)
 {
+	struct btrfs_child_verify verify;
 	struct extent_buffer *right = path->nodes[0];
 	struct extent_buffer *left;
 	int slot;
@@ -4015,6 +4128,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	btrfs_assert_tree_locked(path->nodes[1]);
 
+	btrfs_init_child_verify(path->nodes[1], slot - 1, &verify);
 	left = read_node_slot(path->nodes[1], slot - 1);
 	/*
 	 * slot - 1 is not valid or we fail to read the left node,
@@ -4025,6 +4139,10 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	btrfs_tree_lock(left);
 	btrfs_set_lock_blocking_write(left);
+	if (btrfs_verify_child(left, &verify)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
@@ -5164,6 +5282,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 		goto out;
 	}
 	while (1) {
+		struct btrfs_child_verify verify;
+
 		nritems = btrfs_header_nritems(cur);
 		level = btrfs_header_level(cur);
 		sret = btrfs_bin_search(cur, min_key, level, &slot);
@@ -5222,6 +5342,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			goto out;
 		}
 		btrfs_set_path_blocking(path);
+		btrfs_init_child_verify(cur, slot, &verify);
 		cur = read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
@@ -5229,6 +5350,11 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 		}
 
 		btrfs_tree_read_lock(cur);
+		if (btrfs_verify_child(cur, &verify)) {
+			ret = -EUCLEAN;
+			btrfs_tree_read_unlock(cur);
+			goto out;
+		}
 
 		path->locks[level - 1] = BTRFS_READ_LOCK;
 		path->nodes[level - 1] = cur;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 94660063a162..13e406c293ea 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1283,6 +1283,13 @@ struct btrfs_file_private {
 	void *filldir_buf;
 };
 
+/* Used to store all needed info to verify child tree block */
+struct btrfs_child_verify {
+	struct btrfs_key first_key;
+	u64 gen;
+	int level;
+};
+
 static inline u32 btrfs_inode_sectorsize(const struct inode *inode)
 {
 	return btrfs_sb(inode->i_sb)->sectorsize;
@@ -2915,6 +2922,8 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
 			struct extent_buffer *node,
 			struct extent_buffer *parent);
+int btrfs_verify_child(struct extent_buffer *child,
+		       struct btrfs_child_verify *verify);
 static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
 {
 	/*
@@ -3744,4 +3753,13 @@ static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
 		wake_up(wq);
 }
 
+static inline void btrfs_init_child_verify(struct extent_buffer *parent,
+					   int slot,
+					   struct btrfs_child_verify *verify)
+{
+	btrfs_node_key_to_cpu(parent, &verify->first_key, slot);
+	verify->level = btrfs_header_level(parent) - 1;
+	verify->gen = btrfs_node_ptr_generation(parent, slot);
+}
+
 #endif
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f8a3c1b0a15a..2891b57b9e1e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1810,6 +1810,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		struct btrfs_key dst_key;
 
 		if (src_path->nodes[cur_level] == NULL) {
+			struct btrfs_child_verify verify;
 			struct btrfs_key first_key;
 			struct extent_buffer *eb;
 			int parent_slot;
@@ -1821,6 +1822,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
 			child_gen = btrfs_node_ptr_generation(eb, parent_slot);
 			btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
+			btrfs_init_child_verify(eb, parent_slot, &verify);
 
 			eb = read_tree_block(fs_info, child_bytenr, child_gen,
 					     cur_level, &first_key);
@@ -1833,10 +1835,16 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 				goto out;
 			}
 
-			src_path->nodes[cur_level] = eb;
 
 			btrfs_tree_read_lock(eb);
 			btrfs_set_lock_blocking_read(eb);
+			if (btrfs_verify_child(eb, &verify)) {
+				ret = -EUCLEAN;
+				btrfs_tree_unlock(eb);
+				free_extent_buffer(eb);
+				goto out;
+			}
+			src_path->nodes[cur_level] = eb;
 			src_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
 		}
 
@@ -1932,6 +1940,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 
 	/* Read the tree block if needed */
 	if (dst_path->nodes[cur_level] == NULL) {
+		struct btrfs_child_verify verify;
 		struct btrfs_key first_key;
 		int parent_slot;
 		u64 child_gen;
@@ -1957,6 +1966,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		child_bytenr = btrfs_node_blockptr(eb, parent_slot);
 		child_gen = btrfs_node_ptr_generation(eb, parent_slot);
 		btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
+		btrfs_init_child_verify(eb, parent_slot, &verify);
 
 		/* This node is old, no need to trace */
 		if (child_gen < last_snapshot)
@@ -1973,11 +1983,16 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 			goto out;
 		}
 
-		dst_path->nodes[cur_level] = eb;
-		dst_path->slots[cur_level] = 0;
-
 		btrfs_tree_read_lock(eb);
 		btrfs_set_lock_blocking_read(eb);
+		if (btrfs_verify_child(eb, &verify)) {
+			ret = -EUCLEAN;
+			btrfs_tree_read_unlock(eb);
+			free_extent_buffer(eb);
+			goto out;
+		}
+		dst_path->nodes[cur_level] = eb;
+		dst_path->slots[cur_level] = 0;
 		dst_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
 		need_cleanup = true;
 	}
@@ -2122,6 +2137,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	level = root_level;
 	while (level >= 0) {
 		if (path->nodes[level] == NULL) {
+			struct btrfs_child_verify verify;
 			struct btrfs_key first_key;
 			int parent_slot;
 			u64 child_gen;
@@ -2136,6 +2152,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
 			child_gen = btrfs_node_ptr_generation(eb, parent_slot);
 			btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
+			btrfs_init_child_verify(eb, parent_slot, &verify);
 
 			eb = read_tree_block(fs_info, child_bytenr, child_gen,
 					     level, &first_key);
@@ -2148,11 +2165,17 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			path->nodes[level] = eb;
-			path->slots[level] = 0;
 
 			btrfs_tree_read_lock(eb);
 			btrfs_set_lock_blocking_read(eb);
+			if (btrfs_verify_child(eb, &verify)) {
+				ret = -EUCLEAN;
+				btrfs_tree_read_unlock(eb);
+				free_extent_buffer(eb);
+				goto out;
+			}
+			path->nodes[level] = eb;
+			path->slots[level] = 0;
 			path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
 
 			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index e87cbdad02a3..1447235e845d 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -556,6 +556,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 
 	while (level >= 0) {
 		if (level) {
+			struct btrfs_child_verify verify;
 			struct btrfs_key first_key;
 
 			block_bytenr = btrfs_node_blockptr(path->nodes[level],
@@ -564,6 +565,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 							path->slots[level]);
 			btrfs_node_key_to_cpu(path->nodes[level], &first_key,
 					      path->slots[level]);
+			btrfs_init_child_verify(path->nodes[level],
+						path->slots[level], &verify);
+
 			eb = read_tree_block(fs_info, block_bytenr, gen,
 					     level - 1, &first_key);
 			if (IS_ERR(eb))
@@ -574,6 +578,11 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			}
 			btrfs_tree_read_lock(eb);
 			btrfs_set_lock_blocking_read(eb);
+			if (btrfs_verify_child(eb, &verify)) {
+				btrfs_tree_unlock(eb);
+				free_extent_buffer(eb);
+				return -EUCLEAN;
+			}
 			path->nodes[level-1] = eb;
 			path->slots[level-1] = 0;
 			path->locks[level-1] = BTRFS_READ_LOCK_BLOCKING;
-- 
2.23.0

