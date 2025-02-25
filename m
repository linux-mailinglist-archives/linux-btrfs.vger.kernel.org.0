Return-Path: <linux-btrfs+bounces-11775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B6A443EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 16:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB401885601
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0326BD80;
	Tue, 25 Feb 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umNrn5N0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAF3A27B
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496073; cv=none; b=OpaQNUSkMylKS7ovAIYR5CDjgHBfloQnczD3mvusDf2N8v2yRrP4s6/wfIysKjj9++2HglOyI62hhJjb8O03fhiKpKTxIEBfdyrdUcVexnmiU4XQ/+KHIxy4cGZasqWNeiXFvBzwGLZg9pKTvzkTkrWkxEmu4eX7zjJL/DEBcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496073; c=relaxed/simple;
	bh=YqQekZA+sD9a8v9bnUlB3nhDDimnHeziSR7SUwOUqbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX1r++9WeOpyBZYyFsYoaE3NkGJT9ROuo90NSiFfsOoUl54IOm1AC4riV0Jw6fZRlmm0sEUbelFbGDl/Jmzd+3IDfe/RHrO31jsZ+i0L7IpWaAfeP/gVHtuwnqhA1UvbrTiFs6TQKGKgIHhJWeLxvm0uH3kbY2bZiPW2SGtssag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umNrn5N0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34414C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496072;
	bh=YqQekZA+sD9a8v9bnUlB3nhDDimnHeziSR7SUwOUqbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=umNrn5N0YZPyOYkAGRJxTuLtLEpv1x3sJ8C94ioS11ztetvg88X7l7QfbAfv81It/
	 Ab0b72K8S9IX3R27xwp4z71fvxm82V/i3xTlyINo2CmwCBMOc0kip7GUyMDmt5SJ4Y
	 5JlZRBv5mBWarll3HQECPsEoMcOJcaKWjx9KeN2J6KDtQKj6SINuw4JDUz4399v2dI
	 MYGq0VNba74EaV4OYIo4Z6EnBM/rpYLsnYSKPN+WwZ/Tjhl2aKHFuntg1+AVGq2yhZ
	 JwkuggOSpo0Ca2xf5to4vi1OsSEYRNysWKdarDwa++a9yLXl9gPHvVUQd28CvwykLu
	 SukR6yMQJZP8g==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so12107580a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 07:07:52 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8jmzYZnR/cKM9G2iqsxIEawd8t/iuHlzEjn0WgcxWWUUY5hl9
	vG+GMvrQUcrX8YVgOz3bE86gLPTvcOxc2znMNwd/P7eKrcuPToyCUsEAazUdYQt+RvjnD2MD5m6
	FbkItSPJxGN22GoVhKhEGDld+qfE=
X-Google-Smtp-Source: AGHT+IEfD8+u9I+Xm9xS5JBTJlHKaqr2BWxtqANvcvQk/OXyvFZjXkpqy7eZKh4ulV9tMN0wP0vS+kG4R1RMLUsamqQ=
X-Received: by 2002:a17:906:318b:b0:ab7:b7b5:2a0c with SMTP id
 a640c23a62f3a-abc0ae1b6e9mr1438490066b.6.1740496070780; Tue, 25 Feb 2025
 07:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <31a8b02ec99fd3bf6399b7f543ef6de786665fd2.1740354271.git.wqu@suse.com>
