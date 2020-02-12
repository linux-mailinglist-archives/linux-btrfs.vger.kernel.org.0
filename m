Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1615A133
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 07:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgBLGMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 01:12:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:36050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgBLGMz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 01:12:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76716AE99
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 06:12:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5] btrfs: Don't submit any btree write bio if the fs has error
Date:   Wed, 12 Feb 2020 14:12:44 +0800
Message-Id: <20200212061244.26851-1-wqu@suse.com>
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
  leaf 29421568 gen 8 total ptrs 6 free space 3587 owner EXTENT_TREE
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

Note that, leaf 29421568 doesn't has its backref in extent tree.
Thus extent allocator can re-allocate leaf 29421568 for other trees.

In short, the bug is caused by:
- Existing tree block get allocated to log tree
  This got its generation bumped.

- Log tree balance cleaned dirty bit of offending tree block
  It will not be written back to disk, thus no WRITTEN flag.

- Original owner of the tree block get COWed
  Since the tree block has higher transid, no WRITTEN flag, it's reused,
  and not traced by transaction::dirty_pages.

- Transaction aborted
  Tree blocks get cleaned according to transaction::dirty_pages. But the
  offending tree block is not recorded at all.

- Fs unmount
  Btrfs believes all pages are cleaned, destroying all workqueue, then
  call iput(btree_inode).
  But offending tree block is still dirty, which triggers writeback, and
  cause use-after-free bug.

The detailed sequence looks like this:
- Initial status
  eb: 29421568, header=WRITTEN bflags_dirty=0, page_dirty=0, gen=8,
      not traced by any dirty extent_iot_tree.

- New tree block is allocated
  Since there is no backref for 29421568, it's re-allocated as new tree
  block.
  Keep in mind that, tree block 29421568 is still referred by extent
  tree.

- Tree block 29421568 is filled for log tree
  eb: 29421568, header=0 bflags_dirty=1, page_dirty=1, gen=9 << (gen bumped)
      traced by btrfs_root::dirty_log_pages

- Some log tree operations
  Since the fs is using node size 4096, the log tree can easily go a
  level higher.

- Log tree needs balance
  Tree block 29421568 gets all it content pushed to right, thus now
  it is empty, and btrfs don't need it.
  btrfs_clean_tree_block() from __push_leaf_right() get called.

  eb: 29421568, header=0 bflags_dirty=0, page_dirty=0, gen=9
      traced by btrfs_root::dirty_log_pages

- Log tree write back
  btree_write_cache_pages() go through dirty pages ranges, but since
  page of tree block 29421568 gets cleaned already, it's not written
  back to disk. Thus it doesn't have WRITTEN bit set.
  But ranges in dirty_log_pages are cleared.

  eb: 29421568, header=0 bflags_dirty=0, page_dirty=0, gen=9
      not traced by any dirty extent_iot_tree.

- Extent tree update when committing transaction
  Since tree block 29421568 has transid equals to running trans, and has
  no WRITTEN bit, should_cow_block() will use it directly without adding
  it to btrfs_transaction::dirty_pages.

  eb: 29421568, header=0 bflags_dirty=1, page_dirty=1, gen=9
      not traced by any dirty extent_iot_tree.

  At this stage, we're doomed. We have a dirty eb not traced by any
  extent io tree.

- Transaction get aborted due to corrupted extent tree
  Btrfs cleans up dirty pages according to transaction::dirty_pages and
  btrfs_root::dirty_log_pages.
  But since tree block 29421568 is not traced by either of them, it's
  still dirty.

  eb: 29421568, header=0 bflags_dirty=1, page_dirty=1, gen=9
      not traced by any dirty extent_iot_tree.

- Fs unmount
  Since btrfs believes all its cleanup has done, it destroys all its
  workqueue. Then call iput(btree_inode), expecting no dirty pages.
  But tree 29421568 is still dirty, thus triggering writeback.
  Since all workqueues are already freed, we cause use-after-free.

This shows us that, log tree blocks + bad extent tree can cause wild
dirty pages.

[FIX]
To fix the problem, don't submit any btree write bio if the fs has any
error.
This is the last safe net, just in case other cleanup didn't catch it.

Link: https://github.com/bobfuzzer/CVE/tree/master/CVE-2019-19377
CVE: CVE-2019-19377
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- More detailed reason on why the dirty pages are not cleaned up
  So regular cleanup method won't work on this extremely corrupted case.
  Thus we still need this last resort method to prevent use-after-free.

v3:
- Dig further to find out the cause
  It's log tree bumping transid of existing tree blocks causing the
  problem.
  This breaks COW condition, making btrfs to dirty eb but not tracing
  it.

  The existing cleanup for log tree is fine for sane fs.
  But when fs goes insane, no sane cleanup makes sense now.

v4:
- Add the missing piece of why WRITTEN bit is not set
  It's in tree balance, which calls btrfs_clean_tree_block(), making
  that tree block to have no WRITTEN bit but still has bumped
  generation.
  It's a good adventure, but I won't want to debug such damn complex
  case any more.

v5:
- Check BTRFS_FS_STATE_ERROR instead to provide better coverage
  As there are cases where __btrfs_handle_fs_error() is called without a
  transaction.
  Also change commit message, comment and subject accordingly.
---
 fs/btrfs/extent_io.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f4802f405a2..24475c2ea3c0 100644
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
@@ -4036,7 +4037,39 @@ int btree_write_cache_pages(struct address_space *mapping,
 		end_write_bio(&epd, ret);
 		return ret;
 	}
-	ret = flush_write_bio(&epd);
+	/*
+	 * If something went wrong, don't allow any metadata write bio to be
+	 * submitted.
+	 *
+	 * This would prevent use-after-free if we had dirty pages not
+	 * cleaned up, which can still happen by fuzzed images.
+	 *
+	 * - Bad extent tree
+	 *   Allowing existing tree block to be allocated for other trees.
+	 *
+	 * - Log tree operations
+	 *   Exiting tree blocks get allocated to log tree, bumps its
+	 *   generation, then get cleaned in tree re-balance.
+	 *   Such tree block will not be written back, since it's clean,
+	 *   thus no WRITTEN flag set.
+	 *   And after log writes back, this tree block is not traced by
+	 *   any dirty extent_io_tree.
+	 *
+	 * - Offending tree block gets re-dirtied from its original owner
+	 *   Since it has bumped generation, no WRITTEN flag, it can be
+	 *   reused without COWing. This tree block will not be traced
+	 *   by btrfs_transaction::dirty_pages.
+	 *
+	 *   Now such dirty tree block will not be cleaned by any dirty
+	 *   extent io tree. Thus we don't want to submit such wild eb
+	 *   if the fs already has error.
+	 */
+	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+		ret = flush_write_bio(&epd);
+	} else {
+		ret = -EUCLEAN;
+		end_write_bio(&epd, ret);
+	}
 	return ret;
 }
 
-- 
2.25.0

