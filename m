Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262D2AFFF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfIKP0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32973 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfIKP0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so25756693qtd.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0nOP1bPX4DtUxxN00KaiBrv3aSk3hyVm/FlqiyoiMNc=;
        b=AciSeSjc1MHKrCXJuzmpLjgIrqKVHUU2+HEWFn1r2ONlGXyTKfKbq0D5o2oZ9VAQVT
         bSFVIbVTXoFfsbiCgax9MNhMeyGvRmU3G4LyueyFXj8kugKQxF9SkJT4mVwi4/4Jn3WA
         Fl1Fm7SLl2fODMbt3LMZP78uoGMaiDYBxZWXsBccPZkFeIecaeth2IjK520+b8bJFpVx
         2uoTLP9UxRNSJEZiXe6d/IeEAQdR2BikSp4HdtZrWTUpXLo8Uy/Fg++YYEcCfVAdqlpp
         6kUqi6mWlMSlsWoTiFcP6qLl/0mP+WCWQF2rWGT/TvT+DIXw5DgGi48Th07yBrn6gYfo
         cGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nOP1bPX4DtUxxN00KaiBrv3aSk3hyVm/FlqiyoiMNc=;
        b=LLRrKqk6SGoe6dIHziD2YrPye1Hq0hTxWJZ2VMmRKqVO9skMwFQuY+RUQJtvDUzwGA
         odpESSOvRXhp+K4DRJSEnp/In03oOmIYaFW1THMe66wnv0S9z0ErrqAZ2ERw+7wgp58x
         y0why0asI3kTj2LDh5xoE9FuxdvB/k2oOpi7gx4Yyvjjt5CqPQ8AwPOowpcpOEJRrS2o
         pLm6whv2Hwe82K1uGBuaLOPiFH64vWzhe7RYPN7TUFpYlOT67Nr08Kzz/0IW+Yu+kj3T
         02hW6ADrNPQ33o/F7yM9hnOK+J3CqKvjtoJHhsjznUpUvPlfexZSl77cfjZ5syOr/mlW
         sZtA==
X-Gm-Message-State: APjAAAULcBYX9vaCcKp8d3ZIr0AcFv/rEWbkLY1UvDdAtxICSsQlPOuj
        vLrH49YlB+XKXvJcKG+BLUZk9ce27cInIw==
X-Google-Smtp-Source: APXvYqxbUpWVkBWMGDs3Mmzpg1C9oRRsf4LZ2IQZSsI5Zoiuhy0Fss1wzL3VIh3U1Gqq4VciLPSyig==
X-Received: by 2002:ac8:198b:: with SMTP id u11mr3091510qtj.108.1568215580072;
        Wed, 11 Sep 2019 08:26:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g19sm14033273qtb.2.2019.09.11.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/9] btrfs: move extent_io_tree defs to their own header
Date:   Wed, 11 Sep 2019 11:26:05 -0400
Message-Id: <20190911152611.3393-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911152611.3393-1-josef@toxicpanda.com>
References: <20190911152611.3393-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent_io.c/h are huge, encompassing a bunch of different things.  The
extent_io_tree code can live on its own, so separate this out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h          |   1 +
 fs/btrfs/extent-io-tree.h | 227 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c      |   1 +
 fs/btrfs/extent_io.h      | 217 +-----------------------------------
 4 files changed, 230 insertions(+), 216 deletions(-)
 create mode 100644 fs/btrfs/extent-io-tree.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..5e7ff169683c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -28,6 +28,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
