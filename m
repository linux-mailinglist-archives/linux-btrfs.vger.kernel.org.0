Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046A033C439
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhCORcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 13:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234836AbhCORcI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 13:32:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE55F64E98;
        Mon, 15 Mar 2021 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615829527;
        bh=VRcbQL7CvY6cs5rG3WUG31fwN9zEEEuuniKBvXrs38c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ITjF77TLcgpBt5MuUWlr0DwatVKlFdMISr/3LmxHyhyFvMKGp6gQn80vGywiW0w31
         FpvxijhAGClviF7uDoWK4gaNArg84LppRmlLJXz+bXRoR+3VI0gmSLvMzM1Jm+MI2k
         dg5X5Vzjqe7zn6MVXxbrVduAvjWqo4i+ifgAhjpEuiRoSMYr3tJI5wEWwJTNa/HqEi
         0OCY1UxilLOOXcKbekTTfRzdVb+ikDVwpmIBG4uAdnDY+8YX6CRPv6nNkwRmeqlVBM
         iNLMRzVpYdBXNd8lOlY0wv4gXJ3TXHPQLHcGR2m8m/W9g52M3h5dKTLxxL6HXZU8aJ
         94TUcdCYK9HNg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 67894352261C; Mon, 15 Mar 2021 10:32:07 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:32:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Oliver Glitta <glittao@gmail.com>
Subject: Re: [PATCH] [PATCH] mm, slub: enable slub_debug static key when
 creating cache with explicit debug flags
Message-ID: <20210315173207.GN2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210315153415.24404-1-vbabka@suse.cz>
 <2d80f81a-ed85-a36f-6527-b75da3ae209e@google.com>
 <e723d919-222a-0675-5aae-44dfe1ce005f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e723d919-222a-0675-5aae-44dfe1ce005f@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 15, 2021 at 06:28:42PM +0100, Vlastimil Babka wrote:
> On 3/15/21 6:16 PM, David Rientjes wrote:
> > On Mon, 15 Mar 2021, Vlastimil Babka wrote:
> > 
> >> Commit ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
> >> introduced a static key to optimize the case where no debugging is enabled for
> >> any cache. The static key is enabled when slub_debug boot parameter is passed,
> >> or CONFIG_SLUB_DEBUG_ON enabled.
> >> 
> >> However, some caches might be created with one or more debugging flags
> >> explicitly passed to kmem_cache_create(), and the commit missed this. Thus the
> >> debugging functionality would not be actually performed for these caches unless
> >> the static key gets enabled by boot param or config.
> >> 
> >> This patch fixes it by checking for debugging flags passed to
> >> kmem_cache_create() and enabling the static key accordingly.
> >> 
> >> Note such explicit debugging flags should not be used outside of debugging and
> >> testing as they will now enable the static key globally. btrfs_init_cachep()
> >> creates a cache with SLAB_RED_ZONE but that's a mistake that's being corrected
> >> [1]. rcu_torture_stats() creates a cache with SLAB_STORE_USER, but that is a
> >> testing module so it's OK and will start working as intended after this patch.
> >> 
> >> Also note that in case of backports to kernels before v5.12 that don't have
> >> 59450bbc12be ("mm, slab, slub: stop taking cpu hotplug lock"),
> >> static_branch_enable_cpuslocked() should be used.
> >> 
> > 
> > Since this affects 5.9+, is the plan to propose backports to stable with 
> > static_branch_enable_cpuslocked() once this is merged?  (I notice the 
> > absence of the stable tag here, which I believe is intended.)
> 
> I was thinking about it, and since the rcutorture user is only in -next (AFAICS)
> and btrfs user was unintended, it didn't seem to meet stable criteria to me. But
> I won't mind if it's backported.

I had better ask...  Should rcutorture be doing something different?

							Thanx, Paul

> >> [1] https://lore.kernel.org/linux-btrfs/20210315141824.26099-1-dsterba@suse.com/
> >> 
> >> Reported-by: Oliver Glitta <glittao@gmail.com>
> >> Fixes: ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Acked-by: David Rientjes <rientjes@google.com>
> 
> Thanks!
> 
> >> ---
> >>  mm/slub.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 350a37f30e60..cd6694ad1a0a 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -3827,6 +3827,15 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >>  
> >>  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >>  {
> >> +#ifdef CONFIG_SLUB_DEBUG
> >> +	/*
> >> +	 * If no slub_debug was enabled globally, the static key is not yet
> >> +	 * enabled by setup_slub_debug(). Enable it if the cache is being
> >> +	 * created with any of the debugging flags passed explicitly.
> >> +	 */
> >> +	if (flags & SLAB_DEBUG_FLAGS)
> >> +		static_branch_enable(&slub_debug_enabled);
> >> +#endif
> >>  	s->flags = kmem_cache_flags(s->size, flags, s->name);
> >>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> >>  	s->random = get_random_long();
> > 
> 
