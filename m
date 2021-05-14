Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0E3805C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhENJFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhENJFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 05:05:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54086C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 02:04:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j11so21722157qtn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=aTSNXDzLTJ7a27EJGqF/XlYdr0qBJkK5l4MzCCtecSo=;
        b=UEkS4aHAJd04mULqNdSdvuvvCWeRiPQU+wRh/t2ODJzO8xEGE1k89CfvGDaQz6UAvn
         DTSsZAc0qmyNTyUxcrEwWHnazy/dLGeUf1gwEZw/vf4lDSIAOodO/RGItjHBryMcL6sw
         x37fDCcYDzswhGtBQ22B/G57qLpsY9h1cDi1SKNK/4SN8joi13Qr1BJuizMwyDm555mq
         Fr4bNRDedpEbPytnV3KEZ2qYoB+k/v7uSnfsoL0NBV1XXF6GP1UxIOkZAqdG7MHVA0b6
         FQqBLTxnqRtlXyGl4/wXHH0PvAjZpdCWlkdzpdHMmTYQceMQXHUy9Cp+yFUZb2+yB67v
         dB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=aTSNXDzLTJ7a27EJGqF/XlYdr0qBJkK5l4MzCCtecSo=;
        b=i2ffDbbptnmEWvvHF2nJPKfg6f8LGdauS/vIPSRsfmuWXYXWghczL37sr/soTbCk8d
         7bS+WgYvwSih7JpbQhDCfrOGH2NKd3keqsihE1eoTdgA7jh4i3rxwhvEO7kY39dpS07x
         j+8LwIrXXGHOpgojm6L1vtEV1rUTHuqHvDEexLRCMJeWy27aA3PN61dN4IJ/fAAruHrM
         Oy8A0TwDEuk9B+UWAXDIDGxTJDxfazvApGWSa3ra1pzzlqcXuF9macO61ZaOYd42DHWn
         /tAeurYO2ZZFZPl3+1FpxOxF0sGxg9o/YQkEsazEqhFf7F0K2HpgbnrlWWLVcr5QPaeF
         6I3A==
X-Gm-Message-State: AOAM533T8UBiST25VpxnoyQeXdWUhqThWC7wvfSJqS9c6pv7iweR5qvp
        LNPgvuIirg5s6KekUMD3Y8Nf3SF7MiE5DuDhmqg=
X-Google-Smtp-Source: ABdhPJxQzkjnwKKTvUWtOFSBjqRQXdhezEWr76+MTtYqAlAWY3NgmCZVyMzPuCI0+/I9MMHvmwJYl0SVEb7UJ3T2VQQ=
X-Received: by 2002:ac8:6605:: with SMTP id c5mr9562405qtp.21.1620983047324;
 Fri, 14 May 2021 02:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210513214404.xks77p566fglzgum@riteshh-domain>
In-Reply-To: <20210513214404.xks77p566fglzgum@riteshh-domain>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 14 May 2021 10:03:56 +0100
Message-ID: <CAL3q7H5PbcWPO3Qn_ARerzQK2a-+AK2f3+v9LPjyUgKJ6BotJQ@mail.gmail.com>
Subject: Re: btrfs/112 failure causing lockdep warning?
To:     riteshh <riteshh@linux.ibm.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 2:05 AM riteshh <riteshh@linux.ibm.com> wrote:
>
> Hello,
>
> I am seeing below failure on v5.13-rc1. I could recall that I see the sim=
ilar
> warning on 5.12 as well. Is this a known issue?

It's not new, it happens since we switched the btree locks to rw
semaphores a few kernel releases ago.
This is actually a false positive since both locks are acquired in read mod=
e.

Nevertheless it's good to silence lockdep and in this case it's
trivial to do so.
I've just sent a patch for it.

Thanks.

>
> btrfs/112 3s ...        [21:34:13][   41.306155] run fstests btrfs/112 at=
 2021-05-13 21:34:13
