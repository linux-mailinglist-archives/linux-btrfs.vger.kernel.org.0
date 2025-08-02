Return-Path: <linux-btrfs+bounces-15807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8334B18CD4
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C936D564115
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99292798E1;
	Sat,  2 Aug 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h019Jhga"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1B248193
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127006; cv=none; b=azW+DPqrTMhaE7uT0+KEojrxkY/W8xC6MNBkUOHzYPmbhbNJKr/xkPGsUgPsY1jqJTSEqn6QHodHQJq+3dRbsCfaijEJn9iXuAd5fbanSbWzWWGFTVA7eg6vV87/P6POT6HntLQmJ6d2V3Er8oxZP4sY5fnchITY0WN57ajeTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127006; c=relaxed/simple;
	bh=q8MxPnoiRCTlI5wYH6Jay1hKCyKR9hcBRH08GZLDjsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiAqQPIosc+4W8KxWPwcYR5pOPjS9KTuMvTb1RF9T9cf2AryY1EPfs3mmXm2T6gpxS1JuryPTPfUNvFI3tyHA2ZnRGdtsZAWJ2CMbxdWS/g95NtEzW6/lNhitUPoEqM8DcPOMx204rpVky+uDiR0oRgYJsKfFePMjy5Fu5QXN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h019Jhga; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e6696eb4bfso170401485a.2
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754127004; x=1754731804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cHAP9jEtZEzmCiITzFE1CGA+C8Cnte+R7M9/Gg5LwQ=;
        b=h019JhgaqE4y8KlKtH31vf0CtoQiD4I6y/icw8KI1aEUyz+Pkrl92+jgC2zyy74IBg
         kIP0sJfuAry6H0VYT3Ml3PU3qfYy9DIl2olLQmSP2zIuWEHnVdyLTyE04PPl9aXb9RXX
         Ak2m9R4l8Us43PYp2DAnWiLNHtAws65NCgQX1jurkEzRt7FtWvTrH4whdPG9LzfFsGFT
         y4ZwR/qqbiKd7FXeagvtXAM40FI6uwfGw+OySg/NXI5agyn2z+JrH9FJTqo0n6PcVAVB
         YqfB2oAIxoEpgiT0OpyQ6PQSIw5RqfsYP6cfDGW3vgxCkzpry7SBvHtjY8vT25CRg7bd
         EDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754127004; x=1754731804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cHAP9jEtZEzmCiITzFE1CGA+C8Cnte+R7M9/Gg5LwQ=;
        b=YouXVR8OxSN5XMiIwMhZYUUrCnmuXZXiWu/f1J6b2Sb7NgTTxTZIdwwYlzTOcX9jjC
         P3Ls0Lu4PzZxC3PWAf80tESh7E/YToGnIhVsT1GDTGSVD3L/QY7aSIqrowVIYLs6/3CW
         MNzDkipMy98fQj2PGW3MONlDG32rW84Nkqu36YZNSyrozPBy4x77kSC8vVtJzk+YaYAD
         S08dY/TrCPpls28VhB0yuFqyaXkQs8ouKR2w+ITU4gWOFB+zMKTi350Df38xLXAXos3y
         OuNrAaJgwVFUIS22HEKo/ZyvgSMAf9ywtAakR/C8W2rNEJo32WCpshxfC/Fx+0uIdIBn
         4sPQ==
X-Gm-Message-State: AOJu0YwsyVKhtSE7nE1v7ZF/c8xbXAz4+4+udKXGv9VviOkTgpF8EmOC
	SfroCwQCS8b9VeZQ0PIiW1KxY9UYp2oQpy1O2b7+EDnWE0KwiQhVaU+7xUJA4UkmEI+7D3JDUvA
	zsHlRet/15KaYBlftSoM+4xZuMS2j9TE=
X-Gm-Gg: ASbGnctnBLOwjX8+Dh/Q8ROrMWkdbiQTjALQNoVA6mlWCqFrwulBMbWlMKf+h11psPt
	fQUtkDvQ5+/K9zAYqVFSwuqzt4FN6afOzrfhcLB/SDKyYKFIB3odxj9mYJ0NMmA8QxvOBdmEp4P
	tzepn7wHRByv5hpxI6eErk+Uzd/jv90rNJuLenP4AmO2+w11H34d47pBr2eAMstBOwDE7KkU8t2
	jAbShfi
X-Google-Smtp-Source: AGHT+IGObECxKMPCSg/spMIrgrlVeBvJuChlmKJ2VDxAHMTZIpEX+HiGW6vpV0FSVlRbXE7xSm446bC2dclk+I8B2BM=
X-Received: by 2002:a05:6214:ccc:b0:707:4aa0:2f7 with SMTP id
 6a1803df08f44-70935f86a74mr47531596d6.19.1754127003884; Sat, 02 Aug 2025
 02:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801110318.37249-1-racz.zoli@gmail.com> <3a8f23bf-e1cf-4803-a290-8d77b0d5dadd@gmx.com>
