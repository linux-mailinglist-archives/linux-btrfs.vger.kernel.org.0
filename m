Return-Path: <linux-btrfs+bounces-2253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B084E950
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D31F224B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFAD38395;
	Thu,  8 Feb 2024 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcn9UmQW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072738384
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422694; cv=none; b=bVL/+zn7IW7B9XIbA5GTCiyL6k+x/AlHhzJlb0LbdOHjqRnCs+RgAQ+gm4WQZbkSrh9D0Bnmm4EXRCIrK3z4V25FFOCC0beIa+mq9Vz/V8nHTNZh89NlXDyAXf2txlk5Ra0iWUQxQZPLhSOp7NCzVsMvg/mVVfVsUA+ilPNeC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422694; c=relaxed/simple;
	bh=WX3yu5BiXhO40lokV8Nq7ujAwm0v/9zaXSS4JxoIVGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA/ThaLXrFzn/r4mt+zNDwvnw/p0agiFi6tbgRU7xSjw0gDKfhhFN6okuGgJ7yIvrdpFRQkdkQfJurJTragngJ6k63vG76y6hCAoL8ESFecl+tM9lnKMItFuSkZ3DvW5ybLbYdsGN7CM0hvP8akn1aC0ZvKjvagcqU/RhREMX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcn9UmQW; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc74897c01bso189178276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Feb 2024 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707422691; x=1708027491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoaRtxLBUjTpN2tNo0MY35cn48y5H0J3YYVXCPDEUU0=;
        b=Lcn9UmQWcQCD0OM9aiI0fvk52tMK5PfLmQIteEt+CnW88jc2rGsI9jQxQaluSkhBnI
         mxdAQZ0KRju/+97TC+r2j2j9glM2kYZw8iPSY+Gv3q8Dl7ut9di4EcETmruj5yDUR2YU
         8tyqcCY18ZbevWrnbXg+v9D/c7I8OGqlCe6uDbKl8Zg5xWB4SdlY0fHGRInxR38k+FFm
         4bqjn0bksynY0fz4nZv8JQTFhD2uZfhBdsYkFgEh9K97zzjpBX+Nz6O9OAJo35mEyM2A
         QFPkNX2YhPq3btYrU9L1FNNYxsXx/SbgWRgdQvSjAyWVOF0haY5vZJMFZ7d4GY2prGbI
         1ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422691; x=1708027491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoaRtxLBUjTpN2tNo0MY35cn48y5H0J3YYVXCPDEUU0=;
        b=T9dV4fECh3U2JAMLRpR8BEkBULQHsIt4QevhhLgNAz2sL9Vu1/0O/fexz4joaKV7Rl
         cg6yS6a0z074niR56wVXfUmN/1Pmm5g7bvF8XqX3UnObxaJ77pruUxn7Yaj+JynBFvPc
         iaqouWUPXE/N6XlJJq7mT/bVsjxKFA8yUKulZOc5+9t+IrCbBJtl/oj3OqeTaihGdH7h
         GhAt5zf86woRHBA/+y4+daZ3G4hTHWNe9wV2O2EVZL1e++u1/lqN4bjn2GyRtUNyuQT6
         bo8AWii25fQx1T0sqbz8jU7nCsh5Xz9SLVFS1U3u8+vjaT7hOesv1Qa2xK8qgrZUYP2W
         ctMw==
X-Forwarded-Encrypted: i=1; AJvYcCUyRYM6SVJac97QAkWqbqwk6yvYvA5ggtwls9U87Na/9EVI+IpuCXG4isYqNYVlRbGuyLuuO5KFqFn86eVU+VIxGZqEWXMOkENYdy4=
X-Gm-Message-State: AOJu0YzYHo66xSI0LRI/YoeGy/HYVkhanZFtO//cQ9DXberKgDRjaeq4
	AdiU2b8tZLJafY2HlLEKnjJCvY+Fz8g3K2ujCYj1bj/NehofQe6X5ELavjbyfkLfUiiZoQnpSFo
	syqT9BEFVWR1kxeLMEid60eBq6TiNnRNI7eaNYA==
