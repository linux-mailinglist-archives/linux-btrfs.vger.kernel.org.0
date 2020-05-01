Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2F1C0C22
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEACai convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 30 Apr 2020 22:30:38 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43830 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgEACai (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 22:30:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9EAC469CB81; Thu, 30 Apr 2020 22:30:30 -0400 (EDT)
Date:   Thu, 30 Apr 2020 22:30:30 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Rollo ro <rollodroid@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: raid56 write hole
Message-ID: <20200501023029.GD10769@hungrycats.org>
References: <CAAhjAp1zrjrizrswo3BF1-cTXArpZ5XFUPbd-OR_Nu1N05pdSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAhjAp1zrjrizrswo3BF1-cTXArpZ5XFUPbd-OR_Nu1N05pdSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 07:00:43PM +0200, Rollo ro wrote:
> Hi, I read about the write hole and want to share my thoughts. I'm not
> sure if I got it in full depth but as far as I understand, the issue
> is about superblocks on disks, the superblocks containing addresses of
> tree roots and if the trees are changed using copy on write, we have a
> new root and it's address needs to be written into the superblock.
> That leads to inconsistent data if one address is updated but another
> one is not. Is this about right? 

Nope.  See Wikipedia, or google for "write hole".  When people say
"write hole", especially in a btrfs context, they are almost always
talking about raid5.

btrfs's raid1 write hole is handled by btrfs cow update write ordering
(assuming the drives have working write ordering, and that a write to
any individual sector on a disk does not change the content of any other
sector on that or any other disk).  The update ordering assumes the
drive can reorder writes between barriers, so it trivially handles the
raid1 cases.  Any updates that fail to land on one disk or the other are
not part of the filesystem after a crash, because the transaction that
contains them did not complete.  Superblocks are updated on the opposite
side of the barrier, so we know all disks have the new filesystem tree
on disk before any superblock points to it (and of course the old tree
is still there, so if the superblock is not updated that's OK too).

The write hole problem on btrfs arises because updates to raid5 parity
blocks use read-modify-write, i.e. they do an update in place with no
journal, while the CoW layer relies on the raid profile layer to never
do that.  This can be fixed either way, i.e. make the raid5 layer do
stripe update journalling, or make the CoW layer not modify existing
raid5 stripes.  Both options have significant IO costs that are paid at
different times (much later in the second case, as something like garbage
collection has to run periodically).  mdadm's raid5 implementation picked
the first option.  ZFS picked the second option (in the sense that their
RAIDZ stripes are immutable and always exactly the width of any data
they write, so they never modify an existing stripe).  btrfs has taken
7 years to not implement either solution yet.

ZFS pushed the parity into the CoW layer, so it's handled in a manner
similar to the way btrfs handles filesystem compression.  This could be
done on btrfs too, but the result would be an entirely new RAID scheme
that would be used instead of the current btrfs raid5/6 implementation
(the latter would be deprecated).  Doing it this way could work in
parallel with the existing raid profiles, so it could be used to implement
something that looks like raid5+1 and other layered redundancy schemes.

There's currently a bug which occurs after data has been corrupted by
any cause, including write hole:  btrfs updates parity without checking
the csums of all the other data blocks in the stripe first, so btrfs
propagates data corruption to parity blocks, and the parity blocks cannot
be used to reconstruct the damaged data later.  This is a distinct problem
from the write hole, but it means that given identical disk behavior,
btrfs's raid1* implementations would recover from all detectable errors
while btrfs's raid5/6 implementation will fail to correct some errors.

> (I'm not sure whether we are talking
> here about a discrepancy between two root adresses in one superblock,
> or between two superblocks on different disks or possibly both)
> 
> In my opinion, it's mandatory to have a consistent filesystem at _any_
> point in time, so it can't be relied on flush to write all new
> addresses!
> 
> I propose that the superblock should not contain the one single root
> address for each tree that is hopefully correct, but it should contain
> an array of addresses of tree root _candidates_. 

I invite you to look at the existing btrfs on-disk structures.

> Also, the addresses
> in the superblocks are written on filesystem creation, but not in
> usual operation anymore. In usual operation, when we want to switch to
> a new tree version, only _one_ of the root candidates is written with
> new content, so there will be the latest root but also some older
> roots. Now the point is, if there is a power outage or crash during
> flush, we have all information needed to roll back to the last
> consistent version.

There are already multiple superblocks on btrfs, and they each hold
several candidates.  The "usebackuproot" mount option can try to use one.

> We just need to find out which root candidate to use. 

Don't even need to do that--during a transaction commit, either root is
valid (nothing's committed to disk until btrfs returns to userspace).

> (This is why I
> call them candidates) To achieve that, the root candidates have an
> additional attribute that's something like a version counter and we
> also have a version counter variable in RAM. On a transition we
> overwrite the oldest root candidate for each tree with all needed
> information, it's counter with our current counter variable, and a
> checksum. The counter variable is incremented after that. At some
> point it will overflow, hence we need to consider that when we search
> the latest one. Let's say we use 8 candidates, then the superblock
> will contain something like:
> 
> LogicalAdress_t AddressRootCandidatesMetaData[8]
> LogicalAdress_t AddressRootCandidatesData[8]
> 
> (just as an example)
> 
> While mounting, we read all '8 x number of trees x disks' root
> candidates, lookup their version counters and check ZFS checksums.
> We have a struct like
> 
> typedef struct
> {
>     uint8_t Version;
>     CheckResult_te CeckResult; /* enum INVALID = 0, VALID = 1 */
> } VersionWithCheckResult_t
> 
> and build an array with that:
> 
> enum {ARRAY_SIZE = 8};
> VersionWithCheckResult_t VersionWithCheckResult[ARRAY_SIZE];
> 
> and write it in a loop. For example we get:
> 
> {3, VALID}, {4, VALID}, {253, VALID}, {254, VALID}, {255, VALID}, {0,
> VALID}, {1, VALID}, {2, VALID}
> (-> Second entry is the most recent valid one)
> 
> We'd like to get this from all disks for all trees, but there was a
> crash so some disks may have not written the new root candidate at
> all:
> 
> {3, VALID}, {252, VALID}, {253, VALID}, {254, VALID}, {255, VALID},
> {0, VALID}, {1, VALID}, {2, VALID}
> (-> First entry is the most recent valid one, as the second entry has
> not been updated)
> 
> or even left a corrupted one, which we will recognize by the checksum:
> (-> First entry is the most recent valid one, as the second entry has
> been corrupted)
> 
> {3, VALID}, {123, INVALID}, {253, VALID}, {254, VALID}, {255, VALID},
> {0, VALID}, {1, VALID}, {2, VALID}
> 
> Then we walk through that array, first searching the first valid
> entry, and then look if there are more recent, valid entries, like:
> 
> uint8_t IndexOfMostRecentValidEntry = 0xFF;
> uint8_t i = 0;
> while ((i < ARRAY_SIZE) && (IndexOfMostRecentValidEntry == 0xFF))
> {
>     if (VersionWithCheckResult[i].CheckResult == VALID)
>     {
>         IndexOfMostRecentValidEntry = i;
>     }
> }
> 
> for (i = 0, i < ARRAY_SIZE, i++)
> {
>     uint8_t IndexNext = CalcIndexNext(IndexOfMostRecentValidEntry); /*
> Function calculates next index with respect to wrap around */
>     uint8_t MoreRecentExpectedVersion =
> VersionWithCheckResult[IndexOfMostRecentValidEntry].Version + 1u; /*
> Overflows from 0xFF to 0 just like on-disk version numbers */
>     if ((VersionWithCheckResult[IndexNext].Version ==
> MoreRecentExpectedVersion) &&
> (VersionWithCheckResult[IndexNext].CheckResult == VALID))
>     {
>         IndexOfMostRecentValidEntry = IndexNext;
>     }
> }
> 
> Then we build another array that will be aligned to the entry we found:
> 
> VersionWithCheckResultSorted[ARRAY_SIZE] = {0}; /* All elements inited
> as 0 (INVALID) */
> uint8_t Index = IndexOfMostRecentValidEntry;
> for (i = 0, i < ARRAY_SIZE, i++)
> {
>     VersionWithCheckResultSorted[i] = VersionWithCheckResult[Index];
>     Index = CalcIndexPrevious(Index); /* Function calculates previous
> index with respect to wrap around */;
> }
> 
> With the 3 example datasets from above, we get:
> 
> {4, VALID}, {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255,
> VALID}, {254, VALID}, {253, VALID}
> {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255, VALID}, {254,
> VALID}, {253, VALID}, {252, VALID},
> {3, VALID}, {2, VALID}, {1, VALID}, {0, VALID}, {255, VALID}, {254,
> VALID}, {253, VALID}, {123, INVALID},
> 
> Now the versions are prioritized from left to right. It's easy to
> figure out that the latest version we can use is 3. We just fall back
> to the latest version for that we found a valid root candidate for
> every tree. In this example, it's index = 0 in the superblock array.
> So we use that to mount and set the counter variable to 1 for the next
> writes.
> 
> As a consequence, there is no write hole, because we always fall back
> to the latest state that is consistently available and discard the
> last write if it has not been finished correctly for all trees.
> 
> notes:
> - It's required that also the parity data is organized as COW trees. I
> don't know if it's done that way now.

It is not, which is the reason why btrfs has a raid5 write hole.

The on-disk layout is identical to mdadm raid5/6 with no journal or PPL,
so btrfs will fail in most of the same ways if you run single-device
btrfs on top of a mdadm raid5.  dup metadata on mdadm-raid5 might give
you a second roll of the dice to keep your data on every crash and power
failure, but it's categorically inferior to btrfs raid1 metadata which
doesn't roll dice in the first place.

> - For now I assumed that a root candidate is properly written or not.
> One could think of skipping one position and go to the next canditate
> in case of a recognized write error, but this is not covered in this
> example. Hence, if there is an invalid entry, the lookup loop does not
> look for further valid entries.

btrfs will try other disks, but the kernel will only try one superblock
per disk.

There is a utility to recover other superblocks so you can recover from
the one-in-a-billion chance that the only sector that gets corrupted on
the last write before a system crash or power failure on an otherwise
working disk happens to be the one that holds the primary superblock.

> - All data that all 8 root canditates point to need to be kept because
> we don't know which one will be used on the next mount. The data can
> be discarded after a root candidate has been overwritten.
> - ARRAY_SIZE basically could be 2. I just thought we could have some more

You only need two candidates if you have working write ordering.  If you
don't have working write ordering, or you want ARRAY_SIZE > 2, you have
to teach the transaction logic to keep more than two trees intact at
any time.  People have attempted this, it's not trivial.  Right now
there are 3 root backups in each superblock and there's no guarantee that
2 of them still point to an intact tree.

> What do you think?
