Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77C612350
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Oct 2022 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2Nfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Oct 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2Nfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Oct 2022 09:35:41 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BD58B47
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Oct 2022 06:35:40 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso6785664ilj.17
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Oct 2022 06:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UWBCeT2JcZxndCciouGOF6RNQJlwhgrY0jabwvrRGE=;
        b=j0Chy08dE2YjDcGTlt3w/Qfc3aK4S/FtdDWgvDK+ySAWUudKLbZK5MkUHR10soEKcF
         yXTbD38OczGf2aEUK9SJTCEhctxaJjcrX3160Z11WBI1Lm4uDloxXfOps2+wmTpsr/BA
         1Z1QD/jPLkqjKElAOIGwnvHDShBp3tKR5Az5zwM0uN808jlk+hZ5lm85Vc+PJmbRTNMF
         lLePBCmDqW0lzzXouilMfwyelPANQy1UThFmgN097BLA+IZdh6jRw4Qjp9axnkVnJ9UT
         Ko8t9axupHOf+GCKVUHYsSbIlerEpjOfxx4yd0oTQi2kAYE9XIDEJbdK7Q5oAbL9zHjf
         RD5w==
X-Gm-Message-State: ACrzQf2qElz3LEx1SitB6mxSewAKTwGKYTw+3+9/h4vUfdDWTy++ljHU
        FFs53QxVXDaJlfYhGj3L8FEKJYf9urMkaDAuAUHV0ERDh5IL
X-Google-Smtp-Source: AMsMyM7xHAVY050ZB0EmsmQSQqtJ3CNjlQzPn9thZrbE6fTQo1eHvXVscqHkok0dLUWnx5qJTpPZdnIGUEMV4aYc3ZtsTZmJBTOK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1905:b0:2ff:a163:8497 with SMTP id
 w5-20020a056e02190500b002ffa1638497mr2137287ilu.147.1667050540059; Sat, 29
 Oct 2022 06:35:40 -0700 (PDT)
Date:   Sat, 29 Oct 2022 06:35:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004353bc05ec2c73f4@google.com>
Subject: [syzbot] WARNING in find_free_extent_update_loop
From:   syzbot <syzbot+1ab183c4029913aa8e4c@syzkaller.appspotmail.com>
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c0475a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=1ab183c4029913aa8e4c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ab183c4029913aa8e4c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 31718 at fs/btrfs/extent-tree.c:4118 find_free_extent_update_loop+0xa1a/0xd00 fs/btrfs/extent-tree.c:4118
Modules linked in:
CPU: 0 PID: 31718 Comm: syz-executor.1 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:find_free_extent_update_loop+0xa1a/0xd00 fs/btrfs/extent-tree.c:4118
Code: 00 48 c7 c6 a0 33 da 8a 44 89 f2 31 c0 e8 b0 a1 ad 06 eb 1a e8 c7 a6 03 fe 48 c7 c7 a0 32 da 8a 44 89 f6 31 c0 e8 16 45 cb fd <0f> 0b b3 01 4c 8b 6c 24 08 44 0f b6 c3 4c 89 ff 48 c7 c6 40 48 da
RSP: 0018:ffffc9000354e950 EFLAGS: 00010246
RAX: 9bc899dcf6ac9a00 RBX: 00000000fffffff4 RCX: 0000000000040000
RDX: ffffc9000d255000 RSI: 000000000000f22a RDI: 000000000000f22b
RBP: ffff888088f3e050 R08: ffffffff816b8dfd R09: ffffed1017344f13
R10: ffffed1017344f13 R11: 1ffff11017344f12 R12: 0000000000000000
R13: 1ffff110111e7c0a R14: 00000000fffffff4 R15: ffff888088f3e000
FS:  00007f875efde700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020701000 CR3: 00000000271de000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 find_free_extent+0x1740/0x4230 fs/btrfs/extent-tree.c:4470
 btrfs_reserve_extent+0x421/0x800 fs/btrfs/extent-tree.c:4563
 cow_file_range+0x52e/0xfa0 fs/btrfs/inode.c:1276
 btrfs_run_delalloc_range+0xed4/0x11a0 fs/btrfs/inode.c:2229
 writepage_delalloc+0x25e/0x540 fs/btrfs/extent_io.c:1968
 __extent_writepage+0x5d6/0x14d0 fs/btrfs/extent_io.c:2272
 extent_write_cache_pages+0x9e7/0x12d0 fs/btrfs/extent_io.c:3186
 extent_writepages+0x228/0x550 fs/btrfs/extent_io.c:3308
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range fs/btrfs/file.c:4140 [inline]
 start_ordered_ops fs/btrfs/file.c:2026 [inline]
 btrfs_sync_file+0x39e/0x1140 fs/btrfs/file.c:2102
 generic_write_sync include/linux/fs.h:2883 [inline]
 btrfs_do_write_iter+0xa6f/0x1370 fs/btrfs/file.c:1975
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f875fc8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f875efde168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f875fdac050 RCX: 00007f875fc8b5a9
RDX: 0000000000000010 RSI: 0000000020000bc0 RDI: 0000000000000003
RBP: 00007f875efde1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd6082437f R14: 00007f875efde300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
