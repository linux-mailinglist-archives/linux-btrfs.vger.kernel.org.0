Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13987E2E10
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 21:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjKFUUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKFUUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 15:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A20D75;
        Mon,  6 Nov 2023 12:20:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDBAC433C8;
        Mon,  6 Nov 2023 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699302014;
        bh=ekujjvi8RS42//7/8F4SRHBAC5/p/7Prwv5G3MrhLrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJWrTK887hpU3DCPmEEplv5u2zbVfH05jpyFTqRoJrfAUC5w9AGNpvfT52YrsolZs
         Wscxx/a/dBa45B53uLMeAOMR9UxFYciNL/LRLcfe2RWm+iKBr80a/xBLP81wxbDsEq
         vQQKhvYc0HA5NqxRvmgm1L8BODTXS8anvgQyE6KPIX2cILDTtAP6uBpdOSaHZr2Xgs
         7Q5rput9GqfNiSFWC9LAy4Z9EgKMWFTpeW+F1rQQbNoacfDmAuBYx5JQByN/Xcal58
         gtdEMFtuqP7J9wFGSR3GugIAOt4GWy6J/MbhevBcwG86bAjoxE574pQBFZt9OqUh6X
         jXo2+Pj73ZdkQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso28284566b.2;
        Mon, 06 Nov 2023 12:20:13 -0800 (PST)
X-Gm-Message-State: AOJu0YxaJvMTEr5j4iIv87QSekyAduROougKgbksb1xX+b3vWZihDOAQ
        f9oYAII2iwuUxzBQlQRwtP8N7ulROGcn5ihmgIQ=
X-Google-Smtp-Source: AGHT+IF2tLpAh8ZaxZMrEekDHhrr1YK4Mgm0S0K26K6vFFfjn1sriLkmpvn9chTRaqerKcosZplVN6BYhrUA6QkxAIQ=
X-Received: by 2002:a17:907:7255:b0:9c3:8242:e665 with SMTP id
 ds21-20020a170907725500b009c38242e665mr14289406ejc.8.1699302012434; Mon, 06
 Nov 2023 12:20:12 -0800 (PST)
MIME-Version: 1.0
References: <00000000000004769106097f9a34@google.com>
In-Reply-To: <00000000000004769106097f9a34@google.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 6 Nov 2023 20:19:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5u6fDxpmdOzS6EL1zC2N-Bvn1=srJFfC4TYkoDwndGRA@mail.gmail.com>
Message-ID: <CAL3q7H5u6fDxpmdOzS6EL1zC2N-Bvn1=srJFfC4TYkoDwndGRA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_add_delayed_tree_ref
To:     syzbot <syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 6, 2023 at 5:59=E2=80=AFPM syzbot
<syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8f6f76a6a29f Merge tag 'mm-nonmm-stable-2023-11-02-14-08'=
 ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15169b8768000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5ea2285f517f9=
4d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd3ddc6dcc6386de=
a398b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D179c2ecf680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D149dff40e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dfead0cc157b/dis=
k-8f6f76a6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c2ab876430bc/vmlinu=
x-8f6f76a6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e9cd314888e8/b=
zImage-8f6f76a6.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4a497ff0ef=
1a/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com

#syz fix: btrfs: fix qgroup record leaks when using simple quotas

https://lore.kernel.org/linux-btrfs/2431d473c04bede4387c081007d532758fcd2f2=
8.1699301753.git.fdmanana@suse.com/

