Return-Path: <linux-btrfs+bounces-18342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B941C0B0D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 20:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DA9189D55B
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720CD2FDC49;
	Sun, 26 Oct 2025 19:11:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585702798F3
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761505893; cv=none; b=gFR8HOtltgjh80Tzx3G37aNTgjmAciGrNEg66xZ3cqqheHwLDGEvHhS3JuU7rguFaKsPuGiC2AJb8aCEXYWW3/Ymfeq0FJEDwgsQjQ9OgdjyZG9xM/TYPrG1JSYdRQ3/pEjzBa2wAPo7PWWiua1mDGcvAtrhObpOm6H3nI3y/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761505893; c=relaxed/simple;
	bh=gB+/H1jHc3kXm0oQn9JJNSxv/rmr/mkFCubhGERWOe0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l8GwW8TGGNB47yagEjBJf45iXBbAwvDweP/ZKLuO6GIS0LgzOc1m7x0bjecV9qq17mIKlIeSvjivzUppRvkXDHTjCjbzDgvxsm+KQaxkRMKumHZGbx6VrRn7GPYMXF35rugMaQmakkpWzAy97nbstniMfFz7tdkQsuyQMMMQCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430d789ee5aso49114535ab.2
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 12:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761505890; x=1762110690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+kphTYoer9Bj1J3zBI4eWzahyJezzwpuW4Mnn7Kco4=;
        b=NzCjDxUkrYhoxJJJj1Xes1u6CAGx10Pb9VzAhSMxquDKKzhEoTrmXTtYf5CE+LOKyL
         I6uiuCoy9xJXS10/GLsbusIxgZuZrXtgRV0cVe6nPoBvsX4rDYRGTqRtZWcbDzOWQCoK
         XjIKc8D/pIUxAEuwmyEZjhC+oIp4uCeLjxOE+shAeL4itRoI3TBvrH80vYP2LFwiQDts
         vM+pbCuUVEsChEX9kUYKt+vS7Um3HJy/WiE69zxEjXHzA0vJL9mrb1EP7V5ekm0pr2/Y
         avGopKnpbWLTilKzpIL8WTLbotjHoLMD040Ul9KdO6qPyCg2adQStuufnSBRolvrfKDa
         RDfA==
X-Forwarded-Encrypted: i=1; AJvYcCWNWTllIK4j+leLxu/xsGiJIegvSf+ktFNDnW9epfH7RrBhE7JLZ2X6OldGS+q3MND7z2Ws7jazZfw4BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XaQdK5Uu98CHQ/ouucG/m45pKvdtTkT9b+Sgq7rsByVzhOEu
	Tna0JQWq4gYyc+aTmAcgSl6xqag+wBbhHdv/0+rM3luEgFmbLMz5ZdYDFPf30MvMgXm/JPxcj1e
	S6g21N5kMtRXGy21hXVykweOIDlb6K1XlMi20uxaA5PCZcPRiwbeC9oDEo3Y=
X-Google-Smtp-Source: AGHT+IGDEU9U4Z+L7cBPuqTs8NtO6WkLHGO9pQDYO8IFWzvKfxSzGkoEojTSu0k4eG+tyOrG2QyvQ+VUXo5k2uMTK2MFqTWC3kRn
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-430c5263fcbmr520530915ab.13.1761505890465; Sun, 26 Oct 2025
 12:11:30 -0700 (PDT)
Date: Sun, 26 Oct 2025 12:11:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe7262.050a0220.3344a1.0145.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_destroy_inode (3)
From: syzbot <syzbot+25df068cd8509f8c0fe1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43e9ad0c55a3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127ea3cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df98b4d1d5944c56
dashboard link: https://syzkaller.appspot.com/bug?extid=25df068cd8509f8c0fe1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-43e9ad0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58bbcd26d07f/vmlinux-43e9ad0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7223e24dee9/bzImage-43e9ad0c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25df068cd8509f8c0fe1@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
BTRFS error (device loop0): bdev /dev/loop0 errs: wr 3, rd 1, flush 0, corrupt 0, gen 0
BTRFS error (device loop0 state EA): nocow_one_range failed, root=-9 inode=258 start=53248 len=12288: -5
BTRFS error (device loop0 state EA): run_delalloc_nocow failed, root=18446744073709551607 inode=258 start=53248 len=12288 cur_offset=53248 oe_cleanup=53248 oe_cleanup_len=0 untouched_start=65536 untouched_len=0: -5
BTRFS error (device loop0 state EA): failed to run delalloc range, root=-9 ino=258 folio=53248 submit_bitmap=0 start=53248 len=12288: -5
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5324 at fs/btrfs/inode.c:7942 btrfs_destroy_inode+0x7c9/0x910 fs/btrfs/inode.c:7942
Modules linked in:
CPU: 0 UID: 0 PID: 5324 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_destroy_inode+0x7c9/0x910 fs/btrfs/inode.c:7942
Code: 4a fd ff e9 03 ff ff ff e8 d4 6a ef fd 90 0f 0b 90 e9 c4 f8 ff ff e8 c6 6a ef fd 90 0f 0b 90 e9 ee f8 ff ff e8 b8 6a ef fd 90 <0f> 0b 90 e9 1f f9 ff ff e8 aa 6a ef fd 90 0f 0b 90 e9 47 f9 ff ff
RSP: 0018:ffffc9000d497860 EFLAGS: 00010287
RAX: ffffffff83d0a8d8 RBX: 0000000000028000 RCX: 0000000000100000
RDX: ffffc9000ea83000 RSI: 0000000000062177 RDI: 0000000000062178
RBP: ffff8880427a2280 R08: ffff888041940777 R09: 1ffff110083280ee
R10: dffffc0000000000 R11: ffffffff83d0a110 R12: ffff8880427a24f0
R13: dffffc0000000000 R14: ffff8880427a2628 R15: ffff888035518000
FS:  00007fece6bca6c0(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc0fc53000 CR3: 00000000435f3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 destroy_inode fs/inode.c:396 [inline]
 evict+0x7c2/0x9c0 fs/inode.c:834
 btrfs_relocate_block_group+0xb4a/0xc60 fs/btrfs/relocation.c:4026
 btrfs_relocate_chunk+0x12f/0x5c0 fs/btrfs/volumes.c:3451
 __btrfs_balance+0x1860/0x23f0 fs/btrfs/volumes.c:4227
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4604
 btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3577
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fece5d8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fece6bca038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fece5fe6090 RCX: 00007fece5d8efc9
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fece5e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fece5fe6128 R14: 00007fece5fe6090 R15: 00007ffc0fc52ca8
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

