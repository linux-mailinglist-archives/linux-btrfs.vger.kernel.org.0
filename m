Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5376442889
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfFLONa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfFLON3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:13:29 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FB620652
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560348808;
        bh=XT/lxZ/yBh/hWnqsy4i1+gDXYk/c6+id5Iv+MHn4yH4=;
        h=From:To:Subject:Date:From;
        b=BGUxg90yrzjr2csq13LfJY2NY4tQnlz1ox/KdtuWEIEKzUlhktcCqmzVTFlEN7JSd
         cy5OchNSUESCRP4HOPKwhGfsMdx7nx/fVrysvJquDkOZ8JEOGb4z1xO3FgV4WxiVJv
         VXyTh7Sk7TMgYnZEWDYVFFczEZ6xTd/F6orHGaAI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH for <= 5.1] Btrfs: fix race between block group removal and block group allocation
Date:   Wed, 12 Jun 2019 15:13:24 +0100
Message-Id: <20190612141324.25271-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If a task is removing the block group that currently has the highest start
offset amongst all existing block groups, there is a short time window
where it races with a concurrent block group allocation, resulting in a
transaction abort with an error code of EEXIST.

The following diagram explains the race in detail:

      Task A                                                        Task B

 btrfs_remove_block_group(bg offset X)

   remove_extent_mapping(em offset X)
     -> removes extent map X from the
        tree of extent maps
        (fs_info->mapping_tree), so the
        next call to find_next_chunk()
        will return offset X

                                                   btrfs_alloc_chunk()
                                                     find_next_chunk()
                                                       --> returns offset X

                                                     __btrfs_alloc_chunk(offset X)
                                                       btrfs_make_block_group()
                                                         btrfs_create_block_group_cache()
                                                           --> creates btrfs_block_group_cache
                                                               object with a key corresponding
                                                               to the block group item in the
                                                               extent, the key is:
                                                               (offset X, BTRFS_BLOCK_GROUP_ITEM_KEY, 1G)

                                                         --> adds the btrfs_block_group_cache object
                                                             to the list new_bgs of the transaction
                                                             handle

                                                   btrfs_end_transaction(trans handle)
                                                     __btrfs_end_transaction()
                                                       btrfs_create_pending_block_groups()
                                                         --> sees the new btrfs_block_group_cache
                                                             in the new_bgs list of the transaction
                                                             handle
                                                         --> its call to btrfs_insert_item() fails
                                                             with -EEXIST when attempting to insert
                                                             the block group item key
                                                             (offset X, BTRFS_BLOCK_GROUP_ITEM_KEY, 1G)
                                                             because task A has not removed that key yet
                                                         --> aborts the running transaction with
                                                             error -EEXIST

   btrfs_del_item()
     -> removes the block group's key from
        the extent tree, key is
        (offset X, BTRFS_BLOCK_GROUP_ITEM_KEY, 1G)

