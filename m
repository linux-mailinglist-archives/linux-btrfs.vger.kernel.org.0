Return-Path: <linux-btrfs+bounces-12994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAEA885A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3CE7A35DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D442522A0;
	Mon, 14 Apr 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f19ZiU8M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E85252291
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641532; cv=none; b=cfbuwiu2so9/zAGEHAYHBleuM4wS0Tcgj67t2riOZaaJc/hObJVg2QJ+6Yhj1iiWIE5Ff+n8SMzrAEiHYYTs5XgdaWCY6vUcoe1oL0iQNvvaek5uV/4FWjMURYAYmRXRX7I4n78iR5qm9mZ4VdsgJFKFNg2eUYVrhi7GG+XzHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641532; c=relaxed/simple;
	bh=yvoZLy97hEKcgZb84FRMr/U8a7RQded+RpLqHOeG0Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4n3KvLpZ0exUMAOg68ix3nd6L4nnCWB4JvpZHfkxbDyKA6GFOJxh/Yt6QQZL2R/3CLGRNEDkFGYrKdvRlh7ncUwrqwyTCxlpXvaU6OSHdHFccGWx2RkCxcZ5E4wchPh64M9Yt1O7gfjz9KRMNjdT/QTmYl+/CMK1y1f5fh8Vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f19ZiU8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5831BC4CEE9
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641531;
	bh=yvoZLy97hEKcgZb84FRMr/U8a7RQded+RpLqHOeG0Cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f19ZiU8Myh3jmaGIBCB7H8E/q8nS9yeUC3Ypp1eLRVdVvPYW2ZpAq8mBTTBAlbkz/
	 jwg4bmIGDADh/J5pHxxu9X++z3NeBnzc65eYi2U8n1dQ2PFi3Fhn3WHpdbEm5jMm3d
	 AbMGIuIzKNUB0Sx1/nN0bEMwXSEAKZBMmXClAmDGBCG5yy0zvsCIRKpih6HMMSE5Am
	 iDlKVtsdsxRS2a8aigifYKgHOJjMxO/6iPpZgcgiXOAtOAQ4zAOJ8cIsHZyv4jFaog
	 CPyBVMdhU8Zage2whkRkwq0g0ZbgVmvw55NudXAMOA0Zy8oa7jAU1Xfm4dzBCcvWoj
	 YjbSBDjaHya7w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2963dc379so731433866b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:38:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOSlk1CpvDV6pmFF+iGi4HcRPbHwhuztwzEc46TvwsYBWLAUEg
	sOdEgFA6ticWqX8pGtZYLWmb3+Us0dvLu+QdbrHEjPFI+39X1ZzM/UUdAK6lK7MlFB/A2wusGAO
	5Optg6rbMh/50iNWZR/89zmeJeOY=
X-Google-Smtp-Source: AGHT+IE4HJtRr4nStZU1y9MlvaCwcdDhthJolf6IwVXeS4uX1Ca6PXp/Nm6HVImnA9Y20kNDoRUd8kD3i3uaADgtkXA=
X-Received: by 2002:a17:907:3ea7:b0:ac3:a7bb:1c2f with SMTP id
 a640c23a62f3a-acad343945cmr1127735566b.7.1744641529858; Mon, 14 Apr 2025
 07:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744005845.git.wqu@suse.com> <57244fa5fbd1e35dfecb3ecc172ca75b9df67e91.1744005845.git.wqu@suse.com>
In-Reply-To: <57244fa5fbd1e35dfecb3ecc172ca75b9df67e91.1744005845.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 14 Apr 2025 15:38:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5qDzLw6vtFbbW8+izmmiXq5HPRW3yuM9263eXHG=0o-Q@mail.gmail.com>
X-Gm-Features: ATxdqUGGRIMf2ocwZmcTRevReyuUVadpappDy6SLhgAre9xWI0vLO11BRtnRx6U
Message-ID: <CAL3q7H5qDzLw6vtFbbW8+izmmiXq5HPRW3yuM9263eXHG=0o-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: enable larger data folios support for defrag
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:10=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently we rejects larger folios for defrag gracefully, but the

rejects -> reject

