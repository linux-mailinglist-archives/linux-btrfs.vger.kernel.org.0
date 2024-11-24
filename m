Return-Path: <linux-btrfs+bounces-9845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394239D6E2C
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744B4B21D8F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2B1922FC;
	Sun, 24 Nov 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj5nWtG1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B01917DE;
	Sun, 24 Nov 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451973; cv=none; b=cRdKKi6pQRb2AzQWqo0Y87a62FlZk5w96DFlUyEMX9wE69DTqUs5JuT6EHk7VQZ4k3jojAJ4QHC0D63ztycSZer+tYWtbAedrfpKmTDicrAtWm0XAoQvuvZd0w4UVmgLhng40IUq7rrl36wa/yO5iIqrWl2Fhxtwe/GBrWJeibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451973; c=relaxed/simple;
	bh=Wai5QgjNn6fP2jjYouXyrNsDJerhSLIVUPEOBCvjao8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGIJC9z1+ket/p2tmOsOsOhOhYM77XkenMARGTDS1DMepdfCrPCwbgSjM1ZJq0VuGHlqKreSwzIDyA7N+6pME0HISUabW81NypVfWCf+8Nw8keMIxMBhnxR83cEGP+UE3CVlxiaamgBcvSXrdkvH1/xVeqVO0Cuma34x4ALBJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj5nWtG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DEAC4CED6;
	Sun, 24 Nov 2024 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451973;
	bh=Wai5QgjNn6fP2jjYouXyrNsDJerhSLIVUPEOBCvjao8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dj5nWtG1CYDckKsKfyMzJuQTSUvwF3I5vaolXohsrshltX5frmFyUYYzhaIvIIz6b
	 ZTIAGB8su0dyPfjy3K85/l719wdHhxewDsf3gpWIBiCEE5NAQW9dCJWO3zK+L0CYHN
	 st+ewLirTC/m9h2SwMcuBgTI8nH3nXFsx1kxsaZZo72J2WiaFzRTCO6XC4+42AwwlU
	 eCwQ1HeSk1M+4keCmJkbaKodY0LS201obvyd6VyoqOSbYZHSpZnHhWDzRz3zqIbtXf
	 YZTLoIE+I1OzuE7IBpoOn8Qis0LuyxMyRAwcs/fi+dVrjPnlwoVadtSf6woEf23y6k
	 sIVkGjn62uJ3Q==
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
Subject: [PATCH AUTOSEL 6.12 08/19] btrfs: don't take dev_replace rwsem on task already holding it
Date: Sun, 24 Nov 2024 07:38:43 -0500
Message-ID: <20241124123912.3335344-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 83d5cdd77f293..604399e59a3d1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -641,6 +641,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	down_write(&dev_replace->rwsem);
+	dev_replace->replace_task = current;
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
@@ -994,6 +995,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
 	fs_devices->rw_devices++;
 
+	dev_replace->replace_task = NULL;
 	up_write(&dev_replace->rwsem);
 	btrfs_rm_dev_replace_blocked(fs_info);
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79f64e383eddf..cbfb225858a59 100644
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
index eb51b609190fb..920df7585b0d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6481,13 +6481,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6627,7 +6629,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
+	if (dev_replace_is_ongoing && dev_replace->replace_task != current) {
 		lockdep_assert_held(&dev_replace->rwsem);
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
-- 
2.43.0


