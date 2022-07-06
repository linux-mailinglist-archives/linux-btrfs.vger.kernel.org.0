Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377F7568334
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiGFJN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiGFJMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 05:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE226ACC
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 02:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9316E61B27
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A884C341CB
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657098593;
        bh=aNqod55JNWWdq56P6EdyXRW/hhdXmoZOdjAC/KxoT+k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EkmDMi2HbC1WukIlkHMBRo1gTXp0sqFQBa/jYw6ZK4X6Ypkj0Cn6qNLO/xTtG7dMJ
         j04h8JoVwdPuZ59Za4Stkcm6tkMd5bU7f0U/p64k7j2qVLfgXhDTh1Ep5MswjP4lgI
         x4OJUJ4+B1sjD58sJaTwudhP7BRfqlyMk31s1Qc03KR4S94z68ZWfVe6B6Pc7ZpvfG
         Op4m9jZUYjjZDgEkAvkDjKb+LdnsUhvgbGOD/3SatgMXwhjvSyI2XST2tckErZuNFh
         vcQEaX6myieQ/zEtK9K1/QJY4r1dXnNPTGwEfdL40sd1WNkh6SVPxvyvHbMCDHFFuA
         5SlmJzxuKDL2g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix sleep while under a spinlock when inserting a fs root
Date:   Wed,  6 Jul 2022 10:09:46 +0100
Message-Id: <562fd03d99773a3679dbc4924eb0f8fed6c74ccc.1657097693.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657097693.git.fdmanana@suse.com>
References: <cover.1657097693.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When inserting a fs root, at btrfs_insert_fs_root(), we are calling
xa_insert() while holding the spinlock fs_info->fs_roots_lock.

We are passing GFP_NOFS to xa_insert(), but a memory allocation with
GFP_NOFS can sleep, specially likely to happen if we are under memory
pressure. If that happens we will get a splat like the one reported in
a similar case for delayed inodes (see the Link tag below).

Fix this by changing fs_info->fs_roots_lock from a spinlock to a mutex.
Mutexes have an optimistic spinning mode (if CONFIG_MUTEX_SPIN_ON_OWNER=y)
and most of the time our critical sections under this lock are very short,
so it should not have a visible impact.

Link: https://lore.kernel.org/linux-btrfs/c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com/
Fixes: 48b36a602a335c ("btrfs: turn fs_roots_radix in btrfs_fs_info into an XArray")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     | 36 ++++++++++++++++++------------------
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/transaction.c | 14 +++++++-------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7c7d78db27e3..9d8b9badbca7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -680,7 +680,7 @@ struct btrfs_fs_info {
 	struct rb_root global_root_tree;
 
 	/* The xarray that holds all the FS roots */
-	spinlock_t fs_roots_lock;
+	struct mutex fs_roots_mutex;
 	struct xarray fs_roots;
 
 	/* block group cache stuff */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 79aeb5795d72..0da86fba370e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1118,9 +1118,9 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&root->leak_list);
-	spin_lock(&fs_info->fs_roots_lock);
+	mutex_lock(&fs_info->fs_roots_mutex);
 	list_add_tail(&root->leak_list, &fs_info->allocated_roots);
-	spin_unlock(&fs_info->fs_roots_lock);
+	mutex_unlock(&fs_info->fs_roots_mutex);
 #endif
 }
 
@@ -1567,11 +1567,11 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *root;
 
-	spin_lock(&fs_info->fs_roots_lock);
+	mutex_lock(&fs_info->fs_roots_mutex);
 	root = xa_load(&fs_info->fs_roots, (unsigned long)root_id);
 	if (root)
 		root = btrfs_grab_root(root);
-	spin_unlock(&fs_info->fs_roots_lock);
+	mutex_unlock(&fs_info->fs_roots_mutex);
 	return root;
 }
 
@@ -1613,14 +1613,14 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 
-	spin_lock(&fs_info->fs_roots_lock);
+	mutex_lock(&fs_info->fs_roots_mutex);
 	ret = xa_insert(&fs_info->fs_roots, (unsigned long)root->root_key.objectid,
 			root, GFP_NOFS);
 	if (ret == 0) {
 		btrfs_grab_root(root);
 		set_bit(BTRFS_ROOT_REGISTERED, &root->state);
 	}
-	spin_unlock(&fs_info->fs_roots_lock);
+	mutex_unlock(&fs_info->fs_roots_mutex);
 
 	return ret;
 }
@@ -2235,9 +2235,9 @@ void btrfs_put_root(struct btrfs_root *root)
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
 		free_root_extent_buffers(root);
 #ifdef CONFIG_BTRFS_DEBUG
-		spin_lock(&root->fs_info->fs_roots_lock);
+		mutex_lock(&root->fs_info->fs_roots_mutex);
 		list_del_init(&root->leak_list);
-		spin_unlock(&root->fs_info->fs_roots_lock);
+		mutex_unlock(&root->fs_info->fs_roots_mutex);
 #endif
 		kfree(root);
 	}
@@ -3029,7 +3029,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->caching_block_groups);
 	spin_lock_init(&fs_info->delalloc_root_lock);
 	spin_lock_init(&fs_info->trans_lock);
-	spin_lock_init(&fs_info->fs_roots_lock);
+	mutex_init(&fs_info->fs_roots_mutex);
 	spin_lock_init(&fs_info->delayed_iput_lock);
 	spin_lock_init(&fs_info->defrag_inodes_lock);
 	spin_lock_init(&fs_info->super_lock);
