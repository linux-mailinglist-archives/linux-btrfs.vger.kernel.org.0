Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141A02852E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgJFUHR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 6 Oct 2020 16:07:17 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33854 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFUHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 16:07:17 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id ECFBE84035C; Tue,  6 Oct 2020 16:07:15 -0400 (EDT)
Date:   Tue, 6 Oct 2020 16:07:15 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     cryptearth <cryptearth@cryptearth.de>, linux-btrfs@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: using raid56 on a private machine
Message-ID: <20201006200715.GN5890@hungrycats.org>
References: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
 <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
 <20201006012427.GD21815@hungrycats.org>
 <db963644-ac4b-cf19-dcf6-795ff92413e8@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <db963644-ac4b-cf19-dcf6-795ff92413e8@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 06, 2020 at 07:12:04PM +0200, Goffredo Baroncelli wrote:
> On 10/6/20 3:24 AM, Zygo Blaxell wrote:
> > On Mon, Oct 05, 2020 at 07:57:51PM +0200, Goffredo Baroncelli wrote:
> [...]
> 
> > > 
> > > I have only few suggestions:
> > > 1) don't store valuable data on BTRFS with raid5/6 profile. Use it if
> > > you want to experiment and want to help the development of BTRFS. But
> > > be ready to face the lost of all data. (very unlikely, but more the
> > > size of the filesystem is big, more difficult is a restore of the data
> > > in case of problem).
> > 
> > Losing all of the data seems unlikely given the bugs that exist so far.
> > The known issues are related to availability (it crashes a lot and
> > isn't fully usable in degraded mode) and small amounts of data loss
> > (like 5 blocks per TB).
> 
> From what I reading in the mailing list when the problem is too complex to solve
> to the point that the filesystem has to be re-format, quite often the main issue is not to
> "extract" the data, but is about the availability of additional space to "store" the data.
> 
> > 
> > The above assumes you never use raid5 or raid6 for btrfs metadata.  Using
> > raid5 or raid6 for metadata can result in total loss of the filesystem,
> > but you can use raid1 or raid1c3 for metadata instead.
> > 
> > > 2) doesn't fill the filesystem more than 70-80%. If you go further
> > > this limit the likelihood to catch the "dark and scary corners"
> > > quickly increases.
> > 
> > Can you elaborate on that?  I run a lot of btrfs filesystems at 99%
> > capacity, some of the bigger ones even higher.  If there were issues at
> > 80% I expect I would have noticed them.  There were some performance
> > issues with full filesystems on kernels using space_cache=v1, but
> > space_cache=v2 went upstream 4 years ago, and other significant
> > performance problems a year before that.
> 
> My suggestion was more to have enough space to not stress the filesystem
> than "if you go behind this limit you have problem".
> 
> A problem of BTRFS that confuses the users is that you can have space, but you
> can't allocate a new metadata chunk.
> 
> See
> https://lore.kernel.org/linux-btrfs/6e6565b2-58c6-c8c1-62d0-6e8357e41a42@gmx.com/T/#t
> 
> 
> Having the filesystem filled to 99% means that you have to check carefully
> the filesystem (and balance it) to avoid scenarios like this.

Nah.  Never balance metadata, and let the filesystem fill up.  As long
as the largest disks are sufficient for the raid profile, and there
isn't a radical change in usage after it's mostly full (i.e. a sudden
increase in snapshots or dedupe for the first time after the filesystem
has been filled), it'll be fine with no balances at all.

If the largest disks are the wrong sizes (e.g.  you're using raid6 and
the 2 largest disks are larger than the third), then you'll hit ENOSPC
at some point (which might be 80% full, or 10% full, depending on disk
sizes and profile), and it's inevitable, you'll hit ENOSPC no matter
what you do.

Arguably the tools could detect and warn about that case.  It's not
exactly hard to predict the failure.  A few lines of 'btrfs fi usage'
output and some counting are enough to spot it.

> On other side 1% of 1TB (a small filesystem for today standard) are about
> 10GB, that everybody should consider enough....

