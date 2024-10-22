Return-Path: <linux-btrfs+bounces-9063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC689AA134
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 13:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5BB1F24553
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5719B3E2;
	Tue, 22 Oct 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwgfA2rD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7D18859B
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596878; cv=none; b=g9S0x5o4+elt5D76qGJ+Ku1l6ErzCCSqgcHljsdsNKtMdwxNpqSUhVdeXmM8EohQYJFERvoCAMgR0Gk15ORqJBgnvrrBD6vZIjnJp/YUxoQKh31R8FKpqTgGxzp024QTucK6KjBDH13CjtQgDir++0KQ0d+vK1oDWzbbc22OCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596878; c=relaxed/simple;
	bh=0QoB7VIjNFJtqZtn73960oUmA+NC3F4gyguUsaHSsWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwRXIPHmwDENdVkrs8NESc/yXTsRQocsa7k6HxVr0genBUgtVgnHwjRF1wrgA6GVmXBKdAYYSwfbA29Q41GQQIvIx3lOzk6GqXbHL2edpLu9lBNLG+TqR/+Va/b3oFvfri2OcWpF6U6x4Ioh8VMdDwdSpvYJ3IQk+KBiwU4x1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwgfA2rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B0C4CEC3
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729596877;
	bh=0QoB7VIjNFJtqZtn73960oUmA+NC3F4gyguUsaHSsWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CwgfA2rDer1eGNzTKNOa7J0I0WJgylAhdxRkYMt0y6tAvCf8vNWEcDi7VOQuBBB2i
	 XAnf/7jOe/A7eNu3RtASX4/CNnSyftd5WccTo9gt3VpTa8Gy3QoWt2vGlAEdcZXUOW
	 VAfviVHmAjV/uYbUBkIhwos+er9ZIIMSR32TshJIijn/eGbCP2jhDIjoin/czvM2aA
	 6LYfySlLOUldCCZ6BCPtHRPQ280xjd8Q+tkTCZMrVsZ4gHOgD/+3t5RdQ548OW8pmA
	 oxjipVIqYhUIM56VngCshhN3FZmSVtZ9PchlP5hbSNSo9XRz6fcnRHCOpItVzIQQsD
	 EvmYvevwC5IHg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so7327829e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 04:34:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YyrFIDeaxUIOqaOEHjP1VKl8SD/I2uyzUViQtCfBa0xZZBSPinw
	LglstI//wUEVoOHWKEfvYnox9ouS32bygJK+bP0P1B9EvvloYoXhDMQJjT2LrRo2fM30Y29lwVi
	HR3SdDZnvz//JbuI7Zp2dv3eGIE4=
X-Google-Smtp-Source: AGHT+IERKAi7VSgRLFKjfZt+kle7IoJlTzuCBNiOq8l6823KI+utwCSXpphgknoSWgjs+V25F6scw3arj0AoDb1O0Is=
X-Received: by 2002:a05:6512:3d94:b0:539:a3cd:97ca with SMTP id
 2adb3069b0e04-53a152380a1mr7191599e87.36.1729596875436; Tue, 22 Oct 2024
 04:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68342f70406107c376dc8e3b1a6cd67a7e9a6b3e.1729392197.git.wqu@suse.com>
In-Reply-To: <68342f70406107c376dc8e3b1a6cd67a7e9a6b3e.1729392197.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Oct 2024 12:33:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4TeBx=QGXKsHBB_HWShCL+YYpbJBEmHBbOazYzBDuuHQ@mail.gmail.com>
Message-ID: <CAL3q7H4TeBx=QGXKsHBB_HWShCL+YYpbJBEmHBbOazYzBDuuHQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid deadlock when reading a partial uptodate folio
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 3:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If the sector size is smaller than page size, and we allow btrfs to
> avoid reading the full page as long as the buffered write range is

as long as -> because

Otherwise it's confusing.

