Return-Path: <linux-btrfs+bounces-1365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF661829DE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 16:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6B1C229E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56614C3C3;
	Wed, 10 Jan 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii6CCIu6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB84C3AC;
	Wed, 10 Jan 2024 15:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A359BC433C7;
	Wed, 10 Jan 2024 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704901733;
	bh=3lRPiWOcHW5DzNVyRsTxkC2cqTMnSyW9WMv0JYC/Ny4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ii6CCIu6pPIF6fBSR7g7F8fejQZIQukBEcGxGpGAf2AwvonA2gcRbnJHu3lgBXs05
	 apQilbyjzknJBvi3ZmXio34NE1MZesVIv1+wyZr3GNiJ4R+nYkY/at+6e3hA5bePUI
	 Iec5DDJ9YcYn89GsSEfA9eAh+kv1ntv+2LrYQ+cl3L7dTEJE6V47/X04M10Kqihs//
	 55k+0Jq93NsYroZNJmScCjPdN8CbjixBZHu0MLUuSQsNEXUPK1YpJ3ULbYFv+30AsF
	 BKNnL8uYMm3R8vnfPr6YGHTFmnIEEx47WsSginTJvfmC5lSEajzxJBh4hW/8Dua6SG
	 JCXpMnlVXOzgw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a271a28aeb4so457767866b.2;
        Wed, 10 Jan 2024 07:48:53 -0800 (PST)
X-Gm-Message-State: AOJu0YwYIWlu0fyWbFkJnErQteXHlJwVNvxwgaMznISJHOJ4uCF/Od5T
	DiSgT24sprRoe4gvp/w08rWKmSUXBDSVOBivNEA=
X-Google-Smtp-Source: AGHT+IHPqN6Vfhhu5r5vYn6exfhfha7AZJOR9my/AW4pjx54GOzctNcrQ1TjE1f2T7LLWGF0Uf3u4X6/++a1kdpGJ0g=
X-Received: by 2002:a17:907:7f28:b0:a2b:9580:c447 with SMTP id
 qf40-20020a1709077f2800b00a2b9580c447mr954929ejc.110.1704901732086; Wed, 10
 Jan 2024 07:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d35011f8afe8bd55c1f0318b0d2515ea10eac7f.1704839283.git.wqu@suse.com>
 <20240110005428.GN28693@twin.jikos.cz> <CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJubfpsVLF6H4qJnKCUR1w@mail.gmail.com>
 <20240110144434.GU28693@twin.jikos.cz>
In-Reply-To: <20240110144434.GU28693@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Jan 2024 15:48:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H55UPbk9NTSnvpe+oRg54gbn4YaJSEkR7B=AkTTtagzFw@mail.gmail.com>
Message-ID: <CAL3q7H55UPbk9NTSnvpe+oRg54gbn4YaJSEkR7B=AkTTtagzFw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:44=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Jan 10, 2024 at 11:43:39AM +0000, Filipe Manana wrote:
> > On Wed, Jan 10, 2024 at 12:55=E2=80=AFAM David Sterba <dsterba@suse.cz>=
 wrote:
> > >
> > > On Wed, Jan 10, 2024 at 08:58:26AM +1030, Qu Wenruo wrote:
> > > > Add extra sanity check for btrfs_ioctl_defrag_range_args::flags.
> > > >
> > > > This is not really to enhance fuzzing tests, but as a preparation f=
or
> > > > future expansion on btrfs_ioctl_defrag_range_args.
> > > >
> > > > In the future we're adding new members, allowing more fine tuning f=
or
> > > > btrfs defrag.
> > > > Without the -ENONOTSUPP error, there would be no way to detect if t=
he
> > > > kernel supports those new defrag features.
> > > >
> > > > cc: stable@vger.kernel.org #4.14+
> > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > >
> > > Added to misc-next, thanks.
> > >
> > > > ---
> > > >  fs/btrfs/ioctl.c           | 4 ++++
> > > >  include/uapi/linux/btrfs.h | 2 ++
> > > >  2 files changed, 6 insertions(+)
> > > >
> > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > index a1743904202b..3a846b983b28 100644
> > > > --- a/fs/btrfs/ioctl.c
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -2608,6 +2608,10 @@ static int btrfs_ioctl_defrag(struct file *f=
ile, void __user *argp)
> > > >                               ret =3D -EFAULT;
> > > >                               goto out;
> > > >                       }
> > > > +                     if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_S=
UPP) {
> > > > +                             ret =3D -EOPNOTSUPP;
> > >
> > > This should be EINVAL, this is for invalid parameter values or
> > > combinations, EOPNOTSUPP would be for the whole ioctl as not supporte=
d.
> >
> > I'm confused now.
> > We return EOPNOTSUPP for a lot of ioctls when they are given an
> > unknown flag, for example
> > at btrfs_ioctl_scrub():
> >
> > if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
> >     ret =3D -EOPNOTSUPP;
> >     goto out;
> > }
> >
> > Or at btrfs_ioctl_snap_create_v2():
> >
> > if (vol_args->flags & ~BTRFS_SUBVOL_CREATE_ARGS_MASK) {
> >    ret =3D -EOPNOTSUPP;
> >    goto free_args;
> > }
> >
> > We also do similar for fallocate, at btrfs_fallocate():
> >
> > if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> >         FALLOC_FL_ZERO_RANGE))
> >     return -EOPNOTSUPP;
> >
> > I was under the expectation that EOPNOTSUPP is the correct thing to do
> > in this patch.
> > So what's different in this patch from those existing examples to
> > justify EINVAL instead?
>
> Seems that we indeed do EOPNOTSUPP for unsupported flags while EINVAL is
> for invalid parameters, altough there's
>
> btrfs_ioctl_send()
>
> 8113         if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
> 8114                 ret =3D -EINVAL;
> 8115                 goto out;
> 8116         }
> 8117
>
> Either way it should be consistent, so the send flag check is a mistake.
> I'll update the patch from Qu back to EOPNOTSUPP. Thanks.

Ok, with that:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

