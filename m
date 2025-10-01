Return-Path: <linux-btrfs+bounces-17317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F38BB1A4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 21:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC843BAC31
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F826B2AD;
	Wed,  1 Oct 2025 19:46:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006B2AD0C
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347988; cv=none; b=pkidpDNwtmVojutBjafUPq8VVMgpxVbywVP9AR3tZ53mVZ07ExaRdih5kvHywKu65MR4G7ZvFdl9T0UTBCy9cCeYBFOH/0A0F2/jWf8A6P2DfE6Uka1ZGMilG11/YqhAVoG47Fg5Oenk2G5CSf2iUJq+SnnmKvjfsF8DCfgPyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347988; c=relaxed/simple;
	bh=RIdIb6zx1WW1qhGtBR5/lLht3Qe4tk06rHKgRADMKEQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FW+C3H+CRfmeVI6FgJu6aghp4HjLe7AUT5RGbR0+zqDVoTc5eU6elOYebFD/qZORheWsc2NGi1AvSJ/LGUesOs4ZbtyjR47ZJDgI5+FHgJkc1RYyJ71JYxeK9SVKB+J/rf0wKINl7gTy3BfmCtNKWCvv9o7WLu7zDez6ilSTLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4297610aacaso3382715ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 12:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347986; x=1759952786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql/Ot4y0cihorogIf7YKkewbTCHB+GiRiFTLWynohQQ=;
        b=i0SjT8m8Hwy/G/P3A/wa11GGEMHMXMRXxY4pqdBs1+Bba1h10wdWfUkdCwrjEQpYE3
         fOvQbsd+6Kz2+I0STsZc8GX+gG3GV9EpEuAk6Ie6c84Lox/WATBRbFI3bC3kQJYGeN8f
         koeA9v7n2RczlTVozKzBczMMXGCyyC+vEAqOmCPIVoQ6f+sG3rCxyw/E6lewp/FmWB+g
         BdhgqSNj9ulBf5+HiPKCvWhqeU8Juj2AuCNRwdaxS3TvxmTZv7TdCudmnxl62B9g0A/L
         riRxoyrsqBSrsOY49J8ff9WY3mPgekb3JjigzekS2c4Q/UyB5rulBJO8PvlijBlsNnud
         /t+w==
X-Forwarded-Encrypted: i=1; AJvYcCXb3DP0XY4+mbYM0HniuH6SNszhsZ7K5vbfiPt8DVVbqMH3+lEOYYqcdH5gWuPKP9QbN/eDH1mY/UIEEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEW2Bc0R6Ws+LvvfDG/5N417qhueazV5RQW7jKoy3JXfm8DGG0
	fhrOVXJE3drZg74DSH45ZMuEQcdJ3JSKaKV82b2R8k1Fd8HWJTogFwIja//ZkbbLIfsd6nOawJX
	Tk0bgSu01mF1tnY5GPSImO9nkCm30+vNVqpyTviWP6RvyuSps/ifg2xUqtl0=
X-Google-Smtp-Source: AGHT+IFBKhQFQnnrgTcFcFXd9HK8fgpdFuJfS/MY/ZXi6rwziYuzS9/413ZnJucBR3HratS4XkG2X4+H7/P6zXTcbxgLXxXon2KQ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:42d:86cc:1bcd with SMTP id
 e9e14a558f8ab-42d86cc1c65mr35927815ab.3.1759347986267; Wed, 01 Oct 2025
 12:46:26 -0700 (PDT)
Date: Wed, 01 Oct 2025 12:46:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd8512.050a0220.25d7ab.077a.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in __cow_file_range_inline
From: syzbot <syzbot+e74e4a74c03733ebac54@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec734e8d564 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1073b142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=e74e4a74c03733ebac54
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fec734e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9cf7097db7bd/vmlinux-fec734e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca6d872c8346/bzImage-fec734e8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e74e4a74c03733ebac54@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid e417788f-7a09-42b2-9266-8ddc5d5d35d2 devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5360)
BTRFS info (device loop0): first mount of filesystem e417788f-7a09-42b2-9266-8ddc5d5d35d2
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS warning (device loop0): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): setting nodatasum
BTRFS info (device loop0): allowing degraded mounts
BTRFS info (device loop0): enabling disk space caching
BTRFS info (device loop0): force clearing of disk cache
BTRFS info (device loop0): force zlib compression, level 3
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 5360 at fs/btrfs/inode.c:635 __cow_file_range_inline+0xdc4/0x1260 fs/btrfs/inode.c:635
Modules linked in:
CPU: 0 UID: 0 PID: 5360 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__cow_file_range_inline+0xdc4/0x1260 fs/btrfs/inode.c:635
Code: 00 e8 10 94 da fd 84 c0 74 29 e8 57 f1 f3 fd e9 6d 01 00 00 e8 4d f1 f3 fd 90 48 c7 c7 20 dd ed 8b 44 89 e6 e8 fd 80 b7 fd 90 <0f> 0b 90 90 e9 72 fc ff ff e8 6e a5 b0 07 41 89 c7 31 ff 89 c6 e8
RSP: 0018:ffffc9000d556680 EFLAGS: 00010246
RAX: 10ba3533504e6700 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e17a000 RSI: 0000000000034014 RDI: 0000000000034015
RBP: ffffc9000d556870 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a234 R12: 00000000ffffffe4
R13: 1ffff1100641d3c8 R14: ffff8880320e9e40 R15: ffff888052e34001
FS:  00007ff11f0e36c0(0000) GS:ffff88808d007000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000440 CR3: 0000000043940000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 cow_file_range_inline+0x2fc/0x3d0 fs/btrfs/inode.c:692
 cow_file_range+0x449/0x10a0 fs/btrfs/inode.c:1297
 btrfs_run_delalloc_range+0x3f9/0xf80 fs/btrfs/inode.c:2352
 writepage_delalloc+0xf06/0x1a60 fs/btrfs/extent_io.c:1435
 extent_writepage fs/btrfs/extent_io.c:1779 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2463 [inline]
 btrfs_writepages+0x12df/0x22c0 fs/btrfs/extent_io.c:2596
 do_writepages+0x32e/0x550 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 filemap_fdatawrite_range+0x1a5/0x250 mm/filemap.c:437
 btrfs_fdatawrite_range fs/btrfs/file.c:3859 [inline]
 start_ordered_ops fs/btrfs/file.c:1518 [inline]
 btrfs_sync_file+0x3a1/0x1160 fs/btrfs/file.c:1600
 generic_write_sync include/linux/fs.h:3043 [inline]
 btrfs_do_write_iter+0x59a/0x710 fs/btrfs/file.c:1470
 iter_file_splice_write+0x975/0x10e0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x5a5/0xcc0 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff11e18eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff11f0e3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007ff11e3e5fa0 RCX: 00007ff11e18eec9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00007ff11e211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000040001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff11e3e6038 R14: 00007ff11e3e5fa0 R15: 00007ffcc89ac948
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

