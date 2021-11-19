Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAE456956
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 05:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhKSEuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 23:50:35 -0500
Received: from scadrial.mjdsystems.ca ([192.99.73.14]:33537 "EHLO
        scadrial.mjdsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSEuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 23:50:35 -0500
Received: from ring00.localnet (unknown [IPv6:2607:f2c0:ed80:400::1269])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id A6F35820D711;
        Thu, 18 Nov 2021 23:47:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed; d=mjdsystems.ca;
        s=202010; t=1637297252;
        bh=NZJtrT5U0wApgbmjoqyGAg9kknO2P70WmdRD3cFyt0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioYrKEOkPUomqXSiXA968JADChHUvpYfB6bvQeeX5SPvNh+PS/TFJDa9B3+qgmmYr
         xoO+4keWc9QrRoX0WCYF4ybMJEVVf1lQyNswmeggMxZ/5qZ559VDWNSW7+TPsVHdSn
         mptq8cklsOcKZAS6oGlNyGxDnzvJY0d999wQtXUIoAVHBQPcHUPN7UtRP1DJHxObd1
         3fBiF54FlgEZ678B1tRr/rUtVsvzpBvAVfOXMjKWT1Lm/DQCfLZm6LsMvWpjyQsW9j
         E9Aw92rXlh6nB2qglDR9ThPZAGTfays/Hpj9SJW/+y0f1aIn7MS8CjfNaoY3iIokNl
         0Cn3oOW/QoABCB+fiLyx7pmZrT0aXQjDVVQU4cX+/uzY2MgR4e2LqbRap+YKnVlClf
         H6GnhMjjGcwlodRkII0hxvKezMjgXH4nvyFM7kzDHbzDjc9hp/5jDvHDv6uWrQK2oK
         A9oOKFQ/Xpv1yNn2BHP7WYcl84XDa0YfFWevUzvuo7NjHJeyuu4LcS8SlLCBVFL5VX
         2popF1FNwPb2WZiTCxXVOmbrUw7XESQgxKKEDnjsim/DAK7a5Jpkns0eYMSl7/Z2qq
         kJKoE92cki4VybT78QlCSxKdM7g9APyV5cjPuTbyfgtEqQMCrVWwTD3jY2/iivbed3
         CYUZJtrBwyDDg7cb4iCnGSO8=
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Kai Krakow <hurikhan77+btrfs@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Help recovering filesystem (if possible)
Date:   Thu, 18 Nov 2021 23:42:05 -0500
Message-ID: <3593309.dWV9SEqChM@ring00>
In-Reply-To: <20211118210915.GC17148@hungrycats.org>
References: <2586108.vuYhMxLoTh@cwmtaff> <3321185.LZWGnKmheA@cwmtaff> <20211118210915.GC17148@hungrycats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thursday, November 18, 2021 4:09:15 P.M. EST Zygo Blaxell wrote:
> On Wed, Nov 17, 2021 at 09:57:40PM -0500, Matthew Dawson wrote:
> > On Monday, November 15, 2021 5:46:43 A.M. EST Kai Krakow wrote:
> > > Am Mo., 15. Nov. 2021 um 02:55 Uhr schrieb Matthew Dawson
> > > 
> > > <matthew@mjdsystems.ca>:
> > > > I recently upgrade one of my machines to the 5.15.2 kernel.  on the
> > > > first
> > > > reboot, I had a kernel fault during the initialization (I didn't get
> > > > to
> > > > capture the printed stack trace, but I'm 99% sure it did not have
> > > > BTRFS
> > > > related calls).  I then rebooted the machine back to a 5.14 kernel,
> > > > but
> > > > the
> > > > BCache (writeback) cache was corrupted.  I then force started the
> > > > underlying disks, but now my BTRFS filesystem will no longer mount.  I
> > > > realize there may be missing/corrupted data, but I would like to
> > > > ideally
> > > > get any data I can off the disks.
> > > 
> > > I had a similar issue lately where the system didn't reboot cleanly
> > > (there's some issue in the BIOS or with the SSD firmware where it
> > > would disconnect the SSD from SATA a few seconds after boot, forcing
> > > bcache into detaching dirty caches).
> > > 
> > > Since you are seeing transaction IDs lacking behind expectations, I
> > > think you've lost dirty writeback data from bcache. Do fix this in the
> > > future, you should use bcache only in writearound or writethrough
> > > mode.
> > 
> > Considering I started the bcache devices without the cache, I don't doubt
> > I've lost writeback data and I have no doubts there will be issues.  At
> > this point I'm just in data recovery, trying to get what I can.
> 
> The word "issues" is not adequate to describe the catastrophic damage
> to metadata that occurs if the contents of a writeback cache are lost.
> 
> If writeback failure happens to only one btrfs device's cache, you
> can recover with btrfs raid1 self-healing using intact copies stored
> on working devices.  If it happens on multiple btrfs devices at once
> (e.g. due to misconfiguration of bcache with more than one btrfs device
> per pool or more than one bcache pool per SSD, or due to a kernel bug
> that affects all bcache instances at once, or a firmware bug that affects
> each SSD device the same way during a crash) then recovery isn't possible.
> 
> Writeback cache failures are _bad_, falling between "many thousands of
> bad sectors" and "total disk failure" in terms of difficulty of recovery.
> 
> > Hopefully someone has a different idea?  I am posting here because I feel
> > any luck is going to start using more dangerous options and those usually
> > say to ask the mailing list first.
> 
> Your best option would be to get the caches running again, at least in
> read-only mode.  It's not a good option, but all your other options depend
> on having access to as many cached dirty pages as possible.  If all you
> have is the backing devices, then now is the time to scrape what you
> can from the drives with 'btrfs restore' then make use of your backups.
At this point I think I'm stuck with just the backing devices (with GB of lost 
dirty data on the cache).  And I'm primarily in data recovery, trying to get 
whatever good data I can to help supplement the backed up data.

