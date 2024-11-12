Return-Path: <linux-btrfs+bounces-9485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5D9C4D04
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 04:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F0A289F9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 03:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C1206050;
	Tue, 12 Nov 2024 03:04:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F770204F71
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380668; cv=none; b=ubkyubwf3x/yrWOw8EBDRPGGTFPtIy4TY8w/p14GpipV16ZQyeCjSvTJLFqINhfY0+c3AZQ0/HK8sMYsik+QPdP2/NaklXHxrqvEX0lDxNNh94bT5pF1kJlpovsGnN45qEzfP46q6SXJgzTqkSGjXCtSyhPRRgRNLYJok2809O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380668; c=relaxed/simple;
	bh=5E5zoCZfmHG5Vm9xFQpnYhFQgI57hRSIIDLfqT/WB54=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dzPKABxsPIYKpwT5nu0YOonBcd+81At4M0kyKydmC7gZSzYDmMDNgrszNIGHJtuTa1LLKuIeWTB5264R0g/fYz3ITaVZP7PzD0ViI5IOq1hlRNOqV9tjyHZtYRnoQZAccabphPIAMd5y8hjziHkLGXNBbGJ6xQkyfUil4FpXGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso63193295ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 19:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731380665; x=1731985465;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQfs/ir/rcLDEfv4UuYTTRFxsLhvu9ilv5C+meuZdIk=;
        b=q3e/Rw2mkdhL9yMJVNLGDGcU8T8PnSsilbZ22RVJxnBZKUS84cFQtLsA8ziR4KSlp5
         y3+Tl5E554IQZO4CnSv2oA4ug2DUPzI3XvNGLnyKix20ie0EDLNfWUN3oXHTunjgZact
         rNJIEM2v0RsGge84ZUFh2cv05YkcfZLvMGP3tnYX0sYNtiGLSSKRjWV5mWvz/8tiyETm
         jB0ojDGzNPRiYP7gebcRoigM0vTUcaBZBKq+655ViKGwSvtuodDQfCc3MqEy6k/PF/a/
         BCx0ZieksXfrbzgkQSHgZ0CBta5ge3NOJjlpmPjSKzhcpGOOH5lWAjjZ9OEKKqxFrh9T
         PA+w==
X-Forwarded-Encrypted: i=1; AJvYcCW5TJIsrJNFLqlrGI21A4UF7gZPxFFpZa4tUzG+Pwv22r+QIUUTw1a/bMmvtg5myrA+4fpspQeEkAUDPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbgpKKBn8/lCin7kPr2tKQlteh735V2xRTrUTRw/62KxFJXi7
	M6QUADToKxLzM7UXW4AuRa/MCGuc4Ec29oeOxQeCoT7n/xc75eN6PcLfIrZ+T31SO6rHCkiYYz9
	AZU7ZpHnqhubExdAaWB2cfPuSUUWnbE4H5R4aL+TWL7UuYvCjcbrYatk=
X-Google-Smtp-Source: AGHT+IElBI7J4GDNJvBU94uMTqjTbApmid9zVXwv/FIVmUSnO9KB8WFYmTp1OC5O9JiVO/KsMVHjltKoTZoDsuApGyrllXsFWFQ0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c264:0:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a6f1a039damr168406205ab.7.1731380664952; Mon, 11 Nov 2024
 19:04:24 -0800 (PST)
Date: Mon, 11 Nov 2024 19:04:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732c5b8.050a0220.1fb99c.0161.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_lookup_extent_info
From: syzbot <syzbot+c2d0747453b5dddb214a@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    906bd684e4b1 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1267fd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=c2d0747453b5dddb214a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-906bd684.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88c5c4ba7e33/vmlinux-906bd684.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07094e69f47b/bzImage-906bd684.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2d0747453b5dddb214a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5340 at fs/btrfs/extent-tree.c:212 btrfs_lookup_extent_info+0x1011/0x11d0 fs/btrfs/extent-tree.c:212
Modules linked in:
CPU: 0 UID: 0 PID: 5340 Comm: syz.0.0 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_lookup_extent_info+0x1011/0x11d0 fs/btrfs/extent-tree.c:212
Code: 8b ff ff ff 48 8b 7c 24 70 48 c7 c6 2c 9c 13 8e ba ac 00 00 00 b9 8b ff ff ff e8 aa 76 14 08 e9 62 fd ff ff e8 a0 b1 e4 fd 90 <0f> 0b 90 e9 ba fc ff ff 44 89 f1 80 e1 07 38 c1 0f 8c da f0 ff ff
RSP: 0018:ffffc9000d386aa0 EFLAGS: 00010293
RAX: ffffffff83b028c0 RBX: ffffc9000d386ce0 RCX: ffff888000192440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000d386c40 R08: ffffffff83b02575 R09: 1ffff1100864306e
R10: dffffc0000000000 R11: ffffed100864306f R12: ffff88803ead443c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888043218370
FS:  00007f42babdd6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42babdcf98 CR3: 0000000043b68000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 update_ref_for_cow+0x5a4/0x11f0 fs/btrfs/ctree.c:440
 btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
 btrfs_insert_empty_item fs/btrfs/ctree.h:669 [inline]
 insert_with_overflow+0x153/0x400 fs/btrfs/dir-item.c:35
 btrfs_insert_dir_item+0x241/0x640 fs/btrfs/dir-item.c:135
 btrfs_add_link+0x284/0xbe0 fs/btrfs/inode.c:6513
 btrfs_create_new_inode+0x141d/0x1f70 fs/btrfs/inode.c:6451
 btrfs_create_common+0x1d4/0x2e0 fs/btrfs/inode.c:6587
 lookup_open fs/namei.c:3595 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_creat fs/open.c:1508 [inline]
 __se_sys_creat fs/open.c:1502 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1502
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42bb17e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f42babdd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f42bb336130 RCX: 00007f42bb17e719
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f42bb1f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f42bb336130 R15: 00007ffdd4424258
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

