Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457CEB0547
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 23:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfIKVhg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 11 Sep 2019 17:37:36 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47520 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbfIKVhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 17:37:36 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5E47C420C40; Wed, 11 Sep 2019 17:37:04 -0400 (EDT)
Date:   Wed, 11 Sep 2019 17:37:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     webmaster@zedlx.com
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190911213704.GB22121@hungrycats.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 01:20:53PM -0400, webmaster@zedlx.com wrote:
> 
> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> 
> > On 2019-09-10 19:32, webmaster@zedlx.com wrote:
> > > 
> > > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> > > 
> 
> > > 
> > > === I CHALLENGE you and anyone else on this mailing list: ===
> > > 
> > >  - Show me an exaple where splitting an extent requires unsharing,
> > > and this split is needed to defrag.
> > > 
> > > Make it clear, write it yourself, I don't want any machine-made outputs.
> > > 
> > Start with the above comment about all writes unsharing the region being
> > written to.
> > 
> > Now, extrapolating from there:
> > 
> > Assume you have two files, A and B, each consisting of 64 filesystem
> > blocks in single shared extent.  Now assume somebody writes a few bytes
> > to the middle of file B, right around the boundary between blocks 31 and
> > 32, and that you get similar writes to file A straddling blocks 14-15
> > and 47-48.
> > 
> > After all of that, file A will be 5 extents:
> > 
> > * A reflink to blocks 0-13 of the original extent.
> > * A single isolated extent consisting of the new blocks 14-15
> > * A reflink to blocks 16-46 of the original extent.
> > * A single isolated extent consisting of the new blocks 47-48
> > * A reflink to blocks 49-63 of the original extent.
> > 
> > And file B will be 3 extents:
> > 
> > * A reflink to blocks 0-30 of the original extent.
> > * A single isolated extent consisting of the new blocks 31-32.
> > * A reflink to blocks 32-63 of the original extent.
> > 
> > Note that there are a total of four contiguous sequences of blocks that
> > are common between both files:
> > 
> > * 0-13
> > * 16-30
> > * 32-46
> > * 49-63
> > 
> > There is no way to completely defragment either file without splitting
> > the original extent (which is still there, just not fully referenced by
> > either file) unless you rewrite the whole file to a new single extent
> > (which would, of course, completely unshare the whole file).  In fact,
> > if you want to ensure that those shared regions stay reflinked, there's
> > no way to defragment either file without _increasing_ the number of
> > extents in that file (either file would need 7 extents to properly share
> > only those 4 regions), and even then only one of the files could be
> > fully defragmented.
> > 
> > Such a situation generally won't happen if you're just dealing with
> > read-only snapshots, but is not unusual when dealing with regular files
> > that are reflinked (which is not an uncommon situation on some systems,
> > as a lot of people have `cp` aliased to reflink things whenever
> > possible).
> 
> Well, thank you very much for writing this example. Your example is
> certainly not minimal, as it seems to me that one write to the file A and
> one write to file B would be sufficient to prove your point, so there we
> have one extra write in the example, but that's OK.
> 
> Your example proves that I was wrong. I admit: it is impossible to perfectly
> defrag one subvolume (in the way I imagined it should be done).
> Why? Because, as in your example, there can be files within a SINGLE
> subvolume which share their extents with each other. I didn't consider such
> a case.
> 
> On the other hand, I judge this issue to be mostly irrelevant. Why? Because
> most of the file sharing will be between subvolumes, not within a subvolume.
> When a user creates a reflink to a file in the same subvolume, he is
> willingly denying himself the assurance of a perfect defrag. Because, as
> your example proves, if there are a few writes to BOTH files, it gets
> impossible to defrag perfectly. So, if the user creates such reflinks, it's
> his own whish and his own fault.
> 
> Such situations will occur only in some specific circumstances:
> a) when the user is reflinking manually
> b) when a file is copied from one subvolume into a different file in a
> different subvolume.
> 
> The situation a) is unusual in normal use of the filesystem. Even when it
> occurs, it is the explicit command given by the user, so he should be
> willing to accept all the consequences, even the bad ones like imperfect
> defrag.
> 
> The situation b) is possible, but as far as I know copies are currently not
> done that way in btrfs. There should probably be the option to reflink-copy
> files fron another subvolume, that would be good.

Reflink copies across subvolumes have been working for years.  They are
an important component that makes dedupe work when snapshots are present.

> But anyway, it doesn't matter. Because most of the sharing will be between
> subvolumes, not within subvolume. 

