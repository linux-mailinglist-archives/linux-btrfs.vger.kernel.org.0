Return-Path: <linux-btrfs+bounces-3868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E7896D7D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF3EB22610
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522C145B20;
	Wed,  3 Apr 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHY76g3A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C561411DA
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141759; cv=none; b=A8WoKFJRwbgN9/QgLWnKJTtPQ2MSHbV5cFfKQxidRRbwQsADle0qONv5IbsfygVaGw/Cf7/NmVkksXEHpJYUOV9QtxGNryb9bvldxY60dmHF79SdEiDFXg/K4Abu8piffyy0KOlpzPlt0yJ/ZKDK2GnaB7s1gmpFKoc8oqhoXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141759; c=relaxed/simple;
	bh=mvT8xiKS9qAAwred7yHtKYaSD4NIBlg4zQyOcId5mro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4HVRtjqBIHfDWT2fEei/9kZbxwnTLtlV5se9dXgWYG8GDGfx3eT0B7Eo2Khy0EyUz6OOB+JijJc+0AHBVO9aoR1bFixQlq3DXgIfzjeuradhr3++HzZAr9Lq9Fh/XDEUApzESuOjt9JljZvx/yL4Lq1l6iKKGGyYXXEharFEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHY76g3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7BCC43390
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141758;
	bh=mvT8xiKS9qAAwred7yHtKYaSD4NIBlg4zQyOcId5mro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SHY76g3AhO+/wvPeDI99aHqwrs3y/R6DB+RsjYDa9CPAVOVQyCyaTlwwd8pn9vA+L
	 7zmjTtFmOV6IYeBWfFJi9C/As1ELFRtS7VddlUAedgtWAoW9KW0mXFvCqFDJi4J3SI
	 4AL4NhzPJOmjjOH8cp7AJgEGzDA7Qgn8bvu6c3LGjCrI4g2oL+fNAwDOQfqkr1N+uI
	 u3P8pYEYikZsW+ACmtmAlLh0ehDo4QgSJFvQPYf4tjQq0EiuHoRGJlAmT2FmM+o+M/
	 KK6zJ1CTlQ+ik7fUBbdWdg9uwZKGK1C8xYlklv/AXhEcMijhYUvAoXS7tiMOwl511k
	 V5Xs0fnNorCZg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46a7208eedso807390266b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 03:55:58 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0KzNz8Eqfk6hangnwSXCl32PzH+MBwzEnC94uEZJkoxEygO/P
	RWccH0S1r9SAWU6hsUlsJm1UmLktEQN3XQG07cdaxplSZRs9xfJeCq994XuD00RuXHrldqmp+li
	oJo3bxXHAXFJjhY5VqixF4SEfi5s=
X-Google-Smtp-Source: AGHT+IH+3IK7ULu4yjGPTpijuiKun7pANfbE5luHHCRZ9Yni/TJTjrBRkIuXhFv60aj9kDGiCtfbnhRPm/hI1w9L56A=
X-Received: by 2002:a17:906:5592:b0:a47:3b21:161a with SMTP id
 y18-20020a170906559200b00a473b21161amr1532306ejp.37.1712141757060; Wed, 03
 Apr 2024 03:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b5929e96bbede278f63c68a149cb50645b094d6.1712074768.git.fdmanana@suse.com>
 <ddd3fbbc-612a-45b1-955b-bc938c4ddb7f@gmx.com> <CAL3q7H51p8nyusrAi6dbR3RR4YxtXBHxGUVALt+Xj2Z8EPvZjQ@mail.gmail.com>
 <000d9059-f896-429c-b69e-9b9910f6d421@gmx.com>
In-Reply-To: <000d9059-f896-429c-b69e-9b9910f6d421@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Apr 2024 10:55:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7AM5wkgL=d5+7ohh25Q787f89NGKP_FoZdLKVaftH7_w@mail.gmail.com>
Message-ID: <CAL3q7H7AM5wkgL=d5+7ohh25Q787f89NGKP_FoZdLKVaftH7_w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove not needed mod_start and mod_len from
 struct extent_map
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:53=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/3 08:13, Filipe Manana =E5=86=99=E9=81=93:
> > On Tue, Apr 2, 2024 at 10:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/4/3 03:10, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> The mod_start and mod_len fields of struct extent_map were introduced=
 by
> >>> commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that =
we
> >>> want") in order to avoid too low performance when fsyncing a file tha=
t
> >>> keeps getting extent maps merge, because it resulted in each fsync lo=
gging
> >>> again csum ranges that were already merged before.
> >>>
> >>> We don't need this anymore as extent maps in the modified list of ext=
ents
> >>> that get merged with other extents and once we log an extent map we r=
emove
> >>> it from the list of modified extent maps.
> >>>
> >>> So remove the mod_start and mod_len fields from struct extent_map and=
 use
