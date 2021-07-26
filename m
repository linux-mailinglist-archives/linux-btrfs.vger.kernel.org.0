Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA853D516D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 04:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhGZCM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 22:12:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40830 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhGZCM6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 22:12:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4D50DB003C9; Sun, 25 Jul 2021 22:53:27 -0400 (EDT)
Date:   Sun, 25 Jul 2021 22:53:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Maybe we want to maintain a bad driver list? (Was 'Re: "bad tree
 block start, want 419774464 have 0" after a clean shutdown, could it be a
 disk firmware issue?')
Message-ID: <20210726025327.GG10170@hungrycats.org>
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz>
 <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
 <20210722135455.GU19710@twin.jikos.cz>
 <20210724231527.GF10170@hungrycats.org>
 <7cc3c882-6509-ffde-ac32-2d4dba6ade94@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cc3c882-6509-ffde-ac32-2d4dba6ade94@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 01:27:56PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/25 上午7:15, Zygo Blaxell wrote:
> > On Thu, Jul 22, 2021 at 03:54:55PM +0200, David Sterba wrote:
> > > On Thu, Jul 22, 2021 at 08:18:21AM +0800, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2021/7/22 上午1:44, David Sterba wrote:
> > > > > On Fri, Jul 16, 2021 at 11:44:21PM +0100, Jorge Bastos wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > This was a single disk filesystem, DUP metadata, and this week it stop
> > > > > > mounting out of the blue, the data is not a concern since I have a
> > > > > > full fs snapshot in another server, just curious why this happened, I
> > > > > > remember reading that some WD disks have firmware with write caches
> > > > > > issues, and I believe this disk is affected:
> > > > > > 
> > > > > > Model family:Western Digital Green
> > > > > > Device model:WDC WD20EZRX-00D8PB0
> > > > > > Firmware version:80.00A80
> > > > > 
> > > > > For the record summing up the discussion from IRC with Zygo, this
> > > > > particular firmware 80.00A80 on WD Green is known to have problematic
> > > > > firmware and would explain the observed errors.
> > > > > 
> > > > > Recommendation is not to use WD Green or periodically disable the write
> > > > > cache by 'hdparm -W0'.
> > > > 
> > > > Zygo is always the god to expose bad hardware.
> > > > 
> > > > Can we maintain a list of known bad hardware inside btrfs-wiki?
> > > > And maybe escalate it to other fses too?
> > > 
> > > Yeah a list on wiki would be great, though I'm a bit skeptical about
> > > keeping it up up to date, there are very few active wiki editors, the
> > > knowledge is still mostly stored in the IRC logs. But without a landing
> > > page on wiki we can't even start, so I'll create it.
> > 
> > Some points to note:
> > 
> > Most HDD *models* are good (all but 4% of models I've tested, and the
> > ones that failed were mostly 8?.00A8?),
> 
> That's what we expect.
> 
> > but the very few models that
> > are bad form a significant portion of drives in use:  they are the cheap
> > drives that consumers and OEMs buy millions of every year.
> > 
> > 80.00A80 keeps popping up in parent-transid-verify-failed reports from
> > IRC users.  Sometimes also 81.00A81 and 82.00A82 (those two revisions
> > appear on some NAS vendor blacklists as well).  I've never seen 83.00A83
> > fail--I have some drives with that firmware, and they seem OK, and I
> > have not seen any reports about it.
> 
> In fact, even just one model number is much better than nothing.

WD in particular seems to use firmware revisions as unique identifiers
across many drive models.  For this vendor, firmware revision is a more
predictive indicator than model number.  There may exist drives where
the same model number is used, but newer (and bug-fixed) firmware is
inside them.

Of course if you want to buy a drive, you usually only get to pick the
model number, not the firmware revision.

Other vendors don't do it this way.  Some vendors put "0001" or similar in
the firmware revision field of several completely different drive models.
In those cases we really do need the model number.

A raw table of drive stats should include both fields.

> We know nowadays btrfs is even able to detect bitflip, but we don't
> really want weird hardware to bring blame which we don't deserve.
> 
> > 80.00A80 may appear in a lot of low-end WD drive models (here "low end"
> > is "anything below Gold and Ultrastar"), marketed under other names like
> > White Label, or starring as the unspecified model inside USB external
> > drives.
> > 
> > The bad WD firmware has been sold over a period of at least 8 years.
> > Retail consumers can buy new drives today with this firmware (the most
> > recent instance we found was a WD Blue 1TB if I'm decoding the model
> > string correctly).  Even though WD seems to have fixed the bugs years
> > ago (in 83.00A83), the bad firmware doesn't die out as hardware ages
> > out of the user population because users keep buying new drives with
> > the old firmware.
> > 
> > It seems that _any_ HDD might have write cache issues if it is having
> > some kind of hardware failure at the same time (e.g. UNC sectors or
> > power supply issues).  A failing drive is a failing drive, it might blow
> > up a btrfs with dup profile that would otherwise have survived.  It is
> > possible that firmware bugs are involved in these cases, but it's hard
> > to make a test fleet large enough for meaningful and consistent results.
> 
> For such case, I guess smart is enough to tell the drive is failing?
> Thus it shouldn't be that a big concern IMHO.

A clean report from SMART does not necessarily mean the drive is
healthy--it just means the drive didn't record any failures, possibly
because the facility for recording failures itself is broken.

Some SMART implementations store SMART failure stats on the drive platter.
If there's a hardware failure that prevents the firmware from completing
data writes, that failure can also prevent updates of SMART error logs
or event counters.

Some SSD firmware implementations report no errors at any point in the
drive's lifetime, even as the drive ages and begins to silently corrupt
data at exponentially increasing rates, and the drive eventually stops
responding entirely.  SMART is useless on such devices--the firmware
can't detect errors, so it can't increment any SMART error counters or
add entries to SMART error logs.

Certainly if SMART is reporting new errors, around the same time when
btrfs splats, and drive write cache was enabled during the failures, then
it's very likely that the drive failure broke write caching.  Write cache
disable can let the drive be used successfully with btrfs for some time
after that, until some more fatal failure occurs.

> > SSDs are a different story:  there are so many models, firmware revisions
> > are far more diverse, and vendors are still rapidly updating their
> > designs, so we never see exactly the same firmware in any two incident
> > reports.  A firmware list would be obsolete in days.  There is nothing
> > in SSD firmware like the decade-long stability there is in HDD firmware.
> 
> Yeah, that's more or less expected.
> 
> So we don't need to bother that for now.
> 
> Thanks for your awesome info again!
> Qu
> 
> > 
> > IRC users report occasional parent-transid-verify-failure or similar
> > metadata corruption failures on SSDs, but they don't seem to be repeatable
> > with other instances of the same model device.  Samsung dominates the
> > SSD problem reports, but Samsung also dominates the consumer SSD market,
> > so I think we are just seeing messy-but-normal-for-SSD hardware failures,
> > not evidence of firmware bugs.
> > 
> > It's also possible that the window for exploiting a powerfail write cache
> > bug is much, much shorter for SSD than HDD, so even if the bugs do exist,
> > the probability of hitting one is negligible.
> > 
