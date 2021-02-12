Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09B031988D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Feb 2021 04:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBLDEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 22:04:49 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45634 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBLDEo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 22:04:44 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DFA5997E59C; Thu, 11 Feb 2021 22:04:00 -0500 (EST)
Date:   Thu, 11 Feb 2021 22:04:00 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210212030400.GH32440@hungrycats.org>
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
 <20210124223655.GD4626@dread.disaster.area>
 <20210129232550.GA32440@hungrycats.org>
 <20210202001334.GJ4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202001334.GJ4626@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 02, 2021 at 11:13:34AM +1100, Dave Chinner wrote:
> On Fri, Jan 29, 2021 at 06:25:50PM -0500, Zygo Blaxell wrote:
> > On Mon, Jan 25, 2021 at 09:36:55AM +1100, Dave Chinner wrote:
> > > On Sat, Jan 23, 2021 at 04:42:33PM +0800, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2021/1/22 上午6:20, Dave Chinner wrote:
> > > > > Hi btrfs-gurus,
> > > > This means, if we have an file which has one 128K file extent written to
> > > > disk, and then write 4K, which will be COWed to another 4K extent, the
> > > > 128K extent is still kept as is, even the no longer referred 4K range is
> > > > still kept there, with extra 4K space usage.
> > > 
> > > That's not relevant to the workload I'm running. Once it reaches
> > > steady state, it's just doing 4kB overwrites of shared 4kB extents.
> > 
> > Actually it is relevant, because that's _not_ what your workload is doing.
> > 
> > Despite having 'prealloc=0' in fio_config, fio preallocates the testfile.
> 
> I'm using fallocate=none, so preallocation uses write(), not
> fallocate() to preallocation unwritten extents. I explicitly chose
> this so that there was no interactions with unwritten extents in the
> workload and it therefore is a pure overwrite test.
> 
> strace output of fio laying out the base file in iteration 0 before
> any overwrites are done:
> 
> 155715 unlink("/mnt/scr/testdir/testfile") = -1 ENOENT (No such file or directory)
> 155715 openat(AT_FDCWD, "/mnt/scr/testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0644) = 5
> 155715 ftruncate(5, 4294967296)         = 0
> 155715 write(5, "\37\256\233\346J EH\303\365\303\205\2730\374\37\270\376\326u5\3036\17\327\337^/{\35T\t"..., 4096) = 4096
> 155715 write(5, "\341\7\3477j\36,\30\374`\f\303\331g\267\6\37\214\343\7u\v\316\4\203\361\354\332|=\370\23"..., 4096) = 4096
> 155715 write(5, "\250\241\264\10\27\375*\0275\224B\220H\333\361\5\206\322\355\307G\363L\27P\272\272\17r\272o\1"..., 4096) = 4096
> 155715 write(5, "\261P=\300\371\303fN\26*\257\217`\370f\4B\345\352|4\227v\35\250\\\374\34q\224b\24"..., 4096) = 4096
> 155715 write(5, "\222Z\340\254\335\37R,R\vS\210\213m\31\23jaa\353\207i[\16-,\267L\200wm\4"..., 4096) = 4096
> ....
> 155715 write(5, "z\306bv\3\322$>\317X\217\v\17\337\230\25\31k\n5\32\226\24\31c\315\24\21>x\204\23"..., 4096) = 4096
> 155715 write(5, "\215w\352\252FN\332b\361\316\226\231S\364\322\n\336Y\272\v\277\221\207\7;K\210\264Zl\243\r"..., 4096) = 4096
> 155715 write(5, "`\201Qe\331L$\5,0\372k\362\326\327\v\5Fi5\341\3045\f\300\250\252\203\347\35\371\v"..., 4096) = 4096
> 155715 fsync(5 <unfinished ...>
> ....
> 155715 <... fsync resumed> )            = 0
> 155715 fadvise64(5, 0, 4294967296, POSIX_FADV_DONTNEED <unfinished ...>
> ....
> 155715 <... fadvise64 resumed> )        = 0
> 155715 close(5)                         = 0
> ....
> 155715 stat("/mnt/scr/testdir/testfile", {st_mode=S_IFREG|0644, st_size=4294967296, ...}) = 0

Hmmm you are of course right, although all the writes get coalesced into
giant extents by delalloc anyway.  The end result looks very similar in
the extent tree, but it doesn't have prealloc bits set in the metadata,
and I somehow missed that detail.

> > By the time you look at these extents with FIEMAP, FIEMAP is stuck
> > potentially running tens of trillions of iterations trying to fill in
> > the "SHARED" bit for millions of extents.
> 
> Yup, that's pretty bad. Is there any plan to fix this?

Not that I know of.  FIEMAP is too limited to be useful with btrfs,
and it's pretty useless to work on FIEMAP performance before those other
issues are resolved because both sets of issues have the same cause.

Arguably, removing the other issues could also fix btrfs FIEMAP
(i.e. change btrfs to force logical and physical extents to have the
same offset and size, and implement a faster reverse lookup table) but
those changes could break several things that currently work well in
btrfs (e.g. adequate FIEMAP handling for compression seems trivially
impossible to implement without separate logical and physical extent
sizes, and snapshots would always incur full reflink costs up front
instead of being able to defer them).

On the other hand, since there's not a prealloc here, this test case is
not hitting the _really_ slow code at all...

> > IMHO, PREALLOC should be ignored for all datacow files on btrfs.
> > It can't do things people expect with a datacow file (in
> > particular the ENOSPC guarantee is only possible for the first
> > write), and it does a bunch of
> > expensive, counterintuitive stuff that people don't expect.
> 
> So what you are saying is that preallocated extents in btrfs are
> compromised from an architectural POV and are largely
> unfixable?

