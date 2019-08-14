Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A408C56B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfHNBEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfHNBEt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C961AF94
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: print-tree: Skip dropped tree blocks properly
Date:   Wed, 14 Aug 2019 09:04:40 +0800
Message-Id: <20190814010440.15186-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814010440.15186-1-wqu@suse.com>
References: <20190814010440.15186-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For certain btrfs image, btrfs ins dump-tree can hit checksum error for
tree blocks:

  $ btrfs ins dump-tree -t 256 /dev/test/scratch1 > /dev/null
  checksum verify failed on 33173504 found 295F0086 wanted 00000000
  checksum verify failed on 33173504 found 295F0086 wanted 00000000
  checksum verify failed on 33173504 found 295F0086 wanted 00000000
  bad tree block 33173504, bytenr mismatch, want=33173504, have=0

[CAUSE]
The fs is a completely valid fs, with its file tree 256 being half
dropped.

The fs is crafted by using dm-log-writes, with extra kernel hack to
commit transaction for each tree block dropped, and mounted with discard
option to discard dropped tree blocks.

The cause is pretty simple, btrfs ins dump-tree doesn't really check the
drop progress of a tree.
So when above condition is met, dump-tree will still try to print a tree
block which is already dropped.

[FIX]
Fix this problem by introducing @borderline parameter for
btrfs_print_tree() and its children functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-tree.c | 33 ++++++++++++++------
 print-tree.c             | 67 ++++++++++++++++++++++++++++++++--------
 print-tree.h             |  4 ++-
 3 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index e50130a4a161..c2145a2559bc 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -277,7 +277,7 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
 			ret = -EIO;
 			goto next;
 		}
-		btrfs_print_tree(eb, follow, BTRFS_PRINT_TREE_DEFAULT);
+		btrfs_print_tree(eb, NULL, follow, BTRFS_PRINT_TREE_DEFAULT);
 		free_extent_buffer(eb);
 next:
 		remove_cache_extent(tree, ce);
@@ -486,20 +486,20 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 		} else {
 			if (info->tree_root->node) {
 				printf("root tree\n");
-				btrfs_print_tree(info->tree_root->node, true,
-						 traverse);
+				btrfs_print_tree(info->tree_root->node, NULL,
+						 true, traverse);
 			}
 
 			if (info->chunk_root->node) {
 				printf("chunk tree\n");
-				btrfs_print_tree(info->chunk_root->node, true,
-						 traverse);
+				btrfs_print_tree(info->chunk_root->node, NULL,
+						 true, traverse);
 			}
 
 			if (info->log_root_tree) {
 				printf("log root tree\n");
 				btrfs_print_tree(info->log_root_tree->node,
-						 true, traverse);
+						 NULL, true, traverse);
 			}
 		}
 	}
@@ -519,7 +519,7 @@ again:
 			goto close_root;
 		}
 		printf("root tree\n");
-		btrfs_print_tree(info->tree_root->node, true, traverse);
+		btrfs_print_tree(info->tree_root->node, NULL, true, traverse);
 		goto close_root;
 	}
 
@@ -529,7 +529,7 @@ again:
 			goto close_root;
 		}
 		printf("chunk tree\n");
-		btrfs_print_tree(info->chunk_root->node, true, traverse);
+		btrfs_print_tree(info->chunk_root->node, NULL, true, traverse);
 		goto close_root;
 	}
 
@@ -539,7 +539,7 @@ again:
 			goto close_root;
 		}
 		printf("log root tree\n");
-		btrfs_print_tree(info->log_root_tree->node, true, traverse);
+		btrfs_print_tree(info->log_root_tree->node, NULL, true, traverse);
 		goto close_root;
 	}
 
