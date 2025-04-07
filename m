Return-Path: <linux-btrfs+bounces-12846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94BA7E8BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2FC189EC8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30EC24CECE;
	Mon,  7 Apr 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYMaS1YI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF824633C
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047395; cv=none; b=CWTZNfwKWFep+MXvSI93TzUOP8Dj/jDweteei+e9ZIBnRD0vtkn7e8OqkifDkzOuAj9t5NN7TlODquIFiD+elhpyLXty02s1jExZqse2dg1bVFLP0AJ2DwmxbLe52qKNO7H2RFiuspA4L4HF7m3R2aLcu5WMKZxQ+FUZkp8O6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047395; c=relaxed/simple;
	bh=+xN3WYX47Eki7TjTNvqd6UJ/OkEJI76N0fL2E70UiTE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llolsRsXgq5Z38VNDRpnQ7ajgWXqTOyo6vG6Va16eS+c7FLsttlmVuKt0RxcMzUNVS4p4LuKXcEY7gP+WYryufo9eBzcHfvA6YmBIkHBLih5W4nHMnAXmFXX0ZYH3AKAD8UyEJOlgrV5a9isedqMaHZNakP8eAAl9ueQuU07Qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYMaS1YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7C7C4CEE9
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047395;
	bh=+xN3WYX47Eki7TjTNvqd6UJ/OkEJI76N0fL2E70UiTE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QYMaS1YICJjhGAgwy1+dVDs16io9uErRaE6rW78PGGUV9ECjsHmkxQ02mIOTEzSsv
	 qDMSpjn4aEB6sUL5rx6N6Kx12xm8/MUEOYizNxheSeQPacBf5hySScQOnYNtMh5mtK
	 yxqusMHytwrkHqWmvQ6/UrrPcfX91oVCfEEUj9nnba3cWpQnJTlle52e2ZAb5HgTYo
	 mWe5k65zEY55k7qsaENDlJgQ0dKK4QL0Krfy4H/zyfa+bdxM3fMYtKVz6w6TU/tMXv
	 FRZ4ro2+z26+Uh4Pp2244ZhcSvrYVNQWDipWxS6W9IVzw/J/bmBClgKUz4CvFkYTFK
	 R3znH7w9KBteA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs: rename the functions to search for bits in extent ranges
Date: Mon,  7 Apr 2025 18:36:15 +0100
Message-Id: <db4487f7c2bb01316b5a1ca2a29e0a0c57a2bcad.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These functions are exported so they should have a 'btrfs_' prefix by
convention, to make it clear they are btrfs specific and to avoid
collisions with functions from elsewhere in the kernel.

