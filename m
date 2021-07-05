Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89E93BB980
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhGEIqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhGEIqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 04:46:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDADC061574
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 01:43:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q190so16326938qkd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GEWUPRzxZWsf7wVaaJ7QnKHGZvRc8J3zK23E6oqH4OY=;
        b=JEDE0bEiDH4fX664HXGFUD9EsGq00gwRnMiysDoPp8CfLuTftJkf5pWGgtqkaJyYuj
         hEsVLnhhmwWI9mvboS8a69y9y5Uwjvnyvrt+KtSAM6cO8v2IrZV6Vmbuqjwg0x4B2QHC
         Nb5yQcHvEAYzgxLGMAq6SzjgtCjH7srd2r7ggmIdQbFfREFqqCaJlDFARsG6+10Is1Ht
         wtvQI4YJu7PfoiAEC3efqrkRAkRzQi3uN0OnGFbeamYdROy8kOW0QsOJLsZrcH88IdXB
         MN+epjKS3BQnC61BQuVLBEF4OotxZex67uX1OMy9YRHCMONq8j7fn4a7UTzeCJMXmZQv
         2waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GEWUPRzxZWsf7wVaaJ7QnKHGZvRc8J3zK23E6oqH4OY=;
        b=nBFcLKiyrlVKy+ZKUq8B9B77gbkJbzSaSvnexKVe0+RBycCQHJuvaVT8MTbUwgyucr
         S/eCXgXR8Xsyao8R28TtSheOpGmZ91xx6npCbdMlH2ixPd8/Qp+M1+EkCDhjhGgzN9F5
         GUO4Rgz1sIBqwaOaR4t2ZbrVmWv7i8Hi4QgqYO3fFU5lbBB7zDxD96OYNiu0s9sn+9eB
         gU/c65hDX4r4loKpk5g4MoI5mTQQfkYgdePZ70mzP41A/6+kb9TF3PerlqkusvVPq/Ej
         9IlxzwEcd8aP3BdZJmJxcCcao9ASBHvi3yXYxv5miUGplHCr7fLhBAhH20CnDTzDUddi
         3xXQ==
X-Gm-Message-State: AOAM530KTQJHh7Jp6usab1d6PS4lqM9236l7oagc9cmnvOuznfELk9/r
        P8ouXfY3bAiiypE7QNZYTP/DULFNfbNNvzyb9iQ=
X-Google-Smtp-Source: ABdhPJyxkDq2Q9/qSZeBQlzzx7U/Ihv3AXf4feBY52fcHFt9EG1fionjWkYzN9bLDHz6BNiTC4bZIs3JwyIV5O5maeU=
X-Received: by 2002:a37:b544:: with SMTP id e65mr12520375qkf.338.1625474604333;
 Mon, 05 Jul 2021 01:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
In-Reply-To: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 09:43:13 +0100
Message-ID: <CAL3q7H6yweidJi85pdb-D=iOYTEqoDuRs8wvC3q9W1ng__ewkA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check for missing device in btrfs_trim_fs
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 4, 2021 at 12:17 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> A fstrim on a degraded raid1 can trigger the following null pointer
> dereference:
>
> BTRFS info (device loop0): allowing degraded mounts
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): has skinny extents
> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b=
424adb is missing
> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b=
424adb is missing
> BTRFS info (device loop0): enabling ssd optimizations
> BUG: kernel NULL pointer dereference, address: 0000000000000620
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/=
2006
> RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
> Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48 8b 4=
5 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48> 8b 80 20 06=
 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
> RSP: 0018:ffff959541797d28 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
> RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
> RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
> R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
> FS:  00007f55917a5080(0000) GS:ffff946f9bc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000620 CR3: 000000002d2c8001 CR4: 00000000000706f0
> Call Trace:
> btrfs_ioctl_fitrim+0x167/0x260 [btrfs]
> btrfs_ioctl+0x1c00/0x2fe0 [btrfs]
> ? selinux_file_ioctl+0x140/0x240
> ? syscall_trace_enter.constprop.0+0x188/0x240
> ? __x64_sys_ioctl+0x83/0xb0
> __x64_sys_ioctl+0x83/0xb0
> do_syscall_64+0x40/0x80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reproducer:
>
>   Create raid1 btrfs:
>         mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/loop1
>         mount /dev/loop0 /btrfs
>
>   Create some data:
>         _sysbench prepare /btrfs 10 2g 6

This step isn't needed, it's confusing to suggest the filesystem needs
to have some data in order to trigger the bug.

>
>   Mount with one the device missing:
>         umount /btrfs
>         btrfs dev scan --forget
>         mount -o degraded /dev/loop0 /btrfs
>
>   Run fstrim:
>         fstrim /btrfs
>
> The reason is we call btrfs_trim_free_extents() for the missing device,
> which uses device->bdev (NULL for missing device) to find if the device
> supports discard.
>
> Fix is to check if the device is missing before calling
> btrfs_trim_free_extents().
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Other than that, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/extent-tree.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d296483d148f..268ce58d4569 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6019,6 +6019,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, st=
ruct fstrim_range *range)
>         mutex_lock(&fs_info->fs_devices->device_list_mutex);
>         devices =3D &fs_info->fs_devices->devices;
>         list_for_each_entry(device, devices, dev_list) {
> +               if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)=
)
> +                       continue;
> +
>                 ret =3D btrfs_trim_free_extents(device, &group_trimmed);
>                 if (ret) {
>                         dev_failed++;
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
