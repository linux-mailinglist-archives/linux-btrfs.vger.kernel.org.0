Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EB606670
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTQ7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJTQ7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:14 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CFA1B90D5;
        Thu, 20 Oct 2022 09:59:11 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 5C11A80040;
        Thu, 20 Oct 2022 12:59:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1666285151; bh=S8iPbLVzu3sGfMorvLmsWxObjUU7uNjb50ncPquLkeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJUFswhlQnZKL21/ORAmsh+l0zfdvDId3+/PHx4r+2nx+udjzYiCwKgtCs6sVUgQT
         8LLTkc2uwDOJKVxPYHNgQyFOu2YJJwpTToDYnOmpd4A7zZE0LcxYFgbP2HyAt7Og32
         hWp8s3+wdWM33U/WfUEPBT12t9b+HEyZ3xCsysA94TgccwQMDzGr+PtE8PZ0Z0PDnP
         mXs2CHj6zupRDg1+I6xEJw+2VdcnlPDpMeGZX0OZG/2phyDegABln2Unjwkc140mua
         uMJ5ee1RWbaHQp/5IoQZzQhlCh4eApYE329JlGI0lC09Zk6zBaLmdc/L0voczskyXV
         xNbz2E0WUjsAA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 06/22] btrfs: use struct qstr instead of name and namelen
Date:   Thu, 20 Oct 2022 12:58:25 -0400
Message-Id: <df429e0843dc2caee3132c1eebc6ff47bb198de5.1666281277.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1666281276.git.sweettea-kernel@dorminy.me>
References: <cover.1666281276.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index a8b629a166be..2cb6c1adbfc3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2896,11 +2896,11 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
 
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
@@ -2929,25 +2929,23 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
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
@@ -3028,10 +3026,10 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
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
index 72fb2c518a2b..8c60f37eb13f 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -103,8 +103,8 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
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
@@ -120,7 +120,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	key.objectid = btrfs_ino(dir);
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(name->name, name->len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -128,9 +128,9 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	btrfs_cpu_key_to_disk(&disk_key, location);
 
-	data_size = sizeof(*dir_item) + name_len;
+	data_size = sizeof(*dir_item) + name->len;
 	dir_item = insert_with_overflow(trans, root, path, &key, data_size,
-					name, name_len);
+					name->name, name->len);
 	if (IS_ERR(dir_item)) {
 		ret = PTR_ERR(dir_item);
 		if (ret == -EEXIST)
@@ -142,11 +142,11 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
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
@@ -157,7 +157,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	}
 	btrfs_release_path(path);
 
-	ret2 = btrfs_insert_delayed_dir_index(trans, name, name_len, dir,
+	ret2 = btrfs_insert_delayed_dir_index(trans, name->name, name->len, dir,
 					      &disk_key, type, index);
 out_free:
 	btrfs_free_path(path);
@@ -206,7 +206,7 @@ static struct btrfs_dir_item *btrfs_lookup_match_dir(
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
-					     const char *name, int name_len,
+					     const struct qstr *name,
 					     int mod)
 {
 	struct btrfs_key key;
@@ -214,9 +214,10 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(name->name, name->len);
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name->name,
+				    name->len, mod);
 	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
@@ -224,7 +225,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
-				   const char *name, int name_len)
+				   const struct qstr *name)
 {
 	int ret;
 	struct btrfs_key key;
@@ -240,9 +241,10 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 
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
@@ -262,11 +264,8 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
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
@@ -303,8 +302,7 @@ struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 index, const char *name, int name_len,
-			    int mod)
+			    u64 index, const struct qstr *name, int mod)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -313,7 +311,8 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = index;
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name->name,
+				    name->len, mod);
 	if (di == ERR_PTR(-ENOENT))
 		return NULL;
 
