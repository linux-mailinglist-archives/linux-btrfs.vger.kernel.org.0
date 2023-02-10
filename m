Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F10691957
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBJHs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBJHsz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:48:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B00E5ACF2
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7FACQOMrDZk9SWLDT7gYX5QyMcNuSlNvhkVbLVZVLEg=; b=yYcwY3ldIgMn8j29YMv7Vp0rlR
        JG7txLh6UyhA4YMOxyb/B5HoL/Uhb3hcsdS/A3fP/nX/xW6SXk8s1R3ui9kMlrX7zafxvnWjnnJlz
        PQy3jdYoOGXWtxq+pis4I8zR5jh2G5LDRquOuYw9g9q6cf30I73cIdd/K7i/t5ZQt9OBjMwsHDzy9
        jBiVRa14kj7laAFPhQgLf47wbCByRdutQ3GDWkCAeXL0GQ643FYCkdH33NnaYhpkZF/jg3VKP77Zo
        tTTV6cKW3+M8PD0g+Jp4h6wBoL+wB28IpiRldiVCXqW8oSdeL0EgH2wg3Q89FcPR979m4NqFKvr3E
        9vCugdqg==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9J-004feP-Tw; Fri, 10 Feb 2023 07:48:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: embedded a btrfs_bio into struct compressed_bio
Date:   Fri, 10 Feb 2023 08:48:34 +0100
Message-Id: <20230210074841.628201-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
References: <20230210074841.628201-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Embedd a btrfs_bio into struct compressed_bio.  This avoids potential
(so far theoretical) deadlocks due to nesting of btrfs_bioset allocations
for the original read bio and the compressed bio, and avoids an extra
memory allocation in the I/O path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 146 +++++++++++++++++++----------------------
 fs/btrfs/compression.h |  17 ++---
 fs/btrfs/extent_io.c   |   2 +-
 fs/btrfs/inode.c       |  24 ++-----
 fs/btrfs/lzo.c         |   3 +-
 5 files changed, 83 insertions(+), 109 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f42f31f22d135c..cd0cfa8fdb8c15 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -37,6 +37,8 @@
 #include "file-item.h"
 #include "super.h"
 
+struct bio_set btrfs_compressed_bioset;
+
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
 const char* btrfs_compress_type2str(enum btrfs_compression_type type)
@@ -54,6 +56,24 @@ const char* btrfs_compress_type2str(enum btrfs_compression_type type)
 	return NULL;
 }
 
