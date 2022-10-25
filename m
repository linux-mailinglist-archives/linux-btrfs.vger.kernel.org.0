Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8160BFE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 02:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJYAnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJYAmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 20:42:25 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C02338E;
        Mon, 24 Oct 2022 16:14:18 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 460C88130B;
        Mon, 24 Oct 2022 19:14:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1666653258; bh=te63mSTsCla3eq1Ptspor/v0boGBMBovWBofAViNlPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+REjfQeIoR8rxYFbmuP03Cj7WFmVCR3lAm1xycjSnjh9+3KTzG3WQTYR23KaWmbb
         G79EODK/lgaeNRv5q7K4sbdShuntMX7rRER2ai9qgo65HaJ0UglFSTaYCP2VM4s/vu
         uR08e5o/tjW7Z37mVbWMuL5bAtdHVC81FS/jZYnOUTtwStWHiaz396HMbNqNGEQVTM
         wa6brMjgpcqwtRmhXmG7LzLV8DayjmGUhMSFFXsA3n8I+qa1Jq4QV/FgFa4ZB8wTgP
         Smbp8DXW7Zw7+vJdy7bU/JvaLqWkw3HV2LRQVHJXnoACbj+o7jLexg8InYloZcxMxs
         yNBXiF7f7MdKw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 21/21] btrfs: encrypt verity items
Date:   Mon, 24 Oct 2022 19:13:31 -0400
Message-Id: <b16e70d566979d3c58cfbaa77e35d14984d89503.1666651724.git.sweettea-kernel@dorminy.me>
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

Verity items are deemed to have sensitive information about the file
contents, so verity items for a encrypted file should be encrypted. This
change uses the fscrypt inplace encryption helper to do so, which should
be similar to what is used for inline extents.

This change has two related holes. Currently, this reuses the fscrypt
extent context from the data in the file for encryption: if there are
not yet any extents for the file when verity is enabled thereon, there
is no fscrypt extent context yet and encryption fails. Additionally,
IVs shouldn't be reused. I think the best solution here is to somehow
pack the 33-byte fscrypt extent contexts into the 16 bytes reserved for
encryption in verity items, and use that in some in-memory-only extent
maps set up to cover the file indexes after the actual data.

But maybe a better solution is to move fscrypt extent contexts into
their own items with offsets past the end of the file, and then there's
no risk of in-memory-only extent maps accidentally making it to disk or
confusing some other part of the system.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/verity.c | 114 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index d02fa354fc2b..d9dff9e31da2 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -8,6 +8,7 @@
 #include <linux/security.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 #include <linux/sched/mm.h>
 #include "messages.h"
@@ -221,14 +222,52 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 	struct btrfs_key key;
 	unsigned long copy_bytes;
 	unsigned long src_offset = 0;
-	void *data;
+	void *data_pos;
 	int ret = 0;
+#ifdef CONFIG_FS_ENCRYPTION
+	struct page *ciphertext_page = NULL;
+	char *ciphertext_buf;
+
+	if (IS_ENCRYPTED(&inode->vfs_inode)) {
+		ciphertext_page = alloc_page(GFP_NOFS);
+		if (!ciphertext_page)
+			return -ENOMEM;
+		ciphertext_buf = kmap_local_page(ciphertext_page);
+	}
+#endif /* CONFIG_FS_ENCRYPTION */
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	while (len > 0) {
+		const char *data = src + src_offset;
+		/*
+		 * Insert 2K at a time mostly to be friendly for smaller leaf
+		 * size filesystems
+		 */
+		copy_bytes = min_t(u64, len, 2048);
+
+#ifdef CONFIG_FS_ENCRYPTION
+		if (ciphertext_page) {
+			struct btrfs_fs_info *fs_info = inode->root->fs_info;
+			u64 lblk_num = offset >> fs_info->sectorsize_bits;
+
+			memset(ciphertext_buf, 0, PAGE_SIZE);
+			memcpy(ciphertext_buf, data, copy_bytes);
+			copy_bytes = ALIGN(copy_bytes,
+					   FSCRYPT_CONTENTS_ALIGNMENT);
+			ret = fscrypt_encrypt_block_inplace(&inode->vfs_inode,
+							    ciphertext_page,
+							    copy_bytes, 0,
+							    lblk_num,
+							    GFP_NOFS);
+			if (ret)
+				break;
+			data = ciphertext_buf;
+		}
+#endif /* CONFIG_FS_ENCRYPTION */
+
 		/* 1 for the new item being inserted */
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
@@ -240,12 +279,6 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		key.type = key_type;
 		key.offset = offset;
 
-		/*
-		 * Insert 2K at a time mostly to be friendly for smaller leaf
-		 * size filesystems
-		 */
-		copy_bytes = min_t(u64, len, 2048);
-
 		ret = btrfs_insert_empty_item(trans, root, path, &key, copy_bytes);
 		if (ret) {
 			btrfs_end_transaction(trans);
@@ -254,18 +287,25 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 
 		leaf = path->nodes[0];
 
-		data = btrfs_item_ptr(leaf, path->slots[0], void);
-		write_extent_buffer(leaf, src + src_offset,
-				    (unsigned long)data, copy_bytes);
+		data_pos = btrfs_item_ptr(leaf, path->slots[0], void);
+		write_extent_buffer(leaf, data,
+				    (unsigned long)data_pos, copy_bytes);
 		offset += copy_bytes;
 		src_offset += copy_bytes;
-		len -= copy_bytes;
+		len -= min_t(u64, copy_bytes, len);
 
 		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
 	}
 
 	btrfs_free_path(path);
+#ifdef CONFIG_FS_ENCRYPTION
+	if (ciphertext_page) {
+		kunmap_local(ciphertext_buf);
+		__free_page(ciphertext_page);
+	}
+#endif /* CONFIG_FS_ENCRYPTION */
+
 	return ret;
 }
 
