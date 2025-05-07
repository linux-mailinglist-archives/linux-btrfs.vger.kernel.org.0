Return-Path: <linux-btrfs+bounces-13763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C4AADCB7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 12:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A38C17964C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64017A2F0;
	Wed,  7 May 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxiIp1BE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809501DBB0C
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614676; cv=none; b=gZ3HUYfS2SU9pg3yPoFQHn+tDu/XsdYu/PLNFz/eTZwMet/KFDCMK2TXDMoqjCo4XcS9hb15a9rWywMPDNL9lSywmuvmNxNzAIjQQO3nYr49ez6LxCKxq4hl2blMrb+kP+4A0MOmLKZpnB7BvH2SgfciGLOevfQRFS4OQ7IPdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614676; c=relaxed/simple;
	bh=h5Ycy2ddtgj3dcEjd70oDkufrIDpl1HlfFNwTV0jNqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QR/7jBUimV5xW/BKhuPInX2Dd9BpclF+cP6oCC9xQspCtvHIsIbAOgXDEdE1A7m2wBX5D4dwITjIWGm5ZqV9l0SWB7wuWVPPEAUWyfZHq0MFbovAb69KtSpoAy+Xer3CztHEAkehqGr5bc1102XdAss5Ab1dz3dOYscOKRJMV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxiIp1BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4F3C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746614675;
	bh=h5Ycy2ddtgj3dcEjd70oDkufrIDpl1HlfFNwTV0jNqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pxiIp1BE5yIlNRTK8DkYwBUF+jR+fTfCWPvhiaHlj2fXBKU+0N4evCXcg+Ug2CKIi
	 Bu9nRNao2iY1o78K+SE6tRlYV65+YrHXR/AczEnm5ZmGYdY7i9Kro0XEAkAx+htlMU
	 Vn9flb/IzbDUiFUTVkb3UXcuk6lflUGtHFwbA2Ww3kYCyn8kfRN79I/p7C95vkLrJj
	 Fo3W0hu9KuxHVJx39PAse3vIxFWTWIyams9k4C+qTZ1nXpqnX4N3ZTWSThszqtgQEv
	 43PXTVwvx/6T4yIHszSYRVHnoIsi3gmV2DxcRUdJVeNvE8aoaxmEQ+b3J3RXjOwFzW
	 tjQ5/5kTTFIrg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ace94273f0dso525999066b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 May 2025 03:44:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YyFH/TG91Jwh2/PzSTSIteFPs+ndEXfyLGfvewo4paZFfNsHZle
	TjX5SgdovNTiFVG/NoO/ZQY2NEvGEIo7F7A+l/Xyyo8eixYrgjHipLzQzhaf7oeBbakro17/Ojx
	mp7r8rTSzYrRztNTa2kRQ8GhiSII=
X-Google-Smtp-Source: AGHT+IEVJ5TXVTNKlsOfNwRb9/RQ2hDDAxRcAY8co/kkXpfqteLSGkSi0LRzzQa6ZXWaTF271TzddcIcTdxfrovEL4k=
X-Received: by 2002:a17:907:cf94:b0:acb:5070:dd19 with SMTP id
 a640c23a62f3a-ad1e8d562cemr277696266b.61.1746614673448; Wed, 07 May 2025
 03:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4e4f39ce79e08f41410ec45653d028db63e468b.1746594262.git.wqu@suse.com>
