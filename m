Return-Path: <linux-btrfs+bounces-3058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B0874AB3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3571C20E30
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63CF83CC3;
	Thu,  7 Mar 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXv3u1fy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8383CB7
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803295; cv=none; b=l7Mf1Tnz0q7srIFvdSvv1I6VKRvARrKKc/jBaxGcEN9tvzb6/WwlJoc9vdlt9F8WZ5073IdPBOqUYtbhFRBAr/sYnLssDbO8cFbrdpSADxZLJ0gbXT5cGvcNRtYx7vyacIYbLQiS7BWLD+CzQ0MagAT0kcVioPFC365RKU8N0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803295; c=relaxed/simple;
	bh=fneD7NDEoeRjd/ICYDuEtNBHSuLaJ/Ae529XphSzaMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdRLwp0XAzfNAdrwNKLyQiXiXW9GXr5PEVmwUzQNf8ZpYvLP8pEAdrgEoEO66N9dqa44Q8uBDFvPZziLsIDZuNsWkNWbxn29ySK4N6HN+SETlzApQEtH7pQsm3zZYlFcmqAvAH/hF/tHZ/4gONExj4ndO+nLsHk5IXxDxgVKxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXv3u1fy; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1370931276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 01:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803292; x=1710408092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaErA7vjQ40pU7NvVZ1hwP5ZdyCVxEdXpOpRxaOkAxY=;
        b=aXv3u1fyZrLv95U6Xec6v3bK0rchygSP2tcz113Or1J1p+cOKD1DMCEhA/vdUyUX2n
         cxcag1ERqR8EhlnKnCaJcEu3LzDRkHYs8mghAu6RuM0EhvrC1yBxowTo6PEMhEAasW4m
         jNszB3DhIuVnvkP+mwdSzNLLE8JgVk7T1SpDtDyXfmkXsIT6Wh55o1V75+52Pa7IgG1Z
         yVycetpJRuXEy3YQCZYWWBDi52nJm8bZt4icmSq6RmZ0FF42DSdF/gfGYJ+QyPLSOpYy
         LhoMgsUAUUyQFncwr4Dq1SO2iqEJNHbea0A8CPXbcvPvh7sYv5Rj5q7RfFLntF1IJzVA
         QnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803292; x=1710408092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaErA7vjQ40pU7NvVZ1hwP5ZdyCVxEdXpOpRxaOkAxY=;
        b=ivKHINnPnnRrjNglvCIayehZ8xwfgSbcNuYwLbdPLEFsfNhLqT786Q0nBOPG/s/CJt
         GFTrsYRijmkd2J3c41+R7YtbuPFcDwIEZgK8/fdk9yVDdYrRlGTH8EjCAn2PYZb6/Tli
         +Te5cqrxMN8rJmNWiP+WsogEqaPZvXtHePi3TdLUruHK0Iw8v9rbLNKyeGgDNaDhAXwo
         GRycTWy7PWChxMG9h791POW8b1uCe4uS6B4utPdX1cx5T1kZYxnIBdtv3r3bx0Vvb9uE
         Op4i+62RdxaEZOF9OkhpmJ6gHUCOWZ8lgeOpShBN/8A4D+c6oPCfagyoIlk/AUaTeCAb
         TqQQ==
X-Gm-Message-State: AOJu0YxSsY72s9jDOn3QGFQJHXXgok7iC2igGV5dJ6MzechbPMa7Tr5P
	/QVn83/M6cGA9jWCeAoeU09gBasKJoNEXx4PMxmKY8FUBIgA85Vox5NOgTTpTuwTqmmiOnPjW76
	aJPSl0Pm6u6InSvUEs3eO7TEhVUU=
X-Google-Smtp-Source: AGHT+IH4NnWSiRx7R8uFuScvaf7bH46E4xHzddZCjGRIBYgFFS7/0qXB1ygLbGDTTfrjFaal45D4gGebJCw9sPBhEO4=
X-Received: by 2002:a25:6a07:0:b0:dcf:ea90:5f5e with SMTP id
 f7-20020a256a07000000b00dcfea905f5emr500954ybc.1.1709803291999; Thu, 07 Mar
 2024 01:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com>
 <CAKLYge+wer9ij5vfoJ5ct8Zy8OqHuh7vKDmn4S0vCVF05mzOxQ@mail.gmail.com>
 <4118de16-dfb8-4ed4-852d-abbd4c7581ab@oracle.com> <fddbfc5c-e1e0-438d-a696-a2ec75e8de83@oracle.com>
