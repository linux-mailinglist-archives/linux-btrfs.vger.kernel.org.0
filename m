Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA247C9E49
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 06:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjJPEjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjJPEjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 00:39:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39763E3
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Oct 2023 21:39:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D083F1FDCC
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697431156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBjraN6mtFK/01tErLFa8SE7SFAU4huUsB9udr8y+u8=;
        b=Rk/A6yhDY6a3OqRGu4o6w0Dh+A5tmpnKOC2Q8TJwbDF6jHR/k1V7c3hBG4WKTGjCihZsFr
        3fQP87WvIPe/YZiDdC1fR8QqHkn/FYdYlmfVPjUj4mKR9CCvYtV/3EuZI4cCe8tvbLQsWx
        t7uJp7sP+kMcp/laGbumnvKMs1taXoQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 067C6138EF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uCnhLXO+LGUaFgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol() implementation
Date:   Mon, 16 Oct 2023 15:08:50 +1030
Message-ID: <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697430866.git.wqu@suse.com>
References: <cover.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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

To create a subvolume there are several different helpers:

- create_subvol() from convert/main.c
  This relies one using an empty fs_root tree to copy its root item.
  But otherwise has a pretty well wrapper btrfs_ake_root_dir() helper to
  handle the inode item/ref insertion.

- create_data_reloc_tree() from mkfs/main.c
  This is already pretty usable for generic subvolume creation, the only
  bad code is the open-coded rootdir setup.

So here this patch introduce a better version with all the benefit from
the above implementations:

- Move btrfs_make_root_dir() into kernel-shared/root-tree.[ch]

- Implement a unified btrfs_make_subvol() to replace above two implementations
  It would go with btrfs_create_root(), and btrfs_make_root_dir() to
  remove duplicated code, and return a btrfs_root pointer for caller
  to utilize.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c            | 55 +++++--------------------
 kernel-shared/ctree.h     |  4 ++
 kernel-shared/root-tree.c | 86 +++++++++++++++++++++++++++++++++++++++
 mkfs/common.c             | 39 ------------------
 mkfs/common.h             |  2 -
 mkfs/main.c               | 78 +++--------------------------------
 6 files changed, 107 insertions(+), 157 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index 73740fe26d55..453e2c003c20 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -915,44 +915,6 @@ out:
 	return ret;
 }
 
-static int create_subvol(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root, u64 root_objectid)
-{
-	struct extent_buffer *tmp;
-	struct btrfs_root *new_root;
-	struct btrfs_key key;
-	struct btrfs_root_item root_item;
-	int ret;
-
-	ret = btrfs_copy_root(trans, root, root->node, &tmp,
-			      root_objectid);
-	if (ret)
-		return ret;
-
-	memcpy(&root_item, &root->root_item, sizeof(root_item));
-	btrfs_set_root_bytenr(&root_item, tmp->start);
-	btrfs_set_root_level(&root_item, btrfs_header_level(tmp));
-	btrfs_set_root_generation(&root_item, trans->transid);
-	free_extent_buffer(tmp);
-
-	key.objectid = root_objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = trans->transid;
-	ret = btrfs_insert_root(trans, root->fs_info->tree_root,
-				&key, &root_item);
-
-	key.offset = (u64)-1;
-	new_root = btrfs_read_fs_root(root->fs_info, &key);
-	if (!new_root || IS_ERR(new_root)) {
-		error("unable to fs read root: %lu", PTR_ERR(new_root));
-		return PTR_ERR(new_root);
-	}
-
-	ret = btrfs_make_root_dir(trans, new_root, BTRFS_FIRST_FREE_OBJECTID);
-
-	return ret;
-}
-
 /*
  * New make_btrfs() has handle system and meta chunks quite well.
  * So only need to add remaining data chunks.
@@ -1012,6 +974,7 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 static int init_btrfs(struct btrfs_mkfs_config *cfg, struct btrfs_root *root,
 			 struct btrfs_convert_context *cctx, u32 convert_flags)
 {
+	struct btrfs_root *created_root;
 	struct btrfs_key location;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1057,15 +1020,19 @@ static int init_btrfs(struct btrfs_mkfs_config *cfg, struct btrfs_root *root,
 			     BTRFS_FIRST_FREE_OBJECTID);
 
 	/* subvol for fs image file */
