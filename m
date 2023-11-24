Return-Path: <linux-btrfs+bounces-341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84607F742F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 13:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49121B2148E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9FB1DA32;
	Fri, 24 Nov 2023 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAYe7OQL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9518B0B
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 12:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8E9C433CC
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700830095;
	bh=bIOL9WDdsIMsE2eEOBlZIrkCezo/ItAAXxFKILjrSaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dAYe7OQLM32tRw7paUSOi0E89t0NLdK6acjsEUhEC7uTF9NIYNXhBu+pxqeftvTbN
	 ZpeNLP1vf4Yjn2ys9ez27LTcmbokcpqJ8Z7ASCd6nrqbYYr+FUBBjI2IAh75XsfSV1
	 OTFm/2qzkR13DJdBdpljvSvln7/o9UNe06gkf9mYyrHlwH/gobw2Eni8r0cHHHJUx0
	 G6dFJGPyAPB8HcuvqV0LPcK3q7MG9vU6mA6Lr8rjZyMfWyANYDpc60AQ15khPzT46I
	 RlMRUdpTcRuQtirCVpVPAa1mX8WIv8Ga8k24da3LRngRtUCCp2i9U8416ITW58Ijdp
	 W7WrxK0xm+iBw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso2567355a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 04:48:15 -0800 (PST)
X-Gm-Message-State: AOJu0YwyTUuhKVx4HUGnaLSmbUcBiDdmXBxWdPpHjSoEyaQXH/FyR8Bl
	g0vGNLbbvWvzOODnHkxUyZzHo4J0gM+FgUxC7oo=
X-Google-Smtp-Source: AGHT+IEQx0g5lEmm1ku1vRPcfIPX3n9N6Eh+TPN2ON+hUjzsqgwOg2/nGt+Eike3a6yWe663oZg1EHo8psBmMxb8Zis=
X-Received: by 2002:a17:907:5090:b0:9d5:7c6f:de5d with SMTP id
 fv16-20020a170907509000b009d57c6fde5dmr1714026ejc.39.1700830094236; Fri, 24
 Nov 2023 04:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
 <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
In-Reply-To: <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Nov 2023 12:47:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4g=eD5y7DB6x8TW_S4D--2K9y4j5RKH37B-ZpAjfqctw@mail.gmail.com>
Message-ID: <CAL3q7H4g=eD5y7DB6x8TW_S4D--2K9y4j5RKH37B-ZpAjfqctw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: free the allocated memory if btrfs_alloc_page_array()
 failed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:50=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Fri, Nov 24, 2023 at 4:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [BUG]
> > If btrfs_alloc_page_array() failed to allocate all pages but part of th=
e
> > slots, then the partially allocated pages would be leaked in function
> > btrfs_submit_compressed_read().
> >
> > [CAUSE]
> > As explicitly stated, if btrfs_alloc_page_array() returned -ENOMEM,
> > caller is responsible to free the partially allocated pages.
> >
> > For the existing call sites, most of them are fine:
> >
> > - btrfs_raid_bio::stripe_pages
> >   Handled by free_raid_bio().
> >
> > - extent_buffer::pages[]
> >   Handled btrfs_release_extent_buffer_pages().
> >
> > - scrub_stripe::pages[]
> >   Handled by release_scrub_stripe().
> >
> > But there is one exception in btrfs_submit_compressed_read(), if
> > btrfs_alloc_page_array() failed, we didn't cleanup the array and freed
> > the array pointer directly.
> >
> > Initially there is still the error handling in commit dd137dd1f2d7
> > ("btrfs: factor out allocating an array of pages"), but later in commit
> > 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio"),
> > the error handling is removed, leading to the possible memory leak.
> >
> > [FIX]
> > This patch would add back the error handling first, then to prevent suc=
h
> > situation from happening again, also make btrfs_alloc_page_array() to
> > free the allocated pages as a extra safe net.
> >
> > Fixes: 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_b=
io")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Looks good, thanks.

Well, just one comment, see below.

>
> > ---
> >  fs/btrfs/compression.c |  4 ++++
> >  fs/btrfs/extent_io.c   | 10 +++++++---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 19b22b4653c8..d6120741774b 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -534,6 +534,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio=
 *bbio)
> >         return;
> >
> >  out_free_compressed_pages:
> > +       for (int i =3D 0; i < cb->nr_pages; i++) {
> > +               if (cb->compressed_pages[i])
> > +                       __free_page(cb->compressed_pages[i]);
> > +       }

So this hunk is not needed, because of the changes you did to
btrfs_alloc_page_array(), as now it always frees any allocated pages
on -ENOMEM.

Thanks.

> >         kfree(cb->compressed_pages);
> >  out_free_bio:
> >         bio_put(&cb->bbio.bio);
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 0ea65f248c15..e2c0c596bd46 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -676,8 +676,7 @@ static void end_bio_extent_readpage(struct btrfs_bi=
o *bbio)
> >   *             the array will be skipped
> >   *
> >   * Return: 0        if all pages were able to be allocated;
> > - *         -ENOMEM  otherwise, and the caller is responsible for freei=
ng all
> > - *                  non-null page pointers in the array.
> > + *         -ENOMEM  otherwise, and the partially allocated pages would=
 be freed.
> >   */
> >  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_a=
rray)
> >  {
> > @@ -696,8 +695,13 @@ int btrfs_alloc_page_array(unsigned int nr_pages, =
struct page **page_array)
> >                  * though alloc_pages_bulk_array() falls back to alloc_=
page()
> >                  * if  it could not bulk-allocate. So we must be out of=
 memory.
> >                  */
> > -               if (allocated =3D=3D last)
> > +               if (allocated =3D=3D last) {
> > +                       for (int i =3D 0; i < allocated; i++) {
> > +                               __free_page(page_array[i]);
> > +                               page_array[i] =3D NULL;
> > +                       }
> >                         return -ENOMEM;
> > +               }
> >
> >                 memalloc_retry_wait(GFP_NOFS);
> >         }
> > --
> > 2.42.1
> >
> >

