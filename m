Return-Path: <linux-btrfs+bounces-5256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8B8CD8B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 18:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF0C1C213C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFB20DC3;
	Thu, 23 May 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsN1UWnd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65C1CF9A
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483264; cv=none; b=J3YAnI29JtLWLlqwdwpsxx7qNICa986M8AmuWmnK+8yi271ULFspvKTekoq4EqW8bfKOpntzdKckee18EDcN4s64VFUEDaSxT7rU69egRiaMV2ax+OAK1Jc4Z1FYOq4xc2S11KSH3Tku3+cIhQCEPNgvRLw4CE6uyMavBT1MuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483264; c=relaxed/simple;
	bh=sc9mxfoztMz86NHOwAag3pIdZ30q95vKu4E02piLcB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYATzbcHLZ3o5/SUkssEc53gWQyElxolHIE068UKvSFacO9CXuddNXSDzbVjG8hqRUsKwCJ/+sM2wC2jrA6JWkuwC0iJk71j0hy6iHBsDq59K0MWFMsFd7qV6PgT+ToXnz2XDiQym9meKakSpJY3TGbi0thp/ArghARLFs8PxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsN1UWnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9598C2BD10
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716483264;
	bh=sc9mxfoztMz86NHOwAag3pIdZ30q95vKu4E02piLcB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EsN1UWndRWr90UgJLZELhNZVTWsfSGkGTlAqbIWzmrIoS8P6YuJXEFL8Dsf6is7+l
	 XITlOGc6PEad8U5Vy9sdG/2b5d3Vn5rDzFemoUVH7oq0Z6GSSW2AZGbJ2HlKLGNShe
	 3gKScAPv6rr+lO/Byma2L3jp5wAb+9dpvpE6zJoc0IzKjoU8Ov6kucft+UvXXlC3+i
	 8wiEEiRMnWBIN65Bl4X3x3teTgF11uqBTLVN14Yl45A4YS8EFqe3cflbTzDjApktAB
	 pk1XJ9Ql21HhTjugV2BkUxodgNEsh6OzejfaLYw1bNnVKqbbfsdhQ2E9C+cVzHxlWX
	 TzRAqHhNN8wIw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a623cf7764bso188872266b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:54:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/YgSGi9LAiZRsoTaSJtGxcqpa7Tklk7Ikqf1RBnIx8/w56mrp
	oryhAr3U6hNiMOu2RiO4bxVI1pEuRHXpvfOLIrblvYh0PMFPVDGZNnA3+T+5zI1M6B6a3hclbyE
	kq/695g4iWneoy+zClERRXy9KvhA=
X-Google-Smtp-Source: AGHT+IGSxg9vjZqRiJj7ubDZbfLAipSc6jrXxaH9PmNBVA/v9WOE6r/MUwdeooYbWXd9esxT6/vta/JV/S1/e9mnpk8=
X-Received: by 2002:a17:907:54d:b0:a62:2e6e:d28c with SMTP id
 a640c23a62f3a-a623ea0373amr234512966b.34.1716483262278; Thu, 23 May 2024
 09:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716440169.git.wqu@suse.com> <41be25a4c77c46f8725c13636098f5f37e5c3d93.1716440169.git.wqu@suse.com>
