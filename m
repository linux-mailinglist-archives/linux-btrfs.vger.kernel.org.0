Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57E749275A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiARNjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 08:39:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45756 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiARNjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 08:39:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F28A0B8169D
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 13:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BDEC00446
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642513177;
        bh=YQesutKgmqZwsXaf6T/aHjtMoNj1I28VAOX/FDtyv7o=;
        h=From:To:Subject:Date:From;
        b=AV8xGI9lrv3gpi6q263Yco4gWTfGPYQrn9iISQI117DV0OSPdtP2Jh7JNXVYjGeTS
         nc5X0x2sqrUIeTDlvka/st2M8r5iNXZ7XVjcI8gu4MP7pBTn9vo17umdpuEHo5OqNC
         giu/oGPid2zc/6D2lkY3Y0/9Ku3gSBlqRYrqVl4RMUh/r7cNsqOd2IrakMzUA+kPPO
         igV0JZQ/uoq50zQcARs1xgrRo6kU6DAQbSRikohxPzyAO6c6DcZ8PJBOFmUnjw3uxH
         1thQh5c2XxO/WnHIktzhVXbl6Dk7CUsE//HuIlGEhMZl1l7mvqWS8FVl37GvgUbpmd
         nr8bB4PE2Vygw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: skip reserved bytes warning on unmount after log cleanup failure
