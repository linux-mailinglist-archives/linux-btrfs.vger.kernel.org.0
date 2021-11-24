Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB245B396
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 05:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhKXEsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 23:48:01 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:35074 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240982AbhKXEqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 23:46:54 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 79298964E1; Tue, 23 Nov 2021 23:43:43 -0500 (EST)
Date:   Tue, 23 Nov 2021 23:43:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Matthew Dawson <matthew@mjdsystems.ca>
Cc:     Kai Krakow <hurikhan77+btrfs@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Help recovering filesystem (if possible)
Message-ID: <20211124044343.GF17148@hungrycats.org>
References: <2586108.vuYhMxLoTh@cwmtaff>
 <3321185.LZWGnKmheA@cwmtaff>
 <20211118210915.GC17148@hungrycats.org>
 <3593309.dWV9SEqChM@ring00>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3593309.dWV9SEqChM@ring00>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 11:42:05PM -0500, Matthew Dawson wrote:
> On Thursday, November 18, 2021 4:09:15 P.M. EST Zygo Blaxell wrote:
> > On Wed, Nov 17, 2021 at 09:57:40PM -0500, Matthew Dawson wrote:
> > > On Monday, November 15, 2021 5:46:43 A.M. EST Kai Krakow wrote:
> > > > Am Mo., 15. Nov. 2021 um 02:55 Uhr schrieb Matthew Dawson
> > > > 
> > > > <matthew@mjdsystems.ca>:
> > > > > I recently upgrade one of my machines to the 5.15.2 kernel.  on the
> > > > > first
> > > > > reboot, I had a kernel fault during the initialization (I didn't get
> > > > > to
> > > > > capture the printed stack trace, but I'm 99% sure it did not have
> > > > > BTRFS
> > > > > related calls).  I then rebooted the machine back to a 5.14 kernel,
> > > > > but
> > > > > the
> > > > > BCache (writeback) cache was corrupted.  I then force started the
> > > > > underlying disks, but now my BTRFS filesystem will no longer mount.  I
> > > > > realize there may be missing/corrupted data, but I would like to
> > > > > ideally
> > > > > get any data I can off the disks.
> > > > 
> > > > I had a similar issue lately where the system didn't reboot cleanly
> > > > (there's some issue in the BIOS or with the SSD firmware where it
> > > > would disconnect the SSD from SATA a few seconds after boot, forcing
> > > > bcache into detaching dirty caches).
> > > > 
> > > > Since you are seeing transaction IDs lacking behind expectations, I
> > > > think you've lost dirty writeback data from bcache. Do fix this in the
> > > > future, you should use bcache only in writearound or writethrough
> > > > mode.
> > > 
> > > Considering I started the bcache devices without the cache, I don't doubt
> > > I've lost writeback data and I have no doubts there will be issues.  At
> > > this point I'm just in data recovery, trying to get what I can.
> > 
> > The word "issues" is not adequate to describe the catastrophic damage
> > to metadata that occurs if the contents of a writeback cache are lost.
> > 
> > If writeback failure happens to only one btrfs device's cache, you
> > can recover with btrfs raid1 self-healing using intact copies stored
> > on working devices.  If it happens on multiple btrfs devices at once
> > (e.g. due to misconfiguration of bcache with more than one btrfs device
> > per pool or more than one bcache pool per SSD, or due to a kernel bug
> > that affects all bcache instances at once, or a firmware bug that affects
> > each SSD device the same way during a crash) then recovery isn't possible.
> > 
> > Writeback cache failures are _bad_, falling between "many thousands of
> > bad sectors" and "total disk failure" in terms of difficulty of recovery.
> > 
> > > Hopefully someone has a different idea?  I am posting here because I feel
> > > any luck is going to start using more dangerous options and those usually
> > > say to ask the mailing list first.
> > 
> > Your best option would be to get the caches running again, at least in
> > read-only mode.  It's not a good option, but all your other options depend
> > on having access to as many cached dirty pages as possible.  If all you
> > have is the backing devices, then now is the time to scrape what you
> > can from the drives with 'btrfs restore' then make use of your backups.
> At this point I think I'm stuck with just the backing devices (with GB of lost 
> dirty data on the cache).  And I'm primarily in data recovery, trying to get 
> whatever good data I can to help supplement the backed up data.

I don't use words like "catastrophic" casually.  Recovery typically
isn't possible with the backing disks after a writeback cache failure.

The writeback cache algorithm will prefer to keep the most critical
metadata in cache, while writing out-of-date metadata pages out to the
backing devices.  This process effectively wipes btrfs metadata off
the backing disks as the cache fills up, and puts it back as the cache
flushes out.  If a large dirty cache dies, it can leave nothing behind.

> As mentioned in my first email though, btrfs restore fails with the following 
> error message:
> # btrfs restore -l /dev/dm-2
> parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
> parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
> parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
> parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
> Ignoring transid failure
> Couldn't setup extent tree
> Couldn't setup device tree
> Could not open root, trying backup super
> warning, device 6 is missing
> warning, device 13 is missing
> warning, device 12 is missing
> warning, device 11 is missing
> warning, device 7 is missing
> warning, device 9 is missing
> warning, device 14 is missing
> bytenr mismatch, want=136920576753664, have=0
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> warning, device 6 is missing
> warning, device 13 is missing
> warning, device 12 is missing
> warning, device 11 is missing
> warning, device 7 is missing
> warning, device 9 is missing
> warning, device 14 is missing
> bytenr mismatch, want=136920576753664, have=0
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> When all devices are up and reported to the kernel.  I was looking for help to 
> try and move beyond these errors and get whatever may still be available.

