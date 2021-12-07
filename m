Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF51E46C2A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 19:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhLGS1A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 13:27:00 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:42410 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240481AbhLGS07 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 13:26:59 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 13:26:59 EST
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id CC0C7BFE5C; Tue,  7 Dec 2021 13:14:37 -0500 (EST)
Date:   Tue, 7 Dec 2021 13:14:37 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: ENOSPC while df shows 826.93GiB free
Message-ID: <20211207181437.GM17148@hungrycats.org>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
 <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
 <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
 <20211207072128.GL17148@hungrycats.org>
 <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 04:07:32PM +0100, Christoph Anton Mitterer wrote:
> On Tue, 2021-12-07 at 02:21 -0500, Zygo Blaxell wrote:
> > If you minimally balance data (so that you keep 2GB unallocated at
> > all
> > times) then it works much better: you can allocate the last metadata
> > chunk that you need to expand, and it requires only a few minutes of
> > IO
> > per day.  After a while you don't need to do this any more, as a
> > large
> > buffer of allocated but unused metadata will form.
> 
> Hm I've already asked Qu in the other mail just before, whether/why
> balancing would help there at all.
> 
> Doesn't it just re-write the block groups (but not defragment them...)
> would that (and why) help to gain back unallocated space (which could
> then be allocated for meta-data)?

It coalesces the free space in each block group into big contiguous
regions, eventually growing them to regions over 1GB in size.  Usually
this gives back unallocated space.

If balance can't pack the extents in 1GB units without changing their
sizes or crossing a block group boundary, then balance might not be
able to free any block groups this way, so this tends to fail when the
filesystem is over about 97% full.  It's important to run the minimal
data balances _before_ this happens, as it's too late to allocate
metadata after.

> And what exactly do you mean with "minimally"? I mean of course I can
> use -dusage=20 or so... is it that?

Minimal balance is exactly one data block group, i.e.

	btrfs balance start -dlimit=1 /fs

Run it when unallocated space gets low.  The exact threshold is low
enough that the time between new data block group allocations is less
than the balance time.

Usage filter is OK for one-off interventions, but repeated use eventually
leads to a filesystem full of block groups that are filled to the
threshold in the usage filter, and no unallocated space.

> But I guess all that wouldn't help now, when the unallocated space is
> already used up, right?

If you have many GB of free space in the block groups, then usually
one can be freed up.  After that, it's a straightforward slot-puzzle,
packing data into the unallocated space.

If the free space is too fragmented or the extents are too large, then
it will not be possible to recover without adding disk space or deleting
data.

> > If you need a drastic intervention, you can mount with
> > metadata_ratio=1
> > for a short(!) time to allocate a lot of extra metadata block groups.
> > Combine with a data block group balance for a few blocks (e.g. -
> > dlimit=9).
> 
> All that seems rather impractical do to, to be honest. At least for an
> non-expert admin.
> 
> First, these systems are production systems... so one doesn't want to
> unmount (and do this procedure) when one sees that unallocated space
> runs out.

I think remount suffices, but I haven't checked.  The mount option is
checked at block allocation time in the code, so it should be possible
to change it live.

It has to be run for a short time because metadata_ratio=1 means 1:1
metadata to data allocation.  You only want to do this to rescue a
filesystem that has become stuck with too little metadata.  Once the
required amount of metadata is allocated, remove the metadata_ratio
option and do minimal data balancing going forward.

> One would rather want some way that if one sees: unallocated space gets
> low -> allocate so and so much for meta data

You can set metadata_ratio=30, which will allocate (100 / 30) = ~3%
of the space for metadata, if you are starting with an empty filesystem.

> I guess there are no real/official tools out there for such
> surveillance? Like Nagios/Icinga checks, that look at the unallocated
> space?

TBH it's never been a problem--but I run the minimal data balance daily,
and scrub every month, and never balance metadata, and have snapshots
and dedupe.  Between these they trigger all the necessary metadata
allocations.

> > You need about (3 + number_of_disks) GB of allocated but unused
> > metadata
> > block groups to handle the worst case (balance, scrub, and discard
> > all
> > active at the same time, plus the required free metadata space). 
> > Also
> > leave room for existing metadata to expand by about 50%, especially
> > if
> > you have snapshots.
> 
> 
> 
> > Never balance metadata.  Balancing metadata will erase existing
> > metadata
> > allocations, leading directly to this situation.
> 
> Wouldn't that only unallocated such allocations, that are completely
> empty?

It will repack existing metadata into existing metadata block groups,
which _creates_ empty block groups (i.e. it removes all the data from
existing groups), then it removes the empty groups.  That's the opposite of
what you want:  you want extra unused space to be kept in the metadata
block groups, so that metadata can expand without having to compete with
data for new block group allocations.

> > > So if csum data needs so much space... why can't it simply reserve
> > > e.g. 60 GB for metadata instead of just 17 GB?
> > 
> > It normally does.  Are you:
> > 
> >         - running metadata balances?  (Stop immediately.)
> 
> Nope, I did once accidentally (-musage=0 ... copy&pasted the wrong one)
> but only *after* the filesystem got stuck...

That can only do one of two things:  have no effect, or make it worse.

> >         - preallocating large files?  Checksums are allocated later,
> > and
> >         naive usage of prealloc burns metadata space due to
> > fragmentation.
> 
> Hmm... not so sure about that... (I mean I don't know what the storage
> middleware, which is www.dcache.org, does)... but it would probably do
> this only for 1 to few such large files at once, if at all.
> 
> 
> >         - modifying snapshots?  Metadata size increases with each
> >         modified snapshot.
> 
> No snapshots are used at all on these filesystems.
> 
> 
> >         - replacing large files with a lot of very small ones?  Files
> >         below 2K are stored in metadata.  max_inline=0 disables this.
> 
> I guess you mean here:
> First many large files were written... unallocated space is used up
> (with data and meta-data block groups).
> Then, large files are deleted... data block groups get fragmented (but
> not unallocated acagain, because they're not empty.
> 
> Then loads of small files would be written (inline)... which then fails
> as meta-data space would fill up even faster, right?

Correct.

> Well we do have filesystems, where there may be *many* small files..
> but I guess still all around the range of 1MB or more. I don't think we
> have lots of files below 2K.. if at all.

In theory if the average file size decreases drastically it can change
the amount of metadata required and maybe require an increase in
metadata ratio after the metadata has been allocated.

Another case happens when you suddenly start using a lot of reflinks
when the filesystem is already completely allocated.

It is possible to contrive cases where metadata usage approaches 100%
of the filesystem, so there's no such thing as allocating "enough"
metadata space for all use cases.

> So I don't think that we have this IO pattern.
> 
> It rather seems simply as if btrfs wouldn't reserve meta-data
> aggressively enough (at least not in our case)... and that to much is
> allocated for data.. and when that is actually filled, it cannot
> allocate anymore enough for metadata.

That's possible (and there are patches attempting to address it).
We don't want to be too aggressive, or the disk fills up with unused
metadata allocations...but we need to be about 5 block groups more
aggressive than we are now to handle special cases like "mount and
write until full without doing any backups or maintenance."

A couple more suggestions (more like exploitable side-effects):

	- Run regular scrubs.  If a write occurs to a block group
	while it's being scrubbed, there's an extra metadata block
	group allocation.

	- Mount with -o ssd.  This makes metadata allocation more
	aggressive (though it also requires more metadata allocation,
	so like metadata_ratio, it might be worth turning off after
	the filesystem fills up).

> 
> 
> Thanks,
> Chris.
