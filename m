Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B07633BE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiKVL4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 06:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiKVL4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 06:56:44 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A102656B
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 03:56:43 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso10402260ilg.14
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 03:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6KL60JRVFUuWneu7vnb+xiDyNkxZWMW6/O2rgIIB4s=;
        b=TqG4jwBdU5mu0lz8i+2CeUJjJRMwzwKxjJk4WXOW1MMEzQTDRt9mwglRuxEpC14Lkm
         sONSqMDEVWXkrQixn6ru+niCpurwnPTd/DJ8FGbkx5U4oqAelHn8hJ4renToUgaQgRVH
         vBak7z34vh07j6aY7XQvqUFqTOHarYxl9EwXvyV0a9HBb8Rr8LrvcTtNfdPmuyFRqiFt
         nF0BnKtEQ2aTTT+ovhFNcIX6SB4VptAXvTKpUiXzYKY/BcJbYGVEta54Z8Frl2EuM7Fj
         W2JQsa3vY/TUiLRQXuKOkFLY54R+TZjG/UG4mDsseoGl8ttL8YopUXusWLspFu5vBCHR
         YQ3w==
X-Gm-Message-State: ANoB5pkVS9WtsrA5I9QEY02GhX+bvsIFjVBg9kZMh7UWIrkJ641Vl5/o
        esYWfjBJT6EEBcatJTpjpBw4xMiDMM7ex5mdqIqRS0WzCqoA
X-Google-Smtp-Source: AA0mqf4RUulN7NbwGV+q2t01Xu34QUSq7DfbfAcrVvifYtAJ0yS8wX0NiQdA7Mytga6ntN37WrF0oM/ywyiTsYFFD+eM1Sc6bAGo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f06:b0:363:aa8f:e316 with SMTP id
 ck6-20020a0566383f0600b00363aa8fe316mr10496009jab.238.1669118202337; Tue, 22
 Nov 2022 03:56:42 -0800 (PST)
Date:   Tue, 22 Nov 2022 03:56:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089deb205ee0ddd58@google.com>
Subject: [syzbot] WARNING in btrfs_chunk_alloc
From:   syzbot <syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16aec855880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5db36e7087dcccae
dashboard link: https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ec4c3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13940efd880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12e9c825ff47/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/107e5e091c9e/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/605ab211617d/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4d429a6dc170/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 45 at fs/btrfs/block-group.c:3535 do_chunk_alloc fs/btrfs/block-group.c:3535 [inline]
WARNING: CPU: 1 PID: 45 at fs/btrfs/block-group.c:3535 btrfs_chunk_alloc.cold+0x1a7/0x329 fs/btrfs/block-group.c:3777
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/u4:3 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:do_chunk_alloc fs/btrfs/block-group.c:3535 [inline]
RIP: 0010:btrfs_chunk_alloc.cold+0x1a7/0x329 fs/btrfs/block-group.c:3777
Code: 89 c7 89 c6 88 44 24 4f e8 5d 2e c7 f7 45 84 ff 0f 84 6e 01 00 00 e8 df 31 c7 f7 44 89 f6 48 c7 c7 c0 5c 98 8a e8 fb a4 f2 ff <0f> 0b e9 10 ff ff ff e8 c4 31 c7 f7 48 8b 54 24 38 b8 ff ff 37 00
RSP: 0018:ffffc90000d6fa70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
RDX: ffff888018452080 RSI: ffffffff8164973c RDI: fffff520001adf40
RBP: ffff88807bed9800 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888075d88898
R13: ffff888020971000 R14: ffffffffffffffe4 R15: 0000000075d88801
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa773a78250 CR3: 000000007d62e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_space+0x9ce/0xe90 fs/btrfs/space-info.c:769
 btrfs_async_reclaim_metadata_space+0x53f/0xc00 fs/btrfs/space-info.c:1083
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
