Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AB3F1931
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhHSM2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46903 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbhHSM17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376042; x=1660912042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+yBiCHH0RJUPqMJSVdG/DUzX9BJvRhPFwnlxQHbAQY=;
  b=MIGPCGG7LtVm/SAv1VrR+0rtuN51q0/s18Cdr4MoSiXMZdGdQnl9FTB6
   nneXK2pCPmF3m6sy1oCjCn9JFfZRI85HwKyLhuZ7P6vgVV9NFtygq07SY
   BIDLhAXIE9i6sFMyJTUgLWx0RcPJcwG6Nj1XfnUQ7v6SGzhLWphLXnXgw
   aa56vifozQZPjAcGagpUNCWU1o0Lg1+7oxo8eaupF9yIDIyJAkdXIt7fJ
   0K3XAkRstABP7BblS3nyrftDGqSZCBCzwrDGzUko8ueq5puYO1aYarRWS
   PRWgyU+1VXb70ni+WI18kEhD17dq05XMLuJtwDdjnmAaJREuC6Oo74+NA
   w==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773623"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:22 +0800
IronPort-SDR: SNRtshvUMoZvqU3uaM9YfiipGvygucFuOP51vkutBcs3ps45MzOOU8wMjYIM9BLwvi5PdTrE+m
 Q9GTqAQgH1E6lVO6xQrmiYP783Dott1cSzhlSOL4H6hI6+fNNlE3v7WAGnMZfLBU6ZnGVNB+lI
 xlICqBxqhWkmU9JaFB/xf+NAdigQ9fbYWJLA1szuGHdU32Uens3AvI/vbkQclNZLIcUHGTvbSt
 GRpfzCr9bo0DlYbRixpTEwMFw5yX+Zx1aoKPgUS47D3aqpc7nFZZcxpO7y74BrZMbPIZpcYpCb
 IBT+bkhLS3kfe9uoGkxribWU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:30 -0700
IronPort-SDR: +t4sdP/+OmE42HyZGppFBmwKQ4GGykRDZktNtc57s9wTd4+wofP9u8GtwnHJJontpwOBrezfEj
 QZr1+RW06zqkjzOo/AMDquGXbjFVTD94b7hAW8U1S35Pg8ZsPIHI9C3gygSqVYNqmgZ8+vn2+x
 H+nYLoXgvJiNxt3g/gd3x7MYNCmF8A6ayTCoNjqzyZeIfU/RqKO2+7FrUcpI+nzwNL6GZeP4Fi
 nMgzlaeqL7xH/I+4XTD7LaSZ03tn2pp0R64E9AcvzWlu2IF+b6cZ4VcFpempsfrp6mELmSn2p6
 rcs=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 14/17] btrfs: move ffe_ctl one level up