Date:   Tue, 18 Jan 2022 13:39:34 +0000
Message-Id: <abff8bb38826f30e65d26c4cb5535fe599fdfdf1.1642512596.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the recent changes made by commit c2e39305299f01 ("btrfs: clear
extent buffer uptodate when we fail to write it") and its followup fix,
commit 651740a5024117 ("btrfs: check WRITE_ERR when trying to read an
extent buffer"), we can now end up not cleaning up space reservations of
log tree extent buffers after a transaction abort happens, as well as not
cleaning up still dirty extent buffers.

This happens because if writeback for a log tree extent buffer failed,
then we have cleared the bit EXTENT_BUFFER_UPTODATE from the extent buffer
and we have also set the bit EXTENT_BUFFER_WRITE_ERR on it. Later on,
when trying to free the log tree with free_log_tree(), which iterates
over the tree, we can end up getting an -EIO error when trying to read
a node or a leaf, since read_extent_buffer_pages() returns -EIO if an
extent buffer does not have EXTENT_BUFFER_UPTODATE set and has the
EXTENT_BUFFER_WRITE_ERR bit set. Getting that -EIO means that we return
immediately as we can not iterate over the entire tree.

In that case we never update the reserved space for an extent buffer in
the respective block group and space_info object.

When this happens we get the following traces when unmounting the fs:

[174957.284509] BTRFS: error (device dm-0) in cleanup_transaction:1913: errno=-5 IO failure
[174957.286497] BTRFS: error (device dm-0) in free_log_tree:3420: errno=-5 IO failure
[174957.399379] ------------[ cut here ]------------
[174957.402497] WARNING: CPU: 2 PID: 3206883 at fs/btrfs/block-group.c:127 btrfs_put_block_group+0x77/0xb0 [btrfs]
[174957.407523] Modules linked in: btrfs overlay dm_zero (...)
[174957.424917] CPU: 2 PID: 3206883 Comm: umount Tainted: G        W         5.16.0-rc5-btrfs-next-109 #1
[174957.426689] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[174957.428716] RIP: 0010:btrfs_put_block_group+0x77/0xb0 [btrfs]
[174957.429717] Code: 21 48 8b bd (...)
[174957.432867] RSP: 0018:ffffb70d41cffdd0 EFLAGS: 00010206
[174957.433632] RAX: 0000000000000001 RBX: ffff8b09c3848000 RCX: ffff8b0758edd1c8
[174957.434689] RDX: 0000000000000001 RSI: ffffffffc0b467e7 RDI: ffff8b0758edd000
[174957.436068] RBP: ffff8b0758edd000 R08: 0000000000000000 R09: 0000000000000000
[174957.437114] R10: 0000000000000246 R11: 0000000000000000 R12: ffff8b09c3848148
[174957.438140] R13: ffff8b09c3848198 R14: ffff8b0758edd188 R15: dead000000000100
[174957.439317] FS:  00007f328fb82800(0000) GS:ffff8b0a2d200000(0000) knlGS:0000000000000000
[174957.440402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[174957.441164] CR2: 00007fff13563e98 CR3: 0000000404f4e005 CR4: 0000000000370ee0
[174957.442117] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[174957.443076] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[174957.443948] Call Trace:
[174957.444264]  <TASK>
[174957.444538]  btrfs_free_block_groups+0x255/0x3c0 [btrfs]
[174957.445238]  close_ctree+0x301/0x357 [btrfs]
[174957.445803]  ? call_rcu+0x16c/0x290
[174957.446250]  generic_shutdown_super+0x74/0x120
[174957.446832]  kill_anon_super+0x14/0x30
[174957.447305]  btrfs_kill_super+0x12/0x20 [btrfs]
[174957.447890]  deactivate_locked_super+0x31/0xa0
[174957.448440]  cleanup_mnt+0x147/0x1c0
[174957.448888]  task_work_run+0x5c/0xa0
[174957.449336]  exit_to_user_mode_prepare+0x1e5/0x1f0
[174957.449934]  syscall_exit_to_user_mode+0x16/0x40
[174957.450512]  do_syscall_64+0x48/0xc0
[174957.450980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[174957.451605] RIP: 0033:0x7f328fdc4a97
[174957.452059] Code: 03 0c 00 f7 (...)
[174957.454320] RSP: 002b:00007fff13564ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[174957.455262] RAX: 0000000000000000 RBX: 00007f328feea264 RCX: 00007f328fdc4a97
[174957.456131] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000560b8ae51dd0
[174957.457118] RBP: 0000560b8ae51ba0 R08: 0000000000000000 R09: 00007fff13563c40
[174957.458005] R10: 00007f328fe49fc0 R11: 0000000000000246 R12: 0000000000000000
[174957.459113] R13: 0000560b8ae51dd0 R14: 0000560b8ae51cb0 R15: 0000000000000000
[174957.460193]  </TASK>
[174957.460534] irq event stamp: 0
[174957.461003] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[174957.461947] hardirqs last disabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
[174957.463147] softirqs last  enabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
[174957.465116] softirqs last disabled at (0): [<0000000000000000>] 0x0
[174957.466323] ---[ end trace bc7ee0c490bce3af ]---
[174957.467282] ------------[ cut here ]------------
[174957.468184] WARNING: CPU: 2 PID: 3206883 at fs/btrfs/block-group.c:3976 btrfs_free_block_groups+0x330/0x3c0 [btrfs]
[174957.470066] Modules linked in: btrfs overlay dm_zero (...)
[174957.483137] CPU: 2 PID: 3206883 Comm: umount Tainted: G        W         5.16.0-rc5-btrfs-next-109 #1
[174957.484691] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[174957.486853] RIP: 0010:btrfs_free_block_groups+0x330/0x3c0 [btrfs]
[174957.488050] Code: 00 00 00 ad de (...)
[174957.491479] RSP: 0018:ffffb70d41cffde0 EFLAGS: 00010206
[174957.492520] RAX: ffff8b08d79310b0 RBX: ffff8b09c3848000 RCX: 0000000000000000
[174957.493868] RDX: 0000000000000001 RSI: fffff443055ee600 RDI: ffffffffb1131846
[174957.495183] RBP: ffff8b08d79310b0 R08: 0000000000000000 R09: 0000000000000000
[174957.496580] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8b08d7931000
[174957.498027] R13: ffff8b09c38492b0 R14: dead000000000122 R15: dead000000000100
[174957.499438] FS:  00007f328fb82800(0000) GS:ffff8b0a2d200000(0000) knlGS:0000000000000000
[174957.500990] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[174957.502117] CR2: 00007fff13563e98 CR3: 0000000404f4e005 CR4: 0000000000370ee0
[174957.503513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[174957.504864] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[174957.506167] Call Trace:
[174957.506654]  <TASK>
[174957.507047]  close_ctree+0x301/0x357 [btrfs]
[174957.507867]  ? call_rcu+0x16c/0x290
[174957.508567]  generic_shutdown_super+0x74/0x120
[174957.509447]  kill_anon_super+0x14/0x30
[174957.510194]  btrfs_kill_super+0x12/0x20 [btrfs]
[174957.511123]  deactivate_locked_super+0x31/0xa0
[174957.511976]  cleanup_mnt+0x147/0x1c0
[174957.512610]  task_work_run+0x5c/0xa0
[174957.513309]  exit_to_user_mode_prepare+0x1e5/0x1f0
[174957.514231]  syscall_exit_to_user_mode+0x16/0x40
[174957.515069]  do_syscall_64+0x48/0xc0
[174957.515718]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[174957.516688] RIP: 0033:0x7f328fdc4a97
[174957.517413] Code: 03 0c 00 f7 d8 (...)
[174957.521052] RSP: 002b:00007fff13564ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[174957.522514] RAX: 0000000000000000 RBX: 00007f328feea264 RCX: 00007f328fdc4a97
[174957.523950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000560b8ae51dd0
[174957.525375] RBP: 0000560b8ae51ba0 R08: 0000000000000000 R09: 00007fff13563c40
[174957.526763] R10: 00007f328fe49fc0 R11: 0000000000000246 R12: 0000000000000000
[174957.528058] R13: 0000560b8ae51dd0 R14: 0000560b8ae51cb0 R15: 0000000000000000
[174957.529404]  </TASK>
[174957.529843] irq event stamp: 0
[174957.530256] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[174957.531061] hardirqs last disabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
[174957.532075] softirqs last  enabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
[174957.533083] softirqs last disabled at (0): [<0000000000000000>] 0x0
[174957.533865] ---[ end trace bc7ee0c490bce3b0 ]---
[174957.534452] BTRFS info (device dm-0): space_info 4 has 1070841856 free, is not full
[174957.535404] BTRFS info (device dm-0): space_info total=1073741824, used=2785280, pinned=0, reserved=49152, may_use=0, readonly=65536 zone_unusable=0
[174957.537029] BTRFS info (device dm-0): global_block_rsv: size 0 reserved 0
[174957.537859] BTRFS info (device dm-0): trans_block_rsv: size 0 reserved 0
[174957.538697] BTRFS info (device dm-0): chunk_block_rsv: size 0 reserved 0
[174957.539552] BTRFS info (device dm-0): delayed_block_rsv: size 0 reserved 0
[174957.540403] BTRFS info (device dm-0): delayed_refs_rsv: size 0 reserved 0

This also means that in case we have log tree extent buffers that are
still dirty, we can end up not cleaning them up in case we find an
extent buffer with EXTENT_BUFFER_WRITE_ERR set on it, as in that case
we have no way for iterating over the rest of the tree.

This issue is very often triggered with test cases generic/475 and
generic/648 from fstests.

The issue could almost be fixed by iterating over the io tree attached to
each log root which keeps tracks of the range of allocated extent buffers,
log_root->dirty_log_pages, however that does not work and has some
incovenients:

1) After we sync the log, we clear the range of the extent buffers from
   the io tree, so we can't find them after writeback. We could keep the
   ranges in the io tree, with a separate bit to signal they represent
   extent buffers already written, but that means we need to hold into
   more memory until the transaction commits.

   How much more memory is used depends a lot on whether we are able to
   allocate contiguous extent buffers on disk (and how often) for a log
   tree - if we are able to, then a single extent state record can
   represent multiple extent buffers, otherwise we need multiple extent
   state record structures to track each extent buffer.
   In fact, my ealier approach did that:

   https://lore.kernel.org/linux-btrfs/3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com/

   However that can cause a very significant negative impact on
   performance, not only due to the extra memory usage but also because
   we get a larger and deeper dirty_log_pages io tree.
   We got a report that, on beefy machines at least, we can get such
   performance drop with fsmark for example:

   https://lore.kernel.org/linux-btrfs/20220117082426.GE32491@xsang-OptiPlex-9020/

2) We would be doing it only to deal with an unexpected and exceptional
   case, which is basically failure to read an extent buffer from disk
   due to IO failures. On a healthy system we don't expect transaction
   aborts to happen after all;

3) Instead of relying on iterating the log tree or tracking the ranges
   of extent buffers in the dirty_log_pages io tree, using the radix
   tree that tracks extent buffers (fs_info->buffer_radix) to find all
   log tree extent buffers is not reliable either, because after writeback
   of an extent buffer it can be evicted from memory by the release page
   callback of the btree inode (btree_releasepage()).

Since there's no way to be able to properly cleanup a log tree without
being able to read its extent buffers from disk and without using more
memory to track the logical ranges of the allocated extent buffers do
the following:

1) When we fail to cleanup a log tree, setup a flag that indicates that
   failure;

2) Trigger writeback of all log tree extent buffers that are still dirty,
   and wait for the writeback to complete. This is just to cleanup their
   state, page states, page leaks, etc;

3) When unmounting the fs, ignore if the number of bytes reserved in a
   block group and in a space_info is not 0 if, and only if, we failed to
   cleanup a log tree. Also ignore only for metadata block groups and the
   metadata space_info object.

