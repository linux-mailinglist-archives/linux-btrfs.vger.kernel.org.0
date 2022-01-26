Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78049C8E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiAZLoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 06:44:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51114 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiAZLoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 06:44:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FA66194E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 11:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68309C340E3;
        Wed, 26 Jan 2022 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643197456;
        bh=PaDk0T9c/TQd28T9HHlnC6dwFJI1vMXE/UxMojZgmzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrJN3CuXGvxeUSxDtcSMrGw8IBVTnlUQrRkTt3kQMZr7NPNhexYp0iwwIP+AP9h4R
         3H6yjSNKog1lBFMgizHh/SdWG4tlk/rdV+bQmdgxwtm1obuebGE5nC+yyIHw/B3pAj
         BXw8lMba3NzfPkqk7tlEpSWyzKeKSMj1OVyH96mYa4WJieLz5JzsZVyqBrPFetTtl0
         iq2hDA03YwVYdE7Pa0WgthuVH1pM9eBKIJSiB3KvP2kAiLwp1eA8xLsI63HhJu16Cd
         HWYvbX+7Q9xqTN8F2KjnxgTK0FVn68do9y8eAcBocpEcggbncA1ifZ8NNKNGnUsPUe
         24jwkBDQhihWg==
Date:   Wed, 26 Jan 2022 11:44:14 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: defrag: remove the physical adjacent extents
 rejection in defrag_check_next_extent()
Message-ID: <YfE0DlJ437L8/sm6@debian9.Home>
References: <20220126005850.14729-1-wqu@suse.com>
 <20220126005850.14729-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126005850.14729-3-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 08:58:50AM +0800, Qu Wenruo wrote:
> There is a rejection for physically adjacent extents in
> defrag_check_next_extent() from the very beginning.
> 
> The check will reject physically adjacent extents which are also large
> enough.
> 
> The extent size threshold check is now a generic check, and the
> benefit of rejecting physically adjacent extents is unsure.
> 
> Sure physically adjacent extents means no extra seek time, thus
> defragging them may not bring much help.
> 
> On the other hand, btrfs also benefits from reduced number of extents
> (which can reduce the size of extent tree, thus reduce the mount time).

And also reduce the number of file extent items in the subvolume's tree.

I think it's fine.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> 
> So such rejection is not a full win.
> 
> Remove such check, and policy on which extents should be defragged is
> mostly on @extent_thresh and @newer_than parameters.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 2911df12fc48..0929d08bb378 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1069,9 +1069,6 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  	/* Extent is already large enough */
>  	if (next->len >= extent_thresh)
>  		goto out;
> -	/* Physically adjacent */
> -	if ((em->block_start + em->block_len == next->block_start))
> -		goto out;
>  	ret = true;
>  out:
>  	free_extent_map(next);
> -- 
> 2.34.1
> 
