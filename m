Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6F57344F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiGMKbf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiGMKbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:33 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E2FD220
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:31 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 543E7802A1;
        Wed, 13 Jul 2022 06:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708291; bh=H9gUVx9+NnmwDAa/bAVzgK4742gY93CbU6l2ZAEEVfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofciH1KpbxZoc7uJkJKsgyrqUTnFsDGVK2ywoFepL+GKBSaP5ugiAQlT9OZKs14Z0
         duT3F5tSaamRIhRFPogD6IH8MPZ7ysDqsWse45YnI2RSrk0BWsM3HVJY75JF6SQlQ/
         ywQh1CBKE+b5yEEKqv3bbwWARckHETW+xfNXhMFu3YQ7dJGnJeUiTVGHB81SlG9PhP
         +6fP1X26BaYCg15ahg941gbjybbyuQrOnatx38+yKZR9B8/XI1xECHmmG1YSEzjeYg
         IXRpeZd68ru9K1yvVgSmdUerzuxOXFmgJ1JvGWppAif556B+4HzsJgigFC5IdI+pfy
         gYHNteTbu/17A==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 22/23] btrfs: adapt directory read and lookup to potentially encrypted filenames
Date:   Wed, 13 Jul 2022 06:29:55 -0400
Message-Id: <e2abf43d8a430aae4f5de8cc6e510a5fad764bde.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

When filenames can be encrypted, if we don't initially match a desired
filename, we have to try decrypting it with the directory key to see if
it matches in plaintext. Similarly, for readdir, we need to read
encrypted directory items as well as unencrypted.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/delayed-inode.c | 32 +++++++++++++---
 fs/btrfs/delayed-inode.h |  4 +-
 fs/btrfs/dir-item.c      | 18 +++++++++
 fs/btrfs/inode.c         | 81 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index d8ac12fdd991..9d8c88081b41 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1486,9 +1486,9 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 
 	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
+		// TODO: It would be nice to print the base64encoded name here maybe?
 		btrfs_err(trans->fs_info,
-			  "err add delayed dir index item(name: %.*s) into the insertion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  fname_len(fname), fname_name(fname),
+			  "err add delayed dir index item into the insertion tree of the delayed node (root id: %llu, inode id: %llu, errno: %d)",
 			  delayed_node->root->root_key.objectid,
 			  delayed_node->inode_id, ret);
 		BUG();
@@ -1721,7 +1721,9 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
  * btrfs_readdir_delayed_dir_index - read dir info stored in the delayed tree
  *
  */
-int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
+int btrfs_readdir_delayed_dir_index(struct inode *inode,
+				    struct fscrypt_str *fstr,
+				    struct dir_context *ctx,
 				    struct list_head *ins_list)
 {
 	struct btrfs_dir_item *di;
@@ -1731,6 +1733,7 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	int name_len;
 	int over = 0;
 	unsigned char d_type;
+	size_t fstr_len = fstr->len;
 
 	if (list_empty(ins_list))
 		return 0;
@@ -1758,8 +1761,27 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 		d_type = fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di->type));
 		btrfs_disk_key_to_cpu(&location, &di->location);
 
-		over = !dir_emit(ctx, name, name_len,
-			       location.objectid, d_type);
+		if (di->type & BTRFS_FT_FSCRYPT_NAME) {
+			int ret;
+			struct fscrypt_str iname = FSTR_INIT(name, name_len);
+			fstr->len = fstr_len;
+			/*
+			 * The hash is only used when the encryption key is not
+			 * available. But if we have delayed insertions, then we
+			 * must have the encryption key available or we wouldn't
+			 * have been able to create entries in the directory.
+			 * So, we don't calculate the hash.
+			 */
+			ret = fscrypt_fname_disk_to_usr(inode, 0, 0, &iname,
+							fstr);
+			if (ret)
+				return ret;
+			over = !dir_emit(ctx, fstr->name, fstr->len,
+					 location.objectid, d_type);
+		} else {
+			over = !dir_emit(ctx, name, name_len, location.objectid,
+					 d_type);
+		}
 
 		if (refcount_dec_and_test(&curr->refs))
 			kfree(curr);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 968461b3c350..aa3c67d572e4 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -142,7 +142,9 @@ void btrfs_readdir_put_delayed_items(struct inode *inode,
 				     struct list_head *del_list);
 int btrfs_should_delete_dir_index(struct list_head *del_list,
 				  u64 index);
-int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
+int btrfs_readdir_delayed_dir_index(struct inode *inode,
+				    struct fscrypt_str *fstr,
+				    struct dir_context *ctx,
 				    struct list_head *ins_list);
 
 /* for init */
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index e1d769e37ac1..7ff158b546cb 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -120,6 +120,9 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 	struct btrfs_disk_key disk_key;
 	u32 data_size;
 
+	if (fname_encrypted(fname))
+		type |= BTRFS_FT_FSCRYPT_NAME;
+
 	key.objectid = btrfs_ino(dir);
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(fname);
@@ -214,7 +217,9 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_key key;
 	struct btrfs_dir_item *di;
+	struct fscrypt_name unencrypted_fname;
 
