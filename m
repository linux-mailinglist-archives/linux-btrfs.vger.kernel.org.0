Return-Path: <linux-btrfs+bounces-5114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D254D8CA056
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7271F22441
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA2137764;
	Mon, 20 May 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCWAn4QJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9244C66
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220577; cv=none; b=DIq5beJqmnFxD3njo3jgtvLnAGvP8R4cbrpkzjm3GHvIIwnqzaFQhc3bvZHAesH/dKfvMyIEwlg4g/Iv5bFCi4RePPkYpU2W/j/CHKW8QZZaG2jh8/0PYGGLO69AGXwrmRXikAUq/nmaiUxJurXPG4sy2d9w6i0Vw9ys+b4URq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220577; c=relaxed/simple;
	bh=I3UH60wvTxTQpw64/ON5lwrRMsMwgM7Bz5Ovr/oXhVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoujACy9X9Y4wV9MGu7IOXgf/P82AfsXjEvVekMAVKZdN6DAYXcfXay9XPXyC5/RFAlDPrnTkkEtdTaOGzl1LUUJ9FHs+tg89Ho9pj181sOrvDJTguuu8LHQ9qESX0K+v8QGXISjcAntKd/0ZOIOh0BwYI5LkEWmFjcKhGBFd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCWAn4QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0A2C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716220577;
	bh=I3UH60wvTxTQpw64/ON5lwrRMsMwgM7Bz5Ovr/oXhVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VCWAn4QJY+J74nGPah6xOtG0obj+vBL+57vwVjYkwbJXG2pJ/G/JM/ak7ycmlZ73L
	 RNdKXw7HHJF9STvD/wZFH7uMQV+9UoHTKx2I7yDQWxq4aOC6Mvgh6G+oV+c4F9CTO0
	 wzzUh1oYBawK/2wX3PT6MpQbV5RMc/ItSDHDB4mdVFatIyGwdF6CitgCZF8LaI8OMw
	 nBkDWvmvlWFHzE8uOyXWbUbwVTxLs65bMuZnsBIj8151t+dTuSCd6y8t1YCjz4Y6Vk
	 ev7jY/h10zZfq9+LKa+RVLhSVYZ2GuCynUN7Vtj/js0L8EBIsjTWH4hb7Wpzi7ZFAL
	 QpPdGqzzA8rDg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5766cd9ca1bso2088809a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 08:56:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwbfQ8Ka5INBbSU7rqO8jmar/n35y6GUyVKqAtWyL9sPTisnkVf
	dbnf5GtM3DbL3JnHQnRfksj662XunuB/2d0z8mikFoDnraz/JFkFuYh86ksX8EM6bppAVXYYelO
	TfapGNjxe8593JuGIgUpLR9H3pSc=
X-Google-Smtp-Source: AGHT+IE54oExn4YNFk2BsbhpT7ukziAZ4HDqK5hEH17LVB/+r1eeVSw0BqaVCYklE8tk/t4MtDujNBA8S3XLbgoJ2G0=
X-Received: by 2002:a17:906:2b48:b0:a59:c9ce:338b with SMTP id
 a640c23a62f3a-a5a2d5f1479mr2107575366b.35.1716220575623; Mon, 20 May 2024
 08:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <5f31db841be606ec0bf8693377647f572ac9f4e7.1714707707.git.wqu@suse.com>
