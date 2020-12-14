Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695822D9595
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgLNJ5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 04:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgLNJ5g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 04:57:36 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs: fix race between cloning and memory mapped writes leading to deadlock
Date:   Mon, 14 Dec 2020 09:56:41 +0000
Message-Id: <9a8d26f60a41dc934fe4c44a5b50b1c2c15c9174.1607939569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1607939569.git.fdmanana@suse.com>
References: <cover.1607939569.git.fdmanana@suse.com>
In-Reply-To: <cover.1607939569.git.fdmanana@suse.com>
References: <cover.1607939569.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When cloning a file range, we lock the inodes, flush any delalloc within
the respective file ranges, wait for any ordered extents and then lock the
file ranges in both inodes. This means that right after we flush delalloc
and before we lock the file ranges, memory mapped writes can come in and
dirty pages in the file ranges of the clone operation.

Most of the time this is harmless and causes no problems. However, if we
are low on available metadata space, we can later end up in a deadlock
when starting a transaction to replace file extent items. This happens if
when allocating metadata space for the transaction, we need to wait for
the async reclaim thread to release space and the reclaim thread needs to
flush delalloc for the inode that got the memory mapped write and has its
range locked by the clone task.

Basically what happens is the following:

1) A clone operation locks inodes A and B, flushes delalloc for both
   inodes in the respective file ranges and waits for any ordered extents
   in those ranges to complete;

2) Before the clone task locks the file ranges, another task does a
   memory mapped write (which does not lock the inode) for one of the
   inodes of the clone operation. So now we have a dirty page in one of
   the ranges used by the clone operation;

3) The clone operation locks the file ranges for inodes A and B;

4) Later, when iterating over the file extents of inode A, the clone
   task attempts to start a transaction. There's not enough available
   free metadata space, so the async reclaim task is started (if not
   running already) and we wait for someone to wake us up on our
   reservation ticket;

5) The async reclaim task is not able to release space by any other
   means and decides to flush delalloc for the inode of the clone
   operation;

6) The workqueue job used to flush the inode blocks when starting
   delalloc for the inode, since the file range is currently locked by
   the clone task;

7) But the clone task is waiting on its reservation ticket and the async
   reclaim task is waiting on the flush job to complete, which can't
   progress since the clone task has the file range locked. So unless
   some other task is able to release space, for example an ordered
   extent for some other inode completes, we have a deadlock between all
   these tasks;

When this happens stack traces like the following showup in dmesg/syslog:

 INFO: task kworker/u16:11:1810830 blocked for more than 120 seconds.
       Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u16:11  state:D stack:    0 pid:1810830 ppid:     2 flags:0x00004000
 Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
 Call Trace:
  __schedule+0x5d1/0xcf0
  schedule+0x45/0xe0
  lock_extent_bits+0x1e6/0x2d0 [btrfs]
  ? finish_wait+0x90/0x90
  btrfs_invalidatepage+0x32c/0x390 [btrfs]
  ? __mod_memcg_state+0x8e/0x160
  __extent_writepage+0x2d4/0x400 [btrfs]
  extent_write_cache_pages+0x2b2/0x500 [btrfs]
  ? lock_release+0x20e/0x4c0
  ? trace_hardirqs_on+0x1b/0xf0
  extent_writepages+0x43/0x90 [btrfs]
  ? lock_acquire+0x1a3/0x490
  do_writepages+0x43/0xe0
  ? __filemap_fdatawrite_range+0xa4/0x100
  __filemap_fdatawrite_range+0xc5/0x100
  btrfs_run_delalloc_work+0x17/0x40 [btrfs]
  btrfs_work_helper+0xf1/0x600 [btrfs]
  process_one_work+0x24e/0x5e0
  worker_thread+0x50/0x3b0
  ? process_one_work+0x5e0/0x5e0
  kthread+0x153/0x170
  ? kthread_mod_delayed_work+0xc0/0xc0
  ret_from_fork+0x22/0x30
 INFO: task kworker/u16:1:2426217 blocked for more than 120 seconds.
       Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u16:1   state:D stack:    0 pid:2426217 ppid:     2 flags:0x00004000
 Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
 Call Trace:
  __schedule+0x5d1/0xcf0
  ? kvm_clock_read+0x14/0x30
  ? wait_for_completion+0x81/0x110
  schedule+0x45/0xe0
  schedule_timeout+0x30c/0x580
  ? _raw_spin_unlock_irqrestore+0x3c/0x60
  ? lock_acquire+0x1a3/0x490
  ? try_to_wake_up+0x7a/0xa20
  ? lock_release+0x20e/0x4c0
  ? lock_acquired+0x199/0x490
  ? wait_for_completion+0x81/0x110
  wait_for_completion+0xab/0x110
  start_delalloc_inodes+0x2af/0x390 [btrfs]
  btrfs_start_delalloc_roots+0x12d/0x250 [btrfs]
  flush_space+0x24f/0x660 [btrfs]
  btrfs_async_reclaim_metadata_space+0x1bb/0x480 [btrfs]
  process_one_work+0x24e/0x5e0
  worker_thread+0x20f/0x3b0
  ? process_one_work+0x5e0/0x5e0
  kthread+0x153/0x170
  ? kthread_mod_delayed_work+0xc0/0xc0
  ret_from_fork+0x22/0x30
