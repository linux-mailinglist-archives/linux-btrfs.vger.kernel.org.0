Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAC374E99
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 06:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEFEdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 00:33:55 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45254 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhEFEdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 May 2021 00:33:55 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 05D57A478EF; Thu,  6 May 2021 00:32:29 -0400 (EDT)
Date:   Thu, 6 May 2021 00:32:29 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Abdulla Bubshait <darkstego@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Array extremely unbalanced after convert to Raid5
Message-ID: <20210506043229.GD32440@hungrycats.org>
References: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
 <20210505144949.GB32440@hungrycats.org>
 <CADOXG6H7U7grsq0nmEgykYKMwSfOxKiwB0tSaz3_sJAVTGigCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOXG6H7U7grsq0nmEgykYKMwSfOxKiwB0tSaz3_sJAVTGigCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 05, 2021 at 11:35:23AM -0400, Abdulla Bubshait wrote:
> On Wed, May 5, 2021 at 10:49 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > Balancing a full single array to raid5 requires a better device selection
> > algorithm than the kernel provides, especially if the disks are of
> > different sizes and were added to the array over a long period of time.
> > The kernel will strictly relocate the newest block groups first, which
> > may leave space occupied on some disks for most of the balance, and
> > cause many chunks to be created with suboptimal stripe width.
> >
> Is this also true of running a full balance after conversion to raid5?
> Is it able to optimize the stripe width or would a balance run into
> the same issue due to
> the disks being full?

Balancing all the data block groups in a single command will simply
restripe every chunk in reverse creation order, whether needed or not,
and get whatever space is available at the time for each chunk--and
possibly run out of space on filesystems with non-equal disk sizes.
If you run it enough times, it might eventually settle into a good state,
but it is not guaranteed.

Generally you should never do a full balance because a full balance
balances metadata, and you should never balance metadata because it
will lead to low-metadata-space conditions like the one you are in now.
The exceptions to the "never balance metadata" rule are when converting
from one raid profile to a different profile, or when permanently removing
a disk from the filesystem, and even then you should ensure there is a
lot of unallocated space available before starting a metadata balance.

> > Now use the stripes filter to get rid of all chunks that have fewer
> > than the optimum number of stripes on each disk.  Cycle through these
> > commands until they report 0 chunks relocated (you can just leave these
> > running in a shell loop and check on it every few hours, when they get
> > to 0 they will just become no-ops):
> >
> >         btrfs balance start -dlimit=100,convert=raid5,stripes=1..3,devid=3 /fs
> >
> >         btrfs balance start -dlimit=100,convert=raid5,stripes=1..2,devid=2 /fs
> >
> >         btrfs balance start -dlimit=100,convert=raid5,stripes=1..1,devid=1 /fs
> >
> >         btrfs balance start -dlimit=100,convert=raid5,stripes=1..1,devid=4 /fs
> >
> > The filters select chunks that have undesirable stripe counts and force
> > them into raid5 profile.  Single chunks have stripe count 1 and will
> > be converted to raid5.  RAID5 chunks have stripe count >1 and will be
> > relocated (converted from raid5 to raid5, but in a different location
> > with more disks in the chunk).  RAID5 chunks that already occupy the
> > correct number of drives will not be touched.
> 
> That is what I was looking to do, I must have missed the stripes
> filter. I think I can figure out a script that is able to spread the
> data enough.
> 
> But here is a question. At what point does the fs stop striping onto a
> disk? Does it stop at 1MB unallocated and if so does that cause issues
> in practice if the need arises to allocate metadata chunks due to
> raid1c3?

Allocators come in two groups:  those that fill the emptiest disks first
(raid1*, single, dup) and those that fill all disks equally (raid0,
raid5, raid6, raid10).  raid1c3 metadata has a 3-disk minimum, so it
will allocate all its space on the 3 largest disks (or most free space
if the array is unbalanced) and normally runs out of space when the 3rd
largest disk in the array fills up.  raid5 data has a 2-disk minimum,
but will try to fill all drives equally, and normally runs out of space
when the 2nd largest disk in the array fills up.

raid5 fills up devid 3 first, then 2, then 1 and 4.  raid1c3 fills up
devid 1, 4, and 2 first, then 3.  When raid5 fills up devid 2, raid1c3 is
out of space, so you will have effectively 2TB unusable--there will not be
enough metadata space to fill the last 2 TB on devid 1 and 4.  You will
also have additional complications due to being out of metadata space
without also being out of data space that can be hard to recover from.

You can fix that in a few different ways:

	- convert metadata to raid1 (2 disk minimum, 1 failure tolerated,
	same as raid5, works with the 2 largest disks you have).

	- resize the 2 largest disks to be equal in size to the 3rd
	largest (will reduce filesystem capacity by 2 TB).  This ensures
	the 3rd largest disk will fill up at the same time as the two
	larger ones, so raid1c3 metadata can always be allocated until
	the filesystem is completely full.

	- replace a smaller disk with one matching the largest 2 disk
	sizes.	This is another way to make the top 3 disks the same
	size to satisfy the raid1c3 requirement.

	- mount -o metadata_ratio=20 (preallocates a lot of metadata
	space, equal in size to 5% of the data when normally <3% are
	needed).  Remember to never balance metadata or you'll lose
	this preallocation.  This enables maximum space usage and
	3-disk metadata redundancy, but it has a risk of failure
	if the metadata ratio turns out to be too low.