Heh.  I'd like you to meet one of my medium-sized filesystems:

	Physical size:  8TB
	Logical size:  16TB
	Average references per extent:  2.03 (not counting snapshots)
	Workload:  CI build server, VM host

That's a filesystem where over half of the logical data is reflinks to the
other physical data, and 94% of that data is in a single subvol.  7.5TB of
data is unique, the remaining 500GB is referenced an average of 17 times.

We use ordinary applications to make ordinary copies of files, and do
tarball unpacks and source checkouts with reckless abandon, all day long.
Dedupe turns the copies into reflinks as we go, so every copy becomes
a reflink no matter how it was created.

For the VM filesystem image files, it's not uncommon to see a high
reflink rate within a single file as well as reflinks to other files
(like the binary files in the build directories that the VM images are
constructed from).  Those reference counts can go into the millions.

> So, if there is some in-subvolume sharing,
> the defrag wont be 100% perfect, that a minor point. Unimportant.

It's not unimportant; however, the implementation does have to take this
into account, and make sure that defrag can efficiently skip extents that
are too expensive to relocate.  If we plan to read an extent fewer than
100 times, it makes no sense to update 20000 references to it--we spend
less total time just doing the 100 slower reads.  If the numbers are
reversed then it's better to defrag the extent--100 reference updates
are easily outweighed by 20000 faster reads.  The kernel doesn't have
enough information to make good decisions about this.

Dedupe has a similar problem--it's rarely worth doing a GB of IO to
save 4K of space, so in practical implementations, a lot of duplicate
blocks have to remain duplicate.

There are some ways to make the kernel dedupe and defrag API process
each reference a little more efficiently, but none will get around this
basic physical problem:  some extents are just better off where they are.

Userspace has access to some extra data from the user, e.g.  "which
snapshots should have their references excluded from defrag because
the entire snapshot will be deleted in a few minutes."  That will allow
better defrag cost-benefit decisions than any in-kernel implementation
can make by itself.

'btrfs fi defrag' is just one possible userspace implementation, which
implements the "throw entire files at the legacy kernel defrag API one
at a time" algorithm.  Unfortunately, nobody seems to have implemented
any other algorithms yet, other than a few toy proof-of-concept demos.

> > > About merging extents: a defrag should merge extents ONLY when both
> > > extents are shared by the same files (and when those extents are
> > > neighbours in both files). In other words, defrag should always
> > > merge without unsharing. Let's call that operation "fusing extents",
> > > so that there are no more misunderstandings.
> 
> > And I reiterate: defrag only operates on the file it's passed in.  It
> > needs to for efficiency reasons (we had a reflink aware defrag for a
> > while a few years back, it got removed because performance limitations
> > meant it was unusable in the cases where you actually needed it). Defrag
> > doesn't even know that there are reflinks to the extents it's operating
> > on.
> 
> If the defrag doesn't know about all reflinks, that's bad in my view. That
> is a bad defrag. If you had a reflink-aware defrag, and it was slow, maybe
> that happened because the implementation was bad. Because, I don't see any
> reason why it should be slow. So, you will have to explain to me what was
> causing this performance problems.
> 
> > Given this, defrag isn't willfully unsharing anything, it's just a
> > side-effect of how it works (since it's rewriting the block layout of
> > the file in-place).
> 
> The current defrag has to unshare because, as you said, because it is
> unaware of the full reflink structure. If it doesn't know about all
> reflinks, it has to unshare, there is no way around that.
> 
> > Now factor in that _any_ write will result in unsharing the region being
> > written to, rounded to the nearest full filesystem block in both
> > directions (this is mandatory, it's a side effect of the copy-on-write
> > nature of BTRFS, and is why files that experience heavy internal
> > rewrites get fragmented very heavily and very quickly on BTRFS).
> 
> You mean: when defrag performs a write, the new data is unshared because
> every write is unshared? Really?
> 
> Consider there is an extent E55 shared by two files A and B. The defrag has
> to move E55 to another location. In order to do that, defrag creates a new
> extent E70. It makes it belong to file A by changing the reflink of extent
> E55 in file A to point to E70.
> 
> Now, to retain the original sharing structure, the defrag has to change the
> reflink of extent E55 in file B to point to E70. You are telling me this is
> not possible? Bullshit!

This is already possible today and userspace tools can do it--not as
efficiently as possible, but without requiring more than 128M of temporary
space.  'btrfs fi defrag' is not one of those tools.

> Please explain to me how this 'defrag has to unshare' story of yours isn't
> an intentional attempt to mislead me.

Austin is talking about the btrfs we have, not the btrfs we want.
