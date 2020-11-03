Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD012A4697
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgKCNcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:45292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbgKCNcY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILuD6MSx2tZBMk/28SJES+NmEd7eftkRx4O4OLGW/wc=;
        b=XFw2RBpgfAJ50mJEmS/arF8X12lykJpUN+0tblMKE6OVoLpwdsF6bKcoQaLdx7FuvY2CL4
        3zYNTIe8i/hgmXSxinGuUbMv7SEE6TY78QqIMBpezJSX5jrWbV0zHJwF3kJSSqnH/pnH9y
        ohhJzwKgSCVlocyBLhwTgjHxG3z9S1w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 655E4ABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 24/32] btrfs: file-item: refactor btrfs_lookup_bio_sums() to handle out-of-order bvecs
Date:   Tue,  3 Nov 2020 21:31:00 +0800
Message-Id: <20201103133108.148112-25-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor btrfs_lookup_bio_sums() by:
- Remove the @file_offset parameter
  There are two factors making the @file_offset parameter useless:

  * For csum lookup in csum tree, file offset makes no sense
    We only need disk_bytenr, which is unrelated to file_offset

  * page_offset (file offset) of each bvec is not contiguous.
    Pages can be added to the same bio as long as their on-disk bytenr
    is contiguous, meaning we could have pages at differnt file offsets
    in the same bio.

  Thus passing file_offset makes no sense any more.
  The only user of file_offset is for data reloc inode, we will use
  a new function, search_file_offset_in_bio(), to handle it.

- Extract the csum tree lookup into find_csum_tree_sums()
  The new function will handle the csum search in csum tree.
  The return value is the same as btrfs_find_ordered_sum(), returning
  the found number of sectors who has checksum.

- Change how we do the main loop
  The only needed info from bio is:
  * the on-disk bytenr
  * the length

  After extracting above info, we can do the search without bio
  at all, which makes the main loop much simpler:

	for (cur_disk_bytenr = orig_disk_bytenr;
	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
	     cur_disk_bytenr += count * sectorsize) {

		/* Lookup csum tree */
		count = find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
					    search_len, csum_dst);
		if (!count) {
			/* Csum hole handling */
		}
	}

- Use single variable as core to calculate all other offsets
  Instead of all differnt type of variables, we use only one core
  variable, cur_disk_bytenr, which represents the current disk bytenr.

  All involves values can be calculated from that core variable, and
  all those variable will only be visible in the inner loop.

	diff_sectors = div_u64(cur_disk_bytenr - orig_disk_bytenr,
			       sectorsize);
	cur_disk_bytenr = orig_disk_bytenr +
			  diff_sectors * sectorsize;
	csum_dst = csum + diff_sectors * csum_size;

All above refactor makes btrfs_lookup_bio_sums() way more robust than it
used to, especially related to the file offset lookup.
Now file_offset lookup is only related to data reloc inode, other wise
we don't need to bother file_offset at all.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |   5 +-
 fs/btrfs/ctree.h       |   2 +-
 fs/btrfs/file-item.c   | 236 +++++++++++++++++++++++++++--------------
 fs/btrfs/inode.c       |   5 +-
 4 files changed, 159 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4e022ed72d2f..3fb6fde2ca13 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -719,8 +719,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			 */
 			refcount_inc(&cb->pending_bios);
 
-			ret = btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1,
-						    sums);
+			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 			BUG_ON(ret); /* -ENOMEM */
 
 			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
@@ -746,7 +745,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
 	BUG_ON(ret); /* -ENOMEM */
 
-	ret = btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1, sums);
+	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 	BUG_ON(ret); /* -ENOMEM */
 
 	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 10226f250274..b5909eaef231 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2957,7 +2957,7 @@ struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 offset, u8 *dst);
