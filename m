Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816005ADC81
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiIFAgC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiIFAgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:36:00 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194376A487;
        Mon,  5 Sep 2022 17:35:55 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 329E681106;
        Mon,  5 Sep 2022 20:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662424554; bh=LTExQlSQr7/m/oGbh9qeXgB5mFwgu32iYwIHtXnMg1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYl5ELiRlb1OmK6DFdua3G2MRf47EHV3qV3ajIo1ZaIBXu+oLtckNs93QshptUiNN
         WIJkheV05n+roqr+imyDa3iIREMD6k+ByGQD+4LV8AJZjaUwK1oTXkNtvyNEKY3qGd
         HVG8uDaD13SAplCiqZKW9Mc6sbvwUldIXbW6LtbBtGNvLKK/mBJuapk3gUVzbVwuoE
         tOW6l3wSgD3ACuT+JZuwfUiU5CDFZaCqdtYEFZQuD3c+1n1yc1CEh+4BD5GU0QSkTT
         ldCKJN1mG7I7Qc8oWjmx+7aFOFh79jLSTK/8PiCQLlwJUiuFG82TawbyhtAatsteaz
         H5XqPzLA90A9A==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 08/20] btrfs: use fscrypt_names instead of name/len everywhere.
Date:   Mon,  5 Sep 2022 20:35:23 -0400
Message-Id: <2b32b14368c67eb8591ccc4b0cf9d19358dfae23.1662420176.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1662420176.git.sweettea-kernel@dorminy.me>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For encryption, the plaintext filenames provided by the VFS will need to
be translated to ciphertext filenames on disk. Fscrypt provides a struct
to encapsulate a potentially encrypted filename, struct fscrypt_name.
This change converts every (name, len) pair to be a struct fscrypt_name,
statically initialized, for ease of review and uniformity.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h         |  49 +++++-----
 fs/btrfs/delayed-inode.c |  12 ++-
 fs/btrfs/delayed-inode.h |   3 +-
 fs/btrfs/dir-item.c      |  87 ++++++++---------
 fs/btrfs/inode-item.c    |  82 ++++++++--------
 fs/btrfs/inode-item.h    |  14 +--
 fs/btrfs/inode.c         | 197 +++++++++++++++++++++-----------------
 fs/btrfs/ioctl.c         |  29 +++---
 fs/btrfs/props.c         |  11 ++-
 fs/btrfs/root-tree.c     |  19 ++--
 fs/btrfs/send.c          | 139 ++++++++++++++++-----------
 fs/btrfs/super.c         |   5 +-
 fs/btrfs/transaction.c   |  25 ++---
 fs/btrfs/tree-checker.c  |   6 +-
 fs/btrfs/tree-log.c      | 202 ++++++++++++++++++++++-----------------
 fs/btrfs/tree-log.h      |   4 +-
 fs/btrfs/xattr.c         |  21 ++--
 17 files changed, 518 insertions(+), 387 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1793b0e16a14..230537a007b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -21,11 +21,13 @@
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>
 #include <linux/btrfs_tree.h>
+#include <linux/fscrypt.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/sizes.h>
 #include <linux/dynamic_debug.h>
 #include <linux/refcount.h>
+#include <linux/crc32.h>
 #include <linux/crc32c.h>
 #include <linux/iomap.h>
 #include "extent-io-tree.h"
@@ -2803,18 +2805,19 @@ static inline void btrfs_crc32c_final(u32 crc, u8 *result)
 	put_unaligned_le32(~crc, result);
 }
 
-static inline u64 btrfs_name_hash(const char *name, int len)
+static inline u64 btrfs_name_hash(const struct fscrypt_name *name)
 {
-       return crc32c((u32)~1, name, len);
+	return crc32c((u32)~1, fname_name(name), fname_len(name));
 }
 
 /*
  * Figure the key offset of an extended inode ref
  */
-static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
-                                   int len)
+static inline u64 btrfs_extref_hash(u64 parent_objectid,
+				    const struct fscrypt_name *name)
 {
-       return (u64) crc32c(parent_objectid, name, len);
+	return (u64) crc32c(parent_objectid, fname_name(name),
+			    fname_len(name));
 }
 
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
@@ -3250,11 +3253,11 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
 
 /* root-item.c */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
-		       int name_len);
+		       u64 ref_id, u64 dirid, u64 sequence,
+		       const struct fscrypt_name *fname);
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 *sequence, const char *name,
-		       int name_len);
+		       u64 ref_id, u64 dirid, u64 *sequence,
+		       const struct fscrypt_name *fname);
 int btrfs_del_root(struct btrfs_trans_handle *trans,
 		   const struct btrfs_key *key);
 int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
@@ -3283,25 +3286,26 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
 /* dir-item.c */
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
-			  const char *name, int name_len);
-int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
-			  int name_len, struct btrfs_inode *dir,
-			  struct btrfs_key *location, u8 type, u64 index);
+			  const struct fscrypt_name *fname);
+int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
+			  const struct fscrypt_name *fname,
+			  struct btrfs_inode *dir, struct btrfs_key *location,
+			  u8 type, u64 index);
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
-					     const char *name, int name_len,
+					     const struct fscrypt_name *fname,
 					     int mod);
 struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 index, const char *name, int name_len,
+			    u64 index, const struct fscrypt_name *fname,
 			    int mod);
 struct btrfs_dir_item *
 btrfs_search_dir_index_item(struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dirid,
-			    const char *name, int name_len);
+			    const struct fscrypt_name *fname);
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
@@ -3309,17 +3313,16 @@ int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 objectid,
-			    const char *name, u16 name_len,
+			    const struct fscrypt_name *fname,
 			    const void *data, u16 data_len);
 struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 					  struct btrfs_root *root,
 					  struct btrfs_path *path, u64 dir,
-					  const char *name, u16 name_len,
+					  const struct fscrypt_name *fname,
 					  int mod);
 struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
-						 const char *name,
-						 int name_len);
+						 const struct fscrypt_name *name);
 
 /* orphan.c */
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
@@ -3383,10 +3386,11 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const char *name, int name_len);
+		       const struct fscrypt_name *fname);
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
-		   const char *name, int name_len, int add_backref, u64 index);
+		   const struct fscrypt_name *fname, int add_backref,
+		   u64 index);
 int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
 int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			 int front);
@@ -3402,6 +3406,7 @@ struct btrfs_new_inode_args {
 	struct inode *dir;
 	struct dentry *dentry;
 	struct inode *inode;
+	struct fscrypt_name fname;
 	bool orphan;
 	bool subvol;
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 7e405aafab86..069326654074 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1410,7 +1410,7 @@ void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info)
 
 /* Will return 0 or -ENOMEM */
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
-				   const char *name, int name_len,
+				   const struct fscrypt_name *fname,
 				   struct btrfs_inode *dir,
 				   struct btrfs_disk_key *disk_key, u8 flags,
 				   u64 index)
@@ -1428,7 +1428,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
-	delayed_item = btrfs_alloc_delayed_item(sizeof(*dir_item) + name_len,
+	delayed_item = btrfs_alloc_delayed_item(sizeof(*dir_item) +
+						fname_len(fname),
 						delayed_node,
 						BTRFS_DELAYED_INSERTION_ITEM);
 	if (!delayed_item) {
@@ -1442,9 +1443,9 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	dir_item->location = *disk_key;
 	btrfs_set_stack_dir_transid(dir_item, trans->transid);
 	btrfs_set_stack_dir_data_len(dir_item, 0);
-	btrfs_set_stack_dir_name_len(dir_item, name_len);
+	btrfs_set_stack_dir_name_len(dir_item, fname_len(fname));
 	btrfs_set_stack_dir_flags(dir_item, flags);
-	memcpy((char *)(dir_item + 1), name, name_len);
+	memcpy((char *)(dir_item + 1), fname_name(fname), fname_len(fname));
 
 	data_len = delayed_item->data_len + sizeof(struct btrfs_item);
 
@@ -1494,7 +1495,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
 			  "err add delayed dir index item(name: %.*s) into the insertion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  name_len, name, delayed_node->root->root_key.objectid,
+			  fname_len(fname), fname_name(fname),
+			  delayed_node->root->root_key.objectid,
 			  delayed_node->inode_id, ret);
 		BUG();
 	}
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 4f21daa3dbc7..8abeb78af14e 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/fscrypt.h>
 #include <linux/refcount.h>
 #include "ctree.h"
 
@@ -111,7 +112,7 @@ static inline void btrfs_init_delayed_root(
 }
 
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
-				   const char *name, int name_len,
+				   const struct fscrypt_name *fname,
 				   struct btrfs_inode *dir,
 				   struct btrfs_disk_key *disk_key, u8 flags,
 				   u64 index);
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index e37b075afa96..b4c1e2a40401 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -21,8 +21,7 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 						   struct btrfs_path *path,
 						   struct btrfs_key *cpu_key,
 						   u32 data_size,
-						   const char *name,
-						   int name_len)
+						   const struct fscrypt_name *fname)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
@@ -32,7 +31,7 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 	ret = btrfs_insert_empty_item(trans, root, path, cpu_key, data_size);
 	if (ret == -EEXIST) {
 		struct btrfs_dir_item *di;
-		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
+		di = btrfs_match_dir_item_name(fs_info, path, fname);
 		if (di)
 			return ERR_PTR(-EEXIST);
 		btrfs_extend_item(path, data_size);
@@ -53,7 +52,7 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 objectid,
-			    const char *name, u16 name_len,
+			    const struct fscrypt_name *fname,
 			    const void *data, u16 data_len)
 {
 	int ret = 0;
@@ -64,16 +63,16 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	u32 data_size;
 
-	if (name_len + data_len > BTRFS_MAX_XATTR_SIZE(root->fs_info))
+	if (fname_len(fname) + data_len > BTRFS_MAX_XATTR_SIZE(root->fs_info))
 		return -ENOSPC;
 
 	key.objectid = objectid;
 	key.type = BTRFS_XATTR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(fname);
 
-	data_size = sizeof(*dir_item) + name_len + data_len;
+	data_size = sizeof(*dir_item) + fname_len(fname) + data_len;
 	dir_item = insert_with_overflow(trans, root, path, &key, data_size,
-					name, name_len);
+					fname);
 	if (IS_ERR(dir_item))
 		return PTR_ERR(dir_item);
 	memset(&location, 0, sizeof(location));
