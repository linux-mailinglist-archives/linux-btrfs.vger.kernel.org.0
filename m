Return-Path: <linux-btrfs+bounces-1361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEC68299A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D471C25A6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AE47F57;
	Wed, 10 Jan 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5G8AHBk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F604CB39;
	Wed, 10 Jan 2024 11:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7588C433A6;
	Wed, 10 Jan 2024 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704887057;
	bh=Jmw8wSq2Lmym4LTn+EPUUNqMjAmmRyoITXyDdYPs5OI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g5G8AHBkvnpyT/diGNZrlLUSH9ElTbMePJuZOpdwUZOZnNH7z1UHVkgRbFYKGdsW8
	 nnMoGenbVHKZ1GMCjhFRnXcPbG+N51dJSJRDfK0W43DYq9uxedHq6aVF+2eEMDniTf
	 NX2IBmajI971yb+TQsphykGHFy/Umo7FZNSQn5fTj4p0FlanpBE40lBT9xqdK4eHvY
	 PTfs0voLcCAxhwOQcYyUstYrFr9961ReMrezfAXOHJV6643fmhTSLIi258wY1H8ED5
	 7k4N9JrrnbZ9KHMSJOglfc7e3VlwIz+edL+2ZCZXlcQwal/rqsIV/ErqgjOYUqbP2n
	 kZxxGP16USUuQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2adc52f213so325648266b.0;
        Wed, 10 Jan 2024 03:44:17 -0800 (PST)
X-Gm-Message-State: AOJu0YwiAhndRa8eVtxZqsySY81ah9UXm/NBty/VlHZVFMjhPeauQnLh
	nd5Ch1/Vug0uFKCGb5yGswcV4wuwPAJdSXhWsEw=
X-Google-Smtp-Source: AGHT+IGXX0A6N0d/UZrIdrom4CojUCM5Rsn4OuqmU75TcF1sPqNZyXNM7eAzbkvq72xKRJ29mFmSD533tnaokk0cuk4=
X-Received: by 2002:a17:907:7205:b0:a28:a940:5305 with SMTP id
 dr5-20020a170907720500b00a28a9405305mr696168ejc.6.1704887056150; Wed, 10 Jan
 2024 03:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d35011f8afe8bd55c1f0318b0d2515ea10eac7f.1704839283.git.wqu@suse.com>
 <20240110005428.GN28693@twin.jikos.cz>
In-Reply-To: <20240110005428.GN28693@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Jan 2024 11:43:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJubfpsVLF6H4qJnKCUR1w@mail.gmail.com>
Message-ID: <CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJubfpsVLF6H4qJnKCUR1w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:55=E2=80=AFAM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Wed, Jan 10, 2024 at 08:58:26AM +1030, Qu Wenruo wrote:
> > Add extra sanity check for btrfs_ioctl_defrag_range_args::flags.
> >
> > This is not really to enhance fuzzing tests, but as a preparation for
> > future expansion on btrfs_ioctl_defrag_range_args.
> >
> > In the future we're adding new members, allowing more fine tuning for
> > btrfs defrag.
> > Without the -ENONOTSUPP error, there would be no way to detect if the
> > kernel supports those new defrag features.
> >
> > cc: stable@vger.kernel.org #4.14+
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to misc-next, thanks.
>
> > ---
> >  fs/btrfs/ioctl.c           | 4 ++++
> >  include/uapi/linux/btrfs.h | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index a1743904202b..3a846b983b28 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -2608,6 +2608,10 @@ static int btrfs_ioctl_defrag(struct file *file,=
 void __user *argp)
> >                               ret =3D -EFAULT;
> >                               goto out;
> >                       }
> > +                     if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP)=
 {
> > +                             ret =3D -EOPNOTSUPP;
>
> This should be EINVAL, this is for invalid parameter values or
> combinations, EOPNOTSUPP would be for the whole ioctl as not supported.

I'm confused now.
We return EOPNOTSUPP for a lot of ioctls when they are given an
unknown flag, for example
at btrfs_ioctl_scrub():

if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
    ret =3D -EOPNOTSUPP;
    goto out;
}

Or at btrfs_ioctl_snap_create_v2():

if (vol_args->flags & ~BTRFS_SUBVOL_CREATE_ARGS_MASK) {
   ret =3D -EOPNOTSUPP;
   goto free_args;
}

We also do similar for fallocate, at btrfs_fallocate():

if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
        FALLOC_FL_ZERO_RANGE))
    return -EOPNOTSUPP;

I was under the expectation that EOPNOTSUPP is the correct thing to do
in this patch.
So what's different in this patch from those existing examples to
justify EINVAL instead?

Thanks.

>

