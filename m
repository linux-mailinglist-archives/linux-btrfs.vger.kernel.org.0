Return-Path: <linux-btrfs+bounces-13834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16732AAFC50
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C47C4A8468
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601723A58B;
	Thu,  8 May 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4nUqglZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F449238C29
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713009; cv=none; b=RoQBsDbywhdNV/dDsH5MwSnqcHlnSMItbZ34lBBoZNYlF2/NHiw6b4fsccLVNqAwvcIM+L2BZH5V9eIGcTNlPIL5HV6xPf3FoGpWpzehYG53tqXDkogZzMWNlAe7gJ7E8f3aQRjwU1TmVOP6uNq4Ngg9lZOnnvhGMHg/3/s5GQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713009; c=relaxed/simple;
	bh=Ogmk4CKu+BXv9spcjOQYEa3G40MSy3PmjB3Z1na8XCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRd9ccsVTooLB09HwdzPsDlhpqIe97jJrccEKS81kSVEaPyi6Fd/nYY81H4uK6tA/6jLspcCsZ73SpDp0ceroaB7VGI0RYoIUAZpVLXXBbn/qhWKBr2tU6tg/N2owie/mD5dmd3q57ussrQWYoDwQ9xlu1m2gfc0bwr0sDKxHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4nUqglZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F2CC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746713008;
	bh=Ogmk4CKu+BXv9spcjOQYEa3G40MSy3PmjB3Z1na8XCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g4nUqglZKhqywHnnTzbDoVlKK07DTMI/+rg4iP0GQi3aZz/VBqYBz30xvFs2XZYPq
	 KjIarGHqXN/NaoGUS8CmQoTWRaoNTQus7uViPVc6aomUgL/kmzGYmK/7+tibJOU8/H
	 QOGZOhBJxQzYirAfXyVnVILLy1VB5jWULamW9kl4hQJ8h+WP+v9Hsea5YQrvI4R0So
	 UuHby8m8N/m0OSDNqAo9zx0psdXCArZqbKMVIvAYzjiAXzk89eIJBYeWewQeVumCB5
	 7dLkUTsHi1WQxlA4mTz9FoIsAtVdNw9FIImXjqMlQHG2RbV2cVGZHBXorSETYzsYnU
	 BhBHWfasWuGCw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbf29d0ff1so1559162a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 07:03:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw7BPpFPr8PR8zKb8gtIBYQzu4D+8phy+Imq4kGm0M66dPLo6pY
	GNgjtmUITCR1VwYxxM4TzkpV26bS4lkjiEDwsU5lg4VeyZZ6TO3Cz0J/+EBJLoW3D9HD1NNgL8K
	dl39zBB+hNaXxrsMBdTSdfwCNQcA=
X-Google-Smtp-Source: AGHT+IEKYRcrTXeTMOb/HarIZfvEY4C8sVvcsfV/reugqzi+Yq90db0DYKBkbqcyN560ZJEM3D/4QCdtek8YVH4vVTo=
X-Received: by 2002:a17:907:9411:b0:ace:da0a:2882 with SMTP id
 a640c23a62f3a-ad1e8d9b5b3mr725237866b.54.1746713003354; Thu, 08 May 2025
 07:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9458a40fed8e6a27ada539372170d52c45967f0.1746652135.git.boris@bur.io>
In-Reply-To: <a9458a40fed8e6a27ada539372170d52c45967f0.1746652135.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 May 2025 15:02:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4tV-i95ORA91LPVBbgOVp8+Ym8=dBqn94+0KgFWiEWSQ@mail.gmail.com>
X-Gm-Features: ATxdqUGz9PNrW29MXRNBWpClFcjB6jujEcbs26Z2lATCpHlTrFEAeL4KuyACVOE
Message-ID: <CAL3q7H4tV-i95ORA91LPVBbgOVp8+Ym8=dBqn94+0KgFWiEWSQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix folio leak in submit_one_async_extent()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:08=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> If btrfs_reserve_extent() fails while submitting an async_extent for a
> compressed write, then we fail to call free_async_extent_pages() on the
> async_extent and leak its folios. A likely cause for such a failure
> would be btrfs_reserve_extent() failing to find a large enough
> contiguous free extent for the compressed extent.
>
> I was able to reproduce this by:
> 1. mount with compress-force=3Dzstd:3
> 2. fallocating most of a filesystem to a big file
> 3. fragmenting the remaining free space
> 4. trying to copy in a file which zstd would generate large compressed
> extents for (vmlinux worked well for this)
>
> Step 4. hits the memory leak and can be repeated ad nauseam to
> eventually exhaust the system memory.
>
> Fix this by detecting the case where we fallback to uncompressed
> submission for a compressed async_extent and ensuring that we call
> free_async_extent_pages().
>
> Fixes: 131a821a243f ("btrfs: fallback if compressed IO fails for ENOSPC")
> Co-authored-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2666b0f73452..9d4b99ba8950 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1092,6 +1092,7 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>         struct extent_state *cached =3D NULL;
>         struct extent_map *em;
>         int ret =3D 0;
> +       bool free_pages =3D false;
>         u64 start =3D async_extent->start;
>         u64 end =3D async_extent->start + async_extent->ram_size - 1;
>
> @@ -1112,6 +1113,8 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>         }
>
>         if (async_extent->compress_type =3D=3D BTRFS_COMPRESS_NONE) {
> +               ASSERT(!async_extent->folios);
> +               ASSERT(!async_extent->nr_folios);

It wouldn't hurt to still set free_pages to true in this case.
This is just to be safe and prevent leaks in case running on a kernel
with CONFIG_BTRFS_DEBUG not set - which several distros do like Debian
for example (since the Kconfg says this setting is meant for
developers).

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                 submit_uncompressed_range(inode, async_extent, locked_fol=
io);
>                 goto done;
>         }
> @@ -1128,6 +1131,7 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>                  * fall back to uncompressed.
>                  */
>                 submit_uncompressed_range(inode, async_extent, locked_fol=
io);
> +               free_pages =3D true;
>                 goto done;
>         }
>
> @@ -1169,6 +1173,8 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>  done:
>         if (async_chunk->blkcg_css)
>                 kthread_associate_blkcg(NULL);
> +       if (free_pages)
> +               free_async_extent_pages(async_extent);
>         kfree(async_extent);
>         return;
>
> --
> 2.49.0
>
>

