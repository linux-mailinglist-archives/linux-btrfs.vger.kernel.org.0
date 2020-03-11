Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005DD180EFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 05:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgCKElr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 11 Mar 2020 00:41:47 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37722 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgCKElq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 00:41:46 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1F1A660875E; Wed, 11 Mar 2020 00:41:44 -0400 (EDT)
Date:   Wed, 11 Mar 2020 00:41:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jonathan H <pythonnut@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: USB reset + raid6 = majority of files unreadable
Message-ID: <20200311044144.GQ13306@hungrycats.org>
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
 <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com>
 <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 08:45:17AM -0800, Jonathan H wrote:
> On Tue, Feb 25, 2020 at 8:37 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > It's great that your metadata is safe.
> >
> > The biggest concern is no longer a concern now.
> 
> Glad to hear.
> 
> > More context would be welcomed.
> 
> Here's a string of uncorrectable errors detected by the scrub: http://ix.io/2cJM
> 
> Here is another attempt to read a file giving an I/O error: http://ix.io/2cJS
> The last two lines are produced when trying to read the file a second time.
> 
> Here's the state of the currently running scrub: http://ix.io/2cJU
> I had to cancel and resume the scrub to run `btrfs check` earlier, but
> otherwise it has been uninterrupted.
> 
> > Anyway, even with more context, it may still lack the needed info as
> > such csum failure message is rate limited.
> >
> > The mirror num 2 means it's the first rebuild try failed.
> >
> > Since only the first rebuild try failed, and there are some corrected
> > data read, it looks btrfs can still rebuild the data.
> >
> > Since you have already observed some EIO, it looks like write hole is
> > involved, screwing up the rebuild process.
> > But it's still very strange, as I'm expecting more mirror number other
> > than 2.
> > For your 6 disks with 1 bad disk, we still have 5 ways to rebuild data,
> > only showing mirror num 2 doesn't look correct to me.
> 
> I'm sort of curious why so many files have been affected. It seems
> like most of the file system has become unreadable, but I was under
> the impression that if the write hole occurred it would at least not
> damage too much data at once. Is that incorrect?

There are still unfixed bugs in btrfs parity RAID:

	https://www.spinics.net/lists/linux-btrfs/msg94594.html

If you have an array where some of the drives go offline for a while and
come back online, then you will see a lot of what looks like disk-level
corruption.  The unwritten blocks on drives that come back online are
treated as corrupted data (csums or transid fields don't match expected
values recorded on the other drives) and btrfs will attempt to repair
them.

If you have parent transid verify failures, you are very likely to also
have correctable data errors made uncorrectable due to the above raid5/6
bug.  The two visible error cases are two different possible consequences
of the same low-level write loss events.  This means that at some point,
you had two disks offline for a while, but the other disks in the array
were still getting updates (array failures are never simple--multiple
modes of failure at different times during a single event are the norm).

If you have corrupted data on raid5/6 on btrfs, some of it won't come
back due to the data recovery corruption bug linked above.  Until this
bug is fixed, the only alternative is to restore the lost data from
backups.  Replacing the missing drive before fixing the correction bug
in the kernel will damage some more data, so data that is theoretically
readable now may be lost in the future as you replace drives; however,
losses should be 1% or less, so raid5/6 recovery in-place can still be
quicker than a full mkfs+restore for raid0.

Note that the raid5/6 write hole is a separate issue.  It's possible
for both issues to occur at the same time in a failing array, but the
correction bug will affect several orders of magnitude more data than
the write hole.

raid1 and raid1c3 have no such problems.  The parent transid verify errors
come from btrfs metadata, which in your filesystem is raid1c3, so they
would have been easily and correctly repaired as they were encountered.

> > BTW, since your free space cache is already corrupted, it's recommended
> > to clear the space cache.
> 
> It's strange to me that the free space cache is giving an error, since
> I cleared it previously and the most recent unmount was clean.

Free space cache is stored in data block groups and subject to all
of the above btrfs parity raid data integrity problems.  Do not use
space_cache=v1 with raid5 or raid6.  Better not to use space_cache=v1
at all, but v1 + raid5/6 is bad in ways that go beyond merely being slow
and unreliable.

