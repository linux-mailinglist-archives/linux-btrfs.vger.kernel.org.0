Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1259730F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiHQPch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiHQPce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 11:32:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB79DB61
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 08:32:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t22so12811079pjy.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KWQa5ElD0+1EZZYhMiZLxgs06gnlccOot4jW+aqqSO0=;
        b=SFuQs8l/1MCvsd+QY2bzzRiXT5OfnZWTr2mY8czcFY5XXZUJg5+eNXZ8YgTagcNZO1
         zhM1Pue8P39QfLWw9GCFunXuxtPzY1u15n+SgucSrFY5YLdMvOw4qyo0Za3Z5CBgvtXL
         GaXD5bR7HEdzZbVFryxDuHmiKKxAtbIex/zOCTbrM0ZPOXWcfDSRQ4sC7ahmZOYtqc5o
         84A1s7RHDEitJ8KKJcH6ipBNw5bmyk0sBq7FALRcbtiDHknwglTfTs1+jwCKjvNsm/Gs
         n+41ZoQPd8t02CbvOkf1vZSy5dPsPDRxKgm8vizyejRFQ3WVgES6eCmzGsTDokwLqEer
         Ej9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KWQa5ElD0+1EZZYhMiZLxgs06gnlccOot4jW+aqqSO0=;
        b=QnKlZIJkgojRFx+0wWD0dJx7q9BebabeIV4jnW0t8dwC7PS2dpn4vE+fX90DGATLA1
         azuSfEYelGiCcEWJAh7F8hcdLPzoLViCU3PkmRGAnKQLQVhCvl2eS3e1Iit83p1qF+s8
         xHsSZuxDbeYYcul+6xipc4gQKsebbt8AvOU7wDGirxbLO6dAvhusYzB1g3DgmQ+KMqkE
         S/sciQSv/XDpf3XADrRQg9v/YlyhiirANiindYTjDDtU2cdl0NwHIXzCTvb8GTIq7h2W
         lPbrLIgyiv6o6UOhGMpREyPo3HYL308nMvT+irhriWZm5w84cCcogDTKrjC9qapyFqVp
         jMeQ==
X-Gm-Message-State: ACgBeo12cmbMZvfG2NHuXVTbty8upSSP8v2R+ly26sbQlwsK4DA3Lpfc
        Pcs9pIpz0lK97aLlQYO+/JHNxg==
X-Google-Smtp-Source: AA6agR4q13Hi51lEfZv3QLTJEoRBe4aCRTHz/wXGXpjyPr3UY5Ly8j7WI1BzPX8ol7YplLcObAF7ww==
X-Received: by 2002:a17:902:a5cc:b0:170:d1cf:ac83 with SMTP id t12-20020a170902a5cc00b00170d1cfac83mr26395478plq.14.1660750352098;
        Wed, 17 Aug 2022 08:32:32 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:a300:cc0::f972])
        by smtp.gmail.com with ESMTPSA id y198-20020a6264cf000000b0052d4ffac466sm10526076pfb.188.2022.08.17.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 08:32:31 -0700 (PDT)