+static inline struct compressed_bio *to_compressed_bio(struct btrfs_bio *bbio)
+{
+	return container_of(bbio, struct compressed_bio, bbio);
+}
+
+static struct compressed_bio *alloc_compressed_bio(struct btrfs_inode *inode,
+						   u64 start, blk_opf_t op,
+						   btrfs_bio_end_io_t end_io)
+{
+	struct btrfs_bio *bbio;
+
+	bbio = btrfs_bio(bio_alloc_bioset(NULL, BTRFS_MAX_COMPRESSED_PAGES, op,
+					  GFP_NOFS, &btrfs_compressed_bioset));
+	btrfs_bio_init(bbio, inode, end_io, NULL);
+	bbio->file_offset = start;
+	return to_compressed_bio(bbio);
+}
+
 bool btrfs_compress_is_valid_type(const char *str, size_t len)
 {
 	int i;
@@ -143,14 +163,13 @@ static int btrfs_decompress_bio(struct compressed_bio *cb);
 
 static void end_compressed_bio_read(struct btrfs_bio *bbio)
 {
-	struct compressed_bio *cb = bbio->private;
+	struct compressed_bio *cb = to_compressed_bio(bbio);
+	blk_status_t status = bbio->bio.bi_status;
 	unsigned int index;
 	struct page *page;
 
-	if (bbio->bio.bi_status)
-		cb->status = bbio->bio.bi_status;
-	else
-		cb->status = errno_to_blk_status(btrfs_decompress_bio(cb));
+	if (!status)
+		status = errno_to_blk_status(btrfs_decompress_bio(cb));
 
 	/* Release the compressed pages */
 	for (index = 0; index < cb->nr_pages; index++) {
@@ -160,11 +179,10 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
 	}
 
 	/* Do io completion on the original bio */
-	btrfs_bio_end_io(btrfs_bio(cb->orig_bio), cb->status);
+	btrfs_bio_end_io(btrfs_bio(cb->orig_bio), status);
 
 	/* Finally free the cb struct */
 	kfree(cb->compressed_pages);
-	kfree(cb);
 	bio_put(&bbio->bio);
 }
 
@@ -172,14 +190,14 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
  * Clear the writeback bits on all of the file
  * pages for a compressed write
  */
-static noinline void end_compressed_writeback(struct inode *inode,
-					      const struct compressed_bio *cb)
+static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 {
+	struct inode *inode = &cb->bbio.inode->vfs_inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
-	const int errno = blk_status_to_errno(cb->status);
+	const int errno = blk_status_to_errno(cb->bbio.bio.bi_status);
 	int i;
 	int ret;
 
@@ -209,19 +227,18 @@ static noinline void end_compressed_writeback(struct inode *inode,
 
 static void finish_compressed_bio_write(struct compressed_bio *cb)
 {
-	struct inode *inode = cb->inode;
 	unsigned int index;
 
 	/*
 	 * Ok, we're the last bio for this extent, step one is to call back
 	 * into the FS and do all the end_io operations.
 	 */
-	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
+	btrfs_writepage_endio_finish_ordered(cb->bbio.inode, NULL,
 			cb->start, cb->start + cb->len - 1,
-			cb->status == BLK_STS_OK);
+			cb->bbio.bio.bi_status == BLK_STS_OK);
 
 	if (cb->writeback)
-		end_compressed_writeback(inode, cb);
+		end_compressed_writeback(cb);
 	/* Note, our inode could be gone now */
 
 	/*
@@ -237,7 +254,7 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
 
 	/* Finally free the cb struct */
 	kfree(cb->compressed_pages);
-	kfree(cb);
+	bio_put(&cb->bbio.bio);
 }
 
 static void btrfs_finish_compressed_write_work(struct work_struct *work)
@@ -257,13 +274,10 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
  */
 static void end_compressed_bio_write(struct btrfs_bio *bbio)
 {
-	struct compressed_bio *cb = bbio->private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	struct compressed_bio *cb = to_compressed_bio(bbio);
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
-	cb->status = bbio->bio.bi_status;
 	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
-
-	bio_put(&bbio->bio);
 }
 
 /*
@@ -275,7 +289,7 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
  * This also checksums the file bytes and gets things ready for
  * the end io hooks.
  */
-blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
+void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 unsigned int len, u64 disk_start,
 				 unsigned int compressed_len,
 				 struct page **compressed_pages,
@@ -285,18 +299,21 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 bool writeback)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *bio = NULL;
+	struct bio *bio;
 	struct compressed_bio *cb;
 	u64 cur_disk_bytenr = disk_start;
-	blk_status_t ret = BLK_STS_OK;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
-	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
-	if (!cb)
-		return BLK_STS_RESOURCE;
-	cb->status = BLK_STS_OK;
-	cb->inode = &inode->vfs_inode;
+
+	if (blkcg_css) {
+		kthread_associate_blkcg(blkcg_css);
+		write_flags |= REQ_CGROUP_PUNT;
+	}
+	write_flags |= REQ_BTRFS_ONE_ORDERED;
+
+	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE | write_flags,
+				  end_compressed_bio_write);
 	cb->start = start;
 	cb->len = len;
 	cb->compressed_pages = compressed_pages;
@@ -305,16 +322,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 
-	if (blkcg_css) {
-		kthread_associate_blkcg(blkcg_css);
-		write_flags |= REQ_CGROUP_PUNT;
-	}
-
-	write_flags |= REQ_BTRFS_ONE_ORDERED;
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_WRITE | write_flags,
-			      BTRFS_I(cb->inode), end_compressed_bio_write, cb);
-	bio->bi_iter.bi_sector = cur_disk_bytenr >> SECTOR_SHIFT;
-	btrfs_bio(bio)->file_offset = start;
+	bio = &cb->bbio.bio;
+	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 
 	while (cur_disk_bytenr < disk_start + compressed_len) {
 		u64 offset = cur_disk_bytenr - disk_start;
@@ -346,7 +355,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	btrfs_submit_bio(bio, 0);
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
-	return ret;
 }
 
 static u64 bio_end_offset(struct bio *bio)
