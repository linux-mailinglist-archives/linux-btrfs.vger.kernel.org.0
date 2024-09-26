Return-Path: <linux-btrfs+bounces-8253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CEF9871CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 12:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028B91C20ADD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9A1AD9F2;
	Thu, 26 Sep 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov3jGLDM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6D1AD9EC
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347330; cv=none; b=lKtYGd65zkMWWw91c/8DHeCW8ud+zRxrATwKaIsDo761fGsjhCYW1mnWxfr0GOxS/HHWfMiyfXIhDI96G1igzl2SfqC402W3TJaOdGV38GLwrRqHoA4nhp8FsdJFPw0A90YD+3p/c8lC+hyP4EdanMWCbopk9mzF8ZsAMdQVRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347330; c=relaxed/simple;
	bh=3jkpKq1+aZ3dme6Oe08DbGHPKIBhEzLlX7VBEbV+XUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUQnRDCzvH+G2AVpXs63Yvb8hyyg9Y1U/2PdaTuzMaFWfGH51YjlV6VYQPAKAKOuWtEKAssm+34ruIfzDBnb2gOf2Yg+CgEDnhTOtsxdTwi+1YT5ySStI+nYzCWgocN90/4eqUErok+LkIGNO+5ebfZr7y06mtmj2sWHmGOFHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov3jGLDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC361C4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727347329;
	bh=3jkpKq1+aZ3dme6Oe08DbGHPKIBhEzLlX7VBEbV+XUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ov3jGLDMkrrGHSfTM7gz9uGjioiO+drW998EOLqUZX5UUKcSkjzOQz+8VxDto6ZZa
	 8yAofNSq4dk2WCk3Fhg22ErI4dvVPRuPXSStJPzqLwO+0Ug7opvz9s+OYBFqUr+A8p
	 pNq7YZZsaq1Q8x7u4+qa4RzNHwP7fbHAzlfEYusW8Qa2c14tiNzquV9N1lCkfP01Ny
	 taOXFSaTzMGnC3X8pAHeHEPNN51bTSxHThtYcXTFjrbllVmbtw6UKG3GTstY5jd+HD
	 IQeLrxoC8OM7UcY4VaOYcuqOQmcUPFcCIzfYlraFIYHJ8akQsSZJ1B3XFTcdKsp0gy
	 EqKojXEaJG7JQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d64b27c45so119626166b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 03:42:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YzycNEMouAgg8DukjJZvEkjVFJLjHQeM8zRE/pwIvRXDdmVt9bU
	rbXYYF8y25Kc7/iHPvjOU9jQUL7RH0gaVMHQh9cDcwjwm+zvn8zkgx7/eYmztSukHhgP+T2FH1s
	L51P4af2061/I06PHr4OFODMfyIQ=
X-Google-Smtp-Source: AGHT+IHLf9ePjpQussk4Rao/39gWGCpI3pD3OUNf7ZdWJZxiv4c2iOfWoeo//5dr+09DrVqdWf8xc0HciwjCjx/Vy2Q=
X-Received: by 2002:a17:907:c7c8:b0:a7d:a080:baa with SMTP id
 a640c23a62f3a-a93a03b1a6fmr520622966b.34.1727347328109; Thu, 26 Sep 2024
 03:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174151.git.fdmanana@suse.com> <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
 <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com> <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
 <9323f10d-dab1-4826-a088-90b1c5bea38c@gmx.com>
In-Reply-To: <9323f10d-dab1-4826-a088-90b1c5bea38c@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 11:41:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7LBWyfXy7XRJh7ufgLdhTBw4MGZtBtLV+2zCLJ3MrFsQ@mail.gmail.com>
Message-ID: <CAL3q7H7LBWyfXy7XRJh7ufgLdhTBw4MGZtBtLV+2zCLJ3MrFsQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: make the extent map shrinker run
 asynchronously as a work queue job
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:55=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/26 18:31, Filipe Manana =E5=86=99=E9=81=93:
> > On Wed, Sep 25, 2024 at 11:08=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> Currently the extent map shrinker is run synchronously for kswapd tas=
ks
> >>> that end up calling the fs shrinker (fs/super.c:super_cache_scan()).
> >>> This has some disadvantages and for some heavy workloads with memory
> >>> pressure it can cause some delays and stalls that make a machine
> >>> unresponsive for some periods. This happens because:
> >>>
> >>> 1) We can have several kswapd tasks on machines with multiple NUMA zo=
nes,
> >>>      and running the extent map shrinker concurrently can cause high
> >>>      contention on some spin locks, namely the spin locks that protec=
t
> >>>      the radix tree that tracks roots, the per root xarray that track=
s
> >>>      open inodes and the list of delayed iputs. This not only delays =
the
> >>>      shrinker but also causes high CPU consumption and makes the task
> >>>      running the shrinker monopolize a core, resulting in the symptom=
s
> >>>      of an unresponsive system. This was noted in previous commits su=
ch as
> >>>      commit ae1e766f623f ("btrfs: only run the extent map shrinker fr=
om
> >>>      kswapd tasks");
> >>>
> >>> 2) The extent map shrinker's iteration over inodes can often be slow,=
 even
