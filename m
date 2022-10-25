Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5660BFCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 02:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJYAmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 20:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJYAmQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 20:42:16 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983B6FC54;
        Mon, 24 Oct 2022 16:13:51 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C548B811C2;
        Mon, 24 Oct 2022 19:13:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1666653231; bh=QS+zTFayoagkLtb4ZnEgjHaN0OgqjfoAJHY4g7I8TGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7zU2oklyiKWMn0msHkSm3sI1AARtQcakknpL0hdkk1QjfCY2yxVjYxYWvVNaxAx3
         Y47fjmd+46TYzbfRC1cGC1zpbirfEYeIZp+OXNYOVnFry5RNA5Z38EE+sLRkxAjJUl
         kYqrlEa/NBfOTdxC4ihTSaIPIbRif3/K4jTMzqGidqUGXtrnNhSz95MLFXnLFkInx6
         czo1kXMOG4QWbQrsYuTeplPfi3QK0RrRfoTJ8NdgrqRL/gsvRp8Umq+XvuxLKQLgvL
         /PH/kfEckv8jVZXsZdYtcfd8FeOApVJASzIBTPGGdC5wH0ecOYPVkOHz+Dt95tDpCn
         2pcZ+S2DzB7Fw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 07/21] btrfs: use struct qstr instead of name and namelen
Date:   Mon, 24 Oct 2022 19:13:17 -0400
Message-Id: <8772216302ada4c9a969cb91c594b259df1ce1d2.1666651724.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1666651724.git.sweettea-kernel@dorminy.me>
References: <cover.1666651724.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Many functions throughout btrfs take name buffer and name length
arguments. Most of these functions at the highest level are usually
called with these arguments extracted from a supplied dentry's name.
But the entire name can be passed instead, making each function a little
more elegant.

Each function whose arguments are currently the name and length
extracted from a dentry is herein converted to instead take a pointer to
the name in the dentry. The couple of calls to these calls without a
struct dentry are converted to create an appropriate qstr to pass in.
Additionally, every function which is only called with a name/len
extracted directly from a qstr is also converted.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h       |  26 ++--
 fs/btrfs/dir-item.c    |  50 ++++----
 fs/btrfs/inode-item.c  |  73 ++++++------
 fs/btrfs/inode-item.h  |  20 ++--
 fs/btrfs/inode.c       | 128 +++++++++-----------
 fs/btrfs/ioctl.c       |   7 +-
 fs/btrfs/root-tree.c   |  19 ++-
 fs/btrfs/send.c        |  11 +-
 fs/btrfs/super.c       |   3 +-
 fs/btrfs/transaction.c |  11 +-
 fs/btrfs/tree-log.c    | 263 +++++++++++++++++++----------------------
 fs/btrfs/tree-log.h    |   4 +-
 12 files changed, 283 insertions(+), 332 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f5beb0dff2be..d80ebd5b1a83 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1516,11 +1516,11 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 
 /* root-item.c */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
-		       int name_len);
+		       u64 ref_id, u64 dirid, u64 sequence,
+		       const struct qstr *name);
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 *sequence, const char *name,
-		       int name_len);
+		       u64 ref_id, u64 dirid, u64 *sequence,
+		       const struct qstr *name);
 int btrfs_del_root(struct btrfs_trans_handle *trans,
 		   const struct btrfs_key *key);
 int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
@@ -1549,25 +1549,23 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
 /* dir-item.c */
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
-			  const char *name, int name_len);
-int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
-			  int name_len, struct btrfs_inode *dir,
+			  const struct qstr *name);
+int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
+			  const struct qstr *name, struct btrfs_inode *dir,
 			  struct btrfs_key *location, u8 type, u64 index);
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
-					     const char *name, int name_len,
-					     int mod);
+					     const struct qstr *name, int mod);
 struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 index, const char *name, int name_len,
-			    int mod);
+			    u64 index, const struct qstr *name, int mod);
 struct btrfs_dir_item *
 btrfs_search_dir_index_item(struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dirid,
-			    const char *name, int name_len);
+			    const struct qstr *name);
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
@@ -1648,10 +1646,10 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const char *name, int name_len);
+		       const struct qstr *name);
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
-		   const char *name, int name_len, int add_backref, u64 index);
+		   const struct qstr *name, int add_backref, u64 index);
 int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
 int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			 int front);
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 9fa37f245c43..48a15af4ec57 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -105,8 +105,8 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
  * to use for the second index (if one is created).
  * Will return 0 or -ENOMEM
  */
-int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
-			  int name_len, struct btrfs_inode *dir,
+int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
+			  const struct qstr *name, struct btrfs_inode *dir,
 			  struct btrfs_key *location, u8 type, u64 index)
 {
 	int ret = 0;
@@ -122,7 +122,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	key.objectid = btrfs_ino(dir);
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(name->name, name->len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -130,9 +130,9 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	btrfs_cpu_key_to_disk(&disk_key, location);
 
-	data_size = sizeof(*dir_item) + name_len;
+	data_size = sizeof(*dir_item) + name->len;
 	dir_item = insert_with_overflow(trans, root, path, &key, data_size,
-					name, name_len);
+					name->name, name->len);
 	if (IS_ERR(dir_item)) {
 		ret = PTR_ERR(dir_item);
 		if (ret == -EEXIST)
@@ -144,11 +144,11 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
 	btrfs_set_dir_type(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
-	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_name_len(leaf, dir_item, name->len);
 	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
 	name_ptr = (unsigned long)(dir_item + 1);
 
-	write_extent_buffer(leaf, name, name_ptr, name_len);
+	write_extent_buffer(leaf, name->name, name_ptr, name->len);
 	btrfs_mark_buffer_dirty(leaf);
 
 second_insert:
@@ -159,7 +159,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	}
 	btrfs_release_path(path);
 
-	ret2 = btrfs_insert_delayed_dir_index(trans, name, name_len, dir,
+	ret2 = btrfs_insert_delayed_dir_index(trans, name->name, name->len, dir,
 					      &disk_key, type, index);
 out_free:
 	btrfs_free_path(path);
@@ -208,7 +208,7 @@ static struct btrfs_dir_item *btrfs_lookup_match_dir(
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
-					     const char *name, int name_len,
+					     const struct qstr *name,
 					     int mod)
 {
 	struct btrfs_key key;
@@ -216,9 +216,10 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(name->name, name->len);
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name->name,
+				    name->len, mod);
 	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
@@ -226,7 +227,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
-				   const char *name, int name_len)
+				   const struct qstr *name)
 {
 	int ret;
 	struct btrfs_key key;
@@ -242,9 +243,10 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(name->name, name->len);
 
-	di = btrfs_lookup_match_dir(NULL, root, path, &key, name, name_len, 0);
+	di = btrfs_lookup_match_dir(NULL, root, path, &key, name->name,
+				    name->len, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		/* Nothing found, we're safe */
@@ -264,11 +266,8 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 		goto out;
 	}
 
-	/*
-	 * see if there is room in the item to insert this
-	 * name
-	 */
-	data_size = sizeof(*di) + name_len;
+	/* See if there is room in the item to insert this name. */
+	data_size = sizeof(*di) + name->len;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	if (data_size + btrfs_item_size(leaf, slot) +
@@ -305,8 +304,7 @@ struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 index, const char *name, int name_len,
-			    int mod)
+			    u64 index, const struct qstr *name, int mod)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -315,7 +313,8 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = index;
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name->name,
+				    name->len, mod);
 	if (di == ERR_PTR(-ENOENT))
 		return NULL;
 
