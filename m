Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0205D15374A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBESJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:57672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgBESJt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20318AAB8;
        Wed,  5 Feb 2020 18:09:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F882DA735; Wed,  5 Feb 2020 19:09:35 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/8] btrfs: sink argument tree to extent_read_full_page
Date:   Wed,  5 Feb 2020 19:09:35 +0100
Message-Id: <fb262a910895eaa84572cd94b6f412215b2967e6.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree pointer can be safely read from the page's inode, use it and
drop the redundant argument.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   | 4 +---
 fs/btrfs/extent_io.c | 7 +++----
 fs/btrfs/extent_io.h | 4 ++--
 fs/btrfs/inode.c     | 4 +---
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 28622de9e642..a1e5b9511993 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -972,9 +972,7 @@ static int btree_writepages(struct address_space *mapping,
 
 static int btree_readpage(struct file *file, struct page *page)
 {
-	struct extent_io_tree *tree;
-	tree = &BTRFS_I(page->mapping->host)->io_tree;
-	return extent_read_full_page(tree, page, btree_get_extent, 0);
+	return extent_read_full_page(page, btree_get_extent, 0);
 }
 
 static int btree_releasepage(struct page *page, gfp_t gfp_flags)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a0a80a151085..97e613e72ed4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3324,15 +3324,14 @@ static int __extent_read_full_page(struct extent_io_tree *tree,
 	return ret;
 }
 
-int extent_read_full_page(struct extent_io_tree *tree, struct page *page,
-			    get_extent_t *get_extent, int mirror_num)
+int extent_read_full_page(struct page *page, get_extent_t *get_extent,
+			  int mirror_num)
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
+	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 	int ret;
 
-	ASSERT(tree == &BTRFS_I(page->mapping->host)->io_tree);
-
 	ret = __extent_read_full_page(tree, page, get_extent, &bio, mirror_num,
 				      &bio_flags, 0);
 	if (bio)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5d205bbaafdc..234622101230 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -189,8 +189,8 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-int extent_read_full_page(struct extent_io_tree *tree, struct page *page,
-			  get_extent_t *get_extent, int mirror_num);
+int extent_read_full_page(struct page *page, get_extent_t *get_extent,
+			  int mirror_num);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 29b06c109137..64e3c62cc0df 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8256,9 +8256,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 int btrfs_readpage(struct file *file, struct page *page)
 {
-	struct extent_io_tree *tree;
-	tree = &BTRFS_I(page->mapping->host)->io_tree;
-	return extent_read_full_page(tree, page, btrfs_get_extent, 0);
+	return extent_read_full_page(page, btrfs_get_extent, 0);
 }
 
 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
-- 
2.25.0

