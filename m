Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF32354188
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 13:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhDELcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 07:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbhDELcZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Apr 2021 07:32:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8CA961396
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Apr 2021 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617622339;
        bh=32WEG/FsYiG/5fV9K+3y5eaIRDHVE/caxqYjNiQwa64=;
        h=From:To:Subject:Date:From;
        b=kI1fpNK/73iErvWOfZt2eocxbCnN2Tpw4S/kcknhQ86M55EFTghrRJWcofgZaibWT
         GzsXp6dJb/CspshByK9YXwXWqJUadVl/+ubYLDveXVx4z/gjQxTvh1w3H+m0Wlry/w
         TPQtrgU1s2Y43dgmhqZOO7vFMhPNRfOcAant736imYQSw7T+7r02Ebb8JnMJb4gGuX
         5vjZfJwOz3q4df1eh67aCyByyEESZR2sNQtjXI0eiNV+Xp+97PWPUs8sJBd1tEn8U2
         wUcn4WVAFbkCIPDkdXS9+Hk/5U56S8jjDP2igILQ3fFTNioMFT8BOr5skvadb294UJ
         g0uZWL1Gy3pcQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix race between transaction aborts and fsyncs leading to use-after-free
Date:   Mon,  5 Apr 2021 12:32:16 +0100
Message-Id: <8e712682d53a4d6b0f983dd5569f2d78e5f12863.1617622240.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There is a race between a task aborting a transaction during a commit,
a task doing an fsync and the transaction kthread, which leads to an
use-after-free of the log root tree. When this happens, it results in a
stack trace like the following:

[99678.547335] BTRFS info (device dm-0): forced readonly
[99678.547340] BTRFS warning (device dm-0): Skipping commit of aborted transaction.
[99678.547341] BTRFS: error (device dm-0) in cleanup_transaction:1958: errno=-5 IO failure
[99678.547373] BTRFS warning (device dm-0): lost page write due to IO error on /dev/mapper/error-test (-5)
[99678.547533] BTRFS warning (device dm-0): Skipping commit of aborted transaction.
[99678.548743] BTRFS warning (device dm-0): direct IO failed ino 261 rw 0,0 sector 0xa4e8 len 4096 err no 10
[99678.549188] BTRFS error (device dm-0): error writing primary super block to device 1
[99678.551100] BTRFS warning (device dm-0): direct IO failed ino 261 rw 0,0 sector 0x12e000 len 4096 err no 10
[99678.551149] BTRFS warning (device dm-0): direct IO failed ino 261 rw 0,0 sector 0x12e008 len 4096 err no 10
[99678.551205] BTRFS warning (device dm-0): direct IO failed ino 261 rw 0,0 sector 0x12e010 len 4096 err no 10
[99678.551401] BTRFS: error (device dm-0) in write_all_supers:4110: errno=-5 IO failure (1 errors while writing supers)
[99678.565169] BTRFS: error (device dm-0) in btrfs_sync_log:3308: errno=-5 IO failure
[99678.566132] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b68: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
[99678.567526] CPU: 2 PID: 2458471 Comm: fsstress Not tainted 5.12.0-rc5-btrfs-next-84 #1
[99678.568531] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[99678.569980] RIP: 0010:__mutex_lock+0x139/0xa40
[99678.570556] Code: c0 74 19 (...)
[99678.573752] RSP: 0018:ffff9f18830d7b00 EFLAGS: 00010202
[99678.574723] RAX: 6b6b6b6b6b6b6b68 RBX: 0000000000000001 RCX: 0000000000000002
[99678.576027] RDX: ffffffffb9c54d13 RSI: 0000000000000000 RDI: 0000000000000000
[99678.577314] RBP: ffff9f18830d7bc0 R08: 0000000000000000 R09: 0000000000000000
[99678.578601] R10: ffff9f18830d7be0 R11: 0000000000000001 R12: ffff8c6cd199c040
[99678.579890] R13: ffff8c6c95821358 R14: 00000000fffffffb R15: ffff8c6cbcf01358
[99678.581282] FS:  00007fa9140c2b80(0000) GS:ffff8c6fac600000(0000) knlGS:0000000000000000
[99678.582818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[99678.583771] CR2: 00007fa913d52000 CR3: 000000013d2b4003 CR4: 0000000000370ee0
[99678.584600] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[99678.585425] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[99678.586247] Call Trace:
[99678.586542]  ? __btrfs_handle_fs_error+0xde/0x146 [btrfs]
[99678.587260]  ? btrfs_sync_log+0x7c1/0xf20 [btrfs]
[99678.587930]  ? btrfs_sync_log+0x7c1/0xf20 [btrfs]
[99678.588573]  btrfs_sync_log+0x7c1/0xf20 [btrfs]
[99678.589222]  btrfs_sync_file+0x40c/0x580 [btrfs]
[99678.589947]  do_fsync+0x38/0x70
[99678.590514]  __x64_sys_fsync+0x10/0x20
[99678.591196]  do_syscall_64+0x33/0x80
[99678.591829]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[99678.592744] RIP: 0033:0x7fa9142a55c3
[99678.593403] Code: 8b 15 09 (...)
[99678.596777] RSP: 002b:00007fff26278d48 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
[99678.598143] RAX: ffffffffffffffda RBX: 0000563c83cb4560 RCX: 00007fa9142a55c3
[99678.599450] RDX: 00007fff26278cb0 RSI: 00007fff26278cb0 RDI: 0000000000000005
[99678.600770] RBP: 0000000000000005 R08: 0000000000000001 R09: 00007fff26278d5c
[99678.602067] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000340
[99678.603380] R13: 00007fff26278de0 R14: 00007fff26278d96 R15: 0000563c83ca57c0
[99678.604714] Modules linked in: btrfs dm_zero dm_snapshot dm_thin_pool (...)
[99678.616646] ---[ end trace ee2f1b19327d791d ]---

The steps that lead to this crash are the following:

1) We are at transaction N;

