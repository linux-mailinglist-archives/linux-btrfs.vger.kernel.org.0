Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996B240C051
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhIOHSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 03:18:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53852 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhIOHSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 03:18:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F28BC2219D
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631690246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWJmTuPCs/ObTlQx3Dgsb11GGtMzegnzpCyYdjtdqu8=;
        b=O/UJFqDBAnfY6sAQzpzVh7wtdrlaE0valJX9hdHKLtTo2vUcu/stVX3lXsZnQT0Cbx6Ehz
        hZL98GW57YSAe2oq+1Is4kCxHtfuD7gicVihWEVGU6rJV6ywelc0hDlebe5CHJeuZMML1e
        GfOz0f+c5+VHY49thK0K67Cqb4MZZJE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35BB613C1A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHjNOQSeQWGxEAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: rename struct btrfs_io_bio to btrfs_logical_bio
Date:   Wed, 15 Sep 2021 15:17:18 +0800
Message-Id: <20210915071718.59418-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915071718.59418-1-wqu@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we have "struct btrfs_bio", which records IO context for
mirrored IO and RAID56, and "strcut btrfs_io_bio", which records extra
btrfs specific info for logical bytenr bio.

With "strcut btrfs_bio" renamed to "struct btrfs_io_context", we are
safe to rename "strcut btrfs_io_bio" to "strcut btrfs_logical_bio" which
is a more suitable name now.

Although the name, "btrfs_logical_bio", is a little long and name
"btrfs_bio" can be much shorter, "btrfs_bio" conflicts with previous
"btrfs_bio" structure and can cause a lot of problems for backports.

Thus here we choose the name "btrfs_logical_bio", which also emphasis
those bios all work at logical bytenr.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/compression.c     | 16 ++++-----
 fs/btrfs/ctree.h           |  6 ++--
 fs/btrfs/disk-io.c         |  2 +-
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/extent_io.c       | 69 +++++++++++++++++++-------------------
 fs/btrfs/extent_io.h       |  7 ++--
 fs/btrfs/file-item.c       | 12 +++----
 fs/btrfs/inode.c           | 50 ++++++++++++++-------------
 fs/btrfs/raid56.c          |  8 ++---
 fs/btrfs/scrub.c           | 14 ++++----
 fs/btrfs/volumes.c         | 10 +++---
 fs/btrfs/volumes.h         | 29 ++++++++--------
 13 files changed, 116 insertions(+), 111 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 81b11124b67a..94fefaa6438c 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1561,7 +1561,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		struct bio *bio;
 		unsigned int j;
 
-		bio = btrfs_io_bio_alloc(num_pages - i);
+		bio = btrfs_logical_bio_alloc(num_pages - i);
 		bio_set_dev(bio, block_ctx->dev->bdev);
 		bio->bi_iter.bi_sector = dev_bytenr >> 9;
 		bio->bi_opf = REQ_OP_READ;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2475dc0b1c22..331ef88b87d1 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -179,9 +179,9 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 			if (memcmp(&csum, cb_sum, csum_size) != 0) {
 				btrfs_print_data_csum_error(inode, disk_start,
 						csum, cb_sum, cb->mirror_num);
-				if (btrfs_io_bio(bio)->device)
+				if (btrfs_logical_bio(bio)->device)
 					btrfs_dev_stat_inc_and_print(
-						btrfs_io_bio(bio)->device,
+						btrfs_logical_bio(bio)->device,
 						BTRFS_DEV_STAT_CORRUPTION_ERRS);
 				return -EIO;
 			}
@@ -208,7 +208,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	struct inode *inode;
 	struct page *page;
 	unsigned int index;
-	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
+	unsigned int mirror = btrfs_logical_bio(bio)->mirror_num;
 	int ret = 0;
 
 	if (bio->bi_status)
@@ -224,7 +224,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	 * Record the correct mirror_num in cb->orig_bio so that
 	 * read-repair can work properly.
 	 */
