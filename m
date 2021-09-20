Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963544112C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhITKTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 06:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhITKTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 06:19:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133EC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 03:17:35 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk29so40651735qkb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=VFdPIb4S9gTZFbajuH2Iu7jcf2UmOzoXnfpvc73O3m0=;
        b=FvdExa11ZvvFSE19qTfliA4X1JbByh7RDO0OQeqllmHpjr7PJCLfoOpNIFvvDWmtOk
         jY9dhIuKLi/C2ad5kCuEsfKSsMCBmqM43+i1XcUOpirLz5xZNn4xXs7LDTcG0QTly1UL
         tZe2lr84eBNP1tphFf0tnXomodHM0qR0tZcGjzmJTWIShYMmorGQdHIo6gCs4suwcejM
         kHxX7jFUwH9ODunECAVMus87mV1MVbVmpfTAj0CJcqnNZPA+GB0g7kTGZ/0gcXVqwSUP
         6FC3uqC5iYycUuj4H0eJ0Mua4+x3HkkOMWIAMmaGVXx46Dori/5XqUBJLZpkwZo4pIQ4
         mgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=VFdPIb4S9gTZFbajuH2Iu7jcf2UmOzoXnfpvc73O3m0=;
        b=DZzsGWEBG3Adjc99Nuiwh2r+orwZiAjDHJLySciW72LCCixBa2JUDCzbpH+YfpR9PP
         OEe1M5UQ+4gPyTAFowuu3ETQyZODWEEdO+vVKzjlqY7rtrjcvhAJ1aslWXOCPfljjQBG
         Ig3h9b/E076S4DiF/DtFdxPliKW3crxhKuK3VEH9xYbORtJFQEXud8fyMoRr94yHGK1c
         4gYyJ0+ZyMPjyBAM9MWhuiV1Hs1NHnt7wPDnmF2raVoNKkTPSpLlezX03yQPQbTLNybC
         w1jXpq3FXb3ZmzqYzPFV+f54Xk4SJhDUwh7VlttBbOk8hkKKgWMne4smNIanG4q+szPI
         YiNg==
X-Gm-Message-State: AOAM532rN8qfoqWjj7VL/gpZCGvH9OtlOtxLB5D1/5ODUyd350o73q3H
        ZcfNS0f1+49EvJRMwOy5/Kw1KEmnw7AyugLblLsjCYh92Oc=
X-Google-Smtp-Source: ABdhPJxrLtYQBGdVWZZMGuGIkNDAaeiryltqX+KjYyQ8OfYCKjDeqQ0wZZg8xqsqwmd3ABQTkgvc044CLIrfmXZqqYM=
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr24103633qkp.388.1632133054238;
 Mon, 20 Sep 2021 03:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210914065759.38793-1-wqu@suse.com> <20210920084822.GA9286@twin.jikos.cz>
