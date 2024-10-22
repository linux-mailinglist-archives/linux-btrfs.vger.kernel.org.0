Return-Path: <linux-btrfs+bounces-9067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637789AB099
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3821F23FAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C8219F118;
	Tue, 22 Oct 2024 14:15:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4E19AD97
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606532; cv=none; b=T/tvIqt7XMXD/+me0Bl/5k0odcS3yjSDTaUJwXp6/D3rYZMoz46V9tHFZUtOFKMXVYAyfAeXQFCusFQYsD4iEndnYycLE5oVC8tMEuLcooEVOyU9TrdJ6EuRx/ncTsWtFF/OFTwnYROXP2r9NLIVazjW5qNZ5/drl12Rfrl1/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606532; c=relaxed/simple;
	bh=9k2AIoLKTW2VmIGMT+A1LSrMU73kJvdOVYZKEGMgTM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k7h+DJ5QNTKdDKiD1UDW9K7Wodm4kHKLIn348oRvzSrFV6W0EbO9jmsm5DEP0A5QDEYPxdZljci8nq0h7YnZ/IYU9hPE5RoQgSq4uj7kK1wO7d6FbkMrWMayv702mIXy5pGWXr8GPEG/ZLEPQ9SpmeyKMnyoKtnXTvJWb5RqLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so33886795ab.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606530; x=1730211330;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7B4v+GWQAvstfNn3v39eXXCk1aLsKTiXwFVxWjaIiA=;
        b=kXyV6lJVzJYtGKwLfMHGi7DVwvcuGgjLXT5mMI7D6fWf25AzYoBJfwJ7o/eJniB7S0
         r1gkAMJlETDlGXVQoAAXdgx2NCRt1KXNWMZb4kzl3qEefP2cM6bCSxGLSuTP8FXPmepo
         OJvJQi928edVVMaGjhjeVZrWIhYXOMtfe9lzppTqCPFba7g9DvFVBGQv2Q4UCUnmTJLq
         TV7iVK1WN9kaCcXU0docxk64+zi0k+DcLH6/TtBUWR4w54zXemZCFVU0Dfv2bWbC6tcI
         aFXwGGepZ3dcpZzr17Ox/bJqYljRJzaUnDGGceF+CWE6CzUjKSPa96C/D1p4X30rtMaA
         A98g==
X-Forwarded-Encrypted: i=1; AJvYcCUOYvsCiDxwN4Od5PCl5wYXUPhuRRDfWxHXZ1+R7h/HRML9L9vBKGokr9SiqXiuN2BNB6fLCtCdQR8OEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gaWGmiL1tdgr/GeITzIkuIMhtqEEFvDCAtOMrVogb1MsA0o5
	UV5IbVdaJ3oBgKVtV3ANJlfp4ZDxe0ropf6MTZ/yAutFJ7QHI0+a76t/Uq5S5CvelJRrCLIH/NN
	QuPE1hKe41NvgPXsN82EvYKcxn2Sz/SjAWQ/0exz1gYtoly6pes05o50=
X-Google-Smtp-Source: AGHT+IEW6IjdFMeN5kY5LX2hqcuxN1ExJJgRzxNoF35sk953Eog98bSovoyuAtqMVSGLSejqJd1fDcFXbDMWXUQhGZFrU1XWg/Pg
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c565:0:b0:3a0:9d2c:b079 with SMTP id
 e9e14a558f8ab-3a3f409fcf4mr122240195ab.19.1729606529736; Tue, 22 Oct 2024
 07:15:29 -0700 (PDT)
