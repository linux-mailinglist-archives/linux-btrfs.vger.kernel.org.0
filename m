Return-Path: <linux-btrfs+bounces-6251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC2928F77
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 01:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7BEB22165
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD371487DA;
	Fri,  5 Jul 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdJGOwVx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D113D608;
	Fri,  5 Jul 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720220996; cv=none; b=pDmVyxjPjKb7hatTuYgJ7lLSVAWwiF6ZFSPoEgmYwJYU4jAWZHG6HzEDho3Lsr6WpaGtu2l7VPzKeUFjChOvbSv0bCiUcTlfoW3z3c1plsiU7ma/VHE++5JaA8Is1Khs+IWftYR+LbNHWeMo/gKBbk9RVjCifywbOZ7N1Pf9wGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720220996; c=relaxed/simple;
	bh=/afWkT3diQaULeNGYyQ3tiVGSL/Fhl+aZ4/fZZDMk9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD6ekBvx48aK3ReAKW4N7ipWci5PEMk3KtEpAsi+rPrxiT6gB1U0HAykyWOB5Sng6fCxYZ9432dJ30IMTMGhIbjQd2sGiFYrjCBuAj8lA8JaitbHS9EsVco+6KlIC5APa8RYyAHGHdrmEBfYniBIvDpgmfJZx+v8yfpABasndjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdJGOwVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB3AC116B1;
	Fri,  5 Jul 2024 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720220996;
	bh=/afWkT3diQaULeNGYyQ3tiVGSL/Fhl+aZ4/fZZDMk9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HdJGOwVxSjGJnLpZT/wO4eZ3FfhcNY2E9u6Qn0SzgN1CgKqiWCBSQBOaLwbkHbEeR
	 2Br7yS0j05Ove5ZJFrUo//7W0oa7Vzlu5a6ETcyJs4zcJL8+jObK1qBLgU+jh+UtiI
	 Bb2d0NPL53wkUBlaRa3/WcAsCWBfcEb7jhB6h52oEcXJF5/YqvCE20j+RTR9DS4aIB
	 BR/2xEXdMcCxaD2SXDusvWeGC5B1SfJhLaOYk5gynDeW9zA3n/U3FfnKNI04OA3Bgo
	 PnOoELIBvviWr0j05ICysSXR6VA44s9+M/xOTd+NC5wfXbzdchwzJUGxZHHzu8GdCh
	 efs/Pl2R24KLw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a75131ce948so250042866b.2;
        Fri, 05 Jul 2024 16:09:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVdx5nvoFTt7AfCkp83ffUIWXMj1sl4VTx2e7xVGyaVPdl6y2ZgxeKC1YoLszzR3lgBhN+XzD7RF9bD1vnttXPgEGV1qnuZAnGehqU1SBtElXQwSlewaGY6oTUFyBwpb+HjfR8Tp9STh8=
X-Gm-Message-State: AOJu0YzD5ZYqwxhdmxqU+1eUg8wUAjYFg2nQrg7SSTzdMqFc5rwK4+rs
	1ELRuDqRAu+qEw69PVc9qWdl4Tf8LBGcYYnCQkRRvfrVEDsaqfFmGjYS/WWPFJ4F3lF78i9x02+
	nfU/Ee50ZaZcovxgH5UrYdICMILE=
X-Google-Smtp-Source: AGHT+IHBICGkT7g/ZDelEWQHHQyEaLSVOtC9as5w/GSZSbNdXWnpSIMaSqpBB+qOyOo9LHryGDCySfTPt2SETHlYLXI=
X-Received: by 2002:a17:906:40d0:b0:a72:5bb9:b140 with SMTP id
 a640c23a62f3a-a77ba7123abmr363137466b.54.1720220994932; Fri, 05 Jul 2024
 16:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com> <CABXGCsM4tCH1wHtH0awV8J4eXWL57daMEbbuq_a_vSCEgQDqUQ@mail.gmail.com>