In-Reply-To: <41be25a4c77c46f8725c13636098f5f37e5c3d93.1716440169.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 23 May 2024 17:53:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4ESOZTAaG4Opf3u_8p4BJ_cQPDGs-SdY9vCCFHe6KrCg@mail.gmail.com>
Message-ID: <CAL3q7H4ESOZTAaG4Opf3u_8p4BJ_cQPDGs-SdY9vCCFHe6KrCg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] btrfs: introduce new members for extent_map
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 6:04=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
>   little more complex, as we have 3 different cases:
>
>   * Both extent maps are referring to the same data extents
>     |<----- data extent A ----->|
>        |<- em 1 ->|<- em 2 ->|
>
>   * Both extent maps are referring to different data extents
>     |<-- data extent A -->|<-- data extent B -->|
>                |<- em 1 ->|<- em 2 ->|
>
>   * One of the extent maps is referring to a merged and larger data
>     extent that covers both extent maps
>
>     This is not really valid case other than some selftests.
>     So this test case would be removed.
>
>   A new helper merge_ondisk_extents() would be introduced to handle
>   above valid cases.
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
>  fs/btrfs/extent_map.c | 78 ++++++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/extent_map.h | 17 ++++++++++
>  fs/btrfs/file-item.c  |  9 ++++-
>  fs/btrfs/file.c       |  1 +
>  fs/btrfs/inode.c      | 57 +++++++++++++++++++++++++++----
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
> index a9d60d1eade9..c7d2393692e6 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -229,6 +229,60 @@ static bool mergeable_maps(const struct extent_map *=
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
> +        * There are two different cases where @prev and @next can be mer=
ged.
> +        *
> +        * 1) They are referring to the same data extent
> +        * |<----- data extent A ----->|
> +        *    |<- prev ->|<- next ->|
> +        *
> +        * 2) They are referring to different data extents but still adja=
cent
> +        *
> +        * |<-- data extent A -->|<-- data extent B -->|
> +        *            |<- prev ->|<- next ->|
> +        *
> +        * The calculation here always merge the data extents first, then=
 update
> +        * @offset using the new data extents.
> +        *
> +        * For case 1), the merged data extent would be the same.
> +        * For case 2), we just merge the two data extents into one.
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
> @@ -260,6 +314,9 @@ static void try_merge_map(struct btrfs_inode *inode, =
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
>                         rb_erase(&merge->rb_node, &tree->root);
> @@ -275,6 +332,8 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>         if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge=
)) {
>                 em->len +=3D merge->len;
>                 em->block_len +=3D merge->block_len;
> +               if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> +                       merge_ondisk_extents(em, merge);
>                 rb_erase(&merge->rb_node, &tree->root);
>                 RB_CLEAR_NODE(&merge->rb_node);
>                 em->generation =3D max(em->generation, merge->generation)=
;
> @@ -562,6 +621,7 @@ static noinline int merge_extent_mapping(struct btrfs=
_inode *inode,
>             !extent_map_is_compressed(em)) {
>                 em->block_start +=3D start_diff;
>                 em->block_len =3D em->len;
> +               em->offset +=3D start_diff;
>         }
>         return add_extent_mapping(inode, em, 0);
>  }
> @@ -785,14 +845,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
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
> @@ -813,13 +877,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
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
> @@ -832,10 +897,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
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

Why move the assignment of ->disk_num_bytes ?
This is sort of distracting, doing unnecessary changes.

