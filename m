Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9444ADE80
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383468AbiBHQnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 11:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBHQnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 11:43:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DABC061576
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 08:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE1DFCE1AFC
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 16:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2C9C340EC;
        Tue,  8 Feb 2022 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644338597;
        bh=rZ+O7kiHy5Gmb0/U9yv2K72fgvwdAPt/Q16Ee66fhTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHUvgGAv64pYXHUTrJV7JHBqwtUNs33nkdABpe0ny0jT38QaM/3fAB4yvSUTks3IG
         1HvRznEzT9/11XkAQNnOA7j210qRfEMiWjnSinUhNhhriKHbSt9dIT2iXDLEYkVWId
         Yr+EUWBK1b9oVug6CzaJ5joHV9mcsqgtTlvpW8EQ7Mii9SL74CQmPb4mw/B8VasLy4
         5L2D/bIt+j88zHlk5+Os1i1yiRNz95IVEgvDk4BmzgxdIP7F+lGTjdDzQrwZgplRbS
         geZDv0MYqrV11kzZQNXuz1sVxxAW4krdB2s05Egtq1ULaF7t6KrDrMLtESqdcYIuWQ
         StFRBpMrcPGhw==
Date:   Tue, 8 Feb 2022 16:43:14 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: defrag: don't try to defrag extents which are
 under writeback
Message-ID: <YgKdokMLGVHrsmmk@debian9.Home>
References: <72af431773a417658d8737f3acb39c1652f7e821.1644303096.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72af431773a417658d8737f3acb39c1652f7e821.1644303096.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 02:54:05PM +0800, Qu Wenruo wrote:
> Once we start writeback (have called btrfs_run_delalloc_range()), we
> allocate an extent, create an extent map point to that extent, with a
> generation of (u64)-1, created the ordered extent and then clear the
> DELALLOC bit from the range in the inode's io tree.
> 
> Such extent map can pass the first call of defrag_collect_targets(), as
> its generation is (u64)-1, meets any possible minimal geneartion check.

Same as in the other patch, geneartion -> generation.

> And the range will not have DELALLOC bit, also passing the DELALLOC bit
> check.
> 
> It will only be re-checked in the second call of
> defrag_collect_targets(), which will wait for writeback.
> 
> But at that stage we have already spent our time waiting for some IO we
> may or may not want to defrag.
> 
> Let's reject such extents early so we won't waste our time.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> - Update the subject, commit message and comment.
>   To replace the confusing phrase "be going to be written back" with
>   "under writeback".
> 
> - Update the commit message to indicate it's not always going to be marked
>   for defrag 
>   The second defrag_collect_targets() call will determine its destiny.
> 
> - Update the commit message to show why we want to skip it early
>   To save some time waiting for IO.
> ---
>  fs/btrfs/ioctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3a5ada561298..f08005b41deb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1383,6 +1383,10 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		if (em->generation < ctrl->newer_than)
>  			goto next;
>  
> +		/* This em is goging to be written back, no need to defrag */

Still as in v1, should be "This em is under writeback...".

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +		if (em->generation == (u64)-1)
> +			goto next;
> +
>  		/*
>  		 * Our start offset might be in the middle of an existing extent
>  		 * map, so take that into account.
> -- 
> 2.35.0
> 
