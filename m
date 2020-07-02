Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E987A2125DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgGBOOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:14:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbgGBOOj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:14:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01039AD9F;
        Thu,  2 Jul 2020 14:14:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5EBDDA781; Thu,  2 Jul 2020 16:14:21 +0200 (CEST)
Date:   Thu, 2 Jul 2020 16:14:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/10] btrfs: Remove fail2 label from
 btrfs_submit_compressed_read
Message-ID: <20200702141421.GS27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-10-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702134650.16550-10-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 04:46:49PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/compression.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 2033ce17e5c6..c28ee9fcd15d 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -661,8 +661,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	u64 em_len;
>  	u64 em_start;
>  	struct extent_map *em;
> -	blk_status_t ret = BLK_STS_RESOURCE;
> -	int faili = 0;
> +	blk_status_t ret;
>  	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>  	u8 *sums;
>  
> @@ -712,12 +711,16 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS |
>  							      __GFP_HIGHMEM);
>  		if (!cb->compressed_pages[pg_index]) {
> -			faili = pg_index - 1;
> -			ret = BLK_STS_RESOURCE;
> -			goto fail2;
> +			int i;
> +
> +			for (i = 0; i < pg_index; i++)
> +				__free_page(cb->compressed_pages[i]);
> +
> +			kfree(cb->compressed_pages);
> +			kfree(cb);
> +			return BLK_STS_RESOURCE;

No, that's pushing the error cleanup code to the main code path.

>  		}
>  	}
> -	faili = nr_pages - 1;
>  	cb->nr_pages = nr_pages;
>  
>  	add_ra_bio_pages(inode, em_start + em_len, cb);
> @@ -801,14 +804,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  
>  	return 0;
>  
> -fail2:
> -	while (faili >= 0) {
> -		__free_page(cb->compressed_pages[faili]);
> -		faili--;
> -	}
> -
> -	kfree(cb->compressed_pages);
> -	kfree(cb);
>  out:
>  	free_extent_map(em);
>  	return ret;

If there's anything to fix in this function, it's the labels and
variable naming. 'faili' should be eg. last_index, fail1 -> out_free_cb,
fail2 -> out_free_pages, and out -> out_free_map.
