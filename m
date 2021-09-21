Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34B9413347
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 14:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhIUMUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhIUMUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 08:20:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2168EC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 05:18:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u21so18645934qtw.8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=m1EhrjZ2e9R94OjF8/YTaS/upy7M3i+/9k7VyK4QH6A=;
        b=OuxEp9bJ0YGO4M1jcLrjucnGoioKIFgER3bw2tCPV8dYhvJOui0S7hxdH3FwOKP9U2
         TMDq6QqgKuWaMPcgApCsi2bziXikBvAHhml/mP3bis8UpZMVrOzUV4PBJVxt9GKSQEEx
         2J+4r17q7aedf/M/msFJDqBcuELzdQ4VcG5WAdRsH/ByZetp/2yS0b/6MoD/pV5moy3J
         34NdVV766M5SK9YdnYS9Y+3xy1qL0cRFALZUU5GCy+2iJLMZrB6RwPLveW43rfW4rWnd
         jU/zwdG6+LW/oigVQzH+dgQHICON9FaDfndm+YwH1sfP5kX2UXnQoRLeItiqrN6p040b
         GpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=m1EhrjZ2e9R94OjF8/YTaS/upy7M3i+/9k7VyK4QH6A=;
        b=n3os06PMwU/ASrkT0T5tzf3nQNFSVjxdueqpsBMryJTejgAKNFFwc2LxjtbmP5tcNs
         3rWEwd4k346IUNTm1NN6shp+TpWYqHd6jHUXtaalWkJh6Sa/1eNEec4NDLGnvbBjnrgZ
         TpwNl1SrhcZuhc0QirfAZbMZqNJ7iVALPpwNxeqDX30lFhmqrZzQ2zhVXtJuFThnNoZ2
         kN8s+77p8bwiSGSm+3pvfCatZSHFaWUBwiJnRA9gH6GZBrXDZZ+YV0mLyTgOwww+nXLC
         RBwYZRYCUXPaubZyU4Skts36lb67/ZPvNamcZdYzs4L/tR+4ybECbaeWW2ysCve1VTJU
         2B+Q==
X-Gm-Message-State: AOAM531/2O8WLoRzvf/vy4W7V7bcX5x1BbMFEMwMQsN16iQReLFSHrz/
        TH9ZosR/5VG22ZmF6xXB/tvxmfGQtiCRB9oUQ+A=
X-Google-Smtp-Source: ABdhPJyRliKrQrdAgQLqjz5KLn+55Q8OHv6YadbV5psn+ndKiUlCZx7LkzmO674VSA6XXFpt3rQlB0kOrLc/8AvEQ3k=
X-Received: by 2002:ac8:7354:: with SMTP id q20mr27501868qtp.329.1632226714957;
 Tue, 21 Sep 2021 05:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627419595.git.josef@toxicpanda.com> <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <CAL3q7H6KdA+ay4y=wTMjXBiXNPw8n0rhyfKS7WNqh3uOm2XuZw@mail.gmail.com>
