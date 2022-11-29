Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6263CA25
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Nov 2022 22:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiK2VL2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Nov 2022 16:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiK2VLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Nov 2022 16:11:07 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5F970472
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Nov 2022 13:10:42 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so13379528ild.18
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Nov 2022 13:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+T5btxFITBUYFNemWF4t9XMo8L1hkUwTBYtJ6gvqC3w=;
        b=vtW80/n1b5u3Jp9gM6TkkfeNjOmVaostD++cZlaVwO4uVjvoH49U/FoSMajeAaeG8q
         PyXKVTgX+GI3cvqJQqvCPyY2p9QnmWzTBe+ZNS+ivJBRBJHulViyr3EgC/IPe3sGP8ib
         oQuuClN32nUoBNVuTmtarBIXaRAAlrohaBBuw7xIGLu0w+R8FKqiQlTYq9Mdov1xPPdU
         42YOsBwz/eR5ynJErawOtipmdwCijxES16iz57DzKy5RbRawQmmVxkkANKKUzCHKC/45
         1XKqMMBH+VPnQJBY8QiRFwudEGePHMvwl8LcQY0EXH7X/byemGfhDWk/YlO+GWjcwOgX
         2Q9Q==
X-Gm-Message-State: ANoB5pmmF65GKb8DfICYZW0tCkzsNnWA/om2PHZ2VHU02ahI6gr05KVq
        udrKr3XQuVZ6grTnrFR6VTqpQNxBTF9PEQgpHeu/8ailaOrc
X-Google-Smtp-Source: AA0mqf6itHiSNazy+QcwfhiR8iCnI40NzyQa9ZJ4g9Aty3ZZo4I4bM5OqksgP8YLzUNeWfoZ49RnCnj34JsbIizC8TIWYwUplkgy
MIME-Version: 1.0
X-Received: by 2002:a92:2c0e:0:b0:302:e042:9ddd with SMTP id
 t14-20020a922c0e000000b00302e0429dddmr15312188ile.292.1669756241459; Tue, 29
 Nov 2022 13:10:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:10:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2432a05eea26be6@google.com>
Subject: [syzbot] kernel BUG in insert_state_fast
From:   syzbot <syzbot+9ce4a36127ca92b59677@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12bc57c5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12806381880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127f33c5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3162096f8ebc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ce4a36127ca92b59677@syzkaller.appspotmail.com

RSP: 002b:00007ffd0af295c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fdc57eface9
RDX: 0000000000000049 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007ffd0af295d0 R08: 0000000000000001 R09: 00007fdc57eb0034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:381!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3632 Comm: syz-executor229 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:set_state_bits fs/btrfs/extent-io-tree.c:381 [inline]
RIP: 0010:insert_state_fast+0x242/0x250 fs/btrfs/extent-io-tree.c:439
Code: 2e fe e9 77 ff ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 72 fe ff ff 4c 89 e7 e8 d8 c1 2e fe e9 65 fe ff ff e8 fe a8 da fd <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 55 41 57 41 56 41 55 41
RSP: 0018:ffffc90003b6f698 EFLAGS: 00010293
RAX: ffffffff83afeeb2 RBX: dffffc0000000000 RCX: ffff888018ee57c0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: 00000000fffffff4 R08: ffffffff83afedd4 R09: 00000000ffffffff
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: 0000000000000000
R13: ffff888029b51588 R14: ffff888021a0e840 R15: 0000000000001000
FS:  0000555555986300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a0f58ad000 CR3: 000000007c25a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __set_extent_bit+0x1547/0x19a0 fs/btrfs/extent-io-tree.c:997
 set_record_extent_bits+0x50/0x80 fs/btrfs/extent-io-tree.c:1601
 qgroup_reserve_data+0x27b/0x6f0 fs/btrfs/qgroup.c:3739
 btrfs_qgroup_reserve_data+0x2a/0xc0 fs/btrfs/qgroup.c:3782
 btrfs_check_data_free_space+0x144/0x240 fs/btrfs/delalloc-space.c:152
 btrfs_buffered_write+0x56c/0x16f0 fs/btrfs/file.c:1559
 btrfs_direct_write fs/btrfs/file.c:1899 [inline]
 btrfs_do_write_iter+0xeb4/0x1260 fs/btrfs/file.c:1980
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdc57eface9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0af295c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fdc57eface9
RDX: 0000000000000049 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007ffd0af295d0 R08: 0000000000000001 R09: 00007fdc57eb0034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits fs/btrfs/extent-io-tree.c:381 [inline]
RIP: 0010:insert_state_fast+0x242/0x250 fs/btrfs/extent-io-tree.c:439
Code: 2e fe e9 77 ff ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 72 fe ff ff 4c 89 e7 e8 d8 c1 2e fe e9 65 fe ff ff e8 fe a8 da fd <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 55 41 57 41 56 41 55 41
RSP: 0018:ffffc90003b6f698 EFLAGS: 00010293
RAX: ffffffff83afeeb2 RBX: dffffc0000000000 RCX: ffff888018ee57c0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: 00000000fffffff4 R08: ffffffff83afedd4 R09: 00000000ffffffff
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: 0000000000000000
R13: ffff888029b51588 R14: ffff888021a0e840 R15: 0000000000001000
FS:  0000555555986300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a0f58ad000 CR3: 000000007c25a000 CR4: 00000000003506e0
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
