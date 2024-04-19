Return-Path: <linux-btrfs+bounces-4431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BF08AAF96
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 15:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8551F23B45
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0C12AADF;
	Fri, 19 Apr 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VudR1eNj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923C129E86
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534120; cv=none; b=DBFXDNvutb0nV9htCY3VS8wMGclmI8tBILed/GbjxaIZwNCDRN10rcHAVWfEfcImbPMmM/xV2vCOZxE/Ow2HfG10C5jKO6aOSsGNuqyRzJuQu56E/GSR2PYDSV98m1nVuV3LhU6rQ0RvCiNlNThUs1MGWZFKdcyIcJBWbEVOtT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534120; c=relaxed/simple;
	bh=alIzIsz9OBARy5kwjg9KeF6SU21EOxM+qcCZuQG7RJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2XCnxHCQGuqHZQPOAVeo7TiJ72xjr18F3NqbSWdYkz0Fo9d/BP9I5jDn3T83BdpsQUF5U6xvuDpu3dmVultDyNSJm/TsBbXi2jtB5OVfXGmQXnxnmuXyyQBvsC2xlB9R9dZsEGx05djLAEx7s43ZuxKN5UOLpS9hhkWrn5htbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VudR1eNj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db8021275eso634971fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713534117; x=1714138917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtW73INnF7WodWNVxKvcsAWcQWBqZTH27FISCxovWRU=;
        b=VudR1eNjzVLQ+JWTeTnKGe9rx06TsgwdtBOGYQPHzk5yFVrcAfQaicfgDkjMW7AsuC
         RAVZ6zz92hDxsrAcCwmIZpFdznkTfqqgGnR9wL59ZoDjn3ri/Ryta0k0fFMJxfreAusF
         lECOV4zBSQJXOERBt9UYGAgBErxohXHVIsCYFQYsIyxOQxSU0LTnakj03sf2FTTLeARG
         ksipCh3GBIbPtwq1Z9ZE1I0m7kcvtHiJSIjA72MZQSi9OfgiuwHlxukksdK8wM00+yGD
         6t5J9gKD9AK4aVM97KFdFQxMOD0rKL7XTvzI6jrg9U6wiZVsupCPpOg0DbBvgGM8H+9V
         St4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534117; x=1714138917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtW73INnF7WodWNVxKvcsAWcQWBqZTH27FISCxovWRU=;
        b=CzTln5s0mIlej0+hZD76STHNvAogKX08SMWW+eDnd0qnDm/PiwX0kUgk17BCZ0/6B1
         eMEwQZt5+tefxWoLMl3jUo0710KBTuQfcbBS7RpPBoqymOAA1HVsXVQJoC6bQiq3Ya8W
         w1kA3/3Yr0DnssORU+Df/2U+LuWdMEZtT1RnjCdS8hdaR4ZVqkqWT2OEDOYoIL2uSpBj
         45qgYtjhHL39tofJeT3m3NwBXjpzbng7UbUvzRBY6FdDbz10SvnJ9547MnCo0p+CzIy/
         h5cCPQ4/Gw/D1y2OPw3WE5HDguK+CVvs9pVkkmylzAFdvUnP6yyu996oMSYMF97nvLQ9
         on2Q==
X-Gm-Message-State: AOJu0YzS5SiogAkkSKUPQqtCjuLr31NBwNqKnciU5e3rW6bUjSngOiNO
	97kTqMNtRiwVaKN8tTbWhzaw8KOlz4bGgCIef0Aw/b7tm99lHoH+vOSqYfhRWvUQ5DppU+CJaQt
	BdjKWPt0XXKBz205lvJ4TV7VucmRrFoqa
X-Google-Smtp-Source: AGHT+IFK5tHPLCi3OTGtKBG4JKeDWKQa7JVmrg7Wnv/Ui9m46qar0MvzcQEFmSU+PmrqvTRoRqXBONtsew+VkX92UJg=
X-Received: by 2002:a05:651c:1423:b0:2d8:b8c8:1315 with SMTP id
 u35-20020a05651c142300b002d8b8c81315mr1118366lje.4.1713534117019; Fri, 19 Apr
 2024 06:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b996820e-efa5-4fb5-ba4e-57cc295c1b64@gmail.com>
 <CAA91j0VmxAE=XmCPJwT9m6YXKJzDKtP-+vpcTXbp=_=fROyqnA@mail.gmail.com> <0d65236f-184c-48fe-8789-32c41732eae7@gmail.com>
In-Reply-To: <0d65236f-184c-48fe-8789-32c41732eae7@gmail.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Fri, 19 Apr 2024 16:41:45 +0300
Message-ID: <CAA91j0WFKw_TZMLN=3NhdtnjNx5g6rcbM+gGVF+BGOKhG6-SxQ@mail.gmail.com>
Subject: Re: support request: btrfs df reports drive is out of space, cannot
 find what occupies it
