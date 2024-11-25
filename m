Return-Path: <linux-btrfs+bounces-9890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4AB9D8524
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9618416388B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5ED19AD70;
	Mon, 25 Nov 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7ZUP3zU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474C2500BA
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536736; cv=none; b=fRsUWLgigHyyItgv2iGoIulaS86VpsNObH94BKOf/akJaAJW6k1K598r17PbOfXjA6WwAGQhEVdO4poxoERooi1C7QYlgjEU3CQK1Zm6BwRCNN99GoGQ5a5EGD5xHQlm1C0ZZIgF1VxjCTcGyJTHAluUTzi7z0LAl5V5jl7I9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536736; c=relaxed/simple;
	bh=OD/ffHFxZ++34/DBjc4qmLxoDjO8lky17FNP/jB2VGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrWtCFySnAVI/Z0JwZal6EtBfaH9HWRynaskaqIHbBEX85dZM4e5Nvfb47OK6T61DOgFALlL6NKbF7kq5cp973jyC11196gg6pQF+J5G1B5SNj6sZexYVv26YnP/Kn4cO8tRIXRUPqieTY/3pxdILHLJpeNM4EfrI6A/dFOLGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7ZUP3zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95871C4CECE
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732536735;
	bh=OD/ffHFxZ++34/DBjc4qmLxoDjO8lky17FNP/jB2VGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l7ZUP3zUqvXJbBYm746/q2OWGx2eNlkW/SG/zQZe3ZSOqyl0dcocPSOYDTn2+cyMJ
	 RxEoFtupu5GrwZgAQQKrDQkyDE84mrRsZZr6MYzdPFIp8635Qq/Y0yWgj42PmCvNjq
	 hh6xWX1q6E6F3bfgUdCmUJxHtyNiqm+txrPSWAwbMa1oOpZ9osF+1nwhXNuXZowYtf
	 SfHHAyRlJPUZM9VxfsjGzYTKNGy5B1oaT5gLr69EwIy/j/Vxq2qSTA/0LAepaPDgfm
	 mGYm1aWAtcUufNr9Wlqf00QYkmYaCNaf4/vr3hNU9EAM2EYzAmSgmArVoIkgvvM/LU
	 46M4wgcBvrTYw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de79c2be4so90640e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 04:12:15 -0800 (PST)
X-Gm-Message-State: AOJu0YwRb0upeFOLrVYczYJxgBvun17CskehakmQiuZ1kA9TOFcYRJRt
	NJWmQs6y1PAiEfR7FnRajkKXxtO4DCfrlKZLx1LLD5gr//VYuXh1LHCLmkYJMy1ikSbF3Ve67lU
	mRtyZDJq3WypXUy0AFmoMcEFIX0k=
X-Google-Smtp-Source: AGHT+IGiR2FRESyOznWHFCoIQ+aQdrFvlilnGPeGPcpnN59yt59SIQWGtK8awffnlXv82l6KSW0Bo6rna2a5MQN+WYg=
X-Received: by 2002:a05:6512:3ca4:b0:53d:e732:1588 with SMTP id
 2adb3069b0e04-53de7321884mr558406e87.38.1732536733732; Mon, 25 Nov 2024
 04:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724690141.git.josef@toxicpanda.com> <3a8713ffde30072690bcc9149ec211abc1aed8ca.1724690141.git.josef@toxicpanda.com>