In-Reply-To: <CABXGCsM4tCH1wHtH0awV8J4eXWL57daMEbbuq_a_vSCEgQDqUQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 6 Jul 2024 00:09:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H54-NXwzAenDde9djjqm30KkaqGdp6ABCZC57WTYpV_5A@mail.gmail.com>
Message-ID: <CAL3q7H54-NXwzAenDde9djjqm30KkaqGdp6ABCZC57WTYpV_5A@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:36=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Thu, Jul 4, 2024 at 10:25=E2=80=AFPM Filipe Manana <fdmanana@kernel.or=
g> wrote:
> >
> > So several different things to try here:
> >
> > 1) First let's check that the problem is really a consequence of the sh=
rinker.
> >     Try this patch:
> >
> >     https://gist.githubusercontent.com/fdmanana/b44abaade0000d28ba0e1e1=
ae3ac4fee/raw/5c9bf0beb5aa156b893be2837c9244d035962c74/gistfile1.txt
> >
> >     This disables the shrinker. This is just to confirm if I'm looking
> > in the right direction, if your problem is the same as Mikhail's and
> > double check his bisection.
>
> [1]
> I can't check it because the patch is unapplyable on top of 661e504db04c.
> > git apply debug-1.patch
> error: patch failed: fs/btrfs/super.c:2410
> error: fs/btrfs/super.c: patch does not apply
> > cat debug-1.patch
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f05cce7c8b8d..06c0db641d18 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2410,8 +2410,10 @@ static const struct super_operations btrfs_super_o=
ps =3D {
>         .statfs         =3D btrfs_statfs,
>         .freeze_fs      =3D btrfs_freeze,
>         .unfreeze_fs    =3D btrfs_unfreeze,
> +       /*
>         .nr_cached_objects =3D btrfs_nr_cached_objects,
>         .free_cached_objects =3D btrfs_free_cached_objects,
> +       */
>  };
>
>  static const struct file_operations btrfs_ctl_fops =3D {
>
>
>
> > 2) Then drop that patch that disables the shrinker.
> >      With all the previous 4 patches applied, apply this one on top of =
them:
> >
> >      https://gist.githubusercontent.com/fdmanana/9cea16ca56594f8c7e20b6=
7dc66c6c94/raw/557bd5f6b37b65d210218f8da8987b74bfe5e515/gistfile1.txt
> >
> >      The goal here is to see if the extent map eviction done by the
> > shrinker is making reads from other tasks too slow, and check if
> > that's what0s making your system unresponsive.
> >
>
> [2]
> 6.10.0-rc6-661e504db04c-test2
> up  1:00
> root         269 15.5  0.0      0     0 ?        R    10:23   9:20 [kswap=
d0]
> up  2:02
> root         269 21.6  0.0      0     0 ?        S    10:23  26:27 [kswap=
d0]
> up  3:10
> root         269 25.2  0.0      0     0 ?        R    10:23  48:11 [kswap=
d0]
> up  4:04
> root         269 29.0  0.0      0     0 ?        S    10:23  71:12 [kswap=
d0]
> up  5:04
> root         269 26.8  0.0      0     0 ?        R    10:23  81:47 [kswap=
d0]
> up  6:07
> root         269 27.9  0.0      0     0 ?        R    10:23 102:40 [kswap=
d0]
> dmesg attached below as 6.10.0-rc6-661e504db04c-test2.zip
>
> > 3) Then drop the patch from step 2), and on top of the previous 4
> > patches from my git tree, apply this one:
> >
> >      https://gist.githubusercontent.com/fdmanana/a7c9c2abb69c978cf5b80c=
2f784243d5/raw/b4cca964904d3ec15c74e36ccf111a3a2f530520/gistfile1.txt
> >
> >      This is just to confirm if we do have concurrent calls to the
> > shrinker, as the tracing seems to suggest, and where the negative
> > numbers come from.
> >      It also helps to check if not allowing concurrent calls to it, by
> > skipping if it's already running, helps making the problems go away.
>
> [3]
> 6.10.0-rc6-661e504db04c-test3
> up  1:00
> root         269 18.6  0.0      0     0 ?        S    17:09  11:12 [kswap=
d0]
> up  2:00
> root         269 23.7  0.0      0     0 ?        R    17:09  28:30 [kswap=
d0]
> up  3:00
> root         269 27.0  0.0      0     0 ?        S    17:09  48:47 [kswap=
d0]
> up  4:00
> root         269 28.8  0.0      0     0 ?        S    17:09  69:10 [kswap=
d0]
> up  5:00
> root         269 32.0  0.0      0     0 ?        S    17:09  96:17 [kswap=
d0]
> up  6:00
> root         269 29.7  0.0      0     0 ?        S    17:09 107:12 [kswap=
d0]
> dmesg attached below as 6.10.0-rc6-661e504db04c-test3.zip
>
> As we can see, the time of kswapd0 has increased significantly. It was
> 30 min in 6 hours it became 100 min. That is, it became three times
> worse even with proposed patches (1-4).

Can you try the following two branches based on 6.10-rc6?

1)  https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/=
?h=3Dtest1_em_shrinker_6.10

2)  https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/=
?h=3Dtest2_em_shrinker_6.10

Even if the first one makes things good, also try the second one please.

The first just includes some changes for the next merge window (for
6.11) that might help speedup things.
The second just has a change that would be simple to add to 6.10 and
we'll probably always want it or some variation of it.

Thanks!

>
> --
> Best Regards,
> Mike Gavrilov.

