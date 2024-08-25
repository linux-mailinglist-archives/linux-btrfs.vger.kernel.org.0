Return-Path: <linux-btrfs+bounces-7480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D89ED95E333
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46896B21340
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20A14B09E;
	Sun, 25 Aug 2024 12:03:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681B13D8BF
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724587407; cv=none; b=JZMDHficee0NG+jDaP/HEq8QIttgQ55Mavtpg2cxnaBKkPMYQ3eFg3lrhdPQySP4yMSXqZpb76IbhBsG01vee50Mmnh42kU/VFo+7DJFq1oHuymyzHkoTxIwCKFADX2RbH2e4U6bkdpZeIW6fD2VkglACPbl7X3dQmAMqogWl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724587407; c=relaxed/simple;
	bh=47CTPFSTrXFPh/XdWhVvqzptUIBnz2Kqbb6zEL/2gss=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xvy2RfoSS7kgWty8eRoSPVWzWMrglaZgRrCVD/9bqwecVeSygprJeheGAsLAPn6oASFAdvCyG8YXvqAonFltKWCVJUfbqCGTS4GNrpW1+ksgCy222myCTWKJHnRQUIeN/KKgYi94E6P+Imcg/TEd1rjJZ24h1MO0KJLiZIRebiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8252a16781eso369731139f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 05:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724587405; x=1725192205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLl5Ha4AdV1gGnFVkiTxn8lS6BFOusF75bZtbPvHigU=;
        b=DdLGylP3gbBExqQXWeh2EReCPpBqG2M6eN2kjJnFfRr5+ti0NS70G+QYAWq5cxaZ+1
         eCDd00QFUr4IHGF2zSbHK+jl4KYSJ+DEa9VjmiU62eQN9IvJNbr/3MQu0OSUc1xdwlSm
         LAOoQdE5W/qaHsicPkZi51nbM4alG7nSKFzCANylG51HBNKobep0z4WZbu3TwrSQRnET
         epYI0Jk7u8dIP5s59fzQ4mNeJBhFWJpzGrsnspJFRlTp+sx0l60u6fjT/viSPPVF8xDG
         6Y+wQcOzMq7e0+MFKjpLD0bg1TzLBbUaUIcdWPIQFSVlLqWGZ09XBzzJT8la5shqvU89
         2Ccw==
X-Forwarded-Encrypted: i=1; AJvYcCULCAVs0LTktzR/WxpttD/RSVc8XNI6ZRpKvlTcjOWZSRMb9p7indQ5NFutEmLa11Q/opxRiehy9aVL1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAEHy3XO0h5+bqUKbDyoghSu7Qciw0f3z20Cyz2HIexrYQi9n
	NzwQHG4BlQTaQP3PPwidqJPQK4kgamWQ4TQG2jlKltKeTPeBJwHmHDUw1WaKC//MiDBVDx7bPXu
	5ZGSinzndpRF9WG0jjfS3BbLSMmRJaJCUnCSVNVy90wBCwNRNiH3Y2GU=
X-Google-Smtp-Source: AGHT+IFfNb9IB0UPcAUqtsXCROsA0CLdRODvZmwB77Tu7S/cXVEzJSpeWi5Cb57LrXuFf3YpscSS/uO0NhalZGbWdeySGAoeDls+
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0a:b0:824:d9e5:6700 with SMTP id
 ca18e2360f4ac-82787386374mr25400139f.4.1724587405096; Sun, 25 Aug 2024
 05:03:25 -0700 (PDT)
Date: Sun, 25 Aug 2024 05:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa486f062080cb5d@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in can_finish_ordered_extent
From: syzbot <syzbot+f88e7f8eca12247510dc@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c79c85875f1a Add linux-next specific files for 20240823
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177d1305980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23bc95d9a9b56fa4
dashboard link: https://syzkaller.appspot.com/bug?extid=f88e7f8eca12247510dc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8bbbc2af33d9/disk-c79c8587.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e25f34cd29db/vmlinux-c79c8587.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c0f92a7043e/bzImage-c79c8587.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f88e7f8eca12247510dc@syzkaller.appspotmail.com

