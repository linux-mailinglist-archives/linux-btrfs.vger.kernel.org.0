Return-Path: <linux-btrfs+bounces-3104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F24D876662
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96261F22188
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146DB15AF;
	Fri,  8 Mar 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9higThP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB5EBB
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908348; cv=none; b=BkDmzahIJWQWpqj5VGjHJ1RXsMpdsiRvN50E38b4NfyTKQOrIMhMz9KgjuhkfskPAEgXmQcO164zbmf8z2u5AIlTgV5R+rze9dQLJmmLYBMiEq/tnzX4LAd9oiUADlMlWdqCW9Z/cgfhb5XPTX0rWDfaNTf3TWaDSikkcS8EqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908348; c=relaxed/simple;
	bh=Hb+xTqjSv2uJDr8nnm/sRihzOhtxsCtnrnVM2qvl37c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcdvpuS2xQFGh1YpNvxWk48Q8rofx651G6xMUHu9r6uxjpUykYAHiUWgsHKkI9le0OD/b9l0mUrVkZE92tP931nGI9DytYPOvti7sKEd7YxK1Pp2W2b4hfPo9W2QGBpmvi8zyQPj8bFj/Cgsh/v/FyIQHY8TA2OXaAV2JU//Bk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9higThP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6099703e530so9107857b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709908345; x=1710513145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJDB6LonLARNR6+OprgtTEPBxopc/Mk+37v7G4i3HpA=;
        b=P9higThPysr0XH/r/QkL4Ctr1+BxP6AVZgEXjeEt7Fne7Vadp8L9oIirZ7wbI6wq4T
         bec1JToZ0CKkpAJWTky1OmSPNXyAmAIDJRfp6O0GSYqH1qROzxhM731ZJNvu5yfcJMBA
         JGVOVfTumzUInqO0NzeUd6HiNJbWfpb5yCs2t8kXBqQeVfZKbwszn3nUjxGiI9VphFK5
         wUjXdN2/5RY47X4lmSLYXaSHFhWmURt6Yw2Bx6m3CpmQ32JnauffalhpSS3D4zM3ueMk
         0tWUYY6S8Hq1p7qseD87/92TqXrJ/cOgW9zcHDJ5AWsgbbEZa6GHaTwYglWd2VI/UzHB
         1cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709908345; x=1710513145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJDB6LonLARNR6+OprgtTEPBxopc/Mk+37v7G4i3HpA=;
        b=gkdeMaQwFJh2SixIYvED+L5ihDxzNZrM+GzZUEvq9/hGVd09OY2kR8+m4LN+lPa1SC
         UH68Yp63FreokkRmZipmYtJqfZayhBMLS9gnI9aG0oF7LFzm1Nkvt80f5A4mHnD//nP8
         QfePPyGoFTJ8N+f28NpKBMLDB5eAUtVvjq3UO/0e3oPg4hzCGBvkQE6SVq+vkw63Iedy
         GTeEZcGcamLcR7EdW/12jlhag0FVba/qbKogdz+zD0CHnuU01c86lbmL20dRFi/d3q6R
         yicDfXS3gDeQYhLaF4hKn/NiSWI0a8S8SttIhCz4SZiNIA8iiv+kayGMykpleyAiiQrd
         CxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvH3ZCqe/cgFezwyN7H8c6d4mRmIezlXQznH3LdxCAa+icf9sf42KkQwWzUx0Qh6hPGYaBQ10Sehb8/Y8JO2zMrU/2AzeiFhJMSb4=
X-Gm-Message-State: AOJu0YykvNXyREhjxxueRR5bCQeJofthGYVJX/cKZa8SAaFoKQoTb3Kl
	FeaF/+12FptSZ5siAzw34l8FwtUcgHg+Qc3k0mA8M46+gVm7gjTVweWN/Ml404kndHPdwq1z6Fk
	6SWNFtm747g7XbLKD5nG+fjxcz+s=
X-Google-Smtp-Source: AGHT+IE+NAos6+mudlFIVFt/jpVmGKU/aQCDS8I9myK7IVPL1SKj7kFRw1EI9HQLxl/PD6F4tdLmR4K6IDBmh7Ni8oo=
X-Received: by 2002:a25:d092:0:b0:dcd:a28e:e5e0 with SMTP id
 h140-20020a25d092000000b00dcda28ee5e0mr17860077ybg.25.1709908345510; Fri, 08
 Mar 2024 06:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com> <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
 <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com>
In-Reply-To: <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Fri, 8 Mar 2024 15:32:12 +0100
Message-ID: <CAKLYgeJDQHTWj4U_SBLRK6ssoTJEkn9_EdZXWPgTfkK6s87H1A@mail.gmail.com>
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>, 
	CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sorry about the previous html mail.

Just to eliminate any confusion, can you please provide either a link
to v4 of the patch or include it in the reply to this and explicitly
labeled as such? I am beginning to have doubts as to the version I was
testing. Thanks

