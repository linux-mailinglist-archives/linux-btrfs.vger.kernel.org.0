Return-Path: <linux-btrfs+bounces-2210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A184CAB3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 13:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A5B1C24E39
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 12:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CA5A0F5;
	Wed,  7 Feb 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMc2VFod"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB55A0E1
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308866; cv=none; b=e1LWF3WUYcpx8TiXxLegfm2HYg+NfYQVDP5h3lxqDV16InlQMOvs5mXWXShEKwDmSbXmrqqb6wVKOhFrZIzaT34F4L5K2bLHm8fWeniNuYC5FR4xQtWqd1l1abW6SyT0N6UBH4i5A+3OZggaZpqRHEuC+KGt42XsJ1zzH817JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308866; c=relaxed/simple;
	bh=efL6TlLRbzDHOz24D5m2bR5h/kJRTrcUln+jPoUCiSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asJ1E1O/6JoAd3UhVWqgYR6rdBFln8qOyVucg6ctYU3jYU4XYGUVs9+3tScgoS8ji+0bLot2A5/imPw2OT0aCGRGL1HXrNzVKKc1qTI7dFbOFdIdGoTl3zUAlX+8YDMclCiZzQHvX4K5glRD3N1XEUpOCUbQ3DaXpbiPzeogPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMc2VFod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F1C43394
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707308866;
	bh=efL6TlLRbzDHOz24D5m2bR5h/kJRTrcUln+jPoUCiSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NMc2VFodD4AVS6XA9CIf6xpJ7SlTuMYjihhNm6YYr069mjs2bHWBkpn+MXV88kN7C
	 Svfd4DbbGGiTgb2qruJgk312IgdZjCyaShTzGPRjuGLenvH8rb7rWb1oumfa+rFe+N
	 glwwGGiaBMLTTAMcrAoOvDRTB4EN6lDKgqDa151tTT/zlGWoMfFXf8mKm4eCRkex4K
	 yGu0VfqEatuW5bU6wQVYE6jTXwDjbD+QqCGs/RcKigC5v7Wxh+pL7Ej3Hi3bJeU+0q
	 8YmIzVK331qKxxzj2pWD+qE+ROUO9moRH8/ff5/A67FPUV8W/jxZVXcoAkPXyOhoyx
	 95DKLxmtSRlgg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3850ce741bso63635666b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Feb 2024 04:27:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yy9xMDctPGVnlHDqWsBUPA06l8sAkRZAlSB9xYJCfPnhFyGanmy
	6x7EwQq2fJSDq239Oml//8UMvBYCE5Xo6XyxOyuN1Ag6IPF/Vl1r+D630uU6I2QAZvmIR27/egW
	2MOO57M2F8h7nGsoUzhBNL3T3ZZc=
X-Google-Smtp-Source: AGHT+IG7kekee0g0fh9nHWRN80SIYfDi5pl5dp860jCEDFTxR5fuBLHlR52/pS+I8apDXPRnlOqhBJ/83A2Dun52NCs=
X-Received: by 2002:a17:906:a48:b0:a36:fc15:c6b2 with SMTP id
 x8-20020a1709060a4800b00a36fc15c6b2mr4286142ejf.35.1707308864512; Wed, 07 Feb
 2024 04:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707172743.git.wqu@suse.com> <1e862826f30ce2de104b66572ddfbfd6e2d398a5.1707172743.git.wqu@suse.com>
 <CAL3q7H5OcYGdoriDdOissUntv1+6orr6-JM2s6HjXDCqNvk6qw@mail.gmail.com> <6f730234-f252-47bb-b52f-3eac960c863e@gmx.com>
In-Reply-To: <6f730234-f252-47bb-b52f-3eac960c863e@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 Feb 2024 12:27:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7nbjJhZiE+VMxBui5zgEGBNjO+J=SF9WrmtRETpT8P_g@mail.gmail.com>
Message-ID: <CAL3q7H7nbjJhZiE+VMxBui5zgEGBNjO+J=SF9WrmtRETpT8P_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: defrag: allow fine-tuning on lone extent
 defrag behavior
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 8:50=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> On 2024/2/7 03:33, Filipe Manana wrote:
> > On Mon, Feb 5, 2024 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Previously we're using a fixed ratio and fixed bytes for lone extents
> >> defragging, which may not fit all situations.
> >>
> >> This patch would enhance the behavior by allowing fine-tuning using so=
me
> >> extra members inside btrfs_ioctl_defrag_range_args.
> >>
> >> This would introduce two flags and two new members:
> >>
> >> - BTRFS_DEFRAG_RANGE_LONE_RATIO and BTRFS_DEFRAG_RANGE_LONE_WASTED_BYT=
ES
> >>    With these flags set, defrag would consider lone extents with their
> >>    utilization ratio and wasted bytes as a defrag condition.
> >>
> >> - lone_ratio
> >>    This is a u32 value, but only [0, 65536] is allowed (still beyond u=
16
> >>    range, thus have to go u32).
> >>    0 means disable lone ratio detection.
> >>    [1, 65536] means the ratio. If a lone extent is utilizing less than
> >>    (lone_ratio / 65536) * on-disk size of an extent, it would be
> >>    considered as a defrag target.
> >>
> >> - lone_wasted_bytes
> >>    This is a u32 value.
> >>    If we free the lone extent, and can free up to @lone_wasted_bytes
> >>    (excluding the extent itself), then it would be considered as a def=
rag
> >>    target.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/defrag.c          | 40 ++++++++++++++++++++++++------------=
--
> >>   fs/btrfs/ioctl.c           |  9 +++++++++
> >>   include/uapi/linux/btrfs.h | 28 +++++++++++++++++++++-----
> >>   3 files changed, 57 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> >> index 85c6e45d0cd4..3566845ee3e6 100644
> >> --- a/fs/btrfs/defrag.c
> >> +++ b/fs/btrfs/defrag.c
> >> @@ -958,26 +958,28 @@ struct defrag_target_range {
> >>    * any adjacent ones), but we may still want to defrag them, to free=
 up