In-Reply-To: <3a8713ffde30072690bcc9149ec211abc1aed8ca.1724690141.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 25 Nov 2024 12:11:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7wzZnwmLHM2g=QvGBk4U6OzrCQmSvdP+0DXmM5FXjg-g@mail.gmail.com>
Message-ID: <CAL3q7H7wzZnwmLHM2g=QvGBk4U6OzrCQmSvdP+0DXmM5FXjg-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: do not hold the extent lock for entire read
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:39=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Historically we've held the extent lock throughout the entire read.
> There's been a few reasons for this, but it's mostly just caused us
> problems.  For example, this prevents us from allowing page faults
> during direct io reads, because we could deadlock.  This has forced us
> to only allow 4k reads at a time for io_uring NOWAIT requests because we
> have no idea if we'll be forced to page fault and thus have to do a
> whole lot of work.
>
> On the buffered side we are protected by the page lock, as long as we're
> reading things like buffered writes, punch hole, and even direct IO to a
> certain degree will get hung up on the page lock while the page is in
> flight.
>
> On the direct side we have the dio extent lock, which acts much like the
> way the extent lock worked previously to this patch, however just for
> direct reads.  This protects direct reads from concurrent direct writes,
> while we're protected from buffered writes via the inode lock.
>
> Now that we're protected in all cases, narrow the extent lock to the
> part where we're getting the extent map to submit the reads, no longer
> holding the extent lock for the entire read operation.  Push the extent
> lock down into do_readpage() so that we're only grabbing it when looking
> up the extent map.  This portion was contributed by Goldwyn.
>
> Co-developed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/compression.c |  2 +-
>  fs/btrfs/direct-io.c   | 51 +++++++++++------------
>  fs/btrfs/extent_io.c   | 94 ++----------------------------------------
>  3 files changed, 29 insertions(+), 118 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 832ab8984c41..511f81f312af 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -521,6 +521,7 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>                 }
>                 add_size =3D min(em->start + em->len, page_end + 1) - cur=
;
>                 free_extent_map(em);
> +               unlock_extent(tree, cur, page_end, NULL);
>
>                 if (folio->index =3D=3D end_index) {
>                         size_t zero_offset =3D offset_in_folio(folio, isi=
ze);
> @@ -534,7 +535,6 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>
>                 if (!bio_add_folio(orig_bio, folio, add_size,
>                                    offset_in_folio(folio, cur))) {
> -                       unlock_extent(tree, cur, page_end, NULL);
>                         folio_unlock(folio);
>                         folio_put(folio);
>                         break;
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 576f469cacee..66f1ce5fcfd2 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -366,7 +366,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode,=
 loff_t start,
>         int ret =3D 0;
>         u64 len =3D length;
>         const u64 data_alloc_len =3D length;
> -       bool unlock_extents =3D false;
> +       u32 unlock_bits =3D EXTENT_LOCKED;
>
>         /*
>          * We could potentially fault if we have a buffer > PAGE_SIZE, an=
d if
> @@ -527,7 +527,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode,=
 loff_t start,
>                                                     start, &len, flags);
>                 if (ret < 0)
>                         goto unlock_err;
> -               unlock_extents =3D true;
>                 /* Recalc len in case the new em is smaller than requeste=
d */
>                 len =3D min(len, em->len - (start - em->start));
>                 if (dio_data->data_space_reserved) {
> @@ -548,23 +547,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode=
, loff_t start,
>                                                                release_of=
fset,
>                                                                release_le=
n);
>                 }
> -       } else {
> -               /*
> -                * We need to unlock only the end area that we aren't usi=
ng.
> -                * The rest is going to be unlocked by the endio routine.
> -                */
> -               lockstart =3D start + len;
> -               if (lockstart < lockend)
> -                       unlock_extents =3D true;
>         }
>
> -       if (unlock_extents)
> -               clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, loc=
kend,
> -                                EXTENT_LOCKED | EXTENT_DIO_LOCKED,
> -                                &cached_state);
> -       else
> -               free_extent_state(cached_state);
> -
>         /*
>          * Translate extent map information to iomap.
>          * We trim the extents (and move the addr) even though iomap code=
 does
> @@ -583,6 +567,23 @@ static int btrfs_dio_iomap_begin(struct inode *inode=
, loff_t start,
>         iomap->length =3D len;
>         free_extent_map(em);
>
> +       /*
> +        * Reads will hold the EXTENT_DIO_LOCKED bit until the io is comp=
leted,
> +        * writes only hold it for this part.  We hold the extent lock un=
til
> +        * we're completely done with the extent map to make sure it rema=
ins
> +        * valid.
> +        */
> +       if (write)
> +               unlock_bits |=3D EXTENT_DIO_LOCKED;
> +
> +       clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> +                        unlock_bits, &cached_state);
> +
> +       /* We didn't use everything, unlock the dio extent for the remain=
der. */
> +       if (!write && (start + len) < lockend)
> +               unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len,
> +                                 lockend, NULL);
> +
>         return 0;
>
>  unlock_err:
> @@ -615,9 +616,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, l=
off_t pos, loff_t length,
>
>         if (!write && (iomap->type =3D=3D IOMAP_HOLE)) {
>                 /* If reading from a hole, unlock and return */
> -               clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> -                                 pos + length - 1,
> -                                 EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL=
);
> +               unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> +                                 pos + length - 1, NULL);
>                 return 0;
>         }
>
> @@ -628,10 +628,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, =
loff_t pos, loff_t length,
>                         btrfs_finish_ordered_extent(dio_data->ordered, NU=
LL,
>                                                     pos, length, false);
>                 else
> -                       clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> -                                        pos + length - 1,
> -                                        EXTENT_LOCKED | EXTENT_DIO_LOCKE=
D,
> -                                        NULL);
> +                       unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> +                                         pos + length - 1, NULL);
>                 ret =3D -ENOTBLK;
>         }
>         if (write) {
> @@ -663,9 +661,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
>                                             dip->file_offset, dip->bytes,
>                                             !bio->bi_status);
>         } else {
> -               clear_extent_bit(&inode->io_tree, dip->file_offset,
> -                                dip->file_offset + dip->bytes - 1,
> -                                EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL)=
;
> +               unlock_dio_extent(&inode->io_tree, dip->file_offset,
> +                                 dip->file_offset + dip->bytes - 1, NULL=
);
>         }
>
>         bbio->bio.bi_private =3D bbio->private;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6083bed89df2..77161116af7a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -480,75 +480,6 @@ static void end_bbio_data_write(struct btrfs_bio *bb=
io)
>         bio_put(bio);
>  }
>
> -/*
> - * Record previously processed extent range
> - *
> - * For endio_readpage_release_extent() to handle a full extent range, re=
ducing
> - * the extent io operations.
> - */
> -struct processed_extent {
> -       struct btrfs_inode *inode;
> -       /* Start of the range in @inode */
> -       u64 start;
> -       /* End of the range in @inode */
> -       u64 end;
> -       bool uptodate;
> -};
> -
> -/*
> - * Try to release processed extent range
> - *
> - * May not release the extent range right now if the current range is
> - * contiguous to processed extent.
> - *
> - * Will release processed extent when any of @inode, @uptodate, the rang=
e is
> - * no longer contiguous to the processed range.
> - *
> - * Passing @inode =3D=3D NULL will force processed extent to be released=
.
> - */
> -static void endio_readpage_release_extent(struct processed_extent *proce=
ssed,
> -                             struct btrfs_inode *inode, u64 start, u64 e=
nd,
> -                             bool uptodate)
> -{
> -       struct extent_state *cached =3D NULL;
> -       struct extent_io_tree *tree;
> -
> -       /* The first extent, initialize @processed */
> -       if (!processed->inode)
> -               goto update;
> -
> -       /*
> -        * Contiguous to processed extent, just uptodate the end.
> -        *
> -        * Several things to notice:
> -        *
> -        * - bio can be merged as long as on-disk bytenr is contiguous
> -        *   This means we can have page belonging to other inodes, thus =
need to
> -        *   check if the inode still matches.
> -        * - bvec can contain range beyond current page for multi-page bv=
ec
> -        *   Thus we need to do processed->end + 1 >=3D start check
> -        */
> -       if (processed->inode =3D=3D inode && processed->uptodate =3D=3D u=
ptodate &&
> -           processed->end + 1 >=3D start && end >=3D processed->end) {
> -               processed->end =3D end;
> -               return;
> -       }
> -
> -       tree =3D &processed->inode->io_tree;
> -       /*
> -        * Now we don't have range contiguous to the processed range, rel=
ease
> -        * the processed range now.
> -        */
> -       unlock_extent(tree, processed->start, processed->end, &cached);
> -
> -update:
> -       /* Update processed to current range */
> -       processed->inode =3D inode;
> -       processed->start =3D start;
> -       processed->end =3D end;
> -       processed->uptodate =3D uptodate;
> -}
> -
>  static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio=
 *folio)
