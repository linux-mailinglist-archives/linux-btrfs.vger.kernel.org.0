Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1091D56832D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiGFJNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiGFJMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 05:12:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1BE26AD2
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 02:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5871BB81A69
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AD5C341CA
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657098592;
        bh=Ac3bYY7f2HZ+BhcgHl8xLmX3xV0C1yt3NrAvQ0BsN3M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j2vlzxUwv4GmNIVt5HPnObYx1VH09VHKRc5nTrUJqsNPorYDAGZmBYpABjyhsOSYK
         nb+nJlgD90Az/ENjvcsPkv1macNiiiEfv+PcaaGGA2pY4/PnZpfY7FRkHLQ4IyJAKB
         aDgTA7QRi7Kjw/8mi8soxJ90O/VsShjXVmSaAuiPYpfGhyJ7lMV05/NaqZY27sBawa
         ldwisu9xecgj1ab4ZOd0JF0LJovvb6A334o815A5LFnoqx1i4JMS4eKt82FMZH35hI
         /lHomsLW+Q7tnOLhekmzEjymXPWLw/ueCgRWLju74zaDg/yMv9c0tpqevT0L4TKxZQ
         U1C9QiQ52MStA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix sleep while under a spinlock when allocating delayed inode
Date:   Wed,  6 Jul 2022 10:09:45 +0100
Message-Id: <7a36a9c1d94367f386b18b38f11828c6aaf3a14f.1657097693.git.fdmanana@suse.com>
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

When allocating a delayed inode, at btrfs_get_or_create_delayed_node(),
we are calling xa_insert() while holding the root's inode_lock spinlock.

We are passing GFP_NOFS to xa_insert(), but a memory allocation with
GFP_NOFS can sleep, specially likely to happen if we are under memory
pressure. If that happens we get a splat like the following:

Jul  3 04:08:44 nfsvmf24 kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
Jul  3 04:08:44 nfsvmf24 kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4308, name: nfsd
Jul  3 04:08:44 nfsvmf24 kernel: preempt_count: 1, expected: 0
Jul  3 04:08:44 nfsvmf24 kernel: RCU nest depth: 0, expected: 0
Jul  3 04:08:44 nfsvmf24 kernel: 4 locks held by nfsd/4308:
Jul  3 04:08:44 nfsvmf24 kernel: #0: ffff8881052d4438 (sb_writers#14){.+.+}-{0:0}, at: nfsd4_setattr+0x17f/0x3c0 [nfsd]
Jul  3 04:08:44 nfsvmf24 kernel: #1: ffff888141e5aa50 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at:  nfsd_setattr+0x56a/0xe00 [nfsd]
Jul  3 04:08:44 nfsvmf24 kernel: #2: ffff8881052d4628 (sb_internal#2){.+.+}-{0:0}, at: btrfs_dirty_inode+0xda/0x1d0
Jul  3 04:08:44 nfsvmf24 kernel: #3: ffff888105ed6628 (&root->inode_lock){+.+.}-{2:2}, at: btrfs_get_or_create_delayed_node+0x27a/0x430