@@ -323,9 +322,8 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 }
 
 struct btrfs_dir_item *
-btrfs_search_dir_index_item(struct btrfs_root *root,
-			    struct btrfs_path *path, u64 dirid,
-			    const char *name, int name_len)
+btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
+			    u64 dirid, const struct qstr *name)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -340,7 +338,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 			break;
 
 		di = btrfs_match_dir_item_name(root->fs_info, path,
-					       name, name_len);
+					       name->name, name->len);
 		if (di)
 			return di;
 	}
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b8dbabfa8b31..577e39cfc411 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -14,8 +14,8 @@
 #include "accessors.h"
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
-						   int slot, const char *name,
-						   int name_len)
+						   int slot,
+						   const struct qstr *name)
 {
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
@@ -31,9 +31,10 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 		len = btrfs_inode_ref_name_len(leaf, ref);
 		name_ptr = (unsigned long)(ref + 1);
 		cur_offset += len + sizeof(*ref);
-		if (len != name_len)
+		if (len != name->len)
 			continue;
-		if (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+		if (memcmp_extent_buffer(leaf, name->name, name_ptr,
+					 name->len) == 0)
 			return ref;
 	}
 	return NULL;
@@ -41,7 +42,7 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
-		const char *name, int name_len)
+		const struct qstr *name)
 {
 	struct btrfs_inode_extref *extref;
 	unsigned long ptr;
@@ -64,9 +65,10 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		name_ptr = (unsigned long)(&extref->name);
 		ref_name_len = btrfs_inode_extref_name_len(leaf, extref);
 
-		if (ref_name_len == name_len &&
+		if (ref_name_len == name->len &&
 		    btrfs_inode_extref_parent(leaf, extref) == ref_objectid &&
-		    (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0))
+		    (memcmp_extent_buffer(leaf, name->name, name_ptr,
+					  name->len) == 0))
 			return extref;
 
 		cur_offset += ref_name_len + sizeof(*extref);
@@ -79,7 +81,7 @@ struct btrfs_inode_extref *
 btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_path *path,
-			  const char *name, int name_len,
+			  const struct qstr *name,
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow)
 {
@@ -88,7 +90,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
@@ -96,13 +98,13 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 	if (ret > 0)
 		return NULL;
 	return btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-					      ref_objectid, name, name_len);
+					      ref_objectid, name);
 
 }
 
 static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct qstr *name,
 				  u64 inode_objectid, u64 ref_objectid,
 				  u64 *index)
 {
@@ -111,14 +113,14 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_extref *extref;
 	struct extent_buffer *leaf;
 	int ret;
-	int del_len = name_len + sizeof(*extref);
+	int del_len = name->len + sizeof(*extref);
 	unsigned long ptr;
 	unsigned long item_start;
 	u32 item_size;
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -136,7 +138,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	 * readonly.
 	 */
 	extref = btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-						ref_objectid, name, name_len);
+						ref_objectid, name);
 	if (!extref) {
 		btrfs_handle_fs_error(root->fs_info, -ENOENT, NULL);
 		ret = -EROFS;
@@ -172,8 +174,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root,
-			const char *name, int name_len,
+			struct btrfs_root *root, const struct qstr *name,
 			u64 inode_objectid, u64 ref_objectid, u64 *index)
 {
 	struct btrfs_path *path;
@@ -186,7 +187,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	u32 sub_item_len;
 	int ret;
 	int search_ext_refs = 0;
-	int del_len = name_len + sizeof(*ref);
+	int del_len = name->len + sizeof(*ref);
 
 	key.objectid = inode_objectid;
 	key.offset = ref_objectid;
@@ -205,8 +206,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0], name,
-					 name_len);
+	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0], name);
 	if (!ref) {
 		ret = -ENOENT;
 		search_ext_refs = 1;
@@ -223,7 +223,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	ptr = (unsigned long)ref;
-	sub_item_len = name_len + sizeof(*ref);
+	sub_item_len = name->len + sizeof(*ref);
 	item_start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			      item_size - (ptr + sub_item_len - item_start));
@@ -237,7 +237,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		 * name in our ref array. Find and remove the extended
 		 * inode ref then.
 		 */
-		return btrfs_del_inode_extref(trans, root, name, name_len,
+		return btrfs_del_inode_extref(trans, root, name,
 					      inode_objectid, ref_objectid, index);
 	}
 
@@ -251,12 +251,13 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
  */
 static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
-				     const char *name, int name_len,
-				     u64 inode_objectid, u64 ref_objectid, u64 index)
+				     const struct qstr *name,
+				     u64 inode_objectid, u64 ref_objectid,
+				     u64 index)
 {
 	struct btrfs_inode_extref *extref;
 	int ret;
-	int ins_len = name_len + sizeof(*extref);
+	int ins_len = name->len + sizeof(*extref);
 	unsigned long ptr;
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -264,7 +265,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -276,7 +277,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 		if (btrfs_find_name_in_ext_backref(path->nodes[0],
 						   path->slots[0],
 						   ref_objectid,
-						   name, name_len))
+						   name))
 			goto out;
 
 		btrfs_extend_item(path, ins_len);
@@ -290,12 +291,12 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	ptr += btrfs_item_size(leaf, path->slots[0]) - ins_len;
 	extref = (struct btrfs_inode_extref *)ptr;
 
-	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
+	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name->len);
 	btrfs_set_inode_extref_index(path->nodes[0], extref, index);
 	btrfs_set_inode_extref_parent(path->nodes[0], extref, ref_objectid);
 
 	ptr = (unsigned long)&extref->name;
-	write_extent_buffer(path->nodes[0], name, ptr, name_len);
+	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 
 out:
@@ -305,8 +306,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 /* Will return 0, -ENOMEM, -EMLINK, or -EEXIST or anything from the CoW path */
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   const char *name, int name_len,
+			   struct btrfs_root *root, const struct qstr *name,
 			   u64 inode_objectid, u64 ref_objectid, u64 index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -315,7 +315,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
 	int ret;
