Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340D75BA89
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGTWXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGTWXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:23:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1C30F0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:22:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 69BA65C0051;
        Thu, 20 Jul 2023 18:22:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 18:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689891752; x=1689978152; bh=r7
        wadMdu8i2snwX5mH2PXPXlsihiVbxoD9AcRVRnENo=; b=hxfmHo1NcDqW14SuLP
        532fV8uIsa/wvodsbNCxya5WUAW/IuQXQQ1qfZ6dtuPIjM/rfoDHNYixY1mHg9+e
        6Q86gi2A/QGBvUqwdnDG9QpP7RzVdKRR7RQM4UVpAZQsqmr17157msY2p2gQ7+w3
        TF1vmuHjbO3Vs1ZDT3a1cPQVtfYE5Cvx8kcIZptQpYyTBiiUtShjG5hS1u9CdKcW
        UHvE69J4YEOm3wkigCZcvvQD/Ih31iI5aSXvhQmqOoNfjz2SviENMa7hCHY0Alj8
        DTGm2DlOo24moRyzb6wkc+F4f2f3JArd83waJRFUjrbhzmt/O0fyt1Hv4Bc1TG4H
        RVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689891752; x=1689978152; bh=r7wadMdu8i2sn
        wX5mH2PXPXlsihiVbxoD9AcRVRnENo=; b=N0eL1HOKIxMWE0TA+iHwJJj37dYqf
        wCM/zTF/zFcAgwXj2qy6fx5UwNtNWnngReXo5+/LIaoeiqt00F1oc2IrKK2YO/3F
        2nLFednyZMiKeLaEdpEYiRPGYhF3tggXjQIuWHRvuRA2ZQkH/XTf/5kBTJvLVoyc
        k33ef3R9gDY7HIkcRdlSMIxI7O7zfZKvVNmSr7WNM+tuTSThWdQuwfZL5Xf9WVLk
        X1A0gE9nUUgcPoeIIWhGPexSzEeQcj43ZSRoqwhH6qWmMdUwGdCqgz1P6+i9F/Yh
        zFEeXow2HWb0rvF5/Ss1n5u5mE1h8XoDN6SBwYgErlaRnEcAf1+DBb+MA==
X-ME-Sender: <xms:qLO5ZPFa2RnBS3C0mMjnCkkeZR1ITBKDDRjLx_PhMIImJahJx5WfxQ>
    <xme:qLO5ZMVaYmXfmvzr3QV7xvTVjKSazcOT_MLXUpq8X4G7xQ3Ss_iRhmVcwOlOnxpCX
    9vkl0is8vma4cMstnQ>
X-ME-Received: <xmr:qLO5ZBL8aQODxKMeSzdGhPiiu2cEk0nuFcEOc4W630ymVwbHaJjiiqaUyqoLtozL1E2_EWPNui8YvBrJpDDNiDChdvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:qLO5ZNHrE-56xlV9tMEVdQpNJ9QFOwNtwHKtC6KqcLx2ihnRW16VdQ>
    <xmx:qLO5ZFXySCOVrPwf6u4SG0PFXd-JQhkNYc_3y-ecaHX7q8Ds_cjOng>
    <xmx:qLO5ZIMoCi1OIoGHWPt50QCSEx7vjd9eMZH5YuC0si7wF7QfL3YuKg>
    <xmx:qLO5ZEdAlA88a-DgpnpmYetvk8bvWi4mqurHZunbRpZmSgC_GzbLjA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:22:31 -0400 (EDT)
Date:   Thu, 20 Jul 2023 15:21:01 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs: wait for block groups to finish caching
 during allocation
Message-ID: <20230720222101.GA545904@zen>
References: <cover.1689883754.git.josef@toxicpanda.com>
 <bd295f0e2277e34008b4aa5648527d0394472de1.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd295f0e2277e34008b4aa5648527d0394472de1.1689883754.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 04:12:14PM -0400, Josef Bacik wrote:
> Recently we've been having mysterious hangs while running generic/475 on
> the CI system.  This turned out to be something like this
> 
> Task 1
> dmsetup suspend --nolockfs
> -> __dm_suspend
>  -> dm_wait_for_completion
>   -> dm_wait_for_bios_completion
>    -> Unable to complete because of IO's on a plug in Task 2
> 
> Task 2
> wb_workfn
> -> wb_writeback
>  -> blk_start_plug
>   -> writeback_sb_inodes
>    -> Infinite loop unable to make an allocation
> 
> Task 3
> cache_block_group
> ->read_extent_buffer_pages
>  ->Waiting for IO to complete that can't be submitted because Task 1
>    suspended the DM device
> 
> The problem here is that we need Task 2 to be scheduled completely for
> the blk plug to flush.  Normally this would happen, we normally wait for
> the block group caching to finish (Task 3), and this schedule would
> result in the block plug flushing.
> 
> However if there's enough free space available from the current caching
> to satisfy the allocation we won't actually wait for the caching to
> complete.  This check however just checks that we have enough space, not
> that we can make the allocation.  In this particular case we were trying
> to allocate 9mib, and we had 10mib of free space, but we didn't have
> 9mib of contiguous space to allocate, and thus the allocation failed and
> we looped.
> 
> We specifically don't cycle through the FFE loop until we stop finding
> cached block groups because we don't want to allocate new block groups
> just because we're caching, so we short circuit the normal loop once we
> hit LOOP_CACHING_WAIT and we found a caching block group.
> 
> This is normally fine, except in this particular case where the caching
> thread can't make progress because the dm device has been suspended.
> 
> Fix this by adding another LOOP state that specifically waits for the
> block group to be completely cached before proceeding.  This allows us
> to drop this particular optimization, and will give us the proper
> scheduling needed to finish the plug.
> 
> The alternative here was to simply flush the plug if we need_resched(),
> but this is actually a sort of bad behavior from us where we assume that
> if the block group has enough free space to match our allocation we'll
> actually be successful.  It is a good enough check for a quick pass to
> avoid the latency of a full wait, but free space != contiguous free
> space, so waiting is more appropriate.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 04ceb9d25d3e..2850bd411a0e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3331,6 +3331,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
>  enum btrfs_loop_type {
>  	LOOP_CACHING_NOWAIT,
>  	LOOP_CACHING_WAIT,
> +	LOOP_CACHING_DONE,
>  	LOOP_UNSET_SIZE_CLASS,
>  	LOOP_ALLOC_CHUNK,
>  	LOOP_WRONG_SIZE_CLASS,
> @@ -3920,9 +3921,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  		return 0;
>  	}
>  
> -	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
> -		return 1;
> -

