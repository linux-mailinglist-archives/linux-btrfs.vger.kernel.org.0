Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFF153748
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBESJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgBESJp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F771AAB8;
        Wed,  5 Feb 2020 18:09:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9CDADA735; Wed,  5 Feb 2020 19:09:30 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/8] btrfs: add assertions for tree == inode->io_tree to extent IO helpers
Date:   Wed,  5 Feb 2020 19:09:30 +0100
Message-Id: <d1acc29c9c15139a988add159de8dbfe2129a36f.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add assertions to all helpers that get tree as argument and verify that
it's the same that can be obtained from the inode or from its pages. In
followup patches the redundant arguments and assertions will be removed
one by one.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c    | 10 ++++++++++
 fs/btrfs/ordered-data.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6640336dd9ba..e9d116ecf5a1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3097,6 +3097,8 @@ static int __do_readpage(struct extent_io_tree *tree,
 	size_t blocksize = inode->i_sb->s_blocksize;
 	unsigned long this_bio_flag = 0;
 
+	ASSERT(tree == &BTRFS_I(inode)->io_tree);
+
 	set_page_extent_mapped(page);
 
 	if (!PageUptodate(page)) {
@@ -3290,6 +3292,8 @@ static inline void contiguous_readpages(struct extent_io_tree *tree,
 	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
 	int index;
 
+	ASSERT(tree == &inode->io_tree);
+
 	btrfs_lock_and_flush_ordered_range(tree, inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
@@ -3311,6 +3315,8 @@ static int __extent_read_full_page(struct extent_io_tree *tree,
 	u64 end = start + PAGE_SIZE - 1;
 	int ret;
 
+	ASSERT(tree == &inode->io_tree);
+
 	btrfs_lock_and_flush_ordered_range(tree, inode, start, end, NULL);
 
 	ret = __do_readpage(tree, page, get_extent, NULL, bio, mirror_num,
@@ -3325,6 +3331,8 @@ int extent_read_full_page(struct extent_io_tree *tree, struct page *page,
 	unsigned long bio_flags = 0;
 	int ret;
 
+	ASSERT(tree == &BTRFS_I(page->mapping->host)->io_tree);
+
 	ret = __extent_read_full_page(tree, page, get_extent, &bio, mirror_num,
 				      &bio_flags, 0);
 	if (bio)
@@ -5413,6 +5421,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
+	ASSERT(tree == &BTRFS_I(eb->pages[0]->mapping->host)->io_tree);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 45048e5f76b0..ad471a2fba93 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -849,6 +849,8 @@ void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
 	struct extent_state *cache = NULL;
 	struct extent_state **cachedp = &cache;
 
+	ASSERT(tree == &inode->io_tree);
+
 	if (cached_state)
 		cachedp = cached_state;
 
-- 
2.25.0

