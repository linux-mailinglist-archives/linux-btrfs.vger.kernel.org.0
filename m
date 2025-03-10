Return-Path: <linux-btrfs+bounces-12147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D184BA59B31
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 17:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2077818857F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43252309A7;
	Mon, 10 Mar 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou1VHiwK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4FB17A31A;
	Mon, 10 Mar 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624720; cv=none; b=fe9mmQAxcACgZcycNZrXYOCVJoxj2fWcEkwsERPM+aGjfrPla8TmFltAz2v3uAb020fOTfZ9sFazhDKQr72O7CrN7jSwv5JuwBfKGRrWti6VaKVO92O4CGFtsYW8JTTSTxYkVjWhplL86v2oFFyRK65IuoLR6+6l/J7QZhV7Kec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624720; c=relaxed/simple;
	bh=84V7Rax7KD7zLRWucgSj72E4erxtMkfRCkOadE0DKqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI916YDwu7eRo8r2UKR+cALuYMysaLxLpgTKoNAj5U+KyKUcIP5fS9tAROnIprVDlKo2npNH/upUea5JN86nO+U/MLF9LrBCOyHSYBJvmFFNLcK/bcZOr+mLCkdkBbbBkHQ0sotBRGeYjBt0FC0iotF7PeVKRVeMvLqdBxVuQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou1VHiwK; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3d3147b81so486765685a.1;
        Mon, 10 Mar 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741624717; x=1742229517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVHqdz5vY0IjdSBVVIdoq6OZCdZ9dysiy6csm1hvdto=;
        b=Ou1VHiwKt8NfkbNcjJQl2qbZp5QPWxbBQc1/nXQus74UxJUatYsH8LUzJMBgnXuKbL
         ADyEM5eQoEEgoRukkJ3CJoXm3h79Lqz7pSLNqhn6zWvykK63veuheQuk+rYn39EqERbT
         6YbeJY67MdortR4mEyWg4LKiJGimoGdn1i5G8T8NUvGR350chACpxKwXp3U6E82PKlBR
         icvWhiDWnzenkzbsN3MW4PMku/i0WpyXI+Z0BRwAByvr4GuJhJSo+EvQ682sC1WsR1G2
         62nV3Q6AquUtX0aiRSQl6zYPif6Z7Qh6u54ZWPOrOTS+MF4wuXAAlg5S+WolKiP5A0o7
         qPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624717; x=1742229517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVHqdz5vY0IjdSBVVIdoq6OZCdZ9dysiy6csm1hvdto=;
        b=vajIBqxgVDvD7m6xBOYu8SKH05V8bkVYxs7vpN35P1VqRIqxbWNHhlfjws+qdPljYy
         ckPyIKTfJjh0gmXrwaSMHXxuJKPwPSeIkBmdgD/EKE7Fr8xSdhhkMHPjiBJxzKc/5mgY
         GZkeye2alGYnvJurd7uvoNwSlId4rNVX3zSu2toIU79PK7b6KOMnFS9fDoPncF1PMMDD
         BQJlzGN1IJSpUQPlOCEUzLi9xj8ZQBNWMyeSBtRM3Ndf0sR3S/OYV1MDJCsgr5R+Kr8w
         WHn4POQmZq5HgrX61qk1VwdOTQP8rniEHiMcnkOErYBehUkPOeFwkqdaeIS++Hfo+yqK
         /cUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN14OAx+WLouVfakwuiLT1lbLHCjNJqy1Y3sRaGdsFUgyKXhhbjm5UezxluBwQE5xEAbteWySRN5osmA==@vger.kernel.org, AJvYcCXtondm2Bc8nzzeIqHsa3yMdsStUDpF5c0LgCrnYiJpdCIXoU8WVxJ85acMRjBgCk8DSKvA/DHH32Z32g29@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wIm5eolfGQEOseVlGsqYRABjLd1WfTGvX7hUOBdlsI6bNtqw
	PF/JcwXWEGZSJKv7hVPUf/Oroe2O2h4Ri6PZff4QDdPmZa5BIetq
X-Gm-Gg: ASbGncvgqWpIqo1q513a+o7SNAVPdkChnniUx/PaHbGwU5neOGfJKvZxZZdE5pW79fq
	Oyg3YmrKZLbUvmZb/0YLTuETtbWySloCcFKyPe5ByWLMsD7eHg1mrocXVUTHZaCMKNOL8IqTAwu
	aBkRIWMKeFw/DClmca7aJOJYBhWWtQitxRoZnAAF9XkE2cRhKeMjgyWnoElMjUHT1uld7wmBn+n
	j9OGqbrDv2r6lRO3wsbn8olqUvAAL1xKhBSz3Ifu3BmRLYWsZ0OHEXqVNRIc1IOS27PC7eGloTC
	J0RPs+gUNilWNC2uLu7V9V921Q8+8PVStxqH0C/UUJx4HkAVTfz9QLkg9Q5BE+aW7jiX0fGXS4I
	X6qSvRSFCgwJKfCF7AGxli7ny0/phRccRQgFhMWuQjsMD5A==
