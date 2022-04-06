Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6114F6C1C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiDFVIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiDFVIS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:08:18 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9B13CC535
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 12:45:58 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id D0E5A2B252E; Wed,  6 Apr 2022 15:45:57 -0400 (EDT)
Date:   Wed, 6 Apr 2022 15:45:57 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <Yk3t9U/XtQjFAcAE@hungrycats.org>
References: <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
 <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org>
 <20220406191317.GC14804@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406191317.GC14804@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 12:13:17PM -0700, Marc MERLIN wrote:
> On Wed, Apr 06, 2022 at 02:07:47PM -0400, Zygo Blaxell wrote:
> > Readahead can fail for a number of reasons that aren't real problems,
> 
> thanks.
> 
> > Once a degraded array has an IO failure, mdadm assumes you're in
> > a data-scraping recovery mode and simply passes errors through.
> > bcache does something similar when the backing store fails.
>  
> shouldn't it go read only also?
> I haven't found a setting to tell it to do that if it's not the default.

bcache in writethrough mode could leave cached blocks dirty as long as
the SSD completes the write.  It should be reporting the write errors
back to upper layers.

Whether it actually does...I don't know, I haven't run that kind of
stress test on bcache.  I usually pair bcache SSD 1:1 with HDD, so if
either the SSD or HDD fails, I scrub or replace them both as a single
logical btrfs device, which makes this kind of question mostly irrelevant.
Unfortunately this approach doesn't work with raid5--the striping cuts IO
requests into tiny fragments, so the cache will try to cache everything.

> > btrfs is the agent that has to stop attempting writes, and make sure
> > any transaction in progress doesn't get committed.  ext4 has similar
> > responsibility and implements its own force-read-only feature.
> 
> Agreed, but I like the defense in multiple layers approach
> mdadm knows that any data going to be written is going to be incomplete
> due to the 2nd missing drive, and there are few to no scenarios where 
> continuing to write is a good thing.

True, there's no way the parity would make any sense with two drives
in a stripe missing during an update.  So maybe there weren't any
writes going through mdadm at that point, and everything failed at the
drive-offline event.  Or writes completed on the working drives before
the failing drive's failure was detected, messing up the data there.
A typical drive bus timeout is a long time, and a lot of raid stripes
could be modified on other drives while that happens.

> > There's a possibility that the drive dropped the writes during the
> > bus reset at the start of the second drive failure.  If write caching
> > was enabled in the drive, and the drive has a firmware bug that drops
> > the write cache contents (or it's just failing hardware, i.e. the CPU
> > running the drive firmware is getting killed by electrical problems on the
> > controller board, causing both the bus drop and the loss of write cache
> > contents), then writes in the drive's cache could be lost _after_ mdadm,
> > bcache and btrfs had been told by the drive that they were completed.
> 
> That's true, but I've seen btfrs remount read only before, and it didn't
> there. Shouldn't hard IO errors immediately cause btrfs to go read only?

No, only hard write IO errors on all metadata mirror drives, and cases
where btrfs needs to CoW a page or read free space tree, and can't find
an intact mirror.  Anything less is correctable (write failure on some
mirrors) or can be retried (any read failure) if the raid profile has
redundancy.

> Write caching is on all those drives though:
> gargamel:/var/local/src/btrfs-progs-josefbacik# hdparm -v -W /dev/sdh
> /dev/sdh:
>  multcount     = 16 (on)
>  readonly      =  0 (off)
>  readahead     = 256 (on)
>  geometry      = 729601/255/63, sectors = 11721045168, start = 0
>  write-caching =  1 (on)
> 
> I haven't heard that these drives have broken caching, but maybe they do?
> Device Model:     ST6000VN0041-2EL11C
> Serial Number:    ZA18TVFZ
> LU WWN Device Id: 5 000c50 0a4d9b49c
> Firmware Version: SC61
> User Capacity:    6,001,175,126,016 bytes [6.00 TB]

I've heard of problems with SC60, but IIRC SC61 was supposed to be the
fix for them.  I had some SC60 drives for a while without encountering
issues, but I didn't have any bus timeouts with them.  When they failed,
they had a burst of 10k+ UNC sectors and then stopped spinning up,
with no bus timeouts.

> > If the failing drive also reorders cached writes across flush
> > commands, then we go directly to parent transid verify failed in btrfs.
> > Parent transid verification is designed to detect this exact firmware
> > failure mode, and it usually works as intended.  It's a pretty direct
> > and reliable signal that write ordering is broken in a lower level of
> > the storage stack, and must be fixed or disabled before trying again.
>  
> Agreed, I do want to fix the underlying problem here.
> What I can do is
> 
> 1) disable write caching on the drives
> 
> 2) disable bcache by removing the caching device
> 
> 3) change the cache mode
> gargamel:/sys/block/md7/bcache# cat cache_mode 
> [writethrough] writeback writearound none
> writethrough should be safe, but I could use writearound instead
> 
> 4) if I end up wiping my device, I can just remove the bcache layer altogether.
> 
> > Even if a single drive doesn't reorder writes, multiple drives in
> > raid effectively reorder writes between drives as each drive has its
> > own distinct write queue.  A dropped write that would be harmless in a
> 
> very good point.
> 
> > single-device filesystem could be harmful in a multi-device array as the
> > non-failing drives will have writes that occurred after the lost writes
> > on the failing drive.  Normally mdadm enforces flush ordering across all
> > component devices so that this isn't a problem, but if you have optimistic
> > firmware and a drive failure after the flush command returns success,
> > the inter-drive ordering enforcement fails and the result is the same
> > as if an individual drive had a write/flush reordering bug.
> 
> That's all fair, but it feels like FS kept writing way longer than it
> was supposed to and that is what worries me the most.

The log excerpt I saw didn't show any write errors from btrfs, only
from mdadm.  That suggests to me that the failure happened earlier when
it was already too late to respond.  Also we can't rule out that bcache
is doing something stupid.

> > Some years ago we did a fleetwide audit of bad firmware drives and
> > found about a third of our drives were bad.  We disabled write cache on
> 
> Looks like I just want to disable write caching then. Correctness beats
> speed for sure.
> 
> > Yeah, experimental recovery code is fun, but robust backups and a working
> > disaster recovery plan is usually better.  Even if the filesystem is
> > up and running again, I'd want to compare all the files against backups
> > because I'd trust nothing on a filesystem after fsck touched it.
>  
> That is totally my plan. Given the output that I'm seeing, I'll definitely do
> at least a diff of all files between the backup and the array being recovered.
> I might even do an rsync, forcing md5 checksums, but if I do that, it
> will take days and longer than restoring the backup.
> 
> > On the other hand, if you get lucky and the filesystem isn't too badly
> > damaged, then comparing the data with backups will be more convenient
> > than starting over with a new filesystem.
> 
> Agreed.
> 
> Thanks,
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/  
> 