In-Reply-To: <CAL3q7H6KdA+ay4y=wTMjXBiXNPw8n0rhyfKS7WNqh3uOm2XuZw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 21 Sep 2021 13:17:57 +0100
Message-ID: <CAL3q7H7Ohy+vHmVu2s4nJa9Kj4U4aRgUZ2U7kSxOGC0kqJdYjw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 21, 2021 at 12:59 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Tue, Jul 27, 2021 at 10:05 PM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >
> > We got the following lockdep splat while running xfstests (specifically
> > btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
> > by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") whic=
h
> > converted loop to using workqueues, which comes with lockdep
> > annotations that don't exist with kworkers.  The lockdep splat is as
> > follows
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 5.14.0-rc2-custom+ #34 Not tainted
> > ------------------------------------------------------
> > losetup/156417 is trying to acquire lock:
> > ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueu=
e+0x84/0x600
> >
> > but task is already holding lock:
> > ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x=
650 [loop]
> >
> > which lock already depends on the new lock.
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
> >        __mutex_lock+0xba/0x7c0
> >        lo_open+0x28/0x60 [loop]
> >        blkdev_get_whole+0x28/0xf0
> >        blkdev_get_by_dev.part.0+0x168/0x3c0
> >        blkdev_open+0xd2/0xe0
> >        do_dentry_open+0x163/0x3a0
> >        path_openat+0x74d/0xa40
> >        do_filp_open+0x9c/0x140
> >        do_sys_openat2+0xb1/0x170
> >        __x64_sys_openat+0x54/0x90
> >        do_syscall_64+0x3b/0x90
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > -> #4 (&disk->open_mutex){+.+.}-{3:3}:
> >        __mutex_lock+0xba/0x7c0
> >        blkdev_get_by_dev.part.0+0xd1/0x3c0
> >        blkdev_get_by_path+0xc0/0xd0
> >        btrfs_scan_one_device+0x52/0x1f0 [btrfs]
> >        btrfs_control_ioctl+0xac/0x170 [btrfs]
> >        __x64_sys_ioctl+0x83/0xb0
> >        do_syscall_64+0x3b/0x90
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > -> #3 (uuid_mutex){+.+.}-{3:3}:
> >        __mutex_lock+0xba/0x7c0
> >        btrfs_rm_device+0x48/0x6a0 [btrfs]
> >        btrfs_ioctl+0x2d1c/0x3110 [btrfs]
> >        __x64_sys_ioctl+0x83/0xb0
> >        do_syscall_64+0x3b/0x90
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > -> #2 (sb_writers#11){.+.+}-{0:0}:
> >        lo_write_bvec+0x112/0x290 [loop]
> >        loop_process_work+0x25f/0xcb0 [loop]
> >        process_one_work+0x28f/0x5d0
> >        worker_thread+0x55/0x3c0
> >        kthread+0x140/0x170
> >        ret_from_fork+0x22/0x30
> >
> > -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
> >        process_one_work+0x266/0x5d0
> >        worker_thread+0x55/0x3c0
> >        kthread+0x140/0x170
> >        ret_from_fork+0x22/0x30
> >
> > -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
> >        __lock_acquire+0x1130/0x1dc0
> >        lock_acquire+0xf5/0x320
> >        flush_workqueue+0xae/0x600
> >        drain_workqueue+0xa0/0x110
> >        destroy_workqueue+0x36/0x250
> >        __loop_clr_fd+0x9a/0x650 [loop]
> >        lo_ioctl+0x29d/0x780 [loop]
> >        block_ioctl+0x3f/0x50
> >        __x64_sys_ioctl+0x83/0xb0
> >        do_syscall_64+0x3b/0x90
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > other info that might help us debug this:
> > Chain exists of:
> >   (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> >  Possible unsafe locking scenario:
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&lo->lo_mutex);
> >                                lock(&disk->open_mutex);
> >                                lock(&lo->lo_mutex);
> >   lock((wq_completion)loop0);
> >
> >  *** DEADLOCK ***
> > 1 lock held by losetup/156417:
> >  #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x=
41/0x650 [loop]
> >
> > stack backtrace:
> > CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/20=
15
> > Call Trace:
> >  dump_stack_lvl+0x57/0x72
> >  check_noncircular+0x10a/0x120
> >  __lock_acquire+0x1130/0x1dc0
> >  lock_acquire+0xf5/0x320
> >  ? flush_workqueue+0x84/0x600
> >  flush_workqueue+0xae/0x600
> >  ? flush_workqueue+0x84/0x600
> >  drain_workqueue+0xa0/0x110
> >  destroy_workqueue+0x36/0x250
> >  __loop_clr_fd+0x9a/0x650 [loop]
> >  lo_ioctl+0x29d/0x780 [loop]
> >  ? __lock_acquire+0x3a0/0x1dc0
> >  ? update_dl_rq_load_avg+0x152/0x360
> >  ? lock_is_held_type+0xa5/0x120
> >  ? find_held_lock.constprop.0+0x2b/0x80
> >  block_ioctl+0x3f/0x50
> >  __x64_sys_ioctl+0x83/0xb0
> >  do_syscall_64+0x3b/0x90
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f645884de6b
> >
> > Usually the uuid_mutex exists to protect the fs_devices that map
> > together all of the devices that match a specific uuid.  In rm_device
> > we're messing with the uuid of a device, so it makes sense to protect
> > that here.
> >
> > However in doing that it pulls in a whole host of lockdep dependencies,
> > as we call mnt_may_write() on the sb before we grab the uuid_mutex, thu=
s
> > we end up with the dependency chain under the uuid_mutex being added
> > under the normal sb write dependency chain, which causes problems with
> > loop devices.
> >
> > We don't need the uuid mutex here however.  If we call
> > btrfs_scan_one_device() before we scratch the super block we will find
> > the fs_devices and not find the device itself and return EBUSY because
> > the fs_devices is open.  If we call it after the scratch happens it wil=
l
> > not appear to be a valid btrfs file system.
> >
> > We do not need to worry about other fs_devices modifying operations her=
e
> > because we're protected by the exclusive operations locking.
> >
> > So drop the uuid_mutex here in order to fix the lockdep splat.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/volumes.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 5217b93172b4..0e7372f637eb 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2082,8 +2082,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info=
, const char *device_path,
> >         u64 num_devices;
> >         int ret =3D 0;
> >
> > -       mutex_lock(&uuid_mutex);
> > -
> >         num_devices =3D btrfs_num_devices(fs_info);
> >
> >         ret =3D btrfs_check_raid_min_devices(fs_info, num_devices - 1);
> > @@ -2127,11 +2125,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_inf=
o, const char *device_path,
> >                 mutex_unlock(&fs_info->chunk_mutex);
> >         }
> >
> > -       mutex_unlock(&uuid_mutex);
> >         ret =3D btrfs_shrink_device(device, 0);
> >         if (!ret)
> >                 btrfs_reada_remove_dev(device);
> > -       mutex_lock(&uuid_mutex);
>
> On misc-next, this is now triggering a warning due to a lockdep
> assertion failure:
>
> [ 5343.002752] ------------[ cut here ]------------
> [ 5343.002756] WARNING: CPU: 3 PID: 797246 at fs/btrfs/volumes.c:1165
> close_fs_devices+0x200/0x220 [btrfs]
> [ 5343.002813] Modules linked in: dm_dust btrfs dm_flakey dm_mod
> blake2b_generic xor raid6_pq libcrc32c bochs drm_vram_helper
> intel_rapl_msr intel_rapl_common drm_ttm_helper crct10dif_pclmul ttm
> ghash_clmulni_intel aesni_intel drm_kms_helper crypto_simd ppdev
> cryptd joy>
> [ 5343.002876] CPU: 3 PID: 797246 Comm: btrfs Not tainted
> 5.15.0-rc2-btrfs-next-99 #1
> [ 5343.002879] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 5343.002883] RIP: 0010:close_fs_devices+0x200/0x220 [btrfs]
> [ 5343.002912] Code: 8b 43 78 48 85 c0 0f 85 89 fe ff ff e9 7e fe ff
> ff be ff ff ff ff 48 c7 c7 10 6f bd c0 e8 58 70 7d c9 85 c0 0f 85 20
> fe ff ff <0f> 0b e9 19 fe ff ff 0f 0b e9 63 ff ff ff 0f 0b e9 67 ff ff
> ff 66
> [ 5343.002914] RSP: 0018:ffffb32608fe7d38 EFLAGS: 00010246
> [ 5343.002917] RAX: 0000000000000000 RBX: ffff948d78f6b538 RCX: 000000000=
0000001
> [ 5343.002918] RDX: 0000000000000000 RSI: ffffffff8aabac29 RDI: ffffffff8=
ab2a43e
> [ 5343.002920] RBP: ffff948d78f6b400 R08: ffff948d4fcecd38 R09: 000000000=
0000000
> [ 5343.002921] R10: 0000000000000000 R11: 0000000000000000 R12: ffff948d4=
fcecc78
> [ 5343.002922] R13: ffff948d401bc000 R14: ffff948d78f6b400 R15: ffff948d4=
fcecc00
> [ 5343.002924] FS:  00007fe1259208c0(0000) GS:ffff94906d400000(0000)
> knlGS:0000000000000000
> [ 5343.002926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5343.002927] CR2: 00007fe125a953d5 CR3: 00000001017ca005 CR4: 000000000=
0370ee0
> [ 5343.002930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 5343.002932] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 5343.002933] Call Trace:
> [ 5343.002938]  btrfs_rm_device.cold+0x147/0x1c0 [btrfs]
> [ 5343.002981]  btrfs_ioctl+0x2dc2/0x3460 [btrfs]
> [ 5343.003021]  ? __do_sys_newstat+0x48/0x70
> [ 5343.003028]  ? lock_is_held_type+0xe8/0x140
> [ 5343.003034]  ? __x64_sys_ioctl+0x83/0xb0
> [ 5343.003037]  __x64_sys_ioctl+0x83/0xb0
> [ 5343.003042]  do_syscall_64+0x3b/0xc0
> [ 5343.003045]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 5343.003048] RIP: 0033:0x7fe125a17d87
> [ 5343.003051] Code: 00 00 00 48 8b 05 09 91 0c 00 64 c7 00 26 00 00
> 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d9 90 0c 00 f7 d8 64 89
> 01 48
> [ 5343.003053] RSP: 002b:00007ffdbfbd11c8 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000010
> [ 5343.003056] RAX: ffffffffffffffda RBX: 00007ffdbfbd33b0 RCX: 00007fe12=
5a17d87
> [ 5343.003057] RDX: 00007ffdbfbd21e0 RSI: 000000005000943a RDI: 000000000=
0000003
> [ 5343.003059] RBP: 0000000000000000 R08: 0000000000000000 R09: 006264732=
f766564
> [ 5343.003060] R10: fffffffffffffebb R11: 0000000000000206 R12: 000000000=
0000003
> [ 5343.003061] R13: 00007ffdbfbd33b0 R14: 0000000000000000 R15: 00007ffdb=
fbd33b8
> [ 5343.003077] irq event stamp: 202039
> [ 5343.003079] hardirqs last  enabled at (202045):
> [<ffffffff8992d2a0>] __up_console_sem+0x60/0x70
> [ 5343.003082] hardirqs last disabled at (202050):
> [<ffffffff8992d285>] __up_console_sem+0x45/0x70
> [ 5343.003083] softirqs last  enabled at (196012):
> [<ffffffff898a0f2b>] irq_exit_rcu+0xeb/0x130
> [ 5343.003086] softirqs last disabled at (195973):
> [<ffffffff898a0f2b>] irq_exit_rcu+0xeb/0x130
> [ 5343.003090] ---[ end trace 7b957e10a906f920 ]---
>
> Happens all the time on btrfs/164 for example.
> Maybe some other patch is missing?

