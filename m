Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF140A278
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhINB1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:27:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57148 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbhINB1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:27:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89DD321DCB
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631582751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOqxpLkpDsq+0OJwGw/zEUgfifQtMzgP2bFrb1Ahjkw=;
        b=d0LtAr6X+T+YaI2k2WIvopkALwJEk5ntGpiZFRh4e1qs26E0YhpFHxtvvPQvSwM5iW23Og
        H0+/3JX87De62+3kK/orv7d9CrJNDRJAP9Lddg8jSZrUdbVEJAaLMqJkEN4/WG9S2JnJS2
        quFZHxDwhSpx3Pw9FeK2zQFmXPg9G1k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9EB2139E0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 01:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QNHVHR76P2HafQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 01:25:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: rename struct btrfs_io_bio to btrfs_bio
Date:   Tue, 14 Sep 2021 09:25:43 +0800
Message-Id: <20210914012543.12746-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914012543.12746-1-wqu@suse.com>
References: <20210914012543.12746-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we have "struct btrfs_bio", which records IO context for
stripe IO, and "strcut btrfs_io_bio", which records extra btrfs specific
info for logical bytenr bio.

With "strcut btrfs_bio" renamed to "struct btrfs_io_context", we are
safe to rename "strcut btrfs_io_bio" to "strcut btrfs_bio" which is a
more suitable name now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/compression.c     | 16 +++++-----
 fs/btrfs/ctree.h           |  3 +-
 fs/btrfs/disk-io.c         |  2 +-
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/extent_io.c       | 64 +++++++++++++++++++-------------------
 fs/btrfs/extent_io.h       |  2 +-
 fs/btrfs/file-item.c       | 12 +++----
 fs/btrfs/inode.c           | 42 ++++++++++++-------------
 fs/btrfs/raid56.c          |  8 ++---
 fs/btrfs/scrub.c           | 14 ++++-----
 fs/btrfs/volumes.c         |  8 ++---
 fs/btrfs/volumes.h         | 29 +++++++++--------
 13 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 81b11124b67a..ed646f2b46f4 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1561,7 +1561,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		struct bio *bio;
 		unsigned int j;
 
-		bio = btrfs_io_bio_alloc(num_pages - i);
+		bio = btrfs_bio_alloc(num_pages - i);
 		bio_set_dev(bio, block_ctx->dev->bdev);
 		bio->bi_iter.bi_sector = dev_bytenr >> 9;
 		bio->bi_opf = REQ_OP_READ;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2475dc0b1c22..a2dbdea899bc 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -179,9 +179,9 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 			if (memcmp(&csum, cb_sum, csum_size) != 0) {
 				btrfs_print_data_csum_error(inode, disk_start,
 						csum, cb_sum, cb->mirror_num);
-				if (btrfs_io_bio(bio)->device)
+				if (btrfs_bio(bio)->device)
 					btrfs_dev_stat_inc_and_print(
-						btrfs_io_bio(bio)->device,
+						btrfs_bio(bio)->device,
 						BTRFS_DEV_STAT_CORRUPTION_ERRS);
 				return -EIO;
 			}
@@ -208,7 +208,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	struct inode *inode;
 	struct page *page;
 	unsigned int index;
-	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
+	unsigned int mirror = btrfs_bio(bio)->mirror_num;
 	int ret = 0;
 
 	if (bio->bi_status)
@@ -224,7 +224,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	 * Record the correct mirror_num in cb->orig_bio so that
 	 * read-repair can work properly.
 	 */
