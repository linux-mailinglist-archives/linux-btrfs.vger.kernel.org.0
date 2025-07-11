Return-Path: <linux-btrfs+bounces-15460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A40B016E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0137AF4D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448DA1FECB4;
	Fri, 11 Jul 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDnCvLnD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534520D500
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224054; cv=none; b=lICWYTsxJ7esfyRtyEbXWr2gWgnpKqpIQrBNbQSGnkq5qPoCJHQCZsAJuHPV0Uaapm5yzWldtd8NTFOqbSj18xF5qvvLaTYeF31p/bO+RIiqy9J4w3W4ZgU1TaiPKNC63H0gpNd8PAiLC9iOw3Gi8gFu0VQ/V1ZNpjPVTD4SN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224054; c=relaxed/simple;
	bh=K/Kwrzz1wuTvJ1kA1Jsyr178UlbDRybn5j4RTURVRxY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GU7ztAq9BD8vJ6oGfsSlVjEtFGZuawaBgcPOj02qjnxErVr7tlDAeungbEwlWCzlcirpg5B7qKKxIq1iTb9lc8x6bSx2xYv5Ux23v0e8ijOKMbka/SIp0jTwn1aB57V2R38z/bGhTcSkYp6zH4GQt5nmzv4qzguKoAe5seR5f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDnCvLnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907AAC4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224054;
	bh=K/Kwrzz1wuTvJ1kA1Jsyr178UlbDRybn5j4RTURVRxY=;
	h=From:To:Subject:Date:From;
	b=DDnCvLnDZ07XT8+BS0Msl7T6En8hDEymDZwKBIfAXT1Ijey7rov/QJz3jiiNAdLl1
	 uFC/kxug0gP0eu+ae6M4IsqmEFNk7a/rXKPtinCyTsWy8LMAY7L9IaVtC5WW0QZteo
	 qNxrl+D8zxQtzLWnJtwzUthrimRmmfXTm3SMzGQEaZjw2CZ+eDgZRHwNzLfYckp4MI
	 2HgyePNSKZZDR8Mf1YFBcIGRYFylBzkWTSmEZhihbRYtwlz/JGurBmmrO12z0CVZjy
	 xMyC3ppvymuZObReXOAQHY0hcOaURwmBIGxO0kcK7Oc2cKcE/PYJ99cX1wkfErVuNC
	 x0F9rwSVPOZVQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove btrfs_clear_extent_bits()
Date: Fri, 11 Jul 2025 09:54:10 +0100
Message-ID: <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's just a simple wrapper around btrfs_clear_extent_bit() that passes a
NULL for its last argument (a cached extent state record), plus there is
not counter part - we have a btrfs_set_extent_bit() but we do not have a
btrfs_set_extent_bits() (plural version). So just remove it and make all
callers use btrfs_clear_extent_bit() directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c           | 12 ++++++------
 fs/btrfs/disk-io.c               |  2 +-
 fs/btrfs/extent-io-tree.h        |  6 ------
 fs/btrfs/inode.c                 |  4 ++--
 fs/btrfs/qgroup.c                |  4 ++--
 fs/btrfs/reflink.c               |  4 ++--
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/tests/extent-io-tests.c |  4 ++--
 fs/btrfs/tests/inode-tests.c     | 24 ++++++++++++------------
 fs/btrfs/volumes.c               | 10 +++++-----
 10 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fb62a8cf03b3..999b61c97011 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -832,8 +832,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
 {
-	btrfs_clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
-				bg->start + bg->length - 1, EXTENT_DIRTY);
+	btrfs_clear_extent_bit(&bg->fs_info->excluded_extents, bg->start,
+			       bg->start + bg->length - 1, EXTENT_DIRTY, NULL);
 }
 
 static noinline void caching_thread(struct btrfs_work *work)
@@ -1436,14 +1436,14 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	 */
 	mutex_lock(&fs_info->unused_bg_unpin_mutex);
 	if (prev_trans) {
-		ret = btrfs_clear_extent_bits(&prev_trans->pinned_extents, start, end,
-					      EXTENT_DIRTY);
+		ret = btrfs_clear_extent_bit(&prev_trans->pinned_extents, start, end,
+					     EXTENT_DIRTY, NULL);
 		if (ret)
 			goto out;
 	}
 
