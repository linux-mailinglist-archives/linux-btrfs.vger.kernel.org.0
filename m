Return-Path: <linux-btrfs+bounces-6035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D291BB88
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6EEB22672
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94815278D;
	Fri, 28 Jun 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRp2xCkZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69E15252C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567238; cv=none; b=fHn3wlh/3oYfMP1t5zdfO5wuef6egpiBucijuOEf93OCrmMtgq5nT7w4WX+nSPAksoK/8bI6Wr875/5vIg9s0C5GD2ZLUI5f6Y25ga592Ozspun2/BJk3Y4Rbp9jBes8eyjHkVAjEXtHiLcu9qHF4YgrDMcR7ac8uwkUI3fO1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567238; c=relaxed/simple;
	bh=mrU82vn4pW+bvFzxjtgGdTkGSg9g95M6avS1pk5ztd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKwt0Xdoj4GFdqcnv/L429yfyLQNgokP+odbqVpORZWx+IkJx8FcbXWlYSdqAAjTv6FsUqxJgVYxd3CVrwiexo8GpnWR1QT+rfG7fbYZ0zJQa+TRIGvuAbKbaR3vYe14odKUc1562YdR3kJQhFOPh3++PSxZCYAUkn7SiNkyrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRp2xCkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404A2C32781
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719567238;
	bh=mrU82vn4pW+bvFzxjtgGdTkGSg9g95M6avS1pk5ztd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bRp2xCkZtBQTORsCEIG6HsbDVmo/mUFBQvP/BtPZE1mBwOjOzdHKYtVnWKIRZjF8B
	 1FX4ZFuKLiGaTqflo6xUT/njAoFM88UIJbirWWRGIb10d9k2BIUq4nVL60e3H6n5JN
	 BwjXbt3jZzoHwU/UrRrr8sHmtKBlzYBlzf8Fk2CIkyd/X1t9jD9f4MRGenkSY5aAjO
	 +XnerHSInsY+snOJG8eGjFDJhkAm4gLc1ZRYzoKkmuyurJjTPqtr5QbPvHPph7cug0
	 ARdFC54gfMucskWAnerCYNyH1uuCAnHsX5x5FU/51IxeZa3kbWvv9oY3vbjU9VG4AT
	 DAQ6ri4r0gFag==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6fd513f18bso44790666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 02:33:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlFwkcUZNcVJy7IthJBWT8pajTArElbTPvj1CGpjvNnVNAf0dK
	U/3T4K03WxvNRvop+yLQOrdKgdx4RjWKlDQAmL2aBixQP7j0shP7+zmQ79hLBDcRv8+qx11F0RA
	lh+eW/NC0S3qxB79dgKuHTPhP2Dw=
X-Google-Smtp-Source: AGHT+IFIeH1C3Ld+6gsCJvfQqzW0zkfSVhhgeU+G4YpELlPxwhqCbZIn18+mEEez58BC3Fkqmqd41okzk7zkUaB2QHo=
X-Received: by 2002:a17:906:9c8d:b0:a72:5bb9:b140 with SMTP id
 a640c23a62f3a-a725bb9b312mr861685066b.54.1719567236723; Fri, 28 Jun 2024
 02:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719548446.git.wqu@suse.com> <9533640304878bb57291dafc76ab0656892cf64a.1719548446.git.wqu@suse.com>
In-Reply-To: <9533640304878bb57291dafc76ab0656892cf64a.1719548446.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Jun 2024 10:33:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Nd7f3XEoPGgyovryvF0eMat+25++nwd3W=bSBDSActA@mail.gmail.com>
Message-ID: <CAL3q7H6Nd7f3XEoPGgyovryvF0eMat+25++nwd3W=bSBDSActA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: rename the extra_gfp parameter of btrfs_alloc_page_array()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 5:22=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is only one caller utilizing the @extra_gfp parameter,
> alloc_eb_folio_array().
> And in that case the extra_gfp is only assigned to __GFP_NOFAIL.
>
> This patch would rename the @extra_gfp parameter to @nofail to indicate
> that.

"would rename" -> renames

Anyway, it's good now:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 20 ++++++++++----------
>  fs/btrfs/extent_io.h |  2 +-
>  fs/btrfs/inode.c     |  2 +-
>  fs/btrfs/raid56.c    |  6 +++---
>  fs/btrfs/scrub.c     |  2 +-
>  5 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dc416bad9ad8..d3ce07ab9692 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -696,21 +696,21 @@ int btrfs_alloc_folio_array(unsigned int nr_folios,=
 struct folio **folio_array)
