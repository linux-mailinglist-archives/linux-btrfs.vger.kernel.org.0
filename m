Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBB25CCCB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 23:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICVw1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 3 Sep 2020 17:52:27 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48730 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgICVw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 17:52:27 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 233877E6DEF; Thu,  3 Sep 2020 17:52:24 -0400 (EDT)
Date:   Thu, 3 Sep 2020 17:52:24 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     A L <mail@lechevalier.se>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Hamish Moffatt <hamish-btrfs@moffatt.email>,
        linux-btrfs@vger.kernel.org
Subject: Re: new database files not compressed
Message-ID: <20200903215223.GB5890@hungrycats.org>
References: <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
 <dede53e.d98f7053.1744e402728@lechevalier.se>
 <20200902161621.GA5890@hungrycats.org>
 <9672d08e-852b-d43d-4fdc-3cd967c53d7d@lechevalier.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9672d08e-852b-d43d-4fdc-3cd967c53d7d@lechevalier.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 05:03:15PM +0200, A L wrote:
> On 2020-09-02 18:16, Zygo Blaxell wrote:
> > On Wed, Sep 02, 2020 at 11:57:41AM +0200, A L wrote:
> > > This is interesting. I think that a lot of applications use fallocate
> > > in their normal operations. This is probably why we see weird compsize
> > > results every now and then.
> > fallocate doesn't make a lot of sense on btrfs, except in the special
> > case of nodatacow files without snapshots.  fallocate breaks compression,
> > and snapshots/reflinks break fallocate.
> 
> Isn't this a strong use-case to improve fallocate behavior on Btrfs?

	fallocate:  you shall write data in exactly in one specific location.

	copy-on-write:	you shall write data anywhere but in one specific
	location.

It's the same specific location for both, so the requirements are mutually
exclusive.  You can only implement the complete requirements for one by
not implementing the requirements for the other, or by restricting each
to separate parts of the filesystem (e.g. datacow and nodatacow files).

btrfs silently ignores fallocate whenever it conflicts with copy-on-write
requirements.  IMHO it would be better for btrfs to reject fallocate
with an error when it is used in one of the allocate-disk-space modes on
a datacow file, but that's just MHO.  It would be clearer if the system
call just failed, so that applications know not to expect the various
guarantees mentioned in the fallocate(2) man page.

I suppose it's possible to have a space reservation system where every
fallocated extent reserves enough space to guarantee that copy-on-write
won't run out of space, and every subvol tracks how much reserved
space it has so that a duplicate space can be reserved in the event
of a non-read-only snapshot.  But that's probably a worse result
overall: suddenly snapshotting a subvol or reflink cloning a file
wants a surprising amount of extra space, and dedupe would never be
able to make that reserved space go away (or would it?  What does it
even mean to dedupe a fallocated extent over a non-fallocated one?
Does that transfer the space reservation, duplicate it, or delete it?
What about deduping the other way?)

Another possibility would be make fallocate able to reserve space
without committing to a location, i.e. "guarantee I can allocate 500 MB
for overwrites in this file at a later time" but without committing to a
specific location within the file as fallocate requires now.  This would
cover data overwrite cases which are not covered by the current btrfs
implementation of the fallocate system call, but it would require yet
another "not-supported-by-all-filesystems" new fallocate flag.

To be strictly correct, fallocate on nodatacow files would have to mark
the subvol non-snapshottable as long as the fallocated extents exist,
and disallow reflink copies of those extents.  That would require some
on-disk format changes to track fallocated extents that contain data.
Administrators would probably want a "disallow fallocate" bit for
subvols if they want to be able to make send/receive backups of them.
There are probably more traps and pitfalls on this path, and good
reasons btrfs didn't go there.

> > > I would really like to see that Btrfs was corrected  so that writes
> > > to an fallocated area will be compressed (if one is using compression
> > > that is).
> > This is difficult to do with the semantics of fallocate, which dictate that
> > a write to a file within the preallocated region shall not return ENOSPC.

> Is this the case when you do `fallocate -l <larger-than-fs-size>`?

In theory the system call would always fail because it can't allocate
that amount of space, so it doesn't have to guarantee anything about
ENOSPC.

Note that fallocate is often emulated by userspace tools and libraries,
so it may behave differently from the kernel call.  Emulation is usually
done by writing zeros with normal write calls, and that doesn't guarantee
anything on btrfs (if anything, it does the opposite, making ENOSPC _more_
likely when writing in the fallocated region).

> > It looks like compressed writes have been disabled for the whole file:
> 
> But this is odd. So we have a file with no special attributes that in effect
> is like a nodatacow file? What happens if we snapshot and then write to the
> file?

Prealloc is an attribute of the _extent reference_, not the file or the
extent (prealloc data blocks logically contain zero, and on disk their
contents are undefined).  The prealloc attribute is removed when data
is written to the extent.  Prealloc is the only part of fallocate's
allocation modes that are implemented by btrfs for datacow files.
fallocate on existing blocks makes no guarantees about ENOSPC when
overwriting those blocks in a btrfs datacow file, and making an extent
unshared has no effect on allocation behavior in a datacow file.

