Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AADE33C3F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 18:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhCORQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhCORQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 13:16:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C2C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 10:16:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o10so3431794plg.11
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vkbgOXNRjmxTcw1oc4wVA8/mmcZsN9FbZ3cSv6WDfss=;
        b=vHGrIXtbAnB0hsWFkRVsBVtDapqSeQHP9YPXjdXzuGzaReV6xIo5HCJXKVwi7/3Eij
         cJSNy9cqf2x5xni7GXxxGfmNtjAglgbxHox2FOwrJ6vR2XDTBSzeAa4lgZR+3JgoksTT
         mDzdOjPd15zKTeTQFlf4RHgdBM0r62m9L+juaXMmZbB8yKsS1JvyIsgUJhaNveU6ktLF
         MmD/d60dPSRQKAseQOCk15PbyOx25nN6AgjMebpx9+jdWJjap/u0L1Rc9va8LuZp/cez
         5j4vr76o6VEwT9epPVvwtyF9OQUfTOgFJR8G3fFTt4iYkrRWe3BnUYiX1WVPUlBKte5u
         agQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vkbgOXNRjmxTcw1oc4wVA8/mmcZsN9FbZ3cSv6WDfss=;
        b=MxE3QEP++IHK5+I5+XB7C5X3lND997WMiajf3oGgjulX0c2B+00c6MJbemp3s8EMaw
         WtfFmWfEDEkVPUlY1Ya1iHFJMoQxklwrD9/6kD2nDubo6bjyQ+7z5TTn08hunEKpmBwh
         /G2EuMY6Cu0fiTTzFZCFi7ft6UMavNywUIXJBjnG4dy6sEIkLYIPLKLYK79k9kAcqT1r
         FeiuStjCh2csJC12OuFhwvlbQ39GtvpYt/LRUAVS/ynfL0ZlyQHXHTBlRhcRlSc78GLs
         tSFNrBQbkW+qGIggUpT5yBdkbbzNrw83bl0zSq5UjuqKhMpT1jwr9ifEGDMd8nJvQuFS
         +fFQ==
X-Gm-Message-State: AOAM533uDjX6NRUEUcisrz9kopVQtXkNtzfrwFIpsEhBq42dCBJKZye+
        P97m/FXHk4SiMOYtY7QGNYwXEg==
X-Google-Smtp-Source: ABdhPJynimVWlz2D9pxTZJUTa2nWLBJAmcFtq7xh/TIQTYYAUqAXCU+Nu07rPMO12pC4brn1UhRr1Q==
X-Received: by 2002:a17:90a:b293:: with SMTP id c19mr58684pjr.193.1615828574415;
        Mon, 15 Mar 2021 10:16:14 -0700 (PDT)
Received: from [2620:15c:17:3:15aa:7e35:d042:44e5] ([2620:15c:17:3:15aa:7e35:d042:44e5])
        by smtp.gmail.com with ESMTPSA id h6sm14006271pfb.157.2021.03.15.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:16:13 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:16:13 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Oliver Glitta <glittao@gmail.com>
Subject: Re: [PATCH] [PATCH] mm, slub: enable slub_debug static key when
 creating cache with explicit debug flags
In-Reply-To: <20210315153415.24404-1-vbabka@suse.cz>
Message-ID: <2d80f81a-ed85-a36f-6527-b75da3ae209e@google.com>
References: <20210315153415.24404-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 15 Mar 2021, Vlastimil Babka wrote:

> Commit ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
> introduced a static key to optimize the case where no debugging is enabled for
> any cache. The static key is enabled when slub_debug boot parameter is passed,
> or CONFIG_SLUB_DEBUG_ON enabled.
> 
> However, some caches might be created with one or more debugging flags
> explicitly passed to kmem_cache_create(), and the commit missed this. Thus the
> debugging functionality would not be actually performed for these caches unless
> the static key gets enabled by boot param or config.
> 
> This patch fixes it by checking for debugging flags passed to
> kmem_cache_create() and enabling the static key accordingly.
> 
> Note such explicit debugging flags should not be used outside of debugging and
> testing as they will now enable the static key globally. btrfs_init_cachep()
> creates a cache with SLAB_RED_ZONE but that's a mistake that's being corrected
> [1]. rcu_torture_stats() creates a cache with SLAB_STORE_USER, but that is a
> testing module so it's OK and will start working as intended after this patch.
> 
> Also note that in case of backports to kernels before v5.12 that don't have
> 59450bbc12be ("mm, slab, slub: stop taking cpu hotplug lock"),
> static_branch_enable_cpuslocked() should be used.
> 

Since this affects 5.9+, is the plan to propose backports to stable with 
static_branch_enable_cpuslocked() once this is merged?  (I notice the 
absence of the stable tag here, which I believe is intended.)

> [1] https://lore.kernel.org/linux-btrfs/20210315141824.26099-1-dsterba@suse.com/
> 
> Reported-by: Oliver Glitta <glittao@gmail.com>
> Fixes: ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>

> ---
>  mm/slub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 350a37f30e60..cd6694ad1a0a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3827,6 +3827,15 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  
>  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  {
> +#ifdef CONFIG_SLUB_DEBUG
> +	/*
> +	 * If no slub_debug was enabled globally, the static key is not yet
> +	 * enabled by setup_slub_debug(). Enable it if the cache is being
> +	 * created with any of the debugging flags passed explicitly.
> +	 */
> +	if (flags & SLAB_DEBUG_FLAGS)
> +		static_branch_enable(&slub_debug_enabled);
> +#endif
>  	s->flags = kmem_cache_flags(s->size, flags, s->name);
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	s->random = get_random_long();
