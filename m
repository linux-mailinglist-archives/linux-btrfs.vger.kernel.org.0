Return-Path: <linux-btrfs+bounces-15603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE53B0C973
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54663A86C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA22E3AF9;
	Mon, 21 Jul 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etikyThW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B012E3AE7
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118211; cv=none; b=TbZ7BlLFpk2ElA81YIW1Y8+bZkrq0g08mnWNk3x2meYWbHekfIQLl5MtDfG43QbGhl3LToWImo5dgVszeHBgW9yLIfuSDnlt1KOa4NYMokmLzEjmadfihXdJCYSNAya7lGH+pUtOSxYs/mtkFygHvXMjaGCd3Wxnea0cxMAvPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118211; c=relaxed/simple;
	bh=+q7z1TMJkqCWV7jgMgSWgawWIDsntYS930JSvplF7Ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqqir2PQTbVA87QuqQK7AA++I18BvVjfGhXHsuXeQNAwiXNPGCCy2AnP499yhfXSmsfArbfiYZNYJZtukU8VwRECLmm1AwCahq/0KCz8kuwvscmT96SCEuctQFrHTaNfG+wK7EC3XlXdEXWXROaBfEP5RZT60AuxpoWUEs5puwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etikyThW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AF2C4CEED
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118210;
	bh=+q7z1TMJkqCWV7jgMgSWgawWIDsntYS930JSvplF7Ko=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=etikyThWEM/avb5aCAi+8FSLFS1I1m326k9/h6LO9TMq7rxl1aEvrZrJXaFuLmnm7
	 Hlpeyyy4AP5oY7iyXCnpIIjX1i4pTA6Eudwj33SZLFJlTpKHFR8qVG04iTJhICvTTS
	 5P4dZXs7YtTynLjXap5lzXorn0rvnbU/C9pZA/cqOOz50XhpP/sosudQFtYcYoZH6d
	 Gf1mFeIsIQY7pRjVZSuxQqplZ5wJTqS8JAts9CevCkI/X38JAnc3nllW5lXw0wxjaN
	 lQjilcwaZx+wIjbugPONlxTp0/RdY96MMAozE6eUMu2+EQfrI1S2MDtifHENToDbvj
	 3ynKuz+TKGkjA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: exit early when replaying hole file extent item from a log tree
Date: Mon, 21 Jul 2025 18:16:34 +0100
Message-ID: <e6c6a5699aa2ea6bc5b10a47e434fa5ac3c23a8d.1753117707.git.fdmanana@suse.com>
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

At replay_one_extent(), we can jump to the code that updates the file
extent range and updates the inode when processing a file extent item that
represents a hole and we don't have the NO_HOLES feature enabled. This
helps reduce the high indentation level by one in replay_one_extent() and
avoid splitting some lines to make the code easier to read.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 261 +++++++++++++++++++++-----------------------
 1 file changed, 126 insertions(+), 135 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 17af4ff51479..158959c8cc11 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -732,6 +732,9 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
+		u64 csum_start;
+		u64 csum_end;
+		LIST_HEAD(ordered_sums);
 		u64 offset;
 		unsigned long dest_offset;
 		struct btrfs_key ins;
@@ -751,6 +754,17 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		copy_extent_buffer(path->nodes[0], eb, dest_offset,
 				(unsigned long)item,  sizeof(*item));
 
+		/*
+		 * We have an explicit hole and NO_HOLES is not enabled. We have
+		 * added the hole file extent item to the subvolume tree, so we
+		 * don't have anything else to do other than update the file
+		 * extent item range and update the inode item.
+		 */
+		if (btrfs_file_extent_disk_bytenr(eb, item) == 0) {
+			btrfs_release_path(path);
+			goto update_inode;
+		}
+
 		ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
 		ins.type = BTRFS_EXTENT_ITEM_KEY;
 		ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
