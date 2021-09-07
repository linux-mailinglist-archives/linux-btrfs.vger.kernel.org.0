Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F64024A3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbhIGHoP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 03:44:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55938 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbhIGHn7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 03:43:59 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 408C12203C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631000572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqTaMx6pTK2inYxRoxJCCEE4tidm245wCZT368NE1kQ=;
        b=E63BU7KOLMTeFmGoKVxvFMHgpsOzaV8ATOWZUNYURWSBK1kA6yfpJ3T3GKimcDppPTGsi3
        Zg1WpGBJQppqThxkJ5GAJZLPiO/6ejXcSzQ+QJHaeD48gqMjpe0lwVz0keSWcok3MF3pUc
        hzhLPtHqemkYrLFLRFRIBV4oaKHgYhE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A5D2C132FD
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id sKqqGPoXN2GTFQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 07:42:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: rename struct btrfs_io_bio to struct btrfs_logical_bio
Date:   Tue,  7 Sep 2021 15:42:41 +0800
Message-Id: <20210907074242.103438-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907074242.103438-1-wqu@suse.com>
References: <20210907074242.103438-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs there are at least 4 types of different bios currently:

- btrfs_io_bio
  It's used to specify IO for logical bytenr

- btrfs_bio
  It's real physical bio

- compressed_bio
  Only used for compressed read write.

- btrfs_raid_bio
  Only used by RAID56

The naming of btrfs_bio and btrfs_io_bio is just anti-human.

Rename btrfs_io_bio to btrfs_logical_bio, and all involved helpers to
make clear at which layer the bio works.

Since we're here, also add extra comments on critical members like
@mirror_num.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/compression.c     | 16 ++++----
 fs/btrfs/ctree.h           |  5 ++-
 fs/btrfs/disk-io.c         |  2 +-
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/extent_io.c       | 78 +++++++++++++++++++-------------------
 fs/btrfs/extent_io.h       | 11 +++---
 fs/btrfs/file-item.c       | 12 +++---
 fs/btrfs/inode.c           | 57 +++++++++++++++-------------
 fs/btrfs/raid56.c          |  8 ++--
 fs/btrfs/scrub.c           | 14 +++----
 fs/btrfs/volumes.c         | 11 +++---
 fs/btrfs/volumes.h         | 54 ++++++++++++++++++--------
 13 files changed, 153 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 06a9b1875bec..0edb16da44d2 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1561,7 +1561,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		struct bio *bio;
 		unsigned int j;
 
-		bio = btrfs_bio_alloc_iovecs(num_pages - i);
+		bio = btrfs_logical_bio_alloc_iovecs(num_pages - i);
 		bio_set_dev(bio, block_ctx->dev->bdev);
 		bio->bi_iter.bi_sector = dev_bytenr >> 9;
 		bio->bi_opf = REQ_OP_READ;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7869ad12bc6e..02b17a3ad619 100644
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
 
-	bio = btrfs_bio_alloc(first_byte);
+	bio = btrfs_logical_bio_alloc(first_byte);
 	bio->bi_opf = bio_op | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
@@ -490,7 +490,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				bio_endio(bio);
 			}
 
-			bio = btrfs_bio_alloc(first_byte);
+			bio = btrfs_logical_bio_alloc(first_byte);
 			bio->bi_opf = bio_op | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
@@ -748,7 +748,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_bio_alloc(cur_disk_byte);
+	comp_bio = btrfs_logical_bio_alloc(cur_disk_byte);
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
 	comp_bio->bi_end_io = end_compressed_bio_read;
@@ -806,7 +806,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				bio_endio(comp_bio);
 			}
 
-			comp_bio = btrfs_bio_alloc(cur_disk_byte);
+			comp_bio = btrfs_logical_bio_alloc(cur_disk_byte);
 			comp_bio->bi_opf = REQ_OP_READ;
 			comp_bio->bi_private = cb;
 			comp_bio->bi_end_io = end_compressed_bio_read;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 38870ae46cbb..88203068543f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3133,8 +3133,9 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-				    struct page *page, u64 start, u64 end);