-	btrfs_io_bio(cb->orig_bio)->mirror_num = mirror;
+	btrfs_bio(cb->orig_bio)->mirror_num = mirror;
 	cb->mirror_num = mirror;
 
 	/*
@@ -418,7 +418,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_bio_alloc(0);
 	bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
 	bio->bi_opf = bio_op | write_flags;
 	bio->bi_private = cb;
@@ -491,7 +491,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				bio_endio(bio);
 			}
 
-			bio = btrfs_io_bio_alloc(0);
+			bio = btrfs_bio_alloc(0);
 			bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
 			bio->bi_opf = bio_op | write_flags;
 			bio->bi_private = cb;
@@ -750,7 +750,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_io_bio_alloc(0);
+	comp_bio = btrfs_bio_alloc(0);
 	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
@@ -809,7 +809,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				bio_endio(comp_bio);
 			}
 
-			comp_bio = btrfs_io_bio_alloc(0);
+			comp_bio = btrfs_bio_alloc(0);
 			comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 			comp_bio->bi_opf = REQ_OP_READ;
 			comp_bio->bi_private = cb;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 38870ae46cbb..8c6ee947a68d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -48,6 +48,7 @@ extern struct kmem_cache *btrfs_free_space_cachep;
 extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
 struct btrfs_ordered_sum;
 struct btrfs_ref;
+struct btrfs_bio;
 
 #define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
 
@@ -3133,7 +3134,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
+unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio, u32 bio_offset,
 				    struct page *page, u64 start, u64 end);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d80e5b22d32..d294b28d5c63 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -683,7 +683,7 @@ static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
 	return ret;
 }
 
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
+int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0e7e9526b6a8..1d3b749c405a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -81,7 +81,7 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
+int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ef7c506aee6..4025897b1f86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -241,7 +241,7 @@ int __init extent_io_init(void)
 		return -ENOMEM;
 
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_io_bio, bio),
+			offsetof(struct btrfs_bio, bio),
 			BIOSET_NEED_BVECS))
 		goto free_buffer_cache;
 
@@ -2299,7 +2299,7 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_repair_one_zone(fs_info, logical);
 
-	bio = btrfs_io_bio_alloc(1);
+	bio = btrfs_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
@@ -2618,10 +2618,10 @@ int btrfs_repair_one_sector(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
+	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
-	struct btrfs_io_bio *repair_io_bio;
+	struct btrfs_bio *repair_bbio;
 	blk_status_t status;
 
 	btrfs_debug(fs_info,
@@ -2639,24 +2639,24 @@ int btrfs_repair_one_sector(struct inode *inode,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_io_bio_alloc(1);
-	repair_io_bio = btrfs_io_bio(repair_bio);
+	repair_bio = btrfs_bio_alloc(1);
+	repair_bbio = btrfs_bio(repair_bio);
 	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
 
-	if (failed_io_bio->csum) {
+	if (failed_bbio->csum) {
 		const u32 csum_size = fs_info->csum_size;
 
-		repair_io_bio->csum = repair_io_bio->csum_inline;
-		memcpy(repair_io_bio->csum,
-		       failed_io_bio->csum + csum_size * icsum, csum_size);
+		repair_bbio->csum = repair_bbio->csum_inline;
+		memcpy(repair_bbio->csum,
+		       failed_bbio->csum + csum_size * icsum, csum_size);
 	}
 
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_io_bio->logical = failrec->start;
-	repair_io_bio->iter = repair_bio->bi_iter;
+	repair_bbio->logical = failrec->start;
+	repair_bbio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
 		    "repair read error: submitting new read to mirror %d",
@@ -2976,7 +2976,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
 static void end_bio_extent_readpage(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
@@ -3003,7 +3003,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
-			io_bio->mirror_num);
+			bbio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
 		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
@@ -3028,14 +3028,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
-		mirror = io_bio->mirror_num;
+		mirror = bbio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode)) {
-				error_bitmap = btrfs_verify_data_csum(io_bio,
+				error_bitmap = btrfs_verify_data_csum(bbio,
 						bio_offset, page, start, end);
 				ret = error_bitmap;
 			} else {
-				ret = btrfs_validate_metadata_buffer(io_bio,
+				ret = btrfs_validate_metadata_buffer(bbio,
 					page, start, end, mirror);
 			}
 			if (ret)
@@ -3106,7 +3106,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	btrfs_io_bio_free_csum(io_bio);
+	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
 
@@ -3115,9 +3115,9 @@ static void end_bio_extent_readpage(struct bio *bio)
  * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
  * 'bio' because use of __GFP_ZERO is not supported.
  */
