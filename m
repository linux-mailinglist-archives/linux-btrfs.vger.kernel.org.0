Return-Path: <linux-btrfs+bounces-4990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C98C5C3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A934328457F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A53181B8D;
	Tue, 14 May 2024 20:23:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940B180A97
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718214; cv=none; b=up9wpmIpvtjsFQ6xbOOoiNfrVQ6lN79mQPGPa9ru04eTesu9/d+AdSmQx1V4dJ0i/d2DiSTtS84yY9QqZCE/zYzGmuHVv5GihjWmZUFC8KYPQWFGA+NSFFrLRvX9cMfpckZvRUse/+fY3pYxAQxGfZrABKyw80yCLpFEK3s4208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718214; c=relaxed/simple;
	bh=VTIB/7/r0A+xbsKG6d6v06OLFByjsDiqG8BqgoHWkcE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WDOlXyjaxIA57vrBN6NVBnd/hOey0iNn/UOZfzmkKNmWPoGYJhQp8ZgJzRZnNU1YETI/368VwDlQUHdsjmp7P+yAAW4RX4+0LYHCN9mi2J8K0F8wm0rgs7UEqnadoSjwrff49Q9/toCC4tJVbMdsqnIPJ/KOGtB1e/RkVhgGJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7da4360bbacso743166439f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 13:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715718212; x=1716323012;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rq9iUgKR4TDRB9grFF21zTQBEC+sDHsGn0+DR4a1KJ8=;
        b=uppwvaM6aupq9LCrAuOF7I1C0sT5V4EMozGbnPNPn453ykpUOaScfcT71BNo43/I23
         9sfH6B5R89NauqtpupypPXH1fYNAHhXIkIMjxwJLARZSvYceivGlkS9iwfEgfgswZkk7
         r0yT3bRhmEIYdIFlpJrOtjspj245jOE/3Ig75aST8bHmewahUrqo0vzBRZvw5zdU4Jk8
         kS3JdEiAGU2sHLydYfVgAfJXYaPIdzYmpXh0d+eovug3yv099SnuL9dXgNEIs8TCy7gz
         aZU04Zz4kJqe+P/55TFTDxAZEuwlGPcxXUzk/hnvgZUd4QHyaNVvcVeEYm4xqeo66fOP
         k/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVsmFlu3+oW4jgpePpL/KEron3iHqdcISvEphbmIt6ba8JbhOfA7Z2iZbpEYdjgm2ogT6KkPpTOMTcXgtkXqBXDJTGeNI0GdqK7Xkw=
X-Gm-Message-State: AOJu0YzImQkQj4l9FbjLDFIqyXjtwqL0VsY5yiZa7prAdVcJw5X3Bg7t
	NDFQoBiwQeRRWMJejkFuNf/xuRTGtEXOugWDApYLzxbuVjdByTl84gsPVFC73BMD+uFOK+naNT1
	HTRRKV3eUS4gGovzC/AlVAz89SlfupmMIAVOYCkgyJjLa9EqGrobbxek=
X-Google-Smtp-Source: AGHT+IHzyAjAze8ucBFpJ9ILU+skjgB+zENaWw3sMcBXYuE7KUnc9o3EAvaN8ewmpanBaAW+I9fbDxZJPHxkhwJT2Wrr5lMtKMdy
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248e:b0:488:7f72:b3ac with SMTP id
 8926c6da1cb9f-489585764d4mr831595173.2.1715718212415; Tue, 14 May 2024
 13:23:32 -0700 (PDT)
Date: Tue, 14 May 2024 13:23:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096049806186fc6f9@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_stop_all_workers (2)
From: syzbot <syzbot+05fd41caa517e957851d@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a0fbc4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=05fd41caa517e957851d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05fd41caa517e957851d@syzkaller.appspotmail.com

BTRFS info (device loop2): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
general protection fault, probably for non-canonical address 0xe01ffbf11002a143: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x00ffff8880150a18-0x00ffff8880150a1f]
CPU: 1 PID: 5087 Comm: syz-executor.2 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 f3 80 de 11 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 a0 2c a1 92 0f 84 98 f2
RSP: 0018:ffffc9000327f938 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 001ffff11002a143 RSI: ffff888029405a00 RDI: 00ffff8880150a18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f9f4fd7 R11: 0000000000000001 R12: 00ffff8880150a18
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  000055556dc0c480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c002bb5000 CR3: 00000000668d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 put_pwq_unlocked kernel/workqueue.c:1671 [inline]
 put_pwq_unlocked kernel/workqueue.c:1664 [inline]
 destroy_workqueue+0x5df/0xaa0 kernel/workqueue.c:5739
 btrfs_stop_all_workers+0x29f/0x370 fs/btrfs/disk-io.c:1800
 close_ctree+0x4e3/0xfd0 fs/btrfs/disk-io.c:4371
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_anon_super+0x3a/0x60 fs/super.c:1225
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2091
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53b047f057
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdaeab7cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f53b047f057
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffdaeab7db0
RBP: 00007ffdaeab7db0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdaeab8e70
R13: 00007f53b04c93b9 R14: 000000000001ac84 R15: 0000000000000007
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 f3 80 de 11 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 a0 2c a1 92 0f 84 98 f2
RSP: 0018:ffffc9000327f938 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 001ffff11002a143 RSI: ffff888029405a00 RDI: 00ffff8880150a18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f9f4fd7 R11: 0000000000000001 R12: 00ffff8880150a18
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  000055556dc0c480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c002bb5000 CR3: 00000000668d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	11 00                	adc    %eax,(%rax)
   2:	00 39                	add    %bh,(%rcx)
   4:	05 f3 80 de 11       	add    $0x11de80f3,%eax
   9:	0f 82 be 05 00 00    	jb     0x5cd
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	e9 e4 00 00 00       	jmp    0xfd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 82 1f 00 00    	jne    0x1fb6
  34:	49 81 3c 24 a0 2c a1 	cmpq   $0xffffffff92a12ca0,(%r12)
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

