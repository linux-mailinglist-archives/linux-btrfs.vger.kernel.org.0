Return-Path: <linux-btrfs+bounces-4847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36638C01CB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36086B213EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF8129E70;
	Wed,  8 May 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHg1TzLr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6351A2C05
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185086; cv=none; b=M2vCgtgxXdLPOn7xqPqmo4igWUhRmenrrQxiLzCyXNv7iZarLbHelgoedcxKoYYib91NWGHkwTpth1HJZus5bv9aQExF0/M9KGvWWchSiDTVSXDawzmCAA56SmF9CMryWy+rRQzNV5nIJC0md/RO96Qcklj77oqGn+0AEsTv7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185086; c=relaxed/simple;
	bh=xSoBWpuaRVs0KO3C66rLVqytAPCIPJTEfSEJSI4KIsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH2mhORWokW4CMnNx/nCelEtZsQpvSsWcIGfAdPNN94xgrb0oWKjOzZJJYb1lyUNRz+Vn1HK8CtVErkxhOTNQquA+6+eSooRk78eDm1v3Q8rS8utGKmzCweciu3xoVAjCDUiA4QloLDE2q6fAG/53rxat+2UDz/6f/1BzF5l26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHg1TzLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B356C113CC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185086;
	bh=xSoBWpuaRVs0KO3C66rLVqytAPCIPJTEfSEJSI4KIsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HHg1TzLrdpqbC67wm5Kij4YbPp8sNgQklfkLrGi5XaxnPlRx7ivnbYHyPLikT7fgm
	 XWJlmNk/LQx5s31X8XnfC816IY8cVIOsSYQkQeeD2oRlZLIrwah6arvCdacDfJfZu0
	 QmN2irGQy8xZXoOiO8IhX8GwkIEWwdoGKYkwt4VT9CcKXRHn2puE+N+UzhC8fn+rer
	 qRlIEtVeo+7h9TXMtzANKNP5r3B7yfcL4ZZ2gpxO567AjwTnvafcj5R2pSIz3GJMz7
	 VsoPy14bzEgNJOFoFDNnEKyzcbzYidc5nUqgQ0IC0YiR8ozWFt5OPXi1t1qcm110d0
	 iR0EoVjIjrPbA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51ef64d051bso3930769e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2024 09:18:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2I76WBpTwjn6dZ0eZi033g2tNxeU69zHRvLlizKlDqO/yZ9HB
	syWtCJ9v+II/ljpP8d4D2nRgcgJTOMTrlCgclJRdkKyfgGXR3QCI0sFogZ8gSv5Uw9NeCHXETzv
	rwZFL/bRNvxhWbicwadWf2lmsMI8=
X-Google-Smtp-Source: AGHT+IFOIQRJ5WTeb/Iroa1QrpJIE9u7uQxy11mzLN8TpXr7NWlQZJLAscHkBarzrOjtkTD1whMz3K9EYRNUUieaiew=
X-Received: by 2002:ac2:4e97:0:b0:519:2c84:2405 with SMTP id
 2adb3069b0e04-5217cc42bbamr1811658e87.44.1715185084475; Wed, 08 May 2024
 09:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503114230.9871-1-dsterba@suse.com>
