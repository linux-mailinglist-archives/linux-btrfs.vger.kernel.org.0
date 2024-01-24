Return-Path: <linux-btrfs+bounces-1713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2583AF9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77FA1F2A016
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF001272C4;
	Wed, 24 Jan 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DM3tfr/J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBC1272AC
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116795; cv=none; b=ns5GI3L70sTFO3HIaHbz9Lv9nh7dwj24XajCE0pJ/0MrRAqzlRhR4+k0WifZLDF0e8qKioHn6x3xg9v2x9l9heJX/xzYMLgjYDagNQUe5wAFbArGV+ZeXxVhai7MOD/lrCCcna8ddrLPOr54BOczI8qCFlPmWj69dPhCxJ5QyMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116795; c=relaxed/simple;
	bh=VeKXwz2SlmB/wDaeV1BuWCcSxKoGrW5ChSWiIxAPDfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ26tswSlRDCBCRRNmBADJhWbolYsyJUuScF01QPcquhKrQN5erUCQALYvurq8rZOxmsP+Qwo+CCWwa2CE3XdOjtS2+C4bnMO0NXr2fRAQi2jEWN22liqEYy5gGamvD1kPyN9LaFH+ZhVLgmq+g6pT4kWuiOvTNpNJ+Tg0knslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DM3tfr/J; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff9adbf216so49058897b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116792; x=1706721592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k36IM3oogbJbX+Cca977QJLVZadx0c7notGaGN70m/A=;
        b=DM3tfr/JXhPsP1M2XOcdWpok5lJks/g9l7bKQ3jPc/MZIBps4PU2LyUvlJIoIAx3uR
         6OojpRKE4Ngz9d9ligrKc5cB+05ul9e+CCq5X9mnA/wh5aMZ1lE4CV33wXvPeHwOscmz
         0J9WkebnZJ+PQ9pLTubwngMqRf3+h0VeFgpJ5rB/yedEd7RKFT1YFJc7ZjDsJC1HWEOk
         2mj6dfpmgLMiv3P/AKRyxH2EJd4AVtclxrEiihbhrZf05Pl15kGffZlieFdm5CtXje3U
         YfcPFvVLth1GQptYJByNyJkzIovA00Dt1Dagz099rbib6YtEruS9sMorHM581fQC4jn8
         RMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116792; x=1706721592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k36IM3oogbJbX+Cca977QJLVZadx0c7notGaGN70m/A=;
        b=YIg3Pliz0LEkg/QbJkfBzULrKYh2sX4iDKYa9ISjDqhjxvlHWu4cEYH/6sCt31K5go
         QbO4ybbU7+fIF9D0rGNQCCUUR9LyOITQpG0bArj9mc9I/N6rT1L7pvZOWtiRzJjuNNm/
         M0whFyOF3fNG3jaTgNr2A6VX75quZ36176g7y7F24Q24GieUwGZrcMWLkG16zCOhiIA1
         UhxvYbyYunQUcQI/LkfddkE0OBpYBg0wtztlW8EypB3fvro1mmQblansSImS4QLKl8Xu
         fKzIIBh3Jo/O0Urz9fDYMsWxNzE8KQOrktkucQN6det0nLvAQ1IdU6J/o34GET1FA3uS
         FK7Q==
X-Gm-Message-State: AOJu0Yy7RhEO9wqY9h/9S7G+EuvItAKrgAHsYrbysBxCVFP4MxUkSN4I
	N7LzQuEI+pCnRer0LvmpvrCvBAexj4xfrfiIF1+Z9ro9Fyx5Keu+bJj9VDyIVUowWtz5k/g2+BF
	I
X-Google-Smtp-Source: AGHT+IGF8TlpBesyGTAgyt6W09vDglLWvwqnCdZvo+q6TpGKNJhuC8qN+k4UQuWbMiMQKzWD4reZeg==
X-Received: by 2002:a0d:d614:0:b0:5ff:58f1:9944 with SMTP id y20-20020a0dd614000000b005ff58f19944mr1147179ywd.30.1706116792202;
        Wed, 24 Jan 2024 09:19:52 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cn23-20020a05690c0d1700b005ff95e9a554sm60208ywb.127.2024.01.24.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 31/52] btrfs: implement the fscrypt extent encryption hooks
