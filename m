Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4757A77C062
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjHNTJJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 15:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjHNTI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 15:08:56 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F19C
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 12:08:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C81E95C00C6;
        Mon, 14 Aug 2023 15:08:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 15:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692040133; x=1692126533; bh=IR
        qqZI27ngDcTETv3tFRgZl6A40ZWcDq3DUOD2uSmTQ=; b=qz5p93Rs1OB572JBdT
        1deg/2kEZHSdep/RE0KwYdaQ9gwE76YLXkhn6/PGZ2qWApQWmu3ufyC5FeEuvs8J
        wqQLjCk+HtXDm9FW7I6wJSwoFTYzYyHwZr63200Bw6IwN5g6ru9lae0ZtwkbP3Og
        ff/LvMk1DR7nPGAD8sXtY7IpRKrJv0+9eNfeVlXD4kVViAg1oYmiVpio8A0451j+
        QfPq0qS662UaxpWGPD+SqONz/hB3ucyIKyTzFNLGfO3yQ67eMtX51K2q164VijLF
        1PBfvivsXDvlOCHRko/kdGIdjagYlz73jifsVROlrWu/jzAxXSh/4IQMYz9BNH3P
        jAtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692040133; x=1692126533; bh=IRqqZI27ngDcT
        ETv3tFRgZl6A40ZWcDq3DUOD2uSmTQ=; b=TFG99w0aPRbtDennbrQZtURdnTf8v
        LhpkJcgOtrtqYCYTdKVc8bXbPpNKEQ6GNggLp15CjTV8SYrzGUlKDwk3mafjxKuD
        alS0IOqnjROUhBpJp7Ayvy2eGyYlHCEv0e5LaKL7tXkfQYA4KP8EWYRmXgl7yagp
        PVU6sAFA5X1etAFWn9HFeI9QSL+8VU5VsxmE7w0k93VjMzaLs56Ko7hXf0rdbF77
        zESTgyhDv2GI6fWtv+7op/x22uSuT+x8+XHJrWhyZTt+i2UO9cSkTiJJ9laLBB8k
        8AWqUDPdPTCfvP3ThNpRBxDaIFkvtvHa1cxUfpZF8QOCXdlZisAlriWmQ==
X-ME-Sender: <xms:xXvaZM4f6D16iI8lC-0kLpWhz8UdiaOjmieXcfZvx8ZrX5XnEMtocg>
    <xme:xXvaZN66RiZnLs3T3M1-FHjSYjK8-a71_UoTHMMi0znTIIF1utvR1QjrI8A1b_xW3
    SH7oK6wNCmOQ4cF0y4>
X-ME-Received: <xmr:xXvaZLdcCZgjOvexBmBmTuLMMJPPiafiYWu-yMEUPDE_lUXDx8aiamoF9pyqVHIJwGkeUY5EGcBuwnTD_Hg5iLlZtZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddthedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:xXvaZBJQ4JT1OuzcOdHS92aJn8eLCgWDDAnG1PRqog-bdR1p6JZS2A>
    <xmx:xXvaZAIITpTAq_W4uY3B2GUdMtMJOgXarXiHjLAGC0vis0DxoIM9kg>
    <xmx:xXvaZCzRKd-698yRXVp9eBD1DCxk7NDzyZie0ncDZS1znUamFUZEhA>
    <xmx:xXvaZE2wUjJP5nG9YwWX5A2XIE5rNgVy6OnaSfwY6kYtJdXytWqFKw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 15:08:53 -0400 (EDT)
Date:   Mon, 14 Aug 2023 12:06:45 -0700
From:   Boris Burkov <boris@bur.io>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Convert btrfs_read_merkle_tree_page() to use a
 folio
Message-ID: <20230814190645.GA3998603@zen>
References: <20230814175208.810785-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814175208.810785-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 06:52:08PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove a number of hidden calls to compound_head() by using a folio
> throughout.  Also follow core kernel code style by adding the folio to
> the page cache immediately after allocation instead of doing the read
> first, then adding it to the page cache.  This ordering makes subsequent
> readers block waiting for the first reader instead of duplicating the
> work only to throw it away when they find out they lost the race.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The btrfs fs-verity fstests had bitrotted (some boring issues with
btrfs-progs) that I cleaned up locally and was able to test your change.
Code LGTM as well, thanks for the update.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/verity.c | 62 +++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index c5ff16f9e9fa..04d85db9bb58 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -715,7 +715,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  						pgoff_t index,
>  						unsigned long num_ra_pages)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	u64 off = (u64)index << PAGE_SHIFT;
>  	loff_t merkle_pos = merkle_file_pos(inode);
>  	int ret;
> @@ -726,29 +726,38 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  		return ERR_PTR(-EFBIG);
>  	index += merkle_pos >> PAGE_SHIFT;
>  again:
> -	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
> -	if (page) {
> -		if (PageUptodate(page))
> -			return page;
> +	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> +	if (!IS_ERR(folio)) {
> +		if (folio_test_uptodate(folio))
> +			goto out;
>  
> -		lock_page(page);
> +		folio_lock(folio);
>  		/*
> -		 * We only insert uptodate pages, so !Uptodate has to be
> -		 * an error
> +		 * If it's not uptodate after we have the lock, we got a
> +		 * read error.
>  		 */
> -		if (!PageUptodate(page)) {
> -			unlock_page(page);
> -			put_page(page);
> +		if (!folio_test_uptodate(folio)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			return ERR_PTR(-EIO);
>  		}
> -		unlock_page(page);
> -		return page;
> +		folio_unlock(folio);
> +		goto out;
>  	}
>  
> -	page = __page_cache_alloc(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS));
> -	if (!page)
> +	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS), 0);
> +	if (!folio)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ret = filemap_add_folio(inode->i_mapping, folio, index, GFP_NOFS);
> +	if (ret) {
> +		folio_put(folio);
> +		/* Did someone else insert a folio here? */
> +		if (ret == -EEXIST)
> +			goto again;
> +		return ERR_PTR(ret);
> +	}
> +
>  	/*
>  	 * Merkle item keys are indexed from byte 0 in the merkle tree.
>  	 * They have the form:
> @@ -756,28 +765,19 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  	 * [ inode objectid, BTRFS_MERKLE_ITEM_KEY, offset in bytes ]
>  	 */
>  	ret = read_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY, off,
> -			     page_address(page), PAGE_SIZE, page);
> +			     folio_address(folio), PAGE_SIZE, &folio->page);
>  	if (ret < 0) {
> -		put_page(page);
> +		folio_put(folio);
>  		return ERR_PTR(ret);
>  	}
>  	if (ret < PAGE_SIZE)
> -		memzero_page(page, ret, PAGE_SIZE - ret);
> +		folio_zero_segment(folio, ret, PAGE_SIZE);
>  
> -	SetPageUptodate(page);
> -	ret = add_to_page_cache_lru(page, inode->i_mapping, index, GFP_NOFS);
> +	folio_mark_uptodate(folio);
> +	folio_unlock(folio);
>  
> -	if (!ret) {
> -		/* Inserted and ready for fsverity */
> -		unlock_page(page);
> -	} else {
> -		put_page(page);
> -		/* Did someone race us into inserting this page? */
> -		if (ret == -EEXIST)
> -			goto again;
> -		page = ERR_PTR(ret);
> -	}
> -	return page;
> +out:
> +	return folio_file_page(folio, index);
>  }
>  
>  /*
> -- 
> 2.40.1
> 