@@ -772,148 +786,125 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		if (ins.objectid > 0) {
-			u64 csum_start;
-			u64 csum_end;
-			LIST_HEAD(ordered_sums);
-
-			/*
-			 * is this extent already allocated in the extent
-			 * allocation tree?  If so, just add a reference
-			 */
-			ret = btrfs_lookup_data_extent(fs_info, ins.objectid,
-						ins.offset);
-			if (ret < 0) {
+		/*
+		 * Is this extent already allocated in the extent tree?
+		 * If so, just add a reference.
+		 */
+		ret = btrfs_lookup_data_extent(fs_info, ins.objectid, ins.offset);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		} else if (ret == 0) {
+			struct btrfs_ref ref = {
+				.action = BTRFS_ADD_DELAYED_REF,
+				.bytenr = ins.objectid,
+				.num_bytes = ins.offset,
+				.owning_root = btrfs_root_id(root),
+				.ref_root = btrfs_root_id(root),
+			};
+
+			btrfs_init_data_ref(&ref, key->objectid, offset, 0, false);
+			ret = btrfs_inc_extent_ref(trans, &ref);
+			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
-			} else if (ret == 0) {
-				struct btrfs_ref ref = {
-					.action = BTRFS_ADD_DELAYED_REF,
-					.bytenr = ins.objectid,
-					.num_bytes = ins.offset,
-					.owning_root = btrfs_root_id(root),
-					.ref_root = btrfs_root_id(root),
-				};
-				btrfs_init_data_ref(&ref, key->objectid, offset,
-						    0, false);
-				ret = btrfs_inc_extent_ref(trans, &ref);
-				if (ret) {
-					btrfs_abort_transaction(trans, ret);
-					goto out;
-				}
-			} else {
-				/*
-				 * insert the extent pointer in the extent
-				 * allocation tree
-				 */
-				ret = btrfs_alloc_logged_file_extent(trans,
-						btrfs_root_id(root),
-						key->objectid, offset, &ins);
-				if (ret) {
-					btrfs_abort_transaction(trans, ret);
-					goto out;
-				}
-			}
-			btrfs_release_path(path);
-
-			if (btrfs_file_extent_compression(eb, item)) {
-				csum_start = ins.objectid;
-				csum_end = csum_start + ins.offset;
-			} else {
-				csum_start = ins.objectid +
-					btrfs_file_extent_offset(eb, item);
-				csum_end = csum_start +
-					btrfs_file_extent_num_bytes(eb, item);
 			}
-
-			ret = btrfs_lookup_csums_list(root->log_root,
-						csum_start, csum_end - 1,
-						&ordered_sums, false);
-			if (ret < 0) {
+		} else {
+			/* Insert the extent pointer in the extent tree. */
+			ret = btrfs_alloc_logged_file_extent(trans, btrfs_root_id(root),
+							     key->objectid, offset, &ins);
+			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
-			ret = 0;
-			/*
-			 * Now delete all existing cums in the csum root that
-			 * cover our range. We do this because we can have an
-			 * extent that is completely referenced by one file
-			 * extent item and partially referenced by another
-			 * file extent item (like after using the clone or
-			 * extent_same ioctls). In this case if we end up doing
-			 * the replay of the one that partially references the
-			 * extent first, and we do not do the csum deletion
-			 * below, we can get 2 csum items in the csum tree that
-			 * overlap each other. For example, imagine our log has
-			 * the two following file extent items:
-			 *
-			 * key (257 EXTENT_DATA 409600)
-			 *     extent data disk byte 12845056 nr 102400
-			 *     extent data offset 20480 nr 20480 ram 102400
-			 *
-			 * key (257 EXTENT_DATA 819200)
-			 *     extent data disk byte 12845056 nr 102400
-			 *     extent data offset 0 nr 102400 ram 102400
-			 *
-			 * Where the second one fully references the 100K extent
-			 * that starts at disk byte 12845056, and the log tree
-			 * has a single csum item that covers the entire range
-			 * of the extent:
-			 *
-			 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
-			 *
-			 * After the first file extent item is replayed, the
-			 * csum tree gets the following csum item:
-			 *
-			 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
-			 *
-			 * Which covers the 20K sub-range starting at offset 20K
-			 * of our extent. Now when we replay the second file
-			 * extent item, if we do not delete existing csum items
-			 * that cover any of its blocks, we end up getting two
-			 * csum items in our csum tree that overlap each other:
-			 *
-			 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
-			 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
-			 *
-			 * Which is a problem, because after this anyone trying
-			 * to lookup up for the checksum of any block of our
-			 * extent starting at an offset of 40K or higher, will
-			 * end up looking at the second csum item only, which
-			 * does not contain the checksum for any block starting
-			 * at offset 40K or higher of our extent.
-			 */
-			while (!list_empty(&ordered_sums)) {
-				struct btrfs_ordered_sum *sums;
-				struct btrfs_root *csum_root;
-
-				sums = list_first_entry(&ordered_sums,
-							struct btrfs_ordered_sum,
-							list);
-				csum_root = btrfs_csum_root(fs_info,
-							    sums->logical);
-				if (!ret) {
-					ret = btrfs_del_csums(trans, csum_root,
-							      sums->logical,
-							      sums->len);
-					if (ret)
-						btrfs_abort_transaction(trans, ret);
-				}
-				if (!ret) {
-					ret = btrfs_csum_file_blocks(trans,
-								     csum_root,
-								     sums);
-					if (ret)
-						btrfs_abort_transaction(trans, ret);
-				}
-				list_del(&sums->list);
-				kfree(sums);
-			}
-			if (ret)
-				goto out;
+		}
+
+		btrfs_release_path(path);
+
+		if (btrfs_file_extent_compression(eb, item)) {
+			csum_start = ins.objectid;
+			csum_end = csum_start + ins.offset;
 		} else {
-			btrfs_release_path(path);
+			csum_start = ins.objectid + btrfs_file_extent_offset(eb, item);
+			csum_end = csum_start + btrfs_file_extent_num_bytes(eb, item);
+		}
+
+		ret = btrfs_lookup_csums_list(root->log_root, csum_start, csum_end - 1,
+					      &ordered_sums, false);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
 		}
