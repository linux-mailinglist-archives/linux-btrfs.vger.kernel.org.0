Return-Path: <linux-btrfs+bounces-9635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ABA9C8A15
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EA7B31685
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C331F9AB6;
	Thu, 14 Nov 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MruVZxws"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B871F9A9E
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587294; cv=none; b=BNw90ZlgcbiCD7ygfG2bdgDu9n0D6ljX9+EruI24QazBE8oQOKL+KFcVOT0iQDtmoqwwa8rTWK7+8mc+5LwLiafinlTFIU8ykcHcpQdml0XUNcvIr5lwYj0X1KttZUQ+M8j9gNW4GEE4ZHXSXdvpatgZwEMCA3PyJqN8zKVVKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587294; c=relaxed/simple;
	bh=mu7O6v1l5iNVmaRUgT5ZAD1rw5R9FbbcdM5sd7cbCc8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fVLgfAGBLnUf6hCKW3pn9/Bl4o1uapJerErwcizD5DxzwEBBfReUzeCSYoVCaN7HixgL2iwAg505Th6gpve4LqLa2KKQ2PsSRvL/Gj/Yjf7GnLNAL3lk/2md9XKqJlFtpuPGdwoGvFHz7yta9HqjRfeVY7XDT3LOhItOURXj52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MruVZxws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03710C4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731587293;
	bh=mu7O6v1l5iNVmaRUgT5ZAD1rw5R9FbbcdM5sd7cbCc8=;
	h=From:To:Subject:Date:From;
	b=MruVZxwsW4Kv4zqnrtAyNCI9RWPvUwvC+wj+lrap6P0pAACAJ/q76VgL+EU7nM/bt
	 kcOrnW89tNofdiriTUIDOlGJCdSHenzib8Yc3JFXF/BiKKMPL+rflgR7q3wTs9xlgk
	 HW58yHfbCnIe4zBJz5YRiEwRik9o+FwRSZR1XZzwi9L0maon6Hc4jvXbOmgSBaxtVa
	 X2GnvLUJ/7i3WFHn6N/rfywZnQLWwz6pjAp8BBp5w1rWtHTm8UxJeO7QD6VbMlMuV3
	 6rToeEMGPx/JO3yGZz9LsCPMtytEml2ND6Kebd5DEUqun7mYFDC3EKKDsICtM/GYo+
	 kR4RzaPom+Giw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix deadlock between transaction commits and extent locks
Date: Thu, 14 Nov 2024 12:28:09 +0000
Message-Id: <47f1eba1edf0ae59484c3ff1e8e3c4a4269a7444.1731587182.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When running a workload with fsstress and duperemove (generic/561) we can
hit a deadlock related to transaction commits and locking extent ranges,
as described below.

Task A hanging during a transaction commit, waiting for all other writers
to complete:

  [178317.334817] INFO: task fsstress:555623 blocked for more than 120 seconds.
  [178317.335693]       Not tainted 6.12.0-rc6-btrfs-next-179+ #1
  [178317.336528] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [178317.337673] task:fsstress        state:D stack:0     pid:555623 tgid:555623 ppid:555620 flags:0x00004002
  [178317.337679] Call Trace:
  [178317.337681]  <TASK>
  [178317.337685]  __schedule+0x364/0xbe0
  [178317.337691]  schedule+0x26/0xa0
  [178317.337695]  btrfs_commit_transaction+0x5c5/0x1050 [btrfs]
  [178317.337769]  ? start_transaction+0xc4/0x800 [btrfs]
  [178317.337815]  ? __pfx_autoremove_wake_function+0x10/0x10
  [178317.337819]  btrfs_mksubvol+0x381/0x640 [btrfs]
  [178317.337878]  btrfs_mksnapshot+0x7a/0xb0 [btrfs]
  [178317.337935]  __btrfs_ioctl_snap_create+0x1bb/0x1d0 [btrfs]
  [178317.337995]  btrfs_ioctl_snap_create_v2+0x103/0x130 [btrfs]
  [178317.338053]  btrfs_ioctl+0x29b/0x2a90 [btrfs]
  [178317.338118]  ? kmem_cache_alloc_noprof+0x5f/0x2c0
  [178317.338126]  ? getname_flags+0x45/0x1f0
  [178317.338133]  ? _raw_spin_unlock+0x15/0x30
  [178317.338145]  ? __x64_sys_ioctl+0x88/0xc0
  [178317.338149]  __x64_sys_ioctl+0x88/0xc0
  [178317.338152]  do_syscall_64+0x4a/0x110
  [178317.338160]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [178317.338190] RIP: 0033:0x7f13c28e271b

Which corresponds to line 2361 of transaction.c:

  $ cat -n fs/btrfs/transaction.c
  (...)
  2162  int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
  2163  {
  (...)
  2349          spin_lock(&fs_info->trans_lock);
  2350          add_pending_snapshot(trans);
  2351          cur_trans->state = TRANS_STATE_COMMIT_DOING;
  2352          spin_unlock(&fs_info->trans_lock);
  2353
  2354          /*
  2355           * The thread has started/joined the transaction thus it holds the
  2356           * lockdep map as a reader. It has to release it before acquiring the
  2357           * lockdep map as a writer.
  2358           */
  2359          btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
  2360          btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);
  2361          wait_event(cur_trans->writer_wait,
  2362                     atomic_read(&cur_trans->num_writers) == 1);
  (...)

The transaction is in the TRANS_STATE_COMMIT_DOING state and so it's
waiting for all other existing writers to complete and release their
transaction handle.

