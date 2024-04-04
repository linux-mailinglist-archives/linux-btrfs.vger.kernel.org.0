Return-Path: <linux-btrfs+bounces-3908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572B89847F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0902288DEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5B768E1;
	Thu,  4 Apr 2024 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR/r5GsN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220074C0D
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224723; cv=none; b=K0iQoeiCU7FCuOcZUXT6SMGOaIboz4CsK1CrdjGmQE+hiUa5OmtuGvqHCWTyVxds10qOCyveM4CcuSYKLMPNTM3kfk9zc5FTEjfcxUyRGjIN0WDa/ovcPMzPsJM/EH9drhThxSiOoMKaVbqOqWPIKFaT0kwkWLwDajYSoPDRtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224723; c=relaxed/simple;
	bh=gQ7Qxg/i2EHQLWUfXvC+W4enQBx1iPr8tMMVqerACy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7hrIOq9eHRHWh/ffKR9Pe8wQABT3oWuyfC/sXhme3QPgtL4EYg85DGEfndPjnpfLLTagkLF2UMyhEiZb/zec+rBx1/XLr7rhewSkfKHEnd40yxmQB8KV9FvAymtODg4la3qq7ABfDPka3rSZSxXypmMXnkVctzf1Gv5rLa2pJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR/r5GsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E83C433C7
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712224723;
	bh=gQ7Qxg/i2EHQLWUfXvC+W4enQBx1iPr8tMMVqerACy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sR/r5GsN4eo5ObBqIdgeNZyYF3NI79lMV5QvKtFPxdxH7/23tAIdoCSuy6YGuLTnr
	 I3W1xJiFG/ftWoqZbiNRhxDZMqzqH9Bnr76c/7y4UtRtqdm3zAOR4iuh2jOwf04RtT
	 lIitjHov7QVyNO9aq1/UQyK0yNt2UzZKE8pKqVCpxwdp8q3Y/DDPQBZrlfx4Ghc5Iu
	 vCdRG5Q3KatIJREOnquccAtdY4u37eQRAiC+BnloDCHKsH2CwHefJPHla5fMMMZBnq
	 HRRqnMninHYVtiBvKZqCUR+d/jpP7YViDUIhn8M9jGSRH/VX+/wocZJUjwrNGVFRyV
	 AMT2tEDEi26Lw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e39f5030dso109808866b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Apr 2024 02:58:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6Pcl8l9p0LhKZFi+6E4bnKZGOUfHWX3qkze9AFIGA45vnSrWn
	z91qewuVkSpa41UQemfYfGVRekb2QtP1qnXr/rqKRIwaxq5njduwdJTHkzcxFsoUgNWou1mkv5X
	MrTtsaNmUSX5xtb0B/LCUTMOUb5Y=
X-Google-Smtp-Source: AGHT+IGqvxKC7ABDFcIPG4TBvDszRJwf5Dx0wxLatv/yJpWyMByOf+/FyyQeq0Q7CLpifWK7azcpNi31DRKWXFzhIyY=
X-Received: by 2002:a17:906:b791:b0:a4a:850f:28fd with SMTP id
 dt17-20020a170906b79100b00a4a850f28fdmr1414065ejb.29.1712224721581; Thu, 04
 Apr 2024 02:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712187452.git.wqu@suse.com> <03bec7e0f57c902714e2c947fc6720d92c43e995.1712187452.git.wqu@suse.com>
In-Reply-To: <03bec7e0f57c902714e2c947fc6720d92c43e995.1712187452.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Apr 2024 10:58:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Do32YN-VV_JQG59vuJL-U-kkYvqLBi86MbYwJr1=iDA@mail.gmail.com>
Message-ID: <CAL3q7H6Do32YN-VV_JQG59vuJL-U-kkYvqLBi86MbYwJr1=iDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: remove not needed mod_start and mod_len
 from struct extent_map
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:46=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> The mod_start and mod_len fields of struct extent_map were introduced by
> commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that we
> want") in order to avoid too low performance when fsyncing a file that
> keeps getting extent maps merge, because it resulted in each fsync loggin=
g
> again csum ranges that were already merged before.
>
> We don't need this anymore as extent maps in the list of modified extents
> are never merged with other extent maps and once we log an extent map we
> remove it from the list of modified extent maps, so it's never logged
> twice.
>
> So remove the mod_start and mod_len fields from struct extent_map and use
> instead the start and len fields when logging checksums in the fast fsync
> path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.
>
> Running the reproducer from the commit mentioned before, with a larger
> number of extents and against a null block device, so that IO is fast
> and we can better see any impact from searching checksums items and
> logging them, gave the following results from dd:
>
> Before this change:
>
>    409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
>
> After this change:
>
>    409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
>
> So no changes in throughput.
> The test was done in a release kernel (non-debug, Debian's default kernel
> config) and its steps are the following:
>
>    $ mkfs.btrfs -f /dev/nullb0
>    $ mount /dev/sdb /mnt
>    $ dd if=3D/dev/zero of=3D/mnt/foobar bs=3D4k count=3D100000 oflag=3Dsy=
nc
>    $ umount /mnt
>
> This also reduces the size of struct extent_map from 128 bytes down to 11=
2
> bytes, so now we can have 36 extents maps per 4K page instead of 32.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Why are you resending this?
This was already in the for-next branch.

