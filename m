Return-Path: <linux-btrfs+bounces-14455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80993ACDEDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557F23A6F29
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EE28F950;
	Wed,  4 Jun 2025 13:20:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3143AA9
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043231; cv=none; b=rHjhYBsdC0Q54eEa4QRSp9j/P3hC9tDY0quIzEq95oNeeqKPReVCR3+KmOLKb6kc5sIt5be1DZ7nMZUYv1rlY1GNFz+p/M6OhhbB6s7CYwfNqpFgFkXhUxMhvJA2pCCaxcXF0xEEerTJctxeXvNA1/EjzH4okWLFvKTqHCayAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043231; c=relaxed/simple;
	bh=GtwuQJuy51N4t1zq/Q9Z6lCX128Pom+l/Co0cYVYgYo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gb3LHz7Gh2sEwYPfaOB+tQZhZAxxJxoqltfnQSUIekxSbrjHwKSdgu3WAot6i6VW8e3Ljo2Nq7npN7bh35J1ZyWoQBDEiuavkZ8XyhGDdQBRv9dhGILNnoANdrIYZptR6UMV0u/ER4gYuZA7vFM06fJKGIEcbyXu4m+GvMR35FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc2d3a2cfso4418545ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 06:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043229; x=1749648029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10aIB0t8KM36XkuxFgyqCSaNeuDx3XE/NxbhTOsT0v0=;
        b=ZAXTINC0e0pGe6gzHEBjwHTmOn1eJTgyUJxekupCL24HsdiODhbT0UUxeCvHBQ5NAX
         16ggl+FKSfzaO5rBedo+i4Bl3lVRljPCScBd8hySNKxB3LGd+blfi3aLTK70yGr4Bln3
         bUJaxXe+1GdMx4yKU6KfSqr5gNdIR0NKiorfOQ8zKwjTn6SdFSFvZF3yNMi+2mPRd0Sz
         B8OwUvq0B/LjEs4HpYBze1bAo2NpMLA7Nn4DhRZmGTMNadAB3S38HhJ2YVdzcKvEMUrz
         xEREZfGEEzbr5GbEKAahP8LAhy5nR/lLwHt5FdY9rMZyeAYHOVQoaca23O3TgykrD1ka
         u5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt3uOo2iFlm4oShTneSUds8aqxk0qy7qVloI0QYx8HsmYF5f7sSu4m2GFsvPN7zNyJ/D0WsJ35bHEL5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAT20aWlPwfUXiQkR6mHtSUwmZE1WYPAmfcA3hi8qcL5Ic2O9
	L5iA5hxI6N3d0cDFnUCCcQwJbd8AIidlP/HAXQKt+76O9Vl0adZKeTmireYN4MZBI8UOsgHaKRJ
	FgWt0SCeUWOUjcPV1e2tB+gUl530pVOdeIFEfh9lbdI0UMG79CTPZGXpM3eM=
X-Google-Smtp-Source: AGHT+IGwseWAf5OxBFbNEQ2+7rV/HvgblxWQTAb1qtVGBtvaspTA9QK9LkA8yHip5XZ3Qtm+IDi1O0NxObvlABQKQCrI0iybkd/M
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b07:b0:3dc:88ca:5ebd with SMTP id
 e9e14a558f8ab-3ddbedfca9emr32646245ab.20.1749043228917; Wed, 04 Jun 2025
 06:20:28 -0700 (PDT)
Date: Wed, 04 Jun 2025 06:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6840481c.a00a0220.d4325.000c.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_add_delayed_iput
From: syzbot <syzbot+0ed30ad435bf6f5b7a42@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a83b350b5be Add linux-next specific files for 20250530
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=117a3ed4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28859360c84ac63d
dashboard link: https://syzkaller.appspot.com/bug?extid=0ed30ad435bf6f5b7a42
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e18e458d13c9/disk-3a83b350.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1c40854811c/vmlinux-3a83b350.xz
kernel image: https://storage.googleapis.com/syzbot-assets/571f670b130a/bzImage-3a83b350.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ed30ad435bf6f5b7a42@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 65 at fs/btrfs/inode.c:3420 btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
Modules linked in:
CPU: 0 UID: 0 PID: 65 Comm: kworker/u8:4 Not tainted 6.15.0-next-20250530-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: btrfs-endio-write btrfs_work_helper
RIP: 0010:btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
Code: 4e ad 5d fe 48 8b 3b 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d e9 f8 bc ca fd e8 03 2a fa fd e9 e6 fd ff ff e8 f9 29 fa fd 90 <0f> 0b 90 e9 41 fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 72
RSP: 0018:ffffc9000213f780 EFLAGS: 00010293
RAX: ffffffff83c635b7 RBX: ffff888058920000 RCX: ffff88801c769e00
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffff888058921b67 R09: 1ffff1100b12436c
R10: dffffc0000000000 R11: ffffed100b12436d R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88807d748000 R15: 0000000000000100
FS:  0000000000000000(0000) GS:ffff888125c53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000bd038 CR3: 000000006a142000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_put_ordered_extent+0x19f/0x470 fs/btrfs/ordered-data.c:635
 btrfs_finish_one_ordered+0x11d8/0x1b10 fs/btrfs/inode.c:3312
 btrfs_work_helper+0x399/0xc20 fs/btrfs/async-thread.c:312
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

