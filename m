Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28536CF37
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhD0XGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239488AbhD0XGD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:06:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uftk//bPkSIWqbqIyNDv9J5doRS4thsqpdWD8TKa1yQ=;
        b=iXly/qCWG5oKdL0e7UAijOtTFAZlhCqC/SSUDgDMh1jp2C4w5cI2kV1sPNy/LrYiHTEcvh
        YQq5U7WFfGdHRx9o27YXLFHQoo+LKhAbMN06sbYJU85obP0w33jrpyW+94H3HWYQwBIb7C
        8uXKJwPxQlIah1NjfQjO6YpFfgwo0fA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F110AC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:05:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 38/42] btrfs: allow submit_extent_page() to do bio split for subpage
Date:   Wed, 28 Apr 2021 07:03:45 +0800
Message-Id: <20210427230349.369603-39-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current submit_extent_page() just if the current page range can fit into
the current bio, and if not, submit then re-add.

But this behavior has a problem, it can't handle subpage cases.

For subpage case, the problem is in the page size, 64K, which is also
the same size as stripe size.

This means, if we can't fit a full 64K into a bio, due to stripe limit,
then it won't fit into next bio without crossing stripe either.

The proper way to handle it is:
- Check how many bytes we can put into current bio
- Put as many bytes as possible into current bio first
- Submit current bio
- Create new bio
- Add the remaining bytes into the new bio

Refactor submit_extent_page() so that it does the above iteration.

The main loop inside submit_extent_page() will look like this:

	cur = pg_offset;
	while (cur < pg_offset + size) {
		u32 offset = cur - pg_offset;
		int added;
		if (!bio_ctrl->bio) {
			/* Allocate new bio if needed */
		}
		/* Add as many bytes into the bio */
		if (added < size - offset) {
			/* The current bio is full, submit it */
		}
		cur += added;
	}

Also, since we're doing new bio allocation deep inside the main loop,
extra that code into a new function, alloc_new_bio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 183 ++++++++++++++++++++++++++++---------------
 1 file changed, 122 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c4615e087446..14ab11381d49 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -172,6 +172,7 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 
 	bio->bi_private = NULL;
 
+	ASSERT(bio->bi_iter.bi_size);
 	if (is_data_inode(tree->private_data))
 		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
@@ -3201,13 +3202,13 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  * @size:	portion of page that we want to write
  * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
  * @bio_flags:	flags of the current bio to see if we can merge them
- * @return:	true if page was added, false otherwise
  *
  * Attempt to add a page to bio considering stripe alignment etc.
  *
- * Return true if successfully page added. Otherwise, return false.
+ * Return >= 0 for the number of bytes added to the bio.
+ * Return <0 for error.
  */
-static bool btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
+static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 			       struct page *page,
 			       u64 disk_bytenr, unsigned int size,
 			       unsigned int pg_offset,
@@ -3215,6 +3216,7 @@ static bool btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 {
 	struct bio *bio = bio_ctrl->bio;
 	u32 bio_size = bio->bi_iter.bi_size;
+	u32 real_size;
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig;
 	int ret;
@@ -3223,26 +3225,33 @@ static bool btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary &&
 	       bio_ctrl->len_to_stripe_boundary);
+
 	if (bio_ctrl->bio_flags != bio_flags)
-		return false;
+		return 0;
 
 	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED)
 		contig = bio->bi_iter.bi_sector == sector;
 	else
 		contig = bio_end_sector(bio) == sector;
 	if (!contig)
-		return false;
+		return 0;
 
-	if (bio_size + size > bio_ctrl->len_to_oe_boundary ||
-	    bio_size + size > bio_ctrl->len_to_stripe_boundary)
-		return false;
+	real_size = min(bio_ctrl->len_to_oe_boundary,
+			bio_ctrl->len_to_stripe_boundary) - bio_size;
+	real_size = min(real_size, size);
+	/*
+	 * If real_size is 0, never call bio_add_*_page(), as even size is 0,
+	 * bio will still execute its endio function on the page!
+	 */
+	if (real_size == 0)
+		return 0;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
+		ret = bio_add_zone_append_page(bio, page, real_size, pg_offset);
 	else
-		ret = bio_add_page(bio, page, size, pg_offset);
+		ret = bio_add_page(bio, page, real_size, pg_offset);
 
-	return ret == size;
+	return ret;
 }
 
 static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
@@ -3301,6 +3310,61 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	return 0;
 }
 