Date: Wed, 24 Jan 2024 12:18:53 -0500
Message-ID: <30eaad31964c88c3497a0c5bc8f2c727c1dc763a.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements the necessary hooks from fscrypt to support
per-extent encryption.  There's two main entry points

btrfs_fscrypt_load_extent_info
btrfs_fscrypt_save_extent_info

btrfs_fscrypt_load_extent_info gets called when we create the extent
maps from the file extent item at btrfs_get_extent() time.  We read the
extent context, and pass it into fscrypt to create the appropriate
fscrypt_extent_info structure.  This is then used on the bio's to make
sure the encryption is done properly.

btrfs_fscrypt_save_extent_info is used to generate the fscrypt context
from fscrypt and save it into the file extent item when we create a new
file extent item.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h     |  3 +++
 fs/btrfs/defrag.c    | 10 +++++++-
 fs/btrfs/file-item.c | 15 ++++++++++--
 fs/btrfs/file-item.h |  5 +++-
 fs/btrfs/file.c      |  5 ++++
 fs/btrfs/fscrypt.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h   | 35 ++++++++++++++++++++++++++
 fs/btrfs/inode.c     | 34 ++++++++++++++++++++++++--
 fs/btrfs/tree-log.c  | 13 +++++++++-
 9 files changed, 171 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 34ecf5966a5a..54ef875765ff 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -369,6 +369,9 @@ struct btrfs_replace_extent_info {
 	char *extent_buf;
 	/* The length of @extent_buf */
 	u32 extent_buf_size;
+	/* The fscrypt_extent_info for a new extent. */
+	u8 *fscrypt_ctx;
+	u32 fscrypt_context_size;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index dd1b5a060366..c3be0d1203ba 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -16,6 +16,7 @@
 #include "defrag.h"
 #include "file-item.h"
 #include "super.h"
+#include "fscrypt.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 
@@ -631,9 +632,12 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 	struct btrfs_path path = { 0 };
 	struct extent_map *em;
 	struct btrfs_key key;
+	struct btrfs_fscrypt_ctx ctx;
 	u64 ino = btrfs_ino(inode);
 	int ret;
 
+	ctx.size = 0;
+
 	em = alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
@@ -728,7 +732,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto next;
 
 		/* Now this extent covers @start, convert it to em */
-		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
+		btrfs_extent_item_to_extent_map(inode, &path, fi, em, &ctx);
 		break;
 next:
 		ret = btrfs_next_item(root, &path);
@@ -738,6 +742,10 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto not_found;
 	}
 	btrfs_release_path(&path);
+
+	ret = btrfs_fscrypt_load_extent_info(inode, em, &ctx);
+	if (ret)
+		goto err;
 	return em;
 
 not_found:
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 8bb6be8f2445..a00dc5f0273f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -21,6 +21,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "super.h"
+#include "fscrypt.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
@@ -1264,7 +1265,8 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     struct extent_map *em)
+				     struct extent_map *em,
+				     struct btrfs_fscrypt_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1275,6 +1277,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	u64 bytenr;
 	u8 type = btrfs_file_extent_type(leaf, fi);
 	int compress_type = btrfs_file_extent_compression(leaf, fi);
+	int encrypt_type = btrfs_file_extent_encryption(leaf, fi);
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
@@ -1304,7 +1307,15 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
-		extent_map_set_encryption(em, btrfs_file_extent_encryption(leaf, fi));
+
+		extent_map_set_encryption(em, encrypt_type);
+		if (encrypt_type != BTRFS_ENCRYPTION_NONE) {
+			ctx->size =
+				btrfs_file_extent_encryption_ctx_size(leaf, fi);
+			read_extent_buffer(leaf, ctx->ctx,
+				btrfs_file_extent_encryption_ctx_offset(fi),
+				ctx->size);
+		}
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
 		em->start = extent_start;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 04bd2d34efb1..bb79014024bd 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -5,6 +5,8 @@
 
 #include "accessors.h"
 
+struct btrfs_fscrypt_ctx;
+
 #define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
 		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
 
