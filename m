Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596E9262C80
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIJuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 05:50:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgIIJtW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 05:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD504B159;
        Wed,  9 Sep 2020 09:49:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/10] btrfs: Remove pg_offset from btrfs_get_extent
Date:   Wed,  9 Sep 2020 12:49:06 +0300
Message-Id: <20200909094914.29721-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909094914.29721-1-nborisov@suse.com>
References: <20200909094914.29721-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs doesn't support subpage blocksize io as such pg_offset is always
zero. Remove this argument to cleanup the parameter list.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h             |  3 +--
 fs/btrfs/disk-io.c           |  3 +--
 fs/btrfs/disk-io.h           |  3 +--
 fs/btrfs/extent_io.c         |  8 ++++---
 fs/btrfs/extent_io.h         |  4 ++--
 fs/btrfs/file.c              | 12 +++++------
 fs/btrfs/inode.c             | 28 +++++++++++-------------
 fs/btrfs/ioctl.c             |  2 +-
 fs/btrfs/tests/inode-tests.c | 42 ++++++++++++++++++------------------
 9 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 98c5f6178efc..7c7afa823f71 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3000,8 +3000,7 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 			      struct btrfs_root *root, struct btrfs_path *path);
 struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 end);
+				    struct page *page, u64 start, u64 end);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct inode *inode);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d63498f3c75f..c6c9b6b13bf0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -209,8 +209,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
  * that covers the entire device
  */
 struct extent_map *btree_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len)
+				    struct page *page, u64 start, u64 len)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 00dc39d47ed3..dbc8c353c86c 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -124,8 +124,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
 struct extent_map *btree_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len);
+				    struct page *page, u64 start, u64 len);
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1e070ec7ad8..ac92c0ab1402 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3127,7 +3127,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 		*em_cached = NULL;
 	}
 
-	em = get_extent(BTRFS_I(inode), page, pg_offset, start, len);
+	em = get_extent(BTRFS_I(inode), page, start, len);
 	if (em_cached && !IS_ERR_OR_NULL(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
@@ -3161,7 +3161,7 @@ static int __do_readpage(struct page *page,
 	int ret = 0;
 	int nr = 0;
 	size_t pg_offset = 0;
-	size_t iosize;
+	size_t iosize = 0;
 	size_t disk_io_size;
 	size_t blocksize = inode->i_sb->s_blocksize;
 	unsigned long this_bio_flag = 0;
@@ -3208,6 +3208,8 @@ static int __do_readpage(struct page *page,
 					     cur + iosize - 1, &cached);
 			break;
 		}
+		if (pg_offset != 0)
+			trace_printk("PG offset: %lu iosize: %lu\n", pg_offset, iosize);
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, get_extent, em_cached);
 		if (IS_ERR_OR_NULL(em)) {
@@ -3540,7 +3542,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 							     page_end, 1);
 			break;
 		}
-		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
+		em = btrfs_get_extent(inode, NULL, cur, end - cur + 1);
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
 			ret = PTR_ERR_OR_ZERO(em);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 06611947a9f7..41621731a4fe 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -187,8 +187,8 @@ static inline int extent_compress_type(unsigned long bio_flags)
 struct extent_map_tree;
 
 typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
-					  struct page *page, size_t pg_offset,
-					  u64 start, u64 len);
+					  struct page *page, u64 start,
+					  u64 len);
 
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index af4eab9cbc51..0020c6780035 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -466,7 +466,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		u64 em_len;
 		int ret = 0;
 
-		em = btrfs_get_extent(inode, NULL, 0, search_start, search_len);
+		em = btrfs_get_extent(inode, NULL, search_start, search_len);
 		if (IS_ERR(em))
 			return PTR_ERR(em);
 
@@ -2511,7 +2511,7 @@ static int find_first_non_hole(struct inode *inode, u64 *start, u64 *len)
 	struct extent_map *em;
 	int ret = 0;
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
+	em = btrfs_get_extent(BTRFS_I(inode), NULL,
 			      round_down(*start, fs_info->sectorsize),
 			      round_up(*len, fs_info->sectorsize));
 	if (IS_ERR(em))
@@ -3113,7 +3113,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	int ret;
 
 	offset = round_down(offset, sectorsize);
