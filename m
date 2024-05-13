Return-Path: <linux-btrfs+bounces-4937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905678C4613
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31751C22EBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E432942F;
	Mon, 13 May 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw/T8MZu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4661286AD
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621541; cv=none; b=sQe/+8oMhhJ8/rxdbnKY1nrAHxih6neYvClkzpRwZWPUr9n0m+BbZhQUGvEKwWLqoT+wVmup0qnPbc6Rho9F0EVZxUFNa7HmT0ailtKw8k8ecbQQE8YwUITV2usRbSnWj8CklMwxhN9LdkHDgIHhuZXTahZIa3UecJrPOur2UCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621541; c=relaxed/simple;
	bh=3BuVo2oJcBCRN1LJ319jBwJXYOC1+e4Y+i4Benu8j8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDwQz5NmZdiEDI2h9Bx6EMg2rhCBodtW7Ah/4ghVXuDsqtYU6kdmrMiUSQsiwgi5+NQb5bFHUlhW+FUXBlkikC3br+TQmdCYT0VAkvW3uMS9trYul6HdxufDLE69GN8U1abUX76mBgh8XKqbNBeQOdLKwByMcQDKOQWsCKpSOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw/T8MZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E05C32786
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715621541;
	bh=3BuVo2oJcBCRN1LJ319jBwJXYOC1+e4Y+i4Benu8j8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cw/T8MZuIrolKiR7EK6a+qEDP9GOacWORx3lNkjsQzXWlPbz8RCH4HIGeoK0MfuYe
	 mrrxot2+Q7tBCDdGzv5eIzSPoauLnjmuYHumHNKoBkCp8mh5msN64RcVIR+pp2KBQJ
	 ljZZiDG56tZvNZLTo5qa7KwT2L1kS2Mdtsh7eQjsFv1SSl0NDxQ6R8/k0nhuWCVw9x
	 YDhNihLOuZYN2x0jtJ43xn5rbpZda7A1MWQTTZU+DxfmwgTGyAXiTLSZz5YyJCtl8g
	 2EZ5cP8WQYY8KSFApL3XdliE1t3z7dp13eC8f4bQbkglRFjNlQJfpIUcLq3IV9G4un
	 9SgiD3NsSDsPQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a64db066so1170433066b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 10:32:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyeH+1n5BlHTPRF8kI6w2dnOclhwjbZiLX9d/n0gI5fgS0OmHyq
	yBIspy+DOx/phBgBNXZYVghz67M07PHYHALfuAmrLAvxhh7VQFycVN1QC4xV1yK3yEgY+MRHsH8
	xntUqdEQt8yXMYhKyQiJdwfMRcBg=
X-Google-Smtp-Source: AGHT+IHUaB3c2tMnZ08Vts0AIiTb+S8Pv9uKIV1n+RsEON/fxOqKeFNEKIehRKuKPS6Gj29+KTHacGY2wETKmas9tnQ=
X-Received: by 2002:a17:906:4ecf:b0:a59:9dbf:677b with SMTP id
 a640c23a62f3a-a5a2d665400mr690032066b.48.1715621539694; Mon, 13 May 2024
 10:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
