Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74ED2F96C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 01:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbhARAqG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 17 Jan 2021 19:46:06 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40496 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhARAqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 19:46:04 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0323D943DE3; Sun, 17 Jan 2021 19:45:19 -0500 (EST)
Date:   Sun, 17 Jan 2021 19:45:19 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Cedric.dewijs@eclipso.eu
Cc:     andrea.gelmini@gmail.com, linux-btrfs@vger.kernel.org
Subject: Re: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to
 prioritize the SSD?
Message-ID: <20210118004519.GL31381@hungrycats.org>
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com>
 <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
 <CAK-xaQbQPSS7=cH1qmb9S51CL34VRfyE_=eNwb-GhSL1b8Yz2g@mail.gmail.com>
 <20210109214032.GC31381@hungrycats.org>
 <CAK-xaQZ=ZNqkruDSjNdprDfj5nAh5TdCpT+sv0nB6LqCRu7dmQ@mail.gmail.com>
 <20210116010438.GG31381@hungrycats.org>
 <9ba7de732a8b69c39922dad268a1e226@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9ba7de732a8b69c39922dad268a1e226@mail.eclipso.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 04:27:29PM +0100,   wrote:
> 
> --- Ursprüngliche Nachricht ---
> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Datum: 16.01.2021 02:04:38
> An: Andrea Gelmini <andrea.gelmini@gmail.com>
> Betreff: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize  the SSD?
> 
> This tells me everything I need to know about mdadm. It can only save
> my data in case both drive originally had correct data, and one of the
> drives completely disappears. A mdadm raid-1 (mirror) array ironically
> increases the likelihood of data corruption. If one drive has a 1%
> change of corrupting the data, 2 of those drives in mdadm raid 1 have
> a 2% chance of corrupting the data, and 100 of these drives in raid 1
> will 100% corrupt the data. (This is a bit of an oversimplification,
> and statistically not entirely sound, but it gets my point across). For
> me this defeats the purpose of a raid system, as raid should increase
> the redundancy and resilience.

It influences architecture and purchasing too.  Say you want to build
two filesystems, and you have 2 instances of 2 device models A and B
with different firmware, and you are worried about firmware bugs.

The mdadm way is:  host1 is modelA, modelA.  host2 is modelB, modelB.
This way, if modelA has a firmware bug, host1's filesystem gets corrupted,
but host2 is not affected, so you can restore backups from host2 back
to host1 after a failure.  Short of detailed forensic investigation,
it's not easy to tell which model is failing, so you just keep buying
both models and never combining them into an array in the same host.

The btrfs way is:  host1 is modelA, modelB.  host2 is modelA, modelB.
This way, if modelA has a firmware bug, btrfs corrects modelA using
modelB's data, so you don't need the backups.  You also know whether
modelA or modelB has the bad firmware, because btrfs identifies the bad
drive, and you can confirm the bug if both host1 and host2 are affected,
so you can stop buying that model until the vendor fixes it.

> Would it be possible to add a checksum to the data in mdadm in much
> the same way btrfs is doing that, so it can also detect and even repair
> corruption on the block level?

dm-integrity would provide the csum error detection that mdadm needs to
be able to recover from bitrot (i.e. use dm-integrity devices as
mdadm component devices).  I wouldn't expect it to perform too well
on spinning disks.

> I was trying to figure out if my data could survive if one of the drives
> (partially)failed. I only know of two ways to simulate this: physically
> disconnecting the drive, or dd-ing random data to it. I didn't state
> it in my original question, but I wanted to first poison one drive,
> then scrub the data, and then poison the next drive, and scrub again,
> until all drives has been poisoned and scrubbed. I have tested this
> with 2 set's of a backing drive and a writeback  SSD cache. No matter
> which drive was poisoned, all the data survived although reconstructing
> the data was about 30x slower than reading correct data.

> My rule of thumb is "never run adadm". I don't see a use case where
> it increases the longevity of my data.

There are still plenty of use cases for mdadm.  btrfs can't do everything,
e.g. mirrors on more than 4 disks, or split-failure-domain raid10, or
just a really convenient way to copy one disk to another from time to
time without taking it offline.