> sector aligned, we can hit a hang with generic/095 runs:
>
>   __switch_to+0xf8/0x168
>   __schedule+0x328/0x8a8
>   schedule+0x54/0x140
>   io_schedule+0x44/0x68
>   folio_wait_bit_common+0x198/0x3f8
>   __folio_lock+0x24/0x40
>   extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
>   btrfs_writepages+0x94/0x158 [btrfs]
>   do_writepages+0x74/0x190
>   filemap_fdatawrite_wbc+0x88/0xc8
>   __filemap_fdatawrite_range+0x6c/0xa8
>   filemap_fdatawrite_range+0x1c/0x30
>   btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
>   btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
>   __get_extent_map+0xa0/0x220 [btrfs]
>   btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
>   btrfs_read_folio+0x50/0xa0 [btrfs]
>   filemap_read_folio+0x54/0x110
>   filemap_update_page+0x2e0/0x3b8
>   filemap_get_pages+0x228/0x4d8
>   filemap_read+0x11c/0x3b8
>   btrfs_file_read_iter+0x74/0x90 [btrfs]
>   new_sync_read+0xd0/0x1d0
>   vfs_read+0x1a0/0x1f0
>
> [CAUSE]
> The above call trace shows that, during the folio read a writeback is
> triggered on the same folio.
> And since during btrfs_do_readpage(), the folio is locked, the writeback
> will never be able to get the folio, thus it is waiting on itself thus
> causing the deadlock.

get the folio -> lock the folio

>
> The root cause is a little complex, the system is 64K page sized, with
> 4K sector size:
>
> 1) The folio has its range [48K, 64K) marked dirty by buffered write
>
>    0          16K         32K          48K         64K
>    |                                   |///////////|
>                                              \- sector Uptodate|Dirty
>
> 2) Writeback finished for [48K, 64K), but ordered extent not yet finished
>
>    0          16K         32K          48K         64K
>    |                                   |///////////|
>                                              \- sector Uptodate
>                                                 extent map PINNED
>                                                 OE still here
>
> 3) Direct IO tries to drop the folio

Drop the folio - what do you mean? Dropping the pages from the page cache?
That is, the call to kiocb_invalidate_pages() from
fs/iomap/direct-io.c:__iomap_dio_rw()?

For such things can you please mention the names of the functions
involved in order to remove any ambiguities or confusions?

>    Since there is no locked extent map, btrfs allows the folio to be

Locked extent map? What do you mean?
We don't have locks on the extent maps themselves.

I suppose you mean we don't have the file range locked in the inode's
io_tree (EXTENT_LOCKED bit), which we
check at extent_io.c:try_release_extent_state(), and that it is
triggered through the btrfs_release_folio() callback
when the iomap code attempts do invalidate the pages from the page
cache with that function mentioned above.

Please mention all these details, they are important to make it clear.

>    released. Now no sector in the folio has uptodate flag.
>    But extent map and OE are still here.
>
>    0          16K         32K          48K         64K
>    |                                   |///////////|
>                                              \- extent map PINNED
>                                                 OE still here
>
> 4) Buffered write dirtied range [0, 16K)
>    Since it's sector aligned, btrfs didn't read the full folio from disk.
>
>    0          16K         32K          48K         64K
>    |//////////|                        |///////////|
>        \- sector Uptodate|Dirty              \- extent map PINNED
>                                                 OE still here
>
> 5) Read on the folio is triggered
>    For the range [0, 16), since it's already uptodate, btrfs skip this

16 -> 16K
skip -> skips

>    range.
>    For the range [16K, 48K), btrfs submit the read from disk.
>
>    The problem comes to the range [48K, 64K), the following call chain

to the range -> for the range

>    happens:
>
>    btrfs_do_readpage()
>    \- __get_extent_map()
>     \- btrfs_lock_and_flush_ordered_range()
>      \- btrfs_start_ordered_extent()
>       \- filemap_fdatawrite_range()
>
>    Since the folio indeed has dirty sectors in range [0, 16K), the range
>    will be written back.
>
>    But the folio is already locked by the folio read, the writeback
>    will never be able to lock the folio, thus lead to the deadlock.
>
> This sequence can only happen if all the following conditions are met:
>
> - The sector size is smaller than page size

Missing punctuation at the end of the sentence, since bellow we start
a new phrase that ends with punctuation.

>   Or we won't have mixed dirty blocks in the same folio we're reading.
>
> - We allow the buffered write to skip the folio read if it's sector
>   aligned

Same here.

>   This is the incoming new optimization for sector size < page size to
>   pass generic/563.

Ok, so I'm confused after reading this.
Does it mean that this deadlock only happens with that optimization
introduced in btrfs? That it's a patch not yet in for-next?

If that's the case please make the changelog more explicit, saying
this deadlock only happens after the patch (or patches) introducing
that
optimization are merged.

>
>   Or the folio will be fully read from the disk, before marking it
>   dirty.
>   Thus will not trigger the deadlock.

