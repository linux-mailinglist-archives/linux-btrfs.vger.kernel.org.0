Return-Path: <linux-btrfs+bounces-11872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3412A45CB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F197ABCF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B5213E84;
	Wed, 26 Feb 2025 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwU4Z541"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5CF212D8D
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568066; cv=none; b=qS2xsq39j4PF7x8CepMTy9iRUloydwR2BJ9FC9qldXpRtuxFHrCJOvKx5WivICxz/YRkDqbyqrJlQvYe7uqB5tyasfP3nCPeSdp1uezCGsn27Mdz3/hp1iYXoU47GleDhsdcw7wleJTsBiF4PPu2/4bjy061VKlESlEI1Un80tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568066; c=relaxed/simple;
	bh=UstKWAFkGN5uJB1wqyvzRGHsQMRCqd2ehKu7va3/Nq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cf0KJmv2ZU9Uh6kyIB+/8I666H8dIOli13h34o3aEc88x96tcPU6iYwCIUUXgXiFcusao9TzNvvDMjO16ma1wv5Cvk/D5etaTtC4J6EKQtDqrD0m7JY1rxQYjp5c78EbIs0GVCXOBsM6fQA2y9a6htXG9R4my/pj6Rs/ddObMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwU4Z541; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE97C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740568065;
	bh=UstKWAFkGN5uJB1wqyvzRGHsQMRCqd2ehKu7va3/Nq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NwU4Z5412M2tG5VX2F3UJ8KsChHl/D2i6gaFNXoVOH1avNOrFKZQSYA9Eh6zL+eh+
	 8z0PssC9+l3f1U9loGhqJdGy8fKNImQkcYsgbceqYSE1oy1RPZvqhHnesaLKIG2Q9q
	 YvnZDBKccghcdfGsJp+by4YLgP9KhGCMoS/Y3jSSWBQZjsqOTsEYAQx9hzPb8SCPX7
	 nwQc1O6i33SkThv0teflBMIN61+4HIkJKAznOV1m8G12dfEDhlQq0gbW1wZC6GkLdS
	 kASMvEeI1iexoOsZEziJYxSmEQLNtf8/vRUT7kBOmeOeZxVFJzGAXCiZtO/Wos5VNb
	 JAkFjHivPPOEg==
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f378498c9so6543894f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:07:45 -0800 (PST)
X-Gm-Message-State: AOJu0YyIavFacez7GaOKFPnOgGyYAJPXkr4l3EkWbhSa/iuw+4PTid/W
	dOMt58XUBm4gYqjTqj+d+WQENx4ERzCvAJk7DumDSOONvUBqtZQhe6kSjyGVKf5o/vBzatG1NlP
	1otTiHTrvZNBLRGXzo7yfVLDUCMg=
X-Google-Smtp-Source: AGHT+IEoaUeoxLSzRSyx1t0ukSYbB5UN9pr8yqltLfLPK9JYfqcRgJWeH8YBwxgu+foXk2XO8bktvHd479H4INXQIAk=
X-Received: by 2002:a05:6000:18a2:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-390cc631b3bmr6491295f8f.37.1740568064339; Wed, 26 Feb 2025
 03:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
 <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com> <e8b84e01-a56d-427e-b188-6c2539a0093b@suse.com>
