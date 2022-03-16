Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F14DB6DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiCPREE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiCPRED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 13:04:03 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D9E8C08
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 10:02:47 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9DB3D2602F8; Wed, 16 Mar 2022 13:02:46 -0400 (EDT)
Date:   Wed, 16 Mar 2022 13:02:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjIYNjq8b7Ar/+Gt@hungrycats.org>
References: <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org>
 <87fsnjnjxr.fsf@vps.thesusis.net>
 <YjD/7zhERFjcY5ZP@hungrycats.org>
 <CAODFU0pwch49XB4oGX0GKvuRyrp+JEYBbrHvHcXTnWapPBQ8Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0pwch49XB4oGX0GKvuRyrp+JEYBbrHvHcXTnWapPBQ8Aw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 11:20:09PM +0100, Jan Ziak wrote:
> On Tue, Mar 15, 2022 at 10:06 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> > This is what makes
> > nodatacow and prealloc slow--on every write, they have to check whether
> > the blocks being written are shared or not, and that check is expensive
> > because it's a linear search of every reference for overlapping block
> > ranges, and it can't exit the search early until it has proven there
> > are no shared references.  Contrast with datacow, which allocates a new
> > unshared extent that it knows it can write to, and only has to check
> > overwritten extents when they are completely overwritten (and only has
> > to check for the existence of one reference, not enumerate them all).
> 
> Some questions:
> 
> - Linear nodatacow search: Do you mean that write(fd1, buf1, 4096) to
> a larger nodatacow file is slower compared to write(fd2, buf2, 4096)
> to a smaller nodatacow file?

Size doesn't matter, the number and position of references do.  It's true
that large extents tend to end up with higher average reference counts
than small extents, but that's only spurious correlation--the "large
extent" and "many references" cases are independent.  An 8K nodatacow
extent, where the first 4K block has exactly one reference and the second
4K has 32767 references, requires a 32768 times more CPU work to write
than a 128M extent with a single reference.

In sane cases, there's only one reference to a nodatacow/prealloc extent,
because multiple references will turn off nodatacow and multiple writes
will turn off prealloc, defeating both features.  When there's only one
reference, the linear search for overlapping blocks ends quickly.

In insane cases (after hole punching, snapshots, reflinks, or writes
to prealloc files) there exist multiple references to the extent,
each covering distinct byte ranges of the extent.  The btrfs trees
only index references from leaf metadata pages to the entire extent,
so to calculate the number of times an individual block is referenced,
we have to iterate over every existing reference to see if it happens to
overlap the blocks of interest.  That's O(N) in the number of references
(roughly--e.g. we don't need to examine different snapshots sharing a
metadata page, because every snapshot sharing a metadata page references
the same bytes in the data extent, but I don't know if btrfs implements
that optimization).

We can't simply read the reference count on the extent for various
reasons.  One is that we don't know what the true reference count is
without walking all parent tree nodes toward the root to see if there's
a snapshot.  The extent is referenced by one metadata page, so its
reference count is 1, but the metadata page is shared by multiple tree
roots, so the true reference count is higher.  Another is that a hole
punched into the middle of an extent causes two references from the same
file, where each reference covers a distinct set of blocks.  None of
the individual blocks are shared, but the extent's reference count is 2.

> - Linear nodatacow search: Does the search happen only with uncached
> metadata, or also with metadata cached in RAM?

All metadata is cached in RAM prior to searching.  I think I missed
where you were going with this question.

> - Extent tree v2 + nodatacow: V2 also features the linear search (like
> v1) or has the search been redesigned to be logarithmic?

I haven't seen the implementation, but the design implies a linear
search over the adjacent range of extent physical addresses that is up
to 2 * max_extent_len wide.  It could be made faster with a clever data
structure, which is implied in the project description, but I haven't
seen details.

There are simple ways to make nodatacow fast, but btrfs doesn't implement
them.  e.g. nodatacow could be a subvol property, where reflink and
snapshot is prohibited over the entire subvol when nodatacow is enabled.
That would eliminate the need to ever search extent references on
write--nodatacow writes could safely assume everything in the subvol is
never shared--and it would match the expectations of people who prefer
that nodatacow takes precedence over all incompatible btrfs features.

> -Jan
