Return-Path: <linux-btrfs+bounces-10903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09D3A09718
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD65A16368C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600E212FAD;
	Fri, 10 Jan 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfgoEhyw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F60212D7F;
	Fri, 10 Jan 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526043; cv=none; b=Sy8ybXv1q3EY1Eh59aArB95puVylThpsvFZH0oxBt/YmjupgK09sdKgHxSCLO7ke/xxwblyiqhwqAj97QQ8XsPRHAO6oh7LM8yF+iNlntXNLkzg9bRkrRjmBghvv3ZpV8IrCIsRpjQOM3GXkgEjH5pR9RHvDiKAgn17GfBKQwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526043; c=relaxed/simple;
	bh=H3muBgUl5jDNTOyzUYnuQthBzKw6osMvX7NFUAkqlEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh8NY6FS7Z7wK33uKq7G49M4DviLRZFWni5c5ZZjRRC0nsaYyUB6tEDI8Bd/q6oBCjPFTn3kBvTuopLhqpuqc+qfU4dPHqqOlA4Rcth45eXPTjqyQpfNnzgZ02xoq1gB/FZKGIeovHLI5l5tHCM625c/ahCH5ptIn7Ezrfkctp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfgoEhyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A2BC4CEE1;
	Fri, 10 Jan 2025 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526042;
	bh=H3muBgUl5jDNTOyzUYnuQthBzKw6osMvX7NFUAkqlEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kfgoEhyw2OM0HUietLHQ47InMd2Fdz+wJNeJyvRePS7UY3CrQb/O0tZe4jSoSQA59
	 MjOU6O3vMdUZGwvIeubZDsOnpc37rENKI9CH+evAK3K/GNF8Fa2o3S/Ei/LxihDU8b
	 QHssZxn9g7IoT6bUq6rPSFgIKclRbAGhB85Q5Yl3qfUlr0L2U0obI8lUHOaDdnpCIi
	 JO/sI9DnerPOTKHhd0S/s17/HYy0ZX7Q7AcrJY//vM+VcR5av1qLAz/LCUeDCuEKdo
	 o8m313gcs45mVVOczgYMYk5gO0l0Ye/ztK+60EkmRsVLH7QtDIofGrn1tVCM4hz2rz
	 e5QjQgSzBCCgA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso373731066b.1;
        Fri, 10 Jan 2025 08:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYCUr1n3ndIJFgaLdIyBS1tr9vIzxapGd5Lvu6Nm9Yo1QUOKMNHFHCwSa6Y/7UOnTY58ZSYTBLZSFGJw==@vger.kernel.org, AJvYcCXUJM/gp8ljmUrLG06Rr2V/YlGtAzTvKSS4irLJv5NIWrdNEaQxMcADGA62tsCoEiM9+OoxAtiloq3IbXJy@vger.kernel.org
X-Gm-Message-State: AOJu0YycJsxYKo95hnsjmYH3d71gvHSmWcAx/5uBEeI97pbaxxwtzw1Q
	Z+37ygBnhkz8ThcWF7uWOptKlDjdQw7yFypHCOHKH6IScKdlzaAoXkZ5bZMkrCntYNUzwJVPcqx
	yIiK73GIChVreIRC80i9OXBTwr+Y=
X-Google-Smtp-Source: AGHT+IESuokiNaO1+Wxp2hYMqM2n7jehDcUUtHihSmQMRZxIqcjviWYcjBwCAw2vJSvYglWHW2Ye9PMEbxcs70SiHco=
X-Received: by 2002:a17:907:c10:b0:aa6:75bd:eb5 with SMTP id
 a640c23a62f3a-ab2abc94d17mr1040738766b.57.1736526040851; Fri, 10 Jan 2025
 08:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-6-0c7b14c0aac2@kernel.org> <CAL3q7H6=EVN9PokKxsf6MiOo2DRt3N=t2ikm9H7U1FxB+4udCg@mail.gmail.com>
 <e277500a-41dd-4f3e-be74-c23ad692a540@wdc.com>