In-Reply-To: <20240503114230.9871-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 8 May 2024 17:17:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4UGXk8Oi7nA+SY585-K=HCT7MV-KrG0x46s020-5_pag@mail.gmail.com>
Message-ID: <CAL3q7H4UGXk8Oi7nA+SY585-K=HCT7MV-KrG0x46s020-5_pag@mail.gmail.com>
Subject: Re: [PATCH] btrfs: enhance compression error messages
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:50=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> Add more verbose and specific messages to all main error points in
> compression code for all algorithms. Currently there's no way to know
> which inode is affected or where in the data errors happened.
>
> The messages follow a common format:
>
> - what happened
> - error code if relevant
> - root and inode
> - additional data like offsets or lengths
>
> There's no helper for the messages as they differ in some details and
> that would be cumbersome to generalize to a single function. As all the
> errors are "almost never happens" there are the unlikely annotations
> done as compression is hot path.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/lzo.c  | 43 ++++++++++++++++++++---------
>  fs/btrfs/zlib.c | 60 ++++++++++++++++++++++++++++++----------
>  fs/btrfs/zstd.c | 73 +++++++++++++++++++++++++++++++++++++------------
>  3 files changed, 131 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 1c396ac167aa..d2e8a9117d22 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -258,8 +258,8 @@ int lzo_compress_folios(struct list_head *ws, struct =
address_space *mapping,
>                                        workspace->cbuf, &out_len,
>                                        workspace->mem);
>                 kunmap_local(data_in);
> -               if (ret < 0) {
> -                       pr_debug("BTRFS: lzo in loop returned %d\n", ret)=
;
> +               if (unlikely(ret < 0)) {
> +                       /* lzo1x_1_compress never fails. */
>                         ret =3D -EIO;
>                         goto out;
>                 }
> @@ -354,11 +354,14 @@ int lzo_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>          * and all sectors should be used.
>          * If this happens, it means the compressed extent is corrupted.
>          */
> -       if (len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_l=
en) ||
> -           round_up(len_in, sectorsize) < cb->compressed_len) {
> +       if (unlikely(len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->com=
pressed_len) ||
> +                    round_up(len_in, sectorsize) < cb->compressed_len)) =
{
> +               struct btrfs_inode *inode =3D cb->bbio.inode;
> +
>                 btrfs_err(fs_info,
> -                       "invalid lzo header, lzo len %u compressed len %u=
",
> -                       len_in, cb->compressed_len);
> +"lzo header invalid, root %llu inode %llu offset %llu lzo len %u compres=
sed len %u",
> +                         inode->root->root_key.objectid, btrfs_ino(inode=
),

Now that we are using btrfs_root_id() everywhere after Josef's recent
patch, please use btrfs_root_id(inode->root) everywhere in the patch
for consistency (it's also shorter to type and the name is very
clear).

Otherwise it looks fine, and after that:

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +                         cb->start, len_in, cb->compressed_len);
>                 return -EUCLEAN;
>         }
>
> @@ -383,13 +386,17 @@ int lzo_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>                 kunmap_local(kaddr);
>                 cur_in +=3D LZO_LEN;
>
> -               if (seg_len > WORKSPACE_CBUF_LENGTH) {
> +               if (unlikely(seg_len > WORKSPACE_CBUF_LENGTH)) {
> +                       struct btrfs_inode *inode =3D cb->bbio.inode;
> +
>                         /*
>                          * seg_len shouldn't be larger than we have alloc=
ated
>                          * for workspace->cbuf
>                          */
> -                       btrfs_err(fs_info, "unexpectedly large lzo segmen=
t len %u",
> -                                       seg_len);
> +                       btrfs_err(fs_info,
> +                       "lzo segment too big, root %llu inode %llu offset=
 %llu len %u",
> +                                 inode->root->root_key.objectid, btrfs_i=
no(inode),
> +                                 cb->start, seg_len);
>                         return -EIO;
>                 }
>
> @@ -399,8 +406,13 @@ int lzo_decompress_bio(struct list_head *ws, struct =
compressed_bio *cb)
>                 /* Decompress the data */
>                 ret =3D lzo1x_decompress_safe(workspace->cbuf, seg_len,
>                                             workspace->buf, &out_len);
> -               if (ret !=3D LZO_E_OK) {
> -                       btrfs_err(fs_info, "failed to decompress");
> +               if (unlikely(ret !=3D LZO_E_OK)) {
> +                       struct btrfs_inode *inode =3D cb->bbio.inode;
> +
> +                       btrfs_err(fs_info,
> +               "lzo decompression failed, error %d root %llu inode %llu =
offset %llu",
> +                                 ret, inode->root->root_key.objectid,
> +                                 btrfs_ino(inode), cb->start);
>                         return -EIO;
>                 }
>
> @@ -454,8 +466,13 @@ int lzo_decompress(struct list_head *ws, const u8 *d=
ata_in,
>
>         out_len =3D sectorsize;
>         ret =3D lzo1x_decompress_safe(data_in, in_len, workspace->buf, &o=
ut_len);
> -       if (ret !=3D LZO_E_OK) {
> -               pr_warn("BTRFS: decompress failed!\n");
> +       if (unlikely(ret !=3D LZO_E_OK)) {
> +               struct btrfs_inode *inode =3D BTRFS_I(dest_page->mapping-=
>host);
> +
> +               btrfs_err(fs_info,
> +               "lzo decompression failed, error %d root %llu inode %llu =
offset %llu",
> +                         ret, inode->root->root_key.objectid,
> +                         btrfs_ino(inode), page_offset(dest_page));
>                 ret =3D -EIO;
>                 goto out;
>         }
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index d9e5c88a0f85..d7e5f681bc32 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -19,6 +19,7 @@
>  #include <linux/bio.h>
>  #include <linux/refcount.h>
>  #include "compression.h"
> +#include "btrfs_inode.h"
>
>  /* workspace buffer size for s390 zlib hardware support */
>  #define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
> @@ -112,8 +113,14 @@ int zlib_compress_folios(struct list_head *ws, struc=
t address_space *mapping,
>         *total_out =3D 0;
>         *total_in =3D 0;
>
> -       if (Z_OK !=3D zlib_deflateInit(&workspace->strm, workspace->level=
)) {
> -               pr_warn("BTRFS: deflateInit failed\n");
> +       ret =3D zlib_deflateInit(&workspace->strm, workspace->level);
> +       if (unlikely(ret !=3D Z_OK)) {
> +               struct btrfs_inode *inode =3D BTRFS_I(mapping->host);
> +
> +               btrfs_err(inode->root->fs_info,
> +       "zlib compression init failed, error %d root %llu inode %llu offs=
et %llu",
> +                         ret, inode->root->root_key.objectid, btrfs_ino(=
inode),
> +                         start);
>                 ret =3D -EIO;
>                 goto out;
>         }
> @@ -182,9 +189,13 @@ int zlib_compress_folios(struct list_head *ws, struc=
t address_space *mapping,
>                 }
>
>                 ret =3D zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
> -               if (ret !=3D Z_OK) {
> -                       pr_debug("BTRFS: deflate in loop returned %d\n",
> -                              ret);
> +               if (unlikely(ret !=3D Z_OK)) {
> +                       struct btrfs_inode *inode =3D BTRFS_I(mapping->ho=
st);
> +
> +                       btrfs_warn(inode->root->fs_info,
> +               "zlib compression failed, error %d root %llu inode %llu o=
ffset %llu",
> +                                  ret, inode->root->root_key.objectid, b=
trfs_ino(inode),
> +                                  start);
>                         zlib_deflateEnd(&workspace->strm);
>                         ret =3D -EIO;
>                         goto out;
> @@ -307,9 +318,15 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>                 workspace->strm.avail_in -=3D 2;
>         }
>
> -       if (Z_OK !=3D zlib_inflateInit2(&workspace->strm, wbits)) {
> -               pr_warn("BTRFS: inflateInit failed\n");
> +       ret =3D zlib_inflateInit2(&workspace->strm, wbits);
> +       if (unlikely(ret !=3D Z_OK)) {
> +               struct btrfs_inode *inode =3D cb->bbio.inode;
> +
>                 kunmap_local(data_in);
> +               btrfs_err(inode->root->fs_info,
> +       "zlib decompression init failed, error %d root %llu inode %llu of=
fset %llu",
> +                         ret, inode->root->root_key.objectid, btrfs_ino(=
inode),
> +                         cb->start);
>                 return -EIO;
>         }
>         while (workspace->strm.total_in < srclen) {
> @@ -348,10 +365,15 @@ int zlib_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>                         workspace->strm.avail_in =3D min(tmp, PAGE_SIZE);
>                 }
>         }
> -       if (ret !=3D Z_STREAM_END)
> +       if (unlikely(ret !=3D Z_STREAM_END)) {
> +               btrfs_err(cb->bbio.inode->root->fs_info,
> +               "zlib decompression failed, error %d root %llu inode %llu=
 offset %llu",
> +                         ret, cb->bbio.inode->root->root_key.objectid,
> +                         btrfs_ino(cb->bbio.inode), cb->start);
>                 ret =3D -EIO;
> -       else
> +       } else {
>                 ret =3D 0;
> +       }
>  done:
>         zlib_inflateEnd(&workspace->strm);
>         if (data_in)
> @@ -386,8 +408,14 @@ int zlib_decompress(struct list_head *ws, const u8 *=
data_in,
>                 workspace->strm.avail_in -=3D 2;
>         }
>
> -       if (Z_OK !=3D zlib_inflateInit2(&workspace->strm, wbits)) {
> -               pr_warn("BTRFS: inflateInit failed\n");
> +       ret =3D zlib_inflateInit2(&workspace->strm, wbits);
> +       if (unlikely(ret !=3D Z_OK)) {
> +               struct btrfs_inode *inode =3D BTRFS_I(dest_page->mapping-=
>host);
> +
> +               btrfs_err(inode->root->fs_info,
> +               "zlib decompression init failed, error %d root %llu inode=
 %llu offset %llu",
> +                         ret, inode->root->root_key.objectid, btrfs_ino(=
inode),
> +                         page_offset(dest_page));
>                 return -EIO;
>         }
>
> @@ -403,9 +431,13 @@ int zlib_decompress(struct list_head *ws, const u8 *=
data_in,
>         memcpy_to_page(dest_page, dest_pgoff, workspace->buf, to_copy);
>
>  out:
> -       if (unlikely(to_copy !=3D destlen)) {
> -               pr_warn_ratelimited("BTRFS: inflate failed, decompressed=
=3D%lu expected=3D%zu\n",
> -                                       to_copy, destlen);
> +       if (unlikely(ret !=3D Z_OK || to_copy !=3D destlen)) {
> +               struct btrfs_inode *inode =3D BTRFS_I(dest_page->mapping-=
>host);
> +
> +               btrfs_err(inode->root->fs_info,
> +"zlib decompression failed, error %d root %llu inode %llu offset %llu de=
compressed %lu expected %zu",
> +                         ret, inode->root->root_key.objectid, btrfs_ino(=
inode),
> +                         page_offset(dest_page), to_copy, destlen);
>                 ret =3D -EIO;
>         } else {
>                 ret =3D 0;
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 2b232b82c3a8..68ab483d7fd9 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -19,6 +19,7 @@
>  #include <linux/zstd.h>
>  #include "misc.h"
>  #include "fs.h"
> +#include "btrfs_inode.h"
>  #include "compression.h"
>  #include "super.h"
>
> @@ -399,8 +400,13 @@ int zstd_compress_folios(struct list_head *ws, struc=
t address_space *mapping,
>         /* Initialize the stream */
>         stream =3D zstd_init_cstream(&params, len, workspace->mem,
>                         workspace->size);
> -       if (!stream) {
> -               pr_warn("BTRFS: zstd_init_cstream failed\n");
> +       if (unlikely(!stream)) {
> +               struct btrfs_inode *inode =3D BTRFS_I(mapping->host);
> +
> +               btrfs_err(inode->root->fs_info,
> +       "zstd compression init level %d failed, root %llu inode %llu offs=
et %llu",
> +                         workspace->req_level, inode->root->root_key.obj=
ectid,
> +                         btrfs_ino(inode), start);
>                 ret =3D -EIO;
>                 goto out;
>         }
> @@ -429,9 +435,14 @@ int zstd_compress_folios(struct list_head *ws, struc=
t address_space *mapping,
>
>                 ret2 =3D zstd_compress_stream(stream, &workspace->out_buf=
,
>                                 &workspace->in_buf);
> -               if (zstd_is_error(ret2)) {
> -                       pr_debug("BTRFS: zstd_compress_stream returned %d=
\n",
> -                                       zstd_get_error_code(ret2));
> +               if (unlikely(zstd_is_error(ret2))) {
> +                       struct btrfs_inode *inode =3D BTRFS_I(mapping->ho=
st);
> +
> +                       btrfs_warn(inode->root->fs_info,
> +"zstd compression level %d failed, error %d root %llu inode %llu offset =
%llu",
> +                                  workspace->req_level, zstd_get_error_c=
ode(ret2),
> +                                  inode->root->root_key.objectid, btrfs_=
ino(inode),
> +                                  start);
>                         ret =3D -EIO;
>                         goto out;
>                 }
> @@ -497,9 +508,14 @@ int zstd_compress_folios(struct list_head *ws, struc=
t address_space *mapping,
>                 size_t ret2;
>
>                 ret2 =3D zstd_end_stream(stream, &workspace->out_buf);
> -               if (zstd_is_error(ret2)) {
> -                       pr_debug("BTRFS: zstd_end_stream returned %d\n",
> -                                       zstd_get_error_code(ret2));
> +               if (unlikely(zstd_is_error(ret2))) {
> +                       struct btrfs_inode *inode =3D BTRFS_I(mapping->ho=
st);
> +
> +                       btrfs_err(inode->root->fs_info,
> +"zstd compression end level %d failed, error %d root %llu inode %llu off=
set %llu",
> +                                 workspace->req_level, zstd_get_error_co=
de(ret2),
> +                                 inode->root->root_key.objectid, btrfs_i=
no(inode),
> +                                 start);
>                         ret =3D -EIO;
>                         goto out;
>                 }
> @@ -561,8 +577,13 @@ int zstd_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>
>         stream =3D zstd_init_dstream(
>                         ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->=
size);
> -       if (!stream) {
> -               pr_debug("BTRFS: zstd_init_dstream failed\n");
> +       if (unlikely(!stream)) {
> +               struct btrfs_inode *inode =3D cb->bbio.inode;
> +
> +               btrfs_err(inode->root->fs_info,
> +               "zstd decompression init failed, root %llu inode %llu off=
set %llu",
> +                         inode->root->root_key.objectid, btrfs_ino(inode=
),
> +                         cb->start);
>                 ret =3D -EIO;
>                 goto done;
>         }
> @@ -580,9 +601,14 @@ int zstd_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>
>                 ret2 =3D zstd_decompress_stream(stream, &workspace->out_b=
uf,
>                                 &workspace->in_buf);
> -               if (zstd_is_error(ret2)) {
> -                       pr_debug("BTRFS: zstd_decompress_stream returned =
%d\n",
> -                                       zstd_get_error_code(ret2));
> +               if (unlikely(zstd_is_error(ret2))) {
> +                       struct btrfs_inode *inode =3D cb->bbio.inode;
> +
> +                       btrfs_err(inode->root->fs_info,
> +               "zstd decompression failed, error %d root %llu inode %llu=
 offset %llu",
> +                                 zstd_get_error_code(ret2),
> +                                 inode->root->root_key.objectid, btrfs_i=
no(inode),
> +                                 cb->start);
>                         ret =3D -EIO;
>                         goto done;
>                 }
> @@ -637,8 +663,14 @@ int zstd_decompress(struct list_head *ws, const u8 *=
data_in,
>
>         stream =3D zstd_init_dstream(
>                         ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->=
size);
> -       if (!stream) {
> -               pr_warn("BTRFS: zstd_init_dstream failed\n");
> +       if (unlikely(!stream)) {
> +               struct btrfs_inode *inode =3D BTRFS_I(dest_page->mapping-=
>host);
> +
> +               btrfs_err(inode->root->fs_info,
> +               "zstd decompression init failed, root %llu inode %llu off=
set %llu",
> +                         inode->root->root_key.objectid, btrfs_ino(inode=
),
> +                         page_offset(dest_page));
> +               ret =3D -EIO;
>                 goto finish;
>         }
>
> @@ -655,9 +687,14 @@ int zstd_decompress(struct list_head *ws, const u8 *=
data_in,
>          * one call should end the decompression.
>          */
>         ret =3D zstd_decompress_stream(stream, &workspace->out_buf, &work=
space->in_buf);
> -       if (zstd_is_error(ret)) {
> -               pr_warn_ratelimited("BTRFS: zstd_decompress_stream return=
 %d\n",
> -                                   zstd_get_error_code(ret));
> +       if (unlikely(zstd_is_error(ret))) {
> +               struct btrfs_inode *inode =3D BTRFS_I(dest_page->mapping-=
>host);
> +
> +               btrfs_err(inode->root->fs_info,
> +               "zstd decompression failed, error %d root %llu inode %llu=
 offset %llu",
> +                         zstd_get_error_code(ret),
> +                         inode->root->root_key.objectid, btrfs_ino(inode=
),
> +                         page_offset(dest_page));
>                 goto finish;
>         }
>         to_copy =3D workspace->out_buf.pos;
> --
> 2.44.0
>
>

