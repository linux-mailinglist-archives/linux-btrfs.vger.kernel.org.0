Return-Path: <linux-btrfs+bounces-5116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29808CA0D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 18:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BD81F21B4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990113699F;
	Mon, 20 May 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXSE9su1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A97E552
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223615; cv=none; b=mMfg9ZLUd/moGr6M2m71Fxhu5d41Rbxwj3eXSSOS37Z5GsqCmZScUhrz7gIxk17yJMJ3egYfaZJwa2WMQXT/GYIknacdBZUulOXBOteOY1mHt8ZA2WbF30kit12IrTO/uUp3y5DjzctgkpSWtax0k5JYhFGNijcVvbUbk63Xlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223615; c=relaxed/simple;
	bh=2AO39icb9f5bxg0rUOh2sP79xiPFAG95qT9Zo0QFwpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlKbYA8RctuEGZjGU0C9wrqjkcC1d2eGTwBekWCLKE4nf4fcYG4RYppUdsclwVij3JxrESYcgpEPpt8aVFtzjdLGQTGAkv8faGiInmwWeofNooNtPcc7H8uvK8Kq1vjT1cBbYzyDq5qHQBHtWHanBUnuVhcjSnXifLj1w43H31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXSE9su1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F3C4AF07
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716223615;
	bh=2AO39icb9f5bxg0rUOh2sP79xiPFAG95qT9Zo0QFwpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cXSE9su1wWcuY4ADBnpog3spfvmUgfu3/CmMrVSEiZ1nGjrNXdKVs1Wp1V7vDk9j/
	 0eE5SN5fkDE0aHJAxNn2JeBT/7JGi5Yp+KmeAhN7TEuFZUvF5Q4+dZ1IZSYD5To3aT
	 4QX8f/I/46uxAgmgKoUISOKbbnCIFdrk6vOru8Z9TPAS1xaTAh19yZ+o8eVi+FzIFs
	 qoHyavXoBymlR2De11lds/i7zOwSxFiDkuSSfMvwGBpfBCgelZxqgvOqQMdv7bLaGo
	 tsRn5eZ1Pjbby4GFXXaDFKeFRHV7L5LOywRsclBhyl5MOZJWqL/N4P9MzoRC4lJJ00
	 XL5weNTFFjn6Q==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59e4136010so793031266b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YyaLfC+ypEKDQdvof4fi/G5s1pul5r+EVNxeLFlP3EFpj/euG7d
	1zatpq/pPzuV3n7FeNk6pMCnk86QP3ZA7IjUBpcIci0UzDEFfSlOzPZq3d9g1m2Rm9I96LBxDyu
	Ajf1FYmk87cFdHNrDL4XX5V3wOtw=
X-Google-Smtp-Source: AGHT+IESIJO+NyMkXmWtKrKSZv7HA14zc7IrBYFQ6vP483+oLS+m5nCSK6HtviKAO4ZtkSOVHmIyq3Cl+VaoK/gp1ms=
X-Received: by 2002:a17:906:ae8b:b0:a59:cb09:41d6 with SMTP id
 a640c23a62f3a-a5a2d65f294mr1735596266b.49.1716223613675; Mon, 20 May 2024
 09:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <ee8e2727bfb0607f2e3b091364c131864e120439.1714707707.git.wqu@suse.com>
