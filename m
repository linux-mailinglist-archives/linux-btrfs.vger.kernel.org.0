Return-Path: <linux-btrfs+bounces-460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2867FFEC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F63281A5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD3561FA8;
	Thu, 30 Nov 2023 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IXo3XVkn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A92CA
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 14:56:24 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out1.suse.de (Postfix) with ESMTP id 90CA621BA7;
	Thu, 30 Nov 2023 22:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701384983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry2Drqgen0wT+5Iu3S5ZgFDxRYTslNLnZHTwJNIoNSY=;
	b=IXo3XVkn7+hvoC0VVXFIIl2e6peVeBzWQZRXu7FxTVseP/MUPEVCGlI/sTzRcDwUHsC7o9
	slziX0x/C07M3DYDS9+RNBRcz1Lf9DERxnrH+9/+E5jyQVdy9Td7rGwlzOsfMhOMoWNDlE
	+bjoCxfxbQ4EwBlrkGY2ivnS1FEGUKc=
Received: by ds.suse.cz (Postfix, from userid 10065)
	id CBACCDA86C; Thu, 30 Nov 2023 23:49:10 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use xarray for btrfs_root::delayed_nodes_tree instead of radix-tree
Date: Thu, 30 Nov 2023 23:49:10 +0100
Message-ID: <e283f8d460c7b3288e8eb1d8974d6b5842210167.1701384168.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701384168.git.dsterba@suse.com>
References: <cover.1701384168.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.41
X-Spamd-Result: default: False [-2.41 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-0.71)[-0.713];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_COUNT_ZERO(0.00)[0];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%]

Port btrfs_root::delayed_nodes_tree to the xarray API. The functionality
is equivalent, the flags are still GFP_ATOMIC as the changes are done
under a spin lock. Using a sleeping allocation would need changing the
lock to mutex.

The conversion is almost direct, btrfs_kill_all_delayed_nodes() uses an
iterator to collect the items to delete.

