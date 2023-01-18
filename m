Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086E0672900
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 21:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjARUHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjARUHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 15:07:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FB3D91F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 12:07:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D02A95C29E;
        Wed, 18 Jan 2023 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674072428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFeQ2Vl1dIp2ENMtCo7TxYjWp8a4pYodNtepoz6K/0U=;
        b=Khdo+eTbqL8qvr4YnICf3mMTMcuDA0G8mXSl/5MPG51O6lBdRnvHRVv25usl5V1sTe6rk7
        NvkUaGnX2lmfmC9SE0vQLrTlOzPH+34Aa2e53QHX0zoPSfcJXnKC+ZUy9kZJRcVjtSHp1S
        onK+H+ndgPYPREjJ5915gsBRTq3OADA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674072428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFeQ2Vl1dIp2ENMtCo7TxYjWp8a4pYodNtepoz6K/0U=;
        b=Dwn22UwNnYcBx26rvGINF+geFt63o1tPci+pfGszSx3/GN3lfjY+GHU+2JEM1d+31doXf5
        V841h/9BBKT1zjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A722E139D2;
        Wed, 18 Jan 2023 20:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q8TZJ2xRyGOtFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 Jan 2023 20:07:08 +0000
Date:   Wed, 18 Jan 2023 21:01:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
Message-ID: <20230118200129.GE11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673851704.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 16, 2023 at 03:04:11PM +0800, Qu Wenruo wrote:
> This is the formal version of the previous PoC patchset "btrfs: scrub:
> rework to get rid of the complex bio formshaping"
> 
> The idea is pretty straight-forward for scrub:
> 
> - Fetch the extent info and csum for the whole BTRFS_STRIPE_LEN range
> 
> - Read the full BTRFS_STRIPE_LEN range
> 
> - Verify the contents using the extent info and csum at endio time
> 
> - Wait for above BTRFS_STRIPE_LEN range read to finish.
> 
> - If we have failed sectors, read extra mirrors to repair them.
> 
> - If we have failed sectors, writeback the repaired ones.
> 
> - If we're doing dev-replace, writeback all good sectors to the target
>   device.
> 
> Although the workflow is still mostly the same as the old scrub
> infrastructure, the implementation goes submit-and-wait method.
> 
> Thus it provides a very straight-forward code basis:
> 
> 		scrub_reset_stripe(stripe);
> 		ret = scrub_find_fill_first_stripe(extent_root, csum_root, bg,
> 				cur_logical, logical_end - cur_logical, stripe);
> 		stripe->physical = physical + stripe->logical - logical_start;
> 		scrub_throttle_dev_io(sctx, device, BTRFS_STRIPE_LEN);
> 		scrub_submit_read_one_stripe(stripe);
> 		wait_scrub_stripe(stripe);
> 		scrub_repair_one_stripe(stripe);
> 		scrub_write_repaired_sectors(sctx, stripe);
> 		scrub_report_stripe_errors(sctx, stripe);
> 		if (sctx->is_dev_replace)
> 			scrub_write_replace_sectors(sctx, stripe);
> 		cur_logical = stripe->logical + BTRFS_STRIPE_LEN;
> 
> Thus it covers all the core logic in one function.
> 
> By contrast the old code goes various workqueue, endio function jumps,
> and extra bio formshaping.
> 
> Currently the patchset only covers profiles other than RAID56 parity
> stripes.
> Thus old infrastructure is still kept for RAID56 parity scrub usage.
> 
> But still the patchset is already large enough for review.
> 
> The current patchset can already pass all scrub and replace tests.
> 
> [BENCHMARK]
> 
> However there is a cost.
> Since our block size is limited to 64K, it's much smaller block size
> compared to the original one.
> 
> Thus for the worst case scenario (all data are continuous, and the
> profiles is RAID0 for extra splits), the scrub performance got a 20%
> drop:
> 
> Old:
>  
>  Duration:         0:00:19
>  Total to scrub:   10.52GiB
>  Rate:             449.50MiB/s
> 
> New:
> 
>  Duration:         0:00:24
>  Total to scrub:   10.52GiB
>  Rate:             355.86MiB/s
> 
> The benchmark is using an SATA SSD directly attached to the VM.
> 
> [NEED FEEDBACK]
> 
> Is 20% drop perf acceptable?
> 
> I have seen some customers asking for ways to slow down scrub,
> but not to speed it up.
> Thus I'm not sure if a native performance drop is a curse or a bless.
> 
> Any if needed, I can enlarge the block size by submitting multiple
> stripes instead.
> But in that case, we will need some extra code to do multiple stripe
> scrub.

20% seems a lot, however if this means that more IO from other
applications can be submitted while scrub is running it might not be
that bad. Scrub limiting is not done by default so this could help.

The point against that is what if I have an idle machine and want to let
the scrub run as fast as possible. As the request size and IO timing
depends on the device type, it's not exactly the same as limiting the
bandwidth. In your case you have an SSD, no HDD can do 449 or 355. An
option to 'scrub start' to set the request size or some human friendly
name like "big request" can be done. But I'm not sure if this is the
best way, it would be yet another tunable, we might try using cgroups
instead.