@@ -82,13 +81,14 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 	btrfs_cpu_key_to_disk(&disk_key, &location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
 	btrfs_set_dir_flags(leaf, dir_item, BTRFS_FT_XATTR);
-	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_name_len(leaf, dir_item, fname_len(fname));
 	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
 	btrfs_set_dir_data_len(leaf, dir_item, data_len);
 	name_ptr = (unsigned long)(dir_item + 1);
-	data_ptr = (unsigned long)((char *)name_ptr + name_len);
+	data_ptr = (unsigned long)((char *)name_ptr + fname_len(fname));
 
-	write_extent_buffer(leaf, name, name_ptr, name_len);
+	write_extent_buffer(leaf, fname_name(fname), name_ptr,
+			    fname_len(fname));
 	write_extent_buffer(leaf, data, data_ptr, data_len);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 
@@ -103,9 +103,10 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
  * to use for the second index (if one is created).
  * Will return 0 or -ENOMEM
  */
-int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
-			  int name_len, struct btrfs_inode *dir,
-			  struct btrfs_key *location, u8 type, u64 index)
+int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
+			  const struct fscrypt_name *fname,
+			  struct btrfs_inode *dir, struct btrfs_key *location,
+			  u8 type, u64 index)
 {
 	int ret = 0;
 	int ret2 = 0;
@@ -120,7 +121,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	key.objectid = btrfs_ino(dir);
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(fname);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -128,9 +129,9 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	btrfs_cpu_key_to_disk(&disk_key, location);
 
-	data_size = sizeof(*dir_item) + name_len;
+	data_size = sizeof(*dir_item) + fname_len(fname);
 	dir_item = insert_with_overflow(trans, root, path, &key, data_size,
-					name, name_len);
+					fname);
 	if (IS_ERR(dir_item)) {
 		ret = PTR_ERR(dir_item);
 		if (ret == -EEXIST)
@@ -142,11 +143,12 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
 	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
-	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_name_len(leaf, dir_item, fname_len(fname));
 	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
 	name_ptr = (unsigned long)(dir_item + 1);
 
-	write_extent_buffer(leaf, name, name_ptr, name_len);
+	write_extent_buffer(leaf, fname_name(fname), name_ptr,
+			    fname_len(fname));
 	btrfs_mark_buffer_dirty(leaf);
 
 second_insert:
@@ -157,7 +159,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	}
 	btrfs_release_path(path);
 
-	ret2 = btrfs_insert_delayed_dir_index(trans, name, name_len, dir,
+	ret2 = btrfs_insert_delayed_dir_index(trans, fname, dir,
 					      &disk_key, type, index);
 out_free:
 	btrfs_free_path(path);
@@ -171,8 +173,8 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 static struct btrfs_dir_item *btrfs_lookup_match_dir(
 			struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, struct btrfs_path *path,
-			struct btrfs_key *key, const char *name,
-			int name_len, int mod)
+			struct btrfs_key *key, const struct fscrypt_name *fname,
+			int mod)
 {
 	const int ins_len = (mod < 0 ? -1 : 0);
 	const int cow = (mod != 0);
@@ -184,7 +186,7 @@ static struct btrfs_dir_item *btrfs_lookup_match_dir(
 	if (ret > 0)
 		return ERR_PTR(-ENOENT);
 
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return btrfs_match_dir_item_name(root->fs_info, path, fname);
 }
 
 /*
@@ -206,7 +208,7 @@ static struct btrfs_dir_item *btrfs_lookup_match_dir(
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
-					     const char *name, int name_len,
+					     const struct fscrypt_name *fname,
 					     int mod)
 {
 	struct btrfs_key key;
@@ -214,9 +216,9 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(fname);
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, fname, mod);
 	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
@@ -224,7 +226,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
-				   const char *name, int name_len)
+				   const struct fscrypt_name *fname)
 {
 	int ret;
 	struct btrfs_key key;
@@ -240,9 +242,9 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(fname);
 
-	di = btrfs_lookup_match_dir(NULL, root, path, &key, name, name_len, 0);
+	di = btrfs_lookup_match_dir(NULL, root, path, &key, fname, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		/* Nothing found, we're safe */
@@ -266,7 +268,7 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	 * see if there is room in the item to insert this
 	 * name
 	 */
-	data_size = sizeof(*di) + name_len;
+	data_size = sizeof(*di) + fname_len(fname);
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	if (data_size + btrfs_item_size(leaf, slot) +
@@ -303,7 +305,7 @@ struct btrfs_dir_item *
 btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dir,
-			    u64 index, const char *name, int name_len,
+			    u64 index, const struct fscrypt_name *fname,
 			    int mod)
 {
 	struct btrfs_dir_item *di;
@@ -313,7 +315,7 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = index;
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, fname, mod);
 	if (di == ERR_PTR(-ENOENT))
 		return NULL;
 
@@ -323,7 +325,7 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 struct btrfs_dir_item *
 btrfs_search_dir_index_item(struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dirid,
-			    const char *name, int name_len)
+			    const struct fscrypt_name *fname)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -337,8 +339,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
 
-		di = btrfs_match_dir_item_name(root->fs_info, path,
-					       name, name_len);
+		di = btrfs_match_dir_item_name(root->fs_info, path, fname);
 		if (di)
 			return di;
 	}
@@ -352,7 +353,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 					  struct btrfs_root *root,
 					  struct btrfs_path *path, u64 dir,
-					  const char *name, u16 name_len,
+					  const struct fscrypt_name *fname,
 					  int mod)
 {
 	struct btrfs_key key;
@@ -360,9 +361,9 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_XATTR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = btrfs_name_hash(fname);
 
-	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	di = btrfs_lookup_match_dir(trans, root, path, &key, fname, mod);
 	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
@@ -376,10 +377,9 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
  */
 struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
-						 const char *name, int name_len)
+						 const struct fscrypt_name *fname)
 {
 	struct btrfs_dir_item *dir_item;
-	unsigned long name_ptr;
 	u32 total_len;
 	u32 cur = 0;
 	u32 this_len;
@@ -390,13 +390,14 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 
 	total_len = btrfs_item_size(leaf, path->slots[0]);
 	while (cur < total_len) {
+		unsigned long name_ptr = (unsigned long)(dir_item + 1);
 		this_len = sizeof(*dir_item) +
 			btrfs_dir_name_len(leaf, dir_item) +
 			btrfs_dir_data_len(leaf, dir_item);
-		name_ptr = (unsigned long)(dir_item + 1);
 
-		if (btrfs_dir_name_len(leaf, dir_item) == name_len &&
-		    memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+		if (btrfs_dir_name_len(leaf, dir_item) == fname_len(fname) &&
+		    memcmp_extent_buffer(leaf, fname_name(fname), name_ptr,
+					 fname_len(fname)) == 0)
 			return dir_item;
 
 		cur += this_len;
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 0eeb5ea87894..78053eb9589c 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -3,15 +3,16 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include <linux/crc32.h>
 #include "ctree.h"
 #include "inode-item.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "print-tree.h"
 
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
-						   int slot, const char *name,
-						   int name_len)
+struct btrfs_inode_ref *
+btrfs_find_name_in_backref(struct extent_buffer *leaf, int slot,
+			   const struct fscrypt_name *fname)
 {
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
@@ -27,9 +28,10 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 		len = btrfs_inode_ref_name_len(leaf, ref);
 		name_ptr = (unsigned long)(ref + 1);
 		cur_offset += len + sizeof(*ref);
-		if (len != name_len)
+		if (len != fname_len(fname))
 			continue;
-		if (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+		if (memcmp_extent_buffer(leaf, fname_name(fname), name_ptr,
+					 fname_len(fname)) == 0)
 			return ref;
 	}
 	return NULL;
@@ -37,7 +39,7 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
-		const char *name, int name_len)
+		const struct fscrypt_name *fname)
 {
 	struct btrfs_inode_extref *extref;
 	unsigned long ptr;
@@ -60,9 +62,10 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		name_ptr = (unsigned long)(&extref->name);
 		ref_name_len = btrfs_inode_extref_name_len(leaf, extref);
 
-		if (ref_name_len == name_len &&
+		if (ref_name_len == fname_len(fname) &&
 		    btrfs_inode_extref_parent(leaf, extref) == ref_objectid &&
-		    (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0))
+		    (memcmp_extent_buffer(leaf, fname_name(fname), name_ptr,
+					  fname_len(fname)) == 0))
 			return extref;
 
 		cur_offset += ref_name_len + sizeof(*extref);
@@ -75,7 +78,7 @@ struct btrfs_inode_extref *
 btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_path *path,
-			  const char *name, int name_len,
+			  const struct fscrypt_name *fname,
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow)
 {
@@ -84,7 +87,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, fname);
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
@@ -92,13 +95,12 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 	if (ret > 0)
 		return NULL;
 	return btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-					      ref_objectid, name, name_len);
-
+					      ref_objectid, fname);
 }
 
 static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct fscrypt_name *fname,
 				  u64 inode_objectid, u64 ref_objectid,
 				  u64 *index)
 {
@@ -107,14 +109,14 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_extref *extref;
 	struct extent_buffer *leaf;
 	int ret;
-	int del_len = name_len + sizeof(*extref);
+	int del_len = fname_len(fname) + sizeof(*extref);
 	unsigned long ptr;
 	unsigned long item_start;
 	u32 item_size;
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, fname);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -132,7 +134,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	 * readonly.
 	 */
 	extref = btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-						ref_objectid, name, name_len);
+					        ref_objectid, fname);
 	if (!extref) {
 		btrfs_handle_fs_error(root->fs_info, -ENOENT, NULL);
 		ret = -EROFS;
@@ -169,7 +171,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 
 int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
-			const char *name, int name_len,
+			const struct fscrypt_name *fname,
 			u64 inode_objectid, u64 ref_objectid, u64 *index)
 {
 	struct btrfs_path *path;
@@ -182,7 +184,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	u32 sub_item_len;
 	int ret;
 	int search_ext_refs = 0;
-	int del_len = name_len + sizeof(*ref);
+	int del_len = fname_len(fname) + sizeof(*ref);
 
 	key.objectid = inode_objectid;
 	key.offset = ref_objectid;
@@ -201,8 +203,8 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0], name,
-					 name_len);
+	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
+					 fname);
 	if (!ref) {
 		ret = -ENOENT;
 		search_ext_refs = 1;
@@ -219,7 +221,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	ptr = (unsigned long)ref;
-	sub_item_len = name_len + sizeof(*ref);
+	sub_item_len = fname_len(fname) + sizeof(*ref);
 	item_start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			      item_size - (ptr + sub_item_len - item_start));
@@ -233,8 +235,9 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		 * name in our ref array. Find and remove the extended
 		 * inode ref then.
 		 */
-		return btrfs_del_inode_extref(trans, root, name, name_len,
-					      inode_objectid, ref_objectid, index);
+		return btrfs_del_inode_extref(trans, root, fname,
+					      inode_objectid, ref_objectid,
+					      index);
 	}
 
 	return ret;
@@ -247,12 +250,12 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
  */
 static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
-				     const char *name, int name_len,
+				     const struct fscrypt_name *fname,
 				     u64 inode_objectid, u64 ref_objectid, u64 index)
 {
 	struct btrfs_inode_extref *extref;
 	int ret;
-	int ins_len = name_len + sizeof(*extref);
+	int ins_len = fname_len(fname) + sizeof(*extref);
 	unsigned long ptr;
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -260,7 +263,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = btrfs_extref_hash(ref_objectid, fname);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -272,7 +275,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 		if (btrfs_find_name_in_ext_backref(path->nodes[0],
 						   path->slots[0],
 						   ref_objectid,
-						   name, name_len))
+						   fname))
 			goto out;
 
 		btrfs_extend_item(path, ins_len);
@@ -286,12 +289,13 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	ptr += btrfs_item_size(leaf, path->slots[0]) - ins_len;
 	extref = (struct btrfs_inode_extref *)ptr;
 
-	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
+	btrfs_set_inode_extref_name_len(path->nodes[0], extref, fname_len(fname));
 	btrfs_set_inode_extref_index(path->nodes[0], extref, index);
 	btrfs_set_inode_extref_parent(path->nodes[0], extref, ref_objectid);
 
 	ptr = (unsigned long)&extref->name;
