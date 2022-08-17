Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C719596C4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiHQJrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiHQJrP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 05:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53856AA38
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 02:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D4261448
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 09:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E71C433D6;
        Wed, 17 Aug 2022 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660729631;
        bh=bRDQpfVKJEnC4Kuc2aMdylsWGyTsczE95NSKKVrJngM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKvLtp9ttz7sCsQevCENnCqYPu+NGFDlXGAKDoIu7hGT6D2rbkqHJiMxU+K5b2+JI
         fnfoZLYnV8QpjPR0o0Eap5/jgiHs8GfWz5IkMtFdAhAOEcsq37eDXEzthcEJk0glVX
         Kr0ZQwQDqfO4GVi7dTdCzQOc7zO0mZryOFLhgiJAlWiBc3Gi6GjAwHXVmmyCiWMyI6
         rn18pyeB4CTYXygtNMD7hFVJUf/kmHvTXr7CH2nv3p7Zumqdem2B9+VMRPPEWjciCB
         +9rv4gBw0ayJMPrwcnRJZgfoD/9js2JwcU91OeMGHMhluQJRRRBnBec75SxztTfX1B
         DK+5IBIxLyWkA==
Date:   Wed, 17 Aug 2022 10:47:08 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <20220817094708.GA2815552@falcondesktop>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 04:12:15PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When testing space_cache v2 on a large set of machines, we encountered a
> few symptoms:
> 
> 1. "unable to add free space :-17" (EEXIST) errors.
> 2. Missing free space info items, sometimes caught with a "missing free
>    space info for X" error.
> 3. Double-accounted space: ranges that were allocated in the extent tree
>    and also marked as free in the free space tree, ranges that were
>    marked as allocated twice in the extent tree, or ranges that were
>    marked as free twice in the free space tree. If the latter made it
>    onto disk, the next reboot would hit the BUG_ON() in
>    add_new_free_space().
> 4. On some hosts with no on-disk corruption or error messages, the
>    in-memory space cache (dumped with drgn) disagreed with the free
>    space tree.
> 
> All of these symptoms have the same underlying cause: a race between
> caching the free space for a block group and returning free space to the
> in-memory space cache for pinned extents causes us to double-add a free
> range to the space cache. This race exists when free space is cached
> from the free space tree (space_cache=v2) or the extent tree
> (nospace_cache, or space_cache=v1 if the cache needs to be regenerated).
> struct btrfs_block_group::last_byte_to_unpin and struct
> btrfs_block_group::progress are supposed to protect against this race,
> but commit d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when
> waiting for a transaction commit") subtly broke this by allowing
> multiple transactions to be unpinning extents at the same time.
> 
> Specifically, the race is as follows:
> 
> 1. An extent is deleted from an uncached block group in transaction A.
> 2. btrfs_commit_transaction() is called for transaction A.
> 3. btrfs_run_delayed_refs() -> __btrfs_free_extent() runs the delayed
>    ref for the deleted extent.
> 4. __btrfs_free_extent() -> do_free_extent_accounting() ->
>    add_to_free_space_tree() adds the deleted extent back to the free
>    space tree.
> 5. do_free_extent_accounting() -> btrfs_update_block_group() ->
>    btrfs_cache_block_group() queues up the block group to get cached.
>    block_group->progress is set to block_group->start.
> 6. btrfs_commit_transaction() for transaction A calls
>    switch_commit_roots(). It sets block_group->last_byte_to_unpin to
>    block_group->progress, which is block_group->start because the block
>    group hasn't been cached yet.
> 7. The caching thread gets to our block group. Since the commit roots
>    were already switched, load_free_space_tree() sees the deleted extent
>    as free and adds it to the space cache. It finishes caching and sets
>    block_group->progress to U64_MAX.
> 8. btrfs_commit_transaction() advances transaction A to
>    TRANS_STATE_SUPER_COMMITTED.
> 9. fsync calls btrfs_commit_transaction() for transaction B. Since
>    transaction A is already in TRANS_STATE_SUPER_COMMITTED and the
>    commit is for fsync, it advances.
> 10. btrfs_commit_transaction() for transaction B calls
>     switch_commit_roots(). This time, the block group has already been
>     cached, so it sets block_group->last_byte_to_unpin to U64_MAX.
> 11. btrfs_commit_transaction() for transaction A calls
>     btrfs_finish_extent_commit(), which calls unpin_extent_range() for
>     the deleted extent. It sees last_byte_to_unpin set to U64_MAX (by
>     transaction B!), so it adds the deleted extent to the space cache
>     again!
> 
> This explains all of our symptoms above:
> 
> * If the sequence of events is exactly as described above, when the free
>   space is re-added in step 11, it will fail with EEXIST.
> * If another thread reallocates the deleted extent in between steps 7
>   and 11, then step 11 will silently re-add that space to the space
>   cache as free even though it is actually allocated. Then, if that
>   space is allocated *again*, the free space tree will be corrupted
>  (namely, the wrong item will be deleted).
> * If we don't catch this free space tree corruption, it will continue
>   to get worse as extents are deleted and reallocated.
> 
> The v1 space_cache is synchronously loaded when an extent is deleted
> (btrfs_update_block_group() with alloc=0 calls btrfs_cache_block_group()
> with load_cache_only=1), so it is not normally affected by this bug.
> However, as noted above, if we fail to load the space cache, we will
> fall back to caching from the extent tree and may hit this bug.
> 
> The easiest fix for this race is to also make caching from the free
> space tree or extent tree synchronous. Josef tested this and found no
> performance regressions.
> 
> A few extra changes fall out of this change. Namely, this fix does the
> following, with step 2 being the crucial fix:
> 
> 1. Factor btrfs_caching_ctl_wait_done() out of
>    btrfs_wait_block_group_cache_done() to allow waiting on a caching_ctl
>    that we already hold a reference to.
> 2. Change the call in btrfs_cache_block_group() of
>    btrfs_wait_space_cache_v1_finished() to
>    btrfs_caching_ctl_wait_done(), which makes us wait regardless of the
>    space_cache option.
> 3. Delete the now unused btrfs_wait_space_cache_v1_finished() and
>    space_cache_v1_done().
> 4. Change btrfs_cache_block_group()'s `int load_cache_only` parameter to
>    `bool wait` to more accurately describe its new meaning.
> 5. Change a few callers which had a separate call to
>    btrfs_wait_block_group_cache_done() to use wait = true instead.
> 6. Make btrfs_wait_block_group_cache_done() static now that it's not
>    used outside of block-group.c anymore.
> 
> Fixes: d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when waiting for a transaction commit")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Looks good to me, thanks for fixing this and the very detailed analysis.
Only one comment inlined below, which is not critical, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/block-group.c | 36 ++++++++++++++----------------------
>  fs/btrfs/block-group.h |  3 +--
>  fs/btrfs/extent-tree.c | 30 ++++++------------------------
>  3 files changed, 21 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c8162b8d85a2..1af6fc395a52 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -440,33 +440,26 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
>  	btrfs_put_caching_control(caching_ctl);
>  }
>  
> -int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
> +static int btrfs_caching_ctl_wait_done(struct btrfs_block_group *cache,
> +				      struct btrfs_caching_control *caching_ctl)
> +{
> +	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
> +	return cache->cached == BTRFS_CACHE_ERROR ? -EIO : 0;
> +}
> +
> +static int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_caching_control *caching_ctl;
> -	int ret = 0;
> +	int ret;
>  
>  	caching_ctl = btrfs_get_caching_control(cache);
>  	if (!caching_ctl)
>  		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
> -
> -	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
> -	if (cache->cached == BTRFS_CACHE_ERROR)
> -		ret = -EIO;
> +	ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
>  	btrfs_put_caching_control(caching_ctl);
>  	return ret;
>  }
>  
> -static bool space_cache_v1_done(struct btrfs_block_group *cache)
> -{
> -	bool ret;
> -
> -	spin_lock(&cache->lock);
> -	ret = cache->cached != BTRFS_CACHE_FAST;

This BTRFS_CACHE_FAST state now becomes useless.
Any reason you didn't remove it?
Something like this on top of this patch:

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c8162b8d85a2..9b2314f6ffed 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -779,10 +779,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
        }
        WARN_ON(cache->caching_ctl);
        cache->caching_ctl = caching_ctl;
