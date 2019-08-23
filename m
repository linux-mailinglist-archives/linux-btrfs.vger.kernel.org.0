Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7193A9B527
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfHWRJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732498AbfHWRIS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FB04AC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66DC3DA796; Fri, 23 Aug 2019 19:08:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/7] btrfs: rename and export read_node_slot
Date:   Fri, 23 Aug 2019 19:08:41 +0200
Message-Id: <c09a30806d1881ebb4290c66d7514f3da31c4e42.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566579823.git.dsterba@suse.com>
References: <cover.1566579823.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparatory work for code that will be moved out of ctree and uses this
function.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 22 +++++++++++-----------
 fs/btrfs/ctree.h |  3 +++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2f3cd7a619c..3b585f3e4d11 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1792,8 +1792,8 @@ static void root_sub_used(struct btrfs_root *root, u32 size)
 /* given a node and slot number, this reads the blocks it points to.  The
  * extent buffer is returned with a reference taken (but unlocked).
  */
-static noinline struct extent_buffer *read_node_slot(
-				struct extent_buffer *parent, int slot)
+struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
+					   int slot)
 {
 	int level = btrfs_header_level(parent);
 	struct extent_buffer *eb;
@@ -1862,7 +1862,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			return 0;
 
 		/* promote the child to a root */
-		child = read_node_slot(mid, 0);
+		child = btrfs_read_node_slot(mid, 0);
 		if (IS_ERR(child)) {
 			ret = PTR_ERR(child);
 			btrfs_handle_fs_error(fs_info, ret, NULL);
@@ -1902,7 +1902,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
 		return 0;
 
-	left = read_node_slot(parent, pslot - 1);
+	left = btrfs_read_node_slot(parent, pslot - 1);
 	if (IS_ERR(left))
 		left = NULL;
 
@@ -1917,7 +1917,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	right = read_node_slot(parent, pslot + 1);
+	right = btrfs_read_node_slot(parent, pslot + 1);
 	if (IS_ERR(right))
 		right = NULL;
 
@@ -2077,7 +2077,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (!parent)
 		return 1;
 
-	left = read_node_slot(parent, pslot - 1);
+	left = btrfs_read_node_slot(parent, pslot - 1);
 	if (IS_ERR(left))
 		left = NULL;
 
@@ -2129,7 +2129,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(left);
 		free_extent_buffer(left);
 	}
-	right = read_node_slot(parent, pslot + 1);
+	right = btrfs_read_node_slot(parent, pslot + 1);
 	if (IS_ERR(right))
 		right = NULL;
 
@@ -3783,7 +3783,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	btrfs_assert_tree_locked(path->nodes[1]);
 
-	right = read_node_slot(upper, slot + 1);
+	right = btrfs_read_node_slot(upper, slot + 1);
 	/*
 	 * slot + 1 is not valid or we fail to read the right node,
 	 * no big deal, just return.
@@ -4017,7 +4017,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	btrfs_assert_tree_locked(path->nodes[1]);
 
-	left = read_node_slot(path->nodes[1], slot - 1);
+	left = btrfs_read_node_slot(path->nodes[1], slot - 1);
 	/*
 	 * slot - 1 is not valid or we fail to read the left node,
 	 * no big deal, just return.
@@ -5224,7 +5224,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			goto out;
 		}
 		btrfs_set_path_blocking(path);
-		cur = read_node_slot(cur, slot);
+		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
 			goto out;
@@ -5251,7 +5251,7 @@ static int tree_move_down(struct btrfs_path *path, int *level)
 	struct extent_buffer *eb;
 
 	BUG_ON(*level == 0);
-	eb = read_node_slot(path->nodes[*level], path->slots[*level]);
+	eb = btrfs_read_node_slot(path->nodes[*level], path->slots[*level]);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a7291e7dd574..70a80db23ecc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2586,6 +2586,9 @@ int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
 int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			 struct btrfs_path *path,
 			 u64 min_trans);
+struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
+					   int slot);
+
 enum btrfs_compare_tree_result {
 	BTRFS_COMPARE_TREE_NEW,
 	BTRFS_COMPARE_TREE_DELETED,
-- 
2.22.0

