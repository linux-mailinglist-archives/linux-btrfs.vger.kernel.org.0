Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8A9B528
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbfHWRJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:54358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732787AbfHWRIU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 949C7AC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA607DA796; Fri, 23 Aug 2019 19:08:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/7] btrfs: move functions for tree compare to send.c
Date:   Fri, 23 Aug 2019 19:08:43 +0200
Message-Id: <7d321b00740d4cfb64774d2842cc861ce9ab72a6.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566579823.git.dsterba@suse.com>
References: <cover.1566579823.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Send is the only user of tree_compare, we can move it there along with
the other helpers and definitions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 362 ---------------------------------------------
 fs/btrfs/ctree.h |  14 --
 fs/btrfs/send.c  | 374 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+), 376 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3b585f3e4d11..fbf94e28fba8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5246,368 +5246,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	return ret;
 }
 
-static int tree_move_down(struct btrfs_path *path, int *level)
-{
-	struct extent_buffer *eb;
-
-	BUG_ON(*level == 0);
-	eb = btrfs_read_node_slot(path->nodes[*level], path->slots[*level]);
-	if (IS_ERR(eb))
-		return PTR_ERR(eb);
-
-	path->nodes[*level - 1] = eb;
-	path->slots[*level - 1] = 0;
-	(*level)--;
-	return 0;
-}
-
-static int tree_move_next_or_upnext(struct btrfs_path *path,
-				    int *level, int root_level)
-{
-	int ret = 0;
-	int nritems;
-	nritems = btrfs_header_nritems(path->nodes[*level]);
-
-	path->slots[*level]++;
-
-	while (path->slots[*level] >= nritems) {
-		if (*level == root_level)
-			return -1;
-
-		/* move upnext */
-		path->slots[*level] = 0;
-		free_extent_buffer(path->nodes[*level]);
-		path->nodes[*level] = NULL;
-		(*level)++;
-		path->slots[*level]++;
-
-		nritems = btrfs_header_nritems(path->nodes[*level]);
-		ret = 1;
-	}
-	return ret;
-}
-
-/*
- * Returns 1 if it had to move up and next. 0 is returned if it moved only next
- * or down.
- */
-static int tree_advance(struct btrfs_path *path,
-			int *level, int root_level,
-			int allow_down,
-			struct btrfs_key *key)
-{
-	int ret;
-
-	if (*level == 0 || !allow_down) {
-		ret = tree_move_next_or_upnext(path, level, root_level);
-	} else {
-		ret = tree_move_down(path, level);
-	}
-	if (ret >= 0) {
-		if (*level == 0)
-			btrfs_item_key_to_cpu(path->nodes[*level], key,
-					path->slots[*level]);
-		else
-			btrfs_node_key_to_cpu(path->nodes[*level], key,
-					path->slots[*level]);
-	}
-	return ret;
-}
-
-static int tree_compare_item(struct btrfs_path *left_path,
-			     struct btrfs_path *right_path,
-			     char *tmp_buf)
-{
-	int cmp;
-	int len1, len2;
-	unsigned long off1, off2;
-
-	len1 = btrfs_item_size_nr(left_path->nodes[0], left_path->slots[0]);
-	len2 = btrfs_item_size_nr(right_path->nodes[0], right_path->slots[0]);
-	if (len1 != len2)
-		return 1;
-
-	off1 = btrfs_item_ptr_offset(left_path->nodes[0], left_path->slots[0]);
-	off2 = btrfs_item_ptr_offset(right_path->nodes[0],
-				right_path->slots[0]);
-
-	read_extent_buffer(left_path->nodes[0], tmp_buf, off1, len1);
-
-	cmp = memcmp_extent_buffer(right_path->nodes[0], tmp_buf, off2, len1);
-	if (cmp)
-		return 1;
-	return 0;
-}
-
-#define ADVANCE 1
-#define ADVANCE_ONLY_NEXT -1
-
-/*
- * This function compares two trees and calls the provided callback for
- * every changed/new/deleted item it finds.
- * If shared tree blocks are encountered, whole subtrees are skipped, making
- * the compare pretty fast on snapshotted subvolumes.
- *
- * This currently works on commit roots only. As commit roots are read only,
- * we don't do any locking. The commit roots are protected with transactions.
- * Transactions are ended and rejoined when a commit is tried in between.
- *
- * This function checks for modifications done to the trees while comparing.
- * If it detects a change, it aborts immediately.
- */
-int btrfs_compare_trees(struct btrfs_root *left_root,
-			struct btrfs_root *right_root,
-			btrfs_changed_cb_t changed_cb, void *ctx)
-{
-	struct btrfs_fs_info *fs_info = left_root->fs_info;
-	int ret;
-	int cmp;
-	struct btrfs_path *left_path = NULL;
-	struct btrfs_path *right_path = NULL;
-	struct btrfs_key left_key;
-	struct btrfs_key right_key;
-	char *tmp_buf = NULL;
-	int left_root_level;
-	int right_root_level;
-	int left_level;
-	int right_level;
-	int left_end_reached;
-	int right_end_reached;
-	int advance_left;
-	int advance_right;
-	u64 left_blockptr;
-	u64 right_blockptr;
-	u64 left_gen;
-	u64 right_gen;
-
-	left_path = btrfs_alloc_path();
-	if (!left_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	right_path = btrfs_alloc_path();
-	if (!right_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	tmp_buf = kvmalloc(fs_info->nodesize, GFP_KERNEL);
-	if (!tmp_buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	left_path->search_commit_root = 1;
-	left_path->skip_locking = 1;
-	right_path->search_commit_root = 1;
-	right_path->skip_locking = 1;
-
-	/*
-	 * Strategy: Go to the first items of both trees. Then do
-	 *
-	 * If both trees are at level 0
-	 *   Compare keys of current items
-	 *     If left < right treat left item as new, advance left tree
-	 *       and repeat
-	 *     If left > right treat right item as deleted, advance right tree
-	 *       and repeat
-	 *     If left == right do deep compare of items, treat as changed if
-	 *       needed, advance both trees and repeat
-	 * If both trees are at the same level but not at level 0
-	 *   Compare keys of current nodes/leafs
-	 *     If left < right advance left tree and repeat
-	 *     If left > right advance right tree and repeat
-	 *     If left == right compare blockptrs of the next nodes/leafs
-	 *       If they match advance both trees but stay at the same level
-	 *         and repeat
-	 *       If they don't match advance both trees while allowing to go
-	 *         deeper and repeat
-	 * If tree levels are different
-	 *   Advance the tree that needs it and repeat
-	 *
-	 * Advancing a tree means:
-	 *   If we are at level 0, try to go to the next slot. If that's not
-	 *   possible, go one level up and repeat. Stop when we found a level
-	 *   where we could go to the next slot. We may at this point be on a
-	 *   node or a leaf.
-	 *
-	 *   If we are not at level 0 and not on shared tree blocks, go one
-	 *   level deeper.
-	 *
-	 *   If we are not at level 0 and on shared tree blocks, go one slot to
-	 *   the right if possible or go up and right.
-	 */
-
-	down_read(&fs_info->commit_root_sem);
-	left_level = btrfs_header_level(left_root->commit_root);
-	left_root_level = left_level;
-	left_path->nodes[left_level] =
-			btrfs_clone_extent_buffer(left_root->commit_root);
-	if (!left_path->nodes[left_level]) {
-		up_read(&fs_info->commit_root_sem);
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	right_level = btrfs_header_level(right_root->commit_root);
-	right_root_level = right_level;
-	right_path->nodes[right_level] =
-			btrfs_clone_extent_buffer(right_root->commit_root);
-	if (!right_path->nodes[right_level]) {
-		up_read(&fs_info->commit_root_sem);
-		ret = -ENOMEM;
-		goto out;
-	}
-	up_read(&fs_info->commit_root_sem);
-
-	if (left_level == 0)
-		btrfs_item_key_to_cpu(left_path->nodes[left_level],
-				&left_key, left_path->slots[left_level]);
-	else
-		btrfs_node_key_to_cpu(left_path->nodes[left_level],
-				&left_key, left_path->slots[left_level]);
-	if (right_level == 0)
-		btrfs_item_key_to_cpu(right_path->nodes[right_level],
-				&right_key, right_path->slots[right_level]);
-	else
-		btrfs_node_key_to_cpu(right_path->nodes[right_level],
-				&right_key, right_path->slots[right_level]);
-
-	left_end_reached = right_end_reached = 0;
-	advance_left = advance_right = 0;
-
-	while (1) {
-		if (advance_left && !left_end_reached) {
-			ret = tree_advance(left_path, &left_level,
-					left_root_level,
-					advance_left != ADVANCE_ONLY_NEXT,
-					&left_key);
-			if (ret == -1)
-				left_end_reached = ADVANCE;
-			else if (ret < 0)
-				goto out;
-			advance_left = 0;
-		}
-		if (advance_right && !right_end_reached) {
-			ret = tree_advance(right_path, &right_level,
-					right_root_level,
-					advance_right != ADVANCE_ONLY_NEXT,
-					&right_key);
-			if (ret == -1)
-				right_end_reached = ADVANCE;
-			else if (ret < 0)
-				goto out;
-			advance_right = 0;
-		}
-
-		if (left_end_reached && right_end_reached) {
-			ret = 0;
-			goto out;
-		} else if (left_end_reached) {
-			if (right_level == 0) {
-				ret = changed_cb(left_path, right_path,
-						&right_key,
-						BTRFS_COMPARE_TREE_DELETED,
-						ctx);
-				if (ret < 0)
-					goto out;
-			}
-			advance_right = ADVANCE;
-			continue;
-		} else if (right_end_reached) {
-			if (left_level == 0) {
-				ret = changed_cb(left_path, right_path,
-						&left_key,
-						BTRFS_COMPARE_TREE_NEW,
-						ctx);
-				if (ret < 0)
-					goto out;
-			}
-			advance_left = ADVANCE;
-			continue;
-		}
-
-		if (left_level == 0 && right_level == 0) {
-			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
-			if (cmp < 0) {
-				ret = changed_cb(left_path, right_path,
-						&left_key,
-						BTRFS_COMPARE_TREE_NEW,
-						ctx);
-				if (ret < 0)
-					goto out;
-				advance_left = ADVANCE;
-			} else if (cmp > 0) {
-				ret = changed_cb(left_path, right_path,
-						&right_key,
-						BTRFS_COMPARE_TREE_DELETED,
-						ctx);
-				if (ret < 0)
-					goto out;
-				advance_right = ADVANCE;
-			} else {
-				enum btrfs_compare_tree_result result;
-
-				WARN_ON(!extent_buffer_uptodate(left_path->nodes[0]));
-				ret = tree_compare_item(left_path, right_path,
-							tmp_buf);
-				if (ret)
-					result = BTRFS_COMPARE_TREE_CHANGED;
-				else
-					result = BTRFS_COMPARE_TREE_SAME;
-				ret = changed_cb(left_path, right_path,
-						 &left_key, result, ctx);
-				if (ret < 0)
-					goto out;
-				advance_left = ADVANCE;
-				advance_right = ADVANCE;
-			}
-		} else if (left_level == right_level) {
-			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
-			if (cmp < 0) {
-				advance_left = ADVANCE;
-			} else if (cmp > 0) {
-				advance_right = ADVANCE;
-			} else {
-				left_blockptr = btrfs_node_blockptr(
-						left_path->nodes[left_level],
-						left_path->slots[left_level]);
-				right_blockptr = btrfs_node_blockptr(
-						right_path->nodes[right_level],
-						right_path->slots[right_level]);
-				left_gen = btrfs_node_ptr_generation(
-						left_path->nodes[left_level],
-						left_path->slots[left_level]);
-				right_gen = btrfs_node_ptr_generation(
-						right_path->nodes[right_level],
-						right_path->slots[right_level]);
-				if (left_blockptr == right_blockptr &&
-				    left_gen == right_gen) {
-					/*
-					 * As we're on a shared block, don't
-					 * allow to go deeper.
-					 */
-					advance_left = ADVANCE_ONLY_NEXT;
-					advance_right = ADVANCE_ONLY_NEXT;
-				} else {
-					advance_left = ADVANCE;
-					advance_right = ADVANCE;
-				}
-			}
-		} else if (left_level < right_level) {
-			advance_right = ADVANCE;
-		} else {
-			advance_left = ADVANCE;
-		}
-	}
-
-out:
-	btrfs_free_path(left_path);
-	btrfs_free_path(right_path);
-	kvfree(tmp_buf);
-	return ret;
-}
-
 /*
  * this is similar to btrfs_next_leaf, but does not try to preserve
  * and fixup the path.  It looks for and returns the next key in the
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 70a80db23ecc..1fd5931a9489 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2589,20 +2589,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 					   int slot);
 
-enum btrfs_compare_tree_result {
-	BTRFS_COMPARE_TREE_NEW,
-	BTRFS_COMPARE_TREE_DELETED,
-	BTRFS_COMPARE_TREE_CHANGED,
-	BTRFS_COMPARE_TREE_SAME,
-};
-typedef int (*btrfs_changed_cb_t)(struct btrfs_path *left_path,
-				  struct btrfs_path *right_path,
-				  struct btrfs_key *key,
-				  enum btrfs_compare_tree_result result,
-				  void *ctx);
-int btrfs_compare_trees(struct btrfs_root *left_root,
-			struct btrfs_root *right_root,
-			btrfs_changed_cb_t cb, void *ctx);
 int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c3c0c064c25d..f856d6ca3771 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -260,6 +260,21 @@ struct name_cache_entry {
 	char name[];
 };
 
+#define ADVANCE							1
+#define ADVANCE_ONLY_NEXT					-1
+
+enum btrfs_compare_tree_result {
+	BTRFS_COMPARE_TREE_NEW,
+	BTRFS_COMPARE_TREE_DELETED,
+	BTRFS_COMPARE_TREE_CHANGED,
+	BTRFS_COMPARE_TREE_SAME,
+};
+typedef int (*btrfs_changed_cb_t)(struct btrfs_path *left_path,
+				  struct btrfs_path *right_path,
+				  struct btrfs_key *key,
+				  enum btrfs_compare_tree_result result,
+				  void *ctx);
+
 __cold
 static void inconsistent_snapshot_error(struct send_ctx *sctx,
 					enum btrfs_compare_tree_result result,
@@ -6514,6 +6529,365 @@ static int full_send_tree(struct send_ctx *sctx)
 	return ret;
 }
 
+static int tree_move_down(struct btrfs_path *path, int *level)
+{
+	struct extent_buffer *eb;
+
+	BUG_ON(*level == 0);
+	eb = btrfs_read_node_slot(path->nodes[*level], path->slots[*level]);
+	if (IS_ERR(eb))
+		return PTR_ERR(eb);
+
+	path->nodes[*level - 1] = eb;
+	path->slots[*level - 1] = 0;
+	(*level)--;
+	return 0;
+}
+
+static int tree_move_next_or_upnext(struct btrfs_path *path,
+				    int *level, int root_level)
+{
+	int ret = 0;
+	int nritems;
+	nritems = btrfs_header_nritems(path->nodes[*level]);
+
+	path->slots[*level]++;
+
+	while (path->slots[*level] >= nritems) {
+		if (*level == root_level)
+			return -1;
+
+		/* move upnext */
+		path->slots[*level] = 0;
+		free_extent_buffer(path->nodes[*level]);
+		path->nodes[*level] = NULL;
+		(*level)++;
+		path->slots[*level]++;
+
+		nritems = btrfs_header_nritems(path->nodes[*level]);
+		ret = 1;
+	}
+	return ret;
+}
+
+/*
+ * Returns 1 if it had to move up and next. 0 is returned if it moved only next
+ * or down.
+ */
+static int tree_advance(struct btrfs_path *path,
+			int *level, int root_level,
+			int allow_down,
+			struct btrfs_key *key)
+{
+	int ret;
+
+	if (*level == 0 || !allow_down) {
+		ret = tree_move_next_or_upnext(path, level, root_level);
+	} else {
+		ret = tree_move_down(path, level);
+	}
+	if (ret >= 0) {
+		if (*level == 0)
+			btrfs_item_key_to_cpu(path->nodes[*level], key,
+					path->slots[*level]);
+		else
+			btrfs_node_key_to_cpu(path->nodes[*level], key,
+					path->slots[*level]);
+	}
+	return ret;
+}
+
+static int tree_compare_item(struct btrfs_path *left_path,
+			     struct btrfs_path *right_path,
+			     char *tmp_buf)
+{
+	int cmp;
+	int len1, len2;
+	unsigned long off1, off2;
+
+	len1 = btrfs_item_size_nr(left_path->nodes[0], left_path->slots[0]);
+	len2 = btrfs_item_size_nr(right_path->nodes[0], right_path->slots[0]);
+	if (len1 != len2)
+		return 1;
+
+	off1 = btrfs_item_ptr_offset(left_path->nodes[0], left_path->slots[0]);
+	off2 = btrfs_item_ptr_offset(right_path->nodes[0],
+				right_path->slots[0]);
+
+	read_extent_buffer(left_path->nodes[0], tmp_buf, off1, len1);
+
+	cmp = memcmp_extent_buffer(right_path->nodes[0], tmp_buf, off2, len1);
+	if (cmp)
+		return 1;
+	return 0;
+}
+
+/*
+ * This function compares two trees and calls the provided callback for
+ * every changed/new/deleted item it finds.
+ * If shared tree blocks are encountered, whole subtrees are skipped, making
+ * the compare pretty fast on snapshotted subvolumes.
+ *
+ * This currently works on commit roots only. As commit roots are read only,
+ * we don't do any locking. The commit roots are protected with transactions.
+ * Transactions are ended and rejoined when a commit is tried in between.
+ *
+ * This function checks for modifications done to the trees while comparing.
+ * If it detects a change, it aborts immediately.
+ */
+static int btrfs_compare_trees(struct btrfs_root *left_root,
+			struct btrfs_root *right_root,
+			btrfs_changed_cb_t changed_cb, void *ctx)
+{
+	struct btrfs_fs_info *fs_info = left_root->fs_info;
+	int ret;
+	int cmp;
+	struct btrfs_path *left_path = NULL;
+	struct btrfs_path *right_path = NULL;
+	struct btrfs_key left_key;
+	struct btrfs_key right_key;
+	char *tmp_buf = NULL;
+	int left_root_level;
+	int right_root_level;
+	int left_level;
+	int right_level;
+	int left_end_reached;
+	int right_end_reached;
+	int advance_left;
+	int advance_right;
+	u64 left_blockptr;
+	u64 right_blockptr;
+	u64 left_gen;
+	u64 right_gen;
+
+	left_path = btrfs_alloc_path();
+	if (!left_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	right_path = btrfs_alloc_path();
+	if (!right_path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tmp_buf = kvmalloc(fs_info->nodesize, GFP_KERNEL);
+	if (!tmp_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	left_path->search_commit_root = 1;
+	left_path->skip_locking = 1;
+	right_path->search_commit_root = 1;
+	right_path->skip_locking = 1;
+
+	/*
+	 * Strategy: Go to the first items of both trees. Then do
+	 *
+	 * If both trees are at level 0
+	 *   Compare keys of current items
+	 *     If left < right treat left item as new, advance left tree
+	 *       and repeat
+	 *     If left > right treat right item as deleted, advance right tree
+	 *       and repeat
+	 *     If left == right do deep compare of items, treat as changed if
+	 *       needed, advance both trees and repeat
+	 * If both trees are at the same level but not at level 0
+	 *   Compare keys of current nodes/leafs
+	 *     If left < right advance left tree and repeat
+	 *     If left > right advance right tree and repeat
+	 *     If left == right compare blockptrs of the next nodes/leafs
+	 *       If they match advance both trees but stay at the same level
+	 *         and repeat
+	 *       If they don't match advance both trees while allowing to go
+	 *         deeper and repeat
+	 * If tree levels are different
+	 *   Advance the tree that needs it and repeat
+	 *
+	 * Advancing a tree means:
+	 *   If we are at level 0, try to go to the next slot. If that's not
+	 *   possible, go one level up and repeat. Stop when we found a level
+	 *   where we could go to the next slot. We may at this point be on a
+	 *   node or a leaf.
+	 *
+	 *   If we are not at level 0 and not on shared tree blocks, go one
+	 *   level deeper.
+	 *
+	 *   If we are not at level 0 and on shared tree blocks, go one slot to
+	 *   the right if possible or go up and right.
+	 */
+
+	down_read(&fs_info->commit_root_sem);
+	left_level = btrfs_header_level(left_root->commit_root);
+	left_root_level = left_level;
+	left_path->nodes[left_level] =
+			btrfs_clone_extent_buffer(left_root->commit_root);
+	if (!left_path->nodes[left_level]) {
+		up_read(&fs_info->commit_root_sem);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	right_level = btrfs_header_level(right_root->commit_root);
+	right_root_level = right_level;
+	right_path->nodes[right_level] =
+			btrfs_clone_extent_buffer(right_root->commit_root);
+	if (!right_path->nodes[right_level]) {
+		up_read(&fs_info->commit_root_sem);
+		ret = -ENOMEM;
+		goto out;
+	}
+	up_read(&fs_info->commit_root_sem);
+
+	if (left_level == 0)
+		btrfs_item_key_to_cpu(left_path->nodes[left_level],
+				&left_key, left_path->slots[left_level]);
+	else
+		btrfs_node_key_to_cpu(left_path->nodes[left_level],
+				&left_key, left_path->slots[left_level]);
+	if (right_level == 0)
+		btrfs_item_key_to_cpu(right_path->nodes[right_level],
+				&right_key, right_path->slots[right_level]);
+	else
+		btrfs_node_key_to_cpu(right_path->nodes[right_level],
+				&right_key, right_path->slots[right_level]);
+
+	left_end_reached = right_end_reached = 0;
+	advance_left = advance_right = 0;
+
+	while (1) {
+		if (advance_left && !left_end_reached) {
+			ret = tree_advance(left_path, &left_level,
+					left_root_level,
+					advance_left != ADVANCE_ONLY_NEXT,
+					&left_key);
+			if (ret == -1)
+				left_end_reached = ADVANCE;
+			else if (ret < 0)
+				goto out;
+			advance_left = 0;
+		}
+		if (advance_right && !right_end_reached) {
+			ret = tree_advance(right_path, &right_level,
+					right_root_level,
+					advance_right != ADVANCE_ONLY_NEXT,
+					&right_key);
+			if (ret == -1)
+				right_end_reached = ADVANCE;
+			else if (ret < 0)
+				goto out;
+			advance_right = 0;
+		}
+
+		if (left_end_reached && right_end_reached) {
+			ret = 0;
+			goto out;
+		} else if (left_end_reached) {
+			if (right_level == 0) {
+				ret = changed_cb(left_path, right_path,
+						&right_key,
+						BTRFS_COMPARE_TREE_DELETED,
+						ctx);
+				if (ret < 0)
+					goto out;
+			}
+			advance_right = ADVANCE;
+			continue;
+		} else if (right_end_reached) {
+			if (left_level == 0) {
+				ret = changed_cb(left_path, right_path,
+						&left_key,
+						BTRFS_COMPARE_TREE_NEW,
+						ctx);
+				if (ret < 0)
+					goto out;
+			}
+			advance_left = ADVANCE;
+			continue;
+		}
+
+		if (left_level == 0 && right_level == 0) {
+			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
+			if (cmp < 0) {
+				ret = changed_cb(left_path, right_path,
+						&left_key,
+						BTRFS_COMPARE_TREE_NEW,
+						ctx);
+				if (ret < 0)
+					goto out;
+				advance_left = ADVANCE;
+			} else if (cmp > 0) {
+				ret = changed_cb(left_path, right_path,
+						&right_key,
+						BTRFS_COMPARE_TREE_DELETED,
+						ctx);
+				if (ret < 0)
+					goto out;
+				advance_right = ADVANCE;
+			} else {
+				enum btrfs_compare_tree_result result;
+
+				WARN_ON(!extent_buffer_uptodate(left_path->nodes[0]));
+				ret = tree_compare_item(left_path, right_path,
+							tmp_buf);
+				if (ret)
+					result = BTRFS_COMPARE_TREE_CHANGED;
+				else
+					result = BTRFS_COMPARE_TREE_SAME;
+				ret = changed_cb(left_path, right_path,
+						 &left_key, result, ctx);
+				if (ret < 0)
+					goto out;
+				advance_left = ADVANCE;
+				advance_right = ADVANCE;
+			}
+		} else if (left_level == right_level) {
+			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
+			if (cmp < 0) {
+				advance_left = ADVANCE;
+			} else if (cmp > 0) {
+				advance_right = ADVANCE;
+			} else {
+				left_blockptr = btrfs_node_blockptr(
+						left_path->nodes[left_level],
+						left_path->slots[left_level]);
+				right_blockptr = btrfs_node_blockptr(
+						right_path->nodes[right_level],
+						right_path->slots[right_level]);
+				left_gen = btrfs_node_ptr_generation(
+						left_path->nodes[left_level],
+						left_path->slots[left_level]);
+				right_gen = btrfs_node_ptr_generation(
+						right_path->nodes[right_level],
+						right_path->slots[right_level]);
+				if (left_blockptr == right_blockptr &&
+				    left_gen == right_gen) {
+					/*
+					 * As we're on a shared block, don't
+					 * allow to go deeper.
+					 */
+					advance_left = ADVANCE_ONLY_NEXT;
+					advance_right = ADVANCE_ONLY_NEXT;
+				} else {
+					advance_left = ADVANCE;
+					advance_right = ADVANCE;
+				}
+			}
+		} else if (left_level < right_level) {
+			advance_right = ADVANCE;
+		} else {
+			advance_left = ADVANCE;
+		}
+	}
+
+out:
+	btrfs_free_path(left_path);
+	btrfs_free_path(right_path);
+	kvfree(tmp_buf);
+	return ret;
+}
+
 static int send_subvol(struct send_ctx *sctx)
 {
 	int ret;
-- 
2.22.0

