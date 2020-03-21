Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3937618DE71
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 08:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgCUHO3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 21 Mar 2020 03:14:29 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41044 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgCUHO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 03:14:29 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 09E55621017; Sat, 21 Mar 2020 03:14:25 -0400 (EDT)
Date:   Sat, 21 Mar 2020 03:14:25 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200321071425.GS13306@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <bd70e1fc-5e5b-672b-cc7c-0cd9b8b31e4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <bd70e1fc-5e5b-672b-cc7c-0cd9b8b31e4a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 21, 2020 at 08:40:50AM +0300, Andrei Borzenkov wrote:
> 21.03.2020 06:29, Zygo Blaxell пишет:
> > On Fri, Mar 20, 2020 at 06:56:38PM +0100, Goffredo Baroncelli wrote:
> >> Hi all,
> >>
> >> for a btrfs filesystem, how an user can understand which is the {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk which profile will have ?
> > 
> > It's the profile used by the highest-numbered block group for the
> > allocation type (one for data, one for metadata/system).
> 
> Is "highest-numbered" block group always the last one created? 

It's not required by the filesystem format but it is the current behavior
of the implementation.

> Can block group numbers wrap around?

In theory, yes, but they are 64 bits long and correspond to bytes in the
filesystem's address space.  If you loop balancing a filesystem with a
single 4K data block and you can do it at 1000 block groups per second,
you'll wrap around in a little over six months.  Typical use cases
(and even extreme ones) will take centuries to wrap around if you
are converting all the time.

> Recently someone reported that after conversion block groups with old
> profile remained and this probably explains it - conversion races with
> new allocation.

Conversion *is* new allocation, no race is possible because they are
the same thing.

While a conversion is running, the conversion itself forces the
raid profile of newly created block groups, so there is no race.
After conversion is completed, there is special case code to prevent the
last empty block group in the filesystem from being deleted; otherwise,
btrfs would lose information about the selected raid profile.

When a conversion is paused or cancelled, new allocations normally
continue using the conversion target profile; however, if all block
groups of the new profile are deleted (i.e. all the data contained in
the new block groups are removed) then it is possible to revert back to
allocating using an older profile.  e.g. if you want to combine a balance
convert with a device remove, you have to let the convert run long enough
to ensure several block groups of the new raid profile exist on other
drives than the drive being removed.  The device remove will delete all
block groups on the removed device, in reverse device physical offset
order which is often (but not necessarily) reverse block group order.
This leads to device remove switching back to the old RAID profile.
This example is not any kind of race--the result can be produced
deterministically, and the conversion must be paused first.

A conversion can be forcibly stopped by various events:  crashes,
unmounting the filesystem, having an unrecoverable read or write error,
or running out of space.  These events will leave block groups with old
profiles on the disk.  Generally if an external event forces conversion
to stop, then it will need to be manually restarted.

If there are uncorrectable read errors on the filesystem then affected
data blocks must be removed from the filesystem before conversion can
be completed.  Same with free space, you must have enough to complete.

Old versions of mkfs.btrfs had bugs which would leave empty block groups
with different profiles on the filesystem.  When in doubt, or if you have
an older vintage btrfs filesystem, run a converting balance with the
desired raid profile and the 'soft' filter to be sure only one profile
is present--it will be a no-op if conversion is complete; otherwise,
it will finish the conversion.

> >> So the question is: the next chunk which profile will have ?
> >> Is there any way to understand what will happens ?
> 
> Well, from that explanation it is not possible using standard tools -
> one needs to crawl btrfs internals to find out the "last" block group.

This is required only during the conversion process.  In normal cases
users can assume the only profile present is the one that will be used.

The python-btrfs package contains an example of listing block groups.
The last entry in the list will have the current allocation profile.

An unprivileged user can monitor 'btrfs fi df' output over time.
Used space will increase or decrease in the current profile, and
only decrease in the other profiles.
