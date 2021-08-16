Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6E3EDEBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhHPUrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 16:47:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhHPUrY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 16:47:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FFA91FEF1;
        Mon, 16 Aug 2021 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629146811;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkxuluEj93oVh/UBmls0eTnl0cq1wB/ibYheCpxTvxk=;
        b=HPIyuLcdjpddmP6wY0gsyOfHhHh+QRSsiqvVT1lT7Iu5keBVV+rOq32CI3HXVt2Ee1vi2t
        fYi7AETZCXm2Gh0ExDmObAIUa4lqEUKIBfANFd64auwDMxh+fnUHP2PA8FkXME6wkwjO1R
        EH9TOJow4byCAHdFaxtwAD+rnjxo3kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629146811;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkxuluEj93oVh/UBmls0eTnl0cq1wB/ibYheCpxTvxk=;
        b=ftRjOFOczICskRQC3eyzfBQWABlLni5IcVar/J2Wo4avSocFq0xFi7hJtER7Qf0ODBrEID
        tD2BdaNpD7Ud25DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6737DA3B87;
        Mon, 16 Aug 2021 20:46:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C231DA72C; Mon, 16 Aug 2021 22:43:54 +0200 (CEST)
Date:   Mon, 16 Aug 2021 22:43:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>, willy@infradead.org
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
Message-ID: <20210816204354.GI5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Peter Zijlstra <peterz@infradead.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>, willy@infradead.org
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
 <20210816102022.GU5047@twin.jikos.cz>
 <1e15b3ab-e3a3-548b-86a7-c309deed0f12@suse.com>
 <YRqAO41JqBwutUKd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRqAO41JqBwutUKd@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 05:11:55PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 16, 2021 at 01:27:35PM +0300, Nikolay Borisov wrote:
