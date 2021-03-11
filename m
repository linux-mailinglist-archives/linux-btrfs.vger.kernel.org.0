Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73FE3375C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhCKOb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233232AbhCKOb1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D6A64FEB;
        Thu, 11 Mar 2021 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473086;
        bh=fs7XbDjKmlMeVcP88GEblEANnQLT7XItSi6PZHAw7Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xxv1r2ZGZ1MaDgiMQG8/Y69j9G2wRATtoo2ezHZLBaCy/onIwjycGNp2dyelBqdtR
         9calCaaVOqCE3XiknwZ+PICsljD3+kThnXb9fwc7YUtzW2UXjjPDZ5pI4W8lRe9tLn
         Qz/FlGsLRO/DgLQHNUNNwuSg5bDYcVioIp4zvp4TgA3V5vSVJQWHZ4RCe1sMPNDYzu
         IsC0ZIy/B5AwdoOMFf5Ijd1Co+wIvJjikXHAxyG+u+fyUpVvmcDAQyVO/60yhMxdYB
         nO62lTShPo3SS0XCg0T6WG16ENrEuvSKGEP4Y4ICtAIfAKePh9cYj7rE7Bj40qYj8Y
         iU3m2DE98YOiA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/9] btrfs: move the tree mod log code into its own file
Date:   Thu, 11 Mar 2021 14:31:07 +0000
Message-Id: <ac64033d4afeff5c10c4993323e7c1a388304aff.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The tree modification log, which records modifications done to btrees, is
quite large and currently spread all over ctree.c, which is a huge file
already.

To make things better organized, move all that code into its own separate
source and header files. Functions and definitions that are used outside
of the module (mostly by ctree.c) are renamed so that they start with a
"btrfs_" prefix. Everything else remains unchanged.

This makes it easier to go over the tree modification log code everytime
I need to go read it to fix a bug.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/Makefile       |   2 +-
 fs/btrfs/backref.c      |  33 +-
 fs/btrfs/ctree.c        | 956 ++--------------------------------------
 fs/btrfs/ctree.h        |  17 -
 fs/btrfs/delayed-ref.c  |   9 +-
 fs/btrfs/qgroup.c       |   9 +-
 fs/btrfs/tree-mod-log.c | 889 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-mod-log.h |  52 +++
 8 files changed, 1006 insertions(+), 961 deletions(-)
 create mode 100644 fs/btrfs/tree-mod-log.c
 create mode 100644 fs/btrfs/tree-mod-log.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index b634c42115ea..fdba34b10a98 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -28,7 +28,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o
+	   subpage.o tree-mod-log.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f47c1528eb9a..117d423fdb93 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -14,6 +14,7 @@
 #include "delayed-ref.h"
 #include "locking.h"
 #include "misc.h"
+#include "tree-mod-log.h"
 
 /* Just an arbitrary number so we can be sure this happened */
 #define BACKREF_FOUND_SHARED 6
@@ -452,7 +453,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 	if (path->slots[0] >= btrfs_header_nritems(eb) ||
 	    is_shared_data_backref(preftrees, eb->start) ||
 	    ref->root_id != btrfs_header_owner(eb)) {
-		if (time_seq == SEQ_LAST)
+		if (time_seq == BTRFS_SEQ_LAST)
 			ret = btrfs_next_leaf(root, path);
 		else
 			ret = btrfs_next_old_leaf(root, path, time_seq);
@@ -476,7 +477,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 		if (slot == 0 &&
 		    (is_shared_data_backref(preftrees, eb->start) ||
 		     ref->root_id != btrfs_header_owner(eb))) {
-			if (time_seq == SEQ_LAST)
+			if (time_seq == BTRFS_SEQ_LAST)
 				ret = btrfs_next_leaf(root, path);
 			else
 				ret = btrfs_next_old_leaf(root, path, time_seq);
@@ -514,7 +515,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 			eie = NULL;
 		}
 next:
-		if (time_seq == SEQ_LAST)
+		if (time_seq == BTRFS_SEQ_LAST)
 			ret = btrfs_next_item(root, path);
 		else
 			ret = btrfs_next_old_item(root, path, time_seq);
@@ -574,7 +575,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 
 	if (path->search_commit_root)
 		root_level = btrfs_header_level(root->commit_root);
-	else if (time_seq == SEQ_LAST)
+	else if (time_seq == BTRFS_SEQ_LAST)
 		root_level = btrfs_header_level(root->node);
 	else
 		root_level = btrfs_old_root_level(root, time_seq);
@@ -605,7 +606,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	    search_key.offset >= LLONG_MAX)
 		search_key.offset = 0;
 	path->lowest_level = level;
-	if (time_seq == SEQ_LAST)
+	if (time_seq == BTRFS_SEQ_LAST)
 		ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	else
 		ret = btrfs_search_old_slot(root, &search_key, path, time_seq);
@@ -1147,8 +1148,8 @@ static int add_keyed_refs(struct btrfs_fs_info *fs_info,
  * indirect refs to their parent bytenr.
  * When roots are found, they're added to the roots list
  *
- * If time_seq is set to SEQ_LAST, it will not search delayed_refs, and behave
- * much like trans == NULL case, the difference only lies in it will not
+ * If time_seq is set to BTRFS_SEQ_LAST, it will not search delayed_refs, and
+ * behave much like trans == NULL case, the difference only lies in it will not
  * commit root.
  * The special case is for qgroup to search roots in commit_transaction().
  *
@@ -1199,7 +1200,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		path->skip_locking = 1;
 	}
 
