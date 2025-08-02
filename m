Return-Path: <linux-btrfs+bounces-15809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53152B18E86
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21FF3BD6FA
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF5235047;
	Sat,  2 Aug 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWHHL0+3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BC21FF58
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138748; cv=none; b=rpHGv4t+J9Lozt9F4RfoSEaVmZgZYlBUlcT811JWTdDLpSkUaJ7uK6sRDuV/Cc4C6fuUKMUY4CCSvL7l9U74YoMGtG4petdI95rvMFcq4F0LzgoCGRrjOj5IW7mrawm+qDYriT3QvRQwsQUDpU0/Rgl3LX9V5Nn06gDcFynOQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138748; c=relaxed/simple;
	bh=w/3iJBzsx/GYixN+E3zVyB7wezEAf5JAFXeEbFVImgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTIiJCxNmVVTaF+tR1fuYBCyzSEwrgySmsAU5k6AigJh1g9bci0eLllO2GBgNif2sgHfc6+pmNxcsc60/TsDLWEr/VjdhaCXGAIXsJBGN4ceoHx4JZx/ySGYnUt7jBMr+woDzZP8BGX27RsDV7eps8HGe20suI/JmOLV2O2Oymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWHHL0+3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4aeb2e06b82so7605941cf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754138746; x=1754743546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NejMHmDUiquV/bCh1paiPsXBPvlIq+/VZPM2MCFABtQ=;
        b=CWHHL0+3RBqZrZLA48Zeydf5ZfZ8mlGu3UOi2ebIAVHcDHCZjQfU0jLAjyicUO373p
         Q0XV7Tbvqgiy0g3/au5u3+cfWyBOMJjbKKWREvVUgQVgxF8273MjKDsFqUqyS2UVmXIv
         2oAJkFzwDm7TMXZM++N0cRh/8njoIgKGS2z871zeWXE9JnEVWfB4ivT9zY+NcptLtBD9
         Zy0ygna0ZuTj0+iMPfm7ZEK6hIjg++xwJ6Hs2QW9gJ/Mzc+gushg+adrUbA+q7RBPMxu
         SwaATSws1KW7ioNTMJcyZnlzwD1ktdOCu8kpD8ktbLsBpYfni9x91OjMbdQfun4QVb98
         NN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754138746; x=1754743546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NejMHmDUiquV/bCh1paiPsXBPvlIq+/VZPM2MCFABtQ=;
        b=v8D1+25U9/raLZWGxae9DerPW/UoIrCwn9ak3R2+51aAq3PwHfC7cb8mX+3aoqe5gE
         4QZ9XqMgHg3rFvrSxLiak+wU/t6ihlhAiF6OAqZl/J59wZBga+FapoAsPSJVdQtRy9B5
         6jX/boVF/4lC5+dJlClbwCh5+/gMauh8hF2KqwgCLk/E40rg8gsEhbF7wC/vvcJQcnhQ
         XEe3H3gvedHKFcLKZ5HrQNxF2Hxt2+hTbcn5hyvv96uIxXMhCIr+oKlvTk9KpO7poGv4
         H/2gAG7tNxc15fuFPY/zdagQZWm+o+au+MYrHzF53yQ2zBTBNPwiChY/cCt9fDOYh5Qu
         jl9w==
X-Gm-Message-State: AOJu0YwW976Dr+GOeHOa4nMykp5bvPmazP5YqonBlHPpA8rVjhR6EmUi
	fncfCinsTbM22uCcr3sJzKaPaMMbgQXHBjI4zGsFM5itWjTRFxyY8/diHC/Eo7pOh92HTBCO3I/
	2B0s0IH7M2yZLnpNRtOQ5suerLvPjY3yQ2xkA
X-Gm-Gg: ASbGnctsfiNjHMhjFii6xybD0EJ76ZWrRXg+zBY+wQZ7aHzemiypHndY8KJVo33ndz3
	pLjPYxnNfWmfuPX594KsdvYmlGUT3JdJsK0V+Q0/H1XmAJaoNZHkcX8ZnjTlTev2t0kGDa/ktBn
	QatACB9g7wsX2aNvLglqRwf+IIpq40iXshERy4EhICdkBSAmdH2j+aYWMTymh+ZzSJBPA+SyRC+
	fnAcfg/
X-Google-Smtp-Source: AGHT+IGCdwyLm4dyrDg7pmWF7lXDBqDtAmucjpQ3M1pxlu8mC9whJQOOnAC5zMUbnK8k+ko0AGf1ZL0mJZx7EH8bMLk=
X-Received: by 2002:a05:6214:20c5:b0:707:1709:8f5 with SMTP id
 6a1803df08f44-709362ee069mr38046816d6.36.1754138745587; Sat, 02 Aug 2025
 05:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801110318.37249-1-racz.zoli@gmail.com> <3a8f23bf-e1cf-4803-a290-8d77b0d5dadd@gmx.com>
 <CANoGd8=_frhw+8iF=n0dFe-+vzwg4SRpM41XXRkB6Zt-2ANPpg@mail.gmail.com> <ccfba80a-d238-43d1-86b1-9d1ac1ec5c56@gmx.com>
In-Reply-To: <ccfba80a-d238-43d1-86b1-9d1ac1ec5c56@gmx.com>
From: Racz Zoli <racz.zoli@gmail.com>
Date: Sat, 2 Aug 2025 15:45:34 +0300
X-Gm-Features: Ac12FXwjLE-c5Eq5z2vts43gq03cW7fZjDhgjyOzSC5npkfqtkpoOpGtRCqrvMY
Message-ID: <CANoGd8=8km8v_-Md3GSvUh3F_hWaHtCj8-EQkeujDWx=NzWFyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to
 handle loopback and device mapper devices
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If I add my user to the disk group it works, but starting from the
issue reported on github, I think it could be useful to leave the
sysfs functionality there and make btrfs device usage work for normal
users, and also users which are not in the disk group.
One usage I can think of would be for web services doing statistics
running under the apache user or any other random user who are not
part of this group.

