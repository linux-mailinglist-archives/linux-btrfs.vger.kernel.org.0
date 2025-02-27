Return-Path: <linux-btrfs+bounces-11905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DDBA47E31
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 13:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B913ACE17
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB222CBF5;
	Thu, 27 Feb 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5Fyvudy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73921DFFC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660472; cv=none; b=RQuKUbLveMmxhpEQr5mh9gVR0Td8RbXsnFA7IIy0kvppJzPFfR3ppJIxLfNM/h0ewTwOUOuGm8SVlc3aG7ds/K0CDOIsha0TASnKALoA2ZLKmvXaDn2NRqOxK86DEPoHUVTgnHd5YGRu021ec8CE23+HU8ePTtQPUDsy8rnwiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660472; c=relaxed/simple;
	bh=Bf+z1pAYdxK5+7pof99LS+2L0jVIQr4eLnvWT19zMlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnVywFKqfvUW017900kjj4ruvls/xE1mp0ShPMo0LBItjyiQ8SBdUU6MbiR5vzwipwHfUpuUzoW8u3OSNByB8HxA8poN7NfCUlYqrps0tIfOIo6GdEsnss/rkCl4mbBP2GBOW/bZFBkFt+UaF6f5lu8e4/s/8qthrOuYNMRboaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5Fyvudy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F502C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740660472;
	bh=Bf+z1pAYdxK5+7pof99LS+2L0jVIQr4eLnvWT19zMlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X5Fyvudy45qQX52pLki3UppiGAy/Sbrb7SfRpkR3koFqdbQ3OsGr2h+YYLPma+RS/
	 nN6VwMzPgS6cHNJZ/659DrH5bZ9rIkXPrRz16REUHf1xhk1QcehX/R+dlilVfovhHG
	 umebEUkNC1q+FWJLuNUv/vXxricw88PobZeTMH+1DgEEstpUv9Q07SS5F2u82anPg3
	 OQYAQ3FvyJIOSXk5NcUNfqOZ1tdA4cOJBGYc7/tBCGGsP0/fvHcwn789NFNjM5yL34
	 b+qAxAOeo+5EyO6F9hOZ9Z1UZ907OurnNrXeBtuAL++AwmGvle/36CE5NSD8uoB1D6
	 KcSmKkhtkiRKQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb8045c3f3so117561266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 04:47:52 -0800 (PST)
X-Gm-Message-State: AOJu0YwxZMHaB9rbBdialIK5IOKqPl3bgpqu/AcdqN1IS8r/1BVfqTBb
	H0AarIZGkTpHZyBwlaT4aLfsJ3855ZfoOCHb0h0PqrRTcxjJUWypDMVjUrldAwZDOcy/k+doRqO
	+EkvyLNcsvvffuCVGJQgq6DSSEP0=
X-Google-Smtp-Source: AGHT+IFOzk3CPXZp+FRoA5PQfLzcWjBr2s/0rOtnMB8frmOAo+AYlOzSysF1TsCZc+DM51WZIfUCOqDfzznuQquJOFI=
X-Received: by 2002:a17:907:8692:b0:abf:546:48b1 with SMTP id
 a640c23a62f3a-abf05464a24mr560813766b.46.1740660470544; Thu, 27 Feb 2025
 04:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740635497.git.wqu@suse.com> <23403ec45842cb921d15de83e446a9168bca9495.1740635497.git.wqu@suse.com>