>  {
>         ASSERT(folio_test_locked(folio));
> @@ -575,7 +506,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio=
)
>  {
>         struct btrfs_fs_info *fs_info =3D bbio->fs_info;
>         struct bio *bio =3D &bbio->bio;
> -       struct processed_extent processed =3D { 0 };
>         struct folio_iter fi;
>         const u32 sectorsize =3D fs_info->sectorsize;
>
> @@ -640,11 +570,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbi=
o)
>
>                 /* Update page status and unlock. */
>                 end_folio_read(folio, uptodate, start, len);
> -               endio_readpage_release_extent(&processed, BTRFS_I(inode),
> -                                             start, end, uptodate);
>         }
> -       /* Release the last extent */
> -       endio_readpage_release_extent(&processed, NULL, 0, 0, false);
>         bio_put(bio);
>  }
>
> @@ -973,6 +899,7 @@ static struct extent_map *__get_extent_map(struct ino=
de *inode,
>                                            u64 len, struct extent_map **e=
m_cached)
>  {
>         struct extent_map *em;
> +       struct extent_state *cached_state =3D NULL;
>
>         ASSERT(em_cached);
>
> @@ -988,12 +915,15 @@ static struct extent_map *__get_extent_map(struct i=
node *inode,
>                 *em_cached =3D NULL;
>         }
>
> +       btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start +=
 len - 1, &cached_state);
