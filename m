Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F61200182
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 07:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgFSFEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 01:04:07 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33956 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFSFEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 01:04:06 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0B3727211DC; Fri, 19 Jun 2020 01:04:03 -0400 (EDT)
Date:   Fri, 19 Jun 2020 01:04:03 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     DanglingPointer <danglingpointerexception@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <20200619050402.GN10769@hungrycats.org>
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org>
 <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 19, 2020 at 08:05:44AM +1000, DanglingPointer wrote:
> For a large portion of desktop users that are not developers and are
> rustlang illiterate and programming illiterate; they would not now whether
> this tool or that tool or any tool would be safe, or unsafe, or have
> concurrent race conditions, or know the meaning of immutable or mutex.
> 
> Think of this scenario; average Joe Bloggs user buys new computer without MS
> Windows.  With the software savings, Joe purchases more disks. He then
> chooses openSuse Leap for his first foray into Linux.
> All he cares about are his music files, photos, and videos being safe.  Joe
> runs a Cafe down the street and uses the music, photos, and videos in
> various screens at his cafe for the atmosphere.
> Times are tough and he's running out of space so he doesn't want the
> accumulate media files duplicated all around the place wasting space to
> conserve storage.
> 
> If the official wikis have broken 3rd party tools, then it makes the whole
> adoption process less easy, less friendly, very cryptic, more chaotic; and
> give the impression that btrfs is a mess and not ready (and Linux as a
> whole).  He would not know or have the time to go through the code of each
> deduplication program tool option to figure out if one type or the other
> type is better just like Zygo Blaxell did who can read code.  Even if he
> wanted to, he doesn't know how to nor has the time to do it.  He says
> good-bye to openSuse and buys Windows.

My objection here is the serious accusation in the term "data loss", which
you have made on the mailing list and github without supporting evidence.

Joe Bloggs will not lose any data from btrfs-dedupe.  He'll waste his
time and run out of disk space, and maybe switch filesystems due to
frustration, but Joe will not lose any of his data.

btrfs-dedupe has not had new commits in years and no longer builds on
today's Rust.  Those facts alone would have been sufficient to justify
removing it from the wiki.  We have far too many real data loss bugs in
btrfs already.  There is no need to spread rumors about new ones just
to push changes through.

It might be nice to keep btrfs-dedupe and bedup _somewhere_ on the wiki,
clearly marked as not supported and only of historical interest to new
developers.  I learned a lot about what is possible on btrfs from bedup
in particular (bees was initially a project to combine the features of
bedup and duperemove), and python is accessible to more developers than
C or C++.  btrfs-dedupe was the first btrfs dedupe agent to combine
defrag and dedupe operations into a single program.

> So I do agree with waxhead.  It would be preferable if there were an
> official btrfs deduplication command from btrfs-progs instead of relying on
> 3rd parties.  Joe Bloggs example above can read a web-page instructions
> saying "run this command... and then this command..."; but he will not have
> the knowledge, nor comprehension nor time to go through code.

Which of the available candidates for "official btrfs dedupe" would you
put in btrfs-progs?  I see a lot of runners in the race, but no clear
winner yet.

duperemove is the closest to Waxhead's proposed "-r /somewhere" syntax.
It's the obvious choice:  written in the same language as btrfs-progs, and
also the oldest btrfs deduper, and it has years of patient, data-driven
optimization built in.  If there wasn't some insurmountable reason
why duperemove can't be merged with btrfs-progs, then it would have
happened already, so there must be a reason why this can't ever happen
(which might be as simple as neither maintainer wants to merge).
Maybe we put duperemove at the top of the Wiki page, as it has the
simplest command-line for Joe Blogger's use case, and it's relatively
easy to build for the few people who use distros where it's not packaged.

The stub support for in-kernel dedupe (arguably the only "official"
btrfs dedupe so far) has been removed due to lack of interest in its
development.  That _was_ available in branches of btrfs-progs
as 'btrfs dedupe'.  It's gone now.

The other viable deduper candidates are still works in progress, and
some have significant trade-offs and limitations resulting from their
optimization for specific use cases.  duperemove hasn't exploited any
btrfs-specific features to make it faster, so duperemove is already
close to the upper performance limits of its design, but far below the
performance that is possible in a specialist tool for btrfs.  bees scales
better and saves more space than the other dedupers, but bees can't
exclude any part of the filesystem from the scope of dedupe the way every
other btrfs deduper can.  dduper is a proof of concept that is so much
faster than the other block-oriented dedupers on btrfs that it overcomes a
ridiculously inefficient implementation and wins benchmarks--but it also
saves the least amount of space of any of the block-oriented dedupers on
the wiki.  There are some other candidates out there that aren't on the
wiki that attack the dedupe problem from interesting--and potentially
high-performing--angles (e.g. solstice dedupes the entire filesystem
using a sorting algorithm instead of a hash table).

