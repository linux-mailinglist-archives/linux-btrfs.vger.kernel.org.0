Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A7741618
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjF1QNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 12:13:46 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48272 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1QNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 12:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3ACD61371
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 16:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CEDC433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687968823;
        bh=jw+tnawmUEOzhA0gvN0SgE4+XFJY0ubT0NSP/LBvCQI=;
        h=From:To:Subject:Date:From;
        b=C4B3zvF7Iisup0N9mIpmMt3yx7YT7DDsIlBP2wEHR/GX3cnDaZsZ/wf1lawEv802t
         ofnTj+7FxKHiApkysiXMncaEqKFj8FpkIM1PhQod7yWWvkJtji7oYrOo57rYtJfqex
         hBtj8ecb7sNyWZlWQbzymmn3u2VXd1eZ+DWpMJrvrmeM2uP2JzA+z1J3Sx1uSiv1W/
         +c61mf3k2ldfurFSJpw4ylPemwLn9kxvo3ZK8VL3a3Nlwkug3ep4kmFuXQE6Q+lpTo
         RRVxOmgd+/QyLPPbaqvWs4a1Um1ip/AiiEoFZfiWJCoRQLRPb/2OC2oxiYDPHlIlbB
         ZqYy7s1C28D0g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix use-after-free of new block group that became unused
Date:   Wed, 28 Jun 2023 17:13:37 +0100
Message-Id: <a21dc3572d3e3655861f4076a8805cc0babb92bb.1687968622.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If a task creates a new block group and that block group becomes unused
before we finish its creation, at btrfs_create_pending_block_groups(),
then when btrfs_mark_bg_unused() is called against the block group, we
assume that the block group is currently in the list of block groups to
reclaim, and we move it out of the list of new block groups and into the
list of unused block groups. This has two consequences:

1) We move it out of the list of new block groups associated to the
   current transaction. So the block group creation is not finished and
   if we attempt to delete the bg because it's unused, we will not find
   the block group item in the extent tree (or the new block group tree),
   its device extent items in the device tree etc, resulting in the
   deletion to fail due to the missing items;

2) We don't increment the reference count on the block group when we
   move it to the list of unused block groups, because we assumed the
   block group was on the list of block groups to reclaim, and in that
   case it already has the correct reference count. However the block
   group was on the list of new block groups, in which case no extra
   reference was taken because it's local to the current task. This
   later results in doing an extra reference count decrement when
   removing the block group from the unused list, eventually leading the
   referecence count to 0.

