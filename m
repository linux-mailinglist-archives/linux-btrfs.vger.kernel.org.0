Return-Path: <linux-btrfs+bounces-6012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7DD91A1DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80E4B21487
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D712D214;
	Thu, 27 Jun 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afa+mMcT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC1819
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478254; cv=none; b=Y2NcB5mpFoElRdUTJ9SnB9u5KCRh2Mz4ccvThHhHWSIiriVXP7fJ8nQhvZPF3oPwI5z79vpgkkkxS37wNRIk6a+T506GsIKoqsQEPvViczXBT6u809tThW5WafQbVCv6Zhu9CU66se9GoDZIbk/aMh2ZmzOpIpfbAIVcuEGVj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478254; c=relaxed/simple;
	bh=z/mP+2ehn9ga+EDDl3I8mYylN+YZa3Hmi/bjZGJG9RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkNxhllzS1847MxRLqOlzUY6tc8tW0C1qJ7Adxg25YRcPwWmbhM5RgK7s/W4F4SzgnQdw1nsHU1Ty4YuMYk/exrpPe/znUijPVzVIUA44Rjyf2kr5T9D01S15oTtAxVhrJpE4NYt6i8B/3U1tsKPglpbXoePe0lLV1XSRoCSNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afa+mMcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6519C2BD10
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719478253;
	bh=z/mP+2ehn9ga+EDDl3I8mYylN+YZa3Hmi/bjZGJG9RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=afa+mMcTtx9aZxirGKPHIxjZ+L6RxL3+WAn3kWLJu92JridQ5O4AhOk/ZG3yV2044
	 Rc99lpXu0qpVWpNsBGNotXAwy9FXGJA4YVVDAFHoBrv9Yd4bLZiVIDMqeKNj7YV/i8
	 Dc8xrbsMZiiq5ix7uXDpp/h8ba3AvcGZuq9yJEPFxQicBaW5EJ92vzD9M7l1eDuC1B
	 TbOomjuKgkS7rFSdQ0Rx6hZ1gGD0b7cOg8Q/zFA0Nlpjm8R+I0P0hqzpWaPvccSEsE
	 394secS+vpQblMHlWWA6zuW6fhtLw3AxhbpN6wmG+TOiGo7zvJs0oITaUVj/afvyyU
	 mmNJaFPLWL1zw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a725a918edaso394818866b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 01:50:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwubnC1R8qoMDRzglksQFIHQRemzUyyBjJAh9j2lcQTZyq7NTTh
	FlTy4p7GcjOBP098dwfKORkzHO2FJPc9nwRjupeo1DGTe3RjWlLWVr8zGtMFTGrZ3QwcoRhQMnZ
	8S0FHsvH2QE02xSrsrSnpq84rgd4=
X-Google-Smtp-Source: AGHT+IEL1WxNGfTEjfJf7puhbb9D2g4mKHvH7WPjn1cTi1LwdGdvDW+HeQe36ruJ1SdnJd2UJmQwGbs8ur8wf5gWfzM=
X-Received: by 2002:a17:907:1187:b0:a72:4402:9344 with SMTP id
 a640c23a62f3a-a7245ba395emr1134533966b.20.1719478252353; Thu, 27 Jun 2024
 01:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719462554.git.wqu@suse.com> <1b08b3f46e29dbb6c88a6f7cf038c2487386bdb0.1719462554.git.wqu@suse.com>
In-Reply-To: <1b08b3f46e29dbb6c88a6f7cf038c2487386bdb0.1719462554.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Jun 2024 09:50:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5OywgMv=BRRFwmNW5pEVLs7AfnuO+jDuz5hsV9CCGX5A@mail.gmail.com>
Message-ID: <CAL3q7H5OywgMv=BRRFwmNW5pEVLs7AfnuO+jDuz5hsV9CCGX5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: remove the extra_gfp parameter from btrfs_alloc_page_array()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is only one caller utilizing the @extra_gfp parameter,
> alloc_eb_folio_array(). All the other callers do not really bother the
> @extra_gfp at all.
>
> This patch removes the parameter from the public function, meanwhile
> implement an internal version with @nofail parameter just for
> alloc_eb_folio_array() to utilize.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 43 +++++++++++++++++++++++--------------------
>  fs/btrfs/extent_io.h |  3 +--
>  fs/btrfs/inode.c     |  2 +-
>  fs/btrfs/raid56.c    |  6 +++---
>  fs/btrfs/scrub.c     |  2 +-
>  5 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dc416bad9ad8..64f8e7b4d553 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -695,22 +695,10 @@ int btrfs_alloc_folio_array(unsigned int nr_folios,=
 struct folio **folio_array)
