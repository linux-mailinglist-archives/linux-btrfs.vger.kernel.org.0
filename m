Return-Path: <linux-btrfs+bounces-10131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2F9E8816
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BD32807F5
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D883192B79;
	Sun,  8 Dec 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW4TU7EN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A28381AF
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693142; cv=none; b=nekEC1eo9YkhFq6uzguGvo5i+HhZ80qZx1bPAR80jrZNX7KO9kuDSRsYRPpPyoL9rtKQQZjwyN9Ztl0fbT6VlvHK8eW2x1KaohafNtkfHKGE8KWBibsam0uZf0+89rswe3KoRqfByuenEmddiHvJXtUZZt9E5YRZOPbzNcZfSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693142; c=relaxed/simple;
	bh=4fBTm6GWRDi+y4fgfjyyRps5r2D+vUn0YfUD9cQy8Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ytvm1EKE5Pnivqi07JQwMrRVkG/YAw4AzXMyXbJJAzNSiczxIDsWluV/Lw8vxL2cpbSJ9dDCCFzAJ3BFMNKIB2NZGwDORZ3bAYwzanxImU+XOKEagpvt+vVOmaLXG9QnsWWVFdNimcqs6Kr0jQTdSLTEVYSiPJitBoMs/5OEGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW4TU7EN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so29749311fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733693139; x=1734297939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIU7sBFP+kZocCd4cTzZbxuOsUq7OTHo5XHHSV/8oOY=;
        b=nW4TU7ENDaVnTeE6/riy5GosYDGwX3EAUC3ruS0N8E5sm896U5ZzMaFHT7AitsTcCP
         D1++pPLUkoG7XU+CrKIcR5bJTOQYzQXiPr5VhuuN56yULRT1eoVOMri4MrpXugHH26sT
         JWhJIMCR4HuZpn77/Xq+6Z+hXyKxsamRnPZbaYfFQi5iNMzrDi/Xnrx8RbUo6uyDEOv1
         5fwsdyaPmvlT2h8cJbUInaTSZ+EsDon/KhNtbcOk884tfkKAGhmdJ8JnYSGjqB8XIXFZ
         E1h68sInsQLdYLhtD8vjIw2rx8BBp+v6BeIjrcroMaGhwpshY2qF0YiyikU8inNE1kgT
         FvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733693139; x=1734297939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIU7sBFP+kZocCd4cTzZbxuOsUq7OTHo5XHHSV/8oOY=;
        b=bvk9fI30iIo40ZAGZfGcrUYxw2+jxCBppBGiY2MRjOw4qgjyJ4ZPfEei5TM6l94JAb
         YJwT0EvxYTIXB5jH0mRrG06sGwApt0rWjJQmw7+B2uFg8GPCLx2Rb6u7Zxlt8sf9fOzS
         2S+mBgWnHmM/3SobDZYvijBtwqf7sJw0jnud6eUjlBbJEmh+ckXOf7Fd0vcFtG9nuDRa
         yVIi7LzxqZsbL0Pvg4BOEdamgOfaEpXdFbzvIj5lY2y9LlgVZHbC+SAkQAWvmAw1Kura
         qV6572Hum/VagAtiqPnuVv5AwkhkOuiCFq+wWU/xzib+TSLxiiOlm1zMIQiHFEhULmxQ
         /Z5g==
X-Gm-Message-State: AOJu0Yx/aLDMwv2IuFvXJT8CRycm4rK0bAwMMlzLAEu8glSe8zGi2XGv
	eYe1SphEIJpXFMzHDESk3k8VxF0Ghdq1X1xLK7sfJydPd266QIvAzjGJ2ciJrgLxaajinfVdlxI
	0mmQ8U0EC0Kz3RresRHWR2AXPUvbs2FlBW4c=
X-Gm-Gg: ASbGnctRiVxvXxlpZLYIgB4QCyNml1kXGktFSA1f7fik4bJ88jLZ3vaVzwAmgBBW3mm
	NFqj77wJUB+SOuwhH5XDhXp6z2JnCBraF
X-Google-Smtp-Source: AGHT+IE6QNF4esNA/8jODj0v2UTopIcnnfQiAc1+UJSjHoJ/n2ivxHVLzIxDgToHnJsVhxcVzuFGoVJ8qjKpQictApI=
X-Received: by 2002:a2e:bc27:0:b0:2fb:597e:28d9 with SMTP id
 38308e7fff4ca-3002f8e614bmr27589101fa.14.1733693138781; Sun, 08 Dec 2024
 13:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com>
