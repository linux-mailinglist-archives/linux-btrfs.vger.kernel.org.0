Return-Path: <linux-btrfs+bounces-19653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB5CB59A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90E9530141F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43D306485;
	Thu, 11 Dec 2025 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0z0WpSO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4120013A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451274; cv=none; b=cwIj4oJrpynJt7aGBNCT9PYecsgY+ejqHVcVrRRs2mQ0zyYOlCjx1e0PyuY5meUtFeAk3i4A5eqvtSkthI3sZCuYnihQKQo2RlIh2s4T6Z/3yjn+4waq2EQCE+uqj1AJEXM+9j6fL5mWjW1WLdKYdBBd8F2Z/iTAUpmWl1418Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451274; c=relaxed/simple;
	bh=UwuhffC6zEYvtSq/sjqsesqb7Y8rUaFeQR+yAvHWaJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br6G8xVY8nzKL7S/cPFxYHmsm0fqh+jofPmLnvUeOq65h4FNa++hWA4WKQJ0Bk1HBVX3HtOS/XH7Kb9l7i0XwNqX8tUxQH6RSvtyHksKxyNnKQYa8yHRoWmFMBTFyN1wWUy0eM22h4FIocrlrObJ13Sej3ahavXFhad23CVYEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0z0WpSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D3C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765451274;
	bh=UwuhffC6zEYvtSq/sjqsesqb7Y8rUaFeQR+yAvHWaJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W0z0WpSOWaJ7QEkJsfyRL3kh+GfiYu4q8woTWNeD78U+Bn69FmwYtpDhWVZi4vOR8
	 k7nNTDiMRwxBCbik1aMQIRgEIpXr5TQpnvLa4weY7FhoRgsN1A3sF2UG5KK2d7UbIp
	 0acbJ7NUvAVSPgEjaM5oLfUWAxeOerC2Oi/9m2a0vMdqwibaQzqvIQhqIfGhJ0ZCpJ
	 DT1TqW685lDI+ly4YrfKRbgIQ5kBMXKqYB8jWsYPQCqrlj7pZwtMBLYZ90fcPFf0w9
	 jDHo9FTBoGSsM62ZnUhAEQnvFf2Tf/poUpOj8DENevMj1ig5zIZ1i8NiyfnREwa8q8
	 s5A0nzgam0Z9Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7bd8b170e0so98196266b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 03:07:54 -0800 (PST)
X-Gm-Message-State: AOJu0YzoV4xzv9u1OE0Rz7UIgfDM4VHJq1okYkrx3dNaqYT1qLPLkqpN
	jWfyz+kbU7Kh7HGytus/5+94JotE0itD56TAiMo8IlGXhFxRslqi+54YVwdEESk6o1IAUJKDhBu
	s0b4wBVRp9MXwIyZJBSfJyYGi5ASmnOc=
X-Google-Smtp-Source: AGHT+IEU+0/APio4tAwhm+9J48N7uA2CE6Vh/HV4lQS6YhoJHn5zX5xYxmRqdrujanUXtuaHA6XdimN5WksfbJUFYZ4=
X-Received: by 2002:a17:907:3f89:b0:b73:6f8c:6127 with SMTP id
 a640c23a62f3a-b7ce82091e7mr607313966b.12.1765451272720; Thu, 11 Dec 2025
 03:07:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
In-Reply-To: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Dec 2025 11:07:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7em9=ew5Tt0qkeyB-XvQYRiLJOoaG8JggKBtOudbF8Sg@mail.gmail.com>
X-Gm-Features: AQt7F2r5SQp1nobqvgxrb4PaH3K4V2Yr-hrMaWl0fcmxb7zwfvUm07cQtZELZJo
Message-ID: <CAL3q7H7em9=ew5Tt0qkeyB-XvQYRiLJOoaG8JggKBtOudbF8Sg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: search for larger extent maps inside btrfs_do_readpage()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 6:26=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> Such change will reduce the overhead of reading large holes a little.
> For current experimental build (with larger folios) on aarch64, there
> will be a tiny but consistent ~1% improvement reading a large hole file:
>
>  Reading a 1GiB sparse file (all hole) using xfs_io, with 64K block
>  size, the result is the time needed to read the whole file, reported
>  from xfs_io.
>
>  32 runs, experimental build (with large folios).
>
>  64K page size, 4K fs block size.
>
>  - Avg before: 0.20823 s
>  - Avg after:  0.20635 s
>  - Diff:   -0.9%
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> Changelog:
> v2:
> - Add a benchmark result for the enhancement
> - Use if () to assigned @locked_end
>   This drops the const prefix thought.
> ---
>  fs/btrfs/extent_io.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a4b74023618d..6caaf6b6fdce 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -998,11 +998,17 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>         u64 start =3D folio_pos(folio);
>         const u64 end =3D start + folio_size(folio) - 1;
>         u64 extent_offset;
> +       u64 locked_end;
>         u64 last_byte =3D i_size_read(inode);
>         struct extent_map *em;
>         int ret =3D 0;
>         const size_t blocksize =3D fs_info->sectorsize;
>
> +       if (bio_ctrl->ractl)
> +               locked_end =3D readahead_pos(bio_ctrl->ractl) + readahead=
_length(bio_ctrl->ractl) - 1;
> +       else
> +               locked_end =3D end;
> +
>         ret =3D set_folio_extent_mapped(folio);
>         if (ret < 0) {
>                 folio_unlock(folio);
> @@ -1036,7 +1042,14 @@ static int btrfs_do_readpage(struct folio *folio, =
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

