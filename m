Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E85600521
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 04:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJQCQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Oct 2022 22:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJQCPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Oct 2022 22:15:42 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2E13CE6
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 19:15:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u11-20020a6b490b000000b006bbcc07d893so6139135iob.9
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 19:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vwbkybJWrGsS7YZXJVFWPDniBFmiMMRdh0Bjsc3Kyk=;
        b=kPpvuSa+oiH6N7KjuGIGy8LszQ3sAnvP7PIxDSC+EUxQE62+LUQKJPCcTLMil+A1vh
         irFkXwCpVTeO4DNqeXgwz6TcdQUAbmiHXeqh9f90nNCKnhdztLknJJqRnlWSuCf5Luwj
         oDW8HQLfnW5/ci0zGHaZvl/c71l9OOQGKcpHdVdUPkrm+iqLjFBhPF2ZoaHH+893VtK5
         tBaYaj5oDwOZYqgQKHxmZCBJxq2ZvjfcpAIlrlDFFmDmvI608k4Y7ojnjYAgkJRWQvVY
         LFJwPyoHePTLqJXvgdubVL0k92Q9i7VPFEr+WGgmV3wjQFzAbYOn2Ha4tyGH5TrKijyy
         LNeg==
X-Gm-Message-State: ACrzQf2qjEtcyCQGbNJ122T4jn/khH/B797DTWx3UujqI695Jxuq82WU
        7GDHUynX6rhjQcBB+rL8hoZTt1FYGnTAxTBEBacXxs+Ojl5Q
X-Google-Smtp-Source: AMsMyM6/K6c4fM4fHieiipAxOjZXX23rcJbWKfm8ucPMCc2F4Yq7ycNV08Zr0Tv2MP7dNs5T9Ts+jq3TM+f8eFbxuLD1fwt9Qgf/
MIME-Version: 1.0
X-Received: by 2002:a02:664f:0:b0:363:3786:c552 with SMTP id
 l15-20020a02664f000000b003633786c552mr4334811jaf.108.1665972940046; Sun, 16
 Oct 2022 19:15:40 -0700 (PDT)
Date:   Sun, 16 Oct 2022 19:15:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c06c405eb318db4@google.com>
Subject: [syzbot] WARNING in btrfs_run_delayed_refs
From:   syzbot <syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com>
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1249e73a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=ebdb2403435c4136db2b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f1fa2c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119fcd62880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/17b7c308ee18/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
BTRFS: Transaction aborted (error -12)
WARNING: CPU: 0 PID: 3628 at fs/btrfs/extent-tree.c:2141 btrfs_run_delayed_refs+0x450/0x4a0 fs/btrfs/extent-tree.c:2141
Modules linked in:
CPU: 0 PID: 3628 Comm: syz-executor264 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:btrfs_run_delayed_refs+0x450/0x4a0 fs/btrfs/extent-tree.c:2141
Code: 48 8b 38 48 c7 c6 40 17 da 8a 89 ea 31 c0 e8 39 2a a8 06 eb 19 e8 f0 88 0a fe 48 c7 c7 40 16 da 8a 89 ee 31 c0 e8 50 ed d2 fd <0f> 0b b3 01 44 0f b6 c3 4c 89 e7 48 c7 c6 60 19 da 8a ba 5d 08 00
RSP: 0018:ffffc90003e1f970 EFLAGS: 00010246
RAX: e42d7aab60647100 RBX: ffff88807851c001 RCX: ffff888028165880
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000fffffff4 R08: ffffffff816aa79d R09: ffffed1017344f13
R10: ffffed1017344f13 R11: 1ffff11017344f12 R12: ffff88807005d1f8
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888075537000
FS:  0000555555605300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd693f62130 CR3: 000000001c70d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x3a9/0x3760 fs/btrfs/transaction.c:2123
 btrfs_ioctl_set_fslabel+0x2c4/0x340 fs/btrfs/ioctl.c:5025
 btrfs_ioctl+0x9de/0xc10 fs/btrfs/ioctl.c:5435
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd693ee9f49
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa2f7a7a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fd693ee9f49
RDX: 0000000020000980 RSI: 0000000041009432 RDI: 0000000000000004
RBP: 00007fffa2f7a7d0 R08: 0000000000000001 R09: 00007fffa2f7a7e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 00007fd693f326b8 R14: 00007fd693f32950 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
