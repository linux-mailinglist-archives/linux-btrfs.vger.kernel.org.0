Return-Path: <linux-btrfs+bounces-22174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGURAOO+pmlDTQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22174-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 11:58:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9F1ED309
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 11:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038703116561
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA33BA22D;
	Tue,  3 Mar 2026 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EgBQPJTy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD13BD654
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535241; cv=none; b=cfRmsciclxtGVk2JHRGUHNBP3fQnsslPlPBIOxNcLNc2VU5vxn25Ml6Syqfcwg7JpqvImvxyIx8NDbY+RifAj90RZQytcC+q8XA+Vc5J2T2BCDnW3IzSTZWXoiWiv2FQ6FXMt9RTUzjU1X/ugHfrQXGdxbOxLQmZO26SXy2vKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535241; c=relaxed/simple;
	bh=bG9ad1j/6k1VECX3lX/ALNfEU4mBHozWnBlDbcd2h2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxLVaygMdmhJypPcUkWoO/rZJlC3VW1em0UeEYrng+lGW8f54NHqJbXxxj2uxcU+bLT+o5shuYbTM+FvatavixJRSh0ZdKArroRtaqyIZahHM6IINa5kCpvWjNKo1EYADfxSyAdivNbsoJAxZVKR1OdJyBhGaJW02XYRsxRlgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EgBQPJTy; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772535236; x=1804071236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bG9ad1j/6k1VECX3lX/ALNfEU4mBHozWnBlDbcd2h2A=;
  b=EgBQPJTyNA4NFc55jPnl5umtOku+t8CY2P2L1BAKgXP5GH5JyPtw0ota
   YPawGwQEl3oQD5W+VgWahwxIIzBF9zmCySFfl1tZu79YNQ9/B0N5hWblg
   xokd9Enx+b9ALRApBq/xKIe7A8zvX4SFgGXdRA3hlCDLtz8vzqFCNDjy9
   I3kdmCgJm/ojHD6HPSyDs/QTB4pOykheSzxSAg08jrRUbwLn4IKCDVjj4
   HVjpXwZw3KUwWZW0hzGHMerKR3tZM2jQGXxwY//589O4LAm+qgOGUPiW7
   0BCfjV8gA7C1Hpe2uS4UBVC9RoKs2pn2JdsCEkQ706Vg+qwDTYL0qtIZE
   Q==;
X-CSE-ConnectionGUID: UJtSEdviRhuIDXVkinmFeg==
X-CSE-MsgGUID: 0dCzI2KkQcuSLMvbToNBCA==
X-IronPort-AV: E=Sophos;i="6.21,321,1763395200"; 
   d="scan'208";a="142927456"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2026 18:53:50 +0800
IronPort-SDR: 69a6bdbf_GQh7GzW6tQnqfErwTmjIG4I73jTcW1rmpd918pGsKvp1g2R
 dUXDC8IqvS2lZvDDcnK8vkfp8G0gKGRB+QsQbPQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 02:53:52 -0800
WDCIronportException: Internal
Received: from wdap-k4qsz3lzlo.ad.shared (HELO neo.fritz.box) ([10.224.26.17])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2026 02:53:49 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: don't take device_list_mutext when quering zone info
Date: Tue,  3 Mar 2026 11:53:46 +0100
Message-ID: <20260303105346.215439-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DF9F1ED309
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22174-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wdc.com:dkim,wdc.com:email,wdc.com:mid]
X-Rspamd-Action: no action