In-Reply-To: <20210920084822.GA9286@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 Sep 2021 11:16:58 +0100
Message-ID: <CAL3q7H4y96n7Bo_KtVuZV01dBvj3c5ZhN7+w0rSfAxoJrdLKQg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: unlock the newly allocated extent buffer in btrfs_alloc_tree_block()
To:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 10:58 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Sep 14, 2021 at 02:57:59PM +0800, Qu Wenruo wrote:
> > [BUG]
> > There is a very detailed bug report that injected ENOMEM error could
> > leave a tree block locked while we return to user-space:
> >
> >   BTRFS info (device loop0): enabling ssd optimizations
> >   FAULT_INJECTION: forcing a failure.
> >   name failslab, interval 1, probability 0, space 0, times 0
> >   CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >   rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> >   Call Trace:
> >    __dump_stack lib/dump_stack.c:88 [inline]
> >    dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
> >    fail_dump lib/fault-inject.c:52 [inline]
> >    should_fail+0x13c/0x160 lib/fault-inject.c:146
> >    should_failslab+0x5/0x10 mm/slab_common.c:1328
> >    slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
> >    slab_alloc_node mm/slub.c:3120 [inline]
> >    slab_alloc mm/slub.c:3214 [inline]
> >    kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
> >    btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
> >    btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
> >    __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
> >    btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
> >    btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
> >    btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
> >    btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
> >    btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
> >    lookup_open+0x660/0x780 fs/namei.c:3282
> >    open_last_lookups fs/namei.c:3352 [inline]
> >    path_openat+0x465/0xe20 fs/namei.c:3557
> >    do_filp_open+0xe3/0x170 fs/namei.c:3588
> >    do_sys_openat2+0x357/0x4a0 fs/open.c:1200
> >    do_sys_open+0x87/0xd0 fs/open.c:1216
> >    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >    do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
> >    entry_SYSCALL_64_after_hwframe+0x44/0xae
> >   RIP: 0033:0x46ae99
> >   Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> >   89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d
> >   01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> >   RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 000000000000005=
5
> >   RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> >   RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
> >   RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
> >   R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   WARNING: lock held when returning to user space!
> >   5.15.0-rc1 #16 Not tainted
> >   ------------------------------------------------
> >   syz-executor/7579 is leaving the kernel with locks still held!
> >   1 lock held by syz-executor/7579:
> >    #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
> >   __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
> >
> > [CAUSE]
> > In btrfs_alloc_tree_block(), after btrfs_init_new_buffer(), the new
> > extent buffer @buf is locked, but if later operations like adding
> > delayed tree ref fails, we just free @buf without unlocking it,
> > resulting above warning.
> >
> > [FIX]
> > Unlock @buf in out_free_buf: tag.
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CACkBjsZ9O6Zr0KK1yGn=3D1rQi6C=
rh1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com/
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I found the following lockdep report, it's been with recent misc-next
> and the functions on stack match what this patch touches but I haven't
> done a deeper analysis so this could be a false trace (though the
> warning seems legit).
>
> The workload was some file creation/copy and relocation but I don't have
> a more specific information.

The problem is known and is always triggered by brfs/187 for example.
It's unrelated to multi device filesystems or to Qu's patch.

The problem is that we have replace_path() locking nodes from a
relocation tree and then lock nodes from a subvolume tree,
while other paths do the opposite (like replace_file_extents() amongst
others), locking first from a subvolume tree and then from a
relocation tree.

I've reported that long ago on slack to Josef, which started to happen
shortly after the switch to rw semaphores for btree locks.
Unfortunately I don't think the problem is simple to fix.


