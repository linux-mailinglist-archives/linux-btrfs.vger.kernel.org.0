Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026687C9E4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 06:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjJPEjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 00:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjJPEjw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 00:39:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F55E3
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Oct 2023 21:39:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80F2721C1B
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697431155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryX1DZEU18eRXd46qs/4kFiVXZkETA0AuES9jJSdSN4=;
        b=PleuDlgAgEVQqTQEYIlfzVId3VJnbraMAlKfYxY0GjdvEwy8RzFIHniNZncJPm1H05LHRE
        esWNszIPTkjLEzpf4YyzyprX0AkgZID1y4uc+W+cn1j1CvSHkUtO0W6mOeT3lguX2CO2Nx
        +/BXxDTjmphO8m8EtiHzQtUfVezDay4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACE94138EF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MLfQGnK+LGUaFgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs-progs: enhance btrfs_create_root() function
Date:   Mon, 16 Oct 2023 15:08:49 +1030
Message-ID: <c8cab2a10f5ea3bc5b0be609cab56c7978715d74.1697430866.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697430866.git.wqu@suse.com>
References: <cover.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch does the following changes:

- Remove the @fs_info parameter
  It can be fetched from @trans.

- Update a comment
  Now the function can update fs_info pointers for not only quota tree,
  but also block group tree.

- Error out immediately if the @objectid is invalid

- Use btrfs_create_tree() to handle the root item/node creation

- Do not update fs_info root pointers before the root fully created
  This is to prevent an use-after-free if we failed to insert the root
  item.

- Add subvolume and data reloc tree into the fs roots cache
  This is to prevent eb leak on root->node.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 106 ++++++++++++++++++------------------------
 kernel-shared/ctree.h |   3 +-
 mkfs/main.c           |   2 +-
 tune/convert-bgt.c    |   3 +-
 tune/quota.c          |   2 +-
 5 files changed, 48 insertions(+), 68 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 61cf125cc136..38c41135d438 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -26,8 +26,10 @@
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/tree-checker.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/messages.h"
 #include "common/internal.h"
 #include "common/messages.h"