X-Google-Smtp-Source: AGHT+IH2//CYC6ZnA0WhHerorYMgYOWxM4cz2RGH6f/EDxCmCnDRtNhyDzjnGWJ2k8JYaoeJ8TWkrRZEpSwIwFp8G2M=
X-Received: by 2002:a25:9304:0:b0:dc6:b121:d011 with SMTP id
 f4-20020a259304000000b00dc6b121d011mr557425ybo.43.1707422690557; Thu, 08 Feb
 2024 12:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240205125704.GD355@twin.jikos.cz> <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
 <8c326f81-e351-4e71-b724-872701f015ff@oracle.com> <CAKLYge+9ngrW-1EffUhyU1y13MzgP33osNDi3D6y6UVW6poJZA@mail.gmail.com>
 <55c879b6-5e6b-4602-b558-e52540b67bda@oracle.com> <CAKLYgeJCqu_9aCO+s74rcFh5R6EdLeNwe43MhRmjQ=soFX-rcQ@mail.gmail.com>
 <bb7f33ba-5c8f-4b07-8d79-d0d191ce1fcf@oracle.com>
In-Reply-To: <bb7f33ba-5c8f-4b07-8d79-d0d191ce1fcf@oracle.com>
From: Alex Romosan <aromosan@gmail.com>
Date: Thu, 8 Feb 2024 21:04:39 +0100
Message-ID: <CAKLYgeKjvkkRM3D8ZDF5=o6j2hw5qrCzhufisnb0Gw-rvj12zA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: bernd.feige@gmx.net, dsterba@suse.cz, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f3e0440610e45217"

--000000000000f3e0440610e45217
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

i'm attaching the boot log from 6.8-rc3 with your patch. update-grub
works. i took a quick look at the log and i can see this (which wasn't
in the unpatched kernel):

BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
scanned by (udev-worker)