@@ -63,7 +65,8 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     struct extent_map *em);
+				     struct extent_map *em,
+				     struct btrfs_fscrypt_ctx *ctx);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
 int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start, u64 len);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2471b37ad57e..02436079c4f2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -38,6 +38,7 @@
 #include "ioctl.h"
 #include "file.h"
 #include "super.h"
+#include "fscrypt.h"
 
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
@@ -2278,6 +2279,10 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_num_bytes(leaf, extent, replace_len);
 	if (extent_info->is_new_extent)
 		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
+	if (extent_info->fscrypt_context_size)
+		btrfs_fscrypt_save_extent_info(inode, path,
+					       extent_info->fscrypt_ctx,
+					       extent_info->fscrypt_context_size);
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 7129a6ce0780..00cbb64129c0 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -215,7 +215,65 @@ static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
+int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
+				   struct extent_map *em,
+				   struct btrfs_fscrypt_ctx *ctx)
+{
+	struct fscrypt_extent_info *info;
+	unsigned long nofs_flag;
+
+	if (ctx->size == 0)
+		return 0;
+
+	nofs_flag = memalloc_nofs_save();
+	info = fscrypt_load_extent_info(&inode->vfs_inode, ctx->ctx, ctx->size);
+	memalloc_nofs_restore(nofs_flag);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+	em->fscrypt_info = info;
+	return 0;
+}
+
+void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
+				    struct btrfs_path *path,
+				    u8 *ctx, ssize_t ctx_size)
+{
+	struct btrfs_file_extent_item *ei;
+
+	/*
+	 * ctx_size includes the btrfs_encryption_info size because we need that
+	 * for inserting the item, subtract that from our ctx_size to get the
+	 * actual size of the context.
+	 */
+	ctx_size -= sizeof(struct btrfs_encryption_info);
+
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	write_extent_buffer(path->nodes[0], ctx,
+			    btrfs_file_extent_encryption_ctx_offset(ei),
+			    ctx_size);
+	btrfs_set_file_extent_encryption_ctx_size(path->nodes[0], ei, ctx_size);
+}
+
+ssize_t btrfs_fscrypt_context_for_new_extent(struct btrfs_inode *inode,
+					     struct fscrypt_extent_info *info,
+					     u8 *ctx)
+{
+	ssize_t ret;
+
+	if (!info)
+		return 0;
+
+	ret = fscrypt_context_for_new_extent(&inode->vfs_inode, info, ctx);
+	if (ret < 0) {
+		btrfs_err_rl(inode->root->fs_info, "invalid encrypt context");
+		return ret;
+	}
+	return ret + sizeof(struct btrfs_encryption_info);
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
+	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index c08fd52c99b4..21b5dfc6100d 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -8,6 +8,11 @@
 
 #include "fs.h"
 
+struct btrfs_fscrypt_ctx {
+	u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];
+	size_t size;
+};
+
 #ifdef CONFIG_FS_ENCRYPTION
 int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
 				struct btrfs_dir_item *di,
@@ -16,8 +21,28 @@ int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
 bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 			      struct extent_buffer *leaf,
 			      unsigned long de_name, u32 de_name_len);
+int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
+				   struct extent_map *em,
+				   struct btrfs_fscrypt_ctx *ctx);
+void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
+				    struct btrfs_path *path,
+				    u8 *ctx, ssize_t ctx_size);
+ssize_t btrfs_fscrypt_context_for_new_extent(struct btrfs_inode *inode,
+					     struct fscrypt_extent_info *info,
+					     u8 *ctx);
 
 #else
+static inline void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
+						  struct btrfs_path *path,
+						  u8 *ctx, ssize_t ctx_size) { }
+
+static inline int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
+						 struct extent_map *em,
+						 struct btrfs_fscrypt_ctx *ctx)
+{
+	return 0;
+}
+
 static inline int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
 					      struct btrfs_dir_item *di,
 					      struct fscrypt_str *qstr)
@@ -35,6 +60,16 @@ static inline bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 	return !memcmp_extent_buffer(leaf, fname->disk_name.name, de_name,
 				     de_name_len);
 }
