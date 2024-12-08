Return-Path: <linux-btrfs+bounces-10133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D749E8836
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF281884E97
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C741922EE;
	Sun,  8 Dec 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crtX0Hek"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C522C6F7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733696382; cv=none; b=GttuXeshs06xnmrFz2CIlm8Ooi5wsfEmnSubGlw+aPJtlyUgaVrhEalGnWQl1E+9+xpmJMQVn/MR2MtXJSzq195vW/Tnqi8HNzhdOjL6fZjTsij7UyIMxPSDz5CFBOAUkymLsq9hVVSDJmQsUrIufcxuSpLeJowjBBa3MC6i+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733696382; c=relaxed/simple;
	bh=HI5eyjoXmwTOT4uF7dfwG37f3T+n/bk6z1i31i3UQ5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FamGn4qJ4NZIe29pK3OM/wKc5FSEvJ1d2+XFEv5sw1G4P9+pejIRfnK/9xAbPWOQCxUP5oz030VGBjY2eOlKoffRoPtuy5sLD3DlWCUtO63Gqdyz3y2gP5LevLtnuUVlDM85TbW0JPXvIAHMCVo3dCG+cYbJtICKlQHosaQi2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crtX0Hek; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-300392cc4caso19281911fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733696378; x=1734301178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tFaEqd7Bw8ci30IYHV1EITI1IaBhmqy+I+yZF5KGAU=;
        b=crtX0Heks6PGlXMw3i4UUiiApvsDMmwCG3SEZ2WsU/7Of+7Aed9+9Ps8SYDNBbkKTQ
         3u4LjqTXg1R9I35kaYYj7/74Kh4LhXhIgWa6PZhtW7oSib4yH6pvwZ2q6hVbo8Od3HdG
         spi/CuHL9Tz6VNZDLGt4qRBkeoa3o/MTkJFlid6ZXGGtBaDouVS7qjPbvQ8APbk+0Z3J
         WoMeFQB22WtIgo5ZSYPmqiCDpzJT+ov5Ft1MH5suLPd751B5LgIvpw5VNkJ60SfGYQBq
         PJH/K+wKdg/g52T8pSMeoPzncDtj9UM/XVpr0Oz8wAO2ua2JHSfQhYcUovOw1Z24jqTy
         Sckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733696378; x=1734301178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tFaEqd7Bw8ci30IYHV1EITI1IaBhmqy+I+yZF5KGAU=;
        b=MD1M1NjlomFy7WgJcB9FaO6SzNd/y0wR72yZpYODu1VP9iz44aMUJdnO3L0qU4OY6N
         ZqddD2XHbqsJ4780U/Xg7QXgvVuGdIIXslBSV14reRgUKxTdTe4itEpBRSm6YBjCqcuL
         jFiX2nW1EtP/QSvKXi5gtSBnLjnLHY/3AHEA9vJ1mwG+Gv4eYY3KYWUdMpnKQByXkAX4
         0bo6ePqBGBpqRxp7hJtoMkwEsGn6S4m4FhELPQA4n/vIrluXY9/xh/KkCRbyOicn4ya6
         Br1tyNmRmlmJ7+DrQv6DOP2eVsEzC6ZU5Q0dZtvKSdZsf06t7fdzVBGrOYraj1adelcD
         8Ldg==
X-Gm-Message-State: AOJu0Yx6sQkhr2fCi/R6eWWdynvBt4bH8sDjnAqcC555Isf7IeI/QV7z
	mas0DRqR/X5DBdVfg9WZPNtGbZbQFNgUWeX2fO/Z+sPF/8hhESwCwM5oOcQxXXYIBF49HU0227z
	PKZr7nEcm8yTKhPg7YtehZNrdoCc=
X-Gm-Gg: ASbGncv9UZ4YEH5R1ulVkxPdnhin4P4Bb7en6kWqy5QAQHEa49FVSAXPel6zFAAW1Yr
	plY0Fq8SHB72mSZwW/x9YGGFxwR4LE9c0
X-Google-Smtp-Source: AGHT+IGYTIGGUVr/fnrq3KgUEc49NvyzlnSBM+a9qkF/L5Yx6b8b91YR8TmmgiXy6YAyuK1P+i/U+nvIFWaqrhsyhBg=
X-Received: by 2002:a05:651c:2224:b0:300:2731:4120 with SMTP id
 38308e7fff4ca-3002f8c1bf7mr30134521fa.15.1733696378089; Sun, 08 Dec 2024
 14:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com> <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
 <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com>
