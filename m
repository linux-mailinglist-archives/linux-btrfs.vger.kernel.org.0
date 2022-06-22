Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA7C55489A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbiFVJh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiFVJhz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 05:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3803969B
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 02:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAFA061A27
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C7C34114
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655890669;
        bh=CyVYmh0RYhi1Wz6SKHguOKr6RFxZAcR6A2IE+PtLur4=;
        h=From:To:Subject:Date:From;
        b=tqXCfQ3D8WoUqfuUxZLbofLLacPW8Rae3fjMxY5mp65U6mefo6PWJGjdNV604so9K
         DOuMKs95KexV92LtP9rctrM7B0HOQN3I64bOQU+6rYs3uOi2mVZkso9bJZI/jgZzuJ
         RcmpU2Ppy54fW2ZoUAwkH3fcMTaLy3U58DXTkZGCL+MnFDb4dMuupiJTAskfaEImPI
         EzbH+0QU6lohzs7LpaB+hUBiL0xbgeQf9aZFddno/HG6Xy9tVhHdMbJqUKbkCJxPSn
         ckl9MS2H+XoDzYOnFXDkXu18ip5jMPqDCItW7/fYWIOf2/wEQs7qzcOOwXwgiBiisH
         cm0+t7MTEBXQw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: reduce amount of reserved metadata for delayed item insertion
Date:   Wed, 22 Jun 2022 10:37:45 +0100
Message-Id: <9290acc4c095b2191f33637948d8020b90ff302d.1655889343.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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
Signed-off-by: David Sterba <dsterba@suse.com>
---

V2: Fixed an underflow on the size of the delayed block reserve's size,
    which was caused by computing the number of leaves used by diving
    the total dir index item byte size by the maximum leaf data size.
    That computation works most of the time, but often its result is
    not correct. For example for a leaf size of 4K, we have a max leaf
    data size of 3995 bytes, and if we have 117 dir index items to
    insert, each with a size of 68 bytes, then we had:

    (117 * 68) / 3995 = 1.99, rounded up to 2

    But that resulted in inserting 3 batches (use 3 leaves) and not 2:

    1) First batch with 58 items, total size of 3944 bytes;
    2) Second batch with another 58 items, total size of 3944 bytes;
    3) Third batch with a single item, total size of 68 bytes.

    This resulted in releasing space for a leaf that was never reserved,
    and whence the underflow on the size of the delayed block reserve.
    In practice that is actually very rare, because our limit on the
    number of pending delayed items makes us flush delayed items before
    we have enough items to cover more than 1 leaf, even with a leaf
    size of 4K. This was initially reported by the lkp test robot at:

    https://lore.kernel.org/linux-btrfs/20220608152303.GB31193@xsang-OptiPlex-9020/

    It could also be sporadically triggered by generic/619.

    Also added missing tracepoints when releasing space from the delayed
    block reserve and the transaction block reserve.

 fs/btrfs/delayed-inode.c | 157 +++++++++++++++++++++++++++++++++++----
 fs/btrfs/delayed-inode.h |  11 +++
 2 files changed, 154 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index f69c8db9e4c8..d0068c80e4b0 100644
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
@@ -566,6 +572,21 @@ static void btrfs_delayed_item_release_metadata(struct btrfs_root *root,
 	btrfs_block_rsv_release(fs_info, rsv, item->bytes_reserved, NULL);
 }
 
+static void btrfs_delayed_item_release_leaves(struct btrfs_delayed_node *node,
+					      unsigned int num_leaves)
+{
+	struct btrfs_fs_info *fs_info = node->root->fs_info;
+	const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, num_leaves);
+
+	/* There are no space reservations during log replay, bail out. */
+	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+		return;
+
+	trace_btrfs_space_reservation(fs_info, "delayed_item", node->inode_id,
+				      bytes, 0);
+	btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv, bytes, NULL);
+}
+
 static int btrfs_delayed_inode_reserve_metadata(
 					struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
@@ -653,15 +674,27 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
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
@@ -675,6 +708,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		if (!next)
 			break;
 
+		ASSERT(next->bytes_reserved == 0);
+
 		next_size = next->data_len + sizeof(struct btrfs_item);
 		if (total_size + next_size > max_size)
 			break;
@@ -731,9 +766,31 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_release_path(path);
 
+	ASSERT(node->index_item_leaves > 0);
+
+	if (next) {
+		/*
+		 * We inserted one batch of items into a leaf a there are more
+		 * items to flush in a future batch, now release one unit of
+		 * metadata space from the delayed block reserve, corresponding
+		 * the leaf we just flushed to.
+		 */
+		btrfs_delayed_item_release_leaves(node, 1);
+		node->index_item_leaves--;
+	} else {
+		/*
+		 * There are no more items to insert. We can have a number of
+		 * reserved leaves > 1 here - this happens when many dir index
+		 * items are added and then removed before they are flushed (file
+		 * names with a very short life, never span a transaction). So
+		 * release all remaining leaves.
+		 */
+		btrfs_delayed_item_release_leaves(node, node->index_item_leaves);
+		node->index_item_leaves = 0;
+	}
+
 	list_for_each_entry_safe(curr, next, &item_list, tree_list) {
 		list_del(&curr->tree_list);
-		btrfs_delayed_item_release_metadata(root, curr);
 		btrfs_release_delayed_item(curr);
 	}
 out:
@@ -1334,9 +1391,13 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   struct btrfs_disk_key *disk_key, u8 type,
 				   u64 index)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	const unsigned int leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_item *delayed_item;
 	struct btrfs_dir_item *dir_item;
