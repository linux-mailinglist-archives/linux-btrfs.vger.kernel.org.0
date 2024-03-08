Return-Path: <linux-btrfs+bounces-3107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF94876776
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA6C1F215DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403B2032A;
	Fri,  8 Mar 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJBCjZW/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529801EA80
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912240; cv=none; b=beiCd/FfOlnan6lh9H72s4ZwHcJea1tvgps0+mbqjJr6bQLld9pWnAOx0sMVXFvVOwmqettBsmp1zGGeU119exWdWmg8FAsgUrgCdLC7BDDtD3EH7bf2swey33AUdI8R1IH54kOewQs8EuOIzII1fModBqVWTmPoEhUFIs5KUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912240; c=relaxed/simple;
	bh=Lk0fIN1zmiZZfqcnWENQsiTEuc2AlyvM2MVmmT38flM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5NY7EGQtXTYVzdrtpdH8xhfhxqTcBzV1aCA8y77Lu3YGk/a2DzbmrTy3LCGl+ALQNqg5dnTGV631tRCgKh+QU3Jy3S17xu3hsannBxNH0fMfcft5viXlyzI+IhOmFHYRMv5NzR6cFMM+Q2aM1jUBJ1SKGzGxnr//CDlS5bbqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJBCjZW/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2142513276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709912237; x=1710517037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NERqwV/LGL3MjjGTrkjk/ODMm2iqshNJTxDDka+Teio=;
        b=OJBCjZW/S4NmPJp6/qI8C3CG6LlykkEA4/jHzS1S+x01XgygQE8/DexEpIOPag6QnM
         CIq5TjuHTfxaTeTeMEA3PQbLcVtS8hk2Flo3Ioc2MOMlQ+INywMDFGfNMB2vK54YIlHs
         3X3YNnoxr1HTOAlQrzOj9ic8wexpJGOEkbncCASXuE8NUO4GCwIXjiOxJtEArDgc0jgt
         J2LwEAoPfaH8uuuR+o3Q89NMUybkrMx2s2oSpK1dQcpjsX6fKeiMFJFzOjh6UzOIiN3l
         /ZlgFAQ6MFlkG6im624t2Z82CQ/SMIY5lhOjh0tSCfiBhEhc2H6Js0hnpw5C3BpKVqCk
         jl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709912237; x=1710517037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NERqwV/LGL3MjjGTrkjk/ODMm2iqshNJTxDDka+Teio=;
        b=FCzojKfrf9enBjsbPrEic01QSDX+mDSWhQTyR/IdXXtu4UTYwNgNCn/noXmIIUir5G
         C4oUFuZ49mpLu3BWo+RW/8emeCejsjizmGh9f8GeNEdQZ1fWbaF35cBTlCHe5bXmUV0W
         VLizOR69ItizE+MVIjPzYaHN/0pporzPpTFGGLsGqK881xh7CuKSssd+8twhFvsQ+vCb
         qeK4J/loE9kA7h4FmGPCYoKyGJ4FvVQY0AmsZyxra9ax87XluLppEkTXaYNlid+e0tIh
         ip41puvhzrrdEQ9TWcU/6TSHFGv8dUJDlXQ5Th0YpDW6Nrax5aDZa7vwiZdxbTTdtdY2
         33VA==
X-Forwarded-Encrypted: i=1; AJvYcCViVi0zUei61Lads+gwoXJlHOaIi++rJOYEmCSaQfTDUXsZEXC7zEt2wsZmZTAJLqO2FVRJ9cckyIT+oOGploQn0y5CQQ87J8rYjVc=
X-Gm-Message-State: AOJu0YzxWxD5TGUTCYqmOffT5PpRT6xz9959sDLP1gLnkkE+ugR+EDuC
	p1apMSg+aeyhQ/mAS+y5MBMYv/K1WdhHOTH0JkP2a3ItWgeC3XZAFciETUdtTjvutbpuNFdV05B
	aivAg/1Mc/lolDavYP92hVusEVN4=
