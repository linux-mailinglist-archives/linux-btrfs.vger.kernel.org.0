Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3782C3FC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgKYMTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 07:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgKYMTf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 07:19:35 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A5E20715
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606306774;
        bh=KUV3qsOKfbZTb3T39rI1D4IJznnHDl3/r05Afj7Vwqs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=tPiew0OaHaw1xwfR7/mvBGcOo61vae/rDih/3qUfYVVjklU7oN5gpoNiMagJhUyxj
         4Y2iYPJnoQUEnqrGBCLmpzgAOPvYl93XZfGZarO39dgXb7jnOkpL5paf/yn67T+Bf4
         pu/NYjhtGa2KFzAyS0YQblFrVojaqyCocyS7ii9g=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: fix race that results in logging old extents during a fast fsync
Date:   Wed, 25 Nov 2020 12:19:24 +0000
Message-Id: <9f9b13e0edb79adea30d7e92dccfea8daf9cac88.1606305501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
References: <cover.1606305501.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging the extents of an inode during a fast fsync, we have a time
window where we can log extents that are from the previous transaction and
already persisted. This only makes us waste time unnecessarily.

The following sequence of steps shows how this can happen:

1) We are at transaction 1000;

2) An ordered extent E from inode I completes, that is it has gone through
   btrfs_finish_ordered_io(), and it set the extent maps' generation to
   1000 when we unpin the extent, which is the generation of the current
   transaction;

3) The commit for transaction 1000 starts by task A;

4) The task committing transaction 1000 sets the transaction state to
   unblocked, writes the dirty extent buffers and the super blocks, then
   unlocks tree_log_mutex;

5) Some change is made to inode I, resulting in creation of a new
   transaction with a generation of 1001;

6) The transaction 1000 commit starts unpinning extents. At this point
   fs_info->last_trans_committed still has a value of 999;

7) Task B starts an fsync on inode I, and when it gets to
   btrfs_log_changed_extents() sees the extent map for extent E in the
   list of modified extents. It sees the extent map has a generation of
   1000 and fs_info->last_trans_committed has a value of 999, so it
   proceeds to logging the respective file extent item and all the
   checksums covering its range.

   So we end up wasting time since the extent was already persisted and
   is reachable through the trees pointed to by the super block committed
   by transaction 1000.

So just fix this by comparing the extent maps generation against the
generation of the transaction handle - if it is smaller then the id in the
handle, we know the extent was already persisted and we do not need to log
it.

This patch belongs to a patch set that is comprised of the following
patches:

  btrfs: fix race causing unnecessary inode logging during link and rename
  btrfs: fix race that results in logging old extents during a fast fsync
  btrfs: fix race that causes unnecessary logging of ancestor inodes
  btrfs: fix race that makes inode logging fallback to transaction commit
  btrfs: fix race leading to unnecessary transaction commit when logging inode
  btrfs: do not block inode logging for so long during transaction commit

Performance results are mentioned in the change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b63f5c2b982a..596d72d239e9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4416,14 +4416,12 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	struct extent_map *em, *n;
 	struct list_head extents;
 	struct extent_map_tree *tree = &inode->extent_tree;
-	u64 test_gen;
 	int ret = 0;
 	int num = 0;
 
 	INIT_LIST_HEAD(&extents);
 
 	write_lock(&tree->lock);
-	test_gen = root->fs_info->last_trans_committed;
 
 	list_for_each_entry_safe(em, n, &tree->modified_extents, list) {
 		list_del_init(&em->list);
@@ -4439,7 +4437,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 			goto process;
 		}
 
-		if (em->generation <= test_gen)
+		if (em->generation < trans->transid)
 			continue;
 
 		/* We log prealloc extents beyond eof later. */
-- 
2.28.0

