Return-Path: <linux-btrfs+bounces-10600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8D9F73BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 05:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA96165BC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422822163BD;
	Thu, 19 Dec 2024 04:39:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5188632A
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734583168; cv=none; b=AWYj1UIBtxkc7Ldah9RXdaPaEohgl0YvykLMs7kkS96dpKtGt3mKgHlFSDCnJ6b3VdVh0G6J7BHIbG+9bXQqZVwIp3qzOkuTM9FuXbKEBkp7CNk4shNeU6ZLGB9RSBDadJTpUfxUH2Hg5gSCT4Sx4ZXlPZmUhi1oLxaWpRFLZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734583168; c=relaxed/simple;
	bh=bTABqYDCcIxbulGqsstULU/50d0AagCvi2ivv7Y0Cl0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TXQub6ThqLVJg9+2IAd9hsCvJtZiPkdzB5Z0/vTr7qoVS9qAANoalxK82JSgAPydTRD0qDQsWntjkHV4kKsRCVeMcsVqCDrY5/1lKVKl4nOm1wktx4dPHrz8ZUA0NxHBgeP+kI640crmjD6OxAbdeK/qhq9RAP8pqFm6jm8WJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so3207015ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734583166; x=1735187966;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdFDWRMHgTOGVYxfZF/dtH18mgv8HOgeVr8Ds1MAEH0=;
        b=stAYDE3EHRfeP+i52ywYtpL9d0fdHgOIdGJXuNCQdSBH+mHrX6meMCPREUNneoxtEY
         3JS5g5So2B2C7Z00fpqYYQmr/eKYru/R4+wXF4AMu2sTWUecfxFzObc9NmecyaL87vCx
         fLumzuoX1oSPLlf3x5fdAmBlEQ9wtEKMqrA21/xMDisCgB6uF0W5eksMCmXkQ+4lvvZb
         +MEB0bOCLQKKF4Tgsk7B7E3/Lxfm4vHJOaVooKSlfj4xo8yPLwFx1qMUK6RBQcNSdaZD
         zLnyomCD5ljDiRE25GLXotDIKq6szUeq/pOvgDTLnfWNAg38yrIvGYaQXRHUQ0ZHoJw6
         SQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVXOqtQ4qF7h2EVP2Oyk6csy9+vOFG6S+GT2myawfVJoIF0vgDF+B8OuLj9zhbvLodvGcCue+IDgMnUgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PTU+QUeihjXGQyw1ExhWd/d24AXJLEHgzXXeWv+x6inmRi43
	o2CpQm+Hq3YtssbrljNvj02niq0mfbm3PzZEALxuHmQqVTBDZA1Z4ylDHoK+4wtig0kYh2Dn51G
	8wSsLP4oG/YKbGcaz6dW7PxNGDt/umCh8VRNt2LZ0mUjBVEXCq9LPejw=
X-Google-Smtp-Source: AGHT+IHUt4CChzG8GMsKEM2qJdjxmj9o7rlIXWHDrToydBZ1OcHzbEQxl61LWf+eYCt/SeYkYb1elvaXQoAl4xSw4UWPI2wM42u2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d47:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3c015056945mr18379415ab.24.1734583166086; Wed, 18 Dec 2024
 20:39:26 -0800 (PST)
Date: Wed, 18 Dec 2024 20:39:26 -0800
In-Reply-To: <6714a705.050a0220.1e4b4d.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6763a37e.050a0220.15da49.0005.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in put_pwq_unlocked (2)
From: syzbot <syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com>
To: cem@kernel.org, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    eabcdba3ad40 Merge tag 'for-6.13-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15adb730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=aa930d41d2f32904c5da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc4cf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12faef44580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a4dff87674a/disk-eabcdba3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/266bc2b7ced3/vmlinux-eabcdba3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4bcd9be832/bzImage-eabcdba3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/90ce8b925e79/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xf11024afb8802002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x8881457dc4010010-0x8881457dc4010017]
CPU: 1 UID: 0 PID: 5817 Comm: syz-executor163 Not tainted 6.13.0-rc3-syzkaller-00073-geabcdba3ad40 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5089
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d cb ce 9d 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 38 93 88 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003a87950 EFLAGS: 00010803
RAX: 111028afb8802002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 8881457dc4010017
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff2030a27 R12: ffff888030045a00
R13: 0000000000000000 R14: 0000000000000000 R15: 8881457dc4010017
FS:  00005555749e8480(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f624dfff000 CR3: 000000007761c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 put_pwq_unlocked+0x42/0x190 kernel/workqueue.c:1662
 destroy_workqueue+0x99d/0xc40 kernel/workqueue.c:5897
 __bch2_fs_free fs/bcachefs/super.c:596 [inline]
 bch2_fs_release+0x69d/0x7d0 fs/bcachefs/super.c:611
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62555f9517
Code: 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe0e922dc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f62555f9517
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe0e922e80
RBP: 00007ffe0e922e80 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffe0e923f40
R13: 00005555749e97c0 R14: 00007ffe0e923f80 R15: 0000000000000008
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5089
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d cb ce 9d 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 38 93 88 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003a87950 EFLAGS: 00010803
RAX: 111028afb8802002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 8881457dc4010017
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff2030a27 R12: ffff888030045a00
R13: 0000000000000000 R14: 0000000000000000 R15: 8881457dc4010017
FS:  00005555749e8480(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f624dfff000 CR3: 000000007761c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 f8 16 	xor    %al,0x16f8850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d cb ce 9d 0e 00 	cmpl   $0x0,0xe9dcecb(%rip)        # 0xe9dcee0
  15:	0f 84 c8 13 00 00    	je     0x13e3
  1b:	89 54 24 60          	mov    %edx,0x60(%rsp)
  1f:	89 5c 24 38          	mov    %ebx,0x38(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 38 93 88 00       	call   0x889370
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

