Return-Path: <linux-btrfs+bounces-17271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60082BAA7DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 21:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBD6192322E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B8248880;
	Mon, 29 Sep 2025 19:45:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362D2BB17
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175141; cv=none; b=QGmTbxu9cYRwLEnACQS7J+psw+w+w0ZqAhQAY+caa0wG7N6v4fwv7bg1HV4w9lgPT1esTUnhnLLiM1zB0lDjRYz7Q4SE6vhtvz7CyKHLNCyWhyBHS9MSF8grpeqkzlhasBYplSKyH2BwczNzoYsJ0oWxpQYyX7KLvbHD63dH6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175141; c=relaxed/simple;
	bh=rh8mdSxxnnUT4tM+QuXBLe2s00ZgIvJ4Y/HdN48sjkI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JYpKCQ/4tx95abPLEaU1GV9o4WUdY4HMh01KmNwfQGLxGbUyBDPMW0V67JaQcldqKk/u2repwvg3r3HordMOLNO1zFa4rAM70QV2vkfIBkQULIQ5pA1bub+UwmfUP1/5NitCqGVUpiNF/1qpOpfstIOYVdDdCfxszPqxFNREaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42594db9398so138922465ab.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 12:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175139; x=1759779939;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ah5UqsEu7QYVNBGFFIr0yyMEFyMgg2KH6V06KOx2+Q4=;
        b=jtuYidIMqP+Z98bLKY0LV/YaI6bc7JrGaom0n6CZy2KXpo32IWvPJMzSwoEHyweAAM
         631u4nxUAAoiu+WySskFyigSQU9TVzscqciv1BsczkEZEpjlbGmrmOMmnXBCDFkcxd9f
         eUo2KrIkbI85VyYeaATXQgZZhTHgxh23Ya3gam5Ch3HUnm+tulrBscRpbMIlSEv7frK9
         raj/yPn5W4EEt+bUt+3SFAfIr71t/Lr9LqwY8VfhMUwpHxzhdoSigOdfpnh4eNYObzjs
         olDHZSOQZ1tBlpqHoeE/ADN7NRjweBwSDEcxI4FlLrjROww7yy96gMP1IXBsVjBrS+fL
         TjPA==
X-Forwarded-Encrypted: i=1; AJvYcCVGTbhQotha8LkO8rH73iOSCOx+y4eCJz+YypDPyt06YEfVpduXJbyVEK7BznjY944Q+PzVueabC/j9Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3Gvv7lbTHGUR7XskHc9NTQN7itBcc/YgJLQHy7oJ+00PSb6k
	Ts3xT1n0Q5Tz++ySNkOh0LWHuvokifm1CWGbMPvEKDuEMzHI5+Yr9/xTrS5R/AU2eTabV9nJrGs
	JacXEn+dDqoBLQ76lUqDC0GQ1Z9QDyJowczl9UmXVsLNtAGcbRl7i17QfPVU=
X-Google-Smtp-Source: AGHT+IHbivRlxcX7G1PJ+Fm7HA0yd/GUNrpPg4qrR2SYCEvnqRrG9exjoZ2veGSpzgzHyQ0VqjTFLMzNW9gB9LXdOu/fOBJgJsTR
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc5:b0:425:9206:b4ea with SMTP id
 e9e14a558f8ab-425955ed698mr305103095ab.4.1759175138930; Mon, 29 Sep 2025
 12:45:38 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:45:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dae1e2.050a0220.1696c6.001f.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in scrub_stripe_get_kaddr
From: syzbot <syzbot+bde59221318c592e6346@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    262858079afd Add linux-next specific files for 20250926
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1562cae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6117d7eea7e1f3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=bde59221318c592e6346
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137abf12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1277f142580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/818c8ba6ac53/disk-26285807.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da143e1d7f10/vmlinux-26285807.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b73ae95dc148/bzImage-26285807.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/27e0b3290872/mount_1.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1477f142580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bde59221318c592e6346@syzkaller.appspotmail.com

BTRFS info (device loop0): force clearing of disk cache
BTRFS info (device loop0): enabling auto defrag
BTRFS info (device loop0): max_inline set to 0
BTRFS info (device loop0): scrub: started on devid 1
assertion failed: !folio_test_partial_kmap(folio) :: 0, in fs/btrfs/scrub.c:697
------------[ cut here ]------------
kernel BUG at fs/btrfs/scrub.c:697!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6077 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:scrub_stripe_get_kaddr+0x1bb/0x1c0 fs/btrfs/scrub.c:697
Code: 0f 0b e8 b8 14 db fd 48 c7 c7 60 8d ef 8b 48 c7 c6 a0 9f ef 8b 31 d2 48 c7 c1 20 8e ef 8b 41 b8 b9 02 00 00 e8 86 58 42 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc9000354f0d0 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff88805bfa0010 RCX: f481606445f80d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 000000000000000c R08: ffffc9000354ede7 R09: 1ffff920006a9dbc
R10: dffffc0000000000 R11: fffff520006a9dbd R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88805bfa0010 R15: 000000000000000c
FS:  000055556411a500(0000) GS:ffff8881259fc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f34bfdf2b60 CR3: 000000007537c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 scrub_bio_add_sector fs/btrfs/scrub.c:932 [inline]
 scrub_submit_initial_read+0xf21/0x1120 fs/btrfs/scrub.c:1897
 submit_initial_group_read+0x423/0x5b0 fs/btrfs/scrub.c:1952
 flush_scrub_stripes+0x18f/0x1150 fs/btrfs/scrub.c:1973
 scrub_stripe+0xbea/0x2a30 fs/btrfs/scrub.c:2516
 scrub_chunk+0x2a3/0x430 fs/btrfs/scrub.c:2575
 scrub_enumerate_chunks+0xa70/0x1350 fs/btrfs/scrub.c:2839
 btrfs_scrub_dev+0x6e7/0x10e0 fs/btrfs/scrub.c:3153
 btrfs_ioctl_scrub+0x249/0x4b0 fs/btrfs/ioctl.c:3163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f5d78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef70163e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2f5d9e5fa0 RCX: 00007f2f5d78eec9
RDX: 0000200000000000 RSI: 00000000c400941b RDI: 0000000000000004
RBP: 00007f2f5d811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f5d9e5fa0 R14: 00007f2f5d9e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:scrub_stripe_get_kaddr+0x1bb/0x1c0 fs/btrfs/scrub.c:697
Code: 0f 0b e8 b8 14 db fd 48 c7 c7 60 8d ef 8b 48 c7 c6 a0 9f ef 8b 31 d2 48 c7 c1 20 8e ef 8b 41 b8 b9 02 00 00 e8 86 58 42 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc9000354f0d0 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff88805bfa0010 RCX: f481606445f80d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 000000000000000c R08: ffffc9000354ede7 R09: 1ffff920006a9dbc
R10: dffffc0000000000 R11: fffff520006a9dbd R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88805bfa0010 R15: 000000000000000c
FS:  000055556411a500(0000) GS:ffff888125afc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556796dbd950 CR3: 000000007537c000 CR4: 00000000003526f0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

