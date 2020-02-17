Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2B1616E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBQQAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 11:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgBQQAp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 11:00:45 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D049206F4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581955244;
        bh=KL4ioOz6NCyIq6iZU3dCofR/NqUuhoyOsOYkTiKSgmw=;
        h=From:To:Subject:Date:From;
        b=JY5ddVu1irkqca8/Pj4h5OB4EUHC671ssY49sWLhjaGiARZBztgNI5SPpVb7LMjy/
         1l3HT7+9Q4E5b7mDZf+fFK7w1RlQ6TVGWypdXeQ0qTnOkCelIweGnAC5ZIpQNJ/JW5
         g4WP/YO0LzCPcBk3sMrQL97M+1su4u8oyCqvDyRw=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix possible sleep in atomic context during a shrinking truncate
Date:   Mon, 17 Feb 2020 16:00:40 +0000
Message-Id: <20200217160040.21922-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit 28553fa992cb28 ("Btrfs: fix race between shrinking truncate and
fiemap") added a file range unlock before freeing and releasing a path.
This can trigger a sleep while in an atomic context, which is reported
by a debugging kernel:

[   70.794783] BUG: sleeping function called from invalid context at mm/slab.h:565
[   70.794834] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1141, name: rsync
[   70.794863] 5 locks held by rsync/1141:
[   70.794876]  #0: ffff888417b9c408 (sb_writers#17){.+.+}, at: mnt_want_write+0x20/0x50
[   70.795030]  #1: ffff888428de28e8 (&type->i_mutex_dir_key#13/1){+.+.}, at: lock_rename+0xf1/0x100
[   70.795051]  #2: ffff888417b9c608 (sb_internal#2){.+.+}, at: start_transaction+0x394/0x560
[   70.795124]  #3: ffff888403081768 (btrfs-fs-01){++++}, at: btrfs_try_tree_write_lock+0x2f/0x160
[   70.795203]  #4: ffff888403086568 (btrfs-fs-00){++++}, at: btrfs_try_tree_write_lock+0x2f/0x160
[   70.795222] CPU: 5 PID: 1141 Comm: rsync Not tainted 5.6.0-rc2-backup+ #2
[   70.795291] Hardware name: ASUS All Series/Z97-DELUXE, BIOS 3503 04/18/2018
[   70.795362] Call Trace:
[   70.795374]  dump_stack+0x71/0xa0
[   70.795445]  ___might_sleep.part.96.cold.106+0xa6/0xb6
[   70.795459]  kmem_cache_alloc+0x1d3/0x290
[   70.795471]  alloc_extent_state+0x22/0x1c0
[   70.795544]  __clear_extent_bit+0x3ba/0x580
[   70.795557]  ? _raw_spin_unlock_irq+0x24/0x30
[   70.795569]  btrfs_truncate_inode_items+0x339/0xe50
[   70.795647]  btrfs_evict_inode+0x269/0x540
[   70.795659]  ? dput.part.38+0x29/0x460
[   70.795671]  evict+0xcd/0x190
[   70.795682]  __dentry_kill+0xd6/0x180
[   70.795754]  dput.part.38+0x2ad/0x460
[   70.795765]  do_renameat2+0x3cb/0x540
[   70.795777]  __x64_sys_rename+0x1c/0x20
[   70.795788]  do_syscall_64+0x6d/0x6b0
[   70.795864]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   70.795876]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   70.795889] RIP: 0033:0x7f7fa39256d7
(...)
[   70.795990] RSP: 002b:00007ffc8ad171a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
[   70.796070] RAX: ffffffffffffffda RBX: 00007ffc8ad19350 RCX: 00007f7fa39256d7
[   70.796084] RDX: 0000000000000000 RSI: 00007ffc8ad17350 RDI: 00007ffc8ad19350
[   70.796097] RBP: 00007ffc8ad17350 R08: 0000000000000000 R09: 0000000000000000
[   70.796170] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   70.796184] R13: 0000000000000004 R14: 00000000000081a4 R15: 0000000000000000

This happens because when we unlock the range we might be still holding
spin locks on some extent buffers in our search path, since the path has
the property 'leave_spinning' set, and unlocking the range attempts to
allocate an extent_state structure in a non-atomic mode at
__clear_extent_bit().

The patch was developed against the integration branch, 'misc-next' from
David Sterba, where we don't use a path in spinning mode anymore, whence
it was not detected earlier.

To fix this just free the path, which releases any spin locks on the
search path, before unlocking the file range. This is temporary and it
will no longer be necessary for the next merge window.

Reported-by: Dave Jones <davej@codemonkey.org.uk>
Fixes: 28553fa992cb28 ("Btrfs: fix race between shrinking truncate and fiemap")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 90c404ae242a..b7b6baa38e10 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4998,10 +4998,15 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		btrfs_inode_safe_disk_i_size_write(inode, last_size);
 	}
 
+	/*
+	 * Release and free the path before unlocking the range because we might
+	 * be holding spin locks on some extent buffers.
+	 */
+	btrfs_free_path(path);
+
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
 			     &cached_state);
 
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.11.0

