Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C510F48E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLCBem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:42 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43723 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLCBem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so731759pjs.10
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z01WoYvrTEc2OUV6ITjBtBaZjRfvvPC11GlOVbz5KM=;
        b=dP+q/yOVVk/LQzHM5txy6W2okmqDctVG7qp7F+cSVr7f+KqkBllrPr4vs6w1E8SLui
         jOtIQ+09hUxygcVbocVThyA4eLo3UUO7wy7PSubw+H+jqkXyvxCFnfrwoK6O85MpCFy8
         kmQJDivD2FJ54U22rvN/JVZLYvonyfMZotW3GtNRHAQsxkcsct9qjyt3VK4WHPbaS93t
         JdJNe7FaqePAYpG4abB3xDDNknTOC/Q/z4NAMVB/OlZ/qYEJiys8Srz8zeumJOsBY+Oz
         yerePqxWXBaxeNbmgkwFVQB5OwCgrgm1Y51ZZ9AjwtXa8ECeifgf3XlT0ePsL0jPd1N5
         xMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z01WoYvrTEc2OUV6ITjBtBaZjRfvvPC11GlOVbz5KM=;
        b=jYnrJ3ga1hE5pBFfGGahhfDWQx8jKbszUviaaqUkQy7Q5iPL4JyqfhwQPIy6MwtO3s
         bXt2mmbjDfo5wvDYWXWwURk8EIfdNYF/2VyktzJTdindKbvPRgcRzKEaa/BI1rLOqEYB
         qeY1WuYV8nJ2mtzR72Av4txAvWgTfmJX1eb8JPlksDDaUCHfmpN0RXC7fQZ2L9aKTvqB
         hsvoB6e1ex2WffrCJ24wBAJLM4RQQivNUih7g8qbVCcaQGljSJVXeCKFLDe2JEs3uJLB
         oxxyalkiT6cTXWdqsFR2GPJPKfdrQ9M/w0yRwN//IxUvL7uKImRCLU0IegotothvmND4
         xIww==
X-Gm-Message-State: APjAAAVnzTWYnEyeT8Pb6A3ke2cpTw2PhEQDUBrn0xQ+cCsmxp8ma7+8
        5lF6CWVwVoC3/m3JbmZUwcDBDKdktSYOEA==
X-Google-Smtp-Source: APXvYqyisC41XkUCkUgbHNcjjfQ3Fdgnx9vk1dyZa23Nj804mk9+lpIwsMMx4pslLrWSzfYoTTEVxA==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr2273927pls.98.1575336880799;
        Mon, 02 Dec 2019 17:34:40 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:40 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: drop create parameter to btrfs_get_extent()
Date:   Mon,  2 Dec 2019 17:34:23 -0800
Message-Id: <3012e96179bf1427eca8e26332c7c4475f31c76b.1575336816.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575336815.git.osandov@fb.com>
References: <cover.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We only pass this as 1 from __extent_writepage_io(). The parameter
basically means "pretend I didn't pass in a page". This is silly since
we can simply not pass in the page. Get rid of the parameter from
btrfs_get_extent(), and since it's used as a get_extent_t callback,
remove it from get_extent_t and btree_get_extent(), neither of which
need it.

While we're here, let's document btrfs_get_extent().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/disk-io.c   |  4 ++--
 fs/btrfs/disk-io.h   |  4 ++--
 fs/btrfs/extent_io.c |  6 +++---
 fs/btrfs/extent_io.h |  6 ++----
 fs/btrfs/file.c      | 17 ++++++++---------
 fs/btrfs/inode.c     | 41 ++++++++++++++++++++++++-----------------
 fs/btrfs/ioctl.c     |  2 +-
 8 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5ad45171e482..7a8209b17b3d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2875,7 +2875,7 @@ struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 			 struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
-				    u64 start, u64 end, int create);
+				    u64 start, u64 end);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct inode *inode);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab888d89d844..881aba162e4e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -202,8 +202,8 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
  * that covers the entire device
  */
 struct extent_map *btree_get_extent(struct btrfs_inode *inode,
-		struct page *page, size_t pg_offset, u64 start, u64 len,
-		int create)
+				    struct page *page, size_t pg_offset,
+				    u64 start, u64 len)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 76f123ebb292..8c2d6cf1ce59 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -134,8 +134,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
 struct extent_map *btree_get_extent(struct btrfs_inode *inode,
-		struct page *page, size_t pg_offset, u64 start, u64 len,
-		int create);
+				    struct page *page, size_t pg_offset,
+				    u64 start, u64 len);
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 635f5d2954a4..13c03c42ba5c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3043,7 +3043,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 		*em_cached = NULL;
 	}
 
-	em = get_extent(BTRFS_I(inode), page, pg_offset, start, len, 0);
+	em = get_extent(BTRFS_I(inode), page, pg_offset, start, len);
 	if (em_cached && !IS_ERR_OR_NULL(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
@@ -3466,8 +3466,8 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 							     page_end, 1);
 			break;
 		}