The dozen or so utilities that do file-only dedupe well and support btrfs
are faster at Joe Blogger's use case than all the block-oriented dedupers.
Most of them are not btrfs-specific tools, so it doesn't make sense to
integrate them into btrfs-progs.

Most of the existing dedupers aren't written in C.  The rest of
btrfs-progs is C, creating a code review and maintenance issue if they
are to be merged. 

The write-in candidate is "write a file-only deduper in C just so it can
be integrated with btrfs-progs."  That doesn't even exist, and it's still
better than some of the existing candidates for merging into btrfs-progs.

A deduper that is good at block-level dedupe is bad at file-level dedupe
and vice versa.  They view the filesystem stack from different sides,
and the hardest optimization one can do is the easiest for the other.
Pre-write (in-kernel) and post-write dedupers have significantly
different memory costs, which is another reason for having a diverse set
of dedupers:  if you copy the ZFS approach to dedupe, you need ZFS-sized
memory budgets to implement it; if you don't have ZFS-sized memory, you
need an alternative implementation.  These are significant barriers to
picking a single winner.

For now, at least until one of the dedupers can scale well over a superset
of the other dedupers' use cases, or the in-kernel deduper comes back from
the dead, it would be better to provide third-party dedupers that are
optimized for the subset of workloads that they can handle very well.

Otherwise, whichever single deduper you pick, it will suck for some users,
or we pick multiple dedupe engines and need have a zillion options after
'btrfs fi dedupe' to help it pick which engine to use (this has already
happened to some extent in duperemove).

At the current rate of development, the XFS people might leapfrog us
on dedupe, and "official btrfs dedupe" could end up being xfs_fsr.

> Thanks David Sterba for removing the items and updating the wiki!
> 
> On 19/6/20 6:43 am, Zygo Blaxell wrote:
> > The point about lack of maintenance with changing Rust dependencies is
> > fair, but "data loss" is a strong and unsupported statement.  Can you
> > explain how data loss could occur in even a badly (assume not maliciously)
> > broken version of btrfs-dedupe?
> > 
> > As far as I can tell, the btrfs-dedupe code uses only non-data-mutating
> > btrfs kernel interfaces for manipulating extents (fiemap, defrag,
> > and file_extent_same/deduperange).  None of these should cause data
> > loss (excluding kernel bugs).
> > 
> > btrfs-dedupe can be trivially tricked into opening files that it did
> > not intend to (it has no protection against symlink injection and other
> > TOCCTOU attacks), but it doesn't seem to be able to alter the content
> > of files once it opens them.
> > 
> > File descriptors pointing to user files are opened O_RDWR, but they are
> > kept in the scope of the dedupe function and their life-cycle is properly
> > managed in Rust, so btrfs-dedupe won't mutate files by writing to the
> > wrong fd (e.g. accidentally close stderr and reopen it to a user file)
> > unless someone adds some seriously buggy code (see "assume not malicious"
> > above).
> > 
> > The unsafe C ioctl interfaces are unlikely to change in data-losing ways,
> > or they'll break all existing userspace tools that use them.  They are
> > also well encapsulated in the rust-btrfs module.
> > 
> > The errors reported on github seem to be problems with incompatible
> > changes in the runtime libraries btrfs-dedupe depends on, and also some
> > reports of what look like pre-existing bugs in the fiemap code that are
> > blamed on new kernel versions without evidence.  Data-losing breaking
> > changes in any of the ioctls btrfs-dedupe uses are extremely unlikely.
> > Those issues may cause btrfs-dedupe to do useless unnecessary work,
> > or fail to do useful necessary work, but could not cause data loss by
> > any mechanism I can find.
> > 
> > Contrast with bedup:  bedup uses data-mutating kernel interfaces
> > (clone_range) for dedupe that have no effective protection against
> > concurrent data modification.  There is ineffective protection implemented
> > in bedup (looking in /proc/*/fd for concurrent users of the files) which
> > may or may not be broken in kernel 5.0, but it's ineffective either way.
> > The case for data loss in bedup is trivial.  The branch with a patch to
> > fix it is now 7 years old, so it's fair to say bedup is unmaintained too
> > (github forks notwithstanding, they didn't fix these issues).
> > 
