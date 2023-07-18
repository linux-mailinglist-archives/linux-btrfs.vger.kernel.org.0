Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3DB757133
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 03:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGRBGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 21:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGRBGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 21:06:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17306E2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 18:06:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C02B62191A;
        Tue, 18 Jul 2023 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689642363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zkH3RHtA34M9ydAVnfGjIZDREgXqB0ll6f/1bCmvyU=;
        b=r8PMjWfuOOVuU/+F5iVHy9NnlWyf/MABP6fDoy3eoViZnYWoMho73f4Ip0twlxQwoXEqI3
        O65CfAchu7dwk9hwGVgrkEwyGUQxmbpdPH9VVV0KXfI7R2p8JitdBIWiQzrs/14S1zcHj8
        HPiIecdJs8P3xWOfsDxvENsWTrdp3Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689642363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zkH3RHtA34M9ydAVnfGjIZDREgXqB0ll6f/1bCmvyU=;
        b=+CJq2uSLCf5uYNB7rrFoLo5Kx+xlR2TNZXEPrgr5hNDoW3PmA2ko6yHi8SkYt9nfPqmHuQ
        C65DwIgHvOwCH4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D52A138EE;
        Tue, 18 Jul 2023 01:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OvO7IXvltWR9dAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Jul 2023 01:06:03 +0000
Date:   Tue, 18 Jul 2023 02:59:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
Message-ID: <20230718005924.GN20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 06:26:40PM +0800, Qu Wenruo wrote:
> [REGRESSION]
> There are several regression reports about the scrub performance with
> v6.4 kernel.
> 
> On a PCIE3.0 device, the old v6.3 kernel can go 3GB/s scrub speed, but
> v6.4 can only go 1GB/s, an obvious 66% performance drop.
> 
> [CAUSE]
> Iostat shows a very different behavior between v6.3 and v6.4 kernel:
> 
> Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
> nvme0n1p3  9731.00 3425544.00 17237.00  63.92    2.18   352.02  21.18 100.00
> nvme0n1p3 20853.00 1330288.00     0.00   0.00    0.08    63.79   1.60 100.00
> 
> The upper one is v6.3 while the lower one is v6.4.
> 
> There are several obvious differences:
> 
> - Very few read merges
>   This turns out to be a behavior change that we no longer go bio
>   plug/unplug.
> 
> - Very low aqu-sz
>   This is due to the submit-and-wait behavior of flush_scrub_stripes().
> 
> Both behavior is not that obvious on SATA SSDs, as SATA SSDs has NCQ to
> merge the reads, while SATA SSDs can not handle high queue depth well
> either.
> 
> [FIX]
> For now this patch focus on the read speed fix. Dev-replace replace
> speed needs extra work.
> 
> For the read part, we go two directions to fix the problems:
> 
> - Re-introduce blk plug/unplug to merge read requests
>   This is pretty simple, and the behavior is pretty easy to observe.
> 
>   This would enlarge the average read request size to 512K.
> 
> - Introduce multi-group reads and no longer waits for each group
>   Instead of the old behavior, which submit 8 stripes and wait for
>   them, here we would enlarge the total stripes to 16 * 8.
>   Which is 8M per device, the same limits as the old scrub flying
>   bios size limit.
> 
>   Now every time we fill a group (8 stripes), we submit them and
>   continue to next stripes.

Have you tried other values for the stripe count if this makes any
difference? Getting back to the previous value (8M) is closer to the
amount of data sent at once but the code around has chnaged, so it's
possible that increasing that could also improve it (or not).

>   Only when the full 16 * 8 stripes are all filled, we submit the
>   remaining ones (the last group), and wait for all groups to finish.
>   Then submit the repair writes and dev-replace writes.
> 
>   This should enlarge the queue depth.
> 
> Even with all these optimization, unfortunately we can only improve the
> scrub performance to around 1.9GiB/s, as the queue depth is still very
> low.

So the request grouping gained about 700MB/s, I was expecting more but
it's a noticeable improvement still.

> Now the new iostat results looks like this:
> 
> Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
> nvme0n1p3  4030.00 1995904.00 27257.00  87.12    0.37   495.26   1.50 100.00
> 
> Which still have a very low queue depth.
> 
> The current bottleneck seems to be in flush_scrub_stripes(), which is
> still doing submit-and-wait, for read-repair and dev-replace
> synchronization.
> 
> To fully re-gain the performance, we need to get rid of the
> submit-and-wait, and go workqueue solution to fully utilize the
> high queue depth capability of NVME devices.
> 
> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> For the proper fix, I'm afraid we have to utilize btrfs workqueue, let
> the initial read and repair done in an async manner, and let the
> writeback (repaired and dev-replace) happen in a synchronized manner.
> 
> This can allow us to have a very high queue depth, to claim the
> remaining 1GiB/s performance.
> 
> But I'm also not sure if we should go that hard, as we may still have
> SATA SSD/HDDs, which won't benefit at all from high queue depth.

I don't understand what you mean here, there are all sorts of devices
that people use and will use. Lower queue depth will lead to lower
throughput which would be expected, high speed devices should utilize
the full bandwidth if we have infrastructure for that.

To some level we can affect the IO but it's still up to block layer.
We've removed code that did own priority, batching and similar things,
which is IMHO good and we can rely on block layer capabilities. So I'm
assuming the fixes should go more in that direction. If this means to
use a work queue then sure.

> The only good news is, this patch is small enough for backport, without
> huge structure changes.

Yeah that's useful, thanks. Patch added to misc-next.
