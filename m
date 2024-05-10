Return-Path: <linux-btrfs+bounces-4889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B28C2366
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE710B24182
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56674175562;
	Fri, 10 May 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjtCawpU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A7175544
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340445; cv=none; b=mz9FcqMa0AyU8ZO3sjYhDHIRdfzZSd26CQ6V7d2YjmsAVAuE+jucra65GJDhuaJ7rdA/nogd4CvxEnenYd529YdtyLf0J++bKX5bkjVSl/TD0I7TpBfdSXBhvREIO4QnI+41FAJLDu5K4Tv85hJlgqSglH5wQZdjDElBy4Jab/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340445; c=relaxed/simple;
	bh=egV6qEq1GnR3xXUz6vs5a85rTdvYa4mBFaGth6q5VHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdxFGQ7d+XEHdXktw/PdwWc6Q9mWcAL1JpIAm9YtpZL2j5J/Ne7fl3in8tGC9qOM7SUJj2YnVrqEvNmRotd4YRNvh8y+gY0DHHB6oDZ7u0NkYlIY2JevhQBLI/E3L/nawtzur4EZC0W//8+yibM/tHkXDWb2jZ7PIFzAWND0TnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjtCawpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B267C32782
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340445;
	bh=egV6qEq1GnR3xXUz6vs5a85rTdvYa4mBFaGth6q5VHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MjtCawpU8D/0OIUSFfmEAjSlvyhdu0CoH0p+NaoYPlowMVcVTcRcBVNSZjkCyTpeg
	 p75/9nMCt8Jufw6PRKLTBXlSFF1x7urm3Ra12kmE32CxRKSAEUFlCdwUYa8AXHXoQ0
	 gNpsz5ZxUN6MkBtf2+VopaJbWbhVa1ZVVJI//mN59tAuszaZ/c6o1f70Kl9pam8ALM
	 bkPydBqDHXCfIMnXrWFT6ohr571x2JWpzs6YtXelV8mP/yBp6UP3v5aVdm/qSiF9DF
	 XAJ5qFAleY7CfP8tN3cazkwO5eBQNhmqIeVhuplUy9M4ylZf7w9FQq4OQApPRafF1i
	 v/gcmGU5DfUHA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso33763211fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 04:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwAo7bzJuMlPZLqlF53wGexXjA8JffWbzDCOhuPSwLYjrsQMgpJM3V1xR/tgi2ugggPPbOSe8lSVTNzMMFmlvWVHwl+8qLiNsAodA=
X-Gm-Message-State: AOJu0YyBeEoashvNX0sLIHScWEyFCy+5/HqwOUqZwMEb1D/79CxyPeG1
	0xAgRq3hgyluAOxjeH30nvhP6dhozzNWpiuulwrt/VNNccxSwleJtFgtTqd3kjitVMPeCnWPV2u
	b/p9h+vCaVATWBbTwQG0hfFw/atM=
X-Google-Smtp-Source: AGHT+IEw0qmKQ1wC2i48Rxtl7G9UwoGfnQR1tt5n9A7f4s9gFtWW2wZxNNk0GF+bYuMq4aoEAHlTS5vK5zShlbwkBnI=
X-Received: by 2002:a2e:3a17:0:b0:2e3:6e32:7a26 with SMTP id
 38308e7fff4ca-2e52039d694mr17664061fa.45.1715340443450; Fri, 10 May 2024
 04:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
 <CAL3q7H7uWw=LnWYXZnZV+kYKho+F4iBcBgZ5GziWeTofVPLDYw@mail.gmail.com> <1fe28d75-a4a3-4304-9998-a88a5fee4919@gmx.com>
In-Reply-To: <1fe28d75-a4a3-4304-9998-a88a5fee4919@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 10 May 2024 12:26:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6rz9Z8xCbsjvqaEQC34m7uiM_FH1ecW+PQC5kARWKxrA@mail.gmail.com>
Message-ID: <CAL3q7H6rz9Z8xCbsjvqaEQC34m7uiM_FH1ecW+PQC5kARWKxrA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] btrfs: introduce new members for extent_map
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/5/10 02:35, Filipe Manana =E5=86=99=E9=81=93:
> > On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Introduce two new members for extent_map:
> >>
> >> - disk_bytenr
> >> - offset
> >>
> >> Both are matching the members with the same name inside
> >> btrfs_file_extent_items.
> >>
> >> For now this patch only touches those members when:
> >>
> >> - Reading btrfs_file_extent_items from disk
> >> - Inserting new holes
> >> - Merging two extent maps
> >>    With the new disk_bytenr and disk_num_bytes, doing merging would be=
 a
