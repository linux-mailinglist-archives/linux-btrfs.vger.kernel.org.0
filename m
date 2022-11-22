Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC46633FB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 16:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiKVPBa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 10:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiKVPAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 10:00:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6A5DB9D;
        Tue, 22 Nov 2022 07:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B30D1B81BAF;
        Tue, 22 Nov 2022 15:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B031C433D6;
        Tue, 22 Nov 2022 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669129200;
        bh=3VyEGKV0nP5rpXczkOvIWSchzdL0fqzmYYCvjb+HsdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YafNO426NbF7l2Fv2I5T7FYklrk8hhLHosDqzd1MsK3X048tuKXRikp7/MN2ULLgk
         1Ihfgnt23Bfv+7nGVS5p6j03qnwZjS6yiOm9RSdYvDup2y83d90b4GoRlaRSxjMII4
         9bTXGSHAEHhogCqMZHFKGAlSQmFqnZ+05e1fYlrBc8MzUXjAscT/606ARppKYV4QTB
         m3TjlVeYDqiz87gFJ1ixnH1l8AvZOLeZG/cJ19BHNlYBS22NIdYJbH1sMgLU/auAKE
         mQQHf0QxRFhzY/KmsboDVsVK26lCGEtROoozkVfMqXyxJ/KysDjRs86cpY/zxf8UoU
         AWWchSqj/S5uQ==
Received: by mail-oi1-f174.google.com with SMTP id n205so16096247oib.1;
        Tue, 22 Nov 2022 07:00:00 -0800 (PST)
X-Gm-Message-State: ANoB5pnn5b1BBA6DZkk1fCsbxwpRCntuQxJRAoCPbnYZeux92YNnJZiK
        Mio1WurRHSJAK43JFM500H33t4lljD/95+Kggfs=
X-Google-Smtp-Source: AA0mqf71Rq4ULunMvybvbyiH6av0ogbdp7pcTFfgnHccIwulrSw4baiZfTSNFJbBUWb+adPM1n9/pq1abGv8pVc2TgY=
X-Received: by 2002:a05:6808:1287:b0:359:dc32:4f9e with SMTP id
 a7-20020a056808128700b00359dc324f9emr3531559oiw.92.1669129199559; Tue, 22 Nov
 2022 06:59:59 -0800 (PST)
MIME-Version: 1.0
References: <00000000000089deb205ee0ddd58@google.com>
In-Reply-To: <00000000000089deb205ee0ddd58@google.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 22 Nov 2022 14:59:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6nLPD=88X8fYvogDAEUg1gwioDLSSu9zgQfO3XekNV-A@mail.gmail.com>
Message-ID: <CAL3q7H6nLPD=88X8fYvogDAEUg1gwioDLSSu9zgQfO3XekNV-A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in btrfs_chunk_alloc
To:     syzbot <syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 22, 2022 at 12:57 PM syzbot
<syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    eb7081409f94 Linux 6.1-rc6
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16aec855880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5db36e7087dcccae
> dashboard link: https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ec4c3880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13940efd880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12e9c825ff47/disk-eb708140.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/107e5e091c9e/vmlinux-eb708140.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/605ab211617d/bzImage-eb708140.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4d429a6dc170/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 45 at fs/btrfs/block-group.c:3535 do_chunk_alloc fs/btrfs/block-group.c:3535 [inline]
> WARNING: CPU: 1 PID: 45 at fs/btrfs/block-group.c:3535 btrfs_chunk_alloc.cold+0x1a7/0x329 fs/btrfs/block-group.c:3777

One thing the log misses, is a btrfs error message mentioning a
transaction aborted, right before the stack trace.
Like this:

[107754.496004] ------------[ cut here ]------------
[107754.496687] BTRFS: Transaction aborted (error -28)
[107754.497422] WARNING: CPU: 2 PID: 1267566 at
fs/btrfs/block-group.c:3613 btrfs_chunk_alloc.cold+0x101/0x412 [btrfs]
(...)

That is what I got by running the C reproducer. It's the same stack
trace, but includes the expected transaction aborted error message.
Don't know why, but all reports from syzbot usually miss that error message.

Also, this is failing with ENOSPC because somehow the reproducer
manages to mount a 16M loop device file,
which will make gather_device_info() not able to find any device (in
case it were a multiple devices fs)
able to allocate a chunk of 67108864 bytes (64M), as the only
available device has a size (device->total_bytes) of 16777216 (16M).

mkfs.btrfs should refuse to build a fs on such a small device, like this:

$ fallocate -l 16M device
$ mkfs.btrfs -f device
btrfs-progs v6.0.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: 'device' is too small to make a usable filesystem
ERROR: minimum size for each btrfs device is 114294784

Somehow the C reproducer (which is not really human readable), is able
to create and mount a fs on 16M loop device:

$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            7.6G     0  7.6G   0% /dev
(...)
tmpfs           1.6G  8.0K  1.6G   1% /run/user/1000
/dev/loop0       16M  960K   11M   8% /mnt/sdj/file0

So no wonder we fail with ENOSPC and a transaction aborts.
The stack trace on transaction abort with -ENOSPC is actually useful
as it tells us where to look in case there's a bug
related with space allocation.

So the only bug here is the ability to create and mount a btrfs fs on
a 16M device.


> Modules linked in:
> CPU: 1 PID: 45 Comm: kworker/u4:3 Not tainted 6.1.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Workqueue: events_unbound btrfs_async_reclaim_metadata_space
> RIP: 0010:do_chunk_alloc fs/btrfs/block-group.c:3535 [inline]
> RIP: 0010:btrfs_chunk_alloc.cold+0x1a7/0x329 fs/btrfs/block-group.c:3777
> Code: 89 c7 89 c6 88 44 24 4f e8 5d 2e c7 f7 45 84 ff 0f 84 6e 01 00 00 e8 df 31 c7 f7 44 89 f6 48 c7 c7 c0 5c 98 8a e8 fb a4 f2 ff <0f> 0b e9 10 ff ff ff e8 c4 31 c7 f7 48 8b 54 24 38 b8 ff ff 37 00
> RSP: 0018:ffffc90000d6fa70 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
> RDX: ffff888018452080 RSI: ffffffff8164973c RDI: fffff520001adf40
> RBP: ffff88807bed9800 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: ffff888075d88898
> R13: ffff888020971000 R14: ffffffffffffffe4 R15: 0000000075d88801
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa773a78250 CR3: 000000007d62e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  flush_space+0x9ce/0xe90 fs/btrfs/space-info.c:769
>  btrfs_async_reclaim_metadata_space+0x53f/0xc00 fs/btrfs/space-info.c:1083
>  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>  worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>  kthread+0x2e8/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
