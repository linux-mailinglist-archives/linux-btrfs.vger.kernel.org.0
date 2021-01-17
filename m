Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026EE2F9502
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 20:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbhAQT4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 17 Jan 2021 14:56:00 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46874 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbhAQTz6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 14:55:58 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 896859436AC; Sun, 17 Jan 2021 14:55:16 -0500 (EST)
Date:   Sun, 17 Jan 2021 14:55:16 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: NVME experience?
Message-ID: <20210117195516.GK31381@hungrycats.org>
References: <b5ea0996-578e-8584-2cc7-4b8422f75566@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b5ea0996-578e-8584-2cc7-4b8422f75566@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 11:42:03PM +0000, Graham Cobb wrote:
> I am about to deploy my first btrfs filesystems on NVME. Does anyone
> have any hints or advice? Initially they will be root disks, but I am
> thinking about also moving home disks and other frequently used data to
> NVME, but probably not backups and other cold data.
> 
> I am mostly wondering about non-functionals like typical failure modes,
> life and wear, etc. Which might affect decisions like how to split
> different filesystems among the drives, whether to mix NVME with other
> drives (SSD or HDD), etc.

It doesn't really make sense to RAID a NVME device except with another
NVME device.  NVME's strength is access latency, and mirroring it with a
SATA device loses that strength (there is also more bandwidth in NVME
than SATA, if the underlying SSD is fast enough to use it).

If you need to cram one more disk into a full machine, and all you have
an unused NVME slot, it'll work, but it's wasteful.

You can use a NVME device as a dm-cache or bcache device--the low-latency
interface is ideal for caching use cases, if you have a suitably fast
and robust SSD.

> Are NVME drives just SSDs with a different interface? With similar
> lifetimes (by bytes written, or another measure)? And similar typical
> failure modes?

Pretty much.  Vendors will often sell model "XYZ123" as a SATA drive and
model "XYZ124" as NVME, with identical specs other than the interface
and different prices.  Probably most of the PCB is the same as well, as
M.2 board area can fit inside a 2.5" SATA box.  Firmware on the interface
side will be different, but firmware on the media side will be the same.

As a result, the device lifetime, failure modes, and firmware bugs are
often identical for NVME and SATA, and you have to read the data
sheets just as carefully to know what you're getting.

Like SATA disks, NVME devices can have volatile RAM caches and can
therefore (in theory) have power-loss write-cache bugs--it's

	nvme set-feature -f 6 -v 0 -s /dev/nvme...

to disable write cache on those, not 'hdparm -W0 /dev/sd...' as for SATA.
To date I haven't met an NVME device that needs this, but I have
relatively few of them compared to SATA and the industry is still young,
so I expect one will come along some day.

> Are they better or worse in terms of firmware bugs? Error detection for
> corrupted data? SMART or other indicators that they are starting to fail
> and should be replaced?

They need their own protocol for SMART and similar data, and the specific
data sets returned are different, but this is not more different than
it is between any other SATA drive models.  Up-to-date smartmontools
just works on most of the NVMEs I've tried, the rest worked a month or
two later at most.

Since they're basically the same drives, their SMART data has basically
the same usefulness on NVME and SATA within a device model family,
i.e. if the firmware self-test can't detect bad sectors in the SATA model,
it won't be able to detect them in the NVME version either.

> I assume that they do not (in practice) suffer from "faulty cable" problems.

This is a theoretical problem (like dust in the connector, bent pins,
manufacturing defect, etc) but I've never hit it in practice so I can't
say much about what it looks like.

Usually if a PCIE card isn't seated correctly it doesn't work in
obvious ways.  NVME would be similar.

NVME devices are held in their slots with screws, so you're not going to
have "loose connector" or "pulled cable" issues that are possible with
SATA (though in cable-less setups, SATA drives are held in their slots
with screws too).

> Anyway, I am hoping someone has experiences to share which might be useful.

If you want more than one or two NVME on the same consumer mainboard,
then you sometimes have to worry about having enough PCIE lanes for your
other devices, as each NVME device will permanently occupy one.  "You can
use the second NVME port _or_ two of the built-in SATA ports _or_ one
of the X16 slots" is a common trade-off as the BIOS can switch one PCIE
lane to multiple points on the mainboard but not share it between devices.

This means NVME devices are frequently limited to single-device
configurations on consumer mainboards, two devices on some newer
mainboards.

You can buy M.2 SSDs that don't have NVME interfaces (they implement
SATA in the connector, there's a B key notch instead of M key so they
will not fit in an incompatible slot).  Watch out for that.

> Graham