-	write_extent_buffer(path->nodes[0], name, ptr, name_len);
+	write_extent_buffer(path->nodes[0], fname_name(fname), ptr,
+			    fname_len(fname));
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 
 out:
@@ -302,7 +306,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 /* Will return 0, -ENOMEM, -EMLINK, or -EEXIST or anything from the CoW path */
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
-			   const char *name, int name_len,
+			   const struct fscrypt_name *fname,
 			   u64 inode_objectid, u64 ref_objectid, u64 index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -311,7 +315,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
 	int ret;
-	int ins_len = name_len + sizeof(*ref);
+	int ins_len = fname_len(fname) + sizeof(*ref);
 
 	key.objectid = inode_objectid;
 	key.offset = ref_objectid;
@@ -327,7 +331,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	if (ret == -EEXIST) {
 		u32 old_size;
 		ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-						 name, name_len);
+						 fname);
 		if (ref)
 			goto out;
 
@@ -336,7 +340,8 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
 		ref = (struct btrfs_inode_ref *)((unsigned long)ref + old_size);
-		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+		btrfs_set_inode_ref_name_len(path->nodes[0], ref,
+					     fname_len(fname));
 		btrfs_set_inode_ref_index(path->nodes[0], ref, index);
 		ptr = (unsigned long)(ref + 1);
 		ret = 0;
@@ -344,7 +349,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret == -EOVERFLOW) {
 			if (btrfs_find_name_in_backref(path->nodes[0],
 						       path->slots[0],
-						       name, name_len))
+						       fname))
 				ret = -EEXIST;
 			else
 				ret = -EMLINK;
@@ -353,11 +358,13 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	} else {
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
-		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+		btrfs_set_inode_ref_name_len(path->nodes[0], ref,
+					     fname_len(fname));
 		btrfs_set_inode_ref_index(path->nodes[0], ref, index);
 		ptr = (unsigned long)(ref + 1);
 	}
-	write_extent_buffer(path->nodes[0], name, ptr, name_len);
+	write_extent_buffer(path->nodes[0], fname_name(fname), ptr,
+			    fname_len(fname));
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 
 out:
@@ -369,8 +376,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		 * add an extended ref. */
 		if (btrfs_super_incompat_flags(disk_super)
 		    & BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-			ret = btrfs_insert_inode_extref(trans, root, name,
-							name_len,
+			ret = btrfs_insert_inode_extref(trans, root, fname,
 							inode_objectid,
 							ref_objectid, index);
 	}
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index a8fc16d0147f..d55f9d6f17dd 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -65,11 +65,11 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_truncate_control *control);
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
-			   const char *name, int name_len,
+			   const struct fscrypt_name *fname,
 			   u64 inode_objectid, u64 ref_objectid, u64 index);
 int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
-			   const char *name, int name_len,
+			   const struct fscrypt_name *fname,
 			   u64 inode_objectid, u64 ref_objectid, u64 *index);
 int btrfs_insert_empty_inode(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
@@ -82,15 +82,15 @@ struct btrfs_inode_extref *btrfs_lookup_inode_extref(
 			  struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_path *path,
-			  const char *name, int name_len,
+			  const struct fscrypt_name *fname,
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow);
 
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
-						   int slot, const char *name,
-						   int name_len);
+struct btrfs_inode_ref *
+btrfs_find_name_in_backref(struct extent_buffer *leaf, int slot,
+			   const struct fscrypt_name *fname);
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
-		const char *name, int name_len);
+		const struct fscrypt_name *fname);
 
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 97e17b9bd34f..3e513ce5bb08 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3863,11 +3863,19 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 	static u64 xattr_default = 0;
 	int scanned = 0;
 
+	struct fscrypt_name name_access = {
+		.disk_name = FSTR_INIT(XATTR_NAME_POSIX_ACL_ACCESS,
+				       strlen(XATTR_NAME_POSIX_ACL_ACCESS))
+	};
+
+	struct fscrypt_name name_default = {
+		.disk_name = FSTR_INIT(XATTR_NAME_POSIX_ACL_DEFAULT,
+				       strlen(XATTR_NAME_POSIX_ACL_DEFAULT))
+	};
+
 	if (!xattr_access) {
-		xattr_access = btrfs_name_hash(XATTR_NAME_POSIX_ACL_ACCESS,
-					strlen(XATTR_NAME_POSIX_ACL_ACCESS));
-		xattr_default = btrfs_name_hash(XATTR_NAME_POSIX_ACL_DEFAULT,
-					strlen(XATTR_NAME_POSIX_ACL_DEFAULT));
+		xattr_access = btrfs_name_hash(&name_access);
+		xattr_default = btrfs_name_hash(&name_default);
 	}
 
 	slot++;
@@ -4254,7 +4262,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir,
 				struct btrfs_inode *inode,
-				const char *name, int name_len,
+				const struct fscrypt_name *fname,
 				struct btrfs_rename_ctx *rename_ctx)
 {
 	struct btrfs_root *root = dir->root;
@@ -4272,8 +4280,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				    name, name_len, -1);
+	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, fname, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto err;
@@ -4301,12 +4308,11 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_del_inode_ref(trans, root, name, name_len, ino,
-				  dir_ino, &index);
+	ret = btrfs_del_inode_ref(trans, root, fname, ino, dir_ino, &index);
 	if (ret) {
 		btrfs_info(fs_info,
 			"failed to delete reference to %.*s, inode %llu parent %llu",
-			name_len, name, ino, dir_ino);
+			fname_len(fname), fname_name(fname), ino, dir_ino);
 		btrfs_abort_transaction(trans, ret);
 		goto err;
 	}
@@ -4327,10 +4333,8 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	 * operations on the log tree, increasing latency for applications.
 	 */
 	if (!rename_ctx) {
-		btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
-					   dir_ino);
-		btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir,
-					     index);
+		btrfs_del_inode_ref_in_log(trans, root, fname, inode, dir_ino);
+		btrfs_del_dir_entries_in_log(trans, root, fname, dir, index);
 	}
 
 	/*
@@ -4348,7 +4352,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name_len * 2);
+	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname_len(fname) * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
@@ -4361,10 +4365,10 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const char *name, int name_len)
+		       const struct fscrypt_name *fname)
 {
 	int ret;
-	ret = __btrfs_unlink_inode(trans, dir, inode, name, name_len, NULL);
+	ret = __btrfs_unlink_inode(trans, dir, inode, fname, NULL);
 	if (!ret) {
 		drop_nlink(&inode->vfs_inode);
 		ret = btrfs_update_inode(trans, inode->root, inode);
@@ -4400,6 +4404,10 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct btrfs_trans_handle *trans;
 	struct inode *inode = d_inode(dentry);
 	int ret;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((unsigned char *)dentry->d_name.name, dentry->d_name.len)
+	};
+
 
 	trans = __unlink_start_trans(dir);
 	if (IS_ERR(trans))
@@ -4409,8 +4417,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 			0);
 
 	ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
-			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
-			dentry->d_name.len);
+			BTRFS_I(d_inode(dentry)), &fname);
 	if (ret)
 		goto out;
 
@@ -4435,12 +4442,14 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	const char *name = dentry->d_name.name;
-	int name_len = dentry->d_name.len;
 	u64 index;
 	int ret;
 	u64 objectid;
 	u64 dir_ino = btrfs_ino(BTRFS_I(dir));
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) dentry->d_name.name,
+				       dentry->d_name.len)
+	};
 
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		objectid = inode->root->root_key.objectid;
@@ -4455,8 +4464,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				   name, name_len, -1);
+	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, &fname, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -4482,8 +4490,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
 	 */
 	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
-		di = btrfs_search_dir_index_item(root, path, dir_ino,
-						 name, name_len);
+		di = btrfs_search_dir_index_item(root, path, dir_ino, &fname);
 		if (IS_ERR_OR_NULL(di)) {
 			if (!di)
 				ret = -ENOENT;
@@ -4500,7 +4507,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	} else {
 		ret = btrfs_del_root_ref(trans, objectid,
 					 root->root_key.objectid, dir_ino,
-					 &index, name, name_len);
+					 &index, &fname);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4513,7 +4520,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name_len * 2);
+	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - fname_len(&fname) * 2);
 	inode_inc_iversion(dir);
 	dir->i_mtime = current_time(dir);
 	dir->i_ctime = dir->i_mtime;
@@ -4537,6 +4544,10 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	struct btrfs_key key;
 	u64 dir_id;
 	int ret;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT("default", 7)
+	};
+
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4545,7 +4556,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	/* Make sure this root isn't set as the default subvol */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, fs_info->tree_root, path,
-				   dir_id, "default", 7, 0);
+				   dir_id, &fname, 0);
 	if (di && !IS_ERR(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
 		if (key.objectid == root->root_key.objectid) {
@@ -4784,6 +4795,9 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	int err = 0;
 	struct btrfs_trans_handle *trans;
 	u64 last_unlink_trans;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((unsigned char *)dentry->d_name.name, dentry->d_name.len)
+	};
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
@@ -4813,8 +4827,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 
 	/* now the directory is empty */
 	err = btrfs_unlink_inode(trans, BTRFS_I(dir),
-			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
-			dentry->d_name.len);
+			BTRFS_I(d_inode(dentry)), &fname);
 	if (!err) {
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 		/*
@@ -5535,19 +5548,21 @@ void btrfs_evict_inode(struct inode *inode)
 static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 			       struct btrfs_key *location, u8 *type)
 {
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
 	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	int ret = 0;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) dentry->d_name.name,
+				       dentry->d_name.len)
+	};
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(NULL, root, path, btrfs_ino(BTRFS_I(dir)),
-			name, namelen, 0);
+				   &fname, 0);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -5559,7 +5574,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 		ret = -EUCLEAN;
 		btrfs_warn(root->fs_info,
 "%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
-			   __func__, name, btrfs_ino(BTRFS_I(dir)),
+			   __func__, fname_name(&fname), btrfs_ino(BTRFS_I(dir)),
 			   location->objectid, location->type, location->offset);
 	}
 	if (!ret)
@@ -6243,6 +6258,14 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 	if (ret)
 		return ret;
 
+	if (!args->orphan) {
+		char *name = (char *) args->dentry->d_name.name;
+		int name_len = args->dentry->d_name.len;
+		args->fname = (struct fscrypt_name) {
+			.disk_name = FSTR_INIT(name, name_len),
+		};
+	}
+
 	/* 1 to add inode item */
 	*trans_num_items = 1;
 	/* 1 to add compression property */
@@ -6316,8 +6339,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 {
 	struct inode *dir = args->dir;
 	struct inode *inode = args->inode;
-	const char *name = args->orphan ? NULL : args->dentry->d_name.name;
-	int name_len = args->orphan ? 0 : args->dentry->d_name.len;
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
@@ -6418,7 +6439,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			sizes[1] = 2 + sizeof(*ref);
 		} else {
 			key[1].offset = btrfs_ino(BTRFS_I(dir));
-			sizes[1] = name_len + sizeof(*ref);
+			sizes[1] = fname_len(&args->fname) + sizeof(*ref);
 		}
 	}
 
@@ -6457,10 +6478,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			btrfs_set_inode_ref_index(path->nodes[0], ref, 0);
 			write_extent_buffer(path->nodes[0], "..", ptr, 2);
 		} else {
-			btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
+			btrfs_set_inode_ref_name_len(path->nodes[0], ref,
+						  fname_len(&args->fname));
 			btrfs_set_inode_ref_index(path->nodes[0], ref,
 						  BTRFS_I(inode)->dir_index);
-			write_extent_buffer(path->nodes[0], name, ptr, name_len);
+			write_extent_buffer(path->nodes[0],
+					    fname_name(&args->fname), ptr,
+					    fname_len(&args->fname));
 		}
 	}
 
