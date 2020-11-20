Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00972BAFBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKTQMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 11:12:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKTQMR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 11:12:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605888732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+1zmZLI/ctYMG57RYaiNG/h/OrVh7hNox3gfX0Iz1f8=;
        b=sPNGGv3cyOD3/TwhtBRgko3pRh2tcf6b8yUJUfsUAZeuHk/H86YmT9Unc607RMs+6g2NjN
        dRyFCU3zES3voOLOGt15VNQ8bHEkcEx7ZO9HCTC4hspfIGvV6YcA+gXbz4Jr6AjjfcqniA
        MZLaVWneoqM23flAkWQV4pHkAC8hXBo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A29FDACC6;
        Fri, 20 Nov 2020 16:12:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4B4DDA6E1; Fri, 20 Nov 2020 17:10:25 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, josef@toxicpanda.com
Subject: [PATCH] btrfs: tree-checker: annotate all error branches as unlikely
Date:   Fri, 20 Nov 2020 17:10:23 +0100
Message-Id: <20201120161023.5033-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree checker is called many times as it verifies metadata at
read/write time. The checks follow a simple pattern:

  if (error_condition) {
	  report_error();
	  return -EUCLEAN;
  }

All the error reporting functions are annotated as __cold that is
supposed to hint the compiler to move the statement block out of the hot
path. This does not seem to happen that often.

As the error condition is expected to be false almost always, we can
annotate it with 'unlikely' as this satisfies one of the few use cases
for the annotation. The expected outcome is a stronger hint to compiler
to reorder the checks

  test
  jump to exit
  test
  jump to exit
  ...

which can be observed in asm of eg. check_dir_item,
btrfs_check_chunk_valid, check_root_item or check_leaf.

There's a measurable run time improvement reported by Josef, the testing
workload went from 655 MiB/s to 677 MiB/s, which is about +3%.

There should be no functional changes but some of the conditions have
been rewritten to produce more readable result, some lines are longer
than 80, for the sake of readability.

Signed-off-by: David Sterba <dsterba@suse.com>
---