> implementation itself is already mostly larger folios compatible.
>
> There are several parts of defrag in btrfs:
>
> - Extent map checking
>   Aka, defrag_collect_targets(), which prepares a list of target ranges
>   that should be defragged.
>
>   This part is completely folio unrelated, thus it doesn't care about
>   the folio size.
>
> - Target folio preparation
>   Aka, defrag_prepare_one_folio(), which lock and read (if needed) the
>   target folio.
>
>   Since folio read and lock are already supporting larger folios, this
>   part needs only minor changes.
>
> - Redirty the target range of the folio
>   This is already done in a way supporting larger folios.
>
> So it's pretty straightforward to enable larger folios for defrag:
>
> - Do not reject larger folios for experimental builds
>   This affects the larger folio check inside defrag_prepare_one_folio().
>
> - Wait for ordered extents of the whole folio in
>   defrag_prepare_one_folio()
>
> - Lock the whole extent range for all involved folios in
>   defrag_one_range()
>
> - Allow the folios[] array to be partially empty
>   Since we can have larger folios, folios[] will not always be full.
>
>   This affects:
>   * How to allocate folios in defrag_one_range()
>     Now we can not use page index, but use the end position of the folio
>     as an iterator.
>
>   * How to free the folios[] array
>     If we hit an empty slot, it means we have larger folios and already
>     hit the end of the array.
>
>   * How to mark the range dirty
>     Instead of use page index directly, we have to go through each
>     folio.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/defrag.c | 72 +++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index d4310d93f532..f2fa8b5c64b5 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -857,13 +857,14 @@ static struct folio *defrag_prepare_one_folio(struc=
t btrfs_inode *inode, pgoff_t
>  {
>         struct address_space *mapping =3D inode->vfs_inode.i_mapping;
>         gfp_t mask =3D btrfs_alloc_write_mask(mapping);
> -       u64 page_start =3D (u64)index << PAGE_SHIFT;
> -       u64 page_end =3D page_start + PAGE_SIZE - 1;
> +       u64 folio_start;
> +       u64 folio_end;
>         struct extent_state *cached_state =3D NULL;
>         struct folio *folio;
>         int ret;
>
>  again:
> +       /* TODO: Add order fgp order flags when larger folios are fully e=
nabled. */
>         folio =3D __filemap_get_folio(mapping, index,
>                                     FGP_LOCK | FGP_ACCESSED | FGP_CREAT, =
mask);
>         if (IS_ERR(folio))
> @@ -871,13 +872,16 @@ static struct folio *defrag_prepare_one_folio(struc=
t btrfs_inode *inode, pgoff_t
>
>         /*
>          * Since we can defragment files opened read-only, we can encount=
er
> -        * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS).=
 We
> -        * can't do I/O using huge pages yet, so return an error for now.
> +        * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS).
> +        *
> +        * The IO for such larger folios are not fully tested, thus retur=
n

"are not" -> "is not"

> +        * an error to reject such folios unless it's an experimental bui=
ld.
> +        *
>          * Filesystem transparent huge pages are typically only used for
>          * executables that explicitly enable them, so this isn't very
>          * restrictive.
>          */
> -       if (folio_test_large(folio)) {
> +       if (!IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) && folio_test_large(fo=
lio)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 return ERR_PTR(-ETXTBSY);
> @@ -890,13 +894,15 @@ static struct folio *defrag_prepare_one_folio(struc=
t btrfs_inode *inode, pgoff_t
>                 return ERR_PTR(ret);
>         }
>
> +       folio_start =3D folio_pos(folio);
> +       folio_end =3D folio_pos(folio) + folio_size(folio) - 1;
>         /* Wait for any existing ordered extent in the range */
>         while (1) {
>                 struct btrfs_ordered_extent *ordered;
>
> -               lock_extent(&inode->io_tree, page_start, page_end, &cache=
d_state);
> -               ordered =3D btrfs_lookup_ordered_range(inode, page_start,=
 PAGE_SIZE);
> -               unlock_extent(&inode->io_tree, page_start, page_end,
> +               lock_extent(&inode->io_tree, folio_start, folio_end, &cac=
hed_state);
> +               ordered =3D btrfs_lookup_ordered_range(inode, folio_start=
, folio_size(folio));
> +               unlock_extent(&inode->io_tree, folio_start, folio_end,
>                               &cached_state);
>                 if (!ordered)
>                         break;
> @@ -1162,13 +1168,7 @@ static int defrag_one_locked_target(struct btrfs_i=
node *inode,
>         struct extent_changeset *data_reserved =3D NULL;
>         const u64 start =3D target->start;
>         const u64 len =3D target->len;
> -       unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
> -       unsigned long start_index =3D start >> PAGE_SHIFT;
> -       unsigned long first_index =3D folios[0]->index;
>         int ret =3D 0;
> -       int i;
> -
> -       ASSERT(last_index - first_index + 1 <=3D nr_pages);
>
>         ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved, start=
, len);
>         if (ret < 0)
> @@ -1179,10 +1179,17 @@ static int defrag_one_locked_target(struct btrfs_=
inode *inode,
>         set_extent_bit(&inode->io_tree, start, start + len - 1,
>                        EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
>
> -       /* Update the page status */
> -       for (i =3D start_index - first_index; i <=3D last_index - first_i=
ndex; i++) {
> -               folio_clear_checked(folios[i]);
> -               btrfs_folio_clamp_set_dirty(fs_info, folios[i], start, le=
n);
> +       /*
> +        * Update the page status.
> +        * Due to possible larger folios, we have to check all folios one=
 by one.
> +        * And the btrfs_folio_clamp_*() helpers can handle ranges out of=
 the
> +        * folio cases well.
> +        */
> +       for (int i =3D 0; i < nr_pages && folios[i]; i++) {
> +               struct folio *folio =3D folios[i];
> +
> +               btrfs_folio_clamp_clear_checked(fs_info, folio, start, le=
n);
> +               btrfs_folio_clamp_set_dirty(fs_info, folio, start, len);
>         }
>         btrfs_delalloc_release_extents(inode, len);
>         extent_changeset_free(data_reserved);
> @@ -1200,9 +1207,9 @@ static int defrag_one_range(struct btrfs_inode *ino=
de, u64 start, u32 len,
>         LIST_HEAD(target_list);
>         struct folio **folios;
>         const u32 sectorsize =3D inode->root->fs_info->sectorsize;
> -       u64 last_index =3D (start + len - 1) >> PAGE_SHIFT;
> -       u64 start_index =3D start >> PAGE_SHIFT;
> -       unsigned int nr_pages =3D last_index - start_index + 1;
> +       u64 cur =3D start;
> +       const unsigned int nr_pages =3D ((start + len - 1) >> PAGE_SHIFT)=
 -
> +                                     (start >> PAGE_SHIFT) + 1;
>         int ret =3D 0;
>         int i;
>
> @@ -1214,21 +1221,25 @@ static int defrag_one_range(struct btrfs_inode *i=
node, u64 start, u32 len,
>                 return -ENOMEM;
>
>         /* Prepare all pages */
> -       for (i =3D 0; i < nr_pages; i++) {
> -               folios[i] =3D defrag_prepare_one_folio(inode, start_index=
 + i);
> +       for (i =3D 0; cur < start + len && i < nr_pages; i++) {

It's a good opportunity to declare 'i' in the loop instead, like in
the previous function.

> +               folios[i] =3D defrag_prepare_one_folio(inode, cur >> PAGE=
_SHIFT);
>                 if (IS_ERR(folios[i])) {
>                         ret =3D PTR_ERR(folios[i]);
> -                       nr_pages =3D i;
> +                       folios[i] =3D NULL;
>                         goto free_folios;
>                 }
> +               cur =3D folio_pos(folios[i]) + folio_size(folios[i]);
>         }
> -       for (i =3D 0; i < nr_pages; i++)
> +       for (i =3D 0; i < nr_pages; i++) {

Same here.

> +               if (!folios[i])
> +                       break;
>                 folio_wait_writeback(folios[i]);
> +       }
>
> -       /* Lock the pages range */
> -       lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
> -                   (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> +       /* Lock the folios[] range */
> +       lock_extent(&inode->io_tree, folio_pos(folios[0]), cur - 1,
>                     &cached_state);
> +

This new line seems accidental.

>         /*
>          * Now we have a consistent view about the extent map, re-check
>          * which range really needs to be defragged.
> @@ -1254,11 +1265,12 @@ static int defrag_one_range(struct btrfs_inode *i=
node, u64 start, u32 len,
>                 kfree(entry);
>         }
>  unlock_extent:
> -       unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
> -                     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> +       unlock_extent(&inode->io_tree, folio_pos(folios[0]), cur - 1,
>                       &cached_state);
>  free_folios:
>         for (i =3D 0; i < nr_pages; i++) {

Same here.

With those minor changes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               if (!folios[i])
> +                       break;
>                 folio_unlock(folios[i]);
>                 folio_put(folios[i]);
>         }
> --
> 2.49.0
>
>

