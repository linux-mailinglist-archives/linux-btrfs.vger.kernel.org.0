Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDA35417C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhDELUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhDELUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 07:20:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99657C061756
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Apr 2021 04:19:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x9so8172433qto.8
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Apr 2021 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LPoc+iMv01IonGAnR5ynlbWsKHZ+aEzMFYORfKF5cYE=;
        b=TClpgRAUkUkzaMNhtJiB3hfj+vnZ384wfu38GTzdtFXXSVoVUtKnMnKacWdBZIDRhW
         00z8ZcKNEitSV5AaIi0aLbxVJk3avT6m4/+Nz4DIhZFKSaR+v7Fz6rGtDpTg+q2W1xxy
         8JtcHj4sNKlZccSgZAxAQVmD0nVll/45YKs9q+QRSPcrC9kjORsVyWgFa5+EcAcTx/h/
         qXlrSKarpipqcJDc/GPvbQRR4KDI7uIqmSIk66ZifKGGESwj4gOA1DvNLhgbFEYALJS4
         E0sU2WYaEcrekAWSy3ygg7IcF+tMYDSRKx55Mf9Xbjb+9LOheTgSuRZJ3QnCh8h+6Vix
         rgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LPoc+iMv01IonGAnR5ynlbWsKHZ+aEzMFYORfKF5cYE=;
        b=aNOdNWnk4oXRR+AMKObsUeIdh75pu7nNDIF6K6eUDAYXMmgh+9QQ1+09yXkkExq6SE
         hRVz2ehjYKbMLX5xdwdhMIyXUk3SiR7yMQGfMS7SyUjt/UPqYdu797XTRwjIfoe5Uh7m
         Ogirb7XjDZ86N3wkHGCm2yQhsTBKOYb9r7hxQyzP4tfDmKQrQ0inLekjl/FtuoNPkYig
         D1CqZ/lHhfoPrAHPAk44fXtxA9mXvrLubE+LTWCun4McgarQojew78trb+GDhw9imeUF
         WL4uCaDY3USMD8Sb0VJTECmwa0Ymfk5xS1HcWF7Svr1f5br/+az0rUVQsHNGu+g0HkpF
         RFYg==
X-Gm-Message-State: AOAM533Ylb2RpDOK8YfWptwBFOsFXoJS2yNXVZseJzaOUaVWwLMhZw+k
        j/cD4yG9f0YEcFftAYWCaiN2SjXv2YHmVkEDYygom/uvAZmNfw==
X-Google-Smtp-Source: ABdhPJz3/HLpt1AB61Ti24qw91rSpFUAJXdgurhROyrvtLuJUv8u40wMbDjDEWf1/5ptXxkUOiS6ViZAW24HLEe/HMc=
X-Received: by 2002:ac8:a04:: with SMTP id b4mr22014336qti.376.1617621597512;
 Mon, 05 Apr 2021 04:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210404040732.GZ32440@hungrycats.org>
In-Reply-To: <20210404040732.GZ32440@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Apr 2021 12:19:46 +0100
Message-ID: <CAL3q7H4FjR6PCpjYYBcMQUP6DDS9jpLtQUrBf=jf+fkEF49cKw@mail.gmail.com>
Subject: Re: kernel BUG at fs/btrfs/tree-mod-log.c:675 - misc-next
 9228ad80f849 (Mar 29 2021)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 4, 2021 at 5:16 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Base kernel is 9228ad80f849 "btrfs: zoned: move log tree node allocation