The patch is almost the same as 253bf57555e451 ("btrfs: turn
delayed_nodes_tree into an XArray"), there are renames, comments and
change of the GFP flags for xa_insert.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h         |  6 +--
 fs/btrfs/delayed-inode.c | 80 ++++++++++++++++++++--------------------
 fs/btrfs/disk-io.c       |  3 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 54fd4eb92745..70e828d33177 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -227,10 +227,10 @@ struct btrfs_root {
 	struct rb_root inode_tree;
 
 	/*
-	 * radix tree that keeps track of delayed nodes of every inode,
-	 * protected by inode_lock
+	 * Xarray that keeps track of delayed nodes of every inode, protected
+	 * by @inode_lock.
 	 */
-	struct radix_tree_root delayed_nodes_tree;
+	struct xarray delayed_nodes;
 	/*
 	 * right now this just gets used so that a root has its own devid
 	 * for stat.  It may be used for more later
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c9c4a53048a1..0437f52ca42c 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -71,7 +71,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	}
 
 	spin_lock(&root->inode_lock);
-	node = radix_tree_lookup(&root->delayed_nodes_tree, ino);
+	node = xa_load(&root->delayed_nodes, ino);
 
 	if (node) {
 		if (btrfs_inode->delayed_node) {
@@ -83,9 +83,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 
 		/*
 		 * It's possible that we're racing into the middle of removing
-		 * this node from the radix tree.  In this case, the refcount
+		 * this node from the xarray.  In this case, the refcount
 		 * was zero and it should never go back to one.  Just return
-		 * NULL like it was never in the radix at all; our release
+		 * NULL like it was never in the xarray at all; our release
 		 * function is in the process of removing it.
 		 *
 		 * Some implementations of refcount_inc refuse to bump the
@@ -93,7 +93,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 * here, refcount_inc() may decide to just WARN_ONCE() instead
 		 * of actually bumping the refcount.
 		 *
-		 * If this node is properly in the radix, we want to bump the
+		 * If this node is properly in the xarray, we want to bump the
 		 * refcount twice, once for the inode and once for this get
 		 * operation.
 		 */
@@ -121,28 +121,29 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	u64 ino = btrfs_ino(btrfs_inode);
 	int ret;
 
-again:
-	node = btrfs_get_delayed_node(btrfs_inode);
-	if (node)
-		return node;
+	do {
+		node = btrfs_get_delayed_node(btrfs_inode);
+		if (node)
+			return node;
 
-	node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
-	if (!node)
-		return ERR_PTR(-ENOMEM);
-	btrfs_init_delayed_node(node, root, ino);
+		node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
+		if (!node)
+			return ERR_PTR(-ENOMEM);
+		btrfs_init_delayed_node(node, root, ino);
 
-	/* cached in the btrfs inode and can be accessed */
-	refcount_set(&node->refs, 2);
+		/* Cached in the inode and can be accessed. */
+		refcount_set(&node->refs, 2);
 
-	spin_lock(&root->inode_lock);
-	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
-	if (ret < 0) {
-		spin_unlock(&root->inode_lock);
-		kmem_cache_free(delayed_node_cache, node);
-		if (ret == -EEXIST)
-			goto again;
-		return ERR_PTR(ret);
-	}
+		spin_lock(&root->inode_lock);
+		ret = xa_insert(&root->delayed_nodes, ino, node, GFP_ATOMIC);
+		if (ret < 0) {
+			spin_unlock(&root->inode_lock);
+			kmem_cache_free(delayed_node_cache, node);
+			if (ret != -EBUSY)
+				return ERR_PTR(ret);
+			/* Otherwise it's ENOMEM. */
+		}
+	} while (ret < 0);
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);
 
@@ -263,8 +264,7 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
-		radix_tree_delete(&root->delayed_nodes_tree,
-				  delayed_node->inode_id);
+		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
@@ -2032,34 +2032,36 @@ void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 
 void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 {
-	u64 inode_id = 0;
+	unsigned long index = 0;
 	struct btrfs_delayed_node *delayed_nodes[8];
-	int i, n;
 
 	while (1) {
+		struct btrfs_delayed_node *node;
+		int count;
+
 		spin_lock(&root->inode_lock);
-		n = radix_tree_gang_lookup(&root->delayed_nodes_tree,
-					   (void **)delayed_nodes, inode_id,
-					   ARRAY_SIZE(delayed_nodes));
-		if (!n) {
+		if (xa_empty(&root->delayed_nodes)) {
 			spin_unlock(&root->inode_lock);
-			break;
+			return;
 		}
 
-		inode_id = delayed_nodes[n - 1]->inode_id + 1;
-		for (i = 0; i < n; i++) {
+		count = 0;
+		xa_for_each_start(&root->delayed_nodes, index, node, index) {
 			/*
 			 * Don't increase refs in case the node is dead and
 			 * about to be removed from the tree in the loop below
 			 */
-			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
-				delayed_nodes[i] = NULL;
+			if (refcount_inc_not_zero(&node->refs)) {
+				delayed_nodes[count] = node;
+				count++;
+			}
+			if (count >= ARRAY_SIZE(delayed_nodes))
+				break;
 		}
 		spin_unlock(&root->inode_lock);
+		index++;
 
-		for (i = 0; i < n; i++) {
-			if (!delayed_nodes[i])
-				continue;
+		for (int i = 0; i < count; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
 			btrfs_release_delayed_node(delayed_nodes[i]);
 		}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9317606017e2..39810120e9f9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -655,7 +655,8 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
 	root->inode_tree = RB_ROOT;
-	INIT_RADIX_TREE(&root->delayed_nodes_tree, GFP_ATOMIC);
+	/* GFP flags are compatible with XA_FLAGS_*. */
+	xa_init_flags(&root->delayed_nodes, GFP_ATOMIC);
 
 	btrfs_init_root_block_rsv(root);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8647d8271b7..41c904530eaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3805,7 +3805,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	 * cache.
 	 *
 	 * This is required for both inode re-read from disk and delayed inode
-	 * in delayed_nodes_tree.
+	 * in the delayed_nodes xarray.
 	 */
 	if (BTRFS_I(inode)->last_trans == btrfs_get_fs_generation(fs_info))
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-- 
2.42.1


