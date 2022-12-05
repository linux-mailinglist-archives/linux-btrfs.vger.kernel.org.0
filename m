Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA31642440
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 09:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiLEIN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 03:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiLEINx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 03:13:53 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592415A1B
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 00:13:47 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so11594351ilv.16
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Dec 2022 00:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kf+gTnL9MXeVWtkJkGE+GjCA76PcAbRRoiShrRPE/Eo=;
        b=vXoCAWknJYNzmMKuGZgIIdn6dX74Dvl3SNmGJ14X4HBXQ2htZlKUA/Ygnqu5IzPaUD
         C5/NTON/u2epLJ7dNVwWeFLvDHjRnoAy6MSnSvijeuMvlcz94pmMQ0wtbbXFjOH3W9uT
         jDq0+q7h/fA2kiFuVNomjCGGJG23Nd0wcDwSpCOC1L5IZz59A/lBnSiKrTPL62MomWHT
         tQUeedhdzMLXHSm8Ulqx5sDF9xdIDtopU1FHDiohSnxze1J1wnviOvYZf3Vs4MM3C7wS
         9mEBTCTkjss/Mt49WDT5dLf0n+QjBvJRXgiPQrbXUun/q3O/zHKldHnZX+x65iVEonKn
         tMmQ==
X-Gm-Message-State: ANoB5plW8SpTQKQmQVw9sV/24JY//ROlnW+bgcTEiiD4kC0/IAAoBhym
        y7ozXMwNee8lq+balrDPPkV3gAgACskTyZMoZCYZbavmGs2I
X-Google-Smtp-Source: AA0mqf7dBcdTNVWOtZD+6FseLn++Cv1SkNbhk9bu5pM9s8EX1PRp73/mgf3keOw4ctx1+EUtrxs1GGgys/qI7YywO8IQ7nE98fd5
MIME-Version: 1.0
X-Received: by 2002:a92:6a11:0:b0:300:ece2:e3b8 with SMTP id
 f17-20020a926a11000000b00300ece2e3b8mr28880177ilc.255.1670228026933; Mon, 05
 Dec 2022 00:13:46 -0800 (PST)
Date:   Mon, 05 Dec 2022 00:13:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d4a1a05ef104401@google.com>
Subject: [syzbot] WARNING in lookup_inline_extent_backref
From:   syzbot <syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com>
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

HEAD commit:    a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1469bdbd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d89247880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b1ca83880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bbe66b25958/disk-a4412fdd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6851483ca667/vmlinux-a4412fdd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d5b23cb4616/bzImage-a4412fdd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1f178223dd56/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6559 at fs/btrfs/extent-tree.c:865 lookup_inline_extent_backref+0x8c1/0x13f0
Modules linked in:
CPU: 0 PID: 6559 Comm: syz-executor311 Not tainted 6.1.0-rc7-syzkaller-00123-ga4412fdd49dc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:lookup_inline_extent_backref+0x8c1/0x13f0 fs/btrfs/extent-tree.c:865
Code: 98 00 00 00 0f 87 42 0b 00 00 e8 5a 9c 07 fe 4c 8b 6c 24 28 eb 3d 83 7d 28 00 4c 8b 6c 24 28 0f 84 b0 04 00 00 e8 3f 9c 07 fe <0f> 0b 41 bc fb ff ff ff e9 f3 05 00 00 e8 2d 9c 07 fe e9 ca 05 00
RSP: 0018:ffffc90006296e40 EFLAGS: 00010293
RAX: ffffffff8382fbb1 RBX: 0000000000000000 RCX: ffff88801eab1d40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90006296ff0 R08: ffffffff8382f700 R09: ffffed100faf1008
R10: ffffed100faf1008 R11: 1ffff1100faf1007 R12: dffffc0000000000
R13: ffff888075edcd10 R14: ffffc90006296f60 R15: ffff88807d788000
FS:  00007fdb617d5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055912e028900 CR3: 000000001954b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 insert_inline_extent_backref+0xcc/0x260 fs/btrfs/extent-tree.c:1152
 __btrfs_inc_extent_ref+0x108/0x5e0 fs/btrfs/extent-tree.c:1455
 btrfs_run_delayed_refs_for_head+0xf00/0x1df0 fs/btrfs/extent-tree.c:1943
 __btrfs_run_delayed_refs+0x25f/0x490 fs/btrfs/extent-tree.c:2008
 btrfs_run_delayed_refs+0x312/0x490 fs/btrfs/extent-tree.c:2139
 qgroup_account_snapshot+0xce/0x340 fs/btrfs/transaction.c:1538
 create_pending_snapshot+0xf35/0x2560 fs/btrfs/transaction.c:1800
 create_pending_snapshots+0x1a8/0x1e0 fs/btrfs/transaction.c:1868
 btrfs_commit_transaction+0x13f0/0x3760 fs/btrfs/transaction.c:2323
 create_snapshot+0x4aa/0x7e0 fs/btrfs/ioctl.c:833
 btrfs_mksubvol+0x62e/0x760 fs/btrfs/ioctl.c:983
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1029
 __btrfs_ioctl_snap_create+0x339/0x450 fs/btrfs/ioctl.c:2184
 btrfs_ioctl_snap_create+0x134/0x190 fs/btrfs/ioctl.c:2211
 btrfs_ioctl+0x15c/0xc10
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdb6184aa69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb617d52f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdb618d57f0 RCX: 00007fdb6184aa69
RDX: 00000000200000c0 RSI: 0000000050009401 RDI: 0000000000000004
RBP: 00007fdb618a226c R08: 00007fdb617d5700 R09: 0000000000000000
R10: 00007fdb617d5700 R11: 0000000000000246 R12: 8000000000000000
R13: 00007fdb618a1270 R14: 0000000100000000 R15: 00007fdb618d57f8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
