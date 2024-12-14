Return-Path: <linux-btrfs+bounces-10372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5F9F1FB5
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 16:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC131635DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D82199924;
	Sat, 14 Dec 2024 15:27:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0519580F
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734190046; cv=none; b=hNn6jti+8fK5upqld3AI+mrDtm321/Tjbw2Yg4sFjBz3RGZQxG+mM2ZTaVu7CyZ/yJ6/QuWAqFNttAdOo004r7cstD5ahUecbvM++SfdCWBX8uQ59qzGNeJqLxC71NC3nEe8Kj0I2dIqS/qch1ONvGTWrEnxyor08AlLveD8/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734190046; c=relaxed/simple;
	bh=T8hGVdCjuGnEszO5pJUdPMr8VJwD+RqgbFW5CoqY5lU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fovrLVZk2+j0J8ZzA5ZL2oL2asAIkVJ9zun10D+3rvEfseim1bMnrj0AofCPGUGoqrwy1nJRvpl5yFaSQNW8Av/MiT308ATjEZVddH8+6RlwelZ6u3c3fJSAHGnvECQUzozuqJT8/bsulcLht74DK60z5P+a9/J04O+p7xWcjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ae31bb8ee3so50537225ab.3
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 07:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734190043; x=1734794843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycb5ZpUl4UbAv/nk5ghNoC0eQYnwnxw0wKOIOVyb+a8=;
        b=iGpP+r024Xgby/JofXqylKdhPY1SOi1IwBJkxRsVm6bCPqwRwKDB2auDlbh/UShAK2
         380Otdma8DIveLSnLGE6+mZhxB+k+BaPteV08Vtj2OMzbkxyYLmbY0pTm0BJFbJiUR6T
         j8zyAjSvibTlNhk4if09eIdsSHVSZyke7IDTF5YRpI+6Rt6b/042TGwv6RDbsouppfx3
         QojMGWWdOu/VG/ydQs5ZZj6LhJUGUeiBLHj5YMhtw0jI19L74ljlCCXXsTRmx7XrKJKI
         xcS3YnWHVYYJtcZMtr71yOa5S+YJmOJV3qCckHb1Nt9A7jR07iQCOvUY1w2nFVD0JLNw
         CU0A==
X-Forwarded-Encrypted: i=1; AJvYcCXTwyfHvxsvU9TgiijIN8jCZux69ZDhYXbJxHlwSklwjoWY4bQH95DdYB4FG1+nIIplJhF64JjUFbjC0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfGKwZBf/Wn/jyWZ4RtqcMHtGKUmHC6utJIkqSM63a2SB4Lhx
	UXSt+a1m6wNoHmCP08IqH6Pb2eYOH5YhyMbfBcHyKJ6RyBhDDkz5Bbvmneu/7oElxVkZYNyMblv
	6SoF4l5WYarVEVm4hkIElaagjSv8BKDUDDe9Lpt/Dj/EV9+lnd1VTFXE=
X-Google-Smtp-Source: AGHT+IELiSkkq0oSatwQK2on/8SqXLLRzEsbHajvH4iAxJHZquN4OGO9Ds+WNxr0j4r5ESrZ4f8lUa77q1GjMopehJ3wGGjbrHgo
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:3a7:e147:812f with SMTP id
 e9e14a558f8ab-3afee3c5b42mr84750215ab.12.1734190043636; Sat, 14 Dec 2024
 07:27:23 -0800 (PST)
Date: Sat, 14 Dec 2024 07:27:23 -0800
In-Reply-To: <6714a705.050a0220.1e4b4d.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675da3db.050a0220.37aaf.00cc.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in put_pwq_unlocked (2)
From: syzbot <syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com>
To: cem@kernel.org, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a446e965a188 Merge tag '6.13-rc2-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11108344580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=aa930d41d2f32904c5da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15108344580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44e300b681ee/disk-a446e965.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a7c7a152318/vmlinux-a446e965.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97df5473ab29/bzImage-a446e965.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/29ab3e8f6ac5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com

bcachefs (da441363-bb6a-4ab9-999b-c1f40db4fee2): shutdown complete
Oops: general protection fault, probably for non-canonical address 0xf11008476f002002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x8880623b78010010-0x8880623b78010017]
CPU: 1 UID: 0 PID: 6159 Comm: syz.1.34 Not tainted 6.13.0-rc2-syzkaller-00292-ga446e965a188 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5089
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 1b d0 9d 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 88 95 88 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc900032b7010 EFLAGS: 00010803
RAX: 11100c476f002002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 8880623b78010017
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203079f R12: ffff88802ea1da00
R13: 0000000000000000 R14: 0000000000000000 R15: 8880623b78010017
FS:  00007f150d2de6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f82dd601000 CR3: 0000000060034000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 put_pwq_unlocked+0x42/0x190 kernel/workqueue.c:1662
 destroy_workqueue+0x99d/0xc40 kernel/workqueue.c:5897
 __bch2_fs_free fs/bcachefs/super.c:592 [inline]
 bch2_fs_release+0x629/0x7d0 fs/bcachefs/super.c:611
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 bch2_fs_alloc fs/bcachefs/super.c:960 [inline]
 bch2_fs_open+0x1ebe/0x2f80 fs/bcachefs/super.c:2065
 bch2_fs_get_tree+0x738/0x1710 fs/bcachefs/fs.c:2157
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f150c5874ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f150d2dde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f150d2ddef0 RCX: 00007f150c5874ba
RDX: 0000000020000080 RSI: 0000000020000000 RDI: 00007f150d2ddeb0
RBP: 0000000020000080 R08: 00007f150d2ddef0 R09: 0000000000800000
R10: 0000000000800000 R11: 0000000000000246 R12: 0000000020000000
R13: 00007f150d2ddeb0 R14: 000000000000595e R15: 0000000020000480
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5089
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 1b d0 9d 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 88 95 88 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc900032b7010 EFLAGS: 00010803
RAX: 11100c476f002002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 8880623b78010017
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203079f R12: ffff88802ea1da00
R13: 0000000000000000 R14: 0000000000000000 R15: 8880623b78010017
FS:  00007f150d2de6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f82dd601000 CR3: 0000000060034000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 f8 16 	xor    %al,0x16f8850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d 1b d0 9d 0e 00 	cmpl   $0x0,0xe9dd01b(%rip)        # 0xe9dd030
  15:	0f 84 c8 13 00 00    	je     0x13e3
  1b:	89 54 24 60          	mov    %edx,0x60(%rsp)
  1f:	89 5c 24 38          	mov    %ebx,0x38(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 88 95 88 00       	call   0x8895c0
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

