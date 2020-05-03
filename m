Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD31C2A19
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 07:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgECF0j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 3 May 2020 01:26:39 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37224 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgECF0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 May 2020 01:26:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 430726A1A87; Sun,  3 May 2020 01:26:37 -0400 (EDT)
Date:   Sun, 3 May 2020 01:26:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Phil Karn <karn@ka9q.net>, Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200503052637.GE10796@hungrycats.org>
References: <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org>
 <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org>
 <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
 <20200502090946.GO10769@hungrycats.org>
 <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 11:48:18AM -0600, Chris Murphy wrote:
> On Sat, May 2, 2020 at 3:09 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On SD/MMC and below-$50 SSDs, silent data corruption is the most common
> > failure mode.  I don't think these disks are capable of detecting or
> > reporting individual sector errors.  I've never seen it happen.  They
> > either fall off the bus or they have a catastrophic failure and give
> > an error on every single access.
> 
> I'm still curious about the allocator to use for this device class. SD
> Cards usually self-report rotational=0. Whereas USB sticks report
> rotational=1. The man page seems to suggest nossd or ssd_spread.

Use dup metadata on all single-disk filesystems, unless you are making
an intentionally temporary filesystem (like a RAM disk, or a cache with
totally expendable contents).  The correct function for maximizing btrfs
lifetime does not have "rotational" as a parameter.

> In my very limited sample size from a single vendor, I've only seen SD
> Card fail by becoming read only. i.e. hardware read-only, with the
> kernel spewing sd/mmc related debugging info about the card (or card's
> firmware). Maybe that's a good example? 

Yes, that would be a good example if you can read the card.  Usually
when these devices hit the end of their lives there's nothing left
to read, or big chunks of data are misplaced or missing entirely.

All SSDs eventually end read-only, completely inaccessible, or
otherwise incapable of accepting further writes, if you run them long
enough.  Since it's no longer possible to test the drive's capability
as a storage device after this happens, you can have at most one such
failure per drive.  All the other failure modes can happen multiple times.

Some cheap SSDs will flip a bit (either in data or in a sector address)
at some point during their testable lifetimes.  The same drive can do
this over and over, so the error counts get quite high, and this is
easily the single most common failure event.  Since the drive itself
seems unaware of the errors, it never hits any kind of internal limit
on the number of failures (contrast with UNC sectors, where eventually
the remapping table fills up).  Typical error rates are one sector every
few weeks once the drive is past 50% of its endurance rating, but some
cheap SSDs don't wait for 50% and start corrupting data right away.

Some cheap SSDs fail by dropping off the bus until power-cycled.
Sometimes they corrupt data and drop off the bus at the same time, so
this event can end up being included in the silent data corruption count.
That may produce an elevated silent data corruption count, but silent
data corruption is still the most common event even if all bus drops
are subtracted.

Some cheap SSDs fail by becoming 2 orders of magnitude slower suddenly.
This is rare, and there's no data loss in these events.

Some SSDs detect and report UNC sector errors, either on read operations
or SMART self-tests, which I presume are due to internal data corruption
combined with error checking by the firmware, though they could be
false positives.  Cheap SSDs never do this, it only occurs on drives
outside of the cheap SSD group.

I believe that the cheap SSDs are not capable of detecting or reporting
data corruption errors on individual sectors, given the large number
of opportunities they've been provided to demonstrate this capability
under my observation, and the exactly zero times they've used one.

Most of the above applies to SD/MMC devices as well, except I've never
seen a SD/MMC device that had the UNC sector error detection capability.
They only seem to have the cheap SSD failure modes.

> I suppose it's better to go
> read-only with data still readable, and insofar as Btrfs was concerned
> the data was correct, rather than start returning transiently bad
> data. However, I only knew this due to data checksums.
> 
> 
> -- 
> Chris Murphy
> 
