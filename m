Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949BD32D614
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 16:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhCDPHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 10:07:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:53616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233749AbhCDPHP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Mar 2021 10:07:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94D22AAC5
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 15:06:09 +0000 (UTC)
Date:   Thu, 4 Mar 2021 09:06:25 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.cz>
Subject: [PATCH v3] btrfs: remove force argument from run_delalloc_nocow()
Message-ID: <20210304150625.idi3d6gpkwwovcpz@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

force_nocow can be calculated by btrfs_inode and does not need to be
passed as an argument.

This simplifies run_delalloc_nocow() call from btrfs_run_delalloc_range()
A new function, should_nocow() checks if the range should be nocow'd or
not. The function returns true iff either BTRFS_INODE_NODATA or
BTRFS_INODE_PREALLOC, but is not a defrag extent.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Changes since v2:
 - merge should_nocow() functionality to fix bug where nocow path was
   followed incorrectly.

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 604c2fcea051..9e1a934ecedc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1516,7 +1516,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				       struct page *locked_page,
 				       const u64 start, const u64 end,
-				       int *page_started, int force,
+				       int *page_started,
 				       unsigned long *nr_written)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1530,6 +1530,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	u64 ino = btrfs_ino(inode);
 	bool nocow = false;
 	u64 disk_bytenr = 0;
+	const bool force = inode->flags & BTRFS_INODE_NODATACOW;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -1863,23 +1864,16 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	return ret;
 }
 
-static inline int need_force_cow(struct btrfs_inode *inode, u64 start, u64 end)
+static inline bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
 {
-
-	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
-	    !(inode->flags & BTRFS_INODE_PREALLOC))
-		return 0;
-
-	/*
-	 * @defrag_bytes is a hint value, no spinlock held here,
-	 * if is not zero, it means the file is defragging.
-	 * Force cow if given extent needs to be defragged.
-	 */
-	if (inode->defrag_bytes &&
-	    test_range_bit(&inode->io_tree, start, end, EXTENT_DEFRAG, 0, NULL))
-		return 1;
-
-	return 0;
+	if (inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)) {
+		if (inode->defrag_bytes &&
+		    test_range_bit(&inode->io_tree, start, end, EXTENT_DEFRAG,
+				   0, NULL))
+			return false;
+		return true;
+	}
+	return false;
 }
 
 /*
@@ -1891,17 +1885,12 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		struct writeback_control *wbc)
 {
 	int ret;
-	int force_cow = need_force_cow(inode, start, end);
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
-	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
-		ASSERT(!zoned);
-		ret = run_delalloc_nocow(inode, locked_page, start, end,
-					 page_started, 1, nr_written);
-	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+	if (should_nocow(inode, start, end)) {
 		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
-					 page_started, 0, nr_written);
+					 page_started, nr_written);
 	} else if (!inode_can_compress(inode) ||
 		   !inode_need_compress(inode, start, end)) {
 		if (zoned)

-- 
Goldwyn
