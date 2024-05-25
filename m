Return-Path: <linux-btrfs+bounces-5289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3DE8CF012
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 May 2024 18:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEDC1F2180F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 May 2024 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E586120;
	Sat, 25 May 2024 16:18:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAF5A7A0
	for <linux-btrfs@vger.kernel.org>; Sat, 25 May 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653909; cv=none; b=q3zoeksrrP498fZAfSR84aA8+i2QojfkmuI42UuPHRr21YEhF9ldqsTS793H2pC4WYRQcS530SAtHdZjAt/nR8OC9zWloUoSUYV0W/PN3sfzbTbT2jpFATQ/VuzZb3zUz+vo/IYRlANCICY4I71vdkrCWxpKtuC6k/i9yDGiu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653909; c=relaxed/simple;
	bh=4OCnw8Bvf07pSAyfkhIFFHLt7ZShqpSiEV3Jcfq2As0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aVVzxEwdN58bAlW+U0sVmjEJZeHEbeF6BB7Z1jPNoORbT3j8tjiNJL25IxYnJRMSb9phIoTCUb3O60F+ll+5ceidHh2gqVSxBxB//hXbptFzZ9IkbagSS+v+SWB66vIxzHsYtjY7iRFy5Q8dG2ShItEPSmVp5JTLMMGnGGVizbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b3c496fso18512485ab.2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 May 2024 09:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716653907; x=1717258707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGhclLxPRc2hmnd8jh+QXBmXgT9UCucDU/l2yKi8jNo=;
        b=fMBbi8XXoyVSHlB70WUjjJLhcp06IuwVAIfLlNDxI3z51Uu2SScyAYfLFK8sXpCNIO
         eC/Ycm9tFRF7lAn0WthPBmMAhuiEe6mnJff3RLzsCFBb1yLA+57qrtazHlb3y7PcWiyk
         7qVwb8Fdyjn+CnTe49aO+R8ApPeguDTde27pCIMJXmNx7/6LQgniJCJ6mTqidXKtBAQJ
         0bgWLVJ0cP5Qi7YeoDC59quqAeajSQc8cX9tSDmvGMf6GQxYr+lJu0hchHyzSxadT6yy
         pCeWwMdyxzL1X48oV8My+NAoDAaM8vzzOKP5XxoBpnDwLG5wXJmvPcDOyvC2kgceDvmM
         ygSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzL3fAeA5C1fj0lUNh+knOF17vx7BrPy5AMeCzDpSvhpNsHeF7o9LdPYutMRcto9mxAHax9Sl1U8+wQ5b+NtEdN5r1ErWfn3mTTe8=
X-Gm-Message-State: AOJu0YwiA17ylj1l0CjP2nNW/sq6p0bX38bU4mkoiOpzBTCvYCcgsdpK
	v4WKhHl3VMDQisyWtFWdJQKDhlVZYeCocUXrsdR2/HzT5xGjJCuC/PeW4UFqQaaGi07+dkjAotG
	5OvZmtW/EmsXKSLEaR3Oi8hmosFYREHDrCVO/zB9BfHEgU7FYNBHVduM=
X-Google-Smtp-Source: AGHT+IHTkdnIbe6Vtip3C9C5b4fJl7805ZRSyuXdMrXv9OPekfioMmAS5QlAiDVRHCbvMlwzhPUbGXHQvJlVjhYU4aGqAFRHfVTb
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:36d:cccb:6842 with SMTP id
 e9e14a558f8ab-3737b1f362bmr3798785ab.0.1716653907082; Sat, 25 May 2024
 09:18:27 -0700 (PDT)
Date: Sat, 25 May 2024 09:18:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000558cea061949a2d6@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_simple_end_io
From: syzbot <syzbot+8cfa88c4efc731f03e7e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bfdae8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620
dashboard link: https://syzkaller.appspot.com/bug?extid=8cfa88c4efc731f03e7e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65ffe3ca9bb3/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354ef77a71b6/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8cfa88c4efc731f03e7e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe01ffbf11002a963: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00ffff8880154b18-0x00ffff8880154b1f]
CPU: 1 PID: 29 Comm: ksoftirqd/1 Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 93 86 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 e0 ed e2 92 0f 84 98 f2
RSP: 0018:ffffc9000056f938 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 001ffff11002a963 RSI: ffff8880163d0000 RDI: 00ffff8880154b18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe2add7 R11: 0000000000000000 R12: 00ffff8880154b18
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f74a20c4 CR3: 000000002ba66000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x39e/0x1020 kernel/workqueue.c:2319
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2410
 queue_work include/linux/workqueue.h:621 [inline]
 btrfs_simple_end_io+0x2d5/0x390 fs/btrfs/bio.c:379
 bio_endio+0x644/0x760 block/bio.c:1636
 blk_update_request+0x704/0x1850 block/blk-mq.c:929
 blk_mq_end_request+0x5b/0x620 block/blk-mq.c:1057
 lo_complete_rq+0x232/0x2f0 drivers/block/loop.c:366
 blk_complete_reqs+0xae/0xf0 block/blk-mq.c:1132
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:928 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:920
 smpboot_thread_fn+0x661/0xa10 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 93 86 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 e0 ed e2 92 0f 84 98 f2
RSP: 0018:ffffc9000056f938 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 001ffff11002a963 RSI: ffff8880163d0000 RDI: 00ffff8880154b18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe2add7 R11: 0000000000000000 R12: 00ffff8880154b18
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f74a20c4 CR3: 000000002ba66000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	11 00                	adc    %eax,(%rax)
   2:	00 39                	add    %bh,(%rcx)
   4:	05 93 86 1f 12       	add    $0x121f8693,%eax
   9:	0f 82 be 05 00 00    	jb     0x5cd
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	e9 e4 00 00 00       	jmp    0xfd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 82 1f 00 00    	jne    0x1fb6
  34:	49 81 3c 24 e0 ed e2 	cmpq   $0xffffffff92e2ede0,(%r12)
  3b:	92
  3c:	0f                   	.byte 0xf
  3d:	84                   	.byte 0x84
  3e:	98                   	cwtl
  3f:	f2                   	repnz


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

