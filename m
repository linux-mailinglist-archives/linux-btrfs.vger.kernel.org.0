Return-Path: <linux-btrfs+bounces-8239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFAA986F7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BD12865E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90618DF79;
	Thu, 26 Sep 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTgR1m/T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1263CF73
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341339; cv=none; b=TAN1WAFdLLXISmp3V5mdJ1/OsrnyOl3+ww0GyTEqb1+Qng/ZX1qzfnX4iAnLPXXXIEmV6gY3bGC+QWImm442ApNetJOcA7R5M6tyyuUpV0Dabpwrfqt1roeznLgKgSCMeWo3aOeu6yQXlmTy3Zw9inIsVdcFEFNgUJOHR53NOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341339; c=relaxed/simple;
	bh=p5PvCkdtJJI5A6smOXBwszZezH4PIJ6d2NheDwRPKnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pal0xo+z9iQjrmBNVQUj0G0GE0ybG0dWUiKdwd0J95we5LS4CPrQ2meWcvxtSovHpfKHJEyKnK0GrNUEDfG7CSx9x9PFumOvBE5fpmDF9uLaRePTNjDAi0bYaSYBS5iZn7g8o2zSJ7gMIZOAFzNiYISRVB5nlvGCUQXIobjGevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTgR1m/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D94AC4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727341338;
	bh=p5PvCkdtJJI5A6smOXBwszZezH4PIJ6d2NheDwRPKnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cTgR1m/T50KAg1EQAHWayZ6YUaCEEFmj2Yks31qcKDY4M4UqiQ6E+WzPFmRE2sUCy
	 0P64xrqzOdcQ7xhBQwESWqAmigzgjIj+NhdUb/WPrj07xcZV8gABjDk2C5yHryPtEp
	 f8hNy5+N0DjyZHf4cQQpu311LOg6Wx9JMcdI2G4yM7y1F+UJNt2ZXOQtL2rZxUgLEn
	 l/0J+HXWYQ1+WniYNVmMdfOOquTYqH+Sa0olWQho36LUadlJGhoNNW1N32I/4BwHzO
	 +pDSSBIJezhoZIOTL7mokMrQLiULLJ/h02mmGsmahlS/Zb0mwhveVsYpxtoIbDYn4n
	 j/nBR7HPBiC5Q==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d4979b843so94799966b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 02:02:18 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9z05P1l52t/FRp3LJFmU9cBifJIHH+k4hFtq3EbEtncZkq4px
	A/he71OP65M+4TmwbFzbsadClbQerW4qgBF6eAALVade2H2YL/loTPnS8awfha73yQ+82xYmbvk
	jTPx7a4jHBHRK6zE1cvhQxDjskGY=
X-Google-Smtp-Source: AGHT+IGqWIhpTn3m0lo0/tP+GtaP534vQZjXz1X949zIK0tJVJRKgWpwQNHBpPiX4wfa2awWVG3kVbDvhc3NT3G6U0I=
X-Received: by 2002:a17:907:1c88:b0:a91:1787:a955 with SMTP id
 a640c23a62f3a-a93a03c3285mr459535566b.28.1727341336789; Thu, 26 Sep 2024
 02:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174151.git.fdmanana@suse.com> <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
 <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com>
