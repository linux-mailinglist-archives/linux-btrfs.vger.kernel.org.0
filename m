Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB86669EC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 17:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjAMQyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 11:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjAMQxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 11:53:50 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C12B81C3D
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 08:50:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so16225463ili.5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 08:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ru+MXa4EkfYAJHzobnbu3rL9zxWmOJLKLdncAEQwSH0=;
        b=n7TclzTyeQD0IMM/bwAYBmp6tdPheEf4EoBl9/MtNGmpU/V+g8XLHFyNwxRP0ygCzM
         X+rIihIdyeNCC7gNCzyIvbUY8nhDvDXC3QdNiN6VMlXqnx+ff8bEvvW5vRsdpg6Rc4SS
         Z3mOQMR7BOPspZpLv2wBbuNFUDXYth9IIVJDub2yl+wpep55QlSaioGrbtXhWoAZE59T
         PP5qdUHJ8DrQ6tVdDsxvP9/yMz/wxz0UB2skOFQFAomQzNkotGZP9iKzjsgk7N2wnjY/
         pdBqZfhpm22ktmzGIDg1ntCh+mnfESceYdQzMh06vuRSpqrbdZbo/k6yfsmgxeOLF5jS
         V4NA==
X-Gm-Message-State: AFqh2kqAG8igrdFjdg1s4M+wvL5JEZMQj1BSaV8FHPf2wLQBOaGIJ+5C
        M5ZzoxYnN7GAZcuGI2QioOHWCi63MlI/I6zsUYztlF0QRmWE
X-Google-Smtp-Source: AMrXdXvpQBQNc+JvI1tKlS8DEY0EInE/am68fVEQTAHiL4grI+7IL2i7yFcmjheBfpXlp+Q1bqEtvKR5/Ay0EldfmIq3cCRXzsZS
MIME-Version: 1.0
X-Received: by 2002:a02:ca46:0:b0:38a:a65d:9885 with SMTP id
 i6-20020a02ca46000000b0038aa65d9885mr7442277jal.40.1673628644450; Fri, 13 Jan
 2023 08:50:44 -0800 (PST)
Date:   Fri, 13 Jan 2023 08:50:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6a91505f22808d4@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in insert_state
From:   syzbot <syzbot+7cab7cbfd44f07a9a6bb@syzkaller.appspotmail.com>
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

HEAD commit:    1fe4fd6f5cad Merge tag 'xfs-6.2-fixes-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131bb6f6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d95104afbe20f9df
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab7cbfd44f07a9a6bb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04384e60561f/disk-1fe4fd6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7ecda64fdc2/vmlinux-1fe4fd6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54286174b436/bzImage-1fe4fd6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cab7cbfd44f07a9a6bb@syzkaller.appspotmail.com

RDX: 00000000000ffe00 RSI: 0000000020004200 RDI: 0000000000000006
RBP: 00007f0c10e811d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe378a8d4f R14: 00007f0c10e81300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:379!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15347 Comm: syz-executor.5 Not tainted 6.2.0-rc3-syzkaller-00008-g1fe4fd6f5cad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
RIP: 0010:insert_state+0x399/0x3a0 fs/btrfs/extent-io-tree.c:401
Code: ff 2c fe e9 17 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 35 fd ff ff 48 89 df e8 a1 ff 2c fe e9 28 fd ff ff e8 17 56 d7 fd <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 38 44
RSP: 0018:ffffc90003abf690 EFLAGS: 00010246
RAX: ffffffff83b48549 RBX: 00000000fffffff4 RCX: 0000000000040000
RDX: ffffc9000bf31000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffff8880277e4600 R08: ffffffff83b4831a R09: 00000000ffffffff
R10: fffffbfff1a8331b R11: 1ffffffff1a8331a R12: 0000000000001000
R13: 0000000000000800 R14: 0000000000003fff R15: dffffc0000000000
FS:  00007f0c10e81700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000032af8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __set_extent_bit+0x1314/0x1c90 fs/btrfs/extent-io-tree.c:1136
 set_record_extent_bits+0x52/0x80 fs/btrfs/extent-io-tree.c:1690
 qgroup_reserve_data+0x27b/0x6f0 fs/btrfs/qgroup.c:3758
 btrfs_qgroup_reserve_data+0x2a/0xc0 fs/btrfs/qgroup.c:3801
 btrfs_check_data_free_space+0x144/0x240 fs/btrfs/delalloc-space.c:154
 btrfs_buffered_write+0x580/0x1730 fs/btrfs/file.c:1253
 btrfs_do_write_iter+0x421/0x1280 fs/btrfs/file.c:1677
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0c1008c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c10e81168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0c101abf80 RCX: 00007f0c1008c0c9
RDX: 00000000000ffe00 RSI: 0000000020004200 RDI: 0000000000000006
RBP: 00007f0c10e811d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe378a8d4f R14: 00007f0c10e81300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
RIP: 0010:insert_state+0x399/0x3a0 fs/btrfs/extent-io-tree.c:401
Code: ff 2c fe e9 17 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 35 fd ff ff 48 89 df e8 a1 ff 2c fe e9 28 fd ff ff e8 17 56 d7 fd <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 38 44
RSP: 0018:ffffc90003abf690 EFLAGS: 00010246
RAX: ffffffff83b48549 RBX: 00000000fffffff4 RCX: 0000000000040000
RDX: ffffc9000bf31000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffff8880277e4600 R08: ffffffff83b4831a R09: 00000000ffffffff
R10: fffffbfff1a8331b R11: 1ffffffff1a8331a R12: 0000000000001000
R13: 0000000000000800 R14: 0000000000003fff R15: dffffc0000000000
FS:  00007f0c10e81700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000032af8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