>
> [10898.966572] BTRFS info (device sdd10): balance: start -musage=3D50 -su=
sage=3D50
> [10898.980261] BTRFS info (device sdd10): relocating block group 19551957=
8112 flags system
> [10906.757623] BTRFS info (device sdd10): relocating block group 19114806=
4768 flags metadata
> [11401.635794]
> [11401.637392] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11401.643647] WARNING: possible circular locking dependency detected
> [11401.649956] 5.15.0-rc1-git+ #810 Not tainted
> [11401.654315] ------------------------------------------------------
> [11401.660588] btrfs/11698 is trying to acquire lock:
> [11401.665467] ffff8bb384bf7068 (btrfs-treloc-03#2){+.+.}-{3:3}, at: __bt=
rfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.675102]
> [11401.675102] but task is already holding lock:
> [11401.681029] ffff8bb3ce5a4110 (btrfs-tree-02/1){+.+.}-{3:3}, at: __btrf=
s_tree_lock+0x2c/0x140 [btrfs]
> [11401.690417]
> [11401.690417] which lock already depends on the new lock.
> [11401.690417]
> [11401.698700]
> [11401.698700] the existing dependency chain (in reverse order) is:
> [11401.706272]
> [11401.706272] -> #2 (btrfs-tree-02/1){+.+.}-{3:3}:
> [11401.712473]        __lock_acquire+0x3e5/0x730
> [11401.716906]        lock_acquire.part.0+0x5f/0x190
> [11401.721700]        down_write_nested+0x49/0x130
> [11401.726310]        __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.731744]        btrfs_init_new_buffer+0x7d/0x2c0 [btrfs]
> [11401.737510]        btrfs_alloc_tree_block+0x13b/0x350 [btrfs]
> [11401.743459]        __btrfs_cow_block+0x144/0x600 [btrfs]
> [11401.748967]        btrfs_cow_block+0x107/0x160 [btrfs]
> [11401.754306]        btrfs_search_slot+0x67a/0xc00 [btrfs]
> [11401.759809]        btrfs_lookup_dir_item+0x7c/0xe0 [btrfs]
> [11401.765507]        __btrfs_unlink_inode+0xaa/0x4f0 [btrfs]
> [11401.771184]        btrfs_unlink+0x87/0x100 [btrfs]
> [11401.776154]        vfs_unlink+0x101/0x210
> [11401.780250]        do_unlinkat+0x19c/0x2c0
> [11401.784435]        __x64_sys_unlinkat+0x34/0x60
> [11401.789057]        do_syscall_64+0x3d/0xb0
> [11401.793253]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11401.798914]
> [11401.798914] -> #1 (btrfs-tree-02){++++}-{3:3}:
> [11401.804947]        __lock_acquire+0x3e5/0x730
> [11401.809381]        lock_acquire.part.0+0x5f/0x190
> [11401.814185]        down_write_nested+0x49/0x130
> [11401.818810]        __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.824247]        btrfs_search_slot+0x2a1/0xc00 [btrfs]
> [11401.829759]        do_relocation+0x12c/0x6f0 [btrfs]
> [11401.834942]        relocate_tree_block+0x1a6/0x270 [btrfs]
> [11401.840646]        relocate_tree_blocks+0xe8/0x260 [btrfs]
> [11401.846358]        relocate_block_group+0x200/0x580 [btrfs]
> [11401.852146]        btrfs_relocate_block_group+0x18b/0x350 [btrfs]
> [11401.858455]        btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [11401.864166]        __btrfs_balance+0x2ea/0x490 [btrfs]
> [11401.869511]        btrfs_balance+0x4d3/0x7c0 [btrfs]
> [11401.874684]        btrfs_ioctl_balance+0x31c/0x3e0 [btrfs]
> [11401.880382]        __x64_sys_ioctl+0x83/0xa0
> [11401.884736]        do_syscall_64+0x3d/0xb0
> [11401.888924]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11401.894573]
> [11401.894573] -> #0 (btrfs-treloc-03#2){+.+.}-{3:3}:
> [11401.900946]        check_prev_add+0x91/0xc30
> [11401.905293]        validate_chain+0x56f/0x840
> [11401.909740]        __lock_acquire+0x3e5/0x730
> [11401.914186]        lock_acquire.part.0+0x5f/0x190
> [11401.918979]        down_write_nested+0x49/0x130
> [11401.923607]        __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.929064]        btrfs_lock_root_node+0x31/0x40 [btrfs]
> [11401.934671]        btrfs_search_slot+0x58e/0xc00 [btrfs]
> [11401.940164]        replace_path+0x57e/0xc70 [btrfs]
> [11401.945241]        merge_reloc_root+0x222/0x8c0 [btrfs]
> [11401.950667]        merge_reloc_roots+0xf0/0x290 [btrfs]
> [11401.956119]        relocate_block_group+0x2d7/0x580 [btrfs]
> [11401.961910]        btrfs_relocate_block_group+0x18b/0x350 [btrfs]
> [11401.968204]        btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [11401.973905]        __btrfs_balance+0x2ea/0x490 [btrfs]
> [11401.979239]        btrfs_balance+0x4d3/0x7c0 [btrfs]
> [11401.984423]        btrfs_ioctl_balance+0x31c/0x3e0 [btrfs]
> [11401.990117]        __x64_sys_ioctl+0x83/0xa0
> [11401.994456]        do_syscall_64+0x3d/0xb0
> [11401.998642]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11402.004323]
> [11402.004323] other info that might help us debug this:
> [11402.004323]
> [11402.012465] Chain exists of:
> [11402.012465]   btrfs-treloc-03#2 --> btrfs-tree-02 --> btrfs-tree-02/1
> [11402.012465]
> [11402.023382]  Possible unsafe locking scenario:
> [11402.023382]
> [11402.029395]        CPU0                    CPU1
> [11402.034004]        ----                    ----
> [11402.038622]   lock(btrfs-tree-02/1);
> [11402.042287]                                lock(btrfs-tree-02);
> [11402.048288]                                lock(btrfs-tree-02/1);
> [11402.054476]   lock(btrfs-treloc-03#2);
> [11402.060166]
> [11402.060166]  *** DEADLOCK ***
> [11402.060166]
> [11402.066212] 5 locks held by btrfs/11698:
> [11402.070210]  #0: ffff8bb4fab09478 (sb_writers#9){.+.+}-{0:0}, at: btrf=
s_ioctl_balance+0x47/0x3e0 [btrfs]
> [11402.079923]  #1: ffff8bb48520a370 (&fs_info->reclaim_bgs_lock){+.+.}-{=
3:3}, at: __btrfs_balance+0x179/0x490 [btrfs]
> [11402.090584]  #2: ffff8bb4852088e0 (&fs_info->cleaner_mutex){+.+.}-{3:3=
}, at: btrfs_relocate_block_group+0x183/0x350 [btrfs]
> [11402.101965]  #3: ffff8bb4fab09698 (sb_internal#2){.+.+}-{0:0}, at: mer=
ge_reloc_root+0x11c/0x8c0 [btrfs]
> [11402.111616]  #4: ffff8bb3ce5a4110 (btrfs-tree-02/1){+.+.}-{3:3}, at: _=
_btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.121418]
> [11402.121418] stack backtrace:
> [11402.125880] CPU: 7 PID: 11698 Comm: btrfs Not tainted 5.15.0-rc1-git+ =
#810
> [11402.132843] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
> [11402.139470] Call Trace:
> [11402.141989]  dump_stack_lvl+0x45/0x59
> [11402.145736]  check_noncircular+0xf3/0x110
> [11402.149827]  ? check_irq_usage+0xaa/0x3f0
> [11402.153943]  check_prev_add+0x91/0xc30
> [11402.157783]  validate_chain+0x56f/0x840
> [11402.161719]  __lock_acquire+0x3e5/0x730
> [11402.165654]  lock_acquire.part.0+0x5f/0x190
> [11402.169924]  ? __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.175013]  ? lock_acquire+0xa0/0x150
> [11402.178839]  ? __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.183949]  down_write_nested+0x49/0x130
> [11402.188043]  ? __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.193127]  __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.198039]  btrfs_lock_root_node+0x31/0x40 [btrfs]
> [11402.203148]  btrfs_search_slot+0x58e/0xc00 [btrfs]
> [11402.208117]  replace_path+0x57e/0xc70 [btrfs]
> [11402.212680]  merge_reloc_root+0x222/0x8c0 [btrfs]
> [11402.217593]  ? lock_release+0x68/0x140
> [11402.221427]  ? _raw_spin_unlock+0x1f/0x40
> [11402.225522]  merge_reloc_roots+0xf0/0x290 [btrfs]
> [11402.230439]  relocate_block_group+0x2d7/0x580 [btrfs]
> [11402.235721]  btrfs_relocate_block_group+0x18b/0x350 [btrfs]
> [11402.241521]  btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [11402.246688]  __btrfs_balance+0x2ea/0x490 [btrfs]
> [11402.251524]  btrfs_balance+0x4d3/0x7c0 [btrfs]
> [11402.256181]  btrfs_ioctl_balance+0x31c/0x3e0 [btrfs]
> [11402.261377]  __x64_sys_ioctl+0x83/0xa0
> [11402.265205]  do_syscall_64+0x3d/0xb0
> [11402.268853]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11402.273985] RIP: 0033:0x7fedef5ff6c7
> [11402.277642] Code: 00 00 00 48 8b 05 c1 67 2b 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 67 2b 00 f7 d8 64 89 01 48
> [11402.296539] RSP: 002b:00007ffda9289e78 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [11402.304211] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fede=
f5ff6c7
> [11402.311439] RDX: 00007ffda9289f10 RSI: 00000000c4009420 RDI: 000000000=
0000003
> [11402.318657] RBP: 00007ffda928c866 R08: 00000000004c4cab R09: 000000000=
0000013
> [11402.325877] R10: 0000000022494966 R11: 0000000000000246 R12: 000000000=
0000001
> [11402.333115] R13: 00007ffda9289f10 R14: 0000000000000000 R15: 00007ffda=
9289f08
> [11432.564100] BTRFS info (device sdd10): found 30943 extents, stage: mov=
e data extents



--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
