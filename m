Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EEEB558F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfIQSoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:44:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36824 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfIQSoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:44:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so14101qkc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fNzTjzeQY0QFU3S7mmuwxZfDcXCCVbDfHFYUaatK8aU=;
        b=KkCav0Rpz0g2h5/gjIQMnQ1/0Z1bT2BIYBNg9MFNQ/5H/O/3yydwal6UWLq4daF0/c
         H6qemT5IUvCKTHlc0of5KTrKX2AUu5z5sqkyDYvn9mBQKC089t6cR+Ei2XSQVXH6HaHR
         TSOdXHLgbnHmfh+gG3TXMKyxKmvX4oExyjEWFeHVB/AABEbzb7dYg/vHJMTTElETjfL0
         DAtomn9STUY3uv3MCGAgZxdItstRbl4Fl+kFuujp5Fn/Do+LTAR5iBk1ZOw/CBKqK5Be
         mV7PSj5t3j7y/UN6N8p7CjPkQmJu4UwLc5O7yQiBSIYWezlPPHMlHAHvTawAP7gJyMzK
         no5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNzTjzeQY0QFU3S7mmuwxZfDcXCCVbDfHFYUaatK8aU=;
        b=TKwjziXycqpWoDEZLHLy4uByJOspB9ae88+7gTi8hyzicZIH2lVlQvw0mBhFV9rsAY
         NBxQR/sam8gJDEhaW9QNcr20lODns+eFPh1eJC4msLuBGWHqaEJqSqTWHrMREDkqoQ6r
         URkWjd1rbJqx5FOoCk8zNmYv9LXtQGR8Ka/3V6+SM1YjH5prwPdhRe4JmJZKHclzaQTU
         x5ODaZWaofKPYmrYyqmiUetir/knX/AOKZQTsN1+Qg1fJ0fCal32A+6atfrd8eD9xF/r
         gh54iozIGhNFgJVp/1IAB6qCMbY9oTV8VUO/1Xb1oxIHkydmeISRC9AxAPIHZ76Dqf2e
         P4pA==
X-Gm-Message-State: APjAAAXn3zynVw8bDG6F7E4e8XO/LCgNwj2tdQdoKRuyRQ2LHkUX9vDv
        9ag7GoULdm4RSci2NsaL05rOKR581FOOTQ==
X-Google-Smtp-Source: APXvYqwLKQpZU7xnKrXBXe/NQnq0PZdo5JyShhKAmx6J8YEGVaaT7DpEbACMgDmp4mZN0sUi3AczbA==
X-Received: by 2002:a37:4cc7:: with SMTP id z190mr5447140qka.458.1568745841561;
        Tue, 17 Sep 2019 11:44:01 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v12sm2038402qtb.5.2019.09.17.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:44:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] btrfs: migrate the extent_buffer code out of extent-io.h
Date:   Tue, 17 Sep 2019 14:43:42 -0400
Message-Id: <20190917184344.13155-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917184344.13155-1-josef@toxicpanda.com>
References: <20190917184344.13155-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's two main things we do with extent buffers, we mess with the
buffers themselves, and then we do IO on those buffers.  Separate out
the actual extent buffer manipulation code from extent_io since they are
unrelated.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h         |   2 +-
 fs/btrfs/disk-io.h       |   2 +
 fs/btrfs/extent-buffer.h | 152 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h     | 148 +-------------------------------------
 4 files changed, 157 insertions(+), 147 deletions(-)
 create mode 100644 fs/btrfs/extent-buffer.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5e7ff169683c..c3a7df64db32 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -29,7 +29,7 @@
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
 #include "extent-io-tree.h"
-#include "extent_io.h"
+#include "extent-buffer.h"
 #include "extent_map.h"
 #include "async-thread.h"
 #include "block-rsv.h"
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a6958103d87e..affb45b1ed82 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_DISK_IO_H
 #define BTRFS_DISK_IO_H
 
+#include "extent_io.h"
+
 #define BTRFS_SUPER_INFO_OFFSET SZ_64K
 #define BTRFS_SUPER_INFO_SIZE 4096
 
