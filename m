Return-Path: <linux-btrfs+bounces-12798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16BA7C14A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37693BCAA4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B32207A2A;
	Fri,  4 Apr 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aggxU+pe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F61207A1D
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783016; cv=none; b=gNd40LqpP+hT/79Dq8Lyuc2YPrAs0bNQgruzaazSKEzvKAYPJ98cO1Mh6JvOBq7wI0eVu1qSp44MwNnuRQGbbWykpw5zEEoTRkL8P9jaXF4HZQQm1/fh+ouD5by5s75Y0YzU109Cu8z+88dcGYhSm/6kwAh37W3+s6zzZaPXpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783016; c=relaxed/simple;
	bh=JOjCK0bpnwLowTsWSy1vYT/rvo2yXGQSr+GiPtotkRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl53T12uYCT17Hs4aR05kKA2KcNl6jbL/GXFrfUTUNf27YKSvgNR71mk7UXRj8m4GWoOQ40AwfGJnobXoZioG3lhOwU+aUsbGf7L9sIBpXEn317qVVu+PVckywRDocWD3BK65rF899L9ENtIbsutNf3K151zD1Dz/KMLA4d1+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aggxU+pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A98C4CEE9
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743783014;
	bh=JOjCK0bpnwLowTsWSy1vYT/rvo2yXGQSr+GiPtotkRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aggxU+pe4gEoe6ASujn5GSsvxX/19TNu+xnYr1aYdf9ygulIYf0RUca3GWvb0LItJ
	 FHAzvvdKIiDYuOJYBhoH0Y9ASnixvWS+85c5lt6m3z4DhzJm5buH1vxmO+WoAgP5zT
	 G8yYV35Gq4ZVAuCdjf/+z/c1UKwKFYXouUi1ZshycC1kMqEbOiRA/Fk27/ccwv6W6d
	 cddmOyEmLqpReEMGFN4pM5ZWm4O68BPmLpqsL414fU88eOc2ovhJh5mutl7EdIoOKz
	 WmlVF20aGsEHeBTaUOOcxvxL/AvTPUzm+P/J42zcIfllH7o2o1JYnb4ZVuOGq+Cjbb
	 IPQhitT3Tr0ig==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf3d64849dso344192166b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 09:10:14 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx5LtN+R0r0+LwKiUpkxTRMj3Qd3HHjAsOgv2eHKfAFLUUGboo4
	SZ2XnGXVMjdKUMaEVF3f+DGnMOfMrCerVb2SpdSahX9kX6DUTlqsH8Pc7qtR5zPHQggP/QfNuo7
	UjthN/65CeW6SnPogRulu+jGQ+0Y=
X-Google-Smtp-Source: AGHT+IHHDJ+vsvZ5khFSt1IRuUVX+tsyUqXWuRIpZFQmbCscdHr33tdfrh1vdrbczy/QpR9zfTaOLkZwcqgAE/t6Ht8=
X-Received: by 2002:a17:907:1b08:b0:abf:a387:7e35 with SMTP id
 a640c23a62f3a-ac7d19f4f50mr417971166b.53.1743783013002; Fri, 04 Apr 2025
 09:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743731232.git.wqu@suse.com> <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
In-Reply-To: <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 4 Apr 2025 16:09:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H76JoUMvQu=QWrSOrcQmpX4xyr0tNUmexpGR2iz06UX=g@mail.gmail.com>
X-Gm-Features: ATxdqUEvo67CIm_aa3bCCsnmSzVzvoG0peMgyVSSGLYVGZmk5ld5zG-3Tr3qWm4
Message-ID: <CAL3q7H76JoUMvQu=QWrSOrcQmpX4xyr0tNUmexpGR2iz06UX=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: use folio_contains() for EOF detection
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 2:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently we use the following pattern to detect if the folio contains
> the end of a file:
>
>         if (folio->index =3D=3D end_index)
>                 folio_zero_range();
>
> But that only works if the folio is page sized.
>
> For the following case, it will not work and leave the range beyond EOF
> uninitialized:
>
>   The page size is 4K, and the fs block size is also 4K.
>
>         16K        20K       24K
>         |          |     |   |
>                          |
>                          EOF at 22K
>
> And we have a large folio sized 8K at file offset 16K.
>
> In that case, the old "folio->index =3D=3D end_index" will not work, thus
> we the range [22K, 24K) will not be zeroed out.

thus we the range -> thus the range

>
> Fix the following call sites which use the above pattern:
>
> - add_ra_bio_pages()
>
> - extent_writepage()
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Otherwise it looks good, thanks.


> ---
>  fs/btrfs/compression.c | 2 +-
>  fs/btrfs/extent_io.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index cb954f9bc332..7aa63681f92a 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -523,7 +523,7 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>                 free_extent_map(em);
>                 unlock_extent(tree, cur, page_end, NULL);
>
> -               if (folio->index =3D=3D end_index) {
> +               if (folio_contains(folio, end_index)) {
>                         size_t zero_offset =3D offset_in_folio(folio, isi=
ze);
>
>                         if (zero_offset) {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 013268f70621..f0d51f6ed951 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_sp=
ace *mapping,
>  }
>
>  static noinline void unlock_delalloc_folio(const struct inode *inode,
> -                                          const struct folio *locked_fol=
io,
> +                                          struct folio *locked_folio,
>                                            u64 start, u64 end)
>  {
>         ASSERT(locked_folio);
> @@ -231,7 +231,7 @@ static noinline void unlock_delalloc_folio(const stru=
ct inode *inode,
>  }
>
>  static noinline int lock_delalloc_folios(struct inode *inode,
> -                                        const struct folio *locked_folio=
,
> +                                        struct folio *locked_folio,
>                                          u64 start, u64 end)
>  {
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> @@ -1711,7 +1711,7 @@ static int extent_writepage(struct folio *folio, st=
ruct btrfs_bio_ctrl *bio_ctrl
>                 return 0;
>         }
>
> -       if (folio->index =3D=3D end_index)
> +       if (folio_contains(folio, end_index))
>                 folio_zero_range(folio, pg_offset, folio_size(folio) - pg=
_offset);
>
>         /*
> --
> 2.49.0
>
>

