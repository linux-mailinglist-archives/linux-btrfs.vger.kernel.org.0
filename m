Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C150925B134
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgIBQQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 12:16:39 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45922 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgIBQQX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 12:16:23 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5E6677E30C8; Wed,  2 Sep 2020 12:16:21 -0400 (EDT)
Date:   Wed, 2 Sep 2020 12:16:21 -0400
From:   Zygo Blaxell <zblaxell@furryterror.org>
To:     A L <mail@lechevalier.se>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Hamish Moffatt <hamish-btrfs@moffatt.email>,
        linux-btrfs@vger.kernel.org
Subject: Re: new database files not compressed
Message-ID: <20200902161621.GA5890@hungrycats.org>
References: <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <20200831161505.369be693@natsu>
 <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
 <dede53e.d98f7053.1744e402728@lechevalier.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dede53e.d98f7053.1744e402728@lechevalier.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 02, 2020 at 11:57:41AM +0200, A L wrote:
> 
> 
> ---- From: Nikolay Borisov <nborisov@suse.com> -- Sent: 2020-09-02 - 07:57 ----
> >> 
> >> I've been able to reproduce this with a trivial test program which
> >> mimics the I/O behaviour of Firebird.
> >> 
> >> It is calling fallocate() to set up a bunch of blocks and then writing
> >> them with pwrite(). It seems to be the fallocate() step which is
> >> preventing compression.
> >> 
> >> Here is my trivial test program which just writes zeroes to a file. The
> >> output file does not get compressed by btrfs.
> > 
> > Ag yes, this makes sense, because fallocate creates PREALLOC extents
> > which are NOCOW (since they are essentially empty so it makes no sense
> > to CoW them) hence they go through a different path which doesn't
> > perform compression.
> > 
> 
> Hi, 
> 
> This is interesting. I think that a lot of applications use fallocate
> in their normal operations. This is probably why we see weird compsize
> results every now and then.

fallocate doesn't make a lot of sense on btrfs, except in the special
case of nodatacow files without snapshots.  fallocate breaks compression,
and snapshots/reflinks break fallocate.

bees deallocates preallocated extents on sight (dedupes them with holes).
I didn't bother to implement an option not to, and so far nobody has
asked for one.

Before bees (and even before btrfs), I had LD_PRELOAD hacks to replace
fallocate() with { return 0; }.  On certain other filesystems fallocate
is spectacularly slow, and one application-that-shall-not-be-named in
particular liked to reserve a lot more space than it ever ultimately used.

> A file that is nocow will also not have checksums. Is this true for
> these fallocated files (that has data written to them) too?
> 
> I would really like to see that Btrfs was corrected  so that writes
> to an fallocated area will be compressed (if one is using compression
> that is).

This is difficult to do with the semantics of fallocate, which dictate that
a write to a file within the preallocated region shall not return ENOSPC.

A fallocated extent is overwritten in-place on the first write, but later
writes will be normal copy-on-write.  To be clear, that means they will
occupy other locations on the disk, and may encounter ENOSPC during write.

fallocate is really broken on btrfs datacow files.  The requirements of
each are mutually exclusive unless you allow solutions that can reserve
indefinite amounts of auxiliary space for journalling data blocks.
It's better not to use fallocate at all.

If a fallocated extent is shared (cloned or snapshotted) then it
becomes temporarily copy-on-write until only one reference remains,
then reverts back to in-place writing--even on nodatacow files.
If you're using btrfs send for backups, fallocate doesn't work properly
at best, and wastes space and time at worst.

The unsharing _should_ also mean that the second write to a preallocated
extent should be compressed, but I tried this on kernel 5.7.15 and it
turns out they're not...  :-O