On Thu, Feb 8, 2024 at 6:22=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
> Thanks for the kernel messages with debug enabled.
>
> I don't see the message to skip scannaing for
> the mounted device. So it's not what we thought
> was the issue.
>
>    pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>
>
> Based on the assumption above, I have a fix below,
> but I doubt its effectiveness.
>
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/8dd1990114aabb775d=
4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com/
>
> -Anand
>
>
> On 2/8/24 18:05, Alex Romosan wrote:
> > i'm attaching my boot log with 6.8.0-rc3 no fixes and btrfs debug
> > enabled (i assume this is what you wanted). update-grub doesn't work.
> > there was no patch in your last message. do you want me to try the
> > patch you sent on monday? confused
> >
> > On Thu, Feb 8, 2024 at 3:23=E2=80=AFAM Anand Jain <anand.jain@oracle.co=
m> wrote:
> >>
> >>
> >> Alex,
> >>
> >> Please provide the kernel boot messages with debugging enabled but
> >> no fixes applied. Kindly collect these messages after reproducing
> >> the problem.
> >>
> >> We've found issues with the previous fix. Please test this
> >> new patch, as it may address the bug. Keep debugging enabled
> >> during testing.
> >>
> >>
> >> Thanks ,Anand
> >>
> >>
> >> On 2/7/24 23:48, Alex Romosan wrote:
> >>> Which version of the patch are we talking about? Let me know and I=E2=
=80=99ll
> >>> try it with debugging on. I tried David=E2=80=99s patch and it seemed=
 to work (I
> >>> just booted into that kernel and ran update-grub) but I=E2=80=99ll tr=
y something
> >>> else=E2=80=A6
> >>>
> >>> On Wed, Feb 7, 2024 at 19:08 Anand Jain <anand.jain@oracle.com
> >>> <mailto:anand.jain@oracle.com>> wrote:
> >>>
> >>>
> >>>
> >>>      On 2/7/24 08:08, Anand Jain wrote:
> >>>       >
> >>>       >
> >>>       >
> >>>       > On 2/5/24 18:27, David Sterba wrote:
> >>>       >> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
> >>>       >>> We skip device registration for a single device. However, w=
e do
> >>>      not do
> >>>       >>> that if the device is already mounted, as it might be comin=
g in
> >>>      again
> >>>       >>> for scanning a different path.
> >>>       >>>
> >>>       >>> This patch is lightly tested; for verification if it fixes.
> >>>       >>>
> >>>       >>> Signed-off-by: Anand Jain <anand.jain@oracle.com
> >>>      <mailto:anand.jain@oracle.com>>
> >>>       >>> ---
> >>>       >>> I still have some unknowns about the problem. Pls test if t=
his
> >>>      fixes
> >>>       >>> the problem.
> >>>
> >>>      Successfully tested with fstests (-g volume) and temp-fsid test =
cases.
> >>>
> >>>      Can someone verify if this patch fixes the problem? Also, when p=
roblem
> >>>      occurs please provide kernel messages with Btrfs debugging suppo=
rt
> >>>      option compiled in.
> >>>
> >>>      Thanks, Anand
> >>>
> >>>
> >>>       >>>
> >>>       >>>   fs/btrfs/volumes.c | 44
> >>>      ++++++++++++++++++++++++++++++++++----------
> >>>       >>>   fs/btrfs/volumes.h |  1 -
> >>>       >>>   2 files changed, 34 insertions(+), 11 deletions(-)
> >>>       >>>
> >>>       >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>       >>> index 474ab7ed65ea..192c540a650c 100644
> >>>       >>> --- a/fs/btrfs/volumes.c
> >>>       >>> +++ b/fs/btrfs/volumes.c
> >>>       >>> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
> >>>       >>>       return ret;
> >>>       >>>   }
> >>>       >>> +static bool btrfs_skip_registration(struct btrfs_super_blo=
ck
> >>>       >>> *disk_super,
> >>>       >>> +                    dev_t devt, bool mount_arg_dev)
> >>>       >>> +{
> >>>       >>> +    struct btrfs_fs_devices *fs_devices;
> >>>       >>> +
> >>>       >>> +    list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> >>>       >>> +        struct btrfs_device *device;
> >>>       >>> +
> >>>       >>> +        mutex_lock(&fs_devices->device_list_mutex);
> >>>       >>> +        list_for_each_entry(device, &fs_devices->devices,
> >>>      dev_list) {
> >>>       >>> +            if (device->devt =3D=3D devt) {
> >>>       >>> +                mutex_unlock(&fs_devices->device_list_mute=
x);
> >>>       >>> +                return false;
> >>>       >>> +            }
> >>>       >>> +        }
> >>>       >>> +        mutex_unlock(&fs_devices->device_list_mutex);
> >>>       >>
> >>>       >> This is locking and unlocking again before going to
> >>>      device_list_add, so
> >>>       >> if something changes regarding the registered device then it=
's
> >>>      not up to
> >>>       >> date.
> >>>       >>
> >>>       >
> >>>
> >>>      We are in the uuid_mutex, a potentially racing thread will have =
to
> >>>      acquire this mutex to delete from the list. So there can't a rac=
e.
> >>>
> >>>
> >>>
> >>>       > Right. A race might happen, but it is not an issue. At worst,=
 there
> >>>       > will be a stale device in the cache, which gets removed or re=
-used
> >>>       > in the next mkfs or mount of the same device.
> >>>       >
> >>>       > However, this is a rough cut that we need to fix. I am review=
ing
> >>>       > your approach as well. I'm fine with any fix.
> >>>       >
> >>>       >
> >>>       >>
> >>>       >>> +    }
> >>>       >>> +
> >>>       >>> +    if (!mount_arg_dev && btrfs_super_num_devices(disk_sup=
er)
> >>>      =3D=3D 1 &&
> >>>       >>> +        !(btrfs_super_flags(disk_super) &
> >>>      BTRFS_SUPER_FLAG_SEEDING))
> >>>       >>> +        return true;
> >>>       >>
> >>>       >> The way I implemented it is to check the above conditions as=
 a
