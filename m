Return-Path: <linux-btrfs+bounces-3099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63DC876422
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 13:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C4284D6E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 12:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D457879;
	Fri,  8 Mar 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEUZCJUa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC56776
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900185; cv=none; b=N7k3HaFDCWXpE8r+648ZuZcckgmdO/4dzTRbNz3HUFmqvl5rktWgn1V2vcQorGXoH/uQ6fJEtfXgYhdccg1eRRgQPM3LKMHR00DoGY7RxKjk2om/KRKf0kzxnIWlNXHJz7xiSg6/BM6Idh5sA+Oq+Q+IyfbGG9MLEFxGlfXFTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900185; c=relaxed/simple;
	bh=37Kqe3/ChpSR48c0Mdvp3IP0PFNv3pdkedx3aU2r/Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDK8yKWX0WTwcnQ36jBU28VPtkZfWghtLpYkmaOrRHqIJZ4BBvaz8LzvBaSthHqL5e9XpsZ5Z5/t9q8LUEnii1oYU0bB2nG+zj/uSWJyPkIDoEsDFkjEUmHzvNpzO2IvjUD86CRHCq0KQPcyDIQexOf+JPPr5wSfUhWF8fsZG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEUZCJUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B26C43394
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709900183;
	bh=37Kqe3/ChpSR48c0Mdvp3IP0PFNv3pdkedx3aU2r/Y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vEUZCJUakC7gO+k1WlXzvj9abegniFhhjyS+fQVRdMQS+oWYLmzlMwvIV7ouvyc1r
	 M1DMar38l5famPTlHJ3xP1x3tez98yQImqrBSTFbO88zj1/8yo3W+bnJYEx9/G4aVd
	 bmiyTcaJ+i+pRVqqjio4wgThfEzuBfQXaDBlkzkvcWPf0TWsgQEyXtFpjm3dR0GYwU
	 GEXNE9BNSxVRLIPcJv9+5nJsF7m3PNw1gefciyqJ0pcer/LCYTwaRBu4fDmC5n6vgD
	 jpB6EIKRYJr4iG1ll6ELuZmHZHWyZsls5tuAf6btBp+79C1LhLgaPllilVSL3llNOK
	 ZdPdeOBWQsJ9w==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a458eb7db13so295704566b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 04:16:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmuVqkGCSH+ZAcOvH+jAMfPPqPUgLZP37rxyUIJFftvpG40CfjBIlO2yTXlUSXYiqrTBvDFBbGPGdei9PisH2fhiqS+SAV7Zx7D2o=
X-Gm-Message-State: AOJu0Yyp96HjZhzgH4gr/H7mBvlaU6YJr53QSUdGPgfDQ8eGBFyT31OH
	p2VqwMc4xicsylyiSs/nIuYpiNrPfiJhrGYYxwa6PcuRrKVJl81CKBZ53D6RkbSG3e0J2PERF2C
	J5rlO167Nv8A2SujVWEK+toDOX4o=
X-Google-Smtp-Source: AGHT+IHaEhsAfEaSVEkmHS1UJ0pZpJJK3SdzFz7ssVrg4l0e2o/6kufIInGgj9SNv45QK/EcvTK+SxzX7mMCD0a1Oak=
X-Received: by 2002:a17:907:a0ce:b0:a45:ed7f:265c with SMTP id
 hw14-20020a170907a0ce00b00a45ed7f265cmr1376709ejc.0.1709900181958; Fri, 08
 Mar 2024 04:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
In-Reply-To: <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 8 Mar 2024 12:15:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
Message-ID: <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, CHECK_1234543212345@protonmail.com, 
	linux-btrfs@vger.kernel.org, aromosan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 2:28=E2=80=AFAM Anand Jain <anand.jain@oracle.com> w=
rote:
>
> Filipe,
>
> We've received confirmation from the user that the original update-grub
> issue has been fixed. Additionally, your reported issue using
> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
>
> However, reproducing the bug has been inconsistent on my systems.
> If you could try checking that as well, it would be appreciated.

Sure, but I'm lost as to what I should test.
There are several patches, and multiple versions, in the mailing list.

What should be tested on top of the for-next branch?

Thanks.