I'm saying fallocate _on datacow files_ in btrfs is broken (as opposed
to nodatacow files where we can just write directly on the allocated
blocks like most other filesystems do).  It just seems obvious to me that
fallocate on datacow could never work well enough to be of practical use.
Here's why:

fallocate makes promises like this one:

	After a successful call to posix_fallocate(), subsequent writes to
	bytes in the specified range are guaranteed not to fail because
	of lack of disk space.

while reflink says the following about fallocate:

	Because a copy-on-write operation requires the allocation
	of new storage, the fallocate(2) operation may unshare shared
	blocks to guarantee that subsequent writes will not fail because
	of lack of disk space.

This seems to say that if the reflink happens first, fallocate will
allocate or reserve duplicate space to implement the no-fail guarantee.

But what happens if the fallocate happens first, and then the reflink?
The doc doesn't say.  There's no guidance in either text about how long
the no-fail guarantee from fallocate lasts, or what events invalidate it,
or what other operations are obligated to maintain it.

One could naively assume that the no-fail guarantee lasts forever, that
reflink will make duplicate space reservations for CoW of fallocated
extents (or even make duplicate copies of the existing data), and that
the reflinks will also provide no-fail guarantees.  The doc doesn't make
any such promises.

Another interpretation is that reflink is allowed to remove the no-fail
guarantee from fallocated extents, and use shared physical storage and
possibly-failing copy-on-write allocations in the future.  The last
stated intent of the user was for shared physical storage of the extent,
so we could argue this doesn't violate the principle of least surprise.
The doc doesn't forbid this, and this is what actually happens on btrfs.

Every btrfs transaction starts by creating a reflink to every datacow
extent in the filesystem.  A snapshot is created in memory (recall
that snapshots are effectively deferred reflinks), btrfs updates the
snapshot rather than the on-disk data (as required for datacow), and then
swaps the snapshot for the original subvol after flushing, deleting the
on-disk subvol.  btrfs datacow files thus behave as if they always have
a new reflink, which removes the no-fail guarantee immediately after
fallocate() is done.

Without the no-fail guarantee, fallocate is (mostly) meaningless.
It would have been sane to say "lol no, we don't implement fallocate
on datacow files because the concepts are obviously incompatible,"
and stop there.  Back in 2008, someone didn't stop, and today we have
btrfs's broken fallocate emulation for datacow files.