diff --git a/fs/btrfs/extent-buffer.h b/fs/btrfs/extent-buffer.h
new file mode 100644
index 000000000000..8bb6b695b70f
--- /dev/null
+++ b/fs/btrfs/extent-buffer.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BTRFS_EXTENT_BUFFER_H
+#define BTRFS_EXTENT_BUFFER_H
+
+enum {
+	EXTENT_BUFFER_UPTODATE,
+	EXTENT_BUFFER_DIRTY,
+	EXTENT_BUFFER_CORRUPT,
+	/* this got triggered by readahead */
+	EXTENT_BUFFER_READAHEAD,
+	EXTENT_BUFFER_TREE_REF,
+	EXTENT_BUFFER_STALE,
+	EXTENT_BUFFER_WRITEBACK,
+	/* read IO error */
+	EXTENT_BUFFER_READ_ERR,
+	EXTENT_BUFFER_UNMAPPED,
+	EXTENT_BUFFER_IN_TREE,
+	/* write IO error */
+	EXTENT_BUFFER_WRITE_ERR,
+};
+
+#define INLINE_EXTENT_BUFFER_PAGES 16
+#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
+struct extent_buffer {
+	u64 start;
+	unsigned long len;
+	unsigned long bflags;
+	struct btrfs_fs_info *fs_info;
+	spinlock_t refs_lock;
+	atomic_t refs;
+	atomic_t io_pages;
+	int read_mirror;
+	struct rcu_head rcu_head;
+	pid_t lock_owner;
+
+	int blocking_writers;
+	atomic_t blocking_readers;
+	bool lock_nested;
+	/* >= 0 if eb belongs to a log tree, -1 otherwise */
+	short log_index;
+
+	/* protects write locks */
+	rwlock_t lock;
+
+	/* readers use lock_wq while they wait for the write
+	 * lock holders to unlock
+	 */
+	wait_queue_head_t write_lock_wq;
+
+	/* writers use read_lock_wq while they wait for readers
+	 * to unlock
+	 */
+	wait_queue_head_t read_lock_wq;
+	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+#ifdef CONFIG_BTRFS_DEBUG
+	int spinning_writers;
+	atomic_t spinning_readers;
+	atomic_t read_locks;
+	int write_locks;
+	struct list_head leak_list;
+#endif
+};
+
+/*
+ * The extent buffer bitmap operations are done with byte granularity instead of
+ * word granularity for two reasons:
+ * 1. The bitmaps must be little-endian on disk.
+ * 2. Bitmap items are not guaranteed to be aligned to a word and therefore a
+ *    single word in a bitmap may straddle two pages in the extent buffer.
+ */
+#define BIT_BYTE(nr) ((nr) / BITS_PER_BYTE)
+#define BYTE_MASK ((1 << BITS_PER_BYTE) - 1)
+#define BITMAP_FIRST_BYTE_MASK(start) \
+	((BYTE_MASK << ((start) & (BITS_PER_BYTE - 1))) & BYTE_MASK)
+#define BITMAP_LAST_BYTE_MASK(nbits) \
+	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
+
+int __init extent_buffer_init(void);
+void __cold extent_buffer_exit(void);
+int try_release_extent_buffer(struct page *page);
+struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
+					  u64 start);
+struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						  u64 start, unsigned long len);
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 start);
+struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
+					       u64 start);
+struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src);
+struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
+					 u64 start);
+void free_extent_buffer(struct extent_buffer *eb);
+void free_extent_buffer_stale(struct extent_buffer *eb);
+
+void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
+
+static inline int num_extent_pages(const struct extent_buffer *eb)
+{
+	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
+	       (eb->start >> PAGE_SHIFT);
+}
+
+static inline void extent_buffer_get(struct extent_buffer *eb)
+{
+	atomic_inc(&eb->refs);
+}
+
+static inline int extent_buffer_uptodate(struct extent_buffer *eb)
+{
+	return test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+}
+
+int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
+			 unsigned long start, unsigned long len);
+void read_extent_buffer(const struct extent_buffer *eb, void *dst,
+			unsigned long start,
+			unsigned long len);
+int read_extent_buffer_to_user(const struct extent_buffer *eb,
+			       void __user *dst, unsigned long start,
+			       unsigned long len);
+void write_extent_buffer_fsid(struct extent_buffer *eb, const void *src);
+void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
+		const void *src);
+void write_extent_buffer(struct extent_buffer *eb, const void *src,
+			 unsigned long start, unsigned long len);
+void copy_extent_buffer_full(struct extent_buffer *dst,
+			     struct extent_buffer *src);
+void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+			unsigned long dst_offset, unsigned long src_offset,
+			unsigned long len);
+void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+			   unsigned long src_offset, unsigned long len);
+void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+			   unsigned long src_offset, unsigned long len);
+void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
+			   unsigned long len);
+int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+			   unsigned long pos);
+void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
+			      unsigned long pos, unsigned long len);
+void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
+				unsigned long pos, unsigned long len);
+void clear_extent_buffer_dirty(struct extent_buffer *eb);
+bool set_extent_buffer_dirty(struct extent_buffer *eb);
+void set_extent_buffer_uptodate(struct extent_buffer *eb);
+void clear_extent_buffer_uptodate(struct extent_buffer *eb);
+int extent_buffer_under_io(struct extent_buffer *eb);
+int map_private_extent_buffer(const struct extent_buffer *eb,
+			      unsigned long offset, unsigned long min_len,
+			      char **map, unsigned long *map_start,
+			      unsigned long *map_len);
+#endif /* BTRFS_EXTENT_BUFFER_H */
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e2246956e544..c329eb3f1817 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -14,23 +14,6 @@
 #define EXTENT_BIO_COMPRESSED 1
 #define EXTENT_BIO_FLAG_SHIFT 16
 
