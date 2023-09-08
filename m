Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4532798B70
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245431AbjIHRVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIHRVH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:21:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CFDCE6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:21:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2D5C433CC
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193662;
        bh=iiIj/mmMxvcXkrAyPyk/3HcJyusZrfys+cxpkND6b8M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a1oj9vGoE5fvlVyGkzIWVZFgj1USt8rktft8Uzkmz0KkNqUJfIKBFCQUYWzU39+VF
         uOsdDqZz0KcLzHdIIJuS/4pPuBXorTramOdaLqby3gYGJ4oGjrd3ugF4GjzYoMOE3U
         oClRuCdtIKB0J3t2CapW1cwS5JbxieorHliFkL/AbarOw+b4OmO0VAw1yUD3LPssPO
         d/1jJjIYleVBuGeuvTusEahi2r6Yfz+MrNjP+Ag62LKnBSmnxAZgHVPFCCplIKYwXI
         ZkxU666cnrCYlipnxp9hAySBKqiDestWqqvDZEx1nnsurNoG4xRFW/r5E80k17K7HW
         Aem/MEtb8sE9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 20/21] btrfs: stop doing excessive space reservation for csum deletion
Date:   Fri,  8 Sep 2023 18:20:37 +0100
Message-Id: <abe697657a6beb9cc54737f65ed6afdbd144feca.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently when reserving space for deleting the csum items for a data
extent, when adding or updating a delayed ref head, we determine how
many leaves of csum items we can have and then pass that number to the
helper btrfs_calc_delayed_ref_bytes(). This helper is used for calculating
space for all tree modifications we need when running delayed references,
however the amount of space it computes is excessive for deleting csum
items because:

1) It uses btrfs_calc_insert_metadata_size() which is excessive because
   we only need to delete csum items from the csum tree, we don't need
   to insert any items, so btrfs_calc_metadata_size() is all we need (as
   it computes space needed to delete an item);

2) If the free space tree is enabled, it doubles the amount of space,
   which is pointless for csum deletion since we don't need to touch the
   free space tree or any other tree other than the csum tree.

So improve on this by tracking how many csum deletions we have and using
a new helper to calculate space for csum deletions (just a wrapper around
btrfs_calc_metadata_size() with a comment). This reduces the amount of
space we need to reserve for csum deletions by a factor of 4, and it helps
reduce the number of times we have to block space reservations and have
the reclaim task enter the space flushing algorihm (flush delayed items,
flush delayed refs, etc) in order to satisfy tickets.

For example this results in a total time decrease when unlinking (or
truncating) files with many extents, as we end up having to block on space
metadata reservations less often. Example test:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/test

  umount $DEV &> /dev/null
  mkfs.btrfs -f $DEV
  # Use compression to quickly create files with a lot of extents
  # (each with a size of 128K).
  mount -o compress=lzo $DEV $MNT

  # 100G gives at least 983040 extents with a size of 128K.
  xfs_io -f -c "pwrite -S 0xab -b 1M 0 120G" $MNT/foobar

  # Flush all delalloc and clear all metadata from memory.
  umount $MNT
  mount -o compress=lzo $DEV $MNT

  start=$(date +%s%N)
  rm -f $MNT/foobar
  end=$(date +%s%N)
  dur=$(( (end - start) / 1000000 ))
  echo "rm took $dur milliseconds"

  umount $MNT

Before this change rm took: 7504 milliseconds
After this change rm took:  6574 milliseconds  (-12.4%)

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  8 ++++----
 fs/btrfs/delayed-ref.c | 33 ++++++++++++++++++++-------------
 fs/btrfs/delayed-ref.h | 13 ++++++++++++-
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/extent-tree.c | 10 +++++-----
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/transaction.h |  1 +
 7 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fb506ee51d2c..82c77dbad2e8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1286,7 +1286,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	/* Once for the lookup reference */
 	btrfs_put_block_group(block_group);
 	if (remove_rsv)
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -2709,7 +2709,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 
 		/* Already aborted the transaction if it failed. */
 next:
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
 	}
