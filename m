Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4323F31A8B7
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBMARw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 19:17:52 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38536 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhBMARj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 19:17:39 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6D998981174; Fri, 12 Feb 2021 19:16:49 -0500 (EST)
Date:   Fri, 12 Feb 2021 19:16:49 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
Message-ID: <20210213001649.GI32440@hungrycats.org>
References: <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
 <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
 <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it>
 <20210211030836.GE32440@hungrycats.org>
 <20210211031306.GL28049@hungrycats.org>
 <CAJCQCtQ48Vy+FxoqDseu=bAsna5gMo8mc8Fo+ybRG3v_SYFbjg@mail.gmail.com>
 <20210211061220.GF32440@hungrycats.org>
 <CAJCQCtQnvVUVhTPQ1v=mw=jDBbsHb5HAa5=s3E+AWuBD7pSO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQnvVUVhTPQ1v=mw=jDBbsHb5HAa5=s3E+AWuBD7pSO2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 11, 2021 at 01:46:07AM -0700, Chris Murphy wrote:
> On Wed, Feb 10, 2021 at 11:12 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> 
> 
> >
> > If we want the data compressed (and who doesn't?  journal data compresses
> > 8:1 with btrfs zstd) then we'll always need to make a copy at close.
> > Because systemd used prealloc, the copy is necessarily to a new inode,
> > as there's no way to re-enable compression on an inode once prealloc
> > is used (this has deep disk-format reasons, but not as deep as the
> > nodatacow ones).
> 
> Pretty sure sd-journald still fallocates when datacow by touching
> /etc/tmpfiles.d/journal-nocow.conf

Fallocate on datacow just wastes space and CPU time if the application
is not doing sequential 4K writes with no overwrites (sequential keeps
the metadata at bounded size, otherwise it grows too).  Datacow takes
precedence over fallocate.  It works only when you're overwriting a
prealloc block with a data block for the first time, and after that
it's just datacow with compress disabled and a reference to a big
extent that doesn't go away until the last block is overwritten.

I think fallocate on datacow should be deprecated and removed from btrfs.
Fixing it doesn't seem to be possible without Pyrrhic time or space costs.
On the other hand, it does have that one working use case, and I could be
convinced to back down if someone shows me one example of an application
in the wild that is using fallocate + datacow on btrfs correctly.

> And I know for sure those datacow files do compress on rotation.

Hmmm...OK, I missed that defrag can force compression in a prealloc file
because it bypasses the inode check for prealloc (same for reflinks,
you can reflink a compressed extent into a prealloc file if you wrote
the extent in a non-prealloc file).  It is only normal compressed writes
directly to the inode that are blocked by prealloc.

So we can keep the inode, but compression still only happens by making
a copy of all the data with defrag.  If the data is still in page cache
then we can skip the read, at least.

> Preallocated datacow might not be so bad if it weren't for that one
> damn header or indexing block, whatever the proper term is, that
> sd-journald hammers every time it fsyncs. 

It seems to write every other block more than once too.

> I don't know if I wanna know
> what it means to snapshot a datacow file that's prealloc. 

The first subvol to write to the prealloc data blocks gets to write
in-place.  All others get datacow, just like nodatacow files when they
have a reflink.

It is basically the same as the nodatacow extent-sharing check, except
competing prealloc refs can be ignored (they will read as zero, and if
they are written they will do their own extent-sharing check and notice
they have lost the race to use the allocated block).

> But in
> theory if the same blocks weren't all being hammered, a preallocated
> file shouldn't fragment like hell if each prealloc block gets just one
> write.

That is the key, each block must have only one 4K write, ever.  Writing 2x
adjacent 2K blocks seems to count as 2 writes even if they are 4K aligned
and there is no flush or commit in between.

> > If we don't care about compression or datasums, then keep the file
> > nodatacow and do nothing at close.  The defrag isn't needed and the
> > FS_NOCOW_FL flag change doesn't work.
> 
> Agreed.
> 
> 
> > It makes sense for SSD too.  It's 4K extents, so the metadata and small-IO
> > overheads will be non-trivial even on SSD.  Deleting or truncating datacow
> > journal files will put a lot of tiny free space holes into the filesystem.
> > It will flood the next commit with delayed refs and push up latency.
> 
> I haven't seen meaningful latency on a single journal file, datacow
> and heavily fragmented, on ssd. 

Someone pushed back last time I proposed simply letting datacow be
datacow, citing high latency on NVME devices.  I'm not sure what
"meaningful" latency is...journalctl takes a crazy long time to start
up compared to, say, 'tail -F' or 'less'.

I've always assumed journald's file format was an interim thing that would
have been deprecated and replaced years ago (you know you've failed to
design a file format when 'less' is winning races against you).  I never
started using it, so I've never investigated what's really wrong with it
(or what compelling advantage offsets the problems it seems to have).

> But to test on more than one file at a
> time i need to revert the defrag commits, and build systemd, and let a
> bunch of journals accumulate somehow. If I dump too much data
> artificially to try and mimic aging, I know I will get nowhere near as
> many of those 4KiB extents. So I dunno.

Something like:

	while :; do
		date > /dev/kmsg
		date >> logfile
		sync logfile
	done

should be the worst case for both journald and a plaintext logfile.
Maybe needs a 'sleep 1' to space things out for journald.

> > > In that case the fragmentation is
> > > quite considerable, hundreds to thousands of extents. It's
> > > sufficiently bad that it'd be probably be better if they were
> > > defragmented automatically with a trigger that tests for number of
> > > non-contiguous small blocks that somehow cheaply estimates latency
> > > reading all of them.
> >
> > Yeah it would be nice of autodefrag could be made to not suck.
> 
> It triggers on inserts, not appends. So it doesn't do anything for the
> sd-journald case.

Appends are probably where autodefrag is most useful, and also cheapest
(the cold data is more likely to still be in page cache for appends than
it is for mid-file inserts), and also really common (lots of programs
have log files).  It would be nice if autodefrag could be configured to
do those and nothing else--I might even be able to use it then.

> I would think the active journals are the one more likely to get
> searched for recent events than archived journals. So in the datacow
> case, you only get relief once it's rotated. It'd be nice to find an
> decent, not necessarily perfect, way for them to not get so fragmented
> in the first place. Or just defrag once a file has 16M of
> non-contiguous extents.

Or run defrag_range on the tail of the file every time the file grows
by 128K.  Huge extents aren't required to get OK performance, we only
need to avoid tiny extents because they are cripplingly slow.  64K is
almost an OOM better than 4K for sequential reading over SATA.  128K
isn't much bigger and would line up nicely with compressed extent size.

> Estimating extents though is another issue, especially with compression enabled.

Shouldn't be necessary.  Either it's nodatacow and the extent sizes are
all 8M (or whatever size you requested in fallocate), or it's datacow
and the extent size is always 4K (or you have truly huge journal data
volumes and none of this matters because even datacow will give good
extent sizes on a firehose of data).  There will not be compression if
there are no 8K single-commit writes (have to save at least 4K per write,
or btrfs won't be able to compress).

> 
> -- 
> Chris Murphy