-       if (btrfs_test_opt(fs_info, SPACE_CACHE))
-               cache->cached = BTRFS_CACHE_FAST;
-       else
-               cache->cached = BTRFS_CACHE_STARTED;
+       cache->cached = BTRFS_CACHE_STARTED;
        spin_unlock(&cache->lock);
 
        write_lock(&fs_info->block_group_cache_lock);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 51c480439263..0fe5f68aadc2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -505,7 +505,6 @@ struct btrfs_free_cluster {
 enum btrfs_caching_type {
        BTRFS_CACHE_NO,
        BTRFS_CACHE_STARTED,
-       BTRFS_CACHE_FAST,
        BTRFS_CACHE_FINISHED,
        BTRFS_CACHE_ERROR,
 };


> -	spin_unlock(&cache->lock);
> -
> -	return ret;
> -}
> -
>  #ifdef CONFIG_BTRFS_DEBUG
>  static void fragment_free_space(struct btrfs_block_group *block_group)
>  {
> @@ -744,9 +737,8 @@ static noinline void caching_thread(struct btrfs_work *work)
>  	btrfs_put_block_group(block_group);
>  }
>  
> -int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only)
> +int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
>  {
> -	DEFINE_WAIT(wait);
>  	struct btrfs_fs_info *fs_info = cache->fs_info;
>  	struct btrfs_caching_control *caching_ctl = NULL;
>  	int ret = 0;
> @@ -794,8 +786,8 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
>  
>  	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
>  out:
> -	if (load_cache_only && caching_ctl)
> -		wait_event(caching_ctl->wait, space_cache_v1_done(cache));
> +	if (wait && caching_ctl)
> +		ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
>  	if (caching_ctl)
>  		btrfs_put_caching_control(caching_ctl);
>  
> @@ -3288,7 +3280,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		 * space back to the block group, otherwise we will leak space.
>  		 */
>  		if (!alloc && !btrfs_block_group_done(cache))
> -			btrfs_cache_block_group(cache, 1);
> +			btrfs_cache_block_group(cache, true);
>  
>  		byte_in_group = bytenr - cache->start;
>  		WARN_ON(byte_in_group > cache->length);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index b5c8425839dc..9dba28bb1806 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -267,9 +267,8 @@ void btrfs_dec_nocow_writers(struct btrfs_block_group *bg);
>  void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
>  void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
>  				           u64 num_bytes);
> -int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache);
>  int btrfs_cache_block_group(struct btrfs_block_group *cache,
> -			    int load_cache_only);
> +			    bool wait);
>  void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
>  struct btrfs_caching_control *btrfs_get_caching_control(
>  		struct btrfs_block_group *cache);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 7bb05d49809b..86ac953c69ac 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2551,17 +2551,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
>  		return -EINVAL;
>  
>  	/*
> -	 * pull in the free space cache (if any) so that our pin
> -	 * removes the free space from the cache.  We have load_only set
> -	 * to one because the slow code to read in the free extents does check
> -	 * the pinned extents.
> +	 * Fully cache the free space first so that our pin removes the free space
> +	 * from the cache.
>  	 */
> -	btrfs_cache_block_group(cache, 1);
> -	/*
> -	 * Make sure we wait until the cache is completely built in case it is
> -	 * missing or is invalid and therefore needs to be rebuilt.
> -	 */
> -	ret = btrfs_wait_block_group_cache_done(cache);
> +	ret = btrfs_cache_block_group(cache, true);
>  	if (ret)
>  		goto out;
>  
> @@ -2584,12 +2577,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
>  	if (!block_group)
>  		return -EINVAL;
>  
> -	btrfs_cache_block_group(block_group, 1);
> -	/*
> -	 * Make sure we wait until the cache is completely built in case it is
> -	 * missing or is invalid and therefore needs to be rebuilt.
> -	 */
> -	ret = btrfs_wait_block_group_cache_done(block_group);
> +	ret = btrfs_cache_block_group(block_group, true);
>  	if (ret)
>  		goto out;
>  
> @@ -4400,7 +4388,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		ffe_ctl->cached = btrfs_block_group_done(block_group);
>  		if (unlikely(!ffe_ctl->cached)) {
>  			ffe_ctl->have_caching_bg = true;
> -			ret = btrfs_cache_block_group(block_group, 0);
> +			ret = btrfs_cache_block_group(block_group, false);
>  
>  			/*
>  			 * If we get ENOMEM here or something else we want to
> @@ -6170,13 +6158,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>  
>  		if (end - start >= range->minlen) {
>  			if (!btrfs_block_group_done(cache)) {
> -				ret = btrfs_cache_block_group(cache, 0);
> -				if (ret) {
> -					bg_failed++;
> -					bg_ret = ret;
> -					continue;
> -				}
> -				ret = btrfs_wait_block_group_cache_done(cache);
> +				ret = btrfs_cache_block_group(cache, true);
>  				if (ret) {
>  					bg_failed++;
>  					bg_ret = ret;
> -- 
> 2.37.2
> 
