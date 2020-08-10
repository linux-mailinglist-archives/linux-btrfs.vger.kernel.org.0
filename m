Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21E240B55
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgHJQpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHJQpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 12:45:53 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C69C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 09:45:53 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id x17so2651529uao.5
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/m3GpnJubHCLDpmFs/xVKUVao5d5An1VMKlU/HbRgi8=;
        b=XbWocbmABLGLKxhf92ztUMs4htJZINzCVcDTxYoPNOYNnOHSYBm8kOtb/g8tVgY0HZ
         nSm0h0TREFhL09dmNVwtCrkTaITip9Na8l+xz4TGqkdsQcn1nCm5VEP67h3n7/eV+M4g
         zKq7WIxjXlEB8XSz9lw6Hdhoj9kvFnCDCngaLSQi33wcTBMm6bczp+Bvl+QZI6zEMnPi
         SrnVDRyt1wVQIlr+0a6VhKNurl+4/v6/WKphSJEglYTGf347lQY4AMnSDO4p+yoHmPEI
         jPtWRDt4xxIDg1rU/Hymt847Mx9j9Mb5NUWMx6cGgk/2X2I0kkOIgdJU/a6wWnjg7ZTt
         uwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/m3GpnJubHCLDpmFs/xVKUVao5d5An1VMKlU/HbRgi8=;
        b=Rge6hLpk+VOqx1jhi+8oSo/yoe4fH6lRBzzco9YfbClWfxbVM6mabxvlGFT8Jasv30
         8ox5pnHPGObC1o1QjRWnbBHaElPWvU4yW+igKI75DTdq5rU9T1+Ty4oMk0s3/3OuH+hR
         nxSBy3aIaJmwAdGWjBHGNsBSMrVOVRndFuS5LNa4R57trdbfAPvZy89cln1L996qqUDq
         QuafL/WjPCDw3bxs7a+bAxDmOKvuUpUjJHNVTnTM7obOYOXPdpeLT5nB0xjUYAMWk6CZ
         eYAoIB+1yvk3tJvNXLEeUdw/g0lVfBGjkDAcNEoiTWKCWE6Qq460aC2VIws+ZLaBWFlX
         eujQ==
X-Gm-Message-State: AOAM533V9hOMBKGlR4lhJr5sMzBP+SFuKrrLCyXZMEfB+5SwXN7YW6Fz
        itnCDdwhUnmcnpDIKX2ZaiYv9zp1b0I0/KpGqso=
X-Google-Smtp-Source: ABdhPJzwIMV29Dz9yWwqHQOsKUxcAyyIR8c6LDqQRv9aiXJf7vtV1f2YRDYmW2Aq2b4vhia6s3DJH/97cg4/p2qi2SM=
X-Received: by 2002:a9f:368c:: with SMTP id p12mr18326623uap.135.1597077951294;
 Mon, 10 Aug 2020 09:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200810154242.782802-1-josef@toxicpanda.com> <20200810154242.782802-3-josef@toxicpanda.com>
In-Reply-To: <20200810154242.782802-3-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 10 Aug 2020 17:45:40 +0100
Message-ID: <CAL3q7H5kE6-uSfcimwhr2AH+CS5eghPBNTgvz5gqaByBxN_wcw@mail.gmail.com>
Subject: Re: [PATCH 02/17] btrfs: fix potential deadlock in the search ioctl
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 4:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> When I converted the locking over to using a rwsem I got the following
> lockdep splat
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.8.0-rc7-00165-g04ec4da5f45f-dirty #922 Not tainted
> ------------------------------------------------------
> compsize/11122 is trying to acquire lock:
> ffff889fabca8768 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x3e/0=
x90
>
> but task is already holding lock:
> ffff889fe720fe40 (btrfs-fs-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x=
39/0x180
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (btrfs-fs-00){++++}-{3:3}:
>        down_write_nested+0x3b/0x70
>        __btrfs_tree_lock+0x24/0x120
>        btrfs_search_slot+0x756/0x990
>        btrfs_lookup_inode+0x3a/0xb4
>        __btrfs_update_delayed_inode+0x93/0x270
>        btrfs_async_run_delayed_root+0x168/0x230
>        btrfs_work_helper+0xd4/0x570
>        process_one_work+0x2ad/0x5f0
>        worker_thread+0x3a/0x3d0
>        kthread+0x133/0x150
>        ret_from_fork+0x1f/0x30
>
> -> #1 (&delayed_node->mutex){+.+.}-{3:3}:
>        __mutex_lock+0x9f/0x930
>        btrfs_delayed_update_inode+0x50/0x440
>        btrfs_update_inode+0x8a/0xf0
>        btrfs_dirty_inode+0x5b/0xd0
>        touch_atime+0xa1/0xd0
>        btrfs_file_mmap+0x3f/0x60
>        mmap_region+0x3a4/0x640
>        do_mmap+0x376/0x580
>        vm_mmap_pgoff+0xd5/0x120
>        ksys_mmap_pgoff+0x193/0x230
>        do_syscall_64+0x50/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
>        __lock_acquire+0x1272/0x2310
>        lock_acquire+0x9e/0x360
>        __might_fault+0x68/0x90
>        _copy_to_user+0x1e/0x80
>        copy_to_sk.isra.32+0x121/0x300
>        search_ioctl+0x106/0x200
>        btrfs_ioctl_tree_search_v2+0x7b/0xf0
>        btrfs_ioctl+0x106f/0x30a0
>        ksys_ioctl+0x83/0xc0
>        __x64_sys_ioctl+0x16/0x20
>        do_syscall_64+0x50/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> other info that might help us debug this:
>
> Chain exists of:
>   &mm->mmap_lock#2 --> &delayed_node->mutex --> btrfs-fs-00
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-fs-00);
>                                lock(&delayed_node->mutex);
>                                lock(btrfs-fs-00);
>   lock(&mm->mmap_lock#2);
>
>  *** DEADLOCK ***
>
> 1 lock held by compsize/11122:
>  #0: ffff889fe720fe40 (btrfs-fs-00){++++}-{3:3}, at: __btrfs_tree_read_lo=
ck+0x39/0x180
>
> stack backtrace:
> CPU: 17 PID: 11122 Comm: compsize Kdump: loaded Not tainted 5.8.0-rc7-001=
65-g04ec4da5f45f-dirty #922
> Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass Sin=
gle Side, BIOS F08_3A18 12/20/2018
> Call Trace:
>  dump_stack+0x78/0xa0
>  check_noncircular+0x165/0x180
>  __lock_acquire+0x1272/0x2310
>  lock_acquire+0x9e/0x360
>  ? __might_fault+0x3e/0x90
>  ? find_held_lock+0x72/0x90
>  __might_fault+0x68/0x90
>  ? __might_fault+0x3e/0x90
>  _copy_to_user+0x1e/0x80
>  copy_to_sk.isra.32+0x121/0x300
>  ? btrfs_search_forward+0x2a6/0x360
>  search_ioctl+0x106/0x200
>  btrfs_ioctl_tree_search_v2+0x7b/0xf0
>  btrfs_ioctl+0x106f/0x30a0
>  ? __do_sys_newfstat+0x5a/0x70
>  ? ksys_ioctl+0x83/0xc0
>  ksys_ioctl+0x83/0xc0
>  __x64_sys_ioctl+0x16/0x20
>  do_syscall_64+0x50/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> The problem is we're doing a copy_to_user() while holding tree locks,
> which can deadlock if we have to do a page fault for the copy_to_user().
> This exists even without my locking changes, so it needs to be fixed.
> Rework the search ioctl to do the pre-fault and then
> copy_to_user_nofault for the copying.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c |  8 ++++----
>  fs/btrfs/extent_io.h |  6 +++---
>  fs/btrfs/ioctl.c     | 27 ++++++++++++++++++++-------
>  3 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 617ea38e6fd7..c15ab6c1897f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5653,9 +5653,9 @@ void read_extent_buffer(const struct extent_buffer =
*eb, void *dstv,
>         }
>  }
>
> -int read_extent_buffer_to_user(const struct extent_buffer *eb,
> -                              void __user *dstv,
> -                              unsigned long start, unsigned long len)
> +int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
> +                                      void __user *dstv,
> +                                      unsigned long start, unsigned long=
 len)
