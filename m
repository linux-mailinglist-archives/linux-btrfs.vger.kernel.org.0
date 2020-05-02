Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFC1C22B9
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 06:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgEBES1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 00:18:27 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47060 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgEBES1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 00:18:27 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A934E69F922; Sat,  2 May 2020 00:18:26 -0400 (EDT)
Date:   Sat, 2 May 2020 00:18:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Alexandru Dordea <alex@dordea.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502041826.GH10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
 <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
 <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 12:29:50AM -0700, Phil Karn wrote:
> On 4/30/20 23:05, Alexandru Dordea wrote:
> > Don’t get me wrong, the single 100% CPU is only during balance process.
> > By running "btrfs device delete missing /storage”there is no impact on CPU/RAM. I do have 64GB DDR4 ECC but there is no more of 3GB ram usage.
> 3GB used for what, does that include the system buffer cache?
> >
> > I can see that @Chris Murphy mention that disabling the cache will impact performance. Did you tried that? 
> > On my devices I do have cache enabled and till now this is the only thing that I didn't tried :)
> 
> 
> It didn't seem to make an obvious difference, which surprised me a
> little since the I/O seems so random. Maybe btrfs is already sticking a
> lot of fences (barriers) into the write stream so the drive can't do
> much reordering anyway?

btrfs can send gigabytes of metadata IO per minute to a drive, enough to
overwhelm even the largest device write caches.  So even if you use 100%
of a 256MB drive's on-board RAM as write cache, the following gigabytes of
a large metadata update won't get much benefit from caching.  The drive
will be stuck a quarter gigabyte behind the host, trying to catch up
all the time.

Also, in large delete operations, half of the IOs are random _reads_,
which can't be optimized by write caching.  The writes are mostly
sequential, so they take less IO time.  So, say, 1% of the IO time
is made 80% faster by write caching, for a net benefit of 0.8% (not real
numbers).  Write caching helps fsync() performance and not much else.

A writeback SSD cache can have a significant beneficial effect on latency
until it gets full, but if it's not big enough to hold the metadata then
it won't be very helpful, in the worst case it will make btrfs slower.

> I've always left write caching enabled in my drives since my system is
> plugged into reliable power. I assume the only reason to turn it off is
> to reduce the chance of filesystem corruption in case I have to force
> the machine to reboot while the operation is still going.

The big surprise for write caches is what happens when the drive
gets a UNC sector.  Some drive firmwares work properly under normal
and power-loss conditions, but immediately drop the contents of the
write cache when they see an unreadable block.  This turns an otherwise
completely survivable error--a small number of consecutive bad sectors
on a single-disk filesystem---into a btrfs damaged beyond repair.

In this event, metadata writes will be dropped in both copies of dup
metadata, but the error is not reported to btrfs by the drive firmware
because it happens after the drive has reported successful completion of
the relevant flush command to the host.  Write caching in drives without
command queueing assumes that the drive will be able to complete the flush
command before a power failure interrupts it.  Usually firmware doesn't
take sector read retries or external vibration events into account, but
those events also prevent the drive from implementing any further write
commands from the host, so write ordering is preserved.  In the UNC case,
the firmware drops the write cache and also keeps accepting new write
commands, which is a bug--it should do at most one of those two things.
The result is unrecoverable metadata loss on btrfs.

Reliable power and crash avoidance won't help in this case--the filesystem
will die while it's still mounted.  If you find out the hard way that
you have a drive with firmware that does this, the only recourse is to
turn off write caching (and make sure it stays off), mkfs, and start
restoring backups.

> Down to only 1.99 TB now! Wow!
> 
> --Phil
> 
> 
> 
