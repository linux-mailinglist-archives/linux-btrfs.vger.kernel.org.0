Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C374EC07
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGKK4U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Jul 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGKK4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 06:56:19 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D6E49
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 03:56:17 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 6C68273B5AD;
        Tue, 11 Jul 2023 12:56:14 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Tue, 11 Jul 2023 12:56:14 +0200
Message-ID: <2311414.ElGaqSPkdT@lichtvoll.de>
In-Reply-To: <3ff556b9-2450-e5d3-2ad3-34a52e723f27@suse.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <1956200.usQuhbGJ8B@lichtvoll.de>
 <3ff556b9-2450-e5d3-2ad3-34a52e723f27@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 11.07.23, 11:57:52 CEST:
> On 2023/7/11 17:25, Martin Steigerwald wrote:
> > Qu Wenruo - 11.07.23, 10:59:55 CEST:
> >> On 2023/7/11 13:52, Martin Steigerwald wrote:
> >>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
> >>>> I see about 180000 reads in 10 seconds in atop. I have seen
> >>>> latency
> >>>> values from 55 to 85 µs which is highly unusual for NVME SSD
> >>>> ("avio"
> >>>> in atop¹).
> >>> 
> >>> Well I did not compare to a base line during scrub with 6.3. So
> >>> not actually sure about the unusual bit. But at least during daily
> >>> activity I do not see those values.
> >>> 
> >>> Anyway, I am willing to test a patch.
> >> 
> >> Mind to try the following branch?
> >> 
> >> https://github.com/adam900710/linux/tree/scrub_multi_thread
> >> 
> >> Or you can grab the commit on top and backport to any kernel >=
> >> 6.4.
> > 
> > Cherry picking the commit on top of v6.4.3 lead to a merge conflict.
> > Since this is a production machine and I am no kernel developer with
> > insight to the inner workings of BTRFS, I'd prefer a patch that
> > applies cleanly on top of v6.4.3. I'd rather not try out a tree,
> > unless I know its a stable kernel version or at least rc3/4 or
> > later. Again this is a production machine.
> 
> Well, I have only tested that patch on that development branch, thus I
> can not ensure the result of the backport.
> 
> But still, here you go the backported patch.
> 
> I'd recommend to test the functionality of scrub on some less
> important machine first then on your production latptop though.

I took this calculated risk.

However, while with the patch applied there seem to be more kworker 
threads doing work using 500-600% of CPU time in system (8 cores with 
hyper threading, so 16 logical cores) the result is even less 
performance. Latency values got even worse going up to 0,2 ms. An 
unrelated BTRFS filesystem in another logical volume is even stalled to 
almost a second for (mostly) write accesses.

Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of 
data, mostly in larger files. Now on second attempt even only 620 MiB/s. 
Which is less than before. Before it reaches about 1 GiB/s. I made sure 
that no desktop search indexing was interfering.

Oh, I forgot to mention, BTRFS uses xxhash here. However it was easily 
scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses zstd 
compression and free space tree (free space cache v2).

So from what I can see here, your patch made it worse.

Best,
-- 
Martin


