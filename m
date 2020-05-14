Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180721D30DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgENNQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgENNQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 09:16:59 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EDFC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 06:16:58 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v23so735845vke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JHmSvOfqI9zv1aLO7Ij5kREGyIzSMH6xuRmSF/8a1cU=;
        b=eZIUyzBX23piR2p8DwUHv6+T+PL8FQjVzSYWdDsnbXRLHIrcANkmtwTYE2KMdO9U3G
         n0KqrodIFf0X6Grfhh3XFG7dgkUFFnQ0eMEViFd29xwarzQ2iRZ8HencqWeMoGOQAHFl
         H7IFELgzWtWzef71IAfbp+cq/mnY1hu1GWfuIGJGyrcpw8NTeto/xBHgQq3Zad6TH+DA
         7XXwMou/1ytdE8uFSnYGeZnYK9D9Dry47/m4p3OFlOfm+GA9fcSGpeobrHFK6L6zx6N6
         J9ryJJzwSDqeRD+qAM9JpiE7sn/jgQ3GsvEFfLuEACbO6+aKID9GWSjOPENHVJwnWWPU
         Pbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JHmSvOfqI9zv1aLO7Ij5kREGyIzSMH6xuRmSF/8a1cU=;
        b=POsYJgh3hi+1Fg10Js3jEnqDGHthqcm2ZEKU54aDYBiLGaN+fTnXWl7TbQ8+bgwoBi
         YteF5r6laMqQ/nMgtH/3AsV3N0lPtCPcJLp2l3nIxu/Ir7PoMI/HwhMo8W/81FPUJn3A
         VAXMzkWRKUxFgFT/S6GeB5TtX5XOZX+txbV/Nn4CAlqxXJ+F9TKwwH3tvYFLoKCcHOHH
         UwkACTuPRQibGOppRZ+z8zXm1NFi4A2GWz1zEaNd2K6uAOh9Rwy4x3RS4dZWst/y1VOX
         bomwH/9FUrN6v+USaE9x94K2DWhctdlU9qjUE3PAt5LY1Cvd30DZGsPT76jurri5fGwR
         PdbA==
X-Gm-Message-State: AOAM533GYw6BfDz7tSO2uiaeaygmX2V2TbVjJfHBwKE8fp6T1gYx0p7o
        Dwpw3eNGHJXKnKF94n6MDj7xdLVt4tbAk4ZlO7q0EA==
X-Google-Smtp-Source: ABdhPJweeiY/Hez6hVl/LfDzeNSmO/Kc75/kJ380spYGsWvf8NjuhaDjsLMe1pii0RQz1M0x1Rr85yE5vAJxwrGQW6w=
X-Received: by 2002:a1f:94d7:: with SMTP id w206mr3445591vkd.24.1589462217880;
 Thu, 14 May 2020 06:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200514091918.30294-1-robbieko@synology.com>