+#include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
 #include "async-thread.h"
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
new file mode 100644
index 000000000000..6f53387445ca
--- /dev/null
+++ b/fs/btrfs/extent-io-tree.h
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_EXTENT_IO_TREE_H
+#define BTRFS_EXTENT_IO_TREE_H
+
+struct extent_changeset;
+
+/* bits for the extent state */
+#define EXTENT_DIRTY		(1U << 0)
+#define EXTENT_UPTODATE		(1U << 1)
+#define EXTENT_LOCKED		(1U << 2)
+#define EXTENT_NEW		(1U << 3)
+#define EXTENT_DELALLOC		(1U << 4)
+#define EXTENT_DEFRAG		(1U << 5)
+#define EXTENT_BOUNDARY		(1U << 6)
+#define EXTENT_NODATASUM	(1U << 7)
+#define EXTENT_CLEAR_META_RESV	(1U << 8)
+#define EXTENT_NEED_WAIT	(1U << 9)
+#define EXTENT_DAMAGED		(1U << 10)
+#define EXTENT_NORESERVE	(1U << 11)
+#define EXTENT_QGROUP_RESERVED	(1U << 12)
+#define EXTENT_CLEAR_DATA_RESV	(1U << 13)
+#define EXTENT_DELALLOC_NEW	(1U << 14)
+#define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
+				 EXTENT_CLEAR_DATA_RESV)
+#define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING)
+
+/*
+ * Redefined bits above which are used only in the device allocation tree,
+ * shouldn't be using EXTENT_LOCKED / EXTENT_BOUNDARY / EXTENT_CLEAR_META_RESV
+ * / EXTENT_CLEAR_DATA_RESV because they have special meaning to the bit
+ * manipulation functions
+ */
+#define CHUNK_ALLOCATED EXTENT_DIRTY
+#define CHUNK_TRIMMED   EXTENT_DEFRAG
+
+enum {
+	IO_TREE_FS_INFO_FREED_EXTENTS0,
+	IO_TREE_FS_INFO_FREED_EXTENTS1,
+	IO_TREE_INODE_IO,
+	IO_TREE_INODE_IO_FAILURE,
+	IO_TREE_RELOC_BLOCKS,
+	IO_TREE_TRANS_DIRTY_PAGES,
+	IO_TREE_ROOT_DIRTY_LOG_PAGES,
+	IO_TREE_SELFTEST,
+};
+
+struct extent_io_tree {
+	struct rb_root state;
+	struct btrfs_fs_info *fs_info;
+	void *private_data;
+	u64 dirty_bytes;
+	bool track_uptodate;
+
+	/* Who owns this io tree, should be one of IO_TREE_* */
+	u8 owner;
+
+	spinlock_t lock;
+	const struct extent_io_ops *ops;
+};
+
+struct extent_state {
+	u64 start;
+	u64 end; /* inclusive */
+	struct rb_node rb_node;
+
+	/* ADD NEW ELEMENTS AFTER THIS */
+	wait_queue_head_t wq;
+	refcount_t refs;
+	unsigned state;
+
+	struct io_failure_record *failrec;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct list_head leak_list;
+#endif
+};
+
+int __init extent_state_cache_init(void);
+void __cold extent_state_cache_exit(void);
+
+void extent_io_tree_init(struct btrfs_fs_info *fs_info,
+			 struct extent_io_tree *tree, unsigned int owner,
+			 void *private_data);
+void extent_io_tree_release(struct extent_io_tree *tree);
+
+int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+		     struct extent_state **cached);
+
+static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
+{
+	return lock_extent_bits(tree, start, end, NULL);
+}
+
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end);
+
+int __init extent_io_init(void);
+void __cold extent_io_exit(void);
+
+u64 count_range_bits(struct extent_io_tree *tree,
+		     u64 *start, u64 search_end,
+		     u64 max_bytes, unsigned bits, int contig);
+
+void free_extent_state(struct extent_state *state);
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   unsigned bits, int filled,
+		   struct extent_state *cached_state);
+int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+		unsigned bits, struct extent_changeset *changeset);
+int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		     unsigned bits, int wake, int delete,
+		     struct extent_state **cached);
+int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		     unsigned bits, int wake, int delete,
+		     struct extent_state **cached, gfp_t mask,
+		     struct extent_changeset *changeset);
+
+static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
+{
+	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, NULL);
+}
+
+static inline int unlock_extent_cached(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached)
+{
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
+				GFP_NOFS, NULL);
+}
+
+static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
+		u64 start, u64 end, struct extent_state **cached)
+{
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
+				GFP_ATOMIC, NULL);
+}
+
+static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
+		u64 end, unsigned bits)
+{
+	int wake = 0;
+
+	if (bits & EXTENT_LOCKED)
+		wake = 1;
+
+	return clear_extent_bit(tree, start, end, bits, wake, 0, NULL);
+}
+
+int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			   unsigned bits, struct extent_changeset *changeset);
+int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   unsigned bits, u64 *failed_start,
+		   struct extent_state **cached_state, gfp_t mask);
+int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
+			   unsigned bits);
+
+static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
+		u64 end, unsigned bits)
+{
+	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS);
+}
+
+static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached_state)
+{
+	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE, 0, 0,
+				cached_state, GFP_NOFS, NULL);
+}
+
+static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
+		u64 end, gfp_t mask)
+{
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL,
+			      NULL, mask);
+}
+
+static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
+				     u64 end, struct extent_state **cached)
+{
+	return clear_extent_bit(tree, start, end,
+				EXTENT_DIRTY | EXTENT_DELALLOC |
+				EXTENT_DO_ACCOUNTING, 0, 0, cached);
+}
+
+int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       unsigned bits, unsigned clear_bits,
+		       struct extent_state **cached_state);
+
+static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
+				      u64 end, unsigned int extra_bits,
+				      struct extent_state **cached_state)
+{
+	return set_extent_bit(tree, start, end,
+			      EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
+			      NULL, cached_state, GFP_NOFS);
+}
+
+static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached_state)
+{
+	return set_extent_bit(tree, start, end,
+			      EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
+			      NULL, cached_state, GFP_NOFS);
+}
+
+static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
+		u64 end)
+{
+	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, NULL,
+			GFP_NOFS);
+}
+
+static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached_state, gfp_t mask)
+{
+	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, NULL,
+			      cached_state, mask);
+}
+
+int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			  u64 *start_ret, u64 *end_ret, unsigned bits,
+			  struct extent_state **cached_state);
+void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, unsigned bits);
+int extent_invalidatepage(struct extent_io_tree *tree,
+			  struct page *page, unsigned long offset);
+
+#endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bdd9b7f5a295..f5945f0a06da 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -14,6 +14,7 @@
 #include <linux/prefetch.h>
 #include <linux/cleancache.h>
 #include "extent_io.h"