@@ -321,9 +320,8 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
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
@@ -338,7 +336,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 			break;
 
 		di = btrfs_match_dir_item_name(root->fs_info, path,
-					       name, name_len);
+					       name->name, name->len);
 		if (di)
 			return di;
 	}
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 366f3a788c6a..643b0c555064 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -11,8 +11,8 @@
 #include "space-info.h"
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
-						   int slot, const char *name,
-						   int name_len)
+						   int slot,
+						   const struct qstr *name)
 {
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
@@ -28,9 +28,10 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
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
@@ -38,7 +39,7 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
-		const char *name, int name_len)
+		const struct qstr *name)
 {
 	struct btrfs_inode_extref *extref;
 	unsigned long ptr;
@@ -61,9 +62,10 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
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
@@ -76,7 +78,7 @@ struct btrfs_inode_extref *
 btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_path *path,
-			  const char *name, int name_len,
+			  const struct qstr *name,
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow)
 {
@@ -85,7 +87,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
@@ -93,13 +95,13 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
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
@@ -108,14 +110,14 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
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
@@ -133,7 +135,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	 * readonly.
 	 */
 	extref = btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-						ref_objectid, name, name_len);
+						ref_objectid, name);
 	if (!extref) {
 		btrfs_handle_fs_error(root->fs_info, -ENOENT, NULL);
 		ret = -EROFS;
@@ -169,8 +171,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root,
-			const char *name, int name_len,
+			struct btrfs_root *root, const struct qstr *name,
 			u64 inode_objectid, u64 ref_objectid, u64 *index)
 {
 	struct btrfs_path *path;
@@ -183,7 +184,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	u32 sub_item_len;
 	int ret;
 	int search_ext_refs = 0;
-	int del_len = name_len + sizeof(*ref);
+	int del_len = name->len + sizeof(*ref);
 
 	key.objectid = inode_objectid;
 	key.offset = ref_objectid;
@@ -202,8 +203,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0], name,
-					 name_len);
+	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0], name);
 	if (!ref) {
 		ret = -ENOENT;
 		search_ext_refs = 1;
@@ -220,7 +220,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	ptr = (unsigned long)ref;
-	sub_item_len = name_len + sizeof(*ref);
+	sub_item_len = name->len + sizeof(*ref);
 	item_start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			      item_size - (ptr + sub_item_len - item_start));
@@ -234,7 +234,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		 * name in our ref array. Find and remove the extended
 		 * inode ref then.
 		 */
-		return btrfs_del_inode_extref(trans, root, name, name_len,
+		return btrfs_del_inode_extref(trans, root, name,
 					      inode_objectid, ref_objectid, index);
 	}
 
@@ -248,12 +248,13 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -261,7 +262,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -273,7 +274,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 		if (btrfs_find_name_in_ext_backref(path->nodes[0],
 						   path->slots[0],
 						   ref_objectid,
-						   name, name_len))
+						   name))
 			goto out;
 
 		btrfs_extend_item(path, ins_len);
@@ -287,12 +288,12 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
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
@@ -302,8 +303,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 /* Will return 0, -ENOMEM, -EMLINK, or -EEXIST or anything from the CoW path */
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   const char *name, int name_len,
+			   struct btrfs_root *root, const struct qstr *name,
 			   u64 inode_objectid, u64 ref_objectid, u64 index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -312,7 +312,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
 	int ret;
-	int ins_len = name_len + sizeof(*ref);
+	int ins_len = name->len + sizeof(*ref);
 
 	key.objectid = inode_objectid;
 	key.offset = ref_objectid;
@@ -328,7 +328,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	if (ret == -EEXIST) {
 		u32 old_size;
 		ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-						 name, name_len);
+						 name);
 		if (ref)
 			goto out;
 
@@ -337,7 +337,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
 		ref = (struct btrfs_inode_ref *)((unsigned long)ref + old_size);
-		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name->len);
 		btrfs_set_inode_ref_index(path->nodes[0], ref, index);
 		ptr = (unsigned long)(ref + 1);
 		ret = 0;
@@ -345,7 +345,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret == -EOVERFLOW) {
 			if (btrfs_find_name_in_backref(path->nodes[0],
 						       path->slots[0],
-						       name, name_len))
+						       name))
 				ret = -EEXIST;
 			else
 				ret = -EMLINK;
@@ -354,11 +354,11 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -371,7 +371,6 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
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
index 28328bc2e7d6..bcba5d434ad4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3639,7 +3639,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->delayed_iput_lock);
 }
 
