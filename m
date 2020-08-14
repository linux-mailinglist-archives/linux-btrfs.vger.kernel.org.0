Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123172442C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 03:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHNBoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 21:44:01 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47658 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNBoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 21:44:00 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3C7257B2393; Thu, 13 Aug 2020 21:43:59 -0400 (EDT)
Date:   Thu, 13 Aug 2020 21:43:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200814014359.GQ5890@hungrycats.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
 <20200812223433.GA533@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812223433.GA533@merlins.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 03:34:33PM -0700, Marc MERLIN wrote:
> On Tue, Jul 07, 2020 at 11:44:07PM -0400, Zygo Blaxell wrote:
> > sdd is running firmware 0957, also found in circa-2014 WD Green.
> > The others are running 01.01RA2 firmware that appears in a model family
> > that includes some broken WD Green and Red models from a few years back
> > (including the venerable datavore 80.00A80).  I have a few of the WD
> > branded versions of these drives.  They are unusable with write cache
> > enabled.  1 in 10 unclean shutdowns lead to filesystem corruption on
> > btrfs; on ext4, git and postgresql database corruption.  After disabling
> > write cache, I've used them for years with no problems.
> > 
> > Hopefully your bcache drive is OK, you didn't post any details on that.
> > bcache on a drive with buggy firmware write caching fails *spectacularly*.
> > 
> > You can work around buggy write cache firmware with a udev rule like
> > this to disable write cache on all the drives:
> > 
> >         ACTION=="add|change", SUBSYSTEM=="block", DRIVERS=="sd", KERNEL=="sd*[!0-9]", RUN+="/sbin/hdparm -W 0 $devnode"
> > 
> > Note that in your logs, the kernel reports that 'sdd' has write cache
> > disabled already, maybe due to lack of firmware support or a conservative
> > default setting.  That makes it probably the only drive in that array
> > that is working properly.
> 
> Hi Zygo, took a while to rebuild the array, but it's back up, thanks for
> your tips.
> 
> To avoid such pain in the future, is there a way for me to find out if
> my other drives have such problems so that I disable write caching on
> them now?

> WDC WD10EADS-00L 01.0 PQ: 0 ANSI: 6
> SAMSUNG HD102UJ  1AA0 PQ: 0 ANSI: 6
> ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
> ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
> ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
> ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
> ST6000VN0041-2EL SC61 PQ: 0 ANSI: 6
> WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
> WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
> WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
> WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
> WDC WD40EFRX-68W 0A80 PQ: 0 ANSI: 5

That "0A80" is the last 4 bytes of "80.00A80" which I mentioned above.
They all need write cache turned off.

I'm told that SC61 firmware has a bug fix for SC60's write cache issues;
however, I have some SC60 drives and haven't had write-cache problems
with them.  They're probably fine.  Same for WD 01.01A01--some WD Green
drives are OK.  I have no data for Samsung firmware.

> As for the failure you helped me with (thanks):
> In hindsight, I think I know what went wrong. I was running bees on the
> array to reclaim duplicate space (1.2TB saved, so it was worth it).
> bees does lots of metadata operations, so that would explain why the
> last operations that didn't get saved/got corrupted caused the fatal
> corruption I ended up with.

If the drive lost data writes then you'd have csum failures on data
blocks.  Some of my WD Reds with 0A80 firmware had those.

There's a lot of metadata writes all the time on btrfs, even with
data-heavy workloads.  You only need to lose any two metadata writes
(one in single or raid0 profile) to break the filesystem.

bees typically only spends a single-digit percentage of its time
manipulating metadata.  Most of the bees IO time is waiting for btrfs
to do slow metadata reads while holding a transaction lock.

> Because it's an external array, I do stop it to save power and do this:
> umount /dev/mapper/crypt_bcache0
> sync
> dmsetup remove crypt_bcache0
> echo 1 > /sys/block/md6/bcache/stop
> mdadm --stop /dev/md6
> /etc/init.d/smartmontools stop
> sleep 5
> pdu disk3 off  <= cuts power
> 
> Note that I umount, then sync just in case, then a bunch of stuff to
> free up block devices, but by then the btrfs FS has been unmounted and
> synced.
> 
> Yet, I added sleep 5 for good measure before turning the drives off.
> Do you think the cache was so broken that even with all the steps I
> took, it failed to flush?

Anything after bcache stop is write cache flush theatre.  If the drive's
write cache firmware is broken, then you can put all the flushes you
want, but the flushes don't do anything that wouldn't also be achieved
by just waiting for the disks to be idle for a while.

5 seconds seems short to me.  I'd keep the drive powered for a minute or
two before turning it off.  Ideally I'd set an idle timeout on the drive
(hdparm -S) and wait until the disk spins itself down (hdparm -C).

> Either way, I now do this as per your recommenation:
> grep md6 /proc/mdstat | sed "s/.*raid5 //" | tr ' ' '\012' | sed "s/1.*//" | while read d; do /sbin/hdparm -v -W 0 /dev/$d; done

Note that after a bus reset while the disks are online, the write caching
flag might revert to default.

Write cache corruption doesn't always occur at shutdown.  It can also
happen if there is a UNC sector or even noise on the SATA cables that
triggers a bus reset.  This wouldn't be detected by the host or btrfs--as
far as the storage stack is concerned, the drive ACKed the flush, so
the data's on the disk, and any losses after that point are equivalent
to disk-level corruption.

> Thanks
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
