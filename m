Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A81C9C24
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEGUUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgEGUUu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FC24AC6C;
        Thu,  7 May 2020 20:20:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4BE81DA732; Thu,  7 May 2020 22:19:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 13/19] btrfs: constify extent_buffer in the API functions
Date:   Thu,  7 May 2020 22:19:58 +0200
Message-Id: <a4eda1c6d165edb24abe428af456fb224dd5e67d.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are many helpers around extent buffers, found in extent_io.h and
ctree.h. Most of them can be converted to take constified eb as there
are no changes to the extent buffer structure itself but rather the
pages.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h        | 28 +++++++++++++-------------
 fs/btrfs/extent_io.c    | 44 ++++++++++++++++++++++-------------------
 fs/btrfs/extent_io.h    | 44 ++++++++++++++++++++++-------------------
 fs/btrfs/struct-funcs.c |  2 +-
 4 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fbe2f9fa9f3e..944775bef6f3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1384,7 +1384,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    u##bits val);				\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off);		\
-void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
+void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val);
 
 DECLARE_BTRFS_SETGET_BITS(8)
@@ -1399,7 +1399,7 @@ static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
 	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
 	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
 }									\
-static inline void btrfs_set_##name(struct extent_buffer *eb, type *s,	\
+static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 				    u##bits val)			\
 {									\
 	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
@@ -1425,7 +1425,7 @@ static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
 	u##bits res = le##bits##_to_cpu(p->member);			\
 	return res;							\
 }									\
-static inline void btrfs_set_##name(struct extent_buffer *eb,		\
+static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
 				    u##bits val)			\
 {									\
 	type *p = page_address(eb->pages[0]);				\
@@ -1443,7 +1443,7 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 }
 
 
-static inline u64 btrfs_device_total_bytes(struct extent_buffer *eb,
+static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
 	BUILD_BUG_ON(sizeof(u64) !=
@@ -1451,7 +1451,7 @@ static inline u64 btrfs_device_total_bytes(struct extent_buffer *eb,
 	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
 					    total_bytes));
 }
-static inline void btrfs_set_device_total_bytes(struct extent_buffer *eb,
+static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 						struct btrfs_dev_item *s,
 						u64 val)
 {
@@ -1555,13 +1555,13 @@ static inline char *btrfs_stripe_dev_uuid_nr(struct btrfs_chunk *c, int nr)
 	return btrfs_stripe_dev_uuid(btrfs_stripe_nr(c, nr));
 }
 