-	ret = btrfs_clear_extent_bits(&trans->transaction->pinned_extents, start, end,
-				      EXTENT_DIRTY);
+	ret = btrfs_clear_extent_bit(&trans->transaction->pinned_extents, start, end,
+				     EXTENT_DIRTY, NULL);
 out:
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 	if (prev_trans)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 44e7ae4a2e0b..9cc14ab35297 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4641,7 +4641,7 @@ static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 
 	while (btrfs_find_first_extent_bit(dirty_pages, start, &start, &end,
 					   mark, NULL)) {
-		btrfs_clear_extent_bits(dirty_pages, start, end, mark);
+		btrfs_clear_extent_bit(dirty_pages, start, end, mark, NULL);
 		while (start <= end) {
 			eb = find_extent_buffer(fs_info, start);
 			start += fs_info->nodesize;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 819da07bff09..36facca37973 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -192,12 +192,6 @@ static inline int btrfs_unlock_extent(struct extent_io_tree *tree, u64 start, u6
 						cached, NULL);
 }
 
-static inline int btrfs_clear_extent_bits(struct extent_io_tree *tree, u64 start,
-					  u64 end, u32 bits)
-{
-	return btrfs_clear_extent_bit(tree, start, end, bits, NULL);
-}
-
 int btrfs_set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 				 u32 bits, struct extent_changeset *changeset);
 int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6781956197c7..7ed340cac33f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3374,8 +3374,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 	    btrfs_test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
 				 NULL)) {
 		/* Skip the range without csum for data reloc inode */
-		btrfs_clear_extent_bits(&inode->io_tree, file_offset, end,
-					EXTENT_NODATASUM);
+		btrfs_clear_extent_bit(&inode->io_tree, file_offset, end,
+				       EXTENT_NODATASUM, NULL);
 		return true;
 	}
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ae9bc7c71a34..1a5972178b3a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4116,8 +4116,8 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
 		 * Now the entry is in [start, start + len), revert the
 		 * EXTENT_QGROUP_RESERVED bit.
 		 */
-		clear_ret = btrfs_clear_extent_bits(&inode->io_tree, entry_start,
-						    entry_end, EXTENT_QGROUP_RESERVED);
+		clear_ret = btrfs_clear_extent_bit(&inode->io_tree, entry_start, entry_end,
+						   EXTENT_QGROUP_RESERVED, NULL);
 		if (!ret && clear_ret < 0)
 			ret = clear_ret;
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 0197bd9160a7..ce25ab7f0e99 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -93,8 +93,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (ret < 0)
 		goto out_unlock;
 
-	btrfs_clear_extent_bits(&inode->io_tree, file_offset, range_end,
-				EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG);
+	btrfs_clear_extent_bit(&inode->io_tree, file_offset, range_end,
+			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, NULL);
 	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 175fc3acc38b..70a9c20b2caf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3651,7 +3651,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	}
 
 	btrfs_release_path(path);
-	btrfs_clear_extent_bits(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRTY);
+	btrfs_clear_extent_bit(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRTY, NULL);
 
 	if (trans) {
 		btrfs_end_transaction_throttle(trans);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 660141fc67a8..b19328d077d3 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -326,7 +326,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 out_bits:
 	if (ret)
 		dump_extent_io_tree(tmp);
-	btrfs_clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
+	btrfs_clear_extent_bit(tmp, 0, total_dirty - 1, (unsigned)-1, NULL);
 out:
 	if (locked_page)
 		put_page(locked_page);
@@ -662,7 +662,7 @@ static int test_find_first_clear_extent_bit(void)
 out:
 	if (ret)
 		dump_extent_io_tree(&tree);
-	btrfs_clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	btrfs_clear_extent_bit(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index a29d2c02c2c8..a4c2b7748b95 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -950,10 +950,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE/2][sectorsize HOLE][the rest] */
-	ret = btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree,
-				      BTRFS_MAX_EXTENT_SIZE >> 1,
-				      (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
-				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+	ret = btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree,
+				     BTRFS_MAX_EXTENT_SIZE >> 1,
+				     (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
+				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1017,10 +1017,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE+4k][4K HOLE][BTRFS_MAX_EXTENT_SIZE+4k] */
-	ret = btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree,
-				      BTRFS_MAX_EXTENT_SIZE + sectorsize,
-				      BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
-				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+	ret = btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree,
+				     BTRFS_MAX_EXTENT_SIZE + sectorsize,
+				     BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
+				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1051,8 +1051,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* Empty */
-	ret = btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+	ret = btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
+				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1066,8 +1066,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (ret)
-		btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-					EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+		btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
+				       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 31aecd291d6c..3e31030063cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5017,8 +5017,8 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 
 	mutex_lock(&fs_info->chunk_mutex);
 	/* Clear all state bits beyond the shrunk device size */
-	btrfs_clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
-				CHUNK_STATE_MASK);
+	btrfs_clear_extent_bit(&device->alloc_state, new_size, (u64)-1,
+			       CHUNK_STATE_MASK, NULL);
 
 	btrfs_device_set_disk_total_bytes(device, new_size);
 	if (list_empty(&device->post_commit_list))
@@ -5445,9 +5445,9 @@ static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned in
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		btrfs_clear_extent_bits(&device->alloc_state, stripe->physical,
-					stripe->physical + map->stripe_size - 1,
-					bits | EXTENT_NOWAIT);
+		btrfs_clear_extent_bit(&device->alloc_state, stripe->physical,
+				       stripe->physical + map->stripe_size - 1,
+				       bits | EXTENT_NOWAIT, NULL);
 	}
 }
 
-- 
2.47.2