The fallocate emulation is good enough to pass a simple unit test (the
one where we preallocate some empty space, fill up the filesystem, then
write once to the preallocated region, and don't get ENOSPC most of the
time) but it fails a lot:

	- it doesn't reserve metadata space for partially overwritten
	prealloc extents or data csums, so writes to fallocated extents
	that don't overwrite the entire extent at once can return ENOSPC
	at any time,

	- it triggers the expensive block-level sharing check for any
	partial overwrite of a prealloc extent,

	- it triggers a normal extent-level sharing check for any future
	write to the file as long as the file exists (it's a flag in
	the inode that cannot be turned off even if all preallocated
	extents are removed).

	- it forgets the prealloc bit in the extent when data is written
	to a block, so overwrites don't get the no-fail guarantee,

	- it doesn't provide space or metadata annotation for the no-fail
	guarantee on existing data blocks at all,

	- it doesn't implement unsharing or space reservation for
	reflinks or snapshots of fallocated extents,

	- it usually ends up wasting a lot of space in practice, due to
	btrfs's shared ref counting (one byte of reference holds 128MB
	of immutable data on the filesystem),

	- it permanently disables compression on files where fallocate
	is used (due to the inode flag that cannot be unset).

Possibly other problems too, this is just a list of some random issues
users complained about over the years.  Some of these apply to nodatacow
files on btrfs too, but fallocate on nodatacow files can work if there
are a) no reflinks or snapshots and b) all the blocks are filled with
non-zero data so there is no metadata expansion for zero-filling blocks.
i.e. don't use prealloc on btrfs nodatacow files either, just write
filler data to them if you really need the no-fail guarantee to work.

btrfs could fix all those issues:  persistently reserve metadata space
for data csums and partial overwrite extent items, persistently reserve
space for reflinks, persist the fallocate bit (writes guaranteed not
to fail) separately from the prealloc bit (space allocated but not
filled, reads as zero) so data overwrites are guaranteed not to fail,
track subvol-level fallocate usage so we can reserve space when making
snapshots, redesign compression, data csums, and reference sharing.

All of the fixes increase the runtime cost of fallocate, possibly to
insane levels, or they turn datacow files into nodatacow files and violate
btrfs data integrity rules, or they impose write overheads proportional
to the number of reflinks, or the preallocated space is subject to
arbitrary amounts of fragmentation, or they have surprising reserved
space requirements, or snapshot create and reflink grow a bunch of knobs
for controlling whether the snapshot/reflink inherits the shared space
guarantee from its parent, or async data writes have to be journaled,
or something even worse than any of these.

Of course any of these fixes will require incompat bits, because the
current on-disk format is useless for implementing fallocate.

Real users of fallocate tend to be performance-sensitive:  one critical
feature of most fallocate implementations is that writes have zero
overhead in the future because allocation is done in the present.
On btrfs datacow files, normal writes never have zero overhead, and
writes to fallocated extents can have _additional_ overhead compared to
normal writes because of the extra work btrfs does to emulate fallocate.
We can eliminate half of the proposable fallocate fixes because they
have even worse overheads than what we have now.