@@ -6520,8 +6544,9 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	if (args->orphan) {
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 	} else {
-		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-				     name_len, 0, BTRFS_I(inode)->dir_index);
+		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+				     &args->fname, 0,
+				     BTRFS_I(inode)->dir_index);
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -6550,7 +6575,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
  */
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
-		   const char *name, int name_len, int add_backref, u64 index)
+		   const struct fscrypt_name *fname, int add_backref, u64 index)
 {
 	int ret = 0;
 	struct btrfs_key key;
@@ -6569,17 +6594,17 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_add_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
-					 index, name, name_len);
+					 index, fname);
 	} else if (add_backref) {
-		ret = btrfs_insert_inode_ref(trans, root, name, name_len, ino,
-					     parent_ino, index);
+		ret = btrfs_insert_inode_ref(trans, root, fname, ino, parent_ino,
+					     index);
 	}
 
 	/* Nothing to clean up yet */
 	if (ret)
 		return ret;
 
-	ret = btrfs_insert_dir_item(trans, name, name_len, parent_inode, &key,
+	ret = btrfs_insert_dir_item(trans, fname, parent_inode, &key,
 				    btrfs_inode_type(&inode->vfs_inode), index);
 	if (ret == -EEXIST || ret == -EOVERFLOW)
 		goto fail_dir_item;
@@ -6589,7 +6614,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_i_size_write(parent_inode, parent_inode->vfs_inode.i_size +
-			   name_len * 2);
+			   fname_len(fname) * 2);
 	inode_inc_iversion(&parent_inode->vfs_inode);
 	/*
 	 * If we are replaying a log tree, we do not want to update the mtime
@@ -6612,17 +6637,18 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		u64 local_index;
 		int err;
+
 		err = btrfs_del_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
-					 &local_index, name, name_len);
+					 &local_index, fname);
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
 		u64 local_index;
 		int err;
 
-		err = btrfs_del_inode_ref(trans, root, name, name_len,
-					  ino, parent_ino, &local_index);
+		err = btrfs_del_inode_ref(trans, root, fname, ino,
+					  parent_ino, &local_index);
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	}
@@ -6705,6 +6731,10 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) dentry->d_name.name,
+				       dentry->d_name.len)
+	};
 	u64 index;
 	int err;
 	int drop_inode = 0;
@@ -6741,8 +6771,8 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
-	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     dentry->d_name.name, dentry->d_name.len, 1, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), &fname, 1,
+			     index);
 
 	if (err) {
 		drop_inode = 1;
@@ -9151,6 +9181,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	int ret;
 	int ret2;
 	bool need_abort = false;
+	struct fscrypt_name old_name = {
+		.disk_name = FSTR_INIT((char *) old_dentry->d_name.name,
+				       old_dentry->d_name.len)
+	};
+	struct fscrypt_name new_name = {
+		.disk_name = FSTR_INIT((char *) new_dentry->d_name.name,
+				       new_dentry->d_name.len)
+	};
 
 	/*
 	 * For non-subvolumes allow exchange only within one subvolume, in the
@@ -9229,10 +9267,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, dest,
-					     new_dentry->d_name.name,
-					     new_dentry->d_name.len,
-					     old_ino,
+		ret = btrfs_insert_inode_ref(trans, dest, &new_name, old_ino,
 					     btrfs_ino(BTRFS_I(new_dir)),
 					     old_idx);
 		if (ret)
@@ -9245,10 +9280,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, root,
-					     old_dentry->d_name.name,
-					     old_dentry->d_name.len,
-					     new_ino,
+		ret = btrfs_insert_inode_ref(trans, root, &old_name, new_ino,
 					     btrfs_ino(BTRFS_I(old_dir)),
 					     new_idx);
 		if (ret) {
@@ -9282,9 +9314,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
-					   BTRFS_I(old_dentry->d_inode),
-					   old_dentry->d_name.name,
-					   old_dentry->d_name.len,
+					   BTRFS_I(old_dentry->d_inode), &old_name,
 					   &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
@@ -9299,9 +9329,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
-					   BTRFS_I(new_dentry->d_inode),
-					   new_dentry->d_name.name,
-					   new_dentry->d_name.len,
+					   BTRFS_I(new_dentry->d_inode), &new_name,
 					   &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
@@ -9312,16 +9340,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len, 0, old_idx);
+			     &new_name, 0, old_idx);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(old_dir), BTRFS_I(new_inode),
-			     old_dentry->d_name.name,
-			     old_dentry->d_name.len, 0, new_idx);
+			     &old_name, 0, new_idx);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
@@ -9403,6 +9429,14 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	int ret;
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
+	struct fscrypt_name old_fname = {
+		.disk_name = FSTR_INIT((char *)old_dentry->d_name.name,
+				       old_dentry->d_name.len)
+	};
+	struct fscrypt_name new_fname = {
+		.disk_name = FSTR_INIT((char *)new_dentry->d_name.name,
+				       new_dentry->d_name.len)
+	};
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -9419,11 +9453,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	    new_inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
 
-
 	/* check for collisions, even if the  name isn't there */
-	ret = btrfs_check_dir_item_collision(dest, new_dir->i_ino,
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len);
+	ret = btrfs_check_dir_item_collision(dest, new_dir->i_ino, &new_fname);
 
 	if (ret) {
 		if (ret == -EEXIST) {
@@ -9517,11 +9548,9 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, dest,
-					     new_dentry->d_name.name,
-					     new_dentry->d_name.len,
-					     old_ino,
-					     btrfs_ino(BTRFS_I(new_dir)), index);
+		ret = btrfs_insert_inode_ref(trans, dest, &new_fname, old_ino,
+					     btrfs_ino(BTRFS_I(new_dir)),
+					     index);
 		if (ret)
 			goto out_fail;
 	}
@@ -9544,9 +9573,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	} else {
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
-					old_dentry->d_name.name,
-					old_dentry->d_name.len,
-					&rename_ctx);
+					&old_fname, &rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
 	}
@@ -9565,8 +9592,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		} else {
 			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 						 BTRFS_I(d_inode(new_dentry)),
-						 new_dentry->d_name.name,
-						 new_dentry->d_name.len);
+						 &new_fname);
 		}
 		if (!ret && new_inode->i_nlink == 0)
 			ret = btrfs_orphan_add(trans,
@@ -9578,8 +9604,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     new_dentry->d_name.name,
-			     new_dentry->d_name.len, 0, index);
+			     &new_fname, 0, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe0cc816b4eb..10b8db56edda 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -941,7 +941,7 @@ static inline int btrfs_may_create(struct user_namespace *mnt_userns,
  */
 static noinline int btrfs_mksubvol(const struct path *parent,
 				   struct user_namespace *mnt_userns,
-				   const char *name, int namelen,
+				   struct fscrypt_name *fname,
 				   struct btrfs_root *snap_src,
 				   bool readonly,
 				   struct btrfs_qgroup_inherit *inherit)
@@ -955,7 +955,8 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (error == -EINTR)
 		return error;
 
-	dentry = lookup_one(mnt_userns, name, parent->dentry, namelen);
+	dentry = lookup_one(mnt_userns, fname_name(fname), parent->dentry,
+			    fname_len(fname));
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
@@ -969,8 +970,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	 * check for them now when we can safely fail
 	 */
 	error = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
-					       dir->i_ino, name,
-					       namelen);
+					       dir->i_ino, fname);
 	if (error)
 		goto out_dput;
 
@@ -997,7 +997,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 
 static noinline int btrfs_mksnapshot(const struct path *parent,
 				   struct user_namespace *mnt_userns,
-				   const char *name, int namelen,
+				   struct fscrypt_name *fname,
 				   struct btrfs_root *root,
 				   bool readonly,
 				   struct btrfs_qgroup_inherit *inherit)
@@ -1026,7 +1026,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
-	ret = btrfs_mksubvol(parent, mnt_userns, name, namelen,
+	ret = btrfs_mksubvol(parent, mnt_userns, fname,
 			     root, readonly, inherit);
 out:
 	if (snapshot_force_cow)
@@ -2138,6 +2138,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 {
 	int namelen;
 	int ret = 0;
+	struct fscrypt_name fname;
 
 	if (!S_ISDIR(file_inode(file)->i_mode))
 		return -ENOTDIR;
@@ -2158,9 +2159,12 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 		goto out_drop_write;
 	}
 
+	fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT((char *) name, namelen)
+	};
 	if (subvol) {
-		ret = btrfs_mksubvol(&file->f_path, mnt_userns, name,
-				     namelen, NULL, readonly, inherit);
+		ret = btrfs_mksubvol(&file->f_path, mnt_userns, &fname,
+				     NULL, readonly, inherit);
 	} else {
 		struct fd src = fdget(fd);
 		struct inode *src_inode;
@@ -2182,8 +2186,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			ret = -EPERM;
 		} else {
 			ret = btrfs_mksnapshot(&file->f_path, mnt_userns,
-					       name, namelen,
-					       BTRFS_I(src_inode)->root,
+					       &fname, BTRFS_I(src_inode)->root,
 					       readonly, inherit);
 		}
 		fdput(src);
@@ -3777,6 +3780,10 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	u64 objectid = 0;
 	u64 dir_id;
 	int ret;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT("default", 7)
+	};
+
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3817,7 +3824,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(trans, fs_info->tree_root, path,
-				   dir_id, "default", 7, 1);
+				   dir_id, &fname, 1);
 	if (IS_ERR_OR_NULL(di)) {
 		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 055a631276ce..21ae776cbe86 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -43,7 +43,10 @@ find_prop_handler(const char *name,
 	struct prop_handler *h;
 
 	if (!handlers) {
-		u64 hash = btrfs_name_hash(name, strlen(name));
+		struct fscrypt_name fname = {
+			.disk_name = FSTR_INIT((char *) name, strlen(name)),
+		};
+		u64 hash = btrfs_name_hash(&fname);
 
 		handlers = find_prop_handlers_by_hash(hash);
 		if (!handlers)
@@ -459,7 +462,11 @@ void __init btrfs_props_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(prop_handlers); i++) {
 		struct prop_handler *p = &prop_handlers[i];
-		u64 h = btrfs_name_hash(p->xattr_name, strlen(p->xattr_name));
+		struct fscrypt_name fname = {
+			.disk_name = FSTR_INIT((char *)p->xattr_name,
+					       strlen(p->xattr_name)),
+		};
+		u64 h = btrfs_name_hash(&fname);
 
 		hash_add(prop_handlers_ht, &p->node, h);
 	}
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e1f599d7a916..f44f02c22027 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -327,8 +327,8 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 *sequence, const char *name,
-		       int name_len)
+		       u64 ref_id, u64 dirid, u64 *sequence,
+		       const struct fscrypt_name *fname)
 
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
@@ -356,8 +356,9 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 				     struct btrfs_root_ref);
 		ptr = (unsigned long)(ref + 1);
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
-		    (btrfs_root_ref_name_len(leaf, ref) != name_len) ||
-		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
+		    (btrfs_root_ref_name_len(leaf, ref) != fname_len(fname)) ||
+		    memcmp_extent_buffer(leaf, fname_name(fname), ptr,
+					 fname_len(fname))) {
 			ret = -ENOENT;
 			goto out;
 		}