Most of the ENOSPC paint-into-the-corner cases I've seen (assuming it's
possible to allocate all the space with the chosen disk sizes and raid
profile) are on drives below 1TB, where GB-sized metadata allocations take
up bigger percentages of free space.  btrfs allocates space in absolute
units (1GB per chunk), so it's the absolute amount of free space that
causes the problems.  A 20GB filesystem can run into problems that need
workarounds at 50% full, while a 20TB filesystem can go all the way up
to 99.95% without issue.

> > The last few GB is a bit of a performance disaster and there are
> > some other gotchas, but that's an absolute number, not a percentage.
> 
> True, it is sufficient to have few GB free (i.e. not allocated by chunk)
> in *enough* disks...
> 
> However these requirements are a bit complex to understand by a new BTRFS
> users.

True, more tool support for the provably bad cases would be good here,
as well as a reliable estimate for how much space remains available for
metadata.  Some of the issues are difficult to boil down to numbers,
though, they are about _shape_.

> > Never balance metadata.  That is a ticket to a dark and scary corner.
> > Make sure you don't do it, and that you don't accidentally install a
> > cron job that does it.
> > 
> > > 3) run scrub periodically and after a power failure ; better to use
> > > an uninterruptible power supply (this is true for all the RAID, even
> > > the MD one).
> > 
> > scrub also provides early warning of disk failure, and detects disks
> > that are silently corrupting your data.  It should be run not less than
> > once a month, though you can skip months where you've already run a
> > full-filesystem read for other reasons (e.g. replacing a failed disk).
> > 
> > > 4) I don't have any data to support this; but as occasional reader of
> > > this mailing list I have the feeling that combing BTRFS with LUCKS(or
> > > bcache) raises the likelihood of a problem.
> 
> > I haven't seen that correlation.  All of my machines run at least one
> > btrfs on luks (dm-crypt).  The larger ones use lvmcache.  I've also run
> > bcache on test machines doing power-fail tests.
> 
> 
> > 
> > That said, there are additional hardware failure risks involved in
> > caching (more storage hardware components = more failures) and the
> > system must be designed to tolerate and recover from these failures.
> > 
> > When cache disks fail, just uncache and run scrub to repair.  btrfs
> > checksums will validate the data on the backing HDD (which will be badly
> > corrupted after a cache SSD failure) and will restore missing data from
> > other drives in the array.
> > 
> > It's definitely possible to configure bcache or lvmcache incorrectly,
> > and then you will have severe problems.  Each HDD must have a separate
> > dedicated SSD.  No sharing between cache devices is permitted.  They must
> > use separate cache pools.  If one SSD is used to cache two or more HDDs
> > and the SSD fails, it will behave the same as a multi-disk failure and
> > probably destroy the filesystem.  So don't do that.
> > 
> > Note that firmware in the SSDs used for caching must respect write
> > ordering, or the cache will do severe damage to the filesystem on
> > just about every power failure.  It's a good idea to test hardware
> > in a separate system through a few power failures under load before
> > deploying them in production.  Most devices are OK, but a few percent
> > of models out there have problems so severe they'll damage a filesystem
> > in a single-digit number of power loss events.  It's fairly common to
> > encounter users who have lost a btrfs on their first or second power
> > failure with a problematic drive.  If you're stuck with one of these
> > disks, you can disable write caching and still use it, but there will
> > be added write latency, and in the long run it's better to upgrade to
> > a better disk model.
> > 
> > > 5) pay attention that having an 8 disks raid, raises the likelihood of a
> > > failure of about an order of magnitude more than a single disk ! RAID6
> > > (or any other RAID) mitigates that, in the sense that it creates a
> > > time window where it is possible to make maintenance (e.g. a disk
> > > replacement) before the lost of data.
> > > 6) leave the room in the disks array for an additional disk (to use
> > > when a disk replacement is needed)
> > > 7) avoid the USB disks, because these are not reliable
> > > 
> > > 
> > > > 
> > > > Any information appreciated.
> > > > 
> > > > 
> > > > Greetings from Germany,
> > > > 
> > > > Matt
> > > 
> > > 
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