As mentioned in my first email though, btrfs restore fails with the following 
error message:
# btrfs restore -l /dev/dm-2
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
parent transid verify failed on 132806584614912 wanted 3240123 found 3240119
Ignoring transid failure
Couldn't setup extent tree
Couldn't setup device tree
Could not open root, trying backup super
warning, device 6 is missing
warning, device 13 is missing
warning, device 12 is missing
warning, device 11 is missing
warning, device 7 is missing
warning, device 9 is missing
warning, device 14 is missing
bytenr mismatch, want=136920576753664, have=0
ERROR: cannot read chunk root
Could not open root, trying backup super
warning, device 6 is missing
warning, device 13 is missing
warning, device 12 is missing
warning, device 11 is missing
warning, device 7 is missing
warning, device 9 is missing
warning, device 14 is missing
bytenr mismatch, want=136920576753664, have=0
ERROR: cannot read chunk root
Could not open root, trying backup super

When all devices are up and reported to the kernel.  I was looking for help to 
try and move beyond these errors and get whatever may still be available.

If further recovery is impossible that's fine I'll wipe and start over, but I 
rather try some risky things to get what I can before I do so.

> 
> This is what you're up against:
> 
> btrfs writes metadata pages in a specific order to keep one complete
> metadata tree on disk intact at all times.  This means that a specific
> item of metadata (e.g. a directory or inode) is stored in different disk
> blocks at different times.  Old physical disk blocks are frequently
> recycled to store different data--not merely newer versions of the
> same items, but completely unrelated items from different areas of
> the filesystem.
> 
> Writeback caches write to backing devices in mostly sequential
> LBA order for performance.  This is a defining characteristic of a
> writeback cache--if the cache maintained the btrfs write order on the
> backing device then we'd call it a "writethrough" or "writebehind"
> cache instead.  Writeback caches don't need to respect write order for
> individual blocks on the backing device as long as they can guarantee they
> will eventually finish writing all of the data out to the backing device
> (i.e. they restart writeback automatically after a reboot or crash).
> 
> During writeback, some metadata items will temporarily appear on the
> backing device two or more times (a new version of the item was written,
> but an old version of the item has not been overwritten yet and remains
> on the backing device) while other items will be completely missing (the
> old version of the item has been overwritten, but the new version of the
> item has not been written yet, so no version of the item exists on the
> backing device).  The backing disk will normally be missing significant
> portions of the filesystem's metadata as long as there are dirty pages
> in the cache device.
> 
> A recovery tool reading the backing device can't simply find an old
> version of an inode's metadata, get a location for most of its data
> blocks, and guess the locations of remaining blocks or truncate the file
> (as tools like e2fsck do).  The missing btrfs metadata items are not
> present at all on the backing device, because their old versions will be
> erased from the backing device during writeback, while the new versions
> haven't been written yet and will exist only in the cache device.
> 
> If the cache had a non-trivial number of dirty blocks when it failed, then
> the above losses occur many thousands of times in the metadata trees, and
> each lost page may contain metadata for hundreds of files.  The backing
> disk will contain a severely damaged (some might say "destroyed")
> filesystem.  Recovery tools would be able to delete incomplete objects
> from the filesystem and make the filesystem mountable, but with
> significant (if not total) data losses.




