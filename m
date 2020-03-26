Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEE5193AE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCZIdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgCZIdk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D404EAE24;
        Thu, 26 Mar 2020 08:33:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 08/39] btrfs: relocation: Refactor direct tree backref processing into its own function
Date:   Thu, 26 Mar 2020 16:32:45 +0800
Message-Id: <20200326083316.48847-9-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For BTRFS_SHARED_BLOCK_REF_KEY, its processing is straightforward, as we
now the parent node bytenr directly.

If the parent is already cached, or a root, call it a day.
If the parent is not cached, add it pending list.

This patch will just refactor this part into its own function,
handle_direct_tree_backref() and add some comment explaining the
@ref_key parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 131 +++++++++++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 72eb2b52d14a..3a1a54350139 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -698,6 +698,82 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
+/*
+ * Handle direct tree backref.
+ *
+ * Direct tree backref means, the backref item shows its parent bytenr
+ * directly. This is for SHARED_BLOCK_REF backref (keyed or inlined).
+ *
+ * @ref_key:	The converted backref key.
+ *		For keyed backref, it's the item key.
+ *		For inlined backref, objectid is the bytenr,
+ *		type is btrfs_inline_ref_type, offset is
+ *		btrfs_inline_ref_offset.
+ */
+static int handle_direct_tree_backref(struct backref_cache *cache,
+				      struct btrfs_key *ref_key,
+				      struct backref_node *cur)
+{
+	struct backref_edge *edge;
+	struct backref_node *upper;
+	struct rb_node *rb_node;
+
+	ASSERT(ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY);
+
+	/* Only reloc root uses backref pointing to itself */
+	if (ref_key->objectid == ref_key->offset) {
+		struct btrfs_root *root;
+
+		cur->is_reloc_root = 1;
+		/* Only reloc backref cache cares exact root */
+		if (cache->is_reloc) {
+			root = find_reloc_root(cache->fs_info, cur->bytenr);
+			if (WARN_ON(!root))
+				return -ENOENT;
+			cur->root = root;
+		} else {
+			/*
+			 * For generic purpose backref cache, reloc root node
+			 * is useless.
+			 */
+			list_add(&cur->list, &cache->useless_node);
+		}
+		return 0;
+	}
+
+	edge = alloc_backref_edge(cache);
+	if (!edge)
+		return -ENOMEM;
+
+	rb_node = tree_search(&cache->rb_root, ref_key->offset);
+	if (!rb_node) {
+		/* Parent node not yet cached */
+		upper = alloc_backref_node(cache);
+		if (!upper) {
+			free_backref_edge(cache, edge);
+			return -ENOMEM;
+		}
+		upper->bytenr = ref_key->offset;
+		upper->level = cur->level + 1;
+
+		/*
+		 *  backrefs for the upper level block isn't
+		 *  cached, add the block to pending list
+		 */
+		list_add_tail(&edge->list[UPPER], &cache->pending_edge);
+	} else {
+		/* Parent node already cached */
+		upper = rb_entry(rb_node, struct backref_node,
+				 rb_node);
+		ASSERT(upper->checked);
+		INIT_LIST_HEAD(&edge->list[UPPER]);
+	}
+	list_add_tail(&edge->list[LOWER], &cur->upper);
+	edge->node[LOWER] = cur;
+	edge->node[UPPER] = upper;
+	return 0;
+}
+
 /*
  * build backref tree for a given tree block. root of the backref tree
  * corresponds the tree block, leaves of the backref tree correspond
@@ -719,7 +795,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 {
 	struct btrfs_backref_iter *iter;
 	struct backref_cache *cache = &rc->backref_cache;
-	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
 	struct btrfs_root *root;
 	struct backref_node *cur;
@@ -840,59 +915,11 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
 		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
-			if (key.objectid == key.offset) {
-				cur->is_reloc_root = 1;
-				/* Only reloc backref cache cares exact root */
-				if (cache->is_reloc) {
-					root = find_reloc_root(fs_info,
-							cur->bytenr);
-					if (WARN_ON(!root)) {
-						err = -ENOENT;
-						goto out;
-					}
-					cur->root = root;
-				} else {
-					/*
-					 * For generic purpose backref cache,
-					 * reloc root node is useless.
-					 */
-					list_add(&cur->list,
-						&cache->useless_node);
-				}
-				break;
-			}
-
-			edge = alloc_backref_edge(cache);
-			if (!edge) {
-				err = -ENOMEM;
+			ret = handle_direct_tree_backref(cache, &key, cur);
+			if (ret < 0) {
+				err = ret;
 				goto out;
 			}
-			rb_node = tree_search(&cache->rb_root, key.offset);
-			if (!rb_node) {
-				upper = alloc_backref_node(cache);
-				if (!upper) {
-					free_backref_edge(cache, edge);
-					err = -ENOMEM;
-					goto out;
-				}
-				upper->bytenr = key.offset;
-				upper->level = cur->level + 1;
-				/*
-				 *  backrefs for the upper level block isn't
-				 *  cached, add the block to pending list
-				 */
-				list_add_tail(&edge->list[UPPER],
-					      &cache->pending_edge);
-			} else {
-				upper = rb_entry(rb_node, struct backref_node,
-						 rb_node);
-				ASSERT(upper->checked);
-				INIT_LIST_HEAD(&edge->list[UPPER]);
-			}
-			list_add_tail(&edge->list[LOWER], &cur->upper);
-			edge->node[LOWER] = cur;
-			edge->node[UPPER] = upper;
-
 			continue;
 		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
 			err = -EINVAL;
-- 
2.26.0