-static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
+static inline void btrfs_bio_init(struct btrfs_bio *btrfs_bio)
 {
-	memset(btrfs_bio, 0, offsetof(struct btrfs_io_bio, bio));
+	memset(btrfs_bio, 0, offsetof(struct btrfs_bio, bio));
 }
 
 /*
@@ -3126,7 +3126,7 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
  * If @nr_iovecs is 0, it will use BIO_MAX_VECS as @nr_iovces instead.
  * This behavior is to provide a fail-safe default value.
  */
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
+struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
 {
 	struct bio *bio;
 
@@ -3134,27 +3134,27 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
 	if (nr_iovecs == 0)
 		nr_iovecs = BIO_MAX_VECS;
 	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
-	btrfs_io_bio_init(btrfs_io_bio(bio));
+	btrfs_bio_init(btrfs_bio(bio));
 	return bio;
 }
 
 struct bio *btrfs_bio_clone(struct bio *bio)
 {
-	struct btrfs_io_bio *btrfs_bio;
+	struct btrfs_bio *bbio;
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
 	new = bio_clone_fast(bio, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio = btrfs_io_bio(new);
-	btrfs_io_bio_init(btrfs_bio);
-	btrfs_bio->iter = bio->bi_iter;
+	bbio = btrfs_bio(new);
+	btrfs_bio_init(bbio);
+	bbio->iter = bio->bi_iter;
 	return new;
 }
 
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 {
 	struct bio *bio;
-	struct btrfs_io_bio *btrfs_bio;
+	struct btrfs_bio *bbio;
 
 	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
 
@@ -3162,11 +3162,11 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	bio = bio_clone_fast(orig, GFP_NOFS, &btrfs_bioset);
 	ASSERT(bio);
 
-	btrfs_bio = btrfs_io_bio(bio);
-	btrfs_io_bio_init(btrfs_bio);
+	bbio = btrfs_bio(bio);
+	btrfs_bio_init(bbio);
 
 	bio_trim(bio, offset >> 9, size >> 9);
-	btrfs_bio->iter = bio->bi_iter;
+	bbio->iter = bio->bi_iter;
 	return bio;
 }
 
@@ -3300,7 +3300,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_bio_alloc(0);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3335,7 +3335,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			goto error;
 		}
 
-		btrfs_io_bio(bio)->device = device;
+		btrfs_bio(bio)->device = device;
 	}
 	return 0;
 error:
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 81fa68eaa699..a3ecfd4f37ac 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -278,7 +278,7 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
+struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2673c6ba7a4e..47fe65921387 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -358,7 +358,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
  * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
  *       checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
  *       NULL, the checksum buffer is allocated and returned in
- *       btrfs_io_bio(bio)->csum instead.
+ *       btrfs_bio(bio)->csum instead.
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
@@ -397,19 +397,19 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 		return BLK_STS_RESOURCE;
 
 	if (!dst) {
-		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
+		struct btrfs_bio *btrfs_bbio = btrfs_bio(bio);
 
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
-			btrfs_bio->csum = kmalloc_array(nblocks, csum_size,
+			btrfs_bbio->csum = kmalloc_array(nblocks, csum_size,
 							GFP_NOFS);
-			if (!btrfs_bio->csum) {
+			if (!btrfs_bbio->csum) {
 				btrfs_free_path(path);
 				return BLK_STS_RESOURCE;
 			}
 		} else {
-			btrfs_bio->csum = btrfs_bio->csum_inline;
+			btrfs_bbio->csum = btrfs_bbio->csum_inline;
 		}
-		csum = btrfs_bio->csum;
+		csum = btrfs_bbio->csum;
 	} else {
 		csum = dst;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a3ce50289888..a1f5cd993112 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3212,7 +3212,7 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  *
  * The length of such check is always one sector size.
  */
-static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
+static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 			   u32 bio_offset, struct page *page, u32 pgoff,
 			   u64 start)
 {
@@ -3228,7 +3228,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
-	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
+	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -3242,9 +3242,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	return 0;
 zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
-				    io_bio->mirror_num);
-	if (io_bio->device)
-		btrfs_dev_stat_inc_and_print(io_bio->device,
+				    bbio->mirror_num);
+	if (bbio->device)
+		btrfs_dev_stat_inc_and_print(bbio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
@@ -3264,7 +3264,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * Return a bitmap where bit set means a csum mismatch, and bit not set means
  * csum match.
  */
-unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
+unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio, u32 bio_offset,
 				    struct page *page, u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
@@ -3283,14 +3283,14 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	 * For subpage case, above PageChecked is not safe as it's not subpage
 	 * compatible.
 	 * But for now only cow fixup and compressed read utilize PageChecked
-	 * flag, while in this context we can easily use io_bio->csum to
+	 * flag, while in this context we can easily use bbio->csum to
 	 * determine if we really need to do csum verification.
 	 *
-	 * So for now, just exit if io_bio->csum is NULL, as it means it's
+	 * So for now, just exit if bbio->csum is NULL, as it means it's
 	 * compressed read, and its compressed data csum has already been
 	 * verified.
 	 */
-	if (io_bio->csum == NULL)
+	if (bbio->csum == NULL)
 		return 0;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
@@ -3317,7 +3317,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 					  EXTENT_NODATASUM);
 			continue;
 		}
