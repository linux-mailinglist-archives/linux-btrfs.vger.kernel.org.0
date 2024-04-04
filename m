Return-Path: <linux-btrfs+bounces-3913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FAD89852D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4335E1F25578
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD17EF09;
	Thu,  4 Apr 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1nGA+FJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55F1C6B8
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227115; cv=none; b=X1z8+UiWzeunr8uS19yvVmXWywtURvU/yTyfA7fv96qTcL3Q/mRQ8Xj0j1dwH88dFsWYa1w0dYmjAuUjwwTGp3LazMXg/Zclk5lqWJOaS3Um2bC8QqvXYFPKzAU/YwdDw0YlauxYIsmTn15MxDNSu+6uwLkXegBIs26Vx2aWDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227115; c=relaxed/simple;
	bh=uFLT82miGRppxjSl+XFMIygr5pOq/s5dqrPXgPoCmPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsvfKYV1iSHEoNuysDw82s3CciHXD8EShVlzaORjuqnG5gvQf+/okWRyvlvrjtZXsJ2fTsZ9gWYY+gFP8cdiM8oOAvYS44VsNTfca1SInxF+JBs7ED4dJmVzBaVy10MGAnlFUMsHoCftjgAiVOKH2/Q6zzzX715IakFHR+nMUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1nGA+FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F45C433F1
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712227115;
	bh=uFLT82miGRppxjSl+XFMIygr5pOq/s5dqrPXgPoCmPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1nGA+FJmHFru+z3VRIyXuW0XYTdWwiOBy4Zs7OlOvpLJqiUu8T/ycy15Ulsob30B
	 TDInnLoTYP1IAKxvepNIp5FgpR14Xn7U5MZtpobdeBF9jJt3rklzf6dsYLS7mvxHkq
	 C5ajQPtK3oKDhVb4RXh1z9twsL/QOfoc5d0hzAxtpeuMWZ7YQrXBl2cFf54PYdYNR1
	 eiuAf32VZXJwnKJ4dcbwC/ngnecB5IKeUb6OpZEf9r58PkkqL5HHqQdkPStSVcxBsZ
	 ZIgKcK9HIYM/S89xigmc0/xo8HwrIci6FXidyMrPZfT4G4eAB4a00rghU2xlMUSzbR
	 geBUQLWkuI0ng==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4a393b699fso133027566b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Apr 2024 03:38:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YxewsEQyB6qbP7L89UaMYnzaA3YvwOUOmJkhokiTH65Uc/zVWGb
	y9rWilCqoEzHlvHmmX/y62IJx4mfkyKTcS4///RR4LbpGKNEvXy11/C1k1fb2EakdHqF7jQnMeZ
	8Jr5YDofCSICsO7vm8ohqO7m/nag=
X-Google-Smtp-Source: AGHT+IHKoNbvw6r+KiNogtsh3hpmn67fk9GUKvReb3ueEo4inOzyrnSd1qWE25JeEVPj3F6ZsmAVXkzxuFQ9Cu1VTYs=
X-Received: by 2002:a17:906:34d6:b0:a51:9641:8dcd with SMTP id
 h22-20020a17090634d600b00a5196418dcdmr59254ejb.31.1712227113659; Thu, 04 Apr
 2024 03:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712187452.git.wqu@suse.com> <03bec7e0f57c902714e2c947fc6720d92c43e995.1712187452.git.wqu@suse.com>
 <CAL3q7H6Do32YN-VV_JQG59vuJL-U-kkYvqLBi86MbYwJr1=iDA@mail.gmail.com> <6c326f9c-2a6f-475a-8329-2d6840be1ba6@suse.com>
