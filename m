Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4F176FC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCCHOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:14:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:56536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbgCCHOX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:14:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E21BB135
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:14:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/19] btrfs: Move backref node/edge/cache structure to backref.h
Date:   Tue,  3 Mar 2020 15:13:51 +0800
Message-Id: <20200303071409.57982-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These 3 structures are the main part of backref cache, move them to
backref.h to build the basis for later reuse.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    | 98 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.c | 93 +---------------------------------------
 2 files changed, 100 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 42fd76dfe553..3cf79fafdf07 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -168,4 +168,102 @@ btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
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
+struct backref_node {
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
+};
+
+#define LOWER	0
+#define UPPER	1
+
+/*
+ * present an edge connecting upper and lower backref nodes.
+ */
+struct backref_edge {
+	/*
+	 * list[LOWER] is linked to backref_node::upper of lower level node,
+	 * and list[UPPER] is linked to backref_node::lower of upper level node.
+	 *
+	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
+	 * linking list[UPPER] to its upper level nodes.
+	 */
+	struct list_head list[2];
+
+	/* Two related nodes */
+	struct backref_node *node[2];
+};
+
+
+struct backref_cache {
+	/* red black tree of all backref nodes in the cache */
+	struct rb_root rb_root;
+	/* for passing backref nodes to btrfs_reloc_cow_block */
+	struct backref_node *path[BTRFS_MAX_LEVEL];
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
+};
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 93364eb07a61..8d939c7837c8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -24,6 +24,8 @@
 #include "block-group.h"
 #include "backref.h"
 
+#define RELOCATION_RESERVED_NODES	256
+
 /*
  * Relocation overview
  *
@@ -79,97 +81,6 @@ struct tree_entry {
 	u64 bytenr;
 };
 
-/*
- * present a tree block in the backref cache
- */
-struct backref_node {
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
-};
-
-#define LOWER	0
-#define UPPER	1
-#define RELOCATION_RESERVED_NODES	256
-/*
- * present an edge connecting upper and lower backref nodes.
- */
-struct backref_edge {
-	/*
-	 * list[LOWER] is linked to backref_node::upper of lower level node,
-	 * and list[UPPER] is linked to backref_node::lower of upper level node.
-	 *
-	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
-	 * linking list[UPPER] to its upper level nodes.
-	 */
-	struct list_head list[2];
-
-	/* Two related nodes */
-	struct backref_node *node[2];
-};
-
-
-struct backref_cache {
-	/* red black tree of all backref nodes in the cache */
-	struct rb_root rb_root;
-	/* for passing backref nodes to btrfs_reloc_cow_block */
-	struct backref_node *path[BTRFS_MAX_LEVEL];
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
-};
-
 /*
  * map address of tree root to tree
  */
-- 
2.25.1