> out of log_root_tree->log_mutex" from misc-next on 2021-03-29.
>
> The BUG() moved, but we are still hitting it:
>
>         [145427.426011][ T5492] BTRFS info (device dm-0): balance: cancel=
ed
>         [145427.689964][ T4811] ------------[ cut here ]------------
>         [145427.692498][ T4811] kernel BUG at fs/btrfs/tree-mod-log.c:675=
!
>         [145427.694668][ T4811] invalid opcode: 0000 [#1] SMP KASAN PTI
>         [145427.696379][ T4811] CPU: 3 PID: 4811 Comm: crawl_1215 Tainted=
: G        W         5.12.0-7d1efdf501f8-misc-next+ #99
>         [145427.700221][ T4811] Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>         [145427.703623][ T4811] RIP: 0010:tree_mod_log_rewind+0x3b1/0x3c0
>         [145427.706135][ T4811] Code: 05 48 8d 74 10 65 ba 19 00 00 00 e8=
 49 5e f2 ff e9 a7 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 28 23 b4 ff 48 63 43 2c=
 e9 a2 fe ff ff <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00 55 48
>         [145427.713034][ T4811] RSP: 0018:ffffc90001027090 EFLAGS: 000102=
93
>         [145427.714996][ T4811] RAX: 0000000000000000 RBX: ffff8880a85146=
00 RCX: ffffffffaa9e59b6
>         [145427.717158][ T4811] RDX: 0000000000000007 RSI: dffffc00000000=
00 RDI: ffff8880a851462c
>         [145427.720422][ T4811] RBP: ffffc900010270e0 R08: 00000000000000=
c0 R09: ffffed1004333417
>         [145427.723835][ T4811] R10: ffff88802199a0b7 R11: ffffed10043334=
16 R12: 000000000000000e
>         [145427.727695][ T4811] R13: ffff888135af8748 R14: ffff88818766ff=
00 R15: ffff8880a851462c
>         [145427.731636][ T4811] FS:  00007f29acf62700(0000) GS:ffff8881f2=
200000(0000) knlGS:0000000000000000
>         [145427.736305][ T4811] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
>         [145427.739587][ T4811] CR2: 00007f0e6013f718 CR3: 000000010d42e0=
03 CR4: 0000000000170ee0
>         [145427.743573][ T4811] Call Trace:
>         [145427.745117][ T4811]  btrfs_get_old_root+0x16a/0x5c0
>         [145427.747686][ T4811]  ? lock_downgrade+0x400/0x400
>         [145427.754189][ T4811]  btrfs_search_old_slot+0x192/0x520
>         [145427.758023][ T4811]  ? btrfs_search_slot+0x1090/0x1090
>         [145427.761014][ T4811]  ? free_extent_buffer.part.61+0xd7/0x140
>         [145427.765208][ T4811]  ? free_extent_buffer+0x13/0x20
>         [145427.770042][ T4811]  resolve_indirect_refs+0x3e9/0xfc0
>         [145427.773633][ T4811]  ? lock_downgrade+0x400/0x400
>         [145427.777323][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.780539][ T4811]  ? add_prelim_ref.part.11+0x150/0x150
>         [145427.785722][ T4811]  ? lock_downgrade+0x400/0x400
>         [145427.791086][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.796266][ T4811]  ? lock_acquired+0xbb/0x620
>         [145427.798764][ T4811]  ? __kasan_check_write+0x14/0x20
>         [145427.801118][ T4811]  ? do_raw_spin_unlock+0xa8/0x140
>         [145427.804491][ T4811]  ? rb_insert_color+0x340/0x360
>         [145427.808066][ T4811]  ? prelim_ref_insert+0x12d/0x430
>         [145427.811889][ T4811]  find_parent_nodes+0x5c3/0x1830
>         [145427.815498][ T4811]  ? stack_trace_save+0x87/0xb0
>         [145427.819210][ T4811]  ? resolve_indirect_refs+0xfc0/0xfc0
>         [145427.823254][ T4811]  ? fs_reclaim_acquire+0x67/0xf0
>         [145427.827220][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.829080][ T4811]  ? lockdep_hardirqs_on_prepare+0x210/0x21=
0
>         [145427.831237][ T4811]  ? fs_reclaim_acquire+0x67/0xf0
>         [145427.835061][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.836508][ T4811]  ? ___might_sleep+0x10f/0x1e0
>         [145427.841389][ T4811]  ? __kasan_kmalloc+0x9d/0xd0
>         [145427.843054][ T4811]  ? trace_hardirqs_on+0x55/0x120
>         [145427.845533][ T4811]  btrfs_find_all_roots_safe+0x142/0x1e0
>         [145427.847325][ T4811]  ? find_parent_nodes+0x1830/0x1830
>         [145427.849318][ T4811]  ? trace_hardirqs_on+0x55/0x120
>         [145427.851210][ T4811]  ? ulist_free+0x1f/0x30
>         [145427.852809][ T4811]  ? btrfs_inode_flags_to_xflags+0x50/0x50
>         [145427.854654][ T4811]  iterate_extent_inodes+0x20e/0x580
>         [145427.856429][ T4811]  ? tree_backref_for_extent+0x230/0x230
>         [145427.858552][ T4811]  ? release_extent_buffer+0x225/0x280
>         [145427.862789][ T4811]  ? read_extent_buffer+0xdd/0x110
>         [145427.865092][ T4811]  ? lock_downgrade+0x400/0x400
>         [145427.867069][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.868585][ T4811]  ? lock_acquired+0xbb/0x620
>         [145427.872309][ T4811]  ? __kasan_check_write+0x14/0x20
>         [145427.873641][ T4811]  ? do_raw_spin_unlock+0xa8/0x140
>         [145427.878150][ T4811]  ? _raw_spin_unlock+0x22/0x30
>         [145427.879355][ T4811]  ? release_extent_buffer+0x225/0x280
>         [145427.881424][ T4811]  iterate_inodes_from_logical+0x129/0x170
>         [145427.884711][ T4811]  ? iterate_inodes_from_logical+0x129/0x17=
0
>         [145427.888124][ T4811]  ? btrfs_inode_flags_to_xflags+0x50/0x50
>         [145427.891553][ T4811]  ? iterate_extent_inodes+0x580/0x580
>         [145427.894531][ T4811]  ? __vmalloc_node+0x92/0xb0
>         [145427.897439][ T4811]  ? init_data_container+0x34/0xb0
>         [145427.900518][ T4811]  ? init_data_container+0x34/0xb0
>         [145427.903705][ T4811]  ? kvmalloc_node+0x60/0x80
>         [145427.906538][ T4811]  btrfs_ioctl_logical_to_ino+0x158/0x230
>         [145427.910125][ T4811]  btrfs_ioctl+0x2038/0x4360
>         [145427.912430][ T4811]  ? __kasan_check_write+0x14/0x20
>         [145427.914061][ T4811]  ? mmput+0x3b/0x220
>         [145427.915380][ T4811]  ? btrfs_ioctl_get_supported_features+0x3=
0/0x30
>         [145427.917512][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.919110][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.920845][ T4811]  ? lock_release+0xc8/0x650
>         [145427.922227][ T4811]  ? __might_fault+0x64/0xd0
>         [145427.923687][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.925222][ T4811]  ? lock_downgrade+0x400/0x400
>         [145427.926729][ T4811]  ? lockdep_hardirqs_on_prepare+0x210/0x21=
0
>         [145427.928496][ T4811]  ? lockdep_hardirqs_on_prepare+0x13/0x210
>         [145427.930396][ T4811]  ? _raw_spin_unlock_irqrestore+0x51/0x63
>         [145427.932123][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.933910][ T4811]  ? do_vfs_ioctl+0xfc/0x9d0
>         [145427.935664][ T4811]  ? ioctl_file_clone+0xe0/0xe0
>         [145427.938147][ T4811]  ? lock_downgrade+0x400/0x400
>         [145427.940717][ T4811]  ? lockdep_hardirqs_on_prepare+0x210/0x21=
0
>         [145427.943673][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.946249][ T4811]  ? lock_release+0xc8/0x650
>         [145427.948509][ T4811]  ? __task_pid_nr_ns+0xd3/0x250
>         [145427.950946][ T4811]  ? __kasan_check_read+0x11/0x20
>         [145427.953415][ T4811]  ? __fget_files+0x160/0x230
>         [145427.955693][ T4811]  ? __fget_light+0xf2/0x110
>         [145427.957951][ T4811]  __x64_sys_ioctl+0xc3/0x100
>         [145427.961647][ T4811]  do_syscall_64+0x37/0x80
>         [145427.963112][ T4811]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>         [145427.971975][ T4811] RIP: 0033:0x7f29ae85b427
>         [145427.974101][ T4811] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7=
 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 =
89 01 48
>         [145427.980483][ T4811] RSP: 002b:00007f29acf5fcf8 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000010
>         [145427.983314][ T4811] RAX: ffffffffffffffda RBX: 00007f29acf5ff=
40 RCX: 00007f29ae85b427
>         [145427.985963][ T4811] RDX: 00007f29acf5ff48 RSI: 00000000c03894=
3b RDI: 0000000000000003
>         [145427.988504][ T4811] RBP: 0000000001000000 R08: 00000000000000=
00 R09: 00007f29acf60120
>         [145427.991085][ T4811] R10: 00005640d5fc7b00 R11: 00000000000002=
46 R12: 0000000000000003
>         [145427.993662][ T4811] R13: 00007f29acf5ff48 R14: 00007f29acf5ff=
40 R15: 00007f29acf5fef8
>         [145427.996289][ T4811] Modules linked in:
>         [145427.997661][ T4811] ---[ end trace 85e5fce078dfbe04 ]---
>
>         (gdb) l *(tree_mod_log_rewind+0x3b1)
>         0xffffffff819e5b21 is in tree_mod_log_rewind (fs/btrfs/tree-mod-l=
og.c:675).
>         670                      * the modification. As we're going backw=
ards, we do the
>         671                      * opposite of each operation here.
>         672                      */
>         673                     switch (tm->op) {
>         674                     case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEI=
NG:
>         675                             BUG_ON(tm->slot < n);
>         676                             fallthrough;
>         677                     case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVIN=
G:
>         678                     case BTRFS_MOD_LOG_KEY_REMOVE:
>         679                             btrfs_set_node_key(eb, &tm->key, =
tm->slot);
>         (gdb) quit

Ok, there's another similar race to the one previously fixed (missing
read lock), that I previously missed.
Can you try the following patch, against misc-next:

https://pastebin.com/raw/MQCCFwhf

Let me know how it goes after that.
Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
