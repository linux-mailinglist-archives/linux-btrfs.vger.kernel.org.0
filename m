Return-Path: <linux-btrfs+bounces-13413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA8FA9C351
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D299A70BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C90235BF3;
	Fri, 25 Apr 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4y0axpk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604A2356A0
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573106; cv=none; b=m5KwyFZETfv7qJQbY2zqGBl/rie8OAl54yISgJFr0Y4TvpzzGuCMDC48vRwvdp/HwruR7YpuZX2c66H+b26mI1Q/DipVWw2XtKrHb9BvJnHsZ4LkH60Oz5tHEWUXP4bZSMzIa2HxfoYMbcm0DrXYG30FU+Z+8Rnkb8z4/oO7B50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573106; c=relaxed/simple;
	bh=7kykoRZo1pWc2DWv7rUGMvb+dnQDq0OwP/25tcdjfZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1/kz3g+XE7kx+7mZApE7XhEIn/3zQoDnCgcrR06XfpNx/KLPchs4YeoFrFWAlKTKb7fXZEtvMRiwC3CxDy4wN/xicHY4NcKPH32/ahNKjc05uPajjuoVN29sSImq9Q9YFahS6aFeroLYU0jsTxgmolc25sQ5SHPbsI8Uye1/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4y0axpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2655C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745573106;
	bh=7kykoRZo1pWc2DWv7rUGMvb+dnQDq0OwP/25tcdjfZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4y0axpkYcbYZ4uGvByYMvxtXKLh++H7USusZYT4AU0bmPbg3oH0QmLNLJTpMxIW5
	 AiFhOaiASEd+C7sSA9K5PzoAllVu03mj4gyRZvYClRkAXrr+cRGR7ZGTmz8+LZJSKQ
	 chxB7NQngmW22SYJuve/y5YzBsU0CAJ6fleqgB5CVUAdn67ZyJPOTrwFi6i9FjvELV
	 mN1xSJidoZfpFFimYPzs76BOzZr7MzbJf6uEa7JlJ6udPHLADTRjeadyfoBv7x+6d6
	 trbnoPVp9t2POtLWwEG5MqbpWYdi758T1/9vL6J87YwJbxzl0SDjnsYxfdddz8+06H
	 NQnRuimQFi9bA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3b12e8518so361212966b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 02:25:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyvy1IM5pmHC09Mb2X1KoX1D/g26o2YNxZXDFqnRzeCK0MygvNo
	aZiAJdYPocSR8poDzC+F/IdmQzhQhQYrQaMGzn28s+VfuDc4hZ6Bx+51EmB8N/ewlmSbmPEpp3b
	vuyLBmaG4ZF2vAT7nUe8rpWYSxkU=
X-Google-Smtp-Source: AGHT+IF2hv/WVxxTQwFMfMScFRDbIdFk7cLlV2uFNeCgEk/nI6AlixsJ4VFizc6ysdV3pCKmAuhzzf3rK7wPTfyS/pU=
X-Received: by 2002:a17:907:6d27:b0:acb:33c6:5c71 with SMTP id
 a640c23a62f3a-ace710f1a40mr149960566b.29.1745573104252; Fri, 25 Apr 2025
 02:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745519463.git.josef@toxicpanda.com> <8e2ae679ccdb12e4e2f46f2811ec7f89fe7f900e.1745519463.git.josef@toxicpanda.com>
