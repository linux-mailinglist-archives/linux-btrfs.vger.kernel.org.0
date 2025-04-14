Return-Path: <linux-btrfs+bounces-12993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A715DA8858F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303F516F3FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8012951C6;
	Mon, 14 Apr 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2MNI6r0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738027FD6F
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640739; cv=none; b=tvn8i6CmJhwGT/IwH2M6mqmUY7/8QQnNNG+nyhlx5y+Uc/NlawhWn4U3uZQ/gCq1COXOVwCltAucgz1/Cl5BATuesr9GMPpmhhOHFmvutbpKtZj+XM6DIi2sRQ4iMtysStSQBYozPz64XtudnqnuuW/aymhARUcUUtHQRc4LuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640739; c=relaxed/simple;
	bh=mWkRJHGXiArGfmY4FHUG5b654/42eyO2VyN6duQYhko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MA1Y68P5y7XDQbIy7pp6rSRwyQsC4jUvptTAFLf5s4BttlrEt4mPhxuv90v2hUBkERlHDprUGQ1TMdgrB/yUwZa16D4Msdfh0pC5kGGht+SxHv7smBxcHCV5E0PYIehKX1AAb6nwkjUBuch6w7vLeUw/rjcNy5TllhjkB0Tgc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2MNI6r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389EEC4CEE2
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640739;
	bh=mWkRJHGXiArGfmY4FHUG5b654/42eyO2VyN6duQYhko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k2MNI6r0kV3uCYkOsD7PVMiDj4y/k3PMhil8Mnk/lZtWb/xtyL5YiTMcRerlZv2Lv
	 cIvpYi81j4yFlLYyJVjKxQqUqm7rtDeMVgTTtKqnYDfewg8i7hfR6amgAn938oMgIN
	 rhowoH46Wcbc1MrFDjgrmF/ElLtuwVuczjXeEEnbPx+6PQp0NrwcQSBxXCWTeThNU+
	 bKsRy+nLL4mSNYG0lzm/42ueHThU/pANNQMfI1N6qn9arFvN1fuV6Nga86mMFGNReq
	 KMlwYs9fpgVm1RXATunbExqnM9knAtrMojT75m3KA+XkNFQD3ru1l/c876eMo568HF
	 SITkKy8U/DjiA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaecf50578eso801713666b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:25:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWLmauxaKkCfjhjAx4KpkX4nnubwFsm0v1v5y7+CGwuo2a1jYy
	bqAPOcUlWLP73zc8JubM2Jd80UImnzdKBcFTUd1CwsIYUNIGTvmr1V/+X5js829txfKUHPmROaW
	KR7H7z67MEwl2y2wbBTKAsnDJDNA=
X-Google-Smtp-Source: AGHT+IHQUwL4ncXDRBXQtD4VUm+atX49Yg+IB5AewBCs2Dg9UHfIU5PThkRNQCGPC5fHZCT6yumFOemWeIxhMYe/Ntc=
X-Received: by 2002:a17:907:948e:b0:ac7:66fb:6a07 with SMTP id
 a640c23a62f3a-acad3439f1fmr1046254966b.6.1744640737793; Mon, 14 Apr 2025
 07:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744005845.git.wqu@suse.com> <f679cbeedbb0132cc657b4db7a1d3d70ff2261f0.1744005845.git.wqu@suse.com>
In-Reply-To: <f679cbeedbb0132cc657b4db7a1d3d70ff2261f0.1744005845.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 14 Apr 2025 15:25:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7x+cH6gAjuyO2pW=An6NkJwm_TCbGzVVygLHvvwzfz+g@mail.gmail.com>
X-Gm-Features: ATxdqUGDH1uvFd3p3xC68NzlncsAMCDVF6ijyqxWdLVMfFQPNYl8hgsqTM5w2lk
Message-ID: <CAL3q7H7x+cH6gAjuyO2pW=An6NkJwm_TCbGzVVygLHvvwzfz+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: prepare btrfs_end_repair_bio() for larger data folios
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:09=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The function btrfs_end_repair_bio() has an ASSERT() making sure the
> folio is page sized.
>
> The reason is mostly related to the fact that later we pass a folio and
> its offset into btrfs_repair_io_failure().
> If we have larger folios passed in, later calculation of the folio and
> its offset can go wrong, as we have extra offset to the bv_page.
>
> Change the behavior by:
>
> - Doing a proper folio grab
>   Instead of just page_folio(bv_page), we should get the real page (as th=
e
>   bv_offset can be larger than page size), then call page_folio().
>
> - Do extra folio offset calculation
>
>                      real_page
>    bv_page           |   bv_offset (10K)
>    |                 |   |
>    v                 v   v
>    |        |        |       |
>    |<- F1 ->|<--- Folio 2 -->|
>             | result off |
>
>    '|' is page boundary.
>
>    The folio is the one containing that real_page.
>    We want the real offset inside that folio.
>
>    The result offset we want is of two parts:
>    - the offset of the real page to the folio page