> >>>      after changing the data structure that tracks open inodes for a =
root
> >>>      from a red black tree (up to kernel 6.10) to an xarray (kernel 6=
.10+).
> >>>      The transition to the xarray while it made things a bit faster, =
it's
> >>>      still somewhat slow - for example in a test scenario with 10000 =
inodes
> >>>      that have no extent maps loaded, the extent map shrinker took be=
tween
> >>>      5ms to 8ms, using a release, non-debug kernel. Iterating over th=
e
> >>>      extent maps of an inode can also be slow if have an inode with m=
any
> >>>      thousands of extent maps, since we use a red black tree to track=
 and
> >>>      search extent maps. So having the extent map shrinker run synchr=
onously
> >>>      adds extra delay for other things a kswapd task does.
> >>>
> >>> So make the extent map shrinker run asynchronously as a job for the
> >>> system unbounded workqueue, just like what we do for data and metadat=
a
> >>> space reclaim jobs.
> >>>
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>> ---
> >>>    fs/btrfs/disk-io.c    |  2 ++
> >>>    fs/btrfs/extent_map.c | 51 ++++++++++++++++++++++++++++++++++++---=
----
> >>>    fs/btrfs/extent_map.h |  3 ++-
> >>>    fs/btrfs/fs.h         |  2 ++
> >>>    fs/btrfs/super.c      | 13 +++--------
> >>>    5 files changed, 52 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >>> index 25d768e67e37..2148147c5257 100644
> >>> --- a/fs/btrfs/disk-io.c
> >>> +++ b/fs/btrfs/disk-io.c
> >>> @@ -2786,6 +2786,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *f=
s_info)
> >>>        btrfs_init_scrub(fs_info);
> >>>        btrfs_init_balance(fs_info);
> >>>        btrfs_init_async_reclaim_work(fs_info);
> >>> +     btrfs_init_extent_map_shrinker_work(fs_info);
> >>>
> >>>        rwlock_init(&fs_info->block_group_cache_lock);
> >>>        fs_info->block_group_cache_tree =3D RB_ROOT_CACHED;
> >>> @@ -4283,6 +4284,7 @@ void __cold close_ctree(struct btrfs_fs_info *f=
s_info)
> >>>        cancel_work_sync(&fs_info->async_reclaim_work);
> >>>        cancel_work_sync(&fs_info->async_data_reclaim_work);
> >>>        cancel_work_sync(&fs_info->preempt_reclaim_work);
> >>> +     cancel_work_sync(&fs_info->extent_map_shrinker_work);
> >>>
> >>>        /* Cancel or finish ongoing discard work */
> >>>        btrfs_discard_cleanup(fs_info);
> >>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> >>> index cb2a6f5dce2b..e2eeb94aa349 100644
> >>> --- a/fs/btrfs/extent_map.c
> >>> +++ b/fs/btrfs/extent_map.c
> >>> @@ -1118,7 +1118,8 @@ struct btrfs_em_shrink_ctx {
> >>>
> >>>    static long btrfs_scan_inode(struct btrfs_inode *inode, struct btr=
fs_em_shrink_ctx *ctx)
> >>>    {
> >>> -     const u64 cur_fs_gen =3D btrfs_get_fs_generation(inode->root->f=
s_info);
> >>> +     struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>> +     const u64 cur_fs_gen =3D btrfs_get_fs_generation(fs_info);
> >>>        struct extent_map_tree *tree =3D &inode->extent_tree;
> >>>        long nr_dropped =3D 0;
> >>>        struct rb_node *node;
> >>> @@ -1191,7 +1192,8 @@ static long btrfs_scan_inode(struct btrfs_inode=
 *inode, struct btrfs_em_shrink_c
> >>>                 * lock. This is to avoid slowing other tasks trying t=
o take the
> >>>                 * lock.
> >>>                 */
> >>> -             if (need_resched() || rwlock_needbreak(&tree->lock))
> >>> +             if (need_resched() || rwlock_needbreak(&tree->lock) ||
> >>> +                 btrfs_fs_closing(fs_info))
> >>>                        break;
> >>>                node =3D next;
> >>>        }
> >>> @@ -1215,7 +1217,8 @@ static long btrfs_scan_root(struct btrfs_root *=
root, struct btrfs_em_shrink_ctx
> >>>                ctx->last_ino =3D btrfs_ino(inode);
> >>>                btrfs_add_delayed_iput(inode);
> >>>
> >>> -             if (ctx->scanned >=3D ctx->nr_to_scan)
> >>> +             if (ctx->scanned >=3D ctx->nr_to_scan ||
> >>> +                 btrfs_fs_closing(inode->root->fs_info))
> >>>                        break;
> >>>
> >>>                cond_resched();
> >>> @@ -1244,16 +1247,19 @@ static long btrfs_scan_root(struct btrfs_root=
 *root, struct btrfs_em_shrink_ctx
> >>>        return nr_dropped;
> >>>    }
> >>>
> >>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_t=
o_scan)
> >>> +static void btrfs_extent_map_shrinker_worker(struct work_struct *wor=
k)
> >>>    {
> >>> +     struct btrfs_fs_info *fs_info;
> >>>        struct btrfs_em_shrink_ctx ctx;
> >>>        u64 start_root_id;
> >>>        u64 next_root_id;
> >>>        bool cycled =3D false;
> >>>        long nr_dropped =3D 0;
> >>>
> >>> +     fs_info =3D container_of(work, struct btrfs_fs_info, extent_map=
_shrinker_work);
> >>> +
> >>>        ctx.scanned =3D 0;
> >>> -     ctx.nr_to_scan =3D nr_to_scan;
> >>> +     ctx.nr_to_scan =3D atomic64_read(&fs_info->extent_map_shrinker_=
nr_to_scan);
> >>>
> >>>        /*
> >>>         * In case we have multiple tasks running this shrinker, make =
the next
> >>> @@ -1271,12 +1277,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_i=
nfo *fs_info, long nr_to_scan)
> >>>        if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
> >>>                s64 nr =3D percpu_counter_sum_positive(&fs_info->evict=
able_extent_maps);
> >>>
> >>> -             trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_=
to_scan,
> >>> +             trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx=
.nr_to_scan,
> >>>                                                           nr, ctx.las=
t_root,
> >>>                                                           ctx.last_in=
o);
> >>>        }
> >>>
> >>> -     while (ctx.scanned < ctx.nr_to_scan) {
> >>> +     while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_inf=
o)) {
> >>>                struct btrfs_root *root;
> >>>                unsigned long count;
> >>>
> >>> @@ -1334,5 +1340,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_in=
fo *fs_info, long nr_to_scan)
> >>>                                                          ctx.last_ino=
);
> >>>        }
> >>>
> >>> -     return nr_dropped;
> >>> +     atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
> >>> +}
> >>> +
> >>> +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_t=
o_scan)
> >>> +{
> >>> +     /*
> >>> +      * Do nothing if the shrinker is already running. In case of hi=
gh memory
> >>> +      * pressure we can have a lot of tasks calling us and all passi=
ng the
> >>> +      * same nr_to_scan value, but in reality we may need only to fr=
ee
> >>> +      * nr_to_scan extent maps (or less). In case we need to free mo=
re than
> >>> +      * that, we will be called again by the fs shrinker, so no worr=
ies about
> >>> +      * not doing enough work to reclaim memory from extent maps.
> >>> +      * We can also be repeatedly called with the same nr_to_scan va=
lue
> >>> +      * simply because the shrinker runs asynchronously and multiple=
 calls
> >>> +      * to this function are made before the shrinker does enough pr=
ogress.
> >>> +      *
> >>> +      * That's why we set the atomic counter to nr_to_scan only if i=
ts
> >>> +      * current value is zero, instead of incrementing the counter b=
y
> >>> +      * nr_to_scan.
> >>> +      */
> >>
> >> Since the shrinker can be called frequently, even if we only keep one
> >> shrink work running, will the shrinker be kept running for a long time=
?
> >> (one queued work done, then immiedately be queued again)
> >
> > What's the problem?
> > The use of the atomic and not incrementing it, as said in the comment,
> > makes sure we don't do more work than necessary.
> >
> > It's also running in the system unbound queue and has plenty of
> > explicit reschedule calls to ensure it doesn't monopolize a cpu and
> > doesn't block other tasks for long.
> >
> > So how can it cause any problem?
>
> Then it will be a workqueue taking CPU 100% (or near that).
> Even there is only one running work.

No it won't.
Besides the very frequent reschedule points, the shrinker is always
called with a small percentage of the total number of objects to free.

>
> The first one queued the X number to do, and the work got queued, after
> freed X items, the next call triggered, queuing another Y number to recla=
im.

And? Work queue jobs are distributed across cores as needed, so that
work queue won't be monopolized with extent map shrinking.

>
> The we get the same near-100% CPU usage, it may be rescheduled, but not
> much difference.
> We will always have one reclaim work item running at any moment.

And if that happens it's because it's needed.
The same goes for space reclaim, it's exactly what we do for space
reclaim. We don't add delays there and neither for delayed iputs.

>
> >
> >>
> >> The XFS is queuing the work with an delay, although their reason is th=
at
> >> the reclaim needs to be run more frequently than syncd interval (30s).
> >>
> >> Do we also need some delay to prevent such too frequent reclaim work?
> >
> > See the comment above.
> >
> > Without the increment of the atomic counter, if it keeps getting
> > scheduled it's because we're under memory pressure and need to free
> > memory as quickly as possible.
>
> Even the atomic stays the same until the current one finished, we just
> get a new number of items to reclaim next.

If we do get it's because we still need to free memory, and we have to do i=
t.

>
> Furthermore, from our existing experience, we didn't really hit a
> realworld case where the em cache is causing a huge problem, so the
> relaim for em should be a very low priority thing.

We had 1 person reporting it. And now that the problem is publicly
known, it can be exploited by someone with bad intentions - no root
privileges are required.

>
> Thus I still believe a delayed work will be much safer, just like what
> XFS is doing for decades, and also like our cleaner kthread.

Not a specialist on XFS, and maybe they have their reasons for doing
what they do.

But the case with our cleaner kthread is very different:

1) First for delayed iputs that delay doesn't exist.
When doing a delayed iput we always wake up the cleaner if it's not
currently running.
We want them to run asap to prevent inode eviction from happening and
holding memory and space reservations for too long.

2) Otherwise the delay and sleep is both because it's a kthread we
manually manage and because deletion of dead roots is IO heavy.

Extent map shrinking doesn't do any IO. Any concern about CPU I've
already addressed above.


>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>> +     if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, =
0, nr_to_scan) !=3D 0)
> >>> +             return;
> >>> +
> >>> +     queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_wor=
k);
> >>> +}
> >>> +
> >>> +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_in=
fo)
> >>> +{
> >>> +     atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
> >>> +     INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_=
shrinker_worker);
> >>>    }
> >>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> >>> index 5154a8f1d26c..cd123b266b64 100644
> >>> --- a/fs/btrfs/extent_map.h
> >>> +++ b/fs/btrfs/extent_map.h
> >>> @@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode,
> >>>    int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
> >>>                                   struct extent_map *new_em,
> >>>                                   bool modified);
> >>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_t=
o_scan);
> >>> +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_t=
o_scan);
> >>> +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_in=
fo);
> >>>
> >>>    #endif
> >>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> >>> index 785ec15c1b84..a246d8dc0b20 100644
> >>> --- a/fs/btrfs/fs.h
> >>> +++ b/fs/btrfs/fs.h
> >>> @@ -638,6 +638,8 @@ struct btrfs_fs_info {
> >>>        spinlock_t extent_map_shrinker_lock;
> >>>        u64 extent_map_shrinker_last_root;
> >>>        u64 extent_map_shrinker_last_ino;
> >>> +     atomic64_t extent_map_shrinker_nr_to_scan;
> >>> +     struct work_struct extent_map_shrinker_work;
> >>>
> >>>        /* Protected by 'trans_lock'. */
> >>>        struct list_head dirty_cowonly_roots;
> >>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >>> index e8a5bf4af918..e9e209dd8e05 100644
> >>> --- a/fs/btrfs/super.c
> >>> +++ b/fs/btrfs/super.c
> >>> @@ -28,7 +28,6 @@
> >>>    #include <linux/btrfs.h>
> >>>    #include <linux/security.h>
> >>>    #include <linux/fs_parser.h>
> >>> -#include <linux/swap.h>
> >>>    #include "messages.h"
> >>>    #include "delayed-inode.h"
> >>>    #include "ctree.h"
> >>> @@ -2416,16 +2415,10 @@ static long btrfs_free_cached_objects(struct =
super_block *sb, struct shrink_cont
> >>>        const long nr_to_scan =3D min_t(unsigned long, LONG_MAX, sc->n=
r_to_scan);
> >>>        struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> >>>
> >>> -     /*
> >>> -      * We may be called from any task trying to allocate memory and=
 we don't
> >>> -      * want to slow it down with scanning and dropping extent maps.=
 It would
> >>> -      * also cause heavy lock contention if many tasks concurrently =
enter
> >>> -      * here. Therefore only allow kswapd tasks to scan and drop ext=
ent maps.
> >>> -      */
> >>> -     if (!current_is_kswapd())
> >>> -             return 0;
> >>> +     btrfs_free_extent_maps(fs_info, nr_to_scan);
> >>>
> >>> -     return btrfs_free_extent_maps(fs_info, nr_to_scan);
> >>> +     /* The extent map shrinker runs asynchronously, so always retur=
n 0. */
> >>> +     return 0;
> >>>    }
> >>>
> >>>    static const struct super_operations btrfs_super_ops =3D {
> >>
>

