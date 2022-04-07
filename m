Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA504F83BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbiDGPlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbiDGPll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 11:41:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469171EADD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 08:39:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3D791F860;
        Thu,  7 Apr 2022 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649345980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNlBikwTLbLGN+UyyzI9kDET7gYAsRZ2FqKwd1QqNMA=;
        b=X6V3ts3lMWmrZLYR6jUoAiBKVw5X0rnR1Fsa2VTdXdTsqaf4lrRPH5fAqBFrE8KyrDn6Yd
        UgVJRXiRr4Mf9mHAjJmBl6NSdViydzrh9si8CzYqyNDltQwGKtRfBRYgWNLInOQ2qGstRt
        Yn6/I7MPBt3ifRCNEmVTgXBiyKBPYhI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAAD913A66;
        Thu,  7 Apr 2022 15:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gA33L7sFT2LpdQAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 07 Apr 2022 15:39:39 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 1/6] Turn delayed_nodes_tree into delayed_nodes_xarray in btrfs_root
Date:   Thu,  7 Apr 2022 17:38:49 +0200
Message-Id: <20220407153855.21089-2-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153855.21089-1-gniebler@suse.com>
References: <20220407153855.21089-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

… but don't use the XArray API yet.

This works, since the radix_tree_root struct has already been turned into an xarray behind the scenes, via a macro.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 fs/btrfs/ctree.h         | 4 ++--
 fs/btrfs/delayed-inode.c | 8 ++++----
 fs/btrfs/disk-io.c       | 2 +-
 fs/btrfs/inode.c         | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7631b88426e..ccd42a1638b1 100644
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
+	struct xarray delayed_nodes_xarray;
 	/*
 	 * right now this just gets used so that a root has its own devid
 	 * for stat.  It may be used for more later
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 748bf6b0d860..14d95ed62ac3 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -78,7 +78,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	}
 
 	spin_lock(&root->inode_lock);
-	node = radix_tree_lookup(&root->delayed_nodes_tree, ino);
+	node = radix_tree_lookup(&root->delayed_nodes_xarray, ino);
 
 	if (node) {
 		if (btrfs_inode->delayed_node) {
@@ -148,7 +148,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	}
 
 	spin_lock(&root->inode_lock);
-	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
+	ret = radix_tree_insert(&root->delayed_nodes_xarray, ino, node);
 	if (ret == -EEXIST) {
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, node);
@@ -276,7 +276,7 @@ static void __btrfs_release_delayed_node(
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
-		radix_tree_delete(&root->delayed_nodes_tree,
+		radix_tree_delete(&root->delayed_nodes_xarray,
 				  delayed_node->inode_id);
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, delayed_node);
@@ -1876,7 +1876,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 
 	while (1) {
 		spin_lock(&root->inode_lock);
-		n = radix_tree_gang_lookup(&root->delayed_nodes_tree,
+		n = radix_tree_gang_lookup(&root->delayed_nodes_xarray,
 					   (void **)delayed_nodes, inode_id,
 					   ARRAY_SIZE(delayed_nodes));
 		if (!n) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b30309f187cf..efe8b37c9504 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1164,7 +1164,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
 	root->inode_tree = RB_ROOT;
-	INIT_RADIX_TREE(&root->delayed_nodes_tree, GFP_ATOMIC);
+	INIT_RADIX_TREE(&root->delayed_nodes_xarray, GFP_ATOMIC);
 
 	btrfs_init_root_block_rsv(root);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 17d5557f98ec..1db667088380 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3827,7 +3827,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	 * cache.
 	 *
 	 * This is required for both inode re-read from disk and delayed inode
-	 * in delayed_nodes_tree.
+	 * in delayed_nodes_xarray.
 	 */
 	if (BTRFS_I(inode)->last_trans == fs_info->generation)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-- 
2.35.1