So add a 'btrfs_' prefix to their name to make it clear they are from
btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c           |  6 +++---
 fs/btrfs/dev-replace.c           |  6 +++---
 fs/btrfs/disk-io.c               | 13 +++++++------
 fs/btrfs/extent-io-tree.c        | 14 +++++++-------
 fs/btrfs/extent-io-tree.h        | 14 +++++++-------
 fs/btrfs/extent-tree.c           | 10 +++++-----
 fs/btrfs/file-item.c             |  4 ++--
 fs/btrfs/free-space-cache.c      |  6 +++---
 fs/btrfs/relocation.c            |  6 +++---
 fs/btrfs/tests/extent-io-tests.c | 24 ++++++++++++------------
 fs/btrfs/transaction.c           |  8 ++++----
 fs/btrfs/volumes.c               |  6 +++---
 12 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 944c355bf051..91807d294366 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -525,9 +525,9 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
 		*total_added_ret = 0;
 
 	while (start < end) {
-		if (!find_first_extent_bit(&info->excluded_extents, start,
-					   &extent_start, &extent_end,
-					   EXTENT_DIRTY, NULL))
+		if (!btrfs_find_first_extent_bit(&info->excluded_extents, start,
+						 &extent_start, &extent_end,
+						 EXTENT_DIRTY, NULL))
 			break;
 
 		if (extent_start <= start) {
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db94c7f22461..55608ac8dbe0 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -794,9 +794,9 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 
 	lockdep_assert_held(&srcdev->fs_info->chunk_mutex);
 
-	while (find_first_extent_bit(&srcdev->alloc_state, start,
-				     &found_start, &found_end,
-				     CHUNK_ALLOCATED, &cached_state)) {
+	while (btrfs_find_first_extent_bit(&srcdev->alloc_state, start,
+					   &found_start, &found_end,
+					   CHUNK_ALLOCATED, &cached_state)) {
 		ret = btrfs_set_extent_bit(&tgtdev->alloc_state, found_start,
 					   found_end, CHUNK_ALLOCATED, NULL);
 		if (ret)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 139a3a09ca57..4259f0582c0d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4237,8 +4237,9 @@ static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
 		u64 found_end;
 
 		found = true;
-		while (find_first_extent_bit(&trans->dirty_pages, cur,
-			&found_start, &found_end, EXTENT_DIRTY, &cached)) {
+		while (btrfs_find_first_extent_bit(&trans->dirty_pages, cur,
+						   &found_start, &found_end,
+						   EXTENT_DIRTY, &cached)) {
 			dirty_bytes += found_end + 1 - found_start;
 			cur = found_end + 1;
 		}
@@ -4691,8 +4692,8 @@ static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	while (find_first_extent_bit(dirty_pages, start, &start, &end,
-				     mark, NULL)) {
+	while (btrfs_find_first_extent_bit(dirty_pages, start, &start, &end,
+					   mark, NULL)) {
 		btrfs_clear_extent_bits(dirty_pages, start, end, mark);
 		while (start <= end) {
 			eb = find_extent_buffer(fs_info, start);
@@ -4726,8 +4727,8 @@ static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		 * the same extent range.
 		 */
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		if (!find_first_extent_bit(unpin, 0, &start, &end,
-					   EXTENT_DIRTY, &cached_state)) {
+		if (!btrfs_find_first_extent_bit(unpin, 0, &start, &end,
+						 EXTENT_DIRTY, &cached_state)) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 49a9202dc5d0..245b78c65edd 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -869,9 +869,9 @@ static struct extent_state *find_first_extent_bit_state(struct extent_io_tree *t
  * Return true if we find something, and update @start_ret and @end_ret.
  * Return false if we found nothing.
  */
-bool find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			   u64 *start_ret, u64 *end_ret, u32 bits,
-			   struct extent_state **cached_state)
+bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, u32 bits,
+				 struct extent_state **cached_state)
 {
 	struct extent_state *state;
 	bool ret = false;
@@ -930,8 +930,8 @@ bool find_first_extent_bit(struct extent_io_tree *tree, u64 start,
  * then walk down the tree until we find a non-contiguous area.  The area
  * returned will be the full contiguous area with the bits set.
  */
-int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, u32 bits)
+int btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+				     u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
 	int ret = 1;
@@ -1495,8 +1495,8 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
  * spans (last_range_end, end of device]. In this case it's up to the caller to
  * trim @end_ret to the appropriate size.
  */
-void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, u32 bits)
+void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				       u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
 	struct extent_state *prev = NULL, *next = NULL;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index e092d776a755..60fedf1b855e 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -214,13 +214,13 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state);
 
-bool find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			   u64 *start_ret, u64 *end_ret, u32 bits,
-			   struct extent_state **cached_state);
-void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, u32 bits);
-int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, u32 bits);
+bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, u32 bits,
+				 struct extent_state **cached_state);
+void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				       u64 *start_ret, u64 *end_ret, u32 bits);
+int btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+				     u64 *start_ret, u64 *end_ret, u32 bits);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 06eb0d724f3d..7ca5cfaccbfd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2829,8 +2829,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		struct extent_state *cached_state = NULL;
 
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		if (!find_first_extent_bit(unpin, 0, &start, &end,
-					   EXTENT_DIRTY, &cached_state)) {
+		if (!btrfs_find_first_extent_bit(unpin, 0, &start, &end,
+						 EXTENT_DIRTY, &cached_state)) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
@@ -6391,9 +6391,9 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		if (ret)
 			break;
 
-		find_first_clear_extent_bit(&device->alloc_state, start,
-					    &start, &end,
-					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+		btrfs_find_first_clear_extent_bit(&device->alloc_state, start,
+						  &start, &end,
+						  CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
 		/* Check if there are any CHUNK_* bits left */
 		if (start > device->total_bytes) {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 87e956cd3520..d2ea830ad244 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -55,8 +55,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 		goto out_unlock;
 	}
 
-	ret = find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
-					 &end, EXTENT_DIRTY);
+	ret = btrfs_find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
+					       &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
 		i_size = min(i_size, end + 1);
 	else
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ba3c8ba26c43..3f91f653c1fa 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1219,9 +1219,9 @@ static noinline_for_stack int write_pinned_extent_entries(
 	start = block_group->start;
 
 	while (start < block_group->start + block_group->length) {
-		if (!find_first_extent_bit(unpin, start,
-					   &extent_start, &extent_end,
-					   EXTENT_DIRTY, NULL))
+		if (!btrfs_find_first_extent_bit(unpin, start,
+						 &extent_start, &extent_end,
+						 EXTENT_DIRTY, NULL))
 			return 0;
 
 		/* This pinned extent is out of our range */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ec31cefd0dc1..b996fb0ee374 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3433,9 +3433,9 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 			goto next;
 		}
 
-		block_found = find_first_extent_bit(&rc->processed_blocks,
-						    key.objectid, &start, &end,
-						    EXTENT_DIRTY, NULL);
+		block_found = btrfs_find_first_extent_bit(&rc->processed_blocks,
+							  key.objectid, &start, &end,
+							  EXTENT_DIRTY, NULL);
 
 		if (block_found && start <= key.objectid) {
 			btrfs_release_path(path);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 5b5506f4b512..6f9bf1174d3b 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -566,7 +566,7 @@ static int test_find_first_clear_extent_bit(void)
 	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST);
 
 	/* Test correct handling of empty tree */
-	find_first_clear_extent_bit(&tree, 0, &start, &end, CHUNK_TRIMMED);
+	btrfs_find_first_clear_extent_bit(&tree, 0, &start, &end, CHUNK_TRIMMED);
 	if (start != 0 || end != -1) {
 		test_err(
 	"error getting a range from completely empty tree: start %llu end %llu",
@@ -580,8 +580,8 @@ static int test_find_first_clear_extent_bit(void)
 	btrfs_set_extent_bit(&tree, SZ_1M, SZ_4M - 1,
 			     CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
 
-	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
-				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	btrfs_find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
+					  CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
 	if (start != 0 || end != SZ_1M - 1) {
 		test_err("error finding beginning range: start %llu end %llu",
@@ -596,8 +596,8 @@ static int test_find_first_clear_extent_bit(void)
 	/*
 	 * Request first hole starting at 12M, we should get 4M-32M
 	 */
-	find_first_clear_extent_bit(&tree, 12 * SZ_1M, &start, &end,
-				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	btrfs_find_first_clear_extent_bit(&tree, 12 * SZ_1M, &start, &end,
+					  CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
 	if (start != SZ_4M || end != SZ_32M - 1) {
 		test_err("error finding trimmed range: start %llu end %llu",
@@ -609,8 +609,8 @@ static int test_find_first_clear_extent_bit(void)
 	 * Search in the middle of allocated range, should get the next one
 	 * available, which happens to be unallocated -> 4M-32M
 	 */
-	find_first_clear_extent_bit(&tree, SZ_2M, &start, &end,
-				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	btrfs_find_first_clear_extent_bit(&tree, SZ_2M, &start, &end,
+					  CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
 	if (start != SZ_4M || end != SZ_32M - 1) {
 		test_err("error finding next unalloc range: start %llu end %llu",
@@ -623,8 +623,8 @@ static int test_find_first_clear_extent_bit(void)
 	 * being unset in this range, we should get the entry in range 64M-72M
 	 */
 	btrfs_set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NULL);
-	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
-				    CHUNK_TRIMMED);
+	btrfs_find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
+					  CHUNK_TRIMMED);
 
 	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1) {
 		test_err("error finding exact range: start %llu end %llu",
@@ -632,8 +632,8 @@ static int test_find_first_clear_extent_bit(void)
 		goto out;
 	}
 
-	find_first_clear_extent_bit(&tree, SZ_64M - SZ_8M, &start, &end,
-				    CHUNK_TRIMMED);
+	btrfs_find_first_clear_extent_bit(&tree, SZ_64M - SZ_8M, &start, &end,
+					  CHUNK_TRIMMED);
 
 	/*
 	 * Search in the middle of set range whose immediate neighbour doesn't
@@ -649,7 +649,7 @@ static int test_find_first_clear_extent_bit(void)
 	 * Search beyond any known range, shall return after last known range
 	 * and end should be -1
 	 */
-	find_first_clear_extent_bit(&tree, -1, &start, &end, CHUNK_TRIMMED);
+	btrfs_find_first_clear_extent_bit(&tree, -1, &start, &end, CHUNK_TRIMMED);
 	if (start != SZ_64M + SZ_8M || end != -1) {
 		test_err(
 		"error handling beyond end of range search: start %llu end %llu",
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3d272c140303..8fa9af18e483 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1128,8 +1128,8 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	while (find_first_extent_bit(dirty_pages, start, &start, &end,
-				     mark, &cached_state)) {
+	while (btrfs_find_first_extent_bit(dirty_pages, start, &start, &end,
+					   mark, &cached_state)) {
 		bool wait_writeback = false;
 
 		ret = convert_extent_bit(dirty_pages, start, end,
@@ -1181,8 +1181,8 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 end;
 	int ret = 0;
 
-	while (find_first_extent_bit(dirty_pages, start, &start, &end,
-				     EXTENT_NEED_WAIT, &cached_state)) {
+	while (btrfs_find_first_extent_bit(dirty_pages, start, &start, &end,
+					   EXTENT_NEED_WAIT, &cached_state)) {
 		/*
 		 * Ignore -ENOMEM errors returned by clear_extent_bit().
 		 * When committing the transaction, we'll remove any entries
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1a60622096da..3c7633a33944 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1600,9 +1600,9 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 	lockdep_assert_held(&device->fs_info->chunk_mutex);
 
-	if (find_first_extent_bit(&device->alloc_state, *start,
-				  &physical_start, &physical_end,
-				  CHUNK_ALLOCATED, NULL)) {
+	if (btrfs_find_first_extent_bit(&device->alloc_state, *start,
+					&physical_start, &physical_end,
+					CHUNK_ALLOCATED, NULL)) {
 
 		if (in_range(physical_start, *start, len) ||
 		    in_range(*start, physical_start,
-- 
2.45.2


