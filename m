Return-Path: <linux-btrfs+bounces-2970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FFE86E3CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 15:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D431F25F36
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D83AC01;
	Fri,  1 Mar 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMcoo8/m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35239FE4;
	Fri,  1 Mar 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304965; cv=none; b=cObwbaINFtInFkQ54jMNV+UDtJXHD6s62KzHJWfEH1FcjOG9NQcYv8Hc6AoxmdZi5yKThyC238tRG0WiteIijCUs+6PdPytkkOVdFLcq7/FPw05U7BUh0ty/UlI6/C7S6n4XN9xfo7shBdtnNXk4SWbTLHDHKJ8QtWPj+GyH+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304965; c=relaxed/simple;
	bh=/8e4n4keYQlLa9223HzAGst+I0zKCUGxT4R0w+TpmXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnubKs/SM9g3aJK7pOhrHCQSmIEbB+roOasHigeBy6+TniBxZA6VTJlU4RnEp1js059s78B81ma7K9QIVacpHgHTSZvs7bXfMeu1hEGnHCEA+PmqDmBatMS7E9648YXInrQSO8Ob5zJcpgQ7xQsPBQwhsAvnL3TjtteX4qepGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMcoo8/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F965C433C7;
	Fri,  1 Mar 2024 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709304965;
	bh=/8e4n4keYQlLa9223HzAGst+I0zKCUGxT4R0w+TpmXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vMcoo8/maHaApx6XsoccXyfjZN4jC01DbAZlJOlGQ5+atQADyH0iOG6p5pawvNsrQ
	 QEyhudSqizc4HlNhkw4fbxLHbtR25Ai8kSq1hjP/cuHhk0ld8tgv4Cm+UXpSPoFLCJ
	 NiuL5o+jWQbKgm7SXBNZWjbndMT2BmJ9tQPClHnSGrZMd3wKt8MgmBLsofgNyShqCD
	 0/obgT80bEVCmpBwc6u3mLJE8kVJspN5w1cIU0z/cc7Tvs3yd4qmVnFMF7UZaFX0JH
	 OKhI2r2vBTgwyUtOku2cWDt8ohhmrS7qmEluKZEKsVva0+rHovtB9ZDapS+iHcL96r
	 RwrRBz+BkmShg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a43f922b2c5so272667066b.3;
        Fri, 01 Mar 2024 06:56:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXR3+S2hxw6jfYny+Se99BbDoA44m1BXGxo+QxGgNAZAgRKVGlA2C/eKSgyADe4BMD3Gi9cpuHmI5V28VX6QlYf4zt1r1c9TcX248h/SHHq4mCioUE1Vq6RKK5D8qaxhYHw1w05
X-Gm-Message-State: AOJu0YxovS8MjR0TQc3OuBaHr+Q+pfin8mjFFhuETfl4bBFSDUEuT2bq
	Hq2FqivtAdKvLesEvQqtdlVL0jANHx2N91VlaqpP6Xzxh0/b5JSJPMuMIVL6vvsGaNTSRUyHnjA
	hpk2hiAODKUjv+00uemWIu9fpk9U=
X-Google-Smtp-Source: AGHT+IFn0NauetGFyDbj6fis8Q9V8S8MaCaIN9ppLBTeRUy8gRV0V5p1wJMVVdXHwa+kHf4kytKSTQU9Ks2vMtg9scw=
X-Received: by 2002:a17:906:560e:b0:a44:1b36:22c3 with SMTP id
 f14-20020a170906560e00b00a441b3622c3mr1392318ejq.42.1709304963738; Fri, 01
 Mar 2024 06:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215140236.29171-1-l@damenly.org> <20240301134914.dgcv4vh2jbx2egfp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240301134914.dgcv4vh2jbx2egfp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 1 Mar 2024 14:55:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53QTzMVdJwEJBOyoB3fBem-2zi3FH411JugRDkq9Bqvg@mail.gmail.com>
Message-ID: <CAL3q7H53QTzMVdJwEJBOyoB3fBem-2zi3FH411JugRDkq9Bqvg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
To: Zorro Lang <zlang@redhat.com>
Cc: Su Yue <glass.su@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	l@damenly.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:49=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Thu, Feb 15, 2024 at 10:02:36PM +0800, Su Yue wrote:
> > From: Su Yue <glass.su@suse.com>
> >
> > Because block group tree requires require no-holes feature,
> > _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> > given in MKFS_OPTION.
> > Without explicit _log_writes_cleanup, the two tests fail with
> > logwrites-test device left. And all next tests will fail due to
> > SCRATCH DEVICE EBUSY.
> >
> > Fix it by overriding _cleanup to call _log_writes_cleanup.
> >
> > Signed-off-by: Su Yue <glass.su@suse.com>
> > ---
> >  tests/btrfs/172 | 6 ++++++
> >  tests/btrfs/206 | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/tests/btrfs/172 b/tests/btrfs/172
> > index f5acc6982cd7..fceff56c9d37 100755
> > --- a/tests/btrfs/172
> > +++ b/tests/btrfs/172
> > @@ -13,6 +13,12 @@
> >  . ./common/preamble
> >  _begin_fstest auto quick log replay recoveryloop
> >
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +     _log_writes_cleanup &> /dev/null
>
> This _cleanup will override the default one, so better to copy the
> default cleanup in this function,
>
>   cd /
>   rm -r -f $tmp.*

Zorro,

You had already replied to v2 of this patch with exactly the same comments:

https://lore.kernel.org/fstests/20240225162212.qcidpyb2bhdburl6@dell-per750=
-06-vm-08.rhts.eng.pek2.redhat.com/

It's trivial to do those changes.
Do you expect Su to send yet another version just for that, or could
you amend the patch?

Can you please be more clear in future replies about that, i.e. if you
expect the author to send a new version or if you'll amend the patch
for trivial changes?

Speaking for myself, I very often get confused with your replies, and
I feel that some patches often get stalled for that reason.
Usually with Eryu or Dave that didn't happen, the course of action was clea=
r.

Thanks.

>
> You can refer to btrfs/196 or generic/482 etc.
>
> > +}
> > +
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/dmlogwrites
> > diff --git a/tests/btrfs/206 b/tests/btrfs/206
> > index f6571649076f..e05adf75b67e 100755
> > --- a/tests/btrfs/206
> > +++ b/tests/btrfs/206
> > @@ -14,6 +14,12 @@
> >  . ./common/preamble
> >  _begin_fstest auto quick log replay recoveryloop punch prealloc
> >
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +     _log_writes_cleanup &> /dev/null
>
>
> Same as above.
>
> Thanks,
> Zorro
>
> > +}
> > +
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/dmlogwrites
> > --
> > 2.43.0
> >
> >
>
>

