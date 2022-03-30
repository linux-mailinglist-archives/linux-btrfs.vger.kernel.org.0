Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784064EC696
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbiC3OdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbiC3OdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:33:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906A3615F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54CBDB81C27
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CFC3410F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648650671;
        bh=cVwItAz/vinq9yQM8/aUgGyDT4eKCJr1P4yRXaXYoiY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n16kB3IDvIRih+TRzvtP8dn4xZH+SpAqHo5BaFJyzbHlFeYPPh1xPF8hisqiThB6U
         rHDVEXNPrkFm4pT084ezgc33hlXZdQWfRRFc1jEMb/+jFugKur9vosDcD9H2LICLep
         lwBnu+JNztPWh1xUxk1/9869E1Khfurf9164d3cway4YfV0ji98fuUCYhNPc+aYjYL
         rUp+aOInjavHCsUXFGNryhxQBdC6sPKejWJ+E1HrK60iJPTvadmtX0YCHgjn/EHKXD
         40uu86r0+cgUubZHbNoOgmao9suZiDPHPQH0cIFp/8txAz/STgogDOR6M8i0RZHDg1
         Oa9LyRP8qQBSg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: move common NOCOW checks against a file extent into a helper
Date:   Wed, 30 Mar 2022 15:31:06 +0100
Message-Id: <25886299db7b0248a0b67de5457794397f250f78.1648650280.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648650280.git.fdmanana@suse.com>
References: <cover.1648650280.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Verifying if we can do a NOCOW write against a range fully or partially
covered by a file extent item requires verifying several constraints, and
these are currently duplicated at two different places: can_nocow_extent()
and run_delalloc_nocow().

This change moves those checks into a common helper function to avoid
duplication. It adds some comments and also preserves all existing
behaviour like for example can_nocow_extent() treating errors from the
calls to btrfs_cross_ref_exist() and csum_exist_in_range() as meaning
we can not NOCOW, instead of propagating the error back to the caller.
That specific behaviour is questionable but also reasonable to some
degree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 428 ++++++++++++++++++++++++-----------------------
 1 file changed, 216 insertions(+), 212 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index faf76da2526f..ae63e6a85cac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1629,6 +1629,142 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 			      nr_written, 1);
 }
 