@@ -566,12 +566,24 @@ again:
 		btrfs_item_key(leaf, &disk_key, path.slots[0]);
 		btrfs_disk_key_to_cpu(&found_key, &disk_key);
 		if (found_key.type == BTRFS_ROOT_ITEM_KEY) {
+			struct btrfs_root *root;
+			struct btrfs_key search_key;
+			struct btrfs_drop_borderline borderline;
 			unsigned long offset;
 			struct extent_buffer *buf;
 			int skip = extent_only | device_only | uuid_tree_only;
 
+			search_key.objectid = found_key.objectid;
+			search_key.type = found_key.type;
+			search_key.offset = -1;
 			offset = btrfs_item_ptr_offset(leaf, slot);
 			read_extent_buffer(leaf, &ri, offset, sizeof(ri));
+			root = btrfs_read_fs_root(info, &search_key);
+			if (!IS_ERR_OR_NULL(root)) {
+				btrfs_init_drop_borderline(root, &borderline);
+			} else {
+				memset(&borderline, 0, sizeof(borderline));
+			}
 			buf = read_tree_block(info, btrfs_root_bytenr(&ri), 0);
 			if (!extent_buffer_uptodate(buf))
 				goto next;
@@ -685,7 +697,8 @@ again:
 					       btrfs_header_level(buf));
 				} else {
 					printf(" \n");
-					btrfs_print_tree(buf, true, traverse);
+					btrfs_print_tree(buf, &borderline,
+							 true, traverse);
 				}
 			}
 			free_extent_buffer(buf);
diff --git a/print-tree.c b/print-tree.c
index b31e515f8989..105663a00710 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -1352,6 +1352,7 @@ void btrfs_print_leaf(struct extent_buffer *eb)
 
 /* Helper function to reach the leftmost tree block at @path->lowest_level */
 static int search_leftmost_tree_block(struct btrfs_fs_info *fs_info,
+				      struct btrfs_drop_borderline *borderline,
 				      struct btrfs_path *path, int root_level)
 {
 	int i;
@@ -1365,12 +1366,20 @@ static int search_leftmost_tree_block(struct btrfs_fs_info *fs_info,
 		free_extent_buffer(path->nodes[i]);
 	}
 
-	/* Reach the leftmost tree block by always reading out slot 0 */
+	/*
+	 * Reach the leftmost tree block by always reading out slot 0
+	 * or goes for the borderline
+	 */
 	for (i = root_level; i > path->lowest_level; i--) {
 		struct extent_buffer *eb;
 
-		path->slots[i] = 0;
-		eb = read_node_slot(fs_info, path->nodes[i], 0);
+		if (borderline)
+			btrfs_bin_search(path->nodes[i], &borderline->keys[i],
+					 i, &path->slots[i]);
+		else
+			path->slots[i] = 0;
+
+		eb = read_node_slot(fs_info, path->nodes[i], path->slots[i]);
 		if (!extent_buffer_uptodate(eb)) {
 			ret = -EIO;
 			goto out;
@@ -1381,7 +1390,8 @@ out:
 	return ret;
 }
 
-static void bfs_print_children(struct extent_buffer *root_eb)
+static void bfs_print_children(struct extent_buffer *root_eb,
+			       struct btrfs_drop_borderline *borderline)
 {
 	struct btrfs_fs_info *fs_info = root_eb->fs_info;
 	struct btrfs_path path;
@@ -1401,13 +1411,14 @@ static void bfs_print_children(struct extent_buffer *root_eb)
 		path.lowest_level = cur_level;
 
 		/* Use the leftmost tree block as a starting point */
-		ret = search_leftmost_tree_block(fs_info, &path, root_level);
+		ret = search_leftmost_tree_block(fs_info, borderline, &path,
+						 root_level);
 		if (ret < 0)
 			goto out;
 
 		/* Print all sibling tree blocks */
 		while (1) {
-			btrfs_print_tree(path.nodes[cur_level], 0,
+			btrfs_print_tree(path.nodes[cur_level], borderline, 0,
 					 BTRFS_PRINT_TREE_BFS);
 			ret = btrfs_next_sibling_tree_block(fs_info, &path);
 			if (ret < 0)
@@ -1423,7 +1434,8 @@ out:
 	return;
 }
 
-static void dfs_print_children(struct extent_buffer *root_eb)
+static void dfs_print_children(struct extent_buffer *root_eb,
+			       struct btrfs_drop_borderline *borderline)
 {
 	struct btrfs_fs_info *fs_info = root_eb->fs_info;
 	struct extent_buffer *next;
@@ -1432,6 +1444,15 @@ static void dfs_print_children(struct extent_buffer *root_eb)
 	int i;
 
 	for (i = 0; i < nr; i++) {
+		struct btrfs_key key;
+
+		if (borderline) {
+			btrfs_node_key_to_cpu(root_eb, &key, i);
+			/* We are at the left side, skip the slot */
+			if (btrfs_comp_cpu_keys(&key,
+					&borderline->keys[root_eb_level]) < 0)
+				continue;
+		}
 		next = read_tree_block(fs_info, btrfs_node_blockptr(root_eb, i),
 				btrfs_node_ptr_generation(root_eb, i));
 		if (!extent_buffer_uptodate(next)) {
@@ -1449,16 +1470,29 @@ static void dfs_print_children(struct extent_buffer *root_eb)
 			free_extent_buffer(next);
 			continue;
 		}
-		btrfs_print_tree(next, 1, BTRFS_PRINT_TREE_DFS);
+		btrfs_print_tree(next, borderline, 1, BTRFS_PRINT_TREE_DFS);
 		free_extent_buffer(next);
 	}
 }
 
-void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse)
+/*
+ * Print the tree block or the whole subtree at @eb.
+ *
+ * @borderline:	if given, this function will ensure no tree blocks at the
+ * 		left side of the borderline will be printed.
+ * 		(tree blocks at borderline will still be printed)
+ * @follow:	whether to print the whole subtree. Only makes sense for nodes.
+ * @traverse:	the order to iterate the subtree. Only makes sense when
+ * 		@follow is true
+ */
+void btrfs_print_tree(struct extent_buffer *eb,
+		      struct btrfs_drop_borderline *borderline,
+		      bool follow, int traverse)
 {
 	u32 i;
 	u32 nr;
 	u32 ptr_num;
+	int level;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_disk_key disk_key;
 	struct btrfs_key key;
@@ -1468,6 +1502,7 @@ void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse)
 	if (traverse != BTRFS_PRINT_TREE_DFS && traverse != BTRFS_PRINT_TREE_BFS)
 		traverse = BTRFS_PRINT_TREE_DEFAULT;
 
+	level = btrfs_header_level(eb);
 	nr = btrfs_header_nritems(eb);
 	if (btrfs_is_leaf(eb)) {
 		btrfs_print_leaf(eb);
@@ -1489,15 +1524,21 @@ void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse)
 	fflush(stdout);
 	ptr_num = BTRFS_NODEPTRS_PER_EXTENT_BUFFER(eb);
 	for (i = 0; i < nr && i < ptr_num; i++) {
+		const char *dropped_str = "";
+
 		u64 blocknr = btrfs_node_blockptr(eb, i);
 
 		btrfs_node_key(eb, &disk_key, i);
 		btrfs_disk_key_to_cpu(&key, &disk_key);
 		printf("\t");
 		btrfs_print_key(&disk_key);
-		printf(" block %llu gen %llu\n",
+		if (borderline && btrfs_comp_cpu_keys(&key,
+					&borderline->keys[level]) < 0)
+			dropped_str = " =DROPPED=";
+		printf(" block %llu gen %llu%s\n",
 		       (unsigned long long)blocknr,
-		       (unsigned long long)btrfs_node_ptr_generation(eb, i));
+		       (unsigned long long)btrfs_node_ptr_generation(eb, i),
+		       dropped_str);
 		fflush(stdout);
 	}
 	if (!follow)
@@ -1507,8 +1548,8 @@ void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse)
 		return;
 
 	if (traverse == BTRFS_PRINT_TREE_DFS)
-		dfs_print_children(eb);
+		dfs_print_children(eb, borderline);
 	else
-		bfs_print_children(eb);
+		bfs_print_children(eb, borderline);
 	return;
 }
diff --git a/print-tree.h b/print-tree.h
index d4721b60647f..5574d9102614 100644
--- a/print-tree.h
+++ b/print-tree.h
@@ -32,7 +32,9 @@ void btrfs_print_leaf(struct extent_buffer *l);
 #define BTRFS_PRINT_TREE_DFS		0
 #define BTRFS_PRINT_TREE_BFS		1
 #define BTRFS_PRINT_TREE_DEFAULT	BTRFS_PRINT_TREE_DFS
-void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse);
+void btrfs_print_tree(struct extent_buffer *eb,
+		      struct btrfs_drop_borderline *borderline,
+		      bool follow, int traverse);
 
 void btrfs_print_key(struct btrfs_disk_key *disk_key);
 void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk);
-- 
2.22.0

