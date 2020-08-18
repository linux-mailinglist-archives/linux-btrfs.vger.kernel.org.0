Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22984247E74
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHRGa6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 02:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgHRGa6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 02:30:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9819AE35;
        Tue, 18 Aug 2020 06:31:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Merge inode_can_compress in inode_need_compress
Date:   Tue, 18 Aug 2020 09:30:56 +0300
Message-Id: <20200818063056.9094-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The latter is the only caller of the former. Just open code can_compress
into need_compress and also remove the warning since it's made redundant
by this change.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 15dc8b6871ac..19e1918bad5c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -410,17 +410,6 @@ static noinline int add_async_extent(struct async_chunk *cow,
 	return 0;
 }
 
-/*
- * Check if the inode has flags compatible with compression
- */
-static inline bool inode_can_compress(struct btrfs_inode *inode)
-{
-	if (inode->flags & BTRFS_INODE_NODATACOW ||
-	    inode->flags & BTRFS_INODE_NODATASUM)
-		return false;
-	return true;
-}
-
 /*
  * Check if the inode needs to be submitted to compression, based on mount
  * options, defragmentation, properties or heuristics.
@@ -430,12 +419,9 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	if (!inode_can_compress(inode)) {
-		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
-			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
-			btrfs_ino(inode));
+	if (inode->flags & BTRFS_INODE_NODATACOW ||
+	    inode->flags & BTRFS_INODE_NODATASUM)
 		return 0;
-	}
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
@@ -1833,8 +1819,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!inode_need_compress(inode, start, end)) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1);
 	} else {
-- 
2.17.1

