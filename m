Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EB4A9901
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 13:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiBDMOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 07:14:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43274 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiBDMOK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 07:14:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B079E61B18
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 12:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB4EC340EF;
        Fri,  4 Feb 2022 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643976850;
        bh=nT+FSL1zyuT4ufu8UmG45SAUHvzLzj9lRTeKb2j0wXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5gRHAQktCRZw0fqbTNXyoMPCXMFFNMLC0qifQx4ujV1LUuqnrpotdudUxJddlt78
         QRt828yUvrBdnR+3yz4sht3B5Q2Tnz4cspv3jrP+WVCitmGinR5Hl1nB9G0Sk0hArC
         5DEnRiwLw+8Ty2hV01SdFjWJV5W0eZlrq/QH4AfPJl5b8kx5S43FQBQ8k7EiZvqeFe
         OJ+3We2/w9n00oQcwIS5Xi54dJSDF10CBoS6tqirdxvGCRoIHXN3Lq1QnxY+t7dgzM
         GYiBQ+WPQcvm+1+oLDUi5fMLqFIJCReapO6A0EdN9XklkhulgE1/HT1XOpONOmVm2s
         MhI06TAmJYSpw==
Date:   Fri, 4 Feb 2022 12:14:07 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: stop checking for NULL return from
 btrfs_get_extent_fiemap()
Message-ID: <Yf0Yj5X4kIf4DNn7@debian9.Home>
References: <90e3cf42e593327159cd261d71da2bedb53cc562.1643976372.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e3cf42e593327159cd261d71da2bedb53cc562.1643976372.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 04:06:27AM -0800, Johannes Thumshirn wrote:
> In get_extent_skip_holes() we're checking the return of
> btrfs_get_extent_fiemap() for an error-pointer or NULL, but
> btrfs_get_extent_fiemap() will never return NULL, only error-pointers or a
> valid extent_map.
> 
> The other caller of btrfs_get_extent_fiemap(), find_desired_extent(),
> correctly only checks for error-pointers.
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 409bad3928db..ad3d8e53a75a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5390,7 +5390,7 @@ static struct extent_map *get_extent_skip_holes(struct btrfs_inode *inode,
>  			break;
>  		len = ALIGN(len, sectorsize);
>  		em = btrfs_get_extent_fiemap(inode, offset, len);
> -		if (IS_ERR_OR_NULL(em))
> +		if (IS_ERR(em))
>  			return em;
>  
>  		/* if this isn't a hole return it */
> -- 
> 2.34.1
> 
