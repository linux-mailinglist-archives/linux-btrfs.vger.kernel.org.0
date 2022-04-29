Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47836514DCC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377668AbiD2Opb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377764AbiD2OpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:45:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717F062BEB
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:41:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9CBB1F893;
        Fri, 29 Apr 2022 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651243309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0OGzoAxMDJ4HqCEe/PwD4ZZuSg91MXOo7xhKBQqZfM=;
        b=jrT+CB2MD/q2BIt1Bt6IyQH0jlfQ9Umk/UAGXZQAPgo9SfzdhtpTtOMwX7buiE/VTiL2Tr
        yNLUxUwIa5yOfXiUGMZ4T8PY7csapkXaJdYbnL8P51csC+NpZqmvjPtDSyBhhn7bkDCyXK
        Qvuz7pJrt6I4eCdQzePEqJWDJKF+Fxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651243309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0OGzoAxMDJ4HqCEe/PwD4ZZuSg91MXOo7xhKBQqZfM=;
        b=6mj9D7WC9+k7SGjiexL5G5Xv5ND4Ag8JBykp2S0K8D6B0272gJwyGtuHO4gWPL2OP7ofkD
        /korFI+QITlymsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C3A413AE0;
        Fri, 29 Apr 2022 14:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jFYjGi35a2LjGwAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 29 Apr 2022 14:41:49 +0000
Date:   Fri, 29 Apr 2022 09:41:47 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
Subject: Re: [PATCH] btrfs: Remove unnecessary inode_need_compress() check
Message-ID: <20220429144147.xhfiqj27whufoyvt@fiona>
References: <20220428200735.j3yxdpi6fgdptsph@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428200735.j3yxdpi6fgdptsph@fiona>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Apparently, BTRFS_INODE_NOCOMPRESS can change runtime, so this patch is
incorrect. Sorry.

