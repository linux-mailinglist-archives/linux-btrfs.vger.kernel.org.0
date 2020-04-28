Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321E91BC1E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgD1OwC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 28 Apr 2020 10:52:02 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45550 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgD1OwB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 10:52:01 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1E7B2695CA3; Tue, 28 Apr 2020 10:51:46 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:51:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Balance loops: what we know so far
Message-ID: <20200428145145.GB10796@hungrycats.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 05:54:21PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/4/28 下午12:55, Zygo Blaxell wrote:
> > On Mon, Apr 27, 2020 at 03:07:29PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/4/12 上午5:14, Zygo Blaxell wrote:
> >>> Since 5.1, btrfs has been prone to getting stuck in semi-infinite loops
> >>> in balance and device shrink/remove:
> >>>
> >>> 	[Sat Apr 11 16:59:32 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
> >>> 	[Sat Apr 11 16:59:33 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
> >>> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
> >>> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
> >>> 	[Sat Apr 11 16:59:35 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
> >>>
> >>> This is a block group while it's looping, as seen by python-btrfs:
> >>>
> >>> 	# share/python-btrfs/examples/show_block_group_contents.py 1934913175552 /media/testfs/
> >>> 	block group vaddr 1934913175552 length 1073741824 flags DATA used 939167744 used_pct 87
> [...]
> >>>
> >>> All of the extent data backrefs are removed by the balance, but the
> >>> loop keeps trying to get rid of the shared data backrefs.  It has
> >>> no effect on them, but keeps trying anyway.
> >>
> >> I guess this shows a pretty good clue.
> >>
> >> I was always thinking about the reloc tree, but in your case, it's data
> >> reloc tree owning them.
> > 
> > In that case, yes.  Metadata balances loop too, in the "move data extents"
> > stage while data balances loop in the "update data pointers" stage.
> 
> Would you please take an image dump of the fs when runaway balance happened?
> 
> Both metadata and data block group loop would greatly help.

There's two problems with this:

	1) my smallest test filesystems have 29GB of metadata,

	2) the problem is not reproducible with an image.

I've tried using VM snapshots to put a filesystem into a reproducible
looping state.  A block group that loops on one boot doesn't repeatably
loop on another boot from the same initial state; however, once a
booted system starts looping, it continues to loop even if the balance
is cancelled, and I restart balance on the same block group or other
random block groups.

I have production filesystems with tens of thousands of block groups
and almost all of them loop (as I said before, I cannot complete any
RAID reshapes with 5.1+ kernels).  They can't _all_ be bad.

Cancelling a balance (usually) doesn't recover.  Rebooting does.
The change that triggered this changes the order of operations in
the kernel.  That smells like a runtime thing to me.

> >> In that case, data reloc tree is only cleaned up at the end of
> >> btrfs_relocate_block_group().
> >>
> >> Thus it is never cleaned up until we exit the balance loop.
> >>
> >> I'm not sure why this is happening only after I extended the lifespan of
> >> reloc tree (not data reloc tree).
> > 
> > I have been poking around with printk to trace what it's doing in the
> > looping and non-looping cases.  It seems to be very similar up to
> > calling merge_reloc_root, merge_reloc_roots, unset_reloc_control,
> > btrfs_block_rsv_release, btrfs_commit_transaction, clean_dirty_subvols,
> > btrfs_free_block_rsv.  In the looping cases, everything up to those
> > functions seems the same on every loop except the first one.
> > 
> > In the non-looping cases, those functions do something different than
> > the looping cases:  the extents disappear in the next loop, and the
> > balance finishes.
> > 
> > I haven't figured out _what_ is different yet.  I need more cycles to
> > look at it.
> > 
> > Your extend-the-lifespan-of-reloc-tree patch moves one of the
> > functions--clean_dirty_subvols (or btrfs_drop_snapshot)--to a different
> > place in the call sequence.  It was in merge_reloc_roots before the
> > transaction commit, now it's in relocate_block_group after transaction
> > commit.  My guess is that the problem lies somewhere in how the behavior
> > of these functions has been changed by calling them in a different
> > sequence.
> > 
> >> But anyway, would you like to give a try of the following patch?
> >> https://patchwork.kernel.org/patch/11511241/
> > 
> > I'm not sure how this patch could work.  We are hitting the found_extents
> > counter every time through the loop.  It's returning thousands of extents
> > each time.
> > 
> >> It should make us exit the the balance so long as we have no extra
> >> extent to relocate.
> > 
> > The problem is not that we have no extents to relocate.  The problem is
> > that we don't successfully get rid of the extents we do find, so we keep
> > finding them over and over again.
> 
> That's very strange.
> 
> As you can see, for relocate_block_group(), it will cleanup reloc trees.
> 
> This means either we have reloc trees in use and not cleaned up, or some
> tracing mechanism is not work properly.

Can you point out where in the kernel that happens?  If we throw some
printks at it we might see something.

> Anyway, if image dump with the dead looping block group specified, it
> would provide good hint to this long problem.
> 
> Thanks,
> Qu
> 
> > 
> > In testing, the patch has no effect:
> > 
> > 	[Mon Apr 27 23:36:15 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:21 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:27 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:32 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:38 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:44 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:50 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:36:56 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:37:01 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:37:07 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:37:13 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:37:19 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:37:24 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 	[Mon Apr 27 23:37:30 2020] BTRFS info (device dm-0): found 4800 extents, stage: update data pointers
> > 
> > The above is the tail end of 3320 loops on a single block group.
> > 
> > I switched to a metadata block group and it's on the 9th loop:
> > 
> > 	# btrfs balance start -mconvert=raid1 /media/testfs/
> > 	[Tue Apr 28 00:09:47 2020] BTRFS info (device dm-0): found 34977 extents, stage: move data extents
> > 	[Tue Apr 28 00:12:24 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:18:46 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:23:24 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:25:54 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:28:17 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:30:35 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:32:45 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 	[Tue Apr 28 00:37:01 2020] BTRFS info (device dm-0): found 26475 extents, stage: move data extents
> > 
> > 
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> This is "semi-infinite" because it is possible for the balance to
> >>> terminate if something removes those 29 extents (e.g. by looking up the
> >>> extent vaddrs with 'btrfs ins log' then feeding the references to 'btrfs
> >>> fi defrag' will reduce the number of inline shared data backref objects.
> >>> When it's reduced all the way to zero, balance starts up again, usually
> >>> promptly getting stuck on the very next block group.  If the _only_
> >>> thing running on the filesystem is balance, it will not stop looping.
> >>>
> >>> Bisection points to commit d2311e698578 "btrfs: relocation: Delay reloc
> >>> tree deletion after merge_reloc_roots" as the first commit where the
> >>> balance loops can be reproduced.
> >>>
> >>> I tested with commit 59b2c371052c "btrfs: check commit root generation
> >>> in should_ignore_root" as well as the rest of misc-next, but the balance
> >>> loops are still easier to reproduce than to avoid.
> >>>
> >>> Once it starts happening on a filesystem, it seems to happen very
> >>> frequently.  It is not possible to reshape a RAID array of more than a
> >>> few hundred GB on kernels after 5.0.  I can get maybe 50-100 block groups
> >>> completed in a resize or balance after a fresh boot, then balance gets
> >>> stuck in loops after that.  With the fast balance cancel patches it's
> >>> possibly to recover from the loop, but futile, since the next balance
> >>> will almost always also loop, even if it is passed a different block
> >>> group.  I've had to downgrade to 5.0 or 4.19 to complete any RAID
> >>> reshaping work.
> >>>
> >>
> > 
> > 
> > 
> 



