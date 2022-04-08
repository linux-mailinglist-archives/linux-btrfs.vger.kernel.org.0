Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49FC4F9B0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiDHQxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiDHQw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 12:52:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24639B858
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 09:50:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7FE421602;
        Fri,  8 Apr 2022 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649436650;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AY0xuac9OP43lxO0c5s4GGBRf6L0cK5z4N3pxAqmxnw=;
        b=UQFzSYSbLEOR9DmOs70j1jjJ6isJ7E0QNNUkuA0CAIH7tpjQKfcVBthU9ecQYd3j4VPhC+
        BsFJY24iEGSWCuwzx/GO52DBmlEEErzRAOi9Bt6olawpxmIw3A3rfoiSh+k2DqpMVClALS
        PZmwFYs5pzCRXXDaO53V/QbMJjwVMQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649436650;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AY0xuac9OP43lxO0c5s4GGBRf6L0cK5z4N3pxAqmxnw=;
        b=XWT+dmbl5PY71zKADKaihFVfU4oXhyAl/0S1HSkp9ygo5FBhIVG+wiwRpmj27Ip5L01Nbp
        vc9tIb7vvCcfN0DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CEEB4A3B82;
        Fri,  8 Apr 2022 16:50:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07CF5DA832; Fri,  8 Apr 2022 18:46:47 +0200 (CEST)
Date:   Fri, 8 Apr 2022 18:46:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/16] btrfs: introduce btrfs_raid_bio::bio_sectors
Message-ID: <20220408164647.GV15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <5737a015d302fb7cb3774deb3115f0e8a26258db.1648807440.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5737a015d302fb7cb3774deb3115f0e8a26258db.1648807440.git.wqu@suse.com>
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

On Fri, Apr 01, 2022 at 07:23:20PM +0800, Qu Wenruo wrote:
> This new member is going to fully replace bio_pages in the future, but
> for now let's keep them co-exist, until the full switch is done.
> 
> Currently cache_rbio_pages() and index_rbio_pages() will also populate
> the new array.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 8cfe00db79c9..f23fd282d298 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -60,6 +60,7 @@ struct btrfs_stripe_hash_table {
>  struct sector_ptr {
>  	struct page *page;
>  	unsigned int pgoff;
> +	unsigned int uptodate:1;
>  } __attribute__ ((__packed__));

Even with packed this does not help as the full in is allocated for the
single bit and it requires bit operations to set/clear. Up to 4 bools
fit into one int and using them is better.

>  
>  enum btrfs_rbio_ops {
> @@ -175,6 +176,9 @@ struct btrfs_raid_bio {
>  	 */
>  	struct page **stripe_pages;
>  
> +	/* Pointers to the sectors in the bio_list, for faster lookup */
> +	struct sector_ptr *bio_sectors;
> +
>  	/* Pointers to the pages in the bio_list, for faster lookup */
>  	struct page **bio_pages;
>  
> @@ -282,6 +286,24 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
>  		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
>  		SetPageUptodate(rbio->stripe_pages[i]);
>  	}
> +
> +	/*
> +	 * TODO: This work is duplicated with above loop, should remove above

I think I told you several times, please don't write TODO notes. A plain
comment explaining that the loop is duplicated is understandable by
itself.

> +	 * loop when the switch is fully done.
> +	 */
> +	for (i = 0; i < rbio->nr_sectors; i++) {
> +		/* Some range not covered by bio (partial write), skip it */
> +		if (!rbio->bio_sectors[i].page)
> +			continue;
> +
> +		ASSERT(rbio->stripe_sectors[i].page);
> +		memcpy_page(rbio->stripe_sectors[i].page,
> +			    rbio->stripe_sectors[i].pgoff,
> +			    rbio->bio_sectors[i].page,
> +			    rbio->bio_sectors[i].pgoff,
> +			    rbio->bioc->fs_info->sectorsize);
> +		rbio->stripe_sectors[i].uptodate = 1;
> +	}
>  	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
>  }
>  
