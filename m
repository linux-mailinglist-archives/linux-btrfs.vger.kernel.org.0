Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF815374C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBESJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:57722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgBESJy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B966AACE0;
        Wed,  5 Feb 2020 18:09:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31786DA735; Wed,  5 Feb 2020 19:09:40 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/8] btrfs: sink arugment tree to contiguous_readpages
Date:   Wed,  5 Feb 2020 19:09:40 +0100
Message-Id: <02eb803895120f3c2bf85eb7f8fc79c7e1b3f6a6.1580925977.git.dsterba@suse.com>
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
 fs/btrfs/extent_io.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 015993ccf333..157a0cf0b492 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3281,8 +3281,7 @@ static int __do_readpage(struct extent_io_tree *tree,
 	return ret;
 }
 
-static inline void contiguous_readpages(struct extent_io_tree *tree,
-					     struct page *pages[], int nr_pages,
+static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					     u64 start, u64 end,
 					     struct extent_map **em_cached,
 					     struct bio **bio,
@@ -3290,10 +3289,9 @@ static inline void contiguous_readpages(struct extent_io_tree *tree,
 					     u64 *prev_em_start)
 {
 	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
 	int index;
 
-	ASSERT(tree == &inode->io_tree);
-
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
@@ -4292,7 +4290,6 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 	unsigned long bio_flags = 0;
 	struct page *pagepool[16];
 	struct extent_map *em_cached = NULL;
-	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
 	int nr = 0;
 	u64 prev_em_start = (u64)-1;
 
@@ -4319,7 +4316,7 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 
 			ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
 
-			contiguous_readpages(tree, pagepool, nr, contig_start,
+			contiguous_readpages(pagepool, nr, contig_start,
 				     contig_end, &em_cached, &bio, &bio_flags,
 				     &prev_em_start);
 		}
-- 
2.25.0