In-Reply-To: <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Sun, 8 Dec 2024 23:19:26 +0100
Message-ID: <CADhu7iCYRjcQ2kHWqvaZYTnwVUY-qFaBSaDyZA_OL2MEpr6EYg@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Dec 2024 at 22:36, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2024/12/9 07:55, j4nn =E5=86=99=E9=81=93:
> > On Sun, 8 Dec 2024 at 21:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> =E5=9C=A8 2024/12/9 02:32, j4nn =E5=86=99=E9=81=93:
> >>> gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bd=
ata
> >>> Unable to find block group for 0
> >>> Unable to find block group for 0
> >>> Unable to find block group for 0
> >>
> >> This is a common indicator of -ENOSPC.
> >>
> >> But according to the fi df output, we should have quite a lot of
> >> metadata space left.
> >>
> >> The only concern is the DUP metadata, which may cause the space
> >> reservation code not to work in progs.
> >>
> >> Have you tried to convert the DUP metadata first?
> >
> > I am not sure how to do that.
> > I see the "Multiple block group profiles detected" warning, assumed it
> > is about metadata in RAID1 and DUP.
> > But I am not sure how that got created or if it has any benefit or not.
> > And what that DUP should be converted into?
>
> Not sure either. But I guess in the past you mounted the device with one
> disk missing, and did some writes.
> And those writes by incident created a new chunk, and in that case the
> new chunk are only seeing one writable disk, so it went DUP.
>
>
> To remove it, you need specific balance filter, e.g
>
>   # btrfs balance start -mprofiles=3Ddup,convert=3Draid1 /mnt/data

Thank you very much - it worked!

gentoo ~ # btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdata
Free space cache cleared

[55392.407421] BTRFS info (device dm-0): balance: start
-mconvert=3Draid1,profiles=3Ddup -sconvert=3Draid1,profiles=3Ddup
[55392.480051] BTRFS info (device dm-0): relocating block group
3216960913408 flags metadata|dup
[55431.499765] BTRFS info (device dm-0): found 27769 extents, stage:
move data extents
[55434.081160] BTRFS info (device dm-0): relocating block group
1142491709440 flags metadata|dup
[55464.555860] BTRFS info (device dm-0): found 9152 extents, stage:
move data extents
[55466.614881] BTRFS info (device dm-0): relocating block group
1112426938368 flags metadata|dup
[55497.322148] BTRFS info (device dm-0): found 9925 extents, stage:
move data extents
[55499.938966] BTRFS info (device dm-0): relocating block group
1079140941824 flags metadata|dup
[55520.415801] BTRFS info (device dm-0): found 14986 extents, stage:
move data extents
[55521.796855] BTRFS info (device dm-0): relocating block group
746280976384 flags metadata|dup
[55548.800335] BTRFS info (device dm-0): found 15430 extents, stage:
move data extents
[55550.291120] BTRFS info (device dm-0): balance: ended with status: 0
[55849.661892] BTRFS info (device dm-0): last unmount of filesystem
1dfac20a-3f84-4149-aba0-f160ab633373

gentoo ~ # vi /etc/fstab
gentoo ~ # systemctl daemon-reload
gentoo ~ # mount /mnt/data

[56068.187456] BTRFS info (device dm-0): first mount of filesystem
1dfac20a-3f84-4149-aba0-f160ab633373
[56068.187473] BTRFS info (device dm-0): using crc32c (crc32c-intel)
checksum algorithm
[56068.187477] BTRFS info (device dm-0): using free-space-tree
[56068.823725] BTRFS info (device dm-0): bdev /dev/mapper/wdrb-bdata
errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[56068.823733] BTRFS info (device dm-0): bdev /dev/mapper/wdrc-cdata
errs: wr 7, rd 0, flush 0, corrupt 0, gen 0

Just wondering what the "errs: wr 8" and "errs: wr 7" mean here?


