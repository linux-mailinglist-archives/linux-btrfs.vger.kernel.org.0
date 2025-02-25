Return-Path: <linux-btrfs+bounces-11777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904FA44586
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09421688EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4018B476;
	Tue, 25 Feb 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9eo6Dhh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487118B475
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499854; cv=none; b=kYjiqqfffa1FMg+WVtyHg+PrNAVmdzOK6uDmpTSUxzLzsDxH33baIZqOiwPF2JA/cYPkFiTthmbvQU9gnzCGlquGmaqezHKQ8rB6ZBvtcu/pnLELfeDTOP4FndOmOF664/RfehtDc1ibSGD0tcCknllXJOoXXZWKLV6ugAVqRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499854; c=relaxed/simple;
	bh=iqyWCPx+Si3yyZNDIPcuKAun84CsjSN6jyjT5NZt3Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUfa+r4LgoPSoju2r0VTP0BYWS8xz7EZskE40BNarVZLlGBxLhwQrYmg4ELEaiPXDMil+f5ntaDPdctiRtAJ1ZI95VWZOLYIFPv8r+38Ccr35A37H3HMLbRTIZ+ywSK1hiU0d6KsdITHO8ad/j6rYhFzV/M18TNNfSfUvkVC+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9eo6Dhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0054C4CEDD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499853;
	bh=iqyWCPx+Si3yyZNDIPcuKAun84CsjSN6jyjT5NZt3Pc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f9eo6DhhNOrbStICWhzrrErXMivAhRZdB+nb27clMkIErUeb8bd71LBiZQcAH4DuU
	 6HbDiXoSne/IgnvkS/deQ1H4pyTu53ePkEd6//a7gJ//BIfH6kYQmRppshdoYdu0JD
	 Kt1CNwjcxL3ItU8qNwjleM/YZJKp23JHJ4WwZkl50N4r66SiPDis5Ica9EAmVYZIoN
	 818Ek+Xk+c2WtJ+RKatcX60Hkv02Je1sYre9KBMCz98KAEv1+WmuNYseHuBo3je3BD
	 Se4BBqiVhC/dfUvbvhmIivxbCV17x7h41lL/6sIm8DMuCBnXwbTjVdBoMwdpjhOSws
	 9Ht/ktF7bKrBw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso9383463a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 08:10:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yxb4VW7zWm/nQYaamRQb+kvlsHGCK39UjI6s53Z10IVl8THJ4Dx
	QbbUYZqYjmupwVSOVV7Og4P4DfrPw3MfX0c6zKIAqX1wBwzIO1GOMarczu+3f59yHQgmKgR2KXW
	/FnbKlpao0r3kWGkdxsOxeoxJg70=
X-Google-Smtp-Source: AGHT+IHLF9PTScH2fzkl0MP4tkr+1LcNXCNnwcGzbwqF2K096nM8zSKDy66rlwuNI3KSMUFfTmKHYjcoHW256BJ8qfI=
X-Received: by 2002:a17:906:6a28:b0:ab7:a39:db4 with SMTP id
 a640c23a62f3a-abc09e73c0fmr2116234166b.57.1740499852358; Tue, 25 Feb 2025
 08:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <31a8b02ec99fd3bf6399b7f543ef6de786665fd2.1740354271.git.wqu@suse.com>
 <CAL3q7H5D7zmdAQwmnb3c6wWyUO9gG=op7f+EHgWW6wha8AcL-Q@mail.gmail.com>