In-Reply-To: <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Sun, 8 Dec 2024 22:25:27 +0100
Message-ID: <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Dec 2024 at 21:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2024/12/9 02:32, j4nn =E5=86=99=E9=81=93:
> > gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdat=
a
> > Unable to find block group for 0
> > Unable to find block group for 0
> > Unable to find block group for 0
>
> This is a common indicator of -ENOSPC.
>
> But according to the fi df output, we should have quite a lot of
> metadata space left.
>
> The only concern is the DUP metadata, which may cause the space
> reservation code not to work in progs.
>
> Have you tried to convert the DUP metadata first?

I am not sure how to do that.
I see the "Multiple block group profiles detected" warning, assumed it
is about metadata in RAID1 and DUP.
But I am not sure how that got created or if it has any benefit or not.
And what that DUP should be converted into?

> And `btrfs fi usage` output please.

gentoo ~ # btrfs fi usage /mnt/data
Overall:
   Device size:                  16.00TiB
   Device allocated:             14.51TiB
   Device unallocated:            1.48TiB
   Device missing:                  0.00B
   Device slack:                    0.00B
   Used:                         14.18TiB
   Free (estimated):            923.95GiB      (min: 923.95GiB)
   Free (statfs, df):           918.95GiB
   Data ratio:                       2.00
   Metadata ratio:                   2.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                 yes      (metadata)

Data,RAID1: Size:7.19TiB, Used:7.03TiB (97.77%)
  /dev/mapper/wdrb-bdata          7.19TiB
  /dev/mapper/wdrc-cdata          7.19TiB

Metadata,RAID1: Size:63.00GiB, Used:58.56GiB (92.95%)
  /dev/mapper/wdrb-bdata         63.00GiB
  /dev/mapper/wdrc-cdata         63.00GiB

Metadata,DUP: Size:5.00GiB, Used:1.18GiB (23.60%)
  /dev/mapper/wdrb-bdata         10.00GiB

System,RAID1: Size:32.00MiB, Used:1.08MiB (3.37%)
  /dev/mapper/wdrb-bdata         32.00MiB
  /dev/mapper/wdrc-cdata         32.00MiB

Unallocated:
  /dev/mapper/wdrb-bdata        755.00GiB
  /dev/mapper/wdrc-cdata        765.00GiB

gentoo ~ # lvs
 LV     VG     Attr       LSize    Pool Origin Data%  Meta%  Move Log
Cpy%Sync Convert
 bdata  wdrb   -wi-ao----    8.00t
 cdata  wdrc   -wi-ao----    8.00t
gentoo ~ # vgs
 VG     #PV #LV #SN Attr   VSize    VFree
 wdrb     1   1   0 wz--n-   <9.10t <1.10t
 wdrc     1   3   0 wz--n-    9.09t     0
gentoo ~ # pvs
 PV         VG     Fmt  Attr PSize    PFree
 /dev/sdb1  wdrc   lvm2 a--     9.09t     0
 /dev/sdd1  wdrb   lvm2 a--    <9.10t <1.10t


> > Tried some balance as found example posted, not really sure if that sho=
uld help:
> >
> > gentoo ~ # btrfs balance start -dusage=3D10 /mnt/data
> > Done, had to relocate 32 out of 7467 chunks
>
> The balance doesn't do much, the overall chunk layout is still the same.
> >
> > gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdat=
a
> > Unable to find block group for 0
> > Unable to find block group for 0
> > Unable to find block group for 0
> > ERROR: failed to clear free space cache
> > extent buffer leak: start 7995086045184 len 16384
>
> Migrating to v2 cache doesn't really need to manually clear the v1 cache.
>
> Just mounting with "space_cache=3Dv2" option will automatically purge the
> v1 cache, just as explained in the man page:
>
>    If v2 is enabled, and v1 space cache will be cleared (at the first
>    mount)
>
> If you want to dig deeper, the implementation is done in
> btrfs_set_free_space_cache_v1_active() which calls
> cleanup_free_space_cache_v1() if @active is false.

Ok, I just followed a howto for the switch.
Did not know it is ok just with the mount option.
Should it be safe to try it if I get the errors with the "btrfs rescue
clear-space-cache v1"?

Thank you.

