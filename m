Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA1638BB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 14:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiKYN6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 08:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiKYN6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 08:58:51 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543431B7B9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 05:58:50 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id q197-20020a6b8ece000000b006de79f67604so2090479iod.13
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 05:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxLmPRnEMOWXxTqEqMLcz/EG6V2ngr5o+XbHNKBTT0o=;
        b=C5n86L2oH7xM/9CZJmM5u/oN15FbFGvHWjRHx8QUTcLR11bZwGwIceDDzidXB2PrqF
         66iAF60b7TRdudPCepEtec18Oerq/9z8sf12zEGyFwM+Umg86BBkfjbj+SxZ4ieH/fwr
         e0ywX1aSPleMs0Sh/2uUFM49hwds7SMPQJNYBtGQZcotRh+35Bidp150HiL0haV7RYzE
         /gEqrToxXihAzktF2Z8NYhqdFcEfBZqQt5svRJgSzp4sFDxS8/nmncvWMgFHxr1qER2k
         5H347DgoTYVibm1jcNFf0Bnfpfznh0i8yLEsvcKlpT6nFchAdrUlK2gNio5+Qz77KGrq
         1YwQ==
X-Gm-Message-State: ANoB5pnu1ThFYwRInAi2GmajPH5wnvbiAdK2CYv2e/k05Q3SAw6Xg/1L
        VLdVq2vd6wH0/2k+uudeyjZDbUO4JXHdAmtbWnvwaLkS59Ug
X-Google-Smtp-Source: AA0mqf4phyWtC/wiBj5Hb1QYaJb87VNik3L0oN5gxhky5K+9A9eQVkqAClH9QyjYQimbpDaq4OQ3piko0TrNxCx7qI7CI3XpH/Nk
MIME-Version: 1.0
X-Received: by 2002:a02:6602:0:b0:375:451f:8eb2 with SMTP id
 k2-20020a026602000000b00375451f8eb2mr16521263jac.43.1669384729702; Fri, 25
 Nov 2022 05:58:49 -0800 (PST)
Date:   Fri, 25 Nov 2022 05:58:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ceb65c05ee4beb9d@google.com>
Subject: [syzbot] kernel BUG in __clear_extent_bit
From:   syzbot <syzbot+5338ef8374ed180ba281@syzkaller.appspotmail.com>
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

HEAD commit:    c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1675aebb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=5338ef8374ed180ba281
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103324e3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e7e1c9880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb11fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb11fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c27a26bacb83/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5338ef8374ed180ba281@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:639!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3632 Comm: syz-executor118 Not tainted 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__clear_extent_bit+0xbbb/0xc60 fs/btrfs/extent-io-tree.c:639
Code: 1c 2f fe e9 cf fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 0e ff ff ff 48 89 ef e8 5f 1c 2f fe e9 01 ff ff ff e8 05 04 db fd <0f> 0b e8 fe 03 db fd 48 8b 44 24 08 48 83 c0 08 48 89 c5 48 c1 e8
RSP: 0018:ffffc90003c7f7a8 EFLAGS: 00010293
RAX: ffffffff83af946b RBX: 0000000000000000 RCX: ffff88807de80000
RDX: 0000000000000000 RSI: ffffffff8aedc420 RDI: ffffffff8b4b3ae0
RBP: 0000000000002fff R08: 00000000ffffffff R09: fffffbfff1a42e97
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: 000000000004ffff
R13: ffff88807eb05b40 R14: 1ffff1100fd60b68 R15: 0000000000002000
FS:  0000555557044300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000007e9f2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 try_release_extent_state fs/btrfs/extent_io.c:3391 [inline]
 try_release_extent_mapping+0x4e5/0x560 fs/btrfs/extent_io.c:3487
 __btrfs_release_folio fs/btrfs/inode.c:8175 [inline]
 btrfs_release_folio+0x126/0x340 fs/btrfs/inode.c:8188
 mapping_evict_folio+0x24d/0x570 mm/truncate.c:279
 invalidate_mapping_pagevec+0x37d/0x7c0 mm/truncate.c:528
 btrfs_direct_write fs/btrfs/file.c:1917 [inline]
 btrfs_do_write_iter+0x112e/0x1260 fs/btrfs/file.c:1980
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcc98e18a19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffcb04cad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcc98e18a19
RDX: 0000000000000004 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fffcb04cb00 R08: 0000000000000002 R09: 00007fffcb04cb10
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00007fffcb04cb40 R14: 00007fffcb04cb20 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__clear_extent_bit+0xbbb/0xc60 fs/btrfs/extent-io-tree.c:639
Code: 1c 2f fe e9 cf fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 0e ff ff ff 48 89 ef e8 5f 1c 2f fe e9 01 ff ff ff e8 05 04 db fd <0f> 0b e8 fe 03 db fd 48 8b 44 24 08 48 83 c0 08 48 89 c5 48 c1 e8
RSP: 0018:ffffc90003c7f7a8 EFLAGS: 00010293
RAX: ffffffff83af946b RBX: 0000000000000000 RCX: ffff88807de80000
RDX: 0000000000000000 RSI: ffffffff8aedc420 RDI: ffffffff8b4b3ae0
RBP: 0000000000002fff R08: 00000000ffffffff R09: fffffbfff1a42e97
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: 000000000004ffff
R13: ffff88807eb05b40 R14: 1ffff1100fd60b68 R15: 0000000000002000
FS:  0000555557044300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000007e9f2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