In-Reply-To: <ee8e2727bfb0607f2e3b091364c131864e120439.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 17:46:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H61O+P1LiA7PXZEgmNnOKRRFUDsed5RiEYFRVhOjNzR0A@mail.gmail.com>
Message-ID: <CAL3q7H61O+P1LiA7PXZEgmNnOKRRFUDsed5RiEYFRVhOjNzR0A@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] btrfs: cleanup duplicated parameters related to create_io_em()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:03=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Most parameters of create_io_em() can be replaced by the members with
> the same name inside btrfs_file_extent.
>
> Do a straight parameters cleanup here.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 50 +++++++++++++-----------------------------------
>  1 file changed, 13 insertions(+), 37 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index eec5ecb917d8..a95dc2333972 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -138,9 +138,6 @@ static noinline int run_delalloc_cow(struct btrfs_ino=
de *inode,
>                                      u64 end, struct writeback_control *w=
bc,
>                                      bool pages_dirty);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
> -                                      u64 len,
> -                                      u64 disk_num_bytes,
> -                                      u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
>                                        int type);
>
> @@ -1207,12 +1204,7 @@ static void submit_one_async_extent(struct async_c=
hunk *async_chunk,
>         file_extent.offset =3D 0;
>         file_extent.compression =3D async_extent->compress_type;
>
> -       em =3D create_io_em(inode, start,
> -                         async_extent->ram_size,       /* len */
> -                         ins.offset,                   /* orig_block_len=
 */
> -                         async_extent->ram_size,       /* ram_bytes */
> -                         async_extent->compress_type,
> -                         &file_extent,
> +       em =3D create_io_em(inode, start, &file_extent,
>                           BTRFS_ORDERED_COMPRESSED);

Btw, as we're changing this, we can take the chance to make everything
in a single line since it fits and gets more readable.

>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
> @@ -1443,11 +1435,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>                 lock_extent(&inode->io_tree, start, start + ram_size - 1,
>                             &cached);
>
> -               em =3D create_io_em(inode, start, ins.offset, /* len */
> -                                 ins.offset, /* orig_block_len */
> -                                 ram_size, /* ram_bytes */
> -                                 BTRFS_COMPRESS_NONE, /* compress_type *=
/
> -                                 &file_extent,
> +               em =3D create_io_em(inode, start, &file_extent,
>                                   BTRFS_ORDERED_REGULAR /* type */);

Same here, and remove the /* type */ comment there which is superfluous any=
way.

>                 if (IS_ERR(em)) {
>                         unlock_extent(&inode->io_tree, start,
> @@ -2168,10 +2156,6 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>                         struct extent_map *em;
>
>                         em =3D create_io_em(inode, cur_offset,
> -                                         nocow_args.file_extent.num_byte=
s,
> -                                         nocow_args.file_extent.disk_num=
_bytes,
> -                                         nocow_args.file_extent.ram_byte=
s,
> -                                         BTRFS_COMPRESS_NONE,
>                                           &nocow_args.file_extent,
>                                           BTRFS_ORDERED_PREALLOC);

Same here.

The rest looks good, simple patch.
Thanks.

>                         if (IS_ERR(em)) {
> @@ -6995,10 +6979,7 @@ static struct extent_map *btrfs_create_dio_extent(=
struct btrfs_inode *inode,
>         struct btrfs_ordered_extent *ordered;
>
>         if (type !=3D BTRFS_ORDERED_NOCOW) {
> -               em =3D create_io_em(inode, start, len,
> -                                 orig_block_len, ram_bytes,
> -                                 BTRFS_COMPRESS_NONE, /* compress_type *=
/
> -                                 file_extent, type);
> +               em =3D create_io_em(inode, start, file_extent, type);
>                 if (IS_ERR(em))
>                         goto out;
>         }
> @@ -7290,9 +7271,6 @@ static int lock_extent_direct(struct inode *inode, =
u64 lockstart, u64 lockend,
>
>  /* The callers of this must take lock_extent() */
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
> -                                      u64 len,
> -                                      u64 disk_num_bytes,
> -                                      u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
>                                        int type)
>  {
> @@ -7314,25 +7292,25 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
>         switch (type) {
>         case BTRFS_ORDERED_PREALLOC:
>                 /* We're only referring part of a larger preallocated ext=
ent. */
> -               ASSERT(len <=3D ram_bytes);
> +               ASSERT(file_extent->num_bytes <=3D file_extent->ram_bytes=
);
>                 break;
>         case BTRFS_ORDERED_REGULAR:
>                 /* COW results a new extent matching our file extent size=
. */
> -               ASSERT(disk_num_bytes =3D=3D len);
> -               ASSERT(ram_bytes =3D=3D len);
> +               ASSERT(file_extent->disk_num_bytes =3D=3D file_extent->nu=
m_bytes);
> +               ASSERT(file_extent->ram_bytes =3D=3D file_extent->num_byt=
es);
>
>                 /* Since it's a new extent, we should not have any offset=
. */
>                 ASSERT(file_extent->offset =3D=3D 0);
>                 break;
>         case BTRFS_ORDERED_COMPRESSED:
>                 /* Must be compressed. */
> -               ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
> +               ASSERT(file_extent->compression !=3D BTRFS_COMPRESS_NONE)=
;
>
>                 /*
>                  * Encoded write can make us to refer to part of the
>                  * uncompressed extent.
>                  */
> -               ASSERT(len <=3D ram_bytes);
> +               ASSERT(file_extent->num_bytes <=3D file_extent->ram_bytes=
);
>                 break;
>         }
>
> @@ -7341,15 +7319,15 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
>                 return ERR_PTR(-ENOMEM);
>
>         em->start =3D start;
> -       em->len =3D len;
> +       em->len =3D file_extent->num_bytes;
>         em->disk_bytenr =3D file_extent->disk_bytenr;
> -       em->disk_num_bytes =3D disk_num_bytes;
> -       em->ram_bytes =3D ram_bytes;
> +       em->disk_num_bytes =3D file_extent->disk_num_bytes;
> +       em->ram_bytes =3D file_extent->ram_bytes;
>         em->generation =3D -1;
>         em->offset =3D file_extent->offset;
>         em->flags |=3D EXTENT_FLAG_PINNED;
>         if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> -               extent_map_set_compression(em, compress_type);
> +               extent_map_set_compression(em, file_extent->compression);
>
>         ret =3D btrfs_replace_extent_map_range(inode, em, true);
>         if (ret) {
> @@ -10327,9 +10305,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         file_extent.ram_bytes =3D ram_bytes;
>         file_extent.offset =3D encoded->unencoded_offset;
>         file_extent.compression =3D compression;
> -       em =3D create_io_em(inode, start, num_bytes,
> -                         ins.offset, ram_bytes, compression,
> -                         &file_extent, BTRFS_ORDERED_COMPRESSED);
> +       em =3D create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COM=
PRESSED);
>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
>                 goto out_free_reserved;
> --
> 2.45.0
>
>

