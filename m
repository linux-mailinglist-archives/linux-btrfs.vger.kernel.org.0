Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8914E268A3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgINLjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 07:39:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgINLjV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 07:39:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 365A0AD0F;
        Mon, 14 Sep 2020 11:39:33 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Opencode extent_read_full_page to its sole caller
Date:   Mon, 14 Sep 2020 14:39:16 +0300
Message-Id: <20200914113916.29852-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This makes reading the code a tad easier by decreasing the level of
indirection by one.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
David,

Here is a followup patch based on Johaness' feedback if you could merge it
after having merged the whole series I'll much appreciated it.

 fs/btrfs/extent_io.c | 24 +++++-------------------
 fs/btrfs/extent_io.h |  5 +++--
 fs/btrfs/inode.c     |  9 +++++++--
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ef857c0d784..afac70ef0cc5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3141,9 +3141,9 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  * XXX JDM: This needs looking at to ensure proper page locking
  * return 0 on success, otherwise return error
  */
-static int __do_readpage(struct page *page, struct extent_map **em_cached,
-			 struct bio **bio, unsigned long *bio_flags,
-			 unsigned int read_flags, u64 *prev_em_start)
+int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
+		      struct bio **bio, unsigned long *bio_flags,
+		      unsigned int read_flags, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
 	u64 start = page_offset(page);
@@ -3358,26 +3358,12 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);

 	for (index = 0; index < nr_pages; index++) {
-		__do_readpage(pages[index], em_cached, bio, bio_flags,
-			      REQ_RAHEAD, prev_em_start);
+		btrfs_do_readpage(pages[index], em_cached, bio, bio_flags,
+				  REQ_RAHEAD, prev_em_start);
 		put_page(pages[index]);
 	}
 }

-int extent_read_full_page(struct page *page, struct bio **bio,
-			  unsigned long *bio_flags)
-{
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
-	int ret;
-
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
-	ret = __do_readpage(page, NULL, bio, bio_flags, 0, NULL);
-	return ret;
-}
-
 static void update_nr_written(struct writeback_control *wbc,
 			      unsigned long nr_written)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5fa248570145..3bbc25b816ea 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -195,8 +195,9 @@ int try_release_extent_buffer(struct page *page);

 int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 				unsigned long bio_flags);
-int extent_read_full_page(struct page *page, struct bio **bio,
-			  unsigned long *bio_flags);
+int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
+		      struct bio **bio, unsigned long *bio_flags,
+		      unsigned int read_flags, u64 *prev_em_start);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c50a907742a1..245c80aaf7a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8040,11 +8040,16 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,

 int btrfs_readpage(struct file *file, struct page *page)
 {
-	struct bio *bio = NULL;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	u64 start = page_offset(page);
+	u64 end = start + PAGE_SIZE - 1;
 	unsigned long bio_flags = 0;
+	struct bio *bio = NULL;
 	int ret;

-	ret = extent_read_full_page(page, &bio, &bio_flags);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
+
+	ret = btrfs_do_readpage(page, NULL, &bio, &bio_flags, 0, NULL);
 	if (bio)
 		ret = submit_one_bio(bio, 0, bio_flags);
 	return ret;
--
2.17.1