Jul  3 04:08:44 nfsvmf24 kernel: Preemption disabled at:
Jul  3 04:08:44 nfsvmf24 kernel: [<0000000000000000>] 0x0
Jul  3 04:08:44 nfsvmf24 kernel: CPU: 0 PID: 4308 Comm: nfsd Kdump: loaded Not tainted 5.19.0-rc4+ #1
Jul  3 04:08:44 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Jul  3 04:08:45 nfsvmf24 kernel: Call Trace:
Jul  3 04:08:45 nfsvmf24 kernel: <TASK>
Jul  3 04:08:45 nfsvmf24 kernel: dump_stack_lvl+0x57/0x7d
Jul  3 04:08:45 nfsvmf24 kernel: __might_resched.cold+0x222/0x26b
Jul  3 04:08:45 nfsvmf24 kernel: kmem_cache_alloc_lru+0x159/0x2c0
Jul  3 04:08:45 nfsvmf24 kernel: __xas_nomem+0x1a5/0x5d0
Jul  3 04:08:45 nfsvmf24 kernel: ? lock_acquire+0x1bb/0x500
Jul  3 04:08:45 nfsvmf24 kernel: __xa_insert+0xff/0x1d0
Jul  3 04:08:45 nfsvmf24 kernel: ? __xa_cmpxchg+0x1f0/0x1f0
Jul  3 04:08:45 nfsvmf24 kernel: ? lockdep_init_map_type+0x2c3/0x7b0
Jul  3 04:08:45 nfsvmf24 kernel: ? rwlock_bug.part.0+0x90/0x90
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_get_or_create_delayed_node+0x295/0x430
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_delayed_update_inode+0x24/0x670
Jul  3 04:08:45 nfsvmf24 kernel: ? btrfs_check_and_init_root_item+0x1f0/0x1f0
Jul  3 04:08:45 nfsvmf24 kernel: ? start_transaction+0x219/0x12d0
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_update_inode+0x1aa/0x430
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_dirty_inode+0xf7/0x1d0
Jul  3 04:08:45 nfsvmf24 kernel: btrfs_setattr+0x928/0x1400
Jul  3 04:08:45 nfsvmf24 kernel: ? mark_held_locks+0x9e/0xe0
Jul  3 04:08:45 nfsvmf24 kernel: ? _raw_spin_unlock+0x29/0x40
Jul  3 04:08:45 nfsvmf24 kernel: ? btrfs_cont_expand+0x9a0/0x9a0
Jul  3 04:08:45 nfsvmf24 kernel: ? fh_update+0x1e0/0x1e0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? current_time+0x88/0xd0
Jul  3 04:08:45 nfsvmf24 kernel: ? timestamp_truncate+0x230/0x230
Jul  3 04:08:45 nfsvmf24 kernel: notify_change+0x4b3/0xe40
Jul  3 04:08:45 nfsvmf24 kernel: ? down_write_nested+0xd4/0x130
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_setattr+0x984/0xe00 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: nfsd_setattr+0x984/0xe00 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_permission+0x310/0x310 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? __mnt_want_write+0x192/0x270
Jul  3 04:08:45 nfsvmf24 kernel: nfsd4_setattr+0x1df/0x3c0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? percpu_counter_add_batch+0x79/0x130
Jul  3 04:08:45 nfsvmf24 kernel: nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: nfsd_dispatch+0x4ed/0xc10 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_reserve+0xb5/0x130 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: svc_process_common+0xd3f/0x1b00 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_generic_rpcbind_set+0x4d0/0x4d0 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_svc+0xc50/0xc50 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_sock_secure_port+0x37/0x50 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: ? svc_recv+0x1096/0x2350 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: svc_process+0x361/0x4f0 [sunrpc]
Jul  3 04:08:45 nfsvmf24 kernel: nfsd+0x2d6/0x570 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
Jul  3 04:08:45 nfsvmf24 kernel: kthread+0x2a1/0x340
Jul  3 04:08:45 nfsvmf24 kernel: ? kthread_complete_and_exit+0x20/0x20
Jul  3 04:08:45 nfsvmf24 kernel: ret_from_fork+0x22/0x30
Jul  3 04:08:45 nfsvmf24 kernel: </TASK>
Jul  3 04:08:45 nfsvmf24 kernel:

Fix this by changing root->inode_lock from a spinlock to a mutex.
Mutexes have an optimistic spinning mode (if CONFIG_MUTEX_SPIN_ON_OWNER=y)
and most of the time our critical sections under this lock are very short,
so it should not have a visible impact.