-/**
+/*
  * Wait for flushing all delayed iputs
  *
  * @fs_info:  the filesystem
@@ -4284,7 +4284,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir,
 				struct btrfs_inode *inode,
-				const char *name, int name_len,
+				const struct qstr *name,
 				struct btrfs_rename_ctx *rename_ctx)
 {
 	struct btrfs_root *root = dir->root;
@@ -4302,8 +4302,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				    name, name_len, -1);
+	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, name, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto err;
@@ -4331,12 +4330,11 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
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
@@ -4357,10 +4355,8 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
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
@@ -4378,7 +4374,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name_len * 2);
+	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
@@ -4391,10 +4387,10 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
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
@@ -4438,9 +4434,8 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 			0);
 
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
-			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
-			dentry->d_name.len);
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
+				 &dentry->d_name);
 	if (ret)
 		goto out;
 
@@ -4465,8 +4460,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	const char *name = dentry->d_name.name;
-	int name_len = dentry->d_name.len;
+	const struct qstr *name = &dentry->d_name;
 	u64 index;
 	int ret;
 	u64 objectid;
@@ -4486,7 +4480,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				   name, name_len, -1);
+				   name, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -4512,8 +4506,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
 	 */
 	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
-		di = btrfs_search_dir_index_item(root, path, dir_ino,
-						 name, name_len);
+		di = btrfs_search_dir_index_item(root, path, dir_ino, name);
 		if (IS_ERR_OR_NULL(di)) {
 			if (!di)
 				ret = -ENOENT;
@@ -4530,7 +4523,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	} else {
 		ret = btrfs_del_root_ref(trans, objectid,
 					 root->root_key.objectid, dir_ino,
-					 &index, name, name_len);
+					 &index, name);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4543,7 +4536,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name_len * 2);
+	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name->len * 2);
 	inode_inc_iversion(dir);
 	dir->i_mtime = current_time(dir);
 	dir->i_ctime = dir->i_mtime;
@@ -4565,6 +4558,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	struct btrfs_path *path;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
+	struct qstr name = QSTR_INIT("default", 7);
 	u64 dir_id;
 	int ret;
 
@@ -4575,7 +4569,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	/* Make sure this root isn't set as the default subvol */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, fs_info->tree_root, path,
-				   dir_id, "default", 7, 0);
+				   dir_id, &name, 0);
 	if (di && !IS_ERR(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
 		if (key.objectid == root->root_key.objectid) {
@@ -4842,9 +4836,8 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -5536,8 +5529,7 @@ void btrfs_evict_inode(struct inode *inode)
 static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 			       struct btrfs_key *location, u8 *type)
 {
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
+	const struct qstr *name = &dentry->d_name;
 	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -5548,7 +5540,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(NULL, root, path, btrfs_ino(BTRFS_I(dir)),
-			name, namelen, 0);
+				   name, 0);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -5560,7 +5552,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 		ret = -EUCLEAN;
 		btrfs_warn(root->fs_info,
 "%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
-			   __func__, name, btrfs_ino(BTRFS_I(dir)),
+			   __func__, name->name, btrfs_ino(BTRFS_I(dir)),
 			   location->objectid, location->type, location->offset);
 	}
 	if (!ret)
@@ -6319,8 +6311,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 {
 	struct inode *dir = args->dir;
 	struct inode *inode = args->inode;
-	const char *name = args->orphan ? NULL : args->dentry->d_name.name;
-	int name_len = args->orphan ? 0 : args->dentry->d_name.len;
+	const struct qstr *name = args->orphan ? NULL : &args->dentry->d_name;
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
@@ -6421,7 +6412,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			sizes[1] = 2 + sizeof(*ref);
 		} else {
 			key[1].offset = btrfs_ino(BTRFS_I(dir));
-			sizes[1] = name_len + sizeof(*ref);
+			sizes[1] = name->len + sizeof(*ref);
 		}
 	}
 
@@ -6460,10 +6451,12 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
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
 
@@ -6524,7 +6517,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 	} else {
 		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-				     name_len, 0, BTRFS_I(inode)->dir_index);
