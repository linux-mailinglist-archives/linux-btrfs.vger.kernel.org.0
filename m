Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540703BB508
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 04:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhGECEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 22:04:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34330 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGECEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Jul 2021 22:04:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F4411FDDF
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625450484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzPIPxxG/T1lGnpEC6n7i//QbDj8/6zVl8yfyZDCcw4=;
        b=jdmA5OOj3eIWkH0vksorI2rRyS2aORNaaeWtg5UOBl5ittGkCVtQQJDM8cxlyggFCu5R3P
        UUMJwqTiEAPT22ESjaoeLWGFqsNyeul2IDTibWoGwBQn55OKADgw8DCqQRNL/PBvIxPui3
        U2LAFmdVleCPMBn5WuLAMJxpVddEu7A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC2A713522
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDc3J/Nn4mAVSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 02:01:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 09/15] btrfs: allow submit_extent_page() to do bio split for subpage
Date:   Mon,  5 Jul 2021 10:01:04 +0800
Message-Id: <20210705020110.89358-10-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705020110.89358-1-wqu@suse.com>
References: <20210705020110.89358-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current submit_extent_page() just checks if the current page range can
be fitted into current bio, and if not, submit then re-add.

But this behavior can't handle subpage case at all.

For subpage case, the problem is in the page size, 64K, which is also
the same size as stripe size.

This means, if we can't fit a full 64K into a bio, due to stripe limit,
then it won't fit into next bio without crossing stripe either.

The proper way to handle it is:
- Check how many bytes we can put into current bio
- Put as many bytes as possible into current bio first
- Submit current bio
- Create a new bio
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
		added = btrfs_bio_add_page();

		if (added < size - offset) {
			/* The current bio is full, submit it */
		}
		cur += added;
	}

Also, since we're doing new bio allocation deep inside the main loop,
extract that code into a new helper, alloc_new_bio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 192 ++++++++++++++++++++++++++++++-------------
 1 file changed, 133 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 003285687b58..e244c10074c8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -172,6 +172,8 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 
 	bio->bi_private = NULL;
 
+	/* Caller should ensure the bio has at least some range added */
+	ASSERT(bio->bi_iter.bi_size);
 	if (is_data_inode(tree->private_data))
 		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
@@ -3181,20 +3183,22 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  * @size:	portion of page that we want to write
  * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
  * @bio_flags:	flags of the current bio to see if we can merge them
- * @return:	true if page was added, false otherwise
  *
  * Attempt to add a page to bio considering stripe alignment etc.
  *
- * Return true if successfully page added. Otherwise, return false.
+ * Return >= 0 for the number of bytes added to the bio.
+ * Can return 0 if the current bio is already at stripe/zone boundary.
+ * Return <0 for error.
  */
-static bool btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
-			       struct page *page,
-			       u64 disk_bytenr, unsigned int size,
-			       unsigned int pg_offset,
-			       unsigned long bio_flags)
+static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
+			      struct page *page,
+			      u64 disk_bytenr, unsigned int size,
+			      unsigned int pg_offset,
+			      unsigned long bio_flags)
 {
 	struct bio *bio = bio_ctrl->bio;
 	u32 bio_size = bio->bi_iter.bi_size;
+	u32 real_size;
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig;
 	int ret;
@@ -3203,25 +3207,32 @@ static bool btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary && bio_ctrl->len_to_stripe_boundary);
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
+
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
@@ -3280,6 +3291,63 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	return 0;
 }
 
+static int alloc_new_bio(struct btrfs_inode *inode,
+			 struct btrfs_bio_ctrl *bio_ctrl,
+			 struct writeback_control *wbc,
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
+	if (ret < 0)
+		goto error;
+	bio->bi_end_io = end_io_func;
+	bio->bi_private = &inode->io_tree;
+	bio->bi_write_hint = inode->vfs_inode.i_write_hint;
+	bio->bi_opf = opf;
+	if (wbc) {
+		struct block_device *bdev;
+
+		bdev = fs_info->fs_devices->latest_bdev;
+		bio_set_dev(bio, bdev);
+		wbc_init_bio(wbc, bio);
+	}
+	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct btrfs_device *device;
+
+		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
+						fs_info->sectorsize);
+		if (IS_ERR(device)) {
+			ret = PTR_ERR(device);
+			goto error;
+		}
+
+		btrfs_io_bio(bio)->device = device;
+	}
+	return 0;
+error:
+	bio_ctrl->bio = NULL;
+	bio->bi_status = errno_to_blk_status(ret);
+	bio_endio(bio);
+	return ret;
+}
+
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
@@ -3305,61 +3373,67 @@ static int submit_extent_page(unsigned int opf,
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
+
+	while (cur < pg_offset + size) {
+		u32 offset = cur - pg_offset;
+		int added;
+
+		/* Allocate new bio if needed */
+		if (!bio_ctrl->bio) {
+			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
+					    end_io_func, disk_bytenr, offset,
+					    bio_flags);
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
+			ASSERT(added == 0 || added == size - offset);
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
-		struct btrfs_device *device;
-
-		device = btrfs_zoned_get_device(fs_info, disk_bytenr, io_size);
-		if (IS_ERR(device))
-			return PTR_ERR(device);
-
-		btrfs_io_bio(bio)->device = device;
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
2.32.0