X-Google-Smtp-Source: AGHT+IGXe8tC8nN8RI+2O31wq20/RnaefKV0xuySK8AGX3ZZow6Dx5M2VPT3gbv7YMx/KtTQvU5vZA==
X-Received: by 2002:a05:620a:4893:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7c55e83a849mr82377785a.5.1741624716806;
        Mon, 10 Mar 2025 09:38:36 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5500015sm697598885a.85.2025.03.10.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:38:36 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id CDA14120006B;
	Mon, 10 Mar 2025 12:38:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 12:38:35 -0400
X-ME-Sender: <xms:ixXPZwchdr-mbn9XCpPWWZVvi7f9tzwqtiCAbOVxgZT6LWnksbLn5A>
    <xme:ixXPZyN2YnMMZFJwVTteB3k6AVMPk9h3NVcCYCtVBI8CT5SmiCLZM26PIwlkOOe5W
    -E-P47I03aFw9N-tg>
X-ME-Received: <xmr:ixXPZxgXtNA5RPh2MXwRqZMTFONSE5RwJhh5Pa8NgFEHOj1-xJbPcYpdPg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehmihhkhhgrihhlrdhvrdhgrghvrhhilhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgiipdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhrtghpthhtohepmhhi
    nhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ixXPZ1_RcAiih4Nc1Gqj2sWZ9gZ-p3MF2mifyyguyDzZFqbf5oy1dQ>
    <xmx:ixXPZ8tD_JWigCMsKv7xREVDJn8cBsh_yviydqZPqVsHc1FI3yLt8Q>
    <xmx:ixXPZ8HbW4sqtosIdEqVx52j9GfkjoWgRW3FtGUPLbI9YhZU7PX0nA>
    <xmx:ixXPZ7OIFURt1R9gTMGvB7Dbb1uS0GNT7gogvI0Da8-Y7_1G1c6wsA>
    <xmx:ixXPZxPTsJ3hrRz0_BGpndmD8DsNUgzvRVqPS817W79AcQD5WsL_c65K>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:38:35 -0400 (EDT)
Date: Mon, 10 Mar 2025 09:37:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, dsterba@suse.cz,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Chris Murphy <lists@colorremedies.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <Z88VOz5seTv_eSLp@boqun-archlinux>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <20250310112110.GR16878@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310112110.GR16878@noisy.programming.kicks-ass.net>

On Mon, Mar 10, 2025 at 12:21:10PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 26, 2023 at 09:38:35AM -0800, Boqun Feng wrote:
> 
> > *	warn but not turn off the lockdep: the lock holding chain is
> > 	only a cache for what lock holding combination lockdep has ever
> > 	see, we also record the dependency in the graph. Without the
> > 	lock holding chain, lockdep can still work but just slower.
> 
> Quite a bit slower, but yeah you can give it a try.
> 
> > *	allow dynmaic memory allocation in lockdep: I think this might
> > 	be OK since we have lockdep_recursion to avoid lockdep code ->
> > 	mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
> > 	missing something. And even we allow it, the use of memory
> > 	doesn't change, you will still need that amout of memory to
> > 	track lock holding chains.
> 
> I'm not sure what you're proposing, we cannot allocate from the
> __lock_acquire context, which is where you establish the new chain and
> find you're out of storage.
> 

Hmm.. I think what was in my mind is that we keep some unused memory
pool (say, one page), and whenever we use up the chain caches, we get
memory from that pool (in __lock_acquire()), and then at the end of
__lock_acquire(), we try to allocate the memory and put it in the pool.

I should probably try it myself, but let's look into "avoid skilly
pattern" first.

