Return-Path: <linux-btrfs+bounces-15604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF9B0C968
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62205460B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B52E3B1A;
	Mon, 21 Jul 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F98wOOi9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C22E3B03
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118212; cv=none; b=RG7dchhtdx5wjmzcvbxEJEWwCGKmfHc9xEBRIVsYL9Dk7ANQlXRjvmWyHVXh9nndtlFkw0ooM1/ehzyGyeuf+YRHDCYQbdUTirT/fYcneIFY8qS81MSmTIYs1h3x4lFDOlMx90rXlkWLPEl0GWrypXN3x8zG0KVFxRYFgWG3eAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118212; c=relaxed/simple;
	bh=yZjqJmph0GosiZ3RezwXzRz/W05AoXPfyHHYRLh4jMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjI7C9R/Rlh+IdfealmmRRHICKkNBOGQoKmF495Inr34AajReWUrrz7K5S2uI0FFMaLnlCo+PDHtolndJogkn1V0hwzH1cr87mwqZi80+pd84y6BkA0vg1vYtWOeUXEGPoz7+tCP8ZbXMggjMzVbAuh0aPy3H/GhNBVAIlHHiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F98wOOi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC32C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118211;
	bh=yZjqJmph0GosiZ3RezwXzRz/W05AoXPfyHHYRLh4jMM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F98wOOi94u99jfanolzjZz3/P61zwSZ3NutCAhZLekLF53cUaq8teRzBS8MX9RwFa
	 Yj6NSMCcT0Yi/WxwNmBFI4cKt8GMXh/3k8XSNZk1Atl2UllmFF2fhysueSW9cDd3xN
	 Jn5qtrJDg1Xzg3rvDbRsk0fqWixmOwxfG7ypyLmLwXRr+Nn3AMeAgjNJVejvJ5zCOQ
	 U87BEy+yrF75eKHZx4MeNUle5b8Vmr5OX8cI+pg7+ckTaTeQLRjwYP+zY6Pgf2L00B
	 b8d/UWzveZu0r73veA9F1mo5VNw+FoYOynEl/16Oeo9wKCplt4EsCzv9iWTBeUBbHi
	 FkEybdt8S9SxA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs: process inline extent earlier in replay_one_extent()
Date: Mon, 21 Jul 2025 18:16:35 +0100
Message-ID: <257a42ef7e2e6435e929ef11c9ea04737616656e.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of having an if statement to check for regular and prealloc
extents first, process them in a block, and then following with an else
statement to check for an inline extent, check for an inline extent first,
process it and jump to the 'update_inode' label, allowing us to avoid
having the code for processing regular and prealloc extents inside a
block, reducing the high indentantion level by one and making the coder
easier to read and avoid line splittings too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 327 ++++++++++++++++++++++----------------------
 1 file changed, 163 insertions(+), 164 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 158959c8cc11..8817dfa5b353 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -653,6 +653,12 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_end;
 	u64 start = key->offset;
 	u64 nbytes = 0;
+	u64 csum_start;
+	u64 csum_end;
+	LIST_HEAD(ordered_sums);
+	u64 offset;
+	unsigned long dest_offset;
+	struct btrfs_key ins;
 	struct btrfs_file_extent_item *item;
 	struct btrfs_inode *inode = NULL;
 	unsigned long size;