Reported-by: dai.ngo@oracle.com
Link: https://lore.kernel.org/linux-btrfs/c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com/
Fixes: 253bf57555e451 ("btrfs: turn delayed_nodes_tree into an XArray")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h         |  4 ++--
 fs/btrfs/delayed-inode.c | 24 ++++++++++++------------
 fs/btrfs/disk-io.c       |  2 +-
 fs/btrfs/inode.c         | 26 ++++++++++++++------------
 fs/btrfs/relocation.c    | 11 +++++++----
 5 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f7afdfd0bae7..7c7d78db27e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1223,13 +1223,13 @@ struct btrfs_root {
 	spinlock_t log_extents_lock[2];
 	struct list_head logged_list[2];
 
-	spinlock_t inode_lock;
+	struct mutex inode_mutex;
 	/* red-black tree that keeps track of in-memory inodes */
 	struct rb_root inode_tree;
 
 	/*
 	 * Xarray that keeps track of delayed nodes of every inode, protected
-	 * by inode_lock
+	 * by @inode_mutex.
 	 */
 	struct xarray delayed_nodes;
 	/*
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e7c12fe2fda6..48cdf6bcb341 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -65,14 +65,14 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		return node;
 	}
 
-	spin_lock(&root->inode_lock);
+	mutex_lock(&root->inode_mutex);
 	node = xa_load(&root->delayed_nodes, ino);
 
 	if (node) {
 		if (btrfs_inode->delayed_node) {
 			refcount_inc(&node->refs);	/* can be accessed */
 			BUG_ON(btrfs_inode->delayed_node != node);
-			spin_unlock(&root->inode_lock);
+			mutex_unlock(&root->inode_mutex);
 			return node;
 		}
 
@@ -99,10 +99,10 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 			node = NULL;
 		}
 
-		spin_unlock(&root->inode_lock);
+		mutex_unlock(&root->inode_mutex);
 		return node;
 	}
-	spin_unlock(&root->inode_lock);
+	mutex_unlock(&root->inode_mutex);
 
 	return NULL;
 }
@@ -129,17 +129,17 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		/* Cached in the inode and can be accessed */
 		refcount_set(&node->refs, 2);
 
-		spin_lock(&root->inode_lock);
+		mutex_lock(&root->inode_mutex);
 		ret = xa_insert(&root->delayed_nodes, ino, node, GFP_NOFS);
 		if (ret) {
-			spin_unlock(&root->inode_lock);
+			mutex_unlock(&root->inode_mutex);
 			kmem_cache_free(delayed_node_cache, node);
 			if (ret != -EBUSY)
 				return ERR_PTR(ret);
 		}
 	} while (ret);
 	btrfs_inode->delayed_node = node;
-	spin_unlock(&root->inode_lock);
+	mutex_unlock(&root->inode_mutex);
 
 	return node;
 }
@@ -252,14 +252,14 @@ static void __btrfs_release_delayed_node(
 	if (refcount_dec_and_test(&delayed_node->refs)) {
 		struct btrfs_root *root = delayed_node->root;
 
-		spin_lock(&root->inode_lock);
+		mutex_lock(&root->inode_mutex);
 		/*
 		 * Once our refcount goes to zero, nobody is allowed to bump it
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
 		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
-		spin_unlock(&root->inode_lock);
+		mutex_unlock(&root->inode_mutex);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
 }
@@ -1954,9 +1954,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 	while (1) {
 		int n = 0;
 
-		spin_lock(&root->inode_lock);
+		mutex_lock(&root->inode_mutex);
 		if (xa_empty(&root->delayed_nodes)) {
-			spin_unlock(&root->inode_lock);
+			mutex_unlock(&root->inode_mutex);
 			return;
 		}
 
@@ -1973,7 +1973,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 				break;
 		}
 		index++;
-		spin_unlock(&root->inode_lock);
+		mutex_unlock(&root->inode_mutex);
 
 		for (int i = 0; i < n; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68e..79aeb5795d72 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1079,7 +1079,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&root->reloc_dirty_list);
 	INIT_LIST_HEAD(&root->logged_list[0]);
 	INIT_LIST_HEAD(&root->logged_list[1]);
-	spin_lock_init(&root->inode_lock);
+	mutex_init(&root->inode_mutex);
 	spin_lock_init(&root->delalloc_lock);
 	spin_lock_init(&root->ordered_extent_lock);
 	spin_lock_init(&root->accounting_lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b86be4c3513d..b510fd917424 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4496,8 +4496,8 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 	if (!BTRFS_FS_ERROR(fs_info))
 		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
 
-	spin_lock(&root->inode_lock);
 again:
+	mutex_lock(&root->inode_mutex);
 	node = root->inode_tree.rb_node;
 	prev = NULL;
 	while (node) {
@@ -4526,7 +4526,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 		objectid = btrfs_ino(entry) + 1;
 		inode = igrab(&entry->vfs_inode);
 		if (inode) {
-			spin_unlock(&root->inode_lock);
+			mutex_unlock(&root->inode_mutex);
 			if (atomic_read(&inode->i_count) > 1)
 				d_prune_aliases(inode);
 			/*
@@ -4535,16 +4535,18 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 			 */
 			iput(inode);
 			cond_resched();
-			spin_lock(&root->inode_lock);
 			goto again;
 		}
 
-		if (cond_resched_lock(&root->inode_lock))
+		if (need_resched()) {
+			mutex_unlock(&root->inode_mutex);
+			cond_resched();
 			goto again;
+		}
 
 		node = rb_next(node);
 	}
