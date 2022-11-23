Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8D63508F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiKWGin (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 01:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiKWGim (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 01:38:42 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B6ECCF4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 22:38:40 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id q197-20020a6b8ece000000b006de79f67604so8613267iod.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 22:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24x6pIXKgI7yTktOcxvzOm6+0lfxVAvmMB4rANgEJoU=;
        b=yThmYk1WDcHZk5ZACyqtTcBVLJEsg6xQNMI7uFQ0h0HR7wMFtr9N63Dr6shBC8ObCr
         qLGEMNJwpqqXw3OlLKwWubQk3iAMZ6eLiNvWXBr+wzbjSpqttH1SxJaM1uICANtw91us
         MvODE9hxmAU1hith8quNqvouYibJaycXEDlfyhOdWdcAdAzGpfE3XGm9917wXeevCIFx
         IpHPEPg10n7KbfZgSZ5PMYiWLm8yYdV7wG+jFqS4VWEgdPBQqglxhvAETvjh0mbByKHM
         nqZj4unBhyOk4B6O1/t7kyyjL/wnFsxY/ZS8XPFqm/ykIAdBHVde3pbqqJL5fH2Xr9yn
         54wA==
X-Gm-Message-State: ANoB5pnNv38gCaxFEk1cuYJY+daS0grjLeTGI69Nv+5VLT0yYzBtaMLS
        JaRE/KV3tAAtHj4jevH7v+QfzkaJeowVMJZvZOBbG4GMvB8G
X-Google-Smtp-Source: AA0mqf4+dSE1VsXEaZLFGskDtjzIr8M3rbqzx/Qd2CvZGDAqjzbmQXAfEBJrALOTpbZNj8iPq22e8WO/4qBcoEp9tVT7zyAnLGB/
MIME-Version: 1.0
X-Received: by 2002:a6b:4114:0:b0:6d2:76f4:e041 with SMTP id
 n20-20020a6b4114000000b006d276f4e041mr3594438ioa.11.1669185520070; Tue, 22
 Nov 2022 22:38:40 -0800 (PST)
Date:   Tue, 22 Nov 2022 22:38:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcf6d705ee1d8947@google.com>
Subject: [syzbot] WARNING in do_chunk_alloc
From:   syzbot <syzbot+88247ec7a18c953867d5@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17b83119880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=88247ec7a18c953867d5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b80ab1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dd6d45880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f765e3fd06e2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88247ec7a18c953867d5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 102 at fs/btrfs/block-group.c:3535 do_chunk_alloc+0x653/0x6c0 fs/btrfs/block-group.c:3535
Modules linked in:
CPU: 1 PID: 102 Comm: kworker/u4:4 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:do_chunk_alloc+0x653/0x6c0 fs/btrfs/block-group.c:3535
Code: 3d 8b 44 89 fe 31 c0 e8 cb a1 a0 fd 0f 0b b3 01 e9 fd fe ff ff e8 bd 03 d9 fd 48 c7 c7 a0 a9 3d 8b 89 de 31 c0 e8 ad a1 a0 fd <0f> 0b 40 b5 01 e9 fa fe ff ff e8 9e 03 d9 fd 48 c7 c7 a0 a9 3d 8b
RSP: 0018:ffffc900015c7870 EFLAGS: 00010246
RAX: 3ba9b5084e06eb00 RBX: ffffffffffffffe4 RCX: ffff88801981ba80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88801e4dc001 R08: ffffffff816e568d R09: ffffed1017304f1b
R10: ffffed1017304f1b R11: 1ffff11017304f1a R12: ffff8880733f02a0
R13: ffff888147573000 R14: 1ffff1100e67e05e R15: 00000000ffffffe4
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556f9b0c86a8 CR3: 0000000028162000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_chunk_alloc+0x6a4/0x900 fs/btrfs/block-group.c:3777
 flush_space+0x9d8/0xbc0 fs/btrfs/space-info.c:769
 btrfs_async_reclaim_metadata_space+0x8e8/0xa50 fs/btrfs/space-info.c:1083
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
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
