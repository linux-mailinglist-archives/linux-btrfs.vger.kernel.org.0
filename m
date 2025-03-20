Return-Path: <linux-btrfs+bounces-12470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DCA6AE1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DBE189E290
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 19:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B422C32D;
	Thu, 20 Mar 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="IlsVxs3A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4422A4F6
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497267; cv=none; b=kO0MdVqhbOK4L8G3R4w1vbX9B1xugx+GjlvZfZ4stWja9fJ91Ob0GPNl7iWo7K61Nms3N52tYAk8b0ZFRSmn+mEVBTMyO/eGxt0s5xxcpo4OWX/GY9sosvLSCfXkKhnBh8W6WWLCcEsja+l4lqJL0EryGZF3eW4C9w6DRwqDAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497267; c=relaxed/simple;
	bh=F+c4BAP6GxxoQ+LU37j4ueQxeB8QVp8a0TW8aAN9bfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9HNHXPIU/24RUXI6h3WwKJyfo4tJkuSjOpBxo/R+O0/2PjvzS3J5RuqtF6fgEVgC3t3KLEoRKyJjG0GJZmHP9QsEgLGA8038MZ/uITjDRqNLGq16Uy1Uv+I8SLbfJ9ePqNxjKzlxGA4YSGhfSG5yMQIc/ORpkCDWPJ9jN3SqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=IlsVxs3A; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301493f461eso1468429a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1742497262; x=1743102062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbvoAE8G1QAIjW1MHgiNJBHTivYSNI1GHJ6AcOwbvcs=;
        b=IlsVxs3A3F4goqQfBykyEBzVcprWhQNjVKTcfp/St8E9ORlrtLV0sPVcuIhgCODD4P
         Or65jTJZbQcXnxsaWq+H0ics54e2DQElSttcJsEuY2TYuQy5GrxMde8CieXQwDnLqD15
         qrw1qYcblCZMPRCDXoqM325zy1iL+9qQ3W5S4Ww1ty9h1+52KCA61PShQGymjj3ok0Lk
         Crr+bg2M9nHyeID5qHldZ0A6HBKq66jd2/bj3mXGEuzW0pxxlxp+Vo1Nz4QHO5WuAF3D
         12eny9Iyak0xOw4EAZPxSZEvtk0I26W2otHzRyfTCJCJQqCg9eaZUXPCu2p9mIoP0lH1
         yvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497262; x=1743102062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbvoAE8G1QAIjW1MHgiNJBHTivYSNI1GHJ6AcOwbvcs=;
        b=jV519JxWlZ+tS/sDUqszzrl2VEclrf0URHPwrcYYvBVGtP9LiRxOCKA+Q3umPJ/RBw
         +TUlAwSDxb+BBMBjilwQEP4wavXQrcZT86RDff1M5m0clfEhkyLglLK2j7dUJr/y2Jqh
         BL3xcMRlyj0As6U2oA0VBYx2rVxKZCPMEAr7026IRlEY1e3OtHpUTS6/8JWTMiGBI1Wf
         Drd25lPT9Z4Vw4qVIDGcplA2XD9bDADXr8A0laE572oxOJ0D8LZa//Uxn1uZiUF6O0Ig
         kZVeEMpHw9YMZLV0TKALZN9MUgQoAFWAkcNM17Davw/i3elc1m9eHD63hbuOZ1Q5Go6q
         KhjQ==
X-Gm-Message-State: AOJu0YznBquU8DYIA1habqPFHws30f0Jnewoy0Bj9yFykm9TqLiyNdbO
	/HHdT22AkWQj/RzSJxLxG6/H+RYFyZu0Xso4UWJxinMzeaDwVX+jMrjDddXbXR4IXM1QB/cMeY0
	hzhtEhm/iSSijwfqys0AnvlXPDx+bvrGscpq7qJW8K06+uDV2CNY=
