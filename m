Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D033484971
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiADUtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 15:49:24 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:42626 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233308AbiADUtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 15:49:24 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 4053B13A05C; Tue,  4 Jan 2022 15:49:23 -0500 (EST)
Date:   Tue, 4 Jan 2022 15:49:23 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: "hardware-assisted zeroing"
Message-ID: <YdSy09eCHqU5sgez@hungrycats.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 05:50:47AM -0500, Eric Levy wrote:
> On Mon, 2022-01-03 at 19:51 +0800, Qu Wenruo wrote:
> 
> > The filesystem (normally) doesn't maintain such info, what a
> > filesystem
> > really care is the unused/used space.
> > 
> > For fstrim case, the filesystem will issue such discard comand to
> > most
> > (if not all) unused space.
> > 
> > And one can call fstrim multiple times to do the same work again and
> > again, the filesystem won't really care.
> > (even the operation can be very time consuming)
> > 
> > The special thing in btrfs is, there is a cache to record which
> > blocks
> > have been trimmed. (only in memory, thus after unmount, such cache is
> > lost, and on next mount will need to be rebuilt)
> > 
> > This is to reduce the trim workload with recent async-discard
> > optimization.
> 
> So in the general case (i.e. no session cache), the trim operation
> scans all the allocation structures, to process all non-allocated
> space?
> 
> > > Why is the
> > > command not sent instantly, as soon as the space is freed by the
> > > file
> > > system?
> > 
> > If you use discard mount option, then most filesystems will send the
> > discard command to the underlying device when some space is freed.
> > 
> > But please keep in mind that, how such discard command gets handled
> > is
> > hardware/storage stack dependent.
> > 
> > Some disk firmware may choose to do discard synchronously, which can
> > hugely slow down other operations.
> > (That's why btrfs has async-discard optimization, and also why fstrim
> > is
> > preferred, to avoid unexpected slow down).
> 
> Yes, but of course as I have used "instantly", I meant, not necessarily
> synchronously, but simply near in time.
> 
> The trim operation is not avoiding bottlenecks, even if it is non-
> blocking, because it operates at the level of the entire file system,
> in a single operation. If Btrfs is able to process discard operations
> asynchronously, then mounting with the discard option seems preferable,
> as it requires no redundant work, adds no serious delay until until the
> calls are made, and depends on no activity (not even automatic
> activity) from the admin.
> 
> I fail to see a reason for preferring trim over discard.

Discard isn't free, and it can cost more than it gives back.

The gain from discard can be close to zero if you're overwriting the
same blocks over and over again (e.g. as btrfs does in metadata pages).
The SSD will keep recycling the blocks without hints from outside to help.
It depends on workload, but on many use cases 60-90% of the discards
btrfs will issue with the mount option are not necessary.  For the rest,
a fstrim every few days is sufficient.

The cost of discard can be significantly higher than zero.  Discard
requires time on the bus to send the trim command, which is a significant
hit for SATA (about the same as a short flushed write).  Popular drive
firmwares can't queue the discard command, which is a significant hit for
IO latency as the IO queue has to be brought to a full stop, the discard
command has to be sent and run, and the IO queue has to be started back
up again.  Before the 'discard=async' option was implemented, 'discard'
was unusably slow on many SSD models, some of them popular.

Cheap SSD devices wear out faster when issued a lot of discards mixed
with small writes, as they lack the specialized hardware and firmware
necessary to make discards low-wear operations.  The same flash component
is used for both FTL persistence (where discards cause wear) and user
data (where writes cause wear), so interleaved short writes and discards
cause double the wear compared to the same short writes without discards.
The fstrim man page advises not running trim more than once a week to
avoid prematurely aging SSDs in this category, while the discard mount
option is equivalent to running fstrim 2000-3000 times a day.

Discard has other side-effects in btrfs as well.  While a block group
is undergoing discard, it cannot be modified, which will force btrfs
to spread allocations out across more of the logical address space.
That can cause performance issues with fragmentation later on (more CPU
usage, more metadata fan-out for extents of the same file).  The discard
mount option can affect performance benchmarks in either direction, even
if the underlying storage is RAM that doesn't implement discard at all.

You'll need to benchmark this with your hardware and your workload to
find out if trim is better than discard or the other way around for you,
but don't be surprised by either result.
