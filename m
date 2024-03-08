Return-Path: <linux-btrfs+bounces-3110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195338767D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972E42830EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80A23772;
	Fri,  8 Mar 2024 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUywWBXY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B21DDFC
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913275; cv=none; b=oUT9fUZGd9StmJfmmYf1F5JFTKuXZuOZBYflX71pQHb5Vs9/UhqVjgh2795wXM4m3If8HNnYB1AK3nOGeUT03oepA5Gth8YovH2bLWzs0IV6nBpyKsPf9e295d+TIsRq1fFZ7bqnFohrNStsrJ1uaaDeKNGjJnwaF7zfqKW4z+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913275; c=relaxed/simple;
	bh=mcn+eGHwyKa8PLpgKx1F6AGJHSgeg+b6P8kOmLe7QVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INxeZbLBjd5lTLyAr23gDWLJR4a4cAuCCowJVV5R+3nO7It2k1VKJ0PCfR62PF5deJfHarqG+94p6MNbSLrw7cruGG3UYwkBCTkekHkkW0lA569gj8ADG/ow//iRrpbxXbSgDK0xT9AkvfwDN71dlI+Q2GqQZ5pBOIHF7k/A/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUywWBXY; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso2233562276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 07:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709913272; x=1710518072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv3Kv1pGqZ1ir0PSkKXz7trL2BZzgS7Oofr8TBTJWV0=;
        b=aUywWBXYFnG4O2/jtPa7rJzcBC6W9o6L0TOD/nbJZ4BTPicVqq+J9fUkxQQyIZT7IZ
         UPau48WFXobTIAkyGL4mHBzmB8E4+wma4Ip/OCuHsNvks6rhDRo6Uk67HU+0yDw7rWiZ
         Bx5gNPDd/nvSGvS0+rN5lLwpRGWz8zOiB4eY58iguRlln0nirWB4BvZmpyu4/RBxunj5
         UtLplBsYksKdZsLPEffO1kUsDf1FVH9DSyQsSfmV3db2Nipw6f6Y070JCcW0/OtovIxK
         vkNKhigft/VWBeYG5q6se+0kby76+zKKLurI/wJMz1B19StzwXQYKIJtCQkNuLb4gqM5
         A22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709913272; x=1710518072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv3Kv1pGqZ1ir0PSkKXz7trL2BZzgS7Oofr8TBTJWV0=;
        b=mMt6yKEewFyF/IoDTxC7wJEiiFhvXI3hxSU1eYqs1wDG1wYkiWcBtpA9AMDsCzVjWL
         0pMGrXX6s3iV1AjK/j2+5Bj5Cqe9NfYJ8oAX0Cu6aEVii8Opyh114TjzH+ljkn6iCC6q
         sljqE+rYEuTcUngykt7j3S58aFnMxZsnoAcRoqxD3FdXqeUp0vP2ah96Thx9sM04/4Ln
         2UK58CggFTcotimacntKDPKoVpiadHbHI+nioTChJnbBDc4YPDPeCX58Ycaayg87BFY3
         +9bdGUjltd2MAy289CJpn6QgMKgl885pYKHLkLJ32EhnE1ifB3jHo5ejD0auT56h5258
         OMmw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Kw5izsfcBS4RSv8KFjtJYnjEp9MkBoZ61u5M2u99pe3sYGoq/dXGweW+rlisac+OIGqLPbffuEdHnK1N1vhJVBBk1W7ku38HWrQ=
X-Gm-Message-State: AOJu0YwReN8quXf436U12iEePu1YQMveGG0fnqwe7++c3jCk+zZ0K3G9
	72rD8aC5VT2XfUR1/5xRUEyc0NBxC8C1m6dHRSwoWjQGlxISeauz00uMfkspjkrUFVzcurYeiGZ
	Hj0ew3FfqMvc0yM2v+YEFvEPrrpQ=
