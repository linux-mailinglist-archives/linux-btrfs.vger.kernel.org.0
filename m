Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21E32C53B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447346AbhCDATu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:55902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239780AbhCCMzR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 07:55:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C58FADDC;
        Wed,  3 Mar 2021 12:54:25 +0000 (UTC)
Date:   Wed, 3 Mar 2021 06:54:40 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, dsterba@suse.cz
Subject: [PATCH] btrfs: fix nocow sequence in btrfs_run_delalloc_range()
Message-ID: <20210303125440.lub5c4qymhxo7mgh@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

need_force_cow will evaluate to false if both BTRFS_INODE_NODATACOW and
BTRFS_INODE_PREALLOC are not set. Change the function to should_cow()
instead and correct the conditions so should_nocow() returns true if
either BTRFS_INODE_NODATACOW or BTRFS_INODE_PREALLOC, but it is not a
defrag extent.

Fixes: 7e33213f8ccc btrfs: remove force argument from run_delalloc_nocow()
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b133fda4f5d..ceb6ca7c571d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1864,23 +1864,16 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
@@ -1894,7 +1887,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	int ret;
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
-	if (!need_force_cow(inode, start, end)) {
+	if (should_nocow(inode, start, end)) {
 		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
-- 
2.30.1


-- 
Goldwyn