-	int ins_len = name_len + sizeof(*ref);
+	int ins_len = name->len + sizeof(*ref);
 
 	key.objectid = inode_objectid;
 	key.offset = ref_objectid;
@@ -331,7 +331,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	if (ret == -EEXIST) {
 		u32 old_size;
 		ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-						 name, name_len);
+						 name);
 		if (ref)
 			goto out;
 
@@ -340,7 +340,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
 		ref = (struct btrfs_inode_ref *)((unsigned long)ref + old_size);
-		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name->len);
 		btrfs_set_inode_ref_index(path->nodes[0], ref, index);
 		ptr = (unsigned long)(ref + 1);
 		ret = 0;
@@ -348,7 +348,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret == -EOVERFLOW) {
 			if (btrfs_find_name_in_backref(path->nodes[0],
 						       path->slots[0],
-						       name, name_len))
+						       name))
 				ret = -EEXIST;
 			else
 				ret = -EMLINK;
@@ -357,11 +357,11 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	} else {
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
-		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name->len);
 		btrfs_set_inode_ref_index(path->nodes[0], ref, index);
 		ptr = (unsigned long)(ref + 1);
 	}
-	write_extent_buffer(path->nodes[0], name, ptr, name_len);
+	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 
 out:
@@ -374,7 +374,6 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (btrfs_super_incompat_flags(disk_super)
 		    & BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
 			ret = btrfs_insert_inode_extref(trans, root, name,
-							name_len,
 							inode_objectid,
 							ref_objectid, index);
 	}
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index a8fc16d0147f..3c657c670cfd 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -64,33 +64,31 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct btrfs_truncate_control *control);
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   const char *name, int name_len,
+			   struct btrfs_root *root, const struct qstr *name,
 			   u64 inode_objectid, u64 ref_objectid, u64 index);
 int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   const char *name, int name_len,
-			   u64 inode_objectid, u64 ref_objectid, u64 *index);
+			struct btrfs_root *root, const struct qstr *name,
+			u64 inode_objectid, u64 ref_objectid, u64 *index);
 int btrfs_insert_empty_inode(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path, u64 objectid);
-int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
-		       *root, struct btrfs_path *path,
+int btrfs_lookup_inode(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct btrfs_path *path,
 		       struct btrfs_key *location, int mod);
 
 struct btrfs_inode_extref *btrfs_lookup_inode_extref(
 			  struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_path *path,
-			  const char *name, int name_len,
+			  const struct qstr *name,
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow);
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
-						   int slot, const char *name,
-						   int name_len);
+						   int slot,
+						   const struct qstr *name);
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
-		const char *name, int name_len);
+		const struct qstr *name);
 
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d336efa450a3..32beee9d9d85 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3641,7 +3641,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->delayed_iput_lock);
 }
 
-/**
+/*
  * Wait for flushing all delayed iputs
  *
  * @fs_info:  the filesystem
@@ -4286,7 +4286,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir,
 				struct btrfs_inode *inode,
-				const char *name, int name_len,
+				const struct qstr *name,
 				struct btrfs_rename_ctx *rename_ctx)
 {
 	struct btrfs_root *root = dir->root;
@@ -4304,8 +4304,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				    name, name_len, -1);
+	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, name, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto err;
@@ -4333,12 +4332,11 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_del_inode_ref(trans, root, name, name_len, ino,
-				  dir_ino, &index);
+	ret = btrfs_del_inode_ref(trans, root, name, ino, dir_ino, &index);
 	if (ret) {
 		btrfs_info(fs_info,
 			"failed to delete reference to %.*s, inode %llu parent %llu",
-			name_len, name, ino, dir_ino);
+			name->len, name->name, ino, dir_ino);
 		btrfs_abort_transaction(trans, ret);
 		goto err;
 	}
@@ -4359,10 +4357,8 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	 * operations on the log tree, increasing latency for applications.
 	 */
 	if (!rename_ctx) {
-		btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
-					   dir_ino);
-		btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir,
-					     index);
+		btrfs_del_inode_ref_in_log(trans, root, name, inode, dir_ino);
+		btrfs_del_dir_entries_in_log(trans, root, name, dir, index);
 	}
 
 	/*
@@ -4380,7 +4376,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name_len * 2);
+	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
@@ -4393,10 +4389,10 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const char *name, int name_len)
+		       const struct qstr *name)
 {
 	int ret;
-	ret = __btrfs_unlink_inode(trans, dir, inode, name, name_len, NULL);
+	ret = __btrfs_unlink_inode(trans, dir, inode, name, NULL);
 	if (!ret) {
 		drop_nlink(&inode->vfs_inode);
 		ret = btrfs_update_inode(trans, inode->root, inode);
@@ -4440,9 +4436,8 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 			0);
 
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
-			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
-			dentry->d_name.len);
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
+				 &dentry->d_name);
 	if (ret)
 		goto out;
 
@@ -4467,8 +4462,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	const char *name = dentry->d_name.name;
-	int name_len = dentry->d_name.len;
+	const struct qstr *name = &dentry->d_name;
 	u64 index;
 	int ret;
 	u64 objectid;
@@ -4488,7 +4482,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				   name, name_len, -1);
+				   name, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -4514,8 +4508,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
 	 */
 	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
-		di = btrfs_search_dir_index_item(root, path, dir_ino,
-						 name, name_len);
+		di = btrfs_search_dir_index_item(root, path, dir_ino, name);
 		if (IS_ERR_OR_NULL(di)) {
 			if (!di)
 				ret = -ENOENT;
@@ -4532,7 +4525,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	} else {
 		ret = btrfs_del_root_ref(trans, objectid,
 					 root->root_key.objectid, dir_ino,
-					 &index, name, name_len);
+					 &index, name);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4545,7 +4538,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name_len * 2);
+	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name->len * 2);
 	inode_inc_iversion(dir);
 	dir->i_mtime = current_time(dir);
 	dir->i_ctime = dir->i_mtime;
@@ -4567,6 +4560,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	struct btrfs_path *path;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
+	struct qstr name = QSTR_INIT("default", 7);
 	u64 dir_id;
 	int ret;
 