+again:
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(fname);
@@ -223,6 +228,19 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
+	if (!di && fname_encrypted(fname)) {
+		unencrypted_fname = (struct fscrypt_name){
+			.usr_fname = fname->usr_fname,
+			.disk_name = {
+				.name = (unsigned char *)fname->usr_fname->name,
+				.len = fname->usr_fname->len,
+			},
+		};
+		fname = &unencrypted_fname;
+		btrfs_release_path(path);
+		goto again;
+	}
+
 	return di;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ee8eca5a88f..7898e0873cb4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5888,12 +5888,25 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
 	struct btrfs_key location;
+	struct fscrypt_name fname;
 	u8 di_type = 0;
 	int ret = 0;
 
 	if (dentry->d_name.len > BTRFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	if (BTRFS_I(dir)->flags & BTRFS_INODE_FSCRYPT_CONTEXT) {
+		ret = fscrypt_prepare_lookup(dir, dentry, &fname);
+		if (ret)
+			return ERR_PTR(ret);
+	} else {
+		fname = (struct fscrypt_name) {
+			.usr_fname = &dentry->d_name,
+			.disk_name = FSTR_INIT(dentry->d_name.name,
+					       dentry->d_name.len),
+		};
+	}
+
 	ret = btrfs_inode_by_name(dir, dentry, &location, &di_type);
 	if (ret < 0)
 		return ERR_PTR(ret);
@@ -6035,18 +6048,32 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	struct list_head del_list;
 	int ret;
 	char *name_ptr;
-	int name_len;
+	u32 name_len;
 	int entries = 0;
 	int total_len = 0;
 	bool put = false;
 	struct btrfs_key location;
+	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
+	u32 fstr_len = 0;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_FSCRYPT_CONTEXT) {
+		ret = fscrypt_prepare_readdir(inode);
+		if (ret)
+			return ret;
+		ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fstr);
+		if (ret)
+			return ret;
+		fstr_len = fstr.len;
+	}
+
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		ret = -ENOMEM;
+		goto err_fstr;
+	}
 
 	addr = private->filldir_buf;
 	path->reada = READA_FORWARD;
@@ -6063,7 +6090,9 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	btrfs_for_each_slot(root, &key, &found_key, path, ret) {
 		struct dir_entry *entry;
 		struct extent_buffer *leaf = path->nodes[0];
+		int slot;
 		u8 di_flags;
+		u32 nokey_len;
 
 		if (found_key.objectid != key.objectid)
 			break;
@@ -6075,8 +6104,13 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 			continue;
 		di = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
 		name_len = btrfs_dir_name_len(leaf, di);
-		if ((total_len + sizeof(struct dir_entry) + name_len) >=
-		    PAGE_SIZE) {
+		nokey_len = DIV_ROUND_UP(name_len * 4, 3);
+		/*
+		 * If name is encrypted, and we don't have the key, we could
+		 * need up to 4/3rds the bytes to print it.
+		 */
+		if ((total_len + sizeof(struct dir_entry) + nokey_len)
+		    >= PAGE_SIZE) {
 			btrfs_release_path(path);
 			ret = btrfs_filldir(private->filldir_buf, entries, ctx);
 			if (ret)
@@ -6090,8 +6124,36 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		di_flags = btrfs_dir_flags(leaf, di);
 		entry = addr;
 		name_ptr = (char *)(entry + 1);
-		read_extent_buffer(leaf, name_ptr,
-				   (unsigned long)(di + 1), name_len);
+		if (di_flags & BTRFS_FT_FSCRYPT_NAME) {
+			struct fscrypt_str oname = FSTR_INIT(name_ptr,
+							     nokey_len);
+			u32 hash = 0, minor_hash = 0;
+
+			read_extent_buffer(leaf, fstr.name,
+					   (unsigned long)(di + 1), name_len);
+			fstr.len = name_len;
+			/*
+			 * We're iterating through DIR_INDEX items, so we don't
+			 * have the DIR_ITEM hash handy. Only compute it if
+			 * we'll need it.
+			 */
+			if (!fscrypt_has_encryption_key(inode)) {
+				struct fscrypt_name fname = {
+					.disk_name = oname,
+				};
+				u64 name_hash = btrfs_name_hash(&fname);
+				hash = name_hash;
+				minor_hash = name_hash >> 32;
+			}
+			ret = fscrypt_fname_disk_to_usr(inode, hash, minor_hash,
+							&fstr, &oname);
+			if (ret)
+				goto err;
+			name_len = oname.len;
+		} else {
+			read_extent_buffer(leaf, name_ptr,
+					   (unsigned long)(di + 1), name_len);
+		}
 		put_unaligned(name_len, &entry->name_len);
 		put_unaligned(
 			fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di_flags)),
@@ -6113,7 +6175,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (ret)
 		goto nopos;
 
-	ret = btrfs_readdir_delayed_dir_index(ctx, &ins_list);
+	fstr.len = fstr_len;
+	ret = btrfs_readdir_delayed_dir_index(inode, &fstr, ctx, &ins_list);
 	if (ret)
 		goto nopos;
 
@@ -6144,6 +6207,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (put)
 		btrfs_readdir_put_delayed_items(inode, &ins_list, &del_list);
 	btrfs_free_path(path);
+err_fstr:
+	fscrypt_fname_free_buffer(&fstr);
 	return ret;
 }
 
-- 
2.35.1