X-Google-Smtp-Source: AGHT+IHNt2b43toVAJksL9GKEL7L0DSteck7bkkVUZsIaOWaQwSyQ5pkznB7iMu8roWc6HgxLQI+ijrqkrpQ5Crn/vo=
X-Received: by 2002:a25:bbc7:0:b0:dcb:ca7e:7e6f with SMTP id
 c7-20020a25bbc7000000b00dcbca7e7e6fmr19385995ybk.55.1709913272131; Fri, 08
 Mar 2024 07:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com> <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
 <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com> <CAKLYgeJDQHTWj4U_SBLRK6ssoTJEkn9_EdZXWPgTfkK6s87H1A@mail.gmail.com>
 <5f3eec2f-d59f-4a2e-a219-770ce3bd02a6@oracle.com> <CAKLYgeLgp4=QxmSEZS1+eUhdfjh-S-hu+HgtFeq51-jgj2EGTQ@mail.gmail.com>
 <9a8f7496-b5ad-45f5-ba0b-5690a8a39fa6@oracle.com>
In-Reply-To: <9a8f7496-b5ad-45f5-ba0b-5690a8a39fa6@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Fri, 8 Mar 2024 16:54:21 +0100
Message-ID: <CAKLYgeJZ2ZS0UAp-Zo4OWACoFuu9vco_X5jhehHA5a1UUssYew@mail.gmail.com>
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>, 
	CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

in my case it doesn't really matter because i have only one device. :-)

On Fri, Mar 8, 2024 at 4:48=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
>
> On 3/8/24 21:07, Alex Romosan wrote:
> > confirming that update-grub works with v4 of the patch. these are the
> > relevant entries in the log:
> >
> > Btrfs loaded, debug=3Don, zoned=3Dno, fsverity=3Dno
> > BTRFS: device fsid 695aa7ac-862a-4de3-ae59-c96f784600a0 devid 1
> > transid 2026388 /dev/root scanned by swapper/0 (1)
> > BTRFS info (device nvme0n1p3): first mount of filesystem
> > 695aa7ac-862a-4de3-ae59-c96f784600a0
> > BTRFS info (device nvme0n1p3): using crc32c (crc32c-generic) checksum a=
lgorithm
> > BTRFS info (device nvme0n1p3): using free-space-tree
> > VFS: Mounted root (btrfs filesystem) readonly on device 0:19.
> > BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
> > scanned by (udev-worker) (279)
>
>
> Thank you for reconfirming and for sharing the logs, which clearly
> depict the device path updates. Additionally, there is a separate
> patch to include the major and minor numbers in these messages,
> enhancing clarity further.
>
> -Anand
>
>
> > On Fri, Mar 8, 2024 at 3:37=E2=80=AFPM Anand Jain <anand.jain@oracle.co=
m> wrote:
> >>
> >>
> >> Sure.
> >> Here is the link to the latest version of the patch, which is v4.
> >> It is based on the mainline master.
> >>
> >> https://patchwork.kernel.org/project/linux-btrfs/patch/65a11e853a31b18=
b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com/
> >>
> >> Thanks, Anand
> >>
> >> On 3/8/24 20:02, Alex Romosan wrote:
> >>> sorry about the previous html mail.
> >>>
> >>> Just to eliminate any confusion, can you please provide either a link
> >>> to v4 of the patch or include it in the reply to this and explicitly
> >>> labeled as such? I am beginning to have doubts as to the version I wa=
s
> >>> testing. Thanks
> >>>
> >>> On Fri, Mar 8, 2024 at 2:52=E2=80=AFPM Anand Jain <anand.jain@oracle.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 3/8/24 17:45, Filipe Manana wrote:
> >>>>> On Fri, Mar 8, 2024 at 2:28=E2=80=AFAM Anand Jain <anand.jain@oracl=
e.com> wrote:
> >>>>>>
> >>>>>> Filipe,
> >>>>>>
> >>>>>> We've received confirmation from the user that the original update=
-grub
> >>>>>> issue has been fixed. Additionally, your reported issue using
> >>>>>> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
> >>>>>>
> >>>>>> However, reproducing the bug has been inconsistent on my systems.
> >>>>>> If you could try checking that as well, it would be appreciated.
> >>>>>
> >>>>> Sure, but I'm lost as to what I should test.
> >>>>> There are several patches, and multiple versions, in the mailing li=
st.
> >>>>>
> >>>>> What should be tested on top of the for-next branch?
> >>>>
> >>>> v4 is the latest version of this patch, which is based on the mainli=
ne
> >>>> master. As you reported that you were able to make btrfs/159 fail wi=
th
> >>>> this patch at v2, v4 of this patch theoretically fixes the bug you
> >>>> reported. So, I wanted to know if you are still able to reproduce
> >>>> the bug with v4?
> >>>>
> >>>> Test case:
> >>>> ./check btrfs/14[6-9] btrfs/15[8-9]
> >>>>
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>>>
> >>>>>> David,
> >>>>>>
> >>>>>> If everything is good with v4, would you like v5 with the RFC
> >>>>>> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
> >>>>>> it could be done during integration? I'm fine either way.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Anand
> >>>>>>
> >>>>>> On 3/7/24 16:38, Anand Jain wrote:
> >>>>>>> There are reports that since version 6.7 update-grub fails to fin=
d the
> >>>>>>> device of the root on systems without initrd and on a single devi=
ce.
> >>>>>>>
> >>>>>>> This looks like the device name changed in the output of
> >>>>>>> /proc/self/mountinfo:
> >>>>>>>
> >>>>>>> 6.5-rc5 working
> >>>>>>>
> >>>>>>>       18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> >>>>>>>
> >>>>>>> 6.7 not working:
> >>>>>>>
> >>>>>>>       17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> >>>>>>>
> >>>>>>> and "update-grub" shows this error:
> >>>>>>>
> >>>>>>>       /usr/sbin/grub-probe: error: cannot find a device for / (is=
 /dev mounted?)
