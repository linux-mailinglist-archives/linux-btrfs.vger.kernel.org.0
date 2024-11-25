Return-Path: <linux-btrfs+bounces-9891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315099D8542
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88601664A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8418872F;
	Mon, 25 Nov 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJLaE2no"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847F1547C3
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537078; cv=none; b=UKZK/pvfqetkNuu9SUKc64r2sVKU9Yv1fldXn1kIIHTQpQ8yiwZvwOuCXs2G9P1OHN/9ejkWpbwmhF78meUxRSr4hVuMjcq5mjfJr3GsFnaNyNot5mAFxmi06sTiU2O0V/8KVhEsAun8zKiwQusLJ7sZCy7qLajgk67MIrFExPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537078; c=relaxed/simple;
	bh=1lNpilNYMNchzZy9YMGUrYd7mwKcCoEn9q0gFbHqe+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPYUAWtvbkHt76biDJ0zCL5Jn9g6q2hwp8GVUuuOk0CjgmIu9Bxl18n0ejcEILPTtkt8n9RVmbEbiwIwDXjAXhX+A09aSUT9s6iiciyz3NfFDQPzmBQpGhw2xUu7+CshK0kwqf5LdZHxkvwHtU9ZtB3q9RsJZYXSkCn1WaLQYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJLaE2no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CC4C4CED2
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732537077;
	bh=1lNpilNYMNchzZy9YMGUrYd7mwKcCoEn9q0gFbHqe+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RJLaE2nozS3Pz4uTVgbTvJ0L5vYxwIrqKhNV7vfzTo1wI6OLIhxJIAMTzozfNDw6c
	 5VqSPswE+weGkxhHTeir4gfzSM6sgt/4vtN1lg97nadqdPQb0HwFI8fQcWDSSUyfHc
	 xWE5f5hUwfLgMwZvZPFUUB3KRAk3JTNPJVpGzuUP/z1dJ+945edXBoSBYZYx4W9orx
	 Nvez9A0cFuHQivFuDq7w68P9lRkxPGqsl1R2ISY1pRU95fcVxJwoCVjuIeIT1PowE9
	 q8Ee+nmXSbwGPCZ4uQN9dl6nfU0GP9cbnkc7R8tSjpsLPBIPi/AUJfIkevUd6ypK4i
	 7EWUWog4CIMCg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa535eed875so288063166b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 04:17:57 -0800 (PST)
X-Gm-Message-State: AOJu0YzBh9fmSAbuk86Zp4A+8IQQKEvX9zXE7s4KmnQzyDRY5f6+qZ/U
	eIu2XMMAtU/A2gaGVDTG1g2taejolRwhpJdTiuevaitXxZ/OuAoWd57cE0Ouxb5k9WjZhoPLNDh
	4PUjt6DKYJOqn7WtUuoRTDnzvnoY=
X-Google-Smtp-Source: AGHT+IGRdiLP8CQCzhumuhgHNpC2IKRBe0K8coeNDEEQVx7WnS+2HUypPzlkna26WFY8iSAEYDTehMNI/IvzZL8dj9s=
X-Received: by 2002:a17:907:77ce:b0:a9e:c881:80bd with SMTP id
 a640c23a62f3a-aa509b9000bmr745583066b.37.1732537075558; Mon, 25 Nov 2024
 04:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724690141.git.josef@toxicpanda.com> <3a8713ffde30072690bcc9149ec211abc1aed8ca.1724690141.git.josef@toxicpanda.com>
 <CAL3q7H7wzZnwmLHM2g=QvGBk4U6OzrCQmSvdP+0DXmM5FXjg-g@mail.gmail.com>