-	ret = create_subvol(trans, root, CONV_IMAGE_SUBVOL_OBJECTID);
-	if (ret < 0) {
-		error("failed to create subvolume image root: %d", ret);
+	created_root = btrfs_create_subvol(trans, CONV_IMAGE_SUBVOL_OBJECTID);
+	if (IS_ERR(created_root)) {
+		ret = PTR_ERR(created_root);
+		errno = -ret;
+		error("failed to create subvolume image root: %m");
 		goto err;
 	}
 	/* subvol for data relocation tree */
-	ret = create_subvol(trans, root, BTRFS_DATA_RELOC_TREE_OBJECTID);
-	if (ret < 0) {
-		error("failed to create DATA_RELOC root: %d", ret);
+	created_root = btrfs_create_subvol(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	if (IS_ERR(created_root)) {
+		ret = PTR_ERR(created_root);
+		errno = -ret;
+		error("failed to create DATA_RELOC root: %m");
 		goto err;
 	}
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 1dda40e96a60..ea459464063d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1134,6 +1134,10 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *item);
 int btrfs_find_last_root(struct btrfs_root *root, u64 objectid, struct
 			 btrfs_root_item *item, struct btrfs_key *key);
+int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root, u64 objectid);
+struct btrfs_root *btrfs_create_subvol(struct btrfs_trans_handle *trans,
+				       u64 objectid);
 /* dir-item.c */
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct btrfs_root
 			  *root, const char *name, int name_len, u64 dir,
diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
index 33f9e4697b18..1fe7d535fdc7 100644
--- a/kernel-shared/root-tree.c
+++ b/kernel-shared/root-tree.c
@@ -19,12 +19,15 @@
 #include "kerncompat.h"
 #include <errno.h>
 #include <string.h>
+#include <time.h>
 #include "kernel-lib/bitops.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/transaction.h"
+#include "common/messages.h"
 
 int btrfs_find_last_root(struct btrfs_root *root, u64 objectid,
 			struct btrfs_root_item *item, struct btrfs_key *key)
@@ -224,3 +227,86 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans,
 	btrfs_free_path(path);
 	return ret;
 }
+
+int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root, u64 objectid)
+{
+	int ret;
+	struct btrfs_inode_item inode_item;
+	time_t now = time(NULL);
+
+	memset(&inode_item, 0, sizeof(inode_item));
+	btrfs_set_stack_inode_generation(&inode_item, trans->transid);
+	btrfs_set_stack_inode_size(&inode_item, 0);
+	btrfs_set_stack_inode_nlink(&inode_item, 1);
+	btrfs_set_stack_inode_nbytes(&inode_item, root->fs_info->nodesize);
+	btrfs_set_stack_inode_mode(&inode_item, S_IFDIR | 0755);
+	btrfs_set_stack_timespec_sec(&inode_item.atime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.atime, 0);
+	btrfs_set_stack_timespec_sec(&inode_item.ctime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.ctime, 0);
+	btrfs_set_stack_timespec_sec(&inode_item.mtime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.mtime, 0);
+	btrfs_set_stack_timespec_sec(&inode_item.otime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.otime, 0);
+
+	if (root->fs_info->tree_root == root)
+		btrfs_set_super_root_dir(root->fs_info->super_copy, objectid);
+
+	ret = btrfs_insert_inode(trans, root, objectid, &inode_item);
+	if (ret)
+		goto error;
+
+	ret = btrfs_insert_inode_ref(trans, root, "..", 2, objectid, objectid, 0);
+	if (ret)
+		goto error;
+
+	btrfs_set_root_dirid(&root->root_item, objectid);
+	ret = 0;
+error:
+	return ret;
+}
+
+struct btrfs_root *btrfs_create_subvol(struct btrfs_trans_handle *trans,
+				       u64 objectid)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root;
+	struct btrfs_key key;
+	int ret;
+
+	ret = btrfs_create_root(trans, objectid);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to create root %lld: %m", objectid);
+		return ERR_PTR(ret);
+	}
+	key.objectid = objectid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+
+	root = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		errno = -ret;
+		error("failed to read created subvolume %lld: %m", objectid);
+		return ERR_PTR(ret);
+	}
+
+	ret = btrfs_make_root_dir(trans, root, BTRFS_FIRST_FREE_OBJECTID);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to update root dir for root %llu",
+		      root->root_key.objectid);
+		return ERR_PTR(ret);
+	}
+	ret = btrfs_update_root(trans, trans->fs_info->tree_root,
+				&root->root_key, &root->root_item);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to update root %llu",
+		      root->root_key.objectid);
+		return ERR_PTR(ret);
+	}
+	return root;
+}
diff --git a/mkfs/common.c b/mkfs/common.c
index d400413c7d41..34798f79026b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -752,45 +752,6 @@ out:
 	return ret;
 }
 
