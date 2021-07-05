Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D443BBA42
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 11:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGEJjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhGEJjK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 05:39:10 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D222C061760
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:36:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cn9so6346322qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=uYGp8NuBR8w9X2vYUWuRR2/zSW/DVBfTpeqPg7ON/Jo=;
        b=S2KUxyFrK3L16IduzfMBwzLYU4HysXZSoFxuqQBN/Ky4Acd8B1TfPdA5imPhMYGZA4
         bQFYRO2kkj1DSxFGyBclLGOxjm1FKjL40HeuJhcp2w2xzDA2+cCX/Ve9sckhH3dOh+zU
         saKS/4/qlCHrBPWDmAff6xFa5GjI2vtmB9qItMPVVLtDLMfq+dpX/AhKD+/aOgyoDXcA
         7tA3frqIw1QDv3p66IsmFKN8xRDr+kClSgn5u3UGRf8ceesP6cd7G60C6Xy579qSe/iz
         9Q0rlx0UlS0BchnTjCPMTnGAzcQSHHNpG0RIusnuV+J2rcBI9MReurtYqD3fegQ2Q/pm
         Y3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=uYGp8NuBR8w9X2vYUWuRR2/zSW/DVBfTpeqPg7ON/Jo=;
        b=biJrE9gI4oy3fnxJ9fcekOgzvHJFn4W9UEjOF5x4vuh5xksmbHiCOqZ2noAm1+zsa2
         8ChETz7gW9uTyobfboFAeTVGvzWuDWha14FJ+FyeeTKCVfIHhR1ytz4uqMkncwck8qoh
         WaeyneiMreU4W26A+ZuKH2SEass+NmfQxq0tLT+6ofAbMdikjFja2d/Ro4nwYci8lqds
         rqz/fxfziB92T02TF2H5oIvohNB4Fm/PFFPCflA1/PYe+EoK/KDeAjue3LT/EIGc9/mD
         3IzV0XTQJAtAbCKDqqB8UmNrBELq6BKCveV47O6TMiaVzJRCNhviQUJHcLWE1cDVQ/aM
         EmGA==
X-Gm-Message-State: AOAM533MRnJ4wWWLs5nY4uM/gqj9WnH1X6XG3Owy0PAJPJOiHnF5p+mD
        2doqQcLuMjkVve1b2KvwNugnSWijFGkCQDvqtLY=
X-Google-Smtp-Source: ABdhPJw8C2rLJk8MD8cKqUBYTQ7ZM3vADwUyRkuI2cCTQ1/Kp5C9pupDgfJbdbLCXg62ezEY6k7b/ttpqA480LtueXY=
X-Received: by 2002:ad4:55e3:: with SMTP id bu3mr12094909qvb.62.1625477792314;
 Mon, 05 Jul 2021 02:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210704171039.GA10170@hungrycats.org>
In-Reply-To: <20210704171039.GA10170@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 10:36:21 +0100
Message-ID: <CAL3q7H4i9-QNAhCS_X44FvbaZ_36zvnXT94=LEV0CovXjGQOQA@mail.gmail.com>
Subject: Re: 5.13 splat: assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6329
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 4, 2021 at 6:12 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Running the usual set of random balances, scrub, rsync, snapshot deletes,
> and bees (for LOGICAL_INO) and:
>
>         [344599.037530][T31984] BTRFS info (device dm-0): balance: cancel=
ed
>         [344700.184935][ T4563] BTRFS debug (device dm-0): cleaner removi=
ng 5369
>         [344701.270658][ T4563] BTRFS debug (device dm-0): cleaner removi=
ng 5301
>         [344702.604521][ T4563] BTRFS debug (device dm-0): cleaner removi=
ng 5396
>         [344704.057458][ T4563] BTRFS debug (device dm-0): cleaner removi=
ng 5177
>         [344887.636132][ T4563] BTRFS debug (device dm-0): cleaner removi=
ng 5388
>         [344887.655861][ T3360] BTRFS info (device dm-0): balance: start =
-mlimit=3D1 -slimit=3D1
>         [344887.669306][ T3360] BTRFS info (device dm-0): relocating bloc=
k group 23770057146368 flags metadata|raid1
>         [345513.402986][T24139] BTRFS critical (device dm-0): unable to f=
ind logical 0 length 4096
>         [345513.404336][T24139] BTRFS critical (device dm-0): unable to f=
ind logical 0 length 4096
>         [345513.405887][T24139] assertion failed: !IS_ERR(em), in fs/btrf=
s/volumes.c:6329
>         [345513.406804][T24139] ------------[ cut here ]------------
>         [345513.407650][T24139] kernel BUG at fs/btrfs/ctree.h:3421!

That is interesting.
Somehow it seems we are trying to read a page of an extent buffer with
a logical address of 0.

First thing that comes to mind is if there's a possible race between
finding references for an extent, snapshot deletion and block group
deletion.

I'll have to look at it.