In-Reply-To: <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 May 2024 18:31:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6uOUxe8=dkjApY0aFw5RF_B0k_oJqO9vrFL35NaS=qMQ@mail.gmail.com>
Message-ID: <CAL3q7H6uOUxe8=dkjApY0aFw5RF_B0k_oJqO9vrFL35NaS=qMQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] btrfs: introduce new members for extent_map
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Introduce two new members for extent_map:
>
> - disk_bytenr
> - offset
>
> Both are matching the members with the same name inside
> btrfs_file_extent_items.
>
> For now this patch only touches those members when:
>
> - Reading btrfs_file_extent_items from disk
> - Inserting new holes
> - Merging two extent maps
>   With the new disk_bytenr and disk_num_bytes, doing merging would be a
>   little complex, as we have 3 different cases:
>
>   * Both extent maps are referring to the same data extent
>   * Both extent maps are referring to different data extents, but
>     those data extents are adjacent, and extent maps are at head/tail
>     of each data extents
>   * One of the extent map is referring to an merged and larger data
>     extent that covers both extent maps
>
>   The 3rd case seems only valid in selftest (test_case_3()), but
>   a new helper merge_ondisk_extents() should be able to handle all of
>   them.
>
> To properly assign values for those new members, a new btrfs_file_extent
> parameter is introduced to all the involved call sites.
>
> - For NOCOW writes the btrfs_file_extent would be exposed from
>   can_nocow_file_extent().
>
> - For other writes, the members can be easily calculated
>   As most of them have 0 offset and utilizing the whole on-disk data
>   extent.
>   The exception is encoded write, but thankfully that interface provided
>   offset directly and all other needed info.
>
> For now, both the old members (block_start/block_len/orig_start) are
> co-existing with the new members (disk_bytenr/offset), meanwhile all the
> critical code is still using the old members only.
>
> The cleanup would happen later after all the older and newer members are
> properly validated.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/defrag.c     |  4 +++
>  fs/btrfs/extent_map.c | 75 +++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/extent_map.h | 17 ++++++++++
>  fs/btrfs/file-item.c  |  9 +++++-
>  fs/btrfs/file.c       |  1 +
>  fs/btrfs/inode.c      | 60 ++++++++++++++++++++++++++++++----
>  6 files changed, 155 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 407ccec3e57e..242c5469f4ba 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -709,6 +709,10 @@ static struct extent_map *defrag_get_extent(struct b=
trfs_inode *inode,
>                         em->start =3D start;
>                         em->orig_start =3D start;
>                         em->block_start =3D EXTENT_MAP_HOLE;
> +                       em->disk_bytenr =3D EXTENT_MAP_HOLE;
> +                       em->disk_num_bytes =3D 0;
> +                       em->ram_bytes =3D 0;
> +                       em->offset =3D 0;
>                         em->len =3D key.offset - start;
>                         break;
>                 }
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 4230dd0f34cc..4d4ac9fc43e2 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -232,6 +232,58 @@ static bool mergeable_maps(const struct extent_map *=
prev, const struct extent_ma
>         return next->block_start =3D=3D prev->block_start;
>  }
>
> +/*
> + * Handle the ondisk data extents merge for @prev and @next.
> + *
> + * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
> + * For now only uncompressed regular extent can be merged.
> + *
> + * @prev and @next will be both updated to point to the new merged range=
.
> + * Thus one of them should be removed by the caller.
> + */
> +static void merge_ondisk_extents(struct extent_map *prev, struct extent_=
map *next)
> +{
> +       u64 new_disk_bytenr;
> +       u64 new_disk_num_bytes;
> +       u64 new_offset;
> +
> +       /* @prev and @next should not be compressed. */
> +       ASSERT(!extent_map_is_compressed(prev));
> +       ASSERT(!extent_map_is_compressed(next));
> +
> +       /*
> +        * There are several different cases that @prev and @next can be =
merged.
> +        *
> +        * 1) They are referring to the same data extent
> +        * 2) Their ondisk data extents are adjacent and @prev is the tai=
l
> +        *    and @next is the head of their data extents
> +        * 3) One of @prev/@next is referrring to a larger merged data ex=
tent.
> +        *    (test_case_3 of extent maps tests).
> +        *
> +        * The calculation here always merge the data extents first, then=
 update
> +        * @offset using the new data extents.
> +        *
> +        * For case 1), the merged data extent would be the same.
> +        * For case 2), we just merge the two data extents into one.
> +        * For case 3), we just got the larger data extent.
> +        */
> +       new_disk_bytenr =3D min(prev->disk_bytenr, next->disk_bytenr);
> +       new_disk_num_bytes =3D max(prev->disk_bytenr + prev->disk_num_byt=
es,
> +                                next->disk_bytenr + next->disk_num_bytes=
) -
> +                            new_disk_bytenr;
> +       new_offset =3D prev->disk_bytenr + prev->offset - new_disk_bytenr=
;
> +
> +       prev->disk_bytenr =3D new_disk_bytenr;
> +       prev->disk_num_bytes =3D new_disk_num_bytes;
> +       prev->ram_bytes =3D new_disk_num_bytes;
> +       prev->offset =3D new_offset;
> +
> +       next->disk_bytenr =3D new_disk_bytenr;
> +       next->disk_num_bytes =3D new_disk_num_bytes;
> +       next->ram_bytes =3D new_disk_num_bytes;
> +       next->offset =3D new_offset;
> +}
> +
>  static void try_merge_map(struct btrfs_inode *inode, struct extent_map *=
em)
>  {
>         struct extent_map_tree *tree =3D &inode->extent_tree;
> @@ -263,6 +315,9 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                         em->block_len +=3D merge->block_len;
>                         em->block_start =3D merge->block_start;
>                         em->generation =3D max(em->generation, merge->gen=
eration);
> +
> +                       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> +                               merge_ondisk_extents(merge, em);
>                         em->flags |=3D EXTENT_FLAG_MERGED;
>
>                         rb_erase_cached(&merge->rb_node, &tree->map);
> @@ -278,6 +333,8 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>         if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge=
)) {
>                 em->len +=3D merge->len;
>                 em->block_len +=3D merge->block_len;
> +               if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> +                       merge_ondisk_extents(em, merge);
>                 rb_erase_cached(&merge->rb_node, &tree->map);
>                 RB_CLEAR_NODE(&merge->rb_node);
>                 em->generation =3D max(em->generation, merge->generation)=
;
> @@ -565,6 +622,7 @@ static noinline int merge_extent_mapping(struct btrfs=
_inode *inode,
>             !extent_map_is_compressed(em)) {
>                 em->block_start +=3D start_diff;
>                 em->block_len =3D em->len;
> +               em->offset +=3D start_diff;
>         }
>         return add_extent_mapping(inode, em, 0);
>  }
> @@ -783,14 +841,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                                         split->block_len =3D em->block_le=
n;
>                                 else
>                                         split->block_len =3D split->len;
> +                               split->disk_bytenr =3D em->disk_bytenr;
>                                 split->disk_num_bytes =3D max(split->bloc=
k_len,
>                                                             em->disk_num_=
bytes);
> +                               split->offset =3D em->offset;
>                                 split->ram_bytes =3D em->ram_bytes;
>                         } else {
>                                 split->orig_start =3D split->start;
>                                 split->block_len =3D 0;
>                                 split->block_start =3D em->block_start;
> +                               split->disk_bytenr =3D em->disk_bytenr;
>                                 split->disk_num_bytes =3D 0;
> +                               split->offset =3D 0;
>                                 split->ram_bytes =3D split->len;
>                         }
>
> @@ -811,13 +873,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                         split->start =3D end;
>                         split->len =3D em_end - end;
>                         split->block_start =3D em->block_start;
> +                       split->disk_bytenr =3D em->disk_bytenr;
>                         split->flags =3D flags;
>                         split->generation =3D gen;
>
>                         if (em->block_start < EXTENT_MAP_LAST_BYTE) {
>                                 split->disk_num_bytes =3D max(em->block_l=
en,
>                                                             em->disk_num_=
bytes);
> -
> +                               split->offset =3D em->offset + end - em->=
start;
>                                 split->ram_bytes =3D em->ram_bytes;
>                                 if (compressed) {
>                                         split->block_len =3D em->block_le=
n;
> @@ -830,10 +893,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                                         split->orig_start =3D em->orig_st=
art;
>                                 }
>                         } else {
> +                               split->disk_num_bytes =3D 0;
> +                               split->offset =3D 0;
>                                 split->ram_bytes =3D split->len;
>                                 split->orig_start =3D split->start;
>                                 split->block_len =3D 0;
> -                               split->disk_num_bytes =3D 0;
>                         }
>
>                         if (extent_map_in_tree(em)) {
> @@ -987,6 +1051,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 =
start, u64 len, u64 pre,
>         /* First, replace the em with a new extent_map starting from * em=
->start */
>         split_pre->start =3D em->start;
>         split_pre->len =3D pre;
> +       split_pre->disk_bytenr =3D new_logical;
> +       split_pre->disk_num_bytes =3D split_pre->len;

So this assignment of ->disk_num_bytes is redundant, because a few
lines below (not shown in the patch diff), there's this:

split_pre->disk_num_bytes =3D split_pre->block_len;

Which overwrites this statement.


> +       split_pre->offset =3D 0;
>         split_pre->orig_start =3D split_pre->start;
>         split_pre->block_start =3D new_logical;
>         split_pre->block_len =3D split_pre->len;
> @@ -1005,10 +1072,12 @@ int split_extent_map(struct btrfs_inode *inode, u=
64 start, u64 len, u64 pre,
>         /* Insert the middle extent_map. */
>         split_mid->start =3D em->start + pre;
>         split_mid->len =3D em->len - pre;
> +       split_mid->disk_bytenr =3D em->block_start + pre;
> +       split_mid->disk_num_bytes =3D split_mid->len;
> +       split_mid->offset =3D 0;
>         split_mid->orig_start =3D split_mid->start;
>         split_mid->block_start =3D em->block_start + pre;
>         split_mid->block_len =3D split_mid->len;
> -       split_mid->disk_num_bytes =3D split_mid->block_len;
>         split_mid->ram_bytes =3D split_mid->len;
>         split_mid->flags =3D flags;
>         split_mid->generation =3D em->generation;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 6ea0287b0d61..cc9c8092b704 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -70,12 +70,29 @@ struct extent_map {
>          */
>         u64 orig_start;
>
> +       /*
> +        * The bytenr for of the full on-disk extent.
> +        *
> +        * For regular extents it's btrfs_file_extent_item::disk_bytenr.
> +        * For holes it's EXTENT_MAP_HOLE and for inline extents it's
> +        * EXTENT_MAP_INLINE.
> +        */
> +       u64 disk_bytenr;
> +
>         /*
>          * The full on-disk extent length, matching
>          * btrfs_file_extent_item::disk_num_bytes.
>          */
>         u64 disk_num_bytes;
>
> +       /*
> +        * Offset inside the decompressed extent.
> +        *
> +        * For regular extents it's btrfs_file_extent_item::offset.
> +        * For holes and inline extents it's 0.
> +        */
> +       u64 offset;
> +
>         /*
>          * The decompressed size of the whole on-disk extent, matching
>          * btrfs_file_extent_item::ram_bytes.
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 2197cfe5443b..47bd4fe0a44b 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1294,12 +1294,17 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
_inode *inode,
>                 em->len =3D btrfs_file_extent_end(path) - extent_start;
>                 em->orig_start =3D extent_start -
>                         btrfs_file_extent_offset(leaf, fi);
> -               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
>                 bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>                 if (bytenr =3D=3D 0) {
>                         em->block_start =3D EXTENT_MAP_HOLE;
> +                       em->disk_bytenr =3D EXTENT_MAP_HOLE;
> +                       em->disk_num_bytes =3D 0;
> +                       em->offset =3D 0;
>                         return;
>                 }
> +               em->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, f=
i);
> +               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
> +               em->offset =3D btrfs_file_extent_offset(leaf, fi);
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                         extent_map_set_compression(em, compress_type);
>                         em->block_start =3D bytenr;
> @@ -1316,8 +1321,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                 ASSERT(extent_start =3D=3D 0);
>
>                 em->block_start =3D EXTENT_MAP_INLINE;
> +               em->disk_bytenr =3D EXTENT_MAP_INLINE;
>                 em->start =3D 0;
>                 em->len =3D fs_info->sectorsize;
> +               em->offset =3D 0;
>                 /*
>                  * Initialize orig_start and block_len with the same valu=
es
>                  * as in inode.c:btrfs_get_extent().
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 63a13a4cace0..8931eeee199d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2337,6 +2337,7 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>                 hole_em->orig_start =3D offset;
>
>                 hole_em->block_start =3D EXTENT_MAP_HOLE;
> +               hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                 hole_em->block_len =3D 0;
>                 hole_em->disk_num_bytes =3D 0;
>                 hole_em->generation =3D trans->transid;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2815b72f2d85..42fea12d509f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -139,8 +139,9 @@ static noinline int run_delalloc_cow(struct btrfs_ino=
de *inode,
>                                      bool pages_dirty);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
>                                        u64 len, u64 orig_start, u64 block=
_start,
> -                                      u64 block_len, u64 orig_block_len,
> +                                      u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
> +                                      struct btrfs_file_extent *file_ext=
ent,
>                                        int type);
>
>  static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_=
bytes,
> @@ -1152,6 +1153,7 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>         struct btrfs_root *root =3D inode->root;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct btrfs_ordered_extent *ordered;
> +       struct btrfs_file_extent file_extent =3D { 0 };
>         struct btrfs_key ins;
>         struct page *locked_page =3D NULL;
>         struct extent_state *cached =3D NULL;
> @@ -1198,6 +1200,13 @@ static void submit_one_async_extent(struct async_c=
hunk *async_chunk,
>         lock_extent(io_tree, start, end, &cached);
>
>         /* Here we're doing allocation and writeback of the compressed pa=
ges */
> +       file_extent.disk_bytenr =3D ins.objectid;
> +       file_extent.disk_num_bytes =3D ins.offset;
> +       file_extent.ram_bytes =3D async_extent->ram_size;
> +       file_extent.num_bytes =3D async_extent->ram_size;
> +       file_extent.offset =3D 0;
> +       file_extent.compression =3D async_extent->compress_type;
> +
>         em =3D create_io_em(inode, start,
>                           async_extent->ram_size,       /* len */
>                           start,                        /* orig_start */
> @@ -1206,6 +1215,7 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>                           ins.offset,                   /* orig_block_len=
 */
>                           async_extent->ram_size,       /* ram_bytes */
>                           async_extent->compress_type,
> +                         &file_extent,
>                           BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
> @@ -1395,6 +1405,7 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>
>         while (num_bytes > 0) {
>                 struct btrfs_ordered_extent *ordered;
> +               struct btrfs_file_extent file_extent =3D { 0 };
>
>                 cur_alloc_size =3D num_bytes;
>                 ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_al=
loc_size,
> @@ -1431,6 +1442,12 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>                 extent_reserved =3D true;
>
>                 ram_size =3D ins.offset;
> +               file_extent.disk_bytenr =3D ins.objectid;
> +               file_extent.disk_num_bytes =3D ins.offset;
> +               file_extent.num_bytes =3D ins.offset;
> +               file_extent.ram_bytes =3D ins.offset;
> +               file_extent.offset =3D 0;
> +               file_extent.compression =3D BTRFS_COMPRESS_NONE;
>
>                 lock_extent(&inode->io_tree, start, start + ram_size - 1,
>                             &cached);
> @@ -1442,6 +1459,7 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                                   ins.offset, /* orig_block_len */
>                                   ram_size, /* ram_bytes */
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
> +                                 &file_extent,
>                                   BTRFS_ORDERED_REGULAR /* type */);
>                 if (IS_ERR(em)) {
>                         unlock_extent(&inode->io_tree, start,
> @@ -1855,6 +1873,7 @@ struct can_nocow_file_extent_args {
>         u64 disk_bytenr;
>         u64 disk_num_bytes;
>         u64 extent_offset;
> +
>         /* Number of bytes that can be written to in NOCOW mode. */
>         u64 num_bytes;
>
> @@ -2182,6 +2201,7 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>                                           nocow_args.num_bytes, /* block_=
len */
>                                           nocow_args.disk_num_bytes, /* o=
rig_block_len */
>                                           ram_bytes, BTRFS_COMPRESS_NONE,
> +                                         &nocow_args.file_extent,
>                                           BTRFS_ORDERED_PREALLOC);
>                         if (IS_ERR(em)) {
>                                 unlock_extent(&inode->io_tree, cur_offset=
,
> @@ -4982,6 +5002,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>                         hole_em->orig_start =3D cur_offset;
>
>                         hole_em->block_start =3D EXTENT_MAP_HOLE;
> +                       hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         hole_em->block_len =3D 0;
>                         hole_em->disk_num_bytes =3D 0;
>                         hole_em->ram_bytes =3D hole_size;
> @@ -6842,6 +6863,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>         }
>         em->start =3D EXTENT_MAP_HOLE;
>         em->orig_start =3D EXTENT_MAP_HOLE;
> +       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>         em->len =3D (u64)-1;
>         em->block_len =3D (u64)-1;
>
> @@ -7007,7 +7029,8 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                                                   const u64 block_len,
>                                                   const u64 orig_block_le=
n,
>                                                   const u64 ram_bytes,
> -                                                 const int type)
> +                                                 const int type,
> +                                                 struct btrfs_file_exten=
t *file_extent)
>  {
>         struct extent_map *em =3D NULL;
>         struct btrfs_ordered_extent *ordered;
> @@ -7016,7 +7039,7 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                 em =3D create_io_em(inode, start, len, orig_start, block_=
start,
>                                   block_len, orig_block_len, ram_bytes,
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
> -                                 type);
> +                                 file_extent, type);
>                 if (IS_ERR(em))
>                         goto out;
>         }
> @@ -7047,6 +7070,7 @@ static struct extent_map *btrfs_new_extent_direct(s=
truct btrfs_inode *inode,
>  {
>         struct btrfs_root *root =3D inode->root;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> +       struct btrfs_file_extent file_extent =3D { 0 };
>         struct extent_map *em;
>         struct btrfs_key ins;
>         u64 alloc_hint;
> @@ -7065,9 +7089,16 @@ static struct extent_map *btrfs_new_extent_direct(=
struct btrfs_inode *inode,
>         if (ret)
>                 return ERR_PTR(ret);
>
> +       file_extent.disk_bytenr =3D ins.objectid;
> +       file_extent.disk_num_bytes =3D ins.offset;
> +       file_extent.num_bytes =3D ins.offset;
> +       file_extent.ram_bytes =3D ins.offset;
> +       file_extent.offset =3D 0;
> +       file_extent.compression =3D BTRFS_COMPRESS_NONE;
>         em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
, start,
>                                      ins.objectid, ins.offset, ins.offset=
,
> -                                    ins.offset, BTRFS_ORDERED_REGULAR);
> +                                    ins.offset, BTRFS_ORDERED_REGULAR,
> +                                    &file_extent);
>         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>         if (IS_ERR(em))
>                 btrfs_free_reserved_extent(fs_info, ins.objectid, ins.off=
set,
> @@ -7310,6 +7341,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>                                        u64 len, u64 orig_start, u64 block=
_start,
>                                        u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
> +                                      struct btrfs_file_extent *file_ext=
ent,
>                                        int type)
>  {
>         struct extent_map *em;
> @@ -7367,9 +7399,11 @@ static struct extent_map *create_io_em(struct btrf=
s_inode *inode, u64 start,
>         em->len =3D len;
>         em->block_len =3D block_len;
>         em->block_start =3D block_start;
> +       em->disk_bytenr =3D file_extent->disk_bytenr;
>         em->disk_num_bytes =3D disk_num_bytes;
>         em->ram_bytes =3D ram_bytes;
>         em->generation =3D -1;
> +       em->offset =3D file_extent->offset;
>         em->flags |=3D EXTENT_FLAG_PINNED;
>         if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>                 extent_map_set_compression(em, compress_type);
> @@ -7393,6 +7427,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>  {
>         const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> +       struct btrfs_file_extent file_extent =3D { 0 };
>         struct extent_map *em =3D *map;
>         int type;
>         u64 block_start, orig_start, orig_block_len, ram_bytes;
> @@ -7423,7 +7458,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 block_start =3D em->block_start + (start - em->start);
>
>                 if (can_nocow_extent(inode, start, &len, &orig_start,
> -                                    &orig_block_len, &ram_bytes, NULL, f=
alse, false) =3D=3D 1) {
> +                                    &orig_block_len, &ram_bytes,
> +                                    &file_extent, false, false) =3D=3D 1=
) {
>                         bg =3D btrfs_inc_nocow_writers(fs_info, block_sta=
rt);
>                         if (bg)
>                                 can_nocow =3D true;
> @@ -7451,7 +7487,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
>                                               orig_start, block_start,
>                                               len, orig_block_len,
> -                                             ram_bytes, type);
> +                                             ram_bytes, type,
> +                                             &file_extent);
>                 btrfs_dec_nocow_writers(bg);
>                 if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
>                         free_extent_map(em);
> @@ -9602,6 +9639,8 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>                 em->orig_start =3D cur_offset;
>                 em->len =3D ins.offset;
>                 em->block_start =3D ins.objectid;
> +               em->disk_bytenr =3D ins.objectid;
> +               em->offset =3D 0;
>                 em->block_len =3D ins.offset;
>                 em->disk_num_bytes =3D ins.offset;
>                 em->ram_bytes =3D ins.offset;
> @@ -10168,6 +10207,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         struct extent_changeset *data_reserved =3D NULL;
>         struct extent_state *cached_state =3D NULL;
>         struct btrfs_ordered_extent *ordered;
> +       struct btrfs_file_extent file_extent =3D { 0 };
>         int compression;
>         size_t orig_count;
>         u64 start, end;
> @@ -10343,10 +10383,16 @@ ssize_t btrfs_do_encoded_write(struct kiocb *io=
cb, struct iov_iter *from,
>                 goto out_delalloc_release;
>         extent_reserved =3D true;
>
> +       file_extent.disk_bytenr =3D ins.objectid;
> +       file_extent.disk_num_bytes =3D ins.offset;
> +       file_extent.num_bytes =3D num_bytes;
> +       file_extent.ram_bytes =3D ram_bytes;
> +       file_extent.offset =3D encoded->unencoded_offset;
> +       file_extent.compression =3D compression;
>         em =3D create_io_em(inode, start, num_bytes,
>                           start - encoded->unencoded_offset, ins.objectid=
,
>                           ins.offset, ins.offset, ram_bytes, compression,
> -                         BTRFS_ORDERED_COMPRESSED);
> +                         &file_extent, BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
>                 goto out_free_reserved;
> --
> 2.45.0
>
>

