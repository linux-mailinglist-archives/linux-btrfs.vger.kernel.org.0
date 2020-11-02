Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995332A2D57
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKBOtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:39934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgKBOtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfA4lh28R/KxmY8sSV8W4WMPPnDzyXbDXGlIN0TuKA8=;
        b=V7L+YAYb0ucJQrRaFuMj4ni4EE2IzbTgO1IEPDPm3JI3ousCcc7+YjFlhXhO9xieODiZK2
        qsB7T1bxx9ko9F6QoFZxmjEaYZsV4FS+2CY3bp/qiMM+TrYgsA6V9W2PR+KqLe/OM+eOtQ
        QbPBRIdUtWyEAPGKVeUg2Cq55SJBtQs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5380FB904;
        Mon,  2 Nov 2020 14:49:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/14] btrfs: Make btrfs_cont_expand take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:04 +0200
Message-Id: <20201102144906.3767963-13-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h   |  2 +-
 fs/btrfs/file.c    |  4 ++--
 fs/btrfs/inode.c   | 37 ++++++++++++++++++-------------------
 fs/btrfs/reflink.c |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bfcd4748319f..879b80ef641e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3044,7 +3044,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 int btrfs_orphan_add(struct btrfs_trans_handle *trans,
 		struct btrfs_inode *inode);
 int btrfs_orphan_cleanup(struct btrfs_root *root);
-int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size);
+int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size);
 void btrfs_add_delayed_iput(struct inode *inode);
 void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info);
 int btrfs_wait_on_delayed_iputs(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3731b3b3325d..05374aa99da8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1989,7 +1989,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		/* Expand hole size to cover write data, preventing empty gap */
 		end_pos = round_up(pos + count,
 				   fs_info->sectorsize);
-		err = btrfs_cont_expand(inode, oldsize, end_pos);
+		err = btrfs_cont_expand(BTRFS_I(inode), oldsize, end_pos);
 		if (err) {
 			inode_unlock(inode);
 			goto out;
@@ -3367,7 +3367,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	 * But that's a minor problem and won't do much harm BTW.
 	 */
 	if (alloc_start > inode->i_size) {
-		ret = btrfs_cont_expand(inode, i_size_read(inode),
+		ret = btrfs_cont_expand(BTRFS_I(inode), i_size_read(inode),
 					alloc_start);
 		if (ret)
 			goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a7fdea00b824..23b9a0621be3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4673,14 +4673,14 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
  * these file extents so that btrfs_get_extent will return a EXTENT_MAP_HOLE for
  * the range between oldsize and size
  */
-int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
+int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	u64 hole_start = ALIGN(oldsize, fs_info->sectorsize);
 	u64 block_end = ALIGN(size, fs_info->sectorsize);
 	u64 last_byte;
@@ -4693,18 +4693,18 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 	 * rest of the block before we expand the i_size, otherwise we could
 	 * expose stale data.
 	 */
-	err = btrfs_truncate_block(BTRFS_I(inode), oldsize, 0, 0);
+	err = btrfs_truncate_block(inode, oldsize, 0, 0);
 	if (err)
 		return err;
 
 	if (size <= hole_start)
 		return 0;
 
-	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), hole_start,
-					   block_end - 1, &cached_state);
+	btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end - 1,
+					   &cached_state);
 	cur_offset = hole_start;
 	while (1) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
+		em = btrfs_get_extent(inode, NULL, 0, cur_offset,
 				      block_end - cur_offset);
 		if (IS_ERR(em)) {
 			err = PTR_ERR(em);
@@ -4718,22 +4718,22 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 		if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
 			struct extent_map *hole_em;
 
-			err = maybe_insert_hole(root, BTRFS_I(inode),
-						cur_offset, hole_size);
+			err = maybe_insert_hole(root, inode, cur_offset,
+						hole_size);
 			if (err)
 				break;
 
-			err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
-							cur_offset, hole_size);
+			err = btrfs_inode_set_file_extent_range(inode,
+								cur_offset, hole_size);
 			if (err)
 				break;
 
-			btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
+			btrfs_drop_extent_cache(inode, cur_offset,
 						cur_offset + hole_size - 1, 0);
 			hole_em = alloc_extent_map();
 			if (!hole_em) {
 				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-					&BTRFS_I(inode)->runtime_flags);
+					&inode->runtime_flags);
 				goto next;
 			}
 			hole_em->start = cur_offset;
@@ -4753,14 +4753,13 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 				write_unlock(&em_tree->lock);
 				if (err != -EEXIST)
 					break;
-				btrfs_drop_extent_cache(BTRFS_I(inode),
-							cur_offset,
+				btrfs_drop_extent_cache(inode, cur_offset,
 							cur_offset +
 							hole_size - 1, 0);
 			}
 			free_extent_map(hole_em);
 		} else {
-			err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
+			err = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
 			if (err)
 				break;
@@ -4808,7 +4807,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		 * this truncation.
 		 */
 		btrfs_drew_write_lock(&root->snapshot_lock);
-		ret = btrfs_cont_expand(inode, oldsize, newsize);
+		ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, newsize);
 		if (ret) {
 			btrfs_drew_write_unlock(&root->snapshot_lock);
 			return ret;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f896dfba771b..be00315995ec 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -652,7 +652,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	if (destoff > inode->i_size) {
 		const u64 wb_start = ALIGN_DOWN(inode->i_size, bs);
 
-		ret = btrfs_cont_expand(inode, inode->i_size, destoff);
+		ret = btrfs_cont_expand(BTRFS_I(inode), inode->i_size, destoff);
 		if (ret)
 			return ret;
 		/*
-- 
2.25.1