In-Reply-To: <5f31db841be606ec0bf8693377647f572ac9f4e7.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 16:55:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H63NVAS9Hy6mMZkU4mdBZvLrudWYkZ6eS=L8uH9rbJgfw@mail.gmail.com>
Message-ID: <CAL3q7H63NVAS9Hy6mMZkU4mdBZvLrudWYkZ6eS=L8uH9rbJgfw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] btrfs: cleanup duplicated parameters related to can_nocow_file_extent_args
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The following functions and structures can be simplified using the
> btrfs_file_extent structure:
>
> - can_nocow_extent()
>   No need to return ram_bytes/orig_block_len through the parameter list,
>   the @file_extent parameter contains all needed info.
>
> - can_nocow_file_extent_args
>   The following members are no longer needed:
>
>   * disk_bytenr
>     This one is confusing as it's not really the
>     btrfs_file_extent_item::disk_bytenr, but where the IO would be,
>     thus it's file_extent::disk_bytenr + file_extent::offset now.
>
>   * num_bytes
>     Now file_extent::num_bytes.
>
>   * extent_offset
>     Now file_extent::offset.
>
>   * disk_num_bytes
>     Now file_extent::disk_num_bytes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h |  3 +-
>  fs/btrfs/file.c        |  2 +-
>  fs/btrfs/inode.c       | 89 +++++++++++++++++++-----------------------
>  3 files changed, 42 insertions(+), 52 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index f30afce4f6ca..bea343615ad1 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -461,8 +461,7 @@ struct btrfs_file_extent {
>  };
>
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> -                             u64 *orig_block_len,
> -                             u64 *ram_bytes, struct btrfs_file_extent *f=
ile_extent,
> +                             struct btrfs_file_extent *file_extent,
>                               bool nowait, bool strict);
>
>  void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 102b5c17ece1..6aaeb9ee048d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1104,7 +1104,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inod=
e, loff_t pos,
>                                                    &cached_state);
>         }
>         ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes=
,
> -                       NULL, NULL, NULL, nowait, false);
> +                              NULL, nowait, false);
>         if (ret <=3D 0)
>                 btrfs_drew_write_unlock(&root->snapshot_lock);
>         else
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8bc1f165193a..89f284ae26a4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1862,16 +1862,10 @@ struct can_nocow_file_extent_args {
>          */
>         bool free_path;
>
> -       /* Output fields. Only set when can_nocow_file_extent() returns 1=
. */
> -
> -       u64 disk_bytenr;
> -       u64 disk_num_bytes;
> -       u64 extent_offset;
> -
> -       /* Number of bytes that can be written to in NOCOW mode. */
> -       u64 num_bytes;
> -
> -       /* The expected file extent for the NOCOW write. */
> +       /*
> +        * Output fields. Only set when can_nocow_file_extent() returns 1=
.
> +        * The expected file extent for the NOCOW write.
> +        */
>         struct btrfs_file_extent file_extent;
>  };
>
> @@ -1894,6 +1888,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>         struct btrfs_root *root =3D inode->root;
>         struct btrfs_file_extent_item *fi;
>         struct btrfs_root *csum_root;
> +       u64 io_start;
>         u64 extent_end;
>         u8 extent_type;
>         int can_nocow =3D 0;
> @@ -1906,11 +1901,6 @@ static int can_nocow_file_extent(struct btrfs_path=
 *path,
>         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE)
>                 goto out;
>
> -       /* Can't access these fields unless we know it's not an inline ex=
tent. */
> -       args->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> -       args->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(leaf, f=
i);
> -       args->extent_offset =3D btrfs_file_extent_offset(leaf, fi);
> -
>         if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
>             extent_type =3D=3D BTRFS_FILE_EXTENT_REG)
>                 goto out;
> @@ -1926,7 +1916,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>                 goto out;
>
>         /* An explicit hole, must COW. */
> -       if (args->disk_bytenr =3D=3D 0)
> +       if (btrfs_file_extent_disk_num_bytes(leaf, fi) =3D=3D 0)

No, this is not correct.
It's btrfs_file_extent_disk_bytenr() that we want, not
btrfs_file_extent_disk_num_bytes().
In fact a disk_num_bytes of 0 should ve invalid and never happen.