> >>>       >> prerequisite but leave the heavy work for device_list_add th=
at
> >>>      does all
> >>>       >> the uuid and device list locking and we are quite sure it
> >>>      survives all
> >>>       >> the races between scanning and mounts.
> >>>       >>
> >>>       >
> >>>       > Hm. But isn't that the bug we need to fix? That we skipped th=
e device
> >>>       > scan thread that wanted to replace the device path from /dev/=
root to
> >>>       > /dev/sdx?
> >>>       >
> >>>       > And we skipped, because it was not a mount thread
> >>>       > (%mount_arg_dev=3Dfalse), and the device is already mounted a=
nd the
> >>>       > devt will match?
> >>>       >
> >>>       > So my fix also checked if devt is a match, then allow it to s=
can
> >>>       > (so that the device path can be updated, such as /dev/root to
> >>>      /dev/sdx).
> >>>       >
> >>>       > To confirm the bug, I asked for the debug kernel messages, I =
don't
> >>>       > this we got it. Also, the existing kernel log shows no such i=
ssue.
> >>>       >
> >>>       >
> >>>       >>> +
> >>>       >>> +    return false;
> >>>       >>> +}
> >>>       >>> +
> >>>       >>>   /*
> >>>       >>>    * Look for a btrfs signature on a device. This may be ca=
lled
> >>>      out
> >>>       >>> of the mount path
> >>>       >>>    * and we are not allowed to call set_blocksize during th=
e scan.
> >>>       >>> The superblock
> >>>       >>> @@ -1316,6 +1341,7 @@ struct btrfs_device
> >>>       >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >>>       >>>       struct btrfs_device *device =3D NULL;
> >>>       >>>       struct bdev_handle *bdev_handle;
> >>>       >>>       u64 bytenr, bytenr_orig;
> >>>       >>> +    dev_t devt =3D 0;
> >>>       >>>       int ret;
> >>>       >>>       lockdep_assert_held(&uuid_mutex);
> >>>       >>> @@ -1355,18 +1381,16 @@ struct btrfs_device
> >>>       >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >>>       >>>           goto error_bdev_put;
> >>>       >>>       }
> >>>       >>> -    if (!mount_arg_dev && btrfs_super_num_devices(disk_sup=
er)
> >>>      =3D=3D 1 &&
> >>>       >>> -        !(btrfs_super_flags(disk_super) &
> >>>      BTRFS_SUPER_FLAG_SEEDING)) {
> >>>       >>> -        dev_t devt;
> >>>       >>> +    ret =3D lookup_bdev(path, &devt);
> >>>       >>> +    if (ret)
> >>>       >>> +        btrfs_warn(NULL, "lookup bdev failed for path %s: =
%d",
> >>>       >>> +               path, ret);
> >>>       >>> -        ret =3D lookup_bdev(path, &devt);
> >>>       >>
> >>>       >> Do we actually need this check? It was added with the patch
> >>>      skipping the
> >>>       >> registration, so it's validating the block device but how ca=
n we
> >>>      pass
> >>>       >> something that is not a valid block device?
> >>>       >>
> >>>       >
> >>>       > Do you mean to check if the lookup_bdev() is successful? Hm. =
It
> >>>      should
> >>>       > be okay not to check, but we do that consistently in other pl=
aces.
> >>>       >
> >>>       >> Besides there's a call to bdev_open_by_path() that in turn d=
oes the
> >>>       >> lookup_bdev so checking it here is redundant. It's not relat=
ed
> >>>      to the
> >>>       >> fix itself but I deleted it in my fix.
> >>>       >>
> >>>       >
> >>>       > Oh no. We need %devt to be set because:
> >>>       >
> >>>       > It will match if that device is already mounted/scanned.
> >>>       > It will also free stale entries.
> >>>       >
> >>>       > Thx, Anand
> >>>       >
> >>>       >>> -        if (ret)
> >>>       >>> -            btrfs_warn(NULL, "lookup bdev failed for path =
%s: %d",
> >>>       >>> -                   path, ret);
> >>>       >>> -        else
> >>>       >>> +    if (btrfs_skip_registration(disk_super, devt,
> >>>      mount_arg_dev)) {
> >>>       >>> +        pr_debug("BTRFS: skip registering single non-seed
> >>>      device %s\n",
> >>>       >>> +              path);
> >>>       >>> +        if (devt)
> >>>       >>>               btrfs_free_stale_devices(devt, NULL);
> >>>       >>> -
> >>>       >>> -        pr_debug("BTRFS: skip registering single non-seed =
device
> >>>       >>> %s\n", path);
> >>>       >>>           device =3D NULL;
> >>>       >>>           goto free_disk_super;
> >>>       >>>       }
> >>>

--000000000000f3e0440610e45217
Content-Type: application/gzip; name="log.6.8.0-rc3-dirty.gz"
Content-Disposition: attachment; filename="log.6.8.0-rc3-dirty.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_lsdnd0080>
X-Attachment-Id: f_lsdnd0080

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
ZIrJlxACAA==
--000000000000f3e0440610e45217--