Date:   Thu, 19 Aug 2021 21:19:21 +0900
Message-Id: <f580f2927575856c9827bc63f0ff985ba80ab91d.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are passing too many variables as it is from btrfs_reserve_extent() to
find_free_extent(). The next commit will add min_alloc_size to ffe_ctl, and
that means another pass-through argument. Take this opportunity to move
ffe_ctl one level up and drop the redundant arguments.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 162 ++++++++++++++++++++++-------------------
 1 file changed, 88 insertions(+), 74 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ac367f1dc4e6..1daa432673c4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3476,6 +3476,7 @@ enum btrfs_extent_allocation_policy {
  */
 struct find_free_extent_ctl {
 	/* Basic allocation info */
+	u64 ram_bytes;
 	u64 num_bytes;
 	u64 empty_size;
 	u64 flags;
@@ -4130,65 +4131,62 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
  *    |- If not found, re-iterate all block groups
  */
 static noinline int find_free_extent(struct btrfs_root *root,
-				u64 ram_bytes, u64 num_bytes, u64 empty_size,
-				u64 hint_byte_orig, struct btrfs_key *ins,
-				u64 flags, int delalloc)
+				     struct btrfs_key *ins,
+				     struct find_free_extent_ctl *ffe_ctl)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret = 0;
 	int cache_block_group_error = 0;
 	struct btrfs_block_group *block_group = NULL;
-	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
-	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 
-	WARN_ON(num_bytes < fs_info->sectorsize);
-
-	ffe_ctl.num_bytes = num_bytes;
-	ffe_ctl.empty_size = empty_size;
-	ffe_ctl.flags = flags;
-	ffe_ctl.search_start = 0;
-	ffe_ctl.delalloc = delalloc;
-	ffe_ctl.index = btrfs_bg_flags_to_raid_index(flags);
-	ffe_ctl.have_caching_bg = false;
-	ffe_ctl.orig_have_caching_bg = false;
-	ffe_ctl.found_offset = 0;
-	ffe_ctl.hint_byte = hint_byte_orig;
-	ffe_ctl.for_treelog = for_treelog;
-	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
+	WARN_ON(ffe_ctl->num_bytes < fs_info->sectorsize);
 
+	ffe_ctl->search_start = 0;
+	/* For clustered allocation */
+	ffe_ctl->empty_cluster = 0;
+	ffe_ctl->last_ptr = NULL;
+	ffe_ctl->use_cluster = true;
+	ffe_ctl->have_caching_bg = false;
+	ffe_ctl->orig_have_caching_bg = false;
+	ffe_ctl->index = btrfs_bg_flags_to_raid_index(ffe_ctl->flags);
+	ffe_ctl->loop = 0;
 	/* For clustered allocation */
-	ffe_ctl.retry_clustered = false;
-	ffe_ctl.retry_unclustered = false;
-	ffe_ctl.last_ptr = NULL;
-	ffe_ctl.use_cluster = true;
+	ffe_ctl->retry_clustered = false;
+	ffe_ctl->retry_unclustered = false;
+	ffe_ctl->cached = 0;
+	ffe_ctl->max_extent_size = 0;
+	ffe_ctl->total_free_space = 0;
+	ffe_ctl->found_offset = 0;
+	ffe_ctl->policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	if (btrfs_is_zoned(fs_info))
-		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+		ffe_ctl->policy = BTRFS_EXTENT_ALLOC_ZONED;
 
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
 
-	trace_find_free_extent(root, num_bytes, empty_size, flags);
+	trace_find_free_extent(root, ffe_ctl->num_bytes, ffe_ctl->empty_size,
+			       ffe_ctl->flags);
 
-	space_info = btrfs_find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
 	if (!space_info) {
-		btrfs_err(fs_info, "No space info for %llu", flags);
+		btrfs_err(fs_info, "No space info for %llu", ffe_ctl->flags);
 		return -ENOSPC;
 	}
 
-	ret = prepare_allocation(fs_info, &ffe_ctl, space_info, ins);
+	ret = prepare_allocation(fs_info, ffe_ctl, space_info, ins);
 	if (ret < 0)
 		return ret;
 
-	ffe_ctl.search_start = max(ffe_ctl.search_start,
-				   first_logical_byte(fs_info, 0));
-	ffe_ctl.search_start = max(ffe_ctl.search_start, ffe_ctl.hint_byte);
-	if (ffe_ctl.search_start == ffe_ctl.hint_byte) {
+	ffe_ctl->search_start = max(ffe_ctl->search_start,
+				    first_logical_byte(fs_info, 0));
+	ffe_ctl->search_start = max(ffe_ctl->search_start, ffe_ctl->hint_byte);
+	if (ffe_ctl->search_start == ffe_ctl->hint_byte) {
 		block_group = btrfs_lookup_block_group(fs_info,
-						       ffe_ctl.search_start);
+						       ffe_ctl->search_start);
 		/*
 		 * we don't want to use the block group if it doesn't match our
 		 * allocation bits, or if its not cached.
@@ -4196,7 +4194,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		 * However if we are re-searching with an ideal block group
 		 * picked out then we don't care that the block group is cached.
 		 */
-		if (block_group && block_group_bits(block_group, flags) &&
+		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
 		    block_group->cached != BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
@@ -4210,9 +4208,10 @@ static noinline int find_free_extent(struct btrfs_root *root,
 				btrfs_put_block_group(block_group);
 				up_read(&space_info->groups_sem);
 			} else {
-				ffe_ctl.index = btrfs_bg_flags_to_raid_index(
+				ffe_ctl->index = btrfs_bg_flags_to_raid_index(
 						block_group->flags);
-				btrfs_lock_block_group(block_group, delalloc);
+				btrfs_lock_block_group(block_group,
+						       ffe_ctl->delalloc);
 				goto have_block_group;
 			}
 		} else if (block_group) {
@@ -4220,31 +4219,31 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 	}
 search:
-	ffe_ctl.have_caching_bg = false;
-	if (ffe_ctl.index == btrfs_bg_flags_to_raid_index(flags) ||
-	    ffe_ctl.index == 0)
+	ffe_ctl->have_caching_bg = false;
+	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
+	    ffe_ctl->index == 0)
 		full_search = true;
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
-			    &space_info->block_groups[ffe_ctl.index], list) {
+			    &space_info->block_groups[ffe_ctl->index], list) {
 		struct btrfs_block_group *bg_ret;
 
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro)) {
-			if (for_treelog)
+			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
 			continue;
 		}
 