This is far from a perfect solution, but it serves to silence test
failures such as those from generic/475 and generic/648. However having
a non-zero value for the reserved bytes counters on unmount after a
transaction abort, is not such a terrible thing and it's completely
harmless, it does not affect the filesystem integrity in any way.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 26 ++++++++++++++++++++++++--
 fs/btrfs/ctree.h       |  6 ++++++
 fs/btrfs/tree-log.c    | 23 +++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1db24e6d6d90..ef725a3406b2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -124,7 +124,16 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 {
 	if (refcount_dec_and_test(&cache->refs)) {
 		WARN_ON(cache->pinned > 0);
-		WARN_ON(cache->reserved > 0);
+		/*
+		 * If there was a failure to cleanup a log tree, very likely due
+		 * to an IO failure on a writeback attempt of one or more of its
+		 * extent buffers, we could not do proper (and cheap) unaccounting
+		 * of their reserved space, so don't warn on reserved > 0 in that
+		 * case.
+		 */
+		if (!(cache->flags & BTRFS_BLOCK_GROUP_METADATA) ||
+		    !BTRFS_FS_LOG_CLEANUP_ERROR(cache->fs_info))
+			WARN_ON(cache->reserved > 0);
 
 		/*
 		 * A block_group shouldn't be on the discard_list anymore.
@@ -3974,9 +3983,22 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		 * important and indicates a real bug if this happens.
 		 */
 		if (WARN_ON(space_info->bytes_pinned > 0 ||
-			    space_info->bytes_reserved > 0 ||
 			    space_info->bytes_may_use > 0))
 			btrfs_dump_space_info(info, space_info, 0, 0);
+
+		/*
+		 * If there was a failure to cleanup a log tree, very likely due
+		 * to an IO failure on a writeback attempt of one or more of its
+		 * extent buffers, we could not do proper (and cheap) unaccounting
+		 * of their reserved space, so don't warn on bytes_reserved > 0 in
+		 * that case.
+		 */
+		if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
+		    !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
+			if (WARN_ON(space_info->bytes_reserved > 0))
+				btrfs_dump_space_info(info, space_info, 0, 0);
+		}
+
 		WARN_ON(space_info->reclaim_size > 0);
 		list_del(&space_info->list);
 		btrfs_sysfs_remove_space_info(space_info);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 459d00211181..fea9a0fd8894 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -145,6 +145,9 @@ enum {
 	BTRFS_FS_STATE_DUMMY_FS_INFO,
 
 	BTRFS_FS_STATE_NO_CSUMS,
+
+	/* Indicates there was an error cleaning up a log tree. */
+	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
 };
 
 #define BTRFS_BACKREF_REV_MAX		256
@@ -3601,6 +3604,9 @@ do {								\
 
 #define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
 						   &(fs_info)->fs_state)))
