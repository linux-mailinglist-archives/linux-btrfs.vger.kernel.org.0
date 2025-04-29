Return-Path: <linux-btrfs+bounces-13528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1717AA1C8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AF8466F6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAAB26AAAA;
	Tue, 29 Apr 2025 20:56:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C082269CE8
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960183; cv=none; b=QlslHrCM2wzx61gQ87TRHYbRxECHceTA9rTfb/ydesnLasVPrUY8kxYqa+b3gatQWvSH0Ls5T0VuGTYE7+XPcC0idNW99Qp0fz2V0T94WyRFE2Rb5PkFW+X/q2BTimfyZFMGd207tKdkfC+FbQTK2u+s1WwUTFkE236pc2Azlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960183; c=relaxed/simple;
	bh=TvYteADXHlYWNgP4cfLc0lqc/TZbG7JhWu45h0hDVqo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UZvPEBaNW6sz9NUmfdRtKlTuW+k/cAGPlsWjqaT8PEP+2kzMEH2RbeRLW7yh0ASyijf7XdaovNrMPwUfIuqQ4Ey7VxEMt6NGcwKumCuGl8o5FRQN0Wa//ThOgNwfSr7e5HHaYYXGpmDyp6g4ysc9+oKTt8FK8XwAln2d3rn5JmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b41b906b3so741847239f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 13:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745960181; x=1746564981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLc1vhZzSKbLGp0YmqKJE/f9yrF67odan8fJEGQKzus=;
        b=fROCbcxjMV/gwUfaIZgm6u5qPZGtBkCkfo4zx6mSXkwWX0xBvk6K5Y98HPcaEzxw4n
         AZTO/FRbmJBWOWEuxsOfmS13wlsIpG/OBMiUBjSyK0K3lpSsPvLIj3ORXChYxKyz7XR4
         ywWeV8xTh5tpmTk0ePblwZQYzkN94BLed5Kby4RGgYoGVkjUrsftcRUTs3B9GBatnMpr
         DJw5+nfF6VGHcs4MREjCq7Fwb0vUWJwCZ+izXc173lF6MZLvaFsw00i8q5cHHQ84voN+
         Li1p8M9YIBuzzjYQt4WlyJ/QFyTQHHNhVfp2AH/mbMoKkGYC/ABXBYtCvRVMWuUpxZiK
         YmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3yqO55ucH2uHKK1C36i2TR/bCnGoQqlQFUNjVgB9BcqIF/OmKWZI2XjNP/k8pUctbMkPsWIkBYGebWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSL1fPWZcrRpEwQ6pyGe0GPRwlvw4ViQQtNKuqrvAKFHDTpQWY
	ZGyyUNqBFeemaLWpaKIk4+soK7Zywb6EKXOLPZUWjvmNO9jtNfQ0GE9e8skclVldPX2bT2uOeqF
	tMq8GSACVQxkusZVkTm/zZwpoqwdOOfGpNfom2qsC9vrSRVorTG+yX1c=
X-Google-Smtp-Source: AGHT+IHpXbBKE78JhMrYX26YX8nbjBvYe6b8dYCV6Sra/bI7zIu0cKhlnUpH89XI8Bauvm/sYiE9+lB99wq1jLBJfnVJ3wwwaTvU
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3945:b0:85b:3885:159e with SMTP id
 ca18e2360f4ac-86495e1fc7amr125287839f.3.1745960181091; Tue, 29 Apr 2025
 13:56:21 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:56:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68113cf5.050a0220.16fb2c.0004.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in tree_insert_offset (2)
