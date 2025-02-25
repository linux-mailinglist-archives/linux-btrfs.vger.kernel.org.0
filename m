Return-Path: <linux-btrfs+bounces-11766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD8A43DFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3627A3562
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907B267B18;
	Tue, 25 Feb 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbgAVjaA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF81A2391;
	Tue, 25 Feb 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483813; cv=none; b=XQiN79+XM401jUjesCevh3c4y4jCfD4QMHpu7rVzXmQL9Y6UtKrfPg+MWzUFQsQ62DmJKe9zr3TcttH+akZlcn5F/7MqwqlFdoFV52BmM8rHEcO9RfC8IhPg53K1QmoQgxjUkzGi+0dlMGYeLNkThXzPc8OWx58fHfHSO6S9wI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483813; c=relaxed/simple;
	bh=50SXg6QdeZvBJt8kvyeAzwQsyWO8Eg4+cCDqsw8URSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHM+AUcZv5BF7rn/+bv7OYUTffmpWf90SJj+memf8r/FYUeRyrjwoP4VSV6Ej804fxspopl1PG8DdEZlL4yS+qt8+dQD8YvthcF3CxBn+/w6k45Z2+BzEOjANOIc6Tpsvs9VysAXrXcdBf31WfmF2Ab5U6WqdlY7AREE7aqy2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbgAVjaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5637FC4CEDD;
	Tue, 25 Feb 2025 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740483812;
	bh=50SXg6QdeZvBJt8kvyeAzwQsyWO8Eg4+cCDqsw8URSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbgAVjaAFYhCw+rKSAMpobKfHX6bo4H1IbhfngfFeyr0SATkZC+zXIRNE1LFjZlYP
	 7AyI78cXE70m3+Cm33BKlUTmvnEidmq13rME0kgTVEC5ejxbTpUcChIk0a4qiZJIqC
	 E5OBc9JIGPil8ct9R5Tuz3C3vw3QErt4BgB/QaZdR8pN5qtl6XMbkIYS2jzOG5Cb3m
	 iUc2llQej8ER2zoOxQju485qYEgCyHZO/ZhT7iZL+nVnIci7rttACCzBDiANsNlox0
	 8xfX22Fu46yquq3fsEQGVoqxkmuwIIGwDaBQGefvPtXeZIH3KIcjrXznr8FkghFVVp
	 nFUUMqfyso58A==
Date: Tue, 25 Feb 2025 11:43:29 +0000
From: Filipe Manana <fdmanana@kernel.org>
To: haoran zheng <zhenghaoran154@gmail.com>
Cc: Daniel Vacek <neelx@suse.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
Message-ID: <Z72s4bDZghGhcWzN@debian0.Home>
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
 <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
 <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
 <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
 <CAPjX3Feo9=hkptSxOMREKVckbvhfbmjHAWYBL2sBryDcVzp0NA@mail.gmail.com>
 <CAL3q7H7eSw0gg=JQwiEe9_pSEqcxugpgOWJDdv45UHrZbsFhzw@mail.gmail.com>
 <CAKa5YKjymZzRWy6WhVhu+mMzENunsM6URBL3o-_yy1wPGhdV-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKa5YKjymZzRWy6WhVhu+mMzENunsM6URBL3o-_yy1wPGhdV-A@mail.gmail.com>

