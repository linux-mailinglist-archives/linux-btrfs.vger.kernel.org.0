Return-Path: <linux-btrfs+bounces-3346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41B87E7BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B901C212ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C112EB10;
	Mon, 18 Mar 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AejLchHS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FF38DDC;
	Mon, 18 Mar 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759224; cv=none; b=HCiaUnfQViQ5nHzGY3wO+FsR2roSaHrB6cWgq4tjqXYDHKLQimJslKKxyeesEz1bMBLlmHz5Cd/LM1gmzLlaDJUfHtbQPCBUNKMW56jh8papY04BSYmoeFVt71oJ/EthrD4bsZ0gvolFcJcLrLFJvGEdCut0DREeBKYTWFKEvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759224; c=relaxed/simple;
	bh=LwAXhbzSqjviIVJYE1ssOJEYV5DZsb/HsKFYmHhCklE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn/J8RoFuUHzXZ6ZvSY0YHfMuHSgPmhSdZpPh8H85WeirUsgZoSJwKyREov+2zomxIYMv/o8+NO3vOH02NTeMdS9iMGRoful7NYz/2UTukyZpPKHN/r18wTaIcwcvDB6ZeL2Oci0rLQvrT7xrZTPSjn10P068yRevGcMjH4TWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AejLchHS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0579a968so44673187b3.3;
        Mon, 18 Mar 2024 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710759222; x=1711364022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ+ETjRt5GAsWXav6Ur1chdsEwQhnzeQQh1tinf4OWo=;
        b=AejLchHSzoHM9evPXNIngeWZ3RlepEdXhxm58gsXTIKUZvbQNsGZkquFLwmHRkftyw
         Alq2awn5jKcM1rD63kDRy1WN6efPKV8CD3sotVFZ1gwdCghFJzuYd2CWDwueq487be0b
         0FKRV1fSRWjTRoycc3X8pfGm0L7qdo5DLj/V65Z75deptn+Rgf2Qq4OraWDSIR1ngArJ
         GPdRP15msXzFe3PbXcqx3Necbx/0rao7zaPNv9EM3Vk+9O+x5mpStAP9li+Vi+nrM2Nh
         Cnop85wuAVKCGp0TIDn4UYA0Lqc5Z7V6oL3U+/vLK2ku3R9eBz47Q7DlM7vp5u9uGh3L
         3C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710759222; x=1711364022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJ+ETjRt5GAsWXav6Ur1chdsEwQhnzeQQh1tinf4OWo=;
        b=D3nUQGQrhSa0i0PmSwFJJaDoPkHUkUfzu5o2TP24NVWDpNY+rmDqZ7lrw1mnmwZSBY
         l6bqIbimM1aWBb+sEj120bnYiD3eCOoHhWABPiI1bQiynLYmgNe7tR69TxrdzcyUgu1l
         9QL/U56gFluVaI/PjzQlVVZeO2HUb5GZ3cLDL8ZNmFIaNjwmqfjqcmCp7e3o5015Om2Q
         LMP6T2BzZo99UgAhpsqLyaUF1Hw9VVqL+KACroT5gFEeL4q9nL8ofhyEj5UtJawfkzFw
         K0z2WcCTOknihXc8exaUqpDXCioi5pTlT/B5XPlGZijn79+4wzio1A+5rZr5lKTJef2x
         q1tw==
X-Forwarded-Encrypted: i=1; AJvYcCXMc4eIPNfwQpLXcQU53rlAspXFQ2kSJebRAoTpOwPIyZBOQl3k7lUaNDFmgIaJDyFIE4V6lWms7eqjSvwPAE+XYCUsFxyE
X-Gm-Message-State: AOJu0Yyccr/6ZsXpk0oMQjpDXbMg94cM5kZBqHOl6QyVeiMf1wbs5RoA
	+Z0hnJbZNZg18zOwXT8FVICrR9NpDhgC+aQAmpLcX1kfKIGxjajsGhoTRdipEq6HbW14wO6dHRU
	g5jj/6VfAykR+f/yzvtYfMSBWhOXigfPy4xk=
