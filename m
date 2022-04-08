Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCA4F9BBB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiDHReK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiDHReJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 13:34:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00728CA90
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 10:32:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 266A11F864;
        Fri,  8 Apr 2022 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649439124;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LX5kQEOD/lCQ57o81tKkGspjCwzQfJ3GfDuHyCkExoo=;
        b=AYxqcbe7jVOwIK3gqJV5OyuBqYgp8EGP5jOtTDxLdAiHfE4Tr+UFh9a1CNqDwFDAlfvHid
        REyqETAbRbHbYr09KmUYwnGqk3ImwEQCAVPuhwJRuJ+IUexxF3neq0dZAvpzE0MeR4GFf/
        qGZswc3Sb76ZOUPlE4s+avnA7WGggHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649439124;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LX5kQEOD/lCQ57o81tKkGspjCwzQfJ3GfDuHyCkExoo=;
        b=eu9JZteLll4BAC8+thQygdaaGabkCgU26JkhwaczJI0tZGUgzw9x62zkcHj9bV6Kxv8zpQ
        nKXtGnhWx+kcb8DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1C3EBA3B83;
        Fri,  8 Apr 2022 17:32:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F306DA832; Fri,  8 Apr 2022 19:28:01 +0200 (CEST)
Date:   Fri, 8 Apr 2022 19:28:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/16] btrfs: open-code rbio_stripe_page_index()
Message-ID: <20220408172801.GY15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <dc402b70e4dea8f2ccda06c33896406caf918846.1648807440.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc402b70e4dea8f2ccda06c33896406caf918846.1648807440.git.wqu@suse.com>
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

On Fri, Apr 01, 2022 at 07:23:25PM +0800, Qu Wenruo wrote:
> There is only one caller for that helper now, and we're definitely fine
> to open-code it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 61df2b3636d2..998c30867554 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -699,12 +699,6 @@ static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
>  	return rbio_stripe_sector(rbio, rbio->nr_data + 1, sector_nr);
>  }
>  
> -static int rbio_stripe_page_index(struct btrfs_raid_bio *rbio, int stripe,
> -				  int index)
> -{
> -	return stripe * rbio->stripe_npages + index;
> -}
> -
>  /*
>   * The first stripe in the table for a logical address
>   * has the lock.  rbios are added in one of three ways:
> @@ -1131,9 +1125,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
>  	int i;
>  	struct page *page;
>  
> -	i = rbio_stripe_page_index(rbio, rbio->nr_data, 0);
> -
> -	for (; i < rbio->nr_pages; i++) {
> +	for (i = rbio->nr_data * rbio->stripe_npages; i < rbio->nr_pages; i++) {

The context has changed in misc-next so I applied it manually, there was
still just one caller so it was straightforward.

>  		if (rbio->stripe_pages[i])
>  			continue;
>  		page = alloc_page(GFP_NOFS);
> -- 
> 2.35.1