In-Reply-To: <3a8f23bf-e1cf-4803-a290-8d77b0d5dadd@gmx.com>
From: Racz Zoli <racz.zoli@gmail.com>
Date: Sat, 2 Aug 2025 12:29:52 +0300
X-Gm-Features: Ac12FXzC3dAkyEbv0OELk_2kUl9qbXW-x0G6Hd33L8QlmrkvrYau1VAKHG0SUjg
Message-ID: <CANoGd8=_frhw+8iF=n0dFe-+vzwg4SRpM41XXRkB6Zt-2ANPpg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to
 handle loopback and device mapper devices
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I reproduced the bug on three separate distros, Arch, Ubuntu 25.04 and
Fedora 42 and open() fails on all three of them
when device usage was checked as a normal user. For testing I used the
most basic commands I could to be sure it`s
not only a particular usecase it fails.

For real storage device:

sudo mkfs.btrfs /dev/sda1
sudo mount /dev/sda1 /mnt
btrfs device usage /mnt -> run as normal user, and open() fails.

For loopback device:

fallocate -l 5G test_bug.img
sudo losetup --find --show test_bug.img
sudo mkfs.btrfs /dev/loop0
sudo mount /dev/loop0 /mnt/
btrfs device usage /mnt/ -> also fails

Thank you,
Zoltan

On Sat, Aug 2, 2025 at 7:19=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2025/8/1 20:33, Zoltan Racz =E5=86=99=E9=81=93:
> > Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs d=
evice usage"
> > which returns the sector size of a partition (or its parent). After mor=
e testing
> > it turned out it couldn`t handle loopback or mapper devices. This patch=
 adds a fix
> > for them.
>
> I can fold this change into the original patch if needed.
>
> Although during my test, even unprivileged users can still do regular
> ioctl based size detection, as long as the user have read permission to
> that device.
>
> And if the user can not even read the device, I'd say the environment is
> set up to intentionally prevent user accesses to that block device.
>
> So I'm not convinced about all the fallback method, especially we're
> doing a lot of special handling (partition vs raw devices).
>
> Mind to also provide the test setup you're using and the involved block
> device mode?
>
> >
> > Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
> > ---
> >   common/device-utils.c | 48 +++++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 33 insertions(+), 15 deletions(-)
> >
> > diff --git a/common/device-utils.c b/common/device-utils.c
> > index dd781bc5..a75194bf 100644
> > --- a/common/device-utils.c
> > +++ b/common/device-utils.c
> > @@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(co=
nst char *name)
> >       char sysfs[PATH_MAX] =3D {};
> >       char sizebuf[128];
> >
> > -     snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
> > +     /*
> > +      * First we look for hw_sector_size directly directly under
> > +      * /sys/class/block/[partition_name]/queue. In case of loopback a=
nd
> > +      * device mapper devices there is no parent device (like /dev/sda=
1 -> /dev/sda),
> > +      * and the partition`s sysfs folder itself contains informations =
regarding
> > +      * the sector size
> > +      */
> > +     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_si=
ze", name);
> > +     sysfd =3D open(sysfs, O_RDONLY);
> >
> > -     if (!realpath(link_path, real_path)) {
> > -             error("Failed to resolve realpath of %s: %s\n", link_path=
, strerror(errno));
> > -             return -1;
> > -     }
> > +     if (sysfd < 0) {
>
> Just a small nitpic, it's better to check the errno against ENOENT.
>
> But my question still stands, does it really make sense to use sysfs as
> a fallback?
>
> Thanks,
> Qu
>
> > +             /*
> > +              * If we couldn`t find it, it means our partition is crea=
ted on a real
> > +              * device and we need to find its parent
> > +              */
> > +             snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", n=
ame);
> >
> > -     dev_name =3D basename(real_path);
> > +             if (!realpath(link_path, real_path)) {
> > +                     error("Failed to resolve realpath of %s: %s\n", l=
ink_path, strerror(errno));
> > +                     return -1;
> > +             }
> >
> > -     if (!dev_name) {
> > -             error("Failed to determine basename for path %s\n", real_=
path);
> > -             return -1;
> > -     }
> > +             dev_name =3D basename(real_path);
> >
> > -     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_si=
ze", dev_name);
> > +             if (!dev_name) {
> > +                     error("Failed to determine basename for path %s\n=
", real_path);
> > +                     return -1;
> > +             }
> >
> > -     sysfd =3D open(sysfs, O_RDONLY);
> > -     if (sysfd < 0) {
> > -             error("Error opening %s to determine dev sector size: %s\=
n", real_path, strerror(errno));
> > -             return -1;
> > +             memset(sysfs, 0, PATH_MAX);
> > +             snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_s=
ector_size", dev_name);
> > +
> > +             sysfd =3D open(sysfs, O_RDONLY);
> > +
> > +             if (sysfd < 0) {
> > +                     error("Error opening %s to determine dev sector s=
ize: %s\n", real_path, strerror(errno));
> > +                     return -1;
> > +             }
> >       }
> >
> >       ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
>