X-Google-Smtp-Source: AGHT+IFNvKGmwM4u7ZRGvCZIdVSEU/Q/yzXnAJe2rQ3yKM7i+8lNzuoYQsHRe/KnxvexUxwHQ+67O1xNatu5WTMpKRg=
X-Received: by 2002:a81:9344:0:b0:60c:c96d:7e0b with SMTP id
 k65-20020a819344000000b0060cc96d7e0bmr13189707ywg.1.1710759221792; Mon, 18
 Mar 2024 03:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171028225254.16151.9271790987036999384.pr-tracker-bot@kernel.org> <57a63f9905549f22618a85991b775fba76104412.1710732026.git.anand.jain@oracle.com>
In-Reply-To: <57a63f9905549f22618a85991b775fba76104412.1710732026.git.anand.jain@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Mon, 18 Mar 2024 11:53:31 +0100
Message-ID: <CAKLYgeJbhnwS+dicruBTNzN4k6iJDLgHz11Qy9=EPJHk778ibA@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org, 
	CHECK_1234543212345@protonmail.com, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

confirming that update-grub works with v5 of the patch (applied
against current Linus tree HEAD). these are the relevant entries in
the log:

Btrfs loaded, debug=3Don, zoned=3Dno, fsverity=3Dno
BTRFS: device fsid 695aa7ac-862a-4de3-ae59-c96f784600a0 devid 1
transid 2037166 /dev/root (259:3) scanned by swapper/0 (1)
BTRFS info (device nvme0n1p3): first mount of filesystem
695aa7ac-862a-4de3-ae59-c96f784600a0
BTRFS info (device nvme0n1p3): using crc32c (crc32c-generic) checksum algor=
ithm
BTRFS info (device nvme0n1p3): using free-space-tree
VFS: Mounted root (btrfs filesystem) readonly on device 0:20.
BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
scanned by (udev-worker) (278)