X-Google-Smtp-Source: AGHT+IHJEe0bdOH7/SPa0cPMYhgdxLbQ3R5E1u8X5n3F3ZbNBkAHpwvBI0GeeocyLSkGGO9JfyZKY/oMHiuJV/wZ4tg=
X-Received: by 2002:a25:abb3:0:b0:dcf:ad31:57c9 with SMTP id
 v48-20020a25abb3000000b00dcfad3157c9mr19488999ybi.0.1709912237091; Fri, 08
 Mar 2024 07:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com> <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
 <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com> <CAKLYgeJDQHTWj4U_SBLRK6ssoTJEkn9_EdZXWPgTfkK6s87H1A@mail.gmail.com>
 <5f3eec2f-d59f-4a2e-a219-770ce3bd02a6@oracle.com>
In-Reply-To: <5f3eec2f-d59f-4a2e-a219-770ce3bd02a6@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Fri, 8 Mar 2024 16:37:06 +0100
Message-ID: <CAKLYgeLgp4=QxmSEZS1+eUhdfjh-S-hu+HgtFeq51-jgj2EGTQ@mail.gmail.com>
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>, 
	CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

confirming that update-grub works with v4 of the patch. these are the
relevant entries in the log:

Btrfs loaded, debug=3Don, zoned=3Dno, fsverity=3Dno
BTRFS: device fsid 695aa7ac-862a-4de3-ae59-c96f784600a0 devid 1
transid 2026388 /dev/root scanned by swapper/0 (1)
BTRFS info (device nvme0n1p3): first mount of filesystem
695aa7ac-862a-4de3-ae59-c96f784600a0
BTRFS info (device nvme0n1p3): using crc32c (crc32c-generic) checksum algor=
ithm
BTRFS info (device nvme0n1p3): using free-space-tree
VFS: Mounted root (btrfs filesystem) readonly on device 0:19.
BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
scanned by (udev-worker) (279)