In-Reply-To: <6c326f9c-2a6f-475a-8329-2d6840be1ba6@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Apr 2024 11:37:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6nse8GPLQcX+69U0_=jWrwhnD88HUGRUr_GK7m+Z1PoA@mail.gmail.com>
Message-ID: <CAL3q7H6nse8GPLQcX+69U0_=jWrwhnD88HUGRUr_GK7m+Z1PoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: remove not needed mod_start and mod_len
 from struct extent_map
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:23=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/4/4 20:28, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Apr 4, 2024 at 12:46=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> The mod_start and mod_len fields of struct extent_map were introduced =
by
> >> commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that w=
e
> >> want") in order to avoid too low performance when fsyncing a file that
> >> keeps getting extent maps merge, because it resulted in each fsync log=
ging
> >> again csum ranges that were already merged before.
> >>
> >> We don't need this anymore as extent maps in the list of modified exte=
nts
> >> are never merged with other extent maps and once we log an extent map =
we
> >> remove it from the list of modified extent maps, so it's never logged
> >> twice.
> >>
> >> So remove the mod_start and mod_len fields from struct extent_map and =
use
> >> instead the start and len fields when logging checksums in the fast fs=
ync
> >> path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.
> >>
> >> Running the reproducer from the commit mentioned before, with a larger
> >> number of extents and against a null block device, so that IO is fast
> >> and we can better see any impact from searching checksums items and
> >> logging them, gave the following results from dd:
> >>
> >> Before this change:
> >>
> >>     409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
> >>
> >> After this change:
> >>
> >>     409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
> >>
> >> So no changes in throughput.
> >> The test was done in a release kernel (non-debug, Debian's default ker=
nel
> >> config) and its steps are the following:
> >>
> >>     $ mkfs.btrfs -f /dev/nullb0
> >>     $ mount /dev/sdb /mnt
> >>     $ dd if=3D/dev/zero of=3D/mnt/foobar bs=3D4k count=3D100000 oflag=
=3Dsync
> >>     $ umount /mnt
> >>
> >> This also reduces the size of struct extent_map from 128 bytes down to=
 112
> >> bytes, so now we can have 36 extents maps per 4K page instead of 32.
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >> Signed-off-by: David Sterba <dsterba@suse.com>
> >
> > Why are you resending this?
> > This was already in the for-next branch.
> >
> > And given the SOB tag from David, your local for-next branch was up to =
date.
>
> Sorry, I still didn't really get how the whole btrfs/for-next branch
> should work.

You use it like you used misc-next.
In this case it seems you were using it already, given David's SOB tag
and the amended changelog.

>
> Should all our patches based on the latest for-next? Since every member
> has write permission to the branch, and the branch can change in a daily
> base, rebasing it daily doesn't look solid to me.

What's the problem? misc-next could also be updated at any time.
It's the same here, and it's not like for-next is updated that often
anyway - we aren't that many and patches are only merged after review.

>
> And I still do not know what's the requirement to push a patch into
> misc-next.

This has been mentioned on slack and there's even some document in
workflow repo IIRC.
A patch needs one review at least (2+ if it's a new feature).

> Like just after fstests runs? Reviewed-by tag? or both or something more?

Ideally after running fstests, but I don't think everyone can afford
that and we also have the github CI tests that run after updating
for-next.

>
> Thanks,
> Qu
> >
> >> ---
> >>   fs/btrfs/extent_map.c        | 18 ------------------
> >>   fs/btrfs/extent_map.h        |  4 ----
> >>   fs/btrfs/inode.c             |  4 +---
> >>   fs/btrfs/tree-log.c          |  4 ++--
> >>   include/trace/events/btrfs.h |  3 +--
> >>   5 files changed, 4 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> >> index 445f7716f1e2..471654cb65b0 100644
> >> --- a/fs/btrfs/extent_map.c
> >> +++ b/fs/btrfs/extent_map.c
> >> @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *=
tree, struct extent_map *em)
> >>                          em->len +=3D merge->len;
> >>                          em->block_len +=3D merge->block_len;
> >>                          em->block_start =3D merge->block_start;
> >> -                       em->mod_len =3D (em->mod_len + em->mod_start) =
- merge->mod_start;
> >> -                       em->mod_start =3D merge->mod_start;
> >>                          em->generation =3D max(em->generation, merge-=
>generation);
> >>                          em->flags |=3D EXTENT_FLAG_MERGED;
> >>
> >> @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *=
tree, struct extent_map *em)
> >>                  em->block_len +=3D merge->block_len;
> >>                  rb_erase_cached(&merge->rb_node, &tree->map);
> >>                  RB_CLEAR_NODE(&merge->rb_node);
> >> -               em->mod_len =3D (merge->mod_start + merge->mod_len) - =
em->mod_start;
> >>                  em->generation =3D max(em->generation, merge->generat=
ion);
> >>                  em->flags |=3D EXTENT_FLAG_MERGED;
> >>                  free_extent_map(merge);
> >> @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, =
u64 start, u64 len, u64 gen)
> >>          struct extent_map_tree *tree =3D &inode->extent_tree;
> >>          int ret =3D 0;
> >>          struct extent_map *em;
> >> -       bool prealloc =3D false;
> >>
> >>          write_lock(&tree->lock);
> >>          em =3D lookup_extent_mapping(tree, start, len);
> >> @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode,=
 u64 start, u64 len, u64 gen)