>  {
>         size_t cur;
>         size_t offset;
> @@ -5675,7 +5675,7 @@ int read_extent_buffer_to_user(const struct extent_=
buffer *eb,
>
>                 cur =3D min(len, (PAGE_SIZE - offset));
>                 kaddr =3D page_address(page);
> -               if (copy_to_user(dst, kaddr + offset, cur)) {
> +               if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
>                         ret =3D -EFAULT;
>                         break;
>                 }
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 00a88f2eb5ab..30794ae58498 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -241,9 +241,9 @@ int memcmp_extent_buffer(const struct extent_buffer *=
eb, const void *ptrv,
>  void read_extent_buffer(const struct extent_buffer *eb, void *dst,
>                         unsigned long start,
>                         unsigned long len);
> -int read_extent_buffer_to_user(const struct extent_buffer *eb,
> -                              void __user *dst, unsigned long start,
> -                              unsigned long len);
> +int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
> +                                      void __user *dst, unsigned long st=
art,
> +                                      unsigned long len);
>  void write_extent_buffer_fsid(const struct extent_buffer *eb, const void=
 *src);
>  void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
>                 const void *src);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index bd3511c5ca81..39448556f635 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2086,9 +2086,14 @@ static noinline int copy_to_sk(struct btrfs_path *=
path,
>                 sh.len =3D item_len;
>                 sh.transid =3D found_transid;
>
> -               /* copy search result header */
> -               if (copy_to_user(ubuf + *sk_offset, &sh, sizeof(sh))) {
> -                       ret =3D -EFAULT;
> +               /*
> +                * copy search result header, if we fault loop again so w=
e can
> +                * fault in the pages and -EFAULT there if there's a prob=
lem,
> +                * otherwise we'll fault and then copy the buffer in prop=
erly
> +                * this next time through
> +                */
> +               if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(s=
h))) {
> +                       ret =3D 0;
>                         goto out;
>                 }
>
> @@ -2096,10 +2101,14 @@ static noinline int copy_to_sk(struct btrfs_path =
*path,
>
>                 if (item_len) {
>                         char __user *up =3D ubuf + *sk_offset;
> -                       /* copy the item */
> -                       if (read_extent_buffer_to_user(leaf, up,
> -                                                      item_off, item_len=
)) {
> -                               ret =3D -EFAULT;
> +                       /* copy the item, same behavior as above, but res=
et the
> +                        * sk_offset so we copy the full thing again.
> +                       */
> +                       if (read_extent_buffer_to_user_nofault(leaf, up,
> +                                                              item_off,
> +                                                              item_len))=
 {
> +                               ret =3D 0;
> +                               *sk_offset -=3D sizeof(sh);
>                                 goto out;
>                         }
>
> @@ -2184,6 +2193,10 @@ static noinline int search_ioctl(struct inode *ino=
de,
>         key.offset =3D sk->min_offset;
>
>         while (1) {
> +               ret =3D fault_in_pages_writeable(ubuf, *buf_size - sk_off=
set);
> +               if (ret)
> +                       break;
> +
>                 ret =3D btrfs_search_forward(root, &key, path, sk->min_tr=
ansid);
>                 if (ret !=3D 0) {
>                         if (ret > 0)
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
