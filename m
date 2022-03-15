Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177FE4D9A28
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347920AbiCOLRC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347917AbiCOLRB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:17:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC94F9C8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 04:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EEF9B81250
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D2AC340E8;
        Tue, 15 Mar 2022 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647342947;
        bh=KyqkeDzr1lDrsixdtBfSDaAZ7NmnDf9cEQGYWKfgZzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lo8UJi+sn805x31OPWZ87DwG30MSiF4EzKNuPcyGdqW0ZO0DUOqBhp0Xbo0vJsdZs
         gCAWayOYInvbyvo7cI3/5ptvdR/1j2rJXYLbA4nMbKR1uCMoyYBuBxh/Q9N/AikIaS
         Cm4zCVyaQeGBMEkb0APF55WoBD0LB7NvJLTBUqa9+bpCAqBPrhEIDVu18qCx7g8GWo
         iJ32RVeQHPFySk05q76IsVNjgdIVdyCAxtK/iyMw08JMeBh601/JHLzZQQJVopTvLf
         JWVZ+J5e/j4Cpzj5/+PN3evvKIC2OlcJjIe3rFnF0mKkJfuSkaI7vrYLz4DYGegIc2
         z+0O0BCB3vGCA==
Date:   Tue, 15 Mar 2022 11:15:44 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid defragging extents whose next extents are
 not targets
Message-ID: <YjB1YO95Vycuhlzo@debian9.Home>
References: <795e3dee8c4789f845e5e14bfc02c992b86fa2d9.1647306224.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795e3dee8c4789f845e5e14bfc02c992b86fa2d9.1647306224.git.wqu@suse.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 09:07:52AM +0800, Qu Wenruo wrote:
> [BUG]
> There is a report that autodefrag is defragging single sector, which
> is completely waste of IO, and no help for defragging:
> 
>    btrfs-cleaner-808     defrag_one_locked_range: root=256 ino=651122 start=0 len=4096
> 
> [CAUSE]
> In defrag_collect_targets(), we check if the current range (A) can be merged
> with next one (B).
> 
> If mergeable, we will add range A into target for defrag.
> 
> However there is a catch for autodefrag, when checking mergebility against
> range B, we intentionally pass 0 as @newer_than, hoping to get a
> higher chance to merge with the next extent.
> 
> But in next iteartion, range B will looked up by defrag_lookup_extent(),
> with non-zero @newer_than.
> 
> And if range B is not really newer, it will rejected directly, causing
> only range A being defragged, while we expect to defrag both range A and
> B.
> 
> [FIX]
> Since the root cause is the difference in check condition of
> defrag_check_next_extent() and defrag_collect_targets(), we fix it by:
> 
> 1. Pass @newer_than to defrag_check_next_extent()
> 2. Pass @extent_thresh to defrag_check_next_extent()
> 
> This makes the check between defrag_collect_targets() and
> defrag_check_next_extent() more consistent.
> 
> While there is still some minor difference, the remaining checks are
> focus on runtime flags like writeback/delalloc, which are mostly
> transient and safe to be checked only in defrag_collect_targets().
> 
> Issue: 423#issuecomment-1066981856

Where is the issue exactly? It's the first time I'm seeing an Issue tag
for kernel patches. Is this a github issue? If so, which repo? There are
several repos we use for btrfs:

https://github.com/btrfs/linux
https://github.com/kdave/btrfs-devel
https://github.com/kdave/btrfs-progs
https://github.com/btrfs/fstests
etc

Can't we use a Link tag with an URL? That removes any doubts where the
issue is and makes it easier to look at it.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Doesn't this miss a Fixes tag and a CC stable tag for 5.16?

This is fixing code added in 5.16, and given that users are reporting
autodefrag causing disruptive amounts of IO, I don't see why it doesn't
have a CC tag for stable.

The change itself looks good. Thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/ioctl.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3d3d6e2f110a..7d7520a2e281 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1189,7 +1189,7 @@ static u32 get_extent_max_capacity(const struct extent_map *em)
>  }
>  
>  static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> -				     bool locked)
> +				     u32 extent_thresh, u64 newer_than, bool locked)
>  {
>  	struct extent_map *next;
>  	bool ret = false;
> @@ -1199,11 +1199,13 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  		return false;
>  
>  	/*
> -	 * We want to check if the next extent can be merged with the current
> -	 * one, which can be an extent created in a past generation, so we pass
> -	 * a minimum generation of 0 to defrag_lookup_extent().
> +	 * Here we need to pass @newer_then when checking the next extent, or
> +	 * we will hit a case we mark current extent for defrag, but the next
> +	 * one will not be a target.
> +	 * This will just cause extra IO without really reducing the fragments.
>  	 */
> -	next = defrag_lookup_extent(inode, em->start + em->len, 0, locked);
> +	next = defrag_lookup_extent(inode, em->start + em->len, newer_than,
> +				    locked);
>  	/* No more em or hole */
>  	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
>  		goto out;
> @@ -1215,6 +1217,13 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  	 */
>  	if (next->len >= get_extent_max_capacity(em))
>  		goto out;
> +	/* Skip older extent */
> +	if (next->generation < newer_than)
> +		goto out;
> +	/* Also check extent size */
> +	if (next->len >= extent_thresh)
> +		goto out;
> +
>  	ret = true;
>  out:
>  	free_extent_map(next);
> @@ -1420,7 +1429,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			goto next;
>  
>  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
> -							  locked);
> +						extent_thresh, newer_than, locked);
>  		if (!next_mergeable) {
>  			struct defrag_target_range *last;
>  
> -- 
> 2.35.1
> 