+unsigned int btrfs_verify_data_csum(struct btrfs_logical_bio *logical_bio,
+				    u32 bio_offset, struct page *page,
+				    u64 start, u64 end);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41ea50f48cfe..68bb899af710 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -683,7 +683,7 @@ static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
 	return ret;
 }
 
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
+int btrfs_validate_metadata_buffer(struct btrfs_logical_bio *logical_bio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0e7e9526b6a8..4430a8ec5bfe 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -81,7 +81,7 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
+int btrfs_validate_metadata_buffer(struct btrfs_logical_bio *logical_bio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 37ff4a4df94b..7d6eb45c1fdf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -241,7 +241,7 @@ int __init extent_io_init(void)
 		return -ENOMEM;
 
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_io_bio, bio),
+			offsetof(struct btrfs_logical_bio, bio),
 			BIOSET_NEED_BVECS))
 		goto free_buffer_cache;
 
@@ -2299,7 +2299,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_repair_one_zone(fs_info, logical);
 
-	bio = btrfs_bio_alloc_iovecs(1);
+	bio = btrfs_logical_bio_alloc_iovecs(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
@@ -2618,10 +2618,11 @@ int btrfs_repair_one_sector(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
+	struct btrfs_logical_bio *failed_logical_bio =
+						btrfs_logical_bio(failed_bio);
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
-	struct btrfs_io_bio *repair_io_bio;
+	struct btrfs_logical_bio *repair_logical_bio;
 	blk_status_t status;
 
 	btrfs_debug(fs_info,
@@ -2639,24 +2640,24 @@ int btrfs_repair_one_sector(struct inode *inode,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_bio_alloc_iovecs(1);
-	repair_io_bio = btrfs_io_bio(repair_bio);
+	repair_bio = btrfs_logical_bio_alloc_iovecs(1);
+	repair_logical_bio = btrfs_logical_bio(repair_bio);
 	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
 
-	if (failed_io_bio->csum) {
+	if (failed_logical_bio->csum) {
 		const u32 csum_size = fs_info->csum_size;
 
-		repair_io_bio->csum = repair_io_bio->csum_inline;
-		memcpy(repair_io_bio->csum,
-		       failed_io_bio->csum + csum_size * icsum, csum_size);
+		repair_logical_bio->csum = repair_logical_bio->csum_inline;
+		memcpy(repair_logical_bio->csum,
+		       failed_logical_bio->csum + csum_size * icsum, csum_size);
 	}
 
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_io_bio->logical = failrec->start;
-	repair_io_bio->iter = repair_bio->bi_iter;
+	repair_logical_bio->logical = failrec->start;
+	repair_logical_bio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
 		    "repair read error: submitting new read to mirror %d",
@@ -2976,7 +2977,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
 static void end_bio_extent_readpage(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	struct btrfs_logical_bio *logical_bio = btrfs_logical_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
@@ -3003,7 +3004,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
-			io_bio->mirror_num);
+			logical_bio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
 		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
@@ -3028,14 +3029,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
-		mirror = io_bio->mirror_num;
+		mirror = logical_bio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode)) {
-				error_bitmap = btrfs_verify_data_csum(io_bio,
+				error_bitmap = btrfs_verify_data_csum(logical_bio,
 						bio_offset, page, start, end);
 				ret = error_bitmap;
 			} else {
-				ret = btrfs_validate_metadata_buffer(io_bio,
+				ret = btrfs_validate_metadata_buffer(logical_bio,
 					page, start, end, mirror);
 			}
 			if (ret)
@@ -3106,7 +3107,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	btrfs_io_bio_free_csum(io_bio);
+	btrfs_logical_bio_free_csum(logical_bio);
 	bio_put(bio);
 }
 
@@ -3115,53 +3116,54 @@ static void end_bio_extent_readpage(struct bio *bio)
  * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
  * 'bio' because use of __GFP_ZERO is not supported.
  */
-static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
+static inline void btrfs_logical_bio_init(struct btrfs_logical_bio *btrfs_bio)
 {
-	memset(btrfs_bio, 0, offsetof(struct btrfs_io_bio, bio));
+	memset(btrfs_bio, 0, offsetof(struct btrfs_logical_bio, bio));
 }
 
 /*
  * The following helpers allocate a bio. As it's backed by a bioset, it'll
- * never fail.  We're returning a bio right now but you can call btrfs_io_bio
- * for the appropriate container_of magic
+ * never fail.  We're returning a bio right now but you can call
+ * btrfs_logical_bio for the appropriate container_of magic
  */
-struct bio *btrfs_bio_alloc(u64 first_byte)
+struct bio *btrfs_logical_bio_alloc(u64 first_byte)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
 	bio->bi_iter.bi_sector = first_byte >> 9;
-	btrfs_io_bio_init(btrfs_io_bio(bio));
+	btrfs_logical_bio_init(btrfs_logical_bio(bio));
 	return bio;
 }
 
-struct bio *btrfs_bio_clone(struct bio *bio)
+struct bio *btrfs_logical_bio_clone(struct bio *bio)
 {
-	struct btrfs_io_bio *btrfs_bio;
+	struct btrfs_logical_bio *btrfs_bio;
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
 	new = bio_clone_fast(bio, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio = btrfs_io_bio(new);
-	btrfs_io_bio_init(btrfs_bio);
+	btrfs_bio = btrfs_logical_bio(new);
+	btrfs_logical_bio_init(btrfs_bio);
 	btrfs_bio->iter = bio->bi_iter;
 	return new;
 }
 
-struct bio *btrfs_bio_alloc_iovecs(unsigned int nr_iovecs)
+struct bio *btrfs_logical_bio_alloc_iovecs(unsigned int nr_iovecs)
 {
 	struct bio *bio;
 
 	/* Bio allocation backed by a bioset does not fail */
 	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
-	btrfs_io_bio_init(btrfs_io_bio(bio));
+	btrfs_logical_bio_init(btrfs_logical_bio(bio));
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
+struct bio *btrfs_logical_bio_clone_partial(struct bio *orig, u64 offset,
+					    u64 size)
 {
 	struct bio *bio;
-	struct btrfs_io_bio *btrfs_bio;
+	struct btrfs_logical_bio *logical_bio;
 
 	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
 
@@ -3169,11 +3171,11 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	bio = bio_clone_fast(orig, GFP_NOFS, &btrfs_bioset);
 	ASSERT(bio);
 
-	btrfs_bio = btrfs_io_bio(bio);
-	btrfs_io_bio_init(btrfs_bio);
+	logical_bio = btrfs_logical_bio(bio);
+	btrfs_logical_bio_init(logical_bio);
 
 	bio_trim(bio, offset >> 9, size >> 9);
-	btrfs_bio->iter = bio->bi_iter;
+	logical_bio->iter = bio->bi_iter;
 	return bio;
 }
 
@@ -3312,9 +3314,9 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	 * passed in, no matter if we have added any range into previous bio.
 	 */
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
-		bio = btrfs_bio_alloc(disk_bytenr);
+		bio = btrfs_logical_bio_alloc(disk_bytenr);
 	else
-		bio = btrfs_bio_alloc(disk_bytenr + offset);
+		bio = btrfs_logical_bio_alloc(disk_bytenr + offset);
 	bio_ctrl->bio = bio;
 	bio_ctrl->bio_flags = bio_flags;
 	bio->bi_end_io = end_io_func;
@@ -3341,7 +3343,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			goto error;
 		}
 
-		btrfs_io_bio(bio)->device = device;
+		btrfs_logical_bio(bio)->device = device;
 	}
 	return 0;
 error:
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index dbc197ba57ce..d4edd3b2e7b9 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -66,7 +66,7 @@ enum {
 
 struct btrfs_root;
 struct btrfs_inode;
-struct btrfs_io_bio;
+struct btrfs_logical_bio;
 struct btrfs_fs_info;
 struct io_failure_record;
 struct extent_io_tree;
@@ -278,10 +278,11 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
-struct bio *btrfs_bio_alloc(u64 first_byte);
-struct bio *btrfs_bio_alloc_iovecs(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone(struct bio *bio);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
+struct bio *btrfs_logical_bio_alloc(u64 first_byte);
+struct bio *btrfs_logical_bio_alloc_iovecs(unsigned int nr_iovecs);
+struct bio *btrfs_logical_bio_clone(struct bio *bio);
+struct bio *btrfs_logical_bio_clone_partial(struct bio *orig, u64 offset,
+					    u64 size);
 
 int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2673c6ba7a4e..18bd5922160b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -358,7 +358,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
  * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
  *       checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
  *       NULL, the checksum buffer is allocated and returned in
- *       btrfs_io_bio(bio)->csum instead.
+ *       btrfs_logical_bio(bio)->csum instead.
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
index 0517f31a3bed..36463a257b88 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3212,7 +3212,8 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  *
  * The length of such check is always one sector size.
  */
-static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
+static int check_data_csum(struct inode *inode,
+			   struct btrfs_logical_bio *logical_bio,
 			   u32 bio_offset, struct page *page, u32 pgoff,
 			   u64 start)
 {
@@ -3228,7 +3229,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
-	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
+	csum_expected = ((u8 *)logical_bio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -3242,9 +3243,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	return 0;
 zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
-				    io_bio->mirror_num);
-	if (io_bio->device)
-		btrfs_dev_stat_inc_and_print(io_bio->device,
+				    logical_bio->mirror_num);
+	if (logical_bio->device)
+		btrfs_dev_stat_inc_and_print(logical_bio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
@@ -3264,8 +3265,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * Return a bitmap where bit set means a csum mismatch, and bit not set means
  * csum match.
  */
-unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-				    struct page *page, u64 start, u64 end)
+unsigned int btrfs_verify_data_csum(struct btrfs_logical_bio *logical_bio,
+				    u32 bio_offset, struct page *page,
+				    u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -3283,14 +3285,14 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	 * For subpage case, above PageChecked is not safe as it's not subpage
 	 * compatible.
 	 * But for now only cow fixup and compressed read utilize PageChecked
-	 * flag, while in this context we can easily use io_bio->csum to
+	 * flag, while in this context we can easily use logical_bio->csum to
 	 * determine if we really need to do csum verification.
 	 *
-	 * So for now, just exit if io_bio->csum is NULL, as it means it's
+	 * So for now, just exit if logical_bio->csum is NULL, as it means it's
 	 * compressed read, and its compressed data csum has already been
 	 * verified.
 	 */
-	if (io_bio->csum == NULL)
+	if (logical_bio->csum == NULL)
 		return 0;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
@@ -3317,8 +3319,8 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 					  EXTENT_NODATASUM);
 			continue;
 		}
-		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
-				      page_offset(page) + pg_off);
+		ret = check_data_csum(inode, logical_bio, bio_offset, page,
+				      pg_off, page_offset(page) + pg_off);
 		if (ret < 0) {
 			const int nr_bit = (pg_off - offset_in_page(start)) >>
 				     root->fs_info->sectorsize_bits;
@@ -8077,8 +8079,8 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
-					     struct btrfs_io_bio *io_bio,
-					     const bool uptodate)
+					struct btrfs_logical_bio *logical_bio,
+					const bool uptodate)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
@@ -8087,11 +8089,12 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	u64 start = io_bio->logical;
+	u64 start = logical_bio->logical;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
-	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
+	__bio_for_each_segment(bvec, &logical_bio->bio, iter,
+			       logical_bio->iter) {
 		unsigned int i, nr_sectors, pgoff;
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
@@ -8099,7 +8102,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
-			    (!csum || !check_data_csum(inode, io_bio,
+			    (!csum || !check_data_csum(inode, logical_bio,
 						       bio_offset, bvec.bv_page,
 						       pgoff, start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
@@ -8109,12 +8112,13 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			} else {
 				int ret;
 
-				ASSERT((start - io_bio->logical) < UINT_MAX);
+				ASSERT((start - logical_bio->logical) <
+					UINT_MAX);
 				ret = btrfs_repair_one_sector(inode,
-						&io_bio->bio,
-						start - io_bio->logical,
+						&logical_bio->bio,
+						start - logical_bio->logical,
 						bvec.bv_page, pgoff,
-						start, io_bio->mirror_num,
+						start, logical_bio->mirror_num,
 						submit_dio_repair_bio);
 				if (ret)
 					err = errno_to_blk_status(ret);
@@ -8156,8 +8160,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   bio->bi_iter.bi_size, err);
 
 	if (bio_op(bio) == REQ_OP_READ) {
-		err = btrfs_check_read_dio_bio(dip->inode, btrfs_io_bio(bio),
-					       !err);
+		err = btrfs_check_read_dio_bio(dip->inode,
+					       btrfs_logical_bio(bio), !err);
 	}
 
 	if (err)
@@ -8208,7 +8212,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		csum_offset = file_offset - dip->logical_offset;
 		csum_offset >>= fs_info->sectorsize_bits;
 		csum_offset *= fs_info->csum_size;
-		btrfs_io_bio(bio)->csum = dip->csums + csum_offset;
+		btrfs_logical_bio(bio)->csum = dip->csums + csum_offset;
 	}
 map:
 	ret = btrfs_map_bio(fs_info, bio, 0);
@@ -8320,10 +8324,11 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
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
index 581472d314bb..4fbb64785930 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1105,8 +1105,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = btrfs_bio_alloc_iovecs(bio_max_len >> PAGE_SHIFT ?: 1);
-	btrfs_io_bio(bio)->device = stripe->dev;
+	bio = btrfs_logical_bio_alloc_iovecs(bio_max_len >> PAGE_SHIFT ?: 1);
+	btrfs_logical_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
 	bio->bi_iter.bi_sector = disk_start >> 9;
@@ -1159,7 +1159,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		page_index = stripe_offset >> PAGE_SHIFT;
 
 		if (bio_flagged(bio, BIO_CLONED))
-			bio->bi_iter = btrfs_io_bio(bio)->iter;
+			bio->bi_iter = btrfs_logical_bio(bio)->iter;
 
 		bio_for_each_segment(bvec, bio, iter) {
 			rbio->bio_pages[page_index + i] = bvec.bv_page;
@@ -2125,7 +2125,7 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	if (generic_io) {
 		ASSERT(bbio->mirror_num == mirror_num);
-		btrfs_io_bio(bio)->mirror_num = mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = mirror_num;
 	}
 
 	rbio = alloc_rbio(fs_info, bbio, stripe_len);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0159fe00f348..ae44b36a3a63 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1423,7 +1423,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_page->dev->bdev)
 		goto out;
 
-	bio = btrfs_bio_alloc_iovecs(BIO_MAX_VECS);
+	bio = btrfs_logical_bio_alloc_iovecs(BIO_MAX_VECS);
 	bio_set_dev(bio, first_page->dev->bdev);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
@@ -1480,7 +1480,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!spage->page);
-		bio = btrfs_bio_alloc_iovecs(1);
+		bio = btrfs_logical_bio_alloc_iovecs(1);
 		bio_set_dev(bio, spage->dev->bdev);
 
 		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
@@ -1562,7 +1562,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_bio_alloc_iovecs(1);
+		bio = btrfs_logical_bio_alloc_iovecs(1);
 		bio_set_dev(bio, spage_bad->dev->bdev);
 		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
@@ -1676,7 +1676,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_bio_alloc_iovecs(sctx->pages_per_wr_bio);
+			bio = btrfs_logical_bio_alloc_iovecs(sctx->pages_per_wr_bio);
 			sbio->bio = bio;
 		}
 
@@ -2102,7 +2102,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->dev = spage->dev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_bio_alloc_iovecs(sctx->pages_per_rd_bio);
+			bio = btrfs_logical_bio_alloc_iovecs(sctx->pages_per_rd_bio);
 			sbio->bio = bio;
 		}
 
@@ -2226,7 +2226,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto bbio_out;
 	}
 
-	bio = btrfs_bio_alloc_iovecs(0);
+	bio = btrfs_logical_bio_alloc_iovecs(0);
 	bio->bi_iter.bi_sector = logical >> 9;
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
@@ -2842,7 +2842,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	if (ret || !bbio || !bbio->raid_map)
 		goto bbio_out;
 
-	bio = btrfs_bio_alloc_iovecs(0);
+	bio = btrfs_logical_bio_alloc_iovecs(0);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c436c805a0ec..77086b9c7736 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6554,7 +6554,8 @@ static void btrfs_end_bio(struct bio *bio)
 		atomic_inc(&bbio->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
+			struct btrfs_device *dev =
+				btrfs_logical_bio(bio)->device;
 
 			ASSERT(dev->bdev);
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
@@ -6580,7 +6581,7 @@ static void btrfs_end_bio(struct bio *bio)
 			bio = bbio->orig_bio;
 		}
 
-		btrfs_io_bio(bio)->mirror_num = bbio->mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = bbio->mirror_num;
 		/* only send an error to the higher layers if it is
 		 * beyond the tolerance of the btrfs bio
 		 */
@@ -6606,7 +6607,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 	bio->bi_private = bbio;
-	btrfs_io_bio(bio)->device = dev;
+	btrfs_logical_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
@@ -6642,7 +6643,7 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 		/* Should be the original bio. */
 		WARN_ON(bio != bbio->orig_bio);
 
-		btrfs_io_bio(bio)->mirror_num = bbio->mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = bbio->mirror_num;
 		bio->bi_iter.bi_sector = logical >> 9;
 		if (atomic_read(&bbio->error) > bbio->max_errors)
 			bio->bi_status = BLK_STS_IOERR;
@@ -6717,7 +6718,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		}
 
 		if (dev_nr < total_devs - 1)
-			bio = btrfs_bio_clone(first_bio);
+			bio = btrfs_logical_bio_clone(first_bio);
 		else
 			bio = first_bio;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4c941b4dd269..22356a09131a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -300,38 +300,62 @@ struct btrfs_fs_devices {
 				/ sizeof(struct btrfs_stripe) + 1)
 
 /*
- * we need the mirror number and stripe index to be passed around
- * the call chain while we are processing end_io (especially errors).
- * Really, what we need is a btrfs_bio structure that has this info
- * and is properly sized with its stripe array, but we're not there
- * quite yet.  We have our own btrfs bioset, and all of the bios
- * we allocate are actually btrfs_io_bios.  We'll cram as much of
- * struct btrfs_bio as we can into this over time.
++ * Extra info for read/write bio of btrfs logical address.
++ *
++ * bio->bi_iter.bi_sector will be btrfs logical address, and
++ * btrfs_map_bio() will convert the logical bio to real bio to each device.
++ *
++ * Currently one logical bio can *NOT* cross stripe boundary, thus it relies on
++ * submit_extent_page() to split the io range into different logical bios.
++ *
++ * TODO: Make btrfs_map_bio() to split the bio.
  */
-struct btrfs_io_bio {
+struct btrfs_logical_bio {
+	/*
+	 * Specify which copy to read (before bio submitted), or which
+	 * copy is read from disk (at endio time).
+	 *
+	 * 0 means choose any copy. Will be affected by balance policy and
+	 * device missing status.
+	 * 1 is the first copy and etc.
+	 *
+	 * At endio time, mirror_num should not be zero.
+	 *
+	 * Normally for write, @mirror_num should always be 0. Only read time
+	 * repair utilize non-zero mirror num at write time.
+	 */
 	unsigned int mirror_num;
 	struct btrfs_device *device;
+
+	/* This is for direct IO to grab its logical bytenr */
 	u64 logical;
+
+	/*
+	 * For data read, csum will be used to verify the result.
+	 * For data write, csum will be inserted into csum tree.
+	 *
+	 * For metadata or data without csum, it will NULL.
+	 */
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 	struct bvec_iter iter;
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
-	 * bytes for entire btrfs_io_bio but relies on bio being last.
+	 * bytes for entire btrfs_logical_bio but relies on bio being last.
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
+static inline void btrfs_logical_bio_free_csum(struct btrfs_logical_bio *logical)
 {
-	if (io_bio->csum != io_bio->csum_inline) {
-		kfree(io_bio->csum);
-		io_bio->csum = NULL;
+	if (logical->csum != logical->csum_inline) {
+		kfree(logical->csum);
+		logical->csum = NULL;
 	}
 }
 
-- 
2.33.0

