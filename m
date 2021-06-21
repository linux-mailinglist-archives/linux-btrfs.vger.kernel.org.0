Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5063AE6C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFUKM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 06:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFUKM5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 06:12:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42D1160FE9
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624270243;
        bh=7urVwjHKTbHahZJedmq9q+ESzfBGpsVjmutmks68IMs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BC02O2ZbNYX9d0ciRLQcURxWEe1SVqB/bOafh9vnq7VJEokNnqHP33vQnKLTXrou1
         rM0Knfr8NBR3xJ0LfGa7G6qG5a7zHNfhamHnSYc+0mjRJffVVVwH9Z3PdV9O1JK6B0
         o6dkoHg8XiP9NoNRrzi21hA6ha7pQqr4/tHVZLXCGM/t4su6DboVvatMFZMKJMcxDS
         5HJSFjhT8b5gW7xYI9y3Ws+eBFXE8cLLFAq0ZhX/XBiHReZc5sRRLnBt3r23TiRtCy
         c35ac7EJytxU7FoyTjymd3XXH1V3AgyvW4l2SEcWJFAMzlOsYxUrzSWPun1dO2j7U4
         Nsnd4ea8phC7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: send: fix crash when memory allocations trigger reclaim
Date:   Mon, 21 Jun 2021 11:10:39 +0100
Message-Id: <33fc2ecb82f1e020c2e4ae7bd51a261a4134e090.1624269734.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624269734.git.fdmanana@suse.com>
References: <cover.1624269734.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a send we don't expect the task to ever start a transaction
after the initial check that verifies if commit roots match the regular
roots. This is because after that we set current->journal_info with a
stub (special value) that signals we are in send context, so that we take
a read lock on an extent buffer when reading it from disk and verifying
it is valid (its generation matches the generation stored in the parent).
This stub was introduced in 2014 by commit a26e8c9f75b0bf ("Btrfs: don't
clear uptodate if the eb is under IO") in order to fix a concurrency issue
between send and balance.

However there is one particular exception where we end up needing to start
a transaction and when this happens it results in a crash with a stack
trace like the following:

[60015.902283] kernel: WARNING: CPU: 3 PID: 58159 at arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x21/0x80
[60015.902292] kernel: Modules linked in: uinput rfcomm snd_seq_dummy (...)
[60015.902384] kernel: CPU: 3 PID: 58159 Comm: btrfs Not tainted 5.12.9-300.fc34.x86_64 #1
[60015.902387] kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88XN-WIFI, BIOS F6 12/24/2015
[60015.902389] kernel: RIP: 0010:kfence_protect_page+0x21/0x80
[60015.902393] kernel: Code: ff 0f 1f 84 00 00 00 00 00 55 48 89 fd (...)
[60015.902396] kernel: RSP: 0018:ffff9fb583453220 EFLAGS: 00010246
[60015.902399] kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9fb583453224
[60015.902401] kernel: RDX: ffff9fb583453224 RSI: 0000000000000000 RDI: 0000000000000000
[60015.902402] kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[60015.902404] kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[60015.902406] kernel: R13: ffff9fb583453348 R14: 0000000000000000 R15: 0000000000000001
[60015.902408] kernel: FS:  00007f158e62d8c0(0000) GS:ffff93bd37580000(0000) knlGS:0000000000000000
[60015.902410] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60015.902412] kernel: CR2: 0000000000000039 CR3: 00000001256d2000 CR4: 00000000000506e0
[60015.902414] kernel: Call Trace:
[60015.902419] kernel:  kfence_unprotect+0x13/0x30
[60015.902423] kernel:  page_fault_oops+0x89/0x270
[60015.902427] kernel:  ? search_module_extables+0xf/0x40
[60015.902431] kernel:  ? search_bpf_extables+0x57/0x70
[60015.902435] kernel:  kernelmode_fixup_or_oops+0xd6/0xf0
[60015.902437] kernel:  __bad_area_nosemaphore+0x142/0x180
[60015.902440] kernel:  exc_page_fault+0x67/0x150
[60015.902445] kernel:  asm_exc_page_fault+0x1e/0x30
[60015.902450] kernel: RIP: 0010:start_transaction+0x71/0x580
[60015.902454] kernel: Code: d3 0f 84 92 00 00 00 80 e7 06 0f 85 63 (...)
[60015.902456] kernel: RSP: 0018:ffff9fb5834533f8 EFLAGS: 00010246
[60015.902458] kernel: RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
[60015.902460] kernel: RDX: 0000000000000801 RSI: 0000000000000000 RDI: 0000000000000039
[60015.902462] kernel: RBP: ffff93bc0a7eb800 R08: 0000000000000001 R09: 0000000000000000
[60015.902463] kernel: R10: 0000000000098a00 R11: 0000000000000001 R12: 0000000000000001
[60015.902464] kernel: R13: 0000000000000000 R14: ffff93bc0c92b000 R15: ffff93bc0c92b000
[60015.902468] kernel:  btrfs_commit_inode_delayed_inode+0x5d/0x120
[60015.902473] kernel:  btrfs_evict_inode+0x2c5/0x3f0
[60015.902476] kernel:  evict+0xd1/0x180
[60015.902480] kernel:  inode_lru_isolate+0xe7/0x180
[60015.902483] kernel:  __list_lru_walk_one+0x77/0x150
[60015.902487] kernel:  ? iput+0x1a0/0x1a0
[60015.902489] kernel:  ? iput+0x1a0/0x1a0
[60015.902491] kernel:  list_lru_walk_one+0x47/0x70
[60015.902495] kernel:  prune_icache_sb+0x39/0x50
[60015.902497] kernel:  super_cache_scan+0x161/0x1f0
[60015.902501] kernel:  do_shrink_slab+0x142/0x240
[60015.902505] kernel:  shrink_slab+0x164/0x280
[60015.902509] kernel:  shrink_node+0x2c8/0x6e0
[60015.902512] kernel:  do_try_to_free_pages+0xcb/0x4b0
[60015.902514] kernel:  try_to_free_pages+0xda/0x190
[60015.902516] kernel:  __alloc_pages_slowpath.constprop.0+0x373/0xcc0
[60015.902521] kernel:  ? __memcg_kmem_charge_page+0xc2/0x1e0
[60015.902525] kernel:  __alloc_pages_nodemask+0x30a/0x340
[60015.902528] kernel:  pipe_write+0x30b/0x5c0
[60015.902531] kernel:  ? set_next_entity+0xad/0x1e0
[60015.902534] kernel:  ? switch_mm_irqs_off+0x58/0x440
[60015.902538] kernel:  __kernel_write+0x13a/0x2b0
[60015.902541] kernel:  kernel_write+0x73/0x150
[60015.902543] kernel:  send_cmd+0x7b/0xd0
[60015.902545] kernel:  send_extent_data+0x5a3/0x6b0
[60015.902549] kernel:  process_extent+0x19b/0xed0
[60015.902551] kernel:  btrfs_ioctl_send+0x1434/0x17e0
[60015.902554] kernel:  ? _btrfs_ioctl_send+0xe1/0x100
[60015.902557] kernel:  _btrfs_ioctl_send+0xbf/0x100
[60015.902559] kernel:  ? enqueue_entity+0x18c/0x7b0
[60015.902562] kernel:  btrfs_ioctl+0x185f/0x2f80
[60015.902564] kernel:  ? psi_task_change+0x84/0xc0
[60015.902569] kernel:  ? _flat_send_IPI_mask+0x21/0x40
[60015.902572] kernel:  ? check_preempt_curr+0x2f/0x70
[60015.902576] kernel:  ? selinux_file_ioctl+0x137/0x1e0
[60015.902579] kernel:  ? expand_files+0x1cb/0x1d0
[60015.902582] kernel:  ? __x64_sys_ioctl+0x82/0xb0
[60015.902585] kernel:  __x64_sys_ioctl+0x82/0xb0
[60015.902588] kernel:  do_syscall_64+0x33/0x40
[60015.902591] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
[60015.902595] kernel: RIP: 0033:0x7f158e38f0ab
[60015.902599] kernel: Code: ff ff ff 85 c0 79 9b (...)
[60015.902602] kernel: RSP: 002b:00007ffcb2519bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[60015.902605] kernel: RAX: ffffffffffffffda RBX: 00007ffcb251ae00 RCX: 00007f158e38f0ab
[60015.902607] kernel: RDX: 00007ffcb2519cf0 RSI: 0000000040489426 RDI: 0000000000000004
[60015.902608] kernel: RBP: 0000000000000004 R08: 00007f158e297640 R09: 00007f158e297640
[60015.902610] kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
[60015.902612] kernel: R13: 0000000000000002 R14: 00007ffcb251aee0 R15: 0000558c1a83e2a0
[60015.902615] kernel: ---[ end trace 7bbc33e23bb887ae ]---

