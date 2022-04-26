Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B950FA17
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 12:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiDZKUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348830AbiDZKS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 06:18:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9575F7C7B1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 02:43:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FA561F388;
        Tue, 26 Apr 2022 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650966187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4E1ttIWZLjooEQacxBfMyAKxY8M4vC4mYoa0rYPwsIU=;
        b=kQ6cA+DqdPGq0JrEBgDbmoz2Zs9xBrBELNqXBCuIADV8zA+rELiC6p4d7Vums3dKYsog7i
        O5Huurt2eMewYjq0svTbhhW1n7MiCUbSb7/IKdbPkPmB/YmjUeOoNOlGdKELxDoJO5zsKL
        z5HN3xqs/uQdcu3mm7p4tTqJeoWVVIs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2682D13223;
        Tue, 26 Apr 2022 09:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zoQZCKu+Z2JGPgAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 26 Apr 2022 09:43:07 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH v6] btrfs: Turn delayed_nodes_tree into an XArray
Date:   Tue, 26 Apr 2022 11:43:04 +0200
Message-Id: <20220426094304.7952-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

… in the btrfs_root struct and adjust all usages of this object to use the
XArray API, because it is notionally easier to use and unserstand, as it
provides array semantics, and also takes care of locking for us, further
simplifying the code.

Also use the opportunity to do some light refactoring.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---

Changes from v5:
 - Fixed whitespace issues (Roman & Nikolay)
 - Moved declaration and initialisation of ints inside loops (Nikolay)
 
Changes from v4:
 - Fixed breaking syntax error

Changes from v3:
 - Replaced goto-label construct with do-while loop (Nikolay)
 - Replaced `break` with equivalent `return` for better understandability (Nikolay)
 - Made use of `delayed_nodes` array more efficient (Nikolay)

Changes from v2:
 - Fixed uninitialised index variable (Nikolay)
 - Fixed missing storage of node in array (Nikolay)
 - Improved commit message to motivate patch (David)

Changes from v1:
 - Reworked patch set into single patch (David)
 - New member name `delayed_nodes` is independent of data strutcture used (David)
 - Shortened commit message and made it start with 'btrfs:' (David)

---
 fs/btrfs/ctree.h         |  4 +-
 fs/btrfs/delayed-inode.c | 83 +++++++++++++++++++---------------------
 fs/btrfs/disk-io.c       |  2 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7631b88426e..9377dded9679 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1224,10 +1224,10 @@ struct btrfs_root {
 	struct rb_root inode_tree;
 
 	/*
-	 * radix tree that keeps track of delayed nodes of every inode,
+	 * XArray that keeps track of delayed nodes of every inode,
 	 * protected by inode_lock
 	 */
-	struct radix_tree_root delayed_nodes_tree;
+	struct xarray delayed_nodes;
 	/*
 	 * right now this just gets used so that a root has its own devid
 	 * for stat.  It may be used for more later
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 748bf6b0d860..8d302f6a0557 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -78,7 +78,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	}
 
 	spin_lock(&root->inode_lock);
-	node = radix_tree_lookup(&root->delayed_nodes_tree, ino);
+	node = xa_load(&root->delayed_nodes, ino);
 
 	if (node) {
 		if (btrfs_inode->delayed_node) {
@@ -90,9 +90,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 
 		/*
 		 * It's possible that we're racing into the middle of removing
-		 * this node from the radix tree.  In this case, the refcount
+		 * this node from the XArray.  In this case, the refcount
 		 * was zero and it should never go back to one.  Just return
-		 * NULL like it was never in the radix at all; our release
+		 * NULL like it was never in the XArray at all; our release
 		 * function is in the process of removing it.
 		 *
 		 * Some implementations of refcount_inc refuse to bump the
@@ -100,7 +100,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 * here, refcount_inc() may decide to just WARN_ONCE() instead
 		 * of actually bumping the refcount.
 		 *
-		 * If this node is properly in the radix, we want to bump the
+		 * If this node is properly in the XArray, we want to bump the
 		 * refcount twice, once for the inode and once for this get
 		 * operation.
 		 */
@@ -128,36 +128,30 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
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
+		/* cached in the btrfs inode and can be accessed */
+		refcount_set(&node->refs, 2);
 
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(ret);
-	}
-
-	spin_lock(&root->inode_lock);
-	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
-	if (ret == -EEXIST) {
-		spin_unlock(&root->inode_lock);
-		kmem_cache_free(delayed_node_cache, node);
-		radix_tree_preload_end();
-		goto again;
-	}
+		spin_lock(&root->inode_lock);
+		ret = xa_insert(&root->delayed_nodes, ino, node, GFP_NOFS);
+		if (ret) {
+			spin_unlock(&root->inode_lock);
+			kmem_cache_free(delayed_node_cache, node);
+			if (ret != -EBUSY)
+				return ERR_PTR(ret);
+		}
+	} while (ret);
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);
-	radix_tree_preload_end();
 
 	return node;
 }
@@ -276,8 +270,7 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
-		radix_tree_delete(&root->delayed_nodes_tree,
-				  delayed_node->inode_id);
+		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
@@ -1870,32 +1863,36 @@ void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 
 void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 {
-	u64 inode_id = 0;
+	unsigned long index = 0;
+	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_node *delayed_nodes[8];
-	int i, n;
 
 	while (1) {
+		int n = 0;
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
+		xa_for_each_start(&root->delayed_nodes, index,
+				  delayed_node, index) {
 			/*
 			 * Don't increase refs in case the node is dead and
 			 * about to be removed from the tree in the loop below
 			 */
-			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
-				delayed_nodes[i] = NULL;
+			if (refcount_inc_not_zero(&delayed_node->refs)) {
+				delayed_nodes[n] = delayed_node;
+				n++;
+			}
+			if (n >= ARRAY_SIZE(delayed_nodes))
+				break;
 		}
+		index++;
 		spin_unlock(&root->inode_lock);
 
-		for (i = 0; i < n; i++) {
+		for (int i = 0; i < n; i++) {
 			if (!delayed_nodes[i])
 				continue;
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 126f244cdf88..913261481c1a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1164,7 +1164,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
 	root->inode_tree = RB_ROOT;
-	INIT_RADIX_TREE(&root->delayed_nodes_tree, GFP_ATOMIC);
+	xa_init_flags(&root->delayed_nodes, GFP_ATOMIC);
 
 	btrfs_init_root_block_rsv(root);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5082b9c70f8c..50a699ece606 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3826,7 +3826,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	 * cache.
 	 *
 	 * This is required for both inode re-read from disk and delayed inode
-	 * in delayed_nodes_tree.
+	 * in the delayed_nodes XArray.
 	 */
 	if (BTRFS_I(inode)->last_trans == fs_info->generation)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-- 
2.35.3