>
> [   46.305677] BTRFS: device fsid 4e2f15b9-c61b-4b0e-9734-fa8ca5a2aac7 de=
vid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (3741)
> [   46.365416] BTRFS info (device vdc): disk space caching is enabled
> [   46.367401] BTRFS info (device vdc): has skinny extents
> [   46.381101] BTRFS info (device vdc): checking UUID tree
> [   46.580634]
> [   46.580704] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   46.580752] WARNING: possible circular locking dependency detected
> [   46.580799] 5.13.0-rc1 #28 Not tainted
> [   46.580832] ------------------------------------------------------
> [   46.580877] cloner/3835 is trying to acquire lock:
> [   46.580918] c00000001301d638 (sb_internal#2){.+.+}-{0:0}, at: clone_co=
py_inline_extent+0xe4/0x5a0
> [   46.581167]
> [   46.581167] but task is already holding lock:
> [   46.581217] c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_=
tree_read_lock+0x70/0x1d0
> [   46.581293]
> [   46.581293] which lock already depends on the new lock.
> [   46.581293]
> [   46.581351]
> [   46.581351] the existing dependency chain (in reverse order) is:
> [   46.581410]
> [   46.581410] -> #1 (btrfs-tree-00){++++}-{3:3}:
> [   46.581464]        down_read_nested+0x68/0x200
> [   46.581536]        __btrfs_tree_read_lock+0x70/0x1d0
> [   46.581577]        btrfs_read_lock_root_node+0x88/0x200
> [   46.581623]        btrfs_search_slot+0x298/0xb70
> [   46.581665]        btrfs_set_inode_index+0xfc/0x260
> [   46.581708]        btrfs_new_inode+0x26c/0x950
> [   46.581749]        btrfs_create+0xf4/0x2b0
> [   46.581782]        lookup_open.isra.57+0x55c/0x6a0
> [   46.581855]        path_openat+0x418/0xd20
> [   46.581888]        do_filp_open+0x9c/0x130
> [   46.581920]        do_sys_openat2+0x2ec/0x430
> [   46.581961]        do_sys_open+0x90/0xc0
> [   46.581993]        system_call_exception+0x3d4/0x410
> [   46.582037]        system_call_common+0xec/0x278
> [   46.582078]
> [   46.582078] -> #0 (sb_internal#2){.+.+}-{0:0}:
> [   46.582135]        __lock_acquire+0x1e90/0x2c50
> [   46.582176]        lock_acquire+0x2b4/0x5b0
> [   46.582263]        start_transaction+0x3cc/0x950
> [   46.582308]        clone_copy_inline_extent+0xe4/0x5a0
> [   46.582353]        btrfs_clone+0x5fc/0x880
> [   46.582388]        btrfs_clone_files+0xd8/0x1c0
> [   46.582434]        btrfs_remap_file_range+0x3d8/0x590
> [   46.582481]        do_clone_file_range+0x10c/0x270
> [   46.582558]        vfs_clone_file_range+0x1b0/0x310
> [   46.582605]        ioctl_file_clone+0x90/0x130
> [   46.582651]        do_vfs_ioctl+0x874/0x1ac0
> [   46.582697]        sys_ioctl+0x6c/0x120
> [   46.582733]        system_call_exception+0x3d4/0x410
> [   46.582777]        system_call_common+0xec/0x278
> [   46.582822]
> [   46.582822] other info that might help us debug this:
> [   46.582822]
> [   46.582888]  Possible unsafe locking scenario:
> [   46.582888]
> [   46.582942]        CPU0                    CPU1
> [   46.582984]        ----                    ----
> [   46.583028]   lock(btrfs-tree-00);
> [   46.583062]                                lock(sb_internal#2);
> [   46.583119]                                lock(btrfs-tree-00);
> [   46.583174]   lock(sb_internal#2);
> [   46.583212]
> [   46.583212]  *** DEADLOCK ***
> [   46.583212]
> [   46.583266] 6 locks held by cloner/3835:
> [   46.583299]  #0: c00000001301d448 (sb_writers#12){.+.+}-{0:0}, at: ioc=
tl_file_clone+0x90/0x130
> [   46.583382]  #1: c00000000f6d3768 (&sb->s_type->i_mutex_key#15){+.+.}-=
{3:3}, at: lock_two_nondirectories+0x58/0xc0
> [   46.583477]  #2: c00000000f6d72a8 (&sb->s_type->i_mutex_key#15/4){+.+.=
}-{3:3}, at: lock_two_nondirectories+0x9c/0xc0
> [   46.583574]  #3: c00000000f6d7138 (&ei->i_mmap_lock){+.+.}-{3:3}, at: =
btrfs_remap_file_range+0xd0/0x590
> [   46.583657]  #4: c00000000f6d35f8 (&ei->i_mmap_lock/1){+.+.}-{3:3}, at=
: btrfs_remap_file_range+0xe0/0x590
> [   46.583743]  #5: c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __b=
trfs_tree_read_lock+0x70/0x1d0
> [   46.583828]
> [   46.583828] stack backtrace:
> [   46.583872] CPU: 1 PID: 3835 Comm: cloner Not tainted 5.13.0-rc1 #28
> [   46.583931] Call Trace:
> [   46.583955] [c0000000167c7200] [c000000000c1ee78] dump_stack+0xec/0x14=
4 (unreliable)
> [   46.584052] [c0000000167c7240] [c000000000274058] print_circular_bug.i=
sra.32+0x3a8/0x400
> [   46.584123] [c0000000167c72e0] [c0000000002741f4] check_noncircular+0x=
144/0x190
> [   46.584191] [c0000000167c73b0] [c000000000278fc0] __lock_acquire+0x1e9=
0/0x2c50
> [   46.584259] [c0000000167c74f0] [c00000000027aa94] lock_acquire+0x2b4/0=
x5b0
> [   46.584317] [c0000000167c75e0] [c000000000a0d6cc] start_transaction+0x=
3cc/0x950
> [   46.584388] [c0000000167c7690] [c000000000af47a4] clone_copy_inline_ex=
tent+0xe4/0x5a0
> [   46.584457] [c0000000167c77c0] [c000000000af525c] btrfs_clone+0x5fc/0x=
880
> [   46.584514] [c0000000167c7990] [c000000000af5698] btrfs_clone_files+0x=
d8/0x1c0
> [   46.584583] [c0000000167c7a00] [c000000000af5b58] btrfs_remap_file_ran=
ge+0x3d8/0x590
> [   46.584652] [c0000000167c7ae0] [c0000000005d81dc] do_clone_file_range+=
0x10c/0x270
> [   46.584722] [c0000000167c7b40] [c0000000005d84f0] vfs_clone_file_range=
+0x1b0/0x310
> [   46.584793] [c0000000167c7bb0] [c00000000058bf80] ioctl_file_clone+0x9=
0/0x130
> [   46.584861] [c0000000167c7c10] [c00000000058c894] do_vfs_ioctl+0x874/0=
x1ac0
> [   46.584922] [c0000000167c7d10] [c00000000058db4c] sys_ioctl+0x6c/0x120
> [   46.584978] [c0000000167c7d60] [c0000000000364a4] system_call_exceptio=
n+0x3d4/0x410
> [   46.585046] [c0000000167c7e10] [c00000000000d45c] system_call_common+0=
xec/0x278
> [   46.585114] --- interrupt: c00 at 0x7ffff7e22990
> [   46.585160] NIP:  00007ffff7e22990 LR: 00000001000010ec CTR: 000000000=
0000000
> [   46.585224] REGS: c0000000167c7e80 TRAP: 0c00   Not tainted  (5.13.0-r=
c1)
> [   46.585280] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE=
>  CR: 28000244  XER: 00000000
> [   46.585374] IRQMASK: 0
> [   46.585374] GPR00: 0000000000000036 00007fffffffdec0 00007ffff7f17100 =
0000000000000004
> [   46.585374] GPR04: 000000008020940d 00007fffffffdf40 0000000000000000 =
0000000000000000
> [   46.585374] GPR08: 0000000000000004 0000000000000000 0000000000000000 =
0000000000000000
> [   46.585374] GPR12: 0000000000000000 00007ffff7ffa940 0000000000000000 =
0000000000000000
> [   46.585374] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
> [   46.585374] GPR20: 0000000000000000 000000009123683e 00007fffffffdf40 =
0000000000000000
> [   46.585374] GPR24: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000004
> [   46.585374] GPR28: 0000000100030260 0000000100030280 0000000000000003 =
000000000000005f
> [   46.585919] NIP [00007ffff7e22990] 0x7ffff7e22990
> [   46.585964] LR [00000001000010ec] 0x1000010ec
> [   46.586010] --- interrupt: c00
>
> [   51.018340] BTRFS: device fsid 09d13397-1bb3-425e-8b98-ff3771442441 de=
vid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (3841)
> [   51.058553] BTRFS info (device vdc): use zlib compression, level 3
> [   51.058641] BTRFS info (device vdc): disk space caching is enabled
> [   51.058690] BTRFS info (device vdc): has skinny extents
> [   51.080240] BTRFS info (device vdc): checking UUID tree
>
> [   55.631182] BTRFS: device fsid 0254de1a-5b6a-40d8-b75a-8940477d1853 de=
vid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (3940)
> [   55.663889] BTRFS info (device vdc): disk space caching is enabled
> [   55.664206] BTRFS info (device vdc): has skinny extents
> [   55.700305] BTRFS info (device vdc): checking UUID tree
> [   55.737159] random: crng init done
> [   55.737430] random: 7 urandom warning(s) missed due to ratelimiting
> [   56.268773] BTRFS: device fsid e5ce6c0b-cd36-4fc5-a9cf-059897fb1b84 de=
vid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (4040)
> [   56.303277] BTRFS info (device vdc): use zlib compression, level 3
> [   56.304065] BTRFS info (device vdc): disk space caching is enabled
> [   56.304132] BTRFS info (device vdc): has skinny extents
> [   56.329306] BTRFS info (device vdc): checking UUID tree
>
> _check_dmesg: something found in dmesg (see /results/btrfs/results-64k/bt=
rfs/112.dmesg)
>
> -ritesh



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
