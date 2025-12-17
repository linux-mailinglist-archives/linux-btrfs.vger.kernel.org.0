Return-Path: <linux-btrfs+bounces-19833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 364AECC7D89
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2EA930A320F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEE363C65;
	Wed, 17 Dec 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j73ctGfQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E63624B2
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977766; cv=none; b=EwuUSjYMhLgJ3EJrfpPDDeXBwLluQhOHrPG6kdJDdHutpmMA7TzPT6NYaR8m579fMIdV1SuXZxVe/jsLBlfJRLRYutpMxcHdw01ZswlqBnBO3/2p/X1HhsZzfYUDhIAulueJRKNDJD8LCQFR36NzpF29d0yTxe4lvPWYaHhbSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977766; c=relaxed/simple;
	bh=z6m7YZ5p+GMupyBEaaIe4HqZuMHLSkQl7d9frkWnRDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Upf3VQzTJ7GTi5zVFg9gAvvl1F6bU9fthfBzVhFgvCnvVHZmN/P8N1UMF+0yFSYtkT4D1Gcb6dCfyYcsa3j1X+MHzhQ5eCT9izvsTyu7E4TF4c6YqvTpC/XD9Sfbo3qJuLWXQcNRrcHbteO8gAx4BXMABhsiABEAQYMeqUrvSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j73ctGfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6086CC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765977765;
	bh=z6m7YZ5p+GMupyBEaaIe4HqZuMHLSkQl7d9frkWnRDY=;
	h=From:To:Subject:Date:From;
	b=j73ctGfQc3RI0BIJTYybj4163oedcOdoV2btcfw189MH2r3Url79DYg1whLWYflU5
	 4MQKPNsl9gkI72GzIlqaviUIAP0wCsOnfCwlFIPRnmOWbRdHf0OkMrrwdRWEVPlnZA
	 yyRGNIYSNk+wkg/Iet0RLN2gu5ehIaMEEv7HS9kGBrJ/XEtnQK1Aes2+7UmbS+U2HE
	 g0Q8D6KPGyPPyhtWOY2TMXTPPpXWoArVpV83pkDCOMzhI+XVkaEx3ylA9Idr2jTwhw
	 P3VBca7Zxbta7Wr06CuBIjdEQqXK6tNGju4oQvEpoV//i+nAykS41uU4l/mKpeFLTG
	 bM7S5+H2DP8NA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tag as unlikely error conditions in the transaction commit path
Date: Wed, 17 Dec 2025 13:22:41 +0000
Message-ID: <bb3d28f50f56238ef6d8db65ddce28d1f53009d4.1765977733.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Errors are unexpected during the transaction commit path, and when they
happen we abort the transaction (by calling cleanup_transaction() under
the label 'cleanup_transaction' in btrfs_commit_transaction()). So mark
every error check in the transaction commit path as unlikely, to hint the
compiler so that it can possibly generate better code, and make it clear
for a reader about being unexpected.

On a x86_84 box using gcc 14.2.0-19 from Debian, this resulted in a slight
reduction of the module's text size.

Before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939476	 172568	  15592	2127636	 207714	fs/btrfs/btrfs.ko

After:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939044	 172568	  15592	2127204	 207564	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 206872d757c8..267f6f753f56 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1515,7 +1515,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 
 			btrfs_free_log(trans, root);
 			ret2 = btrfs_update_reloc_root(trans, root);
-			if (ret2)
+			if (unlikely(ret2))
 				return ret2;
 
 			/* see comments in should_cow_block() */
@@ -1532,7 +1532,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			ret2 = btrfs_update_root(trans, fs_info->tree_root,
 						&root->root_key,
 						&root->root_item);
-			if (ret2)
+			if (unlikely(ret2))
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
 		}
@@ -1687,11 +1687,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 						&pending->dentry->d_name, 0,
 						&fname);
 	memalloc_nofs_restore(nofs_flags);
-	if (pending->error)
+	if (unlikely(pending->error))
 		goto free_pending;
 
 	pending->error = btrfs_get_free_objectid(tree_root, &objectid);
