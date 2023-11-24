Return-Path: <linux-btrfs+bounces-340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5747F7317
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 12:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3377CB213D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EFE2031B;
	Fri, 24 Nov 2023 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO1Ppxlq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A33200B2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 11:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EF2C433C8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700826694;
	bh=CkqgSFyUop0dJvUH8OW8l5peS9YqT4ozJcMLkclxAzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fO1PpxlqtyfwxEWneQrnksYigUbc6CvRGVPBCrteDO+8wKgSdAi5M1oUu99oxAeZo
	 hvCfK0eF0MBu6Z4P5LQbHWZwKuTpsAbx9fTebSk4yUY4r6PJgiCycJ54XC1Ck5rpQQ
	 j9ugiA24O+pcdYPqDpDz8donKphcyN6b5QXZ2T/Cde0thF8TdiPkWsG20bOSY/BR/6
	 JydDFY2VjvFj0v4lacJleW6/uccDBWHnNQMZRww8eQuTciiUF0SMKuxqvN5KAZr4pg
	 n57b1ofrdzEbMtI9HnUfBAg3o1wOO5pOcqJGz81KR3huK/oDvoPPp/vxWjkwATPdil
	 KBbXFXLGfL5nw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a06e59384b6so205035866b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 03:51:34 -0800 (PST)
X-Gm-Message-State: AOJu0YxifsfcK3s5prIgsMcN2S5f4IDv/ufnLvj+veByG/wGPemMQQtR
	JQMdCwyBVLFNUB9ApisidukdD/I2eH86zo2QJC4=
X-Google-Smtp-Source: AGHT+IFL0BOCtPNe40H/7TIllwGUcd5hrdrOf2ueqeA1wqs/wqM7bQjaYrw4oiHUVHFLgf36WCAN5aCu0EBbP5FdHgc=
X-Received: by 2002:a17:906:2306:b0:9e4:b664:baa8 with SMTP id
 l6-20020a170906230600b009e4b664baa8mr1932134eja.7.1700826692573; Fri, 24 Nov
 2023 03:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
In-Reply-To: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Nov 2023 11:50:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
Message-ID: <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: free the allocated memory if btrfs_alloc_page_array()
 failed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 4:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If btrfs_alloc_page_array() failed to allocate all pages but part of the
> slots, then the partially allocated pages would be leaked in function
> btrfs_submit_compressed_read().
>
> [CAUSE]
> As explicitly stated, if btrfs_alloc_page_array() returned -ENOMEM,
> caller is responsible to free the partially allocated pages.
>
> For the existing call sites, most of them are fine:
>
> - btrfs_raid_bio::stripe_pages
>   Handled by free_raid_bio().
>
> - extent_buffer::pages[]
>   Handled btrfs_release_extent_buffer_pages().
>
> - scrub_stripe::pages[]
>   Handled by release_scrub_stripe().
>
> But there is one exception in btrfs_submit_compressed_read(), if
> btrfs_alloc_page_array() failed, we didn't cleanup the array and freed
> the array pointer directly.
>
> Initially there is still the error handling in commit dd137dd1f2d7
> ("btrfs: factor out allocating an array of pages"), but later in commit
> 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio"),
> the error handling is removed, leading to the possible memory leak.
>
> [FIX]
> This patch would add back the error handling first, then to prevent such
> situation from happening again, also make btrfs_alloc_page_array() to
> free the allocated pages as a extra safe net.
>
> Fixes: 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio=
")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/compression.c |  4 ++++
>  fs/btrfs/extent_io.c   | 10 +++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 19b22b4653c8..d6120741774b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -534,6 +534,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio *=
bbio)
>         return;
>
>  out_free_compressed_pages:
> +       for (int i =3D 0; i < cb->nr_pages; i++) {
> +               if (cb->compressed_pages[i])
> +                       __free_page(cb->compressed_pages[i]);
> +       }
>         kfree(cb->compressed_pages);
>  out_free_bio:
>         bio_put(&cb->bbio.bio);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0ea65f248c15..e2c0c596bd46 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -676,8 +676,7 @@ static void end_bio_extent_readpage(struct btrfs_bio =
*bbio)
>   *             the array will be skipped
>   *
>   * Return: 0        if all pages were able to be allocated;
> - *         -ENOMEM  otherwise, and the caller is responsible for freeing=
 all
> - *                  non-null page pointers in the array.
> + *         -ENOMEM  otherwise, and the partially allocated pages would b=
e freed.
>   */
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_arr=
ay)
>  {
> @@ -696,8 +695,13 @@ int btrfs_alloc_page_array(unsigned int nr_pages, st=
ruct page **page_array)
>                  * though alloc_pages_bulk_array() falls back to alloc_pa=
ge()
>                  * if  it could not bulk-allocate. So we must be out of m=
emory.
>                  */
> -               if (allocated =3D=3D last)
> +               if (allocated =3D=3D last) {
> +                       for (int i =3D 0; i < allocated; i++) {
> +                               __free_page(page_array[i]);
> +                               page_array[i] =3D NULL;
> +                       }
>                         return -ENOMEM;
> +               }
>
>                 memalloc_retry_wait(GFP_NOFS);
>         }
> --
> 2.42.1
>
>

