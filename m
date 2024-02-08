Return-Path: <linux-btrfs+bounces-2252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D184E91B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29871F28497
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BC381C8;
	Thu,  8 Feb 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9ri5YNu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0C3714C
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421563; cv=none; b=j+h1PuBX07EFoD3OcnSvRgxT/8GjBpRtKPr268FLmydnxIt11WpI3OszrApMmbdLrIMkphyG5ql48UfqjOP47A6bOQ1NfXejItz3L7s4X/jzfQOHpHSl6b34KrtctD7y+ZW7dBHMk9ydsuxrnqdXj2kfUcwntGz922pyP8GBGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421563; c=relaxed/simple;
	bh=uL+47AQlOYjBDOwT7xLssazkfAeuuQbRmK236qLbzFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJkmnhr9A2s1LlDKEccM9xJEg9sd4gQNlE1/Ll0Ptv98Z93kM8yxSXrAObjydNIEmLICqpXdDNU2AmcHY8iFvZKxI2kPMze/djfEmzUm57bpc1IpNrZO1KueNCPXzY54sHqogjPvWDpa1hmtY0FYn6QWuWz8Wx7IaHEQK2+Yd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9ri5YNu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc745927098so143173276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Feb 2024 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707421560; x=1708026360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VlN6tImfCGDrqu72nDVimwzHX3f/84t2ZbCzDGanxg=;
        b=Z9ri5YNu8mcIk13+2AGuQVWgZnKASeWx6/nmSFg1/O3VsrMRCzkDqCkGCQSsQqEZ8t
         +IaAscGOmyLmee+0PYJcA6upEj2J8xjyKFxtZMw8R/pyZSqn44XFwHc5MUi448GlKcKD
         COSYiOXAzCnoq90kF7p0GZ+cWx7OW71MiO8T5KxXqhVgqdeyLSn3bIAS1dxQ37SSCn22
         jqnZ5HcMJ16RpIbf6crvV0gBUry4Ovpv0vMMQ3uIv4Hi06sdtXujPnM5jMjhLuEyIG1j
         oNoH/XvOb42xulbpSGhEPfF6PGrjLD3w9b/tdoflIbpOg8XxCf0GKP8wo0FoP5z5SFVv
         Xdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707421560; x=1708026360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VlN6tImfCGDrqu72nDVimwzHX3f/84t2ZbCzDGanxg=;
        b=ZuiRuqe5H8N45UckcmeYvgCh9N3MOooH0GCkcAu6qvg8IHswvDHJbcZOC2tjwAAZG4
         R7BpE5XPWdLlpttOwKpm63cO7AyfK6AnYPx0KdHxMTDSeQxpHSOqjoqI7lwTC8/YrHgh
         9oGdbn+rNM/xNGfg2alwVf29Q0Yx26/MBhsqU+/FxB/NXcBT78c4HDRLaIpgfggbsbiS
         Sane0LNWUZWrQ4y1fNsM/tvKRJ6CGl7jh8y6uCqjZlm6T2UccP6NnPxIK1PR3DlBD5VV
         yuJXKDy3oohYDOYpaWrMWjpKqEL7cyWDktVWeM38tbkLkgdUnQofYw9jhVQzZ5cRZ7rk
         bChw==
X-Gm-Message-State: AOJu0YxrIbT0AgsskHmBELxzUJCSeXes8N3u8vPF/uu1C1k/lJ4O/e/X
	mryMl2+B6HmVmBed7gZ7pcohMTdDpu6SHsQy2UTyZAGazPBPBi09sEN4J3KBkTKc20IiWWxrIvJ
	hML3w6yq6wuoKzMe0TkW63meUv+A=
X-Google-Smtp-Source: AGHT+IEcl1zWt59zoWkcZuGrfqki1YFYOm94+ydRlOtdQOkM8QsqrvZo3aO8WBEYqfO5u1TVPxbP2IJKABW6KZNWygY=
X-Received: by 2002:a05:6902:527:b0:dbe:974:fb85 with SMTP id
 y7-20020a056902052700b00dbe0974fb85mr453492ybs.22.1707421560399; Thu, 08 Feb
 2024 11:46:00 -0800 (PST)
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
Date: Thu, 8 Feb 2024 20:45:49 +0100
Message-ID: <CAKLYgeJOUZP2H8SBWPmhXAxXf7FE4FiDm0MF0S3uxsRaqMPR_w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
To: Anand Jain <anand.jain@oracle.com>
Cc: bernd.feige@gmx.net, dsterba@suse.cz, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

okay, so this is the original patch from Monday. I tried the version
David committed to to the btrfs tree and that fixed the problem but
I'll try this one as well (with debugging now enabled) and let you
know.

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

