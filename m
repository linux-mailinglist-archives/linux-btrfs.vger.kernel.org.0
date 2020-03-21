Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1518E573
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Mar 2020 00:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgCUX0m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 21 Mar 2020 19:26:42 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42694 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgCUX0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 19:26:41 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 636656241FA; Sat, 21 Mar 2020 19:26:39 -0400 (EDT)
Date:   Sat, 21 Mar 2020 19:26:39 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200321232638.GD2693@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 21, 2020 at 10:55:32AM +0100, Goffredo Baroncelli wrote:
> On 3/21/20 4:29 AM, Zygo Blaxell wrote:
> > On Fri, Mar 20, 2020 at 06:56:38PM +0100, Goffredo Baroncelli wrote:
> > > Hi all,
> > > 
> > > for a btrfs filesystem, how an user can understand which is the {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk which profile will have ?
> > 
> > It's the profile used by the highest-numbered block group for the
> > allocation type (one for data, one for metadata/system).  There
> > are two profiles to consider, one for data and one for metadata.
> > 'btrfs fi df', 'btrfs fi us', or 'btrfs dev usage' will all indicate
> > which profiles these are.
> > 
> 
> What do you think as "highest-numbered block group", the value in the "offset" filed.

Objectid field (the offset field is the size for block group items).

> If so it doesn't make sense because it could be relocated easily.

Relocation will create a new block group with the filesystem's current
profile, which is the conversion target profile if present (all conversion
is relocation), but some other profile in use on the filesystem otherwise.

> Anyway what are you describing is not what I saw. In the test above
> I create a raid5 filesystem, filled 1 chunk at 100% and a second chunk
> for few MB. Then I convert the most empty chunk as single. 

OK, I was missing some details:  At mount time all the block group items
are read in order, and each one adjusts the allocator profile bits for
the entire filesystem.  The last block group is the one that has the
*most influence* over the profile when no conversion is running, but
doesn't set the profile alone.

If there is a partial conversion, then the behavior changes as you note.

When a conversion is active, the conversion target profile overrides
everything else.  That is how you can get a single block group on a
filesystem that is entirely raid5.

So...TL;DR if you're not running a conversion, the next block group will
use some RAID profile already present on the filesystem, and it may not
be the one you want it to be.

> Then I fill
> the last chunk (the single one) and force to create a new chunk. What
> I saw is that the new chunk is raid5 mode.
> 
> $ sudo mkfs.btrfs -draid5  /dev/loop[012]
> $ dd if=/dev/zero of=t/file-2.128gb_5 bs=1M count=$((2024+128)) # fill two chunk raid 5
> $ sudo btrfs fi du t/. # see what is the situation
> [...]
> Data,RAID5: Size:4.00GiB, Used:2.10GiB (52.57%)
>    /dev/loop0	   2.00GiB
>    /dev/loop1	   2.00GiB
>    /dev/loop2	   2.00GiB
> [...]
> $ sudo btrfs balance start -dconvert=single,usage=50 t/. # convert the latest chunk to single
> $ sudo btrfs fi us t/.	# see what is the situation
> [...]
> Data,single: Size:1.00GiB, Used:259.00MiB (25.29%)
>    /dev/loop0	   1.00GiB
> 
> Data,RAID5: Size:2.00GiB, Used:1.85GiB (92.47%)
>    /dev/loop0	   1.00GiB
>    /dev/loop1	   1.00GiB
>    /dev/loop2	   1.00GiB
> [...]
> 
> # fill the latest chunk and created a new one
> $ dd if=/dev/zero of=t/file-1.128gb_6 bs=1M count=$((1024+128))
> 
> $ sudo btrfs fi us t/. # see what is the situation
> [...]
> Data,single: Size:1.00GiB, Used:259.00MiB (25.29%)
>    /dev/loop0	   1.00GiB
> 
> Data,RAID5: Size:4.00GiB, Used:1.85GiB (46.24%)
>    /dev/loop0	   2.00GiB
>    /dev/loop1	   2.00GiB
>    /dev/loop2	   2.00GiB
> [...]
> 
> Expected results: the "single" chunk should pass from 1GB to 2GB. What it is observed is that the raid5 (the oldest chunk) passed from 2GB to 4GB.

...but now you are not running conversion any more, and have multiple
profiles.  It's not really specified what will happen under those
conditions, nor is it obvious what the correct behavior should be.

The on-disk format does not have a field for "target profile".
Adding one would be a disk format change.

> [...]
> > > Looking at the code it seems to me that the logic is the following (from btrfs_reduce_alloc_profile())
> > > 
> > >          if (allowed & BTRFS_BLOCK_GROUP_RAID6)
> > >                  allowed = BTRFS_BLOCK_GROUP_RAID6;
> > >          else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
> > >                  allowed = BTRFS_BLOCK_GROUP_RAID5;
> > >          else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
> > >                  allowed = BTRFS_BLOCK_GROUP_RAID10;
> > >          else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
> > >                  allowed = BTRFS_BLOCK_GROUP_RAID1;
> > >          else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
> > >                  allowed = BTRFS_BLOCK_GROUP_RAID0;
> > > 
> > >          flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
> > > 
> > > So in the case above the profile will be RAID6. And in the general if a RAID6 chunk is a filesystem, it wins !
> > 
> > This code is used to determine whether a conversion reduces the level of
> > redundancy, e.g. you are going from raid6 (2 redundant disks) to raid5
> > (1 redundant disk) or raid0 (0 redundant disks).  There are warnings and
> > a force flag required when that happens.  It doesn't determine the raid
> > profile of the next block group--that's just a straight copy of the raid
> > profile of the last block group.
> 
> To me it seems that this function decides the allocation of the next chunk. The chain of call is the following:

Sorry, in my earlier mail I thought we were talking about a different
piece of code that tries to enforce a similar rule.

> btrfs_force_chunk_alloc
> 	btrfs_get_alloc_profile
> 		get_alloc_profile
> 			btrfs_reduce_alloc_profile
> 	btrfs_chunk_alloc
> 		btrfs_alloc_chunk
> 			__btrfs_alloc_chunk
> 
> or another one is
> 
> btrfs_alloc_data_chunk_ondemand
> 	btrfs_data_alloc_profile
> 		btrfs_get_alloc_profile
> 			get_alloc_profile
> 				btrfs_reduce_alloc_profile
> 	btrfs_chunk_alloc
> 		btrfs_alloc_chunk
> 			__btrfs_alloc_chunk
> 
> 
> The btrfs_get_alloc_profile/get_alloc_profile/btrfs_reduce_alloc_profile chain decides which profile has to be allocated.
> The current actives profiles are took and then filtered by the possible allowed on the basis of the number of disk. Which means that if a raid6 profile chunk exists (and there is a enough number of devices), the next chunk will be allocated as raid6.
> 
> So is how I read the code, and what suggest my tests...
> 
> My conclusion is: if you have multiple raid profile per disk, the next chunk allocation doesn't depend by the latest "balance", but but by the above logic.
> The recipe is: when you made a balance, pay attention to not leave any chunk in old format

Well, yes, that is what I've been saying:  don't expect btrfs to do sane
things with a mixture of profiles.  Stick to just one profile, except
in the special case of a conversion.  You wouldn't leave an array in
degraded mode for long, and you need to balance after adding a single
drive to a raid1 or striped-profile raid array.  Partially converted
filesystems fall into this category too.

> > > But I am not sure.. Moreover I expected to see also reference to DUP and/or RAID1C[34] ...
> > 
> > If you get through that 'if' statement without hitting any of the
> > branches, then you're equal to raid0 (0 redundant disks) but raid0
> > is a special case because it requires 2 disks for allocation.  'dup'
> > (0 redundant disks) and 'single' (which is the absence of any profile
> > bits) also have 0 redundant disks and require only 1 disk for allocation,
> > there is no need to treat them differently.
> > 
> > raid1c[34] probably should be there.  Patches welcome.
> > 
> > > Does someone have any suggestion ?
> > > 
> > > BR
> > > G.Baroncelli
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
