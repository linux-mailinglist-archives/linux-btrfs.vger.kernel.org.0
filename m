Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264CB754FE6
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jul 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGPQ6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jul 2023 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGPQ6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jul 2023 12:58:51 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F97E52
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 09:58:49 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1a6545aa0e0so5519042fac.3
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 09:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689526728; x=1692118728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuRwkV+sclDSaSk0CwVjw1z7ZfOsLFRuWm/Ymue/4OU=;
        b=EK44Tc7k9c98EcdkCbyIHzWMC/iFvBQPqMMUJyu6xMS87XApP8qUhtST5lo6g905gM
         FPsX6kEI7dpd+aub6sUXGaZl4143eoqR5LphJgoowvCKypsEGIKFNXe51isMALHXy0gs
         yqyGsfJf3M3sakjUrCMM3GeJ7Bjz9fo2UzJLvvDnzoRBx+5m0gDmhRIZY3hup3JPFQmM
         MUExtFm+Y+Z3H67kEJ9/rbrZ4e1g9WW6ffABLHnOSdwtW0xiHvmimOgJ8x8t7zflvhib
         bgnDaGcNRT1W6/cihShkDer2UutlBpnmezWqLHo9kNddY+ZNaPEN/Nj9i2TgC5X4+eKh
         x6Dw==
X-Gm-Message-State: ABy/qLZt4eYl1+jSy9B/1RI+kOQSERk40xKSmDdtGTzyYFdR3uH4/jE2
        5m6Yyp1xgof1Udclb880l2KuYoQcF7CEgXnTI1CtFpUt3YG2
X-Google-Smtp-Source: APBJJlHjbCVIWEyHRn5AR43gg99sjqW8TTlT47cpC5MNc7M+FZ4jJGCaFQyG1wOYVFG7GB05RNcFwVPeHEehIxI8XC5EFyKUtMZ5
MIME-Version: 1.0
X-Received: by 2002:a05:6870:93d5:b0:1b0:814b:78f1 with SMTP id
 c21-20020a05687093d500b001b0814b78f1mr8433461oal.2.1689526728673; Sun, 16 Jul
 2023 09:58:48 -0700 (PDT)
Date:   Sun, 16 Jul 2023 09:58:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000804fb406009d9880@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_finish_one_ordered
From:   syzbot <syzbot+6e54e639e7b934d64304@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1124c2daa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=6e54e639e7b934d64304
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8b0db7be621/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e54c8d8a4367/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a266546d6979/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e54e639e7b934d64304@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 4101 at fs/btrfs/inode.c:3279 btrfs_finish_one_ordered+0x1948/0x1c80 fs/btrfs/inode.c:3279
Modules linked in:
CPU: 1 PID: 4101 Comm: kworker/u4:9 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: btrfs-endio-write btrfs_work_helper
RIP: 0010:btrfs_finish_one_ordered+0x1948/0x1c80 fs/btrfs/inode.c:3279
Code: 48 c7 c7 80 62 4a 8b 44 89 fe e8 73 db c6 fd 0f 0b e9 11 ff ff ff e8 07 be ff fd 48 c7 c7 80 62 4a 8b 44 89 fe e8 58 db c6 fd <0f> 0b e9 2b ff ff ff e8 ec bd ff fd 48 c7 c7 80 62 4a 8b 44 89 fe
RSP: 0018:ffffc900039bf9e0 EFLAGS: 00010246
RAX: 254f043ec951b800 RBX: ffff888088c63ad0 RCX: ffff888036f81dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900039bfbb8 R08: ffffffff815323a2 R09: 1ffff92000737eb4
R10: dffffc0000000000 R11: fffff52000737eb5 R12: 1ffff1101118c75a
R13: ffff888088c63ad0 R14: 0000000000000000 R15: 00000000ffffffe4
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a229778008 CR3: 0000000077545000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_work_helper+0x380/0xbe0 fs/btrfs/async-thread.c:314
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