"to the folio page", this is confusing for me. Isn't it the offset of
the page inside the folio?
I.e. "the offset of the real page inside the folio"

Also, this terminology "real page", does it come from somewhere?
Aren't all pages "real"?

>    - the offset inside that real page
>
>    We can not use offset_in_folio() which will give an incorrect result.
>    (2K instead of 6K, as folio 1 has a different order)

I don't think anyone can understand where that 2K and 6K come from.
The diagram doesn't mention how many pages per folio (folio order),
page sizes, and file offset of each folio.
So mentioning that 2K and 6K without all the relevant information,
make it useless and confusing IMO.

>
> With these changes, now btrfs_end_repair_bio() is able to handle not
> only large folios, but also multi-page bio vectors.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c | 61 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8c2eee1f1878..3140aa19aadc 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -156,6 +156,58 @@ static void btrfs_repair_done(struct btrfs_failed_bi=
o *fbio)
>         }
>  }
>
> +/*
> + * Since a single bio_vec can merge multiple physically contiguous pages
> + * into one bio_vec entry, we can have the following case:
> + *
> + * bv_page             bv_offset
> + * v                   v
> + * |    |    |   |   |   |   |
> + *
> + * In that case we need to grab the real page where bv_offset is at.
> + */
> +static struct page *bio_vec_get_real_page(const struct bio_vec *bv)
> +{
> +       return bv->bv_page + (bv->bv_offset >> PAGE_SHIFT);
> +}
> +static struct folio *bio_vec_get_folio(const struct bio_vec *bv)

Please add a blank line between function delcarations.

> +{
> +       return page_folio(bio_vec_get_real_page(bv));
> +}
> +
> +static unsigned long bio_vec_get_folio_offset(const struct bio_vec *bv)
> +{
> +       const struct page *real_page =3D bio_vec_get_real_page(bv);
> +       const struct folio *folio =3D page_folio(real_page);
> +
> +       /*
> +        * The following ASCII chart is to show how the calculation is do=
ne.
> +        *
> +        *                   real_page
> +        * bv_page           |   bv_offset (10K)
> +        * |                 |   |
> +        * v                 v   v
> +        * |        |        |       |
> +        * |<- F1 ->|<--- Folio 2 -->|
> +        *          | result off |
> +        *
> +        * '|' is page boundary.
> +        *
> +        * The folio is the one containing that real_page.
> +        * We want the real offset inside that folio.
> +        *
> +        * The result offset we want is of two parts:
> +        * - the offset of the real page to the folio page
> +        * - the offset inside that real page
> +        *
> +        * We can not use offset_in_folio() which will give an incorrect =
result.
> +        * (2K instead of 6K, as folio 1 has a different order)

Same comment here, as this is copied from the change log.

Codewise this looks good to me, but those comments and terminology
("real page") make it confusing IMO.

Thanks.

> +        */
> +       ASSERT(&folio->page <=3D real_page);
> +       return (folio_page_idx(folio, real_page) << PAGE_SHIFT) +
> +               offset_in_page(bv->bv_offset);
> +}
> +
>  static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>                                  struct btrfs_device *dev)
>  {
> @@ -165,12 +217,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *r=
epair_bbio,
>         struct bio_vec *bv =3D bio_first_bvec_all(&repair_bbio->bio);
>         int mirror =3D repair_bbio->mirror_num;
>
> -       /*
> -        * We can only trigger this for data bio, which doesn't support l=
arger
> -        * folios yet.
> -        */
> -       ASSERT(folio_order(page_folio(bv->bv_page)) =3D=3D 0);
> -
>         if (repair_bbio->bio.bi_status ||
>             !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
>                 bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
> @@ -192,7 +238,8 @@ static void btrfs_end_repair_bio(struct btrfs_bio *re=
pair_bbio,
>                 btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
>                                   repair_bbio->file_offset, fs_info->sect=
orsize,
>                                   repair_bbio->saved_iter.bi_sector << SE=
CTOR_SHIFT,
> -                                 page_folio(bv->bv_page), bv->bv_offset,=
 mirror);
> +                                 bio_vec_get_folio(bv), bio_vec_get_foli=
o_offset(bv),
> +                                 mirror);
>         } while (mirror !=3D fbio->bbio->mirror_num);
>
>  done:
> --
> 2.49.0
>
>

