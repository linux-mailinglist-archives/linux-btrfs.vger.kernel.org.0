Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280357F252
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiGXAzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbiGXAyw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:52 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7C415A31;
        Sat, 23 Jul 2022 17:54:48 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id DB61D80BB8;
        Sat, 23 Jul 2022 20:54:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624088; bh=kUagk1vzMMoikUsFje5DO09XQkW8tRiKFwRl/Sed8Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxYh70b8+jNo9Bb4Zit6w4TjtT6GW11u4c8lTDmp0zvUrfTHltcd2olQ7qNDufIkd
         43sxDj0XGaUe7lEZ91Cni3JBnJwzAa04Mz83uBhZKEJPw78Pc5Oz63OnKckvqnl/q2
         MYNfpfOrUANhzkOT6sTDGNHv1nsHgukzv9Gkw+pVfIYQ/hdGWYM6ai2EZXN/UrYXzD
         cOwWC6l3mgBO0oGXFZ8mmkINzKwdhWdiqjgoaY4/iM+TYCuMnFLqB4HjrfwdXqm1Pd
         vcq94kgjngvlvWbJyZeUmGL/yNSnrC6ioIjIayb8YdWkFJFpcX8jBQZwpL2SGT0+Uu
         v7VZAl1L1BKVg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 11/16] btrfs: store an IV per encrypted normal file extent
Date:   Sat, 23 Jul 2022 20:53:56 -0400
Message-Id: <e2b20f24efffb067b03634be28356f2164c7874b.1658623319.git.sweettea-kernel@dorminy.me>
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

In order to encrypt data, each file extent must have its own persistent
random IV, which is then provided to fscrypt upon request. This IV is
only needed for encrypted extents and is of variable size on disk, so
file extents must additionally keep track of their actual length.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h                | 29 ++++++++++++++
 fs/btrfs/extent_map.h           |  8 ++++
 fs/btrfs/file-item.c            | 11 ++++++
 fs/btrfs/file.c                 |  4 +-
 fs/btrfs/fscrypt.h              | 23 +++++++++++
 fs/btrfs/inode.c                | 70 +++++++++++++++++++++++++--------
 fs/btrfs/ordered-data.c         | 12 +++++-
 fs/btrfs/ordered-data.h         |  3 +-
 fs/btrfs/reflink.c              |  1 +
 fs/btrfs/tree-checker.c         | 36 +++++++++++++----
 fs/btrfs/tree-log.c             |  9 +++++
 include/uapi/linux/btrfs_tree.h |  9 +++++
 12 files changed, 186 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cb7ded64fee6..bd8855da2e54 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -37,6 +37,7 @@
 #include "async-thread.h"
 #include "block-rsv.h"
 #include "locking.h"
+#include "fscrypt.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -1356,6 +1357,7 @@ struct btrfs_replace_extent_info {
 	u64 file_offset;
 	/* Pointer to a file extent item of type regular or prealloc. */
 	char *extent_buf;
+	u32 extent_buf_size;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
@@ -2591,6 +2593,15 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 			 struct btrfs_file_extent_item, disk_num_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
 			 struct btrfs_file_extent_item, compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_encryption,
+			 struct btrfs_file_extent_item, encryption, 8);
+
+static inline u8 btrfs_stack_file_extent_encryption_ivsize(struct btrfs_file_extent_item *e)
+{
+	u8 ivsize;
+	btrfs_unpack_encryption(e->encryption, NULL, &ivsize);
+	return ivsize;
+}
 
 static inline unsigned long
 btrfs_file_extent_inline_start(const struct btrfs_file_extent_item *e)
@@ -2623,6 +2634,24 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
 
+static inline u8
+btrfs_file_extent_encryption_ivsize(const struct extent_buffer *eb,
+				    struct btrfs_file_extent_item *e)
+{
+	u8 ivsize;
+	btrfs_unpack_encryption(btrfs_file_extent_encryption(eb, e),
+				NULL, &ivsize);
+	return ivsize;
+}
+
+static inline u8
+btrfs_file_extent_ivsize_from_item(const struct extent_buffer *leaf,
+				   const struct btrfs_path *path)
+{
+	return (btrfs_item_size(leaf, path->slots[0]) -
+		sizeof(struct btrfs_file_extent_item));
+}
+
 /*
  * this returns the number of bytes used by the item on disk, minus the
  * size of any extent headers.  If a file is compressed on disk, this is
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index d2fa32ffe304..cc077d15062b 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -5,6 +5,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include "fscrypt.h"
 
 #define EXTENT_MAP_LAST_BYTE ((u64)-4)
 #define EXTENT_MAP_HOLE ((u64)-3)
@@ -27,6 +28,8 @@ enum {
 	EXTENT_FLAG_FS_MAPPING,
 	/* This em is merged from two or more physically adjacent ems */
 	EXTENT_FLAG_MERGED,
