Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D815539397
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbiEaPG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbiEaPG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1077E10D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0DA26133A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C264C3411D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009614;
        bh=Ei/+bgeMAVDsrY4YNx9o2G8X8WZ407OCMceWhy38Dzo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GSiIZKxh1XGdHtM6v4UeSRxqLp10JpLyoqKO9XjLbcKfeFD1iFZiP36Gz7oh2rCM+
         KZyWdbDf7Rm4yXj+pabcgC0BWT7UOLN62IQfKpaEAqzj5lPmmcILxPObcmceaDIEBK
         RtLMZ67eJuwDItTJcKlzUtx5o+ZkUpLJMSiIXayTnbeKVz7L/8D1HZRKMtIAzzI7Ws
         I2nttnNKmycUdDVbqPFx4LK3xcoRAYKd7S/HDMJGnn1Be+FOwvNvRrVaxmHRrpPV5t
         3xW6ATJTm/xa3t3TgT2nnOIYeH6mwa0rQKiSVHOrJRM2q56eth2Jvdf8Lu7SN6DWot
         KZlv7tDSa0NVg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/12] btrfs: improve batch deletion of delayed dir index items
Date:   Tue, 31 May 2022 16:06:38 +0100
Message-Id: <ddec7fd521fe5b0158241a2e111a54bab253f6d3.1654009356.git.fdmanana@suse.com>
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

Currently we group delayed dir index items for deletion in a single batch
(single btree operation) as long as they all exist in the same leaf and as
long as their keys are sequential in the key space. For example if we have
a leaf that has dir index items with offsets:

    2, 3, 4, 6, 7, 10

And we have delayed dir index items for deleting all these indexes, and
no delayed items for any other index keys in between, then we end up
deleting in 3 batches:

1) First batch for indexes 2, 3 and 4;
2) Second batch for indexes 6 and 7;
3) Third batch for index 10.

This is a waste because we can delete all the index keys in a single
batch. What matters is that each consecutive delayed index key matches
each consecutive dir index key in a leaf.

So update the logic at btrfs_batch_delete_items() to check only for a
key match between delayed dir index items and dir index items in a leaf.
Also avoid the useless first iteration on comparing the key of the
first slot to delete with the key of the first delayed item, as it's
silly since they always match, as the delayed item's key was used for
the btree search that gaves us the path we have.

This is more efficient and reduces runtime of running delayed items, as
well as lock contention on the subvolume's tree.

For example, the following test script:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  NUM_FILES=1000

  mkdir $MNT/testdir
  for ((i = 1; i <= $NUM_FILES; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  # Now delete every other file, to create gaps in the dir index keys.
  for ((i = 1; i <= $NUM_FILES; i += 2)); do
      rm -f $MNT/testdir/file_$i
  done

  # Sync to force any delayed items to be flushed to the tree.
  sync

  start=$(date +%s%N)
  rm -fr $MNT/testdir
  end=$(date +%s%N)
  dur=$(( (end - start) / 1000000 ))

  echo -e "\nrm -fr took $dur milliseconds"

  umount $MNT

Running that test script while having the following bpftrace script
running in another shell:

  $ cat bpf-measure.sh
  #!/usr/bin/bpftrace

  /* Add 'noinline' to btrfs_delete_delayed_items()'s definition. */
  k:btrfs_delete_delayed_items
  {
      @start_delete_delayed_items[tid] = nsecs;
  }

  k:btrfs_del_items
  /@start_delete_delayed_items[tid]/
  {
      @delete_batches = count();
  }

  kr:btrfs_delete_delayed_items
  /@start_delete_delayed_items[tid]/
  {
      $dur = (nsecs - @start_delete_delayed_items[tid]) / 1000;
      @btrfs_delete_delayed_items_total_time = sum($dur);
      delete(@start_delete_delayed_items[tid]);
  }

Before this change:

@btrfs_delete_delayed_items_total_time: 9563
@delete_batches: 1001

After this change:

@btrfs_delete_delayed_items_total_time: 7328
@delete_batches: 509

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 60 +++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0125586fd565..74c806d3ab2a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -791,68 +791,58 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_delayed_item *curr, *next;
 	struct extent_buffer *leaf = path->nodes[0];
-	struct btrfs_key key;
-	struct list_head head;
-	int nitems, i, last_item;
-	int ret = 0;
+	LIST_HEAD(batch_list);
+	int nitems, slot, last_slot;
+	int ret;
 
 	ASSERT(leaf != NULL);
 
-	i = path->slots[0];
-	last_item = btrfs_header_nritems(leaf) - 1;
+	slot = path->slots[0];
+	last_slot = btrfs_header_nritems(leaf) - 1;
 	/*
 	 * Our caller always gives us a path pointing to an existing item, so
 	 * this can not happen.
 	 */
-	ASSERT(i <= last_item);
-	if (WARN_ON(i > last_item))
+	ASSERT(slot <= last_slot);
+	if (WARN_ON(slot > last_slot))
 		return -ENOENT;
 
-	next = item;
-	INIT_LIST_HEAD(&head);
-	btrfs_item_key_to_cpu(leaf, &key, i);
-	nitems = 0;
+	nitems = 1;
+	curr = item;
+	list_add_tail(&curr->tree_list, &batch_list);
+
 	/*
-	 * count the number of the dir index items that we can delete in batch
+	 * Keep checking if the next delayed item matches the next item in the
+	 * leaf - if so, we can add it to the batch of items to delete from the
+	 * leaf.
 	 */
-	while (btrfs_comp_cpu_keys(&next->key, &key) == 0) {
-		list_add_tail(&next->tree_list, &head);
-		nitems++;
+	while (slot < last_slot) {
+		struct btrfs_key key;
 
-		curr = next;
 		next = __btrfs_next_delayed_item(curr);
 		if (!next)
 			break;
 
-		if (!btrfs_is_continuous_delayed_item(curr, next))
+		slot++;
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		if (btrfs_comp_cpu_keys(&next->key, &key) != 0)
 			break;
-
-		i++;
-		if (i > last_item)
-			break;
-		btrfs_item_key_to_cpu(leaf, &key, i);
+		nitems++;
+		curr = next;
+		list_add_tail(&curr->tree_list, &batch_list);
 	}
 
-	/*
-	 * Our caller always gives us a path pointing to an existing item, so
-	 * this can not happen.
-	 */
-	ASSERT(nitems >= 1);
-	if (nitems < 1)
-		return -ENOENT;
-
 	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
 	if (ret)
-		goto out;
+		return ret;
 
-	list_for_each_entry_safe(curr, next, &head, tree_list) {
+	list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
 		btrfs_delayed_item_release_metadata(root, curr);
 		list_del(&curr->tree_list);
 		btrfs_release_delayed_item(curr);
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
-- 
2.35.1

