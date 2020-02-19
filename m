Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1F164651
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBSOGT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSOGS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:06:18 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62DC82176D
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582121177;
        bh=0j+a2VxnbD+puWon/BFB+1f3+XfA8EBpDrobuwqoEv4=;
        h=From:To:Subject:Date:From;
        b=n86jIMt6c4PKlX+XVhYXuUkNdDmyC2giJaBTOo/jGaNp0mc3MBYT3US7RRIjKvYpQ
         tmUdQmeCoTKcvzQEVc9ZceGr4Y/Bx9WdIxfn5lEroAvphBqSic3qdT9w2nuWnatevo
         4Ay8x2wfe70zVIVhh3Zoz9aXVs1NNQ1SBIOAQDeA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] Btrfs: implement full reflink support for inline extents
Date:   Wed, 19 Feb 2020 14:06:15 +0000
Message-Id: <20200219140615.1641680-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are a few cases where we don't allow cloning an inline extent into
the destination inode, returning -EOPNOTSUPP to user space. This was done
to prevent several types of file corruption and because it's not very
straightforward to deal with these cases, as they can't rely on simply
copying the inline extent between leaves. Such cases require copying the
inline extent's data into the respective page of the destination inode.

Not supporting these cases makes it harder and more cumbersome to write
applications/libraries that work on any filesystem with reflink support,
since all these cases for which btrfs fails with -EOPNOTSUPP work just
fine on xfs for example. These unsupported cases are also not documented
anywhere and explaining which exact cases fail require a bit of too
technical understanding of btrfs's internal (inline extents and when and
where can they exist in a file), so it's not really user friendly.

Also some test cases from fstests that use fsx, such as generic/522 for
example, can sporadically fail because they trigger one of these cases,
and fsx expects all operations to succeed.

This change adds supports for cloning all these cases by copying the
inline extent's data into the respective page of the destination inode.

With this change test case btrfs/112 from fstests fails because it
expects some clone operations to fail, so it will be updated. Also a
new test case that exercises all these previously unsupported cases
will be added to fstests.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 212 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 152 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 7e7f46116db3..c19c87de6d4a 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/iversion.h>
+#include <linux/blkdev.h>
 #include "misc.h"
 #include "ctree.h"
+#include "btrfs_inode.h"
+#include "compression.h"
+#include "delalloc-space.h"
 #include "transaction.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