In-Reply-To: <CAL3q7H5D7zmdAQwmnb3c6wWyUO9gG=op7f+EHgWW6wha8AcL-Q@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 16:10:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5uu9NuPLfes8bzbzh0OemzLdfc2uNUdE6OVE3hKPyHzQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoBJ-hG3p8Dh33MP1_ZV07Y1ymwPvzr_79-czKKoLXIhSKlL6iu4h2ksHY
Message-ID: <CAL3q7H5uu9NuPLfes8bzbzh0OemzLdfc2uNUdE6OVE3hKPyHzQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] btrfs: prevent inline data extents read from touching
 blocks beyond its range
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 3:07=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Sun, Feb 23, 2025 at 11:46=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >
> > Currently reading an inline data extent will zero out all the remaining
> > range in the page.
> >
> > This is not yet causing problems even for block size < page size
> > (subpage) cases because:
> >
> > 1) An inline data extent always starts at file offset 0
> >    Meaning at page read, we always read the inline extent first, before
> >    any other blocks in the page. Then later blocks are properly read ou=
t
> >    and re-fill the zeroed out ranges.
> >
> > 2) Currently btrfs will read out the whole page if a buffered write is
> >    not page aligned
> >    So a page is either fully uptodate at buffered write time (covers th=
e
> >    whole page), or we will read out the whole page first.
> >    Meaning there is nothing to lose for such an inline extent read.
> >
> > But it's still not ideal:
> >
> > - We're zeroing out the page twice
> >   One done by read_inline_extent()/uncompress_inline(), one done by
> >   btrfs_do_readpage() for ranges beyond i_size.
> >
> > - We're touching blocks that doesn't belong to the inline extent
> >   In the incoming patches, we can have a partial uptodate folio, that
> >   some dirty blocks can exist while the page is not fully uptodate:
> >
> >   The page size is 16K and block size is 4K:
> >
> >   0         4K        8K        12K        16K
> >   |         |         |/////////|          |
> >
> >   And range [8K, 12K) is dirtied by a buffered write, the remaining
> >   blocks are not uptodate.
> >
> >   If range [0, 4K) contains an inline data extent, and we try to read
> >   the whole page, the current behavior will overwrite range [8K, 12K)
> >   with zero and cause data loss.
> >
> > So to make the behavior more consistent and in preparation for future
> > changes, limit the inline data extents read to only zero out the range
> > inside the first block, not the whole page.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/inode.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index c432ccfba56e..fe2c6038064a 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -6788,6 +6788,7 @@ static noinline int uncompress_inline(struct btrf=
s_path *path,
> >  {
> >         int ret;
> >         struct extent_buffer *leaf =3D path->nodes[0];
> > +       const u32 sectorsize =3D leaf->fs_info->sectorsize;
> >         char *tmp;
> >         size_t max_size;
> >         unsigned long inline_size;
> > @@ -6816,17 +6817,19 @@ static noinline int uncompress_inline(struct bt=
rfs_path *path,
> >          * cover that region here.
> >          */
> >
> > -       if (max_size < PAGE_SIZE)
> > -               folio_zero_range(folio, max_size, PAGE_SIZE - max_size)=
;
> > +       if (max_size < sectorsize)
> > +               folio_zero_range(folio, max_size, sectorsize - max_size=
);

Right above this we have:

max_size =3D min_t(unsigned long, PAGE_SIZE, max_size);
ret =3D btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
       max_size);

Should't we replace PAGE_SIZE with sectorsize too? Why not?

And there's a similar case at read_inline_extent() too.

Thanks.


> >         kfree(tmp);
> >         return ret;
> >  }
> >
> > -static int read_inline_extent(struct btrfs_path *path, struct folio *f=
olio)
> > +static int read_inline_extent(struct btrfs_fs_info *fs_info,
> > +                             struct btrfs_path *path, struct folio *fo=
lio)
> >  {
> >         struct btrfs_file_extent_item *fi;
> >         void *kaddr;
> >         size_t copy_size;
> > +       const u32 sectorsize =3D fs_info->sectorsize;
>
> There's no need to add the fs_info argument just to get the sectorsize.
> We can get it like this:
>
> const u32 sectorsize =3D path->nodes[0]->fs_info->sectorsize;
>
> Otherwise it looks good, so:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
>
>
> >
> >         if (!folio || folio_test_uptodate(folio))
> >                 return 0;
> > @@ -6844,8 +6847,8 @@ static int read_inline_extent(struct btrfs_path *=
path, struct folio *folio)
> >         read_extent_buffer(path->nodes[0], kaddr,
> >                            btrfs_file_extent_inline_start(fi), copy_siz=
e);
> >         kunmap_local(kaddr);
> > -       if (copy_size < PAGE_SIZE)
> > -               folio_zero_range(folio, copy_size, PAGE_SIZE - copy_siz=
e);
> > +       if (copy_size < sectorsize)
> > +               folio_zero_range(folio, copy_size, sectorsize - copy_si=
ze);
> >         return 0;
> >  }
> >
> > @@ -7020,7 +7023,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_=
inode *inode,
> >                 ASSERT(em->disk_bytenr =3D=3D EXTENT_MAP_INLINE);
> >                 ASSERT(em->len =3D=3D fs_info->sectorsize);
> >
> > -               ret =3D read_inline_extent(path, folio);
> > +               ret =3D read_inline_extent(fs_info, path, folio);
> >                 if (ret < 0)
> >                         goto out;
> >                 goto insert;
> > --
> > 2.48.1
> >
> >

