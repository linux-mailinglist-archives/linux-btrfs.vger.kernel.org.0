Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF386A10EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 20:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBWT5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 14:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBWT53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 14:57:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261795BB84
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 11:57:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D80DE37D17;
        Thu, 23 Feb 2023 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677182246;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzNOTl15Xd7qAaBbhNgi7dQdX468UC0a4m6Zei56CDM=;
        b=gfl6YVcsSg4h5Fe3AXU3CyX1viE7+QtcQUtvKcTn0kAAzHAhA6sWRmh7UNA5ysPJVX5FCt
        1sVK2dHfQ5R8dzk/tsJBXh8Xx7To/ngqryOluDA5TARgipPHZIYjQCdXpyoP/FkviXrNPB
        riMq9ARUGgNJgllyv1gZvr67MvMFGZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677182246;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzNOTl15Xd7qAaBbhNgi7dQdX468UC0a4m6Zei56CDM=;
        b=8FUcx5KUJtDy3cMVBMx/hXry3hBh0S4jgJmEigRjtCZsifU/rltHPUeIzrQbNs0T2u7gmb
        L0yZxvVGXdetSqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC6F8139B5;
        Thu, 23 Feb 2023 19:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id THb+LCbF92PWTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 19:57:26 +0000
Date:   Thu, 23 Feb 2023 20:51:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: fix an error in stripe offset calculation
Message-ID: <20230223195129.GY10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 10:30:14AM +0800, Qu Wenruo wrote:
> [BUG]
> After commit "btrfs: replace btrfs_io_context::raid_map with a fixed u64
> value", btrfs/261 fails:
> 
>  QA output created by 261
>  ERROR: there are uncorrectable errors
>  scrub failed to fix the fs for profile -m raid5 -d raid5
>  ERROR: there are uncorrectable errors
>  scrub failed to fix the fs for profile -m raid6 -d raid6
>  Silence is golden
> 
> [CAUSE]
> In commit "btrfs: replace btrfs_io_context::raid_map with a fixed u64
> value", there is a call site using raid_map[i]:
> 
> 		*stripe_offset = logical - raid_map[i];
> 
> That location is to calculate the offset inside the stripe.
> But unfortunately the offending commit is using a wrong value:
> 
> 		*stripe_offset = logical - full_stripe_logical;
> 
> The above line is change the behavior to "logical - raid_map[0]", not
> "logical - raid_map[i]".
> 
> Thus causing wrong offset returned to the caller for raid56 replace.
> 
> [FIX]
> Thankfully the call site itself doesn't really need to access
> raid_map[i], since what we need is the offset inside the stripe.
> 
> So we can use BTRFS_STRIPE_LEN_MASK to calculate the offset inside the
> stripe.
> 
> Please fold this one into the offending commit "btrfs: replace
> btrfs_io_context::raid_map with a fixed u64 value".

Folded, thanks.