@@ -515,11 +523,11 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-				  int mirror_num)
+void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_map_tree *em_tree;
+	struct btrfs_inode *inode = btrfs_bio(bio)->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
 	struct bio *comp_bio;
@@ -533,9 +541,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	int memstall = 0;
 	blk_status_t ret;
 	int ret2;
-	int i;
-
-	em_tree = &BTRFS_I(inode)->extent_tree;
 
 	file_offset = bio_first_bvec_all(bio)->bv_offset +
 		      page_offset(bio_first_page_all(bio));
@@ -551,14 +556,11 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
 	compressed_len = em->block_len;
-	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
-	if (!cb) {
-		ret = BLK_STS_RESOURCE;
-		goto out;
-	}
 
-	cb->status = BLK_STS_OK;
-	cb->inode = inode;
+	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
+				  end_compressed_bio_read);
+	comp_bio = &cb->bbio.bio;
+	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 
 	cb->start = em->orig_start;
 	em_len = em->len;
@@ -576,24 +578,21 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	cb->compressed_pages = kcalloc(cb->nr_pages, sizeof(struct page *), GFP_NOFS);
 	if (!cb->compressed_pages) {
 		ret = BLK_STS_RESOURCE;
-		goto fail;
+		goto out_free_bio;
 	}
 
 	ret2 = btrfs_alloc_page_array(cb->nr_pages, cb->compressed_pages);
 	if (ret2) {
 		ret = BLK_STS_RESOURCE;
-		goto fail;
+		goto out_free_compressed_pages;
 	}
 
-	add_ra_bio_pages(inode, em_start + em_len, cb, &memstall, &pflags);
+	add_ra_bio_pages(&inode->vfs_inode, em_start + em_len, cb, &memstall,
+			 &pflags);
 
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, BTRFS_I(cb->inode),
-				   end_compressed_bio_read, cb);
-	comp_bio->bi_iter.bi_sector = (cur_disk_byte >> SECTOR_SHIFT);
-
 	while (cur_disk_byte < disk_bytenr + compressed_len) {
 		u64 offset = cur_disk_byte - disk_bytenr;
 		unsigned int index = offset >> PAGE_SHIFT;
@@ -622,31 +621,17 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	/*
-	 * Stash the initial offset of this chunk, as there is no direct
-	 * correlation between compressed pages and the original file offset.
-	 * The field is only used for printing error messages anyway.
-	 */
-	btrfs_bio(comp_bio)->file_offset = file_offset;
-
 	ASSERT(comp_bio->bi_iter.bi_size);
 	btrfs_submit_bio(comp_bio, mirror_num);
 	return;
 
-fail:
-	if (cb->compressed_pages) {
-		for (i = 0; i < cb->nr_pages; i++) {
-			if (cb->compressed_pages[i])
-				__free_page(cb->compressed_pages[i]);
-		}
-	}
-
+out_free_compressed_pages:
 	kfree(cb->compressed_pages);
-	kfree(cb);
-out:
+out_free_bio:
+	bio_put(comp_bio);
 	free_extent_map(em);
+out:
 	btrfs_bio_end_io(btrfs_bio(bio), ret);
-	return;
 }
 
 /*
@@ -1062,6 +1047,10 @@ int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 
 int __init btrfs_init_compress(void)
 {
+	if (bioset_init(&btrfs_compressed_bioset, BIO_POOL_SIZE,
+			offsetof(struct compressed_bio, bbio.bio),
+			BIOSET_NEED_BVECS))
+		return -ENOMEM;
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
@@ -1075,6 +1064,7 @@ void __cold btrfs_exit_compress(void)
 	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_ZLIB);
 	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_LZO);
 	zstd_cleanup_workspace_manager();
+	bioset_exit(&btrfs_compressed_bioset);
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index a5e3377db9adc9..e73526a23c502c 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -6,8 +6,8 @@
 #ifndef BTRFS_COMPRESSION_H
 #define BTRFS_COMPRESSION_H
 
-#include <linux/blk_types.h>
 #include <linux/sizes.h>
+#include "bio.h"
 
 struct btrfs_inode;
 
@@ -23,6 +23,8 @@ struct btrfs_inode;
 
 /* Maximum length of compressed data stored on disk */
 #define BTRFS_MAX_COMPRESSED		(SZ_128K)