>
> You have more than enough space to remove the DUP chunks.
>
> > Ok, I just followed a howto for the switch.
> > Did not know it is ok just with the mount option.
> > Should it be safe to try it if I get the errors with the "btrfs rescue
> > clear-space-cache v1"?
>
> Since progs and kernel have different implementations on the space
> reservation code, it's not that rare to hit cases where btrfs-progs hits
> some false alerts.
>
> If you balanced removed the DUP profile, then you can try "btrfs rescue"
> again, just to see if it works and I really appreciate the extra
> feedback to help debugging the progs bug.

Yes, it worked - thanks again.
Here some extra feedback:

gentoo ~ # btrfs fi usage /mnt/data
Overall:
   Device size:                  16.00TiB
   Device allocated:             14.55TiB
   Device unallocated:            1.45TiB
   Device missing:                  0.00B
   Device slack:                    0.00B
   Used:                         14.18TiB
   Free (estimated):            906.41GiB      (min: 906.41GiB)
   Free (statfs, df):           906.41GiB
   Data ratio:                       2.00
   Metadata ratio:                   2.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                  no

Data,RAID1: Size:7.19TiB, Used:7.03TiB (97.77%)
  /dev/mapper/wdrb-bdata          7.19TiB
  /dev/mapper/wdrc-cdata          7.19TiB

Metadata,RAID1: Size:86.00GiB, Used:59.74GiB (69.46%)
  /dev/mapper/wdrb-bdata         86.00GiB
  /dev/mapper/wdrc-cdata         86.00GiB

System,RAID1: Size:32.00MiB, Used:1.08MiB (3.37%)
  /dev/mapper/wdrb-bdata         32.00MiB
  /dev/mapper/wdrc-cdata         32.00MiB

Unallocated:
  /dev/mapper/wdrb-bdata        742.00GiB
  /dev/mapper/wdrc-cdata        742.00GiB

gentoo ~ # btrfs filesystem df /mnt/data
Data, RAID1: total=3D7.19TiB, used=3D7.03TiB
System, RAID1: total=3D32.00MiB, used=3D1.08MiB
Metadata, RAID1: total=3D86.00GiB, used=3D59.74GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

gentoo ~ # mount -o rw,remount /mnt/data

[56709.279574] BTRFS info (device dm-0 state M): creating free space tree
[56893.200005] INFO: task btrfs-transacti:2510362 blocked for more
than 122 seconds.
[56893.200011]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
...
[57061.541085] BTRFS info (device dm-0 state M): setting compat-ro
feature flag for FREE_SPACE_TREE (0x1)
[57061.541091] BTRFS info (device dm-0 state M): setting compat-ro
feature flag for FREE_SPACE_TREE_VALID (0x2)
[57062.642266] BTRFS info (device dm-0 state M): cleaning free space cache =
v1

gentoo ~ # btrfs filesystem df /mnt/data
Data, RAID1: total=3D7.19TiB, used=3D7.03TiB
System, RAID1: total=3D32.00MiB, used=3D1.08MiB
Metadata, RAID1: total=3D64.00GiB, used=3D59.75GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

gentoo ~ # btrfs fi usage /mnt/data
Overall:
   Device size:                  16.00TiB
   Device allocated:             14.51TiB
   Device unallocated:            1.49TiB
   Device missing:                  0.00B
   Device slack:                    0.00B
   Used:                         14.18TiB
   Free (estimated):            928.41GiB      (min: 928.41GiB)
   Free (statfs, df):           928.41GiB
   Data ratio:                       2.00
   Metadata ratio:                   2.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                  no

Data,RAID1: Size:7.19TiB, Used:7.03TiB (97.77%)
  /dev/mapper/wdrb-bdata          7.19TiB
  /dev/mapper/wdrc-cdata          7.19TiB

Metadata,RAID1: Size:64.00GiB, Used:59.75GiB (93.35%)
  /dev/mapper/wdrb-bdata         64.00GiB
  /dev/mapper/wdrc-cdata         64.00GiB

System,RAID1: Size:32.00MiB, Used:1.08MiB (3.37%)
  /dev/mapper/wdrb-bdata         32.00MiB
  /dev/mapper/wdrc-cdata         32.00MiB

Unallocated:
  /dev/mapper/wdrb-bdata        764.00GiB
  /dev/mapper/wdrc-cdata        764.00GiB

>
> Otherwise I believe it should be pretty safe just using "space_cache=3Dv2=
"
> mount option.
>
> Thanks,
> Qu
> >
> > Thank you.
>

