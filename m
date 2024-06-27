Return-Path: <linux-btrfs+bounces-6025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FA91AED0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 20:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355EEB266F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867719AA41;
	Thu, 27 Jun 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9/5fsQT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080C14D6EB;
	Thu, 27 Jun 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511940; cv=none; b=N9CE103C5wlKIhOycnBH7iUHrDxxHGWtAercF4o6dj4M0g883S6Q1T198TdKRIVHLNTvae5cYXX2nUa7IZaIjCiXMc6Dbe3CENqPaOyRd7T1jhIpbc6vfpP7B/37W81Txa6iypVw/bNZOPExE/ZkiH55DnDk2SPpLWT5MqGqPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511940; c=relaxed/simple;
	bh=OYVUmimzC+TvNSegkksz4Keghwa/Gc7iuy9ka0pwQKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekac0giEJkL+Lyx/Ug+BlfxOqGXlvG1R6pWIKxP3bgo5wl3bKRm8lnQKDFgIAsrXtqLbZW1D0Ncz7ECYa/WbW35RunE5WxP+HcvJ24SoqWHxAmALZoKmMGgIYp1Tt2sQzkTOJ13kFL/mwKwUj4VTnHQwrGHbyfRoh7CXkS56LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9/5fsQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F888C2BD10;
	Thu, 27 Jun 2024 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719511939;
	bh=OYVUmimzC+TvNSegkksz4Keghwa/Gc7iuy9ka0pwQKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B9/5fsQTTQ3CtM7MDAV1yo8iftTV+exZwWdomIBAZG2/bfKliJv2VKIJs1vw6ut5g
	 Yy9E+e+DF8o4r96AR6dVT2BQyHeM5eaM6PuuweS4q4CkSEWJURQ6zWEHAbo0dS6FDK
	 hnWYMvcGh6oc1WHhE6IsZrOHpA9bUMp6oVYfPm3ILewPzkaleOyXISqjE0PDBcU9RG
	 jgEpRz0EN+/b73bhCvwmABr8VZRJm3vLMbpVzHi87hLdiruK9YDeHu6kZKZjLMJnAT
	 lIwFv5I6y0q7gpoJ+yzTTsdkXmIGAORACRQCSchRo9wjYqkcUnLTTdBwO8YRGHywRz
	 MWsAezBfCwVsw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6fe617966fso576190666b.1;
        Thu, 27 Jun 2024 11:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6QZkB13To1XQ2Pjup1yUXBhT2C6unMAypPYtHNdR1PF0+6RaAAZDcXWBW2VKK3LK4d03Nc+1sU/v63ZIUbg3OLocOZ/jHP+HH1+7Kpn4hg5UM5F/MMQ8LeqanFPINMokmuvh2JnjXaF8=
X-Gm-Message-State: AOJu0Yx7pdqP4ld2xg1R1t4I4C5LZDqNUFoI/1/a4OSJbSpq/2zG6NdX
	I+6h6k0LHnr76fbRu9tc3dqrZrnvxLyXI8cXKpt0Aue5ZXaVD+YVSeVVU4N6+qswZ+8Kjves04M
	5kacYmvjmRp/gDrVrdfc+kw1hSJ0=
X-Google-Smtp-Source: AGHT+IFHVtQbez85EoPPqQzNHxI1X+g/RnpQVeqJhcVKIcxQ63lpzuzQlEvErvaKluSrBv0VPFDDpfgaNHHzTFo7jwE=
X-Received: by 2002:a17:906:d99:b0:a6f:5318:b8f0 with SMTP id
 a640c23a62f3a-a7245b80ea1mr868287866b.37.1719511938093; Thu, 27 Jun 2024
 11:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76d879d2-200d-4b15-8fab-fcd382a4c3e2@gmail.com>
