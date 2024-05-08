Return-Path: <linux-btrfs+bounces-4833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EA8BFCF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324A91F24B71
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56483CBA;
	Wed,  8 May 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBJgiROo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4183A12
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170655; cv=none; b=kT/RXSSPoCP3CzcBjnLfMMKibaP0D2x0zJZgtY1iNuRVlFadxExdes6pAvejF71f1RBv00jkmdUjQf/nC/Xz45GUdU/h7Y+GB0pk4OcuOdmweJ11b09n676UffGP/Ak70/9LP7WizRaC4ScIy1HTi5xNyEamrsmqYSC2pQrv0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170655; c=relaxed/simple;
	bh=EyBRNjfnPcGuOPjs3FXXiJPJ6vgrVJSJOeHSgkwTIoY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKAjfXEVu9tAUrabSUvc0QG6pF8URIjWs4C7weIRFYXcvBwcXaItcbSJ2kMJxbKJhbTy62rgVXoa9sxNJAztqBXOR16EQZ4wnc3CAbn+uctASs3wgdfACt+uqifnYtWVQZE+xRu9nn8Nz+sz9aXs8RvIZfjcAJ3UAVhPSkDL64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBJgiROo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F51DC3277B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170655;
	bh=EyBRNjfnPcGuOPjs3FXXiJPJ6vgrVJSJOeHSgkwTIoY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lBJgiROonmQT3wzKOafERMc7McDUSUQupzO0wAIR8XDW2u+/obUky+wQfeU5jAmla
	 vNP8yLHcgAtisRM9y1cFgusGqWbaGYPwCmT+cl1Cg/vyBY6sFLUvxqNCEqT5eEFDIP
	 NFm20HcTIQ/e5e0f+ARatLXU5j6clDb48/XhugY8JoJoePW7tPhSaYAIyj+Fb8mvWe
	 CsN5yhxiWKXwXucU0kLAa1IqYey3G54q7J/WalnKUPvTe/5I8tn/DOBB8geaVo5l/l
	 wT76T2u2/hb1q0IwmQwtVvWzW+ATWL4INY/7KdqrDPrS+6x5fqeKGooXEmRQLjLC9l
	 r04rcfR3mKwyA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: use an xarray to track open inodes in a root
Date: Wed,  8 May 2024 13:17:24 +0100
Message-Id: <b0f3124d15d38e7ab8283821a123fcdd36900e29.1715169723.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715169723.git.fdmanana@suse.com>
References: <cover.1715169723.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we use a red black tree (rb-tree) to track the currently open
inodes of a root (in struct btrfs_root::inode_tree). This however is not
very efficient when the number of inodes is large since rb-trees are
binary trees. For example for 100K open inodes, the tree has a depth of
17. Besides that, inserting into the tree requires navigating through it
and pulling useless cache lines in the process since the red black tree
nodes are embedded within the btrfs inode - on the other hand, by being
embedded, it requires no extra memory allocations.

We can improve this by using an xarray instead, which is efficient when
indices are densely clustered (such as inode numbers), is more cache
friendly and behaves like a resizable array, with a much better search
and insertion complexity than a red black tree. This only has one small
disadvantage which is that insertion will sometimes require allocating
memory for the xarray - which may fail (not that often since it uses a
kmem_cache) - but on the other hand we can reduce the btrfs inode
structure size by 24 bytes (from 1064 down to 1040 bytes) after removing
the embedded red black tree node, which after the next patches will allow
to reduce the size of the structure to 1024 bytes, meaning we will be able
to store 4 inodes per 4K page instead of 3 inodes.

This change does a straighforward change to use an xarray, and results
in a transaction abort if we can't allocate memory for the xarray when
creating an inode - but the next patch changes things so that we don't
need to abort.

Running the following fs_mark test showed some improvements:

    $ cat test.sh
    #!/bin/bash

    DEV=/dev/nullb0
    MNT=/mnt/nullb0
    MOUNT_OPTIONS="-o ssd"
    FILES=100000
    THREADS=$(nproc --all)

    echo "performance" | \
        tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

    mkfs.btrfs -f $DEV
    mount $MOUNT_OPTIONS $DEV $MNT

    OPTS="-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
    for ((i = 1; i <= $THREADS; i++)); do
        OPTS="$OPTS -d $MNT/d$i"
    done

    fs_mark $OPTS

    umount $MNT

Before this patch:

    FSUse%        Count         Size    Files/sec     App Overhead
        10      1200000            0      92081.6         12505547
        16      2400000            0     138222.6         13067072
        23      3600000            0     148833.1         13290336
        43      4800000            0      97864.7         13931248
        53      6000000            0      85597.3         14384313

After this patch:

    FSUse%        Count         Size    Files/sec     App Overhead
        10      1200000            0      93225.1         12571078
        16      2400000            0     146720.3         12805007
        23      3600000            0     160626.4         13073835
        46      4800000            0     116286.2         13802927
        53      6000000            0      90087.9         14754892