@@ -730,187 +736,180 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (found_type == BTRFS_FILE_EXTENT_REG ||
-	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
-		u64 csum_start;
-		u64 csum_end;
-		LIST_HEAD(ordered_sums);
-		u64 offset;
-		unsigned long dest_offset;
-		struct btrfs_key ins;
+	if (found_type == BTRFS_FILE_EXTENT_INLINE) {
+		/* inline extents are easy, we just overwrite them */
+		ret = overwrite_item(trans, root, path, eb, slot, key);
+		if (ret)
+			goto out;
+		goto update_inode;
+	}
 
-		if (btrfs_file_extent_disk_bytenr(eb, item) == 0 &&
-		    btrfs_fs_incompat(fs_info, NO_HOLES))
-			goto update_inode;
+	/*
+	 * If not an inline extent, it can only be a regular or prealloc one.
+	 * We have checked that above and returned -EUCLEAN if not.
+	 */
 
-		ret = btrfs_insert_empty_item(trans, root, path, key,
-					      sizeof(*item));
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
-		dest_offset = btrfs_item_ptr_offset(path->nodes[0],
-						    path->slots[0]);
-		copy_extent_buffer(path->nodes[0], eb, dest_offset,
-				(unsigned long)item,  sizeof(*item));
+	/* A hole and NO_HOLES feature enabled, nothing else to do. */
+	if (btrfs_file_extent_disk_bytenr(eb, item) == 0 &&
+	    btrfs_fs_incompat(fs_info, NO_HOLES))
+		goto update_inode;
 
-		/*
-		 * We have an explicit hole and NO_HOLES is not enabled. We have
-		 * added the hole file extent item to the subvolume tree, so we
-		 * don't have anything else to do other than update the file
-		 * extent item range and update the inode item.
-		 */
-		if (btrfs_file_extent_disk_bytenr(eb, item) == 0) {
-			btrfs_release_path(path);
-			goto update_inode;
-		}
+	ret = btrfs_insert_empty_item(trans, root, path, key, sizeof(*item));
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+	dest_offset = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
+	copy_extent_buffer(path->nodes[0], eb, dest_offset, (unsigned long)item,
+			   sizeof(*item));
 
-		ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
-		ins.type = BTRFS_EXTENT_ITEM_KEY;
-		ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
-		offset = key->offset - btrfs_file_extent_offset(eb, item);
+	/*
+	 * We have an explicit hole and NO_HOLES is not enabled. We have added
+	 * the hole file extent item to the subvolume tree, so we don't have
+	 * anything else to do other than update the file extent item range and
+	 * update the inode item.
+	 */
+	if (btrfs_file_extent_disk_bytenr(eb, item) == 0) {
+		btrfs_release_path(path);
+		goto update_inode;
+	}
 
-		/*
-		 * Manually record dirty extent, as here we did a shallow
-		 * file extent item copy and skip normal backref update,
-		 * but modifying extent tree all by ourselves.
-		 * So need to manually record dirty extent for qgroup,
-		 * as the owner of the file extent changed from log tree
-		 * (doesn't affect qgroup) to fs/file tree(affects qgroup)
-		 */
-		ret = btrfs_qgroup_trace_extent(trans,
-				btrfs_file_extent_disk_bytenr(eb, item),
-				btrfs_file_extent_disk_num_bytes(eb, item));
-		if (ret < 0) {
+	ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
+	ins.type = BTRFS_EXTENT_ITEM_KEY;
+	ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
+	offset = key->offset - btrfs_file_extent_offset(eb, item);
+
+	/*
+	 * Manually record dirty extent, as here we did a shallow file extent
+	 * item copy and skip normal backref update, but modifying extent tree
+	 * all by ourselves. So need to manually record dirty extent for qgroup,
+	 * as the owner of the file extent changed from log tree (doesn't affect
+	 * qgroup) to fs/file tree (affects qgroup).
+	 */
+	ret = btrfs_qgroup_trace_extent(trans,
+					btrfs_file_extent_disk_bytenr(eb, item),
+					btrfs_file_extent_disk_num_bytes(eb, item));
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
+	/*
+	 * Is this extent already allocated in the extent tree?
+	 * If so, just add a reference.
+	 */
+	ret = btrfs_lookup_data_extent(fs_info, ins.objectid, ins.offset);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	} else if (ret == 0) {
+		struct btrfs_ref ref = {
+			.action = BTRFS_ADD_DELAYED_REF,
+			.bytenr = ins.objectid,
+			.num_bytes = ins.offset,
+			.owning_root = btrfs_root_id(root),
+			.ref_root = btrfs_root_id(root),
+		};
+
+		btrfs_init_data_ref(&ref, key->objectid, offset, 0, false);
+		ret = btrfs_inc_extent_ref(trans, &ref);
+		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
-
-		/*
-		 * Is this extent already allocated in the extent tree?
-		 * If so, just add a reference.
-		 */
-		ret = btrfs_lookup_data_extent(fs_info, ins.objectid, ins.offset);
-		if (ret < 0) {
+	} else {
+		/* Insert the extent pointer in the extent tree. */
+		ret = btrfs_alloc_logged_file_extent(trans, btrfs_root_id(root),
+						     key->objectid, offset, &ins);
+		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
-		} else if (ret == 0) {
-			struct btrfs_ref ref = {
-				.action = BTRFS_ADD_DELAYED_REF,
-				.bytenr = ins.objectid,
-				.num_bytes = ins.offset,
-				.owning_root = btrfs_root_id(root),
-				.ref_root = btrfs_root_id(root),
-			};
-
-			btrfs_init_data_ref(&ref, key->objectid, offset, 0, false);
-			ret = btrfs_inc_extent_ref(trans, &ref);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				goto out;
-			}
-		} else {
-			/* Insert the extent pointer in the extent tree. */
-			ret = btrfs_alloc_logged_file_extent(trans, btrfs_root_id(root),
-							     key->objectid, offset, &ins);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				goto out;
-			}
 		}
