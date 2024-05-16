Return-Path: <linux-btrfs+bounces-5054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA78C7B1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 19:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176A51F225A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD915665B;
	Thu, 16 May 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQaEY7ZT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339C53392
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880549; cv=none; b=Ap9e7bW4QkspFddJDn/M2KKXwOfePPtCkXhYG161VSMZXt/mqoVkHXjXn9v8bgJaoHoEqXleX51eQmTd9a4Xb9HlHPkpFotnDtGQi4UwNcoY2KMlvRia4XSqEhXOJfuVrJ3XoE0uOamod62SwhpCJ/XNsB7sZQtsjEAK/WgriXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880549; c=relaxed/simple;
	bh=Rcx6hrZbzeF25gf3CFZ0hpliZorbEBXU2xXgz+JRUYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eji+VzylfdoH5a0V55EbyCjt4fc6gII5rpq0S8PGXMKHE7XTT8T+1KEQNEqBBVI74Wfg1EeTbHVHxhcvX+qxCW6gH94yqNeJR2K3OUDqXxb3qEjHxM1i1Wh5d7eqKCXuyYLhpdQ5d6E+TFJvQdoSVnY/XQYSlkaSRBB+ggX3fP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQaEY7ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496FAC32786
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715880548;
	bh=Rcx6hrZbzeF25gf3CFZ0hpliZorbEBXU2xXgz+JRUYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rQaEY7ZTMJnk55vZI0B8AjdISUoT+M9TpWtxH881hNMnG1ztUaKagvGYrtbvptf0l
	 V5JLy8EJm/jVvkYxlOyek/GGqIokjmp9STRAhulgKV9ouaNrP394x96/cxgspM6kyE
	 pM79rA3etFzmkgeBbcz+Rb5bWNfmu3T7MRWIGth5pteEpd8M/EeYpQD3s0h0L1uLep
	 rpeDU/Az2CNWxQRfTBPFCj4TPG4WQBNL4h3/SkqcPEqJ9l/mjLmWbMH5WF1kBmRkCt
	 VzPMtHap8oc5wUiJrV+W6eFo4tjGiI6TjuczSxSlalNb009UPhE+AqhFprz1x8QoPr
	 oJZ3tD6+C6FcA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so375933966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 10:29:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YzzrGZXfM+48du6lF+CDZTADXMrSE7eqVenMOTAzl1/ErtBSFdw
	GWr6MGocr9tfmepnjMc3ejLNE69kupu0YjEKkoPOFxj7JsrJ17ByWgzYRvlfCdM0ZiP2ZyX2Owu
	xI64wkQcsw+7CfTAu50kTej4nPn0=
X-Google-Smtp-Source: AGHT+IGqaiAab6G9Zw9WQ7/rRgDsVtkxyw2C7HXEPs/MNCdrA0JtimnKMs6GWcotBP/FOO+Z7EhEBImPh9AuvN/y/ck=
X-Received: by 2002:a17:906:2559:b0:a59:70f0:7706 with SMTP id
 a640c23a62f3a-a5a2d67ae96mr1215857566b.74.1715880546219; Thu, 16 May 2024
 10:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <9333b82dcbe22bd78687f702485d308daaedc7a9.1714707707.git.wqu@suse.com>
In-Reply-To: <9333b82dcbe22bd78687f702485d308daaedc7a9.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 May 2024 18:28:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7bT71DicGMZZ7aHu9xcthHG4SiCAn3cC_-5rjrdiodBw@mail.gmail.com>
Message-ID: <CAL3q7H7bT71DicGMZZ7aHu9xcthHG4SiCAn3cC_-5rjrdiodBw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] btrfs: remove extent_map::block_start member
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The member extent_map::block_start can be calculated from
> extent_map::disk_bytenr + extent_map::offset for regular extents.
> And otherwise just extent_map::disk_bytenr.
>
> And this is already validated by the validate_extent_map().
> Now we can remove the member.
>
> However there is a special case in btrfs_alloc_ordered_extent(), where
> we intentionally pass a pseudo ordered extent, exploiting the fact that
> for NOCOW/PREALLOC writes we do not rely on ordered extent members to
> update the file extent items.
>
> And that's the only way to pass btrfs_extract_ordered_extent(), as it
> doesn't accept any ordered extent with an offset.
>
> For now we will keep the old pseudo ordered extent members, and leave
> the cleanup of it for the future.

These last 3 paragraphs, the rant about NOCOW writes and ordered
extents, seem unnecessary to me.

This is just how things work, and for me it makes total sense that an
ordered extent for a NOCOW write does not represent the entirety of an
existing file extent item.
NOCOW writes don't create new file extent items, so they can refer
only to a section of an existing extent (or the whole extent).

I don't see how this rant is relevant to have here, as the patchset is
about extent maps and not ordered extents.
I would leave it out, as it's a separate thing and doesn't affect anything =
here.

