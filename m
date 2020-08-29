Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9472563BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 02:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH2Aml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 20:42:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56798 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgH2Aml (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 20:42:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C08191F66E;
        Sat, 29 Aug 2020 00:42:40 +0000 (UTC)
Date:   Sat, 29 Aug 2020 00:42:40 +0000
From:   Eric Wong <e@80x24.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Subject: Re: adding new devices to degraded raid1
Message-ID: <20200829004240.GA32462@dcvr>
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
 <20200828003037.GU5890@hungrycats.org>
 <20200828023412.GA308@dcvr>
 <20200828043627.GE8346@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828043627.GE8346@hungrycats.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> On Fri, Aug 28, 2020 at 02:34:12AM +0000, Eric Wong wrote:
> > Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > > Note that add/remove is orders of magnitude slower than replace.
> > > Replace might take hours or even a day or two on a huge spinning drive.
> > > Add/remove might take _months_, though if you have 8-year-old disks
> > > then it's probably a few days, weeks at most.
> > 
> > Btw, any explanation or profiling done on why remove is so much
> > slower than replace?  Especially since btrfs raid1 ought to be
> > fairly mature at this point (and I run recent stable kernels).
> 
> They do different things.
> 
> Replace just computes the contents of the filesystem the same way scrub
> does:  except for the occasional metadata seek, it runs at wire speeds
> because it reads blocks in order from one disk and writes in order on
> the other disk, 99.999% of the time.

Thanks for the explanations.  I'll heed your note down thread
about doing a partial resize followed by a replace when
possible.

> Remove makes a copy of every extent, updates every reference to the
> extent, then deletes the original extents.  Very seek-heavy--including
> seeks between reads and writes on the same drive--and the work is roughly
> proportional to the number of reflinks, so dedupe and snapshots push
> the cost up.  About the only advantage of remove (and balance) is that
> it consists of 95% existing btrfs read and write code, and it can handle
> any relocation that does not require changing the size or content of an
> extent (including all possible conversions).

Does that mean remove speed would be closer to replace on good SSDs?

> Arguably this isn't necessary.  Remove could copy a complete block group,
> the same way replace does but to a different offset on each drive, and
> simply update the chunk tree with the new location of the block group
> at the end.  Trouble is, nobody's implemented this approach in btrfs yet.
> It would be a whole new code path with its very own new bugs to fix.

Ah, it seems like a ton of work for a use case that mainly
affects hobbyists.  I won't hold my breath for it.

> > Converting a single drive to raid1 was not slow at all, either.
> > RAID 1 ought to be straightforward if there's plenty of free
> > space, one would think...
> 
> Depends on the disk size, performance, and structure (how big the extents
> are and how many references).  Also, "slow" is relative:  100x 2 minutes
> is not such a long time.  100x 20 hours is.

It was a new, quickly filled FS; so probably unfragmented.
I remember it seemed reasonable given the HW it was on.

> > 1) full "git gc" (I have a fair amount of git repos)
> >    Maybe setting pack.compression=0 will even help dedupe
> >    similar repos (but they'll be no fun to serve over network)
> 
> Git pack doesn't do 4K block alignment, which limits filesystem-level
> dedupe opportunities.  Git repos are strange:  large ones are full of
> duplicate blocks, but only 3 or 4 at a time.  By the time a big pack file
> has been cut up into extents that can be deduped, we've burned a gigabyte
> of IO, created 60 new extents out of 8, and might save 300K of space.

Heh.  I'll just let git do its thing independently of btrfs.
btrfs checksumming is great for ref storage, at least :>

> If you have a lot of related git repos, '.git/objects/info/alternates'
> is much more efficient than dedupe.  Set up a repo that pulls refs/*
> to different remotes from all the other repos on the filesystem, and
> set all the other repos' alternates to point to the central repo.
> You'll only have each git object once on the filesystem after git gc.
> Aaaand you'll also have various issues with git auto-gc occasionally
> eating your reflogs.  So maybe this is not for everyone.

Yes, I've been using alternates with a mega repo for many years.
I actually have all the remote fetch+url lines duplicated in the
mega repo config for GC safety.  It's a little more network
traffic, but works with overwritten/throwaway branches in
satellite repos.

<snip> will be sticking to FLAC as-is.

> VM image files compress and dedupe well.  Better than xz if you
> have more than 2 or 3 big ones, but not as good as zpaq (which
> has its own deduper built-in, and it's more flexible than btrfs).

Ah, it's a shame I needed to disable CoW on VM images to get
acceptable performance, though.  I'm using `bup' for backing
up VMs and its a nice savings.

> > 3) is this also something defrag can help with?
> 
> Not really.  defrag can make the balance run faster, but defrag will
> require almost the same amount of IO as the balance does.  If you've
> already had to remove a disk, it's too late for defrag--it's something you
> have to maintain over time so that it's already done before a disk fails.

Alright, I'll make a note to keep things defragmented and avoid
relying too much on reflinks.