+#include "extent-io-tree.h"
 #include "extent_map.h"
 #include "ctree.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e813f593202d..8c782d061132 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -7,35 +7,6 @@
 #include <linux/refcount.h>
 #include "ulist.h"
 
-/* bits for the extent state */
-#define EXTENT_DIRTY		(1U << 0)
-#define EXTENT_UPTODATE		(1U << 1)
-#define EXTENT_LOCKED		(1U << 2)
-#define EXTENT_NEW		(1U << 3)
-#define EXTENT_DELALLOC		(1U << 4)
-#define EXTENT_DEFRAG		(1U << 5)
-#define EXTENT_BOUNDARY		(1U << 6)
-#define EXTENT_NODATASUM	(1U << 7)
-#define EXTENT_CLEAR_META_RESV	(1U << 8)
-#define EXTENT_NEED_WAIT	(1U << 9)
-#define EXTENT_DAMAGED		(1U << 10)
-#define EXTENT_NORESERVE	(1U << 11)
-#define EXTENT_QGROUP_RESERVED	(1U << 12)
-#define EXTENT_CLEAR_DATA_RESV	(1U << 13)
-#define EXTENT_DELALLOC_NEW	(1U << 14)
-#define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
-				 EXTENT_CLEAR_DATA_RESV)
-#define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING)
-
-/*
- * Redefined bits above which are used only in the device allocation tree,
- * shouldn't be using EXTENT_LOCKED / EXTENT_BOUNDARY / EXTENT_CLEAR_META_RESV
- * / EXTENT_CLEAR_DATA_RESV because they have special meaning to the bit
- * manipulation functions
- */
-#define CHUNK_ALLOCATED EXTENT_DIRTY
-#define CHUNK_TRIMMED   EXTENT_DEFRAG
-
 /*
  * flags for bio submission. The high bits indicate the compression
  * type for this bio
@@ -89,12 +60,11 @@ enum {
 #define BITMAP_LAST_BYTE_MASK(nbits) \
 	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
 
-struct extent_state;
 struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
 struct io_failure_record;
-
+struct extent_io_tree;
 
 typedef blk_status_t (extent_submit_bio_start_t)(void *private_data,
 		struct bio *bio, u64 bio_offset);
@@ -111,47 +81,6 @@ struct extent_io_ops {
 				    int mirror);
 };
 
-enum {
-	IO_TREE_FS_INFO_FREED_EXTENTS0,
-	IO_TREE_FS_INFO_FREED_EXTENTS1,
-	IO_TREE_INODE_IO,
-	IO_TREE_INODE_IO_FAILURE,
-	IO_TREE_RELOC_BLOCKS,
-	IO_TREE_TRANS_DIRTY_PAGES,
-	IO_TREE_ROOT_DIRTY_LOG_PAGES,
-	IO_TREE_SELFTEST,
-};
-
-struct extent_io_tree {
-	struct rb_root state;
-	struct btrfs_fs_info *fs_info;
-	void *private_data;
-	u64 dirty_bytes;
-	bool track_uptodate;
-
-	/* Who owns this io tree, should be one of IO_TREE_* */
-	u8 owner;
-
-	spinlock_t lock;
-	const struct extent_io_ops *ops;
-};
-
-struct extent_state {
-	u64 start;
-	u64 end; /* inclusive */
-	struct rb_node rb_node;
-
-	/* ADD NEW ELEMENTS AFTER THIS */
-	wait_queue_head_t wq;
-	refcount_t refs;
-	unsigned state;
-
-	struct io_failure_record *failrec;
-
-#ifdef CONFIG_BTRFS_DEBUG
-	struct list_head leak_list;
-#endif
-};
 
 #define INLINE_EXTENT_BUFFER_PAGES 16
 #define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
