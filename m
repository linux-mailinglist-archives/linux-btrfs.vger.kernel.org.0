Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD2454E63
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbhKQUXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbhKQUXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:04 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3EC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:05 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t11so3899300qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pi4j4V4l7C2Awm0t18FqNK5W2ZCvzHMUNiXr6cO8fFc=;
        b=PdI2LY3PYjcC7Q9v+cjV0dF6wRGnJe+EAXwzCHlnTojHf0EWneGeJpW+YVUVBnu0uO
         AdtTPW79hzsiNX5egx5FFCfKMTGQpV4G0Xd8imayEsBQUxnRQIm/Cs1RdPvLt3mpdLc+
         ecIDGxMsBUhtaeAxbL1s8CwIbRf26pUcstrxkBJGneOwBL3YYGERa9qtXmGAf/yKBPCB
         PgB6GY24G/N9picrc7tpQ7juAEoH0KeWriGTaP9JpLd6N55LNo0ky2hKO+ePC3gAtg6t
         MPh4ut7xoixePbJeRoinWZDZSPArVd4ZDJteeU93SR3f7j8h/xLRhf5ggUiCl8tzNUey
         nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pi4j4V4l7C2Awm0t18FqNK5W2ZCvzHMUNiXr6cO8fFc=;
        b=RlcLNd1FttsJCn5erRGsN2OmI8Qf86gH+sZP7QAB3qhI+6/cZdOyN74XfIRlUuDOCX
         ebugng8J9piIRqwkGHN6cB7yIfKTOmuTGgVLjOkGsn2rPJxHkypZtfqbUse6zr7uRlpr
         neSYzGdTg2v94vr0sJABrhcKV6zti1dxpYt8l44ZKS+ALODi6Au3VTc5v6B3U5iSLltl
         j1GxsAUY1CZSo65or6IZdmdhqksXsCxS4JwWUWUkIAT7xx6jwXz8+SnRyOfhWaPTIM6H
         Os4Y4EI6JnrePIhs/HbfnH6pEg372Lx8ffnAh3brete3yQWIATf5RLlE0c/MMn2EtnFL
         QMvA==
X-Gm-Message-State: AOAM531Dx1hEup9q5uP2d4dRPsJDTwdDu9tlLM9EJohLyFSfo5ARzlSo
        /3HO/nIWsXrtjOEky2n2C3HOGPIwMu5i+g==
X-Google-Smtp-Source: ABdhPJyZEPUM0XpHxaY0FFZozE6AJRMuYfR1DXds18pkv81tRBb3MkJgy7a4KTsl89+9/zGLSYFkzg==
X-Received: by 2002:a05:622a:15cc:: with SMTP id d12mr19798550qty.387.1637180404633;
        Wed, 17 Nov 2021 12:20:04 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:04 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 04/17] btrfs: add ram_bytes and offset to btrfs_ordered_extent
Date:   Wed, 17 Nov 2021 12:19:14 -0800
Message-Id: <cc54c2e1a46b6710116ab00eac19ff8a1db02c22.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, we only create ordered extents when ram_bytes == num_bytes
and offset == 0. However, BTRFS_IOC_ENCODED_WRITE writes may create
extents which only refer to a subset of the full unencoded extent, so we
need to plumb these fields through the ordered extent infrastructure and
pass them down to insert_reserved_file_extent().

Since we're changing the btrfs_add_ordered_extent* signature, let's get
rid of the trivial wrappers and add a kernel-doc.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c        |  58 ++++++++++++--------
 fs/btrfs/ordered-data.c | 119 ++++++++++++----------------------------
 fs/btrfs/ordered-data.h |  22 +++++---
 3 files changed, 82 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0bd992835cf5..1afadc7afff3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -980,11 +980,14 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	}
 	free_extent_map(em);
 
-	ret = btrfs_add_ordered_extent_compress(inode, start,	/* file_offset */
-					ins.objectid,		/* disk_bytenr */
-					async_extent->ram_size, /* num_bytes */
-					ins.offset,		/* disk_num_bytes */
-					async_extent->compress_type);
+	ret = btrfs_add_ordered_extent(inode, start,		/* file_offset */
+				       async_extent->ram_size,	/* num_bytes */
+				       async_extent->ram_size,	/* ram_bytes */
+				       ins.objectid,		/* disk_bytenr */
+				       ins.offset,		/* disk_num_bytes */
+				       0,			/* offset */
+				       1 << BTRFS_ORDERED_COMPRESSED,
+				       async_extent->compress_type);
 	if (ret) {
 		btrfs_drop_extent_cache(inode, start, end, 0);
 		goto out_free_reserve;
@@ -1233,9 +1236,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
-					       ram_size, cur_alloc_size,
-					       BTRFS_ORDERED_REGULAR);
+		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
+					       ins.objectid, cur_alloc_size, 0,
+					       1 << BTRFS_ORDERED_REGULAR,
+					       BTRFS_COMPRESS_NONE);
 		if (ret)
 			goto out_drop_extent_cache;
 