@@ -4577,7 +4571,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	/* Make sure this root isn't set as the default subvol */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, fs_info->tree_root, path,
-				   dir_id, "default", 7, 0);
+				   dir_id, &name, 0);
 	if (di && !IS_ERR(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
 		if (key.objectid == root->root_key.objectid) {
@@ -4844,9 +4838,8 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
 
 	/* now the directory is empty */
-	err = btrfs_unlink_inode(trans, BTRFS_I(dir),
-			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
-			dentry->d_name.len);
+	err = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
+				 &dentry->d_name);
 	if (!err) {
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 		/*
@@ -5538,8 +5531,7 @@ void btrfs_evict_inode(struct inode *inode)
 static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 			       struct btrfs_key *location, u8 *type)
 {
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
+	const struct qstr *name = &dentry->d_name;
 	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -5550,7 +5542,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(NULL, root, path, btrfs_ino(BTRFS_I(dir)),
-			name, namelen, 0);
+				   name, 0);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -5562,7 +5554,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 		ret = -EUCLEAN;
 		btrfs_warn(root->fs_info,
 "%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
-			   __func__, name, btrfs_ino(BTRFS_I(dir)),
+			   __func__, name->name, btrfs_ino(BTRFS_I(dir)),
 			   location->objectid, location->type, location->offset);
 	}
 	if (!ret)
@@ -6321,8 +6313,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 {
 	struct inode *dir = args->dir;
 	struct inode *inode = args->inode;
-	const char *name = args->orphan ? NULL : args->dentry->d_name.name;
-	int name_len = args->orphan ? 0 : args->dentry->d_name.len;
+	const struct qstr *name = args->orphan ? NULL : &args->dentry->d_name;
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
@@ -6423,7 +6414,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			sizes[1] = 2 + sizeof(*ref);
 		} else {
 			key[1].offset = btrfs_ino(BTRFS_I(dir));
-			sizes[1] = name_len + sizeof(*ref);
+			sizes[1] = name->len + sizeof(*ref);
 		}
 	}
 
@@ -6462,10 +6453,12 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			btrfs_set_inode_ref_index(path->nodes[0], ref, 0);
 			write_extent_buffer(path->nodes[0], "..", ptr, 2);
 		} else {
-			btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+			btrfs_set_inode_ref_name_len(path->nodes[0], ref,
+						     name->len);
 			btrfs_set_inode_ref_index(path->nodes[0], ref,
 						  BTRFS_I(inode)->dir_index);
-			write_extent_buffer(path->nodes[0], name, ptr, name_len);
+			write_extent_buffer(path->nodes[0], name->name, ptr,
+					    name->len);
 		}
 	}
 
@@ -6526,7 +6519,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 	} else {
 		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-				     name_len, 0, BTRFS_I(inode)->dir_index);
+				     0, BTRFS_I(inode)->dir_index);
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -6555,7 +6548,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
  */
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
-		   const char *name, int name_len, int add_backref, u64 index)
+		   const struct qstr *name, int add_backref, u64 index)
 {
 	int ret = 0;
 	struct btrfs_key key;
@@ -6574,17 +6567,17 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_add_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
-					 index, name, name_len);
+					 index, name);
 	} else if (add_backref) {
-		ret = btrfs_insert_inode_ref(trans, root, name, name_len, ino,
-					     parent_ino, index);
+		ret = btrfs_insert_inode_ref(trans, root, name,
+					     ino, parent_ino, index);
 	}
 
 	/* Nothing to clean up yet */
 	if (ret)
 		return ret;
 
-	ret = btrfs_insert_dir_item(trans, name, name_len, parent_inode, &key,
+	ret = btrfs_insert_dir_item(trans, name, parent_inode, &key,
 				    btrfs_inode_type(&inode->vfs_inode), index);
 	if (ret == -EEXIST || ret == -EOVERFLOW)
 		goto fail_dir_item;
@@ -6594,7 +6587,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_i_size_write(parent_inode, parent_inode->vfs_inode.i_size +
-			   name_len * 2);
+			   name->len * 2);
 	inode_inc_iversion(&parent_inode->vfs_inode);
 	/*
 	 * If we are replaying a log tree, we do not want to update the mtime
@@ -6619,15 +6612,15 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		int err;
 		err = btrfs_del_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
-					 &local_index, name, name_len);
+					 &local_index, name);
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
 		u64 local_index;
 		int err;
 
-		err = btrfs_del_inode_ref(trans, root, name, name_len,
-					  ino, parent_ino, &local_index);
+		err = btrfs_del_inode_ref(trans, root, name, ino, parent_ino,
+					  &local_index);
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	}
@@ -6747,7 +6740,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     dentry->d_name.name, dentry->d_name.len, 1, index);
+			     &dentry->d_name, 1, index);
 
 	if (err) {
 		drop_inode = 1;
@@ -9080,9 +9073,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, dest,
-					     new_dentry->d_name.name,
-					     new_dentry->d_name.len,
+		ret = btrfs_insert_inode_ref(trans, dest, &new_dentry->d_name,
 					     old_ino,
 					     btrfs_ino(BTRFS_I(new_dir)),
 					     old_idx);
@@ -9096,9 +9087,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, root,
-					     old_dentry->d_name.name,
-					     old_dentry->d_name.len,
+		ret = btrfs_insert_inode_ref(trans, root, &old_dentry->d_name,
 					     new_ino,
 					     btrfs_ino(BTRFS_I(old_dir)),
 					     new_idx);
@@ -9134,8 +9123,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
-					   old_dentry->d_name.name,
-					   old_dentry->d_name.len,
+					   &old_dentry->d_name,
 					   &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
@@ -9151,8 +9139,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
-					   new_dentry->d_name.name,
-					   new_dentry->d_name.len,
+					   &new_dentry->d_name,
 					   &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
@@ -9163,16 +9150,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len, 0, old_idx);
+			     &new_dentry->d_name, 0, old_idx);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(old_dir), BTRFS_I(new_inode),
-			     old_dentry->d_name.name,
-			     old_dentry->d_name.len, 0, new_idx);
+			     &old_dentry->d_name, 0, new_idx);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
@@ -9273,8 +9258,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 
 	/* check for collisions, even if the  name isn't there */
 	ret = btrfs_check_dir_item_collision(dest, new_dir->i_ino,
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len);
+					     &new_dentry->d_name);
 
 	if (ret) {
 		if (ret == -EEXIST) {
@@ -9368,9 +9352,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, dest,
-					     new_dentry->d_name.name,
-					     new_dentry->d_name.len,
+		ret = btrfs_insert_inode_ref(trans, dest, &new_dentry->d_name,
 					     old_ino,
 					     btrfs_ino(BTRFS_I(new_dir)), index);
 		if (ret)
@@ -9394,10 +9376,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else {
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
-					BTRFS_I(d_inode(old_dentry)),
-					old_dentry->d_name.name,
-					old_dentry->d_name.len,
-					&rename_ctx);
+					   BTRFS_I(d_inode(old_dentry)),
+					   &old_dentry->d_name, &rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
 	}
@@ -9416,8 +9396,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		} else {
 			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 						 BTRFS_I(d_inode(new_dentry)),
-						 new_dentry->d_name.name,
-						 new_dentry->d_name.len);
+						 &new_dentry->d_name);
 		}
 		if (!ret && new_inode->i_nlink == 0)
 			ret = btrfs_orphan_add(trans,
@@ -9429,8 +9408,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len, 0, index);
+			     &new_dentry->d_name, 0, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bf30e48a28a8..32dd1e654846 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -951,6 +951,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct inode *dir = d_inode(parent->dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct dentry *dentry;
+	struct qstr name_str = QSTR_INIT(name, namelen);
 	int error;
 
 	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
@@ -971,8 +972,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	 * check for them now when we can safely fail
 	 */
 	error = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
-					       dir->i_ino, name,
-					       namelen);
+					       dir->i_ino, &name_str);
 	if (error)
 		goto out_dput;
 
