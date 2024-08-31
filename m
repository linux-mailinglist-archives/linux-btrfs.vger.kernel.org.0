Return-Path: <linux-btrfs+bounces-7708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4F9672E6
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD12B2226C
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9674C08;
	Sat, 31 Aug 2024 17:59:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882810A3D
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Aug 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725127168; cv=none; b=CyjE5KJ9fdxjSC2X7AYs47EI9OS7rfAi5ze7s1b7ySoMEhClSxEIWKOl0VgfxWw7qTUWTbD2ZvU9+9Qxh3kda4QhmmR4ijjHPmVR5RjPxxPvwCrg1vzGem28xUaZy1BHkrQG7367VHYsM6mXNmOVCiqNDHVRKlO4mnV7kFLiA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725127168; c=relaxed/simple;
	bh=XHyQVpoMoTxGb69pUdf4yvKKvfJPBy+TRpZq/a0CTw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G1RYYu55CVCylqvTHPsiDlyzPSbKa4gQzDBn3V+C0jYaPVrgoO0kBHfzcrWf+JdEQuoj9af/yGDQEhRwXkj43T5lQthN7x6VXjdSWqTCSUIBzMuRpQePacDehBVG09x5c2PFCxz0vSCEu2OnSEBf6b9WOdytTrGlA12Db28rVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d465cd6ccso31827735ab.1
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Aug 2024 10:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725127166; x=1725731966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uy2DsHo15yiAT/5MKMd0euNM1waTYrVWOuLOMaJMGkE=;
        b=F0BytVwS03EM8lVTbAEKuJwyTW2JBTWtAUUkfC4kmcshpTofcWIgCU0ZwpoRE0SpZ4
         l+HyOlfE2MDKHfHjUogT0ckFq8VEKgXQldj/f+23XFcCvK9I+EYn/5aJQtzM/N0VE4mA
         xA28tZ01WrWZeqVQfGlWoykZJpchzf1GtbhRqJwBGE5uJIr7FcdaRhl4a+56qxoBFf0Z
         Im5NR7P9NIxx/Ev3pKSZQrIYlop8JDvVNKKtT2/tfOQAPHiR5fD+1YnsZDj8PshvlVVG
         IpTMi6aZyJbYnM/XzEB1XKCAqZ/bh19hdLT6fsJ0pvHYefD769UjNor8gaclipP5SW8r
         MnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW5ES4YdcPS0xHu/vs5oZanFJ3jtQ7XZEXRgjUhxkD6Nl4Gn48xVt9OTYkT0dgv4a5yqpWtd4MDoRslQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyTw13mpwvKYVpV+NDdDyfxYArL4WsX7mNhea8rrAlTX4SOHf
	+ujHpR2F2CS9KtCho7lPC6g8hOGujP0Y7hO8jr4EkbkQGFRt/QBvFHPCgqbutb25Ih4nQOGKxgg
	lY03eSnzbOvjNyOsvCQRHcprCn6CGyiKAYnTYy8ZT1M/nZKe5RboM/mI=
X-Google-Smtp-Source: AGHT+IHABU6CUpEMDZoF5MyCkDP5u7UXfJn6S/W02Bb5mB3rEh78QPKW4q4fvhMv3+ex5ea4niUHJZyuMgMCxIQ1ZW/bH8ZaJstR
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39f40f042d4mr4887855ab.1.1725127165814; Sat, 31 Aug 2024
 10:59:25 -0700 (PDT)
Date: Sat, 31 Aug 2024 10:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e93ea70620fe777a@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (3)
From: syzbot <syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109f1425980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=480676efc0c3a76b5214
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87692913ef45/disk-86987d84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a27da6973d7f/vmlinux-86987d84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e28d02ce725/bzImage-86987d84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -2)
WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 do_free_extent_accounting fs/btrfs/extent-tree.c:2972 [inline]
WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 __btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
Modules linked in:
CPU: 1 UID: 0 PID: 63 Comm: kworker/u8:4 Not tainted 6.11.0-rc5-syzkaller-00057-g86987d84b968 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2972 [inline]
RIP: 0010:__btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
Code: e8 24 a4 ae fd 90 0f 0b 90 90 e9 3c f3 ff ff e8 35 80 ec fd 90 48 c7 c7 00 79 2b 8c 44 8b 6c 24 18 44 89 ee e8 00 a4 ae fd 90 <0f> 0b 90 90 4c 8b 24 24 e9 4f f3 ff ff e8 0d 80 ec fd 90 48 c7 c7
RSP: 0018:ffffc900015e6f80 EFLAGS: 00010246
RAX: ec2b4374561a8400 RBX: ffff88805d790001 RCX: ffff888015581e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900015e7150 R08: ffffffff8155b212 R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
R13: 00000000fffffffe R14: 0000000000000000 R15: ffff88805d3be5c8
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3dca9f0270 CR3: 000000002dd02000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1724 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1750 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2015 [inline]
 __btrfs_run_delayed_refs+0x112e/0x4680 fs/btrfs/extent-tree.c:2085
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2197
 btrfs_commit_transaction+0x4be/0x3740 fs/btrfs/transaction.c:2198
 flush_space+0x19c/0xd00 fs/btrfs/space-info.c:835
 btrfs_async_reclaim_metadata_space+0x6dc/0x840 fs/btrfs/space-info.c:1106
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
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

