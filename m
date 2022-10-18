Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA366024EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJRHEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJRHEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 03:04:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46633240B6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 00:04:39 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id s3-20020a5eaa03000000b006bbdfc81c6fso9176770ioe.4
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 00:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XD2n27cCQIHHebWhb88zFE+CukxwK5BQNAzexMjyc8Q=;
        b=ESnULMt1aFYRTmSADj2WrKeCPWg7095PN677rmsMo6Uj++BxM+ZS7OzTN1oRxKPoT8
         TK+PBa2RnCiHJBEI6R3XE1+W7es9rAK5k+zSar99R6wkM1c8lbFwvdXLLmU5y4GBtdGc
         ivRTtgIiB3ELtm2UFGdGS80I8l74Q98NP2XXYQsu45PhgdYWX1zg0I32+iDG4jsdQaQk
         z11RrHNN0z45km/kR1B5Gchk6FDNKgK7eAADP8hwPcmnQO626KpydebxlqWk4S4oEcqM
         wcoHaZyLpKoEjjwsmRtI5wi5IaMmGDvw+01JO3dkCkbICmuECqaoyLxAxEh63C8gyPmO
         K6jw==
X-Gm-Message-State: ACrzQf2uVs5HUlsmYzx5TtbHRwYl2ECC5rFyLbW9TAFzU7h9IiXQh4NU
        piKEB/qjc2XIG9IB090DH55TOTMxTM0xdKtVHvCf0NInvm1u
X-Google-Smtp-Source: AMsMyM5BqPNu9p0GnSjz5AdBtdhntDHdzWGavKZeUNgRQp6DMfnjuEjI61M1F1Eoz8tOcucrLP1iwK6r8/OIVD+I1aA76uhVQiSD
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3409:b0:6bc:698c:cfca with SMTP id
 n9-20020a056602340900b006bc698ccfcamr973795ioz.98.1666076678398; Tue, 18 Oct
 2022 00:04:38 -0700 (PDT)
Date:   Tue, 18 Oct 2022 00:04:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095ab2705eb49b484@google.com>
Subject: [syzbot] WARNING in btrfs_add_link
From:   syzbot <syzbot+b531e31d583db14070d4@syzkaller.appspotmail.com>
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1298899a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=b531e31d583db14070d4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c791937c012/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb21a2879b4c/vmlinux-55be6084.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b531e31d583db14070d4@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 32768
BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop1): using free space tree
BTRFS info (device loop1): enabling ssd optimizations
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1681 at fs/btrfs/inode.c:6568 btrfs_add_link+0xab5/0xd50 fs/btrfs/inode.c:6568
Modules linked in:
CPU: 1 PID: 1681 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:btrfs_add_link+0xab5/0xd50 fs/btrfs/inode.c:6568
Code: f7 1d fe 44 89 ee bf e2 ff ff ff e8 f5 f3 1d fe 41 83 fd e2 74 6a e8 2a f7 1d fe 44 89 ee 48 c7 c7 40 9c 37 8a e8 2a db e0 05 <0f> 0b bb 01 00 00 00 e8 0f f7 1d fe 41 89 d8 44 89 e9 ba a8 19 00
RSP: 0018:ffffc90003f2f510 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88809c91c000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff81612e28 RDI: fffff520007e5e94
RBP: ffffc90003f2f620 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 00000000312d2072 R12: ffff88809ded3c20
R13: 00000000fffffff4 R14: 0000000000000108 R15: ffff888047aba000
FS:  00007efc740b9700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563379fb8c78 CR3: 00000000a763e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_create_new_inode+0x1b46/0x2890 fs/btrfs/inode.c:6504
 btrfs_create_common+0x1d5/0x260 fs/btrfs/inode.c:6639
 btrfs_create+0x112/0x160 fs/btrfs/inode.c:6679
 lookup_open.isra.0+0xf05/0x12a0 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efc72e8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc740b9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007efc72fabf80 RCX: 00007efc72e8b5a9
RDX: 0000000000000000 RSI: 0000000000143142 RDI: 0000000020002000
RBP: 00007efc740b91d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffc75a878af R14: 00007efc740b9300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
