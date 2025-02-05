Return-Path: <linux-btrfs+bounces-11281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64051A28578
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 09:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B427188738E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF6229B2C;
	Wed,  5 Feb 2025 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT+adt6b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC432215077
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738743935; cv=none; b=Ojz9bBkaHJgnMI2SOimeGJ8afndwsgv6VlZCQZ4ZVWXOTduoLhJ3yRPvLQXTyP6tpxL82TEYAFTk4T10WqYEth0N7Af3bQhF5LLtDHW8ekF4WwntwX79lxVy+CIGNjP3786lQQQI33kaV5t2nfZiab2ZEwGrTjh+evJMJXoJ/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738743935; c=relaxed/simple;
	bh=z1hvzkFdL97uQxiIyHeizazWiW/NTh/F5nCFF/rLThU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTqi6dtzl2o6nkoY3psm58CaMyOYiEgOMeoKTr5SB6PkxmLPw+znTT6z4z3cyhw4asd8H9XstUkShagdSUp0eNKgml9vBZumXxPREIRMoXCkbpBnEMqHFQXNX7qKaBJprx2WGiqUQ/3LwqlVnpQilhnpJTKVavY1W44YOgwn4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT+adt6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F52AC4CEE3
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738743935;
	bh=z1hvzkFdL97uQxiIyHeizazWiW/NTh/F5nCFF/rLThU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oT+adt6bOeMpZhyNmcZHWEs15aejMpnUpv0ahd9IDywDyAKgXgb5RCjALPiSF/Vfp
	 CTw9mSoh52ckEISUjFM4i7d+eiaXCNaA087hRcpyEP2ytEg5xRduT3Ll5yMLHN8rlO
	 nQuMhz1tQA0i0Ks5D3cfJ5GCYIKZXL/IbXPBwRlS4WM24S0+SKORtMq4LENZRUNKWk
	 E7nkQZKAHiqvU23GpEruhbqgAj6wCAJ4g0geOZ4Oruh8cU+xe0E9D9jlAVNwwKpQHD
	 P0e0CBekoZWr7byfJl6CthzNIl3+Rc1pCVp/5CWief87VM9qAMRWPkcN8vRI8e2S6V
	 FLB0s+zrMPXUw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dcd3454922so2086958a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 00:25:35 -0800 (PST)
X-Gm-Message-State: AOJu0YySAvGqxqRsXiFJmnDwnTvjsp6yGfnCo5CQS5fp/T92qrgWjX2/
	lTqTzBqigAenJteP7ZKG6oGfCx/P4NrvKX4YOaKRYLbp9PlWbw/FIN0f5c794HzI0qwAT96uZ21
	/kF0gvZ8ODBsmLhhB/etvLu9f8cA=
X-Google-Smtp-Source: AGHT+IECIGv+PLAcQ4b7sELRlUAfH0LR4MXZPMi4icYvVODqdcmoGbX4cvDwAn13T6xIk/iuapkKmjuCo5iixEuMv1E=
X-Received: by 2002:a17:907:7711:b0:ab7:5f0e:87e8 with SMTP id
 a640c23a62f3a-ab75f0e898bmr149214966b.3.1738743933617; Wed, 05 Feb 2025
 00:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24617a89550bed4ef0e0db12d17187940de551b0.1738685146.git.fdmanana@suse.com>
 <a94fb3db-ac05-4fea-afda-df42cd9286b1@gmx.com>