But if the policy should be for normal users to not have access to
this functionality then you are right, and it might not be necessary
to have the sysfs functionality.

Thank you,
Zoli

On Sat, Aug 2, 2025 at 12:32=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/8/2 18:59, Racz Zoli =E5=86=99=E9=81=93:
> > I reproduced the bug on three separate distros, Arch, Ubuntu 25.04 and
> > Fedora 42 and open() fails on all three of them
> > when device usage was checked as a normal user. For testing I used the
> > most basic commands I could to be sure it`s
> > not only a particular usecase it fails.
> >
> > For real storage device:
> >
> > sudo mkfs.btrfs /dev/sda1
> > sudo mount /dev/sda1 /mnt
> > btrfs device usage /mnt -> run as normal user, and open() fails.
>
> Have you checked if you're in the "disk" group?
>
> >
> > For loopback device:
> >
> > fallocate -l 5G test_bug.img
> > sudo losetup --find --show test_bug.img
> > sudo mkfs.btrfs /dev/loop0
> > sudo mount /dev/loop0 /mnt/
> > btrfs device usage /mnt/ -> also fails
> >
> > Thank you,
> > Zoltan
> >
> > On Sat, Aug 2, 2025 at 7:19=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/8/1 20:33, Zoltan Racz =E5=86=99=E9=81=93:
> >>> Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs=
 device usage"
> >>> which returns the sector size of a partition (or its parent). After m=
ore testing
> >>> it turned out it couldn`t handle loopback or mapper devices. This pat=
ch adds a fix
> >>> for them.
> >>
> >> I can fold this change into the original patch if needed.
> >>
> >> Although during my test, even unprivileged users can still do regular
> >> ioctl based size detection, as long as the user have read permission t=
o
> >> that device.
> >>
> >> And if the user can not even read the device, I'd say the environment =
is
> >> set up to intentionally prevent user accesses to that block device.
> >>
> >> So I'm not convinced about all the fallback method, especially we're
> >> doing a lot of special handling (partition vs raw devices).
> >>
> >> Mind to also provide the test setup you're using and the involved bloc=
k
> >> device mode?
> >>
> >>>
> >>> Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
> >>> ---
> >>>    common/device-utils.c | 48 +++++++++++++++++++++++++++++----------=
----
> >>>    1 file changed, 33 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/common/device-utils.c b/common/device-utils.c
> >>> index dd781bc5..a75194bf 100644
> >>> --- a/common/device-utils.c
> >>> +++ b/common/device-utils.c
> >>> @@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(=
const char *name)
> >>>        char sysfs[PATH_MAX] =3D {};
> >>>        char sizebuf[128];
> >>>
> >>> -     snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
> >>> +     /*
> >>> +      * First we look for hw_sector_size directly directly under
> >>> +      * /sys/class/block/[partition_name]/queue. In case of loopback=
 and
> >>> +      * device mapper devices there is no parent device (like /dev/s=
da1 -> /dev/sda),
> >>> +      * and the partition`s sysfs folder itself contains information=
s regarding
> >>> +      * the sector size
> >>> +      */
> >>> +     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_=
size", name);
> >>> +     sysfd =3D open(sysfs, O_RDONLY);
> >>>
> >>> -     if (!realpath(link_path, real_path)) {
> >>> -             error("Failed to resolve realpath of %s: %s\n", link_pa=
th, strerror(errno));
> >>> -             return -1;
> >>> -     }
> >>> +     if (sysfd < 0) {
> >>
> >> Just a small nitpic, it's better to check the errno against ENOENT.
> >>
> >> But my question still stands, does it really make sense to use sysfs a=
s
> >> a fallback?
> >>
> >> Thanks,
> >> Qu
> >>
> >>> +             /*
> >>> +              * If we couldn`t find it, it means our partition is cr=
eated on a real
> >>> +              * device and we need to find its parent
> >>> +              */
> >>> +             snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..",=
 name);
> >>>
> >>> -     dev_name =3D basename(real_path);
> >>> +             if (!realpath(link_path, real_path)) {
> >>> +                     error("Failed to resolve realpath of %s: %s\n",=
 link_path, strerror(errno));
> >>> +                     return -1;
> >>> +             }
> >>>
> >>> -     if (!dev_name) {
> >>> -             error("Failed to determine basename for path %s\n", rea=
l_path);
> >>> -             return -1;
> >>> -     }
> >>> +             dev_name =3D basename(real_path);
> >>>
> >>> -     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_=
size", dev_name);
> >>> +             if (!dev_name) {
> >>> +                     error("Failed to determine basename for path %s=
\n", real_path);
> >>> +                     return -1;
> >>> +             }
> >>>
> >>> -     sysfd =3D open(sysfs, O_RDONLY);
> >>> -     if (sysfd < 0) {
> >>> -             error("Error opening %s to determine dev sector size: %=
s\n", real_path, strerror(errno));
> >>> -             return -1;
> >>> +             memset(sysfs, 0, PATH_MAX);
> >>> +             snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw=
_sector_size", dev_name);
> >>> +
> >>> +             sysfd =3D open(sysfs, O_RDONLY);
> >>> +
> >>> +             if (sysfd < 0) {
> >>> +                     error("Error opening %s to determine dev sector=
 size: %s\n", real_path, strerror(errno));
> >>> +                     return -1;
> >>> +             }
> >>>        }
> >>>
> >>>        ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
> >>
>