>                 goto out;
>
>         /* Compressed/encrypted/encoded extents must be COWed. */
> @@ -1951,8 +1941,8 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>         btrfs_release_path(path);
>
>         ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
> -                                   key->offset - args->extent_offset,
> -                                   args->disk_bytenr, args->strict, path=
);
> +                                   key->offset - args->file_extent.offse=
t,
> +                                   args->file_extent.disk_bytenr, args->=
strict, path);
>         WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>         if (ret !=3D 0)
>                 goto out;
> @@ -1973,21 +1963,18 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>             atomic_read(&root->snapshot_force_cow))
>                 goto out;
>
> -       args->disk_bytenr +=3D args->extent_offset;
> -       args->disk_bytenr +=3D args->start - key->offset;
> -       args->num_bytes =3D min(args->end + 1, extent_end) - args->start;
> -
> -       args->file_extent.num_bytes =3D args->num_bytes;
> +       args->file_extent.num_bytes =3D min(args->end + 1, extent_end) - =
args->start;
>         args->file_extent.offset +=3D args->start - key->offset;
> +       io_start =3D args->file_extent.disk_bytenr + args->file_extent.of=
fset;
>
>         /*
>          * Force COW if csums exist in the range. This ensures that csums=
 for a
>          * given extent are either valid or do not exist.
>          */
>
> -       csum_root =3D btrfs_csum_root(root->fs_info, args->disk_bytenr);
> -       ret =3D btrfs_lookup_csums_list(csum_root, args->disk_bytenr,
> -                                     args->disk_bytenr + args->num_bytes=
 - 1,
> +       csum_root =3D btrfs_csum_root(root->fs_info, io_start);
> +       ret =3D btrfs_lookup_csums_list(csum_root, io_start,
> +                                     io_start + args->file_extent.num_by=
tes - 1,
>                                       NULL, nowait);
>         WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>         if (ret !=3D 0)
> @@ -2046,7 +2033,6 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>                 struct extent_buffer *leaf;
>                 struct extent_state *cached_state =3D NULL;
>                 u64 extent_end;
> -               u64 ram_bytes;
>                 u64 nocow_end;
>                 int extent_type;
>                 bool is_prealloc;
> @@ -2125,7 +2111,6 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>                         ret =3D -EUCLEAN;
>                         goto error;
>                 }
> -               ram_bytes =3D btrfs_file_extent_ram_bytes(leaf, fi);
>                 extent_end =3D btrfs_file_extent_end(path);
>
>                 /*
> @@ -2145,7 +2130,9 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>                         goto must_cow;
>
>                 ret =3D 0;
> -               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_args.=
disk_bytenr);
> +               nocow_bg =3D btrfs_inc_nocow_writers(fs_info,
> +                               nocow_args.file_extent.disk_bytenr +
> +                               nocow_args.file_extent.offset);
>                 if (!nocow_bg) {
>  must_cow:
>                         /*
> @@ -2181,16 +2168,18 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>                         }
>                 }
>
> -               nocow_end =3D cur_offset + nocow_args.num_bytes - 1;
> +               nocow_end =3D cur_offset + nocow_args.file_extent.num_byt=
es - 1;
>                 lock_extent(&inode->io_tree, cur_offset, nocow_end, &cach=
ed_state);
>
>                 is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTENT_PREA=
LLOC;
>                 if (is_prealloc) {
>                         struct extent_map *em;
>
> -                       em =3D create_io_em(inode, cur_offset, nocow_args=
.num_bytes,
> -                                         nocow_args.disk_num_bytes, /* o=
rig_block_len */
> -                                         ram_bytes, BTRFS_COMPRESS_NONE,
> +                       em =3D create_io_em(inode, cur_offset,
> +                                         nocow_args.file_extent.num_byte=
s,
> +                                         nocow_args.file_extent.disk_num=
_bytes,
> +                                         nocow_args.file_extent.ram_byte=
s,
> +                                         BTRFS_COMPRESS_NONE,
>                                           &nocow_args.file_extent,
>                                           BTRFS_ORDERED_PREALLOC);
>                         if (IS_ERR(em)) {
> @@ -2203,9 +2192,16 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>                         free_extent_map(em);
>                 }
>
> +               /*
> +                * Check btrfs_create_dio_extent() for why we intentional=
ly pass
> +                * incorrect value for NOCOW/PREALLOC OEs.
> +                */

If in the next version you remove that similar comment/rant about OEs
and disk_bytenr, also remove this one.

Everything else in this patch looks fine, thanks.


