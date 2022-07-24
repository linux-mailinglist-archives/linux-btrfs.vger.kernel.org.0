Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B257F265
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiGXAze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiGXAzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:55:08 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A93B1A3B5;
        Sat, 23 Jul 2022 17:54:56 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0E378807A4;
        Sat, 23 Jul 2022 20:54:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624096; bh=irSd7yOHrw/HMKBM4LnThweijHbsccg1b+8ogE+gARE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaV6waLdyq1FKtL7B15kUzqk1tedgdM8R/DSzl8/A2WB6bBRvaG4BuXH7zT1c4bcD
         wP+MKMQlIckYsVV/unXFr7zPnFaJxEJ42ouUWQ5a9zlKj65DGlq/zuGE+k96yW2X84
         GYebD5/NckXhqKUqzeZoZUSENbFAJhV18awmPXSWWoJ/tsgFNKNsmj4D0LW+tg7CT2
         bbZBUzQhEIf8Gqnmq859m8EeUqMBQadfNXnd85gAeK0uN8y5OMbbGMw/m+oLvQeqec
         c8/TIbjv2e46W9YVTMk+y0BDC/166AMCNRCqUDO53c2/L/mF+1jE97+hLy8jEE5ONM
         UQ6NrWxhcHoKw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 14/16] btrfs: adapt directory read and lookup to potentially encrypted filenames
Date:   Sat, 23 Jul 2022 20:53:59 -0400
Message-Id: <1815605d9c69c3ea33b1bcfb7ae9830cc6ca8258.1658623319.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1658623319.git.sweettea-kernel@dorminy.me>
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/delayed-inode.c | 32 +++++++++++++---
 fs/btrfs/delayed-inode.h |  4 +-
 fs/btrfs/dir-item.c      | 23 ++++++++++++
 fs/btrfs/inode.c         | 80 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 125 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 84ae3cf9a9ee..a966dc3c5bf2 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1493,9 +1493,9 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 
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
@@ -1728,7 +1728,9 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
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
@@ -1738,6 +1740,7 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	int name_len;
 	int over = 0;
 	unsigned char d_type;
+	size_t fstr_len = fstr->len;
 
 	if (list_empty(ins_list))
 		return 0;
@@ -1765,8 +1768,27 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
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
index 5af5c7af333f..2dfc0d29f6c6 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -120,6 +120,9 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 	struct btrfs_disk_key disk_key;
 	u32 data_size;
 
+	if (fname->crypto_buf.name)
+		type |= BTRFS_FT_FSCRYPT_NAME;
+
 	key.objectid = btrfs_ino(dir);
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(fname);
@@ -385,6 +388,18 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 	u32 cur = 0;
 	u32 this_len;
 	struct extent_buffer *leaf;
+	bool encrypted = (fname->crypto_buf.name != NULL);
+	struct fscrypt_name unencrypted_fname;
+
+	if (encrypted) {
+		unencrypted_fname = (struct fscrypt_name){
+			.usr_fname = fname->usr_fname,
+			.disk_name = {
+				.name = (unsigned char *)fname->usr_fname->name,
+				.len = fname->usr_fname->len,
+			},
+		};
+	}
 
 	leaf = path->nodes[0];
 	dir_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
@@ -402,6 +417,14 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 			return dir_item;
 		}
 
+		if (encrypted && 
+		    btrfs_dir_name_len(leaf, dir_item) == fname_len(&unencrypted_fname) &&
+		    btrfs_fscrypt_match_name(&unencrypted_fname, leaf,
+					     (unsigned long)(dir_item + 1),
+					     dir_name_len)) {
+			return dir_item;
+		}
+
 		cur += this_len;
 		dir_item = (struct btrfs_dir_item *)((char *)dir_item +
 						     this_len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 565a2b66d766..068e9701a2f4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5883,12 +5883,25 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
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
+			.disk_name = FSTR_INIT((char *) dentry->d_name.name,
+					       dentry->d_name.len),
+		};
+	}
+
 	ret = btrfs_inode_by_name(dir, dentry, &location, &di_type);
 	if (ret < 0)
 		return ERR_PTR(ret);
@@ -6030,18 +6043,32 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
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
@@ -6059,6 +6086,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		struct dir_entry *entry;
 		struct extent_buffer *leaf = path->nodes[0];
 		u8 di_flags;
+		u32 nokey_len;
 
 		if (found_key.objectid != key.objectid)
 			break;
@@ -6070,8 +6098,13 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
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
@@ -6085,8 +6118,36 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
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
@@ -6108,7 +6169,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (ret)
 		goto nopos;
 
-	ret = btrfs_readdir_delayed_dir_index(ctx, &ins_list);
+	fstr.len = fstr_len;
+	ret = btrfs_readdir_delayed_dir_index(inode, &fstr, ctx, &ins_list);
 	if (ret)
 		goto nopos;
 
@@ -6139,6 +6201,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (put)
 		btrfs_readdir_put_delayed_items(inode, &ins_list, &del_list);
 	btrfs_free_path(path);
+err_fstr:
+	fscrypt_fname_free_buffer(&fstr);
 	return ret;
 }
 
-- 
2.35.1

