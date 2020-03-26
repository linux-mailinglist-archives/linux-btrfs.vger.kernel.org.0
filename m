Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9972C193AED
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCZId5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbgCZId5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0A76ACC5
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:33:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/39] btrfs: Move btrfs_backref_(node|edge|cache) structures to backref.h
Date:   Thu, 26 Mar 2020 16:32:53 +0800
Message-Id: <20200326083316.48847-17-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These 3 structures are the main part of btrfs backref cache, move them
to backref.h to build the basis for later reuse.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    | 119 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.c | 113 ---------------------------------------
 2 files changed, 119 insertions(+), 113 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 3226dea35e2c..76858ec099d9 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -151,4 +151,123 @@ btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
 	memset(&iter->cur_key, 0, sizeof(iter->cur_key));
 }
 
+/*
+ * Backref cache related structures.
+ *
+ * The whole objective of backref_cache is to build a bi-directional map
+ * of tree blocks (represented by backref_node) and all their parents.
+ */
+
+/*
+ * present a tree block in the backref cache
+ */
+struct btrfs_backref_node {
+	struct rb_node rb_node;
+	u64 bytenr;
+
+	u64 new_bytenr;
+	/* objectid of tree block owner, can be not uptodate */
+	u64 owner;
+	/* link to pending, changed or detached list */
+	struct list_head list;
+
+	/* List of upper level edges, which links this node to its parent(s) */
+	struct list_head upper;
+	/* List of lower level edges, which links this node to its child(ren) */
+	struct list_head lower;
+
+	/* NULL if this node is not tree root */
+	struct btrfs_root *root;
+	/* extent buffer got by COW the block */
+	struct extent_buffer *eb;
+	/* level of tree block */
+	unsigned int level:8;
+	/* is the block in non-reference counted tree */
+	unsigned int cowonly:1;
+	/* 1 if no child node in the cache */
+	unsigned int lowest:1;
+	/* is the extent buffer locked */
+	unsigned int locked:1;
+	/* has the block been processed */
+	unsigned int processed:1;
+	/* have backrefs of this block been checked */
+	unsigned int checked:1;
+	/*
+	 * 1 if corresponding block has been cowed but some upper
+	 * level block pointers may not point to the new location
+	 */
+	unsigned int pending:1;
+	/*
+	 * 1 if the backref node isn't connected to any other
+	 * backref node.
+	 */
+	unsigned int detached:1;
+
+	/*
+	 * For generic purpose backref cache, where we only care if it's a reloc
+	 * root, doesn't care the source subvolid.
+	 */
+	unsigned int is_reloc_root:1;
+};
+
+#define LOWER	0
+#define UPPER	1
+/*
+ * present an edge connecting upper and lower backref nodes.
+ */
+struct btrfs_backref_edge {
+	/*
+	 * list[LOWER] is linked to btrfs_backref_node::upper of lower level
+	 * node, and list[UPPER] is linked to btrfs_backref_node::lower of
+	 * upper level node.
+	 *
+	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
+	 * linking list[UPPER] to its upper level nodes.
+	 */
+	struct list_head list[2];
+
+	/* Two related nodes */
+	struct btrfs_backref_node *node[2];
+};
+
+struct btrfs_backref_cache {
+	/* red black tree of all backref nodes in the cache */
+	struct rb_root rb_root;
+	/* for passing backref nodes to btrfs_reloc_cow_block */
+	struct btrfs_backref_node *path[BTRFS_MAX_LEVEL];
+	/*
+	 * list of blocks that have been cowed but some block
+	 * pointers in upper level blocks may not reflect the
+	 * new location
+	 */
+	struct list_head pending[BTRFS_MAX_LEVEL];
+	/* list of backref nodes with no child node */
+	struct list_head leaves;
+	/* list of blocks that have been cowed in current transaction */
+	struct list_head changed;
+	/* list of detached backref node. */
+	struct list_head detached;
+
+	u64 last_trans;
+
+	int nr_nodes;
+	int nr_edges;
+
+	/* The list of unchecked backref edges during backref cache build */
+	struct list_head pending_edge;
+
+	/* The list of useless backref nodes during backref cache build */
+	struct list_head useless_node;
+
+	struct btrfs_fs_info *fs_info;
+
+	/*
+	 * Whether this cache is for relocation
+	 *
+	 * Reloction backref cache require more info for reloc root compared
+	 * to generic backref cache.
+	 */
+	unsigned int is_reloc;
+};
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 94a000ea2759..ec7d28d63347 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -80,120 +80,7 @@ struct tree_entry {
 	u64 bytenr;
 };
 
