Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7385541330C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhIUMBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 08:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhIUMBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 08:01:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EDAC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 04:59:41 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id m9so18602327qtk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1fqjEfl2Ew+jgWyxx6UjK2upCfvULloQJAjRk3AVmok=;
        b=G/bhMN1nsmnoExM7vJPQXmrSNUtdni11/UUSH2opz4KR9jhmv43L/WIU4Xa642KrVe
         VZ1UO1dUd7Y+5F/Tt8IGcTcWsTFrc+Y+sQqJTxrrYsLfC2xnN8xJKWZsITnBis+e2Une
         OGLbO9cgAp8QiXCxEzlvU00fY0mR53xY4fduGVq2PQUp33KR8N+j/UvIQtFcPD8exPcX
         RCTR14Uhu1kT5RSJb5xbz30dX7nQqNS5xQiJYxVeP1g6VQjXXBuRIE/7MtTp+PG76KeP
         ZEQtW0Ll54ur8v9XYBDtZMlgS+IJJYW+yUxOA20CZf2AdjKm6lCaWexM5eMrrCO4K62q
         go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1fqjEfl2Ew+jgWyxx6UjK2upCfvULloQJAjRk3AVmok=;
        b=5EOtD62ZkNg9KFYylvqtZD1nEQLT+eTdWoaKwbrolhKDqa+tLJRue3ElW4YXB9I3L/
         DgFNN42ARClH+C3kvS/kXiYPQb23QEesSYAszDTmD2e/zdatk9KeBD1qKHltO2ZpdA/b
         ytDmiiIRAwgFJ/BY+kZMsvcmMBsMJMstQcwyHlHfo0H/V7tV4GUZ+qPj8lEpZ+NtjROF
         hS/McYWdygen6Db3MNWJGAtLppBpTKiqO05jxbrWF4pNgox5JtEfly218r2ASfdt3HOX
         edg8WVt08YoALdvN3u8gE/zzANjULTf/rTjVPbr1/+64sZFxCbz+msYpJu1pkKxpIFY1
         Uahw==
X-Gm-Message-State: AOAM53176Y8BpkMWbby+jNRXjOaWT9/FqZV2Q5hA3IrELIziwk9VmIVW
        w6zC7M/+HAlo5eUIcnyJ0N5tnOt53Qr/tQ9C5Vw=
X-Google-Smtp-Source: ABdhPJxZ+YvsXSJQiWVeLEQdfszS8HyuIPfXI4Izk8+zZZfMqLiHvnNTNQnHNmWRUjAxs5O6rRVgkFUnXkIgUm2MiO4=
X-Received: by 2002:ac8:7959:: with SMTP id r25mr22043571qtt.29.1632225580980;
 Tue, 21 Sep 2021 04:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627419595.git.josef@toxicpanda.com> <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
