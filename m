Return-Path: <linux-btrfs+bounces-10633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDC9FA354
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2024 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A9B166E08
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2024 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F939FD9;
	Sun, 22 Dec 2024 02:20:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD922B9BF
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734834024; cv=none; b=hYRlYwcJERRe3Ggp+XnRg8HGRfQj/etmUYEYTukYVakidIIYOW2OZbLt1D1fZFvXiqyLkOymkY6zXGkEaPhbPk+9i8RzW75GXlFpxNj4xumpmtBWpLo33s9EIY5lkgVBPA4ZIE8sRE7BOG04ZjgGzcBYZ7N0+CXN63AyDGyV+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734834024; c=relaxed/simple;
	bh=r8k4bTdHigu/FqSak59kjLGqXq3rLhZNiDRVHRzRwTU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OGP8oeqMsFmP4BjQRt9BXV8I78yplT/ogdImYaoX6D0jvG2qwO0TyfW36msurMCBnzEMRo+I3YMe0ZtMTN3OenYzanAsrMP9bhv7su+p4yq0mdTjXm0GZOlPWAOQnhh25+uef0aqtNtceLlE03di9i/jIoVeOKsTo3b5lUs2iBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a815ab079cso62623605ab.0
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2024 18:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734834022; x=1735438822;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvkvbfEur0boQYWlGhvmhFQWmAba/EkpKp+2Tbwmi/8=;
        b=P8cuyxTg0NVcOBmoqe3YKPlBTOpNHbECgiK0JZq/h4yr0IrnTW6DYaSPcxbi9LcBea
         YCP+45EQ5WXKeixa4dJYbbDciJPdFsSVaaA3/Deemeh7ojiEZqPWBesP6HdHL38+MNh+
         Z4SLYQHgR2b+fpE6yiBXYkWnFBSiZyVTcjkx6amHW3jjbY6CvwRByJFjwLEfERjSCS+Q
         3VYbWuKY8xsZn0hSv5nt0h6Ds2APefO2K/bpOcZJqmcfNQgSOWIHn7WAY8bsrAjzrHsT
         5pqYWx3oae/Occ0SIqfs3SNjoLyELr5OTNZyUBaAj+goW5suEpPLEykzEb1g52emPD93
         7/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfRGlKNdjRTWEXQMYECi1XKUcDu+Zh4YxXeyI5UZZFGrw7EJblblkpWoXYEQ6hO8Oe1Z0LApzhbanrOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzna6kXOMsSAFXU1f6y0SLLSoYwXfm8ZWeVP4Yycp2zGDWPA3wx
	ciLu/EnExAWu1TyJhpX3qylX1tgDr4DXDkqzTCssVaSg12+pHAGMrk6xbLXKWZOcrDXTESPfV5u
	bB1t5Q6rDN3Pz66TwF6Jvtb2ULNy2lBRyRgSJBDgKawEgNUMOl3jqinQ=
X-Google-Smtp-Source: AGHT+IElj9QaBIIS5aVknYTyNkOzH8mI9EXqUkdmzQBlkmqCCKK/52sH/oF/KRLHJaBJfY7nB1hXB7LzwFQvXgkoovg9hJrx9eVK
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c42:b0:3a7:87f2:b00e with SMTP id
 e9e14a558f8ab-3c2d533f04dmr73683025ab.19.1734834022242; Sat, 21 Dec 2024
 18:20:22 -0800 (PST)
Date: Sat, 21 Dec 2024 18:20:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67677766.050a0220.226966.0019.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_rename2
From: syzbot <syzbot+882cfd52ad141a668d9a@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59dbb9d81adf Merge tag 'xsa465+xsa466-6.13-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1755d730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=882cfd52ad141a668d9a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-59dbb9d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0cc89779297/vmlinux-59dbb9d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e6c895062cb/bzImage-59dbb9d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+882cfd52ad141a668d9a@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -2)
WARNING: CPU: 0 PID: 5321 at fs/btrfs/inode.c:8298 btrfs_rename fs/btrfs/inode.c:8298 [inline]
WARNING: CPU: 0 PID: 5321 at fs/btrfs/inode.c:8298 btrfs_rename2+0x2ac6/0x2b90 fs/btrfs/inode.c:8377
Modules linked in:
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc3-syzkaller-00026-g59dbb9d81adf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_rename fs/btrfs/inode.c:8298 [inline]
RIP: 0010:btrfs_rename2+0x2ac6/0x2b90 fs/btrfs/inode.c:8377
Code: ff ff 48 8d bc 24 d0 01 00 00 e8 75 81 46 fe e9 79 ec ff ff e8 eb 18 e0 fd 90 48 c7 c7 80 99 4b 8c 44 89 fe e8 9b bc a0 fd 90 <0f> 0b 90 90 e9 ee f9 ff ff e8 cc 18 e0 fd 90 48 c7 c7 80 99 4b 8c
RSP: 0018:ffffc9000d447680 EFLAGS: 00010246
RAX: b49777bc4d744c00 RBX: ffff888052f2c001 RCX: 0000000000100000
RDX: ffffc9000eddb000 RSI: 000000000000186c RDI: 000000000000186d
RBP: ffffc9000d447a90 R08: ffffffff81601a42 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: ffff8880448959a0
R13: 1ffff11008912b34 R14: 0000000000000000 R15: 00000000fffffffe
FS:  00007f28b26106c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f28b260ffe0 CR3: 000000003fe4c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_rename+0xbdb/0xf00 fs/namei.c:5067
 do_renameat2+0xd94/0x13f0 fs/namei.c:5224
 __do_sys_rename fs/namei.c:5271 [inline]
 __se_sys_rename fs/namei.c:5269 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f28b1785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f28b2610038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f28b1976080 RCX: 00007f28b1785d29
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000020000080
RBP: 00007f28b1801a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f28b1976080 R15: 00007ffcc9517458
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