Ok so this reinforces the idea that the issue only happens after that
optimization that is not yet merged.
However I'm not sure.

>
> [FIX]
> - Only lookup for the extent map of the next sector to read
>   To avoid touching ranges that can be skipped by per-sector uptodate
>   flag.

What do you mean by touching ranges?
The extent map lookup at btrfs_do_readpage() uses the extent map for
reading only.

I'm not seeing why at btrfs_do_readpage() we have now to specify a
length of blocksize
instead of "end - cur + 1". If an existing map exists for that range
with an end offset beyond "start + blocksize - 1",
we'll get the extent map with that end offset (length) unchanged.

>
> - Break the step 5) of the above case

End with .

>   By passing an optional @locked_folio into btrfs_start_ordered_extent()
>   and btrfs_lock_and_flush_ordered_range().
>   If we got such locked folio, do extra asserts to make sure the target
>   range is already not dirty, then skip writeback for ranges of that
>   folio.
>
>   So far only the call site inside __get_extent_map() is passing the new
>   parameter.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> RFC->v1:
> - Go with extra @locked_folio parameter for btrfs_start_ordered_extent()
>   This is more straightforward compared to skipping folio releasing.
>   This also solves some painful slowdown of other test cases.
> ---
>  fs/btrfs/defrag.c       |  2 +-
>  fs/btrfs/direct-io.c    |  2 +-
>  fs/btrfs/extent_io.c    |  5 +--
>  fs/btrfs/file.c         |  8 ++---
>  fs/btrfs/inode.c        |  6 ++--
>  fs/btrfs/ordered-data.c | 69 ++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/ordered-data.h |  8 +++--
>  7 files changed, 78 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 1644470b9df7..2467990d6ac7 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -902,7 +902,7 @@ static struct folio *defrag_prepare_one_folio(struct =
btrfs_inode *inode, pgoff_t
>                         break;
>
>                 folio_unlock(folio);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, NULL);
>                 btrfs_put_ordered_extent(ordered);
>                 folio_lock(folio);
>                 /*
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index a7c3e221378d..2fb02aa19be0 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -103,7 +103,7 @@ static int lock_extent_direct(struct inode *inode, u6=
4 lockstart, u64 lockend,
>                          */
>                         if (writing ||
>                             test_bit(BTRFS_ORDERED_DIRECT, &ordered->flag=
s))
> -                               btrfs_start_ordered_extent(ordered);
> +                               btrfs_start_ordered_extent(ordered, NULL)=
;
>                         else
>                                 ret =3D nowait ? -EAGAIN : -ENOTBLK;
>                         btrfs_put_ordered_extent(ordered);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7680dd94fddf..765ec965b882 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -922,7 +922,8 @@ static struct extent_map *__get_extent_map(struct ino=
de *inode,
>                 *em_cached =3D NULL;
>         }
>
> -       btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start +=
 len - 1, &cached_state);
> +       btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), folio, start,
> +                                          start + len - 1, &cached_state=
);
>         em =3D btrfs_get_extent(BTRFS_I(inode), folio, start, len);
>         if (!IS_ERR(em)) {
>                 BUG_ON(*em_cached);
> @@ -986,7 +987,7 @@ static int btrfs_do_readpage(struct folio *folio, str=
uct extent_map **em_cached,
>                         end_folio_read(folio, true, cur, blocksize);
>                         continue;
>                 }
> -               em =3D __get_extent_map(inode, folio, cur, end - cur + 1,
> +               em =3D __get_extent_map(inode, folio, cur, blocksize,

So this is the part I don't understand why it makes any difference.

>                                       em_cached);

If this is indeed necessary, it's a good opportunity to make this more
readable by putting the function call into a single line, since it's
below 80 characters.

>                 if (IS_ERR(em)) {
>                         end_folio_read(folio, false, cur, end + 1 - cur);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 676eddc9daaf..7521fbefa9fd 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -987,7 +987,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *i=
node, struct folio *folio,
>                                       cached_state);
>                         folio_unlock(folio);
>                         folio_put(folio);
> -                       btrfs_start_ordered_extent(ordered);
> +                       btrfs_start_ordered_extent(ordered, NULL);
>                         btrfs_put_ordered_extent(ordered);
>                         return -EAGAIN;
>                 }
> @@ -1055,8 +1055,8 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inod=
e, loff_t pos,
>                         return -EAGAIN;
>                 }
>         } else {
> -               btrfs_lock_and_flush_ordered_range(inode, lockstart, lock=
end,
> -                                                  &cached_state);
> +               btrfs_lock_and_flush_ordered_range(inode, NULL, lockstart=
,
> +                                                  lockend, &cached_state=
);
>         }
>         ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes=
,
>                                NULL, nowait, false);
> @@ -1895,7 +1895,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_faul=
t *vmf)
>                 unlock_extent(io_tree, page_start, page_end, &cached_stat=
e);
>                 folio_unlock(folio);
>                 up_read(&BTRFS_I(inode)->i_mmap_lock);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, NULL);
>                 btrfs_put_ordered_extent(ordered);
>                 goto again;
>         }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a21701571cbb..56bd33cf864b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2773,7 +2773,7 @@ static void btrfs_writepage_fixup_worker(struct btr=
fs_work *work)
>                 unlock_extent(&inode->io_tree, page_start, page_end,
>                               &cached_state);
>                 folio_unlock(folio);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, NULL);
>                 btrfs_put_ordered_extent(ordered);
>                 goto again;
>         }
> @@ -4783,7 +4783,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode,=
 loff_t from, loff_t len,
