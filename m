Return-Path: <linux-btrfs+bounces-4938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F88C4664
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 19:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD8286CA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821332E631;
	Mon, 13 May 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmNseZTQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1422C19E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622311; cv=none; b=KkZH9Rxn/c3hvtH0qrUTpE9E829vZbbvgaIY0L0KHa+a8plSB69OcuiNnA3I4SSi8RZSRYvPzlmNR/4YYdVKXe9Y60GRvvCC20QcB/0SxLRHJc1jqKxkK4BnfC1US6MnJhJOgh2bYUR5xLBNZ32/w6jA4Dh26aZfhOJvRH1FfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622311; c=relaxed/simple;
	bh=7psI+kFZsqGangDtw1JeFouS+gyz1LBnLw7fIOigh1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL92s3LxKQlO9+EjfRLxY5C7yTg+mrmRat9iy5QMmKJqDG/0ObHoK9pabEUH9cebT5TbGSQI7m5J37Vb+FlLTgJ+xl4HMpAJuNlCP6f2bGtKNcHAD9p2eB1DAu1DG1DDYo0rRGn24RAq13tf7QIaFPv7Hp/QQHOckizZxNfMTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmNseZTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC698C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622311;
	bh=7psI+kFZsqGangDtw1JeFouS+gyz1LBnLw7fIOigh1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JmNseZTQzkao3VemknB/VU5NBDNaO7/g6fFYN4FEcLuTo4j/871lFHYo6F+7tqT6M
	 3eMHWkbn221nQruTvIqA8oGfFxAJd5n0WYFf8RF4T9nj48Ff+xxSMMRzGNqTyBzhi+
	 YTcBKXy4/8hrJqKuO38O6y5hTXtimXJB7CZslHUq9JbL1cQ2sdVejlyiJcYmzYcVDR
	 DP5fM8oDaBaZ1Q0wd1euhn10o+hBCr3a0Ys/GzwZ/GZYixmcTawubTeun9VMzKYW3/
	 Gs/blPy7yUyDey5yfg72tO6hRr9HjkNd8TcqljQUiGS0Z3nzu9xECFkz75Xpn6NdPd
	 UROur7BVc3/vw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a352bbd9so766590766b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 10:45:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YznyxjGvBBD7vNfDuJ6WHac+OR6oN80WWQ9t05jBSrSzDYVuun+
	4xBibEX1/0KaB381wYzLMJjv3jDxIUbWOkcrvUbD5uOz+SYNXdfYwDp+o6p2IIT1XZS3n+ZyYXd
	E9EGfWSAMq8gRfiX9NeN54AHHvu0=
X-Google-Smtp-Source: AGHT+IFuZdm7Gg7dB8PC3B2dr5RuHt7GOe5z3S3dlneQMPc1aZMDHljnsw8VBKEdO/LfSUpdfy9JSFa6YJk0vp4RnTg=
X-Received: by 2002:a17:906:32cb:b0:a59:af85:17ed with SMTP id
 a640c23a62f3a-a5a2d29115fmr968557166b.28.1715622309221; Mon, 13 May 2024
 10:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <7d7ca65f30edca3d066310a816aac0a46ecb5d53.1714707707.git.wqu@suse.com>