Also, this patch alone does not (completely at least) fix that lockdep
issue with lo_mutex and disk->open_mutex, at least not on current
misc-next.
btrfs/199 triggers this:

[ 6285.539713] run fstests btrfs/199 at 2021-09-21 13:08:09
[ 6286.090226] BTRFS info (device sda): flagging fs with big metadata featu=
re
[ 6286.090233] BTRFS info (device sda): disk space caching is enabled
[ 6286.090236] BTRFS info (device sda): has skinny extents
[ 6286.268451] loop: module loaded
[ 6286.515848] BTRFS: device fsid b59e1692-d742-4826-bb86-11b14cd1d0b0
devid 1 transid 5 /dev/sdb scanned by mkfs.btrfs (838579)
[ 6286.566724] BTRFS info (device sdb): flagging fs with big metadata featu=
re
[ 6286.566732] BTRFS info (device sdb): disk space caching is enabled
[ 6286.566735] BTRFS info (device sdb): has skinny extents
[ 6286.575156] BTRFS info (device sdb): checking UUID tree
[ 6286.773181] loop0: detected capacity change from 0 to 20971520
[ 6286.817351] BTRFS: device fsid d416e8f8-f18e-41c8-8038-932a871c0763
devid 1 transid 5 /dev/loop0 scanned by systemd-udevd (831305)
[ 6286.837095] BTRFS info (device loop0): flagging fs with big metadata fea=
ture
[ 6286.837101] BTRFS info (device loop0): disabling disk space caching
[ 6286.837103] BTRFS info (device loop0): setting nodatasum
[ 6286.837105] BTRFS info (device loop0): turning on sync discard
[ 6286.837107] BTRFS info (device loop0): has skinny extents
[ 6286.847904] BTRFS info (device loop0): enabling ssd optimizations
[ 6286.848767] BTRFS info (device loop0): cleaning free space cache v1
[ 6286.870143] BTRFS info (device loop0): checking UUID tree

