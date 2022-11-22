Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972856342B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiKVRnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 12:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiKVRnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 12:43:13 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12733B7CF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 09:43:12 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1431386d5bbso2057987fac.10
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYyBq2vALJTRYOY7a0ROlGZ09E8odAKlG39ZDpoUj0M=;
        b=OXotfD3GFkvA/S2ZPD37vaDthlWkprxVHql1yZkc/qgJUxUCQLtj5iVfAtLLQ3ZNP/
         DcxkE2WN0l/EwIYaWc5OGW+YK3Rdn3TWw+wRqtRU7YAMzxIMhdSkVakS36iu9+xHO92i
         Sfcex+RaXi6mG7k74pWUONzJ0oIp3zHVOsr60XAwZwSQ0hnV3mqH/vFkNbtABlrC6U2n
         5QjUZHUX+aYxQDiPDPrUBZf03s10mS+GspibWhp6RgXjXWLUTdaoOco0uGAiSc0i7JLr
         8QZi39KZmgPAst6XLu6Xa+U9ApW4LsWcKBIpcL2YCPW5iS/fnpljsKpBBWf6lgjAPqAE
         G6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYyBq2vALJTRYOY7a0ROlGZ09E8odAKlG39ZDpoUj0M=;
        b=vAtzik5hZUqsVGf8zsGfdWU7R23VhGrxL4PNyEzn7b/qjMOhSXttrueA4Rfmjte24c
         urGsfECnU+vP0csUdZYMqGZTlQgJMjICQJbInLFXxYS1u9cs7L/JiF7NO+FFq72lK7T3
         Pxg9okI/B7TIHCpMz8FwXlQVAl/ngarLnezym89FyHdrGNimKCu2nzk+sZbtHiUcJCf/
         2Pn1dwT9GxZUwZD+bznomPcoPf9n7LZS8Z3T1oV4OEwKzbkow1n6bIoDLfuBTEI0lEwE
         xER2acWFijAbvoD2RDwkosOVv0hDqoY6mEkPUGf8aO7g5Z/d55aUBQWBoaIS8spZhCoT
         +eKQ==
X-Gm-Message-State: ANoB5plnR8+tbBzfmvw+ntoCGutIqTH6/rCLcXwJluGhhhtUf9nuz0Me
        tH4RnIEPmlU8ii+CfTDkSqXWzz7d1rzYLT+eHFHNPw==
X-Google-Smtp-Source: AA0mqf4mavWm2PPyp26T4w8CfOCV2UILiEvIWO2kHLzYq0m7QtipzxjQA1WazHzCjU569bwuJ+w3HudIT4ugCBJSQxk=
X-Received: by 2002:a05:6870:b689:b0:13c:7d1c:5108 with SMTP id
 cy9-20020a056870b68900b0013c7d1c5108mr4064195oab.282.1669138991108; Tue, 22
 Nov 2022 09:43:11 -0800 (PST)
MIME-Version: 1.0
References: <00000000000089deb205ee0ddd58@google.com> <CAL3q7H6nLPD=88X8fYvogDAEUg1gwioDLSSu9zgQfO3XekNV-A@mail.gmail.com>
In-Reply-To: <CAL3q7H6nLPD=88X8fYvogDAEUg1gwioDLSSu9zgQfO3XekNV-A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Nov 2022 18:42:59 +0100
Message-ID: <CACT4Y+YnfWhSN2KWtNpXDmEdABhQi+gVBbdLsbbbB49XERnNXQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in btrfs_chunk_alloc
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     syzbot <syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 22 Nov 2022 at 16:00, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Nov 22, 2022 at 12:57 PM syzbot
> <syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    eb7081409f94 Linux 6.1-rc6
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=16aec855880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5db36e7087dcccae
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ec4c3880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13940efd880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/12e9c825ff47/disk-eb708140.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/107e5e091c9e/vmlinux-eb708140.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/605ab211617d/bzImage-eb708140.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/4d429a6dc170/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 45 at fs/btrfs/block-group.c:3535 do_chunk_alloc fs/btrfs/block-group.c:3535 [inline]
> > WARNING: CPU: 1 PID: 45 at fs/btrfs/block-group.c:3535 btrfs_chunk_alloc.cold+0x1a7/0x329 fs/btrfs/block-group.c:3777
>
> One thing the log misses, is a btrfs error message mentioning a
> transaction aborted, right before the stack trace.
> Like this:
>
> [107754.496004] ------------[ cut here ]------------
> [107754.496687] BTRFS: Transaction aborted (error -28)
> [107754.497422] WARNING: CPU: 2 PID: 1267566 at
> fs/btrfs/block-group.c:3613 btrfs_chunk_alloc.cold+0x101/0x412 [btrfs]
> (...)
>
> That is what I got by running the C reproducer. It's the same stack
> trace, but includes the expected transaction aborted error message.
> Don't know why, but all reports from syzbot usually miss that error message.

