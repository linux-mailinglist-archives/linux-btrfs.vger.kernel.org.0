Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2853526889A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgINJh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgINJhT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62A8BAF43;
        Mon, 14 Sep 2020 09:37:32 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 6/9] btrfs: Promote extent_read_full_page to btrfs_readpage
Date:   Mon, 14 Sep 2020 12:37:08 +0300
Message-Id: <20200914093711.13523-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_readpage is the only caller of extent_read_full_page the
latter can be opencoded in the former. Use the occassion to rename
__extent_read_full_page to extent_read_full_page. To facillitate this
change submit_one_bio has to be exported as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 21 ++++-----------------
 fs/btrfs/extent_io.h |  5 ++++-
 fs/btrfs/inode.c     |  9 ++++++++-
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 355db40a1cb5..402b88ddcbca 100644
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
@@ -3365,9 +3365,8 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
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
@@ -3381,18 +3380,6 @@ static int __extent_read_full_page(struct page *page, struct bio **bio,
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
index 0ccb2dabc291..8fec00c50846 100644
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
index e78099d1db34..f01066607901 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8040,7 +8040,14 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,

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

