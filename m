Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5953F492880
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiAROgt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 09:36:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49124 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiAROgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 09:36:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FB660C4D
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 14:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B04CC00446;
        Tue, 18 Jan 2022 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642516608;
        bh=Gs3xxqDuS/AjLTLXE+BWGauaNUpdJaRVkKsKojK/g3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulmpEHtvOJE7aoqRF+aBtpFAQUD0BKNs/ngwxQeMnd5O/Jq53mgTYWczaZu8ALEMr
         HPY8mgm69Q9LSkGgHrKyTsNT9q1+sxqj1yxeAE+6MvJuHswG/Z1algt4htTqmeUn8p
         f+MqcF+HzOKjGaaKhKoRmh/YVG3x3l0CWVGCCToPXSPf4+DCXRKo31/M8nmeW7r0OK
         aBbG4puxxTVoUmNZPnhBm5QIWDLYGXzTrwYWYZCcdghCaD7EqWPoLdX+gkgCEaUMeu
         7PWvq6PWIp8awSvKpMv3qFB7qFk2NbXioz5FyaPOE5qo/0tCNAJmNozuCySRxuCNwj
         N0WSeBzxaPXvQ==
Date:   Tue, 18 Jan 2022 14:36:45 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: defrag: properly update range->start for
 autodefrag
Message-ID: <YebQfdMAcjULXCF4@debian9.Home>
References: <20220118115352.52126-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118115352.52126-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 07:53:52PM +0800, Qu Wenruo wrote:
> [BUG]
> After commit 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to
> implement btrfs_defrag_file()") autodefrag no longer properly re-defrag
> the file from previously finished location.
> 
> [CAUSE]
> The recent refactor on defrag only focuses on defrag ioctl subpage
> support, doesn't take auto defrag into consideration.
> 
> There are two problems involved which prevents autodefrag to restart its
> scan:
> 
> - No range.start update
>   Previously when one defrag target is found, range->start will be
>   updated to indicate where next search should start from.
> 
>   But now btrfs_defrag_file() doesn't update it anymore, making all
>   autodefrag to rescan from file offset 0.
> 
>   This would also make autodefrag to mark the same range dirty again and
>   again, causing extra IO.
> 
> - No proper quick exit for defrag_one_cluster()
>   Currently if we reached or exceed @max_sectors limit, we just exit
>   defrag_one_cluster(), and let next defrag_one_cluster() call to do a
>   quick exit.
>   This makes @cur increase, thus no way to properly know which range is
>   defragged and which range is skipped.
> 
> [FIX]
> The fix involves two modifications:
> 
> - Update range->start to next cluster start
>   This is a little different from the old behavior.
>   Previously range->start is updated to the next defrag target.
> 
>   But in the end, the behavior should still be pretty much the same,
>   as now we skip to next defrag target inside btrfs_defrag_file().
> 
>   Thus if auto-defrag determines to re-scan, then we still do the skip,
>   just at a different timing.
> 
> - Make defrag_one_cluster() to return >0 to indicate a quick exit
>   So that btrfs_defrag_file() can also do a quick exit, without
>   increasing @cur to the range end, and re-use @cur to update
>   @range->start.
> 
> - Add comment for btrfs_defrag_file() to mention the range->start update
>   Currently only autodefrag utilize this behavior, as defrag ioctl won't
>   set @max_to_defrag parameter, thus unless interrupted it will always
>   try to defrag the whole range.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

As mentioned in the other patch, please add a Link tag to the user's report:

Link: https://lore.kernel.org/linux-btrfs/0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org/

> ---
>  fs/btrfs/ioctl.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 2a77273d91fe..91ba2efe9792 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1443,8 +1443,10 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  		u32 range_len = entry->len;
>  
>  		/* Reached or beyond the limit */
> -		if (max_sectors && *sectors_defragged >= max_sectors)
> +		if (max_sectors && *sectors_defragged >= max_sectors) {
> +			ret = 1;
>  			break;
> +		}
>  
>  		if (max_sectors)
>  			range_len = min_t(u32, range_len,
> @@ -1487,7 +1489,10 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>   *		   will be defragged.
>   *
>   * Return <0 for error.
> - * Return >=0 for the number of sectors defragged.
> + * Return >=0 for the number of sectors defragged, and range->start will be updated
> + * to indicate the file offset where next defrag should be started at.
> + * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
> + *  defragging all the range).
>   */
>  int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		      struct btrfs_ioctl_defrag_range_args *range,
> @@ -1575,10 +1580,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		if (ret < 0)
>  			break;
>  		cur = cluster_end + 1;
> +		if (ret > 0) {
> +			ret = 0;
> +			break;
> +		}
>  	}
>  
>  	if (ra_allocated)
>  		kfree(ra);
> +	/*
> +	 * Update range.start for autodefrag, this will indicate where to start
> +	 * in next run.
> +	 */
> +	range->start = cur;
>  	if (sectors_defragged) {
>  		/*
>  		 * We have defragged some sectors, for compression case they
> -- 
> 2.34.1
> 