@@ -1893,10 +1897,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				goto error;
 			}
 			free_extent_map(em);
-			ret = btrfs_add_ordered_extent(inode, cur_offset,
-						       disk_bytenr, num_bytes,
-						       num_bytes,
-						       BTRFS_ORDERED_PREALLOC);
+			ret = btrfs_add_ordered_extent(inode,
+					cur_offset, num_bytes, num_bytes,
+					disk_bytenr, num_bytes, 0,
+					1 << BTRFS_ORDERED_PREALLOC,
+					BTRFS_COMPRESS_NONE);
 			if (ret) {
 				btrfs_drop_extent_cache(inode, cur_offset,
 							cur_offset + num_bytes - 1,
@@ -1905,9 +1910,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 		} else {
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
+						       num_bytes, num_bytes,
 						       disk_bytenr, num_bytes,
-						       num_bytes,
-						       BTRFS_ORDERED_NOCOW);
+						       0,
+						       1 << BTRFS_ORDERED_NOCOW,
+						       BTRFS_COMPRESS_NONE);
 			if (ret)
 				goto error;
 		}
@@ -2864,6 +2871,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key ins;
 	u64 disk_num_bytes = btrfs_stack_file_extent_disk_num_bytes(stack_fi);
 	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
+	u64 offset = btrfs_stack_file_extent_offset(stack_fi);
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
@@ -2938,7 +2946,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		goto out;
 
 	ret = btrfs_alloc_reserved_file_extent(trans, root, btrfs_ino(inode),
-					       file_pos, qgroup_reserved, &ins);
+					       file_pos - offset,
+					       qgroup_reserved, &ins);
 out:
 	btrfs_free_path(path);
 
@@ -2964,20 +2973,20 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 					     struct btrfs_ordered_extent *oe)
 {
 	struct btrfs_file_extent_item stack_fi;
-	u64 logical_len;
 	bool update_inode_bytes;
+	u64 num_bytes = oe->num_bytes;
+	u64 ram_bytes = oe->ram_bytes;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
 	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->disk_bytenr);
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
 						   oe->disk_num_bytes);
+	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
-		logical_len = oe->truncated_len;
-	else
-		logical_len = oe->num_bytes;
-	btrfs_set_stack_file_extent_num_bytes(&stack_fi, logical_len);
-	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, logical_len);
+		num_bytes = ram_bytes = oe->truncated_len;
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
 	/* Encryption and other encoding is reserved and all 0 */
 
@@ -7399,8 +7408,11 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent_dio(inode, start, block_start, len,
-					   block_len, type);
+	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
+				       block_len, 0,
+				       (1 << type) |
+				       (1 << BTRFS_ORDERED_DIRECT),
+				       BTRFS_COMPRESS_NONE);
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6b51fd2ec5ac..5e4c59b00b01 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -143,16 +143,27 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	return ret;
 }
 
-/*
- * Allocate and add a new ordered_extent into the per-inode tree.
+/**
+ * btrfs_add_ordered_extent - Add an ordered extent to the per-inode tree.
+ * @inode: inode that this extent is for.
+ * @file_offset: Logical offset in file where the extent starts.
+ * @num_bytes: Logical length of extent in file.
+ * @ram_bytes: Full length of unencoded data.
+ * @disk_bytenr: Offset of extent on disk.
+ * @disk_num_bytes: Size of extent on disk.
+ * @offset: Offset into unencoded data where file data starts.
+ * @flags: Flags specifying type of extent (1 << BTRFS_ORDERED_*).
+ * @compress_type: Compression algorithm used for data.
  *
- * The tree is given a single reference on the ordered extent that was
- * inserted.
+ * Most of these parameters correspond to &struct btrfs_file_extent_item. The
+ * tree is given a single reference on the ordered extent that was inserted.
+ *
+ * Return: 0 or -ENOMEM.
  */
-static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type, int dio,
-				      int compress_type)
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, int flags,
+			     int compress_type)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -161,7 +172,8 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	struct btrfs_ordered_extent *entry;
 	int ret;
 
