Return-Path: <linux-btrfs+bounces-3223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2C879449
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2CD1C23452
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD856B92;
	Tue, 12 Mar 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlJHN3nO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3B1EA95
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247185; cv=none; b=YlShhxY//GKYbiPZekrcsZcow2jmB8WqQBLDO/ez6QJ/07lM5rZZ8LJpIW2KSPYitq6HrhnliryvZK8AqmIf+9zR2B7sUOKvqpROA9B6sVeenQcLIw/b0JgstSu8pQwBOMWe/GEADuLSPjGiT4l4MldHSavWGqXk4DHn6W94m90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247185; c=relaxed/simple;
	bh=JrLOHxrQvSRrvzF8+NkRSbTS5vvxT/3ZMfBfXPE8BIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlR1RQ2gs2xfk7OGcOGj7tDaLM7rkXRA9B8jFX8OC6Sxq2QM/tsM63jNQEQRp1amkb53NnqZmVfxGywIIGkmnoHylPxBURjhWLaU4kFJwPUyF1oJ1XtNgS/WT45ZIkHQP5xSjTPOheO+l+C+Epu9viNYavkOAXGdIs78Xg/Ea3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlJHN3nO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42f0df98361so24380151cf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710247182; x=1710851982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Wantg+e6guzVSkthB0+MTUCVVZShGG9yUM/Yl9cSpg=;
        b=AlJHN3nOY/27wBYDvJhTj2fmZ/cnjpL9PhMa+GTFaVSRT1AFfcjdLX+d2te1xsPOu8
         vwdGWI9NDRlsQuL9KKU93/ganvPgBUcNWsGlTCZF+xJgeg8GOO8YNwybwbbpiWje9YbN
         lYld8L5ihFzqQ1aMY7h6XJvNB0PM9bfwOp+SAUuWJtY7kOmghkh7Jn5QUY+Kzi/Ubub1
         kjSPeQao1RTx+wkmrmgaeVx9Zlm76xhitLUPYmNd4vHPC5ELj+gRTccPZ2UeLC4Bdcws
         jdm9Dkzcuonv3qrxR00AJrSwTzitHdOGfGyQbsaahu15fftxZxypKxa0dJ+YN4lCT1Pn
         zw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710247182; x=1710851982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Wantg+e6guzVSkthB0+MTUCVVZShGG9yUM/Yl9cSpg=;
        b=fuXBw0FfK4N3sSPNuRHEKb00E4t/sJXdJxAvZ7gbMZdEZ34MOzNGO4fcBFEQcPLRAn
         dv5nY4lgVbpeDBqZNwNY8auwpxw7dkSu/Qhvf+EfjF4g6ZcevRNSzR+s/P2o+Xr60AME
         sAojEKt67J9ufL13UlQ26GxT7nj/hKFeqjcg5lWDvRZMgrBc0vhRJJ38c7sNONB1QgE1
         Q/jBfxdXVqaNZ5b3IdNQJy7olvBWpdcCFoVolLmfGdgS+2z4BLwcZVZN2x/8YfQ9zKt3
         IHvew5htaqqrn7YVoixWZM/e5JoPb9VO6j+mXzecrHTU05CzoT/e3X7wUXsI+Sw0J5JA
         OHsw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Dkwd7lT7Bz1H2gSYI3NharaS3hZ8T8LMMW5WVJOlWAgBuWpH/KYOC35ejweKTYFkmJJ/JQuI4WNfr7BcPu+B8cgEIoPy3gX/qP8=
X-Gm-Message-State: AOJu0YywbQ+kZocPHkdnSS0VjFwvD4ZlG9LkllTM6DDVIwha39pZ1P9e
	P8/WwBrYuhW8DtbPf/UQbr3yed/QqxWIkAGgGjoIaUKd+Suse7P1WEmcEyM2qk/g0TZPIAaX5P2
	RRX4A606LnhkErpDlmCtJk7VLNEhoNIQn
X-Google-Smtp-Source: AGHT+IE0WU56U3SGOfHlLYyHHzbHj+TRl2Fp9U+bV++zaksoQmSYoigEXyBuplYA85ftPHAwL+dKpznRlZsSRNT0Z4c=
X-Received: by 2002:a05:622a:14c:b0:42e:7afb:b5c0 with SMTP id
 v12-20020a05622a014c00b0042e7afbb5c0mr106772qtw.17.1710247182473; Tue, 12 Mar
 2024 05:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
 <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
 <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net> <CAMthOuO56J5OhCnedJLxTuFxTPq7ryCGP_TxMrcXS+4jLj0aiA@mail.gmail.com>
 <4feb955c-cc91-4f0b-8e62-b6a089eea7ae@libero.it>
In-Reply-To: <4feb955c-cc91-4f0b-8e62-b6a089eea7ae@libero.it>
From: Kai Krakow <hurikhan77+btrfs@gmail.com>
Date: Tue, 12 Mar 2024 13:39:16 +0100
Message-ID: <CAMthOuPQDMWGOA9O+StwnmUhZXxsF3ePZKMBgDZdPZ8gxQ+sdg@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: kreijack@inwind.it
Cc: Forza <forza@tnonline.net>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	Matthew Warren <matthewwarren101010@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 11. M=C3=A4rz 2024 um 20:26 Uhr schrieb Goffredo Baroncelli
<kreijack@libero.it>:
>
> On 11/03/2024 15.34, Kai Krakow wrote:
> > Hello!
> >
> > Am So., 10. M=C3=A4rz 2024 um 19:18 Uhr schrieb Forza <forza@tnonline.n=
et>:
> >>
> >>
> >>
> >> On 2024-03-08 22:58, Matt Zagrabelny wrote:
> >>> On Fri, Mar 8, 2024 at 3:54=E2=80=AFPM Matthew Warren
> >>> <matthewwarren101010@gmail.com> wrote:
> >>>>
> >>>> On Fri, Mar 8, 2024 at 4:48=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.u=
mn.edu> wrote:
> >>>>>
> >>>>> Hi Qu and Matthew,
> >>>>>
> >>>>> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matthew Warren
> >>>>> <matthewwarren101010@gmail.com> wrote:
> >>>>>>
> >>>>>> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d=
.umn.edu> wrote:
> >>>>>>>
> >>>>>>> Greetings,
> >>>>>>>
> >>>>>>> I've read some conflicting info online about the best way to have=
 a
