Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0767C2F89E7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAPA0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 19:26:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44638 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPA0Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 19:26:24 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6E2679404BF; Fri, 15 Jan 2021 19:25:33 -0500 (EST)
Date:   Fri, 15 Jan 2021 19:25:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210116002533.GE31381@hungrycats.org>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20210108010511.GZ31381@hungrycats.org>
 <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
 <20210109212332.GB31381@hungrycats.org>
 <7a9baa1b-8426-751a-cd73-47ad246a946f@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a9baa1b-8426-751a-cd73-47ad246a946f@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 10, 2021 at 08:55:36PM +0100, Goffredo Baroncelli wrote:
> On 1/9/21 10:23 PM, Zygo Blaxell wrote:
> 
> > On a loaded test server, I observed 90th percentile fsync times
> > drop from 7 seconds without preferred_metadata to 0.7 seconds with
> > preferred_metadata when all the metadata is on the SSDs.  If some metadata
> > ever lands on a spinner, we go back to almost 7 seconds latency again
> > (it sometimes only gets up to 5 or 6 seconds, but it's still very bad).
> > We lost our performance gain, so our test resulted in failure.
> 
> Wow, this is a very interesting information: an use case where there is a
> 10x increase of speed !

It's a decrease of latency for the highest-latency fsyncs.  Not quite the
same thing as a 10% speed increase, or even an average latency decrease.
The gain comes from two places:

1.  There's much less variation in latency.  Seek times on spinners
are proportional to address distance, while seek times on SSD are not.
This is a 90th percentile observation, and reducing the variance a little
will reduce the 90th percentile a lot.

2.  Most of the latency on these servers comes from btrfs commit's giant
delayed_ref queue purges--hundreds of thousands of seek-heavy metadata
updates.  Those go _much_ faster on SSD than on HDD.  Previously, the
disks would fall behind write requests, so commits keep getting new data
to write all the time, making IO queues longer and longer, absorbing
all the free RAM that could smooth out spikes, and the transactions
would never finish until the writers stop providing new data.  With SSD
metadata it's harder to hit this case--the SSDs can keep up with the
metadata, and the HDDs can flush data faster with less seeking, so we
keep IO queues short and RAM available.  The system-wide gains are very
nonlinear.

> Could you share more detail about this server. With more data that supporting
> this patch, we can convince David to include it.

The one I pulled the numbers from has 3 spinning disks, 7200 RPM NAS or
enterprise drives by WD, HGST, and Seagate.  SSDs are 1TB WD Reds--we
initially tried them for caching, but they were burning out too quickly,
so we found a new home for them in preferred_metadata test boxes.

The workload is backups:  rsyncs, btrfs receives, snapshot creates and
deletes, and dedupe.  Occasionally some data is retrieved.  I excluded
data collected while scrubs are running.

> [...]
> > 
> > We could handle all these use cases with two bits:
> > 
> > 	bit 0:  0 = prefer data, 1 = prefer metadata
> > 	bit 1:  0 = allow other types, 1 = exclude other types
> > 
> > which gives 4 encoded values:
> > 
> > 	0 = prefer data, allow metadata (default)
> > 	1 = prefer metadata, allow data (same as v4 patch)
> > 	2 = prefer data, disallow metadata
> > 	3 = prefer metadata, disallow data
> 
> What you are suggesting allows the maximum flexibility. However I still
> fear that we are mixing two discussions that are unrelated except that
> the solution *may* be the same:

I don't fear that.  I state it explicitly.

> 1) the first discussion is related to the increasing of performance
> because we put the metadata in the faster disks and the data in
> the slower one.

The current btrfs allocator gives close to the worst possible performance
with a mix of drive speeds inversely proportional to size.  This is an
important problem with an easily implemented solution that has been
reinvented several times by different individuals over a period of
some years.  People ask about this on IRC every other week, and in the
mailing list at least once this month.  I've stopped waiting for it to
happen and started testing patches of my own.

If we are going to implement a more sophisticated solution in the future,
we can presume it will be able to emulate preferred_metadata and import
the legacy configuration data, so we can go ahead and implement these
capabilities now.

These future solutions are probably all going to try to create
chunks on useful subsets of drives, and allocate useful subsets of
IO to the available chunks, because any other structure will require
pretty deep changes to the way btrfs works that will not plausibly
be accepted (e.g. not using chunks as allocation units any more).
The likely differences between one proposal and another are the number
of chunk types supported and the number of subsets of IO supported.
"Put metadata on device X, put data on device Y" should be a trivial
capability of any future implementation worth considering.

One source of pushback against the current patch set I would expect is
the use of btrfs_dev_item::type to store the type field.  That field was
probably intended for a different purpose, and space in btrfs_dev_item
is a scarce resource.  We don't intend to come up with a general device
type list here, or sort out when to use a NVME device and when to use
a SSD when both are present--currently we are interested in manually
directing the allocator, not enumerating all possible device information
for the allocator to make good decisions itself (and even if we were, we'd
want to be able to override those anyway).  Maybe the preferred_metadata
"type" can be moved to a separate PERSISTENT_ITEM key (see DEV_STATS_KEY)
with a preferred_metadata objectid.  This will make extensions easier
later on (there are still 2^64-ish objectid values available after this,
so we can have multiple versions of the configuration).

> 2) the second discussion is how avoid that the chunk data consumes space of
> the metadata.

This is an important problem too, but a much larger and more general
one.  It's also one that is relatively well understood and managed now,
so there is less urgent need to fix it.  Also, unlike the performance
issue, there seems to be a large number of ways to change this for the
worse, or make changes which will make more sophisticated solutions
unnecessarily complex.

My strong opinion about this is that I don't have a strong opinion.
There are other problems to solve first, let's work on those.

