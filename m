Return-Path: <linux-btrfs+bounces-19672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993ACB7517
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 23:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5EE3012DD9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DE25785D;
	Thu, 11 Dec 2025 22:50:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AD3B8D64
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765493438; cv=none; b=RCYTdB6wjXt2p6VTrJR3KBe/ImQ+WjFpeJapr2VPgnH4LL0Dakd0779rA8f4ulDPurBLBYqyhzGVVAlm+XhXBvZdVVxVuHwX5+QBlHoeF4f6J0H32Bk57m5Jrf8GTncz6GRbkglbwQZ05R8kUiqJy4iZkzqw8lhaORykEk1HRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765493438; c=relaxed/simple;
	bh=XCp10h3ZcJDg6G5ldXnrmRluMvdtUJYqq8Q7wT93nhc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OAHLGAU2KDUbQ6Rf8yxfVFu9mXyiq/ZxmKIZivJEzy/Qt796H1bxGzrMBDiJj7xx3914Ap/sjla07/cH4vQ36nYBNXeRm4ik3xPSvOepyNkSJmad98os49MVeLDs0GwNQQp1otH8vLO3jQemILT698vesna4oLMf7BCUKwiT2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-657a467228eso971510eaf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 14:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765493435; x=1766098235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/nvF3d1HV0rLnIwF04ZqXM+nC6To8S9FdGa4y/Uksw=;
        b=U6ZiwL23eTdeTtl2vFduuIooRW3X5Q+B0LxBqNg49g8E0e+wvHIxvLcFumcV992G8o
         JYG0N6EHr3w2hLGzo0/2QwT376cwS13NfM8/4l7iQkvrTyKN9le8hA5eDKch1RA09Yua
         xNL+CIrgWKTnE39p5b77T38hPyVEXqgk6a6bEdxXewguk5f/hgQ+boOc39AQSGcfrCQp
         TEBsBlBeJlvrK/NrRhseJAxJEx3I1TPc+iqdiClMxz5CdsXLirRCFMy68Hhq8HVVhTbH
         yXm6dPOirq5qb1NXmkv9pXtCAJeg3NPFzLm6cq0++3iqITUQ28tb2uNmy82RdIAx4x/C
         Bd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxT7D3BuYT0HF27WDuOD8oePXooqMwxJfQMVoEjncQjxBvgGMmlbxF8xoyIzFfyaPPl1XPSuablb31DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5T7e0NrwSP4KrTfBsSOysFdUBFjns4InAJK3BSPe50cR9I2s4
	fFb3BKeJkprDrv5X5FQl7ntXNkce7ReukS+68HjPHrRuRgP+bra1U2t35bfbxnNTU+ORZk8Xgmn
	Gkk/MnbL2vo2oZvle34D7i4py4lNjr4JHjd3WE2nehB6jVkUEG1FE9zmGZ/Q=
X-Google-Smtp-Source: AGHT+IF4lTj3yrH4MbYKEFJO8yF9VPRMUbRGmLKKIkO4PmaV27PactL4TxUbJdpT3/34BpLqKr5FTGM7pK9ecSsFRLHgNYB/8bXF
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150c:b0:65b:3641:bf78 with SMTP id
 006d021491bc7-65b452ad2aemr55089eaf.76.1765493435713; Thu, 11 Dec 2025
 14:50:35 -0800 (PST)
Date: Thu, 11 Dec 2025 14:50:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693b4abb.a70a0220.33cd7b.003b.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_create_qgroup
From: syzbot <syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dc161a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=803e4cb8245b52928347
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eef992580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102541b4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fa1d04c1a85/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9b253146e36/bzImage-d358e525.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/29e87432b229/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=10eef992580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com

R13: 00007f6d45de5fa0 R14: 00007f6d45de5fa0 R15: 0000000000000003
 </TASK>
assertion failed: prealloc == NULL :: 0, in fs/btrfs/qgroup.c:1690
------------[ cut here ]------------
kernel BUG at fs/btrfs/qgroup.c:1690!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5518 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_create_qgroup+0x52b/0x530 fs/btrfs/qgroup.c:1690
Code: 24 08 e8 08 f4 6f 07 48 c7 c7 e0 49 d1 8b 48 c7 c6 40 4a d1 8b 31 d2 48 c7 c1 60 46 d1 8b 41 b8 9a 06 00 00 e8 e6 33 39 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900029af540 EFLAGS: 00010246
RAX: 0000000000000042 RBX: 00000000fffffff4 RCX: 4c7ff4269176e000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000100 R08: ffffc900029af267 R09: 1ffff92000535e4c
R10: dffffc0000000000 R11: fffff52000535e4d R12: dffffc0000000000
R13: 1ffff110001f1b1c R14: ffff888000f8d8e0 R15: ffff888038ab4800
FS:  000055557c30d500(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb800c6e6c8 CR3: 000000001fd86000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 create_pending_snapshot+0x86c/0x3230 fs/btrfs/transaction.c:1748
 create_pending_snapshots+0x17c/0x1c0 fs/btrfs/transaction.c:1940
 btrfs_commit_transaction+0xf78/0x3b10 fs/btrfs/transaction.c:2430
 create_snapshot fs/btrfs/ioctl.c:779 [inline]
 btrfs_mksubvol+0xc75/0x12c0 fs/btrfs/ioctl.c:926
 btrfs_mksnapshot+0xab/0xf0 fs/btrfs/ioctl.c:968
 __btrfs_ioctl_snap_create+0x520/0x730 fs/btrfs/ioctl.c:1232
 btrfs_ioctl_snap_create+0x131/0x180 fs/btrfs/ioctl.c:1259
 btrfs_ioctl+0x447/0xd00 fs/btrfs/ioctl.c:-1
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d45b8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc63bd07b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6d45de5fa0 RCX: 00007f6d45b8f7c9
RDX: 0000200000001600 RSI: 0000000050009401 RDI: 0000000000000003
RBP: 00007ffc63bd0810 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f6d45de5fa0 R14: 00007f6d45de5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_create_qgroup+0x52b/0x530 fs/btrfs/qgroup.c:1690
Code: 24 08 e8 08 f4 6f 07 48 c7 c7 e0 49 d1 8b 48 c7 c6 40 4a d1 8b 31 d2 48 c7 c1 60 46 d1 8b 41 b8 9a 06 00 00 e8 e6 33 39 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900029af540 EFLAGS: 00010246
RAX: 0000000000000042 RBX: 00000000fffffff4 RCX: 4c7ff4269176e000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000100 R08: ffffc900029af267 R09: 1ffff92000535e4c
R10: dffffc0000000000 R11: fffff52000535e4d R12: dffffc0000000000
R13: 1ffff110001f1b1c R14: ffff888000f8d8e0 R15: ffff888038ab4800
FS:  000055557c30d500(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557ea737e138 CR3: 000000001fd86000 CR4: 0000000000352ef0


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

