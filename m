Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E784F9AE1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiDHQq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiDHQq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 12:46:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A7910E9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 09:44:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0ED4921600;
        Fri,  8 Apr 2022 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649436292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fej7EIjPS7aTLaQ7Uola4OVyZoIqd2KWQijqKnAMikU=;
        b=3GcITetI37ZiIJ+m2it2qZkp6H1Glz944HAJEaOp/SRDHyhmvJp6RDWb2Byvp8WSzJ5Q8M
        u+W8mmTs2PuXA3NrqUIWnLzTkE+QwfZFt5WO8RwMGrlcDio6JP807IkbMhRi0GnAu2BUPx
        xd/pxacB7qbK50QfcvtwtY+bSHXk0TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649436292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fej7EIjPS7aTLaQ7Uola4OVyZoIqd2KWQijqKnAMikU=;
        b=uNn8n9phuJs2ZBVs6v9SzH0P/2kX9wpi2eWNSsPO3BS5HopzTNIqG85rE6lzfYPTktO46G
        C5jHkLOpT61e6YDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 06BFCA3B82;
        Fri,  8 Apr 2022 16:44:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 403F8DA832; Fri,  8 Apr 2022 18:40:49 +0200 (CEST)
Date:   Fri, 8 Apr 2022 18:40:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/16] btrfs: introduce btrfs_raid_bio::stripe_sectors
Message-ID: <20220408164049.GU15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <3a178d6547fc13b561535194f9dff41f9b4fa4d4.1648807440.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a178d6547fc13b561535194f9dff41f9b4fa4d4.1648807440.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 01, 2022 at 07:23:19PM +0800, Qu Wenruo wrote:
> The new member is an array of sector_ptr pointers, they will represent
> all sectors inside a full stripe (including P/Q).
> 
> They co-operate with btrfs_raid_bio::stripe_pages:
> 
> stripe_pages:   | Page 0, range [0, 64K)   | Page 1 ...
> stripe_sectors: |  |  | ...             |  |
>                   |  |                    \- sector 15, page 0, pgoff=60K
>                   |  \- sector 1, page 0, pgoff=4K
>                   \---- sector 0, page 0, pfoff=0
> 
> With such structure, we can represent subpage sectors without using
> extra pages.
> 
> Here we introduce a new helper, index_stripe_sectors(), to update
> stripe_sectors[] to point to correct page and pgoff.
> 
> So every time rbio::stripe_pages[] pointer gets updated, the new helper
> should be called.
> 
> The following functions have to call the new helper:
> 
> - steal_rbio()
> - alloc_rbio_pages()
> - alloc_rbio_parity_pages()
> - alloc_rbio_essential_pages()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c | 62 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 1bad7d3a0331..8cfe00db79c9 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -52,6 +52,16 @@ struct btrfs_stripe_hash_table {
>  	struct btrfs_stripe_hash table[];
>  };
>  
> +/*
> + * A bvec like structure to present a sector inside a page.
> + *
> + * Unlike bvec we don't need bvlen, as it's fixed to sectorsize.
> + */
> +struct sector_ptr {
> +	struct page *page;
> +	unsigned int pgoff;
> +} __attribute__ ((__packed__));

Packed does not make much sense here, it's an in-memory structure and
there are no savings, besides that packed structures may force unaligned
access.

> +
>  enum btrfs_rbio_ops {
>  	BTRFS_RBIO_WRITE,
>  	BTRFS_RBIO_READ_REBUILD,
> @@ -154,25 +164,27 @@ struct btrfs_raid_bio {
>  
>  	atomic_t error;
>  	/*
> -	 * these are two arrays of pointers.  We allocate the
> +	 * These are two arrays of pointers.  We allocate the

Please don't fix comments that you don't move or change, this is
unrelated change.

>  	 * rbio big enough to hold them both and setup their
>  	 * locations when the rbio is allocated
>  	 */
>  
> -	/* pointers to pages that we allocated for
> +	/*
> +	 * Pointers to pages that we allocated for

Same

>  	 * reading/writing stripes directly from the disk (including P/Q)
>  	 */
>  	struct page **stripe_pages;
>  
> -	/*
> -	 * pointers to the pages in the bio_list.  Stored
> -	 * here for faster lookup
> -	 */
> +	/* Pointers to the pages in the bio_list, for faster lookup */
>  	struct page **bio_pages;
>  
>  	/*
> -	 * bitmap to record which horizontal stripe has data
> +	 * For subpage support, we need to map each sector to above
> +	 * stripe_pages.
>  	 */
> +	struct sector_ptr *stripe_sectors;
> +
> +	/* Bitmap to record which horizontal stripe has data */

So this one got moved and it's fine to update.

>  	unsigned long *dbitmap;
>  
>  	/* allocated with real_stripes-many pointers for finish_*() calls */
