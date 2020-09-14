Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A93E268897
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgINJhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgINJhS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF6C8AF26;
        Mon, 14 Sep 2020 09:37:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 4/9] btrfs: Remove btrfs_get_extent indirection from __do_readpage
Date:   Mon, 14 Sep 2020 12:37:06 +0300
Message-Id: <20200914093711.13523-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that this function is only responsible for reading data pages it's
no longer necessary to pass get_extent_t parameter across several
layers of functions. This patch removes this parameter from multiple
functions: __get_extent_map/__do_readpage/__extent_read_full_page/
extent_read_full_page and simply calls btrfs_get_extent directly in
__get_extent_map.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 31 ++++++++++++-------------------
 fs/btrfs/extent_io.h |  3 +--
 fs/btrfs/inode.c     |  2 +-
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0a6cda4c30ed..4a0675ec90fa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3110,8 +3110,7 @@ void set_page_extent_mapped(struct page *page)
 
 static struct extent_map *
 __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
-		 u64 start, u64 len, get_extent_t *get_extent,
-		 struct extent_map **em_cached)
+		 u64 start, u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
 
@@ -3127,7 +3126,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 		*em_cached = NULL;
 	}
 
-	em = get_extent(BTRFS_I(inode), page, pg_offset, start, len);
+	em = btrfs_get_extent(BTRFS_I(inode), page, pg_offset, start, len);
 	if (em_cached && !IS_ERR_OR_NULL(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
@@ -3142,9 +3141,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  * XXX JDM: This needs looking at to ensure proper page locking
  * return 0 on success, otherwise return error
  */
-static int __do_readpage(struct page *page,
-			 get_extent_t *get_extent,
-			 struct extent_map **em_cached,
+static int __do_readpage(struct page *page, struct extent_map **em_cached,
 			 struct bio **bio, int mirror_num,
 			 unsigned long *bio_flags, unsigned int read_flags,
 			 u64 *prev_em_start)
@@ -3209,7 +3206,7 @@ static int __do_readpage(struct page *page,
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
-				      end - cur + 1, get_extent, em_cached);
+				      end - cur + 1, em_cached);
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
 			unlock_extent(tree, cur, end);
@@ -3362,16 +3359,14 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
-		__do_readpage(pages[index], btrfs_get_extent, em_cached,
-				bio, 0, bio_flags, REQ_RAHEAD, prev_em_start);
+		__do_readpage(pages[index], em_cached, bio, 0, bio_flags,
+			      REQ_RAHEAD, prev_em_start);
 		put_page(pages[index]);
 	}
 }
 
-static int __extent_read_full_page(struct page *page,
-				   get_extent_t *get_extent,
-				   struct bio **bio, int mirror_num,
-				   unsigned long *bio_flags,
+static int __extent_read_full_page(struct page *page, struct bio **bio,
+				   int mirror_num, unsigned long *bio_flags,
 				   unsigned int read_flags)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
@@ -3381,20 +3376,18 @@ static int __extent_read_full_page(struct page *page,
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = __do_readpage(page, get_extent, NULL, bio, mirror_num,
-			    bio_flags, read_flags, NULL);
+	ret = __do_readpage(page, NULL, bio, mirror_num, bio_flags, read_flags,
+			    NULL);
 	return ret;
 }
 
-int extent_read_full_page(struct page *page, get_extent_t *get_extent,
-			  int mirror_num)
+int extent_read_full_page(struct page *page, int mirror_num)
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
 	int ret;
 
-	ret = __extent_read_full_page(page, get_extent, &bio, mirror_num,
-				      &bio_flags, 0);
+	ret = __extent_read_full_page(page, &bio, mirror_num, &bio_flags, 0);
 	if (bio)
 		ret = submit_one_bio(bio, mirror_num, bio_flags);
 	return ret;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 06611947a9f7..272d5281bd4d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -193,8 +193,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-int extent_read_full_page(struct page *page, get_extent_t *get_extent,
-			  int mirror_num);
+int extent_read_full_page(struct page *page, int mirror_num);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cce6f8789a4e..df8a4008b139 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8040,7 +8040,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 int btrfs_readpage(struct file *file, struct page *page)
 {
-	return extent_read_full_page(page, btrfs_get_extent, 0);
+	return extent_read_full_page(page, 0);
 }
 
 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
-- 
2.17.1

