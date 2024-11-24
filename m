Return-Path: <linux-btrfs+bounces-9853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBB9D6E6B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6871621D4
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFA1B6D1F;
	Sun, 24 Nov 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5Mnsn/i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDB1B6CFF;
	Sun, 24 Nov 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452032; cv=none; b=aPLLqwPWGplCDIddsmTNvpt8k+WL40ZRnC4upbfqfof4Vsala8JTZJJw5pQxfxW4hSV3/0njGJF5UyCErILO8wDIGddfQVv49JveE2YW4IsVvXsh63WPC1CEWAD1WIsXHe7IJKWnjtCqXd6NzS7DGcKP6I9Xc4rG0kC9XE1Ffn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452032; c=relaxed/simple;
	bh=xPwrJzil96GzTPtGcJabTqPe0OEUVmRB46aP5g4Z4kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfjHj2A6QkzoVZ2shBOWWdbbcMV0llHpmbvAFI05xNMn4g5nSiX9EKBlVEQGoKqIH1vqif7EzbNfrvnaCUuNQ0DIu1OrdFkMln+DsxKTmZhKchfRyZTRh09hZ0vRmDPiCnuXk/noINRHWTUt7no/Sad6mbiCi/59T28rt/N8nQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5Mnsn/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B003FC4CECC;
	Sun, 24 Nov 2024 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452031;
	bh=xPwrJzil96GzTPtGcJabTqPe0OEUVmRB46aP5g4Z4kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5Mnsn/ir3o8wJoYI2MxA+GVSb0a4qsm7jHqAiZQbWextTgnI2nmKR7+35Tu5Ik2p
	 q7Yn/VQnl846hmsmDpYCqhXAQvUCxzwXJE6fOjTQdAn2JnmxdMx1ma7TrgMxOPIh1x
	 I/50nb2J0uwFNuHa+CiP2ot4IFhmazpUITU8X6AAsitoIi1WiKQRhEI0sK1bwwwS+E
	 wFr2X7RwlU4J0YpdvEijzDNh1gAs9hhNxAlHVTLFtrXEnBsBmL5QX0en/XvlF3fWgY
	 Qw7/U0XazbA7wu2SEwkmMEOCuIbBtumMaRarezmJsSf69HZwKEbB3zBfHbB4wUhXU+
	 RFLD8HjReGleQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 08/16] btrfs: don't take dev_replace rwsem on task already holding it
Date: Sun, 24 Nov 2024 07:39:45 -0500
Message-ID: <20241124124009.3336072-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 8cca35cb29f81eba3e96ec44dad8696c8a2f9138 ]