-		btrfs_grab_block_group(block_group, delalloc);
-		ffe_ctl.search_start = block_group->start;
+		btrfs_grab_block_group(block_group, ffe_ctl->delalloc);
+		ffe_ctl->search_start = block_group->start;
 
 		/*
 		 * this can happen if we end up cycling through all the
 		 * raid types, but we want to make sure we only allocate
 		 * for the proper type.
 		 */
-		if (!block_group_bits(block_group, flags)) {
+		if (!block_group_bits(block_group, ffe_ctl->flags)) {
 			u64 extra = BTRFS_BLOCK_GROUP_DUP |
 				BTRFS_BLOCK_GROUP_RAID1_MASK |
 				BTRFS_BLOCK_GROUP_RAID56_MASK |
@@ -4255,7 +4254,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			 * doesn't provide them, bail.  This does allow us to
 			 * fill raid0 from raid1.
 			 */
-			if ((flags & extra) && !(block_group->flags & extra))
+			if ((ffe_ctl->flags & extra) &&
+			    !(block_group->flags & extra))
 				goto loop;
 
 			/*
@@ -4263,14 +4263,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			 * It's possible that we have MIXED_GROUP flag but no
 			 * block group is mixed.  Just skip such block group.
 			 */
-			btrfs_release_block_group(block_group, delalloc);
+			btrfs_release_block_group(block_group,
+						  ffe_ctl->delalloc);
 			continue;
 		}
 
 have_block_group:
-		ffe_ctl.cached = btrfs_block_group_done(block_group);
-		if (unlikely(!ffe_ctl.cached)) {
-			ffe_ctl.have_caching_bg = true;
+		ffe_ctl->cached = btrfs_block_group_done(block_group);
+		if (unlikely(!ffe_ctl->cached)) {
+			ffe_ctl->have_caching_bg = true;
 			ret = btrfs_cache_block_group(block_group, 0);
 
 			/*
@@ -4293,10 +4294,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			goto loop;
 
 		bg_ret = NULL;
-		ret = do_allocation(block_group, &ffe_ctl, &bg_ret);
+		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
 		if (ret == 0) {
 			if (bg_ret && bg_ret != block_group) {
-				btrfs_release_block_group(block_group, delalloc);
+				btrfs_release_block_group(block_group,
+							  ffe_ctl->delalloc);
 				block_group = bg_ret;
 			}
 		} else if (ret == -EAGAIN) {
@@ -4306,46 +4308,49 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 		/* Checks */
-		ffe_ctl.search_start = round_up(ffe_ctl.found_offset,
-					     fs_info->stripesize);
+		ffe_ctl->search_start = round_up(ffe_ctl->found_offset,
+						 fs_info->stripesize);
 
 		/* move on to the next group */
-		if (ffe_ctl.search_start + num_bytes >
+		if (ffe_ctl->search_start + ffe_ctl->num_bytes >
 		    block_group->start + block_group->length) {
 			btrfs_add_free_space_unused(block_group,
-					    ffe_ctl.found_offset, num_bytes);
+					    ffe_ctl->found_offset,
+					    ffe_ctl->num_bytes);
 			goto loop;
 		}
 
-		if (ffe_ctl.found_offset < ffe_ctl.search_start)
+		if (ffe_ctl->found_offset < ffe_ctl->search_start)
 			btrfs_add_free_space_unused(block_group,
-					ffe_ctl.found_offset,
-					ffe_ctl.search_start - ffe_ctl.found_offset);
+					ffe_ctl->found_offset,
+					ffe_ctl->search_start - ffe_ctl->found_offset);
 
-		ret = btrfs_add_reserved_bytes(block_group, ram_bytes,
-				num_bytes, delalloc);
+		ret = btrfs_add_reserved_bytes(block_group, ffe_ctl->ram_bytes,
+					       ffe_ctl->num_bytes,
+					       ffe_ctl->delalloc);
 		if (ret == -EAGAIN) {
 			btrfs_add_free_space_unused(block_group,
-					ffe_ctl.found_offset, num_bytes);
+					ffe_ctl->found_offset,
+					ffe_ctl->num_bytes);
 			goto loop;
 		}
 		btrfs_inc_block_group_reservations(block_group);
 
 		/* we are all good, lets return */
-		ins->objectid = ffe_ctl.search_start;
-		ins->offset = num_bytes;
+		ins->objectid = ffe_ctl->search_start;
+		ins->offset = ffe_ctl->num_bytes;
 
-		trace_btrfs_reserve_extent(block_group, ffe_ctl.search_start,
-					   num_bytes);
-		btrfs_release_block_group(block_group, delalloc);
+		trace_btrfs_reserve_extent(block_group, ffe_ctl->search_start,
+					   ffe_ctl->num_bytes);
+		btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 		break;
 loop:
-		release_block_group(block_group, &ffe_ctl, delalloc);
+		release_block_group(block_group, ffe_ctl, ffe_ctl->delalloc);
 		cond_resched();
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ins, &ffe_ctl, full_search);
+	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, full_search);
 	if (ret > 0)
 		goto search;
 
