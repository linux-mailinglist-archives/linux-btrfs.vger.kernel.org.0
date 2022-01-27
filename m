Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2749DFC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 11:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiA0KtJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 05:49:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42460 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiA0KtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 05:49:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C726C61245
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 10:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2014C340E6;
        Thu, 27 Jan 2022 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643280548;
        bh=D0youo98eZbPbW4SvK48VD7+ngWAqGOgVYZ87ZuNJvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvXVoT1vtI9weG5mGFl+lStkWzzIVY0Jq3X2VhH8ors/KI/q0wNfLRFo4Ff4TQWxV
         0negpTu+nDIvf4jtwGtPEbvVhFWwTIJEtpfa+Hz52B/CHWpqz2tO+SB5GoxKgFtCSV
         cSPk7N70GAa/zhUG12iTIY67s3NbPYOsBmka15OuU01e5QzX+cypvbheADoTdfhHnE
         H7gWvl+X869jgCQHZ6y2xe5P8FjMQlq4NJcXrj0u+oh//c4Ss0DoQ9hRiCa6QI2UAo
         NPJ1poACaqGtrWNJaypM8vMzt5SsSs3fUeN/rrzjfI4ubEma0CTtT+J5jAHjs0q6Q7
         EASfaSuoBjXRA==
Date:   Thu, 27 Jan 2022 10:49:05 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: defrag: remove an ambiguous condition for
 rejection
Message-ID: <YfJ4oQ+wEmk/CZfS@debian9.Home>
References: <cover.1643260816.git.wqu@suse.com>
 <0a2fdf173e68967239e4162fe08c434502ba7ea1.1643260816.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2fdf173e68967239e4162fe08c434502ba7ea1.1643260816.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 01:24:43PM +0800, Qu Wenruo wrote:
> From the very beginning of btrfs defrag, there is a check to reject
> extents which meet both conditions:
> 
> - Physically adjacent
> 
>   We may want to defrag physically adjacent extents to reduce the number
>   of extents or the size of subvolume tree.
> 
> - Larger than 128K
> 
>   This may be there for compressed extents, but unfortunately 128K is
>   exactly the max capacity for compressed extents.
>   And the check is > 128K, thus it never rejects compressed extents.
> 
>   Furthermore, the compressed extent capacity bug is fixed by previous
>   patch, there is no reason for that check anymore.
> 
> The original check has a very small ranges to reject (the target extent
> size is > 128K, and default extent threshold is 256K), and for
> compressed extent it doesn't work at all.
> 
> So it's better just to remove the rejection, and allow us to defrag
> physically adjacent extents.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/ioctl.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a03c31e1ff18..af95e3b7aa72 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1078,10 +1078,6 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  	 */
>  	if (next->len >= get_extent_max_capacity(em))
>  		goto out;
> -	/* Physically adjacent and large enough */
> -	if ((em->block_start + em->block_len == next->block_start) &&
> -	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
> -		goto out;
>  	ret = true;
>  out:
>  	free_extent_map(next);
> -- 
> 2.34.1
> 