> >>> instead the start and len fields when logging checksums in the fast f=
sync
> >>> path. This also makes EXTENT_FLAG_FILLING unused so remove it as well=
.
> >>>
> >>> Running the reproducer from the commit mentioned before, with a large=
r
> >>> number of extents and against a null block device, so that IO is fast
> >>> and we can better see any impact from searching checkums items and lo=
gging
> >>> them, gave the following results from dd:
> >>>
> >>> Before this change:
> >>>
> >>>      409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
> >>>
> >>> After this change:
> >>>
> >>>      409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
> >>>
> >>> So no changes in throughput.
> >>> The test was done in a release kernel (non-debug, Debian's default ke=
rnel
> >>> config) and its steps are the following:
> >>>
> >>>      $ mkfs.btrfs -f /dev/nullb0
> >>>      $ mount /dev/sdb /mnt
> >>>      $ dd if=3D/dev/zero of=3D/mnt/foobar bs=3D4k count=3D100000 ofla=
g=3Dsync
> >>>      $ umount /mnt
> >>>
> >>> This also reduce the size of struct extent_map from 128 bytes down to=
 112
> >>> bytes, so now we can have 36 extents maps per 4K page instead of 32.
> >>>
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Great we can start cleaning up the extent map members.
> >>
> >> Mind this patch to be included in my upcoming extent map cleaning seri=
es?
> >
> > Well, the second paragraph needs to be updated to:
> >
> > "We don't need this anymore as extent maps in the modified list of exte=
nts
> > are never merged with other extent maps and once we log an extent map w=
e
> > remove it from the list of modified extent maps, so it's never logged t=
wice."
> >
> > Plus s/reduce/reduces/ in the last paragraph of the changelog.
> >
> > Why does it need to be included in your series? Can't I just push this
> > to misc-next (with the updated changelog)?
> >
> > I've also been working on a large patchset for extent maps for quite
> > some time, which I hope it's ready in 1 to 2 weeks.
> > Several refactorings and a shrinker.
> >
> > What kind of cleanups do you have?
>
> My plan is to sync the em members with the file extent item members, so
> that there is no/less confusion on how to convert a file extent to
> extent map.
> Orig_start/block_start/block_len/orig_block_len to be replaced by
> disk_bytenr/disk_num_bytes/offset, and keep the old members which are
> already the more-or-less the same as the file extent items.
> (ram_bytes, start, len, generation)

Ok, I see. I'm not completely sure because orig_block_len is a max
value across splits.
It may work to always set it to block_len of the original extent that
was split, this is just from a quick look, so I may be wrong about it.

>
> Unfortunately this would result quite some name changes, and would
> definitely going to conflict with your changes.

That would be a huge change, touching lines everywhere due to member rename=
s.

>
> My bad as I'm not aware of your em work, I'm totally fine to wait for
> your patch and re-base my work then.

I'm not going to change anything in the extent_map structure itself,
but all major operations like adding/removing/replacing/merging/etc
are being changed,
mostly changing function parameters and updating a percpu counter, and
some tiny change for fsync to avoid races and data loss with the
shrinker itself.

So all potential conflicts are likely simple to resolve.

I pushed the patch to for-next with the fixed changelog.

Thanks.

>
> Thanks,
> Qu
>
> >
> >
> >>
> >> Thanks,
> >> Qu
> >>> ---
> >>>    fs/btrfs/extent_map.c        | 18 ------------------
> >>>    fs/btrfs/extent_map.h        |  4 ----
> >>>    fs/btrfs/inode.c             |  4 +---
> >>>    fs/btrfs/tree-log.c          |  4 ++--
> >>>    include/trace/events/btrfs.h |  3 +--
> >>>    5 files changed, 4 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> >>> index 445f7716f1e2..471654cb65b0 100644
> >>> --- a/fs/btrfs/extent_map.c
> >>> +++ b/fs/btrfs/extent_map.c
> >>> @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree =
*tree, struct extent_map *em)
> >>>                        em->len +=3D merge->len;
> >>>                        em->block_len +=3D merge->block_len;
> >>>                        em->block_start =3D merge->block_start;
> >>> -                     em->mod_len =3D (em->mod_len + em->mod_start) -=
 merge->mod_start;
> >>> -                     em->mod_start =3D merge->mod_start;
> >>>                        em->generation =3D max(em->generation, merge->=
generation);
> >>>                        em->flags |=3D EXTENT_FLAG_MERGED;
> >>>
> >>> @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree =
*tree, struct extent_map *em)
> >>>                em->block_len +=3D merge->block_len;
> >>>                rb_erase_cached(&merge->rb_node, &tree->map);
> >>>                RB_CLEAR_NODE(&merge->rb_node);
> >>> -             em->mod_len =3D (merge->mod_start + merge->mod_len) - e=
m->mod_start;
> >>>                em->generation =3D max(em->generation, merge->generati=
on);
> >>>                em->flags |=3D EXTENT_FLAG_MERGED;
> >>>                free_extent_map(merge);
> >>> @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode,=
 u64 start, u64 len, u64 gen)