+		ret = 0;
+		/*
+		 * Now delete all existing cums in the csum root that cover our
+		 * range. We do this because we can have an extent that is
+		 * completely referenced by one file extent item and partially
+		 * referenced by another file extent item (like after using the
+		 * clone or extent_same ioctls). In this case if we end up doing
+		 * the replay of the one that partially references the extent
+		 * first, and we do not do the csum deletion below, we can get 2
+		 * csum items in the csum tree that overlap each other. For
+		 * example, imagine our log has the two following file extent items:
+		 *
+		 * key (257 EXTENT_DATA 409600)
+		 *     extent data disk byte 12845056 nr 102400
+		 *     extent data offset 20480 nr 20480 ram 102400
+		 *
+		 * key (257 EXTENT_DATA 819200)
+		 *     extent data disk byte 12845056 nr 102400
+		 *     extent data offset 0 nr 102400 ram 102400
+		 *
+		 * Where the second one fully references the 100K extent that
+		 * starts at disk byte 12845056, and the log tree has a single
+		 * csum item that covers the entire range of the extent:
+		 *
+		 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
+		 *
+		 * After the first file extent item is replayed, the csum tree
+		 * gets the following csum item:
+		 *
+		 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
+		 *
+		 * Which covers the 20K sub-range starting at offset 20K of our
+		 * extent. Now when we replay the second file extent item, if we
+		 * do not delete existing csum items that cover any of its
+		 * blocks, we end up getting two csum items in our csum tree
+		 * that overlap each other:
+		 *
+		 * key (EXTENT_CSUM EXTENT_CSUM 12845056) itemsize 100
+		 * key (EXTENT_CSUM EXTENT_CSUM 12865536) itemsize 20
+		 *
+		 * Which is a problem, because after this anyone trying to
+		 * lookup up for the checksum of any block of our extent
+		 * starting at an offset of 40K or higher, will end up looking
+		 * at the second csum item only, which does not contain the
+		 * checksum for any block starting at offset 40K or higher of
+		 * our extent.
+		 */
+		while (!list_empty(&ordered_sums)) {
+			struct btrfs_ordered_sum *sums;
+			struct btrfs_root *csum_root;
+
+			sums = list_first_entry(&ordered_sums,
+						struct btrfs_ordered_sum, list);
+			csum_root = btrfs_csum_root(fs_info, sums->logical);
+			if (!ret) {
+				ret = btrfs_del_csums(trans, csum_root, sums->logical,
+						      sums->len);
+				if (ret)
+					btrfs_abort_transaction(trans, ret);
+			}
+			if (!ret) {
+				ret = btrfs_csum_file_blocks(trans, csum_root, sums);
+				if (ret)
+					btrfs_abort_transaction(trans, ret);
+			}
+			list_del(&sums->list);
+			kfree(sums);
+		}
+		if (ret)
+			goto out;
 	} else if (found_type == BTRFS_FILE_EXTENT_INLINE) {
 		/* inline extents are easy, we just overwrite them */
 		ret = overwrite_item(trans, root, path, eb, slot, key);
@@ -921,13 +912,13 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
+update_inode:
 	ret = btrfs_inode_set_file_extent_range(inode, start, extent_end - start);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-update_inode:
 	btrfs_update_inode_bytes(inode, nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, inode);
 	if (ret)
-- 
2.47.2


