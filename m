Return-Path: <linux-btrfs+bounces-9873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF49D7549
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 16:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BCF168813
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746621B85E2;
	Sun, 24 Nov 2024 14:45:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C591AA789
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732459520; cv=none; b=QsQ2MLtJWVJD7ro2w05XTldjf+DgRQ9G7zhbEYpMHkaafw6rJlXJnahyY/E6oCe7Qb7xq9/C2xsAy8nsDNyuW4nqmH0Pzs5OKOsrgcQ24k9LIXNgPPJq8BR8KSvIUTFqnuKs+DmMHkui1JhRHP1IRlDlxNIeumdOVpr8ZxWJaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732459520; c=relaxed/simple;
	bh=pX9HTsqn9W2wm96NKL0wmgtrriOmr6tTltrOiYNrewc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HCwN0kqJcyvWZjzEZcmzuNyYJAGhTfq9eZdmACyldSQS7+R730HqqK99XeekPyZEho1AGm863r1xtCk9CIUN6OnlXTi7EGNYa89zjh/kudR+UoVBVcNuM/zu3FPUJLXh5VWFtJxcwhiZi1Vg9J462fZ9+Qyp6i//3UlEoQQQJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77a808c27so39242305ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 06:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732459517; x=1733064317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7Ls8UtoQy1GOcuv3+txAfuwcTatgUFjZL8Pkknxg2s=;
        b=R+bJR/rXdS/8BZioRULCUI67yDlia+ja5I6JHbqDS6ybqA8923SXE33CshWdA44THt
         CreQUSlS+boH9uvNzvHa94AHOtOHEVTJObz+aGNkGT1FqeDqNoIvjTXz4oUE5D7ouX9i
         AMzblDYKYRuzV1zLZgaFLPBYUcP5xtWK9dO7Ful/v3vXkJZDqXdEzrTMxlWnIrThhiuF
         n1zhwHEyI5FYaom7YVeakt8gqwLKSHvGhL7D32yiXgXTAn0fOy9igbd7Pcc8ieN27VPW
         Jxbs8QEe0qBX+gTM+TqUfDpshWcC62JoomRj0nyrptbTGAgAJJQWQ/fZ2rH2ocTDrh/3
         kNWw==
X-Forwarded-Encrypted: i=1; AJvYcCW1ocG20vD2T+wDjEEgcIIUuRpywxYXz0YSMrFit1mcsB1XAjsfr6qwqaUi8T56fAjBz1L+YkYrhZG8ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCi9MFFBEo1Z7QLR1vU3PR5svqrKQjZz8R4uowekooRCRmP0ej
	c8Vzg5lvf8gNHD5ftqdqPeckq4Sn+adGpm/pd56Pb9dqG0bA8SzT9VpdMT43X7VXGva10YhFKgE
	tGJ9HWe7H6sZIV+b8YRIX/J4ulkndPzjOIM4BhaMJKSAd421QoZLvLBA=
X-Google-Smtp-Source: AGHT+IHQgYYrnaMJFsLMkrwdp+jLj3mmTJuGHlOvachPdAtBu0X7pCoEnCr0DYJskDKOMBG6wceMWBxnE7PU0GK6rZef39MUmWGC
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3a7:8320:9ab with SMTP id
 e9e14a558f8ab-3a79ad748aemr104199595ab.8.1732459517611; Sun, 24 Nov 2024
 06:45:17 -0800 (PST)
Date: Sun, 24 Nov 2024 06:45:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67433bfd.050a0220.1cc393.0042.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_put_transaction (3)
From: syzbot <syzbot+d6ba71ce7a916cf10094@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf9aa14fc523 Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1050cae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48190c1cdf985419
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ba71ce7a916cf10094
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-bf9aa14f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a86e66fb23d0/vmlinux-bf9aa14f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fccf5aa8139f/bzImage-bf9aa14f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6ba71ce7a916cf10094@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5346 at fs/btrfs/transaction.c:144 btrfs_put_transaction+0x356/0x3c0 fs/btrfs/transaction.c:144
Modules linked in:
CPU: 0 UID: 0 PID: 5346 Comm: btrfs-transacti Not tainted 6.12.0-syzkaller-01782-gbf9aa14fc523 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_put_transaction+0x356/0x3c0 fs/btrfs/transaction.c:144
Code: 89 da e8 0d c5 10 08 48 bd 00 00 00 00 00 fc ff df e9 02 fe ff ff e8 09 12 de fd 90 0f 0b 90 e9 0d fd ff ff e8 fb 11 de fd 90 <0f> 0b 90 e9 84 fd ff ff e8 ed 11 de fd 90 0f 0b 90 e9 a1 fd ff ff
RSP: 0018:ffffc9000d2f7b40 EFLAGS: 00010293
RAX: ffffffff83b6d7e5 RBX: ffff88804d306358 RCX: ffff888000728000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffffffff83b6d50f R09: 1ffff11009a60c02
R10: dffffc0000000000 R11: ffffed1009a60c03 R12: ffff88804d306028
R13: ffffc9000d2f7d40 R14: ffff88804d306000 R15: ffff888043e54bf8
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff3827ffb0 CR3: 00000000458e4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_cleanup_transaction+0x562/0x1ca0 fs/btrfs/disk-io.c:4805
 transaction_kthread+0x307/0x500 fs/btrfs/disk-io.c:1610
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

