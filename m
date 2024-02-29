Return-Path: <linux-btrfs+bounces-2939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1D86D284
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9168E1C21209
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D517E580;
	Thu, 29 Feb 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrifo9iW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171906CBF2
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232328; cv=none; b=euYbWqV7Br3/+1F/GqeXkeodPI5+mQjM7o3GMDWL/yJrAopPaWx2B6bhe7Frq8x4x7dCfqJLJPX6mQmLLkDRj2Xw36GqE/Z9cszbcYJr9o/ZT1zfE2KFcVBUxf0XQEkunnBOdHWWcthhsFAoJL88GGFSmqkMIU4jmS/Ke7S9j/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232328; c=relaxed/simple;
	bh=IawmnpBjG7BwporsgL6QCBxRpzi/FPmebkhXrDlvGqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXnHR8l58kzRCdFibZmiGMd1Kduh3lmYoeTxMQN90O52edtdAsw9MskNS5Vpcw28B94JBBQttuRlNzMCQl5WGz7f+SbGrI+PD6RvIaIS/xaMX2goWy6N7M3jbBoE+VuZsddV7R3ZL6vOG3GjTaOhm0JaxtKHqoGgQ4UIgtG7agI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrifo9iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9F8C433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709232327;
	bh=IawmnpBjG7BwporsgL6QCBxRpzi/FPmebkhXrDlvGqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zrifo9iWkoftRRUl1xvHeoBY7MxJHspled+VfO0TIDVEpPJIqWIjzkxmb7b/L8TL3
	 tvmYrR/uy4A15bXun22qyXUzPfDb1xNy+xP4usRCeHQjui7HdwI2+5Yuz4gsW3sJCH
	 tJrM94x+qjVU5JqF1uDW19quk9qyr5SdFNlTS7ReeYLR5Z3elF737K+6EFwuibZuEG
	 3NNqK8LeH44BEMn82opdFp8itI1A7gTSi10eMtgaYpeXCH4QPYg4zOx/tNbe3f01HV
	 h6gF4CqbE4M7rzXwaNrtV6itWJssOvKywtHE42jAXgI7y8daOHmXMSIGyLkIYQvp6q
	 RVduk4lTXE72w==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so1797860a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 10:45:27 -0800 (PST)
X-Gm-Message-State: AOJu0Ywa3t0G8YsvCPp/7BkuB7YeWQ+zMxAbt0UdYfWCd8YhYYGTh/bB
	8h0xlp2QJ5Oln80kkkeEHW698S0YLrVXlU3WFEephbGd3uWeNeJwZDVj4DcrShTasEgcP0xAbC8
	dIEVjhc7ooxvV+8oprrzeBD0jOmk=
X-Google-Smtp-Source: AGHT+IEL1/VQMPc15pw317M5Y4PnVFa6vqd3ita2uvdKbV9LWsbxdjoR8+xHTAP6/OV6JRti0S4498oC0L2kTCM7Yyw=
X-Received: by 2002:a17:906:2488:b0:a43:b472:9a57 with SMTP id
 e8-20020a170906248800b00a43b4729a57mr2005707ejb.62.1709232325946; Thu, 29 Feb
 2024 10:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <659b811232f9c647e8a2250f6d4acd6a12751b6c.1709231726.git.boris@bur.io>
In-Reply-To: <659b811232f9c647e8a2250f6d4acd6a12751b6c.1709231726.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 18:44:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4hMjpa5NJ=57RHBtX=Z_6MM5AMY4gD8Z_vSwqzq6qqyw@mail.gmail.com>
Message-ID: <CAL3q7H4hMjpa5NJ=57RHBtX=Z_6MM5AMY4gD8Z_vSwqzq6qqyw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: support device name lookup in forget
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:35=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfs forget assumes the device still exists in the block layer and
> that we can lookup its dev_t. For handling some tricky cases with
> changing devt across device recreation, we need udev rules that run on
> device removal. However, at that point, there is no node to lookup, so
> we need to rely on the cached name. Refactor the forget code to handle
> this case, while still preferring to use dev_t when possible.
>
> Tested by a new fstest btrfs/303 which uses parted to trigger a

Haven't read the code, but this is confusing.

What is test btrfs/303?
Currently it doesn't exist upstream in the for-next branch or any other.

There were two tests recently submitted upstream with a number of
btrfs/303, one for send and another for qgroups.
None of them is what you are referring to.