-	btrfs_io_bio(cb->orig_bio)->mirror_num = mirror;
+	btrfs_logical_bio(cb->orig_bio)->mirror_num = mirror;
 	cb->mirror_num = mirror;
 
 	/*
@@ -418,7 +418,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_logical_bio_alloc(0);
 	bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
 	bio->bi_opf = bio_op | write_flags;
 	bio->bi_private = cb;
@@ -491,7 +491,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				bio_endio(bio);
 			}
 
-			bio = btrfs_io_bio_alloc(0);
+			bio = btrfs_logical_bio_alloc(0);
 			bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
 			bio->bi_opf = bio_op | write_flags;
 			bio->bi_private = cb;
@@ -750,7 +750,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_io_bio_alloc(0);
+	comp_bio = btrfs_logical_bio_alloc(0);
 	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
@@ -809,7 +809,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				bio_endio(comp_bio);
 			}
 
-			comp_bio = btrfs_io_bio_alloc(0);
+			comp_bio = btrfs_logical_bio_alloc(0);
 			comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 			comp_bio->bi_opf = REQ_OP_READ;
 			comp_bio->bi_private = cb;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 38870ae46cbb..41bc28f6c6c4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -48,6 +48,7 @@ extern struct kmem_cache *btrfs_free_space_cachep;
 extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
 struct btrfs_ordered_sum;
 struct btrfs_ref;
+struct btrfs_logical_bio;
 
 #define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
 
@@ -3133,8 +3134,9 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-				    struct page *page, u64 start, u64 end);
+unsigned int btrfs_verify_data_csum(struct btrfs_logical_bio *lbio,
+				    u32 bio_offset, struct page *page,
+				    u64 start, u64 end);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d80e5b22d32..4909f6e5c6f8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -683,7 +683,7 @@ static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
 	return ret;
 }
 
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
+int btrfs_validate_metadata_buffer(struct btrfs_logical_bio *lbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0e7e9526b6a8..aad13d02b9ad 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -81,7 +81,7 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
+int btrfs_validate_metadata_buffer(struct btrfs_logical_bio *lbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3fcf7e8dc48..9ae6fddc4cc8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -241,7 +241,7 @@ int __init extent_io_init(void)
 		return -ENOMEM;
 
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_io_bio, bio),
+			offsetof(struct btrfs_logical_bio, bio),
 			BIOSET_NEED_BVECS))
 		goto free_buffer_cache;
 
@@ -2299,7 +2299,7 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_repair_one_zone(fs_info, logical);
 
-	bio = btrfs_io_bio_alloc(1);
+	bio = btrfs_logical_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
@@ -2618,10 +2618,10 @@ int btrfs_repair_one_sector(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
+	struct btrfs_logical_bio *failed_lbio = btrfs_logical_bio(failed_bio);
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
-	struct btrfs_io_bio *repair_io_bio;
+	struct btrfs_logical_bio *repair_lbio;
 	blk_status_t status;
 
 	btrfs_debug(fs_info,
@@ -2639,24 +2639,24 @@ int btrfs_repair_one_sector(struct inode *inode,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_io_bio_alloc(1);
-	repair_io_bio = btrfs_io_bio(repair_bio);
+	repair_bio = btrfs_logical_bio_alloc(1);
+	repair_lbio = btrfs_logical_bio(repair_bio);
 	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
 
-	if (failed_io_bio->csum) {
+	if (failed_lbio->csum) {
 		const u32 csum_size = fs_info->csum_size;
 
-		repair_io_bio->csum = repair_io_bio->csum_inline;
-		memcpy(repair_io_bio->csum,
-		       failed_io_bio->csum + csum_size * icsum, csum_size);
+		repair_lbio->csum = repair_lbio->csum_inline;
+		memcpy(repair_lbio->csum,
+		       failed_lbio->csum + csum_size * icsum, csum_size);
 	}
 
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_io_bio->logical = failrec->start;
-	repair_io_bio->iter = repair_bio->bi_iter;
+	repair_lbio->logical = failrec->start;
+	repair_lbio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
 		    "repair read error: submitting new read to mirror %d",
@@ -2976,7 +2976,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
 static void end_bio_extent_readpage(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	struct btrfs_logical_bio *lbio = btrfs_logical_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
@@ -3003,7 +3003,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
-			io_bio->mirror_num);
+			lbio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
 		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
@@ -3028,14 +3028,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
-		mirror = io_bio->mirror_num;
+		mirror = lbio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode)) {
-				error_bitmap = btrfs_verify_data_csum(io_bio,
+				error_bitmap = btrfs_verify_data_csum(lbio,
 						bio_offset, page, start, end);
 				ret = error_bitmap;
 			} else {
-				ret = btrfs_validate_metadata_buffer(io_bio,
+				ret = btrfs_validate_metadata_buffer(lbio,
 					page, start, end, mirror);
 			}
 			if (ret)
@@ -3106,7 +3106,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	btrfs_io_bio_free_csum(io_bio);
+	btrfs_logical_bio_free_csum(lbio);
 	bio_put(bio);
 }
 
@@ -3115,9 +3115,9 @@ static void end_bio_extent_readpage(struct bio *bio)
  * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
  * 'bio' because use of __GFP_ZERO is not supported.
  */
