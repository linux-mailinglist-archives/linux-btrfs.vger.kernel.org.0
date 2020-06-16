Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84351FA72E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 05:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFPD4n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 23:56:43 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47654 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgFPD4n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 23:56:43 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5AC11717CA2; Mon, 15 Jun 2020 23:56:41 -0400 (EDT)
Date:   Mon, 15 Jun 2020 23:56:41 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS File Delete Speed Scales With File Size?
Message-ID: <20200616035640.GK10769@hungrycats.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
 <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
 <1a88f0e4-3fd1-b0bc-308e-c12b9f64b46c@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a88f0e4-3fd1-b0bc-308e-c12b9f64b46c@panasas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 06:00:47PM -0400, Ellis H. Wilson III wrote:
> Some follow-ups:
> 
> 1. We've discovered that background dirty sync will cause the deletion
> slow-downs I witnessed before.  If we sync and drop all vm caches before
> starting, the deletion speed for a 64GiB file averages around 2.5s.
> 
> 2. We find that speed to delete and fsync the directory on 4.12 is
> equivalent to delete and then sync the entire filesystem.

I'm not quite sure how fsync() is relevant here--fsync() doesn't do
anything about delayed refs, unless fsync() accidentally triggers a full
sync (which I wouldn't expect to happen when fsyncing a simple unlink).

Are you measuring fsync() and unlink() separately, or the total time
running both?  I would expect the unlink() to be slow on kernels up to
4.20, and fsync() to be almost a no-op on kernels after 4.0.

> 3. We tested on 5.7.1-1-default, the vanilla release available in tumbleweed
> openSuSE.  We find that removes are greatly improved (20x64GiB files
> removed, serially, in the order they were created, an fsync of the directory
> holding them done after each remove, and all caches dropped before
> beginning):
> 
>  real    0m0.112s
>  real    0m0.024s
>  real    0m0.038s
>  real    0m0.039s
>  real    0m0.017s
>  real    0m0.032s
>  real    0m0.073s
>  real    0m0.019s
>  real    0m0.041s
>  real    0m0.029s
>  real    0m0.034s
>  real    0m0.030s
>  real    0m0.023s
>  real    0m0.012s
>  real    0m0.020s
>  real    0m0.035s
>  real    0m0.013s
>  real    0m0.066s
>  real    0m0.014s
>  real    0m0.007s
> 
> We further note background busy-ness by btrfs transaction many seconds
> later, suggestion a new approach to unlink better mirrors how BTRFS manages
> subvolume deletion.

Without delayed ref throttling, ordinary unlinks get millions of their
reference updates pushed into the background, where they do indeed behave
more like subvol deletes (which are in the background for their entire
lives, and consist entirely of reference updates).

Removing the throttling trades kernel memory for speed--at least, as long
as the kernel can keep allocating more memory.  When memory runs out,
or the filesystem is synced or umounted (actions which force a commit),
all pending ref updates get flushed synchronously, and delays can be
significant.

Fast SSDs might be able to process 10k delayed refs per second, while
a few GB of host RAM can hold millions of delayed refs.  The math
multiplies up to hours of IO time pretty quickly on hosts with more RAM
and slower spinning disks.

> 4. We also note that deletion speed goes back to the slow speeds reported
> before if you add a full sync after every remove rather than a targeted
> fsync.  This is relatively unsurprising given the different expectations,
> though an interesting finding given that merely fsync'ing didn't help in the
> case of 4.12.

unlink() reads the extent references contained in a file and creates
delayed refs (an in-memory log of reference adds and deletes) to
remove the extent references in a kernel thread (sometimes a different,
background thread, though neither is guaranteed).

4.12 throttles unlink() to avoid creating huge backlogs of ref updates
in kernel memory.  During the throttling, previously delayed refs
(including ref updates caused by other threads) are processed by the
kernel thread servicing the unlink() system call.

5.7 doesn't throttle unlink(), so the unlink() system call simply queues
delayed ref updates as quickly as the kernel can allocate memory.
Once kernel memory runs out, unlink() will start processing delayed
refs during the unlink() system call, blocking the caller of unlink().
If memory doesn't run out, then the processing happens during transaction
commit in some other thread (which may be btrfs-transaction, or some
other unlucky user thread writing to the filesystem that triggers delayed
ref processing).

In both kernels there will be bursts of fast processing as unlink()
borrows memory, with occasional long delays while unlink() (or some other
random system call) pays off memory debt.  4.12 limited this borrowing
to thousands of refs and most of the payment to the unlink() caller;
in 5.7, there are no limits, and the debt to be paid by a random user
thread can easily be millions of refs, each of which may require a page
of IO to complete.

The total IO cost from the start of the first unlink() call to the end
of the last block freed and committed on disk should be about the same
on 4.12 and 5.7, though there are many other small improvements between
4.12 and 5.7 that might make 5.7 slightly faster than 4.12.  Any other
measurement methodology will not observe some part of the total IO cost.

Nothing about the fundamental work of unlink() has changed--the filesystem
must read and write all the same metadata blocks in more or less the same
order to delete a file.  The difference is which kernel thread does the
work, and how much kernel memory is occupied by the filesystem while
that work is done.

> Any comments on when major change(s) came in that would impact these
> behaviors would be greatly appreciated.

Between 4.20 and 5.0 the delayed ref throttling went away, which might
account for a sudden shift of latency to a different part of the kernel.

The impact is that there is now a larger window for the filesystem to
roll back to earlier versions of the data after a crash.  Without the
throttling, unlink can just keep appending more and more ref deletes to
the current commit faster than the disks can push out updated metadata.
As a result, there is a bad case where the filesystem spends all of
its IO time trying to catch up to metadata updates, but never successfully
completes a commit on disk.

A crash rolls back to the previous completed commit and replays the
fsync log.  A crash on a 5.0 to 5.7 kernel potentially erases hours of
work, or forces the filesystem to replay hours of fsync() log when the
filesystem is mounted again.  This requires specific conditions, but it
sounds like your use case might create those conditions.

Some details:

	https://lore.kernel.org/linux-btrfs/20200209004307.GG13306@hungrycats.org/

5.7 has some recent delayed ref processing improvements, but AFAIK
the real fixes (which include putting the throttling back) are still
in development.

> Thanks,
> 
> ellis
> 
> 
> On 6/11/20 9:54 AM, Ellis H. Wilson III wrote:
> > It seems my first email from last night didn't go through.  Resending,
> > but without the .txt attachment (all of it is described below in enough
> > detail that I don't think it's needed).
> > 
> > On 6/10/20 9:23 PM, Ellis H. Wilson III wrote:
> > > Responses to each person below (sorry I thought it useful to
> > > collapse a few emails into a single response due to the similar
> > > nature of the comments):
> > > 
> > > 
> > > Adam:
> > > 
> > > Request for show_file.py output (extent_map.txt) for a basic 64GiB
> > > file is attached.  It appears the segments are roughly 128MB in
> > > size, so there are (and it reports) 512 of them, and they are all
> > > roughly sequential on disk.  Obviously if I delete things in
> > > parallel (as our end-users are extremely liable to do, us being a
> > > parallel file system and all) one might expect seek time to dominate
> > > and some 10ms per segment (~5s) to occur if you have to hit every
> > > segment before you return to the caller.  Serial deletion testing
> > > shows an average time of 1.66s across 10 data points, with decent
> > > variability, but the overall average is at the upper-end of what we
> > > saw for parallel deletes (30-40GB/s).
> > > 
> > > Is extent size adjustable (I couldn't find this trivially via
> > > search)? Our drives are raided (raid0 via mdadm) together into ~72TB
> > > or (soon) ~96TB BTRFS filesystems, and we manage small files on
> > > separate SSD pools, so optimizing for very large data is highly
> > > viable if the options exist to do so and we expect the seek from
> > > extent to extent is the dominating time for deletion.  Side-effect
> > > information is welcome, or you can point me to go read a specific
> > > architectural document and I'll happily oblige.
> > > 
> > > 
> > > Martin:
> > > 
> > > Remounted with nodatasum:
> > > [478141.959269] BTRFS info (device md0): setting nodatasum
> > > 
> > > Created another 10x64GB files.  Average deletion speed for serial,
> > > in-order deletion is 1.12s per file. This is faster than before, but
> > > still slower than expected.  Oddly, I notice that for the first 5
> > > deletions, the speed is /much/ faster: between 0.04s and 0.07s,
> > > which is in the far more reasonable ~TB deleted per second range. 
> > > However, the next 4 are around 1.7s per delete, and the 10th one
> > > takes 5s for some reason.  Again, these were deleted in the order
> > > they were created and one at a time rather than in parallel like my
> > > previous experiment.
> > > 
> > > 
> > > Hans:
> > > 
> > > Your script reports what I'd gathered from Adams suggestion to use
> > > your other script:
> > > 
> > > Referencing data from 512 regular extents with total size 64.00GiB
> > > average size 128.00MiB
> > > 
> > > No dedupe or compression enabled on our BTRFS filesystems at present.
> > > 
> > > Regarding the I/O pattern, I'd not taken block traces, but we notice
> > > lots of low-bandwidth but high-activity reading (suggesting high
> > > seeking) followed by shorter phases of the same kind of writes.
> > > 
> > > Regarding BTRFS metadata on SSDs -- I've mentioned it before on this
> > > list but that would be an incredible feature add for us, and for
> > > more than just deletion speed.  Do you know if that is being
> > > developed actively?
> > > 
> > > I did the same test (10x64GiB files, created in-order/serially,
> > > deleted in-order/serially) on our SATA SSD that manages small files
> > > for us.  The result was surprising:
> > > 
> > > time (for i in {1..10}; do time (rm test$i; sync); done)
> > > #snipped just the reals out:
> > > real    0m0.309s
> > > real    0m0.286s
> > > real    0m0.272s
> > > real    0m0.298s
> > > real    0m0.286s
> > > real    0m0.870s
> > > real    0m1.861s
> > > real    0m1.877s
> > > real    0m1.905s
> > > real    0m5.002s
> > > 
> > > Total:
> > > real    0m12.978s
> > > 
> > > So this shouldn't be a seek-dominated issue (though SATA this is an
> > > enterprise-grade SSD), and I see the same pathology I saw when I
> > > tried the nodatacow option for Martin.  Fast deletions up-front
> > > (though slower than on the HDDs, which is weird), then a series of
> > > medium-slow deletions, and then one long and slow deletion at the
> > > end.  I definitely need to do a blocktrace on this.
> > > 
> > > /sys/fs/btrfs/<UUID>/features/free_space_tree *does* exist for the
> > > UUID of the md0 HDD array and the single SATA SSD referred to above.
> > > 
> > > "* Organize incoming data in btrfs subvolumes in a way that enables you
> > > to remove the subvol instead of rm'ing the files."
> > > 
> > > A similar approach was explored already.  We find that if you remove
> > > the subvolume, BTRFS does a better job of throttling itself in the
> > > kernel while doing deletions and the disks are generally not as
> > > busy, but subsequent reflinks across volumes stall horribly. 
> > > Frequently in the tens of seconds range.  So our idea of "create a
> > > series of recycle bins and delete them when they reach some
> > > threshold" didn't quite work because moving new stuff being deleted
> > > in the foreground to one of the other recycle bins would come to a
> > > screeching halt when another recycle bin was being deleted.
> > > 
> > > "* Remove stuff in the same order as it got added."
> > > 
> > > We use temporal ordering of data into buckets for our parallel file
> > > system (PFS) components to make things easier on the dirents,
> > > nevertheless, we're at the mercy of the user's workload ultimately.
> > > Nobody is removing anything like rm * as our PFS components are
> > > randomly assigned IDs.
> > > 
> > > We realize the need to move to something newer, however, we've
> > > noticed serious creation-rate degradation in recent revisions
> > > (that's for a different thread) and don't presently have all of the
> > > upgrade hooks in-place to do full OS upgrade yet anyhow.
> > > 
> > > Thanks again for everyone's comments, and if you have any additional
> > > suggestions I'm all ears.
> > > 
> > > Best,  I respond when I get block graphs back.
> > > 
> > > ellis
> > > 
> > > 
> > > 
> > > On 6/9/20 7:09 PM, Hans van Kranenburg wrote:
> > > > Hi!
> > > > 
> > > > On 6/9/20 5:31 PM, Ellis H. Wilson III wrote:
> > > > > Hi folks,
> > > > > 
> > > > > We have a few engineers looking through BTRFS code presently
> > > > > for answers
> > > > > to this, but I was interested to get input from the experts in parallel
> > > > > to hopefully understand this issue quickly.
> > > > > 
> > > > > We find that removes of large amounts of data can take a significant
> > > > > amount of time in BTRFS on HDDs -- in fact it appears to scale linearly
> > > > > with the size of the file.  I'd like to better understand the mechanics
> > > > > underpinning that behavior.
> > > > 
> > > > Like Adam already mentioned, the amount and size of the individual
> > > > extent metadata items that need to be removed is one variable in the big
> > > > equation.
> > > > 
> > > > The code in show_file.py example in python-btrfs is a bit outdated, and
> > > > it prints info about all extents that are referenced and a bit more.
> > > > 
> > > > Alternatively, we can only look at the file extent items and calculate
> > > > the amount and average and total size (on disk):
> > > > 
> > > > ---- >8 ----
> > > > #!/usr/bin/python3
> > > > 
> > > > import btrfs
> > > > import os
> > > > import sys
> > > > 
> > > > with btrfs.FileSystem(sys.argv[1]) as fs:
> > > >      inum = os.fstat(fs.fd).st_ino
> > > >      min_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, 0)
> > > >      max_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, -1)
> > > >      amount = 0
> > > >      total_size = 0
> > > >      for header, data in btrfs.ioctl.search_v2(fs.fd, 0,
> > > > min_key, max_key):
> > > >          item = btrfs.ctree.FileExtentItem(header, data)
> > > >          if item.type != btrfs.ctree.FILE_EXTENT_REG:
> > > >              continue
> > > >          amount += 1
> > > >          total_size += item.disk_num_bytes
> > > >      print("Referencing data from {} regular extents with total
> > > > size {} "
> > > >            "average size {}".format(
> > > >                amount, btrfs.utils.pretty_size(total_size),
> > > >                btrfs.utils.pretty_size(int(total_size/amount))))
> > > > ---- >8 ----
> > > > 
> > > > If I e.g. point this at /bin/bash (compressed), I get:
> > > > 
> > > > Referencing data from 9 regular extents with total size 600.00KiB
> > > > average size 66.67KiB
> > > > 
> > > > The above code assumes that the real data extents are only referenced
> > > > once (no dedupe within the same file etc), otherwise you'll have to
> > > > filter them (and keep more stuff in memory). And, it ignores inlined
> > > > small extents for simplicity. Anyway, you can hack away on it to e.g.
> > > > make it look up more interesting things.
> > > > 
> > > > https://python-btrfs.readthedocs.io/en/latest/btrfs.html#btrfs.ctree.FileExtentItem
> > > > 
> > > > 
> > > > > See the attached graph for a quick experiment that demonstrates this
> > > > > behavior.  In this experiment I use 40 threads to perform deletions of
> > > > > previous written data in parallel.  10,000 files in every case and I
> > > > > scale files by powers of two from 16MB to 16GB.  Thus, the
> > > > > raw amount of
> > > > > data deleted also expands by 2x every step.  Frankly I
> > > > > expected deletion
> > > > > of a file to be predominantly a metadata operation and not scale with
> > > > > the size of the file, but perhaps I'm misunderstanding that.  While the
> > > > > overall speed of deletion is relatively fast (hovering between 30GB/s
> > > > > and 50GB/s) compared with raw ingest of data to the disk array we're
> > > > > using (in our case ~1.5GB/s) it can still take a very long time to
> > > > > delete data from the drives and removes hang completely until that data
> > > > > is deleted, unlike in some other filesystems.  They also compete
> > > > > aggressively with foreground I/O due to the intense seeking
> > > > > on the HDDs.
> > > > 
> > > > What is interesting in this case is to see what kind of IO pattern the
> > > > deletes are causing (so, obviously, test without adding data). Like, how
> > > > much throughput for read and write, and how many iops read and write per
> > > > second (so that we can easily calculate average iop size).
> > > > 
> > > > If most time is spent doing random read IO, then hope for a bright
> > > > future in which you can store btrfs metadata on solid state and the data
> > > > itself on cheaper spinning rust.
> > > > 
> > > > If most time is spent doing writes, then what you're seeing is probably
> > > > what I call rumination, which is caused by making changes in metadata,
> > > > which leads to writing modified parts of metadata in free space again.
> > > > 
> > > > The extent tree (which has info about the actual data extents on disk
> > > > that the file_extent_item ones seen above point to) is once of those,
> > > > and there's only one of that kind, which is even tracking its own space
> > > > allocation, which can lead to the effect of a cat or dog chasing it's
> > > > own tail. There have definitely been performance improvements in that
> > > > area, I don't know exactly where, but when I moved from 4.9 to 4.19
> > > > kernel, things improved a bit.
> > > > 
> > > > There is a very long story at
> > > > https://www.spinics.net/lists/linux-btrfs/msg70624.html about these
> > > > kinds of things.
> > > > 
> > > > There are unfortunately no easy accessible tools present yet that can
> > > > give live insight in what exactly is happening when it's writing
> > > > metadata like crazy.
> > > > 
> > > > > This is with an older version of BTRFS (4.12.14-lp150.12.73-default) so
> > > > > if algorithms have changed substantially such that deletion rate is no
> > > > > longer tied to file size in newer versions please just say so and I'll
> > > > > be glad to take a look at that change and try with a newer version.
> > > > 
> > > > That seems to be a suse kernel. I have no idea what kind of btrfs is in
> > > > there.
> > > > 
> > > > > FWIW, we are using the v2 free space cache.
> > > > 
> > > > Just to be sure, there are edge cases in which the filesystem says it's
> > > > using space cache v2, but actually isn't.
> > > > 
> > > > Does /sys/fs/btrfs/<UUID>/features/free_space_tree exist?
> > > > 
> > > > Or, of course a fun little program to just do a bogus search in it,
> > > > which explodes if it's not there:
> > > > 
> > > > ---- >8 ----
> > > > #!/usr/bin/python3
> > > > 
> > > > import btrfs
> > > > 
> > > > with btrfs.FileSystem('/') as fs:
> > > >      try:
> > > >          list(fs.free_space_extents(0, 0))
> > > >          print("Yay!")
> > > >      except FileNotFoundError:
> > > >          print("No FST :(")
> > > > ---- >8 ----
> > > > 
> > > > Space cache v1 will cause filesystem stalls combined with a burst of
> > > > writes on every 'transaction commit', and space cache v2 will cause more
> > > > random reads and writes, but they don't block the whole thing.
> > > > 
> > > > > If any other information is
> > > > > relevant to this just let me know and I'll be glad to share.
> > > > 
> > > > Suggestions for things to try, and see what difference it makes:
> > > > 
> > > > * Organize incoming data in btrfs subvolumes in a way that enables you
> > > > to remove the subvol instead of rm'ing the files. If there are a lot of
> > > > files and stuff, this can be more efficient, since btrfs knows about
> > > > what parts to 'cut away' with a chainsaw when removing, instead of
> > > > telling it to do everything file by file in small steps. It also keeps
> > > > the size of the individual subvolume metadata trees down, reducing
> > > > rumination done by the cow. If you don't have them, your default fs tree
> > > > with all file info is relatively seen as large as the extent tree.
> > > > 
> > > > * Remove stuff in the same order as it got added. Remember, rm * removes
> > > > files in alphabetical order, not in the order in which metadata was
> > > > added to disk (the inode number sequence). It might cause less jumping
> > > > around in metadata. Using subvolumes instead is still better, because in
> > > > that case the whole issue does not exist.
> > > > 
> > > > * (not recommended) If your mount options do not show 'ssd' in them and
> > > > your kernel does not have this patch:
> > > > https://www.spinics.net/lists/linux-btrfs/msg64203.html then you can try
> > > > the mount -o ssd_spread,nossd (read the story in the link above).
> > > > Anyway, you're better off moving to something recent instead of trying
> > > > all these obsolete workarounds...
> > > > 
> > > > If you have a kernel >= 4.14 then you're better off mounting with -o ssd
> > > > for rotational disks because the metadata writes are put more together
> > > > in bigger parts of free space, leading to less rumination. There is
> > > > still a lot of research and improvements to be done in this area (again,
> > > > see long post referenced above).
> > > > 
> > > > If you have kernel < 4.14, then definitely do not mount with -o ssd, but
> > > > even mount ssds with -o nossd explicitly. (yes, that's also a
> > > > long story)...
> > > > 
> > > > Fun! :) /o\
> > > > 
> > > > > Thank you for any time people can spare to help us
> > > > > understand this better!
> > > > 
> > > > Don't hesitate to ask more questions,
> > > > Have fun,
> > > > Hans
> > > > 
> > > 
> > 
> 
