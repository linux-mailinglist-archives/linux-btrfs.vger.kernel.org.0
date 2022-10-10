Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8545FA2C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJJRgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 13:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJJRgG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 13:36:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726CF6C125
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9DD22745;
        Mon, 10 Oct 2022 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665423363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LVJlsGMJ3nbqOoz65ZUN0lBE93Xyj6OwesrABI2140=;
        b=dLrbWuYG37yhYeYvU357fjOWKAsnYFkmHeiUbuqB5c3gHATQt5E51cn3vzcm11XdRaV/gO
        FaPliG4POXWYo+ml8a2QzdsMxwDeDfJt/pXbVUNxCZoS29hrx5MtwRbnSkrQJZIMtxgepO
        zG4ItStIVn5fhgV39+TRgBBLfHhe67c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665423363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LVJlsGMJ3nbqOoz65ZUN0lBE93Xyj6OwesrABI2140=;
        b=kb6q0eUr+xqufI8LY/QuLXf+LPR/BjWJDLjm2Ncb5Jlag8zAggjlciJ3qh9GO9Th+wMEp3
        FEEHHr/fDM2NXKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0215813ACA;
        Mon, 10 Oct 2022 17:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rwHMOgJYRGPbbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Oct 2022 17:36:02 +0000
Date:   Mon, 10 Oct 2022 19:35:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: raid56: part 1, refactor/cleanup
Message-ID: <20221010173557.GG13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665397731.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665397731.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 10, 2022 at 06:36:05PM +0800, Qu Wenruo wrote:
> This is the cleanup/refactor part for the incoming RAID56 feature, which
> will do data checksum verification during RMW cycle to address
> destructive RMW.
> 
> The important parts of the cleanup are:
> 
> - Make pointer members of btrfs_raid_bio to be allocated separately
>   This will make later expanding (csum_buf and csum_bitmap) easier.
> 
> - Make it explicit that all cached rbio should have all its data sectors
>   uptodate
>   This means, if we steal one rbio, all the data sectors should be
>   uptodate.
> 
> Qu Wenruo (5):
>   btrfs: raid56: properly handle the error when unable to find the
>     missing stripe
>   btrfs: raid56: avoid double freeing for rbio if full_stripe_write()
>     failed
>   btrfs: raid56: cleanup for function __free_raid_bio()
>   btrfs: raid56: allocate memory separately for rbio pointers
>   btrfs: raid56: make it more explicit that cache rbio should have all
>     its data sectors uptodate

At a quick glance it looks all good to me, I'll add it to misc-next,
reviews can continue.