Free space tree (space_cache=v2) is stored in btrfs metadata, so it will
work properly with raid1 or raid1c3 metadata.  Probably faster too,
and nothing can break v2 that doesn't also destroy the filesystem.

All that said, there are internal data integrity checks in free space
cache (v1), so it's possible that the only bad thing that happens here
is that you get a bunch of free space cache invalidation error messages.

> > For now, since it looks like write hole is involved, the only way to
> > solve the problem is to remove all offending files (including a super
> > large file in root 5).
> >
> > You can use `btrfs inspect logical-resolve <bytenr> <mnt>" to see all
> > the involved files.
> >
> > The full <bytenr> are the bytenr shown in btrfs check --check-data-csum
> > output.
> 
> The strange thing is if you use `btrfs inspect logical-resolve` on all
> of the bytenrs mentioned in the check output, I get that all of the
> corruption is in the same file (see http://ix.io/2cJP), but this does
> not seem consistent with the uncorrectable csum errors the scrub is
> detecting.

The uncorrectable csum errors, and changes in errors over time, are
probably the correction bug in action.  Scrub also produces highly
questionable error statistics on raid5/6.  That may be a distinct bug
from the correction/corruption bug--it's hard to tell without fixing
all the current bugs and testing again.

Note: even if scrub is fully debugged, it is limited by the btrfs
on-disk format.  Corruption in data blocks with csums can always be
corrected up to raid5/6 drive-loss limits.  nodatasum files cannot be
reliably corrected.  Free space cache will be corrupted, but btrfs
should detect this and invalidate/rebuild the cache (but don't use
space_cache=v1 anyway).  In the best case scrub will count some csum
errors against the wrong disks in some cases (though the best case
is certainly better than what scrub does now).

In a RAID5/6 stripe that is completely filled with data blocks
belonging to files that have csums, every data block in the stripe can
be individually tested against its csum.  If all the data blocks have
correct csums, but the parity block on disk does not match computed
parity of the data, then we know that the parity block is corrupted
because we eliminated every other possible corrupted block.

If one of the data blocks in a RAID5/6 stripe has an incorrect csum then
we can try to recover the data using the parity block.  If that recovered
data fails the csum check too, then we know both data and parity blocks
are corrupt, since all other blocks in the raid stripe have good csums.
RAID6 has another parity block and some more combinations to try,
but eventually ends up either recovering the entire stripe or knowing
exactly which blocks were corrupt.

If there is:

	- a data block in a RAID5/6 stripe which does not have a csum
	(either because it is unoccupied, part of free space cache,
	or part of a nodatasum file)

	- all the data blocks that do have csums in the RAID stripe
	are OK (otherwise we would know that those blocks were the
	corrupted ones)

	- a parity mismatch detected in the RAID stripe, i.e. by scrub

then btrfs cannot determine whether the parity block is corrupted or one
of the no-csum data blocks.  The parity mismatch can be detected, but any
of the drives without a csum on its data block could have contributed to
the mismatch, and there is no way to tell which no-csum data block(s) is
(are) correct.  This will cause scrub to place csum error counts on the
wrong disks, e.g. blaming the disk that happens to hold the parity block
for the raid stripe when one of the other disks is the one flipping bits.

None of this explains why scrub reports "read" errors on healthy drives
when there is data corruption on other drives.  That part is a bug, the
only question is whether it's the _same_ bug as the correction corruption
bug, and that won't be known until at least one of the bugs is fixed.

> I've been calculating the offsets of the files mentioned in the
> relocation csum errors (by adding the block group and offset),
> resolving the files with `btrfs inspect logical-resolve` and deleting
> them. But it seems like the set of files I'm deleting is also totally
> unrelated to the set of files the scrub is detecting errors in. Given
> the frequency of relocation errors, I fear I will need to delete
> almost everything on the file system for the deletion to complete. I
> can't tell if I should expect these errors to be fixable since the
> relocation isn't making any attempt to correct them as far as I can
> tell.
