Return-Path: <linux-btrfs+bounces-19619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED2CB278E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD8873099D35
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5D2C15B0;
	Wed, 10 Dec 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7He0Bvn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4F194A6C
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357010; cv=none; b=jCOoxuAVwan6g7BWBERQvQekCXbrJtniLWtZJ8y228UVcWe+zfBsTVawyQMICPf7M0/dOG2ZTsfm+utBWkCjbcPt10u7yZ5aD9d7Bj6395GFmUwygg49wuiYtb7q7IwjVoY6Ukio3/8QLksLMEQTa5CtaiHWMT+TnPJ0yyQukiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357010; c=relaxed/simple;
	bh=UHuN3iLY1cXN0pdLxecS81CT3dPJ8TwUcS2BgPIecaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md0RXBQKktvj6kRPd6tTOV3EuRmrBWv0c5kUyDBRyepZQ1Z7NR2keMdjbZyubKAqhQlhGn+jXEiSNtgQoxJrcmPKKdylPsQBV8k+4YRM8HCtwDLSleb86IFt+YbYQZQSOMIZdRL33zkOU8AyK/1GkgF5my6HOOpEOXLU3Rg8aaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7He0Bvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A85C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765357009;
	bh=UHuN3iLY1cXN0pdLxecS81CT3dPJ8TwUcS2BgPIecaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q7He0BvnuluhrM858kAQuDCn6xPfo8Se5W/278A/jbHQuDnC2A53pl3kluw8Bb6ZX
	 dyrDKEY3y/sD+ZBo3UVrRyjf0F0zQDOaZd285yFyui/VwolmZoA0rnE6BBkGkVQY+V
	 FEQOL8VVvbwJSGNGZbPcDweDFsfB7bCZ1vA87ooayA5mUsgARayszZrKZHg1K1MJFj
	 EKaRXZ9lQmXONDVSoO64LnKc/7v7UYxomZ+fuLQozG8WibdJm66MtR98sYwGyWSsAi
	 /s1ngMcMejGkZs9cFZJW9ieK/5hkK5gw1eS058d6yEoU3m+hcO7FKw7b+Ti6ZuvrRl
	 gfLR6rsJLfmEQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so303284266b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 00:56:49 -0800 (PST)
X-Gm-Message-State: AOJu0YzYhXnz9p+9knfaAY2ZzRXl3qqsBMyiGpBg/FTLMA8tgZYo+YZa
	chU1Fxopc1EVTqFJla+IH5SBUlGz7OnguJJPWufaTEYjnVJVufgZopzgVfwMAWBwILtc0uPsadV
	7tZuIdfjE2DUtJbFBFpsNFqBsQqGn808=
X-Google-Smtp-Source: AGHT+IFXrSoaZqtFUOqwmKSCay008If1XE7jf25NfBEm4WoYdexbWz3Wz+z3K8WXK5gBpl23CZihtlssnEC+EN4h/j4=
X-Received: by 2002:a17:907:9690:b0:b7c:532b:cc99 with SMTP id
 a640c23a62f3a-b7ce844815emr148614666b.46.1765357007964; Wed, 10 Dec 2025
 00:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d0cc7c454a8cb80219ab4c218fa73843ff5f809.1764131228.git.wqu@suse.com>
