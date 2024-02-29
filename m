Return-Path: <linux-btrfs+bounces-2912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD686C7B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2012878D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27717A73A;
	Thu, 29 Feb 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="AZjmuzc6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1D3C697
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204846; cv=none; b=pBZydUOCgOXFrb+7UrvluONPgxRQ3aLOSKYSJIfzQSuYm7myA0vm2716szxruODKzN3T3VXqXPgJDw35Byge1BisAowTgPulZnwUgJ79pWHu7OvrKfn1/wSC/PTDWEABFkqnyC6vPXKxGy4T2trYf89HH1XiHQ6uKrvbIJd/W7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204846; c=relaxed/simple;
	bh=vcTToSzVcVtgqoupllPM0TuKSYMicaBk7mgH1ZhFlUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWjST8OZyydXQwEfBZU4q1RCQYU8MWvp3zZdEmXoWkSxPezNkAN5vgS2jiV2pTORCPaSYOMMPYuGrpS5RYPF7sF23Iw7SFhWpFw2DhJeZiy2PxH44xiB3ydzBmAYMB4HfotsxmEzCkXJIQ1oPfWad89AUowmxcYvrLuJsaDLiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=AZjmuzc6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso9159541fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 03:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1709204841; x=1709809641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6KmtjJ5NkKrIDpvSQBE2kRAY5kTdZmYDKdBCR9DD3Y=;
        b=AZjmuzc609btGBdtRKuweA8hnrvWaqrqLqWCOPuaFh3trH7f8pNdzNLuEMR8sWBuat
         E35lR0HLYx+APY384/MkJJwWzEOuXOfOrkThAJHGO/4pGJwpIggSnIkbBFuDmUJuLby3
         7jC+DDvW/EMzvcJ4nL0KqqSi7msM6l26CjLoXTfB4zQrmy2F7SGbvoHybaT9tXzPHeLI
         6uRlj8yG7r0VBDHSRj/eZKeJaHSTBCFwEof4tGbLk0+kbEbtgLDccNqC/FNDAMMk7LWA
         czyzdq1HxltE6/M2akRsLqh0Mz5w52rkqBBC4fBN7b5pmaD/pSrFAjHgQXSVlHxtPZzR
         Q4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709204841; x=1709809641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6KmtjJ5NkKrIDpvSQBE2kRAY5kTdZmYDKdBCR9DD3Y=;
        b=agGYCVtXJ31VtM3t6+4tSGurNZvkvQ6N1bO9GJYgM41zukFGjWI1HLred5emLEI/BT
         LKXskdEgOn2Aw0KAXMBEHVmsXpU0rDAK7T5d4VT+QBKPdCaBJN34R94AAE0glJExWhd3
         +wT313LE334ZKBFl1HHyRrXJGDEjLuWq+fVVhlVMv3wOSlYqLTltoywzmnEQUF6DftXq
         uVoPxcqctf6+TN4yWmzrwP1WzpLS32pmupOMJauGxn+PqSnXqDy7BSxyiE8F6N0QjQEq
         CJFp6dao8Ujq9MDdlh76zx34YY0WCBLTOAKhg3QYSBpjhoq+c7sBWrXHG9jUVrr9fJ3y
         x1sg==
X-Forwarded-Encrypted: i=1; AJvYcCXDcXL6R7Xkge1wsHa8vkuQ7YBvMXxbA0gtp69sOBRKFW8kjArxTs7rB+bSBmZYoeSqZ48SvMkNgKmj3umWyMlVJW6WsnAoWwZWAzY=
X-Gm-Message-State: AOJu0YzoTX+WqYvlBMNIN3jaXMd5j4NwylHvbZkGGfmtRu0LAtjMygBR
	52OmdEQs4YwEct0vtkOPOvDhn4E8UEervf+5MmMahFvxTCI8az+HyMkegyDkFCXEcbHro9bl1eR
	vdoa/UQERDwSXzLadklft+Jx1K5YbapbgdY+2U8b0d3BMDeWwBnI=