>  }
>
>  /*
> - * Populate every free slot in a provided array with pages.
> + * Populate every free slot in a provided array with pages, using GFP_NO=
FS.
>   *
>   * @nr_pages:   number of pages to allocate
>   * @page_array: the array to fill with pages; any existing non-null entr=
ies in
> - *             the array will be skipped
> - * @extra_gfp: the extra GFP flags for the allocation.
> + *             the array will be skipped
> + * @nofail:    whether using __GFP_NOFAIL flag
>   *
>   * Return: 0        if all pages were able to be allocated;
>   *         -ENOMEM  otherwise, the partially allocated pages would be fr=
eed and
>   *                  the array slots zeroed
>   */
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay,
> -                          gfp_t extra_gfp)
> +                          bool nofail)
>  {
> -       const gfp_t gfp =3D GFP_NOFS | extra_gfp;
> +       const gfp_t gfp =3D nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS=
;
>         unsigned int allocated;
>
>         for (allocated =3D 0; allocated < nr_pages;) {
> @@ -734,13 +734,13 @@ int btrfs_alloc_page_array(unsigned int nr_pages, s=
truct page **page_array,
>   *
>   * For now, the folios populated are always in order 0 (aka, single page=
).
>   */
> -static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gf=
p)
> +static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
>  {
>         struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] =3D { 0 };
>         int num_pages =3D num_extent_pages(eb);
>         int ret;
>
> -       ret =3D btrfs_alloc_page_array(num_pages, page_array, extra_gfp);
> +       ret =3D btrfs_alloc_page_array(num_pages, page_array, nofail);
>         if (ret < 0)
>                 return ret;
>
> @@ -2722,7 +2722,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(con=
st struct extent_buffer *src)
>          */
>         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>
> -       ret =3D alloc_eb_folio_array(new, 0);
> +       ret =3D alloc_eb_folio_array(new, false);
>         if (ret) {
>                 btrfs_release_extent_buffer(new);
>                 return NULL;
> @@ -2755,7 +2755,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>         if (!eb)
>                 return NULL;
>
> -       ret =3D alloc_eb_folio_array(eb, 0);
> +       ret =3D alloc_eb_folio_array(eb, false);
>         if (ret)
>                 goto err;
>
> @@ -3121,7 +3121,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>
>  reallocate:
>         /* Allocate all pages first. */
> -       ret =3D alloc_eb_folio_array(eb, __GFP_NOFAIL);
> +       ret =3D alloc_eb_folio_array(eb, true);
>         if (ret < 0) {
>                 btrfs_free_subpage(prealloc);
>                 goto out;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 8364dcb1ace3..e0cf9a367373 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -364,7 +364,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_hand=
le *trans,
>                               struct extent_buffer *buf);
>
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay,
> -                          gfp_t extra_gfp);
> +                          bool nofail);
>  int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio=
_array);
>
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 92ef9b01cf5e..0a11d309ee89 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9128,7 +9128,7 @@ static ssize_t btrfs_encoded_read_regular(struct ki=
ocb *iocb,
>         pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>         if (!pages)
>                 return -ENOMEM;
> -       ret =3D btrfs_alloc_page_array(nr_pages, pages, 0);
> +       ret =3D btrfs_alloc_page_array(nr_pages, pages, false);
>         if (ret) {
>                 ret =3D -ENOMEM;
>                 goto out;
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 3858c00936e8..39bec672df0c 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1051,7 +1051,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *=
rbio)
>  {
>         int ret;
>
> -       ret =3D btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages=
, 0);
> +       ret =3D btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages=
, false);
>         if (ret < 0)
>                 return ret;
>         /* Mapping all sectors */
> @@ -1066,7 +1066,7 @@ static int alloc_rbio_parity_pages(struct btrfs_rai=
d_bio *rbio)
>         int ret;
>
>         ret =3D btrfs_alloc_page_array(rbio->nr_pages - data_pages,
> -                                    rbio->stripe_pages + data_pages, 0);
> +                                    rbio->stripe_pages + data_pages, fal=
se);
>         if (ret < 0)
>                 return ret;
>
> @@ -1640,7 +1640,7 @@ static int alloc_rbio_data_pages(struct btrfs_raid_=
bio *rbio)
>         const int data_pages =3D rbio->nr_data * rbio->stripe_npages;
>         int ret;
>
> -       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages, 0)=
;
> +       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages, fa=
lse);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4677a4f55b6a..14a8d7100018 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs=
_info,
>         atomic_set(&stripe->pending_io, 0);
>         spin_lock_init(&stripe->write_error_lock);
>
> -       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages,=
 0);
> +       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages,=
 false);
>         if (ret < 0)
>                 goto error;
>
> --
> 2.45.2
>
>