>                 ordered =3D btrfs_alloc_ordered_extent(inode, cur_offset,
> -                               nocow_args.num_bytes, nocow_args.num_byte=
s,
> -                               nocow_args.disk_bytenr, nocow_args.num_by=
tes, 0,
> +                               nocow_args.file_extent.num_bytes,
> +                               nocow_args.file_extent.num_bytes,
> +                               nocow_args.file_extent.disk_bytenr +
> +                               nocow_args.file_extent.offset,
> +                               nocow_args.file_extent.num_bytes, 0,
>                                 is_prealloc
>                                 ? (1 << BTRFS_ORDERED_PREALLOC)
>                                 : (1 << BTRFS_ORDERED_NOCOW),
> @@ -7144,8 +7140,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr)
>   *      any ordered extents.
>   */
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> -                             u64 *orig_block_len,
> -                             u64 *ram_bytes, struct btrfs_file_extent *f=
ile_extent,
> +                             struct btrfs_file_extent *file_extent,
>                               bool nowait, bool strict)
>  {
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> @@ -7196,8 +7191,6 @@ noinline int can_nocow_extent(struct inode *inode, =
u64 offset, u64 *len,
>
>         fi =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_ext=
ent_item);
>         found_type =3D btrfs_file_extent_type(leaf, fi);
> -       if (ram_bytes)
> -               *ram_bytes =3D btrfs_file_extent_ram_bytes(leaf, fi);
>
>         nocow_args.start =3D offset;
>         nocow_args.end =3D offset + *len - 1;
> @@ -7215,14 +7208,15 @@ noinline int can_nocow_extent(struct inode *inode=
, u64 offset, u64 *len,
>         }
>
>         ret =3D 0;
> -       if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
> +       if (btrfs_extent_readonly(fs_info,
> +                               nocow_args.file_extent.disk_bytenr + noco=
w_args.file_extent.offset))
>                 goto out;
>
>         if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
>             found_type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
>                 u64 range_end;
>
> -               range_end =3D round_up(offset + nocow_args.num_bytes,
> +               range_end =3D round_up(offset + nocow_args.file_extent.nu=
m_bytes,
>                                      root->fs_info->sectorsize) - 1;
>                 ret =3D test_range_bit_exists(io_tree, offset, range_end,=
 EXTENT_DELALLOC);
>                 if (ret) {
> @@ -7231,13 +7225,11 @@ noinline int can_nocow_extent(struct inode *inode=
, u64 offset, u64 *len,
>                 }
>         }
>
> -       if (orig_block_len)
> -               *orig_block_len =3D nocow_args.disk_num_bytes;
>         if (file_extent)
>                 memcpy(file_extent, &nocow_args.file_extent,
>                        sizeof(struct btrfs_file_extent));
>
> -       *len =3D nocow_args.num_bytes;
> +       *len =3D nocow_args.file_extent.num_bytes;
>         ret =3D 1;
>  out:
>         btrfs_free_path(path);
> @@ -7422,7 +7414,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>         struct btrfs_file_extent file_extent =3D { 0 };
>         struct extent_map *em =3D *map;
>         int type;
> -       u64 block_start, orig_block_len, ram_bytes;
> +       u64 block_start;
>         struct btrfs_block_group *bg;
>         bool can_nocow =3D false;
>         bool space_reserved =3D false;
> @@ -7450,7 +7442,6 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 block_start =3D extent_map_block_start(em) + (start - em-=
>start);
>
>                 if (can_nocow_extent(inode, start, &len,
> -                                    &orig_block_len, &ram_bytes,
>                                      &file_extent, false, false) =3D=3D 1=
) {
>                         bg =3D btrfs_inc_nocow_writers(fs_info, block_sta=
rt);
>                         if (bg)
> @@ -7477,8 +7468,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 space_reserved =3D true;
>
>                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
> -                                             orig_block_len,
> -                                             ram_bytes, type,
> +                                             file_extent.disk_num_bytes,
> +                                             file_extent.ram_bytes, type=
,
>                                               &file_extent);
>                 btrfs_dec_nocow_writers(bg);
>                 if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
> @@ -10709,7 +10700,7 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>                 free_extent_map(em);
>                 em =3D NULL;
>
> -               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL, false, true);
> +               ret =3D can_nocow_extent(inode, start, &len, NULL, false,=
 true);
>                 if (ret < 0) {
>                         goto out;
>                 } else if (ret) {
> --
> 2.45.0
>
>

