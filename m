Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7F63D03B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Nov 2022 09:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiK3IQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Nov 2022 03:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiK3IQo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Nov 2022 03:16:44 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C474152895
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 00:16:43 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id n8-20020a056e021ba800b00302c73f42d9so14449318ili.8
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 00:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ia1ggW+CohV0hM6g6vlRES5+xm4wz+/jHYfjyKI2m+U=;
        b=cDbzp9CD9KDQw0bNCLchytt31V0HW7QrSNPK8uEOp7qaLCWZQ1iNjF2RrKy8hE7j+F
         Gzhj9GJEoe7Qz/S87OhukDzJ+TjyjS/E91xhLFFpVwkxigAf5s3lNxLjwSfiulb3+hXQ
         BKJjnFzJYWZBz6n7N3lmcgOQq5zN7QFt29PBZZYsXgO9ZoArfEM8StC9rZkmu3iWkBUU
         GdPXp2Fu0D1PEjhs2VuUIR0tJhQd9YmMMugWqKqBBw00ZDAG+JK6tJv3ks+intliS9db
         rLjyoVQHL4ln/bFWrWmVdvwtOcgHSYHrkLgloNC7lVkqalx1PFgP8eyhzT3Dp15K1T+c
         CdqA==
X-Gm-Message-State: ANoB5pm7fTsbpFD8+pGdbDaiS/MoqymjFA9w34GAWc2+0/Dw9kO6Ow9u
        RrxHbLKUhYZq+rJQ3IRUGfW0LgU+zkGKtCD6AmTGvBDAQ3Og
X-Google-Smtp-Source: AA0mqf5AszZ02rsX9E++seylfB/ee8zWgLjyoO1uX2F/8x9XTx8qXsGj35oL6xHbPli3SYxBaZXMLxsgP0Gj006qUw5dSwoZsOeN
MIME-Version: 1.0
X-Received: by 2002:a02:880b:0:b0:363:d7b3:7d4 with SMTP id
 r11-20020a02880b000000b00363d7b307d4mr19476634jai.166.1669796203166; Wed, 30
 Nov 2022 00:16:43 -0800 (PST)
Date:   Wed, 30 Nov 2022 00:16:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089839605eeabb948@google.com>
Subject: [syzbot] WARNING in btrfs_remove_chunk
From:   syzbot <syzbot+e8582cc16881ec70a430@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ca57f02295f1 afs: Fix fileserver probe RTT handling
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e3bf8d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13152047880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1491a7fd880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af66f1d3a389/disk-ca57f022.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0c7ec393108/vmlinux-ca57f022.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea8871940eaa/bzImage-ca57f022.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4b0128811f09/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8582cc16881ec70a430@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -s
BTRFS info (device loop0): relocating block group 1048576 flags system
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4053 at fs/btrfs/volumes.c:3175 btrfs_remove_chunk+0x16c9/0x17f0 fs/btrfs/volumes.c:3175
Modules linked in:
CPU: 1 PID: 4053 Comm: syz-executor367 Not tainted 6.1.0-rc7-syzkaller-00012-gca57f02295f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:btrfs_remove_chunk+0x16c9/0x17f0 fs/btrfs/volumes.c:3175
Code: 8b 44 89 f6 31 c0 e8 f6 5c bf fd 0f 0b b3 01 e9 be fd ff ff e8 28 be f7 fd 48 c7 c7 60 da 39 8b 44 89 f6 31 c0 e8 d7 5c bf fd <0f> 0b b3 01 e9 bb fd ff ff 44 89 e9 80 e1 07 38 c1 0f 8c 58 fe ff
RSP: 0018:ffffc900049ff8e0 EFLAGS: 00010246
RAX: 6006f843c165f400 RBX: ffff88801e194001 RCX: ffff8880752d57c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900049ffab0 R08: ffffffff816e560d R09: ffffed1017324f1c
R10: ffffed1017324f1c R11: 1ffff11017324f1b R12: ffff88802787a600
R13: ffff8880756eb690 R14: ffffffffffffffe4 R15: dffffc0000000000
FS:  00007f54b37a1700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe4bdea9c0 CR3: 0000000026c6e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_relocate_chunk+0x24b/0x350 fs/btrfs/volumes.c:3298
 __btrfs_balance+0x1dbf/0x2960 fs/btrfs/volumes.c:3990
 btrfs_balance+0xbfc/0x1140 fs/btrfs/volumes.c:4373
 btrfs_ioctl_balance+0x478/0x780 fs/btrfs/ioctl.c:4484
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54b37f5ed9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54b37a12f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f54b38807a0 RCX: 00007f54b37f5ed9
RDX: 0000000020000480 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f54b384d28c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 8000000000000000
R13: 697265765f666572 R14: 0030656c69662f2e R15: 00007f54b38807a8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
