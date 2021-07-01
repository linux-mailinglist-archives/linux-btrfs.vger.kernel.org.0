Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3A3B9515
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhGARB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 13:01:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGARB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 13:01:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C1C522919;
        Thu,  1 Jul 2021 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625158736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GsDwAxV7S7YCWVu4W3b3kxMMQLgZLt2oBK1TcJbCBHQ=;
        b=LA3j2wPpKirDO3+sgHa7R0GT8C/c/NGQ9gRR7yiZeyIt50M3kXTWVqXPK+UstCqZlYBvUp
        EFhDTe9Bmx+rCdP3y8WusBfYcDWBme+SJkgXHsDqURiiR2WF9Oqo7LZRkBS91tDu8pKYsk
        s4SIw1dSkJp62aYMyCwC1Yc0ySrcVso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625158736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GsDwAxV7S7YCWVu4W3b3kxMMQLgZLt2oBK1TcJbCBHQ=;
        b=np9WtCpQi2nOjBnQkL6MfogbYLAC+5fOaopx8CX2/PP7wUbTg6xBnoTpGkwShGH05bIaLw
        9yuyDmeOJWZONwBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 75C73A3B87;
        Thu,  1 Jul 2021 16:58:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7FF6DA6FD; Thu,  1 Jul 2021 18:56:25 +0200 (CEST)
Date:   Thu, 1 Jul 2021 18:56:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 02/10] btrfs: defrag: extract the page preparation
 code into one helper
Message-ID: <20210701165625.GY2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210610050917.105458-1-wqu@suse.com>
 <20210610050917.105458-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610050917.105458-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 10, 2021 at 01:09:09PM +0800, Qu Wenruo wrote:
> +static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
> +					    unsigned long index)
> +{
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	gfp_t mask = btrfs_alloc_write_mask(mapping);
> +	u64 page_start = index << PAGE_SHIFT;
> +	u64 page_end = page_start + PAGE_SIZE - 1;
> +	struct extent_state *cached_state = NULL;
> +	struct page *page;
> +	int ret;
> +
> +again:
> +	page = find_or_create_page(mapping, index, mask);
> +	if (!page)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = set_page_extent_mapped(page);
> +	if (ret < 0) {
> +		unlock_page(page);
> +		put_page(page);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Wait for any exists ordered extent in the range */
> +	while (1) {
> +		struct btrfs_ordered_extent *ordered;
> +
> +		lock_extent_bits(&inode->io_tree, page_start, page_end,
> +				 &cached_state);
> +		ordered = btrfs_lookup_ordered_range(inode, page_start,
> +						     PAGE_SIZE);
> +		unlock_extent_cached(&inode->io_tree, page_start, page_end,
> +				     &cached_state);
> +		if (!ordered)
> +			break;
> +
> +		unlock_page(page);
> +		btrfs_start_ordered_extent(ordered, 1);
> +		btrfs_put_ordered_extent(ordered);
> +		lock_page(page);
> +		/*
> +		 * we unlocked the page above, so we need check if
> +		 * it was released or not.
> +		 */
> +		if (page->mapping != mapping || !PagePrivate(page)) {
> +			unlock_page(page);
> +			put_page(page);
> +			goto again;
> +		}
> +	}
> +
> +	/*
> +	 * Now the page range has no ordered extent any more.
> +	 * Read the page to make it uptodate.
> +	 */
> +	if (!PageUptodate(page)) {
> +		btrfs_readpage(NULL, page);
> +		lock_page(page);
> +		if (page->mapping != mapping || !PagePrivate(page)) {
> +			unlock_page(page);
> +			put_page(page);
> +			goto again;
> +		}
> +		if (!PageUptodate(page)) {
> +			unlock_page(page);
> +			put_page(page);
> +			return ERR_PTR(-EIO);
> +		}
> +	}
> +
> +	wait_on_page_writeback(page);

Wait for one page

> +	return page;
> +}
> +
>  /*
>   * it doesn't do much good to defrag one or two pages
>   * at a time.  This pulls in a nice chunk of pages
> @@ -1170,11 +1253,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
>  	int ret;
>  	int i;
>  	int i_done;
> -	struct btrfs_ordered_extent *ordered;
>  	struct extent_state *cached_state = NULL;
> -	struct extent_io_tree *tree;
>  	struct extent_changeset *data_reserved = NULL;
> -	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
>  
>  	file_end = (isize - 1) >> PAGE_SHIFT;
>  	if (!isize || start_index > file_end)
> @@ -1187,68 +1267,16 @@ static int cluster_pages_for_defrag(struct inode *inode,
>  	if (ret)
>  		return ret;
>  	i_done = 0;
> -	tree = &BTRFS_I(inode)->io_tree;
>  
>  	/* step one, lock all the pages */
>  	for (i = 0; i < page_cnt; i++) {
>  		struct page *page;
> -again:
> -		page = find_or_create_page(inode->i_mapping,
> -					   start_index + i, mask);
> -		if (!page)
> -			break;
>  
> -		ret = set_page_extent_mapped(page);
> -		if (ret < 0) {
> -			unlock_page(page);
> -			put_page(page);
> +		page = defrag_prepare_one_page(BTRFS_I(inode), start_index + i);

The loop goes one page a time

> +		if (IS_ERR(page)) {
> +			ret = PTR_ERR(page);
>  			break;
>  		}
> -
> -		page_start = page_offset(page);
> -		page_end = page_start + PAGE_SIZE - 1;
> -		while (1) {
> -			lock_extent_bits(tree, page_start, page_end,
> -					 &cached_state);
> -			ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode),
> -							      page_start);
> -			unlock_extent_cached(tree, page_start, page_end,
> -					     &cached_state);
> -			if (!ordered)
> -				break;
> -
> -			unlock_page(page);
> -			btrfs_start_ordered_extent(ordered, 1);
> -			btrfs_put_ordered_extent(ordered);
> -			lock_page(page);
> -			/*
> -			 * we unlocked the page above, so we need check if
> -			 * it was released or not.
> -			 */
> -			if (page->mapping != inode->i_mapping) {
> -				unlock_page(page);
> -				put_page(page);
> -				goto again;
> -			}
> -		}
> -
> -		if (!PageUptodate(page)) {
> -			btrfs_readpage(NULL, page);
> -			lock_page(page);
> -			if (!PageUptodate(page)) {
> -				unlock_page(page);
> -				put_page(page);
> -				ret = -EIO;
> -				break;
> -			}
> -		}
> -
> -		if (page->mapping != inode->i_mapping) {
> -			unlock_page(page);
> -			put_page(page);
> -			goto again;
> -		}
> -
>  		pages[i] = page;
>  		i_done++;
>  	}
> @@ -1258,13 +1286,6 @@ static int cluster_pages_for_defrag(struct inode *inode,
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE))
>  		goto out;
>  
> -	/*
> -	 * so now we have a nice long stream of locked
> -	 * and up to date pages, lets wait on them
> -	 */
> -	for (i = 0; i < i_done; i++)
> -		wait_on_page_writeback(pages[i]);

So here it's making a big difference: originally, lots of pages have
been started and then waited for, while you change it to start+wait for
each page, that does not seem right.

> -
>  	page_start = page_offset(pages[0]);
>  	page_end = page_offset(pages[i_done - 1]) + PAGE_SIZE;
>  
> -- 
> 2.32.0
