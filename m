Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC8285272
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgJFTbQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 6 Oct 2020 15:31:16 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42322 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgJFTbQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 15:31:16 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8BD0684021A; Tue,  6 Oct 2020 15:31:13 -0400 (EDT)
Date:   Tue, 6 Oct 2020 15:31:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     cryptearth <cryptearth@cryptearth.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: using raid56 on a private machine
Message-ID: <20201006193113.GM5890@hungrycats.org>
References: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
 <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
 <20201006012427.GD21815@hungrycats.org>
 <6c516b70-d85f-6115-88e9-295adf4221b3@cryptearth.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <6c516b70-d85f-6115-88e9-295adf4221b3@cryptearth.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 06, 2020 at 07:50:18AM +0200, cryptearth wrote:
> Hello Zygo,
> 
> that's quite a lot of information I wasn't aware of.
> 
> // In advance: Sorry for the wall of text. That mail got a bit longer than I
> thought.
> 
> I guess one point I still have to get my head around is about meta-blocks vs
> data-blocks: I don't even know if and how my current raid is capable of
> detecting other types of errors than instant failures, like corruption of
> structual meta-data or the actual data-blocks itself. Up until now, I never
> encountered any data corruption, neither read nor write issues. I always was
> able to correctly read all data the exact same as I've written them. There's
> only one application that uses rather big files (only in the range of
> 1gb-3gb) which keeps somehow corrupting itself (it's GTA V), but as the
> files that fail are files which, at least in my eyes, are only should be
> opened to read during runtime (as they contain assets like models and
> textures), but are actually opened in read/write mode I suspect that for
> some odd reason the game itself keeps writing data to those data and by it
> keep corrupting itself. Other big file, like other types of images (all
> about 4gb and more) or database files, which I also often read from and
> write to, never got any of these issues - but I guess that's just GTA V at
> its best - aside from some other rather strange CRM I had to use it's one of
> the worst pieces of modern software I know.
> The types of errors I encountered and which led to me replacing the drives
> makred as failed were about this: The monitoring software of this amd
> fakeraid at some point pops up one of those notifications telling me that
> one of the drives failed, was set to offline, and the raid was set to
> critical. Looking into the logs it only says that some operation <hex-code>
> failed at some address <another hex-code> on some drive (port number) and
> that the BSL (bad sector list) was updated. This comes up a few times and
> then this line about that drive going offline - so, it's a burst error. But:
> Even using Google didn't got me what those operation code mean. So, I don't
> know if a drive failed for some read or write error, some parity or checksum
> issue, or for whatever reason. All information I get is that there's a burst
> error, the drive is marked as bad, some list is updated and the array is set
> to a degraded state.
> But: Otherwise to what I tested so far with BtrFS it's not like the array
> goes offline or isn't available after reboot anymore. I can keep using it,
> and, as RAID5, at least this one, seem to always calculate and check at
> least some sort of checksum, there isn't even any performance penalty. To
> get it running again all I have to do is to shutdown the system, replace the
> drive, boot up again (that's caused by the hardware - it doesn't support
> hotplug) and hit rebuild in the raid control panel - which takes only a
> couple of hours with my 3TB drives.
> But, as already mentioned, as this is only RAID5 each rebuild is like
> gambling and hoping for no other drive fails until the rebuild is finished.
> If another drive would go bad during rebuild the data would most likely be
> lost. And recovery would even be harder as it's AMDs proprietary stuff - and
> from what I was able to find AMD denied help even to businesses - let alone
> me as a private person. All I could do would be to replace the board with
> some compatible one, but I don't even know if it just has to have a SB950
> chipset, or if it has to be the exact same board. The "bios-level" interface
> seem to be implemented as an option rom on its own - so it shouldn't depend
> on the specific board.
> 
> Anyway, long story short: I don'T want to wait until that catastrophe
> occurs, but rather want to prevent it by change my setup. Instead of rely
> something fused onto the motherboard my friend suggest to use a simple
> "dumb" HBA and do all the stuff in software, like Linux mdadm or BtrFS/ZFS.
> As I learned over the past few days while learning about BtrFS' RAID-like
> capabilities RAID isn't as simple as I thought until now but can actually
> suffer from one (or more) drive return corrupted data instead of just fail,
> and a typical hardware RAID controller or many "rather simple" software raid
> implementations can't tell the difference between the actual data and some
> not so good ones. As it was explained in some talk: Some implementations
> work in a way that if a data-block becomes corrupted which result in a fail
> of parity check the parity, which could actually be used to recover the
> correct data, is thrown away and overriden with some corrupted data
> re-calculated with the corrupted data-block. Hence using special filesystems
> like BtrFS and ZFS is recommended as they have additional information like
> per-block checksums to actually tell if the checksum calculation failed or
> if some data-block became corrupted.
> 
> As ZFS seem to have some not so clear license related stuff preventing it
> from get included into the kernel I took a look at BtrFS - which doesn't
> seem to fit my needs. Sure, I could go with a RAID 1+0 - but this still
> would result in only about 12TB useable space while actually throwing in 3
> more 3TB drives, but I actually planed to increase the useable size of my
> array instead of just bump it's redundancy. As for metadata: I've read up
> about the RAID1 and RAID3/4 profiles: And although RAID1c3 is recommended
> for a RAID6 (which would store 3 copies so there should be at least one copy
> left even in a double failure) is using a RAID1c4 also an option? I wouldn't
> mind to give up a bit of the available space to an extra metadata copy if it
> helps to prevent data loss in the case of a drive failure.
> 
> You also wrote to never balance metadata. But how should I restore the lost
> metadata after a drive replacement if I only re-balance the data-blocks? 

Replace and balance are distinct operations.

Replace reconstructs the contents of a missing drive on a new blank drive.
It is fast and works for all btrfs raid levels.

Balance redistributes existing data onto drives that have more space,
and reduces free space fragmentation.  This is good for data as it
makes future allocations faster and more contiguous; however, there
is no similar benefit for metadata.  Balance is bad for metadata as it
reduces space previously allocated for metadata to a minimum, and it's
possible to run out of metadata space before metadata can expand again.
This can be very difficult to recover from, and it's much easier to
simply never balance metadata to avoid the issue in the first place.

> Do
> they get updated and re-distributed in the background while restoring the
> data-blocks during a rebuild? 

'btrfs replace' reads mirror/parity disks and writes the contents of
the missing disk sequentially onto a new device.  There is no change in
distribution of the data possible with replace--all of the optimizations
in replace rely on the missing disk and the new replacement disk having
identical physical layout.  The new disk must be equal or larger size
to the missing disk that is replaced.  You start the replace process
manually when the new drive is installed, it does a lot of IO (technically
in the background, but fairly heavy for interactive use) until it is done.

You can also add a disk and remove a missing disk (the 'dev add' and 'dev
remove' operations) and then run balance to fill all the disks fairly,
which is more flexible, e.g. you can add 2 small disks to replace 1 large
disk.  This can be 10-100x slower than replace, and doesn't work properly
for raid5/6 in degraded mode yet (though it can be used for raid5 when all
disks are healthy and you just want the array to be bigger or smaller).

> Or is this more like: "redundancy builds up
> again over time by the regular algorithms"? I may still have something wrong
> in my understanding about "using multiple disks in one array" so currently I
> would suspect that all data are rebuild - also metadata - but I guess BtrFS
> works different on this topic?
> 
> Yes, I can tolerate loss of data as I do have an extra backup of my
> important data, and as I only use it for my personal use I guess any data
> lost by not having a proper backup of them is on me anyway, but seeing BtrFS
> and ZFS used in like 45 drive arrays for crucial data with requirement for
> high availability I'd like to find a solution I can set up my array in a way
> like RAID6, so it can withstand a double failure, but which is also still
> available during a rebuild. And although during my tests BtrFS showed
> promissing when I was able to mount and use an array with WinBtrFS, which
> would also solve my additional quest for come up with some way of use the
> same volume on both Linux and Windows, it doesn't seem to be ready for my
> plan yet, or at least not with the knowledge I got so far. I'm open for any
> suggestions and explanations as I obvious still have quite a lot to learn -
> and, if I may set up a BtrFS volume, likely to require some help doing it
> "the right way" for what I'd like.
> 
> Thanks to anyone, and sorry again for that rather long mail
> 
> Matt
> 
> Am 06.10.2020 um 03:24 schrieb Zygo Blaxell:
> > On Mon, Oct 05, 2020 at 07:57:51PM +0200, Goffredo Baroncelli wrote:
> > > On 10/5/20 6:59 PM, cryptearth wrote:
> > > > Hello there,
> > > > 
> > > > as I plan to use a 8 drive RAID6 with BtrFS I'd like to ask about
> > > > the current status of BtrFS RAID5/6 support or if I should go with a
> > > > more traditional mdadm array.
> > Definitely do not use a single mdadm raid6 array with btrfs.  It is
> > equivalent to running btrfs with raid6 metadata:  mdadm cannot recover
> > from data corruption on the disks, and btrfs cannot recover from
> > write hole issues in degraded mode.  Any failure messier than a total
> > instantaneous disk failure will probably break the filesystem.
> > 
> > > > The general status page on the btrfs wiki shows "unstable" for
> > > > RAID5/6, and it's specific pages mentions some issue marked as "not
> > > > production ready". It also says to not use it for the metadata but
> > > > only for the actual data.
> > That's correct.  Very briefly, the issues are:
> > 
> > 	1.  Reads don't work properly in degraded mode.
> > 
> > 	2.  The admin tools are incomplete.
> > 
> > 	3.  The diagnostic tools are broken.
> > 
> > 	4.  It is not possible to recover from all theoretically
> > 	recoverable failure events.
> > 
> > Items 1 and 4 make raid5/6 unusable for metadata (total filesystem loss
> > is likely).  Use raid1 or raid1c3 for metadata instead.  This is likely
> > a good idea even if all the known issues are fixed--metadata access
> > patterns don't perform well with raid5/6, and the most likely proposals
> > to solve the raid5/6 problems will require raid1/raid1c3 metadata to
> > store an update journal.
> > 
> > If your application can tolerate small data losses correlated with disk
> > failures (i.e. you can restore a file from backup every year if required,
> > and you have no requirement for data availability while replacing disks)
> > then you can use raid5 now; otherwise, btrfs raid5/6 is not ready yet.
> > 
> > > > I plan to use it for my own personal system at home - and I do
> > > > understand that RAID is no replacement for a backup, but I'd rather
> > > > like to ask upfront if it's ready to use before I encounter issues
> > > > when I use it.
> > > > I already had the plan about using a more "traditional" mdadm setup
> > > > and just format the resulting volume with ext4, but as I asked about
> > > > that many actually suggested to me to rather use modern filesystems
> > > > like BtrFS or ZFS instead of "old school RAID".
> > Indeed, old school raid maximizes your probability of silent data loss by
> > allowing multiple disks in inject silent data loss failures and firmware
> > bug effects.
> > 
> > btrfs and ZFS store their own data integrity information, so they can
> > reliably identify failures on the drives.  If redundant storage is used,
> > they can recover automatically from failures the drives can't or won't
> > report.
> > 
> > > > Do you have any help for me about using BtrFS with RAID6 vs mdadm or ZFS?
> > > Zygo collected some useful information about RAID5/6:
> > > 
> > > https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
> > > 
> > > However more recently Josef (one of the main developers), declared
> > > that BTRFS with RAID5/6 has  "...some dark and scary corners..."
> > > 
> > > https://lore.kernel.org/linux-btrfs/bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com/
> > I think my list is a little more...concrete.  ;)
> > 
> > > > I also don't really understand why and what's the difference between
> > > > metadata, data, and system.
> > > > When I set up a volume only define RAID6 for the data it sets
> > > > metadata and systemdata default to RAID1, but doesn't this mean that
> > > > those important metadata are only stored on two drives instead of
> > > > spread accross all drives like in a regular RAID6? This would somewhat
> > > > negate the benefit of RAID6 to withstand a double failure like a 2nd
> > > > drive fail while rebuilding the first failed one.
> > > Correct. In fact Zygo suggested to user RAID6 + RAID1C3.
> > > 
> > > I have only few suggestions:
> > > 1) don't store valuable data on BTRFS with raid5/6 profile. Use it if
> > > you want to experiment and want to help the development of BTRFS. But
> > > be ready to face the lost of all data. (very unlikely, but more the
> > > size of the filesystem is big, more difficult is a restore of the data
> > > in case of problem).
> > Losing all of the data seems unlikely given the bugs that exist so far.
> > The known issues are related to availability (it crashes a lot and
> > isn't fully usable in degraded mode) and small amounts of data loss
> > (like 5 blocks per TB).
> > 
> > The above assumes you never use raid5 or raid6 for btrfs metadata.  Using
> > raid5 or raid6 for metadata can result in total loss of the filesystem,
> > but you can use raid1 or raid1c3 for metadata instead.
> > 
> > > 2) doesn't fill the filesystem more than 70-80%. If you go further
> > > this limit the likelihood to catch the "dark and scary corners"
> > > quickly increases.
> > Can you elaborate on that?  I run a lot of btrfs filesystems at 99%
> > capacity, some of the bigger ones even higher.  If there were issues at
> > 80% I expect I would have noticed them.  There were some performance
> > issues with full filesystems on kernels using space_cache=v1, but
> > space_cache=v2 went upstream 4 years ago, and other significant
> > performance problems a year before that.
> > 
> > The last few GB is a bit of a performance disaster and there are
> > some other gotchas, but that's an absolute number, not a percentage.
> > 
> > Never balance metadata.  That is a ticket to a dark and scary corner.
> > Make sure you don't do it, and that you don't accidentally install a
> > cron job that does it.
> > 
> > > 3) run scrub periodically and after a power failure ; better to use
> > > an uninterruptible power supply (this is true for all the RAID, even
> > > the MD one).
> > scrub also provides early warning of disk failure, and detects disks
> > that are silently corrupting your data.  It should be run not less than
> > once a month, though you can skip months where you've already run a
> > full-filesystem read for other reasons (e.g. replacing a failed disk).
> > 
> > > 4) I don't have any data to support this; but as occasional reader of
> > > this mailing list I have the feeling that combing BTRFS with LUCKS(or
> > > bcache) raises the likelihood of a problem.
> > I haven't seen that correlation.  All of my machines run at least one
> > btrfs on luks (dm-crypt).  The larger ones use lvmcache.  I've also run
> > bcache on test machines doing power-fail tests.
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
> > > > Any information appreciated.
> > > > 
> > > > 
> > > > Greetings from Germany,
> > > > 
> > > > Matt
> > > 
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > > 
> 