>                         }
>
>                         if (extent_map_in_tree(em)) {
> @@ -989,10 +1055,12 @@ int split_extent_map(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 pre,
>         /* First, replace the em with a new extent_map starting from * em=
->start */
>         split_pre->start =3D em->start;
>         split_pre->len =3D pre;
> +       split_pre->disk_bytenr =3D new_logical;

We are already setting disk_bytenr to the same value a few lines below.

> +       split_pre->disk_num_bytes =3D split_pre->len;
> +       split_pre->offset =3D 0;
>         split_pre->orig_start =3D split_pre->start;
>         split_pre->block_start =3D new_logical;
>         split_pre->block_len =3D split_pre->len;
> -       split_pre->disk_num_bytes =3D split_pre->block_len;

Here, where slit_pre->block_len has the same value as split->pre_len.
This sort of apparently accidental change makes it harder to review.

>         split_pre->ram_bytes =3D split_pre->len;
>         split_pre->flags =3D flags;
>         split_pre->generation =3D em->generation;
> @@ -1007,10 +1075,12 @@ int split_extent_map(struct btrfs_inode *inode, u=
64 start, u64 len, u64 pre,
>         /* Insert the middle extent_map. */
>         split_mid->start =3D em->start + pre;
>         split_mid->len =3D em->len - pre;
> +       split_mid->disk_bytenr =3D em->block_start + pre;

Same here.

> +       split_mid->disk_num_bytes =3D split_mid->len;
> +       split_mid->offset =3D 0;
>         split_mid->orig_start =3D split_mid->start;
>         split_mid->block_start =3D em->block_start + pre;
>         split_mid->block_len =3D split_mid->len;
> -       split_mid->disk_num_bytes =3D split_mid->block_len;

Which relates to this.

Otherwise it looks fine, and could be fixed up when cherry picked to for-ne=
xt.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>         split_mid->ram_bytes =3D split_mid->len;
>         split_mid->flags =3D flags;
>         split_mid->generation =3D em->generation;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 2b7bbffd594b..0b1a8e409377 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -70,12 +70,29 @@ struct extent_map {
>          */
>         u64 orig_start;
>
> +       /*
> +        * The bytenr of the full on-disk extent.
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
> index 430dce44ebd2..1298afea9503 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1295,12 +1295,17 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
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
> @@ -1317,8 +1322,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
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
> index 7c42565da70c..5133c6705d74 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2350,6 +2350,7 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>                 hole_em->orig_start =3D offset;
>
>                 hole_em->block_start =3D EXTENT_MAP_HOLE;
> +               hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                 hole_em->block_len =3D 0;
>                 hole_em->disk_num_bytes =3D 0;
>                 hole_em->generation =3D trans->transid;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8ac489fb5e39..7afcdea27782 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -141,6 +141,7 @@ static struct extent_map *create_io_em(struct btrfs_i=
node *inode, u64 start,
>                                        u64 len, u64 orig_start, u64 block=
_start,
>                                        u64 block_len, u64 disk_num_bytes,
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
> +       struct btrfs_file_extent file_extent;
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
> +               struct btrfs_file_extent file_extent;
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
> @@ -2180,6 +2198,7 @@ static noinline int run_delalloc_nocow(struct btrfs=
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
> @@ -5012,6 +5031,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>                         hole_em->orig_start =3D cur_offset;
>
>                         hole_em->block_start =3D EXTENT_MAP_HOLE;
> +                       hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         hole_em->block_len =3D 0;
>                         hole_em->disk_num_bytes =3D 0;
>                         hole_em->ram_bytes =3D hole_size;
> @@ -6880,6 +6900,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>         }
>         em->start =3D EXTENT_MAP_HOLE;
>         em->orig_start =3D EXTENT_MAP_HOLE;
> +       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>         em->len =3D (u64)-1;
>         em->block_len =3D (u64)-1;
>
> @@ -7045,7 +7066,8 @@ static struct extent_map *btrfs_create_dio_extent(s=
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
> @@ -7054,7 +7076,7 @@ static struct extent_map *btrfs_create_dio_extent(s=
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
> @@ -7085,6 +7107,7 @@ static struct extent_map *btrfs_new_extent_direct(s=
truct btrfs_inode *inode,
>  {
>         struct btrfs_root *root =3D inode->root;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> +       struct btrfs_file_extent file_extent;
>         struct extent_map *em;
>         struct btrfs_key ins;
>         u64 alloc_hint;
> @@ -7103,9 +7126,16 @@ static struct extent_map *btrfs_new_extent_direct(=
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
> @@ -7348,6 +7378,7 @@ static struct extent_map *create_io_em(struct btrfs=
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
> @@ -7405,9 +7436,11 @@ static struct extent_map *create_io_em(struct btrf=
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
> @@ -7431,6 +7464,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>  {
>         const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> +       struct btrfs_file_extent file_extent;
>         struct extent_map *em =3D *map;
>         int type;
>         u64 block_start, orig_start, orig_block_len, ram_bytes;
> @@ -7461,7 +7495,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
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
> @@ -7489,7 +7524,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
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
> @@ -9629,6 +9665,8 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>                 em->orig_start =3D cur_offset;
>                 em->len =3D ins.offset;
>                 em->block_start =3D ins.objectid;
> +               em->disk_bytenr =3D ins.objectid;
> +               em->offset =3D 0;
>                 em->block_len =3D ins.offset;
>                 em->disk_num_bytes =3D ins.offset;
>                 em->ram_bytes =3D ins.offset;
> @@ -10195,6 +10233,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         struct extent_changeset *data_reserved =3D NULL;
>         struct extent_state *cached_state =3D NULL;
>         struct btrfs_ordered_extent *ordered;
> +       struct btrfs_file_extent file_extent;
>         int compression;
>         size_t orig_count;
>         u64 start, end;
> @@ -10370,10 +10409,16 @@ ssize_t btrfs_do_encoded_write(struct kiocb *io=
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
> 2.45.1
>
>