[ 6323.701494] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 6323.702261] WARNING: possible circular locking dependency detected
[ 6323.703033] 5.15.0-rc2-btrfs-next-99 #1 Tainted: G        W
[ 6323.703818] ------------------------------------------------------
[ 6323.704591] losetup/838700 is trying to acquire lock:
[ 6323.705225] ffff948d4bb35948 ((wq_completion)loop0){+.+.}-{0:0},
at: flush_workqueue+0x8b/0x5b0
[ 6323.706316]
               but task is already holding lock:
[ 6323.707047] ffff948d7c093ca0 (&lo->lo_mutex){+.+.}-{3:3}, at:
__loop_clr_fd+0x5a/0x680 [loop]
[ 6323.708198]
               which lock already depends on the new lock.

[ 6323.709664]
               the existing dependency chain (in reverse order) is:
[ 6323.711007]
               -> #4 (&lo->lo_mutex){+.+.}-{3:3}:
[ 6323.712103]        __mutex_lock+0x92/0x900
[ 6323.712851]        lo_open+0x28/0x60 [loop]
[ 6323.713612]        blkdev_get_whole+0x28/0x90
[ 6323.714405]        blkdev_get_by_dev.part.0+0x142/0x320
[ 6323.715348]        blkdev_open+0x5e/0xa0
[ 6323.716057]        do_dentry_open+0x163/0x390
[ 6323.716841]        path_openat+0x3f0/0xa80
[ 6323.717585]        do_filp_open+0xa9/0x150
[ 6323.718326]        do_sys_openat2+0x97/0x160
[ 6323.719099]        __x64_sys_openat+0x54/0x90
[ 6323.719896]        do_syscall_64+0x3b/0xc0
[ 6323.720640]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 6323.721652]
               -> #3 (&disk->open_mutex){+.+.}-{3:3}:
[ 6323.722791]        __mutex_lock+0x92/0x900
[ 6323.723530]        blkdev_get_by_dev.part.0+0x56/0x320
[ 6323.724468]        blkdev_get_by_path+0xb8/0xd0
[ 6323.725291]        btrfs_get_bdev_and_sb+0x1b/0xb0 [btrfs]
[ 6323.726344]        btrfs_find_device_by_devspec+0x154/0x1e0 [btrfs]
[ 6323.727519]        btrfs_rm_device+0x14d/0x770 [btrfs]
[ 6323.728253]        btrfs_ioctl+0x2dc2/0x3460 [btrfs]
[ 6323.728911]        __x64_sys_ioctl+0x83/0xb0
[ 6323.729439]        do_syscall_64+0x3b/0xc0
[ 6323.729943]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 6323.730625]
               -> #2 (sb_writers#14){.+.+}-{0:0}:
[ 6323.731367]        lo_write_bvec+0xea/0x2a0 [loop]
[ 6323.731964]        loop_process_work+0x257/0xdb0 [loop]
[ 6323.732606]        process_one_work+0x24c/0x5b0
[ 6323.733176]        worker_thread+0x55/0x3c0
[ 6323.733692]        kthread+0x155/0x180
[ 6323.734157]        ret_from_fork+0x22/0x30
[ 6323.734662]
               -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
