Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC329E31A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgJ2CpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:45:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgJ1Vdo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603869882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4W88er9Sf1WrhRkZapVJY5WShpyacdDxDYHZuOCSm8=;
        b=P/gnJ80/LmSu8YxxaSYw0++9hsC323bWR43GDLr8T0MTrtNEFAYSgPbXLr1YPEH+6YA5g7
        UsTovXEolwrKUE80R5mW/os8wTLhjWoo+5gEwZg5VQe8dZZY5uvCVXnpWz1yhz0O4ihzeV
        hYqj6IQGiRJC8WtyFadL82Ut76cr5qM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1D84AF22
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 07:24:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: file-item: refactor btrfs_lookup_bio_sums() to handle out-of-order bvecs
Date:   Wed, 28 Oct 2020 15:24:32 +0800
Message-Id: <20201028072432.86907-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028072432.86907-1-wqu@suse.com>
References: <20201028072432.86907-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor btrfs_lookup_bio_sums() by:
- Extract the csum tree lookup into find_csum_tree_sums()
  The new function will handle the csum search in csum tree.
  The return value is the same as btrfs_find_ordered_sum(), returning
  the found number of sectors who has checksum.

- Change how we do the main loop
  The parameter bio is in fact just a distraction.
  The only needed info from bio is:
  * the on-disk bytenr
  * the file_offset (if file_offset == (u64)-1)
  * the length

  After extracting above info, we can do the search without bio
  at all, which makes the main loop much simpler:

	for (cur_offset = orig_file_offset; cur_offset < orig_file_offset + orig_len;
	     cur_offset += count * sectorsize) {
		/* Lookup ordered csum */
		count = btrfs_find_ordered_sum(inode, cur_offset,
					       cur_disk_bytenr, csum_dst,
					       search_len / sectorsize);
		if (count)
			continue;
		/* Lookup csum tree */
		count = find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
					    search_len, csum_dst);
		if (!count) {
			/* Csum hole handling */
		}
	}

- Use single variable as core to calculate all other offsets
  Instead of all differnt type of variables, we use only one core
  variable, cur_offset, which represents the current file offset.

  All involves values can be calculated from that core variable, and
  all those variable will only be visible in the inner loop.

    diff_sectors = (cur_offset - orig_file_offset) / sectorsize;
    cur_disk_bytenr = orig_disk_bytenr + diff_sectors * sectorsize;
    csum_dst = csum + diff_sectors * csum_size;

- Fix bugs related to the bio iteration
  There are several hidden pitfalls related to the csum lookup.
  The biggest one is related to the bvec iteration.
  There are cases that the bvecs are not in linear bytenr order, like
  the following case with added debug info:
    btrfs_lookup_bio_sums: file_offset=-1 expected_bvec_offset=532480 page_offset=716800 bv_offset=0
    btrfs_lookup_bio_sums: orig_file_offset=520192 bvec_index=3 root=259 ino=260 page_owner_ino=260

  This is even more dangerous for subpage support, as for subpage case,
  we can have bvec with non-zero bv_offset, and if they get re-ordered,
  we can easily get incorrect csum skip and lead to false csum warning.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 236 ++++++++++++++++++++++++++-----------------
 1 file changed, 142 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index fbc60948b2c4..5f60ce6f227a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -239,44 +239,117 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
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
+static int find_csum_tree_sums(struct btrfs_fs_info *fs_info,
+			       struct btrfs_path *path, u64 disk_bytenr,
+			       u64 len, u8 *dst)
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
+		csum_len = btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
+			   csum_size * sectorsize;
+
+		if (csum_start <= disk_bytenr &&
+		    csum_start + csum_len > disk_bytenr)
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
+found:
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	csum_start = key.offset;
+	csum_len = btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
+		   csum_size * sectorsize;
+	ASSERT(csum_start <= disk_bytenr &&
+	       csum_start + csum_len > disk_bytenr);
+
+	ret = div_u64(min(csum_start + csum_len, disk_bytenr + len) -
+		      disk_bytenr, sectorsize);
+	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
+			ret * csum_size);
+out:
+	if (ret == -ENOENT) {
+		ret = 0;
+		memset(dst, 0, csum_size);
+	}
+	return ret;
+}
+
 /**
  * btrfs_lookup_bio_sums - Look up checksums for a bio.
- * @inode: inode that the bio is for.
- * @bio: bio to look up.
- * @offset: Unless (u64)-1, look up checksums for this offset in the file.
- *          If (u64)-1, use the page offsets from the bio instead.
- * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
- *       checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
- *       NULL, the checksum buffer is allocated and returned in
- *       btrfs_io_bio(bio)->csum instead.
+ * @inode:		Inode that the bio is for.
+ * @bio:		Bio to look up.
+ *			NOTE: The bio is only used to determine the file_offset
+ *			and length.
+ * @file_offset:	File offset of the bio.
+ * 			If (u64)-1, will use the bio to determine the
+ * 			file offset.
+ * @dst:		Csum destination.
+ * 			Should be at least (bio->bi_iter.bi_size /
+ * 			fs_info->sectorsize * csum_size) bytes in size.
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 offset, u8 *dst)
+				   u64 file_offset, u8 *dst)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct bio_vec bvec;
-	struct bvec_iter iter;
-	struct btrfs_csum_item *item = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
-	const bool page_offsets = (offset == (u64)-1);
+	u32 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u32 sectorsize = fs_info->sectorsize;
+	u64 orig_file_offset;
+	u64 orig_len;
+	u64 orig_disk_bytenr = bio->bi_iter.bi_sector << 9;
+	/* Current file offset, is used to calculate all other values */
+	u64 cur_offset;
 	u8 *csum;