A sample transaction abort trace:

  [78912.403537] ------------[ cut here ]------------
  [78912.403811] BTRFS: Transaction aborted (error -17)
  [78912.404082] WARNING: CPU: 2 PID: 20465 at fs/btrfs/extent-tree.c:10551 btrfs_create_pending_block_groups+0x196/0x250 [btrfs]
  (...)
  [78912.405642] CPU: 2 PID: 20465 Comm: btrfs Tainted: G        W         5.0.0-btrfs-next-46 #1
  [78912.405941] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
  [78912.406586] RIP: 0010:btrfs_create_pending_block_groups+0x196/0x250 [btrfs]
  (...)
  [78912.407636] RSP: 0018:ffff9d3d4b7e3b08 EFLAGS: 00010282
  [78912.407997] RAX: 0000000000000000 RBX: ffff90959a3796f0 RCX: 0000000000000006
  [78912.408369] RDX: 0000000000000007 RSI: 0000000000000001 RDI: ffff909636b16860
  [78912.408746] RBP: ffff909626758a58 R08: 0000000000000000 R09: 0000000000000000
  [78912.409144] R10: ffff9095ff462400 R11: 0000000000000000 R12: ffff90959a379588
  [78912.409521] R13: ffff909626758ab0 R14: ffff9095036c0000 R15: ffff9095299e1158
  [78912.409899] FS:  00007f387f16f700(0000) GS:ffff909636b00000(0000) knlGS:0000000000000000
  [78912.410285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [78912.410673] CR2: 00007f429fc87cbc CR3: 000000014440a004 CR4: 00000000003606e0
  [78912.411095] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [78912.411496] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [78912.411898] Call Trace:
  [78912.412318]  __btrfs_end_transaction+0x5b/0x1c0 [btrfs]
  [78912.412746]  btrfs_inc_block_group_ro+0xcf/0x160 [btrfs]
  [78912.413179]  scrub_enumerate_chunks+0x188/0x5b0 [btrfs]
  [78912.413622]  ? __mutex_unlock_slowpath+0x100/0x2a0
  [78912.414078]  btrfs_scrub_dev+0x2ef/0x720 [btrfs]
  [78912.414535]  ? __sb_start_write+0xd4/0x1c0
  [78912.414963]  ? mnt_want_write_file+0x24/0x50
  [78912.415403]  btrfs_ioctl+0x17fb/0x3120 [btrfs]
  [78912.415832]  ? lock_acquire+0xa6/0x190
  [78912.416256]  ? do_vfs_ioctl+0xa2/0x6f0
  [78912.416685]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
  [78912.417116]  do_vfs_ioctl+0xa2/0x6f0
  [78912.417534]  ? __fget+0x113/0x200
  [78912.417954]  ksys_ioctl+0x70/0x80
  [78912.418369]  __x64_sys_ioctl+0x16/0x20
  [78912.418812]  do_syscall_64+0x60/0x1b0
  [78912.419231]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [78912.419644] RIP: 0033:0x7f3880252dd7
  (...)
  [78912.420957] RSP: 002b:00007f387f16ed68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [78912.421426] RAX: ffffffffffffffda RBX: 000055f5becc1df0 RCX: 00007f3880252dd7
  [78912.421889] RDX: 000055f5becc1df0 RSI: 00000000c400941b RDI: 0000000000000003
  [78912.422354] RBP: 0000000000000000 R08: 00007f387f16f700 R09: 0000000000000000
  [78912.422790] R10: 00007f387f16f700 R11: 0000000000000246 R12: 0000000000000000
  [78912.423202] R13: 00007ffda49c266f R14: 0000000000000000 R15: 00007f388145e040
  [78912.425505] ---[ end trace eb9bfe7c426fc4d3 ]---

Fix this by calling remove_extent_mapping(), at btrfs_remove_block_group(),
only at the very end, after removing the block group item key from the
extent tree (and removing the free space tree entry if we are using the
free space tree feature).

Fixes: 04216820fe83d5 ("Btrfs: fix race between fs trimming and block group remove/allocation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 33b169f80157..d6684bcc2885 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10911,22 +10911,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	}
 	spin_unlock(&block_group->lock);
 
-	if (remove_em) {
-		struct extent_map_tree *em_tree;
-
-		em_tree = &fs_info->mapping_tree.map_tree;
-		write_lock(&em_tree->lock);
-		/*
-		 * The em might be in the pending_chunks list, so make sure the
-		 * chunk mutex is locked, since remove_extent_mapping() will
-		 * delete us from that list.
-		 */
-		remove_extent_mapping(em_tree, em);
-		write_unlock(&em_tree->lock);
-		/* once for the tree */
-		free_extent_map(em);
-	}
-
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	ret = remove_block_group_free_space(trans, block_group);
@@ -10943,6 +10927,26 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		goto out;
 
 	ret = btrfs_del_item(trans, root, path);
+	if (ret)
+		goto out;
+
+	if (remove_em) {
+		struct extent_map_tree *em_tree;
+
+		em_tree = &fs_info->mapping_tree.map_tree;
+		mutex_lock(&fs_info->chunk_mutex);
+		write_lock(&em_tree->lock);
+		/*
+		 * The em might be in the pending_chunks list, so make sure the
+		 * chunk mutex is locked, since remove_extent_mapping() will
+		 * delete us from that list.
+		 */
+		remove_extent_mapping(em_tree, em);
+		write_unlock(&em_tree->lock);
+		mutex_unlock(&fs_info->chunk_mutex);
+		/* once for the tree */
+		free_extent_map(em);
+	}
 out:
 	if (remove_rsv)
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
-- 
2.11.0