In-Reply-To: <2d0cc7c454a8cb80219ab4c218fa73843ff5f809.1764131228.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Dec 2025 08:56:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7q783cixa=8njX4Zc_sPQ6D-exmK1fph7X_unj_XyQGg@mail.gmail.com>
X-Gm-Features: AQt7F2qCBHKeSmACPuiEkNvWi80nuwB4ofZI_k08Uzi_74GDP1STPmSVr5mNAKo
Message-ID: <CAL3q7H7q783cixa=8njX4Zc_sPQ6D-exmK1fph7X_unj_XyQGg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: search for larger extent maps inside btrfs_do_readpage()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [CORNER CASE]
> If we have the following file extents layout, btrfs_get_extent() can
> return a smaller hole during read, and cause unnecessary extra tree
> searches:
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13631488 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>
>         item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13635584 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>
> In above case, range [0, 4K) and [32K, 36K) are regular extents, and
> there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
> meaning the hole will not have a file extent item.
>
> [INEFFICIENCY]
> Assume the system has 4K page size, and we're doing readahead for range
> [4K, 32K), no large folio yet.
>
>  btrfs_readahead() for range [4K, 32K)
>  |- btrfs_do_readpage() for folio 4K
>  |  |- get_extent_map() for range [4K, 8K)
>  |     |- btrfs_get_extent() for range [4K, 8K)
>  |        We hit item 6, then for the next item 7.
>  |        At this stage we know range [4K, 32K) is a hole.
>  |        But our search range is only [4K, 8K), not reaching 32K, thus
>  |        we go into not_found: tag, returning a hole em for [4K, 8K).
>  |
>  |- btrfs_do_readpage() for folio 8K
>  |  |- get_extent_map() for range [8K, 12K)
>  |     |- btrfs_get_extent() for range [8K, 12K)
>  |        We hit the same item 6, and then item 7.
>  |        But still we goto not_found tag, inserting a new hole em,
>  |        which will be merged with previous one.
>  |
>  | [ Repeat the same btrfs_get_extent() calls until the end ]
>
> So we're calling btrfs_get_extent() again and again, just for a
> different part of the same hole range [4K, 32K).
>
> [ENHANCEMENT]
> Make btrfs_do_readpage() to search for a larger extent map if readahead
> is involved.
>
> For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents for
> the whole readahead range.
>
> If we find bio_ctrl::ractl is set, we can use that end range as extent
> map search end, this allows btrfs_get_extent() to return a much larger
> hole, thus reduce the need to call btrfs_get_extent() again and again.
>
>  btrfs_readahead() for range [4K, 32K)
>  |- btrfs_do_readpage() for folio 4K
>  |  |- get_extent_map() for range [4K, 32K)
>  |     |- btrfs_get_extent() for range [4K, 32K)
>  |        We hit item 6, then for the next item 7.
>  |        At this stage we know range [4K, 32K) is a hole.
>  |        So the hole em for range [4K, 32K) is returned.
>  |
>  |- btrfs_do_readpage() for folio 8K
>  |  |- get_extent_map() for range [8K, 32K)
>  |     The cached hole em range [4K, 32K) covers the range,
>  |     and reuse that em.
>  |
>  | [ Repeat the same btrfs_get_extent() calls until the end ]
>
> Now we only call btrfs_get_extent() once for the whole range [4K, 32K),
> other than the old 8 times.
>
> Although again I do not expect much difference for the real world
> performance.

Why don't you measure it?

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2d32dfc34ae3..c8c8d3659135 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -997,6 +997,8 @@ static int btrfs_do_readpage(struct folio *folio, str=
uct extent_map **em_cached,
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>         u64 start =3D folio_pos(folio);
>         const u64 end =3D start + folio_size(folio) - 1;
> +       const u64 locked_end =3D bio_ctrl->ractl ? (readahead_pos(bio_ctr=
l->ractl) +
> +                              readahead_length(bio_ctrl->ractl) - 1) : e=
nd;

This is a rather long expression, it's more readable with an if-else statem=
ent.

Thanks.

>         u64 extent_offset;
>         u64 last_byte =3D i_size_read(inode);
>         struct extent_map *em;
> @@ -1036,7 +1038,14 @@ static int btrfs_do_readpage(struct folio *folio, =
struct extent_map **em_cached,
>                         end_folio_read(folio, true, cur, blocksize);
>                         continue;
>                 }
> -               em =3D get_extent_map(BTRFS_I(inode), folio, cur, end - c=
ur + 1, em_cached);
> +               /*
> +                * Search extent map for the whole locked range.
> +                * This will allow btrfs_get_extent() to return a larger =
hole
> +                * when possible.
> +                * This can reduce duplicated btrfs_get_extent() calls fo=
r large
> +                * holes.
> +                */
> +               em =3D get_extent_map(BTRFS_I(inode), folio, cur, locked_=
end - cur + 1, em_cached);
>                 if (IS_ERR(em)) {
>                         end_folio_read(folio, false, cur, end + 1 - cur);
>                         return PTR_ERR(em);
> --
> 2.52.0
>
>

