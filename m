Return-Path: <linux-btrfs+bounces-3832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C26895EE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062481C23794
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCDE15E5DC;
	Tue,  2 Apr 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvCotySl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C915AAA7
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094274; cv=none; b=VlALP4nPgmqs8f//OC2DQfElfV/aiQVljucA/YjT8LFSQZ2NQ9ovn3LSr5hJgxOX3fAl9Tx3mVcu24PfG6A04GO6U/xjvplhTsV5myeZel5nllUVqJdYWSjhC2CwwOTJd6NBrLEW1EO+WlxmOXeGL/scvcjv2TXR+9Pv6TVYhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094274; c=relaxed/simple;
	bh=IwOnm5Ahccy0q3aHQRCRVfAmH8Eb0rByS8S/GaupuQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjCnUsPvoit9pvBc86ciORRRP+gK/sx1gJoFgGpFLVKCFmWlr+UAHJ2uaG/U+upOHw91rIz6Xil8mD7fBwSL+LZ+zHLY94AjXlkpNDEY5/O9fEIssAXrCex5zJAcYKOx2wE8AvACfcKCdcLk4AVyCASikXWyTZinQONJscYzBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvCotySl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7A3C43390
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712094273;
	bh=IwOnm5Ahccy0q3aHQRCRVfAmH8Eb0rByS8S/GaupuQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OvCotySlbiHfjNOAvcxhz5vVNnBz9XZnG4Vs/jcdezm0ty44Jp9yQBQ3YmAOf0wDO
	 494bSRXRW5WtL5bGlVorHO20XHoKj4yu1d29Sdvm2fuaQV59DX42L1w/w0mFn/bM8t
	 y2dIKaBE+pCxi97zvDDNerc8VAYwKftHiPI4um0uqG2e2/A+lX/DpM9BRbkHjGwfxP
	 o//3iMn3nkDFHDYRGJe7QdxX+xF6gwPw8feuJ0wDIb0zZzIzcLUrzBuYerXAhA42K6
	 uM5nmtfwpQc65mxB8jdZEfRUzq0NWciQ+12wKI2JV4HmUToMNnGBfOjbcO94YN7824
	 aP4TOcegNT4qA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a468226e135so682153766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 14:44:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzj9kxUMnYlNNcKCzI1EN52fml2pfHcLoCJMt7DwfdZXOYDMrKE
	gXTFYtD4S5FL66eJCPrF3LxpdjPVpu4wvU1QFmMXB3uLJwZURPaw6ZF0WiidI8lnv6W/PJOn0oN
	HCmBOZJ8pTHqTdYDOPnMYSrw2p48=
X-Google-Smtp-Source: AGHT+IEgUYBh2+hEsOZcLJA/dVQ1jUVa27jnjuDQndoQaooX/aOZV+zKgJ8mNl2A1vHg2mkHJYcfe7AKYul7TaAsQ+0=
X-Received: by 2002:a17:907:1b08:b0:a4e:75bf:518 with SMTP id
 mp8-20020a1709071b0800b00a4e75bf0518mr5290899ejc.63.1712094272162; Tue, 02
 Apr 2024 14:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b5929e96bbede278f63c68a149cb50645b094d6.1712074768.git.fdmanana@suse.com>
 <ddd3fbbc-612a-45b1-955b-bc938c4ddb7f@gmx.com>
