Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775E52EE82A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 23:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbhAGWMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jan 2021 17:12:33 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46030 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAGWMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jan 2021 17:12:32 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E577892CA6D; Thu,  7 Jan 2021 17:11:51 -0500 (EST)
Date:   Thu, 7 Jan 2021 17:11:51 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Cedric.dewijs@eclipso.eu
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
Message-ID: <20210107221151.GY31381@hungrycats.org>
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
 <8af92960a09701579b6bcbb9b51489cc@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af92960a09701579b6bcbb9b51489cc@mail.eclipso.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 05, 2021 at 07:19:14PM +0100,   wrote:
> >> I was expecting btrfs to do almost all reads from the fast SSD, as both
> the data and the metadata is on that drive, so the slow hdd is only really
> needed when there's a bitflip on the SSD, and the data has to be reconstructed.
> 
> > IIRC there will be some read policy feature to do that, but not yet
> > merged, and even merged, you still need to manually specify the
> > priority, as there is no way for btrfs to know which driver is faster
> > (except the non-rotational bit, which is not reliable at all).
> 
> Manually specifying the priority drive would be a big step in the
> right direction. Maybe btrfs could get a routine that benchmarks
> the sequential and random read and write speed of the drives at (for
> instance) mount time, or triggered by an administrator? This could lead
> to misleading results if btrfs doesn't get the whole drive to itself.
>
>
> >> Writing has to be done to both drives of course, but I don't expect
> slowdowns from that, as the system RAM should cache that.
> 
> >Write can still slow down the system even you have tons of memory.
> >Operations like fsync() or sync() will still wait for the writeback,
> >thus in your case, it will also be slowed by the HDD no matter what.
> 
> >In fact, in real world desktop, most of the writes are from sometimes
> >unnecessary fsync().
> 
> >To get rid of such slow down, you have to go dangerous by disabling
> >barrier, which is never a safe idea.
> 
> I suggest a middle ground, where btrfs returns from fsync when one of
> the copies (instead of all the copies) of the data has been written
> completely to disk. This poses a small data risk, as this creates
> moments that there's only one copy of the data on disk, while the
> software above btrfs thinks all data is written on two disks. one
> problem I see if the server is told to shut down while there's a big
> backlog of data to be written to the slow drive, while the big drive
> is already done. Then the server could cut the power while the slow
> drive is still being written.

The tricky thing here is that kernel memory management for the filesystem
is tied to transaction commits.  During a commit we have to finish the
flush to _every_ disk before any more writes can proceed, because the
transaction is holding locks that prevent memory from being modified or
freed until all the writes we are going to do are done.

If you have _short_ bursts of writes, you could put the spinning disk
behind a dedicated block-layer write-barrier-preserving RAM cache device.
btrfs would dump its writes into this cache and be able to complete
transaction commit, reducing latency as long as the write cache isn't
full (at that point writes must block).  btrfs could be modified to
implement such a cache layer itself, but the gains would be modest
compared to having an external block device do it (it saves some CPU
copies, but the worst-case memory requirement is the same) and in the
best case the data loss risks are identical.

As long as the block-layer cache strictly preserves write order barriers,
you can recover from most crashes by doing a btrfs scrub with both
disks online--the filesystem would behave as if the spinning disk was
just really unreliable and corrupting data a lot.

The crashes you can't recover from are csum collisions, where old and
new data have the same csum and you can't tell whether you have current
or stale data on the spinning disk.  You'll have silently corrupted data
at the hash collision rate.  If your crashes are infrequent enough you
can probably get away with this for a long time, or you can use blake2b
or sha256 csums which make collisions effectively impossible.

If the SSD dies and you only have the spinning disk left, the filesystem
will appear to roll back in time some number of transactions, but that
only happens when the SSD fails, so it might be an event rare enough to
be tolerable for some use cases.

If there is a crash which prevents some writes from reaching the spinning
disk, and after the crash, the SSD fails before a scrub can be completed,
then the filesystem on the spinning disk will not be usable.  The spinning
disk will have a discontiguous metadata write history and there is no
longer an intact copy on the SSD to recover from, so the filesystem will
have to be rebuilt by brute force scan of the surviving metadata leaf
pages (i.e. btrfs check --repair --init-extent-tree, with no guarantee
of success).

