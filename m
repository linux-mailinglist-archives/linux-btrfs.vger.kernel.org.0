Return-Path: <linux-btrfs+bounces-12087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080BA56938
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1893A7DA7
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693F21ABC7;
	Fri,  7 Mar 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKgISfV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FB21ABBB
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355070; cv=none; b=MvJ6K/yAZBBBCZi7t+BxbvdGd0M7gjr8l0UJBZJn7tetZGhJ56NI5F0Aj9lGqoIWMNH5JWzTeq9Foz27kCCDFtDCvDtZTk7B9Gc9UfsqWwNhroN6D5MUn/+t2botK9qvtPuxh98APdD8ixezie+L9Mbl7xKuUk1eqZVc+EHOCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355070; c=relaxed/simple;
	bh=vx3Q5/s94FMA3gS/9WP7vZgb64XggyePTdDv5+Tpm1I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lC7qeyX0t+PWLm+nxwnt8VkyzWHyBM22I2l5R+eUou+fYhWyVd/p16FnnGop23dEuQEhO9lrXMPEhh2XDnAD/gKai2gYXXo1rElRaDu4fymCDG91Ma8sL8oebl9X8MvWJIDvu/EmTYQJMmi2drmZmuIDA0Ep1gTZbSWSu4kbAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKgISfV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E180C4CEE7
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355069;
	bh=vx3Q5/s94FMA3gS/9WP7vZgb64XggyePTdDv5+Tpm1I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LKgISfV/lIE9VMtMmLrwa6M5Yx3nxn1xa1ehYAid73z6+LW+0g1D7YVEAzSbrby+l
	 KTfh+v/c77IQB96fZyryFnIUpulvE2z0oRoZ3qA/h4R7WbkWTH8Id/MNObIk38ztSe
	 hFpbnu6+iF6+oZNmeU3cOeDZb/Ro9UspKeZYtWLJ1fL20ns677JrX3dHzOEFgVDj/J
	 8is8u9T0PbWC7ZzEH6KlUW8C2bQTEYcn1H4TSqEcqm7aKjZZ/YeHtzXExBkexrpNM/
	 3+LxDxw+k1ajAKx2H3mGwARbx3S84t+QxIcpaTCMavDSQ2QCfP3N2dn8O5ld7ovp8I
	 iyevWuq52xsiw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: return a btrfs_inode from btrfs_iget_logging()
Date: Fri,  7 Mar 2025 13:44:18 +0000
Message-Id: <da5df90cf9e74e93b3a458d34465a806ebd24249.1741354478.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All callers of btrfs_iget_logging() are interested in the btrfs_inode
structure rather than the VFS inode, so make btrfs_iget_logging() return
the btrfs_inode instead, avoiding lots of BTRFS_I() calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 94 ++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fc5c761181eb..fc13dbfb96f8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -138,7 +138,7 @@ static void wait_log_commit(struct btrfs_root *root, int transid);
  * and once to do all the other items.
  */
 
-static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
+static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 {
 	unsigned int nofs_flag;
 	struct inode *inode;
@@ -154,7 +154,10 @@ static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 	inode = btrfs_iget(objectid, root);
 	memalloc_nofs_restore(nofs_flag);
 
-	return inode;
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	return BTRFS_I(inode);
 }
 
 /*
@@ -616,12 +619,12 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
 static noinline struct inode *read_one_inode(struct btrfs_root *root,
 					     u64 objectid)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	inode = btrfs_iget_logging(objectid, root);
 	if (IS_ERR(inode))
-		inode = NULL;
-	return inode;
+		return NULL;
+	return &inode->vfs_inode;
 }
 
 /* replays a single extent in 'eb' at 'slot' with 'key' into the
@@ -5481,7 +5484,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	ihold(&curr_inode->vfs_inode);
 
 	while (true) {
-		struct inode *vfs_inode;
 		struct btrfs_key key;
 		struct btrfs_key found_key;
 		u64 next_index;
@@ -5497,7 +5499,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			struct extent_buffer *leaf = path->nodes[0];
 			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
-			struct inode *di_inode;
+			struct btrfs_inode *di_inode;
 			int log_mode = LOG_INODE_EXISTS;
 			int type;
 
@@ -5524,17 +5526,16 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-				btrfs_add_delayed_iput(BTRFS_I(di_inode));
+			if (!need_log_inode(trans, di_inode)) {
+				btrfs_add_delayed_iput(di_inode);
 				break;
 			}
 
 			ctx->log_new_dentries = false;
 			if (type == BTRFS_FT_DIR)
 				log_mode = LOG_INODE_ALL;
-			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
-					      log_mode, ctx);
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+			ret = btrfs_log_inode(trans, di_inode, log_mode, ctx);
+			btrfs_add_delayed_iput(di_inode);
 			if (ret)
 				goto out;
 			if (ctx->log_new_dentries) {
@@ -5576,14 +5577,13 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 		kfree(dir_elem);
 
 		btrfs_add_delayed_iput(curr_inode);
-		curr_inode = NULL;
 
-		vfs_inode = btrfs_iget_logging(ino, root);
-		if (IS_ERR(vfs_inode)) {
-			ret = PTR_ERR(vfs_inode);
+		curr_inode = btrfs_iget_logging(ino, root);
+		if (IS_ERR(curr_inode)) {
+			ret = PTR_ERR(curr_inode);
+			curr_inode = NULL;
 			break;
 		}
-		curr_inode = BTRFS_I(vfs_inode);
 	}
 out:
 	btrfs_free_path(path);
@@ -5661,7 +5661,7 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_ino_list *ino_elem;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/*
 	 * It's rare to have a lot of conflicting inodes, in practice it is not
@@ -5752,12 +5752,12 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	 * inode in LOG_INODE_EXISTS mode and rename operations update the log,
 	 * so that the log ends up with the new name and without the old name.
 	 */