In-Reply-To: <fddbfc5c-e1e0-438d-a696-a2ec75e8de83@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Thu, 7 Mar 2024 10:21:21 +0100
Message-ID: <CAKLYgeJJoXn4a-VOK=fehKhSONqAJ52qrr2vQSKk99f_4i2=XA@mail.gmail.com>
Subject: Re: [PATCH v3 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, CHECK_1234543212345@protonmail.com, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

can you send it as an attachment (or at least a link to the actual
patch)? i think part of the problem with the patch not applying was
tabs vs spaces. thanks

On Thu, Mar 7, 2024 at 10:00=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
>
> Sending one for the mainline version. Thx.
>
>
> On 3/7/24 14:17, Anand Jain wrote:
> >
> > Ah, it is based on the https://github.com/btrfs/linux.git for-next
> > branch. I tried applying it again, and it works well.
> >
> >
> > On 3/7/24 14:06, Alex Romosan wrote:
> >> I tried to apply the patch against the latest linux git HEAD but it
> >> failed. Care to send an updated version? If not, I'll try to fix it
> >> myself. Thanks.
> >>
> >> On Thu, Mar 7, 2024 at 5:14=E2=80=AFAM Anand Jain <anand.jain@oracle.c=
om> wrote:
> >>>
> >>> There are reports that since version 6.7 update-grub fails to find th=
e
> >>> device of the root on systems without initrd and on a single device.
> >>>
> >>> This looks like the device name changed in the output of
> >>> /proc/self/mountinfo:
> >>>
> >>> 6.5-rc5 working
> >>>
> >>>    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> >>>
> >>> 6.7 not working:
> >>>
> >>>    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> >>>
> >>> and "update-grub" shows this error:
> >>>
> >>>    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev
> >>> mounted?)
> >>>
> >>> This looks like it's related to the device name, but grub-probe
> >>> recognizes the "/dev/root" path and tries to find the underlying devi=
ce.
> >>> However there's a special case for some filesystems, for btrfs in
> >>> particular.
> >>>
> >>> The generic root device detection heuristic is not done and it all
> >>> relies on reading the device infos by a btrfs specific ioctl. This io=
ctl
> >>> returns the device name as it was saved at the time of device scan (i=
n
> >>> this case it's /dev/root).
> >>>
> >>> The change in 6.7 for temp_fsid to allow several single device
> >>> filesystem to exist with the same fsid (and transparently generate a =
new
> >>> UUID at mount time) was to skip caching/registering such devices.
> >>>
> >>> This also skipped mounted device. One step of scanning is to check if
> >>> the device name hasn't changed, and if yes then update the cached val=
ue.
> >>>
> >>> This broke the grub-probe as it always read the device /dev/root and
> >>> couldn't find it in the system. A temporary workaround is to create a
> >>> symlink but this does not survive reboot.
> >>>
> >>> The right fix is to allow updating the device path of a mounted
> >>> filesystem even if this is a single device one.
> >>>
> >>> In the fix, check if the device's major:minor number matches with the
> >>> cached device. If they do, then we can allow the scan to happen so th=
at
> >>> device_list_add() can take care of updating the device path. The file
> >>> descriptor remains unchanged.
> >>>
> >>> This does not affect the temp_fsid feature, the UUID of the mounted
> >>> filesystem remains the same and the matching is based on device
> >>> major:minor
> >>> which is unique per mounted filesystem.
> >>>
> >>> This covers the path when the device (that exists for all mounted
> >>> devices) name changes, updating /dev/root to /dev/sdx. Any other sing=
le
> >>> device with filesystem and is not mounted is still skipped.
> >>>
> >>> Note that if a system is booted and initial mount is done on the
> >>> /dev/root device, this will be the cached name of the device. Only af=
ter
> >>> the command "btrfs device scan" it will change as it triggers the
> >>> rename.
> >>>
> >>> The fix was verified by users whose systems were affected.
> >>>
> >>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single
> >>> device filesystem")
> >>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> >>> Link:
> >>> https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gis=
PKDZLs8Y2TQ@mail.gmail.com/
> >>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>> Tested-by: Alex Romosan <aromosan@gmail.com>
> >>> Tested-by: CHECK_1234543212345@protonmail.com
> >>> Reviewed-by: David Sterba <dsterba@suse.com>
> >>> ---
> >>> v3:
> >>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the
> >>> RFC stage.
> >>> I need this patch verified by the bug filer.
> >>>
> >>> Changes in v3:
> >>> Verify if the device is opened/mounted to prevent skipping registrati=
on,
> >>> fixing the following fstests failures.
> >>>     ./check btrfs/14[6-9] btrfs/15[8-9]
> >>> Update comments.
> >>> Only reregister when devt matches but the path differs.
> >>>
> >>> v2:
> >>> https://lore.kernel.org/linux-btrfs/88673c60b1d866c289ef019945647adfc=
8ab51d0.1707781507.git.anand.jain@oracle.com/
> >>>
> >>>   fs/btrfs/volumes.c | 61 +++++++++++++++++++++++++++++++++++++------=
---
> >>>   1 file changed, 50 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>> index e49935a54da0..ea71a2c14927 100644
> >>> --- a/fs/btrfs/volumes.c
> >>> +++ b/fs/btrfs/volumes.c
> >>> @@ -1303,6 +1303,47 @@ int btrfs_forget_devices(dev_t devt)
> >>>          return ret;
> >>>   }
> >>>
> >>> +static bool btrfs_skip_registration(struct btrfs_super_block
> >>> *disk_super,
> >>> +                                   const char *path, dev_t devt,
> >>> +                                   bool mount_arg_dev)
> >>> +{
> >>> +       struct btrfs_fs_devices *fs_devices;
> >>> +
> >>> +       /*
> >>> +        * Do not skip device registration for mounted devices with
> >>> matching
> >>> +        * maj:min but different paths. Booting without initrd relies=
 on
> >>> +        * /dev/root initially, later replaced with the actual root
> >>> device.
> >>> +        * A successful scan ensures update-grub selects the correct
> >>> device.
> >>> +        */
> >>> +       list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> >>> +               struct btrfs_device *device;
> >>> +
> >>> +               mutex_lock(&fs_devices->device_list_mutex);
> >>> +
> >>> +               if (!fs_devices->opened) {
> >>> +                       mutex_unlock(&fs_devices->device_list_mutex);
> >>> +                       continue;
> >>> +               }
> >>> +
> >>> +               list_for_each_entry(device, &fs_devices->devices,
> >>> dev_list) {
> >>> +                       if ((device->devt =3D=3D devt) &&
> >>> +                           strcmp(device->name->str, path)) {
> >>> +
> >>> mutex_unlock(&fs_devices->device_list_mutex);
> >>> +
> >>> +                               /* Do not skip registration */
> >>> +                               return false;
> >>> +                       }
> >>> +               }
> >>> +               mutex_unlock(&fs_devices->device_list_mutex);
> >>> +       }
> >>> +
> >>> +       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=
=3D
> >>> 1 &&
> >>> +           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDIN=
G))
> >>> +               return true;
> >>> +
> >>> +       return false;
> >>> +}
> >>> +
> >>>   /*
> >>>    * Look for a btrfs signature on a device. This may be called out
> >>> of the mount path
> >>>    * and we are not allowed to call set_blocksize during the scan.
> >>> The superblock
> >>> @@ -1320,6 +1361,7 @@ struct btrfs_device
> >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >>>          struct btrfs_device *device =3D NULL;
> >>>          struct bdev_handle *bdev_handle;
> >>>          u64 bytenr, bytenr_orig;
> >>> +       dev_t devt =3D 0;
> >>>          int ret;
> >>>
> >>>          lockdep_assert_held(&uuid_mutex);
> >>> @@ -1359,19 +1401,16 @@ struct btrfs_device
> >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >>>                  goto error_bdev_put;
> >>>          }
> >>>
> >>> -       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=
=3D
> >>> 1 &&
> >>> -           !(btrfs_super_flags(disk_super) &
> >>> BTRFS_SUPER_FLAG_SEEDING)) {
> >>> -               dev_t devt;
> >>> +       ret =3D lookup_bdev(path, &devt);
> >>> +       if (ret)
> >>> +               btrfs_warn(NULL, "lookup bdev failed for path %s: %d"=
,
> >>> +                          path, ret);
> >>>
> >>> -               ret =3D lookup_bdev(path, &devt);
> >>> -               if (ret)
> >>> -                       btrfs_warn(NULL, "lookup bdev failed for path
> >>> %s: %d",
> >>> -                                  path, ret);
> >>> -               else
> >>> +       if (btrfs_skip_registration(disk_super, path, devt,
> >>> mount_arg_dev)) {
> >>> +               pr_debug("BTRFS: skip registering single non-seed
> >>> device %s (%d:%d)\n",
> >>> +                         path, MAJOR(devt), MINOR(devt));
> >>> +               if (devt)
> >>>                          btrfs_free_stale_devices(devt, NULL);
> >>> -
> >>> -       pr_debug("BTRFS: skip registering single non-seed device %s
> >>> (%d:%d)\n",
> >>> -                       path, MAJOR(devt), MINOR(devt));
> >>>                  device =3D NULL;
> >>>                  goto free_disk_super;
> >>>          }
> >>> --
> >>> 2.38.1
> >>>

