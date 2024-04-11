Return-Path: <linux-btrfs+bounces-4142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80B8A17F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21AD1C22A07
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAFDDC5;
	Thu, 11 Apr 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdi2wzER"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D9EAFA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847453; cv=none; b=c0Qvz5mzk7aspQDKZ+HEfHSmjAsHRLN0qnRjoWGTpRPXfDjQtfov1Clxiiu4ZP5BP0UFEr98xR9C12lYBMG3tvtYOiWWnLvxudaCXcHjeFdCHn/uw2dDfFJpj2FbNZsQJRGmLcJSX9SNmEgbJR1/VrjJw02igawGQSIH+uEcg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847453; c=relaxed/simple;
	bh=2DdUUuFMBaNNphiF5BYjBUC2mP4peIaAkYWBOTWnjcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFTk/Nq5OwJHe28U4tTUA+/VRjLtkYrpAejFOcyn12jCvPaVNH/h1Ue4dLBjmzWsKQI/MOp6sk3SAeYOY9rIO++k0XCs3Ao0z3lBJrwtD+1ia6JPr/l/M/G4frtaeM33rkbfN9LEfD8sh5vUnDGd4SxrOL3CrGuWv/8Y1+qjs7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdi2wzER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4306C113CE
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712847452;
	bh=2DdUUuFMBaNNphiF5BYjBUC2mP4peIaAkYWBOTWnjcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sdi2wzERTfNm4TZ5zwR+UgHhT1Zb/AhEidl++8MiQgN8TyWVIilkAKVHP27w0UvP2
	 NNVMP+xksuOoplRVKmzLdM5DUHxahYfuGmCYcV4XWTNQ1/nQov+9hr9AtbdcA5LSQ+
	 F3X1ThvVJkDIgEAtmivqooDgFIaQuusrxN63W92bjxt3fIrj2ktW7WrqmybhN/CSMz
	 1jSP20xpktA2dnY0TQNouvkSDjh1peDSP9rf4n6eDL8RPkE58bQoSeEHLmMGrMQAr9
	 14GQzFoDZ3zYnShpQ8ooemSwu8w550+W34BGVsNNzdb9tV+wXIOOomuRo+AF+qRjCL
	 KTreo2l+QwJbw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5200afe39eso313558366b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 07:57:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YxM1hm34i+sl+2Cpf0UtCtr009+nN4A14Jm9jIFBRdg4z73hC93
	mT2q1L9vfBipaRNmJNaWzkpW+iD950F8fvsShEaEoXDt2Xws1d8MqkjfjDawSrZdYlHeVaMJXPG
	sziXZ2nwFlMN7FWGKFqi5Bt2RMiM=
X-Google-Smtp-Source: AGHT+IFJJWl/xPRac0iPeiQ10ed0Nnl7aapEmiOHGSDxVVDp9myiQww1Bs1fcNTkXGR2l7QY/YETIGmolXlVMd7QXYA=
X-Received: by 2002:a17:906:a0c7:b0:a51:aeb8:bff5 with SMTP id
 bh7-20020a170906a0c700b00a51aeb8bff5mr4631318ejb.69.1712847450898; Thu, 11
 Apr 2024 07:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712614770.git.wqu@suse.com> <33ad6697db3e0e869e4553d95c3a3dc98883c278.1712614770.git.wqu@suse.com>
In-Reply-To: <33ad6697db3e0e869e4553d95c3a3dc98883c278.1712614770.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Apr 2024 15:56:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7MdJdv4L83ECpE1081OEv01gRX5VfxKL8MyWMdzAET5Q@mail.gmail.com>
Message-ID: <CAL3q7H7MdJdv4L83ECpE1081OEv01gRX5VfxKL8MyWMdzAET5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] btrfs: introduce new members for extent_map
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:34=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
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
> - Add a new member for can_nocow_file_extent_args
>   The new member is called "orig_disk_bytenr", for easier fetching the
>   old disk_bytenr.
>
> - Update the new members when doing extent map split
>   This is in fact a little simpler, as we only need to update
>   offset/len.
>
> - Update the new members when inserting new io extent map
>   This involves quite some NOCOW related functions, and adding two
>   parameters to a already long parameter list.
>
>   To avoid unexpected parameter change, the two new parameters,
>   @disk_bytenr and @offset are all added to the end of the list.
>
>   And they would be relocated when dropping the old
>   @block_start/@block_len/@orig_start members.
>
> For now, both the old members (block_start/block_len/orig_start) are
> co-existing with the new members (disk_bytenr/offset), meanwhile all the
> critical code is still using the old members only.
>
> The switch to new members would happen gradually to be bisect
> friendly.