>                 unlock_extent(io_tree, block_start, block_end, &cached_st=
ate);
>                 folio_unlock(folio);
>                 folio_put(folio);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, NULL);
>                 btrfs_put_ordered_extent(ordered);
>                 goto again;
>         }
> @@ -4918,7 +4918,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>         if (size <=3D hole_start)
>                 return 0;
>
> -       btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end -=
 1,
> +       btrfs_lock_and_flush_ordered_range(inode, NULL, hole_start, block=
_end - 1,
>                                            &cached_state);
>         cur_offset =3D hole_start;
>         while (1) {
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 2104d60c2161..29434fab8a06 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct btrf=
s_work *work)
>         struct btrfs_ordered_extent *ordered;
>
>         ordered =3D container_of(work, struct btrfs_ordered_extent, flush=
_work);
> -       btrfs_start_ordered_extent(ordered);
> +       btrfs_start_ordered_extent(ordered, NULL);
>         complete(&ordered->completion);
>  }
>
> @@ -845,12 +845,16 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info =
*fs_info, u64 nr,
>   * Wait on page writeback for all the pages in the extent and the IO com=
pletion
>   * code to insert metadata into the btree corresponding to the extent.
>   */
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
> +                               struct folio *locked_folio)
>  {
>         u64 start =3D entry->file_offset;
>         u64 end =3D start + entry->num_bytes - 1;
>         struct btrfs_inode *inode =3D entry->inode;
> +       u64 skip_start;
> +       u64 skip_end;

These can be declared instead in the if statement's block below.

>         bool freespace_inode;
> +       bool skip_writeback =3D false;
>
>         trace_btrfs_ordered_extent_start(inode, entry);
>
> @@ -860,13 +864,59 @@ void btrfs_start_ordered_extent(struct btrfs_ordere=
d_extent *entry)
>          */
>         freespace_inode =3D btrfs_is_free_space_inode(inode);
>
> +       /*
> +        * The locked folio covers the ordered extent range and the full
> +        * folio is dirty.
> +        * We can not trigger writeback on it, as we will try to lock
> +        * the same folio we already hold.
> +        *
> +        * This only happens for sector size < page size case, and even
> +        * that happens we're still safe because this can only happen
> +        * when the range is submitted and finished, but OE is not yet
> +        * finished.
> +        */
> +       if (locked_folio) {
> +               skip_start =3D max_t(u64, folio_pos(locked_folio), start)=
;
> +               skip_end =3D min_t(u64,
> +                               folio_pos(locked_folio) + folio_size(lock=
ed_folio),
> +                               end + 1) - 1;

The variables aren't used outside this scope, so they can be declared
here and made const too.

> +
> +               ASSERT(folio_test_locked(locked_folio));
> +
> +               /* The folio should intersect with the OE range. */
> +               ASSERT(folio_pos(locked_folio) <=3D end ||
> +                      folio_pos(locked_folio) + folio_size(locked_folio)=
 > start);
> +
> +               /*
> +                * The range must not be dirty.  The range can be submitt=
ed (writeback)
> +                * or submitted and finished, then the whole folio releas=
ed (no flag).
> +                *
> +                * If the folio range is dirty, we will deadlock since th=
e OE will never
> +                * be able to finish.

Why?
Isn't the problem that we deadlock on the folio lock when starting
writeback because we have already locked it before in case we are in a
read path?

So I don't see what's the relation of the deadlock with OE completion.
Especially because btrfs_lock_and_flush_ordered_range() unlocks the
extent range in the inode's io_tree before calling
btrfs_start_ordered_extent().


> +                */
> +               btrfs_folio_assert_not_dirty(inode->root->fs_info, locked=
_folio,
> +                                            skip_start, skip_end  + 1 - =
skip_start);
> +               skip_writeback =3D true;

Since this is only expected for the subpage scenario, maybe make it
explicit that we only expect a non-NULL folio if we are a subpage fs
(add an assert or something).

> +       }
>         /*
>          * pages in the range can be dirty, clean or writeback.  We
>          * start IO on any dirty ones so the wait doesn't stall waiting
>          * for the flusher thread to find them
>          */
> -       if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
> -               filemap_fdatawrite_range(inode->vfs_inode.i_mapping, star=
t, end);
> +       if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags)) {
> +               if (!skip_writeback)
> +                       filemap_fdatawrite_range(inode->vfs_inode.i_mappi=
ng, start, end);
> +               else {

Please put the if branch with { } as well.

> +                       /* Need to skip the locked folio range. */
> +                       if (start < folio_pos(locked_folio))
> +                               filemap_fdatawrite_range(inode->vfs_inode=
.i_mapping,
> +                                               start, folio_pos(locked_f=
olio) - 1);
> +                       if (end + 1 > folio_pos(locked_folio) + folio_siz=
e(locked_folio))
> +                               filemap_fdatawrite_range(inode->vfs_inode=
.i_mapping,
> +                                               folio_pos(locked_folio) +=
 folio_size(locked_folio),
> +                                               end);
> +               }
> +       }
>
>         if (!freespace_inode)
>                 btrfs_might_wait_for_event(inode->root->fs_info, btrfs_or=
dered_extent);
> @@ -921,7 +971,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *inod=
e, u64 start, u64 len)
>                         btrfs_put_ordered_extent(ordered);
>                         break;
>                 }
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, NULL);
>                 end =3D ordered->file_offset;
>                 /*
>                  * If the ordered extent had an error save the error but =
don't
> @@ -1141,6 +1191,8 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ord=
ered_range(
>   * @inode:        Inode whose ordered tree is to be searched
>   * @start:        Beginning of range to flush
>   * @end:          Last byte of range to lock
> + * @locked_folio: If passed, will not start writeback to avoid locking t=
he same
> + *               folio already locked by the caller.

Doesn't match what happens - writeback is started except for the range
covered by the folio - that is, we do it for any range not covered by
the folio.

Everything else looks good to me.

Thanks.

>   * @cached_state: If passed, will return the extent state responsible fo=
r the
>   *                locked range. It's the caller's responsibility to free=
 the
>   *                cached state.
> @@ -1148,8 +1200,9 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ord=
ered_range(
>   * Always return with the given range locked, ensuring after it's called=
 no
>   * order extent can be pending.
>   */
> -void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 s=
tart,
> -                                       u64 end,
> +void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode,
> +                                       struct folio *locked_folio,
> +                                       u64 start, u64 end,
>                                         struct extent_state **cached_stat=
e)
>  {
>         struct btrfs_ordered_extent *ordered;
> @@ -1174,7 +1227,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrf=
s_inode *inode, u64 start,
>                         break;
>                 }
>                 unlock_extent(&inode->io_tree, start, end, cachedp);
> -               btrfs_start_ordered_extent(ordered);
> +               btrfs_start_ordered_extent(ordered, locked_folio);
>                 btrfs_put_ordered_extent(ordered);
>         }
>  }
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 4e152736d06c..a4bb24572c73 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -191,7 +191,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_exten=
t *entry,
>                            struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_in=
ode *inode,
>                                                          u64 file_offset)=
;
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
> +                               struct folio *locked_folio);
>  int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 l=
en);
>  struct btrfs_ordered_extent *
>  btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_of=
fset);
> @@ -207,8 +208,9 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *roo=
t, u64 nr,
>                                const struct btrfs_block_group *bg);
>  void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
>                               const struct btrfs_block_group *bg);
> -void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 s=
tart,
> -                                       u64 end,
> +void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode,
> +                                       struct folio *locked_folio,
> +                                       u64 start, u64 end,
>                                         struct extent_state **cached_stat=
e);
>  bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, =
u64 end,
>                                   struct extent_state **cached_state);
> --
> 2.47.0
>
>