+	bool reserve_leaf_space;
+	u32 data_len;
 	int ret;
 
 	delayed_node = btrfs_get_or_create_delayed_node(dir);
@@ -1362,17 +1423,51 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
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
+
+	if (delayed_node->index_item_leaves == 0 ||
+	    delayed_node->curr_index_batch_size + data_len > leaf_data_size) {
+		delayed_node->curr_index_batch_size = data_len;
+		reserve_leaf_space = true;
+	} else {
+		delayed_node->curr_index_batch_size += data_len;
+		reserve_leaf_space = false;
+	}
+
+	if (reserve_leaf_space) {
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
+
+		delayed_node->index_item_leaves++;
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
+		trace_btrfs_space_reservation(fs_info, "transaction",
+					      trans->transid, bytes, 0);
+		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
+		ASSERT(trans->bytes_reserved >= bytes);
+		trans->bytes_reserved -= bytes;
+	}
+
 	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
@@ -1401,8 +1496,37 @@ static int btrfs_delete_delayed_insertion_item(struct btrfs_fs_info *fs_info,
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
+	ASSERT(node->index_item_leaves > 0);
+
+	/*
+	 * If there's only one leaf reserved, we can decrement this item from the
+	 * current batch, otherwise we can not because we don't know which leaf
+	 * it belongs to. With the current limit on delayed items, we rarely
+	 * accumulate enough dir index items to fill more than one leaf (even
+	 * when using a leaf size of 4K).
+	 */
+	if (node->index_item_leaves == 1) {
+		const u32 data_len = item->data_len + sizeof(struct btrfs_item);
+
+		ASSERT(node->curr_index_batch_size >= data_len);
+		node->curr_index_batch_size -= data_len;
+	}
+
 	btrfs_release_delayed_item(item);
+
+	/* If we now have no more dir index items, we can release all leaves. */
+	if (RB_EMPTY_ROOT(&node->ins_root.rb_root)) {
+		btrfs_delayed_item_release_leaves(node, node->index_item_leaves);
+		node->index_item_leaves = 0;
+	}
+
 	mutex_unlock(&node->mutex);
 	return 0;
 }
@@ -1818,12 +1942,17 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
 	mutex_lock(&delayed_node->mutex);
 	curr_item = __btrfs_first_delayed_insertion_item(delayed_node);
 	while (curr_item) {
-		btrfs_delayed_item_release_metadata(root, curr_item);
 		prev_item = curr_item;
 		curr_item = __btrfs_next_delayed_item(prev_item);
 		btrfs_release_delayed_item(prev_item);
 	}
 
+	if (delayed_node->index_item_leaves > 0) {
+		btrfs_delayed_item_release_leaves(delayed_node,
+					  delayed_node->index_item_leaves);
+		delayed_node->index_item_leaves = 0;
+	}
+
 	curr_item = __btrfs_first_delayed_deletion_item(delayed_node);
 	while (curr_item) {
 		btrfs_delayed_item_release_metadata(root, curr_item);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index b2412160c5bc..9795dc295a18 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -58,6 +58,17 @@ struct btrfs_delayed_node {
 	u64 index_cnt;
 	unsigned long flags;
 	int count;
+	/*
+	 * The size of the next batch of dir index items to insert (if this
+	 * node is from a directory inode). Protected by @mutex.
+	 */
+	u32 curr_index_batch_size;
+	/*
+	 * Number of leaves reserved for inserting dir index items (if this
+	 * node belongs to a directory inode). This may be larger then the
+	 * actual number of leaves we end up using. Protected by @mutex.
+	 */
+	u32 index_item_leaves;
 };
 
 struct btrfs_delayed_item {
-- 
2.35.1