@@ -400,8 +401,8 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
  * Will return 0, -ENOMEM, or anything from the CoW path
  */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
-		       int name_len)
+		       u64 ref_id, u64 dirid, u64 sequence,
+		       const struct fscrypt_name *fname)
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
 	struct btrfs_key key;
@@ -420,7 +421,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	key.offset = ref_id;
 again:
 	ret = btrfs_insert_empty_item(trans, tree_root, path, &key,
-				      sizeof(*ref) + name_len);
+				      sizeof(*ref) + fname_len(fname));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_free_path(path);
@@ -431,9 +432,9 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	ref = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_root_ref);
 	btrfs_set_root_ref_dirid(leaf, ref, dirid);
 	btrfs_set_root_ref_sequence(leaf, ref, sequence);
-	btrfs_set_root_ref_name_len(leaf, ref, name_len);
+	btrfs_set_root_ref_name_len(leaf, ref, fname_len(fname));
 	ptr = (unsigned long)(ref + 1);
-	write_extent_buffer(leaf, name, ptr, name_len);
+	write_extent_buffer(leaf, fname_name(fname), ptr, fname_len(fname));
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 127673c81a02..910af5f25a90 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/compat.h>
 #include <linux/crc32c.h>
+#include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 
 #include "send.h"
@@ -1038,7 +1039,7 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 }
 
 typedef int (*iterate_dir_item_t)(int num, struct btrfs_key *di_key,
-				  const char *name, int name_len,
+				  struct fscrypt_name *fname,
 				  const char *data, int data_len,
 				  void *ctx);
 
