Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CBF408233
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 01:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhILXIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 19:08:35 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43646 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbhILXIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 19:08:35 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E2E6EB7448D; Sun, 12 Sep 2021 19:07:19 -0400 (EDT)
Date:   Sun, 12 Sep 2021 19:07:19 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Sam Edwards <cfsworks@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
Message-ID: <20210912230719.GL29026@hungrycats.org>
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com>
 <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <20210911042414.GJ29026@hungrycats.org>
 <CAH5Ym4jNgs1iJufbmCDOS6N=k+YH4nZTSQ7j-MrM3mp8M0Yn2g@mail.gmail.com>
 <20210911165634.GK29026@hungrycats.org>
 <CAH5Ym4isja5hs73ibcACH5cm00=F43cG+m_sNtFjkJ_oRZJT1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4isja5hs73ibcACH5cm00=F43cG+m_sNtFjkJ_oRZJT1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 12, 2021 at 12:12:13AM -0600, Sam Edwards wrote:
> On Sat, Sep 11, 2021 at 10:56 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> > It's not one I've seen previously reported, but there's a huge variety
> > of SSD firmware in the field.
> 
> It seems to be a very newly released SSD. It's possible that the
> reason nobody else has reported issues with it yet is that nobody else
> who owns one of these has yet met the conditions for this problem to
> occur. All the more reason to figure this out, I say.
> 
> I've been working to verify what you've said previously (and to rule
> out any contrary hypotheses - like chunks momentarily having the wrong
> physical offset). One point I can't corroborate is:
> 
> > There are roughly 40 distinct block addresses affected in your check log,
> > clustered in two separate 256 MB blocks.
> 
> The only missing writes that I see are in a single 256 MiB cluster
> (belonging to chunk 1065173909504). What is the other 256 MiB cluster
> that you are seeing? 

Hex addresses from your parent transid verify failed messages:

	f80ad70000
	f80ad74000
	f80c11c000
	f80c6dc000
	f80c6e8000
	f80c704000
	f80dd04000
	f80e320000
	f80e3a4000
	f80e3cc000

	f8167c8000
	f8167e0000
	f818a68000
	f818a6c000
	f818a70000
	f818a74000
	f818a7c000
	f818a80000
	f818a84000
	f818a8c000

"leaf parent key incorrect" has a similar distribution.

There is less than 256MB distance from the first to the last, but they
occupy two separate 256MB-aligned regions (f800000000 and f810000000).
If there is dup metadata then these blocks occupy four separate 256MB
regions, as there is some space between duplicate regions (in logical
address space).

256MB is far too large for a plausible erase block size, 1GB is even
less likely.