@@ -3370,7 +3370,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 		if (should_put)
 			btrfs_put_block_group(cache);
 		if (drop_reserve)
-			btrfs_delayed_refs_rsv_release(fs_info, 1);
+			btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		/*
 		 * Avoid blocking other tasks for too long. It might even save
 		 * us from writing caches for block groups that are going to be
@@ -3517,7 +3517,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 		/* If its not on the io list, we need to put the block group */
 		if (should_put)
 			btrfs_put_block_group(cache);
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		spin_lock(&cur_trans->dirty_bgs_lock);
 	}
 	spin_unlock(&cur_trans->dirty_bgs_lock);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 19dd74b236c6..a6680e8756a1 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -57,17 +57,21 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
  * Release a ref head's reservation.
  *
  * @fs_info:  the filesystem
- * @nr:       number of items to drop
+ * @nr_refs:  number of delayed refs to drop
+ * @nr_csums: number of csum items to drop
  *
  * Drops the delayed ref head's count from the delayed refs rsv and free any
  * excess reservation we had.
  */
-void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
+void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr_refs, int nr_csums)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	const u64 num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, nr);
+	u64 num_bytes;
 	u64 released;
 
+	num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, nr_refs);
+	num_bytes += btrfs_calc_delayed_ref_csum_bytes(fs_info, nr_csums);
+
 	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 	if (released)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
@@ -77,8 +81,9 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 /*
  * Adjust the size of the delayed refs rsv.
  *
- * This is to be called anytime we may have adjusted trans->delayed_ref_updates,
- * it'll calculate the additional size and add it to the delayed_refs_rsv.
+ * This is to be called anytime we may have adjusted trans->delayed_ref_updates
+ * or trans->delayed_ref_csum_deletions, it'll calculate the additional size and
+ * add it to the delayed_refs_rsv.
  */
 void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 {
@@ -86,17 +91,19 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
 	u64 num_bytes;
 
-	if (!trans->delayed_ref_updates)
-		return;
+	num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, trans->delayed_ref_updates);
+	num_bytes += btrfs_calc_delayed_ref_csum_bytes(fs_info,
+						       trans->delayed_ref_csum_deletions);
 
-	num_bytes = btrfs_calc_delayed_ref_bytes(fs_info,
-						 trans->delayed_ref_updates);
+	if (num_bytes == 0)
+		return;
 
 	spin_lock(&delayed_rsv->lock);
 	delayed_rsv->size += num_bytes;
 	delayed_rsv->full = false;
 	spin_unlock(&delayed_rsv->lock);
 	trans->delayed_ref_updates = 0;
+	trans->delayed_ref_csum_deletions = 0;
 }
 
 /*
@@ -434,7 +441,7 @@ static inline void drop_delayed_ref(struct btrfs_fs_info *fs_info,
 		list_del(&ref->add_list);
 	btrfs_put_delayed_ref(ref);
 	atomic_dec(&delayed_refs->num_entries);
-	btrfs_delayed_refs_rsv_release(fs_info, 1);
+	btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 }
 
 static bool merge_ref(struct btrfs_fs_info *fs_info,
@@ -710,11 +717,11 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 
 		if (existing->total_ref_mod >= 0 && old_ref_mod < 0) {
 			delayed_refs->pending_csums -= existing->num_bytes;
-			btrfs_delayed_refs_rsv_release(fs_info, csum_leaves);
+			btrfs_delayed_refs_rsv_release(fs_info, 0, csum_leaves);
 		}
 		if (existing->total_ref_mod < 0 && old_ref_mod >= 0) {
 			delayed_refs->pending_csums += existing->num_bytes;
-			trans->delayed_ref_updates += csum_leaves;
+			trans->delayed_ref_csum_deletions += csum_leaves;
 		}
 	}
 
@@ -834,7 +841,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		 */
 		if (head_ref->is_data && head_ref->ref_mod < 0) {
 			delayed_refs->pending_csums += head_ref->num_bytes;
-			trans->delayed_ref_updates +=
+			trans->delayed_ref_csum_deletions +=
 				btrfs_csum_bytes_to_leaves(trans->fs_info,
 							   head_ref->num_bytes);
 		}
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 46a1421cd99d..1bbabfebb329 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -277,6 +277,17 @@ static inline u64 btrfs_calc_delayed_ref_bytes(const struct btrfs_fs_info *fs_in
 	return num_bytes;
 }
 
