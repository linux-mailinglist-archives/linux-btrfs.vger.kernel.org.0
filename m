Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760A0234FBB
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgHADkC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 23:40:02 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41766 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgHADkB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 23:40:01 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 55EBE78EB23; Fri, 31 Jul 2020 23:40:00 -0400 (EDT)
Date:   Fri, 31 Jul 2020 23:40:00 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Eric Wong <e@80x24.org>, linux-btrfs@vger.kernel.org
Subject: Re: raid1 with several old drives and a big new one
Message-ID: <20200801033959.GL5890@hungrycats.org>
References: <20200731001652.GA28434@dcvr>
 <20200731161307.GA31148@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731161307.GA31148@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 31, 2020 at 06:13:07PM +0200, Adam Borowski wrote:
> On Fri, Jul 31, 2020 at 12:16:52AM +0000, Eric Wong wrote:
> > Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> > a way I can ensure one raid1 copy of the data stays on the new
> > 6TB HDD?
> > 
> > I expect the 2TB HDDs to fail sooner than the 6TB HDD given
> > their age (>5 years).

It might be a good idea to run 'btrfs replace' on one of the two 2TB
disks instead of 'device add'.  That will move one copy of the data
very quickly to the new disk.  You then resize the new disk to 6TB (or
'max'), then add the 2TB disk back into the array with btrfs dev add.
This will leave you with 1 full 2TB disk, 1 empty 2TB disk, and a 6TB
disk with 2TB of data on it.

In that case you don't even need to balance--the empty 2TB drive will
fill up with BGs that contain one chunk from the 2TB drive and one
from 6TB, since the allocator will pick the two emptiest drives first.
Everything will be mirrored on the 6TB drive (probably, see below).

The variation in write load might also shift the date when the drives
eventually do fail, so they'll be less likely to fail at the same time.

> While there's no good way to do so in general, in your case, there's no way
> for any new block group to be allocated without the big disk.
> 
> Btrfs' allocation algorithm is: always pick the disk with most free space
> left.  Besides being simple, this guarantees optimally utilizing available
> space.

That is the theory; however, practice is a little different.

Sometimes btrfs just doesn't follow its own rules.  I've filled in
big raid1 arrays with lopsided disks like this, and ended up with one
block group out of every few thousand with a chunk from each of the
two smaller disks.  I guess it's a race condition, possibly triggered
by scrub or balance marking block groups readonly, but I've never fully
investigated.  When the larger disk is _exactly_ the same size as the two
smaller disks, having one block group in the wrong place can be annoying,
as it reduces capacity.

If two disks fail, btrfs will count the number of failing disks and say
"nope, can't mount this degraded raid1, sorry" if even one block group
in the filesystem contains both failing disks.

In any case, the behavior isn't strictly guaranteed here--btrfs *can*
allocate a block group across the two smaller disks, even though it
normally would not; therefore, there's a risk that it might do so
unexpectedly.

Contrast with combining the two 2TB disks (e.g. with mdadm-raid0 or
linear, or LVM), where btrfs is presented with exactly two devices and
has exactly one option to allocate mirror devices on them.

> And, for 2+2+2+6, no scheme that doesn't waste space could possibly place
> raid1 copies without having one on the biggest disk.
> 
> Thus, all you need is to balance once.
> 
> > The devid balance filter only affects data which already exists
> > on the device, so that isn't suitable for this, right?
> 
> Yeah, balance affects existing data, but doesn't have a lingering effect on
> new allocations.
> 
> Meow!
> -- 
> ⢀⣴⠾⠻⢶⣦⠀
> ⣾⠁⢠⠒⠀⣿⡁
> ⢿⡄⠘⠷⠚⠋⠀ It's time to migrate your Imaginary Protocol from version 4i to 6i.
> ⠈⠳⣄⠀⠀⠀⠀