+struct can_nocow_file_extent_args {
+	/* Input fields. */
+
+	/* Start file offset of the range we want to NOCOW. */
+	u64 start;
+	/* End file offset (inclusive) of the range we want to NOCOW. */
+	u64 end;
+	bool writeback_path;
+	bool strict;
+	/*
+	 * Free the path passed to can_nocow_file_extent() once it's not needed
+	 * anymore.
+	 */
+	bool free_path;
+
+	/* Output fields. Only set when can_nocow_file_extent() returns 1. */
+
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+	u64 extent_offset;
+	/* Number of bytes that can be written to in NOCOW mode. */
+	u64 num_bytes;
+};
+
+/*
+ * Check if we can NOCOW the file extent that the path points to.
+ * This function may return with the path released, so the caller should check
+ * if path->nodes[0] is NULL or not if it needs to use the path afterwards.
+ *
+ * Returns: < 0 on error
+ *          0 if we can not NOCOW
+ *          1 if we can NOCOW
+ */
+static int can_nocow_file_extent(struct btrfs_path *path,
+				 struct btrfs_key *key,
+				 struct btrfs_inode *inode,
+				 struct can_nocow_file_extent_args *args)
+{
+	const bool is_freespace_inode = btrfs_is_free_space_inode(inode);
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_root *root = inode->root;
+	struct btrfs_file_extent_item *fi;
+	u64 extent_end;
+	u8 extent_type;
+	int can_nocow = 0;
+	int ret = 0;
+
+	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+	extent_type = btrfs_file_extent_type(leaf, fi);
+
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
+		goto out;
+
+	/* Can't access these fields unless we know it's not an inline extent. */
+	args->disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+	args->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
+	args->extent_offset = btrfs_file_extent_offset(leaf, fi);
+
+	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
+	    extent_type == BTRFS_FILE_EXTENT_REG)
+		goto out;
+
+	/*
+	 * If the extent was created before the generation where the last snapshot
+	 * for its subvolume was created, then this implies the extent is shared,
+	 * hence we must COW.
+	 */
+	if (!args->strict && !is_freespace_inode &&
+	    btrfs_file_extent_generation(leaf, fi) <=
+	    btrfs_root_last_snapshot(&root->root_item))
+		goto out;
+
+	/* An explicit hole, must COW. */
+	if (args->disk_bytenr == 0)
+		goto out;
+
+	/* Compressed/encrypted/encoded extents must be COWed. */
+	if (btrfs_file_extent_compression(leaf, fi) ||
+	    btrfs_file_extent_encryption(leaf, fi) ||
+	    btrfs_file_extent_other_encoding(leaf, fi))
+		goto out;
+
+	extent_end = btrfs_file_extent_end(path);
+
+	/*
+	 * The following checks can be expensive, as they need to take other
+	 * locks and do btree or rbtree searches, so release the path to avoid
+	 * blocking other tasks for too long.
+	 */
+	btrfs_release_path(path);
+
+	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
+				    key->offset - args->extent_offset,
+				    args->disk_bytenr, false, path);
+	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
+	if (ret != 0)
+		goto out;
+
+	if (args->free_path) {
+		/*
+		 * We don't need the path anymore, plus through the
+		 * csum_exist_in_range() call below we will end up allocating
+		 * another path. So free the path to avoid unnecessary extra
+		 * memory usage.
+		 */
+		btrfs_free_path(path);
+		path = NULL;
+	}
+
+	/* If there are pending snapshots for this root, we must COW. */
+	if (args->writeback_path && !is_freespace_inode &&
+	    atomic_read(&root->snapshot_force_cow))
+		goto out;
+
+	args->disk_bytenr += args->extent_offset;
+	args->disk_bytenr += args->start - key->offset;
+	args->num_bytes = min(args->end + 1, extent_end) - args->start;
+
+	/*
+	 * Force cow if csums exist in the range. This ensures that csums for a
+	 * given extent are either valid or do not exist.
+	 */
+	ret = csum_exist_in_range(root->fs_info, args->disk_bytenr,
+				  args->num_bytes);
+	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
+	if (ret != 0)
+		goto out;
+
+	can_nocow = 1;
+ out:
+	if (args->free_path && path)
+		btrfs_free_path(path);
+
+	return ret < 0 ? ret : can_nocow;
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -1649,11 +1785,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	u64 cur_offset = start;
 	int ret;
 	bool check_prev = true;
-	const bool freespace_inode = btrfs_is_free_space_inode(inode);
 	u64 ino = btrfs_ino(inode);
 	bool nocow = false;
-	u64 disk_bytenr = 0;
-	const bool force = inode->flags & BTRFS_INODE_NODATACOW;
+	struct can_nocow_file_extent_args nocow_args = { 0 };
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -1666,15 +1800,16 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		return -ENOMEM;
 	}
 
+	nocow_args.end = end;
+	nocow_args.writeback_path = true;
+
 	while (1) {
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
 		u64 extent_end;
-		u64 extent_offset;
-		u64 num_bytes = 0;
-		u64 disk_num_bytes;
 		u64 ram_bytes;
+		u64 nocow_end;
 		int extent_type;
 
 		nocow = false;
@@ -1750,117 +1885,37 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		fi = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_file_extent_item);
 		extent_type = btrfs_file_extent_type(leaf, fi);
-
+		/* If this is triggered then we have a memory corruption. */
+		ASSERT(extent_type < BTRFS_NR_FILE_EXTENT_TYPES);
+		if (WARN_ON(extent_type >= BTRFS_NR_FILE_EXTENT_TYPES)) {
+			ret = -EUCLEAN;
+			goto error;
+		}
 		ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