@@ -3776,6 +3776,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path = NULL;
 	struct btrfs_disk_key disk_key;
+	struct qstr name = QSTR_INIT("default", 7);
 	u64 objectid = 0;
 	u64 dir_id;
 	int ret;
@@ -3819,7 +3820,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(trans, fs_info->tree_root, path,
-				   dir_id, "default", 7, 1);
+				   dir_id, &name, 1);
 	if (IS_ERR_OR_NULL(di)) {
 		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 74cfbbc30572..9f324b3e3990 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -331,9 +331,8 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 *sequence, const char *name,
-		       int name_len)
-
+		       u64 ref_id, u64 dirid, u64 *sequence,
+		       const struct qstr *name)
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
 	struct btrfs_path *path;
@@ -360,8 +359,8 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 				     struct btrfs_root_ref);
 		ptr = (unsigned long)(ref + 1);
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
-		    (btrfs_root_ref_name_len(leaf, ref) != name_len) ||
-		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
+		    (btrfs_root_ref_name_len(leaf, ref) != name->len) ||
+		    memcmp_extent_buffer(leaf, name->name, ptr, name->len)) {
 			ret = -ENOENT;
 			goto out;
 		}
@@ -404,8 +403,8 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
  * Will return 0, -ENOMEM, or anything from the CoW path
  */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
-		       int name_len)
+		       u64 ref_id, u64 dirid, u64 sequence,
+		       const struct qstr *name)
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
 	struct btrfs_key key;
@@ -424,7 +423,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	key.offset = ref_id;
 again:
 	ret = btrfs_insert_empty_item(trans, tree_root, path, &key,
-				      sizeof(*ref) + name_len);
+				      sizeof(*ref) + name->len);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_free_path(path);
@@ -435,9 +434,9 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	ref = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_root_ref);
 	btrfs_set_root_ref_dirid(leaf, ref, dirid);
 	btrfs_set_root_ref_sequence(leaf, ref, sequence);
-	btrfs_set_root_ref_name_len(leaf, ref, name_len);
+	btrfs_set_root_ref_name_len(leaf, ref, name->len);
 	ptr = (unsigned long)(ref + 1);
-	write_extent_buffer(leaf, name, ptr, name_len);
+	write_extent_buffer(leaf, name->name, ptr, name->len);
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index eb1f13b230a5..3c7a23d48bec 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1597,13 +1597,16 @@ static int gen_unique_name(struct send_ctx *sctx,
 		return -ENOMEM;
 
 	while (1) {
+		struct qstr tmp_name;
 		len = snprintf(tmp, sizeof(tmp), "o%llu-%llu-%llu",
 				ino, gen, idx);
 		ASSERT(len < sizeof(tmp));
+		tmp_name.name = tmp;
+		tmp_name.len = strlen(tmp);
 
 		di = btrfs_lookup_dir_item(NULL, sctx->send_root,
 				path, BTRFS_FIRST_FREE_OBJECTID,
-				tmp, strlen(tmp), 0);
+				&tmp_name, 0);
 		btrfs_release_path(path);
 		if (IS_ERR(di)) {
 			ret = PTR_ERR(di);
@@ -1623,7 +1626,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 
 		di = btrfs_lookup_dir_item(NULL, sctx->parent_root,
 				path, BTRFS_FIRST_FREE_OBJECTID,
-				tmp, strlen(tmp), 0);
+				&tmp_name, 0);
 		btrfs_release_path(path);
 		if (IS_ERR(di)) {
 			ret = PTR_ERR(di);
@@ -1753,13 +1756,13 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
 	struct btrfs_path *path;
+	struct qstr name_str = QSTR_INIT(name, name_len);
 
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
 
-	di = btrfs_lookup_dir_item(NULL, root, path,
-			dir, name, name_len, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dir, &name_str, 0);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c02fcdb9c7c4..2e3a5ba2910e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1423,6 +1423,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	struct btrfs_key location;
+	struct qstr name = QSTR_INIT("default", 7);
 	u64 dir_id;
 
 	path = btrfs_alloc_path();
@@ -1435,7 +1436,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	 * to mount.
 	 */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
-	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, "default", 7, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
 	if (IS_ERR(di)) {
 		btrfs_free_path(path);
 		return PTR_ERR(di);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 25e6b504edb4..7db9612f4d0e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1678,8 +1678,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	/* check if there is a file/dir which has the same name. */
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
 					 btrfs_ino(BTRFS_I(parent_inode)),
-					 dentry->d_name.name,
-					 dentry->d_name.len, 0);
+					 &dentry->d_name, 0);
 	if (dir_item != NULL && !IS_ERR(dir_item)) {
 		pending->error = -EEXIST;
 		goto dir_item_existed;
@@ -1774,7 +1773,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	ret = btrfs_add_root_ref(trans, objectid,
 				 parent_root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(parent_inode)), index,
-				 dentry->d_name.name, dentry->d_name.len);
+				 &dentry->d_name);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
@@ -1806,9 +1805,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto fail;
 
-	ret = btrfs_insert_dir_item(trans, dentry->d_name.name,
-				    dentry->d_name.len, BTRFS_I(parent_inode),
-				    &key, BTRFS_FT_DIR, index);
+	ret = btrfs_insert_dir_item(trans, &dentry->d_name,
+				    BTRFS_I(parent_inode), &key, BTRFS_FT_DIR,
+				    index);
 	/* We have check then name at the beginning, so it is impossible. */
 	BUG_ON(ret == -EEXIST || ret == -EOVERFLOW);
 	if (ret) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e1a47e0561aa..d6c0bce7569a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -597,6 +597,20 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 	return do_overwrite_item(trans, root, path, eb, slot, key);
 }
 
