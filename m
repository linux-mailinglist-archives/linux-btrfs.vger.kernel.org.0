Return-Path: <linux-btrfs+bounces-3179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1F8781B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 15:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806BA286FF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409740BF9;
	Mon, 11 Mar 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV8Wpwsr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4640BE1
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167713; cv=none; b=alGLxcE2C9lilM64geQlpY3IRlMxKZOrqu7owZhoAIpcmhRO32+00jKz2eN9M+DeLLXTdL3nUYklDs8Whfdo9fXPtNbb+WDnMh73ANaJ/fWZQE6Gp0K/qEqJixfJkGSTXL/Nv9Ha8M3d//8qGzbNrOTiPTibPC5leCWsZlsFOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167713; c=relaxed/simple;
	bh=g5wwBuijHwLZaanPyI8VdU/ZIQA2OMstrXknCUvPLbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6mtFtAJ3r2dhHC3hiEjQvPhV90imWRtzapRQz8sYZgrcZrk+o6pVmtDKaMy4X8yjFlZPuiQ71YQysORZ4VZTXpkbuBpFPxYalO7WQTOU86doVL5629F5iyo14xjKe+iqG8RTFiboxIP3NUJPyCTkohWks15wlWbT6ib04d4VQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV8Wpwsr; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a1fa3cf5eeso655880eaf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710167711; x=1710772511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5wwBuijHwLZaanPyI8VdU/ZIQA2OMstrXknCUvPLbk=;
        b=PV8WpwsrdharFiv9s4LDTRETAEXGVnGaYfQiEHsF7G6DFLecABXh7ebwLo3fulxpew
         UC6KqT7PzN1weslcbigiNcXAMGdrD5EzXRyZWzxVJaVVbuyTfq7HCYkrZv/Unm7RFvi4
         QE2D2yC+qtvKp7IUQ9XY1sxFZzO5+jLDss/UB66sIiJnpAETxBYUtPHnEAK9FdmZmTOQ
         8OxNnZ5u+N/MEmhH+/Ooxm5o67W3Qe0VBGJll9Txe2zQqw5ZePsaxzO9AFdj0891gsOk
         f7iaLRrElkxFbH6eCXZDtYJWlAErrNaXAI8MVDVVtolBmNJU9B2YXeZdJUr46zpXinMb
         kC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167711; x=1710772511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5wwBuijHwLZaanPyI8VdU/ZIQA2OMstrXknCUvPLbk=;
        b=GTgPoEdV4r6vqIWxQvWsAjfqS3wuI7xrhMzzVHE6V5pws36mJAeAX1LgQ0AsFU1xEg
         JVajkyW6J3yMJlF3AZ1HluFKa7EUVl2UYtjc9KT6mYwd3KhGV1vTOi+75C/as2vH88eU
         v6sMCl+STqbRvb5TKao6QThVGkFE4kg7NPUiDZHL+JnCm8wM6t69KCnSGA3OdnUfpLo+
         dmJyY/aUHI+RTr93K7lO7nppVim8ij1bAuRtNIs0TK9UcNoETAgwIKMd6EGg+ibSPcJE
         mbxtc2+5jKZ6t0RNRMmw2AW6TX4jsTBA6Y8EVoqU9g0QlgTTN1dbbvrew3lmEcDwC4PY
         XF+A==
X-Gm-Message-State: AOJu0YxBtWuJldo+VqWbagt5xfuaf3krfjwWfNEbttGXDh5SnEZuAtLf
	emN643VU4xilJBUId0EMUOn6aFE2vXpj6smYIcHIRHpoosyTh4c54d23OR+d1FwybrYawfxYjOp
	oI8R2oFgMXouUy3TsEC40PTbt7no=