In-Reply-To: <b4e4f39ce79e08f41410ec45653d028db63e468b.1746594262.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 May 2025 11:43:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5vMCT3eJBHupjqppfgXD=qLzACcWVnowbrJeeduvTVXg@mail.gmail.com>
X-Gm-Features: ATxdqUHwoN-zWSdwKN-JVCQs1bZHBcfA8bRZ6PGmfenOYQNJnsp4uOEMx42Ye00
Message-ID: <CAL3q7H5vMCT3eJBHupjqppfgXD=qLzACcWVnowbrJeeduvTVXg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: reduce memory usage of scrub_sector_verification
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 6:05=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> That structure records needed info for block verification (either data
> checksum pointer, or expected tree block generation).
>
> But there is also a boolean to tell if this block belongs to a metadata
> or not, as the data checksum pointer and expected tree block generation
> is already a union, we need a dedicated bit to tell if this block is a
> metadata or not.
>
> However such layout means we're wasting 63 bits for x86_64, which is a
> huge memory waste.
>
> Thanks to the recent bitmap aggregation, we can easily move this
> single-bit-per-block member to a new sub-bitmap.
> And since we already have six 16 bits long bitmaps, adding another
> bitmap won't even increase any memory usage for x86_64, as we need two
> 64 bits long anyway.
>
> This will reduce the following memory usages:
>
> - sizeof(struct scrub_sector_verification)
>   From 16 bytes to 8 bytes on x86_64.
>
> - scrub_stripe::sectors
>   From 16 * 16 to 16 * 8 bytes.
>
> - Per-device scrub_ctx memory usage
>   From 128 * (16 * 16) to 128 * (16 * 8), which saves 16KiB memory.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/scrub.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4ba0154e086a..c362bd32756e 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -66,8 +66,6 @@ struct scrub_ctx;
>
>  /* Represent one sector and its needed info to verify the content. */
>  struct scrub_sector_verification {
> -       bool is_metadata;
> -
>         union {
>                 /*
>                  * Csum pointer for data csum verification.  Should point=
 to a
> @@ -115,6 +113,9 @@ enum {
>         /* Which blocks are covered by extent items. */
>         scrub_bitmap_nr_has_extent =3D 0,
>
> +       /* Which blocks are meteadata. */
> +       scrub_bitmap_nr_is_metadata,
> +
>         /*
>          * Which blocks have errors, including IO, csum, and metadata
>          * errors.
> @@ -304,6 +305,7 @@ static inline unsigned int scrub_bitmap_weight_##name=
(struct scrub_stripe *strip
>         return bitmap_weight(&bitmap, stripe->nr_sectors);              \
>  }
>  IMPLEMENT_SCRUB_BITMAP_OPS(has_extent);
> +IMPLEMENT_SCRUB_BITMAP_OPS(is_metadata);
>  IMPLEMENT_SCRUB_BITMAP_OPS(error);
>  IMPLEMENT_SCRUB_BITMAP_OPS(io_error);
>  IMPLEMENT_SCRUB_BITMAP_OPS(csum_error);
> @@ -801,7 +803,7 @@ static void scrub_verify_one_sector(struct scrub_stri=
pe *stripe, int sector_nr)
>                 return;
>
>         /* Metadata, verify the full tree block. */
> -       if (sector->is_metadata) {
> +       if (scrub_bitmap_test_bit_is_metadata(stripe, sector_nr)) {
>                 /*
>                  * Check if the tree block crosses the stripe boundary.  =
If
>                  * crossed the boundary, we cannot verify it but only giv=
e a
> @@ -850,7 +852,7 @@ static void scrub_verify_one_stripe(struct scrub_stri=
pe *stripe, unsigned long b
>
>         for_each_set_bit(sector_nr, &bitmap, stripe->nr_sectors) {
>                 scrub_verify_one_sector(stripe, sector_nr);
> -               if (stripe->sectors[sector_nr].is_metadata)
> +               if (scrub_bitmap_test_bit_is_metadata(stripe, sector_nr))
>                         sector_nr +=3D sectors_per_tree - 1;
>         }
>  }
> @@ -1019,7 +1021,7 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>         for_each_set_bit(sector_nr, &extent_bitmap, stripe->nr_sectors) {
>                 bool repaired =3D false;
>
> -               if (stripe->sectors[sector_nr].is_metadata) {
> +               if (scrub_bitmap_test_bit_is_metadata(stripe, sector_nr))=
 {
>                         nr_meta_sectors++;
>                 } else {
>                         nr_data_sectors++;
> @@ -1616,7 +1618,7 @@ static void fill_one_extent_info(struct btrfs_fs_in=
fo *fs_info,
>
>                 scrub_bitmap_set_bit_has_extent(stripe, nr_sector);
>                 if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
> -                       sector->is_metadata =3D true;
> +                       scrub_bitmap_set_bit_is_metadata(stripe, nr_secto=
r);
>                         sector->generation =3D extent_gen;
>                 }
>         }
> @@ -1760,7 +1762,6 @@ static void scrub_reset_stripe(struct scrub_stripe =
*stripe)
>         stripe->state =3D 0;
>
>         for (int i =3D 0; i < stripe->nr_sectors; i++) {
> -               stripe->sectors[i].is_metadata =3D false;
>                 stripe->sectors[i].csum =3D NULL;
>                 stripe->sectors[i].generation =3D 0;
>         }
> @@ -1902,7 +1903,7 @@ static bool stripe_has_metadata_error(struct scrub_=
stripe *stripe)
>         int i;
>
>         for_each_set_bit(i, &error, stripe->nr_sectors) {
> -               if (stripe->sectors[i].is_metadata) {
> +               if (scrub_bitmap_test_bit_is_metadata(stripe, i)) {
>                         struct btrfs_fs_info *fs_info =3D stripe->bg->fs_=
info;
>
>                         btrfs_err(fs_info,
> --
> 2.49.0
>
>