+static int read_one_name(struct extent_buffer *eb, void *start, int len,
+			 struct qstr *name)
+{
+	char *buf = kmalloc(len, GFP_NOFS);
+
+	if (!buf)
+		return -ENOMEM;
+
+	read_extent_buffer(eb, buf, (unsigned long)start, len);
+	name->name = buf;
+	name->len = len;
+	return 0;
+}
+
 /*
  * simple helper to read an inode off the disk from a given root
  * This can only be called for subvolume roots and not for the log
@@ -902,12 +916,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *dir,
 				       struct btrfs_inode *inode,
-				       const char *name,
-				       int name_len)
+				       const struct qstr *name)
 {
 	int ret;
 
-	ret = btrfs_unlink_inode(trans, dir, inode, name, name_len);
+	ret = btrfs_unlink_inode(trans, dir, inode, name);
 	if (ret)
 		return ret;
 	/*
@@ -934,8 +947,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = dir->root;
 	struct inode *inode;
-	char *name;
-	int name_len;
+	struct qstr name;
 	struct extent_buffer *leaf;
 	struct btrfs_key location;
 	int ret;
@@ -943,12 +955,10 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 
 	btrfs_dir_item_key_to_cpu(leaf, di, &location);
-	name_len = btrfs_dir_name_len(leaf, di);
-	name = kmalloc(name_len, GFP_NOFS);
-	if (!name)
+	ret = read_one_name(leaf, di + 1, btrfs_dir_name_len(leaf, di), &name);
+	if (ret)
 		return -ENOMEM;
 
-	read_extent_buffer(leaf, name, (unsigned long)(di + 1), name_len);
 	btrfs_release_path(path);
 
 	inode = read_one_inode(root, location.objectid);
@@ -961,10 +971,9 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), name,
-			name_len);
+	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), &name);
 out:
-	kfree(name);
+	kfree(name.name);
 	iput(inode);
 	return ret;
 }
@@ -979,14 +988,14 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 static noinline int inode_in_dir(struct btrfs_root *root,
 				 struct btrfs_path *path,
 				 u64 dirid, u64 objectid, u64 index,
-				 const char *name, int name_len)
+				 struct qstr *name)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key location;
 	int ret = 0;
 
 	di = btrfs_lookup_dir_index_item(NULL, root, path, dirid,
-					 index, name, name_len, 0);
+					 index, name, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		goto out;
@@ -999,7 +1008,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 	}
 
 	btrfs_release_path(path);
-	di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, name_len, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		goto out;
@@ -1026,7 +1035,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 static noinline int backref_in_log(struct btrfs_root *log,
 				   struct btrfs_key *key,
 				   u64 ref_objectid,
-				   const char *name, int namelen)
+				   const struct qstr *name)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -1046,12 +1055,10 @@ static noinline int backref_in_log(struct btrfs_root *log,
 	if (key->type == BTRFS_INODE_EXTREF_KEY)
 		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
 						       path->slots[0],
-						       ref_objectid,
-						       name, namelen);
+						       ref_objectid, name);
 	else
 		ret = !!btrfs_find_name_in_backref(path->nodes[0],
-						   path->slots[0],
-						   name, namelen);
+						   path->slots[0], name);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -1064,11 +1071,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
 				  u64 inode_objectid, u64 parent_objectid,
-				  u64 ref_index, char *name, int namelen)
+				  u64 ref_index, struct qstr *name)
 {
 	int ret;
-	char *victim_name;
-	int victim_name_len;
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key search_key;
@@ -1100,43 +1105,39 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
 		while (ptr < ptr_end) {
+			struct qstr victim_name;
 			victim_ref = (struct btrfs_inode_ref *)ptr;
-			victim_name_len = btrfs_inode_ref_name_len(leaf,
-								   victim_ref);
-			victim_name = kmalloc(victim_name_len, GFP_NOFS);
-			if (!victim_name)
-				return -ENOMEM;
-
-			read_extent_buffer(leaf, victim_name,
-					   (unsigned long)(victim_ref + 1),
-					   victim_name_len);
+			ret = read_one_name(leaf, (victim_ref + 1),
+				 btrfs_inode_ref_name_len(leaf, victim_ref),
+				 &victim_name);
+			if (ret)
+				return ret;
 
 			ret = backref_in_log(log_root, &search_key,
-					     parent_objectid, victim_name,
-					     victim_name_len);
+					     parent_objectid, &victim_name);
 			if (ret < 0) {
-				kfree(victim_name);
+				kfree(victim_name.name);
 				return ret;
 			} else if (!ret) {
 				inc_nlink(&inode->vfs_inode);
 				btrfs_release_path(path);
 
 				ret = unlink_inode_for_log_replay(trans, dir, inode,
-						victim_name, victim_name_len);
-				kfree(victim_name);
+						&victim_name);
+				kfree(victim_name.name);
 				if (ret)
 					return ret;
 				goto again;
 			}
-			kfree(victim_name);
+			kfree(victim_name.name);
 
-			ptr = (unsigned long)(victim_ref + 1) + victim_name_len;
+			ptr = (unsigned long)(victim_ref + 1) + victim_name.len;
 		}
 	}
 	btrfs_release_path(path);
 
 	/* Same search but for extended refs */
-	extref = btrfs_lookup_inode_extref(NULL, root, path, name, namelen,
+	extref = btrfs_lookup_inode_extref(NULL, root, path, name,
 					   inode_objectid, parent_objectid, 0,
 					   0);
 	if (IS_ERR(extref)) {
@@ -1153,29 +1154,27 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		base = btrfs_item_ptr_offset(leaf, path->slots[0]);
 
 		while (cur_offset < item_size) {
+			struct qstr victim_name;
 			extref = (struct btrfs_inode_extref *)(base + cur_offset);
 
-			victim_name_len = btrfs_inode_extref_name_len(leaf, extref);
-
 			if (btrfs_inode_extref_parent(leaf, extref) != parent_objectid)
 				goto next;
 
-			victim_name = kmalloc(victim_name_len, GFP_NOFS);
-			if (!victim_name)
-				return -ENOMEM;
-			read_extent_buffer(leaf, victim_name, (unsigned long)&extref->name,
-					   victim_name_len);
+			ret = read_one_name(leaf, &extref->name,
+				 btrfs_inode_extref_name_len(leaf, extref),
+				 &victim_name);
+			if (ret)
+				return ret;
 
 			search_key.objectid = inode_objectid;
 			search_key.type = BTRFS_INODE_EXTREF_KEY;
 			search_key.offset = btrfs_extref_hash(parent_objectid,
-							      victim_name,
-							      victim_name_len);
+							      victim_name.name,
+							      victim_name.len);
 			ret = backref_in_log(log_root, &search_key,
-					     parent_objectid, victim_name,
-					     victim_name_len);
+					     parent_objectid, &victim_name);
 			if (ret < 0) {
-				kfree(victim_name);
+				kfree(victim_name.name);
 				return ret;
 			} else if (!ret) {
 				ret = -ENOENT;
@@ -1187,26 +1186,24 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
 					ret = unlink_inode_for_log_replay(trans,
 							BTRFS_I(victim_parent),
-							inode,
-							victim_name,
-							victim_name_len);
+							inode, &victim_name);
 				}
 				iput(victim_parent);
-				kfree(victim_name);
+				kfree(victim_name.name);
 				if (ret)
 					return ret;
 				goto again;
 			}
-			kfree(victim_name);
+			kfree(victim_name.name);
 next:
