Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620BB212582
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgGBODm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:03:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBODl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:03:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFFECB5E7;
        Thu,  2 Jul 2020 14:03:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF520DA781; Thu,  2 Jul 2020 16:03:24 +0200 (CEST)
Date:   Thu, 2 Jul 2020 16:03:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: Remove fail1 label in
 btrfs_submit_compressed_read
Message-ID: <20200702140324.GQ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-9-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702134650.16550-9-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 04:46:48PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/compression.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 48ceab7be0fe..2033ce17e5c6 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -703,8 +703,10 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
>  	cb->compressed_pages = kcalloc(nr_pages, sizeof(struct page *),
>  				       GFP_NOFS);
> -	if (!cb->compressed_pages)
> -		goto fail1;
> +	if (!cb->compressed_pages) {
> +		kfree(cb);
> +		return BLK_STS_RESOURCE;

No please, that's exactly why there is th exit block so we don't have to
repeat the cleanup functions.

> +	}
>  
>  	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
>  		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS |
> @@ -806,7 +808,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	}
>  
>  	kfree(cb->compressed_pages);
> -fail1:
>  	kfree(cb);
>  out:
>  	free_extent_map(em);
> -- 
> 2.17.1
