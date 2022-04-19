Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5E506DCE
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiDSNkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352149AbiDSNka (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 09:40:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563537A83
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 06:37:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 725851F74F;
        Tue, 19 Apr 2022 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650375465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QMApu4nAXNvauGKNEMa96AAt3zAWISepWxSJKeIKcHM=;
        b=Ov5TZJGn4oPMiWkCzYayjTUJImwgTDyEd07fsx/HbJITwmxlM9XGSIKNNPovw5XblzbqG9
        FEgMIu/OIvFCPBwkZPV8sb3QsVNYSCpo2TUharNnNDM32nppnsdyyOfm7rRvQII15PNpkG
        A9apG7Rgdx18ZAc4NHDZXBmSlt1Fsbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B45F139BE;
        Tue, 19 Apr 2022 13:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nrnSECm7XmJ9DAAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 19 Apr 2022 13:37:45 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH v4] btrfs: Turn delayed_nodes_tree into an XArray
Date:   Tue, 19 Apr 2022 15:37:41 +0200
Message-Id: <20220419133741.23849-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

… in the btrfs_root struct and adjust all usages of this object to use the
XArray API, because it is notionally easier to use and unserstand, as it
provides array semantics, and also takes care of locking for us, further
simplifying the code.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---

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
 fs/btrfs/ctree.h         |  4 +--
 fs/btrfs/delayed-inode.c | 78 +++++++++++++++++++---------------------
 fs/btrfs/disk-io.c       |  2 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 41 insertions(+), 45 deletions(-)

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
index 748bf6b0d860..ca0d626a29ff 100644
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
@@ -128,36 +128,29 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	u64 ino = btrfs_ino(btrfs_inode);
 	int ret;
 
-again:
-	node = btrfs_get_delayed_node(btrfs_inode);
-	if (node)
-		return node;
-
-	node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
-	if (!node)
-		return ERR_PTR(-ENOMEM);
-	btrfs_init_delayed_node(node, root, ino);
+        do {
+		node = btrfs_get_delayed_node(btrfs_inode);
+		if (node)
+			return node;
 
-	/* cached in the btrfs inode and can be accessed */
-	refcount_set(&node->refs, 2);
+		node = kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
+		if (!node)
+			return ERR_PTR(-ENOMEM);
+		btrfs_init_delayed_node(node, root, ino);
 
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(ret);
-	}
+		/* cached in the btrfs inode and can be accessed */
+		refcount_set(&node->refs, 2);
 
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
+	} while (ret);
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);
-	radix_tree_preload_end();
 
 	return node;
 }
@@ -276,8 +269,7 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
-		radix_tree_delete(&root->delayed_nodes_tree,
-				  delayed_node->inode_id);
+		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
@@ -1870,29 +1862,33 @@ void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
 
 void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 {
-	u64 inode_id = 0;
+	unsigned long index = 0;
+	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_node *delayed_nodes[8];
 	int i, n;
 
 	while (1) {
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
+		n = 0;
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
+                        }
+			if (n >= ARRAY_SIZE(delayed_nodes))
+				break;
 		}
+		index++;
 		spin_unlock(&root->inode_lock);
 
 		for (i = 0; i < n; i++) {
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
2.35.1

