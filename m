Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A121EA71A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgFAPiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgFAPhy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA0E9B231;
        Mon,  1 Jun 2020 15:37:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 33/46] btrfs: Make __extent_writepage_io take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:31 +0300
Message-Id: <20200601153744.31891-34-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It has only a single use for a generic vfs inode vs 3 for btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e2a033e77b25..58a07587efcd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3503,7 +3503,7 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
  * 0 if all went well (page still locked)
  * < 0 if there were errors (page still locked)
  */
-static noinline_for_stack int __extent_writepage_io(struct inode *inode,
+static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct page *page,
 				 struct writeback_control *wbc,
 				 struct extent_page_data *epd,
@@ -3511,7 +3511,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 				 unsigned long nr_written,
 				 int *nr_ret)
 {
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	struct extent_io_tree *tree = &inode->io_tree;
 	u64 start = page_offset(page);
 	u64 page_end = start + PAGE_SIZE - 1;
 	u64 end;
@@ -3543,7 +3543,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 	update_nr_written(wbc, nr_written + 1);

 	end = page_end;
-	blocksize = inode->i_sb->s_blocksize;
+	blocksize = inode->vfs_inode.i_sb->s_blocksize;

 	while (cur <= end) {
 		u64 em_end;
@@ -3554,8 +3554,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 							     page_end, 1);
 			break;
 		}
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur,
-				      end - cur + 1);
+		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
 			ret = PTR_ERR_OR_ZERO(em);
@@ -3592,7 +3591,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,

 		btrfs_set_range_writeback(tree, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
-			btrfs_err(BTRFS_I(inode)->root->fs_info,
+			btrfs_err(inode->root->fs_info,
 				   "page %lu not writeback, cur %llu end %llu",
 			       page->index, cur, end);
 		}
@@ -3672,8 +3671,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 			goto done;
 	}

-	ret = __extent_writepage_io(inode, page, wbc, epd,
-				    i_size, nr_written, &nr);
+	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, epd, i_size,
+				    nr_written, &nr);
 	if (ret == 1)
 		return 0;

--
2.17.1