In-Reply-To: <CAL3q7H7wzZnwmLHM2g=QvGBk4U6OzrCQmSvdP+0DXmM5FXjg-g@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 25 Nov 2024 12:17:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5VzQewMPfo4viM4vq+E9KhLjNTjebscWZZwX-z+rkC3A@mail.gmail.com>
Message-ID: <CAL3q7H5VzQewMPfo4viM4vq+E9KhLjNTjebscWZZwX-z+rkC3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: do not hold the extent lock for entire read
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:11=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Mon, Aug 26, 2024 at 5:39=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > Historically we've held the extent lock throughout the entire read.
> > There's been a few reasons for this, but it's mostly just caused us
> > problems.  For example, this prevents us from allowing page faults
> > during direct io reads, because we could deadlock.  This has forced us
> > to only allow 4k reads at a time for io_uring NOWAIT requests because w=
e
> > have no idea if we'll be forced to page fault and thus have to do a
> > whole lot of work.
> >
> > On the buffered side we are protected by the page lock, as long as we'r=
e
> > reading things like buffered writes, punch hole, and even direct IO to =
a
> > certain degree will get hung up on the page lock while the page is in
> > flight.
> >
> > On the direct side we have the dio extent lock, which acts much like th=
e
> > way the extent lock worked previously to this patch, however just for
> > direct reads.  This protects direct reads from concurrent direct writes=
,
> > while we're protected from buffered writes via the inode lock.
> >
> > Now that we're protected in all cases, narrow the extent lock to the
> > part where we're getting the extent map to submit the reads, no longer
> > holding the extent lock for the entire read operation.  Push the extent
> > lock down into do_readpage() so that we're only grabbing it when lookin=
g
> > up the extent map.  This portion was contributed by Goldwyn.
> >
> > Co-developed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/compression.c |  2 +-
> >  fs/btrfs/direct-io.c   | 51 +++++++++++------------
> >  fs/btrfs/extent_io.c   | 94 ++----------------------------------------
> >  3 files changed, 29 insertions(+), 118 deletions(-)
> >
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 832ab8984c41..511f81f312af 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -521,6 +521,7 @@ static noinline int add_ra_bio_pages(struct inode *=
inode,
> >                 }
> >                 add_size =3D min(em->start + em->len, page_end + 1) - c=
ur;
> >                 free_extent_map(em);
> > +               unlock_extent(tree, cur, page_end, NULL);
> >
> >                 if (folio->index =3D=3D end_index) {
> >                         size_t zero_offset =3D offset_in_folio(folio, i=
size);
> > @@ -534,7 +535,6 @@ static noinline int add_ra_bio_pages(struct inode *=
inode,
> >
> >                 if (!bio_add_folio(orig_bio, folio, add_size,
> >                                    offset_in_folio(folio, cur))) {
> > -                       unlock_extent(tree, cur, page_end, NULL);
> >                         folio_unlock(folio);
> >                         folio_put(folio);
> >                         break;
> > diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> > index 576f469cacee..66f1ce5fcfd2 100644
> > --- a/fs/btrfs/direct-io.c
> > +++ b/fs/btrfs/direct-io.c
> > @@ -366,7 +366,7 @@ static int btrfs_dio_iomap_begin(struct inode *inod=
e, loff_t start,
> >         int ret =3D 0;
> >         u64 len =3D length;
> >         const u64 data_alloc_len =3D length;
> > -       bool unlock_extents =3D false;
> > +       u32 unlock_bits =3D EXTENT_LOCKED;
> >
> >         /*
> >          * We could potentially fault if we have a buffer > PAGE_SIZE, =
and if
> > @@ -527,7 +527,6 @@ static int btrfs_dio_iomap_begin(struct inode *inod=
e, loff_t start,
> >                                                     start, &len, flags)=
;
> >                 if (ret < 0)
> >                         goto unlock_err;
> > -               unlock_extents =3D true;
> >                 /* Recalc len in case the new em is smaller than reques=
ted */
> >                 len =3D min(len, em->len - (start - em->start));
> >                 if (dio_data->data_space_reserved) {
> > @@ -548,23 +547,8 @@ static int btrfs_dio_iomap_begin(struct inode *ino=
de, loff_t start,
> >                                                                release_=
offset,
> >                                                                release_=
len);
> >                 }
> > -       } else {
> > -               /*
> > -                * We need to unlock only the end area that we aren't u=
sing.
> > -                * The rest is going to be unlocked by the endio routin=
e.
> > -                */
> > -               lockstart =3D start + len;
> > -               if (lockstart < lockend)
> > -                       unlock_extents =3D true;
> >         }
> >
> > -       if (unlock_extents)
> > -               clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, l=
ockend,
> > -                                EXTENT_LOCKED | EXTENT_DIO_LOCKED,
> > -                                &cached_state);
> > -       else
> > -               free_extent_state(cached_state);
> > -
> >         /*
> >          * Translate extent map information to iomap.
> >          * We trim the extents (and move the addr) even though iomap co=
de does
> > @@ -583,6 +567,23 @@ static int btrfs_dio_iomap_begin(struct inode *ino=
de, loff_t start,
> >         iomap->length =3D len;
> >         free_extent_map(em);
> >
> > +       /*
> > +        * Reads will hold the EXTENT_DIO_LOCKED bit until the io is co=
mpleted,
> > +        * writes only hold it for this part.  We hold the extent lock =
until
> > +        * we're completely done with the extent map to make sure it re=
mains
> > +        * valid.
> > +        */
> > +       if (write)
> > +               unlock_bits |=3D EXTENT_DIO_LOCKED;
> > +
> > +       clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> > +                        unlock_bits, &cached_state);
> > +
> > +       /* We didn't use everything, unlock the dio extent for the rema=
inder. */
> > +       if (!write && (start + len) < lockend)
> > +               unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len=
,
> > +                                 lockend, NULL);
> > +
> >         return 0;
> >
> >  unlock_err:
> > @@ -615,9 +616,8 @@ static int btrfs_dio_iomap_end(struct inode *inode,=
 loff_t pos, loff_t length,
> >
> >         if (!write && (iomap->type =3D=3D IOMAP_HOLE)) {
> >                 /* If reading from a hole, unlock and return */
> > -               clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> > -                                 pos + length - 1,
> > -                                 EXTENT_LOCKED | EXTENT_DIO_LOCKED, NU=
LL);
> > +               unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> > +                                 pos + length - 1, NULL);
> >                 return 0;
> >         }
> >
> > @@ -628,10 +628,8 @@ static int btrfs_dio_iomap_end(struct inode *inode=
, loff_t pos, loff_t length,
> >                         btrfs_finish_ordered_extent(dio_data->ordered, =
NULL,
> >                                                     pos, length, false)=
;
> >                 else
> > -                       clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> > -                                        pos + length - 1,
> > -                                        EXTENT_LOCKED | EXTENT_DIO_LOC=
KED,
> > -                                        NULL);
> > +                       unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos=
,
> > +                                         pos + length - 1, NULL);
> >                 ret =3D -ENOTBLK;
> >         }
> >         if (write) {
> > @@ -663,9 +661,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio=
)
> >                                             dip->file_offset, dip->byte=
s,
> >                                             !bio->bi_status);
> >         } else {
> > -               clear_extent_bit(&inode->io_tree, dip->file_offset,
> > -                                dip->file_offset + dip->bytes - 1,
> > -                                EXTENT_LOCKED | EXTENT_DIO_LOCKED, NUL=
L);
> > +               unlock_dio_extent(&inode->io_tree, dip->file_offset,
> > +                                 dip->file_offset + dip->bytes - 1, NU=
LL);
> >         }
> >
> >         bbio->bio.bi_private =3D bbio->private;
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6083bed89df2..77161116af7a 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -480,75 +480,6 @@ static void end_bbio_data_write(struct btrfs_bio *=
bbio)
> >         bio_put(bio);
> >  }
> >
> > -/*
> > - * Record previously processed extent range
> > - *
> > - * For endio_readpage_release_extent() to handle a full extent range, =
reducing
> > - * the extent io operations.
> > - */
> > -struct processed_extent {
> > -       struct btrfs_inode *inode;
> > -       /* Start of the range in @inode */
> > -       u64 start;
> > -       /* End of the range in @inode */
> > -       u64 end;
> > -       bool uptodate;
> > -};
> > -
> > -/*
> > - * Try to release processed extent range
> > - *
> > - * May not release the extent range right now if the current range is
> > - * contiguous to processed extent.
> > - *
> > - * Will release processed extent when any of @inode, @uptodate, the ra=
nge is
> > - * no longer contiguous to the processed range.
> > - *
> > - * Passing @inode =3D=3D NULL will force processed extent to be releas=
ed.
> > - */
> > -static void endio_readpage_release_extent(struct processed_extent *pro=
cessed,
> > -                             struct btrfs_inode *inode, u64 start, u64=
 end,
> > -                             bool uptodate)
> > -{
> > -       struct extent_state *cached =3D NULL;
> > -       struct extent_io_tree *tree;
> > -
> > -       /* The first extent, initialize @processed */
> > -       if (!processed->inode)
> > -               goto update;
> > -
> > -       /*
> > -        * Contiguous to processed extent, just uptodate the end.
> > -        *
> > -        * Several things to notice:
> > -        *
> > -        * - bio can be merged as long as on-disk bytenr is contiguous
> > -        *   This means we can have page belonging to other inodes, thu=
s need to
> > -        *   check if the inode still matches.
> > -        * - bvec can contain range beyond current page for multi-page =
bvec
> > -        *   Thus we need to do processed->end + 1 >=3D start check
> > -        */
> > -       if (processed->inode =3D=3D inode && processed->uptodate =3D=3D=
 uptodate &&
> > -           processed->end + 1 >=3D start && end >=3D processed->end) {
> > -               processed->end =3D end;
> > -               return;
> > -       }
> > -
> > -       tree =3D &processed->inode->io_tree;
> > -       /*
> > -        * Now we don't have range contiguous to the processed range, r=
elease
> > -        * the processed range now.
> > -        */
> > -       unlock_extent(tree, processed->start, processed->end, &cached);
> > -
> > -update:
> > -       /* Update processed to current range */
> > -       processed->inode =3D inode;
> > -       processed->start =3D start;
> > -       processed->end =3D end;
> > -       processed->uptodate =3D uptodate;
> > -}
> > -
> >  static void begin_folio_read(struct btrfs_fs_info *fs_info, struct fol=
io *folio)
> >  {
> >         ASSERT(folio_test_locked(folio));
> > @@ -575,7 +506,6 @@ static void end_bbio_data_read(struct btrfs_bio *bb=
io)
> >  {
> >         struct btrfs_fs_info *fs_info =3D bbio->fs_info;
> >         struct bio *bio =3D &bbio->bio;
> > -       struct processed_extent processed =3D { 0 };
> >         struct folio_iter fi;
> >         const u32 sectorsize =3D fs_info->sectorsize;
> >
> > @@ -640,11 +570,7 @@ static void end_bbio_data_read(struct btrfs_bio *b=
bio)
> >
> >                 /* Update page status and unlock. */
> >                 end_folio_read(folio, uptodate, start, len);
> > -               endio_readpage_release_extent(&processed, BTRFS_I(inode=
),
> > -                                             start, end, uptodate);
> >         }
> > -       /* Release the last extent */
> > -       endio_readpage_release_extent(&processed, NULL, 0, 0, false);
> >         bio_put(bio);
> >  }
> >
> > @@ -973,6 +899,7 @@ static struct extent_map *__get_extent_map(struct i=
node *inode,
> >                                            u64 len, struct extent_map *=
*em_cached)
> >  {
> >         struct extent_map *em;
> > +       struct extent_state *cached_state =3D NULL;
> >
> >         ASSERT(em_cached);
> >
> > @@ -988,12 +915,15 @@ static struct extent_map *__get_extent_map(struct=
 inode *inode,
> >                 *em_cached =3D NULL;
> >         }
> >
> > +       btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start=
 + len - 1, &cached_state);