On Wed, Feb 19, 2025 at 04:52:40PM +0800, haoran zheng wrote:
> On Wed, Feb 19, 2025 at 12:29 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Tue, Feb 18, 2025 at 4:14 PM Daniel Vacek <neelx@suse.com> wrote:
> > >
> > > On Tue, 18 Feb 2025 at 11:19, Filipe Manana <fdmanana@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 8:08 AM Daniel Vacek <neelx@suse.com> wrote:
> > > > >
> > > > > On Mon, 10 Feb 2025 at 12:11, Filipe Manana <fdmanana@kernel.org> wrote:
> > > > > >
> > > > > > On Sat, Feb 8, 2025 at 7:38 AM Hao-ran Zheng <zhenghaoran154@gmail.com> wrote:
> > > > > > >
> > > > > > > A data race may occur when the function `btrfs_discard_queue_work()`
> > > > > > > and the function `btrfs_update_block_group()` is executed concurrently.
> > > > > > > Specifically, when the `btrfs_update_block_group()` function is executed
> > > > > > > to lines `cache->used = old_val;`, and `btrfs_discard_queue_work()`
> > > > > > > is accessing `if(block_group->used == 0)` will appear with data race,
> > > > > > > which may cause block_group to be placed unexpectedly in discard_list or
> > > > > > > discard_unused_list. The specific function call stack is as follows:
> > > > > > >
> > > > > > > ============DATA_RACE============
> > > > > > >  btrfs_discard_queue_work+0x245/0x500 [btrfs]
> > > > > > >  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
> > > > > > >  btrfs_add_free_space+0x19a/0x200 [btrfs]
> > > > > > >  unpin_extent_range+0x847/0x2120 [btrfs]
> > > > > > >  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
> > > > > > >  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
> > > > > > >  transaction_kthread+0x764/0xc20 [btrfs]
> > > > > > >  kthread+0x292/0x330
> > > > > > >  ret_from_fork+0x4d/0x80
> > > > > > >  ret_from_fork_asm+0x1a/0x30
> > > > > > > ============OTHER_INFO============
> > > > > > >  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
> > > > > > >  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
> > > > > > >  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
> > > > > > >  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
> > > > > > >  flush_space+0x388/0x1440 [btrfs]
> > > > > > >  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
> > > > > > >  process_scheduled_works+0x716/0xf10
> > > > > > >  worker_thread+0xb6a/0x1190
> > > > > > >  kthread+0x292/0x330
> > > > > > >  ret_from_fork+0x4d/0x80
> > > > > > >  ret_from_fork_asm+0x1a/0x30
> > > > > > > =================================
> > > > > > >
> > > > > > > Although the `block_group->used` was checked again in the use of the
> > > > > > > `peek_discard_list` function, considering that `block_group->used` is
> > > > > > > a 64-bit variable, we still think that the data race here is an
> > > > > > > unexpected behavior. It is recommended to add `READ_ONCE` and
> > > > > > > `WRITE_ONCE` to read and write.
> > > > > > >
> > > > > > > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > > > > > > ---
> > > > > > >  fs/btrfs/block-group.c | 4 ++--
> > > > > > >  fs/btrfs/discard.c     | 2 +-
> > > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > > > > index c0a8f7d92acc..c681b97f6835 100644
> > > > > > > --- a/fs/btrfs/block-group.c
> > > > > > > +++ b/fs/btrfs/block-group.c
> > > > > > > @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> > > > > > >         old_val = cache->used;
> > > > > > >         if (alloc) {
> > > > > > >                 old_val += num_bytes;
> > > > > > > -               cache->used = old_val;
> > > > > > > +               WRITE_ONCE(cache->used, old_val);
> > > > > > >                 cache->reserved -= num_bytes;
> > > > > > >                 cache->reclaim_mark = 0;
> > > > > > >                 space_info->bytes_reserved -= num_bytes;
> > > > > > > @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> > > > > > >                 spin_unlock(&space_info->lock);
> > > > > > >         } else {
> > > > > > >                 old_val -= num_bytes;
> > > > > > > -               cache->used = old_val;
> > > > > > > +               WRITE_ONCE(cache->used, old_val);
> > > > > > >                 cache->pinned += num_bytes;
> > > > > > >                 btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
> > > > > > >                 space_info->bytes_used -= num_bytes;
> > > > > > > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > > > > > > index e815d165cccc..71c57b571d50 100644
> > > > > > > --- a/fs/btrfs/discard.c
> > > > > > > +++ b/fs/btrfs/discard.c
> > > > > > > @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
> > > > > > >         if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
> > > > > > >                 return;
> > > > > > >
> > > > > > > -       if (block_group->used == 0)
> > > > > > > +       if (READ_ONCE(block_group->used) == 0)
> > > > > >
> > > > > > There are at least 3 more places in discard.c where we access ->used
> > > > > > without being under the protection of the block group's spinlock.
> > > > > > So let's fix this for all places and not just a single one...
> > > > > >
> > > > > > Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over the place.
> > > > > > What we typically do in btrfs is to add helpers that hide them, see
> > > > > > block-rsv.h for example.
> > > > > >
> > > > > > Also, I don't think we need READ_ONCE/WRITE_ONCE.
> > > > > > We could use data_race(), though I think that could be subject to
> > > > > > load/store tearing, or just take the lock.
> > > > > > So adding a helper like this to block-group.h:
> > > > > >
> > > > > > static inline u64 btrfs_block_group_used(struct btrfs_block_group *bg)
> > > > > > {
> > > > > >    u64 ret;
> > > > > >
> > > > > >    spin_lock(&bg->lock);
> > > > > >    ret = bg->used;
> > > > > >    spin_unlock(&bg->lock);
> > > > > >
> > > > > >     return ret;
> > > > > > }
> 
> I understand that using lock to protect block_group->used
> in discard.c file is feasible. In addition, I looked at the code
> of block-group.c and found that locks have been added in
> some places where block_group->used are used. , it
> seems that it is not appropriate to call
> btrfs_block_group_used again to obtain (because it will
> cause deadlock). 

In places where we are reading it while holding the block group's
spinlock, there's nothing that needs to be changed.

Also we can't call it btrfs_block_group_used() since there's already
an accessor function for struct btrfs_block_group_item with that name
(defined through macros at accessors.h).

I took a closer look at the cases in discard.c, and it's safe to use
data_race() instead, even if load/store tearing happens or we get stale
values, nothing harmful happens, only a few things can be done later or
unnecessarily without side effects - like adding a non-empty block group
to the list of unused block groups, which is fine since the we won't
delete it the cleaner kthread in case it's not empty, or delay the discard.

Either give it another name like btrfs_get_block_group_used() or directly
use data_race() in discard.c - I don't like much either of them, the first
because there's the similar named accessor for block group items, the
second due to spreading data_race(), but I don't see any more elegant
alternative.

So a sample patch:

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 36937eeab9b8..ba635a69a23d 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -278,6 +278,15 @@ static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
 	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
 }
 
