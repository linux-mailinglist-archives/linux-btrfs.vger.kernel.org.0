Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E43D6404EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 11:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiLBKnJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 05:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiLBKm7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 05:42:59 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0512D22BCD
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 02:42:57 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1441d7d40c6so5159743fac.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2WWZGY2UJ6Mw5pzN1Rzf/WQxo3MIjGeO42YFmnTP+o=;
        b=jMsvyUVpYL2bPwRFxgiDVHjZTql3DcreownCQb70DjED+4zoKCtik0aqLBvWs02Fi5
         Rv9ZfsWPgRXTahK+cD+eAx9Eo4lsE8EW+BdG93RAVXgloC4mtEdvYT0ExA2WdvPPa86D
         ulXRBJCISn/uUoKJpErahP6EzFOZ6dBl/3dW85PtWAx02cn/oUOWpM61w8CQ8LM6IdkV
         m+SZJdLm43J/7MNWK7B8ADbfXFYUHnlvzrhO67A+OhM1y1skRmH2JL1LcKHHTIX2FIf5
         zRG5pFZZleJclV6n2XwFk8JlEeHbh+JlQQPwqmm80yA+VO6CWRk62YHU8wGgiZqkwtGR
         QDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2WWZGY2UJ6Mw5pzN1Rzf/WQxo3MIjGeO42YFmnTP+o=;
        b=odarvDJ5GXyA8co42x3Wh2FoQxOpfqlhUz45K7EYH9oYwue0ewPeu4Pq5mye7f0kzc
         1hZJSnF/hueWaSR7yNidS1ZP27mAF1hznLuhlx/Kn4chilu600LDZwwpkgc6lfUH6b/2
         ALWkPvOLFqMYonBcRn0/dD+1M1cdvj+jEyWYa5PLC/eFZFqgkqqz69hVHU2W3YNzCqlQ
         zXQ7tutFHk0AI6fc6mnH7XMSlmFkWpDjaoqZap5VFhx6EzDp8sw+IERayomrPvf+Tapp
         KOWIh0VDSDpjzdQVnrGV1pcADw3chkaTfxJW5/Wry3H3YYBgOVLNcFHgA04O7p+QkiTN
         WgMg==
X-Gm-Message-State: ANoB5pkaBcs3El8AWQ59ySGlnWcvGUQ28bQUanm8O+9MIdkjQoexMk5Y
        cZbMZtqkgeqOZw5SUQdqlX3Bv9KlPPmru8nScwXDEQ==
X-Google-Smtp-Source: AA0mqf76xg7PzPODHSLv4uGxeInCDy5Qp4osAqpm4SubRvSowlLlA1KZ+OcDeDApEFEC1PFjmL1sqTJHHWRQ+L+KSjU=
X-Received: by 2002:a05:6871:404e:b0:144:4546:61e7 with SMTP id
 ky14-20020a056871404e00b00144454661e7mr453286oab.282.1669977775906; Fri, 02
 Dec 2022 02:42:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ceb65c05ee4beb9d@google.com> <f853d5a8-1e31-419a-a6a5-a1f9c7dbd897n@googlegroups.com>
In-Reply-To: <f853d5a8-1e31-419a-a6a5-a1f9c7dbd897n@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Dec 2022 11:42:44 +0100
Message-ID: <CACT4Y+Zw8f982C-qgvjkUuEtuw2UZApT6J18NfF8oE6S+EgvJA@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in __clear_extent_bit
To:     Pawel Suchanecki <subdcc@gmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
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

