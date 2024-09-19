Return-Path: <linux-btrfs+bounces-8137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58A97CF66
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F705B20F68
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E619CD16;
	Thu, 19 Sep 2024 23:50:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710917C8B
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726789823; cv=none; b=bkCSnqv9q38XIG/xOGXCn/83tjS835zBtFgupcBzHd4wnCm14UpmKOfbyHYM3WWld6Kng8gAlgtvVo/gydKURsMMwslv/E6goH9yq5nGFs+xVhhDFugwTL8PHa65YT7tVGyrLCGQVLWVsUN10jocIDVNn3fMbWGJ1TyU5z919cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726789823; c=relaxed/simple;
	bh=+j+1M7v9BuEbK8mliB7Gv6cMOFzsGBaBok+YVzuUlXk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XJRmNyCmhX/ZR+cH6J/t8x3bRkTfCib86wbLTpAEtk5SaBWV+Ngz9qG8+4lKT8qh/Ds5KZBx4lplLzPnZEr63ZsDCv7sjR3LSVRNGdO+3i5NVnlZDP0mUlqFZUASXsVqRHM2WbGj6fvbkGp90NiVGPJkhFnqhaSrsbb7a+ZCdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa8af04feso165829039f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 16:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726789821; x=1727394621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6FXrxzIyYKClICyjTP1w1uk86Bg0/yZXIYu4nr8pj0=;
        b=llPVTMolGtKa0VFYp+DbeYB04kA4TGSJ+pv3IIDaFDcENaBduWMy65vA3ZXFQWlRRq
         6jrNAw5ik1EZGzOQwAwT7b3dUBljyGtXHWOLl0b7JKECITcinmhV6Zh2f27IcdIoax0J
         3v9X1ireYd0avfBDbFl1I91QMWbMb7QYeTzD3gyegpinSrCyALZ/Da4gX/q05PGZTfKd
         ZsOFw1ILajB0umit4HkUOkTYGCNmtP6lxpGxxXDdvdA7nvusbnlpEgRXgzPLQl9v0f4i
         b71UQj65H8HHjNzl0/1KRV69uRq/z1ETyJVcr95fc9f1YfMtg+lXCPv9RNMuxtt2F9oc
         vffg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZ/AAx/ci+R86D58rAsngrLW/MDmuG8C6wg/d7b7nLcVtv3IyJvawI6bB+LsGMU59XjyZTRKr/WtyKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89prgm2kyuAQUymLwm9eP/fvxHN67ug4XnzDgv5Vsn6BcLgVM
	jV/Dw5yXmuOOIeNpbyYrqRb2PqW4V/l5sxHxR3W8CUIVkCn1lo/11I6YhYl+aHvKeYCY7OZ2axV
	x7jjPkxJgn/lO5Z6jKzlB4OS4pWj/Xo/B0uuetjTawpfsZRRj6IW1GNs=
X-Google-Smtp-Source: AGHT+IEuBFhMjtwjHpyJFM4nz2NyxXrjbKjOKuYzf5j1OYkGGAu6t2cYXDpYUb8zpFIMjtDzPQZhS6gXKsy4zOqnQd03ckw3HDgG
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a0c8cdad80mr12485335ab.15.1726789821036; Thu, 19 Sep 2024
 16:50:21 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:50:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ecb8bd.050a0220.2abe4d.0003.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_create_pending_block_groups (2)
From: syzbot <syzbot+b0643a1387dac0572b27@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10795900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ede797980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c4dd67980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b879ea3b7dd4/disk-d42f7708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/812a7fb7bfcc/vmlinux-d42f7708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/806a22d4adbf/bzImage-d42f7708.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b7ab2abbef2a/mount_0.gz

The issue was bisected to:

commit b2f78e88052bc0bee56bbf646d245fcfb431a873
Author: David Sterba <dsterba@suse.com>
Date:   Thu Jul 22 18:54:37 2021 +0000

    btrfs: allow degenerate raid0/raid10

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fee277980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1401e277980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1001e277980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0643a1387dac0572b27@syzkaller.appspotmail.com
Fixes: b2f78e88052b ("btrfs: allow degenerate raid0/raid10")

BTRFS info (device loop0): balance: start -s
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 5219 at fs/btrfs/block-group.c:2752 btrfs_create_pending_block_groups+0x14f9/0x1710 fs/btrfs/block-group.c:2752
Modules linked in:
CPU: 1 UID: 0 PID: 5219 Comm: syz-executor144 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:btrfs_create_pending_block_groups+0x14f9/0x1710 fs/btrfs/block-group.c:2752
Code: c0 fd 4c 89 f7 be 03 00 00 00 e8 d2 58 d7 00 e9 86 f9 ff ff e8 a8 eb c0 fd 90 48 c7 c7 00 47 2e 8c 44 89 f6 e8 38 0f 83 fd 90 <0f> 0b 90 90 e9 7b fe ff ff e8 89 eb c0 fd 90 48 c7 c7 00 47 2e 8c
RSP: 0018:ffffc900034776a0 EFLAGS: 00010246
RAX: 7f15963a9c8f3600 RBX: ffff88807c9b4001 RCX: ffff88802be1da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003477960 R08: ffffffff8155b292 R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: 0000000000000000
R13: dffffc0000000000 R14: 00000000ffffffe4 R15: ffff8880323c49c0
FS:  00005555919dc380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f46f00c80f8 CR3: 00000000253ae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __btrfs_end_transaction+0x150/0x630 fs/btrfs/transaction.c:1066
 btrfs_inc_block_group_ro+0x648/0x700 fs/btrfs/block-group.c:3043
 btrfs_relocate_block_group+0x440/0xd90 fs/btrfs/relocation.c:4090
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3374
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4158
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4535
 btrfs_ioctl_balance+0x496/0x7d0 fs/btrfs/ioctl.c:3675
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f46f004bae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdde70d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f46f004bae9
RDX: 0000000020000040 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 00007f46f00c45f0 R08: 00005555919dd4c0 R09: 00005555919dd4c0
R10: 0000000000005598 R11: 0000000000000246 R12: 00007ffcdde70da0
R13: 00007ffcdde70fc8 R14: 431bde82d7b634db R15: 00007f46f009401d
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

