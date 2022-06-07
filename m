Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB125393A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbiEaPHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbiEaPHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:07:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF8BCD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A248B80FB3
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0EDC385A9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009618;
        bh=zhPJ9icXBExZLmUpKL6ZXPlmLo5FOiOgfjyVHfvy4jA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HxdFNSBughZoheGu1lYxwGZ9/2y8hGaArr2YDijDS6ISeIVbhPt6QeujXEYJxrzMU
         YxHqIWTHIx3NKg35nssJObNj7muO6OOysDMvclsUSgblC2RhOXq+o6rrYrCJ3twddc
         WroE1Bt6MnUdO2hojOShPDDY2XX0YrWYOpfqMsyrB1Gx8jCGduoWUaRJs19R4JAo/Y
         oZxM1T+rNpHKSfxcFXs2G5g8rBkoJqZ8tCQl9ROB2bQCf0EeQu0j/y+u2oShcTWi1D
         kzgBmjIuNQbjDUqgZYP62ZGJBs9T+O+1x7gVW3Hw3BWjmW/IMYyEKoLpnDuwLoJobu
         cZAO+LLIKQ+zQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/12] btrfs: reduce amount of reserved metadata for delayed item insertion
Date:   Tue, 31 May 2022 16:06:43 +0100
Message-Id: <bf924988687205627604f36cbd8ff13936e938ab.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Whenever we want to create a new dir index item (when creating an inode,
create a hard link, rename a file) we reserve 1 unit of metadata space
for it in a transaction (that's 256K for a node/leaf size of 16K), and
then create a delayed insertion item for it to be added later to the
subvolume's tree. That unit of metadata is kept until the delayed item
is inserted into the subvolume tree, which may take a while to happen
(in the worst case, it's done only when the transaction commits). If we
have multiple dir index items to insert for the same directory, say N
index items, and they all fit in a single leaf of metadata, then we are
holding N units of reserved metadata space when all we need is 1 unit.

This change addresses that, whenever a new delayed dir index item is
added, we release the unit of metadata the caller has reserved when it
started the transaction if adding that new dir index item does not
result in touching one more metadata leaf, otherwise the reservation
is kept by transferring it from the transaction block reserve to the
delayed items block reserve, just like before. Given that with a leaf
size of 16K we can have a few hundred dir index items in a single leaf
(the exact value depends on file name lengths), this reduces pressure on
metadata reservation by releasing unnecessary space much sooner.

The following fs_mark test showed some improvement when creating many
files in parallel on machine running a non debug kernel (debian's default
kernel config) with 12 cores:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1
  MOUNT_OPTIONS="-o ssd"
  FILES=100000
  THREADS=$(nproc --all)

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  mkfs.btrfs -f $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  OPTS="-S 0 -L 10 -n $FILES -s 0 -t $THREADS -k"
  for ((i = 1; i <= $THREADS; i++)); do
      OPTS="$OPTS -d $MNT/d$i"
  done

  fs_mark $OPTS

  umount $MNT

Before:

FSUse%        Count         Size    Files/sec     App Overhead
     2      1200000            0     225991.3          5465891
     4      2400000            0     345728.1          5512106
     4      3600000            0     346959.5          5557653
     8      4800000            0     329643.0          5587548
     8      6000000            0     312657.4          5606717
     8      7200000            0     281707.5          5727985
    12      8400000            0      88309.8          5020422
    12      9600000            0      85835.9          5207496
    16     10800000            0      81039.2          5404964
    16     12000000            0      58548.6          5842468

After:

FSUse%        Count         Size    Files/sec     App Overhead
     2      1200000            0     230604.5          5778375
     4      2400000            0     348908.3          5508072
     4      3600000            0     357028.7          5484337
     6      4800000            0     342898.3          5565703
     6      6000000            0     314670.8          5751555
     8      7200000            0     282548.2          5778177
    12      8400000            0      90844.9          5306819
    12      9600000            0      86963.1          5304689
    16     10800000            0      89113.2          5455248
    16     12000000            0      86693.5          5518933

The "after" results are after applying this patch and all the other
patches in the same patchset, which is comprised of the following
changes:

  btrfs: balance btree dirty pages and delayed items after a rename
  btrfs: free the path earlier when creating a new inode
  btrfs: balance btree dirty pages and delayed items after clone and dedupe
  btrfs: add assertions when deleting batches of delayed items
  btrfs: deal with deletion errors when deleting delayed items
  btrfs: refactor the delayed item deletion entry point
  btrfs: improve batch deletion of delayed dir index items
  btrfs: assert that delayed item is a dir index item when adding it
  btrfs: improve batch insertion of delayed dir index items
  btrfs: do not BUG_ON() on failure to reserve metadata for delayed item
  btrfs: set delayed item type when initializing it
  btrfs: reduce amount of reserved metadata for delayed item insertion

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 151 +++++++++++++++++++++++++++++++++++----
 fs/btrfs/delayed-inode.h |   7 ++
 2 files changed, 144 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 814c20c90fe7..fedbc45b71a2 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -540,7 +540,13 @@ static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
 		trace_btrfs_space_reservation(fs_info, "delayed_item",
 					      item->key.objectid,
 					      num_bytes, 1);
-		item->bytes_reserved = num_bytes;
+		/*
+		 * For insertions we track reserved metadata space by accounting
+		 * for the number of leaves that will be used, based on the delayed
+		 * node's index_items_size field.
+		 */
+		if (item->ins_or_del == BTRFS_DELAYED_DELETION_ITEM)
+			item->bytes_reserved = num_bytes;
 	}
 
 	return ret;
@@ -653,15 +659,27 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_path *path,
 				     struct btrfs_delayed_item *first_item)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_delayed_node *node = first_item->delayed_node;
 	LIST_HEAD(item_list);
 	struct btrfs_delayed_item *curr;
 	struct btrfs_delayed_item *next;
