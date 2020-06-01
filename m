Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2E1EA720
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgFAPiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgFAPhw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05856B228;
        Mon,  1 Jun 2020 15:37:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 25/46] btrfs: Make btrfs_cleanup_ordered_extents take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:23 +0300
Message-Id: <20200601153744.31891-26-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparation to converting btrfs_run_delalloc_range to using btrfs_inode without
BTRFS_I() calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 964ebc0a8413..a8a41c19b0bb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -103,7 +103,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
  * to be released, which we want to happen only when finishing the ordered
  * extent (btrfs_finish_ordered_io()).
  */
-static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
+static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 						 struct page *locked_page,
 						 u64 offset, u64 bytes)
 {
@@ -115,7 +115,7 @@ static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
 	struct page *page;

 	while (index <= end_index) {
-		page = find_get_page(inode->i_mapping, index);
+		page = find_get_page(inode->vfs_inode.i_mapping, index);
 		index++;
 		if (!page)
 			continue;
@@ -133,8 +133,7 @@ static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
 		bytes -= PAGE_SIZE;
 	}

-	return __endio_write_update_ordered(BTRFS_I(inode), offset, bytes,
-					    false);
+	return __endio_write_update_ordered(inode, offset, bytes, false);
 }

 static int btrfs_dirty_inode(struct inode *inode);
@@ -1820,7 +1819,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 					   page_started, nr_written);
 	}
 	if (ret)
-		btrfs_cleanup_ordered_extents(inode, locked_page, start,
+		btrfs_cleanup_ordered_extents(BTRFS_I(inode), locked_page, start,
 					      end - start + 1);
 	return ret;
 }
--
2.17.1