-int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root, u64 objectid)
-{
-	int ret;
-	struct btrfs_inode_item inode_item;
-	time_t now = time(NULL);
-
-	memset(&inode_item, 0, sizeof(inode_item));
-	btrfs_set_stack_inode_generation(&inode_item, trans->transid);
-	btrfs_set_stack_inode_size(&inode_item, 0);
-	btrfs_set_stack_inode_nlink(&inode_item, 1);
-	btrfs_set_stack_inode_nbytes(&inode_item, root->fs_info->nodesize);
-	btrfs_set_stack_inode_mode(&inode_item, S_IFDIR | 0755);
-	btrfs_set_stack_timespec_sec(&inode_item.atime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.atime, 0);
-	btrfs_set_stack_timespec_sec(&inode_item.ctime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.ctime, 0);
-	btrfs_set_stack_timespec_sec(&inode_item.mtime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.mtime, 0);
-	btrfs_set_stack_timespec_sec(&inode_item.otime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.otime, 0);
-
-	if (root->fs_info->tree_root == root)
-		btrfs_set_super_root_dir(root->fs_info->super_copy, objectid);
-
-	ret = btrfs_insert_inode(trans, root, objectid, &inode_item);
-	if (ret)
-		goto error;
-
-	ret = btrfs_insert_inode_ref(trans, root, "..", 2, objectid, objectid, 0);
-	if (ret)
-		goto error;
-
-	btrfs_set_root_dirid(&root->root_item, objectid);
-	ret = 0;
-error:
-	return ret;
-}
-
 /*
  * Btrfs minimum size calculation is complicated, it should include at least:
  * 1. system group size
diff --git a/mkfs/common.h b/mkfs/common.h
index 06ddc926390f..659529b90f6e 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -98,8 +98,6 @@ struct btrfs_mkfs_config {
 };
 
 int make_btrfs(int fd, struct btrfs_mkfs_config *cfg);
-int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root, u64 objectid);
 u64 btrfs_min_dev_size(u32 nodesize, int mixed, u64 meta_profile,
 		       u64 data_profile);
 int test_minimum_size(const char *file, u64 min_dev_size);
diff --git a/mkfs/main.c b/mkfs/main.c
index 9584386da4ca..42aa68b7ecf4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -705,75 +705,6 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_inode_item *inode;
-	struct btrfs_root *root;
-	struct btrfs_path path = { 0 };
-	struct btrfs_key key = {
-		.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID,
-		.type = BTRFS_ROOT_ITEM_KEY,
-	};
-	u64 ino = BTRFS_FIRST_FREE_OBJECTID;
-	char *name = "..";
-	int ret;
-
-	root = btrfs_create_tree(trans, fs_info, &key);
-	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
-	}
-	/* Update dirid as created tree has default dirid 0 */
-	btrfs_set_root_dirid(&root->root_item, ino);
-	ret = btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
-				&root->root_item);
-	if (ret < 0)
-		goto out;
-
-	/* Cache this tree so it can be cleaned up at close_ctree() */
-	ret = rb_insert(&fs_info->fs_root_tree, &root->rb_node,
-			btrfs_fs_roots_compare_roots);
-	if (ret < 0)
-		goto out;
-
-	/* Insert INODE_ITEM */
-	ret = btrfs_new_inode(trans, root, ino, 0755 | S_IFDIR);
-	if (ret < 0)
-		goto out;
-
-	/* then INODE_REF */
-	ret = btrfs_insert_inode_ref(trans, root, name, strlen(name), ino, ino,
-				     0);
-	if (ret < 0)
-		goto out;
-
-	/* Update nlink of that inode item */
-	key.objectid = ino;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
-	if (ret > 0) {
-		ret = -ENOENT;
-		btrfs_release_path(&path);
-		goto out;
-	}
-	if (ret < 0) {
-		btrfs_release_path(&path);
-		goto out;
-	}
-	inode = btrfs_item_ptr(path.nodes[0], path.slots[0],
-			       struct btrfs_inode_item);
-	btrfs_set_inode_nlink(path.nodes[0], inode, 1);
-	btrfs_mark_buffer_dirty(path.nodes[0]);
-	btrfs_release_path(&path);
-	return 0;
-out:
-	btrfs_abort_transaction(trans, ret);
-	return ret;
-}
-
 static int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid,
 			       u8 type, u64 subvol_id_cpu)
 {
@@ -1138,6 +1069,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
 	struct btrfs_root *root;
+	struct btrfs_root *data_reloc_root;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_trans_handle *trans;
 	struct open_ctree_args oca = { 0 };
@@ -1887,9 +1819,11 @@ raid_groups:
 		goto out;
 	}
 
-	ret = create_data_reloc_tree(trans);
-	if (ret) {
-		error("unable to create data reloc tree: %d", ret);
+	data_reloc_root = btrfs_create_subvol(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	if (IS_ERR(data_reloc_root)) {
+		ret = PTR_ERR(data_reloc_root);
+		errno = -ret;
+		error("unable to create data reloc tree: %m");
 		goto out;
 	}
 
-- 
2.42.0