> >>>>>>>
> >>>>>>> This looks like it's related to the device name, but grub-probe
> >>>>>>> recognizes the "/dev/root" path and tries to find the underlying =
device.
> >>>>>>> However there's a special case for some filesystems, for btrfs in
> >>>>>>> particular.
> >>>>>>>
> >>>>>>> The generic root device detection heuristic is not done and it al=
l
> >>>>>>> relies on reading the device infos by a btrfs specific ioctl. Thi=
s ioctl
> >>>>>>> returns the device name as it was saved at the time of device sca=
n (in
> >>>>>>> this case it's /dev/root).
> >>>>>>>
> >>>>>>> The change in 6.7 for temp_fsid to allow several single device
> >>>>>>> filesystem to exist with the same fsid (and transparently generat=
e a new
> >>>>>>> UUID at mount time) was to skip caching/registering such devices.
> >>>>>>>
> >>>>>>> This also skipped mounted device. One step of scanning is to chec=
k if
> >>>>>>> the device name hasn't changed, and if yes then update the cached=
 value.
> >>>>>>>
> >>>>>>> This broke the grub-probe as it always read the device /dev/root =
and
> >>>>>>> couldn't find it in the system. A temporary workaround is to crea=
te a
> >>>>>>> symlink but this does not survive reboot.
> >>>>>>>
> >>>>>>> The right fix is to allow updating the device path of a mounted
> >>>>>>> filesystem even if this is a single device one.
> >>>>>>>
> >>>>>>> In the fix, check if the device's major:minor number matches with=
 the
> >>>>>>> cached device. If they do, then we can allow the scan to happen s=
o that
> >>>>>>> device_list_add() can take care of updating the device path. The =
file
> >>>>>>> descriptor remains unchanged.
> >>>>>>>
> >>>>>>> This does not affect the temp_fsid feature, the UUID of the mount=
ed
> >>>>>>> filesystem remains the same and the matching is based on device m=
ajor:minor
> >>>>>>> which is unique per mounted filesystem.
> >>>>>>>
> >>>>>>> This covers the path when the device (that exists for all mounted
> >>>>>>> devices) name changes, updating /dev/root to /dev/sdx. Any other =
single
> >>>>>>> device with filesystem and is not mounted is still skipped.
> >>>>>>>
> >>>>>>> Note that if a system is booted and initial mount is done on the
> >>>>>>> /dev/root device, this will be the cached name of the device. Onl=
y after
> >>>>>>> the command "btrfs device scan" it will change as it triggers the
> >>>>>>> rename.
> >>>>>>>
> >>>>>>> The fix was verified by users whose systems were affected.
> >>>>>>>
> >>>>>>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on si=
ngle device filesystem")
> >>>>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218353
> >>>>>>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpE=
iokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> >>>>>>> Tested-by: Alex Romosan <aromosan@gmail.com>
> >>>>>>> Tested-by: CHECK_1234543212345@protonmail.com
> >>>>>>> Reviewed-by: David Sterba <dsterba@suse.com>
> >>>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>>>>>> ---
> >>>>>>> v4:
> >>>>>>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in t=
he RFC stage.
> >>>>>>> I need this patch verified by the bug filer.
> >>>>>>> Use devt from bdev->bd_dev
> >>>>>>> Rebased on mainline kernel.org master branch
> >>>>>>>
> >>>>>>> v3:
> >>>>>>> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d2=
1d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
> >>>>>>>
> >>>>>>>      fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++=
++--------
> >>>>>>>      1 file changed, 47 insertions(+), 10 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>>>>> index d67785be2c77..75bfef1b973b 100644
> >>>>>>> --- a/fs/btrfs/volumes.c
> >>>>>>> +++ b/fs/btrfs/volumes.c
> >>>>>>> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
> >>>>>>>          return ret;
> >>>>>>>      }
> >>>>>>>
> >>>>>>> +static bool btrfs_skip_registration(struct btrfs_super_block *di=
sk_super,
> >>>>>>> +                                 const char *path, dev_t devt,
> >>>>>>> +                                 bool mount_arg_dev)
> >>>>>>> +{
> >>>>>>> +     struct btrfs_fs_devices *fs_devices;
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Do not skip device registration for mounted devices with=
 matching
> >>>>>>> +      * maj:min but different paths. Booting without initrd reli=
es on
> >>>>>>> +      * /dev/root initially, later replaced with the actual root=
 device.
> >>>>>>> +      * A successful scan ensures update-grub selects the correc=
t device.
> >>>>>>> +      */
> >>>>>>> +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> >>>>>>> +             struct btrfs_device *device;
> >>>>>>> +
> >>>>>>> +             mutex_lock(&fs_devices->device_list_mutex);
> >>>>>>> +
> >>>>>>> +             if (!fs_devices->opened) {
> >>>>>>> +                     mutex_unlock(&fs_devices->device_list_mutex=
);
> >>>>>>> +                     continue;
> >>>>>>> +             }
> >>>>>>> +
> >>>>>>> +             list_for_each_entry(device, &fs_devices->devices, d=
ev_list) {
> >>>>>>> +                     if ((device->devt =3D=3D devt) &&
> >>>>>>> +                         strcmp(device->name->str, path)) {
> >>>>>>> +                             mutex_unlock(&fs_devices->device_li=
st_mutex);
> >>>>>>> +
> >>>>>>> +                             /* Do not skip registration */
> >>>>>>> +                             return false;
> >>>>>>> +                     }
> >>>>>>> +             }
> >>>>>>> +             mutex_unlock(&fs_devices->device_list_mutex);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =
=3D=3D 1 &&
> >>>>>>> +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEED=
ING))
> >>>>>>> +             return true;
> >>>>>>> +
> >>>>>>> +     return false;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>      /*
> >>>>>>>       * Look for a btrfs signature on a device. This may be calle=
d out of the mount path
> >>>>>>>       * and we are not allowed to call set_blocksize during the s=
can. The superblock
> >>>>>>> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_devic=
e(const char *path, blk_mode_t flags,
> >>>>>>>                  goto error_bdev_put;
> >>>>>>>          }
> >>>>>>>
> >>>>>>> -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) =
=3D=3D 1 &&
> >>>>>>> -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEED=
ING)) {
> >>>>>>> -             dev_t devt;
> >>>>>>> +     if (btrfs_skip_registration(disk_super, path, bdev_handle->=
bdev->bd_dev,
> >>>>>>> +                                 mount_arg_dev)) {
> >>>>>>> +             pr_debug("BTRFS: skip registering single non-seed d=
evice %s (%d:%d)\n",
> >>>>>>> +                       path, MAJOR(bdev_handle->bdev->bd_dev),
> >>>>>>> +                       MINOR(bdev_handle->bdev->bd_dev));
> >>>>>>>
> >>>>>>> -             ret =3D lookup_bdev(path, &devt);
> >>>>>>> -             if (ret)
> >>>>>>> -                     btrfs_warn(NULL, "lookup bdev failed for pa=
th %s: %d",
> >>>>>>> -                                path, ret);
> >>>>>>> -             else
> >>>>>>> -                     btrfs_free_stale_devices(devt, NULL);
> >>>>>>> +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev,=
 NULL);
> >>>>>>>
> >>>>>>> -             pr_debug("BTRFS: skip registering single non-seed d=
evice %s\n", path);
> >>>>>>>                  device =3D NULL;
> >>>>>>>                  goto free_disk_super;
> >>>>>>>          }
> >>>>>>