@@ -1088,6 +1089,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	num = 0;
 	while (cur < total) {
+		struct fscrypt_name fname;
 		name_len = btrfs_dir_name_len(eb, di);
 		data_len = btrfs_dir_data_len(eb, di);
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
@@ -1140,8 +1142,11 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 		len = sizeof(*di) + name_len + data_len;
 		di = (struct btrfs_dir_item *)((char *)di + len);
 		cur += len;
+		fname = (struct fscrypt_name) {
+			.disk_name = FSTR_INIT(buf, name_len)
+		};
 
-		ret = iterate(num, &di_key, buf, name_len, buf + name_len,
+		ret = iterate(num, &di_key, &fname, buf + name_len,
 			      data_len, ctx);
 		if (ret < 0)
 			goto out;
@@ -1595,13 +1600,17 @@ static int gen_unique_name(struct send_ctx *sctx,
 		return -ENOMEM;
 
 	while (1) {
+		struct fscrypt_name fname;
 		len = snprintf(tmp, sizeof(tmp), "o%llu-%llu-%llu",
 				ino, gen, idx);
 		ASSERT(len < sizeof(tmp));
+		fname = (struct fscrypt_name) {
+			.disk_name = FSTR_INIT(tmp, strlen(tmp)),//len)
+		};
 
 		di = btrfs_lookup_dir_item(NULL, sctx->send_root,
 				path, BTRFS_FIRST_FREE_OBJECTID,
-				tmp, strlen(tmp), 0);
+				&fname, 0);
 		btrfs_release_path(path);
 		if (IS_ERR(di)) {
 			ret = PTR_ERR(di);
@@ -1621,7 +1630,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 
 		di = btrfs_lookup_dir_item(NULL, sctx->parent_root,
 				path, BTRFS_FIRST_FREE_OBJECTID,
-				tmp, strlen(tmp), 0);
+				&fname, 0);
 		btrfs_release_path(path);
 		if (IS_ERR(di)) {
 			ret = PTR_ERR(di);
@@ -1744,7 +1753,7 @@ static int is_inode_existent(struct send_ctx *sctx, u64 ino, u64 gen)
  * Helper function to lookup a dir item in a dir.
  */
 static int lookup_dir_item_inode(struct btrfs_root *root,
-				 u64 dir, const char *name, int name_len,
+				 u64 dir, struct fscrypt_name *fname,
 				 u64 *found_inode)
 {
 	int ret = 0;
@@ -1757,7 +1766,7 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(NULL, root, path,
-			dir, name, name_len, 0);
+			dir, fname, 0);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -1846,7 +1855,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 
 static int is_first_ref(struct btrfs_root *root,
 			u64 ino, u64 dir,
-			const char *name, int name_len)
+			struct fscrypt_name *fname)
 {
 	int ret;
 	struct fs_path *tmp_name;
@@ -1860,12 +1869,12 @@ static int is_first_ref(struct btrfs_root *root,
 	if (ret < 0)
 		goto out;
 
-	if (dir != tmp_dir || name_len != fs_path_len(tmp_name)) {
+	if (dir != tmp_dir || fname_len(fname) != fs_path_len(tmp_name)) {
 		ret = 0;
 		goto out;
 	}
 
-	ret = !memcmp(tmp_name->start, name, name_len);
+	ret = !memcmp(tmp_name->start, fname_name(fname), fname_len(fname));
 
 out:
 	fs_path_free(tmp_name);
@@ -1883,7 +1892,7 @@ static int is_first_ref(struct btrfs_root *root,
  * orphanizing is really required.
  */
 static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
-			      const char *name, int name_len,
+			      struct fscrypt_name *fname,
 			      u64 *who_ino, u64 *who_gen, u64 *who_mode)
 {
 	int ret = 0;
@@ -1915,7 +1924,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			goto out;
 	}
 
-	ret = lookup_dir_item_inode(sctx->parent_root, dir, name, name_len,
+	ret = lookup_dir_item_inode(sctx->parent_root, dir, fname,
 				    &other_inode);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
@@ -1957,7 +1966,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 static int did_overwrite_ref(struct send_ctx *sctx,
 			    u64 dir, u64 dir_gen,
 			    u64 ino, u64 ino_gen,
-			    const char *name, int name_len)
+			    struct fscrypt_name *fname)
 {
 	int ret = 0;
 	u64 gen;
@@ -1983,7 +1992,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 	}
 
 	/* check if the ref was overwritten by another ref */
-	ret = lookup_dir_item_inode(sctx->send_root, dir, name, name_len,
+	ret = lookup_dir_item_inode(sctx->send_root, dir, fname,
 				    &ow_inode);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
@@ -2030,7 +2039,7 @@ static int did_overwrite_first_ref(struct send_ctx *sctx, u64 ino, u64 gen)
 	struct fs_path *name = NULL;
 	u64 dir;
 	u64 dir_gen;
-
+	struct fscrypt_name fname;
 	if (!sctx->parent_root)
 		goto out;
 
@@ -2042,8 +2051,12 @@ static int did_overwrite_first_ref(struct send_ctx *sctx, u64 ino, u64 gen)
 	if (ret < 0)
 		goto out;
 
+	fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(name->start, fs_path_len(name))
+	};
+
 	ret = did_overwrite_ref(sctx, dir, dir_gen, ino, gen,
-			name->start, fs_path_len(name));
+			&fname);
 
 out:
 	fs_path_free(name);
@@ -2176,6 +2189,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	int ret;
 	int nce_ret;
 	struct name_cache_entry *nce = NULL;
+	struct fscrypt_name fname;
 
 	/*
 	 * First check if we already did a call to this function with the same
@@ -2240,8 +2254,11 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	 * Check if the ref was overwritten by an inode's ref that was processed
 	 * earlier. If yes, treat as orphan and return 1.
 	 */
+	fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(dest->start, fs_path_len(dest))
+	};
 	ret = did_overwrite_ref(sctx, *parent_ino, *parent_gen, ino, gen,
-			dest->start, dest->end - dest->start);
+				&fname);
 	if (ret < 0)
 		goto out;
 	if (ret) {
@@ -3510,6 +3527,9 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 	u64 right_gen;
 	int ret = 0;
 	struct waiting_dir_move *wdm;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT(parent_ref->name, parent_ref->name_len)
+	};
 
 	if (RB_EMPTY_ROOT(&sctx->waiting_dir_moves))
 		return 0;
@@ -3520,7 +3540,7 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 
 	key.objectid = parent_ref->dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(parent_ref->name, parent_ref->name_len);
+	key.offset = btrfs_name_hash(&fname);
 
 	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
 	if (ret < 0) {
@@ -3530,8 +3550,7 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 		goto out;
 	}
 
-	di = btrfs_match_dir_item_name(fs_info, path, parent_ref->name,
-				       parent_ref->name_len);
+	di = btrfs_match_dir_item_name(fs_info, path, &fname);
 	if (!di) {
 		ret = 0;
 		goto out;
@@ -4007,6 +4026,10 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	 * "testdir_2".
 	 */
 	list_for_each_entry(cur, &sctx->new_refs, list) {
+		struct fscrypt_name fname = {
+			.disk_name = FSTR_INIT(cur->name, cur->name_len)
+		};
+
 		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen);
 		if (ret < 0)
 			goto out;
@@ -4020,14 +4043,12 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * simply unlink it.
 		 */
 		ret = will_overwrite_ref(sctx, cur->dir, cur->dir_gen,
-				cur->name, cur->name_len,
-				&ow_inode, &ow_gen, &ow_mode);
+				&fname, &ow_inode, &ow_gen, &ow_mode);
 		if (ret < 0)
 			goto out;
 		if (ret) {
 			ret = is_first_ref(sctx->parent_root,
-					   ow_inode, cur->dir, cur->name,
-					   cur->name_len);
+					   ow_inode, cur->dir, &fname);
 			if (ret < 0)
 				goto out;
 			if (ret) {
@@ -4273,9 +4294,13 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * inodes.
 		 */
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
+			struct fscrypt_name fname = {
+				.disk_name = FSTR_INIT(cur->name, cur->name_len)
+			};
+
 			ret = did_overwrite_ref(sctx, cur->dir, cur->dir_gen,
 					sctx->cur_ino, sctx->cur_inode_gen,
-					cur->name, cur->name_len);
+					&fname);
 			if (ret < 0)
 				goto out;
 			if (!ret) {
@@ -4615,7 +4640,7 @@ static int process_all_refs(struct send_ctx *sctx,
 
 static int send_set_xattr(struct send_ctx *sctx,
 			  struct fs_path *path,
-			  const char *name, int name_len,
+			  struct fscrypt_name *fname,
 			  const char *data, int data_len)
 {
 	int ret = 0;
@@ -4625,7 +4650,8 @@ static int send_set_xattr(struct send_ctx *sctx,
 		goto out;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
-	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, name, name_len);
+	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, fname_name(fname),
+		       fname_len(fname));
 	TLV_PUT(sctx, BTRFS_SEND_A_XATTR_DATA, data, data_len);
 
 	ret = send_cmd(sctx);
@@ -4637,7 +4663,7 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 static int send_remove_xattr(struct send_ctx *sctx,
 			  struct fs_path *path,
-			  const char *name, int name_len)
+			  struct fscrypt_name *fname)
 {
 	int ret = 0;
 
@@ -4646,7 +4672,8 @@ static int send_remove_xattr(struct send_ctx *sctx,
 		goto out;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
-	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, name, name_len);
+	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, fname_name(fname),
+		       fname_len(fname));
 
 	ret = send_cmd(sctx);
 
@@ -4656,7 +4683,7 @@ static int send_remove_xattr(struct send_ctx *sctx,
 }
 
 static int __process_new_xattr(int num, struct btrfs_key *di_key,
-			       const char *name, int name_len, const char *data,
+			       struct fscrypt_name *fname, const char *data,
 			       int data_len, void *ctx)
 {
 	int ret;
@@ -4665,7 +4692,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 	struct posix_acl_xattr_header dummy_acl;
 
 	/* Capabilities are emitted by finish_inode_if_needed */
-	if (!strncmp(name, XATTR_NAME_CAPS, name_len))
+	if (!strncmp(fname_name(fname), XATTR_NAME_CAPS, fname_len(fname)))
 		return 0;
 
 	p = fs_path_alloc();
@@ -4678,8 +4705,10 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 	 * acls will fail later. To fix this, we send a dummy acl list that
 	 * only contains the version number and no entries.
 	 */
-	if (!strncmp(name, XATTR_NAME_POSIX_ACL_ACCESS, name_len) ||
-	    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT, name_len)) {
+	if (!strncmp(fname_name(fname), XATTR_NAME_POSIX_ACL_ACCESS,
+		     fname_len(fname)) ||
+	    !strncmp(fname_name(fname), XATTR_NAME_POSIX_ACL_DEFAULT,
+		     fname_len(fname))) {
 		if (data_len == 0) {
 			dummy_acl.a_version =
 					cpu_to_le32(POSIX_ACL_XATTR_VERSION);
@@ -4692,7 +4721,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 	if (ret < 0)
 		goto out;
 
-	ret = send_set_xattr(sctx, p, name, name_len, data, data_len);
+	ret = send_set_xattr(sctx, p, fname, data, data_len);
 
 out:
 	fs_path_free(p);
@@ -4700,7 +4729,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 }
 
 static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
-				   const char *name, int name_len,
+				   struct fscrypt_name *fname,
 				   const char *data, int data_len, void *ctx)
 {
 	int ret;
@@ -4715,7 +4744,7 @@ static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
 	if (ret < 0)
 		goto out;
 
-	ret = send_remove_xattr(sctx, p, name, name_len);
+	ret = send_remove_xattr(sctx, p, fname);
 
 out:
 	fs_path_free(p);
@@ -4739,20 +4768,21 @@ static int process_deleted_xattr(struct send_ctx *sctx)
 }
 
 struct find_xattr_ctx {
-	const char *name;
-	int name_len;
+	struct fscrypt_name *fname;
 	int found_idx;
 	char *found_data;
 	int found_data_len;
 };
 
-static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
-			int name_len, const char *data, int data_len, void *vctx)
+static int __find_xattr(int num, struct btrfs_key *di_key,
+			struct fscrypt_name *fname,
+			const char *data, int data_len, void *vctx)
 {
 	struct find_xattr_ctx *ctx = vctx;
 
-	if (name_len == ctx->name_len &&
-	    strncmp(name, ctx->name, name_len) == 0) {
+	if (fname_len(fname) == fname_len(ctx->fname) &&
+	    strncmp(fname_name(fname), fname_name(ctx->fname),
+		    fname_len(fname)) == 0) {
 		ctx->found_idx = num;
 		ctx->found_data_len = data_len;
 		ctx->found_data = kmemdup(data, data_len, GFP_KERNEL);
@@ -4766,14 +4796,13 @@ static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
 static int find_xattr(struct btrfs_root *root,
 		      struct btrfs_path *path,
 		      struct btrfs_key *key,
-		      const char *name, int name_len,
+		      struct fscrypt_name *fname,
 		      char **data, int *data_len)
 {
 	int ret;
 	struct find_xattr_ctx ctx;
 
-	ctx.name = name;
-	ctx.name_len = name_len;
+	ctx.fname = fname;
 	ctx.found_idx = -1;
 	ctx.found_data = NULL;
 	ctx.found_data_len = 0;
@@ -4795,7 +4824,7 @@ static int find_xattr(struct btrfs_root *root,
 
 
 static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
-				       const char *name, int name_len,
+				       struct fscrypt_name *fname,
 				       const char *data, int data_len,
 				       void *ctx)
 {
@@ -4805,15 +4834,15 @@ static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 	int found_data_len  = 0;
 
 	ret = find_xattr(sctx->parent_root, sctx->right_path,
-			 sctx->cmp_key, name, name_len, &found_data,
+			 sctx->cmp_key, fname, &found_data,
 			 &found_data_len);
 	if (ret == -ENOENT) {
-		ret = __process_new_xattr(num, di_key, name, name_len, data,
+		ret = __process_new_xattr(num, di_key, fname, data,
 					  data_len, ctx);
 	} else if (ret >= 0) {
 		if (data_len != found_data_len ||
 		    memcmp(data, found_data, data_len)) {
-			ret = __process_new_xattr(num, di_key, name, name_len,
+			ret = __process_new_xattr(num, di_key, fname,
 						  data, data_len, ctx);
 		} else {
 			ret = 0;
@@ -4825,7 +4854,7 @@ static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 }
 
 static int __process_changed_deleted_xattr(int num, struct btrfs_key *di_key,
-					   const char *name, int name_len,
+					   struct fscrypt_name *fname,
 					   const char *data, int data_len,
 					   void *ctx)
 {
@@ -4833,9 +4862,9 @@ static int __process_changed_deleted_xattr(int num, struct btrfs_key *di_key,
 	struct send_ctx *sctx = ctx;
 
 	ret = find_xattr(sctx->send_root, sctx->left_path, sctx->cmp_key,
-			 name, name_len, NULL, NULL);
+			 fname, NULL, NULL);
 	if (ret == -ENOENT)
-		ret = __process_deleted_xattr(num, di_key, name, name_len, data,
+		ret = __process_deleted_xattr(num, di_key, fname, data,
 					      data_len, ctx);
 	else if (ret >= 0)
 		ret = 0;
@@ -5574,13 +5603,16 @@ static int send_capabilities(struct send_ctx *sctx)
 	char *buf = NULL;
 	int buf_len;
 	int ret = 0;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT(XATTR_NAME_CAPS, strlen(XATTR_NAME_CAPS))
+	};
 
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
 
 	di = btrfs_lookup_xattr(NULL, sctx->send_root, path, sctx->cur_ino,
-				XATTR_NAME_CAPS, strlen(XATTR_NAME_CAPS), 0);
+				&fname, 0);
 	if (!di) {
 		/* There is no xattr for this inode */
 		goto out;
@@ -5606,8 +5638,7 @@ static int send_capabilities(struct send_ctx *sctx)
 	data_ptr = (unsigned long)(di + 1) + btrfs_dir_name_len(leaf, di);
 	read_extent_buffer(leaf, buf, data_ptr, buf_len);
 
-	ret = send_set_xattr(sctx, fspath, XATTR_NAME_CAPS,
-			strlen(XATTR_NAME_CAPS), buf, buf_len);
+	ret = send_set_xattr(sctx, fspath, &fname, buf, buf_len);
 out:
 	kfree(buf);
 	fs_path_free(fspath);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eb0ae7e396ef..b7118345c6f7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1395,6 +1395,9 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	struct btrfs_path *path;
 	struct btrfs_key location;
 	u64 dir_id;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT("default", 7),
+	};
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1406,7 +1409,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	 * to mount.
 	 */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
-	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, "default", 7, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &fname, 0);
 	if (IS_ERR(di)) {
 		btrfs_free_path(path);
 		return PTR_ERR(di);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d9e608935e64..b83e618a255d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1596,8 +1596,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
  * happens, we should return the error number. If the error which just affect
  * the creation of the pending snapshots, just return 0.
  */
-static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
-				   struct btrfs_pending_snapshot *pending)
+static noinline int
+create_pending_snapshot(struct btrfs_trans_handle *trans,
+			struct btrfs_pending_snapshot *pending)
 {
 
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1607,10 +1608,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = pending->root;
 	struct btrfs_root *parent_root;
 	struct btrfs_block_rsv *rsv;
-	struct inode *parent_inode;
+	struct inode *parent_inode = pending->dir;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *dir_item;
-	struct dentry *dentry;
 	struct extent_buffer *tmp;
 	struct extent_buffer *old;
 	struct timespec64 cur_time;
@@ -1619,6 +1619,10 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	u64 index = 0;
 	u64 objectid;
 	u64 root_flags;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) pending->dentry->d_name.name,
+				       pending->dentry->d_name.len)
+	};
 
 	ASSERT(pending->path);
 	path = pending->path;
@@ -1657,7 +1661,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	trace_btrfs_space_reservation(fs_info, "transaction",
 				      trans->transid,
 				      trans->bytes_reserved, 1);
-	dentry = pending->dentry;
 	parent_inode = pending->dir;
 	parent_root = BTRFS_I(parent_inode)->root;
 	ret = record_root_in_trans(trans, parent_root, 0);
@@ -1674,8 +1677,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	/* check if there is a file/dir which has the same name. */
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
 					 btrfs_ino(BTRFS_I(parent_inode)),
-					 dentry->d_name.name,
-					 dentry->d_name.len, 0);
+					 &fname, 0);
 	if (dir_item != NULL && !IS_ERR(dir_item)) {
 		pending->error = -EEXIST;
 		goto dir_item_existed;
@@ -1770,7 +1772,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	ret = btrfs_add_root_ref(trans, objectid,
 				 parent_root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(parent_inode)), index,
-				 dentry->d_name.name, dentry->d_name.len);
+				 &fname);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
@@ -1802,8 +1804,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto fail;
 
-	ret = btrfs_insert_dir_item(trans, dentry->d_name.name,
-				    dentry->d_name.len, BTRFS_I(parent_inode),
+	ret = btrfs_insert_dir_item(trans, &fname, BTRFS_I(parent_inode),
 				    &key, BTRFS_FT_DIR, index);
 	/* We have check then name at the beginning, so it is impossible. */
 	BUG_ON(ret == -EEXIST || ret == -EOVERFLOW);
@@ -1812,8 +1813,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
-					 dentry->d_name.len * 2);
+	btrfs_i_size_write(BTRFS_I(parent_inode),
+			   parent_inode->i_size + fname_len(&fname) * 2);
 	parent_inode->i_mtime = current_time(parent_inode);
 	parent_inode->i_ctime = parent_inode->i_mtime;
 	ret = btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_inode));
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 77c53a7491cf..2c6d48af1d2a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -595,10 +595,14 @@ static int check_dir_item(struct extent_buffer *leaf,
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
 			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			struct fscrypt_name fname;
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
-			name_hash = btrfs_name_hash(namebuf, name_len);
+			fname = (struct fscrypt_name) {
+				.disk_name = FSTR_INIT(namebuf, name_len)
+			};
+			name_hash = btrfs_name_hash(&fname);
 			if (unlikely(key->offset != name_hash)) {
 				dir_item_err(leaf, slot,
 		"name hash mismatch with key, have 0x%016x expect 0x%016llx",
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8467fadd6a23..40cfaa9feff3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -901,12 +901,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *dir,
 				       struct btrfs_inode *inode,
-				       const char *name,
-				       int name_len)
+				       const struct fscrypt_name *fname)
 {
 	int ret;
 
-	ret = btrfs_unlink_inode(trans, dir, inode, name, name_len);
+	ret = btrfs_unlink_inode(trans, dir, inode, fname);
 	if (ret)
 		return ret;
 	/*
@@ -938,6 +937,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key location;
 	int ret;
+	struct fscrypt_name fname;
 
 	leaf = path->nodes[0];
 
@@ -950,6 +950,10 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	read_extent_buffer(leaf, name, (unsigned long)(di + 1), name_len);
 	btrfs_release_path(path);
 
+	fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(name, name_len)
+	};
+
 	inode = read_one_inode(root, location.objectid);
 	if (!inode) {
 		ret = -EIO;
@@ -960,8 +964,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), name,
-			name_len);
+	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), &fname);
 out:
 	kfree(name);
 	iput(inode);
@@ -978,14 +981,14 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 static noinline int inode_in_dir(struct btrfs_root *root,
 				 struct btrfs_path *path,
 				 u64 dirid, u64 objectid, u64 index,
-				 const char *name, int name_len)
+				 const struct fscrypt_name *fname)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key location;
 	int ret = 0;
 
 	di = btrfs_lookup_dir_index_item(NULL, root, path, dirid,
-					 index, name, name_len, 0);
+					 index, fname, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		goto out;
@@ -998,7 +1001,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 	}
 
 	btrfs_release_path(path);
-	di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, name_len, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dirid, fname, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		goto out;
@@ -1025,7 +1028,7 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 static noinline int backref_in_log(struct btrfs_root *log,
 				   struct btrfs_key *key,
 				   u64 ref_objectid,
-				   const char *name, int namelen)
+				   struct fscrypt_name *fname)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -1046,11 +1049,11 @@ static noinline int backref_in_log(struct btrfs_root *log,
 		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
 						       path->slots[0],
 						       ref_objectid,
-						       name, namelen);
+						       fname);
 	else
 		ret = !!btrfs_find_name_in_backref(path->nodes[0],
 						   path->slots[0],
-						   name, namelen);
+						   fname);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -1063,7 +1066,8 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
 				  u64 inode_objectid, u64 parent_objectid,
-				  u64 ref_index, char *name, int namelen)
+				  u64 ref_index,
+				  struct fscrypt_name *fname)
 {
 	int ret;
 	char *victim_name;
@@ -1099,6 +1103,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
 		while (ptr < ptr_end) {
+			struct fscrypt_name victim_fname;
 			victim_ref = (struct btrfs_inode_ref *)ptr;
 			victim_name_len = btrfs_inode_ref_name_len(leaf,
 								   victim_ref);
@@ -1109,10 +1114,12 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 			read_extent_buffer(leaf, victim_name,
 					   (unsigned long)(victim_ref + 1),
 					   victim_name_len);
+			victim_fname = (struct fscrypt_name) {
+				.disk_name = FSTR_INIT(victim_name, victim_name_len)
+			};
 
 			ret = backref_in_log(log_root, &search_key,
-					     parent_objectid, victim_name,
-					     victim_name_len);
+					     parent_objectid, &victim_fname);
 			if (ret < 0) {
 				kfree(victim_name);
 				return ret;
@@ -1120,8 +1127,8 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				inc_nlink(&inode->vfs_inode);
 				btrfs_release_path(path);
 
-				ret = unlink_inode_for_log_replay(trans, dir, inode,
-						victim_name, victim_name_len);
+				ret = unlink_inode_for_log_replay(trans,
+						dir, inode, &victim_fname);
 				kfree(victim_name);
 				if (ret)
 					return ret;
@@ -1135,7 +1142,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* Same search but for extended refs */
-	extref = btrfs_lookup_inode_extref(NULL, root, path, name, namelen,
+	extref = btrfs_lookup_inode_extref(NULL, root, path, fname,
 					   inode_objectid, parent_objectid, 0,
 					   0);
 	if (IS_ERR(extref)) {
@@ -1152,6 +1159,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		base = btrfs_item_ptr_offset(leaf, path->slots[0]);
 
 		while (cur_offset < item_size) {
+			struct fscrypt_name victim_fname;
 			extref = (struct btrfs_inode_extref *)(base + cur_offset);
 
 			victim_name_len = btrfs_inode_extref_name_len(leaf, extref);
@@ -1165,14 +1173,15 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 			read_extent_buffer(leaf, victim_name, (unsigned long)&extref->name,
 					   victim_name_len);
 
+			victim_fname = (struct fscrypt_name) {
+				.disk_name = FSTR_INIT(victim_name, victim_name_len),
+			};
+
 			search_key.objectid = inode_objectid;
 			search_key.type = BTRFS_INODE_EXTREF_KEY;
-			search_key.offset = btrfs_extref_hash(parent_objectid,
-							      victim_name,
-							      victim_name_len);
+			search_key.offset = btrfs_extref_hash(parent_objectid, &victim_fname);
 			ret = backref_in_log(log_root, &search_key,
-					     parent_objectid, victim_name,
-					     victim_name_len);
+					     parent_objectid, &victim_fname);
 			if (ret < 0) {
 				kfree(victim_name);
 				return ret;
@@ -1186,9 +1195,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
 					ret = unlink_inode_for_log_replay(trans,
 							BTRFS_I(victim_parent),
-							inode,
-							victim_name,
-							victim_name_len);
+							inode, &victim_fname);
 				}
 				iput(victim_parent);
 				kfree(victim_name);
@@ -1205,7 +1212,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
 	/* look for a conflicting sequence number */
 	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
-					 ref_index, name, namelen, 0);
+					 ref_index, fname, 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
@@ -1217,7 +1224,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
 	/* look for a conflicting name */
 	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir),
-				   name, namelen, 0);
+				   fname, 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
@@ -1231,20 +1238,24 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 }
 
 static int extref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
-			     u32 *namelen, char **name, u64 *index,
+			     struct fscrypt_name *fname, u64 *index,
 			     u64 *parent_objectid)
 {
 	struct btrfs_inode_extref *extref;
-
+	u32 namelen;
+	char *name;
 	extref = (struct btrfs_inode_extref *)ref_ptr;
 
-	*namelen = btrfs_inode_extref_name_len(eb, extref);
-	*name = kmalloc(*namelen, GFP_NOFS);
-	if (*name == NULL)
+	namelen = btrfs_inode_extref_name_len(eb, extref);
+	name = kmalloc(namelen, GFP_NOFS);
+	if (name == NULL)
 		return -ENOMEM;
 
-	read_extent_buffer(eb, *name, (unsigned long)&extref->name,
-			   *namelen);
+	read_extent_buffer(eb, name, (unsigned long)&extref->name,
+			   namelen);
+	*fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(name, namelen)
+	};
 
 	if (index)
 		*index = btrfs_inode_extref_index(eb, extref);
@@ -1255,18 +1266,22 @@ static int extref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
 }
 
 static int ref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
-			  u32 *namelen, char **name, u64 *index)
+			  struct fscrypt_name *fname, u64 *index)
 {
 	struct btrfs_inode_ref *ref;
-
+	u32 namelen;
+	char *name;
 	ref = (struct btrfs_inode_ref *)ref_ptr;
 
-	*namelen = btrfs_inode_ref_name_len(eb, ref);
-	*name = kmalloc(*namelen, GFP_NOFS);
-	if (*name == NULL)
+	namelen = btrfs_inode_ref_name_len(eb, ref);
+	name = kmalloc(namelen, GFP_NOFS);
+	if (name == NULL)
 		return -ENOMEM;
 
-	read_extent_buffer(eb, *name, (unsigned long)(ref + 1), *namelen);
+	read_extent_buffer(eb, name, (unsigned long)(ref + 1), namelen);
+	*fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(name, namelen)
+	};
 
 	if (index)
 		*index = btrfs_inode_ref_index(eb, ref);