(...)
several other tasks blocked on inode locks held by the clone task below
(...)
 RIP: 0033:0x7f61efe73fff
 Code: Unable to access opcode bytes at RIP 0x7f61efe73fd5.
 RSP: 002b:00007ffc3371bbe8 EFLAGS: 00000202 ORIG_RAX: 000000000000013c
 RAX: ffffffffffffffda RBX: 00007ffc3371bea0 RCX: 00007f61efe73fff
 RDX: 00000000ffffff9c RSI: 0000560fbd604690 RDI: 00000000ffffff9c
 RBP: 00007ffc3371beb0 R08: 0000000000000002 R09: 0000560fbd5d75f0
 R10: 0000560fbd5d81f0 R11: 0000000000000202 R12: 0000000000000002
 R13: 000000000000000b R14: 00007ffc3371bea0 R15: 00007ffc3371beb0
 task: fdm-stress        state:D stack:    0 pid:2508234 ppid:2508153 flags:0x00004000
 Call Trace:
  __schedule+0x5d1/0xcf0
  ? _raw_spin_unlock_irqrestore+0x3c/0x60
  schedule+0x45/0xe0
  __reserve_bytes+0x4a4/0xb10 [btrfs]
  ? finish_wait+0x90/0x90
  btrfs_reserve_metadata_bytes+0x29/0x190 [btrfs]
  btrfs_block_rsv_add+0x1f/0x50 [btrfs]
  start_transaction+0x2d1/0x760 [btrfs]
  btrfs_replace_file_extents+0x120/0x930 [btrfs]
  ? lock_release+0x20e/0x4c0
  btrfs_clone+0x3e4/0x7e0 [btrfs]
  ? btrfs_lookup_first_ordered_extent+0x8e/0x100 [btrfs]
  btrfs_clone_files+0xf6/0x150 [btrfs]
  btrfs_remap_file_range+0x324/0x3d0 [btrfs]
  do_clone_file_range+0xd4/0x1f0
  vfs_clone_file_range+0x4d/0x230
  ? lock_release+0x20e/0x4c0
  ioctl_file_clone+0x8f/0xc0
  do_vfs_ioctl+0x342/0x750
  __x64_sys_ioctl+0x62/0xb0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

So fix this by checking for new delalloc extents in the ranges after
locking them, and if any exist, unlock the ranges, flush delalloc, wait
for ordered extents to complete and then retry.

This modifies the existing helper btrfs_lock_and_flush_ordered_range() to
be able to detect and flush new delalloc extents in the range we want to
lock. The new behaviour is conditional, since it is not needed in any of
its existing callers, and in fact it's not desired at all in the buffered
write path because that would cause us do unnecessary IO when attempting
to write to an already dirty range. The clone now calls this helper to
lock file ranges.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/ordered-data.c | 48 ++++++++++++++++++++++++++++++++---------
 fs/btrfs/ordered-data.h |  6 +++---
 fs/btrfs/reflink.c      | 28 ++++++++++++++++++------
 6 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e3b72e63e42..c5337c3c811e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3409,7 +3409,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
 	int index;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, false, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
 		btrfs_do_readpage(pages[index], em_cached, bio, bio_flags,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..dd2d5d73804d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1510,7 +1510,7 @@ static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 		}
 	} else {
 		btrfs_lock_and_flush_ordered_range(inode, lockstart,
-						   lockend, NULL);
+						   lockend, false, NULL);
 	}
 
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..20a580a0f9ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4886,7 +4886,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 		return 0;
 
 	btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end - 1,
