Return-Path: <linux-btrfs+bounces-5261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 401628CD9BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A316D1F21E5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614907FBD2;
	Thu, 23 May 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJBPmBcu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0F1F5E6
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488264; cv=none; b=rU9RC9FvTjH1/zYtGFMbUas5BOhhdWAIC6aSi+LxEaXin5WGRjH2P1Hru34sCHrI5niOWihfIhm5kSTmxnxXlCEKv0cJCZYvjoiZ6rlc4JPXsE6Vqy3C9W/Q4S1ckZuyQx8yA9sGcsJftNQaoP4jEvuDFQKMtnqtDJTlTWxJ8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488264; c=relaxed/simple;
	bh=2wOazjWUy6ziFlSGFkTKNnhTOeyVU3NFdXR1zHr8aMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLOIHLfD/6wE3gdWEfC8Psxc/rkaHSe5eE3+dcoTJfbh5r72gDXj2MIvOmfF/Cotbqq0Dsmno3hMf9skAGocaaGimccETWELeS0xPWfFzPAfmnR66cxba0pDUydd705H+/f+S6qgXYYPZ/h8ojicywCD6JlLhojcW+c95af/GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJBPmBcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB4C32781
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 18:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716488264;
	bh=2wOazjWUy6ziFlSGFkTKNnhTOeyVU3NFdXR1zHr8aMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DJBPmBcutjXoP95JoF9v/LjnwoKjD56FuuzxxjK1hBXda0vpvsnCGkJsOn8X3wtZY
	 zLJIbpdG8MfYMfQvI1s2TYIxmxBHdL7nv1VIqywjHuqVSJLxzuBufCvezgH36PMQlf
	 A8zw00RBKLHX1uwYuLYTDl0xQLjjJxI+0MCc8Dd4D8g+OGs6Q+aMfytezacZoqAFFn
	 2NcXSuLG+z/uiL+XFRDp4oPD4MTMg/aLeJccAfALmvlZ8NJ3qKzJECzo9GHb/FWpr6
	 9JZmbTYrq2AxDNvqUgyTEfjva5AfbnS+Hvxp3y43GUHOnqqQcHgvWmbmZ390yxiG6P
	 FD5R6FD0EeTYA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295a576702so2149e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 11:17:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YzcW5M8ySwgnPZ3z15qdJGCV6KBZmipqwvdn8wZnZcng52OiAcO
	zHEn1Ylk7gDkI53+karhTURkNapqWeTxluN0MSbnk4pZDd6p1uWducWGp81wV6spkygOLnZU+qA
	gWRuLKSXFcWFlVh7smo7ZDWbP2e4=
X-Google-Smtp-Source: AGHT+IF3lqlCeZKwTnRTGAawe/Ptzp2YBjlP4X36MhOZEf14kzctePzFtHyGeDo2NfgLDoirUZkfazJLE6x9r7Px3cc=
X-Received: by 2002:a05:6512:1583:b0:51f:5d0a:d71a with SMTP id
 2adb3069b0e04-526bd694ab4mr4091836e87.10.1716488262095; Thu, 23 May 2024
 11:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716440169.git.wqu@suse.com> <48c8d44318239d9b8ba7fe4906901529f1a5a2f5.1716440169.git.wqu@suse.com>