+static inline u64 btrfs_calc_delayed_ref_csum_bytes(const struct btrfs_fs_info *fs_info,
+						    int num_csum_items)
+{
+	/*
+	 * Deleting csum items does not result in new nodes/leaves and does not
+	 * require changing the free space tree, only the csum tree, so this is
+	 * all we need.
+	 */
+	return btrfs_calc_metadata_size(fs_info, num_csum_items);
+}
+
 static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 				int action, u64 bytenr, u64 len, u64 parent)
 {
@@ -401,7 +412,7 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 
 int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq);
 
-void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr);
+void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr_refs, int nr_csums);
 void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f4fcdbf312f4..bf8dc572b9d2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4609,7 +4609,7 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				list_del(&ref->add_list);
 			atomic_dec(&delayed_refs->num_entries);
 			btrfs_put_delayed_ref(ref);
-			btrfs_delayed_refs_rsv_release(fs_info, 1);
+			btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		}
 		if (head->must_insert_reserved)
 			pin_bytes = true;
@@ -4807,7 +4807,7 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
 
 		spin_unlock(&cur_trans->dirty_bgs_lock);
 		btrfs_put_block_group(cache);
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		spin_lock(&cur_trans->dirty_bgs_lock);
 	}
 	spin_unlock(&cur_trans->dirty_bgs_lock);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 79aa3e68fd34..caef12198cf6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1824,16 +1824,16 @@ u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 	 * to drop the csum leaves for this update from our delayed_refs_rsv.
 	 */
 	if (head->total_ref_mod < 0 && head->is_data) {
-		int nr_items;
+		int nr_csums;
 
 		spin_lock(&delayed_refs->lock);
 		delayed_refs->pending_csums -= head->num_bytes;
 		spin_unlock(&delayed_refs->lock);
-		nr_items = btrfs_csum_bytes_to_leaves(fs_info, head->num_bytes);
+		nr_csums = btrfs_csum_bytes_to_leaves(fs_info, head->num_bytes);
 
-		btrfs_delayed_refs_rsv_release(fs_info, nr_items);
+		btrfs_delayed_refs_rsv_release(fs_info, 0, nr_csums);
 
-		return btrfs_calc_delayed_ref_bytes(fs_info, nr_items);
+		return btrfs_calc_delayed_ref_csum_bytes(fs_info, nr_csums);
 	}
 
 	return 0;
@@ -1985,7 +1985,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 
 		ret = run_one_delayed_ref(trans, ref, extent_op,
 					  must_insert_reserved);
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 		*bytes_released += btrfs_calc_delayed_ref_bytes(fs_info, 1);
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 06050aa520dc..4453d8113b37 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2081,7 +2081,7 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
        struct btrfs_block_group *block_group, *tmp;
 
        list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
-               btrfs_delayed_refs_rsv_release(fs_info, 1);
+               btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
                list_del_init(&block_group->bg_list);
        }
 }
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 8e9fa23bd7fe..474ce34ed02e 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -119,6 +119,7 @@ struct btrfs_trans_handle {
 	u64 bytes_reserved;
 	u64 chunk_bytes_reserved;
 	unsigned long delayed_ref_updates;
+	unsigned long delayed_ref_csum_deletions;
 	struct btrfs_transaction *transaction;
 	struct btrfs_block_rsv *block_rsv;
 	struct btrfs_block_rsv *orig_rsv;
-- 
2.40.1