-enum {
-	EXTENT_BUFFER_UPTODATE,
-	EXTENT_BUFFER_DIRTY,
-	EXTENT_BUFFER_CORRUPT,
-	/* this got triggered by readahead */
-	EXTENT_BUFFER_READAHEAD,
-	EXTENT_BUFFER_TREE_REF,
-	EXTENT_BUFFER_STALE,
-	EXTENT_BUFFER_WRITEBACK,
-	/* read IO error */
-	EXTENT_BUFFER_READ_ERR,
-	EXTENT_BUFFER_UNMAPPED,
-	EXTENT_BUFFER_IN_TREE,
-	/* write IO error */
-	EXTENT_BUFFER_WRITE_ERR,
-};
-
 /* these are flags for __process_pages_contig */
 #define PAGE_UNLOCK		(1 << 0)
 #define PAGE_CLEAR_DIRTY	(1 << 1)
@@ -46,25 +29,12 @@ enum {
  */
 #define EXTENT_PAGE_PRIVATE 1
 
-/*
- * The extent buffer bitmap operations are done with byte granularity instead of
- * word granularity for two reasons:
- * 1. The bitmaps must be little-endian on disk.
- * 2. Bitmap items are not guaranteed to be aligned to a word and therefore a
- *    single word in a bitmap may straddle two pages in the extent buffer.
- */
-#define BIT_BYTE(nr) ((nr) / BITS_PER_BYTE)
-#define BYTE_MASK ((1 << BITS_PER_BYTE) - 1)
-#define BITMAP_FIRST_BYTE_MASK(start) \
-	((BYTE_MASK << ((start) & (BITS_PER_BYTE - 1))) & BYTE_MASK)
-#define BITMAP_LAST_BYTE_MASK(nbits) \
-	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
-
 struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
 struct io_failure_record;
 struct extent_io_tree;
+struct extent_buffer;
 
 typedef blk_status_t (extent_submit_bio_start_t)(void *private_data,
 		struct bio *bio, u64 bio_offset);
@@ -81,49 +51,6 @@ struct extent_io_ops {
 				    int mirror);
 };
 
