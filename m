Return-Path: <linux-btrfs+bounces-12136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DDA592A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B7116B9F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22221E097;
	Mon, 10 Mar 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KKBmAcFC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89410192580;
	Mon, 10 Mar 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605686; cv=none; b=uLC1HwLu+jGT6ASB2Z+hRRJoCdHJHvfeZuXwDAwnNpxNKHw/TZ5UGW+d9f10f4d/DW9XlKW1A9I0/aZTVjkuzXgm8hcHAYVX2ue3H1IrAbwb5MmkxmKGJW10wcBYFUxOzQ2XUxxD65dLT5nAPicsOQwg0+iC0HgeTCeMkRubiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605686; c=relaxed/simple;
	bh=v+cvV8TZEkE6O3ZZKhoW/Uc7tHVXvXIvFHQFcFDAq0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOxA43ovbryKbfyLs7RtOdBtDfsYg2Z7Hfe9hWJWWOarlG+7Huw+uxOqwLwfCFz3SE8bswWbt69Puchg8FsnWqvUv3beSFi6uPalqlmJQz5/SayhNvH42HDlvjDVHracGHl70qu+6yI/l+H5JytQW9StDI+/GviTk8HGkIiyhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KKBmAcFC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gSxstmZW7u9wIdflkH/88t3AUpEgJazDXuWXCe/+pcY=; b=KKBmAcFC+19/DrFQnVn1qKCeLW
	5tf09XumaqPl+xN6DsBkc2bMnv6anCfxInbYc0OA/TZLtLTtzFotQ+0eZlv/Pltno41Kwk3nKe/4Z
	9U996QoIYRONIvtGMCwYbvWI6lJMkuQ/yKBhFXiiTG7gjgHp0sf0ds8K5o+9Ql+mGtzy9vQRZ3H9Y
	cy9Ej9R7ekPmDjq5z58JRehXoAFWiaxJkxtowpDvcBjMUh2EBvLF68LIEWV7DkfSTJ9nN6NQlBwD2
	Dz2H/N81uHxoZJRDt2mg/6KNT8VCeK2p6b2iOTefqP7QuUJ0yUjvYbHuum3Lp6MgAAEEjwpUOiN5o
	gzldPpmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trbC3-00000004E8e-1mO8;
	Mon, 10 Mar 2025 11:21:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2EBEC300269; Mon, 10 Mar 2025 12:21:10 +0100 (CET)
Date: Mon, 10 Mar 2025 12:21:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, dsterba@suse.cz,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Chris Murphy <lists@colorremedies.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <20250310112110.GR16878@noisy.programming.kicks-ass.net>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9K6m5USnON/19GT@boqun-archlinux>

On Thu, Jan 26, 2023 at 09:38:35AM -0800, Boqun Feng wrote:

> *	warn but not turn off the lockdep: the lock holding chain is
> 	only a cache for what lock holding combination lockdep has ever
> 	see, we also record the dependency in the graph. Without the
> 	lock holding chain, lockdep can still work but just slower.

Quite a bit slower, but yeah you can give it a try.

> *	allow dynmaic memory allocation in lockdep: I think this might
> 	be OK since we have lockdep_recursion to avoid lockdep code ->
> 	mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
> 	missing something. And even we allow it, the use of memory
> 	doesn't change, you will still need that amout of memory to
> 	track lock holding chains.

I'm not sure what you're proposing, we cannot allocate from the
__lock_acquire context, which is where you establish the new chain and
find you're out of storage.

I suppose you're thinking about doing the above, skipping caching the
chain and then trying a re-alloc asynchronously?

Anyway, even if we get that to work, we really should keep an eye out
for silly patterns. Yes, the ever growing pool of locks means that per
combinatorics we'll have more chains, we still should avoid silly.


Notably, looking at my lockdep_chains just now, I notice daft stuff
like:

irq_context: 0
[ffffffff849642f0] &pmus_srcu

irq_context: 0
[ffffffff849642f0] &pmus_srcu
[ffffffff849642f0] &pmus_srcu

irq_context: 0
[ffffffff849642f0] &pmus_srcu
[ffffffff849642f0] &pmus_srcu
[ffffffff832177a8] pmc_reserve_mutex

irq_context: 0
[ffffffff849642f0] &pmus_srcu
[ffffffff849642f0] &pmus_srcu
[ffffffff832177a8] pmc_reserve_mutex
[ffffffff83320ac0] fs_reclaim

irq_context: 0
[ffffffff849642f0] &pmus_srcu
[ffffffff849642f0] &pmus_srcu
[ffffffff832177a8] pmc_reserve_mutex
[ffffffff83320ac0] fs_reclaim
[ffffffff833238c0] mmu_notifier_invalidate_range_start


Similarly:

irq_context: softirq
[ffffffff84957a70] rcu_read_lock
[ffffffff84957a70] rcu_read_lock
[ffffffff849c0801] slock-AF_INET/1
[ffffffff84957a70] rcu_read_lock
[ffffffff84957a70] rcu_read_lock
[ffffffff84957a60] rcu_read_lock_bh
[ffffffff849c38e0] dev->qdisc_tx_busylock ?: &qdisc_tx_busylock
[ffff888103bdf290] &sch->root_lock_key#3

