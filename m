Return-Path: <linux-btrfs+bounces-12396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94FAA682EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 02:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E751719C2C1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 01:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98B24E4DB;
	Wed, 19 Mar 2025 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p1vk0fuK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF825760;
	Wed, 19 Mar 2025 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349127; cv=none; b=k5mhx7hFw9ermDJ3CL5OFi8Q4gReCpxEnSXzYNLQ01r0M/TL7PHWnM/TxxtR9lMv1bhmFeO+qzNRyxqPtRqvj9YOeRKN5w16SyY1ghtL1qCiqQ2XZ1Icph988YEYe5ekT3RMYTPY3L/2pmNn421yqjBXX2sKVqJHfvHeBHh1XFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349127; c=relaxed/simple;
	bh=YRT1wKDwMQ76TybzCyCVizTRY3HLpxNGECq3mvWnhPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbwowxFLsowJgi9rySlLUDmq+MinF3mcvigmG1NgS7nBrWO3byaClOt6R+Ppc66gUEavJGmZFhUTYtVLtiWDNbEWjbCjXFYfuSE0YaE08S8pQ1p8xE7ila5H9iiBsO6LZs5HFmWR3XJb7mtPQfBPV/tqA3ue4x5CLPZFJWJ1GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p1vk0fuK; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742349126; x=1773885126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRT1wKDwMQ76TybzCyCVizTRY3HLpxNGECq3mvWnhPs=;
  b=p1vk0fuK+4hYYAu4VdzbbIRTzehsMOfFZcEz4Rh313YPa9IVehR/11sS
   k+Fy5GvmkXwtUu76c+MD0XVGMgzb00aIvkyGYXJtUhtMPvV2DuLO3M7J+
   8fULkIfcV+wpNCRoxOVRUgA0Wr8oj1xmuFfIUGxr71An2brBy9LFdrY7i
   CYL60EvHe+xKPOVenKehGjaoXlObbUHdYjctjKVARWC9fTZXY9vgetdF9
   Jy7NYcn+rSKUkGBFzAM11uk2+G3wUwjeyZ8f/uE6PDFYx9gdnEo1USOgW
   fpRVSAI+evREncJupm688nXJQ1CEGQQhgo62iC9lsY4zyfkuUxpccP6ye
   g==;
X-CSE-ConnectionGUID: tlpXD+uMTzO4iXs9Yf9iKg==
X-CSE-MsgGUID: kQYu5dzYQEOFJhx3nE1V6Q==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55009600"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 09:52:05 +0800
IronPort-SDR: 67da1566_MqsqEwFU3mIV0+G0v0/bI4jj64hl8bGImNosY91vIPWQ+oR
 SExNxo9x9WEs6vD4P0b3ySaDa4i44/0Ojmw0NxA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 17:52:54 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 18:52:05 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	hch@infradead.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] btrfs: zoned: skip reporting zone for new block group
Date: Wed, 19 Mar 2025 10:49:17 +0900
Message-ID: <b623a238bdd28538d32b13e43856901204dae276.1742348826.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742348826.git.naohiro.aota@wdc.com>
References: <cover.1742348826.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential deadlock if we do report zones in an IO context, detailed
in below lockdep report. When one process do a report zones and another process
freezes the block device, the report zones side cannot allocate a tag because
the freeze is already started. This can thus result in new block group creation
to hang forever, blocking the write path.

