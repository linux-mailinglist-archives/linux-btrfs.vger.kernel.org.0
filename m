Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427DE2A827E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbgKEPpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbgKEPp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:29 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92847C0613D3
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:28 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id s14so1529653qkg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/rr63Q25u3v+EEaFXf3TfJW7gNz8QktScKNU8+lknlE=;
        b=WkGwh3aKnIeMBaRdbJIYonTGTy0iF2/YSXClbqfi35A08GWsdAVFpT9ogsbs3UHrWU
         3GkT/4f4DFcAYVxfog40FY+E7fh3WlrDGmBD1nX/uB71LIVVhWDcnqQ53eUx3np96GUV
         Zj3YKX3lFC4mTk863R6htERjB+d0HrcIQOBAgJI9JDbheAcz7DCEQExHYI0x8QmLa4RN
         vwgk1vJTehQHOb1FeIFLim6fJGCbrBjOH/dppOZvT9MB5QLGLWXUp/vBkZPP1vYjSvbX
         n49XugZtBOnVW20l5v8EdIOHUn2TxUUh+BNxFJka4khZzPbgKsO3lEBUfThUMCx5LJ40
         pxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rr63Q25u3v+EEaFXf3TfJW7gNz8QktScKNU8+lknlE=;
        b=sk8JQ6qcANdxrcTgheAXv7PEVRVXEWtIFE+Jil420sgN1YqRWY2VxXvEIN37XwWuPz
         KLUfUS0fv3/4e3kbpZttugTik3KGusjvEj7MtYAhIPhLg9XT33uEqlAe7OidJPylcmbG
         9DjnoQXBW5S6UNrOaYVGJRAkbfWBv1szgh1ujaCuKukEM9cuENFkPyJgzkG8wySx856H
         3bp68lcPrgEIZWHJ5LOMG8rg2iezWCTdPzMYGeKOe6eCXfHUDRSVLyXNoIqdGjxPKT4H
         St3/Zl/+LASRc/54c2MhVBM3VTFr9piK+slxNX6WKoea+PDT3tO+kjW+/HLwX7A2Vdgb
         jC+w==
X-Gm-Message-State: AOAM530iPs5lZR0yy8g5h+mBx/zzV7qmQVVgj2Lz3aR1+DUAu25LT8Nl
        1fird73xHGX+WdsKN1yu1hArnFufDq58LdFo
X-Google-Smtp-Source: ABdhPJylyUHPbq4q3wnGW3mvLylHwBtzj68PLKYpy5PjnoGzFWnJDVgO5fXrN8dWSMLmYiA9O5TVCg==
X-Received: by 2002:a37:4e0a:: with SMTP id c10mr2604074qkb.492.1604591127289;
        Thu, 05 Nov 2020 07:45:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b12sm1280399qkk.71.2020.11.05.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/14] btrfs: cleanup extent buffer readahead
Date:   Thu,  5 Nov 2020 10:45:09 -0500
Message-Id: <c064bd10eca6d335160fa3ab838816fbc87de7c1.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm going to need to start passing around a lot more information when we
allocate extent buffers, in order to make that cleaner we need to
cleanup how we do readahead.  Most of the callers have the parent node
that we're getting our blockptr from, with the sole exception of
relocation which simply has the bytenr it wants to read.  Add a helper
that takes the current arguments that we need (bytenr and gen), and add
another helper for simply reading the slot out of a node.  In followup
patches the helper that takes all the extra arguments will be expanded,
and the simpler helper won't need to have it's arguments adjusted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 45 ++++++++--------------------------------
 fs/btrfs/disk-io.c     | 16 --------------
 fs/btrfs/disk-io.h     |  1 -
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/extent_io.c   | 47 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h   |  3 +++
 fs/btrfs/relocation.c  |  3 ++-
 fs/btrfs/volumes.c     |  8 ++-----
 8 files changed, 64 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d2d5854d51a7..0ff866328a4f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2226,7 +2226,7 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 		search = btrfs_node_blockptr(node, nr);
 		if ((search <= target && target - search <= 65536) ||
 		    (search > target && search - target <= 65536)) {
-			readahead_tree_block(fs_info, search);
+			btrfs_readahead_node_child(node, nr);
 			nread += blocksize;
 		}
 		nscan++;