The test was run with a release kernel config (Debian's default config).

Also capturing the insertion times into the rb tree and into the xarray,
that is measuring the duration of the old function inode_tree_add() and
the duration of the new btrfs_add_inode_to_root() function, gave the
following results (in nanoseconds):

Before this patch, inode_tree_add() execution times:

   Count: 5000000
   Range:  0.000 - 5536887.000; Mean: 775.674; Median: 729.000; Stddev: 4820.961
   Percentiles:  90th: 1015.000; 95th: 1139.000; 99th: 1397.000
      0.000 -    7.816:    40 |
      7.816 -   37.858:   209 |
     37.858 -  170.278:  6059 |
    170.278 -  753.961: 2754890 #####################################################
    753.961 - 3326.728: 2232312 ###########################################
   3326.728 - 14667.018:  4366 |
   14667.018 - 64652.943:   852 |
   64652.943 - 284981.761:   550 |
   284981.761 - 1256150.914:   221 |
   1256150.914 - 5536887.000:     7 |

After this patch, btrfs_add_inode_to_root() execution times:

   Count: 5000000
   Range:  0.000 - 2900652.000; Mean: 272.148; Median: 241.000; Stddev: 2873.369
   Percentiles:  90th: 342.000; 95th: 432.000; 99th: 572.000
      0.000 -    7.264:   104 |
      7.264 -   33.145:   352 |
     33.145 -  140.081: 109606 #
    140.081 -  581.930: 4840090 #####################################################
    581.930 - 2407.590: 43532 |
   2407.590 - 9950.979:  2245 |
   9950.979 - 41119.278:   514 |
   41119.278 - 169902.616:   155 |
   169902.616 - 702018.539:    47 |
   702018.539 - 2900652.000:     9 |

Average, percentiles, standard deviation, etc, are all much better.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |   3 -
 fs/btrfs/ctree.h       |   7 ++-
 fs/btrfs/disk-io.c     |   6 +-
 fs/btrfs/inode.c       | 128 ++++++++++++++++-------------------------
 4 files changed, 58 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 91c994b569f3..e577b9745884 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -155,9 +155,6 @@ struct btrfs_inode {
 	 */
 	struct list_head delalloc_inodes;
 
-	/* node for the red-black tree that links inodes in subvolume root */
-	struct rb_node rb_node;
-
 	unsigned long runtime_flags;
 
 	/* full 64 bit generation number, struct vfs_inode doesn't have a big
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c03c58246033..aa2568f86dc9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -222,8 +222,11 @@ struct btrfs_root {
 	struct list_head root_list;
 
 	spinlock_t inode_lock;
-	/* red-black tree that keeps track of in-memory inodes */
-	struct rb_root inode_tree;
+	/*
+	 * Xarray that keeps track of in-memory inodes, protected by the lock
+	 * @inode_lock.
+	 */
+	struct xarray inodes;
 
 	/*
 	 * Xarray that keeps track of delayed nodes of every inode, protected
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..ed40fe1db53e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -662,7 +662,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->free_objectid = 0;
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
-	root->inode_tree = RB_ROOT;
+	xa_init(&root->inodes);
 	xa_init(&root->delayed_nodes);
 
 	btrfs_init_root_block_rsv(root);
@@ -1854,7 +1854,8 @@ void btrfs_put_root(struct btrfs_root *root)
 		return;
 
 	if (refcount_dec_and_test(&root->refs)) {
-		WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
+		if (WARN_ON(!xa_empty(&root->inodes)))
+			xa_destroy(&root->inodes);
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
@@ -1939,7 +1940,6 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	inode->i_mapping->a_ops = &btree_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
-	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
 			    IO_TREE_BTREE_INODE_IO);
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d0274324c75a..450fe1582f1d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5493,58 +5493,51 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	return err;
 }
 
-static void inode_tree_add(struct btrfs_inode *inode)
+static int btrfs_add_inode_to_root(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
-	struct btrfs_inode *entry;
-	struct rb_node **p;
-	struct rb_node *parent;
-	struct rb_node *new = &inode->rb_node;
-	u64 ino = btrfs_ino(inode);
+	struct btrfs_inode *existing;
+	const u64 ino = btrfs_ino(inode);
+	int ret;
 
 	if (inode_unhashed(&inode->vfs_inode))
-		return;
-	parent = NULL;
+		return 0;
+
+	ret = xa_reserve(&root->inodes, ino, GFP_NOFS);
+	if (ret)
+		return ret;
+
 	spin_lock(&root->inode_lock);
-	p = &root->inode_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct btrfs_inode, rb_node);
+	existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
+	spin_unlock(&root->inode_lock);
 
-		if (ino < btrfs_ino(entry))
-			p = &parent->rb_left;
-		else if (ino > btrfs_ino(entry))
-			p = &parent->rb_right;
-		else {
-			WARN_ON(!(entry->vfs_inode.i_state &
-				  (I_WILL_FREE | I_FREEING)));
-			rb_replace_node(parent, new, &root->inode_tree);
-			RB_CLEAR_NODE(parent);
-			spin_unlock(&root->inode_lock);
-			return;
-		}
+	if (xa_is_err(existing)) {
+		ret = xa_err(existing);
+		ASSERT(ret != -EINVAL);
+		ASSERT(ret != -ENOMEM);
+		return ret;
+	} else if (existing) {
+		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
 	}
-	rb_link_node(new, parent, p);
-	rb_insert_color(new, &root->inode_tree);
-	spin_unlock(&root->inode_lock);
+
+	return 0;
 }
 
-static void inode_tree_del(struct btrfs_inode *inode)
+static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
-	int empty = 0;
+	struct btrfs_inode *entry;
+	bool empty = false;
 
 	spin_lock(&root->inode_lock);
-	if (!RB_EMPTY_NODE(&inode->rb_node)) {
-		rb_erase(&inode->rb_node, &root->inode_tree);
-		RB_CLEAR_NODE(&inode->rb_node);
-		empty = RB_EMPTY_ROOT(&root->inode_tree);
-	}
+	entry = xa_erase(&root->inodes, btrfs_ino(inode));
+	if (entry == inode)
+		empty = xa_empty(&root->inodes);
 	spin_unlock(&root->inode_lock);
 
 	if (empty && btrfs_root_refs(&root->root_item) == 0) {
 		spin_lock(&root->inode_lock);
-		empty = RB_EMPTY_ROOT(&root->inode_tree);
+		empty = xa_empty(&root->inodes);
 		spin_unlock(&root->inode_lock);
 		if (empty)
 			btrfs_add_dead_root(root);
@@ -5613,8 +5606,13 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 
 		ret = btrfs_read_locked_inode(inode, path);
 		if (!ret) {
-			inode_tree_add(BTRFS_I(inode));
-			unlock_new_inode(inode);
+			ret = btrfs_add_inode_to_root(BTRFS_I(inode));
+			if (ret) {
+				iget_failed(inode);
+				inode = ERR_PTR(ret);
+			} else {
+				unlock_new_inode(inode);
+			}
 		} else {
 			iget_failed(inode);
 			/*
@@ -6426,7 +6424,11 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	inode_tree_add(BTRFS_I(inode));
+	ret = btrfs_add_inode_to_root(BTRFS_I(inode));
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto discard;
+	}
 
 	trace_btrfs_inode_new(inode);
 	btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
@@ -8466,7 +8468,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->ordered_tree_last = NULL;
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
-	RB_CLEAR_NODE(&ei->rb_node);
 	init_rwsem(&ei->i_mmap_lock);
 
 	return inode;
@@ -8538,7 +8539,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 		}
 	}
 	btrfs_qgroup_check_reserved_leak(inode);
-	inode_tree_del(inode);
+	btrfs_del_inode_from_root(inode);
 	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
 	btrfs_inode_clear_file_extent_range(inode, 0, (u64)-1);
 	btrfs_put_root(inode->root);
@@ -10857,52 +10858,23 @@ void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 en
  */
 struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
 {
-	struct rb_node *node;
-	struct rb_node *prev;
 	struct btrfs_inode *inode;
+	unsigned long from = min_ino;
 
 	spin_lock(&root->inode_lock);
-again:
-	node = root->inode_tree.rb_node;
-	prev = NULL;
-	while (node) {
-		prev = node;
-		inode = rb_entry(node, struct btrfs_inode, rb_node);
-		if (min_ino < btrfs_ino(inode))
-			node = node->rb_left;
-		else if (min_ino > btrfs_ino(inode))
-			node = node->rb_right;
-		else
+	while (true) {
+		inode = xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
+		if (!inode)
+			break;
+		if (igrab(&inode->vfs_inode))
 			break;
-	}
-
-	if (!node) {
-		while (prev) {
-			inode = rb_entry(prev, struct btrfs_inode, rb_node);
-			if (min_ino <= btrfs_ino(inode)) {
-				node = prev;
-				break;
-			}
-			prev = rb_next(prev);
-		}
-	}
-
-	while (node) {
-		inode = rb_entry(prev, struct btrfs_inode, rb_node);
-		if (igrab(&inode->vfs_inode)) {
-			spin_unlock(&root->inode_lock);
-			return inode;
-		}
-
-		min_ino = btrfs_ino(inode) + 1;
-		if (cond_resched_lock(&root->inode_lock))
-			goto again;
 
-		node = rb_next(node);
+		from = btrfs_ino(inode) + 1;
+		cond_resched_lock(&root->inode_lock);
 	}
 	spin_unlock(&root->inode_lock);
 
-	return NULL;
+	return inode;
 }
 
 static const struct inode_operations btrfs_dir_inode_operations = {
-- 
2.43.0


