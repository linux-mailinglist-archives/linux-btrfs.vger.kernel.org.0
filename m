Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427B4164650
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBSOGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:06:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBSOGK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:06:10 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486AE2176D
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582121168;
        bh=NxuQWdS8+eAufg1UYF0iRrjGN0qVtlYULB7kUphHwJY=;
        h=From:To:Subject:Date:From;
        b=gnzeKLNsn/5WAiGo7JnppBl55Yhli4c3HT1tpE/FAEm+n/WJ6wlHa3Y7fPZF6RAYI
         06xmSyRcwK/GxrhK+XzKYgCkocoR+xyzBUxsfDB3eXuBCM6GPHD/aanpt5SrvRRu0R
         dIMXxjwPBK4oXghHvEinGRaXl0F9/gF/YAdAzgaA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] Btrfs: resurrect extent_read_full_page_nolock()
Date:   Wed, 19 Feb 2020 14:06:06 +0000
Message-Id: <20200219140606.1641625-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit 7f042a8370a5bb ("Btrfs: remove no longer used function
extent_read_full_page_nolock()") removed extent_read_full_page_nolock()
because it was not needed anymore.

This function was used to read a page while holding the respective range
locked in the inode's iotree, to avoid deadlocks when using the other
APIs we have for reading a page (which lock and unlock the range
themselves).

Since this type of functionality is needed for the upcoming changes to
the reflink implementation dealing with cloning of inline extents, bring
back this function to life.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c |  8 ++++++-
 fs/btrfs/extent_io.c   | 47 ++++++++++++++++++++++++++++++++++--------
 fs/btrfs/extent_io.h   |  3 +++
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9ab610cc9114..4096cd3b1a2f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -722,7 +722,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	faili = nr_pages - 1;
 	cb->nr_pages = nr_pages;
 
-	add_ra_bio_pages(inode, em_start + em_len, cb);
+	/*
+	 * In the parent-locked case we only locked the range we are interested
+	 * in.  In all other cases, we can opportunistically cache decompressed
+	 * data that goes beyond the requested range.
+	 */
+	if (!(bio_flags & EXTENT_BIO_PARENT_LOCKED))
+		add_ra_bio_pages(inode, em_start + em_len, cb);
 
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d644da00cca4..72b6c6d4c7e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3104,7 +3104,8 @@ static int __do_readpage(struct page *page,
 	size_t iosize;
 	size_t disk_io_size;
 	size_t blocksize = inode->i_sb->s_blocksize;
-	unsigned long this_bio_flag = 0;
+	const bool parent_locked = *bio_flags & EXTENT_BIO_PARENT_LOCKED;
+	unsigned long this_bio_flag = *bio_flags & EXTENT_BIO_PARENT_LOCKED;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	set_page_extent_mapped(page);
@@ -3144,15 +3145,19 @@ static int __do_readpage(struct page *page,
 			kunmap_atomic(userpage);
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
-			unlock_extent_cached(tree, cur,
-					     cur + iosize - 1, &cached);
+			if (parent_locked)
+				free_extent_state(cached);
+			else
+				unlock_extent_cached(tree, cur,
+						     cur + iosize - 1, &cached);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, get_extent, em_cached);
 		if (IS_ERR_OR_NULL(em)) {
 			SetPageError(page);
-			unlock_extent(tree, cur, end);
+			if (!parent_locked)
+				unlock_extent(tree, cur, end);
 			break;
 		}
 		extent_offset = cur - em->start;
@@ -3234,8 +3239,11 @@ static int __do_readpage(struct page *page,
 			flush_dcache_page(page);
 			kunmap_atomic(userpage);
 
-			set_extent_uptodate(tree, cur, cur + iosize - 1,
-					    &cached, GFP_NOFS);
+			if (parent_locked)
+				free_extent_state(cached);
+			else
+				set_extent_uptodate(tree, cur, cur + iosize - 1,
+						    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
 			cur = cur + iosize;
@@ -3246,7 +3254,8 @@ static int __do_readpage(struct page *page,
 		if (test_range_bit(tree, cur, cur_end,
 				   EXTENT_UPTODATE, 1, NULL)) {
 			check_page_uptodate(tree, page);
-			unlock_extent(tree, cur, cur + iosize - 1);
+			if (!parent_locked)
+				unlock_extent(tree, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3256,7 +3265,8 @@ static int __do_readpage(struct page *page,
 		 */
 		if (block_start == EXTENT_MAP_INLINE) {
 			SetPageError(page);
-			unlock_extent(tree, cur, cur + iosize - 1);
+			if (!parent_locked)
+				unlock_extent(tree, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3274,7 +3284,8 @@ static int __do_readpage(struct page *page,
 			*bio_flags = this_bio_flag;
 		} else {
 			SetPageError(page);
-			unlock_extent(tree, cur, cur + iosize - 1);
+			if (!parent_locked)
+				unlock_extent(tree, cur, cur + iosize - 1);
 			goto out;
 		}
 		cur = cur + iosize;
@@ -3340,6 +3351,24 @@ int extent_read_full_page(struct page *page, get_extent_t *get_extent,
 	return ret;
 }
 
+/*
+ * Similar to extent_read_full_page() but the responsability to lock the range
+ * in the respective inode is from the caller.
+ */
+int extent_read_full_page_nolock(struct page *page, get_extent_t *get_extent,
+				 int mirror_num)
+{
+	struct bio *bio = NULL;
+	unsigned long bio_flags = EXTENT_BIO_PARENT_LOCKED;
+	int ret;
+
+	ret = __do_readpage(page, get_extent, NULL, &bio, mirror_num,
+			    &bio_flags, READ, NULL);
+	if (bio)
+		ret = submit_one_bio(bio, mirror_num, bio_flags);
+	return ret;
+}
+
 static void update_nr_written(struct writeback_control *wbc,
 			      unsigned long nr_written)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 234622101230..8d891a598e24 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -12,6 +12,7 @@
  * type for this bio
  */
 #define EXTENT_BIO_COMPRESSED 1
+#define EXTENT_BIO_PARENT_LOCKED 4
 #define EXTENT_BIO_FLAG_SHIFT 16
 
 enum {
@@ -191,6 +192,8 @@ int try_release_extent_buffer(struct page *page);
 
 int extent_read_full_page(struct page *page, get_extent_t *get_extent,
 			  int mirror_num);
+int extent_read_full_page_nolock(struct page *page, get_extent_t *get_extent,
+				 int mirror_num);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
-- 
2.25.0