@@ -307,6 +347,17 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 	void *data;
 	char *kaddr = dest;
 	int ret;
+#ifdef CONFIG_FS_ENCRYPTION
+	char *ciphertext_buf;
+	struct page *ciphertext_page = NULL;
+
+	if (dest && IS_ENCRYPTED(&inode->vfs_inode)) {
+		ciphertext_page = alloc_page(GFP_NOFS);
+		if (!ciphertext_page)
+			return -ENOMEM;
+		ciphertext_buf = kmap_local_page(ciphertext_page);
+	}
+#endif /* CONFIG_FS_ENCRYPTION */
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -368,14 +419,41 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		/* Offset from the start of item for copying */
 		copy_offset = offset - key.offset;
 
+		data = btrfs_item_ptr(leaf, path->slots[0], void);
 		if (dest) {
+#ifdef CONFIG_FS_ENCRYPTION
+			if (ciphertext_page) {
+				struct btrfs_fs_info *fs_info =
+					inode->root->fs_info;
+				u64 lblk_num = offset >> fs_info->sectorsize_bits;
+
+				read_extent_buffer(leaf, ciphertext_buf,
+						   (unsigned long)data + copy_offset,
+						   item_end - offset);
+				ret = fscrypt_decrypt_block_inplace(&inode->vfs_inode,
+								    ciphertext_page,
+								    item_end - offset, 0,
+								    lblk_num);
+				if (ret)
+					break;
+			}
+#endif /* CONFIG_FS_ENCRYPTION */
+
 			if (dest_page)
 				kaddr = kmap_local_page(dest_page);
 
-			data = btrfs_item_ptr(leaf, path->slots[0], void);
-			read_extent_buffer(leaf, kaddr + dest_offset,
-					   (unsigned long)data + copy_offset,
-					   copy_bytes);
+			if (IS_ENABLED(CONFIG_FS_ENCRYPTION) &&
+			    IS_ENCRYPTED(&inode->vfs_inode)) {
+#ifdef CONFIG_FS_ENCRYPTION
+				memcpy(kaddr + dest_offset,
+				       ciphertext_buf + copy_offset,
+				       copy_bytes);
+#endif /* CONFIG_FS_ENCRYPTION */
+			} else {
+				read_extent_buffer(leaf, kaddr + dest_offset,
+						   (unsigned long)data + copy_offset,
+						   copy_bytes);
+			}
 
 			if (dest_page)
 				kunmap_local(kaddr);
@@ -402,6 +480,12 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		}
 	}
 out:
+#ifdef CONFIG_FS_ENCRYPTION
+	if (ciphertext_page) {
+		kunmap_local(ciphertext_buf);
+		__free_page(ciphertext_page);
+	}
+#endif /* CONFIG_FS_ENCRYPTION */
 	btrfs_free_path(path);
 	if (!ret)
 		ret = copied;
-- 
2.35.1