The general btrfs recovery process is:

	1.  Restore device and chunk trees.  Without these, btrfs
	can't translate logical to physical block addresses, or even
	recognize its own devices, so you get "device is missing" errors.
	The above log shows that device and chunk tree data is now in the
	cache--or at least, not on the backing disks.	'btrfs rescue
	chunk-recover' may locate an older copy of this data by brute
	force search of the disk, if an older copy still exists.

	2.  Find subvol roots to read data.  'btrfs-find-root' will
	do a brute-force search of the disks to locate subvol roots,
	which you can pass to 'btrfs restore -l' to try to read files.
	Normally this produces hundreds of candidates and you'll have
	to try each one.  If you have an old snapshot (one that predates
	the last full cache flush, and no balance, device shrink, device
	remove, defrag, or dedupe operation has occurred since) then you
	might be able to read its entire tree.	Subvols that are modified
	recently will be unusable as they will be missing many or all
	of their pages (they will be in the cache, not the backing disks).

	3.  Verify the data you get back.  The csum tree is no longer
	usable, so you'll have no way to know if any data that you get
	from the filesystem is correct or garbage.  This is true even if
	you are reading from an old snapshot, as the csum tree is global
	to all subvols and will be modified (and moved into the cache)
	by any write to the filesystem.

In the logs above we see that you have missing pages in extent, chunk,
and device trees.  In a writeback cache setup, new versions of these
trees will be written to the cache, while the old versions are partially
or completely erased on the backing devices in the process of flushing
out previous dirty pages.  This pattern will repeat for subvol and csum
trees, leaving you with severely damaged or unusable metadata on the
backing disks as long as there are dirty pages in cache.

> If further recovery is impossible that's fine I'll wipe and start over, but I 
> rather try some risky things to get what I can before I do so.

I wouldn't say it's impossible in theory, but in practice it is a level
of effort comparable to unshredding a phone book--after someone has
grabbed a handful of the shredded paper and burned it.

High-risk interventions like 'check --repair --init-extent-tree' are
likely to have no effect in the best case (they'll give up due to lack
of usable metadata), and will destroy even more data in the worst case
(they'll try modifying the filesystem and overwrite some of the surviving
data).  They depend on having intact device and subvol trees to work,
so if you can't get those back, there's no need to try anything else.

In theory, if you can infer the file structure from the contents of the
files, you might be able to guess some of the missing metadata.  e.g. the
logical-to-physical translation in the device tree only provides about
16 bits of an extent byte address, so you could theoretically build
a tool which tries all 65536 most likely disk locations for a block
until it finds a plausible content match for a file, and use that tool
to reconstruct the device tree.  It might even be possible to automate
this using fragments of the csum tree (assuming the relevant parts of
the csum tree exist on the backing devices and not only in the cache).
This is only the theory--practical tools to do this kind of recovery
don't yet exist.

> > This is what you're up against:
> > 
> > btrfs writes metadata pages in a specific order to keep one complete
> > metadata tree on disk intact at all times.  This means that a specific
> > item of metadata (e.g. a directory or inode) is stored in different disk
> > blocks at different times.  Old physical disk blocks are frequently
> > recycled to store different data--not merely newer versions of the
> > same items, but completely unrelated items from different areas of
> > the filesystem.
> > 
> > Writeback caches write to backing devices in mostly sequential
> > LBA order for performance.  This is a defining characteristic of a
> > writeback cache--if the cache maintained the btrfs write order on the
> > backing device then we'd call it a "writethrough" or "writebehind"
> > cache instead.  Writeback caches don't need to respect write order for
> > individual blocks on the backing device as long as they can guarantee they
> > will eventually finish writing all of the data out to the backing device
> > (i.e. they restart writeback automatically after a reboot or crash).
> > 
> > During writeback, some metadata items will temporarily appear on the
> > backing device two or more times (a new version of the item was written,
> > but an old version of the item has not been overwritten yet and remains
> > on the backing device) while other items will be completely missing (the
> > old version of the item has been overwritten, but the new version of the
> > item has not been written yet, so no version of the item exists on the
> > backing device).  The backing disk will normally be missing significant
> > portions of the filesystem's metadata as long as there are dirty pages
> > in the cache device.
> > 
> > A recovery tool reading the backing device can't simply find an old
> > version of an inode's metadata, get a location for most of its data
> > blocks, and guess the locations of remaining blocks or truncate the file
> > (as tools like e2fsck do).  The missing btrfs metadata items are not
> > present at all on the backing device, because their old versions will be
> > erased from the backing device during writeback, while the new versions
> > haven't been written yet and will exist only in the cache device.
> > 
> > If the cache had a non-trivial number of dirty blocks when it failed, then
> > the above losses occur many thousands of times in the metadata trees, and
> > each lost page may contain metadata for hundreds of files.  The backing
> > disk will contain a severely damaged (some might say "destroyed")
> > filesystem.  Recovery tools would be able to delete incomplete objects
> > from the filesystem and make the filesystem mountable, but with
> > significant (if not total) data losses.
> 
> 
> 
> 
