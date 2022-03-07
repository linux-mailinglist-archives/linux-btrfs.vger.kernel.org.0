Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA84D044D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiCGQlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 11:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiCGQlg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 11:41:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA535AA7A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 08:40:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E3A111F37C;
        Mon,  7 Mar 2022 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646671240;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmpi0xjxTyE5HnklM22SozX56Jx37At20u/RXyVR6Tk=;
        b=13xuR/2JH2+19kp9BTmYrZ//JAaoC/IwKaickjHJeqpUpkYTVyWEdZvoBbwz9rgNwrTvI+
        xqum+q3qsS07nEzW7pntK/xFym1XxDIrvKWlit9jrfLc+iFRr8XYPNaqZirAkYlUBS4qzs
        MxLnEnfM9OZtHeNhbuEvMYScwcS5XrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646671240;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmpi0xjxTyE5HnklM22SozX56Jx37At20u/RXyVR6Tk=;
        b=1JwbrdFEfSpcuiSdfRD+y+W2+aUFPfYjFFTQvj51N+TzPRTCdzp6GnwOmjg670iDSEOajp
        /8Cr10mHYVVf5sCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DE154A3B81;
        Mon,  7 Mar 2022 16:40:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29F9ADA7F7; Mon,  7 Mar 2022 17:36:46 +0100 (CET)
Date:   Mon, 7 Mar 2022 17:36:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: scrub: make scrub uses less memory for
 metadata scrub
Message-ID: <20220307163645.GJ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646210051.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646210051.git.wqu@suse.com>
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

On Wed, Mar 02, 2022 at 04:44:03PM +0800, Qu Wenruo wrote:
> Although btrfs scrub works for subpage from day one, it has a small
> pitfall:
> 
>   Scrub will always allocate a full page for each sector.
> 
> This causes increased memory usage, although not a big deal, it's still
> not ideal.
> 
> The patchset will change the behavior by integrating all pages into
> scrub_block::pages[], instead of using scrub_sector::page.
> 
> Now scrub_sector will no longer hold a page pointer, but uses its
> logical bytenr to caculate which page and page range it should use.
> 
> This behavior unfortunately still only affects memory usage on metadata
> scrub, which uses nodesize for scrub.
> 
> For the best case, 64K node size with 64K page size, we waste no memory
> to scrub one tree block.
> 
> For the worst case, 4K node size with 64K page size, we are no worse
> than the existing behavior (still one 64K page for the tree block)
> 
> For the default case (16K nodesize), we use one 64K page, compared to
> 4x64K pages previously.
> 
> For data scrubing, we uses sector size, thus it causes no difference.
> We need to do more work on data scrubing size to properly handle mutilpe
> sectors for non-RAID56 profiles.
> 
> The patchset requires the rename patchset.
> (https://lore.kernel.org/linux-btrfs/cover.1645530899.git.wqu@suse.com/)
> 
> If David is not happy with the big change again, at least first 3
> patches can be considered as some cleanup.
> 
> Qu Wenruo (5):
>   btrfs: scrub: use pointer array to replace @sblocks_for_recheck
>   btrfs: extract the initialization of scrub_block into a helper
>     function
>   btrfs: extract the allocation and initialization of scrub_sector into
>     a helper
>   btrfs: scrub: introduce scrub_block::pages for more efficient memory
>     usage for subpage
>   btrfs: scrub: remove scrub_sector::page and use scrub_block::pages
>     instead

Added to for-next as topic branch for now.
