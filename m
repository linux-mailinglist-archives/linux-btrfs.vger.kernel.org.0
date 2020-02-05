Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67D15374D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBESJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:57740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgBESJ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 119D8AD00;
        Wed,  5 Feb 2020 18:09:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E9F6DA735; Wed,  5 Feb 2020 19:09:42 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/8] btrfs: sink argument tree to __do_readpage
Date:   Wed,  5 Feb 2020 19:09:42 +0100
Message-Id: <e53dfb989393f4561efbb1ae84e407ecfdbfd6f8.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree pointer can be safely read from the inode, use it and drop the
redundant argument.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 157a0cf0b492..46f0e52bce8f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3072,8 +3072,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  * XXX JDM: This needs looking at to ensure proper page locking
  * return 0 on success, otherwise return error
  */
-static int __do_readpage(struct extent_io_tree *tree,
-			 struct page *page,
+static int __do_readpage(struct page *page,
 			 get_extent_t *get_extent,
 			 struct extent_map **em_cached,
 			 struct bio **bio, int mirror_num,
@@ -3096,8 +3095,7 @@ static int __do_readpage(struct extent_io_tree *tree,
 	size_t disk_io_size;
 	size_t blocksize = inode->i_sb->s_blocksize;
 	unsigned long this_bio_flag = 0;
-
-	ASSERT(tree == &BTRFS_I(inode)->io_tree);
+	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	set_page_extent_mapped(page);
 
@@ -3289,13 +3287,12 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					     u64 *prev_em_start)
 {
 	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
-	struct extent_io_tree *tree = &inode->io_tree;
 	int index;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
-		__do_readpage(tree, pages[index], btrfs_get_extent, em_cached,
+		__do_readpage(pages[index], btrfs_get_extent, em_cached,
 				bio, 0, bio_flags, REQ_RAHEAD, prev_em_start);
 		put_page(pages[index]);
 	}
@@ -3310,12 +3307,11 @@ static int __extent_read_full_page(struct page *page,
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct extent_io_tree *tree = &inode->io_tree;
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = __do_readpage(tree, page, get_extent, NULL, bio, mirror_num,
+	ret = __do_readpage(page, get_extent, NULL, bio, mirror_num,
 			    bio_flags, read_flags, NULL);
 	return ret;
 }
-- 
2.25.0