And given the SOB tag from David, your local for-next branch was up to date=
.

> ---
>  fs/btrfs/extent_map.c        | 18 ------------------
>  fs/btrfs/extent_map.h        |  4 ----
>  fs/btrfs/inode.c             |  4 +---
>  fs/btrfs/tree-log.c          |  4 ++--
>  include/trace/events/btrfs.h |  3 +--
>  5 files changed, 4 insertions(+), 29 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 445f7716f1e2..471654cb65b0 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *tre=
e, struct extent_map *em)
>                         em->len +=3D merge->len;
>                         em->block_len +=3D merge->block_len;
>                         em->block_start =3D merge->block_start;
> -                       em->mod_len =3D (em->mod_len + em->mod_start) - m=
erge->mod_start;
> -                       em->mod_start =3D merge->mod_start;
>                         em->generation =3D max(em->generation, merge->gen=
eration);
>                         em->flags |=3D EXTENT_FLAG_MERGED;
>
> @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *tre=
e, struct extent_map *em)
>                 em->block_len +=3D merge->block_len;
>                 rb_erase_cached(&merge->rb_node, &tree->map);
>                 RB_CLEAR_NODE(&merge->rb_node);
> -               em->mod_len =3D (merge->mod_start + merge->mod_len) - em-=
>mod_start;
>                 em->generation =3D max(em->generation, merge->generation)=
;
>                 em->flags |=3D EXTENT_FLAG_MERGED;
>                 free_extent_map(merge);
> @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64=
 start, u64 len, u64 gen)
>         struct extent_map_tree *tree =3D &inode->extent_tree;
>         int ret =3D 0;
>         struct extent_map *em;
> -       bool prealloc =3D false;
>
>         write_lock(&tree->lock);
>         em =3D lookup_extent_mapping(tree, start, len);
> @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 gen)
>
>         em->generation =3D gen;
>         em->flags &=3D ~EXTENT_FLAG_PINNED;
> -       em->mod_start =3D em->start;
> -       em->mod_len =3D em->len;
> -
> -       if (em->flags & EXTENT_FLAG_FILLING) {
> -               prealloc =3D true;
> -               em->flags &=3D ~EXTENT_FLAG_FILLING;
> -       }
>
>         try_merge_map(tree, em);
>
> -       if (prealloc) {
> -               em->mod_start =3D em->start;
> -               em->mod_len =3D em->len;
> -       }
> -
>  out:
>         write_unlock(&tree->lock);
>         free_extent_map(em);
> @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct extent=
_map_tree *tree,
>                                         int modified)
>  {
>         refcount_inc(&em->refs);
> -       em->mod_start =3D em->start;
> -       em->mod_len =3D em->len;
>
>         ASSERT(list_empty(&em->list));
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index c5a098c99cc6..10e9491865c9 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -30,8 +30,6 @@ enum {
>         ENUM_BIT(EXTENT_FLAG_PREALLOC),
>         /* Logging this extent */
>         ENUM_BIT(EXTENT_FLAG_LOGGING),
> -       /* Filling in a preallocated extent */
> -       ENUM_BIT(EXTENT_FLAG_FILLING),
>         /* This em is merged from two or more physically adjacent ems */
>         ENUM_BIT(EXTENT_FLAG_MERGED),
>  };
> @@ -46,8 +44,6 @@ struct extent_map {
>         /* all of these are in bytes */
>         u64 start;
>         u64 len;
> -       u64 mod_start;
> -       u64 mod_len;
>         u64 orig_start;
>         u64 orig_block_len;
>         u64 ram_bytes;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3442dedff53d..c6f2b5d1dee1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>         em->ram_bytes =3D ram_bytes;
>         em->generation =3D -1;
>         em->flags |=3D EXTENT_FLAG_PINNED;
> -       if (type =3D=3D BTRFS_ORDERED_PREALLOC)
> -               em->flags |=3D EXTENT_FLAG_FILLING;
> -       else if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> +       if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>                 extent_map_set_compression(em, compress_type);
>
>         ret =3D btrfs_replace_extent_map_range(inode, em, true);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 472918a5bc73..d9777649e170 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_hand=
le *trans,
>         struct btrfs_root *csum_root;
>         u64 csum_offset;
>         u64 csum_len;
> -       u64 mod_start =3D em->mod_start;
> -       u64 mod_len =3D em->mod_len;
> +       u64 mod_start =3D em->start;
> +       u64 mod_len =3D em->len;
>         LIST_HEAD(ordered_sums);
>         int ret =3D 0;
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 90b0222390e5..766cfd48386c 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
>                 { EXTENT_FLAG_COMPRESS_LZO,     "COMPRESS_LZO"  },\
>                 { EXTENT_FLAG_COMPRESS_ZSTD,    "COMPRESS_ZSTD" },\
>                 { EXTENT_FLAG_PREALLOC,         "PREALLOC"      },\
> -               { EXTENT_FLAG_LOGGING,          "LOGGING"       },\
> -               { EXTENT_FLAG_FILLING,          "FILLING"       })
> +               { EXTENT_FLAG_LOGGING,          "LOGGING"       })
>
>  TRACE_EVENT_CONDITION(btrfs_get_extent,
>
> --
> 2.44.0
>
>

