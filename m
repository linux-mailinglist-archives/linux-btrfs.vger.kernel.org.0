Return-Path: <linux-btrfs+bounces-9317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D20929BACE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A868B20C1A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AA818E362;
	Mon,  4 Nov 2024 06:57:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8B18562F
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703426; cv=none; b=lIMHyhx8Wa3wDKN63eMTJKMzWD8AR5cTTa6ZqdYXBj7jZ5jNxHdDFwWco0GANlu50TSS9Jk9raFsbXRL7AWoXwPaYc5RbEPbfnZqqansLeEjW9A1m9T0V9gT+jmlT2hwQPv0mLhvQQ1us7REwae6QpDIlHgqHbSHW+KOSAmEUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703426; c=relaxed/simple;
	bh=7u3PVP7XeLnXBb7y0pIyLPAOxq6idjR9oXlLVtoMRWk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DN6d0+N0XHivwuf7hg8O89jya/qBu/hvCjGvuCoXPARKhkjKMXNY+/itDoLw///Rnfilc6pX6eIx4eRkk2koaxolJn10klyMsClpBIsj2g9bgUVsRrOoFFgiQu2ZSwG5QzYJA85Yl8HmovEBxltwdr2WZSUljpbKHLJduMxEGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so42502725ab.0
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Nov 2024 22:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730703423; x=1731308223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS56byKtsj1CuaOp8CMIOFr+yZjq6JATOWy1qBHCB3Y=;
        b=smOkX2a63XNPqIpcDFkPGi30K/un1LmVq0MNj5cS3snFLRfj6HepGhGNhUHPzniWCD
         Ck8Cj8HMTePHACQFrVLh7bo+iQM0z3hLV1nilNTy6uRNmjg6tVM4cy4/7+PTZyydU0z7
         Q71jm/JQHz9DOlHdYu1fBmBM7x1OomPoeZJco08Q7LGlQP1tCwVAeEbUJcxG3gsKEB1Y
         cclvWMWfkt7NyZQsn/bxJwdYcnJnNnoIhJ/JsPBtTgltt2pPVCwy9sKiDrCelEDFLp7p
         X6cTErlN/0OTtNKMxxCEuwsuEJS8BSB4rpak6zFcd5kiiOnSwuvIcLMVSqcWy4/+/BVN
         U5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+okwEytIEFMwWQHllAw+m+yHzWH6tbo7pOUleO9iHBs3m13xtc2YYhn9uNmxqdtWElf0tAHRzwam+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgKeFDrzm9cKFf5OdVZHkZvPPCgDMAV0yFA4mYsezOqlM1lCo
	mRxHiWQq2iAHJp6iWLY2Ib7YIXl8O7tO3e/wOJoBjWe3N8LfrLtkHVVGjNqgO5gry2Agci1dLz7
	0OJy1Kq6qtZX2D6wbSxskoJqNndydOq6mE8tsNf2c1WJPszrfdrRLwHc=
X-Google-Smtp-Source: AGHT+IF9NRi1wtC75+dFdmgUK+o3W5wazJccOcbwGFbyTRSX9gytRCMUlAFpjg5r+pEv3KgtFTrVdfHpgSJ+4xyJSfyYTUEE8Yeo
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:3a3:4122:b56e with SMTP id
 e9e14a558f8ab-3a4ed31449emr296904625ab.26.1730703423648; Sun, 03 Nov 2024
 22:57:03 -0800 (PST)
Date: Sun, 03 Nov 2024 22:57:03 -0800
In-Reply-To: <3c01986b19c041931fe7bb542b1b00069b2e458a.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6728703f.050a0220.35b515.01b1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] VFS: Busy inodes after unmount (use-after-free)
From: syzbot <syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
VFS: Busy inodes after unmount (use-after-free)

ocfs2: Unmounting device (7,0) on (node local)
VFS: Busy inodes after unmount of loop0 (ocfs2)
------------[ cut here ]------------
kernel BUG at fs/super.c:652!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6441 Comm: syz-executor Not tainted 6.12.0-rc6-syzkaller-g59b723cd2adb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:generic_shutdown_super+0x2ca/0x2d0 fs/super.c:650
Code: 1b 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 f9 23 ed ff 48 8b 13 48 c7 c7 80 be 18 8c 4c 89 e6 e8 87 3f ad 09 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000354fd20 EFLAGS: 00010246
RAX: 000000000000002f RBX: ffffffff8ee531e0 RCX: e6b6b127fe74ba00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100f467cf0 R08: ffffffff8174a12c R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: ffff88807a33e668
R13: dffffc0000000000 R14: ffffffff8c49f718 R15: ffff88807a33e780
FS:  0000555593ff6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00221c000 CR3: 0000000060ea2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_block_super+0x44/0x90 fs/super.c:1710
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ed837fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcdc5c5528 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f8ed837fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcdc5c55e0
RBP: 00007ffcdc5c55e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcdc5c6660
R13: 00007f8ed83f11cc R14: 000000000001b0d9 R15: 00007ffcdc5c66a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x2ca/0x2d0 fs/super.c:650
Code: 1b 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 f9 23 ed ff 48 8b 13 48 c7 c7 80 be 18 8c 4c 89 e6 e8 87 3f ad 09 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000354fd20 EFLAGS: 00010246
RAX: 000000000000002f RBX: ffffffff8ee531e0 RCX: e6b6b127fe74ba00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100f467cf0 R08: ffffffff8174a12c R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: ffff88807a33e668
R13: dffffc0000000000 R14: ffffffff8c49f718 R15: ffff88807a33e780
FS:  0000555593ff6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563a27431950 CR3: 0000000060ea2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         59b723cd Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10202d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc23b43a0f2f7cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

