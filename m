Return-Path: <linux-btrfs+bounces-11781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE40A447A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF517AFBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A6E19D884;
	Tue, 25 Feb 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crojf1xN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022221624D1
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503428; cv=none; b=YiO0McH1VlWKQhxaoQWAjGvh2dh0Sr3/FpEQKpJA//ZlEjnnOH/FCmzv2w2rZOLfx8g0UJo+89DaqIeWYyn8XY+losc2MbV/uUsoTOHeUv2OSVAgoEZAn0Iq/4Tne4sO3Qw+7H1YHCYk6HucgD46VekVS5TciS3bNP+4tereHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503428; c=relaxed/simple;
	bh=/wmzbgy7l8BvLeo86hsFbrIdOaBIQwHqmlpUDFB3kck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPJVmHUPCWKSpWfNYrB7ImQl3vFEZLsYCXCh9WsIDfVcnZmlbh+muW8LdPlxAs/WOVE3M5+cu7vCNYRpw6wtWMnci0Rq0oL3JlgVHk6Mk27lR/sxwjULjEoiNkytgxeyQZbMOIWJQPt3h/9/UI+UIf41JoCAQO0CdWgih5GllIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crojf1xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F04BC4CEE2
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503427;
	bh=/wmzbgy7l8BvLeo86hsFbrIdOaBIQwHqmlpUDFB3kck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=crojf1xN+JOezDV9RpXW+7ZcVXrHxao+Ux79DDCvZ0tZZ8azgXNCd9VIs7x0Izkjf
	 6F/OOGgxKjGvmLGeuvF3pDhse9LHPm+S3Ow5RHOH0Q58hL2i4ZKZTC/R0grdz2ZRkJ
	 ccZSZp4LUKB5IZih1bPr0YJ8uqUXJf0HcEdMoR9IsVwON1ERmiFrtvzheH9CM63gL4
	 +fKsx3/2K8P9lCchSkjvXNKckOJXPwAfM5H4JAA2K/T+8VOUr2ZSCeyORqrG5xI3wt
	 I9T8TJcRWVR6PHRAX7pdK7hAiHSKB8aacHS5gohs3CDGyNxjtGcC/5Souoofv8eaNk
	 j22woLPkvBlqw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb7520028bso786774366b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:10:27 -0800 (PST)
X-Gm-Message-State: AOJu0YylLlzdLfSz1UsYjgxs7DjG2yYiufVYBuYfils2eAC90Ws4xr6e
	UwSXGMhV240rcPGh4KgCWAPU3DtkJ5QmxFnveifXeH46fA/V7U+pjbKyraBlCH4jNBgYCgbNYmw
	P0YgYIKNEX759jGskKffOQf9a0QA=
X-Google-Smtp-Source: AGHT+IGWUNc6gNs+mb/GoYRbBU6rQdSjUE1MVQMvAqJojo18qUiauPFlwXwRi50qvEbVrLkj3KhJe5PJgl3oKdpcOdI=
X-Received: by 2002:a17:907:7d93:b0:ab7:e811:de74 with SMTP id
 a640c23a62f3a-abc09c27023mr2085683666b.35.1740503425878; Tue, 25 Feb 2025
 09:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <115f1044e9d341b8507cae894a7e2dece5f41445.1740354271.git.wqu@suse.com>