lvmcache(7) documents something called "dm-writecache" which would
theoretically provide the required write stream caching functionality,
but I've never seen it work.

If you have continuous writes then this idea doesn't work--latency will
degrade to at _least_ as slow as the spinning disk once the cache fills
up, since it's not allowed to elide any writes in the stream.

Alternatively, btrfs could be modified to implement transaction pipelining
that might be smart enough to optimize redundant writes away (i.e. don't
bother writing out a file to the spinner that is already deleted on the
SSD).  That's not a trivial change, though--better to think of it as
writing a new filesystem with a btrfs-compatible on-disk format, than
as an extension of the current filesystem code.

> i think this setting should be given to the system administrator,
> it's not a good idea to just blindly enable this behavior.

Definitely not a good idea to do it blindly.  There are novel failure
modes leading to full filesystem loss in this configuration.

> >> Is there a way to tell btrfs to leave the slow hdd alone, and to
> prioritize the SSD?
> 
> > Not in upstream kernel for now.
> 
> > Thus I guess you need something like bcache to do this.
> 
> Agreed. However, one of the problems of bcache, it that it can't use 2 SSD's in mirrored mode to form a writeback cache in front of many spindles, so this structure is impossible:
> +-----------------------------------------------------------+--------------+--------------+
> |                               btrfs raid 1 (2 copies) /mnt                              |
> +--------------+--------------+--------------+--------------+--------------+--------------+
> | /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 | /dev/bcache4 | /dev/bcache5 |
> +--------------+--------------+--------------+--------------+--------------+--------------+
> |                          Write Cache (2xSSD in raid 1, mirrored)                        |
> |                                 /dev/sda2 and /dev/sda3                                 |
> +--------------+--------------+--------------+--------------+--------------+--------------+
> | Data         | Data         | Data         | Data         | Data         | Data         |
> | /dev/sda9    | /dev/sda10   | /dev/sda11   | /dev/sda12   | /dev/sda13   | /dev/sda14   |
> +--------------+--------------+--------------+--------------+--------------+--------------+
> 
> In order to get a system that has no data loss if a drive fails,  the user either has to live with only a read cache, or the user has to put a separate writeback cache in front of each spindle like this:
> +-----------------------------------------------------------+
> |                btrfs raid 1 (2 copies) /mnt               |
> +--------------+--------------+--------------+--------------+
> | /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 |
> +--------------+--------------+--------------+--------------+
> | Write Cache  | Write Cache  | Write Cache  | Write Cache  |
> |(Flash Drive) |(Flash Drive) |(Flash Drive) |(Flash Drive) |
> | /dev/sda5    | /dev/sda6    | /dev/sda7    | /dev/sda8    |
> +--------------+--------------+--------------+--------------+
> | Data         | Data         | Data         | Data         |
> | /dev/sda9    | /dev/sda10   | /dev/sda11   | /dev/sda12   |
> +--------------+--------------+--------------+--------------+
> 
> In the mainline kernel is's impossible to put a bcache on top of a bcache, so a user does not have the option to have 4 small write caches below one fast, big read cache like this:
> +-----------------------------------------------------------+
> |                btrfs raid 1 (2 copies) /mnt               |
> +--------------+--------------+--------------+--------------+
> | /dev/bcache4 | /dev/bcache5 | /dev/bcache6 | /dev/bcache7 |
> +--------------+--------------+--------------++-------------+
> |                      Read Cache (SSD)                     |
> |                        /dev/sda4                          |
> +--------------+--------------+--------------+--------------+
> | /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 |
> +--------------+--------------+--------------+--------------+
> | Write Cache  | Write Cache  | Write Cache  | Write Cache  |
> |(Flash Drive) |(Flash Drive) |(Flash Drive) |(Flash Drive) |
> | /dev/sda5    | /dev/sda6    | /dev/sda7    | /dev/sda8    |
> +--------------+--------------+--------------+--------------+
> | Data         | Data         | Data         | Data         |
> | /dev/sda9    | /dev/sda10   | /dev/sda11   | /dev/sda12   |
> +--------------+--------------+--------------+--------------+
> 
> >Thanks,
> >Qu
> 
> Thank you,
> Cedric
> 
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 
