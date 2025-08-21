Return-Path: <linux-btrfs+bounces-16197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5BBB2FE30
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02675603A9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4826CE10;
	Thu, 21 Aug 2025 15:16:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD4242D95
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789390; cv=none; b=svYevCwNRuuKfTGag9sGcVc4U3XtCCqLZFkt9d6zpCx2lceLnUwdxP55h6mpZiZYeynpIcNktxsj6Z4HQnItMUhbv5wwiPy8meJhc6JTNgpU0twWsfbhpv7n7gB2Oj/Ub+cwqvHn1KEs3nm/zWHjhhfjHklvOqOT0wkQIACA4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789390; c=relaxed/simple;
	bh=LNbjqvG7LJsRajT5yTZqU8haJdLm5LrGPihmKsKpR0Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ICZdgD7JXm8lQVJYNAspl5zHZTsXdwAojYsYj9k0EnhwFXrYgyTwj0lManMI2WsGaZxeeq6pNJgFMJCxUhLTkAVmbFKNhRXS5Gx5gF1VrYOJvUqeUhL1HKn7Ie4y4HBIo6jR0k657ZsLNWg7u0ExbCXLZ8EtWB/Ra9K2m4zYnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e56ffea78fso12671995ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789388; x=1756394188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O92ULdLlOMhMBsZaIW/XrHMimBdSXPVNNUtybxQYuBg=;
        b=VFLtVpuIC5H86CQQHa2eNPQN4OrfkEW1ML54iFhpyt+eQW8UBxSWOzCRs7hpme84hj
         eEheKwEJyBRjILU9zE1qqWM3etW1TuFQHvIM5sk1XurljAD0RPYD/SeP1ODa4tjdfIaV
         YlwGfSVq0NxrBPj33HqRPKNj0m5jXVvvEQzdKt4cWqyp7L/BnNUD/5l0O4e3ucwMvUKU
         7SxCUhtL7MvtrXd1jYajwiSRQMuA8hftigIQZ5Y+8hutRo5NJAYPv9iLsCAwwtlc8SkE
         VEwbOEgCcXoDQ87X+Zvcv8RQJiIq4Noy+IcFYhBc/kcKAo9tU3I+HphMODZynSCpweq0
         cHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ao8M38cb5uiyLzTdcSqr+F/Hu7wOu12w2EVSHzqAkZvPW6pfzbQ9XMJwkmfY1bTepVDco8aVqCOK3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzDcmav5Q6fTOKdO2Aaf32O7DvwJ8DloHro799KWtf0VsqEES
	8eJAN6OO4u1s+OnmYEqS7CWGMiE0DPrWO4Pru95wNM0XQgKNDtgtJYr5A1JASVlgQj2bljuilLe
	sRatjt437eBmUHjiTaIRSekClMMqNF8cq3LvMlx57Ei1xGhErZyWFttB6Puo=
X-Google-Smtp-Source: AGHT+IECnpZs4zeS7UU209W8Ab5lvMXkV/Aq4dr+bonM9fktxtF5NDv8N1aneoM3N0ll/hnX/Voa8+q6hOdwXfsrX4rxFNWTpHsP
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3e3:fe52:e576 with SMTP id
 e9e14a558f8ab-3e6d4630735mr44044905ab.9.1755789387910; Thu, 21 Aug 2025
 08:16:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:16:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7384b.050a0220.3d78fd.002c.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_put_transaction (4)
From: syzbot <syzbot+62f59a3655c0df0581cd@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13792ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=62f59a3655c0df0581cd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62f59a3655c0df0581cd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7838 at fs/btrfs/transaction.c:144 btrfs_put_transaction+0x4b8/0x520 fs/btrfs/transaction.c:144
Modules linked in:
CPU: 1 UID: 0 PID: 7838 Comm: btrfs-transacti Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : btrfs_put_transaction+0x4b8/0x520 fs/btrfs/transaction.c:144
lr : btrfs_put_transaction+0x4b8/0x520 fs/btrfs/transaction.c:144
sp : ffff8000b41a7a70
x29: ffff8000b41a7a80 x28: 1fffe0001f3374a0 x27: dfff800000000000
x26: ffff0000c621a000 x25: dfff800000000000 x24: 1fffe00018c43404
x23: ffff0000c621a000 x22: ffff0000f99b8d38 x21: 0000000000000001
x20: ffff0000c621a358 x19: ffff0000dfc5b2a4 x18: 00000000ffffffff
x17: ffff800093507000 x16: ffff800080535980 x15: 0000000000000001
x14: 1fffe00018c43402 x13: 0000000000000000 x12: 0000000000000000
x11: ffff600018c43403 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000e01edb80 x7 : ffff80008235f5e4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800082358eec
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 btrfs_put_transaction+0x4b8/0x520 fs/btrfs/transaction.c:144 (P)
 btrfs_commit_transaction+0x1d24/0x2ce4 fs/btrfs/transaction.c:2583
 transaction_kthread+0x200/0x430 fs/btrfs/disk-io.c:1592
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
irq event stamp: 123680
hardirqs last  enabled at (123679): [<ffff80008b028df8>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (123679): [<ffff80008b028df8>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (123680): [<ffff80008b001bfc>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (123658): [<ffff800080201608>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (123656): [<ffff8000802015d4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