-		if (extent_type == BTRFS_FILE_EXTENT_REG ||
-		    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
-			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-			extent_offset = btrfs_file_extent_offset(leaf, fi);
-			extent_end = found_key.offset +
-				btrfs_file_extent_num_bytes(leaf, fi);
-			disk_num_bytes =
-				btrfs_file_extent_disk_num_bytes(leaf, fi);
-			/*
-			 * If the extent we got ends before our current offset,
-			 * skip to the next extent.
-			 */
-			if (extent_end <= cur_offset) {
-				path->slots[0]++;
-				goto next_slot;
-			}
-			/* Skip holes */
-			if (disk_bytenr == 0)
-				goto out_check;
-			/* Skip compressed/encrypted/encoded extents */
-			if (btrfs_file_extent_compression(leaf, fi) ||
-			    btrfs_file_extent_encryption(leaf, fi) ||
-			    btrfs_file_extent_other_encoding(leaf, fi))
-				goto out_check;
-			/*
-			 * If extent is created before the last volume's snapshot
-			 * this implies the extent is shared, hence we can't do
-			 * nocow. This is the same check as in
-			 * btrfs_cross_ref_exist but without calling
-			 * btrfs_search_slot.
-			 */
-			if (!freespace_inode &&
-			    btrfs_file_extent_generation(leaf, fi) <=
-			    btrfs_root_last_snapshot(&root->root_item))
-				goto out_check;
-			if (extent_type == BTRFS_FILE_EXTENT_REG && !force)
-				goto out_check;
+		extent_end = btrfs_file_extent_end(path);
 
-			/*
-			 * The following checks can be expensive, as they need to
-			 * take other locks and do btree or rbtree searches, so
-			 * release the path to avoid blocking other tasks for too
-			 * long.
-			 */
-			btrfs_release_path(path);
+		/*
+		 * If the extent we got ends before our current offset, skip to
+		 * the next extent.
+		 */
+		if (extent_end <= cur_offset) {
+			path->slots[0]++;
+			goto next_slot;
+		}
 
-			ret = btrfs_cross_ref_exist(root, ino,
-						    found_key.offset -
-						    extent_offset, disk_bytenr,
-						    false, path);
-			if (ret) {
-				/*
-				 * ret could be -EIO if the above fails to read
-				 * metadata.
-				 */
-				if (ret < 0) {
-					if (cow_start != (u64)-1)
-						cur_offset = cow_start;
-					goto error;
-				}
+		nocow_args.start = cur_offset;
+		ret = can_nocow_file_extent(path, &found_key, inode, &nocow_args);
+		if (ret < 0) {
+			if (cow_start != (u64)-1)
+				cur_offset = cow_start;
+			goto error;
+		} else if (ret == 0) {
+			goto out_check;
+		}
 
-				WARN_ON_ONCE(freespace_inode);
-				goto out_check;
-			}
-			disk_bytenr += extent_offset;
-			disk_bytenr += cur_offset - found_key.offset;
-			num_bytes = min(end + 1, extent_end) - cur_offset;
-			/*
-			 * If there are pending snapshots for this root, we
-			 * fall into common COW way
-			 */
-			if (!freespace_inode && atomic_read(&root->snapshot_force_cow))
-				goto out_check;
-			/*
-			 * force cow if csum exists in the range.
-			 * this ensure that csum for a given extent are
-			 * either valid or do not exist.
-			 */
-			ret = csum_exist_in_range(fs_info, disk_bytenr,
-						  num_bytes);
-			if (ret) {
-				/*
-				 * ret could be -EIO if the above fails to read
-				 * metadata.
-				 */
-				if (ret < 0) {
-					if (cow_start != (u64)-1)
-						cur_offset = cow_start;
-					goto error;
-				}
-				WARN_ON_ONCE(freespace_inode);
-				goto out_check;
-			}
-			/* If the extent's block group is RO, we must COW */
-			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
-				goto out_check;
+		ret = 0;
+		if (btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr))
 			nocow = true;