For nodatasum files, mdadm and btrfs have equivalent data integrity,
maybe a little worse on btrfs since btrfs lacks any way for the admin to
manually indicate which device has correct data (at least on mdadm there
are various ways to force a resync from one chosen drive to the other).
On the other hand, using nodatasum implies you don't care about data
integrity issues for that specific file, and btrfs still maintains
better integrity than mdadm for the rest of the filesystem.

> I was looking for a way to give a the drives of a btrfs filesystem a
> write cache, in such a way that a failure of a single drive could not
> result in data loss. As bcache does not and will not support multiple
> redundant ssd's as write cache [1], my plan was to put 2 identical
> ssd's in mdadm raid 1, as host for a bcache writecack cache for all
> the drives of the btrfs filesytem. See the figure below:
> +-----------------------------------------------------------+
> |          btrfs raid 1 (2 copies) /mnt                     |
> +--------------+--------------+--------------+--------------+
> | /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 |
> +--------------+--------------+--------------+--------------+
> | Mdadm Raid 1 mirrored Writeback Cache (SSD)               |
> | /dev/md/name (cointaining /dev/sda3 and /dev/sda4)        |
> +--------------+--------------+--------------+--------------+
> | Data         | Data         | Data         | Data         |
> | /dev/sda8    | /dev/sda9    | /dev/sda10   | /dev/sda11   |
> +--------------+--------------+--------------+--------------+
> This will not protect my data if one of the SSD's starts to return
> random data, as mdadm can't see who of the two SSD's is correct. This
> will also defeat the redundancy of btrfs, as all copies of the data
> that btrfs sees are coming from the ssd pair.
> [1] https://lore.kernel.org/linux-bcache/e03dd593-14cb-b4a0-d68a-bd9b4fb8bd20@suse.de/T/#t
> 
> The only way I've come up with is to give each hard drive in the btrfs
> array it's own writeback bcache, but that requires double the amount
> of drives.

If it's a small enough number of disks, you could bind pairs of spinning
disks together into mdadm linear or single (see?  mdadm is still useful):

  btrfs dev 1 -> cache1 -> md1 linear -> spinner1, spinner2

  btrfs dev 2 -> cache2 -> md2 linear -> spinner3, spinner4

If one of the spinners fails, you swap it out and rebuild a new mdadm
array on the remaining old disk and the new disk, then build a new
cache device on top.  If the cache dies you build a new cache device.
Then you mount btrfs degraded without the failed device, and use replace
to repopulate it with the replacement device(s), same as a normal disk
failure.

If just the cache fails, you can maybe get away with dropping the
cache and running a btrfs scrub directly on the backing mdadm device,
as opposed to a full btrfs replace.  The missing blocks from the dead
cache will just look like data corruption and btrfs will replace them.

This changes the recovery time and failure probabilities compared to a
4xSSD 4xHDD layout, but not very much.  I wouldn't try this with 20 disks,
but with only 4 disks it's probably still OK as long as you don't have
a model that likes to fail all at the same time.  You'd want to scrub
that array regularly to detect failures as early as possible.

Both dm-cache and bcache will try to bypass the cache for big sequential
reads, so the scrub will mostly touch the backing disks.  There are some
gaps in the scrub coverage (any scrub reads that are serviced by the
cache will not reflect the backing disk state, so bitrot in the backing
disk might not be observed until the cache blocks are evicted) but btrfs
raid1 handles those like any other intermittently unreliable disk.

> I am misusing consumer drives in my NAS. Most of the hard drives and
> SSD's have been given to me, and are medium old to very old. 

OK, "very old" might be too risky to batch them up 2 disks at a time.
After a certain age, just moving a drive to a different slot in the
chassis can break it.

> That's
> why I am trying to build a system that can survive a single drive
> failure. That's also the reason why I build 2 NAS boxes, my primary
> NAS syncs to my slave nas once per day).

A sound plan.  Host RAM sometimes flips bits, and there can be kernel
bugs.  Having your data on two separate physical hosts provides isolation
for that kind of failure.

> Thanks for confirming sometimes drives do silently corrupt data. I
> have not yet seen this happen "in the wild".

Cheap SSDs are notorious for this (it's pretty much how they indicate
they are failing, you get btrfs csum errors while drive self-tests pass),
but we've seen one or two name-brand devices do it too.

Any drive will do it if it gets too hot and doesn't throttle itself.