On nodatacow files, nodatacow is a persistent inode attribute that
affects all extents referenced by the inode.  btrfs fallocate behaves
more or less as described by the fallocate(2) man page on nodatacow files
as long as only one reference to each extent exists (snapshot or reflink).

If the extent reference is prealloc or belongs to a nodatacow inode,
and the extent is not shared, then a write puts data in-place within
the existing extent.  This doesn't require allocating space, so the
ENOSPC guarantees of fallocate(2) hold.  If the extent is shared, then
a write allocates a new extent and puts the data there.  If a forced
copy-on-write occurs, the original extent semantics resume with the new
extent (i.e. an extent created by a write becomes nodatacow in a nodatacow
file, and remains datacow in a datacow file).  If there is not sufficient
space for copy-on-write, then the write fails with ENOSPC--this is how
you get ENOSPC when writing to an existing block in a nodatacow file.

In a nutshell, any write (*) to a prealloc or nodatasum extent triggers
a partial backref lookup to see whether the extent is shared or not,
and if the extent is shared, then nodatacow and prealloc attributes are
ignored for the duration of the current write.

(*) I left out some special cases that might come up if you try to follow
along with btrfs-dump-tree, e.g.  when one extent reference is split
into two by writing to the middle of the extent reference with a seek,
that technically makes two references to one extent, but doesn't trigger
shared extent behavior because it is not necessary.

> > 	# dd if=/boot/System.map-5.7.15 bs=512K seek=10000 of=test conv=notrunc
> > 	12+1 records in
> > 	12+1 records out
> > 	6607498 bytes (6.6 MB, 6.3 MiB) copied, 0.144441 s, 45.7 MB/s
> > 	# sync test
> > 	# filefrag -v test
> > 	Filesystem type is: 9123683e
> > 	File size of test is 5249487498 (1281614 blocks of 4096 bytes)
> > 	 ext:     logical_offset:        physical_offset: length:   expected: flags:
> > 	   0:        0..     127: 21281040720..21281040847:    128:             unwritten
> > 	   1:      128..    1741: 21281106256..21281107869:   1614: 21281040848:
> > 	   2:     1742..   65535: 21281042462..21281106255:  63794: 21281107870: unwritten
> > 	   3:    65536..   98303: 20476350122..20476382889:  32768: 21281106256: unwritten
> > 	   4:    98304..  131071: 20479845152..20479877919:  32768: 20476382890: unwritten
> > 	   5:   131072..  163839: 20483351132..20483383899:  32768: 20479877920: unwritten
> > 	   6:   163840..  196607: 20485055258..20485088025:  32768: 20483383900: unwritten
> > 	   7:   196608..  229375: 20485546782..20485579549:  32768: 20485088026: unwritten
> > 	   8:   229376..  262143: 20675234358..20675267125:  32768: 20485579550: unwritten
> > 	   9:  1280000.. 1281613: 21281107870..21281109483:   1614: 20676284982: last,eof
> > 	test: 10 extents found
> > 	# getfattr -n btrfs.compression test
> > 	# file: test
> > 	btrfs.compression="zstd"
> > 
> > 	# lsattr test
> > 	--------c---------- test
> > 
> > This works OK if fallocate is not used:
> > 
> > 	# truncate -s 1g test2
> > 	# chattr +c test2
> > 	# sync test2
> > 	# filefrag -v test2
> > 	Filesystem type is: 9123683e
> > 	File size of test2 is 1073741824 (262144 blocks of 4096 bytes)
> > 	test2: 0 extents found
> > 	# dd if=/boot/System.map-5.7.15 bs=512K seek=1 of=test2 conv=notrunc
> > 	12+1 records in
> > 	12+1 records out
> > 	6607498 bytes (6.6 MB, 6.3 MiB) copied, 0.110609 s, 59.7 MB/s
> > 	# sync test2
> > 	# filefrag -v test2
> > 	Filesystem type is: 9123683e
> > 	File size of test2 is 1073741824 (262144 blocks of 4096 bytes)
> > 	 ext:     logical_offset:        physical_offset: length:   expected: flags:
> > 	   0:      128..     159: 8663165813..8663165844:     32:        128: encoded
> > 	   1:      160..     191: 8663166005..8663166036:     32: 8663165845: encoded
> > 	   2:      192..     223: 8663165607..8663165638:     32: 8663166037: encoded
> > 	   3:      224..     255: 8663166052..8663166083:     32: 8663165639: encoded
> > 	[...snip...]
> > 	  48:     1664..    1695: 8663178516..8663178547:     32: 8663176668: encoded
> > 	  49:     1696..    1727: 8663178709..8663178740:     32: 8663178548: encoded
> > 	  50:     1728..    1741: 8663176937..8663176950:     14: 8663178741: last,encoded
> > 	test2: 51 extents found
> > 
> > > Thanks.
> > > 
> 