+				     0, BTRFS_I(inode)->dir_index);
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -6553,7 +6546,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
  */
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
-		   const char *name, int name_len, int add_backref, u64 index)
+		   const struct qstr *name, int add_backref, u64 index)
 {
 	int ret = 0;
 	struct btrfs_key key;
@@ -6572,17 +6565,17 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
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
@@ -6592,7 +6585,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_i_size_write(parent_inode, parent_inode->vfs_inode.i_size +
-			   name_len * 2);
+			   name->len * 2);
 	inode_inc_iversion(&parent_inode->vfs_inode);
 	/*
 	 * If we are replaying a log tree, we do not want to update the mtime
@@ -6617,15 +6610,15 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
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
@@ -6745,7 +6738,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     dentry->d_name.name, dentry->d_name.len, 1, index);
+			     &dentry->d_name, 1, index);
 
 	if (err) {
 		drop_inode = 1;
@@ -9078,9 +9071,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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
@@ -9094,9 +9085,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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
@@ -9132,8 +9121,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
-					   old_dentry->d_name.name,
-					   old_dentry->d_name.len,
+					   &old_dentry->d_name,
 					   &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
@@ -9149,8 +9137,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
-					   new_dentry->d_name.name,
-					   new_dentry->d_name.len,
+					   &new_dentry->d_name,
 					   &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
@@ -9161,16 +9148,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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
@@ -9271,8 +9256,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 
 	/* check for collisions, even if the  name isn't there */
 	ret = btrfs_check_dir_item_collision(dest, new_dir->i_ino,
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len);
+					     &new_dentry->d_name);
 
 	if (ret) {
 		if (ret == -EEXIST) {
@@ -9366,9 +9350,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
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
@@ -9392,10 +9374,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
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
@@ -9414,8 +9394,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		} else {
 			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 						 BTRFS_I(d_inode(new_dentry)),
-						 new_dentry->d_name.name,
-						 new_dentry->d_name.len);
+						 &new_dentry->d_name);
 		}
 		if (!ret && new_inode->i_nlink == 0)
 			ret = btrfs_orphan_add(trans,
@@ -9427,8 +9406,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len, 0, index);
+			     &new_dentry->d_name, 0, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d5dd8bed1488..8a381182ec42 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -949,6 +949,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	struct inode *dir = d_inode(parent->dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct dentry *dentry;
+	struct qstr name_str = QSTR_INIT(name, namelen);
 	int error;
 
 	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
@@ -969,8 +970,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	 * check for them now when we can safely fail
 	 */
 	error = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
-					       dir->i_ino, name,
-					       namelen);
+					       dir->i_ino, &name_str);
 	if (error)
 		goto out_dput;
 
@@ -3774,6 +3774,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path = NULL;
 	struct btrfs_disk_key disk_key;
+	struct qstr name = QSTR_INIT("default", 7);
 	u64 objectid = 0;
 	u64 dir_id;
 	int ret;
@@ -3817,7 +3818,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(trans, fs_info->tree_root, path,
-				   dir_id, "default", 7, 1);
+				   dir_id, &name, 1);
 	if (IS_ERR_OR_NULL(di)) {
 		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e1f599d7a916..cf29241b9b31 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -327,9 +327,8 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
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
@@ -356,8 +355,8 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
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
@@ -400,8 +399,8 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
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
@@ -420,7 +419,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	key.offset = ref_id;
 again:
 	ret = btrfs_insert_empty_item(trans, tree_root, path, &key,
-				      sizeof(*ref) + name_len);
+				      sizeof(*ref) + name->len);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_free_path(path);
@@ -431,9 +430,9 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
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
index ec6e1752af2c..b7566023954a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1596,13 +1596,16 @@ static int gen_unique_name(struct send_ctx *sctx,
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
@@ -1622,7 +1625,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 
 		di = btrfs_lookup_dir_item(NULL, sctx->parent_root,
 				path, BTRFS_FIRST_FREE_OBJECTID,
-				tmp, strlen(tmp), 0);
+				&tmp_name, 0);
 		btrfs_release_path(path);
 		if (IS_ERR(di)) {
 			ret = PTR_ERR(di);
@@ -1752,13 +1755,13 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
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
index 688f7704d3fd..571224170d99 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1394,6 +1394,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	struct btrfs_key location;
+	struct qstr name = QSTR_INIT("default", 7);
 	u64 dir_id;
 
 	path = btrfs_alloc_path();
@@ -1406,7 +1407,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	 * to mount.
 	 */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
-	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, "default", 7, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
 	if (IS_ERR(di)) {
 		btrfs_free_path(path);
 		return PTR_ERR(di);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ae7d4aca771d..65a79ca4ac81 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1676,8 +1676,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	/* check if there is a file/dir which has the same name. */
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
 					 btrfs_ino(BTRFS_I(parent_inode)),
-					 dentry->d_name.name,
-					 dentry->d_name.len, 0);
+					 &dentry->d_name, 0);
 	if (dir_item != NULL && !IS_ERR(dir_item)) {
 		pending->error = -EEXIST;
 		goto dir_item_existed;
@@ -1772,7 +1771,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	ret = btrfs_add_root_ref(trans, objectid,
 				 parent_root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(parent_inode)), index,
-				 dentry->d_name.name, dentry->d_name.len);
+				 &dentry->d_name);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
@@ -1804,9 +1803,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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
index 813986e38258..139429d0f905 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -595,6 +595,20 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
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
@@ -901,12 +915,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
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
@@ -933,8 +946,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = dir->root;
 	struct inode *inode;