2) We have two tasks with a transaction handle attached to transaction N.
   Task A and Task B. Task B is doing an fsync;

3) Task B is at btrfs_sync_log(), and has saved fs_info->log_root_tree
   into a local variable named 'log_root_tree' at the top of
   btrfs_sync_log(). Task B is about to call write_all_supers(), but
   before that...

4) Task A calls btrfs_commit_transaction(), and after it sets the
   transaction state to TRANS_STATE_COMMIT_START, an error happens before
   it waits for the transaction's 'num_writers' counter to reach a value
   of 1 (no one else attached to the transaction), so it jumps to the
   label "cleanup_transaction";

5) Task A then calls cleanup_transaction(), where it aborts the
   transaction, setting BTRFS_FS_STATE_TRANS_ABORTED on fs_info->fs_state,
   setting the ->aborted field of the transaction and the handle to an
   errno value and also setting BTRFS_FS_STATE_ERROR on fs_info->fs_state.

   After that, at cleanup_transaction(), it deletes the transaction from
   the list of transactions (fs_info->trans_list), sets the transaction
   to the state TRANS_STATE_COMMIT_DOING and then waits for the number
   of writers to go down to 1, as it's currently 2 (1 for task A and 1
   for task B);

6) The transaction kthread is running and sees that BTRFS_FS_STATE_ERROR
   is set in fs_info->fs_state, so it calls btrfs_cleanup_transaction().

   There it sees the list fs_info->trans_list is empty, and then proceeds
   into calling btrfs_drop_all_logs(), which frees the log root tree with
   a call to btrfs_free_log_root_tree();

7) Task B calls write_all_supers() and, shortly after, under the label
   'out_wake_log_root', it deferences the pointer stored in
   'log_root_tree', which was already freed in the previous step by the
   transaction kthread. This results in a use-after-free leading to a
   crash.

Fix this by deleting the transaction from the list of transactions at
cleanup_transaction() only after setting the transaction state to
TRANS_STATE_COMMIT_DOING and waiting for all existing tasks that are
attached to the transaction to release their transaction handles.
This makes the transaction kthread wait for all the tasks attached to
the transaction to be done with the transaction before dropping the
log roots and doing other cleanups.

Fixes: ef67963dac255b ("btrfs: drop logs when we've aborted a transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 97c5e7396bce..d56d3e7ca324 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1966,7 +1966,6 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 	 */
 	BUG_ON(list_empty(&cur_trans->list));
 
-	list_del_init(&cur_trans->list);
 	if (cur_trans == fs_info->running_transaction) {
 		cur_trans->state = TRANS_STATE_COMMIT_DOING;
 		spin_unlock(&fs_info->trans_lock);
@@ -1975,6 +1974,17 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 
 		spin_lock(&fs_info->trans_lock);
 	}
+
+	/*
+	 * Now that we know no one else is still using the transaction we can
+	 * remove the transaction from the list of transactions. This avoids
+	 * the transaction kthread from cleaning up the transaction while some
+	 * other task is still using it, which could result in a use-after-free
+	 * on things like log trees, as it forces the transaction kthread to
+	 * wait for this transaction to be cleaned up by us.
+	 */
+	list_del_init(&cur_trans->list);
+
 	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_cleanup_one_transaction(trans->transaction, fs_info);
-- 
2.28.0