Running fstests btrfs/011 with MKFS_OPTIONS="-O rst" to force the usage of
the RAID stripe-tree, we get the following splat from lockdep:

 BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev/sdb started

 ============================================
 WARNING: possible recursive locking detected
 6.11.0-rc3-btrfs-for-next #599 Not tainted
 --------------------------------------------
 btrfs/2326 is trying to acquire lock:
 ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250

 but task is already holding lock:
 ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&fs_info->dev_replace.rwsem);
   lock(&fs_info->dev_replace.rwsem);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by btrfs/2326:
  #0: ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250

 stack backtrace:
 CPU: 1 UID: 0 PID: 2326 Comm: btrfs Not tainted 6.11.0-rc3-btrfs-for-next #599
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x80
  __lock_acquire+0x2798/0x69d0
  ? __pfx___lock_acquire+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  lock_acquire+0x19d/0x4a0
  ? btrfs_map_block+0x39f/0x2250
  ? __pfx_lock_acquire+0x10/0x10
  ? find_held_lock+0x2d/0x110
  ? lock_is_held_type+0x8f/0x100
  down_read+0x8e/0x440
  ? btrfs_map_block+0x39f/0x2250
  ? __pfx_down_read+0x10/0x10
  ? do_raw_read_unlock+0x44/0x70
  ? _raw_read_unlock+0x23/0x40
  btrfs_map_block+0x39f/0x2250
  ? btrfs_dev_replace_by_ioctl+0xd69/0x1d00
  ? btrfs_bio_counter_inc_blocked+0xd9/0x2e0
  ? __kasan_slab_alloc+0x6e/0x70
  ? __pfx_btrfs_map_block+0x10/0x10
  ? __pfx_btrfs_bio_counter_inc_blocked+0x10/0x10
  ? kmem_cache_alloc_noprof+0x1f2/0x300
  ? mempool_alloc_noprof+0xed/0x2b0
  btrfs_submit_chunk+0x28d/0x17e0
  ? __pfx_btrfs_submit_chunk+0x10/0x10
  ? bvec_alloc+0xd7/0x1b0
  ? bio_add_folio+0x171/0x270
  ? __pfx_bio_add_folio+0x10/0x10
  ? __kasan_check_read+0x20/0x20
  btrfs_submit_bio+0x37/0x80
  read_extent_buffer_pages+0x3df/0x6c0
  btrfs_read_extent_buffer+0x13e/0x5f0
  read_tree_block+0x81/0xe0
  read_block_for_search+0x4bd/0x7a0
  ? __pfx_read_block_for_search+0x10/0x10
  btrfs_search_slot+0x78d/0x2720
  ? __pfx_btrfs_search_slot+0x10/0x10
  ? lock_is_held_type+0x8f/0x100
  ? kasan_save_track+0x14/0x30
  ? __kasan_slab_alloc+0x6e/0x70
  ? kmem_cache_alloc_noprof+0x1f2/0x300
  btrfs_get_raid_extent_offset+0x181/0x820
  ? __pfx_lock_acquire+0x10/0x10
  ? __pfx_btrfs_get_raid_extent_offset+0x10/0x10
  ? down_read+0x194/0x440
  ? __pfx_down_read+0x10/0x10
  ? do_raw_read_unlock+0x44/0x70
  ? _raw_read_unlock+0x23/0x40
  btrfs_map_block+0x5b5/0x2250
  ? __pfx_btrfs_map_block+0x10/0x10
  scrub_submit_initial_read+0x8fe/0x11b0
  ? __pfx_scrub_submit_initial_read+0x10/0x10
  submit_initial_group_read+0x161/0x3a0
  ? lock_release+0x20e/0x710
  ? __pfx_submit_initial_group_read+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  scrub_simple_mirror.isra.0+0x3eb/0x580
  scrub_stripe+0xe4d/0x1440
  ? lock_release+0x20e/0x710
  ? __pfx_scrub_stripe+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  ? do_raw_read_unlock+0x44/0x70
  ? _raw_read_unlock+0x23/0x40
  scrub_chunk+0x257/0x4a0
  scrub_enumerate_chunks+0x64c/0xf70
  ? __mutex_unlock_slowpath+0x147/0x5f0
  ? __pfx_scrub_enumerate_chunks+0x10/0x10
  ? bit_wait_timeout+0xb0/0x170
  ? __up_read+0x189/0x700
  ? scrub_workers_get+0x231/0x300
  ? up_write+0x490/0x4f0
  btrfs_scrub_dev+0x52e/0xcd0
  ? create_pending_snapshots+0x230/0x250
  ? __pfx_btrfs_scrub_dev+0x10/0x10
  btrfs_dev_replace_by_ioctl+0xd69/0x1d00
  ? lock_acquire+0x19d/0x4a0
  ? __pfx_btrfs_dev_replace_by_ioctl+0x10/0x10
  ? lock_release+0x20e/0x710
  ? btrfs_ioctl+0xa09/0x74f0
  ? __pfx_lock_release+0x10/0x10
  ? do_raw_spin_lock+0x11e/0x240
  ? __pfx_do_raw_spin_lock+0x10/0x10
  btrfs_ioctl+0xa14/0x74f0
  ? lock_acquire+0x19d/0x4a0
  ? find_held_lock+0x2d/0x110
  ? __pfx_btrfs_ioctl+0x10/0x10
  ? lock_release+0x20e/0x710
  ? do_sigaction+0x3f0/0x860
  ? __pfx_do_vfs_ioctl+0x10/0x10
  ? do_raw_spin_lock+0x11e/0x240
  ? lockdep_hardirqs_on_prepare+0x270/0x3e0
  ? _raw_spin_unlock_irq+0x28/0x50
  ? do_sigaction+0x3f0/0x860
  ? __pfx_do_sigaction+0x10/0x10
  ? __x64_sys_rt_sigaction+0x18e/0x1e0
  ? __pfx___x64_sys_rt_sigaction+0x10/0x10
  ? __x64_sys_close+0x7c/0xd0
  __x64_sys_ioctl+0x137/0x190
  do_syscall_64+0x71/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f0bd1114f9b
 Code: Unable to access opcode bytes at 0x7f0bd1114f71.
 RSP: 002b:00007ffc8a8c3130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0bd1114f9b
 RDX: 00007ffc8a8c35e0 RSI: 00000000ca289435 RDI: 0000000000000003
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
 R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc8a8c6c85
 R13: 00000000398e72a0 R14: 0000000000004361 R15: 0000000000000004
  </TASK>

This happens because on RAID stripe-tree filesystems we recurse back into
btrfs_map_block() on scrub to perform the logical to device physical
mapping.

But as the device replace task is already holding the dev_replace::rwsem
we deadlock.

So don't take the dev_replace::rwsem in case our task is the task performing
the device replace.

Suggested-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/dev-replace.c | 2 ++
 fs/btrfs/fs.h          | 2 ++
 fs/btrfs/volumes.c     | 8 +++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f638c458d2853..ac83f823bf4b9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -641,6 +641,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	down_write(&dev_replace->rwsem);
+	dev_replace->replace_task = current;
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
@@ -971,6 +972,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
 	fs_devices->rw_devices++;
 
+	dev_replace->replace_task = NULL;
 	up_write(&dev_replace->rwsem);
 	btrfs_rm_dev_replace_blocked(fs_info);
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3d6d4b5032208..53824da92cc34 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -317,6 +317,8 @@ struct btrfs_dev_replace {
 
 	struct percpu_counter bio_counter;
 	wait_queue_head_t replace_wait;
+
+	struct task_struct *replace_task;
 };
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0485143cd75e0..fe7cac62f80ca 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6651,13 +6651,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
-	down_read(&dev_replace->rwsem);
+	if (dev_replace->replace_task != current)
+		down_read(&dev_replace->rwsem);
+
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 	/*
 	 * Hold the semaphore for read during the whole operation, write is
 	 * requested at commit time but must wait.
 	 */
-	if (!dev_replace_is_ongoing)
+	if (!dev_replace_is_ongoing && dev_replace->replace_task != current)
 		up_read(&dev_replace->rwsem);
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -6797,7 +6799,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
+	if (dev_replace_is_ongoing && dev_replace->replace_task != current) {
 		lockdep_assert_held(&dev_replace->rwsem);
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
-- 
2.43.0


