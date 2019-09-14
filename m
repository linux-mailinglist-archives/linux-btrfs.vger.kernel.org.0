Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0DB299D
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 06:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfINEM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 14 Sep 2019 00:12:57 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43864 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbfINEM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 00:12:56 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E44474259C7; Sat, 14 Sep 2019 00:12:55 -0400 (EDT)
Date:   Sat, 14 Sep 2019 00:12:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190914041255.GJ22121@hungrycats.org>
References: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 05:23:21PM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> 
> > On Wed, Sep 11, 2019 at 07:21:31PM -0400, webmaster@zedlx.com wrote:
> > > 
> > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
[...etc...]
> > > > On Wed, Sep 11, 2019 at 01:20:53PM -0400, webmaster@zedlx.com wrote:
> > It's the default for GNU coreutils, and for 'mv' across subvols there
> > is currently no option to turn reflink copies off.  Maybe for 'cp'
> > you still have to explicitly request reflink, but that will presumably
> > change at some point as more filesystems get the CLONE_RANGE ioctl and
> > more users expect it to just work by default.
> 
> Yes, thank you for posting another batch of arguments that support the use
> of my vision of defrag instead of the current one.
> 
> The defrag that I'm proposing will preserve all those reflinks that were
> painstakingly created by the user. Therefore, I take that you agree with me
> on the utmost importance of implementing this new defrag that I'm proposing.

I do not agree that improving the current defrag is of utmost importance,
or indeed of any importance whatsoever.  The current defrag API is a
clumsy, unscalable hack that cannot play well with other filesystem layout
optimization tools no matter what you do to its internal implementation
details.  It's better to start over with a better design, and spend only
the minimal amount of effort required to keep the old one building until
its replacement(s) is (are) proven in use and ready for deployment.

I'm adding extent-merging support to an existing tool that already
performs several other filesystem layout optimizations.  The goal is to
detect degenerate extent layout on filesystems as it appears, and repair
it before it becomes a more severe performance problem, without wasting
resources on parts of the filesystem that do not require intervention.

Your defrag ideas are interesting, but you should spend a lot more
time learning the btrfs fundamentals before continuing.  Right now
you do not understand what btrfs is capable of doing easily, and what
requires such significant rework in btrfs to implement that the result
cannot be considered the same filesystem.  This is impairing the quality
of your design proposals and reducing the value of your contribution
significantly.

> I suggest that btrfs should first try to determine whether it can split an
> extent in-place, or not. If it can't do that, then it should create new
> extents to split the old one.

btrfs cannot split extents in place, so it must always create new
extents by copying data blocks.  It's a hugely annoying and non-trivial
limitation that makes me consider starting over with some other filesystem
quite often.

If you are looking for important btrfs work, consider solving that
problem first.  It would dramatically improve GC (in the sense that
it would eliminate the need to perform a separate GC step at all) and
dedupe performance on btrfs as well as help defrag and other extent
layout optimizers.

> Therefore, the defrag can free unused parts of any extent, and then the
> extent can be split is necessary. In fact, both these operations can be done
> simultaneously.

Sure, but I only call one of these operations "defrag" (the extent merge
operation).  The other operations increase the total number of fragments
in the filesystem, so "defrag" is not an appropriate name for them.
An appropriate name would be something like "enfrag" or "refrag" or
"split".  In some cases the "defrag" can be performed by doing a "dedupe"
operation with a single unfragmented identical source extent replacing
several fragmented destination extents...what do you call that?

> > Dedupe on btrfs also requires the ability to split and merge extents;
> > otherwise, we can't dedupe an extent that contains a combination of
> > unique and duplicate data.  If we try to just move references around
> > without splitting extents into all-duplicate and all-unique extents,
> > the duplicate blocks become unreachable, but are not deallocated.  If we
> > only split extents, fragmentation overhead gets bad.  Before creating
> > thousands of references to an extent, it is worthwhile to merge it with
> > as many of its neighbors as possible, ideally by picking the biggest
> > existing garbage-free extents available so we don't have to do defrag.
> > As we examine each extent in the filesystem, it may be best to send
> > to defrag, dedupe, or garbage collection--sometimes more than one of
> > those.
> 
> This is sovled simply by always running defrag before dedupe.

Defrag and dedupe in separate passes is nonsense on btrfs.

Defrag burns a lot of iops on defrag moving extent data around to create
new size-driven extent boundaries.  These will have to be immediately
moved again by dedupe (except in special cases like full-file matches),
because dedupe needs to create content-driven extent boundaries to work
on btrfs.

Extent splitting in-place is not possible on btrfs, so extent boundary
changes necessarily involve data copies.  Reference counting is done
by extent in btrfs, so it is only possible to free complete extents.
You have to replace the whole extent with references to data from
somewhere else, creating data copies as required to do so where no
duplicate copy of the data is available for reflink.

Note the phrase "on btrfs" appears often here...other filesystems manage
to solve these problems without special effort.  Again, if you're looking
for important btrfs things to work on, maybe start with in-place extent
splitting.