@@ -4354,12 +4359,12 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		 * Use ffe_ctl->total_free_space as fallback if we can't find
 		 * any contiguous hole.
 		 */
-		if (!ffe_ctl.max_extent_size)
-			ffe_ctl.max_extent_size = ffe_ctl.total_free_space;
+		if (!ffe_ctl->max_extent_size)
+			ffe_ctl->max_extent_size = ffe_ctl->total_free_space;
 		spin_lock(&space_info->lock);
-		space_info->max_extent_size = ffe_ctl.max_extent_size;
+		space_info->max_extent_size = ffe_ctl->max_extent_size;
 		spin_unlock(&space_info->lock);
-		ins->offset = ffe_ctl.max_extent_size;
+		ins->offset = ffe_ctl->max_extent_size;
 	} else if (ret == -ENOSPC) {
 		ret = cache_block_group_error;
 	}
@@ -4417,6 +4422,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 			 struct btrfs_key *ins, int is_data, int delalloc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct find_free_extent_ctl ffe_ctl = {0};
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
@@ -4425,8 +4431,16 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
 	WARN_ON(num_bytes < fs_info->sectorsize);
-	ret = find_free_extent(root, ram_bytes, num_bytes, empty_size,
-			       hint_byte, ins, flags, delalloc);
+
+	ffe_ctl.ram_bytes = ram_bytes;
+	ffe_ctl.num_bytes = num_bytes;
+	ffe_ctl.empty_size = empty_size;
+	ffe_ctl.flags = flags;
+	ffe_ctl.delalloc = delalloc;
+	ffe_ctl.hint_byte = hint_byte;
+	ffe_ctl.for_treelog = for_treelog;
+
+	ret = find_free_extent(root, ins, &ffe_ctl);
 	if (!ret && !is_data) {
 		btrfs_dec_block_group_reservations(fs_info, ins->objectid);
 	} else if (ret == -ENOSPC) {
-- 
2.33.0