+	}
 
-		btrfs_release_path(path);
+	btrfs_release_path(path);
 
-		if (btrfs_file_extent_compression(eb, item)) {
-			csum_start = ins.objectid;
-			csum_end = csum_start + ins.offset;
-		} else {
-			csum_start = ins.objectid + btrfs_file_extent_offset(eb, item);
-			csum_end = csum_start + btrfs_file_extent_num_bytes(eb, item);
-		}
+	if (btrfs_file_extent_compression(eb, item)) {
+		csum_start = ins.objectid;
+		csum_end = csum_start + ins.offset;
+	} else {
+		csum_start = ins.objectid + btrfs_file_extent_offset(eb, item);
+		csum_end = csum_start + btrfs_file_extent_num_bytes(eb, item);
+	}
 
-		ret = btrfs_lookup_csums_list(root->log_root, csum_start, csum_end - 1,
-					      &ordered_sums, false);
-		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
-		ret = 0;
-		/*
-		 * Now delete all existing cums in the csum root that cover our
-		 * range. We do this because we can have an extent that is
-		 * completely referenced by one file extent item and partially
-		 * referenced by another file extent item (like after using the
-		 * clone or extent_same ioctls). In this case if we end up doing
-		 * the replay of the one that partially references the extent
-		 * first, and we do not do the csum deletion below, we can get 2
-		 * csum items in the csum tree that overlap each other. For
-		 * example, imagine our log has the two following file extent items:
-		 *
-		 * key (257 EXTENT_DATA 409600)
-		 *     extent data disk byte 12845056 nr 102400
-		 *     extent data offset 20480 nr 20480 ram 102400
-		 *
-		 * key (257 EXTENT_DATA 819200)
-		 *     extent data disk byte 12845056 nr 102400
-		 *     extent data offset 0 nr 102400 ram 102400
-		 *
-		 * Where the second one fully references the 100K extent that
-		 * starts at disk byte 12845056, and the log tree has a single
-		 * csum item that covers the entire range of the extent:
-		 *
-		 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
-		 *
-		 * After the first file extent item is replayed, the csum tree
-		 * gets the following csum item:
-		 *
-		 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
-		 *
-		 * Which covers the 20K sub-range starting at offset 20K of our
-		 * extent. Now when we replay the second file extent item, if we
-		 * do not delete existing csum items that cover any of its
-		 * blocks, we end up getting two csum items in our csum tree
-		 * that overlap each other:
-		 *
-		 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
-		 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
-		 *
-		 * Which is a problem, because after this anyone trying to
-		 * lookup up for the checksum of any block of our extent
-		 * starting at an offset of 40K or higher, will end up looking
-		 * at the second csum item only, which does not contain the
-		 * checksum for any block starting at offset 40K or higher of
-		 * our extent.
-		 */
-		while (!list_empty(&ordered_sums)) {
-			struct btrfs_ordered_sum *sums;
-			struct btrfs_root *csum_root;
+	ret = btrfs_lookup_csums_list(root->log_root, csum_start, csum_end - 1,
+				      &ordered_sums, false);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+	ret = 0;
+	/*
+	 * Now delete all existing cums in the csum root that cover our range.
+	 * We do this because we can have an extent that is completely
+	 * referenced by one file extent item and partially referenced by
+	 * another file extent item (like after using the clone or extent_same
+	 * ioctls). In this case if we end up doing the replay of the one that
+	 * partially references the extent first, and we do not do the csum
+	 * deletion below, we can get 2 csum items in the csum tree that overlap
+	 * each other. For example, imagine our log has the two following file
+	 * extent items:
+	 *
+	 * key (257 EXTENT_DATA 409600)
+	 *     extent data disk byte 12845056 nr 102400
+	 *     extent data offset 20480 nr 20480 ram 102400
+	 *
+	 * key (257 EXTENT_DATA 819200)
+	 *     extent data disk byte 12845056 nr 102400
+	 *     extent data offset 0 nr 102400 ram 102400
+	 *
+	 * Where the second one fully references the 100K extent that starts at
+	 * disk byte 12845056, and the log tree has a single csum item that
+	 * covers the entire range of the extent:
+	 *
+	 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
+	 *
+	 * After the first file extent item is replayed, the csum tree gets the
+	 * following csum item:
+	 *
+	 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
+	 *
+	 * Which covers the 20K sub-range starting at offset 20K of our extent.
+	 * Now when we replay the second file extent item, if we do not delete
+	 * existing csum items that cover any of its blocks, we end up getting
+	 * two csum items in our csum tree that overlap each other:
+	 *
+	 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
+	 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
+	 *
+	 * Which is a problem, because after this anyone trying to lookup for
+	 * the checksum of any block of our extent starting at an offset of 40K
+	 * or higher, will end up looking at the second csum item only, which
+	 * does not contain the checksum for any block starting at offset 40K or
+	 * higher of our extent.
+	 */
+	while (!list_empty(&ordered_sums)) {
+		struct btrfs_ordered_sum *sums;
+		struct btrfs_root *csum_root;
 
-			sums = list_first_entry(&ordered_sums,
-						struct btrfs_ordered_sum, list);
-			csum_root = btrfs_csum_root(fs_info, sums->logical);
-			if (!ret) {
-				ret = btrfs_del_csums(trans, csum_root, sums->logical,
-						      sums->len);
-				if (ret)
-					btrfs_abort_transaction(trans, ret);
-			}
-			if (!ret) {
-				ret = btrfs_csum_file_blocks(trans, csum_root, sums);
-				if (ret)
-					btrfs_abort_transaction(trans, ret);
-			}
-			list_del(&sums->list);
-			kfree(sums);
+		sums = list_first_entry(&ordered_sums, struct btrfs_ordered_sum, list);
+		csum_root = btrfs_csum_root(fs_info, sums->logical);
+		if (!ret) {
+			ret = btrfs_del_csums(trans, csum_root, sums->logical,
+					      sums->len);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
-		if (ret)
-			goto out;
-	} else if (found_type == BTRFS_FILE_EXTENT_INLINE) {
-		/* inline extents are easy, we just overwrite them */
-		ret = overwrite_item(trans, root, path, eb, slot, key);
-		if (ret)
-			goto out;
+		if (!ret) {
+			ret = btrfs_csum_file_blocks(trans, csum_root, sums);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
+		list_del(&sums->list);
+		kfree(sums);
 	}
+	if (ret)
+		goto out;
 
 update_inode:
 	ret = btrfs_inode_set_file_extent_range(inode, start, extent_end - start);
-- 
2.47.2


