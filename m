Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0126BEE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgIPIOE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:14:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:59976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPIOD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:14:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29C14B000;
        Wed, 16 Sep 2020 08:14:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Move btrfs_lock_and_flush_ordered_range call in btrfs_do_readpage
Date:   Wed, 16 Sep 2020 11:14:01 +0300
Message-Id: <20200916081401.31668-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_lock_and_flush_ordered_range returns with the extent range locked.
Subsequently this lock is being dropped in btrfs_do_readpage. Given this
it makes more sense to move the call to the locking function inside
btrfs_do_readpage making btrfs_do_readpage self-contained as it calls
unlock_extent a couple of times. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 2 ++
 fs/btrfs/inode.c     | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index afac70ef0cc5..00e552055315 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3163,6 +3163,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	unsigned long this_bio_flag = 0;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, end, NULL);
+
 	set_page_extent_mapped(page);
 
 	if (!PageUptodate(page)) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb3fdd0798c6..ae396d799aa5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8023,15 +8023,10 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 int btrfs_readpage(struct file *file, struct page *page)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
 	unsigned long bio_flags = 0;
 	struct bio *bio = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
 	ret = btrfs_do_readpage(page, NULL, &bio, &bio_flags, 0, NULL);
 	if (bio)
 		ret = submit_one_bio(bio, 0, bio_flags);
-- 
2.17.1