Here's a 1g fallocated file:

	# fallocate -l 1g test
	# sync test
	# filefrag -v test
	Filesystem type is: 9123683e
	File size of test is 1073741824 (262144 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..   65535: 21281040720..21281106255:  65536:             unwritten
	   1:    65536..   98303: 20476350122..20476382889:  32768: 21281106256: unwritten
	   2:    98304..  131071: 20479845152..20479877919:  32768: 20476382890: unwritten
	   3:   131072..  163839: 20483351132..20483383899:  32768: 20479877920: unwritten
	   4:   163840..  196607: 20485055258..20485088025:  32768: 20483383900: unwritten
	   5:   196608..  229375: 20485546782..20485579549:  32768: 20485088026: unwritten
	   6:   229376..  262143: 20675234358..20675267125:  32768: 20485579550: last,unwritten,eof
	test: 7 extents found

Let's turn on compression and dump some compressed data on it:

	# chattr +c test
	# dd if=/boot/System.map-5.7.15 bs=512K seek=1 of=test conv=notrunc
	12+1 records in
	12+1 records out
	6607498 bytes (6.6 MB, 6.3 MiB) copied, 0.070041 s, 94.3 MB/s
	# sync test
	# filefrag -v test
	Filesystem type is: 9123683e
	File size of test is 1073741824 (262144 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..     127: 21281040720..21281040847:    128:             unwritten
	   1:      128..    1741: 21281040848..21281042461:   1614:

720 + (512 / 4 = 128) = 848, this is written in-place on the extent.

	   2:     1742..   65535: 21281042462..21281106255:  63794:             unwritten
	   3:    65536..   98303: 20476350122..20476382889:  32768: 21281106256: unwritten
	   4:    98304..  131071: 20479845152..20479877919:  32768: 20476382890: unwritten
	   5:   131072..  163839: 20483351132..20483383899:  32768: 20479877920: unwritten
	   6:   163840..  196607: 20485055258..20485088025:  32768: 20483383900: unwritten
	   7:   196608..  229375: 20485546782..20485579549:  32768: 20485088026: unwritten
	   8:   229376..  262143: 20675234358..20675267125:  32768: 20485579550: last,unwritten,eof
	test: 7 extents found

OK so we wrote to a fallocated extent and the write as in-place and not
compressed.  Good so far, now let's try writing over the same place again.
The extent is no longer PREALLOC, so it should move to a different place,
and compression can happen:

	# dd if=/boot/System.map-5.7.15 bs=512K seek=1 of=test conv=notrunc
	12+1 records in
	12+1 records out
	6607498 bytes (6.6 MB, 6.3 MiB) copied, 0.0597547 s, 111 MB/s
	# sync test
	# filefrag -v test
	Filesystem type is: 9123683e
	File size of test is 1073741824 (262144 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..     127: 21281040720..21281040847:    128:             unwritten
	   1:      128..    1741: 21281106256..21281107869:   1614: 21281040848:

OK, it moved from 21281040848 to 21281106256, but still isn't compressed.

	   2:     1742..   65535: 21281042462..21281106255:  63794: 21281107870: unwritten
	   3:    65536..   98303: 20476350122..20476382889:  32768: 21281106256: unwritten
	   4:    98304..  131071: 20479845152..20479877919:  32768: 20476382890: unwritten
	   5:   131072..  163839: 20483351132..20483383899:  32768: 20479877920: unwritten
	   6:   163840..  196607: 20485055258..20485088025:  32768: 20483383900: unwritten
	   7:   196608..  229375: 20485546782..20485579549:  32768: 20485088026: unwritten
	   8:   229376..  262143: 20675234358..20675267125:  32768: 20485579550: last,unwritten,eof
	test: 9 extents found

It looks like compressed writes have been disabled for the whole file:

	# dd if=/boot/System.map-5.7.15 bs=512K seek=10000 of=test conv=notrunc
	12+1 records in
	12+1 records out
	6607498 bytes (6.6 MB, 6.3 MiB) copied, 0.144441 s, 45.7 MB/s
	# sync test
	# filefrag -v test
	Filesystem type is: 9123683e
	File size of test is 5249487498 (1281614 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..     127: 21281040720..21281040847:    128:             unwritten
	   1:      128..    1741: 21281106256..21281107869:   1614: 21281040848:
	   2:     1742..   65535: 21281042462..21281106255:  63794: 21281107870: unwritten
	   3:    65536..   98303: 20476350122..20476382889:  32768: 21281106256: unwritten
	   4:    98304..  131071: 20479845152..20479877919:  32768: 20476382890: unwritten
	   5:   131072..  163839: 20483351132..20483383899:  32768: 20479877920: unwritten
	   6:   163840..  196607: 20485055258..20485088025:  32768: 20483383900: unwritten
	   7:   196608..  229375: 20485546782..20485579549:  32768: 20485088026: unwritten
	   8:   229376..  262143: 20675234358..20675267125:  32768: 20485579550: unwritten
	   9:  1280000.. 1281613: 21281107870..21281109483:   1614: 20676284982: last,eof
	test: 10 extents found
	# getfattr -n btrfs.compression test
	# file: test
	btrfs.compression="zstd"

	# lsattr test
	--------c---------- test

This works OK if fallocate is not used:

	# truncate -s 1g test2
	# chattr +c test2
	# sync test2
	# filefrag -v test2
	Filesystem type is: 9123683e
	File size of test2 is 1073741824 (262144 blocks of 4096 bytes)
	test2: 0 extents found
	# dd if=/boot/System.map-5.7.15 bs=512K seek=1 of=test2 conv=notrunc
	12+1 records in
	12+1 records out
	6607498 bytes (6.6 MB, 6.3 MiB) copied, 0.110609 s, 59.7 MB/s
	# sync test2
	# filefrag -v test2
	Filesystem type is: 9123683e
	File size of test2 is 1073741824 (262144 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:      128..     159: 8663165813..8663165844:     32:        128: encoded
	   1:      160..     191: 8663166005..8663166036:     32: 8663165845: encoded
	   2:      192..     223: 8663165607..8663165638:     32: 8663166037: encoded
	   3:      224..     255: 8663166052..8663166083:     32: 8663165639: encoded
	[...snip...]
	  48:     1664..    1695: 8663178516..8663178547:     32: 8663176668: encoded
	  49:     1696..    1727: 8663178709..8663178740:     32: 8663178548: encoded
	  50:     1728..    1741: 8663176937..8663176950:     14: 8663178741: last,encoded
	test2: 51 extents found

> Thanks. 
> 
