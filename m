Return-Path: <linux-btrfs+bounces-6017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D691A40F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9896FB21755
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4214374C;
	Thu, 27 Jun 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbFUMxou"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293413E048
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484732; cv=none; b=qEfaNqDY7gKe7ghIarp/wR6WMM5DHhVnlrlbi0wWYZrxg82zCURGDhVaCaqOy7RHI0TOb6MFWi+yj+DLkSIEwZ91KbNdTOzTAorcGx/tlfs9plvBkDSME3+Now2qXYmhfmTgxsdChz1rKzTSEKQfJE4ramFVzrlFLhHgdPm7Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484732; c=relaxed/simple;
	bh=FnImDT/Ewc8Rou9KFGFt8S0ThYZm0ayqC32rXNDj73Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOf/G1p+iU2c285wrSvtkldjO+iiSLumfcu6hiHFzetfpRkvawgVQySRuAoKOhe24H2tZ34Rfrp9229ZkvLGafbeBPE+1oCucVIKJU5cTdv8SmxDXfujWsLwiH29uQXCAAb7pk2YTBQBGV0K+EwhYffeMoekwUlQh+LBSpYyzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbFUMxou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F036C4AF0A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719484732;
	bh=FnImDT/Ewc8Rou9KFGFt8S0ThYZm0ayqC32rXNDj73Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WbFUMxouoG1CR84iaqL5Jd+weBqORtkaUe79kICg/xu93amdgV5uobaBVgaAujRr/
	 8EdEObSmKnLtpWazyrxr6gY7gNcTZvMK0ZrR7EDo78U448ofhUQRHQhCCr9SKQnAQd
	 JNmXZxClnic+tL5pciM5bJHloYOxU1fioRgBpXR+NfdNaagwRsE20J5DFqIefF1up8
	 FXBBlwVO0jXn6PcO66dBb3fgKTbh82AW8uk5QX1IZI3dbGdbMbxjc7xz22mQU4Gqql
	 tAaZ36H9pM3RvLrc9yOwKTvmNoT+w58Expt0lmGbb181352U2QMLM4S9djIBvogtdd
	 BnPeIvETj/1DA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a725282b926so617602566b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 03:38:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyPILPetxBnPVoMkm+tMtTd2T70Dmh7+bhmE5LW8MLIpHIKYMl4gshECqL0P6OuwQ/UDOYoz/IQw0pQUgOtvidlOCBZlKhfrQ3J9k=
X-Gm-Message-State: AOJu0Yyc1oPeyeNZr323zZSsneO1o8yg1RBEZRAb9pb9v/NgBoD1z0xr
	iafStlh4D5RwvrY275Fibc3b8V/zduefIjt7uiWMA0gx8BquZNUdFUqfugjV0EyxfM8K641zmGK
	zTpW9Pm4tkbiQkY9YBoxSTivZ6D0=
X-Google-Smtp-Source: AGHT+IFppILsUfscO3HFM6kMSU4XJpX7cQiyWuCCVcNArTPqcRIihoyeofscJJJn5b4tSp6yClMYwRrmqR1PQSe4jjc=
X-Received: by 2002:a17:906:255b:b0:a6f:b5cc:9190 with SMTP id
 a640c23a62f3a-a7245cce10cmr781446966b.28.1719484730652; Thu, 27 Jun 2024
 03:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719462554.git.wqu@suse.com> <1b08b3f46e29dbb6c88a6f7cf038c2487386bdb0.1719462554.git.wqu@suse.com>
 <CAL3q7H5OywgMv=BRRFwmNW5pEVLs7AfnuO+jDuz5hsV9CCGX5A@mail.gmail.com> <a6238bf2-4560-47ab-9daf-769d12be05dd@gmx.com>
