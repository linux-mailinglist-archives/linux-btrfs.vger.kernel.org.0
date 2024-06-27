Return-Path: <linux-btrfs+bounces-6013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7224891A1E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F601F21A34
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F712F398;
	Thu, 27 Jun 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqKi4IHC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985004D8B1
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478313; cv=none; b=gQ2EHLGwLrLs8VBPMTHnaE1hgKgNxqD8x0h8W1lhjMFPKD1+1DnKDB2JfV4UIQjEjR4q1aQqZS56dA8U+IelnEAX3tNsiD81izt2ddkqV7Tca8cSggCJ6v1+7c0oHpX5ko2Bly5jLel3G2qRYJZx3hsVMUqW6xg+8NkawWDtdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478313; c=relaxed/simple;
	bh=ie81hloNzi4St5AxoagKdpUG/SbhAa13IY3HM0usL7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC+sjiso9L4VG1V0mouZ3wb2L0uC0kAi1+ZJ7dgW2kucs/Ew150yGxt3KBbHVUGN0IxSDekWvrPBRoNOAXPw74P3eoYC5BdTVOPqBiBlQwLV64ovQX09XBxrq/l9qO6IKxgRXGFwGcZoppBmE8kVTdB4hq6zJ2bS53ihaWx+v1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqKi4IHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B1FC2BBFC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719478313;
	bh=ie81hloNzi4St5AxoagKdpUG/SbhAa13IY3HM0usL7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jqKi4IHChu/woXNrfYxte+S11gWoaj8EVGSJq+ldUmu7gnPx4DNQDRnPO3msIKz0r
	 bKxfJQJVTv+0AoOWdpKXcDmYaBKu2rfZ2GMmPuNEWdIyfvcIvgQcw2d7/gSY/vDAvl
	 71kH3xodggMiaQw+pJMuhCiNE/wH1HN+HniUK3Y6tIhgmU18F7pjpFzvz3tyLJwnXH
	 bPcgEdttoTDou/hvRwb18MH5G8VfVCwFwR4unMDvC/eL3prjSCP5IT/M0yhiXxsW+a
	 4ohclJIjSX4hM9M7e0KYosvVX06mv44mRZE/vwlO8eHmJMUlVyFC9UCPjuLMDplDFF
	 7Ra7MWtoIz9NQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so1451012a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 01:51:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywe6+klayCdkrMfQJC5s8fmfqHwg8AkhNFzRfXBAW5w+2Nt6zV3
	gOpBmWb3C1Q6uucpTA6xNTVNkKhgKM1T4ksv7kVW+6iSusk2GPPlFYT0jv8gV17NrJ6DdHMTJMR
	OY+/iFbiZWe8CZJMxUEncfRAr+hs=
X-Google-Smtp-Source: AGHT+IFycc64QZ7xAY9LL1sAtXPEXOThpJ+7cizN2gF1my8d28dGuq/p2Ue2gxuV65QWjMelLpx+3KwiXKAInEHIEtw=
X-Received: by 2002:a17:907:c301:b0:a6f:5f5d:e924 with SMTP id
 a640c23a62f3a-a7245b4c9bcmr1190402666b.6.1719478311693; Thu, 27 Jun 2024
 01:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719462554.git.wqu@suse.com> <526ad2f2f231241f705af275e8d0ffc52c442e4f.1719462554.git.wqu@suse.com>
In-Reply-To: <526ad2f2f231241f705af275e8d0ffc52c442e4f.1719462554.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Jun 2024 09:51:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5CLM1JUz1MNRnDmVttqV0yZgNzOcgyG-rjEtBTqvF=2w@mail.gmail.com>
Message-ID: <CAL3q7H5CLM1JUz1MNRnDmVttqV0yZgNzOcgyG-rjEtBTqvF=2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: remove the extra_gfp parameter from btrfs_alloc_folio_array()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:32=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The function btrfs_alloc_folio_array() is only utilized in
> btrfs_submit_compressed_read() and no other location, and the only
> caller is not utilizing the @extra_gfp parameter.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/compression.c | 2 +-
>  fs/btrfs/extent_io.c   | 8 +++-----
>  fs/btrfs/extent_io.h   | 3 +--
>  3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 85eb2cadbbf6..a149f3659b15 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -609,7 +609,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *b=
bio)
>                 goto out_free_bio;
>         }
>
> -       ret2 =3D btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_fo=
lios, 0);
> +       ret2 =3D btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_fo=
lios);
>         if (ret2) {
>                 ret =3D BLK_STS_RESOURCE;
>                 goto out_free_compressed_pages;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c7a9284e45e1..dc416bad9ad8 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -667,24 +667,22 @@ static void end_bbio_data_read(struct btrfs_bio *bb=
io)
>  }
>
>  /*
> - * Populate every free slot in a provided array with folios.
> + * Populate every free slot in a provided array with folios using GFP_NO=
FS.
>   *
>   * @nr_folios:   number of folios to allocate
>   * @folio_array: the array to fill with folios; any existing non-NULL en=
tries in
>   *              the array will be skipped
> - * @extra_gfp:  the extra GFP flags for the allocation
>   *
>   * Return: 0        if all folios were able to be allocated;
>   *         -ENOMEM  otherwise, the partially allocated folios would be f=
reed and
>   *                  the array slots zeroed
>   */
> -int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio=
_array,
> -                           gfp_t extra_gfp)
> +int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio=
_array)
>  {
>         for (int i =3D 0; i < nr_folios; i++) {
>                 if (folio_array[i])
>                         continue;
> -               folio_array[i] =3D folio_alloc(GFP_NOFS | extra_gfp, 0);
> +               folio_array[i] =3D folio_alloc(GFP_NOFS, 0);
>                 if (!folio_array[i])
>                         goto error;
>         }
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 8b33cfea6b75..8364dcb1ace3 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -365,8 +365,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_hand=
le *trans,
>
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay,
>                            gfp_t extra_gfp);
> -int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio=
_array,
> -                           gfp_t extra_gfp);
> +int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio=
_array);
>
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  bool find_lock_delalloc_range(struct inode *inode,
> --
> 2.45.2
>
>

