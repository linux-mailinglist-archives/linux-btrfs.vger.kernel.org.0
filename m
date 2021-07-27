Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964A3D794E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhG0PGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 11:06:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhG0PF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 11:05:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 62DEC1FF14;
        Tue, 27 Jul 2021 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627398357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu46LuQG39Wi9vw+H4BkuYQTajN4g+gBOMaNSoDTr2U=;
        b=oLGoBFPiHqO4dq4HvGnr8EWDwtz0Gdlbr40/gSDInRDdtOA2fFDf2PkkH1Y1rGVH6W/2tn
        oiRpZ1QQ7LuBrDy5hv+9R1SqMxKzEGrkdRnfilhx/OWTUYa/AR1yX1BjNU3dE6rusguEJG
        gem3mFKAoncNBIn3bvvbm6eH0KpSawc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5CD80A3B88;
        Tue, 27 Jul 2021 15:05:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DDEFDA8CC; Tue, 27 Jul 2021 17:03:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, wqu@suse.com
Subject: [PATCH v2 10/10] btrfs: add and use simple page/bio to inode/fs_info helpers
Date:   Tue, 27 Jul 2021 17:03:02 +0200
Message-Id: <20210727150302.21604-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
References: <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have lots of places where we want to obtain inode from page, fs_info
from page and open code the pointer chains.

Add helpers for the most common actions where the types match. There are
still unconverted cases that don't have btrfs_inode and need this
conversion first.

The assertion is supposed to catch unexpected pages without mapping.

Signed-off-by: David Sterba <dsterba@suse.com>
---

v2:

- add page->mapping assertion

 fs/btrfs/disk-io.c   | 24 +++++++++++++-----------
 fs/btrfs/extent_io.c | 33 ++++++++++++++++-----------------
 fs/btrfs/inode.c     |  4 ++--
 fs/btrfs/misc.h      | 10 ++++++++++
 4 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b117dd3b8172..cdb7791b00d7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -19,6 +19,7 @@
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
+#include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -633,7 +634,7 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
 				   int mirror)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct extent_buffer *eb;
 	bool reads_done;
 	int ret = 0;
@@ -693,7 +694,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 
 	ASSERT(page->private);
 
-	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
 		return validate_subpage_buffer(page, start, end, mirror);
 
 	eb = (struct extent_buffer *)page->private;
@@ -876,14 +877,14 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 static blk_status_t btree_csum_one_bio(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	struct btrfs_root *root;
 	int ret = 0;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec);
+		struct btrfs_fs_info *fs_info = page_to_fs_info(bvec->bv_page);
+
+		ret = csum_dirty_buffer(fs_info, bvec);
 		if (ret)
 			break;
 	}