>         em =3D btrfs_get_extent(BTRFS_I(inode), folio, start, len);
>         if (!IS_ERR(em)) {
>                 BUG_ON(*em_cached);
>                 refcount_inc(&em->refs);
>                 *em_cached =3D em;
>         }
> +       unlock_extent(&BTRFS_I(inode)->io_tree, start, start + len - 1, &=
cached_state);

Sorry for the late review, but I missed this when it was posted, was
busy with other stuff and summer holidays were approaching.

I don't see how this is safe against concurrent COW writes, this
leaves here some races that trigger either checksum
failures making the reads fail with -EIO or allow a read to read data
from another file (and that can be seen as a
security issue).

So before this patch we locked the extent range when we started the
read and then unlocked it only after read bios
finished - after the data was read from disk and we verified it
matches the checksums.

But now we lock it only to get an extent map, and we unlock it
immediately after getting the extent map.

So first unsafe scenario, for the simple case of reading a single 4K page:

1) We lock the extent range, get the extent map, which lets say points
to an extent at disk_bytenr X, and then unlock the range;

2) We read the checksums from the csum tree and submit the read bios
later, when calling btrfs_submit_bbio() -> btrfs_submit_chunk();

3) But before we go into btrfs_submit_bbio(), a COW write comes for 4K
range, which will now proceed because we are not locking
   the extent range for the whole duration of the read anymore.

   This results in removing extent X, replacing it with a new one, and
pinning it in the current transaction N;

4) Still before we reach btrfs_submit_bio(), transaction N is
committed, so extent X is unpinned and from
   now on anyone can allocate that extent;

5) A write for another file happens and it allocates extent X, writes
to it, and adds checksums to the csum tree;

6) Our read proceeds and enters btrfs_submit_bbio().
   So we submit a read for extent X and the read will succeed since
the checksums match the extent's data.

   We end up reading data from another file - this can cause all sorts
of unexpected results to applications,
   and can also be seen as a security issue.

Another possible race, again for reading a single 4K page (simplest case):

1) We lock the extent range, get the extent map, which lets say points
to an extent at disk_bytenr X, and then unlock the range;