@@ -2235,16 +2235,11 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static noinline void reada_for_balance(struct btrfs_fs_info *fs_info,
-				       struct btrfs_path *path, int level)
+static noinline void reada_for_balance(struct btrfs_path *path, int level)
 {
+	struct extent_buffer *parent;
 	int slot;
 	int nritems;
-	struct extent_buffer *parent;
-	struct extent_buffer *eb;
-	u64 gen;
-	u64 block1 = 0;
-	u64 block2 = 0;
 
 	parent = path->nodes[level + 1];
 	if (!parent)
@@ -2253,32 +2248,10 @@ static noinline void reada_for_balance(struct btrfs_fs_info *fs_info,
 	nritems = btrfs_header_nritems(parent);
 	slot = path->slots[level + 1];
 
-	if (slot > 0) {
-		block1 = btrfs_node_blockptr(parent, slot - 1);
-		gen = btrfs_node_ptr_generation(parent, slot - 1);
-		eb = find_extent_buffer(fs_info, block1);
-		/*
-		 * if we get -eagain from btrfs_buffer_uptodate, we
-		 * don't want to return eagain here.  That will loop
-		 * forever
-		 */
-		if (eb && btrfs_buffer_uptodate(eb, gen, 1) != 0)
-			block1 = 0;
-		free_extent_buffer(eb);
-	}
-	if (slot + 1 < nritems) {
-		block2 = btrfs_node_blockptr(parent, slot + 1);
-		gen = btrfs_node_ptr_generation(parent, slot + 1);
-		eb = find_extent_buffer(fs_info, block2);
-		if (eb && btrfs_buffer_uptodate(eb, gen, 1) != 0)
-			block2 = 0;
-		free_extent_buffer(eb);
-	}
-
-	if (block1)
-		readahead_tree_block(fs_info, block1);
-	if (block2)
-		readahead_tree_block(fs_info, block2);
+	if (slot > 0)
+		btrfs_readahead_node_child(parent, slot - 1);
+	if (slot + 1 < nritems)
+		btrfs_readahead_node_child(parent, slot + 1);
 }
 
 
@@ -2454,7 +2427,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		reada_for_balance(fs_info, p, level);
+		reada_for_balance(p, level);
 		sret = split_node(trans, root, p, level);
 
 		BUG_ON(sret > 0);
@@ -2473,7 +2446,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		reada_for_balance(fs_info, p, level);
+		reada_for_balance(p, level);
 		sret = balance_level(trans, root, p, level);
 
 		if (sret) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 35b16fe3b05f..ec64e087520e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -945,22 +945,6 @@ static const struct address_space_operations btree_aops = {
 	.set_page_dirty = btree_set_page_dirty,
 };
 
-void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct extent_buffer *buf = NULL;
-	int ret;
-
-	buf = btrfs_find_create_tree_block(fs_info, bytenr);
-	if (IS_ERR(buf))
-		return;
-
-	ret = read_extent_buffer_pages(buf, WAIT_NONE, 0);
-	if (ret < 0)
-		free_extent_buffer_stale(buf);
-	else
-		free_extent_buffer(buf);
-}
-
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 238b45223f2e..009f505d6c97 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -45,7 +45,6 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				      u64 parent_transid, int level,
 				      struct btrfs_key *first_key);
-void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d7a68203cda0..bf2f0af24e91 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4854,7 +4854,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 				continue;
 		}
 reada:
-		readahead_tree_block(fs_info, bytenr);
+		btrfs_readahead_node_child(eb, slot);
 		nread++;
 	}
 	wc->reada_slot = slot;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 119ced4a501b..c9d652b0770a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6114,3 +6114,50 @@ int try_release_extent_buffer(struct page *page)
 
 	return release_extent_buffer(eb);
 }
+
+/**
+ * btrfs_readahead_tree_block - attempt to readahead a child block.
+ * @fs_info - the fs_info for the fs.
+ * @bytenr - the bytenr to read.
+ * @gen - the generation for the uptodate check, can be 0.
+ *
+ * Attempt to readahead a tree block at @bytenr.  If @gen is 0 then we do a
+ * normal uptodate check of the eb, without checking the generation.  If we have
+ * to read the block we will not block on anything.
+ */
+void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
+				u64 bytenr, u64 gen)
+{
+	struct extent_buffer *eb;
+	int ret;
+
+	eb = btrfs_find_create_tree_block(fs_info, bytenr);
+	if (IS_ERR(eb))
+		return;
+
+	if (btrfs_buffer_uptodate(eb, gen, 1)) {
+		free_extent_buffer(eb);
+		return;
+	}
+
+	ret = read_extent_buffer_pages(eb, WAIT_NONE, 0);
+	if (ret < 0)
+		free_extent_buffer_stale(eb);
+	else
+		free_extent_buffer(eb);
+}
+
+/**
+ * btrfs_readahead_node_child - readahead a node's child block.
+ * @node - the parent node we're reading from.
+ * @slot - the slot in the parent node for the child we want to read.
+ *
+ * A helper for btrfs_readahead_tree_block, we simply read the bytenr pointed at
+ * the slot in the node provided.
+ */
+void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
+{
+	btrfs_readahead_tree_block(node->fs_info,
+				   btrfs_node_blockptr(node, slot),
+				   btrfs_node_ptr_generation(node, slot));
+}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 3c2bf21c54eb..a211e90292f8 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -198,6 +198,9 @@ void free_extent_buffer_stale(struct extent_buffer *eb);
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait,
 			     int mirror_num);
 void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
+void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
+				u64 bytenr, u64 gen);
+void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
 static inline int num_extent_pages(const struct extent_buffer *eb)
 {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0b3ccf464c3d..0e2dd7cf87f6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2542,7 +2542,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	/* Kick in readahead for tree blocks with missing keys */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
 		if (!block->key_ready)
-			readahead_tree_block(fs_info, block->bytenr);
+			btrfs_readahead_tree_block(fs_info,
+						   block->bytenr, 0);
 	}
 
 	/* Get first keys */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c927dc597550..8beb91d3cd88 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7065,12 +7065,8 @@ static void readahead_tree_node_children(struct extent_buffer *node)
 	int i;
 	const int nr_items = btrfs_header_nritems(node);
 
-	for (i = 0; i < nr_items; i++) {
-		u64 start;
-
-		start = btrfs_node_blockptr(node, i);
-		readahead_tree_block(node->fs_info, start);
-	}
+	for (i = 0; i < nr_items; i++)
+		btrfs_readahead_node_child(node, i);
 }
 
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
-- 
2.26.2

