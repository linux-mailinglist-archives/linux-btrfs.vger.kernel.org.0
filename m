Return-Path: <linux-btrfs+bounces-5415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1E8D847A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B214B21578
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8812E1C4;
	Mon,  3 Jun 2024 13:56:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0431E4A2
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422994; cv=none; b=d1wJtp69lJ2P1JEb9FBNGadQ65rp/PyGxcukxF+X7qDBFKg3smV06sJSs6O8F0lwa9SwAsocG69Ca58JruZhEiutqZn6CBmYbdxKgurlVP4Os1TXCEOKDMHm1v759p2TwATgnsHwHWVUWLvEc9NSotj1etJklzM/jmdjucyBNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422994; c=relaxed/simple;
	bh=F9tchKgJ+0Tly6PvSUL6opwzK6X+g/0Pfpb1+P3qmbY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eBT+596vux9CbLGCYpzz4d28SFWC1XHAZUYW7M5GN7UHfrmFkC2Tl/7db/iUiyHKegZp6gKvtbN1Q67FVSZRTHMMAFKi4ykypRJluLv083Tq0viKZsLBazFsvOsSkFuCg7gkqWrTXAyVT27KEMhpkq12IE2Os0PoyE0owRcTf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e8dc9db8deso301304139f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 06:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422991; x=1718027791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4vlyFUctzrtFKgPihrdjpd13Jl9JMv1iQ2ZzCeOYTQ=;
        b=tmgG2lCMYBCnas8uowJdppEbY1QIcnZdspE3RK5MM80KR9hzOsWlPUiAMKLj5BRI4/
         sxVsC6HnHF53bbTqNzfMukm68C9HsCgo43oWmcTyhv7TTXe4mKQz3wrst2QBl/F38Phu
         NhK8af4tsqERAviDLURx7JVLThofKMZHU6kYnjZdMbYPZe6hTDFM1O1oBD/Uu+MlizUy
         orDsZtOBPBvmdIGgcM6HbS4wsKg0LfhGj9toAugbd55Ti5Y2AE7F2Wl63MUPNe3QcUxC
         afrM5n9O15WKg0/n6bLpE4HEhV8Qy467cfKQTZ7GlMzdlGe5yqJy326IMAGiq+lRZ/6S
         jEAg==
X-Forwarded-Encrypted: i=1; AJvYcCUBijnWFcOmNvzH2gvXz4tBB+L5TSMMmeYBzXhCfIddaNiQUwvpoxM0HT0kUIT3zw332NJ4uu9nPa0hYi5RIi/2ytpLTyNJIX8nwMI=
X-Gm-Message-State: AOJu0YwQkDID4qQeC+K4Gg7uXFGv6t3SqN5AL1yY7/ZUOGLGP9PAZfpJ
	r2sWe46dwhO0kXPKxXfubwZJitHRs7/4Jpgf5ySskSvthJtl4r1HRljlLk5ksWdtMkgnhpfUtdU
	FxL6E1fyZXXiYfmgdsnLxu1DxOj8LjxHDzrgLHf11ZbEc3unu0pGKD8A=
X-Google-Smtp-Source: AGHT+IFzBWhiGwssVfD9HFF2BBQ2iVB5ycLjjzU4CStCPzUU97rq9FmFriD52EB6XT3HrJTgQa7oL6pqEGlz5tsEHr2+Nc/gwlbp
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c8:b0:4b5:dbcb:9bff with SMTP id
 8926c6da1cb9f-4b5dbcb9dadmr110626173.0.1717422991679; Mon, 03 Jun 2024
 06:56:31 -0700 (PDT)
Date: Mon, 03 Jun 2024 06:56:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059334d0619fcb362@google.com>
Subject: [syzbot] [btrfs?] general protection fault in apply_wqattrs_cleanup
From: syzbot <syzbot+1b5f11df288ca3853de9@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f38fa61af7 Linux 6.10-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127bdaba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7
dashboard link: https://syzkaller.appspot.com/bug?extid=1b5f11df288ca3853de9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f38fa6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af6a0b581dee/vmlinux-c3f38fa6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47864da8bd74/bzImage-c3f38fa6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b5f11df288ca3853de9@syzkaller.appspotmail.com