>
> David,
>
> If everything is good with v4, would you like v5 with the RFC
> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
> it could be done during integration? I'm fine either way.
>
> Thanks,
> Anand
>
> On 3/7/24 16:38, Anand Jain wrote:
> > There are reports that since version 6.7 update-grub fails to find the
> > device of the root on systems without initrd and on a single device.
> >
> > This looks like the device name changed in the output of
> > /proc/self/mountinfo:
> >
> > 6.5-rc5 working
> >
> >    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> >
> > 6.7 not working:
> >
> >    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> >
> > and "update-grub" shows this error:
> >
> >    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mou=
nted?)
> >
> > This looks like it's related to the device name, but grub-probe
> > recognizes the "/dev/root" path and tries to find the underlying device=
.
> > However there's a special case for some filesystems, for btrfs in
> > particular.
> >
> > The generic root device detection heuristic is not done and it all
> > relies on reading the device infos by a btrfs specific ioctl. This ioct=
l
> > returns the device name as it was saved at the time of device scan (in
> > this case it's /dev/root).
> >
> > The change in 6.7 for temp_fsid to allow several single device
> > filesystem to exist with the same fsid (and transparently generate a ne=
w
> > UUID at mount time) was to skip caching/registering such devices.
> >
> > This also skipped mounted device. One step of scanning is to check if
> > the device name hasn't changed, and if yes then update the cached value=
.
> >
> > This broke the grub-probe as it always read the device /dev/root and
> > couldn't find it in the system. A temporary workaround is to create a
> > symlink but this does not survive reboot.
> >
> > The right fix is to allow updating the device path of a mounted
> > filesystem even if this is a single device one.
> >
> > In the fix, check if the device's major:minor number matches with the
> > cached device. If they do, then we can allow the scan to happen so that
> > device_list_add() can take care of updating the device path. The file
> > descriptor remains unchanged.
> >
> > This does not affect the temp_fsid feature, the UUID of the mounted
> > filesystem remains the same and the matching is based on device major:m=
inor
> > which is unique per mounted filesystem.
> >
> > This covers the path when the device (that exists for all mounted
> > devices) name changes, updating /dev/root to /dev/sdx. Any other single
> > device with filesystem and is not mounted is still skipped.
> >
> > Note that if a system is booted and initial mount is done on the
> > /dev/root device, this will be the cached name of the device. Only afte=
r
> > the command "btrfs device scan" it will change as it triggers the
> > rename.
> >
> > The fix was verified by users whose systems were affected.
> >
> > Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single d=
evice filesystem")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> > Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK=
2gisPKDZLs8Y2TQ@mail.gmail.com/
> > Tested-by: Alex Romosan <aromosan@gmail.com>
> > Tested-by: CHECK_1234543212345@protonmail.com
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v4:
> > I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC=
 stage.
> > I need this patch verified by the bug filer.
> > Use devt from bdev->bd_dev
> > Rebased on mainline kernel.org master branch
> >
> > v3:
> > https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297a=
d87d0.1709782041.git.anand.jain@oracle.com/T/#u
> >
> >   fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 47 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index d67785be2c77..75bfef1b973b 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
> >       return ret;
> >   }
> >
> > +static bool btrfs_skip_registration(struct btrfs_super_block *disk_sup=
er,
> > +                                 const char *path, dev_t devt,
> > +                                 bool mount_arg_dev)
> > +{
> > +     struct btrfs_fs_devices *fs_devices;
> > +
> > +     /*
> > +      * Do not skip device registration for mounted devices with match=
ing
> > +      * maj:min but different paths. Booting without initrd relies on
> > +      * /dev/root initially, later replaced with the actual root devic=
e.
> > +      * A successful scan ensures update-grub selects the correct devi=
ce.
> > +      */
> > +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> > +             struct btrfs_device *device;
> > +
> > +             mutex_lock(&fs_devices->device_list_mutex);
> > +
> > +             if (!fs_devices->opened) {
> > +                     mutex_unlock(&fs_devices->device_list_mutex);
> > +                     continue;
> > +             }
> > +
> > +             list_for_each_entry(device, &fs_devices->devices, dev_lis=
t) {
> > +                     if ((device->devt =3D=3D devt) &&
> > +                         strcmp(device->name->str, path)) {
> > +                             mutex_unlock(&fs_devices->device_list_mut=
ex);
> > +
> > +                             /* Do not skip registration */
> > +                             return false;
> > +                     }
> > +             }
> > +             mutex_unlock(&fs_devices->device_list_mutex);
> > +     }
> > +
> > +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=3D =
1 &&
> > +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   /*
> >    * Look for a btrfs signature on a device. This may be called out of =
the mount path
> >    * and we are not allowed to call set_blocksize during the scan. The =
superblock
> > @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(cons=
t char *path, blk_mode_t flags,
> >               goto error_bdev_put;
> >       }
> >
> > -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=3D =
1 &&
> > -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) =
{
> > -             dev_t devt;
> > +     if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->=
bd_dev,
> > +                                 mount_arg_dev)) {
> > +             pr_debug("BTRFS: skip registering single non-seed device =
%s (%d:%d)\n",
> > +                       path, MAJOR(bdev_handle->bdev->bd_dev),
> > +                       MINOR(bdev_handle->bdev->bd_dev));
> >
> > -             ret =3D lookup_bdev(path, &devt);
> > -             if (ret)
> > -                     btrfs_warn(NULL, "lookup bdev failed for path %s:=
 %d",
> > -                                path, ret);
> > -             else
> > -                     btrfs_free_stale_devices(devt, NULL);
> > +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL)=
;
> >
> > -             pr_debug("BTRFS: skip registering single non-seed device =
%s\n", path);
> >               device =3D NULL;
> >               goto free_disk_super;
> >       }
>

