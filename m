Return-Path: <linux-btrfs+bounces-5117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846888CA0DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E1D1F218EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74D137916;
	Mon, 20 May 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="borw53+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E2E552
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223748; cv=none; b=blkk7zYXpyznFEem2EmRqH1ntRjiaqwim1NEJPM84IR7exkjcQAFe8Ax0Z/5yhNzFj0xpy5FEzztDLfXlCQooHQh9BB+2GWvX78YGcah+t3UuF7M5FVj5AoJ/Xi8Hcbp8uAcvfQWbK66ehO6X9VQFWWH1sRt4J2RvFJRoex0ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223748; c=relaxed/simple;
	bh=fb8chQ5lLaLqITPDko6NGnVuiFX7M7n9lhfyGR/2E50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+ft/0hjwtIIA4s/RX+OhJJiCeia/yVX7CJKwzU5v5CphD+9wHwCu4LdHPpVjdKkvs1YqCPJpoisE7PjkUJp/XLe3BETo9ejo0jA46xa9pC9GEH49qF+kTPeKi0vDRipHnPYtHvQjoaxE23d6tsQqUZeMaZJTt+8rCH2Xk1Aqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=borw53+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6632C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716223747;
	bh=fb8chQ5lLaLqITPDko6NGnVuiFX7M7n9lhfyGR/2E50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=borw53+hdU77LVbits7CXz7pDJfJE4wG5rDLYlbTbitscbjyE604RONfyiX3LHcLA
	 YEOhpWeEujleYQarlaAEU8Y7wz7m2azgMdGjeCAh3O2QrPXMd6MNSq46zQ+AxPNcBt
	 WMRcP4YfHhqKm+OMigRVx8JQmfDuaqAVLWcl7LvXDCkOegv+ak4WgFqMClNeu/wYKu
	 L6cPs1MquHsYJEJAJ1yYWVku9qNKW5LFOyQOqmF7jomqkS5lmhjH7eO65hRTNZwivj
	 A4NX5tOAAU3ruCaVLn4LmY881wWsG0JY97l3fAEjbSJ0f8fi2vzhHYe52o4f76o0pn
	 ABo3779mN4dOQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e538a264f7so39144081fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:49:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YwvW6gPgJZS48qxoZwYrdDelFFjZcxCj24sAoIxtxpAiaFtEd1i
	CoRST31ugcAGn/jfcrvy9rIAy/178Yk5kYCTini/M38pnyXLMdnpr9zou4i9R6GkFtggjDnNGOZ
	ccCX1OYoAbfcbAv5iskgo9HuZ4gc=
X-Google-Smtp-Source: AGHT+IGV9F+ZiIZ8HMI+I4lse6WHVf9y8Ur+4Qnwb/6UM0W2XYHtyOC+GScrjgwT9WAHiu81+fmtXM+GtbYeBdcjqGE=
X-Received: by 2002:a05:6512:110d:b0:523:dab3:3c with SMTP id
 2adb3069b0e04-523dab3009emr7252200e87.2.1716223746145; Mon, 20 May 2024
 09:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <8bdb1c42be16e32919b5e3e80aa6576c3a688d0d.1714707707.git.wqu@suse.com>
In-Reply-To: <8bdb1c42be16e32919b5e3e80aa6576c3a688d0d.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 17:48:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4UV7amCcXmxN-=FvW-gLHmm-T51qCnPUNbSDb_h1nF5Q@mail.gmail.com>
Message-ID: <CAL3q7H4UV7amCcXmxN-=FvW-gLHmm-T51qCnPUNbSDb_h1nF5Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] btrfs: cleanup duplicated parameters related to btrfs_create_dio_extent()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:03=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The following 3 parameters can be cleaned up using btrfs_file_extent
> structure:
>
> - len
>   btrfs_file_extent::num_bytes
>
> - orig_block_len
>   btrfs_file_extent::disk_num_bytes
>
> - ram_bytes
>   btrfs_file_extent::ram_bytes
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a95dc2333972..09974c86d3d1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6969,11 +6969,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_i=
node *inode,
>  static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *in=
ode,
>                                                   struct btrfs_dio_data *=
dio_data,
>                                                   const u64 start,
> -                                                 const u64 len,
> -                                                 const u64 orig_block_le=
n,
> -                                                 const u64 ram_bytes,
> -                                                 const int type,
> -                                                 struct btrfs_file_exten=
t *file_extent)
> +                                                 struct btrfs_file_exten=
t *file_extent,
> +                                                 const int type)
>  {
>         struct extent_map *em =3D NULL;
>         struct btrfs_ordered_extent *ordered;
> @@ -6991,7 +6988,7 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                 if (em) {
>                         free_extent_map(em);
>                         btrfs_drop_extent_map_range(inode, start,
> -                                                   start + len - 1, fals=
e);
> +                                       start + file_extent->num_bytes - =
1, false);
>                 }
>                 em =3D ERR_CAST(ordered);
>         } else {
> @@ -7034,10 +7031,9 @@ static struct extent_map *btrfs_new_extent_direct(=
struct btrfs_inode *inode,
>         file_extent.ram_bytes =3D ins.offset;
>         file_extent.offset =3D 0;
>         file_extent.compression =3D BTRFS_COMPRESS_NONE;
> -       em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
,
> -                                    ins.offset,
> -                                    ins.offset, BTRFS_ORDERED_REGULAR,
> -                                    &file_extent);
> +       em =3D btrfs_create_dio_extent(inode, dio_data, start,
> +                                    &file_extent,
> +                                    BTRFS_ORDERED_REGULAR);

As we're changing this, we can leave this in a single line as it fits.

>         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>         if (IS_ERR(em))
>                 btrfs_free_reserved_extent(fs_info, ins.objectid, ins.off=
set,
> @@ -7404,10 +7400,8 @@ static int btrfs_get_blocks_direct_write(struct ex=
tent_map **map,
>                 }
>                 space_reserved =3D true;
>
> -               em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
> -                                             file_extent.disk_num_bytes,
> -                                             file_extent.ram_bytes, type=
,
> -                                             &file_extent);
> +               em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start,
> +                                             &file_extent, type);

Same here.

The rest looks good, thanks.

>                 btrfs_dec_nocow_writers(bg);
>                 if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
>                         free_extent_map(em);
> --
> 2.45.0
>
>

