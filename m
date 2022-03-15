Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BF4DA454
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiCOVIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCOVIJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 17:08:09 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5052A483AC
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 14:06:56 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9B49225D275; Tue, 15 Mar 2022 17:06:55 -0400 (EDT)
Date:   Tue, 15 Mar 2022 17:06:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjD/7zhERFjcY5ZP@hungrycats.org>
References: <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org>
 <87fsnjnjxr.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsnjnjxr.fsf@vps.thesusis.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 02:28jjjZ:46PM -0400, Phillip Susi wrote:
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:
> 
> > btrfs extents are immutable, so the filesystem can't extend an existing
> > extent with new data.  Instead, a new extent must be created that contains
> > both the old and new data to replace the old extent.  At least one new
> 
> Wait, what?  How is an extent immutable?  Why isn't a new tree written
> out with a larger extent and once the transaction commits, bam... you've
> enlarged your extent?  Just like modifying any other data.

If the extent is compressed, you have to write a new extent, because
there's no other way to atomically update a compressed extent.

If it's reflinked or snapshotted, you can't overwrite the data in place
as long as a second reference to the data exists.  This is what makes
nodatacow and prealloc slow--on every write, they have to check whether
the blocks being written are shared or not, and that check is expensive
because it's a linear search of every reference for overlapping block
ranges, and it can't exit the search early until it has proven there
are no shared references.  Contrast with datacow, which allocates a new
unshared extent that it knows it can write to, and only has to check
overwritten extents when they are completely overwritten (and only has
to check for the existence of one reference, not enumerate them all).

When a file refers to an extent, it refers to the entire extent from the
file's subvol tree, even if only a single byte of the extent is contained
in the file.  There's no mechanism in btrfs extent tree v1 for atomically
replacing an extent with separately referenceable objects, and updating
all the pointers to parts of the old object to point to the new one.
Any such update could cascade into updates across all reflinks and
snapshots of the extent, so the write multiplier can be arbitrarily large.

There is an extent tree v2 project which provides for splitting
uncompressed extents (compressed extents are always immutable) by storing
all the overlapping references as objects in the extent tree.  It does
reference tracking by creating an extent item for every referenced
block range, so changing one reference's position or length (e.g. by
overwriting or deleting part of an extent reference in a file) doesn't
affect any other reference.  In theory it could also append to the end
of an existing extent, if that case ever came up.

That brings us to the next problem:  mutable extents won't help with
the appending case without also teaching the allocator how to spread out
files all over the disk so there's physical space available at file EOF.

Normally in btrfs, if you write to 3 files, whatever you wrote is packed
into 3 physically contiguous and adjacent extents.  If you then want
to append to the first or second file, you'll need a new extent, because
there's no physical space between the files.

> And do you mean to say that before the new data can be written, the old
> data must first be read in and moved to the new extent?  That seems
> horridly inefficient.

Normally btrfs doesn't read anything when it writes.  New writes create
new extents for the new data, and delete only extents that are completely
replaced by the new extents.

A series of sequential small writes create a lot of small extents,
and small extents are sometimes undesirable.  Defrag gathers these
small extents when they are logically adjacent, reads them into memory,
writes a new physically contiguous extent to replace them, then deletes
the old extents.  Autodefrag is a process that makes defrag happen in
near time to extents that were written recently.

Defrag isn't the only way to resolve the small-extents issue.  If the
file is only read once (e.g. a log file that is rotated and compressed
with a high-performance compressor like xz) then defrag is a waste of
read/write cycles--it's better to leave the small fragments where they
are until they are deleted by an application.
