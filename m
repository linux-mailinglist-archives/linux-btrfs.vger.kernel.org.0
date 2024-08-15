Return-Path: <linux-btrfs+bounces-7213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730F952E99
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8A7B213C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD5019CD1E;
	Thu, 15 Aug 2024 12:57:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435101AC88C;
	Thu, 15 Aug 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726649; cv=none; b=cRvba4+QJxDXTlm1adEZAqlE0/cwICYwLJoxqT7P2cVGAJlLJ5gaYjH8lWCuIclCR6BeQFxjvQWzggbi5t/xLeG5v4A3kZDNja2E14r09SVYu5KilVNfrya8ra2mWqHcRHg9mnu74hW3jWQGuTCydrFXxPlcEeOMQCOVFgz+0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726649; c=relaxed/simple;
	bh=HnbCSjdngrSMJ1V3X3N0XOIYMbaJutttXg2nQyNLWDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1vNiYWHNAqZf7NCvEz9V2lss3lqDM7Mf1nNkmoVd70tzG5CUM1CqUa+VDN6XEJpeNnUWuxdfhHdq0NTNvIaY9Goo6LKdSbHQyNGcV7sz0ra+5KR4m6D7/ec8LCKfHKkJh4m1Kbo2Ryk+2h+UOHVfsf4hmKVrciHtYj7jdfipIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso10428511fa.3;
        Thu, 15 Aug 2024 05:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723726645; x=1724331445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dNRDn55D5Qzv2ymdJzgDjOczfW1oJ38a7MhLZ/yBp0=;
        b=NAz4BUwQ4e0RfKsf14pYXX/1jqRpIEsDFVdXLhxvw9haglOSJ1pAvmby0eKgN8eKah
         IJs22XubIRZpE1yNakxPAJQeeThq4ftWVfP2ngOLlRAtk/4cWlDwT+VeeHu1VSNqsScv
         RA2mVRx01VAfCmN8UsdsYwMqaRG8VDF0a7iYjimxkS+xjEx4VVP+2NrXUvpuSmlSay9v
         fLFa1agFVgifjtHM3xZoIncsg1IjtzHGt2jrdUqZYg8BvDlE6NA/qjV2n5rJQ3rwVTPU
         afsJgmVOR9P95SXjdi4ulDvliVrzhADHQl2TvkIkMzo/AFBj61JzwlcOuH8yTmb5QEZa
         KGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuHLYISztOBbAYLZyZRErNeJvE2lgRQ+Cv7251n+ywMzE3kKksvJ+mSV8jQc6uwjgqPCqjCyx6XoVAnbXTOQhncxGuHBlH7I2ucDSVCPGGX2bD7txPypsZWPE1rIuKu+9ac4AllNjoRzc=
X-Gm-Message-State: AOJu0Yw1Tj5ujDRjSRjguKptt4kEE2K2MqBM1QHD3VYAQuwSZ4GiBD6L
	0cWTikYfF0j/1VOLyK9sRRxZ9PB3/ATZRgfBvtWTmu882y5qyO8e
X-Google-Smtp-Source: AGHT+IHfHo0prY/P2NpBpeJUVGDX/n5cLf1sMsWTs3PRYR3Dl1t0O9+hYx+U0pPQWBfy9icq9Obo1A==
X-Received: by 2002:a2e:884a:0:b0:2ef:2dfd:15e3 with SMTP id 38308e7fff4ca-2f3aa1c957dmr35459031fa.19.1723726644207;
        Thu, 15 Aug 2024 05:57:24 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc08140csm858795a12.83.2024.08.15.05.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:57:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: don't take dev_replace rwsem on task already holding it
Date: Thu, 15 Aug 2024 14:57:05 +0200
Message-ID: <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

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
---
 fs/btrfs/dev-replace.c | 2 ++
 fs/btrfs/fs.h          | 2 ++
 fs/btrfs/volumes.c     | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 83d5cdd77f29..604399e59a3d 100644
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
index 3d6d4b503220..53824da92cc3 100644
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
index 4b9b647a7e29..d2e80a1f258d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6481,7 +6481,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);
-	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
+	if (btrfs_dev_replace_is_ongoing(dev_replace) && dev_replace->replace_task != current)
+		dev_replace_is_ongoing = 1;
+
 	/*
 	 * Hold the semaphore for read during the whole operation, write is
 	 * requested at commit time but must wait.
-- 
2.43.0


