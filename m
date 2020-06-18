Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA41FE949
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 05:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFRDPp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 17 Jun 2020 23:15:45 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47172 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFRDPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 23:15:45 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5F5C671E709; Wed, 17 Jun 2020 23:15:43 -0400 (EDT)
Date:   Wed, 17 Jun 2020 23:15:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS File Delete Speed Scales With File Size?
Message-ID: <20200618031542.GL10769@hungrycats.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
 <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
 <1a88f0e4-3fd1-b0bc-308e-c12b9f64b46c@panasas.com>
 <20200616035640.GK10769@hungrycats.org>
 <d832607a-bfba-4f52-7c4e-05e3decacbf5@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d832607a-bfba-4f52-7c4e-05e3decacbf5@panasas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 09:25:16AM -0400, Ellis H. Wilson III wrote:
> First and foremost Zygo, apologies for not having responded to your prior
> two emails.  I was alerted by a colleague that we'd gotten a response, and
> found that very unfortunately our MS filter had marked your emails as spam.
> I've unmarked them so hopefully this doesn't happen in the future.
> 
> A few comments on prior emails, and then responses in-line:
> 
> 40 threads is simply the max due to the nature of our OSD architecture. We
> can make good use of them in the case of heavy PFS metadata updates (which
> do not go to BTRFS), but yes, they can overwhelm spinning rust under very
> heavy deletion workloads.  We're looking into task queuing to throttle this.
> 
> We are less concerned about the ability to process deletes in O(1) or
> O(log(n)) time, and more concerned about not holding up foreground I/O while
> a number of them are processed (ideally in the background).

So to clarify:  you want O(1) in the foreground thread (the one that calls
unlink()) and O(log(n)) in the background thread.  Also, you want to be
able to designate some threads as foreground and others as background.