+#include "common/rbtree-utils.h"
 
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
@@ -331,57 +333,17 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
  *
  * NOTE: Doesn't support tree with non-zero offset, like data reloc tree.
  */
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid)
+int btrfs_create_root(struct btrfs_trans_handle *trans, u64 objectid)
 {
-	struct extent_buffer *node;
-	struct btrfs_root *new_root;
-	struct btrfs_disk_key disk_key;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct extent_buffer *node = NULL;
+	struct btrfs_root *new_root = NULL;
 	struct btrfs_key location;
-	struct btrfs_root_item root_item = { 0 };
-	int ret;
-
-	new_root = malloc(sizeof(*new_root));
-	if (!new_root)
-		return -ENOMEM;
-
-	btrfs_setup_root(new_root, fs_info, objectid);
-	if (!is_fstree(objectid))
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &new_root->state);
-	add_root_to_dirty_list(new_root);
-
-	new_root->objectid = objectid;
-	new_root->root_key.objectid = objectid;
-	new_root->root_key.type = BTRFS_ROOT_ITEM_KEY;
-	new_root->root_key.offset = 0;
-
-	node = btrfs_alloc_tree_block(trans, new_root, fs_info->nodesize,
-				      objectid, &disk_key, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
-	if (IS_ERR(node)) {
-		ret = PTR_ERR(node);
-		error("failed to create root node for tree %llu: %d (%m)",
-		      objectid, ret);
-		return ret;
-	}
-	new_root->node = node;
-
-	memset_extent_buffer(node, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(node, node->start);
-	btrfs_set_header_generation(node, trans->transid);
-	btrfs_set_header_backref_rev(node, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(node, objectid);
-	write_extent_buffer_fsid(node, fs_info->fs_devices->metadata_uuid);
-	write_extent_buffer_chunk_tree_uuid(node, fs_info->chunk_tree_uuid);
-	btrfs_set_header_nritems(node, 0);
-	btrfs_set_header_level(node, 0);
-	ret = btrfs_inc_ref(trans, new_root, node, 0);
-	if (ret < 0)
-		goto free;
+	int ret = 0;
 
 	/*
 	 * Special tree roots may need to modify pointers in @fs_info
-	 * Only quota is supported yet.
+	 * Only quota and block group trees are supported yet.
 	 */
 	switch (objectid) {
 	case BTRFS_QUOTA_TREE_OBJECTID:
@@ -390,8 +352,6 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 			ret = -EEXIST;
 			goto free;
 		}
-		fs_info->quota_root = new_root;
-		fs_info->quota_enabled = 1;
 		break;
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		if (fs_info->block_group_root) {
@@ -399,9 +359,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 			ret = -EEXIST;
 			goto free;
 		}
-		fs_info->block_group_root = new_root;
 		break;
-
 	/*
 	 * Essential trees can't be created by this function, yet.
 	 * As we expect such skeleton exists, or a lot of functions like
@@ -414,27 +372,51 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 		ret = -EEXIST;
 		goto free;
 	default:
-		/* Subvolume trees don't need special handling */
-		if (is_fstree(objectid))
+		/*
+		 * Subvolume trees don't need special handling.
+		 * In progs we also treat DATA_RELOC tree just as a subvolume.
+		 */
+		if (is_fstree(objectid) || objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
 			break;
 		/* Other special trees are not supported yet */
 		ret = -ENOTTY;
 		goto free;
 	}
-	btrfs_mark_buffer_dirty(node);
-	btrfs_set_root_bytenr(&root_item, btrfs_header_bytenr(node));
-	btrfs_set_root_level(&root_item, 0);
-	btrfs_set_root_generation(&root_item, trans->transid);
-	btrfs_set_root_dirid(&root_item, 0);
-	btrfs_set_root_refs(&root_item, 1);
-	btrfs_set_root_used(&root_item, fs_info->nodesize);
+
 	location.objectid = objectid;
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
+	new_root = btrfs_create_tree(trans, fs_info, &location);
+	if (IS_ERR(new_root)) {
+		ret = PTR_ERR(new_root);
+		errno = -ret;
+		error("failed to create new tree for rootid %lld: %m", objectid);
+		return ret;
+	}
 
-	ret = btrfs_insert_root(trans, fs_info->tree_root, &location, &root_item);
-	if (ret < 0)
-		goto free;
+	add_root_to_dirty_list(new_root);
+
+	switch (objectid) {
+	case BTRFS_QUOTA_TREE_OBJECTID:
+		fs_info->quota_root = new_root;
+		fs_info->quota_enabled = 1;
+		break;
+	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+		fs_info->block_group_root = new_root;
+		break;
+	default:
+		/*
+		 * We need to add subvolume trees to its rb tree, or we will
+		 * leak root->node.
+		 */
+		ASSERT(is_fstree(objectid) ||
+		       objectid == BTRFS_DATA_RELOC_TREE_OBJECTID);
+		ret = rb_insert(&fs_info->fs_root_tree, &new_root->rb_node,
+				btrfs_fs_roots_compare_roots);
+		if (ret < 0)
+			goto free;
+		set_bit(BTRFS_ROOT_SHAREABLE, &new_root->state);
+	}
 	return ret;
 
 free:
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a10a30e36b94..1dda40e96a60 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -988,8 +988,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid);
+int btrfs_create_root(struct btrfs_trans_handle *trans, u64 objectid);
 void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
diff --git a/mkfs/main.c b/mkfs/main.c
index 7d0ffac309e8..9584386da4ca 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1006,7 +1006,7 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 		error_msg(ERROR_MSG_START_TRANS, "%m");
 		return ret;
 	}
-	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
+	ret = btrfs_create_root(trans, BTRFS_QUOTA_TREE_OBJECTID);
 	if (ret < 0) {
 		error("failed to create quota root: %d (%m)", ret);
 		goto fail;
diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
index dd3a8c750604..a027e50b79a0 100644
--- a/tune/convert-bgt.c
+++ b/tune/convert-bgt.c
@@ -54,8 +54,7 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
 	if (btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_CHANGING_BG_TREE)
 		goto iterate_bgs;
 
-	ret = btrfs_create_root(trans, fs_info,
-				BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+	ret = btrfs_create_root(trans, BTRFS_BLOCK_GROUP_TREE_OBJECTID);
 	if (ret < 0) {
 		error("failed to create block group root: %d", ret);
 		goto error;
diff --git a/tune/quota.c b/tune/quota.c
index a14f453078d5..5896a61e61d6 100644
--- a/tune/quota.c
+++ b/tune/quota.c
@@ -107,7 +107,7 @@ int enable_quota(struct btrfs_fs_info *fs_info, bool simple)
 		return ret;
 	}
 
-	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
+	ret = btrfs_create_root(trans, BTRFS_QUOTA_TREE_OBJECTID);
 	if (ret < 0) {
 		error("failed to create quota root: %d (%m)", ret);
 		goto fail;
-- 
2.42.0