Date:   Wed, 17 Aug 2022 08:32:30 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <Yv0KDifyJLPyjVnp@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <20220817094708.GA2815552@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817094708.GA2815552@falcondesktop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 10:47:08AM +0100, Filipe Manana wrote:
> On Tue, Aug 16, 2022 at 04:12:15PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > When testing space_cache v2 on a large set of machines, we encountered a
> > few symptoms:
> > 
> > 1. "unable to add free space :-17" (EEXIST) errors.
> > 2. Missing free space info items, sometimes caught with a "missing free
> >    space info for X" error.
> > 3. Double-accounted space: ranges that were allocated in the extent tree
> >    and also marked as free in the free space tree, ranges that were
> >    marked as allocated twice in the extent tree, or ranges that were
> >    marked as free twice in the free space tree. If the latter made it
> >    onto disk, the next reboot would hit the BUG_ON() in
> >    add_new_free_space().
> > 4. On some hosts with no on-disk corruption or error messages, the
> >    in-memory space cache (dumped with drgn) disagreed with the free
> >    space tree.
> > 
> > All of these symptoms have the same underlying cause: a race between
> > caching the free space for a block group and returning free space to the
> > in-memory space cache for pinned extents causes us to double-add a free
> > range to the space cache. This race exists when free space is cached
> > from the free space tree (space_cache=v2) or the extent tree
> > (nospace_cache, or space_cache=v1 if the cache needs to be regenerated).
> > struct btrfs_block_group::last_byte_to_unpin and struct
> > btrfs_block_group::progress are supposed to protect against this race,
> > but commit d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when
> > waiting for a transaction commit") subtly broke this by allowing
> > multiple transactions to be unpinning extents at the same time.
> > 
> > Specifically, the race is as follows:
> > 
> > 1. An extent is deleted from an uncached block group in transaction A.
> > 2. btrfs_commit_transaction() is called for transaction A.
> > 3. btrfs_run_delayed_refs() -> __btrfs_free_extent() runs the delayed
> >    ref for the deleted extent.
> > 4. __btrfs_free_extent() -> do_free_extent_accounting() ->
> >    add_to_free_space_tree() adds the deleted extent back to the free
> >    space tree.
> > 5. do_free_extent_accounting() -> btrfs_update_block_group() ->
> >    btrfs_cache_block_group() queues up the block group to get cached.
> >    block_group->progress is set to block_group->start.
> > 6. btrfs_commit_transaction() for transaction A calls
> >    switch_commit_roots(). It sets block_group->last_byte_to_unpin to
> >    block_group->progress, which is block_group->start because the block
> >    group hasn't been cached yet.
> > 7. The caching thread gets to our block group. Since the commit roots
> >    were already switched, load_free_space_tree() sees the deleted extent
> >    as free and adds it to the space cache. It finishes caching and sets
> >    block_group->progress to U64_MAX.
> > 8. btrfs_commit_transaction() advances transaction A to
> >    TRANS_STATE_SUPER_COMMITTED.
> > 9. fsync calls btrfs_commit_transaction() for transaction B. Since
> >    transaction A is already in TRANS_STATE_SUPER_COMMITTED and the
> >    commit is for fsync, it advances.
> > 10. btrfs_commit_transaction() for transaction B calls
> >     switch_commit_roots(). This time, the block group has already been
> >     cached, so it sets block_group->last_byte_to_unpin to U64_MAX.
> > 11. btrfs_commit_transaction() for transaction A calls
> >     btrfs_finish_extent_commit(), which calls unpin_extent_range() for
> >     the deleted extent. It sees last_byte_to_unpin set to U64_MAX (by
> >     transaction B!), so it adds the deleted extent to the space cache
> >     again!
> > 
> > This explains all of our symptoms above:
> > 
> > * If the sequence of events is exactly as described above, when the free
> >   space is re-added in step 11, it will fail with EEXIST.
> > * If another thread reallocates the deleted extent in between steps 7
> >   and 11, then step 11 will silently re-add that space to the space
> >   cache as free even though it is actually allocated. Then, if that
> >   space is allocated *again*, the free space tree will be corrupted
> >  (namely, the wrong item will be deleted).
> > * If we don't catch this free space tree corruption, it will continue
> >   to get worse as extents are deleted and reallocated.
> > 
> > The v1 space_cache is synchronously loaded when an extent is deleted
> > (btrfs_update_block_group() with alloc=0 calls btrfs_cache_block_group()
> > with load_cache_only=1), so it is not normally affected by this bug.
> > However, as noted above, if we fail to load the space cache, we will
> > fall back to caching from the extent tree and may hit this bug.
> > 
> > The easiest fix for this race is to also make caching from the free
> > space tree or extent tree synchronous. Josef tested this and found no
> > performance regressions.
> > 
> > A few extra changes fall out of this change. Namely, this fix does the
> > following, with step 2 being the crucial fix:
> > 
> > 1. Factor btrfs_caching_ctl_wait_done() out of
> >    btrfs_wait_block_group_cache_done() to allow waiting on a caching_ctl
> >    that we already hold a reference to.
> > 2. Change the call in btrfs_cache_block_group() of
> >    btrfs_wait_space_cache_v1_finished() to
> >    btrfs_caching_ctl_wait_done(), which makes us wait regardless of the
> >    space_cache option.
> > 3. Delete the now unused btrfs_wait_space_cache_v1_finished() and
> >    space_cache_v1_done().
> > 4. Change btrfs_cache_block_group()'s `int load_cache_only` parameter to
> >    `bool wait` to more accurately describe its new meaning.
> > 5. Change a few callers which had a separate call to
> >    btrfs_wait_block_group_cache_done() to use wait = true instead.
> > 6. Make btrfs_wait_block_group_cache_done() static now that it's not
> >    used outside of block-group.c anymore.
> > 
> > Fixes: d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when waiting for a transaction commit")
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Looks good to me, thanks for fixing this and the very detailed analysis.
> Only one comment inlined below, which is not critical, so:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> > ---
> >  fs/btrfs/block-group.c | 36 ++++++++++++++----------------------
> >  fs/btrfs/block-group.h |  3 +--
> >  fs/btrfs/extent-tree.c | 30 ++++++------------------------
> >  3 files changed, 21 insertions(+), 48 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index c8162b8d85a2..1af6fc395a52 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -440,33 +440,26 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
> >  	btrfs_put_caching_control(caching_ctl);
> >  }
> >  
> > -int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
> > +static int btrfs_caching_ctl_wait_done(struct btrfs_block_group *cache,
> > +				      struct btrfs_caching_control *caching_ctl)
> > +{
> > +	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
> > +	return cache->cached == BTRFS_CACHE_ERROR ? -EIO : 0;
> > +}
> > +
> > +static int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
> >  {
> >  	struct btrfs_caching_control *caching_ctl;
> > -	int ret = 0;
> > +	int ret;
> >  
> >  	caching_ctl = btrfs_get_caching_control(cache);
> >  	if (!caching_ctl)
> >  		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
> > -
> > -	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
> > -	if (cache->cached == BTRFS_CACHE_ERROR)
> > -		ret = -EIO;
> > +	ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
> >  	btrfs_put_caching_control(caching_ctl);
> >  	return ret;
> >  }
> >  
> > -static bool space_cache_v1_done(struct btrfs_block_group *cache)
> > -{
> > -	bool ret;
> > -
> > -	spin_lock(&cache->lock);
> > -	ret = cache->cached != BTRFS_CACHE_FAST;
> 
> This BTRFS_CACHE_FAST state now becomes useless.
> Any reason you didn't remove it?
> Something like this on top of this patch:
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c8162b8d85a2..9b2314f6ffed 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -779,10 +779,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
>         }
>         WARN_ON(cache->caching_ctl);
>         cache->caching_ctl = caching_ctl;
> -       if (btrfs_test_opt(fs_info, SPACE_CACHE))
> -               cache->cached = BTRFS_CACHE_FAST;
> -       else
> -               cache->cached = BTRFS_CACHE_STARTED;
> +       cache->cached = BTRFS_CACHE_STARTED;
>         spin_unlock(&cache->lock);
>  
>         write_lock(&fs_info->block_group_cache_lock);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 51c480439263..0fe5f68aadc2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -505,7 +505,6 @@ struct btrfs_free_cluster {
>  enum btrfs_caching_type {
>         BTRFS_CACHE_NO,
>         BTRFS_CACHE_STARTED,
> -       BTRFS_CACHE_FAST,
>         BTRFS_CACHE_FINISHED,
>         BTRFS_CACHE_ERROR,
>  };

You're right, I missed that. I can add that as another followup cleanup
patch unless you want to send it.