-	if (!need_log_inode(trans, BTRFS_I(inode))) {
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+	if (!need_log_inode(trans, inode)) {
+		btrfs_add_delayed_iput(inode);
 		return 0;
 	}
 
-	btrfs_add_delayed_iput(BTRFS_I(inode));
+	btrfs_add_delayed_iput(inode);
 
 	ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
 	if (!ino_elem)
@@ -5793,7 +5793,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 	 */
 	while (!list_empty(&ctx->conflict_inodes)) {
 		struct btrfs_ino_list *curr;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		u64 parent;
 
@@ -5829,9 +5829,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 * dir index key range logged for the directory. So we
 			 * must make sure the deletion is recorded.
 			 */
-			ret = btrfs_log_inode(trans, BTRFS_I(inode),
-					      LOG_INODE_ALL, ctx);
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
+			btrfs_add_delayed_iput(inode);
 			if (ret)
 				break;
 			continue;
@@ -5847,8 +5846,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * it again because if some other task logged the inode after
 		 * that, we can avoid doing it again.
 		 */
-		if (!need_log_inode(trans, BTRFS_I(inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (!need_log_inode(trans, inode)) {
+			btrfs_add_delayed_iput(inode);
 			continue;
 		}
 
@@ -5859,8 +5858,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * well because during a rename we pin the log and update the
 		 * log with the new name before we unpin it.
 		 */
-		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		ret = btrfs_log_inode(trans, inode, LOG_INODE_EXISTS, ctx);
+		btrfs_add_delayed_iput(inode);
 		if (ret)
 			break;
 	}
@@ -6351,7 +6350,7 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 
 	list_for_each_entry(item, delayed_ins_list, log_list) {
 		struct btrfs_dir_item *dir_item;
-		struct inode *di_inode;
+		struct btrfs_inode *di_inode;
 		struct btrfs_key key;
 		int log_mode = LOG_INODE_EXISTS;
 
@@ -6367,8 +6366,8 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		if (!need_log_inode(trans, di_inode)) {
+			btrfs_add_delayed_iput(di_inode);
 			continue;
 		}
 
@@ -6376,12 +6375,12 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			log_mode = LOG_INODE_ALL;
 
 		ctx->log_new_dentries = false;
-		ret = btrfs_log_inode(trans, BTRFS_I(di_inode), log_mode, ctx);
+		ret = btrfs_log_inode(trans, di_inode, log_mode, ctx);
 
 		if (!ret && ctx->log_new_dentries)
-			ret = log_new_dir_dentries(trans, BTRFS_I(di_inode), ctx);
+			ret = log_new_dir_dentries(trans, di_inode, ctx);
 
-		btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		btrfs_add_delayed_iput(di_inode);
 
 		if (ret)
 			break;
@@ -6789,7 +6788,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		while (cur_offset < item_size) {
 			struct btrfs_key inode_key;
-			struct inode *dir_inode;
+			struct btrfs_inode *dir_inode;
 
 			inode_key.type = BTRFS_INODE_ITEM_KEY;
 			inode_key.offset = 0;
@@ -6838,18 +6837,16 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			if (!need_log_inode(trans, BTRFS_I(dir_inode))) {
-				btrfs_add_delayed_iput(BTRFS_I(dir_inode));
+			if (!need_log_inode(trans, dir_inode)) {
+				btrfs_add_delayed_iput(dir_inode);
 				continue;
 			}
 
 			ctx->log_new_dentries = false;
-			ret = btrfs_log_inode(trans, BTRFS_I(dir_inode),
-					      LOG_INODE_ALL, ctx);
+			ret = btrfs_log_inode(trans, dir_inode, LOG_INODE_ALL, ctx);
 			if (!ret && ctx->log_new_dentries)
-				ret = log_new_dir_dentries(trans,
-						   BTRFS_I(dir_inode), ctx);
-			btrfs_add_delayed_iput(BTRFS_I(dir_inode));
+				ret = log_new_dir_dentries(trans, dir_inode, ctx);
+			btrfs_add_delayed_iput(dir_inode);
 			if (ret)
 				goto out;
 		}
@@ -6874,7 +6871,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		struct extent_buffer *leaf;
 		int slot;
 		struct btrfs_key search_key;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		int ret = 0;
 
@@ -6889,11 +6886,10 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (BTRFS_I(inode)->generation >= trans->transid &&
-		    need_log_inode(trans, BTRFS_I(inode)))
-			ret = btrfs_log_inode(trans, BTRFS_I(inode),
-					      LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (inode->generation >= trans->transid &&
+		    need_log_inode(trans, inode))
+			ret = btrfs_log_inode(trans, inode, LOG_INODE_EXISTS, ctx);
+		btrfs_add_delayed_iput(inode);
 		if (ret)
 			return ret;
 
-- 
2.45.2