In-Reply-To: <e8b84e01-a56d-427e-b188-6c2539a0093b@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 26 Feb 2025 11:07:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4x49K1fYHFJn+3iBupN1uqvSGCHHOw2CNX9D0b7AgmUg@mail.gmail.com>
X-Gm-Features: AQ5f1Johmdddlc4B0Y0HovWcBgJwW78AE0iDkf095JHjpsKe5GAH20C5IzOL77w
Message-ID: <CAL3q7H4x49K1fYHFJn+3iBupN1uqvSGCHHOw2CNX9D0b7AgmUg@mail.gmail.com>
Subject: Re: [PATCH 3/7] btrfs: introduce a read path dedicated extent lock helper
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:12=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/26 03:35, Filipe Manana =E5=86=99=E9=81=93:
> > On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> Currently we're using btrfs_lock_and_flush_ordered_range() for both
> >> btrfs_read_folio() and btrfs_readahead(), but it has one critical
> >> problem for future subpage enhancements:
> >>
> >> - It will call btrfs_start_ordered_extent() to writeback the involved
> >>    folios
> >>
> >>    But remember we're calling btrfs_lock_and_flush_ordered_range() at
> >>    read paths, meaning the folio is already locked by read path.
> >>
> >>    If we really trigger writeback, this will lead to a deadlock and
> >>    writeback can not hold the folio lock.
> >>
> >>    Such dead lock is prevented by the fact that btrfs always keeps a
> >>    dirty folio also uptodate, by either dirtying all blocks of the fol=
io,
> >>    or read the folio before dirtying.
> >>
> >>    But it's not the common behavior, as XFS/EXT4 both allow the folio =
to
> >>    be dirty but not uptodate, by allowing buffered write to dirty a fu=
ll
> >>    block without reading the full folio.
> >
> > Ok, but what happens in other filesystems doesn't affect us.
> > Or did you forget to mention that some other subsequent patch or planne=
d changes
> > will introduce that behaviour?
> >
> > If so, it would be best to say that, otherwise that paragraph isn't rel=
evant.
>
> Got it, will add the mention of the incoming feature of partial uptodate
> folio support.
>
> But still, all the work done here is mostly to pass generic/563, which I
> have to say the EXT4/XFS behavior is still a pretty good optimizatioin.
>
> I'll change the paraph to focus on the incoming optimization.
>
> >
> >>
> >> Instead of blindly calling btrfs_start_ordered_extent(), introduce a
> >> newer helper, which is smarter in the following ways:
> >>
> >> - Only wait and flush the ordered extent if
> >>    * The folio doesn't even have private set
> >>    * Part of the blocks of the ordered extent is not uptodate
> >
> > is -> are
> >
> >>
> >>    This can happen by:
> >>    * Folio writeback finished, then get invalidated. But OE not yet
> >>      finished
> >
> > Ok, this one I understand.
> >
> >>    * Direct IO
> >
> > This one I don't because direct IO doesn't use the page cache.
> > Can you elaborate here and explain why it can happen with direct IO?
>
> Direct IO always drops the cache first, so the folio in the direct IO
> range should have no private attached just like it was invalidated.

Ok, I was under the impression you were implying direct IO could cause
deadlock, but what you mean is the scenarios where private is not set.
So all is good.

Thanks.

