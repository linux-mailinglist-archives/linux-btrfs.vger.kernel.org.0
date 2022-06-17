Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6754654F51A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381739AbiFQKPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381717AbiFQKPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:15:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B56A003
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFFD5B82859
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 10:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7FBC3411B;
        Fri, 17 Jun 2022 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655460917;
        bh=nQX0kr61Cw98PG1TV3WdzKXy5WQhvM5PVb3B0e0QDXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsv0sOEC/paHbytNF298yMhKSXdOTDIurkAHPCmTpaGL+2U6Kkvnle2RwcicbHVhg
         37QrwVCZh+AmNeBq3EM71ha7CNl8jSqE5TdL2rP0TnH1dY3J6iNV8JBx52cK5w8i8D
         O1B3uwDfKgrqp5xz3iTpAFRNlwpHMp9qKM8/Z1HjW+/7GpjLZ+tTDOgxB0xUNpQhdg
         h7yG8LnhxYrzEU6zZuKNgyjFIlw3n8aCsHYD5KYwEwY/OXFi60nDQZ7m+2bgzyKb4a
         sMFQW/UyOUs9A0pdXW30aHZz069rEXisVH1HGu/KjpNpp106IPJV1zlrIFQY85lqrg
         dOtnUf6X9xlpA==
Date:   Fri, 17 Jun 2022 11:15:15 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: extend btrfs_cleanup_ordered_extens for NULL
 locked_page
Message-ID: <20220617101515.GC4041436@falcondesktop>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <6de954aed27f8e5ebccd780bbc40ce37a6ddf4f1.1655391633.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de954aed27f8e5ebccd780bbc40ce37a6ddf4f1.1655391633.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 12:45:40AM +0900, Naohiro Aota wrote:
> btrfs_cleanup_ordered_extents() assumes locked_page to be non-NULL, so it
> is not usable for submit_uncompressed_range() which can habe NULL
> locked_page.
> 
> This commit supports locked_page == NULL case. Also, it rewrites redundant
> "page_offset(locked_page)".

The patch looks fine, but I don't see any patch in the patchset that actually
makes submit_uncompressed_range() use btrfs_cleanup_ordered_extents().
Did you forgot that, or am I missing something?

Thanks.

> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0c3d9998470f..4e1100f84a88 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -195,11 +195,14 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
>  {
>  	unsigned long index = offset >> PAGE_SHIFT;
>  	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
> -	u64 page_start = page_offset(locked_page);
> -	u64 page_end = page_start + PAGE_SIZE - 1;
> -
> +	u64 page_start, page_end;
>  	struct page *page;
>  
> +	if (locked_page) {
> +		page_start = page_offset(locked_page);
> +		page_end = page_start + PAGE_SIZE - 1;
> +	}
> +
>  	while (index <= end_index) {
>  		/*
>  		 * For locked page, we will call end_extent_writepage() on it
> @@ -212,7 +215,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
>  		 * btrfs_mark_ordered_io_finished() would skip the accounting
>  		 * for the page range, and the ordered extent will never finish.
>  		 */
> -		if (index == (page_offset(locked_page) >> PAGE_SHIFT)) {
> +		if (locked_page && index == (page_start >> PAGE_SHIFT)) {
>  			index++;
>  			continue;
>  		}
> @@ -231,17 +234,20 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
>  		put_page(page);
>  	}
>  
> -	/* The locked page covers the full range, nothing needs to be done */
> -	if (bytes + offset <= page_offset(locked_page) + PAGE_SIZE)
> -		return;
> -	/*
> -	 * In case this page belongs to the delalloc range being instantiated
> -	 * then skip it, since the first page of a range is going to be
> -	 * properly cleaned up by the caller of run_delalloc_range
> -	 */
> -	if (page_start >= offset && page_end <= (offset + bytes - 1)) {
> -		bytes = offset + bytes - page_offset(locked_page) - PAGE_SIZE;
> -		offset = page_offset(locked_page) + PAGE_SIZE;
> +	if (locked_page) {
> +		/* The locked page covers the full range, nothing needs to be done */
> +		if (bytes + offset <= page_start + PAGE_SIZE)
> +			return;
> +		/*
> +		 * In case this page belongs to the delalloc range being
> +		 * instantiated then skip it, since the first page of a range is
> +		 * going to be properly cleaned up by the caller of
> +		 * run_delalloc_range
> +		 */
> +		if (page_start >= offset && page_end <= (offset + bytes - 1)) {
> +			bytes = offset + bytes - page_offset(locked_page) - PAGE_SIZE;
> +			offset = page_offset(locked_page) + PAGE_SIZE;
> +		}
>  	}
>  
>  	return __endio_write_update_ordered(inode, offset, bytes, false);
> -- 
> 2.35.1
> 
