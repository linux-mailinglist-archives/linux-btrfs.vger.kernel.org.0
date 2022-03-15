Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B254DA2B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351158AbiCOSwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCOSwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 14:52:37 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 413515881C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:51:24 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 2BE6F25CC81; Tue, 15 Mar 2022 14:51:23 -0400 (EDT)
Date:   Tue, 15 Mar 2022 14:51:23 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjDgKzAx/tawKHCz@hungrycats.org>
References: <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
 <Yi/G+FFqF8TlafF3@hungrycats.org>
 <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
 <Yi/SR7CNbtDvIsPn@hungrycats.org>
 <eda21cae-4825-458a-dd69-1e2740955dc0@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda21cae-4825-458a-dd69-1e2740955dc0@georgianit.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 10:14:01AM -0400, Remi Gauvin wrote:
> On 2022-03-14 7:39 p.m., Zygo Blaxell wrote:
> > If we're adding a mount option for this (I'm not opposed to it, I'm
> > pointing out that it's not the first tool to reach for), then ideally
> > we'd overload it for the compressed batch size (currently hardcoded
> > at 512K).
> 
> Are there any advantages to extents larger than 256K on ssd Media?  

The main advantage of larger extents is smaller metadata, and it doesn't
matter very much whether it's SSD or HDD.  Adjacent extents will be in
the same metadata page, so not much is lost with 256K extents even on HDD,
as long as they are physically allocated adjacent to each other.

There is a CPU hit for every extent, and when snapshot pages become
unshared, every distinct extent on the page needs its reference count
updated for the new page.  The costs of small extents add up during
balances, resizes, and snapshot deletes, but on a small filesystem you'd
want smaller extents so that balances and resizes are possible at all
(this is why there's a 128M limit now--previously, extents of multiple
GB were possible).

Averaged across my filesystems, half of the data blocks are in extents
below 512K, and only 1% of extents are 1M or larger.  Capping the extent
size at 256K wouldn't make much difference--the total extent count would
increase by less than 5%.

In my defrag experiments, the pareto limit kicks in at a target extent
size of 100K-200K (anything larger than this doesn't get better when
defragged, anything smaller kills performance if it's _not_ defragged).
256K may already be larger than optimal for some workloads.

> Even if a much needed garbage collection process were to be created,
> the smaller extents would mean less data would need to be re-written,
> (and potentially duplicated due to snapshots and ref copies.)

GC has to take all references into account when computing block
reachability, and it has to eliminate all references to remove garbage,
so there should not be any new duplicate data.  Currently GC has to
be implemented by copying the data and then using dedupe to replace
references to the original data individually, but that could be optimized
with a new kernel ioctl that handles all the references at once with a
lock, instead of comparing the data bytes for each one.

GC could create smaller extents intentionally, by creating new extents
in units of 256K, but reflinking them in reverse order over the original
large extents to prevent coalescing extents in writeback.

GC would also have to figure out whether the IO cost of splitting the
extent is worth the space saving (e.g. don't relocate 100MB of data to
save 4K of disk space, wait until it's at least 1MB of space saved).
That's a sysadmin policy input.

GC is not autodefrag.  If it sees that it has to carve up 100M extents
for sub-64K writes, GC can create 400x 256K extents to replace the large
extents, and only defrag when there's a contiguous range of modified
extents with length 64K or less.  Or whatever sizes turn out to be the
right ones--setting the sizes isn't the hard thing to do here.

Obviously, in that scenario it is more efficient if there's a way to
not write the 100M extents in the first place, but it quickly reaches
a steady state with relatively little wasted space, and doesn't require
tuning knobs in the kernel.

GC + autodefrag could go the other way, too:  make the default extent
size small, but allow autodefrag to request very large extents for files
that have not been modified in a while.  That's inefficient too, but
in other other direction, so it would be a better match for the steady
state of some workloads (e.g. video recording or log files).

Ideally there'd be an "optimum extent size" inheritable inode property,
so we can have databases use tiny extents and video recorders use huge
extents on the same filesystem.  But maybe that's overengineering,
and 256K (128K?  512K?) is within the range of values for most.

> The fine details on how to implement all of this is way over my head,
> but it seemed to me like the logic to keep the extents small is already
> more or less already there, and would need relatively very little work
> to manifest.

There's a #define for maximum new extent length.  It wouldn't be too
difficult to look up that number in fs_info instead, slightly harder
to look it up in an inode.  The limit applies only to new extents,
so there's no backward compatibility issue with the on-disk format.
