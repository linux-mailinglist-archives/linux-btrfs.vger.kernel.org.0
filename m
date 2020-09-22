Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5252273D47
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIVI2E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 04:28:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45254 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIVI2E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 04:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600763285; x=1632299285;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AQkOyEKRLSc+Vr3jY0wPdwR5EUwS2wbYEl2sfH05dwA=;
  b=AU9Rtd/MeZn8IxgKChQvwQHQrjx468B4PMsatSDZdx0M+D9VKdMGPQBs
   nf3Bsn2f4tA3ibFU572kiPqiFNtWaKX/Dh4yAt+z6aM24h+aBfnIIr6M9
   aqPigSdmS8wERshJ+hwgcPJKHXPklW8855OVewgxGoXnah/hT1ZHWROMY
   2qnEsRPSpIie1TCPhn95aWDZW1VNq3I3LW4HMgUK0nGlFQsA4JoOpvhgf
   MgyzvvR8m07U8HgSipAe+hW7r3X2Zo0+biMndug0lT1n777S/B5LLxEPn
   HvsR9MeE1Tnn0i6Q86JQSDI85kz3AdroTu+WYPpdeEkH4qTH8sHyh4lGN
   Q==;
IronPort-SDR: slzkhDGyQWvGZFktBC0as25cukXJ73L6pggc6IWKFbOjhmDUHvfLA7OlWjlZQxrTNzO5bQ9aoH
 4y+m005QVrCoV2MNxFx7F5b/4zNAE3TNezT9xeg454MPXX4F+sWMdQmF3EONEq5ilOHU2J+PkK
 MQ/ClDFjsT0IKFbCI+ZJX+CAT4ZpvaB9ieRKCrE2d0iSRqykRi4++mcUIitb0W73VabDiJR+Dr
 Gwa7hQJDhmlfpBg9F8AtteyIsnOZIsQP2x9a+X3PMdg/vZUM7C9/9V+lrGdXAgmiuFUP5hACFY
 4bA=
X-IronPort-AV: E=Sophos;i="5.77,290,1596470400"; 
   d="scan'208";a="147982336"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2020 16:28:04 +0800
IronPort-SDR: rq5SOrhPHZ1VnuXy2OyO96WjxFQRNxGJhqYZJxryNI1hOM1k2e0MbWN5qZtTKUYKQikytU9O0x
 But6VMxUjFsA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 01:14:12 -0700
IronPort-SDR: 5SS+Ld5eLaUF3XpcuPgGBZAXx/vT4BrtOHplFInl4OxeZG/VzqtDMPyLtK1n9R1e7pJUajHTH3
 fw6HsudZ5Q+Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2020 01:28:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: reschedule when cloning lots of extents
Date:   Tue, 22 Sep 2020 17:27:29 +0900
Message-Id: <42f05219ee6dfd612fe38f0ec6209d5a2c6c23dc.1600763203.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have several occurrences of a soft lockup from xfstest's generic/175
test-case, which look more or less like this one:

 watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [xfs_io:10030]
 Kernel panic - not syncing: softlockup: hung tasks
 CPU: 0 PID: 10030 Comm: xfs_io Tainted: G             L    5.9.0-rc5+ #768
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack+0x77/0xa0
  panic+0xfa/0x2cb
  watchdog_timer_fn.cold+0x85/0xa5
  ? lockup_detector_update_enable+0x50/0x50
  __hrtimer_run_queues+0x99/0x4c0
  ? recalibrate_cpu_khz+0x10/0x10
  hrtimer_run_queues+0x9f/0xb0
  update_process_times+0x28/0x80
  tick_handle_periodic+0x1b/0x60
  __sysvec_apic_timer_interrupt+0x76/0x210
  asm_call_on_stack+0x12/0x20
  </IRQ>
  sysvec_apic_timer_interrupt+0x7f/0x90
  asm_sysvec_apic_timer_interrupt+0x12/0x20
 RIP: 0010:btrfs_tree_unlock+0x91/0x1a0 [btrfs]
 Code: 85 1e 01 00 00 c7 83 84 00 00 00 00 00 00 00 f0 83 44 24 fc 00 48 8b 83 10 01 00 00 48 8d bb d0 00 00 00 48 81 c3 10 01 00 00 <48> 39 d8 74 63 5b 31 c9 5d ba 01 00 00 00 be 03 00 00 00 41 5c e9
 RSP: 0018:ffffc90007123a58 EFLAGS: 00000282
 RAX: ffff8881cea2fbe0 RBX: ffff8881cea2fbe0 RCX: 0000000000000000
 RDX: ffff8881d23fd200 RSI: ffffffff82045220 RDI: ffff8881cea2fba0
 RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000032
 R10: 0000160000000000 R11: 0000000000001000 R12: 0000000000001000
 R13: ffff8882357fd5b0 R14: ffff88816fa76e70 R15: ffff8881cea2fad0
  ? btrfs_tree_unlock+0x15b/0x1a0 [btrfs]
  btrfs_release_path+0x67/0x80 [btrfs]
  btrfs_insert_replace_extent+0x177/0x2c0 [btrfs]
  btrfs_replace_file_extents+0x472/0x7c0 [btrfs]
  btrfs_clone+0x9ba/0xbd0 [btrfs]
  btrfs_clone_files.isra.0+0xeb/0x140 [btrfs]
  ? file_update_time+0xcd/0x120
  btrfs_remap_file_range+0x322/0x3b0 [btrfs]
  do_clone_file_range+0xb7/0x1e0
  vfs_clone_file_range+0x30/0xa0
  ioctl_file_clone+0x8a/0xc0
  do_vfs_ioctl+0x5b2/0x6f0
  __x64_sys_ioctl+0x37/0xa0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f87977fc247
 Code: 00 00 90 48 8b 05 49 8c 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 8c 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffd51a2f6d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f87977fc247
 RDX: 00007ffd51a2f710 RSI: 000000004020940d RDI: 0000000000000003
 RBP: 0000000000000004 R08: 00007ffd51a79080 R09: 0000000000000000
 R10: 00005621f11352f2 R11: 0000000000000206 R12: 0000000000000000
 R13: 0000000000000000 R14: 00005621f128b958 R15: 0000000080000000
 Kernel Offset: disabled
 ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---

All of these lockup reports have the call chain btrfs_clone_files() ->
btrfs_clone() in common. btrfs_clone_files() calls btrfs_clone() with
both source and destination extents locked and loops over the source
extent to create the clones.

Conditionally reschedule in the btrfs_clone() loop, to give some time back
to other processes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
- Update changelog
---
 fs/btrfs/reflink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 39b3269e5760..99aa87c08912 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -520,6 +520,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			ret = -EINTR;
 			goto out;
 		}
+
+		cond_resched();
 	}
 	ret = 0;
 
-- 
2.26.2

