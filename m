Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3152B84ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKRTcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:32:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:45004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKRTcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:32:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CAD25BDEE;
        Wed, 18 Nov 2020 19:32:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19C84DA701; Wed, 18 Nov 2020 20:30:32 +0100 (CET)
Date:   Wed, 18 Nov 2020 20:30:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 13/24] btrfs: handle sectorsize < PAGE_SIZE case for
 extent buffer accessors
Message-ID: <20201118193031.GB20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-14-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-14-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:38PM +0800, Qu Wenruo wrote:
>  fs/btrfs/ctree.c        |  5 ++--
>  fs/btrfs/ctree.h        | 38 ++++++++++++++++++++++--
>  fs/btrfs/extent_io.c    | 65 ++++++++++++++++++++++++-----------------
>  fs/btrfs/struct-funcs.c | 18 +++++++-----
>  4 files changed, 87 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 892b467347a3..fd4969883c2e 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1686,10 +1686,11 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
>  		oip = offset_in_page(offset);
>  
>  		if (oip + key_size <= PAGE_SIZE) {
> -			const unsigned long idx = offset >> PAGE_SHIFT;
> +			const unsigned long idx = get_eb_page_index(offset);

This could follow the pattern to extract the offset and index

>  			char *kaddr = page_address(eb->pages[idx]);
>  
> -			tmp = (struct btrfs_disk_key *)(kaddr + oip);
> +			tmp = (struct btrfs_disk_key *)(kaddr +
> +					get_eb_page_offset(eb, offset));

and not put it inside the expression.

>  		} else {
>  			read_extent_buffer(eb, &unaligned, offset, key_size);
>  			tmp = &unaligned;

> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5874,10 +5874,21 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
>  
>  	ASSERT(dst->len == src->len);
>  
> -	num_pages = num_extent_pages(dst);
> -	for (i = 0; i < num_pages; i++)
> -		copy_page(page_address(dst->pages[i]),
> -				page_address(src->pages[i]));
> +	if (dst->fs_info->sectorsize == PAGE_SIZE) {
> +		num_pages = num_extent_pages(dst);
> +		for (i = 0; i < num_pages; i++)
> +			copy_page(page_address(dst->pages[i]),
> +				  page_address(src->pages[i]));
> +	} else {
> +		unsigned long src_index = 0;
> +		unsigned long dst_index = 0;

This is not necessary, 0 is fine in the context.

> +		size_t src_offset = get_eb_page_offset(src, 0);
> +		size_t dst_offset = get_eb_page_offset(dst, 0);
> +

As this is in the 'else' branch, an assert for the only valid case
should be here

		ASSERT(dst->fs_info->sectorsize < PAGE_SIZE);

> +		memcpy(page_address(dst->pages[dst_index]) + dst_offset,
> +		       page_address(src->pages[src_index]) + src_offset,
> +		       src->len);
> +	}