Task B is running ordered extent completion and blocked waiting to lock an
extent range in an inode's io tree:

  [178317.327411] INFO: task kworker/u48:8:554545 blocked for more than 120 seconds.
  [178317.328630]       Not tainted 6.12.0-rc6-btrfs-next-179+ #1
  [178317.329635] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [178317.330872] task:kworker/u48:8   state:D stack:0     pid:554545 tgid:554545 ppid:2      flags:0x00004000
  [178317.330878] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
  [178317.330944] Call Trace:
  [178317.330945]  <TASK>
  [178317.330947]  __schedule+0x364/0xbe0
  [178317.330952]  schedule+0x26/0xa0
  [178317.330955]  __lock_extent+0x337/0x3a0 [btrfs]
  [178317.331014]  ? __pfx_autoremove_wake_function+0x10/0x10
  [178317.331017]  btrfs_finish_one_ordered+0x47a/0xaa0 [btrfs]
  [178317.331074]  ? psi_group_change+0x132/0x2d0
  [178317.331078]  btrfs_work_helper+0xbd/0x370 [btrfs]
  [178317.331140]  process_scheduled_works+0xd3/0x460
  [178317.331144]  ? __pfx_worker_thread+0x10/0x10
  [178317.331146]  worker_thread+0x121/0x250
  [178317.331149]  ? __pfx_worker_thread+0x10/0x10
  [178317.331151]  kthread+0xe9/0x120
  [178317.331154]  ? __pfx_kthread+0x10/0x10
  [178317.331157]  ret_from_fork+0x2d/0x50
  [178317.331159]  ? __pfx_kthread+0x10/0x10
  [178317.331162]  ret_from_fork_asm+0x1a/0x30

This extent range locking happens after joining the current transaction,
so task A is waiting for task B to release its transaction handle
(decrementing the transaction's num_writers counter).

Task C while doing a fiemap it tries to join the current transaction:

  [242682.812815] task:pool            state:D stack:0     pid:560767 tgid:560724 ppid:555622 flags:0x00004006
  [242682.812827] Call Trace:
  [242682.812856]  <TASK>
  [242682.812864]  __schedule+0x364/0xbe0
  [242682.812879]  ? _raw_spin_unlock_irqrestore+0x23/0x40
  [242682.812897]  schedule+0x26/0xa0
  [242682.812909]  wait_current_trans+0xd6/0x130 [btrfs]
  [242682.813148]  ? __pfx_autoremove_wake_function+0x10/0x10
  [242682.813162]  start_transaction+0x3d4/0x800 [btrfs]
  [242682.813399]  btrfs_is_data_extent_shared+0xd2/0x440 [btrfs]
  [242682.813723]  fiemap_process_hole+0x2a2/0x300 [btrfs]
  [242682.813995]  extent_fiemap+0x9b8/0xb80 [btrfs]
  [242682.814249]  btrfs_fiemap+0x78/0xc0 [btrfs]
  [242682.814501]  do_vfs_ioctl+0x2db/0xa50
  [242682.814519]  __x64_sys_ioctl+0x6a/0xc0
  [242682.814531]  do_syscall_64+0x4a/0x110
  [242682.814544]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [242682.814556] RIP: 0033:0x7efff595e71b

It tries to join the current transaction, but it can't because the
transaction is in the TRANS_STATE_COMMIT_DOING state, so
join_transaction() returns -EBUSY to start_transaction() and makes it
wait for the current transaction to complete. And while it's waiting
for the transaction to complete, it's holding an extent range locked
in the same inode that task B is operating, which causes a deadlock
between these 3 tasks. The extent range for the inode was locked at
the start of the fiemap operation, early at extent_fiemap().

In short these tasks deadlock because:

1) Task A is waiting for task B to release its transaction handle;

2) Task B is waiting to lock an extent range for an inode while holding a
   transaction handle open;

3) Task C is waiting for the current transaction to complete (for task A
   to finish the transaction commit) while holding the extent range for
   the inode locked, so task B can't progress and release its transaction
   handle.

This results in an ABBA deadlock involving transaction commits and extent
locks. Extent locks are higher level locks, like inode VFS locks, and
should always be acquired before joining or starting a transaction, but
recently commit 2206265f41e9 ("btrfs: remove code duplication in ordered
extent finishing") accidentally changed btrfs_finish_one_ordered() to do
the transaction join before locking the extent range.

Fix this by making sure that btrfs_finish_one_ordered() always locks the
extent before joining a transaction and add an explicit comment about the
need for this order.

Fixes: 2206265f41e9 ("btrfs: remove code duplication in ordered extent finishing")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 22b8e2764619..cfdb537636fe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3063,6 +3063,19 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			goto out;
 	}
 
+	/*
+	 * If it's a COW write we need to lock the extent range as we will be
+	 * inserting/replacing file extent items and unpinning an extent map.
+	 * This must be taken before joining a transaction, as it's a higher
+	 * level lock (like the inode's VFS lock), otherwise we can run into an
+	 * ABBA deadlock with other tasks (transactions work like a lock,
+	 * depending on their current state).
+	 */
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
+		clear_bits |= EXTENT_LOCKED;
+		lock_extent(io_tree, start, end, &cached_state);
+	}
+
 	if (freespace_inode)
 		trans = btrfs_join_transaction_spacecache(root);
 	else
@@ -3099,9 +3112,6 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	clear_bits |= EXTENT_LOCKED;
-	lock_extent(io_tree, start, end, &cached_state);
-
 	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
-- 
2.45.2


