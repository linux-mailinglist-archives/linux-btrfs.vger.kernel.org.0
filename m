Return-Path: <linux-btrfs+bounces-11780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE596A44763
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D832D19C2DCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96F195808;
	Tue, 25 Feb 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZlJZYrR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA551191F6F
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503152; cv=none; b=PADWA+ZWTprx1GQi4QkQfFphx2aSkSYUcEMs7uIvoarkfOY0nYLEBaRRU4K/QFsI53Hj3Wmhs/LGU8CUVTiVWBOVjeaHk0vVRm4gM7wwJ4g6L6W2v0G1G3+aiw5KEtquLzuITZ7q0dkNwhtcAv1GcYsUqYX3gazujIbJaovE0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503152; c=relaxed/simple;
	bh=RJjWbNGeRIGA1AsafVFK+s9tLSyMeyf08X9rr6O71oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FanipGC+XDyrJKKtpSNIRZCctSty5OpxEZ6lCTccsNBDpVBGjqKxIcxDd+jz2rKazkqLjPheEhMvgxNaZAqI6fi65GbKBKbXZAvmhFZ6FFViirAZmPREd7oHKYkI/ik2OyD/fWHON4QSxtdzcKXRseroHJoatZfS/DjT8eU4xb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZlJZYrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E68C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503152;
	bh=RJjWbNGeRIGA1AsafVFK+s9tLSyMeyf08X9rr6O71oQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mZlJZYrR8fgI2owZtXRQoiFsNGlqtp0uQGaN4Mnq6KIGoX2ekb8Y2GYDa6B3b8QgU
	 cSwqtuF2PG3o8pnDS48/P6cOvYmnwl1ZGOrn2J4/+cJjQgJN0Zp3+OmNDwg+6Ff/1z
	 ypGYzuWi1+MsOnU0oVof1+16G479EZGrK5JjHA03CVclVQ2rJZ9HqL8cZ40/KYvekF
	 7eBSt7qDZ7EX+Y91YIyPklyt5nxyeb6w+Xp4xUu/PqTvw5anVxRWnAAVfQpEVd1cqJ
	 bWjeRlV6YAOBfMIVES0abPzNafZP2mNcykb/UTpNTRRLSb9rCjQpAdv4MIp986FwtZ
	 b1s7WcHRRU4jw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abec925a135so207589166b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:05:52 -0800 (PST)
X-Gm-Message-State: AOJu0YwUM6nEuCWFCE1OXE4msETzCiSqMPrERnhKA+0jsQSY6Z0m+Mod
	E02VF3oCRdivC0zSGd0DY3q752p6mZ0UkxZiBo06n9lEDm+LTF84h4TBHItbNdU/VxlC+JUkJoB
	E8H1ZjWImwl73CTzGunl4cNDXijE=
X-Google-Smtp-Source: AGHT+IGpFkRCGq0RiZKLGR+9Pg9Qv7WAEcDoGZtmTybE1TwoR19OL96V35wqj5gLZE0faTpywPal5YpR8Z5iTNcemr8=
X-Received: by 2002:a17:907:c920:b0:abc:c40:b385 with SMTP id
 a640c23a62f3a-abc0c40bb25mr1433289666b.37.1740503150538; Tue, 25 Feb 2025
 09:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
In-Reply-To: <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 17:05:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com>
X-Gm-Features: AWEUYZnfjZAqKdr1hC1Vv3yJYehbbQiuys7UuXidj-aS5PVkyEUTtfAGbOQWGDk
Message-ID: <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] btrfs: introduce a read path dedicated extent lock helper
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently we're using btrfs_lock_and_flush_ordered_range() for both
> btrfs_read_folio() and btrfs_readahead(), but it has one critical
> problem for future subpage enhancements:
>
> - It will call btrfs_start_ordered_extent() to writeback the involved
>   folios
>
>   But remember we're calling btrfs_lock_and_flush_ordered_range() at
>   read paths, meaning the folio is already locked by read path.
>
>   If we really trigger writeback, this will lead to a deadlock and
>   writeback can not hold the folio lock.
>
>   Such dead lock is prevented by the fact that btrfs always keeps a
>   dirty folio also uptodate, by either dirtying all blocks of the folio,
>   or read the folio before dirtying.
>
>   But it's not the common behavior, as XFS/EXT4 both allow the folio to
>   be dirty but not uptodate, by allowing buffered write to dirty a full
>   block without reading the full folio.