and:

irq_context: 0
[ffffffff83393d18] &inode->i_sb->s_type->i_mutex_dir_key
[ffffffff84957a70] rcu_read_lock
[ffffffff84957a70] rcu_read_lock
[ffffffff84957a70] rcu_read_lock
[ffffffff83ec00c0] &pool->lock
[ffffffff83ebf240] &p->pi_lock
[ffffffff83ec2a80] &rq->__lock
[ffffffff849587b0] &____s->seqcount

and:

irq_context: 0
[ffff888106344b38] (wq_completion)usb_hub_wq
[ffffffff849b7700] (work_completion)(&hub->events)
[ffffffff83ec6070] &dev->mutex
[ffffffff83ec6070] &dev->mutex
[ffffffff83ec6070] &dev->mutex
[ffffffff83ec6070] &dev->mutex
[ffffffff83438d68] dquirks_lock

All get extra chains because of the arguably pointless duplication in
held locks.



Also, WTF is up with this lock name: :-)

irq_context: softirq
[ffffffff84965400] &(({ do { const void *__vpp_verify = (typeof((&vmstat_work) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((&vmstat_work))) *)(( unsigned long)((&vmstat_work))))); (typeof((typeof(*((&vmstat_work))) *)(( unsigned long)((&vmstat_work))))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); }))->timer



It might make sense to collapse the rcu locks and count them at the
first instance, instead of tracking them all on the held stack, hmm?

Something a little like the below. I suppose the only problem here is
that we might miss the wait_type check, although I suppose we muck stuff
around a bit more.

This isn't going to fix any big amount of resource usage; but all little
bits help, right :-)

---
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9f361d3ab9d9..a9849fea263b 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -81,6 +81,7 @@ struct lock_class_key {
 
 extern struct lock_class_key __lockdep_no_validate__;
 extern struct lock_class_key __lockdep_no_track__;
+extern struct lockdep_map    __lockdep_default_nest__;
 
 struct lock_trace;
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..2c6b3b0da4f1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -334,12 +334,12 @@ extern struct lockdep_map rcu_callback_map;
 
 static inline void rcu_lock_acquire(struct lockdep_map *map)
 {
-	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
+	lock_acquire(map, 0, 0, 2, 0, &__lockdep_default_nest__, _THIS_IP_);
 }
 
 static inline void rcu_try_lock_acquire(struct lockdep_map *map)
 {
-	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
+	lock_acquire(map, 0, 1, 2, 0, &__lockdep_default_nest__, _THIS_IP_);
 }
 
 static inline void rcu_lock_release(struct lockdep_map *map)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index d7ba46e74f58..bcfba95fe14d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -161,7 +161,7 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 /* Annotates a srcu_read_lock() */
 static inline void srcu_lock_acquire(struct lockdep_map *map)
 {
-	lock_map_acquire_read(map);
+	lock_acquire(map, 0, 0, 2, 0, &__lockdep_default_nest__, _THIS_IP_);
 }
 
 /* Annotates a srcu_read_lock() */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b15757e63626..d0c5799763cd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5003,6 +5003,9 @@ EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 struct lock_class_key __lockdep_no_track__;
 EXPORT_SYMBOL_GPL(__lockdep_no_track__);
 
+struct lockdep_map __lockdep_default_nest__ = { .name = "__lockdep_default_nest__" };
+EXPORT_SYMBOL_GPL(__lockdep_default_nest__);
+
 #ifdef CONFIG_PROVE_LOCKING
 void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
 			     lock_print_fn print_fn)
@@ -5067,6 +5070,9 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
 
+static struct held_lock *find_held_lock(struct task_struct *curr,
+					struct lockdep_map *lock,
+					unsigned int depth, int *idx);
 /*
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
@@ -5099,6 +5105,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!prove_locking || lock->key == &__lockdep_no_validate__) {
 		check = 0;
 		lockevent_inc(lockdep_nocheck);
+		nest_lock = &__lockdep_default_nest__;
 	}
 
 	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
@@ -5138,10 +5145,16 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	class_idx = class - lock_classes;
 
-	if (depth && !sync) {
-		/* we're holding locks and the new held lock is not a sync */
-		hlock = curr->held_locks + depth - 1;
-		if (hlock->class_idx == class_idx && nest_lock) {
+	if (nest_lock && depth && !sync) {
+		if (nest_lock == &__lockdep_default_nest__) {
+			hlock = find_held_lock(curr, lock, depth, NULL);
+		} else {
+			hlock = curr->held_locks + depth - 1;
+			if (hlock->class_idx != class_idx)
+				hlock = NULL;
+		}
+
+		if (hlock) {
 			if (!references)
 				references++;
 
@@ -5222,7 +5235,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	}
 	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 
-	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
+	if (nest_lock &&
+	    nest_lock != &__lockdep_default_nest__ &&
+	    !__lock_is_held(nest_lock, -1)) {
 		print_lock_nested_lock_not_held(curr, hlock);
 		return 0;
 	}
@@ -5366,7 +5381,8 @@ static struct held_lock *find_held_lock(struct task_struct *curr,
 	}
 
 out:
-	*idx = i;
+	if (idx)
+		*idx = i;
 	return ret;
 }
 