+/*
+ * To be used in contexts where we aren't holding the block group's spinlock and
+ * it's safe to do so.
+ */
+static inline u64 btrfs_get_block_group_used(const struct btrfs_block_group *bg)
+{
+	return data_race(bg->used);
+}
+
 static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group *block_group)
 {
 	/*
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e815d165cccc..eef1c0ab0a97 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -247,7 +247,7 @@ static struct btrfs_block_group *peek_discard_list(
 
 	if (block_group && now >= block_group->discard_eligible_time) {
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
-		    block_group->used != 0) {
+		    btrfs_get_block_group_used(block_group) != 0) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
 			} else {
@@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	if (block_group->used == 0)
+	if (btrfs_get_block_group_used(block_group) == 0)
 		add_to_discard_unused_list(discard_ctl, block_group);
 	else
 		add_to_discard_list(discard_ctl, block_group);
@@ -460,7 +460,7 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 {
 	remove_from_discard_list(discard_ctl, block_group);
 
-	if (block_group->used == 0) {
+	if (btrfs_get_block_group_used(block_group) == 0) {
 		if (btrfs_is_free_space_trimmed(block_group))
 			btrfs_mark_bg_unused(block_group);
 		else
@@ -719,7 +719,7 @@ static void btrfs_discard_purge_list(struct btrfs_discard_ctl *discard_ctl)
 					 discard_list) {
 			list_del_init(&block_group->discard_list);
 			spin_unlock(&discard_ctl->lock);
-			if (block_group->used == 0)
+			if (btrfs_get_block_group_used(block_group) == 0)
 				btrfs_mark_bg_unused(block_group);
 			spin_lock(&discard_ctl->lock);
 			btrfs_put_block_group(block_group);



> I would like to ask other similar places
> where block_group->used needs to call
> btrfs_block_group_used function in addition to the four
> places in discard.c?

I noticed one for block-group.c but the solution isn't the same because
there's an actual bug there, see:

https://lore.kernel.org/linux-btrfs/cover.1740427964.git.fdmanana@suse.com/

> 
> > > > >
> > > > > Would memory barriers be sufficient here? Taking a lock just for
> > > > > reading one member seems excessive...
> 
> Do I need to perform performance testing to ensure the impact if I lock it?

No, specially with data_race().

Thanks.

> 
> > > >
> > > > Do you think there's heavy contention on this lock?
> > >
> > > This is not about contention. Spin lock should just never be used this
> > > way. Or any lock actually. The critical section only contains a single
> > > fetch operation which does not justify using a lock.
> > > Hence the only guarantee such lock usage provides are the implicit
> > > memory barriers (from which maybe only one of them is really needed
> > > depending on the context where this helper is going to be used).
> > >
> > > Simply put, the lock is degraded into a memory barrier this way. So
> > > why not just use the barriers in the first place if only ordering
> > > guarantees are required? It only makes sense.
> >
> > As said earlier, it's a lot easier to reason about lock() and unlock()
> > calls rather than spreading memory barriers in the write and read
> > sides.
> > Historically he had several mistakes with barriers, they're simply not
> > as straightforward to reason as locks.
> >
> > Plus spreading the barriers in the read and write sides makes the code
> > not so easy to read, not to mention in case of any new sites updating
> > the member, we'll have to not forget adding a barrier.
> >
> > It's just easier to reason and maintain.
> >
> >
> > >
> > > > Usually I prefer to go the simplest way, and using locks is a lot more
> > > > straightforward and easier to understand than memory barriers.
> > >
> > > How so? Locks provide the same memory barriers implicitly.
> >
> > I'm not saying they don't.
> > I'm talking about easier code to read and maintain.
> >
> > >
> > > > Unless it's clear there's an observable performance penalty, keeping
> > > > it simple is better.
> > >
> > > Exactly. Here is where our opinions differ. For me 'simple' means
> > > without useless locking.
> > > I mean especially with locks they should only be used when absolutely
> > > necessary. In a sense of 'use the right tool for the job'. There are
> > > more lightweight tools possible in this context. Locks provide
> > > additional guarantees which are not needed here.
> > >
> > > On the other hand I understand that using a lock is a 'better safe
> > > than sorry' approach which should also work. Just keep in mind that
> > > spinlock may sleep on RT.
> >
> > It's not about a better safe than sorry, but easier to read, reason
> > and maintain.
> >
> > >
> > > > data_race() may be ok here, at least for one of the unprotected
> > > > accesses it's fine, but would have to analyse the other 3 cases.
> > >
> > > That's exactly my thoughts. Maybe not even the barriers are needed
> > > after all. This needs to be checked on a per-case basis.
> > >
> > > > >
> > > > > > And then use btrfs_bock_group_used() everywhere in discard.c where we
> > > > > > aren't holding a block group's lock.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >                 add_to_discard_unused_list(discard_ctl, block_group);
> > > > > > >         else
> > > > > > >                 add_to_discard_list(discard_ctl, block_group);
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > > > > >

