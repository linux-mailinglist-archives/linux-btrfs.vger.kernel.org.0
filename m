Return-Path: <linux-btrfs+bounces-5381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5D8D6948
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9EDB21969
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A057F7DA;
	Fri, 31 May 2024 18:56:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A17E563
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181782; cv=none; b=nns6kKojregepvo+E9Je325Lqk2S9ETTB9J961azOGWejjTMjRKxRRZIxHXlDgHNi6zGJn+d+jK9pljhXjGahYPE1gDsAiyo/KtDRfSR9LCWbuPkIKTtAYirbO/5lqJlq/QD+guY9QQM2UOByo2dGTjyNDQL+Esc00SszdLdgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181782; c=relaxed/simple;
	bh=qN4vlgIgphPICeA4Q6mNaG+fMmSzRaQqb7ipUQbietE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D2yiE332nmiVASQDpsPiYxgHKPWTYAqhYm3XOuKPvEGQnIEYFyXH0Ru9ChjWHtuHAdB+nCLitwLM62AoYMagTXs3y/0bBkLAK5zgrR7/ghhvR4EfGZU6KHYuTEXex7MOGkk0eOczEstHZPGhdZKXpTRIuDdLCtnmGbWzplLjmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso286980339f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 11:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181780; x=1717786580;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGMeTtLYeIHVSkGLYngSRR4aJEt/tcf+WEvx9z803x4=;
        b=TfZHr0nBn+1mYsBe4FPR3KrRN+IP/mVc3rinSR6ent6g/jXnlm4OAHlbrCOw8QkJj3
         YYspwj2WGdoxmx/VxlR1ay4Kz6+NYdKagIomK50TK0Af6mW8XV5n229dyOqD0OSziECz
         8zQgyD9laLxDnp0hnTW39LSzuCjtPowHYkzE7vlvc6zM09xlfG7r+oY5sVPBopqYn64C
         K6HH7sBsRsacMzGcy91bAzueqWtrQWa+VLeKHVqxUnU2JPEuKb75hRHY7TJxGTQ+zcnV
         XkgiGoZc9g59VUb5r16YyzjEsOTVlLGFFqXvTczkrPBKF5yDITRT/yNnuinL2oxYbdas
         0t8w==
X-Forwarded-Encrypted: i=1; AJvYcCVqBO9Ozrnu0vNLHX63mEKyvGyXCyr9iF8Tr/5O+9SsymRuMrDKYyWt8Oc27iRqiHbgGRqcC2uKSoSdXD7AhUEYHnbdxREKuTfoj0g=
X-Gm-Message-State: AOJu0Yz/6b/fmtvGk9YtcJRcDGGtRuzLhxALJ8YXZtDCVhrZj8nExbmm
	/32SJHxCa3YPQ+fwmO24ayPagHOipwfGdcrjLUyGPuKDKRZsCF9rvopUmuSxtIMDnquNndRMfNJ
	ObaYhdKzyL7Ys7cAQLaaDssbqc6jfIfXSiXJ0Bk89YH2PMI8CC1PgXsA=
X-Google-Smtp-Source: AGHT+IFZFsUgCMXhoAwOpoDKxRo2bK70F662gaHR/g6Wz1Cj3I10qnqYXoAAtI8r+mfs20sgrXxlYOYPO22iWPcCYmq4PjE/A9fV
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1650:b0:7ea:fa78:1568 with SMTP id
 ca18e2360f4ac-7eaffdd3600mr21086839f.0.1717181778406; Fri, 31 May 2024
 11:56:18 -0700 (PDT)
Date: Fri, 31 May 2024 11:56:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eabe1d0619c48986@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in clear_inode
From: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2bfcfd584ff5 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128ea8b4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2bfcfd58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7ed3bb80bed/vmlinux-2bfcfd58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93acc5bfbaef/bzImage-2bfcfd58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:626!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 7700 Comm: syz-executor.2 Not tainted 6.10.0-rc1-syzkaller-00013-g2bfcfd584ff5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:clear_inode+0x15b/0x190 fs/inode.c:626
Code: 00 00 00 5b 5d 41 5c c3 cc cc cc cc e8 1e 7e 8b ff 90 0f 0b e8 16 7e 8b ff 90 0f 0b e8 0e 7e 8b ff 90 0f 0b e8 06 7e 8b ff 90 <0f> 0b e8 fe 7d 8b ff 90 0f 0b e8 b6 b0 e8 ff e9 d2 fe ff ff e8 ac
RSP: 0018:ffffc90003a2fab0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888028014230 RCX: ffffffff82030100
RDX: ffff88801e1fa440 RSI: ffffffff8203016a RDI: 0000000000000007
RBP: 0000000000000040 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000020
R13: ffff88802855c000 R14: 0000000000000000 R15: ffff888028014230
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:0000000056b5e400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f58c1d30980 CR3: 000000006b300000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000001000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_evict_inode+0x529/0xe80 fs/btrfs/inode.c:5262
 evict+0x2ed/0x6c0 fs/inode.c:667
 dispose_list+0x117/0x1e0 fs/inode.c:700
 evict_inodes+0x34e/0x450 fs/inode.c:750
 generic_shutdown_super+0xb5/0x3d0 fs/super.c:627
 kill_anon_super+0x3a/0x60 fs/super.c:1226
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72c7579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff99b808 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff99b8b0 RCX: 0000000000000009
RDX: 00000000f741dff4 RSI: 00000000f736e361 RDI: 00000000ff99c954
RBP: 00000000ff99b8b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_inode+0x15b/0x190 fs/inode.c:626
Code: 00 00 00 5b 5d 41 5c c3 cc cc cc cc e8 1e 7e 8b ff 90 0f 0b e8 16 7e 8b ff 90 0f 0b e8 0e 7e 8b ff 90 0f 0b e8 06 7e 8b ff 90 <0f> 0b e8 fe 7d 8b ff 90 0f 0b e8 b6 b0 e8 ff e9 d2 fe ff ff e8 ac
RSP: 0018:ffffc90003a2fab0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888028014230 RCX: ffffffff82030100
RDX: ffff88801e1fa440 RSI: ffffffff8203016a RDI: 0000000000000007
RBP: 0000000000000040 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000020
R13: ffff88802855c000 R14: 0000000000000000 R15: ffff888028014230
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:0000000056b5e400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000c000f9c4e0 CR3: 000000006b300000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000001000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