On 15:07 28/04, Goldwyn Rodrigues wrote:
> async extent writes are called only for compressed range. So, remove the
> check for inode_need_compress() in compress_file_range() since it is
> already checked in btrfs_run_delalloc_range().
> 
> Conditions for inode_can_compress() can be incorporated in
> inode_need_compress()
> 
> To make the code more elegant, change the condition order in
> btrfs_run_delalloc_range().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 126 ++++++++++++++++++++---------------------------
>  1 file changed, 54 insertions(+), 72 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4dfc02fbbad5..a89768963d9f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -480,17 +480,6 @@ static noinline int add_async_extent(struct async_chunk *cow,
>  	return 0;
>  }
>  
> -/*
> - * Check if the inode has flags compatible with compression
> - */
> -static inline bool inode_can_compress(struct btrfs_inode *inode)
> -{
> -	if (inode->flags & BTRFS_INODE_NODATACOW ||
> -	    inode->flags & BTRFS_INODE_NODATASUM)
> -		return false;
> -	return true;
> -}
> -
>  /*
>   * Check if the inode needs to be submitted to compression, based on mount
>   * options, defragmentation, properties or heuristics.
> @@ -500,12 +489,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  
> -	if (!inode_can_compress(inode)) {
> -		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> -			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
> -			btrfs_ino(inode));
> +	/*
> +	 * Check if the inode has flags compatible with compression
> +	 */
> +	if (inode->flags & BTRFS_INODE_NODATACOW ||
> +	    inode->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
> -	}
> +
>  	/*
>  	 * Special check for subpage.
>  	 *
> @@ -661,62 +651,55 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>  	total_in = 0;
>  	ret = 0;
>  
> -	/*
> -	 * we do compression for mount -o compress and when the
> -	 * inode has not been flagged as nocompress.  This flag can
> -	 * change at any time if we discover bad compression ratios.
> -	 */
> -	if (inode_need_compress(BTRFS_I(inode), start, end)) {
> -		WARN_ON(pages);
> -		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> -		if (!pages) {
> -			/* just bail out to the uncompressed code */
> -			nr_pages = 0;
> -			goto cont;
> -		}
> +	WARN_ON(pages);
> +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> +	if (!pages) {
> +		/* just bail out to the uncompressed code */
> +		nr_pages = 0;
> +		goto cont;
> +	}
>  
> -		if (BTRFS_I(inode)->defrag_compress)
> -			compress_type = BTRFS_I(inode)->defrag_compress;
> -		else if (BTRFS_I(inode)->prop_compress)
> -			compress_type = BTRFS_I(inode)->prop_compress;
> +	if (BTRFS_I(inode)->defrag_compress)
> +		compress_type = BTRFS_I(inode)->defrag_compress;
> +	else if (BTRFS_I(inode)->prop_compress)
> +		compress_type = BTRFS_I(inode)->prop_compress;
>  
> -		/*
> -		 * we need to call clear_page_dirty_for_io on each
> -		 * page in the range.  Otherwise applications with the file
> -		 * mmap'd can wander in and change the page contents while
> -		 * we are compressing them.
> -		 *
> -		 * If the compression fails for any reason, we set the pages
> -		 * dirty again later on.
> -		 *
> -		 * Note that the remaining part is redirtied, the start pointer
> -		 * has moved, the end is the original one.
> -		 */
> -		if (!redirty) {
> -			extent_range_clear_dirty_for_io(inode, start, end);
> -			redirty = 1;
> -		}
> +	/*
> +	 * we need to call clear_page_dirty_for_io on each
> +	 * page in the range.  Otherwise applications with the file
> +	 * mmap'd can wander in and change the page contents while
> +	 * we are compressing them.
> +	 *
> +	 * If the compression fails for any reason, we set the pages
> +	 * dirty again later on.
> +	 *
> +	 * Note that the remaining part is redirtied, the start pointer
> +	 * has moved, the end is the original one.
> +	 */
> +	if (!redirty) {
> +		extent_range_clear_dirty_for_io(inode, start, end);
> +		redirty = 1;
> +	}
>  
> -		/* Compression level is applied here and only here */
> -		ret = btrfs_compress_pages(
> +	/* Compression level is applied here and only here */
> +	ret = btrfs_compress_pages(
>  			compress_type | (fs_info->compress_level << 4),
> -					   inode->i_mapping, start,
> -					   pages,
> -					   &nr_pages,
> -					   &total_in,
> -					   &total_compressed);
> +			inode->i_mapping, start,
> +			pages,
> +			&nr_pages,
> +			&total_in,
> +			&total_compressed);
>  
> -		if (!ret) {
> -			unsigned long offset = offset_in_page(total_compressed);
> -			struct page *page = pages[nr_pages - 1];
> +	if (!ret) {
> +		unsigned long offset = offset_in_page(total_compressed);
> +		struct page *page = pages[nr_pages - 1];
>  
> -			/* zero the tail end of the last page, we might be
> -			 * sending it down to disk
> -			 */
> -			if (offset)
> -				memzero_page(page, offset, PAGE_SIZE - offset);
> -			will_compress = 1;
> -		}
> +		/* zero the tail end of the last page, we might be
> +		 * sending it down to disk
> +		 */
> +		if (offset)
> +			memzero_page(page, offset, PAGE_SIZE - offset);
> +		will_compress = 1;
>  	}
>  cont:
>  	/*
> @@ -2019,18 +2002,17 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, nr_written);
> -	} else if (!inode_can_compress(inode) ||
> -		   !inode_need_compress(inode, start, end)) {
> +	} else if (inode_need_compress(inode, start, end)) {
> +		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
> +		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
> +					   page_started, nr_written);
> +	} else {
>  		if (zoned)
>  			ret = run_delalloc_zoned(inode, locked_page, start, end,
>  						 page_started, nr_written);
>  		else
>  			ret = cow_file_range(inode, locked_page, start, end,
>  					     page_started, nr_written, 1);
> -	} else {
> -		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
> -		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
> -					   page_started, nr_written);
>  	}
>  	ASSERT(ret <= 0);
>  	if (ret)
> -- 
> 2.35.3
> 
> 
> -- 
> Goldwyn

-- 
Goldwyn
