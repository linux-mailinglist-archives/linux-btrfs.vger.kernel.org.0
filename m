Return-Path: <linux-btrfs+bounces-5115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333AD8CA0BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D8E1F21D14
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748A13776C;
	Mon, 20 May 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJDH96YY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0954BE8
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222731; cv=none; b=BCTPNF26emZhiJyq4Qvpg2jTUXz1qAD/9aF1nktq7EX11ySMrNsLjeOAJA48Ph7edwiY3DNX0ICMUsQmrLd1dOQa87NlV6MD7L5y7Lph8seephE8gcYsecY/C9Byt54apnjG0PmBTY9fgHBDGTsKdgHN1nakvrIj3133hkXZaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222731; c=relaxed/simple;
	bh=+sLiTR4azjjnKtMV605UOnNGicRSkrDUoGxsDQypzsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8eq1bxH0aveV2y3RrLlhs54mqzZlEu76gICNTecTXq5Hw7Y7CJ/NQ2OdmnQRONb0DV/FmF2PkqQPRDQEZw9S/19mroXfaK4F/xPdhWlO+TEmkQQ/fIQVGk1dEdcSBk1/e3HsWn+E7TKuCPqp3MmHgdtWG82iZ5rPywzYU7lnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJDH96YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0861C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716222730;
	bh=+sLiTR4azjjnKtMV605UOnNGicRSkrDUoGxsDQypzsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nJDH96YYBE+HdKYUf4hq8N/wMYLCAouoNtpzL0nHVqVM+7tlT44wJjVugpGiVNh1v
	 BpDHGy1+dqbglF1UPlF19hvWpjVjD/r+uS89qybaiJ85bZtFXHBjxzEL9rJayy9IFK
	 7GwRBLIl9J7ES43Zw1mrdRHqhiwZB6ZDlJk6Z8kJzY5OIpy0u/GiTN0BPavvode6Jt
	 w+22hvNuAX7y9JdScvpm5ZONTBybhqROwG9af2T7v51Eda5JMhCb3mWpEiLlwAp1IV
	 vu4fCn1SKoZ4eTrxUq6sxzdvjaqk70zKaf9xrWflZxu2ZJkIrehkGclpTKKClb39Te
	 vvFmfDFPZ/8Gg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a609dd3fso1003760466b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:32:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy+x0sRT7sW9Xhty0cSnD03Ju2BD8iaSlUEMJvEHS+K3f3YpmwF
	LHUxtENYxuG7YS1fqRX4uxw2vyx3bsiLuY7n4DXiCcGYXq02aQ7eANvoYXRF4MD9gVnfz8KyyqV
	mtEXUxOv3FoSuhBRz+WBxAuSKCjU=
X-Google-Smtp-Source: AGHT+IH+cyYH5CJ0HPQdFOBUljK3A/MI96cgpmn548/s3YOe0tCQfzUorcpJWr+WYAAVBJqQCQFCFR+ejyNmRIIUVWg=
X-Received: by 2002:a17:906:af8e:b0:a59:92b0:e0d3 with SMTP id
 a640c23a62f3a-a5d5fc6232emr520031766b.34.1716222729308; Mon, 20 May 2024
 09:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <a61f241459cdfccfe338ec6bb5e883047c4457b6.1714707707.git.wqu@suse.com>
In-Reply-To: <a61f241459cdfccfe338ec6bb5e883047c4457b6.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 17:31:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H514oE4+22Kmj1ZAG9ComyaGUjPB2eW7MpG3cKR1kasTg@mail.gmail.com>
Message-ID: <CAL3q7H514oE4+22Kmj1ZAG9ComyaGUjPB2eW7MpG3cKR1kasTg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] btrfs: cleanup duplicated parameters related to btrfs_alloc_ordered_extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:03=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> All parameters after @filepos of btrfs_alloc_ordered_extent() can be
> replaced with btrfs_file_extent structure.
>
> This patch would do the cleanup, meanwhile some points to note:

would do -> does

>
> - Move btrfs_file_extent structure to ordered-data.h
>   The structure is needed by both btrfs_alloc_ordered_extent() and
>   can_nocow_extent(), but since btrfs_inode.h would include