Hi Filipe,

That's because btrfs_abort_transaction uses KERN_DEBUG (the lowest
level output) to print it:
https://elixir.bootlin.com/linux/v6.1-rc6/source/fs/btrfs/ctree.h#L3813
I think warning messages should match the warning output level (remove
KERN_DEBUG).



> Also, this is failing with ENOSPC because somehow the reproducer
> manages to mount a 16M loop device file,
> which will make gather_device_info() not able to find any device (in
> case it were a multiple devices fs)
> able to allocate a chunk of 67108864 bytes (64M), as the only
> available device has a size (device->total_bytes) of 16777216 (16M).
>
> mkfs.btrfs should refuse to build a fs on such a small device, like this:
>
> $ fallocate -l 16M device
> $ mkfs.btrfs -f device
> btrfs-progs v6.0.1
> See http://btrfs.wiki.kernel.org for more information.
>
> ERROR: 'device' is too small to make a usable filesystem
> ERROR: minimum size for each btrfs device is 114294784
>
> Somehow the C reproducer (which is not really human readable), is able
> to create and mount a fs on 16M loop device:
>
> $ df -h
> Filesystem      Size  Used Avail Use% Mounted on
> udev            7.6G     0  7.6G   0% /dev
> (...)
> tmpfs           1.6G  8.0K  1.6G   1% /run/user/1000
> /dev/loop0       16M  960K   11M   8% /mnt/sdj/file0
>
> So no wonder we fail with ENOSPC and a transaction aborts.
> The stack trace on transaction abort with -ENOSPC is actually useful
> as it tells us where to look in case there's a bug
> related with space allocation.
>
> So the only bug here is the ability to create and mount a btrfs fs on
> a 16M device.
>
>
> > Modules linked in:
> > CPU: 1 PID: 45 Comm: kworker/u4:3 Not tainted 6.1.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> > Workqueue: events_unbound btrfs_async_reclaim_metadata_space
> > RIP: 0010:do_chunk_alloc fs/btrfs/block-group.c:3535 [inline]
> > RIP: 0010:btrfs_chunk_alloc.cold+0x1a7/0x329 fs/btrfs/block-group.c:3777
> > Code: 89 c7 89 c6 88 44 24 4f e8 5d 2e c7 f7 45 84 ff 0f 84 6e 01 00 00 e8 df 31 c7 f7 44 89 f6 48 c7 c7 c0 5c 98 8a e8 fb a4 f2 ff <0f> 0b e9 10 ff ff ff e8 c4 31 c7 f7 48 8b 54 24 38 b8 ff ff 37 00
> > RSP: 0018:ffffc90000d6fa70 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
> > RDX: ffff888018452080 RSI: ffffffff8164973c RDI: fffff520001adf40
> > RBP: ffff88807bed9800 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000080000000 R11: 0000000000000000 R12: ffff888075d88898
> > R13: ffff888020971000 R14: ffffffffffffffe4 R15: 0000000075d88801
> > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa773a78250 CR3: 000000007d62e000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  flush_space+0x9ce/0xe90 fs/btrfs/space-info.c:769
> >  btrfs_async_reclaim_metadata_space+0x53f/0xc00 fs/btrfs/space-info.c:1083
> >  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
> >  worker_thread+0x669/0x1090 kernel/workqueue.c:2436
> >  kthread+0x2e8/0x3a0 kernel/kthread.c:376
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAL3q7H6nLPD%3D88X8fYvogDAEUg1gwioDLSSu9zgQfO3XekNV-A%40mail.gmail.com.