As far as I can tell, this change significantly diminishes the
meaning/value of LOOP_CACHING_WAIT. It goes from a busy loop that
continues until we stop failing on an uncached bgs (success or all bgs
cached) to just a single retry before moving on to LOOP_CACHING_DONE
which does the real wait_event for the bg to get cached.

I am not convinced that a single retry does much compared to just going
straight to the wait_event. I think it should be reasonably easy to
answer this question by creating a big FS, mounting it and allocating
right after and seeing if the allocations succeed in LOOP_CACHING_WAIT
or LOOP_CACHING_DONE.

Let's suppose that I guessed correctly and they succeed in
LOOP_CACHING_DONE. Let's also assume, based on prior experience, that we
can't always affort to wait for the bg to get fully cached in.

Perhaps another option is to add a new event to the mix. It would be
signalled when we make progress caching a bg, and LOOP_CACHING_WAIT
could call the non-blocking btrfs_cache_block_group, then wait on that
event. This would have better granularity than waiting for the whole
block group while still having the desired scheduling behavior needed to
fix this bug.
>  	ffe_ctl->index++;
>  	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
>  		return 1;
> @@ -3931,6 +3929,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  	 * LOOP_CACHING_NOWAIT, search partially cached block groups, kicking
>  	 *			caching kthreads as we move along
>  	 * LOOP_CACHING_WAIT, search everything, and wait if our bg is caching
> +	 * LOOP_CACHING_DONE, search everything, wait for the caching to
> +	 *			completely finish
>  	 * LOOP_UNSET_SIZE_CLASS, allow unset size class
>  	 * LOOP_ALLOC_CHUNK, force a chunk allocation and try again
>  	 * LOOP_NO_EMPTY_SIZE, set empty_size and empty_cluster to 0 and try
> @@ -3939,13 +3939,13 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
>  		ffe_ctl->index = 0;
>  		/*
> -		 * We want to skip the LOOP_CACHING_WAIT step if we don't have
> +		 * We want to skip the LOOP_CACHING_* steps if we don't have
>  		 * any uncached bgs and we've already done a full search
>  		 * through.
>  		 */
>  		if (ffe_ctl->loop == LOOP_CACHING_NOWAIT &&
>  		    (!ffe_ctl->orig_have_caching_bg && full_search))
> -			ffe_ctl->loop++;
> +			ffe_ctl->loop = LOOP_CACHING_DONE;
>  		ffe_ctl->loop++;
>  
>  		if (ffe_ctl->loop == LOOP_ALLOC_CHUNK) {
> @@ -4269,8 +4269,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		trace_find_free_extent_have_block_group(root, ffe_ctl, block_group);
>  		ffe_ctl->cached = btrfs_block_group_done(block_group);
>  		if (unlikely(!ffe_ctl->cached)) {
> -			ffe_ctl->have_caching_bg = true;
> -			ret = btrfs_cache_block_group(block_group, false);
> +			bool wait = ffe_ctl->loop == LOOP_CACHING_DONE;

This feels quite unlikely, but I think it's also theoretically possible
that every single call to btrfs_cache_block_group in the loop will fail
with -ENOMEM, which we swallow. We then advance to the next big loop
with more caching outstanding that we no longer wait for in any way.

I think changing the wait check to >= LOOP_CACHING_DONE would fix this.

> +
> +			if (!wait)
> +				ffe_ctl->have_caching_bg = true;
> +			ret = btrfs_cache_block_group(block_group, wait);

I think a comment somewhere explaining that the wait_event this triggers
is critical would be helpful.

>  
>  			/*
>  			 * If we get ENOMEM here or something else we want to
> @@ -4285,6 +4288,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  				ret = 0;
>  				goto loop;
>  			}
> +
> +			if (wait)
> +				ffe_ctl->cached = btrfs_block_group_done(block_group);

should we set have_caching_bg = false too?

>  			ret = 0;
>  		}
>  
> -- 
> 2.41.0
> 