-	em = btrfs_get_extent(inode, NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(inode, NULL, offset, sectorsize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -3146,7 +3146,7 @@ static int btrfs_zero_range(struct inode *inode,
 
 	inode_dio_wait(inode);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start,
 			      alloc_end - alloc_start);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -3190,7 +3190,7 @@ static int btrfs_zero_range(struct inode *inode,
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start,
 				      sectorsize);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
@@ -3430,7 +3430,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	/* First, check if we exceed the qgroup limit */
 	INIT_LIST_HEAD(&reserve_list);
 	while (cur_offset < alloc_end) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, cur_offset,
 				      alloc_end - cur_offset);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cce6f8789a4e..a7b62b93246b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4722,7 +4722,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 					   block_end - 1, &cached_state);
 	cur_offset = hole_start;
 	while (1) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, cur_offset,
 				      block_end - cur_offset);
 		if (IS_ERR(em)) {
 			err = PTR_ERR(em);
@@ -6530,8 +6530,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
  * Return: ERR_PTR on error, non-NULL extent_map on success.
  */
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len)
+				    struct page *page, u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
@@ -6678,9 +6677,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 			goto out;
 
 		size = btrfs_file_extent_ram_bytes(leaf, item);
-		extent_offset = page_offset(page) + pg_offset - extent_start;
-		copy_size = min_t(u64, PAGE_SIZE - pg_offset,
-				  size - extent_offset);
+		extent_offset = page_offset(page) - extent_start;
+		copy_size = min_t(u64, PAGE_SIZE, size - extent_offset);
 		em->start = extent_start + extent_offset;
 		em->len = ALIGN(copy_size, fs_info->sectorsize);
 		em->orig_block_len = em->len;
@@ -6691,18 +6689,16 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		if (!PageUptodate(page)) {
 			if (btrfs_file_extent_compression(leaf, item) !=
 			    BTRFS_COMPRESS_NONE) {
-				ret = uncompress_inline(path, page, pg_offset,
+				ret = uncompress_inline(path, page, 0,
 							extent_offset, item);
 				if (ret)
 					goto out;
 			} else {
 				map = kmap(page);
-				read_extent_buffer(leaf, map + pg_offset, ptr,
-						   copy_size);
-				if (pg_offset + copy_size < PAGE_SIZE) {
-					memset(map + pg_offset + copy_size, 0,
-					       PAGE_SIZE - pg_offset -
-					       copy_size);
+				read_extent_buffer(leaf, map, ptr, copy_size);
+				if (copy_size < PAGE_SIZE) {
+					memset(map + copy_size, 0,
+					       PAGE_SIZE - copy_size);
 				}
 				kunmap(page);
 			}
@@ -6754,7 +6750,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 	u64 delalloc_end;
 	int err = 0;
 
-	em = btrfs_get_extent(inode, NULL, 0, start, len);
+	em = btrfs_get_extent(inode, NULL, start, len);
 	if (IS_ERR(em))
 		return em;
 	/*
@@ -7397,7 +7393,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		goto err;
 	}
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto unlock_err;
@@ -10044,7 +10040,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		struct btrfs_block_group *bg;
 		u64 len = isize - start;
 
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b31949df7bfc..31ebbe918156 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1162,7 +1162,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
 
 		/* get the big lock and read metadata off disk */
 		lock_extent_bits(io_tree, start, end, &cached);
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
 		unlock_extent_cached(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 894a63a92236..6bcb392e7367 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -263,7 +263,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 
 	/* First with no extents */
 	BTRFS_I(inode)->root = root;
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize);
 	if (IS_ERR(em)) {
 		em = NULL;
 		test_err("got an error when we shouldn't have");
@@ -283,7 +283,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 */
 	setup_file_extents(root, sectorsize);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, (u64)-1);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, (u64)-1);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -305,7 +305,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -333,7 +333,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -356,7 +356,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Regular extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -384,7 +384,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are split extents */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -413,7 +413,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -435,7 +435,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -469,7 +469,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -498,7 +498,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -528,7 +528,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -561,7 +561,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -596,7 +596,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Now for the compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -630,7 +630,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Split compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -665,7 +665,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -692,7 +692,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -727,7 +727,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -754,7 +754,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -787,7 +787,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -871,7 +871,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	insert_inode_item_key(root);
 	insert_extent(root, sectorsize, sectorsize, sectorsize, 0, sectorsize,
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, 1);
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, 2 * sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 2 * sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -893,7 +893,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	}
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize, 2 * sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, sectorsize, 2 * sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
-- 
2.17.1