On XFS you can split extents in place and reference counting is by
block, so you can do alternating defrag and dedupe passes.  It's still
suboptimal (you still waste iops to defrag data blocks that are
immediately eliminated by the following dedupe), but it's orders of
magnitude better than btrfs.

> > As extents get bigger, the seeking and overhead to read them gets smaller.
> > I'd want to defrag many consecutive 4K extents, but I wouldn't bother
> > touching 256K extents unless they were in high-traffic files, nor would I
> > bother combining only 2 or 3 4K extents together (there would be around
> > 400K of metadata IO overhead to do so--likely more than what is saved
> > unless the file is very frequently read sequentially).  The incremental
> > gains are inversely proportional to size, while the defrag cost is
> > directly proportional to size.
> 
> "the defrag cost is directly proportional to size" - this is wrong. The
> defrag cost is proportional to file size, not to extent size.

defrag cost is proportional to target extent size (and also reflink
count on btrfs, as btrfs's reflinks are relatively heavy IO-wise).
There are other cost components in extent split and merge operations,
but they are negligible compared to the cost of relocating extent data
blocks or the constant cost of relocating an extent at all.

File size is irrelevant.  We don't need to load all the metadata for
a VM image file into RAM--a 384MB sliding window over the data is more
than enough.  We don't even care which files an extent belongs to--its
logically adjacent neighbors are just neighboring items in the subvol
metadata trees, and at EOF we just reach a branch tip on the extent
adjacency graph.

btrfs tree search can filter out old extents that were processed earlier
and not modified since.  A whole filesystem can be scanned for new
metadata changes in a few milliseconds.  Extents that require defrag
can be identified from the metadata records.  All of these operations
are fast, you can do a few hundred from a single metadata page read.

Once you start copying data blocks from one part of the disk to another,
the copying easily takes 95% of the total IO time.  Since you don't need
to copy extents when they are above the target extent size, they don't
contribute to the defrag cost.  Only the extents below the target extent
size add to the cost, and the number and cost of those are proportional
to the target extent size (on random input, bigger target size = more
extents to defrag, and the average extent is bigger).

> Before a file is defragmented, the defrag should split its extents so that
> each one is sufficiently small, let's say 32 MB at most. That fixes the
> issue. This was mentioned in my answer to Austin S. Hemmelgarn.
> 
> Then, as the final stage of the defrag, the extents should be merged into
> bigger ones of desired size.

You can try that idea on other filesystems.  It doesn't work on btrfs.
There is no in-place extent split or merge operator, and it's non-trivial
to implement one that doesn't ruin basic posix performance, or make
disk format changes so significant that the resulting filesystem can't
be called btrfs any more.

> > Also, quite a few heavily-fragmented files only ever get read once,
> > or are read only during low-cost IO times (e.g. log files during
> > maintenance windows).  For those, a defrag is pure wasted iops.
> 
> You don't know that because you can't predict the future. Therefore, defrag
> is never a waste because the future is unknown.

Sure we do.  If your DBA knows their job, they keep an up-to-date list of
table files that are write-once-read-never (where defrag is pointless)
and another list of files that get hit with full table scans all day long
(where defrag may not be enough, and you have to resort to database table
"cluster" commands).  Sometimes past data doesn't predict future events,
but not nearly often enough to justify the IO cost of blindly defragging
everything.

On machines where write iops are at 35% of capacity, trying to run defrag
will just break the machine (2x more write cost = machine does not keep
up with workload any more and gets fired).  It won't matter what you
want to do in the future if you can't physically do defrag in the present.

Quite often there is sufficient bandwidth for _some_ defrag, and if it's
done correctly, defrag can make more bandwidth available.  A sorted list
of important areas on the filesystem to defrag is a useful tool.

> > That would depend on where those extents are, how big the references
> > are, etc.  In some cases a million references are fine, in other cases
> > even 20 is too many.  After doing the analysis for each extent in a
> > filesystem, you'll probably get an average around some number, but
> > setting the number first is putting the cart before the horse.
> 
> This is a tiny detail not worthy of consideration at this stage of planning.
> It can be solved.

I thought so too, years ago.  Now I know better.  These "tiny details" are
central to doing performant layout optimization *on btrfs*, and if you're
not planning around them (or planning to fix the underlying problems
in btrfs first) then the end result is going to suck.  Or you'll plan
your way off of btrfs and onto a different filesystem, which I suppose
is also a valid way to solve the problem.

> Actually, many of the problems that you wrote about so far in this thread
> are not problems in my imagined implementation of defrag, which can solves
> them all. 

That's because your imagined implemntation of defrag runs on an equally
imaginary filesystem.  Maybe you'd like to try it out on btrfs instead?

> The problems you wrote about are mostly problems of this
> implementation/library of yours.

The library is basically a workaround for an extent-oriented application
to use file-oriented kernel API.  The library doesn't deal with core
btrfs issues, those are handled in the application.

The problem with the current kernel API starts after we determine that
we need to do something to extent E1.  The kernel API deals only with
open FDs and offsets, but E1 is a virtual block address, so we have to:

	- search backrefs for some file F1 that contains one or more
	blocks of E1

	- determine the offset O1 of the relevant parts of E1 within F1

	- find the name of F1, open it, and get a fd

	- pass (fd, O1) to the relevant kernel ioctl

	- the kernel ioctl looks up F1 and O1 to (hopefully) find E1

	- the kernel does whatever we wanted done to E1

	- if we wanted do something to all the references to E1, or if F1
	does not refer to all of E1, repeat the above for each reference
	until all of E1 is covered.

The library does the above API translation.  Ideally the kernel would
just take E1 directly from an ioctl argument, eliminating all but the
"do whatever we wanted done on E1 and/or its refs" steps.  With the
right kernel API, we'd never need to know about O1 or F1 or any of the
extent refs unless we wanted to for some reason (e.g. to pretty-print
an error message with a filename instead of a raw block address).
All the information we care about to generate the commands we issue to
the kernel is in the btrees, which can be read most efficiently directly
from the filesystem.

The rest of the problems I've described are btrfs limitations and
workarounds you will encounter when your imaginary defrag meets the cold,
hard, concrete reality of btrfs.  The library doesn't do very much about
these issues--they're baked deep into btrfs, and can't be solved by just
changing a top-level API.  If the top-level code tries to ignore the
btrfs low-level implementation details, then the resulting performance
will be catastrophically bad (i.e. you'll need to contact a btrfs expert
to recover the filesystem).

> So yes, you can do things that way as in your library, but that is inferior
> to real defrag.

Again, you're using the word "defrag", and now other words like "inferior"
or "real", in strange ways...

> Now, that split and merge just have to be moved into kernel.
>  - I would keep merge and split as separate operations.
>  - If a split cannot be performed due to problems you mention, then it
> should just return and do nothing. Same with merge.

Split and merge can be emulated on btrfs using data copies, but the costs
of the emulated implementations are not equivalent to the non-copying
implementations.  It is unwise to design higher-level code based on the
non-emulated cost model and then run it on an emulated implementation.

> > Add an operation to replace references to data at extent A with
> > references to data at extent B, and an operation to query extent reference
> > structure efficiently, and you have all the ingredients of an integrated
> > dedupe/defrag/garbage collection tool for btrfs (analogous to the XFS
> > "fsr" process).
> 
> Obviously, some very usefull code. That is good, but perhaps it would be
> better for that code to serve as an example of how it can be done.
> In my imagined defrag, this updating-of-references happens as part of
> flushing the "pending operations buffer", so it will have to be rewritten
> such that it fits into that framework.
> 
> The problem of your defrag is that it is not holistic enough. It has a view
> of only small parts of the filesystem, so it can never be as good as a real
> defrag, which also doesn't unshare extents.

The problem with a "holistic" defrag is that there is nothing such a
defrag could achieve that would be worth the cost of running even a
perfect one.  It would take 2.4 days at full wire speed on one modern
datacenter drive just to move its data even with zero metadata IO.
16TB datacenter drives come in arrays of 3.  A holistic defrag would
take weeks, minimum.

I'm explicitly not writing a defrag that considers a whole filesystem.
That's the very first optimization:  find the 10% of the work that
solves 99% of the problem, and ignore the rest due to the exponentially
increasing costs and diminishing returns.  I'm adding capabilities
to an existing collection of physical layout optimization tools to
defragment unacceptably fragmented files as soon as they appear, just
like it currently removes duplicate blocks as soon as they appear.
The framework scans entire filesystems in a single, incremental pass
taking a few milliseconds.  It tracks write activity as it occurs,
examines new metadata structures soon after they appear (hopefully while
they are still cached in host RAM), and leaves parts of the filesystem
that don't need correction alone.

> Another person said that it is complicated to trace backreferences. So now
> you are saying that it is not.

There's an ioctl, you call it and get a list of backrefs.  The in-kernel
version has a callback function that is passed each backref as
an argument.  This can involve a lot of seeking reads, but it's not
complicated to use.  The list of backrefs is _expanded_ though (it's
in the associative-array form, not the more compact tree form the data
has on disk).  If you really want that last 1% of performance, you need
to read the metadata blocks and interpret the backref tree yourself
(or add hooks to the kernel implementation).

If you know the lower bound on the number of backrefs before enumerating
all of them, you can do math and make sane tradeoffs before touching
an extent.  So if you've seen 100 backrefs and you know that the current
subvol has 20 snapshots, you know there's at least 2000 backrefs, and
you can skip processing the current extent.

> Anyway, such a structure must be available to defrag.
> So, just in case to avoid misunderstandings, this "extent-backrefs"
> associative array would be in-memory, it would cover all extents, the entire
> filesystem structure, and it would be kept in-sync with the filesystem
> during the defrag operation.

That would waste a lot of memory for no particular reason, especially
if you use an associative array instead of a DAG.  The conversion would
multiply out all the shared snapshot metadata pages.  (Yet another problem
you only have to solve on btrfs.)  e.g. my 156GB metadata filesystem,
fully expanded as an associative array, would be a PB or two of array
data assuming zero overhead for the array itself.

I did consider building exactly this a few years ago, basically pushing
the 156GB of metadata through a sort, then consuming all the data in
sequential order.  Then I did the math, and realized I don't own enough
disks to complete the sort operation.