> >         em =3D btrfs_get_extent(BTRFS_I(inode), folio, start, len);
> >         if (!IS_ERR(em)) {
> >                 BUG_ON(*em_cached);
> >                 refcount_inc(&em->refs);
> >                 *em_cached =3D em;
> >         }
> > +       unlock_extent(&BTRFS_I(inode)->io_tree, start, start + len - 1,=
 &cached_state);
>
> Sorry for the late review, but I missed this when it was posted, was
> busy with other stuff and summer holidays were approaching.
>
> I don't see how this is safe against concurrent COW writes, this
> leaves here some races that trigger either checksum
> failures making the reads fail with -EIO or allow a read to read data
> from another file (and that can be seen as a
> security issue).
>
> So before this patch we locked the extent range when we started the
> read and then unlocked it only after read bios
> finished - after the data was read from disk and we verified it
> matches the checksums.
>
> But now we lock it only to get an extent map, and we unlock it
> immediately after getting the extent map.
>
> So first unsafe scenario, for the simple case of reading a single 4K page=
:
>
> 1) We lock the extent range, get the extent map, which lets say points
> to an extent at disk_bytenr X, and then unlock the range;
>
> 2) We read the checksums from the csum tree and submit the read bios
> later, when calling btrfs_submit_bbio() -> btrfs_submit_chunk();
>
> 3) But before we go into btrfs_submit_bbio(), a COW write comes for 4K
> range, which will now proceed because we are not locking
>    the extent range for the whole duration of the read anymore.
>
>    This results in removing extent X, replacing it with a new one, and
> pinning it in the current transaction N;
>
> 4) Still before we reach btrfs_submit_bio(), transaction N is
> committed, so extent X is unpinned and from
>    now on anyone can allocate that extent;
>
> 5) A write for another file happens and it allocates extent X, writes
> to it, and adds checksums to the csum tree;
>
> 6) Our read proceeds and enters btrfs_submit_bbio().
>    So we submit a read for extent X and the read will succeed since
> the checksums match the extent's data.
>
>    We end up reading data from another file - this can cause all sorts
> of unexpected results to applications,
>    and can also be seen as a security issue.
>
> Another possible race, again for reading a single 4K page (simplest case)=
:
>
> 1) We lock the extent range, get the extent map, which lets say points
> to an extent at disk_bytenr X, and then unlock the range;
>
> 2) We get into btrfs_submit_bbio() -> btrfs_submit_chunk() ->
> btrfs_lookup_bio_sums() and reads the checksums for the extent
>    from the csum tree;
>
> 3) Before we submit the read bio(s), a COW write for this range
> happens, so it drops extent X and pins it in the current transaction
> N;
>
> 4) Transaction N is committed, so extent X is unpinned and can now be
> re-allocated by anyone;
>
> 5) A write for another file happens and it allocates extent X, writing
> data to it;
>
> 6) The read proceeds and submits a bio to read extent X;
>
> 7) When the bio completes we do checksum validation and we fail, since
> the data does not match the checksums we got
>    in step 2, as a result the read will fail -EIO due to checksum failure=
.
>
> These are races we didn't have before, since we unlocked the extent
> range only after the bio completed.

