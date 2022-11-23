Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131A6351FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 09:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiKWIKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 03:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiKWIKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 03:10:45 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B750A99E8C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 00:10:44 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w9-20020a056e021c8900b0030247910269so12231476ill.4
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 00:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I1W1y2x8WCoMes3YNYuaCCPghY6aiWezz6ayF0TOpI=;
        b=vHkeznatnb3gSSYhHDNh4xeyk/omeRVQ8s0YOy/gajkz/pLAZbs6/y8eZYQXiDqxj6
         Z/hR3Mfqxz3B4ULsnKAErwPvzYHTJbj3KaEGtb277TNAqDnAOoam3zN1pWCRmV9+glrh
         HGTwN/BySFSJ81Q4e/08ima+5F2Gocf6y7meLeEHC10aaZKWVdOOH8IP7tXwnw3Mz4s3
         vMzr+WpEs6XaemWuFsvW8KDN8RmxDi/wGIzJF9iw406Sptfe5CDAVUDada4Sjt3fLbWJ
         Sdr6BH/euXQ0cYcSSMqO4UpJHcbpRo23tT59rj5fdgJadbgx2u9tTrSBTexBG+9gcBSn
         7JsQ==
X-Gm-Message-State: ANoB5plZmSZMYt6vwrprokbiW0DR9bfJvmilXNo4FHJyjYYHB56YoDv+
        gnvMTMMhuVwFBCX7XhgJ+b+hnnAPJqKNQvs3RI9bAdG/d0ta
X-Google-Smtp-Source: AA0mqf6lHz47qefUNe175SSyHMTEPPiuorHnQZf649VTAzEe4ThbeOrdNrjCMWkY9W0Rn2sjDa9rZDovEozLCWnV4IxxU7WhWje3
MIME-Version: 1.0
X-Received: by 2002:a92:d701:0:b0:300:ca48:e52d with SMTP id
 m1-20020a92d701000000b00300ca48e52dmr11818832iln.86.1669191044114; Wed, 23
 Nov 2022 00:10:44 -0800 (PST)
Date:   Wed, 23 Nov 2022 00:10:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f315b05ee1ed3f4@google.com>
Subject: [syzbot] kernel BUG in close_ctree
From:   syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>
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

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e5b309880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5db36e7087dcccae
dashboard link: https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12e9c825ff47/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/107e5e091c9e/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/605ab211617d/bzImage-eb708140.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com

assertion failed: list_empty(&fs_info->delayed_iputs), in fs/btrfs/disk-io.c:4664
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3713!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3696 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:assertfail.constprop.0+0x27/0x29 fs/btrfs/ctree.h:3713
Code: 3f c9 f7 41 54 41 89 f4 55 48 89 fd e8 a2 3f c9 f7 44 89 e1 48 89 ee 48 c7 c2 60 a4 95 8a 48 c7 c7 a0 a4 95 8a e8 00 76 f5 ff <0f> 0b e8 82 3f c9 f7 e8 8d 3d 15 f8 be 73 04 00 00 48 c7 c7 40 a5
RSP: 0018:ffffc90003727be8 EFLAGS: 00010282
RAX: 0000000000000051 RBX: ffff888027d9c000 RCX: 0000000000000000
RDX: ffff88804a6b6280 RSI: ffffffff8164973c RDI: fffff520006e4f6f
RBP: ffffffff8a95dac0 R08: 0000000000000051 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000001238
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801da29200
FS:  0000555555bec400(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f17654d56be CR3: 0000000031a82000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 close_ctree+0x502/0xdc7 fs/btrfs/disk-io.c:4664
 generic_shutdown_super+0x158/0x410 fs/super.c:492
 kill_anon_super+0x3a/0x60 fs/super.c:1086
 btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2441
 deactivate_locked_super+0x98/0x160 fs/super.c:332
 deactivate_super+0xb1/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7827a8d5f7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeef557068 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7827a8d5f7
RDX: 00007ffeef55713c RSI: 000000000000000a RDI: 00007ffeef557130
RBP: 00007ffeef557130 R08: 00000000ffffffff R09: 00007ffeef556f00
R10: 0000555555bed8b3 R11: 0000000000000246 R12: 00007f7827ae6b46
R13: 00007ffeef5581f0 R14: 0000555555bed810 R15: 00007ffeef558230
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:assertfail.constprop.0+0x27/0x29 fs/btrfs/ctree.h:3713
Code: 3f c9 f7 41 54 41 89 f4 55 48 89 fd e8 a2 3f c9 f7 44 89 e1 48 89 ee 48 c7 c2 60 a4 95 8a 48 c7 c7 a0 a4 95 8a e8 00 76 f5 ff <0f> 0b e8 82 3f c9 f7 e8 8d 3d 15 f8 be 73 04 00 00 48 c7 c7 40 a5
RSP: 0018:ffffc90003727be8 EFLAGS: 00010282
RAX: 0000000000000051 RBX: ffff888027d9c000 RCX: 0000000000000000
RDX: ffff88804a6b6280 RSI: ffffffff8164973c RDI: fffff520006e4f6f
RBP: ffffffff8a95dac0 R08: 0000000000000051 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000001238
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801da29200
FS:  0000555555bec400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd78dea19d8 CR3: 0000000031a82000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