In-Reply-To: <7d7ca65f30edca3d066310a816aac0a46ecb5d53.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 May 2024 18:44:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5y-0mFZey9PwmMtpPX6wHmLpdwi9KPVbZHATpbrUc9mQ@mail.gmail.com>
Message-ID: <CAL3q7H5y-0mFZey9PwmMtpPX6wHmLpdwi9KPVbZHATpbrUc9mQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] btrfs: remove extent_map::block_len member
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:03=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The extent_map::block_len is either extent_map::len (non-compressed
> extent) or extent_map::disk_num_bytes (compressed extent).
>
> Since we already have sanity checks to do the cross-check between the
> new and old members, we can drop the old extent_map::block_len now.
>
> For most call sites, they can manually select extent_map::len or
> extent_map::disk_num_bytes, since most if not all of them have checked
> if the extent is compressed.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/compression.c            |  2 +-
>  fs/btrfs/extent_map.c             | 41 +++++++++++--------------------
>  fs/btrfs/extent_map.h             |  9 -------
>  fs/btrfs/file-item.c              |  7 ------
>  fs/btrfs/file.c                   |  1 -
>  fs/btrfs/inode.c                  | 36 +++++++++------------------
>  fs/btrfs/relocation.c             |  1 -
>  fs/btrfs/tests/extent-map-tests.c | 41 ++++++++++---------------------
>  fs/btrfs/tree-log.c               |  4 +--
>  include/trace/events/btrfs.h      |  5 +---
>  10 files changed, 42 insertions(+), 105 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index a4cd0e743027..3af87911c83e 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -585,7 +585,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *b=
bio)
>         }
>
>         ASSERT(extent_map_is_compressed(em));
> -       compressed_len =3D em->block_len;
> +       compressed_len =3D em->disk_num_bytes;
>
>         cb =3D alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
>                                   end_bbio_comprssed_read);
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index dc73b8a81271..dcd191c2c4b3 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -186,11 +186,18 @@ static struct rb_node *__tree_search(struct rb_root=
 *root, u64 offset,
>         return NULL;
>  }
>
> +static inline u64 extent_map_block_len(const struct extent_map *em)
> +{
> +       if (extent_map_is_compressed(em))
> +               return em->disk_num_bytes;
> +       return em->len;
> +}
> +
>  static inline u64 extent_map_block_end(const struct extent_map *em)
>  {
> -       if (em->block_start + em->block_len < em->block_start)
> +       if (em->block_start + extent_map_block_len(em) < em->block_start)
>                 return (u64)-1;
> -       return em->block_start + em->block_len;
> +       return em->block_start + extent_map_block_len(em);
>  }
>
>  static bool can_merge_extent_map(const struct extent_map *em)
> @@ -288,10 +295,10 @@ static void dump_extent_map(const char *prefix, str=
uct extent_map *em)
>  {
>         if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
>                 return;
> -       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu block_start=3D%llu block_len=3D=
%llu flags=3D0x%x\n",
> +       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu block_start=3D%llu flags=3D0x%x=
\n",
>                 prefix, em->start, em->len, em->disk_bytenr, em->disk_num=
_bytes,
>                 em->ram_bytes, em->offset, em->block_start,
> -               em->block_len, em->flags);
> +               em->flags);
>         ASSERT(0);
>  }
>
> @@ -313,9 +320,6 @@ static void validate_extent_map(struct extent_map *em=
)
>                         if (em->block_start !=3D em->disk_bytenr)
>                                 dump_extent_map(
>                                 "mismatch block_start/disk_bytenr/offset"=
, em);
> -                       if (em->disk_num_bytes !=3D em->block_len)
> -                               dump_extent_map(
> -                               "mismatch disk_num_bytes/block_len", em);
>                 } else {
>                         if (em->block_start !=3D em->disk_bytenr + em->of=
fset)
>                                 dump_extent_map(
> @@ -354,7 +358,6 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                 if (rb && can_merge_extent_map(merge) && mergeable_maps(m=
erge, em)) {
>                         em->start =3D merge->start;
>                         em->len +=3D merge->len;
> -                       em->block_len +=3D merge->block_len;
>                         em->block_start =3D merge->block_start;
>                         em->generation =3D max(em->generation, merge->gen=
eration);
>
> @@ -375,7 +378,6 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                 merge =3D rb_entry(rb, struct extent_map, rb_node);
>         if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge=
)) {
>                 em->len +=3D merge->len;
> -               em->block_len +=3D merge->block_len;
>                 if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>                         merge_ondisk_extents(em, merge);
>                 validate_extent_map(em);
> @@ -669,7 +671,6 @@ static noinline int merge_extent_mapping(struct btrfs=
_inode *inode,
>         if (em->block_start < EXTENT_MAP_LAST_BYTE &&
>             !extent_map_is_compressed(em)) {
>                 em->block_start +=3D start_diff;
> -               em->block_len =3D em->len;
>                 em->offset +=3D start_diff;
>         }
>         return add_extent_mapping(inode, em, 0);
> @@ -884,17 +885,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                         if (em->block_start < EXTENT_MAP_LAST_BYTE) {
>                                 split->block_start =3D em->block_start;
>
> -                               if (compressed)
> -                                       split->block_len =3D em->block_le=
n;
> -                               else
> -                                       split->block_len =3D split->len;
>                                 split->disk_bytenr =3D em->disk_bytenr;
> -                               split->disk_num_bytes =3D max(split->bloc=
k_len,
> -                                                           em->disk_num_=
bytes);
> +                               split->disk_num_bytes =3D em->disk_num_by=
tes;
>                                 split->offset =3D em->offset;
>                                 split->ram_bytes =3D em->ram_bytes;
>                         } else {
> -                               split->block_len =3D 0;
>                                 split->block_start =3D em->block_start;
>                                 split->disk_bytenr =3D em->disk_bytenr;
>                                 split->disk_num_bytes =3D 0;
> @@ -924,23 +919,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                         split->generation =3D gen;
>
>                         if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> -                               split->disk_num_bytes =3D max(em->block_l=
en,
> -                                                           em->disk_num_=
bytes);
> +                               split->disk_num_bytes =3D em->disk_num_by=
tes;
>                                 split->offset =3D em->offset + end - em->=
start;
>                                 split->ram_bytes =3D em->ram_bytes;
> -                               if (compressed) {
> -                                       split->block_len =3D em->block_le=
n;
> -                               } else {
> +                               if (!compressed) {
>                                         const u64 diff =3D end - em->star=
t;
>
> -                                       split->block_len =3D split->len;
>                                         split->block_start +=3D diff;
>                                 }
>                         } else {
>                                 split->disk_num_bytes =3D 0;
>                                 split->offset =3D 0;
>                                 split->ram_bytes =3D split->len;
> -                               split->block_len =3D 0;
>                         }
>
>                         if (extent_map_in_tree(em)) {
> @@ -1098,8 +1088,6 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>         split_pre->disk_num_bytes =3D split_pre->len;
>         split_pre->offset =3D 0;
>         split_pre->block_start =3D new_logical;
> -       split_pre->block_len =3D split_pre->len;
> -       split_pre->disk_num_bytes =3D split_pre->block_len;

Ok so this relates to my comment on patch 3, which added the first
->disk_num_bytes assignment, a few lines above and visible in this
diff, which was useless because of this one.

This is hard to follow. Some patches add code just to be removed a few
patches later.

>         split_pre->ram_bytes =3D split_pre->len;
>         split_pre->flags =3D flags;
>         split_pre->generation =3D em->generation;
> @@ -1118,7 +1106,6 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>         split_mid->disk_num_bytes =3D split_mid->len;
>         split_mid->offset =3D 0;
>         split_mid->block_start =3D em->block_start + pre;
> -       split_mid->block_len =3D split_mid->len;
>         split_mid->ram_bytes =3D split_mid->len;
>         split_mid->flags =3D flags;
>         split_mid->generation =3D em->generation;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 454a4bb08d95..aee721eaa7f3 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -102,15 +102,6 @@ struct extent_map {
>          */
>         u64 block_start;
>
> -       /*
> -        * The on-disk length for the file extent.
> -        *
> -        * For compressed extents it matches btrfs_file_extent_item::disk=
_num_bytes.
> -        * For uncompressed extents it matches extent_map::len.
> -        * For holes and inline extents it's -1 and shouldn't be used.
> -        */
> -       u64 block_len;
> -
>         /*
>          * Generation of the extent map, for merged em it's the highest
>          * generation of all merged ems.
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 08d608f0ae5d..95fb7c059a1a 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1306,11 +1306,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                         extent_map_set_compression(em, compress_type);
>                         em->block_start =3D bytenr;
> -                       em->block_len =3D em->disk_num_bytes;
>                 } else {
>                         bytenr +=3D btrfs_file_extent_offset(leaf, fi);
>                         em->block_start =3D bytenr;
> -                       em->block_len =3D em->len;
>                         if (type =3D=3D BTRFS_FILE_EXTENT_PREALLOC)
>                                 em->flags |=3D EXTENT_FLAG_PREALLOC;
>                 }
> @@ -1323,11 +1321,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                 em->start =3D 0;
>                 em->len =3D fs_info->sectorsize;
>                 em->offset =3D 0;
> -               /*
> -                * Initialize block_len with the same values
> -                * as in inode.c:btrfs_get_extent().
> -                */
> -               em->block_len =3D (u64)-1;
>                 extent_map_set_compression(em, compress_type);
>         } else {
>                 btrfs_err(fs_info,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index be4e6acb08f3..05c7b5429b85 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2337,7 +2337,6 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>
>                 hole_em->block_start =3D EXTENT_MAP_HOLE;
>                 hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
> -               hole_em->block_len =3D 0;
>                 hole_em->disk_num_bytes =3D 0;
>                 hole_em->generation =3D trans->transid;
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d1c948ea1421..7df295e0046d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -139,7 +139,7 @@ static noinline int run_delalloc_cow(struct btrfs_ino=
de *inode,
>                                      bool pages_dirty);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
>                                        u64 len, u64 block_start,
> -                                      u64 block_len, u64 disk_num_bytes,
> +                                      u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
>                                        int type);
> @@ -1210,7 +1210,6 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>         em =3D create_io_em(inode, start,
>                           async_extent->ram_size,       /* len */
>                           ins.objectid,                 /* block_start */
> -                         ins.offset,                   /* block_len */
>                           ins.offset,                   /* orig_block_len=
 */
>                           async_extent->ram_size,       /* ram_bytes */
>                           async_extent->compress_type,
> @@ -1453,7 +1452,6 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>
>                 em =3D create_io_em(inode, start, ins.offset, /* len */
>                                   ins.objectid, /* block_start */
> -                                 ins.offset, /* block_len */
>                                   ins.offset, /* orig_block_len */
>                                   ram_size, /* ram_bytes */
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
> @@ -2194,7 +2192,6 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>
>                         em =3D create_io_em(inode, cur_offset, nocow_args=
.num_bytes,
>                                           nocow_args.disk_bytenr, /* bloc=
k_start */
> -                                         nocow_args.num_bytes, /* block_=
len */
>                                           nocow_args.disk_num_bytes, /* o=
rig_block_len */
>                                           ram_bytes, BTRFS_COMPRESS_NONE,
>                                           &nocow_args.file_extent,
> @@ -4998,7 +4995,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>
>                         hole_em->block_start =3D EXTENT_MAP_HOLE;
>                         hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
> -                       hole_em->block_len =3D 0;
>                         hole_em->disk_num_bytes =3D 0;
>                         hole_em->ram_bytes =3D hole_size;
>                         hole_em->generation =3D btrfs_get_fs_generation(f=
s_info);
> @@ -6859,7 +6855,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>         em->start =3D EXTENT_MAP_HOLE;
>         em->disk_bytenr =3D EXTENT_MAP_HOLE;
>         em->len =3D (u64)-1;
> -       em->block_len =3D (u64)-1;
>
>         path =3D btrfs_alloc_path();
>         if (!path) {
> @@ -7017,7 +7012,6 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                                                   const u64 start,
>                                                   const u64 len,
>                                                   const u64 block_start,
> -                                                 const u64 block_len,
>                                                   const u64 orig_block_le=
n,
>                                                   const u64 ram_bytes,
>                                                   const int type,
> @@ -7028,14 +7022,14 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
>
>         if (type !=3D BTRFS_ORDERED_NOCOW) {
>                 em =3D create_io_em(inode, start, len, block_start,
> -                                 block_len, orig_block_len, ram_bytes,
> +                                 orig_block_len, ram_bytes,
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
>                                   file_extent, type);
>                 if (IS_ERR(em))
>                         goto out;
>         }
>         ordered =3D btrfs_alloc_ordered_extent(inode, start, len, len,
> -                                            block_start, block_len, 0,
> +                                            block_start, len, 0,
>                                              (1 << type) |
>                                              (1 << BTRFS_ORDERED_DIRECT),
>                                              BTRFS_COMPRESS_NONE);
> @@ -7087,7 +7081,7 @@ static struct extent_map *btrfs_new_extent_direct(s=
truct btrfs_inode *inode,
>         file_extent.offset =3D 0;
>         file_extent.compression =3D BTRFS_COMPRESS_NONE;
>         em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
,
> -                                    ins.objectid, ins.offset, ins.offset=
,
> +                                    ins.objectid, ins.offset,
>                                      ins.offset, BTRFS_ORDERED_REGULAR,
>                                      &file_extent);
>         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> @@ -7328,7 +7322,7 @@ static int lock_extent_direct(struct inode *inode, =
u64 lockstart, u64 lockend,
>  /* The callers of this must take lock_extent() */
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
>                                        u64 len, u64 block_start,
> -                                      u64 block_len, u64 disk_num_bytes,
> +                                      u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
>                                        int type)
> @@ -7350,16 +7344,10 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
>
>         switch (type) {
>         case BTRFS_ORDERED_PREALLOC:
> -               /* Uncompressed extents. */
> -               ASSERT(block_len =3D=3D len);
> -
>                 /* We're only referring part of a larger preallocated ext=
ent. */
> -               ASSERT(block_len <=3D ram_bytes);
> +               ASSERT(len <=3D ram_bytes);
>                 break;
>         case BTRFS_ORDERED_REGULAR:
> -               /* Uncompressed extents. */
> -               ASSERT(block_len =3D=3D len);
> -
>                 /* COW results a new extent matching our file extent size=
. */
>                 ASSERT(disk_num_bytes =3D=3D len);
>                 ASSERT(ram_bytes =3D=3D len);
> @@ -7385,7 +7373,6 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>
>         em->start =3D start;
>         em->len =3D len;
> -       em->block_len =3D block_len;
>         em->block_start =3D block_start;
>         em->disk_bytenr =3D file_extent->disk_bytenr;
>         em->disk_num_bytes =3D disk_num_bytes;
> @@ -7474,7 +7461,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>
>                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
>                                               block_start,
> -                                             len, orig_block_len,
> +                                             orig_block_len,
>                                               ram_bytes, type,
>                                               &file_extent);
>                 btrfs_dec_nocow_writers(bg);
> @@ -9628,7 +9615,6 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>                 em->block_start =3D ins.objectid;
>                 em->disk_bytenr =3D ins.objectid;
>                 em->offset =3D 0;
> -               em->block_len =3D ins.offset;
>                 em->disk_num_bytes =3D ins.offset;
>                 em->ram_bytes =3D ins.offset;
>                 em->flags |=3D EXTENT_FLAG_PREALLOC;
> @@ -10125,12 +10111,12 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, =
struct iov_iter *iter,
>                  * Bail if the buffer isn't large enough to return the wh=
ole
>                  * compressed extent.
>                  */
> -               if (em->block_len > count) {
> +               if (em->disk_num_bytes > count) {
>                         ret =3D -ENOBUFS;
>                         goto out_em;
>                 }
> -               disk_io_size =3D em->block_len;
> -               count =3D em->block_len;
> +               disk_io_size =3D em->disk_num_bytes;
> +               count =3D em->disk_num_bytes;
>                 encoded->unencoded_len =3D em->ram_bytes;
>                 encoded->unencoded_offset =3D iocb->ki_pos - em->start + =
em->offset;
>                 ret =3D btrfs_encoded_io_compression_from_extent(fs_info,
> @@ -10378,7 +10364,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         file_extent.compression =3D compression;
>         em =3D create_io_em(inode, start, num_bytes,
>                           ins.objectid,
> -                         ins.offset, ins.offset, ram_bytes, compression,
> +                         ins.offset, ram_bytes, compression,
>                           &file_extent, BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 33662b3aad38..a66d9b921f84 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2912,7 +2912,6 @@ static noinline_for_stack int setup_relocation_exte=
nt_mapping(struct inode *inod
>
>         em->start =3D start;
>         em->len =3D end + 1 - start;
> -       em->block_len =3D em->len;
>         em->block_start =3D block_start;
>         em->disk_bytenr =3D block_start;
>         em->disk_num_bytes =3D em->len;
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index bd56efe37f02..ffdaa6a682af 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -28,9 +28,10 @@ static int free_extent_map_tree(struct btrfs_inode *in=
ode)
>                 if (refcount_read(&em->refs) !=3D 1) {
>                         ret =3D -EINVAL;
>                         test_err(
> -"em leak: em (start %llu len %llu block_start %llu block_len %llu) refs =
%d",
> +"em leak: em (start %llu len %llu block_start %llu disk_num_bytes %llu o=
ffset %llu) refs %d",
>                                  em->start, em->len, em->block_start,
> -                                em->block_len, refcount_read(&em->refs))=
;
> +                                em->disk_num_bytes, em->offset,
> +                                refcount_read(&em->refs));
>
>                         refcount_set(&em->refs, 1);
>                 }
> @@ -77,7 +78,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, s=
truct btrfs_inode *inode)
>         em->start =3D 0;
>         em->len =3D SZ_16K;
>         em->block_start =3D 0;
> -       em->block_len =3D SZ_16K;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -101,7 +101,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D SZ_16K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_32K; /* avoid merging */
> -       em->block_len =3D SZ_4K;
>         em->disk_bytenr =3D SZ_32K; /* avoid merging */
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_4K;
> @@ -125,7 +124,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D start;
>         em->len =3D len;
>         em->block_start =3D start;
> -       em->block_len =3D len;
>         em->disk_bytenr =3D start;
>         em->disk_num_bytes =3D len;
>         em->ram_bytes =3D len;
> @@ -143,11 +141,11 @@ static int test_case_1(struct btrfs_fs_info *fs_inf=
o, struct btrfs_inode *inode)
>                 goto out;
>         }
>         if (em->start !=3D 0 || extent_map_end(em) !=3D SZ_16K ||
> -           em->block_start !=3D 0 || em->block_len !=3D SZ_16K) {
> +           em->block_start !=3D 0 || em->disk_num_bytes !=3D SZ_16K) {
>                 test_err(
> -"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_=
start %llu block_len %llu",
> +"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_=
start %llu disk_num_bytes %llu",
>                          start, start + len, ret, em->start, em->len,
> -                        em->block_start, em->block_len);
> +                        em->block_start, em->disk_num_bytes);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -182,7 +180,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D 0;
>         em->len =3D SZ_1K;
>         em->block_start =3D EXTENT_MAP_INLINE;
> -       em->block_len =3D (u64)-1;
>         em->disk_bytenr =3D EXTENT_MAP_INLINE;
>         em->disk_num_bytes =3D 0;
>         em->ram_bytes =3D SZ_1K;
> @@ -206,7 +203,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_4K;
> -       em->block_len =3D SZ_4K;
>         em->disk_bytenr =3D SZ_4K;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_4K;
> @@ -230,7 +226,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D 0;
>         em->len =3D SZ_1K;
>         em->block_start =3D EXTENT_MAP_INLINE;
> -       em->block_len =3D (u64)-1;
>         em->disk_bytenr =3D EXTENT_MAP_INLINE;
>         em->disk_num_bytes =3D 0;
>         em->ram_bytes =3D SZ_1K;
> @@ -247,11 +242,10 @@ static int test_case_2(struct btrfs_fs_info *fs_inf=
o, struct btrfs_inode *inode)
>                 goto out;
>         }
>         if (em->start !=3D 0 || extent_map_end(em) !=3D SZ_1K ||
> -           em->block_start !=3D EXTENT_MAP_INLINE || em->block_len !=3D =
(u64)-1) {
> +           em->block_start !=3D EXTENT_MAP_INLINE) {
>                 test_err(
> -"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start=
 %llu block_len %llu",
> -                        ret, em->start, em->len, em->block_start,
> -                        em->block_len);
> +"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start=
 %llu",
> +                        ret, em->start, em->len, em->block_start);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -282,7 +276,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_inf=
o,
>         em->start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_4K;
> -       em->block_len =3D SZ_4K;
>         em->disk_bytenr =3D SZ_4K;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_4K;
> @@ -306,7 +299,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_inf=
o,
>         em->start =3D 0;
>         em->len =3D SZ_16K;
>         em->block_start =3D 0;
> -       em->block_len =3D SZ_16K;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -329,11 +321,11 @@ static int __test_case_3(struct btrfs_fs_info *fs_i=
nfo,
>          * em->start.
>          */
>         if (start < em->start || start + len > extent_map_end(em) ||
> -           em->start !=3D em->block_start || em->len !=3D em->block_len)=
 {
> +           em->start !=3D em->block_start) {
>                 test_err(
>  "case3 [%llu %llu): ret %d em (start %llu len %llu block_start %llu bloc=
k_len %llu)",
>                          start, start + len, ret, em->start, em->len,
> -                        em->block_start, em->block_len);
> +                        em->block_start, em->disk_num_bytes);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -395,7 +387,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         em->start =3D 0;
>         em->len =3D SZ_8K;
>         em->block_start =3D 0;
> -       em->block_len =3D SZ_8K;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_8K;
>         em->ram_bytes =3D SZ_8K;
> @@ -419,7 +410,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         em->start =3D SZ_8K;
>         em->len =3D 24 * SZ_1K;
>         em->block_start =3D SZ_16K; /* avoid merging */
> -       em->block_len =3D 24 * SZ_1K;
>         em->disk_bytenr =3D SZ_16K; /* avoid merging */
>         em->disk_num_bytes =3D 24 * SZ_1K;
>         em->ram_bytes =3D 24 * SZ_1K;
> @@ -442,7 +432,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         em->start =3D 0;
>         em->len =3D SZ_32K;
>         em->block_start =3D 0;
> -       em->block_len =3D SZ_32K;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_32K;
>         em->ram_bytes =3D SZ_32K;
> @@ -462,9 +451,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         }
>         if (start < em->start || start + len > extent_map_end(em)) {
>                 test_err(
> -"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_st=
art %llu block_len %llu)",
> +"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_st=
art %llu disk_num_bytes %llu)",
>                          start, start + len, ret, em->start, em->len, em-=
>block_start,
> -                        em->block_len);
> +                        em->disk_num_bytes);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -529,7 +518,6 @@ static int add_compressed_extent(struct btrfs_inode *=
inode,
>         em->start =3D start;
>         em->len =3D len;
>         em->block_start =3D block_start;
> -       em->block_len =3D SZ_4K;
>         em->disk_bytenr =3D block_start;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D len;
> @@ -753,7 +741,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_16K;
> -       em->block_len =3D SZ_16K;
>         em->disk_bytenr =3D SZ_16K;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -809,7 +796,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D 0;
>         em->len =3D SZ_16K;
>         em->block_start =3D 0;
> -       em->block_len =3D SZ_4K;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_16K;
> @@ -834,7 +820,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->start =3D SZ_32K;
>         em->len =3D SZ_16K;
>         em->block_start =3D SZ_32K;
> -       em->block_len =3D SZ_16K;
>         em->disk_bytenr =3D SZ_32K;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c9e8c5f96b1c..13f35180e3a0 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4648,7 +4648,7 @@ static int log_extent_csums(struct btrfs_trans_hand=
le *trans,
>         /* If we're compressed we have to save the entire range of csums.=
 */
>         if (extent_map_is_compressed(em)) {
>                 csum_offset =3D 0;
> -               csum_len =3D max(em->block_len, em->disk_num_bytes);
> +               csum_len =3D em->disk_num_bytes;
>         } else {
>                 csum_offset =3D mod_start - em->start;
>                 csum_len =3D mod_len;
> @@ -4698,7 +4698,7 @@ static int log_one_extent(struct btrfs_trans_handle=
 *trans,
>         else
>                 btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_R=
EG);
>
> -       block_len =3D max(em->block_len, em->disk_num_bytes);
> +       block_len =3D em->disk_num_bytes;
>         compress_type =3D extent_map_compression(em);
>         if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                 btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_st=
art);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 6dacdc1fb63e..3743719d13f2 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -292,7 +292,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>                 __field(        u64,  start             )
>                 __field(        u64,  len               )
>                 __field(        u64,  block_start       )
> -               __field(        u64,  block_len         )
>                 __field(        u32,  flags             )
>                 __field(        int,  refs              )
>         ),
> @@ -303,19 +302,17 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>                 __entry->start          =3D map->start;
>                 __entry->len            =3D map->len;
>                 __entry->block_start    =3D map->block_start;
> -               __entry->block_len      =3D map->block_len;
>                 __entry->flags          =3D map->flags;
>                 __entry->refs           =3D refcount_read(&map->refs);
>         ),
>
>         TP_printk_btrfs("root=3D%llu(%s) ino=3D%llu start=3D%llu len=3D%l=
lu "
> -                 "block_start=3D%llu(%s) block_len=3D%llu flags=3D%s ref=
s=3D%u",
> +                 "block_start=3D%llu(%s) flags=3D%s refs=3D%u",
>                   show_root_type(__entry->root_objectid),
>                   __entry->ino,
>                   __entry->start,
>                   __entry->len,
>                   show_map_type(__entry->block_start),
> -                 __entry->block_len,
>                   show_map_flags(__entry->flags),
>                   __entry->refs)
>  );
> --
> 2.45.0
>
>

