Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E93151752
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgBDJDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 04:03:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:40222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJDX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 04:03:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0531FAD0F;
        Tue,  4 Feb 2020 09:03:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2] btrfs: Don't submit any btree write bio after transaction is aborted
Date:   Tue,  4 Feb 2020 17:03:14 +0800
Message-Id: <20200204090314.15278-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a fuzzed image which could cause KASAN report at unmount time.

  ==================================================================
  BUG: KASAN: use-after-free in btrfs_queue_work+0x2c1/0x390
  Read of size 8 at addr ffff888067cf6848 by task umount/1922

  CPU: 0 PID: 1922 Comm: umount Tainted: G        W         5.0.21 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   dump_stack+0x5b/0x8b
   print_address_description+0x70/0x280
   kasan_report+0x13a/0x19b
   btrfs_queue_work+0x2c1/0x390
   btrfs_wq_submit_bio+0x1cd/0x240
   btree_submit_bio_hook+0x18c/0x2a0
   submit_one_bio+0x1be/0x320
   flush_write_bio.isra.41+0x2c/0x70
   btree_write_cache_pages+0x3bb/0x7f0
   do_writepages+0x5c/0x130
   __writeback_single_inode+0xa3/0x9a0
   writeback_single_inode+0x23d/0x390
   write_inode_now+0x1b5/0x280
   iput+0x2ef/0x600
   close_ctree+0x341/0x750
   generic_shutdown_super+0x126/0x370
   kill_anon_super+0x31/0x50
   btrfs_kill_super+0x36/0x2b0
   deactivate_locked_super+0x80/0xc0
   deactivate_super+0x13c/0x150
   cleanup_mnt+0x9a/0x130
   task_work_run+0x11a/0x1b0
   exit_to_usermode_loop+0x107/0x130
   do_syscall_64+0x1e5/0x280
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

[CAUSE]
The fuzzed image has a completely screwd up extent tree:
  leaf 29421568 gen 9 total ptrs 6 free space 3587 owner 18446744073709551610
  refs 2 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 5938
          item 0 key (12587008 168 4096) itemoff 3942 itemsize 53
                  extent refs 1 gen 9 flags 1
                  ref#0: extent data backref root 5 objectid 259 offset 0 count 1
          item 1 key (12591104 168 8192) itemoff 3889 itemsize 53
                  extent refs 1 gen 9 flags 1
                  ref#0: extent data backref root 5 objectid 271 offset 0 count 1
          item 2 key (12599296 168 4096) itemoff 3836 itemsize 53
                  extent refs 1 gen 9 flags 1
                  ref#0: extent data backref root 5 objectid 259 offset 4096 count 1
          item 3 key (29360128 169 0) itemoff 3803 itemsize 33
                  extent refs 1 gen 9 flags 2
                  ref#0: tree block backref root 5
          item 4 key (29368320 169 1) itemoff 3770 itemsize 33
                  extent refs 1 gen 9 flags 2
                  ref#0: tree block backref root 5
          item 5 key (29372416 169 0) itemoff 3737 itemsize 33
                  extent refs 1 gen 9 flags 2
                  ref#0: tree block backref root 5

1. Wrong owner
   The corrupted leaf has owner -6ULL, which matches
   BTRFS_TREE_LOG_OBJECTID.

2. Missing backref for extent tree itself
   So extent allocator can allocate tree block 29421568 as a new tree
   block.

Above corruption leads to the following sequence to happen:
- Btrfs needs to COW extent tree
  Extent allocator choose to allocate eb at bytenr 29421568 (which is
  current extent tree root).

  And since the owner is copied from old eb, it's -6ULL, so
  btrfs_init_new_buffer() will not mark the range dirty in
  transaction->dirty_pages, but root->dirty_log_pages.

  Also, since the eb is already under usage, extent root doesn't even
  get marked DIRTY, nor added to dirty_cowonly_list.
  Thus even we try to iterate dirty roots to cleanup their
  dirty_log_pages, this particular extent tree won't be iterated.

- run_delayed_refs() failed
  As we can't find the backref for some tree blocks.

- btrfs_abort_transaction() get triggered
  Which will also trigger btrfs_cleanup_one_transaction().
  In that function, we will search transaction->dirty_pages to cleanup.

  But above tree block at 29421568 is not recorded in
  transaction->dirty_pages, so it's not cleaned up.

- Umount happenes
  Btrfs will first stop all workers, then call ipuit() on btree inode.
  But btree inode still has one dirty extent buffer at 29421568.

  Then we will try to write the dirty eb back, but since all workers as
  been freed, we trigger a use-after-free bug.

[FIX]
To fix this problem, make btree_write_cache_pages() to check if the
transaction is aborted before submitting write bio.

This is the last safe net in case all other cleanup failed to catch such
problem.

Link: https://github.com/bobfuzzer/CVE/tree/master/CVE-2019-19377
CVE: CVE-2019-19377
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- More detailed reason on why the dirty pages are not cleaned up
  So regular cleanup method won't work on this extremely corrupted case.
  Thus we still need this last resort method to prevent use-after-free.
---
 fs/btrfs/extent_io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f4802f405a2..0c58c7c230e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3927,6 +3927,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
+	struct btrfs_fs_info *fs_info = tree->fs_info;
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
@@ -4036,7 +4037,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 		end_write_bio(&epd, ret);
 		return ret;
 	}
-	ret = flush_write_bio(&epd);
+	if (!test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state)) {
+		ret = flush_write_bio(&epd);
+	} else {
+		ret = -EUCLEAN;
+		end_write_bio(&epd, ret);
+	}
 	return ret;
 }
 
-- 
2.25.0

