Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C31EA70B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgFAPh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgFAPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 659C8B21C;
        Mon,  1 Jun 2020 15:37:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 36/46] btrfs: Make btrfs_dirty_pages take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:34 +0300
Message-Id: <20200601153744.31891-37-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a single use of the generic vfs_inode so let's take btrfs_inode as
a parameter and remove couple of redundant BTRFS_I() calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/file.c             | 26 +++++++++++++-------------
 fs/btrfs/free-space-cache.c |  5 +++--
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 05a7cef660fc..9a28a2bd4769 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2980,7 +2980,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end);
 int btrfs_release_file(struct inode *inode, struct file *file);
-int btrfs_dirty_pages(struct inode *inode, struct page **pages,
+int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached);
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index aa43d77bfd98..cd1bfd571749 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -500,18 +500,18 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
  * this also makes the decision about creating an inline extent vs
  * doing real data extents, marking pages dirty and delalloc as required.
  */
-int btrfs_dirty_pages(struct inode *inode, struct page **pages,
+int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int err = 0;
 	int i;
 	u64 num_bytes;
 	u64 start_pos;
 	u64 end_of_last_block;
 	u64 end_pos = pos + write_bytes;
-	loff_t isize = i_size_read(inode);
+	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;

 	start_pos = pos & ~((u64) fs_info->sectorsize - 1);
@@ -524,13 +524,13 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 	 * The pages may have already been dirty, clear out old accounting so
 	 * we can set things up properly
 	 */
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos, end_of_last_block,
+	clear_extent_bit(&inode->io_tree, start_pos, end_of_last_block,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, cached);

-	if (!btrfs_is_free_space_inode(BTRFS_I(inode))) {
+	if (!btrfs_is_free_space_inode(inode)) {
 		if (start_pos >= isize &&
-		    !(BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC)) {
+		    !(inode->flags & BTRFS_INODE_PREALLOC)) {
 			/*
 			 * There can't be any extents following eof in this case
 			 * so just set the delalloc new bit for the range
@@ -538,16 +538,15 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 			 */
 			extra_bits |= EXTENT_DELALLOC_NEW;
 		} else {
-			err = btrfs_find_new_delalloc_bytes(BTRFS_I(inode),
-							    start_pos,
+			err = btrfs_find_new_delalloc_bytes(inode, start_pos,
 							    num_bytes, cached);
 			if (err)
 				return err;
 		}
 	}

-	err = btrfs_set_extent_delalloc(BTRFS_I(inode), start_pos,
-					end_of_last_block, extra_bits, cached);
+	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
+					extra_bits, cached);
 	if (err)
 		return err;

@@ -564,7 +563,7 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 	 * at this time.
 	 */
 	if (end_pos > isize)
-		i_size_write(inode, end_pos);
+		i_size_write(&inode->vfs_inode, end_pos);
 	return 0;
 }

@@ -1743,8 +1742,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					fs_info->sectorsize);

 		if (copied > 0)
-			ret = btrfs_dirty_pages(inode, pages, dirty_pages,
-						pos, copied, &cached_state);
+			ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
+						dirty_pages, pos, copied,
+						&cached_state);

 		/*
 		 * If we have not locked the extent range, because the range's
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 55955bd424d7..e806341f4580 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1334,8 +1334,9 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	io_ctl_zero_remaining_pages(io_ctl);

 	/* Everything is written out, now we dirty the pages in the file. */
-	ret = btrfs_dirty_pages(inode, io_ctl->pages, io_ctl->num_pages, 0,
-				i_size_read(inode), &cached_state);
+	ret = btrfs_dirty_pages(BTRFS_I(inode), io_ctl->pages,
+				io_ctl->num_pages, 0, i_size_read(inode),
+				&cached_state);
 	if (ret)
 		goto out_nospc;

--
2.17.1