>
> And direct IO doesn't wait for the OE to finish, we will have the same
> case just like the previous case.
>
> >
> >>
> >>    We have to wait for the ordered extent, as it may contain
> >>    to-be-inserted data checksum.
> >>    Without waiting, our read can fail due to the missing csum.
> >>
> >>    But either way, the OE should not need any extra flush inside the
> >>    locked folio range.
> >>
> >> - Skip the ordered extent completely if
> >>    * All the blocks are dirty
> >>      This happens when OE creation is caused by previous folio.
> >
> > "OE creation is caused by previous folio" - what does this mean?
> > You mean by a write that happened before the read?
>
> I mean the following case, 16K page size 4K block size:
>
>
>     0      8K     16K    24K     32K
>     |/////////////|//////|       |
>
> The writeback for folio 0 started, which ran delalloc range for [0,
> 24K), thus we have an OE at [0, 24K).
>
> But at the same time, since range [24K, 32K) is not uptodate, a read can
> be triggered on folio 16K.
>
> >
> >
> >>      The writeback will never happen (we're holding the folio lock for
> >>      read), nor will the OE finish.
> >>
> >>      Thus we must skip the range.
> >>
> >>    * All the blocks are uptodate
> >>      This happens when the writeback finished, but OE not yet finished=
.
> >>
> >>      Since the blocks are already uptodate, we can skip the OE range.
> >>
> >> The newer helper, lock_extents_for_read() will do a loop for the targe=
t
> >> range by:
> >>
> >> 1) Lock the full range
> >>
> >> 2) If there is no ordered extent in the remaining range, exit
> >>
> >> 3) If there is an ordered extent that we can skip
> >>     Skip to the end of the OE, and continue checking
> >>     We do not trigger writeback nor wait for the OE.
> >>
> >> 4) If there is an ordered extent that we can not skip
> >>     Unlock the whole extent range and start the ordered extent.
> >>
> >> And also update btrfs_start_ordered_extent() to add two more parameter=
s:
> >> @nowriteback_start and @nowriteback_len, to prevent triggering flush f=
or
> >> a certain range.
> >>
> >> This will allow us to handle the following case properly in the future=
:
> >>
> >>   16K page size, 4K btrfs block size:
> >>
> >>   16K           20K             24K              28K            32K
> >>   |/////////////////////////////|                |              |
> >>   |<----------- OE 2----------->|                |<--- OE 1 --->|
> >>
> >>   The folio has been written back before, thus we have an OE at
> >>   [28K, 32K).
> >>   Although the OE 1 finished its IO, the OE is not yet removed from IO
> >>   tree.
> >>   Later the folio got invalidated, but OE still exists.
> >
> > This last sentence to be less confusing: "The folio got invalited
> > after writeback completed and before the ordered extent finished."
> >
> >>
> >>   And [16K, 24K) range is dirty and uptodate, caused by a block aligne=
d
> >>   buffered write (and future enhancements allowing btrfs to skip full
> >>   folio read for such case).
> >>
> >>   Furthermore, OE 2 is created covering range [16K, 24K) by the writeb=
ack
> >>   of previous folio.
> >
> > What previous folio? There's no other one in the example.
> > Do you mean there's a folio for range [0, 16K) and running delalloc
> > resulted in the creation of an OE for the range [0, 24K)? So that OE 2
> > doesn't really start at 16K but at 0 instead?
>
> Yep, exactly.
>
> [...]
> > Normally the parameter list/description comes before describing the
> > return values.
> >
> >> + */
> >> +static bool can_skip_one_ordered_range(struct btrfs_inode *binode,
> >
> > Why binode and not just inode? There's no vfs inode in the function to
> > make any confusion.
>
> OK, will go the regular inode naming.
>
> >
> >
> >> +                                      struct btrfs_ordered_extent *or=
dered,
> >> +                                      u64 cur, u64 *next_ret)
> >> +{
> >> +       const struct btrfs_fs_info *fs_info =3D binode->root->fs_info;
> >> +       struct folio *folio;
> >> +       const u32 blocksize =3D fs_info->sectorsize;
> >> +       u64 range_len;
> >> +       bool ret;
> >> +
> >> +       folio =3D filemap_get_folio(binode->vfs_inode.i_mapping,
> >> +                                 cur >> PAGE_SHIFT);
> >> +
> >> +       /*
> >> +        * We should have locked the folio(s) for range [start, end], =
thus
> >> +        * there must be a folio and it must be locked.
> >> +        */
> >> +       ASSERT(!IS_ERR(folio));
> >> +       ASSERT(folio_test_locked(folio));
> >> +
> >> +       /*
> >> +        * We several cases for the folio and OE combination:
> >> +        *
> >> +        * 0) Folio has no private flag
> >
> > Why does the numbering start from 0? It's not code and it's not
> > related to array indexes or offsets :)
>
> Because I forgot the folio to-be-read may not even be managed by btrfs,
> and hit ASSERT()s related to that.
> Thus I think the private flag should be an important prerequisite, and
> give it 0.
>
> But you're right, in fact it's very common and should not be treated
> specially.
>
> >
> >> +        *    The OE has all its IO done but not yet finished, and fol=
io got
> >> +        *    invalidated. Or direct IO.
> >
> > Ok so I still don't understand the direct IO case, because direct IO
> > doesn't use the page cache.
> > Just like the change log, some explanation here would be desired.
> >
> >> +        *
> >> +        * Have to wait for the OE to finish, as it may contain the
> >> +        * to-be-inserted data checksum.
> >> +        * Without the data checksum inserted into csum tree, read
> >> +        * will just fail with missing csum.
> >
> > Well we don't need to wait if it's a NOCOW / NODATASUM write.
>
> That is also a valid optimization, I can enhance the check to skip
> NODATASUM OEs.
>
> Thanks a lot for reviewing the core mechanism of the patchset.
>
> Thanks,
> Qu
>