X-Gm-Gg: ASbGnctfTJKpjUBcxoCVibuq8qApOUCcE5vrwqPxc3fjcv1IHumvPb2dOOAm9wHDaQl
	OKGC+gby7VZKa0FlUEFjghv3NygIh19VbtTHFzW2jtPNQZiuzWY8OM/YP2zkGWZAPS/sslATg0r
	bcXpe+6KOC+y161OpHaHKELzCGcw==
X-Google-Smtp-Source: AGHT+IG341cmAth1NddmSywj5oMudtH/Ka4szwTtKYPa4B3dE1VyVStUapPASVEgG4hl+Tqz1JdebvX/DipOQVt3KPk=
X-Received: by 2002:a17:90b:4a4a:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-3030fe95a80mr538292a91.14.1742497261664; Thu, 20 Mar 2025
 12:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20190327122418.24027-1-nborisov@suse.com> <20190327122418.24027-10-nborisov@suse.com>
In-Reply-To: <20190327122418.24027-10-nborisov@suse.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Thu, 20 Mar 2025 21:00:50 +0200
X-Gm-Features: AQ5f1Jrq-QasS0RreVCvK9lKslK9k8zQwXSnBJYtRF_DCEIGWK679Kx3aRVSYB0
Message-ID: <CAOcd+r1zNPLrsBQE7ooyo87yqnG0fiM+4kbuHR+MGWQZTSL4yg@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] btrfs: replace pending/pinned chunks lists with
 io tree
To: Nikolay Borisov <nborisov@suse.com>, Jeff Mahoney <jeffm@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nikolay, Jeff,


On Wed, Mar 27, 2019 at 2:24=E2=80=AFPM Nikolay Borisov <nborisov@suse.com>=
 wrote:
>
> From: Jeff Mahoney <jeffm@suse.com>
>
> The pending chunks list contains chunks that are allocated in the
> current transaction but haven't been created yet. The pinned chunks
> list contains chunks that are being released in the current transaction.
> Both describe chunks that are not reflected on disk as in use but are
> unavailable just the same.
>
> The pending chunks list is anchored by the transaction handle, which
> means that we need to hold a reference to a transaction when working
> with the list.
>
> The way we use them is by iterating over both lists to perform
> comparisons on the stripes they describe for each device. This is
> backwards and requires that we keep a transaction handle open while
> we're trimming.
>
> This patchset adds an extent_io_tree to btrfs_device that maintains
> the allocation state of the device.  Extents are set dirty when
> chunks are first allocated -- when the extent maps are added to the
> mapping tree. They're cleared when last removed -- when the extent
> maps are removed from the mapping tree. This matches the lifespan
> of the pending and pinned chunks list and allows us to do trims
I am a bit confused by this.
The lifespan of pending/pinned chunks was at most one transaction. But
now the lifespan in the mapping tree is as long as the block-group
exists. So it's much broader lifespan. So now every device tracks all
its extents in memory until unmount. Is this intended? Is my
understanding correct?

Thanks,
Alex.

