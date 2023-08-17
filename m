Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD20077F677
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbjHQMcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350895AbjHQMb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 08:31:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC616210D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 05:31:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88D2C1F8A6;
        Thu, 17 Aug 2023 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692275514;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vInwKWW1Bezd9B3CC9bEyNyOY1EPBLpzD/XsSRvnUL4=;
        b=SlKnnlyriFCskLUi9MytApsQKUEOAPqSwGFzi1RbnGuA/sR2FWK8ma5+r2uB7RLvXgI+Ke
        N3kB1adx7DBi7Jro/bPMHIRO9HhFu9UVzVXacBuoGNbrP7DCVxYC02zHqvBtYGTV6EbByK
        Ff41h0RCo0aWrT3XSGKHSlWtJ1eBLAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692275514;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vInwKWW1Bezd9B3CC9bEyNyOY1EPBLpzD/XsSRvnUL4=;
        b=kY+vDm3HEiseUvWp0ZaNnm1oRhhcbHxoCWO7TzlAzUQ/vwCn2wCM3AG/VTWB7qvNQH4XYO
        eCXPzLZsmoqUxaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55BEA1392B;
        Thu, 17 Aug 2023 12:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YvtNFDoT3mQEYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 12:31:54 +0000
Date:   Thu, 17 Aug 2023 14:25:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Convert defrag_prepare_one_page() to use a
 folio
Message-ID: <20230817122525.GM2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230814170350.756488-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814170350.756488-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 06:03:49PM +0100, Matthew Wilcox (Oracle) wrote:
> Use a folio throughout defrag_prepare_one_page() to remove dozens of
> hidden calls to compound_head().  There is no support here for large
> folios; indeed, turn the existing check for PageCompound into a check
> for large folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/btrfs/defrag.c | 53 ++++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index f2ff4cbe8656..4392a09d2bb1 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -724,13 +724,14 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
>  	u64 page_start = (u64)index << PAGE_SHIFT;
>  	u64 page_end = page_start + PAGE_SIZE - 1;
>  	struct extent_state *cached_state = NULL;
> -	struct page *page;
> +	struct folio *folio;
>  	int ret;
>  
>  again:
> -	page = find_or_create_page(mapping, index, mask);
> -	if (!page)
> -		return ERR_PTR(-ENOMEM);
> +	folio = __filemap_get_folio(mapping, index,
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
> +	if (IS_ERR(folio))
> +		return &folio->page;
>  
>  	/*
>  	 * Since we can defragment files opened read-only, we can encounter
> @@ -740,16 +741,16 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
>  	 * executables that explicitly enable them, so this isn't very
>  	 * restrictive.
>  	 */
> -	if (PageCompound(page)) {
> -		unlock_page(page);
> -		put_page(page);
> +	if (folio_test_large(folio)) {
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		return ERR_PTR(-ETXTBSY);
>  	}
>  
> -	ret = set_page_extent_mapped(page);
> +	ret = set_page_extent_mapped(&folio->page);
>  	if (ret < 0) {
> -		unlock_page(page);
> -		put_page(page);
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		return ERR_PTR(ret);
>  	}
>  
> @@ -764,17 +765,17 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
>  		if (!ordered)
>  			break;
>  
> -		unlock_page(page);
> +		folio_unlock(folio);
>  		btrfs_start_ordered_extent(ordered);
>  		btrfs_put_ordered_extent(ordered);
> -		lock_page(page);
> +		folio_lock(folio);
>  		/*
> -		 * We unlocked the page above, so we need check if it was
> +		 * We unlocked the folio above, so we need check if it was
>  		 * released or not.
>  		 */
> -		if (page->mapping != mapping || !PagePrivate(page)) {
> -			unlock_page(page);
> -			put_page(page);
> +		if (folio->mapping != mapping || !folio->private) {

Handling the private bit is probably the only thing that's not a direct
API conversion. I'd assume that PagePrivate should be folio_test_private()
or the private pointer should be read via folio_get_private(), not
directly.