@@ -1010,11 +1011,13 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct extent_io_tree *tree;
-	tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = page_to_inode(page);
+
+	tree = &inode->io_tree;
 	extent_invalidatepage(tree, page, offset);
 	btree_releasepage(page, GFP_NOFS);
 	if (PagePrivate(page)) {
-		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
+		btrfs_warn(inode->root->fs_info,
 			   "page private not zero on page %llu",
 			   (unsigned long long)page_offset(page));
 		detach_page_private(page);
@@ -1024,7 +1027,7 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 static int btree_set_page_dirty(struct page *page)
 {
 #ifdef DEBUG
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct btrfs_subpage *subpage;
 	struct extent_buffer *eb;
 	int cur_bit = 0;
@@ -4437,14 +4440,13 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic)
 {
 	int ret;
-	struct inode *btree_inode = buf->pages[0]->mapping->host;
+	struct btrfs_inode *inode = page_to_inode(buf->pages[0]);
 
 	ret = extent_buffer_uptodate(buf);
 	if (!ret)
 		return ret;
 
-	ret = verify_parent_transid(&BTRFS_I(btree_inode)->io_tree, buf,
-				    parent_transid, atomic);
+	ret = verify_parent_transid(&inode->io_tree, buf, parent_transid, atomic);
 	if (ret == -EAGAIN)
 		return ret;
 	return !ret;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19ba5b03b2df..cb4020ce6419 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2682,7 +2682,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
@@ -2783,7 +2783,7 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 	int ret = 0;
 
 	ASSERT(page && page->mapping);
-	inode = BTRFS_I(page->mapping->host);
+	inode = page_to_inode(page);
 	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate);
 
 	if (!uptodate) {
@@ -2815,8 +2815,8 @@ static void end_bio_extent_writepage(struct bio *bio)
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		struct btrfs_inode *inode = page_to_inode(page);
+		struct btrfs_fs_info *fs_info = inode->root->fs_info;
 		const u32 sectorsize = fs_info->sectorsize;
 
 		/* Our read/write should always be sector aligned. */
@@ -2833,7 +2833,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 		end = start + bvec->bv_len - 1;
 
 		if (first_bvec) {
-			btrfs_record_physical_zoned(inode, start, bio);
+			btrfs_record_physical_zoned(&inode->vfs_inode, start, bio);
 			first_bvec = false;
 		}
 
@@ -3306,7 +3306,7 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
@@ -3334,7 +3334,7 @@ static int submit_extent_page(unsigned int opf,
 	bio_add_page(bio, page, io_size, pg_offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
-	bio->bi_write_hint = page->mapping->host->i_write_hint;
+	bio->bi_write_hint = inode->vfs_inode.i_write_hint;
 	bio->bi_opf = opf;
 	if (wbc) {
 		struct block_device *bdev;
@@ -3410,8 +3410,7 @@ int set_page_extent_mapped(struct page *page)
 	if (PagePrivate(page))
 		return 0;
 
-	fs_info = btrfs_sb(page->mapping->host->i_sb);
-
+	fs_info = page_to_fs_info(page);
 	if (fs_info->sectorsize < PAGE_SIZE)
 		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
 
@@ -3428,7 +3427,7 @@ void clear_page_extent_mapped(struct page *page)
 	if (!PagePrivate(page))
 		return;
 
-	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	fs_info = page_to_fs_info(page);
 	if (fs_info->sectorsize < PAGE_SIZE)
 		return btrfs_detach_subpage(fs_info, page);
 
@@ -3670,7 +3669,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					struct btrfs_bio_ctrl *bio_ctrl,
 					u64 *prev_em_start)
 {
-	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(pages[0]);
 	int index;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
@@ -4258,7 +4257,7 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
-	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
+	fs_info = bio_to_fs_info(bio);
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -4480,7 +4479,7 @@ static int submit_eb_subpage(struct page *page,
 			     struct writeback_control *wbc,
 			     struct extent_page_data *epd)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	int submitted = 0;
 	u64 page_start = page_offset(page);
 	int bit_start = 0;
@@ -4586,7 +4585,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!PagePrivate(page))
 		return 0;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
 		return submit_eb_subpage(page, wbc, epd);
 
 	spin_lock(&mapping->private_lock);
@@ -5122,7 +5121,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	struct extent_map *em;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_inode *btrfs_inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *btrfs_inode = page_to_inode(page);
 	struct extent_io_tree *tree = &btrfs_inode->io_tree;
 	struct extent_map_tree *map = &btrfs_inode->extent_tree;
 
@@ -7080,7 +7079,7 @@ static struct extent_buffer *get_next_extent_buffer(
 
 static int try_release_subpage_extent_buffer(struct page *page)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	u64 cur = page_offset(page);
 	const u64 end = page_offset(page) + PAGE_SIZE;
 	int ret;
@@ -7152,7 +7151,7 @@ int try_release_extent_buffer(struct page *page)
 {
 	struct extent_buffer *eb;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
 		return try_release_subpage_extent_buffer(page);
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d31aba370632..159cb2d6a69e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8348,7 +8348,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 int btrfs_readpage(struct file *file, struct page *page)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { 0 };
@@ -8443,7 +8443,7 @@ static int btrfs_migratepage(struct address_space *mapping,
 static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct extent_state *cached_state = NULL;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 6461ebc3a1c1..9a94ee8dd47b 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -10,6 +10,16 @@
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
+#define page_to_inode(page)						\
+({									\
+	struct address_space *page_mapping = (page)->mapping;		\
+	ASSERT(page_mapping);						\
+	BTRFS_I(page_mapping->host);					\
+})
+
+#define page_to_fs_info(page)	(page_to_inode(page)->root->fs_info)
+#define bio_to_fs_info(bio)	(page_to_fs_info(bio_first_page_all(bio)))
+
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
-- 
2.31.1

