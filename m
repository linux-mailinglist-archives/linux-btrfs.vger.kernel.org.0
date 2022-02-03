Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D34A870F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiBCO4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiBCOz6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:55:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429FEC061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 06:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02A77B83475
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADB6C340E8
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900155;
        bh=mzr87MxvQg1TB6uyT41CVREmjenxhwssttwiF4eAse4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lJtKukvy3A9uHHxNAYYTWKArEywMWAlM77hcbpMrx8086+mUygbgTlcQjlM9yYVSF
         ZhXVRwnQ8DtqTizPvFwanHTRHv4oAueV6e1L+KrSUtxtLSRqTCTNYbMk9/s880hAZX
         sVU+W+ltnhfPz0Z/2nVDig1qDCtJXQGof1HtsNw4pHfsDBgYpTxzA06QI3d69mzdb9
         Bdzp7kHsBZ8Nypl75aQExryKgdNQHtETl8ViknT0wEka2xlUgpnF4j5QLr3Wrmt9Vf
         HSsi4W++3chmtq8HVJHTfaBcRQO8zkwnXKa3UzU+/yeHejmVcIHf4onnnoGLvIebD8
         U7XeRsiQHgKVA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
Date:   Thu,  3 Feb 2022 14:55:46 +0000
Message-Id: <cedb93fa7c9a06b2fe75f931d486fc830acc4f74.1643898313.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we delete items from a leaf, if we end up with more than two thirds
of unused leaf space, we try to delete the leaf by moving all its items
into its left and right neighbour leaves. Sometimes that is not possible
because there is not enough free space in the left and right leaves, and
in that case we end up not deleting our leaf.

The way we are doing this is not ideal and can be improved in the
following ways:

1) When we call push_leaf_left(), we pass a value of 1 byte to the data
   size parameter of push_leaf_left(). This is not realistic value because
   no item can have a size less than 25 bytes, which is the size of struct
   btrfs_item. This means that means that if the left leaf has not enough
   free space to push any item, we end up COWing it even if we end up not
   changing its content at all.

   COWing that leaf means allocating a new metadata extent, marking it
   dirty and doing more IO when comitting a transaction or when syncing a
   log tree. For a log tree case, it's particularly more important to
   avoid the useless COW operation, as more IO can imply a higher latency
   for an fsync operation.

   So instead of passing 1 as the minimim data size for push_leaf_left(),
   pass the size of the first item in our leaf, as we don't want to COW
   the left leaf if we can't at least push the first item of our leaf;

2) When we call push_leaf_right(), we also pass a value of 1 byte as the
   data size parameter of push_leaf_right(). Like the previous case, it
   will also result in COWing the right leaf even if we are not able to
   move any items into it, since there can't be any item with a size
   smaller than 25 bytes (the size of struct btrfs_item).

   So instead of passing 1 as the minimum data size to push_leaf_right(),
   pass a size that corresponds to the sum of the size of all the
   remaining items in our leaf. We are not interested in moving less than
   that, because if we do, we are not able to delete our leaf and we have
   COWed the right leaf for nothing. Plus, moving only some of the items
   of our leaf, it means an even less balanced tree.

   Just like the previous case, we want to avoid the useless COW of the
   right leaf, this way we don't have to spend time allocating one new
   metadata extent, and doing more IO when comitting a transaction or
   syncing a log tree. For the log tree case it's specially more important
   because more IO can result in a higher latency for a fsync operation.

So adjust the minimum data size passed to push_leaf_left() and
push_leaf_right() as mentioned above.

This change if part of a patchset that is comprised of the following
patches:

  1/6 btrfs: remove unnecessary leaf free space checks when pushing items
  2/6 btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  3/6 btrfs: avoid unnecessary computation when deleting items from a leaf
  4/6 btrfs: remove constraint on number of visited leaves when replacing extents
  5/6 btrfs: remove useless path release in the fast fsync path
  6/6 btrfs: prepare extents to be logged before locking a log tree path

Not being able to delete a leaf that became less than 1/3 full after
deleting items from it is actually common. For example, for the fio test
mentioned in the changelog of patch 6/6, we are only able to delete a
leaf at btrfs_del_items() about 5.3% of the time, due to its left and
right neighbour leaves not having enough free space to push all the
remaining items into them.

The last patch in the series has some performance test result in its
changelog.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cf3d57082524..5322140f4d22 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4215,24 +4215,50 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			fixup_low_keys(path, &disk_key, 1);
 		}
 
-		/* delete the leaf if it is mostly empty */
+		/*
+		 * Try to delete the leaf if it is mostly empty. We do this by
+		 * trying to move all its items into its left and right neighbours.
+		 * If we can't move all the items, then we don't delete it - it's
+		 * not ideal, but future insertions might fill the leaf with more
+		 * items, or items from other leaves might be moved later into our
+		 * leaf due to deletions on those leaves.
+		 */
 		if (used < BTRFS_LEAF_DATA_SIZE(fs_info) / 3) {
+			u32 min_push_space;
+
 			/* push_leaf_left fixes the path.
 			 * make sure the path still points to our leaf
 			 * for possible call to del_ptr below
 			 */
 			slot = path->slots[1];
 			atomic_inc(&leaf->refs);
-
-			wret = push_leaf_left(trans, root, path, 1, 1,
-					      1, (u32)-1);
+			/*
+			 * We want to be able to at least push one item to the
+			 * left neighbour leaf, and that's the first item.
+			 */
+			min_push_space = sizeof(struct btrfs_item) +
+				btrfs_item_size(leaf, 0);
+			wret = push_leaf_left(trans, root, path, 0,
+					      min_push_space, 1, (u32)-1);
 			if (wret < 0 && wret != -ENOSPC)
 				ret = wret;
 
 			if (path->nodes[0] == leaf &&
 			    btrfs_header_nritems(leaf)) {
-				wret = push_leaf_right(trans, root, path, 1,
-						       1, 1, 0);
+				/*
+				 * If we were not able to push all items from our
+				 * leaf to its left neighbour, then attempt to
+				 * either push all the remaining items to the
+				 * right neighbour or none. There's no advantage
+				 * in pushing only some items, instead of all, as
+				 * it's pointless to end up with a leaf having
+				 * too few items while the neighbours can be full
+				 * or nearly full.
+				 */
+				nritems = btrfs_header_nritems(leaf);
+				min_push_space = leaf_space_used(leaf, 0, nritems);
+				wret = push_leaf_right(trans, root, path, 0,
+						       min_push_space, 1, 0);
 				if (wret < 0 && wret != -ENOSPC)
 					ret = wret;
 			}
-- 
2.33.0