@@ -259,152 +188,11 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 					  u64 start, u64 len,
 					  int create);
 
-void extent_io_tree_init(struct btrfs_fs_info *fs_info,
-			 struct extent_io_tree *tree, unsigned int owner,
-			 void *private_data);
-void extent_io_tree_release(struct extent_io_tree *tree);
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
-int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		     struct extent_state **cached);
 
-static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	return lock_extent_bits(tree, start, end, NULL);
-}
-
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end);
 int extent_read_full_page(struct extent_io_tree *tree, struct page *page,
 			  get_extent_t *get_extent, int mirror_num);
-int __init extent_io_init(void);
-void __cold extent_io_exit(void);
-
-u64 count_range_bits(struct extent_io_tree *tree,
-		     u64 *start, u64 search_end,
-		     u64 max_bytes, unsigned bits, int contig);
-
-void free_extent_state(struct extent_state *state);
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, int filled,
-		   struct extent_state *cached_state);
-int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		unsigned bits, struct extent_changeset *changeset);
-int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     unsigned bits, int wake, int delete,
-		     struct extent_state **cached);
-int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     unsigned bits, int wake, int delete,
-		     struct extent_state **cached, gfp_t mask,
-		     struct extent_changeset *changeset);
-
-static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, NULL);
-}
-
-static inline int unlock_extent_cached(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached)
-{
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
-				GFP_NOFS, NULL);
-}
-
-static inline int unlock_extent_cached_atomic(struct extent_io_tree *tree,
-		u64 start, u64 end, struct extent_state **cached)
-{
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, cached,
-				GFP_ATOMIC, NULL);
-}
-
-static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, unsigned bits)
-{
-	int wake = 0;
-
-	if (bits & EXTENT_LOCKED)
-		wake = 1;
-
-	return clear_extent_bit(tree, start, end, bits, wake, 0, NULL);
-}
-
-int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits, struct extent_changeset *changeset);
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   unsigned bits, u64 *failed_start,
-		   struct extent_state **cached_state, gfp_t mask);
-int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
-			   unsigned bits);
-
-static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, unsigned bits)
-{
-	return set_extent_bit(tree, start, end, bits, NULL, NULL, GFP_NOFS);
-}
-
-static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached_state)
-{
-	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE, 0, 0,
-				cached_state, GFP_NOFS, NULL);
-}
-
-static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
-		u64 end, gfp_t mask)
-{
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL,
-			      NULL, mask);
-}
-
-static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
-				     u64 end, struct extent_state **cached)
-{
-	return clear_extent_bit(tree, start, end,
-				EXTENT_DIRTY | EXTENT_DELALLOC |
-				EXTENT_DO_ACCOUNTING, 0, 0, cached);
-}
-
-int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       unsigned bits, unsigned clear_bits,
-		       struct extent_state **cached_state);
-
-static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
-				      u64 end, unsigned int extra_bits,
-				      struct extent_state **cached_state)
-{
-	return set_extent_bit(tree, start, end,
-			      EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
-			      NULL, cached_state, GFP_NOFS);
-}
-
-static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached_state)
-{
-	return set_extent_bit(tree, start, end,
-			      EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
-			      NULL, cached_state, GFP_NOFS);
-}
-
-static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
-		u64 end)
-{
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, NULL,
-			GFP_NOFS);
-}
-
-static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached_state, gfp_t mask)
-{
-	return set_extent_bit(tree, start, end, EXTENT_UPTODATE, NULL,
-			      cached_state, mask);
-}
-
-int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, unsigned bits,
-			  struct extent_state **cached_state);
-void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, unsigned bits);
-int extent_invalidatepage(struct extent_io_tree *tree,
-			  struct page *page, unsigned long offset);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
@@ -555,7 +343,4 @@ bool find_lock_delalloc_range(struct inode *inode,
 #endif
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
-
-int __init extent_state_cache_init(void);
-void __cold extent_state_cache_exit(void);
 #endif
-- 
2.21.0