+#define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info) \
+	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR, \
+			   &(fs_info)->fs_state)))
 
 __printf(5, 6)
 __cold
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a54ee3a1d082..97ce445fd434 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3396,6 +3396,29 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	if (log->node) {
 		ret = walk_log_tree(trans, log, &wc);
 		if (ret) {
+			/*
+			 * We weren't able to traverse the entire log tree, the
+			 * typical scenario is getting an -EIO when reading an
+			 * extent buffer of the tree, due to a previous writeback
+			 * failure of it.
+			 */
+			set_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
+				&log->fs_info->fs_state);
+
+			/*
+			 * Some extent buffers of the log tree may still be dirty
+			 * and not yet written back to storage, because we may
+			 * have updates to a log tree without syncing a log tree,
+			 * such as during rename and link operations. So flush
+			 * them out and wait for their writeback to complete, so
+			 * that we properly cleanup their state and pages.
+			 */
+			btrfs_write_marked_extents(log->fs_info,
+						   &log->dirty_log_pages,
+						   EXTENT_DIRTY | EXTENT_NEW);
+			btrfs_wait_tree_log_extents(log,
+						    EXTENT_DIRTY | EXTENT_NEW);
+
 			if (trans)
 				btrfs_abort_transaction(trans, ret);
 			else
-- 
2.33.0