This happens because when writing to the pipe, by calling kernel_write(),
we end up doing page allocations using GFP_HIGHUSER | __GFP_ACCOUNT as the
gfp flags, which allow reclaim to happen if there is memory pressure. This
allocation happens at fs/pipe.c:pipe_write().

If the reclaim is triggered, inode eviction can be triggered and that in
turn can result in starting a transaction if the inode has a link count
of 0. The transaction start happens early on during eviction, when we call
btrfs_commit_inode_delayed_inode() at btrfs_evict_inode(). This happens if
there is currently an open file descriptor for an inode with a link count
of 0 and the reclaim task gets a reference on the inode before that
descriptor is closed, in which case the reclaim task ends up doing the
final iput that triggers the inode eviction.

When we have assertions enabled (CONFIG_BTRFS_ASSERT=y), this triggers
the following assertion at transaction.c:start_transaction():

    /* Send isn't supposed to start transactions. */
    ASSERT(current->journal_info != BTRFS_SEND_TRANS_STUB);

And when assertions are not enabled, it triggers a crash since after that
assertion we cast current->journal_info into a transaction handle pointer
and then dereference it:

   if (current->journal_info) {
       WARN_ON(type & TRANS_EXTWRITERS);
       h = current->journal_info;
       refcount_inc(&h->use_count);
       (...)

Which obviously results in a crash due to an invalid memory access.

The same type of issue can happen during other memory allocations we
do directly in the send code with kmalloc (and friends) as they use
GFP_KERNEL and therefore may trigger reclaim too, which started to
happen since 2016 after commit e780b0d1c1523e ("btrfs: send: use
GFP_KERNEL everywhere").

The issue could be solved by setting up a NOFS context for the entire
send operation so that reclaim could not be triggered when allocating
memory or pages through kernel_write(). However that is not very friendly
and we can in fact get rid of the send stub because:

1) The stub was introduced way back in 2014 by commit a26e8c9f75b0bf
   ("Btrfs: don't clear uptodate if the eb is under IO") to solve an
   issue exclusive to when send and balance are running in paralllel,
   however there were other problems between balance and send and we do
   not allow anymore to have balance and send run concurrently since
   commit 9e967495e0e0ae ("Btrfs: prevent send failures and crashes due
   to concurrent relocation"). More generically the issues are between
   send and relocation, and that last commit eliminated only the
   possibility of having send and balance run concurrently, but shrinking
   a device also can trigger relocation, and on zoned filesystems we have
   relocation of partially used block groups triggered automatically as
   well. The previous patch that has a subject of:

   "btrfs: ensure relocation never runs while we have send operations running"

   Addresses all the remaining cases that can trigger relocation.

2) We can actually allow starting and even committing transactions while
   in a send context if needed because send is not holding any locks that
   would block the start or the commit of a transaction.

So get rid of all the logic added by commit a26e8c9f75b0bf ("Btrfs: don't
clear uptodate if the eb is under IO"). We can now always call
clear_extent_buffer_uptodate() at verify_parent_transid() since send is
the only case that uses commit roots without having a transaction open or
without holding the commit_root_sem.

Reported-by: Chris Murphy <lists@colorremedies.com>
Link: https://lore.kernel.org/linux-btrfs/CAJCQCtRQ57=qXo3kygwpwEBOU_CA_eKvdmjP52sU=eFvuVOEGw@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c     | 18 +-----------------
 fs/btrfs/qgroup.c      |  8 +-------
 fs/btrfs/send.c        |  2 --
 fs/btrfs/transaction.c |  3 ---
 fs/btrfs/transaction.h |  2 --
 5 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3ded062d303c..d1e3424aea16 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -241,7 +241,6 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 {
 	struct extent_state *cached_state = NULL;
 	int ret;
-	bool need_lock = (current->journal_info == BTRFS_SEND_TRANS_STUB);
 
 	if (!parent_transid || btrfs_header_generation(eb) == parent_transid)
 		return 0;
@@ -249,9 +248,6 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	if (atomic)
 		return -EAGAIN;
 
-	if (need_lock)
-		btrfs_tree_read_lock(eb);
-
 	lock_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
 			 &cached_state);
 	if (extent_buffer_uptodate(eb) &&
@@ -264,22 +260,10 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 			eb->start,
 			parent_transid, btrfs_header_generation(eb));
 	ret = 1;
-
-	/*
-	 * Things reading via commit roots that don't have normal protection,
-	 * like send, can have a really old block in cache that may point at a
-	 * block that has been freed and re-allocated.  So don't clear uptodate
-	 * if we find an eb that is under IO (dirty/writeback) because we could
-	 * end up reading in the stale data and then writing it back out and
-	 * making everybody very sad.
-	 */
-	if (!extent_buffer_under_io(eb))
-		clear_extent_buffer_uptodate(eb);
+	clear_extent_buffer_uptodate(eb);
 out:
 	unlock_extent_cached(io_tree, eb->start, eb->start + eb->len - 1,
 			     &cached_state);
-	if (need_lock)
-		btrfs_tree_read_unlock(eb);
 	return ret;
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d72885903b8c..07ec06d4e972 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3545,13 +3545,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	/*
-	 * Can't hold an open transaction or we run the risk of deadlocking,
-	 * and can't either be under the context of a send operation (where
-	 * current->journal_info is set to BTRFS_SEND_TRANS_STUB), as that
-	 * would result in a crash when starting a transaction and does not
-	 * make sense either (send is a read-only operation).
-	 */
+	/* Can't hold an open transaction or we run the risk of deadlocking. */
 	ASSERT(current->journal_info == NULL);
 	if (WARN_ON(current->journal_info))
 		return 0;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 37e502b09a80..6ac37ae6c811 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7427,9 +7427,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	fs_info->send_in_progress++;
 	spin_unlock(&fs_info->send_reloc_lock);
 
-	current->journal_info = BTRFS_SEND_TRANS_STUB;
 	ret = send_subvol(sctx);
-	current->journal_info = NULL;
 	spin_lock(&fs_info->send_reloc_lock);
 	fs_info->send_in_progress--;
 	spin_unlock(&fs_info->send_reloc_lock);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 73df8b81496e..143f7a5dec30 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -583,9 +583,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	bool do_chunk_alloc = false;
 	int ret;
 
-	/* Send isn't supposed to start transactions. */
-	ASSERT(current->journal_info != BTRFS_SEND_TRANS_STUB);
-
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
 		return ERR_PTR(-EROFS);
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 0702e8d9b30e..07d76029f598 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -122,8 +122,6 @@ struct btrfs_transaction {
 
 #define TRANS_EXTWRITERS	(__TRANS_START | __TRANS_ATTACH)
 
-#define BTRFS_SEND_TRANS_STUB	((void *)1)
-
 struct btrfs_trans_handle {
 	u64 transid;
 	u64 bytes_reserved;
-- 
2.28.0

