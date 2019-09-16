Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658D7B4469
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfIPXFM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 16 Sep 2019 19:05:12 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48702 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390048AbfIPXFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 19:05:12 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8569742BE7D; Mon, 16 Sep 2019 19:05:11 -0400 (EDT)
Date:   Mon, 16 Sep 2019 19:05:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190916230511.GC24379@hungrycats.org>
References: <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913025832.Horde.Bwn_M-5buBYcgGbqhc_wDkU@server53.web-hosting.com>
 <20190913052520.Horde.TXpSDI4drVhkIzGxF7ZVMA8@server53.web-hosting.com>
 <20190914005931.GI22121@hungrycats.org>
 <20190913212849.Horde.PHJTyaXyvRA0Reaq2YtVdvS@server53.web-hosting.com>
 <20190914042859.GK22121@hungrycats.org>
 <20190915140547.Horde.DRsf7IY4-nawgP5QW2UiAFT@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190915140547.Horde.DRsf7IY4-nawgP5QW2UiAFT@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 15, 2019 at 02:05:47PM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > 3% of 45TB is 1.35TB...seems a little harsh.  Recall no extent can be
> > larger than 128MB, so we're talking about enough space for ten thousand
> > of defrag's worst-case output extents.  A limit based on absolute numbers
> > might make more sense, though the only way to really know what the limit is
> > on any given filesystem is to try to reach it.
> 
> Nah.
> 
> The free space minimum limit must, unfortunately, be based on absolute
> percentages. There is no better way. The problem is that, in order for
> defrag to work, it has to (partially) consolidate some of the free space, in
> order to produce a contiguous free area which will be the destination for
> defrag data.

One quirk of btrfs is that it has two levels of allocation:  it
divides disks into multi-GB block groups, then allocates extents in
the block groups.  Any unallocated space on the disks ("unallocated"
meaning "not allocated to a block group") is contiguous, so as long
as there is unallocated space, there are guaranteed to be contiguous
areas a minimum of 8 times the maximum extent to defrag into.  So 3%
free space on a big disk ("big" meaning "relative to the maximum extent
size") can mean a lot of contiguous space left, more than enough room
to defrag while moving each extent exactly once.

Not necessarily, of course:  if you fill all the way to 100%, there's no
unallocated space any more, and if you then delete 3% of it at random,
you have a severe fragmentation problem (97% of all the block groups are
occupied) and no space to fix it (no unallocated block groups available).

> In order to be able to produce this contiguous free space area, it is of
> utmost importance that there is sufficient free space left on the partition.
> Otherwise, this free space consolidation operation will take too much time
> (too much disk I/O). There is no good way around it the common cases of free
> space fragmentation.
> 
> If you reduce the free space minimum limit below 3%, you are likely to spend
> 2x more I/O in consolidating free space than what is needed to actually
> defrag the data. I mean, the defrag will still work, but I think that the
> slowdown is unacceptable.
> 
> I mean, the user should just free some space! The filesystems should not be
> left with less than 10% free space, that's simply bad management from the
> user's part, and the user should accept the consequences.

Well, yes, the performance of the allocator drops exponentially once
you go past 90% usage of the allocated block groups (there's no
optimization like a free-space btree with lengths as keys).