Ok, but what happens in other filesystems doesn't affect us.
Or did you forget to mention that some other subsequent patch or planned ch=
anges
will introduce that behaviour?

If so, it would be best to say that, otherwise that paragraph isn't relevan=
t.

>
> Instead of blindly calling btrfs_start_ordered_extent(), introduce a
> newer helper, which is smarter in the following ways:
>
> - Only wait and flush the ordered extent if
>   * The folio doesn't even have private set
>   * Part of the blocks of the ordered extent is not uptodate

is -> are

>
>   This can happen by:
>   * Folio writeback finished, then get invalidated. But OE not yet
>     finished

Ok, this one I understand.

>   * Direct IO

This one I don't because direct IO doesn't use the page cache.
Can you elaborate here and explain why it can happen with direct IO?

>
>   We have to wait for the ordered extent, as it may contain
>   to-be-inserted data checksum.
>   Without waiting, our read can fail due to the missing csum.
>
>   But either way, the OE should not need any extra flush inside the
>   locked folio range.
>
> - Skip the ordered extent completely if
>   * All the blocks are dirty
>     This happens when OE creation is caused by previous folio.

"OE creation is caused by previous folio" - what does this mean?
You mean by a write that happened before the read?


>     The writeback will never happen (we're holding the folio lock for
>     read), nor will the OE finish.
>
>     Thus we must skip the range.
>
>   * All the blocks are uptodate
>     This happens when the writeback finished, but OE not yet finished.
>
>     Since the blocks are already uptodate, we can skip the OE range.
>
> The newer helper, lock_extents_for_read() will do a loop for the target
> range by:
>
> 1) Lock the full range
>
> 2) If there is no ordered extent in the remaining range, exit
>
> 3) If there is an ordered extent that we can skip
>    Skip to the end of the OE, and continue checking
>    We do not trigger writeback nor wait for the OE.
>
> 4) If there is an ordered extent that we can not skip
>    Unlock the whole extent range and start the ordered extent.
>
> And also update btrfs_start_ordered_extent() to add two more parameters:
> @nowriteback_start and @nowriteback_len, to prevent triggering flush for
> a certain range.
>
> This will allow us to handle the following case properly in the future:
>
>  16K page size, 4K btrfs block size:
>
>  16K           20K             24K              28K            32K
>  |/////////////////////////////|                |              |
>  |<----------- OE 2----------->|                |<--- OE 1 --->|
>
>  The folio has been written back before, thus we have an OE at
>  [28K, 32K).
>  Although the OE 1 finished its IO, the OE is not yet removed from IO
>  tree.
>  Later the folio got invalidated, but OE still exists.

This last sentence to be less confusing: "The folio got invalited
after writeback completed and before the ordered extent finished."

>
>  And [16K, 24K) range is dirty and uptodate, caused by a block aligned
>  buffered write (and future enhancements allowing btrfs to skip full
>  folio read for such case).
>
>  Furthermore, OE 2 is created covering range [16K, 24K) by the writeback
>  of previous folio.

What previous folio? There's no other one in the example.
Do you mean there's a folio for range [0, 16K) and running delalloc
resulted in the creation of an OE for the range [0, 24K)? So that OE 2
doesn't really start at 16K but at 0 instead?

