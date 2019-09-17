Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B275B46DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 07:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfIQFa5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 17 Sep 2019 01:30:57 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38572 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730407AbfIQFa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 01:30:56 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A0AF042CA47; Tue, 17 Sep 2019 01:30:55 -0400 (EDT)
Date:   Tue, 17 Sep 2019 01:30:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190917053055.GG24379@hungrycats.org>
References: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
 <20190917004916.GD24379@hungrycats.org>
 <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 10:30:39PM -0400, General Zed wrote:
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > and I think that's impossible so I start from designs
> > that make forward progress with a fixed allocation of resources.
> 
> Well, that's not useless, but it's kind of meh. Waste of time. Solve the
> problem like a real man! Shoot with thermonuclear weapons only!

I have thermonuclear weapons:  the metadata trees in my filesystems.  ;)

> > > So I think you should all inform yourself a little better about various
> > > defrag algorithms and solutions that exist. Apparently, you all lost the
> > > sight of the big picture. You can't see the wood from the trees.
> > 
> > I can see the woods, but any solution that starts with "enumerate all
> > the trees" will be met with extreme skepticism, unless it can do that
> > enumeration incrementally.
> 
> I think that I'm close to a solution that only needs to scan the free-space
> tree in the entirety at start. All other trees can be only partially
> scanned. I mean, at start. As the defrag progresses, it will go through all
> the trees (except in case of defragging only a part of the partition). If a
> partition is to be only partially defragged, then the trees do not need to
> be red in entirety. Only the free space tree needs to be red in entirety at
> start (and the virtual-physical address translation trees, which are small,
> I guess).

I doubt that on a 50TB filesystem you need to read the whole tree...are
you going to globally optimize 50TB at once?  That will take a while.
Start with a 100GB sliding window, maybe.

> > This is fairly common on btrfs:  the btrfs words don't mean the same as
> > other words, causing confusion.  How many copies are there in a btrfs
> > 4-disk raid1 array?
> 
> 2 copies of everything, except the superblock which has 2-6 copies.

Good, you can enter the clubhouse.  A lot of new btrfs users are surprised
it's less than 4.

> > > > > This is sovled simply by always running defrag before dedupe.
> > > > Defrag and dedupe in separate passes is nonsense on btrfs.
> > > Defrag can be run without dedupe.
> > Yes, but if you're planning to run both on the same filesystem, they
> > had better be aware of each other.
> 
> On-demand defrag doesn't need to be aware of on-demand dedupe. Or, only in
> the sense that dedupe should be shut down while defrag is running.
> 
> Perhaps you were referring to an on-the-fly dedupe. In that case, yes.

My dedupe runs continuously (well, polling with incremental scan).
It doesn't shut down.

> > > Now, how to organize dedupe? I didn't think about it yet. I'll leave it to
> > > you, but it seems to me that defrag should be involved there. And, my defrag
> > > solution would help there very, very much.
> > 
> > I can't see defrag in isolation as anything but counterproductive to
> > dedupe (and vice versa).
> 
> Share-preserving defrag can't be harmful to dedupe.

Sure it can.  Dedupe needs to split extents by content, and btrfs only
supports that by copying.  If defrag is making new extents bigger before
dedupe gets to them, there is more work for dedupe when it needs to make
extents smaller again.
 
> I would suggest one of the two following simple solutions:
>    a) the on-demand defrag should be run BEFORE AND AFTER the on-demand
> dedupe.
> or b) the on-demand defrag should be run BEFORE the on-demand dedupe, and
> on-demand dedupe uses defrag functionality to defrag while dedupe is in
> progress.
> 
> So I guess you were thinking about the solution b) all the time when you
> said that dedupe and defrag need to be related.

Well, both would be running continuously in the same process, so
they would negotiate with each other as required.  Dedupe runs first
on new extents to create a plan for increasing extent sharing, then
defrag creates a plan for sufficient logical/physical contiguity of
those extents after dedupe has cut them into content-aligned pieces.
Extents that are entirely duplicate simply disappear and do not form
part of the defrag workload (at least until it is time to defragment
free space...).  Both plans are combined and optimized, then the final
data relocation command sequence is sent to the filesystem.

> > > > Extent splitting in-place is not possible on btrfs, so extent boundary
> > > > changes necessarily involve data copies.  Reference counting is done
> > > > by extent in btrfs, so it is only possible to free complete extents.
> > > 
> > > Great, there is reference counting in btrfs. That helps. Good design.
> > 
> > Well, I say "reference counting" because I'm simplifying for an audience
> > that does not yet all know the low-level details.  The counter, such as
> > it is, gives values "zero" or "more than zero."  You never know exactly
> > how many references there are without doing the work to enumerate them.
> > The "is extent unique" function in btrfs runs the enumeration loop until
> > the second reference is found or the supply of references is exhausted,
> > whichever comes first.  It's a tradeoff to make snapshots fast.
> 
> Well, that's a disappointment.
> 
> > When a reference is created to a new extent, it refers to the entire
> > extent.  References can refer to parts of extents (the reference has an
> > offset and length field), so when an extent is partially overwritten, the
> > extent is not modified.  Only the reference is modified, to make it refer
> > to a subset of the extent (references in other snapshots are not changed,
> > and the extent data itself is immutable).  This makes POSIX fast, but it
> > creates some headaches related to garbage collection, dedupe, defrag, etc.
> 
> Ok, got it. Thaks.
> 
> 
> 
> 