In-Reply-To: <a6238bf2-4560-47ab-9daf-769d12be05dd@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Jun 2024 11:38:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6uYdd8yrEwD5f+A7zHk=tRirKr=emC4nveuLe_tuqCKw@mail.gmail.com>
Message-ID: <CAL3q7H6uYdd8yrEwD5f+A7zHk=tRirKr=emC4nveuLe_tuqCKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: remove the extra_gfp parameter from btrfs_alloc_page_array()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:15=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/6/27 18:20, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Jun 27, 2024 at 5:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> There is only one caller utilizing the @extra_gfp parameter,
> >> alloc_eb_folio_array(). All the other callers do not really bother the
> >> @extra_gfp at all.
> >>
> >> This patch removes the parameter from the public function, meanwhile
> >> implement an internal version with @nofail parameter just for
> >> alloc_eb_folio_array() to utilize.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/extent_io.c | 43 +++++++++++++++++++++++-------------------=
-
> >>   fs/btrfs/extent_io.h |  3 +--
> >>   fs/btrfs/inode.c     |  2 +-
> >>   fs/btrfs/raid56.c    |  6 +++---
> >>   fs/btrfs/scrub.c     |  2 +-
> >>   5 files changed, 29 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index dc416bad9ad8..64f8e7b4d553 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -695,22 +695,10 @@ int btrfs_alloc_folio_array(unsigned int nr_foli=
os, struct folio **folio_array)
> >>          return -ENOMEM;
> >>   }
> >>
> >> -/*
> >> - * Populate every free slot in a provided array with pages.
> >> - *
> >> - * @nr_pages:   number of pages to allocate
> >> - * @page_array: the array to fill with pages; any existing non-null e=
ntries in
> >> - *             the array will be skipped
> >> - * @extra_gfp: the extra GFP flags for the allocation.
> >> - *
> >> - * Return: 0        if all pages were able to be allocated;
> >> - *         -ENOMEM  otherwise, the partially allocated pages would be=
 freed and
> >> - *                  the array slots zeroed
> >> - */
> >> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_=
array,
> >> -                          gfp_t extra_gfp)
> >> +static int __btrfs_alloc_page_array(unsigned int nr_pages,
> >> +                                   struct page **page_array, bool nof=
ail)
> >
> > Please don't use functions prefixed with __, we have abandoned that
> > practice, it's against our preferred coding style.
> >
> > Also instead of adding a wrapper function, why not just change the
> > extra_gfp parameter of btrfs_alloc_page() to the "bool nofail" thing?
> >
> > You mentioned in the cover letter "callers have to pay for the extra
> > parameter", but really are you worried about performance?
> > On x86_64 the argument is passed in a register, which is super
> > efficient, almost certainly better than the overhead of an extra
> > function call.
>
> It's not about performance, but the burden on us reviewing/writing code
> using that function.
> As everytime we need to call that function, we have to check if we need
> to use any special value for the extra parameter.

Well, that's the case for pretty much every other function call
everywhere, we have to figure out what parameter values to pass.

If we start adding such wrappers around every case, we end up with
plenty of these one line functions.
And sooner or later someone will send a cleanup patch to remove them
and make all callers pass the extra argument (we have a history of
such cleanup patches).

