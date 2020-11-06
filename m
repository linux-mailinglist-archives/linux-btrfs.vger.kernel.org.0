Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948B32A9CCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 20:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgKFTAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 14:00:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:43406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgKFTAS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 14:00:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D99D8AD21;
        Fri,  6 Nov 2020 19:00:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E1BBDA6E3; Fri,  6 Nov 2020 19:58:36 +0100 (CET)
Date:   Fri, 6 Nov 2020 19:58:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 11/32] btrfs: disk-io: make csum_tree_block() handle
 sectorsize smaller than page size
Message-ID: <20201106185836.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-12-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133108.148112-12-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 09:30:47PM +0800, Qu Wenruo wrote:
> For subpage size support, we only need to handle the first page.
> 
> To make the code work for both cases, we modify the following behaviors:
> 
> - num_pages calcuation
>   Instead of "nodesize >> PAGE_SHIFT", we go
>   "DIV_ROUND_UP(nodesize, PAGE_SIZE)", this ensures we get at least one
>   page for subpage size support, while still get the same result for
>   regular page size.
> 
> - The length for the first run
>   Instead of PAGE_SIZE - BTRFS_CSUM_SIZE, we go min(PAGE_SIZE, nodesize)
>   - BTRFS_CSUM_SIZE.
>   This allows us to handle both cases well.
> 
> - The start location of the first run
>   Instead of always use BTRFS_CSUM_SIZE as csum start position, add
>   offset_in_page(eb->start) to get proper offset for both cases.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/disk-io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1b527b2d16d8..9a72cb5ef31e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -211,16 +211,16 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
>  static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  {
>  	struct btrfs_fs_info *fs_info = buf->fs_info;
> -	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
> +	const int num_pages = DIV_ROUND_UP(fs_info->nodesize, PAGE_SIZE);

No, this is not necessary and the previous way of counting pages should
stay as it's clear what is calculated. The rounding side effects make it
too subtle.  If sectorsize < page size, then num_pages is 0 but checksum
of the first page or it's part is done unconditionally.

>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	char *kaddr;
>  	int i;
>  
>  	shash->tfm = fs_info->csum_shash;
>  	crypto_shash_init(shash);
> -	kaddr = page_address(buf->pages[0]);
> +	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
>  	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> -			    PAGE_SIZE - BTRFS_CSUM_SIZE);
> +		min_t(u32, PAGE_SIZE, fs_info->nodesize) - BTRFS_CSUM_SIZE);

For clarity this should be calculated in a temporary variable.

As this checksumming loop is also in scrub, this needs to be done right
before the unreadable coding pattern spreads.

Also note that the subject talks about sectorsize while it is about
metadata blocks that use nodesize.
