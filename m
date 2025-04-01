Return-Path: <linux-btrfs+bounces-12716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A9A77892
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 12:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9537A37CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3A1F03DE;
	Tue,  1 Apr 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4zx3R8F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C31E5B8B
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502463; cv=none; b=IjHi9nk1i+cBEUNyeadB9XK5HiReOeFEeQY8JSHM7lyy9zFmR1zb/QBzC9HHCjaMHjgXXU0r8SQNucS9RsOSei7IFwtIxwY/0ax2lENKl7v1bi2OnTP6zjRyva2iP+ySrqyl68FdfZG1tF6ANp6cln5I7LlUg+LmILrR2hYN7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502463; c=relaxed/simple;
	bh=c1knKrr3xXou87jLazbVSwWhB0y4zy3GYu/a9AbIRFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3LBIfWE3rQEdIGCz76hnDmgXjLVstZ9R88M90e8iUecfElubsB0OiG28Jt4GfC8tOfFYSYQDYrYlRbqjbSDM2uFsEImPMGodQFc/piYkpGBM0jnRk2DKMRyHNLqPNxnw/uyAOKuxfSqXfyfIlnP+9Gv8UMrjTXI9eaI2XhhRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4zx3R8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D50C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743502462;
	bh=c1knKrr3xXou87jLazbVSwWhB0y4zy3GYu/a9AbIRFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L4zx3R8F5B+OoYIjoNa68m353QISmzJZWqUT26Qd7o6mBELGeELK5uykTlLgbBzS0
	 M/gAlequU6rkLwEaWm/O7Q+K3VvoPxBJzcOwqmtg+Q7oPp5fcNmN8QSpfjcUUfBwsG
	 nuKxPxqnaQFdrQS5XtcnM6x4qdk6/XFJ974AW2STDbSyRI+XjOs520QejIBTNcvMb5
	 9H6ULW6m6eRwasElAlCPNPWyHoSXpOanlQlgSjGYvKFCzlwX27Kw0I/a2qNxzkazIs
	 K9yTuqrxR7FRRLPKvPqWii/PkacZZwkZoK0iDvWWOVFJLeTb0+uzUJliNXlCujO0yF
	 XUKR0Qzql//EQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so10157409a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 03:14:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4XvUkZ+Q+HCYES/K7BnlidgDFhV3hspR3XPiePBSrPOxXzAVw
	yee0HO41glBB7bLsDmiQkBFmsfeSTDqB/6yWPfuVmLcUJkpB/+Ys3fql0tCMTwTPGPcjW66SyR3
	cyEgYcokF9QDVrL8JdtgUeZN1J40=
X-Google-Smtp-Source: AGHT+IFbHOEAE8vKrWHg+kPsKctSk2+p31Oyxf5z5zUfufMMEt13FuG+4gvnyWRPGvNfhEAiL3GOd3jWFsAtratVGdI=
X-Received: by 2002:a17:907:869e:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-ac73898d4b7mr1310506866b.7.1743502461165; Tue, 01 Apr 2025
 03:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743004734.git.fdmanana@suse.com> <c20733c28d02562ff09bfff6739b01b5f710bed7.1743004734.git.fdmanana@suse.com>
 <20250331223907.GL32661@twin.jikos.cz>