would include -> includes  (it's including at the moment, before this
patchset - there's an include of ordered-data.h in btrfs_inode.h)

>   ordered-data.h, so we need to move the structure to ordered-data.h.
>
> - Move the special handling of NOCOW/PREALLOC into
>   btrfs_alloc_ordered_extent()
>   Previously we have two call sites intentionally forging the numbers,

So this forging is the thing you don't like about disk_bytenr not
matching the disk_bytenr of a file extent item, but rather that plus
some offset.
I would leave the rant about it from the changelog the comments in
code. Leave that for a patch that specifically addresses that.

Otherwise the rest of this patch looks fine.
Thanks.

>   but now with accurate btrfs_file_extent results, it's better to move
>   the special handling into btrfs_alloc_ordered_extent(), so callers can
>   just pass the accurate file_extent.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h  | 17 -----------
>  fs/btrfs/inode.c        | 64 +++++++----------------------------------
>  fs/btrfs/ordered-data.c | 36 +++++++++++++++++++----
>  fs/btrfs/ordered-data.h | 22 ++++++++++++--
>  4 files changed, 59 insertions(+), 80 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index bea343615ad1..6622485389dc 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -443,23 +443,6 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs=
_info, struct page *page,
>                             u32 pgoff, u8 *csum, const u8 * const csum_ex=
pected);
>  bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev=
,
>                         u32 bio_offset, struct bio_vec *bv);
> -
> -/*
> - * A more access-friendly representation of btrfs_file_extent_item.
> - *
> - * Unused members are excluded.
> - */
> -struct btrfs_file_extent {
> -       u64 disk_bytenr;
> -       u64 disk_num_bytes;
> -
> -       u64 num_bytes;
> -       u64 ram_bytes;
> -       u64 offset;
> -
> -       u8 compression;
> -};
> -
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>                               struct btrfs_file_extent *file_extent,
>                               bool nowait, bool strict);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 89f284ae26a4..eec5ecb917d8 100644
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
> @@ -2192,20 +2184,11 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>                         free_extent_map(em);
>                 }
>
> -               /*
> -                * Check btrfs_create_dio_extent() for why we intentional=
ly pass
> -                * incorrect value for NOCOW/PREALLOC OEs.
> -                */
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
> @@ -7020,33 +7003,9 @@ static struct extent_map *btrfs_create_dio_extent(=
struct btrfs_inode *inode,
>                         goto out;
>         }
>
> -       /*
> -        * NOTE: I know the numbers are totally wrong for NOCOW/PREALLOC,
> -        * but it doesn't cause problem at least for now.
> -        *
> -        * For regular writes, we would have file_extent->offset as 0,
> -        * thus we really only need disk_bytenr, every other length
> -        * (disk_num_bytes/ram_bytes) would match @len and fe->num_bytes.
> -        * The current numbers are totally fine.
> -        *
> -        * For NOCOW, we don't really care about the numbers except @file=
_pos
> -        * and @num_bytes, as we won't insert a file extent item at all.
> -        *
> -        * For PREALLOC, we do not use ordered extent's member, but
> -        * btrfs_mark_extent_written() would handle everything.
> -        *
> -        * So here we intentionally go with pseudo numbers for the NOCOW/=
PREALLOC
> -        * OEs, or btrfs_extract_ordered_extent() would need a completely=
 new
> -        * routine to handle NOCOW/PREALLOC splits, meanwhile result noth=
ing
> -        * different.
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
> @@ -10377,12 +10336,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *ioc=
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
> index c5bdd674f55c..371a85250d6a 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -263,17 +263,41 @@ static void insert_ordered_extent(struct btrfs_orde=
red_extent *entry)
>   */
>  struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
>                         struct btrfs_inode *inode, u64 file_offset,
> -                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> -                       u64 disk_num_bytes, u64 offset, unsigned long fla=
gs,
> -                       int compress_type)
> +                       struct btrfs_file_extent *file_extent,
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
> +        * NOTE: I know the numbers are totally wrong for NOCOW/PREALLOC,
> +        * but it doesn't cause problem at least for now.
> +        *
> +        * For NOCOW, we don't really care about the numbers except @file=
_pos
> +        * and @num_bytes, as we won't insert a file extent item at all.
> +        *
> +        * For PREALLOC, we do not use ordered extent's member, but
> +        * btrfs_mark_extent_written() would handle everything.
> +        *
> +        * So here we intentionally go with pseudo numbers for the NOCOW/=
PREALLOC
> +        * OEs, or btrfs_extract_ordered_extent() would need a completely=
 new
> +        * routine to handle NOCOW/PREALLOC splits, meanwhile result noth=
ing
> +        * different.
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
> index b6f6c6b91732..5bbec06fbc8d 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -171,11 +171,27 @@ void btrfs_mark_ordered_io_finished(struct btrfs_in=
ode *inode,
>  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>                                     struct btrfs_ordered_extent **cached,
>                                     u64 file_offset, u64 io_size);
> +
> +/*
> + * A more access-friendly representation of btrfs_file_extent_item.
> + *
> + * Unused members are excluded.
> + */
> +struct btrfs_file_extent {
> +       u64 disk_bytenr;
> +       u64 disk_num_bytes;
> +
> +       u64 num_bytes;
> +       u64 ram_bytes;
> +       u64 offset;
> +
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
> +                       unsigned long flags);
>  void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>                            struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_in=
ode *inode,
> --
> 2.45.0
>
>