+				   u8 *dst);
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index ecb6a1f9945f..74bc34488a6d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -239,13 +239,115 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * Helper to find csums for logical bytenr range
+ * [disk_bytenr, disk_bytenr + len) and restore the result to @dst.
+ *
+ * Return >0 for the number of sectors we found.
+ * Return 0 for the range [disk_bytenr, disk_bytenr + sectorsize) has no csum
+ * for it. Caller may want to try next sector until one range is hit.
+ * Return <0 for fatal error.
+ */
+static int search_csum_tree(struct btrfs_fs_info *fs_info,
+			    struct btrfs_path *path, u64 disk_bytenr,
+			    u64 len, u8 *dst)
+{
+	struct btrfs_csum_item *item = NULL;
+	struct btrfs_key key;
+	u32 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u32 sectorsize = fs_info->sectorsize;
+	int ret;
+	u64 csum_start;
+	u64 csum_len;
+
+	ASSERT(IS_ALIGNED(disk_bytenr, sectorsize) &&
+	       IS_ALIGNED(len, sectorsize));
+
+	/* Check if the current csum item covers disk_bytenr */
+	if (path->nodes[0]) {
+		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				      struct btrfs_csum_item);
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		csum_start = key.offset;
+		csum_len = (btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
+			    csum_size) * sectorsize;
+
+		if (in_range(disk_bytenr, csum_start, csum_len))
+			goto found;
+	}
+
+	/* Current item doesn't contain the desired range, re-search */
+	btrfs_release_path(path);
+	item = btrfs_lookup_csum(NULL, fs_info->csum_root, path,
+				 disk_bytenr, 0);
+	if (IS_ERR(item)) {
+		ret = PTR_ERR(item);
+		goto out;
+	}
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	csum_start = key.offset;
+	csum_len = (btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
+		    csum_size) * sectorsize;
+	ASSERT(in_range(disk_bytenr, csum_start, csum_len));
+
+found:
+	ret = (min(csum_start + csum_len, disk_bytenr + len) -
+		   disk_bytenr) >> fs_info->sectorsize_bits;
+	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
+			ret * csum_size);
+out:
+	if (ret == -ENOENT)
+		ret = 0;
+	return ret;
+}
+
+/*
+ * A helper to locate the file_offset of @cur_disk_bytenr of a @bio.
+ *
+ * Bio of btrfs represents read range of
+ * [bi_sector << 9, bi_sector << 9 + bi_size).
+ * Knowing this, we can iterate through each bvec to locate the page belong to
+ * @cur_disk_bytenr and get the file offset.
+ *
+ * @inode is used to determine the bvec page really belongs to @inode.
+ *
+ * Return 0 if we can't find the file offset;
+ * Return >0 if we find the file offset and restore it to @file_offset_ret
+ */
+static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
+				     u64 disk_bytenr, u64 *file_offset_ret)
+{
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	u64 cur = bio->bi_iter.bi_sector << 9;
+	int ret = 0;
+
+	bio_for_each_segment(bvec, bio, iter) {
+		struct page *page = bvec.bv_page;
+
+		if (cur > disk_bytenr)
+			break;
+		if (cur + bvec.bv_len <= disk_bytenr) {
+			cur += bvec.bv_len;
+			continue;
+		}
+		ASSERT(in_range(disk_bytenr, cur, bvec.bv_len));
+		if (page->mapping && page->mapping->host &&
+		    page->mapping->host == inode) {
+			ret = 1;
+			*file_offset_ret = page_offset(page) + bvec.bv_offset
+				+ disk_bytenr - cur;
+			break;
+		}
+	}
+	return ret;
+}
+
 /**
- * btrfs_lookup_bio_sums - Look up checksums for a read bio.
+ * Lookup the csum for the read bio in csum tree.
  *
  * @inode: inode that the bio is for.
  * @bio: bio to look up.
- * @offset: Unless (u64)-1, look up checksums for this offset in the file.
- *          If (u64)-1, use the page offsets from the bio instead.
  * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
  *       checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
  *       NULL, the checksum buffer is allocated and returned in
@@ -254,22 +356,17 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 offset, u8 *dst)
+				   u8 *dst)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct bio_vec bvec;
-	struct bvec_iter iter;
-	struct btrfs_csum_item *item = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
-	const bool page_offsets = (offset == (u64)-1);
+	u32 sectorsize = fs_info->sectorsize;
+	u64 orig_len = bio->bi_iter.bi_size;
+	u64 orig_disk_bytenr = bio->bi_iter.bi_sector << 9;
+	u64 cur_disk_bytenr;
 	u8 *csum;
-	u64 item_start_offset = 0;
-	u64 item_last_offset = 0;
-	u64 disk_bytenr;
-	u64 page_bytes_left;
-	u32 diff;
-	int nblocks;
+	int nblocks = orig_len >> fs_info->sectorsize_bits;
 	int count = 0;
 	const u32 csum_size = fs_info->csum_size;
 
@@ -283,13 +380,16 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	 * - All of our csums should only be in csum tree
 	 *   No ordered extents csums. As ordered extents are only for write
 	 *   path.
+	 * - No need to bother any other info from bvec
+	 *   Since we're looking up csums, the only important info is the
+	 *   disk_bytenr and the length, which can all be extracted from
+	 *   bi_iter directly.
 	 */
 	ASSERT(bio_op(bio) == REQ_OP_READ);
 	path = btrfs_alloc_path();
 	if (!path)
 		return BLK_STS_RESOURCE;
 
-	nblocks = bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
 	if (!dst) {
 		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
 
@@ -326,81 +426,53 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		path->skip_locking = 1;
 	}
 
