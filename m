Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C659BDE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiHVKwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiHVKwB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774B3123B
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F2D60FFF
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD500C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165519;
        bh=Cv4mD7eTiy+rJLxKCXv+EiJjimhvYm2tREgsqdecDY4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gXJfPVuZD58b9IH6NCTm1iHpJ6ZcNZxqos7nxXfgnG8oMtl4En1fcTyl2z8Ajq4I5
         /ib70z9cXVlbX71El63WyuShFTfXyJ4azNIVgnB4WP2HZoCeTwYWeDdmPilG4vDasa
         0gEii+ZNPx9ZMVSwLtqi/K3WdfNwq1gC+znzpX2sSbQM4x9MNRwHEGbFf36VLDnfYW
         1W3e1vXX05yAxP/YcW8NkrPUJE8kX2zr+EMDNtb6a2FEry037d3dWEUIM3aZHMAfJJ
         RuiBx4P7eqwzKbZ5SSwaIfW2h3orLqWzXps9bEtVewmCd7oG+6QBVG2EQU6YR51ft4
         Vdti6l7EH8fTg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/15] btrfs: move log_new_dir_dentries() above btrfs_log_inode()
Date:   Mon, 22 Aug 2022 11:51:41 +0100
Message-Id: <a0d3441b4ae6b66dd6046533679aa947bc18e793.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The static function log_new_dir_dentries() is currently defined below
btrfs_log_inode(), but in an upcoming patch a new function is introduced
that is called by btrfs_log_inode() and this new function needs to call
log_new_dir_dentries(). So move log_new_dir_dentries() to a location
between btrfs_log_inode() and need_log_inode() (the later is called by
log_new_dir_dentries()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 334 ++++++++++++++++++++++----------------------
 1 file changed, 167 insertions(+), 167 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 15a4a150cb27..94ff4a4598dc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5320,6 +5320,173 @@ static bool need_log_inode(const struct btrfs_trans_handle *trans,
 	return true;
 }
 
+struct btrfs_dir_list {
+	u64 ino;
+	struct list_head list;
+};
+
+/*
+ * Log the inodes of the new dentries of a directory.
+ * See process_dir_items_leaf() for details about why it is needed.
+ * This is a recursive operation - if an existing dentry corresponds to a
+ * directory, that directory's new entries are logged too (same behaviour as
+ * ext3/4, xfs, f2fs, reiserfs, nilfs2). Note that when logging the inodes
+ * the dentries point to we do not acquire their VFS lock, otherwise lockdep
+ * complains about the following circular lock dependency / possible deadlock:
+ *
+ *        CPU0                                        CPU1
+ *        ----                                        ----
+ * lock(&type->i_mutex_dir_key#3/2);
+ *                                            lock(sb_internal#2);
+ *                                            lock(&type->i_mutex_dir_key#3/2);
+ * lock(&sb->s_type->i_mutex_key#14);
+ *
+ * Where sb_internal is the lock (a counter that works as a lock) acquired by
+ * sb_start_intwrite() in btrfs_start_transaction().
+ * Not acquiring the VFS lock of the inodes is still safe because:
+ *
+ * 1) For regular files we log with a mode of LOG_INODE_EXISTS. It's possible
+ *    that while logging the inode new references (names) are added or removed
+ *    from the inode, leaving the logged inode item with a link count that does
+ *    not match the number of logged inode reference items. This is fine because
+ *    at log replay time we compute the real number of links and correct the
+ *    link count in the inode item (see replay_one_buffer() and
+ *    link_to_fixup_dir());
+ *
+ * 2) For directories we log with a mode of LOG_INODE_ALL. It's possible that
+ *    while logging the inode's items new index items (key type
+ *    BTRFS_DIR_INDEX_KEY) are added to fs/subvol tree and the logged inode item
+ *    has a size that doesn't match the sum of the lengths of all the logged
+ *    names - this is ok, not a problem, because at log replay time we set the
+ *    directory's i_size to the correct value (see replay_one_name() and
+ *    do_overwrite_item()).
+ */
+static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
+				struct btrfs_inode *start_inode,
+				struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_root *root = start_inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_path *path;
+	LIST_HEAD(dir_list);
+	struct btrfs_dir_list *dir_elem;
+	u64 ino = btrfs_ino(start_inode);
+	int ret = 0;
+
+	/*
+	 * If we are logging a new name, as part of a link or rename operation,
+	 * don't bother logging new dentries, as we just want to log the names
+	 * of an inode and that any new parents exist.
+	 */
+	if (ctx->logging_new_name)
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (true) {
+		struct extent_buffer *leaf;
+		struct btrfs_key min_key;
+		bool continue_curr_inode = true;
+		int nritems;
+		int i;
+
+		min_key.objectid = ino;
+		min_key.type = BTRFS_DIR_INDEX_KEY;
+		min_key.offset = 0;
+again:
+		btrfs_release_path(path);
+		ret = btrfs_search_forward(root, &min_key, path, trans->transid);
+		if (ret < 0) {
+			break;
+		} else if (ret > 0) {
+			ret = 0;
+			goto next;
+		}
+
+		leaf = path->nodes[0];
+		nritems = btrfs_header_nritems(leaf);
+		for (i = path->slots[0]; i < nritems; i++) {
+			struct btrfs_dir_item *di;
+			struct btrfs_key di_key;
+			struct inode *di_inode;
+			int log_mode = LOG_INODE_EXISTS;
+			int type;
+
+			btrfs_item_key_to_cpu(leaf, &min_key, i);
+			if (min_key.objectid != ino ||
+			    min_key.type != BTRFS_DIR_INDEX_KEY) {
+				continue_curr_inode = false;
+				break;
+			}
+
+			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
+			type = btrfs_dir_type(leaf, di);
+			if (btrfs_dir_transid(leaf, di) < trans->transid)
+				continue;
+			btrfs_dir_item_key_to_cpu(leaf, di, &di_key);
+			if (di_key.type == BTRFS_ROOT_ITEM_KEY)
+				continue;
+
+			btrfs_release_path(path);
+			di_inode = btrfs_iget(fs_info->sb, di_key.objectid, root);
+			if (IS_ERR(di_inode)) {
+				ret = PTR_ERR(di_inode);
+				goto out;
+			}
+
+			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
+				btrfs_add_delayed_iput(di_inode);
+				break;
+			}
+
+			ctx->log_new_dentries = false;
+			if (type == BTRFS_FT_DIR)
+				log_mode = LOG_INODE_ALL;
+			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
+					      log_mode, ctx);
+			btrfs_add_delayed_iput(di_inode);
+			if (ret)
+				goto out;
+			if (ctx->log_new_dentries) {
+				dir_elem = kmalloc(sizeof(*dir_elem), GFP_NOFS);
+				if (!dir_elem) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				dir_elem->ino = di_key.objectid;
+				list_add_tail(&dir_elem->list, &dir_list);
+			}
+			break;
+		}
+
+		if (continue_curr_inode && min_key.offset < (u64)-1) {
+			min_key.offset++;
+			goto again;
+		}
+
+next:
+		if (list_empty(&dir_list))
+			break;
+
+		dir_elem = list_first_entry(&dir_list, struct btrfs_dir_list, list);
+		ino = dir_elem->ino;
+		list_del(&dir_elem->list);
+		kfree(dir_elem);
+	}
+out:
+	btrfs_free_path(path);
+	if (ret) {
+		struct btrfs_dir_list *next;
+
+		list_for_each_entry_safe(dir_elem, next, &dir_list, list)
+			kfree(dir_elem);
+	}
+
+	return ret;
+}
+
 struct btrfs_ino_list {
 	u64 ino;
 	u64 parent;
@@ -5956,173 +6123,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-struct btrfs_dir_list {
-	u64 ino;
-	struct list_head list;
-};
-
-/*
- * Log the inodes of the new dentries of a directory.
- * See process_dir_items_leaf() for details about why it is needed.
- * This is a recursive operation - if an existing dentry corresponds to a
- * directory, that directory's new entries are logged too (same behaviour as
- * ext3/4, xfs, f2fs, reiserfs, nilfs2). Note that when logging the inodes
- * the dentries point to we do not acquire their VFS lock, otherwise lockdep
- * complains about the following circular lock dependency / possible deadlock:
- *
- *        CPU0                                        CPU1
- *        ----                                        ----
- * lock(&type->i_mutex_dir_key#3/2);
- *                                            lock(sb_internal#2);
- *                                            lock(&type->i_mutex_dir_key#3/2);
- * lock(&sb->s_type->i_mutex_key#14);
- *
- * Where sb_internal is the lock (a counter that works as a lock) acquired by
- * sb_start_intwrite() in btrfs_start_transaction().
- * Not acquiring the VFS lock of the inodes is still safe because:
- *
- * 1) For regular files we log with a mode of LOG_INODE_EXISTS. It's possible
- *    that while logging the inode new references (names) are added or removed
- *    from the inode, leaving the logged inode item with a link count that does
- *    not match the number of logged inode reference items. This is fine because
- *    at log replay time we compute the real number of links and correct the
- *    link count in the inode item (see replay_one_buffer() and
- *    link_to_fixup_dir());
- *
- * 2) For directories we log with a mode of LOG_INODE_ALL. It's possible that
- *    while logging the inode's items new index items (key type
- *    BTRFS_DIR_INDEX_KEY) are added to fs/subvol tree and the logged inode item
- *    has a size that doesn't match the sum of the lengths of all the logged
- *    names - this is ok, not a problem, because at log replay time we set the
- *    directory's i_size to the correct value (see replay_one_name() and
- *    do_overwrite_item()).
- */
-static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
-				struct btrfs_inode *start_inode,
-				struct btrfs_log_ctx *ctx)
-{
-	struct btrfs_root *root = start_inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
-	LIST_HEAD(dir_list);
-	struct btrfs_dir_list *dir_elem;
-	u64 ino = btrfs_ino(start_inode);
-	int ret = 0;
-
-	/*
-	 * If we are logging a new name, as part of a link or rename operation,
-	 * don't bother logging new dentries, as we just want to log the names
-	 * of an inode and that any new parents exist.
-	 */
-	if (ctx->logging_new_name)
-		return 0;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	while (true) {
-		struct extent_buffer *leaf;
-		struct btrfs_key min_key;
-		bool continue_curr_inode = true;
-		int nritems;
-		int i;
-
-		min_key.objectid = ino;
-		min_key.type = BTRFS_DIR_INDEX_KEY;
-		min_key.offset = 0;
-again:
-		btrfs_release_path(path);
-		ret = btrfs_search_forward(root, &min_key, path, trans->transid);
-		if (ret < 0) {
-			break;
-		} else if (ret > 0) {
-			ret = 0;
-			goto next;
-		}
-
-		leaf = path->nodes[0];
-		nritems = btrfs_header_nritems(leaf);
-		for (i = path->slots[0]; i < nritems; i++) {
-			struct btrfs_dir_item *di;
-			struct btrfs_key di_key;
-			struct inode *di_inode;
-			int log_mode = LOG_INODE_EXISTS;
-			int type;
-
-			btrfs_item_key_to_cpu(leaf, &min_key, i);
-			if (min_key.objectid != ino ||
-			    min_key.type != BTRFS_DIR_INDEX_KEY) {
-				continue_curr_inode = false;
-				break;
-			}
-
-			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
-			type = btrfs_dir_type(leaf, di);
-			if (btrfs_dir_transid(leaf, di) < trans->transid)
-				continue;
-			btrfs_dir_item_key_to_cpu(leaf, di, &di_key);
-			if (di_key.type == BTRFS_ROOT_ITEM_KEY)
-				continue;
-
-			btrfs_release_path(path);
-			di_inode = btrfs_iget(fs_info->sb, di_key.objectid, root);
-			if (IS_ERR(di_inode)) {
-				ret = PTR_ERR(di_inode);
-				goto out;
-			}
-
-			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-				btrfs_add_delayed_iput(di_inode);
-				break;
-			}
-
-			ctx->log_new_dentries = false;
-			if (type == BTRFS_FT_DIR)
-				log_mode = LOG_INODE_ALL;
-			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
-					      log_mode, ctx);
-			btrfs_add_delayed_iput(di_inode);
-			if (ret)
-				goto out;
-			if (ctx->log_new_dentries) {
-				dir_elem = kmalloc(sizeof(*dir_elem), GFP_NOFS);
-				if (!dir_elem) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				dir_elem->ino = di_key.objectid;
-				list_add_tail(&dir_elem->list, &dir_list);
-			}
-			break;
-		}
-
-		if (continue_curr_inode && min_key.offset < (u64)-1) {
-			min_key.offset++;
-			goto again;
-		}
-
-next:
-		if (list_empty(&dir_list))
-			break;
-
-		dir_elem = list_first_entry(&dir_list, struct btrfs_dir_list, list);
-		ino = dir_elem->ino;
-		list_del(&dir_elem->list);
-		kfree(dir_elem);
-	}
-out:
-	btrfs_free_path(path);
-	if (ret) {
-		struct btrfs_dir_list *next;
-
-		list_for_each_entry_safe(dir_elem, next, &dir_list, list)
-			kfree(dir_elem);
-	}
-
-	return ret;
-}
-
 static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				 struct btrfs_inode *inode,
 				 struct btrfs_log_ctx *ctx)
-- 
2.35.1