-	if (pending->error)
+	if (unlikely(pending->error))
 		goto free_fname;
 
 	/*
@@ -1707,7 +1707,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 						     &pending->block_rsv,
 						     to_reserve,
 						     BTRFS_RESERVE_NO_FLUSH);
-		if (pending->error)
+		if (unlikely(pending->error))
 			goto clear_skip_qgroup;
 	}
 
@@ -1719,7 +1719,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 				      trans->bytes_reserved, 1);
 	parent_root = parent_inode->root;
 	ret = record_root_in_trans(trans, parent_root, 0);
-	if (ret)
+	if (unlikely(ret))
 		goto fail;
 	cur_time = current_time(&parent_inode->vfs_inode);
 
@@ -1736,7 +1736,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
 					 btrfs_ino(parent_inode),
 					 &fname.disk_name, 0);
-	if (dir_item != NULL && !IS_ERR(dir_item)) {
+	if (unlikely(dir_item != NULL && !IS_ERR(dir_item))) {
 		pending->error = -EEXIST;
 		goto dir_item_existed;
 	} else if (IS_ERR(dir_item)) {
@@ -1873,7 +1873,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
 		ret = btrfs_qgroup_inherit(trans, btrfs_root_id(root), objectid,
 					   btrfs_root_id(parent_root), pending->inherit);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		goto fail;
 
 	ret = btrfs_insert_dir_item(trans, &fname.disk_name,
@@ -1939,7 +1939,7 @@ static noinline int create_pending_snapshots(struct btrfs_trans_handle *trans)
 	list_for_each_entry_safe(pending, next, head, list) {
 		list_del(&pending->list);
 		ret = create_pending_snapshot(trans, pending);
-		if (ret)
+		if (unlikely(ret))
 			break;
 	}
 	return ret;
@@ -2258,7 +2258,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 		if (run_it) {
 			ret = btrfs_start_dirty_block_groups(trans);
-			if (ret)
+			if (unlikely(ret))
 				goto lockdep_trans_commit_start_release;
 		}
 	}
@@ -2308,7 +2308,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 			ret = READ_ONCE(prev_trans->aborted);
 
 			btrfs_put_transaction(prev_trans);
-			if (ret)
+			if (unlikely(ret))
 				goto lockdep_release;
 			spin_lock(&fs_info->trans_lock);
 		}
@@ -2338,11 +2338,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	extwriter_counter_dec(cur_trans, trans->type);
 
 	ret = btrfs_start_delalloc_flush(fs_info);
-	if (ret)
+	if (unlikely(ret))
 		goto lockdep_release;
 
 	ret = btrfs_run_delayed_items(trans);
-	if (ret)
+	if (unlikely(ret))
 		goto lockdep_release;
 
 	/*
@@ -2357,7 +2357,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	/* some pending stuffs might be added after the previous flush. */
 	ret = btrfs_run_delayed_items(trans);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
 		goto cleanup_transaction;
 	}
@@ -2429,7 +2429,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * core function of the snapshot creation.
 	 */
 	ret = create_pending_snapshots(trans);
-	if (ret)
+	if (unlikely(ret))
 		goto unlock_reloc;
 
 	/*
@@ -2443,11 +2443,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * the nodes and leaves.
 	 */
 	ret = btrfs_run_delayed_items(trans);
-	if (ret)
+	if (unlikely(ret))
 		goto unlock_reloc;
 
 	ret = btrfs_run_delayed_refs(trans, U64_MAX);
-	if (ret)
+	if (unlikely(ret))
 		goto unlock_reloc;
 
 	/*
@@ -2459,7 +2459,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	WARN_ON(cur_trans != trans->transaction);
 
 	ret = commit_fs_roots(trans);
-	if (ret)
+	if (unlikely(ret))
 		goto unlock_reloc;
 
 	/* commit_fs_roots gets rid of all the tree log roots, it is now
@@ -2472,11 +2472,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * new_roots. So let's do quota accounting.
 	 */
 	ret = btrfs_qgroup_account_extents(trans);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		goto unlock_reloc;
 
 	ret = commit_cowonly_roots(trans);
-	if (ret)
+	if (unlikely(ret))
 		goto unlock_reloc;
 
 	/*
@@ -2562,7 +2562,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * to go about their business
 	 */
 	mutex_unlock(&fs_info->tree_log_mutex);
-	if (ret)
+	if (unlikely(ret))
 		goto scrub_continue;
 
 	update_commit_stats(fs_info);
@@ -2575,7 +2575,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
 
 	ret = btrfs_finish_extent_commit(trans);
-	if (ret)
+	if (unlikely(ret))
 		goto scrub_continue;
 
 	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &cur_trans->flags))
-- 
2.47.2


