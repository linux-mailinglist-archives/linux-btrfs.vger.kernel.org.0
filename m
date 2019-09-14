Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A69B2D59
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 01:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfINXjO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 14 Sep 2019 19:39:14 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45558 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbfINXjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 19:39:14 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 45A7F427226; Sat, 14 Sep 2019 19:39:12 -0400 (EDT)
Date:   Sat, 14 Sep 2019 19:39:12 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        General Zed <general-zed@zedlx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190914233912.GA24379@hungrycats.org>
References: <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <fdec5a56-8337-4cfb-4d07-425e8785102d@gmail.com>
 <CAJCQCtQ9729my4i2hdqwyTD-PVhsQk8cRaTg9vbDT4Yn2s7SAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJCQCtQ9729my4i2hdqwyTD-PVhsQk8cRaTg9vbDT4Yn2s7SAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 14, 2019 at 12:29:09PM -0600, Chris Murphy wrote:
> On Fri, Sep 13, 2019 at 5:04 AM Austin S. Hemmelgarn
> <ahferroin7@gmail.com> wrote:
> >
> > Do you have a source for this claim of a 128MB max extent size?  Because
> > everything I've seen indicates the max extent size is a full data chunk
> > (so 1GB for the common case, potentially up to about 5GB for really big
> > filesystems)
> 
> Yeah a block group can be a kind of "super extent". I think the
> EXTENT_DATA maxes out at 128M but they are often contiguous, for
> example
> 
>     item 308 key (5741459 EXTENT_DATA 0) itemoff 39032 itemsize 53
>         generation 241638 type 1 (regular)
>         extent data disk byte 193851400192 nr 134217728
>         extent data offset 0 nr 134217728 ram 134217728
>         extent compression 0 (none)
>     item 309 key (5741459 EXTENT_DATA 134217728) itemoff 38979 itemsize 53
>         generation 241638 type 1 (regular)
>         extent data disk byte 193985617920 nr 134217728
>         extent data offset 0 nr 134217728 ram 134217728
>         extent compression 0 (none)
>     item 310 key (5741459 EXTENT_DATA 268435456) itemoff 38926 itemsize 53
>         generation 241638 type 1 (regular)
>         extent data disk byte 194119835648 nr 134217728
>         extent data offset 0 nr 134217728 ram 134217728
>         extent compression 0 (none)
> 
> Where FIEMAP has a different view (via filefrag -v)
> 
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..  131071:   47327002..  47458073: 131072:
>    1:   131072..  294911:   47518701..  47682540: 163840:   47458074:
>    2:   294912..  360447:   50279681..  50345216:  65536:   47682541:
>    3:   360448..  499871:   50377984..  50517407: 139424:   50345217: last,eof
> Fedora-Workstation-Live-x86_64-31_Beta-1.1.iso: 4 extents found
> 
> Those extents are all bigger than 128M. But they're each made up of
> contiguous EXTENT_DATA items.
> 
> Also, the EXTENT_DATA size goes to a 128K max for any compressed
> files, so you get an explosive number of EXTENT_DATA items on
> compressed file systems, and thus metadata to rewrite.

The compressed extents tend to be physically contiguous as well, so
quantitatively they aren't much of a problem.  There's more space used in
metadata, but that is compensated by less space in data.  In the subvol
trees, logically contiguous extents are always logically contiguous by
key order, so they are packed densely in subvol metadata pages.

In extent, csum, and free space trees, when there is physical
contiguity--or just proximity--the extent's items are packed into the
same metadata pages, keeping their costs down.  That's true of all
small extents, not just compressed ones.  Note that contiguity isn't
necessary for metadata space efficiency--the extents just have to be
close together, they don't need to be seamless, or in order (at least
not for this reason).

Writes that are separated in _time_ are a different problem, and
potentially much worse than the compression case.  If you have a file that
consists of lots of extents that were written with significant allocations
to other files between them, that file becomes a metadata monster that
can create massive commit latencies when it is deleted or modified.
If you unpack tarballs or build sources or rsync backup trees or really
any two or more writing tasks at the same time on a big btrfs filesystem,
you can run into cases where the metadata:data ratio goes above 1.0 during
updates _and_ the metadata is randomly distributed physically.  Commits
after a big delete run for hours.

> I wonder if instead of a rewrite of defragmenting, if there could be
> improvements to the allocator to write bigger extents. I guess the
> problem really comes from file appends? Smarter often means slower but
> perhaps it could be a variation on autodefrag?

Physically dispersed files can be fixed by defrag, but directory trees
are a little different.  The current defrag doesn't look at the physical
distances between files, only the extents within a single file, so it
doesn't help when you have a big fragmented directory tree of many small
not-fragmented files.  IOW defrag helps with 'rm -f' performance but not
'rm -rf' performance.

Other filesystems have allocator heuristics that reserve space near
growing files, or try to pre-divide the free space to spread out
files belonging to different directories or created by two processes.
This is an attempt to fix the problem before it occurs, and sometimes
it works; however, the heuristics have to match the reality or it just
makes things worse, and extra complexity breeds bugs, e.g. the fix
recently for a bug which tried to give every thread its own block group
for allocation--i.e. 20 threads writing 4K each could ENOSPC if there
was less than 20GB of unallocated space.

I think the best approach may be to attack the problem quantitatively
with an autodefrag agent:  keep the write path fast and simple, but
detect areas where problems are occurring--i.e. where the ratio of extent
metadata locality to physical locality is low--and clean them up with
some minimal data relocation.  Note that's somewhat different from what
the current kernel autodefrag does.

In absolute terms autodefrag is worse--ideally we'd just put the data
in the right place from the start, not write it in the wrong place
then spend more iops fixing it later--but not all iops have equal cost.
In some cases there is an opportunity to trade cheap iops at one time
for expensive iops at a different time, and a userspace agent can invest
more time, memory, and code complexity on that trade than the kernel.

Some back-of-the-envelope math says we don't need to do very much
post-processing work to deal with the very worst cases:  keep extent
sizes over a few hundred KB, and keep small files not more than about
5-10 metadata items away from their logical neighbors, and we avoid the
worst-case 12.0 metadata-to-data ratios during updates.  Compared to
those, other inefficiencies are trivial.

> 
> -- 
> Chris Murphy
> 