>
> executing program
> BUG: memory leak
> unreferenced object 0xffff88810891e940 (size 64):
>   comm "syz-executor244", pid 5031, jiffies 4294941874 (age 13.150s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 e0 51 00 00 00 00 00  ..........Q.....
>   backtrace:
>     [<ffffffff816336ad>] kmemleak_alloc_recursive include/linux/kmemleak.=
h:42 [inline]
>     [<ffffffff816336ad>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff816336ad>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff816336ad>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:35=
17
>     [<ffffffff8157e505>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
>     [<ffffffff82135480>] kmalloc include/linux/slab.h:600 [inline]
>     [<ffffffff82135480>] kzalloc include/linux/slab.h:721 [inline]
>     [<ffffffff82135480>] btrfs_add_delayed_tree_ref+0x550/0x5b0 fs/btrfs/=
delayed-ref.c:1045
>     [<ffffffff820874bb>] btrfs_alloc_tree_block+0x65b/0x7c0 fs/btrfs/exte=
nt-tree.c:5153
>     [<ffffffff8206c15e>] btrfs_force_cow_block+0x1be/0xb30 fs/btrfs/ctree=
.c:563
>     [<ffffffff8206cbf8>] btrfs_cow_block+0x128/0x3b0 fs/btrfs/ctree.c:741
>     [<ffffffff82073609>] btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:=
2095
>     [<ffffffff82074fa3>] btrfs_insert_empty_items+0x43/0xc0 fs/btrfs/ctre=
e.c:4285
>     [<ffffffff820b8a34>] btrfs_create_new_inode+0x354/0xfe0 fs/btrfs/inod=
e.c:6283
>     [<ffffffff820b99e7>] btrfs_create_common+0xf7/0x190 fs/btrfs/inode.c:=
6511
>     [<ffffffff820b9c12>] btrfs_create+0x72/0x90 fs/btrfs/inode.c:6551
>     [<ffffffff816b673f>] lookup_open fs/namei.c:3477 [inline]
>     [<ffffffff816b673f>] open_last_lookups fs/namei.c:3546 [inline]
>     [<ffffffff816b673f>] path_openat+0x17df/0x1d60 fs/namei.c:3776
>     [<ffffffff816b78e1>] do_filp_open+0xd1/0x1c0 fs/namei.c:3809
>     [<ffffffff816906c4>] do_sys_openat2+0xf4/0x150 fs/open.c:1440
>     [<ffffffff81690ec5>] do_sys_open fs/open.c:1455 [inline]
>     [<ffffffff81690ec5>] __do_sys_open fs/open.c:1463 [inline]
>     [<ffffffff81690ec5>] __se_sys_open fs/open.c:1459 [inline]
>     [<ffffffff81690ec5>] __x64_sys_open+0xa5/0xf0 fs/open.c:1459
>     [<ffffffff84b5dd4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inlin=
e]
>     [<ffffffff84b5dd4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c=
:82
>
> BUG: memory leak
> unreferenced object 0xffff88810891e980 (size 64):
>   comm "syz-executor244", pid 5031, jiffies 4294941874 (age 13.150s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 69 00 00 00 00 00  ..........i.....
>   backtrace:
>     [<ffffffff816336ad>] kmemleak_alloc_recursive include/linux/kmemleak.=
h:42 [inline]
>     [<ffffffff816336ad>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff816336ad>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff816336ad>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:35=
17
>     [<ffffffff8157e505>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
>     [<ffffffff82135480>] kmalloc include/linux/slab.h:600 [inline]
>     [<ffffffff82135480>] kzalloc include/linux/slab.h:721 [inline]
>     [<ffffffff82135480>] btrfs_add_delayed_tree_ref+0x550/0x5b0 fs/btrfs/=
delayed-ref.c:1045
>     [<ffffffff82083f81>] btrfs_free_tree_block+0x131/0x450 fs/btrfs/exten=
t-tree.c:3432
>     [<ffffffff8206c678>] btrfs_force_cow_block+0x6d8/0xb30 fs/btrfs/ctree=
.c:618
>     [<ffffffff8206cbf8>] btrfs_cow_block+0x128/0x3b0 fs/btrfs/ctree.c:741
>     [<ffffffff82073609>] btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:=
2095
>     [<ffffffff82074fa3>] btrfs_insert_empty_items+0x43/0xc0 fs/btrfs/ctre=
e.c:4285
>     [<ffffffff820b8a34>] btrfs_create_new_inode+0x354/0xfe0 fs/btrfs/inod=
e.c:6283
>     [<ffffffff820b99e7>] btrfs_create_common+0xf7/0x190 fs/btrfs/inode.c:=
6511
>     [<ffffffff820b9c12>] btrfs_create+0x72/0x90 fs/btrfs/inode.c:6551
>     [<ffffffff816b673f>] lookup_open fs/namei.c:3477 [inline]
>     [<ffffffff816b673f>] open_last_lookups fs/namei.c:3546 [inline]
>     [<ffffffff816b673f>] path_openat+0x17df/0x1d60 fs/namei.c:3776
>     [<ffffffff816b78e1>] do_filp_open+0xd1/0x1c0 fs/namei.c:3809
>     [<ffffffff816906c4>] do_sys_openat2+0xf4/0x150 fs/open.c:1440
>     [<ffffffff81690ec5>] do_sys_open fs/open.c:1455 [inline]
>     [<ffffffff81690ec5>] __do_sys_open fs/open.c:1463 [inline]
>     [<ffffffff81690ec5>] __se_sys_open fs/open.c:1459 [inline]
>     [<ffffffff81690ec5>] __x64_sys_open+0xa5/0xf0 fs/open.c:1459
>     [<ffffffff84b5dd4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inlin=
e]
>     [<ffffffff84b5dd4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c=
:82
>
> BUG: memory leak
> unreferenced object 0xffff88810891ea00 (size 64):
>   comm "syz-executor244", pid 5031, jiffies 4294941874 (age 13.150s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 f0 51 00 00 00 00 00  ..........Q.....
>   backtrace:
>     [<ffffffff816336ad>] kmemleak_alloc_recursive include/linux/kmemleak.=
h:42 [inline]
>     [<ffffffff816336ad>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff816336ad>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff816336ad>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:35=
17
>     [<ffffffff8157e505>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
>     [<ffffffff82135480>] kmalloc include/linux/slab.h:600 [inline]
>     [<ffffffff82135480>] kzalloc include/linux/slab.h:721 [inline]
>     [<ffffffff82135480>] btrfs_add_delayed_tree_ref+0x550/0x5b0 fs/btrfs/=
delayed-ref.c:1045
>     [<ffffffff820874bb>] btrfs_alloc_tree_block+0x65b/0x7c0 fs/btrfs/exte=
nt-tree.c:5153
>     [<ffffffff8206c15e>] btrfs_force_cow_block+0x1be/0xb30 fs/btrfs/ctree=
.c:563
>     [<ffffffff8206cbf8>] btrfs_cow_block+0x128/0x3b0 fs/btrfs/ctree.c:741
>     [<ffffffff82073609>] btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:=
2095
>     [<ffffffff82074fa3>] btrfs_insert_empty_items+0x43/0xc0 fs/btrfs/ctre=
e.c:4285
>     [<ffffffff820b8a34>] btrfs_create_new_inode+0x354/0xfe0 fs/btrfs/inod=
e.c:6283
>     [<ffffffff820b99e7>] btrfs_create_common+0xf7/0x190 fs/btrfs/inode.c:=
6511
>     [<ffffffff820b9c12>] btrfs_create+0x72/0x90 fs/btrfs/inode.c:6551
>     [<ffffffff816b673f>] lookup_open fs/namei.c:3477 [inline]
>     [<ffffffff816b673f>] open_last_lookups fs/namei.c:3546 [inline]
>     [<ffffffff816b673f>] path_openat+0x17df/0x1d60 fs/namei.c:3776
>     [<ffffffff816b78e1>] do_filp_open+0xd1/0x1c0 fs/namei.c:3809
>     [<ffffffff816906c4>] do_sys_openat2+0xf4/0x150 fs/open.c:1440
>     [<ffffffff81690ec5>] do_sys_open fs/open.c:1455 [inline]
>     [<ffffffff81690ec5>] __do_sys_open fs/open.c:1463 [inline]
>     [<ffffffff81690ec5>] __se_sys_open fs/open.c:1459 [inline]
>     [<ffffffff81690ec5>] __x64_sys_open+0xa5/0xf0 fs/open.c:1459
>     [<ffffffff84b5dd4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inlin=
e]
>     [<ffffffff84b5dd4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c=
:82
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
