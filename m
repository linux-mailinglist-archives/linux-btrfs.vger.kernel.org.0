Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154D73A92F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFPGoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 02:44:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54852 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhFPGoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 02:44:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3D0A1FD47;
        Wed, 16 Jun 2021 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623825730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjPRNNLHnON5LMLw0A1rbYvJrkBgmwc3jStEDZxCt/0=;
        b=DZGsY1mZe/Zobp67AI7l937K38NWkqwHkZNRbiaNXaS9fTNvUc0wqzG3t4OnWNsTE5Lrnx
        Fv6v0l9LdMskrXEC1SUJURLM4LZSHaq8vEpUeMXYYeasTO6lJXI7unyvuFGEsH8jPiZbze
        cE5NbRkpolLFWXaT3YEZlMKN8iHiU/Y=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 85FCB118DD;
        Wed, 16 Jun 2021 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623825730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjPRNNLHnON5LMLw0A1rbYvJrkBgmwc3jStEDZxCt/0=;
        b=DZGsY1mZe/Zobp67AI7l937K38NWkqwHkZNRbiaNXaS9fTNvUc0wqzG3t4OnWNsTE5Lrnx
        Fv6v0l9LdMskrXEC1SUJURLM4LZSHaq8vEpUeMXYYeasTO6lJXI7unyvuFGEsH8jPiZbze
        cE5NbRkpolLFWXaT3YEZlMKN8iHiU/Y=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id fGq+HUKdyWD1TAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Wed, 16 Jun 2021 06:42:10 +0000
Subject: Re: [RFC PATCH 06/31] btrfs: lock extents while truncating
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <6a65ad8036c65f0d484dc98ee30ba21d4c4812fc.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1edfe59b-a446-39f5-f8d1-8e7d0d9a5670@suse.com>
Date:   Wed, 16 Jun 2021 09:42:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6a65ad8036c65f0d484dc98ee30ba21d4c4812fc.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Lock order change: Lock extents before pages.
> 
> This removes extent locking in invalidatepages().
> invalidatepage() is either called during truncating or while evicting
> inode. Inode eviction does not require locking.

Imo the changelog of that patch warrants an explicit mention why its
correct, namely that it's lifting the locking from btrfs_invalidatepage
and putting it in btrfs_setsize, wrapping truncate_setsize which
eventually boils down to calling invalidatepage,

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 794d906cba6c..7761a60788d0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5201,6 +5201,9 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
>  		btrfs_end_transaction(trans);
>  	} else {
>  		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +		u64 start = round_down(oldsize, fs_info->sectorsize);
> +		u64 end = round_up(newsize, fs_info->sectorsize) - 1;
> +		struct extent_state **cached = NULL;
>  
>  		if (btrfs_is_zoned(fs_info)) {
>  			ret = btrfs_wait_ordered_range(inode,
> @@ -5219,7 +5222,10 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
>  			set_bit(BTRFS_INODE_FLUSH_ON_CLOSE,
>  				&BTRFS_I(inode)->runtime_flags);
>  
> +		lock_extent_bits(&BTRFS_I(inode)->io_tree, start, end, cached);
>  		truncate_setsize(inode, newsize);
> +		unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, end,
> +				cached);

This effectively lifts the granular locking, which is performed on a
per-page basis and turns it into one coarse lock, which covers the whole
region. This might have some performance repercussions which can go
either way:

1. On the one hand you are keeping the whole ranged locked from the
start until the page cache is truncated.

2. On the other you reduce the overall number of extent lock/unlocks.

In either we should think about quantifying the impact, if any.

>  
>  		inode_dio_wait(inode);
>  
> @@ -8322,9 +8328,23 @@ static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
>  
>  static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
>  {
> +	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
> +	struct extent_map *em;
> +	int ret;
> +
>  	if (PageWriteback(page) || PageDirty(page))
>  		return 0;
> -	return __btrfs_releasepage(page, gfp_flags);
> +
> +	em = lookup_extent_mapping(&inode->extent_tree, page_offset(page),
> +			PAGE_SIZE - 1);
> +	if (!em)
> +		return 0;
> +	if (!try_lock_extent(&inode->io_tree, em->start, extent_map_end(em) - 1))
> +		return 0;
> +	ret = __btrfs_releasepage(page, gfp_flags);
> +	unlock_extent(&inode->io_tree, em->start, extent_map_end(em));
> +	free_extent_map(em);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_MIGRATION
> @@ -8398,9 +8418,6 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>  		return;
>  	}
>  
> -	if (!inode_evicting)
> -		lock_extent_bits(tree, page_start, page_end, &cached_state);
> -
>  	cur = page_start;
>  	while (cur < page_end) {
>  		struct btrfs_ordered_extent *ordered;
> @@ -8458,7 +8475,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>  		if (!inode_evicting)
>  			clear_extent_bit(tree, cur, range_end,
>  					 EXTENT_DELALLOC |
> -					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
> +					 EXTENT_DO_ACCOUNTING |
>  					 EXTENT_DEFRAG, 1, 0, &cached_state);
>  
>  		spin_lock_irq(&inode->ordered_tree.lock);
> @@ -8503,7 +8520,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>  		 */
>  		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
>  		if (!inode_evicting) {
> -			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
> +			clear_extent_bit(tree, cur, range_end,
>  				 EXTENT_DELALLOC | EXTENT_UPTODATE |
>  				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1,
>  				 delete_states, &cached_state);
> 
