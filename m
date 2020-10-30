Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABEA2A0FDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgJ3VDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF0C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 12so2301623qkl.8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZVqTZUivwyGZXz4YCJVu8kQfpynmGi1Av7J3i6fozac=;
        b=GrBgL2zszggf+ugpJUVcjoZQ4JpLjgoRdhKMWDZX6LDYLPyD8GHjb54MMXXIJL2+jR
         oTSdI8ofk9FBOl4yRUYMLVdUodJoj3hda7RHDZ65w9vlCWoZSY5rcrJtuOlyv7urfH2V
         i0v13rI+KxpnYN1PQTCvUmGEI2gZF6U6eyFIqq+gS0JvgAF3eEVjziTm1Bw9X4sOHZWC
         gDs/1yrx2ZXxBV4CnyCCUMnDUjL1FTlgyTO9f1Uq2Bj3G0nEFI4bkBL6E8DehGUns09T
         /JfNQdS+sANgicckf0qYgL5EcXjeMLQCNW7HyUT7OSKjtlX8pxdyqSBiwAk6zvju3m/U
         Y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVqTZUivwyGZXz4YCJVu8kQfpynmGi1Av7J3i6fozac=;
        b=n+23jGtQxqXCzIvMBmuRax6x0ZWABU/UX0tXEHhy7gVUF5nyVjIxEEThqayGDPP2YC
         8BwfwgZNpslbmdwPx3OPpoXtfvBW5hr+Q04vGlXOlAC6IarrXTSne1Pf9yExTL0Jf38l
         Fa7PaJEy6bLbdN/H76xEXTPfwy34FwBcEeo5lnJWIqSCH/sJXL1L8XRmSO+3AP2ntx+g
         GW2HQ5GEU6GA9d3fffaPm0OybUscPzWl05RCeFxSZzdQMO9hmpKJB1QHpXuS9TpIJXXo
         F4eJpV32ZvPRzdUER9Q2cxk2GwUkfCz9B0xebNMuBWqdBGfv5SVkgKgpE8Om0GAtd1SK
         tFsw==
X-Gm-Message-State: AOAM53283o+V02vIeiRyMAgpDyTvZbOmp/wrn7Fi4QLz2OJRXgOvzVTe
        4mmUQ7kmIQYbqyOh2bQx4INjj03tS3CQpQ19
X-Google-Smtp-Source: ABdhPJzRKh6bacjt0Lh3N3iGD3nu0bL6oik8DLbemGTIqcn/n1YyceiuU0cMPy1lqYNoshyrBmVzGw==
X-Received: by 2002:a37:a34a:: with SMTP id m71mr4208260qke.81.1604091792090;
        Fri, 30 Oct 2020 14:03:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w25sm2925797qkj.85.2020.10.30.14.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/14] btrfs: cleanup extent buffer readahead
Date:   Fri, 30 Oct 2020 17:02:54 -0400
Message-Id: <40fe12160324eaee77987b106ae12ef5d067d288.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
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
index 113da62dc17f..f8a7416d8a24 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2243,7 +2243,7 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 		search = btrfs_node_blockptr(node, nr);
 		if ((search <= target && target - search <= 65536) ||
 		    (search > target && search - target <= 65536)) {
-			readahead_tree_block(fs_info, search);
+			btrfs_readahead_node_child(node, nr);
 			nread += blocksize;
 		}
 		nscan++;
@@ -2252,16 +2252,11 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
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
@@ -2270,32 +2265,10 @@ static noinline void reada_for_balance(struct btrfs_fs_info *fs_info,
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
 
 
@@ -2481,7 +2454,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_set_path_blocking(p);
-		reada_for_balance(fs_info, p, level);
+		reada_for_balance(p, level);
 		sret = split_node(trans, root, p, level);
 
 		BUG_ON(sret > 0);
@@ -2501,7 +2474,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_set_path_blocking(p);
-		reada_for_balance(fs_info, p, level);
+		reada_for_balance(p, level);
 		sret = balance_level(trans, root, p, level);
 
 		if (sret) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 73eae594e934..464dfb15b054 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -946,22 +946,6 @@ static const struct address_space_operations btree_aops = {
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
index 182540bdcea0..34934f38582b 100644
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
index 5fd60b13f4f8..0ca1135dab8c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4905,7 +4905,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 				continue;
 		}
 reada:
-		readahead_tree_block(fs_info, bytenr);
+		btrfs_readahead_node_child(eb, slot);
 		nread++;
 	}
 	wc->reada_slot = slot;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cf3f576d6277..654e2e517f3d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6106,3 +6106,50 @@ int try_release_extent_buffer(struct page *page)
 
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
index 3801eb3b726e..4f95b087a901 100644
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
index 9ba92d86da0b..50ca5a4f0a96 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2546,7 +2546,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	/* Kick in readahead for tree blocks with missing keys */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
 		if (!block->key_ready)
-			readahead_tree_block(fs_info, block->bytenr);
+			btrfs_readahead_tree_block(fs_info,
+						   block->bytenr, 0);
 	}
 
 	/* Get first keys */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index eb9ee7c2998f..75350c78ca02 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7077,12 +7077,8 @@ static void readahead_tree_node_children(struct extent_buffer *node)
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