On Fri, Mar 8, 2024 at 2:52=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
>
> On 3/8/24 17:45, Filipe Manana wrote:
> > On Fri, Mar 8, 2024 at 2:28=E2=80=AFAM Anand Jain <anand.jain@oracle.co=
m> wrote:
> >>
> >> Filipe,
> >>
> >> We've received confirmation from the user that the original update-gru=
b
> >> issue has been fixed. Additionally, your reported issue using
> >> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
> >>
> >> However, reproducing the bug has been inconsistent on my systems.
> >> If you could try checking that as well, it would be appreciated.
> >
> > Sure, but I'm lost as to what I should test.
> > There are several patches, and multiple versions, in the mailing list.
> >
> > What should be tested on top of the for-next branch?
>
> v4 is the latest version of this patch, which is based on the mainline
> master. As you reported that you were able to make btrfs/159 fail with
> this patch at v2, v4 of this patch theoretically fixes the bug you
> reported. So, I wanted to know if you are still able to reproduce
> the bug with v4?
>
> Test case:
> ./check btrfs/14[6-9] btrfs/15[8-9]
>
> Thanks.
>
> >
> > Thanks.
> >
> >>
> >> David,
> >>
> >> If everything is good with v4, would you like v5 with the RFC
> >> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
> >> it could be done during integration? I'm fine either way.
> >>
> >> Thanks,
> >> Anand
> >>
> >> On 3/7/24 16:38, Anand Jain wrote:
> >>> There are reports that since version 6.7 update-grub fails to find th=
e
> >>> device of the root on systems without initrd and on a single device.
> >>>
> >>> This looks like the device name changed in the output of
> >>> /proc/self/mountinfo:
> >>>
> >>> 6.5-rc5 working
> >>>
> >>>     18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> >>>
> >>> 6.7 not working:
> >>>
> >>>     17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> >>>
> >>> and "update-grub" shows this error:
> >>>
> >>>     /usr/sbin/grub-probe: error: cannot find a device for / (is /dev =
mounted?)
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
> >>> filesystem remains the same and the matching is based on device major=
:minor
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
> >>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single=
 device filesystem")
> >>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> >>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokr=
WK2gisPKDZLs8Y2TQ@mail.gmail.com/
> >>> Tested-by: Alex Romosan <aromosan@gmail.com>
> >>> Tested-by: CHECK_1234543212345@protonmail.com
> >>> Reviewed-by: David Sterba <dsterba@suse.com>
> >>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>> ---
> >>> v4:
> >>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the R=
FC stage.
> >>> I need this patch verified by the bug filer.
> >>> Use devt from bdev->bd_dev
> >>> Rebased on mainline kernel.org master branch
> >>>
> >>> v3:
> >>> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d29=
7ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
> >>>
> >>>    fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++----=
----
> >>>    1 file changed, 47 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>> index d67785be2c77..75bfef1b973b 100644
> >>> --- a/fs/btrfs/volumes.c
> >>> +++ b/fs/btrfs/volumes.c
> >>> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
> >>>        return ret;
> >>>    }
> >>>
> >>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_s=
uper,
> >>> +                                 const char *path, dev_t devt,
> >>> +                                 bool mount_arg_dev)
> >>> +{
> >>> +     struct btrfs_fs_devices *fs_devices;
> >>> +
> >>> +     /*
> >>> +      * Do not skip device registration for mounted devices with mat=
ching
> >>> +      * maj:min but different paths. Booting without initrd relies o=
n
> >>> +      * /dev/root initially, later replaced with the actual root dev=
ice.
> >>> +      * A successful scan ensures update-grub selects the correct de=
vice.
> >>> +      */
> >>> +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> >>> +             struct btrfs_device *device;
> >>> +
> >>> +             mutex_lock(&fs_devices->device_list_mutex);
> >>> +
> >>> +             if (!fs_devices->opened) {
> >>> +                     mutex_unlock(&fs_devices->device_list_mutex);
> >>> +                     continue;
> >>> +             }
> >>> +
> >>> +             list_for_each_entry(device, &fs_devices->devices, dev_l=
ist) {
> >>> +                     if ((device->devt =3D=3D devt) &&
> >>> +                         strcmp(device->name->str, path)) {
> >>> +                             mutex_unlock(&fs_devices->device_list_m=
utex);
> >>> +
> >>> +                             /* Do not skip registration */
> >>> +                             return false;
> >>> +                     }
> >>> +             }
> >>> +             mutex_unlock(&fs_devices->device_list_mutex);
> >>> +     }
> >>> +
> >>> +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=
=3D 1 &&
> >>> +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)=
)
> >>> +             return true;
> >>> +
> >>> +     return false;
> >>> +}
> >>> +
> >>>    /*
> >>>     * Look for a btrfs signature on a device. This may be called out =
of the mount path
> >>>     * and we are not allowed to call set_blocksize during the scan. T=
he superblock
> >>> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(co=
nst char *path, blk_mode_t flags,
> >>>                goto error_bdev_put;
> >>>        }
> >>>
> >>> -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=
=3D 1 &&
> >>> -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)=
) {
> >>> -             dev_t devt;
> >>> +     if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev=
->bd_dev,
> >>> +                                 mount_arg_dev)) {
> >>> +             pr_debug("BTRFS: skip registering single non-seed devic=
e %s (%d:%d)\n",
> >>> +                       path, MAJOR(bdev_handle->bdev->bd_dev),
> >>> +                       MINOR(bdev_handle->bdev->bd_dev));
> >>>
> >>> -             ret =3D lookup_bdev(path, &devt);
> >>> -             if (ret)
> >>> -                     btrfs_warn(NULL, "lookup bdev failed for path %=
s: %d",
> >>> -                                path, ret);
> >>> -             else
> >>> -                     btrfs_free_stale_devices(devt, NULL);
> >>> +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NUL=
L);
> >>>
> >>> -             pr_debug("BTRFS: skip registering single non-seed devic=
e %s\n", path);
> >>>                device =3D NULL;
> >>>                goto free_disk_super;
> >>>        }
> >>

