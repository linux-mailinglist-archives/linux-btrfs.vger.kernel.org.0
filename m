Return-Path: <linux-btrfs+bounces-3960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE2899CDD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33554B21517
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7291116C847;
	Fri,  5 Apr 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGLvRnZ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEB3EA90
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319991; cv=none; b=D04ZWUN1vvmldBbZgNsr98GTeYyiKMl1a2bWR3aQv8cU4e7MO2X18ESgAQaZHcGYv+4uK+mwK8iWQG+l8LDC9Y87/iL96K2SRqQ1y4TThDwWKnl8P79p5kaIR3qY3wZgcXWE0LKbCWiNuhoHSqbIKMeSc+Ih3+hDXFTKmamV3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319991; c=relaxed/simple;
	bh=pib0SsbM0+yOlEJAUYgv144VhsgwSVShQ8n1n4Ya+zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C00sdEKve8skVuiXBqn4PKduODxlDi6QhGOL3bmmM84ggWKQiU01pBYd6Obgq8BSwRWPI8QEEbOvDjxdnB1i2ljBGsf1WDBuDJSTfXO1Gq7caNGI4QqYAz9rX5D/86rsi75DS51pqntbwUOGST56Tn8O7ilaF6iG8/UlID4XqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGLvRnZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5115C433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712319990;
	bh=pib0SsbM0+yOlEJAUYgv144VhsgwSVShQ8n1n4Ya+zQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qGLvRnZ8Ocwdh5YbLJe7WRzYVB365H4IZciOlDW+spaddnmogwoz8BsF7HnIbFgWn
	 miK5YdF8zFKtMgzJpuh05fCVEn8ooAQVMroHB0pLdhsGYDlrwlJxpsFx/+mWY/SR6a
	 PgDH8dbRaZQKPk5KgkL+7xOXOS5hyJLgvpZ92nTFtKMYecY47PfsAArNKH5lWQBaoV
	 zOn5MTZGp3d83QmJWYjLXTtFwgh4htmYu/QrZt4wm0vpZEvI/5PwXy7lrIC806UNAr
	 7SfZtt1mCAw4K5NRLmyKPqz78Uvu0VAVphNjA5aFlPh8wuEC3V9l3x0LDBmY4nkRFk
	 m9helY/FQjaoQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d700beb60bso34431631fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 05:26:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YyahlUh83G06FzyXtoQlXOxbpbcB3+WLVECmoyr8dibToE5Jipr
	lWSmP+Oq2riu0l60YnTbn6aNq/Jfd6l3QKKopJiotroUZCzt73jSQmUZ8D613MLlRW7hc047WWM
	ZBrzs53pKQOdMq/92f5zROn4sZmc=
X-Google-Smtp-Source: AGHT+IFHjdzKG6MFf65FPL7s9BKylZaLfZJ/V32b/Px73ww8knmw/ElarY/zv7VyRTmJoPwInT3rJRgciK4YZ1SzU8w=
X-Received: by 2002:a2e:6808:0:b0:2d4:4ffa:9fa6 with SMTP id
 c8-20020a2e6808000000b002d44ffa9fa6mr1318190lja.52.1712319989171; Fri, 05 Apr
 2024 05:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712287421.git.wqu@suse.com> <5446ba76bd7fa527447a23fe6e3262b36533d4c7.1712287421.git.wqu@suse.com>
In-Reply-To: <5446ba76bd7fa527447a23fe6e3262b36533d4c7.1712287421.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 5 Apr 2024 13:25:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6zCSfbQk+fxA236Gn9QK=x7_cFjdoXAUBUs_NRqbnAVw@mail.gmail.com>
Message-ID: <CAL3q7H6zCSfbQk+fxA236Gn9QK=x7_cFjdoXAUBUs_NRqbnAVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] btrfs: simplify the inline extent map creation
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> With the tree-checker ensuring all inline file extents starts at file
> offset 0 and has a length no larger than sectorsize, we can simplify the
> calculation to assigned those fixes values directly.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/file-item.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index e58fb5347e65..844439f19949 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1265,20 +1265,19 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
_inode *inode,
>         struct extent_buffer *leaf =3D path->nodes[0];
>         const int slot =3D path->slots[0];
>         struct btrfs_key key;
> -       u64 extent_start, extent_end;
> +       u64 extent_start;
>         u64 bytenr;
>         u8 type =3D btrfs_file_extent_type(leaf, fi);
>         int compress_type =3D btrfs_file_extent_compression(leaf, fi);
>
>         btrfs_item_key_to_cpu(leaf, &key, slot);
>         extent_start =3D key.offset;
> -       extent_end =3D btrfs_file_extent_end(path);
>         em->ram_bytes =3D btrfs_file_extent_ram_bytes(leaf, fi);
>         em->generation =3D btrfs_file_extent_generation(leaf, fi);
>         if (type =3D=3D BTRFS_FILE_EXTENT_REG ||
>             type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
>                 em->start =3D extent_start;
> -               em->len =3D extent_end - extent_start;
> +               em->len =3D btrfs_file_extent_end(path) - extent_start;
>                 em->orig_start =3D extent_start -
>                         btrfs_file_extent_offset(leaf, fi);
>                 em->orig_block_len =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
> @@ -1299,9 +1298,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                                 em->flags |=3D EXTENT_FLAG_PREALLOC;
>                 }
>         } else if (type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> +               /* Tree-checker has ensured this. */
> +               ASSERT(extent_start =3D=3D 0);
> +
>                 em->block_start =3D EXTENT_MAP_INLINE;
> -               em->start =3D extent_start;
> -               em->len =3D extent_end - extent_start;
> +               em->start =3D 0;
> +               em->len =3D fs_info->sectorsize;
>                 /*
>                  * Initialize orig_start and block_len with the same valu=
es
>                  * as in inode.c:btrfs_get_extent().
> @@ -1334,12 +1336,10 @@ u64 btrfs_file_extent_end(const struct btrfs_path=
 *path)
>         ASSERT(key.type =3D=3D BTRFS_EXTENT_DATA_KEY);
>         fi =3D btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
>
> -       if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_INL=
INE) {
> -               end =3D btrfs_file_extent_ram_bytes(leaf, fi);
> -               end =3D ALIGN(key.offset + end, leaf->fs_info->sectorsize=
);
> -       } else {
> +       if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_INL=
INE)
> +               end =3D leaf->fs_info->sectorsize;
> +       else
>                 end =3D key.offset + btrfs_file_extent_num_bytes(leaf, fi=
);
> -       }
>
>         return end;
>  }
> --
> 2.44.0
>
>

