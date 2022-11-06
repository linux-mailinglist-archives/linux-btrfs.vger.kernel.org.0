Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8E61E4CC
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiKFRVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKFRVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 12:21:23 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A5248F6
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 09:13:48 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id v18-20020a5d9412000000b006bfdf74fa3bso5876623ion.3
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 09:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tntjbVIwEnUx/49ns5I6z84/2ydQTBLdsYbGbJMJCpQ=;
        b=eDWuiRSUi7w/xnkPHo/bP66UmfOGypiZRXGK4D03x5Sv+QrXSc9OHXXnk3HE0FtZ7H
         CB+dICW+TTV+Kj6Orkiev6kZOn+7HCWpjEIbTDnHPCqedlIqZfFwkW9+3fHhDFFgMsvW
         ykDl5hiJWVg9ce1lEgVa9/66vRoLgwsDTzrneyqqW1QfANAC2ql6RKfFUxbD2tebZy79
         QiXMHdws0hvn2Q69KMLM0Ib29dUCBuFtEkBAJ6J39tjkZIQfIbR1DDcu8LCA1mNmiVyg
         0U7MLB0LNvEOSTz9bUsZIFq09al9p/RVUirci+oJQHr2dnI9WnG+sNupBl6JqISQVCad
         2jdw==
X-Gm-Message-State: ACrzQf2hBm04zAeqWEjWxeAUV+bRT5Lj00KTmWcDqxmIGY9t2aDpt3Hd
        3craoGWFDYN6AxOAz+F2abRYcJc13j408icK5qJfDwtOLicb
X-Google-Smtp-Source: AMsMyM5VKrPycUSdOb59R+bOeJjI8zf+bDoOUzp/DAJ9/FySDSlbXCpISl4QixGDm7RkRqs48uXrytApZLsrPKoMlZ/SOwyrHkOm
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4094:b0:375:8dbb:ef89 with SMTP id
 m20-20020a056638409400b003758dbbef89mr11067967jam.93.1667754827881; Sun, 06
 Nov 2022 09:13:47 -0800 (PST)
Date:   Sun, 06 Nov 2022 09:13:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016a4a905ecd06e88@google.com>
Subject: [syzbot] WARNING in btrfs_create_new_inode
From:   syzbot <syzbot+56e0adfbcf0bafbf4f53@syzkaller.appspotmail.com>
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

HEAD commit:    b208b9fbbcba Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152c0676880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=56e0adfbcf0bafbf4f53
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92fde6d92d82/disk-b208b9fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae3dbdb3faf8/vmlinux-b208b9fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbf4da09683c/bzImage-b208b9fb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56e0adfbcf0bafbf4f53@syzkaller.appspotmail.com

BTRFS info (device loop5): using free space tree
BTRFS info (device loop5): enabling ssd optimizations
------------[ cut here ]------------
WARNING: CPU: 1 PID: 27384 at fs/btrfs/inode.c:6412 btrfs_create_new_inode+0x1aa3/0x2270 fs/btrfs/inode.c:6412
Modules linked in:
CPU: 1 PID: 27384 Comm: syz-executor.5 Not tainted 6.1.0-rc3-syzkaller-00288-gb208b9fbbcba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:btrfs_create_new_inode+0x1aa3/0x2270 fs/btrfs/inode.c:6412
Code: d5 85 a7 06 4c 8b 6c 24 20 49 bf 00 00 00 00 00 fc ff df eb 17 e8 1d 3b fd fd 48 c7 c7 80 00 db 8a 89 de 31 c0 e8 2d d9 c4 fd <0f> 0b b0 01 44 0f b6 c0 48 8b 7c 24 18 48 c7 c6 60 07 db 8a ba 0c
RSP: 0018:ffffc90003abfa20 EFLAGS: 00010246
RAX: 3679467aa46b8200 RBX: 00000000fffffff4 RCX: 0000000000040000
RDX: ffffc9000d634000 RSI: 0000000000006e63 RDI: 0000000000006e64
RBP: ffffc90003abfc70 R08: ffffffff816b9e3d R09: ffffed1017364f13
R10: ffffed1017364f13 R11: 1ffff11017364f12 R12: ffff88803d12e590
R13: 1ffff92000757f60 R14: 1ffff11007a25cb2 R15: dffffc0000000000
FS:  00007f64f0355700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000201e6000 CR3: 000000003a0d2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_create_common+0x2eb/0x420 fs/btrfs/inode.c:6639
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4035
 do_mkdirat+0x279/0x550 fs/namei.c:4060
 __do_sys_mkdirat fs/namei.c:4075 [inline]
 __se_sys_mkdirat fs/namei.c:4073 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4073
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f64ef68b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f64f0355168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f64ef7abf80 RCX: 00007f64ef68b5a9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000004
RBP: 00007f64f03551d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd23a451ef R14: 00007f64f0355300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
