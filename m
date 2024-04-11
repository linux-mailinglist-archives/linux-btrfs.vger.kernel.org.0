Return-Path: <linux-btrfs+bounces-4154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863158A1C63
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAAD28266E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BB180A79;
	Thu, 11 Apr 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuE61IYO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6C17A92F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852367; cv=none; b=aImGbt0baivUDsaVjHtbP3bD06n+hZN1skcT8ND2maMu6rfIcNpu/hv+gEW7nYJHkY4GINJCCkMr/se4HlRBGDR0mdmOlpVNKhO/Gf1wD2SDopNAgQjcz2qFow7gKTzcsbUoa+J+RrnD+Z1pozZhKjQsBqmyTMcoFbNXdde8QU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852367; c=relaxed/simple;
	bh=966eCP3YqZdY6wqX5xS05eAKsKK7bCQiOk1fU2YpjCc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LV80+gCNN+vOVUPFIUk5X9U//WbD4yvK5HnIKqb0aGvTwu+qDa91ADgAaK7AZHFalRlEwMjXi5yAEhuYpznzzG0phzlnK0k7NR4PVuXl8Ik5qHx5Tk50roqqu/uYkQraQ44v5q6VacYbn9gEa/cc7B8u3kjUfliMrOzqhnPCuIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuE61IYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149EDC113CD
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852367;
	bh=966eCP3YqZdY6wqX5xS05eAKsKK7bCQiOk1fU2YpjCc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YuE61IYOex5gHlOHw+oheS/rt7J4Z16Wn7DNLZa4v6iBVtrVxwpzC4ztOza906nfa
	 V/48hkV9Lt5cnqygS7H/E13l2NsInUsVxyCiydUPT1ZY/FmHcyXEQnMoBhQzsG2D3f
	 /9eSF2kRCxTSySxpm5hEWs7FH75gciesDJLls9WzUi1q6MefpbIMmPM+Ila5YOQ+7y
	 vdB1IvZtWFHzeXuN2vlx3oHD23RBwDcbi189Hpt1owgLmisZ4fTK2FBNCyOuf8YZNd
	 W1bJEkPW8AWtB1XzFShqderV7/BTRt3pJQQVnr8wLgSUBoJlnfSLOJi9VrYk/yW110
	 nbRkRjDFMSm6g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/15] btrfs: export find_next_inode() as btrfs_find_first_inode()
Date: Thu, 11 Apr 2024 17:19:05 +0100
Message-Id: <f6020d8c33aeea495917c26b26812dda8eb27a12.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Export the relocation private helper find_next_inode() to inode.c, as this
same logic is also used at btrfs_prune_dentries() and will be used by an
upcoming change that adds an extent map shrinker. The next patch will
change btrfs_prune_dentries() to use this helper.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |   1 +
 fs/btrfs/inode.c       |  58 +++++++++++++++++++++++
 fs/btrfs/relocation.c  | 105 ++++++++++-------------------------------
 3 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ed8bd15aa3e2..9a87ada7fe52 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -543,6 +543,7 @@ ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
 		       size_t done_before);
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 				  size_t done_before);
+struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d4539b4b8148..9dc41334c3a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10827,6 +10827,64 @@ void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 en
 	ASSERT(ordered == NULL);
 }
 
