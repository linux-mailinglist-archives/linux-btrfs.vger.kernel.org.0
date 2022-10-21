Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BD606F05
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJUEps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 00:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJUEpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 00:45:46 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66F155DB1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 21:45:41 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a17-20020a921a11000000b002fadf952565so2260640ila.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 21:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lb/knrwJcvc4TpWJc1KQA7sNbZt1oKWE8AfVeW6LmRw=;
        b=HroCBz0wHf5mJGyy1g7lHzjUjnRGQpON+oT1YR1eqZ4sCoItmxKHCLeUtV/7LQa5yz
         Fco9Ax4s50SqBjjYEC2pNTq7s1mXgOU3ZZ2rU056h4ZRRAcY89YgmCyEodOO/6mqHQPZ
         o602FEEBo2BaK0C+iSbR+HJxdihKHZ+C3P5kvT7q7USs9eYyBVgAC1hPZDw5P3TPGP88
         xOz2W/o4zbrH7p/1ma9R1FG8zPfKmUXpqeof4hCA48PoTpqr8RCVDcpcNspxkXRwGWl5
         dgTLruM/dRaU6W12aahjBAqQmMfsn7PDEL3XtB5lJtxPuq8HqTEmNaLNScjQbrnRraKo
         ZLVg==
X-Gm-Message-State: ACrzQf1kqzKYzRv75EJPNbiLWUxdaRRPxDivdpAzr6GnoaKWXZNvowFV
        oV6aEL+MOsNEKfYCYWEwYFqh0DQ95uIjORJ0ov0X3qkVSJha
X-Google-Smtp-Source: AMsMyM7OZyURxH7i2B4ajj40vpono9jekPJZ6s0JwDRcB8wmh3bJM32SFlQ35IpnCjpop4LGKVKwgLRbvVDAiwcu+AqnesEgBpOC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1311:b0:363:cb56:ed82 with SMTP id
 r17-20020a056638131100b00363cb56ed82mr13161007jad.98.1666327541090; Thu, 20
 Oct 2022 21:45:41 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:45:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a909705eb841dda@google.com>
Subject: [syzbot] WARNING in btrfs_block_rsv_release
From:   syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1025dd72880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d16e6e880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672873c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/df89d50ed284/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
WARNING: CPU: 0 PID: 3612 at fs/btrfs/space-info.h:122 btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
Modules linked in:
CPU: 0 PID: 3612 Comm: syz-executor894 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:122 [inline]
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
RIP: 0010:block_rsv_release_bytes fs/btrfs/block-rsv.c:151 [inline]
RIP: 0010:btrfs_block_rsv_release+0x5d1/0x730 fs/btrfs/block-rsv.c:295
Code: 8b 7c 24 10 74 08 4c 89 f7 e8 2b 94 33 fe 49 8b 1e 48 89 df 48 8b 2c 24 48 89 ee e8 a9 2b e0 fd 48 39 eb 73 0b e8 5f 29 e0 fd <0f> 0b 31 db eb 25 e8 54 29 e0 fd 48 b8 00 00 00 00 00 fc ff df 41
RSP: 0000:ffffc90003baf9e8 EFLAGS: 00010293
RAX: ffffffff83a657f1 RBX: 00000000000d0000 RCX: ffff888020c59d80
RDX: 0000000000000000 RSI: 00000000000e0000 RDI: 00000000000d0000
RBP: 00000000000e0000 R08: ffffffff83a657e7 R09: fffffbfff1c19fde
R10: fffffbfff1c19fde R11: 1ffffffff1c19fdd R12: 1ffff11004f2190c
R13: 00000000000e0000 R14: ffff88802790c860 R15: 0000000000000000
FS:  000055555651b300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f207ed54000 CR3: 0000000026ea2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_release_global_block_rsv+0x2f/0x250 fs/btrfs/block-rsv.c:463
 btrfs_free_block_groups+0xb67/0xfd0 fs/btrfs/block-group.c:4053
 close_ctree+0x6c5/0xbde fs/btrfs/disk-io.c:4710
 generic_shutdown_super+0x130/0x310 fs/super.c:491
 kill_anon_super+0x36/0x60 fs/super.c:1085
 btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 ptrace_notify+0x29a/0x340 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f694614c2f7
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee1dcd8e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f694614c2f7
RDX: 00007ffee1dcd9a9 RSI: 000000000000000a RDI: 00007ffee1dcd9a0
RBP: 00007ffee1dcd9a0 R08: 00000000ffffffff R09: 00007ffee1dcd780
R10: 000055555651c653 R11: 0000000000000206 R12: 00007ffee1dcea20
R13: 000055555651c5f0 R14: 00007ffee1dcd910 R15: 0000000000000004
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