-			cur_offset += victim_name_len + sizeof(*extref);
+			cur_offset += victim_name.len + sizeof(*extref);
 		}
 	}
 	btrfs_release_path(path);
 
 	/* look for a conflicting sequence number */
 	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
-					 ref_index, name, namelen, 0);
+					 ref_index, name, 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
@@ -1217,8 +1214,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* look for a conflicting name */
-	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir),
-				   name, namelen, 0);
+	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir), name, 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
@@ -1232,20 +1228,18 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 }
 
 static int extref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
-			     u32 *namelen, char **name, u64 *index,
+			     struct qstr *name, u64 *index,
 			     u64 *parent_objectid)
 {
 	struct btrfs_inode_extref *extref;
+	int ret;
 
 	extref = (struct btrfs_inode_extref *)ref_ptr;
 
-	*namelen = btrfs_inode_extref_name_len(eb, extref);
-	*name = kmalloc(*namelen, GFP_NOFS);
-	if (*name == NULL)
-		return -ENOMEM;
-
-	read_extent_buffer(eb, *name, (unsigned long)&extref->name,
-			   *namelen);
+	ret = read_one_name(eb, &extref->name,
+			    btrfs_inode_extref_name_len(eb, extref), name);
+	if (ret)
+		return ret;
 
 	if (index)
 		*index = btrfs_inode_extref_index(eb, extref);
@@ -1256,18 +1250,17 @@ static int extref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
 }
 
 static int ref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
-			  u32 *namelen, char **name, u64 *index)
+			  struct qstr *name, u64 *index)
 {
 	struct btrfs_inode_ref *ref;
+	int ret;
 
 	ref = (struct btrfs_inode_ref *)ref_ptr;
 
-	*namelen = btrfs_inode_ref_name_len(eb, ref);
-	*name = kmalloc(*namelen, GFP_NOFS);
-	if (*name == NULL)
-		return -ENOMEM;
-
-	read_extent_buffer(eb, *name, (unsigned long)(ref + 1), *namelen);
+	ret = read_one_name(eb, ref + 1, btrfs_inode_ref_name_len(eb, ref),
+			    name);
+	if (ret)
+		return ret;
 
 	if (index)
 		*index = btrfs_inode_ref_index(eb, ref);
@@ -1309,28 +1302,26 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 	ref_ptr = btrfs_item_ptr_offset(eb, path->slots[0]);
 	ref_end = ref_ptr + btrfs_item_size(eb, path->slots[0]);
 	while (ref_ptr < ref_end) {
-		char *name = NULL;
-		int namelen;
+		struct qstr name;
 		u64 parent_id;
 
 		if (key->type == BTRFS_INODE_EXTREF_KEY) {
-			ret = extref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = extref_get_fields(eb, ref_ptr, &name,
 						NULL, &parent_id);
 		} else {
 			parent_id = key->offset;
-			ret = ref_get_fields(eb, ref_ptr, &namelen, &name,
-					     NULL);
+			ret = ref_get_fields(eb, ref_ptr, &name, NULL);
 		}
 		if (ret)
 			goto out;
 
 		if (key->type == BTRFS_INODE_EXTREF_KEY)
 			ret = !!btrfs_find_name_in_ext_backref(log_eb, log_slot,
-							       parent_id, name,
-							       namelen);
+							       parent_id,
+							       &name);
 		else
 			ret = !!btrfs_find_name_in_backref(log_eb, log_slot,
-							   name, namelen);
+							   &name);
 
 		if (!ret) {
 			struct inode *dir;
@@ -1339,20 +1330,20 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 			dir = read_one_inode(root, parent_id);
 			if (!dir) {
 				ret = -ENOENT;
-				kfree(name);
+				kfree(name.name);
 				goto out;
 			}
 			ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
-						 inode, name, namelen);
-			kfree(name);
+						 inode, &name);
+			kfree(name.name);
 			iput(dir);
 			if (ret)
 				goto out;
 			goto again;
 		}
 
-		kfree(name);
-		ref_ptr += namelen;
+		kfree(name.name);
+		ref_ptr += name.len;
 		if (key->type == BTRFS_INODE_EXTREF_KEY)
 			ref_ptr += sizeof(struct btrfs_inode_extref);
 		else
@@ -1381,8 +1372,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	struct inode *inode = NULL;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
-	char *name = NULL;
-	int namelen;
+	struct qstr name;
 	int ret;
 	int log_ref_ver = 0;
 	u64 parent_objectid;
@@ -1426,7 +1416,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 	while (ref_ptr < ref_end) {
 		if (log_ref_ver) {
-			ret = extref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
 			/*
 			 * parent object can change from one array
@@ -1439,15 +1429,14 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 		} else {
-			ret = ref_get_fields(eb, ref_ptr, &namelen, &name,
-					     &ref_index);
+			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
 		}
 		if (ret)
 			goto out;
 
 		ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
 				   btrfs_ino(BTRFS_I(inode)), ref_index,
-				   name, namelen);
+				   &name);
 		if (ret < 0) {
 			goto out;
 		} else if (ret == 0) {
@@ -1461,7 +1450,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			ret = __add_inode_ref(trans, root, path, log,
 					      BTRFS_I(dir), BTRFS_I(inode),
 					      inode_objectid, parent_objectid,
-					      ref_index, name, namelen);
+					      ref_index, &name);
 			if (ret) {
 				if (ret == 1)
 					ret = 0;
@@ -1470,7 +1459,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 			/* insert our name */
 			ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-					     name, namelen, 0, ref_index);
+					     &name, 0, ref_index);
 			if (ret)
 				goto out;
 
@@ -1480,9 +1469,9 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
-		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
-		kfree(name);
-		name = NULL;
+		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + name.len;
+		kfree(name.name);
+		name.name = NULL;
 		if (log_ref_ver) {
 			iput(dir);
 			dir = NULL;
@@ -1506,7 +1495,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	ret = overwrite_item(trans, root, path, eb, slot, key);
 out:
 	btrfs_release_path(path);
-	kfree(name);
+	kfree(name.name);
 	iput(dir);
 	iput(inode);
 	return ret;
@@ -1778,7 +1767,7 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 				    struct btrfs_root *root,
 				    u64 dirid, u64 index,
-				    char *name, int name_len,
+				    const struct qstr *name,
 				    struct btrfs_key *location)
 {
 	struct inode *inode;
@@ -1796,7 +1785,7 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-			name_len, 1, index);
+			     1, index);
 
 	/* FIXME, put inode into FIXUP list */
 