X-Google-Smtp-Source: AGHT+IEzLgKwEbH5GevYaYhdKBOVIrgNDLQDB8kvHgRoQYXm3r08ArVECSREn+f2VKoUFbv4c6Ku0SPQs89Mpz6HtHc=
X-Received: by 2002:a2e:95d3:0:b0:2d2:9573:dc52 with SMTP id
 y19-20020a2e95d3000000b002d29573dc52mr1064584ljh.2.1709204841453; Thu, 29 Feb
 2024 03:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20190327122418.24027-1-nborisov@suse.com> <20190327122418.24027-10-nborisov@suse.com>
 <CAOcd+r30e-f4R-5x-S7sV22RJPe7+pgwherA6xqN2_qe7o4XTg@mail.gmail.com> <CAL3q7H4-T7VmjdBE0FfOnfVMkem+AXp9q7JoX=YonAuCmx+cCg@mail.gmail.com>
In-Reply-To: <CAL3q7H4-T7VmjdBE0FfOnfVMkem+AXp9q7JoX=YonAuCmx+cCg@mail.gmail.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Thu, 29 Feb 2024 13:07:12 +0200
Message-ID: <CAOcd+r1wsf-xSskmcyugy_p2VEobNPzwBy8j23qA9sOm1=93Qw@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] btrfs: replace pending/pinned chunks lists with
 io tree
To: Filipe Manana <fdmanana@kernel.org>
Cc: Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org, 
	Jeff Mahoney <jeffm@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:55=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Thu, Feb 29, 2024 at 10:01=E2=80=AFAM Alex Lyakas <alex.lyakas@zadara.=
