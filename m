Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66B8E47DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbfJYJxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 05:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390193AbfJYJxp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 05:53:45 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57CE21929
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571997224;
        bh=L5jNtXAGIXyC0pEzjikRjjYwyHzKYAYv6uOpuYN+DhY=;
        h=From:To:Subject:Date:From;
        b=gIcfM8OEEh7/rR7CjfXqGlcnLWIVZ5HTtZUuAxIqNqtc24uTJcQSZ/6iUxW3QoiQr
         xGK6fkhZGiLG8V2yzLMTFUA5WeKbkp7KwnHZbNzBb+R2A2uj1zSLCDAeMbhnZb9WVd
         EJDrICzyF8Vkj+su0HzYmFd3SourmypR3G7Jqhjo=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix race leading to metadata space leak after task received signal
Date:   Fri, 25 Oct 2019 10:53:41 +0100
Message-Id: <20191025095341.18704-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When a task that is allocating metadata needs to wait for the async
reclaim job to process its ticket and gets a signal (because it was killed
for example) before doing the wait, the task ends up erroring out but
with space reserved for its ticket, which never gets released, resulting
in a metadata space leak (more specifically a leak in the bytes_may_use
counter of the metadata space_info object).

Here's the sequence of steps leading to the space leak:

1) A task tries to create a file for example, so it ends up trying to
   start a transaction at btrfs_create();

2) The filesystem is currently in a state where there is not enough
   metadata free space to satisfy the transaction's needs. So at
   space-info.c:__reserve_metadata_bytes() we create a ticket and
   add it to the list of tickets of the space info object. Also,
   because the metadata async reclaim job is not running, we queue
   a job ro run metadata reclaim;

3) In the meanwhile the task receives a signal (like SIGTERM from
   a kill command for example);

4) After queing the async reclaim job, at __reserve_metadata_bytes(),
   we unlock the metadata space info and call handle_reserve_ticket();

5) That last function calls wait_reserve_ticket(), which acquires the
   lock from the metadata space info. Then in the first iteration of
   its while loop, it calls prepare_to_wait_event(), which returns
   -ERESTARTSYS because the task has a pending signal. As a result,
   we set the error field of the ticket to -EINTR and exit the while
   loop without deleting the ticket from the list of tickets (in the
   space info object). After exiting the loop we unlock the space info;

6) The async reclaim job is able to release enough metadata, acquires
   the metadata space info's lock and then reserves space for the ticket,
   since the ticket is still in the list of (non-priority) tickets. The
   space reservation happens at btrfs_try_granting_tickets(), called from
   maybe_fail_all_tickets(). This increments the bytes_may_use counter
   from the metadata space info object, sets the ticket's bytes field to
   zero (meaning success, that space was reserved) and removes it from
   the list of tickets;

7) wait_reserve_ticket() returns, with the error field of the ticket
   set to -EINTR. Then handle_reserve_ticket() just propagates that error
   to the caller. Because an error was returned, the caller does not
   release the reserved space, since the expectation is that any error
   means no space was reserved.

Fix this by removing the ticket from the list, while holding the space
info lock, at wait_reserve_ticket() when prepare_to_wait_event() returns
an error.

Also add some comments and an assertion to guarantee we never end up with
a ticket that has an error set and a bytes counter field set to zero, to
more easily detect regressions in the future.

This issue could be triggered sporadically by some test cases from fstests
such as generic/269 for example, which tries to fill a filesystem and then
kills fsstress processes running in the background.

