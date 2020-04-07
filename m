Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988421A04BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDGCKO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 6 Apr 2020 22:10:14 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43202 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgDGCKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 22:10:13 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E63A06592DB; Mon,  6 Apr 2020 22:10:11 -0400 (EDT)
Date:   Mon, 6 Apr 2020 22:10:06 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
Message-ID: <20200407021006.GN13306@hungrycats.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <636dfbc5-32a7-bdf3-b83b-93e65901aa43@oracle.com>
 <CAL3q7H5r9tjzBzLK7iG5uLztujm=s7rZvuT=TYCUhr61OG-brQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAL3q7H5r9tjzBzLK7iG5uLztujm=s7rZvuT=TYCUhr61OG-brQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 06, 2020 at 05:25:04PM +0100, Filipe Manana wrote:
> On Mon, Apr 6, 2020 at 1:13 PM Anand Jain <anand.jain@oracle.com> wrote:
> >
> >
> >
> > > 7) When we do the actual write of this stripe, because it's a partial
> > > stripe write
> > >     (we aren't writing to all the pages of all the stripes of the full
> > > stripe), we
> > >     need to read the remaining pages of stripe 2 (page indexes from 4 to 15) and
> > >     all the pages of stripe 1 from disk in order to compute the content for the
> > >     parity stripe. So we submit bios to read those pages from the corresponding
> > >     devices (we do this at raid56.c:raid56_rmw_stripe()).
> >
> >
> > > The problem is that we
> > >     assume whatever we read from the devices is valid -
> >
> >    Any idea why we have to assume here, shouldn't the csum / parent
> >    transit id verification fail at this stage?
> 
> I think we're not on the same page. Have you read the whole e-mail?
> 
> At that stage, or any other stage during a partial stripe write,
> there's no verification, that's the problem.
> The raid5/6 layer has no information about which other parts of a
> stripe may be allocated to an extent (which can be either metadata or
> data).
> 
> Getting such information and then doing the checks is expensive and
> complex. 

...and yet maybe still worth doing?  "Make it correct, then make it fast."

I did see Qu's proposal to use a parity mismatch detection to decide when
to pull out the heavy scrub gun.  It's clever, but I see that more as an
optimization than the right way forward: the correct behavior is *always*
to do the csum verification when reading a block, even if it's because we
are writing some adjacent block that is involved in a parity calculation.

We can offer "skip the csum check when the data and parity matches"
as an optional but slightly unsafe speedup.  If you are unlucky with
single-bit errors on multiple drives (e.g. they all have a firmware bug
that makes them all zero out the 54th byte in some sector) then you might
end up with a stripe that has matching parity but invalid SHA256 csums,
and maybe that becomes a security hole that only applies to btrfs raid5/6.
On the other hand, maybe you're expecting all of your errors to be random
and uncorrelated, and parity mismatch detection is good enough.

If we adopt the "do csum verification except when we know we can avoid
it" approach, there are other options where we know we can avoid the
extra verification.  We could have the allocator try to allocate full
RAID stripes so that we can skip the stripe-wide csum check because we
know we are writing all the data in the stripe.  Since we would have the
proper csum check to fall back on for correctness, the allocator can fall
back to partial RAID stripes when we run out of full ones, and we don't
get some of the worst parts of the "allocate only full stripes" approach.
We do still have write hole with any partial stripe updates, but that's
probably best solved separately.

> We do validate an extent from a higher level (not in
> raid56.c) when we read the extent (at btree_readpage_end_io_hook() and
> btree_read_extent_buffer_pages()), and then if something is wrong with
> it we attempt the recovery - in the case of raid56, by rebuilding the
> stripe based on the remaining stripes. But if a write into another
> extent of the same stripe happens before we attempt to read the
> corrupt extent, we end up not being able to recover the extent, and
> permanently corrupt destroy that possibility by overwriting the parity
> stripe with content that was computed based on a corrupt extent.
> 
> That's why I was asking for suggestions, because it's nor trivial to
> do it without having a significant impact on performance and
> complexity.
> 
> About why we don't do it, I suppose the original author of our raid5/6
> implementation never thought about that it could lead to a permanent
> corruption.
> 
> >
> >    There is raid1 test case [1] which is more consistent to reproduce.
> >      [1] https://patchwork.kernel.org/patch/11475417/
> >    looks like its result of avoiding update to the generation for nocsum
> >    file data modifications.
> 
> Sorry, I don't see what's the relation.
> The problem I'm exposing is exclusive to raid5/6, it's about partial
> stripes writes, raid1 is not stripped.
> Plus it's not about nodatacow/nodatacsum either, it affects both cow
> and nocow, and metadata as well.
> 
> Thanks.
> 
> >
> > Thanks, Anand
> >
> >
> > > in this case what we read
> > >     from device 3, to which stripe 2 is mapped, is invalid since in the degraded
> > >     mount we haven't written extent buffer 39043072 to it - so we get
> > > garbage from
> > >     that device (either a stale extent, a bunch of zeroes due to trim/discard or
> > >     anything completely random).
> > >
> > > Then we compute the content for the
> > > parity stripe
> > >     based on that invalid content we read from device 3 and write the
> > > parity stripe
> > >     (and the other two stripes) to disk;
> >
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