-static inline u64 btrfs_stripe_offset_nr(struct extent_buffer *eb,
+static inline u64 btrfs_stripe_offset_nr(const struct extent_buffer *eb,
 					 struct btrfs_chunk *c, int nr)
 {
 	return btrfs_stripe_offset(eb, btrfs_stripe_nr(c, nr));
 }
 
-static inline u64 btrfs_stripe_devid_nr(struct extent_buffer *eb,
+static inline u64 btrfs_stripe_devid_nr(const struct extent_buffer *eb,
 					 struct btrfs_chunk *c, int nr)
 {
 	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
@@ -1658,14 +1658,14 @@ BTRFS_SETGET_FUNCS(extent_refs_v0, struct btrfs_extent_item_v0, refs, 32);
 
 BTRFS_SETGET_FUNCS(tree_block_level, struct btrfs_tree_block_info, level, 8);
 
-static inline void btrfs_tree_block_key(struct extent_buffer *eb,
+static inline void btrfs_tree_block_key(const struct extent_buffer *eb,
 					struct btrfs_tree_block_info *item,
 					struct btrfs_disk_key *key)
 {
 	read_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
 }
 
-static inline void btrfs_set_tree_block_key(struct extent_buffer *eb,
+static inline void btrfs_set_tree_block_key(const struct extent_buffer *eb,
 					    struct btrfs_tree_block_info *item,
 					    struct btrfs_disk_key *key)
 {
@@ -1717,7 +1717,7 @@ BTRFS_SETGET_STACK_FUNCS(stack_key_blockptr, struct btrfs_key_ptr,
 BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
 			 generation, 64);
 
-static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
+static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
 {
 	unsigned long ptr;
 	ptr = offsetof(struct btrfs_node, ptrs) +
@@ -1725,7 +1725,7 @@ static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
 	return btrfs_key_blockptr(eb, (struct btrfs_key_ptr *)ptr);
 }
 
-static inline void btrfs_set_node_blockptr(struct extent_buffer *eb,
+static inline void btrfs_set_node_blockptr(const struct extent_buffer *eb,
 					   int nr, u64 val)
 {
 	unsigned long ptr;
@@ -1734,7 +1734,7 @@ static inline void btrfs_set_node_blockptr(struct extent_buffer *eb,
 	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
 }
 
-static inline u64 btrfs_node_ptr_generation(struct extent_buffer *eb, int nr)
+static inline u64 btrfs_node_ptr_generation(const struct extent_buffer *eb, int nr)
 {
 	unsigned long ptr;
 	ptr = offsetof(struct btrfs_node, ptrs) +
@@ -1742,7 +1742,7 @@ static inline u64 btrfs_node_ptr_generation(struct extent_buffer *eb, int nr)
 	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
 }
 
-static inline void btrfs_set_node_ptr_generation(struct extent_buffer *eb,
+static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
 						 int nr, u64 val)
 {
 	unsigned long ptr;
@@ -1760,7 +1760,7 @@ static inline unsigned long btrfs_node_key_ptr_offset(int nr)
 void btrfs_node_key(const struct extent_buffer *eb,
 		    struct btrfs_disk_key *disk_key, int nr);
 
-static inline void btrfs_set_node_key(struct extent_buffer *eb,
+static inline void btrfs_set_node_key(const struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
 {
 	unsigned long ptr;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 67ee46a0a9c8..da6f0c1ed80c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2333,7 +2333,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	return 0;
 }
 
-int btrfs_repair_eb_io_failure(struct extent_buffer *eb, int mirror_num)
+int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 start = eb->start;
@@ -4910,7 +4910,7 @@ static void __free_extent_buffer(struct extent_buffer *eb)
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
-int extent_buffer_under_io(struct extent_buffer *eb)
+int extent_buffer_under_io(const struct extent_buffer *eb)
 {
 	return (atomic_read(&eb->io_pages) ||
 		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
@@ -5018,7 +5018,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	return eb;
 }
 
-struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src)
+struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	int i;
 	struct page *p;
@@ -5424,7 +5424,7 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	release_extent_buffer(eb);
 }
 
-void clear_extent_buffer_dirty(struct extent_buffer *eb)
+void clear_extent_buffer_dirty(const struct extent_buffer *eb)
 {
 	int i;
 	int num_pages;
@@ -5720,7 +5720,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	return ret;
 }
 
-void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
+void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *srcv)
 {
 	char *kaddr;
@@ -5731,7 +5731,7 @@ void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
 			BTRFS_FSID_SIZE);
 }
 
-void write_extent_buffer_fsid(struct extent_buffer *eb, const void *srcv)
+void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 {
 	char *kaddr;
 
@@ -5741,7 +5741,7 @@ void write_extent_buffer_fsid(struct extent_buffer *eb, const void *srcv)
 			BTRFS_FSID_SIZE);
 }
 
-void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
+void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 			 unsigned long start, unsigned long len)
 {
 	size_t cur;
@@ -5772,7 +5772,7 @@ void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
 	}
 }
 
-void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
+void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 		unsigned long len)
 {
 	size_t cur;
@@ -5801,8 +5801,8 @@ void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
 	}
 }
 
-void copy_extent_buffer_full(struct extent_buffer *dst,
-			     struct extent_buffer *src)
+void copy_extent_buffer_full(const struct extent_buffer *dst,
+			     const struct extent_buffer *src)
 {
 	int i;
 	int num_pages;
@@ -5815,7 +5815,8 @@ void copy_extent_buffer_full(struct extent_buffer *dst,
 				page_address(src->pages[i]));
 }
 
-void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+void copy_extent_buffer(const struct extent_buffer *dst,
+			const struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len)
 {
@@ -5860,7 +5861,7 @@ void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
  * This helper hides the ugliness of finding the byte in an extent buffer which
  * contains a given bit.
  */
-static inline void eb_bitmap_offset(struct extent_buffer *eb,
+static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 				    unsigned long start, unsigned long nr,
 				    unsigned long *page_index,
 				    size_t *page_offset)
@@ -5886,7 +5887,7 @@ static inline void eb_bitmap_offset(struct extent_buffer *eb,
  * @start: offset of the bitmap item in the extent buffer
  * @nr: bit number to test
  */
-int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr)
 {
 	u8 *kaddr;
@@ -5908,7 +5909,7 @@ int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
  * @pos: bit number of the first bit
  * @len: number of bits to set
  */
-void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
+void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
 			      unsigned long pos, unsigned long len)
 {
 	u8 *kaddr;
@@ -5950,8 +5951,9 @@ void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
  * @pos: bit number of the first bit
  * @len: number of bits to clear
  */
-void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
-				unsigned long pos, unsigned long len)
+void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
+				unsigned long start, unsigned long pos,
+				unsigned long len)
 {
 	u8 *kaddr;
 	struct page *page;
@@ -6012,8 +6014,9 @@ static void copy_pages(struct page *dst_page, struct page *src_page,
 		memcpy(dst_kaddr + dst_off, src_kaddr + src_off, len);
 }
 
-void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len)
+void memcpy_extent_buffer(const struct extent_buffer *dst,
+			  unsigned long dst_offset, unsigned long src_offset,
+			  unsigned long len)
 {
 	struct btrfs_fs_info *fs_info = dst->fs_info;
 	size_t cur;
@@ -6057,8 +6060,9 @@ void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
 	}
 }
 
-void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len)
+void memmove_extent_buffer(const struct extent_buffer *dst,
+			   unsigned long dst_offset, unsigned long src_offset,
+			   unsigned long len)
 {
 	struct btrfs_fs_info *fs_info = dst->fs_info;
 	size_t cur;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9ed89c01e2da..9a10681b12bf 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -213,7 +213,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						  u64 start, unsigned long len);
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						u64 start);
-struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src);
+struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src);
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 start);
 void free_extent_buffer(struct extent_buffer *eb);
