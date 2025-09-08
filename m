Return-Path: <linux-btrfs+bounces-16712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD6B48926
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496013A6A8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759AC2F9C32;
	Mon,  8 Sep 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMlQcvXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90D2F999E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325226; cv=none; b=oDsHqirvmL9d2jqdowC39u1H7GQv8eQQTKJeBTi40zjD3yvnwbhjDuxN+jt/xOzNDH2pRlwYd7e6Z6uS5lwX/qMyLqnJofORibhFvRTob9S5AQ/ORMll8ZdPWW6f21SHZczjMUGlQnW/f5rpwVA+R0R/wk3Emhw7+bza6X7lpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325226; c=relaxed/simple;
	bh=2Z7YIyny6CHmL3eUxvNXZQdElcEv6jg7WVi2RkQ40YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeK7WBm9ReiedsvFUygBLUVGlid0wpT6Pbh2OQl0SVjG9aAaUVUEVu9RNn7a3RN3gGMAl1Mnv4KNgXHn9iQj69hqG0KZLw1GG5yA7zFfELOx9aHHPdz7eS49lpslZe0gD3mCyBjfbZeSXSWv1F8tW+TFQAC9MBv9qPEq9RP9l14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMlQcvXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249E7C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325226;
	bh=2Z7YIyny6CHmL3eUxvNXZQdElcEv6jg7WVi2RkQ40YE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KMlQcvXXHva0P9MdDqGohJ/eIf+lx/X6afkTlULRpaeC/uxXraySU+xg5Ak191NVO
	 oCoG/V970xL9KpXah9X7mosOU9pWJA6H02nB53Ez6sLyWUOxCGN1DiFWSmof1V37LR
	 vZUbfi8RVF1TlqWC2RA/iIljRCBL3J9Vkl9+l8F+BXiex1yAn3vqpJiTGPZ77Blt2+
	 KtxsOg39hl6w9N0NALdckZiaQwaLbhrxg8AC/g0OQRdOKL+oUWXyyBxZiK+CW28zwl
	 SDXkqx5TFPQ2aI3xk3nzveJrHhbCSy8vcV0cQG0ex1ttKIA9fvwmM5GE94cdTvzUdr
	 W3piK4OaMVt7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/33] btrfs: pass walk_control structure to drop_one_dir_item() and helpers
Date: Mon,  8 Sep 2025 10:53:11 +0100
Message-ID: <62467d966c4ba21f6fbd88ccb1a591e8d8ce575d.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing the transaction as an argument to drop_one_dir_item()
and its helpers (link_to_fixup_dir() and unlink_inode_for_log_replay()),
pass the walk_control structure as we can access the transaction from it
and the subvolume root. This is going to be needed by an incoming change
that improves error reporting for log replay and also reduces the number
of arguments passed to link_to_fixup_dir().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c4c2fbf291a1..01a0f7cbcd4b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -156,8 +156,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode,
 			   int inode_only,
 			   struct btrfs_log_ctx *ctx);
