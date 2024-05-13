Return-Path: <linux-btrfs+bounces-4932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC688C412F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CDD1C22D43
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F7152197;
	Mon, 13 May 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxgXg5uu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2A1514C4
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604932; cv=none; b=SnkJbbHOKxWrZZu/qNTlIz8nT845YmuM5oak1itE+UVVp8McSaEHs1O3utrvYSs/yv9LUGTpmx3CLdx0YHRjTMkiexg8d/2ufv4h2Vjxiudm5GJu9jIdQSXGlHDzqQAM6uc7Letm72YQfZaqG1diJIXSz9p5eKbBRin42WCPcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604932; c=relaxed/simple;
	bh=pBFacvZqexX68Ku+lPSoxu3poJNrsrq4gKaXkFzYLRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTaersfaobphVvmyLmRdhnHIx/QMq34OkxltVl/zlOLZs/qF+cziIP+O1d5fjvBfh8V594DpObS6qsCP31V+JXJi0MMKwzQJGBQvdKtEcV8nRf03xqJfT/Mr66zI83rhgh/3G/6I2e7hOV3mMGAzacDq2wK/6MJ26smYUrcpHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxgXg5uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DA5C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715604932;
	bh=pBFacvZqexX68Ku+lPSoxu3poJNrsrq4gKaXkFzYLRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sxgXg5uuJ0XueZ322jfNbaxreq6eCqYZjeXapyq9LgxdhUeOUVbvBxnwFvKSd8q+U
	 CtqBiWbmwIfSCYmBzEYcRZIllBSX0ew0oQlDTn1iHWDBF4UjJCP2iAw7422w67ktMb
	 OWBEY9VHxNHexogT1JQL+jpv7GcKWIC4o3hm7+CwCoDBz5fpfQPk5wzIFH0CjwFAst
	 abZGWeIl9DMx1wHGvLhshDVDTDVOUpTY8ADOcgtTUI9A/n3Bgl1cxVXj8TxStontpf
	 Wz/QaPkQ1Dy+fOsjpMroSanALFsOY5zMgI/YEFFGbZjJ77Z+8qCN0daxBdow7n7qHw
	 l8XGn6z3wY2Gw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso8537767a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 05:55:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQ5tVYQeFEZa/Oz+pXV17H/oZd18Cy63Wqtlb4yWFLBKOdwa5U
	DBmcbZuOEOUWVLjtA5TJ0u/7ZaR2PGaeADy3w69xCw7esINyupfTjq2NU8AsVnFHF4M7cJXK1Rp
	sDMYj9B5iaRT5rWh72XaljcqlVvI=
X-Google-Smtp-Source: AGHT+IGc2sdNrsiyM4p9DKTs7Xs/fdweDZurIhYhvQag1lmFYCuByx9dlLTJhD1Zn73WHKiSevDWi4sVb51mm3E9iso=
X-Received: by 2002:a17:906:b7c4:b0:a59:bb24:a61 with SMTP id
 a640c23a62f3a-a5a2d292a23mr827492666b.30.1715604930507; Mon, 13 May 2024
 05:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
 <CAL3q7H7NdMixjcdXK_K8aphjxzUpr84WYUBO4EMysi3HhnCgNQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7NdMixjcdXK_K8aphjxzUpr84WYUBO4EMysi3HhnCgNQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 May 2024 13:54:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H53TC2FaCFVvK9FX5y6wotya3HBYMXMWObOoajYRP56sQ@mail.gmail.com>
