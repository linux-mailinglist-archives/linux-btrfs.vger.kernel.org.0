Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E227372744
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEDIca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 04:32:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37723 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhEDIca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 04:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620117097; x=1651653097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jp0npQ34qz4OJYlnvwH8IAPvOIhPBWzmNV01m49xgis=;
  b=K2GDHtjJwWbJgIZfob4Cf1Rz4bvsmGukN8oASTC7nnjE3Dh+AluOoGL0
   4OINP9H9OKxWBdHWFrhXFD6uDcPrE0udJNV/xEt0Imx1uIBUV9ohdxbXF
   mD7VhP6KFTml3m0SvMRaEfPuCyuaArOCLzGRVA74/asy9aIvAIRDkE1Gx
   nWhsG2ra8ARon90gcVFfu7UT/+93VLtRapRpKD96tJEV4QyKgO85x0l+L
   b02RK8vEOwsbD8/i9pOmpbylv3Sb9xpuADjswpnzLjWSJb6eCZnbgedgp
   iP51ZF7HJ5Og7CCqLFYFETrxT+YS+XHOXxj6m6mgu0XJQaj3BBDxo7EMY
   A==;
IronPort-SDR: PSuS4dxglpVf8rBVafSoVwvYFHno8jA9xMkhqg94u/2DGvdAm/XGioYYPYirA8ewDwKYFawgRx
 wd7uzWspb5boQOuNHSQKXy+K08sH1fedmaa8Ntli/mahdfqQABUbb0IH+ZiB7jV3TQQGkOjzQ8
 YRwtj+aiKtpnDvOhF6jClc8JAiI450ousOf5hd3PBKwCr+SC2M3/TSE5UcWMhLmto0plxfseHq
 zZuA7Ab0ro+f0VjQCncP7HbYR7YnneA5J9nHvoiC8cLAyATfMo936q3/nJkY3HERer6fOHXkUk
 JbM=
X-IronPort-AV: E=Sophos;i="5.82,271,1613404800"; 
   d="scan'208";a="167613992"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2021 16:31:36 +0800
IronPort-SDR: 7+DMor5nhakfK7npmkPX46xBdJTC6QeqaUScmC1/FR1RS93GUt7PXGL9/dpad5vbDoWwjZHABV
 VL4lYEiwaeEZ/s4a8hUUmqqSb/vYRvGNTaIWKHL2shtgAyJLy6ImCuUfrPH9c606S7SsImWWaO
 Wf9w8wEkJ6LI40EtqwskDE3j25L1hBzfWF6z2032FoJcdHiD5MzL+wCnROT6AkjmEPZFr9s+6R
 vtF8HJLeqvnjkT6ompEOgV/v3oAnTw+z8oLkG3FmhyS1x7CfcWO9GamyMXMGx/ouQNbTNm0EkS
 +gKhYDPbdxSp3leS+1Oi0yP7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 01:10:19 -0700
IronPort-SDR: RTbAt//WxxdEWSkXyFmv3bXvnH8+W14NUtQnh75irtIhIDua7fpMv2fY/Driu1vTXvCahgLkna
 VJDG4Vh5uSNi8FKeEYlBHiuHWf/FEyIBfwP02kLVxJ+lxV8DujYrpLX+wVeODaKedTeqCNJ5Si
 1w96101Dc+YFkQsQXjgsg06QgJ6rhbwxqZ8vl53Fn4F72qOt32cK/1sbLKfT4FrP02bDjpVgGh
 4O0tin0DbQ7HH5DyYNifrcK7px7UERYUXozvcD7LnUsE9Mi7srBOY8IlEJOMaw3KvCqh26bETM
 fu8=
WDCIronportException: Internal
Received: from 3x7y6s2.ad.shared (HELO localhost.localdomain) ([10.225.32.59])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 May 2021 01:31:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] btrfs: zoned: sanity check zone type
Date:   Tue,  4 May 2021 10:30:23 +0200
Message-Id: <20210504083024.28072-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
References: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

The xfstests test case generic/475 creates a dm-linear device that gets
changed to a dm-error device. This leads to errors in loading the block
group's zone information when running on a zoned file system, ultimately
resulting in a list corruption. When running on a kernel with list
debugging enabled this leads to the following crash.

 BTRFS: error (device dm-2) in cleanup_transaction:1953: errno=-5 IO failure
 kernel BUG at lib/list_debug.c:54!
 invalid opcode: 0000 [#1] SMP PTI
 CPU: 1 PID: 2433 Comm: umount Tainted: G        W         5.12.0+ #1018
 RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
 RSP: 0018:ffffc90001473df0 EFLAGS: 00010296
 RAX: 0000000000000054 RBX: ffff8881038fd000 RCX: ffffc90001473c90
 RDX: 0000000100001a31 RSI: 0000000000000003 RDI: 0000000000000003
 RBP: ffff888308871108 R08: 0000000000000003 R09: 0000000000000001
 R10: 3961373532383838 R11: 6666666620736177 R12: ffff888308871000
 R13: ffff8881038fd088 R14: ffff8881038fdc78 R15: dead000000000100
 FS:  00007f353c9b1540(0000) GS:ffff888627d00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f353cc2c710 CR3: 000000018e13c000 CR4: 00000000000006a0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  btrfs_free_block_groups+0xc9/0x310 [btrfs]
  close_ctree+0x2ee/0x31a [btrfs]
  ? call_rcu+0x8f/0x270
  ? mutex_lock+0x1c/0x40
  generic_shutdown_super+0x67/0x100
  kill_anon_super+0x14/0x30
  btrfs_kill_super+0x12/0x20 [btrfs]
  deactivate_locked_super+0x31/0x90
  cleanup_mnt+0x13e/0x1b0
  task_work_run+0x63/0xb0
  exit_to_user_mode_loop+0xd9/0xe0
  exit_to_user_mode_prepare+0x3e/0x60
  syscall_exit_to_user_mode+0x1d/0x50
  entry_SYSCALL_64_after_hwframe+0x44/0xae

As dm-error has no support for zones, btrfs will run it's zone emulation
mode on this device. The zone emulation mode emulates conventional zones,
so bail out if the zone bitmap that gets populated on mount sees the zone
as sequential while we're thinking it's a conventional zone when creating
a block group.

Note: this scenario is unlikely in a real wold application and can only
happen by this (ab)use of device-mapper targets.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
[ jth: commit message and error messages ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 70b23a0d03b1..6edf88580f47 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1126,6 +1126,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 
+		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			btrfs_err(fs_info,
+				  "zoned: unexpected conventional zone: %llu on device %s (devid %llu)",
+				  zone.start << SECTOR_SHIFT,
+				  rcu_str_deref(device->name), device->devid);
+			ret = -EIO;
+			goto out;
+		}
+
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
-- 
2.31.1

