Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C31758EF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGSH1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGSH1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 03:27:17 -0400
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3241736
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 00:27:13 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 6D938747A58;
        Wed, 19 Jul 2023 09:27:10 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
Date:   Wed, 19 Jul 2023 09:27:10 +0200
Message-ID: <1921732.taCxCBeP46@lichtvoll.de>
In-Reply-To: <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
 <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu, hi Jens.

@Qu: I wonder whether Jens as a maintainer for the block layer can shed 
some insight on the merging of requests in block layer or the latency of 
plugging aspect of this bug.

@Jens: There has been a regression of scrubbing speeds in kernel 6.4 
mainly for NVME SSDs with a drop of speed from above 2 GiB/s to 
sometimes even lower than 1 GiB/s. I bet Qu can explain better to you 
what is actually causing this. For reference here the initial thread:

Scrub of my nvme SSD has slowed by about 2/3
https://lore.kernel.org/linux-btrfs/
CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/

And here another attempt of Qu to fix this which did not work out as well 
as he hoped:

btrfs: scrub: make sctx->stripes[] a ring buffer 

https://lore.kernel.org/linux-btrfs/cover.1689744163.git.wqu@suse.com/

Maybe Jens you can share some insight on how to best achieve higher 
queue depth and good merge behavior for NVME SSDs while not making the 
queue depth too high for SATA SSDs/HDDs?

Qu Wenruo - 19.07.23, 07:22:05 CEST:
> On 2023/7/18 09:41, Qu Wenruo wrote:
> > On 2023/7/18 08:59, David Sterba wrote:
> >> On Fri, Jul 14, 2023 at 06:26:40PM +0800, Qu Wenruo wrote:
> >>> [REGRESSION]
> >>> There are several regression reports about the scrub performance
> >>> with
> >>> v6.4 kernel.
> >>> 
> >>> On a PCIE3.0 device, the old v6.3 kernel can go 3GB/s scrub speed,
> >>> but v6.4 can only go 1GB/s, an obvious 66% performance drop.
> >>> 
> >>> [CAUSE]
> >>> Iostat shows a very different behavior between v6.3 and v6.4
> >>> kernel:
> >>> 
> >>> Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz
> >>> aqu-sz  %util
> >>> nvme0n1p3  9731.00 3425544.00 17237.00  63.92    2.18   352.02 
> >>> 21.18
> >>> 100.00
> >>> nvme0n1p3 20853.00 1330288.00     0.00   0.00    0.08    63.79  
> >>> 1.60
> >>> 100.00
> >>> 
> >>> The upper one is v6.3 while the lower one is v6.4.
> >>> 
> >>> There are several obvious differences:
> >>> 
> >>> - Very few read merges
> >>>    This turns out to be a behavior change that we no longer go bio
> >>>    plug/unplug.
> >>> 
> >>> - Very low aqu-sz
> >>>    This is due to the submit-and-wait behavior of
> >>> flush_scrub_stripes().
> >>> 
> >>> Both behavior is not that obvious on SATA SSDs, as SATA SSDs has
> >>> NCQ to merge the reads, while SATA SSDs can not handle high queue
> >>> depth well either.
> >>> 
> >>> [FIX]
> >>> For now this patch focus on the read speed fix. Dev-replace
> >>> replace
> >>> speed needs extra work.
> >>> 
> >>> For the read part, we go two directions to fix the problems:
> >>> 
> >>> - Re-introduce blk plug/unplug to merge read requests
> >>>    This is pretty simple, and the behavior is pretty easy to
> >>> observe.
> >>> 
> >>>    This would enlarge the average read request size to 512K.
> >>> 
> >>> - Introduce multi-group reads and no longer waits for each group
> >>>    Instead of the old behavior, which submit 8 stripes and wait
> >>> for
> >>>    them, here we would enlarge the total stripes to 16 * 8.
> >>>    Which is 8M per device, the same limits as the old scrub flying
> >>>    bios size limit.
> >>> 
> >>>    Now every time we fill a group (8 stripes), we submit them and
> >>>    continue to next stripes.
> >> 
> >> Have you tried other values for the stripe count if this makes any
> >> difference? Getting back to the previous value (8M) is closer to
> >> the
> >> amount of data sent at once but the code around has chnaged, so
> >> it's
> >> possible that increasing that could also improve it (or not).
> > 
> > I tried smaller ones, like grounp number 8 (4M), with the plugging
> > added back, it's not that good, around 1.6GB/s ~ 1.7GB/s.
> > And larger number 32 (16M) doesn't increase much over the 16 (8M)
> > value.
> > 
> > The bottleneck on the queue depth seems to be the wait.
> > 
> > Especially for zoned write back, we need to ensure the write into
> > dev-replace target device ordered.
> > 
> > This patch choose to wait for all existing stripes to finish their
> > read, then submit all the writes, to ensure the write sequence.
> > 
> > But this is still a read-and-wait behavior, thus leads to the low
> > queue depth.
> 
> I tried making sctx->stripes[] a ring buffer, so that we would only
> wait the current slot if it's still under scrub, no more dedicated
> waits at the last slot.
> 
> The branch can be found at my github repo:
> https://github.com/adam900710/linux/tree/scrub_testing
> 
> 
> But unfortunately this brings no change to scrub performance at all,
> and the average queue depth is still pretty shallow (slightly better,
> can reach 1.8~2.0).
> 
> If needed, I can send out the patchset (still pretty small, +249/-246)
> for review, but I don't think it worthy as no improvement at all...
> 
> For now, I'm afraid the latency introduced by plug is already enough
> to reduce the throughput, thus we have to go back the original
> behavior, to manually merge the read requests, other than rely on
> block layer plug...
-- 
Martin


