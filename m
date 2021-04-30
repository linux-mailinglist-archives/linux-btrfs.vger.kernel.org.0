Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415436FB96
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhD3NgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 09:36:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28821 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhD3NgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619789730; x=1651325730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QlwXtn33G78E3i5eF4kfh2ytcSnkw5Nj+WY1evc2P5c=;
  b=nD30EE5/BCvynuZli8Qs18dhCNQJFroSJvf7A3jzJ0V+FHcgXaQ2gymy
   AWSJmvR8aywSfpI+viuNZHFI4Laakinc2O2WsMQ6UqLI9aOP6+gRwDyf8
   gmxtTz3zsFuYQY9yAC3Ai4lgwIaetKSh0/FBXUXqA8TQ/mbz2jNAWq4ac
   sCaWeLDM/wNHP7Vcn3zuZQev+Z3R8ncixahqmjwhILqddTP9N4S1kvWRD
   Cj7C0s1MDJ+FCQC/qwhri8mdkxbLjO6MbrcrVxxgQGK2f12e/1GMAem9D
   jdDOlbZBPQZ2Sw230DRuvj0zTV4G/qQfGAa+cmon6/cZQ7gdz+oA+dsKU
   g==;
IronPort-SDR: 5oLAoQEMQVnBJ4nZBkamLZl7EY9V4hdFt1109Wije5oTdbLuZgNpmpH/7MpuuIprL1zQk5raAb
 Jy7RvwzcJ2GEUt8iel4D75tkFwoMmfhfjURPda3xcT1DSB37vrUR0cZXRgz14bkt+dBHC/e7UH
 zfsnYKT3wMDzlNjXqzbS8RxdkGI2NHBPN2YRFgIZuKuLGb2l9kfc3W58xaJhP2GIdvCRjrObnN
 sX4ihVJalyDLH5l+5Cf2eF12Uv1+JIjQCgn0b4FvVbZ1YuaBOhD41Aikrb7yA0bfm3iCcGXfjm
 CWE=
X-IronPort-AV: E=Sophos;i="5.82,262,1613404800"; 
   d="scan'208";a="166128996"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 21:35:30 +0800
IronPort-SDR: 40Cf+yO4SkccHZa+T78Aj56OiIaU+jNSLlUPGQQ1aLPgy2wgpEHOlfGFVNYcNLjWbstOQ8afCX
 bC/tPQrhB1SPWlz3PxgO/z3D2QKWscSnXPtDlEuig/PVDVzMk5gJJEHEd9wX9sJsIRTPfliJSt
 flu+FUU8CnHlEQpxYzMvm7EI865EZoot/9A1TiB96w4AvWHraIE7lCzx7zQMUH3hxi5qmNi3rk
 ci+9M1ZwX3UO7rH2yX9g85iKnUJv10RX4OUpKh+3MfMl5z1cMu99tmZcyrwV7ifkmEKCozGmcW
 GRQ//H4ajdGQG67l8qYmDXVe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 06:14:17 -0700
IronPort-SDR: lyPWKhZf/1KaVnDTSJ33hOFTuaA6P5864aPJ+4oKiaIIfvv2yDyGQOXLUac0m3V57AT44snQBq
 x/3vQGMbFqPEmtbgcbqmzppU6GWiCyxHeJb/vjoZE/8ePeNwlT+w4NZtq8wogc3UQtbDh34t/q
 nMxUif8MV96wQSwbZn/ndHodcJfK1OT7s9L8+93o+CUQLINeWnD2u2sKLWEPyodeJM8nj1WKN8
 D7S5IFJQXPEqM5FqAaFQUs+H91i8MnXFbW73ihArxq0MixqFjvX7F2K43bImMxpYU7gFqrc0Aq
 WrA=
WDCIronportException: Internal
Received: from deb000468.ad.shared (HELO localhost.localdomain) ([10.225.0.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2021 06:35:29 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: sanity check zone type
Date:   Fri, 30 Apr 2021 15:34:17 +0200
Message-Id: <20210430133418.4100-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430133418.4100-1-johannes.thumshirn@wdc.com>
References: <20210430133418.4100-1-johannes.thumshirn@wdc.com>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 70b23a0d03b1..304ce64c70a4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1126,6 +1126,11 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 
+		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			ret = -EIO;
+			goto out;
+		}
+
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
-- 
2.31.1