Date: Tue, 22 Oct 2024 07:15:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717b381.050a0220.1e4b4d.0076.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_free_reserved_data_space_noquota (3)
From: syzbot <syzbot+9064acebb06685edb243@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d939780b705 Merge tag 'mm-hotfixes-stable-2024-10-17-16-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca4c5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=9064acebb06685edb243
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4d939780.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12c327c1ad70/vmlinux-4d939780.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7596a960357/bzImage-4d939780.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9064acebb06685edb243@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 262144
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
BTRFS: device fsid 7e32c2af-f87a-45a1-bcba-64dea7c56a53 devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5106)
BTRFS info (device loop0): first mount of filesystem 7e32c2af-f87a-45a1-bcba-64dea7c56a53
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free-space-tree
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5106 Comm: syz.0.0 Not tainted 6.12.0-rc3-syzkaller-00217-g4d939780b705 #0
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
 kmem_cache_alloc_noprof+0x6c/0x2a0 mm/slub.c:4141
 alloc_ordered_extent+0x13b/0x5d0 fs/btrfs/ordered-data.c:172
 btrfs_alloc_ordered_extent+0x1e4/0xa70
 btrfs_create_dio_extent+0x79/0x160 fs/btrfs/direct-io.c:153
 btrfs_new_extent_direct fs/btrfs/direct-io.c:203 [inline]
 btrfs_get_blocks_direct_write+0x972/0xfa0 fs/btrfs/direct-io.c:321
 btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
 iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
 __iomap_dio_rw+0xdea/0x2370 fs/iomap/direct-io.c:677
 btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
 btrfs_direct_write+0x61b/0xa70 fs/btrfs/direct-io.c:880
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1505
 aio_write+0x56b/0x7c0 fs/aio.c:1633
 io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x179/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4756d7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4757b3f038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f4756f35f80 RCX: 00007f4756d7dff9
RDX: 0000000020000540 RSI: 000000000000003b RDI: 00007f4757af5000
RBP: 00007f4757b3f090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f4756f35f80 R15: 00007ffc4b13df48
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5106 at fs/btrfs/space-info.h:250 btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:250 [inline]
WARNING: CPU: 0 PID: 5106 at fs/btrfs/space-info.h:250 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:283 [inline]
WARNING: CPU: 0 PID: 5106 at fs/btrfs/space-info.h:250 btrfs_free_reserved_data_space_noquota+0x287/0x4f0 fs/btrfs/delalloc-space.c:179
Modules linked in:
CPU: 0 UID: 0 PID: 5106 Comm: syz.0.0 Not tainted 6.12.0-rc3-syzkaller-00217-g4d939780b705 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:250 [inline]
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:283 [inline]
RIP: 0010:btrfs_free_reserved_data_space_noquota+0x287/0x4f0 fs/btrfs/delalloc-space.c:179
Code: 00 74 08 4c 89 e7 e8 68 e1 23 fe 4d 8b 2c 24 4c 89 ef 48 8b 5c 24 20 48 89 de e8 34 2e ba fd 49 39 dd 73 19 e8 ca 2b ba fd 90 <0f> 0b 90 31 db 4c 8b 6c 24 10 41 80 3c 2f 00 75 2b eb 31 e8 b1 2b
RSP: 0018:ffffc9000b2df200 EFLAGS: 00010293
RAX: ffffffff83dabc36 RBX: 0000000000004000 RCX: ffff88801cd1c880
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000000003000
RBP: dffffc0000000000 R08: ffffffff83dabc2c R09: 1ffffffff2039ff5
R10: dffffc0000000000 R11: fffffbfff2039ff6 R12: ffff888040b7a068
R13: 0000000000003000 R14: ffff88804c94c000 R15: 1ffff1100816f40d
FS:  00007f4757b3f6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d4b4513e88 CR3: 000000003e504000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_free_reserved_data_space+0xa2/0xe0 fs/btrfs/delalloc-space.c:199
 btrfs_dio_iomap_begin+0x7c6/0x1180 fs/btrfs/direct-io.c:598
 iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
 __iomap_dio_rw+0xdea/0x2370 fs/iomap/direct-io.c:677
 btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
 btrfs_direct_write+0x61b/0xa70 fs/btrfs/direct-io.c:880
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1505
 aio_write+0x56b/0x7c0 fs/aio.c:1633
 io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x179/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4756d7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4757b3f038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f4756f35f80 RCX: 00007f4756d7dff9
RDX: 0000000020000540 RSI: 000000000000003b RDI: 00007f4757af5000
RBP: 00007f4757b3f090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f4756f35f80 R15: 00007ffc4b13df48
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