To: Skirnir Torvaldsson <skirnir.torvaldsson@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:18=E2=80=AFPM Skirnir Torvaldsson
<skirnir.torvaldsson@gmail.com> wrote:
>
> With all due respect, 38G is a grand total, so it is 38G out of 78G
> reported data.
> There is one thing I've noticed that troubles me:
>
> root@next:/home/support/btrfs-list-2.3# ./btrfs-list
> NAME                      TYPE    REFER     EXCL  MOUNTPOINT
> NEXT_ROOTFS                 fs       -    78.37G (single/dup,
> 15.03G/95.46G free, 15.74%)
>     [main]              mainvol   16.00k   16.00k /
>     @System              subvol   16.00k   16.00k /.snapshots
>     @Logs                subvol   16.00k   16.00k /next/logs/.snapshots
>     @Logs/current        subvol    4.70G    4.70G /next/logs
>     @AppData             subvol   16.00k   16.00k /next/appdata/.snapshot=
s
>     @AppData/current     subvol  370.14M  370.14M /next/appdata
>     @AppData/var         subvol   16.00k   16.00k
>     @Databases           subvol   16.00k   16.00k /next/databases/.snapsh=
ots
>     @Databases/current   subvol  754.95M  754.95M /next/databases
>     @MessageBus          subvol   16.00k   16.00k /next/mbus/.snapshots
>     @MessageBus/current  subvol   67.70G   67.70G /next/mbus
>     @Updates             subvol   16.00k   16.00k /next/updates/.snapshot=
s
>     @Updates/current     subvol    1.81G    1.81G /next/updates
>     @SystemData          subvol   16.00k   16.00k
> /next/systemdata/.snapshots
>     @SystemData/current  subvol    1.21G    1.21G /next/systemdata
>     @System/prev         subvol    1.48G    1.48G
>     @System/current      subvol  443.27M  443.27M /
> root@next:/home/support/btrfs-list-2.3# du -hd1 /next/mbus
> 0       /next/mbus/.snapshots
> 1.4G    /next/mbus/redpanda
> 1.4G    /next/mbus
>
> So, the MessageBus subvolume is occupying 67Gb (?), however I fail to
> understand how come this space is not accounted for by du and how I can
> clean it and limit it in future.
>

Could be variation of

https://lore.kernel.org/linux-btrfs/0f4a5a08fe9c4a6fe1bfcb0785691a7532abb95=
8.camel@scientia.org/


> > On Fri, Apr 19, 2024 at 11:40=E2=80=AFAM Skirnir Torvaldsson
> > <skirnir.torvaldsson@gmail.com> wrote:
> >> Dear btrfs experts,
> >>
> >> Could you please help me sort out the following situation:
> >>
> >> btrfs df reports my 100Gb device is almost out of space (which agrees =
with the results produced by the standard "df"):
> >>
> >> root@next:/home/support# btrfs fi df /
> >> Data, single: total=3D82.00GiB, used=3D78.23GiB
> >> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> >> Metadata, DUP: total=3D1.00GiB, used=3D153.70MiB
> >> GlobalReserve, single: total=3D68.45MiB, used=3D0.00B
> >> root@next:/home/support# df -h /
> >> Filesystem      Size  Used Avail Use% Mounted on
> >> /dev/sda3        96G   79G   16G  84% /
> >>
> >> However  when I try to locate files to delete with du that's what I ge=
t:
> >>
> >> root@next:/home/support# du -hd1 /
> >> 70M     /boot
> >> 0       /dev
> >> 2.2G    /.snapshots
> >> 14M     /bin
> >> 4.5M    /etc
> >> 2.5M    /home
> >> 348M    /lib
> >> 4.0K    /lib64
> >> 0       /media
> >> 0       /mnt
> >> 0       /opt
> >> 0       /proc
> >> 40K     /root
> >> 2.7M    /run
> >> 12M     /sbin
> >> 0       /srv
> >> 0       /sys
> >> 0       /tmp
> >> 566M    /usr
> >> 5.0G    /var
> >> 29G     /next
> >> 38G     /
> >>
> >> I.e. almost 40Gb just gone somewhere.
> > Huh?
> >
> > 2.2G + 5.0G + 29G + 38G =3D=3D 75.2G out of 78G reported for DATA. What
> > 40G are you talking about?
> >
> > If you have some other mount points, you could start with explaining
> > your storage layout first.
> >
> >> Am I doing something wrong? Is there a problem or a piece of theory I'=
m missing? Kindly advice.
> >>
> >> +++++++++++++++++++++++++++++++++++++
> >> root@next:~#  uname -a
> >> Linux next 5.10.0-28-amd64 #1 SMP Debian 5.10.209-2 (2024-01-31) x86_6=
4 GNU/Linux
> >> root@next:~#  btrfs --version
> >> btrfs-progs v5.10.1
> >> root@next:~#  btrfs fi show
> >> Label: 'NEXT_ROOTFS'  uuid: abc71bdb-c570-461d-a28a-54294a646089
> >>          Total devices 1 FS bytes used 78.37GiB
> >>          devid    1 size 95.46GiB used 84.06GiB path /dev/sda3
> >>
> >> root@next:~#  btrfs fi df /
> >> Data, single: total=3D82.00GiB, used=3D78.22GiB
> >> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> >> Metadata, DUP: total=3D1.00GiB, used=3D153.64MiB
> >> GlobalReserve, single: total=3D68.45MiB, used=3D0.00B
> >>
>

