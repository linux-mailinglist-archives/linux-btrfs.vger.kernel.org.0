Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461853D8194
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhG0VT1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:19:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhG0VRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 704062225F;
        Tue, 27 Jul 2021 21:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+E0xUIJZHsW17IpTJAF8whOwg78kaxbefCWM2mIXd9c=;
        b=c2YLT9h/vmJDwQTgY5i2/fPysSa6+PKGEU+7ju+PuCFOR5PLUeh/Ev4RszgcPraYCzNdjj
        QrwsnYxQAaPJ8wjOPW/SnxJP9U6iais9ZCik8p7UXZhqKclDJKuF3yIuMmUlmwrhSK8wOd
        OQ6DcfU0ZTUMPDDtEDS7Pr2/Jjz2iOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420669;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+E0xUIJZHsW17IpTJAF8whOwg78kaxbefCWM2mIXd9c=;
        b=j+564oqTDY6a1CUmRRvKs/F1JSKByht6VUbvR2gY2V4O6acRnIrQ7edVZ+VGNt1ZLNDmbf
        LxcdtGLu8fnMyoDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 05BBB133DE;
        Tue, 27 Jul 2021 21:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id q9luKPx3AGFydQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 21:17:48 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/7] btrfs: Allocate walk_control on stack
Date:   Tue, 27 Jul 2021 16:17:25 -0500
Message-Id: <381dc8c84c07b4eecc8b5de6686d79ad5c60ae58.1627418762.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using kmalloc() to allocate walk_control, allocate
walk_control on stack.

No need to memset() a struct to zero if it is initialized to zero.

sizeof(walk_control) = 200

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent-tree.c | 89 +++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fc3da7585fb7..a66cb2e5146f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5484,7 +5484,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root_item *root_item = &root->root_item;
-	struct walk_control *wc;
+	struct walk_control wc = {0};
 	struct btrfs_key key;
 	int err = 0;
 	int ret;
@@ -5499,13 +5499,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		goto out;
 	}
 
-	wc = kzalloc(sizeof(*wc), GFP_NOFS);
-	if (!wc) {
-		btrfs_free_path(path);
-		err = -ENOMEM;
-		goto out;
-	}
-
 	/*
 	 * Use join to avoid potential EINTR from transaction start. See
 	 * wait_reserve_ticket and the whole reservation callchain.
@@ -5537,12 +5530,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		path->nodes[level] = btrfs_lock_root_node(root);
 		path->slots[level] = 0;
 		path->locks[level] = BTRFS_WRITE_LOCK;
-		memset(&wc->update_progress, 0,
-		       sizeof(wc->update_progress));
 	} else {
 		btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
-		memcpy(&wc->update_progress, &key,
-		       sizeof(wc->update_progress));
+		memcpy(&wc.update_progress, &key,
+		       sizeof(wc.update_progress));
 
 		level = btrfs_root_drop_level(root_item);
 		BUG_ON(level == 0);
@@ -5568,62 +5559,62 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
-						level, 1, &wc->refs[level],
-						&wc->flags[level]);
+						level, 1, &wc.refs[level],
+						&wc.flags[level]);
 			if (ret < 0) {
 				err = ret;
 				goto out_end_trans;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			BUG_ON(wc.refs[level] == 0);
 
 			if (level == btrfs_root_drop_level(root_item))
 				break;
 
 			btrfs_tree_unlock(path->nodes[level]);
 			path->locks[level] = 0;
-			WARN_ON(wc->refs[level] != 1);
+			WARN_ON(wc.refs[level] != 1);
 			level--;
 		}
 	}
 
-	wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
-	wc->level = level;
-	wc->shared_level = -1;
-	wc->stage = DROP_REFERENCE;
-	wc->update_ref = update_ref;
-	wc->keep_locks = 0;
-	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
+	wc.restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
+	wc.level = level;
+	wc.shared_level = -1;
+	wc.stage = DROP_REFERENCE;
+	wc.update_ref = update_ref;
+	wc.keep_locks = 0;
+	wc.reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
 
 	while (1) {
 
-		ret = walk_down_tree(trans, root, path, wc);
+		ret = walk_down_tree(trans, root, path, &wc);
 		if (ret < 0) {
 			err = ret;
 			break;
 		}
 
-		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
+		ret = walk_up_tree(trans, root, path, &wc, BTRFS_MAX_LEVEL);
 		if (ret < 0) {
 			err = ret;
 			break;
 		}
 
 		if (ret > 0) {
-			BUG_ON(wc->stage != DROP_REFERENCE);
+			BUG_ON(wc.stage != DROP_REFERENCE);
 			break;
 		}
 
-		if (wc->stage == DROP_REFERENCE) {
-			wc->drop_level = wc->level;
-			btrfs_node_key_to_cpu(path->nodes[wc->drop_level],
-					      &wc->drop_progress,
-					      path->slots[wc->drop_level]);
+		if (wc.stage == DROP_REFERENCE) {
+			wc.drop_level = wc.level;
+			btrfs_node_key_to_cpu(path->nodes[wc.drop_level],
+					      &wc.drop_progress,
+					      path->slots[wc.drop_level]);
 		}
 		btrfs_cpu_key_to_disk(&root_item->drop_progress,
-				      &wc->drop_progress);
-		btrfs_set_root_drop_level(root_item, wc->drop_level);
+				      &wc.drop_progress);
+		btrfs_set_root_drop_level(root_item, wc.drop_level);
 
-		BUG_ON(wc->level == 0);
+		BUG_ON(wc.level == 0);
 		if (btrfs_should_end_transaction(trans) ||
 		    (!for_reloc && btrfs_need_cleaner_sleep(fs_info))) {
 			ret = btrfs_update_root(trans, tree_root,
@@ -5703,7 +5694,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 out_end_trans:
 	btrfs_end_transaction_throttle(trans);
 out_free:
-	kfree(wc);
 	btrfs_free_path(path);
 out:
 	/*
@@ -5731,7 +5721,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
-	struct walk_control *wc;
+	struct walk_control wc = {0};
 	int level;
 	int parent_level;
 	int ret = 0;
@@ -5743,12 +5733,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	wc = kzalloc(sizeof(*wc), GFP_NOFS);
-	if (!wc) {
-		btrfs_free_path(path);
-		return -ENOMEM;
-	}
-
 	btrfs_assert_tree_locked(parent);
 	parent_level = btrfs_header_level(parent);
 	atomic_inc(&parent->refs);
@@ -5761,30 +5745,29 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	path->slots[level] = 0;
 	path->locks[level] = BTRFS_WRITE_LOCK;
 
-	wc->refs[parent_level] = 1;
-	wc->flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
-	wc->level = level;
-	wc->shared_level = -1;
-	wc->stage = DROP_REFERENCE;
-	wc->update_ref = 0;
-	wc->keep_locks = 1;
-	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
+	wc.refs[parent_level] = 1;
+	wc.flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
+	wc.level = level;
+	wc.shared_level = -1;
+	wc.stage = DROP_REFERENCE;
+	wc.update_ref = 0;
+	wc.keep_locks = 1;
+	wc.reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
 
 	while (1) {
-		wret = walk_down_tree(trans, root, path, wc);
+		wret = walk_down_tree(trans, root, path, &wc);
 		if (wret < 0) {
 			ret = wret;
 			break;
 		}
 
-		wret = walk_up_tree(trans, root, path, wc, parent_level);
+		wret = walk_up_tree(trans, root, path, &wc, parent_level);
 		if (wret < 0)
 			ret = wret;
 		if (wret != 0)
 			break;
 	}
 
-	kfree(wc);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.32.0

