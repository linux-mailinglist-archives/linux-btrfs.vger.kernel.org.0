Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60694DB918
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiCPUBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 16:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbiCPUBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 16:01:10 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD18B6AA50
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 12:59:54 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 621D7260A8A; Wed, 16 Mar 2022 15:59:44 -0400 (EDT)
Date:   Wed, 16 Mar 2022 15:59:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjJBqetcCAaYWPVs@hungrycats.org>
References: <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org>
 <87fsnjnjxr.fsf@vps.thesusis.net>
 <YjD/7zhERFjcY5ZP@hungrycats.org>
 <877d8twwrn.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d8twwrn.fsf@vps.thesusis.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 02:46:33PM -0400, Phillip Susi wrote:
> 
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:
> 
> > If the extent is compressed, you have to write a new extent, because
> > there's no other way to atomically update a compressed extent.
> 
> Right, that makes sense for compression.
> 
> > If it's reflinked or snapshotted, you can't overwrite the data in place
> > as long as a second reference to the data exists.  This is what makes
> > nodatacow and prealloc slow--on every write, they have to check whether
> > the blocks being written are shared or not, and that check is expensive
> > because it's a linear search of every reference for overlapping block
> > ranges, and it can't exit the search early until it has proven there
> > are no shared references.  Contrast with datacow, which allocates a new
> > unshared extent that it knows it can write to, and only has to check
> > overwritten extents when they are completely overwritten (and only has
> > to check for the existence of one reference, not enumerate them all).
> 
> Right, I know you can't overwrite the data in place.  What I'm not
> understanding is why you can't just just write the new data elsewhere
> and then free the no longer used portion of the old extent.
> 
> > When a file refers to an extent, it refers to the entire extent from the
> > file's subvol tree, even if only a single byte of the extent is contained
> > in the file.  There's no mechanism in btrfs extent tree v1 for atomically
> > replacing an extent with separately referenceable objects, and updating
> > all the pointers to parts of the old object to point to the new one.
> > Any such update could cascade into updates across all reflinks and
> > snapshots of the extent, so the write multiplier can be arbitrarily large.
> 
> So the inode in the subvol tree points to an extent in the extent tree,
> and then the extent points to the space on disk?  

The extent item tracks ownership of the space on disk.  The extent item
key _is_ the location on disk, so there's no need for a pointer in the
item itself (e.g. read doesn't bother with the extent tree, it just goes
straight from the inode ref to the data blocks and csums).  The extent
tree only comes up to resolve ownership issues, like whether the last
reference to an extent has been removed, or a new reference added,
or whether multiple references to the extent exist.

> And only one extent in
> the extent tree can ever point to a given location on disk?

Correct.  That restriction is characteristic of extent tree v1.
Each extent maintains a list of references to itself.  The extent is
the exclusive owner of the physical space, and ownership of the extent
item is shared by multiple inode references.  Each inode reference knows
which bytes of the extent it is referring to, but this information is
scattered over the subvol trees and not available in the extent tree.

Extent tree v2 creates a separate extent object in the extent tree for
each reflink, and allows the physical regions covered by each extent
to overlap.  The inode reference is the exclusive owner of the extent
item, and ownership of the physical space is shared by multiple extents.
The extent tree in v2 tracks which inodes refer to which specific blocks,
so the availability of a block can be computed without referring to any
other trees.

In v2, free space is recalculated when an extent is removed.  The nearby
extent tree is searched to see if any blocks no longer overlap with an
extent, and any such blocks are added to free space.  To me it looks like
that free space search is O(N), since there's no proposed data structure
to make it not a linear search of every possibly-overlapping extent item
(all extents within MAX_EXTENT_SIZE bytes from the point where space
was freed).

The v2 proposal also has a deferred GC worker, so maybe the O(N)
searches will be performed in a background thread where they aren't as
time-sensitive, and maybe the search cost can be amortized over multiple
deletions near the same physical position.  Deferred GC doesn't help
nodatacow or prealloc though, which have to know whether a block is
shared during the write operation, and can't wait until later.

> In other words, if file B is a reflink copy of file A, and you update
> one page in file B, it can't just create 3 new extents in the extent
> tree: one that refers to the firt part of the original extent, one that
> refers to the last part of the original extent, and one for the new
> location of the new data?  Instead file B refers to the original extent,
> and to one new extent, in such a way that the second superceeds part of
> the first only for file B?

Correct.  Changing an extent in tree v1 requires updating every reference
to the extent, because any inode referring to the entire extent will
now need to refer to 3 distinct extent items.  That means updating
metadata pages in snapshots, and can lead to 4-digit multiples of write
amplification with only a few dozen snapshots--in the worst cases there
are page splits because the old data now needs space for 3x more reference
items.  So in v1 we don't do anything like that--extents are immutable
from the moment they are created until their last reference is deleted.

In v2, file B doesn't refer to file A's extent.  Instead, file B creates
a new extent which overlaps the physical space of file A's extent.
After overwriting the one new page, file B then replaces its reference to
file A's space with two new references to shared parts of file A's space,
and a third new extent item for the new data in B.  If file A is later
deleted, the lack of reference to the middle of the physical space is
(eventually) detected, and the overwritten part of the shared extent
becomes free space.
