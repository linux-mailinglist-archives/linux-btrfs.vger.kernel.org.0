Return-Path: <linux-btrfs+bounces-19625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A880ACB2F7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 14:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FA743159F84
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA13322DD6;
	Wed, 10 Dec 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCvEqi3a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED125F98B
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371681; cv=none; b=dJ0+CpNK2/ET52VGMX41gYF27Ei6WMwnIq764KxQ050NCigWmWF4A1UEWT1maqYkoEbIkfYUQZsfQPfpa84PUWMYdmeO7QocesUtZBj316FopIf8NhtFa/fwFhk6RhX4yr/Kr6GpCzmnCoOmBZjGPGj676FxtP+0M1Hi3R19rAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371681; c=relaxed/simple;
	bh=m/Ulu/VJwxJDo5HfVbOZFxOGn3NNxWmKuuhPnXtJDLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nodERJbPuyBbe0vJqYs9nrZ30bNP/tOzUrs8tvjgIadEmGXc0jbOJwGLNVLO/+l20bJEdZItDPZUBmt+cCRAPhSNtiNVgI1ME36vr9zPgTs+M/+TtutvDqXJjulbhssQAH/0QM7Yp7ThrnR1NVALxjXWqt3+J8zp/aTz17hremQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCvEqi3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21006C19422
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371681;
	bh=m/Ulu/VJwxJDo5HfVbOZFxOGn3NNxWmKuuhPnXtJDLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCvEqi3aDK6rOgA9ngFVdz0FJAxGa6EHcDSqx/1wFgEnyETWNv7LLS5tIldc7XPF2
	 6htP7A555PCyrbModUnpVE4FAQvdcuNOzJD/wLTPghheMdUAWIl/mrfOnqoRB1zloY
	 YSTHrTB3cfyR648W6FGka/LvNf/gzeHZx/QNR6pPusm288FxIVd9eDPJWRNG22oTzt
	 pIfXZSZU76bhZTbopgb0N+5kvYMWw+ilmykOxmXftwdHaBD9hEQ1v4W666J7I1IjzJ
	 7IiPR4uILE55n7A8ZMMjAGm077mg1pOOZOZ9JW5/PqAFSAV4O1AcF0i+O1BDG7LqbB
	 +QF3SqUVFxkGA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so11486986a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 05:01:21 -0800 (PST)
X-Gm-Message-State: AOJu0YzC3mmS8OWM/Gla5frKQB0v1KmQdzkAd4474xIkV63hjXzAmAh3
	b/0OLxl80k3iT4kCoCROq+ffVB+2w07h/QLC51KNmLsKDtYrI0+41gELcy0jZRpkSbbAlHNhWWf
	+lsUeuTlyjU0njJI1HYgTHPW1zfFbRdA=
X-Google-Smtp-Source: AGHT+IH+hVl/pIUVRGlrDysbDr4LT28vU2+csXwLy3501feO9Jsq365lalOKwxQOYlBv/z/htJK6nU1FybcBbHKZrfI=
X-Received: by 2002:a05:6402:42c9:b0:640:c9ff:c06a with SMTP id
 4fb4d7f45d1cf-6496d9f4509mr2277586a12.15.1765371679456; Wed, 10 Dec 2025
 05:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
 <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
 <3c610ad4-b091-4fe2-9c18-689d6f9d3af3@suse.com> <CAL3q7H4JBhA74Mc_KDp8gFbykAd86h-1inLw_fSr8Z0bHJW9Gg@mail.gmail.com>
In-Reply-To: <CAL3q7H4JBhA74Mc_KDp8gFbykAd86h-1inLw_fSr8Z0bHJW9Gg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Dec 2025 13:00:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4wh6cYeiz_a8CYdg_FArSdSJVzENZMjOQ+gfDsbWRQTQ@mail.gmail.com>
X-Gm-Features: AQt7F2pM8Lbhn2UdlzN8zKnZ37QUGIrFGEFm3BQsLCYYX6vSw5GaGFy5CT4uU1Y
Message-ID: <CAL3q7H4wh6cYeiz_a8CYdg_FArSdSJVzENZMjOQ+gfDsbWRQTQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are
 properly truncated
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 12:46=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Wed, Dec 10, 2025 at 8:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2025/11/25 21:15, Filipe Manana =E5=86=99=E9=81=93:
> > > On Tue, Nov 25, 2025 at 8:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrot=
e:
> > >>
> > >> [POSSIBLE BUG]
> > >> If there are multiple ordered extents beyond EOF, at folio writeback
> > >> time we may only truncate the first ordered extent, but leaving the
> > >> remaining ones finished but not marked as truncated.
> > >>
> > >> Since those OEs are not marked as truncated, it will still insert an
> > >> file extent item, and may lead to false missing csum errors during
> > >> "btrfs check".
> > >>
> > >> [CAUSE]
> > >> Since we have bs < ps support for a while and experimental large dat=
a
> > >> folios are also going to graduate from experimental features soon, w=
e
> > >> can have the following folio to be written back:
> > >>
> > >>    fs block size 4K
> > >>    page size 4K, folio size 64K.
> > >>
> > >>             0        16K      32K                  64K
> > >>             |<---------------- Dirty -------------->|
> > >>             |<-OE A->|<-OE B->|<----- OE C -------->|
> > >>                 |
> > >>                 i_size 4K.
> > >>
> > >> In above case we need to submit the writeback for the range [0, 4K).
> > >> For range [4K, 64K) there is no need to submit any IO but mark the
> > >> involved OEs (OE A, B, C) all as truncated.
> > >>
> > >> However during the EOF handling, patch "btrfs: truncate ordered exte=
nt
> > >> when skipping writeback past i_size" only calls
> > >> btrfs_lookup_first_ordered_range() once, thus only got OE A and mark=
 it