More comments inlined below.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/compression.c            |  3 +-
>  fs/btrfs/defrag.c                 |  9 ++-
>  fs/btrfs/extent_io.c              | 10 ++--
>  fs/btrfs/extent_map.c             | 56 +++++------------
>  fs/btrfs/extent_map.h             | 22 ++++---
>  fs/btrfs/file-item.c              |  4 --
>  fs/btrfs/file.c                   | 11 ++--
>  fs/btrfs/inode.c                  | 84 +++++++++++++++-----------
>  fs/btrfs/relocation.c             |  1 -
>  fs/btrfs/tests/extent-map-tests.c | 48 ++++++---------
>  fs/btrfs/tests/inode-tests.c      | 99 ++++++++++++++++---------------
>  fs/btrfs/tree-log.c               | 17 +++---
>  fs/btrfs/zoned.c                  |  4 +-
>  include/trace/events/btrfs.h      | 11 +---
>  14 files changed, 172 insertions(+), 207 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 3af87911c83e..414adbba07b8 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -507,7 +507,8 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>                  */
>                 if (!em || cur < em->start ||
>                     (cur + fs_info->sectorsize > extent_map_end(em)) ||
> -                   (em->block_start >> SECTOR_SHIFT) !=3D orig_bio->bi_i=
ter.bi_sector) {
> +                   (extent_map_block_start(em) >> SECTOR_SHIFT) !=3D
> +                   orig_bio->bi_iter.bi_sector) {
>                         free_extent_map(em);
>                         unlock_extent(tree, cur, page_end, NULL);
>                         unlock_page(page);
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 025e7f853a68..6fb94e897fc5 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -707,7 +707,6 @@ static struct extent_map *defrag_get_extent(struct bt=
rfs_inode *inode,
>                  */
>                 if (key.offset > start) {
>                         em->start =3D start;
> -                       em->block_start =3D EXTENT_MAP_HOLE;
>                         em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         em->disk_num_bytes =3D 0;
>                         em->ram_bytes =3D 0;
> @@ -828,7 +827,7 @@ static bool defrag_check_next_extent(struct inode *in=
ode, struct extent_map *em,
>          */
>         next =3D defrag_lookup_extent(inode, em->start + em->len, newer_t=
han, locked);
>         /* No more em or hole */
> -       if (!next || next->block_start >=3D EXTENT_MAP_LAST_BYTE)
> +       if (!next || next->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE)
>                 goto out;
>         if (next->flags & EXTENT_FLAG_PREALLOC)
>                 goto out;
> @@ -995,12 +994,12 @@ static int defrag_collect_targets(struct btrfs_inod=
e *inode,
>                  * This is for users who want to convert inline extents t=
o
>                  * regular ones through max_inline=3D mount option.
>                  */
> -               if (em->block_start =3D=3D EXTENT_MAP_INLINE &&
> +               if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE &&
>                     em->len <=3D inode->root->fs_info->max_inline)
>                         goto next;
>
>                 /* Skip holes and preallocated extents. */
> -               if (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> +               if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE ||
>                     (em->flags & EXTENT_FLAG_PREALLOC))
>                         goto next;
>
> @@ -1065,7 +1064,7 @@ static int defrag_collect_targets(struct btrfs_inod=
e *inode,
>                  * So if an inline extent passed all above checks, just a=
dd it
>                  * for defrag, and be converted to regular extents.
>                  */
> -               if (em->block_start =3D=3D EXTENT_MAP_INLINE)
> +               if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE)
>                         goto add;
>
>                 next_mergeable =3D defrag_check_next_extent(&inode->vfs_i=
node, em,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 597387e9f040..ef9928cc6467 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1083,10 +1083,10 @@ static int btrfs_do_readpage(struct page *page, s=
truct extent_map **em_cached,
>                 iosize =3D min(extent_map_end(em) - cur, end - cur + 1);
>                 iosize =3D ALIGN(iosize, blocksize);
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE)
> -                       disk_bytenr =3D em->block_start;
> +                       disk_bytenr =3D em->disk_bytenr;
>                 else
> -                       disk_bytenr =3D em->block_start + extent_offset;
> -               block_start =3D em->block_start;
> +                       disk_bytenr =3D extent_map_block_start(em) + exte=
nt_offset;
> +               block_start =3D extent_map_block_start(em);
>                 if (em->flags & EXTENT_FLAG_PREALLOC)
>                         block_start =3D EXTENT_MAP_HOLE;
>
> @@ -1405,8 +1405,8 @@ static noinline_for_stack int __extent_writepage_io=
(struct btrfs_inode *inode,
>                 ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
>                 ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
>
> -               block_start =3D em->block_start;
> -               disk_bytenr =3D em->block_start + extent_offset;
> +               block_start =3D extent_map_block_start(em);
> +               disk_bytenr =3D extent_map_block_start(em) + extent_offse=
t;
>
>                 ASSERT(!extent_map_is_compressed(em));
>                 ASSERT(block_start !=3D EXTENT_MAP_HOLE);
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index dcd191c2c4b3..9ae86125599a 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -195,9 +195,10 @@ static inline u64 extent_map_block_len(const struct =
extent_map *em)
>
>  static inline u64 extent_map_block_end(const struct extent_map *em)
>  {
> -       if (em->block_start + extent_map_block_len(em) < em->block_start)
> +       if (extent_map_block_start(em) + extent_map_block_len(em) <
> +           extent_map_block_start(em))
>                 return (u64)-1;
> -       return em->block_start + extent_map_block_len(em);
> +       return extent_map_block_start(em) + extent_map_block_len(em);
>  }
>
>  static bool can_merge_extent_map(const struct extent_map *em)
> @@ -232,11 +233,11 @@ static bool mergeable_maps(const struct extent_map =
*prev, const struct extent_ma
>         if (prev->flags !=3D next->flags)
>                 return false;
>
> -       if (next->block_start < EXTENT_MAP_LAST_BYTE - 1)
> -               return next->block_start =3D=3D extent_map_block_end(prev=
);
> +       if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)
> +               return extent_map_block_start(next) =3D=3D extent_map_blo=
ck_end(prev);
>
>         /* HOLES and INLINE extents. */
> -       return next->block_start =3D=3D prev->block_start;
> +       return next->disk_bytenr =3D=3D prev->disk_bytenr;
>  }
>
>  /*
> @@ -295,10 +296,9 @@ static void dump_extent_map(const char *prefix, stru=
ct extent_map *em)
>  {
>         if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
>                 return;
> -       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu block_start=3D%llu flags=3D0x%x=
\n",
> +       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu flags=3D0x%x\n",
>                 prefix, em->start, em->len, em->disk_bytenr, em->disk_num=
_bytes,
> -               em->ram_bytes, em->offset, em->block_start,
> -               em->flags);
> +               em->ram_bytes, em->offset, em->flags);
>         ASSERT(0);
>  }
>
> @@ -315,16 +315,6 @@ static void validate_extent_map(struct extent_map *e=
m)
>                 if (em->offset + em->len > em->disk_num_bytes &&
>                     !extent_map_is_compressed(em))
>                         dump_extent_map("disk_num_bytes too small", em);
> -
> -               if (extent_map_is_compressed(em)) {
> -                       if (em->block_start !=3D em->disk_bytenr)
> -                               dump_extent_map(
> -                               "mismatch block_start/disk_bytenr/offset"=
, em);
> -               } else {
> -                       if (em->block_start !=3D em->disk_bytenr + em->of=
fset)
> -                               dump_extent_map(
> -                               "mismatch block_start/disk_bytenr/offset"=
, em);
> -               }
>         } else {
>                 if (em->offset)
>                         dump_extent_map("non-zero offset for hole/inline"=
, em);
> @@ -358,7 +348,6 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                 if (rb && can_merge_extent_map(merge) && mergeable_maps(m=
erge, em)) {
>                         em->start =3D merge->start;
>                         em->len +=3D merge->len;
> -                       em->block_start =3D merge->block_start;
>                         em->generation =3D max(em->generation, merge->gen=
eration);
>
>                         if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> @@ -668,11 +657,9 @@ static noinline int merge_extent_mapping(struct btrf=
s_inode *inode,
>         start_diff =3D start - em->start;
>         em->start =3D start;
>         em->len =3D end - start;
> -       if (em->block_start < EXTENT_MAP_LAST_BYTE &&
> -           !extent_map_is_compressed(em)) {
> -               em->block_start +=3D start_diff;
> +       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE &&
> +           !extent_map_is_compressed(em))
>                 em->offset +=3D start_diff;
> -       }
>         return add_extent_mapping(inode, em, 0);
>  }
>
> @@ -707,7 +694,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inod=
e,
>          * Tree-checker should have rejected any inline extent with non-z=
ero
>          * file offset. Here just do a sanity check.
>          */
> -       if (em->block_start =3D=3D EXTENT_MAP_INLINE)
> +       if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE)
>                 ASSERT(em->start =3D=3D 0);
>
>         ret =3D add_extent_mapping(inode, em, 0);
> @@ -836,7 +823,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                 u64 gen;
>                 unsigned long flags;
>                 bool modified;
> -               bool compressed;
>
>                 if (em_end < end) {
>                         next_em =3D next_extent_map(em);
> @@ -870,7 +856,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                         goto remove_em;
>
>                 gen =3D em->generation;
> -               compressed =3D extent_map_is_compressed(em);
>
>                 if (em->start < start) {
>                         if (!split) {
> @@ -882,15 +867,12 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                         split->start =3D em->start;
>                         split->len =3D start - em->start;
>
> -                       if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> -                               split->block_start =3D em->block_start;
> -
> +                       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
>                                 split->disk_bytenr =3D em->disk_bytenr;
>                                 split->disk_num_bytes =3D em->disk_num_by=
tes;
>                                 split->offset =3D em->offset;
>                                 split->ram_bytes =3D em->ram_bytes;
>                         } else {
> -                               split->block_start =3D em->block_start;
>                                 split->disk_bytenr =3D em->disk_bytenr;
>                                 split->disk_num_bytes =3D 0;
>                                 split->offset =3D 0;
> @@ -913,20 +895,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                         }
>                         split->start =3D end;
>                         split->len =3D em_end - end;
> -                       split->block_start =3D em->block_start;
>                         split->disk_bytenr =3D em->disk_bytenr;
>                         split->flags =3D flags;
>                         split->generation =3D gen;
>
> -                       if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> +                       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
>                                 split->disk_num_bytes =3D em->disk_num_by=
tes;
>                                 split->offset =3D em->offset + end - em->=
start;
>                                 split->ram_bytes =3D em->ram_bytes;
> -                               if (!compressed) {
> -                                       const u64 diff =3D end - em->star=
t;
> -
> -                                       split->block_start +=3D diff;
> -                               }
>                         } else {
>                                 split->disk_num_bytes =3D 0;
>                                 split->offset =3D 0;
> @@ -1073,7 +1049,7 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>
>         ASSERT(em->len =3D=3D len);
>         ASSERT(!extent_map_is_compressed(em));
> -       ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
> +       ASSERT(em->disk_bytenr < EXTENT_MAP_LAST_BYTE);
>         ASSERT(em->flags & EXTENT_FLAG_PINNED);
>         ASSERT(!(em->flags & EXTENT_FLAG_LOGGING));
>         ASSERT(!list_empty(&em->list));
> @@ -1087,7 +1063,6 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>         split_pre->disk_bytenr =3D new_logical;
>         split_pre->disk_num_bytes =3D split_pre->len;
>         split_pre->offset =3D 0;
> -       split_pre->block_start =3D new_logical;
>         split_pre->ram_bytes =3D split_pre->len;
>         split_pre->flags =3D flags;
>         split_pre->generation =3D em->generation;
> @@ -1102,10 +1077,9 @@ int split_extent_map(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 pre,
>         /* Insert the middle extent_map. */
>         split_mid->start =3D em->start + pre;
>         split_mid->len =3D em->len - pre;
> -       split_mid->disk_bytenr =3D em->block_start + pre;
> +       split_mid->disk_bytenr =3D extent_map_block_start(em) + pre;
>         split_mid->disk_num_bytes =3D split_mid->len;
>         split_mid->offset =3D 0;
> -       split_mid->block_start =3D em->block_start + pre;
>         split_mid->ram_bytes =3D split_mid->len;
>         split_mid->flags =3D flags;
>         split_mid->generation =3D em->generation;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index aee721eaa7f3..a0e7f49ec88f 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -90,18 +90,6 @@ struct extent_map {
>          */
>         u64 ram_bytes;
>
> -       /*
> -        * The on-disk logical bytenr for the file extent.
> -        *
> -        * For compressed extents it matches btrfs_file_extent_item::disk=
_bytenr.
> -        * For uncompressed extents it matches
> -        * btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::=
offset
> -        *
> -        * For holes it is EXTENT_MAP_HOLE and for inline extents it is
> -        * EXTENT_MAP_INLINE.
> -        */
> -       u64 block_start;
> -
>         /*
>          * Generation of the extent map, for merged em it's the highest
>          * generation of all merged ems.
> @@ -162,6 +150,16 @@ static inline int extent_map_in_tree(const struct ex=
tent_map *em)
>         return !RB_EMPTY_NODE(&em->rb_node);
>  }
>
> +static inline u64 extent_map_block_start(const struct extent_map *em)
> +{
> +       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
> +               if (extent_map_is_compressed(em))
> +                       return em->disk_bytenr;
> +               return em->disk_bytenr + em->offset;
> +       }
> +       return em->disk_bytenr;
> +}
> +
>  static inline u64 extent_map_end(const struct extent_map *em)
>  {
>         if (em->start + em->len < em->start)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 95fb7c059a1a..b8e213a1a8ee 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1294,7 +1294,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_i=
node *inode,
>                 em->len =3D btrfs_file_extent_end(path) - extent_start;
>                 bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>                 if (bytenr =3D=3D 0) {
> -                       em->block_start =3D EXTENT_MAP_HOLE;
>                         em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         em->disk_num_bytes =3D 0;
>                         em->offset =3D 0;
> @@ -1305,10 +1304,8 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                 em->offset =3D btrfs_file_extent_offset(leaf, fi);
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                         extent_map_set_compression(em, compress_type);
> -                       em->block_start =3D bytenr;
>                 } else {
>                         bytenr +=3D btrfs_file_extent_offset(leaf, fi);
> -                       em->block_start =3D bytenr;
>                         if (type =3D=3D BTRFS_FILE_EXTENT_PREALLOC)
>                                 em->flags |=3D EXTENT_FLAG_PREALLOC;
>                 }
> @@ -1316,7 +1313,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_i=
node *inode,
>                 /* Tree-checker has ensured this. */
>                 ASSERT(extent_start =3D=3D 0);
>
> -               em->block_start =3D EXTENT_MAP_INLINE;
>                 em->disk_bytenr =3D EXTENT_MAP_INLINE;
>                 em->start =3D 0;
>                 em->len =3D fs_info->sectorsize;
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 05c7b5429b85..102b5c17ece1 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2335,7 +2335,6 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>                 hole_em->len =3D end - offset;
>                 hole_em->ram_bytes =3D hole_em->len;
>
> -               hole_em->block_start =3D EXTENT_MAP_HOLE;
>                 hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                 hole_em->disk_num_bytes =3D 0;
>                 hole_em->generation =3D trans->transid;
> @@ -2368,7 +2367,7 @@ static int find_first_non_hole(struct btrfs_inode *=
inode, u64 *start, u64 *len)
>                 return PTR_ERR(em);
>
>         /* Hole or vacuum extent(only exists in no-hole mode) */
> -       if (em->block_start =3D=3D EXTENT_MAP_HOLE) {
> +       if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) {
>                 ret =3D 1;
>                 *len =3D em->start + em->len > *start + *len ?
>                        0 : *start + *len - em->start - em->len;
> @@ -3025,7 +3024,7 @@ static int btrfs_zero_range_check_range_boundary(st=
ruct btrfs_inode *inode,
>         if (IS_ERR(em))
>                 return PTR_ERR(em);
>
> -       if (em->block_start =3D=3D EXTENT_MAP_HOLE)
> +       if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE)
>                 ret =3D RANGE_BOUNDARY_HOLE;
>         else if (em->flags & EXTENT_FLAG_PREALLOC)
>                 ret =3D RANGE_BOUNDARY_PREALLOC_EXTENT;
> @@ -3089,7 +3088,7 @@ static int btrfs_zero_range(struct inode *inode,
>                 ASSERT(IS_ALIGNED(alloc_start, sectorsize));
>                 len =3D offset + len - alloc_start;
>                 offset =3D alloc_start;
> -               alloc_hint =3D em->block_start + em->len;
> +               alloc_hint =3D extent_map_block_start(em) + em->len;
>         }
>         free_extent_map(em);
>
> @@ -3107,7 +3106,7 @@ static int btrfs_zero_range(struct inode *inode,
>                                                            mode);
>                         goto out;
>                 }
> -               if (len < sectorsize && em->block_start !=3D EXTENT_MAP_H=
OLE) {
> +               if (len < sectorsize && em->disk_bytenr !=3D EXTENT_MAP_H=
OLE) {
>                         free_extent_map(em);
>                         ret =3D btrfs_truncate_block(BTRFS_I(inode), offs=
et, len,
>                                                    0);
> @@ -3320,7 +3319,7 @@ static long btrfs_fallocate(struct file *file, int =
mode,
>                 last_byte =3D min(extent_map_end(em), alloc_end);
>                 actual_end =3D min_t(u64, extent_map_end(em), offset + le=
n);
>                 last_byte =3D ALIGN(last_byte, blocksize);
> -               if (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> +               if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE ||
>                     (cur_offset >=3D inode->i_size &&
>                      !(em->flags & EXTENT_FLAG_PREALLOC))) {
>                         const u64 range_len =3D last_byte - cur_offset;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7df295e0046d..8bc1f165193a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -138,7 +138,7 @@ static noinline int run_delalloc_cow(struct btrfs_ino=
de *inode,
>                                      u64 end, struct writeback_control *w=
bc,
>                                      bool pages_dirty);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
> -                                      u64 len, u64 block_start,
> +                                      u64 len,
>                                        u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
> @@ -1209,7 +1209,6 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>
>         em =3D create_io_em(inode, start,
>                           async_extent->ram_size,       /* len */
> -                         ins.objectid,                 /* block_start */
>                           ins.offset,                   /* orig_block_len=
 */
>                           async_extent->ram_size,       /* ram_bytes */
>                           async_extent->compress_type,
> @@ -1287,15 +1286,15 @@ static u64 get_extent_allocation_hint(struct btrf=
s_inode *inode, u64 start,
>                  * first block in this inode and use that as a hint.  If =
that
>                  * block is also bogus then just don't worry about it.
>                  */
> -               if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> +               if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
>                         free_extent_map(em);
>                         em =3D search_extent_mapping(em_tree, 0, 0);
> -                       if (em && em->block_start < EXTENT_MAP_LAST_BYTE)
> -                               alloc_hint =3D em->block_start;
> +                       if (em && em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> +                               alloc_hint =3D extent_map_block_start(em)=
;
>                         if (em)
>                                 free_extent_map(em);
>                 } else {
> -                       alloc_hint =3D em->block_start;
> +                       alloc_hint =3D extent_map_block_start(em);
>                         free_extent_map(em);
>                 }
>         }
> @@ -1451,7 +1450,6 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                             &cached);
>
>                 em =3D create_io_em(inode, start, ins.offset, /* len */
> -                                 ins.objectid, /* block_start */
>                                   ins.offset, /* orig_block_len */
>                                   ram_size, /* ram_bytes */
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
> @@ -2191,7 +2189,6 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>                         struct extent_map *em;
>
>                         em =3D create_io_em(inode, cur_offset, nocow_args=
.num_bytes,
> -                                         nocow_args.disk_bytenr, /* bloc=
k_start */
>                                           nocow_args.disk_num_bytes, /* o=
rig_block_len */
>                                           ram_bytes, BTRFS_COMPRESS_NONE,
>                                           &nocow_args.file_extent,
> @@ -2706,7 +2703,7 @@ static int btrfs_find_new_delalloc_bytes(struct btr=
fs_inode *inode,
>                 if (IS_ERR(em))
>                         return PTR_ERR(em);
>
> -               if (em->block_start !=3D EXTENT_MAP_HOLE)
> +               if (extent_map_block_start(em) !=3D EXTENT_MAP_HOLE)
>                         goto next;
>
>                 em_len =3D em->len;
> @@ -4993,7 +4990,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>                         hole_em->start =3D cur_offset;
>                         hole_em->len =3D hole_size;
>
> -                       hole_em->block_start =3D EXTENT_MAP_HOLE;
>                         hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         hole_em->disk_num_bytes =3D 0;
>                         hole_em->ram_bytes =3D hole_size;
> @@ -6842,7 +6838,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>         if (em) {
>                 if (em->start > start || em->start + em->len <=3D start)
>                         free_extent_map(em);
> -               else if (em->block_start =3D=3D EXTENT_MAP_INLINE && page=
)
> +               else if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE && page=
)
>                         free_extent_map(em);
>                 else
>                         goto out;
> @@ -6945,7 +6941,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>                 /* New extent overlaps with existing one */
>                 em->start =3D start;
>                 em->len =3D found_key.offset - start;
> -               em->block_start =3D EXTENT_MAP_HOLE;
> +               em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                 goto insert;
>         }
>
> @@ -6969,7 +6965,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>                  *
>                  * Other members are not utilized for inline extents.
>                  */
> -               ASSERT(em->block_start =3D=3D EXTENT_MAP_INLINE);
> +               ASSERT(em->disk_bytenr =3D=3D EXTENT_MAP_INLINE);
>                 ASSERT(em->len =3D=3D fs_info->sectorsize);
>
>                 ret =3D read_inline_extent(inode, path, page);
> @@ -6980,7 +6976,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>  not_found:
>         em->start =3D start;
>         em->len =3D len;
> -       em->block_start =3D EXTENT_MAP_HOLE;
> +       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>  insert:
>         ret =3D 0;
>         btrfs_release_path(path);
> @@ -7011,7 +7007,6 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                                                   struct btrfs_dio_data *=
dio_data,
>                                                   const u64 start,
>                                                   const u64 len,
> -                                                 const u64 block_start,
>                                                   const u64 orig_block_le=
n,
>                                                   const u64 ram_bytes,
>                                                   const int type,
> @@ -7021,15 +7016,38 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
>         struct btrfs_ordered_extent *ordered;
>
>         if (type !=3D BTRFS_ORDERED_NOCOW) {
> -               em =3D create_io_em(inode, start, len, block_start,
> +               em =3D create_io_em(inode, start, len,
>                                   orig_block_len, ram_bytes,
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
>                                   file_extent, type);
>                 if (IS_ERR(em))
>                         goto out;
>         }
> +
> +       /*
> +        * NOTE: I know the numbers are totally wrong for NOCOW/PREALLOC,
> +        * but it doesn't cause problem at least for now.

They are not wrong, they are what they must be.

This is all about passing the right values to
btrfs_alloc_ordered_extent(), which has nothing to do with extent
maps.

> +        *
> +        * For regular writes, we would have file_extent->offset as 0,
> +        * thus we really only need disk_bytenr, every other length
> +        * (disk_num_bytes/ram_bytes) would match @len and fe->num_bytes.
> +        * The current numbers are totally fine.
> +        *
> +        * For NOCOW, we don't really care about the numbers except @file=
_pos

I don't see any variable named @file_pos anywhere in this function.

> +        * and @num_bytes, as we won't insert a file extent item at all.

There's no @num_bytes either, there's a @len however.

> +        *
> +        * For PREALLOC, we do not use ordered extent's member, but

ordered extent's member -> ordered extent members

> +        * btrfs_mark_extent_written() would handle everything.

would handle -> handles

> +        *
> +        * So here we intentionally go with pseudo numbers for the NOCOW/=
PREALLOC
> +        * OEs, or btrfs_extract_ordered_extent() would need a completely=
 new
> +        * routine to handle NOCOW/PREALLOC splits, meanwhile result noth=
ing
> +        * different.
> +        */

I would just leave the entire comment out.

>         ordered =3D btrfs_alloc_ordered_extent(inode, start, len, len,
> -                                            block_start, len, 0,
> +                                            file_extent->disk_bytenr +
> +                                            file_extent->offset,
> +                                            len, 0,
>                                              (1 << type) |
>                                              (1 << BTRFS_ORDERED_DIRECT),
>                                              BTRFS_COMPRESS_NONE);
> @@ -7081,7 +7099,7 @@ static struct extent_map *btrfs_new_extent_direct(s=
truct btrfs_inode *inode,
>         file_extent.offset =3D 0;
>         file_extent.compression =3D BTRFS_COMPRESS_NONE;
>         em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
,
> -                                    ins.objectid, ins.offset,
> +                                    ins.offset,
>                                      ins.offset, BTRFS_ORDERED_REGULAR,
>                                      &file_extent);
>         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> @@ -7321,7 +7339,7 @@ static int lock_extent_direct(struct inode *inode, =
u64 lockstart, u64 lockend,
>
>  /* The callers of this must take lock_extent() */
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
> -                                      u64 len, u64 block_start,
> +                                      u64 len,
>                                        u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
> @@ -7373,7 +7391,6 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>
>         em->start =3D start;
>         em->len =3D len;
> -       em->block_start =3D block_start;
>         em->disk_bytenr =3D file_extent->disk_bytenr;
>         em->disk_num_bytes =3D disk_num_bytes;
>         em->ram_bytes =3D ram_bytes;
> @@ -7424,13 +7441,13 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>          */
>         if ((em->flags & EXTENT_FLAG_PREALLOC) ||
>             ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
> -            em->block_start !=3D EXTENT_MAP_HOLE)) {
> +            em->disk_bytenr !=3D EXTENT_MAP_HOLE)) {
>                 if (em->flags & EXTENT_FLAG_PREALLOC)
>                         type =3D BTRFS_ORDERED_PREALLOC;
>                 else
>                         type =3D BTRFS_ORDERED_NOCOW;
>                 len =3D min(len, em->len - (start - em->start));
> -               block_start =3D em->block_start + (start - em->start);
> +               block_start =3D extent_map_block_start(em) + (start - em-=
>start);
>
>                 if (can_nocow_extent(inode, start, &len,
>                                      &orig_block_len, &ram_bytes,
> @@ -7460,7 +7477,6 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 space_reserved =3D true;
>
>                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
> -                                             block_start,
>                                               orig_block_len,
>                                               ram_bytes, type,
>                                               &file_extent);
> @@ -7663,7 +7679,7 @@ static int btrfs_dio_iomap_begin(struct inode *inod=
e, loff_t start,
>          * the generic code.
>          */
>         if (extent_map_is_compressed(em) ||
> -           em->block_start =3D=3D EXTENT_MAP_INLINE) {
> +           em->disk_bytenr =3D=3D EXTENT_MAP_INLINE) {
>                 free_extent_map(em);
>                 /*
>                  * If we are in a NOWAIT context, return -EAGAIN in order=
 to
> @@ -7757,12 +7773,12 @@ static int btrfs_dio_iomap_begin(struct inode *in=
ode, loff_t start,
>          * We trim the extents (and move the addr) even though iomap code=
 does
>          * that, since we have locked only the parts we are performing I/=
O in.
>          */
> -       if ((em->block_start =3D=3D EXTENT_MAP_HOLE) ||
> +       if ((em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) ||
>             ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
>                 iomap->addr =3D IOMAP_NULL_ADDR;
>                 iomap->type =3D IOMAP_HOLE;
>         } else {
> -               iomap->addr =3D em->block_start + (start - em->start);
> +               iomap->addr =3D extent_map_block_start(em) + (start - em-=
>start);
>                 iomap->type =3D IOMAP_MAPPED;
>         }
>         iomap->offset =3D start;
> @@ -9612,7 +9628,6 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>
>                 em->start =3D cur_offset;
>                 em->len =3D ins.offset;
> -               em->block_start =3D ins.objectid;
>                 em->disk_bytenr =3D ins.objectid;
>                 em->offset =3D 0;
>                 em->disk_num_bytes =3D ins.offset;
> @@ -10078,7 +10093,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, st=
ruct iov_iter *iter,
>                 goto out_unlock_extent;
>         }
>
> -       if (em->block_start =3D=3D EXTENT_MAP_INLINE) {
> +       if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE) {
>                 u64 extent_start =3D em->start;
>
>                 /*
> @@ -10099,14 +10114,14 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, =
struct iov_iter *iter,
>          */
>         encoded->len =3D min_t(u64, extent_map_end(em),
>                              inode->vfs_inode.i_size) - iocb->ki_pos;
> -       if (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> +       if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE ||
>             (em->flags & EXTENT_FLAG_PREALLOC)) {
>                 disk_bytenr =3D EXTENT_MAP_HOLE;
>                 count =3D min_t(u64, count, encoded->len);
>                 encoded->len =3D count;
>                 encoded->unencoded_len =3D count;
>         } else if (extent_map_is_compressed(em)) {
> -               disk_bytenr =3D em->block_start;
> +               disk_bytenr =3D em->disk_bytenr;
>                 /*
>                  * Bail if the buffer isn't large enough to return the wh=
ole
>                  * compressed extent.
> @@ -10125,7 +10140,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, st=
ruct iov_iter *iter,
>                         goto out_em;
>                 encoded->compression =3D ret;
>         } else {
> -               disk_bytenr =3D em->block_start + (start - em->start);
> +               disk_bytenr =3D extent_map_block_start(em) + (start - em-=
>start);
>                 if (encoded->len > count)
>                         encoded->len =3D count;
>                 /*
> @@ -10363,7 +10378,6 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         file_extent.offset =3D encoded->unencoded_offset;
>         file_extent.compression =3D compression;
>         em =3D create_io_em(inode, start, num_bytes,
> -                         ins.objectid,
>                           ins.offset, ram_bytes, compression,
>                           &file_extent, BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(em)) {
> @@ -10667,12 +10681,12 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
>                         goto out;
>                 }
>
> -               if (em->block_start =3D=3D EXTENT_MAP_HOLE) {
> +               if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) {
>                         btrfs_warn(fs_info, "swapfile must not have holes=
");
>                         ret =3D -EINVAL;
>                         goto out;
>                 }
> -               if (em->block_start =3D=3D EXTENT_MAP_INLINE) {
> +               if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE) {
>                         /*
>                          * It's unlikely we'll ever actually find ourselv=
es
>                          * here, as a file small enough to fit inline won=
't be
> @@ -10690,7 +10704,7 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>                         goto out;
>                 }
>
> -               logical_block_start =3D em->block_start + (start - em->st=
art);
> +               logical_block_start =3D extent_map_block_start(em) + (sta=
rt - em->start);
>                 len =3D min(len, em->len - (start - em->start));
>                 free_extent_map(em);
>                 em =3D NULL;
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index a66d9b921f84..0d462c2a9c89 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2912,7 +2912,6 @@ static noinline_for_stack int setup_relocation_exte=
nt_mapping(struct inode *inod
>
>         em->start =3D start;
>         em->len =3D end + 1 - start;
> -       em->block_start =3D block_start;
>         em->disk_bytenr =3D block_start;
>         em->disk_num_bytes =3D em->len;
>         em->ram_bytes =3D em->len;
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index ffdaa6a682af..a145214be14b 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -28,8 +28,8 @@ static int free_extent_map_tree(struct btrfs_inode *ino=
de)
>                 if (refcount_read(&em->refs) !=3D 1) {
>                         ret =3D -EINVAL;
>                         test_err(
> -"em leak: em (start %llu len %llu block_start %llu disk_num_bytes %llu o=
ffset %llu) refs %d",
> -                                em->start, em->len, em->block_start,
> +"em leak: em (start %llu len %llu disk_bytenr %llu disk_num_bytes %llu o=
ffset %llu) refs %d",
> +                                em->start, em->len, em->disk_bytenr,
>                                  em->disk_num_bytes, em->offset,
>                                  refcount_read(&em->refs));
>
> @@ -77,7 +77,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, s=
truct btrfs_inode *inode)
>         /* Add [0, 16K) */
>         em->start =3D 0;
>         em->len =3D SZ_16K;
> -       em->block_start =3D 0;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -100,7 +99,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, =
struct btrfs_inode *inode)
>
>         em->start =3D SZ_16K;
>         em->len =3D SZ_4K;
> -       em->block_start =3D SZ_32K; /* avoid merging */
>         em->disk_bytenr =3D SZ_32K; /* avoid merging */
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_4K;
> @@ -123,7 +121,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         /* Add [0, 8K), should return [0, 16K) instead. */
>         em->start =3D start;
>         em->len =3D len;
> -       em->block_start =3D start;
>         em->disk_bytenr =3D start;
>         em->disk_num_bytes =3D len;
>         em->ram_bytes =3D len;
> @@ -141,11 +138,11 @@ static int test_case_1(struct btrfs_fs_info *fs_inf=
o, struct btrfs_inode *inode)
>                 goto out;
>         }
>         if (em->start !=3D 0 || extent_map_end(em) !=3D SZ_16K ||
> -           em->block_start !=3D 0 || em->disk_num_bytes !=3D SZ_16K) {
> +           em->disk_bytenr !=3D 0 || em->disk_num_bytes !=3D SZ_16K) {
>                 test_err(
> -"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_=
start %llu disk_num_bytes %llu",
> +"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu disk_b=
ytenr %llu disk_num_bytes %llu",
>                          start, start + len, ret, em->start, em->len,
> -                        em->block_start, em->disk_num_bytes);
> +                        em->disk_bytenr, em->disk_num_bytes);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -179,7 +176,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         /* Add [0, 1K) */
>         em->start =3D 0;
>         em->len =3D SZ_1K;
> -       em->block_start =3D EXTENT_MAP_INLINE;
>         em->disk_bytenr =3D EXTENT_MAP_INLINE;
>         em->disk_num_bytes =3D 0;
>         em->ram_bytes =3D SZ_1K;
> @@ -202,7 +198,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>
>         em->start =3D SZ_4K;
>         em->len =3D SZ_4K;
> -       em->block_start =3D SZ_4K;
>         em->disk_bytenr =3D SZ_4K;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_4K;
> @@ -225,7 +220,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         /* Add [0, 1K) */
>         em->start =3D 0;
>         em->len =3D SZ_1K;
> -       em->block_start =3D EXTENT_MAP_INLINE;
>         em->disk_bytenr =3D EXTENT_MAP_INLINE;
>         em->disk_num_bytes =3D 0;
>         em->ram_bytes =3D SZ_1K;
> @@ -242,10 +236,10 @@ static int test_case_2(struct btrfs_fs_info *fs_inf=
o, struct btrfs_inode *inode)
>                 goto out;
>         }
>         if (em->start !=3D 0 || extent_map_end(em) !=3D SZ_1K ||
> -           em->block_start !=3D EXTENT_MAP_INLINE) {
> +           em->disk_bytenr !=3D EXTENT_MAP_INLINE) {
>                 test_err(
> -"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start=
 %llu",
> -                        ret, em->start, em->len, em->block_start);
> +"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu disk_bytenr=
 %llu",
> +                        ret, em->start, em->len, em->disk_bytenr);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -275,7 +269,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_inf=
o,
>         /* Add [4K, 8K) */
>         em->start =3D SZ_4K;
>         em->len =3D SZ_4K;
> -       em->block_start =3D SZ_4K;
>         em->disk_bytenr =3D SZ_4K;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_4K;
> @@ -298,7 +291,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_inf=
o,
>         /* Add [0, 16K) */
>         em->start =3D 0;
>         em->len =3D SZ_16K;
> -       em->block_start =3D 0;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -321,11 +313,11 @@ static int __test_case_3(struct btrfs_fs_info *fs_i=
nfo,
>          * em->start.
>          */
>         if (start < em->start || start + len > extent_map_end(em) ||
> -           em->start !=3D em->block_start) {
> +           em->start !=3D extent_map_block_start(em)) {
>                 test_err(
> -"case3 [%llu %llu): ret %d em (start %llu len %llu block_start %llu bloc=
k_len %llu)",
> +"case3 [%llu %llu): ret %d em (start %llu len %llu disk_bytenr %llu bloc=
k_len %llu)",
>                          start, start + len, ret, em->start, em->len,
> -                        em->block_start, em->disk_num_bytes);
> +                        em->disk_bytenr, em->disk_num_bytes);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -386,7 +378,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         /* Add [0K, 8K) */
>         em->start =3D 0;
>         em->len =3D SZ_8K;
> -       em->block_start =3D 0;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_8K;
>         em->ram_bytes =3D SZ_8K;
> @@ -409,7 +400,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         /* Add [8K, 32K) */
>         em->start =3D SZ_8K;
>         em->len =3D 24 * SZ_1K;
> -       em->block_start =3D SZ_16K; /* avoid merging */
>         em->disk_bytenr =3D SZ_16K; /* avoid merging */
>         em->disk_num_bytes =3D 24 * SZ_1K;
>         em->ram_bytes =3D 24 * SZ_1K;
> @@ -431,7 +421,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         /* Add [0K, 32K) */
>         em->start =3D 0;
>         em->len =3D SZ_32K;
> -       em->block_start =3D 0;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_32K;
>         em->ram_bytes =3D SZ_32K;
> @@ -451,9 +440,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         }
>         if (start < em->start || start + len > extent_map_end(em)) {
>                 test_err(
> -"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_st=
art %llu disk_num_bytes %llu)",
> -                        start, start + len, ret, em->start, em->len, em-=
>block_start,
> -                        em->disk_num_bytes);
> +"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu disk_byt=
enr %llu disk_num_bytes %llu)",
> +                        start, start + len, ret, em->start, em->len,
> +                        em->disk_bytenr, em->disk_num_bytes);
>                 ret =3D -EINVAL;
>         }
>         free_extent_map(em);
> @@ -517,7 +506,6 @@ static int add_compressed_extent(struct btrfs_inode *=
inode,
>
>         em->start =3D start;
>         em->len =3D len;
> -       em->block_start =3D block_start;
>         em->disk_bytenr =3D block_start;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D len;
> @@ -740,7 +728,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>
>         em->start =3D SZ_4K;
>         em->len =3D SZ_4K;
> -       em->block_start =3D SZ_16K;
>         em->disk_bytenr =3D SZ_16K;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -795,7 +782,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         /* [0, 16K), pinned */
>         em->start =3D 0;
>         em->len =3D SZ_16K;
> -       em->block_start =3D 0;
>         em->disk_bytenr =3D 0;
>         em->disk_num_bytes =3D SZ_4K;
>         em->ram_bytes =3D SZ_16K;
> @@ -819,7 +805,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         /* [32K, 48K), not pinned */
>         em->start =3D SZ_32K;
>         em->len =3D SZ_16K;
> -       em->block_start =3D SZ_32K;
>         em->disk_bytenr =3D SZ_32K;
>         em->disk_num_bytes =3D SZ_16K;
>         em->ram_bytes =3D SZ_16K;
> @@ -885,8 +870,9 @@ static int test_case_7(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>                 goto out;
>         }
>
> -       if (em->block_start !=3D SZ_32K + SZ_4K) {
> -               test_err("em->block_start is %llu, expected 36K", em->blo=
ck_start);
> +       if (extent_map_block_start(em) !=3D SZ_32K + SZ_4K) {
> +               test_err("em->block_start is %llu, expected 36K",
> +                               extent_map_block_start(em));
>                 goto out;
>         }
>
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index 1b8c39edfc18..d6fd1978934a 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -264,8 +264,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a hole, got %llu", em->block_start);
> +       if (em->disk_bytenr !=3D EXTENT_MAP_HOLE) {
> +               test_err("expected a hole, got %llu", em->disk_bytenr);
>                 goto out;
>         }
>         free_extent_map(em);
> @@ -283,8 +283,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D EXTENT_MAP_INLINE) {
> -               test_err("expected an inline, got %llu", em->block_start)=
;
> +       if (em->disk_bytenr !=3D EXTENT_MAP_INLINE) {
> +               test_err("expected an inline, got %llu", em->disk_bytenr)=
;
>                 goto out;
>         }
>
> @@ -321,8 +321,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a hole, got %llu", em->block_start);
> +       if (em->disk_bytenr !=3D EXTENT_MAP_HOLE) {
> +               test_err("expected a hole, got %llu", em->disk_bytenr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D 4) {
> @@ -344,8 +344,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize - 1) {
> @@ -371,8 +371,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -389,7 +389,7 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
> -       disk_bytenr =3D em->block_start;
> +       disk_bytenr =3D extent_map_block_start(em);
>         orig_start =3D em->start;
>         offset =3D em->start + em->len;
>         free_extent_map(em);
> @@ -399,8 +399,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a hole, got %llu", em->block_start);
> +       if (em->disk_bytenr !=3D EXTENT_MAP_HOLE) {
> +               test_err("expected a hole, got %llu", em->disk_bytenr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -421,8 +421,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D 2 * sectorsize) {
> @@ -441,9 +441,9 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 goto out;
>         }
>         disk_bytenr +=3D (em->start - orig_start);
> -       if (em->block_start !=3D disk_bytenr) {
> +       if (extent_map_block_start(em) !=3D disk_bytenr) {
>                 test_err("wrong block start, want %llu, have %llu",
> -                        disk_bytenr, em->block_start);
> +                        disk_bytenr, extent_map_block_start(em));
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -455,8 +455,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -483,8 +483,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -502,7 +502,7 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
> -       disk_bytenr =3D em->block_start;
> +       disk_bytenr =3D extent_map_block_start(em);
>         orig_start =3D em->start;
>         offset =3D em->start + em->len;
>         free_extent_map(em);
> @@ -512,8 +512,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_HOLE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -531,9 +531,9 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          em->start - orig_start, em->offset);
>                 goto out;
>         }
> -       if (em->block_start !=3D disk_bytenr + em->offset) {
> +       if (extent_map_block_start(em) !=3D disk_bytenr + em->offset) {
>                 test_err("unexpected block start, wanted %llu, have %llu"=
,
> -                        disk_bytenr + em->offset, em->block_start);
> +                        disk_bytenr + em->offset, extent_map_block_start=
(em));
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -544,8 +544,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D 2 * sectorsize) {
> @@ -564,9 +564,9 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          em->start - orig_start, em->offset);
>                 goto out;
>         }
> -       if (em->block_start !=3D disk_bytenr + em->offset) {
> +       if (extent_map_block_start(em) !=3D disk_bytenr + em->offset) {
>                 test_err("unexpected block start, wanted %llu, have %llu"=
,
> -                        disk_bytenr + em->offset, em->block_start);
> +                        disk_bytenr + em->offset, extent_map_block_start=
(em));
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -578,8 +578,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D 2 * sectorsize) {
> @@ -611,8 +611,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -635,7 +635,7 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          BTRFS_COMPRESS_ZLIB, extent_map_compression(em))=
;
>                 goto out;
>         }
> -       disk_bytenr =3D em->block_start;
> +       disk_bytenr =3D extent_map_block_start(em);
>         orig_start =3D em->start;
>         offset =3D em->start + em->len;
>         free_extent_map(em);
> @@ -645,8 +645,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -671,9 +671,9 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D disk_bytenr) {
> +       if (extent_map_block_start(em) !=3D disk_bytenr) {
>                 test_err("block start does not match, want %llu got %llu"=
,
> -                        disk_bytenr, em->block_start);
> +                        disk_bytenr, extent_map_block_start(em));
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D 2 * sectorsize) {
> @@ -706,8 +706,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -732,8 +732,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a hole extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr !=3D EXTENT_MAP_HOLE) {
> +               test_err("expected a hole extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         /*
> @@ -764,8 +764,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start >=3D EXTENT_MAP_LAST_BYTE) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (em->disk_bytenr >=3D EXTENT_MAP_LAST_BYTE) {
> +               test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
>         if (em->start !=3D offset || em->len !=3D sectorsize) {
> @@ -843,8 +843,8 @@ static int test_hole_first(u32 sectorsize, u32 nodesi=
ze)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a hole, got %llu", em->block_start);
> +       if (em->disk_bytenr !=3D EXTENT_MAP_HOLE) {
> +               test_err("expected a hole, got %llu", em->disk_bytenr);
>                 goto out;
>         }
>         if (em->start !=3D 0 || em->len !=3D sectorsize) {
> @@ -865,8 +865,9 @@ static int test_hole_first(u32 sectorsize, u32 nodesi=
ze)
>                 test_err("got an error when we shouldn't have");
>                 goto out;
>         }
> -       if (em->block_start !=3D sectorsize) {
> -               test_err("expected a real extent, got %llu", em->block_st=
art);
> +       if (extent_map_block_start(em) !=3D sectorsize) {
> +               test_err("expected a real extent, got %llu",
> +                        extent_map_block_start(em));
>                 goto out;
>         }
>         if (em->start !=3D sectorsize || em->len !=3D sectorsize) {
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 13f35180e3a0..c4b67bf993d6 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4575,6 +4575,7 @@ static int log_extent_csums(struct btrfs_trans_hand=
le *trans,
>  {
>         struct btrfs_ordered_extent *ordered;
>         struct btrfs_root *csum_root;
> +       u64 block_start;
>         u64 csum_offset;
>         u64 csum_len;
>         u64 mod_start =3D em->start;
> @@ -4584,7 +4585,7 @@ static int log_extent_csums(struct btrfs_trans_hand=
le *trans,
>
>         if (inode->flags & BTRFS_INODE_NODATASUM ||
>             (em->flags & EXTENT_FLAG_PREALLOC) ||
> -           em->block_start =3D=3D EXTENT_MAP_HOLE)
> +           em->disk_bytenr =3D=3D EXTENT_MAP_HOLE)
>                 return 0;
>
>         list_for_each_entry(ordered, &ctx->ordered_extents, log_list) {
> @@ -4655,9 +4656,10 @@ static int log_extent_csums(struct btrfs_trans_han=
dle *trans,
>         }
>
>         /* block start is already adjusted for the file extent offset. */
> -       csum_root =3D btrfs_csum_root(trans->fs_info, em->block_start);
> -       ret =3D btrfs_lookup_csums_list(csum_root, em->block_start + csum=
_offset,
> -                                     em->block_start + csum_offset +
> +       block_start =3D extent_map_block_start(em);
> +       csum_root =3D btrfs_csum_root(trans->fs_info, block_start);
> +       ret =3D btrfs_lookup_csums_list(csum_root, block_start + csum_off=
set,
> +                                     block_start + csum_offset +
>                                       csum_len - 1, &ordered_sums, false)=
;
>         if (ret < 0)
>                 return ret;
> @@ -4689,6 +4691,7 @@ static int log_one_extent(struct btrfs_trans_handle=
 *trans,
>         struct btrfs_key key;
>         enum btrfs_compression_type compress_type;
>         u64 extent_offset =3D em->offset;
> +       u64 block_start =3D extent_map_block_start(em);
>         u64 block_len;
>         int ret;
>
> @@ -4701,10 +4704,10 @@ static int log_one_extent(struct btrfs_trans_hand=
le *trans,
>         block_len =3D em->disk_num_bytes;
>         compress_type =3D extent_map_compression(em);
>         if (compress_type !=3D BTRFS_COMPRESS_NONE) {
> -               btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_st=
art);
> +               btrfs_set_stack_file_extent_disk_bytenr(&fi, block_start)=
;
>                 btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len=
);
> -       } else if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> -               btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_st=
art -
> +       } else if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
> +               btrfs_set_stack_file_extent_disk_bytenr(&fi, block_start =
-
>                                                         extent_offset);
>                 btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len=
);
>         }
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 4b52a8916dbb..6d0f7fc9aaf2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1778,7 +1778,9 @@ static void btrfs_rewrite_logical_zoned(struct btrf=
s_ordered_extent *ordered,
>         write_lock(&em_tree->lock);
>         em =3D search_extent_mapping(em_tree, ordered->file_offset,
>                                    ordered->num_bytes);
> -       em->block_start =3D logical;
> +       /* The em should be a new COW extent, thus it should not has offs=
et. */

not has offset -> not have an offset

Otherwise it seems fine, but I still want to go over the rest of the patchs=
et.
I'm going slowly over it, and after commenting on each inidividual
patch, I'll comment on the cover letter.

Thanks.

> +       ASSERT(em->offset =3D=3D 0);
> +       em->disk_bytenr =3D logical;
>         free_extent_map(em);
>         write_unlock(&em_tree->lock);
>  }
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 3743719d13f2..89b2b66e5bc0 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -291,7 +291,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>                 __field(        u64,  ino               )
>                 __field(        u64,  start             )
>                 __field(        u64,  len               )
> -               __field(        u64,  block_start       )
>                 __field(        u32,  flags             )
>                 __field(        int,  refs              )
>         ),
> @@ -301,18 +300,16 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>                 __entry->ino            =3D btrfs_ino(inode);
>                 __entry->start          =3D map->start;
>                 __entry->len            =3D map->len;
> -               __entry->block_start    =3D map->block_start;
>                 __entry->flags          =3D map->flags;
>                 __entry->refs           =3D refcount_read(&map->refs);
>         ),
>
>         TP_printk_btrfs("root=3D%llu(%s) ino=3D%llu start=3D%llu len=3D%l=
lu "
> -                 "block_start=3D%llu(%s) flags=3D%s refs=3D%u",
> +                 "flags=3D%s refs=3D%u",
>                   show_root_type(__entry->root_objectid),
>                   __entry->ino,
>                   __entry->start,
>                   __entry->len,
> -                 show_map_type(__entry->block_start),
>                   show_map_flags(__entry->flags),
>                   __entry->refs)
>  );
> @@ -2608,7 +2605,6 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
>                 __field(        u64,    root_id         )
>                 __field(        u64,    start           )
>                 __field(        u64,    len             )
> -               __field(        u64,    block_start     )
>                 __field(        u32,    flags           )
>         ),
>
> @@ -2617,15 +2613,12 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
>                 __entry->root_id        =3D inode->root->root_key.objecti=
d;
>                 __entry->start          =3D em->start;
>                 __entry->len            =3D em->len;
> -               __entry->block_start    =3D em->block_start;
>                 __entry->flags          =3D em->flags;
>         ),
>
> -       TP_printk_btrfs(
> -"ino=3D%llu root=3D%llu(%s) start=3D%llu len=3D%llu block_start=3D%llu(%=
s) flags=3D%s",
> +       TP_printk_btrfs("ino=3D%llu root=3D%llu(%s) start=3D%llu len=3D%l=
lu flags=3D%s",
>                         __entry->ino, show_root_type(__entry->root_id),
>                         __entry->start, __entry->len,
> -                       show_map_type(__entry->block_start),
>                         show_map_flags(__entry->flags))
>  );
>
> --
> 2.45.0
>
>