In-Reply-To: <20250331223907.GL32661@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 1 Apr 2025 10:13:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5MXGyt4=mnGnaGNEy_dy2PV_9qg8yND1Xbt1sFD7JLLA@mail.gmail.com>
X-Gm-Features: AQ5f1JqumKx4042N1tkvOOR8yQbvISSKhBsHriUZ_nGzHDQNbttm1UBsEOoOQRk
Message-ID: <CAL3q7H5MXGyt4=mnGnaGNEy_dy2PV_9qg8yND1Xbt1sFD7JLLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: allow folios to be released while ordered
 extent is finishing
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:39=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Thu, Mar 27, 2025 at 04:13:51PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When the release_folio callback (from struct address_space_operations) =
is
> > invoked we don't allow the folio to be released if its range is current=
ly
> > locked in the inode's io_tree, as it may indicate the folio may be need=
ed
> > by the task that locked the range.
> >
> > However if the range is locked because an ordered extent is finishing,
> > then we can safely allow the folio to be released because ordered exten=
t
> > completion doesn't need to use the folio at all.
> >
> > When we are under memory pressure, the kernel starts writeback of dirty
> > pages (folios) with the goal of releasing the pages from the page cache
> > after writeback completes, however this often is not possible on btrfs
> > because:
> >
> >   * Once the writeback completes we queue the ordered extent completion=
;
> >
> >   * Once the ordered extent completion starts, we lock the range in the
> >     inode's io_tree (at btrfs_finish_one_ordered());
> >
> >   * If the release_folio callback is called while the folio's range is
> >     locked in the inode's io_tree, we don't allow the folio to be
> >     released, so the kernel has to try to release memory elsewhere,
> >     which may result in triggering more writeback or releasing other
> >     pages from the page cache which may be more useful to have around
> >     for applications.
> >
> > In contrast, when the release_folio callback is invoked after writeback
> > finishes and before ordered extent completion starts or locks the range=
,
> > we allow the folio to be released, as well as when the release_folio
> > callback is invoked after ordered extent completion unlocks the range.
> >
> > Improve on this by detecting if the range is locked for ordered extent
> > completion and if it is, allow the folio to be released. This detection
> > is achieved by adding a new extent flag in the io_tree that is set when
> > the range is locked during ordered extent completion.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/extent-io-tree.c | 22 +++++++++++++++++
> >  fs/btrfs/extent-io-tree.h |  6 +++++
> >  fs/btrfs/extent_io.c      | 52 +++++++++++++++++++++------------------
> >  fs/btrfs/inode.c          |  6 +++--
> >  4 files changed, 60 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> > index 13de6af279e5..14510a71a8fd 100644
> > --- a/fs/btrfs/extent-io-tree.c
> > +++ b/fs/btrfs/extent-io-tree.c
> > @@ -1752,6 +1752,28 @@ bool test_range_bit_exists(struct extent_io_tree=
 *tree, u64 start, u64 end, u32
> >       return bitset;
> >  }
> >
> > +void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u=
32 *bits)
> > +{
> > +     struct extent_state *state;
> > +
> > +     *bits =3D 0;
> > +
> > +     spin_lock(&tree->lock);
> > +     state =3D tree_search(tree, start);
> > +     while (state) {
> > +             if (state->start > end)
> > +                     break;
> > +
> > +             *bits |=3D state->state;
> > +
> > +             if (state->end >=3D end)
> > +                     break;
> > +
> > +             state =3D next_state(state);
> > +     }
> > +     spin_unlock(&tree->lock);
> > +}
> > +
> >  /*
> >   * Check if the whole range [@start,@end) contains the single @bit set=
.
> >   */
> > diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> > index 6ffef1cd37c1..e49f24151167 100644
> > --- a/fs/btrfs/extent-io-tree.h
> > +++ b/fs/btrfs/extent-io-tree.h
> > @@ -38,6 +38,11 @@ enum {
> >        * that is left for the ordered extent completion.
> >        */
> >       ENUM_BIT(EXTENT_DELALLOC_NEW),
> > +     /*
> > +      * Mark that a range is being locked for finishing an ordered ext=
ent.
> > +      * Used together with EXTENT_LOCKED.
> > +      */
> > +     ENUM_BIT(EXTENT_FINISHING_ORDERED),
> >       /*
> >        * When an ordered extent successfully completes for a region mar=
ked as
> >        * a new delalloc range, use this flag when clearing a new delall=
oc
> > @@ -166,6 +171,7 @@ void free_extent_state(struct extent_state *state);
> >  bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u=
32 bit,
> >                   struct extent_state *cached_state);
> >  bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64=
 end, u32 bit);
> > +void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u=
32 *bits);
> >  int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u=
64 end,
> >                            u32 bits, struct extent_changeset *changeset=
);
> >  int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end=
,
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index a11b22fcd154..6b9a80f9e0f5 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2627,33 +2627,37 @@ static bool try_release_extent_state(struct ext=
ent_io_tree *tree,
> >  {
> >       u64 start =3D folio_pos(folio);
> >       u64 end =3D start + folio_size(folio) - 1;
> > -     bool ret;
> > +     u32 range_bits;
> > +     u32 clear_bits;
> > +     int ret;
> >
> > -     if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
> > -             ret =3D false;
> > -     } else {
> > -             u32 clear_bits =3D ~(EXTENT_LOCKED | EXTENT_NODATASUM |
> > -                                EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
> > -                                EXTENT_QGROUP_RESERVED);
> > -             int ret2;
> > +     get_range_bits(tree, start, end, &range_bits);
>
> There's a difference how much of the tree is traversed,
> test_range_bit_exists() stops on first occurence of EXTENT_LOCKED (a
> single bit), get_range_bits() unconditionally explores the whole tree.

The whole tree?
The folio's range, unless there are no records in the tree outside the
folio's range, in which case it is a very small tree.

But it's not a problem for several reasons:

1) When a range is not under IO or locked, there's typically no state
record in the tree;

2) If a range is under delalloc or writeback, we don't even get to
this function - we exit early in btrfs_release_folio() if the folio is
dirty or under writeback;

3) The IO is folio size based (whether single page or multi page in
the near future), so it's unlikely to find more than one state record
for the range - correct me if you know of cases where we'll get more
than one.

4) For bit ranges other than EXTENT_LOCKED, extent state records are
merged, so even for very uncommon scenarios it's unlikely to find more
than 1 state record for the folio's range.

So traversing the whole range is far from being a bottleneck or
causing more lock contention, even if there are multiple state records
- we already had to traverse the whole range with
test_range_bit_exists() when the folio's range is not locked.

>
> >
> > -             /*
> > -              * At this point we can safely clear everything except th=
e
> > -              * locked bit, the nodatasum bit and the delalloc new bit=
.
> > -              * The delalloc new bit will be cleared by ordered extent
> > -              * completion.
> > -              */
> > -             ret2 =3D __clear_extent_bit(tree, start, end, clear_bits,=
 NULL, NULL);
> > +     /*
> > +      * We can release the folio if it's locked only for ordered exten=
t
> > +      * completion, since that doesn't require using the folio.
> > +      */
> > +     if ((range_bits & EXTENT_LOCKED) &&
> > +         !(range_bits & EXTENT_FINISHING_ORDERED))
>
> Here we need to know that LOCKED exists and FINISHING_ORDERED does not
> exist in the range. This can be proven when the whole tree is traversed,

I still don't get why you say the whole tree.

> but could be in some cases be reduced to
>
>         if (test_range_bit_exists(..., LOCKED) &&
>             !test_range_bit_exists(, FINISHING_ORDERED))
>
> where in some percent of cases the whole tree won't be traversed (and
> the lock held for a shorter time). This depends on the runtime what
> combinations of the locks exist, it's possible than in the average case
> the whole tree would be traversed anyway, and get_range_bits() is OK.

I don't see what specific cases you are talking about, correct me if
any of the things I'd said above is wrong and we can have a lot of
extent state records in the folio's range.
But even if we do, it's the same behaviour as for
test_range_bit_exists() when the range is not locked.

Thanks.

