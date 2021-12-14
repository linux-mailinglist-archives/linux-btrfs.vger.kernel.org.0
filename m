Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570E9474544
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhLNOhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLNOhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:37:41 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DFCC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 06:37:41 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z9so18478279qtj.9
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v/k5JQmSseU9No2Wa38IWiENPeJovOJowFpJ/ACEnDE=;
        b=yIQbMURkXMtlYRZIAk2wfqMUYPRg1c3YnSXPpbcpGLuPH4mM9KTyeIPhSNT0zDW1uj
         fIgUh8a0+DeJ3AXuZ1pceWGrOkvdeqMEq53DpFfHXqcMFQM3jz6y90cW2YYWxLZAiFt0
         otvsrKtZo4aotcG9R5W98AP6A9776BeEmO5dBFRDblZ9wiB3eFgdUWxW7FynNMVJivaI
         9nXhKd15Z6yu9VgwsAkKhEGCuoSTwtFNkfIOV9cyPI6r03onzHPNICIt1TT3eDUWcAst
         a2dus01gxiZ+2BDtYxJvA48sPb8L5uItv1GbnlcWJl7Uj7wuWKWhRr5BOy59HDdSeCiG
         ekNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v/k5JQmSseU9No2Wa38IWiENPeJovOJowFpJ/ACEnDE=;
        b=Ll4NTZYHTvSKpnysNY0tKtx/vAG0et1EH5ztk2KENwBZri+GccIL271RFpGfyInXs0
         cUWsb9Td2NBZFYAbqdFnkRCzi7Iyyd14vhsP0knoAbJX+DflrBh0jopURoXTGcqyrM3A
         bwdacT0KvijOffugS1WFXRzEitKSBzLh7st1eyE6EFZqMe19shRWFuech+ld3tc1s7Rr
         XKK7tjIQKX2ZceuEO8NWcIHYYZYZv4ZNC8Xts+MjW+or4Bqy5SEnGklWpIznXuTjzoB7
         dGQmkQ/6unyZmD7h/tume7UPipcC1w0iqGcSk1xgid/D4SsRbXQ9YS8JOJzM2I/+qYJm
         8d7A==
X-Gm-Message-State: AOAM533DkTIW5FPkhHQ36aZZKB9P9FbHsXeV/vXLn4NpkMHrAGvIR5qL
        K/JgfJQ7q8qhN5zq+g924XpzAL86YHKZLQ==
X-Google-Smtp-Source: ABdhPJwgWLGonXfP+iJwSO8QZme4gUuKbYS15J/RbSgEMiIQXotPaiXtBFSd6X4alOJHn1pj4gHM+w==
X-Received: by 2002:ac8:5c93:: with SMTP id r19mr6235090qta.67.1639492660200;
        Tue, 14 Dec 2021 06:37:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s2sm60284qtw.22.2021.12.14.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:37:39 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:37:38 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove some duplicated checks in
 btrfs_previous_*_item()
Message-ID: <YbisMuAVHVnCxYg7@localhost.localdomain>
References: <20211214071411.48324-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214071411.48324-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 03:14:11PM +0800, Qu Wenruo wrote:
> In btrfs_previous_item() and btrfs_previous_extent_item() we check
> btrfs_header_nritems() in a loop.
> 
> But in fact we don't need to do it in a loop at all.
> 
> Firstly, if a tree block is empty, the whole tree is empty and nodes[0]
> is the tree root.
> We don't need to do anything and can exit immediately.
> 
> Secondly, the only timing we could get a slots[0] >= nritems is when the
> function get called. After the first slots[0]--, the slot should always
> be <= nritems.
> 
> So this patch will move all the nritems related checks out of the loop
> by:
> 
> - Check nritems of nodes[0] to do a quick exit
> 
> - Sanitize path->slots[0] before entering the loop
>   I doubt if there is any caller setting path->slots[0] beyond
>   nritems + 1 (setting to nritems is possible when item is not found).
>   Sanitize path->slots[0] to nritems won't hurt anyway.
> 
> - Unconditionally reduce path->slots[0]
>   Since we're sure all tree blocks should not be empty, and
>   btrfs_prev_leaf() will return with path->slots[0] == nritems, we
>   can safely reduce slots[0] unconditionally.
>   Just keep an extra ASSERT() to make sure no tree block is empty.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.c | 52 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 781537692a4a..555345aed84d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4704,23 +4704,39 @@ int btrfs_previous_item(struct btrfs_root *root,
>  {
>  	struct btrfs_key found_key;
>  	struct extent_buffer *leaf;
> -	u32 nritems;
> +	const u32 nritems = btrfs_header_nritems(path->nodes[0]);
>  	int ret;
>  
> +	/*
> +	 * Check nritems first, if the tree is empty we exit immediately.
> +	 * And if this leave is not empty, none of the tree blocks of this root
> +	 * should be empty.
> +	 */
> +	if (nritems == 0)
> +		return 1;
> +
> +	/*
> +	 * If we're several slots beyond nritems, we reset slot to nritems,
> +	 * and it will be handled properly inside the loop.
> +	 */
> +	if (unlikely(path->slots[0] > nritems))
> +		path->slots[0] = nritems;
> +
>  	while (1) {
>  		if (path->slots[0] == 0) {
>  			ret = btrfs_prev_leaf(root, path);
>  			if (ret != 0)
>  				return ret;
> -		} else {
> -			path->slots[0]--;
>  		}
>  		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> -			path->slots[0]--;
> +		ASSERT(btrfs_header_nritems(leaf));
> +		/*
> +		 * This is for both regular case and above btrfs_prev_leaf() case.
> +		 * As btrfs_prev_leaf() will return with path->slots[0] == nritems,
> +		 * and we're sure no tree block is empty, we can go safely
> +		 * reduce slots[0] here.
> +		 */
> +		path->slots[0]--;

This requires trusting that the thing on disk was ok.  The tree-checker won't
complain if we read a block with nritems == 0.  I think it would be better to do

	if (btrfs_header_nritems(leaf) == 0) {
		ASSERT(btrfs_header_nritems(leaf));
		return -EUCLEAN;
	}

so we don't get ourselves in trouble.  Thanks,

Josef