-	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
+	for (cur_disk_bytenr = orig_disk_bytenr;
+	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
+	     cur_disk_bytenr += (count << fs_info->sectorsize_bits)) {
+		int search_len = orig_disk_bytenr + orig_len - cur_disk_bytenr;
+		int sector_offset;
+		u8 *csum_dst;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		page_bytes_left = bvec.bv_len;
-		if (count)
-			goto next;
+		sector_offset = (cur_disk_bytenr - orig_disk_bytenr) >>
+				 fs_info->sectorsize_bits;
+		csum_dst = csum + sector_offset * csum_size;
 
-		if (page_offsets)
-			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
+		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
+					 search_len, csum_dst);
+		if (count <= 0) {
+			/*
+			 * Either we hit a critical error or we didn't find
+			 * the csum.
+			 * Either way, we put zero into the csums dst, and just
+			 * skip to next sector for a better luck.
+			 */
+			memset(csum_dst, 0, csum_size);
+			count = 1;
 
-		if (!item || disk_bytenr < item_start_offset ||
-		    disk_bytenr >= item_last_offset) {
-			struct btrfs_key found_key;
-			u32 item_size;
-
-			if (item)
-				btrfs_release_path(path);
-			item = btrfs_lookup_csum(NULL, fs_info->csum_root,
-						 path, disk_bytenr, 0);
-			if (IS_ERR(item)) {
-				count = 1;
-				memset(csum, 0, csum_size);
-				if (BTRFS_I(inode)->root->root_key.objectid ==
-				    BTRFS_DATA_RELOC_TREE_OBJECTID) {
-					set_extent_bits(io_tree, offset,
-						offset + fs_info->sectorsize - 1,
+			/*
+			 * For data reloc inode, we need to mark the
+			 * range NODATASUM so that balance won't report
+			 * false csum error.
+			 */
+			if (BTRFS_I(inode)->root->root_key.objectid ==
+			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
+				u64 file_offset;
+				int ret;
+
+				ret = search_file_offset_in_bio(bio, inode,
+						cur_disk_bytenr, &file_offset);
+				if (ret)
+					set_extent_bits(io_tree, file_offset,
+						file_offset + sectorsize - 1,
 						EXTENT_NODATASUM);
-				} else {
-					btrfs_info_rl(fs_info,
-						   "no csum found for inode %llu start %llu",
-					       btrfs_ino(BTRFS_I(inode)), offset);
-				}
-				item = NULL;
-				btrfs_release_path(path);
-				goto found;
+			} else {
+				btrfs_warn_rl(fs_info,
+			"csum hole found for disk bytenr range [%llu, %llu)",
+				cur_disk_bytenr, cur_disk_bytenr + sectorsize);
 			}
-			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
-					      path->slots[0]);
-
-			item_start_offset = found_key.offset;
-			item_size = btrfs_item_size_nr(path->nodes[0],
-						       path->slots[0]);
-			item_last_offset = item_start_offset +
-				(item_size / csum_size) *
-				fs_info->sectorsize;
-			item = btrfs_item_ptr(path->nodes[0], path->slots[0],
-					      struct btrfs_csum_item);
-		}
-		/*
-		 * this byte range must be able to fit inside
-		 * a single leaf so it will also fit inside a u32
-		 */
-		diff = disk_bytenr - item_start_offset;
-		diff = diff >> fs_info->sectorsize_bits;
-		diff = diff * csum_size;
-		count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
-					    fs_info->sectorsize_bits);
-		read_extent_buffer(path->nodes[0], csum,
-				   ((unsigned long)item) + diff,
-				   csum_size * count);
-found:
-		csum += count * csum_size;
-		nblocks -= count;
-next:
-		while (count > 0) {
-			count--;
-			disk_bytenr += fs_info->sectorsize;
-			offset += fs_info->sectorsize;
-			page_bytes_left -= fs_info->sectorsize;
-			if (!page_bytes_left)
-				break; /* move to next bio */
 		}
 	}
 
-	WARN_ON_ONCE(count);
 	btrfs_free_path(path);
 	return BLK_STS_OK;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0432ca58eade..50e80db2aed8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2251,7 +2251,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			 * need to csum or not, which is why we ignore skip_sum
 			 * here.
 			 */
-			ret = btrfs_lookup_bio_sums(inode, bio, (u64)-1, NULL);
+			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
 			if (ret)
 				goto out;
 		}
@@ -7859,8 +7859,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		 *
 		 * If we have csums disabled this will do nothing.
 		 */
-		status = btrfs_lookup_bio_sums(inode, dio_bio, file_offset,
-					       dip->csums);
+		status = btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
 		if (status != BLK_STS_OK)
 			goto out_err;
 	}
-- 
2.29.2