X-Google-Smtp-Source: AGHT+IHOToVkvVs3mxKMK/aDCl7rvUDQiQzfgwtrTT85c5vmJMdWpgol7QLOgUr91EsWw2osbhi4l9ZyH/tzDkZ2awg=
X-Received: by 2002:a05:6358:5286:b0:17e:68ac:6435 with SMTP id
 g6-20020a056358528600b0017e68ac6435mr689377rwa.8.1710167710766; Mon, 11 Mar
 2024 07:35:10 -0700 (PDT)
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
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com> <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
In-Reply-To: <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
From: Kai Krakow <hurikhan77+btrfs@gmail.com>
Date: Mon, 11 Mar 2024 15:34:44 +0100
Message-ID: <CAMthOuO56J5OhCnedJLxTuFxTPq7ryCGP_TxMrcXS+4jLj0aiA@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: Forza <forza@tnonline.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	Matthew Warren <matthewwarren101010@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Am So., 10. M=C3=A4rz 2024 um 19:18 Uhr schrieb Forza <forza@tnonline.net>:
>
>
>
> On 2024-03-08 22:58, Matt Zagrabelny wrote:
> > On Fri, Mar 8, 2024 at 3:54=E2=80=AFPM Matthew Warren
> > <matthewwarren101010@gmail.com> wrote:
> >>
> >> On Fri, Mar 8, 2024 at 4:48=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn=
.edu> wrote:
> >>>
> >>> Hi Qu and Matthew,
> >>>
> >>> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matthew Warren
> >>> <matthewwarren101010@gmail.com> wrote:
> >>>>
> >>>> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.u=
mn.edu> wrote:
> >>>>>
> >>>>> Greetings,
> >>>>>
> >>>>> I've read some conflicting info online about the best way to have a
> >>>>> raid1 btrfs root device.

I think the main issue here that leads to conflicting ideas is:

Grub records the locations (or extent index) of the boot files during
re-configuration for non-trivial filesystems. If you later move the
files, or need to switch to the mirror, it will no longer be able to
read the boot files. Grub doesn't have a full btrfs implementation to
read all the metadata, nor does it know or detect the member devices
of the pool. So in this context, it supports btrfs raid1 under certain
conditions, if, and only if, just two devices are used, and the grub
device remains the same. If you add a third device, both raid1 stripes
for boot files may end up on devices of the pool that grub doesn't
consider. As an example, bees is known to mess up grub boot on btrfs
because it relocates the boot files without letting grub know:
https://github.com/Zygo/bees/issues/249

I'd argue that grub can only boot reliably from single-device btrfs
unless you move boot file extents without re-configuring it. Grub only
has very basic support for btrfs.

mdadm for ESP is not supported for very similar reasons (because EFI
doesn't open the filesystem read-only): It will break the mirror.

The best way, as outlined in the thread already, is two have two ESP,
not put the kernel boot files in btrfs but in ESP instead, and adjust
your kernel-install plugins to mirror the boot files to the other ESP
partition.

Personally, I've got a USB stick where I keep a copy of my ESP created
with major configuration changes (e.g. major kernel update, boot
configuration changes), and the ESP is also included in my daily
backup. I keep blank reserve partitions on all other devices which I
can copy the ESP to in case of disaster. This serves an additional
purpose of keeping some part of the devices trimmed for wear-leveling.


> >>>>>
> >>>>> I've got two disks, with identical partitioning and I tried the
> >>>>> following scenario (call it scenario 1):
> >>>>>
> >>>>> partition 1: EFI
> >>>>> partition 2: btrfs RAID1 (/)
> >>>>>
> >>>>> There are some docs that claim that the above is possible...
> >>>>
> >>>> This is definitely possible. I use it on both my server and desktop =
with GRUB.
> >>>
> >>> Are there any docs you follow for this setup?
> >>>
> >>> Thanks for the info!
> >>>
> >>> -m
> >>
> >> The main important thing is that mdadm has several metadata versions.
> >> Versions 0.9 and 1.0 store the metadata at the end of the partition
> >> which allows UEFI to think the filesystem is EFI rather than mdadm
> >> raid.
> >> https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-ver=
sions_of_the_version-1_superblock
> >>
> >> I followed the arch wiki for setting it up, so here's what I followed.
> >> https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_software_=
RAID1
> >
> > Thanks for the hints. Hopefully there aren't any more unexpected issues=
.
> >
> > Cheers!
> >
> > -m
> >
>
> An alternative to mdadm is to simply have separate ESP partitions on
> each device. You can manually copy the contents between the two if you
> were to update the EFI bootloader. This way you can keep the 'other' ESP
> as backup during GRUB/EFI updates.
>
> This solution is what I use on one of my servers. GRUB2 supports Btrfs
> RAID1 so you do not need to have the kernel and initramfs on the ESP,
> though that works very well too.
>
> Good Luck!
>
> ~Forza

Regards,
Kai

