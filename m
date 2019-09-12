Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B919B083B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 07:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfILFT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 01:19:28 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46946 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbfILFT2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 01:19:28 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7F0D3421459; Thu, 12 Sep 2019 01:19:12 -0400 (EDT)
Date:   Thu, 12 Sep 2019 01:19:05 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     webmaster@zedlx.com
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190912051904.GD22121@hungrycats.org>
References: <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 07:21:31PM -0400, webmaster@zedlx.com wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> 
> > On Wed, Sep 11, 2019 at 01:20:53PM -0400, webmaster@zedlx.com wrote:
> > > 
> > > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> > > 
> > > > On 2019-09-10 19:32, webmaster@zedlx.com wrote:
> > > > >
> > > > > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> > > > >
> > > 
> > > > >
> > > > > === I CHALLENGE you and anyone else on this mailing list: ===
> > > > >
> > > > >  - Show me an exaple where splitting an extent requires unsharing,
> > > > > and this split is needed to defrag.
> > > > >
> > > > > Make it clear, write it yourself, I don't want any machine-made outputs.
> > > > >
> > > > Start with the above comment about all writes unsharing the region being
> > > > written to.
> > > >
> > > > Now, extrapolating from there:
> > > >
> > > > Assume you have two files, A and B, each consisting of 64 filesystem
> > > > blocks in single shared extent.  Now assume somebody writes a few bytes
> > > > to the middle of file B, right around the boundary between blocks 31 and
> > > > 32, and that you get similar writes to file A straddling blocks 14-15
> > > > and 47-48.
> > > >
> > > > After all of that, file A will be 5 extents:
> > > >
> > > > * A reflink to blocks 0-13 of the original extent.
> > > > * A single isolated extent consisting of the new blocks 14-15
> > > > * A reflink to blocks 16-46 of the original extent.
> > > > * A single isolated extent consisting of the new blocks 47-48
> > > > * A reflink to blocks 49-63 of the original extent.
> > > >
> > > > And file B will be 3 extents:
> > > >
> > > > * A reflink to blocks 0-30 of the original extent.
> > > > * A single isolated extent consisting of the new blocks 31-32.
> > > > * A reflink to blocks 32-63 of the original extent.
> > > >
> > > > Note that there are a total of four contiguous sequences of blocks that
> > > > are common between both files:
> > > >
> > > > * 0-13
> > > > * 16-30
> > > > * 32-46
> > > > * 49-63
> > > >
> > > > There is no way to completely defragment either file without splitting
> > > > the original extent (which is still there, just not fully referenced by
> > > > either file) unless you rewrite the whole file to a new single extent
> > > > (which would, of course, completely unshare the whole file).  In fact,
> > > > if you want to ensure that those shared regions stay reflinked, there's
> > > > no way to defragment either file without _increasing_ the number of
> > > > extents in that file (either file would need 7 extents to properly share
> > > > only those 4 regions), and even then only one of the files could be
> > > > fully defragmented.
> > > >
> > > > Such a situation generally won't happen if you're just dealing with
> > > > read-only snapshots, but is not unusual when dealing with regular files
> > > > that are reflinked (which is not an uncommon situation on some systems,
> > > > as a lot of people have `cp` aliased to reflink things whenever
> > > > possible).
> > > 
> > > Well, thank you very much for writing this example. Your example is
> > > certainly not minimal, as it seems to me that one write to the file A and
> > > one write to file B would be sufficient to prove your point, so there we
> > > have one extra write in the example, but that's OK.
> > > 
> > > Your example proves that I was wrong. I admit: it is impossible to perfectly
> > > defrag one subvolume (in the way I imagined it should be done).
> > > Why? Because, as in your example, there can be files within a SINGLE
> > > subvolume which share their extents with each other. I didn't consider such
> > > a case.
> > > 
> > > On the other hand, I judge this issue to be mostly irrelevant. Why? Because
> > > most of the file sharing will be between subvolumes, not within a subvolume.
> > > When a user creates a reflink to a file in the same subvolume, he is
> > > willingly denying himself the assurance of a perfect defrag. Because, as
> > > your example proves, if there are a few writes to BOTH files, it gets
> > > impossible to defrag perfectly. So, if the user creates such reflinks, it's
> > > his own whish and his own fault.
> > > 
> > > Such situations will occur only in some specific circumstances:
> > > a) when the user is reflinking manually
> > > b) when a file is copied from one subvolume into a different file in a
> > > different subvolume.
> > > 
> > > The situation a) is unusual in normal use of the filesystem. Even when it
> > > occurs, it is the explicit command given by the user, so he should be
> > > willing to accept all the consequences, even the bad ones like imperfect
> > > defrag.
> > > 
> > > The situation b) is possible, but as far as I know copies are currently not
> > > done that way in btrfs. There should probably be the option to reflink-copy
> > > files fron another subvolume, that would be good.
> > 
> > Reflink copies across subvolumes have been working for years.  They are
> > an important component that makes dedupe work when snapshots are present.
> 
> I take that what you say is true, but what I said is that when a user (or
> application) makes a
> normal copy from one subvolume to another, then it won't be a reflink-copy.
> To make such a reflink-copy, you need btrfs-aware cp or btrfs-aware
> applications.

