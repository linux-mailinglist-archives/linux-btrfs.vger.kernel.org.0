Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C00D75D5BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGUU3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUU3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 16:29:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB1B7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 13:29:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F8BE5C0113;
        Fri, 21 Jul 2023 16:29:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 21 Jul 2023 16:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689971388; x=1690057788; bh=vw
        pQIPqhbaNHWI/ukT24O+8h44FN0gUr8LfwtPM4sx4=; b=q4uMYe4fRbD4GrqfWZ
        31+huviGY9rwhXIGc4gAJhb3vqMo84eFCv8R2tUAWp9KOPqrxEvL/SMwQya6hpom
        Oj3oY++SzX7JU0Ht15YdS3Bvc6+u/g/tDxsZSqlv0B5Hrb5yzaTz7OSpivvN1SqK
        mj5Kvsis8K5OGQ6CxnOan3Oe3Cdu53cL+OASa9P3mVipPHkdgXKHYB3becU6oHKW
        3E1dQm29CBwXlzJmVsacLSzPgo/qDRGFPuLhr6QE/hKbSpjQ16PORS1TQcKFDU/q
        aBI42OlIASRVu0arOO6dNiZqgYrz6D73vlUJ15f4MW3pvkUqPIvsCnSwU+kE41dy
        QhkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689971388; x=1690057788; bh=vwpQIPqhbaNHW
        I/ukT24O+8h44FN0gUr8LfwtPM4sx4=; b=sFBMEVfdqecjfAf0tkerw1/MQcdPu
        +fWAK+lNvakA4kzHWvkSaLne/RWtsEJNrlIgUeJ+R1rsFLl0tbDpuUS115xUKOKF
        R6G3cdFVpBGhQ+NuBUaZ/C5Ss6mAI8d3EtBcPT2pprME6yoNJwVTCSdKUd+TPIhY
        FUKjDfvbHHPrXvGn63wcJ/KwWPMmXcAXfet9pZSdzddzIOTMRksmcrqFBmcBzyEK
        wkEu0oN82ZVFTNmJOs41JEpbIPFsj4PPpNGAlhNcVIjgsxUJlLdJDE3dVTE14Mv7
        Wd8k/fw4lylt1I7twqE7g32fIokjo68L7TjWL1ad3UxjwrUxuZ77DcGoA==
X-ME-Sender: <xms:vOq6ZB5beUpwkD2MIZuq7iSEw3YvDLmte1fkyyBOmbHdFvTbA1PHZw>
    <xme:vOq6ZO7bJgmvYWDCmM2FnH-LXZ5RUH_X7K4cWte80AGMlnloXXPOlTxvsFqXxJJei
    D4zWb_oh12jym7aeXk>
X-ME-Received: <xmr:vOq6ZIfQ6-mD1rRCOAErahH7lZXXnICvCldEbXymYAFDrHtC3EcJMYqBRrRJVqsKhkBqM6Fxte1uvSUFbRHhPvwBCow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:vOq6ZKJ_GArVECtZ1ywBCuXkwUctxwjm6oCWOeA57bmpvMwEfa7f7w>
    <xmx:vOq6ZFKotbA9eq5-kIcu0oZZLag9mdjVv8W_wz5ZaMGft53YvYHcVA>
    <xmx:vOq6ZDzzEDsuXhNKrXk4zwlgS5q3j6RmZpXvdTerDacVnM95m7gOrg>
    <xmx:vOq6ZDgdL7BDLhALEjjd_oHauIiYjC29uRKiajmcsxkx0W6HkxxMXw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:29:47 -0400 (EDT)
Date:   Fri, 21 Jul 2023 13:28:17 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: wait for actual caching progress during
 allocation
Message-ID: <20230721202817.GA558185@zen>
References: <5b2f035fed89ad01183916d606e5735ffc2cf9c1.1689970027.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2f035fed89ad01183916d606e5735ffc2cf9c1.1689970027.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 04:09:43PM -0400, Josef Bacik wrote:
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
> Fix this by not only waiting for free space to >= the amount of space we
> want to allocate, but also that we make some progress in caching from
> the time we start waiting.  This will keep us from busy looping when the
> caching is taking a while but still theoretically has enough space for
> us to allocate from, and fixes this particular case by forcing us to
> actually sleep and wait for forward progress, which will flush the plug.
> 
> With this fix we're no longer hanging with generic/475.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Boris Burkov <boris@bur.io>

I like this fix a lot! I had missed we already block on a form of
caching progress.

One question, though:
is the logic in release_block_group() to clear the retry bools enough to
make sure we keep waiting on this through multiple passes so that we
don't just fix the most common case while failing to guarantee that we
truly always wait for forward progress?

> ---
> v1->v2:
> - Reworked the fix to just make sure we're waiting for forward progress on each
>   run through btrfs_wait_block_group_cache_progress() instead of further
>   complicating the free extent finding code.
> - Dropped the comments patch and the RAID patch.
> 
>  fs/btrfs/block-group.c | 17 +++++++++++++++--
>  fs/btrfs/block-group.h |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 91d38f38c1e7..a127865f49f9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -441,13 +441,23 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
>  					   u64 num_bytes)
>  {
>  	struct btrfs_caching_control *caching_ctl;
> +	int progress;
>  
>  	caching_ctl = btrfs_get_caching_control(cache);
>  	if (!caching_ctl)
>  		return;
>  
> +	/*
> +	 * We've already failed to allocate from this block group, so even if
> +	 * there's enough space in the block group it isn't contiguous enough to
> +	 * allow for an allocation, so wait for at least the next wakeup tick,
> +	 * or for the thing to be done.
> +	 */
> +	progress = atomic_read(&caching_ctl->progress);
> +
>  	wait_event(caching_ctl->wait, btrfs_block_group_done(cache) ||
> -		   (cache->free_space_ctl->free_space >= num_bytes));
> +		   (progress != atomic_read(&caching_ctl->progress) &&
> +		    (cache->free_space_ctl->free_space >= num_bytes)));
>  
>  	btrfs_put_caching_control(caching_ctl);
>  }
> @@ -808,8 +818,10 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
>  
>  			if (total_found > CACHING_CTL_WAKE_UP) {
>  				total_found = 0;
> -				if (wakeup)
> +				if (wakeup) {
> +					atomic_inc(&caching_ctl->progress);
>  					wake_up(&caching_ctl->wait);
> +				}
>  			}
>  		}
>  		path->slots[0]++;
> @@ -922,6 +934,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
>  	init_waitqueue_head(&caching_ctl->wait);
>  	caching_ctl->block_group = cache;
>  	refcount_set(&caching_ctl->count, 2);
> +	atomic_set(&caching_ctl->progress, 0);
>  	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
>  
>  	spin_lock(&cache->lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index cdf674a5dbad..ae1cf4429cca 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -90,6 +90,7 @@ struct btrfs_caching_control {
>  	wait_queue_head_t wait;
>  	struct btrfs_work work;
>  	struct btrfs_block_group *block_group;
> +	atomic_t progress;
>  	refcount_t count;
>  };
>  
> -- 
> 2.41.0
> 