+	/* This em has a iv */
+	EXTENT_FLAG_ENCRYPTED,
 };
 
 struct extent_map {
@@ -50,6 +53,11 @@ struct extent_map {
 	 */
 	u64 generation;
 	unsigned long flags;
+	/*
+	 * TODO: could either make FSCRYPT_MAX_IV_SIZE public or allocate this
+	 * separately, of size 16 if applicable to the specific policy.
+	 */
+	u8 iv[FSCRYPT_MAX_IV_SIZE];
 	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
 	struct map_lookup *map_lookup;
 	refcount_t refs;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 29999686d234..066d59707408 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1216,6 +1216,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	em->generation = btrfs_file_extent_generation(leaf, fi);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
+		u8 ivsize;
 		em->start = extent_start;
 		em->len = extent_end - extent_start;
 		em->orig_start = extent_start -
@@ -1231,6 +1232,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			em->compress_type = compress_type;
 			em->block_start = bytenr;
 			em->block_len = em->orig_block_len;
+		} else if (btrfs_file_extent_encryption(leaf, fi)) {
+			set_bit(EXTENT_FLAG_ENCRYPTED, &em->flags);
+			em->block_start = bytenr;
+			em->block_len = em->orig_block_len;
 		} else {
 			bytenr += btrfs_file_extent_offset(leaf, fi);
 			em->block_start = bytenr;
@@ -1238,6 +1243,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		}
+
+		ivsize = btrfs_file_extent_ivsize_from_item(leaf, path);
+		ASSERT(ivsize == btrfs_file_extent_encryption_ivsize(leaf, fi));
+
+		read_extent_buffer(leaf, em->iv, (unsigned long)fi->iv,
+				   ivsize);
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
 		em->start = extent_start;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 876fc1c647ef..bb0373194b94 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2658,14 +2658,14 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = extent_info->file_offset;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
-				      sizeof(struct btrfs_file_extent_item));
+				      extent_info->extent_buf_size);
 	if (ret)
 		return ret;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	write_extent_buffer(leaf, extent_info->extent_buf,
 			    btrfs_item_ptr_offset(leaf, slot),
-			    sizeof(struct btrfs_file_extent_item));
+			    extent_info->extent_buf_size);
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	ASSERT(btrfs_file_extent_type(leaf, extent) != BTRFS_FILE_EXTENT_INLINE);
 	btrfs_set_file_extent_offset(leaf, extent, extent_info->data_offset);
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 07884206c8a1..52646bd84e43 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -5,6 +5,9 @@
 
 #include <linux/fscrypt.h>
 
+#define BTRFS_ENCRYPTION_POLICY_MASK 0x0f
+#define BTRFS_ENCRYPTION_IVSIZE_MASK 0xf0
+
 #ifdef CONFIG_FS_ENCRYPTION
 bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
 			      struct extent_buffer *leaf,
@@ -22,5 +25,25 @@ static bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
 }
 #endif
 
+static inline void btrfs_unpack_encryption(u8 encryption,
+					   u8 *policy,
+					   u8 *ivsize)
+{
+	if (policy)
+		*policy = encryption & BTRFS_ENCRYPTION_POLICY_MASK;
+	if (ivsize) {
+		u8 transformed_ivsize =
+			(encryption & BTRFS_ENCRYPTION_IVSIZE_MASK) >> 4;
+		*ivsize = (transformed_ivsize ?
+			   (1 << (transformed_ivsize - 1)) : 0);
+	}
+}
+
+static inline u8 btrfs_pack_encryption(u8 policy, u8 ivsize)
+{
+	u8 transformed_ivsize = ivsize ? ilog2(ivsize) + 1 : 0;
+	return policy | (transformed_ivsize << 4);
+}
+
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
 #endif /* BTRFS_FSCRYPT_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f1382de515c..565a2b66d766 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -32,6 +32,7 @@
 #include <linux/migrate.h>
 #include <linux/sched/mm.h>
 #include <linux/iomap.h>
