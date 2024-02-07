Return-Path: <linux-btrfs+bounces-2204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BC84C675
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865CB1C21940
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB921A19;
	Wed,  7 Feb 2024 08:43:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808220B11
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295406; cv=none; b=B+5jMktzk8oubxP442ZcEI/RE4tmlVgsMeMDmiWMF6Phtv1WxVbcM0I+Q7SMzZDV2bJrmX4/5UkENKt7D4EhZP4qCw62lCSTndWsaQcAcXRoXwK298M5iduhl2cA2syRK0v63KnMIXqPDspYrqcL7unyfcyWV4FrbrIVnREO3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295406; c=relaxed/simple;
	bh=m7YzNhGTx8EdreLaLQv6WahRGcqBsoyLRaNgx5AIeZ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UFk1KizZQOivIA0DvqJrpBTptRqwkF8ZlEyfRwqzHkuM1EO3jNL9MrCFSF9w11jWcJD/OgRi1UURvdrBXM/6r47bdwi+GDjjFfcQqERI6vJUihUKVANzej5lMEseE2iBgoSr/rC8bePNTGPbQevk1gwHbD5YW3jOTvD2OW8y1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363da08fc19so2449915ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Feb 2024 00:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295402; x=1707900202;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cHzaOQQcEQytKXWs8H9MBprsiLU/8XFqHbQYiJ3eXY=;
        b=tryH7A0BrtmBPGJF//vN1rAAce5zYArGs+dmh7nQgV7J2p17aA5nqcznOHHO2xM6RW
         1dvvDfM5bSCx38eB/vQr9KItfe2vpMVdAZnejm3IddIyavT4JLhlJX5hHJjresaac1og
         6/pM+5CBgIMlXLaToKkmjTDHtcbhvH5ehqi5nK3I7J4R1RwOEvsEDZldnkKL/qlCsEhK
         D5fA1kdg9X1ZhEadYcajK6O3H616hr8Hvp2FlJi2PPVOg/xgA32HYSCdFJZFzuq8vYaV
         i+ER7SVv6yqBKks6SurJgUNI/BxYnVrPfLxsJvApHpl9DCLGqV3/X+/Q3hCZtNT7jAZU
         xnzw==
X-Forwarded-Encrypted: i=1; AJvYcCUlJtaIn4DkCpEnFBSKlb+ivfQYrI6GZtlHYm72z5GpwtPQt0vrRCy3akxFBzpyBvkdOw/VUq9OY3U09MjOJFVryS30GSrNkuT/3js=
X-Gm-Message-State: AOJu0YyvtSUo+qUx5pG0+UnZqjWSMYw5Q/98OxRp91PcyEBY25AaB5Kf
	zRHTvM1Z7haOvDmm2AhlGtS6nrxSIM3BVltPuHvAc8T1J/GCC86s6oclFGqx7HfTpyg0NWdzMzT
	4NwW8dmrQdB/+qLnjdJAAgtNTicJGCkNYO5AL/aTJ7rlKL/L/cDy58cM=
X-Google-Smtp-Source: AGHT+IEj7C7Vt1p1cSPScjHI5tRVGFIaP0qrsOagSmyFMRsP4RHKwDPuTJ1XpcZRXkl1bJqWyi7Z42gV4tVHlu9ywtqq85SNrmxR
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:363:b5e3:1082 with SMTP id
 m15-20020a056e021c2f00b00363b5e31082mr284357ilh.4.1707295402015; Wed, 07 Feb
 2024 00:43:22 -0800 (PST)
Date: Wed, 07 Feb 2024 00:43:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6c32a0610c6af48@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in mapping_try_invalidate
From: syzbot <syzbot+e017b58b47bacf31a06b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99bd3cb0d12e Merge tag 'bcachefs-2024-02-05' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16629540180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=e017b58b47bacf31a06b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73aa72bd3577/disk-99bd3cb0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6bf1614995/vmlinux-99bd3cb0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7df252d11788/bzImage-99bd3cb0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e017b58b47bacf31a06b@syzkaller.appspotmail.com

 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
------------[ cut here ]------------
kernel BUG at mm/filemap.c:2072!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 16388 Comm: syz-executor.2 Not tainted 6.8.0-rc3-syzkaller-00005-g99bd3cb0d12e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:find_lock_entries+0xfdf/0x1110 mm/filemap.c:2071
Code: e8 96 4d cb ff eb 2a e8 8f 4d cb ff eb 3a e8 88 4d cb ff eb 4a e8 81 4d cb ff 4c 89 f7 48 c7 c6 a0 41 b3 8b e8 32 0f 10 00 90 <0f> 0b e8 6a 4d cb ff 4c 89 f7 48 c7 c6 a0 4b b3 8b e8 1b 0f 10 00
RSP: 0018:ffffc90013457520 EFLAGS: 00010246
RAX: f6dc7e6d18066c00 RBX: 0000000000000000 RCX: ffffc90013457303
RDX: 0000000000000002 RSI: ffffffff8baac6e0 RDI: ffffffff8bfd93e0
RBP: ffffc90013457670 R08: ffffffff8f842b6f R09: 1ffffffff1f0856d
R10: dffffc0000000000 R11: fffffbfff1f0856e R12: ffffc900134575c0
R13: ffffffffffffffff R14: ffffea0000b3c100 R15: ffffea0000b3c134
FS:  00007f60b3b6e6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056197e1c4648 CR3: 000000007d35c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mapping_try_invalidate+0x162/0x640 mm/truncate.c:499
 open_ctree+0xa9c/0x2a00 fs/btrfs/disk-io.c:3220
 btrfs_fill_super fs/btrfs/super.c:940 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1860 [inline]
 btrfs_get_tree+0xe7a/0x1920 fs/btrfs/super.c:2086
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 fc_mount+0x1b/0xb0 fs/namespace.c:1125
 btrfs_get_tree_subvol fs/btrfs/super.c:2049 [inline]
 btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2087
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f60b2e7f4aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60b3b6def8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f60b3b6df80 RCX: 00007f60b2e7f4aa
RDX: 00000000200051c0 RSI: 0000000020005200 RDI: 00007f60b3b6df40
RBP: 00000000200051c0 R08: 00007f60b3b6df80 R09: 0000000001000008
R10: 0000000001000008 R11: 0000000000000202 R12: 0000000020005200
R13: 00007f60b3b6df40 R14: 00000000000051ab R15: 0000000020000280
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_lock_entries+0xfdf/0x1110 mm/filemap.c:2071
Code: e8 96 4d cb ff eb 2a e8 8f 4d cb ff eb 3a e8 88 4d cb ff eb 4a e8 81 4d cb ff 4c 89 f7 48 c7 c6 a0 41 b3 8b e8 32 0f 10 00 90 <0f> 0b e8 6a 4d cb ff 4c 89 f7 48 c7 c6 a0 4b b3 8b e8 1b 0f 10 00
RSP: 0018:ffffc90013457520 EFLAGS: 00010246
RAX: f6dc7e6d18066c00 RBX: 0000000000000000 RCX: ffffc90013457303
RDX: 0000000000000002 RSI: ffffffff8baac6e0 RDI: ffffffff8bfd93e0
RBP: ffffc90013457670 R08: ffffffff8f842b6f R09: 1ffffffff1f0856d
R10: dffffc0000000000 R11: fffffbfff1f0856e R12: ffffc900134575c0
R13: ffffffffffffffff R14: ffffea0000b3c100 R15: ffffea0000b3c134
FS:  00007f60b3b6e6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555ac9938 CR3: 000000007d35c000 CR4: 00000000003506f0
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