> > On 16.08.21 г. 13:20, David Sterba wrote:
> > > On Fri, Aug 13, 2021 at 10:33:05PM -0600, Chris Murphy wrote:
> > >> I get the following call trace about 0.6s after dnf completes an
> > >> update which I imagine deletes many files. I'll try to reproduce and
> > >> get /proc/lock_stat
> > >>
> > >> [   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > 
> > > The message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" is related to
> > > lockdep and not a btrfs problem, but it appears from time to time and as
> > > Johannes said either increase the config variable, or ignore it.
> > > 
> > 
> > But is not a bug if code triggers it? I.e I think it's a signal of
> > misbehaving code. CC'ed PeterZ who can hopefully shed some light on this.
> 
> Yeah, it's lockdep running out of (memory) resources... the immediate
> thing I noticed is that btrfs_set_buffer_lockdep_class() creates 12*8
> lock classes, but when you consider enum btrfs_lock_nesting that becomes
> 12*8*8, which is a somewhat silly number.. When the number of classes
> increase like that, the number of unique lock chains also increases and
> consequently we seem to run out of hlocks.
> 
> (possibly there's something else that also creates a ton of classes on
> that system, but -ENOINFO)

Yeah it can't be just btrfs taking all the hlocks space, in the past the
warning popped up at random tests. Recently it has consistently started
to appear at test that's #11 in the list out of about ~880 so we lost
lockdep reports. I remember most if not all the reports to be valid
leading to fixes.

The number 12*8*8 is perhaps silly and more than would be sane, but at
least it's fixed and bounded so the CONFIG_LOCKDEP_CHAINS_BITS could be
adjusted as Johaness pointed out in another reply that 18 works for him.
I verified that on my setup and started to see normal lockdep reports
again. This is an improvement, for debugging builds we can live with
that.

> One thing I've been contemplating is using an annotation scheme like
> ww_mutex for trees. Then the tree root gets a nest class and all the
> tree nodes get the same lock class. The down-side is that any actual
> tree lock order violations go unreported. But the current
> class-per-level annotation already has some of that anyway.
> 
> One thing I've pondered is to augment nest_lock with a custom validation
> function which is called in the 'reference' case which validates if the
> current 'instance' nests in the previous instance.
> 
> Something a little like the *completely* untested below....
> 
> Then I imagine someone could do something like:
> 
> struct my_tree_node {
> 	...
> 	spinlock_t lock;

Is this meant to work only for spinlocks or does it work for rwsem too?
I guess with lockdep it does not matter but we use rwsem for tree locks.

> };
> 
> struct my_tree_root {
> 	...
> 	struct my_tree_node *node;
> 	struct lockdep_map dep_map;
> };
> 
> bool my_tree_validate_order(struct lockdep_map *prev, struct lockdep_map *next)
> {
> 	struct my_tree_node *parent = container_of(prev, struct my_tree_node, lock.dep_map);
> 	struct my_tree_node *child = container_of(next, struct my_tree_node, lock.dep_map);
> 
> 	return is_child_of(parent, child);
> }
> 
> void my_tree_init_root(struct my_tree_root *root)
> {
> 	lockdep_init_map_type(&root->dep_map, "my_tree_root", &my_tree_validate_order, 0,
> 			      LD_WAIT_INV, LD_WAIT_INV, LD_LOCK_NEST_FUNC);
> }
> 
> void my_tree_lock_prepare(struct my_tree_root *root)
> {
> 	mutex_acquire(&root->dep_map, 0, 0, _RET_IP_);
> }
> 
> void my_tree_lock_finish(struct my_tree_root *root)
> {
> 	mutex_release(&root->dep_map, _RET_IP_);
> }
> 
> void my_tree_lock_node(struct my_tree_root *root, struct my_tree_node *node)
> {
> 	spin_lock_nest_lock(&node->lock, root);
> }
> 
> void my_tree_unlock_node(struct my_tree_node *node)
> {
> 	spin_unlock(&node->lock);
> }
> 
> And the whole 'tree' thing collapses into a single class and single hold
> entry.

I'll try to adapt the btrfs tree locking to the proposed API.

> ---
>  include/linux/lockdep_types.h |  1 +
>  kernel/locking/lockdep.c      | 68 ++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index 3e726ace5c62..0afc46a1fd31 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -33,6 +33,7 @@ enum lockdep_wait_type {
>  enum lockdep_lock_type {
>  	LD_LOCK_NORMAL = 0,	/* normal, catch all */
>  	LD_LOCK_PERCPU,		/* percpu */
> +	LD_LOCK_NEST_FUNC,
>  	LD_LOCK_MAX,
>  };
>  
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 8a509672a4cc..7e6fcd09a34c 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -723,7 +723,7 @@ static void print_lockdep_cache(struct lockdep_map *lock)
>  	printk(KERN_CONT "%s", name);
>  }
>  
> -static void print_lock(struct held_lock *hlock)
> +static void __print_lock(struct held_lock *hlock, struct lockdep_map *instance, unsigned long ip)
>  {
>  	/*
>  	 * We can be called locklessly through debug_show_all_locks() so be
> @@ -742,9 +742,14 @@ static void print_lock(struct held_lock *hlock)
>  		return;
>  	}
>  
> -	printk(KERN_CONT "%px", hlock->instance);
> +	printk(KERN_CONT "%px", instance);
>  	print_lock_name(lock);
> -	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
> +	printk(KERN_CONT ", at: %pS\n", (void *)ip);
> +}
> +
> +static void print_lock(struct held_lock *hlock)
> +{
> +	__print_lock(hlock, hlock->instance, hlock->acquire_ip);
>  }
>  
>  static void lockdep_print_held_locks(struct task_struct *p)
> @@ -806,6 +811,9 @@ static int static_obj(const void *obj)
>  	if (arch_is_kernel_data(addr))
>  		return 1;
>  
> +	if (arch_is_kernel_text(addr))
> +		return 1;
> +
>  	/*
>  	 * in-kernel percpu var?
>  	 */
> @@ -4846,8 +4854,34 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
>  	pr_warn("\nbut this task is not holding:\n");
>  	pr_warn("%s\n", hlock->nest_lock->name);
>  
> +	pr_warn("\nother info that might help us debug this:\n");
> +	lockdep_print_held_locks(curr);
> +
>  	pr_warn("\nstack backtrace:\n");
>  	dump_stack();
> +}
> +
> +static void
> +print_lock_nested_invalid(struct task_struct *curr,
> +			  struct held_lock *hlock,
> +			  struct lockdep_map *lock,
> +			  unsigned long ip)
> +{
> +	if (!debug_locks_off())
> +		return;
> +	if (debug_locks_silent)
> +		return;
> +
> +	pr_warn("\n");
> +	pr_warn("============================\n");
> +	pr_warn("WARNING: Nested lock invalid\n");
> +	print_kernel_ident();
> +	pr_warn("----------------------------\n");
> +
> +	pr_warn("%s/%d is trying to lock:\n", curr->comm, task_pid_nr(curr));
> +	__print_lock(hlock, lock, ip);
> +	pr_warn("but %ps() fails with already held lock:\n", (void*)hlock->nest_lock->key);
> +	print_lock(hlock);
>  
>  	pr_warn("\nother info that might help us debug this:\n");
>  	lockdep_print_held_locks(curr);
> @@ -4858,6 +4892,13 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
>  
>  static int __lock_is_held(const struct lockdep_map *lock, int read);
>  
> +typedef bool (*nest_f)(struct lockdep_map *prev, struct lockdep_map *next);
> +
> +bool __nest_func_true(struct lockdep_map *prev, struct lockdep_map *next)
> +{
> +	return true;
> +}
> +
>  /*
>   * This gets called for every mutex_lock*()/spin_lock*() operation.
>   * We maintain the dependency maps and validate the locking attempt:
> @@ -4871,6 +4912,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  			  struct lockdep_map *nest_lock, unsigned long ip,
>  			  int references, int pin_count)
>  {
> +	nest_f nest_func = __nest_func_true;
>  	struct task_struct *curr = current;
>  	struct lock_class *class = NULL;
>  	struct held_lock *hlock;
> @@ -4920,6 +4962,15 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  
>  	class_idx = class - lock_classes;
>  
> +	if (nest_lock) {
> +		if (!__lock_is_held(nest_lock, -1)) {
> +			print_lock_nested_lock_not_held(curr, hlock, ip);
> +			return 0;
> +		}
> +		if (nest_lock->type == LD_LOCK_NEST_FUNC)

That's probably nest_lock->lock_type, does not compile otherwise.

> +			nest_func = (nest_f)nest_lock->key;
> +	}
> +
>  	if (depth) { /* we're holding locks */
>  		hlock = curr->held_locks + depth - 1;
>  		if (hlock->class_idx == class_idx && nest_lock) {
> @@ -4929,6 +4980,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  			if (!hlock->references)
>  				hlock->references++;
>  
> +			if (!nest_func(hlock->instance, lock)) {
> +				print_lock_nested_invalid(curr, hlock, lock, ip);
> +				return 0;
> +			}
> +
> +			hlock->instance = lock;
>  			hlock->references += references;
>  
>  			/* Overflow */
> @@ -5002,11 +5059,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  	}
>  	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
>  
> -	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
> -		print_lock_nested_lock_not_held(curr, hlock, ip);
> -		return 0;
> -	}
> -
>  	if (!debug_locks_silent) {
>  		WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->key);
>  		WARN_ON_ONCE(!hlock_class(hlock)->key);