On Thu, 1 Dec 2022 at 23:48, Pawel Suchanecki <subdcc@gmail.com> wrote:
>
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit: c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
>> git tree: upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1675aebb880000
>> kernel config: https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
>> dashboard link: https://syzkaller.appspot.com/bug?extid=5338ef8374ed180ba281
>> compiler: Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=103324e3880000
>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=12e7e1c9880000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb11fb.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb11fb.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/c27a26bacb83/mount_0.gz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+5338ef...@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> kernel BUG at fs/btrfs/extent-io-tree.c:639!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 3632 Comm: syz-executor118 Not tainted 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>> RIP: 0010:__clear_extent_bit+0xbbb/0xc60 fs/btrfs/extent-io-tree.c:639
>> Code: 1c 2f fe e9 cf fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 0e ff ff ff 48 89 ef e8 5f 1c 2f fe e9 01 ff ff ff e8 05 04 db fd <0f> 0b e8 fe 03 db fd 48 8b 44 24 08 48 83 c0 08 48 89 c5 48 c1 e8
>> RSP: 0018:ffffc90003c7f7a8 EFLAGS: 00010293
>> RAX: ffffffff83af946b RBX: 0000000000000000 RCX: ffff88807de80000
>> RDX: 0000000000000000 RSI: ffffffff8aedc420 RDI: ffffffff8b4b3ae0
>> RBP: 0000000000002fff R08: 00000000ffffffff R09: fffffbfff1a42e97
>> R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: 000000000004ffff
>> R13: ffff88807eb05b40 R14: 1ffff1100fd60b68 R15: 0000000000002000
>> FS: 0000555557044300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020002000 CR3: 000000007e9f2000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>> <TASK>
>> try_release_extent_state fs/btrfs/extent_io.c:3391 [inline]
>> try_release_extent_mapping+0x4e5/0x560 fs/btrfs/extent_io.c:3487
>> __btrfs_release_folio fs/btrfs/inode.c:8175 [inline]
>> btrfs_release_folio+0x126/0x340 fs/btrfs/inode.c:8188
>> mapping_evict_folio+0x24d/0x570 mm/truncate.c:279
>> invalidate_mapping_pagevec+0x37d/0x7c0 mm/truncate.c:528
>> btrfs_direct_write fs/btrfs/file.c:1917 [inline]
>> btrfs_do_write_iter+0x112e/0x1260 fs/btrfs/file.c:1980
>> call_write_iter include/linux/fs.h:2191 [inline]
>> new_sync_write fs/read_write.c:491 [inline]
>> vfs_write+0x7dc/0xc50 fs/read_write.c:584
>> ksys_write+0x177/0x2a0 fs/read_write.c:637
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7fcc98e18a19
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fffcb04cad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcc98e18a19
>> RDX: 0000000000000004 RSI: 0000000020000000 RDI: 0000000000000004
>> RBP: 00007fffcb04cb00 R08: 0000000000000002 R09: 00007fffcb04cb10
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
>> R13: 00007fffcb04cb40 R14: 00007fffcb04cb20 R15: 0000000000000000
>> </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:__clear_extent_bit+0xbbb/0xc60 fs/btrfs/extent-io-tree.c:639
>> Code: 1c 2f fe e9 cf fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 0e ff ff ff 48 89 ef e8 5f 1c 2f fe e9 01 ff ff ff e8 05 04 db fd <0f> 0b e8 fe 03 db fd 48 8b 44 24 08 48 83 c0 08 48 89 c5 48 c1 e8
>> RSP: 0018:ffffc90003c7f7a8 EFLAGS: 00010293
>> RAX: ffffffff83af946b RBX: 0000000000000000 RCX: ffff88807de80000
>> RDX: 0000000000000000 RSI: ffffffff8aedc420 RDI: ffffffff8b4b3ae0
>> RBP: 0000000000002fff R08: 00000000ffffffff R09: fffffbfff1a42e97
>> R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: 000000000004ffff
>> R13: ffff88807eb05b40 R14: 1ffff1100fd60b68 R15: 0000000000002000
>> FS: 0000555557044300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020002000 CR3: 000000007e9f2000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzk...@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
>
> Hi,
>
> This bug is to be fixed by recently published patch by Josef Bacik, named: [PATCH 3/3] btrfs: do not panic if we can't allocate a prealloc extent state [1].
>
> [1] https://lore.kernel.org/all/97fb0828deb341efe99ef2bc35cda0eccc5963de.1665755095.git.josef@toxicpanda.com
>
> Thanks,
> Pawel

Let's tell syzbot about the fix so that it reports similar bugs in future:

#syz fix:
btrfs: do not panic if we can't allocate a prealloc extent state