> >>
> >>          em->generation =3D gen;
> >>          em->flags &=3D ~EXTENT_FLAG_PINNED;
> >> -       em->mod_start =3D em->start;
> >> -       em->mod_len =3D em->len;
> >> -
> >> -       if (em->flags & EXTENT_FLAG_FILLING) {
> >> -               prealloc =3D true;
> >> -               em->flags &=3D ~EXTENT_FLAG_FILLING;
> >> -       }
> >>
> >>          try_merge_map(tree, em);
> >>
> >> -       if (prealloc) {
> >> -               em->mod_start =3D em->start;
> >> -               em->mod_len =3D em->len;
> >> -       }
> >> -
> >>   out:
> >>          write_unlock(&tree->lock);
> >>          free_extent_map(em);
> >> @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct ext=
ent_map_tree *tree,
> >>                                          int modified)
> >>   {
> >>          refcount_inc(&em->refs);
> >> -       em->mod_start =3D em->start;
> >> -       em->mod_len =3D em->len;
> >>
> >>          ASSERT(list_empty(&em->list));
> >>
> >> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> >> index c5a098c99cc6..10e9491865c9 100644
> >> --- a/fs/btrfs/extent_map.h
> >> +++ b/fs/btrfs/extent_map.h
> >> @@ -30,8 +30,6 @@ enum {
> >>          ENUM_BIT(EXTENT_FLAG_PREALLOC),
> >>          /* Logging this extent */
> >>          ENUM_BIT(EXTENT_FLAG_LOGGING),
> >> -       /* Filling in a preallocated extent */
> >> -       ENUM_BIT(EXTENT_FLAG_FILLING),
> >>          /* This em is merged from two or more physically adjacent ems=
 */
> >>          ENUM_BIT(EXTENT_FLAG_MERGED),
> >>   };
> >> @@ -46,8 +44,6 @@ struct extent_map {
> >>          /* all of these are in bytes */
> >>          u64 start;
> >>          u64 len;
> >> -       u64 mod_start;
> >> -       u64 mod_len;
> >>          u64 orig_start;
> >>          u64 orig_block_len;
> >>          u64 ram_bytes;
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 3442dedff53d..c6f2b5d1dee1 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct bt=
rfs_inode *inode, u64 start,
> >>          em->ram_bytes =3D ram_bytes;
> >>          em->generation =3D -1;
> >>          em->flags |=3D EXTENT_FLAG_PINNED;
> >> -       if (type =3D=3D BTRFS_ORDERED_PREALLOC)
> >> -               em->flags |=3D EXTENT_FLAG_FILLING;
> >> -       else if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> >> +       if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> >>                  extent_map_set_compression(em, compress_type);
> >>
> >>          ret =3D btrfs_replace_extent_map_range(inode, em, true);
> >> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> >> index 472918a5bc73..d9777649e170 100644
> >> --- a/fs/btrfs/tree-log.c
> >> +++ b/fs/btrfs/tree-log.c
> >> @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_h=
andle *trans,
> >>          struct btrfs_root *csum_root;
> >>          u64 csum_offset;
> >>          u64 csum_len;
> >> -       u64 mod_start =3D em->mod_start;
> >> -       u64 mod_len =3D em->mod_len;
> >> +       u64 mod_start =3D em->start;
> >> +       u64 mod_len =3D em->len;
> >>          LIST_HEAD(ordered_sums);
> >>          int ret =3D 0;
> >>
> >> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs=
.h
> >> index 90b0222390e5..766cfd48386c 100644
> >> --- a/include/trace/events/btrfs.h
> >> +++ b/include/trace/events/btrfs.h
> >> @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
> >>                  { EXTENT_FLAG_COMPRESS_LZO,     "COMPRESS_LZO"  },\
> >>                  { EXTENT_FLAG_COMPRESS_ZSTD,    "COMPRESS_ZSTD" },\
> >>                  { EXTENT_FLAG_PREALLOC,         "PREALLOC"      },\
> >> -               { EXTENT_FLAG_LOGGING,          "LOGGING"       },\
> >> -               { EXTENT_FLAG_FILLING,          "FILLING"       })
> >> +               { EXTENT_FLAG_LOGGING,          "LOGGING"       })
> >>
> >>   TRACE_EVENT_CONDITION(btrfs_get_extent,
> >>
> >> --
> >> 2.44.0
> >>
> >>

