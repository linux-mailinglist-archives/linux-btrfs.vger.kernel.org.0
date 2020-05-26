Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE261B97BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0GuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 02:50:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgD0GuU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 02:50:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56EE4AC85
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 06:50:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: transaction: Avoid deadlock due to bad initialization timing of fs_info::journal_info
Date:   Mon, 27 Apr 2020 14:50:14 +0800
Message-Id: <20200427065014.46502-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
One run of btrfs/063 triggered the following lockdep:
  ============================================
  WARNING: possible recursive locking detected
  5.6.0-rc7-custom+ #48 Not tainted
  --------------------------------------------
  kworker/u24:0/7 is trying to acquire lock:
  ffff88817d3a46e0 (sb_internal#2){.+.+}, at: start_transaction+0x66c/0x890 [btrfs]

  but task is already holding lock:
  ffff88817d3a46e0 (sb_internal#2){.+.+}, at: start_transaction+0x66c/0x890 [btrfs]

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(sb_internal#2);
    lock(sb_internal#2);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  4 locks held by kworker/u24:0/7:
   #0: ffff88817b495948 ((wq_completion)btrfs-endio-write){+.+.}, at: process_one_work+0x557/0xb80
   #1: ffff888189ea7db8 ((work_completion)(&work->normal_work)){+.+.}, at: process_one_work+0x557/0xb80
   #2: ffff88817d3a46e0 (sb_internal#2){.+.+}, at: start_transaction+0x66c/0x890 [btrfs]
   #3: ffff888174ca4da8 (&fs_info->reloc_mutex){+.+.}, at: btrfs_record_root_in_trans+0x83/0xd0 [btrfs]

  stack backtrace:
  CPU: 0 PID: 7 Comm: kworker/u24:0 Not tainted 5.6.0-rc7-custom+ #48
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
  Call Trace:
   dump_stack+0xc2/0x11a
   __lock_acquire.cold+0xce/0x214
   lock_acquire+0xe6/0x210
   __sb_start_write+0x14e/0x290
   start_transaction+0x66c/0x890 [btrfs]
   btrfs_join_transaction+0x1d/0x20 [btrfs]
   find_free_extent+0x1504/0x1a50 [btrfs]
   btrfs_reserve_extent+0xd5/0x1f0 [btrfs]
   btrfs_alloc_tree_block+0x1ac/0x570 [btrfs]
   btrfs_copy_root+0x213/0x580 [btrfs]
   create_reloc_root+0x3bd/0x470 [btrfs]
   btrfs_init_reloc_root+0x2d2/0x310 [btrfs]
   record_root_in_trans+0x191/0x1d0 [btrfs]
   btrfs_record_root_in_trans+0x90/0xd0 [btrfs]
   start_transaction+0x16e/0x890 [btrfs]
   btrfs_join_transaction+0x1d/0x20 [btrfs]
   btrfs_finish_ordered_io+0x55d/0xcd0 [btrfs]
   finish_ordered_fn+0x15/0x20 [btrfs]
   btrfs_work_helper+0x116/0x9a0 [btrfs]
   process_one_work+0x632/0xb80
   worker_thread+0x80/0x690
   kthread+0x1a3/0x1f0
   ret_from_fork+0x27/0x50

It's pretty hard to reproduce, only one hit so far.

[CAUSE]
This is because we're calling btrfs_join_transaction() without re-using
the current running one:

btrfs_finish_ordered_io()
|- btrfs_join_transaction()		<<< Call #1
   |- btrfs_record_root_in_trans()
      |- btrfs_reserve_extent()
	 |- btrfs_join_transaction()	<<< Call #2

Normally such btrfs_join_transaction() call should re-use the existing
one, without trying to re-start a transaction.

But the problem is, in btrfs_join_transaction() call #1, we call
btrfs_record_root_in_trans() before initializing current::journal_info.

And in btrfs_join_transaction() call #2, we're relying on
current::journal_info to avoid such deadlock.

[FIX]
Call btrfs_record_root_in_trans() after we have initialized
current::journal_info.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/transaction.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8cede6eb9843..132bf2f1aa0d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -662,10 +662,19 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	}
 
 got_it:
-	btrfs_record_root_in_trans(h, root);
-
 	if (!current->journal_info)
 		current->journal_info = h;
+
+	/*
+	 * btrfs_record_root_in_trans() need to alloc new extents, and may
+	 * call btrfs_join_transaction() while we're also starting a
+	 * transaction.
+	 *
+	 * Thus it need to be called after current->journal_info initialized,
+	 * or we can deadlock.
+	 */
+	btrfs_record_root_in_trans(h, root);
+
 	return h;
 
 join_fail:
-- 
2.26.2