-static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
+static inline void btrfs_logical_bio_init(struct btrfs_logical_bio *lbio)
 {
-	memset(btrfs_bio, 0, offsetof(struct btrfs_io_bio, bio));
+	memset(lbio, 0, offsetof(struct btrfs_logical_bio, bio));
 }
 
 /*
@@ -3129,7 +3129,7 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
  * This helper uses bioset to allocate the bio, thus it's backed by mempool,
  * and should not fail from process contexts.
  */
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
+struct bio *btrfs_logical_bio_alloc(unsigned int nr_iovecs)
 {
 	struct bio *bio;
 
@@ -3137,27 +3137,28 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
 	if (nr_iovecs == 0)
 		nr_iovecs = BIO_MAX_VECS;
 	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
-	btrfs_io_bio_init(btrfs_io_bio(bio));
+	btrfs_logical_bio_init(btrfs_logical_bio(bio));
 	return bio;
 }
 
-struct bio *btrfs_bio_clone(struct bio *bio)
+struct bio *btrfs_logical_bio_clone(struct bio *bio)
 {
-	struct btrfs_io_bio *btrfs_bio;
+	struct btrfs_logical_bio *lbio;
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
 	new = bio_clone_fast(bio, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio = btrfs_io_bio(new);
-	btrfs_io_bio_init(btrfs_bio);
-	btrfs_bio->iter = bio->bi_iter;
+	lbio = btrfs_logical_bio(new);
+	btrfs_logical_bio_init(lbio);
+	lbio->iter = bio->bi_iter;
 	return new;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
+struct bio *btrfs_logical_bio_clone_partial(struct bio *orig, u64 offset,
+					    u64 size)
 {
 	struct bio *bio;
-	struct btrfs_io_bio *btrfs_bio;
+	struct btrfs_logical_bio *lbio;
 
 	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
 
@@ -3165,11 +3166,11 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	bio = bio_clone_fast(orig, GFP_NOFS, &btrfs_bioset);
 	ASSERT(bio);
 
-	btrfs_bio = btrfs_io_bio(bio);
-	btrfs_io_bio_init(btrfs_bio);
+	lbio = btrfs_logical_bio(bio);
+	btrfs_logical_bio_init(lbio);
 
 	bio_trim(bio, offset >> 9, size >> 9);
-	btrfs_bio->iter = bio->bi_iter;
+	lbio->iter = bio->bi_iter;
 	return bio;
 }
 
@@ -3303,7 +3304,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_logical_bio_alloc(0);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3338,7 +3339,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			goto error;
 		}
 
-		btrfs_io_bio(bio)->device = device;
+		btrfs_logical_bio(bio)->device = device;
 	}
 	return 0;
 error:
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 81fa68eaa699..7eac8536b162 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -278,9 +278,10 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone(struct bio *bio);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
+struct bio *btrfs_logical_bio_alloc(unsigned int nr_iovecs);
+struct bio *btrfs_logical_bio_clone(struct bio *bio);
+struct bio *btrfs_logical_bio_clone_partial(struct bio *orig, u64 offset,
+					    u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2673c6ba7a4e..6e788eb3c689 100644
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
+		struct btrfs_logical_bio *logical_bio = btrfs_logical_bio(bio);
 
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
-			btrfs_bio->csum = kmalloc_array(nblocks, csum_size,
+			logical_bio->csum = kmalloc_array(nblocks, csum_size,
 							GFP_NOFS);
-			if (!btrfs_bio->csum) {
+			if (!logical_bio->csum) {
 				btrfs_free_path(path);
 				return BLK_STS_RESOURCE;
 			}
 		} else {
-			btrfs_bio->csum = btrfs_bio->csum_inline;
+			logical_bio->csum = logical_bio->csum_inline;
 		}
-		csum = btrfs_bio->csum;
+		csum = logical_bio->csum;
 	} else {
 		csum = dst;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a3ce50289888..52d8d5c9bab1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3212,7 +3212,7 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  *
  * The length of such check is always one sector size.
  */
-static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
+static int check_data_csum(struct inode *inode, struct btrfs_logical_bio *lbio,
 			   u32 bio_offset, struct page *page, u32 pgoff,
 			   u64 start)
 {
@@ -3228,7 +3228,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
-	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
+	csum_expected = ((u8 *)lbio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -3242,9 +3242,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	return 0;
 zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
-				    io_bio->mirror_num);
-	if (io_bio->device)
-		btrfs_dev_stat_inc_and_print(io_bio->device,
+				    lbio->mirror_num);
+	if (lbio->device)
+		btrfs_dev_stat_inc_and_print(lbio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
@@ -3264,8 +3264,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * Return a bitmap where bit set means a csum mismatch, and bit not set means
  * csum match.
  */
-unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-				    struct page *page, u64 start, u64 end)
+unsigned int btrfs_verify_data_csum(struct btrfs_logical_bio *lbio,
+				    u32 bio_offset, struct page *page,
+				    u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -3283,14 +3284,14 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	 * For subpage case, above PageChecked is not safe as it's not subpage
 	 * compatible.
 	 * But for now only cow fixup and compressed read utilize PageChecked
-	 * flag, while in this context we can easily use io_bio->csum to
+	 * flag, while in this context we can easily use lbio->csum to
 	 * determine if we really need to do csum verification.
 	 *
-	 * So for now, just exit if io_bio->csum is NULL, as it means it's
+	 * So for now, just exit if lbio->csum is NULL, as it means it's
 	 * compressed read, and its compressed data csum has already been
 	 * verified.
 	 */
-	if (io_bio->csum == NULL)
+	if (lbio->csum == NULL)
 		return 0;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
@@ -3317,7 +3318,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 					  EXTENT_NODATASUM);
 			continue;
 		}
-		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
+		ret = check_data_csum(inode, lbio, bio_offset, page, pg_off,
 				      page_offset(page) + pg_off);
 		if (ret < 0) {
 			const int nr_bit = (pg_off - offset_in_page(start)) >>
@@ -8077,7 +8078,7 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
-					     struct btrfs_io_bio *io_bio,
+					     struct btrfs_logical_bio *lbio,
 					     const bool uptodate)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -8087,11 +8088,11 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	u64 start = io_bio->logical;
+	u64 start = lbio->logical;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
-	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
+	__bio_for_each_segment(bvec, &lbio->bio, iter, lbio->iter) {
 		unsigned int i, nr_sectors, pgoff;
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
@@ -8099,7 +8100,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
-			    (!csum || !check_data_csum(inode, io_bio,
+			    (!csum || !check_data_csum(inode, lbio,
 						       bio_offset, bvec.bv_page,
 						       pgoff, start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
@@ -8109,12 +8110,12 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			} else {
 				int ret;
 
-				ASSERT((start - io_bio->logical) < UINT_MAX);
+				ASSERT((start - lbio->logical) < UINT_MAX);
 				ret = btrfs_repair_one_sector(inode,
-						&io_bio->bio,
-						start - io_bio->logical,
+						&lbio->bio,
+						start - lbio->logical,
 						bvec.bv_page, pgoff,
-						start, io_bio->mirror_num,
+						start, lbio->mirror_num,
 						submit_dio_repair_bio);
 				if (ret)
 					err = errno_to_blk_status(ret);
@@ -8156,8 +8157,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   bio->bi_iter.bi_size, err);
 
 	if (bio_op(bio) == REQ_OP_READ) {
-		err = btrfs_check_read_dio_bio(dip->inode, btrfs_io_bio(bio),
-					       !err);
+		err = btrfs_check_read_dio_bio(dip->inode,
+					       btrfs_logical_bio(bio), !err);
 	}
 
 	if (err)
@@ -8208,7 +8209,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		csum_offset = file_offset - dip->logical_offset;
 		csum_offset >>= fs_info->sectorsize_bits;
 		csum_offset *= fs_info->csum_size;
-		btrfs_io_bio(bio)->csum = dip->csums + csum_offset;
+		btrfs_logical_bio(bio)->csum = dip->csums + csum_offset;
 	}
 map:
 	ret = btrfs_map_bio(fs_info, bio, 0);
@@ -8320,10 +8321,11 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		 * This will never fail as it's passing GPF_NOFS and
 		 * the allocation is backed by btrfs_bioset.
 		 */
-		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
+		bio = btrfs_logical_bio_clone_partial(dio_bio, clone_offset,
+						      clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
-		btrfs_io_bio(bio)->logical = file_offset;
+		btrfs_logical_bio(bio)->logical = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 96c149416f99..705e2f243459 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1104,8 +1104,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = btrfs_io_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
-	btrfs_io_bio(bio)->device = stripe->dev;
+	bio = btrfs_logical_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
+	btrfs_logical_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
 	bio->bi_iter.bi_sector = disk_start >> 9;
@@ -1158,7 +1158,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		page_index = stripe_offset >> PAGE_SHIFT;
 
 		if (bio_flagged(bio, BIO_CLONED))
-			bio->bi_iter = btrfs_io_bio(bio)->iter;
+			bio->bi_iter = btrfs_logical_bio(bio)->iter;
 
 		bio_for_each_segment(bvec, bio, iter) {
 			rbio->bio_pages[page_index + i] = bvec.bv_page;
@@ -2124,7 +2124,7 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	if (generic_io) {
 		ASSERT(bioc->mirror_num == mirror_num);
-		btrfs_io_bio(bio)->mirror_num = mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = mirror_num;
 	}
 
 	rbio = alloc_rbio(fs_info, bioc, stripe_len);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bd38e32ef5dc..c1dfe7f3ace6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1423,7 +1423,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_page->dev->bdev)
 		goto out;
 
-	bio = btrfs_io_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_logical_bio_alloc(0);
 	bio_set_dev(bio, first_page->dev->bdev);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
@@ -1480,7 +1480,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!spage->page);
-		bio = btrfs_io_bio_alloc(1);
+		bio = btrfs_logical_bio_alloc(1);
 		bio_set_dev(bio, spage->dev->bdev);
 
 		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
@@ -1562,7 +1562,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_io_bio_alloc(1);
+		bio = btrfs_logical_bio_alloc(1);
 		bio_set_dev(bio, spage_bad->dev->bdev);
 		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
@@ -1676,7 +1676,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_io_bio_alloc(sctx->pages_per_wr_bio);
+			bio = btrfs_logical_bio_alloc(sctx->pages_per_wr_bio);
 			sbio->bio = bio;
 		}
 
@@ -2102,7 +2102,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->dev = spage->dev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_io_bio_alloc(sctx->pages_per_rd_bio);
+			bio = btrfs_logical_bio_alloc(sctx->pages_per_rd_bio);
 			sbio->bio = bio;
 		}
 
@@ -2226,7 +2226,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto bioc_out;
 	}
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_logical_bio_alloc(0);
 	bio->bi_iter.bi_sector = logical >> 9;
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
@@ -2842,7 +2842,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	if (ret || !bioc || !bioc->raid_map)
 		goto bioc_out;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_logical_bio_alloc(0);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 592d19f95065..9c609ed2606f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6561,7 +6561,7 @@ static void btrfs_end_bio(struct bio *bio)
 		atomic_inc(&bioc->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
+			struct btrfs_device *dev = btrfs_logical_bio(bio)->device;
 
 			ASSERT(dev->bdev);
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
@@ -6587,7 +6587,7 @@ static void btrfs_end_bio(struct bio *bio)
 			bio = bioc->orig_bio;
 		}
 
-		btrfs_io_bio(bio)->mirror_num = bioc->mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = bioc->mirror_num;
 		/* only send an error to the higher layers if it is
 		 * beyond the tolerance of the btrfs bio
 		 */
@@ -6613,7 +6613,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 
 	bio->bi_private = bioc;
-	btrfs_io_bio(bio)->device = dev;
+	btrfs_logical_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
@@ -6649,7 +6649,7 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
 		/* Should be the original bio. */
 		WARN_ON(bio != bioc->orig_bio);
 
-		btrfs_io_bio(bio)->mirror_num = bioc->mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = bioc->mirror_num;
 		bio->bi_iter.bi_sector = logical >> 9;
 		if (atomic_read(&bioc->error) > bioc->max_errors)
 			bio->bi_status = BLK_STS_IOERR;
@@ -6724,7 +6724,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		}
 
 		if (dev_nr < total_devs - 1)
-			bio = btrfs_bio_clone(first_bio);
+			bio = btrfs_logical_bio_clone(first_bio);
 		else
 			bio = first_bio;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b69755fc0e0d..6b0edca6ed2a 100644
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
+struct btrfs_logical_bio {
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
+static inline struct btrfs_logical_bio *btrfs_logical_bio(struct bio *bio)
 {
-	return container_of(bio, struct btrfs_io_bio, bio);
+	return container_of(bio, struct btrfs_logical_bio, bio);
 }
 
-static inline void btrfs_io_bio_free_csum(struct btrfs_io_bio *io_bio)
+static inline void btrfs_logical_bio_free_csum(struct btrfs_logical_bio *lbio)
 {
-	if (io_bio->csum != io_bio->csum_inline) {
-		kfree(io_bio->csum);
-		io_bio->csum = NULL;
+	if (lbio->csum != lbio->csum_inline) {
+		kfree(lbio->csum);
+		lbio->csum = NULL;
 	}
 }
 
-- 
2.33.0