+static int alloc_new_bio(struct btrfs_inode *inode,
+			 struct btrfs_bio_ctrl *bio_ctrl,
+			 unsigned int opf,
+			 bio_end_io_t end_io_func,
+			 u64 disk_bytenr, u32 offset,
+			 unsigned long bio_flags)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct bio *bio;
+	int ret;
+
+	/*
+	 * For compressed page range, its disk_bytenr is always
+	 * @disk_bytenr passed in, no matter if we have added
+	 * any range into previous bio.
+	 */
+	if (bio_flags & EXTENT_BIO_COMPRESSED)
+		bio = btrfs_bio_alloc(disk_bytenr);
+	else
+		bio = btrfs_bio_alloc(disk_bytenr + offset);
+	bio_ctrl->bio = bio;
+	bio_ctrl->bio_flags = bio_flags;
+	ret = calc_bio_boundaries(bio_ctrl, inode);
+	if (ret < 0) {
+		bio_ctrl->bio = NULL;
+		bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(bio);
+		return ret;
+	}
+	bio->bi_end_io = end_io_func;
+	bio->bi_private = &inode->io_tree;
+	bio->bi_write_hint = inode->vfs_inode.i_write_hint;
+	bio->bi_opf = opf;
+	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct extent_map *em;
+		struct map_lookup *map;
+
+		em = btrfs_get_chunk_map(fs_info, disk_bytenr,
+					 fs_info->sectorsize);
+		if (IS_ERR(em)) {
+			bio_ctrl->bio = NULL;
+			bio->bi_status = errno_to_blk_status(ret);
+			bio_endio(bio);
+			return ret;
+		}
+
+		map = em->map_lookup;
+		/* We only support single profile for now */
+		ASSERT(map->num_stripes == 1);
+		btrfs_io_bio(bio)->device = map->stripes[0].dev;
+
+		free_extent_map(em);
+	}
+	return 0;
+}
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
@@ -3326,67 +3390,64 @@ static int submit_extent_page(unsigned int opf,
 			      bool force_bio_submit)
 {
 	int ret = 0;
-	struct bio *bio;
-	size_t io_size = min_t(size_t, size, PAGE_SIZE);
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	struct extent_io_tree *tree = &inode->io_tree;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	unsigned int cur = pg_offset;
 
 	ASSERT(bio_ctrl);
 
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
-	if (bio_ctrl->bio) {
-		bio = bio_ctrl->bio;
-		if (force_bio_submit ||
-		    !btrfs_bio_add_page(bio_ctrl, page, disk_bytenr, io_size,
-					pg_offset, bio_flags)) {
-			ret = submit_one_bio(bio, mirror_num, bio_ctrl->bio_flags);
+	if (force_bio_submit && bio_ctrl->bio) {
+		ret = submit_one_bio(bio_ctrl->bio, mirror_num,
+				     bio_ctrl->bio_flags);
+		bio_ctrl->bio = NULL;
+		if (ret < 0)
+			return ret;
+	}
+	while (cur < pg_offset + size) {
+		u32 offset = cur - pg_offset;
+		int added;
+		/* Allocate new bio if needed */
+		if (!bio_ctrl->bio) {
+			ret = alloc_new_bio(inode, bio_ctrl, opf, end_io_func,
+					    disk_bytenr, offset, bio_flags);
+			if (ret < 0)
+				return ret;
+		}
+		/*
+		 * We must go through btrfs_bio_add_page() to ensure each
+		 * page range won't cross various boundaries.
+		 */
+		if (bio_flags & EXTENT_BIO_COMPRESSED)
+			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
+					size - offset, pg_offset + offset,
+					bio_flags);
+		else
+			added = btrfs_bio_add_page(bio_ctrl, page,
+					disk_bytenr + offset, size - offset,
+					pg_offset + offset, bio_flags);
+
+		/* Metadata page range should never be split */
+		if (!is_data_inode(&inode->vfs_inode))
+			ASSERT(added == 0 || added == size);
+
+		/* At least we added some page, update the account */
+		if (wbc && added)
+			wbc_account_cgroup_owner(wbc, page, added);
+
+		/* We have reached boundary, submit right now */
+		if (added < size - offset) {
+			/* The bio should contain some page(s) */
+			ASSERT(bio_ctrl->bio->bi_iter.bi_size);
+			ret = submit_one_bio(bio_ctrl->bio, mirror_num,
+					bio_ctrl->bio_flags);
 			bio_ctrl->bio = NULL;
 			if (ret < 0)
 				return ret;
-		} else {
-			if (wbc)
-				wbc_account_cgroup_owner(wbc, page, io_size);
-			return 0;
 		}
+		cur += added;
 	}
-
-	bio = btrfs_bio_alloc(disk_bytenr);
-	bio_add_page(bio, page, io_size, pg_offset);
-	bio->bi_end_io = end_io_func;
-	bio->bi_private = tree;
-	bio->bi_write_hint = page->mapping->host->i_write_hint;
-	bio->bi_opf = opf;
-	if (wbc) {
-		struct block_device *bdev;
-
-		bdev = fs_info->fs_devices->latest_bdev;
-		bio_set_dev(bio, bdev);
-		wbc_init_bio(wbc, bio);
-		wbc_account_cgroup_owner(wbc, page, io_size);
-	}
-	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct extent_map *em;
-		struct map_lookup *map;
-
-		em = btrfs_get_chunk_map(fs_info, disk_bytenr, io_size);
-		if (IS_ERR(em))
-			return PTR_ERR(em);
-
-		map = em->map_lookup;
-		/* We only support single profile for now */
-		ASSERT(map->num_stripes == 1);
-		btrfs_io_bio(bio)->device = map->stripes[0].dev;
-
-		free_extent_map(em);
-	}
-
-	bio_ctrl->bio = bio;
-	bio_ctrl->bio_flags = bio_flags;
-	ret = calc_bio_boundaries(bio_ctrl, inode);
-
-	return ret;
+	return 0;
 }
 
 static int attach_extent_buffer_page(struct extent_buffer *eb,
-- 
2.31.1

