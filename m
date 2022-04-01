Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292614EEF16
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiDAOSM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346894AbiDAOSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 10:18:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE82220C4
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 07:16:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF22421608;
        Fri,  1 Apr 2022 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648822579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5iNud7G0nVc32JI9LYbFZKwAPw7iTKCV096y03LEWk=;
        b=SIJmq+6FFN/aK/gq06szGRVtCzj8YjKPHTRBVPWE96i8F3pEwmOP65D0QlcGiOvpDalQKw
        Uf2o2dPMT5gDujO3E4vM71ayl7JtrVGyk78wSxWSjHG3AvQPCIyC+thcv7q9qm/jXqRO72
        EeCNmdN+T42S/GN4DufJ1EbpLnINaMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648822579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5iNud7G0nVc32JI9LYbFZKwAPw7iTKCV096y03LEWk=;
        b=qHLmQ2uLDK8FZi59IZZUpC+Y3ekn94UJrzMPwVcdvBrecqjuBSu0xEypB1FYWwy/Nls/0Y
        N2zwAikGDwJPTcAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BB59BA3B8A;
        Fri,  1 Apr 2022 14:16:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B289DDA7F3; Fri,  1 Apr 2022 16:12:20 +0200 (CEST)
Date:   Fri, 1 Apr 2022 16:12:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: [PATCH v2 2/2] btrfs: zoned: activate block group only for
 extent allocation
Message-ID: <20220401141220.GJ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
References: <cover.1647936783.git.naohiro.aota@wdc.com>
 <9d491b6ea2d2628eb9632f4dfc43e52b8bfb7057.1647936783.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d491b6ea2d2628eb9632f4dfc43e52b8bfb7057.1647936783.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 22, 2022 at 06:11:34PM +0900, Naohiro Aota wrote:
> In btrfs_make_block_group(), we activate the allocated block group,
> expecting that the block group is soon used for allocation. However, the
> chunk allocation from flush_space() context broke the assumption. There can
> be a large time gap between the chunk allocation time and the extent
> allocation time from the chunk.
> 
> Activating the empty block groups pre-allocated from flush_space() context
> can exhaust the active zone counter of a device. Once we use all the active
> zone counts for empty pre-allocated BGs, we cannot activate new BG for the
> other things: metadata, tree-log, or data relocation BG. That failure
> results in a fake -ENOSPC.
> 
> This patch introduces CHUNK_ALLOC_FORCE_FOR_EXTENT to distinguish the chunk
> allocation from find_free_extent(). Now, the new block group is activated
> only in that context.
> 
> Fixes: eb66a010d518 ("btrfs: zoned: activate new block group")
> Cc: stable@vger.kernel.org # 5.16+: c7d1b9109dd0: btrfs: return allocated block group from do_chunk_alloc()
> Cc: stable@vger.kernel.org # 5.16+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 24 ++++++++++++++++--------
>  fs/btrfs/block-group.h |  1 +
>  fs/btrfs/extent-tree.c |  2 +-
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index d4ac1c76f539..84c97d76de92 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2481,12 +2481,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
>  		return ERR_PTR(ret);
>  	}
>  
> -	/*
> -	 * New block group is likely to be used soon. Try to activate it now.
> -	 * Failure is OK for now.
> -	 */
> -	btrfs_zone_activate(cache);
> -
>  	ret = exclude_super_stripes(cache);
>  	if (ret) {
>  		/* We may have excluded something, so call this just in case */
> @@ -3642,8 +3636,14 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
>  	struct btrfs_block_group *ret_bg;
>  	bool wait_for_alloc = false;
>  	bool should_alloc = false;
> +	bool from_extent_allocation = false;
>  	int ret = 0;
>  
> +	if (force == CHUNK_ALLOC_FORCE_FOR_EXTENT) {
> +		from_extent_allocation = true;
> +		force = CHUNK_ALLOC_FORCE;
> +	}
> +
>  	/* Don't re-enter if we're already allocating a chunk */
>  	if (trans->allocating_chunk)
>  		return -ENOSPC;
> @@ -3736,9 +3736,17 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
>  	ret_bg = do_chunk_alloc(trans, flags);
>  	trans->allocating_chunk = false;
>  
> -	if (IS_ERR(ret_bg))
> +	if (IS_ERR(ret_bg)) {
>  		ret = PTR_ERR(ret_bg);
> -	else
> +	} else if (from_extent_allocation) {
> +		/*
> +		 * New block group is likely to be used soon. Try to activate
> +		 * it now. Failure is OK for now.
> +		 */
> +		btrfs_zone_activate(ret_bg);
> +	}
> +
> +	if (!ret)
>  		btrfs_put_block_group(ret_bg);
>  
>  	spin_lock(&space_info->lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 93aabc68bb6a..9c822367c432 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -40,6 +40,7 @@ enum btrfs_chunk_alloc_enum {
>  	CHUNK_ALLOC_NO_FORCE,
>  	CHUNK_ALLOC_LIMITED,
>  	CHUNK_ALLOC_FORCE,
> +	CHUNK_ALLOC_FORCE_FOR_EXTENT,

There's a comment documenting what it means, I've written

	CHUNK_ALLOC_FORCE_FOR_EXTENT like CHUNK_ALLOC_FORCE but called from
	find_free_extent() that also activaes the zone

based on the changelog.