2) We get into btrfs_submit_bbio() -> btrfs_submit_chunk() ->
btrfs_lookup_bio_sums() and reads the checksums for the extent
   from the csum tree;

3) Before we submit the read bio(s), a COW write for this range
happens, so it drops extent X and pins it in the current transaction
N;

4) Transaction N is committed, so extent X is unpinned and can now be
re-allocated by anyone;

5) A write for another file happens and it allocates extent X, writing
data to it;

6) The read proceeds and submits a bio to read extent X;

7) When the bio completes we do checksum validation and we fail, since
the data does not match the checksums we got
   in step 2, as a result the read will fail -EIO due to checksum failure.

These are races we didn't have before, since we unlocked the extent
range only after the bio completed.

Please tell me that I'm missing something here and these races are impossib=
le.

Thanks.

> +
>         return em;
>  }
>  /*
> @@ -1019,11 +949,9 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>         size_t pg_offset =3D 0;
>         size_t iosize;
>         size_t blocksize =3D fs_info->sectorsize;
> -       struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
>
>         ret =3D set_folio_extent_mapped(folio);
>         if (ret < 0) {
> -               unlock_extent(tree, start, end, NULL);
>                 folio_unlock(folio);
>                 return ret;
>         }
> @@ -1047,14 +975,12 @@ static int btrfs_do_readpage(struct folio *folio, =
struct extent_map **em_cached,
>                 if (cur >=3D last_byte) {
>                         iosize =3D folio_size(folio) - pg_offset;
>                         folio_zero_range(folio, pg_offset, iosize);
> -                       unlock_extent(tree, cur, cur + iosize - 1, NULL);
>                         end_folio_read(folio, true, cur, iosize);
>                         break;
>                 }
>                 em =3D __get_extent_map(inode, folio, cur, end - cur + 1,
>                                       em_cached);
>                 if (IS_ERR(em)) {
> -                       unlock_extent(tree, cur, end, NULL);
>                         end_folio_read(folio, false, cur, end + 1 - cur);
>                         return PTR_ERR(em);
>                 }
> @@ -1123,7 +1049,6 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>                 if (block_start =3D=3D EXTENT_MAP_HOLE) {
>                         folio_zero_range(folio, pg_offset, iosize);
>
> -                       unlock_extent(tree, cur, cur + iosize - 1, NULL);
>                         end_folio_read(folio, true, cur, iosize);
>                         cur =3D cur + iosize;
>                         pg_offset +=3D iosize;
> @@ -1131,7 +1056,6 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>                 }
>                 /* the get_extent function already copied into the folio =
*/
>                 if (block_start =3D=3D EXTENT_MAP_INLINE) {
> -                       unlock_extent(tree, cur, cur + iosize - 1, NULL);
>                         end_folio_read(folio, true, cur, iosize);
>                         cur =3D cur + iosize;
>                         pg_offset +=3D iosize;
> @@ -1156,15 +1080,10 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
>
>  int btrfs_read_folio(struct file *file, struct folio *folio)
>  {
> -       struct btrfs_inode *inode =3D folio_to_inode(folio);
> -       u64 start =3D folio_pos(folio);
> -       u64 end =3D start + folio_size(folio) - 1;
>         struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
>         struct extent_map *em_cached =3D NULL;
>         int ret;
>
> -       btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> -
>         ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
>         free_extent_map(em_cached);
>
> @@ -2337,15 +2256,10 @@ int btrfs_writepages(struct address_space *mappin=
g, struct writeback_control *wb
>  void btrfs_readahead(struct readahead_control *rac)
>  {
>         struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ | REQ_R=
AHEAD };
> -       struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
>         struct folio *folio;
> -       u64 start =3D readahead_pos(rac);
> -       u64 end =3D start + readahead_length(rac) - 1;
>         struct extent_map *em_cached =3D NULL;
>         u64 prev_em_start =3D (u64)-1;
>
> -       btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> -
>         while ((folio =3D readahead_folio(rac)) !=3D NULL)
>                 btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_=
start);
>
> --
> 2.43.0
>
>