> > >> as truncated.
> > >
> > > And there's a reason why the patch only looks for one ordered extent.
> > >
> > > Because there shouldn't be more than one: btrfs_truncate() calls
> > > btrfs_wait_ordered_range() when we truncate the size of a file to a
> > > smaller value.
> > > The range goes from the new i_size, rounded down by sector size, to
> > > (u64)-1. And btrfs_wait_ordered_range() flushed any delalloc besides
> > > waiting for ordered extents.
> >
> > Couldn't something like 18de34daa7c6 ("btrfs: truncate ordered extent
> > when skipping writeback past i_size") happen? E.g. with more holes:
> >
> >      0          16K    32K     36K   48K    52K   60K    64K
> >      |//////////|      |///////|     |//////|     |//////|
> >
> > The range [0, 64k) is inside a large folio or just a single page (64K
> > page size), and above "//" range is dirtied by buffered write.
> >
> > Then we truncate the inode size to 16K, which set the inode size to 16K
> > first, then call btrfs_truncate() which triggers
> > btrfs_wait_ordered_range()->btrfs_fdatawrite_range() to do the writebac=
k.
> >
> > Then we start writing back the large folio 0 for range [0, 64K),
> > creating ordered extents for [0, 16K), [32K, 36K), [48K, 52K), [60K, 64=
K).
> >
> > Then call extent_writepage_io() to do the submission, which will only
> > submit [0, 16K).
> > And the current code will only mark OE [32K, 36K) as truncated, missing
> > [48K, 52K) and [60K, 64K).
>
> No, it will mark all ordered extents as truncated.
>
> In extent_writepage_io() we go through each dirty subrange inside the
> folio with the for_each_set_bit() loop.
> For each subrange after 16K, we check the start offset ('cur'
> variable) is >=3D i_size, so we look up the ordered extent for that
> subrange and truncate it.
>
> As long as for_each_set_bit() works and finds each dirty subrange we
> don't need this patch.
> If we did the ordered extent truncation outside that loop, then we
> would need something like this patch to ensure we process all ordered
> extents.

Actually in the for_each_set_bit() loop we have a break statement
after the first subrange that starts at or after i_size.
So we need to replace the break with a continue statement.

This also means the code was broken before, as
btrfs_mark_ordered_io_finished() and btrfs_folio_clear_dirty() weren't
being called for all the remaining subranges after i_size.


>
> Thanks.
>
> >
> > Normally the file extent item insertion and later truncation (which
> > drops all the inserted file extents) are inside the same transaction.
> >
> > But if the transaction committed after the file extent items insertion
> > but before the transaction dropping file extent items, then power loss
> > happened, we got the same ordered extents beyond EOF and without csum.
> >
> > Or did I miss something?
> >
> > Thanks,
> > Qu
> >
> > >
> > > So how can we find more than one ordered extent after this?
> > >
> > > I think this changelog should explain that, it makes no mention of
> > > this detail about btrfs_truncate().
> > >
> > > Thanks.
> > >
> > >
> > >>
> > >> But OE B and C are not marked as truncated, they will finish as usua=
l,
> > >> which will leave a regular file extent item to be inserted beyond EO=
F,
> > >> and without any data checksum.
> > >>
> > >> [FIX]
> > >> Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle=
 all