fallocate doesn't separate the no-fail guarantee from the (mostly
unstated) contiguous allocation expectation (i.e. most users assume
fallocate will try to allocate contiguous space, because most fallocate
implementations do that, but it's not a stated effect of the fallocate
system call).  If we separate these, btrfs could simply reserve space
for all fallocate overwrites in a pool subtracted from free data space
(the same way space for the current transaction is reserved in metadata
space), and snapshots and reflinks can just add to the pool size (or
fail if there's not enough free space for reserved fallocate blocks).
Such allocations would not be contiguous (which isn't guaranteed) but
writes would not fail with ENOSPC (which is guaranteed), so it would
be technically correct; however, the non-contiguous allocation behavior
would be so different from what users expect from other filesystems that
it's questionable whether we should bother.

The one (and possibly only) case where prealloc on datacow is useful
is when writing a file in random order--very carefully, with strictly
page-aligned writes, each page written exactly once.  This reduces
fragmentation, which would otherwise create a pile of metadata roughly 2%
of the size of the data (at 4K page size).  A torrent client could use
this if it was very careful to buffer up partial block writes--if it's
not careful, the resulting prealloc file ends up very badly fragmented,
and a lot of space is wasted.

systemd famously ran into this issue back in 2015.  At the time, systemd
used prealloc on datacow files for its journal, but prealloc on datacow
was useless with systemd's write pattern, so systemd now uses prealloc
on nodatacow files, and tries (incorrectly, it turns out) to flip them
back to datacow once systemd has closed them.

Databases and VM images (which frequently overwrite blocks) are strictly
worse with prealloc on datacow files than without prealloc or without
datacow.

> > PREALLOC is useful for nodatacow files and does implement expected
> > behavior, but it should only be used on those.
> 
> Yeah, that's not an option for general use filesystems
> that run applications that use fallocate() for preallocation and the
> user either doesn't know about it or cannot turn it off.

Hence my proposal that the filesystem silently ignore fallocate when the
file is datacow, as that is the least bad way to satisfy the various
conflicting requirements.  Deprecate the half-finished, stillborn,
insane fallocate-on-datacow feature and remove it in some future kernel.

The most correct way would be to reject posix_fallocate with an error
since btrfs doesn't implement it sanely on datacow files, but as you
point out, that would require LD_PRELOAD hacks on all the applications
that think fallocate is mandatory.

As things are now, I already use LD_PRELOAD hacks to prevent applications
from using prealloc, because prealloc on datacow such a bad idea at scale.

> > > > > Next, subvol snapshot and clone time appears to be scale with the
> > > > > number of snapshots/clones already present. The initial clone/subvol
> > > > > snapshot command take a few milliseconds. At 50 snapshots it take
> > > > > 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
> > > > > > 850 it seems to level off at about 30s a snapshot. There are
> > > > > outliers that take double this time (63s was the longest) and the
> > > > > variation between iterations can be quite substantial. Is this
> > > > > expected scalablity?
> > > > 
> > > > The snapshot will make the current subvolume to be fully committed
> > > > before really taking the snapshot.
> > > > 
> > > > Considering above metadata overhead, I believe most of the performance
> > > > penalty should come from the metadata writeback, not the snapshot
> > > > creation itself.
> > > > 
> > > > If you just create a big subvolume, sync the fs, and try to take as many
> > > > snapshot as you wish, the overhead should be pretty the same as
> > > > snapshotting an empty subvolume.
> > > 
> > > The fio workload runs fsync at the end of the overwrite, which means
> > > all the writes and the metadata needed to reference it *must* be on
> > > stable storage. 
> > 
> > That is not how btrfs fsync works, and your assertions that follow from
> > this misunderstanding are also wrong.
> 
> I suspect you misunderstand what I said.
> 
> "metadata on stable storage" for a journalling filesystem means
> "stable in the journal", not at it's final resting place. 
> I'll snip your description of the btrfs fsync journal because I know that
> btrfs does this and why it was implmented the way it was and not the
> way WAFL or ZFS solved the same "COW metadata is expensive
> for fsync()" problem...

On filesystems with mutable metadata, fsync can cheaply overwrite
metadata (possibly even without writing the journal, e.g. when new
files or metadata pages are created in previously unreferenced space),
mark the metadata pages clean in memory, and thus not have to write
them out again later with async writes.  On such filesystems, fsync()
does reduce future async metadata write latency because it can entirely
remove metadata updates from async queues (not just the data blocks).

My point was that btrfs doesn't ever do that.  btrfs uses transactions
and wandering trees instead of a journal for metadata.  There's no
(implemented) short cut for a metadata tree update, because it has
to insert items into existing btree pages, and that's read, update,
write for every page, all the way from the leaves to the roots, and the
metadata trees are _big_.

As far as I can tell, ZFS's ZIL/SLOG implementation works the same way.
Sync writes don't remove any async write workload from ZFS transaction
aggregation...and ZFS's metadata is even larger than btrfs.

Neither ZFS nor btrfs have a background process that reads these logs and
implements the metadata tree changes asynchronously after transaction
commit, so there's no fast path to dequeueing metadata changes from
kernel memory and thus no (positive) latency impact from fsync.
 
> > In the rare cases where fsync() happens to run at the same time as a
> > transaction commit (or maybe just before), the transaction commit and
> > the fsync() get synchronized by trying to touch the same locks, and
> > return at close to the same time.  In those cases, the snapshot only
> > has to write out a new subvol root and some free space map changes,
> > which takes 0.02s.
> 
> Ok, so there are internal transaction commit/metadata COW lock-step
> conflicts in btrfs? 

Exactly.  delalloc can avoid the locks to some degree, and there is some
attempt to spread out the write load over time in background threads that
don't block anything, but once those run out of memory, or a flushing
commit like snapshot create is triggered, btrfs will stop the world
to wait for a metadata tree update to finish.

> I'm guessing that they can hit anything that runs fsync() and at
> any time?

They can hit anything that is mutating the filesystem at any time.
All mutating functions try to start or join a transaction, and all can
be locked out during the critical section of a transaction commit.

'mkdir' could take 10 microseconds or 10 months under the right
conditions.

> i.e. non-deterministic long tail latencies can hit at any time?

Yes.  Currently it's not possible to run a latency-sensitive workload
on btrfs in the presence of continuous writers.

It will always take a long time to flush millions of 4K extent refs to
disk with 80 GB of metadata, but it seems to be easily possible to cap
the latencies at seconds per commit, instead of allowing them to grow
to multiple hours.

There used to be request throttling to prevent the latencies from getting
stupidly large, but it was removed more or less accidentally in 5.0, so
now the latencies are bounded only by disk space.

Some older parts of the btrfs code (like snapshot delete) never had
throttling implemented in any version.  These are the easiest ways to
get multi-minute commit latencies.

> I doubt that aggregating more changes in memory will improve
> determinism. Sure, it might delay the interference for some time,
> but then the machine will eventually be out of memory. That can be
> trigger by a user allocation and so the user will now complain about
> long application stalls due to kernel memory reclaim....

Yeah, that advice would have only helped your test be more deterministic,
to help confirm that this theory of why the latencies are occurring is
the correct one.  It won't solve any problem.

> > If you have 1000 snapshots and your writes have high metadata locality
> > (e.g. you are appending to a single log file in each snapshot) then
> > the write multipliers are very close to 1.0x.  If you have low metadata
> > locality, even one snapshot will be followed by a big write multiplication
> > burst.
> 
> Yup, so general use case with snapshots is low data and metadata
> write locality as most files tend to get written once and then not
> touched again. 

That's the high locality case.  Most changes will occur at the high end
of the subvol where the new files are created (plus a few pages in the
middle for their dirents), so the majority of the metadata pages in the
subvol are untouched and btrfs avoids having to make reflinks of them.
Most new metadata items will appear on a few pages.

Files that are updated at random throughout their logical space, like
a big VM image or database (or directories where files are updated
randomly, e.g. a cache directory where filenames are hashes, or a
build tree where source files persist a long time but derived files
are wiped out by periodic 'make clean') will have low locality due to
deletions (including overwrites) at random points within the subvol,
while overwrites and new data still appear at the end of the subvol.
The same number of metadata item changes will affect many more metadata
pages over a large logical distance.  These are the workloads that show
up as hot spots when we are looking at what our rotating snapshot servers
are doing.

> > > > No, this is mostly due to the exploding amount of metadata caused by the
> > > > near-worst case workload.
> > 
> > Every 2 orders of magnitude more metadata items increases the O(log(N))
> > costs of btrfs by one unit.  By 50 snapshots or reflinks you have hundreds
> > of millions of metadata items, it's 6x slower and not increasing very
> > much any more...not too far off what we'd expect.
> 
> Ok, so the problem is the exponential cost of maintaining all the
> cross-btree references, not the btree itself. 

I wouldn't say that the cost is exponential (explosive, sure, that's a
good ex- word for this).  The size growth is O(n*log(n)) for the number
of extent refs (shared and unshared reflinks are implemented the same
way on btrfs) and the curve follows that shape for the first 600 or so
snapshots (I didn't run all 1000).

CPU growth seems to follow the metadata size, provided you don't step
on the related prealloc or FIEMAP performance landmines which are
O(reflinks * snapshots * log(n)) for each individual physical extent.
Large numbers growing in two dimensions, but not exponentially.

Obviously the curve bends sharply at the point where metadata no longer
fits in RAM and spills out on disk.  With 80GB of metadata, the constant
terms in O()-notation are going to be huge, and the flood of random
metadata page IOs probably large enough to find nonlinearities in the
storage hardware as well (we've hit SLC and DRAM cache throughput limits
in SSDs with this kind of workload).

> So it really is an architectural issue and not something that can
> be fixed?

Well, it's hard to tell with so many trivial performance problems floating
around in btrfs, but the results in your test do seem to be dominated
by metadata size effects.

Someone could be working on an ultra-skinny reflink metadata format, or
mutable extent ref maps (which would be useful for dedupe use cases as
well), or on-disk deferred metadata ref updates, or a high-speed FIEMAP
accelerator cache just because Dave Chinner wants one.  That would be
a lot like bolting a whole other filesystem onto the side of btrfs.
It was done for fsync, so it's not impossible, but it doesn't seem likely.

For that matter, somebody could be teaching XFS how to do compression,
data csums, and self-healing from mirror devices, and then I could flip
a few servers over to test it... ;)

> > I'm familiar with this workload.  I've been running something similar to
> > your target workload since 2014.  We build NAS backup appliance boxes:
> > each has about 100 client subvols ranging in size from 1GB to 10TB,
> > thousands to millions of files each, 1-5% daily turnover.
> > 
> > Multiple snapshots per hour at this scale is a really ambitious target
> > for btrfs.  We can theoretically do somewhere between 15 and 180 snapshot
> > rotates per day before the machine starts falling behind on the deletes
> > and running out of space.  Snapshot create and delete on btrfs come
> > with giant unbounded latency spikes, so we don't run them all the time.
> > We'll create snapshots any time a client finishes an update, but we only
> > delete old snapshots to recover disk space during a 3-hour maintenance
> > window.
> >
> > While the snapshot rotates are happening, btrfs leaves CPU cores and
> > disks idle.  Current performance is far from the theoretical limits.
> 
> Which, IMO, is kinda sad because zero-cost snapshot-based
> workload/workflows is what btrfs was specifically intended to
> provide to users...

This is a frequent misconception among btrfs users.  The costs are
not zero.  They are _deferred_, and paid out over the lifetime of the
snapshot.

They are good for use cases where you don't modify enough of a subvol to
force a complete reflink copy before you start deleting the snapshot.
This avoids the cost of creating and later deleting a full reflink
copy.  You only pay for what you modified.  This is useful for origin
servers sending backups--the backup snapshot gets deleted after use,
and you have only a handful of snapshots lying around between backups
to calculate incrementals.

For other use cases, snapshot costs include the full cost of a reflink
copy spread out over later writes to shared subvols.  Once a snapshot
has been fully transformed into a reflink copy, deleting the snapshot has
roughly the same cost as rm -fr.  This is the case you were testing, and
btrfs's ability to defer snapshot costs gives no advantage for this case.

Of course, the savings gained by deferred reflink on btrfs could be less
than the entire snapshot lifecycle cost on other filesystems due to the
ratio of btrfs metadata size to other filesystems' metadata sizes.

> Yup, that's exactly how I have fio configured to behave. So the 80GB
> of metadata is for what you consider to be the "better" case.

It should be ~80GB of metadata in both cases.  The total could be 70GB
or 90GB due to random variation between runs.

The prealloc / write fill thing just makes FIEMAP slower (more CPU
iterations) and adds 4GB of data space.  prealloc doesn't change the
metadata size by more than a few KB, and FIEMAP doesn't change anything
on disk at all.

On our fileservers with multi-million-extent subvols, we get from 50 GB
to 180 GB of metadata from 20 TB to 50 TB of data, depending on average
file size and how well dedupe is doing.  Every TB of data is a GB of
data csums.  After that, the rest is roughly equal parts directory
entries, inline file data, and extent forward/backward reference
pairs, with the sizes varying depending on content of the filesystem.
Dedupe will reflink common extents hundreds or thousands of times each,
and then we have hundreds or thousands of snapshots (daily snapshots *
years of retention).

There can easily be 30-100 GB of reflinks in the metadata, so 80 GB is
not an atypical size for this kind of workload.

You haven't confirmed whether your ~220GB size was measured with single
or dup metadata, or whether you were using 'df' or 'btrfs fi df' to
measure it.  'df' counts all 1GB metadata chunks as used space, whether
they are fully occupied or not.  'dup' metadata literally doubles the
metadata size.  If you're using dup metadata and 'df' "used" space, that
number will include 44GB of data, and the remainder will be about 210%
of the actual metadata size.  I used 'btrfs fi df', which shows directly
how much pre-duplication metadata and data space is used, so I'm getting
a best-case estimate.

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