>
>  Since the full folio is not uptodate, if we want to read the folio,
>  the existing btrfs_lock_and_flush_ordered_range() will dead lock, by:
>
>  btrfs_read_folio()
>  | Folio 16K is already locked
>  |- btrfs_lock_and_flush_ordered_range()
>     |- btrfs_start_ordered_extent() for range [16K, 24K)
>        |- filemap_fdatawrite_range() for range [16K, 24K)
>           |- extent_write_cache_pages()
>              folio_lock() on folio 16K, deadlock.
>
>  But now we will have the following sequence:
>
>  btrfs_read_folio()
>  | Folio 16K is already locked
>  |- lock_extents_for_read()
>     |- can_skip_ordered_extent() for range [16K, 24K)
>     |  Returned true, the range [16K, 24K) will be skipped.
>     |- can_skip_ordered_extent() for range [28K, 32K)
>     |  Returned false.
>     |- btrfs_start_ordered_extent() for range [28K, 32K) with
>        [16K, 32K) as no writeback range
>        No writeback for folio 16K will be triggered.
>
>  And there will be no more possible deadlock on the same folio.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/defrag.c       |   2 +-
>  fs/btrfs/direct-io.c    |   2 +-
>  fs/btrfs/extent_io.c    | 183 +++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/file.c         |   4 +-
>  fs/btrfs/inode.c        |   4 +-
>  fs/btrfs/ordered-data.c |  29 +++++--
>  fs/btrfs/ordered-data.h |   3 +-
>  7 files changed, 210 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 18f0704263f3..4b89094da3de 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -902,7 +902,7 @@ static struct folio *defrag_prepare_one_folio(struct =
btrfs_inode *inode, pgoff_t
>                         break;
>
>                 folio_unlock(folio);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, 0, 0);
>                 btrfs_put_ordered_extent(ordered);
>                 folio_lock(folio);
>                 /*
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index e8548de319e7..fb6df17fb55c 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -103,7 +103,7 @@ static int lock_extent_direct(struct inode *inode, u6=
4 lockstart, u64 lockend,
>                          */
>                         if (writing ||
>                             test_bit(BTRFS_ORDERED_DIRECT, &ordered->flag=
s))
> -                               btrfs_start_ordered_extent(ordered);
> +                               btrfs_start_ordered_extent(ordered, 0, 0)=
;
>                         else
>                                 ret =3D nowait ? -EAGAIN : -ENOTBLK;
>                         btrfs_put_ordered_extent(ordered);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7b0aa332aedc..a6ffee6f6fd9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1081,6 +1081,185 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
>         return 0;
>  }
>
> +/*
> + * Check if we can skip waiting the @ordered extent covering the block
> + * at file pos @cur.
> + *
> + * Return true if we can skip to @next_ret. The caller needs to check
> + * the @next_ret value to make sure if covers the full range, before

if covers -> it covers

> + * skipping the OE.
> + *
> + * Return false if we must wait for the ordered extent.
> + *
> + * @cur:       The start file offset that we have locked folio for read.
> + * @next_ret:  If we return true, this indiciates the next check start

indiciates -> indicates

> + *             range.

Normally the parameter list/description comes before describing the
return values.

> + */
> +static bool can_skip_one_ordered_range(struct btrfs_inode *binode,

Why binode and not just inode? There's no vfs inode in the function to
make any confusion.


> +                                      struct btrfs_ordered_extent *order=
ed,
> +                                      u64 cur, u64 *next_ret)
> +{
> +       const struct btrfs_fs_info *fs_info =3D binode->root->fs_info;
> +       struct folio *folio;
> +       const u32 blocksize =3D fs_info->sectorsize;
> +       u64 range_len;
> +       bool ret;
> +
> +       folio =3D filemap_get_folio(binode->vfs_inode.i_mapping,
> +                                 cur >> PAGE_SHIFT);
> +
> +       /*
> +        * We should have locked the folio(s) for range [start, end], thu=
s
> +        * there must be a folio and it must be locked.
> +        */
> +       ASSERT(!IS_ERR(folio));
> +       ASSERT(folio_test_locked(folio));
> +
> +       /*
> +        * We several cases for the folio and OE combination:
> +        *
> +        * 0) Folio has no private flag

Why does the numbering start from 0? It's not code and it's not
related to array indexes or offsets :)

> +        *    The OE has all its IO done but not yet finished, and folio =
got
> +        *    invalidated. Or direct IO.

Ok so I still don't understand the direct IO case, because direct IO
doesn't use the page cache.
Just like the change log, some explanation here would be desired.

> +        *
> +        * Have to wait for the OE to finish, as it may contain the
> +        * to-be-inserted data checksum.
> +        * Without the data checksum inserted into csum tree, read
> +        * will just fail with missing csum.

Well we don't need to wait if it's a NOCOW / NODATASUM write.

> +        */
> +       if (!folio_test_private(folio)) {
> +               ret =3D false;
> +               goto out;
> +       }
> +       range_len =3D min(folio_pos(folio) + folio_size(folio),
> +                       ordered->file_offset + ordered->num_bytes) - cur;

This isn't used, only in one if branch below which repeats the computation.

> +
> +       /*
> +        * 1) The first block is DIRTY.
> +        *
> +        * This means the OE is created by some folio before us, but writ=
eback
> +        * has not started.
> +        * We can and must skip the whole OE, because it will never start=
 until
> +        * we finished our folio read and unlocked the folio.
> +        */
> +       if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
> +               ret =3D true;
> +               /*
> +                * At least inside the folio, all the remaining blocks sh=
ould
> +                * also be dirty.
> +                */
> +               ASSERT(btrfs_folio_test_dirty(fs_info, folio, cur, range_=
len));
> +               *next_ret =3D ordered->file_offset + ordered->num_bytes;
> +               goto out;
> +       }
> +
> +       /*
> +        * 2) The first block is uptodate.
> +        *
> +        * At least the first block can be skipped, but we are still
> +        * not full sure. E.g. if the OE has some other folios in
> +        * the range that can not be skipped.
> +        * So we return true and update @next_ret to the OE/folio boundar=
y.
> +        */
> +       if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
> +               u64 range_len =3D min(folio_pos(folio) + folio_size(folio=
),
> +                                   ordered->file_offset + ordered->num_b=
ytes) - cur;

