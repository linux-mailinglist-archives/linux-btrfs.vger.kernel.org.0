Return-Path: <linux-btrfs+bounces-3060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754A874EAB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 13:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FED61C20CB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060612A15C;
	Thu,  7 Mar 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECltKrmq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71531129A8C
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813554; cv=none; b=LOEf/AWPTjjDJ+TMJS2GHhfSL7YacRUT2XQz4zc+wcnRZaiB1Hf/b4J6OsTzViHE8WKW74n7ye8qIF1G/q4Rroy2mgRvsyMJ0ivZ+cz3DNnulJTt0x2tD4eosXUjIO5i61pmFsks9Lk44CMzjl1kcLLT54A5QAv324A8agacdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813554; c=relaxed/simple;
	bh=WGaqhP6DT8CDzb+ZhZnIghrvJqWi8uEbanrv8ljKi5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ye8lIKYRkI7tp39FeS2icqKMNTN7jEdLFyElazPWViyBPsk5M6oKJ/sQMX2YmpxKPpP9hYYJrnUCBC+5T8qnTGfxWc/ZTz7n/42oSOTPAucRRF0KHo1oSiT9UWkmISzC0wveF2d7xRaXMlph4VBaZLa2VUNw01Xj0rbdqNRpbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECltKrmq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6098bf69909so7156537b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709813550; x=1710418350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFRhgMQpI32YCjYYqDof0+4B5eIcITmJVsFr0lF3iHo=;
        b=ECltKrmqBZWp5+UGEMnGskMkm+RCOSEs9iCs1AK5UUElRkoDetDwWYjuBwERyLA8YV
         nEWdT6a+uA6J/pt3e1QYgegTJb2xnf86dM6FQinIlZs6xy+7XN9XvHqcAAHEHB6t7t3N
         bAMf6dm39/srn4aeMQcjzcu5sSNA2TjLl32QCwmLwJgarNDc15I6jOUdHyrehbZZIuwJ
         qer1KXazZdwu7BKlJBnMt58mkH4zKLxXHqo8DNfUTfTv2dbPXG8sFqg5Qfz5kbCxNxvi
         LLHfY8lrMikslqMsjCgRv/xY3zr1wHuDQdPMAAoizQ4dCuVW4Hc53rgzphFQ+Mlgt1cR
         QaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813550; x=1710418350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFRhgMQpI32YCjYYqDof0+4B5eIcITmJVsFr0lF3iHo=;
        b=pNMsUzHp8QEDCltL1ComI41erg49SwQEbHlvXzhHKQIQHLaISXd16JuYKC9XIjOOyz
         V5oWrh9NE67zuxIRHWJepQCFKS8rLgZJi0YLtuTtLDW6CwgvsikYiExe2JoU1/9rupxp
         9hMi5NL/6pRgDZEYKDxm2tnn2TxcePVzc/Bu71x0IPQShu/eD8hJRSZjmG/Uog7E8qyC
         FcHdvQJlumotylfK/bHlh3Rxw12yXiiS/GEaCN27DNaLevsenVu1zro5+H+o3yKme6Af
         ULkpe2JJiqjd0lLx/cMX78qeZy0SJMySqVUM+SEpWmtJTtpBhKiHiepJt+hJd653VGD8
         ErLg==
X-Gm-Message-State: AOJu0YxiGYudG+/daCQBc6G1PSOHDeB8u+dYDrq4s0KHxKG3x89al2cF
	mXGAuMXbXsCgab3PZajw9EBjmednPfqVOpIkaSGNng+2ZYkPJh6fAOVkT/4YlHKeN/TwD+dHRX6
	n6mhuj+tdMzx5Mpp7d6iC16FH2e4=
X-Google-Smtp-Source: AGHT+IFObyk65glHafq16ne/3cOwqzPsifUKSUTjhZZ5iBii0FtcHXJV5WLZ1u2LBYLRb1sPxq+RZ4gpKlRC61okk7I=
X-Received: by 2002:a0d:d8cd:0:b0:609:b1ec:3ffb with SMTP id
 a196-20020a0dd8cd000000b00609b1ec3ffbmr716666ywe.6.1709813550248; Thu, 07 Mar
 2024 04:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
In-Reply-To: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Thu, 7 Mar 2024 13:12:18 +0100
Message-ID: <CAKLYge+crQ73TJMvd6k2YtLSnT8rQ44AYb5q1HCkL4GB+gb4Xg@mail.gmail.com>
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, CHECK_1234543212345@protonmail.com, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

finally sorted out the spaces vs tabs problem. compared the latest
patch to the original one i've been applying since and they are
identical so everything works fine. i thought at some point there was
an add on patch from david sterba but maybe i'm wrong. thanks.

On Thu, Mar 7, 2024 at 12:08=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
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
> v4:
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
>  fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d67785be2c77..75bfef1b973b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
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
> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags,
>                 goto error_bdev_put;
>         }
>
> -       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=3D =
1 &&
> -           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) =
{
> -               dev_t devt;
> +       if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->=
bd_dev,
> +                                   mount_arg_dev)) {
> +               pr_debug("BTRFS: skip registering single non-seed device =
%s (%d:%d)\n",
> +                         path, MAJOR(bdev_handle->bdev->bd_dev),
> +                         MINOR(bdev_handle->bdev->bd_dev));
>
> -               ret =3D lookup_bdev(path, &devt);
> -               if (ret)
> -                       btrfs_warn(NULL, "lookup bdev failed for path %s:=
 %d",
> -                                  path, ret);
> -               else
> -                       btrfs_free_stale_devices(devt, NULL);
> +               btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL)=
;
>
> -               pr_debug("BTRFS: skip registering single non-seed device =
%s\n", path);
>                 device =3D NULL;
>                 goto free_disk_super;
>         }
> --
> 2.38.1
>