@@ -231,7 +231,7 @@ static inline int num_extent_pages(const struct extent_buffer *eb)
 	       (eb->start >> PAGE_SHIFT);
 }
 
-static inline int extent_buffer_uptodate(struct extent_buffer *eb)
+static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
 {
 	return test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 }
@@ -244,33 +244,37 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 int read_extent_buffer_to_user(const struct extent_buffer *eb,
 			       void __user *dst, unsigned long start,
 			       unsigned long len);
-void write_extent_buffer_fsid(struct extent_buffer *eb, const void *src);
-void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
+void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *src);
+void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *src);
-void write_extent_buffer(struct extent_buffer *eb, const void *src,
+void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len);
-void copy_extent_buffer_full(struct extent_buffer *dst,
-			     struct extent_buffer *src);
-void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+void copy_extent_buffer_full(const struct extent_buffer *dst,
+			     const struct extent_buffer *src);
+void copy_extent_buffer(const struct extent_buffer *dst,
+			const struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len);
-void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len);
-void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len);
-void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
+void memcpy_extent_buffer(const struct extent_buffer *dst,
+			  unsigned long dst_offset, unsigned long src_offset,
+			  unsigned long len);
+void memmove_extent_buffer(const struct extent_buffer *dst,
+			   unsigned long dst_offset, unsigned long src_offset,
 			   unsigned long len);
-int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
+			   unsigned long len);
+int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long pos);
-void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
+void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
 			      unsigned long pos, unsigned long len);
-void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
-				unsigned long pos, unsigned long len);
-void clear_extent_buffer_dirty(struct extent_buffer *eb);
+void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
+				unsigned long start, unsigned long pos,
+				unsigned long len);
+void clear_extent_buffer_dirty(const struct extent_buffer *eb);
 bool set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
-int extent_buffer_under_io(struct extent_buffer *eb);
+int extent_buffer_under_io(const struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
@@ -289,7 +293,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
 		      unsigned int pg_offset, int mirror_num);
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
-int btrfs_repair_eb_io_failure(struct extent_buffer *eb, int mirror_num);
+int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
 
 /*
  * When IO fails, either with EIO or csum verification fails, we
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 67dfd1287c3e..0b23aa0a32d5 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -131,7 +131,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	leres = cpu_to_le##bits(val);					\
 	write_extent_buffer(token->eb, &leres, member_offset, size);	\
 }									\
-void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
+void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-- 
2.25.0

