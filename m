Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F867B181E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjI1KM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 06:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjI1KM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 06:12:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324CA12A
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 03:12:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57743C433C8
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695895974;
        bh=mg5eVZZ7idum590dUokzkOgAXm3/vFgA/g09MhNYd3o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IytSE2RIgIcPUWAyH7nz28xzuad5iNkUoRxV2ouCGckl2zPK9DEFDU9lhJe3neT4l
         YQjH8P7qiiMx30h2gN91f2KS1xqP63/V3XN8zz0aGhJMoC5X5Lh1Ig6vYMqkBhL514
         /hbDw+7CYe8TaMbQbByAh+DZ+KMiPEzrrAf6up7SX0N5ClNrYJplOR4IUflyqcJmXu
         D36SBlWGKk0rScbzLEegWbtuKBEYJEgy7kg0wolOZBM22YwmIR4LEtKSpNHmHT2hP1
         Ug5Wq7dCtVVhuV7Ic0vmRDjZNwuqR//gYH7KB8QHcNIr0P8wtvKIap77nWMHxIgcHf
         eOuRv4ab2U0EA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: stop reserving excessive space for block group item updates
Date:   Thu, 28 Sep 2023 11:12:49 +0100
Message-Id: <3898346501682e3e3f13eb0eca15bb03131355c7.1695895841.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695895841.git.fdmanana@suse.com>
References: <cover.1695895841.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Space for block group item updates, necessary after allocating or
deallocating an extent from a block group, is reserved in the delayed
refs block reserve. Currently we do this by incrementing the transaction
handle's delayed_ref_updates counter and then calling
btrfs_update_delayed_refs_rsv(), which will increase the size of the
delayed refs block reserve by an amount that corresponds to the same
amount we use for delayed refs, given by btrfs_calc_delayed_ref_bytes().

That is an excessive amount because it corresponds to the amount of space
needed to insert one item in a btree (btrfs_calc_insert_metadata_size())
times 2 when the free space tree feature is enabled. All we need is an
amount as given by btrfs_calc_metadata_size(), since we only need to
update an existing block group item in the extent tree (or block group
tree if this feature is enabled). By using btrfs_calc_metadata_size() we
will need to reserve 4 times less space when using the free space tree
and 2 times less space when not using it, putting less pressure on space
reservation.

So use helpers to reserve and release space for block group item updates
that use btrfs_calc_metadata_size() for calculation of the space.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 12 +++++++-----
 fs/btrfs/delayed-ref.c | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/disk-io.c     |  2 +-
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6e2a4000bfe0..9d17b0580fbf 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1286,7 +1286,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	/* Once for the lookup reference */
 	btrfs_put_block_group(block_group);
 	if (remove_rsv)
-		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+		btrfs_dec_delayed_refs_rsv_bg_updates(fs_info);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -3369,7 +3369,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 		if (should_put)
 			btrfs_put_block_group(cache);
 		if (drop_reserve)
-			btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+			btrfs_dec_delayed_refs_rsv_bg_updates(fs_info);
 		/*
 		 * Avoid blocking other tasks for too long. It might even save
 		 * us from writing caches for block groups that are going to be
@@ -3516,7 +3516,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 		/* If its not on the io list, we need to put the block group */
 		if (should_put)
 			btrfs_put_block_group(cache);
-		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+		btrfs_dec_delayed_refs_rsv_bg_updates(fs_info);
 		spin_lock(&cur_trans->dirty_bgs_lock);
 	}
 	spin_unlock(&cur_trans->dirty_bgs_lock);
@@ -3545,6 +3545,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_block_group *cache;
 	u64 old_val;
 	bool reclaim = false;
+	bool bg_already_dirty = true;
 	int factor;
 
 	/* Block accounting for super block */
@@ -3613,7 +3614,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	spin_lock(&trans->transaction->dirty_bgs_lock);
 	if (list_empty(&cache->dirty_list)) {
 		list_add_tail(&cache->dirty_list, &trans->transaction->dirty_bgs);
-		trans->delayed_ref_updates++;
+		bg_already_dirty = false;
 		btrfs_get_block_group(cache);
 	}
 	spin_unlock(&trans->transaction->dirty_bgs_lock);
@@ -3633,7 +3634,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	btrfs_put_block_group(cache);
 
 	/* Modified block groups are accounted for in the delayed_refs_rsv. */
-	btrfs_update_delayed_refs_rsv(trans);
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(info);
 
 	return 0;
 }
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 25d0cdf85a91..a7feef155ded 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -125,6 +125,41 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	trans->delayed_ref_csum_deletions = 0;
 }
 
+/*
+ * Adjust the size of the delayed refs block reserve for 1 block group item
+ * update.
+ */
+void btrfs_inc_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
+
+	spin_lock(&delayed_rsv->lock);
+	/*
+	 * Updating a block group item does not result in new nodes/leaves and
+	 * does not require changing the free space tree, only the extent tree
+	 * or the block group tree, so this is all we need.
+	 */
+	delayed_rsv->size += btrfs_calc_metadata_size(fs_info, 1);
+	delayed_rsv->full = false;
+	spin_unlock(&delayed_rsv->lock);
+}
+
+/*
+ * Adjust the size of the delayed refs block reserve to release space for 1
+ * block group item update.
+ */
+void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
+	const u64 num_bytes = btrfs_calc_metadata_size(fs_info, 1);
+	u64 released;
+
+	released = btrfs_block_rsv_release(fs_info, delayed_rsv, num_bytes, NULL);
+	if (released > 0)
+		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
+					      0, released, 0);
+}
+
 /*
  * Transfer bytes to our delayed refs rsv.
  *
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 783f84c9f2f4..3d2c455fd9b0 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -420,6 +420,8 @@ int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq);
 
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr_refs, int nr_csums);
 void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
+void btrfs_inc_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
+void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc577b3c53f6..f0864d016ceb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4785,7 +4785,7 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
 
 		spin_unlock(&cur_trans->dirty_bgs_lock);
 		btrfs_put_block_group(cache);
-		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+		btrfs_dec_delayed_refs_rsv_bg_updates(fs_info);
 		spin_lock(&cur_trans->dirty_bgs_lock);
 	}
 	spin_unlock(&cur_trans->dirty_bgs_lock);
-- 
2.40.1

