Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF4F3F6581
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhHXRNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 13:13:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhHXRLt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 13:11:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D07720090;
        Tue, 24 Aug 2021 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629825063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGf7j1PGQtnjKszBf1U/VVjtMGBhtQ4KVBrW3DzmsuI=;
        b=L9mMEa8lljjhyJPPbyEwOb6jyWyFqj+0yFRQJs3N/I4IJqn/LyF3nP0Go6Du7F0w5va6A5
        IBRG5sAvRmngTXSl1NdZ5J1oBSY6/JLVgXTSiQJ4EwQMTCvDgPyak8mO779+9u3oJIXrYY
        uXNvGdNM+QxNH3V8fvtDbX0BHs/CkN8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03E5413B45;
        Tue, 24 Aug 2021 17:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aK82LyQoJWGDNwAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 24 Aug 2021 17:11:00 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 6/7] btrfs: send: Use btrfs_for_each_slot macro
Date:   Tue, 24 Aug 2021 14:06:57 -0300
Message-Id: <20210824170658.12567-7-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824170658.12567-1-mpdesouza@suse.com>
References: <20210824170658.12567-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This makes the code much simpler and smaller.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/send.c | 222 +++++++++++++-----------------------------------
 1 file changed, 59 insertions(+), 163 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index afdcbe7844e0..3e32886e171e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2647,6 +2647,7 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
  */
 static int did_create_dir(struct send_ctx *sctx, u64 dir)
 {
+	int iter_ret;
 	int ret = 0;
 	struct btrfs_path *path = NULL;
 	struct btrfs_key key;
@@ -2654,43 +2655,23 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 	struct btrfs_key di_key;
 	struct extent_buffer *eb;
 	struct btrfs_dir_item *di;
-	int slot;
 
 	path = alloc_path_for_send();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, sctx->send_root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(sctx->send_root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				break;
-			}
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
+	btrfs_for_each_slot(sctx->send_root, &key, &found_key, path, iter_ret) {
 		if (found_key.objectid != key.objectid ||
 		    found_key.type != key.type) {
 			ret = 0;
 			goto out;
 		}
 
-		di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
+		eb = path->nodes[0];
+		di = btrfs_item_ptr(eb, path->slots[0], struct btrfs_dir_item);
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 
 		if (di_key.type != BTRFS_ROOT_ITEM_KEY &&
@@ -2698,10 +2679,12 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 			ret = 1;
 			goto out;
 		}
-
-		path->slots[0]++;
 	}
 
+	/* Only set ret if there was an error in the search. */
+	if (iter_ret < 0)
+		ret = iter_ret;
+
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -2905,6 +2888,7 @@ static void free_orphan_dir_info(struct send_ctx *sctx,
 static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 		     u64 send_progress)
 {
+	int iter_ret;
 	int ret = 0;
 	struct btrfs_root *root = sctx->parent_root;
 	struct btrfs_path *path;
@@ -2932,23 +2916,9 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	if (odi)
 		key.offset = odi->last_dir_index_offset;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct waiting_dir_move *dm;
 
-		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
-				      path->slots[0]);
 		if (found_key.objectid != key.objectid ||
 		    found_key.type != key.type)
 			break;
@@ -2984,8 +2954,13 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			goto out;
 		}
 
-		path->slots[0]++;
 	}
+
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto out;
+	}
+
 	free_orphan_dir_info(sctx, odi);
 
 	ret = 1;