In-Reply-To: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 21 Sep 2021 12:59:04 +0100
Message-ID: <CAL3q7H6KdA+ay4y=wTMjXBiXNPw8n0rhyfKS7WNqh3uOm2XuZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 10:05 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We got the following lockdep splat while running xfstests (specifically
> btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
> by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
> converted loop to using workqueues, which comes with lockdep
> annotations that don't exist with kworkers.  The lockdep splat is as
> follows
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2-custom+ #34 Not tainted
> ------------------------------------------------------
> losetup/156417 is trying to acquire lock:
> ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+=
0x84/0x600
>
> but task is already holding lock:
> ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x65=
0 [loop]
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
>        __mutex_lock+0xba/0x7c0
>        lo_open+0x28/0x60 [loop]
>        blkdev_get_whole+0x28/0xf0
>        blkdev_get_by_dev.part.0+0x168/0x3c0
>        blkdev_open+0xd2/0xe0
>        do_dentry_open+0x163/0x3a0
>        path_openat+0x74d/0xa40
>        do_filp_open+0x9c/0x140
>        do_sys_openat2+0xb1/0x170
>        __x64_sys_openat+0x54/0x90
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> -> #4 (&disk->open_mutex){+.+.}-{3:3}:
>        __mutex_lock+0xba/0x7c0
>        blkdev_get_by_dev.part.0+0xd1/0x3c0
>        blkdev_get_by_path+0xc0/0xd0
>        btrfs_scan_one_device+0x52/0x1f0 [btrfs]
>        btrfs_control_ioctl+0xac/0x170 [btrfs]
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> -> #3 (uuid_mutex){+.+.}-{3:3}:
>        __mutex_lock+0xba/0x7c0
>        btrfs_rm_device+0x48/0x6a0 [btrfs]
>        btrfs_ioctl+0x2d1c/0x3110 [btrfs]
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> -> #2 (sb_writers#11){.+.+}-{0:0}:
>        lo_write_bvec+0x112/0x290 [loop]
>        loop_process_work+0x25f/0xcb0 [loop]
>        process_one_work+0x28f/0x5d0
>        worker_thread+0x55/0x3c0
>        kthread+0x140/0x170
>        ret_from_fork+0x22/0x30
>
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>        process_one_work+0x266/0x5d0
>        worker_thread+0x55/0x3c0
>        kthread+0x140/0x170
>        ret_from_fork+0x22/0x30
>
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>        __lock_acquire+0x1130/0x1dc0
>        lock_acquire+0xf5/0x320
>        flush_workqueue+0xae/0x600
>        drain_workqueue+0xa0/0x110
>        destroy_workqueue+0x36/0x250
>        __loop_clr_fd+0x9a/0x650 [loop]
>        lo_ioctl+0x29d/0x780 [loop]
>        block_ioctl+0x3f/0x50
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> other info that might help us debug this:
> Chain exists of:
>   (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
>  Possible unsafe locking scenario:
>        CPU0                    CPU1
>        ----                    ----
>   lock(&lo->lo_mutex);
>                                lock(&disk->open_mutex);
>                                lock(&lo->lo_mutex);
>   lock((wq_completion)loop0);
>
>  *** DEADLOCK ***
> 1 lock held by losetup/156417:
>  #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41=
/0x650 [loop]
>
> stack backtrace:
> CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Call Trace:
>  dump_stack_lvl+0x57/0x72
>  check_noncircular+0x10a/0x120
>  __lock_acquire+0x1130/0x1dc0
>  lock_acquire+0xf5/0x320
>  ? flush_workqueue+0x84/0x600
>  flush_workqueue+0xae/0x600
>  ? flush_workqueue+0x84/0x600
>  drain_workqueue+0xa0/0x110
>  destroy_workqueue+0x36/0x250
>  __loop_clr_fd+0x9a/0x650 [loop]
>  lo_ioctl+0x29d/0x780 [loop]
>  ? __lock_acquire+0x3a0/0x1dc0
>  ? update_dl_rq_load_avg+0x152/0x360
>  ? lock_is_held_type+0xa5/0x120
>  ? find_held_lock.constprop.0+0x2b/0x80
>  block_ioctl+0x3f/0x50
>  __x64_sys_ioctl+0x83/0xb0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f645884de6b
>
> Usually the uuid_mutex exists to protect the fs_devices that map
> together all of the devices that match a specific uuid.  In rm_device
> we're messing with the uuid of a device, so it makes sense to protect
> that here.
>
> However in doing that it pulls in a whole host of lockdep dependencies,
> as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
> we end up with the dependency chain under the uuid_mutex being added
> under the normal sb write dependency chain, which causes problems with
> loop devices.
>
> We don't need the uuid mutex here however.  If we call
> btrfs_scan_one_device() before we scratch the super block we will find
> the fs_devices and not find the device itself and return EBUSY because
> the fs_devices is open.  If we call it after the scratch happens it will
> not appear to be a valid btrfs file system.
>
> We do not need to worry about other fs_devices modifying operations here
> because we're protected by the exclusive operations locking.
>
> So drop the uuid_mutex here in order to fix the lockdep splat.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5217b93172b4..0e7372f637eb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2082,8 +2082,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, =
const char *device_path,
>         u64 num_devices;
>         int ret =3D 0;
>
> -       mutex_lock(&uuid_mutex);
> -
>         num_devices =3D btrfs_num_devices(fs_info);
>
>         ret =3D btrfs_check_raid_min_devices(fs_info, num_devices - 1);
> @@ -2127,11 +2125,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,=
 const char *device_path,
>                 mutex_unlock(&fs_info->chunk_mutex);
>         }
>
> -       mutex_unlock(&uuid_mutex);
>         ret =3D btrfs_shrink_device(device, 0);
>         if (!ret)
>                 btrfs_reada_remove_dev(device);
> -       mutex_lock(&uuid_mutex);

On misc-next, this is now triggering a warning due to a lockdep
assertion failure:

[ 5343.002752] ------------[ cut here ]------------
[ 5343.002756] WARNING: CPU: 3 PID: 797246 at fs/btrfs/volumes.c:1165
close_fs_devices+0x200/0x220 [btrfs]
[ 5343.002813] Modules linked in: dm_dust btrfs dm_flakey dm_mod
blake2b_generic xor raid6_pq libcrc32c bochs drm_vram_helper
intel_rapl_msr intel_rapl_common drm_ttm_helper crct10dif_pclmul ttm
ghash_clmulni_intel aesni_intel drm_kms_helper crypto_simd ppdev
cryptd joy>
[ 5343.002876] CPU: 3 PID: 797246 Comm: btrfs Not tainted
5.15.0-rc2-btrfs-next-99 #1
[ 5343.002879] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[ 5343.002883] RIP: 0010:close_fs_devices+0x200/0x220 [btrfs]
[ 5343.002912] Code: 8b 43 78 48 85 c0 0f 85 89 fe ff ff e9 7e fe ff
ff be ff ff ff ff 48 c7 c7 10 6f bd c0 e8 58 70 7d c9 85 c0 0f 85 20
fe ff ff <0f> 0b e9 19 fe ff ff 0f 0b e9 63 ff ff ff 0f 0b e9 67 ff ff
ff 66
[ 5343.002914] RSP: 0018:ffffb32608fe7d38 EFLAGS: 00010246
[ 5343.002917] RAX: 0000000000000000 RBX: ffff948d78f6b538 RCX: 00000000000=
00001
[ 5343.002918] RDX: 0000000000000000 RSI: ffffffff8aabac29 RDI: ffffffff8ab=
2a43e
[ 5343.002920] RBP: ffff948d78f6b400 R08: ffff948d4fcecd38 R09: 00000000000=
00000
[ 5343.002921] R10: 0000000000000000 R11: 0000000000000000 R12: ffff948d4fc=
ecc78
[ 5343.002922] R13: ffff948d401bc000 R14: ffff948d78f6b400 R15: ffff948d4fc=
ecc00
[ 5343.002924] FS:  00007fe1259208c0(0000) GS:ffff94906d400000(0000)
knlGS:0000000000000000
[ 5343.002926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5343.002927] CR2: 00007fe125a953d5 CR3: 00000001017ca005 CR4: 00000000003=
70ee0
[ 5343.002930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 5343.002932] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 5343.002933] Call Trace:
[ 5343.002938]  btrfs_rm_device.cold+0x147/0x1c0 [btrfs]
[ 5343.002981]  btrfs_ioctl+0x2dc2/0x3460 [btrfs]
[ 5343.003021]  ? __do_sys_newstat+0x48/0x70
[ 5343.003028]  ? lock_is_held_type+0xe8/0x140
[ 5343.003034]  ? __x64_sys_ioctl+0x83/0xb0
[ 5343.003037]  __x64_sys_ioctl+0x83/0xb0
[ 5343.003042]  do_syscall_64+0x3b/0xc0
[ 5343.003045]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5343.003048] RIP: 0033:0x7fe125a17d87
[ 5343.003051] Code: 00 00 00 48 8b 05 09 91 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d9 90 0c 00 f7 d8 64 89
01 48
[ 5343.003053] RSP: 002b:00007ffdbfbd11c8 EFLAGS: 00000206 ORIG_RAX:
0000000000000010
[ 5343.003056] RAX: ffffffffffffffda RBX: 00007ffdbfbd33b0 RCX: 00007fe125a=
17d87
[ 5343.003057] RDX: 00007ffdbfbd21e0 RSI: 000000005000943a RDI: 00000000000=
00003
[ 5343.003059] RBP: 0000000000000000 R08: 0000000000000000 R09: 006264732f7=
66564
[ 5343.003060] R10: fffffffffffffebb R11: 0000000000000206 R12: 00000000000=
00003
[ 5343.003061] R13: 00007ffdbfbd33b0 R14: 0000000000000000 R15: 00007ffdbfb=
d33b8
[ 5343.003077] irq event stamp: 202039
[ 5343.003079] hardirqs last  enabled at (202045):
[<ffffffff8992d2a0>] __up_console_sem+0x60/0x70
[ 5343.003082] hardirqs last disabled at (202050):
[<ffffffff8992d285>] __up_console_sem+0x45/0x70
[ 5343.003083] softirqs last  enabled at (196012):
[<ffffffff898a0f2b>] irq_exit_rcu+0xeb/0x130
[ 5343.003086] softirqs last disabled at (195973):
[<ffffffff898a0f2b>] irq_exit_rcu+0xeb/0x130
[ 5343.003090] ---[ end trace 7b957e10a906f920 ]---

Happens all the time on btrfs/164 for example.
Maybe some other patch is missing?


>         if (ret)
>                 goto error_undo;
>
> @@ -2215,7 +2211,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, =
const char *device_path,
>         }
>
>  out:
> -       mutex_unlock(&uuid_mutex);
>         return ret;
>
>  error_undo:
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
