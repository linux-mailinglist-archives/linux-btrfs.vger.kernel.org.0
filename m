Return-Path: <linux-btrfs+bounces-3159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ABB8777B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9343828120A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158AC38384;
	Sun, 10 Mar 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMX+jqss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B22374D1
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710090708; cv=none; b=jMFfI+NM0asNCy1qzYMJcvjBBNtHn6GUXkCtUfCwu6QWAUZ1W3ZNys+EtKoY5yxCA2SHigx2TevvAzufjEb3hA4CXsF83DiCU9dHZvqsELCtn9aM5uvNcQC3H6S5V2pcvMkyjH7RtnK6wQh6bpapIUpFPCnmV2AcaXoIDIkH24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710090708; c=relaxed/simple;
	bh=zwLOQ7RHjUOzKN42q1bQ/HT4rcNijUFSyv9oYOBWH8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojIzCTX7du7OplXt8C8x18tGzS9tmPt6pG5Bu1KW1spNdzV4zfXvOXJ8tUJD9LeEIvahYCc1S5bdnWEDKaC3kb9RUmIATOeu847UMWkWhjVbAV/9cNKB+ijakR/ojcjtKqdN5EhflqTnGLBJdGIJ6yY9D5CiL8SzmId9O1lLORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMX+jqss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE774C433C7
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710090707;
	bh=zwLOQ7RHjUOzKN42q1bQ/HT4rcNijUFSyv9oYOBWH8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aMX+jqsstnf4PfAyCuxE+NTe6916h//MUdWYgCAbEvvG2KjCy8J9ZrsDE3sQgbngy
	 k2SYevf7VgeUMdP5wFC8mbW/iYzrKE6wlw8RF2hk6ADHzSpQVxIfKddjgwZNi5XjW6
	 WOvXAP3oNuOexPbeNj6B6NBf1GX6ex2xkogThJdd8HlyIZziJxQW4n+mqrez62Iz96
	 52C6050t0FsE5Hw0gKzoQxMgXtwU2UBMrVULPLYcZhYhWdWe7uqBuvBZH/jch0WU+f
	 quW2asBgpYcr4dO+Ma/AbDvTfmSbXSU0WyWd20eumqMChF1yVXcQn/BZRhFrSI554F
	 +ST/+iZYIFonQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44e3176120so458144266b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 10:11:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX34EvRnT/r0pVCdiImx9KvMTW76YOak5IcEZTjMgO/u1qxC/o5tIt56890seIqYLE7cF1g6VKl7p7zQU/RMITelQ0ax7s0r49Zvmw=
X-Gm-Message-State: AOJu0YzBuo8ielsxX8EpC9UiOJx6AkFsomYCsveigXYeCs9fv015O//M
	mqN4MNO8Ysnsdyz3Z1fylbaDbYaTeVQpXioaHg0jxJOHZfHUk2MDCcNyenk17v5mIuvaSrGkrDH
	zGALHQRJTjdLDMuQBVa+1TGpqn9Q=
X-Google-Smtp-Source: AGHT+IHPlDxdAzEYpMF+2iwzEJLiAiKt92CpEcekEiIk1bZn7UG7bK7w41sQZhc3tHSiijMZDfSslqjcSTsOjhJNLb4=
X-Received: by 2002:a17:906:853:b0:a45:aacb:349b with SMTP id
 f19-20020a170906085300b00a45aacb349bmr2592246ejd.16.1710090706097; Sun, 10
 Mar 2024 10:11:46 -0700 (PDT)
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
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 10 Mar 2024 17:11:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6g_D-UJKkudx99NnCiQxj1J8KsME+smCDcQ62ddFA6Pw@mail.gmail.com>
Message-ID: <CAL3q7H6g_D-UJKkudx99NnCiQxj1J8KsME+smCDcQ62ddFA6Pw@mail.gmail.com>
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, CHECK_1234543212345@protonmail.com, 
	linux-btrfs@vger.kernel.org, aromosan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:52=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
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

No, running all fstests doesn't trigger the bug with v4.

>
> Test case:
> ./check btrfs/14[6-9] btrfs/15[8-9]

Yeah, I know, I reported it and provided the "reproducer"...

Thanks.

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

