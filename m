Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0257A4EDFCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiCaRlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCaRlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 13:41:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FF15280A;
        Thu, 31 Mar 2022 10:39:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A5E201F7AC;
        Thu, 31 Mar 2022 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648748364;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNcgLh6DoJ9DDbDIFiiw9A3K3hiKEzb8GtkO14hUjeY=;
        b=EV3xXJjoDGHZ28OkkQp9sGfXg5wy7n0OaVmEqkhYgaC2CTkunPsB6KyFMyXCVafNYGUg4W
        CSvtIKY5Q69+vH4SWH1S6zBsdm3aA51AlwlEBckIlbOPi37lqnxUJzAHyaZcOkhnr5uijP
        RXy4Ie629fUKCjoUNeUw7Lu7pMq74lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648748364;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNcgLh6DoJ9DDbDIFiiw9A3K3hiKEzb8GtkO14hUjeY=;
        b=sWxHHqfJb1nrDnuP02nLZPtpfBAE77ZyOnC22F2O32YZzIvxyekpvs6yogd+ZVGmDpXCtJ
        VqtI3dkCsP5aGYBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9A0F9A3B83;
        Thu, 31 Mar 2022 17:39:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F8D7DA7F3; Thu, 31 Mar 2022 19:35:25 +0200 (CEST)
Date:   Thu, 31 Mar 2022 19:35:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 2/2] btrfs: allocate page arrays using bulk page
 allocator
Message-ID: <20220331173525.GF15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>
References: <cover.1648669832.git.sweettea-kernel@dorminy.me>
 <ede1d39f7878ee2ed12c1526cc2ec358a2d862cf.1648669832.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede1d39f7878ee2ed12c1526cc2ec358a2d862cf.1648669832.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 04:11:23PM -0400, Sweet Tea Dorminy wrote:
> While calling alloc_page() in a loop is an effective way to populate an
> array of pages, the kernel provides a method to allocate pages in bulk.
> alloc_pages_bulk_array() populates the NULL slots in a page array, trying to
> grab more than one page at a time.
> 
> Unfortunately, it doesn't guarantee allocating all slots in the array,
> but it's easy to call it in a loop and return an error if no progress
> occurs. Similar code can be found in xfs/xfs_buf.c:xfs_buf_alloc_pages().
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
> Changes in v3:
>  - Added a newline after variable declaration
> Changes in v2:
>  - Moved from ctree.c to extent_io.c
> ---
>  fs/btrfs/extent_io.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ab4c1c4d1b59..b268e47aa2b7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3144,19 +3144,25 @@ static void end_bio_extent_readpage(struct bio *bio)
>   */
>  int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array)
>  {
> -	int i;
> +	long allocated = 0;
> +
> +	for (;;) {
> +		long last = allocated;
>  
> -	for (i = 0; i < nr_pages; i++) {
> -		struct page *page;
> +		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages,
> +						   page_array);
> +		if (allocated == nr_pages)
> +			return 0;
>  
> -		if (page_array[i])
> +		if (allocated != last)
>  			continue;
> -		page = alloc_page(GFP_NOFS);
> -		if (!page)
> -			return -ENOMEM;
> -		page_array[i] = page;
> +		/*
> +		 * During this iteration, no page could be allocated, even
> +		 * though alloc_pages_bulk_array() falls back to alloc_page()
> +		 * if  it could not bulk-allocate. So we must be out of memory.
> +		 */
> +		return -ENOMEM;
>  	}

I find the way the loop is structured a bit cumbersome so I'd suggest to
rewrite it as:

int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
{
        unsigned int allocated;

        for (allocated = 0; allocated < nr_pages;) {
                unsigned int last = allocated;

                allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);

                /*
                 * During this iteration, no page could be allocated, even
                 * though alloc_pages_bulk_array() falls back to alloc_page()
                 * if  it could not bulk-allocate. So we must be out of memory.
                 */
                if (allocated == last)
                        return -ENOMEM;
        }
        return 0;
}

Also in the xfs code there's memalloc_retry_wait() which is supposed to be
called when repeated memory allocation is retried. What was the reason
you removed it?