+
+static inline ssize_t btrfs_fscrypt_context_for_new_extent(struct btrfs_inode *inode,
+							   struct fscrypt_extent_info *info,
+							   u8 *ctx)
+{
+	if (!info)
+		return 0;
+	return -EINVAL;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e4557c460ee0..7fa38eaa5afd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2915,9 +2915,16 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
-	size_t fscrypt_context_size = 0;
+	u8 fscrypt_ctx[FSCRYPT_SET_CONTEXT_MAX_SIZE];
+	ssize_t fscrypt_context_size = 0;
 	int ret;
 
+	fscrypt_context_size = btrfs_fscrypt_context_for_new_extent(inode,
+								    fscrypt_info,
+								    fscrypt_ctx);
+	if (fscrypt_context_size < 0)
+		return (int)fscrypt_context_size;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -2956,6 +2963,10 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 			btrfs_item_ptr_offset(leaf, path->slots[0]),
 			sizeof(struct btrfs_file_extent_item));
 
+	if (fscrypt_context_size)
+		btrfs_fscrypt_save_extent_info(inode, path, fscrypt_ctx,
+					       fscrypt_context_size);
+
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
@@ -6892,6 +6903,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	struct btrfs_key found_key;
 	struct extent_map *em = NULL;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
+	struct btrfs_fscrypt_ctx ctx;
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -6905,6 +6917,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		else
 			goto out;
 	}
+
+	ctx.size = 0;
+
 	em = alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
@@ -7009,7 +7024,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 
-	btrfs_extent_item_to_extent_map(inode, path, item, em);
+	btrfs_extent_item_to_extent_map(inode, path, item, em, &ctx);
 
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -7053,6 +7068,10 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto out;
 	}
 
+	ret = btrfs_fscrypt_load_extent_info(inode, em, &ctx);
+	if (ret)
+		goto out;
+
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
 	write_unlock(&em_tree->lock);
@@ -9732,6 +9751,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
+	u8 fscrypt_ctx[FSCRYPT_SET_CONTEXT_MAX_SIZE];
 	struct btrfs_replace_extent_info extent_info;
 	struct btrfs_trans_handle *trans = trans_in;
 	struct btrfs_path *path;
@@ -9767,6 +9787,14 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 		return trans;
 	}
 
+	fscrypt_context_size = btrfs_fscrypt_context_for_new_extent(inode,
+								    fscrypt_info,
+								    fscrypt_ctx);
+	if (fscrypt_context_size < 0) {
+		ret = (int)fscrypt_context_size;
+		goto free_qgroup;
+	}
+
 	extent_info.disk_offset = start;
 	extent_info.disk_len = len;
 	extent_info.data_offset = 0;
@@ -9778,6 +9806,8 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
 	extent_info.insertions = 0;
+	extent_info.fscrypt_ctx = fscrypt_ctx;
+	extent_info.fscrypt_context_size = fscrypt_context_size;
 
 	path = btrfs_alloc_path();
 	if (!path) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 102e78886c60..6fc16612b9b8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -30,6 +30,7 @@
 #include "file.h"
 #include "orphan.h"
 #include "tree-checker.h"
+#include "fscrypt.h"
 
 #define MAX_CONFLICT_INODES 10
 
@@ -4623,13 +4624,20 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item fi = { 0 };
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
+	u8 fscrypt_ctx[FSCRYPT_SET_CONTEXT_MAX_SIZE];
 	enum btrfs_compression_type compress_type;
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
-	size_t fscrypt_context_size = 0;
+	ssize_t fscrypt_context_size = 0;
 	u8 encryption = extent_map_encryption(em);
 
+	fscrypt_context_size = btrfs_fscrypt_context_for_new_extent(inode,
+								    em->fscrypt_info,
+								    fscrypt_ctx);
+	if (fscrypt_context_size < 0)
+		return (int)fscrypt_context_size;
+
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (em->flags & EXTENT_FLAG_PREALLOC)
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_PREALLOC);
@@ -4691,6 +4699,9 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, &fi,
 			    btrfs_item_ptr_offset(leaf, path->slots[0]),
 			    sizeof(fi));
+	if (fscrypt_context_size)
+		btrfs_fscrypt_save_extent_info(inode, path, fscrypt_ctx,
+					       fscrypt_context_size);
 	btrfs_mark_buffer_dirty(trans, leaf);
 
 	btrfs_release_path(path);
-- 
2.43.0