On Fri, Mar 8, 2024 at 3:37=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
> Sure.
> Here is the link to the latest version of the patch, which is v4.
> It is based on the mainline master.
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/65a11e853a31b18b62=
0f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com/
>
> Thanks, Anand
>
> On 3/8/24 20:02, Alex Romosan wrote:
> > sorry about the previous html mail.
> >
> > Just to eliminate any confusion, can you please provide either a link
> > to v4 of the patch or include it in the reply to this and explicitly
> > labeled as such? I am beginning to have doubts as to the version I was
> > testing. Thanks
> >
> > On Fri, Mar 8, 2024 at 2:52=E2=80=AFPM Anand Jain <anand.jain@oracle.co=
m> wrote:
> >>
> >>
> >>
> >> On 3/8/24 17:45, Filipe Manana wrote:
> >>> On Fri, Mar 8, 2024 at 2:28=E2=80=AFAM Anand Jain <anand.jain@oracle.=
com> wrote:
> >>>>
> >>>> Filipe,
> >>>>
> >>>> We've received confirmation from the user that the original update-g=
rub
> >>>> issue has been fixed. Additionally, your reported issue using
> >>>> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
> >>>>
> >>>> However, reproducing the bug has been inconsistent on my systems.
> >>>> If you could try checking that as well, it would be appreciated.
> >>>
> >>> Sure, but I'm lost as to what I should test.
> >>> There are several patches, and multiple versions, in the mailing list=
.
> >>>
> >>> What should be tested on top of the for-next branch?
> >>
> >> v4 is the latest version of this patch, which is based on the mainline
> >> master. As you reported that you were able to make btrfs/159 fail with
> >> this patch at v2, v4 of this patch theoretically fixes the bug you
> >> reported. So, I wanted to know if you are still able to reproduce
> >> the bug with v4?
> >>
> >> Test case:
> >> ./check btrfs/14[6-9] btrfs/15[8-9]
> >>
> >> Thanks.
> >>
> >>>
> >>> Thanks.
> >>>
> >>>>
> >>>> David,
> >>>>
> >>>> If everything is good with v4, would you like v5 with the RFC
> >>>> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
> >>>> it could be done during integration? I'm fine either way.
> >>>>
> >>>> Thanks,
> >>>> Anand
> >>>>
> >>>> On 3/7/24 16:38, Anand Jain wrote:
> >>>>> There are reports that since version 6.7 update-grub fails to find =
the
> >>>>> device of the root on systems without initrd and on a single device=
.
> >>>>>
> >>>>> This looks like the device name changed in the output of
> >>>>> /proc/self/mountinfo:
> >>>>>
> >>>>> 6.5-rc5 working
> >>>>>
> >>>>>      18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> >>>>>
> >>>>> 6.7 not working:
> >>>>>
> >>>>>      17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> >>>>>
> >>>>> and "update-grub" shows this error:
> >>>>>
> >>>>>      /usr/sbin/grub-probe: error: cannot find a device for / (is /d=
ev mounted?)
> >>>>>
> >>>>> This looks like it's related to the device name, but grub-probe
> >>>>> recognizes the "/dev/root" path and tries to find the underlying de=
vice.
> >>>>> However there's a special case for some filesystems, for btrfs in
> >>>>> particular.
> >>>>>
> >>>>> The generic root device detection heuristic is not done and it all
> >>>>> relies on reading the device infos by a btrfs specific ioctl. This =
ioctl
> >>>>> returns the device name as it was saved at the time of device scan =
(in
> >>>>> this case it's /dev/root).
> >>>>>
> >>>>> The change in 6.7 for temp_fsid to allow several single device
> >>>>> filesystem to exist with the same fsid (and transparently generate =
a new
> >>>>> UUID at mount time) was to skip caching/registering such devices.
> >>>>>
> >>>>> This also skipped mounted device. One step of scanning is to check =
if
> >>>>> the device name hasn't changed, and if yes then update the cached v=
alue.
> >>>>>
> >>>>> This broke the grub-probe as it always read the device /dev/root an=
d
> >>>>> couldn't find it in the system. A temporary workaround is to create=
 a
> >>>>> symlink but this does not survive reboot.
> >>>>>
> >>>>> The right fix is to allow updating the device path of a mounted
> >>>>> filesystem even if this is a single device one.
> >>>>>
> >>>>> In the fix, check if the device's major:minor number matches with t=
he
> >>>>> cached device. If they do, then we can allow the scan to happen so =
that
> >>>>> device_list_add() can take care of updating the device path. The fi=
le
> >>>>> descriptor remains unchanged.
> >>>>>
> >>>>> This does not affect the temp_fsid feature, the UUID of the mounted
> >>>>> filesystem remains the same and the matching is based on device maj=
or:minor
> >>>>> which is unique per mounted filesystem.
> >>>>>
> >>>>> This covers the path when the device (that exists for all mounted
> >>>>> devices) name changes, updating /dev/root to /dev/sdx. Any other si=
ngle
> >>>>> device with filesystem and is not mounted is still skipped.
> >>>>>
> >>>>> Note that if a system is booted and initial mount is done on the
> >>>>> /dev/root device, this will be the cached name of the device. Only =
after
> >>>>> the command "btrfs device scan" it will change as it triggers the
> >>>>> rename.
> >>>>>
> >>>>> The fix was verified by users whose systems were affected.
> >>>>>
> >>>>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on sing=
le device filesystem")
> >>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> >>>>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEio=
krWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> >>>>> Tested-by: Alex Romosan <aromosan@gmail.com>
> >>>>> Tested-by: CHECK_1234543212345@protonmail.com
> >>>>> Reviewed-by: David Sterba <dsterba@suse.com>
> >>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>>>> ---
> >>>>> v4:
> >>>>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the=
 RFC stage.
> >>>>> I need this patch verified by the bug filer.
> >>>>> Use devt from bdev->bd_dev
> >>>>> Rebased on mainline kernel.org master branch
> >>>>>
> >>>>> v3:
> >>>>> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d=
297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
> >>>>>
> >>>>>     fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++-=
-------
> >>>>>     1 file changed, 47 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>>> index d67785be2c77..75bfef1b973b 100644
> >>>>> --- a/fs/btrfs/volumes.c
> >>>>> +++ b/fs/btrfs/volumes.c
> >>>>> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
> >>>>>         return ret;
> >>>>>     }
> >>>>>
> >>>>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk=
_super,
> >>>>> +                                 const char *path, dev_t devt,
> >>>>> +                                 bool mount_arg_dev)
> >>>>> +{
> >>>>> +     struct btrfs_fs_devices *fs_devices;
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Do not skip device registration for mounted devices with m=
atching
> >>>>> +      * maj:min but different paths. Booting without initrd relies=
 on
> >>>>> +      * /dev/root initially, later replaced with the actual root d=
evice.
> >>>>> +      * A successful scan ensures update-grub selects the correct =
device.
> >>>>> +      */
> >>>>> +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> >>>>> +             struct btrfs_device *device;
> >>>>> +
> >>>>> +             mutex_lock(&fs_devices->device_list_mutex);
> >>>>> +
> >>>>> +             if (!fs_devices->opened) {
> >>>>> +                     mutex_unlock(&fs_devices->device_list_mutex);
> >>>>> +                     continue;
> >>>>> +             }
> >>>>> +
> >>>>> +             list_for_each_entry(device, &fs_devices->devices, dev=
_list) {
> >>>>> +                     if ((device->devt =3D=3D devt) &&
> >>>>> +                         strcmp(device->name->str, path)) {
> >>>>> +                             mutex_unlock(&fs_devices->device_list=
_mutex);
> >>>>> +
> >>>>> +                             /* Do not skip registration */
> >>>>> +                             return false;
> >>>>> +                     }
> >>>>> +             }
> >>>>> +             mutex_unlock(&fs_devices->device_list_mutex);
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=
=3D 1 &&
> >>>>> +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDIN=
G))
> >>>>> +             return true;
> >>>>> +
> >>>>> +     return false;
> >>>>> +}
> >>>>> +
> >>>>>     /*
> >>>>>      * Look for a btrfs signature on a device. This may be called o=
ut of the mount path
> >>>>>      * and we are not allowed to call set_blocksize during the scan=
. The superblock
> >>>>> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(=
const char *path, blk_mode_t flags,
> >>>>>                 goto error_bdev_put;
> >>>>>         }
> >>>>>
> >>>>> -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =3D=
=3D 1 &&
> >>>>> -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDIN=
G)) {
> >>>>> -             dev_t devt;
> >>>>> +     if (btrfs_skip_registration(disk_super, path, bdev_handle->bd=
ev->bd_dev,
> >>>>> +                                 mount_arg_dev)) {
> >>>>> +             pr_debug("BTRFS: skip registering single non-seed dev=
ice %s (%d:%d)\n",
> >>>>> +                       path, MAJOR(bdev_handle->bdev->bd_dev),
> >>>>> +                       MINOR(bdev_handle->bdev->bd_dev));
> >>>>>
> >>>>> -             ret =3D lookup_bdev(path, &devt);
> >>>>> -             if (ret)
> >>>>> -                     btrfs_warn(NULL, "lookup bdev failed for path=
 %s: %d",
> >>>>> -                                path, ret);
> >>>>> -             else
> >>>>> -                     btrfs_free_stale_devices(devt, NULL);
> >>>>> +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, N=
ULL);
> >>>>>
> >>>>> -             pr_debug("BTRFS: skip registering single non-seed dev=
ice %s\n", path);
> >>>>>                 device =3D NULL;
> >>>>>                 goto free_disk_super;
> >>>>>         }
> >>>>

