Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E177E316365
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 11:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBJKMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 05:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhBJKKC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 05:10:02 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A864C06178C;
        Wed, 10 Feb 2021 02:09:22 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t63so1098409qkc.1;
        Wed, 10 Feb 2021 02:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=439nouC6+LIwVa5ziQQ6pS/1Ng+K5FgDPJVVQEDsYOU=;
        b=oNKlosqtIIRr7vrl+u8UUD/1P0MKvMTu1yAdZyRLBHltZk9HXxUIv2DZSobn56WkWN
         qnnA5yb0AF0gN70woOEAcavfI8Mc9pTU5m9hPntRWzFGtjO7gXklA4FvTVzFcv/1KO2o
         pyyDZKibVF94VAG2nYDSPGI81marQwM8njFSHbD83Lph25hgajkzw1C8mOMCegV9raGF
         Tl/8MVgpxIlrQwH8rRHogqwyFqRbTPRexuIbGiCzpTI2Qm6h6rvIl8kqF5x0afRNB8eU
         ifhoeLVJqkKw0h7xWS5NrrjWkz/Gozb7gKwvvZh5+WpDOP1OCjKFMr0Ustpp90axI8b/
         /qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=439nouC6+LIwVa5ziQQ6pS/1Ng+K5FgDPJVVQEDsYOU=;
        b=c1P1Y2BnVkvyIurA23Ste9f8YPO0jZPqXZteXQ1fYFpVHl/wctMWo669AFbE2MNpJI
         +gc5xbeFGQy4A1fXvHCfHFrbdvaFZ4OtpVGBHXwaB30ZayL6/DzN9By6cxkD1sk3XnIc
         MtGNWhnl9njeykVP/zS3OeXbNnGl8ozOr0wpMiSh4UO5Kwz2wRVak4EkxjYBKKVJ5HIH
         RalnEFostMCMmUJzKwjeWCDjpNVW/XOHS0Ky+dx7vNXIb+X3FGZcGyMeCmNerxZUh5B8
         9Bx8lc9t3vaJiDOdYh9RLj85Z9fy2BFn+Y2u0SKwHGw3nNOMFszjBjslnBb+yEpG+Wse
         Vscg==
X-Gm-Message-State: AOAM533NV79WaIxXwCFVJp5oLa55F04USORKdbW/4SxwIZ/an710u33k
        ydcpH4kEOsStENkGDexrVkpObuEwaR0JXtOZF3o=
X-Google-Smtp-Source: ABdhPJx3nKdURXZ+mHwtOkKrJ1uPZ+5hdZjVIOP6/zrn14iDE/ghYO81Kg+xZLLN4ysbzcfsyDr2/fPckscXeUtHXJc=
X-Received: by 2002:ae9:ef8d:: with SMTP id d135mr2592352qkg.0.1612951761186;
 Wed, 10 Feb 2021 02:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20210209203041.21493-1-mrostecki@suse.de> <20210209203041.21493-5-mrostecki@suse.de>
