Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1877174EC92
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGKL0j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Jul 2023 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGKL0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 07:26:37 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BA122
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 04:26:27 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7F4D973B6B9;
        Tue, 11 Jul 2023 13:26:24 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Tue, 11 Jul 2023 13:26:24 +0200
Message-ID: <5977988.lOV4Wx5bFT@lichtvoll.de>
In-Reply-To: <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de>
 <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 11.07.23, 13:05:42 CEST:
> On 2023/7/11 18:56, Martin Steigerwald wrote:
> > Qu Wenruo - 11.07.23, 11:57:52 CEST:
> >> On 2023/7/11 17:25, Martin Steigerwald wrote:
> >>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
> >>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
> >>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
> >>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
> >>>>>> latency
> >>>>>> values from 55 to 85 µs which is highly unusual for NVME SSD
> >>>>>> ("avio"
> >>>>>> in atop¹).
[…]
> >>>> Mind to try the following branch?
> >>>> 
> >>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
> >>>> 
> >>>> Or you can grab the commit on top and backport to any kernel >=
> >>>> 6.4.
> >>> 
> >>> Cherry picking the commit on top of v6.4.3 lead to a merge
> >>> conflict.
[…]
> >> Well, I have only tested that patch on that development branch,
> >> thus I can not ensure the result of the backport.
> >> 
> >> But still, here you go the backported patch.
> >> 
> >> I'd recommend to test the functionality of scrub on some less
> >> important machine first then on your production latptop though.
> > 
> > I took this calculated risk.
> > 
> > However, while with the patch applied there seem to be more kworker
> > threads doing work using 500-600% of CPU time in system (8 cores
> > with
> > hyper threading, so 16 logical cores) the result is even less
> > performance. Latency values got even worse going up to 0,2 ms. An
> > unrelated BTRFS filesystem in another logical volume is even stalled
> > to almost a second for (mostly) write accesses.
> > 
> > Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
> > data, mostly in larger files. Now on second attempt even only 620
> > MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
> > I made sure that no desktop search indexing was interfering.
> > 
> > Oh, I forgot to mention, BTRFS uses xxhash here. However it was
> > easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
> > zstd compression and free space tree (free space cache v2).
> > 
> > So from what I can see here, your patch made it worse.
> 
> Thanks for the confirming, this at least prove it's not the hashing
> threads limit causing the regression.
> 
> Which is pretty weird, the read pattern is in fact better than the
> original behavior, all read are in 64K (even if there are some holes,
> we are fine reading the garbage, this should reduce IOPS workload),
> and we submit a batch of 8 of such read in one go.
> 
> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
> And what about the latency?

CPU usage is between 600-700% on 6.3.9, Latency between 50-70 µs. And 
scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it went 
down a bit to 1,7 GiB/s, maybe due to background activity.

I'd say the CPU usage to result (=scrubbing speed) ratio is much, much 
better with 6.3. However the latencies during scrubbing are pretty much 
the same. I even seen up to 0.2 ms.

> Currently I'm out of ideas, for now you can revert that testing patch.
> 
> If you're interested in more testing, you can apply the following
> small diff, which changed the batch number of scrub.
> 
> You can try either double or half the number to see which change helps
> more.

No time for further testing at the moment. Maybe at a later time.

It might be good you put together a test setup yourself. Any computer 
with NVME SSD should do I think. Unless there is something very special 
about my laptop, but I doubt this. This reduces greatly on the turn-
around time.

I think for now I am back at 6.3. It works. :)

-- 
Martin