>         [345513.408574][T24139] invalid opcode: 0000 [#1] SMP KASAN PTI
>         [345513.409467][T24139] CPU: 2 PID: 24139 Comm: crawl_5446 Tainte=
d: G        W    L    5.13.0-267fbd136877+ #2
>         [345513.410753][T24139] Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>         [345513.412429][T24139] RIP: 0010:assertfail.constprop.77+0x1c/0x=
1e
>         [345513.413506][T24139] Code: 85 48 89 df e8 9c 60 ff ff e9 12 00=
 eb fe 55 89 f1 48 c7 c2 20 88 24 85 48 89 fe 48 c7 c7 20 89 24 85 48 89 e5=
 e8 87 4e fe ff <0f> 0b e8 09 95 aa fe be bb 0c 00 00 48 c7 c7 c0 89 24 85 =
e8
>          cc ff
>         [345513.415971][T24139] RSP: 0018:ffffc90000796a90 EFLAGS: 000102=
86
>         [345513.416717][T24139] RAX: 0000000000000039 RBX: ffffc90000796d=
28 RCX: ffffffff832762f2
>         [345513.417786][T24139] RDX: 0000000000000000 RSI: 00000000000000=
08 RDI: ffff8881f6dfe2ec
>         [345513.418759][T24139] RBP: ffffc90000796a90 R08: ffffed103edc13=
81 R09: ffffed103edc1381
>         [345513.419739][T24139] R10: ffff8881f6e09c07 R11: ffffed103edc13=
80 R12: 0000000000000000
>         [345513.420719][T24139] R13: ffff888109598000 R14: 00000000000000=
00 R15: ffff88808d473278
>         [345513.421705][T24139] FS:  00007fc531cd9700(0000) GS:ffff8881f6=
c00000(0000) knlGS:0000000000000000
>         [345513.422797][T24139] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
>         [345513.423603][T24139] CR2: 00007fe879a13a10 CR3: 0000000110bc40=
05 CR4: 0000000000170ee0
>         [345513.424584][T24139] Call Trace:
>         [345513.424999][T24139]  __btrfs_map_block.cold.105+0x6a/0x80
>         [345513.425686][T24139]  ? kmem_cache_alloc+0x533/0xc00
>         [345513.426302][T24139]  ? submit_one_bio+0xb3/0xc0
>         [345513.426884][T24139]  ? submit_extent_page+0xc1/0x470
>         [345513.427526][T24139]  ? read_extent_buffer_pages+0x422/0xa50
>         [345513.428246][T24139]  ? btree_read_extent_buffer_pages+0x96/0x=
180
>         [345513.429118][T24139]  ? read_tree_block+0x51/0x70
>         [345513.429725][T24139]  ? read_block_for_search+0x2d0/0x3b0
>         [345513.430444][T24139]  ? btrfs_search_old_slot+0x2e1/0x520
>         [345513.431157][T24139]  ? resolve_indirect_refs+0x3e9/0xfc0
>         [345513.431850][T24139]  ? btrfs_get_io_geometry+0x1b0/0x1b0
>         [345513.432534][T24139]  ? iterate_inodes_from_logical+0x129/0x17=
0
>         [345513.433288][T24139]  ? btrfs_ioctl_logical_to_ino+0x158/0x230
>         [345513.434035][T24139]  ? btrfs_ioctl+0x27b3/0x42d0
>         [345513.434753][T24139]  ? percpu_counter_add_batch+0x2d/0xb0
>         [345513.435451][T24139]  ? entry_SYSCALL_64_after_hwframe+0x44/0x=
ae
>         [345513.436210][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.436858][T24139]  ? btrfs_bio_counter_inc_blocked+0xc4/0x1=
d0
>         [345513.437633][T24139]  ? btrfs_bio_counter_sub+0x70/0x70
>         [345513.438306][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.438952][T24139]  ? lock_release+0xc8/0x640
>         [345513.439665][T24139]  ? fs_reclaim_acquire+0x67/0x100
>         [345513.440336][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.441014][T24139]  btrfs_map_bio+0x13d/0x900
>         [345513.441623][T24139]  ? btrfs_get_chunk_map+0x31/0x90
>         [345513.442334][T24139]  ? kasan_poison.part.11+0x3a/0x50
>         [345513.443031][T24139]  ? kasan_unpoison+0x3d/0x70
>         [345513.443655][T24139]  ? btrfs_map_sblock+0x20/0x20
>         [345513.444303][T24139]  ? kmem_cache_alloc+0x70c/0xc00
>         [345513.445011][T24139]  ? btrfs_get_chunk_map.cold.95+0x15/0x4d
>         [345513.445796][T24139]  btrfs_submit_metadata_bio+0x9d/0x190
>         [345513.446535][T24139]  submit_one_bio+0xb3/0xc0
>         [345513.447162][T24139]  submit_extent_page+0xc1/0x470
>         [345513.447838][T24139]  read_extent_buffer_pages+0x422/0xa50
>         [345513.448703][T24139]  ? btrfs_submit_read_repair+0x9d0/0x9d0
>         [345513.449480][T24139]  ? alloc_test_extent_buffer+0x2c0/0x2c0
>         [345513.450312][T24139]  ? find_extent_buffer+0x70/0x70
>         [345513.451176][T24139]  btree_read_extent_buffer_pages+0x96/0x18=
0
>         [345513.452181][T24139]  read_tree_block+0x51/0x70
>         [345513.452791][T24139]  read_block_for_search+0x2d0/0x3b0
>         [345513.453473][T24139]  ? btrfs_release_path+0xd0/0xd0
>         [345513.454136][T24139]  ? unlock_up+0x130/0x260
>         [345513.454729][T24139]  btrfs_search_old_slot+0x2e1/0x520
>         [345513.455425][T24139]  ? btrfs_search_slot+0x1090/0x1090
>         [345513.456134][T24139]  ? free_extent_buffer.part.64+0xd7/0x140
>         [345513.456911][T24139]  ? free_extent_buffer+0x13/0x20
>         [345513.457586][T24139]  resolve_indirect_refs+0x3e9/0xfc0
>         [345513.458310][T24139]  ? add_prelim_ref.part.11+0x150/0x150
>         [345513.459065][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.459788][T24139]  ? lock_acquired+0xbb/0x590
>         [345513.460422][T24139]  ? __kasan_check_write+0x14/0x20
>         [345513.461126][T24139]  ? do_raw_spin_unlock+0xa8/0x140
>         [345513.461821][T24139]  ? _raw_spin_unlock+0x22/0x30
>         [345513.462529][T24139]  ? release_extent_buffer+0x225/0x280
>         [345513.463265][T24139]  ? __kasan_check_write+0x14/0x20
>         [345513.463956][T24139]  ? free_extent_buffer.part.64+0x90/0x140
>         [345513.464731][T24139]  ? free_extent_buffer+0x13/0x20
>         [345513.465395][T24139]  find_parent_nodes+0x5c3/0x1830
>         [345513.466069][T24139]  ? resolve_indirect_refs+0xfc0/0xfc0
>         [345513.466796][T24139]  ? fs_reclaim_acquire+0x67/0x100
>         [345513.467455][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.468133][T24139]  ? lockdep_hardirqs_on_prepare+0x230/0x23=
0
>         [345513.468936][T24139]  ? lock_downgrade+0x400/0x400
>         [345513.469558][T24139]  ? kasan_print_address_stack_frame+0x50/0=
x110
>         [345513.470368][T24139]  ? ___might_sleep+0x10d/0x1e0
>         [345513.470996][T24139]  ? __kasan_check_write+0x20/0x20
>         [345513.471653][T24139]  ? __kasan_kmalloc+0x9f/0xd0
>         [345513.472272][T24139]  ? do_raw_write_lock+0x1d0/0x1d0
>         [345513.472935][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.473586][T24139]  btrfs_find_all_leafs+0x71/0xc0
>         [345513.474245][T24139]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [345513.475016][T24139]  iterate_extent_inodes+0x41f/0x580
>         [345513.475714][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.476378][T24139]  ? tree_backref_for_extent+0x230/0x230
>         [345513.477129][T24139]  ? lock_downgrade+0x400/0x400
>         [345513.477777][T24139]  ? read_extent_buffer+0xdd/0x110
>         [345513.478453][T24139]  ? lock_downgrade+0x400/0x400
>         [345513.479098][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.479768][T24139]  ? lock_acquired+0xbb/0x590
>         [345513.480390][T24139]  ? __kasan_check_write+0x14/0x20
>         [345513.481073][T24139]  ? do_raw_spin_unlock+0xa8/0x140
>         [345513.481833][T24139]  ? _raw_spin_unlock+0x22/0x30
>         [345513.482504][T24139]  ? __kasan_check_write+0x14/0x20
>         [345513.483202][T24139]  iterate_inodes_from_logical+0x129/0x170
>         [345513.484454][T24139]  ? iterate_inodes_from_logical+0x129/0x17=
0
>         [345513.485591][T24139]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [345513.486398][T24139]  ? iterate_extent_inodes+0x580/0x580
>         [345513.488425][T24139]  ? __vmalloc_node+0x92/0xb0
>         [345513.489455][T24139]  ? init_data_container+0x34/0xb0
>         [345513.490191][T24139]  ? init_data_container+0x34/0xb0
>         [345513.490921][T24139]  ? kvmalloc_node+0x60/0x80
>         [345513.491564][T24139]  btrfs_ioctl_logical_to_ino+0x158/0x230
>         [345513.492341][T24139]  btrfs_ioctl+0x27b3/0x42d0
>         [345513.493032][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.493708][T24139]  ? lock_release+0xc8/0x640
>         [345513.494329][T24139]  ? __might_fault+0x64/0xd0
>         [345513.494975][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.495675][T24139]  ? btrfs_ioctl_get_supported_features+0x3=
0/0x30
>         [345513.496579][T24139]  ? ___might_sleep+0x10d/0x1e0
>         [345513.497496][T24139]  ? do_vfs_ioctl+0x1c7/0xcc0
>         [345513.498179][T24139]  ? fiemap_prep+0x100/0x100
>         [345513.498803][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.499468][T24139]  ? lock_release+0xc8/0x640
>         [345513.500083][T24139]  ? __fget_files+0x141/0x230
>         [345513.500695][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.501397][T24139]  ? lock_downgrade+0x400/0x400
>         [345513.502150][T24139]  ? lockdep_hardirqs_on_prepare+0x230/0x23=
0
>         [345513.502924][T24139]  ? __fget_files+0x160/0x230
>         [345513.503675][T24139]  ? __fget_light+0xf2/0x110
>         [345513.504284][T24139]  __x64_sys_ioctl+0xc3/0x100
>         [345513.505128][T24139]  do_syscall_64+0x5d/0xb0
>         [345513.505789][T24139]  ? do_syscall_64+0x69/0xb0
>         [345513.506485][T24139]  ? __kasan_check_read+0x11/0x20
>         [345513.507192][T24139]  ? lockdep_hardirqs_on_prepare+0x13/0x230
>         [345513.507960][T24139]  ? syscall_exit_to_user_mode+0x4e/0x60
>         [345513.508669][T24139]  ? do_syscall_64+0x69/0xb0
>         [345513.509256][T24139]  ? do_syscall_64+0x69/0xb0
>         [345513.509842][T24139]  ? sysvec_call_function_single+0x48/0x90
>         [345513.510573][T24139]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>         [345513.511342][T24139] RIP: 0033:0x7fc5325d0427
>         [345513.511908][T24139] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7=
 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 =
89 01 48
>         [345513.514363][T24139] RSP: 002b:00007fc531cd6c98 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000010
>         [345513.515426][T24139] RAX: ffffffffffffffda RBX: 00007fc531cd6e=
e0 RCX: 00007fc5325d0427
>         [345513.516454][T24139] RDX: 00007fc531cd6ee8 RSI: 00000000c03894=
3b RDI: 0000000000000003
>         [345513.517551][T24139] RBP: 0000000001000000 R08: 00000000000000=
00 R09: 00007fc531cd70c0
>         [345513.518577][T24139] R10: 0000560251295d20 R11: 00000000000002=
46 R12: 0000000000000003
>         [345513.519642][T24139] R13: 00007fc531cd6ee8 R14: 00007fc531cd6e=
e0 R15: 00007fc531cd6e98
>         [345513.520779][T24139] Modules linked in:
>         [345513.521738][T24139] ---[ end trace aea7b537f94a6ed5 ]---
>         [345513.522397][T24139] RIP: 0010:assertfail.constprop.77+0x1c/0x=
1e
>         [345513.523265][T24139] Code: 85 48 89 df e8 9c 60 ff ff e9 12 00=
 eb fe 55 89 f1 48 c7 c2 20 88 24 85 48 89 fe 48 c7 c7 20 89 24 85 48 89 e5=
 e8 87 4e fe ff <0f> 0b e8 09 95 aa fe be bb 0c 00 00 48 c7 c7 c0 89 24 85 =
e8 cc ff
>         [345513.526634][T24139] RSP: 0018:ffffc90000796a90 EFLAGS: 000102=
86
>         [345513.527960][T24139] RAX: 0000000000000039 RBX: ffffc90000796d=
28 RCX: ffffffff832762f2
>         [345513.529833][T24139] RDX: 0000000000000000 RSI: 00000000000000=
08 RDI: ffff8881f6dfe2ec
>         [345513.531307][T24139] RBP: ffffc90000796a90 R08: ffffed103edc13=
81 R09: ffffed103edc1381
>         [345513.533001][T24139] R10: ffff8881f6e09c07 R11: ffffed103edc13=
80 R12: 0000000000000000
>         [345513.534401][T24139] R13: ffff888109598000 R14: 00000000000000=
00 R15: ffff88808d473278
>         [345513.535626][T24139] FS:  00007fc531cd9700(0000) GS:ffff8881f6=
c00000(0000) knlGS:0000000000000000
>         [345513.537402][T24139] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
>         [345513.538387][T24139] CR2: 00007fe879a13a10 CR3: 0000000110bc40=
05 CR4: 0000000000170ee0
>         [345513.655093][T24141] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>         [345513.656337][T24141] BUG: KASAN: vmalloc-out-of-bounds in __li=
st_del_entry_valid+0x52/0x90
>         [345513.657481][T24141] Read of size 8 at addr ffffc900007979d0 b=
y task crawl_5421/24141
>         [345513.658652][T24141]
>         [345513.658983][T24141] CPU: 0 PID: 24141 Comm: crawl_5421 Tainte=
d: G      D W    L    5.13.0-267fbd136877+ #2
>         [345513.660398][T24141] Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>         [345513.661883][T24141] Call Trace:
>         [345513.662425][T24141]  dump_stack+0xc4/0x10f
>         [345513.662999][T24141]  ? __list_del_entry_valid+0x52/0x90
>         [345513.663756][T24141]  print_address_description.constprop.9+0x=
21/0x130
>         [345513.664710][T24141]  ? __list_del_entry_valid+0x52/0x90
>         [345513.665439][T24141]  ? __list_del_entry_valid+0x52/0x90
>         [345513.666863][T24141]  kasan_report.cold.14+0x7b/0xd4
>         [345513.668172][T24141]  ? __list_del_entry_valid+0x52/0x90
>         [345513.669569][T24141]  __asan_load8+0x69/0x90
>         [345513.670694][T24141]  __list_del_entry_valid+0x52/0x90
>         [345513.671791][T24141]  btrfs_put_tree_mod_seq+0x58/0x1c0
>         [345513.672517][T24141]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [345513.673395][T24141]  iterate_extent_inodes+0x322/0x580
>         [345513.674220][T24141]  ? tree_backref_for_extent+0x230/0x230
>         [345513.675160][T24141]  ? release_extent_buffer+0x225/0x280
>         [345513.676025][T24141]  ? read_extent_buffer+0xdd/0x110
>         [345513.676885][T24141]  ? lock_downgrade+0x400/0x400
>         [345513.677674][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.678525][T24141]  ? lock_acquired+0xbb/0x590
>         [345513.679280][T24141]  ? __kasan_check_write+0x14/0x20
>         [345513.679984][T24141]  ? do_raw_spin_unlock+0xa8/0x140
>         [345513.680696][T24141]  ? _raw_spin_unlock+0x22/0x30
>         [345513.681386][T24141]  ? release_extent_buffer+0x225/0x280
>         [345513.682200][T24141]  iterate_inodes_from_logical+0x129/0x170
>         [345513.683080][T24141]  ? iterate_inodes_from_logical+0x129/0x17=
0
>         [345513.684032][T24141]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [345513.684990][T24141]  ? iterate_extent_inodes+0x580/0x580
>         [345513.685943][T24141]  ? __vmalloc_node+0x92/0xb0
>         [345513.686792][T24141]  ? init_data_container+0x34/0xb0
>         [345513.687694][T24141]  ? init_data_container+0x34/0xb0
>         [345513.688500][T24141]  ? kvmalloc_node+0x60/0x80
>         [345513.689313][T24141]  btrfs_ioctl_logical_to_ino+0x158/0x230
>         [345513.690298][T24141]  btrfs_ioctl+0x27b3/0x42d0
>         [345513.691076][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.691902][T24141]  ? lock_release+0xc8/0x640
>         [345513.692740][T24141]  ? __might_fault+0x64/0xd0
>         [345513.693549][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.694426][T24141]  ? btrfs_ioctl_get_supported_features+0x3=
0/0x30
>         [345513.695545][T24141]  ? pv_hash+0xf0/0xf0
>         [345513.696272][T24141]  ? ___might_sleep+0x10d/0x1e0
>         [345513.697109][T24141]  ? do_vfs_ioctl+0x1c7/0xcc0
>         [345513.697913][T24141]  ? __might_sleep+0x71/0xe0
>         [345513.698696][T24141]  ? fiemap_prep+0x100/0x100
>         [345513.699424][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.700320][T24141]  ? lock_release+0xc8/0x640
>         [345513.701138][T24141]  ? __fget_files+0x141/0x230
>         [345513.701955][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.702813][T24141]  ? lock_downgrade+0x400/0x400
>         [345513.703610][T24141]  ? lockdep_hardirqs_on_prepare+0x230/0x23=
0
>         [345513.704642][T24141]  ? syscall_exit_to_user_mode+0x30/0x60
>         [345513.705605][T24141]  ? __fget_files+0x160/0x230
>         [345513.706375][T24141]  ? __fget_light+0xf2/0x110
>         [345513.707209][T24141]  __x64_sys_ioctl+0xc3/0x100
>         [345513.708087][T24141]  do_syscall_64+0x5d/0xb0
>         [345513.708951][T24141]  ? irqentry_exit_to_user_mode+0x2c/0x30
>         [345513.710019][T24141]  ? irqentry_exit+0x5e/0x80
>         [345513.710902][T24141]  ? sysvec_apic_timer_interrupt+0x48/0x90
>         [345513.711914][T24141]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>         [345513.712992][T24141] RIP: 0033:0x7fc5325d0427
>         [345513.713666][T24141] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7=
 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 =
89 01 48
>         [345513.716997][T24141] RSP: 002b:00007fc530cd4c98 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000010
>         [345513.718371][T24141] RAX: ffffffffffffffda RBX: 00007fc530cd4e=
e0 RCX: 00007fc5325d0427
>         [345513.719822][T24141] RDX: 00007fc530cd4ee8 RSI: 00000000c03894=
3b RDI: 0000000000000003
>         [345513.721177][T24141] RBP: 0000000001000000 R08: 00000000000000=
00 R09: 00007fc530cd50c0
>         [345513.722499][T24141] R10: 0000560251295d20 R11: 00000000000002=
46 R12: 0000000000000003
>         [345513.723888][T24141] R13: 00007fc530cd4ee8 R14: 00007fc530cd4e=
e0 R15: 00007fc530cd4e98
>         [345513.725429][T24141]
>         [345513.725824][T24141]
>         [345513.726247][T24141] Memory state around the buggy address:
>         [345513.727209][T24141]  ffffc90000797880: f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8 f8 f8 f8 f8 f8 f8
>         [345513.728601][T24141]  ffffc90000797900: f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8 f8 f8 f8 f8 f8 f8
>         [345513.729973][T24141] >ffffc90000797980: f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8 f8 f8 f8 f8 f8 f8
>         [345513.731326][T24141]                                          =
        ^
>         [345513.732425][T24141]  ffffc90000797a00: f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8 f8 f8 f8 f8 f8 f8
>         [345513.733755][T24141]  ffffc90000797a80: f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8 f8 f8 f8 f8 f8 f8
>         [345513.735115][T24141] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>         [345513.736602][T24141] BUG: unable to handle page fault for addr=
ess: ffffc900007979d0
>         [345513.737580][T24141] #PF: supervisor read access in kernel mod=
e
>         [345513.738329][T24141] #PF: error_code(0x0000) - not-present pag=
e
>         [345513.739081][T24141] PGD 101000067 P4D 101000067 PUD 10129c067=
 PMD 1f6af0067 PTE 0
>         [345513.740499][T24141] Oops: 0000 [#2] SMP KASAN PTI
>         [345513.741145][T24141] CPU: 0 PID: 24141 Comm: crawl_5421 Tainte=
d: G    B D W    L    5.13.0-267fbd136877+ #2
>         [345513.742858][T24141] Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>         [345513.745048][T24141] RIP: 0010:__list_del_entry_valid+0x52/0x9=
0
>         [345513.746400][T24141] Code: 00 00 00 00 ad de 49 39 c5 0f 84 59=
 e5 e7 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 7f e5 e7 00 4c 89 e7=
 e8 9e b7 90 ff <4d> 8b 24 24 49 39 dc 0f 85 56 e5 e7 00 49 8d 7d 08 e8 88 =
b7 90 ff
>         [345513.750660][T24141] RSP: 0018:ffffc900007c77e0 EFLAGS: 000102=
82
>         [345513.751918][T24141] RAX: 0000000000000001 RBX: ffffc900007c7a=
10 RCX: ffffffff831e57c3
>         [345513.753783][T24141] RDX: 0000000000000007 RSI: dffffc00000000=
00 RDI: ffffffff84b4b5b1
>         [345513.755435][T24141] RBP: ffffc900007c77f8 R08: 00000000000000=
00 R09: 0000000000000000
>         [345513.757301][T24141] R10: ffffffff86126ee3 R11: fffffbfff0c24d=
dc R12: ffffc900007979d0
>         [345513.758938][T24141] R13: ffff888109598f28 R14: ffffc900007c7a=
20 R15: ffff888109598ed8
>         [345513.760763][T24141] FS:  00007fc530cd7700(0000) GS:ffff8881f6=
400000(0000) knlGS:0000000000000000
>         [345513.762745][T24141] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
>         [345513.764368][T24141] CR2: ffffc900007979d0 CR3: 0000000110bc40=
02 CR4: 0000000000170ef0
>         [345513.766143][T24141] Call Trace:
>         [345513.766865][T24141]  btrfs_put_tree_mod_seq+0x58/0x1c0
>         [345513.768055][T24141]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [345513.769252][T24141]  iterate_extent_inodes+0x322/0x580
>         [345513.770404][T24141]  ? tree_backref_for_extent+0x230/0x230
>         [345513.771660][T24141]  ? release_extent_buffer+0x225/0x280
>         [345513.772949][T24141]  ? read_extent_buffer+0xdd/0x110
>         [345513.773920][T24141]  ? lock_downgrade+0x400/0x400
>         [345513.775136][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.777071][T24141]  ? lock_acquired+0xbb/0x590
>         [345513.778240][T24141]  ? __kasan_check_write+0x14/0x20
>         [345513.779284][T24141]  ? do_raw_spin_unlock+0xa8/0x140
>         [345513.780382][T24141]  ? _raw_spin_unlock+0x22/0x30
>         [345513.781543][T24141]  ? release_extent_buffer+0x225/0x280
>         [345513.784606][T24141]  iterate_inodes_from_logical+0x129/0x170
>         [345513.786653][T24141]  ? iterate_inodes_from_logical+0x129/0x17=
0
>         [345513.789274][T24141]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [345513.791906][T24141]  ? iterate_extent_inodes+0x580/0x580
>         [345513.792882][T24141]  ? __vmalloc_node+0x92/0xb0
>         [345513.793590][T24141]  ? init_data_container+0x34/0xb0
>         [345513.794574][T24141]  ? init_data_container+0x34/0xb0
>         [345513.795356][T24141]  ? kvmalloc_node+0x60/0x80
>         [345513.796162][T24141]  btrfs_ioctl_logical_to_ino+0x158/0x230
>         [345513.797200][T24141]  btrfs_ioctl+0x27b3/0x42d0
>         [345513.797878][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.798851][T24141]  ? lock_release+0xc8/0x640
>         [345513.799537][T24141]  ? __might_fault+0x64/0xd0
>         [345513.800347][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.801207][T24141]  ? btrfs_ioctl_get_supported_features+0x3=
0/0x30
>         [345513.802280][T24141]  ? pv_hash+0xf0/0xf0
>         [345513.802894][T24141]  ? ___might_sleep+0x10d/0x1e0
>         [345513.803804][T24141]  ? do_vfs_ioctl+0x1c7/0xcc0
>         [345513.804516][T24141]  ? __might_sleep+0x71/0xe0
>         [345513.805336][T24141]  ? fiemap_prep+0x100/0x100
>         [345513.806048][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.806809][T24141]  ? lock_release+0xc8/0x640
>         [345513.807665][T24141]  ? __fget_files+0x141/0x230
>         [345513.808640][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.809560][T24141]  ? lock_downgrade+0x400/0x400
>         [345513.810520][T24141]  ? lockdep_hardirqs_on_prepare+0x230/0x23=
0
>         [345513.811726][T24141]  ? syscall_exit_to_user_mode+0x30/0x60
>         [345513.812782][T24141]  ? __fget_files+0x160/0x230
>         [345513.813654][T24141]  ? __fget_light+0xf2/0x110
>         [345513.814538][T24141]  __x64_sys_ioctl+0xc3/0x100
>         [345513.815367][T24141]  do_syscall_64+0x5d/0xb0
>         [345513.816115][T24141]  ? irqentry_exit_to_user_mode+0x2c/0x30
>         [345513.817129][T24141]  ? irqentry_exit+0x5e/0x80
>         [345513.817922][T24141]  ? sysvec_apic_timer_interrupt+0x48/0x90
>         [345513.818898][T24141]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>         [345513.819925][T24141] RIP: 0033:0x7fc5325d0427
>         [345513.820667][T24141] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7=
 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 =
89 01 48
>         [345513.824018][T24141] RSP: 002b:00007fc530cd4c98 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000010
>         [345513.825345][T24141] RAX: ffffffffffffffda RBX: 00007fc530cd4e=
e0 RCX: 00007fc5325d0427
>         [345513.826502][T24141] RDX: 00007fc530cd4ee8 RSI: 00000000c03894=
3b RDI: 0000000000000003
>         [345513.827702][T24141] RBP: 0000000001000000 R08: 00000000000000=
00 R09: 00007fc530cd50c0
>         [345513.828832][T24141] R10: 0000560251295d20 R11: 00000000000002=
46 R12: 0000000000000003
>         [345513.830141][T24141] R13: 00007fc530cd4ee8 R14: 00007fc530cd4e=
e0 R15: 00007fc530cd4e98
>         [345513.831442][T24141] Modules linked in:
>         [345513.832053][T24141] CR2: ffffc900007979d0
>         [345513.832638][T24141] ---[ end trace aea7b537f94a6ed6 ]---
>         [345513.833423][T24141] RIP: 0010:assertfail.constprop.77+0x1c/0x=
1e
>         [345513.834271][T24141] Code: 85 48 89 df e8 9c 60 ff ff e9 12 00=
 eb fe 55 89 f1 48 c7 c2 20 88 24 85 48 89 fe 48 c7 c7 20 89 24 85 48 89 e5=
 e8 87 4e fe ff <0f> 0b e8 09 95 aa fe be bb 0c 00 00 48 c7 c7 c0 89 24 85 =
e8 cc ff
>         [345513.836999][T24141] RSP: 0018:ffffc90000796a90 EFLAGS: 000102=
86
>         [345513.837852][T24141] RAX: 0000000000000039 RBX: ffffc90000796d=
28 RCX: ffffffff832762f2
>         [345513.839130][T24141] RDX: 0000000000000000 RSI: 00000000000000=
08 RDI: ffff8881f6dfe2ec
>         [345513.840455][T24141] RBP: ffffc90000796a90 R08: ffffed103edc13=
81 R09: ffffed103edc1381
>         [345513.841898][T24141] R10: ffff8881f6e09c07 R11: ffffed103edc13=
80 R12: 0000000000000000
>         [345513.843175][T24141] R13: ffff888109598000 R14: 00000000000000=
00 R15: ffff88808d473278
>         [345513.844829][T24141] FS:  00007fc530cd7700(0000) GS:ffff8881f6=
400000(0000) knlGS:0000000000000000
>         [345513.846956][T24141] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
>         [345513.847823][T24141] CR2: ffffc900007979d0 CR3: 0000000110bc40=
02 CR4: 0000000000170ef0
>         [345513.848895][T24141] note: crawl_5421[24141] exited with preem=
pt_count 1
>         [345513.849850][T24141] BUG: sleeping function called from invali=
d context at include/linux/percpu-rwsem.h:49
>         [345513.852537][T24141] in_atomic(): 0, irqs_disabled(): 1, non_b=
lock: 0, pid: 24141, name: crawl_5421
>         [345513.854546][T24141] INFO: lockdep is turned off.
>         [345513.856749][T24141] irq event stamp: 0
>         [345513.858281][T24141] hardirqs last  enabled at (0): [<00000000=
00000000>] 0x0
>         [345513.859957][T24141] hardirqs last disabled at (0): [<ffffffff=
8311666c>] copy_process+0x116c/0x3690
>         [345513.861584][T24141] softirqs last  enabled at (0): [<ffffffff=
8311666c>] copy_process+0x116c/0x3690
>         [345513.864020][T24141] softirqs last disabled at (0): [<00000000=
00000000>] 0x0
>         [345513.865646][T24141] CPU: 0 PID: 24141 Comm: crawl_5421 Tainte=
d: G    B D W    L    5.13.0-267fbd136877+ #2
>         [345513.867451][T24141] Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>         [345513.869176][T24141] Call Trace:
>         [345513.869952][T24141]  dump_stack+0xc4/0x10f
>         [345513.871011][T24141]  ___might_sleep.cold.117+0xdf/0xf0
>         [345513.872475][T24141]  __might_sleep+0x71/0xe0
>         [345513.873780][T24141]  ? vprintk+0x74/0x160
>         [345513.874984][T24141]  exit_signals+0x7f/0x450
>         [345513.876309][T24141]  ? do_signal_stop+0x370/0x370
>         [345513.877572][T24141]  ? __kasan_check_read+0x11/0x20
>         [345513.878923][T24141]  ? __validate_process_creds+0x170/0x190
>         [345513.880367][T24141]  do_exit+0x196/0x1540
>         [345513.881420][T24141]  ? syscall_exit_to_user_mode+0x30/0x60
>         [345513.882774][T24141]  ? mm_update_next_owner+0x3f0/0x3f0
>         [345513.884109][T24141]  ? __fget_light+0xf2/0x110
>         [345513.885460][T24141]  ? __x64_sys_ioctl+0xc3/0x100
>         [345513.886656][T24141]  ? do_syscall_64+0x5d/0xb0
>         [345513.887784][T24141]  ? irqentry_exit_to_user_mode+0x2c/0x30
>         [345513.889169][T24141]  rewind_stack_do_exit+0x17/0x20
>         [345513.890403][T24141] RIP: 0033:0x7fc5325d0427
>         [345513.891477][T24141] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7=
 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 =
89 01 48
>         [345513.896383][T24141] RSP: 002b:00007fc530cd4c98 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000010
>         [345513.898326][T24141] RAX: ffffffffffffffda RBX: 00007fc530cd4e=
e0 RCX: 00007fc5325d0427
>         [345513.900237][T24141] RDX: 00007fc530cd4ee8 RSI: 00000000c03894=
3b RDI: 0000000000000003
>         [345513.902294][T24141] RBP: 0000000001000000 R08: 00000000000000=
00 R09: 00007fc530cd50c0
>         [345513.904392][T24141] R10: 0000560251295d20 R11: 00000000000002=
46 R12: 0000000000000003
>         [345513.905832][T24141] R13: 00007fc530cd4ee8 R14: 00007fc530cd4e=
e0 R15: 00007fc530cd4e98
>         [345540.969717][    C0] watchdog: BUG: soft lockup - CPU#0 stuck =
for 23s! [kworker/u8:7:15487]
>
> ...and then it's all soft lockup traces after that.
>
> The assertion failure is the one after btrfs_get_chunk_map in __btrfs_map=
_block:
>
> (gdb) list volumes.c:6329
> 6324
> 6325            ASSERT(bbio_ret);
> 6326            ASSERT(op !=3D BTRFS_MAP_DISCARD);
> 6327
> 6328            em =3D btrfs_get_chunk_map(fs_info, logical, *length);
> 6329            ASSERT(!IS_ERR(em));
> 6330
> 6331            ret =3D btrfs_get_io_geometry(fs_info, em, op, logical, *=
length, &geom);
> 6332            if (ret < 0)
> 6333                    return ret;
> (gdb) q
>
> Mount options are rw,noatime,degraded,compress=3Dzstd:3,ssd,flushoncommit=
,discard=3Dasync,space_cache=3Dv2,autodefrag,skip_balance,subvolid=3D5,subv=
ol=3D/



--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
