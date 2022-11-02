Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B57616B29
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiKBRqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiKBRqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 13:46:54 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F612ACD
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 10:46:53 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id k6-20020a92c246000000b00300a1de59baso10798393ilo.23
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 10:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fu2Jh4mtVJYh4m6XIh04CrENtI12FDONZF290zEmHHA=;
        b=yRw6Zvzf1kUXEdyJ+ZEjmdBiXibEtifbxFdYV4zrUKWNSLNI0uNtYUePIl28qqbNVY
         UxPsxHb1Qpv2QEtc9YpiuryGvU8qPIA4HMvVHhWRNCiJauex3rA62GTbAHRJHRQqZ3kK
         fQKXtKFwKfc4FhxBmTBTOgOg/4hva6EG4RL9M31l1LWGhP4IdKv9jRqyncI/WxgMFrgE
         XTq0pm+ePBg5RUG9O1n2n2CWncb6Su4T1kXc6fzKtJL9MOh+HC47zurRD+rbGo/6CHCK
         TnEqNJ115+NkanbA1ft86JGIx0hrewamf9GZJLygwX/LObt5d2ftgx/betxCdVfJ2xRG
         zg3g==
X-Gm-Message-State: ACrzQf22/aZGHaKibCOkqLIA1fEHbwp2tIYz/Qu54Tn5ET5rSYHvAbGU
        C6NOHoL1bCjtCxAtEVwo/A7uAUKh7Pjlv8gi6qJh+uN/U3sz
X-Google-Smtp-Source: AMsMyM7X/DQrD0nktD6nvPbDSJURuMPQQuwt9AapXbFXj4H0UDTMmKKbah7SXCKKHJaeOxtJr5dl2KFSyOoboq13dEo6LjT9ampP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c2:b0:35a:c5b1:b567 with SMTP id
 n2-20020a05663831c200b0035ac5b1b567mr15556454jav.58.1667411213038; Wed, 02
 Nov 2022 10:46:53 -0700 (PDT)
Date:   Wed, 02 Nov 2022 10:46:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c379205ec806d6e@google.com>
Subject: [syzbot] WARNING in btrfs_commit_transaction
From:   syzbot <syzbot+9c37714c07194d816417@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12db9c7e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=9c37714c07194d816417
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17401632880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13176716880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/62077524a72d/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e432a6880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e432a6880000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e432a6880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c37714c07194d816417@syzkaller.appspotmail.com

BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): checking UUID tree
BTRFS warning (device loop0): Skipping commit of aborted transaction.
------------[ cut here ]------------
BTRFS: Transaction aborted (error -12)
WARNING: CPU: 0 PID: 3608 at fs/btrfs/transaction.c:1958 cleanup_transaction fs/btrfs/transaction.c:1958 [inline]
WARNING: CPU: 0 PID: 3608 at fs/btrfs/transaction.c:1958 btrfs_commit_transaction.cold+0x356/0xae3 fs/btrfs/transaction.c:2531
Modules linked in:
CPU: 0 PID: 3608 Comm: syz-executor286 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:cleanup_transaction fs/btrfs/transaction.c:1958 [inline]
RIP: 0010:btrfs_commit_transaction.cold+0x356/0xae3 fs/btrfs/transaction.c:2531
Code: fe ff ff e8 fa 28 27 f8 0f 0b e9 3f fe ff ff 31 db e9 d9 fe ff ff e8 e7 28 27 f8 44 89 ee 48 c7 c7 60 a5 37 8a e8 44 4a f4 ff <0f> 0b bb 01 00 00 00 e9 b9 fe ff ff e8 c7 28 27 f8 48 8b 95 00 ff
RSP: 0018:ffffc9000402fc70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888077eb4000 RCX: 0000000000000000
RDX: ffff88807c599d40 RSI: ffffffff81621b98 RDI: fffff52000805f80
RBP: ffffc9000402fdf0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000046525442 R12: 0000000000000000
R13: 00000000fffffff4 R14: ffff8880704d60a8 R15: ffff888077eb4000
FS:  0000555556f2b300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe136c1ee0 CR3: 000000006fa8b000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_sync_fs+0x169/0x810 fs/btrfs/super.c:1527
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff58bb49179
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb9ddd228 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff58bb49179
RDX: 0000000000000230 RSI: 000000000000c0c2 RDI: 00007ffeb9ddd230
RBP: 00007ffeb9ddd230 R08: 0000000000000001 R09: 00007ff58bbb0035
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000100000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
