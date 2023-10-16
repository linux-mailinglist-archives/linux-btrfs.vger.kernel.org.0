Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7D7CB24E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjJPSWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjJPSWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE1A2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77433e7a876so343788385a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480527; x=1698085327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEcF3KUaH6rXtlaDWGi1U0xtaHS3vB33/I7kz1jHOKA=;
        b=1khyqHrjZQS+tQ8oXGYQhOIoTkIJupZ5kdAm9P+0FR4fCoRD1W35noSGJ4UEnDyJvs
         UxxDYij+CJXBgYe97BgGwPKlxVfM+qQiDNNPZjB81KNlizGZdLShP1Vmih34l+82TQyB
         09Kd4Rs0ibJ413HOwNJzTZz9XKWiRvwFdPhw7bV9KMWzFLAwg057eW4tfBcJXd5H5saI
         1hqNeZb2/OcGPUseFYtJn7OdQwTfpPC3ndokWQwFBVZdvResBIV2ROHse4jppE5LVPd7
         z/JUdwQnLlUJytZGIcAb9ugcpSvtRa2Bx5rkY2ImUEcuaACZqzemn/uwkpoTYz20ebUQ
         sNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480527; x=1698085327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEcF3KUaH6rXtlaDWGi1U0xtaHS3vB33/I7kz1jHOKA=;
        b=L3ydXTzGqOOm+Kqad7rkbuYBNpHwO/IBXWBR2/PzwK67IAbmr6w+k46MSKo1Z7HQ3C
         fN4Krz8OkxONW8RGfz68xxyX5YxDJvxc1djiMCmcZvFf3pQL5iOVQkUbuYqr6oudnL4p
         Ky6i8ECWzoRhboFacMPs/dJqGLWKKNy1cQIetZB2psDGwvwL2OEYyWGTXKlElsF6bNaa
         o43lliqbY5PUEsnYkR/85u5vGK5HbJu0PWECv72C/NbyXxhPJ7dg6uKcknFdHFk4fHBY
         5E4nF2dA40t7zHZZHSTzZtOBxx82EykbaUZWIko+nf/VvPaLoxhmOyNHURwrQAOJ0T+g
         iv8A==
X-Gm-Message-State: AOJu0YyHdAmG4AQTBPpKSpxb1PaC9ueUTkm8SlkIh1WlEtL0VAkZ9nra
        3yb2hkM31sEm9dbc7dOPgu87zrNp9cQ6aKFQ5P7eig==
X-Google-Smtp-Source: AGHT+IFS1l4HeVrTaVPUq4wL3ou0fgpcWEvbnfvZfF+T/hnlu7IcysqYVOm1E6qOWLaLXRQOO0Njgg==
X-Received: by 2002:a05:620a:e96:b0:774:1ba2:5135 with SMTP id w22-20020a05620a0e9600b007741ba25135mr33864689qkm.68.1697480527358;
        Mon, 16 Oct 2023 11:22:07 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9f212000000b0076cdc3b5beasm3188937qkg.86.2023.10.16.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 09/34] btrfs: start using fscrypt hooks
Date:   Mon, 16 Oct 2023 14:21:16 -0400
Message-ID: <5e137a4cc9660ba697b610cb4f5564888c7f8b71.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

In order to appropriately encrypt, create, open, rename, and various
symlink operations must call fscrypt hooks. These determine whether the
inode should be encrypted and do other preparatory actions. The
superblock must have fscrypt operations registered, so implement the
minimal set also, and introduce the new fscrypt.[ch] files to hold the
fscrypt-specific functionality.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile      |   1 +
 fs/btrfs/btrfs_inode.h |   1 +
 fs/btrfs/file.c        |   3 ++
 fs/btrfs/fscrypt.c     |   7 +++
 fs/btrfs/fscrypt.h     |  10 ++++
 fs/btrfs/inode.c       | 110 ++++++++++++++++++++++++++++++++++-------
 fs/btrfs/super.c       |   2 +
 7 files changed, 116 insertions(+), 18 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 525af975f61c..6e51d054c17a 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -39,6 +39,7 @@ btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
 btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
 btrfs-$(CONFIG_FS_VERITY) += verity.o
+btrfs-$(CONFIG_FS_ENCRYPTION) += fscrypt.o
 
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bebb5921b922..052072373078 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -455,6 +455,7 @@ struct btrfs_new_inode_args {
 	struct posix_acl *default_acl;
 	struct posix_acl *acl;
 	struct fscrypt_name fname;
+	bool encrypt;
 };
 
 int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 92419cb8508a..26905b77c7e8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3709,6 +3709,9 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 		        FMODE_CAN_ODIRECT;
