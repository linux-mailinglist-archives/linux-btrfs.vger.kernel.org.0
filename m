Return-Path: <linux-btrfs+bounces-19623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD7CB2F4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64293114940
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F52EB5C4;
	Wed, 10 Dec 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+KSScxT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366D27C866
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371289; cv=none; b=YqxQQis5pLdGgfZMs+gzXX9axUOoDEGCzVJhXhu29nYQv/9o364mIiuh4LASrw2QRGq5s2cgbu4nhAsqGaYTW4tEPKYgvoNz3G3VLvD2MPxXz8NgBDS0na9E7YSLqAefW6o912YAUD4W9rsFLVwKx3NSyKIu4e05lE3FGdf/c3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371289; c=relaxed/simple;
	bh=Vux7umLABYnuwkHEMQMEOVjnVtqlHvfUmD4cvUObbic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU57cPka+inpfJClxJwsCHXJRWUSNMg29tQdtgk7O5Sx1UVN3CUzOFDpXmgJ1h0Kp2Cj9V3gp7qtlCpVn2G5M7UGXcLOVlgwrP8gTx9P2kMbt4wp0U2SbJicNkDPZ7m10WOrAiP3EJyFqK6gDKsw0/88K4BOTCo0k/P+KQ6it/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+KSScxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD51C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371287;
	bh=Vux7umLABYnuwkHEMQMEOVjnVtqlHvfUmD4cvUObbic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y+KSScxTqpNT4NJ1Dx8WN0itcnPrzvmB6UsZkZq8zf8uf1w83er1XwB8zPLQztrD4
	 SgKxSofVwx8Jhw7bvZgTmuZeNsc8ZaBKrrpCeEUwLNdBaVESgLG17ui8gLUUAGOUIz
	 1ItmUsZnSM/cPGsSMatSoHasBcmICQweigh0XAzyN+gLunKsXVG1Dwp7OsgwBguRGC
	 0530fFfZZ1QSGCiRw+xIBDDrKQKC4YyI6rPdn881lytqZ0kvVDrPOTxN/lvHTHmAup
	 M/sc8MFw7UTO5F9zg4GPjnEQMemZAcwA2ZE5bh9thPajM3Kjyol/Con3iea4L0Kb0v
	 kiXBc6ewAM+Nw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b725ead5800so904553666b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 04:54:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCdDn3lc7AzgO0AuIIJ5DPaxma0sM7mIu4LcQeQX9kuGXzaS0WfObslxdSR9FpOpt464ZW1bwNzKgKHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBebGkLLEKanTeCft2dqP3R/Kv7UyFl6uxQkXX0daBlnLKihw
	KwvIX0JPGK2pZIgQKIVcbZ+MeJBC4URmVGJcAZAkBfsEa4kcI1KF7wSosbPxiyMiymUwohmFL+Q
	OoqRYZQjgcA2/6xa3OutOBb6WTiud810=
X-Google-Smtp-Source: AGHT+IF5FnOGYb7hlLNpfSZJtBjzoX9tu+7c+DHPYqE+r5uqbjeJJMqqpFKC8egm2S26W+7E0yZBdu4IzzPP+ZdkzUc=
X-Received: by 2002:a17:906:6a09:b0:b73:6838:802c with SMTP id
 a640c23a62f3a-b7ce84f9aadmr247977966b.42.1765371285965; Wed, 10 Dec 2025
 04:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d0cc7c454a8cb80219ab4c218fa73843ff5f809.1764131228.git.wqu@suse.com>
 <CAL3q7H7q783cixa=8njX4Zc_sPQ6D-exmK1fph7X_unj_XyQGg@mail.gmail.com> <b77d5f0e-ac09-4f64-940c-623ef3c7811b@gmx.com>
