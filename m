Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36666510B7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbiDZVso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355544AbiDZVsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 17:48:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94F2D1EA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 14:45:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7141210E8;
        Tue, 26 Apr 2022 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651009529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NS9Pmsok2N4FDc8os9H9YXEI+ygGyJzT4sDdX7OA0Tc=;
        b=LsUJ3IpFMPqe+NkFXl5F8yjgIi+g1x7QDinR4Q/Whxf+zMzLxPM/d7/Tseq4LOxKGed5CV
        EPxyCkNOtIEX16gymg19xVWMMkZxgFiEFn4FHED+nv+AeXlTG7xFPEXhQzLktYwIhx/7P3
        7al9Ram4D75nZ7LXhpvb/2H8ixuz3+A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E20213AD5;
        Tue, 26 Apr 2022 21:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rvwUIflnaGIScQAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 26 Apr 2022 21:45:29 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an XArray
Date:   Tue, 26 Apr 2022 23:45:25 +0200
Message-Id: <20220426214525.14192-1-gniebler@suse.com>
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

… rename it to simply fs_roots and adjust all usages of this object to use
the XArray API, because it is notionally easier to use and unserstand, as
it provides array semantics, and also takes care of locking for us,
further simplifying the code.

Also do some refactoring, esp. where the API change requires largely
rewriting some functions, anyway.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 fs/btrfs/ctree.h       |   5 +-
 fs/btrfs/disk-io.c     | 176 ++++++++++++++++++++---------------------
 fs/btrfs/inode.c       |  13 +--
 fs/btrfs/transaction.c |  67 +++++++---------
 4 files changed, 126 insertions(+), 135 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7631b88426e..c1c0a2f5a7b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -675,8 +675,9 @@ struct btrfs_fs_info {
 	rwlock_t global_root_lock;
 	struct rb_root global_root_tree;
 
-	spinlock_t fs_roots_radix_lock;
-	struct radix_tree_root fs_roots_radix;
+	/* The XArray that holds all the FS roots */
+	spinlock_t fs_roots_lock;
+	struct xarray fs_roots;
 
 	/* block group cache stuff */
 	spinlock_t block_group_cache_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 126f244cdf88..a8577f659f66 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1216,9 +1216,9 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&root->leak_list);
-	spin_lock(&fs_info->fs_roots_radix_lock);
+	spin_lock(&fs_info->fs_roots_lock);
 	list_add_tail(&root->leak_list, &fs_info->allocated_roots);
-	spin_unlock(&fs_info->fs_roots_radix_lock);
+	spin_unlock(&fs_info->fs_roots_lock);
 #endif
 }
 
@@ -1648,12 +1648,11 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *root;
 
-	spin_lock(&fs_info->fs_roots_radix_lock);
-	root = radix_tree_lookup(&fs_info->fs_roots_radix,
-				 (unsigned long)root_id);
+	spin_lock(&fs_info->fs_roots_lock);
+	root = xa_load(&fs_info->fs_roots, (unsigned long)root_id);
 	if (root)
 		root = btrfs_grab_root(root);
-	spin_unlock(&fs_info->fs_roots_radix_lock);
+	spin_unlock(&fs_info->fs_roots_lock);
 	return root;
 }
 
@@ -1695,20 +1694,15 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret)
-		return ret;
-
-	spin_lock(&fs_info->fs_roots_radix_lock);
-	ret = radix_tree_insert(&fs_info->fs_roots_radix,
-				(unsigned long)root->root_key.objectid,
-				root);
+	spin_lock(&fs_info->fs_roots_lock);
+	ret = xa_insert(&fs_info->fs_roots,
+			(unsigned long)root->root_key.objectid,
+			root, GFP_NOFS);
 	if (ret == 0) {
 		btrfs_grab_root(root);
 		set_bit(BTRFS_ROOT_IN_RADIX, &root->state);
 	}
-	spin_unlock(&fs_info->fs_roots_radix_lock);
-	radix_tree_preload_end();
+	spin_unlock(&fs_info->fs_roots_lock);
 
 	return ret;
 }
@@ -2336,9 +2330,9 @@ void btrfs_put_root(struct btrfs_root *root)
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
 		free_root_extent_buffers(root);
 #ifdef CONFIG_BTRFS_DEBUG
-		spin_lock(&root->fs_info->fs_roots_radix_lock);
+		spin_lock(&root->fs_info->fs_roots_lock);
 		list_del_init(&root->leak_list);
-		spin_unlock(&root->fs_info->fs_roots_radix_lock);
+		spin_unlock(&root->fs_info->fs_roots_lock);
 #endif
 		kfree(root);
 	}