+	ret = fscrypt_file_open(inode, filp);
+	if (ret)
+		return ret;
 
 	ret = fsverity_file_open(inode, filp);
 	if (ret)
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
new file mode 100644
index 000000000000..48ab99dfe48d
--- /dev/null
+++ b/fs/btrfs/fscrypt.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "ctree.h"
+#include "fscrypt.h"
+
+const struct fscrypt_operations btrfs_fscrypt_ops = {
+};
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
new file mode 100644
index 000000000000..7f4e6888bd43
--- /dev/null
+++ b/fs/btrfs/fscrypt.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FSCRYPT_H
+#define BTRFS_FSCRYPT_H
+
+#include <linux/fscrypt.h>
+
+extern const struct fscrypt_operations btrfs_fscrypt_ops;
+
+#endif /* BTRFS_FSCRYPT_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4806ff34224a..b92da4a4ed21 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5053,6 +5053,10 @@ static int btrfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (err)
 		return err;
 
+	err = fscrypt_prepare_setattr(dentry, attr);
+	if (err)
+		return err;
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		err = btrfs_setsize(inode, attr);
 		if (err)
@@ -5207,11 +5211,8 @@ void btrfs_evict_inode(struct inode *inode)
 
 	trace_btrfs_inode_evict(inode);
 
-	if (!root) {
-		fsverity_cleanup_inode(inode);
-		clear_inode(inode);
-		return;
-	}
+	if (!root)
+		goto cleanup;
 
 	evict_inode_truncate_pages(inode);
 
@@ -5311,6 +5312,9 @@ void btrfs_evict_inode(struct inode *inode)
 	 * to retry these periodically in the future.
 	 */
 	btrfs_remove_delayed_node(BTRFS_I(inode));
+
+cleanup:
+	fscrypt_put_encryption_info(inode);
 	fsverity_cleanup_inode(inode);
 	clear_inode(inode);
 }
@@ -6096,6 +6100,12 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 		return ret;
 	}
 
+	ret = fscrypt_prepare_new_inode(dir, inode, &args->encrypt);
+	if (ret) {
+		fscrypt_free_filename(&args->fname);
+		return ret;
+	}
+
 	/* 1 to add inode item */
 	*trans_num_items = 1;
 	/* 1 to add compression property */
@@ -6569,9 +6579,13 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
 		return -EMLINK;
 
+	err = fscrypt_prepare_link(old_dentry, dir, dentry);
+	if (err)
+		return err;
+
 	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
 	if (err)
-		goto fail;
+		return err;
 
 	err = btrfs_set_inode_index(BTRFS_I(dir), &index);
 	if (err)
@@ -8519,6 +8533,7 @@ void btrfs_test_destroy_inode(struct inode *inode)
 
 void btrfs_free_inode(struct inode *inode)
 {
+	fscrypt_free_inode(inode);
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 
@@ -8589,8 +8604,7 @@ int btrfs_drop_inode(struct inode *inode)
 	/* the snap/subvol tree is on deleting */
 	if (btrfs_root_refs(&root->root_item) == 0)
 		return 1;
-	else
-		return generic_drop_inode(inode);
+	return generic_drop_inode(inode) || fscrypt_drop_inode(inode);
 }
 
 static void init_once(void *foo)
@@ -9170,6 +9184,11 @@ static int btrfs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
+	ret = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
+				     flags);
+	if (ret)
+		return ret;
+
 	if (flags & RENAME_EXCHANGE)
 		ret = btrfs_rename_exchange(old_dir, old_dentry, new_dir,
 					    new_dentry);
@@ -9384,15 +9403,31 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	};
 	unsigned int trans_num_items;
 	int err;
-	int name_len;
 	int datasize;
 	unsigned long ptr;
 	struct btrfs_file_extent_item *ei;
 	struct extent_buffer *leaf;
+	struct fscrypt_str disk_link;
+	size_t max_len;
+	u32 name_len = strlen(symname);
 