assertion failed: folio->mapping, in fs/btrfs/ordered-data.c:344
------------[ cut here ]------------
kernel BUG at fs/btrfs/ordered-data.c:344!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6196 Comm: syz.0.165 Not tainted 6.11.0-rc4-next-20240823-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:can_finish_ordered_extent+0x754/0x9e0 fs/btrfs/ordered-data.c:344
Code: e9 67 fe ff ff e8 ec 0c db fd 48 c7 c7 40 b1 4c 8c 48 c7 c6 a0 b7 4c 8c 48 c7 c2 00 b1 4c 8c b9 58 01 00 00 e8 2d 4b 03 08 90 <0f> 0b e8 c5 0c db fd 48 c7 c7 40 b1 4c 8c 48 c7 c6 c0 b7 4c 8c 48
RSP: 0018:ffffc900044de910 EFLAGS: 00010046
RAX: 0000000000000040 RBX: dffffc0000000000 RCX: 41dea3a3101c9000
RDX: ffffc90015fb6000 RSI: 0000000000012a7e RDI: 0000000000012a7f
RBP: ffffea00016e4118 R08: ffffffff817452ac R09: 1ffff1101720519a
R10: dffffc0000000000 R11: ffffed101720519b R12: ffff88805e540000
R13: 0000000000000000 R14: ffff88805e540000 R15: ffffea00016e4100
FS:  00007f3e249ff6c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055edd8a65b40 CR3: 000000002044e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_finish_ordered_extent+0x140/0x480 fs/btrfs/ordered-data.c:410
 end_bbio_data_write+0x4bd/0x750 fs/btrfs/extent_io.c:476
 __btrfs_bio_end_io fs/btrfs/bio.c:116 [inline]
 btrfs_orig_bbio_end_io+0x3ba/0x470 fs/btrfs/bio.c:162
 btrfs_submit_chunk fs/btrfs/bio.c:756 [inline]
 btrfs_submit_bio+0x11fc/0x1940 fs/btrfs/bio.c:775
 submit_one_bio+0x115/0x1c0 fs/btrfs/extent_io.c:120
 submit_extent_folio+0xad3/0xe90
 submit_one_sector fs/btrfs/extent_io.c:1315 [inline]
 __extent_writepage_io+0x84e/0xc90 fs/btrfs/extent_io.c:1391
 __extent_writepage fs/btrfs/extent_io.c:1457 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2125 [inline]
 btrfs_writepages+0x1132/0x22a0 fs/btrfs/extent_io.c:2251
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 filemap_fdatawrite_range+0x11a/0x180 mm/filemap.c:449
 btrfs_fdatawrite_range fs/btrfs/file.c:3778 [inline]
 start_ordered_ops fs/btrfs/file.c:1546 [inline]
 btrfs_sync_file+0x31d/0x10f0 fs/btrfs/file.c:1623
 generic_write_sync include/linux/fs.h:2850 [inline]
 btrfs_do_write_iter+0x5e2/0x760 fs/btrfs/file.c:1498
 do_iter_readv_writev+0x609/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e24f79e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e249ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f3e25115f80 RCX: 00007f3e24f79e79
RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000006
RBP: 00007f3e24fe793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3e25115f80 R15: 00007ffda8678c38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:can_finish_ordered_extent+0x754/0x9e0 fs/btrfs/ordered-data.c:344
Code: e9 67 fe ff ff e8 ec 0c db fd 48 c7 c7 40 b1 4c 8c 48 c7 c6 a0 b7 4c 8c 48 c7 c2 00 b1 4c 8c b9 58 01 00 00 e8 2d 4b 03 08 90 <0f> 0b e8 c5 0c db fd 48 c7 c7 40 b1 4c 8c 48 c7 c6 c0 b7 4c 8c 48
RSP: 0018:ffffc900044de910 EFLAGS: 00010046
RAX: 0000000000000040 RBX: dffffc0000000000 RCX: 41dea3a3101c9000
RDX: ffffc90015fb6000 RSI: 0000000000012a7e RDI: 0000000000012a7f
RBP: ffffea00016e4118 R08: ffffffff817452ac R09: 1ffff1101720519a
R10: dffffc0000000000 R11: ffffed101720519b R12: ffff88805e540000
R13: 0000000000000000 R14: ffff88805e540000 R15: ffffea00016e4100
FS:  00007f3e249ff6c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055edd8a65b40 CR3: 000000002044e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