-		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
+		ret = check_data_csum(inode, bbio, bio_offset, page, pg_off,
 				      page_offset(page) + pg_off);
 		if (ret < 0) {
 			const int nr_bit = (pg_off - offset_in_page(start)) >>
@@ -8077,7 +8077,7 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
-					     struct btrfs_io_bio *io_bio,
+					     struct btrfs_bio *bbio,
 					     const bool uptodate)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -8087,11 +8087,11 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	u64 start = io_bio->logical;
+	u64 start = bbio->logical;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
-	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
+	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
 		unsigned int i, nr_sectors, pgoff;
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
@@ -8099,7 +8099,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
-			    (!csum || !check_data_csum(inode, io_bio,
+			    (!csum || !check_data_csum(inode, bbio,
 						       bio_offset, bvec.bv_page,
 						       pgoff, start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
@@ -8109,12 +8109,12 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			} else {
 				int ret;
 
-				ASSERT((start - io_bio->logical) < UINT_MAX);
+				ASSERT((start - bbio->logical) < UINT_MAX);
 				ret = btrfs_repair_one_sector(inode,
-						&io_bio->bio,
-						start - io_bio->logical,
+						&bbio->bio,
+						start - bbio->logical,
 						bvec.bv_page, pgoff,
-						start, io_bio->mirror_num,
+						start, bbio->mirror_num,
 						submit_dio_repair_bio);
 				if (ret)
 					err = errno_to_blk_status(ret);
@@ -8156,7 +8156,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   bio->bi_iter.bi_size, err);
 
 	if (bio_op(bio) == REQ_OP_READ) {
-		err = btrfs_check_read_dio_bio(dip->inode, btrfs_io_bio(bio),
+		err = btrfs_check_read_dio_bio(dip->inode, btrfs_bio(bio),
 					       !err);
 	}
 
@@ -8208,7 +8208,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		csum_offset = file_offset - dip->logical_offset;
 		csum_offset >>= fs_info->sectorsize_bits;
 		csum_offset *= fs_info->csum_size;
-		btrfs_io_bio(bio)->csum = dip->csums + csum_offset;
+		btrfs_bio(bio)->csum = dip->csums + csum_offset;
 	}
 map:
 	ret = btrfs_map_bio(fs_info, bio, 0);
@@ -8323,7 +8323,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
-		btrfs_io_bio(bio)->logical = file_offset;
+		btrfs_bio(bio)->logical = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 386de5a59900..c0a7e846777a 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1105,8 +1105,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = btrfs_io_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
-	btrfs_io_bio(bio)->device = stripe->dev;
+	bio = btrfs_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
+	btrfs_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
 	bio->bi_iter.bi_sector = disk_start >> 9;
@@ -1159,7 +1159,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		page_index = stripe_offset >> PAGE_SHIFT;
 
 		if (bio_flagged(bio, BIO_CLONED))
-			bio->bi_iter = btrfs_io_bio(bio)->iter;
+			bio->bi_iter = btrfs_bio(bio)->iter;
 
 		bio_for_each_segment(bvec, bio, iter) {
 			rbio->bio_pages[page_index + i] = bvec.bv_page;
@@ -2125,7 +2125,7 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	if (generic_io) {
 		ASSERT(bioc->mirror_num == mirror_num);
-		btrfs_io_bio(bio)->mirror_num = mirror_num;
+		btrfs_bio(bio)->mirror_num = mirror_num;
 	}
 
 	rbio = alloc_rbio(fs_info, bioc, stripe_len);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d83ccec89aa7..4e89b6f0c262 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1423,7 +1423,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_page->dev->bdev)
 		goto out;
 
-	bio = btrfs_io_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS);
 	bio_set_dev(bio, first_page->dev->bdev);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
@@ -1480,7 +1480,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!spage->page);
-		bio = btrfs_io_bio_alloc(1);
+		bio = btrfs_bio_alloc(1);
 		bio_set_dev(bio, spage->dev->bdev);
 
 		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
@@ -1562,7 +1562,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_io_bio_alloc(1);
+		bio = btrfs_bio_alloc(1);
 		bio_set_dev(bio, spage_bad->dev->bdev);
 		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
@@ -1676,7 +1676,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_io_bio_alloc(sctx->pages_per_wr_bio);
+			bio = btrfs_bio_alloc(sctx->pages_per_wr_bio);
 			sbio->bio = bio;
 		}
 
