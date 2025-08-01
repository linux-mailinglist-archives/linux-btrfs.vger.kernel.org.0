Return-Path: <linux-btrfs+bounces-15791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB1B18783
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08B6AA08B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515128D8F3;
	Fri,  1 Aug 2025 18:56:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6141DDC33
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Aug 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074593; cv=none; b=B9kPY0u4vmcNeURfCz2eGL2ysyhNr4lyeYOV6Js7NV1VKkV+mEY+/o3iVPFYxsxFToJNFJoL6h+ADztK1IxfSLvrUM5eGbjdCjl9/5jJl1ZjHwxkf1gQfwQLZ6OzhOkR7yNaYYk99kYqKfnrsxJ+s/GMa9TraghiIM+oLDMkXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074593; c=relaxed/simple;
	bh=w+uyx2u4tVR4KOFa03FtOQKGG260nLh2xxxVtLd4lOE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hzgMMOiVihC5ASY5AMAaWG9A4VSNwnsRyyFGLMiqzGKgXibdYx84FznPLPK7NNwjIMeOl+kmGBvaFeMiqsRrmn3Ks8N17n+w8dPbE4XIEyVTf8XtTipjauVBLO8oxFCbbnhjWo+cPL3wgpOciO4RFRTrLskNTUlntyW4/k0Eusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c707bfeb6so126134939f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Aug 2025 11:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074591; x=1754679391;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYD0nOQRmQukhL/2Ybf6mOxuk5DEQqvSI9aIA75367k=;
        b=d/dluzQNlg1UAt5VlC8a2qtA3r+QQ3D5JtKFrQEmDT7C67+m0Ah06jJoBoMVwZbrkp
         OXxkFKQMsTdqEd5j2I6jxbqDPDqzmYrUA6i+tM8+euVRqZNIE/GLan9nNMVoJIgSebuD
         JbkYYiT+IAPaQN2lRNVzkAppXs63EfZRooK1iYlRq1w5PosNzPJf8LyxTx5SA0xQ3iUI
         WHth0urg5q03/pvgkbO1YFgbUBAEtC+m6ctOuotyFlHLfioYQSMqiVaTxnLkqAKLMdIk
         BBlZRIi0Nh0wlwLVTTMN5zWmJrh6tQOlkgAU6C22kmfDvMs+Wm7xHTNiVSJ3NI1q+sCw
         5Zvg==
X-Forwarded-Encrypted: i=1; AJvYcCV6TG4JG0UizgrnbcF0oxFEdnMLYqtD/iPUaYnpBge2/WgGdOtWgnpknZ1wLugKSjmnVR7V/e45fWCMvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFRBd7QpFsiYGdK4nmXLwNqiYcq332MpzVNeY/fIvNnSwDyLL
	WHJous32A+YbLbGMvrwpQ8BPLw/uvmhWmCgIE0pe/jIvJLMutgbu/+UM7oANzp7Rn4zYvF7N5MC
	t+OtdiiwFy8QMgnNe6HpIOdmQvwVOcX0Uv8HjCa7/LSKpKueviaC6kWK76NM=
X-Google-Smtp-Source: AGHT+IHL3atBPemYe6B0V5/guJyT0zhR6u/wEoZT73+aXkHpZ5L4pRfTdkaAKrngBclr3hnmj5r8Mk+eOpNbArUNN6W32MnC7UoR
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:3e2:a749:250b with SMTP id
 e9e14a558f8ab-3e41615d149mr9886455ab.14.1754074590865; Fri, 01 Aug 2025
 11:56:30 -0700 (PDT)
Date: Fri, 01 Aug 2025 11:56:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688d0dde.050a0220.f0410.0130.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_lookup_extent_info (2)
From: syzbot <syzbot+c035bce0effd1de39e05@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    038d61fd6422 Linux 6.16
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bd14a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=831eea247244ce8c
dashboard link: https://syzkaller.appspot.com/bug?extid=c035bce0effd1de39e05
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-038d61fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45453fb53a5d/vmlinux-038d61fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4094774b8a7e/bzImage-038d61fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c035bce0effd1de39e05@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5337 at fs/btrfs/extent-tree.c:209 btrfs_lookup_extent_info+0xcc6/0xd80 fs/btrfs/extent-tree.c:209
Modules linked in:
CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_lookup_extent_info+0xcc6/0xd80 fs/btrfs/extent-tree.c:209
Code: 8b ff ff ff 48 8b 7c 24 50 48 c7 c6 31 97 ae 8d ba a9 00 00 00 b9 8b ff ff ff e8 c5 85 6a fd e9 16 fe ff ff e8 0b ee 00 fe 90 <0f> 0b 90 e9 6d fd ff ff e8 dd 44 b0 07 89 d9 80 e1 07 38 c1 0f 8c
RSP: 0018:ffffc9000ddfeea0 EFLAGS: 00010293
RAX: ffffffff83bf4305 RBX: ffff8880363d43b0 RCX: ffff8880118c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000ddff000 R08: ffff8880363d43b3 R09: 1ffff11006c7a876
R10: dffffc0000000000 R11: ffffed1006c7a877 R12: dffffc0000000000
R13: ffff88805325c6d4 R14: 0000000000000000 R15: ffffc9000ddff0c0
FS:  00007fe87d3d46c0(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000453000 CR3: 0000000011d7e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 update_ref_for_cow+0x998/0x1210 fs/btrfs/ctree.c:373
 btrfs_force_cow_block+0x9d4/0x1e10 fs/btrfs/ctree.c:527
 btrfs_cow_block+0x40a/0x830 fs/btrfs/ctree.c:688
 do_relocation+0xd64/0x1610 fs/btrfs/relocation.c:2275
 relocate_tree_block fs/btrfs/relocation.c:2528 [inline]
 relocate_tree_blocks+0x118b/0x1e90 fs/btrfs/relocation.c:2635
 relocate_block_group+0x760/0xd90 fs/btrfs/relocation.c:3607
 btrfs_relocate_block_group+0x966/0xde0 fs/btrfs/relocation.c:4008
 btrfs_relocate_chunk+0x12a/0x3b0 fs/btrfs/volumes.c:3437
 __btrfs_balance+0x1870/0x21d0 fs/btrfs/volumes.c:4212
 btrfs_balance+0xc94/0x11d0 fs/btrfs/volumes.c:4589
 btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3583
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe880f8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe87d3d4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe8811b6080 RCX: 00007fe880f8e9a9
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fe881010d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe8811b6080 R15: 00007ffc53dc1948
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