@@ -1856,8 +1845,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 				    struct btrfs_dir_item *di,
 				    struct btrfs_key *key)
 {
-	char *name;
-	int name_len;
+	struct qstr name;
 	struct btrfs_dir_item *dir_dst_di;
 	struct btrfs_dir_item *index_dst_di;
 	bool dir_dst_matches = false;
@@ -1875,17 +1863,11 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	if (!dir)
 		return -EIO;
 
-	name_len = btrfs_dir_name_len(eb, di);
-	name = kmalloc(name_len, GFP_NOFS);
-	if (!name) {
-		ret = -ENOMEM;
+	ret = read_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
+	if (ret)
 		goto out;
-	}
 
 	log_type = btrfs_dir_type(eb, di);
-	read_extent_buffer(eb, name, (unsigned long)(di + 1),
-		   name_len);
-
 	btrfs_dir_item_key_to_cpu(eb, di, &log_key);
 	ret = btrfs_lookup_inode(trans, root, path, &log_key, 0);
 	btrfs_release_path(path);
@@ -1895,7 +1877,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	ret = 0;
 
 	dir_dst_di = btrfs_lookup_dir_item(trans, root, path, key->objectid,
-					   name, name_len, 1);
+					   &name, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
 		goto out;
@@ -1912,7 +1894,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 	index_dst_di = btrfs_lookup_dir_index_item(trans, root, path,
 						   key->objectid, key->offset,
-						   name, name_len, 1);
+						   &name, 1);
 	if (IS_ERR(index_dst_di)) {
 		ret = PTR_ERR(index_dst_di);
 		goto out;
@@ -1940,7 +1922,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = key->objectid;
-	ret = backref_in_log(root->log_root, &search_key, 0, name, name_len);
+	ret = backref_in_log(root->log_root, &search_key, 0, &name);
 	if (ret < 0) {
 	        goto out;
 	} else if (ret) {
@@ -1953,8 +1935,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
 	search_key.offset = key->objectid;
-	ret = backref_in_log(root->log_root, &search_key, key->objectid, name,
-			     name_len);
+	ret = backref_in_log(root->log_root, &search_key, key->objectid, &name);
 	if (ret < 0) {
 		goto out;
 	} else if (ret) {
@@ -1965,7 +1946,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 	ret = insert_one_name(trans, root, key->objectid, key->offset,
-			      name, name_len, &log_key);
+			      &name, &log_key);
 	if (ret && ret != -ENOENT && ret != -EEXIST)
 		goto out;
 	if (!ret)
@@ -1975,10 +1956,10 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 out:
 	if (!ret && update_size) {
-		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name_len * 2);
+		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name.len * 2);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
 	}
-	kfree(name);
+	kfree(name.name);
 	iput(dir);
 	if (!ret && name_added)
 		ret = 1;
@@ -2144,8 +2125,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_dir_item *di;
-	int name_len;
-	char *name;
+	struct qstr name;
 	struct inode *inode = NULL;
 	struct btrfs_key location;
 
@@ -2160,22 +2140,16 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	eb = path->nodes[0];
 	slot = path->slots[0];
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
-	name_len = btrfs_dir_name_len(eb, di);
-	name = kmalloc(name_len, GFP_NOFS);
-	if (!name) {
-		ret = -ENOMEM;
+	ret = read_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
+	if (ret)
 		goto out;
-	}
-
-	read_extent_buffer(eb, name, (unsigned long)(di + 1), name_len);
 
 	if (log) {
 		struct btrfs_dir_item *log_di;
 
 		log_di = btrfs_lookup_dir_index_item(trans, log, log_path,
 						     dir_key->objectid,
-						     dir_key->offset,
-						     name, name_len, 0);
+						     dir_key->offset, &name, 0);
 		if (IS_ERR(log_di)) {
 			ret = PTR_ERR(log_di);
 			goto out;
@@ -2201,7 +2175,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 
 	inc_nlink(inode);
 	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(inode),
-					  name, name_len);
+					  &name);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
@@ -2210,7 +2184,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 	btrfs_release_path(log_path);
-	kfree(name);
+	kfree(name.name);
 	iput(inode);
 	return ret;
 }
@@ -3449,7 +3423,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *log,
 			     struct btrfs_path *path,
 			     u64 dir_ino,
-			     const char *name, int name_len,
+			     const struct qstr *name,
 			     u64 index)
 {
 	struct btrfs_dir_item *di;
@@ -3459,7 +3433,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 	 * for dir item keys.
 	 */
 	di = btrfs_lookup_dir_index_item(trans, log, path, dir_ino,
-					 index, name, name_len, -1);
+					 index, name, -1);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	else if (!di)
@@ -3496,7 +3470,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
  */
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct qstr *name,
 				  struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_path *path;
@@ -3523,7 +3497,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	}
 
 	ret = del_logged_dentry(trans, root->log_root, path, btrfs_ino(dir),
-				name, name_len, index);
+				name, index);
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&dir->log_mutex);
@@ -3535,7 +3509,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 /* see comments for btrfs_del_dir_entries_in_log */
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root,
-				const char *name, int name_len,
+				const struct qstr *name,
 				struct btrfs_inode *inode, u64 dirid)
 {
 	struct btrfs_root *log;
@@ -3556,7 +3530,7 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
 
-	ret = btrfs_del_inode_ref(trans, log, name, name_len, btrfs_ino(inode),
+	ret = btrfs_del_inode_ref(trans, log, name, btrfs_ino(inode),
 				  dirid, &index);
 	mutex_unlock(&inode->log_mutex);
 	if (ret < 0 && ret != -ENOENT)
@@ -5219,6 +5193,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		u32 this_len;
 		unsigned long name_ptr;
 		struct btrfs_dir_item *di;
+		struct qstr name_str;
 
 		if (key->type == BTRFS_INODE_REF_KEY) {
 			struct btrfs_inode_ref *iref;
@@ -5252,8 +5227,11 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		}
 
 		read_extent_buffer(eb, name, name_ptr, this_name_len);
+
+		name_str.name = name;
+		name_str.len = this_name_len;
 		di = btrfs_lookup_dir_item(NULL, inode->root, search_path,
-				parent, name, this_name_len, 0);
+				parent, &name_str, 0);
 		if (di && !IS_ERR(di)) {
 			struct btrfs_key di_key;
 
@@ -7454,8 +7432,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		 */
 		mutex_lock(&old_dir->log_mutex);
 		ret = del_logged_dentry(trans, log, path, btrfs_ino(old_dir),
-					old_dentry->d_name.name,
-					old_dentry->d_name.len, old_dir_index);
+					&old_dentry->d_name, old_dir_index);
 		if (ret > 0) {
 			/*
 			 * The dentry does not exist in the log, so record its
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index f5770829d075..8c9a387151b0 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -87,11 +87,11 @@ int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
 			  struct btrfs_log_ctx *ctx);
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct qstr *name,
 				  struct btrfs_inode *dir, u64 index);
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root,
-				const char *name, int name_len,
+				const struct qstr *name,
 				struct btrfs_inode *inode, u64 dirid);
 void btrfs_end_log_trans(struct btrfs_root *root);
 void btrfs_pin_log_trans(struct btrfs_root *root);
-- 
2.35.1