-
-#define INLINE_EXTENT_BUFFER_PAGES 16
-#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
-struct extent_buffer {
-	u64 start;
-	unsigned long len;
-	unsigned long bflags;
-	struct btrfs_fs_info *fs_info;
-	spinlock_t refs_lock;
-	atomic_t refs;
-	atomic_t io_pages;
-	int read_mirror;
-	struct rcu_head rcu_head;
-	pid_t lock_owner;
-
-	int blocking_writers;
-	atomic_t blocking_readers;
-	bool lock_nested;
-	/* >= 0 if eb belongs to a log tree, -1 otherwise */
-	short log_index;
-
-	/* protects write locks */
-	rwlock_t lock;
-
-	/* readers use lock_wq while they wait for the write
-	 * lock holders to unlock
-	 */
-	wait_queue_head_t write_lock_wq;
-
-	/* writers use read_lock_wq while they wait for readers
-	 * to unlock
-	 */
-	wait_queue_head_t read_lock_wq;
-	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
-#ifdef CONFIG_BTRFS_DEBUG
-	int spinning_writers;
-	atomic_t spinning_readers;
-	atomic_t read_locks;
-	int write_locks;
-	struct list_head leak_list;
-#endif
-};
-
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
@@ -189,7 +116,6 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 					  int create);
 
 int try_release_extent_mapping(struct page *page, gfp_t mask);
-int try_release_extent_buffer(struct page *page);
 
 int extent_read_full_page(struct extent_io_tree *tree, struct page *page,
 			  get_extent_t *get_extent, int mirror_num);
@@ -206,79 +132,13 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
 void set_page_extent_mapped(struct page *page);
 
-struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
-					  u64 start);
-struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						  u64 start, unsigned long len);
-struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						u64 start);
-struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src);
-struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
-					 u64 start);
-void free_extent_buffer(struct extent_buffer *eb);
-void free_extent_buffer_stale(struct extent_buffer *eb);
 #define WAIT_NONE	0
 #define WAIT_COMPLETE	1
 #define WAIT_PAGE_LOCK	2
+
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait,
 			     int mirror_num);
-void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
-
-static inline int num_extent_pages(const struct extent_buffer *eb)
-{
-	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
-	       (eb->start >> PAGE_SHIFT);
-}
-
-static inline void extent_buffer_get(struct extent_buffer *eb)
-{
-	atomic_inc(&eb->refs);
-}
-
-static inline int extent_buffer_uptodate(struct extent_buffer *eb)
-{
-	return test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-}
 
-int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
-			 unsigned long start, unsigned long len);
-void read_extent_buffer(const struct extent_buffer *eb, void *dst,
-			unsigned long start,
-			unsigned long len);
-int read_extent_buffer_to_user(const struct extent_buffer *eb,
-			       void __user *dst, unsigned long start,
-			       unsigned long len);
-void write_extent_buffer_fsid(struct extent_buffer *eb, const void *src);
-void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
-		const void *src);
-void write_extent_buffer(struct extent_buffer *eb, const void *src,
-			 unsigned long start, unsigned long len);
-void copy_extent_buffer_full(struct extent_buffer *dst,
-			     struct extent_buffer *src);
-void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
-			unsigned long dst_offset, unsigned long src_offset,
-			unsigned long len);
-void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len);
-void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len);
-void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
-			   unsigned long len);
-int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
-			   unsigned long pos);
-void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
-			      unsigned long pos, unsigned long len);
-void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
-				unsigned long pos, unsigned long len);
-void clear_extent_buffer_dirty(struct extent_buffer *eb);
-bool set_extent_buffer_dirty(struct extent_buffer *eb);
-void set_extent_buffer_uptodate(struct extent_buffer *eb);
-void clear_extent_buffer_uptodate(struct extent_buffer *eb);
-int extent_buffer_under_io(struct extent_buffer *eb);
-int map_private_extent_buffer(const struct extent_buffer *eb,
-			      unsigned long offset, unsigned long min_len,
-			      char **map, unsigned long *map_start,
-			      unsigned long *map_len);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
@@ -330,8 +190,4 @@ bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
 			     u64 *end);
 #endif
-struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
-					       u64 start);
-int __init extent_buffer_init(void);
-void __cold extent_buffer_exit(void);
 #endif
-- 
2.21.0

