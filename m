Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AE5477F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 01:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiFKXos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 19:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiFKXor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 19:44:47 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BDDB60EF
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 16:44:45 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 11F073B718B; Sat, 11 Jun 2022 19:44:44 -0400 (EDT)
Date:   Sat, 11 Jun 2022 19:44:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <YqUo678pVtaRuF1V@hungrycats.org>
References: <20220611045120.GN22722@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611045120.GN22722@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 09:51:20PM -0700, Marc MERLIN wrote:
> so, my apologies to all for the thread of death that is hopefully going
> to be over soon. I still want to help Josef fix the tools though,
> hopefully we'll get that filesystem back to a mountable state.
> 
> That said, it's been over 2 months now, and I do need to get this
> filesystem back up from backup, so I ended up buying new drives (5x
> 11TiB in raid5).
> 
> Given the pretty massive corruption that happened in ways that I still 
> can't explain, I'll make sure to turn off all the drive write caches
> but I think I'm not sure I want to trust bcache anymore even though
> I had it in writethrough mode.
> 
> Here's the Email from March, questions still apply:
> 
> Kernel will be 5.16. Filesystem will be 24TB and contain mostly bigger
> files (100MB to 10GB).
> 
> 1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal
> 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
>    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
>    [writethrough] writeback writearound none
> 3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
> 4) cryptsetup luksOpen /dev/bcache64 dshelf1
> 5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1
> 
> Any other btrfs options I should set for format to improve reliability
> first and performance second?

> I'm told I should use space_cache=v2, is it default now with btrfs-progs 5.10.1-2 ?

It's default with current btrfs-progs.  I'm not sure what the cutoff
version is, but it doesn't matter--you can convert to v2 on first mount,
which will be fast on an empty filesystem.

> As for bcache, I'm really thinking about droppping it, unless I'm told
> it should be safe to use.

I would not recommend the cache in this configuration for resilience
because it doesn't keep device failures in separate failure domains.
Common SSD failure modes (e.g.  silent data corruption, dropped writes)
can be detected but not repaired, and can affect any part of the
filesystem when viewed through the cache.

Unfortunately cache is only resilient with btrfs raid1 using SSD+HDD
cached device pairs so that a failure of any SSD or HDD affects at most
one btrfs device.  That configuration works reasonably well, but you'll
need a pile more disks (both HDD and SSD) to match the capacity.

btrfs raid5 of SSD+HDD devices doesn't work--it will keep all IO accesses
below the cache's sequential IO size cutoff, which will wear out the SSDs
too fast (in addition to the other btrfs raid5 problems).  Same problem
with raid10 or raid0.

I've tested btrfs with both bcache and lvmcache.  I mostly use lvmcache,
and have had no problems with it.  bcache had problems in testing, so
I've never used bcache outside of test environments.

bcache has a few sharp edges when SSD devices fail that prevent
recovery with the filesystem still online.  It seems to trigger
service-interrupting firmware bugs in some SSD models with
its access patterns compared to lvmcache (failures that are
common on one vendor/model/firmware that never happen on any other
vendor/model/firmware, and that occur much more often, or at all, when
bcache is in use compared to when bcache is not in use).

I have not lost data with bcache when SSD corruption is not present--it
survived hundreds of power-fail crash test cycles and came back after
all the SSD firmware crashes in testing--but the service interruptions
from crashing firmware and the inability to recover from a failed drive
while keeping the filesystem online were a problem.  We worked around
this by using lvmcache instead.

If your IO subsystem has problems with write dropping, then it's going
to be much worse with any cache.  Neither bcache nor lvmcache have
any sort of hardening against SSD corruption or failure.  They both
fail badly on SSD corruption tests even in writethrough mode.

> Thanks,
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/  
> 