Even if it's in some branch of the fstests forked repo
(https://github.com/kdave/xfstests), mentioning that and the branch
name is still confusing.
Because that is periodically rebased on the upstream repo, and
therefore the number 303 could change to something else sooner or
later.

My suggestion, paste here the test code in the change log as a simple
bash script, like I usually do in my change logs.
That eliminates any confusion, and it also makes it a lot simpler to
run the test, just copy paste it to a file, make it executable and
voil=C3=A1.

Thanks.

> partition to take on different devts between remounts. That test passing
> also assumes btrfs-progs patches which takes advantage of this kernel
> change in `device scan -u` and udev.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/super.c   | 11 ++++-------
>  fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  fs/btrfs/volumes.h |  1 +
>  3 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7e44ccaf348f..3609b9a773f7 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2192,7 +2192,7 @@ static long btrfs_control_ioctl(struct file *file, =
unsigned int cmd,
>  {
>         struct btrfs_ioctl_vol_args *vol;
>         struct btrfs_device *device =3D NULL;
> -       dev_t devt =3D 0;
> +       char *name =3D NULL;
>         int ret =3D -ENOTTY;
>
>         if (!capable(CAP_SYS_ADMIN))
> @@ -2217,12 +2217,9 @@ static long btrfs_control_ioctl(struct file *file,=
 unsigned int cmd,
>                 mutex_unlock(&uuid_mutex);
>                 break;
>         case BTRFS_IOC_FORGET_DEV:
> -               if (vol->name[0] !=3D 0) {
> -                       ret =3D lookup_bdev(vol->name, &devt);
> -                       if (ret)
> -                               break;
> -               }
> -               ret =3D btrfs_forget_devices(devt);
> +               if (vol->name[0] !=3D 0)
> +                       name =3D vol->name;
> +               ret =3D btrfs_forget_devices_by_name(name);
>                 break;
>         case BTRFS_IOC_DEVICES_READY:
>                 mutex_lock(&uuid_mutex);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3cc947a42116..68fb0b64ab3f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -503,11 +503,13 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_=
mode_t flags, void *holder,
>  }
>
>  /*
> - *  Search and remove all stale devices (which are not mounted).  When b=
oth
> + *  Search and remove all stale devices (which are not mounted).  When a=
ll
>   *  inputs are NULL, it will search and release all stale devices.
>   *
>   *  @devt:         Optional. When provided will it release all unmounted=
 devices
> - *                 matching this devt only.
> + *                 matching this devt only. Don't set together with name=
.
> + *  @name:         Optional. When provided will it release all unmounted=
 devices
> + *                 matching this name only. Don't set together with devt=
.
>   *  @skip_device:  Optional. Will skip this device when searching for th=
e stale
>   *                 devices.
>   *
> @@ -515,14 +517,16 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_=
mode_t flags, void *holder,
>   *             -EBUSY if @devt is a mounted device.
>   *             -ENOENT if @devt does not match any device in the list.
>   */
> -static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *ski=
p_device)
> +static int btrfs_free_stale_devices(dev_t devt, char *name, struct btrfs=
_device *skip_device)
>  {
>         struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
>         struct btrfs_device *device, *tmp_device;
>         int ret;
>         bool freed =3D false;
> +       bool searching =3D devt || name;
>
>         lockdep_assert_held(&uuid_mutex);
> +       ASSERT(!(devt && name));
>
>         /* Return good status if there is no instance of devt. */
>         ret =3D 0;
> @@ -533,14 +537,18 @@ static int btrfs_free_stale_devices(dev_t devt, str=
uct btrfs_device *skip_device
>                                          &fs_devices->devices, dev_list) =
{
>                         if (skip_device && skip_device =3D=3D device)
>                                 continue;
> +                       if (!searching)
> +                               goto found;
>                         if (devt && devt !=3D device->devt)
>                                 continue;
> +                       if (name && device->name && strcmp(device->name->=
str, name))
> +                               continue;
> +found:
>                         if (fs_devices->opened) {
> -                               if (devt)
> +                               if (searching)
>                                         ret =3D -EBUSY;
>                                 break;
>                         }
> -
>                         /* delete the stale device */
>                         fs_devices->num_devices--;
>                         list_del(&device->dev_list);
> @@ -561,7 +569,7 @@ static int btrfs_free_stale_devices(dev_t devt, struc=
t btrfs_device *skip_device
>         if (freed)
>                 return 0;
>
> -       return ret;
> +       return ret ? ret : -ENODEV;
>  }
>
>  static struct btrfs_fs_devices *find_fsid_by_device(
> @@ -1288,12 +1296,32 @@ static struct btrfs_super_block *btrfs_read_disk_=
super(struct block_device *bdev
>         return disk_super;
>  }
>
> +int btrfs_forget_devices_by_name(char *name)
> +{
> +       int ret;
> +       dev_t devt =3D 0;
> +
> +       /*
> +        * Ideally, use devt, but if not, use name.
> +        * Note: Assumes lookup_bdev handles NULL name gracefully.
> +        */
> +       ret =3D lookup_bdev(name, &devt);
> +       if (!ret)
> +               name =3D NULL;
> +
> +       mutex_lock(&uuid_mutex);
> +       ret =3D btrfs_free_stale_devices(devt, name, NULL);
> +       mutex_unlock(&uuid_mutex);
> +
> +       return ret;
> +}
> +
>  int btrfs_forget_devices(dev_t devt)
>  {
>         int ret;
>
>         mutex_lock(&uuid_mutex);
> -       ret =3D btrfs_free_stale_devices(devt, NULL);
> +       ret =3D btrfs_free_stale_devices(devt, NULL, NULL);
>         mutex_unlock(&uuid_mutex);
>
>         return ret;
> @@ -1364,7 +1392,7 @@ struct btrfs_device *btrfs_scan_one_device(const ch=
ar *path, blk_mode_t flags,
>                         btrfs_warn(NULL, "lookup bdev failed for path %s:=
 %d",
>                                    path, ret);
>                 else
> -                       btrfs_free_stale_devices(devt, NULL);
> +                       btrfs_free_stale_devices(devt, NULL, NULL);
>
>                 pr_debug("BTRFS: skip registering single non-seed device =
%s\n", path);
>                 device =3D NULL;
> @@ -1373,7 +1401,7 @@ struct btrfs_device *btrfs_scan_one_device(const ch=
ar *path, blk_mode_t flags,
>
>         device =3D device_list_add(path, disk_super, &new_device_added);
>         if (!IS_ERR(device) && new_device_added)
> -               btrfs_free_stale_devices(device->devt, device);
> +               btrfs_free_stale_devices(device->devt, NULL, device);
>
>  free_disk_super:
>         btrfs_release_disk_super(disk_super);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index feba8d53526c..a5388a6b2969 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -681,6 +681,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_de=
vices,
>                        blk_mode_t flags, void *holder);
>  struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t =
flags,
>                                            bool mount_arg_dev);
> +int btrfs_forget_devices_by_name(char *name);
>  int btrfs_forget_devices(dev_t devt);
>  void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>  void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
> --
> 2.43.0
>
>