In-Reply-To: <ddd3fbbc-612a-45b1-955b-bc938c4ddb7f@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Apr 2024 21:43:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H51p8nyusrAi6dbR3RR4YxtXBHxGUVALt+Xj2Z8EPvZjQ@mail.gmail.com>
Message-ID: <CAL3q7H51p8nyusrAi6dbR3RR4YxtXBHxGUVALt+Xj2Z8EPvZjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove not needed mod_start and mod_len from
 struct extent_map
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/3 03:10, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The mod_start and mod_len fields of struct extent_map were introduced b=
y
> > commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that we
> > want") in order to avoid too low performance when fsyncing a file that
> > keeps getting extent maps merge, because it resulted in each fsync logg=
ing
> > again csum ranges that were already merged before.
> >
> > We don't need this anymore as extent maps in the modified list of exten=
ts
> > that get merged with other extents and once we log an extent map we rem=
ove
> > it from the list of modified extent maps.
> >
> > So remove the mod_start and mod_len fields from struct extent_map and u=
se
> > instead the start and len fields when logging checksums in the fast fsy=
nc
> > path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.
> >
> > Running the reproducer from the commit mentioned before, with a larger
> > number of extents and against a null block device, so that IO is fast
> > and we can better see any impact from searching checkums items and logg=
ing
> > them, gave the following results from dd:
> >
> > Before this change:
> >
> >     409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
> >
> > After this change:
> >
> >     409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
> >
> > So no changes in throughput.
> > The test was done in a release kernel (non-debug, Debian's default kern=
el
> > config) and its steps are the following:
> >
> >     $ mkfs.btrfs -f /dev/nullb0
> >     $ mount /dev/sdb /mnt
> >     $ dd if=3D/dev/zero of=3D/mnt/foobar bs=3D4k count=3D100000 oflag=
=3Dsync
> >     $ umount /mnt
> >
> > This also reduce the size of struct extent_map from 128 bytes down to 1=
12
> > bytes, so now we can have 36 extents maps per 4K page instead of 32.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Great we can start cleaning up the extent map members.
>
> Mind this patch to be included in my upcoming extent map cleaning series?

Well, the second paragraph needs to be updated to:

"We don't need this anymore as extent maps in the modified list of extents
are never merged with other extent maps and once we log an extent map we
remove it from the list of modified extent maps, so it's never logged twice=
."

Plus s/reduce/reduces/ in the last paragraph of the changelog.

Why does it need to be included in your series? Can't I just push this
to misc-next (with the updated changelog)?

I've also been working on a large patchset for extent maps for quite
some time, which I hope it's ready in 1 to 2 weeks.
Several refactorings and a shrinker.

What kind of cleanups do you have?


