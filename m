Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1D2D962A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407324AbgLNKMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbgLNKMN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:12:13 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: run delayed iputs when remounting RO to avoid leaking them
Date:   Mon, 14 Dec 2020 10:10:49 +0000
Message-Id: <4f147e4818c50efb01c3cdc3c8b031afeb6666f8.1607940240.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
References: <cover.1607940240.git.fdmanana@suse.com>
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
References: <cover.1607940240.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When remounting RO, after setting the superblock with the RO flag, the
cleaner task will start sleeping and do nothing, since the call to
btrfs_need_cleaner_sleep() keeps returning 'true'. However, when the
cleaner task goes to sleep, the list of delayed iputs may not be empty.

As long as we are in RO mode, the cleaner task will keep sleeping and
never run the delayed iputs. This means that if a filesystem unmount
is started, we get into close_ctree() with a non-empty list of delayed
iputs, and because the filesystem is in RO mode and is not in an error
state (or a transaction aborted), btrfs_error_commit_super() and
btrfs_commit_super(), which run the delayed iputs, are never called,
and later we fail the assertion that checks if the delayed iputs list
is empty:

  assertion failed: list_empty(&fs_info->delayed_iputs), in fs/btrfs/disk-io.c:4049
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3153!
  invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
  CPU: 1 PID: 3780621 Comm: umount Tainted: G             L    5.6.0-rc2-btrfs-next-73 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
  RIP: 0010:assertfail.constprop.0+0x18/0x26 [btrfs]
  Code: 8b 7b 58 48 85 ff 74 (...)
  RSP: 0018:ffffb748c89bbdf8 EFLAGS: 00010246
  RAX: 0000000000000051 RBX: ffff9608f2584000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffffff91998988 RDI: 00000000ffffffff
  RBP: ffff9608f25870d8 R08: 0000000000000000 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc0cbc500
  R13: ffffffff92411750 R14: 0000000000000000 R15: ffff9608f2aab250
  FS:  00007fcbfaa66c80(0000) GS:ffff960936c80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fffc2c2dd38 CR3: 0000000235e54002 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   close_ctree+0x1a2/0x2e6 [btrfs]
   generic_shutdown_super+0x6c/0x100
   kill_anon_super+0x14/0x30
   btrfs_kill_super+0x12/0x20 [btrfs]
   deactivate_locked_super+0x31/0x70
   cleanup_mnt+0x100/0x160
   task_work_run+0x93/0xc0
   exit_to_usermode_loop+0xf9/0x100
   do_syscall_64+0x20d/0x260
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7fcbfaca6307
  Code: eb 0b 00 f7 d8 64 89 (...)
  RSP: 002b:00007fffc2c2ed68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
  RAX: 0000000000000000 RBX: 0000558203b559b0 RCX: 00007fcbfaca6307
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000558203b55bc0
  RBP: 0000000000000000 R08: 0000000000000001 R09: 00007fffc2c2dad0
  R10: 0000558203b55bf0 R11: 0000000000000246 R12: 0000558203b55bc0
  R13: 00007fcbfadcc204 R14: 0000558203b55aa8 R15: 0000000000000000
  Modules linked in: btrfs dm_flakey dm_log_writes (...)
  ---[ end trace d44d303790049ef6 ]---

So fix this by making the remount RO path run any remaining delayed iputs
after waiting for the cleaner to become inactive.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 38740cc2919f..12d7d3be7cd4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1978,6 +1978,16 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
 			    TASK_UNINTERRUPTIBLE);
 
+		/*
+		 * We've set the superblock to RO mode, so we might have made
+		 * the cleaner task sleep without running all pending delayed
+		 * iputs. Go through all the delayed iputs here, so that if an
+		 * unmount happens without remounting RW we don't end up at
+		 * finishing close_ctree() with a non-empty list of delayed
+		 * iputs.
+		 */
+		btrfs_run_delayed_iputs(fs_info);
+
 		btrfs_dev_replace_suspend_for_unmount(fs_info);
 		btrfs_scrub_cancel(fs_info);
 		btrfs_pause_balance(fs_info);
-- 
2.28.0