> > >> OEs of a range, and mark them all as truncated.
> > >>
> > >> With that helper, all OEs (A B and C) will be marked as truncated.
> > >> OE B and C will have 0 truncated_len, preventing any file extent ite=
m to
> > >> be inserted from them.
> > >>
> > >> Reviewed-by: Boris Burkov <boris@bur.io>
> > >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > >> ---
> > >> Changelog:
> > >> v2:
> > >> - Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
> > >>    Since the range passed in is to the end of the folio during write=
back
> > >>    path, there is no guarantee that there is always one or more orde=
red
> > >>    extents covering the full range.
> > >>
> > >>    This get triggered during fsstress runs, especially common on bs =
< ps
> > >>    cases.
> > >>
> > >>    Remove the ASSERT() and exit the oe search instead.
> > >>
> > >> Resend:
> > >> - Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
> > >>    calls for buffered write path'
> > >>    As this is a bug fix, which needs a little higher priority than
> > >>    the remaining optimizations.
> > >>
> > >> - Fix various grammar errors
> > >>
> > >> - Use @end to replace duplicated calculations
> > >>
> > >> - Remove the Fixes: tag
> > >>    The involved patch is not yet merged upstream.
> > >>    Just mention the patch subject inside the commit message.
> > >> ---
> > >>   fs/btrfs/extent_io.c    | 19 +------------------
> > >>   fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
> > >>   fs/btrfs/ordered-data.h |  2 ++
> > >>   3 files changed, 36 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > >> index 2d32dfc34ae3..2044b889c887 100644
> > >> --- a/fs/btrfs/extent_io.c
> > >> +++ b/fs/btrfs/extent_io.c
> > >> @@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepag=
e_io(struct btrfs_inode *inode,
> > >>                  cur =3D folio_pos(folio) + (bit << fs_info->sectors=
ize_bits);
> > >>
> > >>                  if (cur >=3D i_size) {
> > >> -                       struct btrfs_ordered_extent *ordered;
> > >> -
> > >> -                       ordered =3D btrfs_lookup_first_ordered_range=
(inode, cur,
> > >> -                                                                  f=
olio_end - cur);
> > >> -                       /*
> > >> -                        * We have just run delalloc before getting =
here, so
> > >> -                        * there must be an ordered extent.
> > >> -                        */
> > >> -                       ASSERT(ordered !=3D NULL);
> > >> -                       spin_lock(&inode->ordered_tree_lock);
> > >> -                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->f=
lags);
> > >> -                       ordered->truncated_len =3D min(ordered->trun=
cated_len,
> > >> -                                                    cur - ordered->=
file_offset);
> > >> -                       spin_unlock(&inode->ordered_tree_lock);
> > >> -                       btrfs_put_ordered_extent(ordered);
> > >> -
> > >> -                       btrfs_mark_ordered_io_finished(inode, folio,=
 cur,
> > >> -                                                      end - cur, tr=
ue);
> > >> +                       btrfs_mark_ordered_io_truncated(inode, folio=
, cur, end - cur);
> > >>                          /*
> > >>                           * This range is beyond i_size, thus we don=
't need to
> > >>                           * bother writing back.
> > >> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > >> index a421f7db9eec..3c0b89164139 100644
> > >> --- a/fs/btrfs/ordered-data.c
> > >> +++ b/fs/btrfs/ordered-data.c
> > >> @@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrf=
s_inode *inode,
> > >>          spin_unlock(&inode->ordered_tree_lock);
> > >>   }
> > >>
> > >> +/*
> > >> + * Mark any ordered extents io inside the specified range as trunca=
ted.
> > >> + */
> > >> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, str=
uct folio *folio,
> > >> +                                    u64 file_offset, u32 len)
> > >> +{
> > >> +       const u64 end =3D file_offset + len;
> > >> +       u64 cur =3D file_offset;
> > >> +
> > >> +       ASSERT(file_offset >=3D folio_pos(folio));
> > >> +       ASSERT(end <=3D folio_pos(folio) + folio_size(folio));
> > >> +
> > >> +       while (cur < end) {
> > >> +               u32 cur_len =3D end - cur;
> > >> +               struct btrfs_ordered_extent *ordered;
> > >> +
> > >> +               ordered =3D btrfs_lookup_first_ordered_range(inode, =
cur, cur_len);
> > >> +
> > >> +               if (!ordered)
> > >> +                       break;
> > >> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> > >> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->f=
lags);
> > >> +                       ordered->truncated_len =3D min(ordered->trun=
cated_len,
> > >> +                                                    cur - ordered->=
file_offset);
> > >> +               }
> > >> +               cur_len =3D min(cur_len, ordered->file_offset + orde=
red->num_bytes - cur);
> > >> +               btrfs_put_ordered_extent(ordered);
> > >> +
> > >> +               cur +=3D cur_len;
> > >> +       }
> > >> +       btrfs_mark_ordered_io_finished(inode, folio, file_offset, le=
n, true);
> > >> +}
> > >> +
> > >>   /*
> > >>    * Finish IO for one ordered extent across a given range.  The ran=
ge can only
> > >>    * contain one ordered extent.
> > >> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> > >> index 1e6b0b182b29..dd4cdc1a8b78 100644
> > >> --- a/fs/btrfs/ordered-data.h
> > >> +++ b/fs/btrfs/ordered-data.h
> > >> @@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_or=
dered_extent *ordered,
> > >>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> > >>                                      struct folio *folio, u64 file_o=
ffset,
> > >>                                      u64 num_bytes, bool uptodate);
> > >> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, str=
uct folio *folio,
> > >> +                                    u64 file_offset, u32 len);
> > >>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
> > >>                                      struct btrfs_ordered_extent **c=
ached,
> > >>                                      u64 file_offset, u64 io_size);
> > >> --
> > >> 2.52.0
> > >>
> > >>
> >