> I suppose you're thinking about doing the above, skipping caching the
> chain and then trying a re-alloc asynchronously?
> 
> Anyway, even if we get that to work, we really should keep an eye out
> for silly patterns. Yes, the ever growing pool of locks means that per
> combinatorics we'll have more chains, we still should avoid silly.
> 
> 
> Notably, looking at my lockdep_chains just now, I notice daft stuff
> like:
> 
> irq_context: 0
> [ffffffff849642f0] &pmus_srcu
> 
> irq_context: 0
> [ffffffff849642f0] &pmus_srcu
> [ffffffff849642f0] &pmus_srcu
> 
> irq_context: 0
> [ffffffff849642f0] &pmus_srcu
> [ffffffff849642f0] &pmus_srcu
> [ffffffff832177a8] pmc_reserve_mutex
> 
> irq_context: 0
> [ffffffff849642f0] &pmus_srcu
> [ffffffff849642f0] &pmus_srcu
> [ffffffff832177a8] pmc_reserve_mutex
> [ffffffff83320ac0] fs_reclaim
> 
> irq_context: 0
> [ffffffff849642f0] &pmus_srcu
> [ffffffff849642f0] &pmus_srcu
> [ffffffff832177a8] pmc_reserve_mutex
> [ffffffff83320ac0] fs_reclaim
> [ffffffff833238c0] mmu_notifier_invalidate_range_start
> 
> 
> Similarly:
> 
> irq_context: softirq
> [ffffffff84957a70] rcu_read_lock
> [ffffffff84957a70] rcu_read_lock
> [ffffffff849c0801] slock-AF_INET/1
> [ffffffff84957a70] rcu_read_lock
> [ffffffff84957a70] rcu_read_lock
> [ffffffff84957a60] rcu_read_lock_bh
> [ffffffff849c38e0] dev->qdisc_tx_busylock ?: &qdisc_tx_busylock
> [ffff888103bdf290] &sch->root_lock_key#3
> 
> and:
> 
> irq_context: 0
> [ffffffff83393d18] &inode->i_sb->s_type->i_mutex_dir_key
> [ffffffff84957a70] rcu_read_lock
> [ffffffff84957a70] rcu_read_lock
> [ffffffff84957a70] rcu_read_lock
> [ffffffff83ec00c0] &pool->lock
> [ffffffff83ebf240] &p->pi_lock
> [ffffffff83ec2a80] &rq->__lock
> [ffffffff849587b0] &____s->seqcount
> 
> and:
> 
> irq_context: 0
> [ffff888106344b38] (wq_completion)usb_hub_wq
> [ffffffff849b7700] (work_completion)(&hub->events)
> [ffffffff83ec6070] &dev->mutex
> [ffffffff83ec6070] &dev->mutex
> [ffffffff83ec6070] &dev->mutex
> [ffffffff83ec6070] &dev->mutex
> [ffffffff83438d68] dquirks_lock
> 
> All get extra chains because of the arguably pointless duplication in
> held locks.
> 
> 
> 
> Also, WTF is up with this lock name: :-)
> 
> irq_context: softirq
> [ffffffff84965400] &(({ do { const void *__vpp_verify = (typeof((&vmstat_work) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((&vmstat_work))) *)(( unsigned long)((&vmstat_work))))); (typeof((typeof(*((&vmstat_work))) *)(( unsigned long)((&vmstat_work))))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); }))->timer
> 

This comes from the INIT_DEFERREABLE_WORK() in start_shepherd_timer()
;-)

> 
> 
> It might make sense to collapse the rcu locks and count them at the
> first instance, instead of tracking them all on the held stack, hmm?
> 
> Something a little like the below. I suppose the only problem here is
> that we might miss the wait_type check, although I suppose we muck stuff
> around a bit more.
> 


No reason we cannot move the check_wait_context() before nesting
handling, right?

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f0226..67c0a68eee6b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5129,28 +5129,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
        if (DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH))
                return 0;

-       class_idx = class - lock_classes;
-
-       if (depth && !sync) {
-               /* we're holding locks and the new held lock is not a sync */
-               hlock = curr->held_locks + depth - 1;
-               if (hlock->class_idx == class_idx && nest_lock) {
-                       if (!references)
-                               references++;
-
-                       if (!hlock->references)
-                               hlock->references++;
-
-                       hlock->references += references;
-
-                       /* Overflow */
-                       if (DEBUG_LOCKS_WARN_ON(hlock->references < references))
-                               return 0;
-
-                       return 2;
-               }
-       }
-
        hlock = curr->held_locks + depth;
        /*
         * Plain impossible, we just registered it and checked it weren't no
@@ -5178,6 +5156,28 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
        if (check_wait_context(curr, hlock))
                return 0;

+       class_idx = class - lock_classes;
+
+       if (depth && !sync) {
+               /* we're holding locks and the new held lock is not a sync */
+               hlock = curr->held_locks + depth - 1;
+               if (hlock->class_idx == class_idx && nest_lock) {
+                       if (!references)
+                               references++;
+
+                       if (!hlock->references)
+                               hlock->references++;
+
+                       hlock->references += references;
+
+                       /* Overflow */
+                       if (DEBUG_LOCKS_WARN_ON(hlock->references < references))
+                               return 0;
+
+                       return 2;
+               }
+       }
+
        /* Initialize the lock usage bit */
        if (!mark_usage(curr, hlock, check))
                return 0;


