Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C360554E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 04:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJTCGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 22:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJTCGA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 22:06:00 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 19:05:55 PDT
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20FC153802
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 19:05:54 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id BA7CF5A04E9; Wed, 19 Oct 2022 21:59:36 -0400 (EDT)
Date:   Wed, 19 Oct 2022 21:59:35 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Endless "reclaiming chunk"/"relocating block group"
Message-ID: <Y1Crh/Cz2rcbIayw@hungrycats.org>
References: <1666204197@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666204197@msgid.manchmal.in-ulm.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 08:29:59PM +0200, Christoph Biedl wrote:
> Hello,
> 
> On some systems I observe a strange behaviour: After remounting a BTRFS
> readwrite, a background process starts doing things on the disk,
> messages look like
> 
> | BTRFS info (device nvme0n1p1): reclaiming chunk 21486669660160 with 100% used 0% unusable
> | BTRFS info (device nvme0n1p1): relocating block group 21486669660160 flags data
> | BTRFS info (device nvme0n1p1): found 4317 extents, stage: move data extents
> | BTRFS info (device nvme0n1p1): found 4317 extents, stage: update data pointers
> 
> and (with differing numbers) this goes on for hours and days, at a
> read/write rate of about 165/244 kbyte/sec. The filesystem, some 2.5
> Gbyte total size, is filled to about 55%, so even if that process
> touches each and every block, it should already have handled everything,
> several times.
> 
> Now, I have no clue what is happening here, what triggers it, if it will
> ever finish. Point is, this takes a measuarable amount of I/O and CPU,
> and it delays other processes.
> 
> 
> Some details, and things I've tested:
> 
> This behaviour is reproducible 100%, even with a btrfs created mere
> moments ago.
> 
> The filesystem was created using the 5.10 and 6.0 version of the
> btrfs-progs (both as provided by Debian stable and unstable resp.).

Reclaim is a purely in-kernel-memory feature, so this should not have
an effect.

> Using the grml rescue system (stable and daily, the latter kernel 5.19),
> the system does not show this behaviour.

> The group block number is constantly increasing (14 digits after two
> days), in other words, I have not observed a wrap-around.

It's a 64-bit number so it's not going to wrap around any time soon.

> It was suggested in IRC to format using the --mixed parameter, no avail.
> 
> It was also suggested to set the various bg_reclaim_threshold to zero to
> stop this process, no avail.

Not sure what's happening there.  The reclaim threshold is the minimum
amount of free space, so it shouldn't be triggering with a 100% filled
block group.  Reclaiming an _exactly_ filled block group makes no sense
at all (no improvement of space usage is possible when a block group
is completely filled), so we shouldn't be doing it.

Note that since 5.19 there are multiple bg_reclaim_threshold knobs:

	/sys/fs/btrfs/(uuid)/bg_reclaim_threshold
	/sys/fs/btrfs/(uuid)/allocation/metadata/bg_reclaim_threshold
	/sys/fs/btrfs/(uuid)/allocation/system/bg_reclaim_threshold
	/sys/fs/btrfs/(uuid)/allocation/data/bg_reclaim_threshold

Make sure all of these are zero.

> This is amd64 hardware without any unusual elements. I could easily
> reproduce this on a fairly different platforms to make sure it's not
> hardware specific.

It makes me think of possible rounding errors (e.g. the threshold
calculation divides by 100, or there's a sum of quantities that leads
to a percentage > 100, but the code treats zero as a special case and
bails out long before, so I don't see how we'd reach those corner cases.

> Scrubbing did not show any errors, and the problem remained.

Scrub shouldn't interact with reclaim, except to slightly delay it.

> The host runs a hand-crafted kernel, currently 5.19, and I reckon this
> is the source of the problem. Of course I've compared all the BTRFS
> kernel options, they are identical. In the block device layer
> configuration I couldn't see any difference that I can think would
> relate to this issue. Likewise I compared all kernel configuration
> options mentioned in src/fs/btrfs/, still nothing noteworthy.
> 
> 
> So I'm a bit out of ideas. Unless there's something obvious from the
> description above, perhaps you could give a hint to the following: The
> process that emits the messages above, is there a way to stop it,

Set bg_reclaim_threshold to 0, as you've already tried (but maybe not
in all of the relevant places).

> or to report completion percentage?

It's done more or less one block group at a time, so it stops when it
stops.  Even if it reaches the end of the block group reclaim list for
one iteration of the worker, there's nothing stopping new block groups
from being added while processing the list, making the percentage at
any given time meaningless.

> Are block group numbers really
> *that* big, magnitudes over the size of the entire filesystem?

Relocation (including reclaim, resize, and balance) copies the data from
the old block group into a new block group, removing free space fragments
between the data extents in the process.  Block group numbers are (almost)
never reused, so each new block group created has higher bytenrs than
any before it.  If you've relocated every block group 100 times, the
block group numbers will be over 100x the size of the filesystem.

> Regards,
> 
>     Christoph
> 