On Mon, Mar 18, 2024 at 5:47=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> There are reports that since version 6.7 update-grub fails to find the
> device of the root on systems without initrd and on a single device.
>
> This looks like the device name changed in the output of
> /proc/self/mountinfo:
>
> 6.5-rc5 working
>
>   18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
>
> 6.7 not working:
>
>   17 1 0:15 / / rw,noatime - btrfs /dev/root ...
>
> and "update-grub" shows this error:
>
>   /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounte=
d?)
>
> This looks like it's related to the device name, but grub-probe
> recognizes the "/dev/root" path and tries to find the underlying device.
> However there's a special case for some filesystems, for btrfs in
> particular.
>
> The generic root device detection heuristic is not done and it all
> relies on reading the device infos by a btrfs specific ioctl. This ioctl
> returns the device name as it was saved at the time of device scan (in
> this case it's /dev/root).
>
> The change in 6.7 for temp_fsid to allow several single device
> filesystem to exist with the same fsid (and transparently generate a new
> UUID at mount time) was to skip caching/registering such devices.
>
> This also skipped mounted device. One step of scanning is to check if
> the device name hasn't changed, and if yes then update the cached value.
>
> This broke the grub-probe as it always read the device /dev/root and
> couldn't find it in the system. A temporary workaround is to create a
> symlink but this does not survive reboot.
>
> The right fix is to allow updating the device path of a mounted
> filesystem even if this is a single device one.
>
> In the fix, check if the device's major:minor number matches with the
> cached device. If they do, then we can allow the scan to happen so that
> device_list_add() can take care of updating the device path. The file
> descriptor remains unchanged.
>
> This does not affect the temp_fsid feature, the UUID of the mounted
> filesystem remains the same and the matching is based on device major:min=
or
> which is unique per mounted filesystem.
>
> This covers the path when the device (that exists for all mounted
> devices) name changes, updating /dev/root to /dev/sdx. Any other single
> device with filesystem and is not mounted is still skipped.
>
> Note that if a system is booted and initial mount is done on the
> /dev/root device, this will be the cached name of the device. Only after
> the command "btrfs device scan" it will change as it triggers the
> rename.
>
> The fix was verified by users whose systems were affected.
>
> CC: stable@vger.kernel.org # 6.7+
> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single dev=
ice filesystem")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2g=
isPKDZLs8Y2TQ@mail.gmail.com/
> Tested-by: Alex Romosan <aromosan@gmail.com>
> Tested-by: CHECK_1234543212345@protonmail.com
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v5:
> Fix the linux-next build failure reported here:
>   https://lore.kernel.org/all/20240318091755.1d0f696f@canb.auug.org.au/
> As the Linux-next branch no longer has the this commit,
> I've sent out the entire patch again.
>
> v4: (based on mainline master)
> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC s=
tage.
> I need this patch verified by the bug filer.
> Use devt from bdev->bd_dev
> Rebased on mainline kernel.org master branch
>
> v3:
> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad8=
7d0.1709782041.git.anand.jain@oracle.com/T/#u
>
>  fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a2d07fa3cfdf..813c1c66b2db 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1303,6 +1303,47 @@ int btrfs_forget_devices(dev_t devt)
>         return ret;
>  }
>
> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super=
,
> +                                   const char *path, dev_t devt,
> +                                   bool mount_arg_dev)
> +{
> +       struct btrfs_fs_devices *fs_devices;
> +
> +       /*
> +        * Do not skip device registration for mounted devices with match=
ing
> +        * maj:min but different paths. Booting without initrd relies on
> +        * /dev/root initially, later replaced with the actual root devic=
e.
> +        * A successful scan ensures update-grub selects the correct devi=
ce.
> +        */
> +       list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +               struct btrfs_device *device;
> +
> +               mutex_lock(&fs_devices->device_list_mutex);
> +
> +               if (!fs_devices->opened) {
> +                       mutex_unlock(&fs_devices->device_list_mutex);
> +                       continue;
> +               }
> +
> +               list_for_each_entry(device, &fs_devices->devices, dev_lis=
t) {
> +                       if ((device->devt =3D=3D devt) &&
> +                           strcmp(device->name->str, path)) {
> +                               mutex_unlock(&fs_devices->device_list_mut=
ex);
> +
> +                               /* Do not skip registration */
> +                               return false;
> +                       }
> +               }
> +               mutex_unlock(&fs_devices->device_list_mutex);
> +       }
> +
> +       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=3D =
1 &&
> +           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> +               return true;
> +
> +       return false;
> +}
> +
>  /*
>   * Look for a btrfs signature on a device. This may be called out of the=
 mount path
>   * and we are not allowed to call set_blocksize during the scan. The sup=
erblock
> @@ -1320,6 +1361,7 @@ struct btrfs_device *btrfs_scan_one_device(const ch=
ar *path, blk_mode_t flags,
>         struct btrfs_device *device =3D NULL;
>         struct file *bdev_file;
>         u64 bytenr, bytenr_orig;
> +       dev_t devt;
>         int ret;
>
>         lockdep_assert_held(&uuid_mutex);
> @@ -1359,19 +1401,13 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags,
>                 goto error_bdev_put;
>         }
>
> -       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=3D =
1 &&
> -           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) =
{
> -               dev_t devt;
> +       devt =3D file_bdev(bdev_file)->bd_dev;
> +       if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev=
)) {
> +       pr_debug("BTRFS: skip registering single non-seed device %s (%d:%=
d)\n",
> +                         path, MAJOR(devt), MINOR(devt));
>
> -               ret =3D lookup_bdev(path, &devt);
> -               if (ret)
> -                       btrfs_warn(NULL, "lookup bdev failed for path %s:=
 %d",
> -                                  path, ret);
> -               else
> -                       btrfs_free_stale_devices(devt, NULL);
> +               btrfs_free_stale_devices(devt, NULL);
>
> -       pr_debug("BTRFS: skip registering single non-seed device %s (%d:%=
d)\n",
> -                       path, MAJOR(devt), MINOR(devt));
>                 device =3D NULL;
>                 goto free_disk_super;
>         }
> --
> 2.38.1
>

