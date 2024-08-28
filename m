Return-Path: <linux-btrfs+bounces-7653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE99634DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 00:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488511F26899
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 22:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508801AD3ED;
	Wed, 28 Aug 2024 22:34:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF94158546
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884462; cv=none; b=TdiCzXJ53O72nkyThgmPtRdUYB3PKId0XOqkQ5BYsD10R1h2NmJOc2bu/N0C+Vz9+iA6MO/q7AKgYnF+xgxKBJ2u8epNMzDjGRCHLiSw7p5qt8J1xT0VH0R+xVAIO63o5IwK2EYjNGaI81H6y/RETIVZLP2Eb+h1FP8hlJd/DdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884462; c=relaxed/simple;
	bh=sOQz8kkEi5Ubq+Mjv10jlf6DH/Uax0Bh8eUjBH/cOUo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eWyvajsDqMSpiuiwjda9G9OReou9V+wuiPtaj6qcMnOitJkOqSutHz1bqnkBdEKWvB4ifTwCmpjC//wF+ZnDeHDUA9zk8kBZG+P49UzHjIqIzXDDPPMXCxaiXtQGqZdcLgqiHpz22HwC+Ofm7rezwmQvZfXWWaBVCKsxNQxCfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a13b28f1dso5012439f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 15:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884460; x=1725489260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IjJ2MY54Emt8uSjZEqDveAzp1Pv35o4h28WCyiZ0Io=;
        b=oBgX05+a1DysOYTEpDEbKSLrcrXBcAliFW6vYRfbWKUrmO4H/ojqxzFWgAoKKkC1Zl
         MPENAj2twO7r4HyYJOIjG3CxOlSWk1Lf4iSFo04fo7cWyP+71v5ppILP5INyhhsxE+rX
         dMkZmFajwbqs8GeL7jHMZ/i0iODT045lNtG2xFgrqlCTLsCqoc9vRWaxkBh9cPOotV5L
         fPoO/iKH1ebEmiHB1wxyMlkpEX9q5ns0FCiIOilK2Cm5VfWthEZ96lMQogy4naPuStYd
         B7IxwK/mOPB5Eayoo0QZxnaNDcbfnKLoxmxBextgB+Cjp8HppA3an/MBX90kcA8mP9uB
         Pupw==
X-Forwarded-Encrypted: i=1; AJvYcCUP9LIEyxWpw9zl9NhWqGAqT+FmyUIdpb1HIrvu2K46LDAnoeta5j2tgElx6Q4op+xjroM5EuLuHmaJbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVQlfi86QK3gnrIQPzH5WupJtQyiNbEOPVqFpjtHu1BqDiY/d
	iIoqlHMizbFmHHBKDN3sO4RAC0eNg+InEpegSj9x1ds8m/CZnQgx03DLmbAZEkqoEMhipzlj2Mp
	Fvu+VQmGCtkYc/1QdDiC8aQnva9evIrFxe9zsFkGNZ32rOryFxKIKCvY=
X-Google-Smtp-Source: AGHT+IHDOjRuYWKOInHY9wiI2ox0PvQiiErxuZ+PFgdIYthTmkhgpFsxVcxTm/LxXjxBoM7PrBdFjVzluYZ6hO9nrQdtye/m82hN
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370d:b0:4c0:971d:36b1 with SMTP id
 8926c6da1cb9f-4ced08b2b8dmr15059173.3.1724884460255; Wed, 28 Aug 2024
 15:34:20 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:34:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008851fe0620c5f51c@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, hch@lst.de, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d5fa7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c0273042a898c230e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137c040b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ddb015980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7569f02310fb/disk-d2bafcf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e30fee7b6c1d/vmlinux-d2bafcf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ffddebac153/bzImage-d2bafcf2.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/cd08557ae343/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/90ff8392fe84/mount_2.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/9c5b91850930/mount_7.gz

The issue was bisected to:

commit f22b5dcbd71edea087946511554956591557de9a
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 31 06:04:59 2023 +0000

    btrfs: remove non-standard extent handling in __extent_writepage_io

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10974043980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12974043980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14974043980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com
Fixes: f22b5dcbd71e ("btrfs: remove non-standard extent handling in __extent_writepage_io")

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1488
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1488!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5722 Comm: syz-executor399 Not tainted 6.11.0-rc4-syzkaller-00255-gd2bafcf224f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__extent_writepage_io+0x1224/0x1400 fs/btrfs/extent_io.c:1488
Code: f7 07 90 0f 0b e8 dc 68 df fd 48 c7 c7 e0 92 2c 8c 48 c7 c6 c0 a0 2c 8c 48 c7 c2 80 92 2c 8c b9 d0 05 00 00 e8 9d 15 f7 07 90 <0f> 0b e8 b5 68 df fd 48 8b 3c 24 e8 bc 9d ff ff 48 89 c7 48 c7 c6
RSP: 0018:ffffc900097d6ee8 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: 2f9fd79be1350f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff817402ac R09: 1ffff920012fad7c
R10: dffffc0000000000 R11: fffff520012fad7d R12: ffffea0001ccbdc8
R13: 1ffffd40003997b9 R14: fffffffffffffffd R15: 000000000007b000
FS:  00007f11a84976c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f11a0fff000 CR3: 0000000020e4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __extent_writepage fs/btrfs/extent_io.c:1578 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
 btrfs_writepages+0x12a2/0x2760 fs/btrfs/extent_io.c:2373
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0x120/0x180 mm/filemap.c:448
 btrfs_fdatawrite_range+0x53/0xe0 fs/btrfs/file.c:3794
 btrfs_direct_write+0x558/0xb40 fs/btrfs/direct-io.c:952
 btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11a850bd79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f11a8497158 EFLAGS: 00000212 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f11a85916d8 RCX: 00007f11a850bd79
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f11a85916d0 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000002000 R11: 0000000000000212 R12: 00007f11a85916dc
R13: 000000000000006e R14: 00007ffd9dcad860 R15: 00007ffd9dcad948
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__extent_writepage_io+0x1224/0x1400 fs/btrfs/extent_io.c:1488
Code: f7 07 90 0f 0b e8 dc 68 df fd 48 c7 c7 e0 92 2c 8c 48 c7 c6 c0 a0 2c 8c 48 c7 c2 80 92 2c 8c b9 d0 05 00 00 e8 9d 15 f7 07 90 <0f> 0b e8 b5 68 df fd 48 8b 3c 24 e8 bc 9d ff ff 48 89 c7 48 c7 c6
RSP: 0018:ffffc900097d6ee8 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: 2f9fd79be1350f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff817402ac R09: 1ffff920012fad7c
R10: dffffc0000000000 R11: fffff520012fad7d R12: ffffea0001ccbdc8
R13: 1ffffd40003997b9 R14: fffffffffffffffd R15: 000000000007b000
FS:  00007f11a84976c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005654e2821068 CR3: 0000000020e4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