> >>>        struct extent_map_tree *tree =3D &inode->extent_tree;
> >>>        int ret =3D 0;
> >>>        struct extent_map *em;
> >>> -     bool prealloc =3D false;
> >>>
> >>>        write_lock(&tree->lock);
> >>>        em =3D lookup_extent_mapping(tree, start, len);
> >>> @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode=
, u64 start, u64 len, u64 gen)
> >>>
> >>>        em->generation =3D gen;
> >>>        em->flags &=3D ~EXTENT_FLAG_PINNED;
> >>> -     em->mod_start =3D em->start;
> >>> -     em->mod_len =3D em->len;
> >>> -
> >>> -     if (em->flags & EXTENT_FLAG_FILLING) {
> >>> -             prealloc =3D true;
> >>> -             em->flags &=3D ~EXTENT_FLAG_FILLING;
> >>> -     }
> >>>
> >>>        try_merge_map(tree, em);
> >>>
> >>> -     if (prealloc) {
> >>> -             em->mod_start =3D em->start;
> >>> -             em->mod_len =3D em->len;
> >>> -     }
> >>> -
> >>>    out:
> >>>        write_unlock(&tree->lock);
> >>>        free_extent_map(em);
> >>> @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct ex=
tent_map_tree *tree,
> >>>                                        int modified)
> >>>    {
> >>>        refcount_inc(&em->refs);
> >>> -     em->mod_start =3D em->start;
> >>> -     em->mod_len =3D em->len;
> >>>
> >>>        ASSERT(list_empty(&em->list));
> >>>
> >>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> >>> index c5a098c99cc6..10e9491865c9 100644
> >>> --- a/fs/btrfs/extent_map.h
> >>> +++ b/fs/btrfs/extent_map.h
> >>> @@ -30,8 +30,6 @@ enum {
> >>>        ENUM_BIT(EXTENT_FLAG_PREALLOC),
> >>>        /* Logging this extent */
> >>>        ENUM_BIT(EXTENT_FLAG_LOGGING),
> >>> -     /* Filling in a preallocated extent */
> >>> -     ENUM_BIT(EXTENT_FLAG_FILLING),
> >>>        /* This em is merged from two or more physically adjacent ems =
*/
> >>>        ENUM_BIT(EXTENT_FLAG_MERGED),
> >>>    };
> >>> @@ -46,8 +44,6 @@ struct extent_map {
> >>>        /* all of these are in bytes */
> >>>        u64 start;
> >>>        u64 len;
> >>> -     u64 mod_start;
> >>> -     u64 mod_len;
> >>>        u64 orig_start;
> >>>        u64 orig_block_len;
> >>>        u64 ram_bytes;
> >>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >>> index 3442dedff53d..c6f2b5d1dee1 100644
> >>> --- a/fs/btrfs/inode.c
> >>> +++ b/fs/btrfs/inode.c
> >>> @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct b=
trfs_inode *inode, u64 start,
> >>>        em->ram_bytes =3D ram_bytes;
> >>>        em->generation =3D -1;
> >>>        em->flags |=3D EXTENT_FLAG_PINNED;
> >>> -     if (type =3D=3D BTRFS_ORDERED_PREALLOC)
> >>> -             em->flags |=3D EXTENT_FLAG_FILLING;
> >>> -     else if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> >>> +     if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> >>>                extent_map_set_compression(em, compress_type);
> >>>
> >>>        ret =3D btrfs_replace_extent_map_range(inode, em, true);
> >>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> >>> index 472918a5bc73..d9777649e170 100644
> >>> --- a/fs/btrfs/tree-log.c
> >>> +++ b/fs/btrfs/tree-log.c
> >>> @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_=
handle *trans,
> >>>        struct btrfs_root *csum_root;
> >>>        u64 csum_offset;
> >>>        u64 csum_len;
> >>> -     u64 mod_start =3D em->mod_start;
> >>> -     u64 mod_len =3D em->mod_len;
> >>> +     u64 mod_start =3D em->start;
> >>> +     u64 mod_len =3D em->len;
> >>>        LIST_HEAD(ordered_sums);
> >>>        int ret =3D 0;
> >>>
> >>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrf=
s.h
> >>> index 90b0222390e5..766cfd48386c 100644
> >>> --- a/include/trace/events/btrfs.h
> >>> +++ b/include/trace/events/btrfs.h
> >>> @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
> >>>                { EXTENT_FLAG_COMPRESS_LZO,     "COMPRESS_LZO"  },\
> >>>                { EXTENT_FLAG_COMPRESS_ZSTD,    "COMPRESS_ZSTD" },\
> >>>                { EXTENT_FLAG_PREALLOC,         "PREALLOC"      },\
> >>> -             { EXTENT_FLAG_LOGGING,          "LOGGING"       },\
> >>> -             { EXTENT_FLAG_FILLING,          "FILLING"       })
> >>> +             { EXTENT_FLAG_LOGGING,          "LOGGING"       })
> >>>
> >>>    TRACE_EVENT_CONDITION(btrfs_get_extent,
> >>>

