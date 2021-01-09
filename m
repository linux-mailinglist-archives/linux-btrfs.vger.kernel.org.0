Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31462F03CA
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jan 2021 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAIVYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jan 2021 16:24:14 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41780 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbhAIVYO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jan 2021 16:24:14 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id CBA7993136D; Sat,  9 Jan 2021 16:23:32 -0500 (EST)
Date:   Sat, 9 Jan 2021 16:23:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210109212332.GB31381@hungrycats.org>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20210108010511.GZ31381@hungrycats.org>
 <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 08, 2021 at 06:30:49PM +0100, Goffredo Baroncelli wrote:
> On 1/8/21 2:05 AM, Zygo Blaxell wrote:
> > On Thu, May 28, 2020 at 08:34:47PM +0200, Goffredo Baroncelli wrote:
> > > 
> [...]
> > 
> > I've been testing these patches for a while now.  They enable an
> > interesting use case that can't otherwise be done safely, sanely or
> > cheaply with btrfs.
> 
> Thanks Zygo for this feedback. As usual you are source of very interesting considerations.
> > 
> > Normally if we have an array of, say, 10 spinning disks, and we want to
> > implement a writeback cache layer with SSD, we would need 10 distinct SSD
> > devices to avoid reducing btrfs's ability to recover from drive failures.
> > The writeback cache will be modified on both reads and writes, data and
> > metadata, so we need high endurance SSDs if we want them to make it to
> > the end of their warranty.  The SSD firmware has to not have crippling
> > performance bugs while under heavy write load, which means we are now
> > restricted to an expensive subset of high endurance SSDs targeted at
> > the enterprise/NAS/video production markets...and we need 10 of them!
> > 
> > NVME has fairly draconian restrictions on drive count, and getting
> > anything close to 10 of them into a btrfs filesystem can be an expensive
> > challenge.  (I'm not counting solutions that use USB-to-NVME bridges
> > because those don't count as "sane" or "safe").
> > 
> > We can share the cache between disks, but not safely in writeback mode,
> > because a failure in one SSD could affect multiple logical btrfs disks.
> > Strictly speaking we can't do it safely in any cache mode, but at least
> > with a writethrough cache we can recover the btrfs by throwing the SSDs
> > away.
> 
> I will replay in a separate thread, because I found your consideration very
> interesting but OT.
> 
> > 
> > In the current btrfs raid5 and dm-cache implementations, a scrub through a
> > SSD/HDD cache pair triggers an _astronomical_ number of SSD cache writes
> > (enough to burn through a low-end SSD's TBW in a weekend).  That can
> > presumably be fixed one day, but it's definitely unusable today.
> 
> Again, this is another point to discuss...
> 
> > 
> > If we have only 2 NVME drives, with this patch, we can put them to work
> > storing metadata, leave the data on the spinning rust, and keep all
> > the btrfs self-repair features working, and get most of the performance
> > gain of SSD caching at significantly lower cost.  The write loads are
> > reasonable (metadata only, no data, no reads) so we don't need a high
> > endurance SSD.  With raid1/10/c3/c4 redundancy, btrfs can fix silent
> > metadata corruption, so we can even use cheap SSDs as long as they
> > don't hang when they fail.  We can use btrfs raid5/6 for data since
> > preferred_metadata avoids the bugs that kill the SSD when we run a scrub.
> > 
> > Now all we have to do is keep porting these patches to new kernels until
> > some equivalent feature lands in mainline.  :-P
> 
> Ok, this would be doable.
> > 
> > I do have some comments about these particular patches:
> > 
> > I dropped the "preferred_metadata" mount option very early in testing.
> > Apart from the merge conflicts with later kernels, the option is
> > redundant, since we could just as easily change all the drive type
> > properties back to 0 to get the same effect.  Adding an incompatible
> > mount option (and potentially removing it again after a failed test)
> > was a comparatively onerous requirement.
> 
> Could you clarify this point ? I understood that you removed some pieces
> of the patch #4, but the other parts are still needed.

I just removed the preferred_metadata mount option, and removed the check
for preferred_metadata in the if statements (i.e. the behavior is as if
preferred_metadata was always set in the mount options).

> Anyway I have some doubt about removing entirely this options.
> The options allows the new policy. The disk property instead marks the
> disk as eligible as preferred storage for metadata. Are two concept
> very different and I prefer to take them separates.
> 
> The behavior that you suggested is something like:
> - if a "preferred metadata" properties is set on any disks, the
> "preferred metadata" behavior is enabled.

Yes, that way we can turn it on once with btrfs prop set just after mkfs,
and not have to make changes to userspace on top to change the mount
options (which would require spinning a whole different image just for
this experiment).  In this way it behaves more like btrfstune or raid
profile settings.

I could have used mount -oremount, but there was a merge conflict in
that part of the code already, so I already had to rewrite those parts
of the patch.  I saw no need for the mount option to be there, so
I just resolved all the conflicts by keeping the code without it.

> My main concern is that setting this disk flag is not atomic, when
> the mount option is. Would help the maintenance of the filesystem
> when the user are replacing (dropping) the disks ?

We would have to adjust the check for minimum number of disks in the
RAID profile to take disks that refuse to accept data/metadata into
account (unless that check is already calling into the patched code?).

Also we should disallow setting all of the devices data-only or
metadata-only at once--though this isn't strictly necessary.  It would
work for a time, as long as no new chunk allocations occur, and then
get a normal ENOSPC when the next chunk allocation is attempted.
The user can then say "oh right I need to enable some data drives" and
fix it, and the filesystem would be effectively full in the interim.

Failing disks behave the same way as before--an offline raid1 mirror is
offline whether it prefers metadata or not.

> Anyway I am open to ear other opinions.
> 
> > 
> > The fallback to the other allocation mode when all disks of one type
> > are full is not always a feature.  When an array gets full, sometimes
> > data gets on SSDs, or metadata gets on spinners, and we quickly lose
> > the benefit of separating them.  Balances in either direction to fix
> > this after it happens are time-consuming and waste SSD lifetime TBW.
> > 
> > I'd like an easy way to make the preference strict, i.e. if there are
> > two types of disks in the filesystem, and one type fills up, and we're
> > not in a weird state like degraded mode or deleting the last drive of
> > one type, then go directly to ENOSPC.  That requires a more complex
> > patch since we'd have to change the way free space is calculated for
> > 'df' to exclude the metadata devices, and track whether there are two
> > types of device present or just one.
> 
> I fear another issue: what happens when you filled the metadata disks ?

Exactly the same thing that happens now when you run out of unallocated
space for the metadata raid profile, or configure an unsatisfiable set of
disk sizes and raid profiles.  This situation can already occur on every
btrfs filesystem under some sequence of allocations and deallocations.

You can replicate the behavior of strict preferred_metadata by doing
btrfs fi resize operations at exactly the right times.  Nothing new here.

> Does BTRFS allow to update the "preferred metadata" properties on a
> filled disks ? I would say yes, but I am not sure what happens when
> BTRFS force the filesystem RO.

No, on btrfs you must always avoid running out of metadata space.
It is too late to do anything after you have run out, other than to roll
back to the end of the previous transaction (i.e. umount and mount the
filesystem again).  That is why there is a global reserve to force at
least half a GB free metadata space, and code sprinkled all over the
kernel that tries, mostly successfully, to avoid filling it.  On our
filesystems we try to ensure that metadata has room to expand by 50%
at all times (rounded up to the next GB on small filesystems).

There are current bugs where you can get into a "groundhog day" situation:
btrfs's mount kernel thread starts a transaction that fails with ENOSPC
in metadata.  The transaction isn't completed, so as far as the filesystem
on disk is concerned, it never happened.  The next mount does exactly
the same thing in every detail.  Repeat until you upgrade the kernel
with a bug fix (or downgrade to avoid a regression).  _Maybe_ you can
get a lvextend/btrfs fi resize or dev add into the same transaction
and get out of the loop that way, but I had a case not too long ago
where I was forced to roll back to 4.19 to complete a snapshot delete
(keep those old LTS kernels handy, you might need one!).

I hadn't noticed this before, but strict preferred metadata provides us
a novel way to avoid the risk of running out of metadata space on btrfs.
We effectively reserve all of the space on the SSDs for metadata, because
strict preferred metadata won't allow any data to be allocated on the
same disks.  Non-strict preferred metadata is _more_ at risk of running
out of metadata space, as data block groups are not prevented from using
the reserved space on SSDs.

> Frankly speaking, I think that a slower filesystem is far better than a
> locked one. 

No, slower is a _failure mode_ in our use case.  We are competing
with slower, and fail if we do not win.

We already have all-spinning arrays that are cheap, all-SSD arrays that
are fast, and arrays of SSD/spinner pairs that are expensive.  We are
considering spending additional money on SSDs and host interfaces to
improve the performance of the all-spinners, but want to spend less money
than the all-SSD or SSD/spinner pair configurations.  We expect strictly
improved performance for any money we spend.  We can haggle over whether
the improvement was worth the cost, but clearly that's not the case if
the improvement is zero.  Equal performance is not acceptable: if there's
no gain, then we keep our money and go back to the cheaper option.

On a loaded test server, I observed 90th percentile fsync times
drop from 7 seconds without preferred_metadata to 0.7 seconds with
preferred_metadata when all the metadata is on the SSDs.  If some metadata
ever lands on a spinner, we go back to almost 7 seconds latency again
(it sometimes only gets up to 5 or 6 seconds, but it's still very bad).
We lost our performance gain, so our test resulted in failure.

If we try to fix this, by running a metadata balance to get the metadata
off of the spinner, fsync's 90th percentile latency goes up past 600
seconds (i.e.  10 minutes) during the balance, and the balance runs for
6 to 10 hours.  The fileserver is effectively unusuable for at least
one working day.  There's no way we can spin that event to our users
as anything less than a service outage.

If data lands on a SSD, we are at greater risk of running out of
metadata space.  We normally (without preferred_metadata) do a lot of
work to force btrfs to maintain spare metadata space--in extreme cases,
with the metadata_ratio mount option--and run daily data balances
to maintain reserves of unallocated space for metadata to grow into.
If we can completely disallow data allocations on SSD, we get an easily
manageable, fast, huge chunk of unallocated space that only metadata can
use, without all the balancing iops and continuous metadata free space
monitoring.  We can control the size of this reserved space by choosing
the SSD size.  This is a valuable capability all by itself.  If we have
non-strict preferred_metadata then we get none of these benefits.

The extra write load for data changes the pricing model for the SSDs.
Failure rates go up (to 100% 5-year failure rate on some SSD models).
Performance goes down (to significantly slower than spinners on some
SSD models).  If we push the price up by over 40%, it's cheaper to buy
high-endurance SSDs instead.  This isn't a failure--we still need fewer
SSDs for preferred_metadata than we would need for dm-cache or bcache,
so we're still winning--but we could easily do better, and that's not
a good story to take into is-it-worth-the-cost discussions.

In the cases I tested, we have about 100:1 SSD to spinner capacity ratio
(e.g. 6x8TB in spinners with 2x512GB in SSD, or 3x12TB in spinners
with 2x128GB in SSD).  Only a trivial amount of data space is lost if
we do not allow data allocation on SSD, and we were doing a lot of
work to avoid ever using that data space before preferred_metadata.
As the array gets bigger, we swap out the spinners for bigger drives,
and we can swap in bigger SSDs at the same time to maintain the ratio.

Here are two other scenarios:

1.  The smallest available SSDs are more than 2% of the total spinner
size.  In this case, we would never fill the SSD with metadata, so we
could allow some data to be placed on the SSD in order to make use of the
space that would otherwise be unused.  We must forbid metadata allocation
on the spinner to keep the performance gain.

We have to monitor unallocated space on the SSD and watch out for data
chunks stealing all the space we need for metadata like we do on any
other btrfs filesystem; however, with data preferentially allocated
on the spinner, in most cases all the necessary metadata chunk
allocations will be completed before the last unallocated space on
the SSD becomes a data chunk.  We don't need to monitor the spinner
because its metadata usage will always be zero.

2.  We have one small fast SSD and one large slow spinner, and we already
paid for them, so we cannot reduce cost by omitting one of the devices
(this is a very popular use case on #btrfs, it's common to fall into
this situation with laptops).  This is a worst-case setup for the stock
btrfs allocator.  Even random allocation would be about 450% better.
In this situation, there is no hardware cost penalty for having
performance equal to the stock btrfs allocator, so we no longer have
to have a performance win--tying is good enough.  With this competitor,
we could only lose the performance race intentionally.

We still have to monitor unallocated space and watch out for data chunks
stealing all the space we need for metadata, but it's no different than
stock btrfs (the order in which devices are filled is different, but
all the devices are still filled).

We could handle all these use cases with two bits:

	bit 0:  0 = prefer data, 1 = prefer metadata
	bit 1:  0 = allow other types, 1 = exclude other types

which gives 4 encoded values:

	0 = prefer data, allow metadata (default)
	1 = prefer metadata, allow data (same as v4 patch)
	2 = prefer data, disallow metadata
	3 = prefer metadata, disallow data

In the allocator, first try allocation using all devices where
data/metadata matches in bit 0, and bit 2 is set.  If that fails,
try again with all those devices, plus devices where bit 2 is clear.
If that fails too, go to ENOSPC.

'df' reports bavail counting unallocated space only when bit 0 is 0
(data preferred) or bit 1 is 0 (all types allowed) in the device type.

> A better way would be add a warning to btrfs-progs which
> say: "WARNING: your preferred metadata disks are filled !!!"

This is something that already happens on every btrfs, so it is not
in any way specific to preferred_metadata.  I'd rather minimize new
warning messages, especially messages where it's so difficult to
determine the condition accurately.

The best way I have found to predict metadata ENOSPC is to monitor
filesystem usage stats over time and watch for indications the trend
line will cross zero free space soon.  Without the trend data (or
very deep metadata analysis to reconstruct the trend data), we can't
know how fast metadata space is growing (or steady, or even shrinking).
Every workload consumes and releases metadata space at a different rate,
so one server's 1% free space is a boring non-event while another server's
1% is an imminent critical emergency.

The calculations for monitoring tools will be a little different with
strict preferred metadata.

> > > Below I collected some data to highlight the performance increment.
> > > 
> > > Test setup:
> > > I performed as test a "dist-upgrade" of a Debian from stretch to buster.
> > > The test consisted in an image of a Debian stretch[1]  with the packages
> > > needed under /var/cache/apt/archives/ (so no networking was involved).
> > > For each test I formatted the filesystem from scratch, un-tar-red the
> > > image and the ran "apt-get dist-upgrade" [2]. For each disk(s)/filesystem
> > > combination I measured the time of apt dist-upgrade with and
> > > without the flag "force-unsafe-io" which reduce the using of sync(2) and
> > > flush(2). The ssd was 20GB big, the hdd was 230GB big,
> > > 
> > > I considered the following scenarios:
> > > - btrfs over ssd
> > > - btrfs over ssd + hdd with my patch enabled
> > > - btrfs over bcache over hdd+ssd
> > > - btrfs over hdd (very, very slow....)
> > > - ext4 over ssd
> > > - ext4 over hdd
> > > 
> > > The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was used
> > > as cache/buff.
> > > 
> > > Data analysis:
> > > 
> > > Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
> > > apt on a rotational was a dramatic experience. And IMHO  this should be replaced
> > > by using the btrfs snapshot capabilities. But this is another (not easy) story.
> > > 
> > > Unsurprising bcache performs better than my patch. But this is an expected
> > > result because it can cache also the data chunk (the read can goes directly to
> > > the ssd). bcache perform about +60% slower when there are a lot of sync/flush
> > > and only +20% in the other case.
> > > 
> > > Regarding the test with force-unsafe-io (fewer sync/flush), my patch reduce the
> > > time from +256% to +113%  than the hdd-only . Which I consider a good
> > > results considering how small is the patch.
> > > 
> > > 
> > > Raw data:
> > > The data below is the "real" time (as return by the time command) consumed by
> > > apt
> > > 
> > > 
> > > Test description         real (mmm:ss)	Delta %
> > > --------------------     -------------  -------
> > > btrfs hdd w/sync	   142:38	+533%
> > > btrfs ssd+hdd w/sync        81:04	+260%
> > > ext4 hdd w/sync	            52:39	+134%
> > > btrfs bcache w/sync	    35:59	 +60%
> > > btrfs ssd w/sync	    22:31	reference
> > > ext4 ssd w/sync	            12:19	 -45%
> > > 
> > > 
> > > 
> > > Test description         real (mmm:ss)	Delta %
> > > --------------------     -------------  -------
> > > btrfs hdd	             56:2	+256%
> > > ext4 hdd	            51:32	+228%
> > > btrfs ssd+hdd	            33:30	+113%
> > > btrfs bcache	            18:57	 +20%
> > > btrfs ssd	            15:44	reference
> > > ext4 ssd	            11:49	 -25%
> > > 
> > > 
> > > [1] I created the image, using "debootrap stretch", then I installed a set
> > > of packages using the commands:
> > > 
> > >    # debootstrap stretch test/
> > >    # chroot test/
> > >    # mount -t proc proc proc
> > >    # mount -t sysfs sys sys
> > >    # apt --option=Dpkg::Options::=--force-confold \
> > >          --option=Dpkg::options::=--force-unsafe-io \
> > > 	install mate-desktop-environment* xserver-xorg vim \
> > >          task-kde-desktop task-gnome-desktop
> > > 
> > > Then updated the release from stretch to buster changing the file /etc/apt/source.list
> > > Then I download the packages for the dist upgrade:
> > > 
> > >    # apt-get update
> > >    # apt-get --download-only dist-upgrade
> > > 
> > > Then I create a tar of this image.
> > > Before the dist upgrading the space used was about 7GB of space with 2281
> > > packages. After the dist-upgrade, the space used was 9GB with 2870 packages.
> > > The upgrade installed/updated about 2251 packages.
> > > 
> > > 
> > > [2] The command was a bit more complex, to avoid an interactive session
> > > 
> > >    # mkfs.btrfs -m single -d single /dev/sdX
> > >    # mount /dev/sdX test/
> > >    # cd test
> > >    # time tar xzf ../image.tgz
> > >    # chroot .
> > >    # mount -t proc proc proc
> > >    # mount -t sysfs sys sys
> > >    # export DEBIAN_FRONTEND=noninteractive
> > >    # time apt-get -y --option=Dpkg::Options::=--force-confold \
> > > 	--option=Dpkg::options::=--force-unsafe-io dist-upgrade
> > > 
> > > 
> > > BR
> > > G.Baroncelli
> > > 
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > > 
> > > 
> > > 
> > > 
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