-		em = btrfs_get_extent(BTRFS_I(inode), page, pg_offset, cur,
-				     end - cur + 1, 1);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur,
+				      end - cur + 1);
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
 			ret = PTR_ERR_OR_ZERO(em);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a8551a1f56e2..5d205bbaafdc 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -183,10 +183,8 @@ static inline int extent_compress_type(unsigned long bio_flags)
 struct extent_map_tree;
 
 typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
-					  struct page *page,
-					  size_t pg_offset,
-					  u64 start, u64 len,
-					  int create);
+					  struct page *page, size_t pg_offset,
+					  u64 start, u64 len);
 
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 568b6391c719..c7efc0b04c62 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -477,8 +477,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		u64 em_len;
 		int ret = 0;
 
-		em = btrfs_get_extent(inode, NULL, 0, search_start,
-				      search_len, 0);
+		em = btrfs_get_extent(inode, NULL, 0, search_start, search_len);
 		if (IS_ERR(em))
 			return PTR_ERR(em);
 
@@ -2390,7 +2389,7 @@ static int find_first_non_hole(struct inode *inode, u64 *start, u64 *len)
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
 			      round_down(*start, fs_info->sectorsize),
-			      round_up(*len, fs_info->sectorsize), 0);
+			      round_up(*len, fs_info->sectorsize));
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -2957,7 +2956,7 @@ static int btrfs_zero_range_check_range_boundary(struct inode *inode,
 	int ret;
 
 	offset = round_down(offset, sectorsize);
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -2990,8 +2989,8 @@ static int btrfs_zero_range(struct inode *inode,
 
 	inode_dio_wait(inode);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
-			      alloc_start, alloc_end - alloc_start, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
+			      alloc_end - alloc_start);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out;
@@ -3034,8 +3033,8 @@ static int btrfs_zero_range(struct inode *inode,
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
-				      alloc_start, sectorsize, 0);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
+				      sectorsize);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -3273,7 +3272,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	INIT_LIST_HEAD(&reserve_list);
 	while (cur_offset < alloc_end) {
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
-				      alloc_end - cur_offset, 0);
+				      alloc_end - cur_offset);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			break;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7fe400d18d60..2145543b2425 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4478,7 +4478,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 	cur_offset = hole_start;
 	while (1) {
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
-				block_end - cur_offset, 0);
+				      block_end - cur_offset);
 		if (IS_ERR(em)) {
 			err = PTR_ERR(em);
 			em = NULL;
@@ -6253,18 +6253,27 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	return ret;
 }
 
-/*
- * a bit scary, this does extent mapping from logical file offset to the disk.
- * the ugly parts come from merging extents from the disk with the in-ram
- * representation.  This gets more complex because of the data=ordered code,
- * where the in-ram extents might be locked pending data=ordered completion.
+/**
+ * btrfs_get_extent - Lookup the first extent overlapping a range in a file.
+ * @inode: File to search in.
+ * @page: Page to read extent data into if the extent is inline.
+ * @pg_offset: Offset into @page to copy to.
+ * @start: File offset.
+ * @len: Length of range starting at @start.
+ *
+ * This returns the first &struct extent_map which overlaps with the given
+ * range, reading it from the B-tree and caching it if necessary. Note that
+ * there may be more extents which overlap the given range after the returned
+ * extent_map.
  *
- * This also copies inline extents directly into the page.
+ * If @page is not NULL and the extent is inline, this also reads the extent
+ * data directly into the page and marks the extent up to date in the io_tree.
+ *
+ * Return: ERR_PTR on error, non-NULL extent_map on success.
  */
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page,
-				    size_t pg_offset, u64 start, u64 len,
-				    int create)
+				    struct page *page, size_t pg_offset,
+				    u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret;
@@ -6281,7 +6290,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	struct extent_map *em = NULL;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	const bool new_inline = !page || create;
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -6404,8 +6412,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 
-	btrfs_extent_item_to_extent_map(inode, path, item,
-			new_inline, em);
+	btrfs_extent_item_to_extent_map(inode, path, item, !page, em);
 
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -6417,7 +6424,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		size_t extent_offset;
 		size_t copy_size;
 
-		if (new_inline)
+		if (!page)
 			goto out;
 
 		size = btrfs_file_extent_ram_bytes(leaf, item);
@@ -6500,7 +6507,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 	u64 delalloc_end;
 	int err = 0;
 
-	em = btrfs_get_extent(inode, NULL, 0, start, len, 0);
+	em = btrfs_get_extent(inode, NULL, 0, start, len);
 	if (IS_ERR(em))
 		return em;
 	/*
@@ -7125,7 +7132,7 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		goto err;
 	}
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len, 0);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto unlock_err;
@@ -10153,7 +10160,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		struct btrfs_block_group *bg;
 		u64 len = isize - start;
 
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len, 0);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1ee0b775e65..00452b98e9f5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1122,7 +1122,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
 
 		/* get the big lock and read metadata off disk */
 		lock_extent_bits(io_tree, start, end, &cached);
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len, 0);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
 		unlock_extent_cached(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
-- 
2.24.0

