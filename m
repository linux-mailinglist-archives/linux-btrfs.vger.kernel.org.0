Return-Path: <linux-btrfs+bounces-9172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592679B0BA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5221F28BD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49926216E02;
	Fri, 25 Oct 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb8mmSMY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E682161F6;
	Fri, 25 Oct 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877097; cv=none; b=Z6WUqd5UWWwEP1a6a5/CdMtYTyBaa+ZHyktFlsCat1ZM75l01ba9pMPr5+T8vodsXeN9AFbfK+iRNIhFB0fl+E7PiGRqDZx878nCApXNxosj5x8C4OBfMkHXiLhZAzoGpQT69t38cNC/Ff3wG1xFD6a0DDlko0rwakv4kMiQ8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877097; c=relaxed/simple;
	bh=g5SAADmxk34xbNyEaNiJC7dDY6WbAYIAcDLeEEJ2MXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKq3StQ1afANywP17fL6sT7m5nFt93vuV1CvQBtNf9XZuAX6PyiKz/ESUB0eRsTC5uJzejnPf+IgQZX1QZkXBPYZ/Wv2O4u3hYg3olmTWdHWpXTinChatA0r3a2a5xhPwvTlm0HjVTgMAvshI3/VurzhYax/VIthCw3OTxDQa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb8mmSMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06158C4CEE3;
	Fri, 25 Oct 2024 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729877097;
	bh=g5SAADmxk34xbNyEaNiJC7dDY6WbAYIAcDLeEEJ2MXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eb8mmSMYkA8ORww/RhTaKWaaDgD59gHfoTl6AWWE9Q/ULjkYCtlfWUMa9ZiFeLFKe
	 /OOPvYjYBLc2bXv4HQzWoM5ukIRe9n0NO6lbKTwYLPEDsOabn72mcu6EImQCY/wpou
	 ZtdxEIjB7GSKRcp4YTW6ilqqxXTwZkD+z58TvYsNrRM+U4Rpz/nj/CB2djTMm+ym0R
	 tevGHICqixuswAzkeG3uwnReHLtBrgxaxRqr6+ELEEJujneAWk0Sxtdn1d6rkhmb5v
	 dYl+hbn1PfX9926krLeDvUPLl2ekHR/EaSjYOtQ2pXJQGHSb38BnaFAODURsQs/ayG
	 oPv4w1rCijjgw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f2b95775so2690069e87.1;
        Fri, 25 Oct 2024 10:24:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVv+fTvFFFyxY7Q34OkPgZgp4xDijua4X14UeugARw67jgTUt63CYN4quPwUbqdtAzfkidSiVRMSbVapg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tgoDDXCC+KVwq3MVjoJaEFi4+Vf2+zIU1SjAbNGfyd+mkI8H
	iAVGsjNnQYSinr84dSZVf0HCd0lmJh/q4n34zyYc/d3vcj8B8btW/v9TaBK//MFx9MzxyDHCX0M
	FlLiQlGyl2E9h+mmB7fJzeRjNjtM=
X-Google-Smtp-Source: AGHT+IFFmDO+g6/9VUjoPadBNHrBEQ14sWCYoKxaLQT23g97b/BthSGaKmYxcRP3GGYe41PE4EF476tYemSZgH/b5I4=
X-Received: by 2002:ac2:4c47:0:b0:53b:154c:f75d with SMTP id
 2adb3069b0e04-53b1a34d059mr10247497e87.31.1729877095310; Fri, 25 Oct 2024
 10:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
 <20241025165348.dgtgksykvpkfh3mb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20241025165348.dgtgksykvpkfh3mb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Oct 2024 18:24:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77vJf0ggZjDBZyAgCJ02SPhBKyKR3hDngdL_SM6Qs=Gw@mail.gmail.com>
Message-ID: <CAL3q7H77vJf0ggZjDBZyAgCJ02SPhBKyKR3hDngdL_SM6Qs=Gw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test remount with "compress" clears "compress-force"
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:53=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, Oct 25, 2024 at 12:27:01PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that remounting with the "compress" mount option clears the
> > "compress-force" mount option previously specified.
> >
> > This tests a regression introduced with kernel 6.8 and recently fixed b=
y
> > the following kernel commit:
> >
> >   3510e684b8f6 ("btrfs: clear force-compress on remount when compress m=
ount option is given")
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/323     | 39 +++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/323.out |  2 ++
> >  2 files changed, 41 insertions(+)
> >  create mode 100755 tests/btrfs/323
> >  create mode 100644 tests/btrfs/323.out
> >
> > diff --git a/tests/btrfs/323 b/tests/btrfs/323
> > new file mode 100755
> > index 00000000..fd2e2250
> > --- /dev/null
> > +++ b/tests/btrfs/323
> > @@ -0,0 +1,39 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# Test that remounting with the "compress" mount option clears the
> > +# "compress-force" mount option previously specified.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick mount remount compress
> > +
> > +_require_scratch
> > +
> > +_fixed_by_kernel_commit 3510e684b8f6 \
> > +     "btrfs: clear force-compress on remount when compress mount optio=
n is given"
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount -o compress-force=3Dzlib:9
> > +
> > +# Confirm we have compress-force with zlib:9
> > +_mount | grep $SCRATCH_DEV | grep -q 'compress-force=3Dzlib:9'
>
> How about:
>
> grep -wq 'compress-force=3Dzlib:9' <(findmnt -rncv -S $SCRATCH_DEV -o OPT=
IONS)

Sure, works for me.
I've just sent a v2 with that change.

Thanks.

>
> > +if [ $? -ne 0 ]; then
> > +     echo "compress-force not set to zlib:9 after initial mount:"
> > +     _mount | grep $SCRATCH_DEV
> > +fi
> > +
> > +# Remount with compress=3Dzlib:4, which should clear compress-force an=
d set the
> > +# algorithm to zlib:4.
> > +_scratch_remount compress=3Dzlib:4
> > +
> > +_mount | grep $SCRATCH_DEV | grep -q 'compress=3Dzlib:4'
>
> Same as above.
>
> Others looks good to me.
>
> Thanks,
> Zorro
>
> > +if [ $? -ne 0 ]; then
> > +     echo "compress not set to zlib:4 after remount:"
> > +     _mount | grep $SCRATCH_DEV
> > +fi
> > +
> > +echo "Silence is golden"
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> > new file mode 100644
> > index 00000000..5dba9b5f
> > --- /dev/null
> > +++ b/tests/btrfs/323.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 323
> > +Silence is golden
> > --
> > 2.43.0
> >
> >
>

