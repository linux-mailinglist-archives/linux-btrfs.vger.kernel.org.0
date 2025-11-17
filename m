Return-Path: <linux-btrfs+bounces-19072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10DC64087
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C3254E4FBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF832C920;
	Mon, 17 Nov 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNy4EYzQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210B32B99E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382373; cv=none; b=Hgt91AVbbSYUuanh0S7x6Rrjpo2R1fhfC0w+j2R2DG+ayvkqTrfUho03Mg2EXlrgBjHiIbvsH4t0jDipyzSstbtxLRiUi/cSBEkS576rkVFxva1uzIgrfqDjec6XPhH6CPV2qbuueSJgDtfdG6GTrONtfSh/MEVk/8FjEUIWQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382373; c=relaxed/simple;
	bh=aDvTiNvOnxQfGcVZQlnOTkUnxe4HiU/yTVczqVEowjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knX/sLrVpxealHgv8WWRyLww9HSOlzPSJ6qWUzQ5aVOoceDPbMLi9JPeyKHiIRsUrKE3VG88cl9/5yqbW+upoStCYDXFPLXymMZTOoQFU7C7hoqNhK7uuInB2iy0ThVjRkZcAg5ONEPWmE42KhtbaM5QKXKqqE5/WfYR3zN0iME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNy4EYzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398EAC2BC87
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763382372;
	bh=aDvTiNvOnxQfGcVZQlnOTkUnxe4HiU/yTVczqVEowjU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RNy4EYzQsqxNlLIPgIs19fWRhgx3fx4079xdRPdERfAv7fjCBXwc7EXamQkUUPWNJ
	 mgubK7mOn/chXDjomHTqnebpztxOQniyy2raaZKxB/slikZvpl9/hP+1s5B3GY3yK3
	 FVikgjsFsqA8TnGx/ii64MyZBk6Px3e4/+bgswyw6Oc4B3zOlJX8pQKieHcHwFoaZG
	 p3EriI+T1J/CDtmhMW+fSVeIkEfyRR0MiPleMzdfVKk62lbp+qw319Q4wVY8yIs4fy
	 savGVMjfI//ijVbM50/yXyZ/kIYgxxz7A9neAlAIqdbl5hNaCig4nmZp2A1iHSDLMO
	 +1tNanswRQepw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: use booleans for delalloc arguments and struct find_free_extent_ctl
Date: Mon, 17 Nov 2025 12:26:07 +0000
Message-ID: <738b447897ab72b409ada9e8b3f44f91aa858bb0.1763381954.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763381954.git.fdmanana@suse.com>
References: <cover.1763381954.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The struct find_free_extent_ctl uses an int for the 'delalloc' field but
it's always used as a boolean, and its value is used to be passed to
several functions to signal if we are dealing with delalloc. The same goes
for the 'is_data' argument from btrfs_reserve_extent(). So change the type
from int to bool and move the field definition in the find_free_extent_ctl
structure so that it's close to other bool fields and reduces the size of
the structure from 144 down to 136 bytes (at the moment it's only declared
in the stack of btrfs_reserve_extent(), never allocated otherwise).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/block-group.h |  2 +-
 fs/btrfs/direct-io.c   |  2 +-
 fs/btrfs/extent-tree.c | 16 +++++++---------
 fs/btrfs/extent-tree.h |  4 ++--
 fs/btrfs/inode.c       |  8 ++++----
 6 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ebbf04501782..8ae73123b610 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3802,7 +3802,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
  * reservation and return -EAGAIN, otherwise this function always succeeds.
  */
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
-			     u64 ram_bytes, u64 num_bytes, int delalloc,
+			     u64 ram_bytes, u64 num_bytes, bool delalloc,
 			     bool force_wrong_size_class)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9172104a5889..5f933455118c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -345,7 +345,7 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc);
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
-			     u64 ram_bytes, u64 num_bytes, int delalloc,
+			     u64 ram_bytes, u64 num_bytes, bool delalloc,
 			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 			       bool is_delalloc);
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 962fccceffd6..07e19e88ba4b 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -186,7 +186,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, len);
 again:
 	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