+/*
+ * Find the first inode with a minimum number.
+ *
+ * @root:	The root to search for.
+ * @min_ino:	The minimum inode number.
+ *
+ * Find the first inode in the @root with a number >= @min_ino and return it.
+ * Returns NULL if no such inode found.
+ */
+struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
+{
+	struct rb_node *node;
+	struct rb_node *prev = NULL;
+	struct btrfs_inode *inode;
+
+	spin_lock(&root->inode_lock);
+again:
+	node = root->inode_tree.rb_node;
+	while (node) {
+		prev = node;
+		inode = rb_entry(node, struct btrfs_inode, rb_node);
+		if (min_ino < btrfs_ino(inode))
+			node = node->rb_left;
+		else if (min_ino > btrfs_ino(inode))
+			node = node->rb_right;
+		else
+			break;
+	}
+
+	if (!node) {
+		while (prev) {
+			inode = rb_entry(prev, struct btrfs_inode, rb_node);
+			if (min_ino <= btrfs_ino(inode)) {
+				node = prev;
+				break;
+			}
+			prev = rb_next(prev);
+		}
+	}
+
+	while (node) {
+		inode = rb_entry(prev, struct btrfs_inode, rb_node);
+		if (igrab(&inode->vfs_inode)) {
+			spin_unlock(&root->inode_lock);
+			return inode;
+		}
+
+		min_ino = btrfs_ino(inode) + 1;
+		if (cond_resched_lock(&root->inode_lock))
+			goto again;
+
+		node = rb_next(node);
+	}
+	spin_unlock(&root->inode_lock);
+
+	return NULL;
+}
+
 static const struct inode_operations btrfs_dir_inode_operations = {
 	.getattr	= btrfs_getattr,
 	.lookup		= btrfs_lookup,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5c9ef6717f84..5b19b41f64a2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -951,60 +951,6 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * helper to find first cached inode with inode number >= objectid
- * in a subvolume
- */
-static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
-{
-	struct rb_node *node;
-	struct rb_node *prev;
-	struct btrfs_inode *entry;
-	struct inode *inode;
-
-	spin_lock(&root->inode_lock);
-again:
-	node = root->inode_tree.rb_node;
-	prev = NULL;
-	while (node) {
-		prev = node;
-		entry = rb_entry(node, struct btrfs_inode, rb_node);
-
-		if (objectid < btrfs_ino(entry))
-			node = node->rb_left;
-		else if (objectid > btrfs_ino(entry))
-			node = node->rb_right;
-		else
-			break;
-	}
-	if (!node) {
-		while (prev) {
-			entry = rb_entry(prev, struct btrfs_inode, rb_node);
-			if (objectid <= btrfs_ino(entry)) {
-				node = prev;
-				break;
-			}
-			prev = rb_next(prev);
-		}
-	}
-	while (node) {
-		entry = rb_entry(node, struct btrfs_inode, rb_node);
-		inode = igrab(&entry->vfs_inode);
-		if (inode) {
-			spin_unlock(&root->inode_lock);
-			return inode;
-		}
-
-		objectid = btrfs_ino(entry) + 1;
-		if (cond_resched_lock(&root->inode_lock))
-			goto again;
-
-		node = rb_next(node);
-	}
-	spin_unlock(&root->inode_lock);
-	return NULL;
-}
-
 /*
  * get new location of data
  */
@@ -1065,7 +1011,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *fi;
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	u64 parent;
 	u64 bytenr;
 	u64 new_bytenr = 0;
@@ -1112,13 +1058,13 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
 			if (first) {
-				inode = find_next_inode(root, key.objectid);
+				inode = btrfs_find_first_inode(root, key.objectid);
 				first = 0;
-			} else if (inode && btrfs_ino(BTRFS_I(inode)) < key.objectid) {
-				btrfs_add_delayed_iput(BTRFS_I(inode));
-				inode = find_next_inode(root, key.objectid);
+			} else if (inode && btrfs_ino(inode) < key.objectid) {
+				btrfs_add_delayed_iput(inode);
+				inode = btrfs_find_first_inode(root, key.objectid);
 			}
-			if (inode && btrfs_ino(BTRFS_I(inode)) == key.objectid) {
+			if (inode && btrfs_ino(inode) == key.objectid) {
 				struct extent_state *cached_state = NULL;
 
 				end = key.offset +
@@ -1128,21 +1074,19 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
 				end--;
 				/* Take mmap lock to serialize with reflinks. */
-				if (!down_read_trylock(&BTRFS_I(inode)->i_mmap_lock))
+				if (!down_read_trylock(&inode->i_mmap_lock))
 					continue;
-				ret = try_lock_extent(&BTRFS_I(inode)->io_tree,
-						      key.offset, end,
-						      &cached_state);
+				ret = try_lock_extent(&inode->io_tree, key.offset,
+						      end, &cached_state);
 				if (!ret) {
-					up_read(&BTRFS_I(inode)->i_mmap_lock);
+					up_read(&inode->i_mmap_lock);
 					continue;
 				}
 
-				btrfs_drop_extent_map_range(BTRFS_I(inode),
-							    key.offset, end, true);
-				unlock_extent(&BTRFS_I(inode)->io_tree,
-					      key.offset, end, &cached_state);
-				up_read(&BTRFS_I(inode)->i_mmap_lock);
+				btrfs_drop_extent_map_range(inode, key.offset, end, true);
+				unlock_extent(&inode->io_tree, key.offset, end,
+					      &cached_state);
+				up_read(&inode->i_mmap_lock);
 			}
 		}
 
@@ -1185,7 +1129,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 	if (dirty)
 		btrfs_mark_buffer_dirty(trans, leaf);
 	if (inode)
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		btrfs_add_delayed_iput(inode);
 	return ret;
 }
 
@@ -1527,7 +1471,7 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 				   const struct btrfs_key *max_key)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	u64 objectid;
 	u64 start, end;
 	u64 ino;
@@ -1537,23 +1481,24 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 		struct extent_state *cached_state = NULL;
 
 		cond_resched();
-		iput(inode);
+		if (inode)
+			iput(&inode->vfs_inode);
 
 		if (objectid > max_key->objectid)
 			break;
 
-		inode = find_next_inode(root, objectid);
+		inode = btrfs_find_first_inode(root, objectid);
 		if (!inode)
 			break;
-		ino = btrfs_ino(BTRFS_I(inode));
+		ino = btrfs_ino(inode);
 
 		if (ino > max_key->objectid) {
-			iput(inode);
+			iput(&inode->vfs_inode);
 			break;
 		}
 
 		objectid = ino + 1;
-		if (!S_ISREG(inode->i_mode))
+		if (!S_ISREG(inode->vfs_inode.i_mode))
 			continue;
 
 		if (unlikely(min_key->objectid == ino)) {
@@ -1586,9 +1531,9 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 		}
 
 		/* the lock_extent waits for read_folio to complete */
-		lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
-		btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, true);
-		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
+		lock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_drop_extent_map_range(inode, start, end, true);
+		unlock_extent(&inode->io_tree, start, end, &cached_state);
 	}
 	return 0;
 }
-- 
2.43.0