In-Reply-To: <8e2ae679ccdb12e4e2f46f2811ec7f89fe7f900e.1745519463.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Apr 2025 10:24:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Tv+MSz9+_TKoVrRNcf6_khOOPaEr21mcF=f6L2pZc7w@mail.gmail.com>
X-Gm-Features: ATxdqUFObF9Evx83P-HgReDQqB9pBnry-OZZX8AKiZ4D9Uea2WUFR88uBMF5QRY
Message-ID: <CAL3q7H7Tv+MSz9+_TKoVrRNcf6_khOOPaEr21mcF=f6L2pZc7w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] btrfs: convert the buffer_radix to an xarray
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:34=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> In order to fully utilize xarray tagging to improve writeback we need to
> convert the buffer_radix to a proper xarray.  This conversion is
> relatively straightforward as the radix code uses the xarray underneath.
> Using xarray directly allows for quite a lot less code.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c           |  15 ++-
>  fs/btrfs/extent_io.c         | 211 +++++++++++++++++------------------
>  fs/btrfs/fs.h                |   4 +-
>  fs/btrfs/tests/btrfs-tests.c |  28 ++---
>  fs/btrfs/zoned.c             |  16 +--
>  5 files changed, 124 insertions(+), 150 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 59da809b7d57..24c08eb86b7b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs=
_info *fs_info)
>         return ret;
>  }
>
> +/*
> + * lockdep gets confused between our buffer_tree which requires IRQ lock=
ing
> + * because we modify marks in the IRQ context, and our delayed inode xar=
ray
> + * which doesn't have these requirements. Use a class key so lockdep doe=
sn't get
> + * them mixed up.
> + */
> +static struct lock_class_key buffer_xa_class;
> +
>  void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  {
>         INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> -       INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> +
> +       /* Use the same flags as mapping->i_pages. */
> +       xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | XA_FLAGS=
_ACCOUNT);
> +       lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_xa_class=
);
> +
>         INIT_LIST_HEAD(&fs_info->trans_list);
>         INIT_LIST_HEAD(&fs_info->dead_roots);
>         INIT_LIST_HEAD(&fs_info->delayed_iputs);
> @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
>         spin_lock_init(&fs_info->delayed_iput_lock);
>         spin_lock_init(&fs_info->defrag_inodes_lock);
>         spin_lock_init(&fs_info->super_lock);
> -       spin_lock_init(&fs_info->buffer_lock);
>         spin_lock_init(&fs_info->unused_bgs_lock);
>         spin_lock_init(&fs_info->treelog_bg_lock);
>         spin_lock_init(&fs_info->zone_active_bgs_lock);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6cfd286b8bbc..4f861a8ff695 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1893,19 +1893,24 @@ static void set_btree_ioerr(struct extent_buffer =
*eb)
>   * context.
>   */
>  static struct extent_buffer *find_extent_buffer_nolock(
> -               const struct btrfs_fs_info *fs_info, u64 start)
> +               struct btrfs_fs_info *fs_info, u64 start)
>  {
> +       XA_STATE(xas, &fs_info->buffer_tree, start >> fs_info->sectorsize=
_bits);
>         struct extent_buffer *eb;
>
> +       /*
> +        * We open code xa_load() here because we need to be holding the =
rcu
> +        * lock when we access the eb.
> +        */
>         rcu_read_lock();
> -       eb =3D radix_tree_lookup(&fs_info->buffer_radix,
> -                              start >> fs_info->sectorsize_bits);
> -       if (eb && atomic_inc_not_zero(&eb->refs)) {
> -               rcu_read_unlock();
> -               return eb;
> -       }
> +       do {
> +               eb =3D xas_load(&xas);
> +       } while (xas_retry(&xas, eb));
> +
> +       if (eb && !atomic_inc_not_zero(&eb->refs))
> +               eb =3D NULL;
>         rcu_read_unlock();
> -       return NULL;
> +       return eb;
>  }
>
>  static void end_bbio_meta_write(struct btrfs_bio *bbio)
> @@ -2769,11 +2774,10 @@ static void detach_extent_buffer_folio(const stru=
ct extent_buffer *eb, struct fo
>
>         if (!btrfs_meta_is_subpage(fs_info)) {
>                 /*
> -                * We do this since we'll remove the pages after we've
> -                * removed the eb from the radix tree, so we could race
> -                * and have this page now attached to the new eb.  So
> -                * only clear folio if it's still connected to
> -                * this eb.
> +                * We do this since we'll remove the pages after we've re=
moved
> +                * the eb from the xarray, so we could race and have this=
 page
> +                * now attached to the new eb.  So only clear folio if it=
's
> +                * still connected to this eb.
>                  */
>                 if (folio_test_private(folio) && folio_get_private(folio)=
 =3D=3D eb) {
>                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)=
);
> @@ -2938,9 +2942,9 @@ static void check_buffer_tree_ref(struct extent_buf=
fer *eb)
>  {
>         int refs;
>         /*
> -        * The TREE_REF bit is first set when the extent_buffer is added
> -        * to the radix tree. It is also reset, if unset, when a new refe=
rence
> -        * is created by find_extent_buffer.
> +        * The TREE_REF bit is first set when the extent_buffer is added =
to the
> +        * xarray. It is also reset, if unset, when a new reference is cr=
eated
> +        * by find_extent_buffer.
>          *
>          * It is only cleared in two cases: freeing the last non-tree
>          * reference to the extent_buffer when its STALE bit is set or
> @@ -2952,13 +2956,12 @@ static void check_buffer_tree_ref(struct extent_b=
uffer *eb)
>          * conditions between the calls to check_buffer_tree_ref in those
>          * codepaths and clearing TREE_REF in try_release_extent_buffer.
>          *
> -        * The actual lifetime of the extent_buffer in the radix tree is
> -        * adequately protected by the refcount, but the TREE_REF bit and
> -        * its corresponding reference are not. To protect against this
> -        * class of races, we call check_buffer_tree_ref from the codepat=
hs
> -        * which trigger io. Note that once io is initiated, TREE_REF can=
 no
> -        * longer be cleared, so that is the moment at which any such rac=
e is
> -        * best fixed.
> +        * The actual lifetime of the extent_buffer in the xarray is adeq=
uately
> +        * protected by the refcount, but the TREE_REF bit and its corres=
ponding
> +        * reference are not. To protect against this class of races, we =
call
> +        * check_buffer_tree_ref from the codepaths which trigger io. Not=
e that
> +        * once io is initiated, TREE_REF can no longer be cleared, so th=
at is
> +        * the moment at which any such race is best fixed.
>          */
>         refs =3D atomic_read(&eb->refs);
>         if (refs >=3D 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> @@ -3022,23 +3025,26 @@ struct extent_buffer *alloc_test_extent_buffer(st=
ruct btrfs_fs_info *fs_info,
>                 return ERR_PTR(-ENOMEM);
>         eb->fs_info =3D fs_info;
>  again:
> -       ret =3D radix_tree_preload(GFP_NOFS);
> -       if (ret) {
> -               exists =3D ERR_PTR(ret);
> +       xa_lock_irq(&fs_info->buffer_tree);
> +       exists =3D __xa_cmpxchg(&fs_info->buffer_tree,
> +                             start >> fs_info->sectorsize_bits, NULL, eb=
,
> +                             GFP_NOFS);
> +       if (xa_is_err(exists)) {
> +               ret =3D xa_err(exists);
> +               xa_unlock_irq(&fs_info->buffer_tree);
> +               btrfs_release_extent_buffer(eb);
> +               return ERR_PTR(ret);
> +       }
> +       if (exists) {
> +               if (!atomic_inc_not_zero(&exists->refs)) {
> +                       /* The extent buffer is being freed, retry. */
> +                       xa_unlock_irq(&fs_info->buffer_tree);
> +                       goto again;
> +               }
> +               xa_unlock_irq(&fs_info->buffer_tree);
>                 goto free_eb;
>         }
> -       spin_lock(&fs_info->buffer_lock);
> -       ret =3D radix_tree_insert(&fs_info->buffer_radix,
> -                               start >> fs_info->sectorsize_bits, eb);
> -       spin_unlock(&fs_info->buffer_lock);
> -       radix_tree_preload_end();
> -       if (ret =3D=3D -EEXIST) {
> -               exists =3D find_extent_buffer(fs_info, start);
> -               if (exists)
> -                       goto free_eb;
> -               else
> -                       goto again;
> -       }
> +       xa_unlock_irq(&fs_info->buffer_tree);
>         check_buffer_tree_ref(eb);
>
>         return eb;
> @@ -3059,9 +3065,9 @@ static struct extent_buffer *grab_extent_buffer(str=
uct btrfs_fs_info *fs_info,
>         lockdep_assert_held(&folio->mapping->i_private_lock);
>
>         /*
> -        * For subpage case, we completely rely on radix tree to ensure w=
e
> -        * don't try to insert two ebs for the same bytenr.  So here we a=
lways
> -        * return NULL and just continue.
> +        * For subpage case, we completely rely on xarray to ensure we do=
n't try
> +        * to insert two ebs for the same bytenr.  So here we always retu=
rn NULL
> +        * and just continue.
>          */
>         if (btrfs_meta_is_subpage(fs_info))
>                 return NULL;
> @@ -3194,7 +3200,7 @@ static int attach_eb_folio_to_filemap(struct extent=
_buffer *eb, int i,
>         /*
>          * To inform we have an extra eb under allocation, so that
>          * detach_extent_buffer_page() won't release the folio private wh=
en the
> -        * eb hasn't been inserted into radix tree yet.
> +        * eb hasn't been inserted into the xarray yet.
>          *
>          * The ref will be decreased when the eb releases the page, in
>          * detach_extent_buffer_page().  Thus needs no special handling i=
n the
> @@ -3328,10 +3334,10 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>
>                 /*
>                  * We can't unlock the pages just yet since the extent bu=
ffer
> -                * hasn't been properly inserted in the radix tree, this
> -                * opens a race with btree_release_folio which can free a=
 page
> -                * while we are still filling in all pages for the buffer=
 and
> -                * we could crash.
> +                * hasn't been properly inserted in the xarray, this open=
s a
> +                * race with btree_release_folio which can free a page wh=
ile we
> +                * are still filling in all pages for the buffer and we c=
ould
> +                * crash.
>                  */
>         }
>         if (uptodate)
> @@ -3340,23 +3346,25 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>         if (page_contig)
>                 eb->addr =3D folio_address(eb->folios[0]) + offset_in_pag=
e(eb->start);
>  again:
> -       ret =3D radix_tree_preload(GFP_NOFS);
> -       if (ret)
> +       xa_lock_irq(&fs_info->buffer_tree);
> +       existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> +                                  start >> fs_info->sectorsize_bits, NUL=
L, eb,
> +                                  GFP_NOFS);
> +       if (xa_is_err(existing_eb)) {
> +               ret =3D xa_err(existing_eb);
> +               xa_unlock_irq(&fs_info->buffer_tree);
>                 goto out;
> -
> -       spin_lock(&fs_info->buffer_lock);
> -       ret =3D radix_tree_insert(&fs_info->buffer_radix,
> -                               start >> fs_info->sectorsize_bits, eb);
> -       spin_unlock(&fs_info->buffer_lock);
> -       radix_tree_preload_end();
> -       if (ret =3D=3D -EEXIST) {
> -               ret =3D 0;
> -               existing_eb =3D find_extent_buffer(fs_info, start);
> -               if (existing_eb)
> -                       goto out;
> -               else
> -                       goto again;
>         }
> +       if (existing_eb) {
> +               if (!atomic_inc_not_zero(&existing_eb->refs)) {
> +                       xa_unlock_irq(&fs_info->buffer_tree);
> +                       goto again;
> +               }
> +               xa_unlock_irq(&fs_info->buffer_tree);
> +               goto out;
> +       }
> +       xa_unlock_irq(&fs_info->buffer_tree);
> +
>         /* add one reference for the tree */
>         check_buffer_tree_ref(eb);
>
> @@ -3426,10 +3434,19 @@ static int release_extent_buffer(struct extent_bu=
ffer *eb)
>
>                 spin_unlock(&eb->refs_lock);
>
> -               spin_lock(&fs_info->buffer_lock);
> -               radix_tree_delete_item(&fs_info->buffer_radix,
> -                                      eb->start >> fs_info->sectorsize_b=
its, eb);
> -               spin_unlock(&fs_info->buffer_lock);
> +               /*
> +                * We're erasing, theoretically there will be no allocati=
ons, so
> +                * just use GFP_ATOMIC.
> +                *
> +                * We use cmpxchg instead of erase because we do not know=
 if
> +                * this eb is actually in the tree or not, we could be cl=
eaning
> +                * up an eb that we allocated but never inserted into the=
 tree.
> +                * Thus use cmpxchg to remove it from the tree if it is t=
here,
> +                * or leave the other entry if this isn't in the tree.
> +                */
> +               xa_cmpxchg_irq(&fs_info->buffer_tree,
> +                              eb->start >> fs_info->sectorsize_bits, eb,=
 NULL,
> +                              GFP_ATOMIC);

So I think you haven't seen my last reply:

https://lore.kernel.org/linux-btrfs/CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-h=
Si5OEi86jejg@mail.gmail.com/

My concern was about if storing a NULL doesn't release space in the xarray.
Checking the xarray documentation confirms that storing a NULL does
release space except if the xarray was defined with the XA_FLAGS_ALLOC
flag, which is not the case here so we're fine.
Perhaps add a comment too about storing NULL releases space.

Anyway, overall it looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


>
>                 btrfs_leak_debug_del_eb(eb);
>                 /* Should be safe to release folios at this point. */
> @@ -4260,44 +4277,6 @@ void memmove_extent_buffer(const struct extent_buf=
fer *dst,
>         }
>  }
>
> -#define GANG_LOOKUP_SIZE       16
> -static struct extent_buffer *get_next_extent_buffer(
> -               const struct btrfs_fs_info *fs_info, struct folio *folio,=
 u64 bytenr)
> -{
> -       struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> -       struct extent_buffer *found =3D NULL;
> -       u64 folio_start =3D folio_pos(folio);
> -       u64 cur =3D folio_start;
> -
> -       ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
> -       lockdep_assert_held(&fs_info->buffer_lock);
> -
> -       while (cur < folio_start + PAGE_SIZE) {
> -               int ret;
> -               int i;
> -
> -               ret =3D radix_tree_gang_lookup(&fs_info->buffer_radix,
> -                               (void **)gang, cur >> fs_info->sectorsize=
_bits,
> -                               min_t(unsigned int, GANG_LOOKUP_SIZE,
> -                                     PAGE_SIZE / fs_info->nodesize));
> -               if (ret =3D=3D 0)
> -                       goto out;
> -               for (i =3D 0; i < ret; i++) {
> -                       /* Already beyond page end */
> -                       if (gang[i]->start >=3D folio_start + PAGE_SIZE)
> -                               goto out;
> -                       /* Found one */
> -                       if (gang[i]->start >=3D bytenr) {
> -                               found =3D gang[i];
> -                               goto out;
> -                       }
> -               }
> -               cur =3D gang[ret - 1]->start + gang[ret - 1]->len;
> -       }
> -out:
> -       return found;
> -}
> -
>  static int try_release_subpage_extent_buffer(struct folio *folio)
>  {
>         struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> @@ -4306,21 +4285,31 @@ static int try_release_subpage_extent_buffer(stru=
ct folio *folio)
>         int ret;
>
>         while (cur < end) {
> +               XA_STATE(xas, &fs_info->buffer_tree,
> +                        cur >> fs_info->sectorsize_bits);
>                 struct extent_buffer *eb =3D NULL;
>
>                 /*
>                  * Unlike try_release_extent_buffer() which uses folio pr=
ivate
> -                * to grab buffer, for subpage case we rely on radix tree=
, thus
> -                * we need to ensure radix tree consistency.
> +                * to grab buffer, for subpage case we rely on xarray, th=
us we
> +                * need to ensure xarray tree consistency.
>                  *
> -                * We also want an atomic snapshot of the radix tree, thu=
s go
> +                * We also want an atomic snapshot of the xarray tree, th=
us go
>                  * with spinlock rather than RCU.
> +                *
> +                * We open code xa_load() here because we need to be hold=
ing the
> +                * xa lock while we're accessing the eb. We could technic=
ally
> +                * use xa_load() while holding the lock since it just doe=
s an
> +                * rcu_read_lock(), but that would be a bit of a waste.
>                  */
> -               spin_lock(&fs_info->buffer_lock);
> -               eb =3D get_next_extent_buffer(fs_info, folio, cur);
> +               xa_lock_irq(&fs_info->buffer_tree);
> +               do {
> +                       eb =3D xas_find(&xas, end >> fs_info->sectorsize_=
bits);
> +               } while (xas_retry(&xas, eb));
> +
>                 if (!eb) {
>                         /* No more eb in the page range after or at cur *=
/
> -                       spin_unlock(&fs_info->buffer_lock);
> +                       xa_unlock_irq(&fs_info->buffer_tree);
>                         break;
>                 }
>                 cur =3D eb->start + eb->len;
> @@ -4332,10 +4321,10 @@ static int try_release_subpage_extent_buffer(stru=
ct folio *folio)
>                 spin_lock(&eb->refs_lock);
>                 if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_under_=
io(eb)) {
>                         spin_unlock(&eb->refs_lock);
> -                       spin_unlock(&fs_info->buffer_lock);
> +                       xa_unlock_irq(&fs_info->buffer_tree);
>                         break;
>                 }
> -               spin_unlock(&fs_info->buffer_lock);
> +               xa_unlock_irq(&fs_info->buffer_tree);
>
>                 /*
>                  * If tree ref isn't set then we know the ref on this eb =
is a
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index bcca43046064..ed02d276d908 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -776,10 +776,8 @@ struct btrfs_fs_info {
>
>         struct btrfs_delayed_root *delayed_root;
>
> -       /* Extent buffer radix tree */
> -       spinlock_t buffer_lock;
>         /* Entries are eb->start / sectorsize */
> -       struct radix_tree_root buffer_radix;
> +       struct xarray buffer_tree;
>
>         /* Next backup root to be overwritten */
>         int backup_root_index;
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index 02a915eb51fb..b576897d71cc 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 n=
odesize, u32 sectorsize)
>
>  void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
>  {
> -       struct radix_tree_iter iter;
> -       void **slot;
>         struct btrfs_device *dev, *tmp;
> +       struct extent_buffer *eb;
> +       unsigned long index;
>
>         if (!fs_info)
>                 return;
> @@ -169,25 +169,13 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info =
*fs_info)
>
>         test_mnt->mnt_sb->s_fs_info =3D NULL;
>
> -       spin_lock(&fs_info->buffer_lock);
> -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) =
{
> -               struct extent_buffer *eb;
> -
> -               eb =3D radix_tree_deref_slot_protected(slot, &fs_info->bu=
ffer_lock);
> -               if (!eb)
> -                       continue;
> -               /* Shouldn't happen but that kind of thinking creates CVE=
's */
> -               if (radix_tree_exception(eb)) {
> -                       if (radix_tree_deref_retry(eb))
> -                               slot =3D radix_tree_iter_retry(&iter);
> -                       continue;
> -               }
> -               slot =3D radix_tree_iter_resume(slot, &iter);
> -               spin_unlock(&fs_info->buffer_lock);
> -               free_extent_buffer_stale(eb);
> -               spin_lock(&fs_info->buffer_lock);
> +       xa_lock_irq(&fs_info->buffer_tree);
> +       xa_for_each(&fs_info->buffer_tree, index, eb) {
> +               xa_unlock_irq(&fs_info->buffer_tree);
> +               free_extent_buffer(eb);
> +               xa_lock_irq(&fs_info->buffer_tree);
>         }
> -       spin_unlock(&fs_info->buffer_lock);
> +       xa_unlock_irq(&fs_info->buffer_tree);
>
>         btrfs_mapping_tree_free(fs_info);
>         list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 7b30700ec930..4b59bc480663 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2171,27 +2171,15 @@ static void wait_eb_writebacks(struct btrfs_block=
_group *block_group)
>  {
>         struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>         const u64 end =3D block_group->start + block_group->length;
> -       struct radix_tree_iter iter;
>         struct extent_buffer *eb;
> -       void __rcu **slot;
> +       unsigned long index, start =3D block_group->start >> fs_info->sec=
torsize_bits;
>
>         rcu_read_lock();
> -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
> -                                block_group->start >> fs_info->sectorsiz=
e_bits) {
> -               eb =3D radix_tree_deref_slot(slot);
> -               if (!eb)
> -                       continue;
> -               if (radix_tree_deref_retry(eb)) {
> -                       slot =3D radix_tree_iter_retry(&iter);
> -                       continue;
> -               }
> -
> +       xa_for_each_start(&fs_info->buffer_tree, index, eb, start) {
>                 if (eb->start < block_group->start)
>                         continue;
>                 if (eb->start >=3D end)
>                         break;
> -
> -               slot =3D radix_tree_iter_resume(slot, &iter);
>                 rcu_read_unlock();
>                 wait_on_extent_buffer_writeback(eb);
>                 rcu_read_lock();
> --
> 2.48.1
>
>