>
> Thanks,
> Qu
> > ---
> >   fs/btrfs/extent_map.c        | 18 ------------------
> >   fs/btrfs/extent_map.h        |  4 ----
> >   fs/btrfs/inode.c             |  4 +---
> >   fs/btrfs/tree-log.c          |  4 ++--
> >   include/trace/events/btrfs.h |  3 +--
> >   5 files changed, 4 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index 445f7716f1e2..471654cb65b0 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *t=
ree, struct extent_map *em)
> >                       em->len +=3D merge->len;
> >                       em->block_len +=3D merge->block_len;
> >                       em->block_start =3D merge->block_start;
> > -                     em->mod_len =3D (em->mod_len + em->mod_start) - m=
erge->mod_start;
> > -                     em->mod_start =3D merge->mod_start;
> >                       em->generation =3D max(em->generation, merge->gen=
eration);
> >                       em->flags |=3D EXTENT_FLAG_MERGED;
> >
> > @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *t=
ree, struct extent_map *em)
> >               em->block_len +=3D merge->block_len;
> >               rb_erase_cached(&merge->rb_node, &tree->map);
> >               RB_CLEAR_NODE(&merge->rb_node);
> > -             em->mod_len =3D (merge->mod_start + merge->mod_len) - em-=
>mod_start;
> >               em->generation =3D max(em->generation, merge->generation)=
;
> >               em->flags |=3D EXTENT_FLAG_MERGED;
> >               free_extent_map(merge);
> > @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, u=
64 start, u64 len, u64 gen)
> >       struct extent_map_tree *tree =3D &inode->extent_tree;
> >       int ret =3D 0;
> >       struct extent_map *em;
> > -     bool prealloc =3D false;
> >
> >       write_lock(&tree->lock);
> >       em =3D lookup_extent_mapping(tree, start, len);
> > @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, =
u64 start, u64 len, u64 gen)
> >
> >       em->generation =3D gen;
> >       em->flags &=3D ~EXTENT_FLAG_PINNED;
> > -     em->mod_start =3D em->start;
> > -     em->mod_len =3D em->len;
> > -
> > -     if (em->flags & EXTENT_FLAG_FILLING) {
> > -             prealloc =3D true;
> > -             em->flags &=3D ~EXTENT_FLAG_FILLING;
> > -     }
> >
> >       try_merge_map(tree, em);
> >
> > -     if (prealloc) {
> > -             em->mod_start =3D em->start;
> > -             em->mod_len =3D em->len;
> > -     }
> > -
> >   out:
> >       write_unlock(&tree->lock);
> >       free_extent_map(em);
> > @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct exte=
nt_map_tree *tree,
> >                                       int modified)
> >   {
> >       refcount_inc(&em->refs);
> > -     em->mod_start =3D em->start;
> > -     em->mod_len =3D em->len;
> >
> >       ASSERT(list_empty(&em->list));
> >
> > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > index c5a098c99cc6..10e9491865c9 100644
> > --- a/fs/btrfs/extent_map.h
> > +++ b/fs/btrfs/extent_map.h
> > @@ -30,8 +30,6 @@ enum {
> >       ENUM_BIT(EXTENT_FLAG_PREALLOC),
> >       /* Logging this extent */
> >       ENUM_BIT(EXTENT_FLAG_LOGGING),
> > -     /* Filling in a preallocated extent */
> > -     ENUM_BIT(EXTENT_FLAG_FILLING),
> >       /* This em is merged from two or more physically adjacent ems */
> >       ENUM_BIT(EXTENT_FLAG_MERGED),
> >   };
> > @@ -46,8 +44,6 @@ struct extent_map {
> >       /* all of these are in bytes */
> >       u64 start;
> >       u64 len;
> > -     u64 mod_start;
> > -     u64 mod_len;
> >       u64 orig_start;
> >       u64 orig_block_len;
> >       u64 ram_bytes;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 3442dedff53d..c6f2b5d1dee1 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
> >       em->ram_bytes =3D ram_bytes;
> >       em->generation =3D -1;
> >       em->flags |=3D EXTENT_FLAG_PINNED;
> > -     if (type =3D=3D BTRFS_ORDERED_PREALLOC)
> > -             em->flags |=3D EXTENT_FLAG_FILLING;
> > -     else if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> > +     if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> >               extent_map_set_compression(em, compress_type);
> >
> >       ret =3D btrfs_replace_extent_map_range(inode, em, true);
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 472918a5bc73..d9777649e170 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_ha=
ndle *trans,
> >       struct btrfs_root *csum_root;
> >       u64 csum_offset;
> >       u64 csum_len;
> > -     u64 mod_start =3D em->mod_start;
> > -     u64 mod_len =3D em->mod_len;
> > +     u64 mod_start =3D em->start;
> > +     u64 mod_len =3D em->len;
> >       LIST_HEAD(ordered_sums);
> >       int ret =3D 0;
> >
> > diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.=
h
> > index 90b0222390e5..766cfd48386c 100644
> > --- a/include/trace/events/btrfs.h
> > +++ b/include/trace/events/btrfs.h
> > @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
> >               { EXTENT_FLAG_COMPRESS_LZO,     "COMPRESS_LZO"  },\
> >               { EXTENT_FLAG_COMPRESS_ZSTD,    "COMPRESS_ZSTD" },\
> >               { EXTENT_FLAG_PREALLOC,         "PREALLOC"      },\
> > -             { EXTENT_FLAG_LOGGING,          "LOGGING"       },\
> > -             { EXTENT_FLAG_FILLING,          "FILLING"       })
> > +             { EXTENT_FLAG_LOGGING,          "LOGGING"       })
> >
> >   TRACE_EVENT_CONDITION(btrfs_get_extent,
> >

