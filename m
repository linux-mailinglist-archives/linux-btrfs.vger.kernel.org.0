Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06F6573449
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiGMKb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiGMKbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:23 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D4FC9B9
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:21 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E1FBC81123;
        Wed, 13 Jul 2022 06:31:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708281; bh=Rua5M38ap98O348HnTFS2NkJBnKjiZEx6pmuTPO3Ia0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGV6w/1eWHVvHLaxSx9QxUQlmXHpPJuNQhfWFvUao8l5qRkBkxbaa1jF7HeGId+MC
         HljBQa2o/VYJ58ViE2X37sj0SkZ8jgG7n+bmJ188x1C22omVBgU/AyYfBZwPUZm6Nx
         E4PBnp6xB4dwC6F6xY/lR37WnkNHr4nvUV7GjuQi/Z67R6cWWpoMtrgOPKVSXn3/uJ
         MqYyn4gks54DJTDICnHA/XT5LYdutoc4KY/3Xx+Kx8RXLNSSaCpmIuVP8NXttrmyoY
         o7+yRbY+A0AUoRyuC+zRDSViwrrUdB/vauNoMYnoXNhQEpwTM0b8KjS6UKETZQR+3G
         1VZzOiG+ATcLg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 18/23] btrfs: add iv generation function
Date:   Wed, 13 Jul 2022 06:29:51 -0400
Message-Id: <83ff2c3196e3fed1d37fe6a8477aa7b6300ab2c4.1657707687.git.sweettea-kernel@dorminy.me>
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

As btrfs cannot use the standard inode or logical block based encryption
for data block encryption, it must provide a IV generation function and
users must use the IV_FROM_FS policy.  However, for filenames (and later for simple, non-block
data), generating the IV from the inode number and logical block number
suffices, since these encrypted datum are not shared between inodes.

Begin implementing the IV_FROM_FS policy with a simple IV generation
function that imitates the IV_INO_LBLK_64 policy.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h                | 28 ++++++++++++++
 fs/btrfs/extent_map.h           |  8 ++++
 fs/btrfs/file-item.c            | 11 ++++++
 fs/btrfs/fscrypt.c              | 12 ++++++
 fs/btrfs/fscrypt.h              | 23 +++++++++++
 fs/btrfs/inode.c                | 68 +++++++++++++++++++++++++--------
 fs/btrfs/ordered-data.c         | 12 +++++-
 fs/btrfs/ordered-data.h         |  3 +-
 fs/btrfs/tree-checker.c         | 36 +++++++++++++----
 fs/btrfs/tree-log.c             |  9 +++++
 include/uapi/linux/btrfs_tree.h |  9 +++++
 11 files changed, 192 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a1fea2833bff..bed27b91d69e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -37,6 +37,7 @@
 #include "async-thread.h"
 #include "block-rsv.h"
 #include "locking.h"
+#include "fscrypt.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -2594,6 +2595,15 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
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
@@ -2626,6 +2636,24 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
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
+				   struct btrfs_path *path)
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
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index cffe63e18ef4..82eb9654f60f 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -185,9 +185,21 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
 	return true;
 }
 
+static void btrfs_fscrypt_get_iv(u8 *iv, int ivsize, struct inode *inode,
+				 u64 lblk_num)
+{
+	/*
+	 * For encryption that doesn't involve extent data, juse use the
+	 * nonce already loaded into the iv buffer.
+	 */
+	return;
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
+	.flags = FS_CFLG_ALLOW_PARTIAL,
 	.key_prefix = "btrfs:",
 	.get_context = btrfs_fscrypt_get_context,
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
+	.get_fs_defined_iv = btrfs_fscrypt_get_iv,
 };
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
index a74b0d326baa..1ee8eca5a88f 100644
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
@@ -3047,6 +3049,7 @@ int btrfs_writepage_cow_fixup(struct page *page)
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *inode, u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
+				       const u8 *iv,
 				       const bool update_inode_bytes,
 				       u64 qgroup_reserved)
 {
@@ -3062,6 +3065,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	int ret;
+	int ivsize = fscrypt_mode_ivsize(&inode->vfs_inode);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3080,7 +3084,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	drop_args.start = file_pos;
 	drop_args.end = file_pos + num_bytes;
 	drop_args.replace_extent = true;
-	drop_args.extent_item_size = sizeof(*stack_fi);
+	drop_args.extent_item_size = sizeof(*stack_fi) + ivsize;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
@@ -3091,7 +3095,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
-					      sizeof(*stack_fi));
+					      sizeof(*stack_fi) + ivsize);
 		if (ret)
 			goto out;
 	}
@@ -3100,6 +3104,11 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
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
@@ -3176,7 +3185,12 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
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
@@ -3190,6 +3204,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
 					   oe->file_offset, &stack_fi,
+					   oe->iv,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
 
@@ -7100,8 +7115,24 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
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
+			if (ivsize != inode_ivsize || ivsize != item_ivsize)
+				btrfs_crit(fs_info,
+					"invalid encryption IV size for inode %llu: itemsize %d item %d inode %d",
+					btrfs_ino(inode), ivsize, item_ivsize, inode_ivsize);
+			ret = -EUCLEAN;
+			goto out;
+		}
+		goto insert;
+	} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		goto insert;
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		unsigned long ptr;
@@ -7330,7 +7361,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 				       block_len, 0,
 				       (1 << type) |
 				       (1 << BTRFS_ORDERED_DIRECT),
-				       BTRFS_COMPRESS_NONE);
+				       BTRFS_COMPRESS_NONE, NULL);
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
@@ -9956,6 +9987,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct extent_buffer *leaf;
 	struct fscrypt_str disk_link;
 	u32 name_len = strlen(symname);
+	u8 encryption;
 
 	/*
 	 * fscrypt sets disk_link.len to be len + 1, including a NULL terminator, but we
@@ -10021,7 +10053,9 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
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
@@ -10102,16 +10136,18 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
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
@@ -11076,7 +11112,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
index 4959e8ecc99a..51aed5667964 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4749,6 +4749,9 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	u8 ivsize = fscrypt_mode_ivsize(&inode->vfs_inode);
+	u8 encryption = btrfs_pack_encryption(IS_ENCRYPTED(&inode->vfs_inode) ?
+					      BTRFS_ENCRYPTION_FSCRYPT : 0, ivsize);
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
@@ -4770,6 +4773,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
 	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
 	btrfs_set_stack_file_extent_compression(&fi, em->compress_type);
+	btrfs_set_stack_file_extent_encryption(&fi, encryption);
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
@@ -4809,6 +4813,11 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
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

