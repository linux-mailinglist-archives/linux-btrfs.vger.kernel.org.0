Return-Path: <linux-btrfs+bounces-714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC9807240
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6792B1C20A51
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829A3EA6C;
	Wed,  6 Dec 2023 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nU4LDPs8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F986D50
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 06:22:54 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out2.suse.de (Postfix) with ESMTP id B6FFA1FD13;
	Wed,  6 Dec 2023 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701872572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pgYsLtKm73FD1m5TnP4W3OjGE7VDCk74un8Hqm4CZQ=;
	b=nU4LDPs8gyDPLij27DdTWr1s9DjF5g7JkrPLg/5/duyF6muYYwHY4O7q/W+QcOpwUguxOw
	h3yIcgXhuo3Y1ag/erLYXXGSyaUbdb5Dq318DTuBUwi/159tYR3/qzOqbL5LXCu1T7WM81
	kyNErwHfmwFCgsNxtT/V96QcrurjOCE=
Received: by ds.suse.cz (Postfix, from userid 10065)
	id A0C0BDA900; Wed,  6 Dec 2023 15:16:03 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/1 v2] btrfs: switch btrfs_root::delayed_nodes_tree to xarray from radix-tree
Date: Wed,  6 Dec 2023 15:16:03 +0100
Message-ID: <c8269e17d8295c223043c2b6bc09b04beab52a18.1701871671.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701871671.git.dsterba@suse.com>
References: <cover.1701871671.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.70
X-Spamd-Result: default: False [-1.70 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_COUNT_ZERO(0.00)[0];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%]

The radix-tree has been superseded by the xarray
(https://lwn.net/Articles/745073), this patch converts the
btrfs_root::delayed_nodes, the APIs are used in a simple way.

First idea is to do xa_insert() but this would require GFP_ATOMIC
allocation which we want to avoid if possible. The preload mechanism of
radix-tree can be emulated within the xarray API.

- xa_reserve() with GFP_NOFS outside of the lock, the reserved entry
  is inserted atomically at most once

- xa_store() under a lock, in case something races in we can detect that
  and xa_load() returns a valid pointer

All uses of xa_load() must check for a valid pointer in case they manage
to get between the xa_reserve() and xa_store(), this is handled in
btrfs_get_delayed_node().

Otherwise the functionality is equivalent, xarray implements the
radix-tree and there should be no performance difference.

The patch continues the efforts started in 253bf57555e451 ("btrfs: turn
delayed_nodes_tree into an XArray") and fixes the problems with locking
and GFP flags 088aea3b97e0ae ("Revert "btrfs: turn delayed_nodes_tree
into an XArray"").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h         |  6 ++--
 fs/btrfs/delayed-inode.c | 64 ++++++++++++++++++++++------------------
 fs/btrfs/disk-io.c       |  3 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 41 insertions(+), 34 deletions(-)

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
index 91159dd7355b..0247faf5bb01 100644
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
@@ -120,6 +120,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	struct btrfs_root *root = btrfs_inode->root;
 	u64 ino = btrfs_ino(btrfs_inode);
 	int ret;
+	void *ptr;
 
 again:
 	node = btrfs_get_delayed_node(btrfs_inode);
@@ -131,26 +132,30 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		return ERR_PTR(-ENOMEM);
 	btrfs_init_delayed_node(node, root, ino);
 
-	/* cached in the btrfs inode and can be accessed */
+	/* Cached in the inode and can be accessed. */
 	refcount_set(&node->refs, 2);
 
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
+	/* Allocate and reserve the slot, from now it can return a NULL on xa_load(). */
+	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
+	if (ret == -ENOMEM) {
 		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(ret);
+		return ERR_PTR(-ENOMEM);
 	}
-
 	spin_lock(&root->inode_lock);
-	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
-	if (ret == -EEXIST) {
+	ptr = xa_load(&root->delayed_nodes, ino);
+	if (ptr) {
+		/* Somebody inserted it, go back and read it. */
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, node);
-		radix_tree_preload_end();
+		node = NULL;
 		goto again;
 	}
+	ptr = xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
+	ASSERT(xa_err(ptr) != -EINVAL);
+	ASSERT(xa_err(ptr) != -ENOMEM);
+	ASSERT(ptr == NULL);
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);
-	radix_tree_preload_end();
 
 	return node;
 }
@@ -269,8 +274,7 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
-		radix_tree_delete(&root->delayed_nodes_tree,
-				  delayed_node->inode_id);
+		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
@@ -2038,34 +2042,36 @@ void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 
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
index a1f440cd6d45..5e64316f8026 100644
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
index 4fa7fabca2c5..4e8c82e5d7a6 100644
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