@@ -1308,16 +1323,15 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 	ref_ptr = btrfs_item_ptr_offset(eb, path->slots[0]);
 	ref_end = ref_ptr + btrfs_item_size(eb, path->slots[0]);
 	while (ref_ptr < ref_end) {
-		char *name = NULL;
-		int namelen;
 		u64 parent_id;
+		struct fscrypt_name fname;
 
 		if (key->type == BTRFS_INODE_EXTREF_KEY) {
-			ret = extref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = extref_get_fields(eb, ref_ptr, &fname,
 						NULL, &parent_id);
 		} else {
 			parent_id = key->offset;
-			ret = ref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = ref_get_fields(eb, ref_ptr, &fname,
 					     NULL);
 		}
 		if (ret)
@@ -1325,11 +1339,11 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 
 		if (key->type == BTRFS_INODE_EXTREF_KEY)
 			ret = !!btrfs_find_name_in_ext_backref(log_eb, log_slot,
-							       parent_id, name,
-							       namelen);
+							       parent_id,
+							       &fname);
 		else
 			ret = !!btrfs_find_name_in_backref(log_eb, log_slot,
-							   name, namelen);
+							   &fname);
 
 		if (!ret) {
 			struct inode *dir;
@@ -1338,20 +1352,20 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 			dir = read_one_inode(root, parent_id);
 			if (!dir) {
 				ret = -ENOENT;
-				kfree(name);
+				kfree(fname_name(&fname));
 				goto out;
 			}
 			ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
-						 inode, name, namelen);
-			kfree(name);
+						 inode, &fname);
+			kfree(fname_name(&fname));
 			iput(dir);
 			if (ret)
 				goto out;
 			goto again;
 		}
 
-		kfree(name);
-		ref_ptr += namelen;
+		kfree(fname_name(&fname));
+		ref_ptr += fname_len(&fname);
 		if (key->type == BTRFS_INODE_EXTREF_KEY)
 			ref_ptr += sizeof(struct btrfs_inode_extref);
 		else
@@ -1380,8 +1394,6 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	struct inode *inode = NULL;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
-	char *name = NULL;
-	int namelen;
 	int ret;
 	int log_ref_ver = 0;
 	u64 parent_objectid;
@@ -1424,8 +1436,9 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	}
 
 	while (ref_ptr < ref_end) {
+		struct fscrypt_name fname;
 		if (log_ref_ver) {
-			ret = extref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = extref_get_fields(eb, ref_ptr, &fname,
 						&ref_index, &parent_objectid);
 			/*
 			 * parent object can change from one array
@@ -1438,7 +1451,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 		} else {
-			ret = ref_get_fields(eb, ref_ptr, &namelen, &name,
+			ret = ref_get_fields(eb, ref_ptr, &fname,
 					     &ref_index);
 		}
 		if (ret)
@@ -1446,7 +1459,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 		ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
 				   btrfs_ino(BTRFS_I(inode)), ref_index,
-				   name, namelen);
+				   &fname);
 		if (ret < 0) {
 			goto out;
 		} else if (ret == 0) {
@@ -1460,7 +1473,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			ret = __add_inode_ref(trans, root, path, log,
 					      BTRFS_I(dir), BTRFS_I(inode),
 					      inode_objectid, parent_objectid,
-					      ref_index, name, namelen);
+					      ref_index, &fname);
 			if (ret) {
 				if (ret == 1)
 					ret = 0;
@@ -1469,7 +1482,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 			/* insert our name */
 			ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-					     name, namelen, 0, ref_index);
+					     &fname, 0, ref_index);
 			if (ret)
 				goto out;
 