@@ -2346,28 +2340,23 @@ void btrfs_put_root(struct btrfs_root *root)
 
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 {
-	int ret;
-	struct btrfs_root *gang[8];
-	int i;
+	struct btrfs_root *root;
+	unsigned long index = 0;
 
 	while (!list_empty(&fs_info->dead_roots)) {
-		gang[0] = list_entry(fs_info->dead_roots.next,
-				     struct btrfs_root, root_list);
-		list_del(&gang[0]->root_list);
+		root = list_entry(fs_info->dead_roots.next,
+				  struct btrfs_root, root_list);
+		list_del(&root->root_list);
 
-		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
-			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
-		btrfs_put_root(gang[0]);
+		if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state))
+			btrfs_drop_and_free_fs_root(fs_info, root);
+		btrfs_put_root(root);
 	}
 
-	while (1) {
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
-					     (void **)gang, 0,
-					     ARRAY_SIZE(gang));
-		if (!ret)
-			break;
-		for (i = 0; i < ret; i++)
-			btrfs_drop_and_free_fs_root(fs_info, gang[i]);
+	while (!xa_empty(&fs_info->fs_roots)) {
+		xa_for_each(&fs_info->fs_roots, index, root) {
+			btrfs_drop_and_free_fs_root(fs_info, root);
+		}
 	}
 }
 
@@ -3132,7 +3121,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
-	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
+	xa_init_flags(&fs_info->fs_roots, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
 	INIT_LIST_HEAD(&fs_info->trans_list);
 	INIT_LIST_HEAD(&fs_info->dead_roots);
@@ -3141,7 +3130,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->caching_block_groups);
 	spin_lock_init(&fs_info->delalloc_root_lock);
 	spin_lock_init(&fs_info->trans_lock);
-	spin_lock_init(&fs_info->fs_roots_radix_lock);
+	spin_lock_init(&fs_info->fs_roots_lock);
 	spin_lock_init(&fs_info->delayed_iput_lock);
 	spin_lock_init(&fs_info->defrag_inodes_lock);
 	spin_lock_init(&fs_info->super_lock);
@@ -3372,7 +3361,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	/*
 	 * btrfs_find_orphan_roots() is responsible for finding all the dead
 	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
-	 * them into the fs_info->fs_roots_radix tree. This must be done before
+	 * them into the fs_info->fs_roots. This must be done before
 	 * calling btrfs_orphan_cleanup() on the tree root. If we don't do it
 	 * first, then btrfs_orphan_cleanup() will delete a dead root's orphan
 	 * item before the root's tree is deleted - this means that if we unmount
@@ -4491,12 +4480,12 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 {
 	bool drop_ref = false;
 
-	spin_lock(&fs_info->fs_roots_radix_lock);
-	radix_tree_delete(&fs_info->fs_roots_radix,
-			  (unsigned long)root->root_key.objectid);
+	spin_lock(&fs_info->fs_roots_lock);
+	xa_erase(&fs_info->fs_roots,
+		 (unsigned long)root->root_key.objectid);
 	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
 		drop_ref = true;
-	spin_unlock(&fs_info->fs_roots_radix_lock);
+	spin_unlock(&fs_info->fs_roots_lock);
 
 	if (BTRFS_FS_ERROR(fs_info)) {
 		ASSERT(root->log_root == NULL);
@@ -4512,50 +4501,54 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 {
-	u64 root_objectid = 0;
-	struct btrfs_root *gang[8];
-	int i = 0;
+	struct btrfs_root *roots[8];
+	unsigned long index = 0;
+	int i;
 	int err = 0;
-	unsigned int ret = 0;
+	int grabbed;
 
 	while (1) {
-		spin_lock(&fs_info->fs_roots_radix_lock);
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
-					     (void **)gang, root_objectid,
-					     ARRAY_SIZE(gang));
-		if (!ret) {
-			spin_unlock(&fs_info->fs_roots_radix_lock);
+		struct btrfs_root *root;
+
+		spin_lock(&fs_info->fs_roots_lock);
+		if (!xa_find(&fs_info->fs_roots, &index,
+			     ULONG_MAX, XA_PRESENT)) {
+			spin_unlock(&fs_info->fs_roots_lock);
 			break;
 		}
-		root_objectid = gang[ret - 1]->root_key.objectid + 1;
 
-		for (i = 0; i < ret; i++) {
-			/* Avoid to grab roots in dead_roots */
-			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
-				gang[i] = NULL;
-				continue;
+		grabbed = 0;
+		xa_for_each_start(&fs_info->fs_roots, index, root,
+				  index) {
+			/* Avoid grabbing roots in dead_roots */
+			if (btrfs_root_refs(&root->root_item) == 0) {
+				roots[grabbed] = NULL;
+			} else {
+				/* Grab all the search results for later use */
+				roots[grabbed] = btrfs_grab_root(root);
 			}
-			/* grab all the search result for later use */
-			gang[i] = btrfs_grab_root(gang[i]);
+			grabbed++;
+			if (grabbed >= ARRAY_SIZE(roots))
+				break;
 		}