In-Reply-To: <a94fb3db-ac05-4fea-afda-df42cd9286b1@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 5 Feb 2025 08:24:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5nYQiV++o6jtOc98S1P7B1O2kwFKXa8e2u-GzAdJAaoA@mail.gmail.com>
X-Gm-Features: AWEUYZkURY0D7heNpXx9_akNLLVaNgqHw3RKSH6fjbHkQ_4pTL8BHBPFdYr2J78
Message-ID: <CAL3q7H5nYQiV++o6jtOc98S1P7B1O2kwFKXa8e2u-GzAdJAaoA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix stale page cache after race between readahead
 and direct IO write
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:15=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2025/2/5 02:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > After commit ac325fc2aad5 ("btrfs: do not hold the extent lock for enti=
re
> > read") we can now trigger a race between a task doing a direct IO write
> > and readahead. When this race is triggered it results in tasks getting
> > stale data when they attempt do a buffered read (including the task tha=
t
> > did the direct IO write).
> >
> > This race can be sporadically triggered with test case generic/418, fai=
ling
> > like this:
> >
> >     $ ./check generic/418
> >     FSTYP         -- btrfs
> >     PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc7-btrfs-next-185+ #1=
7 SMP PREEMPT_DYNAMIC Mon Feb  3 12:28:46 WET 2025
> >     MKFS_OPTIONS  -- /dev/sdc
> >     MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> >     generic/418 14s ... - output mismatch (see /home/fdmanana/git/hub/x=
fstests/results//generic/418.out.bad)
> >         --- tests/generic/418.out     2020-06-10 19:29:03.850519863 +01=
00
> >         +++ /home/fdmanana/git/hub/xfstests/results//generic/418.out.ba=
d      2025-02-03 15:42:36.974609476 +0000
> >         @@ -1,2 +1,5 @@
> >          QA output created by 418
> >         +cmpbuf: offset 0: Expected: 0x1, got 0x0
> >         +[6:0] FAIL - comparison failed, offset 24576
> >         +diotest -wp -b 4096 -n 8 -i 4 failed at loop 3
> >          Silence is golden
> >         ...
> >         (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/418=
.out /home/fdmanana/git/hub/xfstests/results//generic/418.out.bad'  to see =
the entire diff)
> >     Ran: generic/418
> >     Failures: generic/418
> >     Failed 1 of 1 tests
> >
> > The race happens like this:
> >
> > 1) A file has a prealloc extent for the range [16K, 28K);
> >
> > 2) Task A starts a direct IO write against file range [24K, 28K).
> >     At the start of the direct IO write it invalidates the page cache a=
t
> >     __iomap_dio_rw() with kiocb_invalidate_pages() for the 4K page at f=
ile
> >     offset 24K;
> >
> > 3) Task A enters btrfs_dio_iomap_begin() and locks the extent range
> >     [24K, 28K);
> >
> > 4) Task B starts a readahead for file range [16K, 28K), entering
> >     btrfs_readahead().
> >
> >     First it attempts to read the page at offset 16K by entering
> >     btrfs_do_readpage(), where it calls get_extent_map(), locks the ran=
ge
> >     [16K, 20K) and gets the extent map for the range [16K, 28K), cachin=
g
> >     it into the 'em_cached' variable declared in the local stack of
> >     btrfs_readahead(), and then unlocks the range [16K, 20K).
> >
> >     Since the extent map has the prealloc flag, at btrfs_do_readpage() =
we
> >     zero out the page's content and don't submit any bio to read the pa=
ge
> >     from the extent.
> >
> >     Then it attempts to read the page at offset 20K entering
> >     btrfs_do_readpage() where we reuse the previously cached extent map
> >     (decided by get_extent_map()) since it spans the page's range and
> >     it's still in the inode's extent map tree.
> >
> >     Just like for the previous page, we zero out the page's content sin=
ce
> >     the extent map has the prealloc flag set.
> >
> >     Then it attempts to read the page at offset 24K entering
> >     btrfs_do_readpage() where we reuse the previously cached extent map
> >     (decided by get_extent_map()) since it spans the page's range and
> >     it's still in the inode's extent map tree.
> >
> >     Just like for the previous pages, we zero out the page's content si=
nce
> >     the extent map has the prealloc flag set. Note that we didn't lock =
the
> >     extent range [24K, 28K), so we didn't synchronize with the ongoig
> >     direct IO write being performed by task A;
> >
> > 5) Task A enters btrfs_create_dio_extent() and creates an ordered exten=
t
> >     for the range [24K, 28K), with the flags BTRFS_ORDERED_DIRECT and
> >     BTRFS_ORDERED_PREALLOC set;
> >
> > 6) Task A unlocks the range [24K, 28K) at btrfs_dio_iomap_begin();
> >
> > 7) The ordered extent enters btrfs_finish_one_ordered() and locks the
> >     range [24K, 28K);
> >
> > 8) Task A enters fs/iomap/direct-io.c:iomap_dio_complete() and it tries
> >     to invalidate the page at offset 24K by calling
> >     kiocb_invalidate_post_direct_write(), resulting in a call chain tha=
t
> >     ends up at btrfs_release_folio().
> >
> >     The btrfs_release_folio() call ends up returning false because the =
range
> >     for the page at file offset 24K is currently locked by the task doi=
ng
> >     the ordered extent completion in the previous step (7), so we have:
> >
> >     btrfs_release_folio() ->
> >        __btrfs_release_folio() ->
> >           try_release_extent_mapping() ->
> >            try_release_extent_state()
> >
> >     This last function checking that the range is locked and returning =
false
> >     and propagating it up to btrfs_release_folio().
> >
> >     So this results in a failure to invalidate the page and
> >     kiocb_invalidate_post_direct_write() triggers this message logged i=
n
> >     dmesg:
> >
> >       Page cache invalidation failure on direct I/O.  Possible data cor=
ruption due to collision with buffered I/O!
> >
> >     After this we leave the page cache with stale data for the file ran=
ge
> >     [24K, 28K), filled with zeroes instead of the data written by direc=
t IO
> >     write (all bytes with a 0x01 value), so any task attempting to read=
 with