+#include <linux/random.h>
 #include <asm/unaligned.h>
 #include <linux/fsverity.h>
 #include "misc.h"
@@ -1024,7 +1025,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				       ins.offset,		/* disk_num_bytes */
 				       0,			/* offset */
 				       1 << BTRFS_ORDERED_COMPRESSED,
-				       async_extent->compress_type);
+				       async_extent->compress_type, NULL);
 	if (ret) {
 		btrfs_drop_extent_cache(inode, start, end, 0);
 		goto out_free_reserve;
@@ -1302,7 +1303,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
 					       ins.objectid, cur_alloc_size, 0,
 					       1 << BTRFS_ORDERED_REGULAR,
-					       BTRFS_COMPRESS_NONE);
+					       BTRFS_COMPRESS_NONE, NULL);
 		if (ret)
 			goto out_drop_extent_cache;
 
@@ -2100,7 +2101,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					nocow_args.disk_bytenr,
 					nocow_args.num_bytes, 0,
 					1 << BTRFS_ORDERED_PREALLOC,
-					BTRFS_COMPRESS_NONE);
+					BTRFS_COMPRESS_NONE, NULL);
 			if (ret) {
 				btrfs_drop_extent_cache(inode, cur_offset,
 							nocow_end, 0);
@@ -2114,7 +2115,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 						       nocow_args.num_bytes,
 						       0,
 						       1 << BTRFS_ORDERED_NOCOW,
-						       BTRFS_COMPRESS_NONE);
+						       BTRFS_COMPRESS_NONE,
+						       NULL);
 			if (ret)
 				goto error;
 		}
@@ -3050,6 +3052,7 @@ int btrfs_writepage_cow_fixup(struct page *page)
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *inode, u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
+				       const u8 *iv,
 				       const bool update_inode_bytes,
 				       u64 qgroup_reserved)
 {
@@ -3065,6 +3068,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	int ret;
+	int ivsize = fscrypt_mode_ivsize(&inode->vfs_inode);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3083,7 +3087,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	drop_args.start = file_pos;
 	drop_args.end = file_pos + num_bytes;
 	drop_args.replace_extent = true;
-	drop_args.extent_item_size = sizeof(*stack_fi);
+	drop_args.extent_item_size = sizeof(*stack_fi) + ivsize;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
@@ -3094,7 +3098,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
-					      sizeof(*stack_fi));
+					      sizeof(*stack_fi) + ivsize);
 		if (ret)
 			goto out;
 	}
@@ -3103,6 +3107,11 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, stack_fi,
 			btrfs_item_ptr_offset(leaf, path->slots[0]),
 			sizeof(struct btrfs_file_extent_item));