It's the default for GNU coreutils, and for 'mv' across subvols there
is currently no option to turn reflink copies off.  Maybe for 'cp'
you still have to explicitly request reflink, but that will presumably
change at some point as more filesystems get the CLONE_RANGE ioctl and
more users expect it to just work by default.

> So, the reflik-copy is a special case, usually explicitly requested by the
> user.
> 
> > > But anyway, it doesn't matter. Because most of the sharing will be between
> > > subvolumes, not within subvolume.
> > 
> > Heh.  I'd like you to meet one of my medium-sized filesystems:
> > 
> > 	Physical size:  8TB
> > 	Logical size:  16TB
> > 	Average references per extent:  2.03 (not counting snapshots)
> > 	Workload:  CI build server, VM host
> > 
> > That's a filesystem where over half of the logical data is reflinks to the
> > other physical data, and 94% of that data is in a single subvol.  7.5TB of
> > data is unique, the remaining 500GB is referenced an average of 17 times.
> > 
> > We use ordinary applications to make ordinary copies of files, and do
> > tarball unpacks and source checkouts with reckless abandon, all day long.
> > Dedupe turns the copies into reflinks as we go, so every copy becomes
> > a reflink no matter how it was created.
> > 
> > For the VM filesystem image files, it's not uncommon to see a high
> > reflink rate within a single file as well as reflinks to other files
> > (like the binary files in the build directories that the VM images are
> > constructed from).  Those reference counts can go into the millions.
> 
> OK, but that cannot be helped: either you retain the sharing structure with
> imperfect defrag, or you unshare and produce a perfect defrag which should
> have somewhat better performance (and pray that the disk doesn't fill up).

One detail that might not have been covered in the rest of the discussion
is that btrfs extents are immutable.  e.g. if you create a 128MB file,
then truncate it to 4K, it still takes 128MB on disk because that 4K
block at the beginning holds a reference to the whole immutable 128MB
extent.  This holds even if the extent is not shared.  The 127.996MB of
unreferenced extent blocks are unreachable until the last 4K reference
is removed from the filesystem (deleted or overwritten).

There is no "split extent in place" operation on btrfs because the
assumption that extents are immutable is baked into the code.  Changing
this has been discussed a few times.  The gotcha is that some fairly
ordinary write cases can trigger updates of all extent references if
extents were split automatically as soon as blocks become unreachable.
There's non-trivial CPU overhead to determine whether blocks are
unreachable, making it unsuitable to run the garbage collector during
ordinary writes.  So for now, the way to split an extent is to copy the
data you want to keep from the extent into some new extents, then remove
all references to the old extent.

To maintain btrfs storage efficiency you have to do a *garbage collection*
operation that there is currently no tool for.  This tool would find
unreachable blocks and split extents around them, releasing the entire
extent (including unreachable blocks) back to the filesystem.  Defrag is
sometimes used for its accidental garbage collection side-effects (it
will copy all the remaining reachable blocks to new extents and reduce
total space usage if the extens were not shared), but the current defrag
is not designed for GC, and doesn't do a good job.

Dedupe on btrfs also requires the ability to split and merge extents;
otherwise, we can't dedupe an extent that contains a combination of
unique and duplicate data.  If we try to just move references around
without splitting extents into all-duplicate and all-unique extents,
the duplicate blocks become unreachable, but are not deallocated.  If we
only split extents, fragmentation overhead gets bad.  Before creating
thousands of references to an extent, it is worthwhile to merge it with
as many of its neighbors as possible, ideally by picking the biggest
existing garbage-free extents available so we don't have to do defrag.
As we examine each extent in the filesystem, it may be best to send
to defrag, dedupe, or garbage collection--sometimes more than one of
those.

As extents get bigger, the seeking and overhead to read them gets smaller.
I'd want to defrag many consecutive 4K extents, but I wouldn't bother
touching 256K extents unless they were in high-traffic files, nor would I
bother combining only 2 or 3 4K extents together (there would be around
400K of metadata IO overhead to do so--likely more than what is saved
unless the file is very frequently read sequentially).  The incremental
gains are inversely proportional to size, while the defrag cost is
directly proportional to size.

> > > So, if there is some in-subvolume sharing,
> > > the defrag wont be 100% perfect, that a minor point. Unimportant.
> > 
> > It's not unimportant; however, the implementation does have to take this
> > into account, and make sure that defrag can efficiently skip extents that
> > are too expensive to relocate.  If we plan to read an extent fewer than
> > 100 times, it makes no sense to update 20000 references to it--we spend
> > less total time just doing the 100 slower reads.
> 
> Not necesarily. Because you can defrag in the time-of-day when there is a
> low pressure on the disk IO, so updating 20000 references is esentially
> free.
> 
> You are just making those later 100 reads faster.
> 
> OK, you are right, there is some limit, but this is such a rare case, that
> such a heavily-referenced extents are best left untouched.

For you it's rare.  For other users, it's expected behavior--dedupe is
just a thing many different filesystems do now.

Also, quite a few heavily-fragmented files only ever get read once,
or are read only during low-cost IO times (e.g. log files during
maintenance windows).  For those, a defrag is pure wasted iops.

> I suggest something along these lines: if there are more than XX (where XX
> defaults to 1000) reflinks to an extent, then one or more copies of the
> extent should be made such that each has less than XX reflinks to it. The
> number XX should be user-configurable.

That would depend on where those extents are, how big the references
are, etc.  In some cases a million references are fine, in other cases
even 20 is too many.  After doing the analysis for each extent in a
filesystem, you'll probably get an average around some number, but
setting the number first is putting the cart before the horse.

> > If the numbers are
> > reversed then it's better to defrag the extent--100 reference updates
> > are easily outweighed by 20000 faster reads.  The kernel doesn't have
> > enough information to make good decisions about this.
> 
> So, just make the number XX user-provided.
> 
> > Dedupe has a similar problem--it's rarely worth doing a GB of IO to
> > save 4K of space, so in practical implementations, a lot of duplicate
> > blocks have to remain duplicate.
> > 
> > There are some ways to make the kernel dedupe and defrag API process
> > each reference a little more efficiently, but none will get around this
> > basic physical problem:  some extents are just better off where they are.
> 
> OK. If you don't touch those extents, they are still shared. That's what I
> wanted.
> 
> > Userspace has access to some extra data from the user, e.g.  "which
> > snapshots should have their references excluded from defrag because
> > the entire snapshot will be deleted in a few minutes."  That will allow
> > better defrag cost-benefit decisions than any in-kernel implementation
> > can make by itself.
> 
> Yes, but I think that we are going into too much details which are diverting
> the attention from the overall picture and from big problems.
> 
> And the big problem here is: what do we want defrag to do in general, most
> common cases. Because we haven't still agreed on that one since many of the
> people here are ardent followers of the defrag-by-unsharing ideology.

Well, that's the current implementation, so most people are familiar with it.

I have a userspace library that lets applications work in terms of extents
and their sequential connections to logical neighbors, which it extracts
from the reference data in the filesystem trees.  The caller says "move
extent A50..A70, B10..B20, and C90..C110 to a new physically contiguous
location" and the library translates that into calls to the current kernel
API to update all the references to those extents, at least one of which
is a single contiguous reference to the entire new extent.  To defrag,
it walks over extent adjacency DAGs and connects short extents together
into longer ones, and if it notices opportunities to get rid of extents
entirely by dedupe then it does that instead of defrag.  Extents with
unreachable blocks are garbage collected.  If I ever get it done, I'll
propose the kernel provide the library's top-level interface directly,
then drop the userspace emulation layer when that kernel API appears.

> > 'btrfs fi defrag' is just one possible userspace implementation, which
> > implements the "throw entire files at the legacy kernel defrag API one
> > at a time" algorithm.  Unfortunately, nobody seems to have implemented
> > any other algorithms yet, other than a few toy proof-of-concept demos.
> 
> I really don't have a clue what's happening, but if I were to start working
> on it (which I won't), then the first things should be:

> - creating a way for btrfs to split large extents into smaller ones (for
> easier defrag, as first phase).

> - creating a way for btrfs to merge small adjanced extents shared by the
> same files into larger extents (as the last phase of defragmenting a file).

Those were the primitives I found useful as well.  Well, primitive,
singular--in the absence of the ability to split an extent in place,
the same function can do both split and merge operations.  Input is a
list of block ranges, output is one extent containing data from those
block ranges, side effect is to replace all the references to the old
data with references to the new data.

Add an operation to replace references to data at extent A with
references to data at extent B, and an operation to query extent reference
structure efficiently, and you have all the ingredients of an integrated
dedupe/defrag/garbage collection tool for btrfs (analogous to the XFS
"fsr" process).

> - create a structure (associative array) for defrag that can track
> backlinks. Keep the structure updated with each filesystem change, by
> placing hooks in filesystem-update routines.

No need.  btrfs already maintains backrefs--they power the online device shrink
feature and the LOGICAL_TO_INO ioctl.

> You can't go wrong with this. Whatever details change about defrag
> operation, the given three things will be needed by defrag.

I agree about 70% with what you said.  ;)

> > > Now, to retain the original sharing structure, the defrag has to change the
> > > reflink of extent E55 in file B to point to E70. You are telling me this is
> > > not possible? Bullshit!
> > 
> > This is already possible today and userspace tools can do it--not as
> > efficiently as possible, but without requiring more than 128M of temporary
> > space.  'btrfs fi defrag' is not one of those tools.
> > 
> > > Please explain to me how this 'defrag has to unshare' story of yours isn't
> > > an intentional attempt to mislead me.
> > 
> > Austin is talking about the btrfs we have, not the btrfs we want.
> 
> OK, but then, you agree with me that current defrag is a joke. I mean,
> something is better than nothing, and the current defrag isn't completely
> useless, but it is in most circumstances either unusable or not good enough.

I agree that the current defrag is almost useless.  Where we might
disagree is that I don't think the current defrag can ever be useful,
even if it did update all the references simultaneously.

> I mean, the snapshots are a prime feature of btrfs. If not, then why bother
> with b-trees? If you wanted subvolumes, checksums and RAID, then you should
> have made ext5. B-trees are in btrfs so that there can be snapshots. But,
> the current defrag works bad with snaphots. It doesn't defrag them well, it
> also unshares data. Bad bad bad.
> 
> And if you wanted to be honest to your users, why don't you place this info
> in the wiki? Ok, the wiki says "defrag will unshare", but it doesn't say
> that it also doesn't defragment well.

"Well" is the first thing users have trouble with.  They generally
overvalue defragmentation because they don't consider the costs.

There's a lower bound _and_ an upper bound on how big fragments can
usefully be.  The lower bound is somewhere around 100K (below that size
there is egregious seek and metadata overhead), and the upper bound is
a few MB at most, with a few special exceptions like torrent downloads
(where a large file is written in random order, then rearranged into
contiguous extents and never written again).  If you strictly try to
minimize the number of fragments, you can make a lot of disk space
unreachable without garbage collection.  Up to 32768 times the logical
file size can theoretically be wasted, though 25-200% is more common
in practice.  The bigger your target extent size, the more frequently
you have to defrag to maintain disk space usage at reasonable levels,
and the less benefit you get from each defrag run.

> For example, lets examine the typical home user. If he is using btrfs, it
> means he probably wants snapshots of his data. And, after a few snapshots,
> his data is fragmented, and the current defrag can't help because it does a
> terrible job in this particualr case.

I'm not sure I follow.  Snapshots don't cause data fragmentation.
Discontiguous writes do (unless the filesystem is very full and the
only available free areas are small--see below).  The data will be
fragmented or not depending on the write pattern, not the presence or
absence of snapshots.  On the other hand, if snapshots are present, then
(overly aggressive) defrag will consume a large amount of disk space.
Maybe that's what you're getting at.

If the filesystem is very full and all free space areas are small,
you want to use balance to move all the data closer together so that
free space areas get bigger.  Defrag is the wrong tool for this.
Balance handles shared extent references just fine.

> So why don't you write on the wiki "the defrag is practically unusable in
> case you use snapshots". Because that is the truth. Be honest.

It depends on the size of the defragmented data.  If the only thing
you need to defrag is systemd journal files and the $HOME/.thunderbird
directory, then you can probably afford to store a few extra copies of
those on the disk.  It won't be possible to usefully defrag files like
those while they have shared extents anyway--too many small overlaps.

If you have a filesystem full of big VM image files then there's no
good solution yet.