From: syzbot <syzbot+3b8bde8dd279360a77f3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15645d74580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90837c100b88a636
dashboard link: https://syzkaller.appspot.com/bug?extid=3b8bde8dd279360a77f3
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-5bc10186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a2f39285e07/vmlinux-5bc10186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a37a55f34fb/bzImage-5bc10186.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b8bde8dd279360a77f3@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 262144
BTRFS: device fsid b228cae2-8774-489f-9b8f-7356eedc2a2d devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5313)
BTRFS info (device loop0): first mount of filesystem b228cae2-8774-489f-9b8f-7356eedc2a2d
BTRFS info (device loop0): using blake2b (blake2b-256-generic) checksum algorithm
BTRFS info (device loop0): using free-space-tree
BTRFS info (device loop0): scrub: started on devid 1
BTRFS error (device loop0): super block at physical 67108864 devid 1 has bad csum
BTRFS info (device loop0): scrub: finished on devid 1 with status: 0
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5313 Comm: syz.0.0 Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x414/0x560 lib/fault-inject.c:174
 should_failslab+0xa8/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4114 [inline]
 slab_alloc_node mm/slub.c:4190 [inline]
 __kmalloc_cache_noprof+0x70/0x3d0 mm/slub.c:4367
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 btrfs_cache_block_group+0xc1/0x6f0 fs/btrfs/block-group.c:925
 btrfs_update_block_group+0x249/0xad0 fs/btrfs/block-group.c:3704
 do_free_extent_accounting fs/btrfs/extent-tree.c:2977 [inline]
 __btrfs_free_extent+0x16f7/0x2eb0 fs/btrfs/extent-tree.c:3340
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1747 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1773 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1970 [inline]
 __btrfs_run_delayed_refs+0xe7b/0x3a50 fs/btrfs/extent-tree.c:2040
 btrfs_run_delayed_refs+0xe6/0x300 fs/btrfs/extent-tree.c:2152
 btrfs_commit_transaction+0x26f/0x3720 fs/btrfs/transaction.c:2209
 sync_filesystem+0x1cc/0x230 fs/sync.c:66
 btrfs_reconfigure+0x2dd/0x2d30 fs/btrfs/super.c:1504
 reconfigure_super+0x224/0x890 fs/super.c:1083
 do_remount fs/namespace.c:3368 [inline]
 path_mount+0xd18/0xfe0 fs/namespace.c:4203
 do_mount fs/namespace.c:4224 [inline]
 __do_sys_mount fs/namespace.c:4435 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4412
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ea378e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8e9fbf5038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8ea39b5fa0 RCX: 00007f8ea378e969
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 00007f8e9fbf5090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000021 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f8ea39b5fa0 R15: 00007fff9d31f458
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5313 at fs/btrfs/free-space-cache.c:1641 tree_insert_offset+0x2bf/0x340 fs/btrfs/free-space-cache.c:1641
Modules linked in:
CPU: 0 UID: 0 PID: 5313 Comm: syz.0.0 Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:tree_insert_offset+0x2bf/0x340 fs/btrfs/free-space-cache.c:1641
Code: 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 92 a5 ee fd 90 0f 0b 90 bd ef ff ff ff eb da e8 82 a5 ee fd 90 <0f> 0b 90 bd ef ff ff ff eb ca e8 72 a5 ee fd 90 0f 0b 90 4d 85 e4
RSP: 0018:ffffc9000d38ea68 EFLAGS: 00010293
RAX: ffffffff83d1194e RBX: dffffc0000000000 RCX: ffff88801f090000
RDX: 0000000000000000 RSI: 0000000001504000 RDI: 0000000001504000
RBP: ffff88804203e540 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52001a71d58 R12: ffff88804203e828
R13: ffff88804203e588 R14: 0000000000000000 R15: 0000000001504000
FS:  00007f8e9fbf56c0(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f3591a0338 CR3: 00000000422e9000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 link_free_space+0xf5/0x570 fs/btrfs/free-space-cache.c:1847
 btrfs_find_space_for_alloc+0xc4a/0xd50 fs/btrfs/free-space-cache.c:3135
 find_free_extent_unclustered fs/btrfs/extent-tree.c:3760 [inline]
 do_allocation_clustered fs/btrfs/extent-tree.c:3783 [inline]
 do_allocation fs/btrfs/extent-tree.c:3985 [inline]
 find_free_extent+0x2db0/0x56f0 fs/btrfs/extent-tree.c:4520
 btrfs_reserve_extent+0x2fd/0x670 fs/btrfs/extent-tree.c:4674
 btrfs_alloc_tree_block+0x1df/0x1210 fs/btrfs/extent-tree.c:5127
 btrfs_force_cow_block+0x4de/0x1cb0 fs/btrfs/ctree.c:506
 btrfs_cow_block+0x3c2/0x830 fs/btrfs/ctree.c:688
 btrfs_search_slot+0xb4b/0x2a50 fs/btrfs/ctree.c:-1
 btrfs_update_device+0x149/0x4c0 fs/btrfs/volumes.c:3039
 remove_chunk_item+0x169/0x5f0 fs/btrfs/volumes.c:3318
 btrfs_remove_chunk+0x838/0x1910 fs/btrfs/volumes.c:3404
 btrfs_delete_unused_bgs+0xc56/0xf30 fs/btrfs/block-group.c:1701
 btrfs_remount_ro fs/btrfs/super.c:1356 [inline]
 btrfs_reconfigure+0xbcd/0x2d30 fs/btrfs/super.c:1537
 reconfigure_super+0x224/0x890 fs/super.c:1083
 do_remount fs/namespace.c:3368 [inline]
 path_mount+0xd18/0xfe0 fs/namespace.c:4203
 do_mount fs/namespace.c:4224 [inline]
 __do_sys_mount fs/namespace.c:4435 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4412
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ea378e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8e9fbf5038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8ea39b5fa0 RCX: 00007f8ea378e969
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 00007f8e9fbf5090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000021 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f8ea39b5fa0 R15: 00007fff9d31f458
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