In-Reply-To: <48c8d44318239d9b8ba7fe4906901529f1a5a2f5.1716440169.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 23 May 2024 19:17:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5CFnseU8a-pzGdg1+gdNZRcdi2VC2F2FP+FaciU3tcRg@mail.gmail.com>
Message-ID: <CAL3q7H5CFnseU8a-pzGdg1+gdNZRcdi2VC2F2FP+FaciU3tcRg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] btrfs: cleanup duplicated parameters related to btrfs_alloc_ordered_extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 6:04=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> All parameters after @filepos of btrfs_alloc_ordered_extent() can be
> replaced with btrfs_file_extent structure.
>
> This patch does the cleanup, meanwhile some points to note:
>
> - Move btrfs_file_extent structure to ordered-data.h
>   The structure is needed by both btrfs_alloc_ordered_extent() and
>   can_nocow_extent(), but since btrfs_inode.h includes
>   ordered-data.h, so we need to move the structure to ordered-data.h.
>
> - Move the special handling of NOCOW/PREALLOC into
>   btrfs_alloc_ordered_extent()
>   This is to allow btrfs_split_ordered_extent() to properly split them
>   for DIO.
>   For now just move the handling into btrfs_alloc_ordered_extent() to
>   simplify the callers.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h  | 14 -----------
>  fs/btrfs/inode.c        | 56 ++++++++---------------------------------
>  fs/btrfs/ordered-data.c | 34 ++++++++++++++++++++-----
>  fs/btrfs/ordered-data.h | 19 +++++++++++---
>  4 files changed, 54 insertions(+), 69 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index dbc85efdf68a..97ce56a60672 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -514,20 +514,6 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs=
_info, struct page *page,
>                             u32 pgoff, u8 *csum, const u8 * const csum_ex=
pected);
>  bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev=
,
>                         u32 bio_offset, struct bio_vec *bv);
> -
> -/*
> - * This represents details about the target file extent item of a write
> - * operation.
> - */
> -struct btrfs_file_extent {
> -       u64 disk_bytenr;
> -       u64 disk_num_bytes;
> -       u64 num_bytes;
> -       u64 ram_bytes;
> -       u64 offset;
> -       u8 compression;
> -};
> -
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>                               struct btrfs_file_extent *file_extent,
>                               bool nowait, bool strict);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 445c19d96d10..35f03149b777 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1220,14 +1220,8 @@ static void submit_one_async_extent(struct async_c=
hunk *async_chunk,
>         }
>         free_extent_map(em);
>
> -       ordered =3D btrfs_alloc_ordered_extent(inode, start,      /* file=
_offset */
> -                                      async_extent->ram_size,  /* num_by=
tes */
> -                                      async_extent->ram_size,  /* ram_by=
tes */
> -                                      ins.objectid,            /* disk_b=
ytenr */
> -                                      ins.offset,              /* disk_n=
um_bytes */
> -                                      0,                       /* offset=
 */
> -                                      1 << BTRFS_ORDERED_COMPRESSED,
> -                                      async_extent->compress_type);
> +       ordered =3D btrfs_alloc_ordered_extent(inode, start, &file_extent=
,
> +                                      1 << BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(ordered)) {
>                 btrfs_drop_extent_map_range(inode, start, end, false);
>                 ret =3D PTR_ERR(ordered);
> @@ -1463,10 +1457,8 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>                 }
>                 free_extent_map(em);
>
> -               ordered =3D btrfs_alloc_ordered_extent(inode, start, ram_=
size,
> -                                       ram_size, ins.objectid, cur_alloc=
_size,
> -                                       0, 1 << BTRFS_ORDERED_REGULAR,
> -                                       BTRFS_COMPRESS_NONE);
> +               ordered =3D btrfs_alloc_ordered_extent(inode, start, &fil=
e_extent,
> +                                                    1 << BTRFS_ORDERED_R=
EGULAR);
>                 if (IS_ERR(ordered)) {
>                         unlock_extent(&inode->io_tree, start,
>                                       start + ram_size - 1, &cached);
> @@ -2191,15 +2183,10 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>                 }
>
>                 ordered =3D btrfs_alloc_ordered_extent(inode, cur_offset,
> -                               nocow_args.file_extent.num_bytes,
> -                               nocow_args.file_extent.num_bytes,
> -                               nocow_args.file_extent.disk_bytenr +
> -                               nocow_args.file_extent.offset,
> -                               nocow_args.file_extent.num_bytes, 0,
> +                               &nocow_args.file_extent,
>                                 is_prealloc
>                                 ? (1 << BTRFS_ORDERED_PREALLOC)
> -                               : (1 << BTRFS_ORDERED_NOCOW),
> -                               BTRFS_COMPRESS_NONE);
> +                               : (1 << BTRFS_ORDERED_NOCOW));
>                 btrfs_dec_nocow_writers(nocow_bg);
>                 if (IS_ERR(ordered)) {
>                         if (is_prealloc) {
> @@ -7054,29 +7041,9 @@ static struct extent_map *btrfs_create_dio_extent(=
struct btrfs_inode *inode,
>                         goto out;
>         }
>
> -       /*
> -        * For regular writes, file_extent->offset is always 0,
> -        * thus we really only need file_extent->disk_bytenr, every other=
 length
> -        * (disk_num_bytes/ram_bytes) should match @len and
> -        * file_extent->num_bytes.
> -        *
> -        * For NOCOW, we don't really care about the numbers except
> -        * @start and @len, as we won't insert a file extent
> -        * item at all.
> -        *
> -        * For PREALLOC, we do not use ordered extent members, but
> -        * btrfs_mark_extent_written() handles everything.
> -        *
> -        * So here we always passing 0 as offset for the ordered extent,
> -        * or btrfs_split_ordered_extent() can not handle it correctly.
> -        */
> -       ordered =3D btrfs_alloc_ordered_extent(inode, start, len, len,
> -                                            file_extent->disk_bytenr +
> -                                            file_extent->offset,
> -                                            len, 0,
> +       ordered =3D btrfs_alloc_ordered_extent(inode, start, file_extent,
>                                              (1 << type) |
> -                                            (1 << BTRFS_ORDERED_DIRECT),
> -                                            BTRFS_COMPRESS_NONE);
> +                                            (1 << BTRFS_ORDERED_DIRECT))=
;
>         if (IS_ERR(ordered)) {
>                 if (em) {
>                         free_extent_map(em);
> @@ -10396,12 +10363,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *ioc=
b, struct iov_iter *from,
>         }
>         free_extent_map(em);
>
> -       ordered =3D btrfs_alloc_ordered_extent(inode, start, num_bytes, r=
am_bytes,
> -                                      ins.objectid, ins.offset,
> -                                      encoded->unencoded_offset,
> +       ordered =3D btrfs_alloc_ordered_extent(inode, start, &file_extent=
,
>                                        (1 << BTRFS_ORDERED_ENCODED) |
> -                                      (1 << BTRFS_ORDERED_COMPRESSED),
> -                                      compression);
> +                                      (1 << BTRFS_ORDERED_COMPRESSED));
>         if (IS_ERR(ordered)) {
>                 btrfs_drop_extent_map_range(inode, start, end, false);
>                 ret =3D PTR_ERR(ordered);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index d446d89c2c34..5c2fb0a7c5c8 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -264,17 +264,39 @@ static void insert_ordered_extent(struct btrfs_orde=
red_extent *entry)
>   */
>  struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
>                         struct btrfs_inode *inode, u64 file_offset,
> -                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> -                       u64 disk_num_bytes, u64 offset, unsigned long fla=
gs,
> -                       int compress_type)
> +                       struct btrfs_file_extent *file_extent,

Btw, this can be made const.

> +                       unsigned long flags)
>  {
>         struct btrfs_ordered_extent *entry;
>
>         ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) =3D=3D 0);
>
> -       entry =3D alloc_ordered_extent(inode, file_offset, num_bytes, ram=
_bytes,
> -                                    disk_bytenr, disk_num_bytes, offset,=
 flags,
> -                                    compress_type);
> +       /*
> +        * For regular writes, we just use the members in @file_extent.
> +        *
> +        * For NOCOW, we don't really care about the numbers except
> +        * @start and file_extent->num_bytes, as we won't insert a file e=
xtent
> +        * item at all.
> +        *
> +        * For PREALLOC, we do not use ordered extent members, but
> +        * btrfs_mark_extent_written() handles everything.
> +        *
> +        * So here we always passing 0 as offset for NOCOW/PREALLOC order=
ed
> +        * extents, or btrfs_split_ordered_extent() can not handle it cor=
rectly.
> +        */
> +       if (flags & ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PRE=
ALLOC)))
> +               entry =3D alloc_ordered_extent(inode, file_offset,
> +                               file_extent->num_bytes, file_extent->num_=
bytes,
> +                               file_extent->disk_bytenr + file_extent->o=
ffset,
> +                               file_extent->num_bytes, 0, flags,
> +                               file_extent->compression);
> +       else
> +               entry =3D alloc_ordered_extent(inode, file_offset,
> +                               file_extent->num_bytes, file_extent->ram_=
bytes,
> +                               file_extent->disk_bytenr,
> +                               file_extent->disk_num_bytes,
> +                               file_extent->offset, flags,
> +                               file_extent->compression);
>         if (!IS_ERR(entry))
>                 insert_ordered_extent(entry);
>         return entry;
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 2ec329e2f0f3..31e65f2f4990 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -171,11 +171,24 @@ void btrfs_mark_ordered_io_finished(struct btrfs_in=
ode *inode,
>  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>                                     struct btrfs_ordered_extent **cached,
>                                     u64 file_offset, u64 io_size);
> +
> +/*
> + * This represents details about the target file extent item of a write
> + * operation.
> + */
> +struct btrfs_file_extent {
> +       u64 disk_bytenr;
> +       u64 disk_num_bytes;
> +       u64 num_bytes;
> +       u64 ram_bytes;
> +       u64 offset;
> +       u8 compression;
> +};
> +
>  struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
>                         struct btrfs_inode *inode, u64 file_offset,
> -                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> -                       u64 disk_num_bytes, u64 offset, unsigned long fla=
gs,
> -                       int compress_type);
> +                       struct btrfs_file_extent *file_extent,

Same here, const.

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +                       unsigned long flags);
>  void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>                            struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_in=
ode *inode,
> --
> 2.45.1
>
>

