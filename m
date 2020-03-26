Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E034193B09
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCZIel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgCZIel (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3248AE24
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 34/39] btrfs: qgroup: Introduce qgroup_backref_cache_build() function
Date:   Thu, 26 Mar 2020 16:33:11 +0800
Message-Id: <20200326083316.48847-35-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is the main function to build the generic purposed backref
cache for qgroup.

The major difference from relocation purposed backref cache is:
- No processed extent_io_tree
  As we don't need to bother the relocation progress

- Don't care reloc root
  Since reloc root doesn't contribute to qgroup accounting, reloc roots
  are queued to useless list

- Always populate backref_node::owner
  This is the main index for qgroup backref cache to find out the owner
  of one tree block.
  The @owner parameter is from tree block header owner, which doesn't
  reflect reloc tree. But backref cache mechanism will detect reloc tree
  and remove them from backref cache, thus the header owner is very
  accruate for qgroup usage.

This function will be utlized in incoming patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 31b320860b71..d7d50943f482 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -22,6 +22,7 @@
 #include "extent_io.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "misc.h"
 
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
@@ -1606,6 +1607,159 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static bool handle_useless_nodes(struct btrfs_backref_cache *cache,
+				 struct btrfs_backref_node *node)
+{
+	struct list_head *useless_node = &cache->useless_node;
+	bool ret = false;
+
+	while (!list_empty(useless_node)) {
+		struct btrfs_backref_node *cur;
+
+		cur = list_first_entry(useless_node, struct btrfs_backref_node,
+				 list);
+		list_del_init(&cur->list);
+
+		/* Only tree root nodes can be added to @useless_nodes */
+		ASSERT(list_empty(&cur->upper));
+
+		if (cur == node)
+			ret = true;
+
+		/* The node is the lowest node */
+		if (cur->lowest) {
+			list_del_init(&cur->lower);
+			cur->lowest = 0;
+		}
+
+		/* Cleanup the lower edges */
+		while (!list_empty(&cur->lower)) {
+			struct btrfs_backref_edge *edge;
+			struct btrfs_backref_node *lower;
+
+			edge = list_entry(cur->lower.next,
+					struct btrfs_backref_edge, list[UPPER]);
+			list_del(&edge->list[UPPER]);
+			list_del(&edge->list[LOWER]);
+			lower = edge->node[LOWER];
+			btrfs_backref_free_edge(cache, edge);
+
+			/* Child node is also orphan, queue for cleanup */
+			if (list_empty(&lower->upper))
+				list_add(&lower->list, useless_node);
+		}
+
+		/*
+		 * Backref nodes for tree leaves are deleted from the cache.
+		 * Backref nodes for upper level tree blocks are left in the
+		 * cache to avoid unnecessary backref lookup.
+		 */
+		if (cur->level > 0) {
+			list_add(&cur->list, &cache->detached);
+			cur->detached = 1;
+		} else {
+			rb_erase(&cur->rb_node, &cache->rb_root);
+			btrfs_backref_free_node(cache, cur);
+		}
+	}
+	return ret;
+}
+
+/*
+ * Build backref cache for one tree block.
+ *
+ * @node_key:	The first key of the tree block.
+ * @level:	Tree level
+ * @bytenr:	The bytenr of the tree block.
+ * @owner:	The owner from btrfs_header.
+ *
+ * Caller must ensure the tree block belongs to a subvolume tree.
+ *
+ * Return the cached backref_node if the tree block is useful for owner
+ * iteration.
+ *
+ * Return NULL if the tree block doesn't make sense for owner iteration.
+ * (E.g. the tree block belongs to a reloc tree)
+ *
+ * Return ERR_PTR() if something wrong happened.
+ */
+static struct btrfs_backref_node *qgroup_backref_cache_build(
+		struct btrfs_fs_info *fs_info,
+		struct btrfs_key *node_key,
+		int level, u64 bytenr, u64 owner)
+{
+	struct btrfs_backref_iter *iter;
+	struct btrfs_backref_cache *cache = fs_info->qgroup_backref_cache;
+	struct btrfs_path *path;
+	struct btrfs_backref_node *cur;
+	struct btrfs_backref_node *node = NULL;
+	struct btrfs_backref_edge *edge;
+	struct rb_node *rb_node;
+	int ret;
+
+	ASSERT(is_fstree(owner));
+
+	rb_node = simple_search(&cache->rb_root, bytenr);
+	/* Already cached, return the cached node directly */
+	if (rb_node)
+		return rb_entry(rb_node, struct btrfs_backref_node, rb_node);
+
+	iter = btrfs_backref_iter_alloc(fs_info, GFP_NOFS);
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	node = btrfs_backref_alloc_node(cache, bytenr, level);
+	if (!node) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	node->owner = owner;
+	node->lowest = 1;
+	cur = node;
+
+	/* Breadth-first search to build backref cache */
+	do {
+		ret = btrfs_backref_add_tree_node(cache, path, iter, node_key,
+						  cur);
+		if (ret < 0)
+			goto out;
+		edge = list_first_entry_or_null(&cache->pending_edge,
+				struct btrfs_backref_edge, list[UPPER]);
+		/*
+		 * the pending list isn't empty, take the first block to
+		 * process.
+		 */
+		if (edge) {
+			list_del_init(&edge->list[UPPER]);
+			cur = edge->node[UPPER];
+		}
+	} while (edge);
+
+	/* Finish the upper linkage of newly added edges/nodes */
+	ret = btrfs_backref_finish_upper_links(cache, node);
+	if (ret < 0)
+		goto out;
+
+	if (handle_useless_nodes(cache, node))
+		node = NULL;
+out:
+	btrfs_backref_iter_free(iter);
+	btrfs_free_path(path);
+	if (ret < 0) {
+		btrfs_backref_error_cleanup(cache, node);
+		return ERR_PTR(ret);
+	}
+	ASSERT(!node || !node->detached);
+	ASSERT(list_empty(&cache->useless_node) &&
+	       list_empty(&cache->pending_edge));
+	return node;
+}
+
 int btrfs_qgroup_trace_extent_post(struct btrfs_fs_info *fs_info,
 				   struct btrfs_qgroup_extent_record *qrecord)
 {
-- 
2.26.0

