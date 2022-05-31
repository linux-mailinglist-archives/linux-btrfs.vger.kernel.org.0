Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42123539396
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbiEaPHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbiEaPG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A08E2645
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F5F61342
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A60C385A9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009616;
        bh=MUukdcZyVAuy2Ta3voG6NfNhtk0zU8Z3WlY/Dyy2KZg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MXFsHw9uklSNl+9oQEuiXxPMNd/uQTgFnqh4cs3dgnyy82nvx8i+FOz/H/QUspWI+
         LxS2Gt1tv+ZX8m7tV1KyxjlVmhaxLRx5+06Yo8wPhjPCiGMbYk2Uh+0CNO6UPfAW9u
         cL6ZwBghtL184XuU6s+6EeUrj98IdpIEIl0HK+aNDQHXYff9aDIsBasYzEcm6KuIDn
         92BAvZRN7QGcNr5nhm+qvZ6ECLjrnR25kXOMiNM9b9pox3KCeEvXb74OkUeuifnl/z
         eUj3a+FtSc+eIsLFga6VHer1CxfDfqWI3v70F0FEdoRtsZpyrLD5iw0DzL1i+hZtMd
         VfULqb7DXC5Tw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: improve batch insertion of delayed dir index items
Date:   Tue, 31 May 2022 16:06:40 +0100
Message-Id: <c1fa57f1288d8fa3162eb7761b12b60d518096e4.1654009356.git.fdmanana@suse.com>
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

Currently we group delayed dir index items for insertion as a single batch
(a single btree operation) as long as their keys are sequential in the key
space.

For example we have delayed index items for the following index keys:

   10, 11, 12, 15, 16, 20, 21

We end up building three batches:

1) First one for index keys 10, 11 and 12;
2) Second one for index keys 15 and 16;
3) Third one for index keys 20 and 21.

However, since the dir index numbers come from a monotonically increasing
counter and are never reused, we could group all these items into a single
batch. The existence of holes in the sequence happens only when we had
delayed dir index items for insertion that got deleted before they were
flushed to the subvolume's tree.

The delayed items are stored in a rbtree based on their key order, so
we can just group items into a batch as long as they all fit in a leaf,
and ignore if there's a gap (key offset, index number) between two
consecutive items. This is more efficient and reduces the amount of
time spent when running delayed items if there are gaps between dir
index items.

For example running the following test script:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  NUM_FILES=100

  mkdir $MNT/testdir
  for ((i = 1; i <= $NUM_FILES; i++)); do
       echo -n > $MNT/testdir/file_$i
  done

  # Now delete every other file, to create gaps in the dir index keys.
  for ((i = 1; i <= $NUM_FILES; i += 2)); do
      rm -f $MNT/testdir/file_$i
  done

  start=$(date +%s%N)
  sync
  end=$(date +%s%N)
  dur=$(( (end - start) / 1000000 ))

  echo -e "\nsync took $dur milliseconds"

  umount $MNT

While having the following bpftrace script running in another shell:

  $ cat bpf-delayed-items-inserts.sh
  #!/usr/bin/bpftrace

  /* Must add 'noinline' to btrfs_insert_delayed_items(). */
  k:btrfs_insert_delayed_items
  {
      @start_insert_delayed_items[tid] = nsecs;
  }

  k:btrfs_insert_empty_items
  /@start_insert_delayed_items[tid]/
  {
     @insert_batches = count();
  }

  kr:btrfs_insert_delayed_items
  /@start_insert_delayed_items[tid]/
  {
      $dur = (nsecs - @start_insert_delayed_items[tid]) / 1000;
      @btrfs_insert_delayed_items_total_time = sum($dur);
      delete(@start_insert_delayed_items[tid]);
  }

Before this change:

@btrfs_insert_delayed_items_total_time: 576
@insert_batches: 51

After this change:

@btrfs_insert_delayed_items_total_time: 174
@insert_batches: 2

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index addffd7719fc..2ad2a105244c 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -52,18 +52,6 @@ static inline void btrfs_init_delayed_node(
 	INIT_LIST_HEAD(&delayed_node->p_list);
 }
 
-static inline int btrfs_is_continuous_delayed_item(
-					struct btrfs_delayed_item *item1,
-					struct btrfs_delayed_item *item2)
-{
-	if (item1->key.type == BTRFS_DIR_INDEX_KEY &&
-	    item1->key.objectid == item2->key.objectid &&
-	    item1->key.type == item2->key.type &&
-	    item1->key.offset + 1 == item2->key.offset)
-		return 1;
-	return 0;
-}
-
 static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		struct btrfs_inode *btrfs_inode)
 {
@@ -667,8 +655,14 @@ static void btrfs_delayed_inode_release_metadata(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * Insert a single delayed item or a batch of delayed items that have consecutive
- * keys if they exist.
+ * Insert a single delayed item or a batch of delayed items, as many as possible
+ * that fit in a leaf. The delayed items (dir index keys) are sorted by their key
+ * in the rbtree, and if there's a gap between two consecutive dir index items,
+ * then it means at some point we had delayed dir indexes to add but they got
+ * removed (by btrfs_delete_delayed_dir_index()) before we attemped to flush them
+ * into the subvolume tree. Dir index keys also have their offsets coming from a
+ * monotonically increasing counter, so we can't get new keys with an offset that
+ * fits within a gap between delayed dir index items.
  */
 static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
@@ -694,7 +688,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		int next_size;
 
 		next = __btrfs_next_delayed_item(curr);
-		if (!next || !btrfs_is_continuous_delayed_item(curr, next))
+		if (!next)
 			break;
 
 		next_size = next->data_len + sizeof(struct btrfs_item);
-- 
2.35.1