In-Reply-To: <20210209203041.21493-5-mrostecki@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 10 Feb 2021 10:09:10 +0000
Message-ID: <CAL3q7H7Y6Mh9L4niCHzUVOfo4_PDK9o6Ho_aZfxENOQsiWwk9g@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] btrfs: Check if the filesystem is has mixed type
 of devices
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 9, 2021 at 9:32 PM Michal Rostecki <mrostecki@suse.de> wrote:
>
> From: Michal Rostecki <mrostecki@suse.com>
>
> Add the btrfs_check_mixed() function which checks if the filesystem has
> the mixed type of devices (non-rotational and rotational). This
> information is going to be used in roundrobin raid1 read policy.
>
> Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> ---
>  fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/volumes.h |  7 +++++++
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1ac364a2f105..1ad30a595722 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -617,6 +617,35 @@ static int btrfs_free_stale_devices(const char *path=
,
>         return ret;
>  }
>
> +/*
> + * Checks if after adding the new device the filesystem is going to have=
 mixed
> + * types of devices (non-rotational and rotational).
> + *
> + * @fs_devices:          list of devices
> + * @new_device_rotating: if the new device is rotational
> + *
> + * Returns true if there are mixed types of devices, otherwise returns f=
alse.
> + */
> +static bool btrfs_check_mixed(struct btrfs_fs_devices *fs_devices,
> +                             bool new_device_rotating)
> +{
> +       struct btrfs_device *device, *prev_device;
> +
> +       list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +               if (prev_device =3D=3D NULL &&

Hum, prev_device is not initialized when we enter the first iteration
of the loop.

> +                   device->rotating !=3D new_device_rotating)
> +                       return true;
> +               if (prev_device !=3D NULL &&
> +                   (device->rotating !=3D prev_device->rotating ||

Here it's more dangerous, dereferencing an uninitialized pointer can
result in a crash.

With this fixed, it would be better to redo the benchmarks when using
mixed device types.

Thanks.

> +                    device->rotating !=3D new_device_rotating))
> +                       return true;
> +
> +               prev_device =3D device;
> +       }
> +
> +       return false;
> +}
> +
>  /*
>   * This is only used on mount, and we are protected from competing thing=
s
>   * messing with our fs_devices by the uuid_mutex, thus we do not need th=
e
> @@ -629,6 +658,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devi=
ces *fs_devices,
>         struct request_queue *q;
>         struct block_device *bdev;
>         struct btrfs_super_block *disk_super;
> +       bool rotating;
>         u64 devid;
>         int ret;
>
> @@ -669,8 +699,12 @@ static int btrfs_open_one_device(struct btrfs_fs_dev=
ices *fs_devices,
>         }
>
>         q =3D bdev_get_queue(bdev);
> -       if (!blk_queue_nonrot(q))
> +       rotating =3D !blk_queue_nonrot(q);
> +       device->rotating =3D rotating;
> +       if (rotating)
>                 fs_devices->rotating =3D true;
> +       if (!fs_devices->mixed)
> +               fs_devices->mixed =3D btrfs_check_mixed(fs_devices, rotat=
ing);
>
>         device->bdev =3D bdev;
>         clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
> @@ -2418,6 +2452,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_inf=
o *fs_info)
>         fs_devices->open_devices =3D 0;
>         fs_devices->missing_devices =3D 0;
>         fs_devices->rotating =3D false;
> +       fs_devices->mixed =3D false;
>         list_add(&seed_devices->seed_list, &fs_devices->seed_list);
>
>         generate_random_uuid(fs_devices->fsid);
> @@ -2522,6 +2557,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_=
info, const char *device_path
>         int seeding_dev =3D 0;
>         int ret =3D 0;
>         bool locked =3D false;
> +       bool rotating;
>
>         if (sb_rdonly(sb) && !fs_devices->seeding)
>                 return -EROFS;
> @@ -2621,8 +2657,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path
>
>         atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>
> -       if (!blk_queue_nonrot(q))
> +       rotating =3D !blk_queue_nonrot(q);
> +       device->rotating =3D rotating;
> +       if (rotating)
>                 fs_devices->rotating =3D true;
> +       if (!fs_devices->mixed)
> +               fs_devices->mixed =3D btrfs_check_mixed(fs_devices, rotat=
ing);
>
>         orig_super_total_bytes =3D btrfs_super_total_bytes(fs_info->super=
_copy);
>         btrfs_set_super_total_bytes(fs_info->super_copy,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6e544317a377..594f1207281c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -147,6 +147,9 @@ struct btrfs_device {
>         /* I/O stats for raid1 mirror selection */
>         struct percpu_counter inflight;
>         atomic_t last_offset;
> +
> +       /* If the device is rotational */
> +       bool rotating;
>  };
>
>  /*
> @@ -274,6 +277,10 @@ struct btrfs_fs_devices {
>          * nonrot flag set
>          */
>         bool rotating;
> +       /* Set when we find or add both nonrot and rot disks in the
> +        * filesystem
> +        */
> +       bool mixed;
>
>         struct btrfs_fs_info *fs_info;
>         /* sysfs kobjects */
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