+	if (ivsize)
+		write_extent_buffer(leaf, iv,
+				btrfs_item_ptr_offset(leaf, path->slots[0]) +
+				sizeof(struct btrfs_file_extent_item),
+				ivsize);
 
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
@@ -3179,7 +3188,12 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	/* Encryption and other encoding is reserved and all 0 */
+	if (IS_ENCRYPTED(oe->inode)) {
+		u8 encryption = btrfs_pack_encryption(BTRFS_ENCRYPTION_FSCRYPT,
+					fscrypt_mode_ivsize(oe->inode));
+		btrfs_set_stack_file_extent_encryption(&stack_fi, encryption);
+	}
+	/* Other encoding is reserved and always 0 */
 
 	/*
 	 * For delalloc, when completing an ordered extent we update the inode's
@@ -3193,6 +3207,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
 					   oe->file_offset, &stack_fi,
+					   oe->iv,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
 
@@ -7095,8 +7110,25 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	btrfs_extent_item_to_extent_map(inode, path, item, !page, em);
 
-	if (extent_type == BTRFS_FILE_EXTENT_REG ||
-	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
+	if (extent_type == BTRFS_FILE_EXTENT_REG) {
+		u8 ivsize = btrfs_file_extent_ivsize_from_item(leaf, path);
+		u8 encryption = btrfs_file_extent_encryption(leaf, item);
+		u8 policy, item_ivsize;
+		btrfs_unpack_encryption(encryption, &policy, &item_ivsize);
+
+		if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
+			u8 inode_ivsize = fscrypt_mode_ivsize(&inode->vfs_inode);
+
+			if (ivsize != inode_ivsize || ivsize != item_ivsize) {
+				btrfs_crit(fs_info,
+					"invalid encryption IV size for inode %llu: itemsize %d item %d inode %d",
+					btrfs_ino(inode), ivsize, item_ivsize, inode_ivsize);
+				ret = -EUCLEAN;
+				goto out;
+			}
+		}
+		goto insert;
+	} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		goto insert;
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		unsigned long ptr;
@@ -7325,7 +7357,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 				       block_len, 0,
 				       (1 << type) |
 				       (1 << BTRFS_ORDERED_DIRECT),
-				       BTRFS_COMPRESS_NONE);
+				       BTRFS_COMPRESS_NONE, NULL);
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
@@ -9954,6 +9986,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct extent_buffer *leaf;
 	struct fscrypt_str disk_link;
 	u32 name_len = strlen(symname);
+	u8 encryption;
 
 	/*
 	 * fscrypt sets disk_link.len to be len + 1, including a NULL terminator, but we
@@ -10019,7 +10052,9 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	btrfs_set_file_extent_generation(leaf, ei, trans->transid);
 	btrfs_set_file_extent_type(leaf, ei,
 				   BTRFS_FILE_EXTENT_INLINE);
-	btrfs_set_file_extent_encryption(leaf, ei, 0);
+	encryption = btrfs_pack_encryption(IS_ENCRYPTED(inode) ?
+					   BTRFS_ENCRYPTION_FSCRYPT : 0, 0);
+	btrfs_set_file_extent_encryption(leaf, ei, encryption);
 	btrfs_set_file_extent_compression(leaf, ei, 0);
 	btrfs_set_file_extent_other_encoding(leaf, ei, 0);
 	/* ram size is the unencrypted size */
@@ -10100,16 +10135,18 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
-	/* Encryption and other encoding is reserved and all 0 */
+	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       BTRFS_ENCRYPTION_NONE);
+	/* Other encoding is reserved and always 0 */
 
 	qgroup_released = btrfs_qgroup_release_data(inode, file_offset, len);
 	if (qgroup_released < 0)
 		return ERR_PTR(qgroup_released);
 
 	if (trans) {
-		ret = insert_reserved_file_extent(trans, inode,
-						  file_offset, &stack_fi,
-						  true, qgroup_released);
+		ret = insert_reserved_file_extent(trans, inode, file_offset,
+						  &stack_fi, NULL, true,
+						  qgroup_released);
 		if (ret)
 			goto free_qgroup;
 		return trans;
@@ -10121,6 +10158,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.data_len = len;
 	extent_info.file_offset = file_offset;
 	extent_info.extent_buf = (char *)&stack_fi;
+	extent_info.extent_buf_size = sizeof(stack_fi);
 	extent_info.is_new_extent = true;
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
@@ -11071,7 +11109,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 				       encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
-				       compression);
+				       compression, NULL);
 	if (ret) {
 		btrfs_drop_extent_cache(inode, start, end, 0);
 		goto out_free_reserved;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1952ac85222c..8e7d4a3cc661 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -5,6 +5,7 @@
 
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/random.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
 #include "misc.h"
@@ -164,13 +165,14 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
 			     u64 disk_num_bytes, u64 offset, unsigned flags,
-			     int compress_type)
+			     int compress_type, u8 *iv)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry;
+	const u8 ivsize = fscrypt_mode_ivsize(&inode->vfs_inode);
 	int ret;
 
 	if (flags &
@@ -199,6 +201,12 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	entry->disk_bytenr = disk_bytenr;
 	entry->disk_num_bytes = disk_num_bytes;
 	entry->offset = offset;
+	if (ivsize) {
+		if (iv == NULL)
+			get_random_bytes(entry->iv, ivsize);
+		else
+			memcpy(entry->iv, iv, ivsize);
+	}
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
@@ -1059,7 +1067,7 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 	WARN_ON_ONCE(flags & (1 << BTRFS_ORDERED_COMPRESSED));
 	return btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, len, len,
 					disk_bytenr, len, 0, flags,
-					ordered->compress_type);
+					ordered->compress_type, ordered->iv);
 }
 
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 87792f85e2c4..e738ecb70a89 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -99,6 +99,7 @@ struct btrfs_ordered_extent {
 	u64 disk_bytenr;
 	u64 disk_num_bytes;
 	u64 offset;
+	u8 iv[FSCRYPT_MAX_IV_SIZE];
 
 	/* number of bytes that still need writing */
 	u64 bytes_left;
@@ -194,7 +195,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
 			     u64 disk_num_bytes, u64 offset, unsigned flags,
-			     int compress_type);
+			     int compress_type, u8 *iv);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index d22086e1cbc8..466dfccba094 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -495,6 +495,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.data_len = datal;
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
+			clone_info.extent_buf_size = size;
 			clone_info.is_new_extent = false;
 			clone_info.update_times = !no_time_update;
 			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6f8e53d0cd6e..458877442ce5 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -204,6 +204,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 policy;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -255,10 +256,12 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+	btrfs_unpack_encryption(btrfs_file_extent_encryption(leaf, fi),
+				&policy, NULL);
+	if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
 		file_extent_err(leaf, slot,
-			"invalid encryption for file extent, have %u expect 0",
-			btrfs_file_extent_encryption(leaf, fi));
+			"invalid encryption for file extent, have %u expect range [0, %u]",
+			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
 		return -EUCLEAN;
 	}
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
@@ -287,12 +290,29 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return 0;
 	}
 