-		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-			extent_end = found_key.offset + ram_bytes;
-			extent_end = ALIGN(extent_end, fs_info->sectorsize);
-			/* Skip extents outside of our requested range */
-			if (extent_end <= start) {
-				path->slots[0]++;
-				goto next_slot;
-			}
-		} else {
-			/* If this triggers then we have a memory corruption */
-			BUG();
-		}
 out_check:
 		/*
 		 * If nocow is false then record the beginning of the range
@@ -1892,15 +1947,17 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			cow_start = (u64)-1;
 		}
 
+		nocow_end = cur_offset + nocow_args.num_bytes - 1;
+
 		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
-			u64 orig_start = found_key.offset - extent_offset;
+			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset, num_bytes,
+			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
 					  orig_start,
-					  disk_bytenr, /* block_start */
-					  num_bytes, /* block_len */
-					  disk_num_bytes, /* orig_block_len */
+					  nocow_args.disk_bytenr, /* block_start */
+					  nocow_args.num_bytes, /* block_len */
+					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
@@ -1909,20 +1966,23 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 			free_extent_map(em);
 			ret = btrfs_add_ordered_extent(inode,
-					cur_offset, num_bytes, num_bytes,
-					disk_bytenr, num_bytes, 0,
+					cur_offset, nocow_args.num_bytes,
+					nocow_args.num_bytes,
+					nocow_args.disk_bytenr,
+					nocow_args.num_bytes, 0,
 					1 << BTRFS_ORDERED_PREALLOC,
 					BTRFS_COMPRESS_NONE);
 			if (ret) {
 				btrfs_drop_extent_cache(inode, cur_offset,
-							cur_offset + num_bytes - 1,
-							0);
+							nocow_end, 0);
 				goto error;
 			}
 		} else {
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
-						       num_bytes, num_bytes,
-						       disk_bytenr, num_bytes,
+						       nocow_args.num_bytes,
+						       nocow_args.num_bytes,
+						       nocow_args.disk_bytenr,
+						       nocow_args.num_bytes,
 						       0,
 						       1 << BTRFS_ORDERED_NOCOW,
 						       BTRFS_COMPRESS_NONE);
@@ -1931,7 +1991,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		if (nocow)
-			btrfs_dec_nocow_writers(fs_info, disk_bytenr);
+			btrfs_dec_nocow_writers(fs_info, nocow_args.disk_bytenr);
 		nocow = false;
 
 		if (btrfs_is_data_reloc_root(root))
@@ -1941,10 +2001,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			 * from freeing metadata of created ordered extent.
 			 */
 			ret = btrfs_reloc_clone_csums(inode, cur_offset,
-						      num_bytes);
+						      nocow_args.num_bytes);
 