In-Reply-To: <115f1044e9d341b8507cae894a7e2dece5f41445.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 17:09:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7J6o7NJUizBNVqBMOBm=JPcwSFUUxW6aEK2u8kPRpYUA@mail.gmail.com>
X-Gm-Features: AWEUYZmdKSd8vXjAUlD6NANuo_m1puX-yNFyjlNjEr8qGkgDQPtQXFEJmUDkgJw
Message-ID: <CAL3q7H7J6o7NJUizBNVqBMOBm=JPcwSFUUxW6aEK2u8kPRpYUA@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: make btrfs_do_readpage() to do block-by-block read
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently if a btrfs has its block size (the older sector size) smaller
> than the page size, btrfs_do_readpage() will handle the range extent by
> extent, this is good for performance as it doesn't need to re-lookup the
> same extent map again and again.
> (Although __get_extent_map() already does extra cached em check, thus
> the optimization is not that obvious)
>
> This is totally fine and is a valid optimization, but it has an
> assumption that, there is no partial uptodate range in the page.
>
> Meanwhile there is an incoming feature, requiring btrfs to skip the full
> page read if a buffered write range covers a full block but not a full
> page.
>
> In that case, we can have a page that is partially uptodate, and the
> current per-extent lookup can not handle such case.
>
> So here we change btrfs_do_readpage() to do block-by-block read, this
> simplifies the following things:
>
> - Remove the need for @iosize variable
>   Because we just use sectorsize as our increment.
>
> - Remove @pg_offset, and calculate it inside the loop when needed
>   It's just offset_in_folio().
>
> - Use a for() loop instead of a while() loop
>
> This will slightly reduce the read performance for subpage cases, but for
> the future where we need to skip already uptodate blocks, it should still
> be worthy.
>
> For block size =3D=3D page size, this brings no performance change.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a6ffee6f6fd9..b3a4a94212c9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -947,9 +947,7 @@ static int btrfs_do_readpage(struct folio *folio, str=
uct extent_map **em_cached,
>         u64 last_byte =3D i_size_read(inode);
>         struct extent_map *em;
>         int ret =3D 0;
> -       size_t pg_offset =3D 0;
> -       size_t iosize;
> -       size_t blocksize =3D fs_info->sectorsize;
> +       const size_t blocksize =3D fs_info->sectorsize;
>
>         ret =3D set_folio_extent_mapped(folio);
>         if (ret < 0) {
> @@ -960,24 +958,23 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>         if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
>                 size_t zero_offset =3D offset_in_folio(folio, last_byte);
>
> -               if (zero_offset) {
> -                       iosize =3D folio_size(folio) - zero_offset;
> -                       folio_zero_range(folio, zero_offset, iosize);
> -               }
> +               if (zero_offset)
> +                       folio_zero_range(folio, zero_offset,
> +                                        folio_size(folio) - zero_offset)=
;
>         }
>         bio_ctrl->end_io_func =3D end_bbio_data_read;
>         begin_folio_read(fs_info, folio);
> -       while (cur <=3D end) {
> +       for (cur =3D start; cur <=3D end; cur +=3D blocksize) {

While here, we can also declare the variable 'cur' in the for loop
instead of being at the top scope, since it's not used outside the
loop.

Either way, it looks good:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                 enum btrfs_compression_type compress_type =3D BTRFS_COMPR=
ESS_NONE;
> +               unsigned long pg_offset =3D offset_in_folio(folio, cur);
>                 bool force_bio_submit =3D false;
>                 u64 disk_bytenr;
>                 u64 block_start;
>
>                 ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
>                 if (cur >=3D last_byte) {
> -                       iosize =3D folio_size(folio) - pg_offset;
> -                       folio_zero_range(folio, pg_offset, iosize);
> -                       end_folio_read(folio, true, cur, iosize);
> +                       folio_zero_range(folio, pg_offset, end - cur + 1)=
;
> +                       end_folio_read(folio, true, cur, end - cur + 1);
>                         break;
>                 }
>                 em =3D get_extent_map(BTRFS_I(inode), folio, cur, end - c=
ur + 1, em_cached);
> @@ -991,8 +988,6 @@ static int btrfs_do_readpage(struct folio *folio, str=
uct extent_map **em_cached,
>
>                 compress_type =3D extent_map_compression(em);
>
> -               iosize =3D min(extent_map_end(em) - cur, end - cur + 1);
> -               iosize =3D ALIGN(iosize, blocksize);
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE)
>                         disk_bytenr =3D em->disk_bytenr;
>                 else
> @@ -1050,18 +1045,13 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
>
>                 /* we've found a hole, just zero and go on */
>                 if (block_start =3D=3D EXTENT_MAP_HOLE) {
> -                       folio_zero_range(folio, pg_offset, iosize);
> -
> -                       end_folio_read(folio, true, cur, iosize);
> -                       cur =3D cur + iosize;
> -                       pg_offset +=3D iosize;
> +                       folio_zero_range(folio, pg_offset, blocksize);
> +                       end_folio_read(folio, true, cur, blocksize);
>                         continue;
>                 }
>                 /* the get_extent function already copied into the folio =
*/
>                 if (block_start =3D=3D EXTENT_MAP_INLINE) {
> -                       end_folio_read(folio, true, cur, iosize);
> -                       cur =3D cur + iosize;
> -                       pg_offset +=3D iosize;
> +                       end_folio_read(folio, true, cur, blocksize);
>                         continue;
>                 }
>
> @@ -1072,12 +1062,9 @@ static int btrfs_do_readpage(struct folio *folio, =
struct extent_map **em_cached,
>
>                 if (force_bio_submit)
>                         submit_one_bio(bio_ctrl);
> -               submit_extent_folio(bio_ctrl, disk_bytenr, folio, iosize,
> +               submit_extent_folio(bio_ctrl, disk_bytenr, folio, blocksi=
ze,
>                                     pg_offset);
> -               cur =3D cur + iosize;
> -               pg_offset +=3D iosize;
>         }
> -
>         return 0;
>  }
>
> --
> 2.48.1
>
>