BTRFS info (device loop3): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device loop3): using free-space-tree
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 PID: 6690 Comm: syz-executor.3 Not tainted 6.10.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:put_pwq_unlocked kernel/workqueue.c:1662 [inline]
RIP: 0010:put_pwq_unlocked kernel/workqueue.c:1655 [inline]
RIP: 0010:apply_wqattrs_cleanup.part.0+0xbc/0x2b0 kernel/workqueue.c:5223
Code: dd 28 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 8e 01 00 00 48 8b 5c dd 28 48 85 db 74 41 e8 4b ce 35 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 92 01 00 00 48 8b 3b e8 21 70 87 09 48 89 df
RSP: 0018:ffffc900078ef740 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90003133000
RDX: 0000000000040000 RSI: ffffffff8158b125 RDI: ffff8880002d1128
RBP: ffff8880002d1100 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: fffffbfff1a92c7d R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c300000(0063) knlGS:00000000f5ef9b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7fe3ea0 CR3: 0000000025356000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 apply_wqattrs_cleanup kernel/workqueue.c:5222 [inline]
 apply_workqueue_attrs_locked+0x9e/0xe0 kernel/workqueue.c:5344
 apply_workqueue_attrs kernel/workqueue.c:5374 [inline]
 alloc_and_link_pwqs kernel/workqueue.c:5502 [inline]
 alloc_workqueue+0x1496/0x1ca0 kernel/workqueue.c:5717
 btrfs_alloc_workqueue+0x21c/0x510 fs/btrfs/async-thread.c:112
 btrfs_init_workqueues fs/btrfs/disk-io.c:2015 [inline]
 open_ctree+0x165d/0x52e0 fs/btrfs/disk-io.c:3362
 btrfs_fill_super fs/btrfs/super.c:946 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1863 [inline]
 btrfs_get_tree+0x11e9/0x1b90 fs/btrfs/super.c:2089
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 fc_mount+0x16/0xc0 fs/namespace.c:1125
 btrfs_get_tree_subvol fs/btrfs/super.c:2052 [inline]
 btrfs_get_tree+0xa53/0x1b90 fs/btrfs/super.c:2090
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7307579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ef9400 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5ef9460 RCX: 0000000020005140
RDX: 0000000020000100 RSI: 0000000000000816 RDI: 00000000f5ef94a0
RBP: 00000000f5ef9460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:put_pwq_unlocked kernel/workqueue.c:1662 [inline]
RIP: 0010:put_pwq_unlocked kernel/workqueue.c:1655 [inline]
RIP: 0010:apply_wqattrs_cleanup.part.0+0xbc/0x2b0 kernel/workqueue.c:5223
Code: dd 28 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 8e 01 00 00 48 8b 5c dd 28 48 85 db 74 41 e8 4b ce 35 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 92 01 00 00 48 8b 3b e8 21 70 87 09 48 89 df
RSP: 0018:ffffc900078ef740 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90003133000
RDX: 0000000000040000 RSI: ffffffff8158b125 RDI: ffff8880002d1128
RBP: ffff8880002d1100 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: fffffbfff1a92c7d R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c200000(0063) knlGS:00000000f5ef9b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f74ba0c4 CR3: 0000000025356000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	dd 28                	(bad)  (%rax)
   2:	48 89 f8             	mov    %rdi,%rax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   e:	0f 85 8e 01 00 00    	jne    0x1a2
  14:	48 8b 5c dd 28       	mov    0x28(%rbp,%rbx,8),%rbx
  19:	48 85 db             	test   %rbx,%rbx
  1c:	74 41                	je     0x5f
  1e:	e8 4b ce 35 00       	call   0x35ce6e
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 92 01 00 00    	jne    0x1c7
  35:	48 8b 3b             	mov    (%rbx),%rdi
  38:	e8 21 70 87 09       	call   0x987705e
  3d:	48 89 df             	mov    %rbx,%rdi


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