@@ -3563,6 +3538,7 @@ static int is_ancestor(struct btrfs_root *root,
 		       struct fs_path *fs_path)
 {
 	bool free_fs_path = false;
+	int iter_ret = 0;
 	int ret = 0;
 	struct btrfs_path *path = NULL;
 	struct btrfs_key key;
@@ -3584,26 +3560,12 @@ static int is_ancestor(struct btrfs_root *root,
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (true) {
+	btrfs_for_each_slot(root, &key, &key, path, iter_ret) {
 		struct extent_buffer *leaf = path->nodes[0];
 		int slot = path->slots[0];
 		u32 cur_offset = 0;
 		u32 item_size;
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &key, slot);
 		if (key.objectid != ino2)
 			break;
 		if (key.type != BTRFS_INODE_REF_KEY &&
@@ -3641,8 +3603,13 @@ static int is_ancestor(struct btrfs_root *root,
 			if (ret)
 				goto out;
 		}
-		path->slots[0]++;
 	}
+
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto out;
+	}
+
 	ret = 0;
  out:
 	btrfs_free_path(path);
@@ -4524,13 +4491,12 @@ static int record_changed_ref(struct send_ctx *sctx)
 static int process_all_refs(struct send_ctx *sctx,
 			    enum btrfs_compare_tree_result cmd)
 {
-	int ret;
+	int iter_ret;
+	int ret = 0;
 	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct extent_buffer *eb;
-	int slot;
 	iterate_inode_ref_t cb;
 	int pending_move = 0;
 
@@ -4554,24 +4520,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	key.objectid = sctx->cmp_key->objectid;
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
-
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		if (found_key.objectid != key.objectid ||
 		    (found_key.type != BTRFS_INODE_REF_KEY &&
 		     found_key.type != BTRFS_INODE_EXTREF_KEY))
@@ -4580,9 +4529,13 @@ static int process_all_refs(struct send_ctx *sctx,
 		ret = iterate_inode_ref(root, path, &found_key, 0, cb, sctx);
 		if (ret < 0)
 			goto out;
+	}
 
-		path->slots[0]++;
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto out;
 	}
+
 	btrfs_release_path(path);
 
 	/*
@@ -4847,13 +4800,12 @@ static int process_changed_xattr(struct send_ctx *sctx)
 
 static int process_all_new_xattrs(struct send_ctx *sctx)
 {
-	int ret;
+	int iter_ret;
+	int ret = 0;
 	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct extent_buffer *eb;
-	int slot;
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -4864,39 +4816,18 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	key.objectid = sctx->cmp_key->objectid;
 	key.type = BTRFS_XATTR_ITEM_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				break;
-			}
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		if (found_key.objectid != key.objectid ||
-		    found_key.type != key.type) {
-			ret = 0;
-			goto out;
-		}
+		    found_key.type != key.type)
+			break;
 
 		ret = iterate_dir_item(root, path, __process_new_xattr, sctx);
 		if (ret < 0)
-			goto out;
-
-		path->slots[0]++;
+			break;
 	}
+	if (iter_ret < 0)
+		ret = iter_ret;
 
-out:
 	btrfs_free_path(path);
 	return ret;
 }
@@ -5938,13 +5869,12 @@ static int process_extent(struct send_ctx *sctx,
 
 static int process_all_extents(struct send_ctx *sctx)
 {
-	int ret;
+	int iter_ret;
+	int ret = 0;
 	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct extent_buffer *eb;
-	int slot;
 
 	root = sctx->send_root;
 	path = alloc_path_for_send();
@@ -5954,40 +5884,19 @@ static int process_all_extents(struct send_ctx *sctx)
 	key.objectid = sctx->cmp_key->objectid;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				break;
-			}
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
-
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		if (found_key.objectid != key.objectid ||
-		    found_key.type != key.type) {
-			ret = 0;
+		    found_key.type != key.type)
 			goto out;
-		}
 
 		ret = process_extent(sctx, path, &found_key);
 		if (ret < 0)
 			goto out;
-
-		path->slots[0]++;
 	}
 
+	if (iter_ret < 0)
+		ret = iter_ret;
+
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -6180,36 +6089,20 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct parent_paths_ctx ctx;
-	int ret;
+	int iter_ret;
+	int ret = 0;
 
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
 
-	key.objectid = sctx->cur_ino;
-	key.type = BTRFS_INODE_REF_KEY;
-	key.offset = 0;
-	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
 	ctx.refs = &deleted_refs;
 	ctx.sctx = sctx;
 
-	while (true) {
-		struct extent_buffer *eb = path->nodes[0];
-		int slot = path->slots[0];
-
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(sctx->parent_root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &key, slot);
+	key.objectid = sctx->cur_ino;
+	key.type = BTRFS_INODE_REF_KEY;
+	key.offset = 0;
+	btrfs_for_each_slot(sctx->parent_root, &key, &key, path, iter_ret) {
 		if (key.objectid != sctx->cur_ino)
 			break;
 		if (key.type != BTRFS_INODE_REF_KEY &&
@@ -6220,8 +6113,11 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
 					record_parent_ref, &ctx);
 		if (ret < 0)
 			goto out;
+	}
 
-		path->slots[0]++;
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto out;
 	}
 
 	while (!list_empty(&deleted_refs)) {
-- 
2.31.1

