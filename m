Return-Path: <linux-btrfs+bounces-4898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82E8C2954
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EE41C21DDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E518037;
	Fri, 10 May 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8PhfjuT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C118030
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362386; cv=none; b=su7tQuQmC5Ev9nHpRYVQgYRUyv28HosQvFQuHBXOOGOQVSl0R/GbAFbs6YqjNNpYJbFQ2BE+iqbQJZMZMwzevJDmxnmc/W0epM8WGGhRVO8DBZORO1vynVf4ZaGGsNUmXDSzjO0Nlbzi6fb4wre24ZMJz1vNsYSwNUOS5BGHAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362386; c=relaxed/simple;
	bh=nht686NgOLBcl9jBhFVOfg+3/MThlvWU2VNR77qjeys=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0X8CE5F7hav7nrukdj1DxXM8E4QxxnCXBcZTSmDQiZ9AK4nUhvlJy4jKM2Xuj679jQw6PAUe8rt0r3ggflRP9z/ZEl3FfyZwH5A9sJF5SnqTsOHLqzvaLYHyIMQMFqlWshSVMRW01t53tlz1DrR8FqdHA2MbeArvMLWMKvyoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8PhfjuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02730C113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362385;
	bh=nht686NgOLBcl9jBhFVOfg+3/MThlvWU2VNR77qjeys=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i8PhfjuTKd+6lxMuhfrUUhLU/mfWx2lFG7eOJUCv8bewZRSP+T9v4c5iTEsRIT3od
	 +rBoxvQ8LzfIhnjTetzs3xtzI6N7DuD/BXEivkJxAcWGLuqpNc/5dOjvEO3wZsNn8Z
	 XDyDZtKUa25ptfOHZHK0JTl8/a06Fg/SXOAAIEw08rdGL/wiUjYsQvFD2/3eoNpwdP
	 ta933ZPYqfD7UydYCjxdx6RhgA/LGnaBYj4dGSFoUvvG59EHsZJawS/LCYz/DthWAc
	 9nXmPdETuH9ZlrepMUdiA2pi7Q9rKUG9KruHX5TSl1KCkjggJ7H8q9KaAXKfNzibQb
	 7DWxC9OaS25Ig==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/10] btrfs: remove inode_lock from struct btrfs_root and use xarray locks
Date: Fri, 10 May 2024 18:32:52 +0100
Message-Id: <bc43286bf5deeb32d6dd44cb9f644c074f8570fe.1715362104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715362104.git.fdmanana@suse.com>
References: <cover.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we use the spinlock inode_lock from struct btrfs_root to
serialize access to two different data structures:

1) The delayed inodes xarray (struct btrfs_root::delayed_nodes);
2) The inodes xarray (struct btrfs_root::inodes).

Instead of using our own lock, we can use the spinlock that is part of the
xarray implementation, by using the xa_lock() and xa_unlock() APIs and
using the xarray APIs with the double underscore prefix that don't take
the xarray locks and assume the caller is using xa_lock() and xa_unlock().

So remove the spinlock inode_lock from struct btrfs_root and use the
corresponding xarray locks. This brings 2 benefits:

1) We reduce the size of struct btrfs_root, from 1336 bytes down to
   1328 bytes on a 64 bits release kernel config;

2) We reduce lock contention by not using anymore  the same lock for
   changing two different and unrelated xarrays.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h         |  1 -
 fs/btrfs/delayed-inode.c | 26 ++++++++++++--------------
 fs/btrfs/disk-io.c       |  1 -
 fs/btrfs/inode.c         | 18 ++++++++----------
 4 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aa2568f86dc9..1004cb934b4a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -221,7 +221,6 @@ struct btrfs_root {
 
 	struct list_head root_list;
 
-	spinlock_t inode_lock;
 	/*
 	 * Xarray that keeps track of in-memory inodes, protected by the lock
 	 * @inode_lock.
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 95a0497fa866..40e617c7e8a1 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -77,14 +77,14 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		return node;
 	}
 
-	spin_lock(&root->inode_lock);
+	xa_lock(&root->delayed_nodes);
 	node = xa_load(&root->delayed_nodes, ino);
 
 	if (node) {
 		if (btrfs_inode->delayed_node) {
 			refcount_inc(&node->refs);	/* can be accessed */
 			BUG_ON(btrfs_inode->delayed_node != node);
-			spin_unlock(&root->inode_lock);
+			xa_unlock(&root->delayed_nodes);
 			return node;
 		}
 
@@ -111,10 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 			node = NULL;
 		}
 