-	name_len = strlen(symname);
-	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
-		return -ENAMETOOLONG;
+	/*
+	 * BTRFS_MAX_INLINE_DATA_SIZE() isn't actually telling the truth, we
+	 * actually limit inline data extents to
+	 * min(BTRFS_MAX_INLINE_DATA_SIZE(), sectorsize), so adjust max_len
+	 * given this wonderful bit of inconsistency.
+	 */
+	max_len = min_t(size_t, BTRFS_MAX_INLINE_DATA_SIZE(fs_info),
+			fs_info->sectorsize);
+
+	/*
+	 * fscrypt sets disk_link.len to be len + 1, including a NUL terminator, but we
+	 * don't store that '\0' character.
+	 */
+	err = fscrypt_prepare_symlink(dir, symname, name_len, max_len + 1,
+				      &disk_link);
+	if (err)
+		return err;
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
@@ -9401,8 +9436,8 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	inode->i_op = &btrfs_symlink_inode_operations;
 	inode_nohighmem(inode);
 	inode->i_mapping->a_ops = &btrfs_aops;
-	btrfs_i_size_write(BTRFS_I(inode), name_len);
-	inode_set_bytes(inode, name_len);
+	btrfs_i_size_write(BTRFS_I(inode), disk_link.len - 1);
+	inode_set_bytes(inode, disk_link.len - 1);
 
 	new_inode_args.inode = inode;
 	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
@@ -9429,10 +9464,23 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		inode = NULL;
 		goto out;
 	}
+
+	if (IS_ENCRYPTED(inode)) {
+		err = fscrypt_encrypt_symlink(inode, symname, name_len,
+					      &disk_link);
+		if (err) {
+			btrfs_abort_transaction(trans, err);
+			btrfs_free_path(path);
+			discard_new_inode(inode);
+			inode = NULL;
+			goto out;
+		}
+	}
+
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 	key.offset = 0;
 	key.type = BTRFS_EXTENT_DATA_KEY;
-	datasize = btrfs_file_extent_calc_inline_size(name_len);
+	datasize = btrfs_file_extent_calc_inline_size(disk_link.len - 1);
 	err = btrfs_insert_empty_item(trans, root, path, &key,
 				      datasize);
 	if (err) {
@@ -9451,10 +9499,10 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	btrfs_set_file_extent_encryption(leaf, ei, 0);
 	btrfs_set_file_extent_compression(leaf, ei, 0);
 	btrfs_set_file_extent_other_encoding(leaf, ei, 0);
-	btrfs_set_file_extent_ram_bytes(leaf, ei, name_len);
+	btrfs_set_file_extent_ram_bytes(leaf, ei, disk_link.len - 1);
 
 	ptr = btrfs_file_extent_inline_start(ei);
-	write_extent_buffer(leaf, symname, ptr, name_len);
+	write_extent_buffer(leaf, disk_link.name, ptr, disk_link.len - 1);
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_free_path(path);
 
@@ -9471,6 +9519,29 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
+static const char *btrfs_get_link(struct dentry *dentry, struct inode *inode,
+				  struct delayed_call *done)
+{
+	struct page *cpage;
+	const char *paddr;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	if (!IS_ENCRYPTED(inode))
+		return page_get_link(dentry, inode, done);
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	cpage = read_mapping_page(inode->i_mapping, 0, NULL);
+	if (IS_ERR(cpage))
+		return ERR_CAST(cpage);
+
+	paddr = fscrypt_get_symlink(inode, page_address(cpage),
+				    BTRFS_MAX_INLINE_DATA_SIZE(fs_info), done);
+	put_page(cpage);
+	return paddr;
+}
+
 static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       struct btrfs_trans_handle *trans_in,
 				       struct btrfs_inode *inode,
@@ -10949,7 +11020,7 @@ static const struct inode_operations btrfs_special_inode_operations = {
 	.update_time	= btrfs_update_time,
 };
 static const struct inode_operations btrfs_symlink_inode_operations = {
-	.get_link	= page_get_link,
+	.get_link	= btrfs_get_link,
 	.getattr	= btrfs_getattr,
 	.setattr	= btrfs_setattr,
 	.permission	= btrfs_permission,
@@ -10959,4 +11030,7 @@ static const struct inode_operations btrfs_symlink_inode_operations = {
 
 const struct dentry_operations btrfs_dentry_operations = {
 	.d_delete	= btrfs_dentry_delete,
+#ifdef CONFIG_FS_ENCRYPTION
+	.d_revalidate	= fscrypt_d_revalidate,
+#endif
 };
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c3f507f3d862..9d67fdd47d1d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -49,6 +49,7 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
+#include "fscrypt.h"
 #include "qgroup.h"
 #include "raid56.h"
 #include "fs.h"
@@ -1099,6 +1100,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_vop = &btrfs_verityops;
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
+	fscrypt_set_ops(sb, &btrfs_fscrypt_ops);
 	sb->s_time_gran = 1;
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
-- 
2.41.0