I don't see why it is more bisect friendly.

If there's a bug the bisection will point to the patch that does the
switch, while the bug is very likely in the patch (this one) which is
adding the field and doing all its computations.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h |  3 +-
>  fs/btrfs/defrag.c      |  4 +++
>  fs/btrfs/extent_map.c  | 75 ++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/extent_map.h  | 17 ++++++++++
>  fs/btrfs/file-item.c   |  9 ++++-
>  fs/btrfs/file.c        |  3 +-
>  fs/btrfs/inode.c       | 56 +++++++++++++++++++++++--------
>  7 files changed, 147 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 100020ca4658..ded36e065089 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -444,7 +444,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struc=
t btrfs_device *dev,
>                         u32 bio_offset, struct bio_vec *bv);
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>                               u64 *orig_start, u64 *orig_block_len,
> -                             u64 *ram_bytes, bool nowait, bool strict);
> +                             u64 *ram_bytes, bool nowait, bool strict,
> +                             u64 *disk_bytenr_ret, u64 *extent_offset_re=
t);
>
>  void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
>  struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dent=
ry);
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index f015fa1b6301..5259fd556487 100644
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
> index dd51a21b6a76..f59423897501 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -223,6 +223,58 @@ static bool mergeable_maps(const struct extent_map *=
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

that -> where

> +        *
> +        * 1) They are referring to the same data extent
> +        * 2) Their ondisk data extents are adjacent and @prev is the tai=
l
> +        *    and @next is the head of their data extents
> +        * 3) One of @prev/@next is referrring to a larger merged data ex=
tent.

 referrring ->  referring

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
>  static void try_merge_map(struct extent_map_tree *tree, struct extent_ma=
p *em)
>  {
>         struct extent_map *merge =3D NULL;
> @@ -253,6 +305,9 @@ static void try_merge_map(struct extent_map_tree *tre=
e, struct extent_map *em)
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
> @@ -267,6 +322,8 @@ static void try_merge_map(struct extent_map_tree *tre=
e, struct extent_map *em)
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
> @@ -541,6 +598,7 @@ static noinline int merge_extent_mapping(struct exten=
t_map_tree *em_tree,
>             !extent_map_is_compressed(em)) {
>                 em->block_start +=3D start_diff;
>                 em->block_len =3D em->len;
> +               em->offset +=3D start_diff;
>         }
>         return add_extent_mapping(em_tree, em, 0);
>  }
> @@ -759,14 +817,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
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
> @@ -787,13 +849,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
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
> @@ -806,10 +869,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
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
> @@ -965,6 +1029,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 =
start, u64 len, u64 pre,
>         /* First, replace the em with a new extent_map starting from * em=
->start */
>         split_pre->start =3D em->start;
>         split_pre->len =3D pre;
> +       split_pre->disk_bytenr =3D new_logical;
> +       split_pre->disk_num_bytes =3D split_pre->len;
> +       split_pre->offset =3D 0;
>         split_pre->orig_start =3D split_pre->start;
>         split_pre->block_start =3D new_logical;
>         split_pre->block_len =3D split_pre->len;
> @@ -983,10 +1050,12 @@ int split_extent_map(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 pre,
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
> index 242a0c2e7a5e..848b4a4ecd6a 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -67,12 +67,29 @@ struct extent_map {
>          */
>         u64 orig_start;
>
> +       /*
> +        * The bytenr for of the full on-disk extent.

"for of" should be just "of".

I've only skimmed through the patch, but it seems ok.

Thanks.

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
> index b552646a0ce6..96486f82ab5d 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1280,12 +1280,17 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
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
> @@ -1302,8 +1307,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
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
> index cdcd7e0785c1..af6de3549901 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1094,7 +1094,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inod=
e, loff_t pos,
>                                                    &cached_state);
>         }
>         ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes=
,
> -                       NULL, NULL, NULL, nowait, false);
> +                       NULL, NULL, NULL, nowait, false, NULL, NULL);
>         if (ret <=3D 0)
>                 btrfs_drew_write_unlock(&root->snapshot_lock);
>         else
> @@ -2161,6 +2161,7 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>                 hole_em->orig_start =3D offset;
>
>                 hole_em->block_start =3D EXTENT_MAP_HOLE;
> +               hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                 hole_em->block_len =3D 0;
>                 hole_em->disk_num_bytes =3D 0;
>                 hole_em->generation =3D trans->transid;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4d207c3b38d9..69a7cdeef81e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -139,9 +139,9 @@ static noinline int run_delalloc_cow(struct btrfs_ino=
de *inode,
>                                      bool pages_dirty);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
>                                        u64 len, u64 orig_start, u64 block=
_start,
> -                                      u64 block_len, u64 orig_block_len,
> +                                      u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
> -                                      int type);
> +                                      int type, u64 disk_bytenr, u64 off=
set);
>
>  static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_=
bytes,
>                                           u64 root, void *warn_ctx)
> @@ -1166,7 +1166,8 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>                           ins.offset,                   /* orig_block_len=
 */
>                           async_extent->ram_size,       /* ram_bytes */
>                           async_extent->compress_type,
> -                         BTRFS_ORDERED_COMPRESSED);
> +                         BTRFS_ORDERED_COMPRESSED,
> +                         ins.objectid, 0);
>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
>                 goto out_free_reserve;
> @@ -1429,7 +1430,8 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                                   ins.offset, /* orig_block_len */
>                                   ram_size, /* ram_bytes */
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
> -                                 BTRFS_ORDERED_REGULAR /* type */);
> +                                 BTRFS_ORDERED_REGULAR /* type */,
> +                                 ins.objectid, 0);
>                 if (IS_ERR(em)) {
>                         ret =3D PTR_ERR(em);
>                         goto out_reserve;
> @@ -1859,6 +1861,7 @@ struct can_nocow_file_extent_args {
>          */
>
>         u64 block_start;
> +       u64 orig_disk_bytenr;
>         u64 orig_disk_num_bytes;
>         u64 orig_offset;
>         /* Number of bytes that can be written to in NOCOW mode. */
> @@ -1897,6 +1900,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>
>         /* Can't access these fields unless we know it's not an inline ex=
tent. */
>         args->block_start =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> +       args->orig_disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi=
);
>         args->orig_disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(le=
af, fi);
>         args->orig_offset =3D btrfs_file_extent_offset(leaf, fi);
>
> @@ -2169,7 +2173,10 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>                                           nocow_args.num_bytes, /* block_=
len */
>                                           nocow_args.orig_disk_num_bytes,=
 /* orig_block_len */
>                                           ram_bytes, BTRFS_COMPRESS_NONE,
> -                                         BTRFS_ORDERED_PREALLOC);
> +                                         BTRFS_ORDERED_PREALLOC,
> +                                         nocow_args.orig_disk_bytenr,
> +                                         cur_offset - found_key.offset +
> +                                         nocow_args.orig_offset);
>                         if (IS_ERR(em)) {
>                                 btrfs_dec_nocow_writers(nocow_bg);
>                                 ret =3D PTR_ERR(em);
> @@ -4999,6 +5006,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>                         hole_em->orig_start =3D cur_offset;
>
>                         hole_em->block_start =3D EXTENT_MAP_HOLE;
> +                       hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         hole_em->block_len =3D 0;
>                         hole_em->disk_num_bytes =3D 0;
>                         hole_em->ram_bytes =3D hole_size;
> @@ -6860,6 +6868,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>         }
>         em->start =3D EXTENT_MAP_HOLE;
>         em->orig_start =3D EXTENT_MAP_HOLE;
> +       em->disk_bytenr =3D EXTENT_MAP_HOLE;
>         em->len =3D (u64)-1;
>         em->block_len =3D (u64)-1;
>
> @@ -7025,7 +7034,9 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                                                   const u64 block_len,
>                                                   const u64 orig_block_le=
n,
>                                                   const u64 ram_bytes,
> -                                                 const int type)
> +                                                 const int type,
> +                                                 const u64 disk_bytenr,
> +                                                 const u64 offset)
>  {
>         struct extent_map *em =3D NULL;
>         struct btrfs_ordered_extent *ordered;
> @@ -7034,7 +7045,7 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                 em =3D create_io_em(inode, start, len, orig_start, block_=
start,
>                                   block_len, orig_block_len, ram_bytes,
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
> -                                 type);
> +                                 type, disk_bytenr, offset);
>                 if (IS_ERR(em))
>                         goto out;
>         }
> @@ -7085,7 +7096,8 @@ static struct extent_map *btrfs_new_extent_direct(s=
truct btrfs_inode *inode,
>
>         em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
, start,
>                                      ins.objectid, ins.offset, ins.offset=
,
> -                                    ins.offset, BTRFS_ORDERED_REGULAR);
> +                                    ins.offset, BTRFS_ORDERED_REGULAR,
> +                                    ins.objectid, 0);
>         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>         if (IS_ERR(em))
>                 btrfs_free_reserved_extent(fs_info, ins.objectid, ins.off=
set,
> @@ -7129,7 +7141,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr)
>   */
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>                               u64 *orig_start, u64 *orig_block_len,
> -                             u64 *ram_bytes, bool nowait, bool strict)
> +                             u64 *ram_bytes, bool nowait, bool strict,
> +                             u64 *disk_bytenr_ret, u64 *new_offset_ret)
>  {
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>         struct can_nocow_file_extent_args nocow_args =3D { 0 };
> @@ -7218,6 +7231,11 @@ noinline int can_nocow_extent(struct inode *inode,=
 u64 offset, u64 *len,
>                 *orig_start =3D key.offset - nocow_args.orig_offset;
>         if (orig_block_len)
>                 *orig_block_len =3D nocow_args.orig_disk_num_bytes;
> +       if (disk_bytenr_ret)
> +               *disk_bytenr_ret =3D nocow_args.orig_disk_bytenr;
> +       if (new_offset_ret)
> +               *new_offset_ret =3D offset - key.offset +
> +                                 nocow_args.orig_offset;
>
>         *len =3D nocow_args.num_bytes;
>         ret =3D 1;
> @@ -7324,7 +7342,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>                                        u64 len, u64 orig_start, u64 block=
_start,
>                                        u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
> -                                      int type)
> +                                      int type, u64 disk_bytenr, u64 off=
set)
>  {
>         struct extent_map *em;
>         int ret;
> @@ -7381,9 +7399,11 @@ static struct extent_map *create_io_em(struct btrf=
s_inode *inode, u64 start,
>         em->len =3D len;
>         em->block_len =3D block_len;
>         em->block_start =3D block_start;
> +       em->disk_bytenr =3D disk_bytenr;
>         em->disk_num_bytes =3D disk_num_bytes;
>         em->ram_bytes =3D ram_bytes;
>         em->generation =3D -1;
> +       em->offset =3D offset;
>         em->flags |=3D EXTENT_FLAG_PINNED;
>         if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>                 extent_map_set_compression(em, compress_type);
> @@ -7410,6 +7430,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>         struct extent_map *em =3D *map;
>         int type;
>         u64 block_start, orig_start, orig_block_len, ram_bytes;
> +       u64 disk_bytenr;
> +       u64 new_offset;
>         struct btrfs_block_group *bg;
>         bool can_nocow =3D false;
>         bool space_reserved =3D false;
> @@ -7437,7 +7459,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 block_start =3D em->block_start + (start - em->start);
>
>                 if (can_nocow_extent(inode, start, &len, &orig_start,
> -                                    &orig_block_len, &ram_bytes, false, =
false) =3D=3D 1) {
> +                                    &orig_block_len, &ram_bytes, false, =
false,
> +                                    &disk_bytenr, &new_offset) =3D=3D 1)=
 {
>                         bg =3D btrfs_inc_nocow_writers(fs_info, block_sta=
rt);
>                         if (bg)
>                                 can_nocow =3D true;
> @@ -7465,7 +7488,8 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
>                                               orig_start, block_start,
>                                               len, orig_block_len,
> -                                             ram_bytes, type);
> +                                             ram_bytes, type,
> +                                             disk_bytenr, new_offset);
>                 btrfs_dec_nocow_writers(bg);
>                 if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
>                         free_extent_map(em);
> @@ -9784,6 +9808,8 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>                 em->orig_start =3D cur_offset;
>                 em->len =3D ins.offset;
>                 em->block_start =3D ins.objectid;
> +               em->disk_bytenr =3D ins.objectid;
> +               em->offset =3D 0;
>                 em->block_len =3D ins.offset;
>                 em->disk_num_bytes =3D ins.offset;
>                 em->ram_bytes =3D ins.offset;
> @@ -10526,7 +10552,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         em =3D create_io_em(inode, start, num_bytes,
>                           start - encoded->unencoded_offset, ins.objectid=
,
>                           ins.offset, ins.offset, ram_bytes, compression,
> -                         BTRFS_ORDERED_COMPRESSED);
> +                         BTRFS_ORDERED_COMPRESSED, ins.objectid,
> +                         encoded->unencoded_offset);
>         if (IS_ERR(em)) {
>                 ret =3D PTR_ERR(em);
>                 goto out_free_reserved;
> @@ -10856,7 +10883,8 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>                 free_extent_map(em);
>                 em =3D NULL;
>
> -               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL, false, true);
> +               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL,
> +                                      false, true, NULL, NULL);
>                 if (ret < 0) {
>                         goto out;
>                 } else if (ret) {
> --
> 2.44.0
>
>