Here, it's the same computation.
So we can remove the previous one and the range_len variable defined
at the top level scope.

> +
> +               /*
> +                * The whole range to the OE end or folio boundary should=
 also
> +                * be uptodate.
> +                */
> +               ASSERT(btrfs_folio_test_uptodate(fs_info, folio, cur, ran=
ge_len));
> +               ret =3D true;
> +               *next_ret =3D cur + range_len;
> +               goto out;
> +       }
> +
> +       /*
> +        * 3) The first block is not uptodate.
> +        *
> +        * This means the folio is invalidated after the OE finished, or =
direct IO.
> +        * Very much the same as case 1), just with private flag set.
> +        */
> +       ret =3D false;
> +out:
> +       folio_put(folio);
> +       return ret;
> +}
> +
> +static bool can_skip_ordered_extent(struct btrfs_inode *binode,

Same here, call it inode instead of binode.

> +                                   struct btrfs_ordered_extent *ordered,
> +                                   u64 start, u64 end)
> +{
> +       u64 range_end =3D min(end, ordered->file_offset + ordered->num_by=
tes - 1);
> +       u64 range_start =3D max(start, ordered->file_offset);
> +       u64 cur =3D range_start;

Well the range_start variable is not really needed, could assign its
expression to 'cur'.
range_end can also be made const.

> +
> +       while (cur < range_end) {
> +               bool can_skip;
> +               u64 next_start;
> +
> +               can_skip =3D can_skip_one_ordered_range(binode, ordered, =
cur,
> +                                                     &next_start);

Can pass &cur and get rid of the next_start variable.


> +               if (!can_skip)
> +                       return false;
> +               cur =3D next_start;
> +       }
> +       return true;
> +}
> +
> +/*
> + * To make sure we get a stable view of extent maps for the involved ran=
ge.
> + * This is for folio read paths (read and readahead), thus involved rang=
e
> + * should have all the folios locked.
> + */
> +static void lock_extents_for_read(struct btrfs_inode *binode, u64 start,=
 u64 end,

Same here, call it inode instead of binode.

> +                                 struct extent_state **cached_state)
> +{
> +       struct btrfs_ordered_extent *ordered;

This isn't used in this scope, so it can be moved to the scope of the
while loop below.

> +       u64 cur_pos;
> +
> +       /* Caller must provide a valid @cached_state. */
> +       ASSERT(cached_state);
> +
> +       /*
> +        * The range must at least be page aligned, as all read paths
> +        * are folio based.
> +        */
> +       ASSERT(IS_ALIGNED(start, PAGE_SIZE) && IS_ALIGNED(end + 1, PAGE_S=
IZE));

It's best to have one ASSERT per condition, as it makes it easy to
figure out which one fails in case the assertion is triggered.

Thanks.


> +
> +again:
> +       lock_extent(&binode->io_tree, start, end, cached_state);
> +       cur_pos =3D start;
> +       while (cur_pos < end) {
> +               ordered =3D btrfs_lookup_ordered_range(binode, cur_pos,
> +                                                    end - cur_pos + 1);
> +               /*
> +                * No ordered extents in the range, and we hold the
> +                * extent lock, no one can modify the extent maps
> +                * in the range, we're safe to return.
> +                */
> +               if (!ordered)
> +                       break;
> +
> +               /* Check if we can skip waiting for the whole OE. */
> +               if (can_skip_ordered_extent(binode, ordered, start, end))=
 {
> +                       cur_pos =3D min(ordered->file_offset + ordered->n=
um_bytes,
> +                                     end + 1);
> +                       btrfs_put_ordered_extent(ordered);
> +                       continue;
> +               }
> +
> +               /* Now wait for the OE to finish. */
> +               unlock_extent(&binode->io_tree, start, end,
> +                             cached_state);
> +               btrfs_start_ordered_extent(ordered, start, end + 1 - star=
t);
> +               btrfs_put_ordered_extent(ordered);
> +               /* We have unlocked the whole range, restart from the beg=
inning. */
> +               goto again;
> +       }
> +}
> +
>  int btrfs_read_folio(struct file *file, struct folio *folio)
>  {
>         struct btrfs_inode *inode =3D folio_to_inode(folio);
> @@ -1091,7 +1270,7 @@ int btrfs_read_folio(struct file *file, struct foli=
o *folio)
>         struct extent_map *em_cached =3D NULL;
>         int ret;
>
> -       btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_sta=
te);
> +       lock_extents_for_read(inode, start, end, &cached_state);
>         ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
>         unlock_extent(&inode->io_tree, start, end, &cached_state);
>
> @@ -2380,7 +2559,7 @@ void btrfs_readahead(struct readahead_control *rac)
>         struct extent_map *em_cached =3D NULL;
>         u64 prev_em_start =3D (u64)-1;
>
> -       btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_sta=
te);
> +       lock_extents_for_read(inode, start, end, &cached_state);
>
>         while ((folio =3D readahead_folio(rac)) !=3D NULL)
>                 btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_=
start);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e87d4a37c929..00c68b7b2206 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -941,7 +941,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *i=
node, struct folio *folio,
>                                       cached_state);
>                         folio_unlock(folio);
>                         folio_put(folio);
> -                       btrfs_start_ordered_extent(ordered);
> +                       btrfs_start_ordered_extent(ordered, 0, 0);
>                         btrfs_put_ordered_extent(ordered);
>                         return -EAGAIN;
>                 }
> @@ -1855,7 +1855,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_faul=
t *vmf)
>                 unlock_extent(io_tree, page_start, page_end, &cached_stat=
e);
>                 folio_unlock(folio);
>                 up_read(&BTRFS_I(inode)->i_mmap_lock);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, 0, 0);
>                 btrfs_put_ordered_extent(ordered);
>                 goto again;
>         }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0efe9f005149..e99cb5109967 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2821,7 +2821,7 @@ static void btrfs_writepage_fixup_worker(struct btr=
fs_work *work)
>                 unlock_extent(&inode->io_tree, page_start, page_end,
>                               &cached_state);
>                 folio_unlock(folio);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, 0, 0);
>                 btrfs_put_ordered_extent(ordered);
>                 goto again;
>         }
> @@ -4873,7 +4873,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode,=
 loff_t from, loff_t len,
