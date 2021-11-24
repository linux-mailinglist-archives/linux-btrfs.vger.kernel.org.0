Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26DE45B3C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 06:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhKXFO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 00:14:58 -0500
Received: from scadrial.mjdsystems.ca ([192.99.73.14]:44149 "EHLO
        scadrial.mjdsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhKXFO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 00:14:58 -0500
Received: from ring00.localnet (unknown [IPv6:2607:f2c0:ed80:400:92c8:d190:7af1:d6ea])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id 6B057823FD58;
        Wed, 24 Nov 2021 00:11:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed; d=mjdsystems.ca;
        s=202010; t=1637730707;
        bh=qBWCcjJgwAmGWb1s4dEZO8OWRaUjCci/BtniUPvbE8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyzE8855PEtJm4IKcZNdvowF8Oc79efCePH55tRu9mUAeGlg5s6AlpB1eiDN2kIny
         zP9+ybeSxewTol0RiZhosyCGyanDLjo6N01ogcZJTzq8rYOl60VUZ8UMEA3Zmojq9R
         G5aRqDfCu/sPC5als1EsoK2VzaGf3/FVTvdLjI107jFfcVuAZx85vsPmmITC+7G//j
         r5BlqUZJ2s0yXJHaP/It36UqSZjgvGIkRAQgde7/wNud6XxMhW66PYoDC9Sorwp/l3
         UWbzaiNalqYi6hJgG48yUE6Ybct9mjNRyzL70AAFH68oUc1Rh9dsBVC4rn+1/ph++9
         R58un8GO8rP3lk5edaPXqHmPK+w7qU/RkebdsdBafb6ytOKA9ZHW3+5GEJ+gpxL9UN
         G5IfGv/56gRqVf5dfatSn80hN4+M63nCnjNcp1CMP63SfiKrQP/XQlsnJU9sDn32wd
         0JI45xLWdmKHJl5sxv3byWzIyv53g0QvzvvNdDdYWmyVCb5t7JhlvgjgP1xzt9VVW2
         73/3kGlovn5+ShF4LvvX+Piv5ZYcDWeRtHo72r/GnQSW30QnkVCEcw1Xur39H6r0oQ
         3KQTYu2Sbb1MsdxNisWhrspgNoJ29VzCkJHi0lTyEEQ6BQVvszENWhqibDqPxaI0eB
         GscVWTvi3hVb06JB0oAynsHk=
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Kai Krakow <hurikhan77+btrfs@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Help recovering filesystem (if possible)
Date:   Wed, 24 Nov 2021 00:11:46 -0500
Message-ID: <4306866.vuYhMxLoTh@ring00>
In-Reply-To: <20211124044343.GF17148@hungrycats.org>
References: <2586108.vuYhMxLoTh@cwmtaff> <3593309.dWV9SEqChM@ring00> <20211124044343.GF17148@hungrycats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tuesday, November 23, 2021 11:43:43 P.M. EST Zygo Blaxell wrote:
> On Thu, Nov 18, 2021 at 11:42:05PM -0500, Matthew Dawson wrote:
> > On Thursday, November 18, 2021 4:09:15 P.M. EST Zygo Blaxell wrote:
> > > On Wed, Nov 17, 2021 at 09:57:40PM -0500, Matthew Dawson wrote:
> > > > On Monday, November 15, 2021 5:46:43 A.M. EST Kai Krakow wrote:
> > > > > Am Mo., 15. Nov. 2021 um 02:55 Uhr schrieb Matthew Dawson
> > > > > 
> > > > > <matthew@mjdsystems.ca>:
> > > > > > I recently upgrade one of my machines to the 5.15.2 kernel.  on
> > > > > > the
> > > > > > first
> > > > > > reboot, I had a kernel fault during the initialization (I didn't
> > > > > > get
> > > > > > to
> > > > > > capture the printed stack trace, but I'm 99% sure it did not have
> > > > > > BTRFS
> > > > > > related calls).  I then rebooted the machine back to a 5.14
> > > > > > kernel,
> > > > > > but
> > > > > > the
> > > > > > BCache (writeback) cache was corrupted.  I then force started the
> > > > > > underlying disks, but now my BTRFS filesystem will no longer
> > > > > > mount.  I
> > > > > > realize there may be missing/corrupted data, but I would like to
> > > > > > ideally
> > > > > > get any data I can off the disks.
> > > > > 
> > > > > I had a similar issue lately where the system didn't reboot cleanly
> > > > > (there's some issue in the BIOS or with the SSD firmware where it
> > > > > would disconnect the SSD from SATA a few seconds after boot, forcing
> > > > > bcache into detaching dirty caches).
> > > > > 
> > > > > Since you are seeing transaction IDs lacking behind expectations, I
> > > > > think you've lost dirty writeback data from bcache. Do fix this in
> > > > > the
> > > > > future, you should use bcache only in writearound or writethrough
> > > > > mode.
> > > > 
> > > > Considering I started the bcache devices without the cache, I don't
> > > > doubt
> > > > I've lost writeback data and I have no doubts there will be issues. 
> > > > At
> > > > this point I'm just in data recovery, trying to get what I can.
> > > 
> > > The word "issues" is not adequate to describe the catastrophic damage
> > > to metadata that occurs if the contents of a writeback cache are lost.
> > > 
> > > If writeback failure happens to only one btrfs device's cache, you
> > > can recover with btrfs raid1 self-healing using intact copies stored
> > > on working devices.  If it happens on multiple btrfs devices at once
> > > (e.g. due to misconfiguration of bcache with more than one btrfs device
> > > per pool or more than one bcache pool per SSD, or due to a kernel bug
> > > that affects all bcache instances at once, or a firmware bug that
> > > affects
> > > each SSD device the same way during a crash) then recovery isn't
> > > possible.
> > > 
> > > Writeback cache failures are _bad_, falling between "many thousands of
> > > bad sectors" and "total disk failure" in terms of difficulty of
> > > recovery.
> > > 
> > > > Hopefully someone has a different idea?  I am posting here because I
> > > > feel
> > > > any luck is going to start using more dangerous options and those
> > > > usually
> > > > say to ask the mailing list first.
> > > 
> > > Your best option would be to get the caches running again, at least in
> > > read-only mode.  It's not a good option, but all your other options
> > > depend
> > > on having access to as many cached dirty pages as possible.  If all you
> > > have is the backing devices, then now is the time to scrape what you
> > > can from the drives with 'btrfs restore' then make use of your backups.
> > 
> > At this point I think I'm stuck with just the backing devices (with GB of
> > lost dirty data on the cache).  And I'm primarily in data recovery,
> > trying to get whatever good data I can to help supplement the backed up
> > data.
> 
> I don't use words like "catastrophic" casually.  Recovery typically
> isn't possible with the backing disks after a writeback cache failure.
> 
> The writeback cache algorithm will prefer to keep the most critical
> metadata in cache, while writing out-of-date metadata pages out to the
> backing devices.  This process effectively wipes btrfs metadata off
> the backing disks as the cache fills up, and puts it back as the cache
> flushes out.  If a large dirty cache dies, it can leave nothing behind.
> 
> > As mentioned in my first email though, btrfs restore fails with the
> > following error message:
> > # btrfs restore -l /dev/dm-2
> > parent transid verify failed on 132806584614912 wanted 3240123 found
> > 3240119 parent transid verify failed on 132806584614912 wanted 3240123
> > found 3240119 parent transid verify failed on 132806584614912 wanted
> > 3240123 found 3240119 parent transid verify failed on 132806584614912
> > wanted 3240123 found 3240119 Ignoring transid failure
> > Couldn't setup extent tree
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > warning, device 6 is missing
> > warning, device 13 is missing
> > warning, device 12 is missing
> > warning, device 11 is missing
> > warning, device 7 is missing
> > warning, device 9 is missing
> > warning, device 14 is missing
> > bytenr mismatch, want=136920576753664, have=0
> > ERROR: cannot read chunk root
> > Could not open root, trying backup super
> > warning, device 6 is missing
> > warning, device 13 is missing
> > warning, device 12 is missing
> > warning, device 11 is missing
> > warning, device 7 is missing
> > warning, device 9 is missing
> > warning, device 14 is missing
> > bytenr mismatch, want=136920576753664, have=0
> > ERROR: cannot read chunk root
> > Could not open root, trying backup super
> > When all devices are up and reported to the kernel.  I was looking for
> > help to try and move beyond these errors and get whatever may still be
> > available.
> The general btrfs recovery process is:
> 
> 	1.  Restore device and chunk trees.  Without these, btrfs
> 	can't translate logical to physical block addresses, or even
> 	recognize its own devices, so you get "device is missing" errors.
> 	The above log shows that device and chunk tree data is now in the
> 	cache--or at least, not on the backing disks.	'btrfs rescue
> 	chunk-recover' may locate an older copy of this data by brute
> 	force search of the disk, if an older copy still exists.
> 
> 	2.  Find subvol roots to read data.  'btrfs-find-root' will
> 	do a brute-force search of the disks to locate subvol roots,
> 	which you can pass to 'btrfs restore -l' to try to read files.
> 	Normally this produces hundreds of candidates and you'll have
> 	to try each one.  If you have an old snapshot (one that predates
> 	the last full cache flush, and no balance, device shrink, device
> 	remove, defrag, or dedupe operation has occurred since) then you
> 	might be able to read its entire tree.	Subvols that are modified
> 	recently will be unusable as they will be missing many or all
> 	of their pages (they will be in the cache, not the backing disks).
> 
> 	3.  Verify the data you get back.  The csum tree is no longer
> 	usable, so you'll have no way to know if any data that you get
> 	from the filesystem is correct or garbage.  This is true even if
> 	you are reading from an old snapshot, as the csum tree is global
> 	to all subvols and will be modified (and moved into the cache)
> 	by any write to the filesystem.
> 
> In the logs above we see that you have missing pages in extent, chunk,
> and device trees.  In a writeback cache setup, new versions of these
> trees will be written to the cache, while the old versions are partially
> or completely erased on the backing devices in the process of flushing
> out previous dirty pages.  This pattern will repeat for subvol and csum
> trees, leaving you with severely damaged or unusable metadata on the
> backing disks as long as there are dirty pages in cache.
> 
> > If further recovery is impossible that's fine I'll wipe and start over,
> > but I rather try some risky things to get what I can before I do so.
> 
> I wouldn't say it's impossible in theory, but in practice it is a level
> of effort comparable to unshredding a phone book--after someone has
> grabbed a handful of the shredded paper and burned it.
> 
> High-risk interventions like 'check --repair --init-extent-tree' are
> likely to have no effect in the best case (they'll give up due to lack
> of usable metadata), and will destroy even more data in the worst case
> (they'll try modifying the filesystem and overwrite some of the surviving
> data).  They depend on having intact device and subvol trees to work,
> so if you can't get those back, there's no need to try anything else.
> 
> In theory, if you can infer the file structure from the contents of the
> files, you might be able to guess some of the missing metadata.  e.g. the
> logical-to-physical translation in the device tree only provides about
> 16 bits of an extent byte address, so you could theoretically build
> a tool which tries all 65536 most likely disk locations for a block
> until it finds a plausible content match for a file, and use that tool
> to reconstruct the device tree.  It might even be possible to automate
> this using fragments of the csum tree (assuming the relevant parts of
> the csum tree exist on the backing devices and not only in the cache).
> This is only the theory--practical tools to do this kind of recovery
> don't yet exist.
Thanks for the suggestions!  I'll give them a try over the next bit (I'm 
getting some extra storage, then I'll try using device mapper's snapshot 
target to avoid destroying what there).

I also might try writing a recovery tool for the bcache cache, doing something 
similar to the dm snapshot system.

Thanks for the pointers!
--
Matthew


