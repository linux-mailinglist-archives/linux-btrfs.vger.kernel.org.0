Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC604CBC38
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiCCLOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 06:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCLOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 06:14:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19065D22;
        Thu,  3 Mar 2022 03:13:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr20so9855745ejc.6;
        Thu, 03 Mar 2022 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+dLeth0+lye1eO3uzqCkxacCLxEgJk91A6FjstoVs8=;
        b=DpSQ3SidVwnmtSVw+FWr4YkGClAfigLPxL56hVoIdJqFdv0qo1ikk1Y7scdoNOuSVS
         ++XIBCVvHuiJIQLpR/OTi9OYm0pGC9hGbxiS26NMOLYah29YWpGEyASLYWhVtjwgDXfV
         MJixrh73k5HX2B/GCGLGF72X+udoCQ3ipePcEa+qRK34uhNo0T3lwGbQ2McodftMKc2z
         +Lz4RjjYEuWYBZdUXDlUL5lbMJRT4oUvZtZE7ujXbsTBmF794fSu5C36Slwom/piQVc3
         LGKS8JIn1Y39ZgXGnuJxIwiNUxIRVYz7IreL7bNFrKLpMI5rLssJRo6stFUKf2gobpb0
         w9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+dLeth0+lye1eO3uzqCkxacCLxEgJk91A6FjstoVs8=;
        b=Kc61wn4ccDo43XFg7ecYdj64/mRM0jyZRMMjNjSgwo1GoWfvcTc3jjQjlHlpGy6k2P
         vGWypGIvTqUH2sUQmjFx5KGjz7bIkkhv+UwQ6b1yHqkLdxzmn4xK+3d3UI2FSnulMHU1
         925ZAQUMINQP8JmNPHn75+PlCubmUo7Ju7L+KEqPCO7hbzHgtX3Kl+SartkrG/AkueOh
         FMmwTb+z67jhx5ajfJNDVdoW4Tu43z91TGNioe18ChjBIZuwmYBVaistNma96QgMjcvR
         9/AVii9uxmnoClzetxG1U0RxJbXCyyOufvmG7QAyz9KKlaM66S1SP7nIf7xZJQxjz8v4
         j4Xw==
X-Gm-Message-State: AOAM5335dZmkL1SMAaLQ7MlkiQv/pghwHpEy0m0+/pcvzx7sqxLE7WjU
        lzgAg/bgENKOdJ3VZ7c5ByQkdBMWDibKVgXqgx8=
X-Google-Smtp-Source: ABdhPJz7WEuuD9p/6GfFcEH8JGCkFOVgUOqTxKdz25EEY8F6mC4zCbyvBH95CegWbwC7F8jxcXWD3WA0zaFnUoS1wCw=
X-Received: by 2002:a17:907:3da0:b0:6da:8dbc:f4bc with SMTP id
 he32-20020a1709073da000b006da8dbcf4bcmr2302826ejc.708.1646306013972; Thu, 03
 Mar 2022 03:13:33 -0800 (PST)
MIME-Version: 1.0
References: <00000000000066b78e05d94df48b@google.com>
In-Reply-To: <00000000000066b78e05d94df48b@google.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 3 Mar 2022 19:13:07 +0800
Message-ID: <CAD-N9QXXhOPSH=Mi0n78Qoriq=aCOxzoWXux3hwEaPQdkwdryQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in btrfs_scan_one_device (2)
To:     syzbot <syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com>
Cc:     clm@fb.com, David Sterba <dsterba@suse.com>, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 3, 2022 at 6:35 PM syzbot
<syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2293be58d6a1 Merge tag 'trace-v5.17-rc4' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f8b2d4700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28851401b410e5
> dashboard link: https://syzkaller.appspot.com/bug?extid=82650a4e0ed38f218363
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152ee696700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11739502700000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in btrfs_printk+0x395/0x425 fs/btrfs/super.c:244
> Read of size 8 at addr ffff8880237906d8 by task udevd/3694
>
> CPU: 1 PID: 3694 Comm: udevd Not tainted 5.17.0-rc5-syzkaller-00306-g2293be58d6a1 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0x8d/0x303 mm/kasan/report.c:255
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>  btrfs_printk+0x395/0x425 fs/btrfs/super.c:244
>  device_list_add.cold+0xd7/0x2ed fs/btrfs/volumes.c:957

From this crashing trace, the reason is similar with commit 0697d9a61099.

Fix this by modifying another site using fs_info.

I will push a patch request later.