> Regarding 2), I think that a more generic approach is something like:
> - don't allocate *data* chunk if the chunk free space is less than <X>
> Where <X> is the maximum size of a metadata chunk (IIRC 1GB ?), eventually
> multiplied by 2x or 3x.

That's a constant value, orders of magnitude too big for small
filesystems and orders of magnitude too small for big filesystems.
e.g. on a filesystem with 150GB of metadata, we try to keep at least
75GB unused in allocated metadata chunks or in unallocated space.  On a
filesystem with 50GB of total space, we'd probably never need more than
4GB of metadata--or less.

We need metadata space for at least the following:

	- operations that don't throttle properly (e.g. snapshot delete,
	balance) - worst cases in the field are about 10% of the metadata
	size.  These are bugs and will presumably be fixed one day.

	- scrub (locks up to one metadata chunk per device, removing that
	chunk temporarily from usable space).  Seems to work as designed,
	but maybe someone someday will decide it's a bug and fix it?

	- global reserve (capped at 0.5GB) - by design.  In theory we
	don't need anything else--we should be able to gracefully throw
	ENOSPC any time this runs out, without being forced read-only.

	- snapshot subvol metadata page unsharing and big reflink copies.
	We can plan for worst case subvol unsharing easily enough, but
	big reflink copy is a user action we cannot predict.  The value is
	determined by application workload, so it should be configurable.

There are some constant terms (1GB per disk, 0.5GB reserve) and some
proportional terms (multiple of existing metadata size) and some
configurable terms in the equation (user says she needs 40GB on top of
what there is now, we don't know why but assume she knows what she's
doing) for determining how much metadata we need.  And this maybe isn't
even an exhaustive list.  But it shows the size of the problem.

> Instead the metadata allocation policy is still constrained only to have
> enough space. As further step (to allow a metadata balance command to success), we
> could constraint the metadata allocation policy to allocate up to the half of the
> available space ( or 1 GB, whichever is smaller)

That's way more complicated than what we do now.  Now, we never balance
metadata, occasionally balance a few chunks of data, and btrfs usually
ends up with the right mix of block groups by itself over time.

During RAID reshapes one must plan for where metadata is going to
live after all the devices are added and removed.  Sometimes we use
metadata_ratio after these operations to bring the metadata chunks back
up again.

I do like the "never allocate the last N GB except during balance" idea.
Currently we do something similar with fi resize--after mkfs, we resize
the btrfs devices about 1% smaller than the physical device, to provide
emergency free space.  We've only ever needed it once, to recover a
filesystem where someone accidentally ran a metadata balance a few months
earlier, and the ratios got all, for want of a better word, unbalanced.

Arguably this 2) stuff is all fine and we don't need to change anything.
Users have all the tools they need, so we might only need need better
manuals and maybe more automation for common cases.

> Regarding 1) I prefer to leave the patch as simple as possible to increase
> the likelihood of an inclusion. Eventually we can put further constraint after.

I'd prefer...otherwise?  I've already had to implement the strict mode to
make simple test cases work.  The requirement seems uncontroversial to me.

I set up one test server last week and tried to do a metadata balance
with non-strict preferred metadata.  Before metadata balance could
relocate any metadata to the SSDs, the SSDs were all filled with data.
I had to implement strict preference before preferred_metadata would
work at all on that server.

At the moment I'm running this (written before my earlier email, it doesn't
consider the possibility of non-strict preferred metadata):

@@ -4976,15 +5030,47 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
                devices_info[ndevs].max_avail = max_avail;
                devices_info[ndevs].total_avail = total_avail;
                devices_info[ndevs].dev = device;
+               devices_info[ndevs].preferred_metadata = !!(device->type &
+                       BTRFS_DEV_PREFERRED_METADATA);
+               if (devices_info[ndevs].preferred_metadata)
+                       nr_preferred_metadata++;
                ++ndevs;
        }
        ctl->ndevs = ndevs;

+       BUG_ON(nr_preferred_metadata > ndevs);
        /*
         * now sort the devices by hole size / available space
         */
-       sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-            btrfs_cmp_device_info, NULL);
+       if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+           (ctl->type & BTRFS_BLOCK_GROUP_METADATA)
+           ) {
+               /* mixed bg or PREFERRED_METADATA not set */
+               sort(devices_info, ctl->ndevs, sizeof(struct btrfs_device_info),
+                            btrfs_cmp_device_info, NULL);
+       } else {
+               /*
+                * If PREFERRED_METADATA is set, sort the device
+                * considering also the kind (preferred_metadata or
+                * not). Limit the availables devices to the ones of the
+                * requested kind, to prevent metadata appearing on a
+                * non-preferred device, or data appearing on a preferred
+                * device.
+                */
+               if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+                       int nr_data = ctl->ndevs - nr_preferred_metadata;
+                       sort(devices_info, ctl->ndevs,
+                                    sizeof(struct btrfs_device_info),
+                                    btrfs_cmp_device_info_data, NULL);
+                       ctl->ndevs = nr_data;
+               } else { /* non data -> metadata and system */
+                       sort(devices_info, ctl->ndevs,
+                                    sizeof(struct btrfs_device_info),
+                                    btrfs_cmp_device_info_metadata, NULL);
+                       if (nr_preferred_metadata)
+                               ctl->ndevs = nr_preferred_metadata;
+               }
+       }

        return 0;
 }

and it works OK, except df misreports free space because it's counting
unallocated space on metadata drives as space available for data.
I'll need to fix that eventually, though the error is less than 0.5% on
the filesystems where preferred_metadata is most important--and far less
than the errors that already happen during btrfs raid conversions anyway.

> Anyway I am rebasing the patch to the latest kernel. Let me to check how complex
> could be implement you algorithm (the two bits one).

> BR
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
