Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E652843CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 03:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFBYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 21:24:30 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34450 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgJFBY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 21:24:29 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id ECA5983E480; Mon,  5 Oct 2020 21:24:27 -0400 (EDT)
Date:   Mon, 5 Oct 2020 21:24:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     cryptearth <cryptearth@cryptearth.de>, linux-btrfs@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: using raid56 on a private machine
Message-ID: <20201006012427.GD21815@hungrycats.org>
References: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
 <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 05, 2020 at 07:57:51PM +0200, Goffredo Baroncelli wrote:
> On 10/5/20 6:59 PM, cryptearth wrote:
> > Hello there,
> > 
> > as I plan to use a 8 drive RAID6 with BtrFS I'd like to ask about
> > the current status of BtrFS RAID5/6 support or if I should go with a
> > more traditional mdadm array.

Definitely do not use a single mdadm raid6 array with btrfs.  It is
equivalent to running btrfs with raid6 metadata:  mdadm cannot recover
from data corruption on the disks, and btrfs cannot recover from
write hole issues in degraded mode.  Any failure messier than a total
instantaneous disk failure will probably break the filesystem.

> > The general status page on the btrfs wiki shows "unstable" for
> > RAID5/6, and it's specific pages mentions some issue marked as "not
> > production ready". It also says to not use it for the metadata but
> > only for the actual data.

That's correct.  Very briefly, the issues are:

	1.  Reads don't work properly in degraded mode.

	2.  The admin tools are incomplete.

	3.  The diagnostic tools are broken.

	4.  It is not possible to recover from all theoretically
	recoverable failure events.

Items 1 and 4 make raid5/6 unusable for metadata (total filesystem loss
is likely).  Use raid1 or raid1c3 for metadata instead.  This is likely
a good idea even if all the known issues are fixed--metadata access
patterns don't perform well with raid5/6, and the most likely proposals
to solve the raid5/6 problems will require raid1/raid1c3 metadata to
store an update journal.

If your application can tolerate small data losses correlated with disk
failures (i.e. you can restore a file from backup every year if required,
and you have no requirement for data availability while replacing disks)
then you can use raid5 now; otherwise, btrfs raid5/6 is not ready yet.

> > I plan to use it for my own personal system at home - and I do
> > understand that RAID is no replacement for a backup, but I'd rather
> > like to ask upfront if it's ready to use before I encounter issues
> > when I use it.
> > I already had the plan about using a more "traditional" mdadm setup
> > and just format the resulting volume with ext4, but as I asked about
> > that many actually suggested to me to rather use modern filesystems
> > like BtrFS or ZFS instead of "old school RAID".

Indeed, old school raid maximizes your probability of silent data loss by
allowing multiple disks in inject silent data loss failures and firmware
bug effects.

btrfs and ZFS store their own data integrity information, so they can
reliably identify failures on the drives.  If redundant storage is used,
they can recover automatically from failures the drives can't or won't
report.

> > Do you have any help for me about using BtrFS with RAID6 vs mdadm or ZFS?
> 
> Zygo collected some useful information about RAID5/6:
> 
> https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
>
> However more recently Josef (one of the main developers), declared
> that BTRFS with RAID5/6 has  "...some dark and scary corners..."
> 
> https://lore.kernel.org/linux-btrfs/bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com/

I think my list is a little more...concrete.  ;)

> > I also don't really understand why and what's the difference between
> > metadata, data, and system.
> > When I set up a volume only define RAID6 for the data it sets
> > metadata and systemdata default to RAID1, but doesn't this mean that
> > those important metadata are only stored on two drives instead of
> > spread accross all drives like in a regular RAID6? This would somewhat
> > negate the benefit of RAID6 to withstand a double failure like a 2nd
> > drive fail while rebuilding the first failed one.
> 
> Correct. In fact Zygo suggested to user RAID6 + RAID1C3.
> 
> I have only few suggestions:
> 1) don't store valuable data on BTRFS with raid5/6 profile. Use it if
> you want to experiment and want to help the development of BTRFS. But
> be ready to face the lost of all data. (very unlikely, but more the
> size of the filesystem is big, more difficult is a restore of the data
> in case of problem).

