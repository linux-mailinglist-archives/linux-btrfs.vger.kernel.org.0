Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B804212E85
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 23:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGBVKP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 2 Jul 2020 17:10:15 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35216 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBVKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 17:10:14 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id AB6F57435F3; Thu,  2 Jul 2020 17:10:13 -0400 (EDT)
Date:   Thu, 2 Jul 2020 17:10:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200702211013.GC10769@hungrycats.org>
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
 <20200702033016.GA10769@hungrycats.org>
 <de43532c-10eb-4d4b-da6c-1110666d3a08@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <de43532c-10eb-4d4b-da6c-1110666d3a08@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 11:35:00AM -0400, Josef Bacik wrote:
> On 7/1/20 11:30 PM, Zygo Blaxell wrote:
> > On Wed, Jul 01, 2020 at 03:53:40PM -0400, Josef Bacik wrote:
> > > The one thing I _do_ want to do is make better use of the backup roots.
> > > Right now we always free the pinned extents once the transaction commits,
> > > which makes the backup roots useless as we're likely to re-use those blocks.
> > > With Nikolay's patches we can now async drop pinned extents, which I've
> > > implemented here for an unrelated issue.  We could take that work and simply
> > > hold pinned extents for several transactions so that old backup roots and
> > > all of their nodes don't get over-written until they cycle out.  This would
> > > go a long way towards making us more resilient under metadata corruption
> > > conditions.  Thanks,
> > 
> > I have questions about this:  That would probably increase the size
> > required for global reserve?  RAM requirements for the pinned list?
> > What impact does this have when space is low, e.g. deleting a snapshot
> > on a full filesystem?  There are probably answers to these, but it
> > might mean spending some time making sure all the ENOSPC cases are
> > still recoverable.
> 
> There's RAM requirements but they're low, its just a range tree with the
> bits set that need to be unpinned.  We wouldn't have to increase the size
> required for global reserve.
> 
> Right now the way we deal with pinned extents is to commit the transaction,
> because once the transaction is committed all pinned extents are unpinned.
> Nikolay made it so we have a per-transaction pinned tree now instead of two
> that we flip flop on.
> 
> That enables us to async off the unpinning.  I've been doing that internally
> with WhatsApp because they see a huge amount of latency with unpinning.  My
> version of this still works fine with the transaction part, because we wait
> for the transaction to "complete", which only gets set once the unpin
> mechanism is done.  So although it's asynchronous, we still get the same
> behavior from an enospc perspective.

That's interesting...does it mean that we do fewer reads in the critical
part of transaction commit too?  Like if we remove the last reference to
an extent, can we delete the extent and the csum item for the extent in
the background, while new transactions are running?  That would have a
huge latency benefit (which I guess is what WhatsApp wanted), regardless
of the effect on robustness.

> What I would do for this case is delay 4 transactions worth of pinned
> extents. Once we commit the 5th transaction, we unpin the oldest guy because
> we no longer need him.
> 
> But this creates ENOSPC issues, because now we have decoupled the
> transaction commit from the pinned extent thing.  But that's ok, we know
> where our pinned space is now.  So we just add a new flushing state that we
> start walking through the unpin list and unpinning stuff until our
> reservations are satisfied.

So under ENOSPC we smoothly transition back to current behavior.  Got it.

> Now this does mean that under a space crunch we're going to not be saving
> our old roots as well because we'll be re-using them, but that's the same
> situation that we have currently.  Most normal users will have plenty of
> space and thus will get the benefit of being able to recovery from the
> backup roots.  It's not a perfect solution, but it's muuuuch better than
> what we have currently.

I agree that's quantitatively better than 'btrfs gets destroyed
by an unclean shutdown on some drives', but it would mean that firmware
bug root corruption correlates with low disk space.  So it would be
"btrfs gets destroyed by an unclean shutdown while low on disk space on
some drives."  I guess it depends on where you want to draw the line on
support for hard drives that belong in the recycle bin.

> > What we really need is a usable fsck (possibly online or an interactive
> > tool) that can put a filesystem back together quickly when only a few
> > hundred metadata pages are broken.  The vast majority of btrfs filesystems
> > I've seen killed were due btrfs and Linux kernel bugs, e.g. that delayed
> > reloc_roots bug in 5.1.  Second place is RAM failure leading to memory
> > corruption (a favorite in #btrfs IRC).  Third is disk failure beyond
> > array limits (mostly on SD cards, nothing btrfs can do when the whole
> > disk fails).  Firmware bugs in the disk eating the metadata is #4 (it
> > happens, but not often).  Keeping backup trees on the disk longer will
> > only help in the 4th case.  All of the other cases involve damage to trees
> > that were committed long ago, where none of the backup roots will work.
> > 
> Yeah I think we need to be smarter about detecting these cases with btrfsck.
> Like there's good reason to not default to --init-extent-tree or
> --init-csum-tree.  But if you can't read those roots at all?  Why make the
> user have to figure that stuff out?  --repair should be able to say "oh well
> these trees are just completely fucked, --init-extent-tree is getting turned
> on", without the user needing to know how to do it.  Thanks,

That...isn't the direction I was thinking of.  '--init-csum-tree' burns
the data integrity checking in btrfs.  If you're going to do that, you
might as well just restore from backups, at least you know then that the
data wasn't corrupted by whatever corrupted the metadata on the same disk.

There have been some historical btrfs bugs where there's supposed to
be a csum item and there isn't, or there's not supposed to be a csum
item and there is.  Ideally, we'd have a way to tell btrfs check or the
kernel on a mounted filesystem "yes we know there's no csums for block
XYZ, we give permission to compute and insert (delete) those missing
(extra) csum items in this instance" so we don't have to take the
filesystem offline and let btrfs check spend days trying to discover
the one missing csum item on its own.

--init-extent-tree, sure, brute force scan and rebuild of all the subvol
metadata is the general solution to fix the extent tree.  If you keep the
csum tree, you can check your work afterwards.  If the disk is corrupting
one page, it's likely to corrupt several.  btrfs check should not (by
default) prevent scrub from providing a list of corrupted data blocks
when it's done.

I'm thinking more of the cases where there's 150GB of metadata,
and something went wrong with an extent data item in one leaf node.
--init-extent-tree will work, but it's massive overkill.  It currently
takes more than 11 days to run btrfs check on such filesystems (11 days
amount of time it takes to build a new filesystem from backups, then turn
off and wipe the server that has been making no visible progress after
running btrfs check for 11 days).  In some cases I can just delete the
offending items in a hex editor and all is well again (it takes hours to
do by hand, but still beats 11 days).  It would be nice to have the kernel
print a message like 'please run "btrfs check --repair --broken-nodes
1434238885120,4125924810240" and try again' so btrfs check doesn't have
to read the whole metadata to find and fix a single-page problem.

> Josef