-	const int max_size = BTRFS_LEAF_DATA_SIZE(root->fs_info);
+	const int max_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_item_batch batch;
 	int total_size;
 	char *ins_data = NULL;
 	int ret;
 
+	lockdep_assert_held(&node->mutex);
+
+	/*
+	 * For delayed items to insert, we track reserved metadata bytes based
+	 * on the number of leaves that we will use.
+	 * See btrfs_insert_delayed_dir_index() and
+	 * btrfs_delayed_item_reserve_metadata()).
+	 */
+	ASSERT(first_item->bytes_reserved == 0);
+
 	list_add_tail(&first_item->tree_list, &item_list);
 	batch.total_data_size = first_item->data_len;
 	batch.nr = 1;
@@ -675,6 +693,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		if (!next)
 			break;
 
+		ASSERT(next->bytes_reserved == 0);
+
 		next_size = next->data_len + sizeof(struct btrfs_item);
 		if (total_size + next_size > max_size)
 			break;
@@ -733,9 +753,20 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 	list_for_each_entry_safe(curr, next, &item_list, tree_list) {
 		list_del(&curr->tree_list);
-		btrfs_delayed_item_release_metadata(root, curr);
 		btrfs_release_delayed_item(curr);
 	}
+
+	/*
+	 * We inserted one batch of items into a leaf, now release one unit of
+	 * metadata space from the delayed block reserve.
+	 */
+	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+		btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
+					btrfs_calc_insert_metadata_size(fs_info, 1),
+					NULL);
+
+	ASSERT(node->index_items_size >= total_size);
+	node->index_items_size -= total_size;
 out:
 	kfree(ins_data);
 	return ret;
@@ -1327,6 +1358,23 @@ void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info)
 	btrfs_wq_run_delayed_node(delayed_root, fs_info, BTRFS_DELAYED_BATCH);
 }
 
+/*
+ * Return how many leaves of metadata we will use for inserting a given amount
+ * (in bytes) of dir index items (including sizeof struct btrfs_item).
+ */
+static unsigned int num_dir_index_leaves(const struct btrfs_fs_info *fs_info,
+					 u32 index_items_size)
+{
+	const unsigned int leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
+	unsigned int result;
+
+	result = index_items_size / leaf_data_size;
+	if ((index_items_size % leaf_data_size) != 0)
+		result++;
+
+	return result;
+}
+
 /* Will return 0 or -ENOMEM */
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
@@ -1334,9 +1382,13 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   struct btrfs_disk_key *disk_key, u8 type,
 				   u64 index)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_item *delayed_item;
 	struct btrfs_dir_item *dir_item;
+	unsigned int leaves_before;
+	unsigned int leaves_after;
+	u32 data_len;
 	int ret;
 
 	delayed_node = btrfs_get_or_create_delayed_node(dir);
@@ -1362,17 +1414,46 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_dir_type(dir_item, type);
 	memcpy((char *)(dir_item + 1), name, name_len);
 
-	ret = btrfs_delayed_item_reserve_metadata(trans, dir->root, delayed_item);
-	/*
-	 * Space was reserved for a dir index item insertion when we started the
-	 * transaction, so getting a failure here should be impossible.
-	 */
-	if (WARN_ON(ret)) {
-		btrfs_release_delayed_item(delayed_item);
-		goto release_node;
-	}
+	data_len = delayed_item->data_len + sizeof(struct btrfs_item);
 
 	mutex_lock(&delayed_node->mutex);