>  btrfs_scan_one_device+0x4c7/0x5c0 fs/btrfs/volumes.c:1387
>  btrfs_control_ioctl+0x12a/0x2d0 fs/btrfs/super.c:2409
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f86e0e090e7
> Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 9d 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffcb6ec2788 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f86e0e090e7
> RDX: 00007ffcb6ec2798 RSI: 0000000090009427 RDI: 0000000000000009
> RBP: 0000000000000009 R08: 000055f3f60246f0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffcb6ec37d8 R14: 000055f3f7c4fbc0 R15: 00007f86e0cac6c0
>  </TASK>
>
> Allocated by task 3672:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:436 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:515 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:474 [inline]
>  __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:524
>  kmalloc_node include/linux/slab.h:604 [inline]
>  kvmalloc_node+0x97/0x100 mm/util.c:580
>  kvmalloc include/linux/slab.h:731 [inline]
>  kvzalloc include/linux/slab.h:739 [inline]
>  btrfs_mount_root+0x118/0xc10 fs/btrfs/super.c:1665
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  fc_mount fs/namespace.c:1030 [inline]
>  vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1060
>  vfs_kern_mount+0x3c/0x60 fs/namespace.c:1047
>  btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1784
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3024 [inline]
>  path_mount+0x1320/0x1fa0 fs/namespace.c:3354
>  do_mount fs/namespace.c:3367 [inline]
>  __do_sys_mount fs/namespace.c:3575 [inline]
>  __se_sys_mount fs/namespace.c:3552 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3552
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Freed by task 3672:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
>  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
>  ____kasan_slab_free mm/kasan/common.c:366 [inline]
>  ____kasan_slab_free+0xff/0x140 mm/kasan/common.c:328
>  kasan_slab_free include/linux/kasan.h:236 [inline]
>  __cache_free mm/slab.c:3437 [inline]
>  kfree+0xf8/0x2b0 mm/slab.c:3794
>  kvfree+0x42/0x50 mm/util.c:613
>  deactivate_locked_super+0x94/0x160 fs/super.c:332
>  btrfs_mount_root+0x78e/0xc10 fs/btrfs/super.c:1730
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  fc_mount fs/namespace.c:1030 [inline]
>  vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1060
>  vfs_kern_mount+0x3c/0x60 fs/namespace.c:1047
>  btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1784
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3024 [inline]
>  path_mount+0x1320/0x1fa0 fs/namespace.c:3354
>  do_mount fs/namespace.c:3367 [inline]
>  __do_sys_mount fs/namespace.c:3575 [inline]
>  __se_sys_mount fs/namespace.c:3552 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3552
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> The buggy address belongs to the object at ffff888023790000
>  which belongs to the cache kmalloc-16k of size 16384
> The buggy address is located 1752 bytes inside of
>  16384-byte region [ffff888023790000, ffff888023794000)
> The buggy address belongs to the page:
> page:ffffea00008de400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23790
> head:ffffea00008de400 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 ffffea0000990008 ffffea000098fe08 ffff888010c40b00
> raw: 0000000000000000 ffff888023790000 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x2520c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 3672, ts 53936584194, free_ts 53419420055
>  prep_new_page mm/page_alloc.c:2434 [inline]
>  get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
>  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
>  __alloc_pages_node include/linux/gfp.h:572 [inline]
>  kmem_getpages mm/slab.c:1378 [inline]
>  cache_grow_begin+0x75/0x390 mm/slab.c:2584
>  cache_alloc_refill+0x27f/0x380 mm/slab.c:2957
>  ____cache_alloc mm/slab.c:3040 [inline]
>  ____cache_alloc mm/slab.c:3023 [inline]
>  slab_alloc_node mm/slab.c:3241 [inline]
>  kmem_cache_alloc_node_trace+0x49c/0x5b0 mm/slab.c:3609
>  __do_kmalloc_node mm/slab.c:3631 [inline]
>  __kmalloc_node+0x38/0x60 mm/slab.c:3639
>  kmalloc_node include/linux/slab.h:604 [inline]
>  kvmalloc_node+0x97/0x100 mm/util.c:580
>  kvmalloc include/linux/slab.h:731 [inline]
>  kvzalloc include/linux/slab.h:739 [inline]
>  btrfs_mount_root+0x118/0xc10 fs/btrfs/super.c:1665
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  fc_mount fs/namespace.c:1030 [inline]
>  vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1060
>  vfs_kern_mount+0x3c/0x60 fs/namespace.c:1047
>  btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1784
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3024 [inline]
>  path_mount+0x1320/0x1fa0 fs/namespace.c:3354
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1352 [inline]
>  free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
>  free_unref_page_prepare mm/page_alloc.c:3325 [inline]
>  free_unref_page+0x19/0x690 mm/page_alloc.c:3404
>  __put_page+0x193/0x1e0 mm/swap.c:128
>  folio_put include/linux/mm.h:1199 [inline]
>  put_page include/linux/mm.h:1237 [inline]
>  do_exit+0x1f5f/0x2a30 kernel/exit.c:845
>  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
>  __do_sys_exit_group kernel/exit.c:946 [inline]
>  __se_sys_exit_group kernel/exit.c:944 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Memory state around the buggy address:
>  ffff888023790580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888023790600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888023790680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                     ^
>  ffff888023790700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888023790780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000066b78e05d94df48b%40google.com.
