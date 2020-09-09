Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1975262C7B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 11:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIIJtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 05:49:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbgIIJtX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 05:49:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C7C0B167;
        Wed,  9 Sep 2020 09:49:21 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/10] btrfs: Promote extent_read_full_page to btrfs_readpage
Date:   Wed,  9 Sep 2020 12:49:11 +0300
Message-Id: <20200909094914.29721-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909094914.29721-1-nborisov@suse.com>
References: <20200909094914.29721-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_readpage is the only caller of extent_read_full_page the
latter can be opencoded in the former. Use the occassion to rename
__extent_read_full_page to extent_read_full_page. To facillitate this
change submit_one_bio has to be exported as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 21 ++++-----------------
 fs/btrfs/extent_io.h |  5 ++++-
 fs/btrfs/inode.c     |  9 ++++++++-
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d2b71e97218c..fa5717fe27f0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -160,8 +160,8 @@ static int add_extent_changeset(struct extent_state *state, unsigned bits,
 	return ret;
 }
 
-static int __must_check submit_one_bio(struct bio *bio, int mirror_num,
-				       unsigned long bio_flags)
+int __must_check submit_one_bio(struct bio *bio, int mirror_num,
+				unsigned long bio_flags)
 {
 	blk_status_t ret = 0;
 	struct extent_io_tree *tree = bio->bi_private;
@@ -3367,9 +3367,8 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	}
 }
 
-static int __extent_read_full_page(struct page *page, struct bio **bio,
-				   int mirror_num, unsigned long *bio_flags,
-				   unsigned int read_flags)
+int extent_read_full_page(struct page *page, struct bio **bio, int mirror_num,
+			  unsigned long *bio_flags, unsigned int read_flags)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
@@ -3383,18 +3382,6 @@ static int __extent_read_full_page(struct page *page, struct bio **bio,
 	return ret;
 }
 
-int extent_read_full_page(struct page *page)
-{
-	struct bio *bio = NULL;
-	unsigned long bio_flags = 0;
-	int ret;
-
-	ret = __extent_read_full_page(page, &bio, 0, &bio_flags, 0);
-	if (bio)
-		ret = submit_one_bio(bio, 0, bio_flags);
-	return ret;
-}
-
 static void update_nr_written(struct writeback_control *wbc,
 			      unsigned long nr_written)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 96bc9f0c2981..ff1895994994 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -193,7 +193,10 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-int extent_read_full_page(struct page *page);
+int __must_check submit_one_bio(struct bio *bio, int mirror_num,
+				unsigned long bio_flags);
+int extent_read_full_page(struct page *page, struct bio **bio, int mirror_num,
+			  unsigned long *bio_flags, unsigned int read_flags);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3fd73573bbad..dcc8b5de1b9c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8036,7 +8036,14 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 int btrfs_readpage(struct file *file, struct page *page)
 {
-	return extent_read_full_page(page);
+	struct bio *bio = NULL;
+	unsigned long bio_flags = 0;
+	int ret;
+
+	ret = extent_read_full_page(page, &bio, 0, &bio_flags, 0);
+	if (bio)
+		ret = submit_one_bio(bio, 0, bio_flags);
+	return ret;
 }
 
 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
-- 
2.17.1