In-Reply-To: <31a8b02ec99fd3bf6399b7f543ef6de786665fd2.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 15:07:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5D7zmdAQwmnb3c6wWyUO9gG=op7f+EHgWW6wha8AcL-Q@mail.gmail.com>
X-Gm-Features: AWEUYZnB0uZ6J8yInoLOiRp2UvWJA4dtFhxNIet90tOkkU6WKlPdR2sH3jV-Zys
Message-ID: <CAL3q7H5D7zmdAQwmnb3c6wWyUO9gG=op7f+EHgWW6wha8AcL-Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] btrfs: prevent inline data extents read from touching
 blocks beyond its range
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:46=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently reading an inline data extent will zero out all the remaining
> range in the page.
>
> This is not yet causing problems even for block size < page size
> (subpage) cases because:
>
> 1) An inline data extent always starts at file offset 0
>    Meaning at page read, we always read the inline extent first, before
>    any other blocks in the page. Then later blocks are properly read out
>    and re-fill the zeroed out ranges.
>
> 2) Currently btrfs will read out the whole page if a buffered write is
>    not page aligned
>    So a page is either fully uptodate at buffered write time (covers the
>    whole page), or we will read out the whole page first.
>    Meaning there is nothing to lose for such an inline extent read.
>
> But it's still not ideal:
>
> - We're zeroing out the page twice
>   One done by read_inline_extent()/uncompress_inline(), one done by
>   btrfs_do_readpage() for ranges beyond i_size.
>
> - We're touching blocks that doesn't belong to the inline extent
>   In the incoming patches, we can have a partial uptodate folio, that
>   some dirty blocks can exist while the page is not fully uptodate:
>
>   The page size is 16K and block size is 4K:
>
>   0         4K        8K        12K        16K
>   |         |         |/////////|          |
>
>   And range [8K, 12K) is dirtied by a buffered write, the remaining
>   blocks are not uptodate.
>
>   If range [0, 4K) contains an inline data extent, and we try to read
>   the whole page, the current behavior will overwrite range [8K, 12K)
>   with zero and cause data loss.
>
> So to make the behavior more consistent and in preparation for future
> changes, limit the inline data extents read to only zero out the range
> inside the first block, not the whole page.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c432ccfba56e..fe2c6038064a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6788,6 +6788,7 @@ static noinline int uncompress_inline(struct btrfs_=
path *path,
>  {
>         int ret;
>         struct extent_buffer *leaf =3D path->nodes[0];
> +       const u32 sectorsize =3D leaf->fs_info->sectorsize;
>         char *tmp;
>         size_t max_size;
>         unsigned long inline_size;
> @@ -6816,17 +6817,19 @@ static noinline int uncompress_inline(struct btrf=
s_path *path,
>          * cover that region here.
>          */
>
> -       if (max_size < PAGE_SIZE)
> -               folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
> +       if (max_size < sectorsize)
> +               folio_zero_range(folio, max_size, sectorsize - max_size);
>         kfree(tmp);
>         return ret;
>  }
>
> -static int read_inline_extent(struct btrfs_path *path, struct folio *fol=
io)
> +static int read_inline_extent(struct btrfs_fs_info *fs_info,
> +                             struct btrfs_path *path, struct folio *foli=
o)
>  {
>         struct btrfs_file_extent_item *fi;
>         void *kaddr;
>         size_t copy_size;
> +       const u32 sectorsize =3D fs_info->sectorsize;

There's no need to add the fs_info argument just to get the sectorsize.
We can get it like this:

const u32 sectorsize =3D path->nodes[0]->fs_info->sectorsize;

Otherwise it looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.



>
>         if (!folio || folio_test_uptodate(folio))
>                 return 0;
> @@ -6844,8 +6847,8 @@ static int read_inline_extent(struct btrfs_path *pa=
th, struct folio *folio)
>         read_extent_buffer(path->nodes[0], kaddr,
>                            btrfs_file_extent_inline_start(fi), copy_size)=
;
>         kunmap_local(kaddr);
> -       if (copy_size < PAGE_SIZE)
> -               folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size)=
;
> +       if (copy_size < sectorsize)
> +               folio_zero_range(folio, copy_size, sectorsize - copy_size=
);
>         return 0;
>  }
>
> @@ -7020,7 +7023,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>                 ASSERT(em->disk_bytenr =3D=3D EXTENT_MAP_INLINE);
>                 ASSERT(em->len =3D=3D fs_info->sectorsize);
>
> -               ret =3D read_inline_extent(path, folio);
> +               ret =3D read_inline_extent(fs_info, path, folio);
>                 if (ret < 0)
>                         goto out;
>                 goto insert;
> --
> 2.48.1
>
>