This second case was caught when running generic/297 from fstests, which
produced the following assertion failure and stack trace:

   [457589.559668] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4299
   [457589.559931] ------------[ cut here ]------------
   [457589.559932] kernel BUG at fs/btrfs/block-group.c:4299!
   [457589.560168] invalid opcode: 0000 [#1] PREEMPT SMP PTI
   [457589.560381] CPU: 8 PID: 2819134 Comm: umount Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
   [457589.560630] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
   [457589.560871] RIP: 0010:btrfs_free_block_groups+0x449/0x4a0 [btrfs]
   [457589.561181] Code: 68 62 da c0 (...)
   [457589.561711] RSP: 0018:ffffa55a8c3b3d98 EFLAGS: 00010246
   [457589.561957] RAX: 0000000000000058 RBX: ffff8f030d7f2000 RCX: 0000000000000000
   [457589.562202] RDX: 0000000000000000 RSI: ffffffff953f0878 RDI: 00000000ffffffff
   [457589.562442] RBP: ffff8f030d7f2088 R08: 0000000000000000 R09: ffffa55a8c3b3c50
   [457589.562680] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8f05850b4c00
   [457589.562921] R13: ffff8f030d7f2090 R14: ffff8f05850b4cd8 R15: dead000000000100
   [457589.563167] FS:  00007f497fd2e840(0000) GS:ffff8f09dfc00000(0000) knlGS:0000000000000000
   [457589.563419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [457589.563673] CR2: 00007f497ff8ec10 CR3: 0000000271472006 CR4: 0000000000370ee0
   [457589.563934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   [457589.564196] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   [457589.564460] Call Trace:
   [457589.564771]  <TASK>
   [457589.565032]  ? __die_body+0x1b/0x60
   [457589.565290]  ? die+0x39/0x60
   [457589.565571]  ? do_trap+0xeb/0x110
   [457589.565818]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
   [457589.566109]  ? do_error_trap+0x6a/0x90
   [457589.566347]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
   [457589.566623]  ? exc_invalid_op+0x4e/0x70
   [457589.566854]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
   [457589.567122]  ? asm_exc_invalid_op+0x16/0x20
   [457589.567352]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
   [457589.567624]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
   [457589.567895]  close_ctree+0x35d/0x560 [btrfs]
   [457589.568164]  ? fsnotify_sb_delete+0x13e/0x1d0
   [457589.568401]  ? dispose_list+0x3a/0x50
   [457589.568671]  ? evict_inodes+0x151/0x1a0
   [457589.568897]  generic_shutdown_super+0x73/0x1a0
   [457589.569128]  kill_anon_super+0x14/0x30
   [457589.569358]  btrfs_kill_super+0x12/0x20 [btrfs]
   [457589.569673]  deactivate_locked_super+0x2e/0x70
   [457589.569901]  cleanup_mnt+0x104/0x160
   [457589.570156]  task_work_run+0x56/0x90
   [457589.570500]  exit_to_user_mode_prepare+0x160/0x170
   [457589.570750]  syscall_exit_to_user_mode+0x22/0x50
   [457589.570971]  ? __x64_sys_umount+0x12/0x20
   [457589.571190]  do_syscall_64+0x48/0x90
   [457589.571412]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
   [457589.571639] RIP: 0033:0x7f497ff0a567
   [457589.571865] Code: af 98 0e (...)
   [457589.572348] RSP: 002b:00007ffc98347358 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
   [457589.572641] RAX: 0000000000000000 RBX: 00007f49800b8264 RCX: 00007f497ff0a567
   [457589.572883] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000557f558abfa0
   [457589.573124] RBP: 0000557f558a6ba0 R08: 0000000000000000 R09: 00007ffc98346100
   [457589.573359] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
   [457589.573628] R13: 0000557f558abfa0 R14: 0000557f558a6cb0 R15: 0000557f558a6dd0
   [457589.573853]  </TASK>
   [457589.574064] Modules linked in: dm_snapshot dm_thin_pool (...)
   [457589.576327] ---[ end trace 0000000000000000 ]---

Fix this by adding a runtime flag to the block group to tell that the
block group is still in the list of new block groups, and therefore it
should not be moved to the list of unused block groups, at
btrfs_mark_bg_unused(), until the flag is cleared, when we finish the
creation of the block group at btrfs_create_pending_block_groups().

Fixes: a9f189716cf1 ("btrfs: move out now unused BG from the reclaim list")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 13 +++++++++++--
 fs/btrfs/block-group.h |  5 +++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6753524b146c..f53297726238 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1640,13 +1640,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
-	trace_btrfs_add_unused_block_group(bg);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (list_empty(&bg->bg_list)) {
 		btrfs_get_block_group(bg);
+		trace_btrfs_add_unused_block_group(bg);
 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
-	} else {
+	} else if (!test_bit(BLOCK_GROUP_FLAG_NEW, &bg->runtime_flags)) {
 		/* Pull out the block group from the reclaim_bgs list. */
+		trace_btrfs_add_unused_block_group(bg);
 		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
@@ -2668,6 +2669,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 next:
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
 		list_del_init(&block_group->bg_list);
+		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
 	}
 	btrfs_trans_release_chunk_metadata(trans);
 }
@@ -2707,6 +2709,13 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * Mark it as new before adding it to the rbtree of block groups or any
+	 * list, so that no other task finds it and calls btrfs_mark_bg_unused()
+	 * before the new flag is set.
+	 */
+	set_bit(BLOCK_GROUP_FLAG_NEW, &cache->runtime_flags);
+
 	cache->length = size;
 	set_free_space_tree_thresholds(cache);
 	cache->flags = type;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f204addc3fe8..0ed31112d932 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -70,6 +70,11 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
 	/* Indicate that the block group is placed on a sequential zone */
 	BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE,
+	/*
+	 * Indicate the block group is in the list of new block groups of a
+	 * transaction.
+	 */
+	BLOCK_GROUP_FLAG_NEW,
 };
 
 enum btrfs_caching_type {
-- 
2.34.1

