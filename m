Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B227B3F5102
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhHWTIF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:08:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTIE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:08:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE89E21EFC;
        Mon, 23 Aug 2021 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629745640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POb9u77dZJ6CLIE+poZcway8Q+LEJWx3EaIEAWkLcCY=;
        b=IM4scdPX7zWGtK+2T9oi1mzOe89gceeRRz0nu98IJUUcr/+lpkdLjMyO+y/EVYe7yA641Y
        Z1aC5PKogNBJp9FsEIL3DUlOu3qVwjkyngFBdo3IOAh40Vu1w4/e+5cAKD6m+evXgWyWiI
        FZWuQf4zpoUAeNPudnmsIwnowY1n5MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629745640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POb9u77dZJ6CLIE+poZcway8Q+LEJWx3EaIEAWkLcCY=;
        b=7PCwdvgbTB5MfTgWnivU9a/KF3C9ZVmn2I+1qE5zX5C4asWkSoLhdVVFJUyoMxY4DQLBs9
        5RyWodbwTeFyO2DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E785EA3BBC;
        Mon, 23 Aug 2021 19:07:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6CBB3DA725; Mon, 23 Aug 2021 21:04:21 +0200 (CEST)
Date:   Mon, 23 Aug 2021 21:04:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 04/11] btrfs: defrag: extract the page preparation
 code into one helper
Message-ID: <20210823190420.GO5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210806081242.257996-1-wqu@suse.com>
 <20210806081242.257996-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081242.257996-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 04:12:35PM +0800, Qu Wenruo wrote:
> +					    pgoff_t index)
> +{
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	gfp_t mask = btrfs_alloc_write_mask(mapping);
> +	u64 page_start = index << PAGE_SHIFT;

This needs (u64)index << PAGE_SHIFT, the types are not 64bit safe.

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
                        existing

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

Please reformat comments that are moved

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

Same.

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
> +	return page;
> +}