> >>    * some space if possible.
> >>    */
> >> -static bool should_defrag_under_utilized(struct extent_map *em)
> >> +static bool should_defrag_under_utilized(struct extent_map *em, u32 l=
one_ratio,
> >> +                                        u32 lone_wasted_bytes)
> >>   {
> >>          /*
> >>           * Ratio based check.
> >>           *
> >> -        * If the current extent is only utilizing 1/16 of its on-disk=
 size,
> >> +        * If the current extent is only utilizing less than
> >> +        * (%lone_ratio/65536) of its on-disk size,
> >
> > I really don't understand what this notation "(%lone_ratio/65536)" mean=
s...
>
> That means the ratio is between [0, 65536].
>
> 0 means disable ratio check, 1 means 1/65536 of the on-disk size and
> 65536 mean 65536/65536 of the on-disk size (aka, all regular extents
> would meet the ratio)
>
> As normally we don't do any float inside kernel, the ratio must be some
> unsigned int/long based.
>
> Any better ideas on the description?
>
> >
> >>           * it's definitely under-utilized, and defragging it may free=
 up
> >>           * the whole extent.
> >>           */
> >> -       if (em->len < em->orig_block_len / 16)
> >> +       if (lone_ratio && em->len < em->orig_block_len * lone_ratio / =
65536)
> >
> > Why don't you use SZ_64K everywhere instead of 65536?
>
> Maybe for the ratio, I should use some macro to define the division base.
>
> >
> >>                  return true;
> >>
> >>          /*
> >>           * Wasted space based check.
> >>           *
> >> -        * If we can free up at least 16MiB, then it may be a good ide=
a
> >> -        * to defrag.
> >> +        * If we can free up at least @lone_wasted_bytes, then it may =
be a
> >> +        * good idea to defrag.
> >>           */
> >>          if (em->len < em->orig_block_len &&
> >> -           em->orig_block_len - em->len > SZ_16M)
> >> +           em->orig_block_len - em->len > lone_wasted_bytes)
> >
> > According to the comment it should be >=3D. So either fix the comment,
> > or the comparison.
>
> OK, would change that.
>
> [...]
> >> +
> >> +       /*
> >> +        * If we defrag a lone extent (has no adjacent file extent) ca=
n free
> >
> > Using this term "lone" is confusing for me, and this description also
> > suggests it's about a file with only one extent.
> > I would call it wasted_ratio, and the other one wasted_bytes, without
> > the "lone" in the name.
>
> The "lone" would describe a file extent without non-hole neighbor file
> extent, thus I though "lone" would be good enough, but it's not.
> >
> > Because a case like this:
> >
> > xfs_io -f -c "pwrite 0 4K" $MNT/foobar
> > sync
> > xfs_io -c "pwrite 8K 128M" $MNT/foobar
> > sync
> > xfs_io -c "truncate 16K" $MNT/foobar
> > btrfs filesystem defrag $MNT/foobar
> >
> > There's an adjacent extent, it's simply not mergeable, but we want to
> > rewrite the second extent to avoid pinning 128M - 8K of data space.
> > A similar example with a next extent that is not mergeable is also
> > doable, or examples with previous and next extents that aren't
> > mergeable.
>
> Yeah, such extent would always have hole neighbors, just not mergeable.
> Thus "lone" is not good enough.
>
> >
> > And I still don't get the logic of using 65536... Why not have the
> > ratio as an integer between 0 and 99? That's a lot more intuitive
> > IMO...
>
> The choose of 65536 is to make the division faster, as regular division
> is always slow no matter whatever arch we're one.
> "/ 65536" would be optimized by compiler to ">> 4".
>
> But I guess I'm over optimizing here?

Honestly I don't even know how to answer you...

I would be surprised if integer divisions are that heavy in the
context of defrag... probably not even 1% of the time is spent on
divisions.

And really exposing an interface that requires a ratio with such an
odd formula to optimize divisions, is really ugly, odd and confusing
for users.
Specially taking into account that it even leaks to the user interface
in btrfs-progs, as looking into the btrfs-progs patch I see the
following:

+ --lone-ratio <ratio>
+ For a lone file extent (which has no adjacent file exctent), if its utili=
zing
+ less than (ratio / 65536) of the on-disk extent size, it would also
be defraged
+ for its potential to free up the on-disk extent.
+
+ Valid values are in the range [0, 65536].

A percentage, in the integer range from 1 to 99% for example, is a lot
more user friendly, intuitive, obvious.

Thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >> +        * up more space than this value (in bytes), it would be consi=
dered
> >> +        * as a defrag target.
> >> +        */
> >> +       __u32 lone_wasted_bytes;
> >> +
> >>          /* spare for later */
> >> -       __u32 unused[4];
> >> +       __u32 unused[2];
> >>   };
> >>
> >>
> >> --
> >> 2.43.0
> >>
> >>
> >