>         return -ENOMEM;
>  }
>
> -/*
> - * Populate every free slot in a provided array with pages.
> - *
> - * @nr_pages:   number of pages to allocate
> - * @page_array: the array to fill with pages; any existing non-null entr=
ies in
> - *             the array will be skipped
> - * @extra_gfp: the extra GFP flags for the allocation.
> - *
> - * Return: 0        if all pages were able to be allocated;
> - *         -ENOMEM  otherwise, the partially allocated pages would be fr=
eed and
> - *                  the array slots zeroed
> - */
> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay,
> -                          gfp_t extra_gfp)
> +static int __btrfs_alloc_page_array(unsigned int nr_pages,
> +                                   struct page **page_array, bool nofail=
)

Please don't use functions prefixed with __, we have abandoned that
practice, it's against our preferred coding style.

Also instead of adding a wrapper function, why not just change the
extra_gfp parameter of btrfs_alloc_page() to the "bool nofail" thing?

You mentioned in the cover letter "callers have to pay for the extra
parameter", but really are you worried about performance?
On x86_64 the argument is passed in a register, which is super
efficient, almost certainly better than the overhead of an extra
function call.

Thanks.

>  {
> -       const gfp_t gfp =3D GFP_NOFS | extra_gfp;
> +       const gfp_t gfp =3D nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS=
;
>         unsigned int allocated;
>
>         for (allocated =3D 0; allocated < nr_pages;) {
> @@ -728,19 +716,34 @@ int btrfs_alloc_page_array(unsigned int nr_pages, s=
truct page **page_array,
>         }
>         return 0;
>  }
> +/*
> + * Populate every free slot in a provided array with pages, using GFP_NO=
FS.
> + *
> + * @nr_pages:   number of pages to allocate
> + * @page_array: the array to fill with pages; any existing non-null entr=
ies in
> + *             the array will be skipped
> + *
> + * Return: 0        if all pages were able to be allocated;
> + *         -ENOMEM  otherwise, the partially allocated pages would be fr=
eed and
> + *                  the array slots zeroed
> + */
> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay)
> +{
> +       return __btrfs_alloc_page_array(nr_pages, page_array, false);
> +}
>
>  /*
>   * Populate needed folios for the extent buffer.
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
> +       ret =3D __btrfs_alloc_page_array(num_pages, page_array, nofail);
>         if (ret < 0)
>                 return ret;
>
> @@ -2722,7 +2725,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(con=
st struct extent_buffer *src)
>          */
>         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>
> -       ret =3D alloc_eb_folio_array(new, 0);
> +       ret =3D alloc_eb_folio_array(new, false);
>         if (ret) {
>                 btrfs_release_extent_buffer(new);
>                 return NULL;
> @@ -2755,7 +2758,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>         if (!eb)
>                 return NULL;
>
> -       ret =3D alloc_eb_folio_array(eb, 0);
> +       ret =3D alloc_eb_folio_array(eb, false);
>         if (ret)
>                 goto err;
>
> @@ -3121,7 +3124,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
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
> index 8364dcb1ace3..0da5f1947a2b 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -363,8 +363,7 @@ int extent_invalidate_folio(struct extent_io_tree *tr=
ee,
>  void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>                               struct extent_buffer *buf);
>
> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay,
> -                          gfp_t extra_gfp);
> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay);
>  int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio=
_array);
>
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 92ef9b01cf5e..6dfcd27b88ac 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9128,7 +9128,7 @@ static ssize_t btrfs_encoded_read_regular(struct ki=
ocb *iocb,
>         pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>         if (!pages)
>                 return -ENOMEM;
> -       ret =3D btrfs_alloc_page_array(nr_pages, pages, 0);
> +       ret =3D btrfs_alloc_page_array(nr_pages, pages);
>         if (ret) {
>                 ret =3D -ENOMEM;
>                 goto out;
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 3858c00936e8..294bf7349f96 100644
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
);
>         if (ret < 0)
>                 return ret;
>         /* Mapping all sectors */
> @@ -1066,7 +1066,7 @@ static int alloc_rbio_parity_pages(struct btrfs_rai=
d_bio *rbio)
>         int ret;
>
>         ret =3D btrfs_alloc_page_array(rbio->nr_pages - data_pages,
> -                                    rbio->stripe_pages + data_pages, 0);
> +                                    rbio->stripe_pages + data_pages);
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
> +       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4677a4f55b6a..2d819b027321 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs=
_info,
>         atomic_set(&stripe->pending_io, 0);
>         spin_lock_init(&stripe->write_error_lock);
>
> -       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages,=
 0);
> +       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages)=
;
>         if (ret < 0)
>                 goto error;
>
> --
> 2.45.2
>
>