When this issue happens, we get a warning in syslog/dmesg when unmounting
the filesystem, like the following:

 [Tue Oct  1 17:24:23 2019] ------------[ cut here ]------------
 [Tue Oct  1 17:24:23 2019] WARNING: CPU: 0 PID: 13240 at fs/btrfs/block-group.c:3186 btrfs_free_block_groups+0x314/0x470 [btrfs]
 (...)
 [Tue Oct  1 17:24:23 2019] CPU: 0 PID: 13240 Comm: umount Tainted: G        W    L    5.3.0-rc8-btrfs-next-48+ #1
 [Tue Oct  1 17:24:23 2019] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
 [Tue Oct  1 17:24:23 2019] RIP: 0010:btrfs_free_block_groups+0x314/0x470 [btrfs]
 (...)
 [Tue Oct  1 17:24:24 2019] RSP: 0018:ffff9910c14cfdb8 EFLAGS: 00010286
 [Tue Oct  1 17:24:24 2019] RAX: 0000000000000024 RBX: ffff89cd8a4d55f0 RCX: 0000000000000000
 [Tue Oct  1 17:24:24 2019] RDX: 0000000000000000 RSI: ffff89cdf6a178a8 RDI: ffff89cdf6a178a8
 [Tue Oct  1 17:24:24 2019] RBP: ffff9910c14cfde8 R08: 0000000000000000 R09: 0000000000000001
 [Tue Oct  1 17:24:24 2019] R10: ffff89cd4d618040 R11: 0000000000000000 R12: ffff89cd8a4d5508
 [Tue Oct  1 17:24:24 2019] R13: ffff89cde7c4a600 R14: dead000000000122 R15: dead000000000100
 [Tue Oct  1 17:24:24 2019] FS:  00007f42754432c0(0000) GS:ffff89cdf6a00000(0000) knlGS:0000000000000000
 [Tue Oct  1 17:24:24 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [Tue Oct  1 17:24:24 2019] CR2: 00007fd25a47f730 CR3: 000000021f8d6006 CR4: 00000000003606f0
 [Tue Oct  1 17:24:24 2019] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [Tue Oct  1 17:24:24 2019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [Tue Oct  1 17:24:24 2019] Call Trace:
 [Tue Oct  1 17:24:24 2019]  close_ctree+0x1ad/0x390 [btrfs]
 [Tue Oct  1 17:24:24 2019]  generic_shutdown_super+0x6c/0x110
 [Tue Oct  1 17:24:24 2019]  kill_anon_super+0xe/0x30
 [Tue Oct  1 17:24:24 2019]  btrfs_kill_super+0x12/0xa0 [btrfs]
 [Tue Oct  1 17:24:24 2019]  deactivate_locked_super+0x3a/0x70
 [Tue Oct  1 17:24:24 2019]  cleanup_mnt+0xb4/0x160
 [Tue Oct  1 17:24:24 2019]  task_work_run+0x7e/0xc0
 [Tue Oct  1 17:24:24 2019]  exit_to_usermode_loop+0xfa/0x100
 [Tue Oct  1 17:24:24 2019]  do_syscall_64+0x1cb/0x220
 [Tue Oct  1 17:24:24 2019]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 [Tue Oct  1 17:24:24 2019] RIP: 0033:0x7f4274d2cb37
 (...)
 [Tue Oct  1 17:24:24 2019] RSP: 002b:00007ffcff701d38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
 [Tue Oct  1 17:24:24 2019] RAX: 0000000000000000 RBX: 0000557ebde2f060 RCX: 00007f4274d2cb37
 [Tue Oct  1 17:24:24 2019] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000557ebde2f240
 [Tue Oct  1 17:24:24 2019] RBP: 0000557ebde2f240 R08: 0000557ebde2f270 R09: 0000000000000015
 [Tue Oct  1 17:24:24 2019] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f427522ee64
 [Tue Oct  1 17:24:24 2019] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffcff701fc0
 [Tue Oct  1 17:24:24 2019] irq event stamp: 0
 [Tue Oct  1 17:24:24 2019] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 [Tue Oct  1 17:24:24 2019] hardirqs last disabled at (0): [<ffffffffb12b561e>] copy_process+0x75e/0x1fd0
 [Tue Oct  1 17:24:24 2019] softirqs last  enabled at (0): [<ffffffffb12b561e>] copy_process+0x75e/0x1fd0
 [Tue Oct  1 17:24:24 2019] softirqs last disabled at (0): [<0000000000000000>] 0x0
 [Tue Oct  1 17:24:24 2019] ---[ end trace bcf4b235461b26f6 ]---
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): space_info 4 has 19116032 free, is full
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): space_info total=33554432, used=14176256, pinned=0, reserved=0, may_use=196608, readonly=65536
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): global_block_rsv: size 0 reserved 0
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): trans_block_rsv: size 0 reserved 0
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): chunk_block_rsv: size 0 reserved 0
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): delayed_block_rsv: size 0 reserved 0
 [Tue Oct  1 17:24:24 2019] BTRFS info (device sdb): delayed_refs_rsv: size 0 reserved 0

Fixes: 374bf9c5cd7d0b ("btrfs: unify error handling for ticket flushing")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 260a883994b9..ada89bdcae3c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -892,6 +892,15 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 	while (ticket->bytes > 0 && ticket->error == 0) {
 		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
 		if (ret) {
+			/*
+			 * Delete us from the list. After we unlock the space
+			 * info, we don't want the async reclaim job to reserve
+			 * space for this ticket. If that would happen, then the
+			 * ticket's task would not known that space was reserved
+			 * despite getting an error, resulting in a space leak
+			 * (bytes_may_use counter of our space_info).
+			 */
+			list_del_init(&ticket->list);
 			ticket->error = -EINTR;
 			break;
 		}
@@ -944,12 +953,24 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	spin_lock(&space_info->lock);
 	ret = ticket->error;
 	if (ticket->bytes || ticket->error) {
+		/*
+		 * Need to delete here for priority tickets. For regular tickets
+		 * either the async reclaim job deletes the ticket from the list
+		 * or we delete it ourselves at wait_reserve_ticket().
+		 */
 		list_del_init(&ticket->list);
 		if (!ret)
 			ret = -ENOSPC;
 	}
 	spin_unlock(&space_info->lock);
 	ASSERT(list_empty(&ticket->list));
+	/*
+	 * Check that we can't have an error set if the reservation succeeded,
+	 * as that would confuse tasks and lead them to error out without
+	 * releasing reserved space (if an error happens the expectation is that
+	 * space wasn't reserved at all).
+	 */
+	ASSERT(!(ticket->bytes == 0 && ticket->error));
 	return ret;
 }
 
-- 
2.11.0

