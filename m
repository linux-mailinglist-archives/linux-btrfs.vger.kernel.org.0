Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F01211A9D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 05:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGBDaT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Jul 2020 23:30:19 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36876 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBDaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 23:30:19 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B40FB741809; Wed,  1 Jul 2020 23:30:17 -0400 (EDT)
Date:   Wed, 1 Jul 2020 23:30:17 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200702033016.GA10769@hungrycats.org>
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 03:53:40PM -0400, Josef Bacik wrote:
> On 7/1/20 3:43 PM, waxhead wrote:
> > 
> > 
> > Josef Bacik wrote:
> > > One of the things that came up consistently in talking with Fedora about
> > > switching to btrfs as default is that btrfs is particularly vulnerable
> > > to metadata corruption.  If any of the core global roots are corrupted,
> > > the fs is unmountable and fsck can't usually do anything for you without
> > > some special options.
> > > 
> > > Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> > > what it really does is just allow you to operate without an extent root.
> > > However there are a lot of other roots, and I'd rather not have to do
> > > 
> > > mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> > > 
> > > Instead take his original idea and modify it so it just works for
> > > everything.  Turn it into rescue=onlyfs, and then any major root we fail
> > > to read just gets left empty and we carry on.
> > > 
> > > Obviously if the fs roots are screwed then the user is in trouble, but
> > > otherwise this makes it much easier to pull stuff off the disk without
> > > needing our special rescue tools.  I tested this with my TEST_DEV that
> > > had a bunch of data on it by corrupting the csum tree and then reading
> > > files off the disk.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > 
> > Just an idea inspired from RAID1c3 and RAID1c3, how about introducing
> > DUP2 and/or even DUP3 making multiple copies of the metadata to increase
> > the chance to recover metadata on even a single storage device?

I don't think extra dup copies are very useful.  The disk firmware
behavior that breaks 2-copy dup will break 3-copy and 4-copy too.

> Because this only works on HDD.  On SSD's concurrent writes will often be
> shunted to the same erase block, and if the whole erase block goes, so do
> all of your copies.  This is why we default to 'single' for SSD's.

That's true on higher end SSDs that have "data reduction" feature sets
(compress and dedupe).  In theory these drives could dedupe metadata
pages even if they are slightly different, so schemes like labelling the
two dup copies won't work.  A sufficiently broken flash page will wipe
out both metadata copies, possibly even if you arrange a delay buffer
to write both copies several minutes apart.

On low-end SSD, though, there's not only no dedupe, there's also plenty of
single-bit (or sector) errors that don't destroy both copies of metadata.
It's one of the reasons why low-end drives have the write endurance of
mayflies compared to their high-end counterparts--even with the same
flash technology underneath, the high-end drives do clever things behind
the scenes, while the low-end drives just write every sector they're told
to, and the resulting TBW lifespan is very different.  I've had Kingston
SSDs recover from several single-sector csum failure events in btrfs
metadata blocks thanks to dup metadata.  Those would have been 'mkfs &
start over' events had I used default mkfs options with single metadata.

Dup metadata should be the default on all single-drive filesystems.
Single metadata should be reserved for extreme performance/robustness
tradeoffs, like the nobarrier mount option, where the filesystem is not
intended to survive a crash.  Dup metadata won't affect write endurance
or robustness on drives that dedupe writes, but it can save a filesystem
from destruction on drives that don't.

I think we might want to look into having some kind of delayed write
buffer to spread out writes to the same disk over a sufficiently long
period of time to defeat various firmware bugs.  e.g. I had a filesystem
killed by WD Black (HDD) firmware when it mishandled a UNC sector and
dropped the write cache during error handling.  If the two metadata copies
had been written on either side of the UNC error, the filesystem would
have survived, but since both metadata copies were destroyed by the
firmware bug, the filesystem was lost.

> The one thing I _do_ want to do is make better use of the backup roots.
> Right now we always free the pinned extents once the transaction commits,
> which makes the backup roots useless as we're likely to re-use those blocks.
> With Nikolay's patches we can now async drop pinned extents, which I've
> implemented here for an unrelated issue.  We could take that work and simply
> hold pinned extents for several transactions so that old backup roots and
> all of their nodes don't get over-written until they cycle out.  This would
> go a long way towards making us more resilient under metadata corruption
> conditions.  Thanks,

I have questions about this:  That would probably increase the size
required for global reserve?  RAM requirements for the pinned list?
What impact does this have when space is low, e.g. deleting a snapshot
on a full filesystem?  There are probably answers to these, but it
might mean spending some time making sure all the ENOSPC cases are
still recoverable.

Increasing the number of viable backup roots can work if we can figure
out how many trees we need to keep, but for real drives it's probably
the number and temporal spacing of pages written that matters, not
the number of transactions (assuming the drives just ignore write
barriers--if they didn't, then there's no need to keep backup roots
at all).  A full filesystem can get lots of short transactions, so if
the disk firmware bug is "throw the last 500 ms of ACKed writes away"
then keeping the last 8 trees committed in 50 ms each will not help,
because all of those as well as the 9th and 10th trees will be broken.
Same problem for fsync and the log tree, if the disk is going to corrupt
metadata it will corrupt data too.

What we really need is a usable fsck (possibly online or an interactive
tool) that can put a filesystem back together quickly when only a few
hundred metadata pages are broken.  The vast majority of btrfs filesystems
I've seen killed were due btrfs and Linux kernel bugs, e.g. that delayed
reloc_roots bug in 5.1.  Second place is RAM failure leading to memory
corruption (a favorite in #btrfs IRC).  Third is disk failure beyond
array limits (mostly on SD cards, nothing btrfs can do when the whole
disk fails).  Firmware bugs in the disk eating the metadata is #4 (it
happens, but not often).  Keeping backup trees on the disk longer will
only help in the 4th case.  All of the other cases involve damage to trees
that were committed long ago, where none of the backup roots will work.

> Josef
