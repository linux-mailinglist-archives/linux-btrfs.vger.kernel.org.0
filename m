Return-Path: <linux-btrfs+bounces-6648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A39396D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36BDB21927
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 23:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667684C622;
	Mon, 22 Jul 2024 23:08:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B2376E7
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689711; cv=none; b=CO+tDeyl0u9WSPNicMUKJy0BvNawDluo6lmequh7/iH3bLTDIMwx/dpEDDPobW7sdZzJJaQ4aKsWTMNtszQ5nCrRqnUUiX+k2imI/V4cBFFQoaox001MwGz1y5tBHWQCY/+AULJnoRSGXze4j/vgfejKEiZSep6sdfIGJAQkddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689711; c=relaxed/simple;
	bh=rwGIutc2zYh2Gaz+gc6mt86fq0/d0gQib+xjJM/qH9w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rCvov7fC1QbPxt1cnVE446Wd7UVBWTJoqRaJ3+1omVl/LFTA5HI8hQZFpeEmUoPtQseJViMtfT1QVRKP6jJ9wSeUrdUXqF9VxxsMKIl9t0yPmfE/dUBHohTTQejYJrh3ax6gefnNPSDSJb3N3N76Bv2yY2TC28D++dXaWTPT4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39945779edaso33264745ab.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 16:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721689709; x=1722294509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8DSqv9G7o9mnNghAnNmvOA6qRTWCX+Wd6Im/3V6HNE=;
        b=ow+O21Hla71ErKn3U7MXuQ9DzU91pLpmr+5dXGBu9QvO54+BhOOR63EQJ3fYmcxsfb
         twdtbr8h4QzKmww/1/9bCp9+CsQbcnAFZDraAYuMQdN8gJawiNkXuYWbiZwfDxCnLSfB
         1axlVR97xCeZV4NnLF32sI9H70uokFPmP46Ue8P8exKLhR+W7G+82I3rZ47+8g+WTsJu
         BNQrH87SIOZDxPvNtG8Tbn2WYntZy6d2GKqXjjii+sRu5+WpN7QEMXutmbaz4DRvFu5o
         CiNsKNi788bRiuJJN2EpsdbhSyBH2I9cgkGXij4FeRjsPCH5WOknGqqh2ba+XH9PU/jb
         TLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUEp5olH36oZDgEMHry0Ltvcd6zX4pSJwyU6Xu58NYmH9EsYWSShijIQGqez7S/qT8wEThNRQ1odg8hj4Ws4dkhZ2HPYj4qq8BFGA=
X-Gm-Message-State: AOJu0Yzb0HaW/jI2P1B94ZeyAGmfkUBFGZIQcygOKIMM9/xIhGcjX6nX
	6ksj5IbYOhKiPdNtRBUiIoFI5VQDOJVrB2sao0r8/vZXUsRYUaV9DX+kkLwYIBbHpzhi0B3Naxu
	D6EWltf8r5lrn6VYwOTtvi1vw3uw/xSTbpg2wFw0OD+A7Ircq2Ujzt4c=
X-Google-Smtp-Source: AGHT+IEf4KHTuU6VvAnEQKQ1PLhTyb0ITUAoncEWt4+1jOcJjdrO3LQ+Lchue1DbsJMd1dKu2tco5hfaJofFIaXUfWo9hJMauSl+
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-398e7633dfdmr7842055ab.4.1721689709380; Mon, 22 Jul 2024
 16:08:29 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:08:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a971a061dde1f74@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
From: syzbot <syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, johannes.thumshirn@wdc.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1bc554e009e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f02349980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65e004fdd6e65e46
dashboard link: https://syzkaller.appspot.com/bug?extid=a14d8ac9af3a2a4fd0c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11656f2d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cd1179980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e6d5d2330c1/disk-b1bc554e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f753d2415c93/vmlinux-b1bc554e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80bbcb43a23d/bzImage-b1bc554e.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/17f63396bdfd/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/df45c13c09ac/mount_5.gz

The issue was bisected to:

commit 0586d0a89e77d717da14df42648ace4a9fd67981
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Mar 20 21:24:13 2024 +0000

    btrfs: move extent bit and page cleanup into cow_file_range_inline

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1653443d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1553443d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1153443d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
Fixes: 0586d0a89e77 ("btrfs: move extent bit and page cleanup into cow_file_range_inline")

BTRFS: error (device loop0 state EAL) in free_log_tree:3267: errno=-5 IO failure
BTRFS warning (device loop0 state EAL): Skipping commit of aborted transaction.
BTRFS: error (device loop0 state EAL) in cleanup_transaction:2018: errno=-5 IO failure
assertion failed: folio_test_locked(folio), in fs/btrfs/subpage.c:871
------------[ cut here ]------------
kernel BUG at fs/btrfs/subpage.c:871!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5090 Comm: syz-executor225 Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:btrfs_folio_end_all_writers+0x55b/0x610 fs/btrfs/subpage.c:871
Code: e9 d3 fb ff ff e8 25 22 c2 fd 48 c7 c7 c0 3c 0e 8c 48 c7 c6 80 3d 0e 8c 48 c7 c2 60 3c 0e 8c b9 67 03 00 00 e8 66 47 ad 07 90 <0f> 0b e8 6e 45 b0 07 4c 89 ff be 08 00 00 00 e8 21 12 25 fe 4c 89
RSP: 0018:ffffc900033d72e0 EFLAGS: 00010246
RAX: 0000000000000045 RBX: 00fff0000000402c RCX: 663b7a08c50a0a00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900033d73b0 R08: ffffffff8176b98c R09: 1ffff9200067adfc
R10: dffffc0000000000 R11: fffff5200067adfd R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001cbee80
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f076012f8 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __extent_writepage fs/btrfs/extent_io.c:1597 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
 btrfs_writepages+0x14d7/0x2760 fs/btrfs/extent_io.c:2373
 do_writepages+0x359/0x870 mm/page-writeback.c:2656
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_flush+0xdf/0x130 mm/filemap.c:463
 btrfs_release_file+0x117/0x130 fs/btrfs/file.c:1547
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:222
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:877
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1037 [inline]
 __se_sys_exit_group kernel/exit.c:1035 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f075b70c9
Code: Unable to access opcode bytes at 0x7f5f075b709f.
RSP: 002b:00007ffd1c3f9a58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f075b70c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f5f07638390 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5f07638390
R13: 0000000000000000 R14: 00007f5f07639100 R15: 00007f5f07585050
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_folio_end_all_writers+0x55b/0x610 fs/btrfs/subpage.c:871
Code: e9 d3 fb ff ff e8 25 22 c2 fd 48 c7 c7 c0 3c 0e 8c 48 c7 c6 80 3d 0e 8c 48 c7 c2 60 3c 0e 8c b9 67 03 00 00 e8 66 47 ad 07 90 <0f> 0b e8 6e 45 b0 07 4c 89 ff be 08 00 00 00 e8 21 12 25 fe 4c 89
RSP: 0018:ffffc900033d72e0 EFLAGS: 00010246
RAX: 0000000000000045 RBX: 00fff0000000402c RCX: 663b7a08c50a0a00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900033d73b0 R08: ffffffff8176b98c R09: 1ffff9200067adfc
R10: dffffc0000000000 R11: fffff5200067adfd R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001cbee80
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f076012f8 CR3: 000000000e134000 CR4: 00000000003506f0
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