-		extent_clear_unlock_delalloc(inode, cur_offset,
-					     cur_offset + num_bytes - 1,
+		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
@@ -1977,7 +2036,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 error:
 	if (nocow)
-		btrfs_dec_nocow_writers(fs_info, disk_bytenr);
+		btrfs_dec_nocow_writers(fs_info, nocow_args.disk_bytenr);
 
 	if (ret && cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
@@ -7114,6 +7173,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *ram_bytes, bool strict)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct can_nocow_file_extent_args nocow_args = { 0 };
 	struct btrfs_path *path;
 	int ret;
 	struct extent_buffer *leaf;
@@ -7121,13 +7181,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
-	u64 disk_bytenr;
-	u64 backref_offset;
-	u64 extent_end;
-	u64 num_bytes;
-	int slot;
 	int found_type;
-	bool nocow = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -7138,18 +7192,17 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	if (ret < 0)
 		goto out;
 
-	slot = path->slots[0];
 	if (ret == 1) {
-		if (slot == 0) {
+		if (path->slots[0] == 0) {
 			/* can't find the item, must cow */
 			ret = 0;
 			goto out;
 		}
-		slot--;
+		path->slots[0]--;
 	}
 	ret = 0;
 	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &key, slot);
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	if (key.objectid != btrfs_ino(BTRFS_I(inode)) ||
 	    key.type != BTRFS_EXTENT_DATA_KEY) {
 		/* not our file or wrong item type, must cow */
@@ -7161,57 +7214,38 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		goto out;
 	}
 
-	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
-	found_type = btrfs_file_extent_type(leaf, fi);
-	if (found_type != BTRFS_FILE_EXTENT_REG &&
-	    found_type != BTRFS_FILE_EXTENT_PREALLOC) {
-		/* not a regular extent, must cow */
-		goto out;
-	}
-
-	if (!nocow && found_type == BTRFS_FILE_EXTENT_REG)
+	if (btrfs_file_extent_end(path) <= offset)
 		goto out;
 
-	extent_end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
-	if (extent_end <= offset)
-		goto out;
+	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+	found_type = btrfs_file_extent_type(leaf, fi);
+	if (ram_bytes)
+		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 
-	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	if (disk_bytenr == 0)
-		goto out;
+	nocow_args.start = offset;
+	nocow_args.end = offset + *len - 1;
+	nocow_args.strict = strict;
+	nocow_args.free_path = true;
 
-	if (btrfs_file_extent_compression(leaf, fi) ||
-	    btrfs_file_extent_encryption(leaf, fi) ||
-	    btrfs_file_extent_other_encoding(leaf, fi))
-		goto out;
+	ret = can_nocow_file_extent(path, &key, BTRFS_I(inode), &nocow_args);
+	/* can_nocow_file_extent() has freed the path. */
+	path = NULL;
 
-	/*
-	 * Do the same check as in btrfs_cross_ref_exist but without the
-	 * unnecessary search.
-	 */
-	if (!strict &&
-	    (btrfs_file_extent_generation(leaf, fi) <=
-	     btrfs_root_last_snapshot(&root->root_item)))
+	if (ret != 1) {
+		/* Treat errors as not being able to NOCOW. */
+		ret = 0;
 		goto out;
-
-	backref_offset = btrfs_file_extent_offset(leaf, fi);
-
-	if (orig_start) {
-		*orig_start = key.offset - backref_offset;
-		*orig_block_len = btrfs_file_extent_disk_num_bytes(leaf, fi);
-		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	}
 
-	btrfs_release_path(path);
-
-	if (btrfs_extent_readonly(fs_info, disk_bytenr))
+	ret = 0;
+	if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
 		goto out;
 
-	num_bytes = min(offset + *len, extent_end) - offset;
-	if (!nocow && found_type == BTRFS_FILE_EXTENT_PREALLOC) {
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
+	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		u64 range_end;
 
-		range_end = round_up(offset + num_bytes,
+		range_end = round_up(offset + nocow_args.num_bytes,
 				     root->fs_info->sectorsize) - 1;
 		ret = test_range_bit(io_tree, offset, range_end,
 				     EXTENT_DELALLOC, 0, NULL);
@@ -7221,42 +7255,12 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	/*
-	 * look for other files referencing this extent, if we
-	 * find any we must cow
-	 */
+	if (orig_start)
+		*orig_start = key.offset - nocow_args.extent_offset;
+	if (orig_block_len)
+		*orig_block_len = nocow_args.disk_num_bytes;
 
-	ret = btrfs_cross_ref_exist(root, btrfs_ino(BTRFS_I(inode)),
-				    key.offset - backref_offset, disk_bytenr,
-				    strict, path);
-	if (ret) {
-		ret = 0;
-		goto out;
-	}
-
-	/*
-	 * We don't need the path anymore, plus through the csum_exist_in_range()
-	 * call below we will end up allocating another path. So free the path
-	 * to avoid unnecessary extra memory usage.
-	 */
-	btrfs_free_path(path);
-	path = NULL;
-
-	/*
-	 * adjust disk_bytenr and num_bytes to cover just the bytes
-	 * in this extent we are about to write.  If there
-	 * are any csums in that range we have to cow in order
-	 * to keep the csums correct
-	 */
-	disk_bytenr += backref_offset;
-	disk_bytenr += offset - key.offset;
-	if (csum_exist_in_range(fs_info, disk_bytenr, num_bytes))
-		goto out;
-	/*
-	 * all of the above have passed, it is safe to overwrite this extent
-	 * without cow
-	 */
-	*len = num_bytes;
+	*len = nocow_args.num_bytes;
 	ret = 1;
 out:
 	btrfs_free_path(path);
-- 
2.33.0

