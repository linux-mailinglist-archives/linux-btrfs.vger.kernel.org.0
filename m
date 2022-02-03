Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611A84A870A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbiBCOz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:55:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46322 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351536AbiBCOzz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:55:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F8461A88
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4764BC340F1
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900154;
        bh=GgiFrfz7QVJw/N2+ZT/rR6OG99L2F03AJe1ijZ8aNxo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M4LWVRBZ/+J3xaKkcd3XIfOa+og0aPH/jXkBN0vlecf9L++3EuMgp9RcZuwH3Z5hn
         XVmGoPGskRUk8vA8cAp3KrU+kTCJ9EgCUr8gbb1GEDrOvHx+jI00FyIvhkrS8gtCfQ
         viuxtG62yB0tnQVyqtX2xS9kd1I3ui9wYv/Q+Lk/Psr2yI+kAdb2isawNEkAWt56Rm
         ++9mj/AAolr3ZbIrmfvnXf8j0u9cvXFYUbvw8YqdyOOjWnBc7L7AYt7EFHV3tnw8UV
         vrHFhOlU67W+AO1qE54cUOoEEFOd9nxaY1wBg+y5rT9ev5mQGQ+wsP97hxzu08nmR3
         MSR6QYoOQ2bGA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: remove unnecessary leaf free space checks when pushing items
Date:   Thu,  3 Feb 2022 14:55:45 +0000
Message-Id: <979fff359df2da3e82333da7116131c09f368a48.1643898313.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When trying to push items from a leaf into its left and right neighbours,
we lock the left or right leaf, check if it has the required minimum free
space, COW the leaf and then check again if it has the minimum required
free space. This second check is pointless:

1) Most and foremost because it's not neeed. We have a write lock on the
   leaf and on its parent node, so no one can come in and change either
   the pre-COW or post-COW version of the leaf for the whole duration of
   the push_leaf_left() and push_leaf_right() calls;

2) The call to btrfs_leaf_free_space() is not trivial, it has a fair
   amount of arithmetic operations and access to fields in the leaf's
   header and items, so it's not very cheap.

So remove the duplicated free space checks.

This change if part of a patchset that is comprised of the following
patches:

  1/6 btrfs: remove unnecessary leaf free space checks when pushing items
  2/6 btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  3/6 btrfs: avoid unnecessary computation when deleting items from a leaf
  4/6 btrfs: remove constraint on number of visited leaves when replacing extents
  5/6 btrfs: remove useless path release in the fast fsync path
  6/6 btrfs: prepare extents to be logged before locking a log tree path

The last patch in the series has some performance test result in its
changelog.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a7db3f6f1b7b..cf3d57082524 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2990,16 +2990,11 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (free_space < data_size)
 		goto out_unlock;
 
-	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, right, upper,
 			      slot + 1, &right, BTRFS_NESTING_RIGHT_COW);
 	if (ret)
 		goto out_unlock;
 
-	free_space = btrfs_leaf_free_space(right);
-	if (free_space < data_size)
-		goto out_unlock;
-
 	left_nritems = btrfs_header_nritems(left);
 	if (left_nritems == 0)
 		goto out_unlock;
@@ -3224,7 +3219,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		goto out;
 	}
 
-	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, left,
 			      path->nodes[1], slot - 1, &left,
 			      BTRFS_NESTING_LEFT_COW);
@@ -3235,12 +3229,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		goto out;
 	}
 
-	free_space = btrfs_leaf_free_space(left);
-	if (free_space < data_size) {
-		ret = 1;
-		goto out;
-	}
-
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
 		goto out;
-- 
2.33.0