> >>>>>>> raid1 btrfs root device.
> >
> > I think the main issue here that leads to conflicting ideas is:
> >
> > Grub records the locations (or extent index) of the boot files during
> > re-configuration for non-trivial filesystems. If you later move the
> > files, or need to switch to the mirror, it will no longer be able to
> > read the boot files. Grub doesn't have a full btrfs implementation to
> > read all the metadata, nor does it know or detect the member devices
> > of the pool.
>
> I don't think that what you describe is really accurate. Grub (in the NON=
 uefi version)
> stores some code in the first 2MB of the disk (this is one of the reason =
why fdisk by
> default starts the first partition at the 1st MB of the disk). This code =
is mapped as
> you wrote. And if you mess with this disk area grub gets confused.

I've looked into the source code, and it seems the btrfs code is very
basic. It looks like it could handle multiple devices. But it clearly
cannot handle some of the extent flags, doesn't handle compressed
extents (bees, as in my example, does create such extents), has
problems with holes and inline extents (indicated by the source code
comments) and requires extents to be contiguous to read data reliably.

> And the btrfs grub module is stored in this area. After this module is lo=
aded, grub
> has a full access to a btrfs partition.
>
> The fact in some condition grub is not able to access anymore to a btrfs =
filesystem
> is more related to a not mature btrfs implementation in grub.

Agreed.

> I am quite sure that grub access a btrfs filesystem dynamically, without =
using a
> pre-stored table with the location of a file.

Yes, it probably can work its way through the various trees but the
extent resolver and reader is very basic.

This means, at least for now: do not let anything touch the boot files
grub is using, and do not use compression, then it SHOULD work well
most of the time.

I'd still avoid complex filesystems involved in the grub booting process.


> To verify that, try to access a random file or directory in a btrfs locat=
ion (e.g.
> ls /bin) that is not related to a 'boot' process.
>
> > So in this context, it supports btrfs raid1 under certain
> > conditions, if, and only if, just two devices are used, and the grub
> > device remains the same. If you add a third device, both raid1 stripes
> > for boot files may end up on devices of the pool that grub doesn't
> > consider. As an example, bees is known to mess up grub boot on btrfs
> > because it relocates the boot files without letting grub know:
> > https://github.com/Zygo/bees/issues/249
> >
> > I'd argue that grub can only boot reliably from single-device btrfs
> > unless you move boot file extents without re-configuring it. Grub only
> > has very basic support for btrfs.
> >
> > mdadm for ESP is not supported for very similar reasons (because EFI
> > doesn't open the filesystem read-only): It will break the mirror.
> >
> > The best way, as outlined in the thread already, is two have two ESP,
> > not put the kernel boot files in btrfs but in ESP instead, and adjust
> > your kernel-install plugins to mirror the boot files to the other ESP
> > partition.
> >
> > Personally, I've got a USB stick where I keep a copy of my ESP created
> > with major configuration changes (e.g. major kernel update, boot
> > configuration changes), and the ESP is also included in my daily
> > backup. I keep blank reserve partitions on all other devices which I
> > can copy the ESP to in case of disaster. This serves an additional
> > purpose of keeping some part of the devices trimmed for wear-leveling.
> >
> >
> >>>>>>>
> >>>>>>> I've got two disks, with identical partitioning and I tried the
> >>>>>>> following scenario (call it scenario 1):
> >>>>>>>
> >>>>>>> partition 1: EFI
> >>>>>>> partition 2: btrfs RAID1 (/)
> >>>>>>>
> >>>>>>> There are some docs that claim that the above is possible...
> >>>>>>
> >>>>>> This is definitely possible. I use it on both my server and deskto=
p with GRUB.
> >>>>>
> >>>>> Are there any docs you follow for this setup?
> >>>>>
> >>>>> Thanks for the info!
> >>>>>
> >>>>> -m
> >>>>
> >>>> The main important thing is that mdadm has several metadata versions=
.
> >>>> Versions 0.9 and 1.0 store the metadata at the end of the partition
> >>>> which allows UEFI to think the filesystem is EFI rather than mdadm
> >>>> raid.
> >>>> https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-v=
ersions_of_the_version-1_superblock
> >>>>
> >>>> I followed the arch wiki for setting it up, so here's what I followe=
d.
> >>>> https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_softwar=
e_RAID1
> >>>
> >>> Thanks for the hints. Hopefully there aren't any more unexpected issu=
es.
> >>>
> >>> Cheers!
> >>>
> >>> -m
> >>>
> >>
> >> An alternative to mdadm is to simply have separate ESP partitions on
> >> each device. You can manually copy the contents between the two if you
> >> were to update the EFI bootloader. This way you can keep the 'other' E=
SP
> >> as backup during GRUB/EFI updates.
> >>
> >> This solution is what I use on one of my servers. GRUB2 supports Btrfs
> >> RAID1 so you do not need to have the kernel and initramfs on the ESP,
> >> though that works very well too.
> >>
> >> Good Luck!
> >>
> >> ~Forza
> >
> > Regards,
> > Kai
> >
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>