@@ -4399,11 +4399,11 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 {
 	bool drop_ref = false;
 
-	spin_lock(&fs_info->fs_roots_lock);
+	mutex_lock(&fs_info->fs_roots_mutex);
 	xa_erase(&fs_info->fs_roots, (unsigned long)root->root_key.objectid);
 	if (test_and_clear_bit(BTRFS_ROOT_REGISTERED, &root->state))
 		drop_ref = true;
-	spin_unlock(&fs_info->fs_roots_lock);
+	mutex_unlock(&fs_info->fs_roots_mutex);
 
 	if (BTRFS_FS_ERROR(fs_info)) {
 		ASSERT(root->log_root == NULL);
@@ -4428,9 +4428,9 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	while (1) {
 		struct btrfs_root *root;
 
-		spin_lock(&fs_info->fs_roots_lock);
+		mutex_lock(&fs_info->fs_roots_mutex);
 		if (!xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
-			spin_unlock(&fs_info->fs_roots_lock);
+			mutex_unlock(&fs_info->fs_roots_mutex);
 			return err;
 		}
 
@@ -4442,7 +4442,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			if (grabbed >= ARRAY_SIZE(roots))
 				break;
 		}
-		spin_unlock(&fs_info->fs_roots_lock);
+		mutex_unlock(&fs_info->fs_roots_mutex);
 
 		for (i = 0; i < grabbed; i++) {
 			if (!roots[i])
@@ -4783,12 +4783,12 @@ static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
 	int grabbed = 0;
 	struct btrfs_root *roots[8];
 
-	spin_lock(&fs_info->fs_roots_lock);
+	mutex_lock(&fs_info->fs_roots_mutex);
 	while ((grabbed = xa_extract(&fs_info->fs_roots, (void **)roots, index,
 				     ULONG_MAX, 8, XA_PRESENT))) {
 		for (int i = 0; i < grabbed; i++)
 			roots[i] = btrfs_grab_root(roots[i]);
-		spin_unlock(&fs_info->fs_roots_lock);
+		mutex_unlock(&fs_info->fs_roots_mutex);
 
 		for (int i = 0; i < grabbed; i++) {
 			if (!roots[i])
@@ -4798,9 +4798,9 @@ static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
 			btrfs_put_root(roots[i]);
 		}
 		index++;
-		spin_lock(&fs_info->fs_roots_lock);
+		mutex_lock(&fs_info->fs_roots_mutex);
 	}
-	spin_unlock(&fs_info->fs_roots_lock);
+	mutex_unlock(&fs_info->fs_roots_mutex);
 	btrfs_free_log_root_tree(NULL, fs_info);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b510fd917424..3e10a2d1b4a5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3665,12 +3665,12 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			 * up the root from that xarray.
 			 */
 
-			spin_lock(&fs_info->fs_roots_lock);
+			mutex_lock(&fs_info->fs_roots_mutex);
 			dead_root = xa_load(&fs_info->fs_roots,
 					    (unsigned long)found_key.objectid);
 			if (dead_root && btrfs_root_refs(&dead_root->root_item) == 0)
 				is_dead_root = 1;
-			spin_unlock(&fs_info->fs_roots_lock);
+			mutex_unlock(&fs_info->fs_roots_mutex);
 
 			if (is_dead_root) {
 				/* prevent this orphan from being found again */
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 06c0a958d114..1283be132776 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -437,15 +437,15 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		 */
 		smp_wmb();
 
-		spin_lock(&fs_info->fs_roots_lock);
+		mutex_lock(&fs_info->fs_roots_mutex);
 		if (root->last_trans == trans->transid && !force) {
-			spin_unlock(&fs_info->fs_roots_lock);
+			mutex_unlock(&fs_info->fs_roots_mutex);
 			return 0;
 		}
 		xa_set_mark(&fs_info->fs_roots,
 			    (unsigned long)root->root_key.objectid,
 			    BTRFS_ROOT_TRANS_TAG);
-		spin_unlock(&fs_info->fs_roots_lock);
+		mutex_unlock(&fs_info->fs_roots_mutex);
 		root->last_trans = trans->transid;
 
 		/* this is pretty tricky.  We don't want to
@@ -1411,7 +1411,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	 */
 	ASSERT(trans->transaction->state == TRANS_STATE_COMMIT_DOING);
 
-	spin_lock(&fs_info->fs_roots_lock);
+	mutex_lock(&fs_info->fs_roots_mutex);
 	xa_for_each_marked(&fs_info->fs_roots, index, root, BTRFS_ROOT_TRANS_TAG) {
 		int ret;
 
@@ -1426,7 +1426,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 		xa_clear_mark(&fs_info->fs_roots,
 			      (unsigned long)root->root_key.objectid,
 			      BTRFS_ROOT_TRANS_TAG);
-		spin_unlock(&fs_info->fs_roots_lock);
+		mutex_unlock(&fs_info->fs_roots_mutex);
 
 		btrfs_free_log(trans, root);
 		ret = btrfs_update_reloc_root(trans, root);
@@ -1447,10 +1447,10 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 					&root->root_key, &root->root_item);
 		if (ret)
 			return ret;
-		spin_lock(&fs_info->fs_roots_lock);
+		mutex_lock(&fs_info->fs_roots_mutex);
 		btrfs_qgroup_free_meta_all_pertrans(root);
 	}
-	spin_unlock(&fs_info->fs_roots_lock);
+	mutex_unlock(&fs_info->fs_roots_mutex);
 	return 0;
 }
 
-- 
2.35.1