Message-ID: <CAL3q7H53TC2FaCFVvK9FX5y6wotya3HBYMXMWObOoajYRP56sQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] btrfs: introduce new members for extent_map
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 1:48=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > Introduce two new members for extent_map:
> >
> > - disk_bytenr
> > - offset
> >
> > Both are matching the members with the same name inside
> > btrfs_file_extent_items.
> >
> > For now this patch only touches those members when:
> >
> > - Reading btrfs_file_extent_items from disk
> > - Inserting new holes
> > - Merging two extent maps
> >   With the new disk_bytenr and disk_num_bytes, doing merging would be a
> >   little complex, as we have 3 different cases:
> >
> >   * Both extent maps are referring to the same data extent
> >   * Both extent maps are referring to different data extents, but
> >     those data extents are adjacent, and extent maps are at head/tail
> >     of each data extents
> >   * One of the extent map is referring to an merged and larger data
> >     extent that covers both extent maps
> >
> >   The 3rd case seems only valid in selftest (test_case_3()), but
> >   a new helper merge_ondisk_extents() should be able to handle all of
> >   them.
> >
> > To properly assign values for those new members, a new btrfs_file_exten=
t
> > parameter is introduced to all the involved call sites.
> >
> > - For NOCOW writes the btrfs_file_extent would be exposed from
> >   can_nocow_file_extent().
> >
> > - For other writes, the members can be easily calculated
> >   As most of them have 0 offset and utilizing the whole on-disk data
> >   extent.
> >   The exception is encoded write, but thankfully that interface provide=
d
> >   offset directly and all other needed info.
> >
> > For now, both the old members (block_start/block_len/orig_start) are
> > co-existing with the new members (disk_bytenr/offset), meanwhile all th=
e
> > critical code is still using the old members only.
> >
> > The cleanup would happen later after all the older and newer members ar=
e
> > properly validated.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/defrag.c     |  4 +++
> >  fs/btrfs/extent_map.c | 75 +++++++++++++++++++++++++++++++++++++++++--
> >  fs/btrfs/extent_map.h | 17 ++++++++++
> >  fs/btrfs/file-item.c  |  9 +++++-
> >  fs/btrfs/file.c       |  1 +
> >  fs/btrfs/inode.c      | 60 ++++++++++++++++++++++++++++++----
> >  6 files changed, 155 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > index 407ccec3e57e..242c5469f4ba 100644
> > --- a/fs/btrfs/defrag.c
> > +++ b/fs/btrfs/defrag.c
> > @@ -709,6 +709,10 @@ static struct extent_map *defrag_get_extent(struct=
 btrfs_inode *inode,
> >                         em->start =3D start;
> >                         em->orig_start =3D start;
> >                         em->block_start =3D EXTENT_MAP_HOLE;
> > +                       em->disk_bytenr =3D EXTENT_MAP_HOLE;
> > +                       em->disk_num_bytes =3D 0;
> > +                       em->ram_bytes =3D 0;
> > +                       em->offset =3D 0;
> >                         em->len =3D key.offset - start;
> >                         break;
> >                 }
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index 4230dd0f34cc..4d4ac9fc43e2 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -232,6 +232,58 @@ static bool mergeable_maps(const struct extent_map=
 *prev, const struct extent_ma
> >         return next->block_start =3D=3D prev->block_start;
> >  }
> >
> > +/*
> > + * Handle the ondisk data extents merge for @prev and @next.
> > + *
> > + * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
> > + * For now only uncompressed regular extent can be merged.
> > + *
> > + * @prev and @next will be both updated to point to the new merged ran=
ge.
> > + * Thus one of them should be removed by the caller.
> > + */
> > +static void merge_ondisk_extents(struct extent_map *prev, struct exten=
t_map *next)
> > +{
> > +       u64 new_disk_bytenr;
> > +       u64 new_disk_num_bytes;
> > +       u64 new_offset;
> > +
> > +       /* @prev and @next should not be compressed. */
> > +       ASSERT(!extent_map_is_compressed(prev));
> > +       ASSERT(!extent_map_is_compressed(next));
> > +
> > +       /*
> > +        * There are several different cases that @prev and @next can b=
e merged.
> > +        *
> > +        * 1) They are referring to the same data extent
> > +        * 2) Their ondisk data extents are adjacent and @prev is the t=
ail
> > +        *    and @next is the head of their data extents
> > +        * 3) One of @prev/@next is referrring to a larger merged data =
extent.
> > +        *    (test_case_3 of extent maps tests).
> > +        *
> > +        * The calculation here always merge the data extents first, th=
en update
> > +        * @offset using the new data extents.
> > +        *
> > +        * For case 1), the merged data extent would be the same.
> > +        * For case 2), we just merge the two data extents into one.
> > +        * For case 3), we just got the larger data extent.
> > +        */
> > +       new_disk_bytenr =3D min(prev->disk_bytenr, next->disk_bytenr);
> > +       new_disk_num_bytes =3D max(prev->disk_bytenr + prev->disk_num_b=
ytes,
> > +                                next->disk_bytenr + next->disk_num_byt=
es) -
> > +                            new_disk_bytenr;
> > +       new_offset =3D prev->disk_bytenr + prev->offset - new_disk_byte=
nr;
> > +
> > +       prev->disk_bytenr =3D new_disk_bytenr;
> > +       prev->disk_num_bytes =3D new_disk_num_bytes;
> > +       prev->ram_bytes =3D new_disk_num_bytes;
> > +       prev->offset =3D new_offset;
> > +
> > +       next->disk_bytenr =3D new_disk_bytenr;
> > +       next->disk_num_bytes =3D new_disk_num_bytes;
> > +       next->ram_bytes =3D new_disk_num_bytes;
> > +       next->offset =3D new_offset;
> > +}
> > +
> >  static void try_merge_map(struct btrfs_inode *inode, struct extent_map=
 *em)
