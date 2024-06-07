Return-Path: <linux-btrfs+bounces-5522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B298FFB25
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 07:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812301F26C3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 05:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CB11B810;
	Fri,  7 Jun 2024 05:05:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD919D883
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 05:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736731; cv=none; b=m3qRI4xEhuR/xBjU0leDGtcMTZkCFKHHgq84oy++4vNmEoDULidjYh9mZmUC8E8i3M9/qEJjXfyTt+S56CRqZ5TueH8BX13BT9ESZuzD45o7zuTK6P1W4V8EsR/+3LcgvcTZyy4gEPrhkubfkoe/Yeb/fl8S58JJjyLFYV4OQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736731; c=relaxed/simple;
	bh=GBrfTYKLXssvFGONI8vGBOOKuB+PqsQCbSPm4p6qEHA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j4RR8jpXocJzKT0SO8Kl7+Q27xO/+bjp3CXepPFacontr2Y0gKLr70LKTE9sJWW58eYu4eIjTvHSXxRyetvcIlCipFdPRKfrK4UcQ2iPz98l6W0BcKecXzEpldYqxGbNO21PoG+o1Pip4gApzNUn2x0cDPX1IxrjLVgLzNV4Xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb413e6caeso198285739f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 22:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717736729; x=1718341529;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uS8YStOSM+DHa4enbnMdyhZPkLjkUCnAEZNL/nSaHGQ=;
        b=mBFbx7K5XO9N9YrxWR9GJojn99Lnaqi+oppSlqkJ85nFrdhRX6KEl0vFqkbgKiZ3Di
         dOqXCUPcKTRtm9DXOQH2GeAyC6Ptkofjp9LMVyaRcevHQU5OsU2GFSuaUfyRSXtAc3uc
         iuj5IP/U6jOIqUPSUtGwxYMGUF/MmYT/cn0gRRYtqOAKRvkoHaPlm4173G0p0YR0V6DT
         R/BYljcUdA9GxeTBFoPQVOlqJBBhpkmNu0maZ6oBsV4va5cEFsL4DPJqf/aDAqx+XkQe
         D/xdeoP9/03VNxotIwrgz47zlFFM1BgWFV/TANs56fXMUptA/EenUHxvX2M45enRXsZ2
         T8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUXssfGdqcI/s+FWivlgXvDfgP223CRFnkgPwXvXhBvLFGMu76cVA/oPb9ajIaVMGOUZD0OwjPiIntDWKqdtmZGZvesigBzMbApAt0=
X-Gm-Message-State: AOJu0YwP2rf+IEokT3k9/uRiVdF8N7TzeWsOrD6ziLOVS7a0BWMx5Lfm
	wBRuZJubkIxssDqkmOK7CVMdE0HaCcJyyFhnuK4ulP0J4X6yjjOuPN9gUCxp7cCjdbwjolRQ6Oy
	cmX3BAk90Pnq90dfYhW8TaI4HONx5XvbkXTiQiMZLX2AX1CcVrIeVOhQ=
X-Google-Smtp-Source: AGHT+IFuorXcgGYGy5yyFr4JYBxqv+bH6kgczzpeAsUQwr9Tv5KlSX1N2BjY/s8qGOudU5bUs8CF50nv01ZOUZ4qWXW22KuXW+MY
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:373:874e:93be with SMTP id
 e9e14a558f8ab-37580380f1cmr1065635ab.3.1717736729726; Thu, 06 Jun 2024
 22:05:29 -0700 (PDT)
Date: Thu, 06 Jun 2024 22:05:29 -0700
In-Reply-To: <000000000000eabe1d0619c48986@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097e583061a45bfcf@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
From: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d30d0e49da71 Merge tag 'net-6.10-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1736820a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a9aa22980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c57f16980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d30d0e49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f1276023ed77/vmlinux-d30d0e49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a33f372d4fb8/bzImage-d30d0e49.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7fc863ff127d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:626!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5273 Comm: syz-executor331 Not tainted 6.10.0-rc2-syzkaller-00222-gd30d0e49da71 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:clear_inode+0x15b/0x190 fs/inode.c:626
Code: 00 00 00 5b 5d 41 5c c3 cc cc cc cc e8 5e c1 8c ff 90 0f 0b e8 56 c1 8c ff 90 0f 0b e8 4e c1 8c ff 90 0f 0b e8 46 c1 8c ff 90 <0f> 0b e8 3e c1 8c ff 90 0f 0b e8 e6 92 e8 ff e9 d2 fe ff ff e8 dc
RSP: 0018:ffffc900036f7ac0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888030369e90 RCX: ffffffff82012340
RDX: ffff888024190000 RSI: ffffffff820123aa RDI: 0000000000000007
RBP: 0000000000000040 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000020
R13: ffff88802f942000 R14: 0000000000000000 R15: ffff888030369e90
FS:  000055556268d380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555562697708 CR3: 000000001e888000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ba3059777
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff42f9ee78 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f2ba3059777
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff42f9ef30
RBP: 00007fff42f9ef30 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007fff42f9ffa0
R13: 000055556268f6d0 R14: 431bde82d7b634db R15: 00007fff42f9ffc0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_inode+0x15b/0x190 fs/inode.c:626
Code: 00 00 00 5b 5d 41 5c c3 cc cc cc cc e8 5e c1 8c ff 90 0f 0b e8 56 c1 8c ff 90 0f 0b e8 4e c1 8c ff 90 0f 0b e8 46 c1 8c ff 90 <0f> 0b e8 3e c1 8c ff 90 0f 0b e8 e6 92 e8 ff e9 d2 fe ff ff e8 dc
RSP: 0018:ffffc900036f7ac0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888030369e90 RCX: ffffffff82012340
RDX: ffff888024190000 RSI: ffffffff820123aa RDI: 0000000000000007
RBP: 0000000000000040 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000020
R13: ffff88802f942000 R14: 0000000000000000 R15: ffff888030369e90
FS:  000055556268d380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555562697708 CR3: 000000001e888000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