> On 6/15/20 11:56 PM, Zygo Blaxell wrote:
> > > 2. We find that speed to delete and fsync the directory on 4.12 is
> > > equivalent to delete and then sync the entire filesystem.
> > 
> > I'm not quite sure how fsync() is relevant here--fsync() doesn't do
> > anything about delayed refs, unless fsync() accidentally triggers a full
> > sync (which I wouldn't expect to happen when fsyncing a simple unlink).
> 
> fsync is how we are guaranteeing that either a write or create has occurred
> to a new file, or a delete has been acknowledged by the underlying FS and
> will be rolled forward on power-fail.  We recognize there may be non-trivial
> work involved in rolling that forward on reboot, especially on spinners.  It
> was of interest because previously I was (wrongly, at least relative to our
> use of BTRFS in our PFS) timing both the remove and the full 'sync'
> together, rather than just the remove and the fsync of the housing
> directory.  I agree in 4.12 the dominant time is the remove, so switching
> didn't matter, but it does matter in 5.7, for reasons you elucidate
> elsewhere.
> 
> > 4.12 throttles unlink() to avoid creating huge backlogs of ref updates
> > in kernel memory.  During the throttling, previously delayed refs
> > (including ref updates caused by other threads) are processed by the
> > kernel thread servicing the unlink() system call.
> > 
> > 5.7 doesn't throttle unlink(), so the unlink() system call simply queues
> > delayed ref updates as quickly as the kernel can allocate memory.
> > Once kernel memory runs out, unlink() will start processing delayed
> > refs during the unlink() system call, blocking the caller of unlink().
> > If memory doesn't run out, then the processing happens during transaction
> > commit in some other thread (which may be btrfs-transaction, or some
> > other unlucky user thread writing to the filesystem that triggers delayed
> > ref processing).
> 
> The above is exactly the explanation I've been looking for.  Thank you!
> 
> > In both kernels there will be bursts of fast processing as unlink()
> > borrows memory, with occasional long delays while unlink() (or some other
> > random system call) pays off memory debt.  4.12 limited this borrowing
> > to thousands of refs and most of the payment to the unlink() caller;
> > in 5.7, there are no limits, and the debt to be paid by a random user
> > thread can easily be millions of refs, each of which may require a page
> > of IO to complete.
> 
> Are there any user-tunable settings for this in 4.12?  We would be extremely
> interested in bumping the outstanding refs in that version if doing so was
> as simple as a sysctl, hidden mount option, or something similar.

You found the code already.  The specific delayed ref limit is computed
with hardcoded parameters in the kernel, but trivial to change there.

On the other hand, changing it doesn't have very much effect:  you
still don't get to pick which threads are foreground or background.
If the limit is low (as in 4.12) then usually the thread that ends
up stuck with the IO cost is the one that's incurring the IO cost
(i.e. it's the thread doing unlink(), which can be a background worker
thread in your application).  If the limit is high (as in 5.7) then the
thread that gets stuck with the IO cost is much more random (it will be
whichever thread is running when one of several trigger conditions occurs)
and you also get the other bad side-effects of having long update queues.

This is where a lot of write latency in btrfs comes from, and why it's
so hard to avoid priority inversions on btrfs.  Whenever you modify the
filesystem, delayed ref updates go into a single queue where they are
merged with other updates already queued.  There's no priority management
there (AIUI the delayed ref update IO bypasses normal ionice and blkio
cgroup priority settings and doesn't implement any priority algorithm
of its own), so no notion of a "foreground" or "background" thread is
supported--all threads are equal.  What happens instead is that any of
the threads which are trying to perform a write operation on btrfs may
bear the full cost of completing delayed ref updates previously queued
by all threads.

If you have a very predictable bursty workload (e.g. you can quantify
exactly how many extent references will be changed per minute across the
filesystem) then you can increase the hardcoded throttle parameters so
that delayed refs are not throttled below that number, and keep enough
free RAM in the system so the kernel does not run out.  As long as the
limit is not exceeded, delayed ref flushing won't occur until scheduled
transaction commits, and the updates will truly occur in the background
(i.e. only in the btrfs-transaction thread).  As soon as the limit is
exceeded, some thread (you don't get to choose which one) will block,
and block longer if the limit is higher.

If you don't have a predictable workload, then it's better to do the
unlinks in a low-priority (possibly even self-throttling) thread with
4.12-style throttling in the unlink() syscall.  For things like build
servers that have to wipe out large working trees, I move the root of
the tree aside to a deletion queue directory, and a background worker
thread does 'rm -fr' on whatever appears in that directory--slowly.
Other threads still get blocked at random, but only a few seconds at a
time.

If we are considering btrfs modifications, an on-disk delayed ref log
might help, at least for the more expensive ref deletes (the ones that
must fetch and modify pages in extent and csum trees).  This would
be processed in the background the same way snapshot deletes are.
Putting the queued ref deletes on disk removes their CoW updates from the
commit critical path, so that any thread that gets stuck with delayed
ref flushing only has to do the cheaper add-ref operations, instead
of the full delayed ref processing.  This idea might not be sane, I'm
thinking aloud here.  Also requires an on-disk format change, so it's
minimum a year away from becoming reality just for that.

A simpler modification is to make unlink() convert the inode into an
orphan inode, then the unlink() syscall returns, and btrfs-cleaner removes
the extents and orphan inode later (with throttling).  That might annoy
users with small filesystems who do big 'rm -rf' followed by big tarball
extracts--a sync would be needed in between in order to avoid running out
of disk space.  That used to be a chronic problem in older versions of
btrfs, and AIUI throttling unlink() calls at the source was the solution.

It might also be useful to implement some kind of priority queue in the
delayed refs code; however, we want transactions to commit at some point,
and the current design requires all the delayed refs to be done before
the commit can happen.  There would need to be some kind of transaction
pipelining to allow high-priority threads to get ahead of low-priority
ones, and even then, all threads have equal priority when there is no
more memory available to defer low-priority work.

> > > Any comments on when major change(s) came in that would impact these
> > > behaviors would be greatly appreciated.
> > 
> > Between 4.20 and 5.0 the delayed ref throttling went away, which might
> > account for a sudden shift of latency to a different part of the kernel.
> > 
> > The impact is that there is now a larger window for the filesystem to
> > roll back to earlier versions of the data after a crash.  Without the
> > throttling, unlink can just keep appending more and more ref deletes to
> > the current commit faster than the disks can push out updated metadata.
> > As a result, there is a bad case where the filesystem spends all of
> > its IO time trying to catch up to metadata updates, but never successfully
> > completes a commit on disk.
> > 
> > A crash rolls back to the previous completed commit and replays the
> > fsync log.  A crash on a 5.0 to 5.7 kernel potentially erases hours of
> > work, or forces the filesystem to replay hours of fsync() log when the
> > filesystem is mounted again.  This requires specific conditions, but it
> > sounds like your use case might create those conditions.
> 
> Yes, we might under the right end-user scenarios and just the right timed
> power-fail, but we have appropriate states for the PFS to cope with this
> that can include a very lengthy bring-up period, of which mounting BTRFS is
> already included.  Erasing acknowledged fsync'd work would be a breach of
> POSIX and concerning, but taking time on mount to replay things like this is
> both expected and something we do at a higher level in our PFS so we get it.

Power-fail timing isn't particularly hard.  If data is coming
in continuously faster than the disks can write it, and commits are
taking an average of 3 hours each, you have only 8 commits per day,
so a randomly timed power failure wipes out an average of 90 minutes of
non-fsynced filesystem changes.

The behavior is an extreme interpretation of POSIX (and Linux conventions
around fsync):  everything that is flushed with fsync() stays flushed,
everything that is not flushed with fsync() reverts to its state at the
previous commit.  It's even useful to force this behavior when you want
to test programs to verify they're calling fsync() everywhere they should.

> > Some details:
> > 
> > 	https://lore.kernel.org/linux-btrfs/20200209004307.GG13306@hungrycats.org/
> > 
> > 5.7 has some recent delayed ref processing improvements, but AFAIK
> > the real fixes (which include putting the throttling back) are still
> > in development.
> 
> All extremely helpful info Zygo.  Thank you again, and do let me know if
> there are any tunables we can play with in 4.12 to better mimic the behavior
> we're seeing in 5.7.  We'd be indebted to find out there were.
> 
> Best,
> 
> ellis