Regards,
Boqun

> This isn't going to fix any big amount of resource usage; but all little
> bits help, right :-)
> 
> ---
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index 9f361d3ab9d9..a9849fea263b 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -81,6 +81,7 @@ struct lock_class_key {
>  
>  extern struct lock_class_key __lockdep_no_validate__;
>  extern struct lock_class_key __lockdep_no_track__;
> +extern struct lockdep_map    __lockdep_default_nest__;
>  
>  struct lock_trace;
>  
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 48e5c03df1dd..2c6b3b0da4f1 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -334,12 +334,12 @@ extern struct lockdep_map rcu_callback_map;
>  
>  static inline void rcu_lock_acquire(struct lockdep_map *map)
>  {
> -	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
> +	lock_acquire(map, 0, 0, 2, 0, &__lockdep_default_nest__, _THIS_IP_);
>  }
>  
>  static inline void rcu_try_lock_acquire(struct lockdep_map *map)
>  {
> -	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
> +	lock_acquire(map, 0, 1, 2, 0, &__lockdep_default_nest__, _THIS_IP_);
>  }
>  
>  static inline void rcu_lock_release(struct lockdep_map *map)
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index d7ba46e74f58..bcfba95fe14d 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -161,7 +161,7 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>  /* Annotates a srcu_read_lock() */
>  static inline void srcu_lock_acquire(struct lockdep_map *map)
>  {
> -	lock_map_acquire_read(map);
> +	lock_acquire(map, 0, 0, 2, 0, &__lockdep_default_nest__, _THIS_IP_);
>  }
>  
>  /* Annotates a srcu_read_lock() */
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index b15757e63626..d0c5799763cd 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5003,6 +5003,9 @@ EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
>  struct lock_class_key __lockdep_no_track__;
>  EXPORT_SYMBOL_GPL(__lockdep_no_track__);
>  
> +struct lockdep_map __lockdep_default_nest__ = { .name = "__lockdep_default_nest__" };
> +EXPORT_SYMBOL_GPL(__lockdep_default_nest__);
> +
>  #ifdef CONFIG_PROVE_LOCKING
>  void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
>  			     lock_print_fn print_fn)
> @@ -5067,6 +5070,9 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
>  
>  static int __lock_is_held(const struct lockdep_map *lock, int read);
>  
> +static struct held_lock *find_held_lock(struct task_struct *curr,
> +					struct lockdep_map *lock,
> +					unsigned int depth, int *idx);
>  /*
>   * This gets called for every mutex_lock*()/spin_lock*() operation.
>   * We maintain the dependency maps and validate the locking attempt:
> @@ -5099,6 +5105,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  	if (!prove_locking || lock->key == &__lockdep_no_validate__) {
>  		check = 0;
>  		lockevent_inc(lockdep_nocheck);
> +		nest_lock = &__lockdep_default_nest__;
>  	}
>  
>  	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
> @@ -5138,10 +5145,16 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  
>  	class_idx = class - lock_classes;
>  
> -	if (depth && !sync) {
> -		/* we're holding locks and the new held lock is not a sync */
> -		hlock = curr->held_locks + depth - 1;
> -		if (hlock->class_idx == class_idx && nest_lock) {
> +	if (nest_lock && depth && !sync) {
> +		if (nest_lock == &__lockdep_default_nest__) {
> +			hlock = find_held_lock(curr, lock, depth, NULL);
> +		} else {
> +			hlock = curr->held_locks + depth - 1;
> +			if (hlock->class_idx != class_idx)
> +				hlock = NULL;
> +		}
> +
> +		if (hlock) {
>  			if (!references)
>  				references++;
>  
> @@ -5222,7 +5235,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  	}
>  	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
>  
> -	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
> +	if (nest_lock &&
> +	    nest_lock != &__lockdep_default_nest__ &&
> +	    !__lock_is_held(nest_lock, -1)) {
>  		print_lock_nested_lock_not_held(curr, hlock);
>  		return 0;
>  	}
> @@ -5366,7 +5381,8 @@ static struct held_lock *find_held_lock(struct task_struct *curr,
>  	}
>  
>  out:
> -	*idx = i;
> +	if (idx)
> +		*idx = i;
>  	return ret;
>  }
>  

