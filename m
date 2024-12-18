Return-Path: <linux-btrfs+bounces-10536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6609F61F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4318961AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C2199EB0;
	Wed, 18 Dec 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gmi5JTY5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gmi5JTY5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4E198A1A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514928; cv=none; b=pdMmcgwPtHOHE7ODYbzerXNkQmjG2XhUnwn05fb3rlaKvYYD3EQP8rJO6C2VsEeVxloJ+H0+F9baRPp2s0xRlj4BBPeYvyG/unCNTs5aVfPGjtmQILEygXQJ3eE0q1p3uZI8SqhT2VTqTFk7kQweeixmL6coN717s6WHmvgkxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514928; c=relaxed/simple;
	bh=AbvK4fHcrIdamgVU1I1UkMReFDXK6mOhUMFeg1c33xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6SH0nO9wXlszuQ7eEUnaVQq6CgLt3qWZISYLZ7o7rUFPOpPIgjsLjBcy1DrZesF8DSo3PW2hqBGhwbFd8VIq4yPLP0jltmMxb4nQyKW5bsyGd2hvE329XkG7R6MMK7M/kSf12QJl/jL02teTMglB+SKdlULAX5COFR/qIAuWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gmi5JTY5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gmi5JTY5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E5E521167
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtgpT0ATC9SBBgScEhieFkp0pkzxW7Tbe3TRujoH1Ks=;
	b=Gmi5JTY5gf1asyohWdOOc5i1DoHNiKB9LsZfpX0k9orPeHaW7PY1Rq23KpaSeSjVW4Zy9N
	lxsJDGvlZLIwudDq7HQJNqYQyB+mFUtwRGplcCX5hPskAupmexpv4zUocbaMBuq210+1zy
	8gWZgvFYEIqDO81lVQnxy01zxWPbO6w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gmi5JTY5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtgpT0ATC9SBBgScEhieFkp0pkzxW7Tbe3TRujoH1Ks=;
	b=Gmi5JTY5gf1asyohWdOOc5i1DoHNiKB9LsZfpX0k9orPeHaW7PY1Rq23KpaSeSjVW4Zy9N
	lxsJDGvlZLIwudDq7HQJNqYQyB+mFUtwRGplcCX5hPskAupmexpv4zUocbaMBuq210+1zy
	8gWZgvFYEIqDO81lVQnxy01zxWPbO6w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B621132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6KKVAuuYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/18] btrfs: migrate file-item.c to use block size terminology
Date: Wed, 18 Dec 2024 20:11:24 +1030
Message-ID: <7580377dcbe6844964379df7c9760a8077c81f6c.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E5E521167
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Straightforward rename from "sector" to "block", except the bio
interface.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 94 ++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 886749b39672..89b37b59c324 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -77,7 +77,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
  * Does not need to call this in the case where we're replacing an existing file
  * extent, however if not sure it's fine to call this multiple times.
  *
- * The start and len must match the file extent item, so thus must be sectorsize
+ * The start and len must match the file extent item, so thus must be blocksize
  * aligned.
  */
 int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
@@ -89,7 +89,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 	if (len == 0)
 		return 0;
 
-	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->blocksize));
 
 	return set_extent_bit(inode->file_extent_tree, start, start + len - 1,
 			      EXTENT_DIRTY, NULL);
@@ -106,7 +106,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
  * need to be called for cases where we're replacing a file extent, like when
  * we've COWed a file extent.
  *
- * The start and len must match the file extent item, so thus must be sectorsize
+ * The start and len must match the file extent item, so thus must be blocksize
  * aligned.
  */
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
@@ -118,7 +118,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 	if (len == 0)
 		return 0;
 
