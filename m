Return-Path: <linux-btrfs+bounces-9306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999919BA0CF
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2024 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A97F1F21A86
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B419E97B;
	Sat,  2 Nov 2024 14:36:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148F189F2D
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Nov 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558186; cv=none; b=PiQCWEXo1Q0pL2Alj1VQJuir+O67BEZ8I9xtFHCHQU0/Zn6a44rkIiMh+9OzP9MQNRl+345k8FC541Ud1TKDyRMFyU2N/uGSM65bWJ8CQxB2gFFWYXRsPjuvGfc4Ingrp4Mz9hLFLzu+WlxNMVNJYAWijyfL8y+RC4OeTpZ+/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558186; c=relaxed/simple;
	bh=Hq7LeRtWWHNSpxmrELB/KoukxLDE/IoD0HQdxrVrMWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qMRhhUTDL/3keF9is5pZjgTIwCisq9Rc+i2zuz9IaZeWIkcCDztu/lVOEhvvU07XPzrlYBNxBIDF+hfkmP1IYU0kKfSpLndkLIM4XDYIlgOjVLSOQ5Dkb9WWsPOeguUcXgqDS2QBDFA68Ae1Jghides0WP/zvkIVz08xz0daqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abb901672so281448039f.3
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Nov 2024 07:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730558183; x=1731162983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GTWqt0xvaCSN1qf/sSPayNPZCvP3igGeul6m1e2K8M=;
        b=L/Er1UkiCBA9UZI8dVUqn7qSyvgL3N1Wjdy2vS/dTAtLfPrhM0Wp0puyGUy1pr3Pj3
         O+lbd0isf8GTwcLoT+PxGg/st5OBWOc4XZDqy94BCI2dkTaRO5lKl4b8y7jS+BcuSN7y
         aSBp/n2erz5GG51H7kyyZXpE7jgn/cRIlNUySf8k2Hp3xF9nwDBvegVEuaOtP6a3bq/Q
         KIVo3eZtTd0XvVVFU2u7ycYpIAfF5QrAgwUx8gBSqqC41fqVgSzMqz5NbUQ71q60nbY2
         I4ngtTuv27j6yCDMKvtCpqSOpnwN4SZsKPr34Bhjz6ys6B66qFu5VqFcklvau1ssHsKp
         k87w==
X-Forwarded-Encrypted: i=1; AJvYcCUVmbEql9cOVwMeijbOXAa+pEGb17XzSSEQ4wHSu+WuSpYlLTWQsBsQK2lwwoLp9WDuxkytFi1QyrSMag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KxDSBQBNOxRHPzdFkJ3UPMsX+nSZNnm5lGlDbdZTp7ffAwbX
	RkY6uQsNTACGV+HxTTFyt/2ekgDipSZDyKPrwOi0W9VsNVzcgehC82ZaJ4KVwWhdzwBvB+FbG36
	CiWGjVpEdtLyWchGByDCfH6puZQUFv808LnfF8grNH4XZVXczgN6QqdY=
X-Google-Smtp-Source: AGHT+IGlk5YC61OLEFsOGWEauZxp1QDXq9SFdErvoBgv0oo+xxUfTYak1zIkcJt5L3bmvyLFgO9CYfjuWqXP8kXHE0ImnDcqj60U
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6b25813e9mr58003515ab.2.1730558183596; Sat, 02 Nov 2024
 07:36:23 -0700 (PDT)