Losing all of the data seems unlikely given the bugs that exist so far.
The known issues are related to availability (it crashes a lot and
isn't fully usable in degraded mode) and small amounts of data loss
(like 5 blocks per TB).

The above assumes you never use raid5 or raid6 for btrfs metadata.  Using
raid5 or raid6 for metadata can result in total loss of the filesystem,
but you can use raid1 or raid1c3 for metadata instead.

> 2) doesn't fill the filesystem more than 70-80%. If you go further
> this limit the likelihood to catch the "dark and scary corners"
> quickly increases.

Can you elaborate on that?  I run a lot of btrfs filesystems at 99%
capacity, some of the bigger ones even higher.  If there were issues at
80% I expect I would have noticed them.  There were some performance
issues with full filesystems on kernels using space_cache=v1, but
space_cache=v2 went upstream 4 years ago, and other significant
performance problems a year before that.

The last few GB is a bit of a performance disaster and there are
some other gotchas, but that's an absolute number, not a percentage.

Never balance metadata.  That is a ticket to a dark and scary corner.
Make sure you don't do it, and that you don't accidentally install a
cron job that does it.

> 3) run scrub periodically and after a power failure ; better to use
> an uninterruptible power supply (this is true for all the RAID, even
> the MD one).

scrub also provides early warning of disk failure, and detects disks
that are silently corrupting your data.  It should be run not less than
once a month, though you can skip months where you've already run a
full-filesystem read for other reasons (e.g. replacing a failed disk).

> 4) I don't have any data to support this; but as occasional reader of
> this mailing list I have the feeling that combing BTRFS with LUCKS(or
> bcache) raises the likelihood of a problem.

I haven't seen that correlation.  All of my machines run at least one
btrfs on luks (dm-crypt).  The larger ones use lvmcache.  I've also run
bcache on test machines doing power-fail tests.

That said, there are additional hardware failure risks involved in
caching (more storage hardware components = more failures) and the
system must be designed to tolerate and recover from these failures.

When cache disks fail, just uncache and run scrub to repair.  btrfs
checksums will validate the data on the backing HDD (which will be badly
corrupted after a cache SSD failure) and will restore missing data from
other drives in the array.

It's definitely possible to configure bcache or lvmcache incorrectly,
and then you will have severe problems.  Each HDD must have a separate
dedicated SSD.  No sharing between cache devices is permitted.  They must
use separate cache pools.  If one SSD is used to cache two or more HDDs
and the SSD fails, it will behave the same as a multi-disk failure and
probably destroy the filesystem.  So don't do that.

Note that firmware in the SSDs used for caching must respect write
ordering, or the cache will do severe damage to the filesystem on
just about every power failure.  It's a good idea to test hardware
in a separate system through a few power failures under load before
deploying them in production.  Most devices are OK, but a few percent
of models out there have problems so severe they'll damage a filesystem
in a single-digit number of power loss events.  It's fairly common to
encounter users who have lost a btrfs on their first or second power
failure with a problematic drive.  If you're stuck with one of these
disks, you can disable write caching and still use it, but there will
be added write latency, and in the long run it's better to upgrade to
a better disk model.

> 5) pay attention that having an 8 disks raid, raises the likelihood of a
> failure of about an order of magnitude more than a single disk ! RAID6
> (or any other RAID) mitigates that, in the sense that it creates a
> time window where it is possible to make maintenance (e.g. a disk
> replacement) before the lost of data.
> 6) leave the room in the disks array for an additional disk (to use
> when a disk replacement is needed)
> 7) avoid the USB disks, because these are not reliable
> 
> 
> > 
> > Any information appreciated.
> > 
> > 
> > Greetings from Germany,
> > 
> > Matt
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