In-Reply-To: <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 10:01:40 +0100
X-Gmail-Original-Message-ID: <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
Message-ID: <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: make the extent map shrinker run
 asynchronously as a work queue job
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:08=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently the extent map shrinker is run synchronously for kswapd tasks
> > that end up calling the fs shrinker (fs/super.c:super_cache_scan()).
> > This has some disadvantages and for some heavy workloads with memory
> > pressure it can cause some delays and stalls that make a machine
> > unresponsive for some periods. This happens because:
> >
> > 1) We can have several kswapd tasks on machines with multiple NUMA zone=
s,
> >     and running the extent map shrinker concurrently can cause high
> >     contention on some spin locks, namely the spin locks that protect
> >     the radix tree that tracks roots, the per root xarray that tracks
> >     open inodes and the list of delayed iputs. This not only delays the
> >     shrinker but also causes high CPU consumption and makes the task
> >     running the shrinker monopolize a core, resulting in the symptoms
> >     of an unresponsive system. This was noted in previous commits such =
as
> >     commit ae1e766f623f ("btrfs: only run the extent map shrinker from
> >     kswapd tasks");
> >
> > 2) The extent map shrinker's iteration over inodes can often be slow, e=
ven
> >     after changing the data structure that tracks open inodes for a roo=
t
> >     from a red black tree (up to kernel 6.10) to an xarray (kernel 6.10=
+).
> >     The transition to the xarray while it made things a bit faster, it'=
s
> >     still somewhat slow - for example in a test scenario with 10000 ino=
des
> >     that have no extent maps loaded, the extent map shrinker took betwe=
en
> >     5ms to 8ms, using a release, non-debug kernel. Iterating over the
> >     extent maps of an inode can also be slow if have an inode with many
> >     thousands of extent maps, since we use a red black tree to track an=
d
> >     search extent maps. So having the extent map shrinker run synchrono=
usly
> >     adds extra delay for other things a kswapd task does.
> >
> > So make the extent map shrinker run asynchronously as a job for the
> > system unbounded workqueue, just like what we do for data and metadata
> > space reclaim jobs.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/disk-io.c    |  2 ++
> >   fs/btrfs/extent_map.c | 51 ++++++++++++++++++++++++++++++++++++------=
-
> >   fs/btrfs/extent_map.h |  3 ++-
> >   fs/btrfs/fs.h         |  2 ++
> >   fs/btrfs/super.c      | 13 +++--------
> >   5 files changed, 52 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 25d768e67e37..2148147c5257 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2786,6 +2786,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
info)
> >       btrfs_init_scrub(fs_info);
> >       btrfs_init_balance(fs_info);
> >       btrfs_init_async_reclaim_work(fs_info);
> > +     btrfs_init_extent_map_shrinker_work(fs_info);
> >
> >       rwlock_init(&fs_info->block_group_cache_lock);
> >       fs_info->block_group_cache_tree =3D RB_ROOT_CACHED;
> > @@ -4283,6 +4284,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
> >       cancel_work_sync(&fs_info->async_reclaim_work);
> >       cancel_work_sync(&fs_info->async_data_reclaim_work);
> >       cancel_work_sync(&fs_info->preempt_reclaim_work);
> > +     cancel_work_sync(&fs_info->extent_map_shrinker_work);
> >
> >       /* Cancel or finish ongoing discard work */
> >       btrfs_discard_cleanup(fs_info);
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index cb2a6f5dce2b..e2eeb94aa349 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -1118,7 +1118,8 @@ struct btrfs_em_shrink_ctx {
> >
> >   static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_=
em_shrink_ctx *ctx)
> >   {
> > -     const u64 cur_fs_gen =3D btrfs_get_fs_generation(inode->root->fs_=
info);
> > +     struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> > +     const u64 cur_fs_gen =3D btrfs_get_fs_generation(fs_info);
> >       struct extent_map_tree *tree =3D &inode->extent_tree;
> >       long nr_dropped =3D 0;
> >       struct rb_node *node;
> > @@ -1191,7 +1192,8 @@ static long btrfs_scan_inode(struct btrfs_inode *=
inode, struct btrfs_em_shrink_c
> >                * lock. This is to avoid slowing other tasks trying to t=
ake the
> >                * lock.
> >                */
> > -             if (need_resched() || rwlock_needbreak(&tree->lock))
> > +             if (need_resched() || rwlock_needbreak(&tree->lock) ||
> > +                 btrfs_fs_closing(fs_info))
> >                       break;
> >               node =3D next;
> >       }
> > @@ -1215,7 +1217,8 @@ static long btrfs_scan_root(struct btrfs_root *ro=
ot, struct btrfs_em_shrink_ctx
> >               ctx->last_ino =3D btrfs_ino(inode);
> >               btrfs_add_delayed_iput(inode);
> >
> > -             if (ctx->scanned >=3D ctx->nr_to_scan)
> > +             if (ctx->scanned >=3D ctx->nr_to_scan ||
> > +                 btrfs_fs_closing(inode->root->fs_info))
> >                       break;
> >
> >               cond_resched();
> > @@ -1244,16 +1247,19 @@ static long btrfs_scan_root(struct btrfs_root *=
root, struct btrfs_em_shrink_ctx
> >       return nr_dropped;
> >   }
> >
> > -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_=
scan)
> > +static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
> >   {
> > +     struct btrfs_fs_info *fs_info;
> >       struct btrfs_em_shrink_ctx ctx;
> >       u64 start_root_id;
> >       u64 next_root_id;
> >       bool cycled =3D false;
> >       long nr_dropped =3D 0;
> >
> > +     fs_info =3D container_of(work, struct btrfs_fs_info, extent_map_s=
hrinker_work);
> > +
> >       ctx.scanned =3D 0;
> > -     ctx.nr_to_scan =3D nr_to_scan;
> > +     ctx.nr_to_scan =3D atomic64_read(&fs_info->extent_map_shrinker_nr=
_to_scan);
> >
> >       /*
> >        * In case we have multiple tasks running this shrinker, make the=
 next
> > @@ -1271,12 +1277,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_inf=
o *fs_info, long nr_to_scan)
> >       if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
> >               s64 nr =3D percpu_counter_sum_positive(&fs_info->evictabl=
e_extent_maps);
> >
> > -             trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to=
_scan,
> > +             trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.n=
r_to_scan,
> >                                                          nr, ctx.last_r=
oot,
> >                                                          ctx.last_ino);
> >       }
> >
> > -     while (ctx.scanned < ctx.nr_to_scan) {
> > +     while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)=
) {
> >               struct btrfs_root *root;
> >               unsigned long count;
> >
> > @@ -1334,5 +1340,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_info=
 *fs_info, long nr_to_scan)
> >                                                         ctx.last_ino);
> >       }
> >
> > -     return nr_dropped;
> > +     atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
> > +}
> > +
> > +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_=
scan)
> > +{
> > +     /*
> > +      * Do nothing if the shrinker is already running. In case of high=
 memory
> > +      * pressure we can have a lot of tasks calling us and all passing=
 the
> > +      * same nr_to_scan value, but in reality we may need only to free
> > +      * nr_to_scan extent maps (or less). In case we need to free more=
 than
> > +      * that, we will be called again by the fs shrinker, so no worrie=
s about
> > +      * not doing enough work to reclaim memory from extent maps.
> > +      * We can also be repeatedly called with the same nr_to_scan valu=
e
> > +      * simply because the shrinker runs asynchronously and multiple c=
alls
> > +      * to this function are made before the shrinker does enough prog=
ress.
> > +      *
> > +      * That's why we set the atomic counter to nr_to_scan only if its
> > +      * current value is zero, instead of incrementing the counter by
> > +      * nr_to_scan.
> > +      */
>
> Since the shrinker can be called frequently, even if we only keep one
> shrink work running, will the shrinker be kept running for a long time?
> (one queued work done, then immiedately be queued again)

What's the problem?
The use of the atomic and not incrementing it, as said in the comment,
makes sure we don't do more work than necessary.

It's also running in the system unbound queue and has plenty of
explicit reschedule calls to ensure it doesn't monopolize a cpu and
doesn't block other tasks for long.

So how can it cause any problem?

>
> The XFS is queuing the work with an delay, although their reason is that
> the reclaim needs to be run more frequently than syncd interval (30s).
>
> Do we also need some delay to prevent such too frequent reclaim work?

See the comment above.

Without the increment of the atomic counter, if it keeps getting
scheduled it's because we're under memory pressure and need to free
memory as quickly as possible.

Thanks.

>
> Thanks,
> Qu
>
> > +     if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0,=
 nr_to_scan) !=3D 0)