Date: Sat, 02 Nov 2024 07:36:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672638e7.050a0220.3c8d68.0990.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in tree_insert_offset
From: syzbot <syzbot+b7baad46fdef9a0008ce@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16854a30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b7baad46fdef9a0008ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e2253169da8/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9d2f5008f24/bzImage-e42b1a9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7baad46fdef9a0008ce@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 262144
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
BTRFS: device fsid 7e32c2af-f87a-45a1-bcba-64dea7c56a53 devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5332)
BTRFS info (device loop0): first mount of filesystem 7e32c2af-f87a-45a1-bcba-64dea7c56a53
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free-space-tree
BTRFS info (device loop0): scrub: started on devid 1
BTRFS info (device loop0): scrub: finished on devid 1 with status: 0
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5332 Comm: syz.0.0 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
 should_failslab+0xac/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4038 [inline]
 slab_alloc_node mm/slub.c:4114 [inline]
 __kmalloc_cache_noprof+0x6c/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 btrfs_cache_block_group+0xc5/0x6f0 fs/btrfs/block-group.c:928
 btrfs_update_block_group+0x26c/0xb30 fs/btrfs/block-group.c:3676
 do_free_extent_accounting fs/btrfs/extent-tree.c:2998 [inline]
 __btrfs_free_extent+0x1d88/0x3a10 fs/btrfs/extent-tree.c:3362
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1740 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1766 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2031 [inline]
 __btrfs_run_delayed_refs+0x112e/0x4680 fs/btrfs/extent-tree.c:2101
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2213
 btrfs_commit_transaction+0x4be/0x3740 fs/btrfs/transaction.c:2197
 sync_filesystem+0x1c8/0x230 fs/sync.c:66
 btrfs_reconfigure+0x2f3/0x2c30 fs/btrfs/super.c:1507
 reconfigure_super+0x445/0x880 fs/super.c:1083
 vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 vfs_fsconfig_locked fs/fsopen.c:291 [inline]
 __do_sys_fsconfig fs/fsopen.c:472 [inline]
 __se_sys_fsconfig+0xb68/0xf70 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b17f7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5b18d79038 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f5b18135f80 RCX: 00007f5b17f7e719
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000005
RBP: 00007f5b18d79090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f5b18135f80 R15: 00007ffd6518d2d8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5332 at fs/btrfs/free-space-cache.c:1638 tree_insert_offset+0x2c9/0x350 fs/btrfs/free-space-cache.c:1638
Modules linked in:
CPU: 0 UID: 0 PID: 5332 Comm: syz.0.0 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:tree_insert_offset+0x2c9/0x350 fs/btrfs/free-space-cache.c:1638
Code: e8 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 38 4f cb fd 90 0f 0b 90 bd ef ff ff ff eb db e8 28 4f cb fd 90 <0f> 0b 90 bd ef ff ff ff eb cb e8 18 4f cb fd 90 0f 0b 90 4d 85 ed
RSP: 0018:ffffc9000d2ce948 EFLAGS: 00010293
RAX: ffffffff83c98968 RBX: ffff8880362db4e0 RCX: ffff88800021a440
RDX: 0000000000000000 RSI: 0000000001504000 RDI: 0000000001504000
RBP: ffff8880362db6d8 R08: ffffffff83c98834 R09: fffff52001a59d34
R10: dffffc0000000000 R11: fffff52001a59d34 R12: ffff8880362db498
R13: 0000000001504000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f5b18d796c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559cf5234740 CR3: 000000004073c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 link_free_space+0xef/0x5d0 fs/btrfs/free-space-cache.c:1844
 btrfs_find_space_for_alloc+0xdb4/0xed0 fs/btrfs/free-space-cache.c:3133
 find_free_extent_unclustered fs/btrfs/extent-tree.c:3781 [inline]
 do_allocation_clustered fs/btrfs/extent-tree.c:3804 [inline]
 do_allocation fs/btrfs/extent-tree.c:4006 [inline]
 find_free_extent+0x2e59/0x5850 fs/btrfs/extent-tree.c:4541
 btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4695
 btrfs_alloc_tree_block+0x202/0x1440 fs/btrfs/extent-tree.c:5150
 btrfs_force_cow_block+0x526/0x1da0 fs/btrfs/ctree.c:573
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_update_device+0x1b0/0x580 fs/btrfs/volumes.c:2902
 remove_chunk_item+0x166/0x700 fs/btrfs/volumes.c:3183
 btrfs_remove_chunk+0xa12/0x1b20 fs/btrfs/volumes.c:3269
 btrfs_delete_unused_bgs+0xd94/0x1120 fs/btrfs/block-group.c:1681
 btrfs_remount_ro fs/btrfs/super.c:1359 [inline]
 btrfs_reconfigure+0xbda/0x2c30 fs/btrfs/super.c:1540
 reconfigure_super+0x445/0x880 fs/super.c:1083
 vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 vfs_fsconfig_locked fs/fsopen.c:291 [inline]
 __do_sys_fsconfig fs/fsopen.c:472 [inline]
 __se_sys_fsconfig+0xb68/0xf70 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b17f7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5b18d79038 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f5b18135f80 RCX: 00007f5b17f7e719
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000005
RBP: 00007f5b18d79090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f5b18135f80 R15: 00007ffd6518d2d8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