> What shows that writes to that range went
> missing, too? (Or by "affected" do you only mean "involved in the
> damaged transactions in some way"?)

"parent transid verify failed" is btrfs for "there is a reference to a
block at this location, but the block was not written and a different
(usually older) block was found instead."  "leaf parent key incorrect"
is a synonym.  The named block is almost always a missing write.

I don't see any signs of more than one transaction being affected.
With 20 distinct pages of metadata lost we'd expect up to 60,000 items
with reference problems, but there are only about 9000 unique error
items.  If there was more damage to leaf pages, especially from other
transactions, I'd expect more unique errors.

> I do find it interesting that, of a few dozen missing writes, all of
> them are clustered together, while other writes in the same
> transactions appear to have had a perfect success rate. My expectation
> for drive cache failure would have been that *all* writes (during the
> incident) get the same probability of being dropped. All of the
> failures being grouped like that can only mean one thing... I just
> don't know what it is. :)

That's not how write caches work--they are not giant FIFO queues.

Write caches reorder writes in close temporal proximity (i.e. writes
that occurred close together in time rather than in space).  There is
necessarily reordering in the failure case--if there was no reordering,
in a strictly FIFO cache, there would be no btrfs errors because without
reordering the last persisted transaction would be completely persisted
with all its metadata intact (there may be later transactions that were
lost, but if none of their writes persisted then those transactions
didn't really happen).

The cache does not occupy all of the DRAM in the device--usually it is
only a handful of pages, because the firmware will drain the cache to
flash as quickly as possible.  btrfs quite often has to stop to read data
from disk during a transaction, giving the drive time to catch up flushing
out the cache.  This results in a small number of writes in flight.

So there might be e.g. writes to blocks A, B, C, D, E, F, barrier, G,
and those are reordered in write cache as A, D, E, F, G, B, C, and then
the last 2 writes are lost by a drive problem.  Writes to locations A,
D, E, F, and G are persisted (G might be the superblock update,
completing the transaction and updating root pointers to all the trees)
while writes to B and C are not (these are the "leaf parent key incorrect"
and "parent transid verify failed" errors, where a parent node in a tree
points to a block that does not contain the matching child).

Reordering like the above is allowed, but only if the drive can guarantee
results equivalent to the original ordering with the barrier constraint
(e.g. it has big capacitors or SLC write cache).  The drive can legally
write G earlier if and only if it can guarantee it will finish writing
all of A-F, even if power is lost, host sends a reset, or media fails.

> So, the prime suspect at this point is the SSD firmware. Once I have a
> little more information, I'll (try to) share what I find with the
> vendor. Ideally I'd like to narrow down which of 3 components of the
> firmware apparently contains the fault:
> 1. Write back cache: Most likely, although not certain at this point.
> If I turn off the write cache and the problem goes away, I'll know.

Disabling write cache is the most common workaround, and often successful
if the drive is still healthy.

> 2. NVMe command queues: Perhaps there is some race condition where 2
> writes submitted on different queues will, under some circumstances,
> cause one/both of the writes to be ignored.

That often happens to drives as they fail.  Firmware reboots due to a
bug in error handling code or hardware fault, and doesn't remember what
was in its write cache.

Also if there is a transport failure and the host resets the bus, the
drive firmware might have its write cache forcibly erased before being
able to write it.  The spec says that doesn't happen, but some vendors
are demonstrably unable to follow spec.

> 3. LBA mapper: Given the pattern of torn writes, it's possible that
> some LBAs were not updated to the new PBAs after some of the writes. I
> find this pretty unlikely for a handful of reasons (trying to write a
> non-erased block should result in an internal error, old PBA should be
> erased, ...)

That's an SSD-specific restatement of #1 (failure to persist data before
reporting successfully completed write to the host, and returning previous
versions of data on later reads of the same address).

SSDs don't necessarily erase old blocks immediately--a large, empty or
frequently discarded SSD might not erase old blocks for months.

All of the above fit into the general category of "drive drops some
writes, out of order, when some triggering failure occurs."  If you have
access to the drive's firmware on github, you could check out the code,
determine which bug is occurring, and send a pull request with the fix.
If you don't, usually the practical solution is to choose a different
drive vendor, unless you're ordering enough units to cause drive
manufacturer shareholders to panic when you stop.

Also you need to be _really_ sure it's the drive, and this information
casts some doubt on that theory:

> However, even if this is a firmware/hardware issue, I remain
> unconvinced that it's purely coincidence just how quickly this
> happened after the upgrade to 5.14.x. In addition to this corruption,
> there are the 2 incidents where the system became unresponsive under
> I/O load (and the second was purely reads from trying to image the
> SSD). Those problems didn't occur when booting a rescue USB with an
> older kernel. So some change which landed in 5.14.x may have changed
> the drive command pattern in some important way to trigger the SSD
> fault (esp, in the case of possibility #2 above). That gives me hope
> that, if nothing else, we may be able to add a device quirk to Linux
> and minimize future damage that way. :)

Yeah, if something horrible happened in the Linux 5.14 baremetal NVME
hardware drivers or PCIe subsystem in general, then it could produce
symptoms like these.  It wouldn't be the first time a regression in
other parts of Linux was detected by a flood of btrfs errors.

Device resets might trigger write cache losses and then all the above
"firmware" symptoms (but the firmware is not at fault, it is getting
disrupted by the host) (unless you are a stickler for the letter of the
spec that says write cache must be immune to host action).

Linux 5.14 btrfs on VMs seems OK.  I run tests continuously on new Linux
kernels to detect btrfs and lvm regressions early, and nothing like this
has happened on my humble fleet.  My test coverage is limited--it
won't detect a baremetal NVME transport issue, as that's handled by the
host kernel not the VM guest.

> Bayes calls out from beyond the grave and demands that, before I try
> any experiments, I first establish the base rate of these corruptions
> under current conditions. So that means rebuilding my filesystem from
> backups and continuing to use it exactly as I have been, prepared for
> this problem to happen again. Being prepared means stepping up my
> backup frequency, so I'll first set up a btrbk server that can accept
> hourly backups.

Sound methodology.

> Wish me luck,

Good luck!

> Sam