Thankfully, a new block group should be created on empty zones. So, reporting
the zones is not necessary and we can set the write pointer = 0 and load the
zone capacity from the block layer using bdev_zone_capacity() helper.

 ======================================================
 WARNING: possible circular locking dependency detected
 6.14.0-rc1 #252 Not tainted
 ------------------------------------------------------
 modprobe/1110 is trying to acquire lock:
 ffff888100ac83e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0x38f/0xb60

 but task is already holding lock:
 ffff8881205b6f20 (&q->q_usage_counter(queue)#16){++++}-{0:0}, at: sd_remove+0x85/0x130

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #3 (&q->q_usage_counter(queue)#16){++++}-{0:0}:
        blk_queue_enter+0x3d9/0x500
        blk_mq_alloc_request+0x47d/0x8e0
        scsi_execute_cmd+0x14f/0xb80
        sd_zbc_do_report_zones+0x1c1/0x470
        sd_zbc_report_zones+0x362/0xd60
        blkdev_report_zones+0x1b1/0x2e0
        btrfs_get_dev_zones+0x215/0x7e0 [btrfs]
        btrfs_load_block_group_zone_info+0x6d2/0x2c10 [btrfs]
        btrfs_make_block_group+0x36b/0x870 [btrfs]
        btrfs_create_chunk+0x147d/0x2320 [btrfs]
        btrfs_chunk_alloc+0x2ce/0xcf0 [btrfs]
        start_transaction+0xce6/0x1620 [btrfs]
        btrfs_uuid_scan_kthread+0x4ee/0x5b0 [btrfs]
        kthread+0x39d/0x750
        ret_from_fork+0x30/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #2 (&fs_info->dev_replace.rwsem){++++}-{4:4}:
        down_read+0x9b/0x470
        btrfs_map_block+0x2ce/0x2ce0 [btrfs]
        btrfs_submit_chunk+0x2d4/0x16c0 [btrfs]
        btrfs_submit_bbio+0x16/0x30 [btrfs]
        btree_write_cache_pages+0xb5a/0xf90 [btrfs]
        do_writepages+0x17f/0x7b0
        __writeback_single_inode+0x114/0xb00
        writeback_sb_inodes+0x52b/0xe00
        wb_writeback+0x1a7/0x800
        wb_workfn+0x12a/0xbd0
        process_one_work+0x85a/0x1460
        worker_thread+0x5e2/0xfc0
        kthread+0x39d/0x750
        ret_from_fork+0x30/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #1 (&fs_info->zoned_meta_io_lock){+.+.}-{4:4}:
        __mutex_lock+0x1aa/0x1360
        btree_write_cache_pages+0x252/0xf90 [btrfs]
        do_writepages+0x17f/0x7b0
        __writeback_single_inode+0x114/0xb00
        writeback_sb_inodes+0x52b/0xe00
        wb_writeback+0x1a7/0x800
        wb_workfn+0x12a/0xbd0
        process_one_work+0x85a/0x1460
        worker_thread+0x5e2/0xfc0
        kthread+0x39d/0x750
        ret_from_fork+0x30/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
        __lock_acquire+0x2f52/0x5ea0
        lock_acquire+0x1b1/0x540
        __flush_work+0x3ac/0xb60
        wb_shutdown+0x15b/0x1f0
        bdi_unregister+0x172/0x5b0
        del_gendisk+0x841/0xa20
        sd_remove+0x85/0x130
        device_release_driver_internal+0x368/0x520
        bus_remove_device+0x1f1/0x3f0
        device_del+0x3bd/0x9c0
        __scsi_remove_device+0x272/0x340
        scsi_forget_host+0xf7/0x170
        scsi_remove_host+0xd2/0x2a0
        sdebug_driver_remove+0x52/0x2f0 [scsi_debug]
        device_release_driver_internal+0x368/0x520
        bus_remove_device+0x1f1/0x3f0
        device_del+0x3bd/0x9c0
        device_unregister+0x13/0xa0
        sdebug_do_remove_host+0x1fb/0x290 [scsi_debug]
        scsi_debug_exit+0x17/0x70 [scsi_debug]
        __do_sys_delete_module.isra.0+0x321/0x520
        do_syscall_64+0x93/0x180
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 other info that might help us debug this:

 Chain exists of:
   (work_completion)(&(&wb->dwork)->work) --> &fs_info->dev_replace.rwsem --> &q->q_usage_counter(queue)#16

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&q->q_usage_counter(queue)#16);
                                lock(&fs_info->dev_replace.rwsem);
                                lock(&q->q_usage_counter(queue)#16);
   lock((work_completion)(&(&wb->dwork)->work));

  *** DEADLOCK ***

 5 locks held by modprobe/1110:
  #0: ffff88811f7bc108 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0x8f/0x520
  #1: ffff8881022ee0e0 (&shost->scan_mutex){+.+.}-{4:4}, at: scsi_remove_host+0x20/0x2a0
  #2: ffff88811b4c4378 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0x8f/0x520
  #3: ffff8881205b6f20 (&q->q_usage_counter(queue)#16){++++}-{0:0}, at: sd_remove+0x85/0x130
  #4: ffffffffa3284360 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xda/0xb60

 stack backtrace:
 CPU: 0 UID: 0 PID: 1110 Comm: modprobe Not tainted 6.14.0-rc1 #252
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6a/0x90
  print_circular_bug.cold+0x1e0/0x274
  check_noncircular+0x306/0x3f0
  ? __pfx_check_noncircular+0x10/0x10
  ? mark_lock+0xf5/0x1650
  ? __pfx_check_irq_usage+0x10/0x10
  ? lockdep_lock+0xca/0x1c0
  ? __pfx_lockdep_lock+0x10/0x10
  __lock_acquire+0x2f52/0x5ea0
  ? __pfx___lock_acquire+0x10/0x10
  ? __pfx_mark_lock+0x10/0x10
  lock_acquire+0x1b1/0x540
  ? __flush_work+0x38f/0xb60
  ? __pfx_lock_acquire+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  ? mark_held_locks+0x94/0xe0
  ? __flush_work+0x38f/0xb60
  __flush_work+0x3ac/0xb60
  ? __flush_work+0x38f/0xb60
  ? __pfx_mark_lock+0x10/0x10
  ? __pfx___flush_work+0x10/0x10
  ? __pfx_wq_barrier_func+0x10/0x10
  ? __pfx___might_resched+0x10/0x10
  ? mark_held_locks+0x94/0xe0
  wb_shutdown+0x15b/0x1f0
  bdi_unregister+0x172/0x5b0
  ? __pfx_bdi_unregister+0x10/0x10
  ? up_write+0x1ba/0x510
  del_gendisk+0x841/0xa20
  ? __pfx_del_gendisk+0x10/0x10
  ? _raw_spin_unlock_irqrestore+0x35/0x60
  ? __pm_runtime_resume+0x79/0x110
  sd_remove+0x85/0x130
  device_release_driver_internal+0x368/0x520
  ? kobject_put+0x5d/0x4a0
  bus_remove_device+0x1f1/0x3f0
  device_del+0x3bd/0x9c0
  ? __pfx_device_del+0x10/0x10
  __scsi_remove_device+0x272/0x340
  scsi_forget_host+0xf7/0x170
  scsi_remove_host+0xd2/0x2a0
  sdebug_driver_remove+0x52/0x2f0 [scsi_debug]
  ? kernfs_remove_by_name_ns+0xc0/0xf0
  device_release_driver_internal+0x368/0x520
  ? kobject_put+0x5d/0x4a0
  bus_remove_device+0x1f1/0x3f0
  device_del+0x3bd/0x9c0
  ? __pfx_device_del+0x10/0x10
  ? __pfx___mutex_unlock_slowpath+0x10/0x10
  device_unregister+0x13/0xa0
  sdebug_do_remove_host+0x1fb/0x290 [scsi_debug]
  scsi_debug_exit+0x17/0x70 [scsi_debug]
  __do_sys_delete_module.isra.0+0x321/0x520
  ? __pfx___do_sys_delete_module.isra.0+0x10/0x10
  ? __pfx_slab_free_after_rcu_debug+0x10/0x10
  ? kasan_save_stack+0x2c/0x50
  ? kasan_record_aux_stack+0xa3/0xb0
  ? __call_rcu_common.constprop.0+0xc4/0xfb0
  ? kmem_cache_free+0x3a0/0x590
  ? __x64_sys_close+0x78/0xd0
  do_syscall_64+0x93/0x180
  ? lock_is_held_type+0xd5/0x130
  ? __call_rcu_common.constprop.0+0x3c0/0xfb0
  ? lockdep_hardirqs_on+0x78/0x100
  ? __call_rcu_common.constprop.0+0x3c0/0xfb0
  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
  ? kmem_cache_free+0x3a0/0x590
  ? lockdep_hardirqs_on_prepare+0x16d/0x400
  ? do_syscall_64+0x9f/0x180
  ? lockdep_hardirqs_on+0x78/0x100
  ? do_syscall_64+0x9f/0x180
  ? __pfx___x64_sys_openat+0x10/0x10
  ? lockdep_hardirqs_on_prepare+0x16d/0x400
  ? do_syscall_64+0x9f/0x180
  ? lockdep_hardirqs_on+0x78/0x100
  ? do_syscall_64+0x9f/0x180
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f436712b68b
 RSP: 002b:00007ffe9f1a8658 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 00005559b367fd80 RCX: 00007f436712b68b
 RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005559b367fde8
 RBP: 00007ffe9f1a8680 R08: 1999999999999999 R09: 0000000000000000
 R10: 00007f43671a5fe0 R11: 0000000000000206 R12: 0000000000000000
 R13: 00007ffe9f1a86b0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC: stable@vger.kernel.org # 6.13+
---
 fs/btrfs/zoned.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4956baf8220a..6c730f6bce10 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1277,7 +1277,7 @@ struct zone_info {
 
 static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 				struct zone_info *info, unsigned long *active,
-				struct btrfs_chunk_map *map)
+				struct btrfs_chunk_map *map, bool new)
 {
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	struct btrfs_device *device;
@@ -1307,6 +1307,8 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		return 0;
 	}
 
+	ASSERT(!new || btrfs_dev_is_empty_zone(device, info->physical));
+
 	/* This zone will be used for allocation, so mark this zone non-empty. */
 	btrfs_dev_clear_zone_empty(device, info->physical);
 
@@ -1319,6 +1321,18 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	 * to determine the allocation offset within the zone.
 	 */
 	WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+
+	if (new) {
+		sector_t capacity;
+
+		capacity = bdev_zone_capacity(device->bdev, info->physical >> SECTOR_SHIFT);
+		up_read(&dev_replace->rwsem);
+		info->alloc_offset = 0;
+		info->capacity = capacity << SECTOR_SHIFT;
+
+		return 0;
+	}
+
 	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_get_dev_zone(device, info->physical, &zone);
 	memalloc_nofs_restore(nofs_flag);
@@ -1588,7 +1602,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map);
+		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map, new);
 		if (ret)
 			goto out;
 
-- 
2.49.0