@@ -43,30 +47,121 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int copy_inline_to_page(struct inode *inode,
+			       const u64 file_offset,
+			       char *inline_data,
+			       const u64 size,
+			       const u64 datal,
+			       const u8 comp_type)
+{
+	const u64 block_size = btrfs_inode_sectorsize(inode);
+	const u64 range_end = file_offset + block_size - 1;
+	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
+	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
+	struct extent_changeset *data_reserved = NULL;
+	struct page *page = NULL;
+	bool page_locked = false;
+	int ret;
+
+	ASSERT(IS_ALIGNED(file_offset, block_size));
+
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, file_offset,
+					   block_size);
+	if (ret)
+		goto out;
+again:
+	page = find_or_create_page(inode->i_mapping, file_offset >> PAGE_SHIFT,
+				   btrfs_alloc_write_mask(inode->i_mapping));
+	if (!page) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+	page_locked = true;
+	if (!PageUptodate(page)) {
+		ret = extent_read_full_page_nolock(page, btrfs_get_extent, 0);
+		/* even on error, page is unlocked */
+		if (ret) {
+			page_locked = false;
+			goto out_unlock;
+		}
+		lock_page(page);
+		if (page->mapping != inode->i_mapping) {
+			unlock_page(page);
+			put_page(page);
+			page_locked = false;
+			goto again;
+		}
+		if (!PageUptodate(page)) {
+			ret = -EIO;
+			goto out_unlock;
+		}
+	}
+
+	set_page_extent_mapped(page);
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, file_offset, range_end,
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			 0, 0, NULL);
+	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
+	if (ret)
+		goto out_unlock;
+
+	if (comp_type == BTRFS_COMPRESS_NONE) {
+		char *map;
+
+		map = kmap(page);
+		memcpy(map, data_start, datal);
+		flush_dcache_page(page);
+		kunmap(page);
+	} else {
+		ret = btrfs_decompress(comp_type, data_start, page, 0,
+				       inline_size, datal);
+		if (ret)
+			goto out_unlock;
+		flush_dcache_page(page);
+	}
+
+	/*
+	 * If our inline data is smaller then the block/page size, then the
+	 * remaining of the block/page is equivalent to zeroes. We had something
+	 * like the following done:
+	 *
+	 * $ xfs_io -f -c "pwrite -S 0xab 0 500" file
+	 * $ sync  # (or fsync)
+	 * $ xfs_io -c "falloc 0 4K" file
+	 * $ xfs_io -c "pwrite -S 0xcd 4K 4K"
+	 *
+	 * So what's in the range [500, 4095] corresponds to zeroes.
+	 */
+	if (datal < block_size) {
+		char *map;
+
+		map = kmap(page);
+		memset(map + datal, 0, block_size - datal);
+		flush_dcache_page(page);
+		kunmap(page);
+	}
+
+	ClearPageChecked(page);
+	set_page_dirty(page);
+out_unlock:
+	if (page && page_locked)
+		unlock_page(page);
+	if (page)
+		put_page(page);
+	if (ret)
+		btrfs_delalloc_release_space(inode, data_reserved, file_offset,
+					     block_size, true);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), block_size);
+out:
+	extent_changeset_free(data_reserved);
+
+	return ret;
+}
+
 /*
- * Make sure we do not end up inserting an inline extent into a file that has
- * already other (non-inline) extents. If a file has an inline extent it can
- * not have any other extents and the (single) inline extent must start at the
- * file offset 0. Failing to respect these rules will lead to file corruption,
- * resulting in EIO errors on read/write operations, hitting BUG_ON's in mm, etc
- *
- * We can have extents that have been already written to disk or we can have
- * dirty ranges still in delalloc, in which case the extent maps and items are
- * created only when we run delalloc, and the delalloc ranges might fall outside
- * the range we are currently locking in the inode's io tree. So we check the
- * inode's i_size because of that (i_size updates are done while holding the
- * i_mutex, which we are holding here).
- * We also check to see if the inode has a size not greater than "datal" but has
- * extents beyond it, due to an fallocate with FALLOC_FL_KEEP_SIZE (and we are
- * protected against such concurrent fallocate calls by the i_mutex).
- *
- * If the file has no extents but a size greater than datal, do not allow the
- * copy because we would need turn the inline extent into a non-inline one (even
- * with NO_HOLES enabled). If we find our destination inode only has one inline
- * extent, just overwrite it with the source inline extent if its size is less
- * than the source extent's size, or we could copy the source inline extent's
- * data into the destination inode's inline extent if the later is greater then
- * the former.
+ * Deal with cloning of inline extents. We try to copy the inline extent from
+ * the source inode to destination inode when possible. When not possible we
+ * the inline extent's data into the respective page of the destination inode.
  */
 static int clone_copy_inline_extent(struct inode *dst,
 				    struct btrfs_trans_handle *trans,
@@ -75,7 +170,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 				    const u64 drop_start,
 				    const u64 datal,
 				    const u64 size,
-				    const char *inline_data)
+				    const u8 comp_type,
+				    char *inline_data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dst->i_sb);
 	struct btrfs_root *root = BTRFS_I(dst)->root;
@@ -85,7 +181,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 	struct btrfs_key key;
 
 	if (new_key->offset > 0)
-		return -EOPNOTSUPP;
+		return copy_inline_to_page(dst, new_key->offset, inline_data,
+					   size, datal, comp_type);
 
 	key.objectid = btrfs_ino(BTRFS_I(dst));
 	key.type = BTRFS_EXTENT_DATA_KEY;
