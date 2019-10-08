Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29CCF825
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfJHL2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 07:28:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730316AbfJHL2j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 07:28:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4790B28D;
        Tue,  8 Oct 2019 11:28:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1093DA7FB; Tue,  8 Oct 2019 13:28:49 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: opencode extent_buffer_get
Date:   Tue,  8 Oct 2019 13:28:47 +0200
Message-Id: <20191008112847.14359-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper is trivial and we can understand what the atomic_inc on
something named refs does.

Signed-off-by: David Sterba <dsterba@suse.com>
---

quiz: find where and how is the refs are decremented

 fs/btrfs/ctree.c       | 12 ++++++------
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/extent_io.h   |  5 -----
 fs/btrfs/qgroup.c      |  6 +++---
 fs/btrfs/relocation.c  |  4 ++--
 fs/btrfs/tree-log.c    |  2 +-
 7 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f2f9cf1149a4..b6f30f748d7e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1100,7 +1100,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			parent_start = buf->start;
 
-		extent_buffer_get(cow);
+		atomic_inc(&cow->refs);
 		ret = tree_mod_log_insert_root(root->node, cow, 1);
 		BUG_ON(ret < 0);
 		rcu_assign_pointer(root->node, cow);
@@ -2011,7 +2011,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	/* update the path */
 	if (left) {
 		if (btrfs_header_nritems(left) > orig_slot) {
-			extent_buffer_get(left);
+			atomic_inc(&left->refs);
 			/* left was locked after cow */
 			path->nodes[level] = left;
 			path->slots[level + 1] -= 1;
@@ -2601,7 +2601,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 
 		} else {
 			b = root->commit_root;
-			extent_buffer_get(b);
+			atomic_inc(&b->refs);
 		}
 		level = btrfs_header_level(b);
 		/*
@@ -3375,7 +3375,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	free_extent_buffer(old);
 
 	add_root_to_dirty_list(root);
-	extent_buffer_get(c);
+	atomic_inc(&c->refs);
 	path->nodes[level] = c;
 	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
 	path->slots[level] = 0;
@@ -4908,7 +4908,7 @@ static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
 
 	root_sub_used(root, leaf->len);
 
-	extent_buffer_get(leaf);
+	atomic_inc(&leaf->refs);
 	btrfs_free_tree_block(trans, root, leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
 }
@@ -4989,7 +4989,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			 * for possible call to del_ptr below
 			 */
 			slot = path->slots[1];
-			extent_buffer_get(leaf);
+			atomic_inc(&leaf->refs);
 
 			btrfs_set_path_blocking(path);
 			wret = push_leaf_left(trans, root, path, 1, 1,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 16dc60b4966d..6655daf0b380 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -608,7 +608,7 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	/* the pending IO might have been the only thing that kept this buffer
 	 * in memory.  Make sure we have a ref for all this other checks
 	 */
-	extent_buffer_get(eb);
+	atomic_inc(&eb->refs);
 
 	reads_done = atomic_dec_and_test(&eb->io_pages);
 	if (!reads_done)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 49cb26fa7c63..9e5845548b76 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5436,7 +5436,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 
 	btrfs_assert_tree_locked(parent);
 	parent_level = btrfs_header_level(parent);
-	extent_buffer_get(parent);
+	atomic_inc(&parent->refs);
 	path->nodes[parent_level] = parent;
 	path->slots[parent_level] = btrfs_header_nritems(parent);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e22045cef89b..a8551a1f56e2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -230,11 +230,6 @@ static inline int num_extent_pages(const struct extent_buffer *eb)
 	       (eb->start >> PAGE_SHIFT);
 }
 
-static inline void extent_buffer_get(struct extent_buffer *eb)
-{
-	atomic_inc(&eb->refs);
-}
-
 static inline int extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	return test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e734d6d38579..dcb906c4a63d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1811,7 +1811,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		btrfs_item_key_to_cpu(dst_path->nodes[dst_level], &key, 0);
 
 	/* For src_path */
-	extent_buffer_get(src_eb);
+	atomic_inc(&src_eb->refs);
 	src_path->nodes[root_level] = src_eb;
 	src_path->slots[root_level] = dst_path->slots[root_level];
 	src_path->locks[root_level] = 0;
@@ -2067,7 +2067,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	/* For dst_path */
-	extent_buffer_get(dst_eb);
+	atomic_inc(&dst_eb->refs);
 	dst_path->nodes[level] = dst_eb;
 	dst_path->slots[level] = 0;
 	dst_path->locks[level] = 0;
@@ -2126,7 +2126,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	 * walk back up the tree (adjusting slot pointers as we go)
 	 * and restart the search process.
 	 */
-	extent_buffer_get(root_eb); /* For path */
+	atomic_inc(&root_eb->refs);	/* For path */
 	path->nodes[root_level] = root_eb;
 	path->slots[root_level] = 0;
 	path->locks[root_level] = 0; /* so release_path doesn't try to unlock */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 077ad3d93639..10d004f4ca46 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1254,7 +1254,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_root_level(root_item);
-		extent_buffer_get(reloc_root->node);
+		atomic_inc(&reloc_root->node->refs);
 		path->nodes[level] = reloc_root->node;
 		path->slots[level] = 0;
 	} else {
@@ -3676,7 +3676,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		       node->new_bytenr != buf->start);
 
 		drop_node_buffer(node);
-		extent_buffer_get(cow);
+		atomic_inc(&cow->refs);
 		node->eb = cow;
 		node->new_bytenr = cow->start;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fa35fb890bf3..b9b7b9d406fd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2851,7 +2851,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 	level = btrfs_header_level(log->node);
 	orig_level = level;
 	path->nodes[level] = log->node;
-	extent_buffer_get(log->node);
+	atomic_inc(&log->node->refs);
 	path->slots[level] = 0;
 
 	while (1) {
-- 
2.23.0