-	char *name;
-	int name_len;
+	struct qstr name;
 	struct extent_buffer *leaf;
 	struct btrfs_key location;
 	int ret;
@@ -942,12 +954,10 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
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
@@ -960,10 +970,9 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
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
@@ -978,14 +987,14 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
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
@@ -998,7 +1007,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 	}
 
 	btrfs_release_path(path);
-	di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, name_len, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		goto out;
@@ -1025,7 +1034,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 static noinline int backref_in_log(struct btrfs_root *log,
 				   struct btrfs_key *key,
 				   u64 ref_objectid,
-				   const char *name, int namelen)
+				   const struct qstr *name)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -1045,12 +1054,10 @@ static noinline int backref_in_log(struct btrfs_root *log,
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
@@ -1063,11 +1070,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1099,43 +1104,39 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1152,29 +1153,27 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1186,26 +1185,24 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
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
@@ -1216,8 +1213,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* look for a conflicting name */
-	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir),
-				   name, namelen, 0);
+	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir), name, 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
@@ -1231,20 +1227,18 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1255,18 +1249,17 @@ static int extref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
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
@@ -1308,28 +1301,26 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
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
@@ -1338,20 +1329,20 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
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
@@ -1380,8 +1371,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	struct inode *inode = NULL;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
-	char *name = NULL;
-	int namelen;
+	struct qstr name;
 	int ret;
 	int log_ref_ver = 0;
 	u64 parent_objectid;
@@ -1425,7 +1415,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 	while (ref_ptr < ref_end) {
 		if (log_ref_ver) {
-			ret = extref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
 			/*
 			 * parent object can change from one array
@@ -1438,15 +1428,14 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1460,7 +1449,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			ret = __add_inode_ref(trans, root, path, log,
 					      BTRFS_I(dir), BTRFS_I(inode),
 					      inode_objectid, parent_objectid,
-					      ref_index, name, namelen);
+					      ref_index, &name);
 			if (ret) {
 				if (ret == 1)
 					ret = 0;
@@ -1469,7 +1458,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 			/* insert our name */
 			ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-					     name, namelen, 0, ref_index);
+					     &name, 0, ref_index);
 			if (ret)
 				goto out;
 
@@ -1479,9 +1468,9 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1505,7 +1494,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	ret = overwrite_item(trans, root, path, eb, slot, key);
 out:
 	btrfs_release_path(path);
-	kfree(name);
+	kfree(name.name);
 	iput(dir);
 	iput(inode);
 	return ret;
@@ -1777,7 +1766,7 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 				    struct btrfs_root *root,
 				    u64 dirid, u64 index,
-				    char *name, int name_len,
+				    const struct qstr *name,
 				    struct btrfs_key *location)
 {
 	struct inode *inode;
@@ -1795,7 +1784,7 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-			name_len, 1, index);
+			     1, index);
 
 	/* FIXME, put inode into FIXUP list */
 