@@ -104,42 +201,31 @@ static int clone_copy_inline_extent(struct inode *dst,
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		if (key.objectid == btrfs_ino(BTRFS_I(dst)) &&
 		    key.type == BTRFS_EXTENT_DATA_KEY) {
+			/*
+			 * There's an implicit hole at file offset 0, copy the
+			 * inline extent's data to the page.
+			 */
 			ASSERT(key.offset > 0);
-			return -EOPNOTSUPP;
+			return copy_inline_to_page(dst, new_key->offset,
+						   inline_data, size, datal,
+						   comp_type);
 		}
 	} else if (i_size_read(dst) <= datal) {
 		struct btrfs_file_extent_item *ei;
-		u64 ext_len;
 
-		/*
-		 * If the file size is <= datal, make sure there are no other
-		 * extents following (can happen do to an fallocate call with
-		 * the flag FALLOC_FL_KEEP_SIZE).
-		 */
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_file_extent_item);
 		/*
-		 * If it's an inline extent, it can not have other extents
-		 * following it.
+		 * If it's an inline extent replace it with the source inline
+		 * extent, otherwise copy the source inline extent data into
+		 * the respective page at the destination inode.
 		 */
 		if (btrfs_file_extent_type(path->nodes[0], ei) ==
 		    BTRFS_FILE_EXTENT_INLINE)
 			goto copy_inline_extent;
 
-		ext_len = btrfs_file_extent_num_bytes(path->nodes[0], ei);
-		if (ext_len > aligned_end)
-			return -EOPNOTSUPP;
-
-		ret = btrfs_next_item(root, path);
-		if (ret < 0) {
-			return ret;
-		} else if (ret == 0) {
-			btrfs_item_key_to_cpu(path->nodes[0], &key,
-					      path->slots[0]);
-			if (key.objectid == btrfs_ino(BTRFS_I(dst)) &&
-			    key.type == BTRFS_EXTENT_DATA_KEY)
-				return -EOPNOTSUPP;
-		}
+		return copy_inline_to_page(dst, new_key->offset, inline_data,
+					   size, datal, comp_type);
 	}
 
 copy_inline_extent:
@@ -149,18 +235,13 @@ static int clone_copy_inline_extent(struct inode *dst,
 	 */
 	if (i_size_read(dst) > datal) {
 		/*
-		 * If the destination inode has an inline extent...
-		 * This would require copying the data from the source inline
-		 * extent into the beginning of the destination's inline extent.
-		 * But this is really complex, both extents can be compressed
-		 * or just one of them, which would require decompressing and
-		 * re-compressing data (which could increase the new compressed
-		 * size, not allowing the compressed data to fit anymore in an
-		 * inline extent).
-		 * So just don't support this case for now (it should be rare,
-		 * we are not really saving space when cloning inline extents).
+		 * At the destination offset 0 we have either a hole, a regular
+		 * extent or an inline extent larger then the one we want to
+		 * clone. Deal with all these cases by copying the inline extent
+		 * data into the respective page at the destination inode.
 		 */
-		return -EOPNOTSUPP;
+		return copy_inline_to_page(dst, new_key->offset, inline_data,
+					   size, datal, comp_type);
 	}
 
 	btrfs_release_path(path);
@@ -234,6 +315,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		struct btrfs_key new_key;
 		u64 disko = 0, diskl = 0;
 		u64 datao = 0, datal = 0;
+		u8 comp;
 		u64 drop_start;
 
 		/*
@@ -279,6 +361,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 		extent = btrfs_item_ptr(leaf, slot,
 					struct btrfs_file_extent_item);
+		comp = btrfs_file_extent_compression(leaf, extent);
 		type = btrfs_file_extent_type(leaf, extent);
 		if (type == BTRFS_FILE_EXTENT_REG ||
 		    type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -390,7 +473,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 			ret = clone_copy_inline_extent(inode, trans, path,
 						       &new_key, drop_start,
-						       datal, size, buf);
+						       datal, size, comp, buf);
 			if (ret) {
 				if (ret != -EOPNOTSUPP)
 					btrfs_abort_transaction(trans, ret);
@@ -533,6 +616,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	struct inode *src = file_inode(file_src);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int ret;
+	int wb_ret;
 	u64 len = olen;
 	u64 bs = fs_info->sb->s_blocksize;
 
@@ -573,6 +657,14 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	btrfs_double_extent_lock(src, off, inode, destoff, len);
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
 	btrfs_double_extent_unlock(src, off, inode, destoff, len);
+
+	/*
+	 * We may have copied a inline extent into a page of the destination
+	 * range, so wait for writeback to complete before truncating pages
+	 * from the page cache. This is a rare case.
+	 */
+	wb_ret = btrfs_wait_ordered_range(inode, destoff, len);
+	ret = ret ? ret : wb_ret;
 	/*
 	 * Truncate page cache pages so that future reads will see the cloned
 	 * data immediately and not the previous data.
-- 
2.25.0