In-Reply-To: <b77d5f0e-ac09-4f64-940c-623ef3c7811b@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Dec 2025 12:54:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6OShOKC_ZR1ggFqsJsTz0dWm8BSbtg5sb1vgGJ2=Su0w@mail.gmail.com>
X-Gm-Features: AQt7F2rxNmNDKkt9LmZcU8m3gHbKikizudp9pfJDtuFy7fz4NCyq8D1opBBrj2o
Message-ID: <CAL3q7H6OShOKC_ZR1ggFqsJsTz0dWm8BSbtg5sb1vgGJ2=Su0w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: search for larger extent maps inside btrfs_do_readpage()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 9:32=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/12/10 19:26, Filipe Manana =E5=86=99=E9=81=93:
> > On Wed, Nov 26, 2025 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [CORNER CASE]
> >> If we have the following file extents layout, btrfs_get_extent() can
> >> return a smaller hole during read, and cause unnecessary extra tree
> >> searches:
> >>
> >>          item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> >>                  generation 9 type 1 (regular)
> >>                  extent data disk byte 13631488 nr 4096
> >>                  extent data offset 0 nr 4096 ram 4096
> >>                  extent compression 0 (none)
> >>
> >>          item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
> >>                  generation 9 type 1 (regular)
> >>                  extent data disk byte 13635584 nr 4096
> >>                  extent data offset 0 nr 4096 ram 4096
> >>                  extent compression 0 (none)
> >>
> >> In above case, range [0, 4K) and [32K, 36K) are regular extents, and
> >> there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
> >> meaning the hole will not have a file extent item.
> >>
> >> [INEFFICIENCY]
> >> Assume the system has 4K page size, and we're doing readahead for rang=
e
> >> [4K, 32K), no large folio yet.
> >>
> >>   btrfs_readahead() for range [4K, 32K)
> >>   |- btrfs_do_readpage() for folio 4K
> >>   |  |- get_extent_map() for range [4K, 8K)
> >>   |     |- btrfs_get_extent() for range [4K, 8K)
> >>   |        We hit item 6, then for the next item 7.
> >>   |        At this stage we know range [4K, 32K) is a hole.
> >>   |        But our search range is only [4K, 8K), not reaching 32K, th=
us
> >>   |        we go into not_found: tag, returning a hole em for [4K, 8K)=
.
> >>   |
> >>   |- btrfs_do_readpage() for folio 8K
> >>   |  |- get_extent_map() for range [8K, 12K)
> >>   |     |- btrfs_get_extent() for range [8K, 12K)
> >>   |        We hit the same item 6, and then item 7.
> >>   |        But still we goto not_found tag, inserting a new hole em,
> >>   |        which will be merged with previous one.
> >>   |
> >>   | [ Repeat the same btrfs_get_extent() calls until the end ]
> >>
> >> So we're calling btrfs_get_extent() again and again, just for a
> >> different part of the same hole range [4K, 32K).
> >>
> >> [ENHANCEMENT]
> >> Make btrfs_do_readpage() to search for a larger extent map if readahea=
d
> >> is involved.
> >>
> >> For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents fo=
r
> >> the whole readahead range.
> >>
> >> If we find bio_ctrl::ractl is set, we can use that end range as extent
> >> map search end, this allows btrfs_get_extent() to return a much larger
> >> hole, thus reduce the need to call btrfs_get_extent() again and again.
> >>
> >>   btrfs_readahead() for range [4K, 32K)
> >>   |- btrfs_do_readpage() for folio 4K
> >>   |  |- get_extent_map() for range [4K, 32K)
> >>   |     |- btrfs_get_extent() for range [4K, 32K)
> >>   |        We hit item 6, then for the next item 7.
> >>   |        At this stage we know range [4K, 32K) is a hole.
> >>   |        So the hole em for range [4K, 32K) is returned.
> >>   |
> >>   |- btrfs_do_readpage() for folio 8K
> >>   |  |- get_extent_map() for range [8K, 32K)
> >>   |     The cached hole em range [4K, 32K) covers the range,
> >>   |     and reuse that em.
> >>   |
> >>   | [ Repeat the same btrfs_get_extent() calls until the end ]
> >>
> >> Now we only call btrfs_get_extent() once for the whole range [4K, 32K)=
,
> >> other than the old 8 times.
> >>
> >> Although again I do not expect much difference for the real world
> >> performance.
> >
> > Why don't you measure it?
>
> Because it's a very tiny difference.

That's not a reason to not post measurements.
The sentence that is in the changelog gives the idea there was no
attempt to measure anything.

>
> I tried this on aarch64 with 64K page size and 4K fs block size, which
> should have the best result, reading a 1GiB hole with buffered read.
>
> The average (32 runs) buffered read times are:
>
> - Before: 0.20823 s
> - After:  0.20635 s
>
> Resulting an improve of 0.9% improvement.
>
> Not to mention buffered read itself can be noisy, as memory
> pressure/reclaim can easily affect the result more.

Yes, that all can affect results, but to measure things we don't need
anything overcomplicated...

Just measure how long it takes to read a large enough hole, either
from user space or track the total time spent in btrfs_do_readpage()
with bpftrace for example.
Just making sure the page cache is clean before each measure is enough.

>
> I can put that part into the changelog if you wish.

I don't see why not posting results... In fact when a patch claims
better performance, it should be backed by numbers and provide some
information about how the test was done, no matter how small the
difference.

Thanks.

>
> Thanks,
> Qu
>
> >
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/extent_io.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 2d32dfc34ae3..c8c8d3659135 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -997,6 +997,8 @@ static int btrfs_do_readpage(struct folio *folio, =
struct extent_map **em_cached,
> >>          struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> >>          u64 start =3D folio_pos(folio);
> >>          const u64 end =3D start + folio_size(folio) - 1;
> >> +       const u64 locked_end =3D bio_ctrl->ractl ? (readahead_pos(bio_=
ctrl->ractl) +
> >> +                              readahead_length(bio_ctrl->ractl) - 1) =
: end;
> >
> > This is a rather long expression, it's more readable with an if-else st=
atement.
> >
> > Thanks.
> >
> >>          u64 extent_offset;
> >>          u64 last_byte =3D i_size_read(inode);
> >>          struct extent_map *em;
> >> @@ -1036,7 +1038,14 @@ static int btrfs_do_readpage(struct folio *foli=
o, struct extent_map **em_cached,
> >>                          end_folio_read(folio, true, cur, blocksize);
> >>                          continue;
> >>                  }
> >> -               em =3D get_extent_map(BTRFS_I(inode), folio, cur, end =
- cur + 1, em_cached);
> >> +               /*
> >> +                * Search extent map for the whole locked range.
> >> +                * This will allow btrfs_get_extent() to return a larg=
er hole
> >> +                * when possible.
> >> +                * This can reduce duplicated btrfs_get_extent() calls=
 for large
> >> +                * holes.
> >> +                */
> >> +               em =3D get_extent_map(BTRFS_I(inode), folio, cur, lock=
ed_end - cur + 1, em_cached);
> >>                  if (IS_ERR(em)) {
> >>                          end_folio_read(folio, false, cur, end + 1 - c=
ur);
> >>                          return PTR_ERR(em);
> >> --
> >> 2.52.0
> >>
> >>
> >
>

