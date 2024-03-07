Return-Path: <linux-btrfs+bounces-3055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EA8749C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 09:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA211F2440C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEAE82883;
	Thu,  7 Mar 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS2ju04j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9B82881
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800577; cv=none; b=RTrWTMoaaEembNxAiGyBBwhD8YYsrJuhcNgcaktHIE0oMKBeII2VjZzDuvaioOvmVbxnUn4J4+qmIPsd7fmbnoDuYD+uRFaxZh18gFH8jAcjSbKGPIEM7Q56lcscMd2ig2oPNKtEy85ZdLi0Co8btvyZj+Lm5TFzd6xiw1qhpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800577; c=relaxed/simple;
	bh=bam2yrhZ3oBWbvBwu7LJnRgJZ2WaNQITNwT6/y0mVwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoKEkCNEWZZJZLR1n+gN2D7nGaJdv31wH+ZJyLttiX7dwsoOHupDuzOH+TA+1bQd6zxVTuoFtSuA37ZHwXwFZeJLl2NIHzcAtwvBuoNVyRXTNb6tkgGQzEmp4aAWn362bBCDPoQM3eSfsU4o8Kmzj/XCsjp0BewMf+0JLzh9IyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS2ju04j; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so606176276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709800574; x=1710405374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8+rtQ/iluWmNCuhx2kJ2O+4VyR2JSutQ0tqq9+hLpg=;
        b=AS2ju04jyaJwNhLdL50yucNxt4HQWy5ORWR0O1fTI7r21JeKwsMqdb4717Yd3t8myZ
         s0PXWNnAvv7Tfcv9cy2MWX14zEDffZYj/LY+Rhj4IEoKAMJ3hDVmflQt6K8XJ1mz+ybC
         u6+qJldFApwelyQxqq6b+QaIt8ZIarx9RnZSB4FtnlvsU5Lxv6+4p0Or1zdBsPXaNab6
         LBiMN6mITouOHKUsF4HhMl8sM9zkeoxq7Zh8ai1W+a6JC3bKd5hGRqEFItS5ukvzwf3n
         fFhULh8aKdcF8Fyk2f9WGQPrEvta0nXw7SAj3lkkWirBYr0ye5tHZGLKT3gAEL7gFWdw
         S0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800574; x=1710405374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8+rtQ/iluWmNCuhx2kJ2O+4VyR2JSutQ0tqq9+hLpg=;
        b=AOlfbbO5C5cLNgYqdeTBizXKkF84DC6N9nk7z+fPD02x/upfzGbcLMe8pqHZ4q2qcB
         FgdWkQiuttGBqQTl+1KnDBlXBVtT7Pv2jOAQphzX27VxDzxIJHODGODtpmuh8/hGWsrJ
         +lyc8wd1cfFImPSSobQp4vuLawfW0j8z3SROXIqRn94Ctis8kxHTjxhPt9aQAglZHKBM
         7Ib4eou4rmS2OJVJT0f/u0h950K8n9MlQmMOkiDCJshc6VTjyjHmfG3cVLasxMFa6vzq
         DsWR0zGYIkXKr9Rtbsklfr+YjJPF3t2/J8qRKk1b07AMFLTeMFtEihzLXOMcD7wzuKK7
         pxWw==
X-Gm-Message-State: AOJu0YxRFjZPGGLOO10VbyMPtG5NltYSHVx44vmzbEa2JqhCQWmoDdf8
	LpYjYSJfEaUOPBEHP4xtk47B8XgTMQk2typR3uwQh5Iz+B3V6A4JlecnQT+FAICGXQ+7YxybgF/
	Y6hEFFhhwk0GJ62p2eJvTL8pvf38=
X-Google-Smtp-Source: AGHT+IFb/250OxWdeTaUkJc4aV5ngsSn748Yc90HHWnZ1l5UG5O0UVEv79jbPBXR6ecKyLml44iQQ5IRAGFsFsb2b5w=
X-Received: by 2002:a25:7443:0:b0:dc6:db0c:4ff0 with SMTP id
 p64-20020a257443000000b00dc6db0c4ff0mr15874143ybc.32.1709800574575; Thu, 07
 Mar 2024 00:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com>
In-Reply-To: <e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Thu, 7 Mar 2024 09:36:03 +0100
Message-ID: <CAKLYge+wer9ij5vfoJ5ct8Zy8OqHuh7vKDmn4S0vCVF05mzOxQ@mail.gmail.com>
Subject: Re: [PATCH v3 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, CHECK_1234543212345@protonmail.com, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried to apply the patch against the latest linux git HEAD but it
failed. Care to send an updated version? If not, I'll try to fix it
myself. Thanks.

On Thu, Mar 7, 2024 at 5:14=E2=80=AFAM Anand Jain <anand.jain@oracle.com> w=
rote:
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
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Tested-by: Alex Romosan <aromosan@gmail.com>
> Tested-by: CHECK_1234543212345@protonmail.com
> Reviewed-by: David Sterba <dsterba@suse.com>
> ---
> v3:
> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC s=
tage.
> I need this patch verified by the bug filer.
>
> Changes in v3:
> Verify if the device is opened/mounted to prevent skipping registration,
> fixing the following fstests failures.
>    ./check btrfs/14[6-9] btrfs/15[8-9]
> Update comments.
> Only reregister when devt matches but the path differs.
>
> v2:
> https://lore.kernel.org/linux-btrfs/88673c60b1d866c289ef019945647adfc8ab5=
1d0.1707781507.git.anand.jain@oracle.com/
>
>  fs/btrfs/volumes.c | 61 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e49935a54da0..ea71a2c14927 100644
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
>         struct bdev_handle *bdev_handle;
>         u64 bytenr, bytenr_orig;
> +       dev_t devt =3D 0;
>         int ret;
>
>         lockdep_assert_held(&uuid_mutex);
> @@ -1359,19 +1401,16 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags,
>                 goto error_bdev_put;
>         }
>
> -       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=3D =
1 &&
> -           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) =
{
> -               dev_t devt;
> +       ret =3D lookup_bdev(path, &devt);
> +       if (ret)
> +               btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> +                          path, ret);
>
> -               ret =3D lookup_bdev(path, &devt);
> -               if (ret)
> -                       btrfs_warn(NULL, "lookup bdev failed for path %s:=
 %d",
> -                                  path, ret);
> -               else
> +       if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev=
)) {
> +               pr_debug("BTRFS: skip registering single non-seed device =
%s (%d:%d)\n",
> +                         path, MAJOR(devt), MINOR(devt));
> +               if (devt)
>                         btrfs_free_stale_devices(devt, NULL);
> -
> -       pr_debug("BTRFS: skip registering single non-seed device %s (%d:%=
d)\n",
> -                       path, MAJOR(devt), MINOR(devt));
>                 device =3D NULL;
>                 goto free_disk_super;
>         }
> --
> 2.38.1
>

