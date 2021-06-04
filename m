Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B439C11B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFDUSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 16:18:20 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34354 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhFDUSU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 16:18:20 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D80C1A8CE2E; Fri,  4 Jun 2021 16:16:31 -0400 (EDT)
Date:   Fri, 4 Jun 2021 16:16:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, bug-coreutils@gnu.org
Subject: Re: reflink copying does not check/set No_COW attribute and fail
Message-ID: <20210604201630.GH11733@hungrycats.org>
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 04, 2021 at 10:37:35PM +0800, Tom Yan wrote:
> Also cc'ing bug-coreutils@gnu.org.
> 
> On Fri, 4 Jun 2021 at 22:33, Tom Yan <tom.ty89@gmail.com> wrote:
> >
> > Hi all,
> >
> > I've just bumped into a problem that I am not sure what the expected
> > behavior should be, but there seems to be something flawed.
> >
> > Say I have a file that was created with the No_COW attributed
> > (inherited from the directory / subvolume / mount option). Then if I
> > try to do a reflink copy, the copying will fail with "Invalid
> > argument" if the copy has no one to inherit the No_COW attribute from.

Correct.  nodatacow implies nodatasum, and you cannot reflink an extent
from a nodatasum inode into a datasum inode.

The result of allowing this would be a file that has some extents
that have csums, and some that do not.  Making this work would make
reading from such a file worse (i.e. make it slower, or fail to detect
corruption in metadata).  It's possible to solve some of those problems
(or at least contain them in inodes that are known to have mixed csum
and non-csum data), but first someone would have to make the case that
this is worth the effort to support.

> > For example:
> > [tom@archlinux mnt]$ sudo btrfs subvol list .
> > ID 256 gen 11 top level 5 path a
> > ID 257 gen 9 top level 5 path b
> > [tom@archlinux mnt]$ lsattr
> > ---------------------- ./a
> > ---------------C------ ./b
> > [tom@archlinux mnt]$ lsattr b/
> > ---------------C------ b/test
> > [tom@archlinux mnt]$ du -h b/test
> > 512M    b/test
> > [tom@archlinux mnt]$ lsattr a/
> > [tom@archlinux mnt]$ cp --reflink=always b/test a/
> > cp: failed to clone 'a/test' from 'b/test': Invalid argument
> > [tom@archlinux mnt]$ lsattr a/
> > ---------------------- a/test
> > [tom@archlinux mnt]$ du a/test
> > 0    a/test
> > [tom@archlinux mnt]$ du --apparent-size a/test
> > 0    a/test
> > [tom@archlinux mnt]$ rm a/test
> > [tom@archlinux mnt]$ sudo chattr +C a/
> > [tom@archlinux mnt]$ cp --reflink=always b/test a/
> > [tom@archlinux mnt]$ lsattr a/
> > ---------------C------ a/test
> > [tom@archlinux mnt]$ cmp b/test a/test
> > [tom@archlinux mnt]$
> >
> > I'm not entirely sure if a reflink copy is supposed to work for a
> > source file that was created with No_COW, but apparently it is. 

Snapshots are also allowed for nodatacow files.  The extents that are
shared become implicitly datacow until they are not shared any more.

Snapshots are deferred reflink copies, so it would be difficult to
allow one and not the other.  Disallowing both seems overly restrictive
(e.g. with such a restriction, it would not be possible to use 'btrfs
send' or make a snapshot on a subvol that contains any nodatacow file).

btrfs did disallow both operations for swap files, so it could be possible
to disallow both reflinks and snapshots for nodatacow files, but AFAIK
nobody wants that (some people even want the swapfile restrictions to
go away someday).

> > The
> > problem is just that the reflink copy also needs to have the attribute
> > set, yet it cannot inherit from the source automatically.

reflink can only reflink copy from one nodatasum file to another nodatasum
file, or from one datasum file to another datasum file.

An empty inode can be changed from datacow to nodatacow (or vice versa)
using the fsattr ioctl, which simultaneously changes the file from
datasum to nodatasum if the filesystem was not mounted with the nodatasum
mount option.

There is a possible kernel enhancement here:  when an empty inode is the
dst of a reflink, automatically change the reflink dst inode's nodatasum
flag to match the reflink src inode's nodatasum flag.  If the dst inode
is not empty and the inode datasum flags do not match, then reject the
reflink with EINVAL as before.

It's not clear whether this should apply only to nodatasum or also to
nodatacow.  reflink doesn't need src and dst agreement on nodatacow,
so the dst inode could be a nodatasum+datacow file.  Unfortunately all
the userspace tools including coreutils can only see the nodatacow
inode bit, not the nodatasum bit, so the lack of csums on the dst file
would be invisible.  The kernel cannot know the user's intent from the
available information.

It's not clear that we want the kernel to be implicitly changing
inode attribute bits like this--especially bits that disable integrity
features like nodatasum.  There is precedent for changing fsattrs with
the no-compress inode flag, but that flag doesn't disable csums, and
this one would.

One could also make the opposite case:  it should always be an error to
do anything that would put data in a datasum file without csums, the
existing behavior is correct, and should not be changed.  The problem
with this argument is that users can't see the datasum inode bits,
so it's not clear that the EINVAL is a data protection mechanism.

> > I wonder if this is a kernel-side problem or something that coreutils
> > missed? It also seems wrong that when it fails there will be an empty
> > destination file created.

Normally coreutils will fall back to simple copy if --reflink=auto
is used.  --reflink=always is the user's explicit request for "reflink
or nothing, please."  The user correctly got nothing, as requested.

On other filesystems, reflink on a nodatacow file might make a simple
copy in the kernel--in which case you are no better off than if you had
used --reflink=auto.

coreutils could propagate the source inode nodatacow fsattribute to
the destination inode if it intends to use reflink to copy the data.
That would be the userspace equivalent of the kernel enhancement I
suggested above.  It would probably match user expectations better--no
hidden surprises for non-coreutils use cases, and all the affected inode
attribute bits are necessarily visible in userspace.

fsattr propagation could be quite complicated for coreutils to implement
correctly in general, as some fsattrs should not be propagated this way,
and other filesystems may have different restrictions.  Some fsattrs must
be set before the data is written (e.g. -c for compression), others must
be set after the data is written (e.g. -i for immutable), and some are
a matter of user intent (e.g. should a simple copy be compressed if the
source is not?  Depends on the intended use of the copy).

On other filesystems this userspace behavior might trigger the opposite
of the intended kernel behavior, causing reflink to always fall back to
simple copy because the dst inode's nodatacow attribute is set.

Ideally btrfs will not force coreutils to do one thing on btrfs and the
opposite thing on other filesystems, so it might be worthwhile to hack
around this in the kernel as proposed above.  There is precedent for
that--btrfs falls back to simple copy in reflinks of inline extents,
more or less for the sole purpose of making cp --reflink=always not fail
so randomly.

> > Kernel version: Linux archlinux 5.12.8-arch1-1 #1 SMP PREEMPT Fri, 28
> > May 2021 15:10:20 +0000 x86_64 GNU/Linux
> > Coreutils version: 8.32
> >
> > Regards,
> > Tom