Forgot to mention, those writes are direct IO writes, so they don't
use page locks to serialize with the reads.

>
> Please tell me that I'm missing something here and these races are imposs=
ible.
>
> Thanks.
>
> > +
> >         return em;
> >  }
> >  /*
> > @@ -1019,11 +949,9 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
> >         size_t pg_offset =3D 0;
> >         size_t iosize;
> >         size_t blocksize =3D fs_info->sectorsize;
> > -       struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
> >
> >         ret =3D set_folio_extent_mapped(folio);
> >         if (ret < 0) {
> > -               unlock_extent(tree, start, end, NULL);
> >                 folio_unlock(folio);
> >                 return ret;
> >         }
> > @@ -1047,14 +975,12 @@ static int btrfs_do_readpage(struct folio *folio=
, struct extent_map **em_cached,
> >                 if (cur >=3D last_byte) {
> >                         iosize =3D folio_size(folio) - pg_offset;
> >                         folio_zero_range(folio, pg_offset, iosize);
> > -                       unlock_extent(tree, cur, cur + iosize - 1, NULL=
);
> >                         end_folio_read(folio, true, cur, iosize);
> >                         break;
> >                 }
> >                 em =3D __get_extent_map(inode, folio, cur, end - cur + =
1,
> >                                       em_cached);
> >                 if (IS_ERR(em)) {
> > -                       unlock_extent(tree, cur, end, NULL);
> >                         end_folio_read(folio, false, cur, end + 1 - cur=
);
> >                         return PTR_ERR(em);
> >                 }
> > @@ -1123,7 +1049,6 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
> >                 if (block_start =3D=3D EXTENT_MAP_HOLE) {
> >                         folio_zero_range(folio, pg_offset, iosize);
> >
> > -                       unlock_extent(tree, cur, cur + iosize - 1, NULL=
);
> >                         end_folio_read(folio, true, cur, iosize);
> >                         cur =3D cur + iosize;
> >                         pg_offset +=3D iosize;
> > @@ -1131,7 +1056,6 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
> >                 }
> >                 /* the get_extent function already copied into the foli=
o */
> >                 if (block_start =3D=3D EXTENT_MAP_INLINE) {
> > -                       unlock_extent(tree, cur, cur + iosize - 1, NULL=
);
> >                         end_folio_read(folio, true, cur, iosize);
> >                         cur =3D cur + iosize;
> >                         pg_offset +=3D iosize;
> > @@ -1156,15 +1080,10 @@ static int btrfs_do_readpage(struct folio *foli=
o, struct extent_map **em_cached,
> >
> >  int btrfs_read_folio(struct file *file, struct folio *folio)
> >  {
> > -       struct btrfs_inode *inode =3D folio_to_inode(folio);
> > -       u64 start =3D folio_pos(folio);
> > -       u64 end =3D start + folio_size(folio) - 1;
> >         struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
> >         struct extent_map *em_cached =3D NULL;
> >         int ret;
> >
> > -       btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> > -
> >         ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> >         free_extent_map(em_cached);
> >
> > @@ -2337,15 +2256,10 @@ int btrfs_writepages(struct address_space *mapp=
ing, struct writeback_control *wb
> >  void btrfs_readahead(struct readahead_control *rac)
> >  {
> >         struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ | REQ=
_RAHEAD };
> > -       struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
> >         struct folio *folio;
> > -       u64 start =3D readahead_pos(rac);
> > -       u64 end =3D start + readahead_length(rac) - 1;
> >         struct extent_map *em_cached =3D NULL;
> >         u64 prev_em_start =3D (u64)-1;
> >
> > -       btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> > -
> >         while ((folio =3D readahead_folio(rac)) !=3D NULL)
> >                 btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_e=
m_start);
> >
> > --
> > 2.43.0
> >
> >