Josef, would be good if you can add some details about the workload and
hw, I'll update the changelog. Thanks.

 fs/btrfs/tree-checker.c | 337 +++++++++++++++++++++-------------------
 1 file changed, 175 insertions(+), 162 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 1b27242a9c0b..4655220fd5c5 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -100,7 +100,8 @@ static void file_extent_err(const struct extent_buffer *eb, int slot,
  */
 #define CHECK_FE_ALIGNED(leaf, slot, fi, name, alignment)		      \
 ({									      \
-	if (!IS_ALIGNED(btrfs_file_extent_##name((leaf), (fi)), (alignment))) \
+	if (unlikely(!IS_ALIGNED(btrfs_file_extent_##name((leaf), (fi)),      \
+				 (alignment))))				      \
 		file_extent_err((leaf), (slot),				      \
 	"invalid %s for file extent, have %llu, should be aligned to %u",     \
 			(#name), btrfs_file_extent_##name((leaf), (fi)),      \
@@ -181,10 +182,10 @@ static bool check_prev_ino(struct extent_buffer *leaf,
 	 * Only subvolume trees along with their reloc trees need this check.
 	 * Things like log tree doesn't follow this ino requirement.
 	 */
-	if (!is_fstree(btrfs_header_owner(leaf)))
+	if (likely(!is_fstree(btrfs_header_owner(leaf))))
 		return true;
 
-	if (key->objectid == prev_key->objectid)
+	if (likely(key->objectid == prev_key->objectid))
 		return true;
 
 	/* Error found */
@@ -203,7 +204,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
 	u64 extent_end;
 
-	if (!IS_ALIGNED(key->offset, sectorsize)) {
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
 "unaligned file_offset for file extent, have %llu should be aligned to %u",
 			key->offset, sectorsize);
@@ -216,7 +217,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * But if objectids mismatch, it means we have a missing
 	 * INODE_ITEM.
 	 */
-	if (!check_prev_ino(leaf, key, slot, prev_key))
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
 		return -EUCLEAN;
 
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
@@ -225,14 +226,15 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * Make sure the item contains at least inline header, so the file
 	 * extent type is not some garbage.
 	 */
-	if (item_size < BTRFS_FILE_EXTENT_INLINE_DATA_START) {
+	if (unlikely(item_size < BTRFS_FILE_EXTENT_INLINE_DATA_START)) {
 		file_extent_err(leaf, slot,
 				"invalid item size, have %u expect [%zu, %u)",
 				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START,
 				SZ_4K);
 		return -EUCLEAN;
 	}
-	if (btrfs_file_extent_type(leaf, fi) >= BTRFS_NR_FILE_EXTENT_TYPES) {
+	if (unlikely(btrfs_file_extent_type(leaf, fi) >=
+		     BTRFS_NR_FILE_EXTENT_TYPES)) {
 		file_extent_err(leaf, slot,
 		"invalid type for file extent, have %u expect range [0, %u]",
 			btrfs_file_extent_type(leaf, fi),
@@ -244,14 +246,15 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * Support for new compression/encryption must introduce incompat flag,
 	 * and must be caught in open_ctree().
 	 */
-	if (btrfs_file_extent_compression(leaf, fi) >= BTRFS_NR_COMPRESS_TYPES) {
+	if (unlikely(btrfs_file_extent_compression(leaf, fi) >=
+		     BTRFS_NR_COMPRESS_TYPES)) {
 		file_extent_err(leaf, slot,
 	"invalid compression for file extent, have %u expect range [0, %u]",
 			btrfs_file_extent_compression(leaf, fi),
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (btrfs_file_extent_encryption(leaf, fi)) {
+	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
 		file_extent_err(leaf, slot,
 			"invalid encryption for file extent, have %u expect 0",
 			btrfs_file_extent_encryption(leaf, fi));
@@ -259,7 +262,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	}
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
 		/* Inline extent must have 0 as key offset */
-		if (key->offset) {
+		if (unlikely(key->offset)) {
 			file_extent_err(leaf, slot,
 		"invalid file_offset for inline file extent, have %llu expect 0",
 				key->offset);
@@ -272,8 +275,8 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			return 0;
 
 		/* Uncompressed inline extent size must match item size */
-		if (item_size != BTRFS_FILE_EXTENT_INLINE_DATA_START +
-		    btrfs_file_extent_ram_bytes(leaf, fi)) {
+		if (unlikely(item_size != BTRFS_FILE_EXTENT_INLINE_DATA_START +
+					  btrfs_file_extent_ram_bytes(leaf, fi))) {
 			file_extent_err(leaf, slot,
 	"invalid ram_bytes for uncompressed inline extent, have %u expect %llu",
 				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START +
@@ -284,22 +287,22 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	}
 
 	/* Regular or preallocated extent has fixed item size */
-	if (item_size != sizeof(*fi)) {
+	if (unlikely(item_size != sizeof(*fi))) {
 		file_extent_err(leaf, slot,
 	"invalid item size for reg/prealloc file extent, have %u expect %zu",
 			item_size, sizeof(*fi));
 		return -EUCLEAN;
 	}
-	if (CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
-	    CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
-	    CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, sectorsize) ||
-	    CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
-	    CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize))
+	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize)))
 		return -EUCLEAN;
 
 	/* Catch extent end overflow */
-	if (check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
-			       key->offset, &extent_end)) {
+	if (unlikely(check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
+					key->offset, &extent_end))) {
 		file_extent_err(leaf, slot,
 	"extent end overflow, have file offset %llu extent num bytes %llu",
 				key->offset,
@@ -320,7 +323,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		prev_fi = btrfs_item_ptr(leaf, slot - 1,
 					 struct btrfs_file_extent_item);
 		prev_end = file_extent_end(leaf, prev_key, prev_fi);
-		if (prev_end > key->offset) {
+		if (unlikely(prev_end > key->offset)) {
 			file_extent_err(leaf, slot - 1,
 "file extent end range (%llu) goes beyond start offset (%llu) of the next file extent",
 					prev_end, key->offset);
@@ -338,19 +341,19 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	u32 sectorsize = fs_info->sectorsize;
 	const u32 csumsize = fs_info->csum_size;
 
-	if (key->objectid != BTRFS_EXTENT_CSUM_OBJECTID) {
+	if (unlikely(key->objectid != BTRFS_EXTENT_CSUM_OBJECTID)) {
 		generic_err(leaf, slot,
 		"invalid key objectid for csum item, have %llu expect %llu",
 			key->objectid, BTRFS_EXTENT_CSUM_OBJECTID);
 		return -EUCLEAN;
 	}
-	if (!IS_ALIGNED(key->offset, sectorsize)) {
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		generic_err(leaf, slot,
 	"unaligned key offset for csum item, have %llu should be aligned to %u",
 			key->offset, sectorsize);
 		return -EUCLEAN;
 	}
-	if (!IS_ALIGNED(btrfs_item_size_nr(leaf, slot), csumsize)) {
+	if (unlikely(!IS_ALIGNED(btrfs_item_size_nr(leaf, slot), csumsize))) {
 		generic_err(leaf, slot,
 	"unaligned item size for csum item, have %u should be aligned to %u",
 			btrfs_item_size_nr(leaf, slot), csumsize);
@@ -363,7 +366,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 		prev_item_size = btrfs_item_size_nr(leaf, slot - 1);
 		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
 		prev_csum_end += prev_key->offset;
-		if (prev_csum_end > key->offset) {
+		if (unlikely(prev_csum_end > key->offset)) {
 			generic_err(leaf, slot - 1,
 "csum end range (%llu) goes beyond the start range (%llu) of the next csum item",
 				    prev_csum_end, key->offset);
@@ -388,15 +391,16 @@ static int check_inode_key(struct extent_buffer *leaf, struct btrfs_key *key,
 
 	/* For XATTR_ITEM, location key should be all 0 */
 	if (item_key.type == BTRFS_XATTR_ITEM_KEY) {
-		if (key->type != 0 || key->objectid != 0 || key->offset != 0)
+		if (unlikely(key->objectid != 0 || key->type != 0 ||
+			     key->offset != 0))
 			return -EUCLEAN;
 		return 0;
 	}
 
-	if ((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
-	     key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
-	    key->objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
-	    key->objectid != BTRFS_FREE_INO_OBJECTID) {
+	if (unlikely((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
+		      key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
+		     key->objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
+		     key->objectid != BTRFS_FREE_INO_OBJECTID)) {
 		if (is_inode_item) {
 			generic_err(leaf, slot,
 	"invalid key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
@@ -414,7 +418,7 @@ static int check_inode_key(struct extent_buffer *leaf, struct btrfs_key *key,
 		}
 		return -EUCLEAN;
 	}
-	if (key->offset != 0) {
+	if (unlikely(key->offset != 0)) {
 		if (is_inode_item)
 			inode_item_err(leaf, slot,
 				       "invalid key offset: has %llu expect 0",
@@ -438,7 +442,7 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	is_root_item = (item_key.type == BTRFS_ROOT_ITEM_KEY);
 
 	/* No such tree id */
-	if (key->objectid == 0) {
+	if (unlikely(key->objectid == 0)) {
 		if (is_root_item)
 			generic_err(leaf, slot, "invalid root id 0");
 		else
@@ -448,7 +452,7 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 
 	/* DIR_ITEM/INDEX/INODE_REF is not allowed to point to non-fs trees */
-	if (!is_fstree(key->objectid) && !is_root_item) {
+	if (unlikely(!is_fstree(key->objectid) && !is_root_item)) {
 		dir_item_err(leaf, slot,
 		"invalid location key objectid, have %llu expect [%llu, %llu]",
 				key->objectid, BTRFS_FIRST_FREE_OBJECTID,
@@ -464,7 +468,8 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	 * So here we only check offset for reloc tree whose key->offset must
 	 * be a valid tree.
 	 */
-	if (key->objectid == BTRFS_TREE_RELOC_OBJECTID && key->offset == 0) {
+	if (unlikely(key->objectid == BTRFS_TREE_RELOC_OBJECTID &&
+		     key->offset == 0)) {
 		generic_err(leaf, slot, "invalid root id 0 for reloc tree");
 		return -EUCLEAN;
 	}
@@ -480,8 +485,9 @@ static int check_dir_item(struct extent_buffer *leaf,
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
 	u32 cur = 0;
 
-	if (!check_prev_ino(leaf, key, slot, prev_key))
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
 		return -EUCLEAN;
+
 	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 	while (cur < item_size) {
 		struct btrfs_key location_key;
@@ -494,7 +500,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 		int ret;
 
 		/* header itself should not cross item boundary */
-		if (cur + sizeof(*di) > item_size) {
+		if (unlikely(cur + sizeof(*di) > item_size)) {
 			dir_item_err(leaf, slot,
 		"dir item header crosses item boundary, have %zu boundary %u",
 				cur + sizeof(*di), item_size);
@@ -505,12 +511,12 @@ static int check_dir_item(struct extent_buffer *leaf,
 		btrfs_dir_item_key_to_cpu(leaf, di, &location_key);
 		if (location_key.type == BTRFS_ROOT_ITEM_KEY) {
 			ret = check_root_key(leaf, &location_key, slot);
-			if (ret < 0)
+			if (unlikely(ret < 0))
 				return ret;
 		} else if (location_key.type == BTRFS_INODE_ITEM_KEY ||
 			   location_key.type == 0) {
 			ret = check_inode_key(leaf, &location_key, slot);
-			if (ret < 0)
+			if (unlikely(ret < 0))
 				return ret;
 		} else {
 			dir_item_err(leaf, slot,
@@ -522,22 +528,22 @@ static int check_dir_item(struct extent_buffer *leaf,
 
 		/* dir type check */
 		dir_type = btrfs_dir_type(leaf, di);
-		if (dir_type >= BTRFS_FT_MAX) {
+		if (unlikely(dir_type >= BTRFS_FT_MAX)) {
 			dir_item_err(leaf, slot,
 			"invalid dir item type, have %u expect [0, %u)",
 				dir_type, BTRFS_FT_MAX);
 			return -EUCLEAN;
 		}
 
-		if (key->type == BTRFS_XATTR_ITEM_KEY &&
-		    dir_type != BTRFS_FT_XATTR) {
+		if (unlikely(key->type == BTRFS_XATTR_ITEM_KEY &&
+			     dir_type != BTRFS_FT_XATTR)) {
 			dir_item_err(leaf, slot,
 		"invalid dir item type for XATTR key, have %u expect %u",
 				dir_type, BTRFS_FT_XATTR);
 			return -EUCLEAN;
 		}
-		if (dir_type == BTRFS_FT_XATTR &&
-		    key->type != BTRFS_XATTR_ITEM_KEY) {
+		if (unlikely(dir_type == BTRFS_FT_XATTR &&
+			     key->type != BTRFS_XATTR_ITEM_KEY)) {
 			dir_item_err(leaf, slot,
 			"xattr dir type found for non-XATTR key");
 			return -EUCLEAN;
@@ -550,13 +556,13 @@ static int check_dir_item(struct extent_buffer *leaf,
 		/* Name/data length check */
 		name_len = btrfs_dir_name_len(leaf, di);
 		data_len = btrfs_dir_data_len(leaf, di);
-		if (name_len > max_name_len) {
+		if (unlikely(name_len > max_name_len)) {
 			dir_item_err(leaf, slot,
 			"dir item name len too long, have %u max %u",
 				name_len, max_name_len);
 			return -EUCLEAN;
 		}
-		if (name_len + data_len > BTRFS_MAX_XATTR_SIZE(fs_info)) {
+		if (unlikely(name_len + data_len > BTRFS_MAX_XATTR_SIZE(fs_info))) {
 			dir_item_err(leaf, slot,
 			"dir item name and data len too long, have %u max %u",
 				name_len + data_len,
@@ -564,7 +570,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 			return -EUCLEAN;
 		}
 
-		if (data_len && dir_type != BTRFS_FT_XATTR) {
+		if (unlikely(data_len && dir_type != BTRFS_FT_XATTR)) {
 			dir_item_err(leaf, slot,
 			"dir item with invalid data len, have %u expect 0",
 				data_len);
@@ -574,7 +580,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 		total_size = sizeof(*di) + name_len + data_len;
 
 		/* header and name/data should not cross item boundary */
-		if (cur + total_size > item_size) {
+		if (unlikely(cur + total_size > item_size)) {
 			dir_item_err(leaf, slot,
 		"dir item data crosses item boundary, have %u boundary %u",
 				cur + total_size, item_size);
@@ -592,7 +598,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
 			name_hash = btrfs_name_hash(namebuf, name_len);
-			if (key->offset != name_hash) {
+			if (unlikely(key->offset != name_hash)) {
 				dir_item_err(leaf, slot,
 		"name hash mismatch with key, have 0x%016x expect 0x%016llx",
 					name_hash, key->offset);
@@ -641,13 +647,13 @@ static int check_block_group_item(struct extent_buffer *leaf,
 	 * Here we don't really care about alignment since extent allocator can
 	 * handle it.  We care more about the size.
 	 */
-	if (key->offset == 0) {
+	if (unlikely(key->offset == 0)) {
 		block_group_err(leaf, slot,
 				"invalid block group size 0");
 		return -EUCLEAN;
 	}
 
-	if (item_size != sizeof(bgi)) {
+	if (unlikely(item_size != sizeof(bgi))) {
 		block_group_err(leaf, slot,
 			"invalid item size, have %u expect %zu",
 				item_size, sizeof(bgi));
@@ -656,8 +662,8 @@ static int check_block_group_item(struct extent_buffer *leaf,
 
 	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
 			   sizeof(bgi));
-	if (btrfs_stack_block_group_chunk_objectid(&bgi) !=
-	    BTRFS_FIRST_CHUNK_TREE_OBJECTID) {
+	if (unlikely(btrfs_stack_block_group_chunk_objectid(&bgi) !=
+		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
 		block_group_err(leaf, slot,
 		"invalid block group chunk objectid, have %llu expect %llu",
 				btrfs_stack_block_group_chunk_objectid(&bgi),
@@ -665,7 +671,7 @@ static int check_block_group_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
-	if (btrfs_stack_block_group_used(&bgi) > key->offset) {
+	if (unlikely(btrfs_stack_block_group_used(&bgi) > key->offset)) {
 		block_group_err(leaf, slot,
 			"invalid block group used, have %llu expect [0, %llu)",
 				btrfs_stack_block_group_used(&bgi), key->offset);
@@ -673,7 +679,7 @@ static int check_block_group_item(struct extent_buffer *leaf,
 	}
 
 	flags = btrfs_stack_block_group_flags(&bgi);
-	if (hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) > 1) {
+	if (unlikely(hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) > 1)) {
 		block_group_err(leaf, slot,
 "invalid profile flags, have 0x%llx (%lu bits set) expect no more than 1 bit set",
 			flags & BTRFS_BLOCK_GROUP_PROFILE_MASK,
@@ -682,11 +688,11 @@ static int check_block_group_item(struct extent_buffer *leaf,
 	}
 
 	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
-	if (type != BTRFS_BLOCK_GROUP_DATA &&
-	    type != BTRFS_BLOCK_GROUP_METADATA &&
-	    type != BTRFS_BLOCK_GROUP_SYSTEM &&
-	    type != (BTRFS_BLOCK_GROUP_METADATA |
-			   BTRFS_BLOCK_GROUP_DATA)) {
+	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
+		     type != BTRFS_BLOCK_GROUP_METADATA &&
+		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
+		     type != (BTRFS_BLOCK_GROUP_METADATA |
+			      BTRFS_BLOCK_GROUP_DATA))) {
 		block_group_err(leaf, slot,
 "invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
 			type, hweight64(type),
@@ -773,49 +779,49 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	ncopies = btrfs_raid_array[raid_index].ncopies;
 	nparity = btrfs_raid_array[raid_index].nparity;
 
-	if (!num_stripes) {
+	if (unlikely(!num_stripes)) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk num_stripes, have %u", num_stripes);
 		return -EUCLEAN;
 	}
-	if (num_stripes < ncopies) {
+	if (unlikely(num_stripes < ncopies)) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk num_stripes < ncopies, have %u < %d",
 			  num_stripes, ncopies);
 		return -EUCLEAN;
 	}
-	if (nparity && num_stripes == nparity) {
+	if (unlikely(nparity && num_stripes == nparity)) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk num_stripes == nparity, have %u == %d",
 			  num_stripes, nparity);
 		return -EUCLEAN;
 	}
-	if (!IS_ALIGNED(logical, fs_info->sectorsize)) {
+	if (unlikely(!IS_ALIGNED(logical, fs_info->sectorsize))) {
 		chunk_err(leaf, chunk, logical,
 		"invalid chunk logical, have %llu should aligned to %u",
 			  logical, fs_info->sectorsize);
 		return -EUCLEAN;
 	}
-	if (btrfs_chunk_sector_size(leaf, chunk) != fs_info->sectorsize) {
+	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->sectorsize)) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk sectorsize, have %u expect %u",
 			  btrfs_chunk_sector_size(leaf, chunk),
 			  fs_info->sectorsize);
 		return -EUCLEAN;
 	}
-	if (!length || !IS_ALIGNED(length, fs_info->sectorsize)) {
+	if (unlikely(!length || !IS_ALIGNED(length, fs_info->sectorsize))) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk length, have %llu", length);
 		return -EUCLEAN;
 	}
-	if (!is_power_of_2(stripe_len) || stripe_len != BTRFS_STRIPE_LEN) {
+	if (unlikely(!is_power_of_2(stripe_len) || stripe_len != BTRFS_STRIPE_LEN)) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk stripe length: %llu",
 			  stripe_len);
 		return -EUCLEAN;
 	}
-	if (~(BTRFS_BLOCK_GROUP_TYPE_MASK | BTRFS_BLOCK_GROUP_PROFILE_MASK) &
-	    type) {
+	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
+			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
 		chunk_err(leaf, chunk, logical,
 			  "unrecognized chunk type: 0x%llx",
 			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
@@ -824,22 +830,23 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
-	if (!has_single_bit_set(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
-	    (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0) {
+	if (unlikely(!has_single_bit_set(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
+		     (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0)) {
 		chunk_err(leaf, chunk, logical,
 		"invalid chunk profile flag: 0x%llx, expect 0 or 1 bit set",
 			  type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
 		return -EUCLEAN;
 	}
-	if ((type & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0) {
+	if (unlikely((type & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)) {
 		chunk_err(leaf, chunk, logical,
 	"missing chunk type flag, have 0x%llx one bit must be set in 0x%llx",
 			  type, BTRFS_BLOCK_GROUP_TYPE_MASK);
 		return -EUCLEAN;
 	}
 
-	if ((type & BTRFS_BLOCK_GROUP_SYSTEM) &&
-	    (type & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA))) {
+	if (unlikely((type & BTRFS_BLOCK_GROUP_SYSTEM) &&
+		     (type & (BTRFS_BLOCK_GROUP_METADATA |
+			      BTRFS_BLOCK_GROUP_DATA)))) {
 		chunk_err(leaf, chunk, logical,
 			  "system chunk with data or metadata type: 0x%llx",
 			  type);
@@ -851,20 +858,21 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		mixed = true;
 
 	if (!mixed) {
-		if ((type & BTRFS_BLOCK_GROUP_METADATA) &&
-		    (type & BTRFS_BLOCK_GROUP_DATA)) {
+		if (unlikely((type & BTRFS_BLOCK_GROUP_METADATA) &&
+			     (type & BTRFS_BLOCK_GROUP_DATA))) {
 			chunk_err(leaf, chunk, logical,
 			"mixed chunk type in non-mixed mode: 0x%llx", type);
 			return -EUCLEAN;
 		}
 	}
 
-	if ((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes != 2) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
-	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes != 2) ||
-	    ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 && num_stripes != 1)) {
+	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes != 2) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
+		     (type & BTRFS_BLOCK_GROUP_DUP && num_stripes != 2) ||
+		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
+		      num_stripes != 1))) {
 		chunk_err(leaf, chunk, logical,
 			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
 			num_stripes, sub_stripes,
@@ -887,7 +895,7 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 {
 	int num_stripes;
 
-	if (btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk)) {
+	if (unlikely(btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk))) {
 		chunk_err(leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect [%zu, %u)",
 			btrfs_item_size_nr(leaf, slot),
@@ -901,8 +909,8 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 	if (num_stripes == 0)
 		goto out;
 
-	if (btrfs_chunk_item_size(num_stripes) !=
-	    btrfs_item_size_nr(leaf, slot)) {
+	if (unlikely(btrfs_chunk_item_size(num_stripes) !=
+		     btrfs_item_size_nr(leaf, slot))) {
 		chunk_err(leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect %lu",
 			btrfs_item_size_nr(leaf, slot),
@@ -941,14 +949,14 @@ static int check_dev_item(struct extent_buffer *leaf,
 {
 	struct btrfs_dev_item *ditem;
 
-	if (key->objectid != BTRFS_DEV_ITEMS_OBJECTID) {
+	if (unlikely(key->objectid != BTRFS_DEV_ITEMS_OBJECTID)) {
 		dev_item_err(leaf, slot,
 			     "invalid objectid: has=%llu expect=%llu",
 			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
 		return -EUCLEAN;
 	}
 	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
-	if (btrfs_device_id(leaf, ditem) != key->offset) {
+	if (unlikely(btrfs_device_id(leaf, ditem) != key->offset)) {
 		dev_item_err(leaf, slot,
 			     "devid mismatch: key has=%llu item has=%llu",
 			     key->offset, btrfs_device_id(leaf, ditem));
@@ -960,8 +968,8 @@ static int check_dev_item(struct extent_buffer *leaf,
 	 * it can be 0 for device removal. Device size check can only be done
 	 * by dev extents check.
 	 */
-	if (btrfs_device_bytes_used(leaf, ditem) >
-	    btrfs_device_total_bytes(leaf, ditem)) {
+	if (unlikely(btrfs_device_bytes_used(leaf, ditem) >
+		     btrfs_device_total_bytes(leaf, ditem))) {
 		dev_item_err(leaf, slot,
 			     "invalid bytes used: have %llu expect [0, %llu]",
 			     btrfs_device_bytes_used(leaf, ditem),
@@ -986,13 +994,13 @@ static int check_inode_item(struct extent_buffer *leaf,
 	int ret;
 
 	ret = check_inode_key(leaf, key, slot);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		return ret;
 
 	iitem = btrfs_item_ptr(leaf, slot, struct btrfs_inode_item);
 
 	/* Here we use super block generation + 1 to handle log tree */
-	if (btrfs_inode_generation(leaf, iitem) > super_gen + 1) {
+	if (unlikely(btrfs_inode_generation(leaf, iitem) > super_gen + 1)) {
 		inode_item_err(leaf, slot,
 			"invalid inode generation: has %llu expect (0, %llu]",
 			       btrfs_inode_generation(leaf, iitem),
@@ -1000,7 +1008,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	/* Note for ROOT_TREE_DIR_ITEM, mkfs could set its transid 0 */
-	if (btrfs_inode_transid(leaf, iitem) > super_gen + 1) {
+	if (unlikely(btrfs_inode_transid(leaf, iitem) > super_gen + 1)) {
 		inode_item_err(leaf, slot,
 			"invalid inode transid: has %llu expect [0, %llu]",
 			       btrfs_inode_transid(leaf, iitem), super_gen + 1);
@@ -1013,7 +1021,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 	 * anything in the fs. So here we skip the check.
 	 */
 	mode = btrfs_inode_mode(leaf, iitem);
-	if (mode & ~valid_mask) {
+	if (unlikely(mode & ~valid_mask)) {
 		inode_item_err(leaf, slot,
 			       "unknown mode bit detected: 0x%x",
 			       mode & ~valid_mask);
@@ -1026,20 +1034,20 @@ static int check_inode_item(struct extent_buffer *leaf,
 	 * FIFO/CHR/DIR/REG.  Only needs to check BLK, LNK and SOCKS
 	 */
 	if (!has_single_bit_set(mode & S_IFMT)) {
-		if (!S_ISLNK(mode) && !S_ISBLK(mode) && !S_ISSOCK(mode)) {
+		if (unlikely(!S_ISLNK(mode) && !S_ISBLK(mode) && !S_ISSOCK(mode))) {
 			inode_item_err(leaf, slot,
 			"invalid mode: has 0%o expect valid S_IF* bit(s)",
 				       mode & S_IFMT);
 			return -EUCLEAN;
 		}
 	}
-	if (S_ISDIR(mode) && btrfs_inode_nlink(leaf, iitem) > 1) {
+	if (unlikely(S_ISDIR(mode) && btrfs_inode_nlink(leaf, iitem) > 1)) {
 		inode_item_err(leaf, slot,
 		       "invalid nlink: has %u expect no more than 1 for dir",
 			btrfs_inode_nlink(leaf, iitem));
 		return -EUCLEAN;
 	}
-	if (btrfs_inode_flags(leaf, iitem) & ~BTRFS_INODE_FLAG_MASK) {
+	if (unlikely(btrfs_inode_flags(leaf, iitem) & ~BTRFS_INODE_FLAG_MASK)) {
 		inode_item_err(leaf, slot,
 			       "unknown flags detected: 0x%llx",
 			       btrfs_inode_flags(leaf, iitem) &
@@ -1059,11 +1067,12 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	int ret;
 
 	ret = check_root_key(leaf, key, slot);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		return ret;
 
-	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri) &&
-	    btrfs_item_size_nr(leaf, slot) != btrfs_legacy_root_item_size()) {
+	if (unlikely(btrfs_item_size_nr(leaf, slot) != sizeof(ri) &&
+		     btrfs_item_size_nr(leaf, slot) !=
+		     btrfs_legacy_root_item_size())) {
 		generic_err(leaf, slot,
 			    "invalid root item size, have %u expect %zu or %u",
 			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
@@ -1080,24 +1089,24 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   btrfs_item_size_nr(leaf, slot));
 
 	/* Generation related */
-	if (btrfs_root_generation(&ri) >
-	    btrfs_super_generation(fs_info->super_copy) + 1) {
+	if (unlikely(btrfs_root_generation(&ri) >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
 		generic_err(leaf, slot,
 			"invalid root generation, have %llu expect (0, %llu]",
 			    btrfs_root_generation(&ri),
 			    btrfs_super_generation(fs_info->super_copy) + 1);
 		return -EUCLEAN;
 	}
-	if (btrfs_root_generation_v2(&ri) >
-	    btrfs_super_generation(fs_info->super_copy) + 1) {
+	if (unlikely(btrfs_root_generation_v2(&ri) >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
 		generic_err(leaf, slot,
 		"invalid root v2 generation, have %llu expect (0, %llu]",
 			    btrfs_root_generation_v2(&ri),
 			    btrfs_super_generation(fs_info->super_copy) + 1);
 		return -EUCLEAN;
 	}
-	if (btrfs_root_last_snapshot(&ri) >
-	    btrfs_super_generation(fs_info->super_copy) + 1) {
+	if (unlikely(btrfs_root_last_snapshot(&ri) >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
 		generic_err(leaf, slot,
 		"invalid root last_snapshot, have %llu expect (0, %llu]",
 			    btrfs_root_last_snapshot(&ri),
@@ -1106,19 +1115,19 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 
 	/* Alignment and level check */
-	if (!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize)) {
+	if (unlikely(!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize))) {
 		generic_err(leaf, slot,
 		"invalid root bytenr, have %llu expect to be aligned to %u",
 			    btrfs_root_bytenr(&ri), fs_info->sectorsize);
 		return -EUCLEAN;
 	}
-	if (btrfs_root_level(&ri) >= BTRFS_MAX_LEVEL) {
+	if (unlikely(btrfs_root_level(&ri) >= BTRFS_MAX_LEVEL)) {
 		generic_err(leaf, slot,
 			    "invalid root level, have %u expect [0, %u]",
 			    btrfs_root_level(&ri), BTRFS_MAX_LEVEL - 1);
 		return -EUCLEAN;
 	}
-	if (btrfs_root_drop_level(&ri) >= BTRFS_MAX_LEVEL) {
+	if (unlikely(btrfs_root_drop_level(&ri) >= BTRFS_MAX_LEVEL)) {
 		generic_err(leaf, slot,
 			    "invalid root level, have %u expect [0, %u]",
 			    btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
@@ -1126,7 +1135,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 
 	/* Flags check */
-	if (btrfs_root_flags(&ri) & ~valid_root_flags) {
+	if (unlikely(btrfs_root_flags(&ri) & ~valid_root_flags)) {
 		generic_err(leaf, slot,
 			    "invalid root flags, have 0x%llx expect mask 0x%llx",
 			    btrfs_root_flags(&ri), valid_root_flags);
@@ -1180,14 +1189,14 @@ static int check_extent_item(struct extent_buffer *leaf,
 	u64 total_refs;		/* Total refs in btrfs_extent_item */
 	u64 inline_refs = 0;	/* found total inline refs */
 
-	if (key->type == BTRFS_METADATA_ITEM_KEY &&
-	    !btrfs_fs_incompat(fs_info, SKINNY_METADATA)) {
+	if (unlikely(key->type == BTRFS_METADATA_ITEM_KEY &&
+		     !btrfs_fs_incompat(fs_info, SKINNY_METADATA))) {
 		generic_err(leaf, slot,
 "invalid key type, METADATA_ITEM type invalid when SKINNY_METADATA feature disabled");
 		return -EUCLEAN;
 	}
 	/* key->objectid is the bytenr for both key types */
-	if (!IS_ALIGNED(key->objectid, fs_info->sectorsize)) {
+	if (unlikely(!IS_ALIGNED(key->objectid, fs_info->sectorsize))) {
 		generic_err(leaf, slot,
 		"invalid key objectid, have %llu expect to be aligned to %u",
 			   key->objectid, fs_info->sectorsize);
@@ -1195,8 +1204,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 	}
 
 	/* key->offset is tree level for METADATA_ITEM_KEY */
-	if (key->type == BTRFS_METADATA_ITEM_KEY &&
-	    key->offset >= BTRFS_MAX_LEVEL) {
+	if (unlikely(key->type == BTRFS_METADATA_ITEM_KEY &&
+		     key->offset >= BTRFS_MAX_LEVEL)) {
 		extent_err(leaf, slot,
 			   "invalid tree level, have %llu expect [0, %u]",
 			   key->offset, BTRFS_MAX_LEVEL - 1);
@@ -1222,7 +1231,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 	 *         Either using btrfs_extent_inline_ref::offset, or specific
 	 *         data structure.
 	 */
-	if (item_size < sizeof(*ei)) {
+	if (unlikely(item_size < sizeof(*ei))) {
 		extent_err(leaf, slot,
 			   "invalid item size, have %u expect [%zu, %u)",
 			   item_size, sizeof(*ei),
@@ -1236,15 +1245,16 @@ static int check_extent_item(struct extent_buffer *leaf,
 	flags = btrfs_extent_flags(leaf, ei);
 	total_refs = btrfs_extent_refs(leaf, ei);
 	generation = btrfs_extent_generation(leaf, ei);
-	if (generation > btrfs_super_generation(fs_info->super_copy) + 1) {
+	if (unlikely(generation >
+		     btrfs_super_generation(fs_info->super_copy) + 1)) {
 		extent_err(leaf, slot,
 			   "invalid generation, have %llu expect (0, %llu]",
 			   generation,
 			   btrfs_super_generation(fs_info->super_copy) + 1);
 		return -EUCLEAN;
 	}
-	if (!has_single_bit_set(flags & (BTRFS_EXTENT_FLAG_DATA |
-					 BTRFS_EXTENT_FLAG_TREE_BLOCK))) {
+	if (unlikely(!has_single_bit_set(flags & (BTRFS_EXTENT_FLAG_DATA |
+						  BTRFS_EXTENT_FLAG_TREE_BLOCK)))) {
 		extent_err(leaf, slot,
 		"invalid extent flag, have 0x%llx expect 1 bit set in 0x%llx",
 			flags, BTRFS_EXTENT_FLAG_DATA |
@@ -1253,21 +1263,21 @@ static int check_extent_item(struct extent_buffer *leaf,
 	}
 	is_tree_block = !!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK);
 	if (is_tree_block) {
-		if (key->type == BTRFS_EXTENT_ITEM_KEY &&
-		    key->offset != fs_info->nodesize) {
+		if (unlikely(key->type == BTRFS_EXTENT_ITEM_KEY &&
+			     key->offset != fs_info->nodesize)) {
 			extent_err(leaf, slot,
 				   "invalid extent length, have %llu expect %u",
 				   key->offset, fs_info->nodesize);
 			return -EUCLEAN;
 		}
 	} else {
-		if (key->type != BTRFS_EXTENT_ITEM_KEY) {
+		if (unlikely(key->type != BTRFS_EXTENT_ITEM_KEY)) {
 			extent_err(leaf, slot,
 			"invalid key type, have %u expect %u for data backref",
 				   key->type, BTRFS_EXTENT_ITEM_KEY);
 			return -EUCLEAN;
 		}
-		if (!IS_ALIGNED(key->offset, fs_info->sectorsize)) {
+		if (unlikely(!IS_ALIGNED(key->offset, fs_info->sectorsize))) {
 			extent_err(leaf, slot,
 			"invalid extent length, have %llu expect aligned to %u",
 				   key->offset, fs_info->sectorsize);
@@ -1281,7 +1291,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		struct btrfs_tree_block_info *info;
 
 		info = (struct btrfs_tree_block_info *)ptr;
-		if (btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL) {
+		if (unlikely(btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL)) {
 			extent_err(leaf, slot,
 			"invalid tree block info level, have %u expect [0, %u]",
 				   btrfs_tree_block_level(leaf, info),
@@ -1300,7 +1310,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		u64 inline_offset;
 		u8 inline_type;
 
-		if (ptr + sizeof(*iref) > end) {
+		if (unlikely(ptr + sizeof(*iref) > end)) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %zu end %lu",
 				   ptr, sizeof(*iref), end);
@@ -1309,7 +1319,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
 		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
-		if (ptr + btrfs_extent_inline_ref_size(inline_type) > end) {
+		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
 				   ptr, inline_type, end);
@@ -1323,7 +1333,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 			break;
 		/* Contains parent bytenr */
 		case BTRFS_SHARED_BLOCK_REF_KEY:
-			if (!IS_ALIGNED(inline_offset, fs_info->sectorsize)) {
+			if (unlikely(!IS_ALIGNED(inline_offset,
+						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
 		"invalid tree parent bytenr, have %llu expect aligned to %u",
 					   inline_offset, fs_info->sectorsize);
@@ -1338,7 +1349,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
 			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
-			if (!IS_ALIGNED(dref_offset, fs_info->sectorsize)) {
+			if (unlikely(!IS_ALIGNED(dref_offset,
+						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
 		"invalid data ref offset, have %llu expect aligned to %u",
 					   dref_offset, fs_info->sectorsize);
@@ -1349,7 +1361,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 		/* Contains parent bytenr and ref count */
 		case BTRFS_SHARED_DATA_REF_KEY:
 			sref = (struct btrfs_shared_data_ref *)(iref + 1);
-			if (!IS_ALIGNED(inline_offset, fs_info->sectorsize)) {
+			if (unlikely(!IS_ALIGNED(inline_offset,
+						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
 		"invalid data parent bytenr, have %llu expect aligned to %u",
 					   inline_offset, fs_info->sectorsize);
@@ -1365,14 +1378,14 @@ static int check_extent_item(struct extent_buffer *leaf,
 		ptr += btrfs_extent_inline_ref_size(inline_type);
 	}
 	/* No padding is allowed */
-	if (ptr != end) {
+	if (unlikely(ptr != end)) {
 		extent_err(leaf, slot,
 			   "invalid extent item size, padding bytes found");
 		return -EUCLEAN;
 	}
 
 	/* Finally, check the inline refs against total refs */
-	if (inline_refs > total_refs) {
+	if (unlikely(inline_refs > total_refs)) {
 		extent_err(leaf, slot,
 			"invalid extent refs, have %llu expect >= inline %llu",
 			   total_refs, inline_refs);
@@ -1389,21 +1402,21 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
 		expect_item_size = sizeof(struct btrfs_shared_data_ref);
 
-	if (btrfs_item_size_nr(leaf, slot) != expect_item_size) {
+	if (unlikely(btrfs_item_size_nr(leaf, slot) != expect_item_size)) {
 		generic_err(leaf, slot,
 		"invalid item size, have %u expect %u for key type %u",
 			    btrfs_item_size_nr(leaf, slot),
 			    expect_item_size, key->type);
 		return -EUCLEAN;
 	}
-	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for shared block ref, have %llu expect aligned to %u",
 			    key->objectid, leaf->fs_info->sectorsize);
 		return -EUCLEAN;
 	}
-	if (key->type != BTRFS_TREE_BLOCK_REF_KEY &&
-	    !IS_ALIGNED(key->offset, leaf->fs_info->sectorsize)) {
+	if (unlikely(key->type != BTRFS_TREE_BLOCK_REF_KEY &&
+		     !IS_ALIGNED(key->offset, leaf->fs_info->sectorsize))) {
 		extent_err(leaf, slot,
 		"invalid tree parent bytenr, have %llu expect aligned to %u",
 			   key->offset, leaf->fs_info->sectorsize);
@@ -1419,13 +1432,13 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 	unsigned long ptr = btrfs_item_ptr_offset(leaf, slot);
 	const unsigned long end = ptr + btrfs_item_size_nr(leaf, slot);
 
-	if (btrfs_item_size_nr(leaf, slot) % sizeof(*dref) != 0) {
+	if (unlikely(btrfs_item_size_nr(leaf, slot) % sizeof(*dref) != 0)) {
 		generic_err(leaf, slot,
 	"invalid item size, have %u expect aligned to %zu for key type %u",
 			    btrfs_item_size_nr(leaf, slot),
 			    sizeof(*dref), key->type);
 	}
-	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for shared block ref, have %llu expect aligned to %u",
 			    key->objectid, leaf->fs_info->sectorsize);
@@ -1442,13 +1455,13 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		owner = btrfs_extent_data_ref_objectid(leaf, dref);
 		offset = btrfs_extent_data_ref_offset(leaf, dref);
 		hash = hash_extent_data_ref(root_objectid, owner, offset);
-		if (hash != key->offset) {
+		if (unlikely(hash != key->offset)) {
 			extent_err(leaf, slot,
 	"invalid extent data ref hash, item has 0x%016llx key has 0x%016llx",
 				   hash, key->offset);
 			return -EUCLEAN;
 		}
-		if (!IS_ALIGNED(offset, leaf->fs_info->sectorsize)) {
+		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
 				   offset, leaf->fs_info->sectorsize);
@@ -1467,10 +1480,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	unsigned long ptr;
 	unsigned long end;
 
-	if (!check_prev_ino(leaf, key, slot, prev_key))
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
 		return -EUCLEAN;
 	/* namelen can't be 0, so item_size == sizeof() is also invalid */
-	if (btrfs_item_size_nr(leaf, slot) <= sizeof(*iref)) {
+	if (unlikely(btrfs_item_size_nr(leaf, slot) <= sizeof(*iref))) {
 		inode_ref_err(leaf, slot,
 			"invalid item size, have %u expect (%zu, %u)",
 			btrfs_item_size_nr(leaf, slot),
@@ -1483,7 +1496,7 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	while (ptr < end) {
 		u16 namelen;
 
-		if (ptr + sizeof(iref) > end) {
+		if (unlikely(ptr + sizeof(iref) > end)) {
 			inode_ref_err(leaf, slot,
 			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
 				ptr, end, sizeof(iref));
@@ -1492,7 +1505,7 @@ static int check_inode_ref(struct extent_buffer *leaf,
 
 		iref = (struct btrfs_inode_ref *)ptr;
 		namelen = btrfs_inode_ref_name_len(leaf, iref);
-		if (ptr + sizeof(*iref) + namelen > end) {
+		if (unlikely(ptr + sizeof(*iref) + namelen > end)) {
 			inode_ref_err(leaf, slot,
 				"inode ref overflow, ptr %lu end %lu namelen %u",
 				ptr, end, namelen);
@@ -1575,7 +1588,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
 
-	if (btrfs_header_level(leaf) != 0) {
+	if (unlikely(btrfs_header_level(leaf) != 0)) {
 		generic_err(leaf, 0,
 			"invalid level for leaf, have %d expect 0",
 			btrfs_header_level(leaf));
@@ -1594,19 +1607,19 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		u64 owner = btrfs_header_owner(leaf);
 
 		/* These trees must never be empty */
-		if (owner == BTRFS_ROOT_TREE_OBJECTID ||
-		    owner == BTRFS_CHUNK_TREE_OBJECTID ||
-		    owner == BTRFS_EXTENT_TREE_OBJECTID ||
-		    owner == BTRFS_DEV_TREE_OBJECTID ||
-		    owner == BTRFS_FS_TREE_OBJECTID ||
-		    owner == BTRFS_DATA_RELOC_TREE_OBJECTID) {
+		if (unlikely(owner == BTRFS_ROOT_TREE_OBJECTID ||
+			     owner == BTRFS_CHUNK_TREE_OBJECTID ||
+			     owner == BTRFS_EXTENT_TREE_OBJECTID ||
+			     owner == BTRFS_DEV_TREE_OBJECTID ||
+			     owner == BTRFS_FS_TREE_OBJECTID ||
+			     owner == BTRFS_DATA_RELOC_TREE_OBJECTID)) {
 			generic_err(leaf, 0,
 			"invalid root, root %llu must never be empty",
 				    owner);
 			return -EUCLEAN;
 		}
 		/* Unknown tree */
-		if (owner == 0) {
+		if (unlikely(owner == 0)) {
 			generic_err(leaf, 0,
 				"invalid owner, root 0 is not defined");
 			return -EUCLEAN;
@@ -1614,7 +1627,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		return 0;
 	}
 
-	if (nritems == 0)
+	if (unlikely(nritems == 0))
 		return 0;
 
 	/*
@@ -1635,7 +1648,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
 		/* Make sure the keys are in the right order */
-		if (btrfs_comp_cpu_keys(&prev_key, &key) >= 0) {
+		if (unlikely(btrfs_comp_cpu_keys(&prev_key, &key) >= 0)) {
 			generic_err(leaf, slot,
 	"bad key order, prev (%llu %u %llu) current (%llu %u %llu)",
 				prev_key.objectid, prev_key.type,
@@ -1654,7 +1667,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		else
 			item_end_expected = btrfs_item_offset_nr(leaf,
 								 slot - 1);
-		if (btrfs_item_end_nr(leaf, slot) != item_end_expected) {
+		if (unlikely(btrfs_item_end_nr(leaf, slot) != item_end_expected)) {
 			generic_err(leaf, slot,
 				"unexpected item end, have %u expect %u",
 				btrfs_item_end_nr(leaf, slot),
@@ -1667,8 +1680,8 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		 * just in case all the items are consistent to each other, but
 		 * all point outside of the leaf.
 		 */
-		if (btrfs_item_end_nr(leaf, slot) >
-		    BTRFS_LEAF_DATA_SIZE(fs_info)) {
+		if (unlikely(btrfs_item_end_nr(leaf, slot) >
+			     BTRFS_LEAF_DATA_SIZE(fs_info))) {
 			generic_err(leaf, slot,
 			"slot end outside of leaf, have %u expect range [0, %u]",
 				btrfs_item_end_nr(leaf, slot),
@@ -1677,8 +1690,8 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		}
 
 		/* Also check if the item pointer overlaps with btrfs item. */
-		if (btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item) >
-		    btrfs_item_ptr_offset(leaf, slot)) {
+		if (unlikely(btrfs_item_ptr_offset(leaf, slot) <
+			     btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item))) {
 			generic_err(leaf, slot,
 		"slot overlaps with its data, item end %lu data start %lu",
 				btrfs_item_nr_offset(slot) +
@@ -1693,7 +1706,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 			 * criteria
 			 */
 			ret = check_leaf_item(leaf, &key, slot, &prev_key);
-			if (ret < 0)
+			if (unlikely(ret < 0))
 				return ret;
 		}
 
@@ -1726,13 +1739,13 @@ int btrfs_check_node(struct extent_buffer *node)
 	u64 bytenr;
 	int ret = 0;
 
-	if (level <= 0 || level >= BTRFS_MAX_LEVEL) {
+	if (unlikely(level <= 0 || level >= BTRFS_MAX_LEVEL)) {
 		generic_err(node, 0,
 			"invalid level for node, have %d expect [1, %d]",
 			level, BTRFS_MAX_LEVEL - 1);
 		return -EUCLEAN;
 	}
-	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info)) {
+	if (unlikely(nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info))) {
 		btrfs_crit(fs_info,
 "corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%u]",
 			   btrfs_header_owner(node), node->start,
@@ -1746,13 +1759,13 @@ int btrfs_check_node(struct extent_buffer *node)
 		btrfs_node_key_to_cpu(node, &key, slot);
 		btrfs_node_key_to_cpu(node, &next_key, slot + 1);
 
-		if (!bytenr) {
+		if (unlikely(!bytenr)) {
 			generic_err(node, slot,
 				"invalid NULL node pointer");
 			ret = -EUCLEAN;
 			goto out;
 		}
-		if (!IS_ALIGNED(bytenr, fs_info->sectorsize)) {
+		if (unlikely(!IS_ALIGNED(bytenr, fs_info->sectorsize))) {
 			generic_err(node, slot,
 			"unaligned pointer, have %llu should be aligned to %u",
 				bytenr, fs_info->sectorsize);
@@ -1760,7 +1773,7 @@ int btrfs_check_node(struct extent_buffer *node)
 			goto out;
 		}
 
-		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
+		if (unlikely(btrfs_comp_cpu_keys(&key, &next_key) >= 0)) {
 			generic_err(node, slot,
 	"bad key order, current (%llu %u %llu) next (%llu %u %llu)",
 				key.objectid, key.type, key.offset,
-- 
2.25.0