> >  {
> >         struct extent_map_tree *tree =3D &inode->extent_tree;
> > @@ -263,6 +315,9 @@ static void try_merge_map(struct btrfs_inode *inode=
, struct extent_map *em)
> >                         em->block_len +=3D merge->block_len;
> >                         em->block_start =3D merge->block_start;
> >                         em->generation =3D max(em->generation, merge->g=
eneration);
> > +
> > +                       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> > +                               merge_ondisk_extents(merge, em);
> >                         em->flags |=3D EXTENT_FLAG_MERGED;
> >
> >                         rb_erase_cached(&merge->rb_node, &tree->map);
> > @@ -278,6 +333,8 @@ static void try_merge_map(struct btrfs_inode *inode=
, struct extent_map *em)
> >         if (rb && can_merge_extent_map(merge) && mergeable_maps(em, mer=
ge)) {
> >                 em->len +=3D merge->len;
> >                 em->block_len +=3D merge->block_len;
> > +               if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> > +                       merge_ondisk_extents(em, merge);
> >                 rb_erase_cached(&merge->rb_node, &tree->map);
> >                 RB_CLEAR_NODE(&merge->rb_node);
> >                 em->generation =3D max(em->generation, merge->generatio=
n);
> > @@ -565,6 +622,7 @@ static noinline int merge_extent_mapping(struct btr=
fs_inode *inode,
> >             !extent_map_is_compressed(em)) {
> >                 em->block_start +=3D start_diff;
> >                 em->block_len =3D em->len;
> > +               em->offset +=3D start_diff;
> >         }
> >         return add_extent_mapping(inode, em, 0);
> >  }
> > @@ -783,14 +841,18 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
> >                                         split->block_len =3D em->block_=
len;
> >                                 else
> >                                         split->block_len =3D split->len=
;
> > +                               split->disk_bytenr =3D em->disk_bytenr;
> >                                 split->disk_num_bytes =3D max(split->bl=
ock_len,
> >                                                             em->disk_nu=
m_bytes);
> > +                               split->offset =3D em->offset;
> >                                 split->ram_bytes =3D em->ram_bytes;
> >                         } else {
> >                                 split->orig_start =3D split->start;
> >                                 split->block_len =3D 0;
> >                                 split->block_start =3D em->block_start;
> > +                               split->disk_bytenr =3D em->disk_bytenr;
> >                                 split->disk_num_bytes =3D 0;
> > +                               split->offset =3D 0;
> >                                 split->ram_bytes =3D split->len;
> >                         }
> >
> > @@ -811,13 +873,14 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
> >                         split->start =3D end;
> >                         split->len =3D em_end - end;
> >                         split->block_start =3D em->block_start;
> > +                       split->disk_bytenr =3D em->disk_bytenr;
> >                         split->flags =3D flags;
> >                         split->generation =3D gen;
> >
> >                         if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> >                                 split->disk_num_bytes =3D max(em->block=
_len,
> >                                                             em->disk_nu=
m_bytes);
> > -
> > +                               split->offset =3D em->offset + end - em=
->start;
> >                                 split->ram_bytes =3D em->ram_bytes;
> >                                 if (compressed) {
> >                                         split->block_len =3D em->block_=
len;
> > @@ -830,10 +893,11 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
> >                                         split->orig_start =3D em->orig_=
start;
> >                                 }
> >                         } else {
> > +                               split->disk_num_bytes =3D 0;
> > +                               split->offset =3D 0;
> >                                 split->ram_bytes =3D split->len;
> >                                 split->orig_start =3D split->start;
> >                                 split->block_len =3D 0;
> > -                               split->disk_num_bytes =3D 0;
> >                         }
> >
> >                         if (extent_map_in_tree(em)) {
> > @@ -987,6 +1051,9 @@ int split_extent_map(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 pre,
> >         /* First, replace the em with a new extent_map starting from * =
em->start */
> >         split_pre->start =3D em->start;
> >         split_pre->len =3D pre;
> > +       split_pre->disk_bytenr =3D new_logical;
> > +       split_pre->disk_num_bytes =3D split_pre->len;
> > +       split_pre->offset =3D 0;
> >         split_pre->orig_start =3D split_pre->start;
> >         split_pre->block_start =3D new_logical;
> >         split_pre->block_len =3D split_pre->len;
> > @@ -1005,10 +1072,12 @@ int split_extent_map(struct btrfs_inode *inode,=
 u64 start, u64 len, u64 pre,
> >         /* Insert the middle extent_map. */
> >         split_mid->start =3D em->start + pre;
> >         split_mid->len =3D em->len - pre;
> > +       split_mid->disk_bytenr =3D em->block_start + pre;
> > +       split_mid->disk_num_bytes =3D split_mid->len;
> > +       split_mid->offset =3D 0;
> >         split_mid->orig_start =3D split_mid->start;
> >         split_mid->block_start =3D em->block_start + pre;
> >         split_mid->block_len =3D split_mid->len;
> > -       split_mid->disk_num_bytes =3D split_mid->block_len;
> >         split_mid->ram_bytes =3D split_mid->len;
> >         split_mid->flags =3D flags;
> >         split_mid->generation =3D em->generation;
> > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > index 6ea0287b0d61..cc9c8092b704 100644
> > --- a/fs/btrfs/extent_map.h
> > +++ b/fs/btrfs/extent_map.h
> > @@ -70,12 +70,29 @@ struct extent_map {
> >          */
> >         u64 orig_start;
> >
> > +       /*
> > +        * The bytenr for of the full on-disk extent.
> > +        *
> > +        * For regular extents it's btrfs_file_extent_item::disk_bytenr=
.
> > +        * For holes it's EXTENT_MAP_HOLE and for inline extents it's
> > +        * EXTENT_MAP_INLINE.
> > +        */
> > +       u64 disk_bytenr;
> > +
> >         /*
> >          * The full on-disk extent length, matching
> >          * btrfs_file_extent_item::disk_num_bytes.
> >          */
> >         u64 disk_num_bytes;
> >
> > +       /*
> > +        * Offset inside the decompressed extent.
> > +        *
> > +        * For regular extents it's btrfs_file_extent_item::offset.
> > +        * For holes and inline extents it's 0.
> > +        */
> > +       u64 offset;
> > +
> >         /*
> >          * The decompressed size of the whole on-disk extent, matching
> >          * btrfs_file_extent_item::ram_bytes.
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 2197cfe5443b..47bd4fe0a44b 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -1294,12 +1294,17 @@ void btrfs_extent_item_to_extent_map(struct btr=
fs_inode *inode,
> >                 em->len =3D btrfs_file_extent_end(path) - extent_start;
> >                 em->orig_start =3D extent_start -
> >                         btrfs_file_extent_offset(leaf, fi);
> > -               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes=
(leaf, fi);
> >                 bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> >                 if (bytenr =3D=3D 0) {
> >                         em->block_start =3D EXTENT_MAP_HOLE;
> > +                       em->disk_bytenr =3D EXTENT_MAP_HOLE;
> > +                       em->disk_num_bytes =3D 0;
> > +                       em->offset =3D 0;
> >                         return;
> >                 }
> > +               em->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf,=
 fi);
> > +               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes=
(leaf, fi);
> > +               em->offset =3D btrfs_file_extent_offset(leaf, fi);
> >                 if (compress_type !=3D BTRFS_COMPRESS_NONE) {
> >                         extent_map_set_compression(em, compress_type);
> >                         em->block_start =3D bytenr;
> > @@ -1316,8 +1321,10 @@ void btrfs_extent_item_to_extent_map(struct btrf=
s_inode *inode,
> >                 ASSERT(extent_start =3D=3D 0);
> >
> >                 em->block_start =3D EXTENT_MAP_INLINE;
> > +               em->disk_bytenr =3D EXTENT_MAP_INLINE;
> >                 em->start =3D 0;
> >                 em->len =3D fs_info->sectorsize;
> > +               em->offset =3D 0;
> >                 /*
> >                  * Initialize orig_start and block_len with the same va=
lues
> >                  * as in inode.c:btrfs_get_extent().
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 63a13a4cace0..8931eeee199d 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2337,6 +2337,7 @@ static int fill_holes(struct btrfs_trans_handle *=
trans,
> >                 hole_em->orig_start =3D offset;
> >
> >                 hole_em->block_start =3D EXTENT_MAP_HOLE;
> > +               hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
> >                 hole_em->block_len =3D 0;
> >                 hole_em->disk_num_bytes =3D 0;
> >                 hole_em->generation =3D trans->transid;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 2815b72f2d85..42fea12d509f 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -139,8 +139,9 @@ static noinline int run_delalloc_cow(struct btrfs_i=
node *inode,
> >                                      bool pages_dirty);
> >  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 =
start,
> >                                        u64 len, u64 orig_start, u64 blo=
ck_start,
> > -                                      u64 block_len, u64 orig_block_le=
n,
> > +                                      u64 block_len, u64 disk_num_byte=
s,
>
> This hunk should have been in the previous patch, which renames

In the first patch actually.

> orig_block_len to disk_num_bytes everywhere, including the prototype
> declaration of this function.

And in the declaration of the function, not the prototype.


>
> >                                        u64 ram_bytes, int compress_type=
,
> > +                                      struct btrfs_file_extent *file_e=
xtent,
> >                                        int type);
> >
> >  static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 nu=
m_bytes,
> > @@ -1152,6 +1153,7 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
> >         struct btrfs_root *root =3D inode->root;
> >         struct btrfs_fs_info *fs_info =3D root->fs_info;
> >         struct btrfs_ordered_extent *ordered;
> > +       struct btrfs_file_extent file_extent =3D { 0 };
> >         struct btrfs_key ins;
> >         struct page *locked_page =3D NULL;
> >         struct extent_state *cached =3D NULL;
> > @@ -1198,6 +1200,13 @@ static void submit_one_async_extent(struct async=
_chunk *async_chunk,
> >         lock_extent(io_tree, start, end, &cached);
> >
> >         /* Here we're doing allocation and writeback of the compressed =
pages */
> > +       file_extent.disk_bytenr =3D ins.objectid;
> > +       file_extent.disk_num_bytes =3D ins.offset;
> > +       file_extent.ram_bytes =3D async_extent->ram_size;
> > +       file_extent.num_bytes =3D async_extent->ram_size;
> > +       file_extent.offset =3D 0;
> > +       file_extent.compression =3D async_extent->compress_type;
> > +
> >         em =3D create_io_em(inode, start,
> >                           async_extent->ram_size,       /* len */
> >                           start,                        /* orig_start *=
/
> > @@ -1206,6 +1215,7 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
> >                           ins.offset,                   /* orig_block_l=
en */
> >                           async_extent->ram_size,       /* ram_bytes */
> >                           async_extent->compress_type,
> > +                         &file_extent,
> >                           BTRFS_ORDERED_COMPRESSED);
> >         if (IS_ERR(em)) {
> >                 ret =3D PTR_ERR(em);
> > @@ -1395,6 +1405,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >
> >         while (num_bytes > 0) {
> >                 struct btrfs_ordered_extent *ordered;
> > +               struct btrfs_file_extent file_extent =3D { 0 };
> >
> >                 cur_alloc_size =3D num_bytes;
> >                 ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_=
alloc_size,
> > @@ -1431,6 +1442,12 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
> >                 extent_reserved =3D true;
> >
> >                 ram_size =3D ins.offset;
> > +               file_extent.disk_bytenr =3D ins.objectid;
> > +               file_extent.disk_num_bytes =3D ins.offset;
> > +               file_extent.num_bytes =3D ins.offset;
> > +               file_extent.ram_bytes =3D ins.offset;
> > +               file_extent.offset =3D 0;
> > +               file_extent.compression =3D BTRFS_COMPRESS_NONE;
> >
> >                 lock_extent(&inode->io_tree, start, start + ram_size - =
1,
> >                             &cached);
> > @@ -1442,6 +1459,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >                                   ins.offset, /* orig_block_len */
> >                                   ram_size, /* ram_bytes */
> >                                   BTRFS_COMPRESS_NONE, /* compress_type=
 */
> > +                                 &file_extent,
> >                                   BTRFS_ORDERED_REGULAR /* type */);
> >                 if (IS_ERR(em)) {
> >                         unlock_extent(&inode->io_tree, start,
> > @@ -1855,6 +1873,7 @@ struct can_nocow_file_extent_args {
> >         u64 disk_bytenr;
> >         u64 disk_num_bytes;
> >         u64 extent_offset;
> > +
> >         /* Number of bytes that can be written to in NOCOW mode. */
> >         u64 num_bytes;
> >
> > @@ -2182,6 +2201,7 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
> >                                           nocow_args.num_bytes, /* bloc=
k_len */
> >                                           nocow_args.disk_num_bytes, /*=
 orig_block_len */
> >                                           ram_bytes, BTRFS_COMPRESS_NON=
E,
> > +                                         &nocow_args.file_extent,
> >                                           BTRFS_ORDERED_PREALLOC);
> >                         if (IS_ERR(em)) {
> >                                 unlock_extent(&inode->io_tree, cur_offs=
et,
> > @@ -4982,6 +5002,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, =
loff_t oldsize, loff_t size)
> >                         hole_em->orig_start =3D cur_offset;
> >
> >                         hole_em->block_start =3D EXTENT_MAP_HOLE;
> > +                       hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
> >                         hole_em->block_len =3D 0;
> >                         hole_em->disk_num_bytes =3D 0;
> >                         hole_em->ram_bytes =3D hole_size;
> > @@ -6842,6 +6863,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_=
inode *inode,
> >         }
> >         em->start =3D EXTENT_MAP_HOLE;
> >         em->orig_start =3D EXTENT_MAP_HOLE;
> > +       em->disk_bytenr =3D EXTENT_MAP_HOLE;
> >         em->len =3D (u64)-1;
> >         em->block_len =3D (u64)-1;
> >
> > @@ -7007,7 +7029,8 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
> >                                                   const u64 block_len,
> >                                                   const u64 orig_block_=
len,
> >                                                   const u64 ram_bytes,
> > -                                                 const int type)
> > +                                                 const int type,
> > +                                                 struct btrfs_file_ext=
ent *file_extent)
> >  {
> >         struct extent_map *em =3D NULL;
> >         struct btrfs_ordered_extent *ordered;
> > @@ -7016,7 +7039,7 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
> >                 em =3D create_io_em(inode, start, len, orig_start, bloc=
k_start,
> >                                   block_len, orig_block_len, ram_bytes,
> >                                   BTRFS_COMPRESS_NONE, /* compress_type=
 */
> > -                                 type);
> > +                                 file_extent, type);
> >                 if (IS_ERR(em))
> >                         goto out;
> >         }
> > @@ -7047,6 +7070,7 @@ static struct extent_map *btrfs_new_extent_direct=
(struct btrfs_inode *inode,
> >  {
> >         struct btrfs_root *root =3D inode->root;
> >         struct btrfs_fs_info *fs_info =3D root->fs_info;
> > +       struct btrfs_file_extent file_extent =3D { 0 };
> >         struct extent_map *em;
> >         struct btrfs_key ins;
> >         u64 alloc_hint;
> > @@ -7065,9 +7089,16 @@ static struct extent_map *btrfs_new_extent_direc=
t(struct btrfs_inode *inode,
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> > +       file_extent.disk_bytenr =3D ins.objectid;
> > +       file_extent.disk_num_bytes =3D ins.offset;
> > +       file_extent.num_bytes =3D ins.offset;
> > +       file_extent.ram_bytes =3D ins.offset;
> > +       file_extent.offset =3D 0;
> > +       file_extent.compression =3D BTRFS_COMPRESS_NONE;
> >         em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offs=
et, start,
> >                                      ins.objectid, ins.offset, ins.offs=
et,
> > -                                    ins.offset, BTRFS_ORDERED_REGULAR)=
;
> > +                                    ins.offset, BTRFS_ORDERED_REGULAR,
> > +                                    &file_extent);
> >         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> >         if (IS_ERR(em))
> >                 btrfs_free_reserved_extent(fs_info, ins.objectid, ins.o=
ffset,
> > @@ -7310,6 +7341,7 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
> >                                        u64 len, u64 orig_start, u64 blo=
ck_start,
> >                                        u64 block_len, u64 disk_num_byte=
s,
> >                                        u64 ram_bytes, int compress_type=
,
> > +                                      struct btrfs_file_extent *file_e=
xtent,
> >                                        int type)
> >  {
> >         struct extent_map *em;
> > @@ -7367,9 +7399,11 @@ static struct extent_map *create_io_em(struct bt=
rfs_inode *inode, u64 start,
> >         em->len =3D len;
> >         em->block_len =3D block_len;
> >         em->block_start =3D block_start;
> > +       em->disk_bytenr =3D file_extent->disk_bytenr;
> >         em->disk_num_bytes =3D disk_num_bytes;
> >         em->ram_bytes =3D ram_bytes;
> >         em->generation =3D -1;
> > +       em->offset =3D file_extent->offset;
> >         em->flags |=3D EXTENT_FLAG_PINNED;
> >         if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> >                 extent_map_set_compression(em, compress_type);
> > @@ -7393,6 +7427,7 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
> >  {
> >         const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
> >         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> > +       struct btrfs_file_extent file_extent =3D { 0 };
> >         struct extent_map *em =3D *map;
> >         int type;
> >         u64 block_start, orig_start, orig_block_len, ram_bytes;
> > @@ -7423,7 +7458,8 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
> >                 block_start =3D em->block_start + (start - em->start);
> >
> >                 if (can_nocow_extent(inode, start, &len, &orig_start,
> > -                                    &orig_block_len, &ram_bytes, NULL,=
 false, false) =3D=3D 1) {
> > +                                    &orig_block_len, &ram_bytes,
> > +                                    &file_extent, false, false) =3D=3D=
 1) {
> >                         bg =3D btrfs_inc_nocow_writers(fs_info, block_s=
tart);
> >                         if (bg)
> >                                 can_nocow =3D true;
> > @@ -7451,7 +7487,8 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
> >                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_dat=
a, start, len,
> >                                               orig_start, block_start,
> >                                               len, orig_block_len,
> > -                                             ram_bytes, type);
> > +                                             ram_bytes, type,
> > +                                             &file_extent);
> >                 btrfs_dec_nocow_writers(bg);
> >                 if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
> >                         free_extent_map(em);
> > @@ -9602,6 +9639,8 @@ static int __btrfs_prealloc_file_range(struct ino=
de *inode, int mode,
> >                 em->orig_start =3D cur_offset;
> >                 em->len =3D ins.offset;
> >                 em->block_start =3D ins.objectid;
> > +               em->disk_bytenr =3D ins.objectid;
> > +               em->offset =3D 0;
> >                 em->block_len =3D ins.offset;
> >                 em->disk_num_bytes =3D ins.offset;
> >                 em->ram_bytes =3D ins.offset;
> > @@ -10168,6 +10207,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *io=
cb, struct iov_iter *from,
> >         struct extent_changeset *data_reserved =3D NULL;
> >         struct extent_state *cached_state =3D NULL;
> >         struct btrfs_ordered_extent *ordered;
> > +       struct btrfs_file_extent file_extent =3D { 0 };
> >         int compression;
> >         size_t orig_count;
> >         u64 start, end;
> > @@ -10343,10 +10383,16 @@ ssize_t btrfs_do_encoded_write(struct kiocb *=
iocb, struct iov_iter *from,
> >                 goto out_delalloc_release;
> >         extent_reserved =3D true;
> >
> > +       file_extent.disk_bytenr =3D ins.objectid;
> > +       file_extent.disk_num_bytes =3D ins.offset;
> > +       file_extent.num_bytes =3D num_bytes;
> > +       file_extent.ram_bytes =3D ram_bytes;
> > +       file_extent.offset =3D encoded->unencoded_offset;
> > +       file_extent.compression =3D compression;
> >         em =3D create_io_em(inode, start, num_bytes,
> >                           start - encoded->unencoded_offset, ins.object=
id,
> >                           ins.offset, ins.offset, ram_bytes, compressio=
n,
> > -                         BTRFS_ORDERED_COMPRESSED);
> > +                         &file_extent, BTRFS_ORDERED_COMPRESSED);
> >         if (IS_ERR(em)) {
> >                 ret =3D PTR_ERR(em);
> >                 goto out_free_reserved;
> > --
> > 2.45.0
> >
> >