-	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) ||
+	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->blocksize) ||
 	       len == (u64)-1);
 
 	return clear_extent_bit(inode->file_extent_tree, start,
@@ -127,16 +127,16 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 static size_t bytes_to_csum_size(const struct btrfs_fs_info *fs_info, u32 bytes)
 {
-	ASSERT(IS_ALIGNED(bytes, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(bytes, fs_info->blocksize));
 
-	return (bytes >> fs_info->sectorsize_bits) * fs_info->csum_size;
+	return (bytes >> fs_info->blocksize_bits) * fs_info->csum_size;
 }
 
 static size_t csum_size_to_bytes(const struct btrfs_fs_info *fs_info, u32 csum_size)
 {
 	ASSERT(IS_ALIGNED(csum_size, fs_info->csum_size));
 
-	return (csum_size / fs_info->csum_size) << fs_info->sectorsize_bits;
+	return (csum_size / fs_info->csum_size) << fs_info->blocksize_bits;
 }
 
 static inline u32 max_ordered_sum_bytes(const struct btrfs_fs_info *fs_info)
@@ -230,7 +230,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 			goto fail;
 
 		csum_offset = (bytenr - found_key.offset) >>
-				fs_info->sectorsize_bits;
+				fs_info->blocksize_bits;
 		csums_in_item = btrfs_item_size(leaf, path->slots[0]);
 		csums_in_item /= csum_size;
 
@@ -271,9 +271,9 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
  * Find checksums for logical bytenr range [disk_bytenr, disk_bytenr + len) and
  * store the result to @dst.
  *
- * Return >0 for the number of sectors we found.
- * Return 0 for the range [disk_bytenr, disk_bytenr + sectorsize) has no csum
- * for it. Caller may want to try next sector until one range is hit.
+ * Return >0 for the number of blocks we found.
+ * Return 0 for the range [disk_bytenr, disk_bytenr + blocksize) has no csum
+ * for it. Caller may want to try next block until one range is hit.
  * Return <0 for fatal error.
  */
 static int search_csum_tree(struct btrfs_fs_info *fs_info,
@@ -283,15 +283,15 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *csum_root;
 	struct btrfs_csum_item *item = NULL;
 	struct btrfs_key key;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	const u32 csum_size = fs_info->csum_size;
 	u32 itemsize;
 	int ret;
 	u64 csum_start;
 	u64 csum_len;
 
-	ASSERT(IS_ALIGNED(disk_bytenr, sectorsize) &&
-	       IS_ALIGNED(len, sectorsize));
+	ASSERT(IS_ALIGNED(disk_bytenr, blocksize) &&
+	       IS_ALIGNED(len, blocksize));
 
 	/* Check if the current csum item covers disk_bytenr */
 	if (path->nodes[0]) {
@@ -301,7 +301,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 		itemsize = btrfs_item_size(path->nodes[0], path->slots[0]);
 
 		csum_start = key.offset;
-		csum_len = (itemsize / csum_size) * sectorsize;
+		csum_len = (itemsize / csum_size) * blocksize;
 
 		if (in_range(disk_bytenr, csum_start, csum_len))
 			goto found;
@@ -319,12 +319,12 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	itemsize = btrfs_item_size(path->nodes[0], path->slots[0]);
 
 	csum_start = key.offset;
-	csum_len = (itemsize / csum_size) * sectorsize;
+	csum_len = (itemsize / csum_size) * blocksize;
 	ASSERT(in_range(disk_bytenr, csum_start, csum_len));
 
 found:
 	ret = (min(csum_start + csum_len, disk_bytenr + len) -
-		   disk_bytenr) >> fs_info->sectorsize_bits;
+		   disk_bytenr) >> fs_info->blocksize_bits;
 	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
 			ret * csum_size);
 out:
@@ -344,11 +344,11 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 	struct btrfs_path *path;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	const u32 csum_size = fs_info->csum_size;
 	u32 orig_len = bio->bi_iter.bi_size;
 	u64 orig_disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
+	const unsigned int nblocks = orig_len >> fs_info->blocksize_bits;
 	blk_status_t ret = BLK_STS_OK;
 	u32 bio_offset = 0;
 
@@ -384,7 +384,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	}
 
 	/*
-	 * If requested number of sectors is larger than one leaf can contain,
+	 * If requested number of blocks is larger than one leaf can contain,
 	 * kick the readahead for csum tree.
 	 */
 	if (nblocks > fs_info->csums_per_leaf)
@@ -405,7 +405,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		int count;
 		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
 		u8 *csum_dst = bbio->csum +
-			(bio_offset >> fs_info->sectorsize_bits) * csum_size;
+			(bio_offset >> fs_info->blocksize_bits) * csum_size;
 
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
 					 orig_len - bio_offset, csum_dst);
@@ -435,15 +435,15 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 				u64 file_offset = bbio->file_offset + bio_offset;
 
 				set_extent_bit(&inode->io_tree, file_offset,
-					       file_offset + sectorsize - 1,
+					       file_offset + blocksize - 1,
 					       EXTENT_NODATASUM, NULL);
 			} else {
 				btrfs_warn_rl(fs_info,
 			"csum hole found for disk bytenr range [%llu, %llu)",
-				cur_disk_bytenr, cur_disk_bytenr + sectorsize);
+				cur_disk_bytenr, cur_disk_bytenr + blocksize);
 			}
 		}
-		bio_offset += count * sectorsize;
+		bio_offset += count * blocksize;
 	}
 
 	btrfs_free_path(path);
@@ -476,8 +476,8 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 	int ret;
 	bool found_csums = false;
 
-	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(end + 1, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(start, fs_info->blocksize) &&
+	       IS_ALIGNED(end + 1, fs_info->blocksize));
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -605,7 +605,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
  *
  * This version will set the corresponding bits in @csum_bitmap to represent
  * that there is a csum found.
- * Each bit represents a sector. Thus caller should ensure @csum_buf passed
+ * Each bit represents a block. Thus caller should ensure @csum_buf passed
  * in is large enough to contain all csums.
  */
 int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
@@ -620,8 +620,8 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 	bool free_path = false;
 	int ret;
 