+#define BTRFS_MAX_COMPRESSED_PAGES \
+	(BTRFS_MAX_COMPRESSED / PAGE_SIZE)
 static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 
 /* Maximum size of data before compression */
@@ -37,9 +39,6 @@ struct compressed_bio {
 	/* the pages with the compressed data on them */
 	struct page **compressed_pages;
 
-	/* inode that owns this data */
-	struct inode *inode;
-
 	/* starting offset in the inode for our pages */
 	u64 start;
 
@@ -55,14 +54,13 @@ struct compressed_bio {
 	/* Whether this is a write for writeback. */
 	bool writeback;
 
-	/* IO errors */
-	blk_status_t status;
-
 	union {
 		/* For reads, this is the bio we are copying the data into */
 		struct bio *orig_bio;
 		struct work_struct write_end_work;
 	};
+
+	struct btrfs_bio bbio;
 };
 
 static inline unsigned int btrfs_compress_type(unsigned int type_level)
@@ -88,7 +86,7 @@ int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
 
-blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
+void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  unsigned int len, u64 disk_start,
 				  unsigned int compressed_len,
 				  struct page **compressed_pages,
@@ -96,8 +94,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  blk_opf_t write_flags,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
-void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-				  int mirror_num);
+void btrfs_submit_compressed_read(struct bio *bio, int mirror_num);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 287e25edb3ef4c..833c7a94529b89 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -158,7 +158,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	if (btrfs_op(bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(inode, bio, mirror_num);
+		btrfs_submit_compressed_read(bio, mirror_num);
 	else
 		btrfs_submit_bio(bio, mirror_num);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2fd518afc4f317..adace0ce13a825 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -669,8 +669,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 again:
 	will_compress = 0;
 	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
-	nr_pages = min_t(unsigned long, nr_pages,
-			BTRFS_MAX_COMPRESSED / PAGE_SIZE);
+	nr_pages = min_t(unsigned long, nr_pages, BTRFS_MAX_COMPRESSED_PAGES);
 
 	/*
 	 * we don't want to send crud past the end of i_size through
@@ -1054,23 +1053,14 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	extent_clear_unlock_delalloc(inode, start, end,
 			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
-	if (btrfs_submit_compressed_write(inode, start,	/* file_offset */
+	btrfs_submit_compressed_write(inode, start,	/* file_offset */
 			    async_extent->ram_size,	/* num_bytes */
 			    ins.objectid,		/* disk_bytenr */
 			    ins.offset,			/* compressed_len */
 			    async_extent->pages,	/* compressed_pages */
 			    async_extent->nr_pages,
 			    async_chunk->write_flags,
-			    async_chunk->blkcg_css, true)) {
-		const u64 start = async_extent->start;
-		const u64 end = start + async_extent->ram_size - 1;
-
-		btrfs_writepage_endio_finish_ordered(inode, NULL, start, end, 0);
-
-		extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
-					     PAGE_END_WRITEBACK | PAGE_SET_ERROR);
-		free_async_extent_pages(async_extent);
-	}
+			    async_chunk->blkcg_css, true);
 	*alloc_hint = ins.objectid + ins.offset;
 	kfree(async_extent);
 	return ret;
@@ -10393,13 +10383,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
-	if (btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
+	btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
 					  ins.offset, pages, nr_pages, 0, NULL,
-					  false)) {
-		btrfs_writepage_endio_finish_ordered(inode, pages[0], start, end, 0);
-		ret = -EIO;
-		goto out_pages;
-	}
+					  false);
 	ret = orig_count;
 	goto out;
 
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 71f6d8302d50e2..dc66ee98989e90 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -17,6 +17,7 @@
 #include "compression.h"
 #include "ctree.h"
 #include "super.h"
+#include "btrfs_inode.h"
 
 #define LZO_LEN	4
 
@@ -329,7 +330,7 @@ static void copy_compressed_segment(struct compressed_bio *cb,
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	const struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	const struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 	char *kaddr;
 	int ret;
-- 
2.39.1

