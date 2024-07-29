Return-Path: <linux-btrfs+bounces-6840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77393F8AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C761F21CD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FBB15572F;
	Mon, 29 Jul 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSxFJY7m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27121534EC
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264557; cv=none; b=IUuAl8c/yRe5yoobcdqCsW0Crkfrwy9riVFCa488xtCJBuOtw6h4iPzUpC2G6j52A+QrEI+98IxStNszPMh2bqZI4IdVgdnkocfr1Zqj/mS6zRrG81dHoB27UTVFpVVclMVLjS6tXPEQXIfb4xGXluYlzcq3v0FF2u2H0c3Uz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264557; c=relaxed/simple;
	bh=lyPtXi+Ba1R0g2phtFOPgumdPjunHaTSaQFlQqk8ikc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRCaEW1gvlzQScRV/1JFhX9sv2e3bsl0HL/mQhpT/P3k3gk8pQuvOOO0R1fW/CSmPjjOa2N782zNTZ6f5c3jzt27KtA+xnltHrDoKeQFHD3HIgorVDXVATbog4dztbbNPgRFFR99gNfACUMu8rwa64+aqOirNCSCoevNcfCbKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSxFJY7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4E4C4AF0C
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264557;
	bh=lyPtXi+Ba1R0g2phtFOPgumdPjunHaTSaQFlQqk8ikc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GSxFJY7mohpQXob6tLaV9tr4DceHhai8zX0lY6dulCRdSXeK1u/UprKzfKTqHN5+M
	 N3gzShuMehELNL+QXY6+aBYqbu5dxOe1w06ry/LXI8T5wR52zlxfZNncDmMewJlC3z
	 a4xkB6hcQTgOsD2NB11DOoS5//nGFd5LuzfGNkEuyAZzCs9gtOgOVM/FoudGHKoGyR
	 /GA9UYnBAbXziqszfzkZPuOnuVT/Y9y6FfCdld+5SAOno/jpRT7d7ZuNlrEnWx6oKH
	 rh2uazrY2SZC3f6mYTdNqfzEc7zeDX8Pl2QknqXIGl1l8Kl5SUEbLsJQILMpMZOLCq
	 O18adyKSScOBQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so4994430a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 07:49:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlCZVWM2EqoCmJLoenOgoZB0lQ/8q2zoUVjtj8UjB1b4C7SyeppmoWD4htLy1x+HKhlt8+G/zAtpxIakGGKYdoVv695a8tBaIrwIg=
X-Gm-Message-State: AOJu0YwLr+eT6LQRAZGaUIFlAelW/YJ47YAYyqIdWjZYl63UzoqnctaE
	+USRgpt2qBpX75R0Z/3GWWXwD9HGlvBPj+Z2xCVMuZsgoeG8vjTZ4YGuHbioCyyf+XWA0DErlYL
	M5Pzq75uSwEoawo/4onggX2au3Rs=
X-Google-Smtp-Source: AGHT+IH1Zvi9pnjYihXPAgf3u+Jnjs7iHuKbetQxzEg1caFuPYNsZRQSPpyEtjLDe8NDpHlkPRtiGfNx3pid3ZqmFo0=
X-Received: by 2002:a17:907:2da8:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a7d3f856f22mr792999366b.9.1722264555859; Mon, 29 Jul 2024
 07:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
 <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com> <20240729144150.GA3589837@perftesting>
In-Reply-To: <20240729144150.GA3589837@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Jul 2024 15:48:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Nbo=0=kM8-sWv3KO9Xbki+zwyD8gyVgDu87dESBwMbw@mail.gmail.com>
Message-ID: <CAL3q7H5Nbo=0=kM8-sWv3KO9Xbki+zwyD8gyVgDu87dESBwMbw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
To: Josef Bacik <josef@toxicpanda.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:41=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Mon, Jul 29, 2024 at 12:46:48PM +0100, Filipe Manana wrote:
> > On Mon, Jul 29, 2024 at 9:33=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.=
com> wrote:
> > >
> > > __btrfs_add_free_space_zoned() references and modifies BG's alloc_off=
set,
> > > ro, and zone_unusable, but without taking the lock. It is mostly safe
> > > because they monotonically increase (at least for now) and this funct=
ion is
> > > mostly called by a transaction commit, which is serialized by itself.
> > >
> > > Still, taking the lock is a safer and correct option and I'm going to=
 add a
> > > change to reset zone_unusable while a block group is still alive. So,=
 add
> > > locking around the operations.
> > >
> > > Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> > > CC: stable@vger.kernel.org # 5.15+
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/free-space-cache.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.=
c
> > > index f5996a43db24..51263d6dac36 100644
> > > --- a/fs/btrfs/free-space-cache.c
> > > +++ b/fs/btrfs/free-space-cache.c
> > > @@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struc=
t btrfs_block_group *block_group,
> > >         u64 offset =3D bytenr - block_group->start;
> > >         u64 to_free, to_unusable;
> > >         int bg_reclaim_threshold =3D 0;
> > > -       bool initial =3D ((size =3D=3D block_group->length) && (block=
_group->alloc_offset =3D=3D 0));
> > > +       bool initial;
> > >         u64 reclaimable_unusable;
> > >
> > > -       WARN_ON(!initial && offset + size > block_group->zone_capacit=
y);
> > > +       guard(spinlock)(&block_group->lock);
> >
> > What's this guard thing and why do we use it only here? We don't use
> > it anywhere else in btrfs' code base.
> > A quick search in the Documentation directory of the kernel and I
> > can't find anything there.
> > In the fs/ directory there's only two users of it.
> >
>
> It's relatively new, it's like the C++ guards.  If you look in the VFS we=
've
> started using it pretty heavily there.
>
> But it does need to be documented, if you look at include/linux/cleanup.h=
 it has
> documentation about it.
>
> > Why not the usual spin_lock(&block_group->lock) call?
>
> Because this is nice for error handling.  Here it doesn't look as helpful=
, but
> look at d842379313a2 ("fs: use guard for namespace_sem in statmount()") f=
or an
> example of how much it cleans up the error paths.
>
> FWIW one of the tasks I have for one of our new people is to come through=
 and
> utilize some of this new infrastructure to cleanup our error paths, so wh=
ile it
> doesn't exist yet inside btrfs, I hope it gets used pretty liberally.  Th=
anks,

I see, I figured it was something to avoid repeating unlock calls.

But rather than fixing a bug and doing the migration in a single
patch, I'd rather have 1 patch to fix the bug and another to the
migration afterwards.

Thanks.

>
> Josef

