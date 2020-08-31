Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913B62578C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHaLyF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgHaLx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37FB7B7B3;
        Mon, 31 Aug 2020 11:53:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/12] btrfs: Make extent_fiemap take btrfs_iode
Date:   Mon, 31 Aug 2020 14:42:49 +0300
Message-Id: <20200831114249.8360-13-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 28 +++++++++++++---------------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  2 +-
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index efe6b0cbc435..09a1a9b3f351 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4696,7 +4696,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 	return ret;
 }
 
-int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len)
 {
 	int ret = 0;
@@ -4707,12 +4707,12 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u64 last;
 	u64 last_for_get_extent = 0;
 	u64 disko = 0;
-	u64 isize = i_size_read(inode);
+	u64 isize = i_size_read(&inode->vfs_inode);
 	struct btrfs_key found_key;
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct fiemap_cache cache = { 0 };
 	struct ulist *roots;
 	struct ulist *tmp_ulist;
@@ -4736,15 +4736,15 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out_free_ulist;
 	}
 
-	start = round_down(start, btrfs_inode_sectorsize(BTRFS_I(inode)));
-	len = round_up(max, btrfs_inode_sectorsize(BTRFS_I(inode))) - start;
+	start = round_down(start, btrfs_inode_sectorsize(inode));
+	len = round_up(max, btrfs_inode_sectorsize(inode)) - start;
 
 	/*
 	 * lookup the last file extent.  We're not using i_size here
 	 * because there might be preallocation past i_size
 	 */
-	ret = btrfs_lookup_file_extent(NULL, root, path,
-			btrfs_ino(BTRFS_I(inode)), -1, 0);
+	ret = btrfs_lookup_file_extent(NULL, root, path, btrfs_ino(inode), -1,
+				       0);
 	if (ret < 0) {
 		goto out_free_ulist;
 	} else {
@@ -4758,7 +4758,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	found_type = found_key.type;
 
 	/* No extents, but there might be delalloc bits */
-	if (found_key.objectid != btrfs_ino(BTRFS_I(inode)) ||
+	if (found_key.objectid != btrfs_ino(inode) ||
 	    found_type != BTRFS_EXTENT_DATA_KEY) {
 		/* have to trust i_size as the end */
 		last = (u64)-1;
@@ -4784,10 +4784,10 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		last_for_get_extent = isize;
 	}
 
-	lock_extent_bits(&BTRFS_I(inode)->io_tree, start, start + len - 1,
+	lock_extent_bits(&inode->io_tree, start, start + len - 1,
 			 &cached_state);
 
-	em = get_extent_skip_holes(BTRFS_I(inode), start, last_for_get_extent);
+	em = get_extent_skip_holes(inode, start, last_for_get_extent);
 	if (!em)
 		goto out;
 	if (IS_ERR(em)) {
@@ -4853,8 +4853,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			 * then we're just getting a count and we can skip the
 			 * lookup stuff.
 			 */
-			ret = btrfs_check_shared(root,
-						 btrfs_ino(BTRFS_I(inode)),
+			ret = btrfs_check_shared(root, btrfs_ino(inode),
 						 bytenr, roots, tmp_ulist);
 			if (ret < 0)
 				goto out_free;
@@ -4876,8 +4875,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		/* now scan forward to see if this is really the last extent. */
-		em = get_extent_skip_holes(BTRFS_I(inode), off,
-					   last_for_get_extent);
+		em = get_extent_skip_holes(inode, off, last_for_get_extent);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -4899,7 +4897,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		ret = emit_last_fiemap_cache(fieinfo, &cache);
 	free_extent_map(em);
 out:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len - 1,
+	unlock_extent_cached(&inode->io_tree, start, start + len - 1,
 			     &cached_state);
 
 out_free_ulist:
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 68f431ebf65c..c2864a9e7670 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -204,7 +204,7 @@ int extent_writepages(struct address_space *mapping,
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
 void extent_readahead(struct readahead_control *rac);
-int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len);
 void set_page_extent_mapped(struct page *page);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 663551993ca5..e584fd93872b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7963,7 +7963,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
-	return extent_fiemap(inode, fieinfo, start, len);
+	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
 int btrfs_readpage(struct file *file, struct page *page)
-- 
2.17.1