-	spin_unlock(&root->inode_lock);
+	mutex_unlock(&root->inode_mutex);
 }
 
 int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
@@ -5551,7 +5553,7 @@ static void inode_tree_add(struct inode *inode)
 	if (inode_unhashed(inode))
 		return;
 	parent = NULL;
-	spin_lock(&root->inode_lock);
+	mutex_lock(&root->inode_mutex);
 	p = &root->inode_tree.rb_node;
 	while (*p) {
 		parent = *p;
@@ -5566,13 +5568,13 @@ static void inode_tree_add(struct inode *inode)
 				  (I_WILL_FREE | I_FREEING)));
 			rb_replace_node(parent, new, &root->inode_tree);
 			RB_CLEAR_NODE(parent);
-			spin_unlock(&root->inode_lock);
+			mutex_unlock(&root->inode_mutex);
 			return;
 		}
 	}
 	rb_link_node(new, parent, p);
 	rb_insert_color(new, &root->inode_tree);
-	spin_unlock(&root->inode_lock);
+	mutex_unlock(&root->inode_mutex);
 }
 
 static void inode_tree_del(struct btrfs_inode *inode)
@@ -5580,18 +5582,18 @@ static void inode_tree_del(struct btrfs_inode *inode)
 	struct btrfs_root *root = inode->root;
 	int empty = 0;
 
-	spin_lock(&root->inode_lock);
+	mutex_lock(&root->inode_mutex);
 	if (!RB_EMPTY_NODE(&inode->rb_node)) {
 		rb_erase(&inode->rb_node, &root->inode_tree);
 		RB_CLEAR_NODE(&inode->rb_node);
 		empty = RB_EMPTY_ROOT(&root->inode_tree);
 	}
-	spin_unlock(&root->inode_lock);
+	mutex_unlock(&root->inode_mutex);
 
 	if (empty && btrfs_root_refs(&root->root_item) == 0) {
-		spin_lock(&root->inode_lock);
+		mutex_lock(&root->inode_mutex);
 		empty = RB_EMPTY_ROOT(&root->inode_tree);
-		spin_unlock(&root->inode_lock);
+		mutex_unlock(&root->inode_mutex);
 		if (empty)
 			btrfs_add_dead_root(root);
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a6dc827e75af..e3336a3c8f47 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -956,8 +956,8 @@ static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
 	struct btrfs_inode *entry;
 	struct inode *inode;
 
-	spin_lock(&root->inode_lock);
 again:
+	mutex_lock(&root->inode_mutex);
 	node = root->inode_tree.rb_node;
 	prev = NULL;
 	while (node) {
@@ -985,17 +985,20 @@ static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
 		entry = rb_entry(node, struct btrfs_inode, rb_node);
 		inode = igrab(&entry->vfs_inode);
 		if (inode) {
-			spin_unlock(&root->inode_lock);
+			mutex_unlock(&root->inode_mutex);
 			return inode;
 		}
 
 		objectid = btrfs_ino(entry) + 1;
-		if (cond_resched_lock(&root->inode_lock))
+		if (need_resched()) {
+			mutex_unlock(&root->inode_mutex);
+			cond_resched();
 			goto again;
+		}
 
 		node = rb_next(node);
 	}
-	spin_unlock(&root->inode_lock);
+	mutex_unlock(&root->inode_mutex);
 	return NULL;
 }
 
-- 
2.35.1

