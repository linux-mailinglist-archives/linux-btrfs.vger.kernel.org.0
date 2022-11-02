Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C166170B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 23:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiKBWbB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 18:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiKBWa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 18:30:59 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C720A472
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 15:30:57 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id c4-20020a056e020bc400b0030098df879dso296135ilu.6
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 15:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9t5rxiD3HbBUPq6/6mfgx1apalEX8dQGz5+gh984xo=;
        b=1XTPy80WPdptX4tHE+nNdTUx0IngMadnlCiWYIlASICfMMRb91JZfl5k9BmdG0DMQ9
         YbP024wUaialWahoGVx8OS3FPQY9ua5Xgk9u33CdXRYPmOWLaKXNxIRbs1eIMzJvRDBI
         Z+jQeiS2A+ad90kzNUDG9jdceFUbg6BL2EfTCtUWGmphs/yeH/9cZF8xS0ofTOp6K6Fv
         iPeElze/Sj/CVdfX8DVE9TGxMOciOVwuThUB1i2YC9/EhFEGd0ptMqKqsI+0djLQKi5a
         tDbkurMjfaes5RCn36SesZF02cBmkJ90YOa3vg+OpP/PhTv0yK5d3f6/iHrju2d3PiDN
         66Sg==
X-Gm-Message-State: ACrzQf03AnYm0ak7VRrrZU4IhbgbT7ltXsBEeGtbaDr0M658URSmYfk2
        rZOFZ2dv+/ac1YajtW9NZYS+U0GRANTnPqIfmfMqpNn0ER3e
X-Google-Smtp-Source: AMsMyM5Oh95NtQfvBOGDmU7xx1PnSvfcLj5yYyut7wTKcKLky28OCiIBzDZeQutliXIvAwa4206qexk2Wb8wclQJa0FMKAzHvlCE
MIME-Version: 1.0
X-Received: by 2002:a92:cc49:0:b0:300:d9d7:fe36 with SMTP id
 t9-20020a92cc49000000b00300d9d7fe36mr218061ilq.225.1667428256652; Wed, 02 Nov
 2022 15:30:56 -0700 (PDT)
Date:   Wed, 02 Nov 2022 15:30:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed23c905ec846460@google.com>
Subject: [syzbot] WARNING in __btrfs_free_extent
From:   syzbot <syzbot+560e6a32d484d7293e37@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1661bcea880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e9ab22880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152ed4fc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1f4e6872e39d/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+560e6a32d484d7293e37@syzkaller.appspotmail.com

BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
BTRFS: Transaction aborted (error -12)
WARNING: CPU: 1 PID: 3604 at fs/btrfs/extent-tree.c:3067 __btrfs_free_extent+0xbf6/0x2540 fs/btrfs/extent-tree.c:3067
Modules linked in:
CPU: 1 PID: 3604 Comm: syz-executor311 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:__btrfs_free_extent+0xbf6/0x2540 fs/btrfs/extent-tree.c:3067
Code: fa 31 c0 e8 7e 29 ae 06 4c 8b 64 24 08 4c 8b 6c 24 10 eb 1a e8 8b 2e 04 fe 48 c7 c7 a0 32 da 8a 44 89 fe 31 c0 e8 da cc cb fd <0f> 0b b3 01 44 0f b6 c3 4c 89 ef 48 c7 c6 00 40 da 8a ba fb 0b 00
RSP: 0018:ffffc90003c4f600 EFLAGS: 00010246
RAX: 1d499b28e27a2c00 RBX: ffff88802756c001 RCX: ffff88801ee1d7c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003c4f780 R08: ffffffff816b8dfd R09: ffffed1017364f13
R10: ffffed1017364f13 R11: 1ffff11017364f12 R12: ffff8880277d2a50
R13: ffff888070ce3150 R14: 0000000000000001 R15: 00000000fffffff4
FS:  00005555567bf300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1911b2a300 CR3: 000000001e181000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_run_delayed_refs_for_head+0xe20/0x1df0 fs/btrfs/extent-tree.c:1943
 __btrfs_run_delayed_refs+0x25f/0x490 fs/btrfs/extent-tree.c:2008
 btrfs_run_delayed_refs+0x13b/0x4a0 fs/btrfs/extent-tree.c:2139
 btrfs_commit_transaction+0x3a9/0x3760 fs/btrfs/transaction.c:2123
 sync_filesystem+0x1bc/0x220 fs/sync.c:66
 __do_sys_syncfs fs/sync.c:160 [inline]
 __se_sys_syncfs+0x8f/0x110 fs/sync.c:149
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa6dc2ca1e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc86519f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000132
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa6dc2ca1e9
RDX: 0000000000000f20 RSI: 000000000000c0c2 RDI: 0000000000000003
RBP: 00007ffc86519f20 R08: 0000000000000001 R09: 00007fa6dc330036
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000100000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
