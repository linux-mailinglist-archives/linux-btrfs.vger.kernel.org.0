Return-Path: <linux-btrfs+bounces-10726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFAA01873
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2025 08:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C481883A74
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2025 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66412FB1B;
	Sun,  5 Jan 2025 07:36:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C170A926
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Jan 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736062586; cv=none; b=kHyaAaeb/Nudw9zZPkEEzAGuYM1O6zvqndLaXmuMl4HcV7Ki+3phZIKMVwgAE7x2YIpChPGcXuoL5r/XEtTRShuh7MTVj7hqDoir22Ppl+Fyr+IjFlgYigQfhTqMWWmuI7KbmRfNK6nUnCTWwvZ0GdR51nW+GP677lawfLNXB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736062586; c=relaxed/simple;
	bh=NM1sdOj/44IUhyLQUanp1qm93wF6vp3UWsy1VBIJHIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OAoldpnkF04bylHWuKpwfA+Cearc28seLKzUgleRzxdP/XZrhooFjXDd+th0rjiUgltuYYvoqR6K0FJ4cYyC0sg2l65uIQQy/bOhDVp+vNhh9WeT0bz8XZXqiA9LvBMYoPH5KvfMSgJL0t0ogJ7Lhbjr7x92/V2mXHSZzgmgtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so269332515ab.1
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jan 2025 23:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736062584; x=1736667384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZNJj77yzyB7wqYPstMp6IwBnXZLPvNLGifmvsLZsRY=;
        b=ETW27kAOgIkZbeJYtcOW2sNnypjqWeryaeSGOq6pX3OZEBhkRaygRBcSBPCpRHImRQ
         7a/p/U7vK8oannQ0Eu87Adx7HHYxNrPx/Sqge54+ZSuc4letK6r+RukNAsaMrP+wpGGr
         UHK6JGsHqOKIBf1y5G8CecUoFcyw//UeFELypyteG2mQQI91YPDexorot9IgYBgJmYjh
         NFsVy0grgbbXUOVqzWEWOaCWuQanw1KsJmUL+04IDnxOd+dLx3fVy0LPyrbe8wrrDmSz
         nOnxjZTABj6Tgeeg2iFKCQc9hSlOxcgtxB4A4I3gIgJ2CajQzLcV3F4VySIhRsA0hakj
         vndw==
X-Forwarded-Encrypted: i=1; AJvYcCX3vF8ap8ySwK0XkccGqimdiT+c2eHSxKPdPArD7yeqKNxr+5URVJ7wywVURGvJlw0h8JXl16ILKzfVEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+7Imx8waOito2idTbOHVr+EpFvVP0Ndm3ynKlmXfzqnEV0NA
	9U2U+fJ1xZ4NIaj/RjhcVOeVSHRVbzUvfhwTI4AtLwsM6XsMkiI6qh9cji8Q/ARcGzc7L83sTsA
	R+GuX/WDgD1/oN6O3t56+gmCnrf4Ol/YGiUGe2M08CCEnBRsinKNqSYU=
X-Google-Smtp-Source: AGHT+IHoJwwgGE4DUtOOVDdUqXe7u9TjqkS2rHDERcxH0hQMaisIdwwf4wo/+GKilHyiCnh4s/pKjqG2yklKuaICHFUAFqwTyuH7
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3c2d2681c55mr466715095ab.10.1736062584289; Sat, 04 Jan 2025
 23:36:24 -0800 (PST)
Date: Sat, 04 Jan 2025 23:36:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677a3678.050a0220.380ff0.000c.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_fileattr_set (2)
From: syzbot <syzbot+f0fd5fc4b1df37b555c2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c2fac4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=f0fd5fc4b1df37b555c2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5813aeeed683/disk-ccb98cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f3cc0826092/vmlinux-ccb98cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a0638b228fb/bzImage-ccb98cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0fd5fc4b1df37b555c2@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 6116 at fs/btrfs/ioctl.c:382 btrfs_fileattr_set+0xae6/0xb60 fs/btrfs/ioctl.c:382
Modules linked in:
CPU: 1 UID: 0 PID: 6116 Comm: syz.1.14 Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:btrfs_fileattr_set+0xae6/0xb60 fs/btrfs/ioctl.c:382
Code: 0f 8c d1 fc ff ff 48 8b 7c 24 10 e8 84 1a 3d fe e9 c2 fc ff ff e8 fa 3c d9 fd 90 48 c7 c7 c0 52 4c 8c 89 ee e8 6b e0 99 fd 90 <0f> 0b 90 90 e9 ca fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 84
RSP: 0018:ffffc900052bf810 EFLAGS: 00010246
RAX: 1c7144dfc1a76900 RBX: ffff888058517a68 RCX: 0000000000080000
RDX: ffffc9000dc1c000 RSI: 0000000000003a01 RDI: 0000000000003a02
RBP: 00000000ffffffe4 R08: ffffffff816019a2 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: 1ffff1100b0a2f59
R13: ffff888027cbc001 R14: 0000000000000000 R15: ffff888058517ac8
FS:  00007ff8aeef06c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff8aeeeff98 CR3: 000000007cbac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_fileattr_set+0x8ff/0xd50 fs/ioctl.c:696
 ioctl_setflags fs/ioctl.c:728 [inline]
 do_vfs_ioctl+0x2083/0x2e40 fs/ioctl.c:869
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8ae185d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff8aeef0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff8ae376080 RCX: 00007ff8ae185d29
RDX: 00000000200004c0 RSI: 0000000040086602 RDI: 0000000000000003
RBP: 00007ff8ae201b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff8ae376080 R15: 00007ffe81cfcfd8
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