-		spin_unlock(&fs_info->fs_roots_radix_lock);
+		spin_unlock(&fs_info->fs_roots_lock);
 
-		for (i = 0; i < ret; i++) {
-			if (!gang[i])
+		for (i = 0; i < grabbed; i++) {
+			if (!roots[i])
 				continue;
-			root_objectid = gang[i]->root_key.objectid;
-			err = btrfs_orphan_cleanup(gang[i]);
+			index = roots[i]->root_key.objectid;
+			err = btrfs_orphan_cleanup(roots[i]);
 			if (err)
 				break;
-			btrfs_put_root(gang[i]);
+			btrfs_put_root(roots[i]);
 		}
-		root_objectid++;
+		index++;
 	}
 
-	/* release the uncleaned roots due to error */
-	for (; i < ret; i++) {
-		if (gang[i])
-			btrfs_put_root(gang[i]);
+	/* Release the roots that remain uncleaned due to error */
+	for (; i < grabbed; i++) {
+		if (roots[i])
+			btrfs_put_root(roots[i]);
 	}
 	return err;
 }
@@ -4872,31 +4865,36 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 
 static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *gang[8];
-	u64 root_objectid = 0;
-	int ret;
+	unsigned long index = 0;
 
-	spin_lock(&fs_info->fs_roots_radix_lock);
-	while ((ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
-					     (void **)gang, root_objectid,
-					     ARRAY_SIZE(gang))) != 0) {
+	spin_lock(&fs_info->fs_roots_lock);
+	while (xa_find(&fs_info->fs_roots,
+		       &index, ULONG_MAX, XA_PRESENT)) {
+		struct btrfs_root *root;
+		struct btrfs_root *roots[8];
 		int i;
+		int grabbed = 0;
 
-		for (i = 0; i < ret; i++)
-			gang[i] = btrfs_grab_root(gang[i]);
-		spin_unlock(&fs_info->fs_roots_radix_lock);
+		xa_for_each_start(&fs_info->fs_roots, index, root,
+				  index) {
+			roots[grabbed] = btrfs_grab_root(root);
+			grabbed++;
+			if (grabbed >= ARRAY_SIZE(roots))
+				break;
+		}
+		spin_unlock(&fs_info->fs_roots_lock);
 
-		for (i = 0; i < ret; i++) {
-			if (!gang[i])
+		for (i = 0; i < grabbed; i++) {
+			if (!roots[i])
 				continue;
-			root_objectid = gang[i]->root_key.objectid;
-			btrfs_free_log(NULL, gang[i]);
-			btrfs_put_root(gang[i]);
+			index = roots[i]->root_key.objectid;
+			btrfs_free_log(NULL, roots[i]);
+			btrfs_put_root(roots[i]);
 		}
-		root_objectid++;
-		spin_lock(&fs_info->fs_roots_radix_lock);
+		index++;
+		spin_lock(&fs_info->fs_roots_lock);
 	}
-	spin_unlock(&fs_info->fs_roots_radix_lock);
+	spin_unlock(&fs_info->fs_roots_lock);
 	btrfs_free_log_root_tree(NULL, fs_info);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5082b9c70f8c..d0ef3a17ce11 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3494,6 +3494,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	u64 last_objectid = 0;
 	int ret = 0, nr_unlink = 0;
 
+	/* Bail out if the cleanup is already running. */
 	if (test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &root->state))
 		return 0;
 
@@ -3576,17 +3577,17 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			 *
 			 * btrfs_find_orphan_roots() ran before us, which has
 			 * found all deleted roots and loaded them into
-			 * fs_info->fs_roots_radix. So here we can find if an
+			 * fs_info->fs_roots. So here we can find if an
 			 * orphan item corresponds to a deleted root by looking
-			 * up the root from that radix tree.
+			 * up the root from that xarray.
 			 */
 
-			spin_lock(&fs_info->fs_roots_radix_lock);
-			dead_root = radix_tree_lookup(&fs_info->fs_roots_radix,
-							 (unsigned long)found_key.objectid);
+			spin_lock(&fs_info->fs_roots_lock);
+			dead_root = xa_load(&fs_info->fs_roots,
+					    (unsigned long)found_key.objectid);
 			if (dead_root && btrfs_root_refs(&dead_root->root_item) == 0)
 				is_dead_root = 1;
-			spin_unlock(&fs_info->fs_roots_radix_lock);
+			spin_unlock(&fs_info->fs_roots_lock);
 
 			if (is_dead_root) {
 				/* prevent this orphan from being found again */
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b008c5110958..ba0f1895a8ea 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -23,7 +23,7 @@
 #include "space-info.h"
 #include "zoned.h"
 
-#define BTRFS_ROOT_TRANS_TAG 0
+#define BTRFS_ROOT_TRANS_TAG XA_MARK_0
 
 /*
  * Transaction states and transitions
@@ -437,15 +437,15 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		 */
 		smp_wmb();
 
-		spin_lock(&fs_info->fs_roots_radix_lock);
+		spin_lock(&fs_info->fs_roots_lock);
 		if (root->last_trans == trans->transid && !force) {
-			spin_unlock(&fs_info->fs_roots_radix_lock);
+			spin_unlock(&fs_info->fs_roots_lock);
 			return 0;
 		}
-		radix_tree_tag_set(&fs_info->fs_roots_radix,
-				   (unsigned long)root->root_key.objectid,
-				   BTRFS_ROOT_TRANS_TAG);
-		spin_unlock(&fs_info->fs_roots_radix_lock);
+		xa_set_mark(&fs_info->fs_roots,
+			    (unsigned long)root->root_key.objectid,
+			    BTRFS_ROOT_TRANS_TAG);
+		spin_unlock(&fs_info->fs_roots_lock);
 		root->last_trans = trans->transid;
 
 		/* this is pretty tricky.  We don't want to
@@ -487,11 +487,9 @@ void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 	spin_unlock(&cur_trans->dropped_roots_lock);
 
 	/* Make sure we don't try to update the root at commit time */
-	spin_lock(&fs_info->fs_roots_radix_lock);
-	radix_tree_tag_clear(&fs_info->fs_roots_radix,
-			     (unsigned long)root->root_key.objectid,
-			     BTRFS_ROOT_TRANS_TAG);
-	spin_unlock(&fs_info->fs_roots_radix_lock);
+	xa_clear_mark(&fs_info->fs_roots,
+		      (unsigned long)root->root_key.objectid,
+		      BTRFS_ROOT_TRANS_TAG);
 }
 
 int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
@@ -1404,9 +1402,8 @@ void btrfs_add_dead_root(struct btrfs_root *root)
 static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *gang[8];
-	int i;
-	int ret;
+	struct btrfs_root *root;
+	unsigned long index;
 
 	/*
 	 * At this point no one can be using this transaction to modify any tree
@@ -1414,17 +1411,11 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	 */
 	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
 
-	spin_lock(&fs_info->fs_roots_radix_lock);
-	while (1) {
-		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
-						 (void **)gang, 0,
-						 ARRAY_SIZE(gang),
-						 BTRFS_ROOT_TRANS_TAG);
-		if (ret == 0)
-			break;
-		for (i = 0; i < ret; i++) {
-			struct btrfs_root *root = gang[i];
-			int ret2;
+	spin_lock(&fs_info->fs_roots_lock);
+	while (xa_marked(&fs_info->fs_roots, BTRFS_ROOT_TRANS_TAG)) {
+		xa_for_each_marked(&fs_info->fs_roots, index, root,
+				   BTRFS_ROOT_TRANS_TAG) {
+			int ret;
 
 			/*
 			 * At this point we can neither have tasks logging inodes
@@ -1434,15 +1425,15 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			ASSERT(atomic_read(&root->log_commit[0]) == 0);
 			ASSERT(atomic_read(&root->log_commit[1]) == 0);
 
-			radix_tree_tag_clear(&fs_info->fs_roots_radix,
-					(unsigned long)root->root_key.objectid,
-					BTRFS_ROOT_TRANS_TAG);
-			spin_unlock(&fs_info->fs_roots_radix_lock);
+			xa_clear_mark(&fs_info->fs_roots,
+				      (unsigned long)root->root_key.objectid,
+				      BTRFS_ROOT_TRANS_TAG);
+			spin_unlock(&fs_info->fs_roots_lock);
 
 			btrfs_free_log(trans, root);
-			ret2 = btrfs_update_reloc_root(trans, root);
-			if (ret2)
-				return ret2;
+			ret = btrfs_update_reloc_root(trans, root);
+			if (ret)
+				return ret;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
@@ -1455,16 +1446,16 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 						    root->node);
 			}
 
-			ret2 = btrfs_update_root(trans, fs_info->tree_root,
+			ret = btrfs_update_root(trans, fs_info->tree_root,
 						&root->root_key,
 						&root->root_item);
-			if (ret2)
-				return ret2;
-			spin_lock(&fs_info->fs_roots_radix_lock);
+			if (ret)
+				return ret;
+			spin_lock(&fs_info->fs_roots_lock);
 			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
-	spin_unlock(&fs_info->fs_roots_radix_lock);
+	spin_unlock(&fs_info->fs_roots_lock);
 	return 0;
 }
 
-- 
2.35.3

