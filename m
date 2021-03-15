Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03433C427
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 18:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhCOR3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 13:29:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:48748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236043AbhCOR2s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 13:28:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2785AE3D;
        Mon, 15 Mar 2021 17:28:46 +0000 (UTC)
Subject: Re: [PATCH] [PATCH] mm, slub: enable slub_debug static key when
 creating cache with explicit debug flags
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Oliver Glitta <glittao@gmail.com>
References: <20210315153415.24404-1-vbabka@suse.cz>
 <2d80f81a-ed85-a36f-6527-b75da3ae209e@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e723d919-222a-0675-5aae-44dfe1ce005f@suse.cz>
Date:   Mon, 15 Mar 2021 18:28:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2d80f81a-ed85-a36f-6527-b75da3ae209e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/15/21 6:16 PM, David Rientjes wrote:
> On Mon, 15 Mar 2021, Vlastimil Babka wrote:
> 
>> Commit ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
>> introduced a static key to optimize the case where no debugging is enabled for
>> any cache. The static key is enabled when slub_debug boot parameter is passed,
>> or CONFIG_SLUB_DEBUG_ON enabled.
>> 
>> However, some caches might be created with one or more debugging flags
>> explicitly passed to kmem_cache_create(), and the commit missed this. Thus the
>> debugging functionality would not be actually performed for these caches unless
>> the static key gets enabled by boot param or config.
>> 
>> This patch fixes it by checking for debugging flags passed to
>> kmem_cache_create() and enabling the static key accordingly.
>> 
>> Note such explicit debugging flags should not be used outside of debugging and
>> testing as they will now enable the static key globally. btrfs_init_cachep()
>> creates a cache with SLAB_RED_ZONE but that's a mistake that's being corrected
>> [1]. rcu_torture_stats() creates a cache with SLAB_STORE_USER, but that is a
>> testing module so it's OK and will start working as intended after this patch.
>> 
>> Also note that in case of backports to kernels before v5.12 that don't have
>> 59450bbc12be ("mm, slab, slub: stop taking cpu hotplug lock"),
>> static_branch_enable_cpuslocked() should be used.
>> 
> 
> Since this affects 5.9+, is the plan to propose backports to stable with 
> static_branch_enable_cpuslocked() once this is merged?  (I notice the 
> absence of the stable tag here, which I believe is intended.)

I was thinking about it, and since the rcutorture user is only in -next (AFAICS)
and btrfs user was unintended, it didn't seem to meet stable criteria to me. But
I won't mind if it's backported.

>> [1] https://lore.kernel.org/linux-btrfs/20210315141824.26099-1-dsterba@suse.com/
>> 
>> Reported-by: Oliver Glitta <glittao@gmail.com>
>> Fixes: ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks!

>> ---
>>  mm/slub.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 350a37f30e60..cd6694ad1a0a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3827,6 +3827,15 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>>  
>>  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>  {
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	/*
>> +	 * If no slub_debug was enabled globally, the static key is not yet
>> +	 * enabled by setup_slub_debug(). Enable it if the cache is being
>> +	 * created with any of the debugging flags passed explicitly.
>> +	 */
>> +	if (flags & SLAB_DEBUG_FLAGS)
>> +		static_branch_enable(&slub_debug_enabled);
>> +#endif
>>  	s->flags = kmem_cache_flags(s->size, flags, s->name);
>>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>>  	s->random = get_random_long();
> 

