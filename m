Return-Path: <linux-btrfs+bounces-6972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A857494705B
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3072D2810A6
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9789C136320;
	Sun,  4 Aug 2024 19:33:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371D947E
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722800013; cv=none; b=U+Tq9I57G5dmiFSUcPQWUb94ruebWlJurjHRpowp9FfVnUYJ//DiIApJ7yp3jJFyTSjxceZnqijpJVlGIl9+oVnke2PcnCoZufot9bQ+EX3oUD4vkbPlCFXSP+Vio6Ika+1R+FSSntAbwHnplyllVDMkUnMmKDa0G2uP0Nz1Tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722800013; c=relaxed/simple;
	bh=Ege54MFq1DMrJcWiCDMbJ2HcM2ypStFyil/0AKIiHkg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=geYCef37+48fRNpM++KsePiBjVnYiVjFVj/r4/N1CZPG6N/k1erkJNPfSi2bDj5HTBwRDsPAO1OtfveHaCjkaAWbyaA1Ba5io7zPOobcDuEGCw0PnHre0Zcswo6tI5c+34+ny8PC1kDseHMZLp2HlOnFubU9+7HxEFQ2xH3dEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso12277435ab.0
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Aug 2024 12:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722800010; x=1723404810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73bjFrgcVnbFT6bvTdW7jjEosldFBKTQFoMvFajDuwI=;
        b=h/sEWblAZ5vIGumgvrRHAukFh96PzGr1I12Nys1OZvLHAmK6S6NIGHoQ97IqDKSh1h
         HcRXYShlrkG/TXyTy5R20RRsaAFnEvTa8gVO0MnTaaBRLZBcCsR9RjNbok52nTk1mPbd
         Ryf6cJPrSduhtRNetY+OKFFGQZIlPaaJpoD7QKqgsHRrAUY7AC54xVo9F0MbUHxJekSY
         /hHRl4VO0PJChtFk+uB3ZMY57e6TIO7r82UYE0U0Tb1hR92H8BRSxGT1E3D22XWzK6YI
         LoaSNYsr9JDA9PODku1/qY9WW7yJG7B65nKy0XDDeEfCN6hCGA9fZd8VTVLWqWMntyX/
         K0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMuTEXIBVzR5Wpvki3QfDalnAy6V/0R4HyJzaWJgczq+13gMv4b1teDoul2iHUrw8Fjst25ShzzvN/tyzdUr+yYFTJUjgyxl/TjM4=
X-Gm-Message-State: AOJu0YzFA6tAJtnI1uIN6boSX/i4SjfZzCZRI2z29mje0dTdcd7WlXaT
	mC0TZiRYlkA55gOpUR3Cwzl+hzGHdr+wFZHU1HbVPJ7cw7UH1RJULC2Em0l9Yo89rAia9dGU4TA
	702jXHbZV7r5IbIWPwWne5Pthd2QK01MHPRzPULjO0zQT0O+1K3weERU=
X-Google-Smtp-Source: AGHT+IEpmvVuM1dyybCZs19PSG3BgaBmUm0n42ONUF47VQ4nArKnGOTZj3Qrw1IGPV7u1PcBkBMonLeqdOsiozAsELfQ3R32+RI1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2198:b0:39a:e900:7e3e with SMTP id
 e9e14a558f8ab-39b1fc4c0d9mr8100465ab.3.1722800010057; Sun, 04 Aug 2024
 12:33:30 -0700 (PDT)
Date: Sun, 04 Aug 2024 12:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e7183061ee0a25f@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_run_defrag_inodes (2)
From: syzbot <syzbot+5833b186650f87c5b7c4@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e4fc196f5ba3 Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133acef9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=5833b186650f87c5b7c4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c4bed4c74b59/disk-e4fc196f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f90c5ef25b80/vmlinux-e4fc196f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a4dad9a7e8e/bzImage-e4fc196f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5833b186650f87c5b7c4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:1819!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 10710 Comm: btrfs-cleaner Not tainted 6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:iput+0x928/0x930 fs/inode.c:1819
Code: ff e9 a7 fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 45 fe ff ff 4c 89 f7 e8 33 aa e7 ff e9 38 fe ff ff e8 29 71 80 ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900041ffc50 EFLAGS: 00010293
RAX: ffffffff8212f547 RBX: 0000000000000040 RCX: ffff888023d05a00
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: ffff88805e4f48e0 R08: ffffffff8212ec80 R09: 1ffffffff202f495
R10: dffffc0000000000 R11: fffffbfff202f496 R12: ffff88805e4f49b0
R13: ffff88806c102028 R14: 0000000000000005 R15: ffff888068e60350
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c9b094108 CR3: 000000005d542000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __btrfs_run_defrag_inode fs/btrfs/defrag.c:281 [inline]
 btrfs_run_defrag_inodes+0xa80/0xdf0 fs/btrfs/defrag.c:327
 cleaner_kthread+0x28c/0x3d0 fs/btrfs/disk-io.c:1527
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x928/0x930 fs/inode.c:1819
Code: ff e9 a7 fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 45 fe ff ff 4c 89 f7 e8 33 aa e7 ff e9 38 fe ff ff e8 29 71 80 ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900041ffc50 EFLAGS: 00010293
RAX: ffffffff8212f547 RBX: 0000000000000040 RCX: ffff888023d05a00
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: ffff88805e4f48e0 R08: ffffffff8212ec80 R09: 1ffffffff202f495
R10: dffffc0000000000 R11: fffffbfff202f496 R12: ffff88805e4f49b0
R13: ffff88806c102028 R14: 0000000000000005 R15: ffff888068e60350
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c9b094108 CR3: 000000006b99e000 CR4: 0000000000350ef0


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