@@ -2102,7 +2102,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->dev = spage->dev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_io_bio_alloc(sctx->pages_per_rd_bio);
+			bio = btrfs_bio_alloc(sctx->pages_per_rd_bio);
 			sbio->bio = bio;
 		}
 
@@ -2226,7 +2226,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto bioc_out;
 	}
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_bio_alloc(0);
 	bio->bi_iter.bi_sector = logical >> 9;
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
@@ -2842,7 +2842,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	if (ret || !bioc || !bioc->raid_map)
 		goto bioc_out;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_bio_alloc(0);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0cb1d5bad09d..3c0f20a8dfec 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6561,7 +6561,7 @@ static void btrfs_end_bio(struct bio *bio)
 		atomic_inc(&bioc->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
+			struct btrfs_device *dev = btrfs_bio(bio)->device;
 
 			ASSERT(dev->bdev);
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
@@ -6587,7 +6587,7 @@ static void btrfs_end_bio(struct bio *bio)
 			bio = bioc->orig_bio;
 		}
 
-		btrfs_io_bio(bio)->mirror_num = bioc->mirror_num;
+		btrfs_bio(bio)->mirror_num = bioc->mirror_num;
 		/* only send an error to the higher layers if it is
 		 * beyond the tolerance of the btrfs bio
 		 */
@@ -6613,7 +6613,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 
 	bio->bi_private = bioc;
-	btrfs_io_bio(bio)->device = dev;
+	btrfs_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
@@ -6649,7 +6649,7 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
 		/* Should be the original bio. */
 		WARN_ON(bio != bioc->orig_bio);
 
-		btrfs_io_bio(bio)->mirror_num = bioc->mirror_num;
+		btrfs_bio(bio)->mirror_num = bioc->mirror_num;
 		bio->bi_iter.bi_sector = logical >> 9;
 		if (atomic_read(&bioc->error) > bioc->max_errors)
 			bio->bi_status = BLK_STS_IOERR;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1e3bbdf7be94..8d2478daf4c3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -304,38 +304,37 @@ struct btrfs_fs_devices {
 				/ sizeof(struct btrfs_stripe) + 1)
 
 /*
- * we need the mirror number and stripe index to be passed around
- * the call chain while we are processing end_io (especially errors).
- * Really, what we need is a btrfs_io_context structure that has this info
- * and is properly sized with its stripe array, but we're not there
- * quite yet.  We have our own btrfs bioset, and all of the bios
- * we allocate are actually btrfs_io_bios.  We'll cram as much of
- * struct btrfs_io_context as we can into this over time.
+ * Extra info to pass along bio.
+ *
+ * Mostly for btrfs specific feature like csum and mirror_num.
  */
-struct btrfs_io_bio {
+struct btrfs_bio {
 	unsigned int mirror_num;
+
+	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
 	u64 logical;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 	struct bvec_iter iter;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
-	 * bytes for entire btrfs_io_bio but relies on bio being last.
+	 * bytes for entire btrfs_bio but relies on bio being last.
 	 */
 	struct bio bio;
 };
 
-static inline struct btrfs_io_bio *btrfs_io_bio(struct bio *bio)
+static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 {
-	return container_of(bio, struct btrfs_io_bio, bio);
+	return container_of(bio, struct btrfs_bio, bio);
 }
 
-static inline void btrfs_io_bio_free_csum(struct btrfs_io_bio *io_bio)
+static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 {
-	if (io_bio->csum != io_bio->csum_inline) {
-		kfree(io_bio->csum);
-		io_bio->csum = NULL;
+	if (bbio->csum != bbio->csum_inline) {
+		kfree(bbio->csum);
+		bbio->csum = NULL;
 	}
 }
 
-- 
2.33.0