-	u64 item_start_offset = 0;
-	u64 item_last_offset = 0;
-	u64 disk_bytenr;
-	u64 page_bytes_left;
-	u32 diff;
 	int nblocks;
 	int count = 0;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+
+	if (file_offset == (u64)-1)
+		orig_file_offset = page_offset(bio_first_page_all(bio)) +
+				   bio_first_bvec_all(bio)->bv_offset;
+	else
+		orig_file_offset = file_offset;
+
+	orig_len = bio->bi_iter.bi_size;
+	nblocks = orig_len >> inode->i_sb->s_blocksize_bits;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return BLK_STS_RESOURCE;
 
-	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
 	if (!dst) {
 		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
 
@@ -313,85 +386,60 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		path->skip_locking = 1;
 	}
 
-	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
-
-	bio_for_each_segment(bvec, bio, iter) {
-		page_bytes_left = bvec.bv_len;
-		if (count)
-			goto next;
-
-		if (page_offsets)
-			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
-		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
-					       csum, nblocks);
+	/*
+	 * In fact, for csum lookup we don't really need bio at all.
+	 *
+	 * We know the on-disk bytenr, the file_offset, and length.
+	 * That's enough to search csum. The bio is in fact just a distraction
+	 * and following bio bvec would make thing much hard to go.
+	 * As we could have subpage bvec (with different bv_len) and non-linear
+	 * bvec.
+	 *
+	 * So here we don't bother bio at all, just use @cur_offset to do the
+	 * iteration.
+	 */
+	for (cur_offset = orig_file_offset; cur_offset < orig_file_offset + orig_len;
+	     cur_offset += count * sectorsize) {
+		u64 cur_disk_bytenr;
+		int search_len = orig_file_offset + orig_len - cur_offset;
+		int diff_sectors;
+		u8 *csum_dst;
+
+		diff_sectors = div_u64(cur_offset - orig_file_offset,
+				       sectorsize);
+		cur_disk_bytenr = orig_disk_bytenr +
+				  diff_sectors * sectorsize;
+		csum_dst = csum + diff_sectors * csum_size;
+
+		count = btrfs_find_ordered_sum(inode, cur_offset,
+					       cur_disk_bytenr, csum_dst,
+					       search_len / sectorsize);
 		if (count)
-			goto found;
-
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
-						EXTENT_NODATASUM);
-				} else {
-					btrfs_info_rl(fs_info,
-						   "no csum found for inode %llu start %llu",
-					       btrfs_ino(BTRFS_I(inode)), offset);
-				}
-				item = NULL;
-				btrfs_release_path(path);
-				goto found;
+			continue;
+		count = find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
+					    search_len, csum_dst);
+		if (!count) {
+			/*
+			 * For not found case, the csum has been zeroed
+			 * in find_csum_tree_sums() already, just skip
+			 * to next sector.
+			 */
+			count = 1;
+			if (BTRFS_I(inode)->root->root_key.objectid ==
+			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
+				set_extent_bits(io_tree, cur_offset,
+					cur_offset + sectorsize - 1,
+					EXTENT_NODATASUM);
+			} else {
+				btrfs_warn_rl(fs_info,
+		"csum hole found for root %lld inode %llu range [%llu, %llu)",
+				BTRFS_I(inode)->root->root_key.objectid,
+				btrfs_ino(BTRFS_I(inode)),
+				cur_offset, cur_offset + sectorsize);
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
-		diff = diff / fs_info->sectorsize;
-		diff = diff * csum_size;
-		count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
-					    inode->i_sb->s_blocksize_bits);
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
-- 
2.29.1

