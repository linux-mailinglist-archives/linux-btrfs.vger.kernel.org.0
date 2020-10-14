Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF628E2A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgJNO4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 10:56:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:38734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgJNO4F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 10:56:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07380AD18;
        Wed, 14 Oct 2020 14:56:04 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] btrfs: Set EXTENT_NORESERVE bits in btrfs_dirty_pages()
Date:   Wed, 14 Oct 2020 09:55:45 -0500
Message-Id: <20201014145545.10878-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014145545.10878-1-rgoldwyn@suse.de>
References: <20201014145545.10878-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set the extent bits EXTENT_NORESERVE in btrfs_dirty_pages() as opposed
to calling set_extent_bits again later.

Fold check for written length within the function.

Note: EXTENT_NORESERVE is set before unlocking extents.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/file.c             | 26 ++++++++++----------------
 fs/btrfs/free-space-cache.c |  2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..42e9ac0fb641 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3109,7 +3109,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 int btrfs_release_file(struct inode *inode, struct file *file);
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
-		      struct extent_state **cached);
+		      struct extent_state **cached, bool noreserve);
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
 int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6e52e2360d8e..6b4114a5fd92 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -502,7 +502,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
  */
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
-		      struct extent_state **cached)
+		      struct extent_state **cached, bool noreserve)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int err = 0;
@@ -514,6 +514,12 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;
 
+	if (write_bytes == 0)
+		return 0;
+
+	if (noreserve)
+		extra_bits |= EXTENT_NORESERVE;
+
 	start_pos = round_down(pos, fs_info->sectorsize);
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
@@ -1787,10 +1793,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		release_bytes = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 
-		if (copied > 0)
-			ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
-						dirty_pages, pos, copied,
-						&cached_state);
+		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
+					dirty_pages, pos, copied,
+					&cached_state, only_release_metadata);
 
 		/*
 		 * If we have not locked the extent range, because the range's
@@ -1815,17 +1820,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (only_release_metadata)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
-		if (only_release_metadata && copied > 0) {
-			lockstart = round_down(pos,
-					       fs_info->sectorsize);
-			lockend = round_up(pos + copied,
-					   fs_info->sectorsize) - 1;
-
-			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
-				       lockend, EXTENT_NORESERVE, NULL,
-				       NULL, GFP_NOFS);
-		}
-
 		btrfs_drop_pages(pages, num_pages);
 
 		cond_resched();
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af0013d3df63..5ea36a06e514 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1332,7 +1332,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	/* Everything is written out, now we dirty the pages in the file. */
 	ret = btrfs_dirty_pages(BTRFS_I(inode), io_ctl->pages,
 				io_ctl->num_pages, 0, i_size_read(inode),
-				&cached_state);
+				&cached_state, false);
 	if (ret)
 		goto out_nospc;
 
-- 
2.26.2

