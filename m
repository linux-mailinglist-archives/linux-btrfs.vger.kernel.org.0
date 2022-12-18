Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123F465049C
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Dec 2022 21:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiLRULf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Dec 2022 15:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiLRULe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Dec 2022 15:11:34 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89DA19B
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 12:11:33 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id j5-20020a5d9d05000000b006e2f0c28177so3180571ioj.17
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 12:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYdEzkcmM1dQWw1tCSlRiluskSPU7yQYmczw0vf6EAw=;
        b=6lZy50u7WWtdcgAcDiJr3NgzcSNRdbBIKqtCGxb6KQwj8vxrZ22tuEyIa7HwH0b+bp
         FJE90Yg2s7K7RR0TcJN+gSeKBWTfPOFcAA6q1F6BhAD5oXGy++uTNWV9HGhfF3M3Qjef
         wesfFmTGMRlSX1kw7NhuLXkbBiusIGkN+hCBSZ/RswRHi8KzBxJfPxmb987HsdiFEp0k
         tl+kWi9B7E87BrdsF/eGbH/VK2zABt5pJFE2598/I5jalyBhr3p4ZujjKjUxiv/frEJC
         Y/h0NfPkl3wrt4sGNKwUnP1S8DP5t89rCVAmoM8qcd4HDLEhcVRYvBFoF+KAI9q9QUnZ
         nmcQ==
X-Gm-Message-State: ANoB5pmq9J+ITEJi28Zgqf3bMCRrSGlovP9bvU4J3FLggIIw/9h0uvqG
        NcynWPdIdieXj8U4jTH9ewFBchZYccuOPuNJBH3Ki50Xl22C
X-Google-Smtp-Source: AA0mqf7O+EfBtXFqK6D8+0MHVRbDp4g3/viKojgngFQoot8r445Yj77C/P/rLmKU+yQJ3WkD/YMeBwmYYmv9ClfW4b+b6NgdVweH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1252:b0:6e4:8c1:d2d7 with SMTP id
 o18-20020a056602125200b006e408c1d2d7mr1485178iou.27.1671394292609; Sun, 18
 Dec 2022 12:11:32 -0800 (PST)
Date:   Sun, 18 Dec 2022 12:11:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001737cf05f01fcf7f@google.com>
Subject: [syzbot] WARNING in add_to_free_space_tree
From:   syzbot <syzbot+c251f57046d25dec244f@syzkaller.appspotmail.com>
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

HEAD commit:    e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e54400480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=276eb8ff64eb2c27
dashboard link: https://syzkaller.appspot.com/bug?extid=c251f57046d25dec244f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aad47431ccd/disk-e2ca6ba6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/382636835ba9/vmlinux-e2ca6ba6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac62c9f6a7cf/bzImage-e2ca6ba6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c251f57046d25dec244f@syzkaller.appspotmail.com

BTRFS info (device loop1): balance: ended with status: 0
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 30814 at fs/btrfs/free-space-tree.c:1056 add_to_free_space_tree+0x279/0x2c0 fs/btrfs/free-space-tree.c:1056
Modules linked in:
CPU: 0 PID: 30814 Comm: syz-executor.1 Not tainted 6.1.0-syzkaller-09941-ge2ca6ba6ba01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:add_to_free_space_tree+0x279/0x2c0 fs/btrfs/free-space-tree.c:1056
Code: ec 8c ba 20 04 00 00 44 89 e1 e8 8b 91 ee 06 e9 f9 fe ff ff e8 08 9b dd fd 48 c7 c7 e0 84 5b 8b 44 89 e6 31 c0 e8 e7 91 a4 fd <0f> 0b eb bb 89 e9 80 e1 07 38 c1 0f 8c fc fd ff ff be 08 00 00 00
RSP: 0018:ffffc900176273d0 EFLAGS: 00010246
RAX: 53abe3a95ad09b00 RBX: ffff88807b17c001 RCX: 0000000000040000
RDX: ffffc90004441000 RSI: 000000000001f85f RDI: 000000000001f860
RBP: dffffc0000000000 R08: ffffffff816ea35d R09: fffff52002ec4e35
R10: fffff52002ec4e35 R11: 1ffff92002ec4e34 R12: 00000000ffffffe4
R13: ffff88802d265e70 R14: 1ffff11005a4cbd8 R15: ffff88802d265ec0
FS:  00007f281193d700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056102425b970 CR3: 000000002a41d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_free_extent_accounting fs/btrfs/extent-tree.c:2849 [inline]
 __btrfs_free_extent+0x14b3/0x29d0 fs/btrfs/extent-tree.c:3187
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1682 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1706 [inline]
 btrfs_run_delayed_refs_for_head+0xe35/0x1e50 fs/btrfs/extent-tree.c:1950
 __btrfs_run_delayed_refs+0x25f/0x490 fs/btrfs/extent-tree.c:2015
 btrfs_run_delayed_refs+0x13b/0x480 fs/btrfs/extent-tree.c:2146
 btrfs_commit_transaction+0x23d/0x3340 fs/btrfs/transaction.c:2151
 del_balance_item fs/btrfs/volumes.c:3486 [inline]
 reset_balance_state+0x256/0x390 fs/btrfs/volumes.c:3550
 btrfs_balance+0xf43/0x1150 fs/btrfs/volumes.c:4388
 btrfs_ioctl_balance+0x478/0x740 fs/btrfs/ioctl.c:3591
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2810c8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f281193d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2810dac050 RCX: 00007f2810c8c0d9
RDX: 0000000020000480 RSI: 00000000c4009420 RDI: 0000000000000007
RBP: 00007f2810ce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe60b3e16f R14: 00007f281193d300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