>
> The basic idea is, to keep the most common call to be simple (aka, less
> parameters), and only for those special call sites to use the more
> complex one.
>
> This is the only time I miss function overloading in C++.
>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>   {
> >> -       const gfp_t gfp =3D GFP_NOFS | extra_gfp;
> >> +       const gfp_t gfp =3D nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_N=
OFS;
> >>          unsigned int allocated;
> >>
> >>          for (allocated =3D 0; allocated < nr_pages;) {
> >> @@ -728,19 +716,34 @@ int btrfs_alloc_page_array(unsigned int nr_pages=
, struct page **page_array,
> >>          }
> >>          return 0;
> >>   }
> >> +/*
> >> + * Populate every free slot in a provided array with pages, using GFP=
_NOFS.
> >> + *
> >> + * @nr_pages:   number of pages to allocate
> >> + * @page_array: the array to fill with pages; any existing non-null e=
ntries in
> >> + *             the array will be skipped
> >> + *
> >> + * Return: 0        if all pages were able to be allocated;
> >> + *         -ENOMEM  otherwise, the partially allocated pages would be=
 freed and
> >> + *                  the array slots zeroed
> >> + */
> >> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_=
array)
> >> +{
> >> +       return __btrfs_alloc_page_array(nr_pages, page_array, false);
> >> +}
> >>
> >>   /*
> >>    * Populate needed folios for the extent buffer.
> >>    *
> >>    * For now, the folios populated are always in order 0 (aka, single =
page).
> >>    */
> >> -static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra=
_gfp)
> >> +static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail=
)
> >>   {
> >>          struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] =3D { 0 }=
;
> >>          int num_pages =3D num_extent_pages(eb);
> >>          int ret;
> >>
> >> -       ret =3D btrfs_alloc_page_array(num_pages, page_array, extra_gf=
p);
> >> +       ret =3D __btrfs_alloc_page_array(num_pages, page_array, nofail=
);
> >>          if (ret < 0)
> >>                  return ret;
> >>
> >> @@ -2722,7 +2725,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(=
const struct extent_buffer *src)
> >>           */
> >>          set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> >>
> >> -       ret =3D alloc_eb_folio_array(new, 0);
> >> +       ret =3D alloc_eb_folio_array(new, false);
> >>          if (ret) {
> >>                  btrfs_release_extent_buffer(new);
> >>                  return NULL;
> >> @@ -2755,7 +2758,7 @@ struct extent_buffer *__alloc_dummy_extent_buffe=
r(struct btrfs_fs_info *fs_info,
> >>          if (!eb)
> >>                  return NULL;
> >>
> >> -       ret =3D alloc_eb_folio_array(eb, 0);
> >> +       ret =3D alloc_eb_folio_array(eb, false);
> >>          if (ret)
> >>                  goto err;
> >>
> >> @@ -3121,7 +3124,7 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
> >>
> >>   reallocate:
> >>          /* Allocate all pages first. */
> >> -       ret =3D alloc_eb_folio_array(eb, __GFP_NOFAIL);
> >> +       ret =3D alloc_eb_folio_array(eb, true);
> >>          if (ret < 0) {
> >>                  btrfs_free_subpage(prealloc);
> >>                  goto out;
> >> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> >> index 8364dcb1ace3..0da5f1947a2b 100644
> >> --- a/fs/btrfs/extent_io.h
> >> +++ b/fs/btrfs/extent_io.h
> >> @@ -363,8 +363,7 @@ int extent_invalidate_folio(struct extent_io_tree =
*tree,
> >>   void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
> >>                                struct extent_buffer *buf);
> >>
> >> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_=
array,
> >> -                          gfp_t extra_gfp);
> >> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_=
array);
> >>   int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **f=
olio_array);
> >>
> >>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 92ef9b01cf5e..6dfcd27b88ac 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -9128,7 +9128,7 @@ static ssize_t btrfs_encoded_read_regular(struct=
 kiocb *iocb,
> >>          pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> >>          if (!pages)
> >>                  return -ENOMEM;
> >> -       ret =3D btrfs_alloc_page_array(nr_pages, pages, 0);
> >> +       ret =3D btrfs_alloc_page_array(nr_pages, pages);
> >>          if (ret) {
> >>                  ret =3D -ENOMEM;
> >>                  goto out;
> >> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> >> index 3858c00936e8..294bf7349f96 100644
> >> --- a/fs/btrfs/raid56.c
> >> +++ b/fs/btrfs/raid56.c
> >> @@ -1051,7 +1051,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bi=
o *rbio)
> >>   {
> >>          int ret;
> >>
> >> -       ret =3D btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pa=
ges, 0);
> >> +       ret =3D btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pa=
ges);
> >>          if (ret < 0)
> >>                  return ret;
> >>          /* Mapping all sectors */
> >> @@ -1066,7 +1066,7 @@ static int alloc_rbio_parity_pages(struct btrfs_=
raid_bio *rbio)
> >>          int ret;
> >>
> >>          ret =3D btrfs_alloc_page_array(rbio->nr_pages - data_pages,
> >> -                                    rbio->stripe_pages + data_pages, =
0);
> >> +                                    rbio->stripe_pages + data_pages);
> >>          if (ret < 0)
> >>                  return ret;
> >>
> >> @@ -1640,7 +1640,7 @@ static int alloc_rbio_data_pages(struct btrfs_ra=
id_bio *rbio)
> >>          const int data_pages =3D rbio->nr_data * rbio->stripe_npages;
> >>          int ret;
> >>
> >> -       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages,=
 0);
> >> +       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages)=
;
> >>          if (ret < 0)
> >>                  return ret;
> >>
> >> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >> index 4677a4f55b6a..2d819b027321 100644
> >> --- a/fs/btrfs/scrub.c
> >> +++ b/fs/btrfs/scrub.c
> >> @@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info =
*fs_info,
> >>          atomic_set(&stripe->pending_io, 0);
> >>          spin_lock_init(&stripe->write_error_lock);
> >>
> >> -       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pag=
es, 0);
> >> +       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pag=
es);
> >>          if (ret < 0)
> >>                  goto error;
> >>
> >> --
> >> 2.45.2
> >>
> >>
> >