-	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(end + 1, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(start, fs_info->blocksize) &&
+	       IS_ALIGNED(end + 1, fs_info->blocksize));
 
 	if (!path) {
 		path = btrfs_alloc_path();
@@ -723,8 +723,8 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 					   bytes_to_csum_size(fs_info, size));
 
 			bitmap_set(csum_bitmap,
-				(start - orig_start) >> fs_info->sectorsize_bits,
-				size >> fs_info->sectorsize_bits);
+				(start - orig_start) >> fs_info->blocksize_bits,
+				size >> fs_info->blocksize_bits);
 
 			start += size;
 		}
@@ -774,14 +774,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 
 	bio_for_each_segment(bvec, bio, iter) {
 		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
-						 bvec.bv_len + fs_info->sectorsize
+						 bvec.bv_len + fs_info->blocksize
 						 - 1);
 
 		for (i = 0; i < blockcount; i++) {
 			data = bvec_kmap_local(&bvec);
 			crypto_shash_digest(shash,
-					    data + (i * fs_info->sectorsize),
-					    fs_info->sectorsize,
+					    data + (i * fs_info->blocksize),
+					    fs_info->blocksize,
 					    sums->sums + index);
 			kunmap_local(data);
 			index += fs_info->csum_size;
@@ -832,7 +832,7 @@ static noinline void truncate_one_csum(struct btrfs_trans_handle *trans,
 	const u32 csum_size = fs_info->csum_size;
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
-	u32 blocksize_bits = fs_info->sectorsize_bits;
+	u32 blocksize_bits = fs_info->blocksize_bits;
 
 	leaf = path->nodes[0];
 	csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
@@ -883,7 +883,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int ret = 0;
 	const u32 csum_size = fs_info->csum_size;
-	u32 blocksize_bits = fs_info->sectorsize_bits;
+	u32 blocksize_bits = fs_info->blocksize_bits;
 
 	ASSERT(btrfs_root_id(root) == BTRFS_CSUM_TREE_OBJECTID ||
 	       btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID);
@@ -1125,7 +1125,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	if (btrfs_leaf_free_space(leaf) >= csum_size) {
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		csum_offset = (bytenr - found_key.offset) >>
-			fs_info->sectorsize_bits;
+			fs_info->blocksize_bits;
 		goto extend_csum;
 	}
 
@@ -1145,7 +1145,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-	csum_offset = (bytenr - found_key.offset) >> fs_info->sectorsize_bits;
+	csum_offset = (bytenr - found_key.offset) >> fs_info->blocksize_bits;
 
 	if (found_key.type != BTRFS_EXTENT_CSUM_KEY ||
 	    found_key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
@@ -1161,7 +1161,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		u32 diff;
 
 		tmp = sums->len - total_bytes;
-		tmp >>= fs_info->sectorsize_bits;
+		tmp >>= fs_info->blocksize_bits;
 		WARN_ON(tmp < 1);
 		extend_nr = max_t(int, 1, tmp);
 
@@ -1200,7 +1200,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			if (ret < 0)
 				goto out;
 
-			tmp = (next_offset - bytenr) >> fs_info->sectorsize_bits;
+			tmp = (next_offset - bytenr) >> fs_info->blocksize_bits;
 			if (tmp <= INT_MAX)
 				extend_nr = min_t(int, extend_nr, tmp);
 		}
@@ -1226,9 +1226,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		u64 tmp;
 
 		tmp = sums->len - total_bytes;
-		tmp >>= fs_info->sectorsize_bits;
+		tmp >>= fs_info->blocksize_bits;
 		tmp = min(tmp, (next_offset - file_key.offset) >>
-					 fs_info->sectorsize_bits);
+					 fs_info->blocksize_bits);
 
 		tmp = max_t(u64, 1, tmp);
 		tmp = min_t(u64, tmp, MAX_CSUM_ITEMS(fs_info, csum_size));
@@ -1248,7 +1248,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	ins_size = (u32)(sums->len - total_bytes) >> fs_info->sectorsize_bits;
+	ins_size = (u32)(sums->len - total_bytes) >> fs_info->blocksize_bits;
 	ins_size *= csum_size;
 	ins_size = min_t(u32, (unsigned long)item_end - (unsigned long)item,
 			      ins_size);
@@ -1257,7 +1257,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 
 	index += ins_size;
 	ins_size /= csum_size;
-	total_bytes += ins_size * fs_info->sectorsize;
+	total_bytes += ins_size * fs_info->blocksize;
 
 	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	if (total_bytes < sums->len) {
@@ -1322,7 +1322,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 
 		em->disk_bytenr = EXTENT_MAP_INLINE;
 		em->start = 0;
-		em->len = fs_info->sectorsize;
+		em->len = fs_info->blocksize;
 		em->offset = 0;
 		extent_map_set_compression(em, compress_type);
 	} else {
@@ -1336,7 +1336,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 /*
  * Returns the end offset (non inclusive) of the file extent item the given path
  * points to. If it points to an inline extent, the returned offset is rounded
- * up to the sector size.
+ * up to the block size.
  */
 u64 btrfs_file_extent_end(const struct btrfs_path *path)
 {
@@ -1351,7 +1351,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path)
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
-		end = leaf->fs_info->sectorsize;
+		end = leaf->fs_info->blocksize;
 	else
 		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
 
-- 
2.47.1