-/*
- * present a tree block in the backref cache
- */
-struct btrfs_backref_node {
-	struct rb_node rb_node;
-	u64 bytenr;
-
-	u64 new_bytenr;
-	/* objectid of tree block owner, can be not uptodate */
-	u64 owner;
-	/* link to pending, changed or detached list */
-	struct list_head list;
-
-	/* List of upper level edges, which links this node to its parent(s) */
-	struct list_head upper;
-	/* List of lower level edges, which links this node to its child(ren) */
-	struct list_head lower;
-
-	/* NULL if this node is not tree root */
-	struct btrfs_root *root;
-	/* extent buffer got by COW the block */
-	struct extent_buffer *eb;
-	/* level of tree block */
-	unsigned int level:8;
-	/* is the block in non-reference counted tree */
-	unsigned int cowonly:1;
-	/* 1 if no child node in the cache */
-	unsigned int lowest:1;
-	/* is the extent buffer locked */
-	unsigned int locked:1;
-	/* has the block been processed */
-	unsigned int processed:1;
-	/* have backrefs of this block been checked */
-	unsigned int checked:1;
-	/*
-	 * 1 if corresponding block has been cowed but some upper
-	 * level block pointers may not point to the new location
-	 */
-	unsigned int pending:1;
-	/*
-	 * 1 if the backref node isn't connected to any other
-	 * backref node.
-	 */
-	unsigned int detached:1;
-
-	/*
-	 * For generic purpose backref cache, where we only care if it's a reloc
-	 * root, doesn't care the source subvolid.
-	 */
-	unsigned int is_reloc_root:1;
-};
-
-#define LOWER	0
-#define UPPER	1
 #define RELOCATION_RESERVED_NODES	256
-/*
- * present an edge connecting upper and lower backref nodes.
- */
-struct btrfs_backref_edge {
-	/*
-	 * list[LOWER] is linked to btrfs_backref_node::upper of lower level
-	 * node, and list[UPPER] is linked to btrfs_backref_node::lower of
-	 * upper level node.
-	 *
-	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
-	 * linking list[UPPER] to its upper level nodes.
-	 */
-	struct list_head list[2];
-
-	/* Two related nodes */
-	struct btrfs_backref_node *node[2];
-};
-
-
-struct btrfs_backref_cache {
-	/* red black tree of all backref nodes in the cache */
-	struct rb_root rb_root;
-	/* for passing backref nodes to btrfs_reloc_cow_block */
-	struct btrfs_backref_node *path[BTRFS_MAX_LEVEL];
-	/*
-	 * list of blocks that have been cowed but some block
-	 * pointers in upper level blocks may not reflect the
-	 * new location
-	 */
-	struct list_head pending[BTRFS_MAX_LEVEL];
-	/* list of backref nodes with no child node */
-	struct list_head leaves;
-	/* list of blocks that have been cowed in current transaction */
-	struct list_head changed;
-	/* list of detached backref node. */
-	struct list_head detached;
-
-	u64 last_trans;
-
-	int nr_nodes;
-	int nr_edges;
-
-	/* The list of unchecked backref edges during backref cache build */
-	struct list_head pending_edge;
-
-	/* The list of useless backref nodes during backref cache build */
-	struct list_head useless_node;
-
-	struct btrfs_fs_info *fs_info;
-
-	/*
-	 * Whether this cache is for relocation
-	 *
-	 * Reloction backref cache require more info for reloc root compared
-	 * to generic backref cache.
-	 */
-	unsigned int is_reloc;
-};
-
 /*
  * map address of tree root to tree
  */
-- 
2.26.0

