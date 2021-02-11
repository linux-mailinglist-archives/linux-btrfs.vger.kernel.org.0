Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4A318515
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 07:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhBKGNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 01:13:13 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35446 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhBKGNF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 01:13:05 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 718B597C38C; Thu, 11 Feb 2021 01:12:21 -0500 (EST)
Date:   Thu, 11 Feb 2021 01:12:21 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
Message-ID: <20210211061220.GF32440@hungrycats.org>
References: <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
 <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
 <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
 <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it>
 <20210211030836.GE32440@hungrycats.org>
 <20210211031306.GL28049@hungrycats.org>
 <CAJCQCtQ48Vy+FxoqDseu=bAsna5gMo8mc8Fo+ybRG3v_SYFbjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQ48Vy+FxoqDseu=bAsna5gMo8mc8Fo+ybRG3v_SYFbjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 08:39:12PM -0700, Chris Murphy wrote:
> On Wed, Feb 10, 2021 at 8:13 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > Sorry, I busted my mail client.  That was from me.  :-P
> >
> > On Wed, Feb 10, 2021 at 10:08:37PM -0500, kreijack@inwind.it wrote:
> > > On Wed, Feb 10, 2021 at 08:14:09PM +0100, Goffredo Baroncelli wrote:
> > > > Hi Chris,
> > > >
> > > > it seems that systemd-journald is more smart/complex than I thought:
> > > >
> > > > 1) systemd-journald set the "live" journal as NOCOW; *when* (see below) it
> > > > closes the files, it mark again these as COW then defrag [1]
> > > >
> > > > 2) looking at the code, I suspect that systemd-journald closes the
> > > > file asynchronously [2]. This means that looking at the "live" journal
> > > > is not sufficient. In fact:
> > > >
> > > > /var/log/journal/e84907d099904117b355a99c98378dca$ sudo lsattr $(ls -rt *)
> > > > [...]
> > > > --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd4f-0005baed61106a18.journal
> > > > --------------------- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000bd64-0005baed659feff4.journal
> > > > --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd67-0005baed65a0901f.journal
> > > > ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cc63-0005bafed4f12f0a.journal
> > > > ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cc85-0005baff0ce27e49.journal
> > > > ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cd38-0005baffe9080b4d.journal
> > > > ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cd3b-0005baffe908f244.journal
> > > > ---------------C----- user-1000.journal
> > > > ---------------C----- system.journal
> > > >
> > > > The output above means that the last 6 files are "pending" for a de-fragmentation. When these will be
> > > > "closed", the NOCOW flag will be removed and a defragmentation will start.
> > >
> > > Wait what?
> > >
> > > > Now my journals have few (2 or 3 extents). But I saw cases where the extents
> > > > of the more recent files are hundreds, but after few "journalct --rotate" the older files become less
> > > > fragmented.
> > > >
> > > > [1] https://github.com/systemd/systemd/blob/fee6441601c979165ebcbb35472036439f8dad5f/src/libsystemd/sd-journal/journal-file.c#L383
> > >
> > > That line doesn't work, and systemd ignores the error.
> > >
> > > The NOCOW flag cannot be set or cleared unless the file is empty.
> > > This is checked in btrfs_ioctl_setflags.
> > >
> > > This is not something that can be changed easily--if the NOCOW bit is
> > > cleared on a non-empty file, btrfs data read code will expect csums
> > > that aren't present on disk because they were written while the file was
> > > NODATASUM, and the reads will fail pretty badly.  The entire file would
> > > have to have csums added or removed at the same time as the flag change
> > > (or all nodatacow file reads take a performance hit looking for csums
> > > that may or may not be present).
> > >
> > > At file close, the systemd should copy the data to a new file with no
> > > special attributes and discard or recycle the old inode.  This copy
> > > will be mostly contiguous and have desirable properties like csums and
> > > compression, and will have iops equivalent to btrfs fi defrag.
> 
> Journals implement their own checksumming. 

Yeah, Lennart said the same thing six years ago.

I'm using btrfs data csums to detect disk failures (the most important
benefit being that we can stop buying SSD models where silent data
corruption is a problem).  On our systems that have systemd journals,
the journals are pretty big--10% of the writable media.  That's 10%
of the media where defects can hide undetected without csums.

Checking journal csums with a separate tool is crazy.  We used to do
that with git and svn and archive files and media files and a hundred
database formats with ext4, and it was the equivalent of a full time
employee's job trying to figure out where all the chaos was coming from
when a bad disk model came through the fleet.  Never again.

Now btrfs scrub just sends us an email telling us which disk models
are garbage, we stop buying them, and now all the hardware that we buy
(more than once) just works.

If I had to, I'd remove the FS_NOCOW_FL flag support from my kernels to
prevent applications from breaking that.

> Yeah, if there's
> corruption, Btrfs raid can't do a transparent fixup. But the whole
> journal isn't lost, just the affected record. *shrug* I think if (a)
> nodatacow and/or (b) SSD, just leave it alone. Why add more writes?

Well, I'm trying to guess the original intent here.  There are comments
in the systemd git history talking about getting btrfs features back by
turning off nodatacow as systemd closes the journal file.  We can assume
that the existing code turning off the FS_NOCOW_FL bit was intended
to restore data csums (which implies at least reading all the data),
but nobody noticed it doesn't work.  The defrag command that follows
implies an intended copy of the data.  Though with this code it's hard
to tell what's bug, what's intent, and what's cargo cult programming.

If we want the data compressed (and who doesn't?  journal data compresses
8:1 with btrfs zstd) then we'll always need to make a copy at close.
Because systemd used prealloc, the copy is necessarily to a new inode,
as there's no way to re-enable compression on an inode once prealloc
is used (this has deep disk-format reasons, but not as deep as the
nodatacow ones).

If we don't care about compression or datasums, then keep the file
nodatacow and do nothing at close.  The defrag isn't needed and the
FS_NOCOW_FL flag change doesn't work.

> In particular the nodatacow case where I'm seeing consistently the
> file made from multiples of 8MB contiguous blocks, even on HDD the
> seek latency here can't be worth defraging the file.
> 
> I think defrag makes sense (a) datacow journals, i.e. the default
> nodatacow is inhibited (b) HDD.

It makes sense for SSD too.  It's 4K extents, so the metadata and small-IO
overheads will be non-trivial even on SSD.  Deleting or truncating datacow
journal files will put a lot of tiny free space holes into the filesystem.
It will flood the next commit with delayed refs and push up latency.

> In that case the fragmentation is
> quite considerable, hundreds to thousands of extents. It's
> sufficiently bad that it'd be probably be better if they were
> defragmented automatically with a trigger that tests for number of
> non-contiguous small blocks that somehow cheaply estimates latency
> reading all of them. 

Yeah it would be nice of autodefrag could be made to not suck.

Even systemd running defrag_range after writing every 128K-512K would
be so much better than no defrag at all or autodefrag.  Short bursts of
latency, and a small but not unreasonable target extent size.

> Since the files are interleaved, doing something
> like "systemctl status dbus" might actually read many blocks even if
> the result isn't a whole heck of alot of visible data.
> 
> But on SSD, cow or nocow, and HDD nocow - I think just leave them alone.
> 
> -- 
> Chris Murphy
