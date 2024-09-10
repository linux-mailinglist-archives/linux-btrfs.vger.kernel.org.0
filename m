Return-Path: <linux-btrfs+bounces-7903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF9A972B43
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968B22836D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907D18306C;
	Tue, 10 Sep 2024 07:55:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C2142911;
	Tue, 10 Sep 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954927; cv=none; b=bu3meV597d+aGIJUKLxH1PfuEL4InYWEscUzfYlH6jR8BYRiGngeAbTY3BFowF/jzRu+3xSKPOZvW3gdIvPgNih+kKFlrBZnSsq07CGhgKHN+WjhC6dy8rD79rlMr4GQayNsFYO08n5hUH16eWq/Bxfn+4NDdpiRfcRS5f4KeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954927; c=relaxed/simple;
	bh=9dKCnQdmpkg1+bMGKVHJz3KSnyhwm4eLYYnAqhC8qLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7Qc2pGEfNDGDduJ2NwBuUBooPTkNPaKRJfQtQf67n2ox/5LfwBOr0HBlcamKkOyeYq3n3lQb2CtCDp+6CqRBBwSQj6H/ew2SLuorlFPe+DSu/a5CXY0UH09sBZTNSDnfyLnKB1OO54PLDhGUbeAka227Qi2y95+jz0psJ/BtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c5bab490so3860043f8f.1;
        Tue, 10 Sep 2024 00:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954924; x=1726559724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06LBkJunZ51Um4z9Suw1YIHCDpFgSXumyXFumhwjiNk=;
        b=OURtf6TA/weKW5GzddkjgdlV5Xd20vnL/A896INlxrz+ASBQl7+2EwnaNx91/cbzLb
         5w3/rmYtI1AYu1oSyVCJNM7YSWrrh5l/C3wv0WfXsl6I/HRh3kBiFOmz3G7QeOoZZ3+g
         SJwtReOdZH4sDDCVvYt93nZ2I8mFNxtYn1knop9VdBMvN6qgQFHUdbjJLgK7dRhrXdjM
         n+4+mZI28godyZi/Alut4OrBdUHHBg2XK0GG0lqk1BSBuv9BFeWthb3YIjRDJQY/jton
         HPpqfqOOOaiGN9c/kgnS9j/Aa7OKISEcxE4/lzI7QFj1w2E+LqLTQIHEfC1qukjvM/Y8
         lnjw==
X-Forwarded-Encrypted: i=1; AJvYcCUGyY81sgo67pAOjPeFvHk1DQVcYrNzOOjrnxPWv0Lpm0mTsNXdseV9YMkKuvKMqvi6dAcoKcmNz9G1Dg==@vger.kernel.org, AJvYcCURV4cJ7Qa+MDSR8+Wn3Wpedk9e2FBT4ZcD/AVROJ4rMLhKoKY/Jg/+r+ZCPyrP/nT2uOgLSWDnvwXOyjWG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3eRxilYRwJ8gk+Yp9Ms0zHnDHvPRVGbHSc58LKJg2KkTCcA9
	2y0D2d9338VyghLhLxh6+3lHJKMgiHSq94gXw88UYWx0vcUQw76R
X-Google-Smtp-Source: AGHT+IECVs6MIR3gzdDuZnMb0CjC/+6vctajy0BvhH0gXHTTHnjOCvVQWxKoHBOwlhXaPBZZqMmukw==
X-Received: by 2002:adf:e68f:0:b0:374:c64e:3ff1 with SMTP id ffacd0b85a97d-378a8a273c5mr1105676f8f.17.1725954923294;
        Tue, 10 Sep 2024 00:55:23 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7178100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f717:8100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b2f4sm102718025e9.45.2024.09.10.00.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:55:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: don't take dev_replace rwsem on task already holding it
Date: Tue, 10 Sep 2024 09:55:01 +0200
Message-ID: <dd0cb649510537a495bc64d91e09da5a8119d2e3.1725950283.git.jth@kernel.org>
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
 fs/btrfs/volumes.c     | 8 +++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

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
index 79f64e383edd..cbfb225858a5 100644
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
index 8f340ad1d938..995b0647f538 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6480,13 +6480,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6626,7 +6628,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
+	if (dev_replace_is_ongoing && dev_replace->replace_task != current) {
 		lockdep_assert_held(&dev_replace->rwsem);
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
-- 
2.43.0


