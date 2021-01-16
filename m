Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D82F8F0B
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAPUCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 15:02:08 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41482 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhAPUCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 15:02:08 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7D9EA941C48; Sat, 16 Jan 2021 15:01:26 -0500 (EST)
Date:   Sat, 16 Jan 2021 15:01:26 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Adam Borowski <kilobyte@angband.pl>, dsterba@suse.cz,
        waxhead <waxhead@dirtcellar.net>, linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210116200126.GI31381@hungrycats.org>
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
 <20210115035448.GD31381@hungrycats.org>
 <94a65b16-3a23-6862-9de6-169620302308@gmail.com>
 <20210116151933.GA374963@angband.pl>
 <af37a93c-65d3-1213-73cf-1463679d815a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af37a93c-65d3-1213-73cf-1463679d815a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 08:21:16PM +0300, Andrei Borzenkov wrote:
> 16.01.2021 18:19, Adam Borowski пишет:
> > On Sat, Jan 16, 2021 at 10:39:51AM +0300, Andrei Borzenkov wrote:
> >> 15.01.2021 06:54, Zygo Blaxell пишет:
> >>> On the other hand, I'm in favor of deprecating the whole discard option
> >>> and going with fstrim instead.  discard in its current form tends to
> >>> increase write wear rather than decrease it, especially on metadata-heavy
> >>> workloads.  discard is roughly equivalent to running fstrim thousands
> >>> of times a day, which is clearly bad for many (most?  all?) SSDs.
> >>
> >> My (probably naive) understanding so far was that trim on SSD marks
> >> areas as "unused" which means SSD need to copy less residual data from
> >> erase block when reusing it. Assuming TRIM unit is (significantly)
> >> smaller than erase block.
> >>
> >> I would appreciate if you elaborate how trim results in more write on SSD?
> > 
> > The areas are not only marked as unused, but also zeroed.  To keep the
> > zeroing semantic, every discard must be persisted, thus requiring a write
> > to the SSD's metadata (not btrfs metadata) area.
> > 
> 
> There is no requirement that TRIM did it. If device sets RZAT SUPPORTED
> bit, it should return zeroes for trimmed range, but there is no need to
> physically zero anything - simply return zeroes for areas marked as
> unallocated. Discard must be persisted in allocation table, but then
> every write must be persisted in allocation table anyway.

That is exactly the problem--the persistence is a write that counts
against total drive wear.  That is why TRIM variants that leave
the contents of the discarded LBAs undefined are better than those
which define the contents as zero.

The effect seems to be the equivalent of a small write, i.e. a 16K
write might be the same cost as any length of contiguous discard.
So it's OK to discard block-group-sized regions, but not OK to issue
one discard for every metadata free page hole.  Different drives have
different ratios between these costs, so parity might occur at 4K or
256K depending on the drive.

AIUI there is a minimum discard length filter implemented in btrfs
already, so maybe it just needs tuning?

> Moreover, to actually zero on TRIM either trim request must be issued
> for the full erase block or device must perform garbage collection.
> 
> Do you have any links that show that discards increase write load on
> physical media? I am really curious.

I have no links, it's a directly observed result.

It's fairly straightforward to replicate:  Set up a machine to do git
checkouts of each Linux kernel tag in random order, in a loop (maybe
multiple instances of this if needed to get the SSD device IO saturated).
While that happens, watch the percentage used endurance indicator reported
on the drives (smartctl -x).  Wait for the indicator to increment
twice, and measure the time between the first and second increment.
Use a low-cost consumer or OEM SSD so you get results in less than a
few hundred hours.  Then mount -o discard=async and wait for two more
increments.  Assuming the workload produces constant amounts of IO over
time, and the percentage used endurance indicator variable from SMART is
not a complete lie, the time between increments should roughly indicate
the wear rates of the different workloads.

In the field, we discovered this on CI builder workloads (lots of
tiny files created, destroyed, and created again in rapid succession).
They get almost double the SSD wear rate with discard on vs. discard off.
We have monitoring on the p-u-e-i variable, and use it to project the date
when 100% endurance will be reached.  If that date lands within the date
range when we want to be using the SSD, we get an alert.  When discard
is accidentally enabled on a CI server due to a configuration failure,
we get an alert about a week later, as it shortens our drives' projected
lifespan from more than 6 years to less than 4.

Other workloads are less sensitive to this.  If the workload has fewer
metadata updates, bigger files, and sequential writes, then discard
doesn't have a negative effect--though to be fair, it doesn't seem to
have a positive effect either, at least not by this measurement method.
