Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2042EF23
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhJOKy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 06:54:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbhJOKy1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 06:54:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 060F21FD4B;
        Fri, 15 Oct 2021 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634295140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HD4Naw6zVJYU4sSXF2lgHK4ySkSIpgjUG3OcgSlUH9k=;
        b=UAaR7vTxFfMZs8kw63KTvtCFkD8S+XDQwU1N1BNcV0QRJR26XCrK7HSyXucmFNFtGnvL/b
        8Zw+f/+YKKVh/fCgyVPH+igVQ7DHKf9PUziKcT2+Z0PpnDh8nW6stEM1XrWtwsAZ6myYjh
        Y10xyRVeWAHTN0D3aRpJ/hLYzPZddng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634295140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HD4Naw6zVJYU4sSXF2lgHK4ySkSIpgjUG3OcgSlUH9k=;
        b=H/ONCZdwiM22D8kwNvHNuhfNAX7JRWpOLaS2Kc3/hxQLsyfmX14Q8C8MNLPABXKAXi9IzM
        EduCt4ZNduWB/iBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 913B8A3B81;
        Fri, 15 Oct 2021 10:52:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68FFCDA7A3; Fri, 15 Oct 2021 12:51:54 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:51:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net,
        johannes.thumshirn@wdc.com
Subject: Re: [PATCH] btrfs: Simplify conditional in assert
Message-ID: <20211015105154.GC30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wan Jiabing <wanjiabing@vivo.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net,
        johannes.thumshirn@wdc.com
References: <20211015103639.21838-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015103639.21838-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adding Johannes to CC,

On Fri, Oct 15, 2021 at 06:36:39AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./fs/btrfs/inode.c:2015:16-18: WARNING !A || A && B is equivalent to !A || B
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  fs/btrfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e9154b436c47..da4aeef73b0d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2011,8 +2011,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  		 * to use run_delalloc_nocow() here, like for  regular
>  		 * preallocated inodes.
>  		 */
> -		ASSERT(!zoned ||
> -		       (zoned && btrfs_is_data_reloc_root(inode->root)));
> +		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));

The short form is equivalent, but I'm not sure it's also on the same
level of readability. Repeating the 'zoned' condition check makes it
obvious on first sight, which is what I'd prefer.

Johannes if you'd like the new version I'll change it but otherwise I'm
fine with what we have now.

>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, nr_written);
>  	} else if (!inode_can_compress(inode) ||
> -- 
> 2.20.1
