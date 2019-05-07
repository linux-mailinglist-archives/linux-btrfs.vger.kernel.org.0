Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13715DFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfEGHTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 03:19:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfEGHT3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 03:19:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C8C9ADFE
        for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2019 07:19:27 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/3] btrfs: Use newly introduced btrfs_lock_and_flush_ordered_range
Date:   Tue,  7 May 2019 10:19:23 +0300
Message-Id: <20190507071924.17643-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507071924.17643-1-nborisov@suse.com>
References: <20190507071924.17643-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There several functions which open code
btrfs_lock_and_flush_ordered_range, just replace them with a call
to the function. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 29 ++++-------------------------
 fs/btrfs/file.c      | 14 ++------------
 fs/btrfs/inode.c     | 17 ++---------------
 3 files changed, 8 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13fca7bfc1f2..8998819d185a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3206,21 +3206,10 @@ static inline void contiguous_readpages(struct extent_io_tree *tree,
 					     unsigned long *bio_flags,
 					     u64 *prev_em_start)
 {
-	struct inode *inode;
-	struct btrfs_ordered_extent *ordered;
+	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
 	int index;
 
-	inode = pages[0]->mapping->host;
-	while (1) {
-		lock_extent(tree, start, end);
-		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
-						     end - start + 1);
-		if (!ordered)
-			break;
-		unlock_extent(tree, start, end);
-		btrfs_start_ordered_extent(inode, ordered, 1);
-		btrfs_put_ordered_extent(ordered);
-	}
+	btrfs_lock_and_flush_ordered_range(tree, inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
 		__do_readpage(tree, pages[index], btrfs_get_extent, em_cached,
@@ -3236,22 +3225,12 @@ static int __extent_read_full_page(struct extent_io_tree *tree,
 				   unsigned long *bio_flags,
 				   unsigned int read_flags)
 {
-	struct inode *inode = page->mapping->host;
-	struct btrfs_ordered_extent *ordered;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	int ret;
 
-	while (1) {
-		lock_extent(tree, start, end);
-		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
-						PAGE_SIZE);
-		if (!ordered)
-			break;
-		unlock_extent(tree, start, end);
-		btrfs_start_ordered_extent(inode, ordered, 1);
-		btrfs_put_ordered_extent(ordered);
-	}
+	btrfs_lock_and_flush_ordered_range(tree, inode, start, end, NULL);
 
 	ret = __do_readpage(tree, page, get_extent, NULL, bio, mirror_num,
 			    bio_flags, read_flags, NULL);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9dbea72a61fe..d8abce428176 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1550,7 +1550,6 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_ordered_extent *ordered;
 	u64 lockstart, lockend;
 	u64 num_bytes;
 	int ret;
@@ -1563,17 +1562,8 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	lockend = round_up(pos + *write_bytes,
 			   fs_info->sectorsize) - 1;
 
-	while (1) {
-		lock_extent(&inode->io_tree, lockstart, lockend);
-		ordered = btrfs_lookup_ordered_range(inode, lockstart,
-						     lockend - lockstart + 1);
-		if (!ordered) {
-			break;
-		}
-		unlock_extent(&inode->io_tree, lockstart, lockend);
-		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
-		btrfs_put_ordered_extent(ordered);
-	}
+	btrfs_lock_and_flush_ordered_range(&inode->io_tree, inode, lockstart,
+					   lockend, NULL);
 
 	num_bytes = lockend - lockstart + 1;
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d1de8eb253eb..45f999bb3dfe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5008,21 +5008,8 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 	if (size <= hole_start)
 		return 0;
 
-	while (1) {
-		struct btrfs_ordered_extent *ordered;
-
-		lock_extent_bits(io_tree, hole_start, block_end - 1,
-				 &cached_state);
-		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), hole_start,
-						     block_end - hole_start);
-		if (!ordered)
-			break;
-		unlock_extent_cached(io_tree, hole_start, block_end - 1,
-				     &cached_state);
-		btrfs_start_ordered_extent(inode, ordered, 1);
-		btrfs_put_ordered_extent(ordered);
-	}
-
+	btrfs_lock_and_flush_ordered_range(io_tree, BTRFS_I(inode), hole_start,
+					   block_end - 1, &cached_state);
 	cur_offset = hole_start;
 	while (1) {
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
-- 
2.17.1