In-Reply-To: <e277500a-41dd-4f3e-be74-c23ad692a540@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 10 Jan 2025 16:20:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6kXC58uPYVnCVB368NUycGhQiH-pRajnP2WvB=TioHvQ@mail.gmail.com>
X-Gm-Features: AbW1kvZQ3T3kqJ23pBlib1etm0fLAZSmGOW06I_UWXEwgmp9HcdWOszg10Mss6A
Message-ID: <CAL3q7H6kXC58uPYVnCVB368NUycGhQiH-pRajnP2WvB=TioHvQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] btrfs: fix deletion of a range spanning parts
 two RAID stripe extents
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 11:33=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 09.01.25 16:24, Filipe Manana wrote:
> > On Tue, Jan 7, 2025 at 12:50=E2=80=AFPM Johannes Thumshirn <jth@kernel.=
org> wrote:
> >>
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> When a user requests the deletion of a range that spans multiple strip=
e
> >> extents and btrfs_search_slot() returns us the second RAID stripe exte=
nt,
> >> we need to pick the previous item and truncate it, if there's still a
> >> range to delete left, move on to the next item.
> >>
> >> The following diagram illustrates the operation:
> >>
> >>   |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
> >>          |--- keep  ---|--- drop ---|
> >>
> >> While at it, comment the trivial case of a whole item delete as well.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/raid-stripe-tree.c | 28 ++++++++++++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>
> >> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> >> index 79f8f692aaa8f6df2c9482fbd7777c2812528f65..893d963951315abfc734e1=
ca232b3087b7889431 100644
> >> --- a/fs/btrfs/raid-stripe-tree.c
> >> +++ b/fs/btrfs/raid-stripe-tree.c
> >> @@ -103,6 +103,31 @@ int btrfs_delete_raid_extent(struct btrfs_trans_h=
andle *trans, u64 start, u64 le
> >>                  found_end =3D found_start + key.offset;
> >>                  ret =3D 0;
> >>
> >> +               /*
> >> +                * The stripe extent starts before the range we want t=
o delete,
> >> +                * but the range spans more than one stripe extent:
> >> +                *
> >> +                * |--- RAID Stripe Extent ---||--- RAID Stripe Extent=
 ---|
> >> +                *        |--- keep  ---|--- drop ---|
> >> +                *
> >> +                * This means we have to get the previous item, trunca=
te its
> >> +                * length and then restart the search.
> >> +                */
> >> +               if (found_start > start) {
> >> +
> >> +                       ret =3D btrfs_previous_item(stripe_root, path,=
 start,
> >> +                                                 BTRFS_RAID_STRIPE_KE=
Y);
> >> +                       if (ret < 0)
> >> +                               break;
> >> +                       ret =3D 0;
> >> +
> >> +                       leaf =3D path->nodes[0];
> >> +                       slot =3D path->slots[0];
> >> +                       btrfs_item_key_to_cpu(leaf, &key, slot);
> >> +                       found_start =3D key.objectid;
> >> +                       found_end =3D found_start + key.offset;
> >
> > Hum, this isn't safe, ignoring the case where btrfs_previous_item()
> > returns 1, meaning there's no previous item.
> >
> > In that case previous_item() returns pointing to the same leaf and
> > slot, and then below we delete the item instead of trimming it
> > (increasing its range start and decreasing its length).
>
> Good catch!
>
> But what should we do when we end up in this situation? Doesn't that
> mean that either do_free_extent_accounting() passed in a bogus range or
> btrfs_previous_item() should've done one more call to btrfs_pref_leaf()?

When it returns 1 it means there's no previous leaf - the item we
processed was the first in the tree, so any future calls to
btrfs_prev_leaf() will keep returning 1 (unless some other task
inserts smaller keys).
The right thing is probably to log an error telling the target range,
dump the leaf, abort the transaction and return an error.



>