In-Reply-To: <23403ec45842cb921d15de83e446a9168bca9495.1740635497.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Feb 2025 12:47:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6MOo82zmhYr9Zbkb4qVCD8HO+c4P1FYhNQ-1-JCnV1Zg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp4wic1eiYnYLbgLRpPiZjwCGWtHk9pcVsLpB-k6DbyCU0MatSHALa5KHo
Message-ID: <CAL3q7H6MOo82zmhYr9Zbkb4qVCD8HO+c4P1FYhNQ-1-JCnV1Zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] btrfs: introduce a read path dedicated extent lock helper
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:56=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently we're using btrfs_lock_and_flush_ordered_range() for both
> btrfs_read_folio() and btrfs_readahead(), but it has one critical
> problem for future subpage optimizations:
>
> - It will call btrfs_start_ordered_extent() to writeback the involved
>   folios
>
>   But remember we're calling btrfs_lock_and_flush_ordered_range() at
>   read paths, meaning the folio is already locked by read path.
>
>   If we really trigger writeback for those already locked folios, this
>   will lead to a deadlock and writeback can not get the folio lock.
>
>   Such dead lock is prevented by the fact that btrfs always keeps a
>   dirty folio also uptodate, by either dirtying all blocks of the folio,
>   or read the whole folio before dirtying.
>
> To prepare for the incoming patch which allows btrfs to skip full folio
> read if the buffered write is block aligned, we have to start by solving
> the possible deadlock first.
>
> Instead of blindly calling btrfs_start_ordered_extent(), introduce a
> newer helper, which is smarter in the following ways:
>
> - Only wait and flush the ordered extent if
>   * The folio doesn't even have private set
>   * Part of the blocks of the ordered extent are not uptodate
>
>   This can happen by:
>   * The folio writeback finished, then get invalidated.
>     There are a lot of reason that a folio can get invalidated,
>     from memory pressure to direct IO (which invalidates all folios
>     of the range).
>     But OE not yet finished
>
>   We have to wait for the ordered extent, as the OE may contain
>   to-be-inserted data checksum.
>   Without waiting, our read can fail due to the missing csum.
>
>   But either way, the OE should not need any extra flush inside the
>   locked folio range.
>
> - Skip the ordered extent completely if
>   * All the blocks are dirty
>     This happens when OE creation is caused by a folio writeback whose
>     file offset is before our folio.
>
>     E.g. 16K page size and 4K block size
>
>     0      8K      16K      24K     32K
>     |//////////////||///////|       |
>
>     The writeback of folio 0 created an OE for range [0, 24K), but since
>     folio 16K is not fully uptodate, a read is triggered for folio 16K.
>
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
>  0     4K      8K     12K      16K      20K      24K     28K      32K
>  |/////////////////////////////||////////////////|       |        |
>  |<-------------------- OE 2 ------------------->|       |< OE 1 >|
>
>  The folio has been written back before, thus we have an OE at
>  [28K, 32K).
>  Although the OE 1 finished its IO, the OE is not yet removed from IO
>  tree.
>  The folio got invalidated after writeback completed and before the
>  ordered extent finished.
>
>  And [16K, 24K) range is dirty and uptodate, caused by a block aligned
>  buffered write (and future enhancements allowing btrfs to skip full
>  folio read for such case).
>  But writeback for folio 0 has began, thus it generated OE 2, covering
>  range [0, 24K).
>
>  Since the full folio 16K is not uptodate, if we want to read the folio,
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
>  fs/btrfs/extent_io.c    | 187 +++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/ordered-data.c |  23 +++--
>  fs/btrfs/ordered-data.h |   8 +-
>  3 files changed, 210 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7b0aa332aedc..3968ecbb727d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1081,6 +1081,189 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
>         return 0;
>  }
>
> +/*
> + * Check if we can skip waiting the @ordered extent covering the block
> + * at @fileoff.
> + *
> + * @fileoff:   Both input and output.
> + *             Input as the file offset where the check should start at.
> + *             Output as where the next check should start at,
> + *             if the function returns true.
> + *
> + * Return true if we can skip to @fileoff. The caller needs to check
> + * the new @fileoff value to make sure it covers the full range, before
> + * skipping the full OE.
> + *
> + * Return false if we must wait for the ordered extent.
> + */
> +static bool can_skip_one_ordered_range(struct btrfs_inode *inode,
> +                                      struct btrfs_ordered_extent *order=
ed,
> +                                      u64 *fileoff)
> +{
> +       const struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +       struct folio *folio;
> +       const u32 blocksize =3D fs_info->sectorsize;
> +       u64 cur =3D *fileoff;
> +       bool ret;
> +
> +       folio =3D filemap_get_folio(inode->vfs_inode.i_mapping,
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
> +        * 1) Folio has no private flag
> +        *    The OE has all its IO done but not yet finished, and folio =
got
> +        *    invalidated.
> +        *
> +        * Have to wait for the OE to finish, as it may contain the
> +        * to-be-inserted data checksum.
> +        * Without the data checksum inserted into the csum tree, read
> +        * will just fail with missing csum.
> +        */
> +       if (!folio_test_private(folio)) {
> +               ret =3D false;
> +               goto out;
> +       }
> +
> +       /*
> +        * 2) The first block is DIRTY.
> +        *
> +        * This means the OE is created by some other folios whose file p=
os is
> +        * before us. And since we are holding the folio lock, the writeb=
ack of
> +        * this folio can not start.
> +        *
> +        * We must skip the whole OE, because it will never start until
> +        * we finished our folio read and unlocked the folio.
> +        */
> +       if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
> +               u64 range_len =3D min(folio_pos(folio) + folio_size(folio=
),
> +                                   ordered->file_offset + ordered->num_b=
ytes) - cur;
> +
> +               ret =3D true;
> +               /*
> +                * At least inside the folio, all the remaining blocks sh=
ould
> +                * also be dirty.
> +                */
> +               ASSERT(btrfs_folio_test_dirty(fs_info, folio, cur, range_=
len));
> +               *fileoff =3D ordered->file_offset + ordered->num_bytes;
> +               goto out;
> +       }
> +
> +       /*
> +        * 3) The first block is uptodate.
> +        *
> +        * At least the first block can be skipped, but we are still
> +        * not fully sure. E.g. if the OE has some other folios in
> +        * the range that can not be skipped.
> +        * So we return true and update @next_ret to the OE/folio boundar=
y.
> +        */
> +       if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
> +               u64 range_len =3D min(folio_pos(folio) + folio_size(folio=
),
> +                                   ordered->file_offset + ordered->num_b=
ytes) - cur;
> +
> +               /*
> +                * The whole range to the OE end or folio boundary should=
 also
> +                * be uptodate.
> +                */
> +               ASSERT(btrfs_folio_test_uptodate(fs_info, folio, cur, ran=
ge_len));
> +               ret =3D true;
> +               *fileoff =3D cur + range_len;
> +               goto out;
> +       }
> +
> +       /*
> +        * 4) The first block is not uptodate.
> +        *
> +        * This means the folio is invalidated after the writeback is fin=
ished,
> +        * but by some other operations (e.g. block aligned buffered writ=
e) the
> +        * folio is inserted into filemap.
> +        * Very much the same as case 1).
> +        */
> +       ret =3D false;
> +out:
> +       folio_put(folio);
> +       return ret;
> +}
> +
> +static bool can_skip_ordered_extent(struct btrfs_inode *inode,
> +                                   struct btrfs_ordered_extent *ordered,
> +                                   u64 start, u64 end)
> +{
> +       const u64 range_end =3D min(end, ordered->file_offset + ordered->=
num_bytes - 1);
> +       u64 cur =3D max(start, ordered->file_offset);
> +
> +       while (cur < range_end) {
> +               bool can_skip;
> +
> +               can_skip =3D can_skip_one_ordered_range(inode, ordered, &=
cur);
> +               if (!can_skip)
> +                       return false;
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
> +static void lock_extents_for_read(struct btrfs_inode *inode, u64 start, =
u64 end,
> +                                 struct extent_state **cached_state)
> +{
> +       u64 cur_pos;
> +
> +       /* Caller must provide a valid @cached_state. */
> +       ASSERT(cached_state);
> +
> +       /*
> +        * The range must at least be page aligned, as all read paths
> +        * are folio based.
> +        */
> +       ASSERT(IS_ALIGNED(start, PAGE_SIZE));
> +       ASSERT(IS_ALIGNED(end + 1, PAGE_SIZE));
> +
> +again:
> +       lock_extent(&inode->io_tree, start, end, cached_state);
> +       cur_pos =3D start;
> +       while (cur_pos < end) {
> +               struct btrfs_ordered_extent *ordered;
> +
> +               ordered =3D btrfs_lookup_ordered_range(inode, cur_pos,
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
> +               if (can_skip_ordered_extent(inode, ordered, start, end)) =
{
> +                       cur_pos =3D min(ordered->file_offset + ordered->n=
um_bytes,
> +                                     end + 1);
> +                       btrfs_put_ordered_extent(ordered);
> +                       continue;
> +               }
> +
> +               /* Now wait for the OE to finish. */
> +               unlock_extent(&inode->io_tree, start, end,
> +                             cached_state);

Btw, this fits all in one line, making things more readable.
Can be done when committed to for-next.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> +               btrfs_start_ordered_extent_nowriteback(ordered, start, en=
d + 1 - start);
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
> @@ -1091,7 +1274,7 @@ int btrfs_read_folio(struct file *file, struct foli=
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
> @@ -2380,7 +2563,7 @@ void btrfs_readahead(struct readahead_control *rac)
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
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4aca7475fd82..fd33217e4b27 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
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
> +void btrfs_start_ordered_extent_nowriteback(struct btrfs_ordered_extent =
*entry,
> +                                           u64 nowriteback_start, u32 no=
writeback_len)
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
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index be36083297a7..1e6b0b182b29 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -192,7 +192,13 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_exte=
nt *entry,
>                            struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_in=
ode *inode,
>                                                          u64 file_offset)=
;
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
> +void btrfs_start_ordered_extent_nowriteback(struct btrfs_ordered_extent =
*entry,
> +                               u64 nowriteback_start, u32 nowriteback_le=
n);
> +static inline void btrfs_start_ordered_extent(struct btrfs_ordered_exten=
t *entry)
> +{
> +       return btrfs_start_ordered_extent_nowriteback(entry, 0, 0);
> +}
> +
>  int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 l=
en);
>  struct btrfs_ordered_extent *
>  btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_of=
fset);
> --
> 2.48.1
>
>