com> wrote:
> >
> > Hi Nikolay, Jeff,
> >
> >
> > On Wed, Mar 27, 2019 at 2:24=E2=80=AFPM Nikolay Borisov <nborisov@suse.=
com> wrote:
> > >
> > > From: Jeff Mahoney <jeffm@suse.com>
> > >
> > > The pending chunks list contains chunks that are allocated in the
> > > current transaction but haven't been created yet. The pinned chunks
> > > list contains chunks that are being released in the current transacti=
on.
> > > Both describe chunks that are not reflected on disk as in use but are
> > > unavailable just the same.
> > >
> > > The pending chunks list is anchored by the transaction handle, which
> > > means that we need to hold a reference to a transaction when working
> > > with the list.
> > >
> > > The way we use them is by iterating over both lists to perform
> > > comparisons on the stripes they describe for each device. This is
> > > backwards and requires that we keep a transaction handle open while
> > > we're trimming.
> > >
> > > This patchset adds an extent_io_tree to btrfs_device that maintains
> > > the allocation state of the device.  Extents are set dirty when
> > > chunks are first allocated -- when the extent maps are added to the
> > > mapping tree. They're cleared when last removed -- when the extent
> > > maps are removed from the mapping tree. This matches the lifespan
> > > of the pending and pinned chunks list and allows us to do trims
> > > on unallocated space safely without pinning the transaction for what
> > > may be a lengthy operation. We can also use this io tree to mark
> > > which chunks have already been trimmed so we don't repeat the operati=
on.
> > >
> > > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > > ---
> > >  fs/btrfs/ctree.h            |  6 ---
> > >  fs/btrfs/disk-io.c          | 11 -----
> > >  fs/btrfs/extent-tree.c      | 28 -----------
> > >  fs/btrfs/extent_map.c       | 35 ++++++++++++++
> > >  fs/btrfs/extent_map.h       |  1 -
> > >  fs/btrfs/free-space-cache.c |  4 --
> > >  fs/btrfs/transaction.c      |  9 ----
> > >  fs/btrfs/transaction.h      |  1 -
> > >  fs/btrfs/volumes.c          | 92 +++++++++++------------------------=
--
> > >  fs/btrfs/volumes.h          |  2 +
> > >  10 files changed, 65 insertions(+), 124 deletions(-)
> > >
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index 880b5abd8ecc..0b25c2f1b77d 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -1152,12 +1152,6 @@ struct btrfs_fs_info {
> > >         struct mutex unused_bg_unpin_mutex;
> > >         struct mutex delete_unused_bgs_mutex;
> > >
> > > -       /*
> > > -        * Chunks that can't be freed yet (under a trim/discard opera=
tion)
> > > -        * and will be latter freed. Protected by fs_info->chunk_mute=
x.
> > > -        */
> > > -       struct list_head pinned_chunks;
> > > -
> > >         /* Cached block sizes */
> > >         u32 nodesize;
> > >         u32 sectorsize;
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 79800311b8e1..c5900ade4094 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -2789,8 +2789,6 @@ int open_ctree(struct super_block *sb,
> > >         init_waitqueue_head(&fs_info->async_submit_wait);
> > >         init_waitqueue_head(&fs_info->delayed_iputs_wait);
> > >
> > > -       INIT_LIST_HEAD(&fs_info->pinned_chunks);
> > > -
> > >         /* Usable values until the real ones are cached from the supe=
rblock */
> > >         fs_info->nodesize =3D 4096;
> > >         fs_info->sectorsize =3D 4096;
> > > @@ -4065,15 +4063,6 @@ void close_ctree(struct btrfs_fs_info *fs_info=
)
> > >
> > >         btrfs_free_stripe_hash_table(fs_info);
> > >         btrfs_free_ref_cache(fs_info);
> > > -
> > > -       while (!list_empty(&fs_info->pinned_chunks)) {
> > > -               struct extent_map *em;
> > > -
> > > -               em =3D list_first_entry(&fs_info->pinned_chunks,
> > > -                                     struct extent_map, list);
> > > -               list_del_init(&em->list);
> > > -               free_extent_map(em);
> > > -       }
> > >  }
> > >
> > >  int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_tran=
sid,
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index dcda3c4de240..eb4b7f2b10a1 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -10946,10 +10946,6 @@ int btrfs_remove_block_group(struct btrfs_tr=
ans_handle *trans,
> > >         memcpy(&key, &block_group->key, sizeof(key));
> > >
> > >         mutex_lock(&fs_info->chunk_mutex);
> > > -       if (!list_empty(&em->list)) {
> > > -               /* We're in the transaction->pending_chunks list. */
> > > -               free_extent_map(em);
> > > -       }
> > >         spin_lock(&block_group->lock);
> > >         block_group->removed =3D 1;
> > >         /*
> > > @@ -10976,25 +10972,6 @@ int btrfs_remove_block_group(struct btrfs_tr=
ans_handle *trans,
> > >          * the transaction commit has completed.
> > >          */
> > >         remove_em =3D (atomic_read(&block_group->trimming) =3D=3D 0);
> > > -       /*
> > > -        * Make sure a trimmer task always sees the em in the pinned_=
chunks list
> > > -        * if it sees block_group->removed =3D=3D 1 (needs to lock bl=
ock_group->lock
> > > -        * before checking block_group->removed).
> > > -        */
> > > -       if (!remove_em) {
> > > -               /*
> > > -                * Our em might be in trans->transaction->pending_chu=
nks which
> > > -                * is protected by fs_info->chunk_mutex ([lock|unlock=
]_chunks),
> > > -                * and so is the fs_info->pinned_chunks list.
> > > -                *
> > > -                * So at this point we must be holding the chunk_mute=
x to avoid
> > > -                * any races with chunk allocation (more specifically=
 at
> > > -                * volumes.c:contains_pending_extent()), to ensure it=
 always
> > > -                * sees the em, either in the pending_chunks list or =
in the
> > > -                * pinned_chunks list.
> > > -                */
> > > -               list_move_tail(&em->list, &fs_info->pinned_chunks);
> > > -       }
> > >         spin_unlock(&block_group->lock);
> > >
> > >         if (remove_em) {
> > > @@ -11002,11 +10979,6 @@ int btrfs_remove_block_group(struct btrfs_tr=
ans_handle *trans,
> > >
> > >                 em_tree =3D &fs_info->mapping_tree.map_tree;
> > >                 write_lock(&em_tree->lock);
> > > -               /*
> > > -                * The em might be in the pending_chunks list, so mak=
e sure the
> > > -                * chunk mutex is locked, since remove_extent_mapping=
() will
> > > -                * delete us from that list.
> > > -                */
> > >                 remove_extent_mapping(em_tree, em);
> > >                 write_unlock(&em_tree->lock);
> > >                 /* once for the tree */
> > > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > > index 928f729c55ba..1b3c6dc5b458 100644
> > > --- a/fs/btrfs/extent_map.c
> > > +++ b/fs/btrfs/extent_map.c
> > > @@ -4,6 +4,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/spinlock.h>
> > >  #include "ctree.h"
> > > +#include "volumes.h"
> > >  #include "extent_map.h"
> > >  #include "compression.h"
> > >
> > > @@ -336,6 +337,36 @@ static inline void setup_extent_mapping(struct e=
xtent_map_tree *tree,
> > >         else
> > >                 try_merge_map(tree, em);
> > >  }
> > > +static void extent_map_device_set_bits(struct extent_map *em, unsign=
ed bits)
> > > +{
> > > +       struct map_lookup *map =3D em->map_lookup;
> > > +       u64 stripe_size =3D em->orig_block_len;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < map->num_stripes; i++) {
> > > +               struct btrfs_bio_stripe *stripe =3D &map->stripes[i];
> > > +               struct btrfs_device *device =3D stripe->dev;
> > > +
> > > +               set_extent_bits_nowait(&device->alloc_state, stripe->=
physical,
> > > +                                stripe->physical + stripe_size - 1, =
bits);
> > > +       }
> > > +}
> > > +
> > > +static void extent_map_device_clear_bits(struct extent_map *em, unsi=
gned bits)
> > > +{
> > > +       struct map_lookup *map =3D em->map_lookup;
> > > +       u64 stripe_size =3D em->orig_block_len;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < map->num_stripes; i++) {
> > > +               struct btrfs_bio_stripe *stripe =3D &map->stripes[i];
> > > +               struct btrfs_device *device =3D stripe->dev;
> > > +
> > > +               __clear_extent_bit(&device->alloc_state, stripe->phys=
ical,
> > > +                                  stripe->physical + stripe_size - 1=
, bits,
> > > +                                  0, 0, NULL, GFP_NOWAIT, NULL);
> > > +       }
> > > +}
> > >
> > >  /**
> > >   * add_extent_mapping - add new extent map to the extent tree
> > > @@ -357,6 +388,8 @@ int add_extent_mapping(struct extent_map_tree *tr=
ee,
> > >                 goto out;
> > >
> > >         setup_extent_mapping(tree, em, modified);
> > > +       if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
> > > +               extent_map_device_set_bits(em, CHUNK_ALLOCATED);
> > >  out:
> > >         return ret;
> > >  }
> > > @@ -438,6 +471,8 @@ void remove_extent_mapping(struct extent_map_tree=
 *tree, struct extent_map *em)
> > >         rb_erase_cached(&em->rb_node, &tree->map);
> > >         if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
> > >                 list_del_init(&em->list);
> > > +       if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
> > > +               extent_map_device_clear_bits(em, CHUNK_ALLOCATED);
> > >         RB_CLEAR_NODE(&em->rb_node);
> > >  }
> > >
> > > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > > index 473f039fcd7c..72b46833f236 100644
> > > --- a/fs/btrfs/extent_map.h
> > > +++ b/fs/btrfs/extent_map.h
> > > @@ -91,7 +91,6 @@ void replace_extent_mapping(struct extent_map_tree =
*tree,
> > >                             struct extent_map *cur,
> > >                             struct extent_map *new,
> > >                             int modified);
> > > -
> > >  struct extent_map *alloc_extent_map(void);
> > >  void free_extent_map(struct extent_map *em);
> > >  int __init extent_map_init(void);
> > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.=
c
> > > index 74aa552f4793..207fb50dcc7a 100644
> > > --- a/fs/btrfs/free-space-cache.c
> > > +++ b/fs/btrfs/free-space-cache.c
> > > @@ -3366,10 +3366,6 @@ void btrfs_put_block_group_trimming(struct btr=
fs_block_group_cache *block_group)
> > >                 em =3D lookup_extent_mapping(em_tree, block_group->ke=
y.objectid,
> > >                                            1);
> > >                 BUG_ON(!em); /* logic error, can't happen */
> > > -               /*
> > > -                * remove_extent_mapping() will delete us from the pi=
nned_chunks
> > > -                * list, which is protected by the chunk mutex.
> > > -                */
> > >                 remove_extent_mapping(em_tree, em);
> > >                 write_unlock(&em_tree->lock);
> > >                 mutex_unlock(&fs_info->chunk_mutex);
> > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > index b32769998bbb..e5404326fc55 100644
> > > --- a/fs/btrfs/transaction.c
> > > +++ b/fs/btrfs/transaction.c
> > > @@ -50,14 +50,6 @@ void btrfs_put_transaction(struct btrfs_transactio=
n *transaction)
> > >                         btrfs_err(transaction->fs_info,
> > >                                   "pending csums is %llu",
> > >                                   transaction->delayed_refs.pending_c=
sums);
> > > -               while (!list_empty(&transaction->pending_chunks)) {
> > > -                       struct extent_map *em;
> > > -
> > > -                       em =3D list_first_entry(&transaction->pending=
_chunks,
> > > -                                             struct extent_map, list=
);
> > > -                       list_del_init(&em->list);
> > > -                       free_extent_map(em);
> > > -               }
> > >                 /*
> > >                  * If any block groups are found in ->deleted_bgs the=
n it's
> > >                  * because the transaction was aborted and a commit d=
id not
> > > @@ -235,7 +227,6 @@ static noinline int join_transaction(struct btrfs=
_fs_info *fs_info,
> > >         spin_lock_init(&cur_trans->delayed_refs.lock);
> > >
> > >         INIT_LIST_HEAD(&cur_trans->pending_snapshots);
> > > -       INIT_LIST_HEAD(&cur_trans->pending_chunks);
> > >         INIT_LIST_HEAD(&cur_trans->dev_update_list);
> > >         INIT_LIST_HEAD(&cur_trans->switch_commits);
> > >         INIT_LIST_HEAD(&cur_trans->dirty_bgs);
> > > diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> > > index 2bd76f681520..4419a4a0294b 100644
> > > --- a/fs/btrfs/transaction.h
> > > +++ b/fs/btrfs/transaction.h
> > > @@ -51,7 +51,6 @@ struct btrfs_transaction {
> > >         wait_queue_head_t writer_wait;
> > >         wait_queue_head_t commit_wait;
> > >         struct list_head pending_snapshots;
> > > -       struct list_head pending_chunks;
> > >         struct list_head dev_update_list;
> > >         struct list_head switch_commits;
> > >         struct list_head dirty_bgs;
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 90eff8452c31..d240c07d4b2c 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -335,6 +335,7 @@ void btrfs_free_device(struct btrfs_device *devic=
e)
> > >  {
> > >         WARN_ON(!list_empty(&device->post_commit_list));
> > >         rcu_string_free(device->name);
> > > +       extent_io_tree_release(&device->alloc_state);
> > >         bio_put(device->flush_bio);
> > >         kfree(device);
> > >  }
> > > @@ -411,6 +412,7 @@ static struct btrfs_device *__alloc_device(void)
> > >         btrfs_device_data_ordered_init(dev);
> > >         INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_R=
ECLAIM);
> > >         INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT=
_RECLAIM);
> > > +       extent_io_tree_init(NULL, &dev->alloc_state, 0, NULL);
> > >
> > >         return dev;
> > >  }
> > > @@ -1498,58 +1500,29 @@ struct btrfs_device *btrfs_scan_one_device(co=
nst char *path, fmode_t flags,
> > >         return device;
> > >  }
> > >
> > > -static int contains_pending_extent(struct btrfs_transaction *transac=
tion,
> > > -                                  struct btrfs_device *device,
> > > -                                  u64 *start, u64 len)
> > > -{
> > > -       struct btrfs_fs_info *fs_info =3D device->fs_info;
> > > -       struct extent_map *em;
> > > -       struct list_head *search_list =3D &fs_info->pinned_chunks;
> > > -       int ret =3D 0;
> > > -       u64 physical_start =3D *start;
> > > -
> > > -       if (transaction)
> > > -               search_list =3D &transaction->pending_chunks;
> > > -again:
> > > -       list_for_each_entry(em, search_list, list) {
> > > -               struct map_lookup *map;
> > > -               int i;
> > > -
> > > -               map =3D em->map_lookup;
> > > -               for (i =3D 0; i < map->num_stripes; i++) {
> > > -                       u64 end;
> > > -
> > > -                       if (map->stripes[i].dev !=3D device)
> > > -                               continue;
> > > -                       if (map->stripes[i].physical >=3D physical_st=
art + len ||
> > > -                           map->stripes[i].physical + em->orig_block=
_len <=3D
> > > -                           physical_start)
> > > -                               continue;
> > > -                       /*
> > > -                        * Make sure that while processing the pinned=
 list we do
> > > -                        * not override our *start with a lower value=
, because
> > > -                        * we can have pinned chunks that fall within=
 this
> > > -                        * device hole and that have lower physical a=
ddresses
> > > -                        * than the pending chunks we processed befor=
e. If we
> > > -                        * do not take this special care we can end u=
p getting
> > > -                        * 2 pending chunks that start at the same ph=
ysical
> > > -                        * device offsets because the end offset of a=
 pinned
> > > -                        * chunk can be equal to the start offset of =
some
> > > -                        * pending chunk.
> > > -                        */
> > > -                       end =3D map->stripes[i].physical + em->orig_b=
lock_len;
> > > -                       if (end > *start) {
> > > -                               *start =3D end;
> > > -                               ret =3D 1;
> > > -                       }
> > > +/*
> > > + * Tries to find a chunk that intersects [start, start +len] range a=
nd when one
> > > + * such is found, records the end of it in *start
> > > + */
> > > +#define in_range(b, first, len)        ((b) >=3D (first) && (b) < (f=
irst) + (len))
> > > +static bool contains_pending_extent(struct btrfs_device *device, u64=
 *start,
> > > +                                   u64 len)
> > > +{
> > > +       u64 physical_start, physical_end;
> > > +       lockdep_assert_held(&device->fs_info->chunk_mutex);
> > > +
> > > +       if (!find_first_extent_bit(&device->alloc_state, *start,
> > > +                                  &physical_start, &physical_end,
> > > +                                  CHUNK_ALLOCATED, NULL)) {
> > > +
> > > +               if (in_range(physical_start, *start, len) ||
> > > +                   in_range(*start, physical_start,
> > > +                            physical_end - physical_start)) {
> > Shouldn't this be
> > "physical_end - physical_start + 1"
> > ?
> >
> > To my understanding physical_end indicates the last bytenr of the
> > range (i.e., inclusive), rather than the first bytenr outside the
> > range.
> > Can you please clarify?
>
> That's correct yes, I sent a fix for that:
>
> https://lore.kernel.org/linux-btrfs/daee5e8b14d706fe4dd96bd910fd460385128=
61b.1709203710.git.fdmanana@suse.com/
>
> Though in practice it shouldn't make a difference, as we never
> allocate 1 byte chunks or have 1 byte rages of unallocated space.
Thank you for confirming and addressing this. Based on your comments,
this will not get backported into stable. But at least my
understanding was correct.

Thanks,
Alex.


>
> Thanks.
>
> >
> > Thanks,
> > Alex.
> >
> >
> > > +                       *start =3D physical_end + 1;
> > > +                       return true;
> > >                 }
> > >         }
> > > -       if (search_list !=3D &fs_info->pinned_chunks) {
> > > -               search_list =3D &fs_info->pinned_chunks;
> > > -               goto again;
> > > -       }
> > > -
> > > -       return ret;
> > > +       return false;
> > >  }
> > >
> > >
> > > @@ -1660,15 +1633,12 @@ int find_free_dev_extent_start(struct btrfs_t=
ransaction *transaction,
> > >                          * Have to check before we set max_hole_start=
, otherwise
> > >                          * we could end up sending back this offset a=
nyway.
> > >                          */
> > > -                       if (contains_pending_extent(transaction, devi=
ce,
> > > -                                                   &search_start,
> > > +                       if (contains_pending_extent(device, &search_s=
tart,
> > >                                                     hole_size)) {
> > > -                               if (key.offset >=3D search_start) {
> > > +                               if (key.offset >=3D search_start)
> > >                                         hole_size =3D key.offset - se=
arch_start;
> > > -                               } else {
> > > -                                       WARN_ON_ONCE(1);
> > > +                               else
> > >                                         hole_size =3D 0;
> > > -                               }
> > >                         }
> > >
> > >                         if (hole_size > max_hole_size) {
> > > @@ -1709,8 +1679,7 @@ int find_free_dev_extent_start(struct btrfs_tra=
nsaction *transaction,
> > >         if (search_end > search_start) {
> > >                 hole_size =3D search_end - search_start;
> > >
> > > -               if (contains_pending_extent(transaction, device, &sea=
rch_start,
> > > -                                           hole_size)) {
> > > +               if (contains_pending_extent(device, &search_start, ho=
le_size)) {
> > >                         btrfs_release_path(path);
> > >                         goto again;
> > >                 }
> > > @@ -4758,7 +4727,7 @@ int btrfs_shrink_device(struct btrfs_device *de=
vice, u64 new_size)
> > >          * in-memory chunks are synced to disk so that the loop below=
 sees them
> > >          * and relocates them accordingly.
> > >          */
> > > -       if (contains_pending_extent(trans->transaction, device, &star=
t, diff)) {
> > > +       if (contains_pending_extent(device, &start, diff)) {
> > >                 mutex_unlock(&fs_info->chunk_mutex);
> > >                 ret =3D btrfs_commit_transaction(trans);
> > >                 if (ret)
> > > @@ -5200,9 +5169,6 @@ static int __btrfs_alloc_chunk(struct btrfs_tra=
ns_handle *trans,
> > >                 free_extent_map(em);
> > >                 goto error;
> > >         }
> > > -
> > > -       list_add_tail(&em->list, &trans->transaction->pending_chunks)=
;
> > > -       refcount_inc(&em->refs);
> > >         write_unlock(&em_tree->lock);
> > >
> > >         ret =3D btrfs_make_block_group(trans, 0, type, start, chunk_s=
ize);
> > > @@ -5235,8 +5201,6 @@ static int __btrfs_alloc_chunk(struct btrfs_tra=
ns_handle *trans,
> > >         free_extent_map(em);
> > >         /* One for the tree reference */
> > >         free_extent_map(em);
> > > -       /* One for the pending_chunks list reference */
> > > -       free_extent_map(em);
> > >  error:
> > >         kfree(devices_info);
> > >         return ret;
> > > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > > index 81784b68ca12..79901df4a157 100644
> > > --- a/fs/btrfs/volumes.h
> > > +++ b/fs/btrfs/volumes.h
> > > @@ -133,6 +133,8 @@ struct btrfs_device {
> > >         /* Counter to record the change of device stats */
> > >         atomic_t dev_stats_ccnt;
> > >         atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
> > > +
> > > +       struct extent_io_tree alloc_state;
> > >  };
> > >
> > >  /*
> > > --
> > > 2.17.1
> > >
> >