In-Reply-To: <20200514091918.30294-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 14 May 2020 14:16:46 +0100
Message-ID: <CAL3q7H7xg=vjSGgtV8BYL5aWqnvi+CwPqnJ3kiVQgQm=X7Pk5Q@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: reduce lock contention when create snapshot
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 14, 2020 at 10:20 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When creating a snapshot, it takes a long time because
> flush dirty data is required.
>
> But we have taken two resources as shown below:
> 1. Destination directory inode lock
> 2. Global subvol semaphore
>
> This will cause subvol destroy/create/setflag blocked,
> until the snapshot is created.
>
> We fix by flush dirty data first to reduce the time of
> the critical section, and then lock the relevant resources.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ioctl.c | 70 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 40b729dce91c..d0c1598dc51e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -748,7 +748,6 @@ static int create_snapshot(struct btrfs_root *root, s=
truct inode *dir,
>         struct btrfs_pending_snapshot *pending_snapshot;
>         struct btrfs_trans_handle *trans;
>         int ret;
> -       bool snapshot_force_cow =3D false;
>
>         if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>                 return -EINVAL;
> @@ -771,27 +770,6 @@ static int create_snapshot(struct btrfs_root *root, =
struct inode *dir,
>                 goto free_pending;
>         }
>
> -       /*
> -        * Force new buffered writes to reserve space even when NOCOW is
> -        * possible. This is to avoid later writeback (running dealloc) t=
o
> -        * fallback to COW mode and unexpectedly fail with ENOSPC.
> -        */
> -       btrfs_drew_read_lock(&root->snapshot_lock);
> -
> -       ret =3D btrfs_start_delalloc_snapshot(root);
> -       if (ret)
> -               goto dec_and_free;
> -
> -       /*
> -        * All previous writes have started writeback in NOCOW mode, so n=
ow
> -        * we force future writes to fallback to COW mode during snapshot
> -        * creation.
> -        */
> -       atomic_inc(&root->snapshot_force_cow);
> -       snapshot_force_cow =3D true;
> -
> -       btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
> -
>         btrfs_init_block_rsv(&pending_snapshot->block_rsv,
>                              BTRFS_BLOCK_RSV_TEMP);
>         /*
> @@ -806,7 +784,7 @@ static int create_snapshot(struct btrfs_root *root, s=
truct inode *dir,
>                                         &pending_snapshot->block_rsv, 8,
>                                         false);
>         if (ret)
> -               goto dec_and_free;
> +               goto free_pending;
>
>         pending_snapshot->dentry =3D dentry;
>         pending_snapshot->root =3D root;
> @@ -848,11 +826,6 @@ static int create_snapshot(struct btrfs_root *root, =
struct inode *dir,
>  fail:
>         btrfs_put_root(pending_snapshot->snap);
>         btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->bloc=
k_rsv);
> -dec_and_free:
> -       if (snapshot_force_cow)
> -               atomic_dec(&root->snapshot_force_cow);
> -       btrfs_drew_read_unlock(&root->snapshot_lock);
> -
>  free_pending:
>         kfree(pending_snapshot->root_item);
>         btrfs_free_path(pending_snapshot->path);
> @@ -983,6 +956,45 @@ static noinline int btrfs_mksubvol(const struct path=
 *parent,
>         return error;
>  }
>
> +static noinline int btrfs_mksnapshot(const struct path *parent,
> +                                  const char *name, int namelen,
> +                                  struct btrfs_root *root,
> +                                  bool readonly,
> +                                  struct btrfs_qgroup_inherit *inherit)
> +{
> +       int ret;
> +       bool snapshot_force_cow =3D false;
> +
> +       /*
> +        * Force new buffered writes to reserve space even when NOCOW is
> +        * possible. This is to avoid later writeback (running dealloc) t=
o
> +        * fallback to COW mode and unexpectedly fail with ENOSPC.
> +        */
> +       btrfs_drew_read_lock(&root->snapshot_lock);
> +
> +       ret =3D btrfs_start_delalloc_snapshot(root);
> +       if (ret)
> +               goto out;
> +
> +       /*
> +        * All previous writes have started writeback in NOCOW mode, so n=
ow
> +        * we force future writes to fallback to COW mode during snapshot
> +        * creation.
> +        */
> +       atomic_inc(&root->snapshot_force_cow);
> +       snapshot_force_cow =3D true;
> +
> +       btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
> +
> +       ret =3D btrfs_mksubvol(parent, name, namelen,
> +                            root, readonly, inherit);
> +out:
> +       if (snapshot_force_cow)
> +               atomic_dec(&root->snapshot_force_cow);
> +       btrfs_drew_read_unlock(&root->snapshot_lock);
> +       return ret;
> +}
> +
>  /*
>   * When we're defragging a range, we don't want to kick it off again
>   * if it is really just waiting for delalloc to send it down.
> @@ -1762,7 +1774,7 @@ static noinline int __btrfs_ioctl_snap_create(struc=
t file *file,
>                          */
>                         ret =3D -EPERM;
>                 } else {
> -                       ret =3D btrfs_mksubvol(&file->f_path, name, namel=
en,
> +                       ret =3D btrfs_mksnapshot(&file->f_path, name, nam=
elen,
>                                              BTRFS_I(src_inode)->root,
>                                              readonly, inherit);
>                 }
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
