Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA78724557F
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 04:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgHPCvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Aug 2020 22:51:51 -0400
Received: from magic.merlins.org ([209.81.13.136]:54366 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbgHPCvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Aug 2020 22:51:51 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1k6o0N-0006Uo-8f by authid <merlin>; Fri, 14 Aug 2020 21:41:19 -0700
Date:   Fri, 14 Aug 2020 21:41:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Roman Mamedov <rm@romanrm.net>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200815044119.GR8863@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814021912.GR5890@hungrycats.org>
 <20200814014359.GQ5890@hungrycats.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 13, 2020 at 09:43:59PM -0400, Zygo Blaxell wrote:
> That "0A80" is the last 4 bytes of "80.00A80" which I mentioned above.
> They all need write cache turned off.
 
Cool. Those were different drives, not sure if they had the same bug.

> I'm told that SC61 firmware has a bug fix for SC60's write cache issues;
> however, I have some SC60 drives and haven't had write-cache problems
> with them.  They're probably fine.  Same for WD 01.01A01--some WD Green
> drives are OK.  I have no data for Samsung firmware.
 
So, as incredibly thankful as I am for you having this information, is
that stuff you just google?
Is there a DB of bad firmwares, and does linux maybe have a partial one
to turn off write caching on known bad drives, or am I talking crazy and
in happy happy land? :)

> bees typically only spends a single-digit percentage of its time
> manipulating metadata.  Most of the bees IO time is waiting for btrfs
> to do slow metadata reads while holding a transaction lock.
 
Gotcha.

> Anything after bcache stop is write cache flush theatre.  If the drive's
> write cache firmware is broken, then you can put all the flushes you
> want, but the flushes don't do anything that wouldn't also be achieved
> by just waiting for the disks to be idle for a while.
> 
> 5 seconds seems short to me.  I'd keep the drive powered for a minute or
> two before turning it off.  Ideally I'd set an idle timeout on the drive
> (hdparm -S) and wait until the disk spins itself down (hdparm -C).
 
I see. I didn't realize it could take that long for things to flush if
the firmware isn't doing the job of flushing when it said it did.

> Note that after a bus reset while the disks are online, the write caching
> flag might revert to default.
 
oh boy, thanks for the warning.

> Write cache corruption doesn't always occur at shutdown.  It can also
> happen if there is a UNC sector or even noise on the SATA cables that
> triggers a bus reset.  This wouldn't be detected by the host or btrfs--as
> far as the storage stack is concerned, the drive ACKed the flush, so
> the data's on the disk, and any losses after that point are equivalent
> to disk-level corruption.

I see, that makes sense.

> It would be nice if price correlated to firmware quality, but that's
> not how disk vendors make drives.  There's a firmware team that produces
> firmware for a disk controller SoC family.  It's a lot of expensive work,
> so it only happens once unless a major defect is found.  That firmware
> ends up in all the drive models built around that SoC family.  So you
> end up with White Label, WD Green, and WD Red drive models that all
> run the same handful of firmware builds even though there are dozens of
> distinct model numbers sold to different market segments (i.e. prices)
> over a period of many years.
 
I see, so I guess I don't feel as bad buying the cheaper white label
versions :)

> WD didn't think it was important to avoid SMR in NAS drives--a
> requirement that was so obvious that customers ultimately sued them
> over it.  WD certainly wouldn't think it was important for their NAS
> drives to have more correct firmware than the low-end discount model,
> and nobody sued them over it, so they all got shipped with the same bugs.

Yeah, I saw that, most BS move ever. They definitely deserve the
backlash coming with it.

Thanks for your answers.
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
