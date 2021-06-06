Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBB39CD7E
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jun 2021 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhFFFod (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Jun 2021 01:44:33 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48276 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFFoc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Jun 2021 01:44:32 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id CC7DAA8F1A9; Sun,  6 Jun 2021 01:42:42 -0400 (EDT)
Date:   Sun, 6 Jun 2021 01:42:42 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, bug-coreutils@gnu.org
Subject: Re: reflink copying does not check/set No_COW attribute and fail
Message-ID: <20210606054242.GI11733@hungrycats.org>
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
 <20210604201630.GH11733@hungrycats.org>
 <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 05, 2021 at 01:56:49PM +0800, Tom Yan wrote:
> As far as I'm concerned, inheriting an attribute from the source inode
> isn't a "surprising" behavior. Rather it seems pretty "natural" to me.
> And I don't think whether the attribute is "dangerous" changes that,
> because if you consider it "dangerous", shouldn't you "watch out"
> anyway when you try to make a clone of a source with such an
> attribute?

It's important not to conflate the two contexts.  For cp -a, copying
attributes from the src inode might be obvious.  For any other application
(including cp with different arguments), it might be the worst possible
thing to do, especially if we've been doing the opposite for over
a decade.

People run btrfs on crappy SSD and MMC devices, where filesystem csums
are the only way to know the disk is failing (SMART is nonexistent,
and the firmware doesn't bother with any form of working ECC or CRC, so
the first indication of any drive failure is when it starts corrupting
data).  Disabling the datasum bit on any inode is eventually equivalent
to injecting a stream of random undetected corruption into the file when
the drive inevitably fails.  For users with such drives, a mount option
or filesystem feature flag to disable chattr +C globally would make sense,
as they never want any file to be nodatasum for any reason.

If cp -a implements the inode attribute propagation (or inheritance), then
only users of cp -a are impacted.  They are more likely to be aware that
they may be creating new files with reduced-integrity storage attributes.

> If we see it from the way that, the kernel does not make the
> destination inherit nodatasum just to make reflink succeed as much as
> possible, but rather it just by design inherit nodatacow (for the
> reason of being NOT surprising), then there's no concern in whether
> they should "decoupled" when we implement the inheritance. (Like we
> can't set only nodatasum with `chattr either. It's simply out of the
> scope then.)

Thw window for design of these features mostly closed in 2008.  If we
limit the scope as you suggest, we stuck with a lot of the current
behavior now because it is existing kernel API.

If we also fixed some of the other design issues, like the invisible
datasum attribute, we could make the case that at least these automatic
implied inode changes would be _visible to users_.  At the moment,
it requires special tools to inspect the filesystem to see that a file
has its nodatasum bit set, and we probably don't want to start silently
flipping any more inode bits users can't even see.  We already did that
with prealloc and no-compression attributes, and users find it difficult
to understand the resulting changes in btrfs behavior.  There are some
proposals in the works to make all the inode flags visible as xattr
properties, and if those are done then we can say "well at least you
can see that we now change the datasum attribute sometimes."  But it's
a very weak argument.

The kernel has no way to know it's running 'cp -a' or that the intent
is to copy an existing object.  A user could be constructing a new
object using a combination of writes and reflinks from other files
(e.g. a disk image compiler) and intend for the result to have csums
even if the reflinked source files did not.

The kernel only knows that it has been told to create a file with XZ
attributes, and later the user requests cloning data from a file with
XYZ attributes.  If the user didn't intend for the dst file to have
XYZ attributes (and why would she, when she created the file with XZ
attributes?), then it could be a serious regression if the file suddenly
ends up with unintended Y attributes on new kernels.  Without easy
userspace visibility of the nodatasum attribute, it would be difficult
to even _detect_ this change until after silent data corruption gets
bad enough to be noticed.

Contrast with the coreutils package, which has changed its behavior
several times since reflink was first introduced in 2009 to adapt to
changing user expectations.  Nobody expects coreutils to behave quite
the same way from one year to the next, so there is room for innovation
there--and users who don't want the innovations can fork coreutils or
use some other tools.  One such innovation could be to simply detect
this case and make the appropriate inode changes before copying.

On the other hand, maybe nobody has any existing software deployed that
depends on the old kernel behavior, so we can change it after all.  In the
dangerous case (cheap SSD), a sysadmin wouldn't have any nodatacow files
anywhere on the filesystem, so they wouldn't be making reflink copies
of them because none exist.  They could be making a copy of a nodatacow
file from another filesystem, but in that case they would be using normal
copy, since reflink doesn't work across filesystems.  Maybe we can find
all the users who are running reflinking disk image compilers and they
can update their code to work around the proposed new kernel behavior.

> I don't know if we can do that based on whether the reflink mode is
> always. Though we can fallback to "normal" copy when the source has
> nodatasum (and/or nodatacow), personally I don't find it less
> surprising than inheriting nodatacow all the time.

Note that the kernel never sees the reflink argument from cp.  It is
entirely implemented inside the 'cp' command.  In --reflink=auto mode,
cp will first try clone_range, and if the kernel rejects that with an
EINVAL error, then cp will try again with traditional read/write code.
This is after cp has already created the dst file.  The kernel does
not provide a "create a new file with the attributes of an old file"
call--cp has to create the file with open(), and then do a series of
chmod, chown, and setfattr calls in the right order to replicate the
attributes of the old file.

The kernel doesn't guarantee that reflinks are possible in all cases, and
generally does not provide any fallback.  There are multiple possible
responses to a reflink failure and the kernel cannot implement all
of them.  It is up to userspace (i.e. the cp command) to decide what a
correct fallback behavior should be, and then implement it.

> By the way, what will `chattr -C` do exactly if the file/inode had
> nodatacow? Is the behavior different when it is / there is a reflink?

If the file is empty, you can chattr +C or -C.  If the file is not
empty, chattr fails with an error.

All the data extents in a file have to have the same csum status (csum
present or csum absent) as the inode.  It is not allowed to change the
C attribute when data extents exist because the C attribute indirectly
affects whether the extents have data csums or not, and if the inode was
changed it would disagree with existing data extents.  If no data extents
exist (i.e. zero-length file), then the inode attribute can be changed,
because there is nothing present that could disagree with the inode.

It doesn't matter whether reflinks were previously made or not.  In btrfs
there is no difference between a reflink and any other write, in the
same way that there is no difference between a directory entry created
by hardlink versus any other file creation.  Normal writes create a
new data extent, then reflink it to exactly the spot in file where the
data was written.  clone_range creates a reflink to some data extent(s)
that already exist.  Like hardlinks, when a reflink copy is made, it is
not always possible to tell which was the original and which was the copy.

> On Sat, 5 Jun 2021 at 04:16, Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Fri, Jun 04, 2021 at 10:37:35PM +0800, Tom Yan wrote:
> > > Also cc'ing bug-coreutils@gnu.org.
> > >
> > > On Fri, 4 Jun 2021 at 22:33, Tom Yan <tom.ty89@gmail.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I've just bumped into a problem that I am not sure what the expected
> > > > behavior should be, but there seems to be something flawed.
> > > >
> > > > Say I have a file that was created with the No_COW attributed
> > > > (inherited from the directory / subvolume / mount option). Then if I
> > > > try to do a reflink copy, the copying will fail with "Invalid
> > > > argument" if the copy has no one to inherit the No_COW attribute from.
> >
> > Correct.  nodatacow implies nodatasum, and you cannot reflink an extent
> > from a nodatasum inode into a datasum inode.
> >
> > The result of allowing this would be a file that has some extents
> > that have csums, and some that do not.  Making this work would make
> > reading from such a file worse (i.e. make it slower, or fail to detect
> > corruption in metadata).  It's possible to solve some of those problems
> > (or at least contain them in inodes that are known to have mixed csum
> > and non-csum data), but first someone would have to make the case that
> > this is worth the effort to support.
> >
> > > > For example:
> > > > [tom@archlinux mnt]$ sudo btrfs subvol list .
> > > > ID 256 gen 11 top level 5 path a
> > > > ID 257 gen 9 top level 5 path b
> > > > [tom@archlinux mnt]$ lsattr
> > > > ---------------------- ./a
> > > > ---------------C------ ./b
> > > > [tom@archlinux mnt]$ lsattr b/
> > > > ---------------C------ b/test
> > > > [tom@archlinux mnt]$ du -h b/test
> > > > 512M    b/test
> > > > [tom@archlinux mnt]$ lsattr a/
> > > > [tom@archlinux mnt]$ cp --reflink=always b/test a/
> > > > cp: failed to clone 'a/test' from 'b/test': Invalid argument
> > > > [tom@archlinux mnt]$ lsattr a/
> > > > ---------------------- a/test
> > > > [tom@archlinux mnt]$ du a/test
> > > > 0    a/test
> > > > [tom@archlinux mnt]$ du --apparent-size a/test
> > > > 0    a/test
> > > > [tom@archlinux mnt]$ rm a/test
> > > > [tom@archlinux mnt]$ sudo chattr +C a/
> > > > [tom@archlinux mnt]$ cp --reflink=always b/test a/
> > > > [tom@archlinux mnt]$ lsattr a/
> > > > ---------------C------ a/test
> > > > [tom@archlinux mnt]$ cmp b/test a/test
> > > > [tom@archlinux mnt]$
> > > >
> > > > I'm not entirely sure if a reflink copy is supposed to work for a
> > > > source file that was created with No_COW, but apparently it is.
> >
> > Snapshots are also allowed for nodatacow files.  The extents that are
> > shared become implicitly datacow until they are not shared any more.
> >
> > Snapshots are deferred reflink copies, so it would be difficult to
> > allow one and not the other.  Disallowing both seems overly restrictive
> > (e.g. with such a restriction, it would not be possible to use 'btrfs
> > send' or make a snapshot on a subvol that contains any nodatacow file).
> >
> > btrfs did disallow both operations for swap files, so it could be possible
> > to disallow both reflinks and snapshots for nodatacow files, but AFAIK
> > nobody wants that (some people even want the swapfile restrictions to
> > go away someday).
> >
> > > > The
> > > > problem is just that the reflink copy also needs to have the attribute
> > > > set, yet it cannot inherit from the source automatically.
> >
> > reflink can only reflink copy from one nodatasum file to another nodatasum
> > file, or from one datasum file to another datasum file.
> >
> > An empty inode can be changed from datacow to nodatacow (or vice versa)
> > using the fsattr ioctl, which simultaneously changes the file from
> > datasum to nodatasum if the filesystem was not mounted with the nodatasum
> > mount option.
> >
> > There is a possible kernel enhancement here:  when an empty inode is the
> > dst of a reflink, automatically change the reflink dst inode's nodatasum
> > flag to match the reflink src inode's nodatasum flag.  If the dst inode
> > is not empty and the inode datasum flags do not match, then reject the
> > reflink with EINVAL as before.
> >
> > It's not clear whether this should apply only to nodatasum or also to
> > nodatacow.  reflink doesn't need src and dst agreement on nodatacow,
> > so the dst inode could be a nodatasum+datacow file.  Unfortunately all
> > the userspace tools including coreutils can only see the nodatacow
> > inode bit, not the nodatasum bit, so the lack of csums on the dst file
> > would be invisible.  The kernel cannot know the user's intent from the
> > available information.
> >
> > It's not clear that we want the kernel to be implicitly changing
> > inode attribute bits like this--especially bits that disable integrity
> > features like nodatasum.  There is precedent for changing fsattrs with
> > the no-compress inode flag, but that flag doesn't disable csums, and
> > this one would.
> >
> > One could also make the opposite case:  it should always be an error to
> > do anything that would put data in a datasum file without csums, the
> > existing behavior is correct, and should not be changed.  The problem
> > with this argument is that users can't see the datasum inode bits,
> > so it's not clear that the EINVAL is a data protection mechanism.
> >
> > > > I wonder if this is a kernel-side problem or something that coreutils
> > > > missed? It also seems wrong that when it fails there will be an empty
> > > > destination file created.
> >
> > Normally coreutils will fall back to simple copy if --reflink=auto
> > is used.  --reflink=always is the user's explicit request for "reflink
> > or nothing, please."  The user correctly got nothing, as requested.
> >
> > On other filesystems, reflink on a nodatacow file might make a simple
> > copy in the kernel--in which case you are no better off than if you had
> > used --reflink=auto.
> >
> > coreutils could propagate the source inode nodatacow fsattribute to
> > the destination inode if it intends to use reflink to copy the data.
> > That would be the userspace equivalent of the kernel enhancement I
> > suggested above.  It would probably match user expectations better--no
> > hidden surprises for non-coreutils use cases, and all the affected inode
> > attribute bits are necessarily visible in userspace.
> >
> > fsattr propagation could be quite complicated for coreutils to implement
> > correctly in general, as some fsattrs should not be propagated this way,
> > and other filesystems may have different restrictions.  Some fsattrs must
> > be set before the data is written (e.g. -c for compression), others must
> > be set after the data is written (e.g. -i for immutable), and some are
> > a matter of user intent (e.g. should a simple copy be compressed if the
> > source is not?  Depends on the intended use of the copy).
> >
> > On other filesystems this userspace behavior might trigger the opposite
> > of the intended kernel behavior, causing reflink to always fall back to
> > simple copy because the dst inode's nodatacow attribute is set.
> >
> > Ideally btrfs will not force coreutils to do one thing on btrfs and the
> > opposite thing on other filesystems, so it might be worthwhile to hack
> > around this in the kernel as proposed above.  There is precedent for
> > that--btrfs falls back to simple copy in reflinks of inline extents,
> > more or less for the sole purpose of making cp --reflink=always not fail
> > so randomly.
> >
> > > > Kernel version: Linux archlinux 5.12.8-arch1-1 #1 SMP PREEMPT Fri, 28
> > > > May 2021 15:10:20 +0000 x86_64 GNU/Linux
> > > > Coreutils version: 8.32
> > > >
> > > > Regards,
> > > > Tom