> on unallocated space safely without pinning the transaction for what
> may be a lengthy operation. We can also use this io tree to mark
> which chunks have already been trimmed so we don't repeat the operation.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h            |  6 ---
>  fs/btrfs/disk-io.c          | 11 -----
>  fs/btrfs/extent-tree.c      | 28 -----------
>  fs/btrfs/extent_map.c       | 35 ++++++++++++++
>  fs/btrfs/extent_map.h       |  1 -
>  fs/btrfs/free-space-cache.c |  4 --
>  fs/btrfs/transaction.c      |  9 ----
>  fs/btrfs/transaction.h      |  1 -
>  fs/btrfs/volumes.c          | 92 +++++++++++--------------------------
>  fs/btrfs/volumes.h          |  2 +
>  10 files changed, 65 insertions(+), 124 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 880b5abd8ecc..0b25c2f1b77d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1152,12 +1152,6 @@ struct btrfs_fs_info {
>         struct mutex unused_bg_unpin_mutex;
>         struct mutex delete_unused_bgs_mutex;
>
> -       /*
> -        * Chunks that can't be freed yet (under a trim/discard operation=
)
> -        * and will be latter freed. Protected by fs_info->chunk_mutex.
> -        */
> -       struct list_head pinned_chunks;
> -
>         /* Cached block sizes */
>         u32 nodesize;
>         u32 sectorsize;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 79800311b8e1..c5900ade4094 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2789,8 +2789,6 @@ int open_ctree(struct super_block *sb,
>         init_waitqueue_head(&fs_info->async_submit_wait);
>         init_waitqueue_head(&fs_info->delayed_iputs_wait);
>
> -       INIT_LIST_HEAD(&fs_info->pinned_chunks);
> -
>         /* Usable values until the real ones are cached from the superblo=
ck */
>         fs_info->nodesize =3D 4096;
>         fs_info->sectorsize =3D 4096;
> @@ -4065,15 +4063,6 @@ void close_ctree(struct btrfs_fs_info *fs_info)
>
>         btrfs_free_stripe_hash_table(fs_info);
>         btrfs_free_ref_cache(fs_info);
> -
> -       while (!list_empty(&fs_info->pinned_chunks)) {
> -               struct extent_map *em;
> -
> -               em =3D list_first_entry(&fs_info->pinned_chunks,
> -                                     struct extent_map, list);
> -               list_del_init(&em->list);
> -               free_extent_map(em);
> -       }
>  }
>
>  int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index dcda3c4de240..eb4b7f2b10a1 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -10946,10 +10946,6 @@ int btrfs_remove_block_group(struct btrfs_trans_=
handle *trans,
>         memcpy(&key, &block_group->key, sizeof(key));
>
>         mutex_lock(&fs_info->chunk_mutex);
> -       if (!list_empty(&em->list)) {
> -               /* We're in the transaction->pending_chunks list. */
> -               free_extent_map(em);
> -       }
>         spin_lock(&block_group->lock);
>         block_group->removed =3D 1;
>         /*
> @@ -10976,25 +10972,6 @@ int btrfs_remove_block_group(struct btrfs_trans_=
handle *trans,
>          * the transaction commit has completed.
>          */
>         remove_em =3D (atomic_read(&block_group->trimming) =3D=3D 0);
> -       /*
> -        * Make sure a trimmer task always sees the em in the pinned_chun=
ks list
> -        * if it sees block_group->removed =3D=3D 1 (needs to lock block_=
group->lock
> -        * before checking block_group->removed).
> -        */
> -       if (!remove_em) {
> -               /*
> -                * Our em might be in trans->transaction->pending_chunks =
which
> -                * is protected by fs_info->chunk_mutex ([lock|unlock]_ch=
unks),
> -                * and so is the fs_info->pinned_chunks list.
> -                *
> -                * So at this point we must be holding the chunk_mutex to=
 avoid
> -                * any races with chunk allocation (more specifically at
> -                * volumes.c:contains_pending_extent()), to ensure it alw=
ays
> -                * sees the em, either in the pending_chunks list or in t=
he
> -                * pinned_chunks list.
> -                */
> -               list_move_tail(&em->list, &fs_info->pinned_chunks);
> -       }
>         spin_unlock(&block_group->lock);
>
>         if (remove_em) {
> @@ -11002,11 +10979,6 @@ int btrfs_remove_block_group(struct btrfs_trans_=
handle *trans,
>
>                 em_tree =3D &fs_info->mapping_tree.map_tree;
>                 write_lock(&em_tree->lock);
> -               /*
> -                * The em might be in the pending_chunks list, so make su=
re the
> -                * chunk mutex is locked, since remove_extent_mapping() w=
ill
> -                * delete us from that list.
> -                */
>                 remove_extent_mapping(em_tree, em);
>                 write_unlock(&em_tree->lock);
>                 /* once for the tree */
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 928f729c55ba..1b3c6dc5b458 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -4,6 +4,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include "ctree.h"
> +#include "volumes.h"
>  #include "extent_map.h"
>  #include "compression.h"
>
> @@ -336,6 +337,36 @@ static inline void setup_extent_mapping(struct exten=
t_map_tree *tree,
>         else
>                 try_merge_map(tree, em);
>  }
> +static void extent_map_device_set_bits(struct extent_map *em, unsigned b=
its)
> +{
> +       struct map_lookup *map =3D em->map_lookup;
> +       u64 stripe_size =3D em->orig_block_len;
> +       int i;
> +
> +       for (i =3D 0; i < map->num_stripes; i++) {
> +               struct btrfs_bio_stripe *stripe =3D &map->stripes[i];
> +               struct btrfs_device *device =3D stripe->dev;
> +
> +               set_extent_bits_nowait(&device->alloc_state, stripe->phys=
ical,
> +                                stripe->physical + stripe_size - 1, bits=
);
> +       }
> +}
> +
> +static void extent_map_device_clear_bits(struct extent_map *em, unsigned=
 bits)
> +{
> +       struct map_lookup *map =3D em->map_lookup;
> +       u64 stripe_size =3D em->orig_block_len;
> +       int i;
> +
> +       for (i =3D 0; i < map->num_stripes; i++) {
> +               struct btrfs_bio_stripe *stripe =3D &map->stripes[i];
> +               struct btrfs_device *device =3D stripe->dev;
> +
> +               __clear_extent_bit(&device->alloc_state, stripe->physical=
,
> +                                  stripe->physical + stripe_size - 1, bi=
ts,
> +                                  0, 0, NULL, GFP_NOWAIT, NULL);
> +       }
> +}
>
>  /**
>   * add_extent_mapping - add new extent map to the extent tree
> @@ -357,6 +388,8 @@ int add_extent_mapping(struct extent_map_tree *tree,
>                 goto out;
>
>         setup_extent_mapping(tree, em, modified);
> +       if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
> +               extent_map_device_set_bits(em, CHUNK_ALLOCATED);
>  out:
>         return ret;
>  }
> @@ -438,6 +471,8 @@ void remove_extent_mapping(struct extent_map_tree *tr=
ee, struct extent_map *em)
>         rb_erase_cached(&em->rb_node, &tree->map);
>         if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
>                 list_del_init(&em->list);
> +       if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
> +               extent_map_device_clear_bits(em, CHUNK_ALLOCATED);
>         RB_CLEAR_NODE(&em->rb_node);
>  }
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 473f039fcd7c..72b46833f236 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -91,7 +91,6 @@ void replace_extent_mapping(struct extent_map_tree *tre=
e,
>                             struct extent_map *cur,
>                             struct extent_map *new,
>                             int modified);
> -
>  struct extent_map *alloc_extent_map(void);
>  void free_extent_map(struct extent_map *em);
>  int __init extent_map_init(void);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 74aa552f4793..207fb50dcc7a 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3366,10 +3366,6 @@ void btrfs_put_block_group_trimming(struct btrfs_b=
lock_group_cache *block_group)
>                 em =3D lookup_extent_mapping(em_tree, block_group->key.ob=
jectid,
>                                            1);
>                 BUG_ON(!em); /* logic error, can't happen */
> -               /*
> -                * remove_extent_mapping() will delete us from the pinned=
_chunks
> -                * list, which is protected by the chunk mutex.
> -                */
>                 remove_extent_mapping(em_tree, em);
>                 write_unlock(&em_tree->lock);
>                 mutex_unlock(&fs_info->chunk_mutex);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index b32769998bbb..e5404326fc55 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -50,14 +50,6 @@ void btrfs_put_transaction(struct btrfs_transaction *t=
ransaction)
>                         btrfs_err(transaction->fs_info,
>                                   "pending csums is %llu",
>                                   transaction->delayed_refs.pending_csums=
);
> -               while (!list_empty(&transaction->pending_chunks)) {
> -                       struct extent_map *em;
> -
> -                       em =3D list_first_entry(&transaction->pending_chu=
nks,
> -                                             struct extent_map, list);
> -                       list_del_init(&em->list);
> -                       free_extent_map(em);
> -               }
>                 /*
>                  * If any block groups are found in ->deleted_bgs then it=
's
>                  * because the transaction was aborted and a commit did n=
ot
> @@ -235,7 +227,6 @@ static noinline int join_transaction(struct btrfs_fs_=
info *fs_info,
>         spin_lock_init(&cur_trans->delayed_refs.lock);
>
>         INIT_LIST_HEAD(&cur_trans->pending_snapshots);
> -       INIT_LIST_HEAD(&cur_trans->pending_chunks);
>         INIT_LIST_HEAD(&cur_trans->dev_update_list);
>         INIT_LIST_HEAD(&cur_trans->switch_commits);
>         INIT_LIST_HEAD(&cur_trans->dirty_bgs);
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 2bd76f681520..4419a4a0294b 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -51,7 +51,6 @@ struct btrfs_transaction {
>         wait_queue_head_t writer_wait;
>         wait_queue_head_t commit_wait;
>         struct list_head pending_snapshots;
> -       struct list_head pending_chunks;
>         struct list_head dev_update_list;
>         struct list_head switch_commits;
>         struct list_head dirty_bgs;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 90eff8452c31..d240c07d4b2c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -335,6 +335,7 @@ void btrfs_free_device(struct btrfs_device *device)
>  {
>         WARN_ON(!list_empty(&device->post_commit_list));
>         rcu_string_free(device->name);
> +       extent_io_tree_release(&device->alloc_state);
>         bio_put(device->flush_bio);
>         kfree(device);
>  }
> @@ -411,6 +412,7 @@ static struct btrfs_device *__alloc_device(void)
>         btrfs_device_data_ordered_init(dev);
>         INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLA=
IM);
>         INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_REC=
LAIM);
> +       extent_io_tree_init(NULL, &dev->alloc_state, 0, NULL);
>
>         return dev;
>  }
> @@ -1498,58 +1500,29 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, fmode_t flags,
>         return device;
>  }
>
> -static int contains_pending_extent(struct btrfs_transaction *transaction=
,
> -                                  struct btrfs_device *device,
> -                                  u64 *start, u64 len)
> -{
> -       struct btrfs_fs_info *fs_info =3D device->fs_info;
> -       struct extent_map *em;
> -       struct list_head *search_list =3D &fs_info->pinned_chunks;
> -       int ret =3D 0;
> -       u64 physical_start =3D *start;
> -
> -       if (transaction)
> -               search_list =3D &transaction->pending_chunks;
> -again:
> -       list_for_each_entry(em, search_list, list) {
> -               struct map_lookup *map;
> -               int i;
> -
> -               map =3D em->map_lookup;
> -               for (i =3D 0; i < map->num_stripes; i++) {
> -                       u64 end;
> -
> -                       if (map->stripes[i].dev !=3D device)
> -                               continue;
> -                       if (map->stripes[i].physical >=3D physical_start =
+ len ||
> -                           map->stripes[i].physical + em->orig_block_len=
 <=3D
> -                           physical_start)
> -                               continue;
> -                       /*
> -                        * Make sure that while processing the pinned lis=
t we do
> -                        * not override our *start with a lower value, be=
cause
> -                        * we can have pinned chunks that fall within thi=
s
> -                        * device hole and that have lower physical addre=
sses
> -                        * than the pending chunks we processed before. I=
f we
> -                        * do not take this special care we can end up ge=
tting
> -                        * 2 pending chunks that start at the same physic=
al
> -                        * device offsets because the end offset of a pin=
ned
> -                        * chunk can be equal to the start offset of some
> -                        * pending chunk.
> -                        */
> -                       end =3D map->stripes[i].physical + em->orig_block=
_len;
> -                       if (end > *start) {
> -                               *start =3D end;
> -                               ret =3D 1;
> -                       }
> +/*
> + * Tries to find a chunk that intersects [start, start +len] range and w=
hen one
> + * such is found, records the end of it in *start
> + */
> +#define in_range(b, first, len)        ((b) >=3D (first) && (b) < (first=
) + (len))
> +static bool contains_pending_extent(struct btrfs_device *device, u64 *st=
art,
> +                                   u64 len)
> +{
> +       u64 physical_start, physical_end;
> +       lockdep_assert_held(&device->fs_info->chunk_mutex);
> +
> +       if (!find_first_extent_bit(&device->alloc_state, *start,
> +                                  &physical_start, &physical_end,
> +                                  CHUNK_ALLOCATED, NULL)) {
> +
> +               if (in_range(physical_start, *start, len) ||
> +                   in_range(*start, physical_start,
> +                            physical_end - physical_start)) {
> +                       *start =3D physical_end + 1;
> +                       return true;
>                 }
>         }
> -       if (search_list !=3D &fs_info->pinned_chunks) {
> -               search_list =3D &fs_info->pinned_chunks;
> -               goto again;
> -       }
> -
> -       return ret;
> +       return false;
>  }
>
>
> @@ -1660,15 +1633,12 @@ int find_free_dev_extent_start(struct btrfs_trans=
action *transaction,
>                          * Have to check before we set max_hole_start, ot=
herwise
>                          * we could end up sending back this offset anywa=
y.
>                          */
> -                       if (contains_pending_extent(transaction, device,
> -                                                   &search_start,
> +                       if (contains_pending_extent(device, &search_start=
,
>                                                     hole_size)) {
> -                               if (key.offset >=3D search_start) {
> +                               if (key.offset >=3D search_start)
>                                         hole_size =3D key.offset - search=
_start;
> -                               } else {
> -                                       WARN_ON_ONCE(1);
> +                               else
>                                         hole_size =3D 0;
> -                               }
>                         }
>
>                         if (hole_size > max_hole_size) {
> @@ -1709,8 +1679,7 @@ int find_free_dev_extent_start(struct btrfs_transac=
tion *transaction,
>         if (search_end > search_start) {
>                 hole_size =3D search_end - search_start;
>
> -               if (contains_pending_extent(transaction, device, &search_=
start,
> -                                           hole_size)) {
> +               if (contains_pending_extent(device, &search_start, hole_s=
ize)) {
>                         btrfs_release_path(path);
>                         goto again;
>                 }
> @@ -4758,7 +4727,7 @@ int btrfs_shrink_device(struct btrfs_device *device=
, u64 new_size)
>          * in-memory chunks are synced to disk so that the loop below see=
s them
>          * and relocates them accordingly.
>          */
> -       if (contains_pending_extent(trans->transaction, device, &start, d=
iff)) {
> +       if (contains_pending_extent(device, &start, diff)) {
>                 mutex_unlock(&fs_info->chunk_mutex);
>                 ret =3D btrfs_commit_transaction(trans);
>                 if (ret)
> @@ -5200,9 +5169,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_h=
andle *trans,
>                 free_extent_map(em);
>                 goto error;
>         }
> -
> -       list_add_tail(&em->list, &trans->transaction->pending_chunks);
> -       refcount_inc(&em->refs);
>         write_unlock(&em_tree->lock);
>
>         ret =3D btrfs_make_block_group(trans, 0, type, start, chunk_size)=
;
> @@ -5235,8 +5201,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_h=
andle *trans,
>         free_extent_map(em);
>         /* One for the tree reference */
>         free_extent_map(em);
> -       /* One for the pending_chunks list reference */
> -       free_extent_map(em);
>  error:
>         kfree(devices_info);
>         return ret;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 81784b68ca12..79901df4a157 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -133,6 +133,8 @@ struct btrfs_device {
>         /* Counter to record the change of device stats */
>         atomic_t dev_stats_ccnt;
>         atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
> +
> +       struct extent_io_tree alloc_state;
>  };
>
>  /*
> --
> 2.17.1
>