[ 6323.735619]        process_one_work+0x223/0x5b0
[ 6323.736181]        worker_thread+0x55/0x3c0
[ 6323.736708]        kthread+0x155/0x180
[ 6323.737168]        ret_from_fork+0x22/0x30
[ 6323.737671]
               -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[ 6323.738464]        __lock_acquire+0x130e/0x2210
[ 6323.739033]        lock_acquire+0xd7/0x310
[ 6323.739539]        flush_workqueue+0xb5/0x5b0
[ 6323.740084]        drain_workqueue+0xa0/0x110
[ 6323.740621]        destroy_workqueue+0x36/0x280
[ 6323.741191]        __loop_clr_fd+0xb4/0x680 [loop]
[ 6323.741785]        block_ioctl+0x48/0x50
[ 6323.742272]        __x64_sys_ioctl+0x83/0xb0
[ 6323.742800]        do_syscall_64+0x3b/0xc0
[ 6323.743307]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 6323.743995]
               other info that might help us debug this:

[ 6323.744979] Chain exists of:
                 (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mut=
ex

[ 6323.746338]  Possible unsafe locking scenario:

[ 6323.747073]        CPU0                    CPU1
[ 6323.747628]        ----                    ----
[ 6323.748190]   lock(&lo->lo_mutex);
[ 6323.748612]                                lock(&disk->open_mutex);
[ 6323.749386]                                lock(&lo->lo_mutex);
[ 6323.750201]   lock((wq_completion)loop0);
[ 6323.750696]
                *** DEADLOCK ***

[ 6323.751415] 1 lock held by losetup/838700:
[ 6323.751925]  #0: ffff948d7c093ca0 (&lo->lo_mutex){+.+.}-{3:3}, at:
__loop_clr_fd+0x5a/0x680 [loop]
[ 6323.753025]
               stack backtrace:
[ 6323.753556] CPU: 7 PID: 838700 Comm: losetup Tainted: G        W
     5.15.0-rc2-btrfs-next-99 #1
[ 6323.754659] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[ 6323.756066] Call Trace:
[ 6323.756375]  dump_stack_lvl+0x57/0x72
[ 6323.756842]  check_noncircular+0xf3/0x110
[ 6323.757341]  ? stack_trace_save+0x4b/0x70
[ 6323.757837]  __lock_acquire+0x130e/0x2210
[ 6323.758335]  lock_acquire+0xd7/0x310
[ 6323.758769]  ? flush_workqueue+0x8b/0x5b0
[ 6323.759258]  ? lockdep_init_map_type+0x51/0x260
[ 6323.759822]  ? lockdep_init_map_type+0x51/0x260
[ 6323.760382]  flush_workqueue+0xb5/0x5b0
[ 6323.760867]  ? flush_workqueue+0x8b/0x5b0
[ 6323.761367]  ? __mutex_unlock_slowpath+0x45/0x280
[ 6323.761948]  drain_workqueue+0xa0/0x110
[ 6323.762426]  destroy_workqueue+0x36/0x280
[ 6323.762924]  __loop_clr_fd+0xb4/0x680 [loop]
[ 6323.763465]  ? blkdev_ioctl+0xb5/0x320
[ 6323.763935]  block_ioctl+0x48/0x50
[ 6323.764356]  __x64_sys_ioctl+0x83/0xb0
[ 6323.764828]  do_syscall_64+0x3b/0xc0
[ 6323.765269]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 6323.765887] RIP: 0033:0x7fb0fe20dd87

>
>
> >         if (ret)
> >                 goto error_undo;
> >
> > @@ -2215,7 +2211,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info=
, const char *device_path,
> >         }
> >
> >  out:
> > -       mutex_unlock(&uuid_mutex);
> >         return ret;
> >
> >  error_undo:
> > --
> > 2.26.3
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
