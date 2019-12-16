Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78ACD121969
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 19:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLPSux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 13:50:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:47622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLPSur (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 13:50:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A26C8B2A6;
        Mon, 16 Dec 2019 18:50:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFA02DA81D; Mon, 16 Dec 2019 19:50:41 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use helper to zero end of last page
Date:   Mon, 16 Dec 2019 19:50:38 +0100
Message-Id: <20191216185038.14913-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The zero_user_segment is open coded in several places, we should use the
helper. btrfs_page_mkwrite uses kmap/kunmap but replacing them by
_atomic variants is not a problem as they're more restrictive than
required.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 15 ++-------------
 fs/btrfs/extent_io.c   | 39 +++++++--------------------------------
 fs/btrfs/inode.c       | 10 +++-------
 3 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ed05e5277399..299fcfdfb10f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -602,19 +602,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 		free_extent_map(em);
 
-		if (page->index == end_index) {
-			char *userpage;
-			size_t zero_offset = offset_in_page(isize);
-
-			if (zero_offset) {
-				int zeros;
-				zeros = PAGE_SIZE - zero_offset;
-				userpage = kmap_atomic(page);
-				memset(userpage + zero_offset, 0, zeros);
-				flush_dcache_page(page);
-				kunmap_atomic(userpage);
-			}
-		}
+		if (page->index == end_index)
+			zero_user_segment(page, offset_in_page(isize), PAGE_SIZE);
 
 		ret = bio_add_page(cb->orig_bio, page,
 				   PAGE_SIZE, 0);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 394beb474a69..d6b3af7f1675 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3093,31 +3093,18 @@ static int __do_readpage(struct extent_io_tree *tree,
 		}
 	}
 
-	if (page->index == last_byte >> PAGE_SHIFT) {
-		char *userpage;
-		size_t zero_offset = offset_in_page(last_byte);
-
-		if (zero_offset) {
-			iosize = PAGE_SIZE - zero_offset;
-			userpage = kmap_atomic(page);
-			memset(userpage + zero_offset, 0, iosize);
-			flush_dcache_page(page);
-			kunmap_atomic(userpage);
-		}
-	}
+	if (page->index == last_byte >> PAGE_SHIFT)
+		zero_user_segment(page, offset_in_page(last_byte), PAGE_SIZE);
+
 	while (cur <= end) {
 		bool force_bio_submit = false;
 		u64 offset;
 
 		if (cur >= last_byte) {
-			char *userpage;
 			struct extent_state *cached = NULL;
 
+			zero_user_segment(page, pg_offset, PAGE_SIZE);
 			iosize = PAGE_SIZE - pg_offset;
-			userpage = kmap_atomic(page);
-			memset(userpage + pg_offset, 0, iosize);
-			flush_dcache_page(page);
-			kunmap_atomic(userpage);
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
@@ -3202,14 +3189,9 @@ static int __do_readpage(struct extent_io_tree *tree,
 
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
-			char *userpage;
 			struct extent_state *cached = NULL;
 
-			userpage = kmap_atomic(page);
-			memset(userpage + pg_offset, 0, iosize);
-			flush_dcache_page(page);
-			kunmap_atomic(userpage);
-
+			zero_user_segment(page, pg_offset, pg_offset + iosize);
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
@@ -3564,15 +3546,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	if (page->index == end_index) {
-		char *userpage;
-
-		userpage = kmap_atomic(page);
-		memset(userpage + pg_offset, 0,
-		       PAGE_SIZE - pg_offset);
-		kunmap_atomic(userpage);
-		flush_dcache_page(page);
-	}
+	if (page->index == end_index)
+		zero_user_segment(page, pg_offset, PAGE_SIZE);
 
 	set_page_extent_mapped(page);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f27377d8ec55..24337de25a8b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8308,7 +8308,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	char *kaddr;
 	unsigned long zero_start;
 	loff_t size;
 	vm_fault_t ret;
@@ -8414,12 +8413,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	else
 		zero_start = PAGE_SIZE;
 
-	if (zero_start != PAGE_SIZE) {
-		kaddr = kmap(page);
-		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
-		flush_dcache_page(page);
-		kunmap(page);
-	}
+	if (zero_start != PAGE_SIZE)
+		zero_user_segment(page, zero_start, PAGE_SIZE);
+
 	ClearPageChecked(page);
 	set_page_dirty(page);
 	SetPageUptodate(page);
-- 
2.24.0