-		spin_unlock(&root->inode_lock);
+		xa_unlock(&root->delayed_nodes);
 		return node;
 	}
-	spin_unlock(&root->inode_lock);
+	xa_unlock(&root->delayed_nodes);
 
 	return NULL;
 }
@@ -148,21 +148,21 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		kmem_cache_free(delayed_node_cache, node);
 		return ERR_PTR(-ENOMEM);
 	}
-	spin_lock(&root->inode_lock);
+	xa_lock(&root->delayed_nodes);
 	ptr = xa_load(&root->delayed_nodes, ino);
 	if (ptr) {
 		/* Somebody inserted it, go back and read it. */
-		spin_unlock(&root->inode_lock);
+		xa_unlock(&root->delayed_nodes);
 		kmem_cache_free(delayed_node_cache, node);
 		node = NULL;
 		goto again;
 	}
-	ptr = xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
+	ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
 	btrfs_inode->delayed_node = node;
-	spin_unlock(&root->inode_lock);
+	xa_unlock(&root->delayed_nodes);
 
 	return node;
 }
@@ -275,14 +275,12 @@ static void __btrfs_release_delayed_node(
 	if (refcount_dec_and_test(&delayed_node->refs)) {
 		struct btrfs_root *root = delayed_node->root;
 
-		spin_lock(&root->inode_lock);
+		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
 		/*
 		 * Once our refcount goes to zero, nobody is allowed to bump it
 		 * back up.  We can delete it now.
 		 */
 		ASSERT(refcount_read(&delayed_node->refs) == 0);
-		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
-		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, delayed_node);
 	}
 }
@@ -2057,9 +2055,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 		struct btrfs_delayed_node *node;
 		int count;
 
-		spin_lock(&root->inode_lock);
+		xa_lock(&root->delayed_nodes);
 		if (xa_empty(&root->delayed_nodes)) {
-			spin_unlock(&root->inode_lock);
+			xa_unlock(&root->delayed_nodes);
 			return;
 		}
 
@@ -2076,7 +2074,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			if (count >= ARRAY_SIZE(delayed_nodes))
 				break;
 		}
-		spin_unlock(&root->inode_lock);
+		xa_unlock(&root->delayed_nodes);
 		index++;
 
 		for (int i = 0; i < count; i++) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ed40fe1db53e..d20e400a9ce3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -674,7 +674,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&root->ordered_extents);
 	INIT_LIST_HEAD(&root->ordered_root);
 	INIT_LIST_HEAD(&root->reloc_dirty_list);
-	spin_lock_init(&root->inode_lock);
 	spin_lock_init(&root->delalloc_lock);
 	spin_lock_init(&root->ordered_extent_lock);
 	spin_lock_init(&root->accounting_lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ea9fd4c2b66..4fd41d6b377f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5509,9 +5509,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 			return ret;
 	}
 
-	spin_lock(&root->inode_lock);
 	existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
-	spin_unlock(&root->inode_lock);
 
 	if (xa_is_err(existing)) {
 		ret = xa_err(existing);
@@ -5531,16 +5529,16 @@ static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 	struct btrfs_inode *entry;
 	bool empty = false;
 
-	spin_lock(&root->inode_lock);
-	entry = xa_erase(&root->inodes, btrfs_ino(inode));
+	xa_lock(&root->inodes);
+	entry = __xa_erase(&root->inodes, btrfs_ino(inode));
 	if (entry == inode)
 		empty = xa_empty(&root->inodes);
-	spin_unlock(&root->inode_lock);
+	xa_unlock(&root->inodes);
 
 	if (empty && btrfs_root_refs(&root->root_item) == 0) {
-		spin_lock(&root->inode_lock);
+		xa_lock(&root->inodes);
 		empty = xa_empty(&root->inodes);
-		spin_unlock(&root->inode_lock);
+		xa_unlock(&root->inodes);
 		if (empty)
 			btrfs_add_dead_root(root);
 	}
@@ -10871,7 +10869,7 @@ struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
 	struct btrfs_inode *inode;
 	unsigned long from = min_ino;
 
-	spin_lock(&root->inode_lock);
+	xa_lock(&root->inodes);
 	while (true) {
 		inode = xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
 		if (!inode)
@@ -10880,9 +10878,9 @@ struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
 			break;
 
 		from = btrfs_ino(inode) + 1;
-		cond_resched_lock(&root->inode_lock);
+		cond_resched_lock(&root->inodes.xa_lock);
 	}
-	spin_unlock(&root->inode_lock);
+	xa_unlock(&root->inodes);
 
 	return inode;
 }
-- 
2.43.0