>                 unlock_extent(io_tree, block_start, block_end, &cached_st=
ate);
>                 folio_unlock(folio);
>                 folio_put(folio);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, 0, 0);
>                 btrfs_put_ordered_extent(ordered);
>                 goto again;
>         }
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4aca7475fd82..6075a6fa4817 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct btrf=
s_work *work)
>         struct btrfs_ordered_extent *ordered;
>
>         ordered =3D container_of(work, struct btrfs_ordered_extent, flush=
_work);
> -       btrfs_start_ordered_extent(ordered);
> +       btrfs_start_ordered_extent(ordered, 0, 0);
>         complete(&ordered->completion);
>  }
>
> @@ -842,10 +842,12 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info =
*fs_info, u64 nr,
>  /*
>   * Start IO and wait for a given ordered extent to finish.
>   *
> - * Wait on page writeback for all the pages in the extent and the IO com=
pletion
> - * code to insert metadata into the btree corresponding to the extent.
> + * Wait on page writeback for all the pages in the extent but not in
> + * [@nowriteback_start, @nowriteback_start + @nowriteback_len) and the
> + * IO completion code to insert metadata into the btree corresponding to=
 the extent.
>   */
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
> +                               u64 nowriteback_start, u32 nowriteback_le=
n)
>  {
>         u64 start =3D entry->file_offset;
>         u64 end =3D start + entry->num_bytes - 1;
> @@ -865,8 +867,19 @@ void btrfs_start_ordered_extent(struct btrfs_ordered=
_extent *entry)
>          * start IO on any dirty ones so the wait doesn't stall waiting
>          * for the flusher thread to find them
>          */
> -       if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
> -               filemap_fdatawrite_range(inode->vfs_inode.i_mapping, star=
t, end);
> +       if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags)) {
> +               if (!nowriteback_len) {
> +                       filemap_fdatawrite_range(inode->vfs_inode.i_mappi=
ng, start, end);
> +               } else {
> +                       if (start < nowriteback_start)
> +                               filemap_fdatawrite_range(inode->vfs_inode=
.i_mapping, start,
> +                                               nowriteback_start - 1);
> +                       if (nowriteback_start + nowriteback_len < end)
> +                               filemap_fdatawrite_range(inode->vfs_inode=
.i_mapping,
> +                                               nowriteback_start + nowri=
teback_len,
> +                                               end);
> +               }
> +       }
>
>         if (!freespace_inode)
>                 btrfs_might_wait_for_event(inode->root->fs_info, btrfs_or=
dered_extent);
> @@ -921,7 +934,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *inod=
e, u64 start, u64 len)
>                         btrfs_put_ordered_extent(ordered);
>                         break;
>                 }
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, 0, 0);
>                 end =3D ordered->file_offset;
>                 /*
>                  * If the ordered extent had an error save the error but =
don't
> @@ -1174,7 +1187,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrf=
s_inode *inode, u64 start,
>                         break;
>                 }
>                 unlock_extent(&inode->io_tree, start, end, cachedp);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, 0, 0);
>                 btrfs_put_ordered_extent(ordered);
>         }
>  }
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index be36083297a7..5e17f03d43c9 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -192,7 +192,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_exten=
t *entry,
>                            struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_in=
ode *inode,
>                                                          u64 file_offset)=
;
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
> +                               u64 nowriteback_start, u32 nowriteback_le=
n);
>  int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 l=
en);
>  struct btrfs_ordered_extent *
>  btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_of=
fset);
> --
> 2.48.1
>
>