+	leaves_before = num_dir_index_leaves(fs_info,
+					     delayed_node->index_items_size);
+	leaves_after = num_dir_index_leaves(fs_info,
+					    delayed_node->index_items_size +
+					    data_len);
+
+	ASSERT(leaves_after >= leaves_before);
+	ASSERT((leaves_after - leaves_before) <= 1);
+
+	if (leaves_after > leaves_before) {
+		ret = btrfs_delayed_item_reserve_metadata(trans, dir->root,
+							  delayed_item);
+		/*
+		 * Space was reserved for a dir index item insertion when we
+		 * started the transaction, so getting a failure here should be
+		 * impossible.
+		 */
+		if (WARN_ON(ret)) {
+			mutex_unlock(&delayed_node->mutex);
+			btrfs_release_delayed_item(delayed_item);
+			goto release_node;
+		}
+	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
+		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+
+		/*
+		 * Adding the new dir index item does not require touching another
+		 * leaf, so we can release 1 unit of metadata that was previously
+		 * reserved when starting the transaction. This applies only to
+		 * the case where we had a transaction start and excludes the
+		 * transaction join case (when replaying log trees).
+		 */
+		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
+		ASSERT(trans->bytes_reserved >= bytes);
+		trans->bytes_reserved -= bytes;
+	}
+
 	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
@@ -1381,6 +1462,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 			  delayed_node->inode_id, ret);
 		BUG();
 	}
+	delayed_node->index_items_size += data_len;
 	mutex_unlock(&delayed_node->mutex);
 
 release_node:
@@ -1393,6 +1475,9 @@ static int btrfs_delete_delayed_insertion_item(struct btrfs_fs_info *fs_info,
 					       struct btrfs_key *key)
 {
 	struct btrfs_delayed_item *item;
+	unsigned int leaves_before;
+	unsigned int leaves_after;
+	u32 data_len;
 
 	mutex_lock(&node->mutex);
 	item = __btrfs_lookup_delayed_insertion_item(node, key);
@@ -1401,7 +1486,32 @@ static int btrfs_delete_delayed_insertion_item(struct btrfs_fs_info *fs_info,
 		return 1;
 	}
 
-	btrfs_delayed_item_release_metadata(node->root, item);
+	/*
+	 * For delayed items to insert, we track reserved metadata bytes based
+	 * on the number of leaves that we will use.
+	 * See btrfs_insert_delayed_dir_index() and
+	 * btrfs_delayed_item_reserve_metadata()).
+	 */
+	ASSERT(item->bytes_reserved == 0);
+
+	data_len = item->data_len + sizeof(struct btrfs_item);
+	ASSERT(node->index_items_size >= data_len);
+
+	leaves_before = num_dir_index_leaves(fs_info, node->index_items_size);
+	node->index_items_size -= data_len;
+	leaves_after = num_dir_index_leaves(fs_info, node->index_items_size);
+
+	ASSERT(leaves_after <= leaves_before);
+	ASSERT((leaves_before - leaves_after) <= 1);
+
+	if (leaves_after < leaves_before &&
+	    !test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
+		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+
+		btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
+					bytes, NULL);
+	}
+
 	btrfs_release_delayed_item(item);
 	mutex_unlock(&node->mutex);
 	return 0;
@@ -1818,12 +1928,25 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
 	mutex_lock(&delayed_node->mutex);
 	curr_item = __btrfs_first_delayed_insertion_item(delayed_node);
 	while (curr_item) {
-		btrfs_delayed_item_release_metadata(root, curr_item);
 		prev_item = curr_item;
 		curr_item = __btrfs_next_delayed_item(prev_item);
 		btrfs_release_delayed_item(prev_item);
 	}
 
+	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
+	    delayed_node->index_items_size > 0) {
+		unsigned int num_leaves;
+		u64 bytes;
+
+		num_leaves = num_dir_index_leaves(fs_info,
+						  delayed_node->index_items_size);
+		bytes = btrfs_calc_insert_metadata_size(fs_info, num_leaves);
+
+		btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
+					bytes, NULL);
+	}
+	delayed_node->index_items_size = 0;
+
 	curr_item = __btrfs_first_delayed_deletion_item(delayed_node);
 	while (curr_item) {
 		btrfs_delayed_item_release_metadata(root, curr_item);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index b2412160c5bc..2af0d8227479 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -55,6 +55,13 @@ struct btrfs_delayed_node {
 	struct mutex mutex;
 	struct btrfs_inode_item inode_item;
 	refcount_t refs;
+	/*
+	 * The sum of the sizes of all index items we will be inserting for
+	 * this inode (if it represents a directory), including the size of
+	 * struct btrfs_item. 32 bits is enough, as we flush delayed items
+	 * way before reaching the 32 bits limit. Protected by @mutex.
+	 */
+	u32 index_items_size;
 	u64 index_cnt;
 	unsigned long flags;
 	int count;
-- 
2.35.1