> > +             return;
> > +
> > +     queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work)=
;
> > +}
> > +
> > +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info=
)
> > +{
> > +     atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
> > +     INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_sh=
rinker_worker);
> >   }
> > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > index 5154a8f1d26c..cd123b266b64 100644
> > --- a/fs/btrfs/extent_map.h
> > +++ b/fs/btrfs/extent_map.h
> > @@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode,
> >   int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
> >                                  struct extent_map *new_em,
> >                                  bool modified);
> > -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_=
scan);
> > +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_=
scan);
> > +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info=
);
> >
> >   #endif
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 785ec15c1b84..a246d8dc0b20 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -638,6 +638,8 @@ struct btrfs_fs_info {
> >       spinlock_t extent_map_shrinker_lock;
> >       u64 extent_map_shrinker_last_root;
> >       u64 extent_map_shrinker_last_ino;
> > +     atomic64_t extent_map_shrinker_nr_to_scan;
> > +     struct work_struct extent_map_shrinker_work;
> >
> >       /* Protected by 'trans_lock'. */
> >       struct list_head dirty_cowonly_roots;
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index e8a5bf4af918..e9e209dd8e05 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -28,7 +28,6 @@
> >   #include <linux/btrfs.h>
> >   #include <linux/security.h>
> >   #include <linux/fs_parser.h>
> > -#include <linux/swap.h>
> >   #include "messages.h"
> >   #include "delayed-inode.h"
> >   #include "ctree.h"
> > @@ -2416,16 +2415,10 @@ static long btrfs_free_cached_objects(struct su=
per_block *sb, struct shrink_cont
> >       const long nr_to_scan =3D min_t(unsigned long, LONG_MAX, sc->nr_t=
o_scan);
> >       struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> >
> > -     /*
> > -      * We may be called from any task trying to allocate memory and w=
e don't
> > -      * want to slow it down with scanning and dropping extent maps. I=
t would
> > -      * also cause heavy lock contention if many tasks concurrently en=
ter
> > -      * here. Therefore only allow kswapd tasks to scan and drop exten=
t maps.
> > -      */
> > -     if (!current_is_kswapd())
> > -             return 0;
> > +     btrfs_free_extent_maps(fs_info, nr_to_scan);
> >
> > -     return btrfs_free_extent_maps(fs_info, nr_to_scan);
> > +     /* The extent map shrinker runs asynchronously, so always return =
0. */
> > +     return 0;
> >   }
> >
> >   static const struct super_operations btrfs_super_ops =3D {
>

