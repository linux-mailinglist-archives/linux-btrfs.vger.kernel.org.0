Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075951EA71C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgFAPiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgFAPhx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AA9FB229;
        Mon,  1 Jun 2020 15:37:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 27/46] btrfs: Make inode_need_compress take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:25 +0300
Message-Id: <20200601153744.31891-28-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simply gets rid of superfluous BTRFS_I() calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1c3704b18f3a..c44e2ded2597 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -423,29 +423,30 @@ static inline bool inode_can_compress(struct btrfs_inode *inode)
  * Check if the inode needs to be submitted to compression, based on mount
  * options, defragmentation, properties or heuristics.
  */
-static inline int inode_need_compress(struct inode *inode, u64 start, u64 end)
+static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
+				      u64 end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;

-	if (!inode_can_compress(BTRFS_I(inode))) {
+	if (!inode_can_compress(inode)) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
-			btrfs_ino(BTRFS_I(inode)));
+			btrfs_ino(inode));
 		return 0;
 	}
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
 	/* defrag ioctl */
-	if (BTRFS_I(inode)->defrag_compress)
+	if (inode->defrag_compress)
 		return 1;
 	/* bad compression ratios */
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NOCOMPRESS)
+	if (inode->flags & BTRFS_INODE_NOCOMPRESS)
 		return 0;
 	if (btrfs_test_opt(fs_info, COMPRESS) ||
-	    BTRFS_I(inode)->flags & BTRFS_INODE_COMPRESS ||
-	    BTRFS_I(inode)->prop_compress)
-		return btrfs_compress_heuristic(inode, start, end);
+	    inode->flags & BTRFS_INODE_COMPRESS ||
+	    inode->prop_compress)
+		return btrfs_compress_heuristic(&inode->vfs_inode, start, end);
 	return 0;
 }

@@ -551,7 +552,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * inode has not been flagged as nocompress.  This flag can
 	 * change at any time if we discover bad compression ratios.
 	 */
-	if (inode_need_compress(inode, start, end)) {
+	if (inode_need_compress(BTRFS_I(inode), start, end)) {
 		WARN_ON(pages);
 		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 		if (!pages) {
@@ -1809,7 +1810,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
 					 page_started, 0, nr_written);
 	} else if (!inode_can_compress(BTRFS_I(inode)) ||
-		   !inode_need_compress(inode, start, end)) {
+		   !inode_need_compress(BTRFS_I(inode), start, end)) {
 		ret = cow_file_range(BTRFS_I(inode), locked_page, start, end,
 				      page_started, nr_written, 1);
 	} else {
--
2.17.1

