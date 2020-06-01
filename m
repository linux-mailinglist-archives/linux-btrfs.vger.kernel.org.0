Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766BD1EA709
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgFAPh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgFAPhy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A71FCB22A;
        Mon,  1 Jun 2020 15:37:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 28/46] btrfs: Make need_force_cow take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:26 +0300
Message-Id: <20200601153744.31891-29-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gets rid of superfulous BTRFS_I() calls and prepare for converting
btrfs_run_delalloc_range to using btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c44e2ded2597..709253e2470a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1772,11 +1772,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	return ret;
 }

-static inline int need_force_cow(struct inode *inode, u64 start, u64 end)
+static inline int need_force_cow(struct btrfs_inode *inode, u64 start, u64 end)
 {

-	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
-	    !(BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC))
+	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
+	    !(inode->flags & BTRFS_INODE_PREALLOC))
 		return 0;

 	/*
@@ -1784,9 +1784,8 @@ static inline int need_force_cow(struct inode *inode, u64 start, u64 end)
 	 * if is not zero, it means the file is defragging.
 	 * Force cow if given extent needs to be defragged.
 	 */
-	if (BTRFS_I(inode)->defrag_bytes &&
-	    test_range_bit(&BTRFS_I(inode)->io_tree, start, end,
-			   EXTENT_DEFRAG, 0, NULL))
+	if (inode->defrag_bytes &&
+	    test_range_bit(&inode->io_tree, start, end, EXTENT_DEFRAG, 0, NULL))
 		return 1;

 	return 0;
@@ -1801,7 +1800,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 		struct writeback_control *wbc)
 {
 	int ret;
-	int force_cow = need_force_cow(inode, start, end);
+	int force_cow = need_force_cow(BTRFS_I(inode), start, end);

 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW && !force_cow) {
 		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
--
2.17.1

