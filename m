Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBC63A58E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiK1KBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 05:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiK1KBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 05:01:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AE193F7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 02:01:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so8425470ild.11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 02:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqNVlawbqvCFQyeGkOvr/K5NMmW0aOaeIsENVevBXGM=;
        b=79PXwD+m6rYgnymesavRmxP3K8/0Nvn8UeIE1rGxov2a5Sq+GDIoWrlxk0a9/mQo51
         PIunVvnjoIS17pK5qC7IBOGBl0iiU3E5KDcu98nBl7h4EtdubZLC6UDys2D8vQHqZQwM
         YRHnHD+wspUB8j1FgsE0voI4DIWGQeWKIoBUZtrb9tFxaY4Oc9prIZGI3KwR6D7H7YoV
         Wbn0HkcdOfC3bDa5FS41yOCDTE8v5VOtoN8ZfVmW634rpm2cXUsHsOR0bldCwFjQpzcV
         ykgf/uny0biM0dKQlmr545NpdGaI6lPi6qDs/7PhszKTaIbI2yUMWhqvd1sw8xhDg3O/
         UNnQ==
X-Gm-Message-State: ANoB5plK4z6enu1l9naautnyMxI2b6bfwQ0kE1t7Q9EIjrEwbeOR8Zyx
        FvrkumLZ0HYGQV62k5dn6k92MNJYfaYVL4XAR/7R6geANNKm
X-Google-Smtp-Source: AA0mqf6713wrxmEopmZhbiFzp5WmBk2gZY0TpB6KDlqiK2it9OzF7lsaJxPAvuu/pUS/vB3wipiuLYOKdtTJC/JKtEMlI63YFxfp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:66d:b0:303:1196:96c7 with SMTP id
 l13-20020a056e02066d00b00303119696c7mr1785211ilt.133.1669629698089; Mon, 28
 Nov 2022 02:01:38 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:01:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000faabc05ee84f596@google.com>
Subject: [syzbot] WARNING in btrfs_create_pending_block_groups
From:   syzbot <syzbot+5fd11a1f057a67a03a1b@syzkaller.appspotmail.com>
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

HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=102fda4b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd11a1f057a67a03a1b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16108d75880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f871bb880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9df87ba6b18b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fd11a1f057a67a03a1b@syzkaller.appspotmail.com

BTRFS warning (device loop0): the 'inode_cache' option is deprecated and has no effect since 5.11
BTRFS info (device loop0): force zlib compression, level 3
BTRFS info (device loop0): allowing degraded mounts
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): balance: start -susage=7,stripes=0..23665
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3633 at fs/btrfs/block-group.c:2409 btrfs_create_pending_block_groups+0x125d/0x1420 fs/btrfs/block-group.c:2409
Modules linked in:
CPU: 1 PID: 3633 Comm: syz-executor305 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:btrfs_create_pending_block_groups+0x125d/0x1420 fs/btrfs/block-group.c:2409
Code: e1 e8 b9 3a e3 06 4c 8b 64 24 08 4c 8b 74 24 30 e9 b4 f3 ff ff e8 73 7f dd fd 48 c7 c7 60 99 3b 8b 89 de 31 c0 e8 23 1e a5 fd <0f> 0b 41 b6 01 e9 63 ff ff ff e8 54 7f dd fd 48 c7 c7 60 99 3b 8b
RSP: 0018:ffffc90003d0f6c0 EFLAGS: 00010246
RAX: 86bce91ce9a3af00 RBX: 00000000ffffffe4 RCX: ffff888072043a80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003d0f948 R08: ffffffff816e55cd R09: ffffed1017324f1c
R10: ffffed1017324f1c R11: 1ffff11017324f1b R12: ffff8880189381b8
R13: ffff88806fcf50f8 R14: ffff888079420001 R15: ffff888018938058
FS:  0000555555b89300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc0b135ff8 CR3: 000000006eccd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __btrfs_end_transaction+0x2af/0x790 fs/btrfs/transaction.c:990
 btrfs_inc_block_group_ro+0x5d4/0x680 fs/btrfs/block-group.c:2652
 btrfs_relocate_block_group+0x422/0xd70 fs/btrfs/relocation.c:4011
 btrfs_relocate_chunk+0x125/0x350 fs/btrfs/volumes.c:3260
 __btrfs_balance+0x1dbf/0x2960 fs/btrfs/volumes.c:3990
 btrfs_balance+0xbfc/0x1140 fs/btrfs/volumes.c:4373
 btrfs_ioctl_balance+0x478/0x780 fs/btrfs/ioctl.c:4484
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1fc842cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd85f664f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1fc842cba9
RDX: 0000000020002280 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f1fc83ec440 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000050e9 R11: 0000000000000246 R12: 00007f1fc83ec4d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