-	if (time_seq == SEQ_LAST)
+	if (time_seq == BTRFS_SEQ_LAST)
 		path->skip_locking = 1;
 
 	/*
@@ -1217,9 +1218,9 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (trans && likely(trans->type != __TRANS_DUMMY) &&
-	    time_seq != SEQ_LAST) {
+	    time_seq != BTRFS_SEQ_LAST) {
 #else
-	if (trans && time_seq != SEQ_LAST) {
+	if (trans && time_seq != BTRFS_SEQ_LAST) {
 #endif
 		/*
 		 * look if there are updates for this ref queued and lock the
@@ -1527,7 +1528,7 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 	struct btrfs_trans_handle *trans;
 	struct ulist_iterator uiter;
 	struct ulist_node *node;
-	struct seq_list elem = SEQ_LIST_INIT(elem);
+	struct btrfs_seq_list elem = BTRFS_SEQ_LIST_INIT(elem);
 	int ret = 0;
 	struct share_check shared = {
 		.root_objectid = root->root_key.objectid,
@@ -1953,7 +1954,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 	struct ulist *roots = NULL;
 	struct ulist_node *ref_node = NULL;
 	struct ulist_node *root_node = NULL;
-	struct seq_list tree_mod_seq_elem = SEQ_LIST_INIT(tree_mod_seq_elem);
+	struct btrfs_seq_list seq_elem = BTRFS_SEQ_LIST_INIT(seq_elem);
 	struct ulist_iterator ref_uiter;
 	struct ulist_iterator root_uiter;
 
@@ -1971,12 +1972,12 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 	}
 
 	if (trans)
-		btrfs_get_tree_mod_seq(fs_info, &tree_mod_seq_elem);
+		btrfs_get_tree_mod_seq(fs_info, &seq_elem);
 	else
 		down_read(&fs_info->commit_root_sem);
 
 	ret = btrfs_find_all_leafs(trans, fs_info, extent_item_objectid,
-				   tree_mod_seq_elem.seq, &refs,
+				   seq_elem.seq, &refs,
 				   &extent_item_pos, ignore_offset);
 	if (ret)
 		goto out;
@@ -1984,7 +1985,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 	ULIST_ITER_INIT(&ref_uiter);
 	while (!ret && (ref_node = ulist_next(refs, &ref_uiter))) {
 		ret = btrfs_find_all_roots_safe(trans, fs_info, ref_node->val,
-						tree_mod_seq_elem.seq, &roots,
+						seq_elem.seq, &roots,
 						ignore_offset);
 		if (ret)
 			break;
@@ -2007,7 +2008,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 	free_leaf_list(refs);
 out:
 	if (trans) {
-		btrfs_put_tree_mod_seq(fs_info, &tree_mod_seq_elem);
+		btrfs_put_tree_mod_seq(fs_info, &seq_elem);
 		btrfs_end_transaction(trans);
 	} else {
 		up_read(&fs_info->commit_root_sem);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 19d7b81cee55..2c6e525b3458 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -14,6 +14,7 @@
 #include "locking.h"
 #include "volumes.h"
 #include "qgroup.h"
+#include "tree-mod-log.h"
 
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
@@ -233,597 +234,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-enum mod_log_op {
-	MOD_LOG_KEY_REPLACE,
-	MOD_LOG_KEY_ADD,
-	MOD_LOG_KEY_REMOVE,
-	MOD_LOG_KEY_REMOVE_WHILE_FREEING,
-	MOD_LOG_KEY_REMOVE_WHILE_MOVING,
-	MOD_LOG_MOVE_KEYS,
-	MOD_LOG_ROOT_REPLACE,
-};
-
-struct tree_mod_root {
-	u64 logical;
-	u8 level;
-};
-
-struct tree_mod_elem {
-	struct rb_node node;
-	u64 logical;
-	u64 seq;
-	enum mod_log_op op;
-
-	/* this is used for MOD_LOG_KEY_* and MOD_LOG_MOVE_KEYS operations */
-	int slot;
-
-	/* this is used for MOD_LOG_KEY* and MOD_LOG_ROOT_REPLACE */
-	u64 generation;
-
-	/* those are used for op == MOD_LOG_KEY_{REPLACE,REMOVE} */
-	struct btrfs_disk_key key;
-	u64 blockptr;
-
-	/* this is used for op == MOD_LOG_MOVE_KEYS */
-	struct {
-		int dst_slot;
-		int nr_items;
-	} move;
-
-	/* this is used for op == MOD_LOG_ROOT_REPLACE */
-	struct tree_mod_root old_root;
-};
-
-/*
- * Pull a new tree mod seq number for our operation.
- */
-static inline u64 btrfs_inc_tree_mod_seq(struct btrfs_fs_info *fs_info)
-{
-	return atomic64_inc_return(&fs_info->tree_mod_seq);
-}
-
-/*
- * This adds a new blocker to the tree mod log's blocker list if the @elem
- * passed does not already have a sequence number set. So when a caller expects
- * to record tree modifications, it should ensure to set elem->seq to zero
- * before calling btrfs_get_tree_mod_seq.
- * Returns a fresh, unused tree log modification sequence number, even if no new
- * blocker was added.
- */
-u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
-			   struct seq_list *elem)
-{
-	write_lock(&fs_info->tree_mod_log_lock);
-	if (!elem->seq) {
-		elem->seq = btrfs_inc_tree_mod_seq(fs_info);
-		list_add_tail(&elem->list, &fs_info->tree_mod_seq_list);
-	}
-	write_unlock(&fs_info->tree_mod_log_lock);
-
-	return elem->seq;
-}
-
-void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
-			    struct seq_list *elem)
-{
-	struct rb_root *tm_root;
-	struct rb_node *node;
-	struct rb_node *next;
-	struct tree_mod_elem *tm;
-	u64 min_seq = (u64)-1;
-	u64 seq_putting = elem->seq;
-
-	if (!seq_putting)
-		return;
-
-	write_lock(&fs_info->tree_mod_log_lock);
-	list_del(&elem->list);
-	elem->seq = 0;
-
-	if (!list_empty(&fs_info->tree_mod_seq_list)) {
-		struct seq_list *first;
-
-		first = list_first_entry(&fs_info->tree_mod_seq_list,
-					 struct seq_list, list);
-		if (seq_putting > first->seq) {
-			/*
-			 * Blocker with lower sequence number exists, we
-			 * cannot remove anything from the log.
-			 */
-			write_unlock(&fs_info->tree_mod_log_lock);
-			return;
-		}
-		min_seq = first->seq;
-	}
-
-	/*
-	 * anything that's lower than the lowest existing (read: blocked)
-	 * sequence number can be removed from the tree.
-	 */
-	tm_root = &fs_info->tree_mod_log;
-	for (node = rb_first(tm_root); node; node = next) {
-		next = rb_next(node);
-		tm = rb_entry(node, struct tree_mod_elem, node);
-		if (tm->seq >= min_seq)
-			continue;
-		rb_erase(node, tm_root);
-		kfree(tm);
-	}
-	write_unlock(&fs_info->tree_mod_log_lock);
-}
-
-/*
- * key order of the log:
- *       node/leaf start address -> sequence
- *
- * The 'start address' is the logical address of the *new* root node
- * for root replace operations, or the logical address of the affected
- * block for all other operations.
- */
-static noinline int
-__tree_mod_log_insert(struct btrfs_fs_info *fs_info, struct tree_mod_elem *tm)
-{
-	struct rb_root *tm_root;
-	struct rb_node **new;
-	struct rb_node *parent = NULL;
-	struct tree_mod_elem *cur;
-
-	lockdep_assert_held_write(&fs_info->tree_mod_log_lock);
-
-	tm->seq = btrfs_inc_tree_mod_seq(fs_info);
-
-	tm_root = &fs_info->tree_mod_log;
-	new = &tm_root->rb_node;
-	while (*new) {
-		cur = rb_entry(*new, struct tree_mod_elem, node);
-		parent = *new;
-		if (cur->logical < tm->logical)
-			new = &((*new)->rb_left);
-		else if (cur->logical > tm->logical)
-			new = &((*new)->rb_right);
-		else if (cur->seq < tm->seq)
-			new = &((*new)->rb_left);
-		else if (cur->seq > tm->seq)
-			new = &((*new)->rb_right);
-		else
-			return -EEXIST;
-	}
-
-	rb_link_node(&tm->node, parent, new);
-	rb_insert_color(&tm->node, tm_root);
-	return 0;
-}
-
-/*
- * Determines if logging can be omitted. Returns 1 if it can. Otherwise, it
- * returns zero with the tree_mod_log_lock acquired. The caller must hold
- * this until all tree mod log insertions are recorded in the rb tree and then
- * write unlock fs_info::tree_mod_log_lock.
- */
-static inline int tree_mod_dont_log(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb) {
-	smp_mb();
-	if (list_empty(&(fs_info)->tree_mod_seq_list))
-		return 1;
-	if (eb && btrfs_header_level(eb) == 0)
-		return 1;
-
-	write_lock(&fs_info->tree_mod_log_lock);
-	if (list_empty(&(fs_info)->tree_mod_seq_list)) {
-		write_unlock(&fs_info->tree_mod_log_lock);
-		return 1;
-	}
-
-	return 0;
-}
-
-/* Similar to tree_mod_dont_log, but doesn't acquire any locks. */
-static inline int tree_mod_need_log(const struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb)
-{
-	smp_mb();
-	if (list_empty(&(fs_info)->tree_mod_seq_list))
-		return 0;
-	if (eb && btrfs_header_level(eb) == 0)
-		return 0;
-
-	return 1;
-}
-
-static struct tree_mod_elem *
-alloc_tree_mod_elem(struct extent_buffer *eb, int slot,
-		    enum mod_log_op op, gfp_t flags)
-{
-	struct tree_mod_elem *tm;
-
-	tm = kzalloc(sizeof(*tm), flags);
-	if (!tm)
-		return NULL;
-
-	tm->logical = eb->start;
-	if (op != MOD_LOG_KEY_ADD) {
-		btrfs_node_key(eb, &tm->key, slot);
-		tm->blockptr = btrfs_node_blockptr(eb, slot);
-	}
-	tm->op = op;
-	tm->slot = slot;
-	tm->generation = btrfs_node_ptr_generation(eb, slot);
-	RB_CLEAR_NODE(&tm->node);
-
-	return tm;
-}
-
-static noinline int tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
-		enum mod_log_op op, gfp_t flags)
-{
-	struct tree_mod_elem *tm;
-	int ret;
-
-	if (!tree_mod_need_log(eb->fs_info, eb))
-		return 0;
-
-	tm = alloc_tree_mod_elem(eb, slot, op, flags);
-	if (!tm)
-		return -ENOMEM;
-
-	if (tree_mod_dont_log(eb->fs_info, eb)) {
-		kfree(tm);
-		return 0;
-	}
-
-	ret = __tree_mod_log_insert(eb->fs_info, tm);
-	write_unlock(&eb->fs_info->tree_mod_log_lock);
-	if (ret)
-		kfree(tm);
-
-	return ret;
-}
-
-static noinline int tree_mod_log_insert_move(struct extent_buffer *eb,
-		int dst_slot, int src_slot, int nr_items)
-{
-	struct tree_mod_elem *tm = NULL;
-	struct tree_mod_elem **tm_list = NULL;
-	int ret = 0;
-	int i;
-	int locked = 0;
-
-	if (!tree_mod_need_log(eb->fs_info, eb))
-		return 0;
-
-	tm_list = kcalloc(nr_items, sizeof(struct tree_mod_elem *), GFP_NOFS);
-	if (!tm_list)
-		return -ENOMEM;
-
-	tm = kzalloc(sizeof(*tm), GFP_NOFS);
-	if (!tm) {
-		ret = -ENOMEM;
-		goto free_tms;
-	}
-
-	tm->logical = eb->start;
-	tm->slot = src_slot;
-	tm->move.dst_slot = dst_slot;
-	tm->move.nr_items = nr_items;
-	tm->op = MOD_LOG_MOVE_KEYS;
-
-	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
-		tm_list[i] = alloc_tree_mod_elem(eb, i + dst_slot,
-		    MOD_LOG_KEY_REMOVE_WHILE_MOVING, GFP_NOFS);
-		if (!tm_list[i]) {
-			ret = -ENOMEM;
-			goto free_tms;
-		}
-	}
-
-	if (tree_mod_dont_log(eb->fs_info, eb))
-		goto free_tms;
-	locked = 1;
-
-	/*
-	 * When we override something during the move, we log these removals.
-	 * This can only happen when we move towards the beginning of the
-	 * buffer, i.e. dst_slot < src_slot.
-	 */
-	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
-		ret = __tree_mod_log_insert(eb->fs_info, tm_list[i]);
-		if (ret)
-			goto free_tms;
-	}
-
-	ret = __tree_mod_log_insert(eb->fs_info, tm);
-	if (ret)
-		goto free_tms;
-	write_unlock(&eb->fs_info->tree_mod_log_lock);
-	kfree(tm_list);
-
-	return 0;
-free_tms:
-	for (i = 0; i < nr_items; i++) {
-		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
-			rb_erase(&tm_list[i]->node, &eb->fs_info->tree_mod_log);
-		kfree(tm_list[i]);
-	}
-	if (locked)
-		write_unlock(&eb->fs_info->tree_mod_log_lock);
-	kfree(tm_list);
-	kfree(tm);
-
-	return ret;
-}
-
-static inline int
-__tree_mod_log_free_eb(struct btrfs_fs_info *fs_info,
-		       struct tree_mod_elem **tm_list,
-		       int nritems)
-{
-	int i, j;
-	int ret;
-
-	for (i = nritems - 1; i >= 0; i--) {
-		ret = __tree_mod_log_insert(fs_info, tm_list[i]);
-		if (ret) {
-			for (j = nritems - 1; j > i; j--)
-				rb_erase(&tm_list[j]->node,
-					 &fs_info->tree_mod_log);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static noinline int tree_mod_log_insert_root(struct extent_buffer *old_root,
-			 struct extent_buffer *new_root, int log_removal)
-{
-	struct btrfs_fs_info *fs_info = old_root->fs_info;
-	struct tree_mod_elem *tm = NULL;
-	struct tree_mod_elem **tm_list = NULL;
-	int nritems = 0;
-	int ret = 0;
-	int i;
-
-	if (!tree_mod_need_log(fs_info, NULL))
-		return 0;
-
-	if (log_removal && btrfs_header_level(old_root) > 0) {
-		nritems = btrfs_header_nritems(old_root);
-		tm_list = kcalloc(nritems, sizeof(struct tree_mod_elem *),
-				  GFP_NOFS);
-		if (!tm_list) {
-			ret = -ENOMEM;
-			goto free_tms;
-		}
-		for (i = 0; i < nritems; i++) {
-			tm_list[i] = alloc_tree_mod_elem(old_root, i,
-			    MOD_LOG_KEY_REMOVE_WHILE_FREEING, GFP_NOFS);
-			if (!tm_list[i]) {
-				ret = -ENOMEM;
-				goto free_tms;
-			}
-		}
-	}
-
-	tm = kzalloc(sizeof(*tm), GFP_NOFS);
-	if (!tm) {
-		ret = -ENOMEM;
-		goto free_tms;
-	}
-
-	tm->logical = new_root->start;
-	tm->old_root.logical = old_root->start;
-	tm->old_root.level = btrfs_header_level(old_root);
-	tm->generation = btrfs_header_generation(old_root);
-	tm->op = MOD_LOG_ROOT_REPLACE;
-
-	if (tree_mod_dont_log(fs_info, NULL))
-		goto free_tms;
-
-	if (tm_list)
-		ret = __tree_mod_log_free_eb(fs_info, tm_list, nritems);
-	if (!ret)
-		ret = __tree_mod_log_insert(fs_info, tm);
-
-	write_unlock(&fs_info->tree_mod_log_lock);
-	if (ret)
-		goto free_tms;
-	kfree(tm_list);
-
-	return ret;
-
-free_tms:
-	if (tm_list) {
-		for (i = 0; i < nritems; i++)
-			kfree(tm_list[i]);
-		kfree(tm_list);
-	}
-	kfree(tm);
-
-	return ret;
-}
-
-static struct tree_mod_elem *
-__tree_mod_log_search(struct btrfs_fs_info *fs_info, u64 start, u64 min_seq,
-		      int smallest)
-{
-	struct rb_root *tm_root;
-	struct rb_node *node;
-	struct tree_mod_elem *cur = NULL;
-	struct tree_mod_elem *found = NULL;
-
-	read_lock(&fs_info->tree_mod_log_lock);
-	tm_root = &fs_info->tree_mod_log;
-	node = tm_root->rb_node;
-	while (node) {
-		cur = rb_entry(node, struct tree_mod_elem, node);
-		if (cur->logical < start) {
-			node = node->rb_left;
-		} else if (cur->logical > start) {
-			node = node->rb_right;
-		} else if (cur->seq < min_seq) {
-			node = node->rb_left;
-		} else if (!smallest) {
-			/* we want the node with the highest seq */
-			if (found)
-				BUG_ON(found->seq > cur->seq);
-			found = cur;
-			node = node->rb_left;
-		} else if (cur->seq > min_seq) {
-			/* we want the node with the smallest seq */
-			if (found)
-				BUG_ON(found->seq < cur->seq);
-			found = cur;
-			node = node->rb_right;
-		} else {
-			found = cur;
-			break;
-		}
-	}
-	read_unlock(&fs_info->tree_mod_log_lock);
-
-	return found;
-}
-
-/*
- * this returns the element from the log with the smallest time sequence
- * value that's in the log (the oldest log item). any element with a time
- * sequence lower than min_seq will be ignored.
- */
-static struct tree_mod_elem *
-tree_mod_log_search_oldest(struct btrfs_fs_info *fs_info, u64 start,
-			   u64 min_seq)
-{
-	return __tree_mod_log_search(fs_info, start, min_seq, 1);
-}
-
-/*
- * this returns the element from the log with the largest time sequence
- * value that's in the log (the most recent log item). any element with
- * a time sequence lower than min_seq will be ignored.
- */
-static struct tree_mod_elem *
-tree_mod_log_search(struct btrfs_fs_info *fs_info, u64 start, u64 min_seq)
-{
-	return __tree_mod_log_search(fs_info, start, min_seq, 0);
-}
-
-static noinline int tree_mod_log_eb_copy(struct extent_buffer *dst,
-		     struct extent_buffer *src, unsigned long dst_offset,
-		     unsigned long src_offset, int nr_items)
-{
-	struct btrfs_fs_info *fs_info = dst->fs_info;
-	int ret = 0;
-	struct tree_mod_elem **tm_list = NULL;
-	struct tree_mod_elem **tm_list_add, **tm_list_rem;
-	int i;
-	int locked = 0;
-
-	if (!tree_mod_need_log(fs_info, NULL))
-		return 0;
-
-	if (btrfs_header_level(dst) == 0 && btrfs_header_level(src) == 0)
-		return 0;
-
-	tm_list = kcalloc(nr_items * 2, sizeof(struct tree_mod_elem *),
-			  GFP_NOFS);
-	if (!tm_list)
-		return -ENOMEM;
-
-	tm_list_add = tm_list;
-	tm_list_rem = tm_list + nr_items;
-	for (i = 0; i < nr_items; i++) {
-		tm_list_rem[i] = alloc_tree_mod_elem(src, i + src_offset,
-		    MOD_LOG_KEY_REMOVE, GFP_NOFS);
-		if (!tm_list_rem[i]) {
-			ret = -ENOMEM;
-			goto free_tms;
-		}
-
-		tm_list_add[i] = alloc_tree_mod_elem(dst, i + dst_offset,
-		    MOD_LOG_KEY_ADD, GFP_NOFS);
-		if (!tm_list_add[i]) {
-			ret = -ENOMEM;
-			goto free_tms;
-		}
-	}
-
-	if (tree_mod_dont_log(fs_info, NULL))
-		goto free_tms;
-	locked = 1;
-
-	for (i = 0; i < nr_items; i++) {
-		ret = __tree_mod_log_insert(fs_info, tm_list_rem[i]);
-		if (ret)
-			goto free_tms;
-		ret = __tree_mod_log_insert(fs_info, tm_list_add[i]);
-		if (ret)
-			goto free_tms;
-	}
-
-	write_unlock(&fs_info->tree_mod_log_lock);
-	kfree(tm_list);
-
-	return 0;
-
-free_tms:
-	for (i = 0; i < nr_items * 2; i++) {
-		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
-			rb_erase(&tm_list[i]->node, &fs_info->tree_mod_log);
-		kfree(tm_list[i]);
-	}
-	if (locked)
-		write_unlock(&fs_info->tree_mod_log_lock);
-	kfree(tm_list);
-
-	return ret;
-}
-
-static noinline int tree_mod_log_free_eb(struct extent_buffer *eb)
-{
-	struct tree_mod_elem **tm_list = NULL;
-	int nritems = 0;
-	int i;
-	int ret = 0;
-
-	if (btrfs_header_level(eb) == 0)
-		return 0;
-
-	if (!tree_mod_need_log(eb->fs_info, NULL))
-		return 0;
-
-	nritems = btrfs_header_nritems(eb);
-	tm_list = kcalloc(nritems, sizeof(struct tree_mod_elem *), GFP_NOFS);
-	if (!tm_list)
-		return -ENOMEM;
-
-	for (i = 0; i < nritems; i++) {
-		tm_list[i] = alloc_tree_mod_elem(eb, i,
-		    MOD_LOG_KEY_REMOVE_WHILE_FREEING, GFP_NOFS);
-		if (!tm_list[i]) {
-			ret = -ENOMEM;
-			goto free_tms;
-		}
-	}
-
-	if (tree_mod_dont_log(eb->fs_info, eb))
-		goto free_tms;
-
-	ret = __tree_mod_log_free_eb(eb->fs_info, tm_list, nritems);
-	write_unlock(&eb->fs_info->tree_mod_log_lock);
-	if (ret)
-		goto free_tms;
-	kfree(tm_list);
-
-	return 0;
-
-free_tms:
-	for (i = 0; i < nritems; i++)
-		kfree(tm_list[i]);
-	kfree(tm_list);
-
-	return ret;
-}
-
 /*
  * check if the tree block can be shared by multiple trees
  */
@@ -1090,7 +500,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 			parent_start = buf->start;
 
 		atomic_inc(&cow->refs);
-		ret = tree_mod_log_insert_root(root->node, cow, 1);
+		ret = btrfs_tree_mod_log_insert_root(root->node, cow, 1);
 		BUG_ON(ret < 0);
 		rcu_assign_pointer(root->node, cow);
 
@@ -1100,15 +510,15 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		add_root_to_dirty_list(root);
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
-		tree_mod_log_insert_key(parent, parent_slot,
-					MOD_LOG_KEY_REPLACE, GFP_NOFS);
+		btrfs_tree_mod_log_insert_key(parent, parent_slot,
+					      BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
 		btrfs_set_node_ptr_generation(parent, parent_slot,
 					      trans->transid);
 		btrfs_mark_buffer_dirty(parent);
 		if (last_ref) {
-			ret = tree_mod_log_free_eb(buf);
+			ret = btrfs_tree_mod_log_free_eb(buf);
 			if (ret) {
 				btrfs_tree_unlock(cow);
 				free_extent_buffer(cow);
@@ -1127,298 +537,6 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * returns the logical address of the oldest predecessor of the given root.
- * entries older than time_seq are ignored.
- */
-static struct tree_mod_elem *__tree_mod_log_oldest_root(
-		struct extent_buffer *eb_root, u64 time_seq)
-{
-	struct tree_mod_elem *tm;
-	struct tree_mod_elem *found = NULL;
-	u64 root_logical = eb_root->start;
-	int looped = 0;
-
-	if (!time_seq)
-		return NULL;
-
-	/*
-	 * the very last operation that's logged for a root is the
-	 * replacement operation (if it is replaced at all). this has
-	 * the logical address of the *new* root, making it the very
-	 * first operation that's logged for this root.
-	 */
-	while (1) {
-		tm = tree_mod_log_search_oldest(eb_root->fs_info, root_logical,
-						time_seq);
-		if (!looped && !tm)
-			return NULL;
-		/*
-		 * if there are no tree operation for the oldest root, we simply
-		 * return it. this should only happen if that (old) root is at
-		 * level 0.
-		 */
-		if (!tm)
-			break;
-
-		/*
-		 * if there's an operation that's not a root replacement, we
-		 * found the oldest version of our root. normally, we'll find a
-		 * MOD_LOG_KEY_REMOVE_WHILE_FREEING operation here.
-		 */
-		if (tm->op != MOD_LOG_ROOT_REPLACE)
-			break;
-
-		found = tm;
-		root_logical = tm->old_root.logical;
-		looped = 1;
-	}
-
-	/* if there's no old root to return, return what we found instead */
-	if (!found)
-		found = tm;
-
-	return found;
-}
-
-/*
- * tm is a pointer to the first operation to rewind within eb. then, all
- * previous operations will be rewound (until we reach something older than
- * time_seq).
- */
-static void
-__tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct extent_buffer *eb,
-		      u64 time_seq, struct tree_mod_elem *first_tm)
-{
-	u32 n;
-	struct rb_node *next;
-	struct tree_mod_elem *tm = first_tm;
-	unsigned long o_dst;
-	unsigned long o_src;
-	unsigned long p_size = sizeof(struct btrfs_key_ptr);
-
-	n = btrfs_header_nritems(eb);
-	read_lock(&fs_info->tree_mod_log_lock);
-	while (tm && tm->seq >= time_seq) {
-		/*
-		 * all the operations are recorded with the operator used for
-		 * the modification. as we're going backwards, we do the
-		 * opposite of each operation here.
-		 */
-		switch (tm->op) {
-		case MOD_LOG_KEY_REMOVE_WHILE_FREEING:
-			BUG_ON(tm->slot < n);
-			fallthrough;
-		case MOD_LOG_KEY_REMOVE_WHILE_MOVING:
-		case MOD_LOG_KEY_REMOVE:
-			btrfs_set_node_key(eb, &tm->key, tm->slot);
-			btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
-			btrfs_set_node_ptr_generation(eb, tm->slot,
-						      tm->generation);
-			n++;
-			break;
-		case MOD_LOG_KEY_REPLACE:
-			BUG_ON(tm->slot >= n);
-			btrfs_set_node_key(eb, &tm->key, tm->slot);
-			btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
-			btrfs_set_node_ptr_generation(eb, tm->slot,
-						      tm->generation);
-			break;
-		case MOD_LOG_KEY_ADD:
-			/* if a move operation is needed it's in the log */
-			n--;
-			break;
-		case MOD_LOG_MOVE_KEYS:
-			o_dst = btrfs_node_key_ptr_offset(tm->slot);
-			o_src = btrfs_node_key_ptr_offset(tm->move.dst_slot);
-			memmove_extent_buffer(eb, o_dst, o_src,
-					      tm->move.nr_items * p_size);
-			break;
-		case MOD_LOG_ROOT_REPLACE:
-			/*
-			 * this operation is special. for roots, this must be
-			 * handled explicitly before rewinding.
-			 * for non-roots, this operation may exist if the node
-			 * was a root: root A -> child B; then A gets empty and
-			 * B is promoted to the new root. in the mod log, we'll
-			 * have a root-replace operation for B, a tree block
-			 * that is no root. we simply ignore that operation.
-			 */
-			break;
-		}
-		next = rb_next(&tm->node);
-		if (!next)
-			break;
-		tm = rb_entry(next, struct tree_mod_elem, node);
-		if (tm->logical != first_tm->logical)
-			break;
-	}
-	read_unlock(&fs_info->tree_mod_log_lock);
-	btrfs_set_header_nritems(eb, n);
-}
-
-/*
- * Called with eb read locked. If the buffer cannot be rewound, the same buffer
- * is returned. If rewind operations happen, a fresh buffer is returned. The
- * returned buffer is always read-locked. If the returned buffer is not the
- * input buffer, the lock on the input buffer is released and the input buffer
- * is freed (its refcount is decremented).
- */
-static struct extent_buffer *
-tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
-		    struct extent_buffer *eb, u64 time_seq)
-{
-	struct extent_buffer *eb_rewin;
-	struct tree_mod_elem *tm;
-
-	if (!time_seq)
-		return eb;
-
-	if (btrfs_header_level(eb) == 0)
-		return eb;
-
-	tm = tree_mod_log_search(fs_info, eb->start, time_seq);
-	if (!tm)
-		return eb;
-
-	if (tm->op == MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
-		BUG_ON(tm->slot != 0);
-		eb_rewin = alloc_dummy_extent_buffer(fs_info, eb->start);
-		if (!eb_rewin) {
-			btrfs_tree_read_unlock(eb);
-			free_extent_buffer(eb);
-			return NULL;
-		}
-		btrfs_set_header_bytenr(eb_rewin, eb->start);
-		btrfs_set_header_backref_rev(eb_rewin,
-					     btrfs_header_backref_rev(eb));
-		btrfs_set_header_owner(eb_rewin, btrfs_header_owner(eb));
-		btrfs_set_header_level(eb_rewin, btrfs_header_level(eb));
-	} else {
-		eb_rewin = btrfs_clone_extent_buffer(eb);
-		if (!eb_rewin) {
-			btrfs_tree_read_unlock(eb);
-			free_extent_buffer(eb);
-			return NULL;
-		}
-	}
-
-	btrfs_tree_read_unlock(eb);
-	free_extent_buffer(eb);
-
-	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
-				       eb_rewin, btrfs_header_level(eb_rewin));
-	btrfs_tree_read_lock(eb_rewin);
-	__tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
-	WARN_ON(btrfs_header_nritems(eb_rewin) >
-		BTRFS_NODEPTRS_PER_BLOCK(fs_info));
-
-	return eb_rewin;
-}
-
-/*
- * get_old_root() rewinds the state of @root's root node to the given @time_seq
- * value. If there are no changes, the current root->root_node is returned. If
- * anything changed in between, there's a fresh buffer allocated on which the
- * rewind operations are done. In any case, the returned buffer is read locked.
- * Returns NULL on error (with no locks held).
- */
-static inline struct extent_buffer *
-get_old_root(struct btrfs_root *root, u64 time_seq)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct tree_mod_elem *tm;
-	struct extent_buffer *eb = NULL;
-	struct extent_buffer *eb_root;
-	u64 eb_root_owner = 0;
-	struct extent_buffer *old;
-	struct tree_mod_root *old_root = NULL;
-	u64 old_generation = 0;
-	u64 logical;
-	int level;
-
-	eb_root = btrfs_read_lock_root_node(root);
-	tm = __tree_mod_log_oldest_root(eb_root, time_seq);
-	if (!tm)
-		return eb_root;
-
-	if (tm->op == MOD_LOG_ROOT_REPLACE) {
-		old_root = &tm->old_root;
-		old_generation = tm->generation;
-		logical = old_root->logical;
-		level = old_root->level;
-	} else {
-		logical = eb_root->start;
-		level = btrfs_header_level(eb_root);
-	}
-
-	tm = tree_mod_log_search(fs_info, logical, time_seq);
-	if (old_root && tm && tm->op != MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
-		btrfs_tree_read_unlock(eb_root);
-		free_extent_buffer(eb_root);
-		old = read_tree_block(fs_info, logical, root->root_key.objectid,
-				      0, level, NULL);
-		if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old))) {
-			if (!IS_ERR(old))
-				free_extent_buffer(old);
-			btrfs_warn(fs_info,
-				   "failed to read tree block %llu from get_old_root",
-				   logical);
-		} else {
-			btrfs_tree_read_lock(old);
-			eb = btrfs_clone_extent_buffer(old);
-			btrfs_tree_read_unlock(old);
-			free_extent_buffer(old);
-		}
-	} else if (old_root) {
-		eb_root_owner = btrfs_header_owner(eb_root);
-		btrfs_tree_read_unlock(eb_root);
-		free_extent_buffer(eb_root);
-		eb = alloc_dummy_extent_buffer(fs_info, logical);
-	} else {
-		eb = btrfs_clone_extent_buffer(eb_root);
-		btrfs_tree_read_unlock(eb_root);
-		free_extent_buffer(eb_root);
-	}
-
-	if (!eb)
-		return NULL;
-	if (old_root) {
-		btrfs_set_header_bytenr(eb, eb->start);
-		btrfs_set_header_backref_rev(eb, BTRFS_MIXED_BACKREF_REV);
-		btrfs_set_header_owner(eb, eb_root_owner);
-		btrfs_set_header_level(eb, old_root->level);
-		btrfs_set_header_generation(eb, old_generation);
-	}
-	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb), eb,
-				       btrfs_header_level(eb));
-	btrfs_tree_read_lock(eb);
-	if (tm)
-		__tree_mod_log_rewind(fs_info, eb, time_seq, tm);
-	else
-		WARN_ON(btrfs_header_level(eb) != 0);
-	WARN_ON(btrfs_header_nritems(eb) > BTRFS_NODEPTRS_PER_BLOCK(fs_info));
-
-	return eb;
-}
-
-int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq)
-{
-	struct tree_mod_elem *tm;
-	int level;
-	struct extent_buffer *eb_root = btrfs_root_node(root);
-
-	tm = __tree_mod_log_oldest_root(eb_root, time_seq);
-	if (tm && tm->op == MOD_LOG_ROOT_REPLACE) {
-		level = tm->old_root.level;
-	} else {
-		level = btrfs_header_level(eb_root);
-	}
-	free_extent_buffer(eb_root);
-
-	return level;
-}
-
 static inline int should_cow_block(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct extent_buffer *buf)