-static int link_to_fixup_dir(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
+static int link_to_fixup_dir(struct walk_control *wc,
 			     struct btrfs_path *path, u64 objectid);
 static noinline int replay_dir_deletes(struct walk_control *wc,
 				       struct btrfs_path *path,
@@ -927,11 +926,12 @@ static noinline int replay_one_extent(struct walk_control *wc,
 	return ret;
 }
 
-static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
+static int unlink_inode_for_log_replay(struct walk_control *wc,
 				       struct btrfs_inode *dir,
 				       struct btrfs_inode *inode,
 				       const struct fscrypt_str *name)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	int ret;
 
 	ret = btrfs_unlink_inode(trans, dir, inode, name);
@@ -959,11 +959,12 @@ static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
  * This is a helper function to do the unlink of a specific directory
  * item
  */
-static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
+static noinline int drop_one_dir_item(struct walk_control *wc,
 				      struct btrfs_path *path,
 				      struct btrfs_inode *dir,
 				      struct btrfs_dir_item *di)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = dir->root;
 	struct btrfs_inode *inode;
 	struct fscrypt_str name;
@@ -990,11 +991,11 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	ret = link_to_fixup_dir(trans, root, path, location.objectid);
+	ret = link_to_fixup_dir(wc, path, location.objectid);
 	if (ret)
 		goto out;
 
-	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
+	ret = unlink_inode_for_log_replay(wc, dir, inode, &name);
 out:
 	kfree(name.name);
 	if (inode)
@@ -1135,7 +1136,7 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 		inc_nlink(&inode->vfs_inode);
 		btrfs_release_path(path);
 
-		ret = unlink_inode_for_log_replay(trans, dir, inode, &victim_name);
+		ret = unlink_inode_for_log_replay(wc, dir, inode, &victim_name);
 		kfree(victim_name.name);
 		if (ret)
 			return ret;
@@ -1207,7 +1208,7 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 		inc_nlink(&inode->vfs_inode);
 		btrfs_release_path(path);
 
-		ret = unlink_inode_for_log_replay(trans, victim_parent, inode,
+		ret = unlink_inode_for_log_replay(wc, victim_parent, inode,
 						  &victim_name);
 		iput(&victim_parent->vfs_inode);
 		kfree(victim_name.name);
@@ -1281,7 +1282,7 @@ static inline int __add_inode_ref(struct walk_control *wc,
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	} else if (di) {
-		ret = drop_one_dir_item(trans, path, dir, di);
+		ret = drop_one_dir_item(wc, path, dir, di);
 		if (ret)
 			return ret;
 	}
@@ -1292,7 +1293,7 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
-		ret = drop_one_dir_item(trans, path, dir, di);
+		ret = drop_one_dir_item(wc, path, dir, di);
 		if (ret)
 			return ret;
 	}
@@ -1415,7 +1416,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
-			ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
+			ret = unlink_inode_for_log_replay(wc, dir, inode, &name);
 			kfree(name.name);
 			iput(&dir->vfs_inode);
 			if (ret)
@@ -1842,11 +1843,12 @@ static noinline int fixup_inode_link_counts(struct walk_control *wc,
  * count when replay is done.  The link count is incremented here
  * so the inode won't go away until we check it
  */
-static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root,
+static noinline int link_to_fixup_dir(struct walk_control *wc,
 				      struct btrfs_path *path,
 				      u64 objectid)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	struct btrfs_key key;
 	int ret = 0;
 	struct btrfs_inode *inode;
@@ -1917,7 +1919,7 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int delete_conflicting_dir_entry(struct btrfs_trans_handle *trans,
+static int delete_conflicting_dir_entry(struct walk_control *wc,
 					struct btrfs_inode *dir,
 					struct btrfs_path *path,
 					struct btrfs_dir_item *dst_di,
@@ -1942,7 +1944,7 @@ static int delete_conflicting_dir_entry(struct btrfs_trans_handle *trans,
 	if (!exists)
 		return 0;
 
-	return drop_one_dir_item(trans, path, dir, dst_di);
+	return drop_one_dir_item(wc, path, dir, dst_di);
 }
 
 /*
@@ -2014,7 +2016,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (dir_dst_di) {
-		ret = delete_conflicting_dir_entry(trans, dir, path, dir_dst_di,
+		ret = delete_conflicting_dir_entry(wc, dir, path, dir_dst_di,
 						   &log_key, log_flags, exists);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
@@ -2033,7 +2035,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (index_dst_di) {
-		ret = delete_conflicting_dir_entry(trans, dir, path, index_dst_di,
+		ret = delete_conflicting_dir_entry(wc, dir, path, index_dst_di,
 						   &log_key, log_flags, exists);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
@@ -2161,7 +2163,7 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 		}
 
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
-		ret = link_to_fixup_dir(wc->trans, wc->root, fixup_path, di_key.objectid);
+		ret = link_to_fixup_dir(wc, fixup_path, di_key.objectid);
 		btrfs_free_path(fixup_path);
 	}
 
@@ -2317,12 +2319,12 @@ static noinline int check_item_in_log(struct walk_control *wc,
 		goto out;
 	}
 
-	ret = link_to_fixup_dir(trans, root, path, location.objectid);
+	ret = link_to_fixup_dir(wc, path, location.objectid);
 	if (ret)
 		goto out;
 
 	inc_nlink(&inode->vfs_inode);
-	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
+	ret = unlink_inode_for_log_replay(wc, dir, inode, &name);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
@@ -2699,7 +2701,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 					break;
 			}
 
-			ret = link_to_fixup_dir(trans, root, path, key.objectid);
+			ret = link_to_fixup_dir(wc, path, key.objectid);
 			if (ret)
 				break;
 		}
-- 
2.47.2


