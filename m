Return-Path: <linux-btrfs+bounces-5907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB580913C76
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7876A1C214AF
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3581822D2;
	Sun, 23 Jun 2024 15:39:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A063D
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157165; cv=none; b=Y+ew8MtkFKlg0EA5hHSZ9nVMPb0htmj6tcP4k+xyfsjBkUXNodL+/IJu5K4AYCmiT4IT8yG2qUGfGLTWr0vVTJY0iILIrFxDKqwiUVn2P8gpihzpcdw71k2N7d2SvV1kXOKr7EjHRon2GmF8OsW7/5GWZdk0ACVHnhCIs2SUUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157165; c=relaxed/simple;
	bh=9yvW496ZCme6R+fZtQRf/kUwwW4daBGCaWiUQoZh6F0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gz9s2uhtpA5oJD2+3rjnFeS61caa6Fy+ZQk0kx51gTfggRDGL5TZ0x10Ld/FrTfGYlSg8/LoO/xJwmchkDoVQxkyNqBLTdrEZNENqxBbAvwB8FJKh3v/WYH0QFc1tILHavPOPyqCWhNFuzh4dT3bMavLlMVIvHfMakeN43ffB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7f3aaf60267so79862039f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 08:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719157163; x=1719761963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qX0mbmMVdwwRBSjq+pId2i9t9BOsQ2Jv1qsuM3/Mq0=;
        b=JxxqCnoBbTqVKej5f4PJyaZ5io9XJ8fgc23kvUkW+ABbEoiAU8HOeyuMz9fnUa06cj
         iXXPejq+14zuJULdcqcQNvNI5RPHjyElMD6IAzQ8wnlP1cAvML1wg4VRVXNtN1rs4FvV
         nzjcR92EqHHo1k4zL2VY0FHEyLLtwbmhbjHyXrlW275iX83STtBRZrB/I88HiOBI8SAk
         yEqljzwlf4V4bdG8kC6xoNPZb6w043re+sNrXUlEqaCrToi0RxtOBsJ8fuHaIBL/Hu6/
         o48qnmWtIqAFgx5JPT5LbniuKc1dGKhLszdYT/cgh6oRCiy/zqVuzel4USfWZkAKUrfO
         UrpA==
X-Forwarded-Encrypted: i=1; AJvYcCU1TfxfgebLhiFYk81MerRWTustbbiv1eW375CEqLEY4uKQS9ZrPpHgafBbOjGVCR/dt7zQKUsUNTuYoiX1F4ys6eRwDY3xvWUZGHs=
X-Gm-Message-State: AOJu0Yz3TnXT5nOEjfW03ivkspTXE/zEWBY5MbJY9YqOgyclXlQ0y/8c
	XnHTAfyyVOHwzjYVhGfdADc3/wedV0A9axCtQRF1DHtbIVenWvef1OlF4VDG8YlA5pmW8biXN18
	2gJE5tghvzbY6xBw0gpw5+lNcTnuWDOP96TaPcH1eoOxymPkua6qjddg=
X-Google-Smtp-Source: AGHT+IFMhq+CUdJ2xePyAMUNdR+dlZhrqKJzPpu4IjU7l1KNu8636+sSjS03avDDykjemMlOxJCW1y+KGX00/zZ81FojbVxbtNCr
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8711:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4b9e7f27f5amr148607173.6.1719157163497; Sun, 23 Jun 2024
 08:39:23 -0700 (PDT)
Date: Sun, 23 Jun 2024 08:39:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b2e35061b9078aa@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (2)
From: syzbot <syzbot+fe3566bcb509ae7764ef@syzkaller.appspotmail.com>
To: boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10aed446980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=fe3566bcb509ae7764ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ebe941980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1374b3de980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35e32e9073a7/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6e34658d16/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4417e7ef76ed/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b1cd2f1f0c7e/mount_0.gz

The issue was bisected to:

commit cecbb533b5fcec4ff77e786b7f94457f6cacd9e7
Author: Boris Burkov <boris@bur.io>
Date:   Wed Jun 28 18:00:15 2023 +0000

    btrfs: record simple quota deltas in delayed refs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a47be2980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a47be2980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a47be2980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe3566bcb509ae7764ef@syzkaller.appspotmail.com
Fixes: cecbb533b5fc ("btrfs: record simple quota deltas in delayed refs")

BTRFS: Transaction aborted (error -2)
WARNING: CPU: 0 PID: 5085 at fs/btrfs/extent-tree.c:2984 do_free_extent_accounting fs/btrfs/extent-tree.c:2984 [inline]
WARNING: CPU: 0 PID: 5085 at fs/btrfs/extent-tree.c:2984 __btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3358
Modules linked in:
CPU: 0 PID: 5085 Comm: syz-executor845 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2984 [inline]
RIP: 0010:__btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3358
Code: e8 64 b0 b0 fd 90 0f 0b 90 90 e9 3c f3 ff ff e8 b5 81 ee fd 90 48 c7 c7 00 2e 0b 8c 44 8b 6c 24 18 44 89 ee e8 40 b0 b0 fd 90 <0f> 0b 90 90 4c 8b 24 24 e9 4f f3 ff ff e8 8d 81 ee fd 90 48 c7 c7
RSP: 0018:ffffc9000352f220 EFLAGS: 00010246
RAX: 7e1377ca92db5900 RBX: ffff888024e3c001 RCX: ffff88807c1f0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000352f3f0 R08: ffffffff81585742 R09: fffffbfff1c39994
R10: dffffc0000000000 R11: fffffbfff1c39994 R12: dffffc0000000000
R13: 00000000fffffffe R14: 0000000000000000 R15: ffff888063a8b5c8
FS:  000055556fa3c3c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005648b40a4798 CR3: 0000000023a7e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1736 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1762 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2027 [inline]
 __btrfs_run_delayed_refs+0x117c/0x4670 fs/btrfs/extent-tree.c:2097
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2209
 btrfs_commit_transaction+0xf5d/0x3740 fs/btrfs/transaction.c:2400
 sync_filesystem+0x1c8/0x230 fs/sync.c:66
 generic_shutdown_super+0x72/0x2d0 fs/super.c:621
 kill_anon_super+0x3b/0x70 fs/super.c:1226
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x273/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda22d8de67
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffaba15888 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fda22d8de67
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffaba15940
RBP: 00007fffaba15940 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007fffaba16a00
R13: 000055556fa3d700 R14: 431bde82d7b634db R15: 00007fffaba169a4
 </TASK>


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