-	if (type == BTRFS_ORDERED_NOCOW || type == BTRFS_ORDERED_PREALLOC) {
+	if (flags &
+	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
 		if (ret < 0)
@@ -181,9 +193,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 		return -ENOMEM;
 
 	entry->file_offset = file_offset;
-	entry->disk_bytenr = disk_bytenr;
 	entry->num_bytes = num_bytes;
+	entry->ram_bytes = ram_bytes;
+	entry->disk_bytenr = disk_bytenr;
 	entry->disk_num_bytes = disk_num_bytes;
+	entry->offset = offset;
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
@@ -191,18 +205,12 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->qgroup_rsv = ret;
 	entry->physical = (u64)-1;
 
-	ASSERT(type == BTRFS_ORDERED_REGULAR ||
-	       type == BTRFS_ORDERED_NOCOW ||
-	       type == BTRFS_ORDERED_PREALLOC ||
-	       type == BTRFS_ORDERED_COMPRESSED);
-	set_bit(type, &entry->flags);
+	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
+	entry->flags = flags;
 
 	percpu_counter_add_batch(&fs_info->ordered_bytes, num_bytes,
 				 fs_info->delalloc_batch);
 
-	if (dio)
-		set_bit(BTRFS_ORDERED_DIRECT, &entry->flags);
-
 	/* one ref for the tree */
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
@@ -247,41 +255,6 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	return 0;
 }
 
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-			     int type)
-{
-	ASSERT(type == BTRFS_ORDERED_REGULAR ||
-	       type == BTRFS_ORDERED_NOCOW ||
-	       type == BTRFS_ORDERED_PREALLOC);
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 0,
-					  BTRFS_COMPRESS_NONE);
-}
-
-int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
-				 u64 disk_bytenr, u64 num_bytes,
-				 u64 disk_num_bytes, int type)
-{
-	ASSERT(type == BTRFS_ORDERED_REGULAR ||
-	       type == BTRFS_ORDERED_NOCOW ||
-	       type == BTRFS_ORDERED_PREALLOC);
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 1,
-					  BTRFS_COMPRESS_NONE);
-}
-
-int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int compress_type)
-{
-	ASSERT(compress_type != BTRFS_COMPRESS_NONE);
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes,
-					  BTRFS_ORDERED_COMPRESSED, 0,
-					  compress_type);
-}
-
 /*
  * Add a struct btrfs_ordered_sum into the list of checksums to be inserted
  * when an ordered extent is finished.  If the list covers more than one
@@ -1052,42 +1025,18 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	u64 file_offset = ordered->file_offset + pos;
 	u64 disk_bytenr = ordered->disk_bytenr + pos;
-	u64 num_bytes = len;
-	u64 disk_num_bytes = len;
-	int type;
-	unsigned long flags_masked = ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
-	int compress_type = ordered->compress_type;
-	unsigned long weight;
-	int ret;
-
-	weight = hweight_long(flags_masked);
-	WARN_ON_ONCE(weight > 1);
-	if (!weight)
-		type = 0;
-	else
-		type = __ffs(flags_masked);
+	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
 
 	/*
-	 * The splitting extent is already counted and will be added again
-	 * in btrfs_add_ordered_extent_*(). Subtract num_bytes to avoid
-	 * double counting.
+	 * The splitting extent is already counted and will be added again in
+	 * btrfs_add_ordered_extent_*(). Subtract len to avoid double counting.
 	 */
-	percpu_counter_add_batch(&fs_info->ordered_bytes, -num_bytes,
+	percpu_counter_add_batch(&fs_info->ordered_bytes, -len,
 				 fs_info->delalloc_batch);
-	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered->flags)) {
-		WARN_ON_ONCE(1);
-		ret = btrfs_add_ordered_extent_compress(BTRFS_I(inode),
-				file_offset, disk_bytenr, num_bytes,
-				disk_num_bytes, compress_type);
-	} else if (test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
-		ret = btrfs_add_ordered_extent_dio(BTRFS_I(inode), file_offset,
-				disk_bytenr, num_bytes, disk_num_bytes, type);
-	} else {
-		ret = btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
-				disk_bytenr, num_bytes, disk_num_bytes, type);
-	}
-
-	return ret;
+	WARN_ON_ONCE(flags & (1 << BTRFS_ORDERED_COMPRESSED));
+	return btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, len, len,
+					disk_bytenr, len, 0, flags,
+					ordered->compress_type);
 }
 
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4194e960ff61..0feb0c29839e 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -76,6 +76,13 @@ enum {
 	BTRFS_ORDERED_PENDING,
 };
 
+/* BTRFS_ORDERED_* flags that specify the type of the extent. */
+#define BTRFS_ORDERED_TYPE_FLAGS ((1UL << BTRFS_ORDERED_REGULAR) |	\
+				  (1UL << BTRFS_ORDERED_NOCOW) |	\
+				  (1UL << BTRFS_ORDERED_PREALLOC) |	\
+				  (1UL << BTRFS_ORDERED_COMPRESSED) |	\
+				  (1UL << BTRFS_ORDERED_DIRECT))
+
 struct btrfs_ordered_extent {
 	/* logical offset in the file */
 	u64 file_offset;
@@ -84,9 +91,11 @@ struct btrfs_ordered_extent {
 	 * These fields directly correspond to the same fields in
 	 * btrfs_file_extent_item.
 	 */
-	u64 disk_bytenr;
 	u64 num_bytes;
+	u64 ram_bytes;
+	u64 disk_bytenr;
 	u64 disk_num_bytes;
+	u64 offset;
 
 	/* number of bytes that still need writing */
 	u64 bytes_left;
@@ -179,14 +188,9 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
-			     int type);
-int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
-				 u64 disk_bytenr, u64 num_bytes,
-				 u64 disk_num_bytes, int type);
-int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
-				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int compress_type);
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, int flags,
+			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.34.0