-					   &cached_state);
+					   false, &cached_state);
 	cur_offset = hole_start;
 	while (1) {
 		em = btrfs_get_extent(inode, NULL, 0, cur_offset,
@@ -8069,7 +8069,7 @@ int btrfs_readpage(struct file *file, struct page *page)
 	struct bio *bio = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, false, NULL);
 
 	ret = btrfs_do_readpage(page, NULL, &bio, &bio_flags, 0, NULL);
 	if (bio)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 79d366a36223..7a762e62703a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -858,31 +858,50 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
  * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
  * ordered extents in it are run to completion.
  *
+ * Also, optionally, flush any dirty pages within the range. This is to prevent
+ * deadlocks in case our caller starts a transaction after it locked the range,
+ * and if right before it locked a range a memory mapped write came in. Such
+ * deadlock can happen when we are low on metadata space and if reserving the
+ * metadata space for the transaction requires the async reclaim worker to flush
+ * delalloc.
+ *
  * @inode:        Inode whose ordered tree is to be searched
  * @start:        Beginning of range to flush
  * @end:          Last byte of range to lock
+ * @flush_dirty:  Whether we should or not flush any dirty pages in the range.
  * @cached_state: If passed, will return the extent state responsible for the
  * locked range. It's the caller's responsibility to free the cached state.
  *
  * This function always returns with the given range locked, ensuring after it's
- * called no order extent can be pending.
+ * called no ordered extent can be pending and, optionally, there are no dirty
+ * pages within the range as well.
+ *
+ * This function always returns 0 (success) when @flush_dirty is false, but can
+ * return an error (negative errno) when @flush_dirty is true and there was an
+ * error flushing delalloc.
  */
-void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
-					u64 end,
-					struct extent_state **cached_state)
+int btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
+				       u64 end, bool flush_dirty,
+				       struct extent_state **cached_state)
 {
+	const u64 len = end - start + 1;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cache = NULL;
 	struct extent_state **cachedp = &cache;
+	int ret = 0;
 
 	if (cached_state)
 		cachedp = cached_state;
 
-	while (1) {
+	while (!ret) {
+		bool has_delalloc = false;
+
 		lock_extent_bits(&inode->io_tree, start, end, cachedp);
-		ordered = btrfs_lookup_ordered_range(inode, start,
-						     end - start + 1);
-		if (!ordered) {
+		ordered = btrfs_lookup_ordered_range(inode, start, len);
+		if (flush_dirty)
+			has_delalloc = test_range_bit(&inode->io_tree, start, end,
+						      EXTENT_DELALLOC, 0, *cachedp);
+		if (!ordered && !has_delalloc) {
 			/*
 			 * If no external cached_state has been passed then
 			 * decrement the extra ref taken for cachedp since we
@@ -893,9 +912,18 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 			break;
 		}
 		unlock_extent_cached(&inode->io_tree, start, end, cachedp);
-		btrfs_start_ordered_extent(ordered, 1);
-		btrfs_put_ordered_extent(ordered);
+
+		if (flush_dirty)
+			ret = btrfs_wait_ordered_range(&inode->vfs_inode, start,
+						       len);
+		else if (ordered)
+			btrfs_start_ordered_extent(ordered, 1);
+
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
 	}
+
+	return ret;
 }
 
 int __init ordered_data_init(void)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 0bfa82b58e23..fe2b04983388 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -187,9 +187,9 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			      const u64 range_start, const u64 range_len);
-void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
-					u64 end,
-					struct extent_state **cached_state);
+int btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
+				       u64 end, bool flush_dirty,
+				       struct extent_state **cached_state);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b03e7891394e..823486511c1c 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -574,17 +574,29 @@ static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1,
 	unlock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1);
 }
 
-static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
-				     struct inode *inode2, u64 loff2, u64 len)
+static int btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
+				    struct inode *inode2, u64 loff2, u64 len)
 {
+	int ret;
+
 	if (inode1 < inode2) {
 		swap(inode1, inode2);
 		swap(loff1, loff2);
 	} else if (inode1 == inode2 && loff2 < loff1) {
 		swap(loff1, loff2);
 	}
-	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1);
-	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1);
+
+	ret = btrfs_lock_and_flush_ordered_range(BTRFS_I(inode1), loff1,
+						 loff1 + len - 1, true, NULL);
+	if (ret)
+		return ret;
+
+	ret = btrfs_lock_and_flush_ordered_range(BTRFS_I(inode2), loff2,
+						 loff2 + len - 1, true, NULL);
+	if (ret)
+		unlock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1);
+
+	return ret;
 }
 
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
@@ -597,7 +609,9 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	 * Lock destination range to serialize with concurrent readpages() and
 	 * source range to serialize with relocation.
 	 */
-	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
+	ret = btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
+	if (ret)
+		return ret;
 	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
 	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
 
@@ -691,7 +705,9 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	 * Lock destination range to serialize with concurrent readpages() and
 	 * source range to serialize with relocation.
 	 */
-	btrfs_double_extent_lock(src, off, inode, destoff, len);
+	ret = btrfs_double_extent_lock(src, off, inode, destoff, len);
+	if (ret)
+		return ret;
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
 	btrfs_double_extent_unlock(src, off, inode, destoff, len);
 
-- 
2.28.0