In-Reply-To: <76d879d2-200d-4b15-8fab-fcd382a4c3e2@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Jun 2024 19:11:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7p6EYDG9k66bxDZZrfTQPaiEiZOnFFbov2C3EuRMVLZg@mail.gmail.com>
Message-ID: <CAL3q7H7p6EYDG9k66bxDZZrfTQPaiEiZOnFFbov2C3EuRMVLZg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPROBLEM=5D_make_randconfig=3A_fs=2Fbtrfs=2Fref=2Dverify=2Ec?=
	=?UTF-8?Q?=3A500=3A16=3A_error=3A_=E2=80=98ret=E2=80=99_may_be_used_uninitialized_in_this_?=
	=?UTF-8?Q?function_=5B=2DWerror=3Dmaybe=2Duninitialized=5D?=
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:07=E2=80=AFPM Mirsad Todorovac <mtodorovac69@gmai=
l.com> wrote:
>
> Hi all,
>
> After following Boris' advice in https://lore.kernel.org/lkml/20240404134=
142.GCZg6uFh_ZSzUFLChd@fat_crate.local/
> on using the randconfig test, this is the second catch:
>
> KCONFIG_SEED=3D0xEE80059C
>
> marvin@defiant:~/linux/kernel/linux_torvalds$ time nice make -j 36 bindeb=
-pkg |& tee ../err-6.10-rc5-05a.log; date
>   GEN     debian
> dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes -R'm=
ake -f debian/rules' -j1 -a$(cat debian/arch)
> dpkg-buildpackage: info: source package linux-upstream
> dpkg-buildpackage: info: source version 6.10.0-rc5-gafcd48134c58-27
> dpkg-buildpackage: info: source distribution jammy
> dpkg-buildpackage: info: source changed by marvin <marvin@defiant>
> dpkg-architecture: warning: specified GNU system type i686-linux-gnu does=
 not match CC system type x86_64-linux-gnu, try setting a correct CC enviro=
nment variable
>  dpkg-source --before-build .
> dpkg-buildpackage: info: host architecture i386
>  make -f debian/rules binary
> #
> # No change to .config
> #
>   CALL    scripts/checksyscalls.sh
>   UPD     init/utsversion-tmp.h
>   CC      init/version.o
>   AR      init/built-in.a
>   CHK     kernel/kheaders_data.tar.xz
>   CC [M]  fs/btrfs/ref-verify.o
>   AR      fs/built-in.a
> fs/btrfs/ref-verify.c: In function =E2=80=98process_extent_item.isra=E2=
=80=99:
> fs/btrfs/ref-verify.c:500:16: error: =E2=80=98ret=E2=80=99 may be used un=
initialized in this function [-Werror=3Dmaybe-uninitialized]
>   500 |         return ret;
>       |                ^~~
> cc1: all warnings being treated as errors
> make[7]: *** [scripts/Makefile.build:244: fs/btrfs/ref-verify.o] Error 1
> make[6]: *** [scripts/Makefile.build:485: fs/btrfs] Error 2
> make[5]: *** [scripts/Makefile.build:485: fs] Error 2
> make[4]: *** [Makefile:1934: .] Error 2
> make[3]: *** [debian/rules:74: build-arch] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess returned=
 exit status 2
> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
> make[1]: *** [/home/marvin/linux/kernel/linux_torvalds/Makefile:1555: bin=
deb-pkg] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>
> real    0m2.583s
> user    0m9.943s
> sys     0m5.607s
> Thu Jun 27 19:14:55 CEST 2024
> marvin@defiant:~/linux/kernel/linux_torvalds$
>
> This fix does nothing to the algorithm, but it silences compiler -Werror=
=3Dmaybe-uninitialised

You've reported this before, and there's a fix [1] for it in the
btrfs' github repo, for-next branch. It's not yet in Linus' tree.

[1] https://lore.kernel.org/linux-btrfs/612bf950d478214e8b76bdd7c22dd6a9913=
37b15.1719143259.git.fdmanana@suse.com/

>
> ---
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index cf531255ab76..0b5ff30e2d81 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -459,6 +459,8 @@ static int process_extent_item(struct btrfs_fs_info *=
fs_info,
>                 iref =3D (struct btrfs_extent_inline_ref *)(ei + 1);
>         }
>
> +       ret =3D -EINVAL;
> +

This is not correct.
This would result in failure if we have an extent item without any
inline references (only keyed references following the extent item).

Thanks.

>         ptr =3D (unsigned long)iref;
>         end =3D (unsigned long)ei + item_size;
>         while (ptr < end) {
> ---
>
> Hope this helps.
>
> Best regards,
> Mirsad Todorovac
>