-	/* Regular or preallocated extent has fixed item size */
-	if (unlikely(item_size != sizeof(*fi))) {
-		file_extent_err(leaf, slot,
+	if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
+		u8 ivsize = btrfs_file_extent_encryption_ivsize(leaf, fi);
+		if (unlikely(item_size != sizeof(*fi) + ivsize)) {
+			file_extent_err(leaf, slot,
+	"invalid item size for encrypted file extent, have %u expect = %zu + iv of size %u",
+					item_size, sizeof(*fi), ivsize);
+			return -EUCLEAN;
+		}
+		/* Only regular extents should be encrypted. */
+		if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG) {
+			file_extent_err(leaf, slot,
+		"invalid type for encrypted file extent, have %u expect %u",
+					btrfs_file_extent_type(leaf, fi),
+					BTRFS_FILE_EXTENT_REG);
+			return -EUCLEAN;
+		}
+	} else {
+		if (unlikely(item_size != sizeof(*fi))) {
+			file_extent_err(leaf, slot,
 	"invalid item size for reg/prealloc file extent, have %u expect %zu",
-			item_size, sizeof(*fi));
-		return -EUCLEAN;
+					item_size, sizeof(*fi));
+			return -EUCLEAN;
+		}
 	}
 	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
 		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d73238254274..292a71be956b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4758,6 +4758,9 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	u8 ivsize = fscrypt_mode_ivsize(&inode->vfs_inode);
+	u8 encryption = btrfs_pack_encryption(IS_ENCRYPTED(&inode->vfs_inode) ?
+					      BTRFS_ENCRYPTION_FSCRYPT : 0, ivsize);
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
@@ -4779,6 +4782,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
 	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
 	btrfs_set_stack_file_extent_compression(&fi, em->compress_type);
+	btrfs_set_stack_file_extent_encryption(&fi, encryption);
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
@@ -4818,6 +4822,11 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, &fi,
 			    btrfs_item_ptr_offset(leaf, path->slots[0]),
 			    sizeof(fi));
+	if (ivsize)
+		write_extent_buffer(leaf, em->iv,
+				    btrfs_item_ptr_offset(leaf, path->slots[0]) +
+				    sizeof(fi), ivsize);
+
 	btrfs_mark_buffer_dirty(leaf);
 
 	btrfs_release_path(path);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index da44d3355385..6a2a37edd326 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -820,6 +820,10 @@ struct btrfs_file_extent_item {
 	 * but not for stat.
 	 */
 	__u8 compression;
+	/*
+	 * This field contains 4 bits of encryption type in the lower bits,
+	 * 4 bits of ivsize in the upper bits. The unencrypted value is 0.
+	 */
 	__u8 encryption;
 	__le16 other_encoding; /* spare for later use */
 
@@ -848,6 +852,11 @@ struct btrfs_file_extent_item {
 	 */
 	__le64 num_bytes;
 
+	/*
+	 * Encryption initialization vector. Only present if extent is
+	 * encrypted (stored in the encryption field).
+	 */
+	__u8 iv[0];
 } __attribute__ ((__packed__));
 
 struct btrfs_csum_item {
-- 
2.35.1

