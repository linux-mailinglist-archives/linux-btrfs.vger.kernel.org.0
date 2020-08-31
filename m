Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3A2578CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHaLyR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgHaLxt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86018B8F4;
        Mon, 31 Aug 2020 11:53:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/12] btrfs: Make btrfs_writepage_endio_finish_ordered btrfs_inode-centric
Date:   Mon, 31 Aug 2020 14:42:44 +0300
Message-Id: <20200831114249.8360-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0621fbbd08be..663551993ca5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2757,19 +2757,19 @@ static void finish_ordered_fn(struct btrfs_work *work)
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate)
 {
-	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_extent *ordered_extent = NULL;
 	struct btrfs_workqueue *wq;
 
 	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
 
 	ClearPagePrivate2(page);
-	if (!btrfs_dec_test_ordered_pending(BTRFS_I(inode), &ordered_extent,
-					    start, end - start + 1, uptodate))
+	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
+					    end - start + 1, uptodate))
 		return;
 
-	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
+	if (btrfs_is_free_space_inode(inode))
 		wq = fs_info->endio_freespace_worker;
 	else
 		wq = fs_info->endio_write_workers;
-- 
2.17.1