@@ -1479,9 +1492,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
-		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
-		kfree(name);
-		name = NULL;
+		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + fname_len(&fname);
+		kfree(fname_name(&fname));
 		if (log_ref_ver) {
 			iput(dir);
 			dir = NULL;
@@ -1505,7 +1517,6 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	ret = overwrite_item(trans, root, path, eb, slot, key);
 out:
 	btrfs_release_path(path);
-	kfree(name);
 	iput(dir);
 	iput(inode);
 	return ret;
@@ -1777,7 +1788,7 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 				    struct btrfs_root *root,
 				    u64 dirid, u64 index,
-				    char *name, int name_len,
+				    struct fscrypt_name *fname,
 				    struct btrfs_key *location)
 {
 	struct inode *inode;
@@ -1794,8 +1805,8 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 		return -EIO;
 	}
 
-	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-			name_len, 1, index);
+	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), fname, 1,
+			     index);
 
 	/* FIXME, put inode into FIXUP list */
 
@@ -1869,6 +1880,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	int ret;
 	bool update_size = true;
 	bool name_added = false;
+	struct fscrypt_name fname;
 
 	dir = read_one_inode(root, key->objectid);
 	if (!dir)
@@ -1884,6 +1896,9 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	log_flags = btrfs_dir_flags(eb, di);
 	read_extent_buffer(eb, name, (unsigned long)(di + 1),
 		   name_len);
+	fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(name, name_len)
+	};
 
 	btrfs_dir_item_key_to_cpu(eb, di, &log_key);
 	ret = btrfs_lookup_inode(trans, root, path, &log_key, 0);
@@ -1894,7 +1909,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	ret = 0;
 
 	dir_dst_di = btrfs_lookup_dir_item(trans, root, path, key->objectid,
-					   name, name_len, 1);
+					   &fname, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
 		goto out;
@@ -1911,7 +1926,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 	index_dst_di = btrfs_lookup_dir_index_item(trans, root, path,
 						   key->objectid, key->offset,
-						   name, name_len, 1);
+						   &fname, 1);
 	if (IS_ERR(index_dst_di)) {
 		ret = PTR_ERR(index_dst_di);
 		goto out;
@@ -1939,7 +1954,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = key->objectid;
-	ret = backref_in_log(root->log_root, &search_key, 0, name, name_len);
+	ret = backref_in_log(root->log_root, &search_key, 0, &fname);
 	if (ret < 0) {
 	        goto out;
 	} else if (ret) {
@@ -1952,8 +1967,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
 	search_key.offset = key->objectid;
-	ret = backref_in_log(root->log_root, &search_key, key->objectid, name,
-			     name_len);
+	ret = backref_in_log(root->log_root, &search_key, key->objectid, &fname);
 	if (ret < 0) {
 		goto out;
 	} else if (ret) {
@@ -1964,7 +1978,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 	ret = insert_one_name(trans, root, key->objectid, key->offset,
-			      name, name_len, &log_key);
+			      &fname, &log_key);
 	if (ret && ret != -ENOENT && ret != -EEXIST)
 		goto out;
 	if (!ret)
@@ -2147,6 +2161,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	char *name;
 	struct inode *inode = NULL;
 	struct btrfs_key location;
+	struct fscrypt_name fname;
 
 	/*
 	 * Currently we only log dir index keys. Even if we replay a log created
@@ -2167,6 +2182,9 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	}
 
 	read_extent_buffer(eb, name, (unsigned long)(di + 1), name_len);
+	fname = (struct fscrypt_name) {
+		.disk_name = FSTR_INIT(name, name_len)
+	};
 
 	if (log) {
 		struct btrfs_dir_item *log_di;
@@ -2174,7 +2192,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 		log_di = btrfs_lookup_dir_index_item(trans, log, log_path,
 						     dir_key->objectid,
 						     dir_key->offset,
-						     name, name_len, 0);
+						     &fname, 0);
 		if (IS_ERR(log_di)) {
 			ret = PTR_ERR(log_di);
 			goto out;
@@ -2199,8 +2217,8 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 		goto out;
 
 	inc_nlink(inode);
-	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(inode),
-					  name, name_len);
+	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
+					      BTRFS_I(inode), &fname);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
@@ -2260,6 +2278,7 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 			u16 data_len = btrfs_dir_data_len(path->nodes[0], di);
 			u32 this_len = sizeof(*di) + name_len + data_len;
 			char *name;
+			struct fscrypt_name fname;
 
 			name = kmalloc(name_len, GFP_NOFS);
 			if (!name) {
@@ -2268,15 +2287,18 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 			}
 			read_extent_buffer(path->nodes[0], name,
 					   (unsigned long)(di + 1), name_len);
+			fname = (struct fscrypt_name) {
+				.disk_name = FSTR_INIT(name, name_len)
+			};
 
 			log_di = btrfs_lookup_xattr(NULL, log, log_path, ino,
-						    name, name_len, 0);
+						    &fname, 0);
 			btrfs_release_path(log_path);
 			if (!log_di) {
 				/* Doesn't exist in log tree, so delete it. */
 				btrfs_release_path(path);
 				di = btrfs_lookup_xattr(trans, root, path, ino,
-							name, name_len, -1);
+							&fname, -1);
 				kfree(name);
 				if (IS_ERR(di)) {
 					ret = PTR_ERR(di);
@@ -3448,7 +3470,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *log,
 			     struct btrfs_path *path,
 			     u64 dir_ino,
-			     const char *name, int name_len,
+			     const struct fscrypt_name *fname,
 			     u64 index)
 {
 	struct btrfs_dir_item *di;
@@ -3458,7 +3480,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 	 * for dir item keys.
 	 */
 	di = btrfs_lookup_dir_index_item(trans, log, path, dir_ino,
-					 index, name, name_len, -1);
+					 index, fname, -1);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	else if (!di)
@@ -3495,7 +3517,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
  */
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct fscrypt_name *fname,
 				  struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_path *path;
@@ -3522,7 +3544,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	}
 
 	ret = del_logged_dentry(trans, root->log_root, path, btrfs_ino(dir),
-				name, name_len, index);
+				fname, index);
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&dir->log_mutex);
@@ -3534,7 +3556,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 /* see comments for btrfs_del_dir_entries_in_log */
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root,
-				const char *name, int name_len,
+				const struct fscrypt_name *fname,
 				struct btrfs_inode *inode, u64 dirid)
 {
 	struct btrfs_root *log;
@@ -3555,7 +3577,7 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
 
-	ret = btrfs_del_inode_ref(trans, log, name, name_len, btrfs_ino(inode),
+	ret = btrfs_del_inode_ref(trans, log, fname, btrfs_ino(inode),
 				  dirid, &index);
 	mutex_unlock(&inode->log_mutex);
 	if (ret < 0 && ret != -ENOENT)
@@ -5218,6 +5240,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		u32 this_len;
 		unsigned long name_ptr;
 		struct btrfs_dir_item *di;
+		struct fscrypt_name fname;
 
 		if (key->type == BTRFS_INODE_REF_KEY) {
 			struct btrfs_inode_ref *iref;
@@ -5251,8 +5274,12 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		}
 
 		read_extent_buffer(eb, name, name_ptr, this_name_len);
+		fname = (struct fscrypt_name) {
+			.disk_name = FSTR_INIT(name, this_name_len)
+		};
+
 		di = btrfs_lookup_dir_item(NULL, inode->root, search_path,
-				parent, name, this_name_len, 0);
+				parent, &fname, 0);
 		if (di && !IS_ERR(di)) {
 			struct btrfs_key di_key;
 
@@ -7416,6 +7443,10 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	if (old_dir && old_dir->logged_trans == trans->transid) {
 		struct btrfs_root *log = old_dir->root->log_root;
 		struct btrfs_path *path;
+		struct fscrypt_name fname = {
+			.disk_name = FSTR_INIT((char *) old_dentry->d_name.name,
+					       old_dentry->d_name.len)
+		};
 
 		ASSERT(old_dir_index >= BTRFS_DIR_START_INDEX);
 
@@ -7453,8 +7484,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		 */
 		mutex_lock(&old_dir->log_mutex);
 		ret = del_logged_dentry(trans, log, path, btrfs_ino(old_dir),
-					old_dentry->d_name.name,
-					old_dentry->d_name.len, old_dir_index);
+					&fname, old_dir_index);
 		if (ret > 0) {
 			/*
 			 * The dentry does not exist in the log, so record its
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index aed1e05e9879..acea5da43284 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -86,11 +86,11 @@ int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
 			  struct btrfs_log_ctx *ctx);
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
-				  const char *name, int name_len,
+				  const struct fscrypt_name *name,
 				  struct btrfs_inode *dir, u64 index);
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root,
-				const char *name, int name_len,
+				const struct fscrypt_name *name,
 				struct btrfs_inode *inode, u64 dirid);
 void btrfs_end_log_trans(struct btrfs_root *root);
 void btrfs_pin_log_trans(struct btrfs_root *root);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 5bb8d8c86311..9bb45e230d35 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -21,7 +21,7 @@
 #include "locking.h"
 
 int btrfs_getxattr(struct inode *inode, const char *name,
-				void *buffer, size_t size)
+		   void *buffer, size_t size)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -29,6 +29,9 @@ int btrfs_getxattr(struct inode *inode, const char *name,
 	struct extent_buffer *leaf;
 	int ret = 0;
 	unsigned long data_ptr;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) name, strlen(name))
+	};
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -36,7 +39,7 @@ int btrfs_getxattr(struct inode *inode, const char *name,
 
 	/* lookup the xattr by name */
 	di = btrfs_lookup_xattr(NULL, root, path, btrfs_ino(BTRFS_I(inode)),
-			name, strlen(name), 0);
+				&fname, 0);
 	if (!di) {
 		ret = -ENODATA;
 		goto out;
@@ -85,6 +88,10 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	struct btrfs_path *path;
 	size_t name_len = strlen(name);
 	int ret = 0;
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) name, name_len)
+	};
+
 
 	ASSERT(trans);
 
@@ -98,7 +105,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 
 	if (!value) {
 		di = btrfs_lookup_xattr(trans, root, path,
-				btrfs_ino(BTRFS_I(inode)), name, name_len, -1);
+					btrfs_ino(BTRFS_I(inode)), &fname, -1);
 		if (!di && (flags & XATTR_REPLACE))
 			ret = -ENODATA;
 		else if (IS_ERR(di))
@@ -118,7 +125,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	if (flags & XATTR_REPLACE) {
 		ASSERT(inode_is_locked(inode));
 		di = btrfs_lookup_xattr(NULL, root, path,
-				btrfs_ino(BTRFS_I(inode)), name, name_len, 0);
+					btrfs_ino(BTRFS_I(inode)), &fname, 0);
 		if (!di)
 			ret = -ENODATA;
 		else if (IS_ERR(di))
@@ -130,7 +137,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	}
 
 	ret = btrfs_insert_xattr_item(trans, root, path, btrfs_ino(BTRFS_I(inode)),
-				      name, name_len, value, size);
+				      &fname, value, size);
 	if (ret == -EOVERFLOW) {
 		/*
 		 * We have an existing item in a leaf, split_leaf couldn't
@@ -139,14 +146,14 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		 */
 		ret = 0;
 		btrfs_assert_tree_write_locked(path->nodes[0]);
-		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
+		di = btrfs_match_dir_item_name(fs_info, path, &fname);
 		if (!di && !(flags & XATTR_REPLACE)) {
 			ret = -ENOSPC;
 			goto out;
 		}
 	} else if (ret == -EEXIST) {
 		ret = 0;
-		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
+		di = btrfs_match_dir_item_name(fs_info, path, &fname);
 		ASSERT(di); /* logic error */
 	} else if (ret) {
 		goto out;
-- 
2.35.1