Shin'ichiro reported sporadic hangs when running generic/013 in our CI
system. When enabling lockdep, there is a lockdep splat when calling
btrfs_get_dev_zone_info_all_devices() in the mount path that can be
triggered by i.e. generic/013:

 ======================================================
 WARNING: possible circular locking dependency detected
 7.0.0-rc1+ #355 Not tainted
 ------------------------------------------------------
 mount/1043 is trying to acquire lock:
 ffff8881020b5470 (&vblk->vdev_mutex){+.+.}-{4:4}, at: virtblk_report_zones+0xda/0x430

 but task is already holding lock:
 ffff888102a738e0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: btrfs_get_dev_zone_info_all_devices+0x45/0x90

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #4 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
        __mutex_lock+0xa3/0x1360
        btrfs_create_pending_block_groups+0x1f4/0x9d0
        __btrfs_end_transaction+0x3e/0x2e0
        btrfs_zoned_reserve_data_reloc_bg+0x2f8/0x390
        open_ctree+0x1934/0x23db
        btrfs_get_tree.cold+0x105/0x26c
        vfs_get_tree+0x28/0xb0
        __do_sys_fsconfig+0x324/0x680
        do_syscall_64+0x92/0x4f0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #3 (btrfs_trans_num_extwriters){++++}-{0:0}:
        join_transaction+0xc2/0x5c0
        start_transaction+0x17c/0xbc0
        btrfs_zoned_reserve_data_reloc_bg+0x2b4/0x390
        open_ctree+0x1934/0x23db
        btrfs_get_tree.cold+0x105/0x26c
        vfs_get_tree+0x28/0xb0
        __do_sys_fsconfig+0x324/0x680
        do_syscall_64+0x92/0x4f0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #2 (btrfs_trans_num_writers){++++}-{0:0}:
        lock_release+0x163/0x4b0
        __btrfs_end_transaction+0x1c7/0x2e0
        btrfs_dirty_inode+0x6f/0xd0
        touch_atime+0xe5/0x2c0
        btrfs_file_mmap_prepare+0x65/0x90
        __mmap_region+0x4b9/0xf00
        mmap_region+0xf7/0x120
        do_mmap+0x43d/0x610
        vm_mmap_pgoff+0xd6/0x190
        ksys_mmap_pgoff+0x7e/0xc0
        do_syscall_64+0x92/0x4f0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #1 (&mm->mmap_lock){++++}-{4:4}:
        __might_fault+0x68/0xa0
        _copy_to_user+0x22/0x70
        blkdev_copy_zone_to_user+0x22/0x40
        virtblk_report_zones+0x282/0x430
        blkdev_report_zones_ioctl+0xfd/0x130
        blkdev_ioctl+0x20f/0x2c0
        __x64_sys_ioctl+0x86/0xd0
        do_syscall_64+0x92/0x4f0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (&vblk->vdev_mutex){+.+.}-{4:4}:
        __lock_acquire+0x1522/0x2680
        lock_acquire+0xd5/0x2f0
        __mutex_lock+0xa3/0x1360
        virtblk_report_zones+0xda/0x430
        blkdev_report_zones_cached+0x162/0x190
        btrfs_get_dev_zones+0xdc/0x2e0
        btrfs_get_dev_zone_info+0x219/0xe80
        btrfs_get_dev_zone_info_all_devices+0x62/0x90
        open_ctree+0x1200/0x23db
        btrfs_get_tree.cold+0x105/0x26c
        vfs_get_tree+0x28/0xb0
        __do_sys_fsconfig+0x324/0x680
        do_syscall_64+0x92/0x4f0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 other info that might help us debug this:

 Chain exists of:
   &vblk->vdev_mutex --> btrfs_trans_num_extwriters --> &fs_devs->device_list_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&fs_devs->device_list_mutex);
                                lock(btrfs_trans_num_extwriters);
                                lock(&fs_devs->device_list_mutex);
   lock(&vblk->vdev_mutex);

  *** DEADLOCK ***

 3 locks held by mount/1043:
  #0: ffff88811063e878 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig+0x2ae/0x680
  #1: ffff88810cb9f0e8 (&type->s_umount_key#31/1){+.+.}-{4:4}, at: alloc_super+0xc0/0x3e0
  #2: ffff888102a738e0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: btrfs_get_dev_zone_info_all_devices+0x45/0x90

 stack backtrace:
 CPU: 2 UID: 0 PID: 1043 Comm: mount Not tainted 7.0.0-rc1+ #355 PREEMPT(full)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x80
  print_circular_bug.cold+0x18d/0x1d8
  check_noncircular+0x10d/0x130
  __lock_acquire+0x1522/0x2680
  ? vmap_small_pages_range_noflush+0x3ef/0x820
  lock_acquire+0xd5/0x2f0
  ? virtblk_report_zones+0xda/0x430
  ? lock_is_held_type+0xcd/0x130
  __mutex_lock+0xa3/0x1360
  ? virtblk_report_zones+0xda/0x430
  ? virtblk_report_zones+0xda/0x430
  ? __pfx_copy_zone_info_cb+0x10/0x10
  ? virtblk_report_zones+0xda/0x430
  virtblk_report_zones+0xda/0x430
  ? __pfx_copy_zone_info_cb+0x10/0x10
  blkdev_report_zones_cached+0x162/0x190
  ? __pfx_copy_zone_info_cb+0x10/0x10
  btrfs_get_dev_zones+0xdc/0x2e0
  btrfs_get_dev_zone_info+0x219/0xe80
  btrfs_get_dev_zone_info_all_devices+0x62/0x90
  open_ctree+0x1200/0x23db
  btrfs_get_tree.cold+0x105/0x26c
  ? rcu_is_watching+0x18/0x50
  vfs_get_tree+0x28/0xb0
  __do_sys_fsconfig+0x324/0x680
  do_syscall_64+0x92/0x4f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f615e27a40e
 Code: 73 01 c3 48 8b 0d f2 29 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c2 29 0f 00 f7 d8 64 89 01 48
 RSP: 002b:00007fff11b18fb8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
 RAX: ffffffffffffffda RBX: 000055572e92ab10 RCX: 00007f615e27a40e
 RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
 RBP: 00007fff11b19100 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 000055572e92bc40 R14: 00007f615e3faa60 R15: 000055572e92bd08
  </TASK>

Don't hold the device_list_mutex while calling into
btrfs_get_dev_zone_info() in btrfs_get_dev_zone_info_all_devices() to
mitigate the issue. This is safe, as no other thread can touch the device
list at the moment of execution.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 851b0de7bed7..df44586af57f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -337,7 +337,10 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 	if (!btrfs_fs_incompat(fs_info, ZONED))
 		return 0;
 
-	mutex_lock(&fs_devices->device_list_mutex);
+	/*
+	 * No need to take the device_list mutex here, we're still in the mount
+	 * path and devices cannot be added to removed from the list yet.
+	 */
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		/* We can skip reading of zone info for missing devices */
 		if (!device->bdev)
@@ -347,7 +350,6 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 		if (ret)
 			break;
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	return ret;
 }
-- 
2.53.0