> >     buffered IO, including the task that did the direct IO write, will =
get
> >     all bytes in the range with a 0x00 value instead of the written dat=
a.
> >
> > Fix this by locking the range, with btrfs_lock_and_flush_ordered_range(=
),
> > at the two callers of btrfs_do_readpage() instead of doing it at
> > get_extent_map(), just like we did before commit ac325fc2aad5 ("btrfs: =
do
> > not hold the extent lock for entire read"), and unlocking the range aft=
er
> > all the calls to btrfs_do_readpage(). This way we never reuse a cached
> > extent map without flushing any pending ordered extents from a concurre=
nt
> > direct IO write.
> >
> > Fixes: ac325fc2aad5 ("btrfs: do not hold the extent lock for entire rea=
d")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/extent_io.c | 18 +++++++++++++++---
> >   1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 838ab2b6ed43..bdb9816bf125 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -898,7 +898,6 @@ static struct extent_map *get_extent_map(struct btr=
fs_inode *inode,
> >                                        u64 len, struct extent_map **em_=
cached)
> >   {
> >       struct extent_map *em;
> > -     struct extent_state *cached_state =3D NULL;
> >
> >       ASSERT(em_cached);
> >
> > @@ -914,14 +913,12 @@ static struct extent_map *get_extent_map(struct b=
trfs_inode *inode,
> >               *em_cached =3D NULL;
> >       }
> >
> > -     btrfs_lock_and_flush_ordered_range(inode, start, start + len - 1,=
 &cached_state);
> >       em =3D btrfs_get_extent(inode, folio, start, len);
> >       if (!IS_ERR(em)) {
> >               BUG_ON(*em_cached);
> >               refcount_inc(&em->refs);
> >               *em_cached =3D em;
> >       }
> > -     unlock_extent(&inode->io_tree, start, start + len - 1, &cached_st=
ate);
> >
> >       return em;
> >   }
> > @@ -1078,11 +1075,18 @@ static int btrfs_do_readpage(struct folio *foli=
o, struct extent_map **em_cached,
> >
> >   int btrfs_read_folio(struct file *file, struct folio *folio)
> >   {
> > +     struct btrfs_inode *inode =3D folio_to_inode(folio);
> > +     const u64 start =3D folio_pos(folio);
> > +     const u64 end =3D start + folio_size(folio) - 1;
>
> And great you're already taking larger data folio into consideration.
>
> > +     struct extent_state *cached_state =3D NULL;
> >       struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
> >       struct extent_map *em_cached =3D NULL;
> >       int ret;
> >
> > +     btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_sta=
te);
>
> This change is going to conflict with the subpage + partial uptodate
> page optimization (which will also be the foundation for larger data foli=
o):
> https://lore.kernel.org/linux-btrfs/1d230d53e92c4f4a7ea4ce036f226b8daa16e=
5ae.1736848277.git.wqu@suse.com/
>
> I'm fine to update the patch on my side after yours got merged.

I'm sorry about that, but it's a regression so it has to come first.

>
> >       ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> > +     unlock_extent(&inode->io_tree, start, end, &cached_state);
> > +
> >       free_extent_map(em_cached);
> >
> >       /*
> > @@ -2377,12 +2381,20 @@ void btrfs_readahead(struct readahead_control *=
rac)
> >   {
> >       struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ | REQ_R=
AHEAD };
> >       struct folio *folio;
> > +     struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
> > +     const u64 start =3D readahead_pos(rac);
> > +     const u64 end =3D start + readahead_length(rac) - 1;
> > +     struct extent_state *cached_state =3D NULL;
> >       struct extent_map *em_cached =3D NULL;
> >       u64 prev_em_start =3D (u64)-1;
> >
> > +     btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_sta=
te);
> > +
>
> I'm not confident enough about this lock, as it can cross several pages.
>
> E.g. if we have the following case, 4K page size 4K block size.
>
>          0       4K      8K      12K     16K
>          |       |///////|               |
>
> And range [4K, 8K) is uptodate, and it has been submitted for writeback,
> and finished writeback.
> But it still have ordered extent, not yet finished.
>
> Then we go into the following call chain:
> btrfs_lock_and_write_flush()
> |- btrfs_start_ordered_extent()
>     |- filemap_fdatawrite_range()
>
> Which will try to writeback the range [4K, 8K) again.

But you just said above that the writeback has finished...

> But since the folio at [4K, 8K) is going to be passed to
> btrfs_do_readpage(), it should already have been locked.
>
> Thus the writeback will never be able to lock the folio, thus causing a
> deadlock.

readahead (and readpage) are never called for pages that are already
in the page cache,
so how can that happen?

And why do you think that is specific to the case where the range
covers more than one page?
I.e. why doesn't the current scenario of locking only [4K, 8K) doesn't
lead to that?

>
> Or did I miss something specific to readahead so it will avoid readahead
> on already uptodate pages?

It will skip pages already in the page cache (whether uptodate, under
writeback, etc).

If you look closer, what this patch is doing is restoring the
behaviour we had before
commit ac325fc2aad5 ("btrfs: do not hold the extent lock for entire
read"), with the
exception of doing the unlock in readahead/readpage instead of when
submitted bios complete.

If there was a possibility for such a deadlock, we would almost
certainly have noticed it before,
as that has been the behaviour for ages until that commit that landed
last summer.


>
>
> And even if it will not cause the above deadlock, I'm not confident the
> mentioned subpage fix conflict can be proper fixed.
> In the subpage fix, I can only add a folio parameter to
> btrfs_lock_and_flush_ordered_range(), but in this case, we have multiple
> folios, how can we avoid the same subpage dead lock then?

About the subpage case I have no idea.
But given that readahead/readpage is never called for pages already in
the page cache, I don't think there should be a problem even for
subpage scenario.

We also have many places where we lock ranges wider than 1 page, so I
don't see why this specific place would be a problem.

Thanks.

>
> Thanks,
> Qu
>
> >       while ((folio =3D readahead_folio(rac)) !=3D NULL)
> >               btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_=
start);
> >
> > +     unlock_extent(&inode->io_tree, start, end, &cached_state);
> > +
> >       if (em_cached)
> >               free_extent_map(em_cached);
> >       submit_one_bio(&bio_ctrl);
>