@@ -1840,7 +958,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto enospc;
 		}
 
-		ret = tree_mod_log_insert_root(root->node, child, 1);
+		ret = btrfs_tree_mod_log_insert_root(root->node, child, 1);
 		BUG_ON(ret < 0);
 		rcu_assign_pointer(root->node, child);
 
@@ -1920,8 +1038,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		} else {
 			struct btrfs_disk_key right_key;
 			btrfs_node_key(right, &right_key, 0);
-			ret = tree_mod_log_insert_key(parent, pslot + 1,
-					MOD_LOG_KEY_REPLACE, GFP_NOFS);
+			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
+					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
 			BUG_ON(ret < 0);
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
@@ -1966,8 +1084,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		/* update the parent key to reflect our changes */
 		struct btrfs_disk_key mid_key;
 		btrfs_node_key(mid, &mid_key, 0);
-		ret = tree_mod_log_insert_key(parent, pslot,
-				MOD_LOG_KEY_REPLACE, GFP_NOFS);
+		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
+				BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
 		BUG_ON(ret < 0);
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
@@ -2068,8 +1186,8 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			struct btrfs_disk_key disk_key;
 			orig_slot += left_nr;
 			btrfs_node_key(mid, &disk_key, 0);
-			ret = tree_mod_log_insert_key(parent, pslot,
-					MOD_LOG_KEY_REPLACE, GFP_NOFS);
+			ret = btrfs_tree_mod_log_insert_key(parent, pslot,
+					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
 			BUG_ON(ret < 0);
 			btrfs_set_node_key(parent, &disk_key, pslot);
 			btrfs_mark_buffer_dirty(parent);
@@ -2122,8 +1240,8 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			struct btrfs_disk_key disk_key;
 
 			btrfs_node_key(right, &disk_key, 0);
-			ret = tree_mod_log_insert_key(parent, pslot + 1,
-					MOD_LOG_KEY_REPLACE, GFP_NOFS);
+			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
+					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
 			BUG_ON(ret < 0);
 			btrfs_set_node_key(parent, &disk_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
@@ -2881,7 +1999,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	}
 
 again:
-	b = get_old_root(root, time_seq);
+	b = btrfs_get_old_root(root, time_seq);
 	if (!b) {
 		ret = -EIO;
 		goto done;
@@ -2936,7 +2054,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 
 		level = btrfs_header_level(b);
 		btrfs_tree_read_lock(b);
-		b = tree_mod_log_rewind(fs_info, p, b, time_seq);
+		b = btrfs_tree_mod_log_rewind(fs_info, p, b, time_seq);
 		if (!b) {
 			ret = -ENOMEM;
 			goto done;
@@ -3050,8 +2168,8 @@ static void fixup_low_keys(struct btrfs_path *path,
 		if (!path->nodes[i])
 			break;
 		t = path->nodes[i];
-		ret = tree_mod_log_insert_key(t, tslot, MOD_LOG_KEY_REPLACE,
-				GFP_ATOMIC);
+		ret = btrfs_tree_mod_log_insert_key(t, tslot,
+				BTRFS_MOD_LOG_KEY_REPLACE, GFP_ATOMIC);
 		BUG_ON(ret < 0);
 		btrfs_set_node_key(t, key, tslot);
 		btrfs_mark_buffer_dirty(path->nodes[i]);
@@ -3214,7 +2332,7 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-	ret = tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
+	ret = btrfs_tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -3226,8 +2344,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 
 	if (push_items < src_nritems) {
 		/*
-		 * Don't call tree_mod_log_insert_move here, key removal was
-		 * already fully logged by tree_mod_log_eb_copy above.
+		 * Don't call btrfs_tree_mod_log_insert_move() here, key removal
+		 * was already fully logged by btrfs_tree_mod_log_eb_copy() above.
 		 */
 		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(0),
 				      btrfs_node_key_ptr_offset(push_items),
@@ -3288,15 +2406,15 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-	ret = tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
+	ret = btrfs_tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
 	BUG_ON(ret < 0);
 	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
 				      btrfs_node_key_ptr_offset(0),
 				      (dst_nritems) *
 				      sizeof(struct btrfs_key_ptr));
 
-	ret = tree_mod_log_eb_copy(dst, src, 0, src_nritems - push_items,
-				   push_items);
+	ret = btrfs_tree_mod_log_eb_copy(dst, src, 0, src_nritems - push_items,
+					 push_items);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -3362,7 +2480,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(c);
 
 	old = root->node;
-	ret = tree_mod_log_insert_root(root->node, c, 0);
+	ret = btrfs_tree_mod_log_insert_root(root->node, c, 0);
 	BUG_ON(ret < 0);
 	rcu_assign_pointer(root->node, c);
 
@@ -3401,8 +2519,8 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 	BUG_ON(nritems == BTRFS_NODEPTRS_PER_BLOCK(trans->fs_info));
 	if (slot != nritems) {
 		if (level) {
-			ret = tree_mod_log_insert_move(lower, slot + 1, slot,
-					nritems - slot);
+			ret = btrfs_tree_mod_log_insert_move(lower, slot + 1,
+					slot, nritems - slot);
 			BUG_ON(ret < 0);
 		}
 		memmove_extent_buffer(lower,
@@ -3411,8 +2529,8 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 			      (nritems - slot) * sizeof(struct btrfs_key_ptr));
 	}
 	if (level) {
-		ret = tree_mod_log_insert_key(lower, slot, MOD_LOG_KEY_ADD,
-				GFP_NOFS);
+		ret = btrfs_tree_mod_log_insert_key(lower, slot,
+					    BTRFS_MOD_LOG_KEY_ADD, GFP_NOFS);
 		BUG_ON(ret < 0);
 	}
 	btrfs_set_node_key(lower, key, slot);
@@ -3453,9 +2571,9 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 		 * tree mod log: We don't log_removal old root in
 		 * insert_new_root, because that root buffer will be kept as a
 		 * normal node. We are going to log removal of half of the
-		 * elements below with tree_mod_log_eb_copy. We're holding a
-		 * tree lock on the buffer, which is why we cannot race with
-		 * other tree_mod_log users.
+		 * elements below with btrfs_tree_mod_log_eb_copy(). We're
+		 * holding a tree lock on the buffer, which is why we cannot
+		 * race with other tree_mod_log users.
 		 */
 		ret = insert_new_root(trans, root, path, level + 1);
 		if (ret)
@@ -3482,7 +2600,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	root_add_used(root, fs_info->nodesize);
 	ASSERT(btrfs_header_level(c) == level);
 
-	ret = tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
+	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -4864,8 +3982,8 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 	nritems = btrfs_header_nritems(parent);
 	if (slot != nritems - 1) {
 		if (level) {
-			ret = tree_mod_log_insert_move(parent, slot, slot + 1,
-					nritems - slot - 1);
+			ret = btrfs_tree_mod_log_insert_move(parent, slot,
+					slot + 1, nritems - slot - 1);
 			BUG_ON(ret < 0);
 		}
 		memmove_extent_buffer(parent,
@@ -4874,8 +3992,8 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 			      sizeof(struct btrfs_key_ptr) *
 			      (nritems - slot - 1));
 	} else if (level) {
-		ret = tree_mod_log_insert_key(parent, slot, MOD_LOG_KEY_REMOVE,
-				GFP_NOFS);
+		ret = btrfs_tree_mod_log_insert_key(parent, slot,
+				BTRFS_MOD_LOG_KEY_REMOVE, GFP_NOFS);
 		BUG_ON(ret < 0);
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ae8901aec4f1..50208673bd55 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -500,16 +500,6 @@ struct btrfs_discard_ctl {
 	atomic64_t discard_bytes_saved;
 };
 
-/* delayed seq elem */
-struct seq_list {
-	struct list_head list;
-	u64 seq;
-};
-
-#define SEQ_LIST_INIT(name)	{ .list = LIST_HEAD_INIT((name).list), .seq = 0 }
-
-#define SEQ_LAST	((u64)-1)
-
 enum btrfs_orphan_cleanup_state {
 	ORPHAN_CLEANUP_STARTED	= 1,
 	ORPHAN_CLEANUP_DONE	= 2,
@@ -2946,13 +2936,6 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
 	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
 }
 
-/* tree mod log functions from ctree.c */
-u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
-			   struct seq_list *elem);
-void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
-			    struct seq_list *elem);
-int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq);
-
 /* root-item.c */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 63be7d01a9a3..d87472a68bf4 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -11,6 +11,7 @@
 #include "transaction.h"
 #include "qgroup.h"
 #include "space-info.h"
+#include "tree-mod-log.h"
 
 struct kmem_cache *btrfs_delayed_ref_head_cachep;
 struct kmem_cache *btrfs_delayed_tree_ref_cachep;
@@ -496,10 +497,10 @@ void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
 
 	read_lock(&fs_info->tree_mod_log_lock);
 	if (!list_empty(&fs_info->tree_mod_seq_list)) {
-		struct seq_list *elem;
+		struct btrfs_seq_list *elem;
 
 		elem = list_first_entry(&fs_info->tree_mod_seq_list,
-					struct seq_list, list);
+					struct btrfs_seq_list, list);
 		seq = elem->seq;
 	}
 	read_unlock(&fs_info->tree_mod_log_lock);
@@ -517,13 +518,13 @@ void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
 
 int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq)
 {
-	struct seq_list *elem;
+	struct btrfs_seq_list *elem;
 	int ret = 0;
 
 	read_lock(&fs_info->tree_mod_log_lock);
 	if (!list_empty(&fs_info->tree_mod_seq_list)) {
 		elem = list_first_entry(&fs_info->tree_mod_seq_list,
-					struct seq_list, list);
+					struct btrfs_seq_list, list);
 		if (seq >= elem->seq) {
 			btrfs_debug(fs_info,
 				"holding back delayed_ref %#x.%x, lowest is %#x.%x",
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1b7d3cadc39e..9d8d1ac86962 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -23,6 +23,7 @@
 #include "qgroup.h"
 #include "block-group.h"
 #include "sysfs.h"
+#include "tree-mod-log.h"
 
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
@@ -2631,12 +2632,12 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 					record->data_rsv,
 					BTRFS_QGROUP_RSV_DATA);
 			/*
-			 * Use SEQ_LAST as time_seq to do special search, which
-			 * doesn't lock tree or delayed_refs and search current
-			 * root. It's safe inside commit_transaction().
+			 * Use BTRFS_SEQ_LAST as time_seq to do special search,
+			 * which doesn't lock tree or delayed_refs and search
+			 * current root. It's safe inside commit_transaction().
 			 */
 			ret = btrfs_find_all_roots(trans, fs_info,
-				record->bytenr, SEQ_LAST, &new_roots, false);
+				record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
 			if (ret < 0)
 				goto cleanup;
 			if (qgroup_to_skip) {
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
new file mode 100644
index 000000000000..fc7eb33ec383
--- /dev/null
+++ b/fs/btrfs/tree-mod-log.c
@@ -0,0 +1,889 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "tree-mod-log.h"
+#include "disk-io.h"
+
+struct tree_mod_root {
+	u64 logical;
+	u8 level;
+};
+
+struct tree_mod_elem {
+	struct rb_node node;
+	u64 logical;
+	u64 seq;
+	enum btrfs_mod_log_op op;
+
+	/*
+	 * This is used for BTRFS_MOD_LOG_KEY_* and BTRFS_MOD_LOG_MOVE_KEYS
+	 * operations.
+	 */
+	int slot;
+
+	/* This is used for BTRFS_MOD_LOG_KEY* and BTRFS_MOD_LOG_ROOT_REPLACE. */
+	u64 generation;
+
+	/* Those are used for op == BTRFS_MOD_LOG_KEY_{REPLACE,REMOVE}. */
+	struct btrfs_disk_key key;
+	u64 blockptr;
+
+	/* This is used for op == BTRFS_MOD_LOG_MOVE_KEYS. */
+	struct {
+		int dst_slot;
+		int nr_items;
+	} move;
+
+	/* This is used for op == BTRFS_MOD_LOG_ROOT_REPLACE. */
+	struct tree_mod_root old_root;
+};
+
+/*
+ * Pull a new tree mod seq number for our operation.
+ */
+static inline u64 btrfs_inc_tree_mod_seq(struct btrfs_fs_info *fs_info)
+{
+	return atomic64_inc_return(&fs_info->tree_mod_seq);
+}
+
+/*
+ * This adds a new blocker to the tree mod log's blocker list if the @elem
+ * passed does not already have a sequence number set. So when a caller expects
+ * to record tree modifications, it should ensure to set elem->seq to zero
+ * before calling btrfs_get_tree_mod_seq.
+ * Returns a fresh, unused tree log modification sequence number, even if no new
+ * blocker was added.
+ */
+u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
+			   struct btrfs_seq_list *elem)
+{
+	write_lock(&fs_info->tree_mod_log_lock);
+	if (!elem->seq) {
+		elem->seq = btrfs_inc_tree_mod_seq(fs_info);
+		list_add_tail(&elem->list, &fs_info->tree_mod_seq_list);
+	}
+	write_unlock(&fs_info->tree_mod_log_lock);
+
+	return elem->seq;
+}
+
+void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
+			    struct btrfs_seq_list *elem)
+{
+	struct rb_root *tm_root;
+	struct rb_node *node;
+	struct rb_node *next;
+	struct tree_mod_elem *tm;
+	u64 min_seq = BTRFS_SEQ_LAST;
+	u64 seq_putting = elem->seq;
+
+	if (!seq_putting)
+		return;
+
+	write_lock(&fs_info->tree_mod_log_lock);
+	list_del(&elem->list);
+	elem->seq = 0;
+
+	if (!list_empty(&fs_info->tree_mod_seq_list)) {
+		struct btrfs_seq_list *first;
+
+		first = list_first_entry(&fs_info->tree_mod_seq_list,
+					 struct btrfs_seq_list, list);
+		if (seq_putting > first->seq) {
+			/*
+			 * Blocker with lower sequence number exists, we
+			 * cannot remove anything from the log.
+			 */
+			write_unlock(&fs_info->tree_mod_log_lock);
+			return;
+		}
+		min_seq = first->seq;
+	}
+
+	/*
+	 * anything that's lower than the lowest existing (read: blocked)
+	 * sequence number can be removed from the tree.
+	 */
+	tm_root = &fs_info->tree_mod_log;
+	for (node = rb_first(tm_root); node; node = next) {
+		next = rb_next(node);
+		tm = rb_entry(node, struct tree_mod_elem, node);
+		if (tm->seq >= min_seq)
+			continue;
+		rb_erase(node, tm_root);
+		kfree(tm);
+	}
+	write_unlock(&fs_info->tree_mod_log_lock);
+}
+
+/*
+ * key order of the log:
+ *       node/leaf start address -> sequence
+ *
+ * The 'start address' is the logical address of the *new* root node
+ * for root replace operations, or the logical address of the affected
+ * block for all other operations.
+ */
+static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
+					struct tree_mod_elem *tm)
+{
+	struct rb_root *tm_root;
+	struct rb_node **new;
+	struct rb_node *parent = NULL;
+	struct tree_mod_elem *cur;
+
+	lockdep_assert_held_write(&fs_info->tree_mod_log_lock);
+
+	tm->seq = btrfs_inc_tree_mod_seq(fs_info);
+
+	tm_root = &fs_info->tree_mod_log;
+	new = &tm_root->rb_node;
+	while (*new) {
+		cur = rb_entry(*new, struct tree_mod_elem, node);
+		parent = *new;
+		if (cur->logical < tm->logical)
+			new = &((*new)->rb_left);
+		else if (cur->logical > tm->logical)
+			new = &((*new)->rb_right);
+		else if (cur->seq < tm->seq)
+			new = &((*new)->rb_left);
+		else if (cur->seq > tm->seq)
+			new = &((*new)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&tm->node, parent, new);
+	rb_insert_color(&tm->node, tm_root);
+	return 0;
+}
+
+/*
+ * Determines if logging can be omitted. Returns 1 if it can. Otherwise, it
+ * returns zero with the tree_mod_log_lock acquired. The caller must hold
+ * this until all tree mod log insertions are recorded in the rb tree and then
+ * write unlock fs_info::tree_mod_log_lock.
+ */
+static inline int tree_mod_dont_log(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb)
+{
+	smp_mb();
+	if (list_empty(&(fs_info)->tree_mod_seq_list))
+		return 1;
+	if (eb && btrfs_header_level(eb) == 0)
+		return 1;
+
+	write_lock(&fs_info->tree_mod_log_lock);
+	if (list_empty(&(fs_info)->tree_mod_seq_list)) {
+		write_unlock(&fs_info->tree_mod_log_lock);
+		return 1;
+	}
+
+	return 0;
+}
+
+/* Similar to tree_mod_dont_log, but doesn't acquire any locks. */
+static inline int tree_mod_need_log(const struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb)
+{
+	smp_mb();
+	if (list_empty(&(fs_info)->tree_mod_seq_list))
+		return 0;
+	if (eb && btrfs_header_level(eb) == 0)
+		return 0;
+
+	return 1;
+}
+
+static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
+						 int slot,
+						 enum btrfs_mod_log_op op,
+						 gfp_t flags)
+{
+	struct tree_mod_elem *tm;
+
+	tm = kzalloc(sizeof(*tm), flags);
+	if (!tm)
+		return NULL;
+
+	tm->logical = eb->start;
+	if (op != BTRFS_MOD_LOG_KEY_ADD) {
+		btrfs_node_key(eb, &tm->key, slot);
+		tm->blockptr = btrfs_node_blockptr(eb, slot);
+	}
+	tm->op = op;
+	tm->slot = slot;
+	tm->generation = btrfs_node_ptr_generation(eb, slot);
+	RB_CLEAR_NODE(&tm->node);
+
+	return tm;
+}
+
+int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+				  enum btrfs_mod_log_op op, gfp_t flags)
+{
+	struct tree_mod_elem *tm;
+	int ret;
+
+	if (!tree_mod_need_log(eb->fs_info, eb))
+		return 0;
+
+	tm = alloc_tree_mod_elem(eb, slot, op, flags);
+	if (!tm)
+		return -ENOMEM;
+
+	if (tree_mod_dont_log(eb->fs_info, eb)) {
+		kfree(tm);
+		return 0;
+	}
+
+	ret = tree_mod_log_insert(eb->fs_info, tm);
+	write_unlock(&eb->fs_info->tree_mod_log_lock);
+	if (ret)
+		kfree(tm);
+
+	return ret;
+}
+
+int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+				   int dst_slot, int src_slot,
+				   int nr_items)
+{
+	struct tree_mod_elem *tm = NULL;
+	struct tree_mod_elem **tm_list = NULL;
+	int ret = 0;
+	int i;
+	int locked = 0;
+
+	if (!tree_mod_need_log(eb->fs_info, eb))
+		return 0;
+
+	tm_list = kcalloc(nr_items, sizeof(struct tree_mod_elem *), GFP_NOFS);
+	if (!tm_list)
+		return -ENOMEM;
+
+	tm = kzalloc(sizeof(*tm), GFP_NOFS);
+	if (!tm) {
+		ret = -ENOMEM;
+		goto free_tms;
+	}
+
+	tm->logical = eb->start;
+	tm->slot = src_slot;
+	tm->move.dst_slot = dst_slot;
+	tm->move.nr_items = nr_items;
+	tm->op = BTRFS_MOD_LOG_MOVE_KEYS;
+
+	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
+		tm_list[i] = alloc_tree_mod_elem(eb, i + dst_slot,
+		    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING, GFP_NOFS);
+		if (!tm_list[i]) {
+			ret = -ENOMEM;
+			goto free_tms;
+		}
+	}
+
+	if (tree_mod_dont_log(eb->fs_info, eb))
+		goto free_tms;
+	locked = 1;
+
+	/*
+	 * When we override something during the move, we log these removals.
+	 * This can only happen when we move towards the beginning of the
+	 * buffer, i.e. dst_slot < src_slot.
+	 */
+	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
+		ret = tree_mod_log_insert(eb->fs_info, tm_list[i]);
+		if (ret)
+			goto free_tms;
+	}
+
+	ret = tree_mod_log_insert(eb->fs_info, tm);
+	if (ret)
+		goto free_tms;
+	write_unlock(&eb->fs_info->tree_mod_log_lock);
+	kfree(tm_list);
+
+	return 0;
+free_tms:
+	for (i = 0; i < nr_items; i++) {
+		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
+			rb_erase(&tm_list[i]->node, &eb->fs_info->tree_mod_log);
+		kfree(tm_list[i]);
+	}
+	if (locked)
+		write_unlock(&eb->fs_info->tree_mod_log_lock);
+	kfree(tm_list);
+	kfree(tm);
+
+	return ret;
+}
+
+static inline int tree_mod_log_free_eb(struct btrfs_fs_info *fs_info,
+				       struct tree_mod_elem **tm_list,
+				       int nritems)
+{
+	int i, j;
+	int ret;
+
+	for (i = nritems - 1; i >= 0; i--) {
+		ret = tree_mod_log_insert(fs_info, tm_list[i]);
+		if (ret) {
+			for (j = nritems - 1; j > i; j--)
+				rb_erase(&tm_list[j]->node,
+					 &fs_info->tree_mod_log);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
+				   struct extent_buffer *new_root,
+				   int log_removal)
+{
+	struct btrfs_fs_info *fs_info = old_root->fs_info;
+	struct tree_mod_elem *tm = NULL;
+	struct tree_mod_elem **tm_list = NULL;
+	int nritems = 0;
+	int ret = 0;
+	int i;
+
+	if (!tree_mod_need_log(fs_info, NULL))
+		return 0;
+
+	if (log_removal && btrfs_header_level(old_root) > 0) {
+		nritems = btrfs_header_nritems(old_root);
+		tm_list = kcalloc(nritems, sizeof(struct tree_mod_elem *),
+				  GFP_NOFS);
+		if (!tm_list) {
+			ret = -ENOMEM;
+			goto free_tms;
+		}
+		for (i = 0; i < nritems; i++) {
+			tm_list[i] = alloc_tree_mod_elem(old_root, i,
+			    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING, GFP_NOFS);
+			if (!tm_list[i]) {
+				ret = -ENOMEM;
+				goto free_tms;
+			}
+		}
+	}
+
+	tm = kzalloc(sizeof(*tm), GFP_NOFS);
+	if (!tm) {
+		ret = -ENOMEM;
+		goto free_tms;
+	}
+
+	tm->logical = new_root->start;
+	tm->old_root.logical = old_root->start;
+	tm->old_root.level = btrfs_header_level(old_root);
+	tm->generation = btrfs_header_generation(old_root);
+	tm->op = BTRFS_MOD_LOG_ROOT_REPLACE;
+
+	if (tree_mod_dont_log(fs_info, NULL))
+		goto free_tms;
+
+	if (tm_list)
+		ret = tree_mod_log_free_eb(fs_info, tm_list, nritems);
+	if (!ret)
+		ret = tree_mod_log_insert(fs_info, tm);
+
+	write_unlock(&fs_info->tree_mod_log_lock);
+	if (ret)
+		goto free_tms;
+	kfree(tm_list);
+
+	return ret;
+
+free_tms:
+	if (tm_list) {
+		for (i = 0; i < nritems; i++)
+			kfree(tm_list[i]);
+		kfree(tm_list);
+	}
+	kfree(tm);
+
+	return ret;
+}
+
+static struct tree_mod_elem *__tree_mod_log_search(struct btrfs_fs_info *fs_info,
+						   u64 start, u64 min_seq,
+						   int smallest)
+{
+	struct rb_root *tm_root;
+	struct rb_node *node;
+	struct tree_mod_elem *cur = NULL;
+	struct tree_mod_elem *found = NULL;
+
+	read_lock(&fs_info->tree_mod_log_lock);
+	tm_root = &fs_info->tree_mod_log;
+	node = tm_root->rb_node;
+	while (node) {
+		cur = rb_entry(node, struct tree_mod_elem, node);
+		if (cur->logical < start) {
+			node = node->rb_left;
+		} else if (cur->logical > start) {
+			node = node->rb_right;
+		} else if (cur->seq < min_seq) {
+			node = node->rb_left;
+		} else if (!smallest) {
+			/* we want the node with the highest seq */
+			if (found)
+				BUG_ON(found->seq > cur->seq);
+			found = cur;
+			node = node->rb_left;
+		} else if (cur->seq > min_seq) {
+			/* we want the node with the smallest seq */
+			if (found)
+				BUG_ON(found->seq < cur->seq);
+			found = cur;
+			node = node->rb_right;
+		} else {
+			found = cur;
+			break;
+		}
+	}
+	read_unlock(&fs_info->tree_mod_log_lock);
+
+	return found;
+}
+
+/*
+ * This returns the element from the log with the smallest time sequence
+ * value that's in the log (the oldest log item). any element with a time
+ * sequence lower than min_seq will be ignored.
+ */
+static struct tree_mod_elem *tree_mod_log_search_oldest(struct btrfs_fs_info *fs_info,
+							u64 start, u64 min_seq)
+{
+	return __tree_mod_log_search(fs_info, start, min_seq, 1);
+}
+
+/*
+ * This returns the element from the log with the largest time sequence
+ * value that's in the log (the most recent log item). any element with
+ * a time sequence lower than min_seq will be ignored.
+ */
+static struct tree_mod_elem *tree_mod_log_search(struct btrfs_fs_info *fs_info,
+						 u64 start, u64 min_seq)
+{
+	return __tree_mod_log_search(fs_info, start, min_seq, 0);
+}
+
+
+int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
+			       struct extent_buffer *src,
+			       unsigned long dst_offset,
+			       unsigned long src_offset,
+			       int nr_items)
+{
+	struct btrfs_fs_info *fs_info = dst->fs_info;
+	int ret = 0;
+	struct tree_mod_elem **tm_list = NULL;
+	struct tree_mod_elem **tm_list_add, **tm_list_rem;
+	int i;
+	int locked = 0;
+
+	if (!tree_mod_need_log(fs_info, NULL))
+		return 0;
+
+	if (btrfs_header_level(dst) == 0 && btrfs_header_level(src) == 0)
+		return 0;
+
+	tm_list = kcalloc(nr_items * 2, sizeof(struct tree_mod_elem *),
+			  GFP_NOFS);
+	if (!tm_list)
+		return -ENOMEM;
+
+	tm_list_add = tm_list;
+	tm_list_rem = tm_list + nr_items;
+	for (i = 0; i < nr_items; i++) {
+		tm_list_rem[i] = alloc_tree_mod_elem(src, i + src_offset,
+		    BTRFS_MOD_LOG_KEY_REMOVE, GFP_NOFS);
+		if (!tm_list_rem[i]) {
+			ret = -ENOMEM;
+			goto free_tms;
+		}
+
+		tm_list_add[i] = alloc_tree_mod_elem(dst, i + dst_offset,
+		    BTRFS_MOD_LOG_KEY_ADD, GFP_NOFS);
+		if (!tm_list_add[i]) {
+			ret = -ENOMEM;
+			goto free_tms;
+		}
+	}
+
+	if (tree_mod_dont_log(fs_info, NULL))
+		goto free_tms;
+	locked = 1;
+
+	for (i = 0; i < nr_items; i++) {
+		ret = tree_mod_log_insert(fs_info, tm_list_rem[i]);
+		if (ret)
+			goto free_tms;
+		ret = tree_mod_log_insert(fs_info, tm_list_add[i]);
+		if (ret)
+			goto free_tms;
+	}
+
+	write_unlock(&fs_info->tree_mod_log_lock);
+	kfree(tm_list);
+
+	return 0;
+
+free_tms:
+	for (i = 0; i < nr_items * 2; i++) {
+		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
+			rb_erase(&tm_list[i]->node, &fs_info->tree_mod_log);
+		kfree(tm_list[i]);
+	}
+	if (locked)
+		write_unlock(&fs_info->tree_mod_log_lock);
+	kfree(tm_list);
+
+	return ret;
+}
+
+int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb)
+{
+	struct tree_mod_elem **tm_list = NULL;
+	int nritems = 0;
+	int i;
+	int ret = 0;
+
+	if (btrfs_header_level(eb) == 0)
+		return 0;
+
+	if (!tree_mod_need_log(eb->fs_info, NULL))
+		return 0;
+
+	nritems = btrfs_header_nritems(eb);
+	tm_list = kcalloc(nritems, sizeof(struct tree_mod_elem *), GFP_NOFS);
+	if (!tm_list)
+		return -ENOMEM;
+
+	for (i = 0; i < nritems; i++) {
+		tm_list[i] = alloc_tree_mod_elem(eb, i,
+		    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING, GFP_NOFS);
+		if (!tm_list[i]) {
+			ret = -ENOMEM;
+			goto free_tms;
+		}
+	}
+
+	if (tree_mod_dont_log(eb->fs_info, eb))
+		goto free_tms;
+
+	ret = tree_mod_log_free_eb(eb->fs_info, tm_list, nritems);
+	write_unlock(&eb->fs_info->tree_mod_log_lock);
+	if (ret)
+		goto free_tms;
+	kfree(tm_list);
+
+	return 0;
+
+free_tms:
+	for (i = 0; i < nritems; i++)
+		kfree(tm_list[i]);
+	kfree(tm_list);
+
+	return ret;
+}
+
+/*
+ * Returns the logical address of the oldest predecessor of the given root.
+ * entries older than time_seq are ignored.
+ */
+static struct tree_mod_elem *tree_mod_log_oldest_root(struct extent_buffer *eb_root,
+						      u64 time_seq)
+{
+	struct tree_mod_elem *tm;
+	struct tree_mod_elem *found = NULL;
+	u64 root_logical = eb_root->start;
+	int looped = 0;
+
+	if (!time_seq)
+		return NULL;
+
+	/*
+	 * the very last operation that's logged for a root is the
+	 * replacement operation (if it is replaced at all). this has
+	 * the logical address of the *new* root, making it the very
+	 * first operation that's logged for this root.
+	 */
+	while (1) {
+		tm = tree_mod_log_search_oldest(eb_root->fs_info, root_logical,
+						time_seq);
+		if (!looped && !tm)
+			return NULL;
+		/*
+		 * if there are no tree operation for the oldest root, we simply
+		 * return it. this should only happen if that (old) root is at
+		 * level 0.
+		 */
+		if (!tm)
+			break;
+
+		/*
+		 * if there's an operation that's not a root replacement, we
+		 * found the oldest version of our root. normally, we'll find a
+		 * BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING operation here.
+		 */
+		if (tm->op != BTRFS_MOD_LOG_ROOT_REPLACE)
+			break;
+
+		found = tm;
+		root_logical = tm->old_root.logical;
+		looped = 1;
+	}
+
+	/* if there's no old root to return, return what we found instead */
+	if (!found)
+		found = tm;
+
+	return found;
+}
+
+
+/*
+ * tm is a pointer to the first operation to rewind within eb. then, all
+ * previous operations will be rewound (until we reach something older than
+ * time_seq).
+ */
+static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
+				struct extent_buffer *eb,
+				u64 time_seq,
+				struct tree_mod_elem *first_tm)
+{
+	u32 n;
+	struct rb_node *next;
+	struct tree_mod_elem *tm = first_tm;
+	unsigned long o_dst;
+	unsigned long o_src;
+	unsigned long p_size = sizeof(struct btrfs_key_ptr);
+
+	n = btrfs_header_nritems(eb);
+	read_lock(&fs_info->tree_mod_log_lock);
+	while (tm && tm->seq >= time_seq) {
+		/*
+		 * all the operations are recorded with the operator used for
+		 * the modification. as we're going backwards, we do the
+		 * opposite of each operation here.
+		 */
+		switch (tm->op) {
+		case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING:
+			BUG_ON(tm->slot < n);
+			fallthrough;
+		case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING:
+		case BTRFS_MOD_LOG_KEY_REMOVE:
+			btrfs_set_node_key(eb, &tm->key, tm->slot);
+			btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
+			btrfs_set_node_ptr_generation(eb, tm->slot,
+						      tm->generation);
+			n++;
+			break;
+		case BTRFS_MOD_LOG_KEY_REPLACE:
+			BUG_ON(tm->slot >= n);
+			btrfs_set_node_key(eb, &tm->key, tm->slot);
+			btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
+			btrfs_set_node_ptr_generation(eb, tm->slot,
+						      tm->generation);
+			break;
+		case BTRFS_MOD_LOG_KEY_ADD:
+			/* if a move operation is needed it's in the log */
+			n--;
+			break;
+		case BTRFS_MOD_LOG_MOVE_KEYS:
+			o_dst = btrfs_node_key_ptr_offset(tm->slot);
+			o_src = btrfs_node_key_ptr_offset(tm->move.dst_slot);
+			memmove_extent_buffer(eb, o_dst, o_src,
+					      tm->move.nr_items * p_size);
+			break;
+		case BTRFS_MOD_LOG_ROOT_REPLACE:
+			/*
+			 * this operation is special. for roots, this must be
+			 * handled explicitly before rewinding.
+			 * for non-roots, this operation may exist if the node
+			 * was a root: root A -> child B; then A gets empty and
+			 * B is promoted to the new root. in the mod log, we'll
+			 * have a root-replace operation for B, a tree block
+			 * that is no root. we simply ignore that operation.
+			 */
+			break;
+		}
+		next = rb_next(&tm->node);
+		if (!next)
+			break;
+		tm = rb_entry(next, struct tree_mod_elem, node);
+		if (tm->logical != first_tm->logical)
+			break;
+	}
+	read_unlock(&fs_info->tree_mod_log_lock);
+	btrfs_set_header_nritems(eb, n);
+}
+
+
+/*
+ * Called with eb read locked. If the buffer cannot be rewound, the same buffer
+ * is returned. If rewind operations happen, a fresh buffer is returned. The
+ * returned buffer is always read-locked. If the returned buffer is not the
+ * input buffer, the lock on the input buffer is released and the input buffer
+ * is freed (its refcount is decremented).
+ */
+struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
+						struct btrfs_path *path,
+						struct extent_buffer *eb,
+						u64 time_seq)
+{
+	struct extent_buffer *eb_rewin;
+	struct tree_mod_elem *tm;
+
+	if (!time_seq)
+		return eb;
+
+	if (btrfs_header_level(eb) == 0)
+		return eb;
+
+	tm = tree_mod_log_search(fs_info, eb->start, time_seq);
+	if (!tm)
+		return eb;
+
+	if (tm->op == BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
+		BUG_ON(tm->slot != 0);
+		eb_rewin = alloc_dummy_extent_buffer(fs_info, eb->start);
+		if (!eb_rewin) {
+			btrfs_tree_read_unlock(eb);
+			free_extent_buffer(eb);
+			return NULL;
+		}
+		btrfs_set_header_bytenr(eb_rewin, eb->start);
+		btrfs_set_header_backref_rev(eb_rewin,
+					     btrfs_header_backref_rev(eb));
+		btrfs_set_header_owner(eb_rewin, btrfs_header_owner(eb));
+		btrfs_set_header_level(eb_rewin, btrfs_header_level(eb));
+	} else {
+		eb_rewin = btrfs_clone_extent_buffer(eb);
+		if (!eb_rewin) {
+			btrfs_tree_read_unlock(eb);
+			free_extent_buffer(eb);
+			return NULL;
+		}
+	}
+
+	btrfs_tree_read_unlock(eb);
+	free_extent_buffer(eb);
+
+	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
+				       eb_rewin, btrfs_header_level(eb_rewin));
+	btrfs_tree_read_lock(eb_rewin);
+	tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
+	WARN_ON(btrfs_header_nritems(eb_rewin) >
+		BTRFS_NODEPTRS_PER_BLOCK(fs_info));
+
+	return eb_rewin;
+}
+
+/*
+ * Rewinds the state of @root's root node to the given @time_seq value.
+ * If there are no changes, the current root->root_node is returned. If anything
+ * changed in between, there's a fresh buffer allocated on which the rewind
+ * operations are done. In any case, the returned buffer is read locked.
+ * Returns NULL on error (with no locks held).
+ */
+struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct tree_mod_elem *tm;
+	struct extent_buffer *eb = NULL;
+	struct extent_buffer *eb_root;
+	u64 eb_root_owner = 0;
+	struct extent_buffer *old;
+	struct tree_mod_root *old_root = NULL;
+	u64 old_generation = 0;
+	u64 logical;
+	int level;
+
+	eb_root = btrfs_read_lock_root_node(root);
+	tm = tree_mod_log_oldest_root(eb_root, time_seq);
+	if (!tm)
+		return eb_root;
+
+	if (tm->op == BTRFS_MOD_LOG_ROOT_REPLACE) {
+		old_root = &tm->old_root;
+		old_generation = tm->generation;
+		logical = old_root->logical;
+		level = old_root->level;
+	} else {
+		logical = eb_root->start;
+		level = btrfs_header_level(eb_root);
+	}
+
+	tm = tree_mod_log_search(fs_info, logical, time_seq);
+	if (old_root && tm && tm->op != BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
+		btrfs_tree_read_unlock(eb_root);
+		free_extent_buffer(eb_root);
+		old = read_tree_block(fs_info, logical, root->root_key.objectid,
+				      0, level, NULL);
+		if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old))) {
+			if (!IS_ERR(old))
+				free_extent_buffer(old);
+			btrfs_warn(fs_info,
+				   "failed to read tree block %llu from get_old_root",
+				   logical);
+		} else {
+			btrfs_tree_read_lock(old);
+			eb = btrfs_clone_extent_buffer(old);
+			btrfs_tree_read_unlock(old);
+			free_extent_buffer(old);
+		}
+	} else if (old_root) {
+		eb_root_owner = btrfs_header_owner(eb_root);
+		btrfs_tree_read_unlock(eb_root);
+		free_extent_buffer(eb_root);
+		eb = alloc_dummy_extent_buffer(fs_info, logical);
+	} else {
+		eb = btrfs_clone_extent_buffer(eb_root);
+		btrfs_tree_read_unlock(eb_root);
+		free_extent_buffer(eb_root);
+	}
+
+	if (!eb)
+		return NULL;
+	if (old_root) {
+		btrfs_set_header_bytenr(eb, eb->start);
+		btrfs_set_header_backref_rev(eb, BTRFS_MIXED_BACKREF_REV);
+		btrfs_set_header_owner(eb, eb_root_owner);
+		btrfs_set_header_level(eb, old_root->level);
+		btrfs_set_header_generation(eb, old_generation);
+	}
+	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb), eb,
+				       btrfs_header_level(eb));
+	btrfs_tree_read_lock(eb);
+	if (tm)
+		tree_mod_log_rewind(fs_info, eb, time_seq, tm);
+	else
+		WARN_ON(btrfs_header_level(eb) != 0);
+	WARN_ON(btrfs_header_nritems(eb) > BTRFS_NODEPTRS_PER_BLOCK(fs_info));
+
+	return eb;
+}
+
+int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq)
+{
+	struct tree_mod_elem *tm;
+	int level;
+	struct extent_buffer *eb_root = btrfs_root_node(root);
+
+	tm = tree_mod_log_oldest_root(eb_root, time_seq);
+	if (tm && tm->op == BTRFS_MOD_LOG_ROOT_REPLACE)
+		level = tm->old_root.level;
+	else
+		level = btrfs_header_level(eb_root);
+
+	free_extent_buffer(eb_root);
+
+	return level;
+}
+
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
new file mode 100644
index 000000000000..15e7a4c4bb14
--- /dev/null
+++ b/fs/btrfs/tree-mod-log.h
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_TREE_MOD_LOG_H
+#define BTRFS_TREE_MOD_LOG_H
+
+#include "ctree.h"
+
+/* Represents a tree mod log user. */
+struct btrfs_seq_list {
+	struct list_head list;
+	u64 seq;
+};
+
+#define BTRFS_SEQ_LIST_INIT(name) { .list = LIST_HEAD_INIT((name).list), .seq = 0 }
+#define BTRFS_SEQ_LAST            ((u64)-1)
+
+enum btrfs_mod_log_op {
+	BTRFS_MOD_LOG_KEY_REPLACE,
+	BTRFS_MOD_LOG_KEY_ADD,
+	BTRFS_MOD_LOG_KEY_REMOVE,
+	BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING,
+	BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING,
+	BTRFS_MOD_LOG_MOVE_KEYS,
+	BTRFS_MOD_LOG_ROOT_REPLACE,
+};
+
+u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
+			   struct btrfs_seq_list *elem);
+void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
+			    struct btrfs_seq_list *elem);
+int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
+				   struct extent_buffer *new_root,
+				   int log_removal);
+int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+				  enum btrfs_mod_log_op op, gfp_t flags);
+int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb);
+struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
+						struct btrfs_path *path,
+						struct extent_buffer *eb,
+						u64 time_seq);
+struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq);
+int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq);
+int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
+			       struct extent_buffer *src,
+			       unsigned long dst_offset,
+			       unsigned long src_offset,
+			       int nr_items);
+int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+				   int dst_slot, int src_slot,
+				   int nr_items);
+
+#endif /* BTRFS_TREE_MOD_LOG_H */
-- 
2.28.0