@@ -1855,8 +1844,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 				    struct btrfs_dir_item *di,
 				    struct btrfs_key *key)
 {
-	char *name;
-	int name_len;
+	struct qstr name;
 	struct btrfs_dir_item *dir_dst_di;
 	struct btrfs_dir_item *index_dst_di;
 	bool dir_dst_matches = false;
@@ -1874,17 +1862,11 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
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
@@ -1894,7 +1876,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	ret = 0;
 
 	dir_dst_di = btrfs_lookup_dir_item(trans, root, path, key->objectid,
-					   name, name_len, 1);
+					   &name, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
 		goto out;
@@ -1911,7 +1893,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 	index_dst_di = btrfs_lookup_dir_index_item(trans, root, path,
 						   key->objectid, key->offset,
-						   name, name_len, 1);
+						   &name, 1);
 	if (IS_ERR(index_dst_di)) {
 		ret = PTR_ERR(index_dst_di);
 		goto out;
@@ -1939,7 +1921,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = key->objectid;
-	ret = backref_in_log(root->log_root, &search_key, 0, name, name_len);
+	ret = backref_in_log(root->log_root, &search_key, 0, &name);
 	if (ret < 0) {
 	        goto out;
 	} else if (ret) {
@@ -1952,8 +1934,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
 	search_key.offset = key->objectid;
-	ret = backref_in_log(root->log_root, &search_key, key->objectid, name,
-			     name_len);
+	ret = backref_in_log(root->log_root, &search_key, key->objectid, &name);
 	if (ret < 0) {
 		goto out;
 	} else if (ret) {
@@ -1964,7 +1945,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 	ret = insert_one_name(trans, root, key->objectid, key->offset,
-			      name, name_len, &log_key);
+			      &name, &log_key);
 	if (ret && ret != -ENOENT && ret != -EEXIST)
 		goto out;
 	if (!ret)
@@ -1974,10 +1955,10 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
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
@@ -2143,8 +2124,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_dir_item *di;
-	int name_len;
-	char *name;
+	struct qstr name;
 	struct inode *inode = NULL;
 	struct btrfs_key location;
 
@@ -2159,22 +2139,16 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
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
@@ -2200,7 +2174,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 
 	inc_nlink(inode);
 	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(inode),
-					  name, name_len);
+					  &name);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
@@ -2209,7 +2183,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 	btrfs_release_path(log_path);
-	kfree(name);
+	kfree(name.name);
 	iput(inode);
 	return ret;
 }
@@ -3448,7 +3422,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *log,
 			     struct btrfs_path *path,
 			     u64 dir_ino,
-			     const char *name, int name_len,
+			     const struct qstr *name,
 			     u64 index)
 {
 	struct btrfs_dir_item *di;
@@ -3458,7 +3432,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 	 * for dir item keys.
 	 */
 	di = btrfs_lookup_dir_index_item(trans, log, path, dir_ino,
-					 index, name, name_len, -1);
+					 index, name, -1);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	else if (!di)
@@ -3495,7 +3469,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
  */
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct qstr *name,
 				  struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_path *path;
@@ -3522,7 +3496,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	}
 
 	ret = del_logged_dentry(trans, root->log_root, path, btrfs_ino(dir),
-				name, name_len, index);
+				name, index);
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&dir->log_mutex);
@@ -3534,7 +3508,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 /* see comments for btrfs_del_dir_entries_in_log */
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root,
-				const char *name, int name_len,
+				const struct qstr *name,
 				struct btrfs_inode *inode, u64 dirid)
 {
 	struct btrfs_root *log;
@@ -3555,7 +3529,7 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
 
-	ret = btrfs_del_inode_ref(trans, log, name, name_len, btrfs_ino(inode),
+	ret = btrfs_del_inode_ref(trans, log, name, btrfs_ino(inode),
 				  dirid, &index);
 	mutex_unlock(&inode->log_mutex);
 	if (ret < 0 && ret != -ENOENT)
@@ -5218,6 +5192,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		u32 this_len;
 		unsigned long name_ptr;
 		struct btrfs_dir_item *di;
+		struct qstr name_str;
 
 		if (key->type == BTRFS_INODE_REF_KEY) {
 			struct btrfs_inode_ref *iref;
@@ -5251,8 +5226,11 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
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
 
@@ -7453,8 +7431,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
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
index aed1e05e9879..59dc4359c8c4 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -86,11 +86,11 @@ int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
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