> >>    little complex, as we have 3 different cases:
> >>
> >>    * Both extent maps are referring to the same data extent
> >>    * Both extent maps are referring to different data extents, but
> >>      those data extents are adjacent, and extent maps are at head/tail
> >>      of each data extents
> >
> > I have no idea what this last part of the sentence means:
> >
> > "and extent maps are at head/tail of each data extents"
>
> For this case:
>
>          |<- data extent 1 ->|<- data extent 2 ->|
>         |          |////////|////////|          |
>                       FE A      FE B
>
> In above case, FE A is only referring the tailing part of data extent 1,
> and FE B is referring to the heading part of data extent 2.
>
> In that case, FE A and FE B can be merged into something like this:
>
>          |<------ merged extent 1 + 2 --------->|
>         |          |/////////////////|         |
>                         FE A + B
>
> In that case, merged file extent would have:
>
> - disk_bytenr =3D fe_a->disk_bytenr
> - disk_num_bytes =3D fe_a->disk_num_bytes + fe_b->disk_num_bytes
> - ram_bytes =3D fe_a->ram_bytes + fe_b->ram_bytes
> - offset =3D fe_a->offset
> - num_bytes =3D fe_a->num_bytes + fe_b->num_bytes
>
> >
> >>    * One of the extent map is referring to an merged and larger data
> >
> > map -> maps
> > an -> a
> >
> >>      extent that covers both extent maps
> >
> > Not sure if I can understand this. How can one of the extent maps
> > already cover the range of the other extent map?
> > This suggests some overlapping, or most likely I misunderstood what
> > this is trying to say.
>
> That's the for impossible test case 3, but as you mentioned, it's more
> sane just to remove it.
>
> [...]
> >
> >> +        *
> >> +        * The calculation here always merge the data extents first, t=
hen update
> >> +        * @offset using the new data extents.
> >> +        *
> >> +        * For case 1), the merged data extent would be the same.
> >> +        * For case 2), we just merge the two data extents into one.
> >> +        * For case 3), we just got the larger data extent.
> >> +        */
> >> +       new_disk_bytenr =3D min(prev->disk_bytenr, next->disk_bytenr);
> >> +       new_disk_num_bytes =3D max(prev->disk_bytenr + prev->disk_num_=
bytes,
> >> +                                next->disk_bytenr + next->disk_num_by=
tes) -
> >> +                            new_disk_bytenr;
> >
> > So this is confusing, disk_num_bytes being a max between the two
> > extent maps and not their sum.
>
> Check case 1).
>
> Both file extents are referring to the same data extent.
>
> Like this:
>
> FE 1, file pos 0, num_bytes 4K, disk_bytenr X, disk_num_bytes 16K,
> offset 0, ram_bytes 16K, compression none
>
> FE 2, file pos 4k, num_bytes 4K, disk_bytenr X, disk_num_bytes 16K,
> offset 4k, ram_bytes 16K, compression none.
>
> In that case we should not just sum up the disk_num_bytes at all.
> Remember disk_num_bytes are for the data extent.

Yes, but for cases where they refer to different file extent items
that are contiguous on disk, the max is confusing, and a sum is what
makes sense. Example:

FE 1, file pos 0, num_bytes 4K, disk_bytenr X, disk_num_bytes 4K,
offset 0, ram_bytes 4K, no compression

FE 2, file pos 4K, num_bytes 4K, disk_bytenr X + 4K, disk_num_bytes
4K, offset 0, ram_bytes 4K, no compression

When merging the corresponding extent maps it's natural to think
disk_num_bytes is 8K and not 4K.

But as I mentioned before, after merging we really don't use
disk_num_bytes anywhere.
It's only used during extent logging, which only happens for extents
maps that were not merged and can not be before they are logged.

Before this patchset, when disk_num_bytes was named orig_block_len,
that was never updated during merging, exactly because we don't use
cases for it.


>
> > I gather this is modelled after what we already do at
> > btrfs_drop_extent_map_range() when splitting.
> >
> > But the truth is we never used the disk_num_bytes of an extent map
> > that was merged - we also didn't do it before this patch, for that
> > reason.
> > It's only used for logging new extents - which can't be merged - they
> > can be merged only after being logged.
> >
> > We can set this to the sum, or leave with some value to signal it's inv=
alid.
> > Just leave a comment saying disk_num_bytes it's not used anywhere for
> > merged extent maps.
> >
> > In the splitting case at btrfs_drop_extent_map_range() it's what we
> > need since in the case the extent is new and not logged (in the
> > modified list), disk_num_bytes always represents the size of the
> > original, before split, extent.
>
> [...]
>
> >> +       file_extent.disk_bytenr =3D ins.objectid;
> >> +       file_extent.disk_num_bytes =3D ins.offset;
> >> +       file_extent.num_bytes =3D ins.offset;
> >> +       file_extent.ram_bytes =3D ins.offset;
> >> +       file_extent.offset =3D 0;
> >> +       file_extent.compression =3D BTRFS_COMPRESS_NONE;
> >
> > Same as before:
> >
> > "If we always have to initialize all the members of the structure,
> > it's pointless to have it initialized to zeros when we declared it."
> >
> [...]
> >> +       file_extent.disk_bytenr =3D ins.objectid;
> >> +       file_extent.disk_num_bytes =3D ins.offset;
> >> +       file_extent.num_bytes =3D num_bytes;
> >> +       file_extent.ram_bytes =3D ram_bytes;
> >> +       file_extent.offset =3D encoded->unencoded_offset;
> >> +       file_extent.compression =3D compression;
> >
> > Same as before:
> >
> > "If we always have to initialize all the members of the structure,
> > it's pointless to have it initialized to zeros when we declared it."
>
> Fair enough, and an uninitilized structure member can also make compiler
> to warn us.
>
> Thanks,
> Qu
> >
> > The rest I suppose seems fine, but I have to look at the rest of the pa=
tchset.
> >
> > Thanks.
> >
> >>          em =3D create_io_em(inode, start, num_bytes,
> >>                            start - encoded->unencoded_offset, ins.obje=
ctid,
> >>                            ins.offset, ins.offset, ram_bytes, compress=
ion,
> >> -                         BTRFS_ORDERED_COMPRESSED);
> >> +                         &file_extent, BTRFS_ORDERED_COMPRESSED);
> >>          if (IS_ERR(em)) {
> >>                  ret =3D PTR_ERR(em);
> >>                  goto out_free_reserved;
> >> --
> >> 2.45.0
> >>
> >>
> >