-				   0, alloc_hint, &ins, 1, 1);
+				   0, alloc_hint, &ins, true, true);
 	if (ret == -EAGAIN) {
 		ASSERT(btrfs_is_zoned(fs_info));
 		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINISH,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 819e0a15e8e7..a3646440c4fe 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3587,15 +3587,14 @@ enum btrfs_loop_type {
 };
 
 static inline void
-btrfs_lock_block_group(struct btrfs_block_group *cache,
-		       int delalloc)
+btrfs_lock_block_group(struct btrfs_block_group *cache, bool delalloc)
 {
 	if (delalloc)
 		down_read(&cache->data_rwsem);
 }
 
 static inline void btrfs_grab_block_group(struct btrfs_block_group *cache,
-		       int delalloc)
+					  bool delalloc)
 {
 	btrfs_get_block_group(cache);
 	if (delalloc)
@@ -3605,7 +3604,7 @@ static inline void btrfs_grab_block_group(struct btrfs_block_group *cache,
 static struct btrfs_block_group *btrfs_lock_cluster(
 		   struct btrfs_block_group *block_group,
 		   struct btrfs_free_cluster *cluster,
-		   int delalloc)
+		   bool delalloc)
 	__acquires(&cluster->refill_lock)
 {
 	struct btrfs_block_group *used_bg = NULL;
@@ -3642,8 +3641,7 @@ static struct btrfs_block_group *btrfs_lock_cluster(
 }
 
 static inline void
-btrfs_release_block_group(struct btrfs_block_group *cache,
-			 int delalloc)
+btrfs_release_block_group(struct btrfs_block_group *cache, bool delalloc)
 {
 	if (delalloc)
 		up_read(&cache->data_rwsem);
@@ -4033,7 +4031,7 @@ static int do_allocation(struct btrfs_block_group *block_group,
 
 static void release_block_group(struct btrfs_block_group *block_group,
 				struct find_free_extent_ctl *ffe_ctl,
-				int delalloc)
+				bool delalloc)
 {
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
@@ -4689,7 +4687,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 			 u64 num_bytes, u64 min_alloc_size,
 			 u64 empty_size, u64 hint_byte,
-			 struct btrfs_key *ins, int is_data, int delalloc)
+			 struct btrfs_key *ins, bool is_data, bool delalloc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct find_free_extent_ctl ffe_ctl = {};
@@ -5166,7 +5164,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		return ERR_CAST(block_rsv);
 
 	ret = btrfs_reserve_extent(root, blocksize, blocksize, blocksize,
-				   empty_size, hint, &ins, 0, 0);
+				   empty_size, hint, &ins, false, false);
 	if (ret)
 		goto out_unuse;
 
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index e573509c5a71..f96a300a2db4 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -30,7 +30,6 @@ struct find_free_extent_ctl {
 	u64 min_alloc_size;
 	u64 empty_size;
 	u64 flags;
-	int delalloc;
 
 	/* Where to start the search inside the bg */
 	u64 search_start;
@@ -40,6 +39,7 @@ struct find_free_extent_ctl {
 	struct btrfs_free_cluster *last_ptr;
 	bool use_cluster;
 
+	bool delalloc;
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
 
@@ -137,7 +137,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 				   struct btrfs_key *ins);
 int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes, u64 num_bytes,
 			 u64 min_alloc_size, u64 empty_size, u64 hint_byte,
-			 struct btrfs_key *ins, int is_data, int delalloc);
+			 struct btrfs_key *ins, bool is_data, bool delalloc);
 int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, bool full_backref);
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fc0f0c46ab22..f71a5f7f55b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1136,7 +1136,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	ret = btrfs_reserve_extent(root, async_extent->ram_size,
 				   async_extent->compressed_size,
 				   async_extent->compressed_size,
-				   0, *alloc_hint, &ins, 1, 1);
+				   0, *alloc_hint, &ins, true, true);
 	if (ret) {
 		/*
 		 * We can't reserve contiguous space for the compressed size.
@@ -1359,7 +1359,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		ret = btrfs_reserve_extent(root, num_bytes, num_bytes,
 					   min_alloc_size, 0, alloc_hint,
-					   &ins, 1, 1);
+					   &ins, true, true);
 		if (ret == -EAGAIN) {
 			/*
 			 * btrfs_reserve_extent only returns -EAGAIN for zoned
@@ -9106,7 +9106,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		 */
 		cur_bytes = min(cur_bytes, last_alloc);
 		ret = btrfs_reserve_extent(root, cur_bytes, cur_bytes,
-				min_size, 0, *alloc_hint, &ins, 1, 0);
+				min_size, 0, *alloc_hint, &ins, true, false);
 		if (ret)
 			break;
 
@@ -9914,7 +9914,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 
 	ret = btrfs_reserve_extent(root, disk_num_bytes, disk_num_bytes,
-				   disk_num_bytes, 0, 0, &ins, 1, 1);
+				   disk_num_bytes, 0, 0, &ins, true, true);
 	if (ret)
 		goto out_delalloc_release;
 	extent_reserved = true;
-- 
2.47.2


